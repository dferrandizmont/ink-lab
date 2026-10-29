import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/color_utils.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import 'color_sampling.dart';
import 'image_picker_service.dart';
import 'match_result_tile.dart';
import '../../../l10n/l10n.dart';

/// Composition root above the page, or `null` in isolated previews/tests.
///
/// Mirrors `AppScope.of` without the debug assertion so the page can degrade
/// gracefully when it is pumped without a scope (for example the shell smoke
/// test that only checks the page key).
AppScope? _scopeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<AppScope>();

/// The colour match page: photo in, closest markers out.
///
/// Picks a photo from the camera or the gallery, shows it, lets the user tap or
/// drag a loupe reticle over it to sample the average colour of a small region,
/// then ranks the closest markers of the active collection with
/// [findClosestMarkerMatches]. Tapping a result records a [ColorMatchPick] in
/// the recent picks. Photos are decoded on the device and never uploaded.
class MatchPage extends StatefulWidget {
  const MatchPage({super.key, this.picker, this.decoder});

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('match-page');

  /// Number of matches shown: one best match plus five alternates.
  static const int matchLimit = 6;

  /// Photo picker. Production wraps `image_picker`; tests inject a fake.
  final ImagePickerService? picker;

  /// Decoder from encoded photo bytes to raw pixels. Tests inject a fake.
  final PhotoDecoder? decoder;

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  static const double _radiusFraction = defaultSamplingRadiusFraction;
  static const double _photoHeight = 196;

  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _settingsSubscription;
  Stream<List<ColorMatchPick>>? _historyChanges;
  String _collectionSignature = '';

  MarkerBrand _brand = MarkerBrand.ohuhuOahu;
  List<MarkerColor> _available = const <MarkerColor>[];
  bool _loading = true;

  Uint8List? _bytes;
  SampledImage? _sampled;
  Offset? _pick;
  int? _sampledColorInt;
  List<ColorDistanceMatch> _matches = const <ColorDistanceMatch>[];
  String? _error;
  String? _notice;
  bool _picking = false;

