import 'layout_rect.dart';

/// One colour of a palette image, with the texts already localised.
final class PaletteCardEntry {
  const PaletteCardEntry({
    required this.code,
    required this.name,
    required this.hex,
    this.role,
  });

  /// Role of the colour in the palette ("Base", "Shadow"...), when it has one.
  final String? role;
  final String code, name, hex;

  bool get hasRole => role != null && role!.trim().isNotEmpty;
}

/// What a shared palette image says, ready to draw.
final class PaletteCardData {
  const PaletteCardData({
    required this.title,
    required this.brand,
    required this.entries,
  });

  /// The palette's type or scene name.
  final String title;

  /// The marker brand ("Ohuhu").
  final String brand;
  final List<PaletteCardEntry> entries;
}

/// One row of the card: the large swatch and the text column beside it.
final class PaletteCardRow {
  const PaletteCardRow({required this.swatch, required this.text});

  final LayoutRect swatch, text;
}

/// The geometry of a shared palette image: 1080 px wide, a title and the
/// brand, one row per colour (a large swatch with its texts) and a footer. The
/// height follows the number of colours.
///
/// Pure Dart so it can be tested without a renderer.
final class PaletteCardLayout {
  PaletteCardLayout(int count)
    : count = count < 0 ? 0 : count,
      height = _heightFor(count < 0 ? 0 : count);

  static const double width = 1080;
  static const double margin = 72;
  static const double headerHeight = 240;
  static const double rowHeight = 220;
  static const double rowGap = 24;
  static const double swatchWidth = 432;
  static const double swatchTextGap = 36;
  static const double footerGap = 48;
  static const double footerHeight = 56;

  final int count;
  final double height;

  static double _heightFor(int count) {
    final double rows = count == 0 ? 0 : count * (rowHeight + rowGap) - rowGap;
    return headerHeight + rows + footerGap + footerHeight + margin;
  }

  /// Title and brand.
  LayoutRect get header => const LayoutRect(
    margin,
    margin,
    width - 2 * margin,
    headerHeight - margin,
  );

  /// The rows, top to bottom.
  List<PaletteCardRow> get rows => <PaletteCardRow>[
    for (int i = 0; i < count; i++)
      PaletteCardRow(
        swatch: LayoutRect(
          margin,
          headerHeight + i * (rowHeight + rowGap),
          swatchWidth,
          rowHeight,
        ),
        text: LayoutRect(
          margin + swatchWidth + swatchTextGap,
          headerHeight + i * (rowHeight + rowGap),
          width - margin - (margin + swatchWidth + swatchTextGap),
          rowHeight,
        ),
      ),
  ];

  /// The small "Ink Lab" line.
  LayoutRect get footer => LayoutRect(
    margin,
    height - margin - footerHeight,
    width - 2 * margin,
    footerHeight,
  );
}
