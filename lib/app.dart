import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'launch/app_launch.dart';
import 'settings/settings_controller.dart';
import 'util/core_methods.dart';
import 'util/home_screen.dart';

class PercentageCalculatorApp extends StatelessWidget {
  const PercentageCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsController.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        theme: buildTheme(Brightness.light, seed: settings.accentColor),
        darkTheme: buildTheme(Brightness.dark, seed: settings.accentColor),
        themeMode: settings.themeMode,
        locale: settings.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(),
      ),
    );
  }
}
