import 'dart:async';
import 'dart:convert';

import 'json_value.dart';
import 'collection_selection.dart';
import 'models.dart';
import 'own_colors.dart';
import 'scene_catalog.dart';
import 'swatch_card_location.dart';

/// The required brand chooses the catalog format and overrides stored brand IDs.
List<MarkerColor> parseColors(String json, {required MarkerBrand brand}) {
  final payload = jsonDecode(json) as List;
  return List.unmodifiable(
    payload.map((value) {
      final item = value as Map<String, dynamic>;
      if (brand == MarkerBrand.ohuhuOahu) {
        final color = MarkerColor.fromJson(item).copyWith(brandId: brand.id);
        // Catalogs written before product lines existed only held Oahu.
        return color.lines.isEmpty
            ? color.copyWith(lines: [MarkerLine.oahu.id])
            : color;
      }
      final code = (item['code'] as String).trim().toUpperCase();
      final name = (item['name'] as String).trim();
      var hex = (item['hex'] as String).trim();
      if (hex.startsWith('#')) hex = hex.substring(1);
      hex = hex.toLowerCase();
      return MarkerColor(
        brandId: brand.id,
        newCode: code,
        newName: name.isEmpty ? code : name,
        // Prismacolor's PB codes are aliases of its primary PM codes, using
        // the same alternative-code field as Ohuhu's historical codes.
        oldCode: jsonDefault<String>(
          item,
          'oldCode',
          code,
        ).trim().toUpperCase(),
        oldName: name.isEmpty ? code : name,
        hex: hex.isEmpty ? 'cfcfcf' : hex,
        sets: jsonDefault<List<dynamic>>(item, 'sets', const []).cast<String>(),
        lines: jsonDefault<List<dynamic>>(
          item,
          'lines',
          const [],
        ).cast<String>(),
      );
    }),
  );
}

/// Inject `rootBundle.loadString` from the Flutter layer, or a disk reader in
/// tests. No Flutter dependency is required by this module.
typedef AssetTextLoader = FutureOr<String> Function(String path);

final class MarkerRepository {
  MarkerRepository({required this.loadAsset});
  final AssetTextLoader loadAsset;
  final _cache = <MarkerBrand, Future<List<MarkerColor>>>{};
  Future<Map<String, Map<String, int>>>? _cardLocations;

  /// Asset that maps each Oahu pack's marker codes to their swatch card.
  static const cardLocationsAssetPath = 'assets/data/oahu_card_locations.json';

  /// Swatch card catalogue (`setId -> code -> card`), loaded once.
  ///
  /// The data is optional: if the asset is missing or malformed the result is
  /// empty and no location is shown.
  Future<Map<String, Map<String, int>>> loadCardLocations() =>
      _cardLocations ??= _loadCardLocations();

  Future<Map<String, Map<String, int>>> _loadCardLocations() async {
    try {
      final raw = await Future<String>.sync(
        () => loadAsset(cardLocationsAssetPath),
      );
      return decodeSwatchCardLocationCatalog(raw);
    } catch (_) {
      return const {};
    }
  }

  Future<SceneCatalog>? _scenes;

  /// The drawing scenes (scenes.json), loaded once and installed
  /// as the catalogue that [Scene.fromJson] resolves ids against.
  Future<SceneCatalog> loadScenes() => _scenes ??= _loadScenes();

  Future<SceneCatalog> _loadScenes() async {
    try {
      final catalog = SceneCatalog.parse(
        await Future<String>.sync(() => loadAsset(SceneCatalog.assetPath)),
      );
      SceneCatalog.install(catalog);
      return catalog;
    } catch (_) {
      _scenes = null;
      rethrow;
    }
  }

  /// Where the user's own colours come from, if the app has them.
  ///
  /// The composition root sets it once. With it, [loadColors] is the single
  /// point where own colours replace the catalogue ones, so every screen
  /// (Match, Palette, Ideas, Swatches) sees the same effective colours.
  OwnColorSource? get ownColors => _ownColors;
  set ownColors(OwnColorSource? source) {
    _ownColors = source;
    _effectiveFutures.clear();
    _effectiveValues.clear();
  }

  OwnColorSource? _ownColors;

