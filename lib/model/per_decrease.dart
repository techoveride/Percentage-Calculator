import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// Y decreased by X%.
CalculatorDefinition decreaseDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.decrease,
    title: l.calcDecreaseTitle,
    subtitle: l.calcDecreaseSubtitle,
    icon: Icons.trending_down,
    fields: [
      CalcField(label: l.fieldAmount, hint: '120', allowNegative: true),
      CalcField(label: l.fieldDecreaseBy, hint: '10', suffix: '%'),
    ],
    calculate: (v) => [
      CalcResult(l.resultResult, perDecrease(v[1], v[0])),
      CalcResult(l.resultDecrease, percentage(v[1], v[0])),
    ],
  );
}
