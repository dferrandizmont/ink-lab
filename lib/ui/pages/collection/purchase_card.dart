import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../core/purchase_advisor.dart';
import '../../../core/scene_catalog.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import 'marker_status_row.dart';

/// "What to buy next" in My collection: the ten loose markers of the active
/// brand that would bring the user's colours closest to the most drawing
/// scenes (see `suggestPurchases`), each with a one-line reason and a button
/// that puts it on the wishlist.
class PurchaseCard extends StatefulWidget {
  const PurchaseCard({
    super.key,
    required this.brand,
    required this.catalog,
    required this.settings,
    required this.nameDisplayMode,
  });

  final MarkerBrand brand;

  /// The colours of [brand].
  final List<MarkerColor> catalog;

  /// The collection of the user.
  final AppSettings settings;

  final NameDisplayMode nameDisplayMode;

  @override
  State<PurchaseCard> createState() => _PurchaseCardState();
}

class _PurchaseCardState extends State<PurchaseCard> {
  AppScope? _scope;
  Stream<Set<String>>? _wishChanges;
  Stream<Set<String>>? _driedChanges;
  Future<SceneCatalog>? _scenes;

  String? _signature;
  List<PurchaseSuggestion> _suggestions = const <PurchaseSuggestion>[];
  bool _hasCollection = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _wishChanges = scope.wishlist.changes;
      _driedChanges = scope.dried.changes;
      _scenes = scope.markers.loadScenes();
      _signature = null;
    }
  }

  /// Recomputes the ranking when the collection, the catalogue colours or the
  /// dried-out markers changed since the last build.
  void _refresh(AppScope scope, SceneCatalog scenes) {
    final List<String> sets = widget.settings.ownedSetIds.toList()..sort();
    final List<String> extras = widget.settings.extraMarkerIds.toList()..sort();
    final String signature =
        '${widget.brand.id}|${sets.join(',')}|${extras.join(',')}|'
        '${scope.dried.revision}|${scope.markers.colorRevision}|'
        '${widget.catalog.length}';
    if (signature == _signature) return;
    _signature = signature;
    final Set<String> dried = scope.dried.ids;
    final List<MarkerColor> range = brandRangeColors(
      colors: widget.catalog,
      brand: widget.brand,
    );
    final List<MarkerColor> owned = ownedColors(
      colors: widget.catalog,
      brand: widget.brand,
      ownedSetIds: widget.settings.ownedSetIds,
      ownedMarkerCodes: widget.settings.extraMarkerIds,
    );
    _hasCollection = owned.isNotEmpty;
    _suggestions = _hasCollection
        ? suggestPurchases(
            range: range,
            owned: <MarkerColor>[
              for (final MarkerColor c in owned)
                if (!dried.contains(c.colorId)) c,
            ],
            scenes: scenes.scenes,
          )
        : const <PurchaseSuggestion>[];
  }

  String _reason(AppLocalizations l10n, PurchaseSuggestion s, String language) {
    if (s.improvedScenes == 0) return l10n.buyNextReasonGap;
    final String names =
        s.topScenes.take(2).map((scene) => scene.nameFor(language)).join(', ') +
        (s.improvedScenes > 2 ? '…' : '');
    return l10n.buyNextReasonScenes(s.improvedScenes, names);
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: FutureBuilder<SceneCatalog>(
          future: _scenes,
          builder: (BuildContext context, AsyncSnapshot<SceneCatalog> scenes) {
            final SceneCatalog? catalog = scenes.data;
            if (catalog == null) {
              // The catalogue is a bundled asset: a moment, or never (error).
              return const SizedBox(height: InkGeometry.target);
            }
            return StreamBuilder<Set<String>>(
              stream: _driedChanges,
              initialData: scope.dried.ids,
              builder: (BuildContext context, AsyncSnapshot<Set<String>> _) {
                _refresh(scope, catalog);
                return StreamBuilder<Set<String>>(
                  stream: _wishChanges,
                  initialData: scope.wishlist.ids,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<Set<String>> _,
                  ) => _content(context, scope, ink),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context, AppScope scope, InkColors ink) {
    final AppLocalizations l10n = context.l10n;
    final String language = Localizations.localeOf(context).languageCode;
    final Set<String> dried = scope.dried.ids;
    final List<Widget> children = <Widget>[
      Text(
        l10n.buyNextIntro,
        style: AppTypography.secondary.copyWith(color: ink.fg2),
      ),
    ];
    if (!_hasCollection) {
      children
        ..add(const SizedBox(height: InkSpacing.group))
        ..add(
          Text(
            l10n.buyNextNoCollection,
            key: const ValueKey<String>('buy-next-empty'),
            style: AppTypography.body.copyWith(color: ink.fg),
          ),
        );
    } else if (_suggestions.isEmpty) {
      children
        ..add(const SizedBox(height: InkSpacing.group))
        ..add(
          Text(
            l10n.buyNextComplete,
            key: const ValueKey<String>('buy-next-complete'),
            style: AppTypography.body.copyWith(color: ink.fg),
          ),
        );
    } else {
      children.add(const SizedBox(height: InkSpacing.group));
      for (final PurchaseSuggestion s in _suggestions) {
        final String id = s.color.colorId;
        final bool wished = scope.wishlist.contains(id);
        children
          ..add(
            Divider(
              height: InkGeometry.border,
              thickness: InkGeometry.border,
              color: ink.line,
            ),
          )
          ..add(
            MarkerStatusRow(
              key: ValueKey<String>('buy-next-$id'),
              colorId: id,
              color: s.color,
              nameDisplayMode: widget.nameDisplayMode,
              notes: <String>[
                _reason(l10n, s, language),
                if (dried.contains(id)) l10n.buyNextRefill,
              ],
              trailing: InkIconButton(
                key: ValueKey<String>('buy-next-wish-$id'),
                icon: InkIcons.bookmark,
                selected: wished,
                tooltip: wished ? l10n.wishlistRemove : l10n.wishlistAdd,
                onPressed: () => scope.wishlist.toggle(id),
              ),
            ),
          );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
