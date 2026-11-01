import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/layout_rect.dart';
import 'package:ink_lab/core/palette_card_layout.dart';

void main() {
  test('the card is 1080 px wide and grows with the colours', () {
    final PaletteCardLayout three = PaletteCardLayout(3);
    final PaletteCardLayout four = PaletteCardLayout(4);
    expect(PaletteCardLayout.width, 1080);
    expect(
      four.height - three.height,
      PaletteCardLayout.rowHeight + PaletteCardLayout.rowGap,
    );
  });

  test('negative or zero counts give an empty card', () {
    expect(PaletteCardLayout(-2).count, 0);
    expect(PaletteCardLayout(0).rows, isEmpty);
    expect(PaletteCardLayout(0).height, greaterThan(0));
  });

  for (final int count in <int>[1, 3, 5, 12]) {
    test(
      '$count colours: everything fits inside the canvas, nothing overlaps',
      () {
        final PaletteCardLayout layout = PaletteCardLayout(count);
        final LayoutRect canvas = LayoutRect(
          0,
          0,
          PaletteCardLayout.width,
          layout.height,
        );
        final List<LayoutRect> blocks = <LayoutRect>[layout.header];
        for (final PaletteCardRow row in layout.rows) {
          blocks
            ..add(row.swatch)
            ..add(row.text);
          expect(row.swatch.overlaps(row.text), isFalse);
        }
        blocks.add(layout.footer);
        expect(layout.rows, hasLength(count));
        for (final LayoutRect block in blocks) {
          expect(canvas.contains(block), isTrue, reason: '$block');
          // A margin all round, so the image does not touch the edge.
          expect(block.left, greaterThanOrEqualTo(PaletteCardLayout.margin));
          expect(
            block.right,
            lessThanOrEqualTo(
              PaletteCardLayout.width - PaletteCardLayout.margin,
            ),
          );
        }
        for (int a = 0; a < blocks.length; a++) {
          for (int b = a + 1; b < blocks.length; b++) {
            expect(blocks[a].overlaps(blocks[b]), isFalse, reason: '$a vs $b');
          }
        }
        expect(layout.footer.bottom, layout.height - PaletteCardLayout.margin);
      },
    );
  }

  test('swatches are large: at least 400 px wide and 200 px tall', () {
    final PaletteCardRow row = PaletteCardLayout(2).rows.first;
    expect(row.swatch.width, greaterThanOrEqualTo(400));
    expect(row.swatch.height, greaterThanOrEqualTo(200));
  });

  test('an entry has a role only when it is not blank', () {
    expect(
      const PaletteCardEntry(code: 'B1', name: 'n', hex: '#FFF').hasRole,
      isFalse,
    );
    expect(
      const PaletteCardEntry(
        code: 'B1',
        name: 'n',
        hex: '#FFF',
        role: ' ',
      ).hasRole,
      isFalse,
    );
    expect(
      const PaletteCardEntry(
        code: 'B1',
        name: 'n',
        hex: '#FFF',
        role: 'Base',
      ).hasRole,
      isTrue,
    );
  });
}
