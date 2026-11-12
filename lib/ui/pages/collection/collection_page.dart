import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/section_card.dart';
import '../../share/share_sink.dart';
import '../settings/dialogs.dart';
import '../settings/settings_widgets.dart';
import '../tools/collection_tools_rows.dart';
import '../tools/collection_transfer_page.dart';
import 'brand_picker.dart';
import 'collection_pickers.dart';
import 'collection_summary.dart';
import 'collection_summary_card.dart';
import 'dried_card.dart';
import 'purchase_card.dart';
import 'swatch_chart_card.dart';
import 'loose_markers_page.dart';
import 'wishlist_card.dart';

/// "My collection": the one place where the user says which markers they
/// own (see `AppSettings`).
///
/// Three `caps` groups, as in Settings. *What you own* keeps the brand picker
/// and the summary, and folds the series, the sets and the loose markers into
/// summary rows. *Shopping* holds what to buy next, the wishlist and the dried
/// out markers. *Tools* keeps the printable swatch chart, and "Reset
/// collection" closes the page as a text button.
class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key, this.shareSink});

  /// Where the printable swatch chart goes. Production opens the system share
  /// sheet; tests inject a fake.
  final ShareSink? shareSink;

  /// Key of the page body.
  static const Key pageKey = Key('collection-page');

  /// Pushes the page on the nearest navigator.
  static Future<void> open(BuildContext context) =>
      AppScope.push(context, const CollectionPage());

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

/// What the page reads: the colours of the active brand, and the colours of
/// every brand the user owns a marker of.
typedef _Catalogs = ({List<MarkerColor> catalog, List<MarkerColor> owned});

class _CollectionPageState extends State<CollectionPage> {
  AppScope? _scope;
  Stream<AppSettingsState>? _changes;

  /// A marker ran dry or is usable again: "Mix my brands" is offered only
  /// with usable markers of two brands.
  StreamSubscription<Set<String>>? _driedChanges;

  /// The catalogues the page reads, kept while what they depend on (the
  /// brand, the collection, the user's own colours) stays the same, so a
  /// rebuild never starts the reading again.
  String? _catalogsKey;
  Future<_Catalogs>? _catalogs;

