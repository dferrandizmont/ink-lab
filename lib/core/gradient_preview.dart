import 'dart:math' as math;

import 'blending_chain.dart';
import 'color_utils.dart';
import 'model/marker_color.dart';
import 'natural_sort.dart';

// "Blend with…": a gradient from one marker to another, and the markers the
// user owns that would make the steps between them.
//
// The path is a straight line in OKLab, where equal steps look equal. The
// number of intermediate markers follows the length of the path (one per
// [BlendingRules.idealStep] of OKLab distance, at most
// [GradientRules.maxSteps]). For each stop of the path the closest owned
// marker is picked, as long as it sits within [GradientRules.maxOffPath] of
// the line; a marker is used once. The longest hop between neighbours that is
// still over [BlendingRules.maxStep] is a gap: the closest marker the user
// does not own to the middle of that gap is what to buy.

/// The knobs of the gradient, for tests and tuning.
abstract final class GradientRules {
  /// Most intermediate markers of a gradient.
  static const int maxSteps = 5;

  /// How far (OKLab distance) a marker may sit from the line between the two
  /// ends to count as a step of the gradient. About 0.6 of an ideal blending
  /// step: further than that the marker is a different colour, not a stage of
  /// this one.
  static const double maxOffPath = 0.06;

  /// Colour stops sampled along the path for the gradient strip. Flutter
  /// mixes the stops of a gradient in sRGB, which is darker in the middle
  /// than OKLab; stops this close make the difference invisible.
  static const int samples = 12;
}

/// A step of the gradient: an owned marker near a point of the path.
final class GradientPick {
  const GradientPick({
    required this.t,
    required this.color,
    required this.offPath,
  });

  /// Where the step sits on the path: 0 is the first marker, 1 the second.
  final double t;

  /// The owned marker.
  final MarkerColor color;

  /// How far the marker is from the point of the path (OKLab distance).
  final double offPath;
}

/// The gradient between two markers and the markers that make it.
final class GradientPreview {
  const GradientPreview({
    required this.from,
    required this.to,
    required this.distance,
    required this.stops,
    required this.picks,
    this.slots = 0,
    this.missing,
    this.missingT,
    this.missingOffPath,
  });

  /// The marker the gradient starts at.
  final MarkerColor from;

  /// The marker it ends at.
  final MarkerColor to;

  /// The OKLab distance between the two.
  final double distance;

  /// The hex of the colour stops of the strip, from [from] to [to], equally
  /// spaced and mixed in OKLab.
  final List<String> stops;

  /// The owned markers between the two, in order from [from] to [to].
  final List<GradientPick> picks;

  /// How many markers in between the path asks for: 0 when the two are close
  /// enough to blend straight into each other.
  final int slots;

  /// The closest marker the user does not own to the biggest gap, or `null`
  /// when there is no big gap.
  final MarkerColor? missing;

  /// Where on the path [missing] belongs.
  final double? missingT;

  /// How far [missing] is from its point of the path.
  final double? missingOffPath;

  /// Whether the two markers are close enough to need nothing in between.
  bool get isDirect => slots == 0;
}

