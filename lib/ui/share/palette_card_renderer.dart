import 'dart:typed_data';

import 'package:flutter/painting.dart';

import '../../core/layout_rect.dart';
import '../../core/palette_card_layout.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import '../widgets/color_swatch_tile.dart' show swatchColor;
import 'image_painting.dart';

/// The name of the app, drawn small at the foot of every shared image.
const String shareFooterText = 'Ink Lab';

/// Draws [data] as a PNG, 1080 px wide, always with the light theme so it reads
/// the same wherever it is opened.
Future<Uint8List> renderPaletteCard(PaletteCardData data) {
  final PaletteCardLayout layout = PaletteCardLayout(data.entries.length);
  return renderPng(
    width: PaletteCardLayout.width.round(),
    height: layout.height.round(),
    paint: (Canvas canvas) => paintPaletteCard(canvas, data, layout),
  );
}

/// Paints the palette card on [canvas] following [layout].
void paintPaletteCard(
  Canvas canvas,
  PaletteCardData data,
  PaletteCardLayout layout,
) {
  const InkColors ink = InkColors.light;
  canvas.drawRect(
    Rect.fromLTWH(0, 0, PaletteCardLayout.width, layout.height),
    Paint()..color = ink.bg,
  );

  final LayoutRect header = layout.header;
  drawFitted(
    canvas,
    data.title,
    sizedStyle(AppTypography.title, 68, ink.fg),
    LayoutRect(header.left, header.top, header.width, 84),
    minScale: 0.5,
  );
  drawFitted(
    canvas,
    data.brand,
    sizedStyle(AppTypography.secondary, 34, ink.fg2),
    LayoutRect(header.left, header.top + 92, header.width, 44),
  );

  final List<PaletteCardRow> rows = layout.rows;
  for (int i = 0; i < rows.length; i++) {
    final PaletteCardEntry entry = data.entries[i];
    final PaletteCardRow row = rows[i];
    drawSwatch(canvas, row.swatch.rect, swatchColor(entry.hex));
    _paintEntryText(canvas, entry, row.text, ink);
  }

  drawFitted(
    canvas,
    shareFooterText,
    sizedStyle(AppTypography.sheetTitle, 30, ink.fg2),
    layout.footer,
  );
}

void _paintEntryText(
  Canvas canvas,
  PaletteCardEntry entry,
  LayoutRect area,
  InkColors ink,
) {
  final List<_Line> lines = <_Line>[
    if (entry.hasRole)
      _Line(
        AppTypography.caps(entry.role!.trim()),
        sizedStyle(AppTypography.capsStyle, 26, ink.fg2),
        36,
      ),
    _Line(entry.code, sizedStyle(AppTypography.code, 60, ink.fg), 68),
    _Line(entry.name, sizedStyle(AppTypography.body, 34, ink.fg), 46),
    _Line(
      _displayHex(entry.hex),
      sizedStyle(AppTypography.data, 28, ink.fg2),
      38,
    ),
  ];
  final double total = lines.fold(0, (double sum, _Line l) => sum + l.height);
  double y = area.top + (area.height - total) / 2;
  for (final _Line line in lines) {
    drawFitted(
      canvas,
      line.text,
      line.style,
      LayoutRect(area.left, y, area.width, line.height),
    );
    y += line.height;
  }
}

/// "#E75A3C": the hex of a marker, upper case with the leading `#`.
String _displayHex(String hex) {
  final String value = hex.trim().replaceFirst('#', '').toUpperCase();
  return '#$value';
}

final class _Line {
  const _Line(this.text, this.style, this.height);

  final String text;
  final TextStyle style;
  final double height;
}
