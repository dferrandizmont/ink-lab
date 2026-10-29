// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsCollectionGroup => 'My collection';

  @override
  String get settingsDisplayGroup => 'Display';

  @override
  String get settingsDataGroup => 'Your data';

  @override
  String get settingsAiGroup => 'AI assistant';

  @override
  String get settingsAiOffByDefault => 'Off by default';

  @override
  String get settingsUnavailable =>
      'The app services are not available, so the settings cannot be shown.';

  @override
  String get settingsBrandTitle => 'Brand';

  @override
  String get settingsBrandSubtitle =>
      'The brand selects the catalogue of markers the app works with.';

  @override
  String get settingsPalettesTitle => 'Saved palettes';

  @override
  String get settingsPalettesEmpty => 'No palette has been saved yet.';

  @override
  String get settingsClearPalettes => 'Clear all';

  @override
  String get settingsClearPalettesTitle => 'Delete every saved palette?';

  @override
  String get settingsClearPalettesBody =>
      'The palettes saved for this brand will be deleted. This cannot be undone.';

  @override
  String get settingsDeletePalette => 'Delete the palette';

  @override
  String get settingsFavoritesTitle => 'Favourites';

  @override
  String get settingsFavoritesEmpty => 'No colour is a favourite yet.';

  @override
  String get settingsClearFavorites => 'Clear all';

  @override
  String get settingsClearFavoritesTitle => 'Remove every favourite?';

  @override
  String get settingsClearFavoritesBody =>
      'The favourite colours of this brand will be removed. This cannot be undone.';

  @override
  String get settingsDeleteFavorite => 'Remove the favourite';

  @override
  String get settingsLabelsTitle => 'Ohuhu codes';

  @override
  String get settingsLabelsSubtitle => 'Ohuhu renamed its codes in 2023.';

  @override
  String get settingsNewLabels => 'Current';

  @override
  String get settingsOldLabels => 'Old';

  @override
  String get settingsBothLabels => 'Both';

  @override
  String get settingsAppearanceTitle => 'Appearance';

  @override
  String get settingsAppearanceSystem => 'System';

  @override
  String get settingsAppearanceLight => 'Light';

  @override
  String get settingsAppearanceDark => 'Dark';

  @override
  String get settingsBackupTitle => 'Backup';

  @override
  String get settingsBackupSubtitle =>
      'Your settings, palettes, history and AI settings can be exported as a JSON file and imported back.';

  @override
  String get settingsExportBackup => 'Export';

  @override
  String get settingsImportBackup => 'Import';

  @override
  String get settingsBackupExported => 'Backup copied to the clipboard';

  @override
  String get settingsBackupImported => 'Backup imported';

  @override
  String get settingsImportTitle => 'Import a backup';

  @override
  String get settingsImportHint => 'Paste the exported JSON here';

  @override
  String get settingsImportConfirm => 'Import';

  @override
  String get settingsCancel => 'Cancel';

  @override
  String get settingsImportConfirmTitle => 'Replace your current data?';

  @override
  String get settingsImportConfirmBody =>
      'The backup replaces your settings, your saved palettes, your colour match history and your AI settings.';

  @override
  String get settingsImportInvalidJson => 'The text is not valid JSON.';

  @override
  String get settingsImportInvalidDocument =>
      'The text is not a backup document.';

  @override
  String get settingsAiTitle => 'AI assistant';

  @override
  String get settingsAiSubtitle =>
      'The AI only suggests palettes. It never changes your collection.';

  @override
  String get settingsAiEnabled => 'Suggest with AI';

  @override
  String get settingsAiEnabledSubtitleColourTheory =>
      'Pick On-device or OpenRouter below to use an AI';

  @override
  String get settingsAiEnabledSubtitleColourTheoryNoOnDevice =>
      'Pick OpenRouter below to use an AI';

  @override
  String get settingsAiEnabledSubtitleOnDevice => 'Gemini Nano on this phone';

  @override
  String get settingsAiEnabledSubtitleOpenRouter =>
      'Uses your own OpenRouter key';

  @override
  String get settingsAiExplainColourTheory =>
      'Palettes come from the built-in colour-theory engine. No AI, nothing leaves your phone.';

  @override
  String get settingsAiExplainOnDevice =>
      'Gemini Nano runs on this phone. Nothing leaves your phone.';

  @override
  String get settingsAiExplainOpenRouter =>
      'Requests go to openrouter.ai with your own key. Photos are never sent.';

  @override
  String get settingsAiProvider => 'Provider';

  @override
  String get settingsAiProviderColourTheory => 'Colour theory';

  @override
  String get settingsAiProviderOnDevice => 'On-device';

  @override
  String get settingsAiProviderOpenRouter => 'OpenRouter';

  @override
  String get settingsAiTextModel => 'Text model';

  @override
  String get settingsAiTextModelHint => 'Model id used for text requests';

  @override
  String get settingsAiVisionModel => 'Vision model';

  @override
  String get settingsAiVisionModelHint => 'Model id used for image requests';

  @override
  String get settingsAiTemperature => 'Temperature';

  @override
  String get settingsAiMaxTokens => 'Max tokens';

  @override
  String get settingsAiAutoFallback => 'Built-in fallback';

  @override
  String get settingsAiAutoFallbackSubtitle =>
      'If the AI fails, the built-in engine answers instead.';

  @override
  String get settingsAiApiKey => 'API key';

  @override
  String get settingsAiApiKeySubtitle =>
      'Your own key, kept in the secure store of this device.';

  @override
  String get settingsAiApiKeySave => 'Save key';

  @override
  String get settingsAiApiKeyRemove => 'Remove key';

  @override
  String get settingsAiApiKeySaved => 'Key saved.';

  @override
  String get settingsAiRemoveKeyTitle => 'Remove the API key?';

  @override
  String get settingsAiRemoveKeyBody =>
      'The key is deleted from this device. AI suggestions stop until you enter a key again.';

  @override
  String get settingsAiRemoveKeyConfirm => 'Remove';

  @override
  String get settingsAiApiKeyInvalid =>
      'That does not look like an OpenRouter key. It should start with sk-or- and have no spaces.';

  @override
  String get settingsAiApiKeyUnreadable =>
      'Your saved key could not be read. Enter it again.';

  @override
  String get settingsAiApiKeyStorageError =>
      'The key could not be saved. Try again.';

  @override
  String get settingsAiDisclosureTitle => 'Turn on AI suggestions?';

  @override
  String get settingsAiDisclosure =>
      'When this is on and you use a suggestion with OpenRouter, the app sends your scenario, the base colour code, name and hex value, and the list of candidate colours to openrouter.ai and to the model provider, using your own API key. Photos are never sent: this feature has no image upload. Nothing at all is sent while this switch is off.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'With Colour theory selected, palettes come from the built-in engine: no AI is used and nothing leaves your phone. Choose On-device or OpenRouter to use an AI.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'With Colour theory selected, palettes come from the built-in engine: no AI is used and nothing leaves your phone. Choose OpenRouter to use an AI.';

  @override
  String get settingsAiDisclosureConfirm => 'Enable';

  @override
  String get settingsAiDisclosureCancel => 'Not now';

  @override
  String get settingsAiDisclosureOnDevice =>
      'On-device (Gemini Nano) requests are answered by the model on this phone. Your scenario and colour codes never leave it, and no key is needed.';

  @override
  String get settingsAiOnDeviceName => 'On-device (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'On-device requests never leave your phone.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'The model is not on this phone yet. Android downloads it once and keeps it for every app.';

  @override
  String get settingsAiOnDeviceDownloading => 'Downloading the model...';

  @override
  String get settingsAiOnDevicePreparing =>
      'Android is preparing the model. This can take a while and may wait for Wi‑Fi and charging. You can leave this screen; the download continues in the background.';

  @override
  String get settingsAiOnDeviceCheckAgain => 'Check again';

  @override
  String get settingsAiOnDeviceReady => 'The model is ready on this phone.';

  @override
  String get settingsAiOnDeviceDownload => 'Download model';

  @override
  String get settingsAiOnDeviceFailed =>
      'The download did not finish. Check the connection and try again.';

  @override
  String get settingsAiTestConnection => 'Test connection';

  @override
  String get settingsAiTestingConnection => 'Testing...';

  @override
  String get settingsAiModelsTitle => 'Model';

  @override
  String get settingsAiModelsFilterFree => 'Free';

  @override
  String get settingsAiModelsFilterPaid => 'Paid';

  @override
  String get settingsAiModelsFilterBoth => 'Both';

  @override
  String get settingsAiModelsLoad => 'Load models';

  @override
  String get settingsAiModelsEmpty => 'No models matched this filter.';

  @override
  String get settingsAiModelsNeedsKey =>
      'Save a key to load the models from OpenRouter.';

  @override
  String get settingsAiPrimaryModel => 'Text model';

  @override
  String get settingsAiModelNone => 'Not set';

  @override
  String get settingsAiModelsPickerHint =>
      'Load the models, then pick them from the list.';

  @override
  String get settingsAiModelSearchHint => 'Search models';

  @override
  String get settingsAiModelFree => 'Free';

  @override
  String get settingsAiModelPaid => 'Paid';

  @override
  String get settingsAiModelsDone => 'Done';

  @override
  String get settingsAiModelsNotLoaded =>
      'Load the models first, or type a model id above.';

  @override
  String get settingsAiRecommended => 'Recommended';

  @override
  String get settingsAiFreeModelsNote =>
      'Free models may be slow or unreliable. The recommended models are inexpensive and answer more consistently.';

  @override
  String get settingsAiAllModels => 'All models';

  @override
  String get settingsAiRecommendedDefault => 'Recommended default';

  @override
  String get settingsAiFallbacksTitle => 'Fallbacks';

  @override
  String get settingsAboutTitle => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsSourceCode => 'Source code';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsCopyRepository => 'Copy the link';

  @override
  String get settingsRepositoryCopied => 'The link was copied';

  @override
  String get settingsDisclaimer =>
      'Ink Lab is an independent community project: it is not affiliated with, endorsed by or sponsored by Ohuhu or DecoTime, and it uses their marker codes, names and colour values only as factual reference data.';

  @override
  String get paletteTitle => 'Palette';

  @override
  String get paletteBaseCodeLabel => 'Base marker code';

  @override
  String get paletteBaseCodeHint => 'E08 or B271';

  @override
  String get paletteHarmonyLabel => 'Harmony';

  @override
  String get paletteScenarioToggle => 'Scenes';

  @override
  String get paletteScenarioTitle => 'Scenes';

  @override
  String get paletteSizeTitle => 'Size';

  @override
  String get paletteSizeSemantic => 'Palette size';

  @override
  String get paletteGenerateButton => 'Generate';

  @override
  String get paletteRegenerateButton => 'Regenerate';

  @override
  String get paletteClearButton => 'Clear';

  @override
  String get paletteSuggestAiButton => 'Suggest with AI';

  @override
  String get paletteSuggestAiLoading => 'Suggesting…';

  @override
  String get paletteAiBadge => 'AI';

  @override
  String get paletteSaveButton => 'Save palette';

  @override
  String get paletteOkButton => 'OK';

  @override
  String get paletteBaseMarkerTitle => 'Base marker';

  @override
  String get paletteVariationsLabel => 'Variations';

  @override
  String get palettePaintPlanTitle => 'Paint order';

  @override
  String get palettePaintTipBase =>
      'Block the overall shape with the base colour first.';

  @override
  String get palettePaintTipShadow =>
      'Lay this shadow where light does not reach.';

  @override
  String get palettePaintTipHighlight =>
      'Place the highlight where light hits directly.';

  @override
  String get palettePaintTipAccent =>
      'Reserve the accent for focal areas only.';

  @override
  String get palettePaintTipSupport =>
      'Use this support tone to blend transitions.';

  @override
  String get paletteSubtitleIdle =>
      'Build a palette from a base marker you own';

  @override
  String get paletteAiOptionalNote => 'AI is optional and off by default.';

  @override
  String get paletteLockButton => 'Lock';

  @override
  String get paletteUnlockButton => 'Unlock';

  @override
  String get paletteSaveDialogTitle => 'Save palette';

  @override
  String get paletteSaveDialogHint => 'Palette name';

  @override
  String get paletteSaveDialogCancel => 'Cancel';

  @override
  String get paletteSaveDialogConfirm => 'Save';

  @override
  String get paletteSavedTitle => 'Saved palettes';

  @override
  String get paletteSavedEmpty => 'No saved palettes for this brand yet.';

  @override
  String get paletteLoadButton => 'Load';

  @override
  String get paletteDeleteButton => 'Delete';

  @override
  String get paletteDeleteDialogTitle => 'Delete palette?';

  @override
  String get paletteDeleteDialogBody => 'This action cannot be undone.';

  @override
  String get paletteAiFellBack => 'AI unavailable. Showing local suggestions.';

  @override
  String get paletteEmptyHint =>
      'Pick a base marker to build a palette, or choose a scene with the Scenes chip.';

  @override
  String get paletteCustomModeHint =>
      'Custom palette mode is manual: load a saved palette or apply one from Ideas.';

  @override
  String get paletteNoSuggestions =>
      'No palette could be built from your collection. Try another mode or add more markers.';

  @override
  String get palettePickBaseTooltip => 'Choose from your markers';

  @override
  String get palettePickerTitle => 'Choose a base marker';

  @override
  String get palettePickerSearchHint => 'Code or name';

  @override
  String get palettePickerEmpty => 'No marker matches your search.';

  @override
  String get paletteUndoButton => 'Undo';

  @override
  String paletteBaseReplaced(String code) {
    return '$code is now the base. Your previous palette was replaced.';
  }

  @override
  String paletteIdeaApplied(String title, int count) {
    return '“$title” palette applied ($count markers).';
  }

  @override
  String get swatchesTitle => 'Swatches';

  @override
  String get swatchesSearchHint => 'Code, name or hex';

  @override
  String get swatchesClearSearch => 'Clear the search';

  @override
  String get swatchesAllFilter => 'All';

  @override
  String get swatchesFavoritesOnly => 'Favourites';

  @override
  String get swatchesOwnedOnly => 'Mine';

  @override
  String get swatchesFilters => 'Filters';

  @override
  String get swatchesFiltersTitle => 'Filters';

  @override
  String get swatchesLabelPack => 'Set';

  @override
  String get swatchesLabelLayout => 'Layout';

  @override
  String get swatchesAllPacks => 'All sets';

  @override
  String get swatchesClearFilters => 'Clear filters';

  @override
  String get swatchesLoadingSemantics => 'Loading colours';

  @override
  String get swatchesClosestAlternatives => 'Closest alternatives';

  @override
  String get swatchesDeltaEUnit => 'ΔE 76';

  @override
  String get swatchesInPacks => 'In sets';

  @override
  String get swatchesLocation => 'Location';

  @override
  String get swatchesAddToPalette => 'Add to palette';

  @override
  String get swatchesLayoutGrid => 'Grid';

  @override
  String get swatchesLayoutList => 'List';

  @override
  String get swatchesOwned => 'Owned';

  @override
  String get swatchesNewLabels => 'New';

  @override
  String get swatchesOldLabels => 'Old';

  @override
  String get swatchesBothLabels => 'Both';

  @override
  String get swatchesLabelMode => 'Labels';

  @override
  String get swatchesToggleLayout => 'Switch between the grid and the list';

  @override
  String get swatchesGridLayout => 'Grid';

  @override
  String get swatchesListLayout => 'List';

  @override
  String get swatchesNewCode => 'New code';

  @override
  String get swatchesOldCode => 'Old code';

  @override
  String get swatchesNewName => 'New name';

  @override
  String get swatchesOldName => 'Old name';

  @override
  String get swatchesHex => 'Hex';

  @override
  String get swatchesCopyHex => 'Copy hex';

  @override
  String get swatchesHexCopied => 'Hex copied to the clipboard';

  @override
  String get swatchesAddFavorite => 'Add to favourites';

  @override
  String get swatchesRemoveFavorite => 'Remove from favourites';

  @override
  String get swatchesEmptyNoOwnedTitle => 'No markers yet';

  @override
  String get swatchesEmptyNoOwnedBody =>
      'You haven\'t added any markers yet. Tell the app which sets and markers you have.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Set up my collection';

  @override
  String get swatchesEmptyNoOwnedHint => 'Open Settings, then My collection.';

  @override
  String get swatchesEmptySearchTitle => 'No colours found';

  @override
  String get swatchesEmptySearchBody =>
      'No colour of this collection matches your search.';

  @override
  String get swatchesEmptyFiltersTitle => 'Nothing to show';

  @override
  String get swatchesEmptyFiltersBody =>
      'This brand has no colours for the selected sets and filters.';

  @override
  String get swatchesLoading => 'Loading colours…';

  @override
  String get swatchesLoadFailedTitle => 'Colours unavailable';

  @override
  String get swatchesLoadFailedBody =>
      'The marker catalogue could not be read, so no colours can be shown.';

  @override
  String get swatchesUnavailable =>
      'The app services are not available, so the swatches cannot be shown.';

  @override
  String get swatchesVisibleCount => 'Colours';

  @override
  String get swatchesScopeCollection => 'Your collection';

  @override
  String get swatchesScopePack => 'Pack';

  @override
  String get ideasTitle => 'Ideas';

  @override
  String get ideasHeaderSubtitle =>
      'Exercises for your markers, with a palette from your collection';

  @override
  String get ideasHeaderSubtitleWholeRange =>
      'Exercises with a palette from the whole range';

  @override
  String get ideasSearchHint => 'Search ideas';

  @override
  String get ideasCategoryAll => 'All';

  @override
  String get ideasApplyButton => 'Use in Palette';

  @override
  String get ideasGuideOnlyNote =>
      'This exercise uses your whole collection, so it has no fixed palette.';

  @override
  String get ideasNoMarkersDecoTime =>
      'Add the DecoTime markers you own in My collection to get a palette for this idea.';

  @override
  String get ideasNoMarkersOther =>
      'Add the markers you own in My collection to get a palette for this idea.';

  @override
  String get ideasCategoriesLabel => 'Categories';

  @override
  String get ideasEmptyTitle => 'No ideas found';

  @override
  String get ideasClearFilters => 'Clear filters';

  @override
  String get ideasEmptySearch => 'No ideas match your search.';

  @override
  String get ideasNoMarkers => 'No markers currently available';

  @override
  String get ideasCategoryTechnique => 'Techniques';

  @override
  String get ideasCategoryColorChallenge => 'Colour challenges';

  @override
  String get ideasCategoryMood => 'Moods';

  @override
  String get ideasCategorySeason => 'Seasons';

  @override
  String get ideasDifficultyEasy => 'Easy';

  @override
  String get ideasDifficultyMedium => 'Medium';

  @override
  String get ideasDifficultyHard => 'Hard';

  @override
  String get ideasFeaturedLabel => 'Idea of the day';

  @override
  String get ideasOpenButton => 'See steps';

  @override
  String get ideasOtherMarkersButton => 'Other markers';

  @override
  String get ideasPracticeTitle => 'What you practise';

  @override
  String get ideasSubjectTitle => 'What to draw';

  @override
  String get ideasMarkersTitle => 'Your markers';

  @override
  String get ideasStepsTitle => 'Steps';

  @override
  String get ideasTipTitle => 'Tip';

  @override
  String get ideasMaterialsTitle => 'You need';

  @override
  String get ideasMaterialPaper => 'marker paper with a sheet underneath';

  @override
  String get ideasMaterialBlender => 'colourless blender';

  @override
  String get ideasMaterialWhiteGel => 'white gel pen';

  @override
  String get ideasMaterialPigmentLiner => 'black pigment liner';

  @override
  String get ideasMaterialPencil => 'pencil';

  @override
  String get ideasMaterialTape => 'masking tape';

  @override
  String get ideasBackLabel => 'Back to ideas';

  @override
  String ideasMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String ideasMissingMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Your collection is missing $count markers for this idea.',
      one: 'Your collection is missing 1 marker for this idea.',
    );
    return '$_temp0';
  }

  @override
  String ideasMarkerSemantic(String role, String code, String name) {
    return '$role: $code $name';
  }

  @override
  String get ideasSmoothFillTitle => 'Streak-free fill';

  @override
  String get ideasSmoothFillSummary =>
      'Fill a square with one marker without visible streaks.';

  @override
  String get ideasSmoothFillPractice =>
      'Even, streak-free coverage, the base of every marker drawing.';

  @override
  String get ideasSmoothFillSubject =>
      'A 5 × 5 cm square framed with masking tape, then a simple flat shape such as a leaf.';

  @override
  String get ideasSmoothFillTip =>
      'If the paper starts to pill, stop: it is saturated. Let it dry completely before another layer.';

  @override
  String get ideasSmoothFillStep1 =>
      'Tape a 5 × 5 cm square on marker paper and slip a scrap sheet underneath.';

  @override
  String get ideasSmoothFillStep2 =>
      'Fill the square with the light marker in small overlapping circles, without stopping.';

  @override
  String get ideasSmoothFillStep3 =>
      'Keep a wet edge: always go back over ink that is still shiny, never over dry ink.';

  @override
  String get ideasSmoothFillStep4 =>
      'Let it dry, then add a second layer with the same marker, at right angles to the first.';

  @override
  String get ideasSmoothFillStep5 =>
      'Repeat the square with the darker marker and compare: streaks show more in dark colours.';

  @override
  String get ideasSmoothFillStep6 =>
      'Peel the tape off slowly to reveal a clean edge.';

  @override
  String get ideasThreeMarkerBlendTitle => 'Three-marker blend';

  @override
  String get ideasThreeMarkerBlendSummary =>
      'Blend a light, a mid and a dark marker of one family on a ball.';

  @override
  String get ideasThreeMarkerBlendPractice =>
      'Smooth light-to-dark blending within one colour family.';

  @override
  String get ideasThreeMarkerBlendSubject =>
      'A ball lit from the top left, with its shadow on the table.';

  @override
  String get ideasThreeMarkerBlendTip =>
      'Pick markers that are close in tone: if the jump between them is too big, a line will show.';

  @override
  String get ideasThreeMarkerBlendStep1 =>
      'Draw a circle in light pencil and mark where the light comes from.';

  @override
  String get ideasThreeMarkerBlendStep2 =>
      'Cover the whole ball with the light marker, leaving a small spot of white paper for the highlight.';

  @override
  String get ideasThreeMarkerBlendStep3 =>
      'While it is still damp, add the mid marker on the shadow half, in curved strokes that follow the shape.';

  @override
  String get ideasThreeMarkerBlendStep4 =>
      'Add the dark marker only along the edge furthest from the light.';

  @override
  String get ideasThreeMarkerBlendStep5 =>
      'Go back over the joins with the mid marker and then with the light one to melt the steps together.';

  @override
  String get ideasThreeMarkerBlendStep6 =>
      'Soften any hard edge around the highlight with the colourless blender.';

  @override
  String get ideasFlickingTitle => 'Flicking strokes';

  @override
  String get ideasFlickingSummary =>
      'Draw hair or grass with quick strokes that fade out at the end.';

  @override
  String get ideasFlickingPractice =>
      'Flicking: fast strokes that taper off, to blend without hard edges.';

  @override
  String get ideasFlickingSubject => 'A ponytail or a tuft of grass.';

  @override
  String get ideasFlickingTip =>
      'Try it on a scrap first: the faster you move, the thinner the tail of the stroke.';

  @override
  String get ideasFlickingStep1 =>
      'Pencil the main locks or blades as simple shapes, without detail.';

  @override
  String get ideasFlickingStep2 =>
      'Cover each shape with the light marker in one flat layer and let it dry.';

  @override
  String get ideasFlickingStep3 =>
      'Flick the mid marker from the roots outwards: press, move fast and lift before the end of the stroke.';

  @override
  String get ideasFlickingStep4 =>
      'Do the same with the dark marker, only from the roots and shorter, where the locks overlap.';

  @override
  String get ideasFlickingStep5 =>
      'Flick the light marker from the tips back towards the roots to soften the change of tone.';

  @override
  String get ideasFlickingStep6 =>
      'Leave a band of the first layer where the hair catches the light.';

  @override
  String get ideasGrayscaleTitle => 'Shades of grey';

  @override
  String get ideasGrayscaleSummary =>
      'Draw a simple object with one grey family to see how light and shadow build form.';

  @override
  String get ideasGrayscalePractice =>
      'Seeing light and shadow as steps from light to dark.';

  @override
  String get ideasGrayscaleSubject =>
      'A mug, an apple or an egg under a single lamp.';

  @override
  String get ideasGrayscaleTip =>
      'Do not mix warm and cool greys in the same object: pick one family.';

  @override
  String get ideasGrayscaleStep1 =>
      'Pick a simple object and mark in pencil where the light comes from.';

  @override
  String get ideasGrayscaleStep2 =>
      'Leave the highlight as white paper. Never colour over it.';

  @override
  String get ideasGrayscaleStep3 =>
      'Cover the whole object with the lightest grey and let it dry.';

  @override
  String get ideasGrayscaleStep4 =>
      'Add the next grey on the shadow side, blending the edge while it is still wet.';

  @override
  String get ideasGrayscaleStep5 =>
      'Repeat with each darker grey, covering a smaller area each time.';

  @override
  String get ideasGrayscaleStep6 =>
      'Use the darkest grey only for the cast shadow and the contact line under the object.';

  @override
  String get ideasStickerEffectTitle => 'Sticker effect';

  @override
  String get ideasStickerEffectSummary =>
      'Make a character look like a cut-out sticker with a paper-white border and a coloured background.';

  @override
  String get ideasStickerEffectPractice =>
      'Keeping the white of the paper on purpose.';

  @override
  String get ideasStickerEffectSubject =>
      'A cat, a slice of pizza or a cartoon star.';

  @override
  String get ideasStickerEffectTip =>
      'The white must be the paper. White gel over marker ink looks patchy.';

  @override
  String get ideasStickerEffectStep1 =>
      'Draw your subject, then pencil a second outline 3–5 mm outside it: that is the sticker border.';

  @override
  String get ideasStickerEffectStep2 =>
      'Colour the subject from light to dark without touching the border.';

  @override
  String get ideasStickerEffectStep3 =>
      'Colour the background around the border in one flat colour, so the white edge shows.';

  @override
  String get ideasStickerEffectStep4 =>
      'When it is dry, go over the outside of the border with a black liner or brush pen.';

  @override
  String get ideasStickerEffectStep5 =>
      'Add a grey shadow along one side of the border to lift the sticker off the page.';

  @override
  String get ideasGlossyCherriesTitle => 'Glossy cherries';

  @override
  String get ideasGlossyCherriesSummary =>
      'Make two cherries shine with a kept highlight and a reflected light.';

  @override
  String get ideasGlossyCherriesPractice =>
      'Crisp highlights and reflected light, the keys to a shiny surface.';

  @override
  String get ideasGlossyCherriesSubject =>
      'Two cherries on a stalk, lit from one side.';

  @override
  String get ideasGlossyCherriesTip =>
      'Shiny surfaces have hard-edged highlights: do not blend them, keep the border crisp.';

  @override
  String get ideasGlossyCherriesStep1 =>
      'Pencil the cherries and the shape of each highlight: a crisp bean shape near the top.';

  @override
  String get ideasGlossyCherriesStep2 =>
      'Cover each cherry with the light marker, going around the highlights so they stay white paper.';

  @override
  String get ideasGlossyCherriesStep3 =>
      'Add the base everywhere except a thin crescent along the bottom edge: that is the reflected light.';

  @override
  String get ideasGlossyCherriesStep4 =>
      'Lay the shadow on the side away from the light and blend it into the base while it is wet.';

  @override
  String get ideasGlossyCherriesStep5 =>
      'Add the darkest marker in a narrow band between the shadow and the reflected light.';

  @override
  String get ideasGlossyCherriesStep6 =>
      'Draw the shadow on the table with the grey and, once dry, add a white gel dot on each highlight.';

  @override
  String get ideasColoredShadowsTitle => 'Coloured shadows';

  @override
  String get ideasColoredShadowsSummary =>
      'Shade the same lemon twice, once with grey and once with violet, and compare.';

  @override
  String get ideasColoredShadowsPractice =>
      'Choosing shadow colours that keep a drawing alive.';

  @override
  String get ideasColoredShadowsSubject =>
      'Two lemons side by side on a white table.';

  @override
  String get ideasColoredShadowsTip =>
      'A shadow often leans towards the opposite of the light: violet under yellow, blue under orange.';

  @override
  String get ideasColoredShadowsStep1 =>
      'Draw two identical lemons side by side, with the light coming from the same side.';

  @override
  String get ideasColoredShadowsStep2 =>
      'Colour both with the yellow, leaving a small highlight of white paper.';

  @override
  String get ideasColoredShadowsStep3 =>
      'On the first lemon, shade the dark side and the shadow on the table with the grey.';

  @override
  String get ideasColoredShadowsStep4 =>
      'On the second, do the same with the violet, gently: one layer is enough.';

  @override
  String get ideasColoredShadowsStep5 =>
      'Go over the edge of the second shadow with the yellow to blend it in.';

  @override
  String get ideasColoredShadowsStep6 =>
      'Look at them from a distance: the violet shadow looks brighter and more natural next to the yellow.';

  @override
  String get ideasStainedGlassTitle => 'Stained glass';

  @override
  String get ideasStainedGlassSummary =>
      'Colour the glass panes with simple gradients and add the lead lines at the end.';

  @override
  String get ideasStainedGlassPractice =>
      'Clean gradients in small areas; the black lines hide uneven edges.';

  @override
  String get ideasStainedGlassSubject =>
      'A round window with a flower or a sun in the middle.';

  @override
  String get ideasStainedGlassTip =>
      'If you draw the black lines first, use pigment ink that resists alcohol: ordinary ink smears under the marker.';

  @override
  String get ideasStainedGlassStep1 =>
      'Pencil the window and divide it into panes of different sizes.';

  @override
  String get ideasStainedGlassStep2 =>
      'Colour the panes of the main colour first, each one as a gradient: darker at one edge, lighter in the middle.';

  @override
  String get ideasStainedGlassStep3 =>
      'Do the same with the second and third colours, letting each pane dry before colouring the one next to it.';

  @override
  String get ideasStainedGlassStep4 =>
      'Use the accent in just a few small panes so they stand out.';

  @override
  String get ideasStainedGlassStep5 =>
      'When everything is dry, go over the borders with thick lines of black liner or brush pen.';

  @override
  String get ideasStainedGlassStep6 =>
      'Add a small stroke of white gel on a few panes to suggest the shine of the glass.';

  @override
  String get ideasSwatchChartTitle => 'Your own colour chart';

  @override
  String get ideasSwatchChartSummary =>
      'Test how each marker looks with one, two and three layers.';

  @override
  String get ideasSwatchChartPractice =>
      'Knowing how your markers really look on paper, not on the cap.';

  @override
  String get ideasSwatchChartSubject =>
      'A grid with one row per marker, grouped by colour family.';

  @override
  String get ideasSwatchChartTip =>
      'Make the chart on the paper you really use: the same marker changes a lot from one paper to another.';

  @override
  String get ideasSwatchChartStep1 =>
      'Draw a grid on the paper you usually use: one row per marker and four squares per row.';

  @override
  String get ideasSwatchChartStep2 =>
      'Fill the first square with one layer, the second with two and the third with three, letting each layer dry.';

  @override
  String get ideasSwatchChartStep3 =>
      'In the fourth square, lay one layer and lift part of the ink with the colourless blender.';

  @override
  String get ideasSwatchChartStep4 =>
      'Write the code under each row in pencil or with a liner.';

  @override
  String get ideasSwatchChartStep5 =>
      'Use the Swatches tab to mark the markers you own and compare them with your chart.';

  @override
  String get ideasOneColorTitle => 'One colour family';

  @override
  String get ideasOneColorSummary =>
      'Draw a whole scene with four markers of a single colour family.';

  @override
  String get ideasOneColorPractice =>
      'Building depth with layers and with lighter and darker markers.';

  @override
  String get ideasOneColorSubject =>
      'A steaming cup of tea, or a small plant in a pot.';

  @override
  String get ideasOneColorTip =>
      'Pressing lightly does not make a marker paler. For light areas, use the lighter marker or the colourless blender.';

  @override
  String get ideasOneColorStep1 =>
      'Pick a simple subject and mark in pencil where the light comes from.';

  @override
  String get ideasOneColorStep2 =>
      'Cover everything except the highlights with the lightest marker.';

  @override
  String get ideasOneColorStep3 =>
      'Add the base marker to the parts facing away from the light.';

  @override
  String get ideasOneColorStep4 =>
      'Put the shadow marker in the darkest areas and blend the edges while they are wet.';

  @override
  String get ideasOneColorStep5 =>
      'Keep the darkest marker for contact shadows and a few small details.';

  @override
  String get ideasOneColorStep6 =>
      'To darken a tone without changing markers, add another layer of the same one once the first is dry.';

  @override
  String get ideasTwoMarkersTitle => 'Two-marker challenge';

  @override
  String get ideasTwoMarkersSummary =>
      'Just one light and one dark marker, nothing else.';

  @override
  String get ideasTwoMarkersPractice =>
      'Deciding what stays light and what goes dark before you start.';

  @override
  String get ideasTwoMarkersSubject =>
      'A mushroom, a sitting cat or a house with a roof.';

  @override
  String get ideasTwoMarkersTip =>
      'With only two markers, the white of the paper does a lot of the work: plan it from the start.';

  @override
  String get ideasTwoMarkersStep1 =>
      'Make a small sketch first and decide which areas are light and which are dark.';

  @override
  String get ideasTwoMarkersStep2 =>
      'Cover everything except the highlights with the light marker.';

  @override
  String get ideasTwoMarkersStep3 =>
      'Add a second layer of the light marker on the half-shadows.';

  @override
  String get ideasTwoMarkersStep4 =>
      'Use the dark marker only for the deepest shadows and a few details.';

  @override
  String get ideasTwoMarkersStep5 =>
      'Leave the white paper in the brightest spots: it is your third tone.';

  @override
  String get ideasTwoColorsTitle => 'Two opposite colours';

  @override
  String get ideasTwoColorsSummary =>
      'Use two opposite colours and one grey, and keep them apart.';

  @override
  String get ideasTwoColorsPractice =>
      'Handling opposite colours, which turn muddy when they overlap.';

  @override
  String get ideasTwoColorsSubject =>
      'An orange on a blue cloth, or a red flower with green leaves.';

  @override
  String get ideasTwoColorsTip =>
      'Two opposite colours layered on top of each other turn grey or brown. Use that only where you want a dull shadow.';

  @override
  String get ideasTwoColorsStep1 =>
      'Decide which areas belong to each colour and keep them as separate shapes.';

  @override
  String get ideasTwoColorsStep2 =>
      'Colour the shapes of the first colour, from light to dark.';

  @override
  String get ideasTwoColorsStep3 =>
      'Add its shadow while the first layer is still damp.';

  @override
  String get ideasTwoColorsStep4 =>
      'Let it dry completely, then colour the shapes of the second colour, stopping at the border.';

  @override
  String get ideasTwoColorsStep5 =>
      'Add the shadow of the second colour in the same way.';

  @override
  String get ideasTwoColorsStep6 =>
      'Use the grey for shadows that cross from one colour to the other.';

  @override
  String get ideasFiftyFiftyTitle => 'Half warm, half cool';

  @override
  String get ideasFiftyFiftySummary =>
      'Split one drawing in two: warm colours on one side, cool ones on the other.';

  @override
  String get ideasFiftyFiftyPractice =>
      'Seeing how warm and cool colours change the mood of the same subject.';

  @override
  String get ideasFiftyFiftySubject =>
      'A face or a house split down the middle.';

  @override
  String get ideasFiftyFiftyTip =>
      'Wet edges run into each other: never let a wet warm area touch a wet cool one.';

  @override
  String get ideasFiftyFiftyStep1 =>
      'Draw your subject and a line that splits it in two.';

  @override
  String get ideasFiftyFiftyStep2 =>
      'Colour the warm half first, from light to dark.';

  @override
  String get ideasFiftyFiftyStep3 =>
      'Add its shadows and let the whole half dry completely.';

  @override
  String get ideasFiftyFiftyStep4 =>
      'Colour the cool half, stopping a millimetre short of the line, and close the gap once the other side is dry.';

  @override
  String get ideasFiftyFiftyStep5 =>
      'Add the cool shadows in the same places as on the warm half.';

  @override
  String get ideasFiftyFiftyStep6 =>
      'Use the grey only in the darkest spots, so both halves share it.';

  @override
  String get ideasRandomColorsTitle => 'Five random markers';

  @override
  String get ideasRandomColorsSummary =>
      'Draw anything with five markers picked at random from your collection.';

  @override
  String get ideasRandomColorsPractice =>
      'Making any colours work together by controlling light and dark.';

  @override
  String get ideasRandomColorsSubject =>
      'Anything you like: a bird, a teapot or a monster.';

  @override
  String get ideasRandomColorsTip =>
      'Light and dark matter more than colour: a drawing with clear contrast works with almost any colours.';

  @override
  String get ideasRandomColorsStep1 =>
      'Look at the five markers above: they are sorted from lightest to darkest.';

  @override
  String get ideasRandomColorsStep2 =>
      'Use the lightest one for the large lit areas.';

  @override
  String get ideasRandomColorsStep3 =>
      'Use the middle ones for the main shapes.';

  @override
  String get ideasRandomColorsStep4 =>
      'Keep the darkest one for shadows and outlines.';

  @override
  String get ideasRandomColorsStep5 =>
      'If two colours clash, separate them with a thin line of white paper.';

  @override
  String get ideasRandomColorsStep6 =>
      'Tap Other markers for a new draw and try again.';

  @override
  String get ideasUnlikelyColorsTitle => 'Unexpected colours';

  @override
  String get ideasUnlikelyColorsSummary =>
      'Colour a familiar object in colours that are not its own.';

  @override
  String get ideasUnlikelyColorsPractice =>
      'Keeping light and dark right so the object still reads, whatever its colour.';

  @override
  String get ideasUnlikelyColorsSubject =>
      'A banana, a dog or your own trainer.';

  @override
  String get ideasUnlikelyColorsTip =>
      'If you squint and the drawing still reads, the light and dark are right, whatever the colours.';

  @override
  String get ideasUnlikelyColorsStep1 =>
      'Draw the object from life or from a photo and notice where its light and dark areas are.';

  @override
  String get ideasUnlikelyColorsStep2 =>
      'Use the lightest marker where the real object is lightest.';

  @override
  String get ideasUnlikelyColorsStep3 =>
      'Use the base where the real object has its middle tones.';

  @override
  String get ideasUnlikelyColorsStep4 =>
      'Use the shadow marker where the real object is darkest.';

  @override
  String get ideasUnlikelyColorsStep5 =>
      'Add the accent in one small area to catch the eye.';

  @override
  String get ideasPastelTitle => 'Soft pastels';

  @override
  String get ideasPastelSummary =>
      'Colour a soft, airy drawing with light markers and plenty of white paper.';

  @override
  String get ideasPastelPractice =>
      'Light, even layers and keeping the white of the paper.';

  @override
  String get ideasPastelSubject => 'A cupcake, a bunny or a bunch of flowers.';

  @override
  String get ideasPastelTip =>
      'Pressing lightly does not make a marker paler: choose a lighter marker instead.';

  @override
  String get ideasPastelStep1 =>
      'Pick a gentle subject and keep the pencil lines very light.';

  @override
  String get ideasPastelStep2 =>
      'Decide where the paper stays white: the highlights and part of the background.';

  @override
  String get ideasPastelStep3 =>
      'Colour each area with one light marker in a single even layer, in small circles.';

  @override
  String get ideasPastelStep4 =>
      'Make the shadow with a second layer of the same marker, not with a darker colour.';

  @override
  String get ideasPastelStep5 =>
      'Use the slightly deeper marker only for the smallest shadows.';

  @override
  String get ideasPastelStep6 =>
      'Soften any hard edge with the colourless blender.';

  @override
  String get ideasSkinTonesTitle => 'Skin with four markers';

  @override
  String get ideasSkinTonesSummary =>
      'Colour a face with a light tone, a base, a shadow and a blush.';

  @override
  String get ideasSkinTonesPractice =>
      'Soft skin blending and warm shadows on a face.';

  @override
  String get ideasSkinTonesSubject =>
      'A face in three-quarter view, lit from one side.';

  @override
  String get ideasSkinTonesTip =>
      'Skin shadows are warm: avoid greys, they make the face look dirty.';

  @override
  String get ideasSkinTonesStep1 =>
      'Draw the face lightly and mark the shadow shapes: under the brow, beside the nose, under the lip and along the jaw.';

  @override
  String get ideasSkinTonesStep2 =>
      'Cover all the skin with the light marker, leaving the brightest spots of the forehead, nose and cheek as white paper.';

  @override
  String get ideasSkinTonesStep3 =>
      'While it is damp, add the blush on the cheeks, the tip of the nose and the ears.';

  @override
  String get ideasSkinTonesStep4 =>
      'Put the base on the shadow shapes and blend their edges with the light marker.';

  @override
  String get ideasSkinTonesStep5 =>
      'Use the shadow marker only where shapes meet: under the chin, inside the ear and around the nostrils.';

  @override
  String get ideasSkinTonesStep6 =>
      'Soften any hard line with the light marker rather than the colourless blender, so the skin does not go blotchy.';

  @override
  String get ideasMidnightTitle => 'Moonlit night';

  @override
  String get ideasMidnightSummary =>
      'A small house at night, lit by the moon and one warm window.';

  @override
  String get ideasMidnightPractice =>
      'Planning a night scene: cool shadows and a few clean, warm lights.';

  @override
  String get ideasMidnightSubject =>
      'A small house at night with one lit window.';

  @override
  String get ideasMidnightTip =>
      'Do not let the blue and the yellow touch while either is wet: together they turn green.';

  @override
  String get ideasMidnightStep1 =>
      'Before you start, decide where the lights are: the moon and the window stay white paper.';

  @override
  String get ideasMidnightStep2 =>
      'Colour the window and a soft glow around it with the yellow, and let it dry completely.';

  @override
  String get ideasMidnightStep3 =>
      'Cover the sky and the lit walls with the light blue, working away from the moon.';

  @override
  String get ideasMidnightStep4 =>
      'Add the base blue to everything in shadow, a few millimetres away from the yellow glow.';

  @override
  String get ideasMidnightStep5 =>
      'Darken the sky towards the top and the shadows under the roof and the trees.';

  @override
  String get ideasMidnightStep6 =>
      'Use the darkest marker for the deepest shadows and, once dry, add a few stars with white gel.';

  @override
  String get ideasUnderwaterTitle => 'Under the sea';

  @override
  String get ideasUnderwaterSummary =>
      'Sunbeams in blue water around a small fish.';

  @override
  String get ideasUnderwaterPractice =>
      'Lifting rays of light with the colourless blender.';

  @override
  String get ideasUnderwaterSubject => 'A small fish swimming above a coral.';

  @override
  String get ideasUnderwaterTip =>
      'Try the blender rays on a scrap first: they only work while the ink is still slightly damp.';

  @override
  String get ideasUnderwaterStep1 =>
      'Colour the fish and the coral first with the accent and let them dry.';

  @override
  String get ideasUnderwaterStep2 =>
      'Cover the water with the light blue, stopping just short of the fish.';

  @override
  String get ideasUnderwaterStep3 =>
      'Add the base blue to the lower half and blend it upwards while it is wet.';

  @override
  String get ideasUnderwaterStep4 =>
      'Darken the bottom and the area behind the fish so it stands out.';

  @override
  String get ideasUnderwaterStep5 =>
      'While the blues are still damp, pull diagonal rays down from the surface with the colourless blender: it pushes the ink away.';

  @override
  String get ideasUnderwaterStep6 =>
      'Add the darkest marker at the very bottom and, once dry, finish with tiny bubbles in white gel.';

  @override
  String get ideasGalaxyTitle => 'Galaxy';

  @override
  String get ideasGalaxySummary =>
      'Blend glowing nebula colours into a dark sky and finish with stars.';

  @override
  String get ideasGalaxyPractice =>
      'Blending wet into wet, and lifting ink to make stars.';

  @override
  String get ideasGalaxySubject =>
      'A nebula over the silhouette of a mountain.';

  @override
  String get ideasGalaxyTip =>
      'Keep the big stars to a handful: too many flatten the depth.';

  @override
  String get ideasGalaxyStep1 =>
      'Use marker paper that does not bleed through and put a sheet underneath: this exercise takes a lot of ink.';

  @override
  String get ideasGalaxyStep2 =>
      'Start with the lightest nebula colours in soft, irregular clouds.';

  @override
  String get ideasGalaxyStep3 =>
      'While they are still wet, blend the middle colour into their edges.';

  @override
  String get ideasGalaxyStep4 =>
      'Fill the rest of the sky with the darkest markers, working towards the clouds, not over them.';

  @override
  String get ideasGalaxyStep5 =>
      'Dab the colourless blender on the dark areas to lift little dots of ink: they will be distant stars.';

  @override
  String get ideasGalaxyStep6 =>
      'Once dry, add a few bright stars and a cross-shaped sparkle with white gel.';

  @override
  String get ideasNeonTitle => 'Neon sign';

  @override
  String get ideasNeonSummary =>
      'Make a sign glow with a white core and a dark background.';

  @override
  String get ideasNeonPractice =>
      'Glow: a white core, a bright halo and a dark background.';

  @override
  String get ideasNeonSubject =>
      'The word OPEN, or a heart drawn as a neon tube.';

  @override
  String get ideasNeonTip =>
      'Fluorescent markers are see-through: use them on white, never over dark ink.';

  @override
  String get ideasNeonStep1 =>
      'Draw a simple word or shape in pencil with thick strokes.';

  @override
  String get ideasNeonStep2 =>
      'Leave a thin line of white paper in the middle of each stroke: that is the hot core.';

  @override
  String get ideasNeonStep3 =>
      'Colour the rest of the stroke with the light version of your neon colour.';

  @override
  String get ideasNeonStep4 =>
      'Flick the bright colour outwards from the stroke to make a soft halo.';

  @override
  String get ideasNeonStep5 =>
      'When the halo is dry, fill the background with the darkest marker, stopping a few millimetres from the halo.';

  @override
  String get ideasNeonStep6 =>
      'Blend that gap with the dark marker so the glow fades into the night.';

  @override
  String get ideasSepiaPhotoTitle => 'Old sepia photo';

  @override
  String get ideasSepiaPhotoSummary =>
      'Draw a portrait or a building as if it were an old brown photograph.';

  @override
  String get ideasSepiaPhotoPractice =>
      'Working with one warm family of browns, like a light-and-dark study in colour.';

  @override
  String get ideasSepiaPhotoSubject =>
      'An old house, a cowboy hat or a portrait of a grandparent.';

  @override
  String get ideasSepiaPhotoTip =>
      'Avoid black and cool greys: they break the warm sepia look.';

  @override
  String get ideasSepiaPhotoStep1 =>
      'Pencil the subject and frame it with a border that stays white paper.';

  @override
  String get ideasSepiaPhotoStep2 =>
      'Cover everything except the brightest spots with the lightest brown.';

  @override
  String get ideasSepiaPhotoStep3 =>
      'Build the middle tones with the base brown.';

  @override
  String get ideasSepiaPhotoStep4 =>
      'Add the shadows with the shadow brown, blending the edges while they are wet.';

  @override
  String get ideasSepiaPhotoStep5 =>
      'Use the darkest brown instead of black for the deepest shadows.';

  @override
  String get ideasSepiaPhotoStep6 =>
      'Darken the corners of the picture slightly with the warm grey to make it look old.';

  @override
  String get ideasSunsetTitle => 'Sunset sky';

  @override
  String get ideasSunsetSummary =>
      'Blend a sky from yellow to violet and add a dark silhouette.';

  @override
  String get ideasSunsetPractice =>
      'Blending neighbouring colours wet into wet over a large area.';

  @override
  String get ideasSunsetSubject =>
      'A sunset over the sea with a palm tree or a city skyline in silhouette.';

  @override
  String get ideasSunsetTip =>
      'Only blend neighbouring colours: yellow next to violet turns brownish while wet.';

  @override
  String get ideasSunsetStep1 =>
      'Pencil the horizon and the silhouette; keep the sun as a circle of white paper.';

  @override
  String get ideasSunsetStep2 =>
      'Start at the sun: colour a wide band of yellow around it.';

  @override
  String get ideasSunsetStep3 =>
      'While the yellow is wet, add the orange above it and blend the join.';

  @override
  String get ideasSunsetStep4 =>
      'Carry on upwards with the pink, blending each band into the last while it is wet.';

  @override
  String get ideasSunsetStep5 => 'Finish the top of the sky with the violet.';

  @override
  String get ideasSunsetStep6 =>
      'When the sky is dry, fill the silhouette with the darkest marker in flat, even strokes.';

  @override
  String get ideasSpringTitle => 'Spring blossom';

  @override
  String get ideasSpringSummary =>
      'A branch of cherry blossom with soft pink petals.';

  @override
  String get ideasSpringPractice =>
      'Delicate petals: light layers and soft edges.';

  @override
  String get ideasSpringSubject =>
      'A branch with five or six blossoms and a few leaves.';

  @override
  String get ideasSpringTip =>
      'Petals are thin: two light layers look more delicate than one dark one.';

  @override
  String get ideasSpringStep1 =>
      'Draw the branch and the flowers lightly, with five petals each.';

  @override
  String get ideasSpringStep2 =>
      'Colour each petal with the light pink, leaving a thin white edge on some of them.';

  @override
  String get ideasSpringStep3 =>
      'Add the base pink near the centre of each flower, flicking outwards.';

  @override
  String get ideasSpringStep4 =>
      'Touch the deepest pink only in the centre and where petals overlap.';

  @override
  String get ideasSpringStep5 =>
      'Colour the leaves and the young shoots with the green.';

  @override
  String get ideasSpringStep6 =>
      'Shade the underside of the leaves with the dark green.';

  @override
  String get ideasAutumnTitle => 'Autumn leaves';

  @override
  String get ideasAutumnSummary =>
      'A still life of fallen leaves in warm, glowing colours.';

  @override
  String get ideasAutumnPractice =>
      'Blending neighbouring warm colours and keeping the veins light.';

  @override
  String get ideasAutumnSubject =>
      'Three fallen leaves on a table: oak, maple and chestnut.';

  @override
  String get ideasAutumnTip =>
      'Leave the veins as a lighter line: it is easier than drawing them on top later.';

  @override
  String get ideasAutumnStep1 =>
      'Draw the leaves and their main veins in light pencil.';

  @override
  String get ideasAutumnStep2 =>
      'Colour the lightest leaf with the yellow, going around the veins so they stay light.';

  @override
  String get ideasAutumnStep3 =>
      'Colour the next leaf with the light orange and blend a little yellow into its edges while wet.';

  @override
  String get ideasAutumnStep4 =>
      'Colour the third leaf with the base and blend the light orange into its tip.';

  @override
  String get ideasAutumnStep5 =>
      'Add the red along the edges and in a few patches, as if the leaf were changing colour.';

  @override
  String get ideasAutumnStep6 =>
      'Shade where the leaves overlap and where they touch the table with the dark orange.';

  @override
  String get ideasWinterTitle => 'Snowy cabin';

  @override
  String get ideasWinterSummary =>
      'A cabin in the snow where the white is the paper itself.';

  @override
  String get ideasWinterPractice =>
      'Drawing snow with blue-grey shadows and lots of white paper.';

  @override
  String get ideasWinterSubject =>
      'A wooden cabin with snow on the roof and one lit window.';

  @override
  String get ideasWinterTip =>
      'Do not shade snow with warm grey: blue-greys make it look cold and clean.';

  @override
  String get ideasWinterStep1 =>
      'Pencil the cabin and where the snow ends: the snow is white paper, so plan it first.';

  @override
  String get ideasWinterStep2 =>
      'Colour the window with the yellow and let it dry.';

  @override
  String get ideasWinterStep3 =>
      'Colour the wooden walls with the brown without touching the snow on the roof.';

  @override
  String get ideasWinterStep4 =>
      'Shade the snow with the light blue-grey only where the light does not reach.';

  @override
  String get ideasWinterStep5 =>
      'Add the darker blue-grey under the roof and in the footprints, blending it into the light one.';

  @override
  String get ideasWinterStep6 =>
      'Use the darkest marker for the door and the deepest shadows and, once dry, add falling snow with white gel.';

  @override
  String get ideasChristmasTitle => 'Christmas baubles';

  @override
  String get ideasChristmasSummary =>
      'Shiny red baubles hanging from a green fir branch.';

  @override
  String get ideasChristmasPractice =>
      'Round, shiny shapes with a kept highlight and reflections.';

  @override
  String get ideasChristmasSubject =>
      'Two red baubles hanging from a fir branch.';

  @override
  String get ideasChristmasTip =>
      'Draw the branch after the baubles, so the green never runs into the red.';

  @override
  String get ideasChristmasStep1 =>
      'Draw the baubles and plan a window-shaped highlight on each one.';

  @override
  String get ideasChristmasStep2 =>
      'Cover each bauble with the light red, going around the highlight.';

  @override
  String get ideasChristmasStep3 =>
      'Add the base red in a ring that follows the round shape, leaving the middle lighter.';

  @override
  String get ideasChristmasStep4 =>
      'Darken the edge furthest from the light, keeping a thin lighter rim for the reflection.';

  @override
  String get ideasChristmasStep5 =>
      'Flick the needles of the branch with the green, from the stem outwards.';

  @override
  String get ideasChristmasStep6 =>
      'Add the dark green where the needles overlap and, once dry, a white gel sparkle on each bauble.';

  @override
  String get ideasHalloweenTitle => 'Halloween pumpkin';

  @override
  String get ideasHalloweenSummary =>
      'A glowing carved pumpkin in a dark violet night.';

  @override
  String get ideasHalloweenPractice =>
      'Light coming from inside an object, against a dark background.';

  @override
  String get ideasHalloweenSubject =>
      'A carved pumpkin with a candle inside, on a doorstep.';

  @override
  String get ideasHalloweenTip =>
      'Lay the dark background last and slowly near the edge: dark ink runs into light areas.';

  @override
  String get ideasHalloweenStep1 =>
      'Draw the pumpkin and its carved face; the inside of the face will be the brightest part.';

  @override
  String get ideasHalloweenStep2 =>
      'Colour the carved holes with the light orange, leaving a white core in the middle.';

  @override
  String get ideasHalloweenStep3 =>
      'Colour the pumpkin with the base orange, following its ribs with curved strokes.';

  @override
  String get ideasHalloweenStep4 =>
      'Shade the grooves between the ribs and the side away from the glow.';

  @override
  String get ideasHalloweenStep5 => 'Colour the stalk with the green.';

  @override
  String get ideasHalloweenStep6 =>
      'When everything is dry, fill the night with the dark violet, starting a few millimetres away from the pumpkin.';

  @override
  String get ideasRoleLight => 'Light';

  @override
  String get ideasReasonLight => 'First layer, over almost everything';

  @override
  String get ideasRoleLightMid => 'Light mid';

  @override
  String get ideasReasonLightMid => 'Second step, softens the jump to the base';

  @override
  String get ideasRoleBase => 'Base';

  @override
  String get ideasReasonBase => 'Main colour of the shapes';

  @override
  String get ideasRoleShadow => 'Shadow';

  @override
  String get ideasReasonShadow => 'Where the light does not reach';

  @override
  String get ideasRoleDeepShadow => 'Deep shadow';

  @override
  String get ideasReasonDeepShadow =>
      'Only the darkest corners and contact lines';

  @override
  String get ideasRoleShadowGray => 'Shadow grey';

  @override
  String get ideasReasonShadowGray => 'Neutral shadows and cast shadows';

  @override
  String get ideasRoleAccent => 'Accent';

  @override
  String get ideasReasonAccent => 'Small touches that draw the eye';

  @override
  String get ideasRoleBackground => 'Background';

  @override
  String get ideasReasonBackground => 'Around the subject, laid last';

  @override
  String get ideasRoleMainColor => 'Main colour';

  @override
  String get ideasReasonMainColor => 'First colour of the pair';

  @override
  String get ideasRoleMainShadow => 'Main shadow';

  @override
  String get ideasReasonMainShadow => 'Shadow of the first colour';

  @override
  String get ideasRoleSecondColor => 'Second colour';

  @override
  String get ideasReasonSecondColor => 'Second colour of the scheme';

  @override
  String get ideasRoleSecondShadow => 'Second shadow';

  @override
  String get ideasReasonSecondShadow => 'Shadow of the second colour';

  @override
  String get ideasRoleThirdColor => 'Third colour';

  @override
  String get ideasReasonThirdColor => 'Third colour of the scheme';

  @override
  String get ideasRoleBlush => 'Blush';

  @override
  String get ideasReasonBlush => 'Cheeks, nose and ears, blended while wet';

  @override
  String get ideasRoleWarmLight => 'Warm light';

  @override
  String get ideasReasonWarmLight => 'Lit areas of the warm half';

  @override
  String get ideasRoleWarmShadow => 'Warm shadow';

  @override
  String get ideasReasonWarmShadow => 'Shadows of the warm half';

  @override
  String get ideasRoleCoolLight => 'Cool light';

  @override
  String get ideasReasonCoolLight => 'Lit areas of the cool half';

  @override
  String get ideasRoleCoolShadow => 'Cool shadow';

  @override
  String get ideasReasonCoolShadow => 'Shadows of the cool half';

  @override
  String get ideasRoleColorShadow => 'Colour shadow';

  @override
  String get ideasReasonColorShadow =>
      'A coloured shadow to compare with the grey one';

  @override
  String get matchTitle => 'Match';

  @override
  String get matchPrivacyCaption => 'Photos stay on this phone.';

  @override
  String get matchCameraButton => 'Camera';

  @override
  String get matchGalleryButton => 'Gallery';

  @override
  String get matchLoadingPhoto => 'Reading photo…';

  @override
  String get matchEmptyPhotoTitle => 'No photo yet';

  @override
  String get matchEmptyPhotoMessage =>
      'Take a photo or pick one from the gallery to find the closest marker.';

  @override
  String get matchPhotoSemantics => 'Photo to sample a colour from';

  @override
  String get matchPickToSample =>
      'Tap or drag on the photo to sample a colour.';

  @override
  String get matchSampledLabel => 'Sampled';

  @override
  String get matchBestMatchTitle => 'Best match';

  @override
  String get matchAlternatesTitle => 'Alternatives';

  @override
  String get matchDeltaMethod => 'ΔE 76';

  @override
  String get matchSaveButton => 'Save';

  @override
  String get matchRecentTitle => 'Recent picks';

  @override
  String get matchRecentDetailSampled => 'Sampled';

  @override
  String get matchRecentEmpty =>
      'No recent picks yet. Tap a match to save it here.';

  @override
  String get matchClearButton => 'Clear';

  @override
  String get matchRemoveTooltip => 'Remove';

  @override
  String get matchCloseTooltip => 'Close';

  @override
  String get matchRecentPickLabel => 'Recent pick';

  @override
  String get matchClearDialogTitle => 'Clear recent picks?';

  @override
  String get matchClearDialogBody =>
      'Every saved pick is removed. This cannot be undone.';

  @override
  String get matchCancelButton => 'Cancel';

  @override
  String get matchCancelNotice => 'No photo selected.';

  @override
  String get matchCameraDenied =>
      'Camera access is off. Allow it in your device settings, or pick a photo from the gallery instead.';

  @override
  String get matchGalleryDenied =>
      'Photo access is off. Allow it in your device settings, then try again.';

  @override
  String get matchDecodeFailed =>
      'That photo could not be read. Try another one.';

  @override
  String get matchPickFailed => 'The photo could not be opened. Try again.';

  @override
  String get matchOkButton => 'OK';

  @override
  String get appTitle => 'Ink Lab';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOwned => 'Owned';

  @override
  String get commonFavourite => 'Favourite';

  @override
  String get commonAddToFavourites => 'Add to favourites';

  @override
  String get commonRemoveFromFavourites => 'Remove from favourites';

  @override
  String get commonClearSearch => 'Clear search';

  @override
  String get commonClose => 'Close';

  @override
  String get commonBaseLocked => 'Base locked';

  @override
  String commonDeltaE(double value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String valueString = valueNumberFormat.format(value);

    return 'ΔE $valueString';
  }

  @override
  String commonRgb(int r, int g, int b) {
    return 'RGB $r $g $b';
  }

  @override
  String commonOldCode(String code) {
    return 'Old $code';
  }

  @override
  String commonMarkersAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers available',
      one: '1 marker available',
    );
    return '$_temp0';
  }

  @override
  String commonColorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colours',
      one: '1 colour',
    );
    return '$_temp0';
  }

  @override
  String commonCardLocation(int number) {
    return 'Swatch card $number';
  }

  @override
  String navTabHint(int index, int count) {
    return 'Tab $index of $count';
  }

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String settingsOwnedCount(int owned, int total) {
    return '$owned of $total markers';
  }

  @override
  String settingsPacksSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count packs selected',
      one: '1 pack selected',
    );
    return '$_temp0';
  }

  @override
  String settingsPaletteDescription(String mode, String colors) {
    return '$mode · $colors';
  }

  @override
  String settingsImportUnsupportedVersion(int version) {
    return 'This backup has the unsupported version $version.';
  }

  @override
  String settingsImportFailed(String reason) {
    return 'The backup could not be imported: $reason';
  }

  @override
  String settingsAiOnDeviceProgressTotal(
    String bytes,
    String total,
    int percent,
  ) {
    return '$bytes of $total MB downloaded ($percent%)';
  }

  @override
  String settingsAiOnDeviceProgressBytes(String bytes) {
    return '$bytes MB downloaded';
  }

  @override
  String settingsAiConnectionOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count models',
      one: '1 model',
    );
    return 'Connection OK ($_temp0 available).';
  }

  @override
  String settingsAiConnectionFailed(String reason) {
    return 'Connection failed: $reason';
  }

  @override
  String settingsAiFallbacksCount(int count, int max) {
    return '$count of $max';
  }

  @override
  String settingsAiUseTyped(String id) {
    return 'Use \"$id\"';
  }

  @override
  String settingsAiFallbacksHint(int max) {
    return 'Tried in order when the model above fails (up to $max).';
  }

  @override
  String get settingsAiOnDeviceUnavailable =>
      'On-device AI is not available on this phone right now. Colour theory is used until it is.';

  @override
  String paletteSizeChip(int size) {
    return '$size colours';
  }

  @override
  String paletteAiLabel(String name) {
    return 'AI · $name';
  }

  @override
  String paletteAiLabelPartial(String name, int aiCount, int total) {
    return 'AI + colour theory · $name · $aiCount/$total';
  }

  @override
  String paletteResultTitle(int count) {
    return 'Combinations ($count)';
  }

  @override
  String paletteSavedSubtitle(String mode, int size) {
    return '$mode · $size colours';
  }

  @override
  String paletteSubtitleFrom(String mode, String base, String available) {
    return '$mode from $base · $available';
  }

  @override
  String paletteSubtitleScenario(String scenario, String available) {
    return '$scenario · $available';
  }

  @override
  String paletteSubtitleCustom(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers',
      one: '1 marker',
    );
    return 'Custom palette · $_temp0';
  }

  @override
  String paletteSavedNotice(String name) {
    return 'Palette \"$name\" saved.';
  }

  @override
  String paletteLoadedNotice(String name) {
    return 'Palette \"$name\" loaded.';
  }

  @override
  String paletteVariationApplied(String label) {
    return '$label variation applied.';
  }

  @override
  String paletteDraftApplied(int count) {
    return 'Ideas palette applied ($count colours).';
  }

  @override
  String paletteUsingDefaultBase(String code, String scenario) {
    return 'Using $code as the default base for $scenario. Enter a code to override it.';
  }

  @override
  String paletteUnknownCode(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': '$input is not a DecoTime marker code. Try $example.',
      'other': '$input is not an Ink Lab marker code. Try $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input is not in your collection. Try $example or add it in My collection.',
      'other':
          '$input is not in your collection. Try $example or add it in My collection.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'There are no DecoTime markers in your collection yet. Add them in My collection.',
      'other': 'There are no markers in your collection yet. Add them in My collection.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Pick a base marker, such as $example, or choose a scene with the Scenes chip.';
  }

  @override
  String swatchesFiltersCount(int count) {
    return 'Filters · $count';
  }

  @override
  String swatchesCodeCopied(String code) {
    return '$code copied. Paste it as the base colour on the Palette tab.';
  }

  @override
  String swatchesAlternativeSemantics(String code, String name, double value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String valueString = valueNumberFormat.format(value);

    return '$code, $name, delta E $valueString';
  }

  @override
  String swatchesCountOf(int visible, int total) {
    return '$visible of $total';
  }

  @override
  String swatchesOwnedSubtitle(String brand, int count) {
    return '$brand · $count owned';
  }

  @override
  String swatchesFilteredColorCount(int visible, int total) {
    return '$visible of $total colours';
  }

  @override
  String swatchesSwatchSemantics(String code, String name, String favorite) {
    String _temp0 = intl.Intl.selectLogic(favorite, {
      'true': '$code, $name, favourite',
      'other': '$code, $name',
    });
    return '$_temp0';
  }

  @override
  String swatchesClassicPack(String label) {
    return 'Classic $label';
  }

  @override
  String ideasPaletteSent(String title) {
    return 'The “$title” palette is ready in Palette.';
  }

  @override
  String matchSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers',
      one: '1 marker',
    );
    return 'Matching against your $_temp0';
  }

  @override
  String get matchQualityExcellent => 'Nearly exact';

  @override
  String get matchQualityVeryClose => 'Very close';

  @override
  String get matchQualityClose => 'Close';

  @override
  String get matchQualityFair => 'Rough';

  @override
  String get matchQualityApproximate => 'Far off';

  @override
  String matchRecorded(String code) {
    return '$code saved to recent picks.';
  }

  @override
  String get errDisabled => 'AI suggestions are turned off.';

  @override
  String get errMissingKey => 'No API key configured.';

  @override
  String get errNoModelSelected => 'No AI model selected.';

  @override
  String get errUnauthorized => 'The API key was rejected.';

  @override
  String get errPaymentRequired =>
      'The account has no credit or the key is out of quota.';

  @override
  String get errRateLimited =>
      'The provider is rate limiting requests. Try again shortly.';

  @override
  String get errServerError =>
      'The provider had a server error. Try again later.';

  @override
  String get errHttpError => 'The provider rejected the request.';

  @override
  String get errNetworkError =>
      'The provider could not be reached. Check the connection.';

  @override
  String get errInvalidJson => 'The provider returned an unreadable response.';

  @override
  String get errInvalidResponse => 'The provider returned no usable palette.';

  @override
  String get errNoValidSuggestions =>
      'The provider suggested colours that are not in the active collection.';

  @override
  String get errNoAvailableColors =>
      'There are no available markers to choose from.';

  @override
  String get errNoSuggestions => 'No suggestions could be generated.';

  @override
  String get errTimeout => 'The on-device model took too long. Try again.';

  @override
  String get errOnDeviceUnavailable =>
      'The on-device model is not ready on this phone.';

  @override
  String get errUnknown => 'AI suggestions are unavailable.';

  @override
  String errAiUnavailableWithReason(String reason) {
    return 'AI unavailable ($reason) Showing local suggestions.';
  }

  @override
  String get roleMainTone => 'Main tone';

  @override
  String get roleMidtone => 'Midtone';

  @override
  String get roleShadow => 'Shadow';

  @override
  String get roleHighlight => 'Highlight';

  @override
  String get roleBlend => 'Blend';

  @override
  String get roleToneA => 'Tone A';

  @override
  String get roleToneAShadow => 'Tone A shadow';

  @override
  String get roleToneB => 'Tone B';

  @override
  String get roleToneBShadow => 'Tone B shadow';

  @override
  String get roleBridge => 'Bridge';

  @override
  String get roleWarmBase => 'Warm base';

  @override
  String get roleWarmShadow => 'Warm shadow';

  @override
  String get roleSunlitAccent => 'Sunlit accent';

  @override
  String get roleDepthTone => 'Depth tone';

  @override
  String get roleCoolBase => 'Cool base';

  @override
  String get roleCoolShadow => 'Cool shadow';

  @override
  String get roleAtmosphere => 'Atmosphere';

  @override
  String get roleDeepCool => 'Deep cool';

  @override
  String get rolePastelBase => 'Pastel base';

  @override
  String get roleSoftShade => 'Soft shade';

  @override
  String get rolePastelHighlight => 'Pastel highlight';

  @override
  String get roleAccent => 'Accent';

  @override
  String get roleSupport => 'Support';

  @override
  String get roleNeonLead => 'Neon lead';

  @override
  String get roleNeonSecondary => 'Neon secondary';

  @override
  String get roleGlow => 'Glow';

  @override
  String get rolePopAccent => 'Pop accent';

  @override
  String get roleHue1 => 'Hue 1';

  @override
  String get roleHue2 => 'Hue 2';

  @override
  String get roleHue3 => 'Hue 3';

  @override
  String get roleHue4 => 'Hue 4';

  @override
  String get roleHue5 => 'Hue 5';

  @override
  String get roleUnexpectedLead => 'Unexpected lead';

  @override
  String get roleContrastPair => 'Contrast pair';

  @override
  String get roleTensionAccent => 'Tension accent';

  @override
  String get roleOffbeatSupport => 'Offbeat support';

  @override
  String get roleRandom1 => 'Random 1';

  @override
  String get roleRandom2 => 'Random 2';

  @override
  String get roleRandom3 => 'Random 3';

  @override
  String get roleRandom4 => 'Random 4';

  @override
  String get roleRandom5 => 'Random 5';

  @override
  String get roleLightValue => 'Light value';

  @override
  String get roleMidLight => 'Mid-light';

  @override
  String get roleMid => 'Mid';

  @override
  String get roleMidDark => 'Mid-dark';

  @override
  String get roleDarkValue => 'Dark value';

  @override
  String get roleWarmSideA => 'Warm side A';

  @override
  String get roleWarmSideB => 'Warm side B';

  @override
  String get roleCoolSideA => 'Cool side A';

  @override
  String get roleCoolSideB => 'Cool side B';

  @override
  String get roleBridgeTone => 'Bridge tone';

  @override
  String get roleSeasonLead => 'Season lead';

  @override
  String get roleSeasonSupport => 'Season support';

  @override
  String get roleFestiveRed => 'Festive red';

  @override
  String get roleEvergreen => 'Evergreen';

  @override
  String get roleGoldAccent => 'Gold accent';

  @override
  String get rolePineShadow => 'Pine shadow';

  @override
  String get roleSnowSupport => 'Snow support';

  @override
  String get roleRomanticLead => 'Romantic lead';

  @override
  String get roleRoseShadow => 'Rose shadow';

  @override
  String get roleSoftBlush => 'Soft blush';

  @override
  String get roleBalanceTone => 'Balance tone';

  @override
  String get roleBase => 'Base';

  @override
  String get roleGlowZone => 'Glow zone';

  @override
  String get rolePatternAccent => 'Pattern accent';

  @override
  String get roleContrastColor => 'Contrast colour';

  @override
  String get rolePrimary1 => 'Primary 1';

  @override
  String get rolePrimary2 => 'Primary 2';

  @override
  String get rolePrimary3 => 'Primary 3';

  @override
  String get roleSecondary => 'Secondary';

  @override
  String get roleSepiaLight => 'Sepia light';

  @override
  String get roleDustMidtone => 'Dust midtone';

  @override
  String get roleLeatherShadow => 'Leather shadow';

  @override
  String get roleAgedAccent => 'Aged accent';

  @override
  String get roleSmokeNeutral => 'Smoke neutral';

  @override
  String get roleHauntBase => 'Haunt base';

  @override
  String get rolePumpkinGlow => 'Pumpkin glow';

  @override
  String get roleNightShadow => 'Night shadow';

  @override
  String get roleEerieAccent => 'Eerie accent';

  @override
  String get roleFogSupport => 'Fog support';

  @override
  String get roleNightBase => 'Night base';

  @override
  String get roleDeepShadow => 'Deep shadow';

  @override
  String get roleMoonlitEdge => 'Moonlit edge';

  @override
  String get roleCoolAccent => 'Cool accent';

  @override
  String get roleMist => 'Mist';

  @override
  String get roleWaterBase => 'Water base';

  @override
  String get roleDepth => 'Depth';

  @override
  String get roleShadowWater => 'Shadow water';

  @override
  String get roleLightBeam => 'Light beam';

  @override
  String get roleBubbleHighlight => 'Bubble highlight';

  @override
  String get roleSpookyBase => 'Spooky base';

  @override
  String get roleColdShadow => 'Cold shadow';

  @override
  String get roleHauntedAccent => 'Haunted accent';

  @override
  String get roleEerieHighlight => 'Eerie highlight';

  @override
  String get roleFogTone => 'Fog tone';

  @override
  String get roleMysticBase => 'Mystic base';

  @override
  String get roleSpellShadow => 'Spell shadow';

  @override
  String get roleMagicalAccent => 'Magical accent';

  @override
  String get roleRuneGlow => 'Rune glow';

  @override
  String get roleMoodLead => 'Mood lead';

  @override
  String get roleMoodShadow => 'Mood shadow';

  @override
  String get roleEmotionAccent => 'Emotion accent';

  @override
  String get roleMaterialBase => 'Material base';

  @override
  String get rolePlaneShift => 'Plane shift';

  @override
  String get roleHardShadow => 'Hard shadow';

  @override
  String get roleSpecularEdge => 'Specular edge';

  @override
  String get rolePatinaAccent => 'Patina accent';

  @override
  String get roleSpaceBase => 'Space base';

  @override
  String get roleNebulaGlow => 'Nebula glow';

  @override
  String get roleDeepVoid => 'Deep void';

  @override
  String get roleStarAccent => 'Star accent';

  @override
  String get roleDustCloud => 'Dust cloud';

  @override
  String get roleGlassPaneA => 'Glass pane A';

  @override
  String get roleGlassPaneB => 'Glass pane B';

  @override
  String get roleGlassPaneC => 'Glass pane C';

  @override
  String get roleGlassPaneD => 'Glass pane D';

  @override
  String get roleLightHit => 'Light hit';

  @override
  String get roleShade => 'Shade';

  @override
  String get roleContrast => 'Contrast';

  @override
  String get roleSoftShadow => 'Soft shadow';

  @override
  String get roleBackground => 'Background';

  @override
  String get roleCompanionHue => 'Companion hue';

  @override
  String get rolePrimaryShadow => 'Primary shadow';

  @override
  String get roleMysticAccent => 'Mystic accent';

  @override
  String get roleSecondaryAccent => 'Secondary accent';

  @override
  String get rolePumpkinShadow => 'Pumpkin shadow';

  @override
  String get roleWitchyPurple => 'Witchy purple';

  @override
  String get roleToxicAccent => 'Toxic accent';

  @override
  String get roleNightBackground => 'Night background';

  @override
  String get roleRibbonRed => 'Ribbon red';

  @override
  String get rolePineDepth => 'Pine depth';

  @override
  String get roleSnowHighlight => 'Snow highlight';

  @override
  String get roleBudShadow => 'Bud shadow';

  @override
  String get roleBlossomTint => 'Blossom tint';

  @override
  String get roleFreshLeaf => 'Fresh leaf';

  @override
  String get roleDaffodilLight => 'Daffodil light';

  @override
  String get roleRainySky => 'Rainy sky';

  @override
  String get roleSkinSubjectShadow => 'Skin/subject shadow';

  @override
  String get roleWarmCompanion => 'Warm companion';

  @override
  String get roleNeutralBalance => 'Neutral balance';

  @override
  String get roleBarkShadow => 'Bark shadow';

  @override
  String get roleMapleRed => 'Maple red';

  @override
  String get roleOliveAccent => 'Olive accent';

  @override
  String get roleMorningMist => 'Morning mist';

  @override
  String get roleSubjectShadow => 'Subject shadow';

  @override
  String get roleCoolCompanion => 'Cool companion';

  @override
  String get roleAiryHighlight => 'Airy highlight';

  @override
  String get roleSnowShadow => 'Snow shadow';

  @override
  String get roleFrostHighlight => 'Frost highlight';

  @override
  String get roleEvergreenDepth => 'Evergreen depth';

  @override
  String get roleBerryAccent => 'Berry accent';

  @override
  String get roleTwilightSky => 'Twilight sky';

  @override
  String get roleGroundShadow => 'Ground shadow';

  @override
  String get roleSkyBlend => 'Sky blend';

  @override
  String get roleSunHighlight => 'Sun highlight';

  @override
  String get roleContrastAccent => 'Contrast accent';

  @override
  String get roleNeutralBuffer => 'Neutral buffer';

  @override
  String get rolePalmShadow => 'Palm shadow';

  @override
  String get roleCoralAccent => 'Coral accent';

  @override
  String get roleOceanSplash => 'Ocean splash';

  @override
  String get roleSunbeamHighlight => 'Sunbeam highlight';

  @override
  String get roleWarmSand => 'Warm sand';

  @override
  String get roleLeafShadow => 'Leaf shadow';

  @override
  String get roleMossMidtone => 'Moss midtone';

  @override
  String get roleSunlitLeaf => 'Sunlit leaf';

  @override
  String get roleTrunkAccent => 'Trunk accent';

  @override
  String get roleSkyFog => 'Sky/fog';

  @override
  String get rolePetalShadow => 'Petal shadow';

  @override
  String get rolePetalHighlight => 'Petal highlight';

  @override
  String get roleSecondaryPetal => 'Secondary petal';

  @override
  String get roleLeafAccent => 'Leaf accent';

  @override
  String get rolePatternBackground => 'Pattern background';

  @override
  String get roleToneC => 'Tone C';

  @override
  String get roleToneD => 'Tone D';

  @override
  String get roleNeutralLinework => 'Neutral linework';

  @override
  String get roleComplement => 'Complement';

  @override
  String get roleNeutral => 'Neutral';

  @override
  String get roleCompanion => 'Companion';

  @override
  String get reasonScenarioSupport => 'Scenario support';

  @override
  String get reasonBalancedPairing => 'Balanced pairing';

  @override
  String get reasonShadowDepth => 'Shadow depth';

  @override
  String get reasonSoftNearbyHue => 'Soft nearby hue';

  @override
  String get reasonControlledContrast => 'Controlled contrast';

  @override
  String get reasonHighlightLift => 'Highlight lift';

  @override
  String get reasonLocked => 'Locked';

  @override
  String get reasonVariationSupport => 'Variation support';

  @override
  String get reasonOppositeHueContrast => 'Opposite hue contrast';

  @override
  String get reasonSplitComplementContrast => 'Split complement contrast';

  @override
  String get reasonTriadBalance => 'Triad balance';

  @override
  String get reasonSquareHarmony => 'Square harmony';

  @override
  String get reasonRectangleHarmony => 'Rectangle harmony';

  @override
  String get reasonSameFamilyDeeperTone => 'Same family, deeper tone';

  @override
  String get reasonSameFamilyLighterTone => 'Same family, lighter tone';

  @override
  String get reasonManualPalette => 'Manual palette';

  @override
  String get reasonSupportTone => 'Support tone';

  @override
  String get reasonAISuggestion => 'AI suggestion';

  @override
  String get reasonLoadedPalette => 'Loaded palette';

  @override
  String get reasonAppliedFromIdeas => 'Applied from Ideas';

  @override
  String reasonNearbyHue(int degrees) {
    return 'Nearby hue harmony (${degrees}deg)';
  }

  @override
  String reasonShadowTone(int percent) {
    return 'Shadow tone ($percent% darker)';
  }

  @override
  String reasonVariation(String prefix, String reason) {
    return '$prefix: $reason';
  }

  @override
  String get variationPrefixVibrant => 'Vibrant';

  @override
  String get variationPrefixSoft => 'Soft';

  @override
  String get variationPrefixContrast => 'Contrast';

  @override
  String get variationPrefixWarm => 'Warm';

  @override
  String get variationPrefixCool => 'Cool';

  @override
  String get variationLabelMoreVibrant => 'More vibrant';

  @override
  String get variationLabelSofter => 'Softer';

  @override
  String get variationLabelHigherContrast => 'Higher contrast';

  @override
  String get variationLabelWarmer => 'Warmer';

  @override
  String get variationLabelCooler => 'Cooler';

  @override
  String get modeRecommended => 'Recommended';

  @override
  String get modeComplementary => 'Complementary';

  @override
  String get modeAnalogous => 'Analogous';

  @override
  String get modeSplitComplementary => 'Split Complementary';

  @override
  String get modeTriad => 'Triad';

  @override
  String get modeSquare => 'Square';

  @override
  String get modeRectangle => 'Rectangle';

  @override
  String get modeMonochrome => 'Monochrome';

  @override
  String get modeCustomPalette => 'Custom Palette';

  @override
  String get modeShadow => 'Shadow';

  @override
  String get scenarioGhostCharacter => 'Ghost Character';

  @override
  String get scenarioCuteCharacter => 'Cute Character';

  @override
  String get scenarioFantasyCreature => 'Fantasy Creature';

  @override
  String get scenarioWarmPortrait => 'Warm Portrait';

  @override
  String get scenarioCoolPortrait => 'Cool Portrait';

  @override
  String get scenarioSunsetLandscape => 'Sunset Landscape';

  @override
  String get scenarioForestScene => 'Forest Scene';

  @override
  String get scenarioOceanScene => 'Ocean Scene';

  @override
  String get scenarioAutumnScene => 'Autumn Scene';

  @override
  String get scenarioSpringGarden => 'Spring Garden';

  @override
  String get scenarioCozyInterior => 'Cozy Interior';

  @override
  String get scenarioVintageRoom => 'Vintage Room';

  @override
  String get scenarioPastelDream => 'Pastel Dream';

  @override
  String get scenarioNeonNight => 'Neon Night';

  @override
  String get scenarioMoodyNight => 'Moody Night';

  @override
  String get scenarioFloralPattern => 'Floral Pattern';

  @override
  String get scenarioGeometricPattern => 'Geometric Pattern';

  @override
  String get scenarioPlaidPattern => 'Plaid Pattern';

  @override
  String get scenarioPolkaDotPattern => 'Polka Dot Pattern';

  @override
  String get scenarioCandyStripes => 'Candy Stripes';

  @override
  String get scenarioHalloweenMood => 'Halloween Mood';

  @override
  String get scenarioChristmasMood => 'Christmas Mood';

  @override
  String get scenarioSpringMood => 'Spring Mood';

  @override
  String get scenarioSummerMood => 'Summer Mood';

  @override
  String get scenarioAutumnMood => 'Autumn Mood';

  @override
  String get scenarioWinterMood => 'Winter Mood';

  @override
  String get scenarioWinterSnow => 'Winter Snow';

  @override
  String get packLabel120New => '120 New';

  @override
  String get packLabel36Skin => '36 Skin';

  @override
  String get packLabel36Gray => '36 Gray';

  @override
  String get packLabel48Pastel => '48 Pastel';

  @override
  String get categorySignature => 'Signature';

  @override
  String get categoryChallenges => 'Challenges';

  @override
  String get categoryAtmosphere => 'Atmosphere';

  @override
  String get settingsLinesTitle => 'Lines you own';

  @override
  String get settingsLinesHint =>
      'Pick every Ohuhu line you own. Turning a line off removes its packs from your selection.';

  @override
  String settingsLineSelectedOfTotal(int selected, int total) {
    return '$selected of $total packs selected';
  }

  @override
  String settingsCurrentPacks(int count) {
    return 'Current packs ($count)';
  }

  @override
  String settingsLegacyPacks(int count) {
    return 'Older / community packs ($count)';
  }

  @override
  String get settingsLegacyPacksNote =>
      'Pack list from the community; may no longer be sold.';

  @override
  String settingsPackColorsSemantics(String pack, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colours',
      one: '1 colour',
    );
    return '$pack, $_temp0';
  }

  @override
  String get swatchesLines => 'Lines';

  @override
  String get swatchesLabelLine => 'Line';

  @override
  String get swatchesAllLines => 'All lines';

  @override
  String get swatchesLegacyPacks => 'Older sets';

  @override
  String packLabelSkin(String n) {
    return '$n Skin';
  }

  @override
  String packLabelPastel(String n) {
    return '$n Pastel';
  }

  @override
  String packLabelPastels(String n) {
    return '$n Pastels';
  }

  @override
  String packLabelBasic(String n) {
    return '$n Basic';
  }

  @override
  String packLabelIllustration(String n) {
    return '$n Illustration';
  }

  @override
  String packLabelLandscape(String n) {
    return '$n Landscape';
  }

  @override
  String packLabelSweetPastels(String n) {
    return '$n Sweetness Pastels';
  }

  @override
  String packLabelMidTones(String n) {
    return '$n Mid-Tones';
  }

  @override
  String packLabelBlossomPastels(String n) {
    return '$n Blossoming Pastels';
  }

  @override
  String packLabelWhiteCase(String n) {
    return 'White Case $n';
  }

  @override
  String packLabelWhiteCaseVersion(String n, String v) {
    return 'White Case $n (V$v)';
  }

  @override
  String packLabelJapanVersion(String n, String v) {
    return 'Japan $n (V$v)';
  }

  @override
  String packFullLabel(String line, String pack) {
    return '$line $pack';
  }

  @override
  String swatchesMorePacks(int count) {
    return '+$count more';
  }

  @override
  String get settingsMatchingGroup => 'Colour matching';

  @override
  String get settingsMatchSuggestUnowned => 'Show the whole range';

  @override
  String get settingsMatchSuggestUnownedSubtitle =>
      'When none of your markers is close, Match also shows the closest one of the whole range.';

  @override
  String get settingsSetupAgain => 'Run the setup again';

  @override
  String get matchNoCloseMatch => 'No close match in your markers.';

  @override
  String matchRangeTitle(String brand) {
    return 'Whole $brand range';
  }

  @override
  String get matchNotOwnedBadge => 'You don\'t own it';

  @override
  String get matchSubtitleEmpty => 'No markers in your collection yet';

  @override
  String swatchesWholeRangeNotice(String brand) {
    return 'Showing the whole $brand range';
  }

  @override
  String get swatchesWholeRangeAction => 'Set up';

  @override
  String matchWholeRangeBody(String brand) {
    return 'Until you set up your collection, matching uses the whole $brand range.';
  }

  @override
  String get matchWholeRangeAction => 'Go to My collection';

  @override
  String get collectionTitle => 'My collection';

  @override
  String collectionMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers',
      one: '1 marker',
      zero: 'No markers',
    );
    return '$_temp0';
  }

  @override
  String collectionSets(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sets',
      one: '1 set',
    );
    return '$_temp0';
  }

  @override
  String get collectionNotSetUp => 'Not set up yet';

  @override
  String get collectionSeriesTitle => 'Series you own';

  @override
  String get collectionHonoluluNote =>
      'Honolulu B, Honolulu S and Honolulu² use the same colour codes as Honolulu; only the tips differ.';

  @override
  String get collectionSetsTitle => 'Sets you own';

  @override
  String get collectionSetsEmpty => 'Pick a series to see its sets.';

  @override
  String collectionOlderSets(int count) {
    return 'Older sets ($count)';
  }

  @override
  String get collectionOlderSetsNote =>
      'Discontinued or regional editions, from community data.';

  @override
  String get collectionExtrasTitle => 'Extra markers';

  @override
  String get collectionExtrasHint =>
      'Bought single markers? Tick them here. Markers in your sets already count.';

  @override
  String get collectionDecoMarkersTitle => 'Your markers';

  @override
  String get collectionDecoHint =>
      'DecoTime does not publish which colours each set holds, so tick the ones you own or add a whole family.';

  @override
  String get collectionDecoSizesHint =>
      'Action sells DecoTime sets of 100, 150, 160, 200 and 300 markers.';

  @override
  String get collectionFamiliesTitle => 'Add by family';

  @override
  String collectionFamilyChip(String family, int owned, int total) {
    return '$family $owned/$total';
  }

  @override
  String get collectionFamilyColours => 'Colours';

  @override
  String get collectionFamilyWarmGrey => 'Warm greys';

  @override
  String get collectionFamilyCoolGrey => 'Cool greys';

  @override
  String get collectionFamilyBlueGrey => 'Blue greys';

  @override
  String get collectionFamilyGreenGrey => 'Green greys';

  @override
  String get collectionDecoRange => 'DecoTime range';

  @override
  String get collectionWholeRange => 'Whole range';

  @override
  String get collectionSearchHint => 'Search code or name';

  @override
  String get collectionTickVisible => 'Tick all';

  @override
  String get collectionUntickVisible => 'Untick all';

  @override
  String get collectionInYourSets => 'In your set';

  @override
  String get collectionNoResults => 'No marker matches the search.';

  @override
  String get collectionReset => 'Reset collection';

  @override
  String collectionResetTitle(String brand) {
    return 'Reset your $brand collection?';
  }

  @override
  String get collectionResetBody =>
      'Your sets and extra markers of this brand are removed. Favourites and palettes stay.';

  @override
  String collectionOwnedCount(int owned, int total) {
    return '$owned of $total';
  }

  @override
  String get onboardingWelcomeTitle => 'Welcome to Ink Lab';

  @override
  String get onboardingWelcomeBody =>
      'Browse your markers, match colours from photos and build palettes. First, tell us which markers you have.';

  @override
  String get onboardingOhuhuLine => 'Sets by series: Oahu, Honolulu, Kaala';

  @override
  String get onboardingDecoLine => 'One range of 313 colours, sets at Action';

  @override
  String get onboardingSeriesTitle => 'Which series do you have?';

  @override
  String get onboardingSeriesBody => 'Pick every series you have markers from.';

  @override
  String get onboardingSetsTitle => 'Which sets do you have?';

  @override
  String get onboardingSetsBody =>
      'Pick the boxes you bought. Extra markers can be added later.';

  @override
  String get onboardingDecoTitle => 'Your DecoTime markers';

  @override
  String get onboardingDoneTitle => 'All set';

  @override
  String get onboardingLaterNote =>
      'You can change this later in My collection.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingBack => 'Back';

  @override
  String get onboardingFinish => 'Start';

  @override
  String onboardingStep(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get collectionSeriesOahuTips => 'Fine and chisel tips';

  @override
  String get collectionSeriesHonoluluTips => 'Brush and chisel tips';

  @override
  String get collectionSeriesKaalaTips => 'Brush tip';

  @override
  String get collectionSummaryNoSets =>
      'You have not picked any sets yet: the whole range is used';

  @override
  String get collectionSummaryNoMarkers =>
      'You have not ticked any markers yet';

  @override
  String get collectionExtrasAddTitle => 'Add loose markers';

  @override
  String get collectionDecoMarkersButton => 'Tick your markers';

  @override
  String collectionExtrasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count loose markers',
      one: '1 loose marker',
      zero: 'No loose markers',
    );
    return '$_temp0';
  }

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Until you pick sets, the app shows the whole $brand range.';
  }

  @override
  String get onboardingDoneNoMarkers =>
      'You have not ticked any DecoTime markers yet: tick them in My collection.';

  @override
  String get onboardingDoneNext =>
      'What next: browse colours in Swatches, match a photo in Match or build a palette in Palette.';

  @override
  String get collectionVisibleScope =>
      'Applies to the markers that match your search.';
}
