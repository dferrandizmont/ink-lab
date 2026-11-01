import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../core/white_balance.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import 'color_sampling.dart';

/// A photo with a loupe reticle on the point being sampled.
///
/// Shared by Match and by the "my colour" editor: both show the photo
/// contained in the available space, let the user tap or drag to sample and
/// draw the same reticle filled with the sampled colour. With a [balance] the
/// photo is shown corrected (a preview only: the pixels are never changed).
///
/// [onPoint] gets the touched point as a fraction of the photo. With
/// [tapOnly] only a tap counts (a drag does not), which is what choosing the
/// white of the photo needs.
class PhotoSampleCanvas extends StatelessWidget {
  const PhotoSampleCanvas({
    super.key,
    required this.bytes,
    required this.image,
    required this.onPoint,
    this.pick,
    this.sampleColor,
    this.balance,
    this.tapOnly = false,
    this.gestureKey,
  });

  /// The encoded photo, as picked.
  final Uint8List bytes;

  /// The decoded pixels, for the aspect ratio.
  final SampledImage image;

  /// Called with the touched point, as a fraction of the photo.
  final ValueChanged<Offset> onPoint;

  /// Where the reticle sits, as a fraction of the photo.
  final Offset? pick;

  /// The colour the reticle is filled with.
  final Color? sampleColor;

  /// The white balance to preview, if any.
  final WhiteBalance? balance;

  /// Whether only a tap (not a drag) calls [onPoint].
  final bool tapOnly;

  /// Key of the touch layer.
  final Key? gestureKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size container = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        final Rect fitted = containRect(container, image.aspectRatio);
        final Offset? point = pick;
        final Offset? pickLocal = point == null || fitted.isEmpty
            ? null
            : Offset(
                fitted.left + point.dx * fitted.width,
                fitted.top + point.dy * fitted.height,
              );
        void touch(Offset local) => onPoint(fractionForPoint(local, fitted));
        return GestureDetector(
          key: gestureKey,
          behavior: HitTestBehavior.opaque,
          onTapDown: (TapDownDetails details) => touch(details.localPosition),
          onPanStart: tapOnly
              ? null
              : (DragStartDetails details) => touch(details.localPosition),
          onPanUpdate: tapOnly
              ? null
              : (DragUpdateDetails details) => touch(details.localPosition),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              WhiteBalancePreview(
                balance: balance,
                child: Image.memory(
                  bytes,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stack,
                  ) => ColoredBox(color: InkColors.of(context).surface),
                ),
              ),
              if (pickLocal != null && sampleColor != null)
                CustomPaint(
                  painter: ReticlePainter(
                    centre: pickLocal,
                    sampleColor: sampleColor!,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Shows [child] as it looks with [balance]: the gains are applied on linear
/// light, between an sRGB-to-linear and a linear-to-sRGB filter, so the
/// preview agrees with the colours that are sampled.
class WhiteBalancePreview extends StatelessWidget {
  const WhiteBalancePreview({super.key, required this.child, this.balance});

  final Widget child;
  final WhiteBalance? balance;

  @override
  Widget build(BuildContext context) {
    final WhiteBalance? applied = balance;
    if (applied == null || applied.isIdentity) return child;
    return ColorFiltered(
      colorFilter: const ColorFilter.linearToSrgbGamma(),
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(applied.linearMatrix),
        child: ColorFiltered(
          colorFilter: const ColorFilter.srgbToLinearGamma(),
          child: child,
        ),
      ),
    );
  }
}

/// Draws the reticle (design G): a 60 circle filled with the sampled colour,
/// a white 3 px ring, a 1 px dark outer ring and a dark crosshair. The ring
/// colours are fixed, not themed, so the reticle reads on any photo.
class ReticlePainter extends CustomPainter {
  ReticlePainter({required this.centre, required this.sampleColor});

  final Offset centre;
  final Color sampleColor;

  static const double _outerRadius = 30;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(centre, _outerRadius - 1, Paint()..color = sampleColor);
    canvas.drawCircle(
      centre,
      _outerRadius - 2.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = InkColors.reticleRing,
    );
    canvas.drawCircle(
      centre,
      _outerRadius - 0.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = InkColors.reticleOuter,
    );
    // The 20 px crosshair: four ticks around an open centre.
    final Paint cross = Paint()
      ..color = InkColors.reticleOuter
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round;
    const double inner = 3.3, outer = 8.3;
    for (final Offset dir in const <Offset>[
      Offset(1, 0),
      Offset(-1, 0),
      Offset(0, 1),
      Offset(0, -1),
    ]) {
      canvas.drawLine(centre + dir * inner, centre + dir * outer, cross);
    }
  }

  @override
  bool shouldRepaint(ReticlePainter oldDelegate) =>
      oldDelegate.centre != centre || oldDelegate.sampleColor != sampleColor;
}

/// The white balance control under a photo: the "Fix white balance" button,
/// the hint while the user is choosing the white, or the "on" state with a way
/// back.
class WhiteBalanceBar extends StatelessWidget {
  const WhiteBalanceBar({
    super.key,
    required this.balance,
    required this.choosing,
    required this.onStart,
    required this.onCancel,
    required this.onReset,
    this.rejection,
  });

