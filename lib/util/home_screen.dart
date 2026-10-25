import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ads/ads_controller.dart';
import '../ai/ai_config.dart';
import '../ai/ai_screen.dart';
import '../ads/anchored_adaptive_ad.dart';
import '../analytics/analytics.dart';
import '../history/history_screen.dart';
import '../l10n/app_localizations.dart';
import '../launch/app_launch.dart';
import '../launch/home_widget_service.dart';
import '../model/about.dart';
import '../model/calculator_definition.dart';
import '../model/report_bug.dart';
import '../premium/premium_controller.dart';
import '../premium/remove_ads_sheet.dart';
import '../settings/settings_screen.dart';
import '../update/update_checker.dart';
import '../widgets/calculator_page.dart';
import 'app_links.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Locale? _labelsLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      AiConfig.load(); // Remote Config switch for the AI assistant
      AppLaunch.start(); // widget taps + long-press shortcuts
      UpdateChecker.check(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Shortcut and widget texts follow the app language.
    final locale = Localizations.localeOf(context);
    if (locale != _labelsLocale) {
      _labelsLocale = locale;
      final l = AppLocalizations.of(context);
      AppLaunch.updateShortcuts(l);
      HomeWidgetService.updateLabels(l);
    }
  }

  /// Padding + icon (fixed) plus title and subtitle lines (scale with text).
  static double _cardHeight(BuildContext context) {
    final scaled = MediaQuery.textScalerOf(context).scale(88);
    return (92 + scaled).clamp(180, 400).toDouble();
  }

  void _openHistory() {
    Analytics.historyOpened();
    _open(const HistoryScreen());
  }

  void _open(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.homeTitle),
          actions: [
            ValueListenableBuilder<bool>(
              valueListenable: AiConfig.enabled,
              builder: (_, enabled, _) => enabled
                  ? IconButton(
                      tooltip: l.aiTitle,
                      icon: const Icon(Icons.auto_awesome),
                      onPressed: () => _open(const AiScreen()),
                    )
                  : const SizedBox.shrink(),
            ),
            IconButton(
              tooltip: l.menuHistory,
              icon: const Icon(Icons.history),
              onPressed: _openHistory,
            ),
          ],
        ),
        drawer: _buildDrawer(l),
        body: SafeArea(
          top: false,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              // Room for a 2-line title and 2-line subtitle, growing with the
              // phone's text size so larger fonts never overflow the card.
              mainAxisExtent: _cardHeight(context),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: CalculatorKind.values.length,
            itemBuilder: (context, i) {
              final kind = CalculatorKind.values[i];
              return _CalculatorCard(
                definition: kind.definition(l),
                onTap: () => _open(CalculatorPage(kind: kind)),
              );
            },
          ),
        ),
        bottomNavigationBar: const AnchoredAdaptiveAd(),
      ),
    );
  }

  Widget _buildDrawer(AppLocalizations l) {
    final scheme = Theme.of(context).colorScheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Sized by its content (DrawerHeader has a fixed height that
          // overflows on narrow phones and with larger text).
          Container(
            color: scheme.primaryContainer,
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.paddingOf(context).top + 16,
              16,
              16,
            ),
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset('images/main_logo.png'),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l.appTitle,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(color: scheme.onPrimaryContainer),
                ),
                Text(
                  'Techoveride',
                  style: TextStyle(color: scheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: AiConfig.enabled,
            builder: (_, enabled, _) => enabled
                ? _drawerItem(
                    Icons.auto_awesome,
                    l.aiTitle,
                    () => _open(const AiScreen()),
                  )
                : const SizedBox.shrink(),
          ),
          _drawerItem(Icons.history, l.menuHistory, _openHistory),
          _drawerItem(
            Icons.settings_outlined,
            l.menuSettings,
            () => _open(const SettingsScreen()),
          ),
          ListenableBuilder(
            listenable: PremiumController.instance,
            builder: (_, _) => PremiumController.instance.isPremium
                ? const SizedBox.shrink()
                : _drawerItem(
                    Icons.block,
                    l.premiumTitle,
                    () => showRemoveAdsSheet(context),
                  ),
          ),
          const Divider(),
          _drawerItem(Icons.share_outlined, l.menuShareApp, () {
            Analytics.shareApp();
            AppLinks.shareApp(l.shareAppText(AppLinks.playStoreUrl));
          }),
          _drawerItem(Icons.star_outline, l.menuRateApp, AppLinks.rateApp),
          _drawerItem(
            Icons.bug_report_outlined,
            l.menuReportBug,
            () => _open(const ReportBug()),
          ),
          const Divider(),
          ValueListenableBuilder<bool>(
            valueListenable: AdsController.instance.privacyOptionsRequired,
            builder: (_, required, _) => required
                ? _drawerItem(
                    Icons.privacy_tip_outlined,
                    l.menuPrivacySettings,
                    AdsController.instance.showPrivacyOptions,
                  )
                : const SizedBox.shrink(),
          ),
          if (AppLinks.privacyPolicyUrl.isNotEmpty)
            _drawerItem(
              Icons.policy_outlined,
              l.menuPrivacyPolicy,
              AppLinks.openPrivacyPolicy,
            ),
          _drawerItem(
            Icons.system_update_outlined,
            l.menuCheckUpdates,
            () => UpdateChecker.checkManually(context),
          ),
          _drawerItem(
            Icons.info_outline,
            l.menuAbout,
            () => _open(const About()),
          ),
          _drawerItem(Icons.exit_to_app, l.menuExit, _confirmExit),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop(); // close the drawer
        onTap();
      },
    );
  }

  Future<void> _confirmExit() async {
    final l = AppLocalizations.of(context);
    final exit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.exit_to_app),
        title: Text(l.exitTitle),
        content: Text(l.exitMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l.no),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l.yes),
          ),
        ],
      ),
    );
    if (exit ?? false) await SystemNavigator.pop();
  }
}

class _CalculatorCard extends StatelessWidget {
  const _CalculatorCard({required this.definition, required this.onTap});

  final CalculatorDefinition definition;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                foregroundColor: scheme.onPrimaryContainer,
                child: Icon(definition.icon),
              ),
              const Spacer(),
              Text(
                definition.title,
                style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                definition.subtitle,
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
