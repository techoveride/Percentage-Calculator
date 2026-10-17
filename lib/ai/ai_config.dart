import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../remote/remote_settings.dart';

/// AI assistant switches, controlled from Firebase Remote Config so they can
/// change without an app update (see [RemoteSettings]):
/// - `ai_enabled`: show the assistant (off until AI Logic is set up).
/// - `ai_provider`: `gemini` (default, free) or `worker` (Claude, paid).
class AiConfig {
  AiConfig._();

  /// Whether AI features are shown. Updated after Remote Config loads.
  static final ValueNotifier<bool> enabled = ValueNotifier(false);

  static bool get usesWorker => RemoteSettings.instance.aiProvider == 'worker';
  static String get geminiModel => RemoteSettings.instance.aiModel;
  static String get workerEndpoint => RemoteSettings.instance.aiEndpoint;

  /// Most recent calculations sent with a question.
  static const maxHistory = 100;

  /// Reads Remote Config and updates [enabled]. Safe to call repeatedly.
  static Future<void> load() async {
    await RemoteSettings.instance.fetch();
    final settings = RemoteSettings.instance;
    final ready = usesWorker
        ? workerEndpoint.isNotEmpty
        : Firebase.apps.isNotEmpty;
    enabled.value = settings.aiEnabled && ready;
  }
}
