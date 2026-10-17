import 'package:flutter/material.dart';

import '../analytics/analytics.dart';
import '../ads/rewarded_ad_manager.dart';
import '../history/history_store.dart';
import '../l10n/app_localizations.dart';
import '../util/core_methods.dart';
import '../widgets/calculator_page.dart';
import 'ai_service.dart';
import 'ai_steps.dart';
import 'ai_widgets.dart';

class _Turn {
  _Turn(this.question);

  final String question;
  AiAnswer? answer;
  List<AiStepResult>? steps;
  bool invalidSteps = false;
  Object? error;
  bool get loading => answer == null && error == null;
}

/// Ask about your history, describe a calculation in words, or get insights.
class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final _turns = <_Turn>[];
  List<AiInsight>? _insights;
  Object? _insightsError;
  bool _insightsLoading = false;

  @override
  void initState() {
    super.initState();
    RewardedAdManager.instance.preload();
    AiService.instance.refreshQuota().catchError((_) {});
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  String get _locale => Localizations.localeOf(context).languageCode;

  Future<void> _send([String? text]) async {
    final question = (text ?? _input.text).trim();
    if (question.isEmpty) return;
    if (!await ensureAiConsent(context) || !mounted) return;
    final l = AppLocalizations.of(context);
    _input.clear();
    FocusScope.of(context).unfocus();
    final turn = _Turn(question);
    setState(() => _turns.add(turn));
    _scrollToEnd();

    try {
      final answer = await AiService.instance.ask(question, l, _locale);
      turn.answer = answer;
      if (answer.steps.isNotEmpty) {
        turn.steps = runSteps(answer.steps, l);
        turn.invalidSteps = turn.steps == null;
      }
      Analytics.aiQuestion(calculation: answer.steps.isNotEmpty);
    } catch (e) {
      turn.error = e;
    }
    if (mounted) setState(() {});
    _scrollToEnd();
  }

  Future<void> _loadInsights() async {
    if (!await ensureAiConsent(context) || !mounted) return;
    final l = AppLocalizations.of(context);
    setState(() {
      _insightsLoading = true;
      _insightsError = null;
    });
    try {
      _insights = await AiService.instance.insights(l, _locale);
      Analytics.aiInsights();
    } catch (e) {
      _insightsError = e;
    }
    if (mounted) setState(() => _insightsLoading = false);
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.aiTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: ValueListenableBuilder<AiQuota?>(
            valueListenable: AiService.instance.quota,
            builder: (_, quota, _) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                quota == null ? '' : l.aiRemaining(quota.remaining),
                style: text.bodySmall,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scroll,
                padding: const EdgeInsets.all(16),
                children: [
                  _insightsCard(l),
                  const SizedBox(height: 16),
                  if (_turns.isEmpty) ...[
                    Text(l.aiWelcome, style: text.bodyLarge),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final s in [
                          l.aiSuggestion1,
                          l.aiSuggestion2,
                          l.aiSuggestion3,
                        ])
                          ActionChip(
                            avatar: const Icon(Icons.auto_awesome, size: 16),
                            label: Text(s),
                            onPressed: () => _send(s),
                          ),
                      ],
                    ),
                  ],
                  for (final turn in _turns) ..._turnWidgets(l, turn),
                  ValueListenableBuilder<AiQuota?>(
                    valueListenable: AiService.instance.quota,
                    builder: (_, quota, _) =>
                        quota != null && quota.remaining <= 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: AiQuotaCard(quota: quota),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Text(
                l.aiDisclaimer,
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      maxLength: 500,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: l.aiHint,
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: l.reportBugSend,
                    onPressed: () => _send(),
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _insightsCard(AppLocalizations l) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final hasHistory = HistoryStore.instance.entries.isNotEmpty;
    final insights = _insights;
    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.insights, color: scheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.aiInsightsTitle,
                    style: text.titleMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
                if (insights != null)
                  IconButton(
                    tooltip: l.aiReport,
                    icon: const Icon(Icons.flag_outlined, size: 20),
                    onPressed: () => reportAiAnswer(
                      question: l.aiInsightsTitle,
                      answer: insights
                          .map((i) => '${i.title}: ${i.text}')
                          .join('\n'),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (!hasHistory)
              Text(
                l.aiInsightsEmpty,
                style: TextStyle(color: scheme.onPrimaryContainer),
              )
            else if (_insightsLoading)
              const LinearProgressIndicator()
            else if (insights != null)
              for (final i in insights)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${i.title}\n',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: i.text),
                      ],
                    ),
                    style: TextStyle(color: scheme.onPrimaryContainer),
                  ),
                )
            else ...[
              if (_insightsError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    aiErrorMessage(l, _insightsError!),
                    style: TextStyle(color: scheme.error),
                  ),
                ),
              FilledButton.tonalIcon(
                onPressed: _loadInsights,
                icon: const Icon(Icons.auto_awesome),
                label: Text(l.aiInsightsButton),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _turnWidgets(AppLocalizations l, _Turn turn) {
    final scheme = Theme.of(context).colorScheme;
    final answer = turn.answer;
    return [
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          margin: const EdgeInsets.only(top: 12, bottom: 8, left: 48),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(turn.question, style: TextStyle(color: scheme.onPrimary)),
        ),
      ),
      if (turn.loading)
        Row(
          children: [
            const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            Text(l.aiThinking),
          ],
        )
      else if (turn.error != null)
        Text(
          aiErrorMessage(l, turn.error!),
          style: TextStyle(color: scheme.error),
        )
      else if (answer != null)
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(answer.text)),
                    IconButton(
                      tooltip: l.aiReport,
                      icon: const Icon(Icons.flag_outlined, size: 20),
                      onPressed: () => reportAiAnswer(
                        question: turn.question,
                        answer: answer.text,
                      ),
                    ),
                  ],
                ),
                if (turn.invalidSteps)
                  Text(l.aiInvalidStep, style: TextStyle(color: scheme.error)),
                for (final (i, step)
                    in (turn.steps ?? const <AiStepResult>[]).indexed)
                  _StepCard(index: i, step: step),
              ],
            ),
          ),
        ),
    ];
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.index, required this.step});

  final int index;
  final AiStepResult step;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final def = step.definition;
    final headline = step.results.first;
    return Card(
      color: scheme.surfaceContainerHigh,
      margin: const EdgeInsets.only(top: 8, right: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(def.icon, size: 18, color: scheme.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${l.aiStep(index + 1)} · ${def.title}',
                    style: text.labelLarge,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CalculatorPage(
                        kind: def.kind,
                        initialValues: step.inputs,
                        source: 'ai',
                      ),
                    ),
                  ),
                  child: Text(l.aiOpenCalculator),
                ),
              ],
            ),
            Text(
              [
                for (var i = 0; i < step.inputs.length; i++)
                  '${def.fields[i].label}: '
                      '${formatLocalized(context, step.inputs[i], suffix: def.fields[i].suffix ?? '')}',
              ].join(' · '),
              style: text.bodySmall,
            ),
            const SizedBox(height: 6),
            Text(
              '${headline.label}: '
              '${formatLocalized(context, headline.value, suffix: headline.suffix)}',
              style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            for (final r in step.results.skip(1).take(1))
              Text(
                '${r.label}: ${formatLocalized(context, r.value, suffix: r.suffix)}',
                style: text.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
