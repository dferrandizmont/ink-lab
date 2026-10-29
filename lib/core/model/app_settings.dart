import 'marker_line.dart';
import 'oahu_set.dart';

/// The user's collection: the ONE definition of "my markers".
///
/// Owned markers = the colours of the Ohuhu sets the user owns
/// ([ownedSetIds]) + the single markers the user added by hand
/// ([extraMarkerIds], brand-scoped `brandId:CODE`, any brand). DecoTime
/// publishes no set membership, so a DecoTime collection is made of extra
/// markers only. Every screen (Swatches "Mine", Match, Palette, Ideas, the
/// counts) reads the collection through `collection_selection.dart`.
final class AppSettings {
  AppSettings({
    Set<String> ownedSetIds = const {},
    Set<String> extraMarkerIds = const {},
    Set<String> chosenSeriesIds = const {},
  }) : ownedSetIds = Set.unmodifiable(ownedSetIds),
       extraMarkerIds = Set.unmodifiable(extraMarkerIds),
       chosenSeriesIds = Set.unmodifiable(chosenSeriesIds);

  /// Migrates the settings of app versions before the collection model.
  ///
  /// Old versions stored "selected packs" (core packs, of which only the
  /// first counted in single-pack mode, plus add-on packs) and a separate
  /// "owned markers" tick list. The packs the user was shown become the sets
  /// they own and the ticked markers become extra markers.
  /// [selectedCoreSetIds] is `null` when the old key was never written
  /// (nothing configured): no set is assumed to be owned then.
  factory AppSettings.fromLegacy({
    bool singlePackMode = true,
    Set<String>? selectedCoreSetIds,
    Set<String> selectedAddonSetIds = const {},
    Set<String> ownedMarkerCodes = const {},
  }) {
    final Set<String> sets;
    if (selectedCoreSetIds == null) {
      sets = {...selectedAddonSetIds};
    } else {
      final sortedCore = selectedCoreSetIds.toList()..sort();
      final core = singlePackMode ? sortedCore.take(1) : sortedCore;
      final combined = {...core, ...selectedAddonSetIds};
      // An empty selection used to fall back to Oahu 160: that is what the
      // user saw, so that is what they keep.
      sets = combined.isEmpty ? {OahuSet.classic160.id} : combined;
    }
    return AppSettings(
      ownedSetIds: sets,
      extraMarkerIds: {
        for (final raw in ownedMarkerCodes)
          if (raw.trim().isNotEmpty) raw.trim(),
      },
    );
  }

  /// Ids of the Ohuhu sets the user owns (`classic_160`, `honolulu_120`...).
  final Set<String> ownedSetIds;

  /// Single markers added by hand, brand-scoped (`decotime:01`).
  final Set<String> extraMarkerIds;

  /// Ids of the Ohuhu series (`oahu`, `honolulu`, `kaala`) the user said
  /// they have. Stored apart from the sets so that a series survives when no
  /// set has been picked yet.
  final Set<String> chosenSeriesIds;

  /// The series the user has: the chosen ones plus any series that holds an
  /// owned set (older data never stored the series on its own).
  Set<MarkerLine> get ownedSeries => <MarkerLine>{
    for (final String id in chosenSeriesIds) ?MarkerLine.fromId(id),
    for (final String id in ownedSetIds) ?OahuSet.byId[id]?.line,
  };

  /// Name kept for the palette engines: the extra markers.
  Set<String> get ownedMarkerCodes => extraMarkerIds;

  /// Name kept for the palette engines: the owned sets.
  Set<String> effectiveSetIds() => ownedSetIds;

  AppSettings copyWith({
    Set<String>? ownedSetIds,
    Set<String>? extraMarkerIds,
    Set<String>? chosenSeriesIds,
  }) => AppSettings(
    ownedSetIds: ownedSetIds ?? this.ownedSetIds,
    extraMarkerIds: extraMarkerIds ?? this.extraMarkerIds,
    chosenSeriesIds: chosenSeriesIds ?? this.chosenSeriesIds,
  );
}
