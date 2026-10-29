import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_search_field.dart';

/// "Add loose markers": every marker of the active brand with a search, a
/// tick per marker and "tick / untick what is in view". A marker that comes
/// with an owned set says "In your set" and cannot be ticked one by one.
///
/// For DecoTime (no sets) it is the list of the markers the user has. The
/// list is the page's own scroll, never a scroll inside a card.
class LooseMarkersPage extends StatefulWidget {
  const LooseMarkersPage({super.key});

  /// Key of the page body.
  static const Key pageKey = Key('loose-markers-page');

  /// Pushes the page on the nearest navigator.
  static Future<void> open(BuildContext context) =>
      AppScope.push(context, const LooseMarkersPage());

  @override
  State<LooseMarkersPage> createState() => _LooseMarkersPageState();
}

class _LooseMarkersPageState extends State<LooseMarkersPage> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

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
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    return StreamBuilder<AppSettingsState>(
      stream: _changes,
      initialData: scope.settings.state,
      builder: (BuildContext context, AsyncSnapshot<AppSettingsState> s) {
        final AppSettingsState state = s.data ?? scope.settings.state;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.brand == MarkerBrand.ohuhuOahu
                  ? context.l10n.collectionExtrasAddTitle
                  : context.l10n.collectionDecoMarkersTitle,
            ),
          ),
          body: FutureBuilder<List<MarkerColor>>(
            future: scope.markers.loadColors(state.brand),
            builder:
                (BuildContext context, AsyncSnapshot<List<MarkerColor>> c) {
                  if (!c.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _content(context, scope, state, c.data!);
                },
          ),
        );
      },
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
    final AppSettings settings = state.settings;
    final List<MarkerColor> range = brandRangeColors(
      colors: catalog,
      brand: brand,
    );
    final Set<String> extras = scopedCodesForBrand(
      settings.extraMarkerIds,
      brand.id,
    );
    final Set<String> setIds = brand == MarkerBrand.ohuhuOahu
        ? settings.ownedSetIds
        : const <String>{};
    bool viaSet(MarkerColor c) => c.sets.any(setIds.contains);
    bool owned(MarkerColor c) =>
        isOwnedColor(c, ownedSetIds: setIds, extraCodes: extras);
    final List<MarkerColor> visible = range
        .where(_matches)
        .toList(growable: false);
    final List<MarkerColor> tickable = visible
        .where((MarkerColor c) => !viaSet(c))
        .toList(growable: false);

    final List<Widget> top = <Widget>[
      Text(
        brand == MarkerBrand.ohuhuOahu
            ? context.l10n.collectionExtrasHint
            : context.l10n.collectionDecoHint,
        style: AppTypography.secondary.copyWith(color: ink.fg2),
      ),
      const SizedBox(height: InkSpacing.block),
      InkSearchField(
        controller: _search,
        hintText: context.l10n.collectionSearchHint,
        semanticLabel: context.l10n.collectionSearchHint,
        onChanged: (String v) =>
            setState(() => _query = v.trim().toLowerCase()),
      ),
      const SizedBox(height: InkSpacing.block),
      Row(
        children: <Widget>[
          Expanded(
            child: InkButton.secondary(
              key: const ValueKey<String>('collection-tick-visible'),
              label: context.l10n.collectionTickVisible,
              onPressed: tickable.isEmpty
                  ? null
                  : () => _setExtras(scope, settings, tickable, add: true),
            ),
          ),
          const SizedBox(width: InkSpacing.buttonGap),
          Expanded(
            child: InkButton.secondary(
              key: const ValueKey<String>('collection-untick-visible'),
              label: context.l10n.collectionUntickVisible,
              onPressed: visible.isEmpty
                  ? null
                  : () => _setExtras(scope, settings, visible, add: false),
            ),
          ),
        ],
      ),
      if (_query.isNotEmpty) ...<Widget>[
        const SizedBox(height: InkSpacing.group),
        Text(
          context.l10n.collectionVisibleScope,
          key: const ValueKey<String>('collection-visible-scope'),
          style: AppTypography.secondary.copyWith(color: ink.fg2),
        ),
      ],
      const SizedBox(height: InkSpacing.group),
      Text(
        context.l10n.collectionOwnedCount(
          range.where(owned).length,
          range.length,
        ),
        key: const ValueKey<String>('collection-owned-count'),
        style: AppTypography.data.copyWith(color: ink.fg2),
      ),
      const SizedBox(height: InkSpacing.group),
    ];

    return CustomScrollView(
      key: LooseMarkersPage.pageKey,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            InkSpacing.gutter,
            InkSpacing.group,
            InkSpacing.gutter,
            0,
          ),
          sliver: SliverList.list(children: top),
        ),
        if (visible.isEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(InkSpacing.gutter),
            sliver: SliverToBoxAdapter(
              child: Text(
                context.l10n.collectionNoResults,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.only(bottom: InkSpacing.pageBottom),
            sliver: SliverList.builder(
              itemCount: visible.length,
              itemBuilder: (BuildContext context, int index) {
                final MarkerColor color = visible[index];
                final bool inSet = viaSet(color);
                return _MarkerRow(
                  key: ValueKey<String>('collection-marker-${color.newCode}'),
                  color: color,
                  owned: owned(color),
                  inSet: inSet,
                  onChanged: inSet
                      ? null
                      : (bool on) => _setExtras(scope, settings, <MarkerColor>[
                          color,
                        ], add: on),
                );
              },
            ),
          ),
      ],
    );
  }

  bool _matches(MarkerColor color) {
    if (_query.isEmpty) return true;
    return color.newCode.toLowerCase().contains(_query) ||
        color.oldCode.toLowerCase().contains(_query) ||
        color.newName.toLowerCase().contains(_query) ||
        color.oldName.toLowerCase().contains(_query);
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
}

/// One marker of the list: swatch, code and name, and a tick. A marker that
/// comes with an owned set says "In your set" instead of the tick.
class _MarkerRow extends StatelessWidget {
  const _MarkerRow({
    super.key,
    required this.color,
    required this.owned,
    required this.inSet,
    required this.onChanged,
  });

  final MarkerColor color;
  final bool owned;
  final bool inSet;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return MergeSemantics(
      child: InkWell(
        onTap: onChanged == null ? null : () => onChanged!(!owned),
        child: Container(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          padding: const EdgeInsets.fromLTRB(
            InkSpacing.gutter,
            InkSpacing.s4,
            InkSpacing.s8,
            InkSpacing.s4,
          ),
          child: Row(
            children: <Widget>[
              SwatchBlock(hex: color.hex, size: 32, radius: InkRadii.xs),
              const SizedBox(width: InkSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      color.newCode,
                      style: AppTypography.code.copyWith(color: ink.fg),
                    ),
                    Text(
                      color.newName,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                  ],
                ),
              ),
              if (inSet)
                Padding(
                  padding: const EdgeInsets.only(right: InkSpacing.s8),
                  child: Text(
                    context.l10n.collectionInYourSets,
                    key: ValueKey<String>('collection-in-set-${color.newCode}'),
                    maxLines: 1,
                    softWrap: false,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                )
              else
                Checkbox(
                  value: owned,
                  onChanged: (bool? v) => onChanged!(v ?? false),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
