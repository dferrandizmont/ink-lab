import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

/// Decodes encoded photo bytes into raw pixels.
///
/// The page takes this as a seam so tests can hand it a fixed image instead of
/// decoding a real file. Production uses [decodePhoto].
typedef PhotoDecoder = Future<SampledImage> Function(Uint8List bytes);

/// Largest side, in pixels, a photo is decoded to before sampling.
///
/// Downscaling first keeps the pixel buffer small (memory and the per-pixel
/// average stay cheap) while keeping far more detail than a loupe needs.
const int defaultMaxDimension = 720;

/// Radius of the sampled region, as a fraction of the image's shorter side.
const double defaultSamplingRadiusFraction = 0.02;

/// A decoded photo reduced to its raw, opaque RGBA pixels.
///
/// Sampling and the loupe work on this buffer only, so no `ui.Image` (and no
/// extra decoding) is needed once the photo has been read.
final class SampledImage {
  SampledImage({required this.width, required this.height, required this.rgba})
    : assert(width > 0, 'width must be positive'),
      assert(height > 0, 'height must be positive'),
      assert(
        rgba.length >= width * height * 4,
        'rgba must hold four bytes per pixel',
      );

  /// Width, in pixels.
  final int width;

  /// Height, in pixels.
  final int height;

  /// Raw pixels, four bytes (red, green, blue, alpha) per pixel, row-major.
  final Uint8List rgba;

  /// Width divided by height.
  double get aspectRatio => width / height;

  /// Number of pixels in the buffer.
  int get pixelCount => width * height;

  /// The opaque ARGB colour of the pixel at ([x], [y]).
  int pixelAt(int x, int y) {
    final int index = (y * width + x) * 4;
    return 0xff000000 |
        (rgba[index] << 16) |
        (rgba[index + 1] << 8) |
        rgba[index + 2];
  }
}

/// Raised when encoded bytes cannot be turned into pixels.
final class PhotoDecodeException implements Exception {
  const PhotoDecodeException(this.message);

  /// What went wrong, for logging; never shown raw to the user.
  final String message;

  @override
  String toString() => 'PhotoDecodeException: $message';
}

/// Decodes [bytes] into a [SampledImage], downscaling to at most [maxDimension].
///
/// Throws [PhotoDecodeException] when the bytes are empty or not a readable
/// image. Uses `dart:ui` only, so no image package is needed.
Future<SampledImage> decodePhoto(
  Uint8List bytes, {
  int maxDimension = defaultMaxDimension,
}) async {
  if (bytes.isEmpty) {
    throw const PhotoDecodeException('the photo is empty');
  }
  ui.ImmutableBuffer? buffer;
  ui.ImageDescriptor? descriptor;
  ui.Codec? codec;
  try {
    buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    descriptor = await ui.ImageDescriptor.encoded(buffer);
    final int longest = math.max(descriptor.width, descriptor.height);
    final double scale = maxDimension > 0 && longest > maxDimension
        ? maxDimension / longest
        : 1;
    codec = await descriptor.instantiateCodec(
      targetWidth: math.max(1, (descriptor.width * scale).round()),
      targetHeight: math.max(1, (descriptor.height * scale).round()),
    );
    final ui.FrameInfo frame = await codec.getNextFrame();
    final ui.Image image = frame.image;
    try {
      final ByteData? data = await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      if (data == null) {
        throw const PhotoDecodeException('the photo has no readable pixels');
      }
      return SampledImage(
        width: image.width,
        height: image.height,
        rgba: data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
    } finally {
      image.dispose();
    }
  } on PhotoDecodeException {
    rethrow;
  } catch (error) {
    throw PhotoDecodeException('$error');
  } finally {
    codec?.dispose();
    descriptor?.dispose();
    buffer?.dispose();
  }
}

/// The average opaque colour of the square region of [image] around [centre].
///
/// [centre] is a fraction of the image ([0, 1] on each axis), so it maps to the
/// same spot regardless of how the photo is laid out on screen. The region is
/// clamped to the image, and its radius is [radiusFraction] of the shorter side
/// (at least one pixel).
int averageColorOfRegion(
  SampledImage image,
  ui.Offset centre, {
  double radiusFraction = defaultSamplingRadiusFraction,
}) {
  final int centreX = (centre.dx * image.width).round().clamp(
    0,
    image.width - 1,
  );
  final int centreY = (centre.dy * image.height).round().clamp(
    0,
    image.height - 1,
  );
  final int radius = math.max(
    1,
    (radiusFraction * math.min(image.width, image.height)).round(),
  );
  var red = 0;
  var green = 0;
  var blue = 0;
  var count = 0;
  for (var y = centreY - radius; y <= centreY + radius; y++) {
    if (y < 0 || y >= image.height) continue;
    for (var x = centreX - radius; x <= centreX + radius; x++) {
      if (x < 0 || x >= image.width) continue;
      final int index = (y * image.width + x) * 4;
      red += image.rgba[index];
      green += image.rgba[index + 1];
      blue += image.rgba[index + 2];
      count++;
    }
  }
  if (count == 0) return 0xff000000;
  return 0xff000000 |
      ((red ~/ count) << 16) |
      ((green ~/ count) << 8) |
      (blue ~/ count);
}

/// The rectangle an image of [aspectRatio] occupies inside [container] when it
/// is painted with `BoxFit.contain`: centred, scaled to touch one axis.
///
/// Returns [ui.Rect.zero] for a degenerate container or ratio.
ui.Rect containRect(ui.Size container, double aspectRatio) {
  if (container.width <= 0 ||
      container.height <= 0 ||
      aspectRatio <= 0 ||
      !aspectRatio.isFinite) {
    return ui.Rect.zero;
  }
  final double containerAspect = container.width / container.height;
  final double width = aspectRatio > containerAspect
      ? container.width
      : container.height * aspectRatio;
  final double height = aspectRatio > containerAspect
      ? container.width / aspectRatio
      : container.height;
  return ui.Rect.fromLTWH(
    (container.width - width) / 2,
    (container.height - height) / 2,
    width,
    height,
  );
}

/// Where [point] falls inside [fitted], as a fraction of each axis in [0, 1].
///
/// Points outside the fitted image are clamped to its nearest edge, so a drag
/// that leaves the photo keeps sampling the border instead of jumping.
ui.Offset fractionForPoint(ui.Offset point, ui.Rect fitted) {
  if (fitted.width <= 0 || fitted.height <= 0) return ui.Offset.zero;
  return ui.Offset(
    ((point.dx - fitted.left) / fitted.width).clamp(0.0, 1.0),
    ((point.dy - fitted.top) / fitted.height).clamp(0.0, 1.0),
  );
}
