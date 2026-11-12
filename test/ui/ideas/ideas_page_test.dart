import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/ideas/idea_detail_sheet.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/branded_code.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';

import 'ideas_test_support.dart';
import '../../support/l10n.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// The keys of the step rows that show a marker in the open idea sheet.
List<String> _markerSteps(IdeaPreset preset) => <String>[
  for (final Element e
      in find
          .descendant(
            of: _key('ideas-detail-${preset.id}'),
            matching: find.byWidgetPredicate(
              (Widget w) =>
                  w.key is ValueKey<String> &&
                  (w.key! as ValueKey<String>).value.startsWith('ideas-step-'),
            ),
          )
          .evaluate())
    (e.widget.key! as ValueKey<String>).value,
];

void main() {
  testWidgets(
    'mixed Ideas use markers from both brands and label their codes',
    (tester) async {
      await pumpIdeas(
        tester,
        setup: (scope) async {
          await scope.settings.setOwnedMarkerCodes({
            'decotime:91',
            'decotime:92',
          });
          await scope.settings.setScope(BrandScope.mixedBrands);
        },
      );
      final featured = IdeasEngine.featuredFor(DateTime(2026, 10, 29));
      await tester.tap(_key('ideas-open-${featured.id}'));
      await tester.pumpAndSettle();
      final sheet = tester.widget<IdeaDetailSheet>(
        find.byType(IdeaDetailSheet),
      );
      expect(sheet.candidates.map((c) => c.brandId).toSet(), {
        'ohuhu_oahu',
        'decotime',
      });
      expect(
        sheet.candidates.where((c) => c.brandId == 'decotime'),
        hasLength(2),
      );
      final markers = _key('ideas-markers-${featured.id}');
      await tester.ensureVisible(markers);
      await tester.tap(markers);
      await tester.pumpAndSettle();
      // Each marker says its brand, drawn by the one shared widget: the
      // short brand name, then the code.
      final color = sheet.initial.palette.first.color;
      expect(
        tester
            .widgetList<BrandedCode>(find.byType(BrandedCode))
            .where((w) => w.mixed && w.marker.colorId == color.colorId),
        isNotEmpty,
      );
      expect(
        find.descendant(
          of: find.byType(BrandedCode),
          matching: find.text(MarkerBrand.fromId(color.brandId).shortLabel),
        ),
        findsWidgets,
      );
    },
  );
  // The real fonts: the summary wraps in full now, and the test font (one em
  // per glyph) would make it far longer than any language does.
  setUpAll(loadAppFonts);

  testWidgets('renders the intro, the idea of the day and the list', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);

    expect(find.byKey(IdeasPage.pageKey), findsOneWidget);
    // The page title and the first segment of the Ideas / Diary control.
    expect(find.text(l10n.ideasTitle), findsNWidgets(2));
    expect(find.text(l10n.ideasHeaderSubtitle), findsOneWidget);
    expect(_key('ideas-search'), findsOneWidget);
    final IdeaPreset featured = IdeasEngine.featuredFor(DateTime(2026, 10, 29));
    expect(_key('ideas-featured-${featured.id}'), findsOneWidget);
    expect(
      find.text(
        AppTypography.caps(
          '${l10n.ideasFeaturedLabel} · ${l10n.ideasMinutes(featured.minutes)}',
        ),
      ),
      findsOneWidget,
    );
    // The whole featured card is the way to its steps: no separate button.
    expect(_key('ideas-open-${featured.id}'), findsOneWidget);
    expect(find.text('Streak-free fill'), findsWidgets);
    for (final IdeaCategory c in IdeaCategory.values) {
      expect(_key('ideas-category-${c.name}'), findsOneWidget);
    }
    // Rows show difficulty and time instead of the old data-model badge; the
    // category is the heading of the section they sit in.
    expect(find.text(AppTypography.caps('Easy · 10 min')), findsWidgets);
  });

  testWidgets('search narrows the list and hides the idea of the day', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);

    await tester.enterText(_key('ideas-search'), 'neon');
    await tester.pumpAndSettle();

    expect(find.text('Neon sign'), findsOneWidget);
    expect(find.text('Streak-free fill'), findsNothing);
    expect(
      find.text(AppTypography.caps(l10n.ideasFeaturedLabel)),
      findsNothing,
    );
  });

  testWidgets('a category chip filters the list', (WidgetTester tester) async {
    await pumpIdeas(tester);

    await tester.tap(_key('ideas-category-mood'));
    await tester.pumpAndSettle();

    expect(find.text('Galaxy'), findsOneWidget);
    expect(find.text('Streak-free fill'), findsNothing);
  });

  testWidgets('an idea opens its detail with steps tied to your markers', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);
    final IdeaPreset preset = IdeasEngine.byId('one_color')!;

    await tester.tap(_key('ideas-preset-one_color'));
    await tester.pumpAndSettle();

    expect(_key('ideas-detail-one_color'), findsOneWidget);
    // What you practise, what to draw, the tip and the materials are folded
    // behind "More details".
    expect(_key('ideas-details-one_color'), findsOneWidget);
    expect(
      find.text(AppTypography.caps(l10n.ideasPracticeTitle)),
      findsNothing,
    );
    await tester.tap(_key('ideas-details-one_color'));
    await tester.pumpAndSettle();
    for (final String title in <String>[
      l10n.ideasPracticeTitle,
      l10n.ideasSubjectTitle,
      l10n.ideasTipTitle,
      l10n.ideasMaterialsTitle,
    ]) {
      expect(find.text(AppTypography.caps(title)), findsOneWidget);
    }
    expect(find.text(l10n.ideaTipText('one_color')), findsOneWidget);

    // The steps are on view; their roles and the named markers are folded.
    expect(find.text(AppTypography.caps(l10n.ideasStepsTitle)), findsOneWidget);
    final int bound = preset.stepRoles.where((r) => r != null).length;
    expect(_markerSteps(preset).length, bound);
    expect(
      find.text(AppTypography.caps(l10n.roleLabel(IdeaRoles.light))),
      findsNothing,
    );
    await tester.tap(_key('ideas-markers-one_color'));
    await tester.pumpAndSettle();
    expect(
      find.text(AppTypography.caps(l10n.roleLabel(IdeaRoles.light))),
      findsOneWidget,
    );

    // "Other markers" lives in the "⋯" menu and picks other markers.
    final List<String> before = _markerSteps(preset);
    var after = before;
    for (var i = 0; i < 4 && after.join() == before.join(); i++) {
      await tester.ensureVisible(find.byTooltip(l10n.commonMoreActions));
      await tester.tap(find.byTooltip(l10n.commonMoreActions));
      await tester.pumpAndSettle();
      await tester.tap(_key('ideas-other-one_color'));
      await tester.pumpAndSettle();
      after = _markerSteps(preset);
    }
    expect(after, isNot(before));
  });

  testWidgets(
    'the sheet opens a little above half height with "Use in Palette" on view',
    (WidgetTester tester) async {
      await pumpIdeas(tester, size: const Size(360, 740));
      final IdeaPreset featured = IdeasEngine.featuredFor(
        DateTime(2026, 10, 29),
      );

      await tester.tap(_key('ideas-open-${featured.id}'));
      await tester.pumpAndSettle();

      final Rect sheet = tester.getRect(find.byType(InkSheet));
      // 60 % of 740.
      expect(
        sheet.top,
        moreOrLessEquals(740 * (1 - ideaSheetHeight), epsilon: 2),
      );
      // The primary action is on view without scrolling.
      final Finder apply = _key('ideas-apply-${featured.id}');
      expect(apply, findsOneWidget);
      final Rect button = tester.getRect(apply);
      expect(button.bottom, lessThanOrEqualTo(sheet.bottom + 0.5));
      expect(button.height, greaterThanOrEqualTo(InkGeometry.target));
      // The "⋯" menu offers the diary and other markers.
      await tester.tap(find.byTooltip(l10n.commonMoreActions));
      await tester.pumpAndSettle();
      expect(find.text(l10n.diaryAdd), findsOneWidget);
      expect(find.text(l10n.ideasOtherMarkersButton), findsOneWidget);
      expect(_key('ideas-other-${featured.id}'), findsOneWidget);
    },
  );

  testWidgets('"Use in Palette" hands over roles, opens Palette and confirms', (
    WidgetTester tester,
  ) async {
    addTearDown(() => paletteDraft.value = null);
    var opened = 0;
    await pumpIdeas(tester, onOpenPalette: () => opened++);

    await tester.tap(_key('ideas-preset-three_marker_blend'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(_key('ideas-apply-three_marker_blend'));
    await tester.tap(_key('ideas-apply-three_marker_blend'));
    await tester.pumpAndSettle();

    final PaletteDraft? draft = paletteDraft.value;
    expect(draft, isNotNull);
    expect(draft!.title, 'Three-marker blend');
    expect(draft.suggestions.map((s) => s.role), <String>[
      IdeaRoles.light,
      IdeaRoles.base,
      IdeaRoles.shadow,
    ]);
    expect(
      draft.suggestions.map((s) => s.reason),
      draft.suggestions.map((s) => IdeaRoles.reasonFor(s.role!)),
    );
    expect(opened, 1);
    expect(_key('ideas-detail-three_marker_blend'), findsNothing);
    expect(
      find.text(l10n.ideasPaletteSent('Three-marker blend')),
      findsOneWidget,
    );
  });

  testWidgets('an exercise without a palette says so, with no apply button', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);

    await showIdeaRow(tester, 'swatch_chart');
    await tester.tap(_key('ideas-preset-swatch_chart'));
    await tester.pumpAndSettle();

    expect(find.text(l10n.ideasGuideOnlyNote), findsOneWidget);
    expect(_key('ideas-apply-swatch_chart'), findsNothing);
    expect(find.text(AppTypography.caps(l10n.ideasStepsTitle)), findsOneWidget);
  });

  testWidgets('a DecoTime idea without a collection asks for the markers, '
      'instead of using the whole range', (WidgetTester tester) async {
    await pumpIdeas(tester, brand: MarkerBrand.decoTime);

    await tester.tap(_key('ideas-preset-one_color'));
    await tester.pumpAndSettle();

    // No palette out of the brand's range, and no "Your markers" list.
    expect(_key('ideas-apply-one_color'), findsNothing);
    expect(find.text(AppTypography.caps(l10n.ideasMarkersTitle)), findsNothing);
    expect(find.text(l10n.missingMarkersHint), findsOneWidget);
    expect(_key('ideas-open-collection-one_color'), findsOneWidget);
  });

  testWidgets('the idea sheet opens the collection, where they are ticked', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester, brand: MarkerBrand.decoTime);

    await tester.tap(_key('ideas-preset-one_color'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(_key('ideas-open-collection-one_color'));
    await tester.tap(_key('ideas-open-collection-one_color'));
    await tester.pumpAndSettle();

    // The collection is open, and the sheet is closed.
    expect(find.byKey(CollectionPage.pageKey), findsOneWidget);
    expect(_key('ideas-detail-one_color'), findsNothing);
  });

  testWidgets('with every marker dried out: the sheet says so', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(
      tester,
      setup: (AppScope scope) async {
        await scope.settings.setCollection(
          AppSettings(extraMarkerIds: const <String>{'B08'}),
        );
        await scope.dried.add('ohuhu_oahu:B08');
      },
    );

    await tester.tap(_key('ideas-preset-one_color'));
    await tester.pumpAndSettle();

    // The collection is not empty: the sheet does not ask for markers the
    // user already has, it says they ran dry.
    expect(find.text(l10n.allMarkersDried), findsOneWidget);
    expect(find.text(l10n.missingMarkersHint), findsNothing);
  });
}
