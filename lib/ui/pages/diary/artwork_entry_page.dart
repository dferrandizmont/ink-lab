import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../share/diary_entry_card_layout.dart';
import '../../share/share_actions.dart';
import '../../share/share_sink.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/section_card.dart';
import '../match/image_picker_service.dart';
import '../settings/dialogs.dart';
import 'artwork_photo_viewer.dart';
import 'diary_pickers.dart';
import 'diary_widgets.dart';

/// The form of one diary entry: a new one or one being edited.
///
/// Title (required), date, what it was painted on, status, the markers used,
/// a linked saved palette, notes and up to four photos. Photos picked here
/// stay in memory until "Save entry": only then are they copied into the
/// app's private folder, so leaving without saving leaves nothing behind.
/// The page pops with `true` when an entry was saved.
class ArtworkEntryPage extends StatefulWidget {
  const ArtworkEntryPage({
    super.key,
    this.entry,
    this.title,
    this.palette,
    this.picker,
    this.shareSink,
  });

  /// Key of the page body, handy for tests.
  static const Key pageKey = Key('diary-entry-page');

  /// The entry being edited, or `null` for a new one.
  final ArtworkEntry? entry;

  /// A title to start a new entry with (an idea's name).
  final String? title;

  /// A saved palette a new entry starts linked to, with its markers.
  final SavedPalette? palette;

  /// Photo picker. Production wraps `image_picker`; tests inject a fake.
  final ImagePickerService? picker;

  /// Where "Share" sends the image: the system share sheet unless a test
  /// injects a fake.
  final ShareSink? shareSink;

  /// Opens the form; returns whether an entry was saved.
  static Future<bool> open(
    BuildContext context, {
    ArtworkEntry? entry,
    String? title,
    SavedPalette? palette,
    ImagePickerService? picker,
    ShareSink? shareSink,
  }) async {
    // Keep the services of this context above the form, also when they sit
    // below the navigator (tests, previews).
    final AppScope? scope = context.getInheritedWidgetOfExactType<AppScope>();
    final bool? saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          final Widget page = ArtworkEntryPage(
            entry: entry,
            title: title,
            palette: palette,
            picker: picker,
            shareSink: shareSink,
          );
          return scope == null ? page : scope.wrap(page);
        },
      ),
    );
    return saved ?? false;
  }

  @override
  State<ArtworkEntryPage> createState() => _ArtworkEntryPageState();
}

/// A photo of the form: already stored (it has a [name]) or just picked.
class _DraftPhoto {
  const _DraftPhoto({this.name, required this.bytes});

  final String? name;
  final Uint8List bytes;
}

class _ArtworkEntryPageState extends State<ArtworkEntryPage> {
  static const double _thumb = 88;

  late final TextEditingController _title = TextEditingController(
    text: widget.entry?.title ?? widget.title ?? '',
  );
  late final TextEditingController _onWhat = TextEditingController(
    text: widget.entry?.onWhat ?? '',
  );
  late final TextEditingController _notes = TextEditingController(
    text: widget.entry?.notes ?? '',
  );
  late final ImagePickerService _picker =
      widget.picker ?? PlatformImagePickerService(null, 85);

  late DateTime _date = widget.entry?.date ?? DateTime.now();
  late ArtworkStatus _status = widget.entry?.status ?? ArtworkStatus.finished;
  late List<String> _markerIds = <String>[
    ...?widget.entry?.markerIds,
    if (widget.entry == null && widget.palette != null)
      ...paletteMarkerIds(widget.palette!),
  ];
  late String? _paletteId = widget.entry?.paletteId ?? widget.palette?.id;
  final List<_DraftPhoto> _photos = <_DraftPhoto>[];

  AppScope? _scope;
  late bool _photosReady = (widget.entry?.photos ?? const <String>[]).isEmpty;
  bool _picking = false;
  bool _saving = false;
  bool _sharing = false;
  String? _error;

  /// Whether the "More details" block of the form is open: folded while every
  /// field it holds is empty, open as soon as one of them has a value.
  late bool _detailsOpen;

  bool get _isNew => widget.entry == null;

