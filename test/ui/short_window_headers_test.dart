import 'dart:io';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/ui/pages/diary/artwork_diary_view.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';
import 'package:ink_lab/ui/shell/app_shortcuts.dart' show swatchesSearchFocus;
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';
import 'package:ink_lab/ui/widgets/ink_adaptive.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_header_page.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';

import '../support/l10n.dart';
import 'diary/diary_test_support.dart' show entry;
import 'palette/palette_test_support.dart' show chooseBase, pumpPalette;

// The top of Swatches, Ideas and Palette goes up with the content on a short
// window (a phone in landscape, a split screen) and stays above the list on a
// tall one. German is the longest language of the app.

const Locale _locale = Locale('de');
final AppLocalizations _t = lookupAppLocalizations(_locale);

/// Short windows: a phone in landscape, a big phone in landscape, a
/// split-screen like window. Each one under [InkLayout.shortPageHeight].
const List<Size> _shortSizes = <Size>[
  Size(800, 360),
  Size(915, 412),
  Size(360, 330),
];
const List<double> _scales = <double>[1.0, 1.3];

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

void _setWindow(WidgetTester tester, Size size, [double scale = 1.0]) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

AppScope _scope(Widget page) => AppScope.inMemory(
  markers: _markers(),
  child: MaterialApp(
    locale: _locale,
    localizationsDelegates: testLocalizationsDelegates,
    supportedLocales: testSupportedLocales,
    theme: AppTheme.light(),
    home: Scaffold(body: page),
  ),
);

Future<void> _pumpSwatches(WidgetTester tester, Size size, double scale) async {
  _setWindow(tester, size, scale);
  await tester.pumpWidget(_scope(const SwatchesPage()));
  await tester.pumpAndSettle();
  // The preview collection opens on "Mine": browse the whole range.
  await tester.tap(find.text(_t.swatchesAllFilter));
  await tester.pumpAndSettle();
}

Future<void> _pumpIdeas(WidgetTester tester, Size size, double scale) async {
  _setWindow(tester, size, scale);
  await tester.pumpWidget(_scope(IdeasPage(today: DateTime(2026, 11, 15))));
  await tester.pumpAndSettle();
}

/// The vertical scroll view of the page.
Finder get _verticalScrollable => find
    .byWidgetPredicate(
      (Widget w) => w is Scrollable && w.axisDirection == AxisDirection.down,
    )
    .first;

ScrollPosition _position(WidgetTester tester) =>
    tester.state<ScrollableState>(_verticalScrollable).position;

Future<void> _scrollTo(WidgetTester tester, double offset) async {
  final ScrollPosition position = _position(tester);
  position.jumpTo(offset.clamp(0, position.maxScrollExtent));
  await tester.pumpAndSettle();
}

/// The header block (title to chips), wherever it is.
Finder get _headerBlock => find
    .descendant(
      of: find.byType(InkHeaderPage),
      matching: find.byType(KeyedSubtree),
    )
    .first;

/// Height of the header block.
double _headerExtent(WidgetTester tester) =>
    tester.getSize(_headerBlock).height;

/// Whether the header is inside the scroll view (a short window).
bool _headerScrolls(WidgetTester tester) => find
    .ancestor(
      of: find.byType(InkPageHeader, skipOffstage: false),
      matching: find.byType(CustomScrollView),
    )
    .evaluate()
    .isNotEmpty;

double _viewportHeight(WidgetTester tester) =>
    tester.getSize(find.byType(CustomScrollView)).height;

/// How much of the viewport the visible part of [items] covers, from the top
/// of the first to the bottom of the last.
double _coverage(WidgetTester tester, Finder items) {
  final Rect view = tester.getRect(find.byType(CustomScrollView));
  double top = double.infinity;
  double bottom = double.negativeInfinity;
  for (final Element e in items.evaluate()) {
    final Rect r = tester.getRect(
      find.byElementPredicate((Element x) => x == e),
    );
    if (r.bottom <= view.top || r.top >= view.bottom) continue;
    top = top < r.top ? top : (r.top < view.top ? view.top : r.top);
    final double clippedBottom = r.bottom > view.bottom
        ? view.bottom
        : r.bottom;
    if (clippedBottom > bottom) bottom = clippedBottom;
  }
  return bottom > top ? bottom - top : 0;
}

