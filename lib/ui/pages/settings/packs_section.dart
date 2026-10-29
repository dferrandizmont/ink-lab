import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/section_card.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The Ohuhu packs that make up the collection.
///
/// Ohuhu sells several lines (Oahu, Honolulu, Kaala) and people often own
/// more than one, so the section first asks which lines the user owns and
/// then lists the packs of each chosen line in a collapsible block, split
/// into the current packs and the older / community ones. The packs are
/// still stored as core and add-on pack ids, and the [PackSelectionMode]
/// decides whether one core pack or several are active.
/// Renders rows of the "Collection" card; the page owns the group.
class PacksSection extends StatefulWidget {
  const PacksSection({super.key, required this.scope, required this.state});

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  State<PacksSection> createState() => _PacksSectionState();
}

class _PacksSectionState extends State<PacksSection> {
  /// The lines the user owns. Starts from the lines of the selected packs, so
  /// users who only had Oahu packs see Oahu exactly as before.
  late Set<MarkerLine> _lines;

  /// Lines whose pack list is open, and those whose older packs are open.
  late final Set<MarkerLine> _open;
  final Set<MarkerLine> _legacyOpen = <MarkerLine>{};

  @override
  void initState() {
    super.initState();
    _lines = _linesOfSelection(widget.state.settings);
    _open = <MarkerLine>{MarkerLine.values.firstWhere(_lines.contains)};
    for (final MarkerLine line in _lines) {
      if (_legacySets(line).any(_isSelected)) _legacyOpen.add(line);
    }
  }

  @override
  void didUpdateWidget(PacksSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A backup import (or another screen) can select packs of a line that is
    // not shown: show it rather than hiding selected packs.
    final Set<MarkerLine> missing = _linesOfSelection(
      widget.state.settings,
      fallback: false,
    ).difference(_lines);
    if (missing.isNotEmpty) {
      _lines = <MarkerLine>{..._lines, ...missing};
    }
  }

  /// Lines that hold a selected pack; Oahu when there is none.
  static Set<MarkerLine> _linesOfSelection(
    AppSettings settings, {
    bool fallback = true,
  }) {
    final Set<String> ids = <String>{
      ...settings.selectedCoreSetIds,
      ...settings.selectedAddonSetIds,
    };
    final Set<MarkerLine> found = <MarkerLine>{
      for (final MarkerLine line in MarkerLine.values)
        if (ids.any((String id) => OahuSet.byId[id]?.line == line)) line,
    };
    if (found.isEmpty && fallback) return <MarkerLine>{MarkerLine.oahu};
    return found;
  }

  AppSettings get _settings => widget.state.settings;

  bool _isSelected(OahuSet set) =>
      _settings.selectedCoreSetIds.contains(set.id) ||
      _settings.selectedAddonSetIds.contains(set.id);

  static List<OahuSet> _currentSets(MarkerLine line) =>
      OahuSet.forLine(line)
          .where((OahuSet set) => !set.isLegacy)
          .toList(growable: false);

