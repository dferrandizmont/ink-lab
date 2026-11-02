import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/diary_stats.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/section_card.dart';
import 'diary_widgets.dart';

/// The numbers of the artwork diary: how many entries each month has, how many
/// are finished, the markers used most, the markers owned and never used and
/// the saved palettes linked most. Opened from the summary card at the top of
/// the Diary segment. Everything is computed on the phone from the entries.
class DiaryStatsPage extends StatefulWidget {
  const DiaryStatsPage({super.key});

  /// Key of the page body, handy for tests.
  static const Key pageKey = Key('diary-stats-page');

  /// Months shown in the per-month list (the newest ones).
  static const int maxMonths = 12;

  /// Markers shown in the most used list.
  static const int maxMarkers = 10;

  /// Palettes shown in the most linked list.
  static const int maxPalettes = 5;

  /// Widest the page content grows on a tablet.
  static const double maxContentWidth = 640;

  /// Height of the status bar and of the per-month bars.
  static const double barHeight = 8;

  /// Opens the page.
  static Future<void> open(BuildContext context) {
    // Keep the services of this context above the page, also when they sit
    // below the navigator (tests, previews).
    final AppScope? scope = context.getInheritedWidgetOfExactType<AppScope>();
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          const Widget page = DiaryStatsPage();
          return scope == null ? page : scope.wrap(page);
        },
      ),
    );
  }

  @override
  State<DiaryStatsPage> createState() => _DiaryStatsPageState();
}

class _DiaryStatsPageState extends State<DiaryStatsPage> {
  AppScope? _scope;
  Future<List<MarkerColor>>? _owned;
  bool _showUnused = false;
  bool _showPalettes = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (identical(scope, _scope)) return;
    _scope = scope;
    _owned = _loadOwned(scope);
  }

  /// The markers the user owns, in every brand.
  Future<List<MarkerColor>> _loadOwned(AppScope scope) async {
    final AppSettings settings = scope.settings.settings;
    final List<MarkerColor> owned = <MarkerColor>[];
    for (final MarkerBrand brand in MarkerBrand.values) {
      List<MarkerColor> catalog;
      try {
        catalog = await scope.markers.loadColors(brand);
      } catch (_) {
        continue;
      }
      owned.addAll(
        ownedColors(
          colors: catalog,
          brand: brand,
          ownedSetIds: settings.effectiveSetIds(),
          ownedMarkerCodes: settings.ownedMarkerCodes,
        ),
      );
    }
    return owned;
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = AppScope.of(context);
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.diaryStatsTitle)),
      body: SafeArea(
        child: StreamBuilder<List<ArtworkEntry>>(
          stream: scope.artworkDiary.changes,
          initialData: scope.artworkDiary.entries,
          builder: (BuildContext context, AsyncSnapshot<List<ArtworkEntry>> s) {
            final List<ArtworkEntry> entries = s.data ?? const <ArtworkEntry>[];
            return FutureBuilder<List<MarkerColor>>(
              future: _owned,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<List<MarkerColor>> owned,
                  ) {
                    final DiaryStats stats = computeDiaryStats(
                      entries: entries,
                      ownedMarkers: owned.data ?? const <MarkerColor>[],
                    );
                    return SingleChildScrollView(
                      key: DiaryStatsPage.pageKey,
                      padding: const EdgeInsets.fromLTRB(
                        InkSpacing.gutter,
                        InkSpacing.group,
                        InkSpacing.gutter,
                        InkSpacing.pageBottom,
                      ),
                      child: stats.totalEntries == 0
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: InkSpacing.section,
                              ),
                              child: EmptyState(
                                icon: InkIcons.edit3,
                                title: l10n.diaryEmptyTitle,
                                message: l10n.diaryEmptyMessage,
                              ),
                            )
                          // On a tablet the bars and strips stay readable.
                          : Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: DiaryStatsPage.maxContentWidth,
                                ),
                                child: _buildSections(
                                  context,
                                  stats,
                                  ownedLoaded: owned.hasData,
                                  ownedCount: owned.data?.length ?? 0,
                                ),
                              ),
                            ),
                    );
                  },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSections(
    BuildContext context,
    DiaryStats stats, {
    required bool ownedLoaded,
    required int ownedCount,
  }) {
    final AppLocalizations l10n = context.l10n;
    const Widget gap = SizedBox(height: InkSpacing.block);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionCard(
          key: const ValueKey<String>('diary-stats-status'),
          title: l10n.diaryStatsStatusTitle,
          child: _StatusBar(stats: stats),
        ),
        gap,
        SectionCard(
          key: const ValueKey<String>('diary-stats-months'),
          title: l10n.diaryStatsMonthsTitle,
          child: _MonthBars(months: stats.months),
        ),
        gap,
        SectionCard(
          key: const ValueKey<String>('diary-stats-markers'),
          title: l10n.diaryStatsMarkersTitle,
          child: _TopMarkers(
            usage: stats.mostUsedMarkers
                .take(DiaryStatsPage.maxMarkers)
                .toList(),
          ),
        ),
        gap,
        if (ownedLoaded) ...<Widget>[
          SectionCard(
            key: const ValueKey<String>('diary-stats-unused'),
            title: l10n.diaryStatsUnusedTitle,
            child: _Unused(
              owned: ownedCount,
              unused: stats.unusedOwnedMarkers,
              expanded: _showUnused,
              onToggle: () => setState(() => _showUnused = !_showUnused),
            ),
          ),
          gap,
        ],
        SectionCard(
          key: const ValueKey<String>('diary-stats-palettes'),
          title: l10n.diaryStatsPalettesTitle,
          child: _TopPalettes(
            usage: stats.mostLinkedPalettes,
            expanded: _showPalettes,
            onToggle: () => setState(() => _showPalettes = !_showPalettes),
          ),
        ),
      ],
    );
  }
}

