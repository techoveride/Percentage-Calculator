import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart' as calc;
import 'calculator_definition.dart';

/// Sale price after a percentage discount.
CalculatorDefinition discountDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.discount,
    title: l.calcDiscountTitle,
    subtitle: l.calcDiscountSubtitle,
    icon: Icons.local_offer_outlined,
    fields: [
      CalcField(label: l.fieldOriginalPrice, hint: '80'),
      CalcField(label: l.fieldDiscount, hint: '25', suffix: '%'),
    ],
    calculate: (v) {
      final d = calc.discount(v[0], v[1]);
      return [
        CalcResult(l.resultFinalPrice, d.finalPrice),
        CalcResult(l.resultYouSave, d.saved),
      ];
    },
  );
}
