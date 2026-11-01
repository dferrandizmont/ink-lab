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

/// The colours the palette engines may use: the user's markers.
///
/// A collection that is not set up yet (no owned set, no extra marker) uses
/// the whole range of the brand so palettes and ideas still work; this holds
/// for every brand.
///
/// [driedColorIds] are never offered (see [ownedColors]). A collection whose
/// markers are all dried is still a configured collection: the result is then
/// empty rather than the whole range.
List<MarkerColor> paletteCandidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  Set<String> activeSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
  Set<String> driedColorIds = const {},
}) {
  final owned = ownedColors(
    colors: colors,
    brand: brand,
    ownedSetIds: activeSetIds,
    ownedMarkerCodes: ownedMarkerCodes,
  );
  List<MarkerColor> usable(List<MarkerColor> list) => driedColorIds.isEmpty
      ? list
      : list.where((color) => !driedColorIds.contains(color.colorId)).toList();
  if (owned.isNotEmpty) return usable(owned);
  // Leftover retail set ids do not configure individually collected brands.
  final configured =
      (brand.hasRetailSets && activeSetIds.isNotEmpty) ||
      scopedCodesForBrand(ownedMarkerCodes, brand.id).isNotEmpty;
  return configured
      ? owned
      : usable(brandRangeColors(colors: colors, brand: brand));
}

List<MarkerColor> _sorted(Iterable<MarkerColor> colors) =>
    // MainActivity orders the active collection before generating palettes.
    stableSorted(
      colors.toList(),
      (a, b) => naturalCodeComparator(a.newCode, b.newCode),
    );
