import 'dart:math' as math;
import 'dart:typed_data';

import 'color_utils.dart';
import 'model/marker_color.dart';
import 'model/scene.dart';
import 'natural_sort.dart';

// "What should I buy next?": ranks the markers a user does not have by how
// much each would improve what they can draw.
//
// Every colour role of every drawing scene asks for a colour (see
// [sceneRoleTargets]). For a role, the owned marker nearest to that colour is
// the best the user can do today; a candidate improves the role by the
// colour distance it takes off. A scene counts as improved when its roles
// gain at least [minSceneGain] together.
//
// Pure Dart, no I/O. The Lab colour of every marker and every target is
// computed once, so 500 markers against the 67 scenes is a few milliseconds.

/// The colour a role of a scene asks for, in CIE Lab.
///
/// A role can allow more than one hue (a "background" that may be green or
/// blue): [colors] then holds one colour per hue and the nearest counts.
final class RoleTarget {
  const RoleTarget(this.role, this.colors);

  /// The role name, for example `Soft shadow`.
  final String role;

  /// The acceptable colours; never empty.
  final List<LabColor> colors;
}

/// The colour of every role of [scene].
///
/// The scene engine picks roles relative to a base marker, so the targets are
/// built from the scene's own seed colour: the seed's hue turned by the role's
/// hue offsets, its value and saturation moved by the role's deltas and kept
/// inside the role's saturation limits (a neutral role stays pale). This is
/// the colour the engine looks for when the base is the seed itself.
List<RoleTarget> sceneRoleTargets(Scene scene) => <RoleTarget>[
  for (final ScenarioTarget target in scene.targets)
    RoleTarget(target.role, <LabColor>[
      for (final double offset
          in target.hueOffsets.isEmpty ? const <double>[0] : target.hueOffsets)
        _targetColor(scene, target, offset),
    ]),
];

LabColor _targetColor(Scene scene, ScenarioTarget target, double hueOffset) {
  double saturation = (scene.seedSaturation + target.saturationDelta).clamp(
    0.0,
    1.0,
  );
  final double value = (scene.seedValue + target.valueDelta).clamp(0.0, 1.0);
  if (target.preferNeutral) saturation = math.min(saturation, 0.3);
  final double? min = target.minSaturation, max = target.maxSaturation;
  if (min != null) saturation = math.max(saturation, min);
  if (max != null) saturation = math.min(saturation, max);
  final double hue = ((scene.seedHue + hueOffset) % 360 + 360) % 360;
  return rgbToLab(hsvToRgb(hue, saturation, value));
}

/// One marker the user could buy, with what it would add.
final class PurchaseSuggestion {
  const PurchaseSuggestion({
    required this.color,
    required this.improvedScenes,
    required this.totalGain,
    required this.gap,
    required this.topScenes,
  });

  /// The marker.
  final MarkerColor color;

  /// How many scenes get a closer colour for at least one role.
  final int improvedScenes;

  /// The colour distance (ΔE76) the marker takes off all the roles of all the
  /// scenes together.
  final double totalGain;

  /// The distance (ΔE76) to the nearest marker the user has: how far into an
  /// empty region of the colour space this marker sits.
  final double gap;

  /// The scenes it helps most, most first (up to [PurchaseAdvisor.maxTopScenes]).
  final List<Scene> topScenes;
}

/// The knobs of the ranking, for tests and tuning.
abstract final class PurchaseAdvisor {
  /// A scene counts as improved when its roles get at least this much closer
  /// (ΔE76, summed over the roles): about one just-noticeable difference.
  static const double minSceneGain = 3.0;

  /// How many scenes a [PurchaseSuggestion] names.
  static const int maxTopScenes = 3;

  /// The distance used for a role while the user has no marker to compare.
  static const double noMarkerDistance = 100;

  /// Two suggestions closer than this (ΔE76) are the same buy: only the better
  /// ranked one is kept, so ten results are ten different colours.
  static const double minSeparation = 6.0;
}

