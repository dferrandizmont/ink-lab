import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../../../ai/palette_advisor.dart' as ai;
import '../../../app_scope.dart';
import '../../../core/app_version.dart' as app_version;
import '../../../core/blending_chain.dart';
import '../../../core/collection_selection.dart';
import '../../../core/color_vision.dart';
import '../../../core/models.dart';
import '../../../core/palette_advisor.dart';
import '../../../core/palette_card_layout.dart';
import '../../../core/match_quality.dart';
import '../../../core/palette_generator.dart';
import '../../../core/palette_text.dart';
import '../../../core/photo_palette.dart';
import '../../../core/scene_catalog.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../screen_awake.dart';
import '../../share/share_actions.dart';
import '../../share/share_sink.dart';
import '../../theme/tokens.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/palette_strip.dart';
import '../collection/collection_page.dart';
import '../settings/dialogs.dart';
import '../diary/artwork_entry_page.dart';
import '../match/color_sampling.dart';
import '../match/image_picker_service.dart';
import 'ai_report.dart';
import 'palette_draft.dart';
import 'palette_photo_scene.dart';
import 'palette_reasons.dart';
import 'palette_share.dart';
import 'palette_type_picker.dart';
import 'palette_vision.dart';
import 'saved_palettes_sheet.dart';
import '../../../l10n/l10n.dart';
import 'palette_actions.dart';
import 'palette_ai_report_dialog.dart';
import 'palette_base_field.dart';
import 'palette_base_picker_sheet.dart';
import 'palette_easel_page.dart';
import 'palette_import_sheet.dart';
import 'palette_layout.dart';
import 'palette_notes.dart';
import 'palette_paint_order.dart';
import 'palette_result_header.dart';
import 'palette_roles.dart';
import 'palette_save_name_dialog.dart';
import 'palette_suggestion_row.dart';
import 'palette_type_fields.dart';
import 'palette_vision_sheet.dart';

export 'palette_suggestion_row.dart' show RoleLabel;

part 'palette_ai_flow.dart';
part 'palette_photo_flow.dart';
part 'palette_result_section.dart';
part 'palette_save_share.dart';
part 'palette_snapshot.dart';
part 'palette_notice.dart';
part 'palette_text_flow.dart';

/// Composition root above the page, or `null` in isolated previews/tests.
///
/// Mirrors `AppScope.of` without the debug assertion so the page can degrade
/// gracefully when it is pumped without a scope (for example the shell smoke
/// test that only checks the page key).
AppScope? _scopeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<AppScope>();

/// The palette builder.
///
/// Reads the active collection and repositories from [AppScope], builds a
/// palette through the injected [PaletteAdvisor] (the local engine by default)
/// and renders it as a strip plus per-color rows, a paint plan, quick
/// variations and the brand's saved palettes.
class PalettePage extends StatefulWidget {
  const PalettePage({
    super.key,
    this.advisor = const PaletteGenerator(),
    this.picker,
    this.decoder,
    this.photoExtractor,
    this.launchEmail,
    this.shareSink,
    this.screenAwake = const WakelockScreenAwake(),
  });

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('palette-page');

  /// Engine that turns a request into suggestions. Defaults to the local
  /// [PaletteGenerator]; a future AI advisor can be injected here.
  final PaletteAdvisor advisor;

  /// Photo picker for "From a photo". Production wraps `image_picker`; tests
  /// inject a fake.
  final ImagePickerService? picker;

  /// Decoder of the picked photo. Production uses `decodePhoto`.
  final PhotoDecoder? decoder;

  /// Finds the dominant colours of the decoded photo. Production does it off
  /// the UI thread; tests inject a synchronous one.
  final PhotoColorExtractor? photoExtractor;

  /// Opens the email app with a prepared `mailto:` address and says whether it
  /// opened. Production uses `url_launcher`; tests inject a fake.
  final Future<bool> Function(Uri uri)? launchEmail;

  /// Where a shared palette image goes. Production opens the system share
  /// sheet; tests inject a fake.
  final ShareSink? shareSink;

  /// What keeps the screen awake in Easel mode. Production uses the wakelock;
  /// tests inject a fake.
  final ScreenAwake screenAwake;

  @override
  State<PalettePage> createState() => _PalettePageState();
}

/// State of the palette page: the inputs, the result on screen and the core
/// that recomputes it. The rest lives in part files, as extensions of this
/// class, one per concern (add new features the same way):
///
/// - `palette_ai_flow.dart`: the optional AI advisor and its report.
/// - `palette_photo_flow.dart`: "From a photo".
/// - `palette_result_section.dart`: the strip, rows, chain notes and paint
///   order drawn under the fields, and the colour vision sheet.
/// - `palette_save_share.dart`: saving, sharing and loading palettes.
/// - `palette_snapshot.dart`: the undo of a base handed over from Swatches.
/// - `palette_text_flow.dart`: "Share as text", "Import from text" and Easel
///   mode.
///
/// The widgets that need no state of the page (fields, actions, rows, sheets,
/// dialogs) are libraries of their own with explicit constructors.
class _PalettePageState extends State<PalettePage> with WidgetsBindingObserver {
  late final ImagePickerService _picker =
      widget.picker ?? PlatformImagePickerService();
  late final PhotoDecoder _decode =
      widget.decoder ??
      (Uint8List bytes) =>
          decodePhoto(bytes, maxDimension: PhotoScene.maxDimension);
  late final PhotoColorExtractor _extract =
      widget.photoExtractor ?? extractPhotoColors;

  late final Future<bool> Function(Uri uri) _launchEmail =
      widget.launchEmail ??
      (Uri uri) => launcher.launchUrl(
        uri,
        mode: launcher.LaunchMode.externalApplication,
      );

  late final ShareSink _share = widget.shareSink ?? const SystemShareSink();

  /// A palette image is being rendered or the share sheet is open.
  bool _sharing = false;

  /// The colour vision the palettes on screen are previewed with; `null` is
  /// normal vision. Only what is drawn changes: a palette is saved and
  /// shared with its true colours.
  ColorVisionType? _vision;

  /// Whether the palettes on screen are previewed in values (greyscale, see
  /// `ValueView`). It excludes [_vision]; like it, it only changes what is
  /// drawn.
  bool _values = false;

  /// Whether the "Paint order" disclosure is open (it starts folded).
  bool _paintOrderOpen = false;

  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _settingsSubscription;

  /// The saved palettes of every brand: the Save button follows them (saved,
  /// or saveable again once the palette is deleted), whatever brand the
  /// palette on screen was saved under.
  StreamSubscription<void>? _savedSubscription;
  StreamSubscription<Map<String, String>>? _ownColorsSubscription;
  StreamSubscription<Set<String>>? _driedSubscription;
  StreamSubscription<AiSettings>? _aiSubscription;
  String _collectionSignature = '';
  int _catalogVersion = 0;

  /// Whether the optional AI advisor is configured (enabled + OpenRouter +
  /// stored key). Drives the "Suggest with AI" button.
  bool _aiAvailable = false;
  bool _aiLoading = false;

  /// Whether the suggestions currently on screen came from the AI.
  bool _aiUsed = false;

  /// Id of the model that produced the AI result on screen.
  String _aiModel = '';

  /// The provider that produced the current AI result, for its report.
  AiProvider? _aiProvider;

  /// How many colours of the AI result on screen came from the model, and how
  /// many there are in all (the rest were completed by colour theory).
  int _aiCount = 0;
  int _aiTotal = 0;

  /// Typed message of the last failed AI call, shown next to the button.
  String? _aiError;

  MarkerBrand _brand = MarkerBrand.ohuhuOahu;

  /// Every colour the page can name: the range of the brands in use and,
  /// after a saved or imported palette of another brand was loaded, that
  /// brand's too (so its markers still resolve).
  List<MarkerColor> _catalog = const <MarkerColor>[];

  /// The whole range of the brands in use: the active brand, or, with "Mix
  /// my brands", every brand the user has a usable marker of. The only range
  /// ever offered (the blending chain in whole-range mode, the previews).
  List<MarkerColor> _range = const <MarkerColor>[];

  /// The markers to build with: the user's usable ones, of the active brand
  /// or, with "Mix my brands", of every brand they own.
  List<MarkerColor> _available = const <MarkerColor>[];

  /// Whether "Mix my brands" is in effect: [_available] holds markers of more
  /// than one brand.
  bool _scopeMixed = false;

  /// The markers the user owns, the dried-out ones included: they are in the
  /// collection, they just cannot be used to build anything.
  List<MarkerColor> _owned = const <MarkerColor>[];
  bool _loading = true;

  /// Whether the collection was read at least once: from then on a reload
  /// is a change of collection, brand or scope under a page in use.
  bool _ready = false;

