import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/pages/settings/settings_widgets.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/one_line_text.dart';

import '../../support/l10n.dart';

// The one-line switch row ("Mix my brands" among the one-line rows of My
// collection): its title shrinks a little to stay on one line, but never
// past [paletteMinLineScale].

Future<void> _pump(
  WidgetTester tester,
  String label, {
  required double width,
  double scale = 1,
}) async {
  tester.view.physicalSize = Size(width, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: SettingsSwitchRow(
            label: label,
            subtitle: 'Ohuhu + DecoTime',
            singleLine: true,
            value: false,
            onChanged: (bool _) {},
          ),
        ),
      ),
    ),
  );
}

/// The factor the title is drawn at: 1, or what its FittedBox scales it to.
double _titleScale(WidgetTester tester, String label) {
  final Finder fitted = find.ancestor(
    of: find.text(label),
    matching: find.byType(FittedBox),
  );
  if (fitted.evaluate().isEmpty) return 1;
  return tester.getSize(fitted).width / tester.getSize(find.text(label)).width;
}

void main() {
  setUpAll(loadAppFonts);

  const String label = 'Mix my brands';
  const String long = 'Meine Marken miteinander mischen und kombinieren';

  testWidgets('a title that fits is one line at its own size', (tester) async {
    await _pump(tester, label, width: 360);
    expect(tester.takeException(), isNull);
    expect(_titleScale(tester, label), 1);
    final Text title = tester.widget<Text>(find.text(label));
    expect(title.style!.fontSize, AppTypography.body.fontSize);
    expect(title.maxLines, 1);
  });

  testWidgets('a title a little too wide shrinks, no more than allowed', (
    tester,
  ) async {
    // The room the title has is the screen less a fixed amount (paddings,
    // the switch): find it, then leave nine tenths of what the title needs.
    await _pump(tester, long, width: 700);
    expect(_titleScale(tester, long), 1);
    final double natural = tester.getSize(find.text(long)).width;
    // (The column of the two lines is as wide as that room.)
    final double room = tester
        .getSize(
          find
              .ancestor(of: find.text(long), matching: find.byType(Column))
              .first,
        )
        .width;
    expect(room, greaterThan(natural));
    await _pump(tester, long, width: 700 - room + natural * 0.9);
    expect(tester.takeException(), isNull);
    final double scale = _titleScale(tester, long);
    expect(scale, lessThan(1));
    expect(scale, greaterThanOrEqualTo(paletteMinLineScale));
    expect(tester.widget<Text>(find.text(long)).maxLines, 1);
  });

  testWidgets(
    'at a very large text size it wraps, whole, instead of shrinking away',
    (tester) async {
      await _pump(tester, long, width: 320, scale: 3);
      expect(tester.takeException(), isNull);
      // Not scaled by a box: it is laid out at the smallest size allowed.
      expect(
        find.ancestor(of: find.text(long), matching: find.byType(FittedBox)),
        findsNothing,
      );
      final Text title = tester.widget<Text>(find.text(long));
      expect(
        title.style!.fontSize,
        AppTypography.body.fontSize! * paletteMinLineScale,
      );
      // As many lines as it needs, and none of it cut.
      expect(title.maxLines, isNull);
      expect(title.overflow, isNull);
      final RenderParagraph paragraph = tester.renderObject<RenderParagraph>(
        find.text(long),
      );
      expect(paragraph.didExceedMaxLines, isFalse);
      final double line = paragraph.getFullHeightForCaret(
        const TextPosition(offset: 0),
      );
      expect(paragraph.size.height, greaterThan(line * 2));
    },
  );
}
