import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../core/purchase_advisor.dart';
import '../../../core/shadow_light.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/skeleton_block.dart';
import 'swatch_marker_row.dart';

/// "Shadow and light": the closest darker and the closest lighter marker the
/// user owns in the colour of the marker, one tap from their own detail.
///
/// Both slots are always there, one beside the other (one above the other
/// with large text), and both are as high as a slot with a marker in it: a
/// slot that finds nothing says "None in your collection" in the same room,
/// so the sheet does not move whichever way it turns out.
class ShadowLightSection extends StatefulWidget {
  const ShadowLightSection({
    super.key,
    required this.marker,
    required this.owned,
    required this.onSelect,
  });

  final MarkerColor marker;

  /// The markers the user owns and can use, of every brand.
  final Future<List<MarkerColor>> owned;

  /// Called when a neighbour is tapped.
  final ValueChanged<MarkerColor> onSelect;

  @override
  State<ShadowLightSection> createState() => _ShadowLightSectionState();
}

class _ShadowLightSectionState extends State<ShadowLightSection> {
  late Future<ShadowLight> _result = _compute();

  Future<ShadowLight> _compute() => widget.owned.then(
    (List<MarkerColor> owned) => findShadowAndLight(widget.marker, owned),
    onError: (Object _) => const ShadowLight(),
  );