  /// Whether the codes on screen are shown with their brand ("Ohuhu BV04"):
  /// "Mix my brands" is in effect, or the palette on screen holds a marker of
  /// another brand than the active one (a saved or imported mixed palette,
  /// or one kept across a change of brand). Without either the page is
  /// exactly the single-brand one.
  ///
  /// The base counts as the palette shows it: the first colour of a photo
  /// palette, which the base field knows nothing of, the typed one otherwise
  /// (the default base of a scene is one of [_available], so it is of the
  /// active brand whenever the scope is not mixed).
  bool get _mixed {
    if (_scopeMixed) return true;
    if (_suggestions.any((s) => s.color.brandId != _brand.id)) return true;
    final MarkerColor? base = _photoMode ? _stripBase : _resolvedBase;
    return base != null && base.brandId != _brand.id;
  }

  /// The code of [c] as the page shows it (see [_mixed]).
  String _codeLabel(MarkerColor c) => markerCodeLabel(c, mixed: _mixed);

  /// What the base field holds for [c]: its code, with the brand when the
  /// code alone would not say which marker it is.
  String _baseValue(MarkerColor c) =>
      markerCodeLabel(c, mixed: _scopeMixed || c.brandId != _brand.id);

  /// The key part of the row of [c]: the colour id where two brands may
  /// share a code, the bare code otherwise (as before brands could mix).
  /// Locks are always kept by colour id.
  String _rowId(MarkerColor c) => _mixed ? c.colorId : c.newCode;

  /// Whether the collection has a marker to work with. When it has none,
  /// the page says so instead of building a palette out of the brand's range.
  bool get _hasMarkers => _available.isNotEmpty;

  /// Whether the collection is not empty but every marker in it ran dry: the
  /// page says so, instead of claiming the user owns nothing.
  bool get _allMarkersDried => _available.isEmpty && _owned.isNotEmpty;

  /// Whether a palette can be built: there is a base the user owns (or a
  /// scene, which brings its own) and at least one marker of the collection
  /// to build it with. A base out of the brand's range is not a base: the
  /// engines refuse it.
  bool get _canBuild {
    if (!_hasMarkers) return false;
    final String input = _baseInput.trim();
    if (input.isEmpty) return _useScenario;
    final MarkerColor? base = _resolvedBase;
    if (base == null) return false;
    return _available.any((MarkerColor c) => c.colorId == base.colorId);
  }

  late final TextEditingController _baseController;
  final FocusNode _baseFocus = FocusNode();
  String _baseInput = '';

  PaletteMode _mode = PaletteMode.recommended;
  bool _useScenario = false;
  Scene? _sceneChoice;

  /// The scene in use: the one picked, or the first by default.
  Scene get _scenario => _sceneChoice ?? Scene.byId('ghostCharacter');

  /// The photo the palette was built from (Scenes > From a photo), or `null`.
  /// Its colours are matched to [_available] in [_recompute].
  PhotoScene? _photoScene;

  /// Generation of the photo flow (pick, read, analyse). Every await checks
  /// it, so a result that arrives after Clear, another type, a saved palette,
  /// an Ideas draft or an undo is dropped; [_dropPhoto] moves it on.
  int _photoToken = 0;

  /// Generation of the AI request. Entering photo mode moves it on, so a late
  /// AI answer never overwrites the photo palette.
  int _aiVersion = 0;

  /// The owned markers chosen for the photo's colours, most prominent first.
  /// As many as the palette size asks for.
  List<PhotoMarkerPick> _photoPicks = const <PhotoMarkerPick>[];

  /// A photo is being picked, read or analysed.
  bool _photoBusy = false;

  /// Why the last photo could not be used, shown as an error note.
  String? _photoError;

  /// Whether the palette on screen comes from a photo.
  bool get _photoMode => _useScenario && _photoScene != null;

  /// Preview colours of the scenes against the whole brand range.
  ScenePreviews _previews = ScenePreviews(const <MarkerColor>[]);
  int _paletteSize = 5;
  int _variationToken = 0;

  /// Blending Chain: the chains found for the base, the one on screen, which
  /// of the chains it is, and whether the whole range of the brand may be
  /// used instead of the user's markers.
  BlendingChainResult? _chainResult;
  BlendingChain? _chain;
  int _chainIndex = 0;
  bool _chainWholeRange = false;

  /// The brands of the range the chains on screen were searched in (whole
  /// range mode; empty otherwise). The chain may outlive a change of brand
  /// or of "Mix my brands", so its note names the range it really came from
  /// (see [_chainRangeNote]).
  Set<String> _chainRangeBrands = const <String>{};

  /// Whether the type in use is the Blending Chain.
  bool get _chainMode => _mode == PaletteMode.blendingChain && !_useScenario;

  /// The chain on screen, or `null` when the type is another one.
  BlendingChain? get _shownChain => _chainMode ? _chain : null;

  List<PaletteSuggestion> _suggestions = const <PaletteSuggestion>[];
  PaletteFailureReason? _failure;
  bool _unknownInput = false;

  List<String> _lockedCodes = const <String>[];
  final Map<String, PaletteSuggestion> _lockedSuggestions =
      <String, PaletteSuggestion>{};

  /// A note about what just happened (a palette loaded, an import's counts).
  /// It is dismissable and it goes when the user leaves the tab.
  _PaletteNotice? _notice;

  /// Whether the palette on screen is one the user keeps: it was loaded from
  /// "My palettes" or it was saved.
  bool _workedPalette = false;

  /// Whether that kept palette was changed by hand since (a lock, the size,
  /// a variation). Replacing such a palette asks first; a fresh result never
  /// does (see [_approveReplacement]).
  bool _paletteEdited = false;

  /// The "Replace this palette?" dialog is open.
  bool _confirmingReplacement = false;

  /// The palette the Undo snack bar on screen brings back, while it is up,
  /// whether that undo came from typing in the base field, a count of the
  /// snack bars shown (a closing one must not clear a newer one's) and the
  /// snack bar itself, to take it down (see [_dropUndo]).
  _PaletteSnapshot? _undoTarget;
  bool _undoFromTyping = false;
  int _undoGeneration = 0;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _undoSnack;

  /// The base last resolved, with what it was resolved from (see
  /// [_resolvedBase]: it is read many times in one build).
  ({String input, List<MarkerColor> catalog, List<MarkerColor> choices})?
  _baseMemoKey;
  MarkerColor? _baseMemo;

  /// Whether the tab was on screen the last time the dependencies changed.
  /// The shell keeps every visited tab alive in an IndexedStack, so a note
  /// would otherwise still be there when the user comes back.
  bool _tabVisible = true;

  /// Keyboard height at the last metrics change, to notice it closing.
  double _keyboardInset = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _baseController = TextEditingController();
    paletteDraft.addListener(_onDraftChanged);
    paletteBaseDraft.addListener(_onBaseDraftChanged);
    paletteSavedDraft.addListener(_onSavedDraftChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onDraftChanged();
      _onBaseDraftChanged();
      _onSavedDraftChanged();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool visible = Visibility.of(context);
    if (_tabVisible && !visible) _notice = null;
    _tabVisible = visible;
    final scope = _scopeOf(context);
    if (scope == null || identical(scope, _scope)) return;
    _scope = scope;
    _settingsSubscription?.cancel();
    _collectionSignature = _signatureOf(scope.settings.state);
    _settingsSubscription = scope.settings.changes.listen(_onSettingsChanged);
    _savedSubscription?.cancel();
    _savedSubscription = scope.savedPalettes.changes.listen((_) {
      if (mounted) setState(() {});
    });
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
    _aiSubscription?.cancel();
    // Only an on/off or provider change can alter availability; other edits
    // (temperature, toggles) must not make ML Kit answer another status call.
    AiSettings seen = scope.aiSettings.value;
    _aiSubscription = scope.aiSettings.changes.listen((AiSettings next) {
      final bool relevant =
          next.enabled != seen.enabled || next.provider != seen.provider;
      seen = next;
      if (relevant) unawaited(_refreshAiAvailability());
    });
    unawaited(_refreshAiAvailability());
    unawaited(_reload());
  }

  /// Dismissing the keyboard (back gesture, "done") leaves the field focused,
  /// so the suggestions would keep floating over the page: drop the focus
  /// as soon as the keyboard closes.
  @override
  void didChangeMetrics() {
    final Iterable<ui.FlutterView> views =
        WidgetsBinding.instance.platformDispatcher.views;
    final double inset = views.isEmpty ? 0 : views.first.viewInsets.bottom;
    final bool closed = inset == 0 && _keyboardInset > 0;
    _keyboardInset = inset;
    if (closed && _baseFocus.hasFocus) _baseFocus.unfocus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    paletteDraft.removeListener(_onDraftChanged);
    paletteBaseDraft.removeListener(_onBaseDraftChanged);
    paletteSavedDraft.removeListener(_onSavedDraftChanged);
    _settingsSubscription?.cancel();
    _savedSubscription?.cancel();
    _ownColorsSubscription?.cancel();
    _driedSubscription?.cancel();
    _aiSubscription?.cancel();
    _photoToken++;
    _photoScene?.dispose();
    _baseController.dispose();
    _baseFocus.dispose();
    super.dispose();
  }

