import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../history/history_store.dart';
import '../l10n/app_localizations.dart';
import '../model/calculator_definition.dart';
import '../premium/premium_controller.dart';
import '../util/calculations.dart';
import 'ai_backends.dart';
import 'ai_config.dart';
import 'ai_errors.dart';
import 'ai_quota.dart';
import 'ai_steps.dart';

export 'ai_errors.dart';
export 'ai_quota.dart' show AiQuota;

class AiAnswer {
  const AiAnswer({required this.text, required this.steps});

  final String text;

  /// Non-empty when the user described a calculation: the plan the app runs.
  final List<AiStep> steps;
}

class AiInsight {
  const AiInsight(this.title, this.text);
  final String title;
  final String text;
}

/// The app's AI assistant. Sends a question plus the user's saved
/// calculations only when they ask; never in the background.
///
/// Answers come from Gemini (Firebase AI Logic, free) or, if Remote Config
/// `ai_provider` is `worker`, from Claude through server/ai-worker.
class AiService {
  AiService._();

  static final AiService instance = AiService._();

  static const _installKey = 'ai_install_id';
  static const _consentKey = 'ai_consent';

  /// Latest allowance (null until first known).
  final ValueNotifier<AiQuota?> quota = ValueNotifier(null);

  /// Replaced in tests.
  @visibleForTesting
  AiBackend? backendOverride;
  @visibleForTesting
  LocalAiQuota localQuota = LocalAiQuota();

  String? _installId;

  AiBackend get _backend =>
      backendOverride ??
      (AiConfig.usesWorker
          ? WorkerBackend(endpoint: AiConfig.workerEndpoint)
          : GeminiBackend(model: AiConfig.geminiModel));

  bool get _premium => PremiumController.instance.isPremium;

  Future<bool> hasConsent() async =>
      (await SharedPreferences.getInstance()).getBool(_consentKey) ?? false;

  Future<void> giveConsent() async =>
      (await SharedPreferences.getInstance()).setBool(_consentKey, true);

  /// Random ID for the Worker's daily limits; not linked to the user or device.
  Future<String> _install() async {
    final cached = _installId;
    if (cached != null) return cached;
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_installKey);
    if (id == null) {
      final random = Random.secure();
      id = List.generate(
        16,
        (_) => random.nextInt(256),
      ).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      await prefs.setString(_installKey, id);
    }
    return _installId = id;
  }

  Future<Map<String, Object?>> _identity() async => {
    'installId': await _install(),
    'premium': _premium,
  };

  Future<AiAnswer> ask(
    String question,
    AppLocalizations l,
    String locale,
  ) async {
    final data = await _run(AiFeature.assist, {
      'question': question,
      'locale': locale,
      'history': historyPayload(HistoryStore.instance.entries, l),
      'calculators': calculatorCatalog(l),
    });
    final steps = data['kind'] == 'calculation'
        ? [
            for (final s in (data['steps'] as List? ?? const []))
              AiStep.fromJson(Map<String, dynamic>.from(s as Map)),
          ]
        : const <AiStep>[];
    return AiAnswer(text: data['answer'] as String? ?? '', steps: steps);
  }

  Future<List<AiInsight>> insights(AppLocalizations l, String locale) async {
    final data = await _run(AiFeature.insights, {
      'locale': locale,
      'history': historyPayload(HistoryStore.instance.entries, l),
    });
    return [
      for (final i in (data['insights'] as List? ?? const []))
        AiInsight('${(i as Map)['title']}', '${i['text']}'),
    ];
  }

  Future<String> explain(
    CalculatorKind kind,
    List<double> values,
    AppLocalizations l,
    String locale,
  ) async {
    final entry = HistoryEntry(
      kind: kind,
      values: values,
      time: DateTime.now(),
    );
    final payload = historyPayload([entry], l);
    if (payload.isEmpty) throw const AiException(AiErrorCode.generic);
    final data = await _run(AiFeature.explain, {
      'locale': locale,
      'calculation': payload.first,
    });
    return data['explanation'] as String? ?? '';
  }

  /// +5 questions after a rewarded ad (two a day).
  Future<void> claimReward() async {
    final backend = _backend;
    if (backend.enforcesQuota) {
      quota.value = await backend.reward(await _identity());
      return;
    }
    final updated = await localQuota.addReward(premium: _premium);
    if (updated == null) throw const AiException(AiErrorCode.quota);
    quota.value = updated;
  }

  Future<void> refreshQuota() async {
    final backend = _backend;
    quota.value = backend.enforcesQuota
        ? await backend.quota(await _identity())
        : await localQuota.status(premium: _premium);
  }

  Future<Map<String, dynamic>> _run(
    AiFeature feature,
    Map<String, Object?> payload,
  ) async {
    final backend = _backend;
    if (!backend.enforcesQuota) {
      final current = await localQuota.status(premium: _premium);
      quota.value = current;
      if (current.remaining <= 0) throw const AiException(AiErrorCode.quota);
    }
    try {
      final result = await backend.run(feature, {
        ...await _identity(),
        ...payload,
      });
      quota.value = backend.enforcesQuota
          ? result.quota ?? quota.value
          : await localQuota.addUse(premium: _premium);
      return result.data;
    } on AiException catch (e) {
      if (e.quota != null) quota.value = e.quota;
      rethrow;
    }
  }
}

/// Saved calculations in the shape the AI expects, newest first, with
/// labels in the user's language and the results the app worked out.
@visibleForTesting
List<Map<String, Object>> historyPayload(
  List<HistoryEntry> entries,
  AppLocalizations l,
) {
  final out = <Map<String, Object>>[];
  for (final entry in entries.take(AiConfig.maxHistory)) {
    final def = entry.kind.definition(l);
    final results = def.calculate(entry.values);
    if (results == null || entry.values.length != def.fields.length) continue;
    out.add({
      'date': entry.time.toIso8601String().substring(0, 19),
      'calculator': entry.kind.name,
      'title': def.title,
      'inputs': [
        for (var i = 0; i < entry.values.length; i++)
          {
            'label': def.fields[i].label,
            'value': entry.values[i],
            'suffix': def.fields[i].suffix ?? '',
          },
      ],
      'results': [
        for (final r in results)
          {'label': r.label, 'value': r.value, 'suffix': r.suffix},
      ],
    });
  }
  return out;
}

/// Every calculator with its input fields and result names, so the AI can
/// turn a sentence into a calculation plan.
@visibleForTesting
List<Map<String, Object>> calculatorCatalog(AppLocalizations l) {
  return [
    for (final kind in CalculatorKind.values)
      () {
        final def = kind.definition(l);
        final sample = [for (final f in def.fields) parseNumber(f.hint) ?? 1];
        return <String, Object>{
          'calculator': kind.name,
          'title': def.title,
          'fields': [
            for (final f in def.fields)
              {'label': f.label, 'suffix': f.suffix ?? ''},
          ],
          'results': [
            for (final r in def.calculate(sample) ?? const <CalcResult>[])
              r.label,
          ],
        };
      }(),
  ];
}
