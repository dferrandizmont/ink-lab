import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

import '../../core/layout_rect.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import '../widgets/color_swatch_tile.dart' show swatchColor;
import 'diary_entry_card_layout.dart';
import 'image_painting.dart';
import 'palette_card_renderer.dart' show shareFooterText;

/// How much of the overflow of a tall photo is cut from its top: 0.4 keeps a
/// little more of the top, where the subject usually is.
const double _photoFocusY = 0.4;

/// Draws [data] as a PNG, 1080 px wide, always with the light theme so it reads
/// the same wherever it is opened. Same width, background and type as the
/// palette image.
///
/// The photo, if any, is decoded here at the size the box needs and released
/// when the image is done; nothing is kept.
Future<Uint8List> renderDiaryEntryCard(DiaryEntryCardData data) async {
  final ui.Image? photo = await _decodeCover(
    data.photo,
    DiaryEntryCardLayout.contentWidth,
    DiaryEntryCardLayout.photoHeight,
  );
  try {
    final DiaryEntryCardLayout layout = diaryEntryLayoutFor(
      data,
      hasPhoto: photo != null,
    );
    return await renderPng(
      width: DiaryEntryCardLayout.width.round(),
      height: layout.height.round(),
      paint: (Canvas canvas) =>
          paintDiaryEntryCard(canvas, data, layout, photo: photo),
    );
  } finally {
    photo?.dispose();
  }
}

/// The layout [data] needs. [hasPhoto] says whether its photo was decoded.
DiaryEntryCardLayout diaryEntryLayoutFor(
  DiaryEntryCardData data, {
  required bool hasPhoto,
}) {
  final TextPainter title = _titlePainter(data.title);
  final int lines = title.computeLineMetrics().length;
  title.dispose();
  return DiaryEntryCardLayout(
    titleLines: lines,
    hasOnWhat: data.onWhat.trim().isNotEmpty,
    hasPhoto: hasPhoto,
    markerCount: data.markers.length,
    hasMore: data.moreMarkers > 0 && data.moreText.isNotEmpty,
    paletteColors: data.paletteHexes.length,
  );
}

TextPainter _titlePainter(String title) {
  const InkColors ink = InkColors.light;
  return TextPainter(
    text: TextSpan(
      text: title.trim(),
      style: sizedStyle(AppTypography.title, 64, ink.fg).copyWith(height: 1.25),
    ),
    textDirection: TextDirection.ltr,
    textScaler: TextScaler.noScaling,
    maxLines: 2,
    ellipsis: '…',
  )..layout(maxWidth: DiaryEntryCardLayout.contentWidth);
}

