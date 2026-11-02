import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';

import '../support/l10n.dart';

/// About the width a role label has in a suggestion row at 360 dp (the row
/// minus the card padding and the lock button).
const double _roleWidth = 240;

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// A phone 360 dp wide: the narrowest one the layout supports.
void _phone360(WidgetTester tester) {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

Future<AppScope> _pumpSpanish(
  WidgetTester tester,
  Widget page, {
  double textScale = 1.0,
}) async {
  _phone360(tester);
  final AppScope scope = AppScope.inMemory(markers: _markers(), child: page);
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: Scaffold(body: scope),
    ),
  );
  await tester.pumpAndSettle();
  return scope;
}

/// Every language of the app.
const List<String> _languages = <String>['en', 'es', 'de', 'fr', 'pt', 'it'];

/// The text of every `role...` message of the ARB of [locale].
List<String> _roles(String locale) {
  final Map<String, dynamic> arb = jsonDecode(
    File('lib/l10n/app_$locale.arb').readAsStringSync(),
  ) as Map<String, dynamic>;
  return <String>[
    for (final MapEntry<String, dynamic> e in arb.entries)
      if (e.key.startsWith('role')) e.value as String,
  ];
}

/// The text of every scene role that scenes.json translates into [locale].
List<String> _sceneRoles(String locale) {
  final Map<String, dynamic> roles =
      (jsonDecode(File('assets/data/scenes.json').readAsStringSync())
              as Map<String, dynamic>)['roles']
          as Map<String, dynamic>;
  return <String>[
    for (final dynamic names in roles.values)
      (names as Map<String, dynamic>)[locale] as String,
  ];
}

