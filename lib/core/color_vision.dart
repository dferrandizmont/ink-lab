import 'color_utils.dart';
import 'match_quality.dart';

// "How does this palette look to someone who cannot tell red from green?"
//
// The simulation follows Machado, Oliveira and Fernandes (2009): a 3×3
// matrix that maps the linear RGB of a colour to the colour a dichromat
// sees. The three matrices are the ones of the paper at full severity
// (dichromacy); achromatopsia is the grey a colour becomes when only its
// lightness is left.
//
// Everything works in linear sRGB, with the same helpers the rest of the
// app uses (`linearizeSrgbChannel` and `encodeSrgbChannel`), so the
// simulation does not darken the mid-tones the way a naive gamma-space
// matrix would.

/// The kinds of colour vision deficiency the app can simulate.
enum ColorVisionType {
  /// No red cones: red turns dark and greenish (protanopia).
  protanopia,

  /// No green cones: red and green collapse into the same yellowish tone
  /// (deuteranopia).
  deuteranopia,

  /// No blue cones: blue and green become hard to tell apart (tritanopia).
  tritanopia,

  /// No cones at all: only the lightness of a colour is left
  /// (achromatopsia).
  achromatopsia;

  /// The label the app shows, in English; the UI localises it.
  String get label => switch (this) {
    protanopia => 'Protanopia',
    deuteranopia => 'Deuteranopia',
    tritanopia => 'Tritanopia',
    achromatopsia => 'Achromatopsia',
  };
}

/// The simulation of the colour vision deficiencies and the pairs of colours
/// they make hard to tell apart.
abstract final class ColorVision {
  /// The distance below which two colours are hard to tell apart.
  ///
  /// It is the app's "very close" band (see [MatchQuality]): a difference
  /// small enough that the two colours are easily mixed up, but still a
  /// visible one side by side. It is a constant because it is the default
  /// of [confusablePairs]; the test keeps it in step with [MatchQuality].
  static const double confusableThreshold = 5;

  /// The colour [hex] as someone with [type] sees it, as six lower-case hex
  /// digits.
  ///
  /// A hex that is not a colour comes back unchanged.
  static String simulate(String hex, ColorVisionType type) {
    try {
      return colorIntToHex(simulateInt(hexToColorInt(hex), type)).toLowerCase();
    } on FormatException {
      return hex;
    }
  }

  /// The colour [colorInt] as someone with [type] sees it, as opaque sRGB.
  static int simulateInt(int colorInt, ColorVisionType type) {
    final RgbColor rgb = colorIntToRgb(colorInt);
    final double r = linearizeSrgbChannel(rgb.r / 255);
    final double g = linearizeSrgbChannel(rgb.g / 255);
    final double b = linearizeSrgbChannel(rgb.b / 255);
    final List<double> seen = switch (type) {
      ColorVisionType.protanopia => _apply(_protanopia, r, g, b),
      ColorVisionType.deuteranopia => _apply(_deuteranopia, r, g, b),
      ColorVisionType.tritanopia => _apply(_tritanopia, r, g, b),
      ColorVisionType.achromatopsia => _grey(r, g, b),
    };
    return RgbColor(
      _byte(seen[0]),
      _byte(seen[1]),
      _byte(seen[2]),
    ).colorInt;
  }

  /// The pairs of [palette] that become hard to tell apart under [type].
  ///
  /// [palette] holds the colours as hex strings. Two colours are a pair when
  /// the distance between them, once simulated, is below [threshold]; the
  /// distance before the simulation comes with the pair, so a screen can say
  /// how much the simulation changed.
  ///
  /// The pairs come with the closest one first.
  static List<ConfusablePair> confusablePairs(
    List<String> palette, {
    required ColorVisionType type,
    double threshold = confusableThreshold,
  }) {
    final List<int> original = <int>[];
    final List<int> seen = <int>[];
    final List<int> indexes = <int>[];
    for (int i = 0; i < palette.length; i++) {
      final int? color = _colorIntOf(palette[i]);
      if (color == null) continue;
      indexes.add(i);
      original.add(color);
      seen.add(simulateInt(color, type));
    }
    final List<ConfusablePair> pairs = <ConfusablePair>[];
    for (int i = 0; i < seen.length; i++) {
      for (int j = i + 1; j < seen.length; j++) {
        final double distance = _distance(seen[i], seen[j]);
        if (distance >= threshold) continue;
        pairs.add(
          ConfusablePair(
            firstIndex: indexes[i],
            secondIndex: indexes[j],
            firstHex: palette[indexes[i]],
            secondHex: palette[indexes[j]],
            distance: distance,
            originalDistance: _distance(original[i], original[j]),
          ),
        );
      }
    }
    pairs.sort((ConfusablePair a, ConfusablePair b) {
      final int byDistance = a.distance.compareTo(b.distance);
      return byDistance != 0
          ? byDistance
          : a.firstIndex.compareTo(b.firstIndex);
    });
    return pairs;
  }

