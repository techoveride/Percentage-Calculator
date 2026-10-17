import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart' as calc;
import 'calculator_definition.dart';

/// VAT / GST / sales tax: shows both adding tax to a net price and removing
/// it from a gross price, so users don't have to pick a mode.
CalculatorDefinition taxDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.tax,
    title: l.calcTaxTitle,
    subtitle: l.calcTaxSubtitle,
    icon: Icons.receipt_long_outlined,
    fields: [
      CalcField(label: l.fieldAmount, hint: '100'),
      CalcField(label: l.fieldTaxRate, hint: '18', suffix: '%'),
    ],
    calculate: (v) {
      final t = calc.tax(v[0], v[1]);
      return [
        CalcResult(l.resultWithTax, t.withTax),
        CalcResult(l.resultTaxAdded, t.taxAdded),
        CalcResult(l.resultWithoutTax, t.withoutTax),
        CalcResult(l.resultTaxIncluded, t.taxIncluded),
      ];
    },
  );
}
