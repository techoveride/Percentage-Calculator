import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../l10n/app_localizations.dart';
import '../util/app_links.dart';

class ReportBug extends StatefulWidget {
  const ReportBug({super.key});

  @override
  State<ReportBug> createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  final _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  Future<void> _sendReport() async {
    final messenger = ScaffoldMessenger.of(context);
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    var version = '';
    try {
      final info = await PackageInfo.fromPlatform();
      version = '${info.version}+${info.buildNumber}';
    } catch (_) {}

    // Kept in English: it goes to the support inbox, not to the user.
    final sent = await AppLinks.email(
      subject: 'Percentage Calculator - Bug report / idea',
      body:
          'Hi Techoveride!\n\n${_reportController.text.trim()}\n\n'
          '---\nApp version: $version\n'
          'Platform: ${defaultTargetPlatform.name}\n'
          'Language: $locale',
    );
    if (!sent) {
      messenger.showSnackBar(
        SnackBar(content: Text(l.reportBugNoEmail(AppLinks.supportEmail))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.menuReportBug)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              l.reportBugIntro,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reportController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: l.reportBugLabel,
                hintText: l.reportBugHint,
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _sendReport,
              icon: const Icon(Icons.send_outlined),
              label: Text(l.reportBugSend),
            ),
          ],
        ),
      ),
    );
  }
}
