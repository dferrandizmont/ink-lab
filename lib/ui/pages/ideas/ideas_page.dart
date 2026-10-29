import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/ideas_engine.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/page_header.dart';
import '../../widgets/palette_strip.dart';
import '../palette/palette_draft.dart';
import '../../../l10n/l10n.dart';

/// Composition root above the page, or `null` in isolated previews/tests.
AppScope? _scopeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<AppScope>();

/// The ideas browser.
///
/// Lists the presets of [IdeasEngine] grouped by category, filters them with a
/// search box and shows the selected preset's plan (overview, steps,
/// embellishments and, when the preset is palette-ready, its suggested
/// palette). "Apply to Palette" hands the palette to the Palette page through
/// the shared [paletteDraft] notifier.
class IdeasPage extends StatefulWidget {
  const IdeasPage({super.key});

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('ideas-page');

  @override
  State<IdeasPage> createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _settingsSubscription;
  String _collectionSignature = '';

  MarkerBrand _brand = MarkerBrand.ohuhuOahu;
  List<MarkerColor> _available = const <MarkerColor>[];
  bool _loading = true;

  IdeaCategory? _category;
  String _query = '';
  final TextEditingController _searchController = TextEditingController();

  String? _selectedPresetId;
  IdeaPlan? _plan;
  static const int _paletteSize = 5;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = _scopeOf(context);
    if (scope == null || identical(scope, _scope)) return;
    _scope = scope;
    _settingsSubscription?.cancel();
    _collectionSignature = _signatureOf(scope.settings.state);
    _settingsSubscription = scope.settings.changes.listen(_onSettingsChanged);
    unawaited(_reload());
  }

  @override
  void dispose() {
    _settingsSubscription?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  String _signatureOf(AppSettingsState state) {
    final sets = state.settings.effectiveSetIds().toList()..sort();
    final owned = state.settings.ownedMarkerCodes.toList()..sort();
    return '${state.brand.id}|${sets.join(',')}|${owned.join(',')}';
  }

  void _onSettingsChanged(AppSettingsState state) {
    final signature = _signatureOf(state);
    if (signature == _collectionSignature) return;
    _collectionSignature = signature;
    unawaited(_reload());
  }

  Future<void> _reload() async {
    final scope = _scope;
    if (scope == null) return;
    final brand = scope.settings.brand;
    final settings = scope.settings.settings;
    setState(() => _loading = true);
    List<MarkerColor> catalog;
    try {
      catalog = await scope.markers.loadColors(brand);
    } catch (_) {
      catalog = const <MarkerColor>[];
    }
    if (!mounted) return;
    setState(() {
      _brand = brand;
      _available = paletteCandidateColors(
        colors: catalog,
        brand: brand,
        activeSetIds: settings.effectiveSetIds(),
        ownedMarkerCodes: settings.ownedMarkerCodes,
      );
      _plan = null;
      _loading = false;
    });
  }

  List<IdeaPreset> get _filteredPresets {
    final query = _query.trim().toLowerCase();
    return IdeasEngine.presets.where((IdeaPreset preset) {
      if (_category != null && preset.category != _category) return false;
      if (query.isEmpty) return true;
      return context.l10n.ideaTitle(preset).toLowerCase().contains(query) ||
          context.l10n.ideaSummary(preset).toLowerCase().contains(query);
    }).toList();
  }

  void _selectPreset(IdeaPreset preset) {
    setState(() {
      _selectedPresetId = preset.id;
      _plan = null;
    });
  }

  void _generate(IdeaPreset preset) {
    setState(() {
      _plan = IdeasEngine.generatePlan(preset, _available, _paletteSize);
    });
  }

  void _applyToPalette() {
    final plan = _plan;
    if (plan == null || plan.palette.isEmpty) return;
    paletteDraft.value = <MarkerColor>[
      for (final suggestion in plan.palette) suggestion.color,
    ];
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.ideasPaletteSent(context.l10n.ideaTitle(plan.preset)),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final scope = _scopeOf(context);
    if (scope == null) {
      return Center(
        key: IdeasPage.pageKey,
        child: Text(
          context.l10n.ideasTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }
    if (_loading) {
      return const Center(
        key: IdeasPage.pageKey,
        child: CircularProgressIndicator(),
      );
    }

    final List<IdeaPreset> filtered = _filteredPresets;
    IdeaPreset? selected;
    for (final IdeaPreset preset in filtered) {
      if (preset.id == _selectedPresetId) selected = preset;
    }

    return Column(
      key: IdeasPage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkPageHeader(
          title: context.l10n.ideasTitle,
          subtitle: _available.isEmpty
              ? context.l10n.ideasNoMarkers
              : context.l10n.ideasHeaderSubtitle,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            InkSpacing.pageMargin,
            0,
            InkSpacing.pageMargin,
            InkSpacing.group,
          ),
          child: InkSearchField(
            key: const ValueKey<String>('ideas-search'),
            controller: _searchController,
            hintText: context.l10n.ideasSearchHint,
            semanticLabel: context.l10n.ideasSearchHint,
            onChanged: (String value) => setState(() => _query = value),
          ),
        ),
        _buildCategoryChips(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
              top: InkSpacing.block,
              bottom: InkSpacing.pageBottom,
            ),
            children: <Widget>[
              if (selected != null)
                _inset(_buildSelectedCard(selected))
              else if (filtered.isNotEmpty && _selectedPresetId == null)
                _inset(_Hint(message: context.l10n.ideasSelectHint)),
              if (filtered.isEmpty)
                EmptyState(
                  title: context.l10n.ideasEmptyTitle,
                  message: context.l10n.ideasEmptySearch,
                  actionLabel: context.l10n.ideasClearFilters,
                  onAction: _clearFilters,
                )
              else
                _inset(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      for (final IdeaPreset preset in filtered)
                        _IdeaRow(
                          key: ValueKey<String>('ideas-preset-${preset.id}'),
                          preset: preset,
                          selected: preset.id == _selectedPresetId,
                          onTap: () => _selectPreset(preset),
                        ),
                    ],
                  ),
                  top: selected != null || _selectedPresetId == null
                      ? InkSpacing.block
                      : 0,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _inset(Widget child, {double top = 0}) => Padding(
    padding: EdgeInsets.fromLTRB(InkSpacing.gutter, top, InkSpacing.gutter, 0),
    child: child,
  );

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _category = null;
    });
  }

  Widget _buildCategoryChips() {
    return InkChipRow(
      semanticLabel: context.l10n.ideasCategoriesLabel,
      children: <Widget>[
        InkChip(
          key: const ValueKey<String>('ideas-category-all'),
          label: context.l10n.ideasCategoryAll,
          selected: _category == null,
          onSelected: (_) => setState(() => _category = null),
        ),
        for (final category in IdeaCategory.values)
          InkChip(
            key: ValueKey<String>('ideas-category-${category.name}'),
            label: context.l10n.ideaCategoryLabel(category),
            selected: _category == category,
            onSelected: (_) => setState(() => _category = category),
          ),
      ],
    );
  }

  /// The selected idea: label and type, title, summary, then its plan.
  Widget _buildSelectedCard(IdeaPreset preset) {
    final InkColors ink = InkColors.of(context);
    final IdeaPlan? plan = _plan;
    final bool paletteReady =
        preset.outputMode == IdeaOutputMode.guideAndPalette;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(InkSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppTypography.caps(context.l10n.ideasSelectedLabel),
                    style: AppTypography.capsStyle.copyWith(color: ink.action),
                  ),
                ),
                Text(
                  AppTypography.caps(_typeLabel(context, preset)),
                  style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                ),
              ],
            ),
            const SizedBox(height: InkSpacing.group),
            Semantics(
              header: true,
              child: Text(
                context.l10n.ideaTitle(preset),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sheetTitle.copyWith(color: ink.fg),
              ),
            ),
            const SizedBox(height: InkSpacing.group),
            Text(
              context.l10n.ideaSummary(preset),
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
            const SizedBox(height: InkSpacing.block),
            Align(
              alignment: Alignment.centerLeft,
              child: InkButton(
                key: ValueKey<String>('ideas-generate-${preset.id}'),
                variant: plan == null
                    ? InkButtonVariant.primary
                    : InkButtonVariant.secondary,
                label: paletteReady
                    ? context.l10n.ideasGenerateIdea
                    : context.l10n.ideasShowTechnique,
                onPressed: () => _generate(preset),
              ),
            ),
            if (paletteReady && _available.isEmpty) ...<Widget>[
              const SizedBox(height: InkSpacing.block),
              Text(
                _brand == MarkerBrand.decoTime
                    ? context.l10n.ideasNoMarkersDecoTime
                    : context.l10n.ideasNoMarkersOther,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
            ],
            if (plan != null) ..._buildPlan(plan),
            if (plan != null && plan.palette.isNotEmpty) ...<Widget>[
              const SizedBox(height: InkSpacing.s24),
              Row(
                children: <Widget>[
                  Expanded(
                    child: PaletteStrip(
                      colors: <String>[
                        for (final suggestion in plan.palette)
                          suggestion.color.hex,
                      ],
                      colorHeight: 44,
                    ),
                  ),
                  const SizedBox(width: InkSpacing.buttonGap),
                  InkButton(
                    key: ValueKey<String>('ideas-apply-${preset.id}'),
                    label: context.l10n.ideasApplyButton,
                    trailingIcon: InkIcons.arrowRight,
                    onPressed: _applyToPalette,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPlan(IdeaPlan plan) {
    final InkColors ink = InkColors.of(context);
    final List<String> steps = context.l10n.ideaStepsText(plan.preset.id);
    Widget caps(String text) => Padding(
      padding: const EdgeInsets.only(
        top: InkSpacing.s24,
        bottom: InkSpacing.group,
      ),
      child: Text(
        AppTypography.caps(text),
        style: AppTypography.capsStyle.copyWith(color: ink.fg2),
      ),
    );
    return <Widget>[
      caps(context.l10n.ideasHowToTitle),
      Text(
        context.l10n.ideaOverviewText(plan.preset.id),
        style: AppTypography.secondary.copyWith(color: ink.fg2),
      ),
      const SizedBox(height: InkSpacing.s12),
      for (var index = 0; index < steps.length; index++)
        _StepRow(number: index + 1, text: steps[index]),
      caps(context.l10n.ideasExtraTouchesTitle),
      for (final tip in context.l10n.ideaEmbellishmentsText(plan.preset.id))
        Padding(
          padding: const EdgeInsets.only(bottom: InkSpacing.group),
          child: Text(
            tip,
            style: AppTypography.secondary.copyWith(color: ink.fg),
          ),
        ),
      if (plan.palette.isEmpty)
        Padding(
          padding: const EdgeInsets.only(top: InkSpacing.block),
          child: Text(
            context.l10n.ideasGuideOnlyNote,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        )
      else ...<Widget>[
        caps(context.l10n.ideasSuggestedColorsTitle),
        for (final suggestion in plan.palette)
          _IdeaColorRow(
            color: suggestion.color,
            reason: context.l10n.reasonLabel(suggestion.reason),
          ),
      ],
    ];
  }
}

String _typeLabel(BuildContext context, IdeaPreset preset) =>
    preset.outputMode == IdeaOutputMode.guideOnly
    ? context.l10n.ideasBadgeGuideOnly
    : context.l10n.ideasBadgeGuideAndPalette;

/// A numbered step of a plan.
class _StepRow extends StatelessWidget {
  const _StepRow({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.group),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 12,
            child: Padding(
              padding: const EdgeInsets.only(top: InkSpacing.s2),
              child: Text(
                '$number',
                style: AppTypography.data.copyWith(color: ink.fg2),
              ),
            ),
          ),
          const SizedBox(width: InkSpacing.s12),
          Expanded(
            child: Text(
              text,
              style: AppTypography.secondary.copyWith(color: ink.fg),
            ),
          ),
        ],
      ),
    );
  }
}

/// A hairline-separated list row: type, title and a one-line summary.
class _IdeaRow extends StatelessWidget {
  const _IdeaRow({
    super.key,
    required this.preset,
    required this.selected,
    required this.onTap,
  });

  final IdeaPreset preset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ink.line)),
      ),
      child: Semantics(
        button: true,
        selected: selected,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.cardV),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppTypography.caps(
                    '${context.l10n.ideaCategoryLabel(preset.category)} · ${_typeLabel(context, preset)}',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.capsStyle.copyWith(
                    color: selected ? ink.action : ink.fg2,
                  ),
                ),
                const SizedBox(height: InkSpacing.s4),
                Text(
                  context.l10n.ideaTitle(preset),
                  style: AppTypography.section.copyWith(color: ink.fg),
                ),
                const SizedBox(height: InkSpacing.s4),
                Text(
                  context.l10n.ideaSummary(preset),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A suggested color of an idea, with its role/reason.
class _IdeaColorRow extends StatelessWidget {
  const _IdeaColorRow({required this.color, required this.reason});

  final MarkerColor color;
  final String reason;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      container: true,
      label: '${color.newCode}, ${color.newName}, $reason',
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.only(bottom: InkSpacing.buttonGap),
          child: Row(
            children: <Widget>[
              SwatchBlock(hex: color.hex, size: 36),
              const SizedBox(width: InkSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          color.newCode,
                          style: AppTypography.code.copyWith(color: ink.fg),
                        ),
                        const SizedBox(width: InkSpacing.s8),
                        Expanded(
                          child: Text(
                            color.newName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.secondary.copyWith(
                              color: ink.fg2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: InkSpacing.s4),
                    Text(
                      reason,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.secondary.copyWith(color: ink.fg),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: AppTypography.secondary.copyWith(color: InkColors.of(context).fg2),
    );
  }
}
