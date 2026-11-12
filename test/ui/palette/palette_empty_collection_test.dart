import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/widgets/empty_state.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../ai/ai_test_support.dart';
import '../../support/l10n.dart';
import 'palette_test_support.dart';

// A collection with no marker of its brand: the palette never builds one out
// of the brand's range, and the page says where to fill the collection.

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// Whether the button of [finder] can be pressed.
bool _enabled(WidgetTester tester, Finder finder) =>
    tester.widget<InkButton>(finder).onPressed != null;

/// The palette page with the AI on, so the "Suggest with AI" button shows.
Future<AppScope> pumpWithAi(
  WidgetTester tester, {
  MarkerBrand brand = MarkerBrand.ohuhuOahu,
  Set<String>? ownedMarkerCodes,
  Future<void> Function(AppScope scope)? setup,
}) async {
  final secrets = InMemorySecretStore(<String, String>{
    openRouterApiKeyName: 'sk-or-v1-abcdef0123456789abcdef0123456789',
  });
  final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
  await repo.replace(
    AiSettings(
      enabled: true,
      provider: AiProvider.openRouter,
      textModel: 'model-a',
    ),
  );
  final service = AiService(
    aiSettings: repo,
    secrets: secrets,
    clientFactory: () => MockClient((_) async => completionResponse('{}')),
  );
  return pumpPalette(
    tester,
    brand: brand,
    ownedMarkerCodes: ownedMarkerCodes,
    setup: setup,
    secrets: secrets,
    aiSettings: repo,
    aiService: service,
  );
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('with no marker of the brand: no palette, and the way out', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(tester, brand: MarkerBrand.decoTime);

    // The page says which brand is empty and opens the collection.
    expect(find.byType(EmptyState), findsOneWidget);
    expect(
      find.text(l10n.missingMarkersTitle(MarkerBrand.decoTime.label)),
      findsOneWidget,
    );
    expect(_key('palette-empty-collection-action'), findsOneWidget);

    // Both actions are off: there is no marker to build a palette with.
    expect(_key('palette-suggest-ai'), findsOneWidget);
    expect(_enabled(tester, _key('palette-suggest-ai')), isFalse);
    expect(_enabled(tester, _key('palette-generate')), isFalse);

    // And there is no palette out of the brand's range.
    expect(find.byType(PaletteStrip), findsNothing);
  });

  testWidgets('the empty state opens the collection, the way Settings does', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(tester, brand: MarkerBrand.decoTime);

    await tester.tap(_key('palette-empty-collection-action'));
    await tester.pumpAndSettle();

    expect(find.byKey(CollectionPage.pageKey), findsOneWidget);
  });

  testWidgets('with markers but no base: the AI waits for the base', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(tester);

    expect(_key('palette-suggest-ai'), findsOneWidget);
    expect(_enabled(tester, _key('palette-suggest-ai')), isFalse);
    expect(_enabled(tester, _key('palette-generate')), isFalse);

    // A base of the collection: the AI may suggest from it.
    await enterBaseCode(tester, 'B08');
    expect(_enabled(tester, _key('palette-suggest-ai')), isTrue);
    expect(find.byType(PaletteStrip), findsWidgets);
  });

  testWidgets('the base picker button is disabled with no usable markers', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(tester, brand: MarkerBrand.decoTime);

    // Nothing usable to pick from: the button is disabled, like Generate.
    expect(
      tester.widget<InkIconButton>(_key('palette-pick-base')).onPressed,
      isNull,
    );
  });

  testWidgets('the base field suggests no marker of the range', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(tester, brand: MarkerBrand.decoTime);

    await tester.enterText(_key('palette-base-input'), '0');
    await tester.pumpAndSettle();

    // No suggestion out of the brand's range.
    expect(_key('palette-base-options'), findsNothing);
  });

  testWidgets('a base the user does not own cannot be built', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(
      tester,
      setup: (AppScope scope) => scope.settings.setCollection(
        AppSettings(extraMarkerIds: const <String>{'B08'}),
      ),
    );

    // A marker of the range the user does not own: it resolves, but the
    // engines refuse it, so there is nothing to build.
    await enterBaseCode(tester, 'R38');
    expect(_enabled(tester, _key('palette-generate')), isFalse);
    expect(_enabled(tester, _key('palette-suggest-ai')), isFalse);

    // The user's own marker: the palette can be built.
    await enterBaseCode(tester, 'B08');
    expect(_enabled(tester, _key('palette-generate')), isTrue);
    expect(_enabled(tester, _key('palette-suggest-ai')), isTrue);
  });

  testWidgets('with no marker: the chain offers the whole range', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(
      tester,
      setup: (AppScope scope) => scope.settings.setCollection(AppSettings()),
    );

    await choosePaletteType(tester, 'palette-mode-blendingChain');
    await enterBaseCode(tester, 'B08');

    // There is no chain, but the whole range is the way out of it.
    expect(find.byType(PaletteStrip), findsNothing);
    expect(_key('palette-chain-whole-range'), findsOneWidget);

    await tester.ensureVisible(_key('palette-chain-whole-range'));
    await tester.tap(_key('palette-chain-whole-range'));
    await tester.pumpAndSettle();

    // The chain is built, out of the range.
    expect(find.byType(PaletteStrip), findsWidgets);
    expect(
      find.text(l10n.paletteChainWholeRangeNote(MarkerBrand.ohuhuOahu.label)),
      findsOneWidget,
    );
    expect(_key('palette-chain-my-markers'), findsOneWidget);
  });

  testWidgets('the whole range never leaves the chain', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(
      tester,
      setup: (AppScope scope) => scope.settings.setCollection(AppSettings()),
    );

    await choosePaletteType(tester, 'palette-mode-blendingChain');
    await enterBaseCode(tester, 'B08');
    await tester.ensureVisible(_key('palette-chain-whole-range'));
    await tester.tap(_key('palette-chain-whole-range'));
    await tester.pumpAndSettle();
    expect(_key('palette-chain-my-markers'), findsOneWidget);

    // The scenes leave the chain behind: the range goes with it, so the
    // empty state is back and the base field offers no code of the range.
    await choosePaletteType(tester, 'palette-scenario-toggle');
    await tester.pumpAndSettle();

    expect(_key('palette-chain-my-markers'), findsNothing);
    expect(_key('palette-empty-collection'), findsOneWidget);
    await tester.enterText(_key('palette-base-input'), 'B');
    await tester.pumpAndSettle();
    expect(_key('palette-base-options'), findsNothing);
  });

  testWidgets('with every marker dried out: the page says so', (
    WidgetTester tester,
  ) async {
    await pumpWithAi(
      tester,
      setup: (AppScope scope) async {
        await scope.settings.setCollection(
          AppSettings(extraMarkerIds: const <String>{'B08', 'B411'}),
        );
        await scope.dried.add('ohuhu_oahu:B08');
        await scope.dried.add('ohuhu_oahu:B411');
      },
    );

    // The collection is not empty: the page does not say the user owns
    // nothing, it says the markers ran dry.
    expect(
      find.text(l10n.missingMarkersTitle(MarkerBrand.ohuhuOahu.label)),
      findsNothing,
    );
    expect(find.text(l10n.driedTitle), findsOneWidget);
    expect(find.text(l10n.allMarkersDried), findsOneWidget);
    expect(_key('palette-empty-collection-action'), findsOneWidget);
    // The failure note must not contradict the dried empty state.
    expect(
      find.text(l10n.paletteNoAvailableColors(MarkerBrand.ohuhuOahu.name)),
      findsNothing,
    );
  });

  testWidgets(
    'Mix my brands, the active brand empty and the other all dried: dried',
    (WidgetTester tester) async {
      await pumpWithAi(
        tester,
        setup: (AppScope scope) async {
          await scope.settings.setCollection(
            AppSettings(
              extraMarkerIds: const <String>{'decotime:91', 'decotime:92'},
            ),
          );
          await scope.settings.setScope(BrandScope.mixedBrands);
          await scope.dried.add('decotime:91');
          await scope.dried.add('decotime:92');
        },
      );
      // Ohuhu owns nothing, but the collection the switch covers is not
      // empty: its markers ran dry.
      expect(find.text(l10n.driedTitle), findsOneWidget);
      expect(find.text(l10n.allMarkersDried), findsOneWidget);
      expect(
        find.text(l10n.missingMarkersTitle(MarkerBrand.ohuhuOahu.label)),
        findsNothing,
      );
    },
  );

  testWidgets(
    'Mix my brands, the active brand empty and the other usable: not dried',
    (WidgetTester tester) async {
      await pumpWithAi(
        tester,
        setup: (AppScope scope) async {
          await scope.settings.setCollection(
            AppSettings(
              extraMarkerIds: const <String>{'decotime:91', 'decotime:92'},
            ),
          );
          await scope.settings.setScope(BrandScope.mixedBrands);
          await scope.dried.add('decotime:92');
        },
      );
      // One usable brand is nothing to mix: the page works with the active
      // brand, which is empty, and must not claim that everything ran dry.
      expect(
        find.text(l10n.missingMarkersTitle(MarkerBrand.ohuhuOahu.label)),
        findsOneWidget,
      );
      expect(find.text(l10n.allMarkersDried), findsNothing);
    },
  );
}
