import 'package:flutter/material.dart';

import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// The header of every screen (spec §3, §6): padding 24 top / 16 sides /
/// 16 bottom, `title` (Archivo 800 40/40), optional trailing `data` on the
/// title baseline (e.g. "160 of 321"), gap 8, `secondary` subtitle in `fg2`.
///
/// [action] puts one control (an `InkIconButton`, an `InkOverflowMenu`) at
/// the right end of the title line, before [trailing] when both are given:
///
/// ```dart
/// InkPageHeader(
///   title: l10n.paletteTitle,
///   subtitle: l10n.paletteSubtitle,
///   action: InkIconButton(
///     icon: InkIcons.bookmark,
///     tooltip: l10n.paletteSavedTitle,
///     onPressed: openSaved,
///   ),
/// )
/// ```
class InkPageHeader extends StatelessWidget {
  const InkPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.action,
    this.subtitleWidget,
    this.padding = InkSpacing.header,
    this.reserveSubtitleFor = const <String>[],
  });

  final String title;
  final String? subtitle;

  /// Short `data` text right-aligned on the title baseline.
  final String? trailing;

  /// A control at the right end of the title line, before [trailing]. It is
  /// at most 44 dp high, so a header with an action is 4 dp taller than the
  /// 40 dp title line; give every state of one screen the same action so
  /// nothing moves.
  final Widget? action;

  /// Rich subtitle; replaces [subtitle].
  final Widget? subtitleWidget;
  final EdgeInsetsGeometry padding;

  /// The other texts [subtitle] takes on this screen (what a segment, a type
  /// or a mode swaps in). The subtitle box is always as tall as the tallest
  /// of them at the current width and text scale, so switching never moves
  /// what sits below the header.
  final List<String> reserveSubtitleFor;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Widget? sub =
        subtitleWidget ??
        (subtitle == null
            ? null
            : _ReservedSubtitle(
                text: subtitle!,
                alternatives: reserveSubtitleFor,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ));
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                child: Semantics(
                  header: true,
                  // The 40 px display title is already large text: it keeps its
                  // size at any system scale so it stays on one line.
                  child: MediaQuery.withClampedTextScaling(
                    maxScaleFactor: 1,
                    child: Text(
                      title,
                      maxLines: 1,
                      softWrap: false,
                      style: AppTypography.title.copyWith(color: ink.fg),
                    ),
                  ),
                ),
              ),
              if (action != null) ...<Widget>[
                const SizedBox(width: InkSpacing.group),
                action!,
              ],
              if (trailing != null) ...<Widget>[
                if (action != null) const SizedBox(width: InkSpacing.group),
                Text(
                  trailing!,
                  style: AppTypography.data.copyWith(color: ink.fg2),
                ),
              ],
            ],
          ),
          if (sub != null) ...<Widget>[
            const SizedBox(height: InkSpacing.group),
            sub,
          ],
        ],
      ),
    );
  }
}

/// The subtitle text, at least as tall as the tallest of [alternatives] would
/// be at the same width, text scale and style (measured, never clipped).
class _ReservedSubtitle extends StatefulWidget {
  const _ReservedSubtitle({
    required this.text,
    required this.alternatives,
    required this.style,
  });

  final String text;
  final List<String> alternatives;
  final TextStyle style;

  @override
  State<_ReservedSubtitle> createState() => _ReservedSubtitleState();
}

class _ReservedSubtitleState extends State<_ReservedSubtitle> {
  double? _cachedMaxWidth;
  TextScaler? _cachedScaler;
  TextDirection? _cachedDirection;
  TextStyle? _cachedStyle;
  String? _cachedText;
  List<String>? _cachedAlternatives;
  double _cachedTallest = 0;

  bool _sameInputs(
    double maxWidth,
    TextScaler scaler,
    TextDirection direction,
    TextStyle style,
  ) {
    if (_cachedMaxWidth != maxWidth) return false;
    if (_cachedScaler != scaler) return false;
    if (_cachedDirection != direction) return false;
    if (_cachedStyle != style) return false;
    if (_cachedText != widget.text) return false;
    final alts = widget.alternatives;
    if (_cachedAlternatives == null || _cachedAlternatives!.length != alts.length) {
      return false;
    }
    for (var i = 0; i < alts.length; i++) {
      if (_cachedAlternatives![i] != alts[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Text subtitle = Text(widget.text, style: widget.style);
    if (widget.alternatives.isEmpty) return subtitle;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final TextStyle resolved = DefaultTextStyle.of(context).style
            .merge(widget.style);
        final TextScaler scaler = MediaQuery.textScalerOf(context);
        final TextDirection direction = Directionality.of(context);
        if (!_sameInputs(constraints.maxWidth, scaler, direction, resolved)) {
          _cachedMaxWidth = constraints.maxWidth;
          _cachedScaler = scaler;
          _cachedDirection = direction;
          _cachedStyle = resolved;
          _cachedText = widget.text;
          _cachedAlternatives = List<String>.from(widget.alternatives);
          double tallest = 0;
          for (final String candidate in <String>[widget.text, ...widget.alternatives]) {
            final TextPainter painter = TextPainter(
              text: TextSpan(text: candidate, style: resolved),
              textDirection: direction,
              textScaler: scaler,
            )..layout(maxWidth: constraints.maxWidth);
            if (painter.height > tallest) tallest = painter.height;
            painter.dispose();
          }
          _cachedTallest = tallest;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: _cachedTallest),
          child: subtitle,
        );
      },
    );
  }
}

/// A `section` heading with an optional `data` note on the right (e.g.
/// "Closest alternatives" + "ΔE 2000").
class InkSectionHeading extends StatelessWidget {
  const InkSectionHeading(this.title, {super.key, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    // The note shares the line while both fit, else it drops below.
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: InkSpacing.group,
        children: <Widget>[
          Semantics(
            header: true,
            child: Text(
              title,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
          if (trailing != null)
            Text(trailing!, style: AppTypography.data.copyWith(color: ink.fg2)),
        ],
      ),
    );
  }
}
