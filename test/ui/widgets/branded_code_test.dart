import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/ui/pages/palette/palette_paint_order.dart';
import 'package:ink_lab/ui/pages/palette/palette_suggestion_row.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/branded_code.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

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

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  double width = 360,
  ThemeData? theme,
}) async {
  tester.view.physicalSize = Size(width, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: theme ?? AppTheme.light(),
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

double _fontSize(WidgetTester tester, String text) =>
    tester.widget<Text>(find.text(text)).style!.fontSize!;

void main() {
  setUpAll(loadAppFonts);

  test('every brand has a short name of at most eleven characters', () {
    final Set<String> seen = <String>{};
    for (final MarkerBrand brand in MarkerBrand.values) {
      expect(brand.shortLabel, isNotEmpty, reason: brand.id);
      expect(
        brand.shortLabel.length,
        lessThanOrEqualTo(11),
        reason: '${brand.id}: ${brand.shortLabel}',
      );
      expect(seen.add(brand.shortLabel), isTrue, reason: brand.shortLabel);
      // A brand whose name is short enough keeps it.
      if (brand.label.length <= 11) expect(brand.shortLabel, brand.label);
    }
  });

  group('BrandedCode', () {
    testWidgets('one brand: the bare code in the code type, nothing else', (
      tester,
    ) async {
      await _pump(
        tester,
        BrandedCode(
          marker: _marker(MarkerBrand.ohuhuOahu, 'BV04'),
          mixed: false,
        ),
      );
      expect(find.text('BV04'), findsOneWidget);
      expect(find.text('Ohuhu'), findsNothing);
      expect(_fontSize(tester, 'BV04'), AppTypography.code.fontSize);
      expect(find.byType(Row), findsNothing);
    });

    testWidgets('mixed: the short brand in fg2, then the code at full size', (
      tester,
    ) async {
      await _pump(
        tester,
        BrandedCode(
          marker: _marker(MarkerBrand.prismacolor, 'PM23'),
          mixed: true,
        ),
      );
      final Text brand = tester.widget<Text>(find.text('Prismacolor'));
      final Text code = tester.widget<Text>(find.text('PM23'));
      expect(brand.style!.fontSize, AppTypography.secondary.fontSize);
      expect(brand.style!.color, InkColors.light.fg2);
      expect(brand.overflow, TextOverflow.ellipsis);
      expect(code.style!.fontSize, AppTypography.code.fontSize);
      expect(code.style!.color, InkColors.light.fg);
      // Nothing is scaled down, and the pair keeps to its bounded width.
      expect(find.byType(FittedBox), findsNothing);
      expect(
        tester.getSize(find.byType(BrandedCode)).width,
        lessThanOrEqualTo(InkGeometry.brandedCodeWidth),
      );
      // The brand sits before the code, on the same baseline.
      expect(
        tester.getTopLeft(find.text('Prismacolor')).dx,
        lessThan(tester.getTopLeft(find.text('PM23')).dx),
      );
    });

    testWidgets('dense: caption beside data', (tester) async {
      await _pump(
        tester,
        BrandedCode(
          marker: _marker(MarkerBrand.decoTime, '91'),
          mixed: true,
          dense: true,
        ),
      );
      expect(_fontSize(tester, 'DecoTime'), AppTypography.caption.fontSize);
      expect(_fontSize(tester, '91'), AppTypography.data.fontSize);
    });

    testWidgets('in a narrow row the brand gives way, never the code', (
      tester,
    ) async {
      await _pump(
        tester,
        SizedBox(
          width: 90,
          child: Row(
            children: <Widget>[
              Flexible(
                child: BrandedCode(
                  marker: _marker(MarkerBrand.spectrumNoir, 'IG10'),
                  mixed: true,
                ),
              ),
            ],
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      final RenderParagraph code = tester.renderObject<RenderParagraph>(
        find.text('IG10'),
      );
      expect(code.didExceedMaxLines, isFalse);
      expect(code.size.width, greaterThan(0));
      final RenderParagraph brand = tester.renderObject<RenderParagraph>(
        find.text('Spectrum N.'),
      );
      expect(brand.size.width, lessThan(60));
    });

    testWidgets('at a very large text size the code is still whole', (
      tester,
    ) async {
      for (final bool dense in <bool>[false, true]) {
        await _pump(
          tester,
          Builder(
            builder: (BuildContext context) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(3)),
              child: BrandedCode(
                marker: _marker(MarkerBrand.spectrumNoir, 'BV0000'),
                mixed: true,
                dense: dense,
              ),
            ),
          ),
        );
        // No overflow: the room grew to the code instead of cutting it.
        expect(tester.takeException(), isNull, reason: 'dense: $dense');
        final RenderParagraph code = tester.renderObject<RenderParagraph>(
          find.text('BV0000'),
        );
        expect(code.didExceedMaxLines, isFalse);
        expect(
          code.size.width,
          greaterThanOrEqualTo(
            code.getMaxIntrinsicWidth(double.infinity) - 0.01,
          ),
          reason: 'dense: $dense',
        );
        final double whole = tester.getSize(find.byType(BrandedCode)).width;
        if (!dense) {
          // The code alone is wider than the usual room at this size...
          expect(code.size.width, greaterThan(InkGeometry.brandedCodeWidth));
          // ...so the widget takes what the code and its gap need, no more.
          expect(whole, greaterThan(InkGeometry.brandedCodeWidth));
          expect(whole, lessThanOrEqualTo(code.size.width + InkSpacing.s4 + 1));
        }
        // It ends where the widget ends: nothing of it is clipped.
        expect(
          tester.getRect(find.text('BV0000')).right,
          lessThanOrEqualTo(tester.getRect(find.byType(BrandedCode)).right),
        );
      }
    });

    testWidgets('at the usual text size the room is the fixed one', (
      tester,
    ) async {
      await _pump(
        tester,
        BrandedCode(
          marker: _marker(MarkerBrand.spectrumNoir, 'BV0000'),
          mixed: true,
        ),
      );
      expect(
        tester.getSize(find.byType(BrandedCode)).width,
        lessThanOrEqualTo(InkGeometry.brandedCodeWidth),
      );
    });
  });

  group('PaletteStrip labels', () {
    const List<String> colors = <String>[
      '#F08C6D',
      '#11161D',
      '#F6F8FB',
      '#336699',
      '#88AA33',
    ];
    const List<String> codes = <String>['BV04', 'PM23', '91', 'IG10', 'B08'];

    for (final size in [const Size(1280, 800), const Size(1376, 1032)]) {
      for (final mixed in [false, true]) {
        testWidgets(
          'tablet labels fit their natural height ($size, mixed=$mixed, 1.5x)',
          (tester) async {
            await _pump(
              tester,
              PaletteStrip(
                colors: colors,
                labels: codes,
                brandLabels: mixed
                    ? [
                        'Ohuhu',
                        'Prismacolor',
                        'DecoTime',
                        'Spectrum N.',
                        'Ohuhu',
                      ]
                    : null,
              ),
              width: size.width,
            );
            tester.view.physicalSize = size;
            tester.platformDispatcher.textScaleFactorTestValue = 1.5;
            addTearDown(
              tester.platformDispatcher.clearTextScaleFactorTestValue,
            );
            await tester.pumpAndSettle();
            final stripRect = tester.getRect(find.byType(PaletteStrip));
            for (final element
                in find
                    .descendant(
                      of: find.byType(PaletteStrip),
                      matching: find.byType(RichText),
                    )
                    .evaluate()) {
              final p = element.renderObject! as RenderParagraph;
              final painter = TextPainter(
                text: p.text,
                textDirection: p.textDirection,
                textScaler: p.textScaler,
              )..layout(maxWidth: p.size.width);
              expect(p.size.height, greaterThanOrEqualTo(painter.height));
              expect(p.didExceedMaxLines, isFalse);
              final rect = p.localToGlobal(Offset.zero) & p.size;
              expect(rect.bottom, lessThanOrEqualTo(stripRect.bottom));
              painter.dispose();
            }
            final codeHeight =
                1.5 * AppTypography.code.fontSize! * AppTypography.code.height!;
            final brandHeight = mixed
                ? 1.5 *
                      AppTypography.caption.fontSize! *
                      AppTypography.caption.height!
                : 0;
            expect(
              stripRect.height,
              closeTo(
                InkGeometry.paletteStripHeight +
                    InkSpacing.group +
                    codeHeight +
                    brandHeight,
                0.1,
              ),
            );
            expect(tester.takeException(), isNull);
          },
        );
      }
    }

    testWidgets('one brand: one line of codes, as tall as it always was', (
      tester,
    ) async {
      await _pump(tester, const PaletteStrip(colors: colors, labels: codes));
      expect(
        tester.getSize(find.byType(PaletteStrip)).height,
        InkGeometry.paletteStripHeight + InkSpacing.group + 22,
      );
      expect(_fontSize(tester, 'PM23'), AppTypography.code.fontSize);
    });

    testWidgets(
      'mixed at 360 dp: the brand on its own line, the code never scaled',
      (tester) async {
        await _pump(
          tester,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: InkSpacing.pageMargin),
            child: PaletteStrip(
              colors: colors,
              labels: codes,
              brandLabels: <String>[
                'Ohuhu',
                'Prismacolor',
                'DecoTime',
                'Spectrum N.',
                'Ohuhu',
              ],
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        expect(find.byType(FittedBox), findsNothing);
        // The label row grows by the caption line only.
        final double caption =
            AppTypography.caption.fontSize! * AppTypography.caption.height!;
        expect(
          tester.getSize(find.byType(PaletteStrip)).height,
          InkGeometry.paletteStripHeight + InkSpacing.group + 22 + caption,
        );
        for (final String code in codes) {
          expect(_fontSize(tester, code), AppTypography.code.fontSize);
          final RenderParagraph box = tester.renderObject<RenderParagraph>(
            find.text(code),
          );
          expect(box.didExceedMaxLines, isFalse, reason: code);
        }
        final Text brand = tester.widget<Text>(find.text('Prismacolor'));
        expect(brand.style!.fontSize, AppTypography.caption.fontSize);
        expect(brand.style!.color, InkColors.light.fg2);
        expect(brand.maxLines, 1);
        expect(brand.overflow, TextOverflow.ellipsis);
        // Each brand is over its own code.
        expect(
          tester.getBottomLeft(find.text('Prismacolor')).dy,
          lessThanOrEqualTo(tester.getTopLeft(find.text('PM23')).dy),
        );
        expect(
          tester.getCenter(find.text('Prismacolor')).dx,
          moreOrLessEquals(tester.getCenter(find.text('PM23')).dx, epsilon: 1),
        );
      },
    );

    testWidgets('mixed in the dark theme uses the dark tokens', (tester) async {
      await _pump(
        tester,
        const PaletteStrip(
          colors: colors,
          labels: codes,
          brandLabels: <String>['Ohuhu', 'Ohuhu', 'DecoTime', 'Ohuhu', 'Ohuhu'],
        ),
        theme: AppTheme.dark(),
      );
      expect(
        tester.widget<Text>(find.text('DecoTime')).style!.color,
        InkColors.dark.fg2,
      );
      expect(
        tester.widget<Text>(find.text('91')).style!.color,
        InkColors.dark.fg,
      );
    });
  });

  group('rows that name a marker of a mixed palette, 360 dp at 1.3x', () {
    Future<void> pumpRow(WidgetTester tester, Widget row) => _pump(
      tester,
      MediaQuery.withClampedTextScaling(
        minScaleFactor: 1.3,
        maxScaleFactor: 1.3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: InkSpacing.pageMargin,
          ),
          child: Card(child: row),
        ),
      ),
    );

    testWidgets(
      'a palette row: brand and code whole, at most one marker line taller',
      (tester) async {
        final MarkerColor marker = _marker(MarkerBrand.prismacolor, 'PM123');
        Widget row({required bool mixed}) => PaletteSuggestionRow(
          suggestion: PaletteSuggestion(color: marker, reason: 'Shadow'),
          role: 'Shadow',
          roleText: 'Step 2 · Deepest shadow',
          mixed: mixed,
          locked: false,
          last: true,
          onToggleLock: () {},
        );
        await pumpRow(tester, row(mixed: false));
        expect(tester.takeException(), isNull);
        final double single = tester
            .getSize(find.byType(PaletteSuggestionRow))
            .height;
        await pumpRow(tester, row(mixed: true));
        expect(tester.takeException(), isNull);
        // Beside this long role the whole marker does not fit: it goes under
        // the role, so the row grows by that one small line and nothing else.
        expect(
          tester.getSize(find.byType(PaletteSuggestionRow)).height,
          lessThanOrEqualTo(single + 16 * 1.3 + InkSpacing.s2 + 1),
        );
        final RenderParagraph code = tester.renderObject<RenderParagraph>(
          find.text('PM123'),
        );
        expect(code.didExceedMaxLines, isFalse);
        final RenderParagraph brand = tester.renderObject<RenderParagraph>(
          find.text('Prismacolor'),
        );
        expect(brand.didExceedMaxLines, isFalse);
      },
    );

    testWidgets('a paint-order row: the step text keeps most of the line', (
      tester,
    ) async {
      final MarkerColor marker = _marker(MarkerBrand.spectrumNoir, 'IG10');
      await pumpRow(
        tester,
        PaintStepRow(
          step: PlanStep(
            order: 1,
            zone: 'Shadow',
            code: 'Spectrum Noir IG10',
            name: 'Name IG10',
            tip: '',
            marker: marker,
          ),
          hex: marker.hex,
        ),
      );
      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byType(BrandedCode)).width,
        lessThanOrEqualTo(InkGeometry.brandedCodeWidth),
      );
      final RenderParagraph code = tester.renderObject<RenderParagraph>(
        find.text('IG10'),
      );
      expect(code.didExceedMaxLines, isFalse);
      // A palette of one brand draws the plain code, as always.
      await pumpRow(
        tester,
        PaintStepRow(
          step: const PlanStep(
            order: 1,
            zone: 'Shadow',
            code: 'IG10',
            name: 'Name IG10',
            tip: '',
          ),
          hex: marker.hex,
        ),
      );
      expect(find.byType(BrandedCode), findsNothing);
      expect(find.text('IG10'), findsOneWidget);
    });
  });

  test('the unknown-marker swatch follows the theme', () {
    expect(InkColors.light.unknownSwatchHex, '#D5D7D1');
    expect(InkColors.dark.unknownSwatchHex, '#363B36');
  });
}
