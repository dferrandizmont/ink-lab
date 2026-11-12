import 'package:flutter/material.dart';

import '../../../core/blending_chain.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../core/palette_advisor.dart';
import '../../../core/palette_generator.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/branded_code.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/one_line_text.dart';
import 'palette_layout.dart';
import 'palette_reasons.dart';
import 'palette_roles.dart';

/// A single plan step: order, zone, color and tip.
final class PlanStep {
  const PlanStep({
    required this.order,
    required this.zone,
    required this.code,
    required this.name,
    required this.tip,
    this.marker,
  });

  final int order;

  /// [code] is the marker as plain text: with its brand ("DecoTime 91") when
  /// the palette mixes brands.
  final String zone, code, name, tip;

  /// The marker of the step when the palette mixes brands, so the row draws
  /// its brand and its code apart; `null` in a palette of one brand, whose
  /// row shows [code].
  final MarkerColor? marker;
}

/// One row of the paint order: number, then the step (zone) with the marker
/// name under it, and a dot swatch with the code at the right.
class PaintStepRow extends StatelessWidget {
  const PaintStepRow({super.key, required this.step, required this.hex});

  final PlanStep step;
  final String hex;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color colour = swatchColor(hex);
    return Semantics(
      container: true,
      label:
          '${step.order}. ${step.zone}, ${step.code} ${step.name}.'
          '${step.tip.isEmpty ? '' : ' ${step.tip}'}',
      child: ExcludeSemantics(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: InkGeometry.stepRowHeight,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: InkGeometry.stepNumberWidth,
                child: Text(
                  '${step.order}',
                  style: AppTypography.data.copyWith(color: ink.fg2),
                ),
              ),
              const SizedBox(width: InkSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    PaletteOneLine(
                      key: ValueKey<String>('palette-step-zone-${step.order}'),
                      text: step.zone,
                      style: AppTypography.secondary.copyWith(color: ink.fg),
                    ),
                    PaletteOneLine(
                      key: ValueKey<String>('palette-step-name-${step.order}'),
                      text: step.name,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: InkSpacing.s12),
              Container(
                width: InkGeometry.stepDot,
                height: InkGeometry.stepDot,
                decoration: BoxDecoration(
                  color: colour,
                  shape: BoxShape.circle,
                  border: Border.all(color: ink.swatchEdge(colour)),
                ),
              ),
              const SizedBox(width: InkSpacing.s6),
              if (step.marker case final MarkerColor marker)
                BrandedCode(marker: marker, mixed: true)
              else
                Text(
                  step.code,
                  style: AppTypography.code.copyWith(color: ink.fg),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The steps of the paint order of the palette on screen: a blending [chain]
/// in its own order, otherwise the [base] first and then the [suggestions]
/// grouped by role (kept as they are when [keepOrder], for a custom or photo
/// palette). [photoRole] and [roleFor] give the role line of a marker.
List<PlanStep> buildPaintPlan({
  required AppLocalizations t,
  required BlendingChain? chain,
  required MarkerColor? base,
  required bool photoMode,
  required bool keepOrder,
  required List<PaletteSuggestion> suggestions,
  // Whether the codes carry their brand (the palette mixes brands).
  bool mixed = false,
  required String Function(MarkerColor marker) photoRole,
  required String Function(PaletteSuggestion suggestion) roleFor,
}) {
  if (chain != null) return _chainPlan(t, chain, mixed);
  final steps = <PlanStep>[];
  var order = 1;
  if (base != null) {
    steps.add(
      PlanStep(
        order: order++,
        zone: photoMode ? photoRole(base) : t.roleLabel(PaletteRoles.base),
        code: markerCodeLabel(base, mixed: mixed),
        marker: mixed ? base : null,
        name: base.newName,
        tip: photoMode ? '' : t.palettePaintTipBase,
      ),
    );
  }
  final groups = <List<PaletteSuggestion>>[
    <PaletteSuggestion>[],
    <PaletteSuggestion>[],
    <PaletteSuggestion>[],
    <PaletteSuggestion>[],
  ];
  final grouped = <List<String>>[
    <String>[],
    <String>[],
    <String>[],
    <String>[],
  ];
  for (final suggestion in suggestions) {
    final role = roleFor(suggestion);
    // A custom palette (an idea, a loaded palette) is already in painting
    // order, light to dark: keep it instead of regrouping by role.
    final group = keepOrder ? 3 : PaletteRoles.group(role);
    groups[group].add(suggestion);
    grouped[group].add(role);
  }
  for (var index = 0; index < groups.length; index++) {
    for (var i = 0; i < groups[index].length; i++) {
      final suggestion = groups[index][i];
      final role = grouped[index][i];
      // The plan row already names the marker, so a loaded palette (whose
      // reason says nothing) gets the generic tip of its group instead.
      final tip = photoMode
          ? ''
          : suggestion.reason == role ||
                suggestion.reason == PaletteReasons.loaded
          ? _groupTip(t, index)
          : t.reasonLabel(suggestion.reason);
      steps.add(
        PlanStep(
          order: order++,
          zone: t.roleLabel(role),
          code: markerCodeLabel(suggestion.color, mixed: mixed),
          marker: mixed ? suggestion.color : null,
          name: suggestion.color.newName,
          tip: tip,
        ),
      );
    }
  }
  return steps;
}

/// A blending chain is painted in its own order, light to dark.
List<PlanStep> _chainPlan(AppLocalizations t, BlendingChain chain, bool mixed) {
  final List<String> roles = blendingChainRoles(chain);
  final int last = chain.colors.length - 1;
  return <PlanStep>[
    for (int i = 0; i <= last; i++)
      PlanStep(
        order: i + 1,
        zone: t.roleLabel(roles[i]),
        code: markerCodeLabel(chain.colors[i], mixed: mixed),
        marker: mixed ? chain.colors[i] : null,
        name: chain.colors[i].newName,
        tip: i == 0
            ? t.palettePaintTipChainFirst
            : i == last
            ? t.palettePaintTipChainLast
            : t.palettePaintTipChainMiddle,
      ),
  ];
}

String _groupTip(AppLocalizations t, int group) => switch (group) {
  0 => t.palettePaintTipShadow,
  1 => t.palettePaintTipHighlight,
  2 => t.palettePaintTipAccent,
  _ => t.palettePaintTipSupport,
};

/// The "Paint order" disclosure: folded until opened, and the steps are only
/// built while it is open.
class PaintOrderSection extends StatelessWidget {
  const PaintOrderSection({
    super.key,
    required this.steps,
    required this.hexOf,
    required this.open,
    required this.onToggle,
  });

  final List<PlanStep> steps;

  /// The colour a step's marker is drawn in (already seen through the colour
  /// vision preview, if one is on).
  final String Function(String code) hexOf;

  final bool open;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return paletteInset(
      InkDisclosure(
        key: const ValueKey<String>('palette-paint-order'),
        title: AppTypography.caps(context.l10n.palettePaintPlanTitle),
        subtitle: context.l10n.palettePaintPlanSummary(steps.length),
        expanded: open,
        onToggle: onToggle,
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(top: InkSpacing.headingGap),
          child: Column(
            children: <Widget>[
              for (var index = 0; index < steps.length; index++) ...<Widget>[
                if (index > 0) const SizedBox(height: InkSpacing.s8),
                PaintStepRow(step: steps[index], hex: hexOf(steps[index].code)),
              ],
            ],
          ),
        ),
      ),
      top: InkSpacing.section,
    );
  }
}
