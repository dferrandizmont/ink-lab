import 'package:flutter/material.dart';

import '../../../ai/ai.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/ink_sheet.dart';
import '../../../l10n/l10n.dart';

/// Opens the model picker in an [InkSheet].
///
/// With [multi] the sheet edits the fallback list (up to
/// [AiSettings.maxFallbacks]); otherwise it picks the primary text model and
/// closes on selection.
Future<void> showAiModelPicker(
  BuildContext context, {
  required AiSettingsController controller,
  required bool multi,
}) => showInkSheet<void>(
  context: context,
  builder: (BuildContext context) =>
      AiModelPickerSheet(controller: controller, multi: multi),
);

/// The searchable list of models inside the picker sheet.
///
/// Each row shows the model name, its id and a Free/Paid tag. The Free/Paid/Both
/// control filters the list; the search box matches the name and the id. In
/// single mode, an id typed in the search box that is not in the catalog can be
/// used as is (for a model the catalog does not list, or before it is loaded).
class AiModelPickerSheet extends StatefulWidget {
  const AiModelPickerSheet({
    super.key,
    required this.controller,
    required this.multi,
  });

  final AiSettingsController controller;
  final bool multi;

  @override
  State<AiModelPickerSheet> createState() => _AiModelPickerSheetState();
}

