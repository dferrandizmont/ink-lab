import 'dart:typed_data';

import '../../core/layout_rect.dart';

/// One marker of a shared diary image: the texts under its swatch.
final class DiaryEntryCardMarker {
  const DiaryEntryCardMarker({
    required this.code,
    required this.name,
    required this.hex,
  });

  final String code, name, hex;
}

/// What a shared diary entry image says, ready to draw and already localised.
final class DiaryEntryCardData {
  const DiaryEntryCardData({
    required this.title,
    required this.meta,
    this.onWhat = '',
    this.photo,
    this.markers = const <DiaryEntryCardMarker>[],
    this.moreMarkers = 0,
    this.moreText = '',
    this.markersLabel = '',
    this.paletteLabel = '',
    this.paletteName = '',
    this.paletteHexes = const <String>[],
  });

  /// The title of the entry, big.
  final String title;

  /// "30 Oct 2026 · Finished", above the title.
  final String meta;

  /// What it was painted on; empty draws nothing.
  final String onWhat;

  /// The first photo of the entry as it was picked (any size); `null` or bytes
  /// that cannot be decoded leave the photo out.
  final Uint8List? photo;

  /// The markers drawn, at most [DiaryEntryCardLayout.maxMarkers].
  final List<DiaryEntryCardMarker> markers;

  /// How many more markers the entry has than [markers] shows.
  final int moreMarkers;

  /// "+3 more", under the markers when [moreMarkers] is above zero.
  final String moreText;

  /// "Markers used", the heading of the marker block.
  final String markersLabel;

  /// "Palette", the heading of the palette block.
  final String paletteLabel;

  /// The name of the linked palette.
  final String paletteName;

  /// The colours of the linked palette, in order.
  final List<String> paletteHexes;
}

/// One marker of the card: its swatch and the text column beside it.
final class DiaryEntryCardMarkerSlot {
  const DiaryEntryCardMarkerSlot({required this.swatch, required this.text});

  final LayoutRect swatch, text;
}

/// The geometry of a shared diary entry image: 1080 px wide like the palette
/// image, with a date line, the title (one or two lines), what it was painted
/// on, the first photo, the markers in two columns, the palette as a strip of
/// colours and the footer. The height follows what the entry has.
///
/// Pure Dart so it can be tested without a renderer.
final class DiaryEntryCardLayout {
  DiaryEntryCardLayout({
    required int titleLines,
    required bool hasOnWhat,
    required bool hasPhoto,
    required int markerCount,
    required bool hasMore,
    required int paletteColors,
  }) : titleLines = titleLines < 1 ? 1 : (titleLines > 2 ? 2 : titleLines),
       markerCount = markerCount < 0
           ? 0
           : (markerCount > maxMarkers ? maxMarkers : markerCount),
       paletteColors = paletteColors < 0 ? 0 : paletteColors {
    double y = margin;
    meta = LayoutRect(margin, y, contentWidth, metaHeight);
    y += metaHeight + 12;
    title = LayoutRect(margin, y, contentWidth, this.titleLines * titleLine);
    y = title.bottom;
    if (hasOnWhat) {
      y += 8;
      onWhat = LayoutRect(margin, y, contentWidth, onWhatHeight);
      y = onWhat!.bottom;
    }
    y += blockGap;
    if (hasPhoto) {
      photo = LayoutRect(margin, y, contentWidth, photoHeight);
      y = photo!.bottom + blockGap;
    }
    if (this.markerCount > 0) {
      markersHeading = LayoutRect(margin, y, contentWidth, headingHeight);
      y = markersHeading!.bottom + 16;
      final List<DiaryEntryCardMarkerSlot> slots = <DiaryEntryCardMarkerSlot>[];
      for (int i = 0; i < this.markerCount; i++) {
        final double left = margin + (i % 2) * (columnWidth + columnGap);
        final double top = y + (i ~/ 2) * (markerRow + markerGap);
        slots.add(
          DiaryEntryCardMarkerSlot(
            swatch: LayoutRect(
              left,
              top + (markerRow - markerSwatch) / 2,
              markerSwatch,
              markerSwatch,
            ),
            text: LayoutRect(
              left + markerSwatch + 20,
              top,
              columnWidth - markerSwatch - 20,
              markerRow,
            ),
          ),
        );
      }
      markerSlots = slots;
      final int rows = (this.markerCount + 1) ~/ 2;
      y += rows * (markerRow + markerGap) - markerGap;
      if (hasMore) {
        y += 16;
        more = LayoutRect(margin, y, contentWidth, moreHeight);
        y = more!.bottom;
      }
      y += blockGap;
    }
    if (this.paletteColors > 0) {
      paletteHeading = LayoutRect(margin, y, contentWidth, headingHeight);
      y = paletteHeading!.bottom + 8;
      paletteName = LayoutRect(margin, y, contentWidth, paletteNameHeight);
      y = paletteName!.bottom + 16;
      final int n = this.paletteColors;
      final double box = (contentWidth - (n - 1) * paletteGap) / n;
      paletteStrip = <LayoutRect>[
        for (int i = 0; i < n; i++)
          LayoutRect(margin + i * (box + paletteGap), y, box, paletteHeight),
      ];
      y += paletteHeight + blockGap;
    }
    // [blockGap] already closed the last block; the footer follows the same
    // gap as the palette image.
    y += footerGap - blockGap;
    footer = LayoutRect(margin, y, contentWidth, footerHeight);
    height = footer.bottom + margin;
  }

  static const double width = 1080;
  static const double margin = 72;
  static const double contentWidth = width - 2 * margin;
  static const double metaHeight = 40;
  static const double titleLine = 80;
  static const double onWhatHeight = 48;
  static const double photoHeight = 624;
  static const double headingHeight = 40;
  static const double markerRow = 88;
  static const double markerGap = 16;
  static const double markerSwatch = 72;
  static const double columnGap = 36;
  static const double columnWidth = (contentWidth - columnGap) / 2;
  static const double moreHeight = 44;
  static const double paletteNameHeight = 44;
  static const double paletteHeight = 120;
  static const double paletteGap = 12;
  static const double blockGap = 48;
  static const double footerGap = 48;
  static const double footerHeight = 56;

  /// Markers drawn; an entry with more says "+N more".
  static const int maxMarkers = 12;

  final int titleLines;
  final int markerCount;
  final int paletteColors;

  late final double height;
  late final LayoutRect meta, title, footer;
  LayoutRect? onWhat, photo, markersHeading, more;
  LayoutRect? paletteHeading, paletteName;
  List<DiaryEntryCardMarkerSlot> markerSlots =
      const <DiaryEntryCardMarkerSlot>[];
  List<LayoutRect> paletteStrip = const <LayoutRect>[];
}
