import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../analytics/analytics.dart';
import '../util/core_methods.dart';

/// User preferences (theme, colour and language), saved on the device.
class SettingsController extends ChangeNotifier {
  SettingsController._();

  static final SettingsController instance = SettingsController._();

  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale';
  static const _accentKey = 'accent_color';

  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;
  int _accentIndex = 0;

  ThemeMode get themeMode => _themeMode;

  /// Null means "follow the system language".
  Locale? get locale => _locale;

  /// Index into [accentColors]; 0 is the free brand blue.
  int get accentIndex => _accentIndex;
  Color get accentColor => accentColors[_accentIndex];

  /// Call once before `runApp` so the first frame uses the saved choices.
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _themeMode = ThemeMode.values.firstWhere(
        (m) => m.name == prefs.getString(_themeKey),
        orElse: () => ThemeMode.system,
      );
      final code = prefs.getString(_localeKey);
      _locale = code == null ? null : Locale(code);
      final accent = prefs.getInt(_accentKey) ?? 0;
      _accentIndex = accent >= 0 && accent < accentColors.length ? accent : 0;
    } catch (e) {
      debugPrint('Could not load settings: $e');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
    Analytics.themeChanged(mode.name);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<void> setAccentIndex(int index) async {
    if (index == _accentIndex || index < 0 || index >= accentColors.length) {
      return;
    }
    _accentIndex = index;
    notifyListeners();
    Analytics.colorChanged(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_accentKey, index);
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == _locale) return;
    _locale = locale;
    notifyListeners();
    Analytics.languageChanged(locale?.languageCode ?? 'system');
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, locale.languageCode);
    }
  }
}
