import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/ui/pages/palette/palette_suggestion_row.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/branded_code.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';

import '../../support/l10n.dart';

MarkerColor _marker(MarkerBrand brand, String code) => MarkerColor(
  brandId: brand.id,
  newCode: code,
  newName: 'Name $code',
  oldCode: code,
  oldName: 'Name $code',
  hex: '#336699',
  sets: const <String>[],
);

Future<void> _pumpRow(
  WidgetTester tester, {
  required double width,
  required double textScale,
  required MarkerColor color,
  bool mixed = true,
}) async {
  tester.view.physicalSize = Size(width, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(textScale)),
            child: Align(
              alignment: Alignment.topLeft,
              child: PaletteSuggestionRow(
                suggestion: PaletteSuggestion(
                  color: color,
                  reason: 'Analogous',
                  role: 'Shadow',
                ),
                role: 'Shadow',
                mixed: mixed,
                locked: false,
                last: true,
                onToggleLock: () {},
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  setUpAll(loadAppFonts);

  group('a row of a palette that mixes brands', () {
    final MarkerColor deco = _marker(MarkerBrand.decoTime, '172');

    /// Brand and code laid out whole: no cut, no ellipsis, nothing past the
    /// edge of the row.
    void expectMarkerWhole(WidgetTester tester) {
      expect(tester.takeException(), isNull);
      final RenderParagraph brand = tester.renderObject<RenderParagraph>(
        find.text('DecoTime'),
      );
      final RenderParagraph code = tester.renderObject<RenderParagraph>(
        find.text('172'),
      );
      expect(brand.didExceedMaxLines, isFalse);
      expect(code.didExceedMaxLines, isFalse);
      expect(
        brand.size.width,
        greaterThanOrEqualTo(
          brand.getMaxIntrinsicWidth(double.infinity) - 0.01,
        ),
      );
      expect(
        code.size.width,
        greaterThanOrEqualTo(code.getMaxIntrinsicWidth(double.infinity) - 0.01),
      );
      expect(
        tester.getRect(find.text('172')).right,
        lessThanOrEqualTo(
          tester.getRect(find.byType(PaletteSuggestionRow)).right,
        ),
      );
    }

    testWidgets(
      'at text scale 1.5 on a narrow row the whole marker goes under the role',
      (WidgetTester tester) async {
        await _pumpRow(tester, width: 250, textScale: 1.5, color: deco);
        expectMarkerWhole(tester);
        // On a line of its own, below the role, same left edge.
        final Rect role = tester.getRect(
          find.byKey(const ValueKey<String>('palette-row-role-172')),
        );
        final Rect marker = tester.getRect(find.byType(BrandedCode));
        expect(marker.top, greaterThanOrEqualTo(role.bottom));
        expect(marker.left, role.left);
      },
    );

    testWidgets('the marker keeps the role line when it fits beside it', (
      WidgetTester tester,
    ) async {
      await _pumpRow(tester, width: 600, textScale: 1, color: deco);
      expectMarkerWhole(tester);
      final Rect role = tester.getRect(
        find.byKey(const ValueKey<String>('palette-row-role-172')),
      );
      final Rect marker = tester.getRect(find.byType(BrandedCode));
      // Same line: the marker starts after the role and is not lower.
      expect(marker.left, greaterThan(role.right));
      expect(marker.top, lessThan(role.bottom));
    });

    testWidgets('a pair wider than the old 120 dp cap stays on the role line '
        'when the row has the room', (WidgetTester tester) async {
      await _pumpRow(tester, width: 600, textScale: 2, color: deco);
      expectMarkerWhole(tester);
      final Rect role = tester.getRect(
        find.byKey(const ValueKey<String>('palette-row-role-172')),
      );
      final Rect marker = tester.getRect(find.byType(BrandedCode));
      expect(marker.width, greaterThan(InkGeometry.brandedCodeWidth));
      expect(marker.left, greaterThan(role.right));
      expect(marker.top, lessThan(role.bottom));
    });

    testWidgets('a long brand name is never cut, whatever the width', (
      WidgetTester tester,
    ) async {
      final MarkerColor noir = _marker(MarkerBrand.spectrumNoir, 'IG10');
      final String brandText = MarkerBrand.spectrumNoir.shortLabel;
      for (final double scale in <double>[1.5, 2]) {
        for (final double width in <double>[150, 200, 260, 320, 420]) {
          final String reason = 'width $width, x$scale';
          await _pumpRow(tester, width: width, textScale: scale, color: noir);
          expect(tester.takeException(), isNull, reason: reason);
          final RenderParagraph code = tester.renderObject<RenderParagraph>(
            find.text('IG10'),
          );
          expect(code.didExceedMaxLines, isFalse, reason: reason);
          // The brand is never cut: whole on one line, or, when the row is
          // narrower than the brand itself, wrapped onto a second line.
          final RenderParagraph brand = tester.renderObject<RenderParagraph>(
            find.text(brandText),
          );
          expect(brand.didExceedMaxLines, isFalse, reason: reason);
          final bool whole =
              brand.size.width >=
              brand.getMaxIntrinsicWidth(double.infinity) - 0.01;
          final double oneLine = 16 * scale;
          expect(
            whole || brand.size.height > oneLine * 1.5,
            isTrue,
            reason: reason,
          );
          if (width >= 320 && scale == 1.5) {
            expect(whole, isTrue, reason: reason);
          }
        }
      }
    });

    testWidgets('when even the pair is wider than the row, it wraps', (
      WidgetTester tester,
    ) async {
      final MarkerColor noir = _marker(MarkerBrand.spectrumNoir, 'IG10');
      await _pumpRow(tester, width: 120, textScale: 2, color: noir);
      expect(tester.takeException(), isNull);
      final RenderParagraph code = tester.renderObject<RenderParagraph>(
        find.text('IG10'),
      );
      expect(code.didExceedMaxLines, isFalse);
      expect(
        code.size.width,
        greaterThanOrEqualTo(code.getMaxIntrinsicWidth(double.infinity) - 0.01),
      );
      final RenderParagraph brand = tester.renderObject<RenderParagraph>(
        find.text(MarkerBrand.spectrumNoir.shortLabel),
      );
      expect(brand.didExceedMaxLines, isFalse);
      // The code sits under the brand rather than the brand being cut.
      expect(
        tester.getTopLeft(find.text('IG10')).dy,
        greaterThan(
          tester.getTopLeft(find.text(MarkerBrand.spectrumNoir.shortLabel)).dy,
        ),
      );
    });
  });

  testWidgets('a code wider than the row is scaled down, never clipped', (
    WidgetTester tester,
  ) async {
    // About 101 dp of code where the row leaves about 90 (padding and lock).
    final MarkerColor graphit = _marker(MarkerBrand.graphit, 'GI06180');
    await _pumpRow(tester, width: 150, textScale: 2, color: graphit);
    expect(tester.takeException(), isNull);
    final RenderParagraph code = tester.renderObject<RenderParagraph>(
      find.text('GI06180'),
    );
    expect(code.didExceedMaxLines, isFalse);
    // Laid out whole (a clipped code gets a box narrower than its glyphs)...
    expect(
      code.size.width,
      greaterThanOrEqualTo(code.getMaxIntrinsicWidth(double.infinity) - 0.01),
    );
    // ...and, as painted, inside the room the lock button leaves.
    final Rect row = tester.getRect(find.byType(PaletteSuggestionRow));
    final Rect text = tester.getRect(find.text('GI06180'));
    expect(text.left, greaterThanOrEqualTo(row.left));
    expect(text.right, lessThanOrEqualTo(row.right));
    // Fully inside the space the lock button leaves, not under it.
    expect(
      text.right,
      lessThanOrEqualTo(tester.getRect(find.byType(InkIconButton)).left + 0.01),
    );
  });

  testWidgets('a row of one brand has no marker line', (
    WidgetTester tester,
  ) async {
    await _pumpRow(
      tester,
      width: 250,
      textScale: 1.5,
      color: _marker(MarkerBrand.decoTime, '172'),
      mixed: false,
    );
    expect(find.byType(BrandedCode), findsNothing);
    expect(find.text('DecoTime'), findsNothing);
  });
}
