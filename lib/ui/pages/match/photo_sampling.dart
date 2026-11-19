import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/white_balance.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/value_view.dart';
import 'color_sampling.dart';
import 'photo_sample_loupe.dart';

/// A photo with a sample-colour reticle and a magnifier while dragging.
///
/// Shared by Match and by the "my colour" editor: both show the photo
/// contained in the available space, let the user tap or drag to sample and
/// draw the same reticle filled with the sampled colour. With a [balance] the
/// photo is shown corrected (a preview only: the pixels are never changed).
///
/// [onPoint] gets the touched point as a fraction of the photo. With
/// [tapOnly] only a tap counts (a drag does not), which is what choosing the
/// white of the photo needs.
class PhotoSampleCanvas extends StatefulWidget {
  const PhotoSampleCanvas({
    super.key,
    required this.bytes,
    required this.image,
    required this.onPoint,
    this.pick,
    this.sampleColor,
    this.balance,
    this.tapOnly = false,
    this.valueView = false,
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

  /// Whether the photo is drawn in greyscale (its values only). The pixels are
  /// never changed, and the reticle keeps the [sampleColor] it is given.
  final bool valueView;

  /// Key of the canvas bounds; the touch target is the fitted photo inside it.
  final Key? gestureKey;

  @override
  State<PhotoSampleCanvas> createState() => _PhotoSampleCanvasState();
}

class _PhotoSampleCanvasState extends State<PhotoSampleCanvas>
    with SingleTickerProviderStateMixin {
  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _opacity =
      AnimationController(vsync: this, duration: InkMotion.swatchFade)
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.dismissed) _overlay.hide();
        });
  ui.Image? _pixels;
  int? _pointer;
  Offset? _down;
  Offset _finger = Offset.zero;
  Offset _fraction = Offset.zero;
  Offset? _pending;
  int? _frame;
  bool _dragging = false;
  Rect _fitted = Rect.zero;

  @override
  void initState() {
    super.initState();
    _uploadPixels();
  }

  void _uploadPixels() {
    final SampledImage image = widget.image;
    ui.decodeImageFromPixels(
      image.rgba,
      image.width,
      image.height,
      ui.PixelFormat.rgba8888,
      (ui.Image pixels) {
        if (!mounted || widget.image != image) {
          pixels.dispose();
          return;
        }
        setState(() {
          _pixels?.dispose();
          _pixels = pixels;
        });
      },
    );
  }

  @override
  void didUpdateWidget(PhotoSampleCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image ||
        oldWidget.tapOnly != widget.tapOnly) {
      _cancelPointer();
      _opacity.stop();
      // OverlayPortal cannot be shown/hidden during a build (for example when
      // the parent switches to choosing white or replaces the photo).
      if (_overlay.isShowing) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_dragging) _overlay.hide();
        });
      }
    }
    if (oldWidget.image != widget.image) {
      _pixels?.dispose();
      _pixels = null;
      _uploadPixels();
    }
  }

  void _cancelPointer() {
    _pointer = null;
    _down = null;
    _dragging = false;
    _pending = null;
    final int? frame = _frame;
    if (frame != null) {
      SchedulerBinding.instance.cancelFrameCallbackWithId(frame);
    }
    _frame = null;
  }

  @override
  void dispose() {
    _cancelPointer();
    _opacity.dispose();
    _pixels?.dispose();
    super.dispose();
  }

  // Pointer events only retain the latest position. Sampling (including Match's
  // ranking) and rebuilding the overlay happen once at the start of a frame.
  void _queuePoint(Offset local) {
    _finger = local + _fitted.topLeft;
    _fraction = fractionForPoint(_finger, _fitted);
    _pending = _fraction;
    _frame ??= SchedulerBinding.instance.scheduleFrameCallback((_) {
      _frame = null;
      if (!mounted) return;
      final Offset? point = _pending;
      _pending = null;
      if (point != null) widget.onPoint(point);
      setState(() {});
    });
  }

  void _pointerDown(PointerDownEvent event) {
    if (_pointer != null || event.buttons != kPrimaryButton) return;
    _pointer = event.pointer;
    _down = event.position;
  }

  void _pointerMove(PointerMoveEvent event) {
    if (event.pointer != _pointer) return;
    if (!_dragging) {
      final double slop = computeHitSlop(
        event.kind,
        MediaQuery.gestureSettingsOf(context),
      );
      if ((event.position - _down!).distance <= slop) return;
      _dragging = true;
      _opacity.value = 1;
      _overlay.show();
    }
    _queuePoint(event.localPosition);
  }

  void _finishLoupe() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _overlay.hide();
    } else {
      _opacity.reverse();
    }
    _pointer = null;
    _down = null;
    _dragging = false;
  }

  Widget _buildLoupe(BuildContext context, OverlayChildLayoutInfo info) {
    final Offset finger = MatrixUtils.transformPoint(
      info.childPaintTransform,
      _finger,
    );
    // SafeArea/Scaffold may have consumed the canvas's local padding/insets.
    // Placement uses root-overlay coordinates, so read its screen metrics too.
    final BuildContext overlayContext = Overlay.of(
      context,
      rootOverlay: true,
    ).context;
    final EdgeInsets safe = MediaQuery.viewPaddingOf(overlayContext);
    final EdgeInsets insets = MediaQuery.viewInsetsOf(overlayContext);
    final Rect viewport = Rect.fromLTRB(
      safe.left + 8,
      safe.top + 8,
      info.overlaySize.width - safe.right - 8,
      info.overlaySize.height -
          (insets.bottom > safe.bottom ? insets.bottom : safe.bottom) -
          8,
    );
    final Rect rect = photoLoupeRect(finger, viewport);
    return Positioned.fromRect(
      rect: rect,
      child: IgnorePointer(
        child: ExcludeSemantics(
          child: FadeTransition(
            opacity: _opacity,
            child: PhotoSampleLoupe(
              image: widget.image,
              pixels: _pixels,
              fraction: _fraction,
              displayPixelScale: _fitted.width / widget.image.width,
              balance: widget.balance,
              valueView: widget.valueView,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size container = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        final Rect fitted = containRect(container, widget.image.aspectRatio);
        _fitted = fitted;
        final Offset? point = widget.pick;
        final Offset? pickLocal = point == null || fitted.isEmpty
            ? null
            : Offset(
                fitted.left + point.dx * fitted.width,
                fitted.top + point.dy * fitted.height,
              );
        // Claim the fitted photo on down, before Scrollable's vertical drag can
        // beat the larger pan slop. Letterbox margins still scroll. The listener
        // distinguishes a tap from a drag; tap-only waits for a completed tap.
        final Widget touchLayer = widget.tapOnly
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (TapUpDetails details) => widget.onPoint(
                  fractionForPoint(
                    details.localPosition + fitted.topLeft,
                    fitted,
                  ),
                ),
              )
            : RawGestureDetector(
                behavior: HitTestBehavior.opaque,
                gestures: <Type, GestureRecognizerFactory>{
                  EagerGestureRecognizer:
                      GestureRecognizerFactoryWithHandlers<
                        EagerGestureRecognizer
                      >(
                        () => EagerGestureRecognizer(
                          allowedButtonsFilter: (int buttons) =>
                              buttons == kPrimaryButton,
                        ),
                        (EagerGestureRecognizer instance) {},
                      ),
                },
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerDown: _pointerDown,
                  onPointerMove: _pointerMove,
                  onPointerUp: (PointerUpEvent event) {
                    if (event.pointer != _pointer) return;
                    _queuePoint(event.localPosition);
                    _finishLoupe();
                  },
                  onPointerCancel: (PointerCancelEvent event) {
                    if (event.pointer != _pointer) return;
                    _cancelPointer();
                    _finishLoupe();
                  },
                ),
              );
        return OverlayPortal.overlayChildLayoutBuilder(
          controller: _overlay,
          overlayLocation: OverlayChildLocation.rootOverlay,
          overlayChildBuilder: _buildLoupe,
          child: Stack(
            key: widget.gestureKey,
            fit: StackFit.expand,
            children: <Widget>[
              Image.memory(
                widget.bytes,
                fit: BoxFit.contain,
                frameBuilder: (context, child, frame, synchronous) => Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ValueViewFilter(
                      enabled: widget.valueView,
                      child: WhiteBalancePreview(
                        balance: widget.balance,
                        child: child,
                      ),
                    ),
                    if (frame != null &&
                        pickLocal != null &&
                        widget.sampleColor != null)
                      CustomPaint(
                        painter: ReticlePainter(
                          centre: pickLocal,
                          sampleColor: widget.sampleColor!,
                        ),
                      ),
                  ],
                ),
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stack,
                ) => ColoredBox(color: InkColors.of(context).surface),
              ),
              Positioned.fromRect(
                rect: fitted,
                child: Semantics(
                  onTap: widget.tapOnly
                      ? null
                      : () => widget.onPoint(const Offset(0.5, 0.5)),
                  child: touchLayer,
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
  ReticlePainter({
    required this.centre,
    required this.sampleColor,
    this.outerRadius = defaultOuterRadius,
  });

  final Offset centre;
  final Color sampleColor;

  /// Radius of the outer line. The example photo of an empty Match draws a
  /// smaller ring, so it does not cover a thumbnail.
  final double outerRadius;

  /// Radius of the ring on the photo of Match.
  static const double defaultOuterRadius = 30;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(centre, outerRadius - 1, Paint()..color = sampleColor);
    canvas.drawCircle(
      centre,
      outerRadius - 2.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = InkColors.reticleRing,
    );
    canvas.drawCircle(
      centre,
      outerRadius - 0.5,
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
      oldDelegate.centre != centre ||
      oldDelegate.sampleColor != sampleColor ||
      oldDelegate.outerRadius != outerRadius;
}

/// The action that starts choosing the white of the photo.
///
/// The Match page shows it as a text button at the right of its row of
/// actions (so the row never moves); the "my colour" editor shows it as a
/// small secondary button under the photo.
class WhiteBalanceAction extends StatelessWidget {
  const WhiteBalanceAction({
    super.key,
    required this.onPressed,
    this.variant = InkButtonVariant.text,
    this.icon,
  });

  /// Starts choosing the white; `null` disables the button.
  final VoidCallback? onPressed;

  /// How the button is drawn: a text button on Match, a small secondary one
  /// in the editor.
  final InkButtonVariant variant;

  /// Optional leading icon.
  final InkIcons? icon;

  @override
  Widget build(BuildContext context) {
    final String label = context.l10n.matchWhiteBalanceButton;
    return switch (variant) {
      InkButtonVariant.text => InkButton.text(
        key: const ValueKey<String>('white-balance-start'),
        label: label,
        icon: icon,
        onPressed: onPressed,
      ),
      _ => InkButton(
        key: const ValueKey<String>('white-balance-start'),
        label: label,
        icon: icon,
        variant: variant,
        onPressed: onPressed,
      ),
    };
  }
}

/// What the white balance of the photo is doing: the hint while the user is
/// choosing the white, the "on" state with a way back, or why the last point
/// was refused.
///
/// It draws nothing when there is nothing to say, so a page can always leave
/// room for it without moving anything.
class WhiteBalanceStatus extends StatelessWidget {
  const WhiteBalanceStatus({
    super.key,
    required this.balance,
    required this.choosing,
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
    if (problem == null && !choosing && !on) return const SizedBox.shrink();
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
      main = const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[?problemLine, main],
    );
  }
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
    final bool on = balance != null && !balance!.isIdentity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        WhiteBalanceStatus(
          balance: balance,
          choosing: choosing,
          rejection: rejection,
          onCancel: onCancel,
          onReset: onReset,
        ),
        if (!choosing && !on)
          Align(
            alignment: Alignment.centerLeft,
            child: WhiteBalanceAction(
              variant: InkButtonVariant.smallSecondary,
              icon: InkIcons.crosshair,
              onPressed: onStart,
            ),
          ),
      ],
    );
  }
}
