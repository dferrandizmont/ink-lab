import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/ideas_engine.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/palette_strip.dart';
import '../palette/palette_draft.dart';
import 'idea_detail_sheet.dart';

/// Composition root above the page, or `null` in isolated previews/tests.
AppScope? _scopeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<AppScope>();

/// The ideas browser.
///
/// Drawing exercises for alcohol markers, by category, with the idea of the
/// day on top. Every exercise picks its palette from the user's own markers
/// (with real light → dark roles); tapping one opens its detail sheet, and
/// "Use in Palette" hands the palette, roles included, to the Palette page
/// through [paletteDraft] and switches to that tab.
class IdeasPage extends StatefulWidget {
  const IdeasPage({super.key, this.onOpenPalette, this.today});

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('ideas-page');

  /// Opens the Palette tab after a palette was handed over (wired by the app
  /// shell; null in isolated previews and tests).
  final VoidCallback? onOpenPalette;

  /// The day of the "idea of the day"; defaults to now (tests pin it).
  final DateTime? today;

  @override
  State<IdeasPage> createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _settingsSubscription;
  String _collectionSignature = '';

  MarkerBrand _brand = MarkerBrand.ohuhuOahu;
  List<MarkerColor> _available = const <MarkerColor>[];

  /// True while the palette comes from the whole range because the active
  /// brand has no collection configured.
  bool _wholeRange = false;
  bool _loading = true;

  IdeaCategory? _category;
  String _query = '';
  final TextEditingController _searchController = TextEditingController();

  /// Plans with the first pick of markers, one per preset, for the strips.
  final Map<String, IdeaPlan> _plans = <String, IdeaPlan>{};

