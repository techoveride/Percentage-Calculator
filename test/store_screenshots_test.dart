// Renders the real app screens for the Google Play listing.
//
// Skipped in normal test runs. Generate with:
//   flutter test test/store_screenshots_test.dart --dart-define=SCREENSHOTS=true \
//     --dart-define=FONT_DIR=<flutter>/bin/cache/artifacts/material_fonts
// Raw captures go to design/store/screenshots/raw/<device>/.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:percentage_calculator/history/history_screen.dart';
import 'package:percentage_calculator/history/history_store.dart';
import 'package:percentage_calculator/l10n/app_localizations.dart';
import 'package:percentage_calculator/model/calculator_definition.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:percentage_calculator/util/home_screen.dart';
import 'package:percentage_calculator/widgets/calculator_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _enabled = bool.fromEnvironment('SCREENSHOTS');
const _fontDir = String.fromEnvironment('FONT_DIR');

class _Device {
  const _Device(this.name, this.size, this.pixelRatio);
  final String name;
  final Size size; // logical pixels
  final double pixelRatio;
}

const _devices = [
  _Device('phone', Size(412, 892), 3),
  _Device('tablet7', Size(600, 960), 2),
  _Device('tablet10', Size(800, 1280), 2),
];

Future<void> _loadFonts() async {
  Future<ByteData> read(String file) async =>
      ByteData.sublistView(File('$_fontDir/$file').readAsBytesSync());
  final roboto = FontLoader('Roboto');
  for (final w in ['thin', 'light', 'regular', 'medium', 'bold', 'black']) {
    roboto.addFont(read('roboto-$w.ttf'));
  }
  await roboto.load();
  await (FontLoader(
    'MaterialIcons',
  )..addFont(read('materialicons-regular.otf'))).load();
}

/// App shell matching PercentageCalculatorApp, with [page] pushed on top of a
/// blank route so calculator screens show their back arrow.
Widget _app(Widget page, {bool dark = false, bool pushed = true}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: buildTheme(Brightness.light),
    darkTheme: buildTheme(Brightness.dark),
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => const SizedBox()),
    onGenerateInitialRoutes: (_) => [
      if (pushed) MaterialPageRoute<void>(builder: (_) => const SizedBox()),
      MaterialPageRoute<void>(builder: (_) => page),
    ],
  );
}

Future<void> _capture(
  WidgetTester tester,
  _Device device,
  String name,
  Widget app,
) async {
  tester.view.physicalSize = device.size * device.pixelRatio;
  tester.view.devicePixelRatio = device.pixelRatio;
  final key = GlobalKey();
  await tester.pumpWidget(RepaintBoundary(key: key, child: app));
  await tester.pumpAndSettle();
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: device.pixelRatio);
    final png = await image.toByteData(format: ui.ImageByteFormat.png);
    File('design/store/screenshots/raw/${device.name}/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(png!.buffer.asUint8List());
  });
  // Dispose the screen before the next one (calculators save on dispose).
  await tester.pumpWidget(const SizedBox());
}

Future<void> _seedHistory() async {
  final store = HistoryStore.instance;
  await store.clear();
  // Oldest first; the list shows newest first.
  await store.add(CalculatorKind.grade, [42, 50]);
  await store.add(CalculatorKind.tax, [100, 18]);
  await store.add(CalculatorKind.change, [80, 100]);
  await store.add(CalculatorKind.loan, [10000, 12, 3]);
  await store.add(CalculatorKind.tip, [120, 4, 10]);
  await store.add(CalculatorKind.discount, [80, 25]);
  await store.add(CalculatorKind.percentage, [15, 240]);
}

void main() {
  setUpAll(() async {
    if (!_enabled) return;
    SharedPreferences.setMockInitialValues({});
    await _loadFonts();
  });

  for (final device in _devices) {
    testWidgets('store screenshots: ${device.name}', (tester) async {
      Widget calc(CalculatorKind kind, List<double> values) =>
          _app(CalculatorPage(kind: kind, initialValues: values));

      await _capture(
        tester,
        device,
        '01_home',
        _app(const HomeScreen(), pushed: false),
      );
      await _capture(
        tester,
        device,
        '02_percentage',
        calc(CalculatorKind.percentage, [15, 240]),
      );
      await _capture(
        tester,
        device,
        '03_tip',
        calc(CalculatorKind.tip, [120, 4, 10]),
      );
      await _capture(
        tester,
        device,
        '04_discount',
        calc(CalculatorKind.discount, [80, 25]),
      );
      await _capture(
        tester,
        device,
        '05_loan',
        calc(CalculatorKind.loan, [10000, 12, 3]),
      );
      await _seedHistory();
      await _capture(tester, device, '06_history', _app(const HistoryScreen()));
      await _capture(
        tester,
        device,
        '07_dark',
        _app(const HomeScreen(), dark: true, pushed: false),
      );
      await _capture(
        tester,
        device,
        '08_tax',
        calc(CalculatorKind.tax, [100, 18]),
      );

      tester.view.reset();
    }, skip: !_enabled);
  }
}
