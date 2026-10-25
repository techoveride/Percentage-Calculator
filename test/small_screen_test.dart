// Small phones (≤ 6", e.g. Android 10 devices at 320–360 dp wide) with larger
// text: no screen may overflow. Flutter reports any overflow as a test error.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:percentage_calculator/l10n/app_localizations.dart';
import 'package:percentage_calculator/model/calculator_definition.dart';
import 'package:percentage_calculator/premium/ad_free.dart';
import 'package:percentage_calculator/premium/premium_controller.dart';
import 'package:percentage_calculator/premium/remove_ads_sheet.dart';
import 'package:percentage_calculator/settings/settings_screen.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:percentage_calculator/util/home_screen.dart';
import 'package:percentage_calculator/widgets/calculator_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _sizes = [Size(320, 568), Size(360, 640)];
const _textScales = [1.0, 1.3];

Widget _app(
  Widget home, {
  Locale locale = const Locale('en'),
  double scale = 1,
}) {
  return MaterialApp(
    theme: buildTheme(Brightness.light),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(scale)),
      child: child!,
    ),
    home: home,
  );
}

Future<void> _pumpAt(WidgetTester tester, Size size, Widget app) async {
  tester.view.physicalSize = size * 2;
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PremiumController.instance.debugSetPrice('US\$0.99');
  });
  tearDown(() => PremiumController.instance.debugSetPrice(null));

  for (final size in _sizes) {
    for (final scale in _textScales) {
      final name = '${size.width.toInt()}x${size.height.toInt()} @${scale}x';

      testWidgets('Settings fits on $name', (tester) async {
        await _pumpAt(tester, size, _app(const SettingsScreen(), scale: scale));
        expect(find.text('Restore purchases'), findsOneWidget);
        expect(find.text('Remove ads – US\$0.99'), findsOneWidget);
        expect(find.text('Watch a video: no ads for 24 hours'), findsOneWidget);
        // Every button is fully on screen (nothing cut off at the edge).
        for (final label in ['Restore purchases', 'Remove ads – US\$0.99']) {
          final rect = tester.getRect(find.text(label));
          expect(rect.right, lessThanOrEqualTo(size.width), reason: label);
        }
      });

      testWidgets('Settings in French fits on $name', (tester) async {
        await _pumpAt(
          tester,
          size,
          _app(
            const SettingsScreen(),
            locale: const Locale('fr'),
            scale: scale,
          ),
        );
        expect(find.text('Restaurer les achats'), findsOneWidget);
      });

      testWidgets('Home and drawer fit on $name', (tester) async {
        await _pumpAt(tester, size, _app(const HomeScreen(), scale: scale));
        await tester.tap(find.byTooltip('Open navigation menu'));
        await tester.pumpAndSettle();
        final drawerList = find.descendant(
          of: find.byType(Drawer),
          matching: find.byType(Scrollable),
        );
        await tester.scrollUntilVisible(
          find.text('Go ad-free'),
          100,
          scrollable: drawerList,
        );
        expect(find.text('Go ad-free'), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text('Check for updates'),
          100,
          scrollable: drawerList,
        );
        expect(find.text('Check for updates'), findsOneWidget);
      });

      testWidgets('Remove ads sheet fits on $name', (tester) async {
        await _pumpAt(
          tester,
          size,
          _app(
            Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => showRemoveAdsSheet(context),
                  child: const Text('open'),
                ),
              ),
            ),
            scale: scale,
          ),
        );
        await tester.tap(find.text('open'));
        await tester.pumpAndSettle();
        expect(find.text('Watch a video: no ads for 24 hours'), findsOneWidget);
      });

      testWidgets('Loan calculator fits on $name', (tester) async {
        await _pumpAt(
          tester,
          size,
          _app(
            const CalculatorPage(
              kind: CalculatorKind.loan,
              initialValues: [10000, 12, 3],
            ),
            scale: scale,
          ),
        );
        expect(find.text('Monthly payment'), findsOneWidget);
      });
    }
  }

  group('24-hour ad-free pass', () {
    test('hides ads for 24 hours, then they come back', () async {
      var now = DateTime(2026, 10, 26, 15);
      final adFree = AdFreeController.forTest(() => now);
      await adFree.load();
      expect(adFree.active, isFalse);

      await adFree.grantDayPass();
      expect(adFree.active, isTrue);
      expect(adFree.passUntil, DateTime(2026, 10, 27, 15));

      now = DateTime(2026, 10, 27, 14, 59);
      expect(adFree.active, isTrue);
      now = DateTime(2026, 10, 27, 15, 1);
      expect(adFree.active, isFalse);
      expect(adFree.passUntil, isNull);
    });

    test('the pass survives an app restart', () async {
      final now = DateTime(2026, 10, 26, 15);
      await AdFreeController.forTest(() => now).grantDayPass();
      final restarted = AdFreeController.forTest(() => now);
      await restarted.load();
      expect(restarted.active, isTrue);
    });
  });
}
