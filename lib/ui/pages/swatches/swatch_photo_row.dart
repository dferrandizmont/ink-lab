import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_sheet.dart';
import 'swatch_marker_row.dart' show swatchTextHeight;

/// What the user can do with the photo of the real swatch.
enum SwatchPhotoAction { take, choose, view, remove }

/// "Real swatch": the colour on the screen and the photo of the paper swatch
/// side by side in two squares of the same size, so the two can be compared at
/// a glance, with a title and what to do beside them.
///
/// Both squares are always there: without a photo the second one holds a
/// camera, so nothing moves when a photo is added or removed.
class SwatchPhotoRow extends StatelessWidget {
  const SwatchPhotoRow({
    super.key,
    required this.hex,
    required this.hasPhoto,
    required this.photo,
    required this.onTap,
    this.own = false,
  });

  /// The colour on the screen (the user's own colour when there is one).
  final String hex;

  /// Whether the marker has a photo (its bytes may still be loading).
  final bool hasPhoto;

  /// The bytes of the photo, once loaded.
  final Uint8List? photo;

  final VoidCallback? onTap;

  /// Whether [hex] is the user's own colour.
  final bool own;

  /// Side of each square.
  static const double slot = InkGeometry.target;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    return Semantics(
      button: true,
      excludeSemantics: true,
      label:
          '${l10n.swatchPhotoTitle}, '
          '${hasPhoto ? l10n.swatchPhotoHas : l10n.swatchPhotoEmpty}',
      child: InkWell(
        key: const ValueKey<String>('swatch-photo-row'),
        onTap: onTap,
        borderRadius: InkRadii.controlRadius,
        // The row is as high with a photo as without, whichever of the two
        // sentences is longer in the language and at the text size.
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double textWidth =
                constraints.maxWidth -
                (2 * slot +
                    InkSpacing.s4 +
                    InkSpacing.s12 +
                    InkSpacing.group +
                    InkGeometry.smallIcon);
            final double height =
                swatchTextHeight(
                  context,
                  l10n.swatchPhotoTitle,
                  AppTypography.body,
                  textWidth,
                ) +
                <String>[l10n.swatchPhotoEmpty, l10n.swatchPhotoHas]
                    .map(
                      (String t) => swatchTextHeight(
                        context,
                        t,
                        AppTypography.secondary,
                        textWidth,
                      ),
                    )
                    .reduce((double a, double b) => a > b ? a : b);
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height > InkGeometry.rowTall
                    ? height + InkSpacing.s8
                    : InkGeometry.rowTall,
              ),
              child: _row(context, ink, l10n),
            );
          },
        ),
      ),
    );
  }

  Widget _row(BuildContext context, InkColors ink, AppLocalizations l10n) {
    return Row(
      children: <Widget>[
        SwatchBlock(hex: hex, size: slot, radius: InkRadii.xs, own: own),
        const SizedBox(width: InkSpacing.s4),
        _PhotoSlot(photo: photo, hasPhoto: hasPhoto),
        const SizedBox(width: InkSpacing.s12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.swatchPhotoTitle,
                style: AppTypography.body.copyWith(color: ink.fg),
              ),
              Text(
                hasPhoto ? l10n.swatchPhotoHas : l10n.swatchPhotoEmpty,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
            ],
          ),
        ),
        const SizedBox(width: InkSpacing.group),
        InkIcon(
          InkIcons.chevronRight,
          size: InkGeometry.smallIcon,
          color: ink.fg2,
        ),
      ],
    );
  }
}

/// The square of the photo: the photo, or a camera on the surface colour.
class _PhotoSlot extends StatelessWidget {
  const _PhotoSlot({required this.photo, required this.hasPhoto});

  final Uint8List? photo;
  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Widget placeholder = Center(
      child: InkIcon(
        InkIcons.camera,
        size: InkGeometry.smallIcon,
        color: ink.fg2,
      ),
    );
    final Uint8List? bytes = photo;
    return SizedBox.square(
      key: const ValueKey<String>('swatch-photo-slot'),
      dimension: SwatchPhotoRow.slot,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ink.surface,
          borderRadius: InkRadii.xsRadius,
          border: Border.all(color: ink.line),
        ),
        child: ClipRRect(
          borderRadius: InkRadii.xsRadius,
          child: bytes == null || !hasPhoto
              ? placeholder
              : Image.memory(
                  bytes,
                  key: const ValueKey<String>('swatch-photo-image'),
                  fit: BoxFit.cover,
                  // The slot is small: do not decode a 1024 px photo for it.
                  cacheWidth: 128,
                  gaplessPlayback: true,
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? _,
                  ) => placeholder,
                ),
        ),
      ),
    );
  }
}

/// Asks what to do with the photo: take one, pick one, look at it or remove
/// it. `null` when the sheet is dismissed.
Future<SwatchPhotoAction?> showSwatchPhotoActions(
  BuildContext context, {
  required bool hasPhoto,
}) {
  return showInkSheet<SwatchPhotoAction>(
    context: context,
    builder: (BuildContext context) {
      final AppLocalizations l10n = context.l10n;
      void choose(SwatchPhotoAction action) =>
          Navigator.of(context).pop(action);
      return Column(
        key: const ValueKey<String>('swatch-photo-actions'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Room for the close button of the frame.
          Padding(
            padding: const EdgeInsets.only(
              right: InkSpacing.sheetCloseClearance + InkGeometry.target,
            ),
            child: Semantics(
              header: true,
              child: Text(
                l10n.swatchPhotoTitle,
                style: AppTypography.section.copyWith(
                  color: InkColors.of(context).fg,
                ),
              ),
            ),
          ),
          const SizedBox(height: InkSpacing.block),
          InkButton(
            key: const ValueKey<String>('swatch-photo-take'),
            label: l10n.swatchPhotoTake,
            icon: InkIcons.camera,
            expand: true,
            onPressed: () => choose(SwatchPhotoAction.take),
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          InkButton.secondary(
            key: const ValueKey<String>('swatch-photo-choose'),
            label: l10n.swatchPhotoChoose,
            icon: InkIcons.image,
            expand: true,
            onPressed: () => choose(SwatchPhotoAction.choose),
          ),
          if (hasPhoto) ...<Widget>[
            const SizedBox(height: InkSpacing.buttonGap),
            InkButton.secondary(
              key: const ValueKey<String>('swatch-photo-view'),
              label: l10n.swatchPhotoView,
              icon: InkIcons.eye,
              expand: true,
              onPressed: () => choose(SwatchPhotoAction.view),
            ),
            const SizedBox(height: InkSpacing.buttonGap),
            InkButton.text(
              key: const ValueKey<String>('swatch-photo-remove'),
              label: l10n.diaryPhotoRemove,
              icon: InkIcons.trash2,
              expand: true,
              onPressed: () => choose(SwatchPhotoAction.remove),
            ),
          ],
        ],
      );
    },
  );
}

/// Shows the photo large, on a dialog the user closes with a tap.
Future<void> showSwatchPhotoViewer(BuildContext context, Uint8List bytes) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => Dialog(
      key: const ValueKey<String>('swatch-photo-viewer'),
      insetPadding: const EdgeInsets.all(InkSpacing.block),
      child: Padding(
        padding: const EdgeInsets.all(InkSpacing.group),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: ClipRRect(
                borderRadius: InkRadii.controlRadius,
                child: Image.memory(bytes, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: InkSpacing.group),
            InkButton.text(
              label: context.l10n.commonClose,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
  );
}
