import 'dart:typed_data';

import 'package:flutter/painting.dart';

import '../../core/layout_rect.dart';
import '../../core/swatch_chart_layout.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import '../widgets/color_swatch_tile.dart' show swatchColor;
import 'image_painting.dart';
import 'palette_card_renderer.dart' show shareFooterText;

/// One marker of the chart: the texts under its box and, when the catalogue
/// colour is shown, its hex.
final class ChartMarker {
  const ChartMarker({
    required this.code,
    required this.name,
    required this.hex,
  });

  final String code, name, hex;
}

/// Everything a swatch chart page says, already localised.
final class SwatchChartSpec {
  const SwatchChartSpec({
    required this.brand,
    required this.title,
    required this.pageLabel,
    required this.markers,
    this.showCatalogueColour = false,
    this.layout = const SwatchChartLayout(),
  });

  /// The brand, big, in the header.
  final String brand;

  /// "Swatch chart", under the brand.
  final String title;

  /// "Page 2 of 5".
  final String Function(int page, int count) pageLabel;

  /// The markers in chart order (see `chartMarkers`).
  final List<ChartMarker> markers;

  /// Draws a thin strip with the catalogue colour in each box.
  final bool showCatalogueColour;
  final SwatchChartLayout layout;

  List<SwatchChartPage> get pages => layout.paginate(markers.length);
}

/// Renders every page of [spec] as a PNG (A4 portrait, 300 dpi), one after the
/// other so only one page is in memory at a time.
Future<List<Uint8List>> renderSwatchChart(SwatchChartSpec spec) async {
  final List<Uint8List> images = <Uint8List>[];
  for (final SwatchChartPage page in spec.pages) {
    images.add(await renderSwatchChartPage(spec, page));
  }
  return images;
}

/// Renders one page of the chart.
Future<Uint8List> renderSwatchChartPage(
  SwatchChartSpec spec,
  SwatchChartPage page,
) => renderPng(
  width: spec.layout.pageWidth.round(),
  height: spec.layout.pageHeight.round(),
  paint: (Canvas canvas) => paintSwatchChartPage(canvas, spec, page),
);

/// Paints [page] of the chart on [canvas]: white paper, a header, the labelled
/// empty boxes and a small footer.
void paintSwatchChartPage(
  Canvas canvas,
  SwatchChartSpec spec,
  SwatchChartPage page,
) {
  const InkColors ink = InkColors.light;
  final SwatchChartLayout layout = spec.layout;
  canvas.drawRect(
    Rect.fromLTWH(0, 0, layout.pageWidth, layout.pageHeight),
    Paint()..color = const Color(0xFFFFFFFF),
  );

  final LayoutRect header = page.header;
  drawFitted(
    canvas,
    spec.brand,
    sizedStyle(AppTypography.title, 96, ink.fg),
    LayoutRect(header.left, header.top, header.width * 0.7, 110),
    minScale: 0.5,
  );
  drawFitted(
    canvas,
    spec.title,
    sizedStyle(AppTypography.secondary, 44, ink.fg2),
    LayoutRect(header.left, header.top + 116, header.width * 0.7, 56),
  );
  drawFitted(
    canvas,
    spec.pageLabel(page.number, page.count),
    sizedStyle(AppTypography.code, 48, ink.fg),
    LayoutRect(
      header.left + header.width * 0.7,
      header.top,
      header.width * 0.3,
      110,
    ),
    align: TextAlign.right,
  );
  canvas.drawLine(
    Offset(header.left, header.bottom - 12),
    Offset(header.right, header.bottom - 12),
    Paint()
      ..color = ink.strong
      ..strokeWidth = 3,
  );

  final Paint outline = Paint()
    ..color = ink.fg2
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;
  for (final SwatchChartSlot slot in page.slots) {
    final ChartMarker marker = spec.markers[slot.markerIndex];
    final LayoutRect label = slot.label;
    drawFitted(
      canvas,
      marker.code,
      sizedStyle(AppTypography.code, 44, ink.fg),
      LayoutRect(label.left, label.top, label.width, 54),
    );
    drawFitted(
      canvas,
      marker.name,
      sizedStyle(AppTypography.secondary, 32, ink.fg2),
      LayoutRect(label.left, label.top + 54, label.width, 42),
      minScale: 0.7,
    );
    canvas.drawRect(slot.box.rect.deflate(2), outline);
    if (spec.showCatalogueColour) {
      drawSwatch(canvas, slot.reference.rect, swatchColor(marker.hex));
    }
  }

  drawFitted(
    canvas,
    shareFooterText,
    sizedStyle(AppTypography.capsStyle, 28, ink.fg2),
    page.footer,
  );
}
