import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../analytics/analytics.dart';
import 'premium_controller.dart';

/// Whether ads (banners and app open ads) are hidden right now: either the
/// user bought "remove ads", or watched a rewarded video for a 24-hour pass.
///
/// The pass only hides banner and app open ads; extras such as colours and
/// CSV export stay tied to the purchase or their own rewarded unlocks.
class AdFreeController extends ChangeNotifier {
  AdFreeController._({DateTime Function()? now}) : _now = now ?? DateTime.now {
    PremiumController.instance.addListener(notifyListeners);
  }

  static final AdFreeController instance = AdFreeController._();

  /// For tests: an instance with its own clock.
  @visibleForTesting
  factory AdFreeController.forTest(DateTime Function() now) =>
      AdFreeController._(now: now);

  static const passDuration = Duration(hours: 24);
  static const _passKey = 'ad_free_pass_until';

  final DateTime Function() _now;
  DateTime? _passUntil;
  Timer? _expiry;

  bool get isPremium => PremiumController.instance.isPremium;

  /// End of the current 24-hour pass, or null if none is active.
  DateTime? get passUntil {
    final until = _passUntil;
    return until != null && until.isAfter(_now()) ? until : null;
  }

  /// True while ads should be hidden.
  bool get active => isPremium || passUntil != null;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final millis = prefs.getInt(_passKey);
      _passUntil = millis == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(millis);
      _scheduleExpiry();
    } catch (e) {
      debugPrint('Could not load ad-free pass: $e');
    }
  }

  /// Starts (or restarts) a 24-hour ad-free pass after a rewarded video.
  Future<void> grantDayPass() async {
    _passUntil = _now().add(passDuration);
    _scheduleExpiry();
    notifyListeners();
    Analytics.rewardEarned('ad_free_day');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_passKey, _passUntil!.millisecondsSinceEpoch);
  }

  /// Brings ads back the moment the pass ends, even mid-session.
  void _scheduleExpiry() {
    _expiry?.cancel();
    final until = passUntil;
    if (until == null) return;
    _expiry = Timer(until.difference(_now()), notifyListeners);
  }
}
