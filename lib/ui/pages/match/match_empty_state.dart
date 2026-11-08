import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';

/// What Match shows before a photo is chosen: one line about what it does and
/// two equal, full-width actions, "Take a photo" and "Choose from gallery".
///
/// It is the app's standard [EmptyState] with two actions. It sits in the slot
/// where the photo and its row of buttons go once a photo is loaded, so taking
/// a photo replaces it in place: the header above and the page below it do
/// not change. The buttons keep the keys of the camera and gallery buttons of
/// the page (`match-camera`, `match-gallery`), and a `null` callback disables
/// both while a photo is being read.
class MatchEmptyState extends StatelessWidget {
  const MatchEmptyState({
    super.key,
    required this.onCamera,
    required this.onGallery,
  });

  /// Opens the camera; `null` disables the button.
  final VoidCallback? onCamera;

  /// Opens the gallery; `null` disables the button.
  final VoidCallback? onGallery;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      key: const ValueKey<String>('match-empty'),
      icon: InkIcons.image,
      title: context.l10n.matchEmptyPhotoTitle,
      message: context.l10n.matchEmptyPhotoMessage,
      actions: <Widget>[
        InkButton.secondary(
          key: const ValueKey<String>('match-camera'),
          label: context.l10n.matchTakePhotoButton,
          icon: InkIcons.camera,
          expand: true,
          onPressed: onCamera,
        ),
        InkButton.secondary(
          key: const ValueKey<String>('match-gallery'),
          label: context.l10n.matchChooseGalleryButton,
          icon: InkIcons.image,
          expand: true,
          onPressed: onGallery,
        ),
      ],
    );
  }
}
