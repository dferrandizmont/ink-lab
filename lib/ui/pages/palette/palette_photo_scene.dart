import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/photo_palette.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_sheet.dart';
import '../match/color_sampling.dart';
import '../match/image_picker_service.dart';
import 'palette_type_picker.dart';

// "From a photo" in the palette scene sheet: the dominant colours of a photo,
// found on the device, are matched to the markers the user owns. The photo is
// kept in memory only to draw its thumbnail; it is never stored or sent.

/// A photo turned into a palette: its dominant colours for each palette size,
/// and the picture itself for the thumbnail.
///
/// The colours of every size are found once, when the photo is read, so a new
/// size only picks a list again; the markers are matched on the page against
/// the current collection. The decoded pixels are not kept.
final class PhotoScene {
  PhotoScene({required this.bytes, required this.colors});

  /// `SavedPalette.scenarioName` of a palette made from a photo.
  static const String savedName = 'fromPhoto';

  /// The palette sizes the photo is analysed for.
  static const List<int> sizes = <int>[3, 4, 5];

  /// Largest side, in pixels, the photo is decoded to: enough for dominant
  /// colours and cheap to cluster.
  static const int maxDimension = 360;

  /// Width, in pixels, the thumbnail is decoded to.
  static const int thumbnailWidth = 96;

  /// The encoded photo, for the thumbnail only.
  final Uint8List bytes;

  /// The dominant colours (most prominent first) found for each of [sizes].
  final Map<int, List<PhotoColor>> colors;

  /// The thumbnail, a provider this scene owns so it can drop it from the
  /// image cache (which would otherwise keep the original bytes alive).
  late final ImageProvider thumbnail = ResizeImage(
    MemoryImage(bytes),
    width: thumbnailWidth,
  );

  /// The colours to show in a palette of [size] colours.
  List<PhotoColor> colorsFor(int size) =>
      colors[size.clamp(sizes.first, sizes.last)] ?? const <PhotoColor>[];

  /// Drops the thumbnail from the image cache.
  void dispose() {
    unawaited(thumbnail.evict().then((_) {}, onError: (Object _) {}));
  }
}

/// Finds the dominant colours of a decoded photo for every palette size, in
/// one go. The page takes this as a seam so tests need no isolate; production
/// uses [extractPhotoColors].
typedef PhotoColorExtractor = Future<Map<int, List<PhotoColor>>> Function(
  SampledImage image,
);

/// The dominant colours of the pixels for each of [PhotoScene.sizes]: as many
/// colours as the palette shows, so a small vivid accent stays in a short one.
Map<int, List<PhotoColor>> extractPhotoColorSets(
  Uint8List rgba,
  int width,
  int height,
) => <int, List<PhotoColor>>{
  for (final int size in PhotoScene.sizes)
    size: extractDominantColors(rgba, width, height, count: size),
};

/// [PhotoColorExtractor] that clusters the pixels off the UI thread, once for
/// all the sizes.
Future<Map<int, List<PhotoColor>>> extractPhotoColors(SampledImage image) =>
    compute(
      _extractInIsolate,
      _PixelJob(image.rgba, image.width, image.height),
    );

class _PixelJob {
  const _PixelJob(this.rgba, this.width, this.height);
  final Uint8List rgba;
  final int width, height;
}

Map<int, List<PhotoColor>> _extractInIsolate(_PixelJob job) =>
    extractPhotoColorSets(job.rgba, job.width, job.height);

/// Asks where the photo comes from; resolves to the source, or `null` when
/// the sheet is dismissed.
Future<PhotoSource?> showPhotoSourceSheet(BuildContext context) =>
    showInkSheet<PhotoSource>(
      context: context,
      builder: (BuildContext context) => const _PhotoSourceSheet(),
    );

class _PhotoSourceSheet extends StatelessWidget {
  const _PhotoSourceSheet();

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations t = context.l10n;
    return Column(
      key: const ValueKey<String>('palette-photo-source-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Semantics(
            header: true,
            child: Text(
              t.paletteFromPhotoTitle,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.s4),
        Text(
          t.matchPrivacyCaption,
          style: AppTypography.secondary.copyWith(color: ink.fg2),
        ),
        const SizedBox(height: InkSpacing.block),
        PaletteChoiceRow(
          rowKey: const ValueKey<String>('palette-photo-camera'),
          glyph: const PaletteIconGlyph(InkIcons.camera),
          title: t.matchCameraButton,
          selected: false,
          onTap: () => Navigator.of(context).pop(PhotoSource.camera),
        ),
        PaletteChoiceRow(
          rowKey: const ValueKey<String>('palette-photo-gallery'),
          glyph: const PaletteIconGlyph(InkIcons.image),
          title: t.matchGalleryButton,
          selected: false,
          onTap: () => Navigator.of(context).pop(PhotoSource.gallery),
        ),
      ],
    );
  }
}

/// A small rounded thumbnail of the photo, in the size of the sheet glyphs.
class PhotoThumb extends StatelessWidget {
  const PhotoThumb({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: InkRadii.xsRadius,
        child: SizedBox.square(
          dimension: kPaletteGlyphSize,
          child: Image(
            image: image,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            errorBuilder: (BuildContext context, Object error, StackTrace? _) =>
                ColoredBox(color: ink.line),
          ),
        ),
      ),
    );
  }
}
