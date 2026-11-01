import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/diary_stats.dart';
import 'package:ink_lab/core/models.dart';

import 'fixtures.dart';

ArtworkEntry entry({
  String id = 'e1',
  DateTime? date,
  ArtworkStatus status = ArtworkStatus.finished,
  List<String> markers = const <String>[],
  String? paletteId,
}) => ArtworkEntry(
  id: id,
  title: 'Entry $id',
  date: date ?? DateTime(2026, 10, 30),
  status: status,
  markerIds: markers,
  paletteId: paletteId,
  createdAtEpochMs: 0,
);

void main() {
  group('computeDiaryStats', () {
    test('an empty diary has no numbers', () {
      final stats = computeDiaryStats(entries: const <ArtworkEntry>[]);
      expect(stats.totalEntries, 0);
      expect(stats.finished, 0);
      expect(stats.inProgress, 0);
      expect(stats.months, isEmpty);
      expect(stats.mostUsedMarkers, isEmpty);
      expect(stats.mostLinkedPalettes, isEmpty);
      expect(stats.unusedOwnedMarkers, isEmpty);
      expect(stats.busiestMonth, isNull);
    });

    test('the months come oldest first, with their counts', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[
          entry(id: 'a', date: DateTime(2026, 10, 2)),
          entry(id: 'b', date: DateTime(2026, 8, 30)),
          entry(id: 'c', date: DateTime(2026, 9, 1)),
          entry(id: 'd', date: DateTime(2026, 8, 31)),
        ],
      );
      expect(
        stats.months.map((DiaryMonth m) => m.key),
        ['2026-08', '2026-09', '2026-10'],
      );
      expect(stats.months.first.entries, 2);
      expect(stats.months.first.year, 2026);
      expect(stats.months.first.month, 8);
      expect(stats.months.last.entries, 1);
      expect(stats.totalEntries, 4);
    });

    test('finished and in progress are counted, per month and in total', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[
          entry(id: 'a', date: DateTime(2026, 10, 1)),
          entry(
            id: 'b',
            date: DateTime(2026, 10, 2),
            status: ArtworkStatus.inProgress,
          ),
          entry(
            id: 'c',
            date: DateTime(2026, 11, 1),
            status: ArtworkStatus.inProgress,
          ),
        ],
      );
      expect(stats.finished, 1);
      expect(stats.inProgress, 2);
      expect(stats.months.first.finished, 1);
      expect(stats.months.first.inProgress, 1);
      expect(stats.months.last.finished, 0);
      expect(stats.months.last.inProgress, 1);
    });

    test('the most used markers come first, and the ties are broken', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[
          entry(id: 'a', markers: const <String>['ohuhu_oahu:B08']),
          entry(id: 'b', markers: const <String>['ohuhu_oahu:B08']),
          entry(id: 'c', markers: const <String>['ohuhu_oahu:R1']),
          entry(id: 'd', markers: const <String>['copic:BV04']),
          entry(id: 'e', markers: const <String>['copic:BV04']),
        ],
      );
      expect(
        stats.mostUsedMarkers.map((DiaryMarkerUsage m) => m.colorId),
        ['copic:BV04', 'ohuhu_oahu:B08', 'ohuhu_oahu:R1'],
      );
      expect(stats.mostUsedMarkers.first.count, 2);
      expect(stats.mostUsedMarkers.last.count, 1);
    });

    test('the markers of the collection that no entry used are reported', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[
          entry(id: 'a', markers: const <String>['ohuhu_oahu:B08']),
        ],
        ownedMarkers: <MarkerColor>[
          color('B08', '123456'),
          color('R1', 'ff0000'),
          color('G1', '00ff00'),
        ],
      );
      expect(
        stats.unusedOwnedMarkers.map((MarkerColor c) => c.colorId),
        ['ohuhu_oahu:R1', 'ohuhu_oahu:G1'],
      );
    });

    test('the most linked palettes come first', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[
          entry(id: 'a', paletteId: 'p1'),
          entry(id: 'b', paletteId: 'p2'),
          entry(id: 'c', paletteId: 'p1'),
        ],
      );
      expect(
        stats.mostLinkedPalettes.map((DiaryPaletteUsage p) => p.paletteId),
        ['p1', 'p2'],
      );
      expect(stats.mostLinkedPalettes.first.count, 2);
    });

    test('an entry with no palette links no palette', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[entry(id: 'a', paletteId: '')],
      );
      expect(stats.mostLinkedPalettes, isEmpty);
    });

    test('a marker that is not in the collection is still counted', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[
          entry(id: 'a', markers: const <String>['ohuhu_oahu:ZZ9']),
        ],
        ownedMarkers: <MarkerColor>[color('R1', 'ff0000')],
      );
      expect(stats.mostUsedMarkers.single.colorId, 'ohuhu_oahu:ZZ9');
      expect(stats.unusedOwnedMarkers, hasLength(1));
    });

    test('the busiest month is the one with the most entries', () {
      final stats = computeDiaryStats(
        entries: <ArtworkEntry>[
          entry(id: 'a', date: DateTime(2026, 8, 1)),
          entry(id: 'b', date: DateTime(2026, 9, 1)),
          entry(id: 'c', date: DateTime(2026, 9, 2)),
        ],
      );
      expect(stats.busiestMonth!.key, '2026-09');
      expect(stats.busiestMonth!.entries, 2);
    });
  });
}
