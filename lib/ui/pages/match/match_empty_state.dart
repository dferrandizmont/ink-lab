import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import 'match_example.dart';

/// What Match shows before a photo is chosen: a small example photo with its
/// sample point and the marker it matches, one line about what Match does and
/// three equal, full-width actions: "Take a photo", "Choose from gallery" and
/// "Try an example photo".
///
/// It is the app's standard [EmptyState] with three actions, and the example
/// takes the place of its icon. It sits in the slot
/// where the photo and its row of buttons go once a photo is loaded, so taking
/// a photo replaces it in place: the header above and the page below it do
/// not change. The buttons keep the keys of the camera and gallery buttons of
/// the page (`match-camera`, `match-gallery`) and the third is `match-example`;
/// a `null` callback disables each of them while a photo is being read, and
/// the preview with the example button.
class MatchEmptyState extends StatelessWidget {
  const MatchEmptyState({
    super.key,
    required this.onCamera,
    required this.onGallery,
    required this.onExample,
    required this.example,
  });

  /// Opens the camera; `null` disables the button.
  final VoidCallback? onCamera;

  /// Opens the gallery; `null` disables the button.
  final VoidCallback? onGallery;

  /// Loads the example photo, already sampled; `null` disables the button and
  /// the preview.
  final VoidCallback? onExample;

  /// The example photo and its match, or `null` while it is being read.
  final MatchExample? example;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      key: const ValueKey<String>('match-empty'),
      icon: InkIcons.image,
      leading: MatchExamplePreview(
        key: const ValueKey<String>('match-example-preview'),
        example: example,
        onTap: onExample,
      ),
      title: context.l10n.matchEmptyPhotoTitle,
      message: context.l10n.matchEmptyPhotoMessage,
      actions: <Widget>[
        InkButton.secondary(
          key: const ValueKey<String>('match-camera'),
          label: context.l10n.matchTakePhotoButton,
          icon: InkIcons.camera,
          expand: true,
          // A long label wraps at a large text size instead of being cut.
          maxLines: null,
          onPressed: onCamera,
        ),
        InkButton.secondary(
          key: const ValueKey<String>('match-gallery'),
          label: context.l10n.matchChooseGalleryButton,
          icon: InkIcons.image,
          expand: true,
          // A long label wraps at a large text size instead of being cut.
          maxLines: null,
          onPressed: onGallery,
        ),
        InkButton.secondary(
          key: const ValueKey<String>('match-example'),
          label: context.l10n.matchExampleButton,
          icon: InkIcons.crosshair,
          expand: true,
          // A long label wraps at a large text size instead of being cut.
          maxLines: null,
          onPressed: onExample,
        ),
      ],
    );
  }
}
