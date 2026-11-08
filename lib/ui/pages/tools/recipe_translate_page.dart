import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../core/recipe_codes.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../share/share_sink.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/section_card.dart';
import '../settings/dialogs.dart';
import 'collection_snapshot.dart';
import 'tools_widgets.dart';

/// The recipe as plain text, one line per code, in the words of [l10n]:
/// `E00 → B01 (Ohuhu) · ΔE 3,2 · Very close`.
String recipeTranslationText(
  AppLocalizations l10n,
  MarkerBrand source,
  List<RecipeLine> lines,
) {
  String candidate(TranslationCandidate c, {bool flagNotOwned = false}) {
    final String brand = MarkerBrand.fromId(c.color.brandId).label;
    final String quality = l10n.matchQualityLabel(c.deltaE);
    return '${c.color.newCode} ($brand) · '
        '${l10n.commonQualityLine(c.deltaE, quality)}'
        '${flagNotOwned ? ' · ${l10n.toolsTranslateNotOwned}' : ''}';
  }

  return <String>[
    for (final RecipeLine line in lines)
      if (line.unknown)
        '${line.code} → ${l10n.toolsTranslateUnknown(source.label)}'
      else
        <String>[
          '${line.code} →',
          <String>[
            if (line.mine != null) candidate(line.mine!),
            if (line.mine == null) l10n.toolsTranslateMissing,
            if (line.range != null) candidate(line.range!, flagNotOwned: true),
          ].join('; '),
        ].join(' '),
  ].join('\n');
}

/// "Translate a recipe": tutorials list their markers in another brand
/// ("E00, E21, R20", usually Copic or Ohuhu). The user picks that brand,
/// types or pastes the codes, and gets for each the closest marker they own,
/// with the distance and the app's own wording for how close it is, plus the
/// closest one of their brand's whole range when it is clearly better (marked
/// "not owned"), or "nothing close" when no marker would do.
class RecipeTranslatePage extends StatefulWidget {
  const RecipeTranslatePage({super.key, this.shareSink});

  /// Where the list goes. Production opens the system share sheet; tests
  /// inject a fake.
  final ShareSink? shareSink;

  /// Key of the page body.
  static const Key pageKey = Key('recipe-translate-page');

  /// Pushes the page on the nearest navigator.
  static Future<void> open(BuildContext context, {ShareSink? shareSink}) =>
      AppScope.push(context, RecipeTranslatePage(shareSink: shareSink));

  @override
  State<RecipeTranslatePage> createState() => _RecipeTranslatePageState();
}

class _Loaded {
  _Loaded(this.snapshot)
    : translator = RecipeTranslator(
        owned: snapshot.usable,
        range: snapshot.rangeOf(snapshot.activeBrand),
      );

  final CollectionSnapshot snapshot;
  final RecipeTranslator translator;
}

class _RecipeTranslatePageState extends State<RecipeTranslatePage> {
  AppScope? _scope;
  Future<_Loaded>? _loaded;
  final TextEditingController _codes = TextEditingController();
  MarkerBrand? _brand;

