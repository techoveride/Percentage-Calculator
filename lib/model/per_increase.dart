import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// Y increased by X%.
CalculatorDefinition increaseDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.increase,
    title: l.calcIncreaseTitle,
    subtitle: l.calcIncreaseSubtitle,
    icon: Icons.trending_up,
    fields: [
      CalcField(label: l.fieldAmount, hint: '120', allowNegative: true),
      CalcField(label: l.fieldIncreaseBy, hint: '10', suffix: '%'),
    ],
    calculate: (v) => [
      CalcResult(l.resultResult, perIncrease(v[1], v[0])),
      CalcResult(l.resultIncrease, percentage(v[1], v[0])),
    ],
  );
}
