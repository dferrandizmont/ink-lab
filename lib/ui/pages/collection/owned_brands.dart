import 'package:flutter/foundation.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import 'collection_summary.dart';

/// What the user owns of one brand, for the brand list: how many markers,
/// out of how many in the range, and (Ohuhu) how many sets.
///
/// Dried-out markers still count: they stay in the collection, as in every
/// other count of the app.
@immutable
final class OwnedBrandCount {
  const OwnedBrandCount({
    required this.brand,
    required this.markerCount,
    required this.rangeCount,
    this.setCount = 0,
  });

  final MarkerBrand brand;

  /// The markers of the brand the user owns (at least one).
  final int markerCount;

  /// The colours of the whole range of the brand.
  final int rangeCount;

  /// The owned retail sets (only brands with retail sets, i.e. Ohuhu).
  final int setCount;

  /// The second line of the brand's row: "1 set · 161 markers" for a brand
  /// collected by sets (the summary of the collection page), "284 of 313
  /// owned" for a brand collected marker by marker.
  String line(AppLocalizations l10n) => brand.hasRetailSets
      ? CollectionSummary(
          brand: brand,
          series: const <MarkerLine>[],
          setCount: setCount,
          markerCount: markerCount,
        ).counts(l10n)
      : l10n.brandOwnedLine(markerCount, rangeCount);
}

/// The brands the user owns at least one marker of, with their counts.
///
/// Only the brands that have something stored are read, so counting stays
/// cheap; a brand whose catalogue cannot be read is left out, like in
/// `CollectionSnapshot`. Read it before the brand list is shown: the rows do
/// not change once they are on screen.
Future<Map<MarkerBrand, OwnedBrandCount>> loadOwnedBrands(
  AppScope scope,
) async {
  final AppSettings settings = scope.settings.settings;
  final Map<MarkerBrand, OwnedBrandCount> owned =
      <MarkerBrand, OwnedBrandCount>{};
  final List<MarkerBrand> candidates = <MarkerBrand>[
    for (final MarkerBrand brand in MarkerBrand.values)
      if (scopedCodesForBrand(settings.ownedMarkerCodes, brand.id).isNotEmpty ||
          (brand.hasRetailSets && settings.effectiveSetIds().isNotEmpty))
        brand,
  ];
  await Future.wait(<Future<void>>[
    for (final MarkerBrand brand in candidates)
      () async {
        final List<MarkerColor> colors;
        try {
          colors = await scope.markers.loadColors(brand);
        } catch (_) {
          return;
        }
        final int markers = ownedColors(
          colors: colors,
          brand: brand,
          ownedSetIds: settings.effectiveSetIds(),
          ownedMarkerCodes: settings.ownedMarkerCodes,
        ).length;
        if (markers == 0) return;
        owned[brand] = OwnedBrandCount(
          brand: brand,
          markerCount: markers,
          rangeCount: brandRangeColors(colors: colors, brand: brand).length,
          setCount: brand.hasRetailSets
              ? OahuSet.values
                    .where(
                      (OahuSet set) =>
                          settings.effectiveSetIds().contains(set.id),
                    )
                    .length
              : 0,
        );
      }(),
  ]);
  return owned;
}
