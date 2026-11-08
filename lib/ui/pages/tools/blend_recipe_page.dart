import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show LengthLimitingTextInputFormatter, TextInputFormatter;

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../diary/artwork_photo_viewer.dart';
import '../diary/diary_pickers.dart';
import '../diary/diary_widgets.dart';
import '../match/image_picker_service.dart';
import '../settings/dialogs.dart';
import 'collection_snapshot.dart';

/// The form of one blending recipe: a name, the markers in the order they go
/// on the paper (picked from the user's collection, reordered by dragging), a
/// free-text note ("B000 → B01 → B04, E40 on the edges") and, optionally, one
/// photo that stays on the device.
///
/// Saving writes the recipe and pops with `true`; deleting pops with `false`.
class BlendRecipePage extends StatefulWidget {
  const BlendRecipePage({super.key, this.recipe, this.picker});

  /// The recipe being edited; `null` starts a new one.
  final BlendRecipe? recipe;

  /// Photo picker. Production wraps `image_picker`; tests inject a fake.
  final ImagePickerService? picker;

  /// Key of the page body.
  static const Key pageKey = Key('blend-recipe-page');

  /// Pushes the form on the nearest navigator.
  static Future<void> open(
    BuildContext context, {
    BlendRecipe? recipe,
    ImagePickerService? picker,
  }) => AppScope.push(context, BlendRecipePage(recipe: recipe, picker: picker));

  @override
  State<BlendRecipePage> createState() => _BlendRecipePageState();
}

/// The photo of the form: already stored (it has a [name]) or just picked.
class _DraftPhoto {
  const _DraftPhoto({this.name, required this.bytes});

  final String? name;
  final Uint8List bytes;
}

class _BlendRecipePageState extends State<BlendRecipePage> {
  late final TextEditingController _title = TextEditingController(
    text: widget.recipe?.title ?? '',
  )..addListener(_changed);
  late final TextEditingController _note = TextEditingController(
    text: widget.recipe?.note ?? '',
  );
  late List<String> _markerIds = List<String>.of(
    widget.recipe?.markerIds ?? const <String>[],
  );
  Map<String, MarkerColor> _colors = const <String, MarkerColor>{};
  late final ImagePickerService _picker =
      widget.picker ?? PlatformImagePickerService(null, 85);
  _DraftPhoto? _photo;
  bool _photoReady = true;
  bool _picking = false;
  bool _saving = false;
  String? _error;
  AppScope? _scope;

  bool get _isNew => widget.recipe == null;

