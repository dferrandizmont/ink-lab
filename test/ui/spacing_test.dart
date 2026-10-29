// Spacing regressions (owner rule: nothing may touch anything else).
//
// One test per page checks a couple of the key gaps against the semantic
// constants of `InkSpacing` so the rhythm cannot silently collapse again.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_result_tile.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../ai/ai_test_support.dart';
import 'ideas/ideas_test_support.dart';
import 'match/match_test_support.dart';
import 'palette/palette_test_support.dart';
import 'settings/ai_section_test.dart' show pumpSection;
import 'settings/settings_page_test.dart' show pumpSettings;
import 'swatches/swatches_page_test.dart' show openFilters, pumpSwatches;
import '../support/l10n.dart';

/// Vertical distance from the bottom of [upper] to the top of [lower].
double _gapBelow(WidgetTester tester, Finder upper, Finder lower) =>
    tester.getRect(lower).top - tester.getRect(upper).bottom;

void main() {
  testWidgets('Palette: field -> strip -> roles card are 16 apart', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');

    final Finder field = find.ancestor(
      of: find.byKey(const ValueKey<String>('palette-base-input')),
      matching: find.byWidgetPredicate(
        (Widget w) =>
            w is Container &&
            w.constraints?.maxHeight == InkGeometry.fieldHeight,
      ),
    );
    final Finder strip = find.byType(PaletteStrip).first;
    final Finder rolesCard = find
        .ancestor(
          of: find.byWidgetPredicate(
            (Widget w) =>
                w.key is ValueKey<String> &&
                (w.key! as ValueKey<String>).value.startsWith('palette-row-'),
          ),
          matching: find.byType(Card),
        )
        .first;
    final Finder firstRow = find
        .byWidgetPredicate(
          (Widget w) =>
              w.key is ValueKey<String> &&
              (w.key! as ValueKey<String>).value.startsWith('palette-row-'),
        )
        .first;

    expect(
      _gapBelow(tester, field, strip),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    expect(
      _gapBelow(tester, strip, rolesCard),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    // The roles card is a real card: its text keeps the 16 inner margin.
    expect(
      tester
              .getRect(
                find
                    .descendant(of: firstRow, matching: find.byType(Text))
                    .first,
              )
              .left -
          tester.getRect(rolesCard).left,
      greaterThanOrEqualTo(InkSpacing.cardH),
    );
  });

  testWidgets('Match: photo, result, buttons and history are spaced', (
    WidgetTester tester,
  ) async {
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      image: sampledImage(64, 64, <int>[255, 0, 0]),
    );
    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('match-canvas')));
    await tester.pumpAndSettle();

    final Finder canvas = find.byKey(const ValueKey<String>('match-canvas'));
    final Finder sampled = find.byKey(
      const ValueKey<String>('match-sampled-hex'),
    );
    final Finder best = find.byType(BestMatchTile);
    final Finder camera = find.byKey(const ValueKey<String>('match-camera'));
    final Finder gallery = find.byKey(const ValueKey<String>('match-gallery'));

    expect(
      _gapBelow(tester, canvas, sampled),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    expect(
      _gapBelow(tester, sampled, best),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    expect(
      _gapBelow(tester, find.byType(MatchResultTile).last, camera),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    expect(
      tester.getRect(gallery).left - tester.getRect(camera).right,
      greaterThanOrEqualTo(InkSpacing.s8),
    );
    // The page ends with room above the nav.
    final ListView page = tester.widget<ListView>(
      find.byKey(MatchPage.pageKey),
    );
    expect(
      (page.padding! as EdgeInsets).bottom,
      greaterThanOrEqualTo(InkSpacing.pageBottom),
    );
  });

  testWidgets('Ideas: chips -> content and card padding keep their air', (
    WidgetTester tester,
  ) async {
    await pumpIdeas(tester);

    final Finder chips = find.byType(InkChipRow);
    final Finder hint = find.text(l10n.ideasSelectHint);
    expect(
      _gapBelow(tester, chips, hint),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    final Finder firstRow = find.text('Sticker Effect');
    expect(
      _gapBelow(tester, hint, firstRow),
      greaterThanOrEqualTo(InkSpacing.block),
    );

    await tester.tap(firstRow);
    await tester.pumpAndSettle();
    final Finder card = find.ancestor(
      of: find.text(AppTypography.caps(l10n.ideasSelectedLabel)),
      matching: find.byType(Card),
    );
    expect(
      _gapBelow(tester, chips, card),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    expect(
      tester
              .getRect(find.text(AppTypography.caps(l10n.ideasSelectedLabel)))
              .left -
          tester.getRect(card).left,
      greaterThanOrEqualTo(InkSpacing.cardH),
    );
  });

  testWidgets('Swatches: search, chips and grid; filters sheet padding', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    final Finder search = find.byType(TextField).first;
    final Finder chips = find.byType(InkChipRow);
    final Finder firstTile = find.byType(ColorSwatchTile).first;
    expect(
      _gapBelow(tester, search, chips),
      greaterThanOrEqualTo(InkSpacing.group),
    );
    expect(
      _gapBelow(tester, chips, firstTile),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    final Rect a = tester.getRect(find.byType(ColorSwatchTile).at(0));
    final Rect b = tester.getRect(find.byType(ColorSwatchTile).at(1));
    expect(b.left - a.right, greaterThanOrEqualTo(InkSpacing.s12));
    // Cell text keeps a 12 px inner margin.
    expect(
      tester.getRect(find.text('B08')).left -
          tester.getRect(find.byType(ColorSwatchTile).first).left,
      greaterThanOrEqualTo(InkSpacing.cardV),
    );

    await openFilters(tester);
    final Finder title = find.descendant(
      of: find.byType(InkSheet),
      matching: find.text(l10n.swatchesFiltersTitle),
    );
    final Finder firstGroup = find.text(
      AppTypography.caps(l10n.swatchesLabelPack),
    );
    expect(
      _gapBelow(tester, title, firstGroup),
      greaterThanOrEqualTo(InkSpacing.block),
    );
    expect(tester.getRect(title).left, greaterThanOrEqualTo(InkSpacing.sheet));
    // Groups of the sheet are 24 apart (control -> next caps label).
    final Finder labelCaps = find.text(
      AppTypography.caps(l10n.swatchesLabelMode),
    );
    expect(
      _gapBelow(tester, find.byType(Wrap).last, labelCaps),
      greaterThanOrEqualTo(InkSpacing.sheet),
    );
  });

  testWidgets('Swatches: detail sheet keeps 24 padding and 8 between buttons', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);
    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();

    final Rect copy = tester.getRect(
      find.widgetWithText(OutlinedButton, l10n.swatchesCopyHex),
    );
    final Rect add = tester.getRect(
      find.widgetWithText(FilledButton, l10n.swatchesAddToPalette),
    );
    expect(add.left - copy.right, greaterThanOrEqualTo(InkSpacing.s8));
    expect(add.right, lessThanOrEqualTo(390 - InkSpacing.sheet));
    expect(
      _gapBelow(
        tester,
        find.widgetWithText(FilledButton, l10n.swatchesAddToPalette),
        find.text(l10n.swatchesClosestAlternatives),
      ),
      greaterThanOrEqualTo(InkSpacing.block),
    );
  });

  testWidgets('Settings: groups are 32 apart and rows keep 16 x 12', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    tester.view.physicalSize = const Size(390, 6000);
    await tester.pumpAndSettle();

    final Finder collectionCard = find
        .ancestor(
          of: find.text(l10n.settingsBrandTitle),
          matching: find.byType(Card),
        )
        .first;
    final Finder displayHead = find.text(
      AppTypography.caps(l10n.settingsDisplayGroup),
    );
    expect(
      _gapBelow(tester, collectionCard, displayHead),
      greaterThanOrEqualTo(InkSpacing.section),
    );
    // Head -> its card: 8.
    final Finder displayCard = find
        .ancestor(
          of: find.text(l10n.settingsLabelsTitle),
          matching: find.byType(Card),
        )
        .first;
    expect(
      _gapBelow(tester, displayHead, displayCard),
      greaterThanOrEqualTo(InkSpacing.group),
    );
    // A row's label keeps the 16 inner margin of its card.
    expect(
      tester.getRect(find.text(l10n.settingsLabelsTitle)).left -
          tester.getRect(displayCard).left,
      greaterThanOrEqualTo(InkSpacing.cardH),
    );
    // The page ends with room above the nav.
    final ListView list = tester.widget<ListView>(find.byType(ListView).first);
    expect(
      (list.padding! as EdgeInsets).bottom,
      greaterThanOrEqualTo(InkSpacing.pageBottom),
    );
  });

  testWidgets('Settings: AI model sheet spaces filter, search and list', (
    WidgetTester tester,
  ) async {
    await pumpSection(
      tester,
      provider: AiProvider.openRouter,
      client: MockClient(
        (http.Request _) async =>
            jsonResponse(<String, Object>{'data': <Object>[]}),
      ),
    );
    await tester.tap(find.byKey(const ValueKey<String>('ai-text-model-row')));
    await tester.pumpAndSettle();

    final Finder filter = find.byType(InkSegmented<AiModelFilter>);
    final Finder search = find.byKey(const ValueKey<String>('ai-model-search'));
    expect(
      _gapBelow(tester, filter, search),
      greaterThanOrEqualTo(InkSpacing.s12),
    );
    expect(tester.getRect(search).left, greaterThanOrEqualTo(InkSpacing.sheet));
    expect(
      tester
              .getRect(
                find.text(AppTypography.caps(l10n.settingsAiRecommended)),
              )
              .top -
          tester.getRect(search).bottom,
      greaterThanOrEqualTo(InkSpacing.s12),
    );
  });
}
