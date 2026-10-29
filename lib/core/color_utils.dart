import 'dart:math' as math;

import 'collection_utils.dart';
import 'model/marker_color.dart';

final class RgbColor {
  const RgbColor(this.r, this.g, this.b)
    : assert(r >= 0 && r <= 255),
      assert(g >= 0 && g <= 255),
      assert(b >= 0 && b <= 255);
  final int r, g, b;
  int get colorInt => 0xff000000 | (r << 16) | (g << 8) | b;
}

final class LabColor {
  const LabColor(this.l, this.a, this.b);
  final double l, a, b;
}

/// OKLab uses L in [0, 1], rather than CIELAB's [0, 100].
final class OklabColor {
  const OklabColor(this.l, this.a, this.b);
  final double l, a, b;
}

final class ColorDistanceMatch {
  const ColorDistanceMatch({required this.color, required this.deltaE});
  final MarkerColor color;
  final double deltaE;
}

/// RGB shorthand, RRGGBB and AARRGGBB, with optional '#' or '0x'.
int hexToColorInt(String hex) {
  var value = hex.startsWith('#')
      ? hex.substring(1)
      : hex.toLowerCase().startsWith('0x')
      ? hex.substring(2)
      : hex;
  if (RegExp(r'^[0-9a-fA-F]{3}$').hasMatch(value)) {
    value = value.split('').map((digit) => '$digit$digit').join();
  }
  if (!RegExp(r'^(?:[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$').hasMatch(value)) {
    throw FormatException('Invalid hex color', hex);
  }
  final parsed = int.parse(value, radix: 16);
  return value.length == 6 ? 0xff000000 | parsed : parsed;
}

RgbColor colorIntToRgb(int value) =>
    RgbColor((value >> 16) & 255, (value >> 8) & 255, value & 255);
RgbColor hexToRgb(String hex) => colorIntToRgb(hexToColorInt(hex));
String colorIntToHex(int value) =>
    (value & 0xffffff).toRadixString(16).padLeft(6, '0').toUpperCase();
String rgbToHex(RgbColor rgb) => colorIntToHex(rgb.colorInt);

bool isColorDark(String hex) {
  final rgb = hexToRgb(hex);
  return (rgb.r * 299 + rgb.g * 587 + rgb.b * 114) ~/ 1000 < 145;
}

double hueDistance(double a, double b) {
  final delta = (a - b).abs();
  return math.min(delta, 360 - delta);
}

/// Hue in degrees, saturation and value in [0, 1].
List<double> hexToHsv(String hex) => rgbToHsv(hexToRgb(hex));
List<double> rgbToHsv(RgbColor rgb) {
  final max = math.max(rgb.r, math.max(rgb.g, rgb.b)).toDouble();
  final min = math.min(rgb.r, math.min(rgb.g, rgb.b)).toDouble();
  final delta = max - min;
  return [_rgbHue(rgb, max, delta), max == 0 ? 0 : delta / max, max / 255];
}

double _rgbHue(RgbColor rgb, double max, double delta) {
  if (delta == 0) return 0;
  final hue = max == rgb.r
      ? (rgb.g - rgb.b) / delta
      : max == rgb.g
      ? 2 + (rgb.b - rgb.r) / delta
      : 4 + (rgb.r - rgb.g) / delta;
  return (hue * 60) % 360;
}

/// Hue in degrees, saturation and lightness in [0, 1].
List<double> hexToHsl(String hex) => rgbToHsl(hexToRgb(hex));
List<double> rgbToHsl(RgbColor rgb) {
  final max = math.max(rgb.r, math.max(rgb.g, rgb.b)).toDouble();
  final min = math.min(rgb.r, math.min(rgb.g, rgb.b)).toDouble();
  final delta = max - min;
  final l = (max + min) / 510;
  final s = delta == 0 ? 0.0 : delta / 255 / (1 - (2 * l - 1).abs());
  return [_rgbHue(rgb, max, delta), s, l];
}

RgbColor hslToRgb(double hue, double saturation, double lightness) =>
    _cylindricalToRgb(
      hue,
      (1 - (2 * lightness - 1).abs()) * saturation,
      lightness - (1 - (2 * lightness - 1).abs()) * saturation / 2,
    );

RgbColor hsvToRgb(double hue, double saturation, double value) =>
    _cylindricalToRgb(hue, value * saturation, value * (1 - saturation));

RgbColor _cylindricalToRgb(double hue, double c, double m) {
  final h = (hue % 360) / 60;
  final x = c * (1 - (h % 2 - 1).abs());
  final channels = switch (h.floor()) {
    0 => (c, x, 0.0),
    1 => (x, c, 0.0),
    2 => (0.0, c, x),
    3 => (0.0, x, c),
    4 => (x, 0.0, c),
    _ => (c, 0.0, x),
  };
  return RgbColor(
    _byte(channels.$1 + m),
    _byte(channels.$2 + m),
    _byte(channels.$3 + m),
  );
}

