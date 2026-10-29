import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';

import '../support/l10n.dart';

AppScope _scope() => AppScope.inMemory(
  markers: MarkerRepository(
    loadAsset: (String path) => File(path).readAsStringSync(),
  ),
  child: const InkLabApp(),
);

Future<AppScope> _pump(
  WidgetTester tester, {
  required List<Locale> device,
  AppLanguage? language,
}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  useDeviceLocales(tester, device);
  final AppScope scope = _scope();
  if (language != null) await scope.settings.setLanguage(language);
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

AppLocalizations _current(WidgetTester tester) =>
    tester.element(find.byType(AppShell)).l10n;

void main() {
  group('the language follows the device by default', () {
    testWidgets('Spanish (Spain) device shows Spanish', (tester) async {
      await _pump(tester, device: const <Locale>[Locale('es', 'ES')]);
      expect(_current(tester).localeName, 'es');
      expect(find.text('Muestras'), findsWidgets);
      expect(find.text('Ajustes'), findsWidgets);
    });

    testWidgets('any other Spanish locale shows Spanish', (tester) async {
      await _pump(tester, device: const <Locale>[Locale('es', 'MX')]);
      expect(_current(tester).localeName, 'es');
      await tester.pumpWidget(const SizedBox.shrink());

      await _pump(tester, device: const <Locale>[Locale('es', '419')]);
      expect(_current(tester).localeName, 'es');
    });

    testWidgets('an English device shows English', (tester) async {
      await _pump(tester, device: const <Locale>[Locale('en', 'GB')]);
      expect(_current(tester).localeName, 'en');
      expect(find.text('Swatches'), findsWidgets);
    });

    testWidgets('a device in another language falls back to English', (
      tester,
    ) async {
      await _pump(tester, device: const <Locale>[Locale('fr', 'FR')]);
      expect(_current(tester).localeName, 'en');
      expect(find.text('Settings'), findsWidgets);
    });
  });

  group('the language setting overrides the device', () {
    testWidgets('Español on an English device', (tester) async {
      await _pump(
        tester,
        device: const <Locale>[Locale('en', 'US')],
        language: AppLanguage.spanish,
      );
      expect(_current(tester).localeName, 'es');
      expect(find.text('Paleta'), findsWidgets);
    });

    testWidgets('English on a Spanish device', (tester) async {
      await _pump(
        tester,
        device: const <Locale>[Locale('es', 'ES')],
        language: AppLanguage.english,
      );
      expect(_current(tester).localeName, 'en');
      expect(find.text('Palette'), findsWidgets);
    });

    testWidgets('changing it switches the open app live', (tester) async {
      final AppScope scope = await _pump(
        tester,
        device: const <Locale>[Locale('en', 'US')],
      );
      expect(find.text('Settings'), findsWidgets);

      await scope.settings.setLanguage(AppLanguage.spanish);
      await tester.pumpAndSettle();
      expect(find.text('Ajustes'), findsWidgets);
      expect(find.text('Settings'), findsNothing);

      await scope.settings.setLanguage(AppLanguage.system);
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsWidgets);
    });
  });

  testWidgets('the Language control in Settings > Display drives it', (
    tester,
  ) async {
    final AppScope scope = await _pump(
      tester,
      device: const <Locale>[Locale('en', 'US')],
    );
    await tester.tap(find.text('Settings').last);
    await tester.pumpAndSettle();

    final Finder spanishSegment = find.text('Español');
    await tester.ensureVisible(spanishSegment);
    await tester.pumpAndSettle();
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('System'), findsWidgets);

    await tester.tap(spanishSegment);
    await tester.pumpAndSettle();
    expect(scope.settings.language, AppLanguage.spanish);
    expect(find.text('Idioma'), findsOneWidget);

    await tester.ensureVisible(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(scope.settings.language, AppLanguage.english);
    expect(find.text('Language'), findsOneWidget);
  });
}
