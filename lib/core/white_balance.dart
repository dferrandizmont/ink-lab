import 'dart:math' as math;

import 'color_utils.dart';

/// Why a tapped point was refused as the white of a photo.
enum WhiteBalanceRejection {
  /// The point is too dark to be white paper (it would need a huge boost).
  tooDark,

  /// The point has too strong a colour to be paper: balancing on it would
  /// tint the whole photo.
  tooColourful,
}

/// The outcome of choosing a point of a photo as its white reference.
sealed class WhiteBalanceFit {
  const WhiteBalanceFit();

  /// Builds the balance that turns the sRGB colour [reference] into white.
  ///
  /// Returns [WhiteBalanceRejected] when the point is not plausibly paper,
  /// so the caller can say so and leave the photo as it is.
  factory WhiteBalanceFit.fromReference(int reference) {
    final RgbColor rgb = colorIntToRgb(reference);
    final List<double> linear = <double>[
      linearizeSrgbChannel(rgb.r / 255),
      linearizeSrgbChannel(rgb.g / 255),
      linearizeSrgbChannel(rgb.b / 255),
    ];
    final double luminance =
        0.2126 * linear[0] + 0.7152 * linear[1] + 0.0722 * linear[2];
    if (luminance < WhiteBalance.minReferenceLuminance) {
      return const WhiteBalanceRejected(WhiteBalanceRejection.tooDark);
    }
    // The gain a channel needs is 1 / channel; one that would pass the limit
    // means the point is far from neutral.
    final double smallest = linear.reduce(math.min);
    if (smallest <= 0 || 1 / smallest > WhiteBalance.maxGain) {
      return const WhiteBalanceRejected(WhiteBalanceRejection.tooColourful);
    }
    return WhiteBalanceApplied(
      WhiteBalance._(
        _clampGain(1 / linear[0]),
        _clampGain(1 / linear[1]),
        _clampGain(1 / linear[2]),
      ),
    );
  }

  static double _clampGain(double gain) =>
      gain.clamp(WhiteBalance.minGain, WhiteBalance.maxGain).toDouble();
}

/// The point is paper: [balance] makes it white.
final class WhiteBalanceApplied extends WhiteBalanceFit {
  const WhiteBalanceApplied(this.balance);

  final WhiteBalance balance;
}

/// The point cannot be used as the white of the photo.
final class WhiteBalanceRejected extends WhiteBalanceFit {
  const WhiteBalanceRejected(this.reason);

  final WhiteBalanceRejection reason;
}

/// A von Kries style white balance: one gain per channel, applied in linear
/// RGB, that turns the point the user tapped into neutral white.
///
/// Pure arithmetic on sRGB integers, so it is cheap to test. Photos are never
/// rewritten: the balance is applied to the colours that are sampled (and, on
/// screen, as a colour filter on the preview).
final class WhiteBalance {
  const WhiteBalance._(this.gainR, this.gainG, this.gainB);

  /// No correction.
  static const WhiteBalance identity = WhiteBalance._(1, 1, 1);

  /// Smallest linear luminance a point may have to count as paper: a middle
  /// grey (sRGB about 137) or lighter.
  static const double minReferenceLuminance = 0.25;

  /// Gains are kept within this range, so a bad tap can never blow a photo up.
  static const double minGain = 0.5, maxGain = 4;

  /// Multipliers of the linear red, green and blue channels.
  final double gainR, gainG, gainB;

  /// Whether the balance leaves every colour as it is.
  bool get isIdentity => gainR == 1 && gainG == 1 && gainB == 1;

  /// [colorInt] (sRGB, `0xAARRGGBB`) as seen with this balance; opaque.
  int apply(int colorInt) {
    if (isIdentity) return colorInt | 0xff000000;
    final RgbColor rgb = colorIntToRgb(colorInt);
    int channel(int value, double gain) =>
        (encodeSrgbChannel(
                  (linearizeSrgbChannel(value / 255) * gain).clamp(0.0, 1.0),
                ) *
                255)
            .round()
            .clamp(0, 255);
    return RgbColor(
      channel(rgb.r, gainR),
      channel(rgb.g, gainG),
      channel(rgb.b, gainB),
    ).colorInt;
  }

  /// The 4×5 colour matrix (row-major, as Flutter's `ColorFilter.matrix`)
  /// that multiplies the three channels by the gains.
  ///
  /// It works on linear values: wrap it between an sRGB-to-linear and a
  /// linear-to-sRGB filter to preview the correction faithfully.
  List<double> get linearMatrix => <double>[
    gainR, 0, 0, 0, 0, //
    0, gainG, 0, 0, 0,
    0, 0, gainB, 0, 0,
    0, 0, 0, 1, 0,
  ];

  @override
  bool operator ==(Object other) =>
      other is WhiteBalance &&
      other.gainR == gainR &&
      other.gainG == gainG &&
      other.gainB == gainB;

  @override
  int get hashCode => Object.hash(gainR, gainG, gainB);

  @override
  String toString() => 'WhiteBalance($gainR, $gainG, $gainB)';
}