/// Vertical stretch effects of the page (the chip rows have their own,
/// sideways).
Iterable<StretchEffect> stretches(WidgetTester tester) => tester
    .widgetList<StretchEffect>(find.byType(StretchEffect))
    .where((StretchEffect e) => e.axis == Axis.vertical);

void main() {
  group('Swatches', () {
    for (final Size size in _shortSizes) {
      for (final double scale in _scales) {
        testWidgets('a short window ($size, x$scale) scrolls the header away '
            'and gives the grid the room', (WidgetTester tester) async {
          await _pumpSwatches(tester, size, scale);
          expect(
            InkLayout.isShortPage(tester.element(find.byType(SwatchesPage))),
            isTrue,
          );
          final Finder title = find.text(_t.swatchesTitle);
          expect(tester.getRect(title).top, greaterThanOrEqualTo(0));

          await _scrollTo(tester, 100000);
          // The title, the search field and the chips are gone...
          // (A sliver that is scrolled out is off stage for the finders.)
          expect(title, findsNothing);
          expect(find.byType(TextField), findsNothing);
          expect(
            find.byKey(const ValueKey<String>('swatches-filters')),
            findsNothing,
          );
          // ...and the grid fills most of the window.
          final double covered = _coverage(
            tester,
            find.byType(ColorSwatchTile),
          );
          expect(
            covered,
            greaterThan(_viewportHeight(tester) * 0.6),
            reason: 'the grid shows ${covered.round()} dp of $size',
          );
          expect(tester.takeException(), isNull);
        });
      }
    }

    testWidgets('a tall portrait window keeps the header where it is', (
      WidgetTester tester,
    ) async {
      await _pumpSwatches(tester, const Size(412, 915), 1.0);
      expect(
        InkLayout.isShortPage(tester.element(find.byType(SwatchesPage))),
        isFalse,
      );
      final Finder title = find.text(_t.swatchesTitle);
      final Finder search = find.byType(TextField).first;
      final Rect titleBox = tester.getRect(title);
      final Rect searchBox = tester.getRect(search);
      await _scrollTo(tester, 100000);
      expect(_position(tester).pixels, greaterThan(0));
      expect(tester.getRect(title), titleBox);
      expect(tester.getRect(search), searchBox);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the search text and its focus survive a rotation', (
      WidgetTester tester,
    ) async {
      await _pumpSwatches(tester, const Size(412, 915), 1.0);
      final Finder field = find.byType(TextField).first;
      await tester.enterText(field, 'B0');
      swatchesSearchFocus.requestFocus();
      await tester.pumpAndSettle();
      expect(swatchesSearchFocus.hasFocus, isTrue);

      for (final Size size in const <Size>[Size(800, 360), Size(412, 915)]) {
        tester.view.physicalSize = size;
        await tester.pumpAndSettle();
        expect(tester.widget<TextField>(field).controller!.text, 'B0');
        expect(swatchesSearchFocus.hasFocus, isTrue);
      }
    });

    testWidgets('the scroll position survives a rotation', (
      WidgetTester tester,
    ) async {
      await _pumpSwatches(tester, const Size(412, 915), 1.0);
      await _scrollTo(tester, 400);
      final double before = _position(tester).pixels;
      tester.view.physicalSize = const Size(800, 360);
      await tester.pumpAndSettle();
      expect(_position(tester).pixels, closeTo(before, 0.5));
      expect(tester.takeException(), isNull);
    });

    testWidgets('a hand-off to the search field brings the header back', (
      WidgetTester tester,
    ) async {
      await _pumpSwatches(tester, const Size(800, 360), 1.0);
      await _scrollTo(tester, 100000);
      final Finder field = find.byType(TextField);
      expect(field, findsNothing);

      // The shell does this when the search shortcut opens Swatches.
      swatchesSearchFocus.requestFocus();
      await tester.pumpAndSettle();

      expect(_position(tester).pixels, 0);
      expect(swatchesSearchFocus.hasFocus, isTrue);
      final Rect box = tester.getRect(field);
      expect(box.top, greaterThanOrEqualTo(0));
      expect(box.bottom, lessThanOrEqualTo(360));
    });

    testWidgets('typing in the search field does not move the view', (
      WidgetTester tester,
    ) async {
      await _pumpSwatches(tester, const Size(800, 360), 1.0);
      final Finder field = find.byType(TextField).first;
      await tester.enterText(field, 'B');
      await tester.pumpAndSettle();
      final double top = tester.getRect(field).top;
      await tester.enterText(field, 'B0');
      await tester.pumpAndSettle();
      expect(tester.getRect(field).top, top);
      expect(_position(tester).pixels, 0);
    });
  });

  group('Ideas', () {
    for (final Size size in _shortSizes) {
      for (final double scale in _scales) {
        testWidgets('a short window ($size, x$scale) scrolls the header away '
            'and gives the list the room', (WidgetTester tester) async {
          await _pumpIdeas(tester, size, scale);
          final Finder title = find.byType(InkPageHeader);
          expect(tester.getRect(title).top, greaterThanOrEqualTo(0));

          final double header = _headerExtent(tester);
          // Scrolled by exactly the header, the list starts at the top of the
          // window (its own top padding aside): the list gets all the room.
          await _scrollTo(tester, header);
          final Finder featured = find.byWidgetPredicate(
            (Widget w) =>
                w.key is ValueKey<String> &&
                (w.key! as ValueKey<String>).value.startsWith(
                  'ideas-featured-',
                ),
          );
          final Rect view = tester.getRect(find.byType(CustomScrollView));
          expect(
            tester.getRect(featured).top - view.top,
            lessThanOrEqualTo(InkSpacing.block + 0.5),
          );
          await _scrollTo(tester, header + 400);
          expect(title, findsNothing);
          expect(
            find.byKey(const ValueKey<String>('ideas-search')),
            findsNothing,
          );
          expect(tester.takeException(), isNull);
        });
      }
    }

    testWidgets('a tall portrait window keeps the header where it is', (
      WidgetTester tester,
    ) async {
      await _pumpIdeas(tester, const Size(412, 915), 1.0);
      final Finder title = find.byType(InkPageHeader);
      final Finder search = find.byKey(const ValueKey<String>('ideas-search'));
      final Rect titleBox = tester.getRect(title);
      final Rect searchBox = tester.getRect(search);
      await _scrollTo(tester, 600);
      expect(_position(tester).pixels, greaterThan(0));
      expect(tester.getRect(title), titleBox);
      expect(tester.getRect(search), searchBox);
    });

    testWidgets('a chip starts the list at the top (tall window)', (
      WidgetTester tester,
    ) async {
      await _pumpIdeas(tester, const Size(412, 915), 1.0);
      await _scrollTo(tester, 900);
      expect(_position(tester).pixels, greaterThan(0));

      final Finder chip = find.byKey(
        const ValueKey<String>('ideas-category-mood'),
      );
      // Bringing the chip into view scrolls the chip row, not the list.
      final double before = _position(tester).pixels;
      await tester.ensureVisible(chip);
      await tester.pumpAndSettle();
      expect(_position(tester).pixels, before);
      await tester.tap(chip);
      await tester.pumpAndSettle();
      expect(_position(tester).pixels, 0);
      expect(
        find.byKey(const ValueKey<String>('ideas-section-easy')),
        findsOneWidget,
      );
    });

    testWidgets('a chip keeps the list under the header (short window)', (
      WidgetTester tester,
    ) async {
      await _pumpIdeas(tester, const Size(800, 360), 1.0);
      final double header = _headerExtent(tester);
      // Scroll the page down until only the chips are left of the header.
      await _scrollTo(tester, header - 100);
      final double at = _position(tester).pixels;
      expect(at, greaterThan(0));
      final Finder chip = find.byKey(
        const ValueKey<String>('ideas-category-mood'),
      );
      expect(chip, findsOneWidget);
      await tester.tap(chip);
      await tester.pumpAndSettle();
      // The new list starts right under the chips, where the user is.
      expect(_position(tester).pixels, at);
      final Finder first = find.byKey(
        const ValueKey<String>('ideas-section-easy'),
      );
      expect(first, findsOneWidget);
      final Rect box = tester.getRect(first);
      expect(box.top, greaterThanOrEqualTo(0));
      expect(box.top, lessThan(360));
    });

    testWidgets('"See all" from deep in the list lands on its first section', (
      WidgetTester tester,
    ) async {
      await _pumpIdeas(tester, const Size(800, 360), 1.0);
      final double header = _headerExtent(tester);
      final Finder seeAll = find.byKey(
        const ValueKey<String>('ideas-see-all-mood'),
      );
      await tester.scrollUntilVisible(
        seeAll,
        200,
        scrollable: _verticalScrollable,
      );
      expect(_position(tester).pixels, greaterThan(header));
      await tester.tap(seeAll);
      await tester.pumpAndSettle();
      expect(_position(tester).pixels, lessThanOrEqualTo(header + 0.5));
      final Finder first = find.byKey(
        const ValueKey<String>('ideas-section-easy'),
      );
      expect(first, findsOneWidget);
      expect(tester.getRect(first).top, lessThan(360));
    });

    testWidgets('the search text survives a rotation', (
      WidgetTester tester,
    ) async {
      await _pumpIdeas(tester, const Size(412, 915), 1.0);
      final Finder field = find.byKey(const ValueKey<String>('ideas-search'));
      await tester.enterText(field, 'neon');
      await tester.pumpAndSettle();
      tester.view.physicalSize = const Size(800, 360);
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<TextField>(
              find.descendant(of: field, matching: find.byType(TextField)),
            )
            .controller!
            .text,
        'neon',
      );
    });

    testWidgets('the diary segment: add button in the header, list below', (
      WidgetTester tester,
    ) async {
      Future<AppScope> pumpDiary(Size size) async {
        await _pumpIdeas(tester, size, 1.0);
        final AppScope scope = AppScope.of(
          tester.element(find.byType(IdeasPage)),
        );
        for (int i = 0; i < 12; i++) {
          await scope.artworkDiary.save(
            entry(id: 'e$i', title: 'Entry $i', createdAtEpochMs: 1000 + i),
          );
        }
        await tester.tap(find.text(_t.ideasDiarySegment));
        await tester.pumpAndSettle();
        return scope;
      }

      // Short window: the add button goes up with the page.
      await pumpDiary(const Size(800, 360));
      final Finder add = find.byKey(const ValueKey<String>('diary-add'));
      expect(add, findsOneWidget);
      expect(find.byKey(ArtworkDiaryView.viewKey), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('diary-entry-e0')),
        findsOneWidget,
      );
      final double header = _headerExtent(tester);
      expect(_position(tester).maxScrollExtent, greaterThan(header));
      await _scrollTo(tester, 100000);
      expect(_position(tester).pixels, greaterThan(header));
      expect(add, findsNothing);
      expect(find.byType(InkPageHeader), findsNothing);
      // Back to the ideas segment.
      await _scrollTo(tester, 0);
      await tester.tap(
        find.descendant(
          of: find.byKey(const ValueKey<String>('ideas-view')),
          matching: find.text(_t.ideasTitle),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey<String>('ideas-search')),
        findsOneWidget,
      );

      // Tall window: it stays where it is.
      await pumpDiary(const Size(412, 915));
      expect(_position(tester).maxScrollExtent, greaterThan(0));
      final Rect addBox = tester.getRect(add);
      await _scrollTo(tester, 100000);
      expect(_position(tester).pixels, greaterThan(0));
      expect(tester.getRect(add), addBox);
    });
  });

  group('Palette', () {
    testWidgets('a short window scrolls the title away, a tall one pins it', (
      WidgetTester tester,
    ) async {
      _setWindow(tester, const Size(800, 360));
      await tester.pumpWidget(_scope(const PalettePage()));
      await tester.pumpAndSettle();
      final Finder title = find.byType(InkPageHeader);
      expect(tester.getRect(title).top, greaterThanOrEqualTo(0));
      await _scrollTo(tester, 100000);
      expect(title, findsNothing);

      _setWindow(tester, const Size(412, 915));
      await tester.pumpWidget(_scope(const PalettePage()));
      await tester.pumpAndSettle();
      final Rect box = tester.getRect(title);
      await _scrollTo(tester, 100000);
      expect(tester.getRect(title), box);
    });
  });

  group('Match and Settings', () {
    // Their header is the first row of the list already: nothing to change,
    // but it must keep working on a short window.
    for (final Size size in _shortSizes) {
      for (final double scale in _scales) {
        testWidgets('the header goes up with the page ($size, x$scale)', (
          WidgetTester tester,
        ) async {
          for (final Widget page in const <Widget>[
            MatchPage(),
            SettingsPage(),
          ]) {
            _setWindow(tester, size, scale);
            await tester.pumpWidget(_scope(page));
            await tester.pumpAndSettle();
            final Finder header = find.byType(InkPageHeader);
            expect(tester.getRect(header).top, greaterThanOrEqualTo(0));
            await _scrollTo(tester, 100000);
            // A split page (a wide landscape) has two columns, each with its
            // own list: the header stays with the photo or the controls.
            if (!InkLayout.isSplit(size)) {
              expect(header, findsNothing, reason: '${page.runtimeType}');
            }
            expect(tester.takeException(), isNull);
          }
        });
      }
    }
  });

  group('Rail', () {
    for (final Size size in const <Size>[Size(800, 360), Size(915, 412)]) {
      for (final double scale in const <double>[1.3, 2.0]) {
        testWidgets('the five destinations stay reachable ($size, x$scale)', (
          WidgetTester tester,
        ) async {
          _setWindow(tester, size, scale);
          useDeviceLocales(tester, const <Locale>[Locale('de')]);
          await tester.pumpWidget(const InkLabApp());
          await tester.pumpAndSettle();
          expect(find.byType(NavigationRail), findsOneWidget);
          final Finder rail = find.byType(NavigationRail);
          final Finder last = find.descendant(
            of: rail,
            matching: find.text(appDestinations.last.label(_t)),
          );
          expect(last, findsOneWidget);
          await tester.ensureVisible(last);
          await tester.pumpAndSettle();
          final Rect box = tester.getRect(last);
          expect(box.bottom, lessThanOrEqualTo(size.height + 0.5));
          expect(box.top, greaterThanOrEqualTo(0));
          await tester.tap(last);
          await tester.pumpAndSettle();
          expect(find.byType(AppShell), findsOneWidget);
          expect(tester.takeException(), isNull);
        });
      }
    }
  });

  group('overscroll', () {
    testWidgets(
      'a tall window stretches the list, not the header',
      (WidgetTester tester) async {
        const Size size = Size(412, 915);
        await _pumpSwatches(tester, size, 1.0);
        final Finder header = find.byType(InkPageHeader);
        final Rect before = tester.getRect(header);
        final TestGesture drag = await tester.startGesture(
          Offset(size.width / 2, size.height - 150),
        );
        for (int i = 0; i < 8; i++) {
          await drag.moveBy(const Offset(0, 40));
          await tester.pump();
          // Checked during the pull, before anything settles.
          expect(tester.getRect(header), before);
        }
        if (defaultTargetPlatform == TargetPlatform.android) {
          // The stretch is on the list, and the header is not inside it.
          expect(stretches(tester), hasLength(1));
          expect(stretches(tester).single.stretchStrength, isNot(0));
          expect(
            find.descendant(
              of: find.byType(StretchEffect),
              matching: find.byType(InkPageHeader),
            ),
            findsNothing,
          );
        } else {
          expect(_position(tester).pixels, lessThan(0));
        }
        await drag.up();
        await tester.pump();
        expect(tester.getRect(header), before);
        await tester.pumpAndSettle();
        expect(tester.getRect(header), before);
      },
      variant: const TargetPlatformVariant(<TargetPlatform>{
        TargetPlatform.android,
        TargetPlatform.iOS,
      }),
    );

    testWidgets('a short window stretches the whole page, header included', (
      WidgetTester tester,
    ) async {
      await _pumpSwatches(tester, const Size(800, 360), 1.0);
      final TestGesture drag = await tester.startGesture(
        const Offset(400, 250),
      );
      for (int i = 0; i < 6; i++) {
        await drag.moveBy(const Offset(0, 40));
        await tester.pump();
      }
      expect(stretches(tester), hasLength(1));
      expect(stretches(tester).single.stretchStrength, isNot(0));
      expect(
        find.descendant(
          of: find.byType(StretchEffect),
          matching: find.byType(InkPageHeader),
        ),
        findsOneWidget,
      );
      await drag.up();
      await tester.pumpAndSettle();
    });

    for (final bool ideas in const <bool>[false, true]) {
      testWidgets(
        'a tall window whose list fits still stretches or bounces '
        '(${ideas ? 'Ideas' : 'Swatches'})',
        (WidgetTester tester) async {
          const Size size = Size(412, 915);
          if (ideas) {
            await _pumpIdeas(tester, size, 1.0);
          } else {
            await _pumpSwatches(tester, size, 1.0);
          }
          // Nothing matches: the content is short, there is nothing to
          // scroll, and the page still gives the platform's feedback.
          final Finder field = ideas
              ? find.descendant(
                  of: find.byKey(const ValueKey<String>('ideas-search')),
                  matching: find.byType(TextField),
                )
              : find.byType(TextField).first;
          await tester.enterText(field, 'zzzzzzzz');
          await tester.pumpAndSettle();
          expect(_position(tester).maxScrollExtent, 0);
          final Finder header = find.byType(InkPageHeader);
          final Rect before = tester.getRect(header);
          final TestGesture drag = await tester.startGesture(
            Offset(size.width / 2, size.height - 150),
          );
          for (int i = 0; i < 8; i++) {
            await drag.moveBy(const Offset(0, 40));
            await tester.pump();
          }
          if (defaultTargetPlatform == TargetPlatform.android) {
            expect(stretches(tester), hasLength(1));
            expect(stretches(tester).single.stretchStrength, isNot(0));
          } else {
            expect(_position(tester).pixels, lessThan(0));
          }
          expect(tester.getRect(header), before);
          await drag.up();
          await tester.pumpAndSettle();
          expect(tester.getRect(header), before);
        },
        variant: const TargetPlatformVariant(<TargetPlatform>{
          TargetPlatform.android,
          TargetPlatform.iOS,
        }),
      );
    }

    testWidgets('a tall window: a chip row keeps its own stretch', (
      WidgetTester tester,
    ) async {
      await _pumpIdeas(tester, const Size(412, 915), 1.0);
      final TestGesture drag = await tester.startGesture(
        tester.getCenter(find.byType(InkChipRow)),
      );
      // Pulling the chip row to the right, past its start.
      for (int i = 0; i < 6; i++) {
        await drag.moveBy(const Offset(30, 0));
        await tester.pump();
      }
      final Iterable<StretchEffect> sideways = tester
          .widgetList<StretchEffect>(find.byType(StretchEffect))
          .where((StretchEffect e) => e.axis == Axis.horizontal);
      expect(sideways.any((StretchEffect e) => e.stretchStrength != 0), isTrue);
      await drag.up();
      await tester.pumpAndSettle();
    });
  });

  group('iOS status bar', () {
    for (final Size size in const <Size>[Size(412, 915), Size(800, 360)]) {
      for (final bool ideas in const <bool>[false, true]) {
        testWidgets(
          'a tap on it scrolls ${ideas ? 'Ideas' : 'Swatches'} to the top '
          '($size)',
          (WidgetTester tester) async {
            if (ideas) {
              await _pumpIdeas(tester, size, 1.0);
            } else {
              await _pumpSwatches(tester, size, 1.0);
            }
            // A status bar for the scaffold to put its tap area in.
            tester.view.padding = const FakeViewPadding(top: 40);
            tester.view.viewPadding = const FakeViewPadding(top: 40);
            addTearDown(tester.view.resetPadding);
            addTearDown(tester.view.resetViewPadding);
            await tester.pumpAndSettle();
            await _scrollTo(tester, 100000);
            expect(_position(tester).pixels, greaterThan(0));

            // What the iOS embedder sends when the status bar is tapped.
            await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
              SystemChannels.statusBar.name,
              SystemChannels.statusBar.codec.encodeMethodCall(
                const MethodCall('handleScrollToTop'),
              ),
              (ByteData? _) {},
            );
            await tester.pumpAndSettle();
            expect(_position(tester).pixels, 0);
          },
          variant: TargetPlatformVariant.only(TargetPlatform.iOS),
        );
      }
    }
  });

  group('window modes', () {
    testWidgets('Swatches: the search field keeps text and focus when the '
        'header moves in and out of the list', (WidgetTester tester) async {
      await _pumpSwatches(tester, const Size(412, 915), 1.0);
      final Finder editable = find.byType(EditableText);
      await tester.enterText(find.byType(TextField).first, 'B0');
      swatchesSearchFocus.requestFocus();
      await tester.pumpAndSettle();
      final State field = tester.state(editable);
      expect(swatchesSearchFocus.hasFocus, isTrue);

      for (final Size size in const <Size>[
        Size(800, 360),
        Size(412, 915),
        Size(800, 360),
        Size(412, 915),
      ]) {
        tester.view.physicalSize = size;
        await tester.pumpAndSettle();
        expect(_headerScrolls(tester), size.height < 480, reason: '$size');
        // The very same field: moved, not rebuilt.
        expect(tester.state(editable), same(field), reason: '$size');
        expect(
          tester.widget<EditableText>(editable).controller.text,
          'B0',
          reason: '$size',
        );
        expect(swatchesSearchFocus.hasFocus, isTrue, reason: '$size');
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('Ideas: the search field keeps text and focus when the '
        'header moves in and out of the list', (WidgetTester tester) async {
      await _pumpIdeas(tester, const Size(412, 915), 1.0);
      final Finder editable = find.descendant(
        of: find.byKey(const ValueKey<String>('ideas-search')),
        matching: find.byType(EditableText),
      );
      await tester.tap(editable);
      await tester.enterText(editable, 'neon');
      await tester.pumpAndSettle();
      final State field = tester.state(editable);
      expect(tester.widget<EditableText>(editable).focusNode.hasFocus, isTrue);

      for (final Size size in const <Size>[
        Size(800, 360),
        Size(412, 915),
        Size(800, 360),
        Size(412, 915),
      ]) {
        tester.view.physicalSize = size;
        await tester.pumpAndSettle();
        expect(_headerScrolls(tester), size.height < 480, reason: '$size');
        expect(tester.state(editable), same(field), reason: '$size');
        expect(
          tester.widget<EditableText>(editable).controller.text,
          'neon',
          reason: '$size',
        );
        expect(
          tester.widget<EditableText>(editable).focusNode.hasFocus,
          isTrue,
          reason: '$size',
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('the keyboard does not flip the mode, short or tall', (
      WidgetTester tester,
    ) async {
      for (final Size size in const <Size>[Size(800, 360), Size(412, 915)]) {
        await _pumpSwatches(tester, size, 1.0);
        final bool short = InkLayout.isShortPage(
          tester.element(find.byType(SwatchesPage)),
        );
        expect(short, size.height < InkLayout.shortPageHeight);
        final Rect title = tester.getRect(find.text(_t.swatchesTitle));
        expect(_headerScrolls(tester), short);

        // The keyboard takes half of the window: the body shrinks...
        tester.view.viewInsets = FakeViewPadding(bottom: size.height / 2);
        addTearDown(tester.view.resetViewInsets);
        await tester.pumpAndSettle();
        expect(
          InkLayout.isShortPage(tester.element(find.byType(SwatchesPage))),
          short,
        );
        expect(_headerScrolls(tester), short);
        // ...and the header stays where it was.
        expect(tester.getRect(find.text(_t.swatchesTitle)), title);
        tester.view.resetViewInsets();
        await tester.pumpAndSettle();
      }
    });

    testWidgets('479 dp of height is short, 480 dp is not (and back)', (
      WidgetTester tester,
    ) async {
      await _pumpSwatches(tester, const Size(800, 480), 1.0);
      expect(_headerScrolls(tester), isFalse);
      await _scrollTo(tester, 100000);
      expect(find.text(_t.swatchesTitle), findsOneWidget);

      tester.view.physicalSize = const Size(800, 479);
      await tester.pumpAndSettle();
      expect(_headerScrolls(tester), isTrue);
      await _scrollTo(tester, 100000);
      expect(find.text(_t.swatchesTitle), findsNothing);

      tester.view.physicalSize = const Size(800, 480);
      await tester.pumpAndSettle();
      expect(_headerScrolls(tester), isFalse);
      expect(find.text(_t.swatchesTitle), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a Palette keeps its choices across split and non-split', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await chooseBase(tester, 'B08');
      final State state = tester.state(find.byType(PalettePage));
      expect(find.text('B08'), findsWidgets);
      for (final Size size in const <Size>[
        Size(800, 600),
        Size(915, 412),
        Size(800, 360),
        Size(1280, 800),
        Size(412, 915),
      ]) {
        tester.view.physicalSize = size;
        await tester.pumpAndSettle();
        expect(
          tester.state(find.byType(PalettePage)),
          same(state),
          reason: '$size',
        );
        expect(tester.takeException(), isNull, reason: '$size');
        expect(find.text('B08'), findsWidgets, reason: '$size');
      }
    });

    for (final Size size in const <Size>[Size(800, 360), Size(412, 915)]) {
      testWidgets('text at x2.0 ($size): Swatches, Ideas and Palette', (
        WidgetTester tester,
      ) async {
        final bool short = size.height < InkLayout.shortPageHeight;
        for (final Widget page in <Widget>[
          const SwatchesPage(),
          IdeasPage(today: DateTime(2026, 11, 15)),
          const PalettePage(),
        ]) {
          _setWindow(tester, size, 2.0);
          await tester.pumpWidget(_scope(page));
          await tester.pumpAndSettle();
          final Finder header = find.byType(InkPageHeader);
          final Rect before = tester.getRect(header);
          await _scrollTo(tester, 100000);
          expect(tester.takeException(), isNull, reason: '${page.runtimeType}');
          if (short) {
            expect(header, findsNothing, reason: '${page.runtimeType}');
          } else {
            expect(
              tester.getRect(header),
              before,
              reason: '${page.runtimeType}',
            );
          }
        }
      });
    }
  });

  testWidgets('every chip of Ideas is a tap target in the pinned header', (
    WidgetTester tester,
  ) async {
    // The pinned header is on screen already: asking for one of its chips
    // (keyboard focus, accessibility) must not scroll the list under it.
    await _pumpIdeas(tester, const Size(412, 915), 1.0);
    await _scrollTo(tester, 700);
    final double before = _position(tester).pixels;
    final Finder chip = find.byType(InkChip).last;
    await tester.ensureVisible(chip);
    await tester.pumpAndSettle();
    expect(_position(tester).pixels, before);
  });
}
