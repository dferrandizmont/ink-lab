import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/widgets/ink_switch.dart';

/// Radius from which a corner counts as a pill (the app uses 4–12).
const double pillRadius = 20;

/// Boxes thinner than this are decorations (sheet grabber, progress bars),
/// not controls.
const double _minControlHeight = 16;

/// The shapes on screen that are pills: a [StadiumBorder], or a corner of
/// [pillRadius] or more, on a [Material] (buttons, cards, dialogs), a
/// decorated box (chips, segments, badges) or an outlined text field.
///
/// Design G uses one small radius scale (controls 8–10, cards 12). The only
/// pill allowed is the switch track. Circles (icon buttons, swatch dots) are
/// not pills.
List<String> pillShapes(WidgetTester tester) {
  final List<String> pills = <String>[];
  for (final Element element in find.byWidgetPredicate(_shaped).evaluate()) {
    if (_allowed(element)) continue;
    final RenderObject? render = element.renderObject;
    final Size? size = render is RenderBox && render.hasSize
        ? render.size
        : null;
    if (size != null && size.height < _minControlHeight) continue;
    final String? why = _pillOf(element, size);
    if (why != null) pills.add('${_describe(element)}: $why');
  }
  return pills;
}

bool _shaped(Widget w) =>
    w is Material || w is DecoratedBox || w is InputDecorator;

bool _allowed(Element element) {
  var allowed = false;
  element.visitAncestorElements((Element a) {
    if (a.widget is InkSwitch) {
      allowed = true;
      return false;
    }
    return true;
  });
  return allowed;
}

String? _pillOf(Element element, Size? size) {
  final Widget w = element.widget;
  if (w is Material) {
    return _shape(w.shape) ?? _radius(w.borderRadius);
  }
  if (w is DecoratedBox) {
    final Decoration d = w.decoration;
    if (d is ShapeDecoration) return _shape(d.shape);
    if (d is BoxDecoration && d.shape == BoxShape.rectangle) {
      return _radius(d.borderRadius);
    }
    return null;
  }
  if (w is InputDecorator) {
    final theme = Theme.of(element).inputDecorationTheme;
    for (final InputBorder? b in <InputBorder?>[
      w.decoration.border,
      w.decoration.enabledBorder,
      w.decoration.focusedBorder,
      theme.border,
      theme.enabledBorder,
      theme.focusedBorder,
    ]) {
      if (b is OutlineInputBorder) {
        final String? why = _radius(b.borderRadius);
        if (why != null) return why;
      }
    }
  }
  return null;
}

String? _shape(ShapeBorder? shape) {
  if (shape is StadiumBorder) return 'StadiumBorder';
  if (shape is RoundedRectangleBorder) return _radius(shape.borderRadius);
  if (shape is ContinuousRectangleBorder) return _radius(shape.borderRadius);
  return null;
}

String? _radius(BorderRadiusGeometry? radius) {
  if (radius == null) return null;
  final BorderRadius r = radius.resolve(TextDirection.ltr);
  final double max = <double>[
    r.topLeft.x,
    r.topRight.x,
    r.bottomLeft.x,
    r.bottomRight.x,
  ].reduce((double a, double b) => a > b ? a : b);
  return max >= pillRadius ? 'radius $max' : null;
}

String _describe(Element element) {
  final List<String> chain = <String>[];
  element.visitAncestorElements((Element a) {
    final String name = a.widget.runtimeType.toString();
    if (!name.startsWith('_') &&
        name.startsWith(
          RegExp('Ink|Filled|Out|Text|Card|Dialog|Alert|Snack|Search|Chip'),
        )) {
      chain.add(name);
    }
    return chain.length < 2;
  });
  return '${element.widget.runtimeType}${chain.isEmpty ? '' : ' in ${chain.join(' < ')}'}';
}