  /// Whether the "Series you own" and "Sets you own" groups of the Ohuhu
  /// collection are open (both start folded).
  bool _seriesOpen = false;
  bool _setsOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _changes = scope.settings.changes;
      _driedChanges?.cancel();
      _driedChanges = scope.dried.changes.listen((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _driedChanges?.cancel();
    super.dispose();
  }

  /// The colours of the active brand, and the colours of every brand the
  /// user owns a marker of (to know which brands can be mixed).
  Future<_Catalogs> _catalogsOf(AppScope scope, AppSettingsState state) {
    final List<String> owned = <String>[
      ...state.settings.effectiveSetIds(),
      ...state.settings.ownedMarkerCodes,
    ]..sort();
    final String key =
        '${state.brand.id}|${scope.markers.colorRevision}|${owned.join(',')}';
    final Future<_Catalogs>? current = _catalogs;
    if (current != null && key == _catalogsKey) return current;
    _catalogsKey = key;
    return _catalogs = () async {
      final List<MarkerColor> catalog = await scope.markers.loadColors(
        state.brand,
      );
      final List<MarkerColor> owned = await scope.markers.loadCollectionCatalog(
        brand: state.brand,
        settings: state.settings,
        allOwnedBrands: true,
      );
      return (catalog: catalog, owned: owned);
    }();
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.collectionTitle)),
      body: InkReadableWidth(
        child: StreamBuilder<AppSettingsState>(
          stream: _changes,
          initialData: scope.settings.state,
          builder: (BuildContext context, AsyncSnapshot<AppSettingsState> s) {
            final AppSettingsState state = s.data ?? scope.settings.state;
            return FutureBuilder<_Catalogs>(
              future: _catalogsOf(scope, state),
              builder: (BuildContext context, AsyncSnapshot<_Catalogs> c) {
                if (!c.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _content(
                  context,
                  scope,
                  state,
                  c.data!.catalog,
                  c.data!.owned,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _content(
    BuildContext context,
    AppScope scope,
    AppSettingsState state,
    List<MarkerColor> catalog,
    List<MarkerColor> ownedCatalog,
  ) {
    final InkColors ink = InkColors.of(context);
    final MarkerBrand brand = state.brand;
    final bool ohuhu = brand.hasRetailSets;
    final AppSettings settings = state.settings;
    final Set<MarkerLine> series = settings.ownedSeries;
    final List<MarkerColor> range = brandRangeColors(
      colors: catalog,
      brand: brand,
    );
    final Set<String> extras = scopedCodesForBrand(
      settings.extraMarkerIds,
      brand.id,
    );
    // The brands with a usable marker: two or more can be mixed.
    final List<MarkerBrand> mixable = usableOwnedBrands(
      colors: ownedCatalog,
      activeSetIds: settings.effectiveSetIds(),
      ownedMarkerCodes: settings.ownedMarkerCodes,
      driedColorIds: scope.dried.ids,
    );
    final CollectionSummary summary = CollectionSummary.of(state, catalog);
    final String seriesLabel = <String>[
      for (final MarkerLine line in MarkerLine.values)
        if (series.contains(line)) line.label,
    ].join(' + ');
    final TextStyle caption = AppTypography.secondary.copyWith(color: ink.fg2);
    // The row that opens the text import, for every brand: it is defined
    // once, so the two branches of the collection never drift apart.
    final Widget importCodesRow = InkListRow(
      key: const ValueKey<String>('collection-import-codes'),
      label: context.l10n.collectionImportCodesTitle,
      // One line under the title, like the Sets row; the help sentence is
      // on the page the row opens.
      subtitle: context.l10n.collectionImportCodesHint,
      chevron: true,
      onTap: () => CollectionTransferPage.open(
        context,
        shareSink: widget.shareSink,
        initialSection: CollectionTransferSection.import,
      ),
    );

    return SingleChildScrollView(
      key: CollectionPage.pageKey,
      padding: EdgeInsets.fromLTRB(
        InkSpacing.gutter,
        InkSpacing.section,
        InkSpacing.gutter,
        InkSpacing.pageBottomOf(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // What you own.
          SettingsGroup(
            title: context.l10n.collectionOwnedGroup,
            children: <Widget>[
              // The brand list can keep growing, so it lives behind a
              // picker, never inline.
              InkListRow(
                key: const ValueKey<String>('collection-brand'),
                label: context.l10n.settingsBrandTitle,
                value: brand.label,
                chevron: true,
                onTap: () => showBrandPicker(context, scope: scope),
              ),
              // "Mix my brands": Palette, Ideas, the Colour map, the AI and
              // the home widget use the markers of every brand the user owns.
              // Only offered when there are two brands to mix; with fewer the
              // stored choice does nothing.
              if (mixable.length >= 2)
                SettingsSwitchRow(
                  key: const ValueKey<String>('collection-mix-brands'),
                  label: context.l10n.collectionMixBrands,
                  // One line, like the rows around it: the brands that are
                  // mixed ("Ohuhu + DecoTime", "Ohuhu, DecoTime and 1 more"),
                  // or how many when their names do not fit ("3 brands").
                  subtitle: mixable.length == 2
                      ? '${mixable[0].label} + ${mixable[1].label}'
                      : context.l10n.collectionMoreBrands(
                          mixable[0].label,
                          mixable[1].label,
                          mixable.length - 2,
                        ),
                  singleLine: true,
                  shortSubtitle: context.l10n.collectionBrandsCount(
                    mixable.length,
                  ),
                  value: state.scope == BrandScope.mixedBrands,
                  onChanged: (bool on) => scope.settings.setScope(
                    on ? BrandScope.mixedBrands : BrandScope.singleBrand,
                  ),
                ),
              KeyedSubtree(
                key: const ValueKey<String>('collection-summary'),
                child: CollectionSummaryCard(summary: summary, embedded: true),
              ),
              if (ohuhu) ...<Widget>[
                InkDisclosure(
                  key: const ValueKey<String>('collection-series'),
                  title: context.l10n.collectionSeriesTitle,
                  subtitle: series.isEmpty ? null : seriesLabel,
                  expanded: _seriesOpen,
                  onToggle: () => setState(() => _seriesOpen = !_seriesOpen),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      InkSpacing.cardH,
                      0,
                      InkSpacing.cardH,
                      InkSpacing.cardV,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SeriesChips(
                          selected: series,
                          onToggle: (MarkerLine line, bool on) =>
                              _toggleSeries(context, scope, line, on, catalog),
                        ),
                        if (series.contains(MarkerLine.honolulu)) ...<Widget>[
                          const SizedBox(height: InkSpacing.group),
                          Text(
                            context.l10n.collectionHonoluluNote,
                            style: caption,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                InkDisclosure(
                  key: const ValueKey<String>('collection-sets'),
                  title: context.l10n.collectionSetsTitle,
                  subtitle: settings.ownedSetIds.isEmpty
                      ? context.l10n.collectionSetsEmpty
                      : context.l10n.collectionSets(
                          settings.ownedSetIds.length,
                        ),
                  expanded: _setsOpen,
                  onToggle: () => setState(() => _setsOpen = !_setsOpen),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      InkSpacing.cardH,
                      0,
                      InkSpacing.cardH,
                      InkSpacing.cardV,
                    ),
                    child: series.isEmpty
                        ? Text(context.l10n.collectionSetsEmpty, style: caption)
                        : SeriesSetPicker(
                            series: series,
                            ownedSetIds: settings.ownedSetIds,
                            onToggle: (OahuSet set, bool on) =>
                                _toggleSet(context, scope, set, on, catalog),
                          ),
                  ),
                ),
                importCodesRow,
                InkListRow(
                  key: const ValueKey<String>('collection-add-loose'),
                  label: context.l10n.collectionExtrasTitle,
                  // One line under the title, like the Sets row; the help
                  // sentence is on the page the row opens.
                  subtitle: context.l10n.collectionExtrasCount(extras.length),
                  chevron: true,
                  onTap: () => LooseMarkersPage.open(context),
                ),
              ] else ...<Widget>[
                if (brand == MarkerBrand.decoTime)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      InkSpacing.cardH,
                      InkSpacing.cardV,
                      InkSpacing.cardH,
                      InkSpacing.group,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          context.l10n.collectionDecoSizesHint,
                          style: caption,
                        ),
                        const SizedBox(height: InkSpacing.block),
                        InkGroupHead(context.l10n.collectionFamiliesTitle),
                        _familyChips(context, scope, range, extras),
                      ],
                    ),
                  ),
                importCodesRow,
                InkListRow(
                  key: const ValueKey<String>('collection-add-loose'),
                  label: context.l10n.collectionDecoMarkersTitle,
                  value: context.l10n.collectionMarkers(extras.length),
                  // One line under the title, like the Sets row; the help
                  // sentence is on the page the row opens.
                  subtitle: context.l10n.collectionIndividualMarkersShort,
                  chevron: true,
                  onTap: () => LooseMarkersPage.open(context),
                ),
              ],
            ],
          ),
          const SizedBox(height: InkSpacing.section),
          // Shopping.
          SettingsGroup(
            title: context.l10n.collectionShoppingGroup,
            children: <Widget>[
              PurchaseCard(
                key: const ValueKey<String>('collection-buy-next'),
                brand: brand,
                catalog: catalog,
                settings: settings,
                nameDisplayMode: state.nameDisplayMode,
              ),
              WishlistCard(
                key: const ValueKey<String>('collection-wishlist'),
                brand: brand,
                catalog: catalog,
                nameDisplayMode: state.nameDisplayMode,
              ),
              DriedCard(
                key: const ValueKey<String>('collection-dried'),
                brand: brand,
                catalog: catalog,
                nameDisplayMode: state.nameDisplayMode,
              ),
            ],
          ),
          const SizedBox(height: InkSpacing.section),
          // Tools.
          SettingsGroup(
            title: context.l10n.collectionToolsGroup,
            children: <Widget>[
              SwatchChartCard(
                brand: brand,
                markers: ownedColors(
                  colors: catalog,
                  brand: brand,
                  ownedSetIds: settings.ownedSetIds,
                  ownedMarkerCodes: settings.extraMarkerIds,
                ),
                nameDisplay: state.nameDisplayMode,
                shareSink: widget.shareSink,
              ),
              ...collectionToolRows(context, shareSink: widget.shareSink),
            ],
          ),
          const SizedBox(height: InkSpacing.section),
          _DestructiveButton(
            key: const ValueKey<String>('collection-reset'),
            label: context.l10n.collectionReset,
            onPressed:
                summary.isEmpty &&
                    !(ohuhu && settings.chosenSeriesIds.isNotEmpty)
                ? null
                : () => _reset(context, scope, brand),
          ),
        ],
      ),
    );
  }

  Widget _familyChips(
    BuildContext context,
    AppScope scope,
    List<MarkerColor> range,
    Set<String> extras,
  ) {
    bool all(List<MarkerColor> colors) => colors.every(
      (MarkerColor c) => extras.contains(c.newCode.toUpperCase()),
    );
    void toggle(List<MarkerColor> colors, String? name) =>
        _toggleFamily(context, scope, colors, name);
    final List<_FamilyChipData> chips = <_FamilyChipData>[
      _FamilyChipData(
        id: 'all',
        label: context.l10n.collectionWholeRange,
        widest: context.l10n.collectionWholeRange,
        selected: range.isNotEmpty && all(range),
        members: range,
        name: null,
      ),
      for (final String id in decoTimeFamilyIds)
        if (range.any((MarkerColor c) => c.sets.contains(id)))
          () {
            final List<MarkerColor> members = range
                .where((MarkerColor c) => c.sets.contains(id))
                .toList(growable: false);
            final int ownedCount = members
                .where(
                  (MarkerColor c) => extras.contains(c.newCode.toUpperCase()),
                )
                .length;
            final String family = context.l10n.decoFamilyLabel(id)!;
            return _FamilyChipData(
              id: id,
              label: context.l10n.collectionFamilyChip(
                family,
                ownedCount,
                members.length,
              ),
              // The count is longest when every marker is owned, so the lines
              // a chip needs never depend on how many are.
              widest: context.l10n.collectionFamilyChip(
                family,
                members.length,
                members.length,
              ),
              selected: ownedCount == members.length,
              members: members,
              name: family,
            );
          }(),
    ];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double gap = InkSpacing.chipGap;
        final double column = (constraints.maxWidth - gap) / 2;
        final List<String> widest = <String>[
          for (final chip in chips) chip.widest,
        ];
        // The text room of a chip: its width less the padding and the border.
        const double chrome = 2 * InkSpacing.s10 + 2;
        // Two lines of label at most, the same for every chip: the grid has
        // one chip height whatever the language, the text size or the state.
        // If a label would need a third line in a column (the longest
        // German and Portuguese families at 1.3x text on the narrowest
        // phone), the chips take a row each instead: never a cut label.
        final int columnLines = _familyChipLines(
          context,
          widest,
          column - chrome,
        );
        final bool twoColumns = columnLines <= 2;
        final int lines = twoColumns
            ? columnLines
            : _familyChipLines(
                context,
                widest,
                constraints.maxWidth - chrome,
              ).clamp(1, 2);
        Widget chip(_FamilyChipData data) => InkChip(
          key: ValueKey<String>('collection-family-${data.id}'),
          label: data.label,
          selected: data.selected,
          expand: true,
          lines: lines,
          onSelected: (_) => toggle(data.members, data.name),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int i = 0; i < chips.length; i += twoColumns ? 2 : 1)
              if (twoColumns && i + 1 < chips.length)
                Row(
                  children: <Widget>[
                    Expanded(child: chip(chips[i])),
                    const SizedBox(width: gap),
                    Expanded(child: chip(chips[i + 1])),
                  ],
                )
              else
                // An odd one out (or every chip, in one column) takes the
                // whole row.
                chip(chips[i]),
          ],
        );
      },
    );
  }

