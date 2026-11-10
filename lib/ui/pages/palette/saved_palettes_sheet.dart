import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../core/palette_card_layout.dart';
import '../../../core/scene_catalog.dart';
import '../../icons/ink_icons.dart';
import '../../share/share_actions.dart';
import '../../share/share_sink.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/palette_strip.dart';
import '../diary/artwork_entry_page.dart';
import '../settings/dialogs.dart';
import 'palette_draft.dart';
import 'palette_photo_scene.dart';
import 'palette_roles.dart';
import 'palette_share.dart';
import '../../../l10n/l10n.dart';

/// The palettes saved for one brand, as a draggable selector (spec §2.2).
///
/// The list left the Palette page (and the Settings screen, which keeps a
/// summary row): it opens on demand from the page header, one row per palette
/// with its strip, its name and its meta line. Tapping a row loads it in the
/// Palette tab; each row has a "⋯" with Share · Add to the diary · Delete.
/// The rows and their menu are the same wherever the sheet opens (the Palette
/// page or Settings). In Settings the sheet also carries "Clear all" in its
/// own "⋯".
class SavedPalettesSheet extends StatelessWidget {
  const SavedPalettesSheet({
    super.key,
    required this.scope,
    required this.brand,
    required this.palettes,
    required this.colors,
    required this.scrollController,
    required this.onLoad,
    required this.onShare,
    required this.onAddToDiary,
    this.onImport,
    this.allowClearAll = false,
  });

  /// The app services: the repository that deletes and the catalog.
  final AppScope scope;

  /// The brand whose palettes are listed.
  final MarkerBrand brand;

  /// The palettes of [brand]; created once by [show] so the builder of the
  /// draggable sheet never resubscribes.
  final Stream<List<SavedPalette>> palettes;

  /// The markers of [brand], to resolve a saved code to its colour.
  final Future<List<MarkerColor>> colors;

  /// Binds the sheet's drag to the list (see [showInkDraggableSheet]).
  final ScrollController scrollController;

  /// Loads the palette into the builder (the Palette page hands it its own
  /// loader; [show] hands the palette over to the Palette tab by default).
  final ValueChanged<SavedPalette> onLoad;

  /// Shares the palette as an image.
  final ValueChanged<SavedPalette> onShare;

  /// Starts a diary entry linked to the palette.
  final ValueChanged<SavedPalette> onAddToDiary;

  /// Opens "Import from text" (the sheet closes first). `null` hides the
  /// button (Settings).
  final VoidCallback? onImport;

  /// Whether the sheet has the "⋯" at its top right (Settings): only then the
  /// title leaves room for it.
  final bool allowClearAll;

  /// Opens the selector. [allowClearAll] adds "Clear all" to the sheet's "⋯".
  static Future<void> show(
    BuildContext context, {
    required AppScope scope,
    required MarkerBrand brand,
    ValueChanged<SavedPalette>? onLoad,
    ValueChanged<SavedPalette>? onShare,
    ValueChanged<SavedPalette>? onAddToDiary,
    VoidCallback? onImport,
    ShareSink? shareSink,
    bool allowClearAll = false,
  }) {
    // Created once here: the draggable sheet rebuilds its builder on every
    // drag, so neither the stream nor the future may be made inside it.
    final Stream<List<SavedPalette>> palettes = scope.savedPalettes.watch(
      brand,
    );
    final Future<List<MarkerColor>> colors = scope.markers.loadColors(brand);
    // Without the Palette page's own handlers (Settings), a row opens in the
    // Palette tab and Share / Add to the diary work from the sheet itself.
    final ValueChanged<SavedPalette> load =
        onLoad ?? (SavedPalette palette) => paletteSavedDraft.value = palette;
    final ValueChanged<SavedPalette> share =
        onShare ??
        (SavedPalette palette) => unawaited(
          _share(
            context,
            colors,
            palette,
            shareSink ?? const SystemShareSink(),
          ),
        );
    final ValueChanged<SavedPalette> diary =
        onAddToDiary ??
        (SavedPalette palette) => unawaited(_addToDiary(context, palette));
    return showInkDraggableSheet<void>(
      context: context,
      initial: 0.5,
      snaps: const <double>[0.5, 1.0],
      actions: <Widget>[
        if (allowClearAll)
          InkOverflowMenu(
            key: const ValueKey<String>('palette-saved-overflow'),
            items: <InkMenuItem>[
              InkMenuItem(
                key: const ValueKey<String>('palette-clear-all'),
                label: context.l10n.settingsClearPalettes,
                icon: InkIcons.trash2,
                destructive: true,
                onSelected: () => _clearAll(context, scope, brand),
              ),
            ],
          ),
      ],
      builder: (BuildContext context, ScrollController scroll) =>
          SavedPalettesSheet(
            scope: scope,
            brand: brand,
            palettes: palettes,
            colors: colors,
            scrollController: scroll,
            onLoad: load,
            onShare: share,
            onAddToDiary: diary,
            onImport: onImport,
            allowClearAll: allowClearAll,
          ),
    );
  }