int _byte(double value) => (value * 255).round().clamp(0, 255);
double linearizeSrgbChannel(double channel) => channel <= 0.04045
    ? channel / 12.92
    : math.pow((channel + 0.055) / 1.055, 2.4).toDouble();
double _encodeSrgb(double channel) => channel <= 0.0031308
    ? channel * 12.92
    : 1.055 * math.pow(channel, 1 / 2.4) - 0.055;
double _labPivot(double value) => value > 0.008856
    ? math.pow(value, 1 / 3).toDouble()
    : 7.787 * value + 16 / 116;

LabColor hexToLab(String hex) => rgbToLab(hexToRgb(hex));
LabColor colorIntToLab(int colorInt) => rgbToLab(colorIntToRgb(colorInt));
LabColor rgbToLab(RgbColor rgb) {
  final r = linearizeSrgbChannel(rgb.r / 255);
  final g = linearizeSrgbChannel(rgb.g / 255);
  final b = linearizeSrgbChannel(rgb.b / 255);
  final fx = _labPivot((r * 0.4124 + g * 0.3576 + b * 0.1805) / 0.95047);
  final fy = _labPivot(r * 0.2126 + g * 0.7152 + b * 0.0722);
  final fz = _labPivot((r * 0.0193 + g * 0.1192 + b * 0.9505) / 1.08883);
  return LabColor(116 * fy - 16, 500 * (fx - fy), 200 * (fy - fz));
}

/// Inverse of the source's rounded sRGB/D65 matrix; output is gamut-clipped.
RgbColor labToRgb(LabColor lab) {
  double inverse(double f) {
    final cube = f * f * f;
    return cube > 0.008856 ? cube : (f - 16 / 116) / 7.787;
  }

  final fy = (lab.l + 16) / 116;
  final x = inverse(fy + lab.a / 500) * 0.95047;
  final y = inverse(fy);
  final z = inverse(fy - lab.b / 200) * 1.08883;
  return RgbColor(
    _byte(_encodeSrgb(x * 3.24062548 - y * 1.53720797 - z * 0.49862860)),
    _byte(_encodeSrgb(-x * 0.96893071 + y * 1.87575606 + z * 0.04151752)),
    _byte(_encodeSrgb(x * 0.05571012 - y * 0.20402105 + z * 1.05699594)),
  );
}

double deltaE76(LabColor a, LabColor b) =>
    _distance(a.l - b.l, a.a - b.a, a.b - b.b);
double _distance(double l, double a, double b) =>
    math.sqrt(l * l + a * a + b * b);

OklabColor hexToOklab(String hex) => rgbToOklab(hexToRgb(hex));
OklabColor rgbToOklab(RgbColor rgb) {
  final r = linearizeSrgbChannel(rgb.r / 255);
  final g = linearizeSrgbChannel(rgb.g / 255);
  final b = linearizeSrgbChannel(rgb.b / 255);
  double cbrt(double value) => value.sign * math.pow(value.abs(), 1 / 3);
  final l = cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b);
  final m = cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b);
  final s = cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b);
  return OklabColor(
    0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s,
  );
}

RgbColor oklabToRgb(OklabColor lab) {
  double cube(double v) => v * v * v;
  final l = cube(lab.l + 0.3963377774 * lab.a + 0.2158037573 * lab.b);
  final m = cube(lab.l - 0.1055613458 * lab.a - 0.0638541728 * lab.b);
  final s = cube(lab.l - 0.0894841775 * lab.a - 1.2914855480 * lab.b);
  return RgbColor(
    _byte(_encodeSrgb(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s)),
    _byte(_encodeSrgb(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s)),
    _byte(_encodeSrgb(-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s)),
  );
}

/// Euclidean OKLab distance, in native [0, 1] L units (no factor of 100).
double deltaEOklab(OklabColor a, OklabColor b) =>
    _distance(a.l - b.l, a.a - b.a, a.b - b.b);

List<ColorDistanceMatch> findClosestMarkerMatches(
  int sampleColorInt,
  List<MarkerColor> candidates, {
  int limit = 6,
}) {
  final sample = colorIntToLab(sampleColorInt);
  final matches = <ColorDistanceMatch>[];
  for (final candidate in candidates) {
    try {
      matches.add(
        ColorDistanceMatch(
          color: candidate,
          deltaE: deltaE76(sample, hexToLab(candidate.hex)),
        ),
      );
    } on FormatException {
      // Kotlin skips malformed candidate colors, retaining valid matches.
    }
  }
  return stableSortedBy(
    matches,
    (match) => match.deltaE,
  ).take(math.max(1, limit)).toList();
}
