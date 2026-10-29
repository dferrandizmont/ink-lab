import 'package:flutter/material.dart';

import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// One option of an [InkSegmented] control.
@immutable
class InkSegment<T> {
  const InkSegment({required this.value, required this.label, this.semantic});

  final T value;
  final String label;

  /// Spoken label when [label] alone is unclear (e.g. "3 colours").
  final String? semantic;
}

/// The segmented control (spec §4 "Segmented control").
///
/// Container 48 high, control radius, 1 px `strong`, padding 3, gap 2, `surface`.
/// Segments 40 high, min width 44, padding 0 10, segment radius. Selected: `action`
/// fill, `onAction` text; others transparent with `fg`. [numeric] segments
/// use `code` type (Palette size 3/4/5), others `button`. Exposed to
/// assistive technology as a radio group.
class InkSegmented<T> extends StatelessWidget {
  const InkSegmented({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.numeric = false,
    this.expand = false,
    this.semanticLabel,
  });

  final List<InkSegment<T>> segments;
  final T selected;
  final ValueChanged<T>? onChanged;
  final bool numeric;

  /// Gives every segment an equal share of the available width.
  final bool expand;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Duration duration = InkMotion.accessible(
      context,
      InkMotion.crossFade,
    );
    final TextStyle base = numeric ? AppTypography.code : AppTypography.button;

    // Natural (one-line) width of each label, so "expand" shares the width in
    // proportion to the labels instead of equally: a long option is never cut
    // or wrapped while a short one ("3", "List") does not hog space.
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    final TextDirection direction = Directionality.of(context);
    double natural(InkSegment<T> s) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: s.label, style: base),
        textDirection: direction,
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      final double width = painter.width;
      painter.dispose();
      return width;
    }

    Widget segment(InkSegment<T> s) {
      final bool on = s.value == selected;
      final Widget child = Semantics(
        inMutuallyExclusiveGroup: true,
        checked: on,
        button: true,
        enabled: onChanged != null,
        label: s.semantic ?? s.label,
        excludeSemantics: true,
        child: InkWell(
          onTap: onChanged == null || on ? null : () => onChanged!(s.value),
          customBorder: const RoundedRectangleBorder(
            borderRadius: InkRadii.segmentRadius,
          ),
          // The segment takes the full height of the control, so the hit
          // area is 46 high around the 40-high visual segment.
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: AnimatedContainer(
              duration: duration,
              curve: InkMotion.crossFadeCurve,
              height: InkGeometry.segmentHeight,
              constraints: const BoxConstraints(minWidth: InkGeometry.target),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: on ? ink.action : Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: InkRadii.segmentRadius,
                ),
              ),
              child: Text(
                s.label,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
                style: base.copyWith(color: on ? ink.onAction : ink.fg),
              ),
            ),
          ),
        ),
      );
      return expand
          ? Expanded(flex: (natural(s) + 20).round(), child: child)
          : child;
    }

    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        height: InkGeometry.segmentedHeight,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: ShapeDecoration(
          color: ink.surface,
          shape: RoundedRectangleBorder(
            borderRadius: InkRadii.controlRadius,
            side: BorderSide(color: ink.strong),
          ),
        ),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          children: <Widget>[
            for (int i = 0; i < segments.length; i++) ...<Widget>[
              if (i > 0) const SizedBox(width: 2),
              segment(segments[i]),
            ],
          ],
        ),
      ),
    );
  }
}
