import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/layout_rect.dart';
import 'package:ink_lab/ui/share/diary_entry_card_layout.dart';
import 'package:ink_lab/ui/share/diary_entry_renderer.dart';
import 'package:ink_lab/ui/share/image_painting.dart';
import 'package:ink_lab/ui/share/share_actions.dart';

import '../../support/fake_share_sink.dart';
import '../../support/l10n.dart';

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

/// A 400 x 300 PNG painted in one colour, standing for a photo.
Future<Uint8List> _photo(WidgetTester tester) async {
  final Uint8List? bytes = await tester.runAsync(
    () => renderPng(
      width: 400,
      height: 300,
      paint: (Canvas canvas) => canvas.drawRect(
        const Rect.fromLTWH(0, 0, 400, 300),
        Paint()..color = const Color(0xFFFF0000),
      ),
    ),
  );
  return bytes!;
}

DiaryEntryCardData _data({
  Uint8List? photo,
  String title = 'Forest page',
  String onWhat = 'Colouring book',
  int markers = 3,
  int more = 0,
  List<String> palette = const <String>['#00FF00', '#0000FF'],
}) => DiaryEntryCardData(
  title: title,
  meta: '30 Oct 2026 · Finished',
  onWhat: onWhat,
  photo: photo,
  markers: <DiaryEntryCardMarker>[
    for (int i = 0; i < markers; i++)
      DiaryEntryCardMarker(
        code: 'B${i + 1}',
        name: 'Blue $i',
        hex: i.isEven ? '#FF00FF' : '#00FFFF',
      ),
  ],
  moreMarkers: more,
  moreText: more > 0 ? '+$more more' : '',
  markersLabel: 'Markers used',
  paletteLabel: 'Palette',
  paletteName: palette.isEmpty ? '' : 'Sunrise',
  paletteHexes: palette,
);

