import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:percentage_calculator/ai/ai_backends.dart';
import 'package:percentage_calculator/ai/ai_math.dart';
import 'package:percentage_calculator/ai/ai_quota.dart';
import 'package:percentage_calculator/ai/ai_screen.dart';
import 'package:percentage_calculator/ai/ai_service.dart';
import 'package:percentage_calculator/ai/ai_steps.dart';
import 'package:percentage_calculator/history/history_store.dart';
import 'package:percentage_calculator/l10n/app_localizations.dart';
import 'package:percentage_calculator/l10n/app_localizations_en.dart';
import 'package:percentage_calculator/model/calculator_definition.dart';
import 'package:shared_preferences/shared_preferences.dart';

final l = AppLocalizationsEn();

AiStep step(String calculator, List<AiStepInput> inputs) =>
    AiStep(calculator: calculator, inputs: inputs);

/// "15% off 2,400 plus 7.5% VAT" as the AI would plan it.
const discountThenVat = <String, Object?>{
  'kind': 'calculation',
  'answer': 'Take 15% off 2,400, then add 7.5% VAT.',
  'steps': [
    {
      'calculator': 'discount',
      'inputs': [
        {'value': 2400, 'from_step': null, 'result_index': null},
        {'value': 15, 'from_step': null, 'result_index': null},
      ],
    },
    {
      'calculator': 'tax',
      'inputs': [
        {'value': null, 'from_step': 0, 'result_index': 0},
        {'value': 7.5, 'from_step': null, 'result_index': null},
      ],
    },
  ],
};

/// Records calls and returns canned data, like a backend would.
class FakeBackend implements AiBackend {
  FakeBackend(this.reply);

  Map<String, dynamic> Function(AiFeature, Map<String, Object?>) reply;
  final calls = <(AiFeature, Map<String, Object?>)>[];

  @override
  bool get enforcesQuota => false;

  @override
  Future<AiCallResult> run(
    AiFeature feature,
    Map<String, Object?> payload,
  ) async {
    calls.add((feature, payload));
    return AiCallResult(reply(feature, payload));
  }

  @override
  Future<AiQuota> reward(Map<String, Object?> identity) =>
      throw UnimplementedError();

  @override
  Future<AiQuota> quota(Map<String, Object?> identity) =>
      throw UnimplementedError();
}

GenerateContentResponse geminiTurn(List<Part> parts, {FinishReason? finish}) =>
    GenerateContentResponse([
      Candidate(
        Content.model(parts),
        null,
        null,
        finish ?? FinishReason.stop,
        null,
      ),
    ], null);

