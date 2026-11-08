import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/collection_wheel.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';

/// A dot under the finger: the marker's place in the map and whether the
/// user owns it (the faint dots of the whole range are the ones they do not).
typedef ColourMapHit = ({WheelDot dot, bool owned});

/// Radius of the dots of the markers the user owns, and of the faint dots of
/// the whole range.
const double colourMapOwnedRadius = 5;
const double colourMapRangeRadius = 2;

/// How far a finger may be from an owned dot and still hit it; a faint dot
/// needs a closer touch so it never steals a tap from an owned one.
const double colourMapOwnedReach = 22;
const double colourMapRangeReach = 10;

/// Height of the hue strip under the map, and the gap above it.
const double colourMapStripHeight = 10;
const double colourMapStripGap = 4;

/// Space between the border of the map and the dots, so a dot at the edge
/// is not cut.
const double colourMapInset = 8;

/// The place of every dot in a map drawn in [size]: the plot is the whole
/// area but the hue strip at the bottom.
final class ColourMapLayout {
  const ColourMapLayout(this.size);

  final Size size;

  /// The area of the map without the hue strip.
  Rect get plot => Rect.fromLTWH(
    0,
    0,
    size.width,
    math.max(0, size.height - colourMapStripHeight - colourMapStripGap),
  );

  Rect get _inner => plot.deflate(colourMapInset);

  /// Where [dot] sits in the plot.
  Offset position(WheelDot dot) => Offset(
    _inner.left + wheelX(dot.hue) * _inner.width,
    _inner.top + wheelY(dot.lightness) * _inner.height,
  );

  /// The rectangle of one cell of the 8 x 3 grid, edge to edge of the plot.
  Rect cell(HueFamily family, LightnessBand band) {
    final Rect p = plot;
    final double left = wheelX(family.from);
    final double right = left + family.span / 360;
    final double top = wheelY(band.to);
    final double bottom = wheelY(band.from);
    return Rect.fromLTRB(
      p.left + left * p.width,
      p.top + top * p.height,
      p.left + right * p.width,
      p.top + bottom * p.height,
    );
  }

  /// The rectangle of the hue strip.
  Rect get strip => Rect.fromLTWH(
    0,
    size.height - colourMapStripHeight,
    size.width,
    colourMapStripHeight,
  );
}

/// The dot nearest to [at] in the map of [wheel] (plus the faint dots of
/// [range] when given), or `null` when none is within reach. The markers the
/// user owns win over the faint ones.
ColourMapHit? colourMapHit(
  Offset at,
  Size size,
  CollectionWheel wheel, {
  List<WheelDot> range = const <WheelDot>[],
}) {
  final ColourMapLayout layout = ColourMapLayout(size);
  WheelDot? best;
  double bestDistance = colourMapOwnedReach;
  for (final WheelDot dot in wheel.coloured) {
    final double d = (layout.position(dot) - at).distance;
    if (d <= bestDistance) {
      best = dot;
      bestDistance = d;
    }
  }
  if (best != null) return (dot: best, owned: true);
  bestDistance = colourMapRangeReach;
  for (final WheelDot dot in range) {
    final double d = (layout.position(dot) - at).distance;
    if (d <= bestDistance) {
      best = dot;
      bestDistance = d;
    }
  }
  return best == null ? null : (dot: best, owned: false);
}

/// Paints the colour map: a grid of 8 hue bands by 3 lightness bands whose
/// empty cells are hatched, the faint dots of the whole range, the markers
/// the user owns and a hue strip under it all.
class ColourMapPainter extends CustomPainter {
  ColourMapPainter({
    required this.wheel,
    required this.range,
    required this.colors,
    this.selectedId,
  });

  /// The markers the user owns.
  final CollectionWheel wheel;

  /// The faint dots of the whole range; empty to draw none.
  final List<WheelDot> range;

  final InkColors colors;

  /// The `brandId:CODE` of the marker last tapped, ringed on the map.
  final String? selectedId;

