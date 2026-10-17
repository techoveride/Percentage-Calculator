import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// Percentage change from one value to another.
CalculatorDefinition changeDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.change,
    title: l.calcChangeTitle,
    subtitle: l.calcChangeSubtitle,
    icon: Icons.swap_vert,
    fields: [
      CalcField(
        label: l.fieldInitialValue,
        hint: '120',
        allowNegative: true,
        validate: (v) => v == 0 ? l.errorNotZero : null,
      ),
      CalcField(label: l.fieldFinalValue, hint: '150', allowNegative: true),
    ],
    calculate: (v) {
      final change = perChange(v[0], v[1]);
      if (change == null) return null;
      return [
        CalcResult(l.resultPercentChange, change, suffix: '%'),
        CalcResult(l.resultDifference, v[1] - v[0]),
      ];
    },
  );
}
