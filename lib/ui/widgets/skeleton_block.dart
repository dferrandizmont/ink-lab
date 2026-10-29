import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// A static loading placeholder: a `line`-coloured block. No shimmer (the
/// design has no gradients), so nothing animates.
class SkeletonBlock extends StatelessWidget {
  const SkeletonBlock({
    super.key,
    this.width,
    this.height = 16,
    this.radius = InkRadii.cell,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: InkColors.of(context).line,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
