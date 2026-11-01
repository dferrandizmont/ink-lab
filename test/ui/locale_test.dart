import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/settings/language_section.dart';
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

    testWidgets('an unsupported first language falls to the next one', (
      tester,
    ) async {
      await _pump(
        tester,
        device: const <Locale>[Locale('ca', 'ES'), Locale('es', 'ES')],
      );
      expect(_current(tester).localeName, 'es');
    });

    testWidgets('a device in another language falls back to English', (
      tester,
    ) async {
      await _pump(tester, device: const <Locale>[Locale('ja', 'JP')]);
      expect(_current(tester).localeName, 'en');
      expect(find.text('Settings'), findsWidgets);
    });

    for (final (Locale device, String code) in <(Locale, String)>[
      (const Locale('de', 'DE'), 'de'),
      (const Locale('de', 'AT'), 'de'),
      (const Locale('fr', 'FR'), 'fr'),
      (const Locale('fr', 'CA'), 'fr'),
      (const Locale('pt', 'PT'), 'pt'),
      // A Brazilian device gets European Portuguese: the only one shipped.
      (const Locale('pt', 'BR'), 'pt'),
      (const Locale('it', 'IT'), 'it'),
    ]) {
      testWidgets('a $device device shows $code', (tester) async {
        await _pump(tester, device: <Locale>[device]);
        expect(_current(tester).localeName, code);
        expect(
          find.text(lookupAppLocalizations(Locale(code)).settingsTitle),
          findsWidgets,
        );
      });
    }
  });

  testWidgets('the resolver keeps the language and drops the region', (
    tester,
  ) async {
    await _pump(tester, device: const <Locale>[Locale('en', 'US')]);
    final LocaleListResolutionCallback resolve = tester
        .widget<MaterialApp>(find.byType(MaterialApp))
        .localeListResolutionCallback!;
    const List<Locale> supported = AppLocalizations.supportedLocales;
    for (final String code in <String>['en', 'es', 'de', 'fr', 'pt', 'it']) {
      expect(resolve(<Locale>[Locale(code, 'XX')], supported), Locale(code));
    }
    expect(
      resolve(const <Locale>[Locale('nl')], supported),
      const Locale('en'),
    );
    expect(resolve(const <Locale>[], supported), const Locale('en'));
    expect(resolve(null, supported), const Locale('en'));
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

  group('each language can be forced on a device in another one', () {
    for (final AppLanguage language in AppLanguage.values) {
      final String? code = language.languageCode;
      if (code == null) continue;
      testWidgets(language.name, (tester) async {
        await _pump(
          tester,
          device: const <Locale>[Locale('ja', 'JP')],
          language: language,
        );
        expect(_current(tester).localeName, code);
        expect(
          find.text(lookupAppLocalizations(Locale(code)).settingsTitle),
          findsWidgets,
        );
      });
    }
  });

  testWidgets('the Language row in Settings > Display opens a picker', (
    tester,
  ) async {
    final AppScope scope = await _pump(
      tester,
      device: const <Locale>[Locale('en', 'US')],
    );
    await tester.tap(find.text('Settings').last);
    await tester.pumpAndSettle();

    Future<void> choose(String label) async {
      final Finder row = find.byKey(LanguageSection.rowKey);
      await tester.ensureVisible(row);
      await tester.pumpAndSettle();
      await tester.tap(row);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byKey(const ValueKey<String>('language-list')),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
      // The sheet closes on selection.
      expect(find.byKey(const ValueKey<String>('language-list')), findsNothing);
    }

    expect(find.text('Language'), findsOneWidget);

    await choose('Español');
    expect(scope.settings.language, AppLanguage.spanish);
    expect(find.text('Idioma'), findsOneWidget);

    await choose('English');
    expect(scope.settings.language, AppLanguage.english);
    expect(find.text('Language'), findsOneWidget);

    // The four new languages, each named in itself.
    for (final (String label, AppLanguage language, String title)
        in <(String, AppLanguage, String)>[
          ('Deutsch', AppLanguage.german, 'Sprache'),
          ('Français', AppLanguage.french, 'Langue'),
          ('Português', AppLanguage.portuguese, 'Idioma'),
          ('Italiano', AppLanguage.italian, 'Lingua'),
        ]) {
      await choose(label);
      expect(scope.settings.language, language);
      expect(find.text(title), findsOneWidget, reason: label);
      // The row now shows the choice as its value.
      expect(
        find.descendant(
          of: find.byKey(LanguageSection.rowKey),
          matching: find.text(label),
        ),
        findsOneWidget,
        reason: label,
      );
    }
  });
}
