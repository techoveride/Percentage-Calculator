import 'package:flutter_test/flutter_test.dart';
import 'package:percentage_calculator/util/calculations.dart';

void main() {
  test('percentage', () {
    expect(percentage(10, 120), closeTo(12, 1e-9));
    expect(percentage(-5, 200), closeTo(-10, 1e-9));
  });

  test('increase and decrease', () {
    expect(perIncrease(10, 120), closeTo(132, 1e-9));
    expect(perDecrease(10, 120), closeTo(108, 1e-9));
  });

  test('percentage change', () {
    expect(perChange(50, 75), closeTo(50, 1e-9));
    expect(perChange(80, 60), closeTo(-25, 1e-9));
    // The old formula (|new| - old) / |old| got negative values wrong.
    expect(perChange(-100, -50), closeTo(50, 1e-9));
    expect(perChange(0, 10), isNull);
  });

  test('percentage of', () {
    expect(perOf(30, 120), closeTo(25, 1e-9));
    expect(perOf(1, 0), isNull);
  });

  test('margin is profit as a share of price', () {
    final m = perMargin(100, 20)!;
    expect(m.price, closeTo(125, 1e-9));
    expect(m.profit, closeTo(25, 1e-9));
    expect(m.markupPercent, closeTo(25, 1e-9));
    expect(perMargin(100, 100), isNull);
  });

  test('tip split', () {
    final t = perTip(10, 200, 4)!;
    expect(t.tipAmount, closeTo(20, 1e-9));
    expect(t.tipPerPerson, closeTo(5, 1e-9));
    expect(t.totalToPay, closeTo(220, 1e-9));
    expect(t.totalPerPerson, closeTo(55, 1e-9));
    expect(perTip(10, 200, 0), isNull);
  });

  test('parseNumber', () {
    expect(parseNumber('12.5'), 12.5);
    expect(parseNumber(' 1,5 '), 1.5);
    expect(parseNumber('-3'), -3);
    expect(parseNumber('1,234.5'), 1234.5);
    expect(parseNumber('1.234,5'), 1234.5);
    expect(parseNumber('1,234,567'), 1234567);
    expect(parseNumber('1.234.567'), 1234567);
    expect(parseNumber('.'), isNull);
    expect(parseNumber('1-2'), isNull);
    expect(parseNumber(''), isNull);
  });

  test('formatNumber', () {
    expect(formatNumber(12), '12');
    expect(formatNumber(12.5), '12.5');
    expect(formatNumber(1 / 3), '0.33');
    expect(formatNumber(-0.001), '0');
    expect(formatNumber(1234.5, locale: 'en'), '1,234.5');
    expect(formatNumber(1234.5, locale: 'de'), '1.234,5');
  });

  test('formatInput round-trips through parseNumber', () {
    for (final v in [0.0, 12.0, 12.5, -3.25, 1234567.891]) {
      expect(parseNumber(formatInput(v)), closeTo(v, 1e-6));
    }
  });

  test('discount', () {
    final d = discount(80, 25);
    expect(d.finalPrice, closeTo(60, 1e-9));
    expect(d.saved, closeTo(20, 1e-9));
  });

  test('tax added and removed', () {
    final t = tax(100, 20);
    expect(t.withTax, closeTo(120, 1e-9));
    expect(t.taxAdded, closeTo(20, 1e-9));
    expect(t.withoutTax, closeTo(83.3333, 1e-4));
    expect(t.taxIncluded, closeTo(16.6667, 1e-4));
  });

  test('grade', () {
    expect(gradePercent(42, 50), closeTo(84, 1e-9));
    expect(gradePercent(1, 0), isNull);
  });

  test('loan uses the standard monthly payment formula', () {
    // 10,000 at 12%/year over 1 year → 888.49 per month.
    final l = loan(10000, 12, 1)!;
    expect(l.monthlyPayment, closeTo(888.49, 0.01));
    expect(l.totalPayment, closeTo(10661.85, 0.01));
    expect(l.totalInterest, closeTo(661.85, 0.01));
    // Interest-free loans are split evenly.
    expect(loan(1200, 0, 1)!.monthlyPayment, closeTo(100, 1e-9));
    expect(loan(1000, 10, 0), isNull);
  });
}
