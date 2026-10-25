import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../analytics/analytics.dart';

/// The one-time "remove ads" purchase. Owning it hides every ad and unlocks
/// all extras that are otherwise unlocked by watching a rewarded ad.
///
/// Create a one-time product with ID [productId] in Play Console →
/// Monetize → Products → In-app products (and the same ID in App Store
/// Connect for iOS).
class PremiumController extends ChangeNotifier {
  PremiumController._();

  static final PremiumController instance = PremiumController._();

  static const productId = 'remove_ads';
  static const _ownedKey = 'premium_remove_ads';

  bool _isPremium = false;
  bool _storeAvailable = false;
  bool _purchasePending = false;
  ProductDetails? _product;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final _failures = StreamController<void>.broadcast();

  /// Fires when a purchase fails, so the screen can show a message.
  Stream<void> get purchaseFailures => _failures.stream;

  bool get isPremium => _isPremium;
  bool get storeAvailable => _storeAvailable;
  bool get purchasePending => _purchasePending;

  /// Localized price from the store, e.g. "₦1,500.00" or "$2.99".
  String? get price => _debugPrice ?? _product?.price;
  String? _debugPrice;

  /// For tests and screenshots: pretend the store returned [value].
  @visibleForTesting
  void debugSetPrice(String? value) {
    _debugPrice = value;
    notifyListeners();
  }

  /// Reads the saved entitlement. Call before `runApp` so no ad flashes for
  /// people who already bought.
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isPremium = prefs.getBool(_ownedKey) ?? false;
    } catch (e) {
      debugPrint('Could not load premium state: $e');
    }
  }

  /// Connects to Google Play / the App Store. Call after `runApp`.
  Future<void> connect() async {
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      return;
    }
    try {
      final iap = InAppPurchase.instance;
      _subscription ??= iap.purchaseStream.listen(
        _onPurchases,
        onError: (Object e) => debugPrint('Purchase stream error: $e'),
      );
      _storeAvailable = await iap.isAvailable();
      if (_storeAvailable) {
        final response = await iap.queryProductDetails({productId});
        _product = response.productDetails.isEmpty
            ? null
            : response.productDetails.first;
        // Android: silently re-grant a purchase after reinstall / new phone.
        // (On iOS restoring asks for the Apple ID password, so it's a button.)
        if (!_isPremium && defaultTargetPlatform == TargetPlatform.android) {
          await iap.restorePurchases();
        }
      }
    } catch (e) {
      debugPrint('Store connection failed: $e');
    }
    notifyListeners();
  }

  /// Starts the purchase. Returns false if the store or product is missing.
  Future<bool> buy() async {
    final product = _product;
    if (!_storeAvailable || product == null) return false;
    Analytics.purchaseStarted();
    return InAppPurchase.instance.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: product),
    );
  }

  Future<void> restore() async {
    if (!_storeAvailable) return;
    await InAppPurchase.instance.restorePurchases();
  }

  Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID != productId) continue;
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _purchasePending = true;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _purchasePending = false;
          if (!_isPremium && purchase.status == PurchaseStatus.purchased) {
            Analytics.purchaseCompleted();
          }
          await _setPremium(true);
        case PurchaseStatus.error:
          _purchasePending = false;
          _failures.add(null);
        case PurchaseStatus.canceled:
          _purchasePending = false;
      }
      if (purchase.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchase);
      }
    }
    notifyListeners();
  }

  Future<void> _setPremium(bool value) async {
    _isPremium = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_ownedKey, value);
    } catch (e) {
      debugPrint('Could not save premium state: $e');
    }
  }

  /// For tests only.
  @visibleForTesting
  Future<void> debugSetPremium(bool value) async {
    await _setPremium(value);
    notifyListeners();
  }
}