  /// Shares a saved palette as an image (the sheet's own default).
  static Future<void> _share(
    BuildContext context,
    Future<List<MarkerColor>> colors,
    SavedPalette palette,
    ShareSink sink,
  ) async {
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final AppLocalizations t = context.l10n;
    try {
      final PaletteCardData data = savedPaletteCardData(
        palette: palette,
        catalog: await colors,
        baseRole: t.roleLabel(PaletteRoles.base),
      );
      // None of its codes are in the catalogue any more: nothing to draw.
      if (data.entries.isEmpty) throw StateError('empty palette');
      await sharePaletteCard(sink, data);
    } catch (_) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            key: const ValueKey<String>('palette-share-failed'),
            content: Text(t.shareFailed),
          ),
        );
    }
  }

  /// Starts a diary entry linked to a saved palette (the sheet's own default).
  static Future<void> _addToDiary(
    BuildContext context,
    SavedPalette palette,
  ) async {
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final String notice = context.l10n.diaryAddedNotice;
    final bool saved = await ArtworkEntryPage.open(context, palette: palette);
    if (!saved) return;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(notice)));
  }

  static Future<void> _clearAll(
    BuildContext context,
    AppScope scope,
    MarkerBrand brand,
  ) async {
    final AppLocalizations t = context.l10n;
    final bool confirmed = await confirmAction(
      context,
      title: t.settingsClearPalettesTitle,
      body: t.settingsClearPalettesBody,
      confirmLabel: t.settingsClearPalettes,
    );
    if (!confirmed) return;
    await scope.savedPalettes.clearBrand(brand);
  }

  Future<void> _delete(BuildContext context, SavedPalette palette) async {
    final AppLocalizations t = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(t.paletteDeleteDialogTitle),
        content: Text(t.paletteDeleteDialogBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.paletteSaveDialogCancel),
          ),
          FilledButton(
            key: const ValueKey<String>('palette-delete-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.paletteDeleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await scope.savedPalettes.delete(brand, palette.id);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = context.l10n;
    final InkColors ink = InkColors.of(context);
    final Widget title = Padding(
      padding: EdgeInsets.only(
        right: allowClearAll ? InkGeometry.target * 2 + InkSpacing.s8 : 0,
      ),
      child: InkSectionHeading(t.paletteSavedTitle),
    );
    return StreamBuilder<List<SavedPalette>>(
      stream: palettes,
      initialData: scope.savedPalettes.palettesOf(brand),
      builder:
          (BuildContext context, AsyncSnapshot<List<SavedPalette>> snapshot) {
            final List<SavedPalette> saved =
                snapshot.data ?? const <SavedPalette>[];
            if (saved.isEmpty) {
              return ListView(
                key: const ValueKey<String>('palette-saved-list'),
                controller: scrollController,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  title,
                  const SizedBox(height: InkSpacing.headingGap),
                  Text(
                    t.paletteSavedEmpty,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                  ..._importButton(context),
                ],
              );
            }
            return FutureBuilder<List<MarkerColor>>(
              future: colors,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<List<MarkerColor>> colors,
                  ) {
                    final Map<String, String> hexByCode = <String, String>{
                      for (final MarkerColor color
                          in colors.data ?? const <MarkerColor>[])
                        color.newCode.toUpperCase(): color.hex,
                    };
                    return ListView(
                      key: const ValueKey<String>('palette-saved-list'),
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        title,
                        const SizedBox(height: InkSpacing.headingGap),
                        for (int i = 0; i < saved.length; i++) ...<Widget>[
                          if (i > 0) const SizedBox(height: InkSpacing.block),
                          _row(context, saved[i], hexByCode),
                        ],
                        ..._importButton(context),
                      ],
                    );
                  },
            );
          },
    );
  }

  /// "Import from text" at the end of the list, when the page offers it.
  List<Widget> _importButton(BuildContext context) {
    final VoidCallback? openImport = onImport;
    if (openImport == null) return const <Widget>[];
    return <Widget>[
      const SizedBox(height: InkSpacing.block),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: InkButton.text(
          key: const ValueKey<String>('palette-import-open'),
          label: context.l10n.paletteImportTitle,
          icon: InkIcons.download,
          onPressed: () {
            Navigator.of(context).maybePop();
            openImport();
          },
        ),
      ),
    ];
  }

  Widget _row(
    BuildContext context,
    SavedPalette palette,
    Map<String, String> hexByCode,
  ) {
    final AppLocalizations t = context.l10n;
    final InkColors ink = InkColors.of(context);
    final List<String> hexes = <String>[
      for (final String code in palette.colorCodes)
        hexByCode[code.toUpperCase()] ?? '#CFCFCF',
    ];
    final List<InkMenuItem> items = <InkMenuItem>[
      InkMenuItem(
        key: ValueKey<String>('palette-share-${palette.id}'),
        label: t.paletteShareButton,
        icon: InkIcons.share,
        onSelected: () => onShare(palette),
      ),
      InkMenuItem(
        key: ValueKey<String>('palette-diary-${palette.id}'),
        label: t.diaryAdd,
        icon: InkIcons.plus,
        onSelected: () => onAddToDiary(palette),
      ),
      InkMenuItem(
        key: ValueKey<String>('palette-delete-${palette.id}'),
        label: t.paletteDeleteButton,
        icon: InkIcons.trash2,
        destructive: true,
        onSelected: () => _delete(context, palette),
      ),
    ];
    final Widget details = Padding(
      padding: const EdgeInsets.symmetric(vertical: InkSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            palette.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: ink.fg),
          ),
          const SizedBox(height: InkSpacing.s4),
          _SavedLine(
            key: ValueKey<String>('palette-saved-subtitle-${palette.id}'),
            text: t.paletteSavedSubtitle(
              _kindLabel(context, palette),
              palette.paletteSize,
            ),
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: InkGeometry.target,
                ),
                child: InkWell(
                  key: ValueKey<String>('palette-load-${palette.id}'),
                  onTap: () {
                    onLoad(palette);
                    Navigator.of(context).maybePop();
                  },
                  child: details,
                ),
              ),
            ),
            InkOverflowMenu(
              key: ValueKey<String>('palette-saved-menu-${palette.id}'),
              items: items,
            ),
          ],
        ),
        const SizedBox(height: InkSpacing.s8),
        PaletteStrip(
          colors: hexes,
          labels: palette.colorCodes,
          colorHeight: 32,
          labelStyle: AppTypography.data,
        ),
      ],
    );
  }

  /// What kind of palette this is: the scene it came from, or the colour
  /// theory mode. A scene that cannot be resolved reads as "Scenes".
  String _kindLabel(BuildContext context, SavedPalette palette) {
    final String? sceneId = palette.scenarioName;
    if (sceneId == null || sceneId.isEmpty) {
      return context.l10n.modeLabel(palette.mode);
    }
    if (sceneId == PhotoScene.savedName) {
      return context.l10n.paletteFromPhotoTitle;
    }
    // Older saves hold the wire value (`ForestScene`), newer ones the id.
    final Scene? scene = SceneCatalog.isInstalled
        ? SceneCatalog.current.find(
            '${sceneId[0].toLowerCase()}${sceneId.substring(1)}',
          )
        : null;
    return scene == null
        ? context.l10n.paletteTypeScenesGroup
        : context.l10n.scenarioLabel(scene);
  }
}

/// Smallest factor a single line of text is scaled down to before it wraps.
const double _minLineScale = 0.8;
const int _wrapLines = 2;

/// One line of text that shrinks, never cuts, when it is wider than the room
/// it has (the same rule as the palette rows): down to [_minLineScale], and
/// past that two lines with an ellipsis.
class _SavedLine extends StatelessWidget {
  const _SavedLine({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = constraints.maxWidth;
        final TextPainter painter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: direction,
          textScaler: scaler,
          maxLines: 1,
        )..layout();
        final double width = painter.width;
        painter.dispose();
        if (!available.isFinite || width <= available) {
          return Text(text, maxLines: 1, softWrap: false, style: style);
        }
        if (available / width >= _minLineScale) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(text, maxLines: 1, softWrap: false, style: style),
          );
        }
        return Text(
          text,
          maxLines: _wrapLines,
          overflow: TextOverflow.ellipsis,
          style: style.copyWith(
            fontSize: (style.fontSize ?? 14) * _minLineScale,
          ),
        );
      },
    );
  }
}