/// A bar with the finished and in progress shares, and its legend.
class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.stats});

  final DiaryStats stats;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final String finished = l10n.diaryStatsFinished(stats.finished);
    final String inProgress = l10n.diaryStatsInProgress(stats.inProgress);
    return Semantics(
      container: true,
      label: '$finished, $inProgress',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(InkRadii.xs),
              child: SizedBox(
                height: DiaryStatsPage.barHeight,
                child: Row(
                  children: <Widget>[
                    if (stats.finished > 0)
                      Expanded(
                        flex: stats.finished,
                        child: ColoredBox(color: ink.action),
                      ),
                    // A gap, so the two fills never rely on colour alone.
                    if (stats.finished > 0 && stats.inProgress > 0)
                      const SizedBox(width: InkSpacing.s2),
                    if (stats.inProgress > 0)
                      Expanded(
                        flex: stats.inProgress,
                        child: ColoredBox(color: ink.strong),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: InkSpacing.buttonGap),
            Wrap(
              spacing: InkSpacing.block,
              runSpacing: InkSpacing.group,
              children: <Widget>[
                _LegendDot(color: ink.action, text: finished),
                _LegendDot(color: ink.strong, text: inProgress),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(InkRadii.xs),
          ),
          child: const SizedBox.square(dimension: 12),
        ),
        const SizedBox(width: InkSpacing.s8),
        Flexible(
          child: Text(
            text,
            style: AppTypography.secondary.copyWith(color: ink.fg),
          ),
        ),
      ],
    );
  }
}

/// The entries of each month as a plain bar list, newest month first.
class _MonthBars extends StatelessWidget {
  const _MonthBars({required this.months});

