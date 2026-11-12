import 'models.dart';
import 'collection_utils.dart';
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
  List<MarkerColor> of(MarkerBrand b) => ownedColors(
    colors: colors,
    brand: b,
    ownedSetIds: activeSetIds,
    ownedMarkerCodes: ownedMarkerCodes,
    driedColorIds: driedColorIds,
  );
  if (scope == BrandScope.mixedBrands) {
    final all = <MarkerColor>[for (final b in MarkerBrand.values) ...of(b)];
    if (hasMixedBrands(all)) return all;
  }
  return of(brand);
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
  List<MarkerColor> of(MarkerBrand b) => ownedColors(
    colors: colors,
    brand: b,
    ownedSetIds: activeSetIds,
    ownedMarkerCodes: ownedMarkerCodes,
  );
  if (scope == BrandScope.mixedBrands &&
      usableOwnedBrands(
            colors: colors,
            activeSetIds: activeSetIds,
            ownedMarkerCodes: ownedMarkerCodes,
            driedColorIds: driedColorIds,
          ).length !=
          1) {
    return <MarkerColor>[for (final b in MarkerBrand.values) ...of(b)];
  }
  return of(brand);
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

List<MarkerColor> _sorted(Iterable<MarkerColor> colors) =>
    // MainActivity orders the active collection before generating palettes.
    stableSorted(
      colors.toList(),
      (a, b) => naturalCodeComparator(a.newCode, b.newCode),
    );
