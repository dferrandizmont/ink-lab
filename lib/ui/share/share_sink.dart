import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

/// One PNG image to hand to the system share sheet.
final class ShareImage {
  const ShareImage({required this.bytes, required this.name});

  /// The encoded PNG.
  final Uint8List bytes;

  /// File name the receiving app sees ("ink-lab-palette.png").
  final String name;
}

/// Where a rendered image goes: the system share sheet in the app, a fake in
/// tests. Nothing leaves the phone unless the user picks an app in that sheet.
abstract interface class ShareSink {
  /// Opens the share sheet with [images]; completes when it closes.
  Future<void> shareImages(List<ShareImage> images, {String? subject});
}

/// The system share sheet, through `share_plus`. The images are handed over as
/// in-memory data (`XFile.fromData`); the plugin stages them in the app's
/// cache folder only for the receiving app to read.
final class SystemShareSink implements ShareSink {
  const SystemShareSink();

  @override
  Future<void> shareImages(List<ShareImage> images, {String? subject}) async {
    if (images.isEmpty) return;
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[
          for (final ShareImage image in images)
            XFile.fromData(
              image.bytes,
              mimeType: 'image/png',
              name: image.name,
            ),
        ],
        fileNameOverrides: <String>[
          for (final ShareImage image in images) image.name,
        ],
        subject: subject,
      ),
    );
  }
}
