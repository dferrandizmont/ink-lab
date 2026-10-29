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

/// The pill segmented control (spec §4 "Segmented control").
///
/// Container 48 high, pill, 1 px `strong`, padding 3, gap 2, `surface`.
/// Segments 40 high, min width 44, padding 0 10, pill. Selected: `action`
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
          customBorder: const StadiumBorder(),
          child: AnimatedContainer(
            duration: duration,
            curve: InkMotion.crossFadeCurve,
            height: InkGeometry.segmentHeight,
            constraints: const BoxConstraints(minWidth: InkGeometry.target),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: on ? ink.action : Colors.transparent,
              shape: const StadiumBorder(),
            ),
            child: Text(
              s.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: base.copyWith(color: on ? ink.onAction : ink.fg),
            ),
          ),
        ),
      );
      return expand ? Expanded(child: child) : child;
    }

    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        height: InkGeometry.segmentedHeight,
        padding: const EdgeInsets.all(3),
        decoration: ShapeDecoration(
          color: ink.surface,
          shape: StadiumBorder(side: BorderSide(color: ink.strong)),
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
