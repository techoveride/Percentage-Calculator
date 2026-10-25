import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ads/rewarded_ad_manager.dart';
import '../l10n/app_localizations.dart';
import 'ad_free.dart';
import 'premium_controller.dart';

/// Opens the "Remove ads" options (from the drawer).
Future<void> showRemoveAdsSheet(BuildContext context) {
  RewardedAdManager.instance.preload();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: RemoveAdsOptions(),
      ),
    ),
  );
}

/// The ways to remove ads: a 24-hour pass for watching a video, or the
/// one-time purchase. Buttons wrap onto new lines on narrow screens.
class RemoveAdsOptions extends StatefulWidget {
  const RemoveAdsOptions({super.key, this.onPrimaryContainer = false});

  /// Use the "on secondary container" colours (inside the Settings card).
  final bool onPrimaryContainer;

  @override
  State<RemoveAdsOptions> createState() => _RemoveAdsOptionsState();
}

class _RemoveAdsOptionsState extends State<RemoveAdsOptions> {
  bool _watching = false;

  @override
  void initState() {
    super.initState();
    RewardedAdManager.instance.preload();
  }

  Future<void> _watchForPass() async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _watching = true);
    final outcome = await RewardedAdManager.instance.show();
    if (mounted) setState(() => _watching = false);
    if (outcome == RewardOutcome.earned) {
      await AdFreeController.instance.grantDayPass();
      messenger.showSnackBar(SnackBar(content: Text(l.adPassGranted)));
    } else if (outcome == RewardOutcome.unavailable) {
      messenger.showSnackBar(SnackBar(content: Text(l.adNotReady)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final fg = widget.onPrimaryContainer
        ? scheme.onSecondaryContainer
        : scheme.onSurface;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return ListenableBuilder(
      listenable: AdFreeController.instance,
      builder: (context, _) {
        final premium = PremiumController.instance;
        final adFree = AdFreeController.instance;

        if (premium.isPremium) {
          return Row(
            children: [
              Icon(Icons.verified, color: scheme.tertiary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(l.premiumActive, style: TextStyle(color: fg)),
              ),
            ],
          );
        }

        final price = premium.price;
        final passUntil = adFree.passUntil;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.block, color: fg),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.premiumTitle,
                    style: text.titleMedium?.copyWith(color: fg),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(l.premiumDescription, style: TextStyle(color: fg)),
            if (passUntil != null) ...[
              const SizedBox(height: 12),
              Chip(
                avatar: const Icon(Icons.timer_outlined, size: 18),
                label: Text(
                  l.adPassActive(
                    DateFormat.E(locale).add_jm().format(passUntil),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (price != null)
                  FilledButton(
                    onPressed: premium.purchasePending ? null : premium.buy,
                    child: premium.purchasePending
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            l.premiumBuy(price),
                            textAlign: TextAlign.center,
                          ),
                  ),
                FilledButton.tonalIcon(
                  onPressed: _watching ? null : _watchForPass,
                  // Inside the Settings card the default tonal colour is the
                  // card's own colour, so use the surface colour there.
                  style: widget.onPrimaryContainer
                      ? FilledButton.styleFrom(
                          backgroundColor: scheme.surface,
                          foregroundColor: scheme.primary,
                        )
                      : null,
                  icon: const Icon(Icons.ondemand_video_outlined),
                  label: Text(l.adPassWatch, textAlign: TextAlign.center),
                ),
                if (price != null)
                  TextButton(
                    onPressed: premium.restore,
                    child: Text(l.restorePurchases),
                  ),
              ],
            ),
            if (price == null) ...[
              const SizedBox(height: 8),
              Text(
                l.purchaseUnavailable,
                style: text.bodySmall?.copyWith(color: fg),
              ),
            ],
          ],
        );
      },
    );
  }
}