  ShareSink get _sink => widget.shareSink ?? const SystemShareSink();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _loaded = CollectionSnapshot.load(scope).then(_Loaded.new);
    }
  }

  @override
  void dispose() {
    _codes.dispose();
    super.dispose();
  }

  /// The brand the recipe is written for: Copic, the brand most tutorials
  /// use, unless that is the brand the user works with.
  MarkerBrand _sourceBrand(_Loaded loaded) =>
      _brand ??
      (loaded.snapshot.activeBrand == MarkerBrand.copic
          ? MarkerBrand.ohuhuOahu
          : MarkerBrand.copic);

  List<RecipeLine> _translate(_Loaded loaded) {
    final CodeIndex index = CodeIndex(
      loaded.snapshot.rangeOf(_sourceBrand(loaded)),
    );
    return <RecipeLine>[
      for (final String code in parseCodeList(_codes.text, knows: index.knows))
        loaded.translator.translate(code, index.find(code)),
    ];
  }

  Future<void> _pickBrand(_Loaded loaded) async {
    final MarkerBrand? brand = await showBrandChoice(
      context,
      current: _sourceBrand(loaded),
      title: context.l10n.toolsTranslateBrand,
    );
    if (brand != null && mounted) setState(() => _brand = brand);
  }

  Future<void> _copy(String text) async {
    final AppLocalizations l10n = context.l10n;
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    showMessage(context, l10n.toolsListCopied);
  }

  Future<void> _share(String text) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    try {
      await _sink.shareTextFile(text, name: 'ink-lab-recipe.txt');
    } catch (_) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            key: const ValueKey<String>('recipe-share-failed'),
            content: Text(l10n.toolsShareFailed),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.toolsTranslateTitle)),
      body: InkReadableWidth(
        child: FutureBuilder<_Loaded>(
          future: _loaded,
          builder: (BuildContext context, AsyncSnapshot<_Loaded> snapshot) {
            final _Loaded? loaded = snapshot.data;
            if (loaded == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return _content(context, loaded);
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context, _Loaded loaded) {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final MarkerBrand brand = _sourceBrand(loaded);
    final List<RecipeLine> lines = _translate(loaded);
    final String text = recipeTranslationText(l10n, brand, lines);
    return SingleChildScrollView(
      key: RecipeTranslatePage.pageKey,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(
        InkSpacing.gutter,
        InkSpacing.group,
        InkSpacing.gutter,
        InkSpacing.pageBottomOf(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.toolsTranslateIntro,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
          const SizedBox(height: InkSpacing.block),
          InkListCard(
            children: <Widget>[
              InkListRow(
                key: const ValueKey<String>('recipe-brand'),
                label: l10n.toolsTranslateBrand,
                value: brand.label,
                chevron: true,
                onTap: () => _pickBrand(loaded),
              ),
            ],
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          TextField(
            key: const ValueKey<String>('recipe-codes'),
            controller: _codes,
            // A fixed height, so what is typed never moves the page; a longer
            // list scrolls inside the field.
            minLines: 4,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            enableSuggestions: false,
            style: AppTypography.code.copyWith(color: ink.fg),
            decoration: InputDecoration(
              labelText: l10n.toolsTranslateCodes,
              hintText: 'E00, E21, R20',
              alignLabelWithHint: true,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          InkButton.secondary(
            key: const ValueKey<String>('recipe-copy'),
            label: l10n.toolsCopyList,
            icon: InkIcons.copy,
            expand: true,
            onPressed: lines.isEmpty ? null : () => _copy(text),
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          InkButton.secondary(
            key: const ValueKey<String>('recipe-share'),
            label: l10n.toolsShareList,
            icon: InkIcons.share,
            expand: true,
            onPressed: lines.isEmpty ? null : () => _share(text),
          ),
          const SizedBox(height: InkSpacing.section),
          InkGroupHead(l10n.toolsTranslateResults),
          if (lines.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: InkSpacing.s4),
              child: Text(
                l10n.toolsTranslateEmpty,
                key: const ValueKey<String>('recipe-empty'),
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
            )
          else
            for (final RecipeLine line in lines) ...<Widget>[
              _LineCard(
                key: ValueKey<String>('recipe-line-${line.code}'),
                line: line,
                source: brand,
              ),
              const SizedBox(height: InkSpacing.buttonGap),
            ],
        ],
      ),
    );
  }
}

/// One code of the recipe and what it turns into.
class _LineCard extends StatelessWidget {
  const _LineCard({super.key, required this.line, required this.source});

  final RecipeLine line;
  final MarkerBrand source;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final MarkerColor? marker = line.source;
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (marker != null) ...<Widget>[
                  SwatchBlock(
                    hex: marker.hex,
                    size: InkGeometry.swatchRow,
                    own: marker.hasOwnColor,
                  ),
                  const SizedBox(width: InkSpacing.s12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        line.code,
                        style: AppTypography.code.copyWith(color: ink.fg),
                      ),
                      Text(
                        marker?.newName ??
                            l10n.toolsTranslateUnknown(source.label),
                        style: AppTypography.secondary.copyWith(color: ink.fg2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!line.unknown) ...<Widget>[
              const SizedBox(height: InkSpacing.block),
              _caps(context, l10n.toolsTranslateMine),
              const SizedBox(height: InkSpacing.group),
              if (line.mine != null)
                _CandidateRow(
                  key: const ValueKey<String>('recipe-mine'),
                  candidate: line.mine!,
                )
              else
                Row(
                  key: const ValueKey<String>('recipe-missing'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkIcon(
                      InkIcons.alertCircle,
                      size: InkGeometry.smallIcon,
                      color: ink.fg2,
                    ),
                    const SizedBox(width: InkSpacing.s8),
                    Expanded(
                      child: Text(
                        l10n.toolsTranslateMissing,
                        style: AppTypography.secondary.copyWith(color: ink.fg),
                      ),
                    ),
                  ],
                ),
              if (line.range != null) ...<Widget>[
                const SizedBox(height: InkSpacing.block),
                _caps(context, l10n.toolsTranslateNotOwned),
                const SizedBox(height: InkSpacing.group),
                _CandidateRow(
                  key: const ValueKey<String>('recipe-range'),
                  candidate: line.range!,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _caps(BuildContext context, String text) => Semantics(
    header: true,
    child: Text(
      AppTypography.caps(text),
      style: AppTypography.capsStyle.copyWith(color: InkColors.of(context).fg2),
    ),
  );
}

/// A marker offered for a code: its colour, code, brand and name, and how
/// close it is.
class _CandidateRow extends StatelessWidget {
  const _CandidateRow({super.key, required this.candidate});

  final TranslationCandidate candidate;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor color = candidate.color;
    final String brand = MarkerBrand.fromId(color.brandId).label;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SwatchBlock(
          hex: color.hex,
          size: InkGeometry.swatchRow,
          own: color.hasOwnColor,
        ),
        const SizedBox(width: InkSpacing.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                color.newCode,
                style: AppTypography.code.copyWith(color: ink.fg),
              ),
              Text(
                '${color.newName} · $brand',
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
              const SizedBox(height: InkSpacing.s4),
              InkQualityText(candidate.deltaE),
            ],
          ),
        ),
      ],
    );
  }
}
