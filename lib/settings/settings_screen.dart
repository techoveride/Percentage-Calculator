import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../premium/premium_controller.dart';
import '../premium/reward_gate.dart';
import '../premium/unlocks.dart';
import '../util/core_methods.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  StreamSubscription<void>? _failures;

  @override
  void initState() {
    super.initState();
    _failures = PremiumController.instance.purchaseFailures.listen((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).purchaseFailed)),
      );
    });
  }

  @override
  void dispose() {
    _failures?.cancel();
    super.dispose();
  }

  Future<void> _pickColor(int index) async {
    final l = AppLocalizations.of(context);
    if (index != 0 && !Unlocks.instance.colors) {
      final earned = await unlockWithRewardedAd(
        context,
        feature: 'colors',
        title: l.unlockColorsTitle,
        message: l.unlockColorsMessage,
      );
      if (!earned) return;
      await Unlocks.instance.unlockColors();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.colorsUnlocked)));
      }
    }
    await SettingsController.instance.setAccentIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final settings = SettingsController.instance;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          settings,
          PremiumController.instance,
          Unlocks.instance,
        ]),
        builder: (context, _) => ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _PremiumCard(),
            ),
            const SizedBox(height: 16),
            _Header(l.settingsTheme),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: const Icon(Icons.brightness_auto_outlined),
                    label: Text(l.themeSystem),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: const Icon(Icons.light_mode_outlined),
                    label: Text(l.themeLight),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: const Icon(Icons.dark_mode_outlined),
                    label: Text(l.themeDark),
                  ),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (s) => settings.setThemeMode(s.first),
              ),
            ),
            _Header(l.settingsColor),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (var i = 0; i < accentColors.length; i++)
                    _ColorSwatch(
                      color: accentColors[i],
                      selected: settings.accentIndex == i,
                      locked: i != 0 && !Unlocks.instance.colors,
                      onTap: () => _pickColor(i),
                    ),
                ],
              ),
            ),
            const Divider(),
            _Header(l.settingsLanguage, style: text.titleSmall),
            _LanguageTile(
              title: l.languageSystem,
              selected: settings.locale == null,
              onTap: () => settings.setLocale(null),
            ),
            for (final entry in appLanguages.entries)
              _LanguageTile(
                title: entry.value,
                selected: settings.locale?.languageCode == entry.key,
                onTap: () => settings.setLocale(Locale(entry.key)),
              ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.title, {this.style});

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Text(
        title,
        style: style ?? Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final premium = PremiumController.instance;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    if (premium.isPremium) {
      return Card(
        color: scheme.tertiaryContainer,
        child: ListTile(
          leading: Icon(Icons.verified, color: scheme.onTertiaryContainer),
          title: Text(
            l.premiumActive,
            style: TextStyle(color: scheme.onTertiaryContainer),
          ),
        ),
      );
    }

    final price = premium.price;
    return Card(
      color: scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.block, color: scheme.onSecondaryContainer),
                const SizedBox(width: 8),
                Text(
                  l.premiumTitle,
                  style: text.titleMedium?.copyWith(
                    color: scheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l.premiumDescription,
              style: TextStyle(color: scheme.onSecondaryContainer),
            ),
            const SizedBox(height: 12),
            if (price == null)
              Text(
                l.purchaseUnavailable,
                style: text.bodySmall?.copyWith(
                  color: scheme.onSecondaryContainer,
                ),
              )
            else
              Row(
                children: [
                  FilledButton(
                    onPressed: premium.purchasePending ? null : premium.buy,
                    child: premium.purchasePending
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l.premiumBuy(price)),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: premium.restore,
                    child: Text(l.restorePurchases),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.color,
    required this.selected,
    required this.locked,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.onSurface;
    return InkResponse(
      onTap: onTap,
      radius: 28,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selected ? Border.all(color: outline, width: 3) : null,
        ),
        child: selected
            ? const Icon(Icons.check, color: Colors.white)
            : locked
            ? const Icon(Icons.lock_outline, color: Colors.white, size: 18)
            : null,
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: selected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      selected: selected,
      onTap: onTap,
    );
  }
}
