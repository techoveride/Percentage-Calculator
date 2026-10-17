import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ads/app_open_ad_manager.dart';

/// Links and actions that leave the app. Each one tells the app open ad
/// manager to skip the next resume, so users aren't shown an ad on return.
class AppLinks {
  AppLinks._();

  static const androidPackage = 'com.techoveride.percentagecalculator';
  static const playStoreUrl =
      'https://play.google.com/store/apps/details?id=$androidPackage';
  static const supportEmail = 'techoveridehub@gmail.com';

  /// Page served by the WordPress template `website/page-percal-privacy-policy.php`
  /// (page slug `percal-privacy-policy`). Required on the Play listing for
  /// apps that show ads. Leave empty to hide the menu entry.
  static const privacyPolicyUrl =
      'https://techoveridehub.com/percal-privacy-policy/';

  static Future<void> share(String text, {String? subject}) async {
    AppOpenAdManager.instance.skipNextResume();
    await SharePlus.instance.share(ShareParams(text: text, subject: subject));
  }

  /// [text] is the localized invitation (see `shareAppText`).
  static Future<void> shareApp(String text) => share(text);

  static Future<bool> rateApp() => openStore(null);

  /// Opens [url], or this app's Play Store page when [url] is null.
  static Future<bool> openStore(String? url) async {
    if (url != null) return _open(Uri.parse(url));
    final market = Uri.parse('market://details?id=$androidPackage');
    if (defaultTargetPlatform == TargetPlatform.android &&
        await _open(market)) {
      return true;
    }
    return _open(Uri.parse(playStoreUrl));
  }

  static Future<bool> openPrivacyPolicy() => _open(Uri.parse(privacyPolicyUrl));

  static Future<bool> email({required String subject, required String body}) {
    // Encode by hand: Uri(queryParameters:) turns spaces into '+', which
    // many mail apps show literally.
    final uri = Uri.parse(
      'mailto:$supportEmail'
      '?subject=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(body)}',
    );
    return _open(uri);
  }

  static Future<bool> _open(Uri uri) async {
    AppOpenAdManager.instance.skipNextResume();
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not open $uri: $e');
      return false;
    }
  }
}
