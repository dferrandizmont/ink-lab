import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';
import 'package:ink_lab/ui/widgets/ink_search_field.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';

import '../ai/ai_test_support.dart';
import '../support/layout_stability.dart';

// Switching a segment, a type or a filter in place never moves a control (or
// the header above it): every screen that swaps content or header text is
// pumped in all six languages x {360, 412} dp x {1.0, 1.3} text and the
// position of its controls is compared across the segments.

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// The owned checks of the grid cells.
Finder _ownedChecks() => find.byWidgetPredicate(
  (Widget w) => w is InkIcon && w.icon == InkIcons.check,
);

/// The control under the segment switch: the search field in Ideas and the
/// "Add to diary" button in the Diary. Both sit in the same 48 dp slot, so
/// the content below them starts at the same place in both segments.
Finder _ideasContentSlot() => find.byWidgetPredicate(
  (Widget w) =>
      w.key == const ValueKey<String>('ideas-search') ||
      w.key == const ValueKey<String>('diary-add-slot'),
);

/// The text [label] inside [scope] (a segmented control, a chip row...).
Finder _in(Finder scope, String label) =>
    find.descendant(of: scope, matching: find.text(label));

Future<void> _tapIn(WidgetTester tester, Finder scope, String label) async {
  final Finder target = _in(scope, label);
  expect(target, findsOneWidget, reason: 'segment "$label"');
  await tester.tap(target);
}

/// Picks a palette type in the type sheet.
Future<void> _pickType(WidgetTester tester, String rowKey) async {
  await tester.tap(_key('palette-type-field'));
  await tester.pumpAndSettle();
  final Finder row = _key(rowKey);
  await tester.ensureVisible(row);
  await tester.pumpAndSettle();
  await tester.tap(row);
  await tester.pumpAndSettle();
}

/// The vertical list of a page: the chip rows and the search field also scroll,
/// but sideways, so they are not the list to walk.
Finder _verticalScrollable() => find.byWidgetPredicate(
  (Widget w) => w is Scrollable && w.axisDirection == AxisDirection.down,
);

