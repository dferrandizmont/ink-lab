import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/ideas_engine.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/palette_strip.dart';
import '../diary/artwork_diary_view.dart';
import '../diary/artwork_entry_page.dart';
import '../match/image_picker_service.dart';
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
///
/// A segmented control switches between the ideas and the artwork diary
/// (a log of what the user painted); "Add to diary" in an idea's sheet starts
/// an entry titled after the idea.
class IdeasPage extends StatefulWidget {
  const IdeasPage({super.key, this.onOpenPalette, this.today, this.picker});

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('ideas-page');

  /// Opens the Palette tab after a palette was handed over (wired by the app
  /// shell; null in isolated previews and tests).
  final VoidCallback? onOpenPalette;

  /// The day of the "idea of the day"; defaults to now (tests pin it).
  final DateTime? today;

  /// Photo picker of the diary's entry form (tests inject a fake).
  final ImagePickerService? picker;

  @override
  State<IdeasPage> createState() => _IdeasPageState();
}

/// What the Ideas tab shows.
enum _IdeasView { ideas, diary }

class _IdeasPageState extends State<IdeasPage> {
  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _settingsSubscription;
  StreamSubscription<Map<String, String>>? _ownColorsSubscription;
  StreamSubscription<Set<String>>? _driedSubscription;
  StreamSubscription<Set<String>>? _favoritesSubscription;
  StreamSubscription<List<String>>? _recentSubscription;
  String _collectionSignature = '';

  MarkerBrand _brand = MarkerBrand.ohuhuOahu;
  List<MarkerColor> _available = const <MarkerColor>[];

  /// True while the palette comes from the whole range because the active
  /// brand has no collection configured.
  bool _wholeRange = false;
  bool _loading = true;

  _IdeasView _view = _IdeasView.ideas;
  IdeaCategory? _category;

