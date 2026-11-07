import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/app_settings_state.dart';
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

void main() {
  for (final bool finish in [true, false]) {
    testWidgets(
      'Finecolour setup stages individual markers until finish ($finish)',
      (tester) async {
        final scope = await _pumpApp(
          tester,
          state: AppSettingsState(
            settings: AppSettings(
              extraMarkerIds: const {'decotime:01', 'ohuhu_oahu:BV321'},
            ),
          ),
        );
        await tester.ensureVisible(_key('onboarding-brand-finecolour'));
        await tester.pumpAndSettle();
        await tester.tap(_key('onboarding-brand-finecolour'));
        await tester.pumpAndSettle();
        expect(find.text(l10n.onboardingStep(1, 3)), findsOneWidget);
        await tester.tap(_key('onboarding-next'));
        await tester.pumpAndSettle();
        expect(
          find.text(l10n.onboardingMarkersTitle('Finecolour')),
          findsOneWidget,
        );
        expect(find.text(l10n.collectionDecoSizesHint), findsNothing);
        await tester.tap(_key('onboarding-pick-markers'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'BV321');
        await tester.pumpAndSettle();
        await tester.tap(_key('collection-marker-BV321'));
        await tester.pumpAndSettle();
        await tester.pageBack();
        await tester.pumpAndSettle();
        expect(scope.settings.brand, MarkerBrand.ohuhuOahu);
        expect(scope.settings.settings.extraMarkerIds, {
          'decotime:01',
          'ohuhu_oahu:BV321',
        });
        if (finish) {
          await tester.tap(_key('onboarding-next'));
          await tester.pumpAndSettle();
          expect(find.text('Finecolour'), findsOneWidget);
          expect(find.text('1 marker'), findsOneWidget);
          await tester.tap(_key('onboarding-next'));
          await tester.pumpAndSettle();
          expect(scope.settings.brand, MarkerBrand.finecolour);
          expect(scope.settings.settings.extraMarkerIds, {
            'finecolour:BV321',
            'decotime:01',
            'ohuhu_oahu:BV321',
          });
        } else {
          await tester.tap(_key('onboarding-skip'));
          await tester.pumpAndSettle();
          expect(scope.settings.brand, MarkerBrand.ohuhuOahu);
          expect(scope.settings.settings.extraMarkerIds, {
            'decotime:01',
            'ohuhu_oahu:BV321',
          });
        }
        expect(scope.settings.onboardingCompleted, isTrue);
        expect(find.byType(AppShell), findsOneWidget);
      },
    );
  }
}