  late final ShareSink _shareSink = widget.shareSink ?? const SystemShareSink();

  static bool _isToday(DateTime date) {
    final DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  void initState() {
    super.initState();
    _markerIds = _markerIds.toSet().toList();
    _detailsOpen =
        _onWhat.text.trim().isNotEmpty ||
        _notes.text.trim().isNotEmpty ||
        _paletteId != null ||
        !_isToday(_date);
    _title.addListener(_onTitleChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (identical(scope, _scope)) return;
    _scope = scope;
    if (!_photosReady) _loadPhotos(scope);
  }

  @override
  void dispose() {
    _title
      ..removeListener(_onTitleChanged)
      ..dispose();
    _onWhat.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _onTitleChanged() => setState(() {});

  /// Reads the stored photos of the entry; a file that is gone shows no photo
  /// and is dropped when the entry is saved.
  Future<void> _loadPhotos(AppScope scope) async {
    final List<String> names = widget.entry?.photos ?? const <String>[];
    final List<_DraftPhoto> loaded = <_DraftPhoto>[];
    for (final String name in names) {
      final Uint8List? bytes = await scope.artworkDiary.photoBytes(name);
      if (bytes != null) loaded.add(_DraftPhoto(name: name, bytes: bytes));
    }
    if (!mounted) return;
    setState(() {
      _photos
        ..clear()
        ..addAll(loaded);
      _photosReady = true;
    });
  }

  // ---------------------------------------------------------------------------
  // Fields
  // ---------------------------------------------------------------------------

  Future<void> _pickDate() async {
    final DateTime today = DateTime.now();
    final DateTime last = _date.isAfter(today) ? _date : today;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(last.year, last.month, last.day),
    );
    if (picked == null || !mounted) return;
    setState(() => _date = picked);
  }

  Future<void> _chooseMarkers() async {
    final AppScope scope = AppScope.of(context);
    final MarkerBrand brand = scope.settings.brand;
    List<MarkerColor> catalog;
    try {
      catalog = await scope.markers.loadColors(brand);
    } catch (_) {
      catalog = const <MarkerColor>[];
    }
    if (!mounted) return;
    final AppSettings settings = scope.settings.settings;
    List<MarkerColor> markers = ownedColors(
      colors: catalog,
      brand: brand,
      ownedSetIds: settings.effectiveSetIds(),
      ownedMarkerCodes: settings.ownedMarkerCodes,
    );
    if (markers.isEmpty) {
      markers = brandRangeColors(colors: catalog, brand: brand);
    }
    await showInkSheet<void>(
      context: context,
      builder: (BuildContext context) => DiaryMarkerPickerSheet(
        markers: markers,
        selected: _markerIds.toSet(),
        onChanged: (Set<String> picked) => setState(() {
          _markerIds = <String>[
            for (final String id in _markerIds)
              if (picked.contains(id)) id,
            for (final String id in picked)
              if (!_markerIds.contains(id)) id,
          ];
        }),
      ),
    );
  }

  Future<void> _choosePalette() async {
    final AppScope scope = AppScope.of(context);
    final MarkerBrand current = scope.settings.brand;
    // The palettes of the current brand first, then those of every other
    // brand that has any: a brand without a saved palette adds nothing, so
    // the 15 brands never leave an empty section.
    final List<SavedPalette> palettes = <SavedPalette>[
      ...scope.savedPalettes.palettesOf(current),
      for (final MarkerBrand brand in MarkerBrand.values)
        if (brand != current) ...scope.savedPalettes.palettesOf(brand),
    ];
    final DiaryPaletteChoice? choice = await showInkSheet<DiaryPaletteChoice>(
      context: context,
      builder: (BuildContext context) =>
          DiaryPalettePickerSheet(palettes: palettes, selectedId: _paletteId),
    );
    if (choice == null || !mounted) return;
    setState(() => _paletteId = choice.paletteId);
  }

  // ---------------------------------------------------------------------------
  // Photos
  // ---------------------------------------------------------------------------

  Future<void> _pickPhoto(PhotoSource source) async {
    if (_picking || _photos.length >= ArtworkEntry.maxPhotos) return;
    setState(() {
      _picking = true;
      _error = null;
    });
    final PhotoPickResult result = await _picker.pick(source);
    if (!mounted) return;
    switch (result) {
      case PhotoPicked(:final Uint8List bytes):
        setState(() {
          _picking = false;
          if (_photos.length < ArtworkEntry.maxPhotos) {
            _photos.add(_DraftPhoto(bytes: bytes));
          }
        });
      case PhotoPickCancelled():
        setState(() => _picking = false);
      case PhotoPickDenied(:final PhotoSource source):
        setState(() {
          _picking = false;
          _error = source == PhotoSource.camera
              ? context.l10n.matchCameraDenied
              : context.l10n.matchGalleryDenied;
        });
      case PhotoPickFailed():
        setState(() {
          _picking = false;
          _error = context.l10n.matchPickFailed;
        });
    }
  }

  void _openViewer(int index) => ArtworkPhotoViewer.open(
    context,
    photos: <Uint8List>[for (final _DraftPhoto p in _photos) p.bytes],
    initialIndex: index,
  );

  // ---------------------------------------------------------------------------
  // Save and delete
  // ---------------------------------------------------------------------------

  bool get _canSave =>
      _title.text.trim().isNotEmpty && _photosReady && !_saving;

  Future<void> _save() async {
    if (!_canSave) return;
    final AppScope scope = AppScope.of(context);
    final NavigatorState navigator = Navigator.of(context);
    setState(() => _saving = true);
    final List<String> names = <String>[];
    for (final _DraftPhoto photo in _photos) {
      names.add(photo.name ?? await scope.artworkDiary.addPhoto(photo.bytes));
    }
    final ArtworkEntry? previous = widget.entry;
    final DateTime now = DateTime.now();
    await scope.artworkDiary.save(
      ArtworkEntry(
        id: previous?.id ?? now.microsecondsSinceEpoch.toString(),
        title: _title.text.trim(),
        date: _date,
        onWhat: _onWhat.text.trim(),
        status: _status,
        markerIds: _markerIds,
        paletteId: _paletteId,
        notes: _notes.text.trim(),
        photos: names,
        createdAtEpochMs:
            previous?.createdAtEpochMs ?? now.millisecondsSinceEpoch,
      ),
    );
    navigator.pop(true);
    // Only new work triggers the review policy.
    if (previous == null) unawaited(scope.reviewPrompt?.onSuccess());
  }

  Future<void> _delete() async {
    final ArtworkEntry? entry = widget.entry;
    if (entry == null) return;
    final AppScope scope = AppScope.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final bool confirmed = await confirmAction(
      context,
      title: context.l10n.diaryDeleteTitle,
      body: context.l10n.diaryDeleteBody,
      confirmLabel: context.l10n.diaryDeleteConfirm,
    );
    if (!confirmed) return;
    await scope.artworkDiary.delete(entry.id);
    navigator.pop(false);
  }

  // ---------------------------------------------------------------------------
  // Share
  // ---------------------------------------------------------------------------

  bool get _canShare =>
      _title.text.trim().isNotEmpty && _photosReady && !_saving && !_sharing;

  /// Renders the entry as it is on screen (title, date, status, first photo,
  /// markers and palette) and opens the share sheet. Only on this tap: the
  /// photo is read from memory, drawn into the image and never sent anywhere
  /// else.
  Future<void> _share() async {
    if (!_canShare) return;
    final AppScope scope = AppScope.of(context);
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final String date = MaterialLocalizations.of(context)
        .formatMediumDate(_date);
    final String status = _status == ArtworkStatus.inProgress
        ? l10n.diaryStatusInProgress
        : l10n.diaryStatusFinished;
    final String? linked = _paletteId;
    final SavedPalette? palette = linked == null
        ? null
        : findSavedPalette(scope, linked);
    final List<String> paletteIds = palette == null
        ? const <String>[]
        : paletteMarkerIds(palette);
    final String title = _title.text.trim();
    final String onWhat = _onWhat.text.trim();
    final List<String> markerIds = List<String>.of(_markerIds);
    final Uint8List? photo = _photos.isEmpty ? null : _photos.first.bytes;
    setState(() => _sharing = true);
    try {
      final Map<String, MarkerColor> colors = await loadMarkerColors(scope, [
        ...markerIds,
        ...paletteIds,
      ]);
      final List<MarkerColor> known = <MarkerColor>[
        for (final String id in markerIds) ?colors[id],
      ];
      final List<MarkerColor> shown = known
          .take(DiaryEntryCardLayout.maxMarkers)
          .toList();
      final int more = known.length - shown.length;
      await shareDiaryEntryCard(
        _shareSink,
        DiaryEntryCardData(
          title: title,
          meta: '$date · $status',
          onWhat: onWhat,
          photo: photo,
          markers: <DiaryEntryCardMarker>[
            for (final MarkerColor color in shown)
              DiaryEntryCardMarker(
                code: color.newCode,
                name: color.newName,
                hex: color.hex,
              ),
          ],
          moreMarkers: more,
          moreText: more > 0 ? l10n.diaryShareMore(more) : '',
          markersLabel: l10n.diaryMarkersTitle,
          paletteLabel: l10n.diaryPaletteTitle,
          paletteName: palette?.name ?? '',
          paletteHexes: <String>[
            for (final String id in paletteIds) ?colors[id]?.hex,
          ],
        ),
      );
    } catch (_) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            key: const ValueKey<String>('diary-share-failed'),
            content: Text(l10n.shareFailed),
          ),
        );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final AppScope scope = AppScope.of(context);
    final String? linked = _paletteId;
    final SavedPalette? palette = linked == null
        ? null
        : findSavedPalette(scope, linked);
    final bool paletteGone = linked != null && palette == null;
    final bool full = _photos.length >= ArtworkEntry.maxPhotos;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.diaryNewTitle : l10n.diaryEditTitle),
        actions: <Widget>[
          InkOverflowMenu(
            key: const ValueKey<String>('diary-overflow'),
            items: <InkMenuItem>[
              InkMenuItem(
                key: const ValueKey<String>('diary-share'),
                label: l10n.diaryShareButton,
                icon: InkIcons.share,
                // Nothing to share until the entry has a title (and while it
                // is saving or sharing): the item stays, dimmed, so the menu
                // does not change size.
                enabled: _canShare,
                onSelected: _share,
              ),
              if (!_isNew)
                InkMenuItem(
                  key: const ValueKey<String>('diary-delete'),
                  label: l10n.diaryDelete,
                  icon: InkIcons.trash2,
                  destructive: true,
                  onSelected: _delete,
                ),
            ],
          ),
          const SizedBox(width: InkSpacing.s4),
        ],
      ),
      body: InkReadableWidth(
        child: SafeArea(
          child: SingleChildScrollView(
            key: ArtworkEntryPage.pageKey,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(
              InkSpacing.gutter,
              InkSpacing.group,
              InkSpacing.gutter,
              InkSpacing.pageBottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  key: const ValueKey<String>('diary-title'),
                  controller: _title,
                  autofocus: _isNew,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(120),
                  ],
                  style: AppTypography.body.copyWith(color: ink.fg),
                  decoration: InputDecoration(labelText: l10n.diaryTitleLabel),
                ),
                const SizedBox(height: InkSpacing.section),
                // Title, then the photos and the markers used: the essentials of
                // an entry. Everything else is one tap away in "More details".
                InkSectionHeading(l10n.diaryPhotosTitle),
                const SizedBox(height: InkSpacing.group),
                Text(
                  l10n.diaryPhotosHelp(ArtworkEntry.maxPhotos),
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
                if (_photos.isNotEmpty) ...<Widget>[
                  const SizedBox(height: InkSpacing.block),
                  Wrap(
                    spacing: InkSpacing.s8,
                    runSpacing: InkSpacing.s8,
                    children: <Widget>[
                      for (int i = 0; i < _photos.length; i++) _buildThumb(i),
                    ],
                  ),
                ],
                if (_error != null) ...<Widget>[
                  const SizedBox(height: InkSpacing.group),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkIcon(
                        InkIcons.alertCircle,
                        size: InkGeometry.smallIcon,
                        color: ink.error,
                      ),
                      const SizedBox(width: InkSpacing.s8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: InkSpacing.block),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: InkButton(
                        key: const ValueKey<String>('diary-photo-camera'),
                        label: l10n.matchCameraButton,
                        icon: InkIcons.camera,
                        variant: InkButtonVariant.smallSecondary,
                        expand: true,
                        onPressed: _picking || full
                            ? null
                            : () => _pickPhoto(PhotoSource.camera),
                      ),
                    ),
                    const SizedBox(width: InkSpacing.buttonGap),
                    Expanded(
                      child: InkButton(
                        key: const ValueKey<String>('diary-photo-gallery'),
                        label: l10n.matchGalleryButton,
                        icon: InkIcons.image,
                        variant: InkButtonVariant.smallSecondary,
                        expand: true,
                        onPressed: _picking || full
                            ? null
                            : () => _pickPhoto(PhotoSource.gallery),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: InkSpacing.section),
                InkSectionHeading(l10n.diaryMarkersTitle),
                const SizedBox(height: InkSpacing.group),
                if (_markerIds.isNotEmpty) ...<Widget>[
                  _buildMarkerChips(),
                  const SizedBox(height: InkSpacing.group),
                ],
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkButton.secondary(
                    key: const ValueKey<String>('diary-markers-choose'),
                    label: l10n.diaryMarkersChoose,
                    icon: InkIcons.plus,
                    onPressed: _chooseMarkers,
                  ),
                ),
                const SizedBox(height: InkSpacing.section),
                _caps(l10n.diaryStatusLabel),
                const SizedBox(height: InkSpacing.group),
                InkSegmented<ArtworkStatus>(
                  key: const ValueKey<String>('diary-status'),
                  expand: true,
                  semanticLabel: l10n.diaryStatusLabel,
                  segments: <InkSegment<ArtworkStatus>>[
                    InkSegment<ArtworkStatus>(
                      value: ArtworkStatus.finished,
                      label: l10n.diaryStatusFinished,
                    ),
                    InkSegment<ArtworkStatus>(
                      value: ArtworkStatus.inProgress,
                      label: l10n.diaryStatusInProgress,
                    ),
                  ],
                  selected: _status,
                  onChanged: (ArtworkStatus value) =>
                      setState(() => _status = value),
                ),
                const SizedBox(height: InkSpacing.section),
                InkDisclosure(
                  key: const ValueKey<String>('diary-details'),
                  title: l10n.diaryMoreDetails,
                  expanded: _detailsOpen,
                  padding: EdgeInsets.zero,
                  onToggle: () => setState(() => _detailsOpen = !_detailsOpen),
                  child: Padding(
                    padding: const EdgeInsets.only(top: InkSpacing.block),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          key: const ValueKey<String>('diary-on-what'),
                          controller: _onWhat,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(120),
                          ],
                          style: AppTypography.body.copyWith(color: ink.fg),
                          decoration: InputDecoration(
                            labelText: l10n.diaryOnWhatLabel,
                            hintText: l10n.diaryOnWhatHint,
                          ),
                        ),
                        const SizedBox(height: InkSpacing.buttonGap),
                        InkListCard(
                          children: <Widget>[
                            InkListRow(
                              key: const ValueKey<String>('diary-date'),
                              label: l10n.diaryDateLabel,
                              value: MaterialLocalizations.of(context)
                                  .formatMediumDate(_date),
                              chevron: true,
                              onTap: _pickDate,
                            ),
                          ],
                        ),
                        const SizedBox(height: InkSpacing.buttonGap),
                        InkListCard(
                          children: <Widget>[
                            InkListRow(
                              key: const ValueKey<String>('diary-palette'),
                              label: l10n.diaryPaletteTitle,
                              value: palette?.name ?? l10n.diaryPaletteNone,
                              subtitle: paletteGone
                                  ? l10n.diaryPaletteMissing
                                  : null,
                              chevron: true,
                              onTap: _choosePalette,
                            ),
                          ],
                        ),
                        if (palette != null) ...<Widget>[
                          const SizedBox(height: InkSpacing.group),
                          DiaryPaletteStrip(palette: palette, colorHeight: 24),
                        ],
                        const SizedBox(height: InkSpacing.buttonGap),
                        TextField(
                          key: const ValueKey<String>('diary-notes'),
                          controller: _notes,
                          minLines: 3,
                          maxLines: 8,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(2000),
                          ],
                          style: AppTypography.body.copyWith(color: ink.fg),
                          decoration: InputDecoration(
                            labelText: l10n.diaryNotesLabel,
                            hintText: l10n.diaryNotesHint,
                            alignLabelWithHint: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: InkSpacing.section),
                // Save entry is the only primary action of the form; share and
                // delete live in the header's "More actions".
                InkButton(
                  key: const ValueKey<String>('diary-save'),
                  label: l10n.diarySave,
                  expand: true,
                  onPressed: _canSave ? _save : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _caps(String text) => Text(
    AppTypography.caps(text),
    style: AppTypography.capsStyle.copyWith(color: InkColors.of(context).fg2),
  );

  Widget _buildMarkerChips() {
    return MarkerLookup(
      ids: _markerIds,
      builder: (BuildContext context, Map<String, MarkerColor> colors) {
        return Wrap(
          spacing: InkSpacing.chipGap,
          runSpacing: InkSpacing.s4,
          children: <Widget>[
            for (final String id in _markerIds)
              _MarkerChip(
                key: ValueKey<String>('diary-marker-chip-$id'),
                code: colors[id]?.newCode ?? id.substring(id.indexOf(':') + 1),
                hex: colors[id]?.hex,
                onRemove: () => setState(() => _markerIds.remove(id)),
              ),
          ],
        );
      },
    );
  }

  Widget _buildThumb(int index) {
    final InkColors ink = InkColors.of(context);
    return SizedBox.square(
      dimension: _thumb,
      child: Stack(
        children: <Widget>[
          DiaryPhotoImage(
            key: ValueKey<String>('diary-photo-$index'),
            bytes: _photos[index].bytes,
            size: _thumb,
            semanticLabel: context.l10n.diaryPhotoSemantic(
              index + 1,
              _photos.length,
            ),
            onTap: () => _openViewer(index),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ink.surface.withValues(alpha: InkOpacity.overPhoto),
                borderRadius: InkRadii.controlRadius,
              ),
              child: InkIconButton(
                key: ValueKey<String>('diary-photo-remove-$index'),
                icon: InkIcons.x,
                tooltip: context.l10n.diaryPhotoRemove,
                onPressed: () => setState(() => _photos.removeAt(index)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A removable marker of the form: its colour and code, and an x. 36 high
/// inside a 44 hit area, like [InkChip].
class _MarkerChip extends StatelessWidget {
  const _MarkerChip({
    super.key,
    required this.code,
    required this.hex,
    required this.onRemove,
  });

  final String code;

  /// The colour, or `null` when the catalogue does not know the marker.
  final String? hex;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      button: true,
      label: context.l10n.diaryMarkerRemove(code),
      excludeSemantics: true,
      child: InkWell(
        onTap: onRemove,
        customBorder: const RoundedRectangleBorder(
          borderRadius: InkRadii.controlRadius,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: InkGeometry.target,
            minHeight: InkGeometry.target,
          ),
          child: Center(
            widthFactor: 1,
            child: Container(
              height: InkGeometry.chipHeight,
              padding: const EdgeInsets.symmetric(horizontal: InkSpacing.s10),
              decoration: ShapeDecoration(
                color: ink.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: InkRadii.controlRadius,
                  side: BorderSide(color: ink.line),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (hex != null) ...<Widget>[
                    SwatchBlock(
                      hex: hex!,
                      size: InkGeometry.swatchXs,
                      radius: InkRadii.xs,
                    ),
                    const SizedBox(width: InkSpacing.s6),
                  ],
                  Text(code, style: AppTypography.data.copyWith(color: ink.fg)),
                  const SizedBox(width: InkSpacing.s6),
                  InkIcon(
                    InkIcons.x,
                    size: InkGeometry.smallIcon,
                    color: ink.fg2,
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
