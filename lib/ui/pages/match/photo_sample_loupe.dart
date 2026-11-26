import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../core/white_balance.dart';
import '../../theme/tokens.dart';
import 'color_sampling.dart';
import 'photo_sampling.dart' show WhiteBalancePreview;

/// Prefer above the finger, then below, then either side. Every candidate is
/// clamped to the safe viewport and kept outside a 32 dp finger exclusion box.
Rect photoLoupeRect(Offset finger, Rect viewport) {
  final Rect exclusion = Rect.fromCircle(center: finger, radius: 32);
  // A keyboard or a narrow window can leave no room for the full-size loupe.
  // The largest free strip beside the exclusion box sets the square's limit.
  final double clearance = <double>[
    exclusion.top - viewport.top,
    viewport.bottom - exclusion.bottom,
    viewport.right - exclusion.right,
    exclusion.left - viewport.left,
  ].reduce(math.max);
  final double maximumSide = math.min(120, viewport.shortestSide);
  final double side = clearance > 0
      ? math.min(maximumSide, clearance)
      : maximumSide;
  const double gap = 36;
  final List<Offset> candidates = <Offset>[
    Offset(finger.dx - side / 2, finger.dy - gap - side),
    Offset(finger.dx - side / 2, finger.dy + gap),
    Offset(finger.dx + gap, finger.dy - side / 2),
    Offset(finger.dx - gap - side, finger.dy - side / 2),
  ];
  Rect? furthest;
  for (final Offset candidate in candidates) {
    final Rect rect = Rect.fromLTWH(
      candidate.dx.clamp(viewport.left, viewport.right - side),
      candidate.dy.clamp(viewport.top, viewport.bottom - side),
      side,
      side,
    );
    if (!rect.overlaps(exclusion)) return rect;
    if (furthest == null ||
        (rect.center - finger).distanceSquared >
            (furthest.center - finger).distanceSquared) {
      furthest = rect;
    }
  }
  // Only reachable in a viewport too small for both the loupe and the finger.
  return furthest!;
}

/// Native sampling pixels, with precisely the same preview as the photo.
/// The marks remain unfiltered and use theme colours in both appearances.
class PhotoSampleLoupe extends StatelessWidget {
  const PhotoSampleLoupe({
    super.key,
    required this.image,
    required this.pixels,
    required this.fraction,
    required this.displayPixelScale,
    this.balance,
  });

  final SampledImage image;
  final ui.Image? pixels;
  final Offset fraction;
  final double displayPixelScale;
  final WhiteBalance? balance;

  /// Four times the photo's on-screen scale, at least one logical pixel per
  /// decoded pixel, capped at eight to keep tiny photos useful.
  double get pixelScale => (displayPixelScale * 4).clamp(1.0, 8.0);

  /// Centre of the actual sampled pixel; sampling rounds and clamps its index.
  Offset get pixelCentre => Offset(
    (fraction.dx * image.width).round().clamp(0, image.width - 1) + 0.5,
    (fraction.dy * image.height).round().clamp(0, image.height - 1) + 0.5,
  );

  Rect get sampleBounds => samplingRegionOf(image, fraction);

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return DecoratedBox(
      key: const ValueKey<String>('photo-sample-loupe'),
      decoration: BoxDecoration(
        color: ink.surface,
        borderRadius: InkRadii.cardRadius,
      ),
      child: ClipRRect(
        borderRadius: InkRadii.cardRadius,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            WhiteBalancePreview(
              balance: balance,
              child: CustomPaint(
                painter: _LoupePixels(pixels, pixelCentre, pixelScale),
              ),
            ),
            CustomPaint(
              painter: _LoupeMarks(pixelCentre, sampleBounds, pixelScale, ink),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoupePixels extends CustomPainter {
  _LoupePixels(this.image, this.centre, this.scale);

  final ui.Image? image;
  final Offset centre;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final ui.Image? pixels = image;
    if (pixels == null) return;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale);
    canvas.translate(-centre.dx, -centre.dy);
    canvas.drawImage(
      pixels,
      Offset.zero,
      Paint()..filterQuality = FilterQuality.none,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_LoupePixels oldDelegate) =>
      image != oldDelegate.image ||
      centre != oldDelegate.centre ||
      scale != oldDelegate.scale;
}

class _LoupeMarks extends CustomPainter {
  _LoupeMarks(this.centre, this.bounds, this.scale, this.ink);

  final Offset centre;
  final Rect bounds;
  final double scale;
  final InkColors ink;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset middle = size.center(Offset.zero);
    final Rect region = Rect.fromLTRB(
      (bounds.left - centre.dx) * scale + middle.dx,
      (bounds.top - centre.dy) * scale + middle.dy,
      (bounds.right - centre.dx) * scale + middle.dx,
      (bounds.bottom - centre.dy) * scale + middle.dy,
    );
    // A theme surface halo keeps fine marks readable against any photo.
    final Path marks = Path()..addRect(region);
    for (final Offset direction in const <Offset>[
      Offset(1, 0),
      Offset(-1, 0),
      Offset(0, 1),
      Offset(0, -1),
    ]) {
      final Offset start = middle + direction * 3;
      final Offset end = middle + direction * 10;
      marks.moveTo(start.dx, start.dy);
      marks.lineTo(end.dx, end.dy);
    }
    canvas.drawPath(
      marks,
      Paint()
        ..color = ink.surface
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    canvas.drawPath(
      marks,
      Paint()
        ..color = ink.fg
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        (Offset.zero & size).deflate(0.5),
        const Radius.circular(InkRadii.card),
      ),
      Paint()
        ..color = ink.line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_LoupeMarks oldDelegate) =>
      centre != oldDelegate.centre ||
      bounds != oldDelegate.bounds ||
      scale != oldDelegate.scale ||
      ink != oldDelegate.ink;
}
