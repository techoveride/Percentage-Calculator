import 'package:flutter/material.dart';

import '../analytics/analytics.dart';
import '../l10n/app_localizations.dart';
import '../model/calculator_definition.dart';
import 'ai_service.dart';
import 'ai_widgets.dart';

/// Opens the "How it's calculated" sheet for a calculation (asks for AI
/// consent first).
Future<void> showExplainSheet(
  BuildContext context, {
  required CalculatorKind kind,
  required List<double> values,
}) async {
  if (!await ensureAiConsent(context) || !context.mounted) return;
  Analytics.aiExplain(kind);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ExplainSheet(kind: kind, values: values),
  );
}

class _ExplainSheet extends StatefulWidget {
  const _ExplainSheet({required this.kind, required this.values});

  final CalculatorKind kind;
  final List<double> values;

  @override
  State<_ExplainSheet> createState() => _ExplainSheetState();
}

class _ExplainSheetState extends State<_ExplainSheet> {
  Future<String>? _explanation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _explanation ??= AiService.instance.explain(
      widget.kind,
      widget.values,
      AppLocalizations.of(context),
      Localizations.localeOf(context).languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final title = widget.kind.definition(l).title;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: FutureBuilder<String>(
          future: _explanation,
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: scheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${l.aiExplainTitle} · $title',
                        style: text.titleMedium,
                      ),
                    ),
                    if (snapshot.hasData)
                      IconButton(
                        tooltip: l.aiReport,
                        icon: const Icon(Icons.flag_outlined, size: 20),
                        onPressed: () => reportAiAnswer(
                          question: '${l.aiExplain}: $title ${widget.values}',
                          answer: snapshot.data!,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                if (snapshot.connectionState != ConnectionState.done)
                  const LinearProgressIndicator()
                else if (snapshot.hasError)
                  Text(
                    aiErrorMessage(l, snapshot.error!),
                    style: TextStyle(color: scheme.error),
                  )
                else
                  Text(snapshot.data ?? '', style: text.bodyLarge),
                const SizedBox(height: 16),
                Text(
                  l.aiDisclaimer,
                  style: text.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