/// The [limit] markers of [range] that [owned] lacks and that would improve
/// the scenes most.
///
/// * [range] is the whole catalogue of one brand.
/// * [owned] is what the user can use today (dried-out markers left out).
///   Candidates are the markers of [range] that are not in it, so a dried-out
///   marker can come back as a refill.
/// * Each candidate is a single marker: sets are never suggested, so every
///   result can be bought loose.
///
/// The order is: scenes improved (most first), then the total colour distance
/// gained, then how far the marker sits from everything owned (the tie-break
/// that fills the largest empty regions of the colour space), then code. A
/// marker within [PurchaseAdvisor.minSeparation] of a better ranked one is
/// skipped, so near-identical colours are not suggested twice. The numbers of
/// each suggestion are its own, as if it were the only marker bought.
List<PurchaseSuggestion> suggestPurchases({
  required List<MarkerColor> range,
  required List<MarkerColor> owned,
  required List<Scene> scenes,
  int limit = 10,
}) {
  final Set<String> ownedIds = <String>{
    for (final MarkerColor c in owned) c.colorId,
  };
  final List<_Lab> candidates = <_Lab>[];
  for (final MarkerColor c in range) {
    if (ownedIds.contains(c.colorId)) continue;
    final _Lab? lab = _Lab.of(c);
    if (lab != null) candidates.add(lab);
  }
  if (candidates.isEmpty || limit <= 0) return const <PurchaseSuggestion>[];
  final List<_Lab> have = <_Lab>[
    for (final MarkerColor c in owned) ?_Lab.of(c),
  ];

  // Flatten the targets: target t belongs to role roleOf[t] of scene
  // sceneOfRole[role].
  final List<double> tl = <double>[], ta = <double>[], tb = <double>[];
  final List<int> roleOf = <int>[];
  final List<int> sceneOfRole = <int>[];
  for (int s = 0; s < scenes.length; s++) {
    for (final RoleTarget role in sceneRoleTargets(scenes[s])) {
      final int roleIndex = sceneOfRole.length;
      sceneOfRole.add(s);
      for (final LabColor lab in role.colors) {
        tl.add(lab.l);
        ta.add(lab.a);
        tb.add(lab.b);
        roleOf.add(roleIndex);
      }
    }
  }
  final int roles = sceneOfRole.length;

  // The best the user has today, per role.
  final Float64List best = Float64List(roles)
    ..fillRange(0, roles, PurchaseAdvisor.noMarkerDistance);
  final Float64List scratch = Float64List(roles);
  for (final _Lab marker in have) {
    _roleDistances(marker, tl, ta, tb, roleOf, scratch);
    for (int r = 0; r < roles; r++) {
      if (scratch[r] < best[r]) best[r] = scratch[r];
    }
  }

  final List<PurchaseSuggestion> results = <PurchaseSuggestion>[];
  final Map<String, _Lab> labOf = <String, _Lab>{};
  final Float64List sceneGain = Float64List(scenes.length);
  for (final _Lab candidate in candidates) {
    _roleDistances(candidate, tl, ta, tb, roleOf, scratch);
    sceneGain.fillRange(0, sceneGain.length, 0);
    double total = 0;
    for (int r = 0; r < roles; r++) {
      final double gain = best[r] - scratch[r];
      if (gain > 0) {
        sceneGain[sceneOfRole[r]] += gain;
        total += gain;
      }
    }
    final List<int> improved = <int>[
      for (int s = 0; s < scenes.length; s++)
        if (sceneGain[s] >= PurchaseAdvisor.minSceneGain) s,
    ];
    improved.sort((int a, int b) => sceneGain[b].compareTo(sceneGain[a]));
    double gap = PurchaseAdvisor.noMarkerDistance;
    for (final _Lab marker in have) {
      final double d = candidate.distanceTo(marker);
      if (d < gap) gap = d;
    }
    labOf[candidate.color.colorId] = candidate;
    results.add(
      PurchaseSuggestion(
        color: candidate.color,
        improvedScenes: improved.length,
        totalGain: total,
        gap: gap,
        topScenes: <Scene>[
          for (final int s in improved.take(PurchaseAdvisor.maxTopScenes))
            scenes[s],
        ],
      ),
    );
  }

  results.sort((PurchaseSuggestion a, PurchaseSuggestion b) {
    int c = b.improvedScenes.compareTo(a.improvedScenes);
    if (c != 0) return c;
    c = _compareRounded(b.totalGain, a.totalGain);
    if (c != 0) return c;
    c = _compareRounded(b.gap, a.gap);
    if (c != 0) return c;
    return naturalCodeComparator(a.color.newCode, b.color.newCode);
  });
  final List<PurchaseSuggestion> picked = <PurchaseSuggestion>[];
  for (final PurchaseSuggestion s in results) {
    if (picked.length >= limit) break;
    final _Lab lab = labOf[s.color.colorId]!;
    final bool twin = picked.any(
      (PurchaseSuggestion p) =>
          labOf[p.color.colorId]!.distanceTo(lab) <
          PurchaseAdvisor.minSeparation,
    );
    if (!twin) picked.add(s);
  }
  return List<PurchaseSuggestion>.unmodifiable(picked);
}

