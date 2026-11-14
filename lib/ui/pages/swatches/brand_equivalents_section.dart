import 'package:flutter/material.dart';

import '../../../core/brand_equivalents.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/skeleton_block.dart';

/// Looks up the closest markers of the other brands for [marker].
///
/// [onlyMine] limits the search to the markers the user owns and has not run
/// dry. The lookup is asynchronous so the page can read the other brands'
/// catalogues and measure about a thousand colours off the build path.
typedef BrandEquivalentsLoader = Future<List<BrandEquivalentGroup>> Function(
  MarkerColor marker, {
  required bool onlyMine,
});

/// The ids of the brands the user owns at least one marker of.
typedef OwnedBrandsLoader = Future<Set<String>> Function();

/// "In other brands": the closest markers of every other brand to a marker,
/// with how close each one is, and a switch to keep only the user's own.
///
/// With fifteen brands the section does not list them all at once. The
/// brands the user owns markers of come first, each a closed group that shows
/// its best match (opening it shows the three closest); then one disclosure,
/// "All brands (N)", holds one compact row per brand, the closest brand
/// first. Which groups are open is kept here, and forgotten when the marker
/// changes.
///
/// The answer is computed once per marker (and per switch position): the
/// future is kept in the state, so rebuilding the sheet around the section
/// (a favourite toggled, a colour edited elsewhere) never measures again.
class BrandEquivalentsSection extends StatefulWidget {
  const BrandEquivalentsSection({
    super.key,
    required this.marker,
    required this.loader,
    required this.onSelect,
    this.ownedBrands,
  });

  /// The marker the section is about.
  final MarkerColor marker;

  /// Where the answer comes from.
  final BrandEquivalentsLoader loader;

  /// Called when a result is tapped.
  final ValueChanged<MarkerColor> onSelect;

  /// Which brands the user owns markers of, to show those first. Without it
  /// every brand is in the list of all brands.
  final OwnedBrandsLoader? ownedBrands;

  @override
  State<BrandEquivalentsSection> createState() =>
      _BrandEquivalentsSectionState();
}

class _BrandEquivalentsSectionState extends State<BrandEquivalentsSection> {
  bool _onlyMine = false;
  late Future<_Loaded> _future = _load();

  /// The brands whose group is open.
  final Set<String> _open = <String>{};

  /// Whether the list of all brands is open.
  bool _allOpen = false;

  Future<_Loaded> _load() async {
    final Future<Set<String>> owned =
        widget.ownedBrands?.call() ?? Future<Set<String>>.value(<String>{});
    final List<BrandEquivalentGroup> groups = await widget.loader(
      widget.marker,
      onlyMine: _onlyMine,
    );
    Set<String> ownedIds;
    try {
      ownedIds = await owned;
    } catch (_) {
      ownedIds = <String>{};
    }
    return _Loaded(groups, ownedIds);
  }

