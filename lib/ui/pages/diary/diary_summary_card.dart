import 'package:flutter/material.dart';

import '../../../core/diary_stats.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import 'diary_stats_page.dart';
import 'diary_widgets.dart';

/// The compact summary at the top of the Diary segment ("12 artworks · 9
/// finished · 3 in progress", the markers used most as small swatches with
/// their counts). Tapping it opens [DiaryStatsPage].
class DiarySummaryCard extends StatelessWidget {
  const DiarySummaryCard({super.key, required this.entries});

  /// Markers shown on the card.
  static const int maxMarkers = 5;

  final List<ArtworkEntry> entries;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final DiaryStats stats = computeDiaryStats(entries: entries);
    final String summary = <String>[
      l10n.diaryStatsArtworks(stats.totalEntries),
      if (stats.finished > 0) l10n.diaryStatsFinished(stats.finished),
      if (stats.inProgress > 0) l10n.diaryStatsInProgress(stats.inProgress),
    ].join(' · ');
    final List<DiaryMarkerUsage> top = stats.mostUsedMarkers
        .take(maxMarkers)
        .toList();
    return Semantics(
      button: true,
      container: true,
      label: '$summary. ${l10n.diaryStatsOpen}',
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          onTap: () => DiaryStatsPage.open(context),
          borderRadius: InkRadii.cardRadius,
          child: Padding(
            padding: InkSpacing.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  summary,
                  style: AppTypography.section.copyWith(color: ink.fg),
                ),
                if (top.isNotEmpty) ...<Widget>[
                  const SizedBox(height: InkSpacing.buttonGap),
                  MarkerLookup(
                    ids: <String>[
                      for (final DiaryMarkerUsage u in top) u.colorId,
                    ],
                    builder:
                        (
                          BuildContext context,
                          Map<String, MarkerColor> colors,
                        ) => Wrap(
                          spacing: InkSpacing.block,
                          runSpacing: InkSpacing.group,
                          children: <Widget>[
                            for (final DiaryMarkerUsage u in top)
                              if (colors[u.colorId] case final MarkerColor c)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SwatchBlock(
                                      hex: c.hex,
                                      size: InkGeometry.swatchInline,
                                      radius: InkRadii.xs,
                                      own: c.hasOwnColor,
                                    ),
                                    const SizedBox(width: InkSpacing.s6),
                                    Text(
                                      '× ${u.count}',
                                      style: AppTypography.code.copyWith(
                                        color: ink.fg2,
                                      ),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                  ),
                ],
                const SizedBox(height: InkSpacing.buttonGap),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        l10n.diaryStatsOpen,
                        style: AppTypography.button.copyWith(color: ink.action),
                      ),
                    ),
                    InkIcon(
                      InkIcons.chevronRight,
                      size: InkGeometry.smallIcon,
                      color: ink.fg2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