/// Paints the diary card on [canvas] following [layout]. [photo] is the
/// already decoded photo; it is drawn cropped to fill its box.
void paintDiaryEntryCard(
  Canvas canvas,
  DiaryEntryCardData data,
  DiaryEntryCardLayout layout, {
  ui.Image? photo,
}) {
  const InkColors ink = InkColors.light;
  canvas.drawRect(
    Rect.fromLTWH(0, 0, DiaryEntryCardLayout.width, layout.height),
    Paint()..color = ink.bg,
  );

  drawFitted(
    canvas,
    AppTypography.caps(data.meta),
    sizedStyle(AppTypography.capsStyle, 28, ink.fg2),
    layout.meta,
  );

  final TextPainter title = _titlePainter(data.title);
  title.paint(
    canvas,
    Offset(
      layout.title.left,
      layout.title.top + (layout.title.height - title.height) / 2,
    ),
  );
  title.dispose();

  final LayoutRect? onWhat = layout.onWhat;
  if (onWhat != null) {
    drawFitted(
      canvas,
      data.onWhat.trim(),
      sizedStyle(AppTypography.secondary, 34, ink.fg2),
      onWhat,
    );
  }

  final LayoutRect? photoBox = layout.photo;
  if (photoBox != null && photo != null) _paintPhoto(canvas, photo, photoBox);

  final LayoutRect? markersHeading = layout.markersHeading;
  if (markersHeading != null) {
    drawFitted(
      canvas,
      AppTypography.caps(data.markersLabel),
      sizedStyle(AppTypography.capsStyle, 26, ink.fg2),
      markersHeading,
    );
    for (int i = 0; i < layout.markerSlots.length; i++) {
      final DiaryEntryCardMarker marker = data.markers[i];
      final DiaryEntryCardMarkerSlot slot = layout.markerSlots[i];
      drawSwatch(canvas, slot.swatch.rect, swatchColor(marker.hex));
      final LayoutRect text = slot.text;
      const double codeHeight = 46, nameHeight = 36;
      final double top = text.top + (text.height - codeHeight - nameHeight) / 2;
      drawFitted(
        canvas,
        marker.code,
        sizedStyle(AppTypography.code, 40, ink.fg),
        LayoutRect(text.left, top, text.width, codeHeight),
      );
      drawFitted(
        canvas,
        marker.name,
        sizedStyle(AppTypography.secondary, 28, ink.fg2),
        LayoutRect(text.left, top + codeHeight, text.width, nameHeight),
        minScale: 0.7,
      );
    }
    final LayoutRect? more = layout.more;
    if (more != null) {
      drawFitted(
        canvas,
        data.moreText,
        sizedStyle(AppTypography.secondary, 30, ink.fg2),
        more,
      );
    }
  }

  final LayoutRect? paletteHeading = layout.paletteHeading;
  if (paletteHeading != null) {
    drawFitted(
      canvas,
      AppTypography.caps(data.paletteLabel),
      sizedStyle(AppTypography.capsStyle, 26, ink.fg2),
      paletteHeading,
    );
    drawFitted(
      canvas,
      data.paletteName,
      sizedStyle(AppTypography.body, 34, ink.fg),
      layout.paletteName!,
    );
    for (int i = 0; i < layout.paletteStrip.length; i++) {
      drawSwatch(
        canvas,
        layout.paletteStrip[i].rect,
        swatchColor(data.paletteHexes[i]),
      );
    }
  }

  drawFitted(
    canvas,
    shareFooterText,
    sizedStyle(AppTypography.sheetTitle, 30, ink.fg2),
    layout.footer,
  );
}

/// Draws [image] filling [box]: scaled to cover, the overflow cropped, with
/// rounded corners and the light-theme hairline.
void _paintPhoto(Canvas canvas, ui.Image image, LayoutRect box) {
  const InkColors ink = InkColors.light;
  final Rect dst = box.rect;
  final double imageW = image.width.toDouble();
  final double imageH = image.height.toDouble();
  final double boxAspect = dst.width / dst.height;
  final Rect src;
  if (imageW / imageH > boxAspect) {
    final double w = imageH * boxAspect;
    src = Rect.fromLTWH((imageW - w) / 2, 0, w, imageH);
  } else {
    final double h = imageW / boxAspect;
    src = Rect.fromLTWH(0, (imageH - h) * _photoFocusY, imageW, h);
  }
  final RRect rounded = RRect.fromRectAndRadius(dst, const Radius.circular(24));
  canvas.save();
  canvas.clipRRect(rounded);
  canvas.drawImageRect(
    image,
    src,
    dst,
    Paint()..filterQuality = FilterQuality.medium,
  );
  canvas.restore();
  canvas.drawRRect(
    rounded.deflate(1),
    Paint()
      ..color = ink.line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2,
  );
}

/// Decodes [bytes] no bigger than a [boxWidth] x [boxHeight] cover needs, or
/// returns `null` when there are no bytes or they are not an image.
Future<ui.Image?> _decodeCover(
  Uint8List? bytes,
  double boxWidth,
  double boxHeight,
) async {
  if (bytes == null || bytes.isEmpty) return null;
  ui.ImmutableBuffer? buffer;
  ui.ImageDescriptor? descriptor;
  ui.Codec? codec;
  try {
    buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    descriptor = await ui.ImageDescriptor.encoded(buffer);
    final double scale = math.max(
      boxWidth / descriptor.width,
      boxHeight / descriptor.height,
    );
    codec = await descriptor.instantiateCodec(
      targetWidth: scale < 1 ? (descriptor.width * scale).ceil() : null,
    );
    final ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  } catch (_) {
    return null;
  } finally {
    codec?.dispose();
    descriptor?.dispose();
    buffer?.dispose();
  }
}
