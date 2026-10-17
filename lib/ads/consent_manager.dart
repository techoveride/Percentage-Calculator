import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_config.dart';

/// Google User Messaging Platform (UMP) consent, required by Google to serve
/// ads to users in the EEA, UK and Switzerland. The message itself is
/// configured in AdMob → Privacy & messaging.
class ConsentManager {
  ConsentManager._();

  /// Requests the latest consent status and shows the consent form if the
  /// user still needs to answer it. Completes when the form is dismissed or
  /// isn't needed. Never throws.
  static Future<void> gatherConsent() {
    final completer = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      _params(),
      () async {
        await ConsentForm.loadAndShowConsentFormIfRequired((FormError? error) {
          if (error != null) {
            debugPrint(
              'Consent form error: ${error.errorCode} ${error.message}',
            );
          }
          if (!completer.isCompleted) completer.complete();
        });
      },
      (FormError error) {
        // Offline or misconfigured: fall back to the previous consent state.
        debugPrint(
          'Consent info update failed: ${error.errorCode} ${error.message}',
        );
        if (!completer.isCompleted) completer.complete();
      },
    );
    return completer.future;
  }

  static Future<bool> canRequestAds() async {
    try {
      return await ConsentInformation.instance.canRequestAds();
    } catch (e) {
      debugPrint('canRequestAds failed: $e');
      return false;
    }
  }

  /// Whether the app must offer a way to change consent (EEA/UK users).
  static Future<bool> isPrivacyOptionsRequired() async {
    try {
      return await ConsentInformation.instance
              .getPrivacyOptionsRequirementStatus() ==
          PrivacyOptionsRequirementStatus.required;
    } catch (e) {
      debugPrint('Privacy options status failed: $e');
      return false;
    }
  }

  static Future<void> showPrivacyOptionsForm() {
    final completer = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((FormError? error) {
      if (error != null) {
        debugPrint(
          'Privacy options form error: ${error.errorCode} ${error.message}',
        );
      }
      if (!completer.isCompleted) completer.complete();
    });
    return completer.future;
  }

  static ConsentRequestParameters _params() {
    if (!kDebugMode) return ConsentRequestParameters();
    return ConsentRequestParameters(
      consentDebugSettings: ConsentDebugSettings(
        debugGeography: AdConfig.forceEeaConsentInDebug
            ? DebugGeography.debugGeographyEea
            : null,
        testIdentifiers: AdConfig.umpTestDeviceIds,
      ),
    );
  }
}
