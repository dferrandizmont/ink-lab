import 'dart:math' as math;

import 'color_utils.dart';
import 'model/marker_color.dart';

// The "colour map" of a collection: every marker placed by hue and lightness
// in OKLCH (the perceptual space `color_utils.dart` already offers), so a gap
// in the hues or in the values reads at a glance. Greys have no hue worth
// speaking of and live in a value strip of their own.
//
// Everything here is plain geometry on numbers; the screen paints it.

/// A band of the hue circle, named the way a person would.
///
/// The bands follow OKLCH hue angles: red is centred near 30 degrees, orange
/// near 55, yellow near 100, green near 145, teal near 195, blue near 255,
/// violet near 295 and magenta near 335.
enum HueFamily {
  red(350, 40),
  orange(40, 75),
  yellow(75, 115),
  green(115, 170),
  teal(170, 225),
  blue(225, 275),
  violet(275, 320),
  magenta(320, 350);

  const HueFamily(this.from, this.to);

  /// First hue angle of the band, in degrees (inclusive).
  final double from;

  /// Hue angle where the next band starts, in degrees (exclusive).
  final double to;

  /// How wide the band is, in degrees.
  double get span => (to - from + 360) % 360;

  /// The band of [hue] (degrees, any value).
  static HueFamily of(double hue) {
    final double h = ((hue % 360) + 360) % 360;
    for (final HueFamily family in values) {
      if ((h - family.from + 360) % 360 < family.span) return family;
    }
    return red;
  }
}

/// How light a marker is: three bands of OKLab lightness.
enum LightnessBand {
  light(0.78, 1.0),
  mid(0.55, 0.78),
  dark(0.0, 0.55);

  const LightnessBand(this.from, this.to);

  /// Lowest lightness of the band (inclusive).
  final double from;

  /// Highest lightness of the band (exclusive, except the lightest band).
  final double to;

  static LightnessBand of(double lightness) {
    if (lightness >= light.from) return light;
    if (lightness >= mid.from) return mid;
    return dark;
  }
}

/// One marker with its place in the map.
final class WheelDot {
  const WheelDot({
    required this.color,
    required this.hue,
    required this.chroma,
    required this.lightness,
  });

  /// The marker.
  final MarkerColor color;

  /// OKLCH hue, degrees in [0, 360).
  final double hue;

  /// OKLCH chroma: 0 for a perfect grey.
  final double chroma;

  /// OKLab lightness in [0, 1].
  final double lightness;

  /// Below [greyChroma] a colour has no hue worth plotting.
  bool get isGrey => chroma < greyChroma;

  HueFamily get family => HueFamily.of(hue);
  LightnessBand get band => LightnessBand.of(lightness);

  /// The markers whose chroma is under this are treated as greys. Warm and
  /// cool greys sit around 0.01-0.02; the palest skin tones start near 0.04.
  static const double greyChroma = 0.03;

  /// [color] placed in the map, or `null` when its hex is not a colour.
  static WheelDot? of(MarkerColor color) {
    final OklabColor lab;
    try {
      lab = hexToOklab(color.hex);
    } on FormatException {
      return null;
    }
    final double chroma = math.sqrt(lab.a * lab.a + lab.b * lab.b);
    final double hue = (math.atan2(lab.b, lab.a) * 180 / math.pi + 360) % 360;
    return WheelDot(color: color, hue: hue, chroma: chroma, lightness: lab.l);
  }
}

/// The map of a set of markers: the coloured ones by hue and lightness, the
/// greys apart, and how many fall in each of the 24 cells (8 hue bands by 3
/// lightness bands).
final class CollectionWheel {
  CollectionWheel._(this.coloured, this.greys, this._cells);

  /// Places [markers]; those with an unreadable hex are left out.
  factory CollectionWheel.of(Iterable<MarkerColor> markers) {
    final List<WheelDot> coloured = <WheelDot>[];
    final List<WheelDot> greys = <WheelDot>[];
    final Map<(HueFamily, LightnessBand), int> cells =
        <(HueFamily, LightnessBand), int>{};
    for (final MarkerColor marker in markers) {
      final WheelDot? dot = WheelDot.of(marker);
      if (dot == null) continue;
      if (dot.isGrey) {
        greys.add(dot);
      } else {
        coloured.add(dot);
        final (HueFamily, LightnessBand) cell = (dot.family, dot.band);
        cells[cell] = (cells[cell] ?? 0) + 1;
      }
    }
    greys.sort((WheelDot a, WheelDot b) => a.lightness.compareTo(b.lightness));
    return CollectionWheel._(coloured, greys, cells);
  }

  /// The markers with a hue.
  final List<WheelDot> coloured;

  /// The greys, darkest first.
  final List<WheelDot> greys;

  final Map<(HueFamily, LightnessBand), int> _cells;

  /// How many coloured markers fall in the cell.
  int count(HueFamily family, LightnessBand band) =>
      _cells[(family, band)] ?? 0;

  /// How many coloured markers a hue band holds.
  int familyCount(HueFamily family) => <int>[
    for (final LightnessBand band in LightnessBand.values) count(family, band),
  ].fold(0, (int a, int b) => a + b);

  /// The coloured markers of a hue band, lightest first.
  List<WheelDot> inFamily(HueFamily family) =>
      coloured.where((WheelDot d) => d.family == family).toList()
        ..sort((WheelDot a, WheelDot b) => b.lightness.compareTo(a.lightness));

  /// The cells of the 8 x 3 grid with no marker in them.
  int get emptyCells => <int>[
    for (final HueFamily family in HueFamily.values)
      for (final LightnessBand band in LightnessBand.values)
        if (count(family, band) == 0) 1,
  ].length;

  /// The number of cells of the grid.
  static int get cellCount =>
      HueFamily.values.length * LightnessBand.values.length;
}

/// The lightness at the bottom and the top of the map. Markers are never
/// darker than the bottom (black is a grey) nor lighter than the top.
const double wheelMinLightness = 0.25;
const double wheelMaxLightness = 1.0;

/// Where [hue] sits across the map, 0 on the left to 1 on the right. The map
/// starts at the red band so red stays in one piece.
double wheelX(double hue) =>
    ((((hue - HueFamily.red.from) % 360) + 360) % 360) / 360;

/// Where [lightness] sits down the map, 0 at the top (lightest) to 1 at the
/// bottom (darkest).
double wheelY(double lightness) =>
    ((wheelMaxLightness - lightness) / (wheelMaxLightness - wheelMinLightness))
        .clamp(0.0, 1.0);

/// A colour of the hue strip under the map: [hue] at a lightness and chroma
/// that every hue can show on screen.
RgbColor wheelStripColor(double hue) {
  final double radians = hue * math.pi / 180;
  return oklabToRgb(
    OklabColor(0.75, 0.1 * math.cos(radians), 0.1 * math.sin(radians)),
  );
}
