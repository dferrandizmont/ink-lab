import 'model/artwork_entry.dart';
import 'model/marker_color.dart';

// The numbers of the artwork diary: what the user painted, when, with which
// markers and with which palettes.
//
// Pure functions over lists: the diary entries and the user's collection go
// in, the numbers come out. Nothing here reads storage or knows about the
// repository.

// One month of the diary.
final class DiaryMonth {
  const DiaryMonth({
    required this.year,
    required this.month,
    required this.entries,
    required this.finished,
    required this.inProgress,
  });

  /// The year of the month.
  final int year;

  /// The month of the year, 1 to 12.
  final int month;

  /// How many entries the month has.
  final int entries;

  /// How many of them are finished.
  final int finished;

  /// How many of them are still in progress.
  final int inProgress;

  /// `yyyy-MM`, the way the month is written in a key.
  String get key =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}';
}

/// A marker and how many entries used it.
final class DiaryMarkerUsage {
  const DiaryMarkerUsage({required this.colorId, required this.count});

  /// The brand-scoped id of the marker (`brandId:CODE`).
  final String colorId;

  /// How many entries used it.
  final int count;
}

/// A saved palette and how many entries link to it.
final class DiaryPaletteUsage {
  const DiaryPaletteUsage({required this.paletteId, required this.count});

  /// The id of the saved palette.
  final String paletteId;

  /// How many entries link to it.
  final int count;
}

/// Everything the diary says about the user's practice.
final class DiaryStats {
  const DiaryStats({
    required this.totalEntries,
    required this.finished,
    required this.inProgress,
    required this.months,
    required this.mostUsedMarkers,
    required this.unusedOwnedMarkers,
    required this.mostLinkedPalettes,
  });

  /// How many entries the diary has.
  final int totalEntries;

  /// How many of them are finished.
  final int finished;

  /// How many of them are still in progress.
  final int inProgress;

  /// The months that have entries, oldest first.
  final List<DiaryMonth> months;

  /// The markers used most often, most used first.
  final List<DiaryMarkerUsage> mostUsedMarkers;

  /// The markers of the collection that no entry has used yet.
  final List<MarkerColor> unusedOwnedMarkers;

  /// The saved palettes linked most often, most linked first.
  final List<DiaryPaletteUsage> mostLinkedPalettes;

  /// The month with the most entries, or `null` when the diary is empty.
  DiaryMonth? get busiestMonth {
    DiaryMonth? best;
    for (final DiaryMonth month in months) {
      if (best == null || month.entries > best.entries) best = month;
    }
    return best;
  }
}

/// The numbers of the diary entries.
///
/// [entries] are the artwork diary entries and [ownedMarkers] the markers
/// of the user's collection. A marker of the collection that no entry used
/// is reported in [DiaryStats.unusedOwnedMarkers].
///
/// The months come oldest first, the markers and the palettes most used
/// first. A marker or a palette id that no entry mentions is never reported.
DiaryStats computeDiaryStats({
  required List<ArtworkEntry> entries,
  List<MarkerColor> ownedMarkers = const [],
}) {
  final Map<String, int> markerCounts = <String, int>{};
  final Map<String, int> paletteCounts = <String, int>{};
  final Map<String, DiaryMonth> months = <String, DiaryMonth>{};
  int finished = 0;
  int inProgress = 0;

  for (final ArtworkEntry entry in entries) {
    if (entry.status == ArtworkStatus.finished) {
      finished++;
    } else {
      inProgress++;
    }
    final String key = _monthKey(entry.date);
    final DiaryMonth? month = months[key];
    months[key] = DiaryMonth(
      year: entry.date.year,
      month: entry.date.month,
      entries: (month?.entries ?? 0) + 1,
      finished: (month?.finished ?? 0) +
          (entry.status == ArtworkStatus.finished ? 1 : 0),
      inProgress: (month?.inProgress ?? 0) +
          (entry.status == ArtworkStatus.inProgress ? 1 : 0),
    );
    for (final String markerId in entry.markerIds) {
      markerCounts[markerId] = (markerCounts[markerId] ?? 0) + 1;
    }
    final String? paletteId = entry.paletteId;
    if (paletteId != null && paletteId.isNotEmpty) {
      paletteCounts[paletteId] = (paletteCounts[paletteId] ?? 0) + 1;
    }
  }

  final List<DiaryMonth> sortedMonths = months.values.toList()
    ..sort((DiaryMonth a, DiaryMonth b) {
      final int byYear = a.year.compareTo(b.year);
      return byYear != 0 ? byYear : a.month.compareTo(b.month);
    });

  final List<DiaryMarkerUsage> usedMarkers = _ranked(
    markerCounts,
    (String id, int count) => DiaryMarkerUsage(colorId: id, count: count),
  );
  final List<DiaryPaletteUsage> usedPalettes = _ranked(
    paletteCounts,
    (String id, int count) => DiaryPaletteUsage(paletteId: id, count: count),
  );

  final Set<String> usedIds = markerCounts.keys.toSet();
  final List<MarkerColor> unused = <MarkerColor>[
    for (final MarkerColor color in ownedMarkers)
      if (!usedIds.contains(color.colorId)) color,
  ];

  return DiaryStats(
    totalEntries: entries.length,
    finished: finished,
    inProgress: inProgress,
    months: List<DiaryMonth>.unmodifiable(sortedMonths),
    mostUsedMarkers: List<DiaryMarkerUsage>.unmodifiable(usedMarkers),
    unusedOwnedMarkers: List<MarkerColor>.unmodifiable(unused),
    mostLinkedPalettes: List<DiaryPaletteUsage>.unmodifiable(usedPalettes),
  );
}

/// The most used markers and palettes: the count first, then the id, so the
/// order never depends on the order the entries came in.
List<T> _ranked<T>(Map<String, int> counts, T Function(String, int) build) {
  final List<MapEntry<String, int>> sorted = counts.entries.toList()
    ..sort((MapEntry<String, int> a, MapEntry<String, int> b) {
      final int byCount = b.value.compareTo(a.value);
      return byCount != 0 ? byCount : a.key.compareTo(b.key);
    });
  return <T>[
    for (final MapEntry<String, int> entry in sorted)
      build(entry.key, entry.value),
  ];
}

/// `yyyy-MM` of [date].
String _monthKey(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}';