  /// Changes whenever the colours [loadColors] returns would change.
  int get colorRevision => ownColors?.revision ?? 0;

  final _loaded = <MarkerBrand, List<MarkerColor>>{};
  final _effectiveFutures =
      <MarkerBrand, ({int revision, Future<List<MarkerColor>> future})>{};
  final _effectiveValues =
      <MarkerBrand, ({int revision, List<MarkerColor> value})>{};

  /// The colours of [brand]: the catalogue's, with the user's own colours
  /// in place of the ones they set (see [ownColors]).
  ///
  /// The same future comes back until the own colours change, so a
  /// `FutureBuilder` does not restart on every rebuild.
  Future<List<MarkerColor>> loadColors(MarkerBrand brand) {
    final Future<List<MarkerColor>> catalogue = _cache.putIfAbsent(
      brand,
      () => _load(brand),
    );
    final OwnColorSource? source = ownColors;
    final Map<String, String> own = source?.activeOwnColors ?? const {};
    if (source == null || own.isEmpty) return catalogue;
    final int revision = source.revision;
    final cached = _effectiveFutures[brand];
    if (cached != null && cached.revision == revision) return cached.future;
    final Future<List<MarkerColor>> future = catalogue.then(
      (List<MarkerColor> all) => _applied(brand, revision, all, own),
    );
    _effectiveFutures[brand] = (revision: revision, future: future);
    return future;
  }

  /// The colours of [brand] and, with [BrandScope.mixedBrands] ("Mix my
  /// brands") or [allOwnedBrands], of every other brand the user owns a
  /// marker of: what `paletteCandidateColors` chooses from. [brand] comes
  /// first. With the single scope it is the catalogue of [brand] alone.
  ///
  /// Each brand is read through [loadColors] (the same cache, the user's own
  /// colours applied); a brand that cannot be read adds nothing.
  Future<List<MarkerColor>> loadCollectionCatalog({
    required MarkerBrand brand,
    required AppSettings settings,
    bool allOwnedBrands = false,
    BrandScope scope = BrandScope.singleBrand,
  }) async {
    final brands = <MarkerBrand>{brand};
    if (allOwnedBrands || scope == BrandScope.mixedBrands) {
      for (final b in MarkerBrand.values) {
        if ((b.hasRetailSets && settings.effectiveSetIds().isNotEmpty) ||
            scopedCodesForBrand(settings.ownedMarkerCodes, b.id).isNotEmpty) {
          brands.add(b);
        }
      }
    }
    return <MarkerColor>[
      for (final colors in await Future.wait(
        brands.map((b) async {
          try {
            return await loadColors(b);
          } catch (_) {
            return <MarkerColor>[];
          }
        }),
      ))
        ...colors,
    ];
  }

  /// The colours of [brand] when they are already in memory, else `null`.
  ///
  /// Same colours as [loadColors], without waiting: a screen can start from
  /// them instead of blinking when an own colour is saved.
  List<MarkerColor>? peekColors(MarkerBrand brand) {
    final List<MarkerColor>? all = _loaded[brand];
    final OwnColorSource? source = ownColors;
    final Map<String, String> own = source?.activeOwnColors ?? const {};
    if (all == null || source == null || own.isEmpty) return all;
    return _applied(brand, source.revision, all, own);
  }

  List<MarkerColor> _applied(
    MarkerBrand brand,
    int revision,
    List<MarkerColor> all,
    Map<String, String> own,
  ) {
    final cached = _effectiveValues[brand];
    if (cached != null && cached.revision == revision) return cached.value;
    final List<MarkerColor> value = applyOwnColors(all, own);
    _effectiveValues[brand] = (revision: revision, value: value);
    return value;
  }

  Future<List<MarkerColor>> _load(MarkerBrand brand) async {
    try {
      final List<MarkerColor> parsed = parseColors(
        await Future<String>.sync(() => loadAsset(brand.assetPath)),
        brand: brand,
      );
      _loaded[brand] = parsed;
      return parsed;
    } catch (_) {
      // The cache holds the future, so removing it hands back the failed
      // future; nobody waits on it because the caller already got the error.
      unawaited(_cache.remove(brand));
      rethrow;
    }
  }
}
