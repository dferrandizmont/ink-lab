import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';

import '../support/l10n.dart';
import 'ideas/ideas_test_support.dart';

Widget _row({
  required bool fadeEnds,
  int chips = 6,
  double width = 220,
  TextDirection? direction,
  bool dark = false,
  bool noAnimations = false,
  double textScale = 1,
}) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: testLocalizationsDelegates,
  supportedLocales: testSupportedLocales,
  theme: dark ? AppTheme.dark() : AppTheme.light(),
  builder: (BuildContext context, Widget? child) {
    Widget app = MediaQuery(
      data: MediaQuery.of(context).copyWith(
        disableAnimations: noAnimations,
        textScaler: TextScaler.linear(textScale),
      ),
      child: child!,
    );
    if (direction != null) {
      app = Directionality(textDirection: direction, child: app);
    }
    return app;
  },
  home: Scaffold(
    body: SizedBox(
      width: width,
      child: InkChipRow(
        fadeEnds: fadeEnds,
        children: <Widget>[
          for (int i = 0; i < chips; i++)
            InkChip(
              label: 'Chip number $i',
              selected: false,
              onSelected: (_) {},
            ),
        ],
      ),
    ),
  ),
);

Finder _fade() => find.descendant(
  of: find.byType(InkChipRow),
  matching: find.byType(ShaderMask),
);

