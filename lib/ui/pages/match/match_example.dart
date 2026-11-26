import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

import '../../../core/color_utils.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import 'photo_sampling.dart';

/// The bundled example photo of the empty Match tab (CC0, see
/// `assets/images/CREDITS.md`).
const String matchExampleAsset = 'assets/images/match_example.jpg';

/// Where the example is sampled, as a fraction of the photo.
///
/// A big, smooth patch of the sky above the canal, and a point where the
/// closest marker does not depend on the screen or on how the photo was
/// scaled: it is the same marker for every sampling radius and every offset of
/// 1 % around it, and the runner-up is several steps of ΔE away. Never an
/// edge. A test pins it against the real photo.
const Offset matchExamplePoint = Offset(0.65, 0.30);

/// Reads the bytes of the example photo; tests inject their own.
typedef MatchExampleLoader = Future<Uint8List> Function();

/// Reads [matchExampleAsset] from the app bundle.
Future<Uint8List> loadMatchExample() async {
  final ByteData data = await rootBundle.load(matchExampleAsset);
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

/// The example photo as the empty state shows it: the encoded photo, and what
/// sampling [matchExamplePoint] gives with the markers Match uses.
final class MatchExample {
  const MatchExample({
    required this.bytes,
    required this.aspectRatio,
    required this.sampleColor,
    required this.match,
  });

  /// Encoded photo, as the gallery would give it.
  final Uint8List bytes;

  /// Width over height of the decoded photo.
  final double aspectRatio;

  /// Opaque ARGB colour sampled at [matchExamplePoint].
  final int sampleColor;

  /// The closest marker of what Match matches against, or `null` when there
  /// is none to match against.
  final ColorDistanceMatch? match;
}

/// A small, tappable preview of the example photo with the sample ring on it,
/// and the chip of the marker that point matches under it.
///
/// The photo is cropped to a fixed 2:1 box. The chip is laid out separately
/// from the image frames and keeps one line of space while its name is unknown.
/// Tapping the preview does what the example button does; a `null` [onTap]
/// disables it.
class MatchExamplePreview extends StatelessWidget {
  const MatchExamplePreview({super.key, required this.example, this.onTap});

  /// The photo and its match, or `null` while it is being read.
  final MatchExample? example;

  /// Loads the example into Match; `null` disables the preview.
  final VoidCallback? onTap;

  /// Width over height of the box the photo is drawn in.
  static const double boxAspect = 2;

  /// Radius of the ring on the thumbnail (the photo of Match has 30).
  static const double ringRadius = 14;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MatchExample? shown = example;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Semantics(
          button: true,
          enabled: onTap != null,
          container: true,
          label: context.l10n.matchExamplePreviewSemantics,
          onTap: onTap,
          child: ExcludeSemantics(
            child: AspectRatio(
              aspectRatio: boxAspect,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: ink.surface,
                  borderRadius: InkRadii.cardRadius,
                  border: Border.all(color: ink.line),
                ),
                child: ClipRRect(
                  // Inside the 1 px border.
                  borderRadius: BorderRadius.circular(InkRadii.card - 1),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if (shown != null) _photo(context, shown),
                      Positioned.fill(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            key: const ValueKey<String>('match-example-tap'),
                            onTap: onTap,
                            borderRadius: InkRadii.cardRadius,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.group),
        _MarkerChip(match: shown?.match),
      ],
    );
  }

  /// The photo, cropped to fill the box, and the ring where it is sampled.
  Widget _photo(BuildContext context, MatchExample shown) {
    final double pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size box = constraints.biggest;
        // `BoxFit.cover`, centred: the photo is scaled to fill the box and
        // the overflow is cropped evenly on both sides.
        final Size drawn = box.aspectRatio > shown.aspectRatio
            ? Size(box.width, box.width / shown.aspectRatio)
            : Size(box.height * shown.aspectRatio, box.height);
        final Offset ring = Offset(
          (box.width - drawn.width) / 2 + matchExamplePoint.dx * drawn.width,
          (box.height - drawn.height) / 2 + matchExamplePoint.dy * drawn.height,
        );
        return Image.memory(
          shown.bytes,
          fit: BoxFit.cover,
          // A thumbnail: the 1600 px photo is never decoded for it.
          cacheWidth: (box.width * pixelRatio).ceil(),
          excludeFromSemantics: true,
          frameBuilder: (context, child, frame, synchronous) => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              child,
              if (frame != null)
                CustomPaint(
                  painter: ReticlePainter(
                    centre: ring,
                    sampleColor: Color(0xFF000000 | shown.sampleColor),
                    outerRadius: ringRadius,
                  ),
                ),
            ],
          ),
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stack,
          ) => ColoredBox(color: InkColors.of(context).surface),
        );
      },
    );
  }
}

/// The chip of the marker that matches the example: its swatch, code and name.
class _MarkerChip extends StatelessWidget {
  const _MarkerChip({required this.match});

  static const int _nameMaxLines = 4;

  final ColorDistanceMatch? match;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? color = match?.color;
    final TextStyle nameStyle = AppTypography.secondary.copyWith(
      color: ink.fg2,
    );
    final TextStyle codeStyle = AppTypography.code.copyWith(color: ink.fg);
    return Visibility(
      visible: color != null,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Container(
        key: const ValueKey<String>('match-example-chip'),
        padding: const EdgeInsets.symmetric(
          horizontal: InkSpacing.s10,
          vertical: InkSpacing.s6,
        ),
        decoration: BoxDecoration(
          color: ink.surface,
          borderRadius: InkRadii.controlRadius,
          border: Border.all(color: ink.line),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  color?.newCode ?? '0',
                  maxLines: 1,
                  softWrap: false,
                  style: codeStyle,
                ),
                const SizedBox(width: InkSpacing.s8),
                SwatchBlock(
                  hex: color?.hex ?? 'ffffff',
                  size: InkGeometry.smallIcon,
                  radius: InkRadii.xs,
                ),
              ],
            ),
            Text(
              color?.newName ?? 'M',
              style: nameStyle,
              maxLines: _nameMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
