import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

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

  /// Opens the share sheet with [text] as plain text, to paste into a chat or
  /// a note; completes when it closes.
  Future<void> shareText(String text, {String? subject});

  /// Opens the share sheet with [text] as a plain-text file called [name];
  /// completes when it closes.
  Future<void> shareTextFile(
    String text, {
    required String name,
    String? subject,
  });
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
        sharePositionOrigin: systemShareOrigin(),
      ),
    );
  }

  @override
  Future<void> shareText(String text, {String? subject}) async {
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: subject,
        sharePositionOrigin: systemShareOrigin(),
      ),
    );
  }

  @override
  Future<void> shareTextFile(
    String text, {
    required String name,
    String? subject,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[
          XFile.fromData(
            Uint8List.fromList(utf8.encode(text)),
            mimeType: 'text/plain',
            name: name,
          ),
        ],
        fileNameOverrides: <String>[name],
        subject: subject,
        sharePositionOrigin: systemShareOrigin(),
      ),
    );
  }
}

/// Where the system share sheet points from. On iPad and Mac the sheet is a
/// popover and needs a non-empty rect or it closes at once; phones ignore it.
/// The bottom centre of the window stands in for the tapped button.
Rect systemShareOrigin() {
  final PlatformDispatcher dispatcher = PlatformDispatcher.instance;
  final FlutterView? view =
      dispatcher.implicitView ?? dispatcher.views.firstOrNull;
  if (view == null) return const Rect.fromLTWH(0, 0, 1, 1);
  final Size size = view.physicalSize / view.devicePixelRatio;
  return Rect.fromLTWH(size.width / 2, size.height - 1, 1, 1);
}
