import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'ai_errors.dart';
import 'ai_math.dart';
import 'ai_prompts.dart';
import 'ai_quota.dart';

/// The AI features the app asks for.
enum AiFeature { assist, insights, explain }

class AiCallResult {
  const AiCallResult(this.data, {this.quota});

  final Map<String, dynamic> data;

  /// Set when the backend enforces limits itself (the Worker).
  final AiQuota? quota;
}

/// Where answers come from. Chosen with Remote Config `ai_provider`.
abstract class AiBackend {
  /// True when the backend tracks daily limits; otherwise the app does.
  bool get enforcesQuota;

  Future<AiCallResult> run(AiFeature feature, Map<String, Object?> payload);

  /// Only for backends that enforce limits.
  Future<AiQuota> reward(Map<String, Object?> identity) =>
      throw UnsupportedError('reward');
  Future<AiQuota> quota(Map<String, Object?> identity) =>
      throw UnsupportedError('quota');
}

// ---------------------------------------------------------------------------
// Gemini through Firebase AI Logic (free tier, no server).

class GeminiBackend implements AiBackend {
  GeminiBackend({required this.model, GeminiGenerate? generate})
    : _generate = generate ?? _defaultGenerate;

  final String model;
  final GeminiGenerate _generate;

  static const _maxRounds = 6;

  @override
  bool get enforcesQuota => false;

  @override
  Future<AiQuota> reward(Map<String, Object?> identity) =>
      throw UnsupportedError('reward');

  @override
  Future<AiQuota> quota(Map<String, Object?> identity) =>
      throw UnsupportedError('quota');

  /// Sends one turn to Gemini through Firebase AI Logic.
  static GeminiGenerate get _defaultGenerate {
    GenerativeModel? cached;
    GeminiRequest? cachedFor;
    return (request, contents) {
      if (cached == null || !identical(cachedFor, request)) {
        cached = _buildModel(request);
        cachedFor = request;
      }
      return cached!.generateContent(contents);
    };
  }

  static GenerativeModel _buildModel(GeminiRequest r) =>
      FirebaseAI.googleAI(useLimitedUseAppCheckTokens: true).generativeModel(
        model: r.model,
        systemInstruction: Content.system(r.instructions),
        tools: [Tool.functionDeclarations(r.functions)],
        toolConfig: ToolConfig(
          functionCallingConfig: FunctionCallingConfig.any(
            r.functions.map((f) => f.name).toSet(),
          ),
        ),
        generationConfig: GenerationConfig(
          temperature: 0.2,
          maxOutputTokens: 2048,
        ),
      );

  @override
  Future<AiCallResult> run(
    AiFeature feature,
    Map<String, Object?> payload,
  ) async {
    final locale = payload['locale'];
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final language = 'Reply in the language with code "$locale".';
    final history = [
      for (final e in (payload['history'] as List? ?? const []))
        Map<String, Object>.from(e as Map),
    ];

    final (instructions, respond, user, toolHistory) = switch (feature) {
      AiFeature.assist => (
        assistInstructions,
        _assistRespond,
        'Today is $today. $language\n'
            '<calculators>${jsonEncode(payload['calculators'])}</calculators>\n'
            '<history>${jsonEncode(history)}</history>\n\n'
            'User: ${payload['question']}',
        history,
      ),
      AiFeature.insights => (
        insightsInstructions,
        _insightsRespond,
        'Today is $today. $language\n<history>${jsonEncode(history)}</history>',
        history,
      ),
      AiFeature.explain => (
        explainInstructions,
        _explainRespond,
        '$language\n'
            'Formula: ${calculatorFormulas[(payload['calculation'] as Map)['calculator']] ?? '(use the inputs and results shown)'}\n'
            '<calculation>${jsonEncode(payload['calculation'])}</calculation>',
        [Map<String, Object>.from(payload['calculation']! as Map)],
      ),
    };

    final request = GeminiRequest(
      model: model,
      instructions: instructions,
      functions: [_aggregate, _compute, respond],
    );
    final contents = <Content>[Content.text(user)];

    for (var round = 0; round < _maxRounds; round++) {
      final GenerateContentResponse response;
      try {
        response = await _generate(request, List.of(contents));
      } on QuotaExceeded {
        throw const AiException(AiErrorCode.busy);
      } on UnsupportedUserLocation {
        throw const AiException(AiErrorCode.unavailable);
      } on ServiceApiNotEnabled {
        throw const AiException(AiErrorCode.unavailable);
      } on SocketException {
        throw const AiException(AiErrorCode.offline);
      } on FirebaseAIException catch (e) {
        debugPrint('Gemini error: $e');
        throw const AiException(AiErrorCode.generic);
      }

      if (response.promptFeedback?.blockReason != null) {
        throw const AiException(AiErrorCode.refused);
      }
      final candidate = response.candidates.firstOrNull;
      if (candidate == null) throw const AiException(AiErrorCode.generic);
      if (const {
        FinishReason.safety,
        FinishReason.prohibitedContent,
        FinishReason.blocklist,
        FinishReason.spii,
        FinishReason.recitation,
      }.contains(candidate.finishReason)) {
        throw const AiException(AiErrorCode.refused);
      }

      final calls = response.functionCalls.toList();
      if (calls.isEmpty) throw const AiException(AiErrorCode.generic);
      final answer = calls.where((c) => c.name == 'respond').firstOrNull;
      if (answer != null) {
        return AiCallResult(Map<String, dynamic>.from(answer.args));
      }

      // Keep the model's turn as-is (it carries thought signatures).
      contents
        ..add(candidate.content)
        ..add(
          Content.functionResponses([
            for (final call in calls)
              FunctionResponse(
                call.name,
                runAiTool(call.name, call.args, toolHistory),
                id: call.id,
              ),
          ]),
        );
    }
    throw const AiException(AiErrorCode.generic);
  }

