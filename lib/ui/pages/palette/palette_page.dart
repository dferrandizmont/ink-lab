import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;

import '../../../ai/palette_advisor.dart' as ai;
import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../core/palette_advisor.dart';
import '../../../core/match_quality.dart';
import '../../../core/palette_generator.dart';
import '../../../core/photo_palette.dart';
import '../../../core/color_utils.dart';
import '../../../core/scene_catalog.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_segmented.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/palette_strip.dart';
import '../match/color_sampling.dart';
import '../match/image_picker_service.dart';
import 'palette_draft.dart';
import 'palette_photo_scene.dart';
import 'palette_reasons.dart';
import 'palette_type_picker.dart';
import '../../../l10n/l10n.dart';

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

  @override
  State<PalettePage> createState() => _PalettePageState();
}

class _PalettePageState extends State<PalettePage> with WidgetsBindingObserver {
  late final ImagePickerService _picker =
      widget.picker ?? PlatformImagePickerService();
  late final PhotoDecoder _decode =
      widget.decoder ??
      (Uint8List bytes) =>
          decodePhoto(bytes, maxDimension: PhotoScene.maxDimension);
  late final PhotoColorExtractor _extract =
      widget.photoExtractor ?? extractPhotoColors;

  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _settingsSubscription;
  StreamSubscription<AiSettings>? _aiSubscription;
  String _collectionSignature = '';

  /// Whether the optional AI advisor is configured (enabled + OpenRouter +
  /// stored key). Drives the "Suggest with AI" button.
  bool _aiAvailable = false;
  bool _aiLoading = false;

  /// Whether the suggestions currently on screen came from the AI.
  bool _aiUsed = false;

  /// Id of the model that produced the AI result on screen.
  String _aiModel = '';

  /// How many colours of the AI result on screen came from the model, and how
  /// many there are in all (the rest were completed by colour theory).
  int _aiCount = 0;
  int _aiTotal = 0;

  /// Typed message of the last failed AI call, shown next to the button.
  String? _aiError;

  /// Saved-palette streams, one per brand, so the StreamBuilder keeps its
  /// subscription across rebuilds.
  final Map<MarkerBrand, Stream<List<SavedPalette>>> _savedStreams =
      <MarkerBrand, Stream<List<SavedPalette>>>{};

  MarkerBrand _brand = MarkerBrand.ohuhuOahu;
  List<MarkerColor> _catalog = const <MarkerColor>[];
  List<MarkerColor> _available = const <MarkerColor>[];
  bool _loading = true;

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

  List<PaletteSuggestion> _suggestions = const <PaletteSuggestion>[];
  PaletteFailureReason? _failure;
  bool _unknownInput = false;

  List<String> _lockedCodes = const <String>[];
  final Map<String, PaletteSuggestion> _lockedSuggestions =
      <String, PaletteSuggestion>{};

  String? _notice;

  /// Keyboard height at the last metrics change, to notice it closing.
  double _keyboardInset = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _baseController = TextEditingController();
    paletteDraft.addListener(_onDraftChanged);
    paletteBaseDraft.addListener(_onBaseDraftChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onDraftChanged();
      _onBaseDraftChanged();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = _scopeOf(context);
    if (scope == null || identical(scope, _scope)) return;
    _scope = scope;
    _savedStreams.clear();
    _settingsSubscription?.cancel();
    _collectionSignature = _signatureOf(scope.settings.state);
    _settingsSubscription = scope.settings.changes.listen(_onSettingsChanged);
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
    _settingsSubscription?.cancel();
    _aiSubscription?.cancel();
    _photoToken++;
    _photoScene?.dispose();
    _baseController.dispose();
    _baseFocus.dispose();
    super.dispose();
  }

  String _signatureOf(AppSettingsState state) {
    final sets = state.settings.effectiveSetIds().toList()..sort();
    final owned = state.settings.ownedMarkerCodes.toList()..sort();
    return '${state.brand.id}|${sets.join(',')}|${owned.join(',')}';
  }

  void _onSettingsChanged(AppSettingsState state) {
    final signature = _signatureOf(state);
    if (signature == _collectionSignature) return;
    _collectionSignature = signature;
    unawaited(_reload());
  }

  /// Recomputes whether the AI button should be offered.
  Future<void> _refreshAiAvailability() async {
    final scope = _scope;
    if (scope == null) return;
    final bool available = await scope.aiService.isAiAvailable();
    if (!mounted) return;
    if (available != _aiAvailable) setState(() => _aiAvailable = available);
  }

