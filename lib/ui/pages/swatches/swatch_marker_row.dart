import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';

/// One marker in a list of the detail sheet: its swatch, the code and the
/// name beside it, at least 44 high and tappable. The texts wrap instead of
/// being cut.
///
/// [relativeTo] is the marker the list is about: when this one is of another
/// brand, the brand leads the name line, because a code alone is ambiguous
/// across brands.
class SwatchMarkerRow extends StatelessWidget {
  const SwatchMarkerRow({
    super.key,
    required this.color,
    required this.onTap,
    this.relativeTo,
    this.trailing,
    this.semanticSuffix,
  });

  final MarkerColor color;
  final VoidCallback? onTap;

  /// The marker the list is about; see above.
  final MarkerColor? relativeTo;

  /// Shown at the end of the row (a distance, a mark).
  final Widget? trailing;

  /// Added to the spoken label ("closest to this one").
  final String? semanticSuffix;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final String name = swatchNameLine(color, relativeTo);
    return Semantics(
      button: onTap != null,
      excludeSemantics: true,
      label: [color.newCode, name, ?semanticSuffix].join(', '),
      child: InkWell(
        onTap: onTap,
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
                        color.newCode,
                        style: AppTypography.code.copyWith(color: ink.fg),
                      ),
                      Text(
                        name,
                        style: AppTypography.secondary.copyWith(color: ink.fg2),
                      ),
                    ],
                  ),
                ),
                if (trailing != null) ...<Widget>[
                  const SizedBox(width: InkSpacing.group),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The line under the code of [color] in a list about [relativeTo]: the name,
/// led by the brand when [color] is of another brand.
String swatchNameLine(MarkerColor color, MarkerColor? relativeTo) {
  if (relativeTo == null || relativeTo.brandId == color.brandId) {
    return color.newName;
  }
  return '${MarkerBrand.fromId(color.brandId).label} · ${color.newName}';
}

/// A short note in the secondary type, for the sections of the detail sheet.
class SwatchNote extends StatelessWidget {
  const SwatchNote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: AppTypography.secondary.copyWith(color: InkColors.of(context).fg2),
  );
}

/// The heading of a section of the detail sheet.
class SwatchSectionHeading extends StatelessWidget {
  const SwatchSectionHeading(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      text,
      style: AppTypography.section.copyWith(color: InkColors.of(context).fg),
    ),
  );
}

/// The height of [text] in [style] when it wraps in [maxWidth], at the current
/// text size.
double swatchTextHeight(
  BuildContext context,
  String text,
  TextStyle style,
  double maxWidth,
) {
  final TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: Directionality.of(context),
    textScaler: MediaQuery.textScalerOf(context),
  )..layout(maxWidth: maxWidth.isFinite ? maxWidth : 10000);
  final double height = painter.height;
  painter.dispose();
  return height;
}

/// How much a sheet row reserves for [lines] lines of [style] at the current
/// text size: used to give states that show different amounts of text the
/// same height.
double swatchLinesHeight(BuildContext context, TextStyle style, int lines) =>
    MediaQuery.textScalerOf(context).scale(style.fontSize! * style.height!) *
    lines;
