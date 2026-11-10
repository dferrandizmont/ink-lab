import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
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
import 'package:ink_lab/ui/widgets/brand_list.dart';
import 'package:ink_lab/ui/widgets/section_card.dart';

import '../../support/l10n.dart';

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

Future<AppScope> _pumpCollection(
  WidgetTester tester, {
  AppSettingsState? state,
  Size size = const Size(412, 900),
  double textScale = 1,
}) async {
  tester.view.physicalSize = size;
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
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
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

/// Opens the folded group of My collection with [key] (Series, Sets...).
Future<void> _openGroup(WidgetTester tester, String key) async {
  final Finder finder = _key(key);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Opens the brand picker row and taps the row of [brand].
Future<void> _pickBrand(WidgetTester tester, MarkerBrand brand) async {
  final Finder row = _key('collection-brand');
  await tester.ensureVisible(row);
  await tester.pumpAndSettle();
  await tester.tap(row);
  await tester.pumpAndSettle();
  // The rows scroll inside the sheet: bring the brand's row into view.
  await tester.scrollUntilVisible(
    _key('brand-${brand.id}'),
    80,
    scrollable: find.descendant(
      of: _key('brand-list'),
      matching: find.byType(Scrollable),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(_key('brand-${brand.id}'));
  await tester.pumpAndSettle();
}

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

      // A Honolulu set: pick the series, then the set. Both groups start
      // folded.
      await _openGroup(tester, 'collection-series');
      await tester.tap(_key('collection-series-honolulu'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.collectionHonoluluNote), findsOneWidget);
      await _openGroup(tester, 'collection-sets');
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
        find.byType(SingleChildScrollView).first,
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
      // With sets the count is what is ticked here, apart from the sets.
      expect(
        tester.widget<Text>(_key('collection-owned-count')).data,
        l10n.collectionLooseTicked(1, 0),
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

    testWidgets(
      'Copic selects individual markers, switches and resets only its own collection',
      (tester) async {
        final scope = await _pumpCollection(
          tester,
          state: AppSettingsState(
            brand: MarkerBrand.copic,
            onboardingCompleted: true,
            settings: AppSettings(
              ownedSetIds: const {'classic_160'},
              chosenSeriesIds: const {'oahu'},
              extraMarkerIds: const {
                'copic:0',
                'decotime:01',
                'ohuhu_oahu:BV04',
              },
            ),
          ),
        );
        expect(find.text(l10n.collectionCopicHint), findsOneWidget);
        expect(find.text(l10n.collectionDecoHint), findsNothing);
        expect(_key('collection-series-oahu'), findsNothing);
        expect(_key('collection-family-all'), findsNothing);
        await tester.ensureVisible(_key('collection-add-loose'));
        await tester.tap(_key('collection-add-loose'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'BV04');
        await tester.pumpAndSettle();
        await tester.tap(_key('collection-marker-BV04'));
        await tester.pumpAndSettle();
        expect(scope.settings.settings.extraMarkerIds, contains('copic:BV04'));
        expect(
          tester.widget<Text>(_key('collection-owned-count')).data,
          l10n.collectionOwnedCount(2, 358),
        );
        await tester.tap(_key('collection-untick-visible'));
        await tester.pumpAndSettle();
        expect(
          scope.settings.settings.extraMarkerIds,
          isNot(contains('copic:BV04')),
        );
        await tester.tap(_key('collection-tick-visible'));
        await tester.pumpAndSettle();
        await tester.pageBack();
        await tester.pumpAndSettle();
        await scope.settings.setBrand(MarkerBrand.decoTime);
        await tester.pumpAndSettle();
        expect(find.text(l10n.collectionDecoHint), findsOneWidget);
        await scope.settings.setBrand(MarkerBrand.copic);
        await tester.pumpAndSettle();
        await tester.ensureVisible(_key('collection-reset'));
        await tester.tap(_key('collection-reset'));
        await tester.pumpAndSettle();
        await tester.tap(
          find.widgetWithText(FilledButton, l10n.collectionReset),
        );
        await tester.pumpAndSettle();
        expect(scope.settings.settings.extraMarkerIds, {
          'decotime:01',
          'ohuhu_oahu:BV04',
        });
        expect(scope.settings.settings.ownedSetIds, {'classic_160'});
        expect(scope.settings.settings.chosenSeriesIds, {'oahu'});
      },
    );

    testWidgets(
      'Finecolour selects individual markers, switches and resets only its own collection',
      (tester) async {
        final scope = await _pumpCollection(
          tester,
          state: AppSettingsState(
            brand: MarkerBrand.finecolour,
            onboardingCompleted: true,
            settings: AppSettings(
              ownedSetIds: const {'classic_160'},
              chosenSeriesIds: const {'oahu'},
              extraMarkerIds: const {
                'finecolour:0',
                'decotime:01',
                'ohuhu_oahu:BV321',
              },
            ),
          ),
        );
        expect(find.text(l10n.collectionFinecolourHint), findsOneWidget);
        expect(find.text(l10n.collectionDecoHint), findsNothing);
        expect(_key('collection-series-oahu'), findsNothing);
        expect(_key('collection-family-all'), findsNothing);
        await tester.ensureVisible(_key('collection-add-loose'));
        await tester.tap(_key('collection-add-loose'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'BV321');
        await tester.pumpAndSettle();
        await tester.tap(_key('collection-marker-BV321'));
        await tester.pumpAndSettle();
        expect(
          scope.settings.settings.extraMarkerIds,
          contains('finecolour:BV321'),
        );
        expect(
          tester.widget<Text>(_key('collection-owned-count')).data,
          l10n.collectionOwnedCount(2, 480),
        );
        await tester.tap(_key('collection-untick-visible'));
        await tester.pumpAndSettle();
        expect(
          scope.settings.settings.extraMarkerIds,
          isNot(contains('finecolour:BV321')),
        );
        await tester.tap(_key('collection-tick-visible'));
        await tester.pumpAndSettle();
        await tester.pageBack();
        await tester.pumpAndSettle();
        await scope.settings.setBrand(MarkerBrand.decoTime);
        await tester.pumpAndSettle();
        expect(find.text(l10n.collectionDecoHint), findsOneWidget);
        await _pickBrand(tester, MarkerBrand.finecolour);
        await tester.ensureVisible(_key('collection-reset'));
        await tester.tap(_key('collection-reset'));
        await tester.pumpAndSettle();
        await tester.tap(
          find.widgetWithText(FilledButton, l10n.collectionReset),
        );
        await tester.pumpAndSettle();
        expect(scope.settings.settings.extraMarkerIds, {
          'decotime:01',
          'ohuhu_oahu:BV321',
        });
        expect(scope.settings.settings.ownedSetIds, {'classic_160'});
        expect(scope.settings.settings.chosenSeriesIds, {'oahu'});
      },
    );

    testWidgets('the brand picker lists every brand on a narrow phone, '
        'large text', (WidgetTester tester) async {
      final AppScope scope = await _pumpCollection(
        tester,
        size: const Size(360, 800),
        textScale: 1.3,
        state: AppSettingsState(
          brand: MarkerBrand.finecolour,
          onboardingCompleted: true,
        ),
      );
      // The row shows the active brand and never clips it: the list that can
      // grow lives behind the picker.
      final InkListRow row = tester.widget<InkListRow>(
        _key('collection-brand'),
      );
      expect(row.value, MarkerBrand.finecolour.label);

      await tester.ensureVisible(_key('collection-brand'));
      await tester.tap(_key('collection-brand'));
      await tester.pumpAndSettle();

      expect(_key('brand-list'), findsOneWidget);
      // Fifteen rows do not fit in this sheet: the list scrolls under the
      // search field, and scrolling reaches every brand, inside the screen.
      // Only the active brand is ticked.
      final Finder scrollable = find.descendant(
        of: _key('brand-list'),
        matching: find.byType(Scrollable),
      );
      Finder tick(MarkerBrand brand) => find.descendant(
        of: _key('brand-${brand.id}'),
        matching: find.byWidgetPredicate(
          (Widget w) => w is InkIcon && w.icon == InkIcons.check,
        ),
      );
      for (final MarkerBrand brand in <MarkerBrand>[
        ...popularBrands,
        ...moreBrands,
      ]) {
        final Finder option = _key('brand-${brand.id}');
        await tester.scrollUntilVisible(option, 60, scrollable: scrollable);
        await tester.pumpAndSettle();
        expect(option, findsOneWidget, reason: brand.label);
        final double top = tester.getTopLeft(option).dy;
        expect(top, greaterThanOrEqualTo(0), reason: brand.label);
        expect(top, lessThan(800), reason: brand.label);
        expect(
          tick(brand),
          brand == MarkerBrand.finecolour ? findsOneWidget : findsNothing,
          reason: brand.label,
        );
      }

      // Picking a brand applies it at once and closes the sheet.
      await tester.drag(scrollable, const Offset(0, 5000));
      await tester.pumpAndSettle();
      await tester.tap(_key('brand-ohuhu_oahu'));
      await tester.pumpAndSettle();
      expect(scope.settings.brand, MarkerBrand.ohuhuOahu);
      expect(_key('brand-list'), findsNothing);
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
      // The Honolulu sets are offered although none is owned yet. The series
      // and sets groups start folded.
      await _openGroup(tester, 'collection-series');
      expect(find.text(l10n.collectionHonoluluNote), findsOneWidget);
      await _openGroup(tester, 'collection-sets');
      expect(_key('collection-set-honolulu_24'), findsOneWidget);

      await tester.ensureVisible(_key('collection-series-kaala'));
      await tester.pumpAndSettle();
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

    testWidgets('the loose markers row has one line of help, the count', (
      WidgetTester tester,
    ) async {
      await _pumpCollection(
        tester,
        state: AppSettingsState(onboardingCompleted: true),
      );
      await tester.ensureVisible(_key('collection-add-loose'));
      // The help sentence lives on the page the row opens, not twice.
      expect(find.text(l10n.collectionExtrasHint), findsNothing);
      expect(
        find.descendant(
          of: _key('collection-add-loose'),
          matching: find.text(l10n.collectionExtrasCount(0)),
        ),
        findsOneWidget,
      );
      // Label and one subtitle: no taller than any other two-line row.
      expect(
        tester.getSize(_key('collection-add-loose')).height,
        lessThanOrEqualTo(72),
      );
    });

    testWidgets('the count says loose ticked and, apart, what the sets give', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(
          onboardingCompleted: true,
          settings: AppSettings(ownedSetIds: const {'classic_160'}),
        ),
      );
      await tester.ensureVisible(_key('collection-add-loose'));
      await tester.tap(_key('collection-add-loose'));
      await tester.pumpAndSettle();
      final String before = tester
          .widget<Text>(_key('collection-owned-count'))
          .data!;
      final RegExpMatch match = RegExp(r'^0 loose ticked · (\d+) in your sets$')
          .firstMatch(before)!;
      final int inSets = int.parse(match.group(1)!);
      expect(inSets, greaterThan(100));
      // Ticking a marker that is not in a set moves only the loose number.
      await tester.enterText(find.byType(TextField), 'BV04');
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-marker-BV04'));
      await tester.pumpAndSettle();
      expect(
        scope.settings.settings.extraMarkerIds,
        contains('ohuhu_oahu:BV04'),
      );
      expect(
        tester.widget<Text>(_key('collection-owned-count')).data,
        l10n.collectionLooseTicked(1, inSets),
      );
    });

    testWidgets('Tick all asks first when it would tick a lot at once', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(onboardingCompleted: true),
      );
      await tester.ensureVisible(_key('collection-add-loose'));
      await tester.tap(_key('collection-add-loose'));
      await tester.pumpAndSettle();

      // The whole range: a question, and Cancel changes nothing.
      await tester.tap(_key('collection-tick-visible'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.textContaining(l10n.collectionTickManyBody), findsOneWidget);
      await tester.tap(find.text(l10n.settingsCancel));
      await tester.pumpAndSettle();
      expect(scope.settings.settings.extraMarkerIds, isEmpty);

      // Confirm: everything in view is ticked.
      await tester.tap(_key('collection-tick-visible'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(FilledButton, l10n.collectionTickVisible),
      );
      await tester.pumpAndSettle();
      expect(
        scope.settings.settings.extraMarkerIds.length,
        greaterThan(LooseMarkersPage.tickConfirmThreshold),
      );
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('Tick all does not ask for a handful of markers', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(
        tester,
        state: AppSettingsState(onboardingCompleted: true),
      );
      await tester.ensureVisible(_key('collection-add-loose'));
      await tester.tap(_key('collection-add-loose'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'BV04');
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-tick-visible'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(
        scope.settings.settings.extraMarkerIds,
        contains('ohuhu_oahu:BV04'),
      );
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
      expect(find.text(l10n.onboardingStepFirst), findsOneWidget);

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
      await tester.ensureVisible(_key('onboarding-brand-decotime'));
      await tester.pumpAndSettle();
      await tester.tap(_key('onboarding-brand-decotime'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.onboardingStepFirst), findsOneWidget);
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

    for (final bool finish in [true, false]) {
      testWidgets(
        'Copic setup stages individual markers until finish ($finish)',
        (tester) async {
          final scope = await _pumpApp(
            tester,
            state: AppSettingsState(
              settings: AppSettings(
                extraMarkerIds: const {'decotime:01', 'ohuhu_oahu:BV04'},
              ),
            ),
          );
          await tester.ensureVisible(_key('onboarding-brand-copic'));
          await tester.tap(_key('onboarding-brand-copic'));
          await tester.pumpAndSettle();
          expect(find.text(l10n.onboardingStepFirst), findsOneWidget);
          await tester.tap(_key('onboarding-next'));
          await tester.pumpAndSettle();
          expect(
            find.text(l10n.onboardingMarkersTitle('Copic')),
            findsOneWidget,
          );
          expect(find.text(l10n.collectionDecoSizesHint), findsNothing);
          await tester.tap(_key('onboarding-pick-markers'));
          await tester.pumpAndSettle();
          await tester.enterText(find.byType(TextField), 'BV04');
          await tester.pumpAndSettle();
          await tester.tap(_key('collection-marker-BV04'));
          await tester.pumpAndSettle();
          await tester.pageBack();
          await tester.pumpAndSettle();
          expect(scope.settings.brand, MarkerBrand.ohuhuOahu);
          expect(scope.settings.settings.extraMarkerIds, {
            'decotime:01',
            'ohuhu_oahu:BV04',
          });
          if (finish) {
            await tester.tap(_key('onboarding-next'));
            await tester.pumpAndSettle();
            expect(find.text('Copic'), findsOneWidget);
            expect(find.text('1 marker'), findsOneWidget);
            await tester.tap(_key('onboarding-next'));
            await tester.pumpAndSettle();
            expect(scope.settings.brand, MarkerBrand.copic);
            expect(scope.settings.settings.extraMarkerIds, {
              'copic:BV04',
              'decotime:01',
              'ohuhu_oahu:BV04',
            });
          } else {
            await tester.tap(_key('onboarding-skip'));
            await tester.pumpAndSettle();
            expect(scope.settings.brand, MarkerBrand.ohuhuOahu);
            expect(scope.settings.settings.extraMarkerIds, {
              'decotime:01',
              'ohuhu_oahu:BV04',
            });
          }
          expect(scope.settings.onboardingCompleted, isTrue);
          expect(find.byType(AppShell), findsOneWidget);
        },
      );
    }

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
    for (final brand in [
      MarkerBrand.decoTime,
      MarkerBrand.copic,
      MarkerBrand.finecolour,
    ]) {
      testWidgets(
        '${brand.label}: Swatches, Match, Palette and Ideas follow the new brand',
        (WidgetTester tester) async {
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

          await scope.settings.setBrand(brand);
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
          // The subtitle says the brand, never a count.
          expect(find.text(brand.label), findsOneWidget);
          expect(
            find.text('${brand.label} · ${l10n.collectionNotSetUp}'),
            findsNothing,
          );
          expect(find.text('B08'), findsNothing);
        },
      );
    }
  });
}
