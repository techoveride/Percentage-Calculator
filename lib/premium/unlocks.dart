import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'premium_controller.dart';

/// Extras unlocked by watching a rewarded ad (or by buying "remove ads").
class Unlocks extends ChangeNotifier {
  Unlocks._() {
    PremiumController.instance.addListener(notifyListeners);
  }

  static final Unlocks instance = Unlocks._();

  static const _colorsKey = 'unlocked_colors';

  bool _colors = false;

  bool get _premium => PremiumController.instance.isPremium;

  /// All accent colours (one rewarded ad unlocks them for good).
  bool get colors => _premium || _colors;

  /// CSV export is free with premium; otherwise one rewarded ad per export.
  bool get freeExport => _premium;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _colors = prefs.getBool(_colorsKey) ?? false;
    } catch (e) {
      debugPrint('Could not load unlocks: $e');
    }
  }

  Future<void> unlockColors() async {
    _colors = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_colorsKey, true);
  }
}
