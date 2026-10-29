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
  PlatformImagePickerService([ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<PhotoPickResult> pick(PhotoSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source == PhotoSource.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        // Cap the captured side at capture time; the decoder downscales again
        // before sampling, so this only keeps the intermediate file sane.
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 100,
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
