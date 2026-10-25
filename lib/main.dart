import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ads/ads_controller.dart';
import 'analytics/analytics.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'history/history_store.dart';
import 'premium/ad_free.dart';
import 'premium/premium_controller.dart';
import 'premium/unlocks.dart';
import 'settings/settings_controller.dart';

export 'app.dart' show PercentageCalculatorApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  await Future.wait([
    SettingsController.instance.load(),
    HistoryStore.instance.load(),
    PremiumController.instance.load(),
    AdFreeController.instance.load(),
    Unlocks.instance.load(),
  ]);

  runApp(const PercentageCalculatorApp());

  // Google Play / App Store connection for the "remove ads" purchase.
  PremiumController.instance.connect();
  // Consent form (EEA/UK) → Mobile Ads SDK → banners and app open ads.
  // Runs after the first frame so the consent form has a screen to show on.
  AdsController.instance.initialize();
}

Future<void> _initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialisation failed: $e');
    return;
  }

  // Crashlytics: off in debug so local experiments don't create reports.
  final crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
  FlutterError.onError = crashlytics.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    crashlytics.recordError(error, stack, fatal: true);
    return true;
  };

  await Analytics.init();

  // App Check: proves AI requests come from this app installed from Play /
  // the App Store. Debug builds print a debug token to register in Firebase.
  try {
    await FirebaseAppCheck.instance.activate(
      providerAndroid: kDebugMode
          ? const AndroidDebugProvider()
          : const AndroidPlayIntegrityProvider(),
      providerApple: kDebugMode
          ? const AppleDebugProvider()
          : const AppleAppAttestWithDeviceCheckFallbackProvider(),
    );
  } catch (e) {
    debugPrint('App Check activation failed: $e');
  }
}