class _AiModelPickerSheetState extends State<AiModelPickerSheet> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

  AiSettingsController get _controller => widget.controller;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _matches(AiModelDescriptor model) {
    if (_query.isEmpty) return true;
    return model.name.toLowerCase().contains(_query) ||
        model.id.toLowerCase().contains(_query);
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final double maxListHeight = MediaQuery.sizeOf(context).height * 0.45;
    return ListenableBuilder(
      listenable: _controller,
      builder: (BuildContext context, Widget? child) {
        final List<AiModelDescriptor> visible = _controller.availableModels
            .where(_matches)
            .toList(growable: false);
        final String typed = _search.text.trim();
        final bool offerTyped =
            !widget.multi &&
            typed.isNotEmpty &&
            !_controller.allModels.any((AiModelDescriptor m) => m.id == typed);
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
                child: Text(
                  widget.multi
                      ? context.l10n.settingsAiFallbacksTitle
                      : context.l10n.settingsAiPrimaryModel,
                  style: AppTypography.section.copyWith(color: ink.fg),
                ),
              ),
              if (widget.multi)
                Padding(
                  padding: EdgeInsets.only(top: InkSpacing.group),
                  child: Text(
                    context.l10n.settingsAiFallbacksHint(
                      AiSettings.maxFallbacks,
                    ),
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ),
              SizedBox(height: InkSpacing.block),
              InkSegmented<AiModelFilter>(
                semanticLabel: context.l10n.settingsAiModelsTitle,
                expand: true,
                segments: <InkSegment<AiModelFilter>>[
                  InkSegment<AiModelFilter>(
                    value: AiModelFilter.free,
                    label: context.l10n.settingsAiModelsFilterFree,
                  ),
                  InkSegment<AiModelFilter>(
                    value: AiModelFilter.paid,
                    label: context.l10n.settingsAiModelsFilterPaid,
                  ),
                  InkSegment<AiModelFilter>(
                    value: AiModelFilter.both,
                    label: context.l10n.settingsAiModelsFilterBoth,
                  ),
                ],
                selected: _controller.modelFilter,
                onChanged: _controller.setModelFilter,
              ),
              const SizedBox(height: InkSpacing.buttonGap),
              InkSearchField(
                key: const ValueKey<String>('ai-model-search'),
                controller: _search,
                hintText: context.l10n.settingsAiModelSearchHint,
                onChanged: (String value) =>
                    setState(() => _query = value.trim().toLowerCase()),
                onClear: () => setState(() => _query = ''),
              ),
              const SizedBox(height: InkSpacing.buttonGap),
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxListHeight),
                  child: _buildList(ink, visible, offerTyped ? typed : null),
                ),
              ),
              if (widget.multi) ...<Widget>[
                const SizedBox(height: InkSpacing.block),
                InkButton(
                  key: const ValueKey<String>('ai-model-done'),
                  label: context.l10n.settingsAiModelsDone,
                  expand: true,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(
    InkColors ink,
    List<AiModelDescriptor> visible,
    String? typedId,
  ) {
    // Rows above the catalog: the typed id, the recommended models and the
    // empty-state message. The catalog itself is built lazily below them.
    final List<Widget> head = <Widget>[
      if (typedId != null)
        _ModelRow(
          key: const ValueKey<String>('ai-model-use-typed'),
          title: context.l10n.settingsAiUseTyped(typedId),
          subtitle: null,
          tag: null,
          selected: false,
          enabled: true,
          onTap: () => _pickSingle(typedId),
        ),
      if (_query.isEmpty) ...<Widget>[
        _SectionLabel(context.l10n.settingsAiRecommended),
        for (final String id in <String>[
          AiSettings.recommendedTextModel,
          ...AiSettings.recommendedTextFallbacks,
        ])
          _buildRow(
            key: ValueKey<String>('ai-model-rec-$id'),
            id: id,
            model: _catalogEntry(id),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: InkSpacing.cardV),
          child: Text(
            context.l10n.settingsAiFreeModelsNote,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ),
        if (visible.isNotEmpty) _SectionLabel(context.l10n.settingsAiAllModels),
      ],
      if (visible.isEmpty && typedId == null)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: InkSpacing.block),
          child: Text(
            _controller.modelsLoaded
                ? context.l10n.settingsAiModelsEmpty
                : context.l10n.settingsAiModelsNotLoaded,
            textAlign: TextAlign.center,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ),
    ];
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: head.length + visible.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < head.length) return head[index];
        final AiModelDescriptor model = visible[index - head.length];
        return _buildRow(
          key: ValueKey<String>('ai-model-${model.id}'),
          id: model.id,
          model: model,
        );
      },
    );
  }

  AiModelDescriptor? _catalogEntry(String id) {
    for (final AiModelDescriptor model in _controller.allModels) {
      if (model.id == id) return model;
    }
    return null;
  }

  Widget _buildRow({
    required Key key,
    required String id,
    required AiModelDescriptor? model,
  }) {
    final bool selected = widget.multi
        ? _controller.textFallbacks.contains(id)
        : _controller.textModel == id;
    final bool full =
        widget.multi &&
        !selected &&
        _controller.textFallbacks.length >= AiSettings.maxFallbacks;
    return _ModelRow(
      key: key,
      title: model?.name ?? id,
      subtitle: model == null ? null : id,
      tag: model == null
          ? null
          : model.isFree
          ? context.l10n.settingsAiModelFree
          : context.l10n.settingsAiModelPaid,
      selected: selected,
      enabled: !full,
      onTap: () =>
          widget.multi ? _controller.toggleFallback(id) : _pickSingle(id),
    );
  }

  Future<void> _pickSingle(String id) async {
    await _controller.selectPrimaryModel(id);
    if (!mounted) return;
    await Navigator.of(context).maybePop();
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: InkSpacing.block,
        bottom: InkSpacing.group,
      ),
      child: Text(
        AppTypography.caps(text),
        style: AppTypography.capsStyle.copyWith(color: ink.fg2),
      ),
    );
  }
}

class _ModelRow extends StatelessWidget {
  const _ModelRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final String? tag;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body.copyWith(
                          color: enabled ? ink.fg : ink.fg2,
                        ),
                      ),
                      if (subtitle != null) ...<Widget>[
                        const SizedBox(height: InkSpacing.s4),
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.data.copyWith(color: ink.fg2),
                        ),
                      ],
                    ],
                  ),
                ),
                if (tag != null) ...<Widget>[
                  const SizedBox(width: InkSpacing.buttonGap),
                  Text(
                    AppTypography.caps(tag!),
                    style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                  ),
                ],
                SizedBox(
                  width: 32,
                  child: selected
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: InkIcon(
                            InkIcons.check,
                            size: InkGeometry.mediumIcon,
                            color: ink.action,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
