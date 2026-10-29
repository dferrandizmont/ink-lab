import 'package:flutter/material.dart';

import 'tokens.dart';

/// Shape helpers built from [InkRadii]. Legacy names map onto the G radii.
abstract final class AppShapes {
  static const double extraSmall = InkRadii.xs;
  static const double small = InkRadii.cell;
  static const double medium = InkRadii.input;
  static const double large = InkRadii.card;
  static const double extraLarge = InkRadii.card;

  static const BorderRadius extraSmallRadius = InkRadii.xsRadius;
  static const BorderRadius smallRadius = InkRadii.cellRadius;
  static const BorderRadius mediumRadius = InkRadii.inputRadius;
  static const BorderRadius largeRadius = InkRadii.cardRadius;
  static const BorderRadius extraLargeRadius = InkRadii.cardRadius;

  static const RoundedRectangleBorder extraSmallBorder = RoundedRectangleBorder(
    borderRadius: extraSmallRadius,
  );
  static const RoundedRectangleBorder smallBorder = RoundedRectangleBorder(
    borderRadius: smallRadius,
  );
  static const RoundedRectangleBorder mediumBorder = RoundedRectangleBorder(
    borderRadius: mediumRadius,
  );
  static const RoundedRectangleBorder largeBorder = RoundedRectangleBorder(
    borderRadius: largeRadius,
  );
  static const RoundedRectangleBorder extraLargeBorder = largeBorder;
  static const StadiumBorder pill = StadiumBorder();
}
