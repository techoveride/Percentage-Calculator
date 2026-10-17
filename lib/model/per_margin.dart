import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart';
import 'calculator_definition.dart';

/// Selling price for a gross profit margin.
CalculatorDefinition marginDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.margin,
    title: l.calcMarginTitle,
    subtitle: l.calcMarginSubtitle,
    icon: Icons.storefront_outlined,
    fields: [
      CalcField(label: l.fieldCost, hint: '100'),
      CalcField(
        label: l.fieldMargin,
        hint: '20',
        suffix: '%',
        validate: (v) => v >= 100 ? l.errorBelow100 : null,
      ),
    ],
    calculate: (v) {
      final m = perMargin(v[0], v[1]);
      if (m == null) return null;
      return [
        CalcResult(l.resultPrice, m.price),
        CalcResult(l.resultProfit, m.profit),
        CalcResult(l.resultMarkup, m.markupPercent ?? 0, suffix: '%'),
      ];
    },
  );
}
