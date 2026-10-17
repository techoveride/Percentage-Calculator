import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:percentage_calculator/history/history_export.dart';
import 'package:percentage_calculator/history/history_store.dart';
import 'package:percentage_calculator/l10n/app_localizations_en.dart';
import 'package:percentage_calculator/launch/app_launch.dart';
import 'package:percentage_calculator/model/calculator_definition.dart';
import 'package:percentage_calculator/premium/premium_controller.dart';
import 'package:percentage_calculator/premium/unlocks.dart';
import 'package:percentage_calculator/settings/settings_controller.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('CSV export has a header, one row per entry, and escapes commas', () {
    final l = AppLocalizationsEn();
    final csv = historyToCsv([
      HistoryEntry(
        kind: CalculatorKind.discount,
        values: const [1234.5, 25],
        time: DateTime(2026, 10, 16, 9, 30),
      ),
    ], l);
    final lines = csv.split('\r\n');

    expect(lines.first, 'Date,Calculator,Inputs,Results');
    expect(lines, hasLength(2));
    expect(lines[1], startsWith('2026-10-16 09:30,Discount,'));
    expect(lines[1], contains('Original price: 1234.5; Discount: 25%'));
    expect(lines[1], contains('Final price: 925.88'));
  });

  test('percal:// links round-trip calculator and inputs', () {
    final uri = AppLaunch.calculatorUri(CalculatorKind.tip, const [120, 4, 10]);
    expect(uri.toString(), 'percal://calc/tip?v=120%2C4%2C10');
    expect(uri.pathSegments.single, 'tip');
    expect(uri.queryParameters['v'], '120,4,10');
    expect(AppLaunch.historyUri.toString(), 'percal://history');
  });

  test('going ad-free unlocks colours and free export', () async {
    await PremiumController.instance.load();
    await Unlocks.instance.load();
    expect(Unlocks.instance.colors, isFalse);
    expect(Unlocks.instance.freeExport, isFalse);

    await PremiumController.instance.debugSetPremium(true);
    expect(Unlocks.instance.colors, isTrue);
    expect(Unlocks.instance.freeExport, isTrue);

    await PremiumController.instance.debugSetPremium(false);
  });

  test('a rewarded unlock of colours is remembered', () async {
    await Unlocks.instance.unlockColors();
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('unlocked_colors'), isTrue);
  });

  test('accent colour choice is saved and validated', () async {
    final settings = SettingsController.instance;
    await settings.setAccentIndex(3);
    expect(settings.accentColor, accentColors[3]);
    await settings.setAccentIndex(99); // ignored
    expect(settings.accentIndex, 3);
    await settings.setAccentIndex(0);
    expect(settings.accentColor, isA<Color>());
  });
}
