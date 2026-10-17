import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// Exam marks as a percentage.
CalculatorDefinition gradeDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.grade,
    title: l.calcGradeTitle,
    subtitle: l.calcGradeSubtitle,
    icon: Icons.school_outlined,
    fields: [
      CalcField(label: l.fieldScore, hint: '42'),
      CalcField(
        label: l.fieldTotalMarks,
        hint: '50',
        validate: (v) => v == 0 ? l.errorNotZero : null,
      ),
    ],
    calculate: (v) {
      final percent = gradePercent(v[0], v[1]);
      if (percent == null) return null;
      return [
        CalcResult(l.resultPercentage, percent, suffix: '%'),
        CalcResult(l.resultMarksLost, v[1] - v[0]),
      ];
    },
  );
}
