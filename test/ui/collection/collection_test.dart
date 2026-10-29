import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/collection/loose_markers_page.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/onboarding/onboarding_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

Future<AppScope> _pumpCollection(
  WidgetTester tester, {
  AppSettingsState? state,
}) async {
  tester.view.physicalSize = const Size(412, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: _markers(),
    settingsState: state,
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      home: const CollectionPage(),
    ),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

Future<AppScope> _pumpApp(
  WidgetTester tester, {
  AppSettingsState? state,
}) async {
  tester.view.physicalSize = const Size(412, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  useEnglishDevice(tester);
  final AppScope scope = AppScope.inMemory(
    markers: _markers(),
    settingsState: state,
    child: const InkLabApp(),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

Finder _key(String key) => find.byKey(ValueKey<String>(key));

Finder _nav(String label) => find.descendant(
  of: find.byType(InkNavigationBar),
  matching: find.text(label),
);

void main() {
  group('My collection screen', () {
    testWidgets('Ohuhu: series, sets and extras add up to one count', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(tester);

      expect(find.byKey(CollectionPage.pageKey), findsOneWidget);
      expect(find.text('Ohuhu · Oahu'), findsOneWidget);
      expect(find.text('1 set · 161 markers'), findsOneWidget);

      // A Honolulu set: pick the series, then the set.
      await tester.tap(_key('collection-series-honolulu'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.collectionHonoluluNote), findsOneWidget);
      await tester.ensureVisible(_key('collection-set-honolulu_24'));
      await tester.tap(_key('collection-set-honolulu_24'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.ownedSetIds, <String>{
        'classic_160',
        'honolulu_24',
      });

      // The loose markers live on their own screen. A marker of an owned set
      // says "In your set" and cannot be ticked one by one.
      await tester.ensureVisible(_key('collection-add-loose'));
      await tester.tap(_key('collection-add-loose'));
      await tester.pumpAndSettle();
      expect(find.byKey(LooseMarkersPage.pageKey), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'B08');
      await tester.pumpAndSettle();
      final Finder b08 = _key('collection-marker-B08');
      expect(
        find.descendant(
          of: b08,
          matching: find.text(l10n.collectionInYourSets),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(of: b08, matching: find.byType(Checkbox)),
        findsNothing,
      );
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Dropping the series drops its sets.
      await tester.fling(
        find.byType(SingleChildScrollView),
        const Offset(0, 3000),
        5000,
      );
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-series-honolulu'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.ownedSetIds, <String>{'classic_160'});
    });

    testWidgets('an extra marker can be ticked from the full list', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(onboardingCompleted: true),
      );
      expect(find.text(l10n.collectionSummaryNoSets), findsOneWidget);

      await tester.ensureVisible(_key('collection-add-loose'));
      await tester.tap(_key('collection-add-loose'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'BV04');
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-marker-BV04'));
      await tester.pumpAndSettle();

      expect(scope.settings.settings.extraMarkerIds, <String>{
        'ohuhu_oahu:BV04',
      });
      expect(
        tester.widget<Text>(_key('collection-owned-count')).data,
        startsWith('1 of '),
      );

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('1 marker'), findsWidgets);
      expect(find.text('1 loose marker'), findsOneWidget);
    });

    testWidgets('DecoTime: no sets, families add markers, no raw ids', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(
          brand: MarkerBrand.decoTime,
          onboardingCompleted: true,
        ),
      );

      expect(_key('collection-series-oahu'), findsNothing);
      expect(find.text(l10n.collectionDecoSizesHint), findsOneWidget);
      expect(find.textContaining('decotime_'), findsNothing);

      await tester.tap(_key('collection-family-decotime_warm_grey'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.extraMarkerIds, hasLength(10));
      expect(
        find.descendant(
          of: _key('collection-summary'),
          matching: find.text('10 markers'),
        ),
        findsOneWidget,
      );

      // Tapping a complete family removes it again.
      await tester.tap(_key('collection-family-decotime_warm_grey'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.extraMarkerIds, isEmpty);

      await tester.tap(_key('collection-family-all'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.extraMarkerIds, hasLength(313));
    });

    testWidgets('reset asks first and only clears the active brand', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(
          onboardingCompleted: true,
          settings: AppSettings(
            ownedSetIds: const <String>{'classic_160'},
            extraMarkerIds: const <String>{'decotime:01', 'ohuhu_oahu:BV04'},
          ),
        ),
      );

      await tester.ensureVisible(_key('collection-reset'));
      await tester.tap(_key('collection-reset'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.ownedSetIds, isNotEmpty);
      await tester.tap(find.widgetWithText(FilledButton, l10n.collectionReset));
      await tester.pumpAndSettle();

      expect(scope.settings.settings.ownedSetIds, isEmpty);
      expect(scope.settings.settings.extraMarkerIds, <String>{'decotime:01'});
    });

    testWidgets('the stored series show without any set, and survive', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(
          onboardingCompleted: true,
          settings: AppSettings(chosenSeriesIds: const <String>{'honolulu'}),
        ),
      );
      expect(find.text('Ohuhu · Honolulu'), findsOneWidget);
      expect(find.text(l10n.collectionSummaryNoSets), findsOneWidget);
      // The Honolulu sets are offered although none is owned yet.
      expect(_key('collection-set-honolulu_24'), findsOneWidget);
      expect(find.text(l10n.collectionHonoluluNote), findsOneWidget);

      await tester.tap(_key('collection-series-kaala'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.chosenSeriesIds, <String>{
        'honolulu',
        'kaala',
      });
      expect(find.text('Ohuhu · Honolulu + Kaala'), findsOneWidget);
    });

    testWidgets('reset also forgets the chosen series', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(
          onboardingCompleted: true,
          settings: AppSettings(chosenSeriesIds: const <String>{'oahu'}),
        ),
      );
      await tester.ensureVisible(_key('collection-reset'));
      await tester.tap(_key('collection-reset'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, l10n.collectionReset));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.chosenSeriesIds, isEmpty);
    });

    testWidgets('tick and untick visible work on what the search shows', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(onboardingCompleted: true),
      );
      await tester.ensureVisible(_key('collection-add-loose'));
      await tester.tap(_key('collection-add-loose'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'BV0');
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-tick-visible'));
      await tester.pumpAndSettle();
      final Set<String> ticked = scope.settings.settings.extraMarkerIds;
      expect(ticked, isNotEmpty);
      expect(
        ticked.every((String id) => id.startsWith('ohuhu_oahu:BV0')),
        true,
      );
      await tester.tap(_key('collection-untick-visible'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.extraMarkerIds, isEmpty);
    });

    testWidgets('the marker list scrolls with the page, not inside a card', (
      WidgetTester tester,
    ) async {
      await _pumpCollection(tester);
      // One vertical scrollable for the whole screen.
      expect(
        find.byWidgetPredicate(
          (Widget w) =>
              w is Scrollable && w.axisDirection == AxisDirection.down,
        ),
        findsOneWidget,
      );
    });
  });

  group('first-run setup', () {
    testWidgets('a fresh install starts with the setup and Ohuhu sets', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpApp(tester, state: AppSettingsState());
      expect(find.byKey(OnboardingPage.pageKey), findsOneWidget);
      expect(find.byType(AppShell), findsNothing);
      expect(find.text(l10n.onboardingStep(1, 4)), findsOneWidget);

      await tester.tap(_key('onboarding-brand-ohuhu'));
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-series-kaala'));
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-set-kaala_basic_24'));
      await tester.pumpAndSettle();
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      expect(find.text('Ohuhu · Kaala'), findsOneWidget);
      expect(find.textContaining('1 set'), findsOneWidget);
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();

      expect(find.byType(AppShell), findsOneWidget);
      expect(scope.settings.onboardingCompleted, isTrue);
      expect(scope.settings.settings.ownedSetIds, <String>{'kaala_basic_24'});
    });

    testWidgets('the series is kept even when no set is picked', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpApp(tester, state: AppSettingsState());
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      // Series are cards with their tips, one per series.
      expect(find.text(l10n.collectionSeriesOahuTips), findsOneWidget);
      expect(find.text(l10n.collectionSeriesHonoluluTips), findsOneWidget);
      expect(find.text(l10n.collectionSeriesKaalaTips), findsOneWidget);
      await tester.tap(_key('collection-series-oahu'));
      await tester.tap(_key('collection-series-honolulu'));
      await tester.pumpAndSettle();
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      // No set picked.
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();

      // The last step says what the app does with nothing chosen.
      expect(find.text('Ohuhu · Oahu + Honolulu'), findsOneWidget);
      expect(find.text(l10n.collectionSummaryNoSets), findsOneWidget);
      expect(find.text(l10n.onboardingDoneWholeRange('Ohuhu')), findsOneWidget);
      expect(find.text(l10n.onboardingDoneNext), findsOneWidget);

      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.ownedSetIds, isEmpty);
      expect(scope.settings.settings.chosenSeriesIds, <String>{
        'oahu',
        'honolulu',
      });

      // My collection shows them.
      unawaited(CollectionPage.open(tester.element(find.byType(AppShell))));
      await tester.pumpAndSettle();
      expect(find.text('Ohuhu · Oahu + Honolulu'), findsOneWidget);
    });

    testWidgets('the last step counts sets and markers', (
      WidgetTester tester,
    ) async {
      await _pumpApp(tester, state: AppSettingsState());
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-series-oahu'));
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-set-classic_160'));
      await tester.pumpAndSettle();
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      expect(find.text('Ohuhu · Oahu'), findsOneWidget);
      expect(find.text('1 set · 161 markers'), findsOneWidget);
      expect(find.text(l10n.onboardingDoneWholeRange('Ohuhu')), findsNothing);
    });

    testWidgets('DecoTime takes three steps and families', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpApp(tester, state: AppSettingsState());
      await tester.tap(_key('onboarding-brand-decotime'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.onboardingStep(1, 3)), findsOneWidget);
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      await tester.tap(_key('onboarding-family-decotime_cool_grey'));
      await tester.pumpAndSettle();
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();

      expect(scope.settings.brand, MarkerBrand.decoTime);
      expect(scope.settings.settings.extraMarkerIds, hasLength(9));
    });

    testWidgets('skip keeps the defaults and never asks again', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpApp(tester, state: AppSettingsState());
      expect(find.text(l10n.onboardingLaterNote), findsOneWidget);
      await tester.tap(_key('onboarding-skip'));
      await tester.pumpAndSettle();

      expect(find.byType(AppShell), findsOneWidget);
      expect(scope.settings.onboardingCompleted, isTrue);
      expect(scope.settings.settings.ownedSetIds, isEmpty);
    });
  });

  group('switching brand reaches every tab', () {
    testWidgets('Swatches, Match, Palette and Ideas follow the new brand', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpApp(tester);
      for (final String tab in <String>['Match', 'Palette', 'Ideas']) {
        await tester.tap(_nav(tab));
        await tester.pumpAndSettle();
      }
      final State<StatefulWidget> palette = tester.state(
        find.byType(PalettePage, skipOffstage: false),
      );
      final State<StatefulWidget> ideas = tester.state(
        find.byType(IdeasPage, skipOffstage: false),
      );
      // A base colour of the old brand waiting for the Palette tab.
      paletteBaseDraft.value = MarkerColor(
        brandId: 'ohuhu_oahu',
        newCode: 'B08',
        newName: 'Cotton Candy Blue',
        oldCode: 'B289',
        oldName: 'Pastel Blue',
        hex: '82dcfa',
        sets: const <String>['classic_160'],
      );

      await scope.settings.setBrand(MarkerBrand.decoTime);
      await tester.pumpAndSettle();

      // Pages that hold colours of one brand start fresh.
      expect(
        tester.state(find.byType(PalettePage, skipOffstage: false)),
        isNot(same(palette)),
      );
      expect(
        tester.state(find.byType(IdeasPage, skipOffstage: false)),
        isNot(same(ideas)),
      );
      expect(paletteBaseDraft.value, isNull);

      await tester.tap(_nav('Match'));
      await tester.pumpAndSettle();
      expect(find.byKey(MatchPage.pageKey), findsOneWidget);
      expect(find.text(l10n.matchSubtitleEmpty), findsOneWidget);

      await tester.tap(_nav('Swatches'));
      await tester.pumpAndSettle();
      expect(find.byKey(SwatchesPage.pageKey), findsOneWidget);
      expect(
        find.text('DecoTime · ${l10n.collectionNotSetUp}'),
        findsOneWidget,
      );
      expect(find.text('B08'), findsNothing);
    });
  });
}
