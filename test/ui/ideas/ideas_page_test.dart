import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';

import 'ideas_test_support.dart';
import '../../support/l10n.dart';

void main() {
  testWidgets('renders the ideas browser with categories and presets', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);

    expect(find.byKey(IdeasPage.pageKey), findsOneWidget);
    expect(find.text(l10n.ideasTitle), findsOneWidget);
    expect(find.byKey(const ValueKey<String>('ideas-search')), findsOneWidget);
    // The Signature presets come first and are on screen.
    expect(find.text('Sticker Effect'), findsOneWidget);
    // Categories appear as chips and as group headers.
    expect(find.text('Signature'), findsWidgets);
    expect(
      find.byKey(const ValueKey<String>('ideas-category-all')),
      findsOneWidget,
    );
  });

  testWidgets('search narrows the preset list', (WidgetTester tester) async {
    await pumpIdeas(tester);

    await tester.enterText(
      find.byKey(const ValueKey<String>('ideas-search')),
      'neon',
    );
    await tester.pumpAndSettle();

    expect(find.text('Neon'), findsOneWidget);
    expect(find.text('Sticker Effect'), findsNothing);
  });

  testWidgets('a category chip filters the list', (WidgetTester tester) async {
    await pumpIdeas(tester);

    await tester.tap(
      find.byKey(const ValueKey<String>('ideas-category-atmosphere')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Galaxy'), findsOneWidget);
    expect(find.text('Sticker Effect'), findsNothing);
  });

  testWidgets('a palette-ready idea generates colors and applies them', (
    WidgetTester tester,
  ) async {
    addTearDown(() => paletteDraft.value = null);
    await pumpIdeas(tester);

    await tester.tap(
      find.byKey(const ValueKey<String>('ideas-preset-one_color')),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey<String>('ideas-generate-one_color')),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppTypography.caps(l10n.ideasHowToTitle)), findsOneWidget);
    expect(
      find.text(AppTypography.caps(l10n.ideasSuggestedColorsTitle)),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('ideas-apply-one_color')),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(const ValueKey<String>('ideas-apply-one_color')),
    );
    await tester.pump();

    expect(paletteDraft.value, isNotNull);
    expect(paletteDraft.value, isNotEmpty);
  });

  testWidgets('a guide-only idea shows the technique note, no palette', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);

    await tester.tap(
      find.byKey(const ValueKey<String>('ideas-preset-sticker_effect')),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey<String>('ideas-generate-sticker_effect')),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppTypography.caps(l10n.ideasHowToTitle)), findsOneWidget);
    expect(find.text(l10n.ideasGuideOnlyNote), findsOneWidget);
    expect(
      find.text(AppTypography.caps(l10n.ideasSuggestedColorsTitle)),
      findsNothing,
    );
  });

  testWidgets('a DecoTime idea without owned markers warns instead', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester, brand: MarkerBrand.decoTime);

    await tester.tap(
      find.byKey(const ValueKey<String>('ideas-preset-one_color')),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.ideasNoMarkersDecoTime), findsOneWidget);
  });
}