  void _changed() => setState(() {});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (identical(scope, _scope)) return;
    final bool first = _scope == null;
    _scope = scope;
    if (first) {
      _loadColors();
      final String? name = widget.recipe?.photo;
      if (name != null) {
        _photoReady = false;
        _loadPhoto(scope, name);
      }
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _loadPhoto(AppScope scope, String name) async {
    final Uint8List? bytes = await scope.blendRecipes.photoBytes(name);
    if (!mounted) return;
    setState(() {
      // A photo whose file is gone shows no photo; saving then drops it.
      _photo = bytes == null ? null : _DraftPhoto(name: name, bytes: bytes);
      _photoReady = true;
    });
  }

  Future<void> _loadColors() async {
    final Map<String, MarkerColor> found = await loadMarkerColors(
      _scope!,
      _markerIds,
    );
    if (!mounted) return;
    setState(() => _colors = found);
  }

  bool get _canSave => _title.text.trim().isNotEmpty && _photoReady && !_saving;

  Future<void> _chooseMarkers() async {
    final AppScope scope = AppScope.of(context);
    final CollectionSnapshot snapshot = await CollectionSnapshot.load(scope);
    if (!mounted) return;
    // The collection, or the whole range of the brand while it is empty.
    final List<MarkerColor> markers = snapshot.owned.isNotEmpty
        ? snapshot.owned
        : snapshot.rangeOf(snapshot.activeBrand);
    final bool mixed =
        markers.map((MarkerColor c) => c.brandId).toSet().length > 1;
    await showInkSheet<void>(
      context: context,
      builder: (BuildContext context) => DiaryMarkerPickerSheet(
        markers: markers,
        selected: _markerIds.toSet(),
        title: context.l10n.toolsBlendsMarkersTitle,
        showBrand: mixed,
        onChanged: (Set<String> picked) {
          setState(() {
            _markerIds = <String>[
              for (final String id in _markerIds)
                if (picked.contains(id)) id,
              for (final String id in picked)
                if (!_markerIds.contains(id) &&
                    _markerIds.length < BlendRecipe.maxMarkers)
                  id,
            ];
          });
          _loadColors();
        },
      ),
    );
  }

  Future<void> _pickPhoto(PhotoSource source) async {
    if (_picking) return;
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
          _photo = _DraftPhoto(bytes: bytes);
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

  Future<void> _save() async {
    if (!_canSave) return;
    final AppScope scope = AppScope.of(context);
    final NavigatorState navigator = Navigator.of(context);
    setState(() => _saving = true);
    final _DraftPhoto? photo = _photo;
    final String? photoName = photo == null
        ? null
        : photo.name ?? await scope.blendRecipes.addPhoto(photo.bytes);
    final BlendRecipe? previous = widget.recipe;
    final int now = DateTime.now().millisecondsSinceEpoch;
    await scope.blendRecipes.save(
      BlendRecipe(
        id: previous?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        title: _title.text.trim(),
        markerIds: _markerIds,
        note: _note.text.trim(),
        photo: photoName,
        createdAtEpochMs: previous?.createdAtEpochMs ?? now,
        updatedAtEpochMs: now,
      ),
    );
    navigator.pop(true);
  }

  Future<void> _delete() async {
    final BlendRecipe? recipe = widget.recipe;
    if (recipe == null) return;
    final AppScope scope = AppScope.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final AppLocalizations l10n = context.l10n;
    final bool confirmed = await confirmAction(
      context,
      title: l10n.toolsBlendsDeleteTitle,
      body: l10n.toolsBlendsDeleteBody,
      confirmLabel: l10n.diaryDeleteConfirm,
    );
    if (!confirmed) return;
    await scope.blendRecipes.delete(recipe.id);
    navigator.pop(false);
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      final String id = _markerIds.removeAt(oldIndex);
      _markerIds.insert(newIndex, id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.toolsBlendsNew : l10n.toolsBlendsEditTitle),
        actions: <Widget>[
          if (!_isNew) ...<Widget>[
            InkOverflowMenu(
              key: const ValueKey<String>('recipe-overflow'),
              items: <InkMenuItem>[
                InkMenuItem(
                  key: const ValueKey<String>('recipe-delete'),
                  label: l10n.toolsBlendsDelete,
                  icon: InkIcons.trash2,
                  destructive: true,
                  onSelected: _delete,
                ),
              ],
            ),
            const SizedBox(width: InkSpacing.s4),
          ],
        ],
      ),
      body: InkReadableWidth(
        child: SafeArea(
          child: SingleChildScrollView(
            key: BlendRecipePage.pageKey,
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
                  key: const ValueKey<String>('recipe-title'),
                  controller: _title,
                  autofocus: _isNew,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(
                      BlendRecipe.maxTitleLength,
                    ),
                  ],
                  style: AppTypography.body.copyWith(color: ink.fg),
                  decoration: InputDecoration(labelText: l10n.toolsBlendsName),
                ),
                const SizedBox(height: InkSpacing.section),
                InkSectionHeading(l10n.toolsBlendsMarkersTitle),
                const SizedBox(height: InkSpacing.group),
                Text(
                  l10n.toolsBlendsMarkersHelp,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
                if (_markerIds.isNotEmpty) ...<Widget>[
                  const SizedBox(height: InkSpacing.group),
                  ReorderableListView.builder(
                    key: const ValueKey<String>('recipe-markers'),
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false,
                    itemCount: _markerIds.length,
                    onReorderItem: _reorder,
                    itemBuilder: (BuildContext context, int index) {
                      final String id = _markerIds[index];
                      return _MarkerRow(
                        key: ValueKey<String>('recipe-marker-$id'),
                        index: index,
                        id: id,
                        marker: _colors[id],
                        onRemove: () {
                          setState(() => _markerIds.removeAt(index));
                        },
                      );
                    },
                  ),
                ],
                const SizedBox(height: InkSpacing.group),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkButton.secondary(
                    key: const ValueKey<String>('recipe-markers-choose'),
                    label: l10n.diaryMarkersChoose,
                    icon: InkIcons.plus,
                    onPressed: _chooseMarkers,
                  ),
                ),
                const SizedBox(height: InkSpacing.section),
                TextField(
                  key: const ValueKey<String>('recipe-note'),
                  controller: _note,
                  // A fixed height, so what is typed never moves the page; a
                  // longer note scrolls inside the field.
                  minLines: 4,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(BlendRecipe.maxNoteLength),
                  ],
                  style: AppTypography.body.copyWith(color: ink.fg),
                  decoration: InputDecoration(
                    labelText: l10n.toolsBlendsNote,
                    hintText: 'B000 → B01 → B04, E40',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: InkSpacing.section),
                InkSectionHeading(l10n.toolsBlendsPhotoTitle),
                const SizedBox(height: InkSpacing.group),
                Text(
                  l10n.toolsBlendsPhotoHelp,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
                if (_photo != null) ...<Widget>[
                  const SizedBox(height: InkSpacing.block),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _thumb(_photo!),
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
                        key: const ValueKey<String>('recipe-photo-camera'),
                        label: l10n.matchCameraButton,
                        icon: InkIcons.camera,
                        variant: InkButtonVariant.smallSecondary,
                        expand: true,
                        onPressed: _picking
                            ? null
                            : () => _pickPhoto(PhotoSource.camera),
                      ),
                    ),
                    const SizedBox(width: InkSpacing.buttonGap),
                    Expanded(
                      child: InkButton(
                        key: const ValueKey<String>('recipe-photo-gallery'),
                        label: l10n.matchGalleryButton,
                        icon: InkIcons.image,
                        variant: InkButtonVariant.smallSecondary,
                        expand: true,
                        onPressed: _picking
                            ? null
                            : () => _pickPhoto(PhotoSource.gallery),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: InkSpacing.section),
                InkButton(
                  key: const ValueKey<String>('recipe-save'),
                  label: l10n.toolsBlendsSave,
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

  Widget _thumb(_DraftPhoto photo) {
    final InkColors ink = InkColors.of(context);
    const double size = 96;
    return SizedBox.square(
      dimension: size,
      child: Stack(
        children: <Widget>[
          DiaryPhotoImage(
            key: const ValueKey<String>('recipe-photo'),
            bytes: photo.bytes,
            size: size,
            semanticLabel: context.l10n.toolsBlendsPhotoSemantic,
            onTap: () => ArtworkPhotoViewer.open(
              context,
              photos: <Uint8List>[photo.bytes],
            ),
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
                key: const ValueKey<String>('recipe-photo-remove'),
                icon: InkIcons.x,
                tooltip: context.l10n.diaryPhotoRemove,
                onPressed: () => setState(() => _photo = null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// One marker of the recipe: its place in the order, colour, code and name,
/// a handle to drag it and an x to take it out.
class _MarkerRow extends StatelessWidget {
  const _MarkerRow({
    super.key,
    required this.index,
    required this.id,
    required this.marker,
    required this.onRemove,
  });

  final int index;
  final String id;
  final MarkerColor? marker;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final String code = marker?.newCode ?? id.substring(id.indexOf(':') + 1);
    final String name = marker?.newName ?? '';
    return Semantics(
      container: true,
      label: '${index + 1}. $code $name'.trim(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: InkGeometry.target + 8),
        child: Row(
          children: <Widget>[
            ReorderableDragStartListener(
              index: index,
              child: SizedBox.square(
                dimension: InkGeometry.target,
                child: Tooltip(
                  message: l10n.toolsBlendsDrag,
                  child: Center(
                    child: InkIcon(
                      InkIcons.list,
                      size: InkGeometry.mediumIcon,
                      color: ink.fg2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: InkSpacing.s24,
              child: Text(
                '${index + 1}',
                style: AppTypography.data.copyWith(color: ink.fg2),
              ),
            ),
            if (marker != null) ...<Widget>[
              SwatchBlock(
                hex: marker!.hex,
                size: InkGeometry.swatchMd,
                radius: InkRadii.xs,
                own: marker!.hasOwnColor,
              ),
              const SizedBox(width: InkSpacing.s12),
            ],
            Text(code, style: AppTypography.code.copyWith(color: ink.fg)),
            const SizedBox(width: InkSpacing.s10),
            Expanded(
              child: Tooltip(
                message: name,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
              ),
            ),
            InkIconButton(
              icon: InkIcons.x,
              tooltip: l10n.toolsBlendsRemoveMarker(code),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