  late final ImagePickerService _picker =
      widget.picker ?? PlatformImagePickerService();
  late final PhotoDecoder _decode = widget.decoder ?? decodePhoto;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope? scope = _scopeOf(context);
    if (scope == null || identical(scope, _scope)) return;
    _scope = scope;
    // Captured once so the StreamBuilder does not resubscribe every build.
    _historyChanges = scope.matchHistory.changes;
    _settingsSubscription?.cancel();
    _collectionSignature = _signatureOf(scope.settings.state);
    _settingsSubscription = scope.settings.changes.listen(_onSettingsChanged);
    unawaited(_reload());
  }

  @override
  void dispose() {
    _settingsSubscription?.cancel();
    super.dispose();
  }

  String _signatureOf(AppSettingsState state) {
    final List<String> sets = state.settings.effectiveSetIds().toList()..sort();
    final List<String> owned = state.settings.ownedMarkerCodes.toList()..sort();
    return '${state.brand.id}|${sets.join(',')}|${owned.join(',')}';
  }

  void _onSettingsChanged(AppSettingsState state) {
    final String signature = _signatureOf(state);
    if (signature == _collectionSignature) return;
    _collectionSignature = signature;
    unawaited(_reload());
  }

  Future<void> _reload() async {
    final AppScope? scope = _scope;
    if (scope == null) return;
    final MarkerBrand brand = scope.settings.brand;
    final AppSettings settings = scope.settings.settings;
    setState(() => _loading = true);
    List<MarkerColor> catalog;
    try {
      catalog = await scope.markers.loadColors(brand);
    } catch (_) {
      catalog = const <MarkerColor>[];
    }
    if (!mounted) return;
    final List<MarkerColor> available = paletteCandidateColors(
      colors: catalog,
      brand: brand,
      activeSetIds: settings.effectiveSetIds(),
      ownedMarkerCodes: settings.ownedMarkerCodes,
    );
    setState(() {
      _brand = brand;
      _available = available;
      _loading = false;
      // A new collection can re-rank the current sample.
      final int? sample = _sampledColorInt;
      _matches = sample == null
          ? const <ColorDistanceMatch>[]
          : findClosestMarkerMatches(
              sample,
              available,
              limit: MatchPage.matchLimit,
            );
    });
  }

  // ---------------------------------------------------------------------------
  // Picking and sampling
  // ---------------------------------------------------------------------------

  Future<void> _pickPhoto(PhotoSource source) async {
    if (_picking) return;
    setState(() {
      _picking = true;
      _error = null;
      _notice = null;
    });
    final PhotoPickResult result = await _picker.pick(source);
    if (!mounted) return;
    switch (result) {
      case PhotoPicked(:final Uint8List bytes):
        await _loadPhoto(bytes);
      case PhotoPickCancelled():
        setState(() {
          _picking = false;
          _notice = context.l10n.matchCancelNotice;
        });
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

  Future<void> _loadPhoto(Uint8List bytes) async {
    SampledImage sampled;
    try {
      sampled = await _decode(bytes);
    } on PhotoDecodeException {
      if (!mounted) return;
      setState(() {
        _picking = false;
        _error = context.l10n.matchDecodeFailed;
      });
      return;
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _picking = false;
        _error = context.l10n.matchDecodeFailed;
      });
      return;
    }
    if (!mounted) return;
    setState(() {
      _bytes = bytes;
      _sampled = sampled;
      _pick = null;
      _sampledColorInt = null;
      _matches = const <ColorDistanceMatch>[];
      _picking = false;
      _error = null;
      _notice = null;
    });
  }

  void _sampleAt(Offset local, Rect fitted) {
    final SampledImage? sampled = _sampled;
    if (sampled == null) return;
    final Offset fraction = fractionForPoint(local, fitted);
    final int colorInt = averageColorOfRegion(
      sampled,
      fraction,
      radiusFraction: _radiusFraction,
    );
    setState(() {
      _pick = fraction;
      _sampledColorInt = colorInt;
      _matches = findClosestMarkerMatches(
        colorInt,
        _available,
        limit: MatchPage.matchLimit,
      );
      _notice = null;
    });
  }

  Future<void> _record(ColorDistanceMatch match) async {
    final AppScope? scope = _scope;
    final int? colorInt = _sampledColorInt;
    if (scope == null || colorInt == null) return;
    final DateTime now = DateTime.now();
    await scope.matchHistory.record(
      ColorMatchPick(
        id: now.microsecondsSinceEpoch.toString(),
        brandId: _brand.id,
        sampledHex: colorIntToHex(colorInt),
        matchedCode: match.color.newCode,
        matchedName: match.color.newName,
        matchedHex: match.color.hex,
        deltaE: match.deltaE,
        createdAtEpochMs: now.millisecondsSinceEpoch,
      ),
    );
    if (!mounted) return;
    setState(() => _notice = context.l10n.matchRecorded(match.color.newCode));
  }

  Future<void> _clearHistory(AppScope scope) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(context.l10n.matchClearDialogTitle),
        content: Text(context.l10n.matchClearDialogBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.matchCancelButton),
          ),
          FilledButton(
            key: const ValueKey<String>('match-history-clear-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.matchClearButton),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await scope.matchHistory.clear();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final AppScope? scope = _scopeOf(context);
    if (scope == null) {
      return Center(
        key: MatchPage.pageKey,
        child: Text(
          context.l10n.matchTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }
    if (_loading) {
      return const Center(
        key: MatchPage.pageKey,
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      key: MatchPage.pageKey,
      padding: const EdgeInsets.only(bottom: InkSpacing.pageBottom),
      children: <Widget>[
        InkPageHeader(
          title: context.l10n.matchTitle,
          subtitle: context.l10n.matchSubtitle(_available.length),
        ),
        if (_picking)
          _StatusLine(
            icon: InkIcons.info,
            message: context.l10n.matchLoadingPhoto,
          ),
        if (_error != null)
          _StatusLine(
            icon: InkIcons.alertCircle,
            message: _error!,
            isError: true,
          ),
        if (_notice != null) _buildNotice(),
        _buildPhoto(),
        if (_sampledColorInt != null)
          _buildSampled(_sampledColorInt!)
        else if (_sampled != null)
          _Gutter(
            top: InkSpacing.block,
            child: _SecondaryText(context.l10n.matchPickToSample),
          ),
        if (_sampled != null && _available.isEmpty)
          _StatusLine(icon: InkIcons.info, message: context.l10n.matchNoMarkers)
        else if (_matches.isNotEmpty) ...<Widget>[
          _buildBestMatch(),
          if (_matches.length > 1) _buildAlternatives(),
        ],
        _buildActions(),
        _buildHistory(scope),
        const _Gutter(top: InkSpacing.section, child: _PrivacyLine()),
      ],
    );
  }

  Widget _buildPhoto() {
    final InkColors ink = InkColors.of(context);
    final bool hasPhoto = _bytes != null && _sampled != null;
    return _Gutter(
      child: Semantics(
        container: true,
        label: context.l10n.matchPhotoSemantics,
        child: Container(
          height: _photoHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: ink.surface,
            borderRadius: InkRadii.cardRadius,
            border: Border.all(color: ink.line),
          ),
          child: hasPhoto
              ? _buildCanvas()
              : EmptyState(
                  icon: InkIcons.image,
                  title: context.l10n.matchEmptyPhotoTitle,
                  message: context.l10n.matchEmptyPhotoMessage,
                ),
        ),
      ),
    );
  }

  Widget _buildCanvas() {
    final SampledImage sampled = _sampled!;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size container = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        final Rect fitted = containRect(container, sampled.aspectRatio);
        final Offset? pick = _pick;
        final Offset? pickLocal = pick == null || fitted.isEmpty
            ? null
            : Offset(
                fitted.left + pick.dx * fitted.width,
                fitted.top + pick.dy * fitted.height,
              );
        return GestureDetector(
          key: const ValueKey<String>('match-canvas'),
          behavior: HitTestBehavior.opaque,
          onTapDown: (TapDownDetails details) =>
              _sampleAt(details.localPosition, fitted),
          onPanStart: (DragStartDetails details) =>
              _sampleAt(details.localPosition, fitted),
          onPanUpdate: (DragUpdateDetails details) =>
              _sampleAt(details.localPosition, fitted),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.memory(
                _bytes!,
                fit: BoxFit.contain,
                gaplessPlayback: true,
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stack,
                ) => ColoredBox(color: InkColors.of(context).surface),
              ),
              if (pickLocal != null && _sampledColorInt != null)
                CustomPaint(
                  painter: _ReticlePainter(
                    centre: pickLocal,
                    sampleColor: Color(0xFF000000 | _sampledColorInt!),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSampled(int colorInt) {
    final InkColors ink = InkColors.of(context);
    final Color sample = Color(0xFF000000 | colorInt);
    final RgbColor rgb = colorIntToRgb(colorInt);
    return _Gutter(
      top: InkSpacing.block,
      child: SizedBox(
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              AppTypography.caps(context.l10n.matchSampledLabel),
              style: AppTypography.capsStyle.copyWith(color: ink.fg2),
            ),
            const SizedBox(width: InkSpacing.s8),
            Container(
              width: InkGeometry.smallIcon,
              height: InkGeometry.smallIcon,
              decoration: BoxDecoration(
                color: sample,
                borderRadius: InkRadii.xsRadius,
                border: Border.all(color: ink.swatchEdge(sample)),
              ),
            ),
            const SizedBox(width: InkSpacing.s8),
            Text(
              '#${colorIntToHex(colorInt)}',
              key: const ValueKey<String>('match-sampled-hex'),
              style: AppTypography.data.copyWith(color: ink.fg),
            ),
            const SizedBox(width: InkSpacing.s8),
            Expanded(
              child: Text(
                context.l10n.commonRgb(rgb.r, rgb.g, rgb.b),
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.data.copyWith(color: ink.fg2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestMatch() {
    final ColorDistanceMatch best = _matches.first;
    return _Gutter(
      top: InkSpacing.block,
      child: BestMatchTile(
        key: ValueKey<String>('match-best-${best.color.newCode}'),
        match: best,
        onRecord: () => _record(best),
      ),
    );
  }

  Widget _buildAlternatives() {
    final List<ColorDistanceMatch> alternates = _matches.skip(1).toList();
    return _Gutter(
      top: InkSpacing.section,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkSectionHeading(
            context.l10n.matchAlternatesTitle,
            trailing: context.l10n.matchDeltaMethod,
          ),
          const SizedBox(height: InkSpacing.headingGap),
          _EqualColumns(
            columns: MatchPage.matchLimit - 1,
            gap: InkSpacing.buttonGap,
            children: <Widget>[
              for (final ColorDistanceMatch match in alternates)
                MatchResultTile(
                  key: ValueKey<String>('match-result-${match.color.newCode}'),
                  match: match,
                  onRecord: () => _record(match),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return _Gutter(
      top: InkSpacing.block,
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkButton(
              key: const ValueKey<String>('match-camera'),
              label: context.l10n.matchCameraButton,
              icon: InkIcons.camera,
              expand: true,
              onPressed: _picking ? null : () => _pickPhoto(PhotoSource.camera),
            ),
          ),
          const SizedBox(width: InkSpacing.buttonGap),
          Expanded(
            child: InkButton.secondary(
              key: const ValueKey<String>('match-gallery'),
              label: context.l10n.matchGalleryButton,
              icon: InkIcons.image,
              expand: true,
              onPressed: _picking
                  ? null
                  : () => _pickPhoto(PhotoSource.gallery),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotice() {
    final InkColors ink = InkColors.of(context);
    return _Gutter(
      bottom: InkSpacing.block,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          InkSpacing.s4,
          InkSpacing.s8,
          InkSpacing.s4,
        ),
        decoration: BoxDecoration(
          color: ink.surface,
          borderRadius: InkRadii.cardRadius,
          border: Border.all(color: ink.line),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                _notice!,
                style: AppTypography.secondary.copyWith(color: ink.fg),
              ),
            ),
            InkButton.text(
              label: context.l10n.matchOkButton,
              onPressed: () => setState(() => _notice = null),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(AppScope scope) {
    return StreamBuilder<List<ColorMatchPick>>(
      stream: _historyChanges,
      initialData: scope.matchHistory.entries,
      builder:
          (BuildContext context, AsyncSnapshot<List<ColorMatchPick>> snapshot) {
            final List<ColorMatchPick> picks =
                snapshot.data ?? scope.matchHistory.entries;
            return _Gutter(
              top: InkSpacing.section,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkSectionHeading(context.l10n.matchRecentTitle),
                      ),
                      if (picks.isNotEmpty)
                        InkButton.text(
                          key: const ValueKey<String>('match-history-clear'),
                          label: context.l10n.matchClearButton,
                          onPressed: () => _clearHistory(scope),
                        ),
                    ],
                  ),
                  const SizedBox(height: InkSpacing.headingGap),
                  if (picks.isEmpty)
                    _SecondaryText(context.l10n.matchRecentEmpty)
                  else
                    _EqualColumns(
                      columns: 6,
                      gap: InkSpacing.s8,
                      rowGap: InkSpacing.buttonGap,
                      children: <Widget>[
                        for (final ColorMatchPick pick in picks)
                          _RecentPickTile(
                            key: ValueKey<String>('match-pick-${pick.id}'),
                            pick: pick,
                            onTap: () => _showPick(scope, pick),
                          ),
                      ],
                    ),
                ],
              ),
            );
          },
    );
  }

  Future<void> _showPick(AppScope scope, ColorMatchPick pick) {
    return showInkSheet<void>(
      context: context,
      closeTooltip: context.l10n.matchCloseTooltip,
      builder: (BuildContext sheetContext) => _PickSheet(
        pick: pick,
        onRemove: () {
          scope.matchHistory.remove(pick.id);
          Navigator.of(sheetContext).pop();
        },
      ),
    );
  }
}

/// Horizontal gutter (and optional vertical gaps) around a block of the page.
class _Gutter extends StatelessWidget {
  const _Gutter({required this.child, this.top = 0, this.bottom = 0});

  final Widget child;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        InkSpacing.gutter,
        top,
        InkSpacing.gutter,
        bottom,
      ),
      child: child,
    );
  }
}

class _SecondaryText extends StatelessWidget {
  const _SecondaryText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.secondary.copyWith(color: InkColors.of(context).fg2),
    );
  }
}

/// "Photos stay on this phone." with its lock icon.
class _PrivacyLine extends StatelessWidget {
  const _PrivacyLine();

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Row(
      children: <Widget>[
        InkIcon(InkIcons.lock, size: InkGeometry.smallIcon, color: ink.fg2),
        const SizedBox(width: InkSpacing.s8),
        Expanded(
          child: Text(
            context.l10n.matchPrivacyCaption,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ),
      ],
    );
  }
}

/// Lays [children] out in rows of [columns] equal cells.
class _EqualColumns extends StatelessWidget {
  const _EqualColumns({
    required this.columns,
    required this.gap,
    required this.children,
    this.rowGap = 0,
  });

  final int columns;
  final double gap;
  final double rowGap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int start = 0; start < children.length; start += columns) {
      final List<Widget> cells = <Widget>[];
      for (int i = 0; i < columns; i++) {
        if (i > 0) cells.add(SizedBox(width: gap));
        final int index = start + i;
        cells.add(
          Expanded(
            child: index < children.length
                ? children[index]
                : const SizedBox.shrink(),
          ),
        );
      }
      if (rows.isNotEmpty) rows.add(SizedBox(height: rowGap));
      rows.add(
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: cells),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

/// One saved pick in the recent picks grid: the matched marker colour and code.
class _RecentPickTile extends StatelessWidget {
  const _RecentPickTile({super.key, required this.pick, required this.onTap});

  final ColorMatchPick pick;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      button: true,
      label:
          '${context.l10n.matchRecentPickLabel} ${pick.matchedCode} '
          '${pick.matchedName}',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: InkRadii.cellRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SwatchBlock(hex: pick.matchedHex, height: 40),
              const SizedBox(height: InkSpacing.group),
              Text(
                pick.matchedCode,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.data.copyWith(color: ink.fg2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Details of a saved pick, with the action that removes it.
class _PickSheet extends StatelessWidget {
  const _PickSheet({required this.pick, required this.onRemove});

  final ColorMatchPick pick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color sampled = swatchColor(pick.sampledHex);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SwatchBlock(
                hex: pick.matchedHex,
                size: InkGeometry.heroSwatch,
                radius: InkRadii.card,
              ),
              const SizedBox(width: InkSpacing.s16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pick.matchedCode,
                      style: AppTypography.code.copyWith(color: ink.fg),
                    ),
                    const SizedBox(height: InkSpacing.s4),
                    Text(
                      pick.matchedName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.sheetTitle.copyWith(color: ink.fg),
                    ),
                    const SizedBox(height: InkSpacing.group),
                    Text(
                      '${displayHex(pick.matchedHex)} · '
                      '${context.l10n.commonDeltaE(pick.deltaE)}',
                      style: AppTypography.data.copyWith(color: ink.fg2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: InkSpacing.s16),
        Row(
          children: <Widget>[
            Text(
              AppTypography.caps(context.l10n.matchRecentDetailSampled),
              style: AppTypography.capsStyle.copyWith(color: ink.fg2),
            ),
            const SizedBox(width: InkSpacing.s8),
            Container(
              width: InkGeometry.smallIcon,
              height: InkGeometry.smallIcon,
              decoration: BoxDecoration(
                color: sampled,
                borderRadius: InkRadii.xsRadius,
                border: Border.all(color: ink.swatchEdge(sampled)),
              ),
            ),
            const SizedBox(width: InkSpacing.s8),
            Text(
              displayHex(pick.sampledHex),
              style: AppTypography.data.copyWith(color: ink.fg),
            ),
          ],
        ),
        const SizedBox(height: InkSpacing.s16),
        InkButton.secondary(
          key: ValueKey<String>('match-pick-remove-${pick.id}'),
          label: context.l10n.matchRemoveTooltip,
          icon: InkIcons.trash2,
          expand: true,
          onPressed: onRemove,
        ),
      ],
    );
  }
}

/// Draws the reticle (design G): a 60 circle filled with the sampled colour,
/// a white 3 px ring, a 1 px dark outer ring and a dark crosshair. The ring
/// colours are fixed, not themed, so the reticle reads on any photo.
class _ReticlePainter extends CustomPainter {
  _ReticlePainter({required this.centre, required this.sampleColor});

  final Offset centre;
  final Color sampleColor;

  static const double _outerRadius = 30;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(centre, _outerRadius - 1, Paint()..color = sampleColor);
    canvas.drawCircle(
      centre,
      _outerRadius - 2.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = InkColors.reticleRing,
    );
    canvas.drawCircle(
      centre,
      _outerRadius - 0.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = InkColors.reticleOuter,
    );
    // The 20 px crosshair: four ticks around an open centre.
    final Paint cross = Paint()
      ..color = InkColors.reticleOuter
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round;
    const double inner = 3.3, outer = 8.3;
    for (final Offset dir in const <Offset>[
      Offset(1, 0),
      Offset(-1, 0),
      Offset(0, 1),
      Offset(0, -1),
    ]) {
      canvas.drawLine(centre + dir * inner, centre + dir * outer, cross);
    }
  }

  @override
  bool shouldRepaint(_ReticlePainter oldDelegate) =>
      oldDelegate.centre != centre || oldDelegate.sampleColor != sampleColor;
}

/// A one-line status (loading, error, empty collection) in a bordered card.
///
/// Errors use the `error` token for the icon only; the text stays `fg` and
/// nothing is filled with red.
class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.icon,
    required this.message,
    this.isError = false,
  });

  final InkIcons icon;
  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return _Gutter(
      bottom: InkSpacing.block,
      child: Container(
        padding: InkSpacing.card,
        decoration: BoxDecoration(
          color: ink.surface,
          borderRadius: InkRadii.cardRadius,
          border: Border.all(color: ink.line),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkIcon(
              icon,
              size: InkGeometry.mediumIcon,
              color: isError ? ink.error : ink.fg2,
            ),
            const SizedBox(width: InkSpacing.block),
            Expanded(
              child: Text(
                message,
                style: AppTypography.secondary.copyWith(color: ink.fg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
