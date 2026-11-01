import 'collection_utils.dart';
import 'layout_rect.dart';
import 'models.dart';
import 'natural_sort.dart';

/// The markers of a swatch chart in natural code order (B2 before B10).
List<MarkerColor> chartMarkers(Iterable<MarkerColor> markers) => stableSorted(
  markers,
  (MarkerColor a, MarkerColor b) => naturalCodeComparator(a.newCode, b.newCode),
);

/// One empty box of the chart: the marker it is for, the label above it and
/// the box the user colours in.
final class SwatchChartSlot {
  const SwatchChartSlot({
    required this.markerIndex,
    required this.label,
    required this.box,
    required this.reference,
  });

  /// Index of the marker in the list that was paginated.
  final int markerIndex;

  /// Where the code and the name go, above the box.
  final LayoutRect label;

  /// The empty box.
  final LayoutRect box;

  /// The thin strip inside [box] that shows the catalogue colour, when asked.
  final LayoutRect reference;
}

/// One A4 page of the chart.
final class SwatchChartPage {
  const SwatchChartPage({
    required this.number,
    required this.count,
    required this.header,
    required this.footer,
    required this.slots,
  });

  /// 1-based page number.
  final int number;

  /// Pages in the whole chart.
  final int count;

  /// Where the brand and the page number go.
  final LayoutRect header;

  /// Where the small footer goes (inside the printing margin).
  final LayoutRect footer;
  final List<SwatchChartSlot> slots;
}

/// The geometry of the printable swatch chart: A4 portrait at 300 dpi
/// (2480 x 3508 px), a header with the brand and the page number, and a grid of
/// empty boxes, one per marker, filled left to right and top to bottom.
///
/// Pure Dart: the renderer in `ui/share/` only draws what this decides, and the
/// pagination is tested without any graphics.
final class SwatchChartLayout {
  const SwatchChartLayout({
    this.pageWidth = 2480,
    this.pageHeight = 3508,
    this.margin = 150,
    this.headerHeight = 220,
    this.footerHeight = 60,
    this.columns = 4,
    this.columnGap = 36,
    this.rowGap = 36,
    this.labelHeight = 96,
    this.labelGap = 14,
    this.boxHeight = 170,
    this.referenceHeight = 22,
    this.referenceInset = 10,
  });

  final double pageWidth, pageHeight;

  /// Blank border on every side, so a home printer does not cut the content.
  final double margin;
  final double headerHeight, footerHeight;
  final int columns;
  final double columnGap, rowGap;
  final double labelHeight, labelGap, boxHeight;
  final double referenceHeight, referenceInset;

  double get cellWidth =>
      (pageWidth - 2 * margin - (columns - 1) * columnGap) / columns;
  double get rowHeight => labelHeight + labelGap + boxHeight;
  double get gridTop => margin + headerHeight;
  double get gridBottom => pageHeight - margin - footerHeight;

  /// Rows that fit between the header and the footer.
  int get rows =>
      ((gridBottom - gridTop + rowGap) / (rowHeight + rowGap)).floor();

  /// Markers per page.
  int get perPage => columns * rows;

  /// Pages needed for [markerCount] markers (0 for none).
  int pageCount(int markerCount) =>
      markerCount <= 0 ? 0 : (markerCount + perPage - 1) ~/ perPage;

  /// The pages for [markerCount] markers, in order. Empty for none.
  List<SwatchChartPage> paginate(int markerCount) {
    final int pages = pageCount(markerCount);
    final LayoutRect header = LayoutRect(
      margin,
      margin,
      pageWidth - 2 * margin,
      headerHeight,
    );
    final LayoutRect footer = LayoutRect(
      margin,
      pageHeight - margin - footerHeight,
      pageWidth - 2 * margin,
      footerHeight,
    );
    return <SwatchChartPage>[
      for (int page = 0; page < pages; page++)
        SwatchChartPage(
          number: page + 1,
          count: pages,
          header: header,
          footer: footer,
          slots: <SwatchChartSlot>[
            for (
              int i = 0;
              i < perPage && page * perPage + i < markerCount;
              i++
            )
              _slot(page * perPage + i, i),
          ],
        ),
    ];
  }

  SwatchChartSlot _slot(int markerIndex, int indexOnPage) {
    final int column = indexOnPage % columns;
    final int row = indexOnPage ~/ columns;
    final double left = margin + column * (cellWidth + columnGap);
    final double top = gridTop + row * (rowHeight + rowGap);
    final LayoutRect box = LayoutRect(
      left,
      top + labelHeight + labelGap,
      cellWidth,
      boxHeight,
    );
    return SwatchChartSlot(
      markerIndex: markerIndex,
      label: LayoutRect(left, top, cellWidth, labelHeight),
      box: box,
      reference: LayoutRect(
        box.left + referenceInset,
        box.bottom - referenceInset - referenceHeight,
        box.width - 2 * referenceInset,
        referenceHeight,
      ),
    );
  }
}