  /// The balance in force, if any.
  final WhiteBalance? balance;

  /// Whether the next tap on the photo chooses its white.
  final bool choosing;

  /// Why the last chosen point was refused, if it was.
  final WhiteBalanceRejection? rejection;

  final VoidCallback onStart;
  final VoidCallback onCancel;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final bool on = balance != null && !balance!.isIdentity;
    final String? problem = switch (rejection) {
      WhiteBalanceRejection.tooDark => context.l10n.matchWhiteBalanceTooDark,
      WhiteBalanceRejection.tooColourful =>
        context.l10n.matchWhiteBalanceTooColourful,
      null => null,
    };
    Widget line({
      required InkIcons icon,
      required String text,
      required String actionLabel,
      required VoidCallback action,
      Key? actionKey,
    }) => Row(
      children: <Widget>[
        InkIcon(icon, size: InkGeometry.smallIcon, color: ink.fg2),
        const SizedBox(width: InkSpacing.s8),
        Expanded(
          child: Text(
            text,
            style: AppTypography.secondary.copyWith(color: ink.fg),
          ),
        ),
        InkButton.text(key: actionKey, label: actionLabel, onPressed: action),
      ],
    );
    final Widget? problemLine = problem == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(bottom: InkSpacing.group),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkIcon(
                  InkIcons.alertCircle,
                  size: InkGeometry.smallIcon,
                  color: ink.error,
                ),
                const SizedBox(width: InkSpacing.s8),
                Expanded(
                  child: Text(
                    problem,
                    key: const ValueKey<String>('white-balance-problem'),
                    style: AppTypography.secondary.copyWith(color: ink.fg),
                  ),
                ),
              ],
            ),
          );
    final Widget main;
    if (choosing) {
      main = line(
        icon: InkIcons.crosshair,
        text: context.l10n.matchWhiteBalanceHint,
        actionLabel: context.l10n.matchCancelButton,
        action: onCancel,
        actionKey: const ValueKey<String>('white-balance-cancel'),
      );
    } else if (on) {
      main = line(
        icon: InkIcons.check,
        text: context.l10n.matchWhiteBalanceOn,
        actionLabel: context.l10n.matchWhiteBalanceReset,
        action: onReset,
        actionKey: const ValueKey<String>('white-balance-reset'),
      );
    } else {
      main = Align(
        alignment: Alignment.centerLeft,
        child: InkButton(
          key: const ValueKey<String>('white-balance-start'),
          label: context.l10n.matchWhiteBalanceButton,
          icon: InkIcons.crosshair,
          variant: InkButtonVariant.smallSecondary,
          onPressed: onStart,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[?problemLine, main],
    );
  }
}
