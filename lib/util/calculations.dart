/// Pure percentage math used by the calculator screens.
///
/// Functions return full-precision values; rounding happens only when a
/// result is displayed (see [formatNumber]). Functions that can be undefined
/// for some inputs (e.g. division by zero) return `null`.
library;

import 'dart:math' as math;

import 'package:intl/intl.dart';

/// [per]% of [value].  e.g. 10% of 120 = 12
double percentage(double per, double value) => per / 100 * value;

/// [value] increased by [per]%.  e.g. 120 + 10% = 132
double perIncrease(double per, double value) => value + value * per / 100;

/// [value] decreased by [per]%.  e.g. 120 - 10% = 108
double perDecrease(double per, double value) => value - value * per / 100;

/// Percentage change from [oldValue] to [newValue].
/// e.g. 50 -> 75 = +50%, 80 -> 60 = -25%. Undefined when [oldValue] is 0.
double? perChange(double oldValue, double newValue) {
  if (oldValue == 0) return null;
  return (newValue - oldValue) / oldValue.abs() * 100;
}

/// What percentage [part] is of [whole].  e.g. 30 of 120 = 25%.
/// Undefined when [whole] is 0.
double? perOf(double part, double whole) {
  if (whole == 0) return null;
  return part / whole * 100;
}

/// Selling price that gives a gross [marginPercent] on [cost].
///
/// Margin is profit as a share of the *price*: price = cost / (1 - margin).
/// e.g. cost 100 at 20% margin -> price 125 (profit 25, which is 20% of 125).
/// Undefined for margins of 100% or more.
MarginResult? perMargin(double cost, double marginPercent) {
  if (marginPercent >= 100) return null;
  final price = cost / (1 - marginPercent / 100);
  final profit = price - cost;
  final markup = cost == 0 ? null : profit / cost * 100;
  return MarginResult(price: price, profit: profit, markupPercent: markup);
}

class MarginResult {
  const MarginResult({
    required this.price,
    required this.profit,
    required this.markupPercent,
  });

  final double price;
  final double profit;

  /// Profit as a share of the cost; `null` when the cost is 0.
  final double? markupPercent;
}

/// Splits a bill of [amount] with a [tipPercent] tip between [people].
/// Undefined when [people] is less than 1.
TipResult? perTip(double tipPercent, double amount, int people) {
  if (people < 1) return null;
  final tip = amount * tipPercent / 100;
  final total = amount + tip;
  return TipResult(
    tipAmount: tip,
    tipPerPerson: tip / people,
    totalToPay: total,
    totalPerPerson: total / people,
  );
}

class TipResult {
  const TipResult({
    required this.tipAmount,
    required this.tipPerPerson,
    required this.totalToPay,
    required this.totalPerPerson,
  });

  final double tipAmount;
  final double tipPerPerson;
  final double totalToPay;
  final double totalPerPerson;
}

/// [price] after a [discountPercent] discount.  e.g. 80 at 25% off = 60.
DiscountResult discount(double price, double discountPercent) {
  final saved = price * discountPercent / 100;
  return DiscountResult(finalPrice: price - saved, saved: saved);
}

class DiscountResult {
  const DiscountResult({required this.finalPrice, required this.saved});

  final double finalPrice;
  final double saved;
}

/// Adds tax to, and removes tax from, [amount] at [ratePercent].
/// e.g. 100 at 20%: with tax 120 (tax 20); without tax 83.33 (tax 16.67).
TaxResult tax(double amount, double ratePercent) {
  final rate = ratePercent / 100;
  final net = amount / (1 + rate);
  return TaxResult(
    withTax: amount * (1 + rate),
    taxAdded: amount * rate,
    withoutTax: net,
    taxIncluded: amount - net,
  );
}

class TaxResult {
  const TaxResult({
    required this.withTax,
    required this.taxAdded,
    required this.withoutTax,
    required this.taxIncluded,
  });

  /// [amount] treated as a net price, with tax added on top.
  final double withTax;
  final double taxAdded;

  /// [amount] treated as a gross price, with the tax inside it taken out.
  final double withoutTax;
  final double taxIncluded;
}

/// [score] out of [total] as a percentage. Undefined when [total] is 0.
double? gradePercent(double score, double total) {
  if (total == 0) return null;
  return score / total * 100;
}

/// Fixed-rate loan repaid monthly (standard amortisation / EMI formula).
/// Undefined for terms shorter than one month.
LoanResult? loan(double principal, double annualRatePercent, double years) {
  final months = (years * 12).round();
  if (months < 1) return null;
  final r = annualRatePercent / 100 / 12;
  final payment = r == 0
      ? principal / months
      : principal * r / (1 - math.pow(1 + r, -months));
  final total = payment * months;
  return LoanResult(
    monthlyPayment: payment,
    totalPayment: total,
    totalInterest: total - principal,
  );
}

class LoanResult {
  const LoanResult({
    required this.monthlyPayment,
    required this.totalPayment,
    required this.totalInterest,
  });

  final double monthlyPayment;
  final double totalPayment;
  final double totalInterest;
}

/// Parses user input. Accepts `.` or `,` as the decimal separator; when both
/// appear (e.g. `1.234,5` or `1,234.5`) the last one is the decimal separator
/// and the other is a thousands separator. A separator repeated on its own
/// (`1,234,567`) is treated as thousands. Returns `null` for anything that is
/// not a finite number.
double? parseNumber(String? input) {
  if (input == null) return null;
  var text = input.trim().replaceAll(RegExp(r'[\s  ]'), '');
  if (text.isEmpty) return null;

  final lastDot = text.lastIndexOf('.');
  final lastComma = text.lastIndexOf(',');
  if (lastDot >= 0 && lastComma >= 0) {
    final decimal = lastDot > lastComma ? '.' : ',';
    final grouping = decimal == '.' ? ',' : '.';
    text = text.replaceAll(grouping, '').replaceAll(decimal, '.');
  } else if (lastComma >= 0) {
    text = ','.allMatches(text).length > 1
        ? text.replaceAll(',', '')
        : text.replaceAll(',', '.');
  } else if ('.'.allMatches(text).length > 1) {
    text = text.replaceAll('.', '');
  }

  final value = double.tryParse(text);
  if (value == null || !value.isFinite) return null;
  return value;
}

/// Formats [value] for display in [locale] (grouping separators, local
/// decimal mark) with at most [decimals] decimal places and no trailing zeros.
/// e.g. en: 1234.5 -> "1,234.5"; fr: "1 234,5"; 12.0 -> "12".
String formatNumber(double value, {String? locale, int decimals = 2}) {
  final threshold = 0.5 / math.pow(10, decimals);
  if (value.abs() < threshold) value = 0; // avoid "-0"
  NumberFormat format;
  try {
    format = NumberFormat.decimalPattern(locale);
  } catch (_) {
    format = NumberFormat.decimalPattern('en');
  }
  format
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = decimals;
  return format.format(value);
}

/// Plain machine-style text for putting a number back into an input field:
/// no grouping, `.` decimal mark, no trailing zeros.  e.g. 1234.5 -> "1234.5".
String formatInput(double value) {
  var text = value.toStringAsFixed(6);
  text = text.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  return text == '-0' ? '0' : text;
}