void main() {
  group('runSteps', () {
    test('chains steps with the app calculators (exact numbers)', () {
      final steps = [
        for (final s in discountThenVat['steps']! as List)
          AiStep.fromJson(Map<String, dynamic>.from(s as Map)),
      ];
      final results = runSteps(steps, l)!;
      expect(results, hasLength(2));
      expect(results[0].results.first.value, closeTo(2040, 1e-9));
      expect(results[1].inputs, [2040, 7.5]);
      expect(results[1].results.first.value, closeTo(2193, 1e-9));
    });

    test('rejects unknown calculators, bad references and invalid inputs', () {
      expect(runSteps([step('nope', const [])], l), isNull);
      expect(
        runSteps([
          step('tax', const [
            AiStepInput(fromStep: 3, resultIndex: 0),
            AiStepInput(value: 5),
          ]),
        ], l),
        isNull,
      );
      expect(
        runSteps([
          step('margin', const [
            AiStepInput(value: 10),
            AiStepInput(value: 100),
          ]),
        ], l),
        isNull,
      );
      expect(
        runSteps([
          step('percentage', const [AiStepInput(value: 1)]),
        ], l),
        isNull,
      );
    });
  });

  test('history payload carries labels and app-computed results', () {
    final payload = historyPayload([
      HistoryEntry(
        kind: CalculatorKind.discount,
        values: const [80, 25],
        time: DateTime(2026, 10, 2, 9),
      ),
    ], l);
    expect(payload.single, {
      'date': '2026-10-02T09:00:00',
      'calculator': 'discount',
      'title': 'Discount',
      'inputs': [
        {'label': 'Original price', 'value': 80.0, 'suffix': ''},
        {'label': 'Discount', 'value': 25.0, 'suffix': '%'},
      ],
      'results': [
        {'label': 'Final price', 'value': 60.0, 'suffix': ''},
        {'label': 'You save', 'value': 20.0, 'suffix': ''},
      ],
    });
  });

  test('calculator catalog lists fields and result names', () {
    final tip = calculatorCatalog(l)
        .firstWhere((c) => c['calculator'] == 'tip');
    expect(tip['fields'], hasLength(3));
    expect(tip['results'], [
      'Total per person',
      'Total to pay',
      'Tip amount',
      'Tip per person',
    ]);
  });

  group('exact maths tools', () {
    final history = historyPayload([
      HistoryEntry(
        kind: CalculatorKind.discount,
        values: const [80, 25],
        time: DateTime(2026, 9, 30),
      ),
      HistoryEntry(
        kind: CalculatorKind.discount,
        values: const [200, 10],
        time: DateTime(2026, 10, 5),
      ),
      HistoryEntry(
        kind: CalculatorKind.tip,
        values: const [120, 4, 10],
        time: DateTime(2026, 10, 6),
      ),
    ], l);

    test('aggregate sums a label within calculator and dates', () {
      expect(
        runAiTool('aggregate', {
          'op': 'sum',
          'label': 'you save',
          'calculator': 'discount',
          'from': '2026-10-01',
          'to': null,
        }, history),
        {'op': 'sum', 'label': 'you save', 'count': 1, 'value': 20.0},
      );
      expect(
        runAiTool('aggregate', {
          'op': 'avg',
          'label': 'You save',
        }, history)['value'],
        20.0,
      );
    });

    test('compute evaluates safely', () {
      expect(
        evaluateExpression('(1250 - 980) / 980 * 100'),
        closeTo(27.5510204, 1e-6),
      );
      expect(evaluateExpression('2^3^2'), 512);
      expect(runAiTool('compute', {'expression': '1/0'}, const []), {
        'error': 'Division by zero',
      });
      expect(
        runAiTool('compute', {'expression': 'exit()'}, const [])['error'],
        isNotNull,
      );
    });
  });

  group('GeminiBackend', () {
    final history = historyPayload([
      HistoryEntry(
        kind: CalculatorKind.discount,
        values: const [80, 25],
        time: DateTime(2026, 10, 2),
      ),
      HistoryEntry(
        kind: CalculatorKind.discount,
        values: const [200, 10],
        time: DateTime(2026, 10, 5),
      ),
    ], l);

    test('runs tools in app code, then returns the respond call', () async {
      final sent = <List<Content>>[];
      final turns = [
        geminiTurn([
          const FunctionCall('aggregate', {
            'op': 'sum',
            'label': 'You save',
            'calculator': 'discount',
          }, id: 'call-1'),
        ]),
        geminiTurn([
          const FunctionCall('respond', {
            'kind': 'answer',
            'answer': 'You saved 40 with discounts.',
            'steps': <Object>[],
          }),
        ]),
      ];
      final backend = GeminiBackend(
        model: 'test-model',
        generate: (request, contents) async {
          expect(request.model, 'test-model');
          expect(request.functions.map((f) => f.name), [
            'aggregate',
            'compute',
            'respond',
          ]);
          sent.add(contents);
          return turns.removeAt(0);
        },
      );

      final result = await backend.run(AiFeature.assist, {
        'locale': 'en',
        'question': 'How much did I save?',
        'history': history,
        'calculators': const <Object>[],
      });

      expect(result.data['answer'], 'You saved 40 with discounts.');
      expect(sent, hasLength(2));
      final reply = sent[1].last.parts.single as FunctionResponse;
      expect(reply.name, 'aggregate');
      expect(reply.id, 'call-1');
      expect(reply.response, {
        'op': 'sum',
        'label': 'You save',
        'count': 2,
        'value': 40.0,
      });
    });

    test('maps blocked answers and quota errors', () async {
      Future<AiErrorCode?> codeFor(GeminiGenerate generate) async {
        try {
          await GeminiBackend(model: 'm', generate: generate).run(
            AiFeature.explain,
            {'locale': 'en', 'calculation': history.first},
          );
          return null;
        } on AiException catch (e) {
          return e.code;
        }
      }

      expect(
        await codeFor(
          (_, _) async => geminiTurn(const [], finish: FinishReason.safety),
        ),
        AiErrorCode.refused,
      );
      expect(
        await codeFor((_, _) async => throw QuotaExceeded('quota')),
        AiErrorCode.busy,
      );
      expect(
        await codeFor((_, _) async => throw UnsupportedUserLocation()),
        AiErrorCode.unavailable,
      );
      expect(
        await codeFor(
          (_, _) async => geminiTurn([const TextPart('no tool call')]),
        ),
        AiErrorCode.generic,
      );
    });
  });

  group('AiService with local limits', () {
    late FakeBackend backend;

    setUp(() async {
      SharedPreferences.setMockInitialValues({'ai_consent': true});
      await HistoryStore.instance.clear();
      backend = FakeBackend(
        (feature, _) => Map<String, dynamic>.from(discountThenVat),
      );
      AiService.instance
        ..backendOverride = backend
        ..localQuota = LocalAiQuota(now: () => DateTime(2026, 10, 17, 12))
        ..quota.value = null;
    });

    test('sends history and calculators; 3 free questions a day', () async {
      await HistoryStore.instance.add(CalculatorKind.tip, [120, 4, 10]);
      final answer = await AiService.instance.ask(
        '15% off 2400 + 7.5% VAT',
        l,
        'en',
      );
      expect(answer.steps, hasLength(2));
      final payload = backend.calls.single.$2;
      expect(
        (payload['history']! as List).single,
        containsPair('calculator', 'tip'),
      );
      expect(payload['calculators'], hasLength(CalculatorKind.values.length));
      expect(AiService.instance.quota.value!.remaining, 2);

      await AiService.instance.ask('again', l, 'en');
      await AiService.instance.ask('again', l, 'en');
      await expectLater(
        AiService.instance.ask('one too many', l, 'en'),
        throwsA(
          isA<AiException>().having((e) => e.code, 'code', AiErrorCode.quota),
        ),
      );
      expect(backend.calls, hasLength(3));
    });

    test('rewarded ads add 5 questions, twice a day', () async {
      await AiService.instance.claimReward();
      expect(AiService.instance.quota.value!.limit, 8);
      await AiService.instance.claimReward();
      expect(AiService.instance.quota.value!.limit, 13);
      expect(AiService.instance.quota.value!.rewardsLeft, 0);
      await expectLater(
        AiService.instance.claimReward(),
        throwsA(isA<AiException>()),
      );
    });

    test('failed answers do not use up a question', () async {
      backend.reply = (_, _) => throw const AiException(AiErrorCode.busy);
      await expectLater(
        AiService.instance.insights(l, 'en'),
        throwsA(isA<AiException>()),
      );
      await AiService.instance.refreshQuota();
      expect(AiService.instance.quota.value!.used, 0);
    });

    test('limits reset the next day', () async {
      for (var i = 0; i < 3; i++) {
        await AiService.instance.ask('q', l, 'en');
      }
      AiService.instance.localQuota = LocalAiQuota(
        now: () => DateTime(2026, 10, 18, 9),
      );
      await AiService.instance.refreshQuota();
      expect(AiService.instance.quota.value!.remaining, 3);
    });

    testWidgets('AI screen shows the app-calculated steps', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AiScreen(),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('15% off 2,400 plus 7.5% VAT'));
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Take 15% off 2,400, then add 7.5% VAT.'),
        findsOneWidget,
      );
      expect(find.text('Final price: 2,040'), findsOneWidget);
      expect(find.text('Price with tax added: 2,193'), findsOneWidget);
      expect(find.text('2 AI questions left today'), findsOneWidget);
    });
  });
}
