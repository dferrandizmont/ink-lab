import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../../l10n/l10n.dart';
import '../icons/ink_icons.dart';
import '../pages/collection/collection_summary.dart';
import '../pages/collection/owned_brands.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import 'ink_search_field.dart';
import 'section_card.dart';

/// The brands that come first in every brand list, most popular first: the
/// ones most people who start with alcohol markers own. The order of this
/// list is the order on screen (it is a ranking, not alphabetical).
///
/// Every other brand follows in [moreBrands], alphabetically, so a brand that
/// is not here is found by its name in a list people already know how to scan.
const List<MarkerBrand> popularBrands = <MarkerBrand>[
  MarkerBrand.ohuhuOahu,
  MarkerBrand.copic,
  MarkerBrand.arrtx,
  MarkerBrand.touchTwin,
  MarkerBrand.promarker,
  MarkerBrand.prismacolor,
];

/// Every brand that is not in [popularBrands], alphabetical by name (case,
/// accents and punctuation ignored: "Graph'it" sorts as "graphit"). A new
/// brand lands here on its own; add it to [popularBrands] only once it is one
/// of the brands most people own.
List<MarkerBrand> get moreBrands {
  final List<MarkerBrand> rest =
      <MarkerBrand>[
        for (final MarkerBrand brand in MarkerBrand.values)
          if (!popularBrands.contains(brand)) brand,
      ]..sort(
        (MarkerBrand a, MarkerBrand b) =>
            brandSearchKey(a.label).compareTo(brandSearchKey(b.label)),
      );
  return rest;
}

const Map<String, String> _folded = <String, String>{
  'àáâãäåāăą': 'a',
  'çćĉċč': 'c',
  'ďđ': 'd',
  'èéêëēĕėęě': 'e',
  'ĝğġģ': 'g',
  'ìíîïĩīĭįı': 'i',
  'ñńņňŉ': 'n',
  'òóôõöøōŏő': 'o',
  'ŕŗř': 'r',
  'śŝşš': 's',
  'ţťŧ': 't',
  'ùúûüũūŭůűų': 'u',
  'ýÿŷ': 'y',
  'źżž': 'z',
  'æ': 'ae',
  'œ': 'oe',
  'ß': 'ss',
};

final Map<int, String> _foldTable = <int, String>{
  for (final MapEntry<String, String> entry in _folded.entries)
    for (final int rune in entry.key.runes) rune: entry.value,
};

/// What two names are compared by: lower case, without accents, and without
/// anything that is not a letter or a digit, so "touch twin", "Touch-Twin",
/// "graphit" and "Graph'it" all meet. Used for sorting and for the search.
String brandSearchKey(String text) {
  final StringBuffer out = StringBuffer();
  for (final int rune in text.toLowerCase().runes) {
    final String? plain = _foldTable[rune];
    if (plain != null) {
      out.write(plain);
    } else if ((rune >= 0x61 && rune <= 0x7a) ||
        (rune >= 0x30 && rune <= 0x39) ||
        rune > 0x7f) {
      // A letter or digit; any other non-ASCII letter is kept as it is.
      out.writeCharCode(rune);
    }
  }
  return out.toString();
}

/// Whether [brand]'s name contains [query], a partial word included
/// ("promar", "zig", "touch"); an empty [query] matches every brand.
bool brandMatchesQuery(MarkerBrand brand, String query) {
  final String key = brandSearchKey(query);
  return key.isEmpty || brandSearchKey(brand.label).contains(key);
}

/// Key of the search field.
const Key brandSearchFieldKey = ValueKey<String>('brand-search');

/// Key of the line shown when no brand matches the search.
const Key brandSearchEmptyKey = ValueKey<String>('brand-search-empty');

/// Key of the "Your brands" group head.
const Key brandGroupOwnedKey = ValueKey<String>('brand-group-owned');

/// Key of the "Popular" group head.
const Key brandGroupPopularKey = ValueKey<String>('brand-group-popular');

/// Key of the "More brands" group head.
const Key brandGroupMoreKey = ValueKey<String>('brand-group-more');

/// Every brand of the app, found by name: a search field, then the brands
/// the user owns markers of ("Your brands", when there are any), the
/// [popularBrands] and the [moreBrands] as compact rows (name, and under it
/// the colour count and how the brand is collected, or what the user owns of
/// it). The brand list keeps growing, so people look a brand up here instead
/// of scrolling a card each.
///
/// The search field sits first and never moves; a group with no match drops
/// out whole (head included), and when nothing matches a single line takes the
/// place of the groups. The chosen brand's row is filled and ticked.
///
/// [scrollable] false (first-run setup) lays everything out in a column to be
/// put in the page's own list; true (the brand picker sheet) pins the search
/// field and scrolls the rows inside the height it is given, which must be
/// bounded.
class BrandList extends StatefulWidget {
  const BrandList({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.rowKey,
    this.scrollable = false,
    this.listKey,
    this.owned = const <MarkerBrand, OwnedBrandCount>{},
  });

  /// The chosen brand.
  final MarkerBrand selected;

  /// Called with the brand that was tapped (or the only one left by the
  /// search, when the keyboard's search key is pressed).
  final ValueChanged<MarkerBrand> onSelected;

