import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../core/swatch_card_location.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/skeleton_block.dart';
import '../../widgets/swatch_list_tile.dart';
import '../collection/collection_page.dart';
import '../collection/collection_summary.dart';
import 'swatch_detail_sheet.dart';
import '../../../l10n/l10n.dart';

/// The swatch browser (design G, spec §6 "Swatches").
///
/// "All" is the whole range of the active brand, browsable before the user
/// owns anything; "Mine" is the user's collection (owned sets + extra
/// markers, see `collection_selection.ownedColors`). The filters sheet only
/// holds view-time filters (series, set, layout).
///
/// The page is a plain stateful widget: it reads the services from
/// [AppScope] and persists every change through the repositories, so no
/// state-management package is needed.
class SwatchesPage extends StatefulWidget {
  const SwatchesPage({super.key, this.onAddToPalette, this.onOpenCollection});

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('swatches-page');

  /// Called when the user adds a colour to a palette from the detail sheet.
  ///
  /// The shell can use it to open the Palette tab with the colour as its
  /// base. Without it the code is copied to the clipboard instead.
  final ValueChanged<MarkerColor>? onAddToPalette;

  /// Called when the user asks to set up their collection (empty "Mine").
  /// Without it the page pushes the collection screen itself.
  final VoidCallback? onOpenCollection;

  @override
  State<SwatchesPage> createState() => _SwatchesPageState();
}

class _SwatchesPageState extends State<SwatchesPage> {
  /// Height of a grid cell: colour block, body padding, code, two name lines,
  /// hex line (spec §4 "Swatch cell").
  static const double _cellHeight =
      InkGeometry.swatchBlockHeight + 12 + 22 + 40 + 16 + 12;

  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _favoritesOnly = false;
  bool _ownedOnly = false;
  MarkerBrand? _scopeBrand;
  String? _selectedPackId;

  /// Product lines the swatches are narrowed to; empty means every line.
  final Set<MarkerLine> _selectedLines = <MarkerLine>{};
  bool _listLayout = false;

