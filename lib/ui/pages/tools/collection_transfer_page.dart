import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import '../../../app_scope.dart';
import '../../../core/collection_export.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../share/share_sink.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/section_card.dart';
import '../settings/dialogs.dart';
import 'collection_snapshot.dart';
import 'tools_widgets.dart';

/// "Export and import": the collection out as a CSV for a spreadsheet or a
/// short list grouped by brand for a message, and codes in: the user picks a
/// brand, pastes a list of codes and sees what would be added, what they
/// already own and what was not recognised. Nothing changes until they press
/// the button that adds the new markers.
class CollectionTransferPage extends StatefulWidget {
  const CollectionTransferPage({super.key, this.shareSink});

  /// Where the files go. Production opens the system share sheet; tests
  /// inject a fake.
  final ShareSink? shareSink;

  /// Key of the page body.
  static const Key pageKey = Key('collection-transfer-page');

  /// Pushes the page on the nearest navigator.
  static Future<void> open(BuildContext context, {ShareSink? shareSink}) =>
      AppScope.push(context, CollectionTransferPage(shareSink: shareSink));

  @override
  State<CollectionTransferPage> createState() => _CollectionTransferPageState();
}

class _CollectionTransferPageState extends State<CollectionTransferPage> {
  AppScope? _scope;
  late Future<CollectionSnapshot> _snapshot;
  final TextEditingController _codes = TextEditingController();
  MarkerBrand? _brand;
  bool _newOpen = false;
  bool _ownedOpen = false;
  bool _unknownOpen = false;
  bool _adding = false;