  Future<void> _reload() async {
    final scope = _scope;
    if (scope == null) return;
    final brand = scope.settings.brand;
    final settings = scope.settings.settings;
    setState(() => _loading = true);
    List<MarkerColor> catalog;
    try {
      catalog = await scope.markers.loadColors(brand);
    } catch (_) {
      catalog = const <MarkerColor>[];
    }
    try {
      await scope.markers.loadScenes();
    } catch (_) {
      // Without the scene catalogue the Scenes type is simply not offered.
    }
    if (!mounted) return;
    final available = paletteCandidateColors(
      colors: catalog,
      brand: brand,
      activeSetIds: settings.effectiveSetIds(),
      ownedMarkerCodes: settings.ownedMarkerCodes,
    );
    setState(() {
      _brand = brand;
      _catalog = catalog;
      _previews = ScenePreviews(catalog);
      _available = available;
      _loading = false;
    });
    _recompute();
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

  /// Uses the marker handed over by the Swatches page as the base colour.
  ///
  /// When that replaces a palette already on screen, a snackbar offers to
  /// undo it, so nothing is lost silently.
  void _onBaseDraftChanged() {
    final color = paletteBaseDraft.value;
    if (color == null || !mounted) return;
    paletteBaseDraft.value = null;
    final bool sameBase =
        _baseInput.trim().toUpperCase() == color.newCode.toUpperCase() &&
        _mode != PaletteMode.customPalette &&
        !_useScenario;
    // A palette made from a photo cannot be brought back (the photo is not
    // kept), so replacing one offers no undo.
    final _PaletteSnapshot? previous =
        _suggestions.isEmpty || sameBase || _photoMode
        ? null
        : _PaletteSnapshot.of(this);
    setState(() {
      if (_mode == PaletteMode.customPalette) _mode = PaletteMode.recommended;
      _useScenario = false;
      _dropPhoto();
      _baseInput = color.newCode;
      _baseController.text = color.newCode;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _aiUsed = false;
      _notice = null;
    });
    _recompute();
    if (previous != null) _offerUndo(color, previous);
  }

  /// Shows "E08 is now the base" with an Undo action that brings back the
  /// palette [previous].
  void _offerUndo(MarkerColor color, _PaletteSnapshot previous) {
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    if (messenger == null) return;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        key: const ValueKey<String>('palette-base-replaced'),
        // The Undo button is drawn here, not as a SnackBarAction: the snack
        // bar forces the Material default pill shape on its action.
        padding: const EdgeInsetsDirectional.only(start: 16, end: 4),
        content: Row(
          children: <Widget>[
            Expanded(
              child: Text(context.l10n.paletteBaseReplaced(color.newCode)),
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
    );
  }

  /// Opens the searchable list of markers and uses the chosen one as base.
  Future<void> _pickBase() async {
    _baseFocus.unfocus();
    final List<MarkerColor> markers = _available.isNotEmpty
        ? _available
        : _catalog;
    final MarkerColor? picked = await showInkSheet<MarkerColor>(
      context: context,
      builder: (BuildContext context) => _BasePickerSheet(markers: markers),
    );
    if (picked == null || !mounted) return;
    _baseController.text = picked.newCode;
    if (_mode == PaletteMode.customPalette) {
      setState(() => _mode = PaletteMode.recommended);
    }
    _onBaseInputChanged(picked.newCode);
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
          ? context.l10n.paletteDraftApplied(count)
          : context.l10n.paletteIdeaApplied(title, count);
    }

    if (!mounted) {
      apply();
      return;
    }
    setState(apply);
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

  MarkerColor? get _resolvedBase {
    final input = _baseInput.trim();
    if (input.isEmpty) return null;
    return resolveBaseColor(input, _catalog);
  }

  String get _exampleCode {
    final source = _available.isNotEmpty ? _available : _catalog;
    if (source.isNotEmpty) return source.first.newCode;
    return 'A1';
  }

  void _recompute() {
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

  /// The request for the current UI state, shared by the local engine and the
  /// optional AI advisor.
  PaletteAdvisorRequest _buildRequest() => PaletteAdvisorRequest(
    scenario: _useScenario ? _scenario : null,
    baseColor: _resolvedBase,
    availableColors: _available,
    paletteSize: _companions,
    mode: _mode,
    brand: _brand,
    ownedMarkerCodes: _scope?.settings.settings.ownedMarkerCodes ?? const {},
    activeSetIds: _scope?.settings.settings.effectiveSetIds() ?? const {},
    variationToken: _variationToken,
  );

  /// Applies the local engine's answer in place (call inside [setState]).
  void _applyLocalAdvice(PaletteAdvisorRequest request) {
    final advice = widget.advisor.advise(request);
    switch (advice) {
      case PaletteAdviceSuccess(:final suggestions):
        _failure = null;
        _suggestions = _mergeLocked(suggestions);
      case PaletteAdviceFailure(:final reason):
        _failure = reason;
        _suggestions = const <PaletteSuggestion>[];
    }
  }

  /// Runs the optional AI advisor for the current request.
  ///
  /// Never blocks: the advisor already falls back to the local engine, and any
  /// throw is caught here. The local result already on screen is kept when the
  /// AI fails, and the typed reason is shown next to the button.
  Future<void> _suggestWithAi() async {
    final scope = _scope;
    if (scope == null || _aiLoading) return;
    final request = _buildRequest();
    final int version = ++_aiVersion;
    setState(() {
      _aiLoading = true;
      _aiUsed = false;
      _aiModel = '';
      _aiCount = 0;
      _aiTotal = 0;
      _aiError = null;
      _unknownInput = false;
      _notice = null;
    });
    try {
      final advisor = await scope.aiService.buildAdvisor();
      final ai.PaletteAdvice advice = await advisor.advise(request);
      if (!mounted || version != _aiVersion) return;
      setState(() {
        _aiLoading = false;
        switch (advice) {
          case ai.PaletteAdviceSuccess(
            :final suggestions,
            :final modelUsed,
            :final tips,
            :final aiCount,
          ):
            // The local fallback reports no model; the AI always names one.
            if (modelUsed.isNotEmpty) {
              _failure = null;
              _suggestions = _mergeLocked(suggestions);
              _aiUsed = true;
              _aiModel = modelUsed;
              _aiCount = aiCount;
              _aiTotal = suggestions.length;
            } else {
              _aiUsed = false;
              _aiError = tips.isNotEmpty ? tips.first : aiFellBackNote;
              _keepLocalResult(request, suggestions);
            }
          case ai.PaletteAdviceFailure(:final reason, :final message):
            _aiUsed = false;
            _aiError = message.isNotEmpty ? message : reason.userMessage;
            _keepLocalResult(request, null);
        }
      });
    } catch (_) {
      if (!mounted || version != _aiVersion) return;
      setState(() {
        _aiLoading = false;
        _aiUsed = false;
        _aiError = aiFellBackNote;
        _keepLocalResult(request, null);
      });
    }
  }

  /// Keeps the local result on screen after a failed AI call (call inside
  /// [setState]); computes one only when there is none yet.
  void _keepLocalResult(
    PaletteAdvisorRequest request,
    List<PaletteSuggestion>? fallback,
  ) {
    if (_suggestions.isNotEmpty) return;
    if (fallback != null && fallback.isNotEmpty) {
      _failure = null;
      _suggestions = _mergeLocked(fallback);
      return;
    }
    _applyLocalAdvice(request);
  }

  List<PaletteSuggestion> _mergeLocked(List<PaletteSuggestion> base) {
    final wanted = _wanted;
    if (_lockedCodes.isEmpty) return base.take(wanted).toList();
    final used = <String>{};
    final merged = <PaletteSuggestion>[];
    for (final code in _lockedCodes) {
      if (merged.length >= wanted) break;
      final normalized = code.toUpperCase();
      PaletteSuggestion? locked =
          _lockedSuggestions[code] ?? _lockedSuggestions[normalized];
      if (locked == null) {
        for (final suggestion in base) {
          if (suggestion.color.newCode.toUpperCase() == normalized) {
            locked = suggestion;
            break;
          }
        }
      }
      if (locked == null) {
        for (final color in _catalog) {
          if (color.newCode.toUpperCase() == normalized) {
            locked = PaletteSuggestion(
              color: color,
              reason: context.l10n.paletteLockButton,
            );
            break;
          }
        }
      }
      if (locked != null && used.add(locked.color.newCode.toUpperCase())) {
        merged.add(
          PaletteSuggestion(
            color: locked.color,
            reason: context.l10n.paletteLockButton,
            role: locked.role,
          ),
        );
      }
    }
    for (final suggestion in base) {
      if (merged.length >= wanted) break;
      if (used.add(suggestion.color.newCode.toUpperCase())) {
        merged.add(suggestion);
      }
    }
    return merged.take(wanted).toList();
  }

  void _toggleLock(PaletteSuggestion suggestion) {
    final code = suggestion.color.newCode;
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
    });
  }

  void _applyVariation(QuickPaletteVariation variation) {
    if (_suggestions.isEmpty || _available.isEmpty) return;
    final varied = remixPaletteWithVariation(
      _suggestions,
      _available,
      _lockedCodes.toSet(),
      _resolvedBase?.newCode,
      variation,
      size: _companions,
    );
    setState(() {
      _suggestions = _mergeLocked(varied);
      _aiUsed = false;
      _notice = context.l10n.paletteVariationApplied(
        context.l10n.variationName(variation),
      );
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
        _selectMode(mode);
      case ScenesChoice():
        if (_useScenario) return;
        _selectScenes();
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
        _selectScenario(scene);
      case PhotoScenePicked():
        await _pickPhotoScene();
    }
  }

  // ---------------------------------------------------------------------------
  // From a photo
  // ---------------------------------------------------------------------------

  /// Asks for a photo, finds its dominant colours on the device and shows the
  /// nearest owned markers. The photo is read into memory only: it is not
  /// stored and never leaves the phone.
  ///
  /// Every await is followed by a check of the flow's token: if the photo was
  /// dropped meanwhile (Clear, another type, a saved palette...) the late
  /// result is ignored.
  Future<void> _pickPhotoScene() async {
    if (_photoBusy) return;
    final PhotoSource? source = await showPhotoSourceSheet(context);
    if (source == null || !mounted) return;
    final int token = ++_photoToken;
    setState(() {
      _photoBusy = true;
      _photoError = null;
      _notice = null;
    });
    final PhotoPickResult result = await _picker.pick(source);
    if (!mounted || token != _photoToken) return;
    final AppLocalizations t = context.l10n;
    switch (result) {
      case PhotoPicked(:final Uint8List bytes):
        await _loadPhotoScene(bytes, token);
      case PhotoPickCancelled():
        setState(() => _photoBusy = false);
      case PhotoPickDenied(:final PhotoSource source):
        setState(() {
          _photoBusy = false;
          _photoError = source == PhotoSource.camera
              ? t.matchCameraDenied
              : t.matchGalleryDenied;
        });
      case PhotoPickFailed():
        setState(() {
          _photoBusy = false;
          _photoError = t.matchPickFailed;
        });
    }
  }

  Future<void> _loadPhotoScene(Uint8List bytes, int token) async {
    final AppLocalizations t = context.l10n;
    Map<int, List<PhotoColor>> colors;
    try {
      // The decoded pixels live only until the colours are found.
      final SampledImage sampled = await _decode(bytes);
      if (!mounted || token != _photoToken) return;
      colors = await _extract(sampled);
      if (!mounted || token != _photoToken) return;
    } on PhotoDecodeException {
      if (!mounted || token != _photoToken) return;
      setState(() {
        _photoBusy = false;
        _photoError = t.matchDecodeFailed;
      });
      return;
    } catch (_) {
      if (!mounted || token != _photoToken) return;
      setState(() {
        _photoBusy = false;
        _photoError = t.paletteFromPhotoEmpty;
      });
      return;
    }
    final PhotoScene scene = PhotoScene(bytes: bytes, colors: colors);
    // Needs a base and at least one companion, from markers the user owns.
    if (matchPhotoColorsToMarkers(
          scene.colorsFor(_companions + 1),
          _available,
        ).length <
        2) {
      scene.dispose();
      setState(() {
        _photoBusy = false;
        _photoError = t.paletteFromPhotoEmpty;
      });
      return;
    }
    setState(() {
      _photoScene?.dispose();
      _photoBusy = false;
      _photoError = null;
      _photoScene = scene;
      _useScenario = true;
      if (_mode == PaletteMode.customPalette) _mode = PaletteMode.recommended;
      _failure = null;
      _unknownInput = false;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      // A pending AI answer must not overwrite the photo palette.
      _aiVersion++;
      _aiLoading = false;
      _aiUsed = false;
      _aiError = null;
    });
    _recompute();
  }

  /// Shows the photo as a palette of the chosen size (call from [_recompute]):
  /// the colours found for that size, matched to the owned markers.
  void _applyPhotoScene(PhotoScene scene) {
    final List<PhotoMarkerPick> picks = matchPhotoColorsToMarkers(
      scene.colorsFor(_companions + 1),
      _available,
    ).take(_companions + 1).toList();
    setState(() {
      _unknownInput = false;
      _aiUsed = false;
      _aiError = null;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _photoPicks = picks;
      if (picks.length < 2) {
        // The collection changed under the photo: nothing close is left.
        _suggestions = const <PaletteSuggestion>[];
        _failure = _available.isEmpty
            ? PaletteFailureReason.noAvailableColors
            : null;
        _photoError = _available.isEmpty
            ? null
            : context.l10n.paletteFromPhotoEmpty;
        return;
      }
      _failure = null;
      _photoError = null;
      _suggestions = <PaletteSuggestion>[
        for (final PhotoMarkerPick pick in picks.skip(1))
          PaletteSuggestion(color: pick.marker, reason: PaletteReasons.photo),
      ];
    });
  }

  /// The role line of [marker] in a photo palette: "Photo colour · 32 %".
  String _photoRole(MarkerColor marker) {
    for (final PhotoMarkerPick pick in _photoPicks) {
      if (pick.marker.newCode == marker.newCode) {
        return context.l10n.paletteFromPhotoRole(
          (pick.source.share * 100).round(),
        );
      }
    }
    return context.l10n.paletteFromPhotoTitle;
  }

  /// Whether a photo colour has no usable owned marker among those shown.
  bool get _photoHasFarPick =>
      _photoMode &&
      _photoPicks.any((PhotoMarkerPick p) => !MatchQuality.isUsable(p.deltaE));

  void _selectMode(PaletteMode mode) {
    setState(() {
      _mode = mode;
      // A type is one choice among the others: a colour-theory mode leaves
      // the scenes.
      _useScenario = false;
      _dropPhoto();
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

  void _selectScenes() {
    setState(() {
      _useScenario = true;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
    });
    _recompute();
  }

  void _selectScenario(Scene scene) {
    setState(() {
      _sceneChoice = scene;
      // A scene replaces the photo palette.
      _dropPhoto();
    });
    _recompute();
  }

  /// Forgets the photo and what came from it (call inside [setState]).
  ///
  /// It also ends a photo still being read: its result is dropped when it
  /// arrives and the spinner is cleared here.
  void _dropPhoto() {
    _photoScene?.dispose();
    _photoScene = null;
    _photoPicks = const <PhotoMarkerPick>[];
    _photoError = null;
    _photoToken++;
    _photoBusy = false;
  }

  void _selectSize(int size) {
    setState(() => _paletteSize = size);
    _recompute();
  }

  void _onBaseInputChanged(String value) {
    setState(() => _baseInput = value);
    _recompute();
  }

  void _clear() {
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
    });
  }

  // ---------------------------------------------------------------------------
  // Saved palettes
  // ---------------------------------------------------------------------------

  Future<void> _save() async {
    final scope = _scope;
    final base = _stripBase;
    if (scope == null || base == null || _suggestions.isEmpty) return;
    final name = await _askName(
      _photoMode
          ? '${base.newCode} ${context.l10n.paletteFromPhotoTitle}'
          : _useScenario
          ? '${base.newCode} ${context.l10n.scenarioLabel(_scenario)}'
          : '${base.newCode} ${context.l10n.modeLabel(_mode)}',
    );
    if (name == null || name.isEmpty) return;
    final now = DateTime.now();
    await scope.savedPalettes.save(
      SavedPalette(
        id: now.microsecondsSinceEpoch.toString(),
        brandId: _brand.id,
        name: name,
        baseCode: base.newCode,
        baseName: base.newName,
        mode: _mode,
        paletteSize: (_suggestions.length + 1).clamp(3, 5),
        createdAtEpochMs: now.millisecondsSinceEpoch,
        colorCodes: <String>[
          base.newCode,
          for (final suggestion in _suggestions) suggestion.color.newCode,
        ],
        isCustom: _mode == PaletteMode.customPalette,
        scenarioName: _photoMode
            ? PhotoScene.savedName
            : _useScenario
            ? _scenario.id
            : null,
      ),
    );
    if (!mounted) return;
    setState(() => _notice = context.l10n.paletteSavedNotice(name));
  }

  Future<String?> _askName(String initial) => showDialog<String>(
    context: context,
    builder: (BuildContext context) => _SaveNameDialog(initial: initial),
  );

  void _loadSaved(SavedPalette palette) {
    final byCode = <String, MarkerColor>{
      for (final color in _catalog) color.newCode.toUpperCase(): color,
    };
    final suggestions = <PaletteSuggestion>[];
    final String baseCode = palette.baseCode.toUpperCase();
    for (final code in palette.colorCodes) {
      // The base is the first band of the strip, not a companion row. Older
      // saved palettes hold the companions only.
      if (code.toUpperCase() == baseCode) continue;
      final color = byCode[code.toUpperCase()];
      if (color != null) {
        suggestions.add(
          PaletteSuggestion(color: color, reason: PaletteReasons.loaded),
        );
      }
    }
    setState(() {
      _baseInput = palette.baseCode;
      _baseController.text = palette.baseCode;
      _mode = palette.mode;
      _paletteSize = (suggestions.length + 1).clamp(3, 5);
      _useScenario = false;
      _dropPhoto();
      _failure = null;
      _unknownInput = false;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _suggestions = suggestions;
      _aiUsed = false;
      _aiError = null;
      _notice = context.l10n.paletteLoadedNotice(palette.name);
    });
  }

  Future<void> _deleteSaved(SavedPalette palette) async {
    final scope = _scope;
    if (scope == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(context.l10n.paletteDeleteDialogTitle),
        content: Text(context.l10n.paletteDeleteDialogBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.paletteSaveDialogCancel),
          ),
          FilledButton(
            key: const ValueKey<String>('palette-delete-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.paletteDeleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await scope.savedPalettes.delete(_brand, palette.id);
  }

  // ---------------------------------------------------------------------------
  // Presentation helpers
  // ---------------------------------------------------------------------------

  /// A stored code may not resolve to a catalog color; fall back to a neutral.
  String _hexForCode(String code) {
    for (final color in _catalog) {
      if (color.newCode.toUpperCase() == code.toUpperCase()) return color.hex;
    }
    return '#CFCFCF';
  }

  String _roleFor(PaletteSuggestion suggestion) {
    // An AI item carries its own role, from the same item as its reason.
    final String? given = suggestion.role?.trim();
    if (given != null && given.isNotEmpty) return given;
    if (_photoMode) return _photoRole(suggestion.color);
    if (_useScenario) return suggestion.reason;
    return _roleFromReason(suggestion.reason);
  }

  // Canonical (English) roles: the core engines and the AI write English, so
  // the grouping below works on these ids and the text is localised only when
  // it is drawn (see roleLabel / reasonLabel in l10n/core_labels.dart).
  static const String _roleBase = 'Base';
  static const String _roleShadow = 'Shadow';
  static const String _roleHighlight = 'Highlight';
  static const String _roleNeutral = 'Neutral';
  static const String _roleAccent = 'Accent';
  static const String _roleComplement = 'Complement';
  static const String _roleCompanion = 'Companion';

  String _roleFromReason(String reason) {
    final value = reason.toLowerCase();
    if (value.contains('shadow') ||
        value.contains('depth') ||
        value.contains('darker')) {
      return _roleShadow;
    }
    if (value.contains('highlight') ||
        value.contains('lift') ||
        value.contains('lighter')) {
      return _roleHighlight;
    }
    if (value.contains('neutral')) return _roleNeutral;
    if (value.contains('contrast') ||
        value.contains('split') ||
        value.contains('complement') ||
        value.contains('triad') ||
        value.contains('square') ||
        value.contains('rectangle') ||
        value.contains('opposite')) {
      return _roleAccent;
    }
    return _roleCompanion;
  }

  int _roleGroup(String role) {
    final value = role.toLowerCase();
    if (value.contains(_roleShadow.toLowerCase()) || value.contains('depth')) {
      return 0;
    }
    if (value.contains(_roleHighlight.toLowerCase()) ||
        value.contains('light')) {
      return 1;
    }
    if (value.contains(_roleAccent.toLowerCase()) ||
        value.contains(_roleComplement.toLowerCase()) ||
        value.contains('contrast')) {
      return 2;
    }
    return 3;
  }

  List<_PlanStep> _paintPlan() {
    final steps = <_PlanStep>[];
    var order = 1;
    final base = _stripBase;
    if (base != null) {
      steps.add(
        _PlanStep(
          order: order++,
          zone: _photoMode
              ? _photoRole(base)
              : context.l10n.roleLabel(_roleBase),
          code: base.newCode,
          name: base.newName,
          tip: _photoMode ? '' : context.l10n.palettePaintTipBase,
        ),
      );
    }
    final groups = <List<PaletteSuggestion>>[
      <PaletteSuggestion>[],
      <PaletteSuggestion>[],
      <PaletteSuggestion>[],
      <PaletteSuggestion>[],
    ];
    final grouped = <List<String>>[
      <String>[],
      <String>[],
      <String>[],
      <String>[],
    ];
    final bool keepOrder = _mode == PaletteMode.customPalette || _photoMode;
    for (final suggestion in _suggestions) {
      final role = _roleFor(suggestion);
      // A custom palette (an idea, a loaded palette) is already in painting
      // order, light to dark: keep it instead of regrouping by role.
      final group = keepOrder ? 3 : _roleGroup(role);
      groups[group].add(suggestion);
      grouped[group].add(role);
    }
    for (var index = 0; index < groups.length; index++) {
      for (var i = 0; i < groups[index].length; i++) {
        final suggestion = groups[index][i];
        final role = grouped[index][i];
        // The plan row already names the marker, so a loaded palette (whose
        // reason says nothing) gets the generic tip of its group instead.
        final tip = _photoMode
            ? ''
            : suggestion.reason == role ||
                  suggestion.reason == PaletteReasons.loaded
            ? _groupTip(index)
            : context.l10n.reasonLabel(suggestion.reason);
        steps.add(
          _PlanStep(
            order: order++,
            zone: context.l10n.roleLabel(role),
            code: suggestion.color.newCode,
            name: suggestion.color.newName,
            tip: tip,
          ),
        );
      }
    }
    return steps;
  }

  String _groupTip(int group) => switch (group) {
    0 => context.l10n.palettePaintTipShadow,
    1 => context.l10n.palettePaintTipHighlight,
    2 => context.l10n.palettePaintTipAccent,
    _ => context.l10n.palettePaintTipSupport,
  };

  String? _errorMessage() {
    final failure = _failure;
    if (failure == null && !_unknownInput) return null;
    final input = _baseInput.trim().toUpperCase();
    final example = _exampleCode;
    if (_unknownInput) {
      return context.l10n.paletteUnknownCode(_brandSelector, input, example);
    }
    return switch (failure!) {
      PaletteFailureReason.noAvailableColors =>
        context.l10n.paletteNoAvailableColors(_brandSelector),
      PaletteFailureReason.missingBaseColor => context.l10n.paletteMissingBase(
        example,
      ),
      PaletteFailureReason.invalidBaseColor => context.l10n.paletteNotAvailable(
        _brandSelector,
        input,
        example,
      ),
      PaletteFailureReason.noSuggestions => context.l10n.paletteNoSuggestions,
    };
  }

  /// Selector of the brand-aware messages: `decoTime` or `other`.
  String get _brandSelector =>
      _brand == MarkerBrand.decoTime ? 'decoTime' : 'other';

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
    final String? error = _photoError ?? _errorMessage();
    final bool hasResult = _suggestions.isNotEmpty;

    return Column(
      key: PalettePage.pageKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkPageHeader(title: context.l10n.paletteTitle, subtitle: _subtitle()),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: _onUserScroll,
            child: ListView(
              padding: const EdgeInsets.only(bottom: InkSpacing.pageBottom),
              children: <Widget>[
                _buildTypeFields(),
                _buildBaseAndSize(customMode: customMode || _photoMode),
                if (_scenarioDefaultBase != null)
                  _inset(
                    _InfoCard(
                      message: context.l10n.paletteUsingDefaultBase(
                        _scenarioDefaultBase!.newCode,
                        context.l10n.scenarioLabel(_scenario),
                      ),
                    ),
                    top: InkSpacing.block,
                  ),
                if (customMode)
                  _inset(
                    _InfoCard(message: context.l10n.paletteCustomModeHint),
                    top: InkSpacing.block,
                  ),
                if (_photoHasFarPick)
                  _inset(
                    KeyedSubtree(
                      key: const ValueKey<String>('palette-photo-far-note'),
                      child: _InfoCard(
                        message: context.l10n.paletteFromPhotoFarNote,
                      ),
                    ),
                    top: InkSpacing.block,
                  ),
                if (_notice != null)
                  _inset(_buildNotice(), top: InkSpacing.block),
                if (error != null)
                  _inset(_ErrorNote(message: error), top: InkSpacing.block),
                if (hasResult) ..._buildResult(),
                if (!hasResult && error == null && !customMode)
                  _inset(
                    _InfoCard(message: context.l10n.paletteEmptyHint),
                    top: InkSpacing.block,
                  ),
                _buildActions(customMode: customMode, photoMode: _photoMode),
                _buildSavedPalettes(scope),
              ],
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

  /// Horizontal gutter plus [top] spacing around [child].
  Widget _inset(Widget child, {double top = 0}) => Padding(
    padding: EdgeInsets.fromLTRB(
      InkSpacing.pageMargin,
      top,
      InkSpacing.pageMargin,
      0,
    ),
    child: child,
  );

  String _subtitle() {
    if (_useScenario) {
      return context.l10n.commonMarkersAvailable(_available.length);
    }
    if (_mode == PaletteMode.customPalette) {
      return context.l10n.paletteSubtitleCustom(_suggestions.length);
    }
    final MarkerColor? base = _resolvedBase;
    if (base != null) {
      return context.l10n.commonMarkersAvailable(_available.length);
    }
    return context.l10n.paletteSubtitleIdle;
  }

  Widget _caps(String text) {
    final InkColors ink = InkColors.of(context);
    return Text(
      AppTypography.caps(text),
      style: AppTypography.capsStyle.copyWith(color: ink.fg2),
    );
  }

  /// The palette type field and, once Scenes is the type, the scene field.
  Widget _buildTypeFields() {
    final AppLocalizations t = context.l10n;
    final InkColors ink = InkColors.of(context);
    final String typeName = _useScenario
        ? t.paletteScenarioToggle
        : t.modeLabel(_mode);
    final Widget type = PaletteChoiceField(
      label: t.paletteTypeTitle,
      semanticLabel: t.paletteTypeSemantic(typeName),
      fieldKey: const ValueKey<String>('palette-type-field'),
      onTap: _pickType,
      leading: _useScenario
          ? const ScenesGlyph()
          : PaletteModeGlyph(mode: _mode),
      child: Text(
        typeName,
        key: const ValueKey<String>('palette-type-value'),
        style: AppTypography.button.copyWith(color: ink.fg),
      ),
    );
    if (!_useScenario) return _inset(type, top: InkSpacing.block);
    final PhotoScene? photo = _photoScene;
    final Scene scene = _scenario;
    final String sceneName = photo != null
        ? t.paletteFromPhotoValue
        : t.scenarioLabel(scene);
    final Widget sceneValue = _photoBusy
        ? Row(
            children: <Widget>[
              SizedBox.square(
                dimension: InkGeometry.smallIcon,
                child: CircularProgressIndicator(
                  key: const ValueKey<String>('palette-photo-busy'),
                  strokeWidth: 2,
                  color: ink.action,
                ),
              ),
              const SizedBox(width: InkSpacing.s8),
              Expanded(
                child: Text(
                  t.matchLoadingPhoto,
                  key: const ValueKey<String>('palette-scene-value'),
                  style: AppTypography.button.copyWith(color: ink.fg2),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                sceneName,
                key: const ValueKey<String>('palette-scene-value'),
                style: AppTypography.button.copyWith(color: ink.fg),
              ),
              const SizedBox(height: InkSpacing.s8),
              SceneStrip(
                key: photo == null
                    ? null
                    : const ValueKey<String>('palette-photo-strip'),
                hexes: photo == null
                    ? _previews.of(scene)
                    : <String>[
                        for (final PhotoMarkerPick pick in _photoPicks)
                          colorIntToHex(pick.source.colorInt),
                      ],
                height: 16,
              ),
            ],
          );
    return _inset(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          type,
          const SizedBox(height: InkSpacing.block),
          PaletteChoiceField(
            label: t.paletteSceneTitle,
            semanticLabel: _photoBusy
                ? t.matchLoadingPhoto
                : t.paletteSceneSemantic(sceneName),
            fieldKey: const ValueKey<String>('palette-scene-field'),
            onTap: _photoBusy ? null : _pickScene,
            leading: photo == null || _photoBusy
                ? null
                : PhotoThumb(
                    key: const ValueKey<String>('palette-photo-thumb'),
                    image: photo.thumbnail,
                  ),
            child: sceneValue,
          ),
        ],
      ),
      top: InkSpacing.block,
    );
  }

  Widget _buildBaseAndSize({required bool customMode}) {
    final Widget size = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _caps(context.l10n.paletteSizeTitle),
        const SizedBox(height: InkSpacing.group),
        InkSegmented<int>(
          semanticLabel: context.l10n.paletteSizeSemantic,
          numeric: true,
          segments: <InkSegment<int>>[
            for (final value in const <int>[3, 4, 5])
              InkSegment<int>(
                value: value,
                label: '$value',
                semantic: context.l10n.paletteSizeChip(value),
              ),
          ],
          selected: _paletteSize,
          onChanged: _selectSize,
        ),
      ],
    );
    return _inset(
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (customMode) return size;
          // The base field takes the full width so the code and the whole
          // marker name stay readable; the size control sits below it and
          // only goes beside it on wide screens.
          final double scale = MediaQuery.textScalerOf(context).scale(1);
          if (constraints.maxWidth < 440 + 120 * scale) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBaseInput(),
                const SizedBox(height: InkSpacing.block),
                size,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(child: _buildBaseInput()),
              const SizedBox(width: InkSpacing.buttonGap),
              size,
            ],
          );
        },
      ),
      top: InkSpacing.block,
    );
  }

  Widget _buildBaseInput() {
    return RawAutocomplete<MarkerColor>(
      textEditingController: _baseController,
      focusNode: _baseFocus,
      displayStringForOption: (MarkerColor option) => option.newCode,
      optionsBuilder: (TextEditingValue value) {
        final query = value.text.trim().toUpperCase();
        if (query.isEmpty) return const Iterable<MarkerColor>.empty();
        final List<MarkerColor> matches = _catalog
            .where(
              (color) =>
                  color.newCode.toUpperCase().contains(query) ||
                  color.oldCode.toUpperCase().contains(query),
            )
            .take(8)
            .toList();
        // A complete code that already produced its result has nothing left
        // to suggest: the list would only hover over the strip.
        if (matches.length == 1 &&
            (matches.first.newCode.toUpperCase() == query ||
                matches.first.oldCode.toUpperCase() == query)) {
          return const Iterable<MarkerColor>.empty();
        }
        return matches;
      },
      onSelected: (MarkerColor option) {
        _onBaseInputChanged(option.newCode);
        // Close the suggestions: losing focus hides the overlay.
        _baseFocus.unfocus();
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) => _buildBaseField(controller, focusNode, onFieldSubmitted),
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<MarkerColor> onSelected,
        Iterable<MarkerColor> options,
      ) => _buildOptions(context, onSelected, options),
    );
  }

