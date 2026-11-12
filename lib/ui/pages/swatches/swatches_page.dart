import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_scope.dart';
import '../../../core/brand_equivalents.dart';
import '../../../core/collection_selection.dart';
import '../../../core/color_utils.dart';
import '../../../core/hex_search.dart';
import '../../../core/models.dart';
import '../../../core/own_colors.dart';
import '../../../core/swatch_card_location.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/skeleton_block.dart';
import '../../widgets/swatch_list_tile.dart';
import '../collection/collection_page.dart';
import '../collection/collection_summary.dart';
import '../match/color_sampling.dart';
import '../match/image_picker_service.dart';
import '../../shell/app_shortcuts.dart' show swatchesSearchFocus;
import '../settings/dialogs.dart';
import 'brand_equivalents_index.dart';
import 'brand_equivalents_section.dart';
import 'ink_level_section.dart' show showRefillNoteDialog;
import 'own_color_page.dart';
import 'swatch_detail_sheet.dart';
import 'swatch_photo_row.dart';
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
  const SwatchesPage({
    super.key,
    this.onAddToPalette,
    this.onBlendingChain,
    this.onOpenCollection,
    this.picker,
    this.decoder,
  });

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('swatches-page');

  /// Called when the user adds a colour to a palette from the detail sheet.
  ///
  /// The shell can use it to open the Palette tab with the colour as its
  /// base. Without it the code is copied to the clipboard instead.
  final ValueChanged<MarkerColor>? onAddToPalette;

  /// Called when the user asks for a blending chain around a colour from the
  /// detail sheet. The shell opens the Palette tab with the colour as its
  /// base and the Blending Chain type. Without it the action is not shown.
  final ValueChanged<MarkerColor>? onBlendingChain;

  /// Called when the user asks to set up their collection (empty "Mine").
  /// Without it the page pushes the collection screen itself.
  final VoidCallback? onOpenCollection;

  /// Photo picker of the "my colour" editor. Production wraps `image_picker`;
  /// tests inject a fake.
  final ImagePickerService? picker;

  /// Decoder of the "my colour" editor's photo. Tests inject a fake.
  final PhotoDecoder? decoder;

  @override
  State<SwatchesPage> createState() => _SwatchesPageState();
}

class _SwatchesPageState extends State<SwatchesPage> {
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
  Stream<Map<String, String>>? _ownColorChanges;
  Stream<Set<String>>? _driedChanges;

  /// The picker of the photo of a real swatch: pictures scaled to about
  /// 1024 px. Tests inject their own through [SwatchesPage.picker].
  late final ImagePickerService _swatchPicker =
      widget.picker ?? PlatformImagePickerService.limited();

  /// The other brands' colours, prepared once for "In other brands" and
  /// prepared again when the effective colours change.
  Future<BrandEquivalentsIndex>? _equivalentsIndex;
  int? _equivalentsRevision;

  /// Whether the last layout had room for the detail next to the grid
  /// ([InkLayout.isTwoPane]); a tapped marker then opens there instead of in
  /// a sheet.
  bool _twoPane = false;

  /// The detail on screen in the pane, or `null` while no marker is chosen.
  _PaneDetail? _pane;

  /// The scroll position of the pane (its own: the grid has the primary one).
  final ScrollController _paneScroll = ScrollController();

  /// The id of the marker the pane shows, outlined in the grid.
  final ValueNotifier<String?> _paneShown = ValueNotifier<String?>(null);

  /// The marker whose detail is open (in the pane or in the sheet) and the
  /// colours its alternatives come from, or `null` when none is. It outlives
  /// the pane: a rotation to a narrow page hides the pane but keeps this, so
  /// the way back to two panes shows the same marker again.
  ({MarkerColor color, List<MarkerColor> pool})? _selection;

  /// Takes the detail sheet out of the screen so its marker can move to the
  /// pane; `null` while no sheet is open. Answers `false` when the sheet is
  /// not the top route (a dialog or the photo viewer is over it): it then
  /// stays, and the move is tried again a moment later.
  bool Function()? _handSheetToPane;

  /// The pending retry of a move that had to wait for the route above the
  /// sheet to close.
  Timer? _handOverRetry;

  /// The brand the page was last showing: another brand forgets the marker.
  MarkerBrand? _brand;
  StreamSubscription<AppSettingsState>? _brandWatch;

