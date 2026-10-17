import 'dart:math' as math;

/// Exact maths for the AI (same as server/ai-worker/src/tools.ts). The model
/// never does arithmetic itself: it calls these, which run in app code on the
/// history payload (see `historyPayload`).

/// Runs a tool call and returns its JSON-able result. Errors are returned as
/// data so the model can correct itself.
Map<String, Object?> runAiTool(
  String name,
  Map<String, Object?> args,
  List<Map<String, Object>> history,
) {
  try {
    switch (name) {
      case 'aggregate':
        return aggregateHistory(
          op: '${args['op']}',
          label: '${args['label']}',
          calculator: args['calculator'] as String?,
          from: args['from'] as String?,
          to: args['to'] as String?,
          history: history,
        );
      case 'compute':
        final expression = '${args['expression']}';
        return {
          'expression': expression,
          'value': _round(evaluateExpression(expression)),
        };
      default:
        return {'error': 'Unknown tool $name'};
    }
  } on FormatException catch (e) {
    return {'error': e.message};
  }
}

Map<String, Object?> aggregateHistory({
  required String op,
  required String label,
  String? calculator,
  String? from,
  String? to,
  required List<Map<String, Object>> history,
}) {
  final wanted = label.trim().toLowerCase();
  final values = <double>[];
  for (final entry in history) {
    if (calculator != null &&
        calculator.isNotEmpty &&
        entry['calculator'] != calculator) {
      continue;
    }
    final day = '${entry['date']}'.substring(0, 10);
    if (from != null && from.isNotEmpty && day.compareTo(from) < 0) continue;
    if (to != null && to.isNotEmpty && day.compareTo(to) > 0) continue;
    final fields = [
      ...(entry['inputs'] as List? ?? const []),
      ...(entry['results'] as List? ?? const []),
    ].cast<Map>();
    for (final field in fields) {
      if ('${field['label']}'.trim().toLowerCase() == wanted) {
        values.add((field['value'] as num).toDouble());
        break;
      }
    }
  }
  if (values.isEmpty) {
    return {'op': op, 'label': label, 'count': 0, 'value': null};
  }
  final sum = values.fold<double>(0, (a, b) => a + b);
  final value = switch (op) {
    'sum' => sum,
    'avg' => sum / values.length,
    'min' => values.reduce(math.min),
    'max' => values.reduce(math.max),
    'count' => values.length.toDouble(),
    _ => throw FormatException('Unknown op $op'),
  };
  return {
    'op': op,
    'label': label,
    'count': values.length,
    'value': _round(value),
  };
}

double _round(double v) => (v * 1e6).roundToDouble() / 1e6;

/// Safe arithmetic evaluator: numbers, + - * / ^, parentheses, unary minus.
double evaluateExpression(String expression) {
  if (expression.length > 300) {
    throw const FormatException('Expression too long');
  }
  final src = expression.replaceAll(RegExp(r'\s+'), '');
  var pos = 0;

  String? peek() => pos < src.length ? src[pos] : null;

  late double Function() additive;

  double number() {
    final match = RegExp(r'^(\d+(\.\d+)?|\.\d+)')
        .firstMatch(src.substring(pos));
    if (match == null) throw FormatException('Number expected at $pos');
    pos += match.group(0)!.length;
    return double.parse(match.group(0)!);
  }

  double primary() {
    if (peek() == '(') {
      pos++;
      final v = additive();
      if (peek() != ')') throw FormatException('Expected ")" at $pos');
      pos++;
      return v;
    }
    if (peek() == '-') {
      pos++;
      return -primary();
    }
    if (peek() == '+') {
      pos++;
      return primary();
    }
    return number();
  }

  double power() {
    final base = primary();
    if (peek() == '^') {
      pos++;
      return math.pow(base, power()).toDouble(); // right-associative
    }
    return base;
  }

  double multiplicative() {
    var v = power();
    while (peek() == '*' || peek() == '/') {
      final op = src[pos++];
      final rhs = power();
      if (op == '/' && rhs == 0) {
        throw const FormatException('Division by zero');
      }
      v = op == '*' ? v * rhs : v / rhs;
    }
    return v;
  }

  additive = () {
    var v = multiplicative();
    while (peek() == '+' || peek() == '-') {
      final op = src[pos++];
      final rhs = multiplicative();
      v = op == '+' ? v + rhs : v - rhs;
    }
    return v;
  };

  final result = additive();
  if (pos != src.length) {
    throw FormatException('Unexpected "${src[pos]}" at $pos');
  }
  if (!result.isFinite) {
    throw const FormatException('Result is not a finite number');
  }
  return result;
}
