import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../l10n/app_localizations.dart';
import '../model/calculator_definition.dart';
import 'app_launch.dart';

/// Feeds the Android home-screen widget (LastResultWidgetProvider.kt).
/// iOS needs a WidgetKit extension built in Xcode, so it's Android-only.
class HomeWidgetService {
  HomeWidgetService._();

  static const _provider =
      'com.techoveride.percentage_calculator.LastResultWidgetProvider';

  static bool get _supported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Widget texts in the app's current language.
  static Future<void> updateLabels(AppLocalizations l) async {
    await _save({
      'app_title': l.appTitle,
      'empty_text': l.widgetEmpty,
      'btn1_label': '%',
      'btn1_uri': AppLaunch.calculatorUri(CalculatorKind.percentage).toString(),
      'btn2_label': l.calcDiscountTitle,
      'btn2_uri': AppLaunch.calculatorUri(CalculatorKind.discount).toString(),
      'btn3_label': l.fieldTipPercent,
      'btn3_uri': AppLaunch.calculatorUri(CalculatorKind.tip).toString(),
    });
  }

  /// Shows the latest calculation; tapping it reopens it with its inputs.
  static Future<void> updateLastResult({
    required String title,
    required String value,
    required CalculatorKind kind,
    required List<double> inputs,
  }) async {
    await _save({
      'last_title': title,
      'last_value': value,
      'last_uri': AppLaunch.calculatorUri(kind, inputs).toString(),
    });
  }

  static Future<void> _save(Map<String, String> data) async {
    if (!_supported) return;
    try {
      for (final entry in data.entries) {
        await HomeWidget.saveWidgetData<String>(entry.key, entry.value);
      }
      await HomeWidget.updateWidget(qualifiedAndroidName: _provider);
    } catch (e) {
      debugPrint('Home widget update failed: $e');
    }
  }
}
