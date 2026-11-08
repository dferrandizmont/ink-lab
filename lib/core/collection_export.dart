import 'model/marker_brand.dart';
import 'model/marker_color.dart';
import 'natural_sort.dart';
import 'recipe_codes.dart';

// Taking the collection out of the app as text, and bringing codes in.
//
// The CSV is for a spreadsheet, the plain list for a message or a note. The
// import reads the same tolerant code lists the recipe translator does and
// only ever describes what it would do: the screen applies it after the user
// confirms.

/// The header of the CSV, in the order of the columns.
const String collectionCsvHeader = 'brand,code,name,hex,ink';

/// The markers [owned], one row each, as CSV (comma separated, `\n` line
/// ends, text in quotes only when it needs them).
///
/// The columns are the brand, the code, the name, the colour as `#RRGGBB` and
/// the state of the ink: `ok`, or `dried` for a marker that ran out
/// ([driedIds] holds the `brandId:CODE` ids of those).
String collectionCsv(
  Iterable<MarkerColor> owned, {
  Set<String> driedIds = const <String>{},
}) {
  final StringBuffer out = StringBuffer(collectionCsvHeader)..write('\n');
  for (final MarkerColor marker in _inOrder(owned)) {
    out
      ..writeAll(<String>[
        _csvField(MarkerBrand.fromId(marker.brandId).label),
        _csvField(marker.newCode),
        _csvField(marker.newName),
        _csvField(_hex(marker.hex)),
        driedIds.contains(marker.colorId) ? 'dried' : 'ok',
      ], ',')
      ..write('\n');
  }
  return out.toString();
}

/// The markers [owned] as a short list grouped by brand, one line per brand:
/// `Copic (3): B00, B01, E00`. Brands in the app's order, codes in natural
/// order.
String collectionTextList(Iterable<MarkerColor> owned) {
  final Map<String, List<MarkerColor>> byBrand = <String, List<MarkerColor>>{};
  for (final MarkerColor marker in _inOrder(owned)) {
    byBrand.putIfAbsent(marker.brandId, () => <MarkerColor>[]).add(marker);
  }
  return <String>[
    for (final MapEntry<String, List<MarkerColor>> entry in byBrand.entries)
      '${MarkerBrand.fromId(entry.key).label} (${entry.value.length}): '
          '${entry.value.map((MarkerColor m) => m.newCode).join(', ')}',
  ].join('\n');
}

/// What importing a list of codes for one brand would do.
final class CodeImportPreview {
  const CodeImportPreview({
    required this.toAdd,
    required this.alreadyOwned,
    required this.unknown,
  });

  /// Markers the list names that the user does not own yet.
  final List<MarkerColor> toAdd;

  /// Markers the list names that are already in the collection.
  final List<MarkerColor> alreadyOwned;

  /// Words of the list that look like codes but are not in the brand.
  final List<String> unknown;

  /// Whether the list named nothing at all.
  bool get isEmpty => toAdd.isEmpty && alreadyOwned.isEmpty && unknown.isEmpty;
}

/// Reads [text] as codes of the brand whose whole range is [range] and sorts
/// them into new, already owned and unknown. [ownedIds] are the
/// `brandId:CODE` ids the user owns.
CodeImportPreview previewCodeImport({
  required String text,
  required List<MarkerColor> range,
  required Set<String> ownedIds,
}) {
  final CodeIndex index = CodeIndex(range);
  final List<MarkerColor> toAdd = <MarkerColor>[];
  final List<MarkerColor> already = <MarkerColor>[];
  final List<String> unknown = <String>[];
  final Set<String> seen = <String>{};
  for (final String code in parseCodeList(text, knows: index.knows)) {
    final MarkerColor? marker = index.find(code);
    if (marker == null) {
      unknown.add(code);
    } else if (seen.add(marker.colorId)) {
      (ownedIds.contains(marker.colorId) ? already : toAdd).add(marker);
    }
  }
  return CodeImportPreview(
    toAdd: toAdd,
    alreadyOwned: already,
    unknown: unknown,
  );
}

List<MarkerColor> _inOrder(Iterable<MarkerColor> markers) {
  int brandRank(String id) {
    final MarkerBrand brand = MarkerBrand.fromId(id);
    return MarkerBrand.values.indexOf(brand);
  }

  return markers.toList()..sort((MarkerColor a, MarkerColor b) {
    final int byBrand = brandRank(a.brandId).compareTo(brandRank(b.brandId));
    return byBrand != 0 ? byBrand : naturalCodeComparator(a.newCode, b.newCode);
  });
}

String _hex(String hex) =>
    '#${(hex.startsWith('#') ? hex.substring(1) : hex).toUpperCase()}';

String _csvField(String value) => value.contains(RegExp(r'[",\n\r]'))
    ? '"${value.replaceAll('"', '""')}"'
    : value;
