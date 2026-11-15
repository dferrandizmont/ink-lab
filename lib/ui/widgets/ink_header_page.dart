import 'package:flutter/material.dart';

import 'ink_adaptive.dart';

/// A page made of a header (title, search, chips) and a scrolling list.
///
/// On a tall window the header sits above the scroll view, as it always did.
/// On a short one ([InkLayout.isShortPage]: a phone in landscape, a split
/// screen) it goes inside the scroll view as its first row and scrolls away
/// with the content, so the list gets the room.
///
/// The header lives under [headerKey], a [GlobalKey] the page's state owns.
/// Moving between the two places is a reparenting in one frame: the header
/// keeps its state, so the search field keeps its text and its focus (a
/// rotation while the user types does not close the keyboard). The scroll
/// view is in the same place of the tree at every size, so it keeps its
/// scroll position, and its first sliver is always there (empty on a tall
/// window), so the slivers after it keep their elements.
///
/// The scroll view takes the primary scroll controller, like any page (so a
/// tap on the iOS status bar scrolls it to the top, and a list that fits
/// still bounces). A page reaches its position through [slotKey], the key of
/// the permanent first row (see [inkPageScroll] and [jumpToContentTop]).
class InkHeaderPage extends StatelessWidget {
  const InkHeaderPage({
    super.key,
    required this.headerKey,
    required this.slotKey,
    required this.header,
    required this.slivers,
  });

  /// Identity of the header, kept by the page's state.
  final GlobalKey headerKey;

  /// Key of the permanent first row of the scroll view, kept by the state.
  final GlobalKey slotKey;

  /// The top of the page; as tall as it needs to be.
  final Widget header;

  /// The list, after the header.
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final bool short = InkLayout.isShortPage(context);
    final Widget keyed = KeyedSubtree(key: headerKey, child: header);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (short) const SizedBox.shrink() else keyed,
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                key: slotKey,
                child: short ? keyed : const SizedBox.shrink(),
              ),
              ...slivers,
            ],
          ),
        ),
      ],
    );
  }
}

/// The scroll position of the page whose permanent first row is [slotKey],
/// or `null` when it is not on screen yet.
ScrollPosition? inkPageScroll(GlobalKey slotKey) {
  final BuildContext? context = slotKey.currentContext;
  if (context == null || !context.mounted) return null;
  final ScrollPosition? position = Scrollable.maybeOf(
    context,
    axis: Axis.vertical,
  )?.position;
  return position != null && position.hasPixels ? position : null;
}

/// Brings the list of a page built with [InkHeaderPage] back to its start,
/// for a list that changes under the header (a chip, a segment).
///
/// With the header above the scroll view the list starts at offset 0. With
/// the header inside it ([headerScrolls]), the list stays where it is while
/// the header is still (partly) on screen and otherwise is brought to just
/// above the first row.
void jumpToContentTop(
  GlobalKey slotKey,
  GlobalKey headerKey, {
  required bool headerScrolls,
}) {
  final ScrollPosition? position = inkPageScroll(slotKey);
  if (position == null) return;
  double limit = 0;
  if (headerScrolls) {
    final RenderObject? box = headerKey.currentContext?.findRenderObject();
    if (box is RenderBox && box.hasSize) limit = box.size.height;
  }
  if (position.pixels > limit) position.jumpTo(limit);
}
