import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';

import '../support/l10n.dart';

void main() {
  testWidgets('the app boots into the shell and follows the system theme', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    useEnglishDevice(tester);
    await tester.pumpWidget(const InkLabApp());
    await tester.pumpAndSettle();

    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(tester.element(find.byType(AppShell)).l10n.appTitle, 'Ink Lab');
    expect(app.supportedLocales, const <Locale>[Locale('en'), Locale('es')]);
    expect(app.themeMode, ThemeMode.system);
    expect(app.theme, isNotNull);
    expect(app.darkTheme, isNotNull);
    expect(find.byType(AppShell), findsOneWidget);
  });
}
