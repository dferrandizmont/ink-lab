import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/select_card.dart';
import 'collection_summary.dart';

/// Chips of the Ohuhu series (Oahu, Honolulu, Kaala), multi-select.
class SeriesChips extends StatelessWidget {
  const SeriesChips({
    super.key,
    required this.selected,
    required this.onToggle,
  });

  final Set<MarkerLine> selected;
  final void Function(MarkerLine line, bool on) onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: InkSpacing.chipGap,
      runSpacing: InkSpacing.s4,
      children: <Widget>[
        for (final MarkerLine line in MarkerLine.values)
          InkChip(
            key: ValueKey<String>('collection-series-${line.id}'),
            label: line.label,
            selected: selected.contains(line),
            onSelected: (bool on) => onToggle(line, on),
          ),
      ],
    );
  }
}

/// The Ohuhu series as selectable cards, multi-select: name and the tips the
/// series comes with, one card per series (first-run setup).
class SeriesCards extends StatelessWidget {
  const SeriesCards({
    super.key,
    required this.selected,
    required this.onToggle,
  });

  final Set<MarkerLine> selected;
  final void Function(MarkerLine line, bool on) onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final MarkerLine line in MarkerLine.values) ...<Widget>[
          if (line != MarkerLine.values.first)
            const SizedBox(height: InkSpacing.s12),
          SelectCard(
            key: ValueKey<String>('collection-series-${line.id}'),
            title: line.label,
            line: context.l10n.seriesTips(line),
            selected: selected.contains(line),
            onTap: () => onToggle(line, !selected.contains(line)),
          ),
        ],
      ],
    );
  }
}

/// The sets of the chosen series, grouped by series: current sets as chips,
/// older / community sets behind a disclosure.
class SeriesSetPicker extends StatefulWidget {
  const SeriesSetPicker({
    super.key,
    required this.series,
    required this.ownedSetIds,
    required this.onToggle,
  });

  /// The series whose sets are listed.
  final Set<MarkerLine> series;
  final Set<String> ownedSetIds;
  final void Function(OahuSet set, bool on) onToggle;

  @override
  State<SeriesSetPicker> createState() => _SeriesSetPickerState();
}

class _SeriesSetPickerState extends State<SeriesSetPicker> {
  final Set<MarkerLine> _olderOpen = <MarkerLine>{};

  @override
  void initState() {
    super.initState();
    for (final MarkerLine line in MarkerLine.values) {
      if (OahuSet.forLine(
        line,
      ).any((OahuSet s) => s.isLegacy && widget.ownedSetIds.contains(s.id))) {
        _olderOpen.add(line);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<Widget> children = <Widget>[];
    for (final MarkerLine line in MarkerLine.values) {
      if (!widget.series.contains(line)) continue;
      final List<OahuSet> sets = OahuSet.forLine(line);
      final List<OahuSet> current = sets
          .where((OahuSet s) => !s.isLegacy)
          .toList(growable: false);
      final List<OahuSet> older = sets
          .where((OahuSet s) => s.isLegacy)
          .toList(growable: false);
      children
        ..add(
          Padding(
            padding: const EdgeInsets.only(
              top: InkSpacing.block,
              bottom: InkSpacing.s4,
            ),
            child: Text(
              AppTypography.caps(line.label),
              style: AppTypography.capsStyle.copyWith(color: ink.fg2),
            ),
          ),
        )
        ..add(_chips(context, current));
      if (older.isNotEmpty) {
        children.add(
          InkDisclosure(
            key: ValueKey<String>('collection-older-${line.id}'),
            title: context.l10n.collectionOlderSets(older.length),
            expanded: _olderOpen.contains(line),
            padding: EdgeInsets.zero,
            onToggle: () => setState(() {
              if (!_olderOpen.remove(line)) _olderOpen.add(line);
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: InkSpacing.group),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: InkIcon(
                          InkIcons.info,
                          size: InkGeometry.smallIcon,
                          color: ink.fg2,
                        ),
                      ),
                      const SizedBox(width: InkSpacing.group),
                      Expanded(
                        child: Text(
                          context.l10n.collectionOlderSetsNote,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _chips(context, older),
              ],
            ),
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  Widget _chips(BuildContext context, List<OahuSet> sets) => Wrap(
    spacing: InkSpacing.chipGap,
    runSpacing: InkSpacing.s4,
    children: <Widget>[
      for (final OahuSet set in sets)
        InkChip(
          key: ValueKey<String>('collection-set-${set.id}'),
          label: context.l10n.packSetLabel(set),
          semanticLabel: context.l10n.settingsPackColorsSemantics(
            context.l10n.packSetFullLabel(set),
            set.expectedMemberCount,
          ),
          selected: widget.ownedSetIds.contains(set.id),
          onSelected: (bool on) => widget.onToggle(set, on),
        ),
    ],
  );
}

/// Ohuhu series that hold one of [ownedSetIds].
Set<MarkerLine> seriesOfSets(Set<String> ownedSetIds) => <MarkerLine>{
  for (final String id in ownedSetIds) ?OahuSet.byId[id]?.line,
};
