import 'dart:typed_data';

import 'package:ink_lab/ui/share/share_sink.dart';

/// A [ShareSink] that records what would have gone to the share sheet.
class FakeShareSink implements ShareSink {
  FakeShareSink({this.fail = false});

  /// Throws instead of sharing, to test the error notice.
  final bool fail;

  /// One entry per call: the images handed to the sheet.
  final List<List<ShareImage>> shared = <List<ShareImage>>[];
  final List<String?> subjects = <String?>[];

  @override
  Future<void> shareImages(List<ShareImage> images, {String? subject}) async {
    if (fail) throw StateError('no share sheet');
    shared.add(images);
    subjects.add(subject);
  }
}

/// Width and height of a PNG, read from its IHDR chunk; `null` if [bytes] is
/// not a PNG.
({int width, int height})? pngSize(Uint8List bytes) {
  const List<int> signature = <int>[137, 80, 78, 71, 13, 10, 26, 10];
  if (bytes.length < 24) return null;
  for (int i = 0; i < signature.length; i++) {
    if (bytes[i] != signature[i]) return null;
  }
  final ByteData data = ByteData.sublistView(bytes);
  return (width: data.getUint32(16), height: data.getUint32(20));
}
