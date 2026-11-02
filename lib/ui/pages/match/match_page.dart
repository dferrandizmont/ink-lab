import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/color_utils.dart';
import '../../../core/match_quality.dart';
import '../../../core/models.dart';
import '../../../core/white_balance.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../collection/collection_page.dart';
import 'color_sampling.dart';
import 'image_picker_service.dart';
import 'match_result_tile.dart';
import 'photo_box.dart';
import 'photo_sampling.dart';
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
/// then ranks the closest markers of the user's collection with
/// [findClosestMarkerMatches]. Matches are labelled with honest [MatchQuality]
/// bands; when none of the user's markers is close (ΔE76 above
/// [MatchQuality.noCloseMatchThreshold]) the page says so and, unless turned
/// off in Settings, shows the closest marker of the whole range ("You don't
/// own it"). Tapping a result records a [ColorMatchPick] in the recent picks
/// of the active brand. Photos are decoded on the device and never uploaded.
class MatchPage extends StatefulWidget {
  const MatchPage({super.key, this.picker, this.decoder});

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('match-page');

  /// Number of matches shown: one best match plus five alternates.
  static const int matchLimit = 6;

  /// Number of saved picks shown on the page; the rest are in the picker.
  static const int recentPicksInView = 6;

  /// Photo picker. Production wraps `image_picker`; tests inject a fake.
  final ImagePickerService? picker;

  /// Decoder from encoded photo bytes to raw pixels. Tests inject a fake.
  final PhotoDecoder? decoder;

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  static const double _radiusFraction = defaultSamplingRadiusFraction;

  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _settingsSubscription;
  StreamSubscription<Map<String, String>>? _ownColorsSubscription;
  StreamSubscription<Set<String>>? _driedSubscription;
  Stream<List<ColorMatchPick>>? _historyChanges;
  String _collectionSignature = '';

  MarkerBrand _brand = MarkerBrand.ohuhuOahu;

  /// The user's markers of the active brand.
  List<MarkerColor> _available = const <MarkerColor>[];

  /// What the photo is matched against: the user's markers, or the whole
  /// range while the collection is not set up yet.
  List<MarkerColor> get _pool => _available.isEmpty ? _range : _available;

  /// The whole range of the active brand.
  List<MarkerColor> _range = const <MarkerColor>[];
  ColorDistanceMatch? _rangeBest;
  bool _suggestUnowned = true;
  bool _loading = true;

  Uint8List? _bytes;
  SampledImage? _sampled;
  Offset? _pick;
  int? _sampledColorInt;

  /// The white balance of the photo on screen (per photo, never stored).
  WhiteBalance? _balance;

  /// Whether the next tap on the photo chooses its white.
  bool _choosingWhite = false;
  WhiteBalanceRejection? _whiteRejection;
  List<ColorDistanceMatch> _matches = const <ColorDistanceMatch>[];
  String? _error;
  String? _notice;
  bool _picking = false;

