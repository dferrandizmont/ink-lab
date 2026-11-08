import 'color_utils.dart';
import 'color_vision.dart';

// The "value view": a colour as only its lightness (its value, in the
// painter's word). Alcohol-marker artists use it to check that a drawing has
// enough contrast between its lights and darks, the mistake that is easiest
// to make with a set of markers.
//
// The grey is the relative luminance of WCAG / Rec. 709 (the weights of
// sRGB), computed on linear light and encoded back to sRGB. It is the same
// grey as the achromatopsia simulation of [ColorVision], so the two always
// agree; this file only gives it a name and the matrix that draws a photo in
// it.

/// The value (greyscale) view of colours.
abstract final class ValueView {
  /// Weights of red, green and blue in the relative luminance of sRGB.
  static const double redWeight = 0.2126,
      greenWeight = 0.7152,
      blueWeight = 0.0722;

  /// The relative luminance of [colorInt], from 0 (black) to 1 (white), on
  /// linear light.
  static double luminance(int colorInt) {
    final RgbColor rgb = colorIntToRgb(colorInt);
    return redWeight * linearizeSrgbChannel(rgb.r / 255) +
        greenWeight * linearizeSrgbChannel(rgb.g / 255) +
        blueWeight * linearizeSrgbChannel(rgb.b / 255);
  }

  /// The colour [colorInt] as the grey of the same luminance, opaque sRGB.
  static int greyInt(int colorInt) =>
      ColorVision.simulateInt(colorInt, ColorVisionType.achromatopsia);

  /// The colour [hex] as the grey of the same luminance, as six lower-case
  /// hex digits. A hex that is not a colour comes back unchanged.
  static String greyHex(String hex) =>
      ColorVision.simulate(hex, ColorVisionType.achromatopsia);

  /// The 4×5 colour matrix (row-major, the layout of Flutter's
  /// `ColorFilter.matrix`) that makes every pixel the grey of its luminance.
  ///
  /// It works on LINEAR light: draw a photo through an sRGB-to-linear filter,
  /// then this matrix, then a linear-to-sRGB filter, so the grey of the photo
  /// is the one [greyInt] gives for its colours. Alpha is kept.
  static const List<double> linearMatrix = <double>[
    redWeight, greenWeight, blueWeight, 0, 0, //
    redWeight, greenWeight, blueWeight, 0, 0, //
    redWeight, greenWeight, blueWeight, 0, 0, //
    0, 0, 0, 1, 0, //
  ];
}
