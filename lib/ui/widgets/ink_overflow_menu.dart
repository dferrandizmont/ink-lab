import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../icons/ink_icons.dart';
import '../theme/tokens.dart';
import 'ink_button.dart';

/// One entry of an [InkOverflowMenu].
///
/// [key] goes to the entry's `PopupMenuItem`, so a test (or a screen) can
/// find it with `find.byKey` once the menu is open.
@immutable
class InkMenuItem {
  const InkMenuItem({
    this.key,
    required this.label,
    required this.onSelected,
    this.icon,
    this.destructive = false,
    this.enabled = true,
  });

  final Key? key;

  /// Already localised. It wraps (two lines at most for a sensible label) and
  /// is never cut.
  final String label;

  /// Optional 20 dp leading icon.
  final InkIcons? icon;

  /// Called after the menu has closed, only if the menu's own widget is
  /// still on screen.
  final VoidCallback onSelected;

  /// Draws the entry in the `error` colour (delete, clear all).
  final bool destructive;

  /// Whether the entry can be picked. A disabled entry stays in the menu (so
  /// the menu keeps its size) drawn in the muted colour, and does nothing.
  final bool enabled;
}

/// The entries of a "⋯" menu that a sheet fills while it is open.
///
/// The sheet publishes them (see [publish]) and the menu reads them. A
/// write after the notifier has been disposed does nothing: the sheet may
/// still be alive for a frame after the menu is gone.
class InkMenuItemsNotifier extends ValueNotifier<List<InkMenuItem>> {
  InkMenuItemsNotifier() : super(const <InkMenuItem>[]);

  bool _disposed = false;

  /// Whether [dispose] has been called.
  bool get isDisposed => _disposed;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Whether [items] are the ones already published: the same entries, in
  /// the same order (same labels and same keys).
  bool hasSameItems(List<InkMenuItem> items) => _same(value, items);

  /// Publishes [items] when they are not the ones already published, so the
  /// menu is only rebuilt when its entries really change. Does nothing when
  /// the notifier has been disposed.
  void publish(List<InkMenuItem> items) {
    if (_disposed || _same(value, items)) return;
    value = items;
  }

  /// Two lists of entries are the same when they hold the same entries, in
  /// the same order.
  static bool _same(List<InkMenuItem> a, List<InkMenuItem> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].label != b[i].label) return false;
      if (a[i].key != b[i].key) return false;
      if (a[i].enabled != b[i].enabled) return false;
    }
    return true;
  }
}

/// The "⋯" button: a 44 dp [InkIconButton] with the localised tooltip "More
/// actions" that opens a popup menu under it. The secondary actions of a
/// card, a sheet or a screen go here, so the primary action is the only
/// button left in view.
///
/// Entries are at least 48 dp high, use the app's `popupMenuTheme` and wrap
/// to a second line instead of being cut. With no [items] nothing is drawn,
/// so a caller can build the list conditionally:
///
/// ```dart
/// InkOverflowMenu(
///   key: const ValueKey<String>('swatch-overflow'),
///   items: <InkMenuItem>[
///     InkMenuItem(
///       label: l10n.swatchesCopyHex,
///       icon: InkIcons.copy,
///       onSelected: copyHex,
///     ),
///     if (hasOwnColour)
///       InkMenuItem(label: l10n.swatchesMyColourReset, onSelected: reset),
///     InkMenuItem(
///       label: l10n.settingsDeleteFavorite,
///       icon: InkIcons.trash2,
///       destructive: true,
///       onSelected: confirmDelete,
///     ),
///   ],
/// )
/// ```
///
/// Inside a sheet, hand it to `showInkDraggableSheet(actions: ...)` or
/// `InkSheet(actions: ...)`; in a page header, to `InkPageHeader.action`.
class InkOverflowMenu extends StatelessWidget {
  const InkOverflowMenu({super.key, required this.items, this.tooltip});

  final List<InkMenuItem> items;

  /// Defaults to the localised "More actions".
  final String? tooltip;

  Future<void> _open(BuildContext context) async {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    // The menu opens under the button, ending at the button's far edge.
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, button.size.height), ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset(0, button.size.height)),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
    final int? picked = await showMenu<int>(
      context: context,
      position: position,
      items: <PopupMenuEntry<int>>[
        for (int i = 0; i < items.length; i++)
          PopupMenuItem<int>(
            key: items[i].key,
            value: i,
            enabled: items[i].enabled,
            height: kMinInteractiveDimension,
            child: _MenuRow(item: items[i]),
          ),
      ],
    );
    if (picked != null && context.mounted) items[picked].onSelected();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return InkIconButton(
      icon: InkIcons.moreHorizontal,
      tooltip: tooltip ?? context.l10n.commonMoreActions,
      onPressed: () => _open(context),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.item});

  final InkMenuItem item;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color color = !item.enabled
        ? ink.fg2
        : item.destructive
        ? ink.error
        : ink.fg;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (item.icon != null) ...<Widget>[
            InkIcon(item.icon!, size: InkGeometry.mediumIcon, color: color),
            const SizedBox(width: InkSpacing.s12),
          ],
          Flexible(
            child: Text(
              item.label,
              style: DefaultTextStyle.of(context).style.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
