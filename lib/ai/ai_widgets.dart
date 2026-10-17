import 'package:flutter/material.dart';

import '../ads/rewarded_ad_manager.dart';
import '../analytics/analytics.dart';
import '../l10n/app_localizations.dart';
import '../premium/premium_controller.dart';
import '../settings/settings_screen.dart';
import '../util/app_links.dart';
import 'ai_service.dart';

/// Asks once for permission to send questions and history to the AI service.
Future<bool> ensureAiConsent(BuildContext context) async {
  final service = AiService.instance;
  if (await service.hasConsent()) return true;
  if (!context.mounted) return false;
  final l = AppLocalizations.of(context);
  final agreed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.auto_awesome),
      title: Text(l.aiConsentTitle),
      content: Text(l.aiConsentMessage),
      actions: [
        TextButton(
          onPressed: () => AppLinks.openPrivacyPolicy(),
          child: Text(l.menuPrivacyPolicy),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l.aiConsentAgree),
        ),
      ],
    ),
  );
  if (agreed ?? false) await service.giveConsent();
  return agreed ?? false;
}

String aiErrorMessage(AppLocalizations l, Object error) {
  final code = error is AiException ? error.code : AiErrorCode.generic;
  return switch (code) {
    AiErrorCode.offline => l.aiErrorOffline,
    AiErrorCode.quota => l.aiQuotaReached,
    AiErrorCode.busy => l.aiErrorBusy,
    AiErrorCode.refused => l.aiErrorRefused,
    AiErrorCode.unavailable => l.aiErrorUnavailable,
    AiErrorCode.generic => l.aiErrorGeneric,
  };
}

/// Play policy: users must be able to report offensive AI output.
Future<void> reportAiAnswer({
  required String question,
  required String answer,
}) {
  return AppLinks.email(
    subject: 'Percentage Calculator - AI answer report',
    body:
        'I want to report this AI answer:\n\n'
        'Question: $question\n\nAnswer: $answer\n\nReason: ',
  );
}

/// "You've used today's questions" with the two ways to get more.
class AiQuotaCard extends StatelessWidget {
  const AiQuotaCard({super.key, required this.quota});

  final AiQuota quota;

  Future<void> _watchAd(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final outcome = await RewardedAdManager.instance.show();
    if (outcome != RewardOutcome.earned) {
      if (outcome == RewardOutcome.unavailable) {
        messenger.showSnackBar(SnackBar(content: Text(l.adNotReady)));
      }
      return;
    }
    Analytics.rewardEarned('ai');
    try {
      await AiService.instance.claimReward();
      messenger.showSnackBar(SnackBar(content: Text(l.aiBonusAdded)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(aiErrorMessage(l, e))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final premium = PremiumController.instance.isPremium;
    return Card(
      color: scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l.aiQuotaReached,
              style: TextStyle(color: scheme.onSecondaryContainer),
            ),
            if (!premium && quota.rewardsLeft > 0) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _watchAd(context),
                icon: const Icon(Icons.ondemand_video_outlined),
                label: Text(l.aiWatchAdMore),
              ),
            ],
            if (!premium) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
                icon: const Icon(Icons.block),
                label: Text(l.aiPremiumMore),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
