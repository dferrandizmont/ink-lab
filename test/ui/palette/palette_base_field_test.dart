import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/pages/palette/palette_base_field.dart';
import 'package:ink_lab/ui/pages/palette/palette_base_picker_sheet.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../support/l10n.dart';
import 'palette_test_support.dart';

// The base marker field of the Palette page is a button: it opens the
// searchable list of markers with the search ready to type in, and the base is
// whatever is chosen there. Nothing is typed on the page.

Finder _key(String key) => find.byKey(ValueKey<String>(key));

Finder get _field => _key('palette-base-field');

/// The search field of the list of markers has the keyboard focus.
bool _searchFocused(WidgetTester tester) => tester
    .widget<EditableText>(
      find.descendant(
        of: _key('palette-picker-search'),
        matching: find.byType(EditableText),
      ),
    )
    .focusNode
    .hasFocus;

MarkerColor? _resolved(WidgetTester tester) => tester
    .widget<PaletteBaseAndSize>(find.byType(PaletteBaseAndSize))
    .resolvedBase;

/// The colour of the box's border: `strong`, or `action` with the focus.
Color _border(WidgetTester tester) =>
    (tester
                .widget<Material>(
                  find
                      .descendant(of: _field, matching: find.byType(Material))
                      .first,
                )
                .shape!
            as RoundedRectangleBorder)
        .side
        .color;

/// The focus node of the field's button.
FocusNode _fieldFocus(WidgetTester tester) =>
    Focus.of(tester.element(_key('palette-base-value')));

/// The keyboard rises over the bottom of the screen (as it does once the
/// search of the list is focused).
Future<void> _keyboard(WidgetTester tester, double height) async {
  tester.view.viewInsets = FakeViewPadding(bottom: height);
  await tester.pumpAndSettle();
}

/// A phone: 360 x 640 dp, optionally with large text.
void _phone(WidgetTester tester, {double scale = 1}) {
  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1.0;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.platformDispatcher.clearAllTestValues);
  addTearDown(tester.view.reset);
}

