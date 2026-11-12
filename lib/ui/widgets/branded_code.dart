import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// The code of a marker in a row, with its brand in front when the list it
/// is in mixes brands ("Ohuhu BV04", "DecoTime 91").
///
/// Not [mixed], it is the bare code in the `code` type (`data` when [dense]),
/// exactly what a single-brand row shows. [mixed], the brand's short name
/// comes first in the body type, `fg2` (`secondary` beside `code`, `caption`
/// beside `data`), then the code at its full size. The two take at most
/// [InkGeometry.brandedCodeWidth]: when they do not fit it is the brand that
/// is cut with an ellipsis, never the code, and nothing is scaled down. At a
/// very large text size the code alone may be wider than that: the room
/// then grows to the code, so it is still whole (and the brand gives way).
///
/// The one way a code with its brand is drawn; plain strings (semantics, the
/// base field, shared text) use `markerCodeLabel`.
class BrandedCode extends StatelessWidget {
  const BrandedCode({
    super.key,
    required this.marker,
    required this.mixed,
    this.dense = false,
  });

  final MarkerColor marker;

  /// Whether the list mixes brands, so the code needs its brand.
  final bool mixed;

  /// The small pair (`caption` + `data`), for a code at the end of a line of
  /// secondary text; otherwise `secondary` + `code`.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final TextStyle codeStyle =
        (dense ? AppTypography.data : AppTypography.code).copyWith(
          color: ink.fg,
        );
    final Widget code = Text(
      marker.newCode,
      maxLines: mixed ? 1 : null,
      softWrap: mixed ? false : null,
      style: codeStyle,
    );
    if (!mixed) return code;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: math.max(
          InkGeometry.brandedCodeWidth,
          _codeWidth(context, codeStyle),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // The small pair shares one line height, so centring keeps the
        // line exactly as tall as a line of either (the two baselines are
        // a twentieth of a pixel apart); the large pair has two line
        // heights and sits on a common baseline.
        crossAxisAlignment: dense
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.baseline,
        textBaseline: dense ? null : TextBaseline.alphabetic,
        children: <Widget>[
          Flexible(
            child: Text(
              MarkerBrand.fromId(marker.brandId).shortLabel,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: (dense ? AppTypography.caption : AppTypography.secondary)
                  .copyWith(color: ink.fg2),
            ),
          ),
          const SizedBox(width: InkSpacing.s4),
          code,
        ],
      ),
    );
  }

  /// The width the code and the gap before it need at the text size in use,
  /// measured the way the [Text] above lays it out.
  double _codeWidth(BuildContext context, TextStyle style) {
    TextStyle effective = DefaultTextStyle.of(context).style.merge(style);
    if (MediaQuery.boldTextOf(context)) {
      effective = effective.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    final TextPainter painter = TextPainter(
      text: TextSpan(text: marker.newCode, style: effective),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final double width = painter.width;
    painter.dispose();
    return width.ceilToDouble() + InkSpacing.s4;
  }
}
