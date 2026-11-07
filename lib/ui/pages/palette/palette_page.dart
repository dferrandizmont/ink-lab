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
import '../../widgets/ink_adaptive.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import '../../widgets/palette_strip.dart';
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
  StreamSubscription<Map<String, String>>? _ownColorsSubscription;
  StreamSubscription<Set<String>>? _driedSubscription;
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

  /// The provider that produced the current AI result, for its report.
  AiProvider? _aiProvider;

  /// How many colours of the AI result on screen came from the model, and how
  /// many there are in all (the rest were completed by colour theory).
  int _aiCount = 0;
  int _aiTotal = 0;

  /// Typed message of the last failed AI call, shown next to the button.
  String? _aiError;

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

  /// Blending Chain: the chains found for the base, the one on screen, which
  /// of the chains it is, and whether the whole range of the brand may be
  /// used instead of the user's markers.
  BlendingChainResult? _chainResult;
  BlendingChain? _chain;
  int _chainIndex = 0;
  bool _chainWholeRange = false;

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
  String? _notice;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onDraftChanged();
      _onBaseDraftChanged();
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
    _settingsSubscription?.cancel();
    _ownColorsSubscription?.cancel();
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
    return '${state.brand.id}|${sets.join(',')}|${owned.join(',')}|'
        '${_scope?.markers.colorRevision}|${_scope?.dried.revision}';
  }

  void _onSettingsChanged(AppSettingsState state) {
    final signature = _signatureOf(state);
    if (signature == _collectionSignature) return;
    _collectionSignature = signature;
    unawaited(_reload());
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
      driedColorIds: scope.dried.ids,
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
    // The type asked for together with the marker (Swatches > Blending chain).
    final PaletteMode? asked = paletteBaseMode.value;
    paletteBaseMode.value = null;
    final bool sameBase =
        _baseInput.trim().toUpperCase() == color.newCode.toUpperCase() &&
        _mode != PaletteMode.customPalette &&
        (asked == null || asked == _mode) &&
        !_useScenario;
    // A palette made from a photo cannot be brought back (the photo is not
    // kept), so replacing one offers no undo.
    final _PaletteSnapshot? previous =
        _suggestions.isEmpty || sameBase || _photoMode
        ? null
        : _PaletteSnapshot.of(this);
    setState(() {
      if (asked != null) {
        _mode = asked;
      } else if (_mode == PaletteMode.customPalette) {
        _mode = PaletteMode.recommended;
      }
      _useScenario = false;
      _dropPhoto();
      _dropChain();
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
      builder: (BuildContext context) =>
          PaletteBasePickerSheet(markers: markers),
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

  /// The hint of the empty base field: two real codes of the markers the user
  /// owns in this brand (the first two of the collection, in catalogue order,
  /// so it never changes between rebuilds), or of the brand's range when none
  /// is owned. One code if that is all there is; the field's label if the
  /// catalogue has not loaded.
  String get _baseHint {
    final List<MarkerColor> source = _available.isNotEmpty
        ? _available
        : _catalog;
    final List<String> codes = <String>[
      for (final MarkerColor c in source.take(2)) c.newCode,
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
    final List<MarkerColor> pool = _chainWholeRange ? _catalog : _available;
    final MarkerColor? inPool = pool
        .where((MarkerColor c) => c.colorId == base.colorId)
        .firstOrNull;
    setState(() {
      _unknownInput = false;
      _aiUsed = false;
      _aiError = null;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      if (inPool == null) {
        // Same rule as every other type: the base must be one of the markers.
        _failure = pool.isEmpty
            ? PaletteFailureReason.noAvailableColors
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

  void _selectChain(int index) {
    final BlendingChainResult? result = _chainResult;
    if (result == null || index < 0 || index >= result.chains.length) return;
    setState(() {
      _chainIndex = index;
      _showChain(result.chains[index]);
    });
  }

  void _setChainWholeRange(bool value) {
    setState(() => _chainWholeRange = value);
    _recompute();
  }

  /// Forgets the chains (call inside [setState]).
  void _dropChain() {
    _chainResult = null;
    _chain = null;
    _chainIndex = 0;
    _chainWholeRange = false;
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
    if (_suggestions.isEmpty || _available.isEmpty || _chainMode) return;
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
  // Type, scene and size
  // ---------------------------------------------------------------------------

  void _selectMode(PaletteMode mode) {
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
      _dropChain();
    });
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
    return PaletteRoles.fromReason(suggestion.reason);
  }

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

  /// Selector of the brand-aware messages, with ICU's `other` fallback.
  String get _brandSelector => _brand.name;

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
        catalog: _catalog,
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
              _scenarioDefaultBase!.newCode,
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
            message: _notice!,
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
      if (!hasResult &&
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
      canRegenerate: _canRegenerate,
      canGenerate: _baseInput.trim().isNotEmpty || _useScenario,
      onSuggestAi: _suggestWithAi,
      onRegenerate: _regenerate,
      onGenerate: _recompute,
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
    (code) => code.toUpperCase() == suggestion.color.newCode.toUpperCase(),
  );

  /// Whether Regenerate has anything else to show. A blending chain has
  /// nothing to roll: it steps through the alternative chains of its result,
  /// so it needs at least two.
  bool get _canRegenerate =>
      !_chainMode || (_chainResult?.chains.length ?? 0) > 1;

  /// Regenerates the palette on screen: another variation of the same type
  /// (the base marker and the locked ones stay), or, for a blending chain,
  /// the next alternative chain.
  void _regenerate() {
    if (_chainMode) {
      final BlendingChainResult? result = _chainResult;
      if (result == null || result.chains.length < 2) return;
      _selectChain((_chainIndex + 1) % result.chains.length);
      return;
    }
    setState(() => _variationToken++);
    _recompute(keepVariation: true);
  }
}
