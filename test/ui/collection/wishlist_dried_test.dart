import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/shopping_list.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_result_tile.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';

import '../../support/l10n.dart';
import '../match/match_test_support.dart';
import '../palette/palette_test_support.dart';
import '../swatches/swatches_page_test.dart' show pumpSwatches;

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

List<MarkerColor> _catalogue() => parseColors(
  File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
  brand: MarkerBrand.ohuhuOahu,
);

Finder _key(String key) => find.byKey(ValueKey<String>(key));

Future<AppScope> _pumpCollection(WidgetTester tester) async {
  tester.view.physicalSize = const Size(412, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: _markers(),
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

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Opens the detail sheet of [code] in Swatches.
Future<void> _openDetail(WidgetTester tester, String code) async {
  await tester.enterText(find.byType(TextField), code);
  await tester.pumpAndSettle();
  await tester.tap(
    find.descendant(
      of: find.byType(ColorSwatchTile),
      matching: find.text(code),
    ),
  );
  await tester.pumpAndSettle();
}

bool _isDriedMark(Widget w) => w is InkIcon && w.icon == InkIcons.dropletOff;

void main() {
  setUpAll(loadAppFonts);

  group('wishlist in the swatch detail', () {
    testWidgets('any marker can be added to the wishlist and taken off', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      // BV04 is not in the default collection (Classic 160).
      await _openDetail(tester, 'BV04');

      expect(_key('swatch-wishlist'), findsOneWidget);
      expect(find.text(l10n.wishlistAdd), findsOneWidget);
      // Not owned, so it cannot be marked as dried out.
      expect(_key('swatch-dried'), findsNothing);

      await _tapVisible(tester, _key('swatch-wishlist'));
      expect(scope.wishlist.contains('BV04'), isTrue);
      expect(find.text(l10n.wishlistRemove), findsOneWidget);

      await _tapVisible(tester, _key('swatch-wishlist'));
      expect(scope.wishlist.contains('BV04'), isFalse);
      expect(find.text(l10n.wishlistAdd), findsOneWidget);
    });

    testWidgets('the wishlist is per brand', (WidgetTester tester) async {
      final AppScope scope = await pumpSwatches(tester);
      await _openDetail(tester, 'B08');
      await _tapVisible(tester, _key('swatch-wishlist'));
      expect(scope.wishlist.ids, <String>{'ohuhu_oahu:B08'});
      expect(scope.wishlist.countOf(MarkerBrand.decoTime), 0);
    });
  });

  group('dried out in the swatch detail', () {
    testWidgets(
      'an owned marker can be marked, is flagged and offers the list',
      (WidgetTester tester) async {
        final AppScope scope = await pumpSwatches(tester);
        await _openDetail(tester, 'B08');

        expect(find.text(l10n.driedMark), findsOneWidget);
        expect(_key('swatch-dried-note'), findsNothing);
        await _tapVisible(tester, _key('swatch-dried'));

        expect(scope.dried.contains('B08'), isTrue);
        expect(_key('swatch-dried-note'), findsOneWidget);
        expect(find.text(l10n.driedNote), findsOneWidget);
        expect(find.text(l10n.driedUnmark), findsOneWidget);
        // Marking it dried offers to buy a refill.
        expect(find.text(l10n.wishlistOfferTitle), findsOneWidget);
        expect(find.text(l10n.wishlistOfferBody('B08')), findsOneWidget);
        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(l10n.wishlistAdd),
          ),
        );
        await tester.pumpAndSettle();
        expect(scope.wishlist.contains('B08'), isTrue);
        expect(scope.dried.contains('B08'), isTrue);
      },
    );

    testWidgets('the offer can be declined and nothing is added', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await _openDetail(tester, 'B08');
      await _tapVisible(tester, _key('swatch-dried'));
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(l10n.settingsCancel),
        ),
      );
      await tester.pumpAndSettle();
      expect(scope.dried.contains('B08'), isTrue);
      expect(scope.wishlist.contains('B08'), isFalse);
    });

    testWidgets('no offer when it is already on the wishlist', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await scope.wishlist.add('B08');
      await _openDetail(tester, 'B08');
      await _tapVisible(tester, _key('swatch-dried'));
      expect(find.byType(AlertDialog), findsNothing);
      expect(scope.dried.contains('B08'), isTrue);
    });

    testWidgets('marking it usable again clears the flag, no offer', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await scope.dried.add('B08');
      await _openDetail(tester, 'B08');
      expect(_key('swatch-dried-note'), findsOneWidget);
      await _tapVisible(tester, _key('swatch-dried'));
      expect(find.byType(AlertDialog), findsNothing);
      expect(scope.dried.contains('B08'), isFalse);
      expect(_key('swatch-dried-note'), findsNothing);
    });

    testWidgets('a dried marker shows the mark in the grid and the list', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await tester.enterText(find.byType(TextField), 'B08');
      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate(_isDriedMark), findsNothing);
      await scope.dried.add('B08');
      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate(_isDriedMark), findsOneWidget);
      await scope.dried.remove('B08');
      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate(_isDriedMark), findsNothing);
    });
  });

  group('My collection', () {
    testWidgets('the wishlist lists the markers and removes them', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(tester);
      expect(find.text(l10n.wishlistCount(0)), findsOneWidget);
      expect(find.text(l10n.wishlistEmpty), findsOneWidget);
      expect(_key('wishlist-copy'), findsNothing);

      await scope.wishlist.add('R16');
      await scope.wishlist.add('B08');
      await scope.wishlist.add('decotime:01');
      await tester.pumpAndSettle();

      // Only the active brand (Ohuhu), in code order.
      expect(find.text(l10n.wishlistCount(2)), findsOneWidget);
      expect(_key('wishlist-row-ohuhu_oahu:B08'), findsOneWidget);
      expect(_key('wishlist-row-ohuhu_oahu:R16'), findsOneWidget);
      expect(_key('wishlist-row-decotime:01'), findsNothing);
      expect(
        tester.getTopLeft(_key('wishlist-row-ohuhu_oahu:B08')).dy,
        lessThan(tester.getTopLeft(_key('wishlist-row-ohuhu_oahu:R16')).dy),
      );
      expect(find.text('Cotton Candy Blue'), findsWidgets);

      await _tapVisible(tester, _key('wishlist-remove-ohuhu_oahu:B08'));
      expect(scope.wishlist.contains('B08'), isFalse);
      expect(find.text(l10n.wishlistCount(1)), findsOneWidget);
      // The other brand's wish is untouched.
      expect(scope.wishlist.contains('decotime:01'), isTrue);
    });

    testWidgets('"Copy list" copies brand, code and name per line', (
      WidgetTester tester,
    ) async {
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall call) async {
          if (call.method == 'Clipboard.setData') {
            copied =
                (call.arguments as Map<Object?, Object?>)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      final AppScope scope = await _pumpCollection(tester);
      await scope.wishlist.add('R16');
      await scope.wishlist.add('B08');
      await tester.pumpAndSettle();

      await _tapVisible(tester, _key('wishlist-copy'));

      final List<MarkerColor> all = _catalogue();
      MarkerColor byCode(String code) =>
          all.firstWhere((MarkerColor c) => c.newCode == code);
      expect(
        copied,
        shoppingListText(<MarkerColor>[
          byCode('B08'),
          byCode('R16'),
        ], mode: scope.settings.nameDisplayMode),
      );
      expect(copied!.split('\n'), hasLength(2));
      expect(copied!.split('\n').first, startsWith('Ohuhu - B08'));
      expect(copied, contains('Cotton Candy Blue'));
      expect(find.text(l10n.wishlistCopied), findsOneWidget);
    });

    testWidgets('the dried card counts the markers and lets you see them', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(tester);
      expect(find.text(l10n.driedCount(0)), findsOneWidget);
      expect(find.text(l10n.driedEmpty), findsOneWidget);
      expect(_key('dried-disclosure'), findsNothing);

      await scope.dried.add('B08');
      await scope.dried.add('R16');
      await tester.pumpAndSettle();
      expect(find.text(l10n.driedCount(2)), findsOneWidget);
      expect(find.text(l10n.driedHint), findsOneWidget);
      // Closed until opened.
      expect(_key('dried-row-ohuhu_oahu:B08'), findsNothing);

      await _tapVisible(tester, _key('dried-disclosure'));
      expect(_key('dried-row-ohuhu_oahu:B08'), findsOneWidget);
      expect(_key('dried-row-ohuhu_oahu:R16'), findsOneWidget);

      await _tapVisible(tester, _key('dried-unmark-ohuhu_oahu:B08'));
      expect(scope.dried.contains('B08'), isFalse);
      expect(find.text(l10n.driedCount(1)), findsOneWidget);
      expect(_key('dried-row-ohuhu_oahu:B08'), findsNothing);
    });

    testWidgets('"What to buy next" shows ten markers you do not own', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(tester);
      final Finder rows = find.byWidgetPredicate(
        (Widget w) =>
            w.key is ValueKey<String> &&
            (w.key! as ValueKey<String>).value.startsWith('buy-next-ohuhu'),
      );
      expect(rows, findsNWidgets(10));
      expect(find.textContaining('Improves'), findsWidgets);
      expect(_key('buy-next-empty'), findsNothing);

      final List<MarkerColor> all = _catalogue();
      final Set<String> owned = <String>{
        for (final MarkerColor c in all)
          if (c.sets.contains('classic_160')) c.colorId,
      };
      for (final Element e in rows.evaluate()) {
        final String id = (e.widget.key! as ValueKey<String>).value.substring(
          'buy-next-'.length,
        );
        expect(owned, isNot(contains(id)));
      }

      // The button puts the marker on the wishlist and takes it off again.
      final String firstId =
          (rows.evaluate().first.widget.key! as ValueKey<String>).value
              .substring('buy-next-'.length);
      await _tapVisible(tester, _key('buy-next-wish-$firstId'));
      expect(scope.wishlist.contains(firstId), isTrue);
      expect(find.text(l10n.wishlistCount(1)), findsOneWidget);
      await _tapVisible(tester, _key('buy-next-wish-$firstId'));
      expect(scope.wishlist.contains(firstId), isFalse);
    });

    testWidgets('"What to buy next" asks for a collection first', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(tester);
      await scope.settings.setCollection(AppSettings());
      await tester.pumpAndSettle();
      expect(_key('buy-next-empty'), findsOneWidget);
      expect(find.text(l10n.buyNextNoCollection), findsOneWidget);
    });

    testWidgets('a dried marker no longer counts, so it can be suggested', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(tester);
      // Dry the whole of one hue family: the suggestions change.
      final List<MarkerColor> all = _catalogue();
      final List<MarkerColor> owned = all
          .where((MarkerColor c) => c.sets.contains('classic_160'))
          .toList();
      final String before = _suggestedIds(tester).join(',');
      for (final MarkerColor c in owned.where(
        (MarkerColor c) => hexToHsv(c.hex)[0] > 40 && hexToHsv(c.hex)[0] < 90,
      )) {
        await scope.dried.add(c.colorId);
      }
      await tester.pumpAndSettle();
      expect(_suggestedIds(tester).join(','), isNot(before));
    });

    testWidgets('a marker leaves the wishlist when you get it', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpCollection(tester);
      // BV04 is outside Classic 160.
      await scope.wishlist.add('BV04');
      await tester.pumpAndSettle();
      expect(_key('wishlist-row-ohuhu_oahu:BV04'), findsOneWidget);

      await scope.settings.setExtraMarkerIds(<String>{'ohuhu_oahu:BV04'});
      await tester.pumpAndSettle();
      expect(scope.wishlist.contains('BV04'), isFalse);
      expect(_key('wishlist-row-ohuhu_oahu:BV04'), findsNothing);
    });
  });

  group('dried markers are not suggested', () {
    // Markers with a lettered code, so a code on screen is never a number
    // that a ΔE or a count could also show.
    final List<MarkerColor> classic = _catalogue()
        .where(
          (MarkerColor c) =>
              c.sets.contains('classic_160') &&
              RegExp(r'^[A-Z]{1,3}\d{2,3}$').hasMatch(c.newCode),
        )
        .take(8)
        .toList();
    final Set<String> ids = <String>{
      for (final MarkerColor c in classic) c.colorId,
    };

    testWidgets('Match leaves them out of the pool and the best match', (
      WidgetTester tester,
    ) async {
      final RgbColor rgb = hexToRgb(classic.first.hex);
      final AppScope scope = await pumpMatch(
        tester,
        picker: FakeImagePickerService(PhotoPicked(tinyPng)),
        image: sampledImage(64, 64, <int>[rgb.r, rgb.g, rgb.b]),
      );
      await scope.settings.setCollection(AppSettings(extraMarkerIds: ids));
      await tester.pumpAndSettle();
      await tester.tap(_key('match-camera'));
      await tester.pumpAndSettle();
      await tester.tap(_key('match-canvas'));
      await tester.pumpAndSettle();

      expect(find.text(l10n.matchSubtitle(8)), findsOneWidget);
      Finder bestHas(String code) => find.descendant(
        of: find.byType(BestMatchTile),
        matching: find.text(code),
      );
      expect(bestHas(classic.first.newCode), findsOneWidget);

      await scope.dried.add(classic.first.colorId);
      await tester.pumpAndSettle();
      expect(find.text(l10n.matchSubtitle(7)), findsOneWidget);
      expect(bestHas(classic.first.newCode), findsNothing);

      await scope.dried.remove(classic.first.colorId);
      await tester.pumpAndSettle();
      expect(find.text(l10n.matchSubtitle(8)), findsOneWidget);
      expect(bestHas(classic.first.newCode), findsOneWidget);
    });

    testWidgets('Palette does not take them as a base or offer them', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpPalette(
        tester,
        setup: (AppScope s) =>
            s.settings.setCollection(AppSettings(extraMarkerIds: ids)),
      );
      final MarkerColor dry = classic.first;
      await scope.dried.add(dry.colorId);
      await tester.pumpAndSettle();

      await enterBaseCode(tester, dry.newCode);
      expect(find.textContaining('is not in your collection'), findsOneWidget);

      await tester.tap(_key('palette-pick-base'));
      await tester.pumpAndSettle();
      expect(_key('palette-picker-${dry.newCode}'), findsNothing);
      expect(_key('palette-picker-${classic[1].newCode}'), findsOneWidget);
    });

    testWidgets('Ideas works from the markers that are still usable', (
      WidgetTester tester,
    ) async {
      final AppScope scope = AppScope.inMemory(
        markers: _markers(),
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          theme: AppTheme.light(),
          home: Scaffold(body: IdeasPage(today: DateTime(2026, 10, 29))),
        ),
      );
      tester.view.physicalSize = const Size(800, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await scope.settings.setCollection(
        AppSettings(extraMarkerIds: <String>{ids.first, ids.last}),
      );
      await tester.pumpWidget(scope);
      await tester.pumpAndSettle();
      expect(find.text(l10n.ideasHeaderSubtitle), findsOneWidget);

      await scope.dried.add(ids.first);
      await scope.dried.add(ids.last);
      await tester.pumpAndSettle();
      expect(find.text(l10n.ideasNoMarkers), findsOneWidget);

      await scope.dried.remove(ids.first);
      await tester.pumpAndSettle();
      expect(find.text(l10n.ideasHeaderSubtitle), findsOneWidget);
    });
  });
}

List<String> _suggestedIds(WidgetTester tester) => <String>[
  for (final Element e
      in find
          .byWidgetPredicate(
            (Widget w) =>
                w.key is ValueKey<String> &&
                (w.key! as ValueKey<String>).value.startsWith('buy-next-ohuhu'),
          )
          .evaluate())
    (e.widget.key! as ValueKey<String>).value,
];
