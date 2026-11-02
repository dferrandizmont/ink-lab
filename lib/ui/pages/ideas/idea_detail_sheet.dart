import 'package:flutter/material.dart';

import '../../../core/ideas_engine.dart';
import '../../../core/models.dart';
import '../../../core/palette_advisor.dart';
import '../../../data/idea_favorites_repository.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/palette_strip.dart';
import 'ideas_page.dart' show IdeaHeartButton, ideaMetaLine;

/// The detail of one idea, inside a draggable ink sheet (0.9 review §2.3):
/// the title with its heart, the meta line, a one-line summary, the palette
/// picked from the collection with "Use in Palette" as the only action on
/// view, the steps and, folded away, what you practise, what to draw, a tip
/// and the materials.
///
/// "Other markers" (in the sheet's "⋯" menu) picks the palette again with a
/// new seed; "Use in Palette" closes the sheet with the plan on screen (the
/// caller hands it over). The named markers sit behind their own disclosure,
/// which starts folded and shows how many there are.
class IdeaDetailSheet extends StatefulWidget {
  const IdeaDetailSheet({
    super.key,
    required this.initial,
    required this.candidates,
    required this.brand,
    required this.scrollController,
    this.favorites,
    this.onAddToDiary,
  });

  /// The plan shown first (the same markers as the list strip).
  final IdeaPlan initial;

  /// The markers of the collection to pick from.
  final List<MarkerColor> candidates;
  final MarkerBrand brand;

  /// The scroll controller of the sheet content, handed over by
  /// [showInkDraggableSheet] so a drag on the content resizes the sheet.
  final ScrollController scrollController;

  /// The hearts of the ideas; without it the sheet has no heart.
  final IdeaFavoritesRepository? favorites;

  /// Called with the idea's title after the sheet closed, to start a diary
  /// entry; without it the sheet has no "Add to diary" entry in its menu.
  final ValueChanged<String>? onAddToDiary;

  @override
  State<IdeaDetailSheet> createState() => _IdeaDetailSheetState();
}

class _IdeaDetailSheetState extends State<IdeaDetailSheet> {
  late IdeaPlan _plan = widget.initial;

  /// The named markers of the palette, under a disclosure, folded by default.
  bool _markersOpen = false;

  /// What you practise, what to draw, the tip and the materials, folded away.
  bool _detailsOpen = false;

  IdeaPreset get _preset => _plan.preset;

