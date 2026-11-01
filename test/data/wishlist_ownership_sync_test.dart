import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

void main() {
  late StoredAppSettingsRepository settings;
  late StoredWishlistRepository wishlist;
  late WishlistOwnershipSync sync;

  Future<void> start({AppSettings? collection}) async {
    final InMemoryKeyValueStore store = InMemoryKeyValueStore();
    settings = StoredAppSettingsRepository(
      store,
      initial: AppSettingsState(
        onboardingCompleted: true,
        settings: collection ?? AppSettings(ownedSetIds: {'classic_160'}),
      ),
    );
    await settings.load();
    wishlist = StoredWishlistRepository(store);
    await wishlist.load();
    sync = WishlistOwnershipSync(
      settings: settings,
      wishlist: wishlist,
      markers: MarkerRepository(
        loadAsset: (String path) => File(path).readAsStringSync(),
      ),
    )..start();
    await sync.idle;
  }

  tearDown(() async => sync.dispose());

  test(
    'a wished marker leaves the list when it joins the collection',
    () async {
      final List<MarkerColor> all = parseColors(
        File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
        brand: MarkerBrand.ohuhuOahu,
      );
      final MarkerColor outside = all.firstWhere(
        (MarkerColor c) => !c.sets.contains('classic_160'),
      );
      final MarkerColor inside = all.firstWhere(
        (MarkerColor c) => c.sets.contains('classic_160'),
      );
      await start();

      await wishlist.add(outside.colorId);
      await sync.idle;
      expect(wishlist.ids, contains(outside.colorId));

      // Getting it as a loose marker takes it off the list.
      await settings.setExtraMarkerIds({outside.colorId});
      await sync.idle;
      expect(wishlist.ids, isNot(contains(outside.colorId)));

      // An owned marker can still be wished (a refill) and stays.
      await wishlist.add(inside.colorId);
      await sync.idle;
      await settings.setUseOwnColors(false);
      await settings.setFavorites({'ohuhu_oahu:X1'});
      await sync.idle;
      expect(wishlist.ids, contains(inside.colorId));
    },
  );

  test('ticking a whole set takes all its wished markers off', () async {
    final List<MarkerColor> all = parseColors(
      File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
      brand: MarkerBrand.ohuhuOahu,
    );
    final List<MarkerColor> honolulu = all
        .where(
          (MarkerColor c) =>
              c.sets.contains('honolulu_24') && !c.sets.contains('classic_160'),
        )
        .toList();
    expect(honolulu.length, greaterThan(1));
    await start();
    for (final MarkerColor c in honolulu) {
      await wishlist.add(c.colorId);
    }
    await wishlist.add('decotime:01');
    await sync.idle;
    expect(wishlist.ids.length, honolulu.length + 1);

    await settings.setOwnedSetIds({'classic_160', 'honolulu_24'});
    await sync.idle;
    // Only the other brand's wish is left.
    expect(wishlist.ids, {'decotime:01'});
  });

  test('a marker already owned when it is wished stays on the list', () async {
    await start();
    await wishlist.add('ohuhu_oahu:B08');
    await sync.idle;
    // Unrelated collection change: B08 was owned before, so it is not
    // "newly" owned.
    await settings.setExtraMarkerIds({'ohuhu_oahu:BV04'});
    await sync.idle;
    expect(wishlist.ids, contains('ohuhu_oahu:B08'));
  });

  test('other brands are tracked on their own', () async {
    await start();
    await wishlist.add('decotime:01');
    await sync.idle;
    await settings.setExtraMarkerIds({'decotime:01'});
    await sync.idle;
    expect(wishlist.ids, isEmpty);
  });

  test('dispose stops listening', () async {
    await start();
    await wishlist.add('decotime:01');
    await sync.idle;
    await sync.dispose();
    await settings.setExtraMarkerIds({'decotime:01'});
    await Future<void>.delayed(Duration.zero);
    expect(wishlist.ids, {'decotime:01'});
  });
}