  static List<OahuSet> _legacySets(MarkerLine line) =>
      OahuSet.forLine(line)
          .where((OahuSet set) => set.isLegacy)
          .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    final AppSettings settings = _settings;
    final int selectedCount =
        settings.selectedCoreSetIds.length +
        settings.selectedAddonSetIds.length;
    final List<MarkerLine> lines = <MarkerLine>[
      for (final MarkerLine line in MarkerLine.values)
        if (_lines.contains(line)) line,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkListRow(
          label: context.l10n.settingsPacksTitle,
          value: context.l10n.settingsPacksSelected(selectedCount),
        ),
        const Divider(),
        SettingsControlRow(
          label: context.l10n.settingsPackMode,
          stacked: true,
          control: InkSegmented<PackSelectionMode>(
            expand: true,
            semanticLabel: context.l10n.settingsPackMode,
            segments: <InkSegment<PackSelectionMode>>[
              for (final PackSelectionMode mode in PackSelectionMode.values)
                InkSegment<PackSelectionMode>(
                  value: mode,
                  label: context.l10n.packModeLabel(mode),
                ),
            ],
            selected: settings.packSelectionMode,
            onChanged: (PackSelectionMode mode) =>
                widget.scope.settings.setPackSelectionMode(mode),
          ),
        ),
        if (settings.packSelectionMode == PackSelectionMode.single)
          SettingsCaption(context.l10n.settingsSinglePackHint),
        const Divider(),
        SettingsSubhead(context.l10n.settingsLinesTitle),
        _PackChips(
          semanticLabel: context.l10n.settingsLinesTitle,
          children: <Widget>[
            for (final MarkerLine line in MarkerLine.values)
              InkChip(
                label: line.label,
                selected: _lines.contains(line),
                onSelected: (bool value) => _toggleLine(line, value),
              ),
          ],
        ),
        SettingsCaption(context.l10n.settingsLinesHint),
        for (final MarkerLine line in lines) ...<Widget>[
          const Divider(),
          _buildLine(context, line),
        ],
        const SizedBox(height: InkSpacing.group),
      ],
    );
  }

  Widget _buildLine(BuildContext context, MarkerLine line) {
    final List<OahuSet> current = _currentSets(line);
    final List<OahuSet> legacy = _legacySets(line);
    final int total = current.length + legacy.length;
    final int selected = <OahuSet>[
      ...current,
      ...legacy,
    ].where(_isSelected).length;
    return InkDisclosure(
      title: line.label,
      subtitle: context.l10n.settingsLineSelectedOfTotal(selected, total),
      expanded: _open.contains(line),
      onToggle: () => setState(() {
        if (!_open.remove(line)) _open.add(line);
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (current.isNotEmpty) ...<Widget>[
            SettingsSubhead(context.l10n.settingsCurrentPacks(current.length)),
            _packChips(context, current),
          ],
          if (legacy.isNotEmpty)
            InkDisclosure(
              title: context.l10n.settingsLegacyPacks(legacy.length),
              expanded: _legacyOpen.contains(line),
              onToggle: () => setState(() {
                if (!_legacyOpen.remove(line)) _legacyOpen.add(line);
              }),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _LegacyNote(context.l10n.settingsLegacyPacksNote),
                  _packChips(context, legacy),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _packChips(BuildContext context, List<OahuSet> sets) {
    return _PackChips(
      children: <Widget>[
        for (final OahuSet set in sets)
          InkChip(
            label: context.l10n.packSetLabel(set),
            semanticLabel: context.l10n.settingsPackColorsSemantics(
              context.l10n.packSetLabel(set),
              set.expectedMemberCount,
            ),
            selected: _isSelected(set),
            onSelected: (bool value) => _togglePack(set, value),
          ),
      ],
    );
  }

  void _toggleLine(MarkerLine line, bool value) {
    if (value) {
      setState(() {
        _lines = <MarkerLine>{..._lines, line};
        _open.add(line);
      });
      return;
    }
    // At least one line stays on, so the section never ends up empty.
    if (_lines.length <= 1) return;
    final Set<String> lineIds = <String>{
      for (final OahuSet set in OahuSet.forLine(line)) set.id,
    };
    final Set<String> core = {..._settings.selectedCoreSetIds};
    final Set<String> addon = {..._settings.selectedAddonSetIds};
    final bool coreHad = core.any(lineIds.contains);
    final bool addonHad = addon.any(lineIds.contains);
    setState(() {
      _lines = <MarkerLine>{..._lines}..remove(line);
      _open.remove(line);
      _legacyOpen.remove(line);
      if (_open.isEmpty) _open.add(_lines.first);
    });
    // The pack ids of the line leave the selection with it.
    if (coreHad) {
      widget.scope.settings.setSelectedCoreSetIds(core..removeAll(lineIds));
    }
    if (addonHad) {
      widget.scope.settings.setSelectedAddonSetIds(addon..removeAll(lineIds));
    }
  }

  void _togglePack(OahuSet set, bool value) =>
      set.isCore ? _toggleCore(set, value) : _toggleAddon(set, value);

  void _toggleCore(OahuSet set, bool value) {
    final Set<String> next = {..._settings.selectedCoreSetIds};
    if (value) {
      if (_settings.packSelectionMode == PackSelectionMode.single) {
        // A single pack is active, so picking one replaces the previous.
        next
          ..clear()
          ..add(set.id);
      } else {
        next.add(set.id);
      }
    } else {
      next.remove(set.id);
    }
    widget.scope.settings.setSelectedCoreSetIds(next);
  }

  void _toggleAddon(OahuSet set, bool value) {
    final Set<String> next = {..._settings.selectedAddonSetIds};
    if (value) {
      next.add(set.id);
    } else {
      next.remove(set.id);
    }
    widget.scope.settings.setSelectedAddonSetIds(next);
  }
}

/// The chips of one group, wrapped inside the card's 16 padding.
class _PackChips extends StatelessWidget {
  const _PackChips({required this.children, this.semanticLabel});

  final List<Widget> children;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticLabel,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          0,
          InkSpacing.cardH,
          InkSpacing.s4,
        ),
        child: Wrap(
          spacing: InkSpacing.chipGap,
          runSpacing: InkSpacing.s4,
          children: children,
        ),
      ),
    );
  }
}

/// The info note above the older / community packs.
class _LegacyNote extends StatelessWidget {
  const _LegacyNote(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        InkSpacing.cardH,
        0,
        InkSpacing.cardH,
        InkSpacing.group,
      ),
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
              text,
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
          ),
        ],
      ),
    );
  }
}
