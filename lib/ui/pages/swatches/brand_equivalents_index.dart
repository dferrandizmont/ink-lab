import '../../../core/brand_equivalents.dart';
import '../../../core/collection_selection.dart';
import '../../../core/marker_repository.dart';
import '../../../core/models.dart';

/// Every brand's colours with their Lab values, ready to answer "what is the
/// same colour in another brand?" for any marker.
///
/// The catalogues come from [MarkerRepository.loadColors], so the user's own
/// colours already replace the catalogue's. Build it once and keep it for as
/// long as [MarkerRepository.colorRevision] does not change; asking is one
/// distance per marker of every other brand.
final class BrandEquivalentsIndex {
  BrandEquivalentsIndex._(this._finder, this._byBrand);

  /// Reads the catalogue of every brand and prepares the finder.
  static Future<BrandEquivalentsIndex> load(MarkerRepository markers) async {
    final List<List<MarkerColor>> lists = await Future.wait(
      <Future<List<MarkerColor>>>[
        for (final MarkerBrand brand in MarkerBrand.values)
          markers.loadColors(brand),
      ],
    );
    final Map<MarkerBrand, List<MarkerColor>> byBrand =
        <MarkerBrand, List<MarkerColor>>{
          for (int i = 0; i < MarkerBrand.values.length; i++)
            MarkerBrand.values[i]: lists[i],
        };
    return BrandEquivalentsIndex._(
      BrandEquivalentFinder(<MarkerColor>[for (final l in lists) ...l]),
      byBrand,
    );
  }

  final BrandEquivalentFinder _finder;
  final Map<MarkerBrand, List<MarkerColor>> _byBrand;

  /// The ids of the markers of every brand the user owns.
  Set<String> ownedIds(AppSettings settings) => <String>{
    for (final MapEntry<MarkerBrand, List<MarkerColor>> entry
        in _byBrand.entries)
      for (final MarkerColor color in ownedColors(
        colors: entry.value,
        brand: entry.key,
        ownedSetIds: settings.ownedSetIds,
        ownedMarkerCodes: settings.extraMarkerIds,
      ))
        color.colorId,
  };

  /// The closest markers of the other brands to [marker], [limit] per brand.
  ///
  /// With [onlyMine] only the markers the user owns compete, and the ones
  /// that ran dry ([driedIds]) are left out.
  List<BrandEquivalentGroup> closestTo(
    MarkerColor marker, {
    required AppSettings settings,
    required Set<String> driedIds,
    bool onlyMine = false,
    int limit = 3,
  }) => _finder.closestTo(
    marker,
    limit: limit,
    ownedIds: onlyMine ? ownedIds(settings) : null,
    skipDried: onlyMine,
    driedIds: driedIds,
  );
}
