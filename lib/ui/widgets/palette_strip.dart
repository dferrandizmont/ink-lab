import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import 'color_swatch_tile.dart';
import '../../l10n/l10n.dart';

/// A palette at a glance (spec §4 "Palette strip").
///
/// One rounded, clipped bar of equal segments (radius 16 at 56 high), each
/// with a 1 px top and bottom edge per the swatch edge rule. Optional labels
/// (marker codes, `code` type) sit centred under every segment, 6 below. The
/// [lockedIndex] segment shows a lock in `inkOn(colour)` inside a 44 hit area.
class PaletteStrip extends StatelessWidget {
  const PaletteStrip({
    super.key,
    required this.colors,
    this.labels,
    this.spacing = 0,
    this.colorHeight = InkGeometry.paletteStripHeight,
    this.labelHeight = 22,
    this.onColorTap,
    this.radius,
    this.lockedIndex,
    this.lockedIndices,
    this.onLockTap,
    this.lockTooltip,
    this.labelStyle,
  });

  /// Colours of the strip, as hex strings.
  final List<String> colors;

  /// Optional labels shown under every colour; must match [colors] in length.
  final List<String>? labels;

  /// Gap between two segments (0 in design G).
  final double spacing;

  /// Height of the colour bar.
  final double colorHeight;

  /// Height reserved for the labels.
  final double labelHeight;

  /// Called with the index of the tapped colour.
  final void Function(int index)? onColorTap;

  /// Corner radius; defaults to 16 for bars of 56 and more, 10 for shorter
  /// ones and 4 for mini strips under 20.
  final double? radius;

  /// Index of the segment that shows a lock, if any.
  final int? lockedIndex;

  /// Segments that show a decorative lock glyph (no hit area, no semantics);
  /// for strips whose lock state is toggled elsewhere.
  final Set<int>? lockedIndices;

  /// Called when the lock is tapped.
  final VoidCallback? onLockTap;

  /// Semantic label of the lock button.
  /// Semantic label of the lock mark; defaults to the localised "Base locked".
  final String? lockTooltip;

  /// Overrides the label style (defaults to `code`).
  final TextStyle? labelStyle;

  double get _radius =>
      radius ??
      (colorHeight >= InkGeometry.paletteStripHeight
          ? InkRadii.card
          : colorHeight < 20
          ? InkRadii.xs
          : InkRadii.cell);

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<String>? stripLabels = labels;

    final Widget bar = ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: SizedBox(
        height: colorHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int index = 0; index < colors.length; index++) ...<Widget>[
              if (index > 0 && spacing > 0) SizedBox(width: spacing),
              Expanded(child: _segment(context, ink, index)),
            ],
          ],
        ),
      ),
    );

    if (stripLabels == null) {
      return bar;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        bar,
        const SizedBox(height: InkSpacing.group),
        SizedBox(
          height: labelHeight,
          child: Row(
            children: <Widget>[
              for (int index = 0; index < colors.length; index++) ...<Widget>[
                if (index > 0 && spacing > 0) SizedBox(width: spacing),
                Expanded(
                  child: Text(
                    index < stripLabels.length ? stripLabels[index] : '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: (labelStyle ?? AppTypography.code).copyWith(
                      color: labelStyle?.color ?? ink.fg,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _segment(BuildContext context, InkColors ink, int index) {
    final Color colour = swatchColor(colors[index]);
    final BorderSide edge = BorderSide(color: ink.swatchEdge(colour));
    return Material(
      color: colour,
      shape: Border(top: edge, bottom: edge),
      child: InkWell(
        onTap: onColorTap == null ? null : () => onColorTap!(index),
        child: Stack(
          children: <Widget>[
            if (lockedIndex != index &&
                (lockedIndices?.contains(index) ?? false))
              Positioned(
                left: 12,
                top: 10,
                child: ExcludeSemantics(
                  child: InkIcon(
                    InkIcons.lock,
                    size: InkGeometry.smallIcon,
                    color: inkOn(colour),
                  ),
                ),
              ),
            if (lockedIndex == index)
              Positioned(
                left: 0,
                top: 0,
                child: Semantics(
                  button: onLockTap != null,
                  toggled: true,
                  label: lockTooltip ?? context.l10n.commonBaseLocked,
                  child: InkResponse(
                    onTap: onLockTap,
                    radius: 22,
                    child: SizedBox.square(
                      dimension: InkGeometry.target,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 10),
                          child: InkIcon(
                            InkIcons.lock,
                            size: InkGeometry.smallIcon,
                            color: inkOn(colour),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
