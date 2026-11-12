import 'package:flutter/material.dart';

import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../core/palette_advisor.dart';
import '../../../core/palette_generator.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/branded_code.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/one_line_text.dart';
import 'palette_reasons.dart';

/// One suggestion of the result: role, reason and the lock control.
class PaletteSuggestionRow extends StatefulWidget {
  const PaletteSuggestionRow({
    super.key,
    required this.suggestion,
    required this.role,
    required this.locked,
    required this.last,
    required this.onToggleLock,
    this.roleText,
    this.note,
    this.mixed = false,
  });

  final PaletteSuggestion suggestion;
  final String role;

  /// The role line already localised and composed (a blending chain's
  /// "Step 2 · Base"); with it the second line is the marker name.
  final String? roleText;

  /// A short remark after the marker name ("You don't own it").
  final String? note;

  /// Whether the palette mixes brands: the row then says which marker it is
  /// ("DecoTime 91") at the end of its role line.
  final bool mixed;
  final bool locked;
  final bool last;

  /// Locks or unlocks the colour; `null` hides the lock (photo palettes).
  final VoidCallback? onToggleLock;

  @override
  State<PaletteSuggestionRow> createState() => _SuggestionRowState();
}

/// A role in caps on a single line: when the whole text is wider than the
/// space it has, the type is scaled down just enough to fit, instead of
/// wrapping or being cut with an ellipsis.
@visibleForTesting
class RoleLabel extends StatelessWidget {
  const RoleLabel({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final String caps = AppTypography.caps(text);
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = constraints.maxWidth;
        final TextPainter painter = TextPainter(
          text: TextSpan(text: caps, style: style),
          textDirection: direction,
          textScaler: scaler,
          maxLines: 1,
        )..layout();
        final double width = painter.width;
        painter.dispose();
        if (width <= available) {
          return Text(caps, maxLines: 1, softWrap: false, style: style);
        }
        // A hair of margin so rounding never pushes the text past the edge.
        final double scale = available / width * 0.97;
        if (scale < paletteMinLineScale) {
          // Too long to shrink any further: wrap, like PaletteOneLine.
          return Text(
            caps,
            maxLines: paletteWrapLines,
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(
              fontSize: (style.fontSize ?? 12) * paletteMinLineScale,
              letterSpacing: (style.letterSpacing ?? 0) * paletteMinLineScale,
            ),
          );
        }
        return Text(
          caps,
          maxLines: 1,
          softWrap: false,
          style: style.copyWith(
            fontSize: (style.fontSize ?? 12) * scale,
            letterSpacing: (style.letterSpacing ?? 0) * scale,
          ),
        );
      },
    );
  }
}

class _SuggestionRowState extends State<PaletteSuggestionRow> {
  /// Lines shown before a reason needs a tap to expand.
  static const int _collapsedLines = 3;

  bool _expanded = false;

  /// The role line of a palette that mixes brands: the role, then the
  /// marker ("DecoTime 91") at the end of the line.
  ///
  /// The role keeps the room it needs to stay on one line, as in a palette
  /// of one brand; the marker takes what is left, where its brand is the
  /// part that gives way. The code is never cut: when even the code does not
  /// fit beside the role, it is the role that shrinks (see [RoleLabel]).
  Widget _roleAndMarker(
    BuildContext context,
    Widget roleLabel,
    String roleText,
    MarkerColor color,
  ) {
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    double widthOf(String text, TextStyle style) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: direction,
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      final double width = painter.width;
      painter.dispose();
      return width;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // One pixel of slack on each, so rounding never costs the role its
        // line or the code its last glyph.
        final double afterRole =
            constraints.maxWidth -
            widthOf(AppTypography.caps(roleText), AppTypography.capsStyle) -
            InkSpacing.s8 -
            1;
        final double codeAlone =
            widthOf(color.newCode, AppTypography.data) + InkSpacing.s4 + 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: roleLabel),
            const SizedBox(width: InkSpacing.s8),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: afterRole < codeAlone ? codeAlone : afterRole,
              ),
              child: BrandedCode(marker: color, mixed: true, dense: true),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final PaletteSuggestion suggestion = widget.suggestion;
    final String role = widget.role;
    final MarkerColor color = suggestion.color;
    // In scenario mode the role is the reason itself, and a loaded palette's
    // reason says nothing: show the marker name instead.
    final bool nameOnly =
        widget.roleText != null ||
        suggestion.reason == role ||
        suggestion.reason == PaletteReasons.loaded ||
        suggestion.reason == PaletteReasons.photo;
    final String code = markerCodeLabel(color, mixed: widget.mixed);
    final String name = widget.note == null
        ? color.newName
        : '${color.newName} · ${widget.note}';
    final String why = nameOnly
        ? name
        : context.l10n.reasonLabel(suggestion.reason);
    final String roleText = widget.roleText ?? context.l10n.roleLabel(role);
    final Widget roleLabel = RoleLabel(
      key: ValueKey<String>('palette-row-role-${color.newCode}'),
      text: roleText,
      style: AppTypography.capsStyle.copyWith(color: ink.fg2),
    );
    // The name alone is one line; a reason is a sentence that clamps and
    // expands on tap.
    return Semantics(
      container: true,
      label: '$code, ${color.newName}, $roleText',
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.only(left: InkSpacing.cardH),
        decoration: BoxDecoration(
          border: widget.last
              ? null
              : Border(bottom: BorderSide(color: ink.line)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // With brands mixed the marker is named at the end of
                    // the role line, in the small type, so the row is as
                    // tall as in a palette of one brand.
                    if (widget.mixed)
                      _roleAndMarker(context, roleLabel, roleText, color)
                    else
                      roleLabel,
                    const SizedBox(height: InkSpacing.s4),
                    // The name alone has nothing to expand: only a reason does.
                    if (nameOnly)
                      PaletteOneLine(
                        key: ValueKey<String>(
                          'palette-row-why-${color.newCode}',
                        ),
                        text: why,
                        style: AppTypography.secondary.copyWith(color: ink.fg),
                      )
                    else
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => _expanded = !_expanded),
                        child: Text(
                          why,
                          key: ValueKey<String>(
                            'palette-row-why-${color.newCode}',
                          ),
                          maxLines: _expanded ? null : _collapsedLines,
                          overflow: _expanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.onToggleLock != null)
              InkIconButton(
                icon: widget.locked ? InkIcons.lock : InkIcons.unlock,
                iconSize: InkGeometry.smallIcon,
                color: widget.locked ? ink.action : ink.fg2,
                tooltip: widget.locked
                    ? context.l10n.paletteUnlockButton
                    : context.l10n.paletteLockButton,
                onPressed: widget.onToggleLock,
              )
            else
              const SizedBox(width: InkSpacing.cardH),
          ],
        ),
      ),
    );
  }
}
