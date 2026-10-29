import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Line icons drawn on a 24×24 grid, stroke 2, round caps and joins.
///
/// Geometry follows Feather (MIT, Cole Bemis; see NOTICE.md) and the
/// design G mockups.
enum InkIcons {
  /// Swatches tab: 2×2 squares.
  grid,

  /// Match tab.
  camera,

  /// Palette tab: a split rounded square.
  columns,

  /// Ideas tab: pen over a baseline.
  edit3,

  /// Settings tab: three sliders.
  sliders,

  /// Gear (kept for legacy callers).
  settings,
  search,
  x,
  check,
  star,
  copy,
  trash2,
  plus,
  minus,
  chevronRight,
  chevronDown,

  /// Feather funnel.
  filter,

  /// Three centred lines of decreasing width ("Filters · 2" chip).
  filterLines,
  image,
  rotateCcw,
  download,
  upload,
  info,
  lock,
  unlock,
  shuffle,
  heart,
  arrowRight,
  crosshair,
  alertCircle,
  list;

  static const InkIcons edit_3 = edit3;
  static const InkIcons trash_2 = trash2;
}

/// Paints one [InkIcons] glyph at [size], in [color] or the ambient
/// [IconTheme] colour.
class InkIcon extends StatelessWidget {
  const InkIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.filled = false,
  });

  final InkIcons icon;

  /// Size in logical pixels; defaults to the ambient [IconTheme] size (24).
  final double? size;

  /// Fills closed shapes (used by the favourite star).
  final bool filled;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double dimension = size ?? iconTheme.size ?? 24;
    final Color paint =
        color ?? iconTheme.color ?? Theme.of(context).colorScheme.onSurface;
    final Widget glyph = SizedBox.square(
      dimension: dimension,
      child: CustomPaint(painter: InkIconPainter(icon, paint, filled: filled)),
    );
    if (semanticLabel == null) {
      return ExcludeSemantics(child: glyph);
    }
    return Semantics(label: semanticLabel, image: true, child: glyph);
  }
}

class InkIconPainter extends CustomPainter {
  const InkIconPainter(this.icon, this.color, {this.filled = false});

