import 'package:flutter/material.dart';

import 'calculations.dart';

/// Brand colour; Material 3 derives the light and dark palettes from it.
const Color brandColor = Color(0xFF1565C0);

/// Accent colours users can pick in Settings. The first is free; the rest are
/// unlocked with a rewarded ad or by going ad-free.
const List<Color> accentColors = [
  brandColor,
  Color(0xFF00897B), // teal
  Color(0xFF2E7D32), // green
  Color(0xFF6A1B9A), // purple
  Color(0xFFEF6C00), // orange
  Color(0xFFD81B60), // pink
  Color(0xFFC62828), // red
];

ThemeData buildTheme(Brightness brightness, {Color seed = brandColor}) {
  final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: brightness);
  return ThemeData(
    colorScheme: scheme,
    appBarTheme: const AppBarTheme(centerTitle: true),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}

/// Languages the app is translated into, shown by their own names.
const Map<String, String> appLanguages = {
  'en': 'English',
  'fr': 'Français',
  'sw': 'Kiswahili',
  'hi': 'हिन्दी',
  'es': 'Español',
  'pt': 'Português',
  'ar': 'العربية',
};

/// Formats [value] for the app's current language, e.g. "1,234.5" in English
/// and "1 234,5" in French.
String formatLocalized(
  BuildContext context,
  double value, {
  String suffix = '',
}) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return '${formatNumber(value, locale: locale)}$suffix';
}
