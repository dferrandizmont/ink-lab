import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/empty_state.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_disclosure.dart';
import 'package:ink_lab/ui/widgets/ink_overflow_menu.dart';
import 'package:ink_lab/ui/widgets/ink_search_field.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';
import 'package:ink_lab/ui/widgets/ink_switch.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';
import 'package:ink_lab/ui/widgets/swatch_list_tile.dart';

import '../support/l10n.dart';
import '../support/layout_stability.dart';

Future<void> pumpIn(
  WidgetTester tester,
  Widget child, {
  bool dark = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(body: Center(child: child)),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('chips: 44 hit, pale when on, toggles', (
    WidgetTester tester,
  ) async {
    bool on = false;
    await pumpIn(
      tester,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => InkChip(
          label: 'Owned',
          icon: InkIcons.filterLines,
          selected: on,
          onSelected: (bool v) => setState(() => on = v),
        ),
      ),
    );
    expect(tester.getSize(find.byType(InkChip)).height, 44);
    await tester.tap(find.text('Owned'));
    await tester.pumpAndSettle();
    expect(on, isTrue);
    final Text label = tester.widget(find.text('Owned'));
    expect(label.style?.color, InkColors.light.action);
  });

  testWidgets('segmented: radio semantics and action fill', (
    WidgetTester tester,
  ) async {
    int size = 5;
    await pumpIn(
      tester,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
            InkSegmented<int>(
              numeric: true,
              selected: size,
              onChanged: (int v) => setState(() => size = v),
              segments: const <InkSegment<int>>[
                InkSegment<int>(value: 3, label: '3'),
                InkSegment<int>(value: 4, label: '4'),
                InkSegment<int>(value: 5, label: '5'),
              ],
            ),
      ),
      dark: true,
    );
    expect(tester.getSize(find.byType(InkSegmented<int>)).height, 48);
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    expect(size, 3);
    final Text three = tester.widget(find.text('3'));
    expect(three.style?.color, InkColors.dark.onAction);
  });

  testWidgets('switch toggles and buttons are 44 high pills', (
    WidgetTester tester,
  ) async {
    bool value = false;
    int pressed = 0;
    await pumpIn(
      tester,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkSwitch(
              value: value,
              semanticLabel: 'Suggest with AI',
              onChanged: (bool v) => setState(() => value = v),
            ),
            InkButton(
              label: 'Save palette',
              icon: InkIcons.plus,
              onPressed: () => pressed++,
            ),
            InkButton.secondary(
              label: 'Suggest with AI',
              tag: 'Off',
              onPressed: () {},
            ),
            InkIconButton(
              icon: InkIcons.star,
              tooltip: 'Favourite',
              outlined: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
    await tester.tap(find.byType(InkSwitch));
    await tester.pumpAndSettle();
    expect(value, isTrue);
    await tester.tap(find.text('Save palette'));
    expect(pressed, 1);
    expect(tester.getSize(find.byType(FilledButton)).height, 48);
    expect(find.text('OFF'), findsOneWidget);
    expect(tester.getSize(find.byType(IconButton)).width, 44);
  });

  testWidgets('search field, header, list row and empty state render', (
    WidgetTester tester,
  ) async {
    await pumpIn(
      tester,
      const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkPageHeader(
              title: 'Swatches',
              subtitle: 'Ohuhu Oahu · Classic 160',
              trailing: '160 of 321',
            ),
            InkSearchField(hintText: 'Code, name, hex or old code'),
            SwatchListTile(
              hex: '2d6e9c',
              code: 'B114',
              name: 'Cerulean Blue',
              owned: true,
            ),
            EmptyState(
              title: 'No markers match',
              message: 'Try another search.',
              actionLabel: 'Clear filters',
              onAction: _noop,
            ),
          ],
        ),
      ),
    );
    expect(find.text('Swatches'), findsOneWidget);
    expect(find.text('160 of 321'), findsOneWidget);
    expect(tester.getSize(find.byType(InkSearchField)).height, 48);
    expect(find.text('#2D6E9C'), findsOneWidget);
    expect(find.text('Clear filters'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'B1');
    await tester.pump();
    expect(find.byTooltip('Clear search'), findsOneWidget);
  });

  testWidgets('the sheet has a grabber, a close button and the scrim', (
    WidgetTester tester,
  ) async {
    await pumpIn(
      tester,
      Builder(
        builder: (BuildContext context) => TextButton(
          onPressed: () => showInkSheet<void>(
            context: context,
            builder: (_) =>
                const InkDefinitionRow(label: 'In packs', value: 'Classic 160'),
          ),
          child: const Text('Open'),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('IN PACKS'), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.text('IN PACKS'), findsNothing);
  });

  for (final double bar in <double>[48, 24]) {
    testWidgets('the sheet keeps its content above a ${bar.toInt()} dp '
        'navigation bar', (WidgetTester tester) async {
      final double ratio = tester.view.devicePixelRatio;
      tester.view.padding = FakeViewPadding(bottom: bar * ratio);
      tester.view.viewPadding = FakeViewPadding(bottom: bar * ratio);
      addTearDown(tester.view.resetPadding);
      addTearDown(tester.view.resetViewPadding);
      const Key last = ValueKey<String>('last row');
      await pumpIn(
        tester,
        Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => showInkSheet<void>(
              context: context,
              builder: (_) => const SizedBox(key: last, height: 40),
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      final double screen = tester.view.physicalSize.height / ratio;
      expect(
        tester.getRect(find.byKey(last)).bottom,
        lessThanOrEqualTo(screen - bar - InkSpacing.sheet),
      );
      // The sheet itself still reaches the bottom edge, under the bar.
      expect(tester.getRect(find.byType(InkSheet)).bottom, screen);
    });
  }

  _t0Tests();
}

void _noop() {}

// ---------------------------------------------------------------------------
// T0 · common base of the 0.9 UI review: overflow menu, draggable sheet,
// quality text, disclosure slots, header action.
// ---------------------------------------------------------------------------

const Key _rowsKey = ValueKey<String>('rows');

/// Pumps a button that opens a [showInkDraggableSheet] with 40 rows on a
/// 400 x 800 phone, then opens it.
Future<void> _openDraggable(
  WidgetTester tester, {
  bool still = false,
  DraggableScrollableController? controller,
  List<Widget> actions = const <Widget>[],
  bool dark = false,
}) async {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      builder: still
          ? (BuildContext context, Widget? child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(disableAnimations: true),
              child: child!,
            )
          : null,
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => showInkDraggableSheet<void>(
              context: context,
              controller: controller,
              actions: actions,
              builder: (BuildContext context, ScrollController scroll) =>
                  ListView(
                    key: _rowsKey,
                    controller: scroll,
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      for (int i = 0; i < 40; i++)
                        SizedBox(height: 56, child: Text('Row $i')),
                    ],
                  ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

double _sheetTop(WidgetTester tester) =>
    tester.getTopLeft(find.byType(InkSheet)).dy;

Offset _grabber(WidgetTester tester) =>
    tester.getTopLeft(find.byType(InkSheet)) + const Offset(100, 8);

void _t0Tests() {
  group('InkOverflowMenu', () {
    Future<void> pumpMenu(
      WidgetTester tester,
      List<InkMenuItem> items, {
      bool dark = false,
    }) => pumpIn(
      tester,
      Align(
        alignment: Alignment.topRight,
        child: InkOverflowMenu(items: items),
      ),
      dark: dark,
    );

    testWidgets('opens, calls onSelected once and closes', (
      WidgetTester tester,
    ) async {
      final List<String> picked = <String>[];
      await pumpMenu(tester, <InkMenuItem>[
        InkMenuItem(
          key: const ValueKey<String>('item-a'),
          label: 'Copy hex',
          icon: InkIcons.copy,
          onSelected: () => picked.add('a'),
        ),
        InkMenuItem(label: 'Delete', onSelected: () => picked.add('b')),
      ]);
      expect(find.byTooltip('More actions'), findsOneWidget);
      expect(find.text('Copy hex'), findsNothing);
      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();
      expect(find.text('Copy hex'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      // The item key reaches the PopupMenuItem.
      expect(
        tester.widget(find.byKey(const ValueKey<String>('item-a'))),
        isA<PopupMenuItem<int>>(),
      );
      await tester.tap(find.byKey(const ValueKey<String>('item-a')));
      await tester.pumpAndSettle();
      expect(picked, <String>['a']);
      expect(find.text('Delete'), findsNothing);
    });

    testWidgets('dismissing the menu calls nothing', (
      WidgetTester tester,
    ) async {
      int calls = 0;
      await pumpMenu(tester, <InkMenuItem>[
        InkMenuItem(label: 'One', onSelected: () => calls++),
      ]);
      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(5, 590));
      await tester.pumpAndSettle();
      expect(find.text('One'), findsNothing);
      expect(calls, 0);
    });

    testWidgets('the button is 44 and every entry is at least 48 high', (
      WidgetTester tester,
    ) async {
      // Real font metrics: the test font is one em wide per glyph.
      await loadAppFonts();
      await pumpMenu(tester, <InkMenuItem>[
        InkMenuItem(label: 'Short', onSelected: () {}),
        InkMenuItem(
          label: 'Mark as dry, so it is left out of every new palette',
          icon: InkIcons.droplet,
          onSelected: () {},
        ),
      ]);
      expect(tester.getSize(find.byType(IconButton)), const Size(44, 44));
      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();
      final Finder entries = find.byType(PopupMenuItem<int>);
      expect(entries, findsNWidgets(2));
      for (final Element e in entries.evaluate()) {
        expect(
          (e.renderObject! as RenderBox).size.height,
          greaterThanOrEqualTo(48),
        );
      }
      // A long label wraps (two lines) and is never cut.
      final RenderParagraph p = tester.renderObject(
        find.textContaining('Mark as dry'),
      );
      expect(p.didExceedMaxLines, isFalse);
      expect(p.size.height, lessThanOrEqualTo(2 * 24.0));
      expect(tester.takeException(), isNull);
    });

    testWidgets('destructive entries use the error colour, in both themes', (
      WidgetTester tester,
    ) async {
      for (final bool dark in <bool>[false, true]) {
        await pumpMenu(tester, <InkMenuItem>[
          InkMenuItem(label: 'Keep', onSelected: () {}),
          InkMenuItem(
            label: 'Remove',
            icon: InkIcons.trash2,
            destructive: true,
            onSelected: () {},
          ),
        ], dark: dark);
        await tester.tap(find.byTooltip('More actions'));
        await tester.pumpAndSettle();
        final InkColors ink = dark ? InkColors.dark : InkColors.light;
        expect(
          tester.widget<Text>(find.text('Remove')).style?.color,
          ink.error,
        );
        expect(tester.widget<Text>(find.text('Keep')).style?.color, ink.fg);
        await tester.tapAt(const Offset(5, 590));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('with no items nothing is drawn', (WidgetTester tester) async {
      await pumpMenu(tester, const <InkMenuItem>[]);
      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('a custom tooltip replaces the default one', (
      WidgetTester tester,
    ) async {
      await pumpIn(
        tester,
        InkOverflowMenu(
          tooltip: 'Palette actions',
          items: <InkMenuItem>[InkMenuItem(label: 'One', onSelected: () {})],
        ),
      );
      expect(find.byTooltip('Palette actions'), findsOneWidget);
      expect(find.byTooltip('More actions'), findsNothing);
    });

    testWidgets('works inside a sheet next to the close button', (
      WidgetTester tester,
    ) async {
      int selected = 0;
      await _openDraggable(
        tester,
        actions: <Widget>[
          InkOverflowMenu(
            items: <InkMenuItem>[
              InkMenuItem(label: 'Share', onSelected: () => selected++),
            ],
          ),
        ],
      );
      final Rect more = tester.getRect(find.byTooltip('More actions'));
      final Rect close = tester.getRect(find.byTooltip('Close'));
      expect(more.right + 4, moreOrLessEquals(close.left));
      expect(more.top, close.top);
      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Share'));
      await tester.pumpAndSettle();
      expect(selected, 1);
    });
  });

  group('showInkDraggableSheet', () {
    testWidgets('opens at half the height', (WidgetTester tester) async {
      await _openDraggable(tester);
      expect(_sheetTop(tester), moreOrLessEquals(400, epsilon: 2));
      expect(tester.getSize(find.byType(InkSheet)).height, closeTo(400, 2));
      expect(find.byTooltip('Close'), findsOneWidget);
    });

    testWidgets('dragging the content up reaches full height, then scrolls', (
      WidgetTester tester,
    ) async {
      await _openDraggable(tester);
      await tester.drag(find.byKey(_rowsKey), const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(_sheetTop(tester), moreOrLessEquals(0, epsilon: 2));
      // Past full height the list scrolls.
      await tester.drag(find.byKey(_rowsKey), const Offset(0, -200));
      await tester.pumpAndSettle();
      expect(_sheetTop(tester), moreOrLessEquals(0, epsilon: 2));
      expect(find.text('Row 0'), findsNothing);
    });

    testWidgets('a short drag snaps back to half, a long one to full', (
      WidgetTester tester,
    ) async {
      await _openDraggable(tester);
      await tester.drag(find.byKey(_rowsKey), const Offset(0, -100));
      await tester.pumpAndSettle();
      expect(_sheetTop(tester), moreOrLessEquals(400, epsilon: 2));
      await tester.drag(find.byKey(_rowsKey), const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(_sheetTop(tester), moreOrLessEquals(0, epsilon: 2));
    });

    testWidgets('dragging down from half closes the sheet', (
      WidgetTester tester,
    ) async {
      await _openDraggable(tester);
      await tester.drag(find.byKey(_rowsKey), const Offset(0, 300));
      await tester.pumpAndSettle();
      expect(find.byType(InkSheet), findsNothing);
      expect(find.text('Open'), findsOneWidget);
    });

    testWidgets('the grabber area drags the sheet too', (
      WidgetTester tester,
    ) async {
      await _openDraggable(tester);
      await tester.dragFrom(_grabber(tester), const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(_sheetTop(tester), moreOrLessEquals(0, epsilon: 2));
      await tester.dragFrom(_grabber(tester), const Offset(0, 400));
      await tester.pumpAndSettle();
      expect(_sheetTop(tester), moreOrLessEquals(400, epsilon: 2));
      await tester.dragFrom(_grabber(tester), const Offset(0, 300));
      await tester.pumpAndSettle();
      expect(find.byType(InkSheet), findsNothing);
    });

    testWidgets('the close button and the scrim close it', (
      WidgetTester tester,
    ) async {
      await _openDraggable(tester);
      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(InkSheet), findsNothing);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(200, 100));
      await tester.pumpAndSettle();
      expect(find.byType(InkSheet), findsNothing);
    });

    testWidgets('with animations disabled it settles without animating', (
      WidgetTester tester,
    ) async {
      await _openDraggable(tester, still: true);
      expect(_sheetTop(tester), moreOrLessEquals(400, epsilon: 2));
      await tester.drag(find.byKey(_rowsKey), const Offset(0, -300));
      // No snap animation: it is at the snap size after a few frames
      // (the animated one takes longer).
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
      expect(_sheetTop(tester), moreOrLessEquals(0, epsilon: 2));
    });

    testWidgets('moveTo brings the sheet back, animated or at once', (
      WidgetTester tester,
    ) async {
      for (final bool still in <bool>[false, true]) {
        final DraggableScrollableController controller =
            DraggableScrollableController();
        await _openDraggable(tester, still: still, controller: controller);
        await tester.drag(find.byKey(_rowsKey), const Offset(0, -400));
        await tester.pumpAndSettle();
        expect(controller.size, moreOrLessEquals(1.0, epsilon: 0.01));
        final BuildContext context = tester.element(find.byType(InkSheet));
        final Future<void> moving = controller.moveTo(context, 0.5);
        await tester.pump();
        if (still) {
          expect(_sheetTop(tester), moreOrLessEquals(400, epsilon: 2));
        } else {
          // Animated: not there on the first frame.
          expect(_sheetTop(tester), lessThan(399));
        }
        await tester.pumpAndSettle();
        await moving;
        expect(_sheetTop(tester), moreOrLessEquals(400, epsilon: 2));
        await tester.tap(find.byTooltip('Close'));
        await tester.pumpAndSettle();
        controller.dispose();
      }
    });

    testWidgets('moveTo on a sheet that is not attached does nothing', (
      WidgetTester tester,
    ) async {
      await pumpIn(tester, const SizedBox());
      final DraggableScrollableController controller =
          DraggableScrollableController();
      addTearDown(controller.dispose);
      await controller.moveTo(tester.element(find.byType(SizedBox)), 0.5);
    });

    testWidgets('the frame is raised, in both themes', (
      WidgetTester tester,
    ) async {
      for (final bool dark in <bool>[false, true]) {
        await _openDraggable(tester, dark: dark);
        final DecoratedBox frame = tester.widget(
          find
              .descendant(
                of: find.byType(InkSheet),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final BoxDecoration decoration = frame.decoration as BoxDecoration;
        expect(
          decoration.color,
          (dark ? InkColors.dark : InkColors.light).raised,
        );
        await tester.tap(find.byTooltip('Close'));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('InkSheet actions sit left of the close button, 4 apart', (
      WidgetTester tester,
    ) async {
      await pumpIn(
        tester,
        InkSheet(
          actions: <Widget>[
            InkIconButton(
              icon: InkIcons.share,
              tooltip: 'Share',
              onPressed: () {},
            ),
            InkIconButton(
              icon: InkIcons.copy,
              tooltip: 'Copy',
              onPressed: () {},
            ),
          ],
          child: const SizedBox(height: 120),
        ),
      );
      final Rect share = tester.getRect(find.byTooltip('Share'));
      final Rect copy = tester.getRect(find.byTooltip('Copy'));
      final Rect close = tester.getRect(find.byTooltip('Close'));
      expect(share.right + 4, moreOrLessEquals(copy.left));
      expect(copy.right + 4, moreOrLessEquals(close.left));
      expect(share.top, close.top);
    });

    testWidgets('InkSheet without actions keeps the close button in place', (
      WidgetTester tester,
    ) async {
      await pumpIn(tester, const InkSheet(child: SizedBox(height: 120)));
      final Rect close = tester.getRect(find.byTooltip('Close'));
      final Rect sheet = tester.getRect(find.byType(InkSheet));
      expect(sheet.right - close.right, 8);
      expect(close.top - sheet.top, 10);
    });
  });

  group('InkQualityText', () {
    Finder dots() => find.descendant(
      of: find.byKey(const ValueKey<String>('quality-dots')),
      matching: find.byType(Container),
    );

    int dotsOf(Color color) => dots()
        .evaluate()
        .where(
          (Element e) =>
              ((e.widget as Container).decoration! as BoxDecoration).color ==
              color,
        )
        .length;

    testWidgets('fills 4 / 3 / 2 / 1 / 0 dots for dE 1 / 4 / 8 / 15 / 30', (
      WidgetTester tester,
    ) async {
      final Map<double, int> expected = <double, int>{
        1: 4,
        4: 3,
        8: 2,
        15: 1,
        30: 0,
      };
      for (final bool dark in <bool>[false, true]) {
        final InkColors ink = dark ? InkColors.dark : InkColors.light;
        for (final MapEntry<double, int> e in expected.entries) {
          await pumpIn(tester, InkQualityText(e.key), dark: dark);
          expect(dots(), findsNWidgets(4), reason: 'dE ${e.key}');
          expect(dotsOf(ink.fg), e.value, reason: 'dE ${e.key}');
          // The empty ones are drawn in `line`.
          expect(dotsOf(ink.line), 4 - e.value, reason: 'dE ${e.key}');
          expect(qualityDotsFor(e.key), e.value);
          for (final Element dot in dots().evaluate()) {
            expect((dot.renderObject! as RenderBox).size, const Size(6, 6));
          }
        }
      }
    });

    testWidgets('writes the line in data type and fg2, dots 3 dp apart', (
      WidgetTester tester,
    ) async {
      await pumpIn(tester, const InkQualityText(10.8));
      final Finder line = find.text('ΔE 10.8 · Rough');
      expect(line, findsOneWidget);
      final Text text = tester.widget(line);
      expect(text.style?.color, InkColors.light.fg2);
      expect(text.style?.fontSize, 12);
      final List<Rect> rects = dots()
          .evaluate()
          .map((Element e) => tester.getRect(find.byWidget(e.widget)))
          .toList();
      expect(rects[1].left - rects[0].right, 3);
    });

    testWidgets('showDots: false draws the text only', (
      WidgetTester tester,
    ) async {
      await pumpIn(tester, const InkQualityText(3, showDots: false));
      expect(dots(), findsNothing);
      expect(find.text('ΔE 3.0 · Very close'), findsOneWidget);
    });

    testWidgets('semantics read the quality, then the dE', (
      WidgetTester tester,
    ) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await pumpIn(tester, const InkQualityText(10.8));
      expect(find.bySemanticsLabel('Rough, ΔE 10.8'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('in Spanish the line uses the decimal comma', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          theme: AppTheme.light(),
          home: const Scaffold(body: InkQualityText(10.8)),
        ),
      );
      expect(find.textContaining('ΔE 10,8 · '), findsOneWidget);
    });
  });

  group('QualityBadge', () {
    testWidgets('never stretches inside a stretching Column', (
      WidgetTester tester,
    ) async {
      await pumpIn(
        tester,
        const SizedBox(
          width: 300,
          child: Column(
            key: ValueKey<String>('col'),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[QualityBadge('Rough')],
          ),
        ),
      );
      final Finder column = find.byKey(const ValueKey<String>('col'));
      expect(tester.getSize(column).width, 300);
      final Finder pill = find.descendant(
        of: find.byType(QualityBadge),
        matching: find.byType(Container),
      );
      final Size badge = tester.getSize(pill);
      expect(badge.width, lessThan(300));
      expect(badge.height, 24);
      // It sits at the start edge.
      expect(tester.getTopLeft(pill).dx, tester.getTopLeft(column).dx);
    });

    testWidgets('keeps its size in a Row', (WidgetTester tester) async {
      await pumpIn(
        tester,
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[QualityBadge('Close')],
        ),
      );
      final Size badge = tester.getSize(find.byType(QualityBadge));
      expect(badge.height, 24);
      expect(badge.width, lessThan(120));
    });
  });

  group('InkDisclosure', () {
    Widget disclosure({
      required bool expanded,
      Widget? leading,
      Widget? trailing,
      Widget? subtitleWidget,
      String? subtitle,
      String? semanticLabel,
      EdgeInsetsGeometry? padding,
      VoidCallback? onToggle,
    }) => SizedBox(
      width: 320,
      child: InkDisclosure(
        title: 'OHUHU',
        subtitle: subtitle,
        subtitleWidget: subtitleWidget,
        leading: leading,
        trailing: trailing,
        semanticLabel: semanticLabel,
        expanded: expanded,
        onToggle: onToggle ?? () {},
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        child: const SizedBox(key: ValueKey<String>('body'), height: 100),
      ),
    );

    testWidgets(
      'leading and trailing sit around the text, before the chevron',
      (WidgetTester tester) async {
        await pumpIn(
          tester,
          disclosure(
            expanded: false,
            subtitle: 'FY02',
            leading: const SizedBox.square(
              key: ValueKey<String>('lead'),
              dimension: 20,
            ),
            trailing: const Text('3', key: ValueKey<String>('trail')),
          ),
        );
        final Rect lead = tester.getRect(
          find.byKey(const ValueKey<String>('lead')),
        );
        final Rect title = tester.getRect(find.text('OHUHU'));
        final Rect trail = tester.getRect(
          find.byKey(const ValueKey<String>('trail')),
        );
        final Rect row = tester.getRect(find.byType(InkDisclosure));
        expect(lead.left, row.left + 16);
        expect(title.left, greaterThan(lead.right));
        expect(trail.left, greaterThan(title.right));
        expect(trail.right, lessThan(row.right - 16));
        expect(find.byKey(const ValueKey<String>('body')), findsNothing);
      },
    );

    testWidgets('zero padding puts the header flush with the sheet margin', (
      WidgetTester tester,
    ) async {
      await pumpIn(
        tester,
        disclosure(
          expanded: false,
          padding: EdgeInsets.zero,
          leading: const SizedBox.square(
            key: ValueKey<String>('lead'),
            dimension: 20,
          ),
        ),
      );
      expect(
        tester.getTopLeft(find.byKey(const ValueKey<String>('lead'))).dx,
        tester.getTopLeft(find.byType(InkDisclosure)).dx,
      );
    });

    testWidgets('a rich summary replaces the subtitle and is announced', (
      WidgetTester tester,
    ) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await pumpIn(
        tester,
        disclosure(
          expanded: false,
          subtitle: 'ignored',
          subtitleWidget: const InkQualityText(7.6),
          semanticLabel: 'OHUHU, FY02, Close',
        ),
      );
      expect(find.text('ignored'), findsNothing);
      expect(find.textContaining('ΔE 7.6'), findsOneWidget);
      expect(find.bySemanticsLabel('OHUHU, FY02, Close'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('opening only pushes what is below: the header keeps its box', (
      WidgetTester tester,
    ) async {
      bool open = false;
      await pumpIn(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Align(
            alignment: Alignment.topCenter,
            child: disclosure(
              expanded: open,
              subtitle: 'FY02 · ΔE 10.8',
              onToggle: () => setState(() => open = !open),
            ),
          ),
        ),
      );
      final Rect closed = tester.getRect(find.text('OHUHU'));
      final double height = tester.getSize(find.byType(InkWell)).height;
      expect(height, greaterThanOrEqualTo(44));
      await tester.tap(find.text('OHUHU'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('body')), findsOneWidget);
      expect(tester.getRect(find.text('OHUHU')), closed);
      expect(tester.getSize(find.byType(InkWell)).height, height);
      await tester.tap(find.text('OHUHU'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('body')), findsNothing);
    });
  });

  group('InkPageHeader action', () {
    testWidgets('sits right of the title, before the trailing text', (
      WidgetTester tester,
    ) async {
      await pumpIn(
        tester,
        SizedBox(
          width: 360,
          child: InkPageHeader(
            title: 'Palette',
            subtitle: 'Build a palette',
            trailing: '5',
            action: InkIconButton(
              icon: InkIcons.bookmark,
              tooltip: 'Saved palettes',
              onPressed: () {},
            ),
          ),
        ),
      );
      final Rect title = tester.getRect(find.text('Palette'));
      final Rect action = tester.getRect(find.byTooltip('Saved palettes'));
      final Rect trailing = tester.getRect(find.text('5'));
      expect(action.left, greaterThanOrEqualTo(title.right));
      expect(trailing.left, greaterThanOrEqualTo(action.right));
      expect(action.size, const Size(44, 44));
      // The action is centred on the 40 dp title line within 3 dp.
      expect((action.center.dy - title.center.dy).abs(), lessThan(3));
      // The subtitle is still below everything.
      expect(
        tester.getTopLeft(find.text('Build a palette')).dy,
        greaterThanOrEqualTo(action.bottom),
      );
    });

    testWidgets('the action is tappable; a header without one is unchanged', (
      WidgetTester tester,
    ) async {
      int taps = 0;
      await pumpIn(
        tester,
        SizedBox(
          width: 360,
          child: InkPageHeader(
            title: 'Palette',
            action: InkIconButton(
              icon: InkIcons.bookmark,
              tooltip: 'Saved palettes',
              onPressed: () => taps++,
            ),
          ),
        ),
      );
      await tester.tap(find.byTooltip('Saved palettes'));
      expect(taps, 1);
      final double withAction = tester
          .getSize(find.byType(InkPageHeader))
          .height;
      await pumpIn(
        tester,
        const SizedBox(width: 360, child: InkPageHeader(title: 'Palette')),
      );
      // 24 top + 40 title line + 16 bottom; the 44 dp action adds 4.
      expect(tester.getSize(find.byType(InkPageHeader)).height, 80);
      expect(withAction, 84);
    });
  });

  group('InkIcons.moreHorizontal', () {
    testWidgets('draws three dots in a row', (WidgetTester tester) async {
      await pumpIn(
        tester,
        const InkIcon(InkIcons.moreHorizontal, size: 24, color: Colors.black),
      );
      final Finder paint = find.descendant(
        of: find.byType(InkIcon),
        matching: find.byType(CustomPaint),
      );
      final RenderBox box = tester.renderObject(paint);
      expect(
        box,
        paints
          ..circle(x: 5, y: 12, radius: 1)
          ..circle(x: 12, y: 12, radius: 1)
          ..circle(x: 19, y: 12, radius: 1),
      );
    });
  });

  group('layout stability', () {
    stabilityTest('header with an action never moves with the subtitle', (
      WidgetTester tester,
      StabilityEnv env,
    ) async {
      String segment = 'a';
      final Map<String, String> subtitles = <String, String>{
        'a': env.t.paletteTitle,
        'b':
            '${env.t.paletteTitle} ${env.t.paletteTitle} ${env.t.paletteTitle}',
      };
      await pumpStability(
        tester,
        env,
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkPageHeader(
                title: env.t.paletteTitle,
                subtitle: subtitles[segment],
                reserveSubtitleFor: subtitles.values.toList(),
                action: InkOverflowMenu(
                  items: <InkMenuItem>[
                    InkMenuItem(label: 'One', onSelected: () {}),
                  ],
                ),
              ),
              InkSegmented<String>(
                key: const ValueKey<String>('seg'),
                selected: segment,
                onChanged: (String v) => setState(() => segment = v),
                segments: const <InkSegment<String>>[
                  InkSegment<String>(value: 'a', label: 'A'),
                  InkSegment<String>(value: 'b', label: 'B'),
                ],
              ),
            ],
          ),
        ),
      );
      await expectStableAcrossSegments(
        tester,
        env: env,
        anchors: <String, Finder>{
          'header': find.byType(InkPageHeader),
          'action': find.byType(InkOverflowMenu),
          'control': find.byKey(const ValueKey<String>('seg')),
        },
        segments: <StabilitySegment>[
          (name: 'a', activate: () async {}),
          (name: 'b', activate: () => tester.tap(find.text('B'))),
          (name: 'a again', activate: () => tester.tap(find.text('A'))),
        ],
      );
    });

    stabilityTest('opening a disclosure moves nothing above it', (
      WidgetTester tester,
      StabilityEnv env,
    ) async {
      bool open = false;
      await pumpStability(
        tester,
        env,
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => ListView(
            children: <Widget>[
              InkPageHeader(title: env.t.paletteTitle),
              InkDisclosure(
                title: 'OHUHU',
                subtitleWidget: const InkQualityText(10.8),
                semanticLabel: 'OHUHU',
                leading: const SizedBox.square(dimension: 20),
                expanded: open,
                onToggle: () => setState(() => open = !open),
                child: const SizedBox(height: 120),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
      await expectStableAcrossSegments(
        tester,
        env: env,
        anchors: <String, Finder>{
          'header': find.byType(InkPageHeader),
          'group header': find.text('OHUHU'),
        },
        segments: <StabilitySegment>[
          (name: 'closed', activate: () async {}),
          (name: 'open', activate: () => tester.tap(find.text('OHUHU'))),
          (
            name: 'closed again',
            activate: () => tester.tap(find.text('OHUHU')),
          ),
        ],
      );
    });
  });
}
