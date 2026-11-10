import 'package:flutter_test/flutter_test.dart';

import '../../support/l10n.dart';

/// The counts of the Diary say "1 terminada" and "2 terminadas", in every
/// language (review finding: "1 obra · 1 terminadas").
void main() {
  group('Diary count strings agree in number', () {
    test('finished', () {
      expect(l10n.diaryStatsFinished(1), '1 finished');
      expect(l10n.diaryStatsFinished(3), '3 finished');
      expect(l10nEs.diaryStatsFinished(1), '1 terminada');
      expect(l10nEs.diaryStatsFinished(2), '2 terminadas');
      expect(l10nPt.diaryStatsFinished(1), '1 terminada');
      expect(l10nPt.diaryStatsFinished(2), '2 terminadas');
      expect(l10nIt.diaryStatsFinished(1), '1 finita');
      expect(l10nIt.diaryStatsFinished(2), '2 finite');
      expect(l10nFr.diaryStatsFinished(1), '1 terminée');
      expect(l10nFr.diaryStatsFinished(0), '0 terminée');
      expect(l10nFr.diaryStatsFinished(2), '2 terminées');
      expect(l10nDe.diaryStatsFinished(1), '1 fertig');
      expect(l10nDe.diaryStatsFinished(2), '2 fertig');
    });

    test('artworks, entries and unused markers: singular and plural', () {
      for (final AppLocalizations l in <AppLocalizations>[
        l10n,
        ...l10nTranslated,
      ]) {
        expect(l.diaryStatsArtworks(1), startsWith('1 '));
        expect(l.diaryStatsArtworks(2), isNot(l.diaryStatsArtworks(1)));
        expect(l.diaryStatsEntries(2), isNot(l.diaryStatsEntries(1)));
        expect(l.diaryStatsUnusedCount(2), isNot(l.diaryStatsUnusedCount(1)));
      }
    });

    test('the latest months', () {
      expect(l10n.diaryStatsMonthsLatest(1), 'Showing the latest month.');
      expect(l10n.diaryStatsMonthsLatest(6), 'Showing the latest 6 months.');
      for (final AppLocalizations l in l10nTranslated) {
        expect(
          l.diaryStatsMonthsLatest(1),
          isNot(contains('1')),
          reason: 'one month says "the last month", not "the last 1 months"',
        );
        expect(l.diaryStatsMonthsLatest(6), contains('6'));
      }
    });
  });
}
