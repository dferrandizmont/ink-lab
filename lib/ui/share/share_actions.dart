import 'dart:typed_data';

import '../../core/palette_card_layout.dart';
import 'palette_card_renderer.dart';
import 'share_sink.dart';
import 'swatch_chart_renderer.dart';

/// Renders [data] as a PNG and opens the share sheet with it.
Future<void> sharePaletteCard(ShareSink sink, PaletteCardData data) async {
  final Uint8List bytes = await renderPaletteCard(data);
  await sink.shareImages(<ShareImage>[
    ShareImage(bytes: bytes, name: 'ink-lab-palette.png'),
  ], subject: data.title);
}

/// Renders every page of [spec] and opens the share sheet with all of them at
/// once, so the user can print or save the whole chart.
Future<void> shareSwatchChart(ShareSink sink, SwatchChartSpec spec) async {
  final List<Uint8List> pages = await renderSwatchChart(spec);
  final String brand = _slug(spec.brand);
  await sink.shareImages(<ShareImage>[
    for (int i = 0; i < pages.length; i++)
      ShareImage(
        bytes: pages[i],
        name: 'ink-lab-$brand-chart-${i + 1}-of-${pages.length}.png',
      ),
  ], subject: '${spec.brand} · ${spec.title}');
}

String _slug(String text) {
  final String slug = text
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  return slug.isEmpty ? 'markers' : slug;
}
