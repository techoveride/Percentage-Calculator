import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../premium/premium_controller.dart';
import 'ad_config.dart';

/// Loads and shows app open ads, following Google's guidance:
/// - one shared ad instance for the whole app,
/// - cached ads expire after 4 hours,
/// - shown on cold start (only if it loads quickly) and when the app returns
///   from the background,
/// - never twice in a row: [AdConfig.appOpenMinInterval] between ads,
/// - not shown when the user returns from something the app itself opened
///   (share sheet, email, Play Store, in-app update) — see [skipNextResume].
class AppOpenAdManager {
  AppOpenAdManager._();

  static final AppOpenAdManager instance = AppOpenAdManager._();

  static const _maxCacheDuration = Duration(hours: 4);

  AppOpenAd? _appOpenAd;
  DateTime? _loadTime;
  DateTime? _lastShownTime;
  bool _isLoading = false;
  bool _isShowingAd = false;
  bool _skipNextResume = false;
  bool _enabled = false;
  void Function()? _onLoaded;

  bool get isAdAvailable =>
      _appOpenAd != null &&
      _loadTime != null &&
      DateTime.now().difference(_loadTime!) < _maxCacheDuration;

  /// Turns app open ads on (after the SDK is initialised and the user is
  /// eligible) and starts loading the first ad.
  void enable() {
    _enabled = true;
    loadAd();
  }

  void loadAd() {
    final adUnitId = AdConfig.appOpenAdUnitId;
    if (!_enabled ||
        adUnitId == null ||
        _isLoading ||
        isAdAvailable ||
        PremiumController.instance.isPremium) {
      return;
    }
    _isLoading = true;
    AppOpenAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoading = false;
          _appOpenAd?.dispose();
          _appOpenAd = ad;
          _loadTime = DateTime.now();
          final onLoaded = _onLoaded;
          _onLoaded = null;
          onLoaded?.call();
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          _onLoaded = null;
          debugPrint('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  /// Shows an ad on cold start if one becomes available before
  /// [AdConfig.appOpenColdStartTimeout] has passed since [appStart].
  void showOnColdStart(DateTime appStart) {
    bool inTime() =>
        DateTime.now().difference(appStart) < AdConfig.appOpenColdStartTimeout;
    if (!_enabled || !inTime()) return;
    if (isAdAvailable) {
      showAdIfAvailable();
      return;
    }
    _onLoaded = () {
      if (inTime()) showAdIfAvailable();
    };
    loadAd();
  }

  /// Call right before handing the user to another app or system UI so that
  /// coming back doesn't trigger an app open ad.
  void skipNextResume() => _skipNextResume = true;

  /// Called when the app moves to the foreground.
  void onAppForegrounded() {
    if (_skipNextResume) {
      _skipNextResume = false;
      return;
    }
    showAdIfAvailable();
  }

  void showAdIfAvailable() {
    if (!_enabled || _isShowingAd || PremiumController.instance.isPremium) {
      return;
    }
    if (!isAdAvailable) {
      _appOpenAd?.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    final last = _lastShownTime;
    if (last != null &&
        DateTime.now().difference(last) < AdConfig.appOpenMinInterval) {
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        _lastShownTime = DateTime.now();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('AppOpenAd failed to show: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}
