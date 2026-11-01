import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/layout_rect.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/swatch_chart_layout.dart';

MarkerColor _marker(String code) => MarkerColor(
  newCode: code,
  newName: 'Name $code',
  oldCode: code,
  oldName: 'Name $code',
  hex: '#336699',
  sets: const <String>[],
);

void main() {
  const SwatchChartLayout layout = SwatchChartLayout();

  group('A4 geometry', () {
    test('is A4 portrait at 300 dpi', () {
      expect(layout.pageWidth, 2480);
      expect(layout.pageHeight, 3508);
    });

    test('grid fills the printable area without crossing the margins', () {
      expect(layout.columns, 4);
      expect(layout.rows, 9);
      expect(layout.perPage, 36);
      final LayoutRect printable = LayoutRect(
        layout.margin,
        layout.margin,
        layout.pageWidth - 2 * layout.margin,
        layout.pageHeight - 2 * layout.margin,
      );
      for (final SwatchChartPage page in layout.paginate(layout.perPage)) {
        expect(printable.contains(page.header), isTrue);
        expect(printable.contains(page.footer), isTrue);
        expect(page.header.overlaps(page.footer), isFalse);
        for (final SwatchChartSlot slot in page.slots) {
          expect(printable.contains(slot.label), isTrue);
          expect(printable.contains(slot.box), isTrue);
          expect(slot.box.bottom, lessThanOrEqualTo(page.footer.top));
          expect(slot.label.top, greaterThanOrEqualTo(page.header.bottom));
        }
      }
    });

    test('boxes never overlap each other or any label', () {
      final SwatchChartPage page = layout.paginate(layout.perPage).single;
      expect(page.slots, hasLength(layout.perPage));
      for (int a = 0; a < page.slots.length; a++) {
        final SwatchChartSlot one = page.slots[a];
        expect(one.label.overlaps(one.box), isFalse);
        expect(one.box.contains(one.reference), isTrue);
        for (int b = a + 1; b < page.slots.length; b++) {
          final SwatchChartSlot two = page.slots[b];
          expect(one.box.overlaps(two.box), isFalse, reason: '$a vs $b');
          expect(one.label.overlaps(two.label), isFalse, reason: '$a vs $b');
          expect(one.box.overlaps(two.label), isFalse, reason: '$a vs $b');
        }
      }
    });

    test('boxes are big enough to colour in (at least 40 x 12 mm)', () {
      const double pxPerMm = 300 / 25.4;
      final SwatchChartSlot slot = layout.paginate(1).single.slots.single;
      expect(slot.box.width / pxPerMm, greaterThan(40));
      expect(slot.box.height / pxPerMm, greaterThan(12));
    });

    test('fills left to right, then top to bottom', () {
      final List<SwatchChartSlot> slots = layout.paginate(6).single.slots;
      expect(slots[0].box.top, slots[1].box.top);
      expect(slots[1].box.left, greaterThan(slots[0].box.left));
      expect(slots[4].box.left, slots[0].box.left);
      expect(slots[4].box.top, greaterThan(slots[0].box.top));
    });
  });

  group('pagination', () {
    test('no markers, no pages', () {
      expect(layout.pageCount(0), 0);
      expect(layout.paginate(0), isEmpty);
    });

    test('page counts around the page size', () {
      expect(layout.pageCount(1), 1);
      expect(layout.pageCount(36), 1);
      expect(layout.pageCount(37), 2);
      expect(layout.pageCount(72), 2);
      expect(layout.pageCount(73), 3);
      expect(layout.pageCount(160), 5);
      expect(layout.pageCount(321), 9);
    });

    test('every marker lands on exactly one page, in order', () {
      for (final int count in <int>[1, 35, 36, 37, 160, 321]) {
        final List<SwatchChartPage> pages = layout.paginate(count);
        final List<int> indexes = <int>[
          for (final SwatchChartPage page in pages)
            for (final SwatchChartSlot slot in page.slots) slot.markerIndex,
        ];
        expect(
          indexes,
          List<int>.generate(count, (int i) => i),
          reason: '$count',
        );
        expect(pages.map((SwatchChartPage p) => p.number), <int>[
          for (int i = 1; i <= pages.length; i++) i,
        ]);
        expect(
          pages.every((SwatchChartPage p) => p.count == pages.length),
          isTrue,
        );
      }
    });

    test('only the last page may be partly empty', () {
      final List<SwatchChartPage> pages = layout.paginate(80);
      expect(pages, hasLength(3));
      expect(pages[0].slots, hasLength(36));
      expect(pages[1].slots, hasLength(36));
      expect(pages[2].slots, hasLength(8));
    });

    test('a later page repeats the geometry of the first', () {
      final List<SwatchChartPage> pages = layout.paginate(40);
      expect(pages[1].slots.first.box, pages[0].slots.first.box);
    });
  });

  group('chart order', () {
    test('sorts codes naturally: B2 before B10, letters then numbers', () {
      final List<MarkerColor> sorted = chartMarkers(<MarkerColor>[
        _marker('B10'),
        _marker('B2'),
        _marker('BV04'),
        _marker('B1'),
        _marker('YR57'),
        _marker('120'),
        _marker('9'),
      ]);
      expect(sorted.map((MarkerColor c) => c.newCode), <String>[
        '9',
        '120',
        'B1',
        'B2',
        'B10',
        'BV04',
        'YR57',
      ]);
    });

    test('does not change the list it is given', () {
      final List<MarkerColor> input = <MarkerColor>[
        _marker('B2'),
        _marker('B1'),
      ];
      chartMarkers(input);
      expect(input.first.newCode, 'B2');
    });
  });
}