  /// The base-marker field: caps label, then a 48-high rounded box with the
  /// marker colour chip, the code input and the marker name.
  Widget _buildBaseField(
    TextEditingController controller,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? base = _resolvedBase;
    const InputBorder none = InputBorder.none;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _caps(context.l10n.paletteBaseMarkerTitle),
        const SizedBox(height: InkSpacing.group),
        ListenableBuilder(
          listenable: focusNode,
          builder: (BuildContext context, Widget? child) => Container(
            constraints: const BoxConstraints(
              minHeight: InkGeometry.fieldHeight,
            ),
            padding: const EdgeInsets.only(
              left: InkSpacing.s12,
              right: InkSpacing.s2,
              top: InkSpacing.s4,
              bottom: InkSpacing.s4,
            ),
            decoration: BoxDecoration(
              color: ink.surface,
              borderRadius: InkRadii.inputRadius,
              border: Border.all(
                color: focusNode.hasFocus ? ink.action : ink.strong,
              ),
            ),
            child: child,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: base == null ? null : swatchColor(base.hex),
                  borderRadius: InkRadii.smRadius,
                  border: Border.all(
                    color: base == null
                        ? ink.line
                        : ink.swatchEdge(swatchColor(base.hex)),
                  ),
                ),
              ),
              const SizedBox(width: InkSpacing.s10),
              Expanded(
                // The code on top and, once a marker is resolved, its whole
                // name on a second line: nothing is cut to fit one row.
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Semantics(
                      label: context.l10n.paletteBaseCodeLabel,
                      child: TextField(
                        key: const ValueKey<String>('palette-base-input'),
                        controller: controller,
                        focusNode: focusNode,
                        textCapitalization: TextCapitalization.characters,
                        onChanged: _onBaseInputChanged,
                        onSubmitted: (_) => onFieldSubmitted(),
                        onTapOutside: (_) => focusNode.unfocus(),
                        style: AppTypography.code.copyWith(color: ink.fg),
                        cursorColor: ink.action,
                        decoration: InputDecoration(
                          hintText: context.l10n.paletteBaseCodeHint,
                          hintStyle: AppTypography.secondary.copyWith(
                            color: ink.fg2,
                          ),
                          filled: false,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: none,
                          enabledBorder: none,
                          focusedBorder: none,
                          disabledBorder: none,
                          errorBorder: none,
                          focusedErrorBorder: none,
                        ),
                      ),
                    ),
                    if (base != null)
                      Tooltip(
                        message: base.newName,
                        excludeFromSemantics: true,
                        child: Text(
                          base.newName,
                          key: const ValueKey<String>('palette-base-name'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(color: ink.fg2),
                        ),
                      ),
                  ],
                ),
              ),
              InkIconButton(
                key: const ValueKey<String>('palette-pick-base'),
                icon: InkIcons.search,
                iconSize: InkGeometry.smallIcon + 2,
                tooltip: context.l10n.palettePickBaseTooltip,
                onPressed: _pickBase,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(
    BuildContext context,
    AutocompleteOnSelected<MarkerColor> onSelected,
    Iterable<MarkerColor> options,
  ) {
    final InkColors ink = InkColors.of(context);
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: InkSpacing.group),
        child: Material(
          key: const ValueKey<String>('palette-base-options'),
          color: ink.surface,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: InkRadii.inputRadius,
            side: BorderSide(color: ink.line),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 280,
              maxWidth: math.min(
                MediaQuery.sizeOf(context).width - 2 * InkSpacing.pageMargin,
                420,
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final MarkerColor option = options.elementAt(index);
                final bool hasOld =
                    option.oldCode.toUpperCase() !=
                    option.newCode.toUpperCase();
                return InkWell(
                  onTap: () => onSelected(option),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: InkGeometry.target,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: InkSpacing.cardH,
                        vertical: InkSpacing.s6,
                      ),
                      child: Row(
                        children: <Widget>[
                          SwatchBlock(
                            hex: option.hex,
                            size: 24,
                            radius: InkRadii.xs,
                          ),
                          const SizedBox(width: InkSpacing.s10),
                          Expanded(
                            // Code (and former code) on the first line, the
                            // whole name below it.
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[
                                    Text(
                                      option.newCode,
                                      style: AppTypography.code.copyWith(
                                        color: ink.fg,
                                      ),
                                    ),
                                    if (hasOld) ...<Widget>[
                                      const SizedBox(width: InkSpacing.s8),
                                      Text(
                                        option.oldCode,
                                        style: AppTypography.data.copyWith(
                                          color: ink.fg2,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  option.newName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.secondary.copyWith(
                                    color: ink.fg2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotice() {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          InkSpacing.s8,
          InkSpacing.s8,
          InkSpacing.s8,
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
              label: context.l10n.paletteOkButton,
              onPressed: () => setState(() => _notice = null),
            ),
          ],
        ),
      ),
    );
  }

  /// The strip with its codes, role/reason card, variations and paint order.
  List<Widget> _buildResult() {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? base = _stripBase;
    // The base is the first band of the strip; companions follow it.
    final int offset = base == null ? 0 : 1;
    final bool photo = _photoMode;
    final Set<int> locked = photo
        ? const <int>{}
        : <int>{
            if (base != null) 0,
            for (var index = 0; index < _suggestions.length; index++)
              if (_isLocked(_suggestions[index])) index + offset,
          };
    return <Widget>[
      _inset(
        Row(
          children: <Widget>[
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  context.l10n.paletteResultTitle(_suggestions.length + offset),
                  style: AppTypography.section.copyWith(color: ink.fg),
                ),
              ),
            ),
            if (_aiUsed)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: InkSpacing.s8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ink.pale,
                      borderRadius: BorderRadius.circular(InkRadii.xs),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: InkSpacing.s8,
                        vertical: InkSpacing.s2,
                      ),
                      child: Tooltip(
                        message: context.l10n.aiResultLabel(
                          _aiModel,
                          aiCount: _aiCount,
                          total: _aiTotal,
                        ),
                        excludeFromSemantics: true,
                        child: Text(
                          context.l10n.aiResultLabel(
                            _aiModel,
                            aiCount: _aiCount,
                            total: _aiTotal,
                          ),
                          key: const ValueKey<String>('palette-ai-badge'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.secondary.copyWith(
                            color: ink.action,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        top: InkSpacing.section,
      ),
      _inset(
        PaletteStrip(
          colors: <String>[
            if (base != null) base.hex,
            for (final suggestion in _suggestions) suggestion.color.hex,
          ],
          labels: <String>[
            if (base != null) base.newCode,
            for (final suggestion in _suggestions) suggestion.color.newCode,
          ],
          lockedIndices: locked,
        ),
        top: InkSpacing.headingGap,
      ),
      _inset(
        Card(
          child: Column(
            children: <Widget>[
              for (var index = 0; index < _suggestions.length; index++)
                _SuggestionRow(
                  key: ValueKey<String>(
                    'palette-row-${_suggestions[index].color.newCode}',
                  ),
                  suggestion: _suggestions[index],
                  role: _roleFor(_suggestions[index]),
                  locked: _isLocked(_suggestions[index]),
                  last: index == _suggestions.length - 1,
                  onToggleLock: photo
                      ? null
                      : () => _toggleLock(_suggestions[index]),
                ),
            ],
          ),
        ),
        top: InkSpacing.block,
      ),
      if (!photo)
        Padding(
          padding: const EdgeInsets.only(top: InkSpacing.block),
          child: InkChipRow(
            semanticLabel: context.l10n.paletteVariationsLabel,
            children: <Widget>[
              for (final variation in QuickPaletteVariation.values)
                InkChip(
                  label: context.l10n.variationName(variation),
                  selected: false,
                  onSelected: (_) => _applyVariation(variation),
                ),
            ],
          ),
        ),
      ..._buildPaintOrder(),
    ];
  }

  bool _isLocked(PaletteSuggestion suggestion) => _lockedCodes.any(
    (code) => code.toUpperCase() == suggestion.color.newCode.toUpperCase(),
  );

  List<Widget> _buildPaintOrder() {
    final steps = _paintPlan();
    if (steps.isEmpty) return const <Widget>[];
    final InkColors ink = InkColors.of(context);
    return <Widget>[
      _inset(
        Semantics(
          header: true,
          child: Text(
            context.l10n.palettePaintPlanTitle,
            style: AppTypography.section.copyWith(color: ink.fg),
          ),
        ),
        top: InkSpacing.section,
      ),
      _inset(
        Column(
          children: <Widget>[
            for (var index = 0; index < steps.length; index++) ...<Widget>[
              if (index > 0) const SizedBox(height: InkSpacing.s8),
              _PaintStepRow(
                step: steps[index],
                hex: _hexForCode(steps[index].code),
              ),
            ],
          ],
        ),
        top: InkSpacing.headingGap,
      ),
    ];
  }

  Widget _buildActions({required bool customMode, required bool photoMode}) {
    final bool showAi = _aiAvailable && !customMode && !photoMode;
    final bool hasResult = _suggestions.isNotEmpty;
    final InkColors ink = InkColors.of(context);
    final Widget clear = InkButton.text(
      key: const ValueKey<String>('palette-clear'),
      label: context.l10n.paletteClearButton,
      onPressed: _clear,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // A photo palette has no Generate or Regenerate: Clear follows Save
        // on the one row, flush with the content like the other buttons.
        if (!photoMode)
          _inset(
            Wrap(
              spacing: InkSpacing.buttonGap,
              runSpacing: InkSpacing.s8,
              children: <Widget>[
                // A photo palette has nothing to regenerate: same photo, same
                // markers.
                if (!photoMode)
                  InkButton(
                    key: const ValueKey<String>('palette-generate'),
                    variant: InkButtonVariant.smallSecondary,
                    label: context.l10n.paletteGenerateButton,
                    icon: InkIcons.shuffle,
                    onPressed:
                        customMode ||
                            (_baseInput.trim().isEmpty && !_useScenario)
                        ? null
                        : _recompute,
                  ),
                if (_useScenario && !photoMode)
                  InkButton(
                    key: const ValueKey<String>('palette-regenerate'),
                    variant: InkButtonVariant.smallSecondary,
                    label: context.l10n.paletteRegenerateButton,
                    icon: InkIcons.rotateCcw,
                    onPressed: () {
                      setState(() => _variationToken++);
                      _recompute();
                    },
                  ),
                clear,
              ],
            ),
            top: InkSpacing.block,
          ),
        if (showAi || hasResult || photoMode)
          _inset(
            Wrap(
              spacing: InkSpacing.buttonGap,
              runSpacing: InkSpacing.s8,
              children: <Widget>[
                if (showAi)
                  InkButton.secondary(
                    key: const ValueKey<String>('palette-suggest-ai'),
                    label: _aiLoading
                        ? context.l10n.paletteSuggestAiLoading
                        : context.l10n.paletteSuggestAiButton,
                    loading: _aiLoading,
                    onPressed: _suggestWithAi,
                  ),
                if (hasResult)
                  InkButton(
                    key: const ValueKey<String>('palette-save'),
                    label: context.l10n.paletteSaveButton,
                    onPressed: _save,
                  ),
                if (photoMode) clear,
              ],
            ),
            top: InkSpacing.s8,
          ),
        if (_aiError != null)
          _inset(
            KeyedSubtree(
              key: const ValueKey<String>('palette-ai-error'),
              child: _ErrorNote(message: context.l10n.aiNote(_aiError!)),
            ),
            top: InkSpacing.buttonGap,
          ),
        if (!_aiAvailable && !photoMode)
          _inset(
            Text(
              context.l10n.paletteAiOptionalNote,
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
            top: InkSpacing.buttonGap,
          ),
      ],
    );
  }

  Widget _buildSavedPalettes(AppScope scope) {
    return StreamBuilder<List<SavedPalette>>(
      key: ValueKey<String>('palette-saved-${_brand.id}'),
      stream: _savedStreams.putIfAbsent(
        _brand,
        () => scope.savedPalettes.watch(_brand),
      ),
      initialData: scope.savedPalettes.palettesOf(_brand),
      builder:
          (BuildContext context, AsyncSnapshot<List<SavedPalette>> snapshot) {
            final InkColors ink = InkColors.of(context);
            final palettes = snapshot.data ?? const <SavedPalette>[];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _inset(
                  Semantics(
                    header: true,
                    child: Text(
                      context.l10n.paletteSavedTitle,
                      style: AppTypography.section.copyWith(color: ink.fg),
                    ),
                  ),
                  top: InkSpacing.section,
                ),
                if (palettes.isEmpty)
                  _inset(
                    Text(
                      context.l10n.paletteSavedEmpty,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                    top: InkSpacing.headingGap,
                  )
                else
                  for (var i = 0; i < palettes.length; i++)
                    _inset(
                      _SavedPaletteRow(
                        palette: palettes[i],
                        hexes: <String>[
                          for (final code in palettes[i].colorCodes)
                            _hexForCode(code),
                        ],
                        onLoad: () => _loadSaved(palettes[i]),
                        onDelete: () => _deleteSaved(palettes[i]),
                      ),
                      top: i == 0 ? InkSpacing.headingGap : InkSpacing.block,
                    ),
              ],
            );
          },
    );
  }
}

/// A single plan step: order, zone, color and tip.
final class _PlanStep {
  const _PlanStep({
    required this.order,
    required this.zone,
    required this.code,
    required this.name,
    required this.tip,
  });

  final int order;
  final String zone, code, name, tip;
}

/// Smallest factor a single line of text is scaled down to. Below it the
/// text wraps to [_wrapLines] lines with an ellipsis instead of shrinking
/// further (only reachable at large accessibility text scales).
const double _minLineScale = 0.8;
const int _wrapLines = 2;

/// A single line of text that is scaled down, never cut, when it is wider
/// than the space it has. It shrinks to [_minLineScale] at most; beyond that
/// it wraps to two lines and ends with an ellipsis.
class _OneLine extends StatelessWidget {
  const _OneLine({super.key, required this.text, required this.style});

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

/// One row of the paint order: number, then the step (zone) with the marker
/// name under it, and a dot swatch with the code at the right.
class _PaintStepRow extends StatelessWidget {
  const _PaintStepRow({required this.step, required this.hex});

  final _PlanStep step;
  final String hex;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color colour = swatchColor(hex);
    return Semantics(
      container: true,
      label:
          '${step.order}. ${step.zone}, ${step.code} ${step.name}.'
          '${step.tip.isEmpty ? '' : ' ${step.tip}'}',
      child: ExcludeSemantics(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 22),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 12,
                child: Text(
                  '${step.order}',
                  style: AppTypography.data.copyWith(color: ink.fg2),
                ),
              ),
              const SizedBox(width: InkSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _OneLine(
                      key: ValueKey<String>('palette-step-zone-${step.order}'),
                      text: step.zone,
                      style: AppTypography.secondary.copyWith(color: ink.fg),
                    ),
                    _OneLine(
                      key: ValueKey<String>('palette-step-name-${step.order}'),
                      text: step.name,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: InkSpacing.s12),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: colour,
                  shape: BoxShape.circle,
                  border: Border.all(color: ink.swatchEdge(colour)),
                ),
              ),
              const SizedBox(width: InkSpacing.s6),
              Text(
                step.code,
                style: AppTypography.code.copyWith(color: ink.fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One suggestion of the result: role, reason and the lock control.
class _SuggestionRow extends StatefulWidget {
  const _SuggestionRow({
    super.key,
    required this.suggestion,
    required this.role,
    required this.locked,
    required this.last,
    required this.onToggleLock,
  });

  final PaletteSuggestion suggestion;
  final String role;
  final bool locked;
  final bool last;

  /// Locks or unlocks the colour; `null` hides the lock (photo palettes).
  final VoidCallback? onToggleLock;

  @override
  State<_SuggestionRow> createState() => _SuggestionRowState();
}

/// A role in caps on a single line: when the whole text is wider than the
/// space it has, the type is scaled down just enough to fit, instead of
/// wrapping or being cut with an ellipsis.
@visibleForTesting
class RoleLabel extends StatelessWidget {
  const RoleLabel({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final String caps = AppTypography.caps(text);
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = constraints.maxWidth;
        final TextPainter painter = TextPainter(
          text: TextSpan(text: caps, style: style),
          textDirection: direction,
          textScaler: scaler,
          maxLines: 1,
        )..layout();
        final double width = painter.width;
        painter.dispose();
        if (width <= available) {
          return Text(caps, maxLines: 1, softWrap: false, style: style);
        }
        // A hair of margin so rounding never pushes the text past the edge.
        final double scale = available / width * 0.97;
        if (scale < _minLineScale) {
          // Too long to shrink any further: wrap, like _OneLine.
          return Text(
            caps,
            maxLines: _wrapLines,
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(
              fontSize: (style.fontSize ?? 12) * _minLineScale,
              letterSpacing: (style.letterSpacing ?? 0) * _minLineScale,
            ),
          );
        }
        return Text(
          caps,
          maxLines: 1,
          softWrap: false,
          style: style.copyWith(
            fontSize: (style.fontSize ?? 12) * scale,
            letterSpacing: (style.letterSpacing ?? 0) * scale,
          ),
        );
      },
    );
  }
}

class _SuggestionRowState extends State<_SuggestionRow> {
  /// Lines shown before a reason needs a tap to expand.
  static const int _collapsedLines = 3;

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final PaletteSuggestion suggestion = widget.suggestion;
    final String role = widget.role;
    final MarkerColor color = suggestion.color;
    // In scenario mode the role is the reason itself, and a loaded palette's
    // reason says nothing: show the marker name instead.
    final bool nameOnly =
        suggestion.reason == role ||
        suggestion.reason == PaletteReasons.loaded ||
        suggestion.reason == PaletteReasons.photo;
    final String why = nameOnly
        ? color.newName
        : context.l10n.reasonLabel(suggestion.reason);
    final String roleText = context.l10n.roleLabel(role);
    // The name alone is one line; a reason is a sentence that clamps and
    // expands on tap.
    return Semantics(
      container: true,
      label: '${color.newCode}, ${color.newName}, $roleText',
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.only(left: InkSpacing.cardH),
        decoration: BoxDecoration(
          border: widget.last
              ? null
              : Border(bottom: BorderSide(color: ink.line)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RoleLabel(
                      key: ValueKey<String>(
                        'palette-row-role-${color.newCode}',
                      ),
                      text: roleText,
                      style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                    ),
                    const SizedBox(height: InkSpacing.s4),
                    // The name alone has nothing to expand: only a reason does.
                    if (nameOnly)
                      _OneLine(
                        key: ValueKey<String>(
                          'palette-row-why-${color.newCode}',
                        ),
                        text: why,
                        style: AppTypography.secondary.copyWith(color: ink.fg),
                      )
                    else
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => _expanded = !_expanded),
                        child: Text(
                          why,
                          key: ValueKey<String>(
                            'palette-row-why-${color.newCode}',
                          ),
                          maxLines: _expanded ? null : _collapsedLines,
                          overflow: _expanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.onToggleLock != null)
              InkIconButton(
                icon: widget.locked ? InkIcons.lock : InkIcons.unlock,
                iconSize: InkGeometry.smallIcon,
                color: widget.locked ? ink.action : ink.fg2,
                tooltip: widget.locked
                    ? context.l10n.paletteUnlockButton
                    : context.l10n.paletteLockButton,
                onPressed: widget.onToggleLock,
              )
            else
              const SizedBox(width: InkSpacing.cardH),
          ],
        ),
      ),
    );
  }
}

/// One saved palette, with a load and a delete action.
class _SavedPaletteRow extends StatelessWidget {
  const _SavedPaletteRow({
    required this.palette,
    required this.hexes,
    required this.onLoad,
    required this.onDelete,
  });

  final SavedPalette palette;
  final List<String> hexes;
  final VoidCallback onLoad;
  final VoidCallback onDelete;

  /// What kind of palette this is: the scene it came from, or the colour
  /// theory mode. A scene that cannot be resolved reads as "Scenes".
  String _kindLabel(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          InkSpacing.cardV,
          InkSpacing.cardH,
          InkSpacing.s8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              palette.name,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: ink.fg),
            ),
            const SizedBox(height: InkSpacing.s4),
            _OneLine(
              key: ValueKey<String>('palette-saved-subtitle-${palette.id}'),
              text: context.l10n.paletteSavedSubtitle(
                _kindLabel(context),
                palette.paletteSize,
              ),
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
            const SizedBox(height: InkSpacing.s8),
            PaletteStrip(
              colors: hexes,
              labels: palette.colorCodes,
              colorHeight: 32,
              labelStyle: AppTypography.data,
            ),
            const SizedBox(height: InkSpacing.buttonGap),
            Row(
              children: <Widget>[
                InkButton(
                  key: ValueKey<String>('palette-load-${palette.id}'),
                  variant: InkButtonVariant.smallSecondary,
                  label: context.l10n.paletteLoadButton,
                  icon: InkIcons.upload,
                  onPressed: onLoad,
                ),
                const SizedBox(width: InkSpacing.s8),
                InkButton.text(
                  key: ValueKey<String>('palette-delete-${palette.id}'),
                  label: context.l10n.paletteDeleteButton,
                  icon: InkIcons.trash2,
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Asks for a palette name.
///
/// The dialog owns its [TextEditingController] so it is disposed with the
/// widget, not while the route is still animating out.
class _SaveNameDialog extends StatefulWidget {
  const _SaveNameDialog({required this.initial});

  final String initial;

  @override
  State<_SaveNameDialog> createState() => _SaveNameDialogState();
}

class _SaveNameDialogState extends State<_SaveNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.paletteSaveDialogTitle),
      content: TextField(
        key: const ValueKey<String>('palette-name-field'),
        controller: _controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: context.l10n.paletteSaveDialogHint,
        ),
        onSubmitted: (value) => Navigator.of(context).pop(value.trim()),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.paletteSaveDialogCancel),
        ),
        FilledButton(
          key: const ValueKey<String>('palette-save-confirm'),
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: Text(context.l10n.paletteSaveDialogConfirm),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: Text(
          message,
          style: AppTypography.secondary.copyWith(color: ink.fg2),
        ),
      ),
    );
  }
}

/// An error: same card as [_InfoCard], with an `error` icon (no red fill).
class _ErrorNote extends StatelessWidget {
  const _ErrorNote({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: InkIcon(
                InkIcons.alertCircle,
                size: InkGeometry.mediumIcon,
                color: ink.error,
              ),
            ),
            const SizedBox(width: InkSpacing.buttonGap),
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

/// The palette on screen, kept to undo a base handed over from Swatches.
final class _PaletteSnapshot {
  _PaletteSnapshot.of(_PalettePageState s)
    : mode = s._mode,
      useScenario = s._useScenario,
      scenario = s._scenario,
      baseInput = s._baseInput,
      paletteSize = s._paletteSize,
      suggestions = s._suggestions,
      lockedCodes = s._lockedCodes,
      lockedSuggestions = Map<String, PaletteSuggestion>.of(
        s._lockedSuggestions,
      ),
      aiUsed = s._aiUsed;

  final PaletteMode mode;
  final bool useScenario;
  final Scene scenario;
  final String baseInput;
  final int paletteSize;
  final List<PaletteSuggestion> suggestions;
  final List<String> lockedCodes;
  final Map<String, PaletteSuggestion> lockedSuggestions;
  final bool aiUsed;

  /// Puts the palette back (call inside setState).
  void restore(_PalettePageState s) {
    s._mode = mode;
    s._useScenario = useScenario;
    s._sceneChoice = scenario;
    s._baseInput = baseInput;
    s._baseController.text = baseInput;
    s._paletteSize = paletteSize;
    s._suggestions = suggestions;
    s._lockedCodes = lockedCodes;
    s._lockedSuggestions
      ..clear()
      ..addAll(lockedSuggestions);
    s._aiUsed = aiUsed;
    // Whatever photo came since goes, with a photo still being read.
    s._dropPhoto();
    s._failure = null;
    s._unknownInput = false;
    s._notice = null;
  }
}

/// A searchable list of markers to pick the base from: code, old code or
/// name, with the colour.
class _BasePickerSheet extends StatefulWidget {
  const _BasePickerSheet({required this.markers});

  final List<MarkerColor> markers;

  @override
  State<_BasePickerSheet> createState() => _BasePickerSheetState();
}

class _BasePickerSheetState extends State<_BasePickerSheet> {
  String _query = '';

  List<MarkerColor> get _filtered {
    final String q = _query.trim().toLowerCase();
    if (q.isEmpty) return widget.markers;
    return widget.markers
        .where(
          (MarkerColor c) =>
              c.newCode.toLowerCase().contains(q) ||
              c.oldCode.toLowerCase().contains(q) ||
              c.newName.toLowerCase().contains(q) ||
              c.oldName.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<MarkerColor> markers = _filtered;
    final double height = MediaQuery.sizeOf(context).height * 0.55;
    return Column(
      key: const ValueKey<String>('palette-base-picker'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkGeometry.target),
          child: Semantics(
            header: true,
            child: Text(
              context.l10n.palettePickerTitle,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        InkSearchField(
          key: const ValueKey<String>('palette-picker-search'),
          hintText: context.l10n.palettePickerSearchHint,
          semanticLabel: context.l10n.palettePickerSearchHint,
          onChanged: (String value) => setState(() => _query = value),
        ),
        const SizedBox(height: InkSpacing.s8),
        SizedBox(
          height: height,
          child: markers.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: InkSpacing.block),
                  child: Text(
                    context.l10n.palettePickerEmpty,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                )
              : ListView.builder(
                  itemCount: markers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final MarkerColor marker = markers[index];
                    return InkWell(
                      key: ValueKey<String>('palette-picker-${marker.newCode}'),
                      onTap: () => Navigator.of(context).pop(marker),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: InkGeometry.target + 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: InkSpacing.s6,
                          ),
                          child: Row(
                            children: <Widget>[
                              SwatchBlock(hex: marker.hex, size: 32),
                              const SizedBox(width: InkSpacing.s12),
                              Text(
                                marker.newCode,
                                style: AppTypography.code.copyWith(
                                  color: ink.fg,
                                ),
                              ),
                              const SizedBox(width: InkSpacing.s10),
                              Expanded(
                                child: Text(
                                  marker.newName,
                                  style: AppTypography.secondary.copyWith(
                                    color: ink.fg2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
