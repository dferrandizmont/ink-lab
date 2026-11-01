import 'color_utils.dart';
import 'model/marker_color.dart';

/// Where the catalogue gets the user's own marker colours from.
///
/// The catalogue hex of a marker is only an estimate of the ink on paper, so
/// the user can store the colour they actually see. The implementation lives
/// in the data layer; the core only needs to read it.
abstract interface class OwnColorSource {
  /// The own colours in force right now: `brandId:CODE` to `rrggbb`.
  ///
  /// Empty when the user turned the feature off.
  Map<String, String> get activeOwnColors;

  /// Changes whenever [activeOwnColors] changes, so results can be cached per
  /// revision.
  int get revision;
}

/// Normalises a user-typed or sampled colour to six lower-case hex digits
/// without `#`. Returns `null` when [raw] is not a colour (3 or 6 digits, with
/// or without `#`).
String? normalizeOwnHex(String raw) {
  final String value = raw.trim();
  if (!RegExp(r'^#?(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{6})$').hasMatch(value)) {
    return null;
  }
  return colorIntToHex(hexToColorInt(value)).toLowerCase();
}

/// [colors] with the user's [own] colours in place of the catalogue's.
///
/// The one place where own colours reach matching and generation: a marker
/// with an entry in [own] (keyed by [MarkerColor.colorId]) comes back with
/// that hex and remembers the catalogue's in [MarkerColor.catalogHex]. Entries
/// that equal the catalogue, or are not a colour, change nothing. Returns
/// [colors] itself when nothing applies.
List<MarkerColor> applyOwnColors(
  List<MarkerColor> colors,
  Map<String, String> own,
) {
  if (own.isEmpty) return colors;
  var changed = false;
  final List<MarkerColor> result = <MarkerColor>[];
  for (final MarkerColor color in colors) {
    final String? hex = own[color.colorId];
    final String? normalized = hex == null ? null : normalizeOwnHex(hex);
    final String? catalogue = normalizeOwnHex(color.hex);
    if (normalized == null || normalized == catalogue) {
      result.add(color);
      continue;
    }
    changed = true;
    result.add(color.withOwnHex(normalized));
  }
  return changed ? List.unmodifiable(result) : colors;
}
