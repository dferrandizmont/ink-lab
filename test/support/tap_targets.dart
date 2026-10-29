import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Smallest touch target, in logical pixels, on both axes.
const double minTapTarget = 44;

/// The tappable areas on screen (ink wells and buttons) smaller than
/// [minTapTarget] on either axis.
///
/// Areas cut by the screen edge or a scroll viewport are skipped: only what
/// is fully laid out is judged.
List<String> smallTapTargets(WidgetTester tester) {
  final List<String> small = <String>[];
  final Size screen = tester.view.physicalSize / tester.view.devicePixelRatio;
  final Rect bounds = Offset.zero & screen;
  for (final Element element
      in find
          .byWidgetPredicate(
            (Widget w) =>
                (w is InkResponse &&
                    (w.onTap != null || w.onLongPress != null)) ||
                (w is ButtonStyleButton && w.onPressed != null) ||
                (w is IconButton && w.onPressed != null),
          )
          .evaluate()) {
    final RenderObject? render = element.renderObject;
    if (render is! RenderBox || !render.hasSize || !render.attached) continue;
    final Rect rect = render.localToGlobal(Offset.zero) & render.size;
    if (!bounds.contains(rect.topLeft) || !bounds.contains(rect.bottomRight)) {
      continue;
    }
    if (_clipped(element, rect) || _insideButton(element)) continue;
    // A button's render box is its padded tap target.
    final Size hit = render.size;
    if (hit.width + 0.5 < minTapTarget || hit.height + 0.5 < minTapTarget) {
      small.add(
        '${_name(element)} ${hit.width.toStringAsFixed(0)}x'
        '${hit.height.toStringAsFixed(0)}',
      );
    }
  }
  return small;
}

/// The ink well of a Material button: the button's padded box is judged.
bool _insideButton(Element element) {
  if (element.widget is! InkResponse) return false;
  var inside = false;
  var depth = 0;
  element.visitAncestorElements((Element a) {
    if (a.widget is ButtonStyleButton || a.widget is IconButton) {
      inside = true;
      return false;
    }
    return ++depth < 40;
  });
  return inside;
}

bool _clipped(Element element, Rect rect) {
  var clipped = false;
  element.visitAncestorElements((Element a) {
    if (a.widget is Scrollable) {
      final RenderObject? r = a.renderObject;
      if (r is RenderBox && r.hasSize) {
        final Rect view = r.localToGlobal(Offset.zero) & r.size;
        if (!view.contains(rect.topLeft) ||
            !view.contains(rect.bottomRight - const Offset(0.1, 0.1))) {
          clipped = true;
        }
      }
      return false;
    }
    return true;
  });
  return clipped;
}

String _name(Element element) {
  final Key? key = element.widget.key;
  String? label;
  element.visitAncestorElements((Element a) {
    final Key? k = a.widget.key;
    if (k is ValueKey<String>) {
      label = k.value;
      return false;
    }
    return true;
  });
  return '${element.widget.runtimeType}'
      '${key is ValueKey<String>
          ? ' ${key.value}'
          : label == null
          ? ''
          : ' in $label'}';
}