  /// Whether the detail is being moved between the sheet, the pane and back,
  /// so a second layout pass does not start the move twice.
  bool _movingDetail = false;

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
      _ownColorChanges = scope.ownColors.changes;
      _driedChanges = scope.dried.changes;
      _brand = scope.settings.brand;
      unawaited(_brandWatch?.cancel());
      _brandWatch = scope.settings.changes.listen(_onSettings);
    }
  }

  /// Another brand in Settings: the marker of the old one is not the user's
  /// choice any more, in the pane or kept for the next rotation.
  void _onSettings(AppSettingsState state) {
    if (state.brand == _brand) return;
    _brand = state.brand;
    _selection = null;
    _closePane();
  }

  @override
  void dispose() {
    _handOverRetry?.cancel();
    unawaited(_brandWatch?.cancel());
    _pane?.closed();
    _searchController.dispose();
    _paneScroll.dispose();
    _paneShown.dispose();
    super.dispose();
  }

  /// Closes the detail of the pane: the user is done with that marker.
  void _closePane() {
    if (_pane == null) return;
    _selection = null;
    _hidePane();
  }

  /// Takes the detail out of the pane without forgetting its marker.
  void _hidePane() {
    if (_pane == null) return;
    _pane?.closed();
    _paneShown.value = null;
    if (mounted) setState(() => _pane = null);
  }

  /// Keeps the open detail in step with the layout, after the frame:
  ///
  /// * narrow page, detail in the pane: the pane goes (rotation, Split View),
  ///   its marker is remembered;
  /// * wide page, a sheet open: the sheet closes and its marker opens in the
  ///   pane (a modal sheet over two panes would leave the pane empty);
  /// * wide page, a marker remembered and no pane: it opens in the pane.
  void _syncDetailWithLayout(AppScope scope, {required bool twoPane}) {
    if (!twoPane) {
      if (_pane != null) _hidePane();
      return;
    }
    final ({MarkerColor color, List<MarkerColor> pool})? selection = _selection;
    if (selection == null || _pane != null || _movingDetail) return;
    final bool Function()? handOver = _handSheetToPane;
    if (handOver != null && !handOver()) {
      // Something is open over the sheet (a confirmation, the photo): wait
      // for it instead of pulling the sheet from under it.
      _handOverRetry?.cancel();
      _handOverRetry = Timer(InkMotion.sheetIn, () {
        if (mounted && _twoPane) _syncDetailWithLayout(scope, twoPane: true);
      });
      return;
    }
    _movingDetail = true;
    _openDetail(
      context,
      scope,
      selection.color,
      selection.pool,
      forPane: true,
    ).whenComplete(() => _movingDetail = false);
  }

  /// The detail pane of the two-pane layout: the marker chosen in the grid,
  /// or a short hint while there is none. Its overflow menu is keyed by the
  /// detail, so a new marker gets a new menu (and the old one is disposed).
  Widget _buildPane(BuildContext context) {
    final _PaneDetail? pane = _pane;
    if (pane == null) {
      return InkDetailPane(
        key: const ValueKey<String>('swatches-detail-pane'),
        child: EmptyState(
          key: const ValueKey<String>('swatches-detail-pane-empty'),
          icon: InkIcons.droplet,
          title: context.l10n.swatchesDetailPaneEmpty,
        ),
      );
    }
    return InkDetailPane(
      key: const ValueKey<String>('swatches-detail-pane'),
      onClose: _closePane,
      actions: <Widget>[
        _SwatchOverflowMenu(key: ObjectKey(pane), items: pane.menuItems),
      ],
      child: KeyedSubtree(
        key: ObjectKey(pane),
        child: pane.builder(context, _paneScroll),
      ),
    );
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
    // Wide pages show the detail of the marker next to the grid. The grid is
    // the first child of the row at every width, so crossing the breakpoint
    // keeps its scroll position and the search text.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool twoPane = InkLayout.isTwoPane(constraints.maxWidth);
        final bool detailOutOfStep = twoPane
            ? _selection != null && _pane == null
            : _pane != null;
        if (detailOutOfStep) {
          // The page changed width (rotation, Split View): the detail moves
          // between the sheet and the pane, keeping its marker.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _twoPane == twoPane) {
              _syncDetailWithLayout(scope, twoPane: twoPane);
            }
          });
        }
        _twoPane = twoPane;
        return PopScope(
          // Back closes the detail in the pane first; only a second Back
          // leaves the app. Every visited tab lives in the shell, so a hidden
          // Swatches tab must not take the Back of the tab on screen.
          canPop: _pane == null || !Visibility.of(context),
          onPopInvokedWithResult: (bool didPop, Object? result) {
            if (!didPop) _closePane();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _buildStreams(context, scope)),
              if (twoPane)
                SizedBox(
                  width: InkLayout.detailPaneWidth,
                  child: _buildPane(context),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStreams(BuildContext context, AppScope scope) {
    return StreamBuilder<AppSettingsState>(
      stream: _settingsChanges,
      initialData: scope.settings.state,
      builder: (BuildContext context, AsyncSnapshot<AppSettingsState> snapshot) {
        final AppSettingsState state = snapshot.data ?? scope.settings.state;
        // An own colour set or reset rebuilds the page with the new colours.
        return StreamBuilder<Map<String, String>>(
          stream: _ownColorChanges,
          initialData: scope.ownColors.colors,
          // Marking a marker as dried out (or usable) redraws its mark.
          builder:
              (BuildContext context, AsyncSnapshot<Map<String, String>> _) =>
                  StreamBuilder<Set<String>>(
                    stream: _driedChanges,
                    initialData: scope.dried.ids,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<Set<String>> _,
                    ) => _buildCatalogue(context, scope, state),
                  ),
        );
      },
    );
  }

  Widget _buildCatalogue(
    BuildContext context,
    AppScope scope,
    AppSettingsState state,
  ) {
    // Keyed by brand so another brand starts from scratch, while new own
    // colours of the same brand keep the page on screen until they arrive.
    return FutureBuilder<List<MarkerColor>>(
      key: ValueKey<String>(state.brand.id),
      future: scope.markers.loadColors(state.brand),
      initialData: scope.markers.peekColors(state.brand),
      builder: (BuildContext context, AsyncSnapshot<List<MarkerColor>> colors) {
        if (!colors.hasData &&
            colors.connectionState == ConnectionState.waiting) {
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
    // The owned check of a grid cell only means something when the whole
    // range is on screen: with "Mine" (or "Favourites") every cell of the
    // grid would carry it.
    final bool showOwnedMark = !_favoritesOnly && !_ownedOnly;
    bool inView(MarkerColor color) =>
        _inSelectedLines(color) &&
        (_selectedPackId == null || color.sets.contains(_selectedPackId)) &&
        (!_ownedOnly || isOwned(color));
    List<MarkerColor> visible = candidates
        .where((MarkerColor color) => _matches(color, state) && inView(color))
        .toList();
    // A search text that is a hex colour (`#2D6E9C`, `2d6e9c`) shows the
    // closest markers first, then whatever else the text finds.
    final int? hexTarget = hexSearchColor(_query, candidates);
    if (hexTarget != null) {
      final List<MarkerColor> nearest = nearestMarkers(
        hexTarget,
        candidates.where(
          (MarkerColor color) =>
              _matches(color, state, ignoreQuery: true) && inView(color),
        ),
      );
      final Set<String> shown = <String>{
        for (final MarkerColor color in nearest) color.colorId,
      };
      visible = <MarkerColor>[
        ...nearest,
        for (final MarkerColor color in visible)
          if (!shown.contains(color.colorId)) color,
      ];
    }

    return Column(
      key: SwatchesPage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkPageHeader(
          title: context.l10n.swatchesTitle,
          trailing: context.l10n.swatchesCountOf(visible.length, total),
          // The count of the range is on the title line already: the subtitle
          // says the brand and its series, never a number.
          subtitle: CollectionSummary.of(state, colors).headline(),
          // The series of the collection change the subtitle: the header
          // reserves the room of the tallest one, so nothing below moves.
          reserveSubtitleFor: _subtitleVariants(state.brand),
        ),
        if (owned.isEmpty) _wholeRangeNotice(context, state),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: InkSpacing.pageMargin,
          ),
          child: InkSearchField(
            controller: _searchController,
            focusNode: swatchesSearchFocus,
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
              if (hexTarget != null && visible.isNotEmpty)
                SliverToBoxAdapter(child: _closestTo(context, hexTarget)),
              if (visible.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _emptyState(
                    context,
                    noCollection: owned.isEmpty,
                    noFavorites: !candidates.any(
                      (MarkerColor color) =>
                          state.favorites.contains(color.colorId),
                    ),
                    noOwnedFavorites: !candidates.any(
                      (MarkerColor color) =>
                          state.favorites.contains(color.colorId) &&
                          isOwned(color),
                    ),
                  ),
                )
              else if (_listLayout)
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: InkSpacing.pageBottomOf(context),
                  ),
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
                            ownColor: color.hasOwnColor,
                            dried: scope.dried.contains(color.colorId),
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
                  padding: EdgeInsets.fromLTRB(
                    InkSpacing.pageMargin,
                    0,
                    InkSpacing.pageMargin,
                    InkSpacing.pageBottomOf(context),
                  ),
                  sliver: SliverGrid(
                    gridDelegate: ColorSwatchTile.gridDelegate(
                      context,
                      showHex: false,
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
                        // The owned check only says something when the whole
                        // range is on screen: with "Mine" (or "Favourites")
                        // every cell would carry it.
                        owned: showOwnedMark && isOwned(color),
                        favorite: state.favorites.contains(color.colorId),
                        ownColor: color.hasOwnColor,
                        dried: scope.dried.contains(color.colorId),
                        // The hex stays in the list and in the detail sheet:
                        // the grid cells are lower without it.
                        showHex: false,
                        // The marker of the detail pane, on wide pages.
                        selected: _twoPane && _paneShown.value == color.colorId,
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

  /// Every subtitle the header can show for [brand]: the brand alone and the
  /// brand with each combination of its series.
  ///
  /// The series of the collection change when the collection changes, and
  /// the header must not grow when they do.
  List<String> _subtitleVariants(MarkerBrand brand) {
    final List<MarkerLine> lines = brand.lines;
    return <String>[
      for (int mask = 0; mask < (1 << lines.length); mask++)
        // The counts do not matter for the headline ("Ohuhu · Oahu").
        CollectionSummary(
          brand: brand,
          series: <MarkerLine>[
            for (int i = 0; i < lines.length; i++)
              if (mask & (1 << i) != 0) lines[i],
          ],
          setCount: 0,
          markerCount: 0,
        ).headline(),
    ];
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

  /// Number of filters that narrow the results (series, set). The layout
  /// (grid or list) only changes how they are drawn, so it does not count.
  int _activeFilterCount(AppSettingsState state) =>
      (_selectedPackId != null ? 1 : 0) + (_selectedLines.isNotEmpty ? 1 : 0);

  Widget _chipRow(
    BuildContext context,
    AppScope scope,
    AppSettingsState state,
    List<MarkerColor> colors,
  ) {
    final int active = _activeFilterCount(state);
    final AppLocalizations l10n = context.l10n;
    final String allLabel = l10n.swatchesAllFilter;
    final String mineLabel = l10n.swatchesOwnedOnly;
    final String favouritesLabel = l10n.swatchesFavoritesOnly;
    // The Filters chip carries the count of the filters that narrow the
    // results; with no filter on, it is the plain word.
    final String filtersLabel = active > 0
        ? l10n.swatchesFiltersCount(active)
        : l10n.swatchesFilters;
    // The same chip with its icon only and the count on its own: it says how
    // many filters are on without taking the room of the word.
    final String compactLabel = active > 0 ? '$active' : '';

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // The width the three chips take when nothing squeezes them: the
        // gutter of the row, the chips, the gap between them and the trailing
        // padding of the chip row.
        final double chipsWidth =
            InkSpacing.gutter +
            InkChip.naturalWidth(context, allLabel) +
            InkSpacing.chipGap +
            InkChip.naturalWidth(context, mineLabel) +
            InkSpacing.chipGap +
            InkChip.naturalWidth(context, favouritesLabel) +
            InkSpacing.chipGap;
        // Decide the icon-only state with the widest variant of the Filters
        // label, including the count badge, so that toggling a filter never
        // switches the chip between word and icon-only (no layout jump).
        final double filtersWidth = math.max(
          InkChip.naturalWidth(
            context,
            l10n.swatchesFilters,
            icon: InkIcons.filterLines,
          ),
          math.max(
            InkChip.naturalWidth(
              context,
              l10n.swatchesFiltersCount(1),
              icon: InkIcons.filterLines,
            ),
            InkChip.naturalWidth(
              context,
              l10n.swatchesFiltersCount(2),
              icon: InkIcons.filterLines,
            ),
          ),
        );
        // The widest count digit the compact chip can show, so its width
        // stays stable when a filter is toggled.
        final double compactWidth = math.max(
          InkChip.naturalWidth(context, '1', icon: InkIcons.filterLines),
          InkChip.naturalWidth(context, '2', icon: InkIcons.filterLines),
        );
        // The chips are whole when they fit in the room the pinned chip
        // leaves them (the pinned chip keeps its own gutter at the end).
        final double available = constraints.maxWidth;
        final bool fits =
            chipsWidth + filtersWidth + InkSpacing.gutter <= available;
        final bool fitsCompact =
            chipsWidth + compactWidth + InkSpacing.gutter <= available;
        // The pinned chip shrinks to its icon when the row would overflow, and
        // the row wraps when even that is not enough: a chip is never cut by
        // the edge, nor hidden behind the pinned one.
        final bool compact = !fits;
        final bool wrap = compact && !fitsCompact;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: InkChipRow(
                fadeEnds: !wrap,
                wrap: wrap,
                padding: const EdgeInsetsDirectional.only(
                  start: InkSpacing.gutter,
                  end: InkSpacing.chipGap,
                ),
                children: <Widget>[
                  InkChip(
                    label: allLabel,
                    selected: !_favoritesOnly && !_ownedOnly,
                    onSelected: (_) => setState(() {
                      _favoritesOnly = false;
                      _ownedOnly = false;
                    }),
                  ),
                  InkChip(
                    key: const ValueKey<String>('swatches-mine'),
                    label: mineLabel,
                    selected: _ownedOnly,
                    onSelected: (bool on) => setState(() => _ownedOnly = on),
                  ),
                  InkChip(
                    label: favouritesLabel,
                    selected: _favoritesOnly,
                    onSelected: (bool on) =>
                        setState(() => _favoritesOnly = on),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: InkSpacing.gutter),
              child: compact
                  ? Tooltip(
                      message: filtersLabel,
                      // The chip says it in its own semantics label.
                      excludeFromSemantics: true,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: compactWidth),
                        child: InkChip(
                          key: const ValueKey<String>('swatches-filters'),
                          label: compactLabel,
                          semanticLabel: filtersLabel,
                          icon: InkIcons.filterLines,
                          selected: active > 0,
                          onSelected: (_) =>
                              _openFilters(context, scope, colors),
                        ),
                      ),
                    )
                  : InkChip(
                      key: const ValueKey<String>('swatches-filters'),
                      label: filtersLabel,
                      icon: InkIcons.filterLines,
                      selected: active > 0,
                      onSelected: (_) => _openFilters(context, scope, colors),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _emptyState(
    BuildContext context, {
    required bool noCollection,
    required bool noFavorites,
    required bool noOwnedFavorites,
  }) {
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
    // "Favourites" is on and nothing is starred: the filters are not the
    // cause, so the text says what to do instead of blaming them.
    if (_favoritesOnly && noFavorites) {
      return EmptyState(
        key: const ValueKey<String>('swatches-empty-no-favorites'),
        title: context.l10n.swatchesEmptyNoFavoritesTitle,
        message: context.l10n.swatchesEmptyNoFavoritesBody,
        icon: InkIcons.star,
        actionLabel: context.l10n.swatchesEmptyNoFavoritesAction,
        onAction: () => setState(() {
          _favoritesOnly = false;
          _ownedOnly = false;
        }),
      );
    }
    // "Mine" and "Favourites" can be on together: the favourites exist, but
    // none of them is a marker the user owns.
    if (_favoritesOnly && _ownedOnly && noOwnedFavorites) {
      return EmptyState(
        key: const ValueKey<String>('swatches-empty-favorites-not-mine'),
        title: context.l10n.swatchesEmptyFavoritesNotMineTitle,
        message: context.l10n.swatchesEmptyFavoritesNotMineBody,
        icon: InkIcons.star,
        actionLabel: context.l10n.swatchesEmptyFavoritesNotMineAction,
        onAction: () => setState(() => _ownedOnly = false),
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
      // The button says what it clears, and clears exactly that.
      actionLabel: switch ((searching, _hasNarrowingFilters)) {
        (true, true) => context.l10n.swatchesClearSearchAndFilters,
        (true, false) => context.l10n.swatchesClearSearch,
        _ => context.l10n.swatchesClearFilters,
      },
      onAction: _clearSearchAndFilters,
    );
  }

  /// Whether the favourites switch or a series / set filter narrows the list
  /// (the search text and the "Mine" scope are not counted).
  bool get _hasNarrowingFilters =>
      _favoritesOnly || _selectedPackId != null || _selectedLines.isNotEmpty;

  /// The empty state's button: clears the search text and every filter it
  /// names. The layout (grid / list) and the "Mine" scope stay as they are.
  void _clearSearchAndFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _favoritesOnly = false;
      _selectedPackId = null;
      _selectedLines.clear();
    });
  }

  /// Whether [color] is sold in one of the lines picked in the filters.
  bool _inSelectedLines(MarkerColor color) =>
      _selectedLines.isEmpty || _selectedLines.any(color.inLine);

  /// "Closest to #2D6E9C", with the colour, over the markers of a hex search.
  Widget _closestTo(BuildContext context, int colorInt) {
    final InkColors ink = InkColors.of(context);
    final Color color = Color(colorInt);
    final String hex = '#${colorIntToHex(colorInt)}';
    return Padding(
      key: const ValueKey<String>('swatches-closest-to'),
      padding: const EdgeInsets.fromLTRB(
        InkSpacing.pageMargin,
        0,
        InkSpacing.pageMargin,
        InkSpacing.group,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: InkGeometry.smallIcon,
            height: InkGeometry.smallIcon,
            decoration: BoxDecoration(
              color: color,
              borderRadius: InkRadii.xsRadius,
              border: Border.all(color: ink.swatchEdge(color)),
            ),
          ),
          const SizedBox(width: InkSpacing.s8),
          Expanded(
            child: Text(
              context.l10n.swatchesClosestTo(hex),
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
          ),
        ],
      ),
    );
  }

  /// Whether [color] passes the favourites switch and the search text; with
  /// [ignoreQuery] only the favourites switch counts.
  bool _matches(
    MarkerColor color,
    AppSettingsState state, {
    bool ignoreQuery = false,
  }) {
    if (_favoritesOnly && !state.favorites.contains(color.colorId)) {
      return false;
    }
    if (ignoreQuery || _query.isEmpty) return true;
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
  /// Only Ohuhu has packs; every other brand is organised by ownership
  /// instead.
  List<String> _availablePacks(List<MarkerColor> colors, MarkerBrand brand) {
    if (!brand.hasRetailSets) return const <String>[];
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
      padding: const EdgeInsets.only(
        top: InkSpacing.block,
        bottom: InkSpacing.s4,
      ),
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
                  const SizedBox(height: InkSpacing.s24),
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

  /// Stores [hex] as the own colour of [color], or forgets it when it is the
  /// catalogue's own colour. An own colour is only seen while "Use my colours"
  /// is on, so saving one switches it on.
  Future<void> _storeOwnColor(
    AppScope scope,
    MarkerColor color,
    String hex,
  ) async {
    if (hex == normalizeOwnHex(color.originalHex)) {
      await scope.ownColors.remove(color.colorId);
      return;
    }
    await scope.ownColors.set(color.colorId, hex);
    if (!scope.settings.state.useOwnColors) {
      await scope.settings.setUseOwnColors(true);
    }
  }

  /// Whether [color] is in the collection right now (sets or loose markers).
  bool _isOwnedNow(AppScope scope, MarkerColor color) {
    final AppSettings settings = scope.settings.settings;
    final MarkerBrand brand = MarkerBrand.fromId(color.brandId);
    return isOwnedColor(
      color,
      ownedSetIds: brand.hasRetailSets
          ? settings.ownedSetIds
          : const <String>{},
      extraCodes: scopedCodesForBrand(settings.extraMarkerIds, brand.id),
    );
  }

  Future<BrandEquivalentsIndex> _indexFor(AppScope scope) {
    final int revision = scope.markers.colorRevision;
    final Future<BrandEquivalentsIndex>? kept = _equivalentsIndex;
    if (kept != null && _equivalentsRevision == revision) return kept;
    final Future<BrandEquivalentsIndex> index = BrandEquivalentsIndex.load(
      scope.markers,
    );
    _equivalentsRevision = revision;
    _equivalentsIndex = index;
    // A failed read is not kept: the next sheet tries again.
    index.then<void>(
      (_) {},
      onError: (Object _) {
        if (identical(_equivalentsIndex, index)) _equivalentsIndex = null;
      },
    );
    return index;
  }

  Future<List<BrandEquivalentGroup>> _equivalentsOf(
    AppScope scope,
    MarkerColor marker, {
    required bool onlyMine,
  }) async {
    final BrandEquivalentsIndex index = await _indexFor(scope);
    return index.closestTo(
      marker,
      settings: scope.settings.settings,
      driedIds: scope.dried.ids,
      onlyMine: onlyMine,
    );
  }

  /// The markers the user owns and can use, of every brand: what "Shadow
  /// and light", "Blend with…" and the near-duplicates measure against.
  Future<List<MarkerColor>> _ownedMarkers(AppScope scope) async {
    final BrandEquivalentsIndex index = await _indexFor(scope);
    return index.ownedUsable(
      scope.settings.settings,
      driedIds: scope.dried.ids,
    );
  }

  /// The ids of the brands the user owns at least one marker of.
  Future<Set<String>> _ownedBrands(AppScope scope) async {
    final BrandEquivalentsIndex index = await _indexFor(scope);
    return index.ownedBrandIds(scope.settings.settings);
  }

  /// Changes whenever the collection (or what is dried out) does, so the
  /// sections that measure against it measure again.
  Object _collectionSignature(AppScope scope) {
    final AppSettings settings = scope.settings.settings;
    return Object.hash(
      scope.markers.colorRevision,
      scope.dried.revision,
      Object.hashAll(settings.ownedSetIds.toList()..sort()),
      Object.hashAll(settings.extraMarkerIds.toList()..sort()),
    );
  }

  Future<void> _openDetail(
    BuildContext context,
    AppScope scope,
    MarkerColor color,
    List<MarkerColor> candidates, {
    bool? forPane,
  }) async {
    // The search field must not keep the focus under the detail: closing the
    // sheet would bring the keyboard back over the list.
    FocusManager.instance.primaryFocus?.unfocus();
    // Where the detail goes is decided now, not after the catalogue is read:
    // a page that changes width meanwhile is put right by the layout pass.
    final bool inPane = forPane ?? _twoPane;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final AppLocalizations l10n = context.l10n;
    MarkerColor current = color;
    List<MarkerColor> pool = candidates;
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

    // On a wide page the detail opens in the pane next to the grid.
    // The sheet opens at half height and can be dragged up to the full
    // screen; the controller lets it go back to half when the marker
    // changes.
    final DraggableScrollableController? sheetController = inPane
        ? null
        : DraggableScrollableController();
    // The entries of the "⋯" menu, which lives in the frame of the sheet.
    final InkMenuItemsNotifier menuItems = InkMenuItemsNotifier();

    // The markers the user owns, measured again only when the collection
    // changes, and the photo of the real swatch of the marker on screen.
    Future<List<MarkerColor>>? ownedFuture;
    Object? ownedSignature;
    Uint8List? photoBytes;
    String? photoKey;
    bool sheetClosed = false;
    // Whether the sheet was taken away because the page got wide: the marker
    // then goes on in the pane instead of being forgotten.
    bool handedToPane = false;
    // This sheet's hand-over: the field may hold another sheet's by the time
    // this one is gone.
    bool Function()? mine;

    Widget detail(BuildContext sheetContext, ScrollController scroll) {
      if (!inPane && !sheetClosed) {
        final ModalRoute<Object?>? route = ModalRoute.of(sheetContext);
        final NavigatorState? navigator = route?.navigator;
        if (route != null && navigator != null) {
          mine ??= () {
            if (!route.isCurrent) return false;
            handedToPane = true;
            navigator.removeRoute(route);
            return true;
          };
          _handSheetToPane = mine;
        }
      }
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setSheetState) {
          // Remembered, so a change of layout can show it again.
          if (!sheetClosed) _selection = (color: current, pool: pool);
          if (inPane) {
            // Outline the marker on screen in the grid (after the frame:
            // the grid is another part of the tree).
            final String shown = current.colorId;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (sheetClosed || !mounted || _paneShown.value == shown) {
                return;
              }
              _paneShown.value = shown;
              setState(() {});
            });
          }
          final Object signature = _collectionSignature(scope);
          if (ownedFuture == null || signature != ownedSignature) {
            ownedSignature = signature;
            ownedFuture = _ownedMarkers(scope);
          }
          final String? photoName = scope.markerExtras.photoNameOf(
            current.colorId,
          );
          // Load the photo of the marker on screen; a stale answer (another
          // marker, another photo, a closed sheet) is dropped.
          final String? wantedPhoto = photoName == null
              ? null
              : '${current.colorId}/$photoName';
          if (wantedPhoto != photoKey) {
            photoKey = wantedPhoto;
            photoBytes = null;
            if (wantedPhoto != null) {
              scope.markerExtras.photoBytes(current.colorId).then((
                Uint8List? bytes,
              ) {
                if (sheetClosed || photoKey != wantedPhoto) return;
                photoBytes = bytes;
                setSheetState(() {});
              });
            }
          }

          // Moves the sheet to another marker, of this brand or another.
          Future<void> selectMarker(MarkerColor other) async {
            if (other.brandId != current.brandId) {
              final MarkerBrand brand = MarkerBrand.fromId(other.brandId);
              final List<MarkerColor> all = await scope.markers.loadColors(
                brand,
              );
              pool = swatchCandidateColors(colors: all, brand: brand);
            }
            if (!context.mounted) return;
            setSheetState(() => current = other);
          }

          // A marker that ran dry is one to buy again: offer the list.
          Future<void> afterLevelChange(
            MarkerColor marker,
            InkLevel before,
            InkLevel after,
          ) async {
            if (!context.mounted) return;
            setSheetState(() {});
            if (after != InkLevel.dried || before == InkLevel.dried) return;
            if (scope.wishlist.contains(marker.colorId)) return;
            final bool add = await confirmAction(
              context,
              title: l10n.wishlistOfferTitle,
              body: l10n.wishlistOfferBody(marker.newCode),
              confirmLabel: l10n.wishlistAdd,
            );
            if (!add) return;
            await scope.wishlist.add(marker.colorId);
            if (context.mounted) setSheetState(() {});
          }

          Future<void> pickSwatchPhoto(
            MarkerColor marker,
            PhotoSource source,
          ) async {
            final PhotoPickResult result = await _swatchPicker.pick(source);
            String? message;
            switch (result) {
              case PhotoPicked(:final Uint8List bytes):
                final bool saved = await scope.markerExtras.setPhoto(
                  marker.colorId,
                  bytes,
                );
                message = saved
                    ? l10n.swatchPhotoSaved
                    : l10n.swatchPhotoSaveFailed;
              case PhotoPickCancelled():
                break;
              case PhotoPickDenied(source: final PhotoSource denied):
                message = denied == PhotoSource.camera
                    ? l10n.matchCameraDenied
                    : l10n.matchGalleryDenied;
              case PhotoPickFailed():
                message = l10n.matchPickFailed;
            }
            if (context.mounted) setSheetState(() {});
            if (message != null) {
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(message)));
            }
          }

          return SwatchDetailSheet(
            color: current,
            favorite: scope.settings.isFavorite(current.colorId),
            lineLabels: MarkerBrand.fromId(current.brandId)
                .rangeLabels(current.lines),
            // Human labels only: a raw id ("decotime_base") is never shown.
            packLabels: <String>[
              for (final String id in current.sets) ?l10n.setLabel(id),
            ],
            cardLocation: cardLocationOf(current),
            alternatives: closestAlternatives(current, pool),
            onSelectAlternative: (MarkerColor other) =>
                setSheetState(() => current = other),
            // The sheet moves to the marker of the other brand, as it does
            // for an alternative; its own alternatives are then the markers
            // of that brand.
            onSelectNeighbour: selectMarker,
            ownedMarkers: ownedFuture,
            blendCatalogue: pool,
            brandEquivalents: BrandEquivalentsSection(
              marker: current,
              loader: (MarkerColor marker, {required bool onlyMine}) =>
                  _equivalentsOf(scope, marker, onlyMine: onlyMine),
              ownedBrands: () => _ownedBrands(scope),
              onSelect: selectMarker,
            ),
            inkLevel: scope.markerExtras.levelOf(current.colorId),
            onInkLevelChanged: (InkLevel level) async {
              final MarkerColor marker = current;
              final InkLevel before = scope.markerExtras.levelOf(
                marker.colorId,
              );
              await scope.markerExtras.setLevel(marker.colorId, level);
              await afterLevelChange(marker, before, level);
            },
            refillNote: scope.markerExtras.noteOf(current.colorId),
            onEditRefillNote: () async {
              final MarkerColor marker = current;
              final String? text = await showRefillNoteDialog(
                context,
                current: scope.markerExtras.noteOf(marker.colorId),
              );
              if (text == null) return;
              await scope.markerExtras.setNote(marker.colorId, text);
              if (context.mounted) setSheetState(() {});
            },
            hasPhoto: photoName != null,
            photo: photoBytes,
            onSwatchPhoto: () async {
              final MarkerColor marker = current;
              final SwatchPhotoAction? action = await showSwatchPhotoActions(
                context,
                hasPhoto:
                    scope.markerExtras.photoNameOf(marker.colorId) != null,
              );
              if (action == null || !context.mounted) return;
              switch (action) {
                case SwatchPhotoAction.take:
                  await pickSwatchPhoto(marker, PhotoSource.camera);
                case SwatchPhotoAction.choose:
                  await pickSwatchPhoto(marker, PhotoSource.gallery);
                case SwatchPhotoAction.view:
                  final Uint8List? bytes = await scope.markerExtras.photoBytes(
                    marker.colorId,
                  );
                  if (bytes != null && context.mounted) {
                    await showSwatchPhotoViewer(context, bytes);
                  }
                case SwatchPhotoAction.remove:
                  await scope.markerExtras.removePhoto(marker.colorId);
                  if (!context.mounted) return;
                  setSheetState(() {});
                  messenger
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text(l10n.swatchPhotoRemoved)),
                    );
              }
            },
            // A code alone is ambiguous across brands, and a palette only
            // holds the brand chosen in Settings.
            brandLabel: current.brandId == scope.settings.brand.id
                ? null
                : MarkerBrand.fromId(current.brandId).label,
            showPaletteActions: current.brandId == scope.settings.brand.id,
            onSetOwnColor: () async {
              final String? hex = await OwnColorPage.open(
                context,
                current,
                picker: widget.picker,
                decoder: widget.decoder,
              );
              if (hex == null) return;
              await _storeOwnColor(scope, current, hex);
              final List<MarkerColor> all = await scope.markers.loadColors(
                MarkerBrand.fromId(current.brandId),
              );
              current =
                  <MarkerColor>[
                    for (final MarkerColor c in all)
                      if (c.colorId == current.colorId) c,
                  ].firstOrNull ??
                  current;
              pool = swatchCandidateColors(
                colors: all,
                brand: MarkerBrand.fromId(current.brandId),
              );
              if (!context.mounted) return;
              setSheetState(() {});
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(l10n.swatchesMyColourSaved)),
                );
            },
            onResetOwnColor: () async {
              await scope.ownColors.remove(current.colorId);
              final List<MarkerColor> all = await scope.markers.loadColors(
                MarkerBrand.fromId(current.brandId),
              );
              current =
                  <MarkerColor>[
                    for (final MarkerColor c in all)
                      if (c.colorId == current.colorId) c,
                  ].firstOrNull ??
                  current;
              pool = swatchCandidateColors(
                colors: all,
                brand: MarkerBrand.fromId(current.brandId),
              );
              if (!context.mounted) return;
              setSheetState(() {});
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(l10n.swatchesMyColourWasReset)),
                );
            },
            wished: scope.wishlist.contains(current.colorId),
            dried: scope.dried.contains(current.colorId),
            owned: _isOwnedNow(scope, current),
            onToggleWishlist: () async {
              await scope.wishlist.toggle(current.colorId);
              if (context.mounted) setSheetState(() {});
            },
            onToggleDried: () async {
              final MarkerColor marker = current;
              final InkLevel before = scope.markerExtras.levelOf(
                marker.colorId,
              );
              final InkLevel after = before == InkLevel.dried
                  ? InkLevel.full
                  : InkLevel.dried;
              await scope.markerExtras.setLevel(marker.colorId, after);
              await afterLevelChange(marker, before, after);
            },
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
            onBlendingChain: widget.onBlendingChain == null
                ? null
                : () {
                    if (!inPane) Navigator.of(sheetContext).maybePop();
                    widget.onBlendingChain!(current);
                  },
            onAddToPalette: () async {
              final ValueChanged<MarkerColor>? hook = widget.onAddToPalette;
              if (hook != null) {
                if (!inPane) Navigator.of(sheetContext).maybePop();
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
            scrollController: scroll,
            sheetController: sheetController,
            menuItems: menuItems,
          );
        },
      );
    }

    // Remembered from the start: the detail may be hidden (a narrow page)
    // before it is ever built.
    _selection = (color: current, pool: pool);
    if (inPane) {
      _pane?.closed();
      if (_paneScroll.hasClients) _paneScroll.jumpTo(0);
      setState(() {
        _pane = _PaneDetail(
          builder: detail,
          menuItems: menuItems,
          closed: () => sheetClosed = true,
        );
      });
      return;
    }

    await showInkDraggableSheet<void>(
      context: context,
      controller: sheetController,
      initial: 0.5,
      snaps: const <double>[0.5],
      max: 1.0,
      min: 0.25,
      actions: <Widget>[_SwatchOverflowMenu(items: menuItems)],
      builder: detail,
    ).whenComplete(() {
      sheetClosed = true;
      sheetController!.dispose();
      if (identical(_handSheetToPane, mine)) _handSheetToPane = null;
      if (!handedToPane) _selection = null;
    });
  }
}

