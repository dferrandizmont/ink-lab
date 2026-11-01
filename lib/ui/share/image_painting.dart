import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

import '../../core/layout_rect.dart';
import '../theme/tokens.dart';

/// Draws [paint] on a [width] x [height] canvas at one pixel per unit and
/// encodes it as a PNG. Offscreen: no widget tree, no device pixel ratio, so
/// the output is exactly the size the layout asked for.
Future<Uint8List> renderPng({
  required int width,
  required int height,
  required void Function(Canvas canvas) paint,
}) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(
    recorder,
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
  );
  paint(canvas);
  final ui.Picture picture = recorder.endRecording();
  ui.Image? image;
  try {
    image = await picture.toImage(width, height);
    final ByteData? data = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    if (data == null) throw StateError('The image could not be encoded.');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  } finally {
    image?.dispose();
    picture.dispose();
  }
}

/// A [LayoutRect] as a [Rect].
extension LayoutRectPainting on LayoutRect {
  Rect get rect => Rect.fromLTWH(left, top, width, height);
}

/// [style] at [size] px, with the letter spacing scaled to match.
TextStyle sizedStyle(TextStyle style, double size, Color color) {
  final double base = style.fontSize ?? size;
  return style.copyWith(
    fontSize: size,
    color: color,
    letterSpacing: (style.letterSpacing ?? 0) * size / base,
  );
}

/// Draws [text] on one line inside [box], vertically centred, shrinking the
/// type down to [minScale] when it is too wide and cutting it with an ellipsis
/// beyond that. Returns the height of the line.
double drawFitted(
  Canvas canvas,
  String text,
  TextStyle style,
  LayoutRect box, {
  double minScale = 0.6,
  TextAlign align = TextAlign.left,
  bool centerVertically = true,
}) {
  TextPainter layout(TextStyle s, {bool ellipsis = false}) => TextPainter(
    text: TextSpan(text: text, style: s),
    textDirection: TextDirection.ltr,
    textAlign: align,
    textScaler: TextScaler.noScaling,
    maxLines: 1,
    ellipsis: ellipsis ? '…' : null,
  )..layout(maxWidth: ellipsis ? box.width : double.infinity);

  TextPainter painter = layout(style);
  if (painter.width > box.width) {
    final double scale = box.width / painter.width;
    painter.dispose();
    final double size = style.fontSize ?? 12;
    final bool fits = scale >= minScale;
    painter = layout(
      sizedStyle(
        style,
        fits ? size * scale * 0.99 : size * minScale,
        style.color!,
      ),
      ellipsis: !fits,
    );
  }
  final double dx = switch (align) {
    TextAlign.right || TextAlign.end => box.right - painter.width,
    TextAlign.center => box.left + (box.width - painter.width) / 2,
    _ => box.left,
  };
  final double dy = centerVertically
      ? box.top + (box.height - painter.height) / 2
      : box.top;
  painter.paint(canvas, Offset(dx, dy));
  final double height = painter.height;
  painter.dispose();
  return height;
}

/// Fills [rect] with the marker colour [color] and a 1 px edge: the colour's
/// own when it is dark, the light-theme hairline when it is pale (the swatch
/// edge rule of the design spec), so pale markers keep a visible outline.
void drawSwatch(Canvas canvas, Rect rect, Color color, {double border = 2}) {
  canvas.drawRect(rect, Paint()..color = color);
  canvas.drawRect(
    rect.deflate(border / 2),
    Paint()
      ..color = InkColors.light.swatchEdge(color)
      ..style = PaintingStyle.stroke
      ..strokeWidth = border,
  );
}