  @override
  void paint(Canvas canvas, Size size) {
    final ColourMapLayout layout = ColourMapLayout(size);
    final Paint line = Paint()
      ..color = colors.line
      ..style = PaintingStyle.stroke
      ..strokeWidth = InkGeometry.border;
    final Paint hatch = Paint()
      ..color = colors.strong.withValues(alpha: InkOpacity.hatch)
      ..style = PaintingStyle.stroke
      ..strokeWidth = InkGeometry.border;

    // Cells: empty ones hatched, so a gap reads without colour.
    for (final HueFamily family in HueFamily.values) {
      for (final LightnessBand band in LightnessBand.values) {
        final Rect cell = layout.cell(family, band);
        if (wheel.count(family, band) == 0) {
          canvas.save();
          canvas.clipRect(cell);
          for (double x = cell.left - cell.height; x < cell.right; x += 8) {
            canvas.drawLine(
              Offset(x, cell.bottom),
              Offset(x + cell.height, cell.top),
              hatch,
            );
          }
          canvas.restore();
        }
        canvas.drawRect(cell, line);
      }
    }

    // The whole range, faint, under the markers the user owns.
    for (final WheelDot dot in range) {
      canvas.drawCircle(
        layout.position(dot),
        colourMapRangeRadius,
        Paint()
          ..color = swatchColor(dot.color.hex)
              .withValues(alpha: InkOpacity.faint),
      );
    }

    final Paint ring = Paint()
      ..color = colors.fg2
      ..style = PaintingStyle.stroke
      ..strokeWidth = InkGeometry.border;
    for (final WheelDot dot in wheel.coloured) {
      final Offset at = layout.position(dot);
      canvas.drawCircle(
        at,
        colourMapOwnedRadius,
        Paint()..color = swatchColor(dot.color.hex),
      );
      canvas.drawCircle(at, colourMapOwnedRadius, ring);
    }
    _paintSelection(canvas, layout);

    // The hue strip: the colour of every hue, to read the map's columns by.
    final Rect strip = layout.strip;
    const int steps = 72;
    for (int i = 0; i < steps; i++) {
      final double hue = HueFamily.red.from + (i + 0.5) * 360 / steps;
      canvas.drawRect(
        Rect.fromLTRB(
          strip.left + strip.width * i / steps,
          strip.top,
          strip.left + strip.width * (i + 1) / steps + 0.5,
          strip.bottom,
        ),
        Paint()..color = Color(wheelStripColor(hue).colorInt),
      );
    }
  }

  void _paintSelection(Canvas canvas, ColourMapLayout layout) {
    final String? id = selectedId;
    if (id == null) return;
    for (final WheelDot dot in <WheelDot>[...wheel.coloured, ...range]) {
      if (dot.color.colorId != id) continue;
      canvas.drawCircle(
        layout.position(dot),
        colourMapOwnedRadius + 4,
        Paint()
          ..color = colors.action
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      return;
    }
  }

  @override
  bool shouldRepaint(ColourMapPainter old) =>
      !identical(old.wheel, wheel) ||
      !identical(old.range, range) ||
      old.colors != colors ||
      old.selectedId != selectedId;
}

/// Height of the grey value strip.
const double valueStripHeight = 64;

/// The places of the greys in a value strip of [size]: lightness runs left
/// (dark) to right (light); greys of nearly the same value stack in rows.
List<Offset> valueStripPositions(List<WheelDot> greys, Size size) {
  const double pitch = colourMapOwnedRadius * 2 + 1;
  final double width = size.width - 2 * colourMapInset;
  final int rows = math.max(
    1,
    ((size.height - 2 * colourMapInset) / pitch).floor(),
  );
  final List<double> lastX = List<double>.filled(rows, double.negativeInfinity);
  final List<Offset> placed = <Offset>[];
  for (final WheelDot dot in greys) {
    final double x = colourMapInset + dot.lightness.clamp(0.0, 1.0) * width;
    int row = 0;
    for (int r = 0; r < rows; r++) {
      if (x - lastX[r] >= pitch) {
        row = r;
        break;
      }
      if (lastX[r] < lastX[row]) row = r;
    }
    lastX[row] = x;
    placed.add(Offset(x, colourMapInset + colourMapOwnedRadius + row * pitch));
  }
  return placed;
}

/// The grey nearest to [at] in a value strip of [size], or `null`.
WheelDot? valueStripHit(Offset at, Size size, List<WheelDot> greys) {
  final List<Offset> places = valueStripPositions(greys, size);
  WheelDot? best;
  double bestDistance = colourMapOwnedReach;
  for (int i = 0; i < greys.length; i++) {
    final double d = (places[i] - at).distance;
    if (d <= bestDistance) {
      best = greys[i];
      bestDistance = d;
    }
  }
  return best;
}

/// Paints the greys of the collection on a strip from dark to light.
class ValueStripPainter extends CustomPainter {
  ValueStripPainter({
    required this.greys,
    required this.colors,
    this.selectedId,
  });

  final List<WheelDot> greys;
  final InkColors colors;
  final String? selectedId;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> places = valueStripPositions(greys, size);
    final Paint ring = Paint()
      ..color = colors.fg2
      ..style = PaintingStyle.stroke
      ..strokeWidth = InkGeometry.border;
    for (int i = 0; i < greys.length; i++) {
      canvas.drawCircle(
        places[i],
        colourMapOwnedRadius,
        Paint()..color = swatchColor(greys[i].color.hex),
      );
      canvas.drawCircle(places[i], colourMapOwnedRadius, ring);
      if (greys[i].color.colorId == selectedId) {
        canvas.drawCircle(
          places[i],
          colourMapOwnedRadius + 4,
          Paint()
            ..color = colors.action
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(ValueStripPainter old) =>
      !identical(old.greys, greys) ||
      old.colors != colors ||
      old.selectedId != selectedId;
}