DiaryEntryCardLayout _layout(DiaryEntryCardData d, {bool photo = false}) =>
    diaryEntryLayoutFor(d, hasPhoto: photo);

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await loadAppFonts();
  });

  group('diary entry image layout', () {
    test('stacks its blocks without overlap, inside the page', () {
      final DiaryEntryCardLayout l = DiaryEntryCardLayout(
        titleLines: 2,
        hasOnWhat: true,
        hasPhoto: true,
        markerCount: 5,
        hasMore: true,
        paletteColors: 4,
      );
      final List<LayoutRect> blocks = <LayoutRect>[
        l.meta,
        l.title,
        l.onWhat!,
        l.photo!,
        l.markersHeading!,
        for (final DiaryEntryCardMarkerSlot slot in l.markerSlots) slot.swatch,
        l.more!,
        l.paletteHeading!,
        l.paletteName!,
        ...l.paletteStrip,
        l.footer,
      ];
      final LayoutRect page = LayoutRect(0, 0, 1080, l.height);
      for (final LayoutRect block in blocks) {
        expect(page.contains(block), isTrue, reason: '$block');
      }
      for (int i = 0; i < blocks.length; i++) {
        for (int j = i + 1; j < blocks.length; j++) {
          expect(
            blocks[i].overlaps(blocks[j]),
            isFalse,
            reason: '${blocks[i]} against ${blocks[j]}',
          );
        }
      }
      // Two columns: the second marker sits in the right half.
      expect(l.markerSlots[1].swatch.left, greaterThan(540));
      expect(l.markerSlots[1].swatch.top, l.markerSlots[0].swatch.top);
    });

    test('grows with what the entry has and caps the markers', () {
      double h({
        int lines = 1,
        bool photo = false,
        int markers = 0,
        int colours = 0,
      }) => DiaryEntryCardLayout(
        titleLines: lines,
        hasOnWhat: false,
        hasPhoto: photo,
        markerCount: markers,
        hasMore: false,
        paletteColors: colours,
      ).height;
      final double bare = h();
      expect(h(lines: 2), greaterThan(bare));
      expect(h(photo: true), greaterThan(bare));
      expect(h(markers: 1), greaterThan(bare));
      expect(h(markers: 3), h(markers: 4));
      expect(h(markers: 5), greaterThan(h(markers: 4)));
      expect(h(colours: 3), greaterThan(bare));
      expect(h(markers: 40), h(markers: DiaryEntryCardLayout.maxMarkers));
    });
  });

  group('diary entry image', () {
    testWidgets('is a 1080 px wide PNG as tall as its layout says', (
      WidgetTester tester,
    ) async {
      final DiaryEntryCardData d = _data(photo: await _photo(tester));
      final Uint8List bytes = (await tester.runAsync(
        () => renderDiaryEntryCard(d),
      ))!;
      final ({int width, int height})? size = pngSize(bytes);
      expect(size!.width, 1080);
      expect(size.height, _layout(d, photo: true).height.round());
    });

    testWidgets('paints the photo, the markers and the palette on light', (
      WidgetTester tester,
    ) async {
      final DiaryEntryCardData d = _data(photo: await _photo(tester));
      final DiaryEntryCardLayout l = _layout(d, photo: true);
      final Uint8List bytes = (await tester.runAsync(
        () => renderDiaryEntryCard(d),
      ))!;
      Future<List<int>> at(LayoutRect r) async => (await tester.runAsync(
        () => _pixel(
          bytes,
          (r.left + r.width / 2).round(),
          (r.top + r.height / 2).round(),
        ),
      ))!;
      expect(await at(l.photo!), <int>[255, 0, 0, 255]);
      expect(await at(l.markerSlots[0].swatch), <int>[255, 0, 255, 255]);
      expect(await at(l.markerSlots[1].swatch), <int>[0, 255, 255, 255]);
      expect(await at(l.paletteStrip[0]), <int>[0, 255, 0, 255]);
      expect(await at(l.paletteStrip[1]), <int>[0, 0, 255, 255]);
      // The page itself is the light-theme background, whatever the app theme.
      final List<int> corner = (await tester.runAsync(
        () => _pixel(bytes, 4, 4),
      ))!;
      expect(corner, <int>[0xF5, 0xF5, 0xF3, 255]);
    });

    testWidgets('an entry without photo, markers or palette is short', (
      WidgetTester tester,
    ) async {
      final DiaryEntryCardData d = _data(
        onWhat: '',
        markers: 0,
        palette: const <String>[],
      );
      final Uint8List bytes = (await tester.runAsync(
        () => renderDiaryEntryCard(d),
      ))!;
      final ({int width, int height})? size = pngSize(bytes);
      expect(size!.width, 1080);
      expect(size.height, lessThan(500));
      expect(size.height, _layout(d).height.round());
    });

    testWidgets('bytes that are not an image leave the photo out', (
      WidgetTester tester,
    ) async {
      final DiaryEntryCardData d = _data(
        photo: Uint8List.fromList(<int>[1, 2, 3]),
      );
      final Uint8List bytes = (await tester.runAsync(
        () => renderDiaryEntryCard(d),
      ))!;
      expect(pngSize(bytes)!.height, _layout(d).height.round());
    });

    testWidgets('a long title takes two lines', (WidgetTester tester) async {
      final DiaryEntryCardData longTitle = _data(
        title:
            'A page of the autumn forest colouring book with the fox and the '
            'owls',
      );
      expect(_layout(longTitle).titleLines, 2);
      expect(_layout(_data()).titleLines, 1);
      final Uint8List bytes = (await tester.runAsync(
        () => renderDiaryEntryCard(longTitle),
      ))!;
      expect(pngSize(bytes)!.height, _layout(longTitle).height.round());
    });

    testWidgets('shares one PNG named after the app, titled by the entry', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await tester.runAsync(() => shareDiaryEntryCard(sink, _data()));
      expect(sink.shared, hasLength(1));
      expect(sink.shared.single, hasLength(1));
      expect(sink.shared.single.single.name, 'ink-lab-diary.png');
      expect(pngSize(sink.shared.single.single.bytes)!.width, 1080);
      expect(sink.subjects.single, 'Forest page');
    });
  });
}
