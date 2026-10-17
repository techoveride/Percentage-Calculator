import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../l10n/app_localizations.dart';
import '../util/app_links.dart';
import '../util/core_methods.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final features = [
      (Icons.calculate_outlined, l.featCalculators, l.featCalculatorsDesc),
      (Icons.bolt_outlined, l.featInstant, l.featInstantDesc),
      (Icons.history, l.featHistory, l.featHistoryDesc),
      (Icons.widgets_outlined, l.featWidget, l.featWidgetDesc),
      (Icons.palette_outlined, l.featStyle, l.featStyleDesc),
      (Icons.translate, l.featLanguages, appLanguages.values.join(', ')),
      (Icons.lock_outline, l.featPrivate, l.featPrivateDesc),
      (Icons.block, l.featAdFree, l.featAdFreeDesc),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.menuAbout)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset('images/logo.png', width: 96, height: 96),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l.appTitle,
            style: text.headlineSmall,
            textAlign: TextAlign.center,
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (_, snapshot) => Text(
              l.aboutVersion(snapshot.data?.version ?? ''),
              style: text.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Text(l.aboutDescription, style: text.bodyLarge),
          const SizedBox(height: 24),
          Text(l.featuresTitle, style: text.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                for (final (icon, title, description) in features)
                  _FeatureTile(
                    icon: icon,
                    title: title,
                    description: description,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (AppLinks.privacyPolicyUrl.isNotEmpty)
            OutlinedButton.icon(
              onPressed: AppLinks.openPrivacyPolicy,
              icon: const Icon(Icons.policy_outlined),
              label: Text(l.menuPrivacyPolicy),
            ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        child: Icon(icon, size: 20),
      ),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