  /// The "Favourites" chip: only the ideas with a heart.
  bool _favoritesOnly = false;
  Set<String> _favorites = const <String>{};
  List<String> _recent = const <String>[];
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
    // The colours of the markers changed (an own colour was set or reset).
    _ownColorsSubscription?.cancel();
    _driedSubscription?.cancel();
    _ownColorsSubscription = scope.ownColors.changes.listen(
      (_) => _onSettingsChanged(scope.settings.state),
    );
    // A marker was marked as dried out, or usable again.
    _driedSubscription?.cancel();
    _driedSubscription = scope.dried.changes.listen(
      (_) => _onSettingsChanged(scope.settings.state),
    );
    // The hearts and the ideas opened last.
    _favoritesSubscription?.cancel();
    _recentSubscription?.cancel();
    _favorites = scope.ideaFavorites.favorites;
    _recent = scope.ideaFavorites.recent;
    _favoritesSubscription = scope.ideaFavorites.favoriteChanges.listen((
      Set<String> favorites,
    ) {
      if (mounted) setState(() => _favorites = favorites);
    });
    _recentSubscription = scope.ideaFavorites.recentChanges.listen((
      List<String> recent,
    ) {
      if (mounted) setState(() => _recent = recent);
    });
    unawaited(_reload());
  }

  @override
  void dispose() {
    _settingsSubscription?.cancel();
    _ownColorsSubscription?.cancel();
    _driedSubscription?.cancel();
    _favoritesSubscription?.cancel();
    _recentSubscription?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  String _signatureOf(AppSettingsState state) {
    final sets = state.settings.effectiveSetIds().toList()..sort();
    final owned = state.settings.ownedMarkerCodes.toList()..sort();
    return '${state.brand.id}|${sets.join(',')}|${owned.join(',')}|'
        '${_scope?.markers.colorRevision}|${_scope?.dried.revision}';
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
        driedColorIds: scope.dried.ids,
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
      if (_favoritesOnly && !_favorites.contains(preset.id)) return false;
      if (query.isEmpty) return true;
      return context.l10n.ideaTitle(preset).toLowerCase().contains(query) ||
          context.l10n.ideaSummary(preset).toLowerCase().contains(query);
    }).toList();
  }

  /// The ideas opened last that the catalogue knows, newest first.
  List<IdeaPreset> get _recentPresets => <IdeaPreset>[
    for (final String id in _recent.take(_recentShown))
      for (final IdeaPreset preset in IdeasEngine.presets)
        if (preset.id == id) preset,
  ];

  Future<void> _toggleFavorite(IdeaPreset preset) async {
    final AppScope? scope = _scope;
    if (scope == null) return;
    try {
      await scope.ideaFavorites.toggle(preset.id);
    } catch (_) {
      // The heart simply does not change when the store cannot write.
    }
  }

  Future<void> _open(IdeaPreset preset) async {
    final IdeaPlan initial = _planFor(preset);
    // Opening the sheet counts as viewing the idea.
    final IdeaFavoritesRepository? favorites = _scope?.ideaFavorites;
    if (favorites != null) {
      unawaited(favorites.recordViewed(preset.id).catchError((Object _) {}));
    }
    final IdeaPlan? applied = await showInkSheet<IdeaPlan>(
      context: context,
      builder: (BuildContext context) => IdeaDetailSheet(
        initial: initial,
        candidates: _available,
        brand: _brand,
        favorites: favorites,
        onAddToDiary: _addToDiary,
      ),
    );
    if (applied == null || !mounted) return;
    _applyToPalette(applied);
  }

  /// Opens a new diary entry titled [title] (the idea's name) and confirms
  /// it with a snackbar once it is saved.
  Future<void> _addToDiary(String title) async {
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final String notice = context.l10n.diaryAddedNotice;
    final bool saved = await ArtworkEntryPage.open(
      context,
      title: title,
      picker: widget.picker,
    );
    if (!saved) return;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const ValueKey<String>('ideas-diary-added'),
          content: Text(notice),
        ),
      );
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

    final bool diary = _view == _IdeasView.diary;
    final List<IdeaPreset> filtered = _filteredPresets;
    final bool browsing =
        _category == null && !_favoritesOnly && _query.trim().isEmpty;
    final List<IdeaPreset> recent = browsing
        ? _recentPresets
        : const <IdeaPreset>[];
    final IdeaPreset featured = IdeasEngine.featuredFor(
      widget.today ?? DateTime.now(),
    );

    return Column(
      key: IdeasPage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkPageHeader(
          title: context.l10n.ideasTitle,
          subtitle: diary
              ? context.l10n.ideasDiarySubtitle
              : _available.isEmpty
              ? context.l10n.ideasNoMarkers
              : _wholeRange
              ? context.l10n.ideasHeaderSubtitleWholeRange
              : context.l10n.ideasHeaderSubtitle,
          // The control below must not jump when the segment (or the
          // collection) swaps the subtitle: reserve the tallest one.
          reserveSubtitleFor: <String>[
            context.l10n.ideasDiarySubtitle,
            context.l10n.ideasNoMarkers,
            context.l10n.ideasHeaderSubtitleWholeRange,
            context.l10n.ideasHeaderSubtitle,
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            InkSpacing.pageMargin,
            0,
            InkSpacing.pageMargin,
            InkSpacing.block,
          ),
          child: InkSegmented<_IdeasView>(
            key: const ValueKey<String>('ideas-view'),
            expand: true,
            semanticLabel: context.l10n.ideasTitle,
            segments: <InkSegment<_IdeasView>>[
              InkSegment<_IdeasView>(
                value: _IdeasView.ideas,
                label: context.l10n.ideasTitle,
              ),
              InkSegment<_IdeasView>(
                value: _IdeasView.diary,
                label: context.l10n.ideasDiarySegment,
              ),
            ],
            selected: _view,
            onChanged: (_IdeasView view) => setState(() => _view = view),
          ),
        ),
        if (diary)
          Expanded(child: ArtworkDiaryView(picker: widget.picker))
        else ...<Widget>[
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
                      favorite: _favorites.contains(featured.id),
                      onToggleFavorite: () => _toggleFavorite(featured),
                      onOpen: () => _open(featured),
                    ),
                  ),
                if (recent.isNotEmpty)
                  _RecentRow(
                    key: const ValueKey<String>('ideas-recent'),
                    presets: recent,
                    planFor: _planFor,
                    onOpen: _open,
                  ),
                if (filtered.isEmpty && _favoritesOnly && _query.trim().isEmpty)
                  EmptyState(
                    key: const ValueKey<String>('ideas-favorites-empty'),
                    icon: InkIcons.heart,
                    title: context.l10n.ideasFavoritesEmptyTitle,
                    message: context.l10n.ideasFavoritesEmptyMessage,
                  )
                else if (filtered.isEmpty)
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
                            favorite: _favorites.contains(preset.id),
                            onToggleFavorite: () => _toggleFavorite(preset),
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
      _favoritesOnly = false;
    });
  }

  Widget _buildCategoryChips() {
    return InkChipRow(
      semanticLabel: context.l10n.ideasCategoriesLabel,
      children: <Widget>[
        InkChip(
          key: const ValueKey<String>('ideas-category-all'),
          label: context.l10n.ideasCategoryAll,
          selected: _category == null && !_favoritesOnly,
          onSelected: (_) => setState(() {
            _category = null;
            _favoritesOnly = false;
          }),
        ),
        InkChip(
          key: const ValueKey<String>('ideas-category-favorites'),
          label: context.l10n.ideasFavoritesChip,
          icon: InkIcons.heart,
          selected: _favoritesOnly,
          onSelected: (_) => setState(() {
            _category = null;
            _favoritesOnly = true;
          }),
        ),
        for (final category in IdeaCategory.values)
          InkChip(
            key: ValueKey<String>('ideas-category-${category.name}'),
            label: context.l10n.ideaCategoryLabel(category),
            selected: _category == category,
            onSelected: (_) => setState(() {
              _category = category;
              _favoritesOnly = false;
            }),
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
    required this.favorite,
    required this.onToggleFavorite,
    required this.onOpen,
  });

  final IdeaPreset preset;
  final IdeaPlan plan;
  final bool favorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // The heart is 44 dp tall; this keeps the caps lines
                      // centred against it.
                      const SizedBox(height: InkSpacing.s8),
                      Text(
                        AppTypography.caps(context.l10n.ideasFeaturedLabel),
                        style: AppTypography.capsStyle.copyWith(
                          color: ink.action,
                        ),
                      ),
                      const SizedBox(height: InkSpacing.s4),
                      Text(
                        ideaMetaLine(context, preset),
                        style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                      ),
                    ],
                  ),
                ),
                IdeaHeartButton(
                  key: ValueKey<String>('ideas-heart-${preset.id}-featured'),
                  favorite: favorite,
                  onPressed: onToggleFavorite,
                ),
              ],
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
    required this.favorite,
    required this.onToggleFavorite,
    required this.onTap,
  });

  final IdeaPreset preset;
  final IdeaPlan plan;
  final bool showCategory;
  final bool favorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ink.line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Semantics(
              button: true,
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: InkSpacing.cardV,
                  ),
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
                              style: AppTypography.capsStyle.copyWith(
                                color: ink.fg2,
                              ),
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: InkSpacing.s4),
            child: IdeaHeartButton(
              key: ValueKey<String>('ideas-heart-${preset.id}'),
              favorite: favorite,
              onPressed: onToggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}