void main() {
  stabilityTest('ideas: Ideas | Diary keeps the header and the control', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    await pumpStability(tester, env, IdeasPage(today: DateTime(2026, 10, 29)));
    final Finder view = _key('ideas-view');
    Future<void> tap(String label) => _tapIn(tester, view, label);
    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'header': find.byType(InkPageHeader),
        'control': view,
        // The slot under the control: the search field in Ideas, the "Add to
        // diary" button in the Diary. Both are 48 high, so the content below
        // them starts at the same place in both segments.
        'content slot': _ideasContentSlot(),
        // Only the ideas segment has a search field below the control.
        'search': _key('ideas-search'),
      },
      segments: <StabilitySegment>[
        (name: 'ideas', activate: () async {}),
        (name: 'diary', activate: () => tap(env.t.ideasDiarySegment)),
        (name: 'ideas again', activate: () => tap(env.t.ideasTitle)),
        (name: 'diary again', activate: () => tap(env.t.ideasDiarySegment)),
      ],
    );
  });

  stabilityTest('ideas: Ideas | Diary with no collection (whole range)', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    final AppScope scope = await pumpStability(
      tester,
      env,
      IdeasPage(today: DateTime(2026, 10, 29)),
    );
    // No sets and no markers: the subtitle becomes the whole-range one.
    await scope.settings.setCollection(
      AppSettings(ownedSetIds: const <String>{}),
    );
    await tester.pumpAndSettle();
    final Finder view = _key('ideas-view');
    await expectStableAcrossSegments(
      tester,
      env: env,
      where: 'whole range',
      anchors: <String, Finder>{
        'header': find.byType(InkPageHeader),
        'control': view,
        // The slot under the control is the same in both segments.
        'content slot': _ideasContentSlot(),
      },
      segments: <StabilitySegment>[
        (name: 'ideas', activate: () async {}),
        (
          name: 'diary',
          activate: () => _tapIn(tester, view, env.t.ideasDiarySegment),
        ),
        (
          name: 'ideas again',
          activate: () => _tapIn(tester, view, env.t.ideasTitle),
        ),
      ],
    );
  });

  stabilityTest('palette: switching the type keeps header and type field', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    await pumpStability(tester, env, const PalettePage());
    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'header': find.byType(InkPageHeader),
        'type field': _key('palette-type-field'),
      },
      segments: <StabilitySegment>[
        (name: 'recommended', activate: () async {}),
        (
          name: 'custom palette',
          activate: () => _pickType(tester, 'palette-mode-customPalette'),
        ),
        (
          name: 'triad',
          activate: () => _pickType(tester, 'palette-mode-triad'),
        ),
        (
          name: 'scenes',
          activate: () => _pickType(tester, 'palette-scenario-toggle'),
        ),
        (
          name: 'recommended again',
          activate: () => _pickType(tester, 'palette-mode-recommended'),
        ),
      ],
    );
  });

  stabilityTest('collection: the brand selector never moves', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    final AppScope scope = await pumpStability(
      tester,
      env,
      const CollectionPage(),
    );
    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'brand selector': _key('collection-brand'),
        'summary': _key('collection-summary'),
      },
      // The card below the selector is content: its height follows the brand.
      topOnly: <String>{'summary'},
      segments: <StabilitySegment>[
        for (final MarkerBrand brand in <MarkerBrand>[
          ...MarkerBrand.values,
          MarkerBrand.values.first,
        ])
          (name: brand.id, activate: () => scope.settings.setBrand(brand)),
      ],
    );
  });

  stabilityTest('swatches: the filter chips keep header, search and chips', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    await pumpStability(tester, env, SwatchesPage(onBlendingChain: (_) {}));
    final Finder chips = find.byType(InkChipRow);
    Future<void> tap(String label) => _tapIn(tester, chips, label);
    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'header': find.byType(InkPageHeader),
        'search': find.byType(InkSearchField),
        'chips': chips,
        // The first cell of the grid: the filters change its colours, not
        // its place.
        'grid': find.byType(ColorSwatchTile),
      },
      segments: <StabilitySegment>[
        (name: 'all', activate: () async {}),
        (name: 'mine', activate: () => tap(env.t.swatchesOwnedOnly)),
        (name: 'favourites', activate: () => tap(env.t.swatchesFavoritesOnly)),
        (name: 'all again', activate: () => tap(env.t.swatchesAllFilter)),
      ],
    );
    // The owned check of the grid follows the filter: with "Mine" every cell
    // would carry it, so it says nothing and is left out.
    await tap(env.t.swatchesOwnedOnly);
    await tester.pumpAndSettle();
    expect(_ownedChecks(), findsNothing);
    await tap(env.t.swatchesAllFilter);
    await tester.pumpAndSettle();
    expect(_ownedChecks(), findsWidgets);
  });

  stabilityTest('swatches: the detail sheet keeps its header and its actions', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    await pumpStability(tester, env, SwatchesPage(onBlendingChain: (_) {}));
    // The whole range, so there is a swatch to open.
    await _tapIn(tester, find.byType(InkChipRow), env.t.swatchesAllFilter);
    await tester.pumpAndSettle();
    // With larger text the grid shows fewer columns and builds fewer cells at
    // once, so the marker may start below the built range: scroll to it.
    final Finder swatch = find.text('B08');
    await tester.scrollUntilVisible(
      swatch,
      200,
      scrollable: _verticalScrollable(),
    );
    await tester.pumpAndSettle();
    await tester.tap(swatch);
    await tester.pumpAndSettle();
    // The sheet at the full height: its header, its action and the row of
    // the own colour are on screen together with the groups below.
    await tester.drag(
      find
          .descendant(
            of: find.byType(InkSheet),
            matching: find.byType(Scrollable),
          )
          .first,
      const Offset(0, -600),
    );
    await tester.pumpAndSettle();
    // The header of the group of a brand: the group itself grows with its
    // results, and tapping one of those would open another marker.
    final Finder groupHeader = find
        .descendant(
          of: _key('swatch-equivalents-copic'),
          matching: find.byType(InkWell),
        )
        .first;
    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'header': _key('swatch-header'),
        'primary': _key('swatch-primary'),
        'my colour': _key('swatch-my-colour-row'),
      },
      segments: <StabilitySegment>[
        (name: 'every brand', activate: () async {}),
        (name: 'a group open', activate: () => tester.tap(groupHeader)),
        (name: 'the group closed', activate: () => tester.tap(groupHeader)),
        (
          name: 'only mine',
          activate: () => tester.tap(_key('swatch-equivalents-only-mine')),
        ),
        (
          name: 'every brand again',
          activate: () => tester.tap(_key('swatch-equivalents-only-mine')),
        ),
      ],
    );
  });

  stabilityTest('settings: Appearance segments keep the rows where they are', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    await pumpStability(tester, env, const SettingsPage());
    final Finder control = find.byType(InkSegmented<AppThemeMode>);
    await tester.ensureVisible(control);
    await tester.pumpAndSettle();
    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'appearance control': control,
        'language row': _key('settings-language'),
      },
      segments: <StabilitySegment>[
        (name: 'system', activate: () async {}),
        (
          name: 'light',
          activate: () =>
              _tapIn(tester, control, env.t.settingsAppearanceLight),
        ),
        (
          name: 'dark',
          activate: () => _tapIn(tester, control, env.t.settingsAppearanceDark),
        ),
        (
          name: 'system again',
          activate: () =>
              _tapIn(tester, control, env.t.settingsAppearanceSystem),
        ),
      ],
    );
  });

  stabilityTest('settings: the AI model picker keeps Free | Paid | Both', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    final StoredAiSettingsRepository repo = StoredAiSettingsRepository(
      InMemoryKeyValueStore(),
    );
    await repo.replace(
      AiSettings(
        enabled: true,
        provider: AiProvider.openRouter,
        textModel: 'free/model-0:free',
      ),
    );
    final InMemorySecretStore secrets = InMemorySecretStore(<String, String>{
      openRouterApiKeyName: 'sk-or-v1-abcdef0123456789abcdef0123456789',
    });
    http.Client catalog() => MockClient(
      (_) async => jsonResponse(<String, Object>{
        'data': <Object>[
          for (int i = 0; i < 12; i++)
            <String, Object>{
              'id': 'free/model-$i:free',
              'name': 'Free model $i',
              'pricing': <String, String>{'prompt': '0', 'completion': '0'},
            },
          <String, Object>{
            'id': 'b',
            'name': 'Paid B',
            'pricing': <String, String>{'prompt': '1', 'completion': '1'},
          },
        ],
      }),
    );
    final AiService service = AiService(
      aiSettings: repo,
      secrets: secrets,
      clientFactory: catalog,
    );
    await pumpStability(
      tester,
      env,
      const SettingsPage(),
      aiSettings: repo,
      secrets: secrets,
      aiService: service,
    );
    final Finder load = _key('ai-load-models');
    await tester.ensureVisible(load);
    await tester.pumpAndSettle();
    await tester.tap(load);
    await tester.pumpAndSettle();
    final Finder row = _key('ai-text-model-row');
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    await tester.tap(row);
    await tester.pumpAndSettle();

    final Finder filter = find.byType(InkSegmented<AiModelFilter>);
    Future<void> tap(String label) => _tapIn(tester, filter, label);
    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'filter control': filter,
        'search': _key('ai-model-search'),
      },
      segments: <StabilitySegment>[
        (name: 'free', activate: () async {}),
        (name: 'paid', activate: () => tap(env.t.settingsAiModelsFilterPaid)),
        (name: 'both', activate: () => tap(env.t.settingsAiModelsFilterBoth)),
        (
          name: 'free again',
          activate: () => tap(env.t.settingsAiModelsFilterFree),
        ),
      ],
    );
  });
}
