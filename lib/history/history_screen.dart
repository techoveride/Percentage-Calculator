import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../premium/reward_gate.dart';
import '../premium/unlocks.dart';
import '../util/core_methods.dart';
import '../widgets/calculator_page.dart';
import 'history_export.dart';
import 'history_store.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final store = HistoryStore.instance;
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final entries = store.entries;
        return Scaffold(
          appBar: AppBar(
            title: Text(l.historyTitle),
            actions: [
              if (entries.isNotEmpty)
                IconButton(
                  tooltip: l.exportCsv,
                  icon: const Icon(Icons.file_download_outlined),
                  onPressed: () => _export(context),
                ),
              if (entries.isNotEmpty)
                IconButton(
                  tooltip: l.historyClear,
                  icon: const Icon(Icons.delete_sweep_outlined),
                  onPressed: () => _confirmClear(context),
                ),
            ],
          ),
          body: entries.isEmpty
              ? _EmptyHistory(message: l.historyEmpty)
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: entries.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) => _HistoryTile(entry: entries[i]),
                ),
        );
      },
    );
  }

  /// Free with "remove ads"; otherwise one rewarded ad per export.
  Future<void> _export(BuildContext context) async {
    final l = AppLocalizations.of(context);
    if (!Unlocks.instance.freeExport) {
      final earned = await unlockWithRewardedAd(
        context,
        feature: 'export',
        title: l.exportTitle,
        message: l.exportMessage,
      );
      if (!earned) return;
    }
    await shareHistoryCsv(HistoryStore.instance.entries, l);
  }

  Future<void> _confirmClear(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final clear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.historyClear),
        content: Text(l.historyClearConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l.delete),
          ),
        ],
      ),
    );
    if (clear ?? false) await HistoryStore.instance.clear();
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.entry});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final def = entry.kind.definition(l);
    final results = def.calculate(entry.values);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final inputs = [
      for (var i = 0; i < entry.values.length && i < def.fields.length; i++)
        '${def.fields[i].label}: '
            '${formatLocalized(context, entry.values[i], suffix: def.fields[i].suffix ?? '')}',
    ].join(' · ');
    final headline = results == null || results.isEmpty
        ? null
        : '${results.first.label}: '
              '${formatLocalized(context, results.first.value, suffix: results.first.suffix)}';

    return Dismissible(
      key: ObjectKey(entry),
      direction: DismissDirection.endToStart,
      background: Container(
        color: scheme.errorContainer,
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
      ),
      onDismissed: (_) {
        final store = HistoryStore.instance;
        store.remove(entry);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(l.historyDeleted),
              action: SnackBarAction(
                label: l.undo,
                onPressed: () => store.restore(entry),
              ),
            ),
          );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.secondaryContainer,
          foregroundColor: scheme.onSecondaryContainer,
          child: Icon(def.icon),
        ),
        title: Text(def.title),
        subtitle: Text(
          [inputs, ?headline].join('\n'),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: headline != null,
        trailing: Text(
          DateFormat.MMMd(locale).add_Hm().format(entry.time),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CalculatorPage(
              kind: entry.kind,
              initialValues: entry.values,
              source: 'history',
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 64, color: scheme.outline),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
