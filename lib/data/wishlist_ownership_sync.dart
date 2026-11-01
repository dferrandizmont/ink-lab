import 'dart:async';

import '../core/collection_selection.dart';
import '../core/marker_repository.dart';
import '../core/models.dart';
import 'app_settings_repository.dart';
import 'color_id_set_repository.dart';

/// Takes a marker off the wishlist the moment the user gets it: when a marker
/// becomes part of the collection (a set was ticked, a loose marker added) it
/// is no longer something to buy.
///
/// Only the step from "not owned" to "owned" removes a marker. A marker that
/// is already owned can sit on the wishlist (a refill for one that dried
/// out) and stays there. The collection is read through
/// [ownedColors], the one rule behind every screen.
///
/// Create it once next to the repositories and call [start]; it lives as long
/// as the subscriptions do.
final class WishlistOwnershipSync {
  WishlistOwnershipSync({
    required this.settings,
    required this.wishlist,
    required this.markers,
  });

  final AppSettingsRepository settings;
  final WishlistRepository wishlist;
  final MarkerRepository markers;

  StreamSubscription<Object?>? _settingsSub;
  StreamSubscription<Object?>? _wishlistSub;

  /// The owned ids of each brand the last time the wishlist had one of its
  /// markers.
  final Map<String, Set<String>> _owned = <String, Set<String>>{};

  bool _collectionChanged = false;
  bool _running = false;
  bool _again = false;

  /// Starts listening. Safe to call once.
  void start() {
    _settingsSub ??= settings.settingsChanges.listen((_) {
      _collectionChanged = true;
      _kick();
    });
    _wishlistSub ??= wishlist.changes.listen((_) => _kick());
  }

  /// Stops listening.
  Future<void> dispose() async {
    await _settingsSub?.cancel();
    await _wishlistSub?.cancel();
    _settingsSub = null;
    _wishlistSub = null;
  }

  /// Resolves when the changes delivered so far have been dealt with. For
  /// tests.
  Future<void> get idle async {
    await Future<void>.delayed(Duration.zero);
    while (_running) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  void _kick() {
    if (_running) {
      _again = true;
      return;
    }
    _running = true;
    unawaited(_loop());
  }

  Future<void> _loop() async {
    try {
      do {
        _again = false;
        final bool apply = _collectionChanged;
        _collectionChanged = false;
        await _pass(apply);
      } while (_again);
    } catch (_) {
      // A catalogue that cannot load leaves the wishlist as it is.
    } finally {
      _running = false;
    }
  }

  Future<void> _pass(bool apply) async {
    final Set<String> wished = wishlist.ids;
    final AppSettings collection = settings.settings;
    for (final MarkerBrand brand in MarkerBrand.values) {
      final Set<String> mine = wishlist.idsOf(brand);
      if (mine.isEmpty) {
        _owned.remove(brand.id);
        continue;
      }
      final List<MarkerColor> catalogue = await markers.loadColors(brand);
      final Set<String> owned = <String>{
        for (final MarkerColor c in ownedColors(
          colors: catalogue,
          brand: brand,
          ownedSetIds: collection.ownedSetIds,
          ownedMarkerCodes: collection.extraMarkerIds,
        ))
          c.colorId,
      };
      final Set<String>? before = _owned[brand.id];
      _owned[brand.id] = owned;
      if (!apply || before == null) continue;
      for (final String id in owned.difference(before)) {
        if (wished.contains(id)) await wishlist.remove(id);
      }
    }
  }
}