  @override
  void didUpdateWidget(BrandEquivalentsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Another marker, or the same one with another colour (its own colour was
    // set or dropped): measure again. Anything else keeps the answer.
    if (oldWidget.marker.colorId != widget.marker.colorId ||
        oldWidget.marker.hex != widget.marker.hex) {
      _future = _load();
      // The groups of the old marker are closed: the new ones start closed.
      _open.clear();
      _allOpen = false;
    }
  }

  void _setOnlyMine(bool value) {
    setState(() {
      _onlyMine = value;
      _future = _load();
    });
  }

  void _toggle(String brandId) {
    setState(() {
      if (!_open.remove(brandId)) _open.add(brandId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Column(
      key: const ValueKey<String>('swatch-brand-equivalents'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // The switch shares the line of the heading while both fit; in a
        // long translation it drops below it, and the heading never wraps.
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: InkSpacing.group,
          runSpacing: InkSpacing.s8,
          children: <Widget>[
            Semantics(
              header: true,
              child: Text(
                context.l10n.swatchesOtherBrandsTitle,
                style: AppTypography.section.copyWith(color: ink.fg),
              ),
            ),
            InkChip(
              key: const ValueKey<String>('swatch-equivalents-only-mine'),
              label: context.l10n.swatchesOtherBrandsOnlyMine,
              selected: _onlyMine,
              onSelected: _setOnlyMine,
            ),
          ],
        ),
        const SizedBox(height: InkSpacing.block),
        FutureBuilder<_Loaded>(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<_Loaded> snapshot) {
            if (snapshot.hasError) {
              return _note(
                context,
                ink,
                'swatch-equivalents-failed',
                context.l10n.swatchesOtherBrandsFailed,
              );
            }
            final _Loaded? loaded = snapshot.data;
            if (loaded == null) {
              return const SkeletonBlock(height: InkGeometry.skeletonList);
            }
            final List<BrandEquivalentGroup> groups = <BrandEquivalentGroup>[
              for (final BrandEquivalentGroup g in loaded.groups)
                if (g.matches.isNotEmpty) g,
            ];
            if (groups.isEmpty) {
              return _note(
                context,
                ink,
                'swatch-equivalents-empty',
                _onlyMine
                    ? context.l10n.swatchesOtherBrandsNoneMine
                    : context.l10n.swatchesOtherBrandsNone,
              );
            }
            // The user's brands first, the closest one first.
            final List<BrandEquivalentGroup> yours = <BrandEquivalentGroup>[
              for (final BrandEquivalentGroup g in groups)
                if (loaded.ownedBrandIds.contains(g.brandId)) g,
            ]..sort(_byDistance);
            // With "Only mine" every brand is the user's: the list of all
            // brands would only repeat them.
            final bool showAll = !_onlyMine;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (yours.isNotEmpty && showAll)
                  Padding(
                    padding: const EdgeInsets.only(bottom: InkSpacing.s4),
                    child: Text(
                      AppTypography.caps(context.l10n.swatchesOtherBrandsYours),
                      style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                    ),
                  ),
                for (final BrandEquivalentGroup group in yours)
                  _BrandGroup(
                    group: group,
                    expanded: _open.contains(group.brandId),
                    onToggle: () => _toggle(group.brandId),
                    onSelect: widget.onSelect,
                  ),
                if (showAll) ...<Widget>[
                  if (yours.isNotEmpty)
                    const SizedBox(height: InkSpacing.group),
                  _AllBrands(
                    groups: <BrandEquivalentGroup>[...groups]
                      ..sort(_byDistance),
                    expanded: _allOpen,
                    onToggle: () => setState(() => _allOpen = !_allOpen),
                    onSelect: widget.onSelect,
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _note(BuildContext context, InkColors ink, String key, String text) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
        child: Text(
          text,
          key: ValueKey<String>(key),
          style: AppTypography.secondary.copyWith(color: ink.fg2),
        ),
      );
}

/// What the section reads: the groups and the brands the user owns.
final class _Loaded {
  const _Loaded(this.groups, this.ownedBrandIds);

  final List<BrandEquivalentGroup> groups;
  final Set<String> ownedBrandIds;
}

/// Closest brand first; the brands keep the app's order among equals.
int _byDistance(BrandEquivalentGroup a, BrandEquivalentGroup b) =>
    a.matches.first.deltaE.compareTo(b.matches.first.deltaE);

/// "All brands (N)": one closed disclosure with one compact row per brand,
/// the closest first. A row is the brand, the closest marker of it, its
/// colour and how close it is; tapping it opens that marker.
class _AllBrands extends StatelessWidget {
  const _AllBrands({
    required this.groups,
    required this.expanded,
    required this.onToggle,
    required this.onSelect,
  });

  final List<BrandEquivalentGroup> groups;
  final bool expanded;
  final VoidCallback onToggle;
  final ValueChanged<MarkerColor> onSelect;

  @override
  Widget build(BuildContext context) {
    return InkDisclosure(
      key: const ValueKey<String>('swatch-equivalents-all'),
      title: context.l10n.swatchesAllBrands(groups.length),
      expanded: expanded,
      onToggle: onToggle,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final BrandEquivalentGroup group in groups)
            _BrandRow(group: group, onSelect: onSelect),
        ],
      ),
    );
  }
}

/// One brand of the list of all brands: swatch, brand, code and distance.
class _BrandRow extends StatelessWidget {
  const _BrandRow({required this.group, required this.onSelect});

  final BrandEquivalentGroup group;
  final ValueChanged<MarkerColor> onSelect;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final BrandEquivalent best = group.matches.first;
    final MarkerColor color = best.color;
    final String quality = l10n.matchQualityLabel(best.deltaE);
    return Semantics(
      button: true,
      excludeSemantics: true,
      label:
          '${group.brand.label}, ${color.newCode}, '
          '${l10n.commonDeltaE(best.deltaE)}, $quality',
      child: InkWell(
        key: ValueKey<String>('swatch-equivalents-row-${group.brandId}'),
        onTap: () => onSelect(color),
        borderRadius: InkRadii.cellRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s4),
            child: Row(
              children: <Widget>[
                SwatchBlock(
                  hex: color.hex,
                  size: InkGeometry.swatchRow,
                  own: color.hasOwnColor,
                ),
                const SizedBox(width: InkSpacing.s10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        group.brand.label,
                        style: AppTypography.secondary.copyWith(color: ink.fg),
                      ),
                      Wrap(
                        spacing: InkSpacing.s8,
                        children: <Widget>[
                          Text(
                            color.newCode,
                            style: AppTypography.code.copyWith(color: ink.fg),
                          ),
                          Text(
                            l10n.commonDeltaE(best.deltaE),
                            style: AppTypography.data.copyWith(color: ink.fg2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The closest markers of one brand: a closed group that shows its best
/// match, and the three of them when it is opened.
class _BrandGroup extends StatelessWidget {
  const _BrandGroup({
    required this.group,
    required this.expanded,
    required this.onToggle,
    required this.onSelect,
  });

  final BrandEquivalentGroup group;
  final bool expanded;
  final VoidCallback onToggle;
  final ValueChanged<MarkerColor> onSelect;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final BrandEquivalent best = group.matches.first;
    final MarkerColor color = best.color;
    return InkDisclosure(
      key: ValueKey<String>('swatch-equivalents-${group.brandId}'),
      title: AppTypography.caps(group.brand.label),
      leading: SwatchBlock(
        hex: color.hex,
        size: InkGeometry.swatchInline,
        radius: InkRadii.xs,
      ),
      subtitleWidget: Row(
        children: <Widget>[
          Text(
            color.newCode,
            style: AppTypography.code.copyWith(color: ink.fg),
          ),
          const SizedBox(width: InkSpacing.s8),
          Expanded(child: InkQualityText(best.deltaE)),
        ],
      ),
      semanticLabel:
          '${group.brand.label}, ${color.newCode}, '
          '${l10n.commonDeltaE(best.deltaE)}',
      expanded: expanded,
      onToggle: onToggle,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final BrandEquivalent match in group.matches.take(3))
            _EquivalentRow(match: match, onTap: () => onSelect(match.color)),
        ],
      ),
    );
  }
}

/// One result: swatch, code, name and distance, at least 48 high.
class _EquivalentRow extends StatelessWidget {
  const _EquivalentRow({required this.match, required this.onTap});

  final BrandEquivalent match;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor color = match.color;
    final String quality = context.l10n.matchQualityLabel(match.deltaE);
    return Semantics(
      button: true,
      excludeSemantics: true,
      label:
          '${MarkerBrand.fromId(color.brandId).label}, '
          '${context.l10n.swatchesAlternativeSemantics(color.newCode, color.newName, match.deltaE)}, '
          '$quality',
      child: InkWell(
        key: ValueKey<String>('swatch-equivalent-${color.colorId}'),
        onTap: onTap,
        borderRadius: InkRadii.cellRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SwatchBlock(
                  hex: color.hex,
                  size: InkGeometry.swatchRow,
                  own: color.hasOwnColor,
                ),
                const SizedBox(width: InkSpacing.s10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        color.newCode,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.code.copyWith(color: ink.fg),
                      ),
                      Text(
                        color.newName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.secondary.copyWith(color: ink.fg2),
                      ),
                      const SizedBox(height: InkSpacing.s2),
                      InkQualityText(match.deltaE),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
