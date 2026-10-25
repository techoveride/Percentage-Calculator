import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ads/app_open_ad_manager.dart';
import '../analytics/analytics.dart';
import '../l10n/app_localizations.dart';
import '../remote/remote_settings.dart';
import '../util/app_links.dart';

/// App updates driven by Firebase Remote Config — see [RemoteSettings] for
/// the parameters (`min_version_code`, `latest_version_code`, ...).
///
/// "Version code" is the number after `+` in pubspec.yaml (`1.2.0+5` → 5).
class UpdateChecker {
  UpdateChecker._();

  static const _dismissedKey = 'update_dismissed_version';

  static bool _checked = false;

  /// Fetches the config and shows an update dialog if needed. Safe to call
  /// from the home screen's first frame; runs once per app launch.
  static Future<void> check(BuildContext context) async {
    if (_checked) return;
    _checked = true;
    try {
      final settings = RemoteSettings.instance;
      if (!await settings.fetch()) return;

      final info = await PackageInfo.fromPlatform();
      final build = int.tryParse(info.buildNumber) ?? 0;
      final minimum = settings.minVersionCode;
      final latest = settings.latestVersionCode;
      final forced = build < minimum;

      if (!forced) {
        if (build >= latest) return;
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getInt(_dismissedKey) == latest) return; // asked already
      }
      if (!context.mounted) return;

      await _showDialog(
        context,
        forced: forced,
        latest: latest,
        customMessage: settings.updateMessage,
        url: settings.updateUrl,
      );
    } catch (e) {
      debugPrint('Update check failed: $e');
    }
  }

  /// "Check for updates" from the drawer: asks Google Play and Remote Config
  /// now, and always tells the user the outcome.
  static Future<void> checkManually(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final info = await PackageInfo.fromPlatform();
    final build = int.tryParse(info.buildNumber) ?? 0;

    // Google Play knows about every published update, even before Remote
    // Config is raised.
    if (defaultTargetPlatform == TargetPlatform.android && kReleaseMode) {
      try {
        final play = await InAppUpdate.checkForUpdate();
        if (play.updateAvailability == UpdateAvailability.updateAvailable) {
          if (!context.mounted) return;
          await _showDialog(
            context,
            forced: false,
            latest: play.availableVersionCode ?? build + 1,
            customMessage: '',
            url: '',
          );
          return;
        }
      } catch (e) {
        debugPrint('Play update check failed: $e');
      }
    }

    final settings = RemoteSettings.instance;
    final fetched = await settings.refresh();
    if (!context.mounted) return;
    final forced = build < settings.minVersionCode;
    if (forced || build < settings.latestVersionCode) {
      await _showDialog(
        context,
        forced: forced,
        latest: settings.latestVersionCode,
        customMessage: settings.updateMessage,
        url: settings.updateUrl,
      );
      return;
    }
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            fetched ? l.updateUpToDate(info.version) : l.updateCheckFailed,
          ),
        ),
      );
  }

  static Future<void> _showDialog(
    BuildContext context, {
    required bool forced,
    required int latest,
    required String customMessage,
    required String url,
  }) async {
    final l = AppLocalizations.of(context);
    final message = customMessage.isNotEmpty
        ? customMessage
        : (forced ? l.updateRequiredMessage : l.updateAvailableMessage);

    Analytics.updatePrompt(forced: forced);
    final update = await showDialog<bool>(
      context: context,
      barrierDismissible: !forced,
      builder: (context) => PopScope(
        canPop: !forced,
        child: AlertDialog(
          icon: const Icon(Icons.system_update),
          title: Text(forced ? l.updateRequiredTitle : l.updateAvailableTitle),
          content: Text(message),
          actions: [
            if (!forced)
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l.later),
              ),
            FilledButton(
              onPressed: () {
                // A forced dialog stays open; the user comes back to it.
                if (!forced) Navigator.of(context).pop(true);
                Analytics.updateAccepted();
                _startUpdate(url);
              },
              child: Text(l.updateNow),
            ),
          ],
        ),
      ),
    );

    if (update == false) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_dismissedKey, latest);
    }
  }

  /// Uses Google Play's in-app update on Android when Play knows about the
  /// update; otherwise opens the store page.
  static Future<void> _startUpdate(String url) async {
    AppOpenAdManager.instance.skipNextResume();
    if (defaultTargetPlatform == TargetPlatform.android && kReleaseMode) {
      try {
        final info = await InAppUpdate.checkForUpdate();
        if (info.updateAvailability == UpdateAvailability.updateAvailable &&
            info.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
          return;
        }
      } catch (e) {
        debugPrint('Play in-app update unavailable: $e');
      }
    }
    await AppLinks.openStore(url.isEmpty ? null : url);
  }
}
