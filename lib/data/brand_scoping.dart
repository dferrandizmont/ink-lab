import '../core/models.dart';

/// Canonical, brand-scoped colour id for a stored favourites/owned entry.
///
/// Mirrors the legacy rule in `core/collection_selection.dart`
/// ([scopedCodesForBrand]): a bare code belongs to Ohuhu, `brandId:code` belongs
/// to that brand (an unknown brand prefix falls back to Ohuhu), and the code is
/// trimmed and upper-cased. Malformed entries (no code, an empty code, or an
/// embedded separator) are dropped so they can never be persisted as garbage.
///
/// Returns `null` when the value cannot be scoped.
String? scopedColorId(String raw) {
  final value = raw.trim();
  if (value.isEmpty) return null;
  final separator = value.indexOf(':');
  if (separator < 0) {
    return '${MarkerBrand.ohuhuOahu.id}:${value.toUpperCase()}';
  }
  if (separator == 0 || separator == value.length - 1) return null;
  final code = value.substring(separator + 1).trim().toUpperCase();
  if (code.isEmpty || code.contains(':')) return null;
  final brand = MarkerBrand.fromId(value.substring(0, separator));
  return '${brand.id}:$code';
}

/// Scopes and de-duplicates a raw list of stored codes, preserving nothing that
/// [scopedColorId] rejects.
Set<String> scopedColorIds(Iterable<String> rawValues) {
  final result = <String>{};
  for (final raw in rawValues) {
    final id = scopedColorId(raw);
    if (id != null) result.add(id);
  }
  return result;
}

/// Trims stored owned-marker codes and drops empties, without re-scoping.
///
/// Owned markers keep the user's (and the Kotlin store's) raw form so the core
/// rule in `scopedCodesForBrand` stays the single place that interprets them.
Set<String> cleanCodes(Iterable<String> rawValues) => {
  for (final raw in rawValues)
    if (raw.trim().isNotEmpty) raw.trim(),
};

/// `true` when [colorId] belongs to [brand].
bool colorIdBelongsToBrand(String colorId, MarkerBrand brand) {
  final scoped = scopedColorId(colorId);
  return scoped != null && scoped.startsWith('${brand.id}:');
}
