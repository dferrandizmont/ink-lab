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
  String get settingsClearPalettes => 'Clear all';

  @override
  String get settingsClearPalettesTitle => 'Delete every saved palette?';

  @override
  String get settingsClearPalettesBody =>
      'The palettes saved for this brand will be deleted. This cannot be undone.';

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
  String get settingsBackupSubtitle =>
      'Copies your data (collection, palettes, diary, history and settings) to the clipboard as text, so you can import it later. Photos and the API key are not included.';

  @override
  String get settingsExportBackup => 'Export';

  @override
  String get settingsImportBackup => 'Import';

  @override
  String get settingsBackupExported =>
      'Backup copied to the clipboard, without the photos';

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
      'The backup replaces your current data: collection, palettes, diary, history and settings. Diary entries that are not in it are deleted along with their photos; photos are never part of a backup.';

  @override
  String get ideasFavoritesChip => 'Favourites';

  @override
  String get ideasFavoritesEmptyTitle => 'No favourite ideas yet';

  @override
  String get ideasFavoritesEmptyMessage =>
      'Tap the heart on an idea to keep it here.';

  @override
  String get ideasRecentTitle => 'Recently viewed';

  @override
  String get settingsBackupFileCaption =>
      'A ZIP file with your data and all your photos: diary, swatches and recipes. Pick Files, Drive or any app in the share sheet to keep it. The API key is never included.';

  @override
  String get settingsBackupTextTitle => 'Copy as text (no photos)';

  @override
  String get settingsSaveBackupFile => 'Share backup file';

  @override
  String get settingsRestoreBackupFile => 'Restore from file';

  @override
  String get settingsBackupFileSaving => 'Packing your data and photos…';

  @override
  String get settingsBackupFileRestoring => 'Restoring your backup…';

  @override
  String get settingsRestoreConfirmBody =>
      'The file replaces your current data: collection, palettes, diary, history and settings. The photos in the file are restored too. Diary entries that are not in it are deleted along with their photos.';

  @override
  String get settingsBackupFileRestored => 'Backup restored, photos included';

  @override
  String get settingsBackupFileSaveFailed =>
      'The backup file could not be created.';

  @override
  String get settingsBackupFileReadFailed => 'The file could not be read.';

  @override
  String get settingsBackupFileNotZip => 'That file is not a backup ZIP.';

  @override
  String get settingsBackupFileTooLarge =>
      'The backup is too big for Ink Lab to handle.';

  @override
  String get settingsBackupFileEntryTooLarge =>
      'A photo in the backup is too big.';

  @override
  String get settingsBackupFileDamaged =>
      'The file is damaged or is not an Ink Lab backup.';

  @override
  String get settingsBackupFileUnsupported =>
      'This backup comes from a version Ink Lab cannot read.';

  @override
  String get settingsBackupFileNotAPhoto =>
      'A photo in the file is not a JPEG, PNG or WebP image.';

  @override
  String get settingsBackupFileWriteFailed =>
      'The photos could not be saved. Your data has not changed.';

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
      'Gemini Nano runs on this phone and your requests stay on it. Google\'s ML Kit sends Google usage diagnostics.';

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
      'When this is on and you ask OpenRouter for a suggestion, the app sends openrouter.ai and the model provider, with your own API key: the brand, palette mode and scene, the base marker\'s code and name and whether it is locked, the palette size, the codes and hex colours of the candidate markers, the model settings and the app\'s fixed instructions. Photos are never sent: this feature has no image upload. On Android, the app may also ask Google\'s ML Kit whether Gemini Nano is available; ML Kit sends Google usage diagnostics. Nothing at all is sent while this switch is off.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. On Android, the app may ask Google\'s ML Kit whether Gemini Nano is available; ML Kit sends Google usage diagnostics, never your colours or photos. Choose On-device or OpenRouter to use an AI.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. On Android, the app may ask Google\'s ML Kit whether Gemini Nano is available; ML Kit sends Google usage diagnostics, never your colours or photos. Choose OpenRouter to use an AI.';

  @override
  String get settingsAiDisclosureConfirm => 'Enable';

  @override
  String get settingsAiDisclosureCancel => 'Not now';

  @override
  String get settingsAiDisclosureOnDevice =>
      'On-device (Gemini Nano) requests are answered by the model on this phone: your scenario and colour codes never leave it, and no key is needed. To check, download and run the model, the app uses Google\'s ML Kit, which sends Google usage diagnostics (phone model, app version, per-install identifiers, errors and sizes), never your prompts, colours or photos. Nothing is sent while this switch is off.';

  @override
  String get settingsAiOnDeviceName => 'On-device (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Your requests stay on this phone. ML Kit sends Google usage diagnostics, never your prompts, colours or photos.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'The model is not on this phone yet. Android downloads it once and keeps it for every app.';

  @override
  String get settingsAiOnDeviceDownloading => 'Downloading the model...';

  @override
  String get settingsAiOnDevicePreparing =>
      'Android is preparing the model. This can take a while and may wait for Wi‑Fi and charging. You can leave this screen; the download continues in the background.';

  @override
  String get settingsAiEnabledSubtitleOnDeviceIos =>
      'Apple Intelligence on this phone';

  @override
  String get settingsAiExplainOnDeviceIos =>
      'Apple\'s model runs on this phone and your requests stay on it.';

  @override
  String get settingsAiDisclosureOnDeviceIos =>
      'On-device (Apple Intelligence) requests are answered by Apple\'s model on this phone: your scenario and colour codes never leave it, and no key is needed. iOS installs and manages the model with Apple Intelligence; the app downloads nothing and uses no other service for it, so nothing is sent.';

  @override
  String get settingsAiOnDeviceNameIos => 'On-device (Apple Intelligence)';

  @override
  String get settingsAiOnDevicePrivacyIos =>
      'Your requests stay on this phone. Nothing is sent, not your prompts, colours or photos.';

  @override
  String get settingsAiOnDevicePreparingIos =>
      'iOS is preparing the Apple Intelligence model. This can take a while. You can leave this screen; it continues in the background.';

  @override
  String get settingsAiDisclosureIos =>
      'When this is on and you ask OpenRouter for a suggestion, the app sends openrouter.ai and the model provider, with your own API key: the brand, palette mode and scene, the base marker\'s code and name and whether it is locked, the palette size, the codes and hex colours of the candidate markers, the model settings and the app\'s fixed instructions. Photos are never sent: this feature has no image upload. Nothing at all is sent while this switch is off.';

  @override
  String get settingsAiDisclosureColourTheoryIos =>
      'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. Choose On-device or OpenRouter to use an AI.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDeviceIos =>
      'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. Choose OpenRouter to use an AI.';

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
      'Ink Lab is an independent community project: it is not affiliated with, endorsed by or sponsored by any of the marker brands it lists. It uses their marker codes, names and colour values only as factual reference data.';

  @override
  String get paletteTitle => 'Palette';

  @override
  String get paletteBaseCodeLabel => 'Base marker code';

  @override
  String paletteBaseCodeHint(String first, String second) {
    return '$first or $second';
  }

  @override
  String paletteBaseCodeHintOne(String code) {
    return '$code';
  }

  @override
  String get paletteScenarioToggle => 'Scenes';

  @override
  String get paletteTypeTitle => 'Palette type';

  @override
  String get paletteTypeSheetTitle => 'Choose the palette type';

  @override
  String get paletteTypeTheoryGroup => 'Colour theory';

  @override
  String get paletteTypeScenesGroup => 'Scenes';

  @override
  String get paletteTypeScenesHint => 'Ready-made recipes by subject';

  @override
  String get paletteTypeDescRecommended => 'Balanced picks for your base';

  @override
  String get paletteTypeDescComplementary => 'Opposite hue, strong contrast';

  @override
  String get paletteTypeDescAnalogous => 'Neighbouring hues, calm';

  @override
  String get paletteTypeDescSplitComplementary =>
      'Two hues beside the opposite';

  @override
  String get paletteTypeDescTriad => 'Three evenly spaced hues';

  @override
  String get paletteTypeDescSquare => 'Four evenly spaced hues';

  @override
  String get paletteTypeDescRectangle => 'Two complementary pairs';

  @override
  String get paletteTypeDescMonochrome => 'One hue, light to dark';

  @override
  String get paletteTypeDescShadow => 'Deeper tones for shading';

  @override
  String get paletteTypeDescCustomPalette => 'Build it by hand';

  @override
  String get modeBlendingChain => 'Blending Chain';

  @override
  String get paletteTypeDescBlendingChain => 'Light to dark, ready to blend';

  @override
  String paletteChainResultTitle(int count) {
    return 'Blending chain ($count)';
  }

  @override
  String paletteChainStep(int step, String role) {
    return 'Step $step · $role';
  }

  @override
  String get roleLightest => 'Lightest';

  @override
  String get roleLighter => 'Lighter';

  @override
  String get roleDarker => 'Darker';

  @override
  String get roleDarkest => 'Darkest';

  @override
  String get paletteChainHint =>
      'Work light to dark and overlap each step while the ink is still wet. Soften the joins with the colourless blender if you have one.';

  @override
  String paletteChainShort(int count, int wanted) {
    return 'Only $count of your markers blend well with this base, fewer than the $wanted you asked for.';
  }

  @override
  String get paletteChainNeedLighter =>
      'No chain yet: you need a lighter marker in this family.';

  @override
  String get paletteChainNeedDarker =>
      'No chain yet: you need a darker marker in this family.';

  @override
  String get paletteChainNeedBoth =>
      'No chain yet: you need a lighter and a darker marker in this family.';

  @override
  String get paletteChainBaseLightest =>
      'You have nothing lighter in this family, so the chain starts at your base.';

  @override
  String get paletteChainBaseDarkest =>
      'You have nothing darker in this family, so the chain ends at your base.';

  @override
  String get paletteChainOptionsLabel => 'Other chains';

  @override
  String paletteChainOption(int number) {
    return 'Option $number';
  }

  @override
  String get paletteChainWholeRange => 'Search the whole range';

  @override
  String paletteChainWholeRangeNote(String brand) {
    return 'Showing the whole $brand range, markers you don\'t own included.';
  }

  @override
  String get paletteChainMyMarkers => 'Back to my markers';

  @override
  String get palettePaintTipChainFirst =>
      'Lay the lightest colour over the whole area first.';

  @override
  String get palettePaintTipChainMiddle =>
      'Overlap the previous step while it is still wet.';

  @override
  String get palettePaintTipChainLast =>
      'Finish with the darkest only where the shadow falls.';

  @override
  String get swatchesBlendingChain => 'Blending chain';

  @override
  String paletteTypeSemantic(String value) {
    return 'Palette type, $value';
  }

  @override
  String get paletteSceneTitle => 'Scene';

  @override
  String get paletteSceneSheetTitle => 'Choose a scene';

  @override
  String get paletteSceneSearchHint => 'Search scene or category';

  @override
  String get paletteSceneEmpty => 'No scene matches your search.';

  @override
  String paletteSceneSemantic(String value) {
    return 'Scene, $value';
  }

  @override
  String get paletteFromPhotoTitle => 'From a photo';

  @override
  String get paletteFromPhotoHint => 'Your photo, with your markers';

  @override
  String get paletteFromPhotoValue => 'Your photo';

  @override
  String paletteFromPhotoRole(int percent) {
    return 'Photo colour · $percent %';
  }

  @override
  String get paletteFromPhotoEmpty => 'Couldn\'t get colours from this photo';

  @override
  String get paletteFromPhotoFarNote =>
      'Some photo colours have no close marker in your collection';

  @override
  String get sceneCategoryCharacters => 'Characters';

  @override
  String get sceneCategorySkin => 'Skin and portraits';

  @override
  String get sceneCategorySkyWater => 'Sky and water';

  @override
  String get sceneCategoryNature => 'Nature';

  @override
  String get sceneCategoryMaterials => 'Materials';

  @override
  String get sceneCategoryAnimals => 'Animals and fur';

  @override
  String get sceneCategoryFood => 'Food';

  @override
  String get sceneCategoryHolidays => 'Holidays and moods';

  @override
  String get sceneCategoryInteriors => 'Interiors';

  @override
  String get sceneCategoryPatterns => 'Patterns';

  @override
  String get sceneCategoryFantasy => 'Fantasy';

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
  String get paletteSavedButton => 'Palette saved';

  @override
  String get paletteShareButton => 'Share';

  @override
  String get shareFailed => 'Could not share the image.';

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
  String palettePaintPlanSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steps',
      one: '1 step',
    );
    return '$_temp0';
  }

  @override
  String get paletteLoadButton => 'Load';

  @override
  String get paletteDeleteButton => 'Delete';

  @override
  String get paletteDeleteDialogTitle => 'Delete palette?';

  @override
  String get paletteDeleteDialogBody => 'This action cannot be undone.';

  @override
  String get paletteAiReportButton => 'Report this suggestion';

  @override
  String get paletteAiReportTitle => 'Report this suggestion';

  @override
  String get paletteAiReportBody =>
      'Tell us if the AI wrote something offensive, inappropriate or wrong. Your email app will open with the suggestion\'s text; you decide whether to send it. Your API key is never included.';

  @override
  String get paletteAiReportOffensive => 'Offensive or inappropriate';

  @override
  String get paletteAiReportWrong => 'Wrong or makes no sense';

  @override
  String get paletteAiReportOther => 'Something else';

  @override
  String get paletteAiReportSend => 'Send by email';

  @override
  String get paletteAiReportThanks =>
      'Thanks, this helps us improve the suggestions';

  @override
  String get paletteAiReportCopied =>
      'No email app found. The report was copied: paste it in an email to inklab@mainshai.com';

  @override
  String get paletteAiFellBack => 'AI unavailable. Showing local suggestions.';

  @override
  String get paletteEmptyHint =>
      'Pick a base marker to build a palette, or choose Scenes as the palette type.';

  @override
  String get paletteCustomModeHint =>
      'Custom palette mode is manual: load a saved palette or apply one from Ideas.';

  @override
  String get paletteNoSuggestions =>
      'No palette could be built from your collection. Try another mode or add more markers.';

  @override
  String get paletteScenarioTitle => 'Scenes';

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
  String swatchesClosestTo(String hex) {
    return 'Closest to $hex';
  }

  @override
  String get swatchesClearSearch => 'Clear search';

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
  String get swatchesClearSearchAndFilters => 'Clear search and filters';

  @override
  String get swatchesLoadingSemantics => 'Loading colours';

  @override
  String get swatchesClosestAlternatives => 'Closest alternatives';

  @override
  String get swatchesNoCloseAlternatives => 'No close alternatives';

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
  String get swatchesEmptyNoFavoritesTitle => 'No favourites yet';

  @override
  String get swatchesEmptyNoFavoritesBody =>
      'Tap the star in a colour\'s details to add one.';

  @override
  String get swatchesEmptyNoFavoritesAction => 'Show all colours';

  @override
  String get swatchesEmptyFavoritesNotMineTitle =>
      'No favourites in your collection';

  @override
  String get swatchesEmptyFavoritesNotMineBody =>
      'None of your favourites is one of the markers you own.';

  @override
  String get swatchesEmptyFavoritesNotMineAction => 'Show all favourites';

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
  String get ideasHeaderSubtitle => 'Exercises for your markers';

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
  String get ideasMoreDetails => 'More details';

  @override
  String get ideasGuideOnlyNote =>
      'This exercise uses your whole collection, so it has no fixed palette.';

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
  String get ideasTulipFieldTitle => 'Tulip field';

  @override
  String get ideasTulipFieldSummary =>
      'Rows of red and yellow tulips running to the horizon, spring green between them.';

  @override
  String get ideasTulipFieldPractice =>
      'Flat bands that break into dots as they come closer.';

  @override
  String get ideasTulipFieldSubject =>
      'Rows of tulips seen from low down, with a low horizon.';

  @override
  String get ideasTulipFieldTip =>
      'The nearest row is dots, the furthest is a stripe: change the mark as the row goes back.';

  @override
  String get ideasTulipFieldStep1 =>
      'Pencil rows that narrow towards a low horizon.';

  @override
  String get ideasTulipFieldStep2 =>
      'Red in the first rows: single blobs near, a solid stripe further back.';

  @override
  String get ideasTulipFieldStep3 => 'Yellow in the next rows, the same way.';

  @override
  String get ideasTulipFieldStep4 =>
      'Light green between the rows, and along the horizon.';

  @override
  String get ideasTulipFieldStep5 =>
      'Darker green in a thin line at the foot of each row.';

  @override
  String get ideasSummerBeachTitle => 'At the beach';

  @override
  String get ideasSummerBeachSummary =>
      'Sand, a strip of sea, a parasol: three flat bands and one bright accent.';

  @override
  String get ideasSummerBeachPractice =>
      'Three flat bands and a single accent that carries the eye.';

  @override
  String get ideasSummerBeachSubject =>
      'A beach seen from the sand, with a parasol.';

  @override
  String get ideasSummerBeachTip =>
      'Leave the foam as paper: it is the brightest line in the sea.';

  @override
  String get ideasSummerBeachStep1 =>
      'Pencil three horizontal bands (sky, sea, sand) and a parasol in the sand.';

  @override
  String get ideasSummerBeachStep2 =>
      'Pale sand with a very light hand; leave the wet sand near the water lighter.';

  @override
  String get ideasSummerBeachStep3 =>
      'Light teal for the sea, with a line of paper for the foam.';

  @override
  String get ideasSummerBeachStep4 => 'Deeper teal at the horizon.';

  @override
  String get ideasSummerBeachStep5 =>
      'Red parasol and its small shadow on the sand, painted with a second layer of the sand colour.';

  @override
  String get ideasWatermelonSliceTitle => 'Watermelon';

  @override
  String get ideasWatermelonSliceSummary =>
      'A slice of watermelon: red flesh, white rind, green skin, black seeds.';

  @override
  String get ideasWatermelonSlicePractice =>
      'A quick blend and a flat stripe, with the white rind left as paper.';

  @override
  String get ideasWatermelonSliceSubject =>
      'A triangular slice of watermelon with a curved base.';

  @override
  String get ideasWatermelonSliceTip =>
      'The white rind is paper: do not colour it at all.';

  @override
  String get ideasWatermelonSliceStep1 =>
      'Pencil a triangle with a curved base and a thin white band inside the green.';

  @override
  String get ideasWatermelonSliceStep2 =>
      'The light red over the flesh, paler near the rind.';

  @override
  String get ideasWatermelonSliceStep3 =>
      'Deeper red towards the point, blended while wet.';

  @override
  String get ideasWatermelonSliceStep4 =>
      'Green on the skin, with dark green stripes in a second layer.';

  @override
  String get ideasWatermelonSliceStep5 =>
      'Seeds with the liner, each a small teardrop.';

  @override
  String get ideasForestMushroomsTitle => 'Mushrooms on the forest floor';

  @override
  String get ideasForestMushroomsSummary =>
      'A cluster of mushrooms among brown leaves in autumn.';

  @override
  String get ideasForestMushroomsPractice =>
      'Round caps with small blends and a loose, dry ground.';

  @override
  String get ideasForestMushroomsSubject =>
      'Three mushrooms of different heights among fallen leaves.';

  @override
  String get ideasForestMushroomsTip =>
      'The forest floor wants loose, broken strokes of brown, not solid fills.';

  @override
  String get ideasForestMushroomsStep1 =>
      'Pencil three mushrooms of different heights and a few leaves around them.';

  @override
  String get ideasForestMushroomsStep2 =>
      'Pale beige on the stems and the underside of the caps.';

  @override
  String get ideasForestMushroomsStep3 =>
      'The red-brown on the caps, darker at the edge.';

  @override
  String get ideasForestMushroomsStep4 => 'Brown on the leaves and the ground.';

  @override
  String get ideasForestMushroomsStep5 =>
      'Darkest under the caps and where the stems meet the ground; white gel spots on the caps if you like.';

  @override
  String get ideasHarvestBasketTitle => 'Harvest basket';

  @override
  String get ideasHarvestBasketSummary =>
      'Apples, a pear and a small squash in a basket, each a different colour, shaded with one grey.';

  @override
  String get ideasHarvestBasketPractice =>
      'One grey shading three strong colours so they belong together.';

  @override
  String get ideasHarvestBasketSubject =>
      'A basket full of fruit: apples, a pear and a squash.';

  @override
  String get ideasHarvestBasketTip =>
      'Shade every fruit with the same grey. It is what keeps a busy still life together.';

  @override
  String get ideasHarvestBasketStep1 =>
      'Pencil the basket and the fruit overlapping.';

  @override
  String get ideasHarvestBasketStep2 =>
      'Red for the apples, with the highlight left as paper.';

  @override
  String get ideasHarvestBasketStep3 => 'Yellow-green for the pear.';

  @override
  String get ideasHarvestBasketStep4 =>
      'Orange for the squash, with its ridges as darker lines of a second layer.';

  @override
  String get ideasHarvestBasketStep5 =>
      'The same grey for every shadow and the inside of the basket.';

  @override
  String get ideasHarvestBasketStep6 =>
      'The darkest marker for the weave lines of the basket.';

  @override
  String get ideasHotChocolateTitle => 'Hot chocolate';

  @override
  String get ideasHotChocolateSummary =>
      'A mug of chocolate with steam, a marshmallow and a red mitten.';

  @override
  String get ideasHotChocolatePractice =>
      'Warm browns, one red accent and steam lifted out of the background.';

  @override
  String get ideasHotChocolateSubject =>
      'A mug of hot chocolate with a marshmallow and a mitten beside it.';

  @override
  String get ideasHotChocolateTip =>
      'Steam is either paper or a shape lifted with the blender, never a drawn line.';

  @override
  String get ideasHotChocolateStep1 =>
      'Pencil the mug, the surface of the drink, a marshmallow and a mitten resting against it.';

  @override
  String get ideasHotChocolateStep2 =>
      'Pale brown on the lit side of the mug and on the shadow of the marshmallow.';

  @override
  String get ideasHotChocolateStep3 =>
      'Brown on the surface of the drink and the shadow side of the mug.';

  @override
  String get ideasHotChocolateStep4 => 'Red mitten, two layers.';

  @override
  String get ideasHotChocolateStep5 =>
      'Steam: lift wisps out of the background with the blender, or leave them as paper.';

  @override
  String get ideasLunarNewYearTitle => 'Lunar New Year';

  @override
  String get ideasLunarNewYearSummary =>
      'Red lanterns with gold trim against a red wall.';

  @override
  String get ideasLunarNewYearPractice =>
      'One red family in three steps and a flat gold accent.';

  @override
  String get ideasLunarNewYearSubject =>
      'Three round lanterns hanging at different heights, with tassels.';

  @override
  String get ideasLunarNewYearTip =>
      'Lay the gold on top of the dry red, never the other way round.';

  @override
  String get ideasLunarNewYearStep1 =>
      'Pencil three lanterns hanging at different heights, with tassels.';

  @override
  String get ideasLunarNewYearStep2 =>
      'Light red over the lanterns, paler on the lit side.';

  @override
  String get ideasLunarNewYearStep3 =>
      'The red on the shadow side and the ribs, blended while wet.';

  @override
  String get ideasLunarNewYearStep4 =>
      'Dark red between the ribs and inside the rims.';

  @override
  String get ideasLunarNewYearStep5 =>
      'Gold yellow on the rims, the caps and the tassels, left crisp.';

  @override
  String get ideasDiwaliLampsTitle => 'Diwali lamps';

  @override
  String get ideasDiwaliLampsSummary =>
      'A row of clay lamps with small flames and a rangoli of bright colours around them.';

  @override
  String get ideasDiwaliLampsPractice =>
      'A flat saturated pattern next to a two-step blend on the lamps.';

  @override
  String get ideasDiwaliLampsSubject =>
      'Five little clay lamps in a curve, with a simple symmetrical pattern around them.';

  @override
  String get ideasDiwaliLampsTip =>
      'Keep the pattern flat and hard-edged. It is the contrast with the lamps that makes it work.';

  @override
  String get ideasDiwaliLampsStep1 =>
      'Pencil five little lamps in a curve and a simple symmetrical pattern around them.';

  @override
  String get ideasDiwaliLampsStep2 => 'Light terracotta on the lamps.';

  @override
  String get ideasDiwaliLampsStep3 => 'Deeper terracotta on their shadow side.';

  @override
  String get ideasDiwaliLampsStep4 =>
      'Yellow for each flame and a glow on the rim of each lamp.';

  @override
  String get ideasDiwaliLampsStep5 =>
      'Magenta in the alternating sections of the pattern, flat and hard-edged.';

  @override
  String get ideasDiwaliLampsStep6 =>
      'Teal in the other sections, then white gel dots on the flames if you like.';

  @override
  String get ideasHanukkahCandlesTitle => 'Hanukkah';

  @override
  String get ideasHanukkahCandlesSummary =>
      'A menorah with its candles lit, blue and white with gold flames.';

  @override
  String get ideasHanukkahCandlesPractice =>
      'White shapes kept as paper against a blue field.';

  @override
  String get ideasHanukkahCandlesSubject =>
      'A menorah with its candles lit in front of a blue background.';

  @override
  String get ideasHanukkahCandlesTip =>
      'The candles are paper: colour around them and they come out white.';

  @override
  String get ideasHanukkahCandlesStep1 =>
      'Pencil the menorah and the candles; the candles stay paper.';

  @override
  String get ideasHanukkahCandlesStep2 =>
      'Light blue background around everything.';

  @override
  String get ideasHanukkahCandlesStep3 =>
      'Deeper blue at the edges of the page, blended inwards.';

  @override
  String get ideasHanukkahCandlesStep4 =>
      'The dark blue for the menorah itself.';

  @override
  String get ideasHanukkahCandlesStep5 =>
      'Yellow flames and a soft glow around each, then a white gel core in each flame.';

  @override
  String get ideasPaintedEggsTitle => 'Painted eggs';

  @override
  String get ideasPaintedEggsSummary =>
      'Three decorated eggs with stripes, dots and zigzags in mid-strength colours.';

  @override
  String get ideasPaintedEggsPractice =>
      'Three ways to make a pattern: paper, shape and second layer.';

  @override
  String get ideasPaintedEggsSubject =>
      'Three eggs, each with a different pattern.';

  @override
  String get ideasPaintedEggsTip =>
      'Mid-strength colours let a second layer show without turning muddy.';

  @override
  String get ideasPaintedEggsStep1 =>
      'Pencil three eggs and a different pattern on each.';

  @override
  String get ideasPaintedEggsStep2 =>
      'First egg: base colour flat, with the pattern left as paper.';

  @override
  String get ideasPaintedEggsStep3 =>
      'Second egg: fill the pattern shapes only, the rest stays paper.';

  @override
  String get ideasPaintedEggsStep4 =>
      'Third egg: colour it, then add the pattern in the same colour as a second layer.';

  @override
  String get ideasPaintedEggsStep5 =>
      'One grey for the shadow side of each egg and the small shadow under it.';

  @override
  String get ideasDiaDeMuertosTitle => 'Día de Muertos';

  @override
  String get ideasDiaDeMuertosSummary =>
      'Marigolds and a decorated skull in orange, magenta and teal on a dark ground.';

  @override
  String get ideasDiaDeMuertosPractice =>
      'Saturated flat pattern on a dark field.';

  @override
  String get ideasDiaDeMuertosSubject =>
      'A decorated skull with flower shapes round the eyes and a bank of marigolds below.';

  @override
  String get ideasDiaDeMuertosTip =>
      'Lay the dark ground last and slowly: dark ink runs into the light areas.';

  @override
  String get ideasDiaDeMuertosStep1 =>
      'Pencil a skull with flower shapes round the eyes and a bank of marigolds below.';

  @override
  String get ideasDiaDeMuertosStep2 =>
      'Light orange on the marigolds, each as a rough circle.';

  @override
  String get ideasDiaDeMuertosStep3 =>
      'Deeper orange in short strokes inside each circle for the petals.';

  @override
  String get ideasDiaDeMuertosStep4 =>
      'Magenta for the patterns of the skull, flat and symmetrical.';

  @override
  String get ideasDiaDeMuertosStep5 =>
      'Teal for the other half of the patterns of the skull.';

  @override
  String get ideasDiaDeMuertosStep6 =>
      'The darkest marker for the eye sockets and the background, then liner details.';

  @override
  String get ideasValentineCardTitle => 'Valentine card';

  @override
  String get ideasValentineCardSummary =>
      'A card with three hearts, from pale pink to deep red, and a shadow line that lifts them off the paper.';

  @override
  String get ideasValentineCardPractice =>
      'Three flat fills and a drop-shadow line.';

  @override
  String get ideasValentineCardSubject =>
      'Three overlapping hearts, the biggest at the back.';

  @override
  String get ideasValentineCardTip =>
      'Draw the drop shadow as one thin line: it lifts the heart without more colour.';

  @override
  String get ideasValentineCardStep1 =>
      'Pencil three overlapping hearts, the biggest at the back.';

  @override
  String get ideasValentineCardStep2 => 'Pale pink on the back heart.';

  @override
  String get ideasValentineCardStep3 => 'Pink on the middle one.';

  @override
  String get ideasValentineCardStep4 =>
      'Red on the front one, and a thin line of it under the other two as a drop shadow.';

  @override
  String get ideasValentineCardStep5 =>
      'A white gel highlight on each heart, top left.';

  @override
  String get ideasCarnivalMaskTitle => 'Carnival mask';

  @override
  String get ideasCarnivalMaskSummary =>
      'A mask with feathers in violet, teal and gold.';

  @override
  String get ideasCarnivalMaskPractice =>
      'Flicks for feathers, a blend for the mask and flat gold.';

  @override
  String get ideasCarnivalMaskSubject =>
      'A half mask with three feathers rising from one side.';

  @override
  String get ideasCarnivalMaskTip =>
      'Flick the feathers outwards from the quill: the soft edge is what makes them read as feathers.';

  @override
  String get ideasCarnivalMaskStep1 =>
      'Pencil a half mask and three feathers rising from one side.';

  @override
  String get ideasCarnivalMaskStep2 =>
      'Violet on the mask, two layers where it curves away.';

  @override
  String get ideasCarnivalMaskStep3 =>
      'Teal on the feathers, flicked outwards from the quill so the edges are soft.';

  @override
  String get ideasCarnivalMaskStep4 =>
      'Gold on the edge of the mask and the eye rims.';

  @override
  String get ideasCarnivalMaskStep5 =>
      'Darkest inside the eye holes, then gel dots as sequins.';

  @override
  String get ideasMidsummerCrownTitle => 'Midsummer flower crown';

  @override
  String get ideasMidsummerCrownSummary =>
      'A crown of wildflowers and leaves: blue, yellow and pink on green.';

  @override
  String get ideasMidsummerCrownPractice =>
      'Many small dabs of the fine nib on a dry green base.';

  @override
  String get ideasMidsummerCrownSubject =>
      'A ring of leaves with three kinds of small wildflowers.';

  @override
  String get ideasMidsummerCrownTip =>
      'Dabs of colour on a dry base stay crisp. Wait for the green to dry before you start the flowers.';

  @override
  String get ideasMidsummerCrownStep1 =>
      'Pencil a ring of leaves and small flowers in three kinds.';

  @override
  String get ideasMidsummerCrownStep2 => 'Light green on all the leaves.';

  @override
  String get ideasMidsummerCrownStep3 =>
      'Darker green where leaves overlap and underneath.';

  @override
  String get ideasMidsummerCrownStep4 => 'Blue on the first kind of flower.';

  @override
  String get ideasMidsummerCrownStep5 => 'Yellow on the second kind of flower.';

  @override
  String get ideasMidsummerCrownStep6 =>
      'Pink on the third, with a tiny second layer at the centre of each flower.';

  @override
  String get ideasEidNightTitle => 'Eid night';

  @override
  String get ideasEidNightSummary =>
      'A crescent moon and a hanging lantern against a deep teal and violet sky.';

  @override
  String get ideasEidNightPractice =>
      'A clean wet blend from teal to violet, with gold laid on top.';

  @override
  String get ideasEidNightSubject =>
      'A crescent moon and a patterned lantern against a night sky.';

  @override
  String get ideasEidNightTip =>
      'Blend the teal into the violet while both are wet. Once dry, the sky stays clean.';

  @override
  String get ideasEidNightStep1 =>
      'Pencil the crescent and a patterned lantern; both stay paper for now.';

  @override
  String get ideasEidNightStep2 =>
      'Teal across the sky, lightest near the moon.';

  @override
  String get ideasEidNightStep3 => 'Deeper teal towards the edges.';

  @override
  String get ideasEidNightStep4 =>
      'Violet blended into the top corners while the teal is still damp.';

  @override
  String get ideasEidNightStep5 =>
      'Gold on the crescent and the lantern frame; the panes stay pale, then white gel stars.';

  @override
  String get ideasHoliColoursTitle => 'Holi';

  @override
  String get ideasHoliColoursSummary =>
      'Clouds of coloured powder on white: soft edges, hard centres, four bright colours.';

  @override
  String get ideasHoliColoursPractice =>
      'Colour with no edge: the blender dissolves an edge into paper.';

  @override
  String get ideasHoliColoursSubject =>
      'Four overlapping clouds of coloured powder on white paper.';

  @override
  String get ideasHoliColoursTip =>
      'Let each cloud dry before you add the next one, or the colours all turn to mud.';

  @override
  String get ideasHoliColoursStep1 =>
      'Scribble a loose cloud with the first colour, dense in the middle.';

  @override
  String get ideasHoliColoursStep2 =>
      'Pull its edges out with the blender into the white paper until they vanish.';

  @override
  String get ideasHoliColoursStep3 =>
      'A second cloud overlapping the first a little; where they meet, let them mix.';

  @override
  String get ideasHoliColoursStep4 => 'A third cloud, smaller, in a gap.';

  @override
  String get ideasHoliColoursStep5 =>
      'A fourth cloud in the last gap, then flick a few dots of each colour around it.';

  @override
  String get ideasSummerIceCreamTitle => 'Ice cream';

  @override
  String get ideasSummerIceCreamSummary =>
      'Three scoops of different flavours on a cone.';

  @override
  String get ideasSummerIceCreamPractice =>
      'Three round blends and one grey shading all of them.';

  @override
  String get ideasSummerIceCreamSubject =>
      'Three stacked scoops on a cone with a waffle grid.';

  @override
  String get ideasSummerIceCreamTip =>
      'Use the same grey for every scoop: that is what keeps three different colours together.';

  @override
  String get ideasSummerIceCreamStep1 =>
      'Pencil a cone with a waffle grid and three stacked scoops.';

  @override
  String get ideasSummerIceCreamStep2 =>
      'The first flavour on the bottom scoop, with a highlight of paper left on it.';

  @override
  String get ideasSummerIceCreamStep3 =>
      'The second flavour on the middle scoop, with its own highlight.';

  @override
  String get ideasSummerIceCreamStep4 => 'The third flavour on the top scoop.';

  @override
  String get ideasSummerIceCreamStep5 =>
      'The same light grey on the underside of every scoop and where they overlap.';

  @override
  String get ideasSummerIceCreamStep6 =>
      'The cone in beige, with the grid lines in a second layer.';

  @override
  String get ideasNewYearFireworksTitle => 'New Year fireworks';

  @override
  String get ideasNewYearFireworksSummary =>
      'Three bursts of fireworks over a dark sky, each a different colour.';

  @override
  String get ideasNewYearFireworksPractice =>
      'Bright colour over a dark fill, with the lines kept as paper.';

  @override
  String get ideasNewYearFireworksSubject =>
      'Three bursts of fireworks with light lines radiating from each centre.';

  @override
  String get ideasNewYearFireworksTip =>
      'Fill the sky around the lines, not over them: the white paper is what makes the fireworks glow.';

  @override
  String get ideasNewYearFireworksStep1 =>
      'Pencil three centres and light radiating lines from each; the lines stay paper for now.';

  @override
  String get ideasNewYearFireworksStep2 =>
      'Fill the sky dark, going round the lines with the fine nib (they can be uneven).';

  @override
  String get ideasNewYearFireworksStep3 =>
      'Trace the lines of the first burst with the first colour, pressing harder at the tips.';

  @override
  String get ideasNewYearFireworksStep4 =>
      'The lines of the second burst in the second colour.';

  @override
  String get ideasNewYearFireworksStep5 =>
      'The lines of the third burst in the third colour.';

  @override
  String get ideasNewYearFireworksStep6 =>
      'White gel at the centre of each burst and a few sparks at the tips.';

  @override
  String get ideasCozyLampTitle => 'Cosy corner';

  @override
  String get ideasCozyLampSummary =>
      'An armchair under a lamp in the evening: a warm pool of light and soft brown shadows.';

  @override
  String get ideasCozyLampPractice =>
      'Planning a lit area and letting the rest of the room fall into warm brown.';

  @override
  String get ideasCozyLampSubject =>
      'An armchair, a floor lamp and a wall behind them.';

  @override
  String get ideasCozyLampTip =>
      'Keep the darkest brown out of the circle of light: the lamp reaches no corner.';

  @override
  String get ideasCozyLampStep1 =>
      'Pencil the chair, the lamp and the circle of light it throws on the floor and the wall.';

  @override
  String get ideasCozyLampStep2 =>
      'Fill the circle of light with the pale yellow and fade it out with the colourless blender.';

  @override
  String get ideasCozyLampStep3 =>
      'Colour the rest of the room with the light warm beige, flat and even.';

  @override
  String get ideasCozyLampStep4 =>
      'Put the warm brown on the chair and on the side of the room that is away from the lamp.';

  @override
  String get ideasCozyLampStep5 =>
      'Use the dark brown in the corners and under the chair, and keep it off the circle of light.';

  @override
  String get ideasFoggyMorningTitle => 'Fog';

  @override
  String get ideasFoggyMorningSummary =>
      'Trees disappearing into fog: the nearer ones darker, the further ones paler.';

  @override
  String get ideasFoggyMorningPractice =>
      'Depth with a pale glaze over dark shapes.';

  @override
  String get ideasFoggyMorningSubject =>
      'Three rows of trees on a road, each row further back.';

  @override
  String get ideasFoggyMorningTip =>
      'A pale glaze over a dark shape is the simplest fog there is: the ink under it stays.';

  @override
  String get ideasFoggyMorningStep1 =>
      'Pencil three rows of trees, each row further back, and mark where the ground starts.';

  @override
  String get ideasFoggyMorningStep2 =>
      'Colour the furthest row with the palest marker only, without any detail.';

  @override
  String get ideasFoggyMorningStep3 =>
      'Colour the middle row with the base tone and soften its lower edge into the ground with the blender.';

  @override
  String get ideasFoggyMorningStep4 =>
      'Draw the nearest trees with the dark marker and add a few branches.';

  @override
  String get ideasFoggyMorningStep5 =>
      'Glaze the pale marker over the top of every row, so the fog lies over the whole scene.';

  @override
  String get ideasRainyWindowTitle => 'Rain on the window';

  @override
  String get ideasRainyWindowSummary =>
      'Blurred lights seen through a wet window, with drops running down the glass.';

  @override
  String get ideasRainyWindowPractice =>
      'Glowing lights behind glass, and crisp marks on top of them.';

  @override
  String get ideasRainyWindowSubject =>
      'A window at night with street lights outside and three drops on the glass.';

  @override
  String get ideasRainyWindowTip =>
      'The lights must dry completely before the blue goes over them, or the colours mix.';

  @override
  String get ideasRainyWindowStep1 =>
      'Pencil the window frame and a few blurred blobs of light outside, and mark the path of three drops.';

  @override
  String get ideasRainyWindowStep2 =>
      'Colour the warm lights as soft blobs and melt their edges with the blender.';

  @override
  String get ideasRainyWindowStep3 =>
      'Cover the whole glass with the light blue, working around the lights.';

  @override
  String get ideasRainyWindowStep4 =>
      'Add the base blue towards the corners and leave the drop paths a little lighter.';

  @override
  String get ideasRainyWindowStep5 =>
      'Colour the frame dark and put a dark crescent on the side of each drop away from the light.';

  @override
  String get ideasRainyWindowStep6 =>
      'Once dry, add a touch of white gel on the lit side of each drop.';

  @override
  String get ideasEerieForestTitle => 'Eerie woods';

  @override
  String get ideasEerieForestSummary =>
      'Thin trees at dusk in sickly greens, with a violet sky between them.';

  @override
  String get ideasEerieForestPractice =>
      'Letting two colours mix where they meet, on purpose.';

  @override
  String get ideasEerieForestSubject =>
      'Tall thin trunks on a low horizon at dusk.';

  @override
  String get ideasEerieForestTip =>
      'The green and the violet turn grey where they meet. That grey is the mood, not a mistake.';

  @override
  String get ideasEerieForestStep1 =>
      'Pencil tall thin trunks and a low horizon.';

  @override
  String get ideasEerieForestStep2 =>
      'Put a pale yellow-green along the horizon, between the trunks.';

  @override
  String get ideasEerieForestStep3 =>
      'Colour the violet above it and blend it into the green while it is damp.';

  @override
  String get ideasEerieForestStep4 =>
      'Colour the green on the ground and on the lower part of the trunks.';

  @override
  String get ideasEerieForestStep5 =>
      'Use the darkest green on the trunks in uneven strokes, and add long shadows across the ground.';

  @override
  String get ideasGoldenHourTitle => 'Golden hour';

  @override
  String get ideasGoldenHourSummary =>
      'A white wall and a doorway at the end of the afternoon: orange light, long violet shadows.';

  @override
  String get ideasGoldenHourPractice =>
      'One warm glaze over everything, with hard-edged cool shadows on top.';

  @override
  String get ideasGoldenHourSubject =>
      'A wall with a door, a plant and the long shadow the plant throws on the wall.';

  @override
  String get ideasGoldenHourTip =>
      'The wall is not white here: in this light it is orange. Paint it so.';

  @override
  String get ideasGoldenHourStep1 =>
      'Pencil a wall with a door and a plant, and the long shadow the plant throws across the wall.';

  @override
  String get ideasGoldenHourStep2 =>
      'Wash the whole wall with the pale orange: that is the white wall in this light.';

  @override
  String get ideasGoldenHourStep3 =>
      'Put the deeper orange under the lintel and on the door.';

  @override
  String get ideasGoldenHourStep4 =>
      'Add the violet-grey in the shadow of the plant and in the doorway, with a crisp edge.';

  @override
  String get ideasGoldenHourStep5 =>
      'Keep the darkest marker for the depth of the doorway only.';

  @override
  String get ideasStormySeaTitle => 'Stormy sea';

  @override
  String get ideasStormySeaSummary =>
      'Grey-green waves under a dark sky, with white paper for the foam.';

  @override
  String get ideasStormySeaPractice =>
      'Pale flat water against a heavy sky, with the foam left as paper.';

  @override
  String get ideasStormySeaSubject =>
      'A low horizon, two big waves and the foam breaking on them.';

  @override
  String get ideasStormySeaTip =>
      'The foam is paper you did not touch: plan where it breaks before you colour the water.';

  @override
  String get ideasStormySeaStep1 =>
      'Pencil the horizon low, two big waves and where the foam breaks. The foam stays paper.';

  @override
  String get ideasStormySeaStep2 =>
      'Cover the water with the pale grey-green, going round the foam.';

  @override
  String get ideasStormySeaStep3 =>
      'Put the darker water in the troughs and under each crest.';

  @override
  String get ideasStormySeaStep4 =>
      'Fill the sky with the dark marker, darkest at the top, and the deepest water under the breaking wave.';

  @override
  String get ideasStormySeaStep5 =>
      'Once dry, add white gel for the spray flicked off the crests: a few dots only.';

  @override
  String get ideasCandleFlameTitle => 'By candlelight';

  @override
  String get ideasCandleFlameSummary =>
      'A candle on a table in a dark room: everything warm, and nothing far from the flame visible.';

  @override
  String get ideasCandleFlamePractice =>
      'Concentric rings of warm colour, blended wet into each other.';

  @override
  String get ideasCandleFlameSubject =>
      'A candle in a holder, with the table and the far wall behind it.';

  @override
  String get ideasCandleFlameTip =>
      'Only what the flame touches is visible: the far room can be almost one dark shape.';

  @override
  String get ideasCandleFlameStep1 =>
      'Pencil the candle, its flame and a circle of light on the table. The core of the flame stays paper.';

  @override
  String get ideasCandleFlameStep2 =>
      'Colour the halo of the flame and the nearest part of the table with the yellow, melted outwards with the blender.';

  @override
  String get ideasCandleFlameStep3 =>
      'Put the warm orange on the lit side of the candle and on the next ring of the table.';

  @override
  String get ideasCandleFlameStep4 =>
      'Colour brown everything beyond the circle of light.';

  @override
  String get ideasCandleFlameStep5 =>
      'Use the darkest brown for the far room and the shadow side of the candle, with a soft edge against the light.';

  @override
  String get ideasDesertNoonTitle => 'Desert noon';

  @override
  String get ideasDesertNoonSummary =>
      'Sand, one rock and a hard shadow under a bleached sky.';

  @override
  String get ideasDesertNoonPractice =>
      'A flat pale fill against one hard, dark shadow.';

  @override
  String get ideasDesertNoonSubject =>
      'A high horizon, a single rock and its short shadow straight under it.';

  @override
  String get ideasDesertNoonTip =>
      'Leave a band of white paper at the horizon: that band is what makes the sky look hot.';

  @override
  String get ideasDesertNoonStep1 =>
      'Pencil a high horizon, one rock and its short shadow straight under it.';

  @override
  String get ideasDesertNoonStep2 =>
      'Cover the sand below the horizon with the pale yellow, in one very light pass.';

  @override
  String get ideasDesertNoonStep3 =>
      'Colour the sky with the pale blue and leave it paler near the horizon.';

  @override
  String get ideasDesertNoonStep4 =>
      'Put the orange on the shadow side of the rock and on the ripples of the sand.';

  @override
  String get ideasDesertNoonStep5 =>
      'Use the violet-blue only in the shadow the rock casts, with a hard edge.';

  @override
  String get ideasBokehLightsTitle => 'Blurred lights';

  @override
  String get ideasBokehLightsSummary =>
      'A background of soft out-of-focus circles of light.';

  @override
  String get ideasBokehLightsPractice =>
      'Making a soft disc with the blender on a flat field.';

  @override
  String get ideasBokehLightsSubject =>
      'A dark field with a dozen blurred lights of different sizes.';

  @override
  String get ideasBokehLightsTip =>
      'Press the blender flat: a pointed nib draws a line, not a disc.';

  @override
  String get ideasBokehLightsStep1 =>
      'Fill the whole area with the base colour, in flat strokes.';

  @override
  String get ideasBokehLightsStep2 =>
      'Darken the corners and blend the dark inwards while the ink is damp.';

  @override
  String get ideasBokehLightsStep3 =>
      'Let it dry, then press the broad nib of the blender flat in circles of different sizes.';

  @override
  String get ideasBokehLightsStep4 =>
      'Touch the light marker into the centre of a few of the discs so they glow.';

  @override
  String get ideasBokehLightsStep5 =>
      'Put a white gel dot inside two or three of the discs, not in all of them.';

  @override
  String get ideasRetroPosterTitle => 'Retro poster';

  @override
  String get ideasRetroPosterSummary =>
      'Three flat, slightly dusty colours and one dark, with no blending at all.';

  @override
  String get ideasRetroPosterPractice =>
      'Flat fills and hard edges, the way a printed poster looks.';

  @override
  String get ideasRetroPosterSubject =>
      'A lighthouse, a car or a bottle drawn as a few big flat shapes.';

  @override
  String get ideasRetroPosterTip =>
      'Leave a hair of white paper between the colours, as if the print had slipped a little.';

  @override
  String get ideasRetroPosterStep1 =>
      'Pencil a simple subject as big flat shapes: a lighthouse, a car, a bottle.';

  @override
  String get ideasRetroPosterStep2 =>
      'Fill the biggest shapes flat, in one pass.';

  @override
  String get ideasRetroPosterStep3 =>
      'Fill the next shapes and leave a hair of paper between the colours.';

  @override
  String get ideasRetroPosterStep4 =>
      'Use the third colour on the smallest shapes.';

  @override
  String get ideasRetroPosterStep5 =>
      'Draw the shadows as separate flat shapes with the dark marker.';

  @override
  String get ideasRetroPosterStep6 =>
      'Add a few liner lines where the printed poster would have them.';

  @override
  String get ideasFreshCitrusTitle => 'Fresh and zesty';

  @override
  String get ideasFreshCitrusSummary =>
      'A lemon, a lime and a glass of water, with lots of white paper and at most two layers.';

  @override
  String get ideasFreshCitrusPractice =>
      'Bright colour on white, stopped early.';

  @override
  String get ideasFreshCitrusSubject =>
      'A lemon, a lime and a glass of water on a table.';

  @override
  String get ideasFreshCitrusTip =>
      'Stop after two layers: a third one takes the fresh out of the colour.';

  @override
  String get ideasFreshCitrusStep1 =>
      'Pencil the fruit and the glass, and keep the composition airy.';

  @override
  String get ideasFreshCitrusStep2 =>
      'Colour the lemon with the yellow in one pass, leaving a white highlight.';

  @override
  String get ideasFreshCitrusStep3 =>
      'Colour the lime with the green, also in one pass.';

  @override
  String get ideasFreshCitrusStep4 =>
      'The darker yellow on the shadow side of the lemon, and a second pass of green on the shadow side of the lime.';

  @override
  String get ideasFreshCitrusStep5 =>
      'Use the pale blue for the water in the glass and a small shadow under each fruit.';

  @override
  String get ideasTropicalNoonTitle => 'Tropical noon';

  @override
  String get ideasTropicalNoonSummary =>
      'Big leaves, a hot pink flower and a slice of blue sky, saturated and hard-edged.';

  @override
  String get ideasTropicalNoonPractice =>
      'Strong flat colour with crisp overlaps, without any blending.';

  @override
  String get ideasTropicalNoonSubject =>
      'Two or three big leaves overlapping, one flower and the sky in the gaps.';

  @override
  String get ideasTropicalNoonTip =>
      'Leave the edge of each leaf sharp: the overlap is what sells the depth here.';

  @override
  String get ideasTropicalNoonStep1 =>
      'Pencil two or three large leaves overlapping, one flower and the sky in the gaps between them.';

  @override
  String get ideasTropicalNoonStep2 =>
      'Colour the leaves with the light green, following the veins.';

  @override
  String get ideasTropicalNoonStep3 =>
      'Put the mid green on the leaves behind and under the others, with hard edges where they overlap.';

  @override
  String get ideasTropicalNoonStep4 =>
      'Colour the hot pink on the flower, with two layers.';

  @override
  String get ideasTropicalNoonStep5 =>
      'Colour the blue sky in the gaps, right up to the edge of the leaves.';

  @override
  String get ideasGreenhouseLightTitle => 'In the greenhouse';

  @override
  String get ideasGreenhouseLightSummary =>
      'Plants behind glass in damp green light, with pale grey panes.';

  @override
  String get ideasGreenhouseLightPractice =>
      'A pale glaze over a scene, the way glass veils it.';

  @override
  String get ideasGreenhouseLightSubject =>
      'A glass wall with its bars and pots of plants behind it.';

  @override
  String get ideasGreenhouseLightTip =>
      'The green glaze goes on last: it is the damp light of the place, not the colour of the plants.';

  @override
  String get ideasGreenhouseLightStep1 =>
      'Pencil a glass wall with its bars and pots of plants behind it.';

  @override
  String get ideasGreenhouseLightStep2 =>
      'Colour the plants with the base green, softer the further they are behind the glass.';

  @override
  String get ideasGreenhouseLightStep3 =>
      'Keep the dark green for the nearest leaves only.';

  @override
  String get ideasGreenhouseLightStep4 =>
      'Use the light grey for the bars and for the reflection streaks on the panes.';

  @override
  String get ideasGreenhouseLightStep5 =>
      'Once dry, glaze the whole glass area with the pale green: the light inside is green.';

  @override
  String get ideasDustyAtticTitle => 'Dusty attic';

  @override
  String get ideasDustyAtticSummary =>
      'Warm greys, an old trunk and one shaft of light with dust in it.';

  @override
  String get ideasDustyAtticPractice =>
      'A grey room with one bright place left untouched.';

  @override
  String get ideasDustyAtticSubject =>
      'A small high window, the shaft of light it throws and an old trunk in it.';

  @override
  String get ideasDustyAtticTip =>
      'Keep the shaft of light the brightest thing in the picture: it is the only white paper left.';

  @override
  String get ideasDustyAtticStep1 =>
      'Pencil a small window high up, the shaft of light it throws and a trunk inside it.';

  @override
  String get ideasDustyAtticStep2 =>
      'Cover everything with the lightest warm grey, except the inside of the shaft.';

  @override
  String get ideasDustyAtticStep3 =>
      'Put the mid warm grey on the walls away from the window and on the sides of the trunk.';

  @override
  String get ideasDustyAtticStep4 =>
      'Use the darkest grey in the corners and under the trunk.';

  @override
  String get ideasDustyAtticStep5 =>
      'Add a faint pale yellow glaze inside the shaft of light.';

  @override
  String get ideasDustyAtticStep6 =>
      'Once dry, add a few white gel specks of dust in the shaft.';

  @override
  String get ideasColourGreyBlackTitle => 'Colour, grey and black';

  @override
  String get ideasColourGreyBlackSummary =>
      'Only three markers: one colour, one grey and one very dark.';

  @override
  String get ideasColourGreyBlackPractice =>
      'Placing the light with the fewest markers you have.';

  @override
  String get ideasColourGreyBlackSubject =>
      'A bike, a boot or a teapot with one clear colour.';

  @override
  String get ideasColourGreyBlackTip =>
      'With three nibs there is nothing to decide but where the light goes. Plan the light first.';

  @override
  String get ideasColourGreyBlackStep1 =>
      'Pick a subject with one main colour and mark in pencil where the light comes from.';

  @override
  String get ideasColourGreyBlackStep2 =>
      'Colour the whole subject with the colour, and give it two layers where it turns away from the light.';

  @override
  String get ideasColourGreyBlackStep3 =>
      'Use the grey for the cast shadow and for anything that is not the subject.';

  @override
  String get ideasColourGreyBlackStep4 =>
      'Keep the dark marker for the contact lines and the deepest corners.';

  @override
  String get ideasColourGreyBlackStep5 =>
      'Step back: the drawing reads with just three values, and the grey holds them together.';

  @override
  String get ideasAnalogousTrioTitle => 'Three neighbours';

  @override
  String get ideasAnalogousTrioSummary =>
      'Three colours that sit next to each other on the wheel, and nothing from the other side.';

  @override
  String get ideasAnalogousTrioPractice =>
      'Building a scheme out of neighbouring hues.';

  @override
  String get ideasAnalogousTrioSubject =>
      'A sunflower, a sea or a field of one colour.';

  @override
  String get ideasAnalogousTrioTip =>
      'Neighbouring colours blend while wet without turning grey. Keep them wet and let them mix.';

  @override
  String get ideasAnalogousTrioStep1 =>
      'Choose a subject that is naturally one colour, such as a sunflower or a sea, and draw it.';

  @override
  String get ideasAnalogousTrioStep2 =>
      'Cover most of the subject with the middle colour of the three.';

  @override
  String get ideasAnalogousTrioStep3 =>
      'Put the neighbour on the lit side and blend it into the middle colour while it is wet.';

  @override
  String get ideasAnalogousTrioStep4 =>
      'Use the other neighbour in the shadows, away from the light.';

  @override
  String get ideasAnalogousTrioStep5 =>
      'Add the dark of the middle colour only in the deepest places, and leave the rest in the three.';

  @override
  String get ideasTriadTitle => 'A triad';

  @override
  String get ideasTriadSummary =>
      'Three colours equally spaced on the wheel; one leads and two support.';

  @override
  String get ideasTriadPractice =>
      'Using a three-colour scheme with one colour in charge.';

  @override
  String get ideasTriadSubject =>
      'A poster, a book cover or a big flower with small details.';

  @override
  String get ideasTriadTip =>
      'Keep the three colours apart on the paper. One grey over all of them ties the scheme together.';

  @override
  String get ideasTriadStep1 =>
      'Decide which of the three colours leads: it gets most of the paper.';

  @override
  String get ideasTriadStep2 =>
      'Colour the main areas with the leading colour.';

  @override
  String get ideasTriadStep3 =>
      'Use the second colour on about a quarter of the drawing, and never let it touch the first while it is wet.';

  @override
  String get ideasTriadStep4 =>
      'Use the third colour in a few small spots only.';

  @override
  String get ideasTriadStep5 =>
      'Shade all three colours with the same grey so they belong together.';

  @override
  String get ideasSplitComplementTitle => 'Split Complementary';

  @override
  String get ideasSplitComplementSummary =>
      'One colour family and the two colours on either side of its opposite.';

  @override
  String get ideasSplitComplementPractice =>
      'Balancing a main family with two colours close to its opposite.';

  @override
  String get ideasSplitComplementSubject =>
      'A vase with two flowers, or a cup with two small objects beside it.';

  @override
  String get ideasSplitComplementTip =>
      'A near-opposite reads as a clash or a harmony depending on how much of it you use.';

  @override
  String get ideasSplitComplementStep1 =>
      'Draw a subject with one big area and two small ones, such as a vase with two flowers.';

  @override
  String get ideasSplitComplementStep2 =>
      'Cover the big area with the light tone of the main family.';

  @override
  String get ideasSplitComplementStep3 =>
      'Add its shadow where the light does not reach.';

  @override
  String get ideasSplitComplementStep4 =>
      'Use one of the two opposites on the first small area.';

  @override
  String get ideasSplitComplementStep5 =>
      'Use the other opposite on the second small area and keep the two apart.';

  @override
  String get ideasTwoGrayTemperaturesTitle => 'Warm greys, cool greys';

  @override
  String get ideasTwoGrayTemperaturesSummary =>
      'Colour the same stone twice, once with warm greys and once with cool ones.';

  @override
  String get ideasTwoGrayTemperaturesPractice =>
      'Telling warm grey from cool grey by eye.';

  @override
  String get ideasTwoGrayTemperaturesSubject =>
      'The same pebble or a folded cloth, drawn twice side by side.';

  @override
  String get ideasTwoGrayTemperaturesTip =>
      'Most brands sell warm, cool and neutral greys as separate families. Pick one family for each half.';

  @override
  String get ideasTwoGrayTemperaturesStep1 =>
      'Pencil the same pebble twice, side by side, and mark the light on each.';

  @override
  String get ideasTwoGrayTemperaturesStep2 =>
      'First pebble: the light warm grey all over.';

  @override
  String get ideasTwoGrayTemperaturesStep3 =>
      'Add the darker warm grey on the shadow side and darken the contact with the ground.';

  @override
  String get ideasTwoGrayTemperaturesStep4 =>
      'Second pebble: the light cool grey all over.';

  @override
  String get ideasTwoGrayTemperaturesStep5 =>
      'Add the darker cool grey the same way, then compare: one pebble sits in the sun, the other in the shade.';

  @override
  String get ideasGrayPlusAccentTitle => 'Grey with one accent';

  @override
  String get ideasGrayPlusAccentSummary =>
      'Everything in grey except one small thing in colour.';

  @override
  String get ideasGrayPlusAccentPractice =>
      'Making one colour carry the whole drawing.';

  @override
  String get ideasGrayPlusAccentSubject =>
      'A street with a red door, or a yellow umbrella in a grey town.';

  @override
  String get ideasGrayPlusAccentTip =>
      'The accent wants to be as strong as it can be: two layers of the same marker.';

  @override
  String get ideasGrayPlusAccentStep1 =>
      'Draw a scene with one object you want the eye to land on, such as a red door in a street.';

  @override
  String get ideasGrayPlusAccentStep2 =>
      'Cover everything but that object with the light grey.';

  @override
  String get ideasGrayPlusAccentStep3 =>
      'Put the mid grey in the shadows, as if the scene were a photograph.';

  @override
  String get ideasGrayPlusAccentStep4 =>
      'Use the darkest grey for the windows, under the eaves and the contact lines.';

  @override
  String get ideasGrayPlusAccentStep5 =>
      'Colour the object alone, with two layers so the accent is as strong as it can be.';

  @override
  String get ideasEarthTonesTitle => 'Earth tones';

  @override
  String get ideasEarthTonesSummary =>
      'Browns, ochres and an olive green, nothing bright.';

  @override
  String get ideasEarthTonesPractice =>
      'Layering low-chroma colours without them going dull.';

  @override
  String get ideasEarthTonesSubject => 'Bread, a basket or a ploughed field.';

  @override
  String get ideasEarthTonesTip =>
      'Low-chroma colours layer well because the paper keeps lighting them from underneath.';

  @override
  String get ideasEarthTonesStep1 =>
      'Draw something that came from the land, such as bread, a basket or a ploughed field.';

  @override
  String get ideasEarthTonesStep2 =>
      'Lay the pale ochre over everything as the first layer.';

  @override
  String get ideasEarthTonesStep3 =>
      'Add the brown where the form turns away from the light.';

  @override
  String get ideasEarthTonesStep4 =>
      'Put the olive green on anything green, and let the ochre under it mute it.';

  @override
  String get ideasEarthTonesStep5 =>
      'Keep the darkest brown for the deepest places only.';

  @override
  String get ideasJewelTonesTitle => 'Jewel tones';

  @override
  String get ideasJewelTonesSummary =>
      'Deep, saturated colours with a gold accent, like a velvet box.';

  @override
  String get ideasJewelTonesPractice =>
      'Painting dark saturated colours that keep their shine.';

  @override
  String get ideasJewelTonesSubject =>
      'A few gems or bottles with a highlight planned on each.';

  @override
  String get ideasJewelTonesTip =>
      'Dark saturated ink stays glossy on marker paper. A white gel dot on top gives the glass look.';

  @override
  String get ideasJewelTonesStep1 =>
      'Draw a few simple gems or bottles and plan a highlight on each one.';

  @override
  String get ideasJewelTonesStep2 =>
      'Cover the biggest shape with the deep blue-green, in two layers.';

  @override
  String get ideasJewelTonesStep3 => 'Use the deep violet on the next shape.';

  @override
  String get ideasJewelTonesStep4 => 'Use the deep red on the smallest one.';

  @override
  String get ideasJewelTonesStep5 =>
      'Add the gold yellow to the settings or the caps, then a hard white gel dot on every highlight.';

  @override
  String get ideasLowKeyTitle => 'Dark markers only';

  @override
  String get ideasLowKeySummary =>
      'Draw with markers darker than mid grey and let a few bits of paper carry all the light.';

  @override
  String get ideasLowKeyPractice =>
      'Painting a dark picture with light left out on purpose.';

  @override
  String get ideasLowKeySubject =>
      'A cat with lit eyes, a lamp in a dark room or a profile.';

  @override
  String get ideasLowKeyTip =>
      'Dark alcohol ink covers evenly in one pass, so the white shapes you leave stay clean.';

  @override
  String get ideasLowKeyStep1 =>
      'Plan the drawing as a few shapes of paper left white on a dark field: a cat\'s eyes, a lamp, a profile.';

  @override
  String get ideasLowKeyStep2 =>
      'Cover everything except the white shapes with the least dark marker.';

  @override
  String get ideasLowKeyStep3 => 'Use the middle marker on the bigger shadows.';

  @override
  String get ideasLowKeyStep4 =>
      'Put the darkest marker on the edges of the light shapes, so they glow by contrast.';

  @override
  String get ideasLowKeyStep5 =>
      'Add white gel on one or two points only, no more.';

  @override
  String get ideasComplementGradientTitle => 'Through the middle';

  @override
  String get ideasComplementGradientSummary =>
      'Blend two opposite colours into each other and see the grey they make where they meet.';

  @override
  String get ideasComplementGradientPractice =>
      'Mixing two colours on the paper and reading the result.';

  @override
  String get ideasComplementGradientSubject =>
      'A long strip of paper with the two colours meeting in the middle.';

  @override
  String get ideasComplementGradientTip =>
      'Wet opposites mix on the paper at once. Keep both damp and let them meet in the middle.';

  @override
  String get ideasComplementGradientStep1 => 'Tape a long strip of paper down.';

  @override
  String get ideasComplementGradientStep2 =>
      'Fill the left third and fade the colour out towards the middle.';

  @override
  String get ideasComplementGradientStep3 =>
      'Fill the right third and fade it into the middle while the first colour is still damp.';

  @override
  String get ideasComplementGradientStep4 =>
      'Compare the muddy middle with a stroke of your grey next to it.';

  @override
  String get ideasComplementGradientStep5 =>
      'Redo the strip with the grey laid in the middle first and the two colours blended into it: a cleaner way through.';

  @override
  String get ideasWarmLightCoolShadowTitle => 'Warm light, cool shadow';

  @override
  String get ideasWarmLightCoolShadowSummary =>
      'One object, lit side in warm colours and shadow side in cool ones.';

  @override
  String get ideasWarmLightCoolShadowPractice =>
      'Glazing warm and cool over one base colour.';

  @override
  String get ideasWarmLightCoolShadowSubject =>
      'A round fruit, an egg or a ball.';

  @override
  String get ideasWarmLightCoolShadowTip =>
      'Leave a thin band of the plain base between the warm and the cool: it keeps the form turning.';

  @override
  String get ideasWarmLightCoolShadowStep1 =>
      'Draw a round object and mark where the light comes from.';

  @override
  String get ideasWarmLightCoolShadowStep2 =>
      'Cover the whole object with its own colour.';

  @override
  String get ideasWarmLightCoolShadowStep3 =>
      'Glaze the warm colour over the lit half and blend it into the base while it is wet.';

  @override
  String get ideasWarmLightCoolShadowStep4 =>
      'Glaze the cool colour over the shadow half, and leave a thin band of plain base between the two.';

  @override
  String get ideasWarmLightCoolShadowStep5 =>
      'Keep the darkest marker for the contact with the ground only.';

  @override
  String get ideasVividAndMutedTitle => 'Vivid and muted';

  @override
  String get ideasVividAndMutedSummary =>
      'Colour the same flower with a bright pair and then a muted pair of the same hue.';

  @override
  String get ideasVividAndMutedPractice =>
      'Telling a vivid colour from its dusty version.';

  @override
  String get ideasVividAndMutedSubject =>
      'The same flower drawn twice, side by side.';

  @override
  String get ideasVividAndMutedTip =>
      'Most ranges carry a vivid and a dusty version of each hue. Choosing between them is the whole exercise.';

  @override
  String get ideasVividAndMutedStep1 =>
      'Pencil the same flower twice, side by side.';

  @override
  String get ideasVividAndMutedStep2 => 'First flower: the vivid light tone.';

  @override
  String get ideasVividAndMutedStep3 => 'Add the vivid shadow of the same hue.';

  @override
  String get ideasVividAndMutedStep4 =>
      'Second flower: the muted light tone of the same hue.';

  @override
  String get ideasVividAndMutedStep5 =>
      'Add its muted shadow, then decide which flower would go in the foreground of a drawing and which in the background.';

  @override
  String get ideasOneMarkerBlenderTitle => 'One marker and the blender';

  @override
  String get ideasOneMarkerBlenderSummary =>
      'Four values out of one dark marker by diluting it with the colourless blender.';

  @override
  String get ideasOneMarkerBlenderPractice =>
      'Diluting ink to get lighter values without another marker.';

  @override
  String get ideasOneMarkerBlenderSubject =>
      'Four small squares of paper taped side by side.';

  @override
  String get ideasOneMarkerBlenderTip =>
      'The blender is pure solvent: it turns a single dark marker into its own light family.';

  @override
  String get ideasOneMarkerBlenderStep1 =>
      'Tape four small squares of paper side by side.';

  @override
  String get ideasOneMarkerBlenderStep2 =>
      'Fill the first square with the marker at full strength.';

  @override
  String get ideasOneMarkerBlenderStep3 =>
      'Second square: one stroke of marker, then the blender over it while it is wet.';

  @override
  String get ideasOneMarkerBlenderStep4 =>
      'Third square: blender first, then marker into the wet blender. Fourth: touch the marker to the blender nib and paint with the blender only.';

  @override
  String get ideasOneMarkerBlenderStep5 =>
      'Line them up: a four-step ladder out of a single marker.';

  @override
  String get ideasColourWheelTitle => 'Your colour wheel';

  @override
  String get ideasColourWheelSummary =>
      'Lay out twelve of your markers as a wheel and find the gaps in your collection.';

  @override
  String get ideasColourWheelPractice =>
      'Reading a colour wheel with the markers you own.';

  @override
  String get ideasColourWheelSubject =>
      'A circle about ten centimetres across, divided into twelve wedges.';

  @override
  String get ideasColourWheelTip =>
      'A marker wheel is a shopping list and a mixing guide on one page.';

  @override
  String get ideasColourWheelStep1 =>
      'Trace a circle round a cup and divide it into twelve wedges.';

  @override
  String get ideasColourWheelStep2 =>
      'Pick the marker closest to pure yellow, then to red and then to blue, and fill their wedges, four wedges apart.';

  @override
  String get ideasColourWheelStep3 =>
      'Fill the wedges between with the closest markers you own: orange, green, violet, then the six in-betweens.';

  @override
  String get ideasColourWheelStep4 =>
      'Write each code under its wedge. An empty or doubtful wedge is a marker you might want next.';

  @override
  String get ideasDeepSkinTitle => 'Deep skin tones';

  @override
  String get ideasDeepSkinSummary =>
      'Colour a face in deep skin tones, with a warm light and a reddish blush.';

  @override
  String get ideasDeepSkinPractice =>
      'Shading deep skin with a long range of one hue.';

  @override
  String get ideasDeepSkinSubject =>
      'A face in three-quarter view, lit from the front.';

  @override
  String get ideasDeepSkinTip =>
      'Deep skin needs a long lightness range in one hue, which marker families are built for.';

  @override
  String get ideasDeepSkinStep1 =>
      'Pencil a face and mark the forehead, the nose and the cheekbones as the lit planes.';

  @override
  String get ideasDeepSkinStep2 =>
      'Cover the whole face with the lightest brown.';

  @override
  String get ideasDeepSkinStep3 =>
      'While the first layer is damp, add the red-brown on the cheeks and the lips.';

  @override
  String get ideasDeepSkinStep4 =>
      'Add the base brown everywhere except on the lit planes.';

  @override
  String get ideasDeepSkinStep5 =>
      'Use the darkest marker under the brows, the nose, the lower lip and the jaw, and leave the lit planes with only the first layer.';

  @override
  String get ideasBlackObjectTitle => 'Black without black';

  @override
  String get ideasBlackObjectSummary =>
      'Colour a black cat or boot with dark blues and violets, saving the black marker for last.';

  @override
  String get ideasBlackObjectPractice =>
      'Building a dark object out of dark colours instead of black.';

  @override
  String get ideasBlackObjectSubject =>
      'A black cat, a boot or a shiny kettle.';

  @override
  String get ideasBlackObjectTip =>
      'A flat black marker kills the form. Layered dark colours keep it.';

  @override
  String get ideasBlackObjectStep1 =>
      'Pencil the object and the shape of its reflections: black things mirror the sky and the room.';

  @override
  String get ideasBlackObjectStep2 =>
      'Use the pale cool grey-blue on the reflections and the top planes.';

  @override
  String get ideasBlackObjectStep3 =>
      'Cover most of the object with the dark blue.';

  @override
  String get ideasBlackObjectStep4 => 'Use the dark violet on the underside.';

  @override
  String get ideasBlackObjectStep5 =>
      'Keep the darkest marker for the deepest creases, and add a white gel glint if the surface is shiny.';

  @override
  String get ideasWhiteObjectTitle => 'White without white';

  @override
  String get ideasWhiteObjectSummary =>
      'A white cup or egg with pale greys, one tinted shadow and plenty of untouched paper.';

  @override
  String get ideasWhiteObjectPractice =>
      'Painting a white object without painting over the paper.';

  @override
  String get ideasWhiteObjectSubject =>
      'A white cup, an egg or a folded napkin.';

  @override
  String get ideasWhiteObjectTip =>
      'A white object is mostly paper. Markers reward leaving it alone.';

  @override
  String get ideasWhiteObjectStep1 =>
      'Pencil the object and mark the lit side: that side stays paper.';

  @override
  String get ideasWhiteObjectStep2 =>
      'Use the very pale tinted marker on the shadow side only.';

  @override
  String get ideasWhiteObjectStep3 =>
      'Put the light grey inside that, towards the darkest part.';

  @override
  String get ideasWhiteObjectStep4 =>
      'Use the slightly darker cool grey only along the edge furthest from the light and where the object meets the table.';

  @override
  String get ideasWhiteObjectStep5 =>
      'Add a hint of the colour of the table reflected into the underside of the object.';

  @override
  String get ideasFeatheredEdgeTitle => 'Feathered edge';

  @override
  String get ideasFeatheredEdgeSummary =>
      'Make one side of a shape fade into white paper and keep the other side crisp.';

  @override
  String get ideasFeatheredEdgePractice =>
      'A soft edge next to a hard one: the simplest way to give a shape light.';

  @override
  String get ideasFeatheredEdgeSubject => 'A leaf, a petal or a fold of cloth.';

  @override
  String get ideasFeatheredEdgeTip =>
      'Lift the nib as you go: the ink runs out of the stroke on its own.';

  @override
  String get ideasFeatheredEdgeStep1 =>
      'Pencil a leaf and decide which edge is in the light.';

  @override
  String get ideasFeatheredEdgeStep2 =>
      'Colour the dark edge with the base in short strokes that all point towards the light side.';

  @override
  String get ideasFeatheredEdgeStep3 =>
      'Pull the light marker from the middle out over the ends of those strokes, lifting the nib as you go so each stroke dies out.';

  @override
  String get ideasFeatheredEdgeStep4 =>
      'Go over the join again, always moving from colour into white.';

  @override
  String get ideasFeatheredEdgeStep5 =>
      'Compare the two edges: one soft, one hard. That contrast is what makes the shape read.';

  @override
  String get ideasTipToTipTitle => 'Tip to tip';

  @override
  String get ideasTipToTipSummary =>
      'Load a dark colour onto a light marker nib and lay a gradient in one pass.';

  @override
  String get ideasTipToTipPractice =>
      'Borrowing ink from one marker to another for a quick gradient.';

  @override
  String get ideasTipToTipSubject =>
      'A strip of paper the width of two fingers.';

  @override
  String get ideasTipToTipTip =>
      'Hold the dark marker still: the light nib only takes ink from the tip.';

  @override
  String get ideasTipToTipStep1 =>
      'Tape a strip about the width of two fingers.';

  @override
  String get ideasTipToTipStep2 =>
      'Hold the dark marker still and touch the light marker nib to it for a couple of seconds.';

  @override
  String get ideasTipToTipStep3 =>
      'Start at the bottom of the strip with the loaded nib: the first strokes are dark, then the colour of the marker comes back.';

  @override
  String get ideasTipToTipStep4 =>
      'Scribble the nib on a scrap until it runs clean again: the light marker is not spoilt.';

  @override
  String get ideasTipToTipStep5 =>
      'Repeat on a second strip, loading the nib for longer: the dark part reaches further.';

  @override
  String get ideasBlenderPatternTitle => 'Blender patterns';

  @override
  String get ideasBlenderPatternSummary =>
      'Lift dots and lines out of a flat colour with the colourless blender.';

  @override
  String get ideasBlenderPatternPractice =>
      'Moving ink instead of erasing it: dots, lines and patterns.';

  @override
  String get ideasBlenderPatternSubject =>
      'A square of colour to draw the pattern on.';

  @override
  String get ideasBlenderPatternTip =>
      'Wait between touches: two marks too close run into one.';

  @override
  String get ideasBlenderPatternStep1 =>
      'Fill a square with the base and let it dry fully.';

  @override
  String get ideasBlenderPatternStep2 =>
      'Press the fine point of the blender into the colour and hold for a second: a pale dot opens with a darker rim.';

  @override
  String get ideasBlenderPatternStep3 =>
      'Draw a line with the broad nib of the blender: the pushed ink gathers at the edges.';

  @override
  String get ideasBlenderPatternStep4 =>
      'Make a pattern: polka dots, stripes or a row of fish scales.';

  @override
  String get ideasBlenderPatternStep5 =>
      'Wait between the touches or the dots run together.';

  @override
  String get ideasOneMarkerLayersTitle => 'One marker, three layers';

  @override
  String get ideasOneMarkerLayersSummary =>
      'Shade a cube with a single marker by layering one, two and three passes.';

  @override
  String get ideasOneMarkerLayersPractice =>
      'How much range one marker has when the layers dry one on top of the other.';

  @override
  String get ideasOneMarkerLayersSubject =>
      'A cube with the light coming from one top corner.';

  @override
  String get ideasOneMarkerLayersTip =>
      'Let every layer dry: a wet second pass moves the ink instead of darkening it.';

  @override
  String get ideasOneMarkerLayersStep1 =>
      'Pencil a cube with the light coming from one top corner.';

  @override
  String get ideasOneMarkerLayersStep2 => 'One pass on every face. Let it dry.';

  @override
  String get ideasOneMarkerLayersStep3 =>
      'A second pass on the two faces away from the light.';

  @override
  String get ideasOneMarkerLayersStep4 =>
      'A third pass only on the darkest face and along the bottom edges.';

  @override
  String get ideasOneMarkerLayersStep5 =>
      'Look at the three values: that is how much range a single marker has.';

  @override
  String get ideasStipplePeelTitle => 'Stippled orange peel';

  @override
  String get ideasStipplePeelSummary =>
      'Build the dimpled texture of a citrus peel with dots over a blend.';

  @override
  String get ideasStipplePeelPractice =>
      'Stippling on top of a dry blend, without smearing it.';

  @override
  String get ideasStipplePeelSubject =>
      'An orange with a soft highlight on its upper side.';

  @override
  String get ideasStipplePeelTip =>
      'Use the fine point of the nib: it gives clean specks.';

  @override
  String get ideasStipplePeelStep1 =>
      'Pencil an orange and a soft highlight on its upper side.';

  @override
  String get ideasStipplePeelStep2 =>
      'Fill the orange, keeping the highlight paler.';

  @override
  String get ideasStipplePeelStep3 =>
      'Blend the base into the shadow half while it is wet.';

  @override
  String get ideasStipplePeelStep4 =>
      'Once dry, tap the fine point of the shadow marker in loose dots, closer together in the shadow and almost none near the highlight.';

  @override
  String get ideasStipplePeelStep5 =>
      'Tap a few light dots inside the shadow dots to break them up.';

  @override
  String get ideasClearGlassTitle => 'A clear glass';

  @override
  String get ideasClearGlassSummary =>
      'Colour an empty drinking glass with greys and almost nothing else.';

  @override
  String get ideasClearGlassPractice =>
      'Grey and white paper: the lightest way to draw glass.';

  @override
  String get ideasClearGlassSubject =>
      'A tumbler with the rim, the foot and two vertical highlights.';

  @override
  String get ideasClearGlassTip =>
      'Glass is darkest where it is thickest: the rim and the foot.';

  @override
  String get ideasClearGlassStep1 =>
      'Pencil the glass and mark the rim, the base and two vertical highlights that stay white paper.';

  @override
  String get ideasClearGlassStep2 =>
      'Colour the glass with the lightest grey, leaving the highlights and most of the middle white.';

  @override
  String get ideasClearGlassStep3 =>
      'Darken the rim, the thick base and the far edge: glass is darkest where it is thickest.';

  @override
  String get ideasClearGlassStep4 =>
      'Lay a patch of colour behind the glass and let a paler version of it show through the glass, over the light grey.';

  @override
  String get ideasClearGlassStep5 =>
      'White gel on the rim and the base edge for the sharpest glints.';

  @override
  String get ideasPolishedMetalTitle => 'Polished metal';

  @override
  String get ideasPolishedMetalSummary =>
      'Make a spoon look like metal with hard bands of grey and one reflected colour.';

  @override
  String get ideasPolishedMetalPractice =>
      'Hard-edged bands and a long range of values: how metal reads.';

  @override
  String get ideasPolishedMetalSubject =>
      'A spoon with the bands of its reflection drawn in.';

  @override
  String get ideasPolishedMetalTip =>
      'Metal has no soft transitions: keep the edges of the bands crisp.';

  @override
  String get ideasPolishedMetalStep1 =>
      'Pencil the spoon and draw its reflections as bands: a dark one across the bowl, a light one next to it, no soft transitions.';

  @override
  String get ideasPolishedMetalStep2 =>
      'Fill the bowl and the handle with the lightest grey.';

  @override
  String get ideasPolishedMetalStep3 =>
      'Lay the dark bands with crisp edges, following the curve of the bowl.';

  @override
  String get ideasPolishedMetalStep4 =>
      'Put the darkest grey right next to the brightest band: metal lives on that contrast.';

  @override
  String get ideasPolishedMetalStep5 =>
      'Let a smudge of the colour of the table reflect in the lower half of the bowl, then white gel on the sharpest glint.';

  @override
  String get ideasCastShadowTitle => 'The shadow on the table';

  @override
  String get ideasCastShadowSummary =>
      'Draw a cup and get its cast shadow right: dark at the contact, soft further away.';

  @override
  String get ideasCastShadowPractice =>
      'Cast shadows: the contact line, the fade and the grey that draws them.';

  @override
  String get ideasCastShadowSubject =>
      'A cup on a table, with the light from one side.';

  @override
  String get ideasCastShadowTip =>
      'The shadow starts where the object touches the table, not where the light ends.';

  @override
  String get ideasCastShadowStep1 =>
      'Pencil a cup and the shape of its shadow on the table, longer on the side away from the light.';

  @override
  String get ideasCastShadowStep2 =>
      'Colour the cup; shade its far side with the same marker in a second layer.';

  @override
  String get ideasCastShadowStep3 =>
      'Fill the cast shadow with the grey, starting at the base of the cup and lifting as you move away.';

  @override
  String get ideasCastShadowStep4 =>
      'Add a thin dark line where the cup touches the table.';

  @override
  String get ideasCastShadowStep5 =>
      'Soften the far edge of the shadow with a second light touch of grey while the first is still damp.';

  @override
  String get ideasSoftCloudsTitle => 'Soft clouds';

  @override
  String get ideasSoftCloudsSummary =>
      'Colour the sky around the clouds and leave the clouds as paper.';

  @override
  String get ideasSoftCloudsPractice =>
      'Negative painting: the shape is the paper you did not touch.';

  @override
  String get ideasSoftCloudsSubject =>
      'Two or three clouds with round tops and flat bottoms.';

  @override
  String get ideasSoftCloudsTip =>
      'Work around the clouds with the broad nib: their edges keep a ragged look.';

  @override
  String get ideasSoftCloudsStep1 =>
      'Pencil two or three cloud shapes very lightly: round tops, flatter bottoms.';

  @override
  String get ideasSoftCloudsStep2 =>
      'Fill the sky with the light blue, working around the clouds with the broad nib so their edges stay a bit ragged.';

  @override
  String get ideasSoftCloudsStep3 =>
      'Darken the sky towards the top and blend down into the light blue while it is wet.';

  @override
  String get ideasSoftCloudsStep4 =>
      'Shade the underside of each cloud with the light grey, keeping the tops white.';

  @override
  String get ideasSoftCloudsStep5 =>
      'Soften any hard sky edge against a cloud with the blender, pushing the colour outwards.';

  @override
  String get ideasStillWaterTitle => 'Reflection in still water';

  @override
  String get ideasStillWaterSummary =>
      'Draw a tree on a bank and its upside-down, slightly darker copy in the water.';

  @override
  String get ideasStillWaterPractice =>
      'Glazing a colour over another one: how a reflection is made.';

  @override
  String get ideasStillWaterSubject =>
      'A tree on a bank with its reflection in the water below.';

  @override
  String get ideasStillWaterTip =>
      'Paint the reflection in horizontal strokes only: the water moves sideways.';

  @override
  String get ideasStillWaterStep1 =>
      'Pencil a horizon line, a simple tree above it and its mirror image below.';

  @override
  String get ideasStillWaterStep2 =>
      'Colour the tree; colour its reflection with the same marker in horizontal strokes only.';

  @override
  String get ideasStillWaterStep3 =>
      'Lay the light blue over the whole water area, including the reflection, in long horizontal strokes.';

  @override
  String get ideasStillWaterStep4 =>
      'Darken the water near the bank and the far edge; a few broken horizontal lines of base across the reflection.';

  @override
  String get ideasStillWaterStep5 =>
      'Put the dark blue where the bank meets the water, then two or three thin white gel lines for ripples.';

  @override
  String get ideasTwistedRibbonTitle => 'Twisted ribbon';

  @override
  String get ideasTwistedRibbonSummary =>
      'Blend a gradient that bends with a ribbon as it twists over and under itself.';

  @override
  String get ideasTwistedRibbonPractice =>
      'Repeating a short blend on every turn of a shape.';

  @override
  String get ideasTwistedRibbonSubject =>
      'A ribbon with two twists, over and under itself.';

  @override
  String get ideasTwistedRibbonTip =>
      'Blend along the curve of the ribbon, never straight across it.';

  @override
  String get ideasTwistedRibbonStep1 =>
      'Pencil a ribbon with two twists; mark which segments show the front and which the back.';

  @override
  String get ideasTwistedRibbonStep2 =>
      'Fill every segment with the light marker.';

  @override
  String get ideasTwistedRibbonStep3 =>
      'On each segment, add the base on the side that curves away from you, in strokes that follow the curve and not straight across.';

  @override
  String get ideasTwistedRibbonStep4 =>
      'Darken only where a segment passes under another, as a narrow band right at the overlap.';

  @override
  String get ideasTwistedRibbonStep5 =>
      'Blend with the blender along each band where the gradient looks stepped.';

  @override
  String get ideasNoLineLeafTitle => 'No-line colouring';

  @override
  String get ideasNoLineLeafSummary =>
      'Colour a leaf from a pencil sketch and let the edges of the colour do the work of the outline.';

  @override
  String get ideasNoLineLeafPractice =>
      'Drawing without a liner: the edge of the colour is the outline.';

  @override
  String get ideasNoLineLeafSubject => 'A simple leaf with its central vein.';

  @override
  String get ideasNoLineLeafTip =>
      'Lift the pencil with a soft eraser until you can only just see it.';

  @override
  String get ideasNoLineLeafStep1 =>
      'Draw the leaf and its central vein very lightly in pencil, then lift most of the graphite with a soft eraser until you can only just see it.';

  @override
  String get ideasNoLineLeafStep2 =>
      'Fill the leaf; stop exactly at the pencil line.';

  @override
  String get ideasNoLineLeafStep3 =>
      'Shade one half and the base of the leaf while the first layer is damp.';

  @override
  String get ideasNoLineLeafStep4 =>
      'Define the edge on the shadow side with a thin line of the darkest marker instead of a liner.';

  @override
  String get ideasNoLineLeafStep5 =>
      'Erase any pencil still showing once the ink is dry.';

  @override
  String get ideasShortFurTitle => 'Short fur';

  @override
  String get ideasShortFurSummary =>
      'Colour the ear of a cat with short flicks in two directions.';

  @override
  String get ideasShortFurPractice =>
      'Short strokes that follow the direction the hair grows.';

  @override
  String get ideasShortFurSubject =>
      'A cat ear with a few arrows showing the way the fur grows.';

  @override
  String get ideasShortFurTip =>
      'Flick from the roots outwards: press, move fast and lift.';

  @override
  String get ideasShortFurStep1 =>
      'Pencil the ear and draw the direction the fur grows with a few arrows.';

  @override
  String get ideasShortFurStep2 =>
      'Fill the ear with the light marker, flicking outward at the rim so the edge is furry and not solid.';

  @override
  String get ideasShortFurStep3 =>
      'Short flicks of base from the inner edge outward, following the arrows.';

  @override
  String get ideasShortFurStep4 =>
      'Fewer and darker flicks inside the ear and at the base where it meets the head.';

  @override
  String get ideasShortFurStep5 =>
      'Flick the light marker back over the joins to merge the layers and soften the darkest flicks.';

  @override
  String get ideasWoodGrainTitle => 'Wood plank';

  @override
  String get ideasWoodGrainSummary =>
      'A plank with grain lines and a knot, in three browns.';

  @override
  String get ideasWoodGrainPractice =>
      'Long strokes that follow the shape of the material.';

  @override
  String get ideasWoodGrainSubject =>
      'A wooden plank with a knot near one end.';

  @override
  String get ideasWoodGrainTip =>
      'The grain flows around the knot: draw the lines bending, never straight.';

  @override
  String get ideasWoodGrainStep1 =>
      'Pencil a plank and a knot; the grain flows around the knot like water around a stone.';

  @override
  String get ideasWoodGrainStep2 =>
      'Fill the plank with long strokes along the grain.';

  @override
  String get ideasWoodGrainStep3 =>
      'Long, slightly wavy lines of base along the grain, bunching up near the knot.';

  @override
  String get ideasWoodGrainStep4 =>
      'A few darker lines and the rings of the knot; darken the lower edge of the plank.';

  @override
  String get ideasWoodGrainStep5 =>
      'Go back over the lines with the light marker to soften where they look drawn on.';

  @override
  String get ideasBrickWallTitle => 'Brick wall';

  @override
  String get ideasBrickWallSummary =>
      'A patch of brick wall with bricks of slightly different colours and pale mortar.';

  @override
  String get ideasBrickWallPractice =>
      'Flat fills, one brick at a time, and the grey of the mortar.';

  @override
  String get ideasBrickWallSubject =>
      'A patch of wall with about twenty bricks.';

  @override
  String get ideasBrickWallTip =>
      'Leave the mortar as paper: it is lighter than any brick.';

  @override
  String get ideasBrickWallStep1 =>
      'Pencil the mortar grid; leave it as paper for now.';

  @override
  String get ideasBrickWallStep2 =>
      'Fill every brick with the light marker, letting each brick dry as a separate shape.';

  @override
  String get ideasBrickWallStep3 =>
      'Go over about half the bricks with the base, chosen at random, so the wall is not uniform.';

  @override
  String get ideasBrickWallStep4 =>
      'Shadow on the lower edge of each brick, plus a few chips and some darker bricks.';

  @override
  String get ideasBrickWallStep5 =>
      'Fill the mortar lines with the light grey.';

  @override
  String get ideasFoldedClothTitle => 'Folded cloth';

  @override
  String get ideasFoldedClothSummary =>
      'Shade the folds of a hanging cloth with four values and one direction of light.';

  @override
  String get ideasFoldedClothPractice =>
      'The same gradient repeated on every fold.';

  @override
  String get ideasFoldedClothSubject =>
      'A cloth hanging over a line, with three or four folds.';

  @override
  String get ideasFoldedClothTip =>
      'The darkest line goes only where the cloth turns under itself.';

  @override
  String get ideasFoldedClothStep1 =>
      'Pencil a cloth draped over a line, three or four folds; mark the top of each fold.';

  @override
  String get ideasFoldedClothStep2 => 'Fill the cloth.';

  @override
  String get ideasFoldedClothStep3 =>
      'Base on the side of each fold away from the light, blended into the light while it is damp.';

  @override
  String get ideasFoldedClothStep4 =>
      'Shadow deep inside each fold, where the cloth turns under.';

  @override
  String get ideasFoldedClothStep5 =>
      'A thin dark line only at the very bottom of the deepest folds; blend with the blender any hard step on the round parts.';

  @override
  String get ideasWaterDropsTitle => 'Drops on a leaf';

  @override
  String get ideasWaterDropsSummary =>
      'Three water drops on a leaf, each with a shadow, a dark edge and a bright glint.';

  @override
  String get ideasWaterDropsPractice =>
      'A few crisp marks on top of a finished blend.';

  @override
  String get ideasWaterDropsSubject =>
      'A leaf with three drops of water on it.';

  @override
  String get ideasWaterDropsTip =>
      'The drop reverses the light: shade the side that faces it.';

  @override
  String get ideasWaterDropsStep1 =>
      'Pencil a leaf and three drops; mark in each drop a small highlight on the light side.';

  @override
  String get ideasWaterDropsStep2 =>
      'Colour the whole leaf, drops included; the drops are the leaf seen through water.';

  @override
  String get ideasWaterDropsStep3 =>
      'Shade the leaf, and inside each drop shade the side towards the light, because the drop acts as a lens and reverses it.';

  @override
  String get ideasWaterDropsStep4 =>
      'A thin dark crescent on the far side of each drop and a small cast shadow under it.';

  @override
  String get ideasWaterDropsStep5 =>
      'White gel: one hard dot per drop on the light side, plus a faint lighter rim opposite it.';

  @override
  String get ideasStrawberrySeedsTitle => 'Strawberry';

  @override
  String get ideasStrawberrySeedsSummary =>
      'A strawberry whose seeds sit in small dimples, with a green cap.';

  @override
  String get ideasStrawberrySeedsPractice =>
      'Texture made of small marks: dimples, seeds and a cap.';

  @override
  String get ideasStrawberrySeedsSubject =>
      'A strawberry with a loose grid of seeds.';

  @override
  String get ideasStrawberrySeedsTip =>
      'Tap the dimples while the colour is still damp: the darker ring forms by itself.';

  @override
  String get ideasStrawberrySeedsStep1 =>
      'Pencil the strawberry and a loose grid of seed dots, closer together towards the tip.';

  @override
  String get ideasStrawberrySeedsStep2 =>
      'Fill the fruit, leaving a soft highlight.';

  @override
  String get ideasStrawberrySeedsStep3 =>
      'Blend the base around the sides; while damp, press a slightly darker dot above each seed position.';

  @override
  String get ideasStrawberrySeedsStep4 =>
      'Darken the lower half and the dimple above each seed.';

  @override
  String get ideasStrawberrySeedsStep5 =>
      'Colour the leaves and the stalk with the green, then a tiny pale gel dot in each dimple for the seed.';

  @override
  String get ideasPaletteMixingTitle => 'Mixing on a palette';

  @override
  String get ideasPaletteMixingSummary =>
      'Make a third colour by mixing two markers on a plastic surface and picking it up with the blender.';

  @override
  String get ideasPaletteMixingPractice =>
      'Mixing two inks outside the paper, with the blender as the brush.';

  @override
  String get ideasPaletteMixingSubject =>
      'A plastic lid or a blending card, plus a scrap of paper.';

  @override
  String get ideasPaletteMixingTip =>
      'The blender only carries what is wet: do not let the puddles dry.';

  @override
  String get ideasPaletteMixingStep1 =>
      'Scribble the first marker onto a non-porous scrap, such as a blending card, a plastic lid or a zip bag.';

  @override
  String get ideasPaletteMixingStep2 =>
      'Scribble the second marker next to it so the two puddles touch.';

  @override
  String get ideasPaletteMixingStep3 =>
      'Pick the mixture up with the broad nib of the colourless blender and paint a swatch with it; next to it, swatch each marker alone.';

  @override
  String get ideasPaletteMixingStep4 =>
      'Try a second mix with more of one of the two colours.';

  @override
  String get ideasPaletteMixingStep5 =>
      'Note which mixes you would like to own as a marker.';

  @override
  String get ideasLongHairTitle => 'Long hair';

  @override
  String get ideasLongHairSummary =>
      'A fall of hair with a band of light across it and strands that follow the head.';

  @override
  String get ideasLongHairPractice =>
      'Long tapered strokes and a band of light that is only paper.';

  @override
  String get ideasLongHairSubject =>
      'A head of hair with a few big locks and a band of light.';

  @override
  String get ideasLongHairTip =>
      'Press less inside the band of light: the paper does the work.';

  @override
  String get ideasLongHairStep1 =>
      'Pencil the hair as a few big locks and not as single hairs, and a curved band where the light hits.';

  @override
  String get ideasLongHairStep2 =>
      'Fill all the hair, pressing less inside the light band.';

  @override
  String get ideasLongHairStep3 =>
      'Long strokes from the parting down, each lifting as it reaches the light band, then from the ends up towards it.';

  @override
  String get ideasLongHairStep4 =>
      'Darken between the locks and under the ear and the neck.';

  @override
  String get ideasLongHairStep5 =>
      'A few thin strands of the darkest marker, then two or three fine white gel strands only inside the light band.';

  @override
  String get ideasOverlapGlazesTitle => 'Overlapping glazes';

  @override
  String get ideasOverlapGlazesSummary =>
      'Overlap three transparent circles and see which new colours appear.';

  @override
  String get ideasOverlapGlazesPractice =>
      'Transparent layers: every overlap is a real mix.';

  @override
  String get ideasOverlapGlazesSubject =>
      'Three overlapping circles, like a Venn diagram.';

  @override
  String get ideasOverlapGlazesTip =>
      'The order matters: the lighter colour on top always looks different.';

  @override
  String get ideasOverlapGlazesStep1 =>
      'Pencil three circles that overlap like a Venn diagram.';

  @override
  String get ideasOverlapGlazesStep2 =>
      'Fill the first circle and let it dry completely.';

  @override
  String get ideasOverlapGlazesStep3 =>
      'Fill the second, including the overlap; the overlap turns a third colour.';

  @override
  String get ideasOverlapGlazesStep4 =>
      'Fill the third circle; the middle, where all three meet, is the darkest mix.';

  @override
  String get ideasOverlapGlazesStep5 =>
      'Repeat with the markers in another order: the lighter one on top always looks different.';

  @override
  String get ideasFadedBackgroundTitle => 'Faded background';

  @override
  String get ideasFadedBackgroundSummary =>
      'Give a drawing a halo of colour that fades to white long before the edge of the paper.';

  @override
  String get ideasFadedBackgroundPractice =>
      'A vignette made with circular strokes and the blender.';

  @override
  String get ideasFadedBackgroundSubject =>
      'A mug, a bird or any small subject in the middle of the page.';

  @override
  String get ideasFadedBackgroundTip =>
      'Stop before you reach the edge of the paper: the halo fades on its own.';

  @override
  String get ideasFadedBackgroundStep1 =>
      'Pencil a simple subject, such as a mug or a bird, in the middle of the page.';

  @override
  String get ideasFadedBackgroundStep2 =>
      'Colour a ring of base around the subject, about a finger wide, in circular strokes.';

  @override
  String get ideasFadedBackgroundStep3 =>
      'Pull the light marker outwards from the ring in overlapping circles until it runs pale.';

  @override
  String get ideasFadedBackgroundStep4 =>
      'Follow with the blender beyond the colour, pushing the last of it into the paper so there is no edge at all.';

  @override
  String get ideasFadedBackgroundStep5 =>
      'Finish the subject so it is darker than the halo.';

  @override
  String get ideasHatchShadingTitle => 'Hatched shading';

  @override
  String get ideasHatchShadingSummary =>
      'Shade an apple with lines only, no blending: hatching for the mid-tone and cross-hatching for the shadow.';

  @override
  String get ideasHatchShadingPractice =>
      'Hatching and cross-hatching: lines that read as a tone.';

  @override
  String get ideasHatchShadingSubject =>
      'An apple with the highlight marked in.';

  @override
  String get ideasHatchShadingTip =>
      'Keep the lines parallel and evenly spaced: the eye does the rest.';

  @override
  String get ideasHatchShadingStep1 =>
      'Pencil an apple and mark the highlight.';

  @override
  String get ideasHatchShadingStep2 => 'Fill the apple flat and let it dry.';

  @override
  String get ideasHatchShadingStep3 =>
      'Hatch the shadow half with parallel lines of the fine nib, closer together as they get further from the light.';

  @override
  String get ideasHatchShadingStep4 =>
      'Cross the darkest area with a second set of lines at an angle, and add the contact shadow under the apple.';

  @override
  String get ideasHatchShadingStep5 =>
      'Step back: from a distance the lines turn into a shade.';

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
  String get ideasSeasonSpring => 'Spring';

  @override
  String get ideasSeasonSummer => 'Summer';

  @override
  String get ideasSeasonAutumn => 'Autumn';

  @override
  String get ideasSeasonWinter => 'Winter';

  @override
  String get ideasSectionAnyTime => 'Any time';

  @override
  String ideasSeeAllSemantic(int count, String category) {
    return 'See all $count ideas in $category';
  }

  @override
  String get ideasFeaturedLabel => 'Idea of the day';

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
  String get matchEmptyPhotoTitle => 'Match a colour from a photo';

  @override
  String get matchEmptyPhotoMessage =>
      'Photograph something, tap a colour on it and see the closest markers.';

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
  String get matchTakePhotoButton => 'Take a photo';

  @override
  String get matchChooseGalleryButton => 'Choose from gallery';

  @override
  String get matchValuesButton => 'Values';

  @override
  String get matchValuesTooltip =>
      'Show the photo and the matches in greyscale to check their value contrast';

  @override
  String get matchPhotoSampleHint =>
      'Double-tap to sample the middle of the photo. Use the actions to move the sample point.';

  @override
  String get matchSampleMiddle => 'Sample the middle of the photo';

  @override
  String get matchMoveLeft => 'Move the sample point left';

  @override
  String get matchMoveRight => 'Move the sample point right';

  @override
  String get matchMoveUp => 'Move the sample point up';

  @override
  String get matchMoveDown => 'Move the sample point down';

  @override
  String matchSampleSpoken(
    String hex,
    String code,
    String name,
    String quality,
  ) {
    return 'Sampled colour $hex. Closest marker: $code, $name, $quality.';
  }

  @override
  String matchSampleSpokenNone(String hex) {
    return 'Sampled colour $hex.';
  }

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
  String get commonMoreActions => 'More actions';

  @override
  String commonQualityLine(double value, String quality) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String valueString = valueNumberFormat.format(value);

    return 'ΔE $valueString · $quality';
  }

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
  String get settingsLanguageGerman => 'Deutsch';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageItalian => 'Italiano';

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
  String get settingsAiOnDeviceNotEnabledIos =>
      'To use on-device AI, turn on Apple Intelligence in Settings → Apple Intelligence & Siri.';

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
      'copic': '$input is not a Copic marker code. Try $example.',
      'finecolour': '$input is not a Finecolour marker code. Try $example.',
      'touchTwin': '$input is not a Touch Twin marker code. Try $example.',
      'promarker': '$input is not a Promarker marker code. Try $example.',
      'prismacolor':
          '$input is not a Prismacolor Premier marker code. Try $example.',
      'spectrumNoir':
          '$input is not a Spectrum Noir marker code. Try $example.',
      'promarkerBrush':
          '$input is not a Promarker Brush marker code. Try $example.',
      'arrtx': '$input is not an Arrtx marker code. Try $example.',
      'kurecolor': '$input is not a ZIG Kurecolor marker code. Try $example.',
      'graphit': '$input is not a Graph\'it marker code. Try $example.',
      'marvyLePlume':
          '$input is not a Marvy Le Plume marker code. Try $example.',
      'blickBrush':
          '$input is not a Blick Studio Brush marker code. Try $example.',
      'artistsLoft':
          '$input is not an Artist\'s Loft marker code. Try $example.',
      'other': '$input is not an Ink Lab marker code. Try $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input is not in your collection. Try $example or add it in My collection.',
      'copic':
          '$input is not in your collection. Try $example or add it in My collection.',
      'finecolour':
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
      'copic': 'There are no Copic markers in your collection yet. Add them in My collection.',
      'finecolour': 'There are no Finecolour markers in your collection yet. Add them in My collection.',
      'touchTwin': 'There are no Touch Twin markers in your collection yet. Add them in My collection.',
      'promarker': 'There are no Promarker markers in your collection yet. Add them in My collection.',
      'prismacolor': 'There are no Prismacolor Premier markers in your collection yet. Add them in My collection.',
      'spectrumNoir': 'There are no Spectrum Noir markers in your collection yet. Add them in My collection.',
      'promarkerBrush': 'There are no Promarker Brush markers in your collection yet. Add them in My collection.',
      'arrtx': 'There are no Arrtx markers in your collection yet. Add them in My collection.',
      'kurecolor': 'There are no ZIG Kurecolor markers in your collection yet. Add them in My collection.',
      'graphit': 'There are no Graph\'it markers in your collection yet. Add them in My collection.',
      'marvyLePlume': 'There are no Marvy Le Plume markers in your collection yet. Add them in My collection.',
      'blickBrush': 'There are no Blick Studio Brush markers in your collection yet. Add them in My collection.',
      'artistsLoft': 'There are no Artist\'s Loft markers in your collection yet. Add them in My collection.',
      'other': 'There are no markers in your collection yet. Add them in My collection.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Pick a base marker, such as $example, or choose Scenes as the palette type.';
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
  String get settingsLinesTitle => 'Series you own';

  @override
  String get settingsLinesHint =>
      'Pick every Ohuhu series you own. Turning a series off removes its packs from your selection.';

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
  String get swatchesLines => 'Series';

  @override
  String get swatchesLabelLine => 'Series';

  @override
  String get swatchesAllLines => 'All series';

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
  String matchBestOfRange(String brand) {
    return 'Best of the whole $brand range';
  }

  @override
  String get matchNotOwnedLine => 'Not in your collection';

  @override
  String matchSeeAll(int count) {
    return 'See all ($count)';
  }

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
  String collectionTickManyTitle(int count) {
    return 'Tick $count markers?';
  }

  @override
  String get collectionTickManyBody =>
      'They all count as markers you own. You can take them out again with “Untick all”.';

  @override
  String get collectionUntickVisible => 'Untick all';

  @override
  String get collectionInYourSets => 'In your set';

  @override
  String get collectionNoResults => 'No marker matches the search.';

  @override
  String get collectionReset => 'Reset collection';

  @override
  String get collectionOwnedGroup => 'What you own';

  @override
  String get collectionShoppingGroup => 'Shopping';

  @override
  String get collectionToolsGroup => 'Tools';

  @override
  String get toolsMapTitle => 'Colour map';

  @override
  String get toolsMapHint =>
      'Where your markers sit by hue and value, and where the gaps are.';

  @override
  String get toolsTranslateTitle => 'Translate a recipe';

  @override
  String get toolsTranslateHint =>
      'Turn a tutorial\'s marker codes into the closest ones you own.';

  @override
  String get toolsBlendsTitle => 'My recipes';

  @override
  String get toolsBlendsHint =>
      'Blends you save: markers in order, a note and a photo.';

  @override
  String get toolsTransferTitle => 'Export and import';

  @override
  String get toolsTransferHint =>
      'Share your markers as a list or CSV, or add many by code.';

  @override
  String get toolsMapEmptyTitle => 'No markers to map yet';

  @override
  String get toolsMapIntro =>
      'Each dot is a marker you own. Hatched areas have none.';

  @override
  String get toolsMapShowRange => 'Show the whole range';

  @override
  String get toolsMapShowRangeHint =>
      'Faint dots for every marker of your brands, to see what is missing.';

  @override
  String get toolsMapAxes =>
      'Left to right: hue. Top to bottom: light to dark.';

  @override
  String get toolsMapGreysTitle => 'Greys and neutrals';

  @override
  String get toolsMapGreysAxis => 'Left to right: dark to light.';

  @override
  String get toolsMapFamiliesTitle => 'By hue';

  @override
  String get toolsHueRed => 'Red';

  @override
  String get toolsHueOrange => 'Orange';

  @override
  String get toolsHueYellow => 'Yellow';

  @override
  String get toolsHueGreen => 'Green';

  @override
  String get toolsHueTeal => 'Teal';

  @override
  String get toolsHueBlue => 'Blue';

  @override
  String get toolsHueViolet => 'Violet';

  @override
  String get toolsHueMagenta => 'Magenta';

  @override
  String toolsFamilyBands(int light, int mid, int dark) {
    return 'Light $light · Mid $mid · Dark $dark';
  }

  @override
  String get toolsMapDriedNote => 'Dried-out markers are left out.';

  @override
  String toolsMapSummary(String markers, int empty, int cells) {
    return 'Colour map of $markers. $empty of $cells areas have no marker. The list below has the same markers by hue.';
  }

  @override
  String get toolsMarkerOwned => 'In your collection';

  @override
  String get toolsMarkerNotOwned => 'Not in your collection';

  @override
  String get toolsTranslateIntro =>
      'Type or paste the marker codes of a tutorial, in the brand it uses. Commas, spaces and lists all work.';

  @override
  String get toolsTranslateBrand => 'Recipe brand';

  @override
  String get toolsTranslateCodes => 'Marker codes';

  @override
  String get toolsTranslateResults => 'Translation';

  @override
  String get toolsTranslateEmpty => 'The codes you type appear here.';

  @override
  String get toolsTranslateMine => 'Closest you own';

  @override
  String get toolsTranslateNotOwned => 'Not owned';

  @override
  String get toolsTranslateMissing => 'Nothing close in your collection.';

  @override
  String toolsTranslateUnknown(String brand) {
    return 'Not found in $brand';
  }

  @override
  String get toolsCopyList => 'Copy list';

  @override
  String get toolsShareList => 'Share list';

  @override
  String get toolsListCopied => 'List copied.';

  @override
  String get toolsShareFailed => 'Could not share the list.';

  @override
  String get toolsBlendsNew => 'New recipe';

  @override
  String get toolsBlendsEditTitle => 'Edit recipe';

  @override
  String get toolsBlendsEmptyTitle => 'No recipes yet';

  @override
  String get toolsBlendsEmptyBody =>
      'Save the blends you like: markers in order, a note and a photo.';

  @override
  String get toolsBlendsName => 'Recipe name';

  @override
  String get toolsBlendsMarkersTitle => 'Markers, in order';

  @override
  String get toolsBlendsMarkersHelp => 'Drag the handle to change the order.';

  @override
  String get toolsBlendsDrag => 'Drag to reorder';

  @override
  String toolsBlendsRemoveMarker(String code) {
    return 'Remove $code';
  }

  @override
  String get toolsBlendsNote => 'Note';

  @override
  String get toolsBlendsPhotoTitle => 'Photo of the result';

  @override
  String get toolsBlendsPhotoHelp => 'Optional. It stays on this phone.';

  @override
  String get toolsBlendsPhotoSemantic => 'Photo of the recipe';

  @override
  String get toolsBlendsSave => 'Save recipe';

  @override
  String get toolsBlendsDelete => 'Delete recipe';

  @override
  String get toolsBlendsDeleteTitle => 'Delete this recipe?';

  @override
  String get toolsBlendsDeleteBody =>
      'The recipe and its photo will be removed from this phone.';

  @override
  String get toolsTransferExport => 'Export';

  @override
  String toolsTransferBrands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count brands',
      one: '1 brand',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferExportBrands(String brands) {
    return 'Includes every brand you own: $brands.';
  }

  @override
  String get toolsTransferCsv => 'Share as CSV';

  @override
  String get toolsTransferImport => 'Import by code';

  @override
  String get toolsTransferImportHelp =>
      'Choose the brand and paste its codes. Nothing is added until you press the button.';

  @override
  String get toolsTransferNew => 'New markers';

  @override
  String get toolsTransferAlready => 'Already yours';

  @override
  String get toolsTransferUnknown => 'Not recognised';

  @override
  String toolsTransferAdd(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Add $count markers',
      one: 'Add 1 marker',
      zero: 'Add markers',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers added.',
      one: '1 marker added.',
    );
    return '$_temp0';
  }

  @override
  String commonSeeAll(int count) {
    return 'See all ($count)';
  }

  @override
  String get collectionChartTitle => 'Printable swatch chart';

  @override
  String get swatchesOtherBrandsTitle => 'In other brands';

  @override
  String get swatchesOtherBrandsOnlyMine => 'Only mine';

  @override
  String get swatchesOtherBrandsNone =>
      'There is no other brand to compare with.';

  @override
  String get swatchesOtherBrandsNoneMine =>
      'You have no usable markers in other brands.';

  @override
  String get swatchesOtherBrandsFailed => 'The other brands could not be read.';

  @override
  String get swatchesOtherBrandsPaletteNote =>
      'Palettes use the brand chosen in Settings, so this marker cannot be added to one.';

  @override
  String get paletteVisionTitle => 'Colour vision';

  @override
  String get paletteVisionNormal => 'Normal';

  @override
  String get paletteVisionProtanopia => 'Protanopia';

  @override
  String get paletteVisionDeuteranopia => 'Deuteranopia';

  @override
  String get paletteVisionTritanopia => 'Tritanopia';

  @override
  String get paletteVisionAchromatopsia => 'Achromatopsia';

  @override
  String paletteVisionPairs(String pairs) {
    return 'Hard to tell apart: $pairs';
  }

  @override
  String paletteVisionPairsMore(int count) {
    return '+$count more';
  }

  @override
  String get paletteVisionNoPairs => 'Every colour stays easy to tell apart.';

  @override
  String get paletteVisionPreviewNote =>
      'Preview only. Saving and sharing keep the true colours.';

  @override
  String get paletteEaselTitle => 'Easel mode';

  @override
  String get paletteEaselExit => 'Exit easel mode';

  @override
  String get paletteShareTextButton => 'Share as text';

  @override
  String paletteTextHeader(String brand, String title) {
    return 'Ink Lab palette · $brand · $title';
  }

  @override
  String get paletteImportTitle => 'Import from text';

  @override
  String get paletteImportHint =>
      'Paste a shared palette or a list of marker codes.';

  @override
  String get paletteImportPaste => 'Paste';

  @override
  String get paletteImportAction => 'Load palette';

  @override
  String get paletteImportNothing => 'No marker codes found in this text.';

  @override
  String paletteImportNoneKnown(String brand, String codes) {
    return 'None of these codes is a $brand marker: $codes.';
  }

  @override
  String paletteImportOtherBrand(String brand) {
    return 'This palette is for $brand. Change the brand in Settings to import it.';
  }

  @override
  String paletteImportDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported a palette of $count markers.',
      one: 'Imported a palette of 1 marker.',
    );
    return '$_temp0';
  }

  @override
  String paletteImportUnknown(String codes) {
    return 'Not recognised: $codes.';
  }

  @override
  String get paletteImportRepeated => 'Repeated codes were counted once.';

  @override
  String get collectionChartHint =>
      'Empty boxes labelled with the code and name of each marker you own, to swatch your real markers. Shared as A4 images to print or save.';

  @override
  String get collectionChartShowColour => 'Catalogue colour';

  @override
  String get collectionChartShowColourHint =>
      'Show it as a thin strip in each box, to compare.';

  @override
  String get collectionChartCreate => 'Create and share';

  @override
  String get collectionChartPreparing => 'Preparing…';

  @override
  String get collectionChartEmpty => 'Choose your sets or markers first.';

  @override
  String collectionChartPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
    );
    return '$_temp0';
  }

  @override
  String get chartImageTitle => 'Swatch chart';

  @override
  String chartImagePage(int page, int total) {
    return 'Page $page of $total';
  }

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
  String collectionLooseTicked(int loose, int sets) {
    return '$loose loose ticked · $sets in your sets';
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
  String get onboardingStepFirst => 'Step 1';

  @override
  String onboardingMarkersTicked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ticked',
      one: '1 ticked',
    );
    return '$_temp0';
  }

  @override
  String onboardingMarkersNoneTicked(String range) {
    return 'None ticked yet · $range';
  }

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
  String get wishlistTitle => 'Wishlist';

  @override
  String wishlistCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers to buy',
      one: '1 marker to buy',
      zero: 'Nothing on your wishlist yet',
    );
    return '$_temp0';
  }

  @override
  String get wishlistSubtitle => 'Add them from a colour\'s details';

  @override
  String get wishlistEmpty =>
      'Add the markers you want to buy from the detail of any marker.';

  @override
  String get wishlistAdd => 'Add to wishlist';

  @override
  String get wishlistRemove => 'Remove from wishlist';

  @override
  String get wishlistCopy => 'Copy list';

  @override
  String get wishlistCopied => 'Shopping list copied';

  @override
  String get wishlistOfferTitle => 'Add to your wishlist?';

  @override
  String wishlistOfferBody(String code) {
    return '$code is dried out. Add it to your wishlist to buy a refill or a replacement.';
  }

  @override
  String get driedTitle => 'Dried out';

  @override
  String driedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dried out markers',
      one: '1 dried out marker',
      zero: 'No dried out markers',
    );
    return '$_temp0';
  }

  @override
  String get driedHint =>
      'They stay in your collection, but Match, Palette and Ideas do not suggest them.';

  @override
  String get driedEmpty =>
      'When a marker stops working, mark it as dried out from its detail.';

  @override
  String get driedMark => 'Mark as dried out';

  @override
  String get driedUnmark => 'Mark as usable';

  @override
  String get driedNote =>
      'Dried out: Match, Palette and Ideas skip it until you mark it as usable.';

  @override
  String get commonDried => 'Dried out';

  @override
  String get buyNextTitle => 'What to buy next';

  @override
  String get buyNextIntro =>
      'Markers you do not have that would bring your colours closest to the most scenes.';

  @override
  String buyNextReasonScenes(int count, String scenes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Improves $count scenes: $scenes',
      one: 'Improves 1 scene: $scenes',
    );
    return '$_temp0';
  }

  @override
  String get buyNextReasonGap => 'Fills a gap in your range of colours';

  @override
  String get buyNextNoCollection =>
      'Tick the markers you own to see what to buy next.';

  @override
  String get buyNextComplete =>
      'Nothing to suggest: your markers already cover every scene well.';

  @override
  String get buyNextRefill => 'Dried out: a refill brings it back.';

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Until you pick sets, the app shows the whole $brand range.';
  }

  @override
  String get onboardingDoneNext =>
      'What next: browse colours in Swatches, match a photo in Match or build a palette in Palette.';

  @override
  String get collectionVisibleScope =>
      'Applies to the markers that match your search.';

  @override
  String get matchWhiteBalanceButton => 'Fix white balance';

  @override
  String get matchWhiteBalanceHint =>
      'Tap a point of the photo that should be white paper.';

  @override
  String get matchWhiteBalanceOn => 'White balance on';

  @override
  String get matchWhiteBalanceReset => 'Undo';

  @override
  String get matchWhiteBalanceTooDark =>
      'That point is too dark to be paper. Pick a lighter one.';

  @override
  String get matchWhiteBalanceTooColourful =>
      'That point has too much colour to be paper. Pick a white area.';

  @override
  String get commonOwnColour => 'My colour';

  @override
  String get swatchesMyColourTitle => 'My colour';

  @override
  String get swatchesMyColourHelp =>
      'Catalogue colours are estimates. Store the colour your marker really gives on paper.';

  @override
  String get swatchesMyColourReset => 'Back to catalogue';

  @override
  String get swatchesMyColourSaved => 'Your colour was saved';

  @override
  String get swatchesMyColourWasReset => 'Back to the catalogue colour';

  @override
  String get swatchesMyColourSame => 'Same as the catalogue';

  @override
  String swatchesMyColourValue(String hex) {
    return 'Yours: $hex';
  }

  @override
  String get swatchesStatusWished => 'On your wishlist';

  @override
  String get swatchesDetailsTitle => 'Details';

  @override
  String get swatchesCatalogueLabel => 'Catalogue';

  @override
  String get swatchesMineLabel => 'Mine';

  @override
  String ownColorTitle(String code) {
    return 'My colour for $code';
  }

  @override
  String get ownColorHexLabel => 'Hex colour';

  @override
  String get ownColorHexInvalid => 'Type 3 or 6 hex digits, like 3A7F9C.';

  @override
  String get ownColorPhotoTitle => 'From a photo';

  @override
  String get ownColorPhotoHelp =>
      'Paint the marker on white paper, take a photo and tap the painted area.';

  @override
  String get ownColorPhotoTap => 'Tap the painted area.';

  @override
  String get ownColorSave => 'Save my colour';

  @override
  String get settingsOwnColors => 'Use my colours';

  @override
  String get settingsOwnColorsSubtitle =>
      'Match, Palette and Ideas use the colour you stored for a marker instead of the catalogue one.';

  @override
  String settingsOwnColorsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colours of your own',
      one: '1 colour of your own',
      zero: 'No colours of your own yet',
    );
    return '$_temp0';
  }

  @override
  String get settingsOwnColorsReset => 'Reset';

  @override
  String get settingsOwnColorsResetTitle => 'Reset your colours?';

  @override
  String get settingsOwnColorsResetBody =>
      'Every marker goes back to its catalogue colour. This cannot be undone.';

  @override
  String get settingsJoinBeta => 'Join the Google Play beta';

  @override
  String get collectionCopicHint =>
      'Copic markers are bought one by one. Tick the markers you own.';

  @override
  String get collectionFinecolourHint =>
      'Finecolour markers are bought one by one. Tick the markers you own.';

  @override
  String get onboardingCopicLine => '358 colours · Mark the markers you own';

  @override
  String get onboardingFinecolourLine =>
      '480 colours · Mark the markers you own';

  @override
  String onboardingMarkersTitle(String brand) {
    return 'Your $brand markers';
  }

  @override
  String onboardingNoMarkers(String brand) {
    return 'You have not ticked any $brand markers yet: tick them in My collection.';
  }

  @override
  String ideasNoMarkersBrand(String brand) {
    return 'Add the $brand markers you own in My collection to get a palette for this idea.';
  }

  @override
  String get ideasDiarySegment => 'Diary';

  @override
  String get ideasDiarySubtitle => 'Your artworks, newest first';

  @override
  String get diaryEmptyTitle => 'Your diary is empty';

  @override
  String get diaryEmptyMessage =>
      'Log the pages and sheets you paint, with their markers, notes and photos.';

  @override
  String get diaryAdd => 'Add to diary';

  @override
  String get diaryShareButton => 'Share this entry';

  @override
  String get diaryStatusLabel => 'Status';

  @override
  String get diaryStatusInProgress => 'In progress';

  @override
  String get diaryStatusFinished => 'Finished';

  @override
  String get diaryNewTitle => 'New entry';

  @override
  String get diaryEditTitle => 'Edit entry';

  @override
  String get diaryTitleLabel => 'Title';

  @override
  String get diaryDateLabel => 'Date';

  @override
  String get diaryOnWhatLabel => 'Painted on';

  @override
  String get diaryOnWhatHint => 'e.g. a colouring book or a sketchbook';

  @override
  String get diaryMarkersTitle => 'Markers used';

  @override
  String get diaryMarkersChoose => 'Choose markers';

  @override
  String diaryMarkerRemove(String code) {
    return 'Remove $code';
  }

  @override
  String get diaryPaletteTitle => 'Palette';

  @override
  String get diaryPaletteNone => 'No palette';

  @override
  String get diaryPaletteChoose => 'Link a saved palette';

  @override
  String get diaryPaletteMissing => 'This palette is no longer saved.';

  @override
  String get diaryPaletteEmpty => 'You have no saved palettes yet.';

  @override
  String get diaryNotesLabel => 'Notes';

  @override
  String get diaryNotesHint => 'Technique, paper, blending...';

  @override
  String get diaryMoreDetails => 'More details';

  @override
  String get diaryPhotosTitle => 'Photos';

  @override
  String diaryPhotosHelp(int count) {
    return 'Up to $count photos. They stay on this phone.';
  }

  @override
  String get diaryPhotoRemove => 'Remove photo';

  @override
  String diaryPhotoSemantic(int number, int total) {
    return 'Photo $number of $total';
  }

  @override
  String get diarySave => 'Save entry';

  @override
  String get diaryDelete => 'Delete entry';

  @override
  String get diaryDeleteTitle => 'Delete this entry?';

  @override
  String get diaryDeleteBody =>
      'The entry and its photos are removed from this phone. This cannot be undone.';

  @override
  String get diaryDeleteConfirm => 'Delete';

  @override
  String get diaryAddedNotice => 'Added to the diary';

  @override
  String diaryStatsArtworks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count artworks',
      one: '1 artwork',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsFinished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count finished',
      one: '1 finished',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsInProgress(int count) {
    return '$count in progress';
  }

  @override
  String get diaryStatsOpen => 'See the numbers';

  @override
  String get diaryStatsTitle => 'Diary numbers';

  @override
  String get diaryStatsStatusTitle => 'Finished and in progress';

  @override
  String get diaryStatsMonthsTitle => 'Entries per month';

  @override
  String diaryStatsMonthsLatest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Showing the latest $count months.',
      one: 'Showing the latest month.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsMarkersTitle => 'Markers you use most';

  @override
  String get diaryStatsMarkersEmpty => 'No entry has markers yet.';

  @override
  String diaryStatsEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries',
      one: '1 entry',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedTitle => 'Markers not used yet';

  @override
  String diaryStatsUnusedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers you own are not in any entry.',
      one: '1 marker you own is not in any entry.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedNone => 'Every marker you own is in an entry.';

  @override
  String get diaryStatsUnusedNoCollection =>
      'Add your markers in My collection to see which ones you have not used.';

  @override
  String get diaryStatsUnusedShow => 'Show the list';

  @override
  String get diaryStatsUnusedHide => 'Hide the list';

  @override
  String get diaryStatsPalettesTitle => 'Palettes you link most';

  @override
  String get diaryStatsPalettesEmpty => 'No entry links a saved palette yet.';

  @override
  String diaryShareMore(int count) {
    return '+$count more';
  }

  @override
  String get settingsLicences => 'Open-source licences';

  @override
  String get settingsLicencesSubtitle =>
      'The licences of the code, the fonts and the packages the app uses';

  @override
  String get settingsLicencesLegalese =>
      'Ink Lab code: MIT licence. Texts, ideas and documentation: CC BY-SA 4.0. Bundled fonts: SIL Open Font Licence 1.1.';

  @override
  String get settingsSendFeedback => 'Send feedback';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Opens your email app with the app and system version. You decide whether to send it.';

  @override
  String settingsFeedbackNoMail(String address) {
    return 'No email app was found. The address $address was copied.';
  }

  @override
  String get settingsErrorLogShare => 'Share error log';

  @override
  String get settingsErrorLogShareSubtitle =>
      'Technical details of the errors the app had, without your diary or your API key. Nothing is sent unless you share it.';

  @override
  String get settingsErrorLogClear => 'Clear error log';

  @override
  String get settingsErrorLogCleared => 'The error log was cleared';

  @override
  String get settingsErrorLogShareFailed => 'The error log could not be shared';

  @override
  String settingsLastBackup(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Last backup: $dateString';
  }

  @override
  String get settingsNoBackupYet => 'No backup yet';

  @override
  String get settingsBackupReminderNever =>
      'You have data in the app and no backup yet. Save a backup file to keep it safe if you change or reset your phone.';

  @override
  String get settingsBackupReminderOld =>
      'Your last backup is more than a month old. Save a new file to keep your latest work safe.';

  @override
  String get collectionTouchTwinHint => 'Mark the Touch Twin markers you own.';

  @override
  String get onboardingTouchTwinLine =>
      '202 colours · Mark the markers you own';

  @override
  String get collectionPromarkerHint => 'Mark the Promarker markers you own.';

  @override
  String get onboardingPromarkerLine =>
      '148 colours · Mark the markers you own';

  @override
  String get collectionPrismacolorHint =>
      'Mark the Prismacolor Premier markers you own.';

  @override
  String get onboardingPrismacolorLine =>
      '200 colours · Mark the markers you own';

  @override
  String get collectionSpectrumNoirHint =>
      'Mark the Spectrum Noir markers you own.';

  @override
  String get onboardingSpectrumNoirLine =>
      '216 colours · Mark the markers you own';

  @override
  String get collectionPromarkerBrushHint =>
      'Mark the Promarker Brush markers you own.';

  @override
  String get onboardingPromarkerBrushLine =>
      '72 colours · Mark the markers you own';

  @override
  String get collectionArrtxHint => 'Mark the Arrtx markers you own.';

  @override
  String get onboardingArrtxLine => '328 colours · Mark the markers you own';

  @override
  String get collectionKurecolorHint =>
      'Mark the ZIG Kurecolor markers you own.';

  @override
  String get onboardingKurecolorLine =>
      '136 colours · Mark the markers you own';

  @override
  String get collectionGraphitHint => 'Mark the Graph\'it markers you own.';

  @override
  String get onboardingGraphitLine => '168 colours · Mark the markers you own';

  @override
  String get collectionMarvyLePlumeHint =>
      'Mark the Marvy Le Plume markers you own.';

  @override
  String get onboardingMarvyLePlumeLine =>
      '144 colours · Mark the markers you own';

  @override
  String get collectionBlickBrushHint =>
      'Mark the Blick Studio Brush markers you own.';

  @override
  String get onboardingBlickBrushLine =>
      '96 colours · Mark the markers you own';

  @override
  String get collectionArtistsLoftHint =>
      'Mark the Artist\'s Loft markers you own.';

  @override
  String get onboardingArtistsLoftLine =>
      '56 colours · Mark the markers you own';

  @override
  String get shortcutMatchLabel => 'Match a colour';

  @override
  String get shortcutNewPaletteLabel => 'New palette';

  @override
  String get shortcutSearchSwatchesLabel => 'Search swatches';

  @override
  String get brandSearchHint => 'Search brands';

  @override
  String get brandGroupPopular => 'Popular';

  @override
  String get brandGroupMore => 'More brands';

  @override
  String get brandSearchEmpty => 'No brand matches your search.';

  @override
  String get brandGroupOwned => 'Your brands';

  @override
  String brandOwnedLine(int owned, int total) {
    return '$owned of $total owned';
  }

  @override
  String get navRailExpand => 'Expand menu';

  @override
  String get navRailCollapse => 'Collapse menu';

  @override
  String get inkLevelTitle => 'Ink level';

  @override
  String get inkLevelFull => 'Full';

  @override
  String get commonRunningOut => 'Running out';

  @override
  String get refillNoteTitle => 'Refill note';

  @override
  String get refillNoteEmpty => 'Add a note, like “refilled 3 Nov”';

  @override
  String get refillNoteHint => 'Refilled 3 Nov';

  @override
  String get refillNoteSave => 'Save';

  @override
  String get refillNoteRemove => 'Remove note';

  @override
  String get swatchPhotoTitle => 'Real swatch';

  @override
  String get swatchPhotoEmpty => 'Add a photo of your paper swatch';

  @override
  String get swatchPhotoHas => 'Your paper swatch';

  @override
  String get swatchPhotoView => 'View photo';

  @override
  String get swatchPhotoTake => 'Take a photo';

  @override
  String get swatchPhotoChoose => 'Choose from gallery';

  @override
  String get swatchPhotoSaved => 'Photo saved';

  @override
  String get swatchPhotoSaveFailed =>
      'The photo could not be saved. Try another one.';

  @override
  String get swatchPhotoRemoved => 'Photo removed';

  @override
  String get swatchShadowLightTitle => 'Shadow and light';

  @override
  String get swatchShadow => 'Shadow';

  @override
  String get swatchLight => 'Light';

  @override
  String get swatchShadowLightNone => 'None in your collection';

  @override
  String get swatchBlendWith => 'Blend with…';

  @override
  String get swatchBlendTitle => 'Blend with';

  @override
  String get swatchBlendSearchHint => 'Search your markers';

  @override
  String get swatchBlendNoMarkers => 'You have no other markers to blend with.';

  @override
  String get swatchBlendNoResults => 'No marker matches your search.';

  @override
  String get swatchBlendSteps => 'In between, from your collection';

  @override
  String get swatchBlendNothingBetween =>
      'These two are close enough to blend straight into each other.';

  @override
  String get swatchBlendNoneBetween =>
      'None of your markers sits between them.';

  @override
  String swatchBlendBuy(String code) {
    return 'Big jump. To fill the gap, the closest marker you do not own is $code.';
  }

  @override
  String swatchBlendStripSemantics(String from, String to) {
    return 'Gradient from $from to $to';
  }

  @override
  String swatchDuplicatesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You already have $count markers very close to this',
      one: 'You already have 1 marker very close to this',
    );
    return '$_temp0';
  }

  @override
  String get swatchDuplicatesHint =>
      'Almost the same colour, so a new one adds little.';

  @override
  String swatchDuplicatesMore(int count) {
    return 'and $count more';
  }

  @override
  String get swatchDuplicatesNone =>
      'Nothing in your collection is very close to this: it would add a new colour.';

  @override
  String wishlistDuplicateNote(String codes) {
    return 'Very close to $codes in your collection';
  }

  @override
  String wishlistRunningOutCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count markers running out',
      one: '1 marker running out',
      zero: 'Nothing running out',
    );
    return '$_temp0';
  }

  @override
  String get wishlistRunningOutHint =>
      'Still in use. Add them to your list when you want to buy or refill them.';

  @override
  String swatchesAllBrands(int count) {
    return 'All brands ($count)';
  }

  @override
  String get swatchesOtherBrandsYours => 'Your brands';

  @override
  String get inkLevelFullNote =>
      'Full: Match, Palette and Ideas can suggest it.';

  @override
  String get inkLevelRunningOutNote =>
      'Running out: still used everywhere. It shows in the Running out group of your wishlist.';

  @override
  String get swatchesDetailPaneEmpty => 'Tap a marker to see its details here.';
}