  @override
  void didUpdateWidget(ShadowLightSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.owned, widget.owned) ||
        oldWidget.marker.colorId != widget.marker.colorId ||
        oldWidget.marker.hex != widget.marker.hex) {
      _result = _compute();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Column(
      key: const ValueKey<String>('swatch-shadow-light'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SwatchSectionHeading(l10n.swatchShadowLightTitle),
        const SizedBox(height: InkSpacing.headingGap),
        FutureBuilder<ShadowLight>(
          future: _result,
          builder: (BuildContext context, AsyncSnapshot<ShadowLight> snapshot) {
            final bool loading = !snapshot.hasData;
            final ShadowLight result = snapshot.data ?? const ShadowLight();
            final Widget shadow = _Slot(
              slotKey: const ValueKey<String>('swatch-shadow'),
              label: l10n.swatchShadow,
              step: result.shadow,
              loading: loading,
              marker: widget.marker,
              onSelect: widget.onSelect,
            );
            final Widget light = _Slot(
              slotKey: const ValueKey<String>('swatch-light'),
              label: l10n.swatchLight,
              step: result.light,
              loading: loading,
              marker: widget.marker,
              onSelect: widget.onSelect,
            );
            // Side by side while the text is normal; with large text each
            // slot gets a full row.
            if (MediaQuery.textScalerOf(context).scale(1) > 1.15) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  shadow,
                  const SizedBox(height: InkSpacing.group),
                  light,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: shadow),
                const SizedBox(width: InkSpacing.s8),
                Expanded(child: light),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// One of the two slots: the label, and the neighbour or "None in your
/// collection".
class _Slot extends StatelessWidget {
  const _Slot({
    required this.slotKey,
    required this.label,
    required this.step,
    required this.loading,
    required this.marker,
    required this.onSelect,
  });

  final Key slotKey;
  final String label;
  final ShadowLightStep? step;
  final bool loading;
  final MarkerColor marker;
  final ValueChanged<MarkerColor> onSelect;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final ShadowLightStep? found = step;
    final MarkerColor? color = found?.color;
    // Label, code and two lines of name: what a slot with a marker needs, and
    // what a slot without one reserves too.
    final double minHeight =
        swatchLinesHeight(context, AppTypography.caption, 1) +
        swatchLinesHeight(context, AppTypography.code, 1) +
        swatchLinesHeight(context, AppTypography.secondary, 2) +
        2 * InkSpacing.s4;
    final String name = color == null ? '' : swatchNameLine(color, marker);
    final Widget content = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: InkSpacing.s4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (color != null)
              SwatchBlock(
                hex: color.hex,
                size: InkGeometry.swatchRow,
                own: color.hasOwnColor,
              )
            else
              SizedBox.square(
                dimension: InkGeometry.swatchRow,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: InkRadii.cellRadius,
                    border: Border.all(color: ink.line),
                  ),
                ),
              ),
            const SizedBox(width: InkSpacing.s10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppTypography.caps(label),
                    style: AppTypography.caption.copyWith(color: ink.fg2),
                  ),
                  if (color != null) ...<Widget>[
                    Text(
                      color.newCode,
                      style: AppTypography.code.copyWith(color: ink.fg),
                    ),
                    Text(
                      name,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                  ] else if (!loading)
                    Text(
                      l10n.swatchShadowLightNone,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    if (color == null) {
      return Semantics(
        container: true,
        label: loading ? label : '$label, ${l10n.swatchShadowLightNone}',
        excludeSemantics: true,
        child: KeyedSubtree(key: slotKey, child: content),
      );
    }
    return Semantics(
      button: true,
      excludeSemantics: true,
      label: '$label, ${color.newCode}, $name',
      child: InkWell(
        key: slotKey,
        onTap: () => onSelect(color),
        borderRadius: InkRadii.cellRadius,
        child: content,
      ),
    );
  }
}

/// "You already have N markers very close to this": for a marker the user
/// does not own, the owned markers that are almost the same colour, so a
/// near-duplicate is not bought by mistake.
///
/// The threshold is [DuplicateRules.threshold]. Up to
/// [DuplicateRules.maxListed] are listed, closest first; the rest are counted.
class NearDuplicatesSection extends StatefulWidget {
  const NearDuplicatesSection({
    super.key,
    required this.marker,
    required this.owned,
    required this.onSelect,
  });

  final MarkerColor marker;

  /// The markers the user owns and can use, of every brand.
  final Future<List<MarkerColor>> owned;

  final ValueChanged<MarkerColor> onSelect;

  @override
  State<NearDuplicatesSection> createState() => _NearDuplicatesSectionState();
}

class _NearDuplicatesSectionState extends State<NearDuplicatesSection> {
  late Future<({int ownedCount, List<NearDuplicate> found})> _result =
      _compute();

  Future<({int ownedCount, List<NearDuplicate> found})> _compute() =>
      widget.owned.then(
        (List<MarkerColor> owned) => (
          ownedCount: owned.length,
          found: findNearDuplicates(widget.marker, owned),
        ),
        onError: (Object _) => (ownedCount: 0, found: const <NearDuplicate>[]),
      );

  @override
  void didUpdateWidget(NearDuplicatesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.owned, widget.owned) ||
        oldWidget.marker.colorId != widget.marker.colorId ||
        oldWidget.marker.hex != widget.marker.hex) {
      _result = _compute();
    }
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    return FutureBuilder<({int ownedCount, List<NearDuplicate> found})>(
      future: _result,
      builder:
          (
            BuildContext context,
            AsyncSnapshot<({int ownedCount, List<NearDuplicate> found})> snap,
          ) {
            final data = snap.data;
            if (data == null) {
              return const SkeletonBlock(height: InkGeometry.rowTall);
            }
            // Nothing owned yet: there is nothing to compare with.
            if (data.ownedCount == 0) return const SizedBox.shrink();
            if (data.found.isEmpty) {
              return KeyedSubtree(
                key: const ValueKey<String>('swatch-duplicates-none'),
                child: SwatchNote(l10n.swatchDuplicatesNone),
              );
            }
            final List<NearDuplicate> listed = data.found
                .take(DuplicateRules.maxListed)
                .toList();
            final int more = data.found.length - listed.length;
            return Column(
              key: const ValueKey<String>('swatch-duplicates'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Semantics(
                  header: true,
                  child: Text(
                    l10n.swatchDuplicatesTitle(data.found.length),
                    key: const ValueKey<String>('swatch-duplicates-title'),
                    style: AppTypography.body.copyWith(color: ink.fg),
                  ),
                ),
                SwatchNote(l10n.swatchDuplicatesHint),
                const SizedBox(height: InkSpacing.s4),
                for (final NearDuplicate duplicate in listed)
                  SwatchMarkerRow(
                    key: ValueKey<String>(
                      'swatch-duplicate-${duplicate.color.colorId}',
                    ),
                    color: duplicate.color,
                    relativeTo: widget.marker,
                    onTap: () => widget.onSelect(duplicate.color),
                  ),
                if (more > 0) SwatchNote(l10n.swatchDuplicatesMore(more)),
              ],
            );
          },
    );
  }
}
