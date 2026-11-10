import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';

import '../support/l10n.dart';
import 'ideas/ideas_test_support.dart';

Widget _row({required bool fadeEnds}) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: testLocalizationsDelegates,
  supportedLocales: testSupportedLocales,
  theme: AppTheme.light(),
  home: Scaffold(
    body: SizedBox(
      width: 220,
      child: InkChipRow(
        fadeEnds: fadeEnds,
        children: <Widget>[
          for (int i = 0; i < 6; i++)
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
}
