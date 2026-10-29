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

/// Ohuhu swatches show the selected packs regardless of ownership.
/// DecoTime swatches require explicitly owned markers.
List<MarkerColor> swatchCandidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  Set<String> activeSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
}) => _candidateColors(
  colors: colors,
  brand: brand,
  activeSetIds: activeSetIds,
  ownedMarkerCodes: ownedMarkerCodes,
  applyOwnedFilter: brand == MarkerBrand.decoTime,
);

/// Palettes apply ownership when specified; DecoTime requires ownership.
List<MarkerColor> paletteCandidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  Set<String> activeSetIds = const {},
  Set<String> ownedMarkerCodes = const {},
}) => _candidateColors(
  colors: colors,
  brand: brand,
  activeSetIds: activeSetIds,
  ownedMarkerCodes: ownedMarkerCodes,
  applyOwnedFilter: true,
);

List<MarkerColor> _candidateColors({
  required List<MarkerColor> colors,
  required MarkerBrand brand,
  required Set<String> activeSetIds,
  required Set<String> ownedMarkerCodes,
  required bool applyOwnedFilter,
}) {
  final owned = scopedCodesForBrand(ownedMarkerCodes, brand.id);
  final effectiveSetIds = activeSetIds.isEmpty
      ? {OahuSet.classic160.id}
      : activeSetIds;
  final available = colors
      .where(
        (color) =>
            color.brandId == brand.id &&
            (brand == MarkerBrand.decoTime ||
                color.sets.any(effectiveSetIds.contains)) &&
            (!applyOwnedFilter ||
                (owned.isEmpty
                    ? brand != MarkerBrand.decoTime
                    : owned.contains(color.newCode.toUpperCase()))),
      )
      .toList();
  // MainActivity orders the active collection before generating palettes.
  return stableSorted(
    available,
    (a, b) => naturalCodeComparator(a.newCode, b.newCode),
  );
}
