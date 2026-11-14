import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/own_colors.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import 'ideas/ideas_test_support.dart';
import 'palette/palette_test_support.dart';

// Palette and Ideas read their markers from the same place as Match and
// Swatches, so the colours a user stored reach them too, and a change while
// the page is open is picked up.

List<String> _stripHexes(WidgetTester tester) => <String>[
  for (final Element e in find.byType(PaletteStrip).evaluate())
    for (final String hex in (e.widget as PaletteStrip).colors)
      normalizeOwnHex(hex) ?? hex,
];

void main() {
  for (final brand in [
    MarkerBrand.ohuhuOahu,
    MarkerBrand.copic,
    MarkerBrand.finecolour,
  ]) {
    final code = brand == MarkerBrand.finecolour
        ? 'BV321'
        : brand == MarkerBrand.copic
        ? 'BV04'
        : 'B08';
    // The markers the user owns: a brand without retail sets is collected
    // marker by marker, and the app only works with the owned ones.
    final Set<String>? owned = switch (brand) {
      MarkerBrand.copic => const <String>{
        'copic:BV04',
        'copic:R29',
        'copic:B05',
        'copic:Y08',
        'copic:G17',
      },
      MarkerBrand.finecolour => const <String>{
        'finecolour:BV321',
        'finecolour:R140',
        'finecolour:B94',
        'finecolour:Y1',
        'finecolour:G45',
      },
      _ => null,
    };
    testWidgets(
      '${brand.label}: Palette builds from the own colour of the base marker',
      (WidgetTester tester) async {
        final AppScope scope = await pumpPalette(
          tester,
          brand: brand,
          ownedMarkerCodes: owned,
        );
        await chooseBase(tester, code);
        final PaletteStrip before = tester.widget(
          find.byType(PaletteStrip).first,
        );
        final String catalogue = normalizeOwnHex(before.colors.first)!;
        expect(before.labels!.first, code);

        await scope.ownColors.set('${brand.id}:$code', '123456');
        await tester.pumpAndSettle();
        final PaletteStrip own = tester.widget(find.byType(PaletteStrip).first);
        expect(normalizeOwnHex(own.colors.first), '123456');
        expect(own.colors.first, isNot(catalogue));

        // Switched off, the catalogue colour is back.
        await scope.settings.setUseOwnColors(false);
        await tester.pumpAndSettle();
        final PaletteStrip off = tester.widget(find.byType(PaletteStrip).first);
        expect(normalizeOwnHex(off.colors.first), catalogue);
      },
    );

    testWidgets('${brand.label}: Ideas plans are made from the own colours', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpIdeas(
        tester,
        brand: brand,
        ownedMarkerCodes: owned,
      );
      expect(_stripHexes(tester), isNot(contains('123456')));

      final List<MarkerColor> all = await scope.markers.loadColors(brand);
      await scope.ownColors.restore(<String, String>{
        for (final MarkerColor c in all) c.colorId: '123456',
      });
      await tester.pumpAndSettle();
      expect(_stripHexes(tester), contains('123456'));

      await scope.settings.setUseOwnColors(false);
      await tester.pumpAndSettle();
      expect(_stripHexes(tester), isNot(contains('123456')));
    });
  }
}