  /// How many lines the longest of [labels] needs in [width], in the chip's
  /// type at the current text scale.
  int _familyChipLines(
    BuildContext context,
    List<String> labels,
    double width,
  ) {
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    int lines = 1;
    for (final String label in labels) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: label, style: AppTypography.button),
        textDirection: direction,
        textScaler: scaler,
      )..layout(maxWidth: width);
      final int count = painter.computeLineMetrics().length;
      painter.dispose();
      if (count > lines) lines = count;
    }
    return lines;
  }

  Future<void> _toggleSeries(
    BuildContext context,
    AppScope scope,
    MarkerLine line,
    bool on,
    List<MarkerColor> catalog,
  ) async {
    // The series is stored on its own, so it stays when no set is picked yet.
    // The sets of a series the user does not own leave the collection.
    if (on) {
      final AppSettings current = scope.settings.settings;
      await scope.settings.setCollection(
        current.copyWith(
          chosenSeriesIds: <String>{...current.chosenSeriesIds, line.id},
        ),
      );
      return;
    }
    // Taking the series out takes its sets with it, and the markers of those
    // sets leave the collection: the user is asked first.
    final Set<String> lost = _setsOfSeries(scope, line);
    final int markers = catalog
        .where((MarkerColor color) => color.sets.any(lost.contains))
        .length;
    if (markers > 0) {
      final bool ok = await confirmAction(
        context,
        title: context.l10n.collectionRemoveFromTitle(markers, line.label),
        body: context.l10n.collectionRemoveMarkersBody,
        confirmLabel: context.l10n.collectionRemoveConfirm,
      );
      if (!ok || !mounted) return;
    }
    // The state is read again after the question: nothing that happened
    // meanwhile is lost.
    final AppSettings current = scope.settings.settings;
    final Set<String> lostNow = <String>{
      for (final String id in current.ownedSetIds)
        if (OahuSet.byId[id]?.line == line) id,
    };
    await scope.settings.setCollection(
      current.copyWith(
        chosenSeriesIds: <String>{...current.chosenSeriesIds}..remove(line.id),
        ownedSetIds: <String>{...current.ownedSetIds}..removeAll(lostNow),
      ),
    );
  }

  /// The ids of the sets of [line] the user owns right now.
  Set<String> _setsOfSeries(AppScope scope, MarkerLine line) => <String>{
    for (final String id in scope.settings.settings.ownedSetIds)
      if (OahuSet.byId[id]?.line == line) id,
  };

  /// Adds a family (or the whole range) to the collection, or takes it out
  /// of it.
  ///
  /// The decision is made with the collection the repository holds now, not
  /// with the copy this page was built with: markers the user imported in
  /// between are never lost. Taking markers out asks first: the user may
  /// have added them one by one.
  Future<void> _toggleFamily(
    BuildContext context,
    AppScope scope,
    List<MarkerColor> colors,
    String? name,
  ) async {
    if (colors.isEmpty) return;
    final Set<String> owned = _ownedNow(scope, colors);
    if (owned.length == colors.length) {
      final bool ok = await confirmAction(
        context,
        title: name == null
            ? context.l10n.collectionRemoveMarkersTitle(owned.length)
            : context.l10n.collectionRemoveFromTitle(owned.length, name),
        body: context.l10n.collectionRemoveMarkersBody,
        confirmLabel: context.l10n.collectionRemoveConfirm,
      );
      if (!ok || !mounted) return;
      await scope.settings.removeExtraMarkerIds(owned);
      return;
    }
    await scope.settings.addExtraMarkerIds(<String>{
      for (final MarkerColor color in colors) color.colorId,
    });
  }

  /// The ids of [colors] the user owns right now: the collection of the
  /// repository at this moment, not the copy the page was built with.
  Set<String> _ownedNow(AppScope scope, List<MarkerColor> colors) {
    final String brandId = colors.isEmpty
        ? scope.settings.brand.id
        : colors.first.brandId;
    final Set<String> extras = scopedCodesForBrand(
      scope.settings.settings.extraMarkerIds,
      brandId,
    );
    return <String>{
      for (final MarkerColor color in colors)
        if (extras.contains(color.newCode.toUpperCase())) color.colorId,
    };
  }

  /// Adds a set to the collection, or takes it out of it. Taking it out
  /// asks first: the markers of the set leave the collection.
  Future<void> _toggleSet(
    BuildContext context,
    AppScope scope,
    OahuSet set,
    bool on,
    List<MarkerColor> catalog,
  ) async {
    if (on) {
      final Set<String> next = <String>{
        ...scope.settings.settings.ownedSetIds,
        set.id,
      };
      await scope.settings.setOwnedSetIds(next);
      return;
    }
    final int markers = catalog
        .where((MarkerColor color) => color.sets.contains(set.id))
        .length;
    if (markers > 0) {
      final bool ok = await confirmAction(
        context,
        // The name of the set ("Honolulu 48"), not only the line it belongs
        // to: the question says what leaves the collection.
        title: context.l10n.collectionRemoveFromTitle(
          markers,
          context.l10n.packSetFullLabel(set),
        ),
        body: context.l10n.collectionRemoveMarkersBody,
        confirmLabel: context.l10n.collectionRemoveConfirm,
      );
      if (!ok || !mounted) return;
    }
    final Set<String> next = <String>{...scope.settings.settings.ownedSetIds}
      ..remove(set.id);
    await scope.settings.setOwnedSetIds(next);
  }

  Future<void> _reset(
    BuildContext context,
    AppScope scope,
    MarkerBrand brand,
  ) async {
    final bool ok = await confirmAction(
      context,
      title: context.l10n.collectionResetTitle(brand.label),
      body: context.l10n.collectionResetBody,
      confirmLabel: context.l10n.collectionReset,
    );
    if (!ok) return;
    final bool ohuhu = brand.hasRetailSets;
    // The collection is read again after the question: the markers the user
    // added in between are kept.
    final AppSettings current = scope.settings.settings;
    await scope.settings.setCollection(
      AppSettings(
        ownedSetIds: ohuhu ? const <String>{} : current.ownedSetIds,
        chosenSeriesIds: ohuhu ? const <String>{} : current.chosenSeriesIds,
        extraMarkerIds: current.extraMarkerIds
            .where((String id) => !colorIdBelongsToBrand(id, brand))
            .toSet(),
      ),
    );
  }
}

/// A full-width text button drawn in the error colour (irreversible action;
/// the caller asks for confirmation first).
class _DestructiveButton extends StatelessWidget {
  const _DestructiveButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final InkColors ink = InkColors.of(context);
    final ButtonStyle tint = ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) =>
            states.contains(WidgetState.disabled) ? null : ink.error,
      ),
    );
    return Theme(
      data: theme.copyWith(
        textButtonTheme: TextButtonThemeData(
          style: theme.textButtonTheme.style?.merge(tint) ?? tint,
        ),
      ),
      child: InkButton.text(label: label, expand: true, onPressed: onPressed),
    );
  }
}

/// One chip of the "Add by family" grid: its key id, the label it shows, the
/// label at its longest (every marker owned), whether it is on, the markers
/// it toggles and the name of the family (null for the whole range).
class _FamilyChipData {
  const _FamilyChipData({
    required this.id,
    required this.label,
    required this.widest,
    required this.selected,
    required this.members,
    required this.name,
  });

  final String id, label, widest;
  final bool selected;
  final List<MarkerColor> members;

  /// The name of the family, shown when the chips ask before removing
  /// markers; null for the whole range.
  final String? name;
}
