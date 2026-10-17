import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:quick_actions/quick_actions.dart';

import '../history/history_screen.dart';
import '../l10n/app_localizations.dart';
import '../model/calculator_definition.dart';
import '../util/calculations.dart';
import '../widgets/calculator_page.dart';

/// Lets the home-screen widget and the long-press app shortcuts open a
/// specific screen. Both use `percal://` links:
///
/// - `percal://calc/discount`          → Discount calculator
/// - `percal://calc/tip?v=120,4,10`    → Tip calculator with inputs filled in
/// - `percal://history`                → History
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppLaunch {
  AppLaunch._();

  static const scheme = 'percal';
  static const _quickActions = QuickActions();
  static StreamSubscription<Uri?>? _widgetClicks;
  static bool _started = false;

  static Uri calculatorUri(CalculatorKind kind, [List<double>? values]) => Uri(
    scheme: scheme,
    host: 'calc',
    path: '/${kind.name}',
    queryParameters: values == null
        ? null
        : {'v': values.map(formatInput).join(',')},
  );

  static Uri get historyUri => Uri(scheme: scheme, host: 'history');

  /// Starts listening for widget taps and shortcut presses. Call once the
  /// navigator exists (from the home screen's first frame).
  static Future<void> start() async {
    if (_started) return;
    _started = true;
    try {
      await _quickActions.initialize(
        (type) => open(Uri.tryParse(type), source: 'shortcut'),
      );
    } catch (e) {
      debugPrint('Quick actions unavailable: $e');
    }
    if (!_widgetSupported) return;
    try {
      open(
        await HomeWidget.initiallyLaunchedFromHomeWidget(),
        source: 'widget',
      );
      _widgetClicks = HomeWidget.widgetClicked.listen(
        (uri) => open(uri, source: 'widget'),
      );
    } catch (e) {
      debugPrint('Home widget unavailable: $e');
    }
  }

  /// Long-press shortcuts, in the current language.
  static Future<void> updateShortcuts(AppLocalizations l) async {
    try {
      await _quickActions.setShortcutItems([
        ShortcutItem(
          type: calculatorUri(CalculatorKind.percentage).toString(),
          localizedTitle: l.calcPercentageTitle,
          icon: 'ic_shortcut_percent',
        ),
        ShortcutItem(
          type: calculatorUri(CalculatorKind.discount).toString(),
          localizedTitle: l.calcDiscountTitle,
          icon: 'ic_shortcut_discount',
        ),
        ShortcutItem(
          type: calculatorUri(CalculatorKind.tip).toString(),
          localizedTitle: l.calcTipTitle,
          icon: 'ic_shortcut_tip',
        ),
        ShortcutItem(
          type: historyUri.toString(),
          localizedTitle: l.historyTitle,
          icon: 'ic_shortcut_history',
        ),
      ]);
    } catch (e) {
      debugPrint('Could not set shortcuts: $e');
    }
  }

  /// Opens the screen a `percal://` link points to. Unknown links just leave
  /// the app on the home screen.
  static void open(Uri? uri, {required String source}) {
    final navigator = navigatorKey.currentState;
    if (uri == null || uri.scheme != scheme || navigator == null) return;

    if (uri.host == 'history') {
      navigator.push(MaterialPageRoute(builder: (_) => const HistoryScreen()));
      return;
    }
    if (uri.host != 'calc' || uri.pathSegments.isEmpty) return;
    final kind = CalculatorKind.fromName(uri.pathSegments.first);
    if (kind == null) return;

    final raw = uri.queryParameters['v'];
    final values = raw?.split(',').map(parseNumber).toList();
    navigator.push(
      MaterialPageRoute(
        builder: (_) => CalculatorPage(
          kind: kind,
          source: source,
          initialValues: values == null || values.contains(null)
              ? null
              : values.cast<double>(),
        ),
      ),
    );
  }

  static bool get _widgetSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  @visibleForTesting
  static Future<void> dispose() async {
    await _widgetClicks?.cancel();
    _started = false;
  }
}
