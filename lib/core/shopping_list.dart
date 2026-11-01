import 'models.dart';
import 'natural_sort.dart';

/// A plain-text shopping list of [markers]: one line per marker with the
/// brand, the code and the name, brands in catalogue order and codes in
/// natural order.
///
/// The code and name follow [mode] (new, old or both), the way the app shows
/// them. Nothing here touches the network or the clipboard: the caller decides
/// what to do with the text.
String shoppingListText(
  Iterable<MarkerColor> markers, {
  NameDisplayMode mode = NameDisplayMode.both,
}) {
  final List<MarkerColor> sorted = markers.toList()
    ..sort((MarkerColor a, MarkerColor b) {
      final int brand = _brandOrder(a.brandId)
          .compareTo(_brandOrder(b.brandId));
      return brand != 0 ? brand : naturalCodeComparator(a.newCode, b.newCode);
    });
  return <String>[
    for (final MarkerColor c in sorted)
      '${MarkerBrand.fromId(c.brandId).label} - ${c.displayCode(mode)} - '
          '${c.displayName(mode)}',
  ].join('\n');
}

int _brandOrder(String brandId) =>
    MarkerBrand.values.indexOf(MarkerBrand.fromId(brandId));
