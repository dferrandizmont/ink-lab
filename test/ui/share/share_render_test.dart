import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/layout_rect.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_card_layout.dart';
import 'package:ink_lab/core/swatch_chart_layout.dart';
import 'package:ink_lab/ui/pages/palette/palette_share.dart';
import 'package:ink_lab/ui/share/palette_card_renderer.dart';
import 'package:ink_lab/ui/share/share_actions.dart';
import 'package:ink_lab/ui/share/share_sink.dart';
import 'package:ink_lab/ui/share/swatch_chart_renderer.dart';

import '../../support/fake_share_sink.dart';
import '../../support/l10n.dart';

MarkerColor _marker(String code, String hex, {String? name}) => MarkerColor(
  newCode: code,
  newName: name ?? 'Name $code',
  oldCode: code,
  oldName: name ?? 'Name $code',
  hex: hex,
  sets: const <String>[],
);

/// RGBA of the pixel at ([x], [y]) of the PNG [bytes].
Future<List<int>> _pixel(Uint8List bytes, int x, int y) async {
  final ui.Codec codec = await ui.instantiateImageCodec(bytes);
  final ui.FrameInfo frame = await codec.getNextFrame();
  final ByteData data = (await frame.image.toByteData())!;
  final int at = (y * frame.image.width + x) * 4;
  final List<int> rgba = <int>[
    for (int i = 0; i < 4; i++) data.getUint8(at + i),
  ];
  frame.image.dispose();
  codec.dispose();
  return rgba;
}

