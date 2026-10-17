import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:percentage_calculator/app.dart';
import 'package:percentage_calculator/history/history_store.dart';
import 'package:percentage_calculator/l10n/app_localizations.dart';
import 'package:percentage_calculator/model/calculator_definition.dart';
import 'package:percentage_calculator/settings/settings_controller.dart';
import 'package:percentage_calculator/widgets/calculator_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _localized(Widget child, {Locale locale = const Locale('en')}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await HistoryStore.instance.clear();
  });

  testWidgets('home lists every calculator', (tester) async {
    await tester.pumpWidget(const PercentageCalculatorApp());
    await tester.pumpAndSettle();

    expect(find.text('% Calculator'), findsOneWidget);
    expect(find.text('Calculate Percentage'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Loan & Interest'), 200);
    expect(find.text('Loan & Interest'), findsOneWidget);
  });

  testWidgets('calculates while typing', (tester) async {
    await tester.pumpWidget(
      _localized(const CalculatorPage(kind: CalculatorKind.percentage)),
    );

    final inputs = find.byType(TextFormField);
    await tester.enterText(inputs.at(0), '10');
    await tester.enterText(inputs.at(1), '1200');
    await tester.pumpAndSettle();

    expect(find.text('120'), findsOneWidget);
  });

  testWidgets('invalid input shows an error instead of crashing', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localized(const CalculatorPage(kind: CalculatorKind.tip)),
    );

    final inputs = find.byType(TextFormField);
    await tester.enterText(inputs.at(0), '100');
    await tester.enterText(inputs.at(1), '0');
    await tester.enterText(inputs.at(2), '10');
    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();

    expect(find.text('Must be at least 1'), findsOneWidget);
  });

  testWidgets('Calculate saves to history', (tester) async {
    await tester.pumpWidget(
      _localized(const CalculatorPage(kind: CalculatorKind.discount)),
    );

    final inputs = find.byType(TextFormField);
    await tester.enterText(inputs.at(0), '80');
    await tester.enterText(inputs.at(1), '25');
    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();

    final entries = HistoryStore.instance.entries;
    expect(entries, hasLength(1));
    expect(entries.first.kind, CalculatorKind.discount);
    expect(entries.first.values, [80, 25]);
  });

  testWidgets('results use the language number format', (tester) async {
    await tester.pumpWidget(
      _localized(
        const CalculatorPage(
          kind: CalculatorKind.increase,
          initialValues: [1000, 25.5],
        ),
        locale: const Locale('fr'),
      ),
    );
    await tester.pumpAndSettle();

    // 1000 + 25.5% = 1255 → French grouping uses a (narrow) no-break space.
    expect(find.textContaining(RegExp(r'1\s255')), findsOneWidget);
    expect(find.text('Calculer'), findsOneWidget);
  });

  testWidgets('settings switch language and theme', (tester) async {
    await tester.pumpWidget(const PercentageCalculatorApp());
    await SettingsController.instance.setLocale(const Locale('es'));
    await SettingsController.instance.setThemeMode(ThemeMode.dark);
    await tester.pumpAndSettle();

    expect(find.text('Calculadora %'), findsOneWidget);
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);

    await SettingsController.instance.setLocale(null);
    await SettingsController.instance.setThemeMode(ThemeMode.system);
  });
}