  /// `setState` for the extensions in the part files: a protected member of
  /// [State] cannot be called from an extension.
  void _setState(VoidCallback fn) => setState(fn);

  String _signatureOf(AppSettingsState state) {
    final sets = state.settings.effectiveSetIds().toList()..sort();
    final owned = state.settings.ownedMarkerCodes.toList()..sort();
    return '${state.brand.id}|${state.scope.name}|${sets.join(',')}|${owned.join(',')}|'
        '${_scope?.markers.colorRevision}|${_scope?.dried.revision}';
  }

  void _onSettingsChanged(AppSettingsState state) {
    final signature = _signatureOf(state);
    if (signature == _collectionSignature) return;
    _collectionSignature = signature;
    unawaited(_reload());
  }

  /// Reads the collection again: at start, and whenever the brand, "Mix my
  /// brands", the owned markers, a marker's own colour or a dried-out mark
  /// change.
  ///
  /// What was asked of the old collection goes with it: an AI answer still
  /// on its way is dropped, and so is the Undo on screen (its palette was
  /// built from the old collection).
  ///
  /// The palette on screen is never destroyed by a change of brand or of
  /// "Mix my brands": it stays as it is, each marker with its brand, until
  /// the user builds another one (which the Undo then covers). The base
  /// field is rewritten so it still names the same marker; a scene palette
  /// built on the scene's default base gets that base written in the field
  /// when the new collection would pick another one, so its base stays the
  /// marker it was built on. Any other change
  /// (a marker added, removed or dried out) recomputes the palette as it
  /// always did; so does a change of brand or mix that comes with the loss
  /// of one of the palette's own markers, so a palette never keeps a marker
  /// the user can no longer use.
  Future<void> _reload() async {
    final scope = _scope;
    if (scope == null) return;
    final version = ++_catalogVersion;
    _cancelAi();
    _dropUndo();
    final brand = scope.settings.brand;
    final settings = scope.settings.settings;
    final selectionScope = scope.settings.scope;
    // The brands of the palette on screen stay readable: a loaded palette may
    // hold markers of a brand that is not in use.
    final Set<String> shown = <String>{
      for (final PaletteSuggestion s in _suggestions) s.color.brandId,
      if (_resolvedBase case final MarkerColor base) base.brandId,
      if (_stripBase case final MarkerColor base) base.brandId,
    };
    setState(() => _loading = true);
    List<MarkerColor> catalog;
    try {
      catalog = await _withBrands(
        await scope.markers.loadCollectionCatalog(
          brand: brand,
          settings: settings,
          scope: selectionScope,
        ),
        shown,
      );
    } catch (_) {
      catalog = const <MarkerColor>[];
    }
    try {
      await scope.markers.loadScenes();
    } catch (_) {
      // Without the scene catalogue the Scenes type is simply not offered.
    }
    if (!mounted || version != _catalogVersion) return;
    final Set<String> ownedSetIds = settings.effectiveSetIds();
    final Set<String> ownedMarkerCodes = settings.ownedMarkerCodes;
    // The markers the user owns (the dried-out ones included) and the ones
    // that can be used: the difference tells an empty collection from one
    // whose markers all ran dry.
    final available = paletteCandidateColors(
      colors: catalog,
      scope: selectionScope,
      brand: brand,
      activeSetIds: ownedSetIds,
      ownedMarkerCodes: ownedMarkerCodes,
      driedColorIds: scope.dried.ids,
    );
    // "Mix my brands" is in effect only with usable markers of two brands;
    // otherwise the page works with the active brand alone.
    final bool mixed = hasMixedBrands(available);
    final List<MarkerColor> owned = ownedCandidateColors(
      colors: catalog,
      scope: selectionScope,
      brand: brand,
      activeSetIds: ownedSetIds,
      ownedMarkerCodes: ownedMarkerCodes,
      driedColorIds: scope.dried.ids,
    );
    final Set<String> brandIds = <String>{
      brand.id,
      if (mixed)
        for (final MarkerColor c in available) c.brandId,
    };
    final List<MarkerColor> range = <MarkerColor>[
      for (final MarkerColor c in catalog)
        if (brandIds.contains(c.brandId)) c,
    ];
    // Read before the brand and the scope move: the base the field names
    // and the base as the palette on screen shows it, which is the typed
    // one, the first colour of a photo or the default base of a scene.
    final MarkerColor? typedBase = _resolvedBase;
    final MarkerColor? shownBase = _stripBase;
    // The default base of a scene is found among the usable markers every
    // time it is read: under another brand or mix it would be another
    // marker, or none.
    final MarkerColor? sceneBase =
        typedBase == null && _useScenario && !_photoMode ? shownBase : null;
    // Whether a marker of the palette on screen that the user could use no
    // longer can be (it left the collection, or it ran dry), whatever its
    // brand.
    final Set<String> had = <String>{
      for (final MarkerColor c in _available) c.colorId,
    };
    final Set<String> usable = <String>{
      for (final String id in <String>{
        for (final PaletteSuggestion s in _suggestions) s.color.brandId,
        ?shownBase?.brandId,
      })
        if (MarkerBrand.byId[id] case final MarkerBrand shownBrand)
          for (final MarkerColor c in ownedColors(
            colors: catalog,
            brand: shownBrand,
            ownedSetIds: ownedSetIds,
            ownedMarkerCodes: ownedMarkerCodes,
            driedColorIds: scope.dried.ids,
          ))
            c.colorId,
    };
    bool lost(MarkerColor c) =>
        had.contains(c.colorId) && !usable.contains(c.colorId);
    final bool keep =
        _ready &&
        _suggestions.isNotEmpty &&
        (brand != _brand || mixed != _scopeMixed) &&
        !_suggestions.any((PaletteSuggestion s) => lost(s.color)) &&
        !(shownBase != null && lost(shownBase));
    final _PaletteSnapshot? previous = _snapshot();
    setState(() {
      _brand = brand;
      _catalog = catalog;
      _range = range;
      _scopeMixed = mixed;
      _previews = ScenePreviews(range);
      _owned = owned;
      _available = available;
      _loading = false;
      _ready = true;
      if (keep && typedBase != null) {
        // "BV04" would now be read as a marker of the new brand.
        _baseInput = _baseValue(typedBase);
        _baseController.text = _baseInput;
      } else if (keep &&
          sceneBase != null &&
          findScenarioDefaultBase(available, _scenario)?.colorId !=
              sceneBase.colorId) {
        // The scene would now choose another base (or none) for the
        // companions on screen: the one they were built on is written down.
        _baseInput = _baseValue(sceneBase);
        _baseController.text = _baseInput;
      }
    });
    if (!keep) {
      _recompute();
      if (previous != null && previous.differsFrom(this)) {
        // Another palette took its place: it is a fresh result, and the
        // note about the one that went ("Palette loaded") goes with it.
        _workedPalette = false;
        _paletteEdited = false;
        if (_notice != null && identical(_notice, previous.notice)) {
          setState(() => _notice = null);
        }
      }
    }
    // A saved palette or a base handed over before the catalogue was ready.
    _onSavedDraftChanged();
    unawaited(_onBaseDraftChanged());
  }

  /// [catalog] plus the range of every brand of [brandIds] it does not hold
  /// yet. A brand whose catalogue cannot be read adds nothing.
  Future<List<MarkerColor>> _withBrands(
    List<MarkerColor> catalog,
    Iterable<String> brandIds,
  ) async {
    final markers = _scope?.markers;
    final Set<String> have = <String>{
      for (final MarkerColor c in catalog) c.brandId,
    };
    final List<MarkerBrand> missing = <MarkerBrand>[
      for (final String id in brandIds.toSet())
        if (!have.contains(id) && MarkerBrand.byId[id] != null)
          MarkerBrand.byId[id]!,
    ];
    if (markers == null || missing.isEmpty) return catalog;
    final List<MarkerColor> all = List<MarkerColor>.of(catalog);
    for (final MarkerBrand brand in missing) {
      try {
        all.addAll(await markers.loadColors(brand));
      } catch (_) {
        // Its markers simply do not resolve.
      }
    }
    return all;
  }

  // ---------------------------------------------------------------------------
  // Draft hand-off
  // ---------------------------------------------------------------------------

  void _onDraftChanged() {
    final draft = paletteDraft.value;
    if (draft == null || draft.suggestions.isEmpty) return;
    paletteDraft.value = null;
    // Keep the role and the reason the idea gave each marker; only a bare
    // suggestion falls back to the generic "Applied from Ideas".
    final suggestions = <PaletteSuggestion>[
      for (final suggestion in draft.suggestions)
        suggestion.reason.trim().isEmpty
            ? PaletteSuggestion(
                color: suggestion.color,
                reason: PaletteReasons.draft,
                role: suggestion.role,
              )
            : suggestion,
    ];
    _applyDraft(suggestions.length, suggestions, title: draft.title);
  }