/// How many recently viewed ideas the Ideas tab shows (the repository keeps
/// more).
const int _recentShown = 6;

/// The heart that marks an idea as a favourite: outlined, filled with the
/// action colour while the idea is a favourite. Shared by the cards and the
/// idea sheet.
class IdeaHeartButton extends StatelessWidget {
  const IdeaHeartButton({
    super.key,
    required this.favorite,
    required this.onPressed,
  });

  final bool favorite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return InkIconButton(
      icon: InkIcons.heart,
      selected: favorite,
      color: favorite ? ink.action : ink.fg2,
      tooltip: favorite
          ? context.l10n.commonRemoveFromFavourites
          : context.l10n.commonAddToFavourites,
      onPressed: onPressed,
    );
  }
}

/// "Recently viewed": the ideas opened last, newest first, as a row of small
/// cards that scrolls sideways.
class _RecentRow extends StatelessWidget {
  const _RecentRow({
    super.key,
    required this.presets,
    required this.planFor,
    required this.onOpen,
  });

  final List<IdeaPreset> presets;
  final IdeaPlan Function(IdeaPreset) planFor;
  final ValueChanged<IdeaPreset> onOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: InkSpacing.block),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: InkSpacing.gutter),
            child: InkSectionHeading(context.l10n.ideasRecentTitle),
          ),
          const SizedBox(height: InkSpacing.headingGap),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: InkSpacing.gutter),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < presets.length; i++) ...<Widget>[
                  if (i > 0) const SizedBox(width: InkSpacing.s8),
                  _RecentCard(
                    key: ValueKey<String>('ideas-recent-${presets[i].id}'),
                    preset: presets[i],
                    plan: planFor(presets[i]),
                    onTap: () => onOpen(presets[i]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  const _RecentCard({
    super.key,
    required this.preset,
    required this.plan,
    required this.onTap,
  });

  final IdeaPreset preset;
  final IdeaPlan plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    // Wider with the text scale, so a large font does not wrap the title into
    // a tall, narrow card.
    final double scale = MediaQuery.textScalerOf(
      context,
    ).scale(1).clamp(1.0, 1.3);
    return SizedBox(
      width: 168 * scale,
      child: Semantics(
        button: true,
        child: Material(
          color: ink.surface,
          shape: RoundedRectangleBorder(
            borderRadius: InkRadii.cardRadius,
            side: BorderSide(color: ink.line),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: InkSpacing.card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    context.l10n.ideaTitle(preset),
                    style: AppTypography.section.copyWith(color: ink.fg),
                  ),
                  if (plan.palette.isNotEmpty) ...<Widget>[
                    const SizedBox(height: InkSpacing.s8),
                    ExcludeSemantics(
                      child: PaletteStrip(
                        colors: <String>[
                          for (final s in plan.palette) s.color.hex,
                        ],
                        colorHeight: 14,
                        radius: InkRadii.xs,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
