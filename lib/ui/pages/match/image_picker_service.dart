import 'dart:typed_data';

import 'package:flutter/services.dart' show PlatformException;
import 'package:image_picker/image_picker.dart';

/// Where a photo comes from.
enum PhotoSource {
  /// The device camera.
  camera,

  /// The device photo library.
  gallery,
}

/// The outcome of asking the user for a photo.
sealed class PhotoPickResult {
  const PhotoPickResult();
}

/// The user chose a photo; [bytes] are the encoded file contents.
final class PhotoPicked extends PhotoPickResult {
  const PhotoPicked(this.bytes);

  /// Encoded image bytes, ready for `dart:ui` to decode.
  final Uint8List bytes;
}

/// The user dismissed the camera or the library without choosing.
final class PhotoPickCancelled extends PhotoPickResult {
  const PhotoPickCancelled();
}

/// The app is not allowed to reach the camera or the photo library.
final class PhotoPickDenied extends PhotoPickResult {
  const PhotoPickDenied(this.source);

  /// Which source was refused.
  final PhotoSource source;
}

/// The picker failed for any other reason.
final class PhotoPickFailed extends PhotoPickResult {
  const PhotoPickFailed(this.message);

  /// Diagnostic detail; the page shows its own generic message.
  final String message;
}

/// Seam over the platform photo picker.
///
/// The page depends on this interface only, so tests can hand it a fake instead
/// of opening the camera or the gallery.
abstract interface class ImagePickerService {
  /// Asks the user for a photo from [source].
  Future<PhotoPickResult> pick(PhotoSource source);
}

/// [ImagePickerService] backed by `package:image_picker`.
///
/// Photos are read into memory on the device and never leave it: this service
/// performs no network access.
final class PlatformImagePickerService implements ImagePickerService {
  /// [imageQuality] is the JPEG quality (1 to 100) of what is picked: Match
  /// keeps 100 so colours stay true, the artwork diary lowers it to keep its
  /// private copies small.
  PlatformImagePickerService([ImagePicker? picker, this._imageQuality = 100])
    : _picker = picker ?? ImagePicker(),
      _maxSide = 2048;

  /// A picker for small private copies, like the photo of a real swatch: the
  /// picture is scaled so that neither side is over [maxSide] pixels and
  /// saved as a JPEG of [imageQuality].
  PlatformImagePickerService.limited({
    ImagePicker? picker,
    this._imageQuality = 85,
    this._maxSide = 1024,
  }) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;
  final int _imageQuality;
  final int _maxSide;

  @override
  Future<PhotoPickResult> pick(PhotoSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source == PhotoSource.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        // Cap the captured side at capture time; the decoder downscales again
        // before sampling, so this only keeps the intermediate file sane.
        maxWidth: _maxSide.toDouble(),
        maxHeight: _maxSide.toDouble(),
        imageQuality: _imageQuality,
        // No EXIF is needed, so iOS can use PHPicker without asking for
        // access to the whole photo library.
        requestFullMetadata: false,
      );
      if (file == null) return const PhotoPickCancelled();
      final Uint8List bytes = await file.readAsBytes();
      if (bytes.isEmpty) {
        return const PhotoPickFailed('the selected photo is empty');
      }
      return PhotoPicked(bytes);
    } on PlatformException catch (error) {
      if (_isPermissionError(error.code)) return PhotoPickDenied(source);
      return PhotoPickFailed(error.message ?? error.code);
    } catch (error) {
      return PhotoPickFailed('$error');
    }
  }

  /// `image_picker` reports a refused permission with a platform-specific code
  /// such as `camera_access_denied` or `photo_access_restricted`.
  static bool _isPermissionError(String code) {
    final String value = code.toLowerCase();
    return value.contains('denied') ||
        value.contains('restricted') ||
        value.contains('permission');
  }
}
