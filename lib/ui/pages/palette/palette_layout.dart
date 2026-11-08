import 'package:flutter/widgets.dart';

import '../../theme/tokens.dart';

/// Horizontal gutter plus [top] spacing around [child]: how every block of the
/// palette page sits in its list.
Widget paletteInset(Widget child, {double top = 0}) => Padding(
  padding: EdgeInsets.fromLTRB(
    InkSpacing.pageMargin,
    top,
    InkSpacing.pageMargin,
    0,
  ),
  child: child,
);
