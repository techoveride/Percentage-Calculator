import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../util/calculations.dart' as calc;
import 'calculator_definition.dart';

/// Monthly repayment (EMI) and total interest of a fixed-rate loan.
CalculatorDefinition loanDefinition(AppLocalizations l) {
  return CalculatorDefinition(
    kind: CalculatorKind.loan,
    title: l.calcLoanTitle,
    subtitle: l.calcLoanSubtitle,
    icon: Icons.account_balance_outlined,
    fields: [
      CalcField(label: l.fieldLoanAmount, hint: '10000'),
      CalcField(label: l.fieldInterestRate, hint: '12', suffix: '%'),
      CalcField(
        label: l.fieldTermYears,
        hint: '3',
        validate: (v) => v * 12 < 0.5 ? l.errorPositive : null,
      ),
    ],
    calculate: (v) {
      final result = calc.loan(v[0], v[1], v[2]);
      if (result == null) return null;
      return [
        CalcResult(l.resultMonthlyPayment, result.monthlyPayment),
        CalcResult(l.resultTotalPayment, result.totalPayment),
        CalcResult(l.resultTotalInterest, result.totalInterest),
      ];
    },
  );
}
