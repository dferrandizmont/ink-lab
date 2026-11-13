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
    this.maxWidth,
    this.wrap = false,
  });

  final MarkerColor marker;

  /// Whether the list mixes brands, so the code needs its brand.
  final bool mixed;

  /// The small pair (`caption` + `data`), for a code at the end of a line of
  /// secondary text; otherwise `secondary` + `code`.
  final bool dense;

  /// The most room the pair takes, when a row has more to give than the
  /// usual [InkGeometry.brandedCodeWidth] (a marker on a line of its own).
  /// The code still gets what it needs when it is wider than this.
  final double? maxWidth;

  /// Whether the pair wraps instead of cutting the brand: when brand and code
  /// do not fit side by side, the code goes under the brand (and a brand wider
  /// than the room wraps too). For a marker on a line of its own, where there
  /// is nothing left to give; the code is never cut or wrapped (a code wider
  /// than the line is scaled down to fit it).
  final bool wrap;

  /// The width of the whole pair at the text size in use, brand and gap
  /// included, as it would be laid out with all the room it wants: a row
  /// compares it with the room it has to know whether the brand will fit.
  double naturalWidth(BuildContext context) {
    final TextStyle brandStyle = dense
        ? AppTypography.caption
        : AppTypography.secondary;
    return _textWidth(
          context,
          MarkerBrand.fromId(marker.brandId).shortLabel,
          brandStyle,
        ).ceilToDouble() +
        // The gap is part of the code's width.
        _codeWidth(context, _codeStyle(context));
  }

  TextStyle _codeStyle(BuildContext context) =>
      (dense ? AppTypography.data : AppTypography.code).copyWith(
        color: InkColors.of(context).fg,
      );

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final TextStyle codeStyle = _codeStyle(context);
    final Widget code = Text(
      marker.newCode,
      maxLines: mixed ? 1 : null,
      softWrap: mixed ? false : null,
      style: codeStyle,
    );
    if (!mixed) return code;
    final TextStyle brandStyle =
        (dense ? AppTypography.caption : AppTypography.secondary).copyWith(
          color: ink.fg2,
        );
    final String brand = MarkerBrand.fromId(marker.brandId).shortLabel;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: math.max(
          maxWidth ?? InkGeometry.brandedCodeWidth,
          _codeWidth(context, codeStyle),
        ),
      ),
      child: wrap
          ? Wrap(
              spacing: InkSpacing.s4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(brand, style: brandStyle),
                // A code wider than the whole line is scaled down to fit,
                // never clipped; when it fits, this changes nothing.
                FittedBox(fit: BoxFit.scaleDown, child: code),
              ],
            )
          : Row(
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
                    style:
                        (dense
                                ? AppTypography.caption
                                : AppTypography.secondary)
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
  double _codeWidth(BuildContext context, TextStyle style) =>
      _textWidth(context, marker.newCode, style).ceilToDouble() + InkSpacing.s4;

  /// The width of [text] on one line in [style] at the text size in use.
  double _textWidth(BuildContext context, String text, TextStyle style) {
    TextStyle effective = DefaultTextStyle.of(context).style.merge(style);
    if (MediaQuery.boldTextOf(context)) {
      effective = effective.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    final TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: effective),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final double width = painter.width;
    painter.dispose();
    return width;
  }
}