  /// Whether the best of the whole range is open (the disclosure of the
  /// range suggestion).
  bool _rangeOpen = false;

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
    // The colours of the markers changed (an own colour was set or reset).
    _ownColorsSubscription?.cancel();
    _driedSubscription?.cancel();
    _ownColorsSubscription = scope.ownColors.changes.listen(
      (_) => _onSettingsChanged(scope.settings.state),
    );
    // A marker was marked as dried out, or usable again.
    _driedSubscription?.cancel();
    _driedSubscription = scope.dried.changes.listen(
      (_) => _onSettingsChanged(scope.settings.state),
    );
    unawaited(_reload());
  }

  @override
  void dispose() {
    _settingsSubscription?.cancel();
    _ownColorsSubscription?.cancel();
    super.dispose();
  }

  String _signatureOf(AppSettingsState state) {
    final List<String> sets = state.settings.ownedSetIds.toList()..sort();
    final List<String> owned = state.settings.extraMarkerIds.toList()..sort();
    return '${state.brand.id}|${sets.join(',')}|${owned.join(',')}|'
        '${state.matchSuggestUnowned}|${_scope?.markers.colorRevision}|'
        '${_scope?.dried.revision}';
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
    final bool suggest = scope.settings.state.matchSuggestUnowned;
    setState(() => _loading = true);
    List<MarkerColor> catalog;
    try {
      catalog = await scope.markers.loadColors(brand);
    } catch (_) {
      catalog = const <MarkerColor>[];
    }
    if (!mounted) return;
    final Set<String> dried = scope.dried.ids;
    final List<MarkerColor> available = ownedColors(
      colors: catalog,
      brand: brand,
      ownedSetIds: settings.ownedSetIds,
      ownedMarkerCodes: settings.extraMarkerIds,
      driedColorIds: dried,
    );
    setState(() {
      _brand = brand;
      _available = available;
      // A dried-out marker is not offered as a "could buy" match either.
      _range = <MarkerColor>[
        for (final MarkerColor c in brandRangeColors(
          colors: catalog,
          brand: brand,
        ))
          if (!dried.contains(c.colorId)) c,
      ];
      _suggestUnowned = suggest;
      _loading = false;
      // A new collection or brand re-ranks the current sample.
      _rank(_sampledColorInt);
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
      _balance = null;
      _choosingWhite = false;
      _whiteRejection = null;
      _matches = const <ColorDistanceMatch>[];
      _rangeBest = null;
      _picking = false;
      _error = null;
      _notice = null;
    });
  }

  /// Ranks the user's markers, and the whole range, for [sample].
  void _rank(int? sample) {
    if (sample == null) {
      _matches = const <ColorDistanceMatch>[];
      _rangeBest = null;
      return;
    }
    _matches = findClosestMarkerMatches(
      sample,
      _pool,
      limit: MatchPage.matchLimit,
    );
    final List<ColorDistanceMatch> range = findClosestMarkerMatches(
      sample,
      _range,
      limit: 1,
    );
    _rangeBest = range.isEmpty ? null : range.first;
  }

  /// The closest marker of the whole range, when it is worth showing: the
  /// user owns nothing close, or it is clearly better than the best owned
  /// one. Null when it is owned or the suggestion is turned off.
  ColorDistanceMatch? get _rangeSuggestion {
    final ColorDistanceMatch? range = _rangeBest;
    if (!_suggestUnowned || range == null) return null;
    if (_pool.any((MarkerColor c) => c.colorId == range.color.colorId)) {
      return null;
    }
    if (_matches.isEmpty) return range;
    final double best = _matches.first.deltaE;
    if (!MatchQuality.isUsable(best)) return range;
    return MatchQuality.of(range.deltaE).index < MatchQuality.of(best).index
        ? range
        : null;
  }

  /// The photo was touched at [fraction] (of the photo): chooses its white
  /// while that is being asked for, samples a colour otherwise.
  void _onPhotoPoint(Offset fraction) {
    if (_choosingWhite) {
      _chooseWhite(fraction);
    } else {
      _sampleAt(fraction);
    }
  }

  /// The colour under [fraction], as seen with the current white balance.
  int _colorAt(SampledImage sampled, Offset fraction) {
    final int raw = averageColorOfRegion(
      sampled,
      fraction,
      radiusFraction: _radiusFraction,
    );
    return _balance?.apply(raw) ?? raw;
  }

  void _sampleAt(Offset fraction) {
    final SampledImage? sampled = _sampled;
    if (sampled == null) return;
    final int colorInt = _colorAt(sampled, fraction);
    setState(() {
      _pick = fraction;
      _sampledColorInt = colorInt;
      _rank(colorInt);
      _notice = null;
    });
  }

  /// Makes the point at [fraction] the white of the photo, unless it cannot
  /// be paper: then it says so and the photo stays as it was.
  void _chooseWhite(Offset fraction) {
    final SampledImage? sampled = _sampled;
    if (sampled == null) return;
    final int reference = averageColorOfRegion(
      sampled,
      fraction,
      radiusFraction: _radiusFraction,
    );
    switch (WhiteBalanceFit.fromReference(reference)) {
      case WhiteBalanceApplied(:final WhiteBalance balance):
        setState(() {
          _balance = balance;
          _choosingWhite = false;
          _whiteRejection = null;
          _notice = null;
          _resample();
        });
      case WhiteBalanceRejected(:final WhiteBalanceRejection reason):
        setState(() => _whiteRejection = reason);
    }
  }

  /// Takes the sample again after the white balance changed.
  void _resample() {
    final SampledImage? sampled = _sampled;
    final Offset? pick = _pick;
    if (sampled == null || pick == null) return;
    final int colorInt = _colorAt(sampled, pick);
    _sampledColorInt = colorInt;
    _rank(colorInt);
  }

  void _resetWhite() => setState(() {
    _balance = null;
    _whiteRejection = null;
    _resample();
  });

  /// Starts choosing the white of the photo.
  void _startWhite() => setState(() {
    _choosingWhite = true;
    _whiteRejection = null;
  });

  /// Gives up choosing the white of the photo.
  void _cancelWhite() => setState(() {
    _choosingWhite = false;
    _whiteRejection = null;
  });

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
    // Only the picks of the active brand are cleared.
    final List<ColorMatchPick> others = scope.matchHistory.entries
        .where((ColorMatchPick p) => p.brandId != _brand.id)
        .toList(growable: false);
    if (others.isEmpty) {
      await scope.matchHistory.clear();
    } else {
      await scope.matchHistory.restore(others);
    }
  }

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

    final ColorDistanceMatch? rangeSuggestion = _rangeSuggestion;
    final bool closeMatch =
        _matches.isNotEmpty && MatchQuality.isUsable(_matches.first.deltaE);
    return ListView(
      key: MatchPage.pageKey,
      padding: const EdgeInsets.only(bottom: InkSpacing.pageBottom),
      children: <Widget>[
        InkPageHeader(
          title: context.l10n.matchTitle,
          subtitle: _available.isEmpty
              ? context.l10n.matchSubtitleEmpty
              : context.l10n.matchSubtitle(_available.length),
        ),
        if (_available.isEmpty) _buildWholeRangeNotice(),
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
        _buildActions(),
        _buildWhiteBalanceNote(),
        if (_sampledColorInt != null)
          _buildSampled(_sampledColorInt!)
        else if (_sampled != null)
          _Gutter(
            top: InkSpacing.block,
            child: _SecondaryText(context.l10n.matchPickToSample),
          ),
        if (_matches.isNotEmpty) ...<Widget>[
          // Above the threshold the page says so first; the closest owned
          // marker still shows, with its honest "Far off" label.
          if (!closeMatch)
            Padding(
              padding: const EdgeInsets.only(top: InkSpacing.block),
              child: _StatusLine(
                key: const ValueKey<String>('match-no-close'),
                icon: InkIcons.info,
                message: context.l10n.matchNoCloseMatch,
              ),
            ),
          _buildBestMatch(),
          if (_matches.length > 1)
            _buildAlternatives(
              _matches.skip(1).toList(),
              context.l10n.matchAlternatesTitle,
            ),
        ],
        if (rangeSuggestion != null) _buildRangeSuggestion(rangeSuggestion),
        _buildHistory(scope),
        const _Gutter(top: InkSpacing.section, child: _PrivacyLine()),
      ],
    );
  }

  /// Shown while the collection is empty: matching uses the whole range,
  /// with a way to set the collection up.
  Widget _buildWholeRangeNotice() {
    final InkColors ink = InkColors.of(context);
    return _Gutter(
      bottom: InkSpacing.block,
      child: Container(
        key: const ValueKey<String>('match-whole-range'),
        padding: InkSpacing.card,
        decoration: BoxDecoration(
          color: ink.surface,
          borderRadius: InkRadii.cardRadius,
          border: Border.all(color: ink.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              context.l10n.matchWholeRangeBody(_brand.label),
              style: AppTypography.secondary.copyWith(color: ink.fg),
            ),
            const SizedBox(height: InkSpacing.group),
            InkButton.secondary(
              key: const ValueKey<String>('match-whole-range-setup'),
              label: context.l10n.matchWholeRangeAction,
              expand: true,
              onPressed: () => CollectionPage.open(context),
            ),
          ],
        ),
      ),
    );
  }

  /// The best marker of the whole range, folded: the summary says its code
  /// and distance, and opening it shows the marker itself.
  Widget _buildRangeSuggestion(ColorDistanceMatch match) {
    return _Gutter(
      top: InkSpacing.section,
      child: InkDisclosure(
        key: const ValueKey<String>('match-range'),
        title: context.l10n.matchBestOfRange(_brand.label),
        subtitle:
            '${match.color.newCode} · '
            '${context.l10n.commonDeltaE(match.deltaE)}',
        expanded: _rangeOpen,
        onToggle: () => setState(() => _rangeOpen = !_rangeOpen),
        child: Padding(
          padding: const EdgeInsets.only(
            top: InkSpacing.group,
            bottom: InkSpacing.s8,
          ),
          child: BestMatchTile(
            key: ValueKey<String>('match-range-${match.color.newCode}'),
            match: match,
            notOwned: true,
            onRecord: () => _record(match),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoto() {
    final bool hasPhoto = _bytes != null && _sampled != null;
    return _Gutter(
      child: Semantics(
        container: true,
        label: context.l10n.matchPhotoSemantics,
        child: PhotoBox(
          aspectRatio: hasPhoto ? _sampled!.aspectRatio : null,
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
    final int? sampledColor = _sampledColorInt;
    return PhotoSampleCanvas(
      gestureKey: const ValueKey<String>('match-canvas'),
      bytes: _bytes!,
      image: _sampled!,
      onPoint: _onPhotoPoint,
      tapOnly: _choosingWhite,
      balance: _balance,
      pick: _choosingWhite ? null : _pick,
      sampleColor: sampledColor == null
          ? null
          : Color(0xFF000000 | sampledColor),
    );
  }

  Widget _buildSampled(int colorInt) {
    final InkColors ink = InkColors.of(context);
    final Color sample = Color(0xFF000000 | colorInt);
    return _Gutter(
      top: InkSpacing.block,
      // The hex is the colour: the RGB triple would only repeat it.
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
        ],
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

  Widget _buildAlternatives(List<ColorDistanceMatch> alternates, String title) {
    return _Gutter(
      top: InkSpacing.section,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkSectionHeading(title),
          const SizedBox(height: InkSpacing.headingGap),
          _EqualColumns(
            columns: MatchPage.matchLimit - 1,
            minCell: 52,
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

  /// The row of actions, right under the photo: the camera and the gallery,
  /// and the white balance at the right.
  ///
  /// The row is always in the same place, with or without a photo, so taking
  /// a photo never moves the buttons. When the three do not fit on one line
  /// (a long translation at a large text size) the white balance drops to its
  /// own line, right-aligned.
  Widget _buildActions() {
    return _Gutter(
      key: const ValueKey<String>('match-actions'),
      top: InkSpacing.block,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Widget buttons = Row(
            children: <Widget>[
              Expanded(
                child: InkButton(
                  key: const ValueKey<String>('match-camera'),
                  label: context.l10n.matchCameraButton,
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
                  key: const ValueKey<String>('match-gallery'),
                  label: context.l10n.matchGalleryButton,
                  icon: InkIcons.image,
                  variant: InkButtonVariant.smallSecondary,
                  expand: true,
                  onPressed: _picking
                      ? null
                      : () => _pickPhoto(PhotoSource.gallery),
                ),
              ),
            ],
          );
          final Widget balance = Align(
            alignment: AlignmentDirectional.centerEnd,
            child: WhiteBalanceAction(
              onPressed: _sampled == null ? null : _startWhite,
            ),
          );
          if (_actionsFitOnOneLine(context, constraints.maxWidth)) {
            return Row(
              children: <Widget>[
                Expanded(child: buttons),
                const SizedBox(width: InkSpacing.buttonGap),
                balance,
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buttons,
              const SizedBox(height: InkSpacing.s8),
              balance,
            ],
          );
        },
      ),
    );
  }

  /// Whether the camera, the gallery and the white balance fit on one line.
  bool _actionsFitOnOneLine(BuildContext context, double width) {
    final double camera = _buttonWidth(
      context,
      context.l10n.matchCameraButton,
      withIcon: true,
    );
    final double gallery = _buttonWidth(
      context,
      context.l10n.matchGalleryButton,
      withIcon: true,
    );
    final double balance = _buttonWidth(
      context,
      context.l10n.matchWhiteBalanceButton,
      withIcon: false,
    );
    return camera + gallery + balance + 2 * InkSpacing.buttonGap <= width;
  }

  /// The width a button with [label] takes at the current width and text
  /// size: its text plus its padding (and its icon, when it has one).
  double _buttonWidth(
    BuildContext context,
    String label, {
    required bool withIcon,
  }) {
    final TextPainter painter = TextPainter(
      text: TextSpan(
        text: label,
        style: AppTypography.button.copyWith(color: InkColors.of(context).fg),
      ),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final double text = painter.width;
    painter.dispose();
    // Small secondary: padding 0 14, icon 16 and gap 8. Text: padding 0 12.
    final double padding = withIcon ? 28 + InkGeometry.smallIcon + 8 : 24;
    return text + padding;
  }

  /// What the white balance of the photo is doing, under the row of actions.
  Widget _buildWhiteBalanceNote() {
    return _Gutter(
      top: InkSpacing.group,
      child: WhiteBalanceStatus(
        balance: _balance,
        choosing: _choosingWhite,
        rejection: _whiteRejection,
        onCancel: _cancelWhite,
        onReset: _resetWhite,
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
            // Recent picks are per brand: the other brand's picks are kept
            // but not shown.
            final List<ColorMatchPick> picks =
                (snapshot.data ?? scope.matchHistory.entries)
                    .where((ColorMatchPick p) => p.brandId == _brand.id)
                    .toList(growable: false);
            // Only the last six are in view; the rest are in the picker.
            final List<ColorMatchPick> shown = picks
                .take(MatchPage.recentPicksInView)
                .toList(growable: false);
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
                  else ...<Widget>[
                    _EqualColumns(
                      columns: MatchPage.recentPicksInView,
                      minCell: 44,
                      gap: InkSpacing.s8,
                      rowGap: InkSpacing.buttonGap,
                      children: <Widget>[
                        for (final ColorMatchPick pick in shown)
                          _RecentPickTile(
                            key: ValueKey<String>('match-pick-${pick.id}'),
                            pick: pick,
                            onTap: () => _showPick(scope, pick),
                          ),
                      ],
                    ),
                    if (picks.length > shown.length) ...<Widget>[
                      const SizedBox(height: InkSpacing.group),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkButton.text(
                          key: const ValueKey<String>('match-history-see-all'),
                          label: context.l10n.matchSeeAll(picks.length),
                          onPressed: () => _showAllPicks(scope, picks),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            );
          },
    );
  }

  /// Every saved pick, in a sheet, for the days with more than six.
  Future<void> _showAllPicks(AppScope scope, List<ColorMatchPick> picks) {
    return showInkDraggableSheet<void>(
      context: context,
      closeTooltip: context.l10n.matchCloseTooltip,
      builder: (BuildContext sheetContext, ScrollController scroll) => ListView(
        controller: scroll,
        padding: EdgeInsets.zero,
        children: <Widget>[
          for (final ColorMatchPick pick in picks)
            _RecentPickRow(
              key: ValueKey<String>('match-history-row-${pick.id}'),
              pick: pick,
              onTap: () => _showPick(scope, pick),
            ),
        ],
      ),
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

/// One saved pick as a row, for the sheet with every pick.
class _RecentPickRow extends StatelessWidget {
  const _RecentPickRow({super.key, required this.pick, required this.onTap});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
            child: Row(
              children: <Widget>[
                SwatchBlock(
                  hex: pick.matchedHex,
                  size: InkGeometry.swatchInline,
                ),
                const SizedBox(width: InkSpacing.s12),
                Expanded(
                  child: Text(
                    pick.matchedCode,
                    maxLines: 1,
                    softWrap: false,
                    style: AppTypography.code.copyWith(color: ink.fg),
                  ),
                ),
                const SizedBox(width: InkSpacing.s8),
                Expanded(
                  child: Text(
                    pick.matchedName,
                    maxLines: 1,
                    softWrap: false,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontal gutter (and optional vertical gaps) around a block of the page.
class _Gutter extends StatelessWidget {
  const _Gutter({
    super.key,
    required this.child,
    this.top = 0,
    this.bottom = 0,
  });

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
    required this.minCell,
    required this.gap,
    required this.children,
    this.rowGap = 0,
  });

  /// The most cells in a row.
  final int columns;

  /// Narrowest a cell may get at normal text; scaled with the system text
  /// size, so large text gets fewer, wider cells instead of cut codes.
  final double minCell;
  final double gap;
  final double rowGap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.textScalerOf(context).scale(1);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int fit = ((constraints.maxWidth + gap) / (minCell * scale + gap))
            .floor();
        return _rows(fit.clamp(2, columns));
      },
    );
  }

  Widget _rows(int columns) {
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
                softWrap: false,
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

/// A one-line status (loading, error, empty collection) in a bordered card.
///
/// Errors use the `error` token for the icon only; the text stays `fg` and
/// nothing is filled with red.
class _StatusLine extends StatelessWidget {
  const _StatusLine({
    super.key,
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
