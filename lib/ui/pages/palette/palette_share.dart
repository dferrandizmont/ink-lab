import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../core/palette_card_layout.dart';
import '../../../core/palette_text.dart';

/// One colour of a palette about to be shared: the marker and the role to
/// print next to it (already localised), when it has one.
typedef SharedPaletteColor = ({MarkerColor color, String? role});

/// The brand a shared palette names: the brand of its markers, or every
/// brand of a palette that mixes them ("Ohuhu + DecoTime"), in the order
/// they first appear. [fallback] when there is no marker to tell.
String paletteBrandsLabel(
  List<SharedPaletteColor> colors, {
  required MarkerBrand fallback,
}) {
  final Set<String> labels = <String>{
    for (final SharedPaletteColor item in colors)
      MarkerBrand.fromId(item.color.brandId).label,
  };
  return labels.isEmpty ? fallback.label : labels.join(' + ');
}

/// The data of the image for a palette made of [colors], in strip order.
///
/// The card names the brand of its markers ([brand] only when there is none).
/// When the palette mixes brands it names them all and every code carries
/// its brand ("DecoTime 91"), so two markers that share a code stay apart.
PaletteCardData paletteCardData({
  required String title,
  required MarkerBrand brand,
  required List<SharedPaletteColor> colors,
}) {
  final bool mixed = hasMixedBrands(colors.map((c) => c.color));
  return PaletteCardData(
    title: title,
    brand: paletteBrandsLabel(colors, fallback: brand),
    entries: <PaletteCardEntry>[
      for (final SharedPaletteColor item in colors)
        PaletteCardEntry(
          role: item.role,
          code: markerCodeLabel(item.color, mixed: mixed),
          name: item.color.newName,
          hex: item.color.hex,
        ),
    ],
  );
}

/// The message that shares [colors] (in strip order) as text: [header], one
/// line per marker with its code, name and role, and the compact line the app
/// reads back (see [PaletteText]).
///
/// A palette of one brand writes the version 1 line of that brand (the brand
/// of its markers, which with "Mix my brands" need not be the active
/// [brand]). A palette that mixes brands writes the version 2 line, and its
/// readable lines carry the brand of every code.
String paletteShareText({
  required String header,
  required MarkerBrand brand,
  required List<SharedPaletteColor> colors,
}) {
  final bool mixed = hasMixedBrands(colors.map((c) => c.color));
  return PaletteText.format(
    header: header,
    brandId: colors.isEmpty ? brand.id : colors.first.color.brandId,
    colorIds: mixed
        ? <String>[for (final SharedPaletteColor c in colors) c.color.colorId]
        : null,
    compactCodes: <String>[
      for (final SharedPaletteColor c in colors) c.color.newCode,
    ],
    lines: <PaletteTextLine>[
      for (final SharedPaletteColor item in colors)
        (
          code: markerCodeLabel(item.color, mixed: mixed),
          name: item.color.newName,
          role: item.role,
        ),
    ],
  );
}

/// The data of the image for a saved palette. Its colours are looked up by
/// colour id in [catalog] (the markers of every brand the palette holds); a
/// code that no longer exists is left out. The base marker is the only colour
/// with a role ([baseRole]); the companions of a saved palette have none.
PaletteCardData savedPaletteCardData({
  required SavedPalette palette,
  required List<MarkerColor> catalog,
  required String baseRole,
}) {
  final Map<String, MarkerColor> byCode = <String, MarkerColor>{
    for (final MarkerColor color in catalog) color.colorId.toUpperCase(): color,
  };
  final String base = palette.baseColorId.toUpperCase();
  final List<SharedPaletteColor> colors = <SharedPaletteColor>[];
  for (final String code in palette.colorIds) {
    final MarkerColor? color = byCode[code.toUpperCase()];
    if (color == null) continue;
    colors.add((
      color: color,
      role: code.toUpperCase() == base ? baseRole : null,
    ));
  }
  return paletteCardData(
    title: palette.name,
    brand: MarkerBrand.fromId(palette.brandId),
    colors: colors,
  );
}
