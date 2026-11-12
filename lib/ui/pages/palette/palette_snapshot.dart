part of 'palette_page.dart';

/// The answer of `_approveReplacement`: nothing to ask, the user agreed to
/// replace the palette they worked on, or they did not.
enum _Approval { free, confirmed, refused }

/// The palette on screen before something replaces it, kept to undo that:
/// the markers and their locks, the base, the type, scene and size, the
/// chains, the photo, the notes and the AI state.
///
/// A photo palette keeps its [PhotoScene] (the picture in memory, never
/// stored): bringing it back only decodes the thumbnail again.
final class _PaletteSnapshot {
  _PaletteSnapshot.of(_PalettePageState s)
    : mode = s._mode,
      useScenario = s._useScenario,
      baseInput = s._baseInput,
      paletteSize = s._paletteSize,
      suggestions = s._suggestions,
      lockedCodes = s._lockedCodes,
      lockedSuggestions = Map<String, PaletteSuggestion>.of(
        s._lockedSuggestions,
      ),
      aiUsed = s._aiUsed,
      chain = s._chain,
      chainResult = s._chainResult,
      chainIndex = s._chainIndex,
      chainWholeRange = s._chainWholeRange,
      chainRangeBrands = s._chainRangeBrands,
      sceneChoice = s._sceneChoice,
      aiModel = s._aiModel,
      aiProvider = s._aiProvider,
      aiCount = s._aiCount,
      aiTotal = s._aiTotal,
      aiError = s._aiError,
      notice = s._notice,
      failure = s._failure,
      unknownInput = s._unknownInput,
      variationToken = s._variationToken,
      worked = s._workedPalette,
      edited = s._paletteEdited,
      photoScene = s._photoScene,
      photoPicks = s._photoPicks,
      photoError = s._photoError;

  final PaletteMode mode;
  final bool useScenario;
  final String baseInput;
  final int paletteSize;
  final List<PaletteSuggestion> suggestions;
  final List<String> lockedCodes;
  final Map<String, PaletteSuggestion> lockedSuggestions;
  final bool aiUsed;
  final BlendingChain? chain;
  final BlendingChainResult? chainResult;
  final int chainIndex;
  final bool chainWholeRange;
  final Set<String> chainRangeBrands;

  final Scene? sceneChoice;
  final String aiModel;
  final AiProvider? aiProvider;
  final int aiCount, aiTotal, variationToken;
  final String? aiError, photoError;
  final _PaletteNotice? notice;
  final PaletteFailureReason? failure;
  final bool unknownInput, worked, edited;
  final PhotoScene? photoScene;
  final List<PhotoMarkerPick> photoPicks;

  /// Whether the palette on [s] is another one: other markers (or another
  /// order), another base, type or scene. A new size that leaves the same
  /// markers is the same palette.
  bool differsFrom(_PalettePageState s) {
    if (mode != s._mode ||
        useScenario != s._useScenario ||
        baseInput.trim().toUpperCase() != s._baseInput.trim().toUpperCase() ||
        !identical(photoScene, s._photoScene) ||
        (useScenario && sceneChoice?.id != s._sceneChoice?.id) ||
        suggestions.length != s._suggestions.length) {
      return true;
    }
    for (int i = 0; i < suggestions.length; i++) {
      if (suggestions[i].color.colorId != s._suggestions[i].color.colorId) {
        return true;
      }
    }
    return false;
  }

  /// Puts the palette back (call inside setState).
  void restore(_PalettePageState s) {
    s._mode = mode;
    s._useScenario = useScenario;
    s._baseInput = baseInput;
    s._baseController.text = baseInput;
    s._paletteSize = paletteSize;
    s._suggestions = suggestions;
    s._lockedCodes = lockedCodes;
    s._lockedSuggestions
      ..clear()
      ..addAll(lockedSuggestions);
    s._aiUsed = aiUsed;
    s._chain = chain;
    s._chainResult = chainResult;
    s._chainIndex = chainIndex;
    s._chainWholeRange = chainWholeRange;
    s._chainRangeBrands = chainRangeBrands;
    ++s._aiVersion;
    s._aiLoading = false;
    s._dropPhoto();
    s._sceneChoice = sceneChoice;
    s._aiModel = aiModel;
    s._aiProvider = aiProvider;
    s._aiCount = aiCount;
    s._aiTotal = aiTotal;
    s._aiError = aiError;
    s._notice = notice;
    s._failure = failure;
    s._unknownInput = unknownInput;
    s._variationToken = variationToken;
    s._workedPalette = worked;
    s._paletteEdited = edited;
    s._photoScene = photoScene;
    s._photoPicks = photoPicks;
    s._photoError = photoError;
  }
}
