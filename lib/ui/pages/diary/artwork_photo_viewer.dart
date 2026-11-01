import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';

/// The photos of an entry at full screen: swipe between them, pinch to zoom,
/// close with the button or the back gesture. The photos are already in
/// memory (read from the private folder, or just picked); nothing is fetched.
class ArtworkPhotoViewer extends StatefulWidget {
  const ArtworkPhotoViewer({
    super.key,
    required this.photos,
    this.initialIndex = 0,
  });

  /// Key of the page, handy for tests.
  static const Key pageKey = Key('diary-photo-viewer');

  final List<Uint8List> photos;
  final int initialIndex;

  /// Opens the viewer on top of the current page.
  static Future<void> open(
    BuildContext context, {
    required List<Uint8List> photos,
    int initialIndex = 0,
  }) {
    if (photos.isEmpty) return Future<void>.value();
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) =>
            ArtworkPhotoViewer(photos: photos, initialIndex: initialIndex),
      ),
    );
  }

  @override
  State<ArtworkPhotoViewer> createState() => _ArtworkPhotoViewerState();
}

class _ArtworkPhotoViewerState extends State<ArtworkPhotoViewer> {
  late final PageController _controller = PageController(
    initialPage: widget.initialIndex.clamp(0, widget.photos.length - 1),
  );
  late int _index = widget.initialIndex.clamp(0, widget.photos.length - 1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int total = widget.photos.length;
    final String position = context.l10n.diaryPhotoSemantic(_index + 1, total);
    return Scaffold(
      key: ArtworkPhotoViewer.pageKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _controller,
              itemCount: total,
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (BuildContext context, int index) =>
                  InteractiveViewer(
                    maxScale: 5,
                    child: Center(
                      child: Image.memory(
                        widget.photos[index],
                        fit: BoxFit.contain,
                        semanticLabel: context.l10n.diaryPhotoSemantic(
                          index + 1,
                          total,
                        ),
                      ),
                    ),
                  ),
            ),
            Positioned(
              top: InkSpacing.s8,
              right: InkSpacing.s8,
              child: InkIconButton(
                key: const ValueKey<String>('diary-photo-close'),
                icon: InkIcons.x,
                tooltip: context.l10n.commonClose,
                color: Colors.white,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
            if (total > 1)
              Positioned(
                left: 0,
                right: 0,
                bottom: InkSpacing.block,
                child: Center(
                  child: Text(
                    position,
                    key: const ValueKey<String>('diary-photo-position'),
                    style: AppTypography.data.copyWith(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