/// Compares to a tenth of a ΔE (or 1/[scale]); rounding noise never decides.
int _compareRounded(double a, double b, {double scale = 10}) =>
    (a * scale).round().compareTo((b * scale).round());

/// For each role, the distance from [marker] to the nearest of the role's
/// targets, written to [out].
void _roleDistances(
  _Lab marker,
  List<double> tl,
  List<double> ta,
  List<double> tb,
  List<int> roleOf,
  Float64List out,
) {
  out.fillRange(0, out.length, double.infinity);
  for (int t = 0; t < roleOf.length; t++) {
    final double dl = marker.l - tl[t];
    final double da = marker.a - ta[t];
    final double db = marker.b - tb[t];
    final double d = math.sqrt(dl * dl + da * da + db * db);
    final int r = roleOf[t];
    if (d < out[r]) out[r] = d;
  }
}

/// A marker with its Lab colour, computed once.
final class _Lab {
  const _Lab(this.color, this.l, this.a, this.b);

  final MarkerColor color;
  final double l, a, b;

  static _Lab? of(MarkerColor color) {
    try {
      final LabColor lab = hexToLab(color.hex);
      return _Lab(color, lab.l, lab.a, lab.b);
    } on FormatException {
      // A malformed catalogue entry is simply not considered.
      return null;
    }
  }

  double distanceTo(_Lab other) {
    final double dl = l - other.l, da = a - other.a, db = b - other.b;
    return math.sqrt(dl * dl + da * da + db * db);
  }
}

/// The knobs of the near-duplicate check, for tests and tuning.
abstract final class DuplicateRules {
  /// Two markers closer than this OKLab distance (native `[0, 1]` units, so
  /// 0.02 is a 2 % step of lightness) count as the same colour.
  ///
  /// 0.02 is about one just-noticeable difference in OKLab. On the 3,420
  /// colours of the catalogues, 0.02 leaves a marker with fifteen neighbours
  /// on average across all brands, but a collection of a few hundred markers
  /// with only a handful: few enough to be worth listing, close enough that
  /// buying the new one adds nothing to a drawing.
  static const double threshold = 0.02;

  /// How many near-duplicates a screen lists before it summarises the rest.
  static const int maxListed = 5;
}

/// A marker the user owns that is almost the same colour as another one.
final class NearDuplicate {
  const NearDuplicate({required this.color, required this.deltaE});

  /// The owned marker.
  final MarkerColor color;

  /// The OKLab distance to the marker asked about (native `[0, 1]` units).
  final double deltaE;
}

/// The markers of [owned] that are within [threshold] (OKLab distance) of
/// [candidate], closest first; ties by natural code order.
///
/// Meant for a marker the user does NOT own, before they buy it. [candidate]
/// itself is never in the answer, and neither is a marker whose hex cannot
/// be read. The caller leaves out the markers that cannot be used (dried
/// out): a dried marker does not make a new one redundant.
List<NearDuplicate> findNearDuplicates(
  MarkerColor candidate,
  Iterable<MarkerColor> owned, {
  double threshold = DuplicateRules.threshold,
}) {
  final OklabColor origin;
  try {
    origin = hexToOklab(candidate.hex);
  } on FormatException {
    return const <NearDuplicate>[];
  }
  final List<NearDuplicate> found = <NearDuplicate>[];
  for (final MarkerColor other in owned) {
    if (other.colorId == candidate.colorId) continue;
    try {
      final double d = deltaEOklab(origin, hexToOklab(other.hex));
      if (d < threshold) found.add(NearDuplicate(color: other, deltaE: d));
    } on FormatException {
      // A malformed entry is simply not compared.
    }
  }
  found.sort((NearDuplicate a, NearDuplicate b) {
    final int byDistance = _compareRounded(a.deltaE, b.deltaE, scale: 10000);
    return byDistance != 0
        ? byDistance
        : naturalCodeComparator(a.color.newCode, b.color.newCode);
  });
  return List<NearDuplicate>.unmodifiable(found);
}