  static final _aggregate = FunctionDeclaration(
    'aggregate',
    "Exact total / average / minimum / maximum / count of one number across the user's saved "
        'calculations. Matches a field by its label (an input or result label exactly as shown '
        'in the history). Optionally restrict to one calculator and/or a date range '
        '(inclusive, YYYY-MM-DD).',
    parameters: {
      'op': Schema.enumString(
        enumValues: ['sum', 'avg', 'min', 'max', 'count'],
      ),
      'label': Schema.string(
        description: 'Input or result label, e.g. "You save".',
      ),
      'calculator': Schema.string(
        description: 'Calculator id from the history (e.g. "discount"), or null for all.',
        nullable: true,
      ),
      'from': Schema.string(
        description: 'Start date YYYY-MM-DD, or null.',
        nullable: true,
      ),
      'to': Schema.string(
        description: 'End date YYYY-MM-DD, or null.',
        nullable: true,
      ),
    },
    optionalParameters: ['calculator', 'from', 'to'],
  );

  static final _compute = FunctionDeclaration(
    'compute',
    'Exactly evaluates an arithmetic expression with numbers, + - * / ^ and parentheses, '
        'e.g. "(1250 - 980) / 980 * 100". Use it for every calculation you need.',
    parameters: {'expression': Schema.string()},
  );

  static final _assistRespond = FunctionDeclaration(
    'respond',
    'Give the final answer to the user.',
    parameters: {
      'kind': Schema.enumString(enumValues: ['answer', 'calculation']),
      'answer': Schema.string(),
      'steps': Schema.array(
        items: Schema.object(
          properties: {
            'calculator': Schema.string(),
            'inputs': Schema.array(
              items: Schema.object(
                properties: {
                  'value': Schema.number(nullable: true),
                  'from_step': Schema.integer(nullable: true),
                  'result_index': Schema.integer(nullable: true),
                },
                optionalProperties: ['value', 'from_step', 'result_index'],
              ),
            ),
          },
        ),
      ),
    },
  );

  static final _insightsRespond = FunctionDeclaration(
    'respond',
    'Give the final insights to the user.',
    parameters: {
      'insights': Schema.array(
        items: Schema.object(
          properties: {'title': Schema.string(), 'text': Schema.string()},
        ),
      ),
    },
  );

  static final _explainRespond = FunctionDeclaration(
    'respond',
    'Give the final explanation to the user.',
    parameters: {'explanation': Schema.string()},
  );
}

/// One Gemini turn: the request settings plus the conversation so far.
/// Replaceable in tests.
typedef GeminiGenerate = Future<GenerateContentResponse> Function(
  GeminiRequest request,
  List<Content> contents,
);

/// What [GeminiBackend] needs to build a model.
class GeminiRequest {
  const GeminiRequest({
    required this.model,
    required this.instructions,
    required this.functions,
  });

  final String model;
  final String instructions;
  final List<FunctionDeclaration> functions;
}

// ---------------------------------------------------------------------------
// Claude through the Cloudflare Worker in server/ai-worker (optional upgrade).

class WorkerBackend implements AiBackend {
  WorkerBackend({required this.endpoint, http.Client? client})
    : _client = client ?? http.Client();

  final String endpoint;
  final http.Client _client;

  @override
  bool get enforcesQuota => true;

  @override
  Future<AiCallResult> run(
    AiFeature feature,
    Map<String, Object?> payload,
  ) async {
    final json = await _post('/v1/${feature.name}', payload);
    return AiCallResult(
      json['data'] is Map
          ? Map<String, dynamic>.from(json['data'] as Map)
          : const {},
      quota: _quota(json),
    );
  }

  @override
  Future<AiQuota> reward(Map<String, Object?> identity) async =>
      _quota(await _post('/v1/reward', identity))!;

  @override
  Future<AiQuota> quota(Map<String, Object?> identity) async =>
      _quota(await _post('/v1/quota', identity))!;

  AiQuota? _quota(Map<String, dynamic> json) {
    final q = json['quota'];
    return q is Map ? AiQuota.fromJson(Map<String, dynamic>.from(q)) : null;
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, Object?> body,
  ) async {
    String? appCheckToken;
    if (Firebase.apps.isNotEmpty) {
      try {
        appCheckToken = await FirebaseAppCheck.instance.getToken();
      } catch (e) {
        debugPrint('App Check token unavailable: $e');
      }
    }

    final http.Response response;
    try {
      response = await _client
          .post(
            Uri.parse('$endpoint$path'),
            headers: {
              'content-type': 'application/json',
              'X-Firebase-AppCheck': ?appCheckToken,
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 45));
    } on SocketException {
      throw const AiException(AiErrorCode.offline);
    } on TimeoutException {
      throw const AiException(AiErrorCode.offline);
    } on http.ClientException {
      throw const AiException(AiErrorCode.offline);
    }

    final Map<String, dynamic> json;
    try {
      json = Map<String, dynamic>.from(jsonDecode(response.body) as Map);
    } catch (_) {
      throw const AiException(AiErrorCode.generic);
    }
    if (json['ok'] == true) return json;
    throw AiException(switch (json['error']) {
      'quota' || 'no_rewards_left' => AiErrorCode.quota,
      'busy' => AiErrorCode.busy,
      'refused' => AiErrorCode.refused,
      _ => AiErrorCode.generic,
    }, quota: _quota(json));
  }
}
