part of 'palette_page.dart';

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
      aiUsed = s._aiUsed,
      chain = s._chain,
      chainResult = s._chainResult,
      chainIndex = s._chainIndex,
      chainWholeRange = s._chainWholeRange;

  final PaletteMode mode;
  final bool useScenario;
  final Scene scenario;
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
    s._chain = chain;
    s._chainResult = chainResult;
    s._chainIndex = chainIndex;
    s._chainWholeRange = chainWholeRange;
    // Whatever photo came since goes, with a photo still being read.
    s._dropPhoto();
    s._failure = null;
    s._unknownInput = false;
    s._notice = null;
  }
}
