import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';

/// The colour families of the DecoTime card (`sets` of
/// `decotime_colors.json`). DecoTime publishes no set contents, so these
/// families are the only grouping the app offers ("add by family").
const List<String> decoTimeFamilyIds = <String>[
  'decotime_base',
  'decotime_warm_grey',
  'decotime_cool_grey',
  'decotime_blue_grey',
  'decotime_green_grey',
];

/// Human labels of the collection concepts.
extension CollectionLabels on AppLocalizations {
  /// What the tips of an Ohuhu series are ("Fine and chisel tips").
  String seriesTips(MarkerLine line) => switch (line) {
    MarkerLine.oahu => collectionSeriesOahuTips,
    MarkerLine.honolulu => collectionSeriesHonoluluTips,
    MarkerLine.kaala => collectionSeriesKaalaTips,
  };

  /// "Colours", "Warm greys"... for a DecoTime family id, or `null`.
  String? decoFamilyLabel(String id) => switch (id) {
    'decotime_base' => collectionFamilyColours,
    'decotime_warm_grey' => collectionFamilyWarmGrey,
    'decotime_cool_grey' => collectionFamilyCoolGrey,
    'decotime_blue_grey' => collectionFamilyBlueGrey,
    'decotime_green_grey' => collectionFamilyGreenGrey,
    _ => null,
  };

  /// Human label of a set or family id of any brand ("Honolulu 48",
  /// "Classic 160", "DecoTime range", "Warm greys"), or `null` for an id the
  /// app does not know: a raw id is never shown.
  String? setLabel(String id) {
    final OahuSet? set = OahuSet.byId[id];
    if (set != null) return packSetFullLabel(set);
    if (id == 'decotime_base') return collectionDecoRange;
    return decoFamilyLabel(id);
  }
}

/// What the user owns of one brand, in numbers: the summary shown in
/// Settings, Swatches and at the end of the first-run setup.
final class CollectionSummary {
  const CollectionSummary({
    required this.brand,
    required this.series,
    required this.setCount,
    required this.markerCount,
  });

  /// Summarises [state]'s collection of its active brand over [colors] (the
  /// catalogue of that brand).
  factory CollectionSummary.of(
    AppSettingsState state,
    List<MarkerColor> colors,
  ) {
    final MarkerBrand brand = state.brand;
    final List<OahuSet> sets = brand == MarkerBrand.ohuhuOahu
        ? <OahuSet>[
            for (final OahuSet set in OahuSet.values)
              if (state.settings.ownedSetIds.contains(set.id)) set,
          ]
        : const <OahuSet>[];
    return CollectionSummary(
      brand: brand,
      series: brand == MarkerBrand.ohuhuOahu
          ? <MarkerLine>[
              for (final MarkerLine line in MarkerLine.values)
                if (state.settings.ownedSeries.contains(line)) line,
            ]
          : const <MarkerLine>[],
      setCount: sets.length,
      markerCount: ownedColors(
        colors: colors,
        brand: brand,
        ownedSetIds: state.settings.ownedSetIds,
        ownedMarkerCodes: state.settings.extraMarkerIds,
      ).length,
    );
  }

  final MarkerBrand brand;

  /// Ohuhu series that hold an owned set, in catalogue order.
  final List<MarkerLine> series;
  final int setCount;
  final int markerCount;

  bool get isEmpty => markerCount == 0;

  /// "Oahu + Honolulu · 3 sets · 214 markers", "40 markers" (DecoTime) or
  /// "Not set up yet".
  String detail(AppLocalizations l10n) {
    if (isEmpty) return l10n.collectionNotSetUp;
    return <String>[
      if (series.isNotEmpty)
        series.map((MarkerLine line) => line.label).join(' + '),
      if (setCount > 0) l10n.collectionSets(setCount),
      l10n.collectionMarkers(markerCount),
    ].join(' · ');
  }

  /// "Ohuhu · Oahu + Honolulu": the brand and, for Ohuhu, the series.
  String headline() => <String>[
    brand.label,
    if (series.isNotEmpty) series.map((MarkerLine l) => l.label).join(' + '),
  ].join(' · ');

  /// "3 sets · 214 markers", or what happens while nothing is chosen yet:
  /// Ohuhu uses the whole range, DecoTime has nothing to show.
  String counts(AppLocalizations l10n) {
    final List<String> parts = <String>[
      if (setCount > 0) l10n.collectionSets(setCount),
      if (markerCount > 0) l10n.collectionMarkers(markerCount),
    ];
    if (parts.isNotEmpty) return parts.join(' · ');
    return brand == MarkerBrand.ohuhuOahu
        ? l10n.collectionSummaryNoSets
        : l10n.collectionSummaryNoMarkers;
  }

  /// "Ohuhu · Oahu + Honolulu · 3 sets · 214 markers".
  String full(AppLocalizations l10n) => '${brand.label} · ${detail(l10n)}';
}
