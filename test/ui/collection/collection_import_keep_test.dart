import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/collection/loose_markers_page.dart';
import 'package:ink_lab/ui/pages/tools/collection_transfer_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';

/// The bug the owner reported: the markers imported by text disappeared when
/// a family of "Add by family" was tapped in My collection.
///
/// The collection page keeps the copy of the collection it was built with.
/// Every write of the collection must start from the collection the
/// repository holds now, so an import that happened while the page was open
/// is never lost.
MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

Finder _key(String key) => find.byKey(ValueKey<String>(key));

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

/// Imports [codes] through the real text import of the transfer page and
/// comes back to My collection.
Future<void> _importCodes(
  WidgetTester tester,
  AppScope scope, {
  String codes = '01\n02',
}) async {
  await tester.ensureVisible(_key('tools-transfer'));
  await tester.pumpAndSettle();
  await tester.tap(_key('tools-transfer'));
  await tester.pumpAndSettle();
  expect(find.byKey(CollectionTransferPage.pageKey), findsOneWidget);
  await tester.enterText(_key('transfer-codes'), codes);
  await tester.pumpAndSettle();
  await tester.tap(_key('transfer-add'));
  await tester.pumpAndSettle();
  await tester.pageBack();
  await tester.pumpAndSettle();
  expect(scope.settings.settings.extraMarkerIds, contains('decotime:01'));
}

void main() {
  testWidgets('markers imported by text survive a family tap', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(
        brand: MarkerBrand.decoTime,
        onboardingCompleted: true,
      ),
    );

    // The chip of the family is on screen before the import lands.
    await tester.ensureVisible(_key('collection-family-decotime_warm_grey'));
    await tester.pumpAndSettle();

    // The import writes the markers while the page keeps the copy it was
    // built with. Nothing is pumped between the write and the tap, so the
    // page is still the one of the build: the tap must work on the
    // collection the repository holds now and not on that copy. (Rebuild the
    // page and the write of the old code would work too: the loss only
    // happens while the page is still the old one.)
    await scope.settings.setExtraMarkerIds(<String>{
      'decotime:01',
      'decotime:02',
    });
    await tester.tap(_key('collection-family-decotime_warm_grey'));
    await tester.pumpAndSettle();

    // The union: the imported markers and the family, none of them lost.
    expect(scope.settings.settings.extraMarkerIds, <String>{
      'decotime:01',
      'decotime:02',
      ..._warmGreyIds,
    });
  });

  testWidgets('the text import of the transfer page adds the markers', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await _pumpCollection(
      tester,
      state: AppSettingsState(
        brand: MarkerBrand.decoTime,
        onboardingCompleted: true,
      ),
    );

    await _importCodes(tester, scope);

    // The family is added on top of the markers of the import.
    await tester.ensureVisible(_key('collection-family-decotime_warm_grey'));
    await tester.pumpAndSettle();
    await tester.tap(_key('collection-family-decotime_warm_grey'));
    await tester.pumpAndSettle();

    expect(scope.settings.settings.extraMarkerIds, <String>{
      'decotime:01',
      'decotime:02',
      ..._warmGreyIds,
    });
  });

  testWidgets('the import row opens the import of the collection', (
    WidgetTester tester,
  ) async {
    await _pumpCollection(
      tester,
      state: AppSettingsState(
        brand: MarkerBrand.decoTime,
        onboardingCompleted: true,
      ),
    );

    await tester.ensureVisible(_key('collection-import-codes'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.collectionImportCodesTitle), findsOneWidget);
    await tester.tap(_key('collection-import-codes'));
    await tester.pumpAndSettle();

    expect(find.byKey(CollectionTransferPage.pageKey), findsOneWidget);
    // The page opens at the import: the field of the codes is on screen.
    expect(
      find.byKey(const ValueKey<String>('transfer-codes')).hitTestable(),
      findsOneWidget,
    );
    // The export of the collection is not what the row opens.
    expect(find.text(l10n.toolsTransferExport).hitTestable(), findsNothing);
  });

  testWidgets('the import row is there for every brand', (
    WidgetTester tester,
  ) async {
    await _pumpCollection(
      tester,
      state: AppSettingsState(onboardingCompleted: true),
    );
    await tester.ensureVisible(_key('collection-import-codes'));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey<String>('collection-import-codes')),
      findsOneWidget,
    );
    expect(find.byKey(LooseMarkersPage.pageKey), findsNothing);
  });
}