/// A marker's detail shown in the pane of the two-pane layout.
class _PaneDetail {
  _PaneDetail({
    required this.builder,
    required this.menuItems,
    required this.closed,
  });

  /// Builds the detail (the same content as the sheet's).
  final Widget Function(BuildContext context, ScrollController scroll) builder;

  /// The entries of the pane's "⋯" menu.
  final InkMenuItemsNotifier menuItems;

  /// Tells the detail it is gone (stale photo loads are dropped).
  final VoidCallback closed;
}

/// The "⋯" of the swatch sheet: it lives in the frame of the sheet, next to
/// the close button, and shows the entries the sheet publishes.
class _SwatchOverflowMenu extends StatefulWidget {
  const _SwatchOverflowMenu({super.key, required this.items});

  /// The entries of the menu. The sheet fills this list.
  final InkMenuItemsNotifier items;

  @override
  State<_SwatchOverflowMenu> createState() => _SwatchOverflowMenuState();
}

class _SwatchOverflowMenuState extends State<_SwatchOverflowMenu> {
  @override
  void dispose() {
    widget.items.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<InkMenuItem>>(
      valueListenable: widget.items,
      builder: (BuildContext context, List<InkMenuItem> items, Widget? child) =>
          InkOverflowMenu(
            key: const ValueKey<String>('swatch-overflow'),
            items: items,
          ),
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
            gridDelegate: ColorSwatchTile.gridDelegate(context, showHex: false),
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) => SkeletonBlock(
              height: ColorSwatchTile.gridCellHeight(context, showHex: false),
            ),
          ),
        ),
      ],
    );
  }
}