SwatchChartSpec _spec(
  int count, {
  bool showColour = false,
  String brand = 'Ohuhu',
}) => SwatchChartSpec(
  brand: brand,
  title: 'Swatch chart',
  pageLabel: (int page, int total) => 'Page $page of $total',
  showCatalogueColour: showColour,
  markers: <ChartMarker>[
    for (int i = 0; i < count; i++)
      ChartMarker(code: 'B${i + 1}', name: 'Blue $i', hex: '#FF0000'),
  ],
);

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await loadAppFonts();
  });

  group('palette image', () {
    const PaletteCardData data = PaletteCardData(
      title: 'Complementary',
      brand: 'Ohuhu',
      entries: <PaletteCardEntry>[
        PaletteCardEntry(
          role: 'Base',
          code: 'B114',
          name: 'Cobalt Blue',
          hex: '#FF0000',
        ),
        PaletteCardEntry(code: 'YR57', name: 'Saffron', hex: '#00FF00'),
        PaletteCardEntry(
          role: 'Shadow',
          code: 'V3',
          name: 'A very long marker name that has to shrink to fit the column',
          hex: '#0000ff',
        ),
      ],
    );

    testWidgets('is a 1080 px wide PNG as tall as its layout says', (
      WidgetTester tester,
    ) async {
      final Uint8List? bytes = await tester.runAsync(
        () => renderPaletteCard(data),
      );
      final ({int width, int height})? size = pngSize(bytes!);
      expect(size, isNotNull);
      expect(size!.width, 1080);
      expect(size.height, PaletteCardLayout(3).height.round());
    });

    testWidgets('paints each swatch in its marker colour on a light page', (
      WidgetTester tester,
    ) async {
      final Uint8List bytes = (await tester.runAsync(
        () => renderPaletteCard(data),
      ))!;
      final PaletteCardLayout layout = PaletteCardLayout(3);
      final List<PaletteCardRow> rows = layout.rows;
      Future<List<int>> centre(int row) async => (await tester.runAsync(
        () => _pixel(
          bytes,
          (rows[row].swatch.left + rows[row].swatch.width / 2).round(),
          (rows[row].swatch.top + rows[row].swatch.height / 2).round(),
        ),
      ))!;
      expect(await centre(0), <int>[255, 0, 0, 255]);
      expect(await centre(1), <int>[0, 255, 0, 255]);
      expect(await centre(2), <int>[0, 0, 255, 255]);
      // The page itself is the light-theme background, whatever the app theme.
      final List<int> corner = (await tester.runAsync(
        () => _pixel(bytes, 4, 4),
      ))!;
      expect(corner, <int>[0xF5, 0xF5, 0xF3, 255]);
    });

    testWidgets('writes text next to the swatches', (
      WidgetTester tester,
    ) async {
      final Uint8List bytes = (await tester.runAsync(
        () => renderPaletteCard(data),
      ))!;
      final LayoutRect text = PaletteCardLayout(3).rows.first.text;
      // Somewhere in the text column there is at least one dark pixel.
      final bool inked = (await tester.runAsync(() async {
        for (int y = text.top.round(); y < text.bottom.round(); y += 4) {
          for (int x = text.left.round(); x < text.left.round() + 300; x += 4) {
            final List<int> p = await _pixel(bytes, x, y);
            if (p[0] < 120) return true;
          }
        }
        return false;
      }))!;
      expect(inked, isTrue);
    });

    testWidgets('shares one PNG named after the app, titled by the palette', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await tester.runAsync(() => sharePaletteCard(sink, data));
      expect(sink.shared, hasLength(1));
      expect(sink.shared.single, hasLength(1));
      expect(sink.shared.single.single.name, 'ink-lab-palette.png');
      expect(pngSize(sink.shared.single.single.bytes)!.width, 1080);
      expect(sink.subjects.single, 'Complementary');
    });
  });

  group('palette card data', () {
    final List<MarkerColor> catalog = <MarkerColor>[
      _marker('B1', '#112233'),
      _marker('B2', '#445566'),
      _marker('Y9', '#778899'),
    ];

    test(
      'a saved palette keeps its name and brand; only the base has a role',
      () {
        final PaletteCardData card = savedPaletteCardData(
          palette: SavedPalette(
            id: 'p',
            brandId: MarkerBrand.decoTime.id,
            name: 'My sky',
            baseCode: 'b2',
            baseName: 'x',
            mode: PaletteMode.triad,
            paletteSize: 3,
            createdAtEpochMs: 1,
            colorCodes: const <String>['B2', 'Y9', 'B1'],
          ),
          // The palette is DecoTime: colours are looked up by colour id.
          catalog: <MarkerColor>[
            for (final MarkerColor c in catalog)
              c.copyWith(brandId: MarkerBrand.decoTime.id),
          ],
          baseRole: 'Base',
        );
        expect(card.title, 'My sky');
        expect(card.brand, 'DecoTime');
        expect(card.entries.map((PaletteCardEntry e) => e.code), <String>[
          'B2',
          'Y9',
          'B1',
        ]);
        expect(card.entries.map((PaletteCardEntry e) => e.role), <String?>[
          'Base',
          null,
          null,
        ]);
        expect(card.entries.first.name, 'Name B2');
        expect(card.entries.first.hex, '#445566');
      },
    );

    test('a code that left the catalogue is skipped', () {
      final PaletteCardData card = savedPaletteCardData(
        palette: SavedPalette(
          id: 'p',
          name: 'Old',
          baseCode: 'B1',
          baseName: 'x',
          mode: PaletteMode.triad,
          paletteSize: 3,
          createdAtEpochMs: 1,
          colorCodes: const <String>['B1', 'GONE', 'Y9'],
        ),
        catalog: catalog,
        baseRole: 'Base',
      );
      expect(card.entries.map((PaletteCardEntry e) => e.code), <String>[
        'B1',
        'Y9',
      ]);
    });

    test('a palette on screen carries the roles it was given', () {
      final PaletteCardData card = paletteCardData(
        title: 'Triad',
        brand: MarkerBrand.ohuhuOahu,
        colors: <SharedPaletteColor>[
          (color: catalog[0], role: 'Base'),
          (color: catalog[1], role: 'Shadow'),
        ],
      );
      expect(card.brand, 'Ohuhu');
      expect(card.entries.map((PaletteCardEntry e) => e.role), <String?>[
        'Base',
        'Shadow',
      ]);
    });
  });

  group('swatch chart images', () {
    testWidgets('every page is A4 at 300 dpi', (WidgetTester tester) async {
      final List<Uint8List> pages = (await tester.runAsync(
        () => renderSwatchChart(_spec(40)),
      ))!;
      expect(pages, hasLength(2));
      for (final Uint8List page in pages) {
        final ({int width, int height})? size = pngSize(page);
        expect(size?.width, 2480);
        expect(size?.height, 3508);
      }
    });

    testWidgets('boxes are empty unless the catalogue colour is asked for', (
      WidgetTester tester,
    ) async {
      final SwatchChartSlot slot = const SwatchChartLayout()
          .paginate(1)
          .single
          .slots
          .single;
      final int cx = (slot.box.left + slot.box.width / 2).round();
      final int cy = (slot.box.top + slot.box.height / 2).round();
      final int sx = (slot.reference.left + slot.reference.width / 2).round();
      final int sy = (slot.reference.top + slot.reference.height / 2).round();

      final Uint8List plain = (await tester.runAsync(
        () => renderSwatchChartPage(
          _spec(1),
          const SwatchChartLayout().paginate(1).single,
        ),
      ))!;
      expect(await tester.runAsync(() => _pixel(plain, cx, cy)), <int>[
        255,
        255,
        255,
        255,
      ]);
      expect(await tester.runAsync(() => _pixel(plain, sx, sy)), <int>[
        255,
        255,
        255,
        255,
      ]);

      final Uint8List coloured = (await tester.runAsync(
        () => renderSwatchChartPage(
          _spec(1, showColour: true),
          const SwatchChartLayout().paginate(1).single,
        ),
      ))!;
      // The middle of the box is still empty; the strip carries the colour.
      expect(await tester.runAsync(() => _pixel(coloured, cx, cy)), <int>[
        255,
        255,
        255,
        255,
      ]);
      expect(await tester.runAsync(() => _pixel(coloured, sx, sy)), <int>[
        255,
        0,
        0,
        255,
      ]);
    });

    testWidgets('all pages go to the share sheet in one call', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await tester.runAsync(
        () => shareSwatchChart(sink, _spec(80, brand: 'Deco Time')),
      );
      expect(sink.shared, hasLength(1));
      final List<ShareImage> images = sink.shared.single;
      expect(images.map((ShareImage i) => i.name), <String>[
        'ink-lab-deco-time-chart-1-of-3.png',
        'ink-lab-deco-time-chart-2-of-3.png',
        'ink-lab-deco-time-chart-3-of-3.png',
      ]);
    });
  });
}
