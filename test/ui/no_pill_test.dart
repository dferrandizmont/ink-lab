import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_search_field.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';

import '../support/l10n.dart';
import '../support/pill_shapes.dart';

// One small radius scale app-wide (controls 8–10, cards 12): no control is a
// pill. Every screen is also checked by text_fit_test, which runs
// pillShapes() after each step.

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      home: Scaffold(
        body: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  test('the radius scale has no pill outside the nav indicator and switch', () {
    for (final double r in <double>[
      InkRadii.xs,
      InkRadii.sm,
      InkRadii.cell,
      InkRadii.control,
      InkRadii.segment,
      InkRadii.input,
      InkRadii.card,
    ]) {
      expect(r, lessThan(pillRadius));
    }
  });

  testWidgets('design G controls, cards and fields are not pills', (
    WidgetTester tester,
  ) async {
    await _pump(
      tester,
      ListView(
        children: <Widget>[
          InkButton(label: 'Primary', onPressed: () {}),
          InkButton.secondary(label: 'Secondary', onPressed: () {}),
          InkButton.text(label: 'Text', onPressed: () {}),
          FilledButton(onPressed: () {}, child: const Text('Filled')),
          OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
          InkChip(label: 'Chip', selected: true, onSelected: (_) {}),
          InkChip(label: 'Chip', selected: false, onSelected: (_) {}),
          const QualityBadge('Close'),
          InkSegmented<int>(
            segments: const <InkSegment<int>>[
              InkSegment<int>(value: 0, label: 'One'),
              InkSegment<int>(value: 1, label: 'Two'),
            ],
            selected: 0,
            onChanged: (_) {},
          ),
          const InkSearchField(hintText: 'Search'),
          const TextField(),
          const Card(child: SizedBox(height: 60)),
        ],
      ),
    );
    expect(pillShapes(tester), isEmpty);
  });

  testWidgets('the check catches a pill button', (WidgetTester tester) async {
    await _pump(
      tester,
      FilledButton(
        style: FilledButton.styleFrom(shape: const StadiumBorder()),
        onPressed: () {},
        child: const Text('Pill'),
      ),
    );
    expect(pillShapes(tester), isNotEmpty);
  });

  testWidgets('the check catches a 20-radius chip-like box', (
    WidgetTester tester,
  ) async {
    await _pump(
      tester,
      const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SizedBox(width: 80, height: 32),
      ),
    );
    expect(pillShapes(tester), isNotEmpty);
  });
}
