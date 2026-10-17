import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// Tip on a bill, split between several people.
CalculatorDefinition tipDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.tip,
    title: l.calcTipTitle,
    subtitle: l.calcTipSubtitle,
    icon: Icons.restaurant,
    fields: [
      CalcField(label: l.fieldBillAmount, hint: '120'),
      CalcField(
        label: l.fieldPeople,
        hint: '4',
        wholeNumber: true,
        validate: (v) => v < 1 ? l.errorAtLeastOne : null,
      ),
      CalcField(label: l.fieldTipPercent, hint: '10', suffix: '%'),
    ],
    calculate: (v) {
      final tip = perTip(v[2], v[0], v[1].round());
      if (tip == null) return null;
      return [
        CalcResult(l.resultTotalPerPerson, tip.totalPerPerson),
        CalcResult(l.resultTotalToPay, tip.totalToPay),
        CalcResult(l.resultTipAmount, tip.tipAmount),
        CalcResult(l.resultTipPerPerson, tip.tipPerPerson),
      ];
    },
  );
}
