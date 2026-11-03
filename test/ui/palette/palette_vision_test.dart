import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/color_vision.dart';
import 'package:ink_lab/ui/pages/palette/palette_vision.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../support/fake_share_sink.dart';
import '../../support/l10n.dart';
import 'palette_test_support.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

List<String> _stripColors(WidgetTester tester, {int at = 0}) => tester
    .widgetList<PaletteStrip>(find.byType(PaletteStrip))
    .elementAt(at)
    .colors;

Future<void> _choose(WidgetTester tester, String label) async {
  final Finder segment = find.descendant(
    of: _key('palette-vision'),
    matching: find.text(label),
  );
  await tester.ensureVisible(segment);
  await tester.pumpAndSettle();
  await tester.tap(segment);
  await tester.pumpAndSettle();
}

/// Lets the real asynchronous rendering finish, then settles the widgets.
Future<void> _untilShared(
  WidgetTester tester,
  FakeShareSink sink,
  int n,
) async {
  await tester.runAsync(() async {
    for (int i = 0; i < 600 && sink.shared.length < n; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await tester.pump();
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await tester.pump();
  });
  await tester.pump();
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  group('Palette: colour vision preview', () {
    testWidgets('the sheet is as tall as its content, so the palette shows', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');
      await tapResultItem(tester, 'palette-vision-open');
      await _choose(tester, colorVisionLabelOf(ColorVisionType.protanopia));

      final double screen =
          tester.view.physicalSize.height / tester.view.devicePixelRatio;
      final double control = tester.getSize(_key('palette-vision')).height;
      expect(control, lessThan(screen / 3));
    });

    testWidgets('is offered once there is a palette, starting at Normal', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      expect(_key('palette-overflow'), findsNothing);
      expect(_key('palette-vision'), findsNothing);

      await enterBaseCode(tester, 'B08');

      // The preview lives in its own sheet, opened from the result's "⋯".
      expect(_key('palette-overflow'), findsOneWidget);
      await tapResultItem(tester, 'palette-vision-open');

      expect(_key('palette-vision'), findsOneWidget);
      for (final ColorVisionType? type in <ColorVisionType?>[
        null,
        ...ColorVisionType.values,
      ]) {
        expect(
          find.descendant(
            of: _key('palette-vision'),
            matching: find.text(colorVisionLabelOf(type)),
          ),
          findsOneWidget,
          reason: '$type',
        );
      }
      // Normal: nothing but the control, no warning.
      expect(_key('palette-vision-note'), findsNothing);
      expect(_key('palette-vision-pairs'), findsNothing);
      expect(_key('palette-vision-clear'), findsNothing);
    });

    testWidgets('draws the strip as seen with the chosen deficiency', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');
      final List<String> normal = _stripColors(tester);
      expect(normal, isNotEmpty);
      await tapResultItem(tester, 'palette-vision-open');

      for (final ColorVisionType type in ColorVisionType.values) {
        await _choose(tester, colorVisionLabelOf(type));
        expect(_stripColors(tester), <String>[
          for (final String hex in normal) ColorVision.simulate(hex, type),
        ], reason: type.name);
        expect(_key('palette-vision-note'), findsOneWidget);
        // Either the pairs that get hard to tell apart, or that there are none.
        expect(
          _key('palette-vision-pairs').evaluate().length +
              _key('palette-vision-clear').evaluate().length,
          1,
          reason: type.name,
        );
      }

      await _choose(tester, colorVisionLabelOf(null));
      expect(_stripColors(tester), normal);
      expect(_key('palette-vision-note'), findsNothing);
    });

    testWidgets('the shared image keeps the true colours', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await pumpPalette(tester, shareSink: sink);
      await enterBaseCode(tester, 'B08');

      await tapResultItem(tester, 'palette-share', settle: false);
      await _untilShared(tester, sink, 1);

      await tapResultItem(tester, 'palette-vision-open');
      await _choose(tester, colorVisionLabelOf(ColorVisionType.achromatopsia));
      // The preview only changes what is drawn: close its sheet and share.
      await closeSheet(tester);
      await tapResultItem(tester, 'palette-share', settle: false);
      await _untilShared(tester, sink, 2);

      expect(sink.shared, hasLength(2));
      expect(
        sink.shared[1].single.bytes,
        sink.shared[0].single.bytes,
        reason:
            'the image shared while previewing is the one of the true '
            'colours',
      );
    });
  });

  group('PaletteVisionControl', () {
    Widget host(
      List<String> colors,
      List<String> labels,
      ColorVisionType type,
    ) {
      return MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: testLocalizationsDelegates,
        supportedLocales: testSupportedLocales,
        theme: AppTheme.light(),
        home: Scaffold(
          body: PaletteVisionControl(
            selected: type,
            onChanged: (_) {},
            colors: colors,
            labels: labels,
          ),
        ),
      );
    }

    testWidgets('names the colours that become hard to tell apart', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        host(
          <String>['ff0000', 'ff0000', '0000ff'],
          <String>['R1', 'R2', 'B1'],
          ColorVisionType.deuteranopia,
        ),
      );
      final Text text = tester.widget<Text>(_key('palette-vision-pairs'));
      expect(text.data, l10n.paletteVisionPairs('R1 / R2'));
    });

    testWidgets('counts the pairs it does not name', (
      WidgetTester tester,
    ) async {
      // Five identical colours: ten pairs, three named.
      await tester.pumpWidget(
        host(List<String>.filled(5, 'ff0000'), <String>[
          'A',
          'B',
          'C',
          'D',
          'E',
        ], ColorVisionType.protanopia),
      );
      final Text text = tester.widget<Text>(_key('palette-vision-pairs'));
      expect(text.data, contains(l10n.paletteVisionPairsMore(7)));
    });

    testWidgets('says nothing is lost when every colour stays apart', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        host(
          <String>['ff0000', '0000ff'],
          <String>['R1', 'B1'],
          ColorVisionType.achromatopsia,
        ),
      );
      expect(find.text(l10n.paletteVisionNoPairs), findsOneWidget);
    });
  });
}

/// The label the control shows for [type] in English.
String colorVisionLabelOf(ColorVisionType? type) => switch (type) {
  null => l10n.paletteVisionNormal,
  ColorVisionType.protanopia => l10n.paletteVisionProtanopia,
  ColorVisionType.deuteranopia => l10n.paletteVisionDeuteranopia,
  ColorVisionType.tritanopia => l10n.paletteVisionTritanopia,
  ColorVisionType.achromatopsia => l10n.paletteVisionAchromatopsia,
};
