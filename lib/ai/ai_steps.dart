import '../l10n/app_localizations.dart';
import '../model/calculator_definition.dart';

/// One input in an AI calculation plan: a number, or a result of an earlier
/// step.
class AiStepInput {
  const AiStepInput({this.value, this.fromStep, this.resultIndex});

  factory AiStepInput.fromJson(Map<String, dynamic> json) => AiStepInput(
    value: (json['value'] as num?)?.toDouble(),
    fromStep: (json['from_step'] as num?)?.toInt(),
    resultIndex: (json['result_index'] as num?)?.toInt(),
  );

  final double? value;
  final int? fromStep;
  final int? resultIndex;
}

class AiStep {
  const AiStep({required this.calculator, required this.inputs});

  factory AiStep.fromJson(Map<String, dynamic> json) => AiStep(
    calculator: json['calculator'] as String? ?? '',
    inputs: [
      for (final i in (json['inputs'] as List? ?? const []))
        AiStepInput.fromJson(Map<String, dynamic>.from(i as Map)),
    ],
  );

  final String calculator;
  final List<AiStepInput> inputs;
}

/// A step worked out by the app's own calculator code.
class AiStepResult {
  const AiStepResult({
    required this.definition,
    required this.inputs,
    required this.results,
  });

  final CalculatorDefinition definition;
  final List<double> inputs;
  final List<CalcResult> results;
}

/// Runs an AI calculation plan with the app's calculators, so every number
/// shown is exact. Returns null if any step is unknown or invalid (e.g. the
/// AI picked an impossible input) — the screen then shows an error instead.
List<AiStepResult>? runSteps(List<AiStep> steps, AppLocalizations l) {
  final done = <AiStepResult>[];
  for (final step in steps) {
    final kind = CalculatorKind.fromName(step.calculator);
    if (kind == null) return null;
    final def = kind.definition(l);
    if (step.inputs.length != def.fields.length) return null;

    final values = <double>[];
    for (var i = 0; i < step.inputs.length; i++) {
      final input = step.inputs[i];
      double? value = input.value;
      final from = input.fromStep;
      final index = input.resultIndex;
      if (value == null && from != null && index != null) {
        if (from < 0 || from >= done.length) return null;
        final earlier = done[from].results;
        if (index < 0 || index >= earlier.length) return null;
        value = earlier[index].value;
      }
      if (value == null || !value.isFinite) return null;
      if (!isValidValue(def.fields[i], value)) return null;
      values.add(value);
    }

    final results = def.calculate(values);
    if (results == null) return null;
    done.add(AiStepResult(definition: def, inputs: values, results: results));
  }
  return done;
}
