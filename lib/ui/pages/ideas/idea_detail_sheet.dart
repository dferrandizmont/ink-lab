import 'package:flutter/material.dart';

import '../../../core/ideas_engine.dart';
import '../../../core/models.dart';
import '../../../core/palette_advisor.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/palette_strip.dart';
import 'ideas_page.dart' show ideaMetaLine;

/// The detail of one idea, inside an ink sheet: what you practise, what to
/// draw, the markers picked from your collection with their roles, numbered
/// steps tied to those markers, a tip and the materials.
///
/// "Other markers" picks the palette again with a new seed; "Use in Palette"
/// closes the sheet with the plan on screen (the caller hands it over).
class IdeaDetailSheet extends StatefulWidget {
  const IdeaDetailSheet({
    super.key,
    required this.initial,
    required this.candidates,
    required this.brand,
  });

  /// The plan shown first (the same markers as the list strip).
  final IdeaPlan initial;

  /// The markers of the collection to pick from.
  final List<MarkerColor> candidates;
  final MarkerBrand brand;

  @override
  State<IdeaDetailSheet> createState() => _IdeaDetailSheetState();
}

class _IdeaDetailSheetState extends State<IdeaDetailSheet> {
  late IdeaPlan _plan = widget.initial;

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

    return SingleChildScrollView(
      key: ValueKey<String>('ideas-detail-${_preset.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            // Room for the close button of the sheet.
            padding: const EdgeInsets.only(
              right: InkSpacing.sheetCloseClearance,
            ),
            child: Text(
              ideaMetaLine(context, _preset),
              style: AppTypography.capsStyle.copyWith(color: ink.fg2),
            ),
          ),
          const SizedBox(height: InkSpacing.group),
          Semantics(
            header: true,
            child: Text(
              l10n.ideaTitle(_preset),
              style: AppTypography.sheetTitle.copyWith(color: ink.fg),
            ),
          ),
          const SizedBox(height: InkSpacing.group),
          body(l10n.ideaSummary(_preset), color: ink.fg2),
          caps(l10n.ideasPracticeTitle),
          body(l10n.ideaPracticeText(_preset.id)),
          caps(l10n.ideasSubjectTitle),
          body(l10n.ideaSubjectText(_preset.id)),
          ..._buildMarkers(caps, body),
          caps(l10n.ideasStepsTitle),
          for (var i = 0; i < steps.length; i++)
            _StepRow(
              number: i + 1,
              text: steps[i],
              marker: i < _preset.stepRoles.length
                  ? _plan.markerFor(_preset.stepRoles[i])?.color
                  : null,
            ),
          caps(l10n.ideasTipTitle, top: InkSpacing.block),
          body(l10n.ideaTipText(_preset.id)),
          caps(l10n.ideasMaterialsTitle),
          body(l10n.ideaMaterialsText(_preset.materials), color: ink.fg2),
        ],
      ),
    );
  }

  List<Widget> _buildMarkers(
    Widget Function(String, {double top}) caps,
    Widget Function(String, {Color? color}) body,
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
          widget.brand == MarkerBrand.decoTime
              ? l10n.ideasNoMarkersDecoTime
              : l10n.ideasNoMarkersOther,
          color: ink.fg2,
        ),
      ];
    }
    final List<PaletteSuggestion> palette = _plan.palette;
    return <Widget>[
      caps(l10n.ideasMarkersTitle),
      if (palette.isNotEmpty) ...<Widget>[
        PaletteStrip(
          colors: <String>[for (final s in palette) s.color.hex],
          labels: <String>[for (final s in palette) s.color.newCode],
          colorHeight: 44,
          radius: InkRadii.control,
        ),
        const SizedBox(height: InkSpacing.block),
        for (final PaletteSuggestion s in palette) _MarkerRow(suggestion: s),
      ],
      if (_plan.missing > 0)
        Padding(
          padding: const EdgeInsets.only(top: InkSpacing.s4),
          child: body(l10n.ideasMissingMarkers(_plan.missing), color: ink.fg2),
        ),
      const SizedBox(height: InkSpacing.block),
      _ActionButtons(
        secondary: InkButton.secondary(
          key: ValueKey<String>('ideas-other-${_preset.id}'),
          label: l10n.ideasOtherMarkersButton,
          icon: InkIcons.shuffle,
          expand: true,
          onPressed: _otherMarkers,
        ),
        secondaryLabel: l10n.ideasOtherMarkersButton,
        primary: palette.isNotEmpty
            ? InkButton(
                key: ValueKey<String>('ideas-apply-${_preset.id}'),
                label: l10n.ideasApplyButton,
                trailingIcon: InkIcons.arrowRight,
                expand: true,
                onPressed: () => Navigator.of(context).pop(_plan),
              )
            : null,
        primaryLabel: l10n.ideasApplyButton,
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
              SwatchBlock(hex: color.hex, size: 36),
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

/// The sheet's two actions at full width: side by side in equal halves while
/// both labels fit on one line, one above the other (each full width) when
/// they do not, so a label is never cut or wrapped.
class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.secondary,
    required this.secondaryLabel,
    required this.primary,
    required this.primaryLabel,
  });

  final Widget secondary;
  final String secondaryLabel;
  final Widget? primary;
  final String primaryLabel;

  /// Width a button needs: padding 16 + 16, icon 16 and its gap 8, the label
  /// and a hair of margin.
  double _needed(BuildContext context, String label) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: label, style: AppTypography.button),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final double width = painter.width;
    painter.dispose();
    return width + 32 + 16 + 8 + 4;
  }

  @override
  Widget build(BuildContext context) {
    final Widget? primary = this.primary;
    if (primary == null) return secondary;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double half = (constraints.maxWidth - InkSpacing.buttonGap) / 2;
        final bool sideBySide =
            _needed(context, secondaryLabel) <= half &&
            _needed(context, primaryLabel) <= half;
        if (sideBySide) {
          return Row(
            children: <Widget>[
              Expanded(child: secondary),
              const SizedBox(width: InkSpacing.buttonGap),
              Expanded(child: primary),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            secondary,
            const SizedBox(height: InkSpacing.s8),
            primary,
          ],
        );
      },
    );
  }
}