  /// A new draw of random markers every time the page opens.
  final int _sessionSeed = DateTime.now().millisecondsSinceEpoch & 0x7fffffff;

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
    final bool hasCollection = ownedColors(
      colors: catalog,
      brand: brand,
      ownedSetIds: settings.effectiveSetIds(),
      ownedMarkerCodes: settings.ownedMarkerCodes,
    ).isNotEmpty;
    setState(() {
      _brand = brand;
      _wholeRange = !hasCollection;
      _available = paletteCandidateColors(
        colors: catalog,
        brand: brand,
        activeSetIds: settings.effectiveSetIds(),
        ownedMarkerCodes: settings.ownedMarkerCodes,
      );
      _plans.clear();
      _loading = false;
    });
  }

  /// The first seed of [preset]: random markers change every session, the
  /// others start from the best pick.
  int _seedFor(IdeaPreset preset) =>
      preset.id == 'random_colors' ? _sessionSeed : 0;

  IdeaPlan _planFor(IdeaPreset preset) => _plans.putIfAbsent(
    preset.id,
    () => IdeasEngine.generatePlan(preset, _available, seed: _seedFor(preset)),
  );

  List<IdeaPreset> get _filteredPresets {
    final query = _query.trim().toLowerCase();
    return IdeasEngine.presets.where((IdeaPreset preset) {
      if (_category != null && preset.category != _category) return false;
      if (query.isEmpty) return true;
      return context.l10n.ideaTitle(preset).toLowerCase().contains(query) ||
          context.l10n.ideaSummary(preset).toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _open(IdeaPreset preset) async {
    final IdeaPlan initial = _planFor(preset);
    final IdeaPlan? applied = await showInkSheet<IdeaPlan>(
      context: context,
      builder: (BuildContext context) => IdeaDetailSheet(
        initial: initial,
        candidates: _available,
        brand: _brand,
      ),
    );
    if (applied == null || !mounted) return;
    _applyToPalette(applied);
  }

  /// Hands the palette (roles and reasons included) to the Palette page,
  /// opens that tab and confirms it with a snackbar.
  void _applyToPalette(IdeaPlan plan) {
    if (plan.palette.isEmpty) return;
    final String title = context.l10n.ideaTitle(plan.preset);
    paletteDraft.value = PaletteDraft(suggestions: plan.palette, title: title);
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final String sent = context.l10n.ideasPaletteSent(title);
    _openPaletteTab();
    messenger?.hideCurrentSnackBar();
    messenger?.showSnackBar(
      SnackBar(
        key: const ValueKey<String>('ideas-palette-sent'),
        content: Text(sent),
      ),
    );
  }

  void _openPaletteTab() => widget.onOpenPalette?.call();

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
    final bool browsing = _category == null && _query.trim().isEmpty;
    final IdeaPreset featured = IdeasEngine.featuredFor(
      widget.today ?? DateTime.now(),
    );

    return Column(
      key: IdeasPage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkPageHeader(
          title: context.l10n.ideasTitle,
          subtitle: _available.isEmpty
              ? context.l10n.ideasNoMarkers
              : _wholeRange
              ? context.l10n.ideasHeaderSubtitleWholeRange
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
              if (browsing)
                _inset(
                  _FeaturedCard(
                    key: ValueKey<String>('ideas-featured-${featured.id}'),
                    preset: featured,
                    plan: _planFor(featured),
                    onOpen: () => _open(featured),
                  ),
                ),
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
                          plan: _planFor(preset),
                          showCategory: _category == null,
                          onTap: () => _open(preset),
                        ),
                    ],
                  ),
                  top: browsing ? InkSpacing.block : 0,
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
}

/// `TECHNIQUES · EASY · 15 MIN` (the category is left out inside a tab).
String ideaMetaLine(
  BuildContext context,
  IdeaPreset preset, {
  bool withCategory = true,
}) {
  final AppLocalizations l10n = context.l10n;
  return AppTypography.caps(
    <String>[
      if (withCategory) l10n.ideaCategoryLabel(preset.category),
      l10n.ideaDifficultyLabel(preset.difficulty),
      l10n.ideasMinutes(preset.minutes),
    ].join(' · '),
  );
}

/// The idea of the day: the same preset all day, with its palette and a
/// button to its steps (design G "Featured" card).
class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({
    super.key,
    required this.preset,
    required this.plan,
    required this.onOpen,
  });

  final IdeaPreset preset;
  final IdeaPlan plan;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(InkSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              AppTypography.caps(context.l10n.ideasFeaturedLabel),
              style: AppTypography.capsStyle.copyWith(color: ink.action),
            ),
            const SizedBox(height: InkSpacing.s4),
            Text(
              ideaMetaLine(context, preset),
              style: AppTypography.capsStyle.copyWith(color: ink.fg2),
            ),
            const SizedBox(height: InkSpacing.group),
            Semantics(
              header: true,
              child: Text(
                context.l10n.ideaTitle(preset),
                style: AppTypography.sheetTitle.copyWith(color: ink.fg),
              ),
            ),
            const SizedBox(height: InkSpacing.group),
            Text(
              context.l10n.ideaSummary(preset),
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
            if (plan.palette.isNotEmpty) ...<Widget>[
              const SizedBox(height: InkSpacing.block),
              PaletteStrip(
                colors: <String>[for (final s in plan.palette) s.color.hex],
                colorHeight: 32,
                radius: InkRadii.control,
              ),
            ],
            const SizedBox(height: InkSpacing.block),
            Align(
              alignment: Alignment.centerLeft,
              child: InkButton(
                key: ValueKey<String>('ideas-open-${preset.id}'),
                label: context.l10n.ideasOpenButton,
                onPressed: onOpen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A hairline-separated list row: meta line with the mini strip of its
/// markers, title and summary.
class _IdeaRow extends StatelessWidget {
  const _IdeaRow({
    super.key,
    required this.preset,
    required this.plan,
    required this.showCategory,
    required this.onTap,
  });

  final IdeaPreset preset;
  final IdeaPlan plan;
  final bool showCategory;
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
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.cardV),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        ideaMetaLine(
                          context,
                          preset,
                          withCategory: showCategory,
                        ),
                        style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                      ),
                    ),
                    if (plan.palette.isNotEmpty) ...<Widget>[
                      const SizedBox(width: InkSpacing.s12),
                      ExcludeSemantics(
                        child: SizedBox(
                          width: 72,
                          child: PaletteStrip(
                            colors: <String>[
                              for (final s in plan.palette) s.color.hex,
                            ],
                            colorHeight: 14,
                            radius: InkRadii.xs,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: InkSpacing.s4),
                Text(
                  context.l10n.ideaTitle(preset),
                  style: AppTypography.section.copyWith(color: ink.fg),
                ),
                const SizedBox(height: InkSpacing.s4),
                Text(
                  context.l10n.ideaSummary(preset),
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