/// The gradient from [from] to [to].
///
/// [owned] are the markers the user can use (dried-out ones left out), of any
/// brand; they provide the steps. [catalogue] are the markers the user could
/// buy: the closest one that is not in [owned] is offered for the biggest gap.
GradientPreview buildGradientPreview(
  MarkerColor from,
  MarkerColor to, {
  required Iterable<MarkerColor> owned,
  Iterable<MarkerColor> catalogue = const <MarkerColor>[],
}) {
  final OklabColor a = hexToOklab(from.hex);
  final OklabColor b = hexToOklab(to.hex);
  final double distance = deltaEOklab(a, b);
  final List<String> stops = <String>[
    for (int i = 0; i < GradientRules.samples; i++)
      _hexOf(_mix(a, b, i / (GradientRules.samples - 1))),
  ];

  // One intermediate marker per ideal step of the path, so two hops of about
  // an ideal step each need one in between.
  final int slots = math.min(
    GradientRules.maxSteps,
    (distance / BlendingRules.idealStep).round() - 1,
  );
  if (slots < 1) {
    return GradientPreview(
      from: from,
      to: to,
      distance: distance,
      stops: stops,
      picks: const <GradientPick>[],
    );
  }

  final List<_Candidate> pool = _candidates(owned, from, to);
  final Set<String> used = <String>{};
  final List<GradientPick> picks = <GradientPick>[];
  for (int k = 1; k <= slots; k++) {
    final double t = k / (slots + 1);
    final _Candidate? best = _closest(pool, _mix(a, b, t), used);
    if (best == null || best.offPath > GradientRules.maxOffPath) continue;
    used.add(best.color.colorId);
    picks.add(GradientPick(t: t, color: best.color, offPath: best.offPath));
  }

  // The longest hop between neighbours (ends included) that is over the
  // largest step a blend hides.
  double widest = 0;
  double gapStart = 0, gapEnd = 1;
  double previousT = 0;
  OklabColor previous = a;
  void hop(double t, OklabColor lab) {
    final double d = deltaEOklab(previous, lab);
    if (d > widest) {
      widest = d;
      gapStart = previousT;
      gapEnd = t;
    }
    previousT = t;
    previous = lab;
  }

  for (final GradientPick pick in picks) {
    hop(pick.t, hexToOklab(pick.color.hex));
  }
  hop(1, b);

  MarkerColor? missing;
  double? missingT, missingOffPath;
  if (widest > BlendingRules.maxStep) {
    final double t = (gapStart + gapEnd) / 2;
    final Set<String> ownedIds = <String>{
      for (final MarkerColor c in owned) c.colorId,
    };
    final _Candidate? buy = _closest(
      _candidates(
        catalogue.where((MarkerColor c) => !ownedIds.contains(c.colorId)),
        from,
        to,
      ),
      _mix(a, b, t),
      const <String>{},
    );
    if (buy != null && buy.offPath <= GradientRules.maxOffPath) {
      missing = buy.color;
      missingT = t;
      missingOffPath = buy.offPath;
    }
  }

  return GradientPreview(
    from: from,
    to: to,
    distance: distance,
    stops: stops,
    picks: List<GradientPick>.unmodifiable(picks),
    slots: slots,
    missing: missing,
    missingT: missingT,
    missingOffPath: missingOffPath,
  );
}

final class _Candidate {
  _Candidate(this.color, this.lab);

  final MarkerColor color;
  final OklabColor lab;

  /// Set by [_closest] for the point it was asked about.
  double offPath = 0;
}

/// The usable markers: readable, not an end of the gradient, not a blender.
List<_Candidate> _candidates(
  Iterable<MarkerColor> markers,
  MarkerColor from,
  MarkerColor to,
) {
  final List<_Candidate> found = <_Candidate>[];
  for (final MarkerColor c in markers) {
    if (c.colorId == from.colorId ||
        c.colorId == to.colorId ||
        isColourlessBlender(c)) {
      continue;
    }
    try {
      found.add(_Candidate(c, hexToOklab(c.hex)));
    } on FormatException {
      // A malformed entry is simply not offered.
    }
  }
  return found;
}

/// The candidate closest to [point] that is not in [used], with its distance
/// written to [_Candidate.offPath]; ties by natural code order.
_Candidate? _closest(
  List<_Candidate> pool,
  OklabColor point,
  Set<String> used,
) {
  _Candidate? best;
  double bestDistance = double.infinity;
  for (final _Candidate c in pool) {
    if (used.contains(c.color.colorId)) continue;
    final double d = deltaEOklab(point, c.lab);
    final bool better =
        d < bestDistance - 1e-9 ||
        (best != null &&
            (d - bestDistance).abs() <= 1e-9 &&
            naturalCodeComparator(c.color.newCode, best.color.newCode) < 0);
    if (better) {
      best = c;
      bestDistance = d;
    }
  }
  best?.offPath = bestDistance;
  return best;
}

OklabColor _mix(OklabColor a, OklabColor b, double t) => OklabColor(
  a.l + (b.l - a.l) * t,
  a.a + (b.a - a.a) * t,
  a.b + (b.b - a.b) * t,
);

String _hexOf(OklabColor lab) => rgbToHex(oklabToRgb(lab));
