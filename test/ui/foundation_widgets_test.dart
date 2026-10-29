import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/empty_state.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_search_field.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';
import 'package:ink_lab/ui/widgets/ink_switch.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';
import 'package:ink_lab/ui/widgets/swatch_list_tile.dart';

import '../support/l10n.dart';

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
}

void _noop() {}