  final List<DiaryMonth> months;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final MaterialLocalizations dates = MaterialLocalizations.of(context);
    final List<DiaryMonth> shown = months.reversed
        .take(DiaryStatsPage.maxMonths)
        .toList();
    final int most = shown.fold<int>(
      1,
      (int top, DiaryMonth month) => month.entries > top ? month.entries : top,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (int i = 0; i < shown.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(height: InkSpacing.buttonGap),
          Builder(
            builder: (BuildContext context) {
              final DiaryMonth month = shown[i];
              final String label = dates.formatMonthYear(
                DateTime(month.year, month.month),
              );
              return Semantics(
                container: true,
                label: '$label: ${l10n.diaryStatsEntries(month.entries)}',
                child: ExcludeSemantics(
                  child: Column(
                    key: ValueKey<String>('diary-stats-month-${month.key}'),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              label,
                              style: AppTypography.secondary.copyWith(
                                color: ink.fg,
                              ),
                            ),
                          ),
                          const SizedBox(width: InkSpacing.s8),
                          Text(
                            '${month.entries}',
                            style: AppTypography.code.copyWith(color: ink.fg),
                          ),
                        ],
                      ),
                      const SizedBox(height: InkSpacing.s4),
                      _Bar(fraction: month.entries / most),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        if (months.length > shown.length) ...<Widget>[
          const SizedBox(height: InkSpacing.block),
          Text(
            l10n.diaryStatsMonthsLatest(shown.length),
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ],
      ],
    );
  }
}

/// A rounded bar filled to [fraction] of its width.
class _Bar extends StatelessWidget {
  const _Bar({required this.fraction});

  final double fraction;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(InkRadii.xs),
      child: SizedBox(
        height: DiaryStatsPage.barHeight,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ColoredBox(color: ink.line),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: ColoredBox(color: ink.action),
            ),
          ],
        ),
      ),
    );
  }
}

/// The markers used most: swatch, code, name and how many entries use each.
class _TopMarkers extends StatelessWidget {
  const _TopMarkers({required this.usage});

  final List<DiaryMarkerUsage> usage;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    if (usage.isEmpty) {
      return Text(
        l10n.diaryStatsMarkersEmpty,
        style: AppTypography.secondary.copyWith(color: ink.fg2),
      );
    }
    return MarkerLookup(
      ids: <String>[for (final DiaryMarkerUsage u in usage) u.colorId],
      builder: (BuildContext context, Map<String, MarkerColor> colors) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int i = 0; i < usage.length; i++) ...<Widget>[
              if (i > 0) const SizedBox(height: InkSpacing.buttonGap),
              _MarkerRow(
                key: ValueKey<String>('diary-stats-marker-${usage[i].colorId}'),
                color: colors[usage[i].colorId],
                fallbackCode: usage[i].colorId.substring(
                  usage[i].colorId.indexOf(':') + 1,
                ),
                count: usage[i].count,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _MarkerRow extends StatelessWidget {
  const _MarkerRow({
    super.key,
    required this.color,
    required this.fallbackCode,
    required this.count,
  });

  /// The marker, or `null` when the catalogue does not know it any more.
  final MarkerColor? color;
  final String fallbackCode;
  final int count;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final String code = color?.newCode ?? fallbackCode;
    final String name = color?.newName ?? '';
    final String uses = context.l10n.diaryStatsEntries(count);
    return Semantics(
      container: true,
      label: '$code${name.isEmpty ? '' : ' $name'}, $uses',
      child: ExcludeSemantics(
        child: Row(
          children: <Widget>[
            if (color != null)
              SwatchBlock(
                hex: color!.hex,
                size: InkGeometry.swatchRow,
                radius: InkRadii.xs,
                own: color!.hasOwnColor,
              )
            else
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(InkRadii.xs),
                  border: Border.all(color: ink.line),
                ),
                child: const SizedBox.square(dimension: InkGeometry.swatchRow),
              ),
            const SizedBox(width: InkSpacing.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    code,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.code.copyWith(color: ink.fg),
                  ),
                  if (name.isNotEmpty)
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                ],
              ),
            ),
            const SizedBox(width: InkSpacing.s8),
            Text(uses, style: AppTypography.secondary.copyWith(color: ink.fg2)),
          ],
        ),
      ),
    );
  }
}

