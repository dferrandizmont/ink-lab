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
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import 'marker_status_row.dart';

/// "What to buy next" in My collection: the loose markers of the active
/// brand that would bring the user's colours closest to the most drawing
/// scenes (see `suggestPurchases`).
///
/// Shows the three first suggestions and a "See all" that opens the full
/// ranking in a draggable selector (spec §2.6); each row keeps the one-line
/// reason and the button that puts it on the wishlist.
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

  /// How many suggestions are shown inline before "See all".
  static const int _inline = 3;

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

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    final InkColors ink = InkColors.of(context);
    return FutureBuilder<SceneCatalog>(
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
              builder:
                  (BuildContext context, AsyncSnapshot<Set<String>> _) =>
                      _content(context, scope, ink),
            );
          },
        );
      },
    );
  }

  Widget _content(BuildContext context, AppScope scope, InkColors ink) {
    final AppLocalizations l10n = context.l10n;
    final String language = Localizations.localeOf(context).languageCode;
    final List<Widget> children = <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          InkSpacing.cardV,
          InkSpacing.cardH,
          0,
        ),
        child: Text(
          l10n.buyNextIntro,
          style: AppTypography.secondary.copyWith(color: ink.fg2),
        ),
      ),
    ];
    if (!_hasCollection) {
      children.add(
        _line(
          l10n.buyNextNoCollection,
          ink,
          key: const ValueKey<String>('buy-next-empty'),
        ),
      );
    } else if (_suggestions.isEmpty) {
      children.add(
        _line(
          l10n.buyNextComplete,
          ink,
          key: const ValueKey<String>('buy-next-complete'),
        ),
      );
    } else {
      for (final PurchaseSuggestion s in _suggestions.take(_inline)) {
        children
          ..add(
            Divider(
              height: InkGeometry.border,
              thickness: InkGeometry.border,
              color: ink.line,
            ),
          )
          ..add(
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: InkSpacing.cardH,
              ),
              child: _row(context, scope, s, l10n, language),
            ),
          );
      }
      if (_suggestions.length > _inline) {
        children.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(
              InkSpacing.cardH,
              InkSpacing.group,
              InkSpacing.cardH,
              InkSpacing.cardV,
            ),
            child: InkButton.text(
              key: const ValueKey<String>('collection-buy-next-see-all'),
              label: l10n.commonSeeAll(_suggestions.length),
              expand: true,
              onPressed: () => _showAll(context, scope),
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

  Widget _line(String text, InkColors ink, {required Key key}) => Padding(
    padding: const EdgeInsets.fromLTRB(
      InkSpacing.cardH,
      InkSpacing.group,
      InkSpacing.cardH,
      InkSpacing.cardV,
    ),
    child: Text(
      text,
      key: key,
      style: AppTypography.body.copyWith(color: ink.fg),
    ),
  );

  Widget _row(
    BuildContext context,
    AppScope scope,
    PurchaseSuggestion s,
    AppLocalizations l10n,
    String language,
  ) {
    final String id = s.color.colorId;
    final bool wished = scope.wishlist.contains(id);
    return MarkerStatusRow(
      key: ValueKey<String>('buy-next-$id'),
      colorId: id,
      color: s.color,
      nameDisplayMode: widget.nameDisplayMode,
      notes: <String>[
        _reasonText(l10n, s, language),
        if (scope.dried.contains(id)) l10n.buyNextRefill,
      ],
      trailing: InkIconButton(
        key: ValueKey<String>('buy-next-wish-$id'),
        icon: InkIcons.bookmark,
        selected: wished,
        tooltip: wished ? l10n.wishlistRemove : l10n.wishlistAdd,
        onPressed: () => scope.wishlist.toggle(id),
      ),
    );
  }

  Future<void> _showAll(BuildContext context, AppScope scope) {
    final String language = Localizations.localeOf(context).languageCode;
    return showInkDraggableSheet<void>(
      context: context,
      initial: 0.5,
      snaps: const <double>[0.5, 1.0],
      builder: (BuildContext context, ScrollController scroll) =>
          _AllSuggestionsSheet(
            scope: scope,
            suggestions: _suggestions,
            nameDisplayMode: widget.nameDisplayMode,
            language: language,
            scrollController: scroll,
          ),
    );
  }
}

/// The full "What to buy next" ranking, in a draggable selector (spec §2.6).
class _AllSuggestionsSheet extends StatelessWidget {
  const _AllSuggestionsSheet({
    required this.scope,
    required this.suggestions,
    required this.nameDisplayMode,
    required this.language,
    required this.scrollController,
  });

  final AppScope scope;
  final List<PurchaseSuggestion> suggestions;
  final NameDisplayMode nameDisplayMode;
  final String language;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return StreamBuilder<Set<String>>(
      stream: scope.wishlist.changes,
      initialData: scope.wishlist.ids,
      builder: (BuildContext context, AsyncSnapshot<Set<String>> snapshot) {
        final Set<String> wished = snapshot.data ?? scope.wishlist.ids;
        final Set<String> dried = scope.dried.ids;
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(
            InkSpacing.cardH,
            0,
            InkSpacing.cardH,
            InkSpacing.sheet,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkSectionHeading(l10n.buyNextTitle),
              const SizedBox(height: InkSpacing.group),
              for (final PurchaseSuggestion s in suggestions)
                MarkerStatusRow(
                  key: ValueKey<String>('buy-all-${s.color.colorId}'),
                  colorId: s.color.colorId,
                  color: s.color,
                  nameDisplayMode: nameDisplayMode,
                  notes: <String>[
                    _reasonText(l10n, s, language),
                    if (dried.contains(s.color.colorId)) l10n.buyNextRefill,
                  ],
                  trailing: InkIconButton(
                    key: ValueKey<String>('buy-all-wish-${s.color.colorId}'),
                    icon: InkIcons.bookmark,
                    selected: wished.contains(s.color.colorId),
                    tooltip: wished.contains(s.color.colorId)
                        ? l10n.wishlistRemove
                        : l10n.wishlistAdd,
                    onPressed: () => scope.wishlist.toggle(s.color.colorId),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

String _reasonText(
  AppLocalizations l10n,
  PurchaseSuggestion s,
  String language,
) {
  if (s.improvedScenes == 0) return l10n.buyNextReasonGap;
  final String names =
      s.topScenes.take(2).map((scene) => scene.nameFor(language)).join(', ') +
      (s.improvedScenes > 2 ? '…' : '');
  return l10n.buyNextReasonScenes(s.improvedScenes, names);
}
