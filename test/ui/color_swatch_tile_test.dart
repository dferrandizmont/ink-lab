import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';

import '../support/l10n.dart';

Future<void> pumpTile(
  WidgetTester tester, {
  required String hex,
  String code = 'A1',
  String? name,
  bool selected = false,
  bool favorite = false,
  bool owned = false,
  double? height,
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: theme ?? AppTheme.light(),
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 116,
            child: ColorSwatchTile(
              hex: hex,
              code: code,
              name: name,
              selected: selected,
              favorite: favorite,
              owned: owned,
              height: height,
            ),
          ),
        ),
      ),
    ),
  );
}

/// Every marker hex of the bundled datasets.
List<String> datasetHexes() {
  final List<String> hexes = <String>[];
  for (final FileSystemEntity file in Directory('assets/data').listSync()) {
    if (!file.path.endsWith('.json')) {
      continue;
    }
    final Object? json = jsonDecode(File(file.path).readAsStringSync());
    if (json is List) {
      for (final Object? entry in json) {
        if (entry is Map && entry['hex'] is String) {
          hexes.add(entry['hex'] as String);
        }
      }
    }
  }
  return hexes;
}

void main() {
  test('inkOn picks pure black or white with >= 4.5:1 on every marker', () {
    final List<String> hexes = datasetHexes();
    expect(hexes.length, greaterThan(300));
    for (final String hex in hexes) {
      final Color swatch = swatchColor(hex);
      final Color ink = swatchContentColor(hex);
      expect(ink, anyOf(Colors.black, Colors.white), reason: hex);
      expect(
        contrastRatio(ink, swatch),
        greaterThanOrEqualTo(4.5),
        reason: 'text on $hex',
      );
    }
  });

  test('inkOn follows the WCAG rule of the spec', () {
    expect(inkOn(const Color(0xFF000000)), Colors.white);
    expect(inkOn(const Color(0xFFFFFFFF)), Colors.black);
    expect(inkOn(const Color(0xFFEE8354)), Colors.black);
    expect(inkOn(const Color(0xFF2D6E9C)), Colors.white);
  });

  test('the swatch edge rule uses the theme threshold', () {
    const Color pale = Color(0xFFF5F3C4);
    const Color mid = Color(0xFF82DCFA);
    const Color deep = Color(0xFF2D6E9C);
    expect(InkColors.light.swatchEdge(pale), InkColors.light.edge);
    expect(InkColors.light.swatchEdge(deep), deep);
    expect(InkColors.dark.swatchEdge(mid), InkColors.dark.edge);
    expect(InkColors.dark.swatchEdge(deep), deep);
  });

  testWidgets('the cell shows code, name, hex, owned and favourite', (
    WidgetTester tester,
  ) async {
    await pumpTile(
      tester,
      hex: 'ee8354',
      code: 'YR57',
      name: 'Tropical Peach',
      favorite: true,
      owned: true,
    );

    expect(find.text('YR57'), findsOneWidget);
    expect(find.text('Tropical Peach'), findsOneWidget);
    expect(find.text('#EE8354'), findsOneWidget);
    expect(find.bySemanticsLabel('Owned'), findsOneWidget);
    expect(find.bySemanticsLabel('Favourite'), findsOneWidget);
    final InkIcon star = tester.widget(
      find.byWidgetPredicate(
        (Widget w) => w is InkIcon && w.icon == InkIcons.star,
      ),
    );
    expect(star.color, Colors.black);
    expect(star.filled, isTrue);
    // 72 colour block + 8 + 22 + 40 + 16 + 10 body.
    expect(tester.getSize(find.byType(ColorSwatchTile)).height, 174);
  });

  testWidgets('a selected cell is outlined in action', (
    WidgetTester tester,
  ) async {
    await pumpTile(tester, hex: '#2D6E9C', selected: true);

    final Material card = tester.widget(
      find
          .descendant(
            of: find.byType(ColorSwatchTile),
            matching: find.byType(Material),
          )
          .first,
    );
    final RoundedRectangleBorder shape = card.shape! as RoundedRectangleBorder;
    expect(shape.side.color, InkColors.light.action);
    expect(shape.borderRadius, InkRadii.cellRadius);
  });

  testWidgets('a short cell drops lines instead of overflowing', (
    WidgetTester tester,
  ) async {
    await pumpTile(
      tester,
      hex: '#2D6E9C',
      name: 'Cerulean Blue with a long name',
      height: 104,
      theme: AppTheme.dark(),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('A1'), findsOneWidget);
    expect(find.text('#2D6E9C'), findsNothing);
  });
}
