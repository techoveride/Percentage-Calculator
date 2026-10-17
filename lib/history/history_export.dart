import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

import '../ads/app_open_ad_manager.dart';
import '../analytics/analytics.dart';
import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'history_store.dart';

/// Builds a spreadsheet-friendly CSV of [entries]. Numbers are written
/// without grouping and with a `.` decimal mark so Excel / Sheets read them
/// as numbers in any language.
String historyToCsv(List<HistoryEntry> entries, AppLocalizations l) {
  final rows = <List<String>>[
    [l.csvDate, l.csvCalculator, l.csvInputs, l.csvResults],
  ];
  for (final entry in entries) {
    final def = entry.kind.definition(l);
    final results = def.calculate(entry.values) ?? const [];
    rows.add([
      entry.time.toIso8601String().substring(0, 16).replaceFirst('T', ' '),
      def.title,
      [
        for (var i = 0; i < entry.values.length && i < def.fields.length; i++)
          '${def.fields[i].label}: ${formatInput(entry.values[i])}'
              '${def.fields[i].suffix ?? ''}',
      ].join('; '),
      [
        for (final r in results)
          '${r.label}: ${formatInput(double.parse(r.value.toStringAsFixed(2)))}'
              '${r.suffix}',
      ].join('; '),
    ]);
  }
  return rows.map((row) => row.map(_escape).join(',')).join('\r\n');
}

String _escape(String field) {
  if (!field.contains(RegExp(r'[",\r\n]'))) return field;
  return '"${field.replaceAll('"', '""')}"';
}

/// Shares the CSV through the system share sheet (save to Drive, email, ...).
Future<void> shareHistoryCsv(
  List<HistoryEntry> entries,
  AppLocalizations l,
) async {
  // UTF-8 BOM so Excel shows accents and non-Latin scripts correctly.
  final bytes = Uint8List.fromList([
    0xEF,
    0xBB,
    0xBF,
    ...utf8.encode(historyToCsv(entries, l)),
  ]);
  AppOpenAdManager.instance.skipNextResume();
  Analytics.historyExported();
  await SharePlus.instance.share(
    ShareParams(
      subject: l.historyTitle,
      files: [
        XFile.fromData(
          bytes,
          mimeType: 'text/csv',
          name: 'percentage-calculator-history.csv',
        ),
      ],
      fileNameOverrides: const ['percentage-calculator-history.csv'],
    ),
  );
}