void main() {
  setUpAll(loadAppFonts);

  testWidgets('a scrolling chip row can fade its ends to show there is more', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: true));
    await tester.pumpAndSettle();
    expect(_fade(), findsOneWidget);

    // Scrolling to the far end and back does not throw (the fade follows).
    await tester.drag(find.byType(InkChipRow), const Offset(-2000, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(InkChipRow), const Offset(2000, 0));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('the fade is opt-in: a plain row has none', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: false));
    await tester.pumpAndSettle();
    expect(_fade(), findsNothing);
  });

  testWidgets('the idea categories row fades its end on a phone', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester, size: const Size(360, 740));
    final Finder row = find.descendant(
      of: find.byType(IdeasPage),
      matching: find.byType(InkChipRow),
    );
    expect(row, findsWidgets);
    expect(
      find.descendant(of: row.first, matching: find.byType(ShaderMask)),
      findsOneWidget,
    );
  });

  double hint(WidgetTester tester, Key key) =>
      tester.widget<AnimatedOpacity>(find.byKey(key)).opacity;

  testWidgets('a row that overflows shows the chevron at its end only', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: true));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintEndKey), 1);
    expect(hint(tester, chipRowHintStartKey), 0);
  });

  testWidgets('a row that fits shows no chevron', (WidgetTester tester) async {
    await tester.pumpWidget(_row(fadeEnds: true, chips: 1, width: 360));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintEndKey), 0);
    expect(hint(tester, chipRowHintStartKey), 0);
  });

  testWidgets('scrolled to the end, the chevron moves to the start', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: true));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(InkChipRow), const Offset(-2000, 0));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintEndKey), 0);
    expect(hint(tester, chipRowHintStartKey), 1);

    await tester.drag(find.byType(InkChipRow), const Offset(2000, 0));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintEndKey), 1);
    expect(hint(tester, chipRowHintStartKey), 0);
  });

  bool flipped(WidgetTester tester, Key key) {
    final Transform t = tester.widget<Transform>(
      find.descendant(of: find.byKey(key), matching: find.byType(Transform)),
    );
    return t.transform.storage[0] == -1;
  }

  testWidgets('left to right: end chevron at the right edge, pointing right', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: true));
    await tester.pumpAndSettle();
    final Rect row = tester.getRect(find.byType(InkChipRow));
    final Rect end = tester.getRect(find.byKey(chipRowHintEndKey));
    final Rect start = tester.getRect(find.byKey(chipRowHintStartKey));
    expect(row.right - end.right, 6);
    expect(start.left - row.left, 6);
    expect(
      find.descendant(
        of: find.byKey(chipRowHintEndKey),
        matching: find.byType(Transform),
      ),
      findsNothing,
    );
    expect(flipped(tester, chipRowHintStartKey), isTrue);
  });

  testWidgets('right to left mirrors the chevrons: sides and direction', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: true, direction: TextDirection.rtl));
    await tester.pumpAndSettle();
    final Rect row = tester.getRect(find.byType(InkChipRow));
    final Rect end = tester.getRect(find.byKey(chipRowHintEndKey));
    final Rect start = tester.getRect(find.byKey(chipRowHintStartKey));
    // The end of the row is on the left, the start on the right.
    expect(end.left - row.left, 6);
    expect(row.right - start.right, 6);
    // The end chevron points left (flipped), the start one right (not).
    expect(flipped(tester, chipRowHintEndKey), isTrue);
    expect(
      find.descendant(
        of: find.byKey(chipRowHintStartKey),
        matching: find.byType(Transform),
      ),
      findsNothing,
    );
    expect(hint(tester, chipRowHintEndKey), 1);
  });

  testWidgets('the hint takes no touches and is not announced', (
    WidgetTester tester,
  ) async {
    int? tapped;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: testLocalizationsDelegates,
        supportedLocales: testSupportedLocales,
        theme: AppTheme.light(),
        home: Scaffold(
          body: SizedBox(
            width: 220,
            child: InkChipRow(
              fadeEnds: true,
              children: <Widget>[
                for (int i = 0; i < 6; i++)
                  InkChip(
                    label: 'Chip number $i',
                    selected: false,
                    onSelected: (_) => tapped = i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final Finder hintBox = find.ancestor(
      of: find.byKey(chipRowHintEndKey),
      matching: find.byType(IgnorePointer),
    );
    expect(hintBox, findsWidgets);
    expect(
      find.ancestor(
        of: find.byKey(chipRowHintEndKey),
        matching: find.byType(ExcludeSemantics),
      ),
      findsWidgets,
    );
    // A tap on the chip under the end edge still reaches the chip.
    final Rect row = tester.getRect(find.byType(InkChipRow));
    await tester.tapAt(Offset(row.right - 14, row.center.dy));
    expect(tapped, isNotNull);
  });

  for (final bool dark in <bool>[false, true]) {
    testWidgets('the fade and chevron change no size (dark: $dark)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_row(fadeEnds: false, dark: dark));
      await tester.pumpAndSettle();
      final Size plain = tester.getSize(find.byType(InkChipRow));
      final Rect chip = tester.getRect(find.text('Chip number 0'));

      await tester.pumpWidget(_row(fadeEnds: true, dark: dark));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(InkChipRow)), plain);
      expect(tester.getRect(find.text('Chip number 0')), chip);

      await tester.drag(find.byType(InkChipRow), const Offset(-2000, 0));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(InkChipRow)), plain);
    });
  }

  testWidgets('a very narrow row keeps the fade but drops the chevrons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: true, width: 120));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintEndKey), 0);
    // Both edges active, scrolled to the middle.
    await tester.drag(find.byType(InkChipRow), const Offset(-60, 0));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintEndKey), 0);
    expect(hint(tester, chipRowHintStartKey), 0);
    expect(tester.takeException(), isNull);

    // A little wider, the clear zone holds the chevron again.
    await tester.pumpWidget(_row(fadeEnds: true, width: 140));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(InkChipRow), const Offset(-60, 0));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintEndKey), 1);
    expect(hint(tester, chipRowHintStartKey), 1);
  });

  testWidgets('shrinking to a narrow row hides the chevron at once', (
    WidgetTester tester,
  ) async {
    double painted(Key key) => tester
        .widget<FadeTransition>(
          find.descendant(
            of: find.byKey(key),
            matching: find.byType(FadeTransition),
          ),
        )
        .opacity
        .value;

    await tester.pumpWidget(_row(fadeEnds: true, width: 140));
    await tester.pumpAndSettle();
    expect(painted(chipRowHintEndKey), 1);

    await tester.pumpWidget(_row(fadeEnds: true, width: 90));
    await tester.pump();
    expect(painted(chipRowHintEndKey), 0);
    expect(tester.takeException(), isNull);
  });

  int nodes(SemanticsNode n) {
    int count = 1;
    n.visitChildren((SemanticsNode c) {
      count += nodes(c);
      return true;
    });
    return count;
  }

  testWidgets('the fade adds no semantics: labels, actions, nodes equal', (
    WidgetTester tester,
  ) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    Future<(int, List<(String, int)>)> snapshot(bool fade) async {
      await tester.pumpWidget(_row(fadeEnds: fade));
      await tester.pumpAndSettle();
      final List<(String, int)> chips = <(String, int)>[];
      for (int i = 0; i < 2; i++) {
        final SemanticsNode n = tester.getSemantics(
          find.text('Chip number $i'),
        );
        final SemanticsData d = n.getSemanticsData();
        chips.add((d.label, d.actions));
        expect(d.hasAction(SemanticsAction.tap), isTrue);
      }
      return (nodes(tester.getSemantics(find.byType(InkChipRow))), chips);
    }

    final (int, List<(String, int)>) plain = await snapshot(false);
    final (int, List<(String, int)>) faded = await snapshot(true);
    expect(faded.$1, plain.$1);
    expect(faded.$2, plain.$2);
    expect(faded.$2.first.$1, contains('Chip number 0'));
    handle.dispose();
  });

  testWidgets('content that shrinks after scrolling to the end hides both', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: true));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(InkChipRow), const Offset(-2000, 0));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintStartKey), 1);

    await tester.pumpWidget(_row(fadeEnds: true, chips: 1));
    await tester.pumpAndSettle();
    expect(hint(tester, chipRowHintStartKey), 0);
    expect(hint(tester, chipRowHintEndKey), 0);
  });

  testWidgets('reduce motion switches the chevron without a fade', (
    WidgetTester tester,
  ) async {
    AnimatedOpacity end() =>
        tester.widget<AnimatedOpacity>(find.byKey(chipRowHintEndKey));

    await tester.pumpWidget(_row(fadeEnds: true));
    await tester.pumpAndSettle();
    expect(end().duration, const Duration(milliseconds: 150));

    await tester.pumpWidget(_row(fadeEnds: true, noAnimations: true));
    await tester.pumpAndSettle();
    expect(end().duration, Duration.zero);
    await tester.drag(find.byType(InkChipRow), const Offset(-2000, 0));
    await tester.pump();
    expect(end().opacity, 0);
    expect(end().duration, Duration.zero);
    expect(
      tester.widget<AnimatedOpacity>(find.byKey(chipRowHintStartKey)).opacity,
      1,
    );
  });

  testWidgets('a large text scale still shows the hint and moves nothing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_row(fadeEnds: false, textScale: 2));
    await tester.pumpAndSettle();
    final Size plain = tester.getSize(find.byType(InkChipRow));
    final Rect chip = tester.getRect(find.text('Chip number 0'));

    await tester.pumpWidget(_row(fadeEnds: true, textScale: 2));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(InkChipRow)), plain);
    expect(tester.getRect(find.text('Chip number 0')), chip);
    expect(hint(tester, chipRowHintEndKey), 1);
    expect(tester.takeException(), isNull);
  });
}
