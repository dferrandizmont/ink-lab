import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/section_card.dart';
import '../settings/dialogs.dart';
import 'collection_pickers.dart';
import 'collection_summary.dart';
import 'collection_summary_card.dart';
import 'loose_markers_page.dart';

/// "My collection": the one place where the user says which markers they
/// own (see `AppSettings`).
///
/// Brand switch at the top, a summary card, then for Ohuhu the series, the
/// sets and a line that opens the loose markers on their own screen; for
/// DecoTime (which publishes no set contents) quick "add by family" chips and
/// the same line. "Reset collection" closes the page.
class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  /// Key of the page body.
  static const Key pageKey = Key('collection-page');

  /// Pushes the page on the nearest navigator.
  static Future<void> open(BuildContext context) =>
      AppScope.push(context, const CollectionPage());

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  AppScope? _scope;
  Stream<AppSettingsState>? _changes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _changes = scope.settings.changes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.collectionTitle)),
      body: StreamBuilder<AppSettingsState>(
        stream: _changes,
        initialData: scope.settings.state,
        builder: (BuildContext context, AsyncSnapshot<AppSettingsState> s) {
          final AppSettingsState state = s.data ?? scope.settings.state;
          return FutureBuilder<List<MarkerColor>>(
            future: scope.markers.loadColors(state.brand),
            builder:
                (BuildContext context, AsyncSnapshot<List<MarkerColor>> c) {
                  if (!c.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _content(context, scope, state, c.data!);
                },
          );
        },
      ),
    );
  }

  Widget _content(
    BuildContext context,
    AppScope scope,
    AppSettingsState state,
    List<MarkerColor> catalog,
  ) {
    final InkColors ink = InkColors.of(context);
    final MarkerBrand brand = state.brand;
    final bool ohuhu = brand == MarkerBrand.ohuhuOahu;
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
    final CollectionSummary summary = CollectionSummary.of(state, catalog);

    Widget head(String text) => Padding(
      padding: const EdgeInsets.only(top: InkSpacing.s24),
      child: InkGroupHead(text),
    );
    Widget caption(String text) => Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.group),
      child: Text(
        text,
        style: AppTypography.secondary.copyWith(color: ink.fg2),
      ),
    );

    return SingleChildScrollView(
      key: CollectionPage.pageKey,
      padding: const EdgeInsets.fromLTRB(
        InkSpacing.gutter,
        InkSpacing.group,
        InkSpacing.gutter,
        InkSpacing.pageBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkSegmented<MarkerBrand>(
            key: const ValueKey<String>('collection-brand'),
            expand: true,
            semanticLabel: context.l10n.settingsBrandTitle,
            segments: <InkSegment<MarkerBrand>>[
              for (final MarkerBrand b in MarkerBrand.values)
                InkSegment<MarkerBrand>(value: b, label: b.label),
            ],
            selected: brand,
            onChanged: (MarkerBrand b) => scope.settings.setBrand(b),
          ),
          const SizedBox(height: InkSpacing.block),
          KeyedSubtree(
            key: const ValueKey<String>('collection-summary'),
            child: CollectionSummaryCard(summary: summary),
          ),
          if (ohuhu) ...<Widget>[
            head(context.l10n.collectionSeriesTitle),
            SeriesChips(
              selected: series,
              onToggle: (MarkerLine line, bool on) =>
                  _toggleSeries(scope, settings, line, on),
            ),
            if (series.contains(MarkerLine.honolulu))
              Padding(
                padding: const EdgeInsets.only(top: InkSpacing.group),
                child: caption(context.l10n.collectionHonoluluNote),
              ),
            head(context.l10n.collectionSetsTitle),
            if (series.isEmpty)
              caption(context.l10n.collectionSetsEmpty)
            else
              SeriesSetPicker(
                series: series,
                ownedSetIds: settings.ownedSetIds,
                onToggle: (OahuSet set, bool on) {
                  final Set<String> next = <String>{...settings.ownedSetIds};
                  on ? next.add(set.id) : next.remove(set.id);
                  scope.settings.setOwnedSetIds(next);
                },
              ),
            head(context.l10n.collectionExtrasTitle),
            _MarkersRow(
              countLabel: context.l10n.collectionExtrasCount(extras.length),
              hint: context.l10n.collectionExtrasHint,
              buttonLabel: context.l10n.collectionExtrasAddTitle,
            ),
          ] else ...<Widget>[
            const SizedBox(height: InkSpacing.block),
            caption(context.l10n.collectionDecoHint),
            caption(context.l10n.collectionDecoSizesHint),
            head(context.l10n.collectionFamiliesTitle),
            _familyChips(context, scope, settings, range, extras),
            head(context.l10n.collectionDecoMarkersTitle),
            _MarkersRow(
              countLabel: context.l10n.collectionMarkers(extras.length),
              hint: null,
              buttonLabel: context.l10n.collectionDecoMarkersButton,
            ),
          ],
          const SizedBox(height: InkSpacing.section),
          _DestructiveButton(
            key: const ValueKey<String>('collection-reset'),
            label: context.l10n.collectionReset,
            onPressed:
                summary.isEmpty &&
                    !(ohuhu && settings.chosenSeriesIds.isNotEmpty)
                ? null
                : () => _reset(context, scope, settings, brand),
          ),
        ],
      ),
    );
  }

  Widget _familyChips(
    BuildContext context,
    AppScope scope,
    AppSettings settings,
    List<MarkerColor> range,
    Set<String> extras,
  ) {
    bool all(List<MarkerColor> colors) => colors.every(
      (MarkerColor c) => extras.contains(c.newCode.toUpperCase()),
    );
    void toggle(List<MarkerColor> colors) =>
        _setExtras(scope, settings, colors, add: !all(colors));
    return Wrap(
      spacing: InkSpacing.chipGap,
      runSpacing: InkSpacing.s4,
      children: <Widget>[
        InkChip(
          key: const ValueKey<String>('collection-family-all'),
          label: context.l10n.collectionWholeRange,
          selected: range.isNotEmpty && all(range),
          onSelected: (_) => toggle(range),
        ),
        for (final String id in decoTimeFamilyIds)
          if (range.any((MarkerColor c) => c.sets.contains(id)))
            Builder(
              builder: (BuildContext context) {
                final List<MarkerColor> members = range
                    .where((MarkerColor c) => c.sets.contains(id))
                    .toList(growable: false);
                final int ownedCount = members
                    .where(
                      (MarkerColor c) =>
                          extras.contains(c.newCode.toUpperCase()),
                    )
                    .length;
                return InkChip(
                  key: ValueKey<String>('collection-family-$id'),
                  label: context.l10n.collectionFamilyChip(
                    context.l10n.decoFamilyLabel(id)!,
                    ownedCount,
                    members.length,
                  ),
                  selected: ownedCount == members.length,
                  onSelected: (_) => toggle(members),
                );
              },
            ),
      ],
    );
  }

  void _toggleSeries(
    AppScope scope,
    AppSettings settings,
    MarkerLine line,
    bool on,
  ) {
    // The series is stored on its own, so it stays when no set is picked yet.
    // The sets of a series the user does not own leave the collection.
    final Set<String> chosen = <String>{...settings.chosenSeriesIds};
    final Set<String> sets = <String>{...settings.ownedSetIds};
    if (on) {
      chosen.add(line.id);
    } else {
      chosen.remove(line.id);
      sets.removeWhere((String id) => OahuSet.byId[id]?.line == line);
    }
    scope.settings.setCollection(
      settings.copyWith(chosenSeriesIds: chosen, ownedSetIds: sets),
    );
  }

  Future<void> _setExtras(
    AppScope scope,
    AppSettings settings,
    List<MarkerColor> colors, {
    required bool add,
  }) {
    final Set<String> next = <String>{...settings.extraMarkerIds};
    for (final MarkerColor color in colors) {
      add ? next.add(color.colorId) : next.remove(color.colorId);
    }
    return scope.settings.setExtraMarkerIds(next);
  }

  Future<void> _reset(
    BuildContext context,
    AppScope scope,
    AppSettings settings,
    MarkerBrand brand,
  ) async {
    final bool ok = await confirmAction(
      context,
      title: context.l10n.collectionResetTitle(brand.label),
      body: context.l10n.collectionResetBody,
      confirmLabel: context.l10n.collectionReset,
    );
    if (!ok) return;
    final bool ohuhu = brand == MarkerBrand.ohuhuOahu;
    await scope.settings.setCollection(
      AppSettings(
        ownedSetIds: ohuhu ? const <String>{} : settings.ownedSetIds,
        chosenSeriesIds: ohuhu ? const <String>{} : settings.chosenSeriesIds,
        extraMarkerIds: settings.extraMarkerIds
            .where((String id) => !colorIdBelongsToBrand(id, brand))
            .toSet(),
      ),
    );
  }
}

/// The loose-markers line of My collection: how many, and the button that
/// opens the full list on its own screen.
class _MarkersRow extends StatelessWidget {
  const _MarkersRow({
    required this.countLabel,
    required this.hint,
    required this.buttonLabel,
  });

  final String countLabel;
  final String? hint;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              countLabel,
              key: const ValueKey<String>('collection-extras-count'),
              style: AppTypography.body.copyWith(color: ink.fg),
            ),
            if (hint != null) ...<Widget>[
              const SizedBox(height: InkSpacing.s4),
              Text(
                hint!,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
            ],
            const SizedBox(height: InkSpacing.block),
            InkButton.secondary(
              key: const ValueKey<String>('collection-add-loose'),
              label: buttonLabel,
              expand: true,
              onPressed: () => LooseMarkersPage.open(context),
            ),
          ],
        ),
      ),
    );
  }
}

/// A full-width secondary button drawn in the error colour (irreversible
/// action; the caller asks for confirmation first).
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
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: theme.outlinedButtonTheme.style?.merge(tint) ?? tint,
        ),
      ),
      child: InkButton.secondary(
        label: label,
        expand: true,
        onPressed: onPressed,
      ),
    );
  }
}
