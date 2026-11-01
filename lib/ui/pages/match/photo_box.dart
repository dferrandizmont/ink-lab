import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/tokens.dart';

/// How tall the box that shows a photo is, for a photo area [width] wide.
///
/// The box follows the aspect ratio of the photo so a portrait photo fills the
/// width instead of showing as a narrow strip between two empty bars: the
/// height is [width] / [aspectRatio], kept between [minPhotoBoxHeight] (so
/// landscape and panoramic photos look as they always did, and so does the
/// empty box) and a maximum that leaves room for the buttons under it: 60 % of
/// the viewport height without the safe areas, and never more than
/// [maxPhotoBoxHeight]. On a viewport so small that the maximum falls under the
/// minimum, the minimum wins.
///
/// Without a usable [aspectRatio] (no photo yet, or a degenerate one) the box
/// has the minimum height.
double photoBoxHeight({
  required double width,
  required double? aspectRatio,
  required double viewportHeight,
  double safeAreaVertical = 0,
}) {
  if (aspectRatio == null ||
      !aspectRatio.isFinite ||
      aspectRatio <= 0 ||
      !width.isFinite ||
      width <= 0) {
    return minPhotoBoxHeight;
  }
  final double usable = math.max(0, viewportHeight - safeAreaVertical);
  final double cap = math.max(
    minPhotoBoxHeight,
    math.min(maxPhotoBoxHeight, usable * photoBoxViewportShare),
  );
  return (width / aspectRatio).clamp(minPhotoBoxHeight, cap);
}

/// The shortest the photo box gets: the fixed height it had before it followed
/// the photo.
const double minPhotoBoxHeight = 196;

/// The tallest the photo box gets, whatever the screen: on a tablet a 9:16
/// photo would otherwise push the buttons far below the fold.
const double maxPhotoBoxHeight = 520;

/// The share of the viewport height (without safe areas) the photo box may
/// take at most, so the white balance bar and the result stay within reach.
const double photoBoxViewportShare = 0.6;

/// The rounded, bordered box a photo is shown in, sized by [photoBoxHeight]
/// from [aspectRatio] (`null` for no photo: the box then keeps its minimum
/// height). A change of height is animated, unless the platform disables
/// animations.
class PhotoBox extends StatelessWidget {
  const PhotoBox({super.key, required this.aspectRatio, required this.child});

  /// Width over height of the photo, or `null` when there is none.
  final double? aspectRatio;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final double viewportHeight = MediaQuery.sizeOf(context).height;
    final double safeAreaVertical = MediaQuery.viewPaddingOf(context).vertical;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double height = photoBoxHeight(
          width: constraints.maxWidth,
          aspectRatio: aspectRatio,
          viewportHeight: viewportHeight,
          safeAreaVertical: safeAreaVertical,
        );
        return AnimatedContainer(
          duration: InkMotion.accessible(context, InkMotion.crossFade),
          curve: InkMotion.crossFadeCurve,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: ink.surface,
            borderRadius: InkRadii.cardRadius,
            border: Border.all(color: ink.line),
          ),
          child: child,
        );
      },
    );
  }
}
