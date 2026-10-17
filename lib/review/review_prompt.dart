import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ads/app_open_ad_manager.dart';
import '../analytics/analytics.dart';

/// Asks for a Play / App Store rating at a happy moment: right after the
/// user's 3rd and 25th successful calculation. The stores limit how often the
/// dialog really appears, so asking twice is safe.
class ReviewPrompt {
  ReviewPrompt._();

  static const _countKey = 'successful_calculations';
  static const askAt = {3, 25};

  static Future<void> recordSuccess() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final count = (prefs.getInt(_countKey) ?? 0) + 1;
      await prefs.setInt(_countKey, count);
      if (!askAt.contains(count)) return;

      final review = InAppReview.instance;
      if (await review.isAvailable()) {
        AppOpenAdManager.instance.skipNextResume();
        Analytics.reviewRequested(count);
        await review.requestReview();
      }
    } catch (e) {
      debugPrint('Review prompt failed: $e');
    }
  }
}
