import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../core/natural_sort.dart';
import '../../../core/purchase_advisor.dart';
import '../../../core/shopping_list.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_disclosure.dart';
import 'marker_status_row.dart';

/// The wishlist of the active brand in My collection: the markers to buy,
/// each removable, and a button that copies them as a plain-text shopping
/// list (brand, code and name per line).
///
/// The count is the header of a folded [InkDisclosure] (spec §2.6); the list
/// and "Copy list" are inside.
///
/// Two things remind the user what to buy. The markers that are running out
/// (see `MarkerExtrasRepository`) sit in a "Running out" group under the
/// list, each with its refill note and a button that puts it on the list; the
/// summary of the card says how many there are. And a wishlist marker that is
/// almost the same colour as one the user owns is flagged, so a near-duplicate
/// is not bought by mistake.
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
  Stream<int>? _extrasChanges;
  bool _open = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _changes = scope.wishlist.changes;
      _extrasChanges = scope.markerExtras.changes;
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

  static int _byCode(String a, String b) => naturalCodeComparator(
    a.substring(a.indexOf(':') + 1),
    b.substring(b.indexOf(':') + 1),
  );

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    return StreamBuilder<Set<String>>(
      stream: _changes,
      initialData: scope.wishlist.ids,
      builder: (BuildContext context, AsyncSnapshot<Set<String>> snapshot) =>
          // The ink level and the notes change from the marker detail.
          StreamBuilder<int>(
            stream: _extrasChanges,
            initialData: scope.markerExtras.revision,
            builder: (BuildContext context, AsyncSnapshot<int> _) =>
                _card(context, scope),
          ),
    );
  }

  Widget _card(BuildContext context, AppScope scope) {
    final InkColors ink = InkColors.of(context);
    final List<String> ids = scope.wishlist.idsOf(widget.brand).toList()
      ..sort(_byCode);
    final List<MarkerColor> known = <MarkerColor>[
      for (final String id in ids) ?findMarker(widget.catalog, id),
    ];
    // The collection of the brand: a marker that left it is not "running
    // out" any more, whatever was stored.
    final AppSettings settings = scope.settings.settings;
    final List<MarkerColor> collection = ownedColors(
      colors: widget.catalog,
      brand: widget.brand,
      ownedSetIds: settings.ownedSetIds,
      ownedMarkerCodes: settings.extraMarkerIds,
    );
    final Set<String> collectionIds = <String>{
      for (final MarkerColor c in collection) c.colorId,
    };
    final List<String> runningOut = <String>[
      for (final String id in scope.markerExtras.runningOutIds)
        if (collectionIds.contains(id)) id,
    ]..sort(_byCode);
    // Those already on the list are there to be bought; the group is for the
    // ones the user still has to remember.
    final List<String> toRemember = <String>[
      for (final String id in runningOut)
        if (!scope.wishlist.contains(id)) id,
    ];
    // The usable markers the user owns, to flag near-duplicates.
    final List<MarkerColor> owned = <MarkerColor>[
      for (final MarkerColor c in collection)
        if (!scope.dried.contains(c.colorId)) c,
    ];
    return InkDisclosure(
      key: const ValueKey<String>('wishlist-disclosure'),
      title: context.l10n.wishlistCount(ids.length),
      // Something is running out: say how many. Otherwise one line of help,
      // so the row keeps the same height in every state.
      subtitle: runningOut.isEmpty
          ? context.l10n.wishlistSubtitle
          : context.l10n.wishlistRunningOutCount(runningOut.length),
      expanded: _open,
      onToggle: () => setState(() => _open = !_open),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          0,
          InkSpacing.cardH,
          InkSpacing.cardV,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (ids.isEmpty)
              Text(
                context.l10n.wishlistEmpty,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              )
            else ...<Widget>[
              for (final String id in ids) ...<Widget>[
                MarkerStatusRow(
                  key: ValueKey<String>('wishlist-row-$id'),
                  colorId: id,
                  color: findMarker(widget.catalog, id),
                  nameDisplayMode: widget.nameDisplayMode,
                  notes: _duplicateNotes(context, id, owned),
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
            if (toRemember.isNotEmpty) ...<Widget>[
              const SizedBox(height: InkSpacing.section),
              _RunningOutGroup(
                ids: toRemember,
                catalog: widget.catalog,
                nameDisplayMode: widget.nameDisplayMode,
                scope: scope,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// "Very close to B08, B09 in your collection" when the wishlist marker
  /// [id] is almost the same colour as markers the user owns; no note
  /// otherwise.
  List<String> _duplicateNotes(
    BuildContext context,
    String id,
    List<MarkerColor> owned,
  ) {
    final MarkerColor? marker = findMarker(widget.catalog, id);
    if (marker == null || owned.isEmpty) return const <String>[];
    final List<NearDuplicate> found = findNearDuplicates(marker, owned);
    if (found.isEmpty) return const <String>[];
    final String codes = found
        .take(3)
        .map((NearDuplicate d) => d.color.displayCode(widget.nameDisplayMode))
        .join(', ');
    return <String>[context.l10n.wishlistDuplicateNote(codes)];
  }
}

/// The group "Running out" of the wishlist card: the owned markers about to
/// run dry that are not on the list yet, each with its refill note and a
/// button that puts it on the list.
class _RunningOutGroup extends StatelessWidget {
  const _RunningOutGroup({
    required this.ids,
    required this.catalog,
    required this.nameDisplayMode,
    required this.scope,
  });

  final List<String> ids;
  final List<MarkerColor> catalog;
  final NameDisplayMode nameDisplayMode;
  final AppScope scope;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    return Column(
      key: const ValueKey<String>('wishlist-running-out'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Semantics(
          header: true,
          child: Text(
            l10n.commonRunningOut,
            style: AppTypography.section.copyWith(color: ink.fg),
          ),
        ),
        const SizedBox(height: InkSpacing.s4),
        Text(
          l10n.wishlistRunningOutHint,
          style: AppTypography.secondary.copyWith(color: ink.fg2),
        ),
        const SizedBox(height: InkSpacing.group),
        for (final String id in ids) ...<Widget>[
          MarkerStatusRow(
            key: ValueKey<String>('running-out-row-$id'),
            colorId: id,
            color: findMarker(catalog, id),
            nameDisplayMode: nameDisplayMode,
            notes: <String>[?scope.markerExtras.noteOf(id)],
            trailing: InkIconButton(
              key: ValueKey<String>('running-out-add-$id'),
              icon: InkIcons.bookmark,
              tooltip: l10n.wishlistAdd,
              onPressed: () => scope.wishlist.add(id),
            ),
          ),
          Divider(
            height: InkGeometry.border,
            thickness: InkGeometry.border,
            color: ink.line,
          ),
        ],
      ],
    );
  }
}
