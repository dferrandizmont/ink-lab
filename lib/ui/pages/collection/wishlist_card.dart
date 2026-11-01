import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../core/natural_sort.dart';
import '../../../core/shopping_list.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import 'marker_status_row.dart';

/// The wishlist of the active brand in My collection: the markers to buy,
/// each removable, and a button that copies them as a plain-text shopping
/// list (brand, code and name per line).
class WishlistCard extends StatefulWidget {
  const WishlistCard({
    super.key,
    required this.brand,
    required this.catalog,
    required this.nameDisplayMode,
  });

  final MarkerBrand brand;

  /// The colours of [brand].
  final List<MarkerColor> catalog;

  final NameDisplayMode nameDisplayMode;

  @override
  State<WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  AppScope? _scope;
  Stream<Set<String>>? _changes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _changes = scope.wishlist.changes;
    }
  }

  Future<void> _copy(List<MarkerColor> markers) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(
      ClipboardData(
        text: shoppingListText(markers, mode: widget.nameDisplayMode),
      ),
    );
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.wishlistCopied)));
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    final InkColors ink = InkColors.of(context);
    return StreamBuilder<Set<String>>(
      stream: _changes,
      initialData: scope.wishlist.ids,
      builder: (BuildContext context, AsyncSnapshot<Set<String>> snapshot) {
        final List<String> ids = scope.wishlist.idsOf(widget.brand).toList()
          ..sort(
            (String a, String b) => naturalCodeComparator(
              a.substring(a.indexOf(':') + 1),
              b.substring(b.indexOf(':') + 1),
            ),
          );
        final List<MarkerColor> known = <MarkerColor>[
          for (final String id in ids) ?findMarker(widget.catalog, id),
        ];
        return Card(
          child: Padding(
            padding: InkSpacing.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  context.l10n.wishlistCount(ids.length),
                  key: const ValueKey<String>('wishlist-count'),
                  style: AppTypography.body.copyWith(color: ink.fg),
                ),
                if (ids.isEmpty) ...<Widget>[
                  const SizedBox(height: InkSpacing.s4),
                  Text(
                    context.l10n.wishlistEmpty,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ] else ...<Widget>[
                  const SizedBox(height: InkSpacing.group),
                  for (final String id in ids) ...<Widget>[
                    MarkerStatusRow(
                      key: ValueKey<String>('wishlist-row-$id'),
                      colorId: id,
                      color: findMarker(widget.catalog, id),
                      nameDisplayMode: widget.nameDisplayMode,
                      trailing: InkIconButton(
                        key: ValueKey<String>('wishlist-remove-$id'),
                        icon: InkIcons.x,
                        tooltip: context.l10n.wishlistRemove,
                        onPressed: () => scope.wishlist.remove(id),
                      ),
                    ),
                    Divider(
                      height: InkGeometry.border,
                      thickness: InkGeometry.border,
                      color: ink.line,
                    ),
                  ],
                  const SizedBox(height: InkSpacing.block),
                  InkButton.secondary(
                    key: const ValueKey<String>('wishlist-copy'),
                    label: context.l10n.wishlistCopy,
                    icon: InkIcons.copy,
                    expand: true,
                    onPressed: known.isEmpty ? null : () => _copy(known),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
