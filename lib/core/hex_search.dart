import 'color_utils.dart';
import 'collection_utils.dart';
import 'model/marker_color.dart';

// Searching the swatches "by code, name or hex": a search text that is a
// colour (`#2D6E9C`, `2d6e9c`, `#2d6`, `2d6`) shows the markers closest to it
// first. The distance is the Euclidean distance in OKLab, which follows what
// the eye sees better than a raw RGB difference.

/// How many of the closest markers a hex search shows first.
const int hexSearchLimit = 12;

final RegExp _hexQuery = RegExp(r'^(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

/// The colour (opaque sRGB) a search [query] asks for, or `null` when the
/// query is not a hex colour.
///
/// A hex colour is exactly 3 or 6 hex digits after an optional `#`. Without
/// the `#`, a text that is a code stays a code: when it is the exact code of
/// one of [markers] (the new or the old code, in any case), when a code starts
/// with it (the 3 digits of `B01` on the way to `B010`), or when it is exactly
/// a name, it is a search by code or name, and `B08`, `E17` or `BG1` keep
/// finding their marker. With the `#` the text is always a colour, since no
/// code starts with it.
int? hexSearchColor(String query, Iterable<MarkerColor> markers) {
  final String text = query.trim();
  final bool hashed = text.startsWith('#');
  final String digits = hashed ? text.substring(1) : text;
  if (!_hexQuery.hasMatch(digits)) return null;
  if (!hashed) {
    final String needle = digits.toLowerCase();
    for (final MarkerColor marker in markers) {
      if (marker.newCode.toLowerCase().startsWith(needle) ||
          marker.oldCode.toLowerCase().startsWith(needle) ||
          marker.newName.toLowerCase() == needle ||
          marker.oldName.toLowerCase() == needle) {
        return null;
      }
    }
  }
  return hexToColorInt(digits);
}

/// The [limit] markers of [markers] closest to [colorInt], the closest first,
/// by OKLab distance. Markers whose colour is malformed are left out; markers
/// at the same distance keep their order.
List<MarkerColor> nearestMarkers(
  int colorInt,
  Iterable<MarkerColor> markers, {
  int limit = hexSearchLimit,
}) {
  final OklabColor target = rgbToOklab(colorIntToRgb(colorInt));
  final List<(MarkerColor, double)> measured = <(MarkerColor, double)>[];
  for (final MarkerColor marker in markers) {
    try {
      measured.add((marker, deltaEOklab(target, hexToOklab(marker.hex))));
    } on FormatException {
      // A malformed colour in the data is not a candidate.
    }
  }
  return stableSortedBy(
    measured,
    ((MarkerColor, double) pair) => pair.$2,
  ).take(limit).map(((MarkerColor, double) pair) => pair.$1).toList();
}