  /// The key of a brand's row.
  final Key Function(MarkerBrand brand) rowKey;

  /// Whether the rows scroll inside this widget, under a pinned search field.
  final bool scrollable;

  /// The key of the scrolling list, when [scrollable].
  final Key? listKey;

  /// What the user owns, per brand (see `loadOwnedBrands`): these brands form
  /// the first group and say what is owned on their second line. It must be
  /// known before the list is shown, so no row moves afterwards. Empty in the
  /// first-run setup, where nothing is owned yet.
  final Map<MarkerBrand, OwnedBrandCount> owned;

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<MarkerBrand> _matching(List<MarkerBrand> brands) => <MarkerBrand>[
    for (final MarkerBrand brand in brands)
      if (brandMatchesQuery(brand, _query)) brand,
  ];

  void _submit(String _) {
    final List<MarkerBrand> found = <MarkerBrand>[
      ..._matching(_ownedList),
      ..._matching(_popularList),
      ..._matching(_moreList),
    ];
    if (found.length == 1) widget.onSelected(found.single);
  }

  /// The owned brands, in the app's order: the popular ranking, then the rest
  /// alphabetically.
  List<MarkerBrand> get _ownedList => <MarkerBrand>[
    for (final MarkerBrand brand in popularBrands)
      if (widget.owned.containsKey(brand)) brand,
    for (final MarkerBrand brand in moreBrands)
      if (widget.owned.containsKey(brand)) brand,
  ];

  List<MarkerBrand> get _popularList => <MarkerBrand>[
    for (final MarkerBrand brand in popularBrands)
      if (!widget.owned.containsKey(brand)) brand,
  ];

  List<MarkerBrand> get _moreList => <MarkerBrand>[
    for (final MarkerBrand brand in moreBrands)
      if (!widget.owned.containsKey(brand)) brand,
  ];

  Widget _group({
    required Key headKey,
    required String title,
    required List<MarkerBrand> brands,
  }) {
    final AppLocalizations l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkGroupHead(title, key: headKey),
        InkListCard(
          children: <Widget>[
            for (final MarkerBrand brand in brands)
              _BrandRow(
                key: widget.rowKey(brand),
                label: brand.label,
                line:
                    widget.owned[brand]?.line(l10n) ??
                    l10n.onboardingBrandLine(brand),
                selected: brand == widget.selected,
                onTap: () => widget.onSelected(brand),
              ),
          ],
        ),
      ],
    );
  }

  List<Widget> _rows() {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final List<MarkerBrand> yours = _matching(_ownedList);
    final List<MarkerBrand> popular = _matching(_popularList);
    final List<MarkerBrand> more = _matching(_moreList);
    if (yours.isEmpty && popular.isEmpty && more.isEmpty) {
      // One line, where the first group head would be: it never moves.
      return <Widget>[
        Semantics(
          liveRegion: true,
          child: Text(
            l10n.brandSearchEmpty,
            key: brandSearchEmptyKey,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ),
      ];
    }
    final List<Widget> groups = <Widget>[
      if (yours.isNotEmpty)
        _group(
          headKey: brandGroupOwnedKey,
          title: l10n.brandGroupOwned,
          brands: yours,
        ),
      if (popular.isNotEmpty)
        _group(
          headKey: brandGroupPopularKey,
          title: l10n.brandGroupPopular,
          brands: popular,
        ),
      if (more.isNotEmpty)
        _group(
          headKey: brandGroupMoreKey,
          title: l10n.brandGroupMore,
          brands: more,
        ),
    ];
    return <Widget>[
      for (int i = 0; i < groups.length; i++) ...<Widget>[
        if (i > 0) const SizedBox(height: InkSpacing.block),
        groups[i],
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final Widget search = InkSearchField(
      key: brandSearchFieldKey,
      controller: _search,
      hintText: l10n.brandSearchHint,
      semanticLabel: l10n.brandSearchHint,
      onChanged: (String value) => setState(() => _query = value),
      onSubmitted: _submit,
    );
    const Widget gap = SizedBox(height: InkSpacing.block);
    if (widget.scrollable) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          search,
          gap,
          Expanded(
            child: ListView(
              key: widget.listKey,
              padding: EdgeInsets.zero,
              children: _rows(),
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[search, gap, ..._rows()],
    );
  }
}

/// One brand: its name (one line), under it the brand's own line in the
/// smaller type, and a tick at the end while it is the chosen brand.
class _BrandRow extends StatelessWidget {
  const _BrandRow({
    super.key,
    required this.label,
    required this.line,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String line;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      excludeSemantics: true,
      label: '$label, $line',
      onTap: onTap,
      child: Material(
        color: selected ? ink.pale : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: InkGeometry.rowTall),
            child: Padding(
              padding: InkSpacing.card,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          label,
                          maxLines: 1,
                          softWrap: false,
                          style: AppTypography.body.copyWith(color: ink.fg),
                        ),
                        Text(
                          line,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: InkSpacing.s12),
                  SizedBox.square(
                    dimension: InkGeometry.mediumIcon,
                    child: selected
                        ? InkIcon(
                            InkIcons.check,
                            size: InkGeometry.mediumIcon,
                            color: ink.action,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