  /// Loads the saved palette handed over by the saved palettes sheet opened
  /// from Settings. It waits (stays in the slot) until the catalogue is
  /// loaded, so the markers can be resolved.
  void _onSavedDraftChanged() {
    final SavedPalette? palette = paletteSavedDraft.value;
    if (palette == null || !mounted || _loading || _catalog.isEmpty) return;
    paletteSavedDraft.value = null;
    _loadSaved(palette);
  }

  /// Uses the marker handed over by the Swatches page as the base colour.
  ///
  /// When that replaces a palette already on screen, a snackbar offers to
  /// undo it, so nothing is lost silently.
  ///
  /// Like a saved palette, it waits (stays in the slot) until the catalogue
  /// is loaded: only then the page knows whether the code needs its brand.
  Future<void> _onBaseDraftChanged() async {
    final color = paletteBaseDraft.value;
    if (color == null || !mounted || _loading) return;
    paletteBaseDraft.value = null;
    // The type asked for together with the marker (Swatches > Blending chain).
    final PaletteMode? asked = paletteBaseMode.value;
    paletteBaseMode.value = null;
    // The palette of this very marker, in the type asked for, is already on
    // screen: nothing changes, so there is nothing to ask, clear or undo.
    if (_suggestions.isNotEmpty &&
        _resolvedBase?.colorId == color.colorId &&
        _mode != PaletteMode.customPalette &&
        (asked == null || asked == _mode) &&
        !_useScenario) {
      return;
    }
    if (await _approveReplacement(dropsLocks: true) == _Approval.refused ||
        !mounted) {
      return;
    }
    final _PaletteSnapshot? previous = _snapshot();
    _cancelAi();
    setState(() {
      if (asked != null) {
        _mode = asked;
      } else if (_mode == PaletteMode.customPalette) {
        _mode = PaletteMode.recommended;
      }
      _useScenario = false;
      _dropPhoto();
      _dropChain();
      _baseInput = _baseValue(color);
      _baseController.text = _baseInput;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _aiUsed = false;
      _notice = null;
    });
    _recompute();
    _afterReplacement(previous, newBase: color);
  }

  // ---------------------------------------------------------------------------
  // Undo and "Replace this palette?"
  // ---------------------------------------------------------------------------

  /// The palette on screen, to bring it back; `null` when there is none.
  _PaletteSnapshot? _snapshot() =>
      _suggestions.isEmpty ? null : _PaletteSnapshot.of(this);

  /// Drops an AI answer still on its way: what the user just chose must not
  /// be overwritten by it.
  void _cancelAi() {
    ++_aiVersion;
    if (_aiLoading) setState(() => _aiLoading = false);
  }

  /// Margin of a floating snack bar of this page: it keeps the final Save
  /// action reachable at the foot of the list.
  EdgeInsets _snackMargin() => EdgeInsets.fromLTRB(
    InkSpacing.pageMargin,
    0,
    InkSpacing.pageMargin,
    InkGeometry.buttonHeight +
        InkSpacing.pageBottomOf(context) +
        InkSpacing.buttonGap,
  );