void main() {
  setUpAll(loadAppFonts);

  group('opening the list', () {
    testWidgets('a tap opens the list of markers with its search focused', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      expect(_key('palette-base-picker'), findsNothing);

      await tester.tap(_field);
      await tester.pumpAndSettle();

      expect(_key('palette-base-picker'), findsOneWidget);
      expect(_searchFocused(tester), isTrue);
      // The page keeps no text input of its own.
      expect(
        find.descendant(of: _field, matching: find.byType(EditableText)),
        findsNothing,
      );
    });

    testWidgets('rows ignore taps while the list slides in (a double tap)', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      _phone(tester);
      await tester.pumpAndSettle();
      await tester.ensureVisible(_field);
      await tester.tap(_field);
      // The sheet is half way up: a second tap lands on a row that moves.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      final Finder first = find
          .descendant(
            of: _key('palette-base-picker'),
            matching: find.byType(InkWell),
          )
          .first;
      // The row is already on screen, moving: the second tap hits it.
      expect(tester.getCenter(first).dy, lessThan(640));
      await tester.tap(first, warnIfMissed: false);
      await tester.pump(const Duration(milliseconds: 20));
      expect(_key('palette-base-picker'), findsOneWidget);
      expect(baseInputOf(tester), isEmpty);

      // In place but still within a double tap's time (a phone slides the
      // sheet in faster than a quick second tap): still ignored.
      await tester.pumpAndSettle();
      await tester.tap(first);
      await tester.pump(const Duration(milliseconds: 20));
      expect(_key('palette-base-picker'), findsOneWidget);
      expect(baseInputOf(tester), isEmpty);

      // Past that, the same row chooses.
      await tester.pump(const Duration(milliseconds: 600));
      await tester.tap(first);
      await tester.pumpAndSettle();
      expect(_key('palette-base-picker'), findsNothing);
      expect(baseInputOf(tester), isNotEmpty);
    });

    testWidgets('without animations the rows work after a double tap time', (
      WidgetTester tester,
    ) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(tester.platformDispatcher.clearAllTestValues);
      await pumpPalette(tester);
      await tester.ensureVisible(_field);
      await tester.tap(_field);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.tap(
        find
            .descendant(
              of: _key('palette-base-picker'),
              matching: find.byType(InkWell),
            )
            .first,
      );
      await tester.pumpAndSettle();
      expect(_key('palette-base-picker'), findsNothing);
      expect(baseInputOf(tester), isNotEmpty);
    });

    testWidgets('Enter on the focused field opens it, and a ring shows', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      final InkColors ink = InkColors.of(tester.element(_field));
      expect(_border(tester), ink.strong);

      _fieldFocus(tester).requestFocus();
      await tester.pumpAndSettle();
      expect(_border(tester), ink.action);

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(_key('palette-base-picker'), findsOneWidget);
      expect(_searchFocused(tester), isTrue);
    });

    testWidgets('Space opens it', (WidgetTester tester) async {
      await pumpPalette(tester);
      _fieldFocus(tester).requestFocus();
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();
      expect(_key('palette-base-picker'), findsOneWidget);
    });

    testWidgets('typing in the list changes nothing on the page', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await chooseBase(tester, 'B08');
      final List<String> before = rowCodes(tester);

      await openBaseSheet(tester);
      for (final String text in <String>['B', 'B1', 'B11', 'B111']) {
        await tester.enterText(_key('palette-picker-search'), text);
        await tester.pump();
        // No palette is rebuilt and no notice flashes at each letter.
        expect(_key('palette-changed'), findsNothing);
        expect(_key('palette-base-replaced'), findsNothing);
      }
      await closeSheet(tester);
      expect(baseInputOf(tester), 'B08');
      expect(rowCodes(tester), before);
      expect(_key('palette-changed'), findsNothing);
    });

    testWidgets('scrolling the list does not close it', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await openBaseSheet(tester);

      final Finder list = find.descendant(
        of: _key('palette-base-picker'),
        matching: find.byType(ListView),
      );
      expect(_searchFocused(tester), isTrue);
      await tester.drag(list, const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(_key('palette-base-picker'), findsOneWidget);
      // Dragging the list puts the keyboard away.
      expect(_searchFocused(tester), isFalse);
    });
  });

  group('choosing a marker', () {
    testWidgets('sets the base, builds the palette and offers one Undo', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await chooseBase(tester, 'B08');
      expect(baseInputOf(tester), 'B08');
      expect(find.byType(PaletteStrip), findsWidgets);
      expect(_key('palette-base-picker'), findsNothing);
      // Nothing was on screen to go back to: no notice.
      expect(_key('palette-changed'), findsNothing);

      await openBaseSheet(tester);
      final String other = tester
          .widget<PaletteBasePickerSheet>(find.byType(PaletteBasePickerSheet))
          .markers
          .map((MarkerColor c) => c.newCode)
          .firstWhere((String c) => c != 'B08');
      await closeSheet(tester);
      final List<String> before = rowCodes(tester);

      await chooseBase(tester, other);

      expect(baseInputOf(tester), other);
      expect(_key('palette-changed'), findsOneWidget);
      expect(find.text(l10n.paletteUndoButton), findsOneWidget);
      expect(rowCodes(tester), isNot(before));

      await tester.tap(find.text(l10n.paletteUndoButton));
      await tester.pumpAndSettle();
      expect(baseInputOf(tester), 'B08');
      expect(rowCodes(tester), before);
    });

    testWidgets('closing the list without choosing changes nothing', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await chooseBase(tester, 'B08');
      final List<String> before = rowCodes(tester);

      await openBaseSheet(tester);
      await closeSheet(tester);

      expect(baseInputOf(tester), 'B08');
      expect(rowCodes(tester), before);
      expect(_key('palette-changed'), findsNothing);
    });

    for (final double scale in <double>[1, 1.3, 2]) {
      testWidgets('the field keeps its box when a marker is chosen (x$scale)', (
        WidgetTester tester,
      ) async {
        await pumpPalette(tester);
        _phone(tester, scale: scale);
        await tester.pumpAndSettle();
        final Finder type = _key('palette-type-field');
        // Size, and place relative to the field above it (the page may scroll).
        Size sizeOf() => tester.getSize(_field);
        double below() =>
            tester.getTopLeft(_field).dy - tester.getBottomLeft(type).dy;
        final Size empty = sizeOf();
        final double gap = below();
        expect(
          tester.widget<Text>(_key('palette-base-value')).data,
          l10n.paletteBaseChooseHint,
        );
        expect(_key('palette-base-name'), findsNothing);

        await chooseBase(tester, 'B08');
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 5000));
        await tester.pumpAndSettle();

        expect(tester.widget<Text>(_key('palette-base-value')).data, 'B08');
        expect(_key('palette-base-name'), findsOneWidget);
        // Nothing shifts: the box keeps its size and its place.
        expect(sizeOf(), empty);
        expect(below(), moreOrLessEquals(gap));
        // The empty second line says nothing to a screen reader.
        await tapResultItem(tester, 'palette-clear');
        expect(sizeOf(), empty);
        expect(_key('palette-base-name'), findsNothing);
      });
    }

    for (final double scale in <double>[1, 2]) {
      testWidgets('the empty hint is centred in the field (x$scale)', (
        WidgetTester tester,
      ) async {
        await pumpPalette(tester);
        _phone(tester, scale: scale);
        await tester.pumpAndSettle();

        final Rect box = tester.getRect(_field);
        final Rect hint = tester.getRect(_key('palette-base-value'));
        expect(hint.center.dy, moreOrLessEquals(box.center.dy, epsilon: 1));
        final Rect glyph = tester.getRect(
          find.descendant(of: _field, matching: find.byType(InkIcon)),
        );
        expect(hint.center.dy, moreOrLessEquals(glyph.center.dy, epsilon: 1));
      });
    }

    testWidgets('with several brands the rows are told apart by brand', (
      WidgetTester tester,
    ) async {
      await pumpPalette(
        tester,
        ownedMarkerCodes: <String>{'decotime:91', 'decotime:92'},
        setup: (AppScope scope) =>
            scope.settings.setScope(BrandScope.mixedBrands),
      );

      await openBaseSheet(tester);
      expect(_key('palette-picker-brand-ohuhu_oahu'), findsOneWidget);
      await tester.enterText(_key('palette-picker-search'), 'DecoTime');
      await tester.pumpAndSettle();
      expect(_key('palette-picker-brand-decotime'), findsOneWidget);
      await closeSheet(tester);

      await chooseBase(tester, '91', brand: MarkerBrand.decoTime);

      expect(baseInputOf(tester), 'DecoTime 91');
      expect(
        tester.widget<Text>(_key('palette-base-value')).data,
        'DecoTime 91',
      );
      expect(_resolved(tester)!.colorId, 'decotime:91');
    });
  });

  group('the field as a control', () {
    testWidgets('is a button with the label and the current value', (
      WidgetTester tester,
    ) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await pumpPalette(tester);

      expect(
        tester.getSemantics(_field),
        isSemantics(
          isButton: true,
          isEnabled: true,
          hasEnabledState: true,
          hasTapAction: true,
          label: l10n.paletteBaseMarkerTitle,
          hint: l10n.palettePickBaseTooltip,
        ),
      );
      // Empty: the value is the hint, which asks to choose a marker.
      expect(tester.getSemantics(_field).value, l10n.paletteBaseChooseHint);

      await chooseBase(tester, 'B08');
      final String value = tester.getSemantics(_field).value;
      expect(value, startsWith('B08, '));
      expect(value, contains(_resolved(tester)!.newName));
      handle.dispose();
    });

    testWidgets('is one tap target, however far from its text you tap', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      final Rect box = tester.getRect(_field);
      await tester.tapAt(box.centerRight - const Offset(2, 0));
      await tester.pumpAndSettle();
      expect(_key('palette-base-picker'), findsOneWidget);
    });

    testWidgets('is disabled, and opens nothing, with no marker to choose', (
      WidgetTester tester,
    ) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await pumpPalette(tester, brand: MarkerBrand.decoTime);

      expect(
        tester.getSemantics(_field),
        isSemantics(isButton: true, hasEnabledState: true, isEnabled: false),
      );
      await tester.tap(_field);
      await tester.pumpAndSettle();
      expect(_key('palette-base-picker'), findsNothing);
      handle.dispose();
    });

    testWidgets('reads right to left: the swatch first, the glyph last', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester, textDirection: TextDirection.rtl);
      await chooseBase(tester, 'B08');

      final Rect box = tester.getRect(_field);
      final Rect text = tester.getRect(_key('palette-base-value'));
      // The code sits towards the right (the start), the search glyph is at
      // the left end.
      expect(text.right, greaterThan(box.center.dx));
      final Rect glyph = tester.getRect(
        find.descendant(of: _field, matching: find.byType(InkIcon)),
      );
      expect(glyph.left, lessThan(box.center.dx));
      expect(tester.takeException(), isNull);

      await openBaseSheet(tester);
      expect(_key('palette-base-picker'), findsOneWidget);
      expect(_searchFocused(tester), isTrue);
      expect(tester.takeException(), isNull);
    });
  });

  group('on a small phone', () {
    testWidgets('large text: no overflow, size drops below, the list opens', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      _phone(tester, scale: 2);
      await tester.pumpAndSettle();

      await chooseBase(tester, 'B08');
      expect(tester.takeException(), isNull);
      final Rect field = tester.getRect(_field);
      expect(field.left, greaterThanOrEqualTo(0));
      expect(field.right, lessThanOrEqualTo(360));

      await openBaseSheet(tester);
      expect(_key('palette-base-picker'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('keyboard up: the list stays visible above it and scrolls', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      _phone(tester);
      await tester.pumpAndSettle();

      await openBaseSheet(tester);
      await _keyboard(tester, 300);

      expect(_searchFocused(tester), isTrue);
      expect(tester.takeException(), isNull);
      // The whole sheet sits above the keyboard.
      final Rect sheet = tester.getRect(_key('palette-base-picker'));
      expect(sheet.bottom, lessThanOrEqualTo(640 - 300));
      // The search and some rows are on screen, and the list scrolls.
      expect(
        tester.getRect(_key('palette-picker-search')).top,
        greaterThanOrEqualTo(0),
      );
      final Finder rows = find.descendant(
        of: _key('palette-base-picker'),
        matching: find.byType(InkWell),
      );
      expect(rows, findsWidgets);
      final Finder list = find.descendant(
        of: _key('palette-base-picker'),
        matching: find.byType(ListView),
      );
      final Rect listBox = tester.getRect(list);
      expect(listBox.height, greaterThan(100));
      expect(listBox.bottom, lessThanOrEqualTo(640 - 300));
      await tester.drag(list, const Offset(0, -200));
      await tester.pumpAndSettle();
      expect(_key('palette-base-picker'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('keyboard up and large text: still no overflow', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      _phone(tester, scale: 2);
      await tester.pumpAndSettle();

      await openBaseSheet(tester);
      await _keyboard(tester, 300);

      expect(tester.takeException(), isNull);
      expect(_key('palette-picker-search'), findsOneWidget);
      final Rect sheet = tester.getRect(_key('palette-base-picker'));
      expect(sheet.bottom, lessThanOrEqualTo(640 - 300));
      // The list still has room above the keyboard, and shows a row.
      final Finder list = find.descendant(
        of: _key('palette-base-picker'),
        matching: find.byType(ListView),
      );
      final Rect listBox = tester.getRect(list);
      expect(listBox.height, greaterThan(0));
      expect(listBox.bottom, lessThanOrEqualTo(640 - 300));
      expect(
        find.descendant(of: list, matching: find.byType(InkWell)),
        findsWidgets,
      );
    });

    testWidgets('the keyboard closing hands the room back to the list', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      _phone(tester);
      await tester.pumpAndSettle();
      await openBaseSheet(tester);
      await _keyboard(tester, 300);
      final Finder list = find.descendant(
        of: _key('palette-base-picker'),
        matching: find.byType(ListView),
      );
      final double withKeyboard = tester.getRect(list).height;

      await _keyboard(tester, 0);

      expect(tester.getRect(list).height, greaterThan(withKeyboard));
    });
  });

  group('the measured widths', () {
    Widget host({
      Locale locale = const Locale('en'),
      bool bold = false,
      String example = 'B08',
      TextStyle? inherited,
    }) => MaterialApp(
      locale: locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(boldText: bold),
        child: child!,
      ),
      home: Scaffold(
        body: DefaultTextStyle.merge(
          style: inherited ?? const TextStyle(),
          child: PaletteBaseAndSize(
            customMode: false,
            paletteSize: 4,
            onSizeChanged: (_) {},
            hasChoices: true,
            baseInput: '',
            resolvedBase: null,
            exampleCode: example,
            hint: 'B08 or E12',
            onPickBase: () {},
          ),
        ),
      ),
    );

    Future<int> measuresAfter(WidgetTester tester, Widget app) async {
      final int before = paletteBaseMeasureCount;
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      return paletteBaseMeasureCount - before;
    }

    testWidgets('are kept across builds and dropped when the text changes', (
      WidgetTester tester,
    ) async {
      expect(await measuresAfter(tester, host()), 1);
      // The same inputs, built again: nothing is measured again.
      expect(await measuresAfter(tester, host()), 0);
      // Bold text, another language, another inherited style, another
      // example code: each one measures again.
      expect(await measuresAfter(tester, host(bold: true)), 1);
      expect(await measuresAfter(tester, host(bold: true)), 0);
      expect(
        await measuresAfter(
          tester,
          host(bold: true, locale: const Locale('de')),
        ),
        1,
      );
      expect(
        await measuresAfter(
          tester,
          host(
            bold: true,
            locale: const Locale('de'),
            inherited: const TextStyle(wordSpacing: 3),
          ),
        ),
        1,
      );
      expect(
        await measuresAfter(
          tester,
          host(
            bold: true,
            locale: const Locale('de'),
            inherited: const TextStyle(wordSpacing: 3),
            example: 'BV310',
          ),
        ),
        1,
      );
    });

    testWidgets('are dropped when the fonts of the system change', (
      WidgetTester tester,
    ) async {
      await measuresAfter(tester, host());
      final int before = paletteBaseMeasureCount;
      await PaintingBinding.instance.handleSystemMessage(<String, dynamic>{
        'type': 'fontsChange',
      });
      await tester.pumpAndSettle();
      expect(paletteBaseMeasureCount - before, 1);
    });
  });
}
