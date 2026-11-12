import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';

/// The user's whole collection across every brand, read once for a tools page.
///
/// The colours come from `MarkerRepository.loadColors`, so the user's own
/// colours already replace the catalogue's. A brand whose catalogue cannot be
/// read counts as empty: the pages still work with the others.
final class CollectionSnapshot {
  const CollectionSnapshot({
    required this.catalogues,
    required this.owned,
    required this.driedIds,
    required this.activeBrand,
  });

  /// Reads the catalogue of every brand and the collection of the user.
  ///
  /// With [respectScope] the collection is the one Palette and Ideas work
  /// with: the markers of the active brand, or of every brand the user owns
  /// when "Mix my brands" is on (and there are two brands to mix).
  static Future<CollectionSnapshot> load(
    AppScope scope, {
    bool respectScope = false,
  }) async {
    final AppSettings settings = scope.settings.settings;
    final Map<MarkerBrand, List<MarkerColor>> catalogues =
        <MarkerBrand, List<MarkerColor>>{};
    final List<MarkerColor> owned = <MarkerColor>[];
    for (final MarkerBrand brand in MarkerBrand.values) {
      List<MarkerColor> colors;
      try {
        colors = await scope.markers.loadColors(brand);
      } catch (_) {
        colors = const <MarkerColor>[];
      }
      catalogues[brand] = colors;
      owned.addAll(
        ownedColors(
          colors: colors,
          brand: brand,
          ownedSetIds: settings.effectiveSetIds(),
          ownedMarkerCodes: settings.ownedMarkerCodes,
        ),
      );
    }
    if (respectScope) {
      final selected = paletteCandidateColors(
        colors: owned,
        brand: scope.settings.brand,
        scope: scope.settings.scope,
        activeSetIds: settings.effectiveSetIds(),
        ownedMarkerCodes: settings.ownedMarkerCodes,
        driedColorIds: scope.dried.ids,
      );
      if (!hasMixedBrands(selected)) {
        owned.removeWhere(
          (MarkerColor c) => c.brandId != scope.settings.brand.id,
        );
      }
    }
    return CollectionSnapshot(
      catalogues: catalogues,
      owned: owned,
      driedIds: Set<String>.of(scope.dried.ids),
      activeBrand: scope.settings.brand,
    );
  }

  /// Every brand's colours.
  final Map<MarkerBrand, List<MarkerColor>> catalogues;

  /// Every marker the user owns, in every brand (dried-out ones included).
  final List<MarkerColor> owned;

  /// The `brandId:CODE` ids of the owned markers that ran dry.
  final Set<String> driedIds;

  /// The brand chosen in Settings.
  final MarkerBrand activeBrand;

  /// The owned markers that still have ink: what Match, Palette and Ideas
  /// offer, and what the tools suggest.
  List<MarkerColor> get usable => <MarkerColor>[
    for (final MarkerColor c in owned)
      if (!driedIds.contains(c.colorId)) c,
  ];

  /// The ids of every owned marker.
  Set<String> get ownedIds => <String>{
    for (final MarkerColor c in owned) c.colorId,
  };

  /// The brands the user owns at least one marker of, in the app's order.
  List<MarkerBrand> get ownedBrands => <MarkerBrand>[
    for (final MarkerBrand brand in MarkerBrand.values)
      if (owned.any((MarkerColor c) => c.brandId == brand.id)) brand,
  ];

  /// How many markers of each brand in [ownedBrands] the user owns.
  Map<MarkerBrand, int> get ownedCounts => <MarkerBrand, int>{
    for (final MarkerBrand brand in ownedBrands)
      brand: owned.where((MarkerColor c) => c.brandId == brand.id).length,
  };

  /// The whole range of [brand].
  List<MarkerColor> rangeOf(MarkerBrand brand) =>
      catalogues[brand] ?? const <MarkerColor>[];
}