  AppScope? _scope;
  Stream<AppSettingsState>? _settingsChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // `dependOnInheritedWidgetOfExactType` (instead of `AppScope.of`) so the
    // page can also be hosted where no scope is available yet: it then shows
    // a short message instead of throwing.
    final AppScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppScope>();
    if (scope != null && !identical(scope, _scope)) {
      _scope = scope;
      // The stream is captured once: a new stream object on every build
      // would make the StreamBuilder resubscribe on every frame.
      _settingsChanges = scope.settings.changes;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppScope? scope = _scope;
    if (scope == null) {
      return Center(
        key: SwatchesPage.pageKey,
        child: Padding(
          padding: const EdgeInsets.all(InkSpacing.s24),
          child: Text(
            context.l10n.swatchesUnavailable,
            textAlign: TextAlign.center,
            style: AppTypography.secondary.copyWith(
              color: InkColors.of(context).fg2,
            ),
          ),
        ),
      );
    }
    return StreamBuilder<AppSettingsState>(
      stream: _settingsChanges,
      initialData: scope.settings.state,
      builder:
          (BuildContext context, AsyncSnapshot<AppSettingsState> snapshot) {
            final AppSettingsState state =
                snapshot.data ?? scope.settings.state;
            return FutureBuilder<List<MarkerColor>>(
              future: scope.markers.loadColors(state.brand),
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<List<MarkerColor>> colors,
                  ) {
                    if (colors.connectionState == ConnectionState.waiting) {
                      return const _LoadingBody();
                    }
                    if (colors.hasError) {
                      return KeyedSubtree(
                        key: SwatchesPage.pageKey,
                        child: EmptyState.error(
                          title: context.l10n.swatchesLoadFailedTitle,
                          message: context.l10n.swatchesLoadFailedBody,
                        ),
                      );
                    }
                    return _buildContent(
                      context,
                      scope,
                      state,
                      colors.data ?? const <MarkerColor>[],
                    );
                  },
            );
          },
    );
  }

  /// Sets used to locate a marker on its swatch card: the set picked in the
  /// filters, else the sets the user owns.
  Set<String> _activeSets(AppSettingsState state) => _selectedPackId == null
      ? state.settings.ownedSetIds
      : <String>{_selectedPackId!};

  Widget _buildContent(
    BuildContext context,
    AppScope scope,
    AppSettingsState state,
    List<MarkerColor> colors,
  ) {
    final AppSettings settings = state.settings;
    final List<MarkerColor> candidates = swatchCandidateColors(
      colors: colors,
      brand: state.brand,
    );
    final int total = candidates.length;
    final Set<String> owned = <String>{
      for (final MarkerColor c in ownedColors(
        colors: colors,
        brand: state.brand,
        ownedSetIds: settings.ownedSetIds,
        ownedMarkerCodes: settings.extraMarkerIds,
      ))
        c.colorId,
    };
    bool isOwned(MarkerColor color) => owned.contains(color.colorId);
    // Someone with a collection opens on their own markers; decided once per
    // brand, so picking "All" afterwards sticks until the brand changes.
    if (_scopeBrand != state.brand) {
      _scopeBrand = state.brand;
      _ownedOnly = owned.isNotEmpty;
    }
    final List<MarkerColor> visible = candidates
        .where(
          (MarkerColor color) =>
              _matches(color, state) &&
              _inSelectedLines(color) &&
              (_selectedPackId == null ||
                  color.sets.contains(_selectedPackId)) &&
              (!_ownedOnly || isOwned(color)),
        )
        .toList();

    return Column(
      key: SwatchesPage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkPageHeader(
          title: context.l10n.swatchesTitle,
          trailing: context.l10n.swatchesCountOf(visible.length, total),
          subtitle: CollectionSummary.of(state, colors).full(context.l10n),
        ),
        if (owned.isEmpty) _wholeRangeNotice(context, state),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: InkSpacing.pageMargin,
          ),
          child: InkSearchField(
            controller: _searchController,
            hintText: context.l10n.swatchesSearchHint,
            semanticLabel: context.l10n.swatchesSearchHint,
            onChanged: (String value) => setState(() => _query = value.trim()),
          ),
        ),
        const SizedBox(height: InkSpacing.group),
        _chipRow(context, scope, state, colors),
        const SizedBox(height: InkSpacing.block),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              if (visible.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _emptyState(context, owned.isEmpty),
                )
              else if (_listLayout)
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: InkSpacing.pageBottom),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((
                      BuildContext context,
                      int index,
                    ) {
                      final MarkerColor color = visible[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SwatchListTile(
                            hex: color.hex,
                            code: color.displayCode(state.nameDisplayMode),
                            name: color.displayName(state.nameDisplayMode),
                            owned: isOwned(color),
                            favorite: state.favorites.contains(color.colorId),
                            onTap: () =>
                                _openDetail(context, scope, color, candidates),
                          ),
                          Divider(
                            height: InkGeometry.border,
                            thickness: InkGeometry.border,
                            color: InkColors.of(context).line,
                          ),
                        ],
                      );
                    }, childCount: visible.length),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    InkSpacing.pageMargin,
                    0,
                    InkSpacing.pageMargin,
                    InkSpacing.pageBottom,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          // Three columns on a phone; wider screens add more.
                          maxCrossAxisExtent: 130,
                          mainAxisExtent: _cellHeight,
                          crossAxisSpacing: InkSpacing.block,
                          mainAxisSpacing: InkSpacing.block,
                        ),
                    delegate: SliverChildBuilderDelegate((
                      BuildContext context,
                      int index,
                    ) {
                      final MarkerColor color = visible[index];
                      return ColorSwatchTile(
                        hex: color.hex,
                        // The grid cell is too narrow for a "new / old"
                        // pair: only one code and one name show here; the
                        // pair stays in the list and the detail sheet.
                        code: state.nameDisplayMode == NameDisplayMode.oldOnly
                            ? color.oldCode
                            : color.newCode,
                        name: state.nameDisplayMode == NameDisplayMode.oldOnly
                            ? color.oldName
                            : color.newName,
                        owned: isOwned(color),
                        favorite: state.favorites.contains(color.colorId),
                        onTap: () =>
                            _openDetail(context, scope, color, candidates),
                      );
                    }, childCount: visible.length),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Slim notice under the header while no collection is set up: the page
  /// lists the whole range, with a shortcut to set the collection up.
  Widget _wholeRangeNotice(BuildContext context, AppSettingsState state) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      key: const ValueKey<String>('swatches-whole-range'),
      padding: const EdgeInsets.only(
        left: InkSpacing.pageMargin,
        right: InkSpacing.s4,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              context.l10n.swatchesWholeRangeNotice(state.brand.label),
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
          ),
          const SizedBox(width: InkSpacing.s4),
          InkButton.text(
            key: const ValueKey<String>('swatches-whole-range-setup'),
            label: context.l10n.swatchesWholeRangeAction,
            onPressed: _openCollection,
          ),
        ],
      ),
    );
  }

  void _openCollection() {
    final VoidCallback? open = widget.onOpenCollection;
    if (open != null) {
      open();
    } else {
      CollectionPage.open(context);
    }
  }

  /// Number of view filters that differ from the defaults (series, set,
  /// layout).
  int _activeFilterCount(AppSettingsState state) =>
      (_selectedPackId != null ? 1 : 0) +
      (_selectedLines.isNotEmpty ? 1 : 0) +
      (_listLayout ? 1 : 0);

  Widget _chipRow(
    BuildContext context,
    AppScope scope,
    AppSettingsState state,
    List<MarkerColor> colors,
  ) {
    final int active = _activeFilterCount(state);
    return InkChipRow(
      children: <Widget>[
        InkChip(
          label: context.l10n.swatchesAllFilter,
          selected: !_favoritesOnly && !_ownedOnly,
          onSelected: (_) => setState(() {
            _favoritesOnly = false;
            _ownedOnly = false;
          }),
        ),
        InkChip(
          key: const ValueKey<String>('swatches-mine'),
          label: context.l10n.swatchesOwnedOnly,
          selected: _ownedOnly,
          onSelected: (bool on) => setState(() => _ownedOnly = on),
        ),
        InkChip(
          label: context.l10n.swatchesFavoritesOnly,
          selected: _favoritesOnly,
          onSelected: (bool on) => setState(() => _favoritesOnly = on),
        ),
        InkChip(
          label: active > 0
              ? context.l10n.swatchesFiltersCount(active)
              : context.l10n.swatchesFilters,
          icon: InkIcons.filterLines,
          selected: active > 0,
          onSelected: (_) => _openFilters(context, scope, colors),
        ),
      ],
    );
  }

  Widget _emptyState(BuildContext context, bool noCollection) {
    if (_ownedOnly && noCollection) {
      return EmptyState(
        title: context.l10n.swatchesEmptyNoOwnedTitle,
        message: context.l10n.swatchesEmptyNoOwnedBody,
        icon: InkIcons.grid,
        actionLabel: context.l10n.swatchesEmptyNoOwnedAction,
        primaryAction: true,
        onAction: _openCollection,
      );
    }
    final bool searching = _query.isNotEmpty;
    return EmptyState(
      title: searching
          ? context.l10n.swatchesEmptySearchTitle
          : context.l10n.swatchesEmptyFiltersTitle,
      message: searching
          ? context.l10n.swatchesEmptySearchBody
          : context.l10n.swatchesEmptyFiltersBody,
      icon: searching ? InkIcons.search : InkIcons.filterLines,
      actionLabel: context.l10n.swatchesClearFilters,
      onAction: _clearFilters,
    );
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _favoritesOnly = false;
      _ownedOnly = false;
      _selectedPackId = null;
      _selectedLines.clear();
    });
  }

  /// Whether [color] is sold in one of the lines picked in the filters.
  bool _inSelectedLines(MarkerColor color) =>
      _selectedLines.isEmpty || _selectedLines.any(color.inLine);

  bool _matches(MarkerColor color, AppSettingsState state) {
    if (_favoritesOnly && !state.favorites.contains(color.colorId)) {
      return false;
    }
    if (_query.isEmpty) return true;
    final String needle = _query.toLowerCase();
    final String bareNeedle = needle.startsWith('#')
        ? needle.substring(1)
        : needle;
    return color.newCode.toLowerCase().contains(needle) ||
        color.oldCode.toLowerCase().contains(needle) ||
        color.newName.toLowerCase().contains(needle) ||
        color.oldName.toLowerCase().contains(needle) ||
        (bareNeedle.isNotEmpty && color.hex.toLowerCase().contains(bareNeedle));
  }

  /// The packs that hold at least one colour of the loaded catalogue.
  ///
  /// Only Ohuhu has packs; DecoTime is organised by ownership instead.
  List<String> _availablePacks(List<MarkerColor> colors, MarkerBrand brand) {
    if (brand != MarkerBrand.ohuhuOahu) return const <String>[];
    final Set<String> ids = <String>{};
    for (final MarkerColor color in colors) {
      ids.addAll(color.sets);
    }
    final List<String> packs = <String>[
      for (final OahuSet set in OahuSet.values)
        if (ids.contains(set.id)) set.id,
    ];
    for (final String id in ids) {
      if (!packs.contains(id)) packs.add(id);
    }
    return packs;
  }

  /// The lines that hold at least one colour of the loaded catalogue.
  List<MarkerLine> _availableLines(List<MarkerColor> colors) => <MarkerLine>[
    for (final MarkerLine line in MarkerLine.values)
      if (colors.any((MarkerColor color) => color.inLine(line))) line,
  ];

  /// "Classic 160" for the classic packs, "Honolulu 48" for other lines, the
  /// pack label otherwise.
  String _packLabel(String packId) {
    final OahuSet? set = OahuSet.byId[packId];
    return set == null ? packId : context.l10n.packSetFullLabel(set);
  }

  /// The pack chips of the filters sheet: "All packs" first, then the packs
  /// of every line (only the picked lines when a line filter is on), current
  /// packs before the older / community ones.
  Widget _packFilterBody(
    BuildContext context,
    List<String> packs,
    void Function(String? packId) onPick,
  ) {
    final InkColors ink = InkColors.of(context);
    final Set<String> available = packs.toSet();
    Widget chips(List<OahuSet> sets) => Wrap(
      spacing: InkSpacing.chipGap,
      runSpacing: InkSpacing.s4,
      children: <Widget>[
        for (final OahuSet set in sets)
          InkChip(
            // Under its line caption a non-Oahu pack needs no line prefix.
            label: set.line == MarkerLine.oahu
                ? context.l10n.packSetFullLabel(set)
                : context.l10n.packSetLabel(set),
            selected: _selectedPackId == set.id,
            onSelected: (bool on) => onPick(on ? set.id : null),
          ),
      ],
    );
    Widget caption(String text) => Padding(
      padding: const EdgeInsets.only(top: InkSpacing.block, bottom: 4),
      child: Text(
        AppTypography.caps(text),
        style: AppTypography.capsStyle.copyWith(color: ink.fg2),
      ),
    );
    final List<Widget> children = <Widget>[
      Wrap(
        spacing: InkSpacing.chipGap,
        runSpacing: InkSpacing.s4,
        children: <Widget>[
          InkChip(
            label: context.l10n.swatchesAllPacks,
            selected: _selectedPackId == null,
            onSelected: (_) => onPick(null),
          ),
        ],
      ),
    ];
    for (final MarkerLine line in MarkerLine.values) {
      if (_selectedLines.isNotEmpty && !_selectedLines.contains(line)) continue;
      final List<OahuSet> lineSets = OahuSet.forLine(line)
          .where((OahuSet set) => available.contains(set.id))
          .toList();
      final List<OahuSet> current = lineSets
          .where((OahuSet set) => !set.isLegacy)
          .toList();
      final List<OahuSet> legacy = lineSets
          .where((OahuSet set) => set.isLegacy)
          .toList();
      if (lineSets.isEmpty) continue;
      children.add(caption(line.label));
      if (current.isNotEmpty) children.add(chips(current));
      if (legacy.isNotEmpty) {
        children
          ..add(const SizedBox(height: InkSpacing.group))
          ..add(
            Text(
              context.l10n.swatchesLegacyPacks,
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
          )
          ..add(const SizedBox(height: InkSpacing.group))
          ..add(chips(legacy));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  /// The filters sheet: series and set (Ohuhu) and layout. Collection and
  /// display settings live in Settings, not here.
  Future<void> _openFilters(
    BuildContext context,
    AppScope scope,
    List<MarkerColor> colors,
  ) {
    bool packsOpen = false;
    return showInkSheet<void>(
      context: context,
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            final InkColors ink = InkColors.of(context);
            final AppSettingsState state = scope.settings.state;
            final List<String> packs = _availablePacks(colors, state.brand);
            final List<MarkerLine> lines = _availableLines(colors);
            Widget group(String label, Widget child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppTypography.caps(label),
                  style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                ),
                const SizedBox(height: InkSpacing.group),
                child,
              ],
            );
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: InkSpacing.sheetCloseClearance,
                    ),
                    child: Text(
                      context.l10n.swatchesFiltersTitle,
                      style: AppTypography.sheetTitle.copyWith(color: ink.fg),
                    ),
                  ),
                  if (lines.length > 1) ...<Widget>[
                    const SizedBox(height: InkSpacing.block),
                    group(
                      context.l10n.swatchesLabelLine,
                      Wrap(
                        spacing: InkSpacing.chipGap,
                        runSpacing: InkSpacing.s4,
                        children: <Widget>[
                          InkChip(
                            label: context.l10n.swatchesAllLines,
                            selected: _selectedLines.isEmpty,
                            onSelected: (_) {
                              setState(_selectedLines.clear);
                              setSheetState(() {});
                            },
                          ),
                          for (final MarkerLine line in lines)
                            InkChip(
                              label: line.label,
                              selected: _selectedLines.contains(line),
                              onSelected: (bool on) {
                                setState(() {
                                  if (on) {
                                    _selectedLines.add(line);
                                  } else {
                                    _selectedLines.remove(line);
                                  }
                                });
                                setSheetState(() {});
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                  if (packs.isNotEmpty) ...<Widget>[
                    const SizedBox(height: InkSpacing.s24),
                    group(
                      context.l10n.swatchesLabelPack,
                      // The pack list is long (every line has dozens), so it
                      // stays closed until the user opens it.
                      InkDisclosure(
                        title: _selectedPackId == null
                            ? context.l10n.swatchesAllPacks
                            : _packLabel(_selectedPackId!),
                        expanded: packsOpen,
                        padding: EdgeInsets.zero,
                        onToggle: () {
                          packsOpen = !packsOpen;
                          setSheetState(() {});
                        },
                        child: _packFilterBody(context, packs, (
                          String? packId,
                        ) {
                          setState(() => _selectedPackId = packId);
                          setSheetState(() {});
                        }),
                      ),
                    ),
                  ],
                  SizedBox(height: InkSpacing.s24),
                  group(
                    context.l10n.swatchesLabelLayout,
                    InkSegmented<bool>(
                      expand: true,
                      selected: _listLayout,
                      segments: <InkSegment<bool>>[
                        InkSegment<bool>(
                          value: false,
                          label: context.l10n.swatchesLayoutGrid,
                        ),
                        InkSegment<bool>(
                          value: true,
                          label: context.l10n.swatchesLayoutList,
                        ),
                      ],
                      onChanged: (bool list) {
                        setState(() => _listLayout = list);
                        setSheetState(() {});
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _openDetail(
    BuildContext context,
    AppScope scope,
    MarkerColor color,
    List<MarkerColor> candidates,
  ) async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final AppLocalizations l10n = context.l10n;
    MarkerColor current = color;
    // The card catalogue only exists for Oahu; an empty one hides the row.
    final Map<String, Map<String, int>> cardCatalog = await scope.markers
        .loadCardLocations();
    if (!context.mounted) return;
    final Set<String> activeSets = _activeSets(scope.settings.state);
    String? cardLocationOf(MarkerColor c) {
      if (c.brandId != MarkerBrand.ohuhuOahu.id) return null;
      final String? label = buildSwatchCardLocationLabels(
        <MarkerColor>[c],
        activeSets,
        cardCatalog,
      )[c.newCode.trim().toUpperCase()];
      return label == null ? null : context.l10n.cardLocationLabel(label);
    }

    await showInkSheet<void>(
      context: context,
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return SwatchDetailSheet(
              color: current,
              favorite: scope.settings.isFavorite(current.colorId),
              lineLabels: <String>[
                for (final String id in current.lines)
                  ?MarkerLine.fromId(id)?.label,
              ],
              // Human labels only: a raw id ("decotime_base") is never shown.
              packLabels: <String>[
                for (final String id in current.sets) ?l10n.setLabel(id),
              ],
              cardLocation: cardLocationOf(current),
              alternatives: closestAlternatives(current, candidates),
              onSelectAlternative: (MarkerColor other) =>
                  setSheetState(() => current = other),
              onToggleFavorite: () {
                scope.settings.toggleFavorite(current.colorId);
                setSheetState(() {});
              },
              onCopyHex: () async {
                await Clipboard.setData(
                  ClipboardData(text: displayHex(current.hex)),
                );
                messenger.showSnackBar(
                  SnackBar(content: Text(l10n.swatchesHexCopied)),
                );
              },
              onAddToPalette: () async {
                final ValueChanged<MarkerColor>? hook = widget.onAddToPalette;
                if (hook != null) {
                  Navigator.of(sheetContext).maybePop();
                  hook(current);
                  return;
                }
                await Clipboard.setData(ClipboardData(text: current.newCode));
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(l10n.swatchesCodeCopied(current.newCode)),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

/// Placeholder shown while the catalogue is read: the header and skeleton
/// cells in the grid's shape.
class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: SwatchesPage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkPageHeader(title: context.l10n.swatchesTitle),
        Semantics(
          label: context.l10n.swatchesLoadingSemantics,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: InkSpacing.pageMargin),
            child: SkeletonBlock(
              height: InkGeometry.fieldHeight,
              radius: InkRadii.input,
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: InkSpacing.gutter),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              mainAxisExtent: _SwatchesPageState._cellHeight,
              crossAxisSpacing: InkSpacing.block,
              mainAxisSpacing: InkSpacing.block,
            ),
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) =>
                const SkeletonBlock(height: _SwatchesPageState._cellHeight),
          ),
        ),
      ],
    );
  }
}
