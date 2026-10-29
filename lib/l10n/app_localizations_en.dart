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
  String get settingsCollectionGroup => 'Collection';

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
  String get settingsBrandDecoTimeHint =>
      'DecoTime shows only the markers you mark as owned.';

  @override
  String get settingsBrandSubtitle =>
      'The brand selects the catalogue of markers the app works with.';

  @override
  String get settingsPacksTitle => 'Ohuhu packs';

  @override
  String get settingsPacksSubtitle =>
      'The packs that make up your Ohuhu collection.';

  @override
  String get settingsPackMode => 'Pack selection';

  @override
  String get settingsSinglePackHint =>
      'With a single pack only the first selected pack is used.';

  @override
  String get settingsCorePacks => 'Core packs';

  @override
  String get settingsAddonPacks => 'Add-on packs';

  @override
  String get settingsOwnedTitle => 'Owned markers';

  @override
  String get settingsOwnedSubtitle =>
      'Tick the markers you own. DecoTime only shows the colors of the markers you own.';

  @override
  String get settingsOwnedSearchHint => 'Search markers';

  @override
  String get settingsSelectAll => 'Select all';

  @override
  String get settingsSelectNone => 'Select none';

  @override
  String get settingsClearOwned => 'Clear all';

  @override
  String get settingsClearOwnedTitle => 'Remove every owned marker?';

  @override
  String get settingsClearOwnedBody =>
      'The markers you own will be forgotten. You can tick them again afterwards.';

  @override
  String get settingsOwnedEmpty =>
      'No marker is owned yet. Tick the ones you have.';

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
  String get settingsFavoritesTitle => 'Favorites';

  @override
  String get settingsFavoritesEmpty => 'No color is a favorite yet.';

  @override
  String get settingsClearFavorites => 'Clear all';

  @override
  String get settingsClearFavoritesTitle => 'Remove every favorite?';

  @override
  String get settingsClearFavoritesBody =>
      'The favorite colors of this brand will be removed. This cannot be undone.';

  @override
  String get settingsDeleteFavorite => 'Remove the favorite';

  @override
  String get settingsLabelsTitle => 'Name display';

  @override
  String get settingsLabelsSubtitle =>
      'How the marker codes and names are shown in the app.';

  @override
  String get settingsNewLabels => 'New';

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
      'The backup replaces your settings, your saved palettes, your color match history and your AI settings.';

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
  String get settingsAiAutoFallback => 'Fall back to colour theory';

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
  String get settingsCopyRepository => 'Copy the link';

  @override
  String get settingsRepositoryCopied => 'The link was copied';

  @override
  String get settingsDisclaimer =>
      'Ink Lab is an independent community project: it is not affiliated with, endorsed by or sponsored by Ohuhu or DecoTime, and it uses their marker codes, names and color values only as factual reference data.';

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
  String get paletteScenarioTitle => 'Scenarios';

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
      'Block the overall shape with the base color first.';

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
      'Enter a base marker code to build a palette, or turn on Scenario mode.';

  @override
  String get paletteCustomModeHint =>
      'Custom palette mode is manual: load a saved palette or apply one from Ideas.';

  @override
  String get paletteNoSuggestions =>
      'No palette could be built from your collection. Try another mode or add more markers.';

  @override
  String get swatchesTitle => 'Swatches';

  @override
  String get swatchesSearchHint => 'Code, name, hex or old code';

  @override
  String get swatchesClearSearch => 'Clear the search';

  @override
  String get swatchesAllFilter => 'All';

  @override
  String get swatchesFavoritesOnly => 'Favourites';

  @override
  String get swatchesOwnedOnly => 'Owned';

  @override
  String get swatchesFilters => 'Filters';

  @override
  String get swatchesFiltersTitle => 'Filters';

  @override
  String get swatchesLabelPack => 'Pack';

  @override
  String get swatchesLabelLayout => 'Layout';

  @override
  String get swatchesAllPacks => 'All packs';

  @override
  String get swatchesClearFilters => 'Clear filters';

  @override
  String get swatchesLoadingSemantics => 'Loading colours';

  @override
  String get swatchesClosestAlternatives => 'Closest alternatives';

  @override
  String get swatchesDeltaEUnit => 'ΔE 76';

  @override
  String get swatchesInPacks => 'In packs';

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
  String get swatchesAddFavorite => 'Add to favorites';

  @override
  String get swatchesRemoveFavorite => 'Remove from favorites';

  @override
  String get swatchesEmptyNoOwnedTitle => 'No markers added yet';

  @override
  String get swatchesEmptyNoOwnedBody =>
      'DecoTime swatches only show the markers you own. Add the markers you have in Settings, in the owned markers manager, and their colours will show up here.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Add my markers';

  @override
  String get swatchesEmptyNoOwnedHint =>
      'Open the Settings tab and use the owned markers manager.';

  @override
  String get swatchesEmptySearchTitle => 'No colors found';

  @override
  String get swatchesEmptySearchBody =>
      'No color of this collection matches your search.';

  @override
  String get swatchesEmptyFiltersTitle => 'Nothing to show';

  @override
  String get swatchesEmptyFiltersBody =>
      'This brand has no colors for the selected packs and filters.';

  @override
  String get swatchesLoading => 'Loading colors…';

  @override
  String get swatchesLoadFailedTitle => 'Colors unavailable';

  @override
  String get swatchesLoadFailedBody =>
      'The marker catalogue could not be read, so no colors can be shown.';

  @override
  String get swatchesUnavailable =>
      'The app services are not available, so the swatches cannot be shown.';

  @override
  String get swatchesVisibleCount => 'Colors';

  @override
  String get swatchesScopeCollection => 'Your collection';

  @override
  String get swatchesScopePack => 'Pack';

  @override
  String get ideasTitle => 'Ideas';

  @override
  String get ideasHeaderSubtitle => 'Guides and challenges for your markers';

  @override
  String get ideasSelectedLabel => 'Selected';

  @override
  String get ideasSearchHint => 'Search ideas';

  @override
  String get ideasCategoryAll => 'All';

  @override
  String get ideasBadgeGuideOnly => 'Guide only';

  @override
  String get ideasBadgeGuideAndPalette => 'Guide + palette';

  @override
  String get ideasShowTechnique => 'Show technique';

  @override
  String get ideasGenerateIdea => 'Generate idea';

  @override
  String get ideasApplyButton => 'Apply to Palette';

  @override
  String get ideasHowToTitle => 'How to execute';

  @override
  String get ideasExtraTouchesTitle => 'Extra touches';

  @override
  String get ideasSuggestedColorsTitle => 'Suggested colors';

  @override
  String get ideasGuideOnlyNote =>
      'This idea is intentionally technique-first. It does not enforce a fixed palette, so you can choose colors freely.';

  @override
  String get ideasNoMarkersDecoTime =>
      'Select your owned DecoTime markers in Settings to generate color suggestions for this idea.';

  @override
  String get ideasNoMarkersOther =>
      'No markers available for the current collection filters.';

  @override
  String get ideasCategoriesLabel => 'Categories';

  @override
  String get ideasEmptyTitle => 'No ideas found';

  @override
  String get ideasClearFilters => 'Clear filters';

  @override
  String get ideasEmptySearch => 'No ideas match your search.';

  @override
  String get ideasSelectHint => 'Pick an idea to see how to execute it.';

  @override
  String get ideasNoMarkers => 'No markers currently available';

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
  String get matchNoMarkers =>
      'No markers are available for the current collection. Check the active brand and sets in Settings.';

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
      other: '$count colors',
      one: '1 color',
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
    return '$size colors';
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
    return '$mode · $size colors';
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
    return 'Ideas palette applied ($count colors).';
  }

  @override
  String paletteUsingDefaultBase(String code, String scenario) {
    return 'Using $code as the default base for $scenario. Enter a code to override it.';
  }

  @override
  String paletteUnknownCode(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input is not a DecoTime marker code. Try $example or check your owned markers in Settings.',
      'other': '$input is not an Ink Lab marker code. Try $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input is not in your owned DecoTime markers. Try $example or update Owned markers in Settings.',
      'other':
          '$input is not in your active collection. Try $example or switch sets in Settings.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'No DecoTime markers are selected. Go to Settings > Collection > Owned markers and select the markers you own.',
      'other': 'No markers are available for the current collection filters.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Enter a base marker code, like $example, or turn on Scenario mode.';
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
    return '$visible of $total colors';
  }

  @override
  String swatchesSwatchSemantics(String code, String name, String favorite) {
    String _temp0 = intl.Intl.selectLogic(favorite, {
      'true': '$code, $name, favorite',
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
    return '\"$title\" palette sent to the Palette tab.';
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
  String get matchQualityExcellent => 'Excellent';

  @override
  String get matchQualityVeryClose => 'Very close';

  @override
  String get matchQualityClose => 'Close';

  @override
  String get matchQualityFair => 'Fair';

  @override
  String get matchQualityApproximate => 'Approximate';

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
  String get roleContrastColor => 'Contrast color';

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
  String get packModeSinglePack => 'Single pack';

  @override
  String get packModeComparePacks => 'Compare packs';

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
  String get ideaStickerEffectTitle => 'Sticker Effect';

  @override
  String get ideaStickerEffectSummary =>
      'Make subjects look like cut-out stickers using a white halo and black outer outline.';

  @override
  String get ideaStickerEffectOverview =>
      'Technique-first challenge. The illusion comes from edge treatment, not from a specific palette.';

  @override
  String get ideaStickerEffectStep1 => 'Color the main subject normally first.';

  @override
  String get ideaStickerEffectStep2 =>
      'Add a clean white halo around the full silhouette.';

  @override
  String get ideaStickerEffectStep3 =>
      'Trace the outside edge of that white halo with a black line.';

  @override
  String get ideaStickerEffectStep4 =>
      'Optional: add a tiny drop shadow under one side to make it pop.';

  @override
  String get ideaStickerEffectEmbellishment1 =>
      'Keep halo width consistent for a cleaner cut-out look.';

  @override
  String get ideaStickerEffectEmbellishment2 =>
      'If edges feel noisy, smooth with white pen before black contour.';

  @override
  String get ideaPolaroidFrameTitle => 'Polaroid Frame';

  @override
  String get ideaPolaroidFrameSummary =>
      'Draw a Polaroid frame, color only inside it, and keep everything outside in grayscale.';

  @override
  String get ideaPolaroidFrameOverview =>
      'Build a fake instant-photo composition. The interior gets full color while the rest stays in controlled grayscale.';

  @override
  String get ideaPolaroidFrameStep1 =>
      'Sketch a Polaroid frame with a wider bottom border.';

  @override
  String get ideaPolaroidFrameStep2 =>
      'Block everything outside the frame using 2-3 grayscale values.';

  @override
  String get ideaPolaroidFrameStep3 =>
      'Color only the interior photo window with your subject colors.';

  @override
  String get ideaPolaroidFrameStep4 =>
      'Add a subtle frame shadow so the photo appears on top of the page.';

  @override
  String get ideaPolaroidFrameEmbellishment1 =>
      'Write a tiny date caption on the bottom frame for realism.';

  @override
  String get ideaPolaroidFrameEmbellishment2 =>
      'Make outside grayscale slightly cooler to boost interior warmth.';

  @override
  String get ideaSpotlightTitle => 'Spotlight';

  @override
  String get ideaSpotlightSummary =>
      'Create a strong focal light with dark edges and smooth value falloff.';

  @override
  String get ideaSpotlightOverview =>
      'Direct attention with value contrast: bright center, dark perimeter, and clear light falloff.';

  @override
  String get ideaSpotlightStep1 =>
      'Mark the spotlight center before laying color.';

  @override
  String get ideaSpotlightStep2 =>
      'Keep the focal zone bright and high-contrast.';

  @override
  String get ideaSpotlightStep3 =>
      'Darken values gradually as you move away from the center.';

  @override
  String get ideaSpotlightStep4 =>
      'Finish with a soft vignette around page edges.';

  @override
  String get ideaSpotlightEmbellishment1 =>
      'Use harder edges near the focal point, softer edges far away.';

  @override
  String get ideaSpotlightEmbellishment2 =>
      'Avoid bright accents in corners so focus stays centered.';

  @override
  String get ideaOneColorTitle => 'One Color';

  @override
  String get ideaOneColorSummary =>
      'Use a single hue family and control contrast only through value and saturation.';

  @override
  String get ideaOneColorOverview =>
      'One hue, many values. Depth comes from shifts in lightness and saturation, not hue variety.';

  @override
  String get ideaOneColorStep1 =>
      'Choose one dominant hue family for the full piece.';

  @override
  String get ideaOneColorStep2 =>
      'Separate planes with value shifts, not hue shifts.';

  @override
  String get ideaOneColorStep3 =>
      'Reserve highest contrast for your focal element.';

  @override
  String get ideaOneColorStep4 =>
      'Use saturation variation to avoid flat areas.';

  @override
  String get ideaOneColorEmbellishment1 =>
      'Use texture shifts to separate materials when hue variety is limited.';

  @override
  String get ideaOneColorEmbellishment2 =>
      'Keep one micro-accent at the brightest value for focal clarity.';

  @override
  String get ideaTwoColorsTitle => 'Two Colors';

  @override
  String get ideaTwoColorsSummary =>
      'Build the scene using only two dominant hue families plus subtle support tones.';

  @override
  String get ideaTwoColorsOverview =>
      'Restrict the scene to two hue families and let contrast come from value, not palette breadth.';

  @override
  String get ideaTwoColorsStep1 =>
      'Assign each major area to one of the two hue families.';

  @override
  String get ideaTwoColorsStep2 =>
      'Keep transitions clean to preserve the two-tone concept.';

  @override
  String get ideaTwoColorsStep3 => 'Use one neutral bridge only where needed.';

  @override
  String get ideaTwoColorsStep4 => 'Keep one hue dominant and one supporting.';

  @override
  String get ideaTwoColorsEmbellishment1 =>
      'Let one hue occupy larger shapes and the second hue act as accent.';

  @override
  String get ideaTwoColorsEmbellishment2 =>
      'If harmony breaks, add a low-saturation bridge tone in transitions.';

  @override
  String get ideaFiftyFiftyTitle => '50/50 Split';

  @override
  String get ideaFiftyFiftySummary =>
      'Split the composition in two moods. One side warm, the other cool, with a bridge color.';

  @override
  String get ideaFiftyFiftyOverview =>
      'Compose two distinct moods in one image. Keep each side coherent and blend with one bridge tone.';

  @override
  String get ideaFiftyFiftyStep1 =>
      'Split the page vertically or horizontally.';

  @override
  String get ideaFiftyFiftyStep2 =>
      'Assign warm hues to one side and cool hues to the other.';

  @override
  String get ideaFiftyFiftyStep3 =>
      'Use one bridge tone at the boundary so the split feels intentional.';

  @override
  String get ideaFiftyFiftyStep4 =>
      'Keep each half internally consistent in value and saturation.';

  @override
  String get ideaFiftyFiftyEmbellishment1 =>
      'Mirror one small motif on both halves to tie the concept together.';

  @override
  String get ideaFiftyFiftyEmbellishment2 =>
      'Keep one side slightly darker to avoid visual symmetry fatigue.';

  @override
  String get ideaWarmColorsTitle => 'Warm Colors';

  @override
  String get ideaWarmColorsSummary =>
      'Use only warm hues for an energetic, cozy, sunlit scene.';

  @override
  String get ideaWarmColorsOverview =>
      'Warm hues carry energy and intimacy. Keep shadows warm instead of neutral gray.';

  @override
  String get ideaCoolColorsTitle => 'Cool Colors';

  @override
  String get ideaCoolColorsSummary =>
      'Use cool hues for calm, depth, and atmospheric distance.';

  @override
  String get ideaCoolColorsOverview =>
      'Cool hues create depth and calm. Control value steps to avoid a flat finish.';

  @override
  String get ideaPastelTitle => 'Pastel';

  @override
  String get ideaPastelSummary =>
      'Light value and low saturation for a soft, dreamy finish.';

  @override
  String get ideaPastelOverview =>
      'Pastel scenes rely on value control and subtle contrast more than hue intensity.';

  @override
  String get ideaNeonTitle => 'Neon';

  @override
  String get ideaNeonSummary =>
      'High-energy, vivid colors that pop against dark support tones.';

  @override
  String get ideaNeonOverview =>
      'Neon needs contrast. Reserve at least one dark support area so bright accents can glow.';

  @override
  String get ideaRainbowTitle => 'Rainbow';

  @override
  String get ideaRainbowSummary =>
      'Distribute hue families across the artwork while keeping values controlled.';

  @override
  String get ideaRainbowOverview =>
      'Use broad hue coverage but keep one dominant hue family so the piece still feels unified.';

  @override
  String get ideaUnlikelyColorsTitle => 'Unlikely Colors';

  @override
  String get ideaUnlikelyColorsSummary =>
      'Try unexpected color pairings to make ordinary subjects feel stylized.';

  @override
  String get ideaUnlikelyColorsOverview =>
      'Unexpected combinations can feel intentional when value hierarchy stays clear.';

  @override
  String get ideaRandomColorsTitle => 'Random Colors';

  @override
  String get ideaRandomColorsSummary =>
      'Use a randomized palette and force cohesion through value planning.';

  @override
  String get ideaRandomColorsOverview =>
      'Random palettes look coherent if you keep one focal area and controlled contrast.';

  @override
  String get ideaGrayscaleTitle => 'Grayscale';

  @override
  String get ideaGrayscaleSummary =>
      'Work in values only to improve depth and contrast control.';

  @override
  String get ideaGrayscaleOverview =>
      'Limit color information and focus on depth, hierarchy, and material separation through value only.';

  @override
  String get ideaSeasonalTitle => 'Seasonal';

  @override
  String get ideaSeasonalSummary =>
      'Blend spring, summer, autumn, or winter cues into a cohesive palette.';

  @override
  String get ideaSeasonalOverview =>
      'Seasonal palettes work best when one season dominates and others support the mood.';

  @override
  String get ideaChristmasTitle => 'Christmas';

  @override
  String get ideaChristmasSummary =>
      'Classic red-green-gold range for festive contrast and cozy highlights.';

  @override
  String get ideaChristmasOverview =>
      'Classic holiday balance: warm highlights, rich reds/greens, and selective bright accents.';

  @override
  String get ideaValentinesTitle => 'Valentine\'s Day';

  @override
  String get ideaValentinesSummary =>
      'Romantic reds and pinks with soft highlights and warm transitions.';

  @override
  String get ideaValentinesOverview =>
      'Romantic harmony comes from warm transitions and gentle highlight placement.';

  @override
  String get ideaWhiteEffectsTitle => 'White Effects';

  @override
  String get ideaWhiteEffectsSummary =>
      'Plan the palette to leave room for white-pen sparkles and shine accents.';

  @override
  String get ideaWhiteEffectsOverview =>
      'Reserve whitespace and bright value zones so white-ink effects read clearly.';

  @override
  String get ideaWhiteEffectsEmbellishment1 =>
      'Use white pen for sparkles on metal, eyes, and water reflections.';

  @override
  String get ideaWhiteEffectsEmbellishment2 =>
      'Dot highlights in clusters, not evenly, for natural shine.';

  @override
  String get ideaBlackEffectsTitle => 'Black Effects';

  @override
  String get ideaBlackEffectsSummary =>
      'Use black line details, dots, and pattern overlays to enhance contrast.';

  @override
  String get ideaBlackEffectsOverview =>
      'Plan midtone areas where black pen details can add texture and graphic punch.';

  @override
  String get ideaBlackEffectsEmbellishment1 =>
      'Use black dots/stripes to add texture after color layers dry.';

  @override
  String get ideaBlackEffectsEmbellishment2 =>
      'Concentrate black details near focal areas for stronger emphasis.';

  @override
  String get ideaCrayonsOnlyTitle => 'Crayons Only';

  @override
  String get ideaCrayonsOnlySummary =>
      'Simple bold palette that mimics classic crayon behavior and texture.';

  @override
  String get ideaCrayonsOnlyOverview =>
      'Crayon style favors simple blocks, bold primaries, and visible stroke texture.';

  @override
  String get ideaOldWestTitle => 'Old West';

  @override
  String get ideaOldWestSummary =>
      'Dusty sepia range with muted warmth, like an aged Western print.';

  @override
  String get ideaOldWestOverview =>
      'Aged-photo atmosphere with dusty mids, muted warms, and restrained highlights.';

  @override
  String get ideaOldWestStep1 => 'Lay a sepia-like base across major areas.';

  @override
  String get ideaOldWestStep2 =>
      'Use dusty midtones and avoid highly saturated accents.';

  @override
  String get ideaOldWestStep3 =>
      'Push shadows with muted browns instead of pure black.';

  @override
  String get ideaOldWestStep4 =>
      'Reserve highlights for worn edges and sun hit points.';

  @override
  String get ideaOldWestEmbellishment1 =>
      'Add subtle grain dots in empty regions for aged texture.';

  @override
  String get ideaOldWestEmbellishment2 =>
      'Use broken edges on highlights to mimic worn print paper.';

  @override
  String get ideaHorrorHalloweenTitle => 'Horror/Halloween';

  @override
  String get ideaHorrorHalloweenSummary =>
      'Dark values and eerie accents to transform normal scenes into spooky mood.';

  @override
  String get ideaHorrorHalloweenOverview =>
      'Push darkness and selective eerie accents to convert normal scenes into unsettling ones.';

  @override
  String get ideaHorrorHalloweenStep1 =>
      'Drop overall value to establish darkness first.';

  @override
  String get ideaHorrorHalloweenStep2 =>
      'Place eerie accent hues only near focal shapes.';

  @override
  String get ideaHorrorHalloweenStep3 => 'Use harder edge shadows for tension.';

  @override
  String get ideaHorrorHalloweenStep4 =>
      'Keep bright highlights sparse and directional.';

  @override
  String get ideaHorrorHalloweenEmbellishment1 =>
      'Add subtle color noise in shadows for unsettling texture.';

  @override
  String get ideaHorrorHalloweenEmbellishment2 =>
      'Use one sharp high-contrast edge to create visual tension.';

  @override
  String get ideaMidnightTitle => 'Midnight';

  @override
  String get ideaMidnightSummary =>
      'Turn daytime scenes into night by pushing cool shadows and selective highlights.';

  @override
  String get ideaMidnightOverview =>
      'Night conversion depends on cooler shadows, lower values, and sparse light accents.';

  @override
  String get ideaMidnightStep1 =>
      'Convert warm daytime areas into cooler night tones.';

  @override
  String get ideaMidnightStep2 =>
      'Push sky/background values darker than midground.';

  @override
  String get ideaMidnightStep3 => 'Add moonlight accents on top-facing edges.';

  @override
  String get ideaMidnightStep4 =>
      'Soften distant elements to increase nocturnal depth.';

  @override
  String get ideaMidnightEmbellishment1 =>
      'Keep highlights cool and sparse to avoid reintroducing daytime feel.';

  @override
  String get ideaMidnightEmbellishment2 =>
      'Darken corners more than center to create natural nighttime framing.';

  @override
  String get ideaUnderwaterTitle => 'Underwater';

  @override
  String get ideaUnderwaterSummary =>
      'Cool aquatic palette with depth haze, light rays, and bubble accents.';

  @override
  String get ideaUnderwaterOverview =>
      'Water depth appears through cool shifts, softened distance, suspended particles, and bubbles.';

  @override
  String get ideaUnderwaterStep1 => 'Start with cool blue-green base layers.';

  @override
  String get ideaUnderwaterStep2 =>
      'Fade distant elements by lowering contrast.';

  @override
  String get ideaUnderwaterStep3 =>
      'Add directional light rays to suggest water depth.';

  @override
  String get ideaUnderwaterStep4 =>
      'Use pale highlights sparingly on bubbles and reflective edges.';

  @override
  String get ideaUnderwaterEmbellishment1 =>
      'Add bubble clusters of different sizes, denser near the light path.';

  @override
  String get ideaUnderwaterEmbellishment2 =>
      'Paint tiny suspended particles for volume in the water.';

  @override
  String get ideaUnderwaterEmbellishment3 =>
      'Curve light rays slightly for a natural underwater feel.';

  @override
  String get ideaSpookyTitle => 'Spooky';

  @override
  String get ideaSpookySummary =>
      'Haunted-place vibe using desaturated darks and chilling accent tones.';

  @override
  String get ideaSpookyOverview =>
      'A haunted look uses desaturated dark fields and isolated eerie accents.';

  @override
  String get ideaSpookyStep1 =>
      'Start from a dim neutral base with low saturation.';

  @override
  String get ideaSpookyStep2 =>
      'Introduce one eerie accent hue in key focal areas.';

  @override
  String get ideaSpookyStep3 =>
      'Use uneven shadow edges for haunted atmosphere.';

  @override
  String get ideaSpookyStep4 =>
      'Keep backgrounds subdued so the subject feels isolated.';

  @override
  String get ideaFantasyTitle => 'Fantasy';

  @override
  String get ideaFantasySummary =>
      'Magical tones with luminous accents and stylized contrast.';

  @override
  String get ideaFantasyOverview =>
      'Push stylized hue choices and luminous accents while keeping shadows readable.';

  @override
  String get ideaInTheMoodTitle => 'In the Mood';

  @override
  String get ideaInTheMoodSummary =>
      'Express one emotional tone through value rhythm and hue bias.';

  @override
  String get ideaInTheMoodOverview =>
      'Choose one emotional direction and keep every hue/value decision aligned with it.';

  @override
  String get ideaSculptureTitle => 'Sculpture';

  @override
  String get ideaSculptureSummary =>
      'Metallic or stone-like palette focused on material highlights and hard edges.';

  @override
  String get ideaSculptureOverview =>
      'Material realism comes from edge control, value planes, and restrained saturation.';

  @override
  String get ideaGalaxyTitle => 'Galaxy';

  @override
  String get ideaGalaxySummary =>
      'Nebula-inspired range with deep space shadows and starlight accents.';

  @override
  String get ideaGalaxyOverview =>
      'Cosmic scenes need deep darks, vibrant nebula zones, and tiny high-contrast stars.';

  @override
  String get ideaStainedGlassTitle => 'Stained Glass';

  @override
  String get ideaStainedGlassSummary =>
      'Jewel-tone palette with dark separators to mimic leaded glass pieces.';

  @override
  String get ideaStainedGlassOverview =>
      'Think in colored panels and dark separators rather than smooth painterly blending.';

  @override
  String get ideaStainedGlassStep1 =>
      'Block separate color panels before any blending.';

  @override
  String get ideaStainedGlassStep2 =>
      'Leave dark separators between major shapes.';

  @override
  String get ideaStainedGlassStep3 =>
      'Increase saturation in center panels for luminosity.';

  @override
  String get ideaStainedGlassStep4 =>
      'Use highlights as reflected light, not smooth gradients.';

  @override
  String get ideaStainedGlassEmbellishment1 =>
      'Use thin black separators to mimic lead came lines.';

  @override
  String get ideaStainedGlassEmbellishment2 =>
      'Keep each panel hue clean and avoid muddy mixes.';

  @override
  String get ideaDefaultOverview => 'Creative challenge';

  @override
  String get ideaDefaultStep1 => 'Block large shapes with your dominant tones.';

  @override
  String get ideaDefaultStep2 =>
      'Build depth using one lighter and one darker support color.';

  @override
  String get ideaDefaultStep3 => 'Use your accent color only on focal areas.';

  @override
  String get ideaDefaultStep4 =>
      'Finish with line cleanup and controlled highlights.';

  @override
  String get ideaDefaultEmbellishment1 =>
      'Run a final pass to simplify accents and keep one clear focal area.';

  @override
  String get ideaDefaultEmbellishment2 =>
      'Reserve your brightest highlight for the subject you want first attention on.';

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
  String get swatchesLegacyPacks => 'Older / community';

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
}
