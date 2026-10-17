import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// X% of Y.
CalculatorDefinition percentageDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.percentage,
    title: l.calcPercentageTitle,
    subtitle: l.calcPercentageSubtitle,
    icon: Icons.percent,
    fields: [
      CalcField(
        label: l.fieldPercentage,
        hint: '10',
        suffix: '%',
        allowNegative: true,
      ),
      CalcField(label: l.fieldValue, hint: '120', allowNegative: true),
    ],
    calculate: (v) => [CalcResult(l.resultResult, percentage(v[0], v[1]))],
  );
}
