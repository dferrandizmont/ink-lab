import 'package:flutter/material.dart';

/// Smallest factor a single line of text is scaled down to. Below it the
/// text wraps to [paletteWrapLines] lines with an ellipsis instead of shrinking
/// further (only reachable at large accessibility text scales).
const double paletteMinLineScale = 0.8;
const int paletteWrapLines = 2;

/// A single line of text that is scaled down, never cut, when it is wider
/// than the space it has. It shrinks to [paletteMinLineScale] at most; beyond that
/// it wraps to two lines and ends with an ellipsis.
class PaletteOneLine extends StatelessWidget {
  const PaletteOneLine({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = constraints.maxWidth;
        final TextPainter painter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: direction,
          textScaler: scaler,
          maxLines: 1,
        )..layout();
        final double width = painter.width;
        painter.dispose();
        if (!available.isFinite || width <= available) {
          return Text(text, maxLines: 1, softWrap: false, style: style);
        }
        if (available / width >= paletteMinLineScale) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(text, maxLines: 1, softWrap: false, style: style),
          );
        }
        return Text(
          text,
          maxLines: paletteWrapLines,
          overflow: TextOverflow.ellipsis,
          style: style.copyWith(
            fontSize: (style.fontSize ?? 14) * paletteMinLineScale,
          ),
        );
      },
    );
  }
}
