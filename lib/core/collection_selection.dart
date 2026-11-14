import 'models.dart';
import 'natural_sort.dart';

/// Legacy unscoped codes belong to Ohuhu. Namespaced codes belong only to
/// their stored brand, including the original unknown-brand fallback.
Set<String> scopedCodesForBrand(Set<String> rawValues, String brandId) {
  final brand = MarkerBrand.fromId(brandId);
  final result = <String>{};
  for (final raw in rawValues) {
    final value = raw.trim();
    if (value.isEmpty) continue;
    final separator = value.indexOf(':');
    if (separator <= 0 || separator == value.length - 1) {
      if (brand == MarkerBrand.ohuhuOahu) result.add(value.toUpperCase());
    } else if (MarkerBrand.fromId(value.substring(0, separator)) == brand) {
      final code = value.substring(separator + 1).trim().toUpperCase();
      if (code.isNotEmpty) result.add(code);
    }
  }
  return result;
}

/// Whether [color] is one of the user's markers: it belongs to an owned set
/// (Ohuhu) or it was added by hand as an extra marker. This is the single
/// rule behind "Mine", Match, Palette, Ideas and every count.
bool isOwnedColor(
  MarkerColor color, {
  required Set<String> ownedSetIds,
  required Set<String> extraCodes,
}) =>
    ((MarkerBrand.byId[color.brandId]?.hasRetailSets ?? false) &&
        color.sets.any(ownedSetIds.contains)) ||
    extraCodes.contains(color.newCode.toUpperCase());

/// The markers of [brand] the user owns, in natural code order.
///
/// [ownedSetIds] only applies to brands with retail set membership;
/// [ownedMarkerCodes] are the extra markers, brand-scoped.
/// [driedColorIds] (`brandId:CODE`) are owned markers that ran dry: they stay
/// in the collection but are left out of the result, so Match, Palette and
/// Ideas never suggest them. Screens that list the collection itself (Swatches
/// "Mine", the counts) leave it empty.
List<MarkerColor> ownedColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  Set<String> ownedSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
  Set<String> driedColorIds = const {},
}) {
  final extras = scopedCodesForBrand(ownedMarkerCodes, brand.id);
  final sets = brand.hasRetailSets ? ownedSetIds : const <String>{};
  return _sorted(
    colors.where(
      (color) =>
          color.brandId == brand.id &&
          !driedColorIds.contains(color.colorId) &&
          isOwnedColor(color, ownedSetIds: sets, extraCodes: extras),
    ),
  );
}

/// The whole range of [brand] (owned or not), in natural code order.
List<MarkerColor> brandRangeColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
}) => _sorted(colors.where((color) => color.brandId == brand.id));

/// Swatches "All": the whole range of the brand, browsable before the user
/// owns anything. "Mine" narrows it with [ownedColors].
List<MarkerColor> swatchCandidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
}) => brandRangeColors(colors: colors, brand: brand);

/// The colours the palette engines may use: the user's own markers.
///
/// Only the markers the user owns are offered, and never the dried-out ones
/// (see [ownedColors]). A collection that owns nothing of the brand offers
/// nothing: there is no fallback to the whole range, so no screen can pretend
/// that a marker the user does not have is theirs.
///
/// The whole range is still one click away, but only where the user asks for
/// it explicitly and the control says so (see [brandRangeColors]).
List<MarkerColor> paletteCandidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  BrandScope scope = BrandScope.singleBrand,
  Set<String> activeSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
  Set<String> driedColorIds = const {},
}) => mixedCandidateColors(
  colors: colors,
  brand: brand,
  scope: scope,
  activeSetIds: activeSetIds,
  ownedMarkerCodes: ownedMarkerCodes,
  driedColorIds: driedColorIds,
);

/// Cache entry for the candidate selection. Keyed on the *contents* of [colors]
/// compared by element identity (same length and `identical` elements), plus
/// the brand, scope and the *contents* of the three sets.
///
/// A snapshot of [colors] is taken at store time so that a caller mutating its
/// input list in place (e.g. `collection_snapshot.dart`) cannot make a later
/// lookup return a stale result, while two distinct lists with the same elements
/// still share a cache entry. A lookup scans the list once (O(n), no
/// allocation): microseconds for the whole catalogue, after the cheap brand
/// and scope checks.
class _CandidateCacheEntry {
  _CandidateCacheEntry({
    required List<MarkerColor> colors,
    required this.brand,
    required this.scope,
    required this.activeSetIds,
    required this.ownedMarkerCodes,
    required this.driedColorIds,
    required this.result,
  }) : colorsSnapshot = List<MarkerColor>.unmodifiable(colors);

