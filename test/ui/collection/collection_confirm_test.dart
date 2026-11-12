import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/collection/loose_markers_page.dart';
import 'package:ink_lab/ui/pages/onboarding/onboarding_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';

import '../../support/l10n.dart';

/// The owner's rule: every action that takes markers away asks first, and
/// says what is taken away and how many. Cancel changes nothing.
MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// The ten markers of the DecoTime family "warm greys".
const List<String> _warmGreyIds = <String>[
  'decotime:WG0.5',
  'decotime:WG1',
  'decotime:WG2',
  'decotime:WG3',
  'decotime:WG4',
  'decotime:WG5',
  'decotime:WG6',
  'decotime:WG7',
  'decotime:WG8',
  'decotime:WG9',
];

Future<AppScope> _pump(
  WidgetTester tester,
  Widget page, {
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
      home: page,
    ),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

Future<AppScope> _pumpCollection(
  WidgetTester tester, {
  AppSettingsState? state,
}) => _pump(tester, const CollectionPage(), state: state);

/// Opens the folded group of My collection with [key] (Series, Sets...).
Future<void> _openGroup(WidgetTester tester, String key) async {
  await tester.ensureVisible(_key(key));
  await tester.pumpAndSettle();
  await tester.tap(_key(key));
  await tester.pumpAndSettle();
}

/// Answers the question that is on screen: yes or no.
Future<void> _answer(WidgetTester tester, {required bool confirm}) async {
  expect(find.byType(AlertDialog), findsOneWidget);
  if (confirm) {
    await tester.tap(
      find.widgetWithText(FilledButton, l10n.collectionRemoveConfirm),
    );
  } else {
    await tester.tap(find.text(l10n.settingsCancel));
  }
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a family that is owned asks before it is taken away', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(
        brand: MarkerBrand.decoTime,
        onboardingCompleted: true,
        settings: AppSettings(extraMarkerIds: _warmGreyIds.toSet()),
      ),
    );

    await tester.tap(_key('collection-family-decotime_warm_grey'));
    await tester.pumpAndSettle();
    // The question says what is taken away and how many.
    expect(
      find.text(
        l10n.collectionRemoveFromTitle(10, l10n.collectionFamilyWarmGrey),
      ),
      findsOneWidget,
    );
    expect(find.text(l10n.collectionRemoveMarkersBody), findsOneWidget);

    // Cancel: the family stays.
    await _answer(tester, confirm: false);
    expect(scope.settings.settings.extraMarkerIds, _warmGreyIds.toSet());

    // Confirm: the family goes.
    await tester.tap(_key('collection-family-decotime_warm_grey'));
    await tester.pumpAndSettle();
    await _answer(tester, confirm: true);
    expect(scope.settings.settings.extraMarkerIds, isEmpty);
  });

  testWidgets('the whole range asks before it is taken away', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(
        brand: MarkerBrand.decoTime,
        onboardingCompleted: true,
      ),
    );
    final List<MarkerColor> range = await scope.markers.loadColors(
      MarkerBrand.decoTime,
    );
    await scope.settings.setExtraMarkerIds(<String>{
      for (final MarkerColor color in range) color.colorId,
    });
    await tester.pumpAndSettle();

    await tester.tap(_key('collection-family-all'));
    await tester.pumpAndSettle();
    expect(
      find.text(l10n.collectionRemoveMarkersTitle(range.length)),
      findsOneWidget,
    );

    await _answer(tester, confirm: false);
    expect(scope.settings.settings.extraMarkerIds, hasLength(range.length));

    await tester.tap(_key('collection-family-all'));
    await tester.pumpAndSettle();
    await _answer(tester, confirm: true);
    expect(scope.settings.settings.extraMarkerIds, isEmpty);
  });

  testWidgets('a family that is not owned is added without a question', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(
        brand: MarkerBrand.decoTime,
        onboardingCompleted: true,
      ),
    );

    await tester.tap(_key('collection-family-decotime_warm_grey'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(scope.settings.settings.extraMarkerIds, hasLength(10));
  });

  testWidgets('a series asks before its sets are taken away', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(
        onboardingCompleted: true,
        settings: AppSettings(
          ownedSetIds: const <String>{'honolulu_24'},
          chosenSeriesIds: const <String>{'honolulu'},
        ),
      ),
    );

    await _openGroup(tester, 'collection-series');
    await tester.tap(_key('collection-series-honolulu'));
    await tester.pumpAndSettle();
    expect(
      find.text(l10n.collectionRemoveFromTitle(24, 'Honolulu')),
      findsOneWidget,
    );

    // Cancel: the series and its set stay.
    await _answer(tester, confirm: false);
    expect(scope.settings.settings.chosenSeriesIds, <String>{'honolulu'});
    expect(scope.settings.settings.ownedSetIds, <String>{'honolulu_24'});

    // Confirm: the series and its set go.
    await tester.tap(_key('collection-series-honolulu'));
    await tester.pumpAndSettle();
    await _answer(tester, confirm: true);
    expect(scope.settings.settings.chosenSeriesIds, isEmpty);
    expect(scope.settings.settings.ownedSetIds, isEmpty);
  });

  testWidgets('a set asks before its markers are taken away', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(
        onboardingCompleted: true,
        settings: AppSettings(
          ownedSetIds: const <String>{'honolulu_24'},
          chosenSeriesIds: const <String>{'honolulu'},
        ),
      ),
    );

    await _openGroup(tester, 'collection-series');
    await _openGroup(tester, 'collection-sets');
    await tester.tap(_key('collection-set-honolulu_24'));
    await tester.pumpAndSettle();
    expect(
      // The name of the set, not only the line it belongs to.
      find.text(l10n.collectionRemoveFromTitle(24, 'Honolulu 24')),
      findsOneWidget,
    );

    // Cancel: the set stays.
    await _answer(tester, confirm: false);
    expect(scope.settings.settings.ownedSetIds, <String>{'honolulu_24'});

    // Confirm: the set goes.
    await tester.tap(_key('collection-set-honolulu_24'));
    await tester.pumpAndSettle();
    await _answer(tester, confirm: true);
    expect(scope.settings.settings.ownedSetIds, isEmpty);
  });

  testWidgets('unticking all the markers on screen asks first', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(onboardingCompleted: true),
    );

    await tester.ensureVisible(_key('collection-add-loose'));
    await tester.tap(_key('collection-add-loose'));
    await tester.pumpAndSettle();
    expect(find.byKey(LooseMarkersPage.pageKey), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'BV04');
    await tester.pumpAndSettle();
    await tester.tap(_key('collection-marker-BV04'));
    await tester.pumpAndSettle();
    expect(scope.settings.settings.extraMarkerIds, <String>{'ohuhu_oahu:BV04'});

    await tester.tap(_key('collection-untick-visible'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.collectionRemoveMarkersTitle(1)), findsOneWidget);

    // Cancel: the marker stays.
    await _answer(tester, confirm: false);
    expect(scope.settings.settings.extraMarkerIds, <String>{'ohuhu_oahu:BV04'});

    // Confirm: the marker goes.
    await tester.tap(_key('collection-untick-visible'));
    await tester.pumpAndSettle();
    await _answer(tester, confirm: true);
    expect(scope.settings.settings.extraMarkerIds, isEmpty);
  });

  testWidgets('unticking all is off when nothing on screen is owned', (
    WidgetTester tester,
  ) async {
    await _pumpCollection(
      tester,
      state: AppSettingsState(onboardingCompleted: true),
    );

    await tester.ensureVisible(_key('collection-add-loose'));
    await tester.tap(_key('collection-add-loose'));
    await tester.pumpAndSettle();
    expect(find.byKey(LooseMarkersPage.pageKey), findsOneWidget);

    // Nothing is owned: the button has nothing to take out.
    expect(
      tester.widget<InkButton>(_key('collection-untick-visible')).onPressed,
      isNull,
    );
  });

  testWidgets('unticking one marker asks nothing', (WidgetTester tester) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(onboardingCompleted: true),
    );

    await tester.ensureVisible(_key('collection-add-loose'));
    await tester.tap(_key('collection-add-loose'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'BV04');
    await tester.pumpAndSettle();
    await tester.tap(_key('collection-marker-BV04'));
    await tester.pumpAndSettle();
    expect(scope.settings.settings.extraMarkerIds, <String>{'ohuhu_oahu:BV04'});

    // The tick of the marker the user sees: no question.
    await tester.tap(_key('collection-marker-BV04'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(scope.settings.settings.extraMarkerIds, isEmpty);
  });

  testWidgets('the setup asks before it replaces a collection', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pump(
      tester,
      const OnboardingPage(),
      state: AppSettingsState(
        settings: AppSettings(
          ownedSetIds: const <String>{'honolulu_24'},
          chosenSeriesIds: const <String>{'honolulu'},
        ),
      ),
    );

    // The setup starts from the collection the user has: the series is
    // ticked. Unticking it takes its markers away when the setup ends.
    await tester.tap(_key('onboarding-next'));
    await tester.pumpAndSettle();
    await tester.tap(_key('collection-series-honolulu'));
    await tester.pumpAndSettle();
    await tester.tap(_key('onboarding-next'));
    await tester.pumpAndSettle();
    await tester.tap(_key('onboarding-next'));
    await tester.pumpAndSettle();
    // The last step: "Start" ends the setup.
    await tester.tap(_key('onboarding-next'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(l10n.collectionReplaceTitle), findsOneWidget);
    await tester.tap(find.text(l10n.settingsCancel));
    await tester.pumpAndSettle();

    // Cancel: the collection is the one it was.
    expect(scope.settings.settings.ownedSetIds, <String>{'honolulu_24'});
    expect(scope.settings.onboardingCompleted, isFalse);
    expect(find.byKey(OnboardingPage.pageKey), findsOneWidget);

    // Confirm: the setup replaces it.
    await tester.tap(_key('onboarding-next'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(FilledButton, l10n.collectionReplaceConfirm),
    );
    await tester.pumpAndSettle();
    expect(scope.settings.settings.ownedSetIds, isEmpty);
    expect(scope.settings.onboardingCompleted, isTrue);
  });

  testWidgets('the setup with nothing to lose asks nothing', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pump(
      tester,
      const OnboardingPage(),
      state: AppSettingsState(),
    );

    for (int i = 0; i < 4; i++) {
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
    }
    expect(find.byType(AlertDialog), findsNothing);
    expect(scope.settings.onboardingCompleted, isTrue);
  });
}
