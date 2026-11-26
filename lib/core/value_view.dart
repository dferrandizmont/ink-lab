import 'color_vision.dart';

// The "value view": a colour as only its lightness (its value, in the
// painter's word). Alcohol-marker artists use it to check that a drawing has
// enough contrast between its lights and darks, the mistake that is easiest
// to make with a set of markers.
//
// The grey is the relative luminance of WCAG / Rec. 709 (the weights of
// sRGB), computed on linear light and encoded back to sRGB. It is the same
// grey as the achromatopsia simulation of [ColorVision], so the two always
// agree.

/// The value (greyscale) view of colours.
abstract final class ValueView {
  /// The colour [hex] as the grey of the same luminance, as six lower-case
  /// hex digits. A hex that is not a colour comes back unchanged.
  static String greyHex(String hex) =>
      ColorVision.simulate(hex, ColorVisionType.achromatopsia);
}
