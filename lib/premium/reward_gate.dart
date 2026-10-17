import 'package:flutter/material.dart';

import '../ads/rewarded_ad_manager.dart';
import '../analytics/analytics.dart';
import '../l10n/app_localizations.dart';
import '../settings/settings_screen.dart';

/// Asks the user to watch a rewarded ad for [feature], offering "go ad-free"
/// as the alternative. Returns true when the reward was earned.
Future<bool> unlockWithRewardedAd(
  BuildContext context, {
  required String feature,
  required String title,
  required String message,
}) async {
  final l = AppLocalizations.of(context);
  RewardedAdManager.instance.preload();

  final choice = await showDialog<_Choice>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.ondemand_video_outlined),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(_Choice.premium),
          child: Text(l.premiumTitle),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(_Choice.watch),
          icon: const Icon(Icons.play_arrow),
          label: Text(l.watchAd),
        ),
      ],
    ),
  );
  if (!context.mounted || choice == null) return false;

  if (choice == _Choice.premium) {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
    return false;
  }

  final outcome = await RewardedAdManager.instance.show();
  if (outcome == RewardOutcome.earned) {
    Analytics.rewardEarned(feature);
    return true;
  }
  if (outcome == RewardOutcome.unavailable && context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l.adNotReady)));
  }
  return false;
}

enum _Choice { watch, premium }