void main() {
  setUpAll(loadAppFonts);

  group('Settings in Spanish', () {
    testWidgets('renders in Spanish with no overflow at 360 dp', (
      WidgetTester tester,
    ) async {
      await _pumpSpanish(tester, const SettingsPage());

      expect(find.text('Ajustes'), findsOneWidget);
      expect(find.text(AppTypography.caps('Mi colección')), findsOneWidget);
      expect(find.text('Ohuhu'), findsWidgets);
      expect(find.text('Oahu · 1 set · 161 rotuladores'), findsOneWidget);
      expect(find.text('Repetir la configuración'), findsOneWidget);
      expect(find.text(AppTypography.caps('Pantalla')), findsOneWidget);
      expect(find.text('Aspecto'), findsOneWidget);
      expect(find.text('Idioma'), findsOneWidget);
      expect(find.text('Códigos de Ohuhu'), findsOneWidget);
      expect(find.text('Sistema'), findsWidgets);
      // One Language row: the choice is its value, the list is in a picker.
      expect(find.text('English'), findsNothing);
      expect(find.text('Settings'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('scrolling the whole page throws no layout error', (
      WidgetTester tester,
    ) async {
      await _pumpSpanish(tester, const SettingsPage());
      final Finder list = find.byType(ListView).first;
      for (var i = 0; i < 12; i++) {
        await tester.drag(list, const Offset(0, -600));
        await tester.pump();
        expect(tester.takeException(), isNull, reason: 'after scroll $i');
      }
      await tester.pumpAndSettle();
      expect(find.text(AppTypography.caps('Acerca de')), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the AI section reads in Spanish', (WidgetTester tester) async {
      await _pumpSpanish(tester, const SettingsPage());
      await tester.ensureVisible(
        find.text(AppTypography.caps('Asistente de IA')).first,
      );
      await tester.pumpAndSettle();
      expect(find.text('Sugerir con IA'), findsOneWidget);
      // With the AI off the card shows the switch and one line: no provider.
      expect(
        find.text('La IA solo sugiere paletas. Nunca cambia tu colección.'),
        findsOneWidget,
      );
      expect(find.text('Teoría del color'), findsNothing);

      // Turning it on brings the provider.
      await tester.tap(find.text('Sugerir con IA'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const ValueKey<String>('ai-disclosure-confirm')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Teoría del color'), findsWidgets);
      expect(find.text('OpenRouter'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('Diary in Spanish', () {
    for (final double scale in <double>[1.0, 1.3]) {
      testWidgets('the list and the form fit at 360 dp, text x$scale', (
        WidgetTester tester,
      ) async {
        await _pumpSpanish(tester, const IdeasPage(), textScale: scale);
        await tester.tap(find.text('Diario'));
        await tester.pumpAndSettle();
        expect(find.text('Tu diario está vacío'), findsOneWidget);
        expect(find.text('Añadir al diario'), findsOneWidget);
        expect(tester.takeException(), isNull);

        await tester.tap(find.text('Añadir al diario'));
        await tester.pumpAndSettle();
        expect(find.text('Nueva entrada'), findsOneWidget);
        expect(find.text('Terminada'), findsOneWidget);
        expect(find.text('En curso'), findsOneWidget);
        expect(find.text('Guardar entrada'), findsOneWidget);
        expect(tester.takeException(), isNull);
        final Finder list = find.byType(Scrollable).first;
        for (var i = 0; i < 6; i++) {
          await tester.drag(list, const Offset(0, -500));
          await tester.pump();
          expect(tester.takeException(), isNull, reason: 'after scroll $i');
        }
      });
    }
  });

  group('Palette in Spanish', () {
    testWidgets('builds a palette with no overflow at 360 dp', (
      WidgetTester tester,
    ) async {
      await _pumpSpanish(tester, const PalettePage());
      expect(find.text(AppTypography.caps('Rotulador base')), findsWidgets);
      expect(
        find.byKey(const ValueKey<String>('palette-saved-palettes')),
        findsOneWidget,
      );

      await tester.enterText(
        find.byKey(const ValueKey<String>('palette-base-input')),
        'B08',
      );
      await tester.pumpAndSettle();
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();

      expect(find.textContaining('Combinaciones ('), findsOneWidget);
      expect(find.textContaining('Combinations'), findsNothing);
      expect(find.textContaining('rotuladores disponibles'), findsWidgets);
      expect(tester.takeException(), isNull);

      // Every role label is one line that fits, never cut.
      final Finder roles = find.byType(RoleLabel);
      expect(roles, findsWidgets);
      for (final Element element in roles.evaluate()) {
        final Finder text = find.descendant(
          of: find.byWidget(element.widget),
          matching: find.byType(Text),
        );
        final RenderParagraph paragraph = tester.renderObject(text);
        expect(paragraph.didExceedMaxLines, isFalse);
        expect(paragraph.size.width, lessThanOrEqualTo(_roleWidth));
      }
    });

    testWidgets('scenario mode shows translated scenes and roles', (
      WidgetTester tester,
    ) async {
      await _pumpSpanish(tester, const PalettePage());
      await tester.tap(
        find.byKey(const ValueKey<String>('palette-type-field')),
      );
      await tester.pumpAndSettle();
      final Finder toggle = find.byKey(
        const ValueKey<String>('palette-scenario-toggle'),
      );
      await tester.ensureVisible(toggle);
      await tester.pumpAndSettle();
      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(find.text('Personaje fantasma'), findsWidgets);
      expect(find.text('Ghost Character'), findsNothing);
      // The scene sheet lists the Spanish names and categories.
      await tester.tap(
        find.byKey(const ValueKey<String>('palette-scene-field')),
      );
      await tester.pumpAndSettle();
      expect(find.text('PERSONAJES'), findsOneWidget);
      expect(find.text('Personaje fantasma'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });

  group('the role column', () {
    Future<void> pumpRole(
      WidgetTester tester,
      String role, {
      double textScale = 1.0,
      String locale = 'es',
    }) async {
      _phone360(tester);
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(locale),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          theme: AppTheme.light(),
          builder: (BuildContext context, Widget? child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          home: Scaffold(
            body: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: _roleWidth,
                child: RoleLabel(
                  text: role,
                  style: AppTypography.capsStyle.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('COMPLEMENTARIO, the longest word, fits on one line', (
      WidgetTester tester,
    ) async {
      expect(l10nEs.roleComplement, 'Complementario');
      await pumpRole(tester, l10nEs.roleComplement);

      final RenderParagraph paragraph = tester.renderObject(find.byType(Text));
      expect(paragraph.didExceedMaxLines, isFalse);
      // One line of the 12/16 caps style is 16 dp high.
      expect(paragraph.size.height, lessThan(20));
      expect(paragraph.size.width, lessThanOrEqualTo(_roleWidth));
      expect(find.text('COMPLEMENTARIO'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    for (final String locale in _languages) {
      testWidgets(
        'every $locale role fits its column, at normal and large text',
        (WidgetTester tester) async {
          final List<String> roles = <String>[
            ..._roles(locale),
            // English scene roles are the role ids themselves, which the
            // palette shows untranslated.
            if (locale != 'en') ..._sceneRoles(locale),
          ];
          expect(roles.length, greaterThan(150));
          for (final double scale in <double>[1.0, 1.4]) {
            for (final String role in roles) {
              await pumpRole(tester, role, textScale: scale, locale: locale);
              final RenderParagraph paragraph = tester.renderObject(
                find.byType(Text),
              );
              expect(
                paragraph.didExceedMaxLines,
                isFalse,
                reason: '$locale "$role" at x$scale',
              );
              expect(
                paragraph.size.width,
                lessThanOrEqualTo(_roleWidth),
                reason: '$locale "$role" at x$scale',
              );
              expect(
                tester.takeException(),
                isNull,
                reason: '$locale "$role" at x$scale',
              );
            }
          }
        },
      );
    }

    testWidgets('the word is not shrunk when it already fits', (
      WidgetTester tester,
    ) async {
      await pumpRole(tester, 'Sombra');
      final Text text = tester.widget(find.byType(Text));
      expect(text.style?.fontSize, AppTypography.capsStyle.fontSize);
    });
  });
}
