import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/pages/settings/language_section.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/section_card.dart';

import '../../support/l10n.dart';
import 'settings_page_test.dart' show diskMarkers;

/// Settings over a scope, in an app whose locale follows the language setting
/// (like the real shell does).
Future<AppScope> _pump(
  WidgetTester tester, {
  AppLanguage language = AppLanguage.system,
}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: diskMarkers(),
    child: const _LocalizedSettings(),
  );
  await scope.settings.setLanguage(language);
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

class _LocalizedSettings extends StatelessWidget {
  const _LocalizedSettings();

  @override
  Widget build(BuildContext context) {
    final AppScope scope = AppScope.of(context);
    return StreamBuilder<AppSettingsState>(
      stream: scope.settings.changes,
      initialData: scope.settings.state,
      builder: (BuildContext context, AsyncSnapshot<AppSettingsState> s) {
        final String? code = (s.data ?? scope.settings.state)
            .language
            .languageCode;
        return MaterialApp(
          locale: Locale(code ?? 'en'),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          theme: AppTheme.light(),
          home: const Scaffold(body: SettingsPage()),
        );
      },
    );
  }
}

Finder _key(String key) => find.byKey(ValueKey<String>(key));

Future<void> _openPicker(WidgetTester tester) async {
  final Finder row = find.byKey(LanguageSection.rowKey);
  await tester.ensureVisible(row);
  await tester.pumpAndSettle();
  await tester.tap(row);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Display has ONE Language row with the choice as its value', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    final Finder row = find.byKey(LanguageSection.rowKey);
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();

    final InkListRow widget = tester.widget<InkListRow>(row);
    expect(widget.label, l10n.settingsLanguageTitle);
    expect(widget.value, l10n.settingsLanguageSystem);
    expect(widget.chevron, isTrue);
    // No radio list inline any more.
    expect(_key('language-es'), findsNothing);
    expect(_key('language-en'), findsNothing);
    expect(_key('language-system'), findsNothing);
  });

  testWidgets('the row shows the language by its own name', (
    WidgetTester tester,
  ) async {
    await _pump(tester, language: AppLanguage.german);
    final Finder row = find.byKey(LanguageSection.rowKey);
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    final InkListRow widget = tester.widget<InkListRow>(row);
    expect(widget.label, l10nDe.settingsLanguageTitle);
    expect(widget.value, 'Deutsch');
  });

  testWidgets('tapping it lists System first, then every language', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    await _openPicker(tester);

    expect(_key('language-list'), findsOneWidget);
    // Title of the sheet plus the row behind it.
    expect(find.text(l10n.settingsLanguageTitle), findsWidgets);
    final List<AppLanguage> order = AppLanguage.values;
    expect(order.first, AppLanguage.system);
    double? previousTop;
    for (final AppLanguage language in order) {
      final Finder option = _key('language-${language.toJson()}');
      expect(option, findsOneWidget, reason: language.name);
      final double top = tester.getTopLeft(option).dy;
      if (previousTop != null) {
        expect(top, greaterThan(previousTop), reason: language.name);
      }
      previousTop = top;
    }
    for (final String name in <String>[
      l10n.settingsLanguageSystem,
      'Español',
      'English',
      'Deutsch',
      'Français',
      'Português',
      'Italiano',
    ]) {
      expect(
        find.descendant(of: _key('language-list'), matching: find.text(name)),
        findsOneWidget,
        reason: name,
      );
    }
  });

  testWidgets('only the current choice is ticked', (
    WidgetTester tester,
  ) async {
    await _pump(tester, language: AppLanguage.french);
    await _openPicker(tester);

    Finder check(AppLanguage language) => find.descendant(
      of: _key('language-${language.toJson()}'),
      matching: find.byWidgetPredicate(
        (Widget w) => w is InkIcon && w.icon == InkIcons.check,
      ),
    );
    expect(check(AppLanguage.french), findsOneWidget);
    expect(check(AppLanguage.system), findsNothing);
    expect(check(AppLanguage.english), findsNothing);
  });

  testWidgets('choosing a language applies it at once and closes the sheet', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pump(tester);
    await _openPicker(tester);

    await tester.tap(_key('language-es'));
    await tester.pumpAndSettle();

    expect(scope.settings.language, AppLanguage.spanish);
    expect(_key('language-list'), findsNothing);
    // The page is now in Spanish and the row says so.
    final Finder row = find.byKey(LanguageSection.rowKey);
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    final InkListRow widget = tester.widget<InkListRow>(row);
    expect(widget.label, l10nEs.settingsLanguageTitle);
    expect(widget.value, 'Español');
  });

  testWidgets('System goes back to following the device', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pump(tester, language: AppLanguage.italian);
    await _openPicker(tester);

    await tester.tap(_key('language-system'));
    await tester.pumpAndSettle();

    expect(scope.settings.language, AppLanguage.system);
    expect(_key('language-list'), findsNothing);
    final Finder row = find.byKey(LanguageSection.rowKey);
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    expect(tester.widget<InkListRow>(row).value, l10n.settingsLanguageSystem);
  });

  testWidgets('every language can be chosen from the picker', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pump(tester);
    for (final AppLanguage language in AppLanguage.values) {
      await _openPicker(tester);
      await tester.tap(_key('language-${language.toJson()}'));
      await tester.pumpAndSettle();
      expect(scope.settings.language, language, reason: language.name);
    }
  });
}