  /// Shows "Palette changed" (or [message], when the action says what it did
  /// itself, like a variation; or "E08 is now the base" when Swatches handed
  /// [newBase] over) with an Undo action that brings back [previous]: the
  /// markers, the locks, the base, the type, the notes and the AI state.
  void _offerUndo(
    _PaletteSnapshot previous, {
    MarkerColor? newBase,
    String? message,
    bool typing = false,
  }) {
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    if (messenger == null) return;
    messenger.hideCurrentSnackBar();
    final int generation = ++_undoGeneration;
    _undoTarget = previous;
    _undoFromTyping = typing;
    final ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack =
        messenger.showSnackBar(
          SnackBar(
            key: ValueKey<String>(
              newBase == null ? 'palette-changed' : 'palette-base-replaced',
            ),
            duration: InkMotion.undoSnack,
            behavior: SnackBarBehavior.floating,
            margin: _snackMargin(),
            // The Undo button is drawn here, not as a SnackBarAction: the
            // snack bar forces the Material default pill shape on its action.
            padding: const EdgeInsetsDirectional.only(
              start: InkSpacing.cardH,
              end: InkSpacing.s4,
            ),
            content: Builder(
              builder: (BuildContext context) => Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      newBase == null
                          ? message ?? context.l10n.paletteChanged
                          : context.l10n.paletteBaseReplaced(
                              _codeLabel(newBase),
                            ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: InkColors.of(context).pale,
                      shape: const RoundedRectangleBorder(
                        borderRadius: InkRadii.controlRadius,
                      ),
                    ),
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                      if (!mounted) return;
                      setState(() => previous.restore(this));
                    },
                    child: Text(context.l10n.paletteUndoButton),
                  ),
                ],
              ),
            ),
          ),
        );
    _undoSnack = snack;
    snack.closed.whenComplete(() {
      // The snack bar is gone (its time, Undo, or the page left).
      if (generation == _undoGeneration) {
        _undoTarget = null;
        _undoFromTyping = false;
        _undoSnack = null;
      }
    });
  }

  /// Takes the Undo snack bar down and forgets its palette: what it would
  /// bring back no longer fits the collection (see [_reload]).
  void _dropUndo() {
    final ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? snack =
        _undoSnack;
    if (snack == null) return;
    ++_undoGeneration;
    _undoTarget = null;
    _undoFromTyping = false;
    _undoSnack = null;
    snack.close();
  }

  /// Whether the palette on screen may be replaced, asking first when the
  /// user would lose work. There are exactly two such cases:
  ///
  /// 1. it is a palette loaded from "My palettes" or saved that was then
  ///    changed by hand (a lock, the size, a variation);
  /// 2. it has a locked colour the action will not keep ([dropsLocks], or
  ///    more locks than the [wanted] companions). This holds for any
  ///    palette, a fresh result included: locking a colour is the one way
  ///    the user says "keep this", so a result with a lock is no longer
  ///    untouched. An action that keeps every lock (Regenerate, Suggest with
  ///    AI, a variation) does not ask.
  ///
  /// A fresh, untouched result never asks: the Undo snack bar covers it. So
  /// does everything that is asked and confirmed.
  Future<_Approval> _approveReplacement({
    bool dropsLocks = false,
    int? wanted,
  }) async {
    // A second action while the question is open is not an answer to it.
    if (_confirmingReplacement) return _Approval.refused;
    if (_suggestions.isEmpty) return _Approval.free;
    final bool losesLocks =
        _lockedCodes.isNotEmpty &&
        (dropsLocks || (wanted != null && _lockedCodes.length > wanted));
    if (!(_workedPalette && _paletteEdited) && !losesLocks) {
      return _Approval.free;
    }
    _confirmingReplacement = true;
    try {
      final bool ok = await confirmAction(
        context,
        title: context.l10n.paletteReplaceTitle,
        body: context.l10n.paletteReplaceBody,
        confirmLabel: context.l10n.paletteReplaceButton,
      );
      return ok ? _Approval.confirmed : _Approval.refused;
    } finally {
      _confirmingReplacement = false;
    }
  }

  /// Runs [action], which replaces the palette on screen, after
  /// [_approveReplacement]; then offers the undo ([_afterReplacement]).
  ///
  /// [edit] marks a change made by hand to the palette on screen (the size,
  /// a variation) rather than a new result. [undoMessage] names what the
  /// action did, in place of "Palette changed", on the Undo snack bar.
  Future<void> _replacePalette(
    VoidCallback action, {
    bool dropsLocks = false,
    int? wanted,
    bool edit = false,
    String? undoMessage,
  }) async {
    final _Approval approval = await _approveReplacement(
      dropsLocks: dropsLocks,
      wanted: wanted,
    );
    if (approval == _Approval.refused || !mounted) return;
    final _PaletteSnapshot? previous = _snapshot();
    _cancelAi();
    action();
    _afterReplacement(
      previous,
      edit: edit && approval != _Approval.confirmed,
      undoMessage: undoMessage,
    );
  }

  /// Call once the palette on screen was replaced: offers to undo it back to
  /// [previous] when it did change, and settles whether what is on screen now
  /// is still a palette the user worked on. An [edit] of a kept palette makes
  /// it an edited one; anything else (a new result, an empty page, or a
  /// replacement the user already agreed to) is fresh.
  void _afterReplacement(
    _PaletteSnapshot? previous, {
    bool edit = false,
    MarkerColor? newBase,
    String? undoMessage,
    bool typing = false,
  }) {
    final bool changed = previous == null
        ? _suggestions.isNotEmpty
        : previous.differsFrom(this);
    if (!changed) return;
    if (edit && _suggestions.isNotEmpty) {
      if (_workedPalette) _paletteEdited = true;
    } else {
      _workedPalette = false;
      _paletteEdited = false;
    }
    // A note about the palette that was replaced ("Palette loaded", what an
    // import left out) goes with it, unless the action wrote its own.
    if (previous != null &&
        _notice != null &&
        identical(_notice, previous.notice)) {
      setState(() => _notice = null);
    }
    if (previous != null) {
      _offerUndo(
        previous,
        newBase: newBase,
        message: undoMessage,
        typing: typing,
      );
    }
  }

  /// Opens the searchable list of markers and uses the chosen one as base.
  Future<void> _pickBase() async {
    _baseFocus.unfocus();
    final List<MarkerColor> markers = _baseChoices;
    final MarkerColor? picked = await showInkSheet<MarkerColor>(
      context: context,
      builder: (BuildContext context) =>
          PaletteBasePickerSheet(markers: markers),
    );
    if (picked == null || !mounted) return;
    // The marker that is the base already: its palette stays as it is (the
    // field only takes the marker's own spelling).
    if (_suggestions.isNotEmpty &&
        _mode != PaletteMode.customPalette &&
        _resolvedBase?.colorId == picked.colorId) {
      final String value = _baseValue(picked);
      if (value != _baseInput) {
        setState(() {
          _baseInput = value;
          _baseController.text = value;
        });
      }
      return;
    }
    await _replacePalette(() {
      _baseController.text = _baseValue(picked);
      if (_mode == PaletteMode.customPalette) _mode = PaletteMode.recommended;
      _onBaseInputChangedNow(_baseValue(picked));
    });
  }

  void _applyDraft(
    int count,
    List<PaletteSuggestion> suggestions, {
    String? title,
  }) {
    void apply() {
      _mode = PaletteMode.customPalette;
      _useScenario = false;
      _dropPhoto();
      _baseInput = '';
      _baseController.text = '';
      _failure = null;
      _unknownInput = false;
      _suggestions = suggestions;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _aiUsed = false;
      _notice = title == null
          ? _PaletteNotice(_PaletteNoticeKind.draft, count: count)
          : _PaletteNotice(_PaletteNoticeKind.idea, name: title, count: count);
    }

    if (!mounted) {
      apply();
      return;
    }
    unawaited(_replacePalette(() => setState(apply), dropsLocks: true));
  }

  // ---------------------------------------------------------------------------
  // Generation
  // ---------------------------------------------------------------------------

  /// Number of companion colours: the size counts the base, which is the
  /// first band of the strip.
  int get _companions => (_paletteSize - 1).clamp(2, 4);

  /// How many companions the current result may hold. Custom palettes
  /// (applied from Ideas) keep every colour they came with.
  int get _wanted => _mode == PaletteMode.customPalette ? 12 : _companions;

  /// The base shown first in the strip and the paint order: the typed one or
  /// the default base of the selected scenario.
  MarkerColor? get _stripBase => _photoMode
      ? (_photoPicks.isEmpty ? null : _photoPicks.first.marker)
      : _resolvedBase ?? _scenarioDefaultBase;

  /// The marker the base field names, or `null`.
  ///
  /// A base written with its brand ("DecoTime 91", `decotime:91`) is that
  /// marker. A bare code is a marker of the active brand; with "Mix my
  /// brands" it is the user's marker with that code, and when two of their
  /// brands share it the code alone resolves to nothing: the page asks which
  /// (see [_errorMessage]) and the suggestions list offers both.
  MarkerColor? get _resolvedBase {
    final String input = _baseInput.trim();
    if (input.isEmpty) return null;
    final key = (input: input, catalog: _catalog, choices: _baseChoices);
    final memo = _baseMemoKey;
    if (memo != null &&
        memo.input == key.input &&
        identical(memo.catalog, key.catalog) &&
        identical(memo.choices, key.choices)) {
      return _baseMemo;
    }
    _baseMemoKey = key;
    return _baseMemo = _resolveBase(input);
  }

  MarkerColor? _resolveBase(String input) {
    final MarkerColor? branded = resolveBrandedBaseColor(input, _catalog);
    if (branded != null) return branded;
    if (!_scopeMixed) {
      return resolveBaseColor(input, <MarkerColor>[
        for (final MarkerColor c in _range)
          if (c.brandId == _brand.id) c,
      ]);
    }
    final List<MarkerColor> mine = baseCodeMatches(input, _baseChoices);
    if (mine.isNotEmpty) return hasMixedBrands(mine) ? null : mine.first;
    // None of the user's: a marker of the range gets its own reason (not in
    // the collection, dried out) instead of "unknown code".
    return resolveBaseColor(input, _range);
  }

  /// Whether the bare code in the base field is one two of the user's brands
  /// share ("Mix my brands"), so it needs its brand.
  bool get _ambiguousBase =>
      _scopeMixed &&
      resolveBrandedBaseColor(_baseInput, _catalog) == null &&
      hasMixedBrands(baseCodeMatches(_baseInput, _baseChoices));

  /// The markers the base may be: the ones the user owns, or the whole range
  /// of the brand when the blending chain is in whole-range mode (the only
  /// place where the range is offered, and the user is told so).
  List<MarkerColor> get _baseChoices =>
      _chainMode && _chainWholeRange ? _range : _available;

  String get _exampleCode {
    final source = _baseChoices;
    if (source.isNotEmpty) return _codeLabel(source.first);
    return 'A1';
  }

  /// The hint of the empty base field: two real codes of the markers the user
  /// owns in this brand (the first two of the collection, in catalogue order,
  /// so it never changes between rebuilds). One code if that is all there is;
  /// the field's label when the collection has no marker to show, so the page
  /// never offers a code of the brand's range as if it were the user's. The
  /// range is only offered where the user asked for it explicitly (the
  /// blending chain in whole-range mode), whose base is a marker of the range.
  String get _baseHint {
    final List<String> codes = <String>[
      for (final MarkerColor c in _baseChoices.take(2)) _codeLabel(c),
    ];
    return switch (codes.length) {
      0 => context.l10n.paletteBaseCodeLabel,
      1 => context.l10n.paletteBaseCodeHintOne(codes[0]),
      _ => context.l10n.paletteBaseCodeHint(codes[0], codes[1]),
    };
  }

  /// Computes the palette for the current inputs. Anything but Regenerate
  /// starts from the best palette again ([keepVariation] false); Regenerate
  /// keeps the bumped [_variationToken], so its result is another one.
  void _recompute({bool keepVariation = false}) {
    if (!keepVariation) _variationToken = 0;
    final PhotoScene? photo = _useScenario ? _photoScene : null;
    if (photo != null) {
      _applyPhotoScene(photo);
      return;
    }
    if (_mode == PaletteMode.customPalette) {
      // Manual mode: keep whatever was loaded or applied from Ideas.
      return;
    }
    final input = _baseInput.trim();
    final resolved = _resolvedBase;

    if (input.isEmpty && !_useScenario) {
      if (_suggestions.isEmpty) return;
      setState(() {
        _suggestions = const <PaletteSuggestion>[];
        _failure = null;
        _unknownInput = false;
        _lockedCodes = const <String>[];
        _lockedSuggestions.clear();
      });
      return;
    }
    if (input.isNotEmpty && resolved == null && !_useScenario) {
      setState(() {
        _suggestions = const <PaletteSuggestion>[];
        _failure = null;
        _unknownInput = true;
      });
      return;
    }

    if (_chainMode) {
      _applyChain(resolved!);
      return;
    }

    final request = _buildRequest();
    final advice = widget.advisor.advise(request);
    setState(() {
      _unknownInput = false;
      _aiUsed = false;
      _aiError = null;
      switch (advice) {
        case PaletteAdviceSuccess(:final suggestions):
          _failure = null;
          _suggestions = _mergeLocked(suggestions);
        case PaletteAdviceFailure(:final reason):
          _failure = reason;
          _suggestions = const <PaletteSuggestion>[];
      }
    });
  }

  /// Builds the blending chains around [base] from the user's markers, or from
  /// the whole range of the brand when the user asked for it.
  void _applyChain(MarkerColor base) {
    final List<MarkerColor> pool = _chainMode && _chainWholeRange
        ? _range
        : _available;
    final MarkerColor? inPool = pool
        .where((MarkerColor c) => c.colorId == base.colorId)
        .firstOrNull;
    setState(() {
      _unknownInput = false;
      _aiUsed = false;
      _aiError = null;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _chainRangeBrands = _chainWholeRange
          ? <String>{for (final MarkerColor c in pool) c.brandId}
          : const <String>{};
      if (inPool == null) {
        // Same rule as every other type: the base must be one of the markers.
        // A marker that ran dry has its own reason: it is not out of the
        // collection, it just does not paint.
        final bool dried = _scope?.dried.ids.contains(base.colorId) ?? false;
        _failure = pool.isEmpty
            ? PaletteFailureReason.noAvailableColors
            : dried
            ? PaletteFailureReason.baseDried
            : PaletteFailureReason.invalidBaseColor;
        _chainResult = null;
        _showChain(null);
        return;
      }
      _failure = null;
      final BlendingChainResult result = buildBlendingChains(
        inPool,
        pool,
        length: _paletteSize,
      );
      _chainResult = result;
      _chainIndex = 0;
      _showChain(result.best);
    });
  }

  /// Puts [chain] on screen (call inside [setState]): the companions in chain
  /// order, each with its role.
  void _showChain(BlendingChain? chain) {
    _chain = chain;
    if (chain == null) {
      _suggestions = const <PaletteSuggestion>[];
      return;
    }
    final List<String> roles = blendingChainRoles(chain);
    _suggestions = <PaletteSuggestion>[
      for (int i = 0; i < chain.colors.length; i++)
        if (i != chain.baseIndex)
          PaletteSuggestion(color: chain.colors[i], reason: roles[i]),
    ];
  }

  Future<void> _selectChain(int index) =>
      _replacePalette(() => _selectChainNow(index));

  void _selectChainNow(int index) {
    final BlendingChainResult? result = _chainResult;
    if (result == null || index < 0 || index >= result.chains.length) return;
    setState(() {
      _chainIndex = index;
      _showChain(result.chains[index]);
    });
  }

  Future<void> _setChainWholeRange(bool value) =>
      _replacePalette(() => _setChainWholeRangeNow(value), dropsLocks: true);

  void _setChainWholeRangeNow(bool value) {
    setState(() => _chainWholeRange = value);
    _recompute();
  }

  /// Forgets the chains (call inside [setState]).
  void _dropChain() {
    _chainResult = null;
    _chain = null;
    _chainIndex = 0;
    _chainWholeRange = false;
    _chainRangeBrands = const <String>{};
  }

  /// What the whole-range note says: whose range the chain was searched in.
  ///
  /// A chain on screen names the range it was built from, which is not the
  /// one in use any more when it was kept across a change of brand or of
  /// "Mix my brands" (see [_reload]). Without a chain it is the range a
  /// search would use now: the active brand's, or with "Mix my brands" the
  /// one of every brand in the mix, which names no single brand.
  String _chainRangeNote(AppLocalizations t) {
    final Set<String> built = _chain == null
        ? const <String>{}
        : _chainRangeBrands;
    if (built.isEmpty) {
      return _scopeMixed
          ? t.paletteChainWholeRangeNoteMixed
          : t.paletteChainWholeRangeNote(_brand.label);
    }
    return built.length > 1
        ? t.paletteChainWholeRangeNoteMixed
        : t.paletteChainWholeRangeNote(MarkerBrand.fromId(built.single).label);
  }

  /// The request for the current UI state, shared by the local engine and the
  /// optional AI advisor.
  PaletteAdvisorRequest _buildRequest() => PaletteAdvisorRequest(
    scenario: _useScenario ? _scenario : null,
    baseColor: _resolvedBase,
    availableColors: _available,
    paletteSize: _companions,
    mode: _mode,
    brand: _brand,
    scope: _scope?.settings.scope ?? BrandScope.singleBrand,
    ownedMarkerCodes: _scope?.settings.settings.ownedMarkerCodes ?? const {},
    activeSetIds: _scope?.settings.settings.effectiveSetIds() ?? const {},
    // The markers the user owns that ran dry: a base among them is refused
    // with its own reason, not as a marker out of the collection.
    driedColorIds: _scope?.dried.ids ?? const {},
    variationToken: _variationToken,
  );

  /// Puts the locked colours into [base] without moving anything the user
  /// sees: a locked colour stays in the slot it has on screen now (and keeps
  /// its own reason), and only the free slots take [base]'s colours, in
  /// order. A locked colour that is not on screen takes the first free slot.
  List<PaletteSuggestion> _mergeLocked(List<PaletteSuggestion> base) {
    final wanted = _wanted;
    if (_lockedCodes.isEmpty) return base.take(wanted).toList();
    final slots = List<PaletteSuggestion?>.filled(wanted, null);
    final used = <String>{};
    final pending = <String>[];
    for (final code in _lockedCodes) {
      final normalized = code.toUpperCase();
      if (used.contains(normalized)) continue;
      final int onScreen = _suggestions.indexWhere(
        (s) => s.color.colorId.toUpperCase() == normalized,
      );
      final PaletteSuggestion? locked = _lockedSuggestion(code, base);
      if (locked == null) continue;
      if (onScreen >= 0 && onScreen < wanted && slots[onScreen] == null) {
        slots[onScreen] = locked;
        used.add(normalized);
      } else {
        pending.add(code);
      }
    }
    for (final code in pending) {
      final int free = slots.indexOf(null);
      if (free < 0) break;
      final normalized = code.toUpperCase();
      if (!used.add(normalized)) continue;
      slots[free] = _lockedSuggestion(code, base);
    }
    final Iterator<PaletteSuggestion> rest = base
        .where((s) => !used.contains(s.color.colorId.toUpperCase()))
        .iterator;
    for (var i = 0; i < wanted; i++) {
      if (slots[i] != null) continue;
      while (rest.moveNext()) {
        final String normalized = rest.current.color.colorId.toUpperCase();
        if (used.add(normalized)) {
          slots[i] = rest.current;
          break;
        }
      }
    }
    return slots.whereType<PaletteSuggestion>().toList();
  }

  /// The suggestion to show for the locked [code]: the one it had when it was
  /// locked, else the one in [base], else a bare catalog colour.
  PaletteSuggestion? _lockedSuggestion(
    String code,
    List<PaletteSuggestion> base,
  ) {
    final normalized = code.toUpperCase();
    final PaletteSuggestion? kept =
        _lockedSuggestions[code] ?? _lockedSuggestions[normalized];
    if (kept != null) return kept;
    for (final suggestion in base) {
      if (suggestion.color.colorId.toUpperCase() == normalized) {
        return suggestion;
      }
    }
    for (final color in _catalog) {
      if (color.colorId.toUpperCase() == normalized) {
        return PaletteSuggestion(color: color, reason: PaletteReasons.loaded);
      }
    }
    return null;
  }

  void _toggleLock(PaletteSuggestion suggestion) {
    final code = suggestion.color.colorId;
    final normalized = code.toUpperCase();
    setState(() {
      if (_lockedCodes.any((value) => value.toUpperCase() == normalized)) {
        _lockedCodes = _lockedCodes
            .where((value) => value.toUpperCase() != normalized)
            .toList();
        _lockedSuggestions.remove(code);
        _lockedSuggestions.remove(normalized);
      } else {
        _lockedCodes = <String>[..._lockedCodes, code];
        _lockedSuggestions[code] = suggestion;
        _lockedSuggestions[normalized] = suggestion;
      }
      _suggestions = _mergeLocked(_suggestions);
      if (_workedPalette) _paletteEdited = true;
    });
  }

  /// The variation is told once, by the Undo snack bar ("Cooler variation
  /// applied."), not also by a note on the page: two messages for one action,
  /// and the note would outlive an Undo.
  Future<void> _applyVariation(QuickPaletteVariation variation) async {
    // Same as Regenerate: a base of a brand that is not in use is not
    // remixed with the markers of the brand in use.
    if (_wouldRebuildOtherBrandBase) return _explainOtherBrandBase();
    await _replacePalette(
      () => _applyVariationNow(variation),
      edit: true,
      undoMessage: context.l10n.paletteVariationApplied(
        context.l10n.variationName(variation),
      ),
    );
  }

  void _applyVariationNow(QuickPaletteVariation variation) {
    if (_suggestions.isEmpty || _available.isEmpty || _chainMode) return;
    final varied = remixPaletteWithVariation(
      _suggestions,
      _available,
      _lockedCodes.toSet(),
      _resolvedBase?.colorId,
      variation,
      size: _companions,
    );
    setState(() {
      _suggestions = _mergeLocked(varied);
      _aiUsed = false;
    });
  }

  /// Opens the palette type sheet: a colour-theory mode or the scenes.
  Future<void> _pickType() async {
    _baseFocus.unfocus();
    final PaletteTypeChoice? choice = await showPaletteTypeSheet(
      context,
      mode: _mode,
      scenesSelected: _useScenario,
      scenesAvailable: SceneCatalog.isInstalled,
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case ModeChoice(:final PaletteMode mode):
        if (mode == _mode && !_useScenario) return;
        await _selectMode(mode);
      case ScenesChoice():
        if (_useScenario) return;
        await _selectScenes();
    }
  }

  /// Opens the tall, searchable list of scenes.
  Future<void> _pickScene() async {
    _baseFocus.unfocus();
    final SceneSheetResult? picked = await showPaletteSceneSheet(
      context,
      selected: _photoScene == null ? _scenario : null,
      previews: _previews,
      photoSelected: _photoScene != null,
    );
    if (picked == null || !mounted) return;
    switch (picked) {
      case ScenePicked(:final Scene scene):
        await _selectScenario(scene);
      case PhotoScenePicked():
        await _pickPhotoScene();
    }
  }

  // ---------------------------------------------------------------------------
  // Type, scene and size
  // ---------------------------------------------------------------------------

  Future<void> _selectMode(PaletteMode mode) =>
      _replacePalette(() => _selectModeNow(mode), dropsLocks: true);

  void _selectModeNow(PaletteMode mode) {
    setState(() {
      _mode = mode;
      // A type is one choice among the others: a colour-theory mode leaves
      // the scenes.
      _useScenario = false;
      _dropPhoto();
      _dropChain();
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      if (mode == PaletteMode.customPalette) {
        // Custom mode is manual: clear the generated result so the hint shows.
        _suggestions = const <PaletteSuggestion>[];
        _failure = null;
        _unknownInput = false;
        _aiUsed = false;
      }
    });
    _recompute();
  }

  Future<void> _selectScenes() =>
      _replacePalette(_selectScenesNow, dropsLocks: true);

  void _selectScenesNow() {
    setState(() {
      _useScenario = true;
      // The scenes leave the chain behind: the whole-range flag goes with it,
      // so the range is never offered outside the chain.
      _dropChain();
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
    });
    _recompute();
  }

  Future<void> _selectScenario(Scene scene) =>
      _replacePalette(() => _selectScenarioNow(scene), dropsLocks: _photoMode);

  void _selectScenarioNow(Scene scene) {
    setState(() {
      _sceneChoice = scene;
      // A scene replaces the photo palette.
      _dropPhoto();
    });
    _recompute();
  }

  Future<void> _selectSize(int size) => _replacePalette(
    () => _selectSizeNow(size),
    // The companions that fit the new size: a lock beyond them is lost.
    wanted: (size - 1).clamp(2, 4),
    edit: true,
  );

  void _selectSizeNow(int size) {
    setState(() => _paletteSize = size);
    _recompute();
  }

  /// The base field changed (a keystroke, or a suggestion of its list).
  ///
  /// Typing a code replaces the palette more than once on the way ("1",
  /// "12", "120"): while the Undo of the first of those changes is still on
  /// screen, it keeps pointing at the palette the user started from.
  Future<void> _onBaseInputChanged(String value) async {
    final _Approval approval = await _approveReplacement();
    if (!mounted) return;
    if (approval == _Approval.refused) {
      // Nothing changes: the field goes back to the base of the palette.
      _baseController.text = _baseInput;
      return;
    }
    final _PaletteSnapshot? previous = _undoFromTyping && _undoTarget != null
        ? _undoTarget
        : _snapshot();
    _onBaseInputChangedNow(value);
    _afterReplacement(previous, typing: true);
  }

  void _onBaseInputChangedNow(String value) {
    _cancelAi();
    setState(() {
      _baseInput = value;
      _notice = null;
    });
    _recompute();
  }

  Future<void> _clear() => _replacePalette(_clearNow, dropsLocks: true);

  void _clearNow() {
    setState(() {
      _baseInput = '';
      _baseController.text = '';
      _suggestions = const <PaletteSuggestion>[];
      _failure = null;
      _unknownInput = false;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _aiUsed = false;
      _aiError = null;
      _notice = null;
      _dropPhoto();
      _dropChain();
    });
  }

  // ---------------------------------------------------------------------------
  // Presentation helpers
  // ---------------------------------------------------------------------------

  /// The colour of a code as the page shows it (bare, or with its brand); a
  /// code that names no marker falls back to the theme's neutral.
  String _hexForCode(String code) =>
      (resolveBrandedBaseColor(code, _catalog) ??
              resolveBaseColor(code, <MarkerColor>[
                for (final MarkerColor c in _catalog)
                  if (c.brandId == _brand.id) c,
              ]))
          ?.hex ??
      InkColors.of(context).unknownSwatchHex;

  String _roleFor(PaletteSuggestion suggestion) {
    // An AI item carries its own role, from the same item as its reason.
    final String? given = suggestion.role?.trim();
    if (given != null && given.isNotEmpty) return given;
    if (_photoMode) return _photoRole(suggestion.color);
    if (_useScenario) return suggestion.reason;
    return PaletteRoles.fromReason(suggestion.reason);
  }

  String? _errorMessage() {
    final failure = _failure;
    if (failure == null && !_unknownInput) return null;
    final input = _baseInput.trim().toUpperCase();
    final example = _exampleCode;
    if (_unknownInput) {
      // Two of the user's brands have this code: it needs its brand.
      if (_ambiguousBase) return context.l10n.paletteAmbiguousBase;
      return context.l10n.paletteUnknownCode(_brandSelector, input, example);
    }
    return switch (failure!) {
      PaletteFailureReason.noAvailableColors =>
        context.l10n.paletteNoAvailableColors(_brandSelector),
      PaletteFailureReason.missingBaseColor => context.l10n.paletteMissingBase(
        example,
      ),
      PaletteFailureReason.invalidBaseColor =>
        _baseOfUnusedBrand(example) ??
            context.l10n.paletteNotAvailable(_brandSelector, input, example),
      PaletteFailureReason.baseDried => context.l10n.paletteBaseDried(input),
      PaletteFailureReason.noSuggestions => context.l10n.paletteNoSuggestions,
    };
  }

  /// The base when its brand is not among the brands in use (the active one,
  /// or every brand of the mix with "Mix my brands"), `null` for any other
  /// base. That happens to a palette kept across a change of brand or of the
  /// mix, and to one loaded from a brand outside the mix. The engines refuse
  /// such a base, and "not in your collection" would be false.
  MarkerColor? get _baseOfOtherBrand {
    final MarkerColor? base = _resolvedBase;
    if (base == null ||
        _range.any((MarkerColor c) => c.brandId == base.brandId)) {
      return null;
    }
    return base;
  }

  /// What to say when the base is a marker of a brand that is not in use
  /// (see [_baseOfOtherBrand]); `null` for any other base.
  String? _baseOfUnusedBrand(String example) {
    final MarkerColor? base = _baseOfOtherBrand;
    if (base == null) return null;
    return context.l10n.paletteBaseOtherBrand(
      base.newCode,
      MarkerBrand.fromId(base.brandId).label,
      example,
    );
  }

  /// Whether Regenerate or a variation would have to rebuild the palette
  /// around a base whose brand is not among the brands in use (mixed or not,
  /// see [_baseOfOtherBrand]): the engines refuse it, so the palette on
  /// screen would be emptied (Regenerate) or silently remixed with the brands
  /// in use (a variation). Not for a blending chain, whose Regenerate only
  /// steps through the chains already built, nor for a photo palette or the
  /// manual mode, which have no base to rebuild around.
  bool get _wouldRebuildOtherBrandBase =>
      !_chainMode &&
      !_photoMode &&
      _mode != PaletteMode.customPalette &&
      _suggestions.isNotEmpty &&
      _baseInput.trim().isNotEmpty &&
      _baseOfOtherBrand != null;

  /// Says why the palette on screen stays as it is. A snack bar, not a note
  /// on the page: nothing on the page moves, and nothing changed to undo.
  void _explainOtherBrandBase() {
    final String? message = _baseOfUnusedBrand(_exampleCode);
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    if (message == null || messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const ValueKey<String>('palette-other-brand-snack'),
          duration: InkMotion.undoSnack,
          behavior: SnackBarBehavior.floating,
          margin: _snackMargin(),
          content: Text(message),
        ),
      );
  }

  /// Selector of the brand-aware messages, with ICU's `other` fallback
  /// (which names no brand: the one used with "Mix my brands").
  String get _brandSelector => _scopeMixed ? 'mixed' : _brand.name;

  Scene? get _defaultScenarioBaseNotice {
    if (!_useScenario || _photoMode) return null;
    if (_baseInput.trim().isNotEmpty) return null;
    if (_available.isEmpty) return null;
    return _scenario;
  }

  MarkerColor? get _scenarioDefaultBase {
    if (_defaultScenarioBaseNotice == null) return null;
    return findScenarioDefaultBase(_available, _scenario);
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final scope = _scopeOf(context);
    if (scope == null) {
      return Center(
        key: PalettePage.pageKey,
        child: Text(
          context.l10n.paletteTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }
    if (_loading) {
      return const Center(
        key: PalettePage.pageKey,
        child: CircularProgressIndicator(),
      );
    }

    final bool customMode = _mode == PaletteMode.customPalette;
    // The empty collection state (no markers, or all of them dried) already
    // says what is wrong and offers the way out, so the failure note must not
    // repeat it above it.
    final bool emptyCollectionStateVisible =
        !_hasMarkers &&
        _suggestions.isEmpty &&
        !(_chainMode && _chainWholeRange) &&
        !customMode &&
        !_photoMode;
    final String? error =
        _photoError ?? (emptyCollectionStateVisible ? null : _errorMessage());
    final bool hasResult = _suggestions.isNotEmpty;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool split = InkLayout.isSplit(constraints.biggest);
        return InkReadableWidth(
          maxWidth: split ? InkLayout.wideWidth : InkLayout.readableWidth,
          child: _buildBody(
            context,
            scope,
            split: split,
            customMode: customMode,
            error: error,
            hasResult: hasResult,
          ),
        );
      },
    );
  }

  /// The page: the header, then the controls and the result in one list, or
  /// side by side when [split] (a tablet in landscape).
  Widget _buildBody(
    BuildContext context,
    AppScope scope, {
    required bool split,
    required bool customMode,
    required String? error,
    required bool hasResult,
  }) {
    final List<Widget> header = <Widget>[
      InkPageHeader(
        title: context.l10n.paletteTitle,
        subtitle: _subtitle(),
        action: InkIconButton(
          key: const ValueKey<String>('palette-saved-palettes'),
          icon: InkIcons.bookmark,
          tooltip: context.l10n.paletteSavedTitle,
          onPressed: () => _openSavedPalettes(scope),
        ),
        // The type field below must not jump when the type (or the base)
        // swaps the subtitle: reserve the tallest one.
        reserveSubtitleFor: <String>[
          context.l10n.paletteSubtitleIdle,
          for (final int count in const <int>[0, 1, 2, 99, 999]) ...<String>[
            context.l10n.commonMarkersAvailable(count),
            context.l10n.paletteSubtitleCustom(count),
          ],
        ],
      ),
    ];
    final List<Widget> top = <Widget>[
      PaletteTypeFields(
        useScenario: _useScenario,
        mode: _mode,
        scenario: _scenario,
        photoScene: _photoScene,
        photoBusy: _photoBusy,
        previews: _previews,
        photoPicks: _photoPicks,
        onPickType: _pickType,
        onPickScene: _pickScene,
      ),
      PaletteBaseAndSize(
        customMode: customMode || _photoMode,
        paletteSize: _paletteSize,
        onSizeChanged: _selectSize,
        catalog: _baseChoices,
        resolvedBase: _resolvedBase,
        exampleCode: _exampleCode,
        hint: _baseHint,
        baseController: _baseController,
        baseFocus: _baseFocus,
        onBaseChanged: _onBaseInputChanged,
        onPickBase: _pickBase,
      ),
      if (_scenarioDefaultBase != null)
        paletteInset(
          PaletteInfoCard(
            message: context.l10n.paletteUsingDefaultBase(
              _codeLabel(_scenarioDefaultBase!),
              context.l10n.scenarioLabel(_scenario),
            ),
          ),
          top: InkSpacing.block,
        ),
      if (customMode)
        paletteInset(
          PaletteInfoCard(message: context.l10n.paletteCustomModeHint),
          top: InkSpacing.block,
        ),
      if (_photoHasFarPick)
        paletteInset(
          KeyedSubtree(
            key: const ValueKey<String>('palette-photo-far-note'),
            child: PaletteInfoCard(
              message: context.l10n.paletteFromPhotoFarNote,
            ),
          ),
          top: InkSpacing.block,
        ),
      if (_notice != null)
        paletteInset(
          PaletteNoticeCard(
            message: _notice!.message(context.l10n),
            onDismiss: () => setState(() => _notice = null),
          ),
          top: InkSpacing.block,
        ),
      if (error != null)
        paletteInset(PaletteErrorNote(message: error), top: InkSpacing.block),
    ];
    final List<Widget> result = <Widget>[
      ..._buildChainNotes(),
      if (hasResult) ..._buildResult(split: split),
      // Without a marker of the collection there is nothing to build: the
      // page says so and offers the collection, instead of the hint that
      // asks for a base marker the user does not have. The blending chain
      // can still use the whole range when the user asks for it.
      if (!_hasMarkers &&
          !hasResult &&
          !(_chainMode && _chainWholeRange) &&
          !customMode &&
          !_photoMode)
        paletteInset(_emptyCollectionState(), top: InkSpacing.block)
      else if (!hasResult &&
          error == null &&
          !customMode &&
          !(_chainMode && _chainResult != null))
        paletteInset(
          PaletteInfoCard(message: context.l10n.paletteEmptyHint),
          top: InkSpacing.block,
        ),
    ];
    final Widget actions = PaletteActions(
      customMode: customMode,
      photoMode: _photoMode,
      chainMode: _chainMode,
      aiAvailable: _aiAvailable,
      aiLoading: _aiLoading,
      aiError: _aiError,
      hasResult: hasResult,
      saved: hasResult && _isSaved,
      canRegenerate: _canRegenerate,
      canGenerate: _canBuild,
      canSuggestAi: _canBuild,
      onSuggestAi: _suggestWithAi,
      onRegenerate: _regenerate,
      onGenerate: () => _replacePalette(_recompute),
      onSave: _save,
    );
    final EdgeInsets listPadding = EdgeInsets.only(
      bottom: InkSpacing.pageBottomOf(context),
    );
    return Column(
      key: PalettePage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ...header,
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: _onUserScroll,
            child: split
                // The controls and the buttons on one side, the palette they
                // make on the other.
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          key: const ValueKey<String>('palette-controls-side'),
                          padding: listPadding,
                          children: <Widget>[...top, actions],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          key: const ValueKey<String>('palette-result-side'),
                          padding: listPadding,
                          children: result,
                        ),
                      ),
                    ],
                  )
                : ListView(
                    padding: listPadding,
                    children: <Widget>[...top, ...result, actions],
                  ),
          ),
        ),
      ],
    );
  }

  /// Closes the base-marker suggestions when the user scrolls the page, so the
  /// floating list never outlives the field it belongs to.
  bool _onUserScroll(UserScrollNotification notification) {
    if (notification.direction != ScrollDirection.idle && _baseFocus.hasFocus) {
      _baseFocus.unfocus();
    }
    return false;
  }

  /// The empty state of a collection with no markers of the brand: the page
  /// says which brand is empty and opens the collection, the way Settings
  /// does.
  ///
  /// A collection whose markers all ran dry is not an empty one: it says
  /// that, instead of claiming the user owns nothing.
  ///
  /// With "Mix my brands" in effect there are usable markers of two brands,
  /// so the title only ever speaks of the active brand. "All dried out"
  /// counts every brand the switch covers (see `ownedCandidateColors`).
  Widget _emptyCollectionState() {
    final AppLocalizations l10n = context.l10n;
    return EmptyState(
      key: const ValueKey<String>('palette-empty-collection'),
      icon: InkIcons.grid,
      title: _allMarkersDried
          ? l10n.driedTitle
          : l10n.missingMarkersTitle(_brand.label),
      message: _allMarkersDried ? l10n.allMarkersDried : null,
      actions: <Widget>[
        InkButton.secondary(
          key: const ValueKey<String>('palette-empty-collection-action'),
          label: l10n.missingMarkersAction,
          expand: true,
          onPressed: () => CollectionPage.open(context),
        ),
      ],
    );
  }

  String _subtitle() {
    if (_useScenario) {
      return context.l10n.commonMarkersAvailable(_available.length);
    }
    if (_mode == PaletteMode.customPalette) {
      // The base is the first band of the strip, so it counts like the
      // others: the same number as "Combinations (n)" under it.
      return context.l10n.paletteSubtitleCustom(
        _suggestions.length + (_stripBase == null ? 0 : 1),
      );
    }
    final MarkerColor? base = _resolvedBase;
    if (base != null) {
      return context.l10n.commonMarkersAvailable(_available.length);
    }
    return context.l10n.paletteSubtitleIdle;
  }

  bool _isLocked(PaletteSuggestion suggestion) => _lockedCodes.any(
    (code) => code.toUpperCase() == suggestion.color.colorId.toUpperCase(),
  );

  /// Whether Regenerate has anything else to show. A blending chain has
  /// nothing to roll: it steps through the alternative chains of its result,
  /// so it needs at least two.
  bool get _canRegenerate =>
      !_chainMode || (_chainResult?.chains.length ?? 0) > 1;

  /// Regenerates the palette on screen: another variation of the same type
  /// (the base marker and the locked ones stay), or, for a blending chain,
  /// the next alternative chain.
  ///
  /// A palette built on a marker of a brand that is not in use stays as it is
  /// (the engines would refuse that base and empty it): the user is told why.
  Future<void> _regenerate() async {
    if (_wouldRebuildOtherBrandBase) return _explainOtherBrandBase();
    await _replacePalette(_regenerateNow);
  }

  void _regenerateNow() {
    if (_chainMode) {
      final BlendingChainResult? result = _chainResult;
      if (result == null || result.chains.length < 2) return;
      _selectChainNow((_chainIndex + 1) % result.chains.length);
      return;
    }
    setState(() => _variationToken++);
    _recompute(keepVariation: true);
  }
}