  /// The pairs of [palette] that become hard to tell apart, for every type.
  static Map<ColorVisionType, List<ConfusablePair>> confusablePairsByType(
    List<String> palette, {
    double threshold = confusableThreshold,
  }) => <ColorVisionType, List<ConfusablePair>>{
    for (final ColorVisionType type in ColorVisionType.values)
      type: confusablePairs(
        palette,
        type: type,
        threshold: threshold,
      ),
  };

  /// The distance between two colours, in ΔE76, the metric the app uses
  /// everywhere. A colour that is not a colour makes the distance
  /// [double.infinity].
  static double distance(String first, String second) {
    final int? a = _colorIntOf(first);
    final int? b = _colorIntOf(second);
    if (a == null || b == null) return double.infinity;
    return _distance(a, b);
  }

  /// The colour of [hex], or `null` when it is not a colour.
  static int? _colorIntOf(String hex) {
    try {
      return hexToColorInt(hex);
    } on FormatException {
      return null;
    }
  }

  static double _distance(int first, int second) => deltaE76(
    colorIntToLab(first),
    colorIntToLab(second),
  );

  /// The colour as a grey: only its lightness is left.
  static List<double> _grey(double r, double g, double b) {
    final double luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    return <double>[luminance, luminance, luminance];
  }

  /// The colour through the matrix of [type], in linear RGB.
  static List<double> _apply(
    List<List<double>> matrix,
    double r,
    double g,
    double b,
  ) => <double>[
    matrix[0][0] * r + matrix[0][1] * g + matrix[0][2] * b,
    matrix[1][0] * r + matrix[1][1] * g + matrix[1][2] * b,
    matrix[2][0] * r + matrix[2][1] * g + matrix[2][2] * b,
  ];

  static int _byte(double linear) =>
      (encodeSrgbChannel(linear.clamp(0.0, 1.0)) * 255).round().clamp(0, 255);
}

/// Two colours of a palette that become hard to tell apart.
final class ConfusablePair {
  const ConfusablePair({
    required this.firstIndex,
    required this.secondIndex,
    required this.firstHex,
    required this.secondHex,
    required this.distance,
    required this.originalDistance,
  });

  /// Where the first colour sits in the palette it came from.
  final int firstIndex;

  /// Where the second colour sits in the palette it came from.
  final int secondIndex;

  /// The first colour, as it was written.
  final String firstHex;

  /// The second colour, as it was written.
  final String secondHex;

  /// The distance between the two colours once simulated (ΔE76).
  final double distance;

  /// The distance between the two colours before the simulation (ΔE76).
  final double originalDistance;

  /// How close the two colours are once simulated, in the app's own words.
  MatchQuality get quality => MatchQuality.of(distance);
}

// The matrices of Machado, Oliveira and Fernandes (2009), "A
// Physiologically-based Model for Simulation of Color Vision Deficiency", at
// full severity (dichromacy). They map linear RGB to linear RGB.
//
//   protanomaly:   0.152286  1.052583 -0.204868
//                  0.114503  0.786281  0.099216
//                 -0.003882 -0.048116  1.051998
//
//   deuteranomaly: 0.367322  0.860646 -0.227968
//                  0.280085  0.672501  0.047413
//                 -0.011820  0.042940  0.968881
//
//   tritanomaly:   1.255528 -0.076749 -0.178779
//                 -0.078411  0.930809  0.147602
//                  0.004733  0.691367  0.303900
const List<List<double>> _protanopia = <List<double>>[
  <double>[0.152286, 1.052583, -0.204868],
  <double>[0.114503, 0.786281, 0.099216],
  <double>[-0.003882, -0.048116, 1.051998],
];

const List<List<double>> _deuteranopia = <List<double>>[
  <double>[0.367322, 0.860646, -0.227968],
  <double>[0.280085, 0.672501, 0.047413],
  <double>[-0.011820, 0.042940, 0.968881],
];

const List<List<double>> _tritanopia = <List<double>>[
  <double>[1.255528, -0.076749, -0.178779],
  <double>[-0.078411, 0.930809, 0.147602],
  <double>[0.004733, 0.691367, 0.303900],
];