/// The owned markers no entry mentions: how many, and the list on request.
class _Unused extends StatelessWidget {
  const _Unused({
    required this.owned,
    required this.unused,
    required this.expanded,
    required this.onToggle,
  });

  /// How many markers the user owns, in every brand.
  final int owned;
  final List<MarkerColor> unused;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final TextStyle note = AppTypography.secondary.copyWith(color: ink.fg2);
    if (owned == 0) {
      return Text(l10n.diaryStatsUnusedNoCollection, style: note);
    }
    if (unused.isEmpty) {
      return Text(l10n.diaryStatsUnusedNone, style: note);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.diaryStatsUnusedCount(unused.length),
          style: AppTypography.body.copyWith(color: ink.fg),
        ),
        const SizedBox(height: InkSpacing.group),
        InkButton.text(
          key: const ValueKey<String>('diary-stats-unused-toggle'),
          label: expanded
              ? l10n.diaryStatsUnusedHide
              : l10n.diaryStatsUnusedShow,
          onPressed: onToggle,
        ),
        if (expanded) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          Wrap(
            key: const ValueKey<String>('diary-stats-unused-list'),
            spacing: InkSpacing.block,
            runSpacing: InkSpacing.buttonGap,
            children: <Widget>[
              for (final MarkerColor color in unused)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SwatchBlock(
                      hex: color.hex,
                      size: InkGeometry.swatchInline,
                      radius: InkRadii.xs,
                      own: color.hasOwnColor,
                    ),
                    const SizedBox(width: InkSpacing.s6),
                    Text(
                      color.newCode,
                      style: AppTypography.code.copyWith(color: ink.fg),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ],
    );
  }
}

/// The saved palettes linked most: name, colours and how many entries link it.
/// A palette deleted since is left out.
class _TopPalettes extends StatelessWidget {
  const _TopPalettes({
    required this.usage,
    required this.expanded,
    required this.onToggle,
  });

  final List<DiaryPaletteUsage> usage;

  /// The list of palettes is long (every saved palette), so it stays closed
  /// until the user asks for it, like the unused markers.
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final AppScope scope = AppScope.of(context);
    final List<(SavedPalette, int)> rows = <(SavedPalette, int)>[
      for (final DiaryPaletteUsage u in usage)
        if (findSavedPalette(scope, u.paletteId) case final SavedPalette p)
          (p, u.count),
    ].take(DiaryStatsPage.maxPalettes).toList();
    if (rows.isEmpty) {
      return Text(
        l10n.diaryStatsPalettesEmpty,
        style: AppTypography.secondary.copyWith(color: ink.fg2),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkButton.text(
          key: const ValueKey<String>('diary-stats-palettes-toggle'),
          label: expanded
              ? l10n.diaryStatsUnusedHide
              : l10n.diaryStatsUnusedShow,
          onPressed: onToggle,
        ),
        if (expanded) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          Column(
            key: const ValueKey<String>('diary-stats-palettes-list'),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < rows.length; i++) ...<Widget>[
                if (i > 0) const SizedBox(height: InkSpacing.block),
                Semantics(
                  container: true,
                  label:
                      '${rows[i].$1.name}, '
                      '${l10n.diaryStatsEntries(rows[i].$2)}',
                  child: ExcludeSemantics(
                    child: Column(
                      key: ValueKey<String>(
                        'diary-stats-palette-${rows[i].$1.id}',
                      ),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                rows[i].$1.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.body.copyWith(
                                  color: ink.fg,
                                ),
                              ),
                            ),
                            const SizedBox(width: InkSpacing.s8),
                            Text(
                              l10n.diaryStatsEntries(rows[i].$2),
                              style: AppTypography.secondary.copyWith(
                                color: ink.fg2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: InkSpacing.group),
                        DiaryPaletteStrip(palette: rows[i].$1),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
