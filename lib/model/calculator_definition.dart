import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'discount.dart';
import 'grade.dart';
import 'loan.dart';
import 'per_calculate.dart';
import 'per_change.dart';
import 'per_decrease.dart';
import 'per_increase.dart';
import 'per_margin.dart';
import 'per_of.dart';
import 'tax.dart';
import 'tip_calculate.dart';

/// Every calculator in the app, in home-screen order.
///
/// The enum `name` is stored in saved history, so don't rename values.
enum CalculatorKind {
  percentage,
  percentOf,
  increase,
  decrease,
  change,
  discount,
  tip,
  tax,
  margin,
  grade,
  loan;

  static CalculatorKind? fromName(String name) {
    for (final kind in values) {
      if (kind.name == name) return kind;
    }
    return null;
  }

  CalculatorDefinition definition(AppLocalizations l) => switch (this) {
    percentage => percentageDefinition(l),
    percentOf => percentOfDefinition(l),
    increase => increaseDefinition(l),
    decrease => decreaseDefinition(l),
    change => changeDefinition(l),
    discount => discountDefinition(l),
    tip => tipDefinition(l),
    tax => taxDefinition(l),
    margin => marginDefinition(l),
    grade => gradeDefinition(l),
    loan => loanDefinition(l),
  };
}

/// One numeric input of a calculator.
class CalcField {
  const CalcField({
    required this.label,
    required this.hint,
    this.suffix,
    this.allowNegative = false,
    this.wholeNumber = false,
    this.validate,
  });

  final String label;

  /// Example value shown as the hint, e.g. "120".
  final String hint;
  final String? suffix;
  final bool allowNegative;
  final bool wholeNumber;

  /// Extra check on a parsed value; returns an error message or null.
  final String? Function(double value)? validate;
}

/// Whether [value] is acceptable for [field] (same rules as the input boxes).
bool isValidValue(CalcField field, double value) {
  if (!field.allowNegative && value < 0) return false;
  if (field.wholeNumber && value != value.roundToDouble()) return false;
  return field.validate?.call(value) == null;
}

/// One output of a calculator.
class CalcResult {
  const CalcResult(this.label, this.value, {this.suffix = ''});

  final String label;
  final double value;
  final String suffix;
}

/// Everything the shared calculator screen needs to show one calculator.
class CalculatorDefinition {
  const CalculatorDefinition({
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.fields,
    required this.calculate,
  });

  final CalculatorKind kind;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<CalcField> fields;

  /// Results for valid inputs (one value per field), or null when the result
  /// is undefined (e.g. a division by zero). The first result is the headline.
  final List<CalcResult>? Function(List<double> values) calculate;
}
