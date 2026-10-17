import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../premium/premium_controller.dart';
import 'ad_config.dart';
import 'app_open_ad_manager.dart';
import 'consent_manager.dart';

/// Starts ads once per app launch: consent → SDK init → banners + app open ads.
class AdsController {
  AdsController._();

  static final AdsController instance = AdsController._();

  static const _launchCountKey = 'launch_count';

  /// True once the Mobile Ads SDK is initialised and ads may be requested.
  /// Banner widgets listen to this.
  final ValueNotifier<bool> adsReady = ValueNotifier(false);

  /// True when the user must be offered a "Privacy settings" entry (EEA/UK).
  final ValueNotifier<bool> privacyOptionsRequired = ValueNotifier(false);

  Future<void>? _sdkStart;
  StreamSubscription<AppState>? _appStateSubscription;
  late DateTime _appStart;

  /// Call once from `main()` after `runApp`. Never throws.
  Future<void> initialize() async {
    _appStart = DateTime.now();
    if (AdConfig.bannerAdUnitId == null && AdConfig.appOpenAdUnitId == null) {
      return; // Unsupported platform or no ad units configured.
    }
    // Bought "remove ads": no ads, so no consent form or SDK needed either.
    if (PremiumController.instance.isPremium) return;
    try {
      // Returning users who already answered: start loading ads immediately.
      if (await ConsentManager.canRequestAds()) unawaited(_startSdk());

      await ConsentManager.gatherConsent();
      privacyOptionsRequired.value =
          await ConsentManager.isPrivacyOptionsRequired();

      if (await ConsentManager.canRequestAds()) await _startSdk();
    } catch (e, s) {
      debugPrint('Ads initialisation failed: $e\n$s');
    }
  }

  /// Opens the consent form again so the user can change their choice.
  Future<void> showPrivacyOptions() async {
    AppOpenAdManager.instance.skipNextResume();
    await ConsentManager.showPrivacyOptionsForm();
    if (await ConsentManager.canRequestAds()) await _startSdk();
  }

  Future<void> _startSdk() => _sdkStart ??= _doStartSdk();

  Future<void> _doStartSdk() async {
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: AdConfig.testDeviceIds),
    );
    await MobileAds.instance.initialize();
    adsReady.value = true;

    if (await _isEligibleForAppOpenAds()) {
      final manager = AppOpenAdManager.instance..enable();
      await AppStateEventNotifier.startListening();
      _appStateSubscription ??= AppStateEventNotifier.appStateStream.listen((
        state,
      ) {
        if (state == AppState.foreground) manager.onAppForegrounded();
      });
      manager.showOnColdStart(_appStart);
    }
  }

  /// Skips app open ads for a new user's first launch(es).
  Future<bool> _isEligibleForAppOpenAds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final launches = (prefs.getInt(_launchCountKey) ?? 0) + 1;
      await prefs.setInt(_launchCountKey, launches);
      return launches > AdConfig.appOpenFreeLaunches;
    } catch (e) {
      debugPrint('Launch counter unavailable: $e');
      return true;
    }
  }
}
