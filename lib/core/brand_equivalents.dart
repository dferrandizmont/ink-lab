import 'color_utils.dart';
import 'match_quality.dart';
import 'models.dart';
import 'own_colors.dart';

// "What is the same colour in another brand?": for a marker of one brand,
// the closest markers of every OTHER brand.
//
// The distance is ΔE76 (CIELAB), the metric the app already uses everywhere
// (Match, the purchase advisor, the blending chains), so the numbers can be
// compared with the rest of the app and read with [MatchQuality]. The user's
// own colours replace the catalogue's, the same way the rest of the app does
// it (see `own_colors.dart`).
//
// The catalogue's colours are turned into Lab once, when the finder is
// built, so asking for the equivalents of a marker over a thousand colours
// costs one distance per colour and nothing else. Build the finder again when
// the catalogue or the user's own colours change: it holds a copy of them.

// One marker of another brand, with how close it is to the marker asked
// about.
final class BrandEquivalent {
  const BrandEquivalent({required this.color, required this.deltaE});

  /// The marker of the other brand.
  final MarkerColor color;

  /// The distance between the two colours (ΔE76).
  final double deltaE;

  /// How close it is, in the app's own words.
  MatchQuality get quality => MatchQuality.of(deltaE);
}

// The closest markers of one other brand.
final class BrandEquivalentGroup {
  const BrandEquivalentGroup({required this.brandId, required this.matches});

  /// The brand the markers belong to.
  final String brandId;

  /// The brand, for a label.
  MarkerBrand get brand => MarkerBrand.fromId(brandId);

  /// The closest markers, closest first.
  final List<BrandEquivalent> matches;

  /// The closest one, or `null` when the group is empty.
  BrandEquivalent? get closest => matches.isEmpty ? null : matches.first;
}

/// The closest markers of the other brands, for a marker of one brand.
///
/// [catalogue] holds the markers of every brand. [ownColors] are the user's
/// own colours (brand-scoped id to hex); they replace the catalogue's, the
/// same way the rest of the app does it.
///
/// The finder takes a copy of both: it answers with the colours it was built
/// with, and never with a later change of the map the caller kept. Build it
/// again when the catalogue or the effective own colours change.
final class BrandEquivalentFinder {
  factory BrandEquivalentFinder(
    Iterable<MarkerColor> catalogue, {
    Map<String, String> ownColors = const {},
  }) {
    // A copy, so a change of the caller's map cannot mix colours of two
    // revisions in the same answer.
    final Map<String, String> own = Map<String, String>.unmodifiable(
      ownColors,
    );
    final Map<String, List<_Entry>> byBrand = <String, List<_Entry>>{};
    int index = 0;
    for (final MarkerColor color
        in applyOwnColors(catalogue.toList(), own)) {
      final LabColor? lab = _labOf(color);
      if (lab != null) {
        byBrand.putIfAbsent(color.brandId, () => <_Entry>[]).add(
          _Entry(color, lab, index),
        );
      }
      index++;
    }
    return BrandEquivalentFinder._(byBrand, own);
  }

  const BrandEquivalentFinder._(this._byBrand, this._ownColors);

  final Map<String, List<_Entry>> _byBrand;
  final Map<String, String> _ownColors;

  /// The brands the catalogue holds, in the app's own order.
  List<String> get brands => _brandOrder(_byBrand.keys);

  /// The closest markers of every OTHER brand to [marker].
  ///
  /// The brand of [marker] itself is never offered. [limit] is how many
  /// markers each brand gets, closest first.
  ///
  /// [ownedIds] restricts the search to the markers the user owns (their
  /// brand-scoped ids); without it every marker of the catalogue competes.
  /// [skipDried] leaves out the markers in [driedIds] (the ones that ran
  /// dry), which stay in the collection but are not offered.
  ///
  /// The groups come in the app's brand order.
  List<BrandEquivalentGroup> closestTo(
    MarkerColor marker, {
    int limit = 3,
    Set<String>? ownedIds,
    bool skipDried = false,
    Set<String> driedIds = const {},
  }) {
    if (limit <= 0) return const <BrandEquivalentGroup>[];
    final MarkerColor source = applyOwnColors(
      <MarkerColor>[marker],
      _ownColors,
    ).single;
    final LabColor? sourceLab = _labOf(source);
    if (sourceLab == null) return const <BrandEquivalentGroup>[];
    final List<BrandEquivalentGroup> groups = <BrandEquivalentGroup>[];
    for (final String brandId in brands) {
      if (brandId == source.brandId) continue;
      final List<_Scored> scored = <_Scored>[];
      for (final _Entry candidate in _byBrand[brandId] ?? const <_Entry>[]) {
        if (ownedIds != null && !ownedIds.contains(candidate.color.colorId)) {
          continue;
        }
        if (skipDried && driedIds.contains(candidate.color.colorId)) continue;
        scored.add(_Scored(candidate, deltaE76(sourceLab, candidate.lab)));
      }
      if (scored.isEmpty) continue;
      scored.sort((_Scored a, _Scored b) {
        final int byDistance = a.deltaE.compareTo(b.deltaE);
        return byDistance != 0
            ? byDistance
            : a.entry.index.compareTo(b.entry.index);
      });
      groups.add(
        BrandEquivalentGroup(
          brandId: brandId,
          matches: <BrandEquivalent>[
            for (final _Scored s in scored.take(limit))
              BrandEquivalent(color: s.entry.color, deltaE: s.deltaE),
          ],
        ),
      );
    }
    return groups;
  }
}

/// The brand ids in the app's order, unknown brands last (alphabetically).
List<String> _brandOrder(Iterable<String> brandIds) {
  final Set<String> ids = brandIds.toSet();
  final List<String> ordered = <String>[
    for (final MarkerBrand brand in MarkerBrand.values)
      if (ids.remove(brand.id)) brand.id,
  ];
  ordered.addAll(ids.toList()..sort());
  return ordered;
}

/// A marker of the catalogue with its Lab colour, computed once.
final class _Entry {
  const _Entry(this.color, this.lab, this.index);

  final MarkerColor color;
  final LabColor lab;

  /// Its place in the catalogue, to break ties the same way every time.
  final int index;
}

/// A candidate with the distance to the marker asked about.
final class _Scored {
  const _Scored(this.entry, this.deltaE);

  final _Entry entry;
  final double deltaE;
}

/// The Lab colour of [color], or `null` when its hex is not a colour.
LabColor? _labOf(MarkerColor color) {
  try {
    return hexToLab(color.hex);
  } on FormatException {
    // A malformed catalogue entry is simply not considered.
    return null;
  }
}
