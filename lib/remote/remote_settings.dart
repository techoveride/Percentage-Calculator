import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

/// Firebase Remote Config (project "percalculator"), fetched once per launch.
/// Edit values in the console or in firebase/remoteconfig.template.json and
/// run `firebase deploy --only remoteconfig --project percalculator`.
///
/// | key                   | type    | meaning                                              |
/// |-----------------------|---------|------------------------------------------------------|
/// | `min_version_code`    | Number  | builds below this must update (blocking dialog)      |
/// | `latest_version_code` | Number  | builds below this are offered an update              |
/// | `update_message`      | String  | optional custom update text                          |
/// | `update_url`          | String  | optional store link; defaults to the Play Store      |
/// | `ai_enabled`          | Boolean | shows the AI assistant (turn on after setting it up) |
/// | `ai_provider`         | String  | `gemini` (Firebase AI Logic) or `worker` (Claude)    |
/// | `ai_model`            | String  | Gemini model name for `gemini`                       |
/// | `ai_endpoint`         | String  | Worker URL for `worker` (server/ai-worker)           |
class RemoteSettings {
  RemoteSettings._();

  static final RemoteSettings instance = RemoteSettings._();

  static const defaults = <String, Object>{
    'min_version_code': 0,
    'latest_version_code': 0,
    'update_message': '',
    'update_url': '',
    'ai_enabled': false,
    'ai_provider': 'gemini',
    'ai_model': 'gemini-3.5-flash-lite',
    'ai_endpoint': '',
  };

  Future<bool>? _fetch;

  /// Fetches and activates the latest values (once). Never throws; returns
  /// false if Firebase isn't available.
  Future<bool> fetch() => _fetch ??= _doFetch();

  /// Fetches the newest values now, ignoring the usual 1-hour cache (for a
  /// "Check for updates" tap). Returns false if Firebase is unavailable or
  /// the fetch failed; the previous values stay active.
  Future<bool> refresh() async {
    if (Firebase.apps.isEmpty) return false;
    await fetch(); // defaults + settings
    try {
      final config = FirebaseRemoteConfig.instance;
      await config.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await config.fetchAndActivate();
      return true;
    } catch (e) {
      debugPrint('Remote Config refresh failed: $e');
      return false;
    }
  }

  Future<bool> _doFetch() async {
    if (Firebase.apps.isEmpty) return false;
    try {
      final config = FirebaseRemoteConfig.instance;
      await config.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: kReleaseMode
              ? const Duration(hours: 1)
              : Duration.zero,
        ),
      );
      await config.setDefaults(defaults);
      await config.fetchAndActivate();
      return true;
    } catch (e) {
      debugPrint('Remote Config fetch failed: $e');
      return Firebase.apps.isNotEmpty;
    }
  }

  T _get<T>(String key, T Function(FirebaseRemoteConfig c) read) {
    if (Firebase.apps.isEmpty) return defaults[key] as T;
    try {
      return read(FirebaseRemoteConfig.instance);
    } catch (_) {
      return defaults[key] as T;
    }
  }

  int get minVersionCode =>
      _get('min_version_code', (c) => c.getInt('min_version_code'));
  int get latestVersionCode =>
      _get('latest_version_code', (c) => c.getInt('latest_version_code'));
  String get updateMessage =>
      _get('update_message', (c) => c.getString('update_message'));
  String get updateUrl => _get('update_url', (c) => c.getString('update_url'));
  bool get aiEnabled => _get('ai_enabled', (c) => c.getBool('ai_enabled'));
  String get aiProvider =>
      _get('ai_provider', (c) => c.getString('ai_provider'));
  String get aiModel => _get('ai_model', (c) => c.getString('ai_model'));
  String get aiEndpoint =>
      _get('ai_endpoint', (c) => c.getString('ai_endpoint'));
}
