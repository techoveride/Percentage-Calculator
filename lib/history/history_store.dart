import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/calculator_definition.dart';

/// A saved calculation: which calculator and what was typed in. Results are
/// recomputed when shown, so they always appear in the current language.
class HistoryEntry {
  const HistoryEntry({
    required this.kind,
    required this.values,
    required this.time,
  });

  final CalculatorKind kind;
  final List<double> values;
  final DateTime time;

  Map<String, Object> toJson() => {
    'kind': kind.name,
    'values': values,
    'time': time.millisecondsSinceEpoch,
  };

  static HistoryEntry? fromJson(Object? json) {
    if (json is! Map) return null;
    final kind = CalculatorKind.fromName('${json['kind']}');
    final values = json['values'];
    final time = json['time'];
    if (kind == null || values is! List || time is! int) return null;
    return HistoryEntry(
      kind: kind,
      values: [for (final v in values) (v as num).toDouble()],
      time: DateTime.fromMillisecondsSinceEpoch(time),
    );
  }
}

/// Calculation history, newest first, kept on the device.
class HistoryStore extends ChangeNotifier {
  HistoryStore._();

  static final HistoryStore instance = HistoryStore._();

  static const _key = 'history_v1';
  static const maxEntries = 100;

  final List<HistoryEntry> _entries = [];

  List<HistoryEntry> get entries => List.unmodifiable(_entries);

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null) return;
      _entries
        ..clear()
        ..addAll((jsonDecode(raw) as List).map(HistoryEntry.fromJson).nonNulls);
    } catch (e) {
      debugPrint('Could not load history: $e');
    }
  }

  /// Saves a calculation unless it repeats the most recent one.
  Future<void> add(CalculatorKind kind, List<double> values) async {
    final latest = _entries.isEmpty ? null : _entries.first;
    if (latest != null &&
        latest.kind == kind &&
        listEquals(latest.values, values)) {
      return;
    }
    _entries.insert(
      0,
      HistoryEntry(kind: kind, values: values, time: DateTime.now()),
    );
    if (_entries.length > maxEntries) _entries.removeLast();
    notifyListeners();
    await _save();
  }

  Future<void> remove(HistoryEntry entry) async {
    _entries.remove(entry);
    notifyListeners();
    await _save();
  }

  /// Puts back an entry removed with [remove] (for "Undo").
  Future<void> restore(HistoryEntry entry) async {
    _entries
      ..add(entry)
      ..sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
    await _save();
  }

  Future<void> clear() async {
    _entries.clear();
    notifyListeners();
    await _save();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _key,
        jsonEncode([for (final e in _entries) e.toJson()]),
      );
    } catch (e) {
      debugPrint('Could not save history: $e');
    }
  }
}
