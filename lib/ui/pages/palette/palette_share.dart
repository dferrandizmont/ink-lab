import '../../../core/models.dart';
import '../../../core/palette_card_layout.dart';
import '../../../core/palette_text.dart';

/// One colour of a palette about to be shared: the marker and the role to
/// print next to it (already localised), when it has one.
typedef SharedPaletteColor = ({MarkerColor color, String? role});

/// The data of the image for a palette made of [colors], in strip order.
PaletteCardData paletteCardData({
  required String title,
  required MarkerBrand brand,
  required List<SharedPaletteColor> colors,
}) => PaletteCardData(
  title: title,
  brand: brand.label,
  entries: <PaletteCardEntry>[
    for (final SharedPaletteColor item in colors)
      PaletteCardEntry(
        role: item.role,
        code: item.color.newCode,
        name: item.color.newName,
        hex: item.color.hex,
      ),
  ],
);

/// The message that shares [colors] (in strip order) as text: [header], one
/// line per marker with its code, name and role, and the compact line the app
/// reads back (see [PaletteText]).
String paletteShareText({
  required String header,
  required MarkerBrand brand,
  required List<SharedPaletteColor> colors,
}) => PaletteText.format(
  header: header,
  brandId: brand.id,
  lines: <PaletteTextLine>[
    for (final SharedPaletteColor item in colors)
      (code: item.color.newCode, name: item.color.newName, role: item.role),
  ],
);

/// The data of the image for a saved palette. Its colours are looked up by
/// code in [catalog] (the brand's markers); a code that no longer exists is
/// left out. The base marker is the only colour with a role ([baseRole]); the
/// companions of a saved palette have none.
PaletteCardData savedPaletteCardData({
  required SavedPalette palette,
  required List<MarkerColor> catalog,
  required String baseRole,
}) {
  final Map<String, MarkerColor> byCode = <String, MarkerColor>{
    for (final MarkerColor color in catalog) color.newCode.toUpperCase(): color,
  };
  final String base = palette.baseCode.toUpperCase();
  final List<SharedPaletteColor> colors = <SharedPaletteColor>[];
  for (final String code in palette.colorCodes) {
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
