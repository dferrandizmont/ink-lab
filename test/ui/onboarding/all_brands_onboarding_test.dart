import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/app_settings_state.dart';
import 'package:ink_lab/ui/pages/onboarding/onboarding_page.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';

import '../../support/l10n.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

Future<AppScope> _pumpApp(
  WidgetTester tester, {
  AppSettingsState? state,
}) async {
  tester.view.physicalSize = const Size(412, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  useEnglishDevice(tester);
  final AppScope scope = AppScope.inMemory(
    markers: MarkerRepository(
      loadAsset: (path) => File(path).readAsStringSync(),
    ),
    settingsState: state,
    child: const InkLabApp(),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

/// The code of the first colour of [brand]'s catalogue.
String _firstCode(MarkerBrand brand) {
  final first =
      (jsonDecode(File(brand.assetPath).readAsStringSync()) as List).first
          as Map<String, dynamic>;
  return first['code'] as String;
}

void main() {
  // Every brand that is collected marker by marker (DecoTime has its own
  // family step, covered in collection_test): pick its first catalogue colour.
  for (final brand in MarkerBrand.values.where(
    (b) => !b.hasRetailSets && b != MarkerBrand.decoTime,
  )) {
    final code = _firstCode(brand);
    testWidgets('${brand.label} setup stages individual markers until finish', (
      tester,
    ) async {
      final scope = await _pumpApp(
        tester,
        state: AppSettingsState(
          settings: AppSettings(
            extraMarkerIds: const {'decotime:01', 'ohuhu_oahu:BV321'},
          ),
        ),
      );
      final choice = _key(onboardingBrandCardKey(brand));
      await tester.scrollUntilVisible(
        choice,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await Scrollable.ensureVisible(tester.element(choice), alignment: 0.2);
      await tester.pumpAndSettle();
      expect(choice.hitTestable(), findsOneWidget);
      await tester.tap(choice);
      await tester.pumpAndSettle();
      expect(find.text(l10n.onboardingStepFirst), findsOneWidget);
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      expect(
        find.text(l10n.onboardingMarkersTitle(brand.label)),
        findsOneWidget,
      );
      expect(find.text(l10n.collectionDecoSizesHint), findsNothing);
      await tester.tap(_key('onboarding-pick-markers'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), code);
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-marker-$code'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(scope.settings.brand, MarkerBrand.ohuhuOahu);
      expect(scope.settings.settings.extraMarkerIds, {
        'decotime:01',
        'ohuhu_oahu:BV321',
      });
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      expect(find.text(brand.label), findsOneWidget);
      expect(find.text('1 marker'), findsOneWidget);
      await tester.tap(_key('onboarding-next'));
      await tester.pumpAndSettle();
      expect(scope.settings.brand, brand);
      expect(scope.settings.settings.extraMarkerIds, {
        '${brand.id}:$code',
        'decotime:01',
        'ohuhu_oahu:BV321',
      });
      expect(scope.settings.onboardingCompleted, isTrue);
      expect(find.byType(AppShell), findsOneWidget);
    });
  }
}
