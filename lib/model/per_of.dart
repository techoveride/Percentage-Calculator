import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// X is what % of Y.
CalculatorDefinition percentOfDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.percentOf,
    title: l.calcPercentOfTitle,
    subtitle: l.calcPercentOfSubtitle,
    icon: Icons.pie_chart_outline,
    fields: [
      CalcField(label: l.fieldPart, hint: '30', allowNegative: true),
      CalcField(
        label: l.fieldWhole,
        hint: '120',
        allowNegative: true,
        validate: (v) => v == 0 ? l.errorNotZero : null,
      ),
    ],
    calculate: (v) {
      final result = perOf(v[0], v[1]);
      if (result == null) return null;
      return [CalcResult(l.resultResult, result, suffix: '%')];
    },
  );
}