  void _otherMarkers() {
    setState(() {
      _plan = IdeasEngine.generatePlan(
        _preset,
        widget.candidates,
        seed: _plan.seed + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final List<String> steps = l10n.ideaStepsText(_preset.id);
    final List<PaletteSuggestion> palette = _plan.palette;

    Widget caps(String text, {double top = InkSpacing.s24}) => Padding(
      padding: EdgeInsets.only(top: top, bottom: InkSpacing.group),
      child: Text(
        AppTypography.caps(text),
        style: AppTypography.capsStyle.copyWith(color: ink.fg2),
      ),
    );
    Widget body(String text, {Color? color}) => Text(
      text,
      style: AppTypography.secondary.copyWith(color: color ?? ink.fg),
    );

    return ListView(
      key: ValueKey<String>('ideas-detail-${_preset.id}'),
      controller: widget.scrollController,
      padding: EdgeInsets.zero,
      children: <Widget>[
        // Title with the heart and the "⋯" menu. The right clearance keeps
        // them clear of the sheet's floating close button.
        Padding(
          padding: const EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    l10n.ideaTitle(_preset),
                    style: AppTypography.sheetTitle.copyWith(color: ink.fg),
                  ),
                ),
              ),
              if (widget.favorites != null) ...<Widget>[
                const SizedBox(width: InkSpacing.s8),
                StreamBuilder<Set<String>>(
                  stream: widget.favorites!.favoriteChanges,
                  initialData: widget.favorites!.favorites,
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<Set<String>> snapshot,
                      ) => IdeaHeartButton(
                        key: ValueKey<String>(
                          'ideas-heart-sheet-${_preset.id}',
                        ),
                        favorite: (snapshot.data ?? const <String>{}).contains(
                          _preset.id,
                        ),
                        onPressed: _toggleFavorite,
                      ),
                ),
              ],
              const SizedBox(width: InkSpacing.s8),
              InkOverflowMenu(
                key: ValueKey<String>('ideas-overflow-${_preset.id}'),
                items: <InkMenuItem>[
                  if (widget.onAddToDiary != null)
                    InkMenuItem(
                      key: ValueKey<String>('ideas-diary-${_preset.id}'),
                      label: l10n.diaryAdd,
                      icon: InkIcons.plus,
                      onSelected: _addToDiary,
                    ),
                  if (palette.isNotEmpty)
                    InkMenuItem(
                      key: ValueKey<String>('ideas-other-${_preset.id}'),
                      label: l10n.ideasOtherMarkersButton,
                      icon: InkIcons.shuffle,
                      onSelected: _otherMarkers,
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: InkSpacing.group),
        Text(
          ideaMetaLine(context, _preset),
          style: AppTypography.capsStyle.copyWith(color: ink.fg2),
        ),
        const SizedBox(height: InkSpacing.group),
        // One line: the whole summary is one long-press away.
        Tooltip(
          message: l10n.ideaSummary(_preset),
          child: Text(
            l10n.ideaSummary(_preset),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        ..._buildMarkers(context, caps, body, palette),
        caps(l10n.ideasStepsTitle),
        for (var i = 0; i < steps.length; i++)
          _StepRow(
            number: i + 1,
            text: steps[i],
            marker: i < _preset.stepRoles.length
                ? _plan.markerFor(_preset.stepRoles[i])?.color
                : null,
          ),
        const SizedBox(height: InkSpacing.block),
        InkDisclosure(
          key: ValueKey<String>('ideas-details-${_preset.id}'),
          title: l10n.ideasMoreDetails,
          expanded: _detailsOpen,
          onToggle: () => setState(() => _detailsOpen = !_detailsOpen),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              caps(l10n.ideasPracticeTitle, top: 0),
              body(l10n.ideaPracticeText(_preset.id)),
              caps(l10n.ideasSubjectTitle),
              body(l10n.ideaSubjectText(_preset.id)),
              caps(l10n.ideasTipTitle, top: InkSpacing.block),
              body(l10n.ideaTipText(_preset.id)),
              caps(l10n.ideasMaterialsTitle),
              body(l10n.ideaMaterialsText(_preset.materials), color: ink.fg2),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _toggleFavorite() async {
    try {
      await widget.favorites?.toggle(_preset.id);
    } catch (_) {
      // The heart simply does not change when the store cannot write.
    }
  }

  /// Closes the sheet, then hands the idea's title to the page that opened
  /// it (the sheet's own context is gone by then).
  void _addToDiary() {
    final String title = context.l10n.ideaTitle(_preset);
    final ValueChanged<String> callback = widget.onAddToDiary!;
    Navigator.of(context).pop();
    callback(title);
  }

  List<Widget> _buildMarkers(
    BuildContext context,
    Widget Function(String, {double top}) caps,
    Widget Function(String, {Color? color}) body,
    List<PaletteSuggestion> palette,
  ) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    if (!_preset.hasPalette) {
      return <Widget>[
        const SizedBox(height: InkSpacing.block),
        body(l10n.ideasGuideOnlyNote, color: ink.fg2),
      ];
    }
    if (widget.candidates.isEmpty) {
      return <Widget>[
        caps(l10n.ideasMarkersTitle),
        body(
          widget.brand.hasRetailSets
              ? l10n.ideasNoMarkersOther
              : l10n.ideasNoMarkersBrand(widget.brand.label),
          color: ink.fg2,
        ),
      ];
    }
    return <Widget>[
      caps(l10n.ideasMarkersTitle),
      // The strip is the swatches only (like the featured card); the codes
      // wait in the folded list below.
      PaletteStrip(
        colors: <String>[for (final s in palette) s.color.hex],
        colorHeight: 44,
        radius: InkRadii.control,
      ),
      if (_plan.missing > 0)
        Padding(
          padding: const EdgeInsets.only(top: InkSpacing.s4),
          child: body(l10n.ideasMissingMarkers(_plan.missing), color: ink.fg2),
        ),
      const SizedBox(height: InkSpacing.block),
      // The primary sits right under the strip, so it is on view when the
      // sheet opens at half height (§2.3.4).
      InkButton(
        key: ValueKey<String>('ideas-apply-${_preset.id}'),
        label: l10n.ideasApplyButton,
        trailingIcon: InkIcons.arrowRight,
        expand: true,
        onPressed: () => Navigator.of(context).pop(_plan),
      ),
      const SizedBox(height: InkSpacing.block),
      // The named markers stay in "Your markers", folded after the strip
      // (the summary says how many there are).
      InkDisclosure(
        key: ValueKey<String>('ideas-markers-${_preset.id}'),
        title: l10n.collectionMarkers(palette.length),
        expanded: _markersOpen,
        onToggle: () => setState(() => _markersOpen = !_markersOpen),
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: InkSpacing.s4),
            for (final PaletteSuggestion s in palette) _MarkerRow(suggestion: s),
          ],
        ),
      ),
    ];
  }
}

/// A marker of the idea: colour, code and name, its role and why.
class _MarkerRow extends StatelessWidget {
  const _MarkerRow({required this.suggestion});

  final PaletteSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor color = suggestion.color;
    final String role = context.l10n.roleLabel(suggestion.role ?? '');
    return Semantics(
      container: true,
      label: context.l10n.ideasMarkerSemantic(
        role,
        color.newCode,
        color.newName,
      ),
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.only(bottom: InkSpacing.buttonGap),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SwatchBlock(hex: color.hex, size: 36, own: color.hasOwnColor),
              const SizedBox(width: InkSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppTypography.caps(role),
                      style: AppTypography.capsStyle.copyWith(
                        color: ink.action,
                      ),
                    ),
                    const SizedBox(height: InkSpacing.s2),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: color.newCode,
                            style: AppTypography.code.copyWith(color: ink.fg),
                          ),
                          TextSpan(
                            text: '  ${color.newName}',
                            style: AppTypography.secondary.copyWith(
                              color: ink.fg2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: InkSpacing.s2),
                    Text(
                      context.l10n.reasonLabel(suggestion.reason),
                      style: AppTypography.secondary.copyWith(color: ink.fg),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A numbered step; when it uses one of the idea's markers, its colour dot
/// and code sit on the right (design G "Paint order").
class _StepRow extends StatelessWidget {
  const _StepRow({required this.number, required this.text, this.marker});

  final int number;
  final String text;
  final MarkerColor? marker;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? marker = this.marker;
    return Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.s10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 16,
            child: Padding(
              padding: const EdgeInsets.only(top: InkSpacing.s2),
              child: Text(
                '$number',
                style: AppTypography.data.copyWith(color: ink.fg2),
              ),
            ),
          ),
          const SizedBox(width: InkSpacing.s10),
          Expanded(
            child: Text(
              text,
              style: AppTypography.secondary.copyWith(color: ink.fg),
            ),
          ),
          if (marker != null) ...<Widget>[
            const SizedBox(width: InkSpacing.s10),
            Padding(
              padding: const EdgeInsets.only(top: InkSpacing.s4),
              child: SwatchBlock(
                hex: marker.hex,
                size: 12,
                radius: InkRadii.xs,
              ),
            ),
            const SizedBox(width: InkSpacing.s6),
            Text(
              marker.newCode,
              key: ValueKey<String>('ideas-step-$number-${marker.newCode}'),
              style: AppTypography.data.copyWith(color: ink.fg),
            ),
          ],
        ],
      ),
    );
  }
}
