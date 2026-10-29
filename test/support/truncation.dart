import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Key prefixes of texts that clamp to a few lines and expand when tapped.
const List<String> expandOnTapKeyPrefixes = <String>['palette-row-why-'];

/// The texts on screen that are cut off: a paragraph that does not fit in
/// its `maxLines`, so it is drawn with an ellipsis or clipped.
///
/// A paragraph inside a [Tooltip] is exempt: its full text is available to
/// the user (long press, screen reader), which is how genuinely unbounded
/// content (marker names in grid cells, model ids) is allowed to ellipsise.
/// Control labels never qualify.
List<String> truncatedTexts(WidgetTester tester) {
  final List<String> cut = <String>[];
  for (final Element element in find.byType(RichText).evaluate()) {
    final RenderObject? render = element.renderObject;
    if (render is! RenderParagraph || !render.hasSize) continue;
    if (!isShown(element)) continue;
    if (!render.didExceedMaxLines && !_spillsOut(render)) continue;
    var exempt = false;
    element.visitAncestorElements((Element ancestor) {
      final Widget w = ancestor.widget;
      if (w is Tooltip) {
        exempt = true;
        return false;
      }
      // A row whose text expands in place on tap (the palette reasons).
      final Key? key = w.key;
      if (w is Text &&
          key is ValueKey<String> &&
          expandOnTapKeyPrefixes.any(key.value.startsWith)) {
        exempt = true;
        return false;
      }
      return true;
    });
    if (exempt) continue;
    cut.add(render.text.toPlainText());
  }
  return cut;
}

/// Whether the text of [element] can be seen: not in an offstage tab and not
/// under a fully transparent fade (a hint that the typed text replaced).
bool isShown(Element element) {
  var shown = true;
  element.visitAncestorElements((Element a) {
    final Widget w = a.widget;
    if (w is Offstage && w.offstage) {
      shown = false;
    } else if (w is FadeTransition && w.opacity.value == 0) {
      shown = false;
    } else if (w is Opacity && w.opacity == 0) {
      shown = false;
    }
    return shown;
  });
  return shown;
}

/// Whether the text of [p] is laid out wider than the paragraph itself
/// (a non-wrapping label in a box that is too narrow: drawn past its edge).
bool _spillsOut(RenderParagraph p) {
  final int length = p.text.toPlainText().length;
  if (length == 0) return false;
  final List<TextBox> boxes = p.getBoxesForSelection(
    TextSelection(baseOffset: 0, extentOffset: length),
  );
  // Wrapped text hangs trailing spaces past the edge: only judge one line.
  if (boxes.map((TextBox b) => b.top.round()).toSet().length > 1) return false;
  return boxes.any((TextBox b) => b.right > p.size.width + 0.5);
}

/// Fails if any visible text is truncated or a layout error was reported.
void expectNoTruncation(WidgetTester tester, String reason) {
  final Object? error = tester.takeException();
  expect(error, isNull, reason: '$reason: layout error');
  expect(truncatedTexts(tester), isEmpty, reason: '$reason: truncated text');
}

/// Scrolls [scrollable] to the end in steps, running [check] at each stop.
///
/// Lists build lazily, so a one-shot check only sees the first screen.
Future<void> scrollThrough(
  WidgetTester tester,
  Finder scrollable,
  void Function(int step) check, {
  double dy = 360,
  int maxSteps = 60,
}) async {
  check(0);
  for (var i = 1; i <= maxSteps; i++) {
    final ScrollableState state = tester.state(scrollable);
    final double before = state.position.pixels;
    await tester.drag(scrollable, Offset(0, -dy));
    await tester.pumpAndSettle();
    check(i);
    if (state.position.pixels == before) break;
  }
}