  final InkIcons icon;
  final Color color;
  final bool filled;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 24, size.height / 24);
    final Paint stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final Paint fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    void draw(Path path, {bool fillable = false}) {
      if (filled && fillable) {
        canvas.drawPath(path, fill);
      }
      canvas.drawPath(path, stroke);
    }

    void line(double x, double y, double x2, double y2) =>
        canvas.drawLine(Offset(x, y), Offset(x2, y2), stroke);
    void rect(double x, double y, double w, double h, [double r = 0]) => draw(
      Path()..addRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(r)),
      ),
      fillable: true,
    );
    void circle(double x, double y, double r) =>
        canvas.drawCircle(Offset(x, y), r, stroke);
    Path poly(List<double> p, {bool close = false}) {
      final Path path = Path()..moveTo(p[0], p[1]);
      for (int i = 2; i < p.length; i += 2) {
        path.lineTo(p[i], p[i + 1]);
      }
      if (close) {
        path.close();
      }
      return path;
    }

    switch (icon) {
      case InkIcons.grid:
        for (final double x in <double>[3, 14]) {
          for (final double y in <double>[3, 14]) {
            rect(x, y, 7, 7);
          }
        }
      case InkIcons.camera:
        draw(
          Path()
            ..moveTo(23, 19)
            ..arcToPoint(const Offset(21, 21), radius: const Radius.circular(2))
            ..lineTo(3, 21)
            ..arcToPoint(const Offset(1, 19), radius: const Radius.circular(2))
            ..lineTo(1, 8)
            ..arcToPoint(const Offset(3, 6), radius: const Radius.circular(2))
            ..lineTo(7, 6)
            ..lineTo(9, 3)
            ..lineTo(15, 3)
            ..lineTo(17, 6)
            ..lineTo(21, 6)
            ..arcToPoint(const Offset(23, 8), radius: const Radius.circular(2))
            ..close(),
        );
        circle(12, 13, 4);
      case InkIcons.columns:
        rect(3, 3, 18, 18, 2);
        line(12, 3, 12, 21);
      case InkIcons.edit3:
        line(12, 20, 21, 20);
        draw(
          Path()
            ..moveTo(16.5, 3.5)
            ..arcToPoint(
              const Offset(19.5, 6.5),
              radius: const Radius.circular(2.1),
            )
            ..lineTo(7, 19)
            ..lineTo(3, 20)
            ..lineTo(4, 16)
            ..close(),
        );
      case InkIcons.sliders:
        line(4, 21, 4, 14);
        line(4, 10, 4, 3);
        line(12, 21, 12, 12);
        line(12, 8, 12, 3);
        line(20, 21, 20, 16);
        line(20, 12, 20, 3);
        line(1, 14, 7, 14);
        line(9, 8, 15, 8);
        line(17, 16, 23, 16);
      case InkIcons.settings:
        circle(12, 12, 3);
        final Path gear = Path();
        for (int i = 0; i < 48; i++) {
          final double a = -math.pi / 2 + i * math.pi / 24;
          final double r = <int>[0, 1, 6, 7].contains(i % 8) ? 10 : 8;
          final double x = 12 + r * math.cos(a), y = 12 + r * math.sin(a);
          if (i == 0) {
            gear.moveTo(x, y);
          } else {
            gear.lineTo(x, y);
          }
        }
        draw(gear..close());
      case InkIcons.search:
        circle(11, 11, 7);
        line(21, 21, 16.7, 16.7);
      case InkIcons.x:
        line(6, 6, 18, 18);
        line(18, 6, 6, 18);
      case InkIcons.check:
        draw(poly(<double>[4, 12.5, 9, 17.5, 20, 6.5]));
      case InkIcons.star:
        draw(
          poly(<double>[
            12, 2, 15.1, 8.3, 22, 9.3, 17, 14.2, 18.2, 21, 12, 17.8, //
            5.8, 21, 7, 14.2, 2, 9.3, 8.9, 8.3,
          ], close: true),
          fillable: true,
        );
      case InkIcons.copy:
        rect(9, 9, 12, 12, 3);
        draw(
          Path()
            ..moveTo(5, 15)
            ..arcToPoint(const Offset(3, 13), radius: const Radius.circular(2))
            ..lineTo(3, 6)
            ..arcToPoint(const Offset(6, 3), radius: const Radius.circular(3))
            ..lineTo(13, 3)
            ..arcToPoint(const Offset(15, 5), radius: const Radius.circular(2)),
        );
      case InkIcons.trash2:
        line(3, 6, 21, 6);
        line(10, 11, 10, 17);
        line(14, 11, 14, 17);
        draw(
          Path()
            ..moveTo(19, 6)
            ..lineTo(19, 20)
            ..arcToPoint(const Offset(17, 22), radius: const Radius.circular(2))
            ..lineTo(7, 22)
            ..arcToPoint(const Offset(5, 20), radius: const Radius.circular(2))
            ..lineTo(5, 6),
        );
        draw(poly(<double>[8, 6, 8, 3, 16, 3, 16, 6]));
      case InkIcons.plus:
        line(12, 5, 12, 19);
        line(5, 12, 19, 12);
      case InkIcons.minus:
        line(5, 12, 19, 12);
      case InkIcons.chevronRight:
        draw(poly(<double>[9, 6, 15, 12, 9, 18]));
      case InkIcons.chevronDown:
        draw(poly(<double>[6, 9, 12, 15, 18, 9]));
      case InkIcons.filter:
        draw(
          poly(<double>[
            22,
            3,
            2,
            3,
            10,
            12.46,
            10,
            19,
            14,
            21,
            14,
            12.46,
          ], close: true),
        );
      case InkIcons.filterLines:
        line(4, 6, 20, 6);
        line(7, 12, 17, 12);
        line(10, 18, 14, 18);
      case InkIcons.image:
        rect(3, 3, 18, 18, 2);
        circle(8.5, 8.5, 1.5);
        draw(poly(<double>[21, 15, 16, 10, 5, 21]));
      case InkIcons.rotateCcw:
        draw(poly(<double>[1, 4, 1, 10, 7, 10]));
        draw(
          Path()
            ..moveTo(3.51, 15)
            ..arcToPoint(
              const Offset(5.64, 5.64),
              radius: const Radius.circular(9),
              largeArc: true,
              clockwise: false,
            )
            ..lineTo(1, 10),
        );
      case InkIcons.download:
      case InkIcons.upload:
        draw(
          Path()
            ..moveTo(21, 15)
            ..lineTo(21, 19)
            ..arcToPoint(const Offset(19, 21), radius: const Radius.circular(2))
            ..lineTo(5, 21)
            ..arcToPoint(const Offset(3, 19), radius: const Radius.circular(2))
            ..lineTo(3, 15),
        );
        if (icon == InkIcons.download) {
          draw(poly(<double>[7, 10, 12, 15, 17, 10]));
          line(12, 15, 12, 3);
        } else {
          draw(poly(<double>[7, 8, 12, 3, 17, 8]));
          line(12, 3, 12, 15);
        }
      case InkIcons.info:
        circle(12, 12, 10);
        line(12, 16, 12, 12);
        line(12, 8, 12.01, 8);
      case InkIcons.alertCircle:
        circle(12, 12, 10);
        line(12, 8, 12, 12);
        line(12, 16, 12.01, 16);
      case InkIcons.lock:
      case InkIcons.unlock:
        rect(5, 11, 14, 10, 2);
        final Path shackle = Path()
          ..moveTo(8, 11)
          ..lineTo(8, 7)
          ..arcToPoint(const Offset(16, 7), radius: const Radius.circular(4));
        if (icon == InkIcons.lock) {
          shackle.lineTo(16, 11);
        }
        draw(shackle);
      case InkIcons.shuffle:
        draw(poly(<double>[16, 3, 21, 3, 21, 8]));
        line(4, 20, 21, 3);
        draw(poly(<double>[21, 16, 21, 21, 16, 21]));
        line(15, 15, 21, 21);
        line(4, 4, 9, 9);
      case InkIcons.heart:
        draw(
          Path()
            ..moveTo(20.84, 4.61)
            ..cubicTo(18.5, 2.3, 15, 2.6, 12, 5.6)
            ..cubicTo(9, 2.6, 5.5, 2.3, 3.16, 4.61)
            ..cubicTo(0.8, 7, 1.2, 10.5, 3.16, 12.5)
            ..lineTo(12, 21)
            ..lineTo(20.84, 12.5)
            ..cubicTo(22.8, 10.5, 23.2, 7, 20.84, 4.61)
            ..close(),
          fillable: true,
        );
      case InkIcons.arrowRight:
        line(5, 12, 19, 12);
        draw(poly(<double>[13, 6, 19, 12, 13, 18]));
      case InkIcons.crosshair:
        line(12, 2, 12, 8);
        line(12, 16, 12, 22);
        line(2, 12, 8, 12);
        line(16, 12, 22, 12);
      case InkIcons.list:
        line(8, 6, 21, 6);
        line(8, 12, 21, 12);
        line(8, 18, 21, 18);
        line(3, 6, 3.01, 6);
        line(3, 12, 3.01, 12);
        line(3, 18, 3.01, 18);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(InkIconPainter oldDelegate) =>
      oldDelegate.icon != icon ||
      oldDelegate.color != color ||
      oldDelegate.filled != filled;
}