  ShareSink get _sink => widget.shareSink ?? const SystemShareSink();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _snapshot = CollectionSnapshot.load(scope);
    }
  }

  @override
  void dispose() {
    _codes.dispose();
    super.dispose();
  }

  Future<void> _share(String text, String name) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    try {
      await _sink.shareTextFile(text, name: name);
    } catch (_) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            key: const ValueKey<String>('transfer-share-failed'),
            content: Text(l10n.toolsShareFailed),
          ),
        );
    }
  }

  Future<void> _copy(String text) async {
    final AppLocalizations l10n = context.l10n;
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    showMessage(context, l10n.toolsListCopied);
  }

  Future<void> _pickBrand(MarkerBrand current) async {
    final MarkerBrand? brand = await showBrandChoice(
      context,
      current: current,
      title: context.l10n.settingsBrandTitle,
    );
    if (brand != null && mounted) setState(() => _brand = brand);
  }

  Future<void> _add(CodeImportPreview preview) async {
    if (_adding || preview.toAdd.isEmpty) return;
    final AppScope scope = AppScope.of(context);
    final AppLocalizations l10n = context.l10n;
    setState(() => _adding = true);
    await scope.settings.setExtraMarkerIds(<String>{
      ...scope.settings.settings.extraMarkerIds,
      for (final MarkerColor c in preview.toAdd) c.colorId,
    });
    if (!mounted) return;
    _codes.clear();
    setState(() {
      _adding = false;
      _snapshot = CollectionSnapshot.load(scope);
    });
    showMessage(context, l10n.toolsTransferAdded(preview.toAdd.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.toolsTransferTitle)),
      body: InkReadableWidth(
        child: FutureBuilder<CollectionSnapshot>(
          future: _snapshot,
          builder: (BuildContext context, AsyncSnapshot<CollectionSnapshot> s) {
            final CollectionSnapshot? snapshot = s.data;
            if (snapshot == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return _content(context, snapshot);
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context, CollectionSnapshot snapshot) {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final TextStyle caption = AppTypography.secondary.copyWith(color: ink.fg2);
    final MarkerBrand brand = _brand ?? snapshot.activeBrand;
    final List<MarkerColor> owned = snapshot.owned;
    final CodeImportPreview preview = previewCodeImport(
      text: _codes.text,
      range: snapshot.rangeOf(brand),
      ownedIds: snapshot.ownedIds,
    );
    return SingleChildScrollView(
      key: CollectionTransferPage.pageKey,
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
          InkGroupHead(l10n.toolsTransferExport),
          Text(
            owned.isEmpty
                ? l10n.collectionChartEmpty
                : '${l10n.collectionMarkers(owned.length)} · '
                      '${l10n.toolsTransferBrands(snapshot.ownedBrands.length)}',
            key: const ValueKey<String>('transfer-summary'),
            style: caption,
          ),
          // The export holds every brand the user owns markers of, not only
          // the brand of Settings that "My collection" shows: with more than
          // one, say how the total splits so it can be checked.
          if (snapshot.ownedBrands.length > 1) ...<Widget>[
            const SizedBox(height: InkSpacing.s4),
            Text(
              l10n.toolsTransferExportBrands(
                snapshot.ownedCounts.entries
                    .map(
                      (MapEntry<MarkerBrand, int> e) =>
                          '${e.key.label} ${e.value}',
                    )
                    .join(' · '),
              ),
              key: const ValueKey<String>('transfer-brands'),
              style: caption,
            ),
          ],
          const SizedBox(height: InkSpacing.buttonGap),
          InkButton.secondary(
            key: const ValueKey<String>('transfer-csv'),
            label: l10n.toolsTransferCsv,
            icon: InkIcons.share,
            expand: true,
            onPressed: owned.isEmpty
                ? null
                : () => _share(
                    collectionCsv(owned, driedIds: snapshot.driedIds),
                    'ink-lab-markers.csv',
                  ),
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          InkButton.secondary(
            key: const ValueKey<String>('transfer-text'),
            label: l10n.toolsShareList,
            icon: InkIcons.share,
            expand: true,
            onPressed: owned.isEmpty
                ? null
                : () =>
                      _share(collectionTextList(owned), 'ink-lab-markers.txt'),
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          InkButton.secondary(
            key: const ValueKey<String>('transfer-copy'),
            label: l10n.toolsCopyList,
            icon: InkIcons.copy,
            expand: true,
            onPressed: owned.isEmpty
                ? null
                : () => _copy(collectionTextList(owned)),
          ),
          const SizedBox(height: InkSpacing.section),
          InkGroupHead(l10n.toolsTransferImport),
          Text(l10n.toolsTransferImportHelp, style: caption),
          const SizedBox(height: InkSpacing.block),
          InkListCard(
            children: <Widget>[
              InkListRow(
                key: const ValueKey<String>('transfer-brand'),
                label: l10n.settingsBrandTitle,
                value: brand.label,
                chevron: true,
                onTap: () => _pickBrand(brand),
              ),
            ],
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          TextField(
            key: const ValueKey<String>('transfer-codes'),
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
              hintText: 'B114, G07, R29',
              alignLabelWithHint: true,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          InkListCard(
            children: <Widget>[
              _previewGroup(
                key: 'transfer-new',
                title: l10n.toolsTransferNew,
                codes: <String>[for (final c in preview.toAdd) c.newCode],
                open: _newOpen,
                onToggle: () => setState(() => _newOpen = !_newOpen),
              ),
              _previewGroup(
                key: 'transfer-owned',
                title: l10n.toolsTransferAlready,
                codes: <String>[
                  for (final c in preview.alreadyOwned) c.newCode,
                ],
                open: _ownedOpen,
                onToggle: () => setState(() => _ownedOpen = !_ownedOpen),
              ),
              _previewGroup(
                key: 'transfer-unknown',
                title: l10n.toolsTransferUnknown,
                codes: preview.unknown,
                open: _unknownOpen,
                onToggle: () => setState(() => _unknownOpen = !_unknownOpen),
              ),
            ],
          ),
          const SizedBox(height: InkSpacing.block),
          InkButton(
            key: const ValueKey<String>('transfer-add'),
            label: l10n.toolsTransferAdd(preview.toAdd.length),
            expand: true,
            loading: _adding,
            onPressed: preview.toAdd.isEmpty ? null : () => _add(preview),
          ),
        ],
      ),
    );
  }

  /// A folded group of the preview: its title and how many codes it holds,
  /// the codes inside.
  Widget _previewGroup({
    required String key,
    required String title,
    required List<String> codes,
    required bool open,
    required VoidCallback onToggle,
  }) {
    final InkColors ink = InkColors.of(context);
    return InkDisclosure(
      key: ValueKey<String>(key),
      title: title,
      trailing: Text(
        '${codes.length}',
        style: AppTypography.data.copyWith(color: ink.fg2),
      ),
      semanticLabel: '$title, ${codes.length}',
      expanded: open,
      onToggle: onToggle,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          0,
          InkSpacing.cardH,
          InkSpacing.cardV,
        ),
        child: codes.isEmpty
            ? const SizedBox.shrink()
            : Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: InkSpacing.s12,
                  runSpacing: InkSpacing.s4,
                  children: <Widget>[
                    for (final String code in codes)
                      Text(
                        code,
                        style: AppTypography.code.copyWith(color: ink.fg),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
