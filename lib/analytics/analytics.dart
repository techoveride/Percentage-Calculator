import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../model/calculator_definition.dart';

/// Firebase Analytics events (console → Analytics → Events).
///
/// Collection is off in debug builds so testing doesn't skew the numbers.
/// In the EEA/UK, Analytics reads the user's choice from the consent form
/// (TCF string) automatically.
class Analytics {
  Analytics._();

  static FirebaseAnalytics? get _analytics =>
      Firebase.apps.isEmpty ? null : FirebaseAnalytics.instance;

  static Future<void> init() async {
    try {
      await _analytics?.setAnalyticsCollectionEnabled(kReleaseMode);
    } catch (e) {
      debugPrint('Analytics init failed: $e');
    }
  }

  static void calculatorOpened(CalculatorKind kind, {String source = 'home'}) =>
      _log('calculator_open', {'calculator': kind.name, 'source': source});

  static void calculation(CalculatorKind kind) =>
      _log('calculation', {'calculator': kind.name});

  static void shareResult(CalculatorKind kind) =>
      _log('share_result', {'calculator': kind.name});

  static void shareApp() => _log('share_app');
  static void historyOpened() => _log('history_open');
  static void historyExported() => _log('history_export');
  static void themeChanged(String mode) => _log('theme_change', {'mode': mode});
  static void colorChanged(int index) => _log('color_change', {'color': index});
  static void languageChanged(String code) =>
      _log('language_change', {'language': code});
  static void updatePrompt({required bool forced}) =>
      _log('update_prompt', {'forced': forced ? 1 : 0});
  static void updateAccepted() => _log('update_accept');
  static void reviewRequested(int calculations) =>
      _log('review_request', {'calculations': calculations});
  static void purchaseStarted() => _log('remove_ads_start');
  static void purchaseCompleted() => _log('remove_ads_purchase');
  static void aiQuestion({required bool calculation}) =>
      _log('ai_question', {'type': calculation ? 'calculation' : 'answer'});
  static void aiInsights() => _log('ai_insights');
  static void aiExplain(CalculatorKind kind) =>
      _log('ai_explain', {'calculator': kind.name});
  static void rewardEarned(String feature) =>
      _log('reward_earned', {'feature': feature});

  static void _log(String name, [Map<String, Object>? parameters]) {
    final analytics = _analytics;
    if (analytics == null) return;
    unawaited(
      analytics
          .logEvent(name: name, parameters: parameters)
          .catchError((Object e) => debugPrint('Analytics $name failed: $e')),
    );
  }
}
