import 'dart:async';
import 'dart:convert';

import 'json_value.dart';
import 'models.dart';
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
        oldCode: code,
        oldName: name.isEmpty ? code : name,
        hex: hex.isEmpty ? 'cfcfcf' : hex,
        sets: jsonDefault<List<dynamic>>(item, 'sets', const []).cast<String>(),
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

  Future<List<MarkerColor>> loadColors(MarkerBrand brand) =>
      _cache.putIfAbsent(brand, () => _load(brand));

  Future<List<MarkerColor>> _load(MarkerBrand brand) async {
    try {
      return parseColors(
        await Future<String>.sync(() => loadAsset(brand.assetPath)),
        brand: brand,
      );
    } catch (_) {
      _cache.remove(brand);
      rethrow;
    }
  }
}