  final List<MarkerColor> colorsSnapshot;
  final MarkerBrand brand;
  final BrandScope scope;
  final Set<String> activeSetIds;
  final Set<String> ownedMarkerCodes;
  final Set<String> driedColorIds;
  final List<MarkerColor> result;

  /// Same markers in the same order. The snapshot was taken at store time, so
  /// a list mutated in place since then no longer matches.
  bool _colorsMatch(List<MarkerColor> otherColors) {
    if (colorsSnapshot.length != otherColors.length) return false;
    for (var i = 0; i < colorsSnapshot.length; i++) {
      if (!identical(colorsSnapshot[i], otherColors[i])) return false;
    }
    return true;
  }

  bool matches(
    List<MarkerColor> otherColors,
    MarkerBrand otherBrand,
    BrandScope otherScope,
    Set<String> otherActive,
    Set<String> otherOwned,
    Set<String> otherDried,
  ) =>
      brand == otherBrand &&
      scope == otherScope &&
      _sameSet(activeSetIds, otherActive) &&
      _sameSet(ownedMarkerCodes, otherOwned) &&
      _sameSet(driedColorIds, otherDried) &&
      _colorsMatch(otherColors);
}

bool _sameSet(Set<String> a, Set<String> b) =>
    a.length == b.length && a.containsAll(b);

const int _candidateCacheCapacity = 4;
final List<_CandidateCacheEntry> _mixedCandidateCache = [];
final List<_CandidateCacheEntry> _ownedCandidateCache = [];

List<MarkerColor>? _lookupCandidateCache(
  List<_CandidateCacheEntry> cache,
  List<MarkerColor> colors,
  MarkerBrand brand,
  BrandScope scope,
  Set<String> activeSetIds,
  Set<String> ownedMarkerCodes,
  Set<String> driedColorIds,
) {
  for (var i = cache.length - 1; i >= 0; i--) {
    final e = cache[i];
    if (e.matches(
      colors,
      brand,
      scope,
      activeSetIds,
      ownedMarkerCodes,
      driedColorIds,
    )) {
      // LRU: move to the end.
      cache.removeAt(i);
      cache.add(e);
      return e.result;
    }
  }
  return null;
}

void _storeCandidateCache(
  List<_CandidateCacheEntry> cache,
  List<MarkerColor> colors,
  MarkerBrand brand,
  BrandScope scope,
  Set<String> activeSetIds,
  Set<String> ownedMarkerCodes,
  Set<String> driedColorIds,
  List<MarkerColor> result,
) {
  cache.add(
    _CandidateCacheEntry(
      colors: colors,
      brand: brand,
      scope: scope,
      activeSetIds: Set<String>.unmodifiable(activeSetIds),
      ownedMarkerCodes: Set<String>.unmodifiable(ownedMarkerCodes),
      driedColorIds: Set<String>.unmodifiable(driedColorIds),
      result: result,
    ),
  );
  if (cache.length > _candidateCacheCapacity) {
    cache.removeAt(0);
  }
}

/// The one selection rule behind every palette producer (Palette, the AI
/// advisors, Ideas, the Colour map and the home widget).
///
/// With [BrandScope.mixedBrands] ("Mix my brands") it is the union of the
/// usable markers of every brand the user owns, brand by brand in
/// [MarkerBrand.values] order, so two markers that share a code stay apart
/// (`ohuhu_oahu:120`, `decotime:120`). [colors] must then hold the catalogue
/// of every owned brand (`MarkerRepository.loadCollectionCatalog`).
///
/// With [BrandScope.singleBrand] it is the usable markers of [brand] alone.
/// A mixed preference left on while fewer than two brands have a usable
/// marker behaves as single: there is nothing to mix.
List<MarkerColor> mixedCandidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  BrandScope scope = BrandScope.mixedBrands,
  Set<String> activeSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
  Set<String> driedColorIds = const {},
}) {
  final cached = _lookupCandidateCache(
    _mixedCandidateCache,
    colors,
    brand,
    scope,
    activeSetIds,
    ownedMarkerCodes,
    driedColorIds,
  );
  if (cached != null) return cached;

  List<MarkerColor> of(MarkerBrand b) => ownedColors(
    colors: colors,
    brand: b,
    ownedSetIds: activeSetIds,
    ownedMarkerCodes: ownedMarkerCodes,
    driedColorIds: driedColorIds,
  );
  List<MarkerColor> computed;
  if (scope == BrandScope.mixedBrands) {
    final all = <MarkerColor>[for (final b in MarkerBrand.values) ...of(b)];
    if (hasMixedBrands(all)) {
      computed = List<MarkerColor>.unmodifiable(all);
    } else {
      computed = List<MarkerColor>.unmodifiable(of(brand));
    }
  } else {
    computed = List<MarkerColor>.unmodifiable(of(brand));
  }
  _storeCandidateCache(
    _mixedCandidateCache,
    colors,
    brand,
    scope,
    activeSetIds,
    ownedMarkerCodes,
    driedColorIds,
    computed,
  );
  return computed;
}

