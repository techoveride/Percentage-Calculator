import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ads/anchored_adaptive_ad.dart';
import '../ai/ai_config.dart';
import '../ai/explain_sheet.dart';
import '../analytics/analytics.dart';
import '../history/history_store.dart';
import '../l10n/app_localizations.dart';
import '../launch/home_widget_service.dart';
import '../model/calculator_definition.dart';
import '../review/review_prompt.dart';
import '../util/app_links.dart';
import '../util/calculations.dart';
import '../util/core_methods.dart';

/// The screen for any calculator: inputs, live results, copy, share, history.
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    super.key,
    required this.kind,
    this.initialValues,
    this.source = 'home',
  });

  final CalculatorKind kind;

  /// Inputs to restore, e.g. when reopening a calculation from history.
  final List<double>? initialValues;

  /// Where the user came from (home, history, widget, shortcut) — analytics.
  final String source;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <TextEditingController>[];
  final _focusNodes = <FocusNode>[];
  late AppLocalizations _l;
  late CalculatorDefinition _def;
  late String _localeTag;
  List<CalcResult>? _results;
  List<double>? _lastSaved;
  bool _showErrors = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _l = AppLocalizations.of(context);
    _def = widget.kind.definition(_l);
    _localeTag = Localizations.localeOf(context).toLanguageTag();
    if (_controllers.isEmpty) {
      Analytics.calculatorOpened(widget.kind, source: widget.source);
      final initial = widget.initialValues;
      for (var i = 0; i < _def.fields.length; i++) {
        final text = initial != null && i < initial.length
            ? formatInput(initial[i])
            : '';
        _controllers.add(TextEditingController(text: text));
        _focusNodes.add(FocusNode());
      }
      _lastSaved = initial;
    }
    _recalculate(notify: false);
  }

  @override
  void dispose() {
    // Keep what the user worked out even if they never pressed Calculate.
    _saveToHistory();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String? _validate(int index, String? text) {
    final field = _def.fields[index];
    if (text == null || text.trim().isEmpty) return _l.errorRequired;
    final value = parseNumber(text);
    if (value == null) return _l.errorInvalidNumber;
    if (!field.allowNegative && value < 0) return _l.errorNegative;
    if (field.wholeNumber && value != value.roundToDouble()) {
      return _l.errorWholeNumber;
    }
    return field.validate?.call(value);
  }

  /// Parsed inputs, or null if any input is missing or invalid.
  List<double>? _values() {
    final values = <double>[];
    for (var i = 0; i < _controllers.length; i++) {
      if (_validate(i, _controllers[i].text) != null) return null;
      values.add(parseNumber(_controllers[i].text)!);
    }
    return values;
  }

  void _recalculate({bool notify = true}) {
    final values = _values();
    final results = values == null ? null : _def.calculate(values);
    if (notify) {
      setState(() => _results = results);
    } else {
      _results = results;
    }
  }

  void _saveToHistory() {
    final values = _values();
    if (values == null || _results == null) return;
    final last = _lastSaved;
    if (last != null && _sameValues(last, values)) return;
    _lastSaved = values;
    HistoryStore.instance.add(widget.kind, values);

    // Uses cached locale/strings: this also runs from dispose().
    final headline = _results!.first;
    HomeWidgetService.updateLastResult(
      title: '${_def.title} · ${headline.label}',
      value:
          '${formatNumber(headline.value, locale: _localeTag)}${headline.suffix}',
      kind: widget.kind,
      inputs: values,
    );
  }

  static bool _sameValues(List<double> a, List<double> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  /// Explicit calculate: shows errors, hides the keyboard, saves to history.
  bool _submit() {
    setState(() => _showErrors = true);
    if (!_formKey.currentState!.validate()) return false;
    FocusScope.of(context).unfocus();
    _recalculate();
    if (_results == null) return false;
    _saveToHistory();
    Analytics.calculation(widget.kind);
    ReviewPrompt.recordSuccess();
    return true;
  }

  void _reset() {
    for (final c in _controllers) {
      c.clear();
    }
    setState(() {
      _showErrors = false;
      _results = null;
    });
    _formKey.currentState!.reset();
    _focusNodes.first.requestFocus();
  }

  void _share() {
    if (!_submit()) return;
    final values = _values()!;
    final lines = <String>[
      _def.title,
      for (var i = 0; i < values.length; i++)
        '${_def.fields[i].label}: '
            '${formatLocalized(context, values[i], suffix: _def.fields[i].suffix ?? '')}',
      '',
      for (final r in _results!)
        '${r.label}: ${formatLocalized(context, r.value, suffix: r.suffix)}',
      '',
      '${_l.sharedFrom} — ${AppLinks.playStoreUrl}',
    ];
    Analytics.shareResult(widget.kind);
    AppLinks.share(lines.join('\n'), subject: _def.title);
  }

  void _copy(CalcResult result) {
    Clipboard.setData(ClipboardData(text: formatInput(result.value)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(_l.copied(result.label))));
  }

  @override
  Widget build(BuildContext context) {
    final lastIndex = _def.fields.length - 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(_def.title),
        actions: [
          IconButton(
            tooltip: _l.shareResultTooltip,
            onPressed: _results == null ? null : _share,
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          autovalidateMode: _showErrors
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (var i = 0; i < _def.fields.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _input(i, isLast: i == lastIndex),
                ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      label: Text(_l.reset),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.calculate_outlined),
                      label: Text(_l.calculate),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _results == null
                    ? const SizedBox.shrink()
                    : _ResultsCard(
                        results: _results!,
                        onCopy: _copy,
                        onExplain: AiConfig.enabled.value
                            ? () => showExplainSheet(
                                context,
                                kind: widget.kind,
                                values: _values()!,
                              )
                            : null,
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AnchoredAdaptiveAd(),
    );
  }

  Widget _input(int index, {required bool isLast}) {
    final field = _def.fields[index];
    return TextFormField(
      controller: _controllers[index],
      focusNode: _focusNodes[index],
      autofocus: index == 0 && widget.initialValues == null,
      keyboardType: TextInputType.numberWithOptions(
        decimal: !field.wholeNumber,
        signed: field.allowNegative,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(field.allowNegative ? r'[0-9.,\-]' : r'[0-9.,]'),
        ),
      ],
      textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
      onChanged: (_) => _recalculate(),
      onFieldSubmitted: (_) {
        if (isLast) {
          _submit();
        } else {
          _focusNodes[index + 1].requestFocus();
        }
      },
      validator: (text) => _validate(index, text),
      decoration: InputDecoration(
        labelText: field.label,
        hintText: _l.hintExample(field.hint),
        suffixText: field.suffix,
        errorMaxLines: 2,
      ),
    );
  }
}

class _ResultsCard extends StatelessWidget {
  const _ResultsCard({
    required this.results,
    required this.onCopy,
    this.onExplain,
  });

  final List<CalcResult> results;
  final void Function(CalcResult) onCopy;

  /// Opens the AI explanation; null when AI is off.
  final VoidCallback? onExplain;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final headline = results.first;
    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headline.label,
              style: text.labelLarge?.copyWith(
                color: scheme.onPrimaryContainer,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    alignment: AlignmentDirectional.centerStart,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      formatLocalized(
                        context,
                        headline.value,
                        suffix: headline.suffix,
                      ),
                      style: text.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                _CopyButton(onPressed: () => onCopy(headline)),
              ],
            ),
            if (results.length > 1) ...[
              Divider(color: scheme.onPrimaryContainer.withValues(alpha: 0.2)),
              for (final r in results.skip(1))
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        r.label,
                        style: text.bodyMedium?.copyWith(
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    Text(
                      formatLocalized(context, r.value, suffix: r.suffix),
                      style: text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                    _CopyButton(onPressed: () => onCopy(r)),
                  ],
                ),
            ],
            if (onExplain != null)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  onPressed: onExplain,
                  icon: Icon(
                    Icons.auto_awesome,
                    size: 18,
                    color: scheme.onPrimaryContainer,
                  ),
                  label: Text(
                    AppLocalizations.of(context).aiExplain,
                    style: TextStyle(color: scheme.onPrimaryContainer),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: MaterialLocalizations.of(context).copyButtonLabel,
      onPressed: onPressed,
      icon: Icon(
        Icons.copy_rounded,
        size: 18,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
