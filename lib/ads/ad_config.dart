import 'package:flutter/foundation.dart';

/// All AdMob identifiers and ad-frequency settings in one place.
///
/// Debug/profile builds always use Google's official test ad units, so you
/// can't accidentally click your own live ads (which can get the AdMob account
/// suspended). Release builds use the production units below.
class AdConfig {
  AdConfig._();

  static bool get useTestAds => !kReleaseMode;

  // ---- Production ad units (AdMob console) ---------------------------------
  // AdMob app ca-app-pub-8002379469251044~5502618353 (its app ID is in
  // android/app/src/main/AndroidManifest.xml).
  static const _androidBanner = 'ca-app-pub-8002379469251044/9250291676';
  static const _androidAppOpen = 'ca-app-pub-8002379469251044/8675576601';
  static const _androidRewarded = 'ca-app-pub-8002379469251044/9890701331';

  // TODO(ios): create an iOS app + ad units in AdMob, paste them here, and set
  // GADApplicationIdentifier in ios/Runner/Info.plist. Until then iOS release
  // builds show no ads.
  static const String? _iosBanner = null;
  static const String? _iosAppOpen = null;
  static const String? _iosRewarded = null;

  // ---- Google test ad units -------------------------------------------------
  // https://developers.google.com/admob/android/test-ads
  static const _testAndroidBanner = 'ca-app-pub-3940256099942544/9214589741';
  static const _testAndroidAppOpen = 'ca-app-pub-3940256099942544/9257395921';
  static const _testAndroidRewarded = 'ca-app-pub-3940256099942544/5224354917';
  static const _testIosBanner = 'ca-app-pub-3940256099942544/2435281174';
  static const _testIosAppOpen = 'ca-app-pub-3940256099942544/5575463023';
  static const _testIosRewarded = 'ca-app-pub-3940256099942544/1712485313';

  /// Devices that always receive test ads, even in release builds.
  /// The ID is printed in logcat the first time an ad is requested.
  static const testDeviceIds = <String>[
    'A1D024014755730901F48A2A06933E1F',
    '0D7F74813DAA8CF871287A05BE47FDE7',
    'B80A053393264E8C73EDDE6250840319', // Pixel 6
  ];

  /// Hashed device IDs for testing the GDPR consent form outside the EEA.
  /// Logged by the UMP SDK as "Use new ConsentDebugSettings.Builder()...".
  static const umpTestDeviceIds = <String>[];

  /// Set to true (debug builds only) to see the consent form as an EEA user.
  static const forceEeaConsentInDebug = false;

  // ---- App open ad frequency -----------------------------------------------
  /// Launches without app open ads for new users (Google recommends letting
  /// people try the app before showing them one).
  static const appOpenFreeLaunches = 1;

  /// Minimum time between two app open ads.
  static const appOpenMinInterval = Duration(minutes: 2);

  /// A cold-start ad is only shown if it loads within this time of launch;
  /// otherwise it's kept for the next time the app is brought to the front.
  static const appOpenColdStartTimeout = Duration(seconds: 5);

  static String? get bannerAdUnitId => _pick(
    android: _androidBanner,
    ios: _iosBanner,
    testAndroid: _testAndroidBanner,
    testIos: _testIosBanner,
  );

  static String? get appOpenAdUnitId => _pick(
    android: _androidAppOpen,
    ios: _iosAppOpen,
    testAndroid: _testAndroidAppOpen,
    testIos: _testIosAppOpen,
  );

  static String? get rewardedAdUnitId => _pick(
    android: _androidRewarded,
    ios: _iosRewarded,
    testAndroid: _testAndroidRewarded,
    testIos: _testIosRewarded,
  );

  static String? _pick({
    required String? android,
    required String? ios,
    required String testAndroid,
    required String testIos,
  }) {
    if (kIsWeb) return null;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return useTestAds ? testAndroid : android;
      case TargetPlatform.iOS:
        return useTestAds ? testIos : ios;
      default:
        return null;
    }
  }
}