/// The markers of the collection the palette producers work with, the
/// dried-out ones included: what tells a collection whose markers all ran dry
/// from one that owns nothing.
///
/// It follows [mixedCandidateColors]: with [BrandScope.singleBrand], or with
/// "Mix my brands" left on while only one brand has a usable marker, it is
/// the markers of [brand]. With "Mix my brands" and two or more usable
/// brands, or none at all (every marker of every brand ran dry), it is the
/// markers of every brand the user owns.
List<MarkerColor> ownedCandidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  BrandScope scope = BrandScope.singleBrand,
  Set<String> activeSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
  Set<String> driedColorIds = const {},
}) {
  final cached = _lookupCandidateCache(
    _ownedCandidateCache,
    colors,
    brand,
    scope,
    activeSetIds,
    ownedMarkerCodes,
    driedColorIds,
  );
  if (cached != null) return cached;

  List<MarkerColor> of(MarkerBrand b) => ownedColors(
    colors: colors,
    brand: b,
    ownedSetIds: activeSetIds,
    ownedMarkerCodes: ownedMarkerCodes,
  );
  List<MarkerColor> computed;
  if (scope == BrandScope.mixedBrands &&
      usableOwnedBrands(
            colors: colors,
            activeSetIds: activeSetIds,
            ownedMarkerCodes: ownedMarkerCodes,
            driedColorIds: driedColorIds,
          ).length !=
          1) {
    computed = List<MarkerColor>.unmodifiable(<MarkerColor>[
      for (final b in MarkerBrand.values) ...of(b),
    ]);
  } else {
    computed = List<MarkerColor>.unmodifiable(of(brand));
  }
  _storeCandidateCache(
    _ownedCandidateCache,
    colors,
    brand,
    scope,
    activeSetIds,
    ownedMarkerCodes,
    driedColorIds,
    computed,
  );
  return computed;
}

/// The brands the user owns a usable (not dried) marker of, in
/// [MarkerBrand.values] order. Two or more make "Mix my brands" available.
List<MarkerBrand> usableOwnedBrands({
  required List<MarkerColor> colors,
  Set<String> activeSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
  Set<String> driedColorIds = const {},
}) => <MarkerBrand>[
  for (final b in MarkerBrand.values)
    if (ownedColors(
      colors: colors,
      brand: b,
      ownedSetIds: activeSetIds,
      ownedMarkerCodes: ownedMarkerCodes,
      driedColorIds: driedColorIds,
    ).isNotEmpty)
      b,
];

/// Whether [colors] hold markers of more than one brand.
bool hasMixedBrands(Iterable<MarkerColor> colors) {
  String? first;
  for (final c in colors) {
    first ??= c.brandId;
    if (c.brandId != first) return true;
  }
  return false;
}

/// The code of [color] as a list shows it: alone in a single-brand list, with
/// its brand in front (`Ohuhu BV04`, `DecoTime 91`) when the list is [mixed].
String markerCodeLabel(MarkerColor color, {required bool mixed}) => mixed
    ? '${MarkerBrand.fromId(color.brandId).label} ${color.newCode}'
    : color.newCode;

List<MarkerColor> _sorted(Iterable<MarkerColor> colors) {
  // MainActivity orders the active collection before generating palettes.
  final list = colors.toList();
  if (list.length < 2) return list;
  // Precompute upper-cased keys once instead of re-tokenising on every
  // comparison.
  final keys = <String>[for (final c in list) c.newCode.toUpperCase()];
  final order = List<int>.generate(list.length, (i) => i);
  order.sort((ia, ib) {
    final r = naturalCodeCompareUpper(keys[ia], keys[ib]);
    return r == 0 ? ia.compareTo(ib) : r;
  });
  return <MarkerColor>[for (final i in order) list[i]];
}
