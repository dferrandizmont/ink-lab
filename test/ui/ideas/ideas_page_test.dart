import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';

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
  testWidgets('renders the intro, the idea of the day and the list', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);

    expect(find.byKey(IdeasPage.pageKey), findsOneWidget);
    expect(find.text(l10n.ideasTitle), findsOneWidget);
    expect(find.text(l10n.ideasHeaderSubtitle), findsOneWidget);
    expect(_key('ideas-search'), findsOneWidget);
    final IdeaPreset featured = IdeasEngine.featuredFor(DateTime(2026, 10, 29));
    expect(_key('ideas-featured-${featured.id}'), findsOneWidget);
    expect(
      find.text(AppTypography.caps(l10n.ideasFeaturedLabel)),
      findsOneWidget,
    );
    expect(find.text('Streak-free fill'), findsWidgets);
    for (final IdeaCategory c in IdeaCategory.values) {
      expect(_key('ideas-category-${c.name}'), findsOneWidget);
    }
    // Rows show difficulty and time instead of the old data-model badge.
    expect(
      find.text(AppTypography.caps('Techniques · Easy · 10 min')),
      findsWidgets,
    );
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
    for (final String title in <String>[
      l10n.ideasPracticeTitle,
      l10n.ideasSubjectTitle,
      l10n.ideasMarkersTitle,
      l10n.ideasStepsTitle,
      l10n.ideasTipTitle,
      l10n.ideasMaterialsTitle,
    ]) {
      expect(find.text(AppTypography.caps(title)), findsOneWidget);
    }
    expect(find.text(l10n.ideaTipText('one_color')), findsOneWidget);
    // Every step that uses a marker shows its code.
    final int bound = preset.stepRoles.where((r) => r != null).length;
    expect(_markerSteps(preset).length, bound);
    expect(
      find.text(AppTypography.caps(l10n.roleLabel(IdeaRoles.light))),
      findsOneWidget,
    );

    // "Other markers" picks other markers.
    final List<String> before = _markerSteps(preset);
    var after = before;
    for (var i = 0; i < 4 && after.join() == before.join(); i++) {
      await tester.ensureVisible(_key('ideas-other-one_color'));
      await tester.tap(_key('ideas-other-one_color'));
      await tester.pumpAndSettle();
      after = _markerSteps(preset);
    }
    expect(after, isNot(before));
  });

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

    await tester.tap(_key('ideas-preset-swatch_chart'));
    await tester.pumpAndSettle();

    expect(find.text(l10n.ideasGuideOnlyNote), findsOneWidget);
    expect(_key('ideas-apply-swatch_chart'), findsNothing);
    expect(find.text(AppTypography.caps(l10n.ideasStepsTitle)), findsOneWidget);
  });

  testWidgets(
    'a DecoTime idea without a collection uses the whole range like Ohuhu',
    (WidgetTester tester) async {
      await pumpIdeas(tester, brand: MarkerBrand.decoTime);

      await tester.tap(_key('ideas-preset-one_color'));
      await tester.pumpAndSettle();

      expect(find.text(l10n.ideasNoMarkersDecoTime), findsNothing);
      expect(_key('ideas-apply-one_color'), findsOneWidget);
    },
  );
}
