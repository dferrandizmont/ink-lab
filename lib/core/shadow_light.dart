import 'blending_chain.dart';
import 'color_utils.dart';
import 'model/marker_color.dart';
import 'natural_sort.dart';

// "Shadow / Light": for a marker, the closest darker and the closest lighter
// marker the user owns in the same colour family. They are the two markers to
// pick up to shade and to lift the colour.
//
// The family is the one the blending chains use (`inSameHueFamily`: same hue
// within a window that widens as the colour gets greyer), and the steps are
// measured in OKLab, where lightness is perceptual. A neighbour has to differ
// by at least [BlendingRules.minStep] of lightness: under it two markers look
// the same and neither is a shadow nor a light. Of the markers that qualify,
// the closest in OKLab distance wins, so the step is the smallest one there is.

/// One neighbour of a marker: a darker or a lighter one.
final class ShadowLightStep {
  const ShadowLightStep({
    required this.color,
    required this.deltaE,
    required this.lightnessStep,
  });

  /// The neighbour.
  final MarkerColor color;

  /// The OKLab distance to the marker (native `[0, 1]` units).
  final double deltaE;

  /// How much lighter (positive) or darker (negative) the neighbour is, in
  /// OKLab lightness.
  final double lightnessStep;
}

/// The closest darker and lighter markers of one marker.
final class ShadowLight {
  const ShadowLight({this.shadow, this.light});

  /// The closest darker marker of the family, or `null` when there is none.
  final ShadowLightStep? shadow;

  /// The closest lighter marker of the family, or `null` when there is none.
  final ShadowLightStep? light;

  /// Whether the marker has neither.
  bool get isEmpty => shadow == null && light == null;
}

/// The closest darker ([ShadowLight.shadow]) and lighter ([ShadowLight.light])
/// marker of [owned] in the colour family of [marker].
///
/// [marker] itself and the colourless blenders are never offered; neither is
/// a marker whose hex cannot be read. Leave the dried-out markers out of
/// [owned]: they cannot be used.
ShadowLight findShadowAndLight(
  MarkerColor marker,
  Iterable<MarkerColor> owned,
) {
  final OklabColor origin;
  try {
    origin = hexToOklab(marker.hex);
  } on FormatException {
    return const ShadowLight();
  }
  ShadowLightStep? shadow;
  ShadowLightStep? light;
  for (final MarkerColor other in owned) {
    if (other.colorId == marker.colorId || isColourlessBlender(other)) continue;
    final OklabColor lab;
    try {
      lab = hexToOklab(other.hex);
    } on FormatException {
      continue;
    }
    final double step = lab.l - origin.l;
    if (step.abs() < BlendingRules.minStep) continue;
    if (!inSameHueFamily(marker, other)) continue;
    final ShadowLightStep candidate = ShadowLightStep(
      color: other,
      deltaE: deltaEOklab(origin, lab),
      lightnessStep: step,
    );
    if (step < 0) {
      if (_closer(candidate, shadow)) shadow = candidate;
    } else {
      if (_closer(candidate, light)) light = candidate;
    }
  }
  return ShadowLight(shadow: shadow, light: light);
}

bool _closer(ShadowLightStep candidate, ShadowLightStep? best) {
  if (best == null) return true;
  final int byDistance = candidate.deltaE.compareTo(best.deltaE);
  if (byDistance != 0) return byDistance < 0;
  return naturalCodeComparator(candidate.color.newCode, best.color.newCode) < 0;
}
