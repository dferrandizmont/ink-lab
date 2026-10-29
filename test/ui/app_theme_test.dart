import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';
import 'package:ink_lab/ui/widgets/section_card.dart';

import '../support/l10n.dart';

void main() {
  for (final (String name, ThemeData theme, InkColors c)
      in <(String, ThemeData, InkColors)>[
        ('light', AppTheme.light(), InkColors.light),
        ('dark', AppTheme.dark(), InkColors.dark),
      ]) {
    group('$name theme', () {
      test('maps the G roles onto the colour scheme', () {
        expect(theme.extension<InkColors>(), same(c));
        expect(theme.scaffoldBackgroundColor, c.bg);
        expect(theme.colorScheme.surface, c.surface);
        expect(theme.colorScheme.onSurface, c.fg);
        expect(theme.colorScheme.onSurfaceVariant, c.fg2);
        expect(theme.colorScheme.primary, c.action);
        expect(theme.colorScheme.onPrimary, c.onAction);
        expect(theme.colorScheme.primaryContainer, c.pale);
        expect(theme.colorScheme.outline, c.strong);
        expect(theme.colorScheme.outlineVariant, c.line);
      });

      test('is flat: no tint, no shadows, no elevation overlay', () {
        expect(theme.colorScheme.surfaceTint, Colors.transparent);
        expect(theme.applyElevationOverlayColor, isFalse);
        expect(theme.cardTheme.elevation, 0);
        expect(theme.navigationBarTheme.indicatorColor, c.pale);
        expect(theme.bottomSheetTheme.modalBarrierColor, c.scrim);
      });

      test('every text pair reaches 4.5:1', () {
        for (final Color back in <Color>[c.bg, c.surface, c.raised]) {
          expect(contrastRatio(c.fg, back), greaterThanOrEqualTo(4.5));
          expect(contrastRatio(c.fg2, back), greaterThanOrEqualTo(4.5));
        }
        expect(contrastRatio(c.action, c.pale), greaterThanOrEqualTo(4.5));
        expect(contrastRatio(c.onAction, c.action), greaterThanOrEqualTo(4.5));
        expect(contrastRatio(c.strong, c.surface), greaterThanOrEqualTo(3));
      });
    });
  }

  test('the type scale follows the spec', () {
    expect(AppTypography.title.fontFamily, 'Archivo');
    expect(AppTypography.title.fontFamilyFallback, contains('Inter'));
    expect(AppTypography.title.fontWeight, FontWeight.w800);
    expect(AppTypography.title.fontSize, 40);
    expect(AppTypography.title.letterSpacing, -1.2);
    expect(AppTypography.sheetTitle.fontSize, 26);
    expect(AppTypography.section.fontWeight, FontWeight.w600);
    expect(AppTypography.code.fontFamily, 'JetBrainsMono');
    expect(AppTypography.data.fontSize, 12);
    expect(
      AppTypography.data.fontFeatures,
      contains(const FontFeature.tabularFigures()),
    );
    expect(AppTypography.capsStyle.letterSpacing, closeTo(0.96, 0.001));

    final TextTheme textTheme = AppTheme.light().textTheme;
    expect(textTheme.displayLarge?.fontFamily, AppTypography.titleFontFamily);
    expect(textTheme.bodyMedium?.fontFamily, AppTypography.bodyFontFamily);
    expect(textTheme.bodyMedium?.fontSize, 14);
    expect(textTheme.bodyMedium?.color, InkColors.light.fg);
  });

  testWidgets('a palette strip renders every colour and label', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: testLocalizationsDelegates,
        supportedLocales: testSupportedLocales,
        theme: AppTheme.light(),
        home: const Scaffold(
          body: PaletteStrip(
            colors: <String>['#F08C6D', '#11161D', '#F6F8FB'],
            labels: <String>['coral', 'noir', 'day'],
            lockedIndex: 0,
          ),
        ),
      ),
    );

    expect(find.text('coral'), findsOneWidget);
    expect(find.text('noir'), findsOneWidget);
    expect(find.text('day'), findsOneWidget);
    expect(find.bySemanticsLabel('Base locked'), findsOneWidget);
  });

  testWidgets('a section card shows its title and content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: testLocalizationsDelegates,
        supportedLocales: testSupportedLocales,
        theme: AppTheme.light(),
        home: const Scaffold(
          body: SectionCard(
            title: 'Section',
            subtitle: 'Subtitle',
            child: Text('Body'),
          ),
        ),
      ),
    );

    expect(find.text('Section'), findsOneWidget);
    expect(find.text('Subtitle'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
  });
}
