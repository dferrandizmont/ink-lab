import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsCollectionGroup.
  ///
  /// In en, this message translates to:
  /// **'My collection'**
  String get settingsCollectionGroup;

  /// No description provided for @settingsDisplayGroup.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get settingsDisplayGroup;

  /// No description provided for @settingsDataGroup.
  ///
  /// In en, this message translates to:
  /// **'Your data'**
  String get settingsDataGroup;

  /// No description provided for @settingsAiGroup.
  ///
  /// In en, this message translates to:
  /// **'AI assistant'**
  String get settingsAiGroup;

  /// No description provided for @settingsAiOffByDefault.
  ///
  /// In en, this message translates to:
  /// **'Off by default'**
  String get settingsAiOffByDefault;

  /// No description provided for @settingsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The app services are not available, so the settings cannot be shown.'**
  String get settingsUnavailable;

  /// No description provided for @settingsBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get settingsBrandTitle;

  /// No description provided for @settingsBrandSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The brand selects the catalogue of markers the app works with.'**
  String get settingsBrandSubtitle;

  /// No description provided for @settingsPalettesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved palettes'**
  String get settingsPalettesTitle;

  /// No description provided for @settingsClearPalettes.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get settingsClearPalettes;

  /// No description provided for @settingsClearPalettesTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete every saved palette?'**
  String get settingsClearPalettesTitle;

  /// No description provided for @settingsClearPalettesBody.
  ///
  /// In en, this message translates to:
  /// **'The palettes saved for this brand will be deleted. This cannot be undone.'**
  String get settingsClearPalettesBody;

  /// No description provided for @settingsFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get settingsFavoritesTitle;

  /// No description provided for @settingsFavoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No colour is a favourite yet.'**
  String get settingsFavoritesEmpty;

  /// No description provided for @settingsClearFavorites.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get settingsClearFavorites;

  /// No description provided for @settingsClearFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove every favourite?'**
  String get settingsClearFavoritesTitle;

  /// No description provided for @settingsClearFavoritesBody.
  ///
  /// In en, this message translates to:
  /// **'The favourite colours of this brand will be removed. This cannot be undone.'**
  String get settingsClearFavoritesBody;

  /// No description provided for @settingsDeleteFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove the favourite'**
  String get settingsDeleteFavorite;

  /// No description provided for @settingsLabelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ohuhu codes'**
  String get settingsLabelsTitle;

  /// No description provided for @settingsLabelsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ohuhu renamed its codes in 2023.'**
  String get settingsLabelsSubtitle;

  /// No description provided for @settingsNewLabels.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get settingsNewLabels;

  /// No description provided for @settingsOldLabels.
  ///
  /// In en, this message translates to:
  /// **'Old'**
  String get settingsOldLabels;

  /// No description provided for @settingsBothLabels.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get settingsBothLabels;

  /// No description provided for @settingsAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceTitle;

  /// No description provided for @settingsAppearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsAppearanceSystem;

  /// No description provided for @settingsAppearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsAppearanceLight;

  /// No description provided for @settingsAppearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsAppearanceDark;

  /// No description provided for @settingsBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Copies your data (collection, palettes, diary, history and settings) to the clipboard as text, so you can import it later. Photos and the API key are not included.'**
  String get settingsBackupSubtitle;

  /// No description provided for @settingsExportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get settingsExportBackup;

  /// No description provided for @settingsImportBackup.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get settingsImportBackup;

  /// No description provided for @settingsBackupExported.
  ///
  /// In en, this message translates to:
  /// **'Backup copied to the clipboard, without the photos'**
  String get settingsBackupExported;

  /// No description provided for @settingsBackupImported.
  ///
  /// In en, this message translates to:
  /// **'Backup imported'**
  String get settingsBackupImported;

  /// No description provided for @settingsImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Import a backup'**
  String get settingsImportTitle;

  /// No description provided for @settingsImportHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the exported JSON here'**
  String get settingsImportHint;

  /// No description provided for @settingsImportConfirm.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get settingsImportConfirm;

  /// No description provided for @settingsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsCancel;

  /// No description provided for @settingsImportConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace your current data?'**
  String get settingsImportConfirmTitle;

  /// No description provided for @settingsImportConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'The backup replaces your current data: collection, palettes, diary, history and settings. Diary entries that are not in it are deleted along with their photos; photos are never part of a backup.'**
  String get settingsImportConfirmBody;

  /// No description provided for @ideasFavoritesChip.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get ideasFavoritesChip;

  /// No description provided for @ideasFavoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No favourite ideas yet'**
  String get ideasFavoritesEmptyTitle;

  /// No description provided for @ideasFavoritesEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on an idea to keep it here.'**
  String get ideasFavoritesEmptyMessage;

  /// No description provided for @ideasRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recently viewed'**
  String get ideasRecentTitle;

  /// No description provided for @settingsBackupFileCaption.
  ///
  /// In en, this message translates to:
  /// **'A ZIP file with your data and all your photos: diary, swatches and recipes. Pick Files, Drive or any app in the share sheet to keep it. The API key is never included.'**
  String get settingsBackupFileCaption;

  /// No description provided for @settingsBackupTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Copy as text (no photos)'**
  String get settingsBackupTextTitle;

  /// No description provided for @settingsSaveBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Share backup file'**
  String get settingsSaveBackupFile;

  /// No description provided for @settingsRestoreBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Restore from file'**
  String get settingsRestoreBackupFile;

  /// No description provided for @settingsBackupFileSaving.
  ///
  /// In en, this message translates to:
  /// **'Packing your data and photos…'**
  String get settingsBackupFileSaving;

  /// No description provided for @settingsBackupFileRestoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring your backup…'**
  String get settingsBackupFileRestoring;

  /// No description provided for @settingsRestoreConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'The file replaces your current data: collection, palettes, diary, history and settings. The photos in the file are restored too. Diary entries that are not in it are deleted along with their photos.'**
  String get settingsRestoreConfirmBody;

  /// No description provided for @settingsBackupFileRestored.
  ///
  /// In en, this message translates to:
  /// **'Backup restored, photos included'**
  String get settingsBackupFileRestored;

  /// No description provided for @settingsBackupFileSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'The backup file could not be created.'**
  String get settingsBackupFileSaveFailed;

  /// No description provided for @settingsBackupFileReadFailed.
  ///
  /// In en, this message translates to:
  /// **'The file could not be read.'**
  String get settingsBackupFileReadFailed;

  /// No description provided for @settingsBackupFileNotZip.
  ///
  /// In en, this message translates to:
  /// **'That file is not a backup ZIP.'**
  String get settingsBackupFileNotZip;

  /// No description provided for @settingsBackupFileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The backup is too big for Ink Lab to handle.'**
  String get settingsBackupFileTooLarge;

  /// No description provided for @settingsBackupFileEntryTooLarge.
  ///
  /// In en, this message translates to:
  /// **'A photo in the backup is too big.'**
  String get settingsBackupFileEntryTooLarge;

  /// No description provided for @settingsBackupFileDamaged.
  ///
  /// In en, this message translates to:
  /// **'The file is damaged or is not an Ink Lab backup.'**
  String get settingsBackupFileDamaged;

  /// No description provided for @settingsBackupFileUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This backup comes from a version Ink Lab cannot read.'**
  String get settingsBackupFileUnsupported;

  /// No description provided for @settingsBackupFileNotAPhoto.
  ///
  /// In en, this message translates to:
  /// **'A photo in the file is not a JPEG, PNG or WebP image.'**
  String get settingsBackupFileNotAPhoto;

  /// No description provided for @settingsBackupFileWriteFailed.
  ///
  /// In en, this message translates to:
  /// **'The photos could not be saved. Your data has not changed.'**
  String get settingsBackupFileWriteFailed;

  /// No description provided for @settingsImportInvalidJson.
  ///
  /// In en, this message translates to:
  /// **'The text is not valid JSON.'**
  String get settingsImportInvalidJson;

  /// No description provided for @settingsImportInvalidDocument.
  ///
  /// In en, this message translates to:
  /// **'The text is not a backup document.'**
  String get settingsImportInvalidDocument;

  /// No description provided for @settingsAiTitle.
  ///
  /// In en, this message translates to:
  /// **'AI assistant'**
  String get settingsAiTitle;

  /// No description provided for @settingsAiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The AI only suggests palettes. It never changes your collection.'**
  String get settingsAiSubtitle;

  /// No description provided for @settingsAiEnabled.
  ///
  /// In en, this message translates to:
  /// **'Suggest with AI'**
  String get settingsAiEnabled;

  /// No description provided for @settingsAiEnabledSubtitleColourTheory.
  ///
  /// In en, this message translates to:
  /// **'Pick On-device or OpenRouter below to use an AI'**
  String get settingsAiEnabledSubtitleColourTheory;

  /// No description provided for @settingsAiEnabledSubtitleColourTheoryNoOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Pick OpenRouter below to use an AI'**
  String get settingsAiEnabledSubtitleColourTheoryNoOnDevice;

  /// No description provided for @settingsAiEnabledSubtitleOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Gemini Nano on this phone'**
  String get settingsAiEnabledSubtitleOnDevice;

  /// No description provided for @settingsAiEnabledSubtitleOpenRouter.
  ///
  /// In en, this message translates to:
  /// **'Uses your own OpenRouter key'**
  String get settingsAiEnabledSubtitleOpenRouter;

  /// No description provided for @settingsAiExplainColourTheory.
  ///
  /// In en, this message translates to:
  /// **'Palettes come from the built-in colour-theory engine. No AI, nothing leaves your phone.'**
  String get settingsAiExplainColourTheory;

  /// No description provided for @settingsAiExplainOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Gemini Nano runs on this phone and your requests stay on it. Google\'s ML Kit sends Google usage diagnostics.'**
  String get settingsAiExplainOnDevice;

  /// No description provided for @settingsAiExplainOpenRouter.
  ///
  /// In en, this message translates to:
  /// **'Requests go to openrouter.ai with your own key. Photos are never sent.'**
  String get settingsAiExplainOpenRouter;

  /// No description provided for @settingsAiProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get settingsAiProvider;

  /// No description provided for @settingsAiProviderColourTheory.
  ///
  /// In en, this message translates to:
  /// **'Colour theory'**
  String get settingsAiProviderColourTheory;

  /// No description provided for @settingsAiProviderOnDevice.
  ///
  /// In en, this message translates to:
  /// **'On-device'**
  String get settingsAiProviderOnDevice;

  /// No description provided for @settingsAiProviderOpenRouter.
  ///
  /// In en, this message translates to:
  /// **'OpenRouter'**
  String get settingsAiProviderOpenRouter;

  /// No description provided for @settingsAiTextModel.
  ///
  /// In en, this message translates to:
  /// **'Text model'**
  String get settingsAiTextModel;

  /// No description provided for @settingsAiTextModelHint.
  ///
  /// In en, this message translates to:
  /// **'Model id used for text requests'**
  String get settingsAiTextModelHint;

  /// No description provided for @settingsAiVisionModel.
  ///
  /// In en, this message translates to:
  /// **'Vision model'**
  String get settingsAiVisionModel;

  /// No description provided for @settingsAiVisionModelHint.
  ///
  /// In en, this message translates to:
  /// **'Model id used for image requests'**
  String get settingsAiVisionModelHint;

  /// No description provided for @settingsAiTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get settingsAiTemperature;

  /// No description provided for @settingsAiMaxTokens.
  ///
  /// In en, this message translates to:
  /// **'Max tokens'**
  String get settingsAiMaxTokens;

  /// No description provided for @settingsAiAutoFallback.
  ///
  /// In en, this message translates to:
  /// **'Built-in fallback'**
  String get settingsAiAutoFallback;

  /// No description provided for @settingsAiAutoFallbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If the AI fails, the built-in engine answers instead.'**
  String get settingsAiAutoFallbackSubtitle;

  /// No description provided for @settingsAiApiKey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get settingsAiApiKey;

  /// No description provided for @settingsAiApiKeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your own key, kept in the secure store of this device.'**
  String get settingsAiApiKeySubtitle;

  /// No description provided for @settingsAiApiKeySave.
  ///
  /// In en, this message translates to:
  /// **'Save key'**
  String get settingsAiApiKeySave;

  /// No description provided for @settingsAiApiKeyRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove key'**
  String get settingsAiApiKeyRemove;

  /// No description provided for @settingsAiApiKeySaved.
  ///
  /// In en, this message translates to:
  /// **'Key saved.'**
  String get settingsAiApiKeySaved;

  /// No description provided for @settingsAiRemoveKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove the API key?'**
  String get settingsAiRemoveKeyTitle;

  /// No description provided for @settingsAiRemoveKeyBody.
  ///
  /// In en, this message translates to:
  /// **'The key is deleted from this device. AI suggestions stop until you enter a key again.'**
  String get settingsAiRemoveKeyBody;

  /// No description provided for @settingsAiRemoveKeyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get settingsAiRemoveKeyConfirm;

  /// No description provided for @settingsAiApiKeyInvalid.
  ///
  /// In en, this message translates to:
  /// **'That does not look like an OpenRouter key. It should start with sk-or- and have no spaces.'**
  String get settingsAiApiKeyInvalid;

  /// No description provided for @settingsAiApiKeyUnreadable.
  ///
  /// In en, this message translates to:
  /// **'Your saved key could not be read. Enter it again.'**
  String get settingsAiApiKeyUnreadable;

  /// No description provided for @settingsAiApiKeyStorageError.
  ///
  /// In en, this message translates to:
  /// **'The key could not be saved. Try again.'**
  String get settingsAiApiKeyStorageError;

  /// No description provided for @settingsAiDisclosureTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn on AI suggestions?'**
  String get settingsAiDisclosureTitle;

  /// No description provided for @settingsAiDisclosure.
  ///
  /// In en, this message translates to:
  /// **'When this is on and you ask OpenRouter for a suggestion, the app sends openrouter.ai and the model provider, with your own API key: the brand, palette mode and scene, the base marker\'s code and name and whether it is locked, the palette size, the codes and hex colours of the candidate markers, the model settings and the app\'s fixed instructions. Photos are never sent: this feature has no image upload. On Android, the app may also ask Google\'s ML Kit whether Gemini Nano is available; ML Kit sends Google usage diagnostics. Nothing at all is sent while this switch is off.'**
  String get settingsAiDisclosure;

  /// No description provided for @settingsAiDisclosureColourTheory.
  ///
  /// In en, this message translates to:
  /// **'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. On Android, the app may ask Google\'s ML Kit whether Gemini Nano is available; ML Kit sends Google usage diagnostics, never your colours or photos. Choose On-device or OpenRouter to use an AI.'**
  String get settingsAiDisclosureColourTheory;

  /// No description provided for @settingsAiDisclosureColourTheoryNoOnDevice.
  ///
  /// In en, this message translates to:
  /// **'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. On Android, the app may ask Google\'s ML Kit whether Gemini Nano is available; ML Kit sends Google usage diagnostics, never your colours or photos. Choose OpenRouter to use an AI.'**
  String get settingsAiDisclosureColourTheoryNoOnDevice;

  /// No description provided for @settingsAiDisclosureConfirm.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get settingsAiDisclosureConfirm;

  /// No description provided for @settingsAiDisclosureCancel.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get settingsAiDisclosureCancel;

  /// No description provided for @settingsAiDisclosureOnDevice.
  ///
  /// In en, this message translates to:
  /// **'On-device (Gemini Nano) requests are answered by the model on this phone: your scenario and colour codes never leave it, and no key is needed. To check, download and run the model, the app uses Google\'s ML Kit, which sends Google usage diagnostics (phone model, app version, per-install identifiers, errors and sizes), never your prompts, colours or photos. Nothing is sent while this switch is off.'**
  String get settingsAiDisclosureOnDevice;

  /// No description provided for @settingsAiOnDeviceName.
  ///
  /// In en, this message translates to:
  /// **'On-device (Gemini Nano)'**
  String get settingsAiOnDeviceName;

  /// No description provided for @settingsAiOnDevicePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Your requests stay on this phone. ML Kit sends Google usage diagnostics, never your prompts, colours or photos.'**
  String get settingsAiOnDevicePrivacy;

  /// No description provided for @settingsAiOnDeviceDownloadable.
  ///
  /// In en, this message translates to:
  /// **'The model is not on this phone yet. Android downloads it once and keeps it for every app.'**
  String get settingsAiOnDeviceDownloadable;

  /// No description provided for @settingsAiOnDeviceDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading the model...'**
  String get settingsAiOnDeviceDownloading;

  /// No description provided for @settingsAiOnDevicePreparing.
  ///
  /// In en, this message translates to:
  /// **'Android is preparing the model. This can take a while and may wait for Wi‑Fi and charging. You can leave this screen; the download continues in the background.'**
  String get settingsAiOnDevicePreparing;

  /// No description provided for @settingsAiEnabledSubtitleOnDeviceIos.
  ///
  /// In en, this message translates to:
  /// **'Apple Intelligence on this phone'**
  String get settingsAiEnabledSubtitleOnDeviceIos;

  /// No description provided for @settingsAiExplainOnDeviceIos.
  ///
  /// In en, this message translates to:
  /// **'Apple\'s model runs on this phone and your requests stay on it.'**
  String get settingsAiExplainOnDeviceIos;

  /// No description provided for @settingsAiDisclosureOnDeviceIos.
  ///
  /// In en, this message translates to:
  /// **'On-device (Apple Intelligence) requests are answered by Apple\'s model on this phone: your scenario and colour codes never leave it, and no key is needed. iOS installs and manages the model with Apple Intelligence; the app downloads nothing and uses no other service for it, so nothing is sent.'**
  String get settingsAiDisclosureOnDeviceIos;

  /// No description provided for @settingsAiOnDeviceNameIos.
  ///
  /// In en, this message translates to:
  /// **'On-device (Apple Intelligence)'**
  String get settingsAiOnDeviceNameIos;

  /// No description provided for @settingsAiOnDevicePrivacyIos.
  ///
  /// In en, this message translates to:
  /// **'Your requests stay on this phone. Nothing is sent, not your prompts, colours or photos.'**
  String get settingsAiOnDevicePrivacyIos;

  /// No description provided for @settingsAiOnDevicePreparingIos.
  ///
  /// In en, this message translates to:
  /// **'iOS is preparing the Apple Intelligence model. This can take a while. You can leave this screen; it continues in the background.'**
  String get settingsAiOnDevicePreparingIos;

  /// No description provided for @settingsAiDisclosureIos.
  ///
  /// In en, this message translates to:
  /// **'When this is on and you ask OpenRouter for a suggestion, the app sends openrouter.ai and the model provider, with your own API key: the brand, palette mode and scene, the base marker\'s code and name and whether it is locked, the palette size, the codes and hex colours of the candidate markers, the model settings and the app\'s fixed instructions. Photos are never sent: this feature has no image upload. Nothing at all is sent while this switch is off.'**
  String get settingsAiDisclosureIos;

  /// No description provided for @settingsAiDisclosureColourTheoryIos.
  ///
  /// In en, this message translates to:
  /// **'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. Choose On-device or OpenRouter to use an AI.'**
  String get settingsAiDisclosureColourTheoryIos;

  /// No description provided for @settingsAiDisclosureColourTheoryNoOnDeviceIos.
  ///
  /// In en, this message translates to:
  /// **'With Colour theory selected, palettes come from the built-in engine: no AI is used and they stay on your phone. Choose OpenRouter to use an AI.'**
  String get settingsAiDisclosureColourTheoryNoOnDeviceIos;

  /// No description provided for @settingsAiOnDeviceCheckAgain.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get settingsAiOnDeviceCheckAgain;

  /// No description provided for @settingsAiOnDeviceReady.
  ///
  /// In en, this message translates to:
  /// **'The model is ready on this phone.'**
  String get settingsAiOnDeviceReady;

  /// No description provided for @settingsAiOnDeviceDownload.
  ///
  /// In en, this message translates to:
  /// **'Download model'**
  String get settingsAiOnDeviceDownload;

  /// No description provided for @settingsAiOnDeviceFailed.
  ///
  /// In en, this message translates to:
  /// **'The download did not finish. Check the connection and try again.'**
  String get settingsAiOnDeviceFailed;

  /// No description provided for @settingsAiTestConnection.
  ///
  /// In en, this message translates to:
  /// **'Test connection'**
  String get settingsAiTestConnection;

  /// No description provided for @settingsAiTestingConnection.
  ///
  /// In en, this message translates to:
  /// **'Testing...'**
  String get settingsAiTestingConnection;

  /// No description provided for @settingsAiModelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get settingsAiModelsTitle;

  /// No description provided for @settingsAiModelsFilterFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get settingsAiModelsFilterFree;

  /// No description provided for @settingsAiModelsFilterPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get settingsAiModelsFilterPaid;

  /// No description provided for @settingsAiModelsFilterBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get settingsAiModelsFilterBoth;

  /// No description provided for @settingsAiModelsLoad.
  ///
  /// In en, this message translates to:
  /// **'Load models'**
  String get settingsAiModelsLoad;

  /// No description provided for @settingsAiModelsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No models matched this filter.'**
  String get settingsAiModelsEmpty;

  /// No description provided for @settingsAiModelsNeedsKey.
  ///
  /// In en, this message translates to:
  /// **'Save a key to load the models from OpenRouter.'**
  String get settingsAiModelsNeedsKey;

  /// No description provided for @settingsAiPrimaryModel.
  ///
  /// In en, this message translates to:
  /// **'Text model'**
  String get settingsAiPrimaryModel;

  /// No description provided for @settingsAiModelNone.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settingsAiModelNone;

  /// No description provided for @settingsAiModelsPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Load the models, then pick them from the list.'**
  String get settingsAiModelsPickerHint;

  /// No description provided for @settingsAiModelSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search models'**
  String get settingsAiModelSearchHint;

  /// No description provided for @settingsAiModelFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get settingsAiModelFree;

  /// No description provided for @settingsAiModelPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get settingsAiModelPaid;

  /// No description provided for @settingsAiModelsDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get settingsAiModelsDone;

  /// No description provided for @settingsAiModelsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Load the models first, or type a model id above.'**
  String get settingsAiModelsNotLoaded;

  /// No description provided for @settingsAiRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get settingsAiRecommended;

  /// No description provided for @settingsAiFreeModelsNote.
  ///
  /// In en, this message translates to:
  /// **'Free models may be slow or unreliable. The recommended models are inexpensive and answer more consistently.'**
  String get settingsAiFreeModelsNote;

  /// No description provided for @settingsAiAllModels.
  ///
  /// In en, this message translates to:
  /// **'All models'**
  String get settingsAiAllModels;

  /// No description provided for @settingsAiRecommendedDefault.
  ///
  /// In en, this message translates to:
  /// **'Recommended default'**
  String get settingsAiRecommendedDefault;

  /// No description provided for @settingsAiFallbacksTitle.
  ///
  /// In en, this message translates to:
  /// **'Fallbacks'**
  String get settingsAiFallbacksTitle;

  /// No description provided for @settingsAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutTitle;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsSourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get settingsSourceCode;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsCopyRepository.
  ///
  /// In en, this message translates to:
  /// **'Copy the link'**
  String get settingsCopyRepository;

  /// No description provided for @settingsRepositoryCopied.
  ///
  /// In en, this message translates to:
  /// **'The link was copied'**
  String get settingsRepositoryCopied;

  /// No description provided for @settingsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Ink Lab is an independent community project: it is not affiliated with, endorsed by or sponsored by any of the marker brands it lists. It uses their marker codes, names and colour values only as factual reference data.'**
  String get settingsDisclaimer;

  /// No description provided for @paletteTitle.
  ///
  /// In en, this message translates to:
  /// **'Palette'**
  String get paletteTitle;

  /// No description provided for @paletteBaseCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Base marker code'**
  String get paletteBaseCodeLabel;

  /// Hint of the empty base marker field: two real codes of the user's markers in the current brand.
  ///
  /// In en, this message translates to:
  /// **'{first} or {second}'**
  String paletteBaseCodeHint(String first, String second);

  /// Hint of the empty base marker field when only one code is known.
  ///
  /// In en, this message translates to:
  /// **'{code}'**
  String paletteBaseCodeHintOne(String code);

  /// No description provided for @paletteScenarioToggle.
  ///
  /// In en, this message translates to:
  /// **'Scenes'**
  String get paletteScenarioToggle;

  /// No description provided for @paletteTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Palette type'**
  String get paletteTypeTitle;

  /// No description provided for @paletteTypeSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the palette type'**
  String get paletteTypeSheetTitle;

  /// No description provided for @paletteTypeTheoryGroup.
  ///
  /// In en, this message translates to:
  /// **'Colour theory'**
  String get paletteTypeTheoryGroup;

  /// No description provided for @paletteTypeScenesGroup.
  ///
  /// In en, this message translates to:
  /// **'Scenes'**
  String get paletteTypeScenesGroup;

  /// No description provided for @paletteTypeScenesHint.
  ///
  /// In en, this message translates to:
  /// **'Ready-made recipes by subject'**
  String get paletteTypeScenesHint;

  /// No description provided for @paletteTypeDescRecommended.
  ///
  /// In en, this message translates to:
  /// **'Balanced picks for your base'**
  String get paletteTypeDescRecommended;

  /// No description provided for @paletteTypeDescComplementary.
  ///
  /// In en, this message translates to:
  /// **'Opposite hue, strong contrast'**
  String get paletteTypeDescComplementary;

  /// No description provided for @paletteTypeDescAnalogous.
  ///
  /// In en, this message translates to:
  /// **'Neighbouring hues, calm'**
  String get paletteTypeDescAnalogous;

  /// No description provided for @paletteTypeDescSplitComplementary.
  ///
  /// In en, this message translates to:
  /// **'Two hues beside the opposite'**
  String get paletteTypeDescSplitComplementary;

  /// No description provided for @paletteTypeDescTriad.
  ///
  /// In en, this message translates to:
  /// **'Three evenly spaced hues'**
  String get paletteTypeDescTriad;

  /// No description provided for @paletteTypeDescSquare.
  ///
  /// In en, this message translates to:
  /// **'Four evenly spaced hues'**
  String get paletteTypeDescSquare;

  /// No description provided for @paletteTypeDescRectangle.
  ///
  /// In en, this message translates to:
  /// **'Two complementary pairs'**
  String get paletteTypeDescRectangle;

  /// No description provided for @paletteTypeDescMonochrome.
  ///
  /// In en, this message translates to:
  /// **'One hue, light to dark'**
  String get paletteTypeDescMonochrome;

  /// No description provided for @paletteTypeDescShadow.
  ///
  /// In en, this message translates to:
  /// **'Deeper tones for shading'**
  String get paletteTypeDescShadow;

  /// No description provided for @paletteTypeDescCustomPalette.
  ///
  /// In en, this message translates to:
  /// **'Build it by hand'**
  String get paletteTypeDescCustomPalette;

  /// No description provided for @modeBlendingChain.
  ///
  /// In en, this message translates to:
  /// **'Blending Chain'**
  String get modeBlendingChain;

  /// No description provided for @paletteTypeDescBlendingChain.
  ///
  /// In en, this message translates to:
  /// **'Light to dark, ready to blend'**
  String get paletteTypeDescBlendingChain;

  /// No description provided for @paletteChainResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Blending chain ({count})'**
  String paletteChainResultTitle(int count);

  /// No description provided for @paletteChainStep.
  ///
  /// In en, this message translates to:
  /// **'Step {step} · {role}'**
  String paletteChainStep(int step, String role);

  /// No description provided for @roleLightest.
  ///
  /// In en, this message translates to:
  /// **'Lightest'**
  String get roleLightest;

  /// No description provided for @roleLighter.
  ///
  /// In en, this message translates to:
  /// **'Lighter'**
  String get roleLighter;

  /// No description provided for @roleDarker.
  ///
  /// In en, this message translates to:
  /// **'Darker'**
  String get roleDarker;

  /// No description provided for @roleDarkest.
  ///
  /// In en, this message translates to:
  /// **'Darkest'**
  String get roleDarkest;

  /// No description provided for @paletteChainHint.
  ///
  /// In en, this message translates to:
  /// **'Work light to dark and overlap each step while the ink is still wet. Soften the joins with the colourless blender if you have one.'**
  String get paletteChainHint;

  /// No description provided for @paletteChainShort.
  ///
  /// In en, this message translates to:
  /// **'Only {count} of your markers blend well with this base, fewer than the {wanted} you asked for.'**
  String paletteChainShort(int count, int wanted);

  /// No description provided for @paletteChainNeedLighter.
  ///
  /// In en, this message translates to:
  /// **'No chain yet: you need a lighter marker in this family.'**
  String get paletteChainNeedLighter;

  /// No description provided for @paletteChainNeedDarker.
  ///
  /// In en, this message translates to:
  /// **'No chain yet: you need a darker marker in this family.'**
  String get paletteChainNeedDarker;

  /// No description provided for @paletteChainNeedBoth.
  ///
  /// In en, this message translates to:
  /// **'No chain yet: you need a lighter and a darker marker in this family.'**
  String get paletteChainNeedBoth;

  /// No description provided for @paletteChainBaseLightest.
  ///
  /// In en, this message translates to:
  /// **'You have nothing lighter in this family, so the chain starts at your base.'**
  String get paletteChainBaseLightest;

  /// No description provided for @paletteChainBaseDarkest.
  ///
  /// In en, this message translates to:
  /// **'You have nothing darker in this family, so the chain ends at your base.'**
  String get paletteChainBaseDarkest;

  /// No description provided for @paletteChainOptionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Other chains'**
  String get paletteChainOptionsLabel;

  /// No description provided for @paletteChainOption.
  ///
  /// In en, this message translates to:
  /// **'Option {number}'**
  String paletteChainOption(int number);

  /// No description provided for @paletteChainWholeRange.
  ///
  /// In en, this message translates to:
  /// **'Search the whole range'**
  String get paletteChainWholeRange;

  /// No description provided for @paletteChainWholeRangeNote.
  ///
  /// In en, this message translates to:
  /// **'Showing the whole {brand} range, markers you don\'t own included.'**
  String paletteChainWholeRangeNote(String brand);

  /// No description provided for @paletteChainMyMarkers.
  ///
  /// In en, this message translates to:
  /// **'Back to my markers'**
  String get paletteChainMyMarkers;

  /// No description provided for @palettePaintTipChainFirst.
  ///
  /// In en, this message translates to:
  /// **'Lay the lightest colour over the whole area first.'**
  String get palettePaintTipChainFirst;

  /// No description provided for @palettePaintTipChainMiddle.
  ///
  /// In en, this message translates to:
  /// **'Overlap the previous step while it is still wet.'**
  String get palettePaintTipChainMiddle;

  /// No description provided for @palettePaintTipChainLast.
  ///
  /// In en, this message translates to:
  /// **'Finish with the darkest only where the shadow falls.'**
  String get palettePaintTipChainLast;

  /// No description provided for @swatchesBlendingChain.
  ///
  /// In en, this message translates to:
  /// **'Blending chain'**
  String get swatchesBlendingChain;

  /// No description provided for @paletteTypeSemantic.
  ///
  /// In en, this message translates to:
  /// **'Palette type, {value}'**
  String paletteTypeSemantic(String value);

  /// No description provided for @paletteSceneTitle.
  ///
  /// In en, this message translates to:
  /// **'Scene'**
  String get paletteSceneTitle;

  /// No description provided for @paletteSceneSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a scene'**
  String get paletteSceneSheetTitle;

  /// No description provided for @paletteSceneSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search scene or category'**
  String get paletteSceneSearchHint;

  /// No description provided for @paletteSceneEmpty.
  ///
  /// In en, this message translates to:
  /// **'No scene matches your search.'**
  String get paletteSceneEmpty;

  /// No description provided for @paletteSceneSemantic.
  ///
  /// In en, this message translates to:
  /// **'Scene, {value}'**
  String paletteSceneSemantic(String value);

  /// Scene sheet entry and source sheet title: build a palette from the colours of a photo.
  ///
  /// In en, this message translates to:
  /// **'From a photo'**
  String get paletteFromPhotoTitle;

  /// One-line explanation under the From a photo entry.
  ///
  /// In en, this message translates to:
  /// **'Your photo, with your markers'**
  String get paletteFromPhotoHint;

  /// Value of the scene field while a photo palette is shown.
  ///
  /// In en, this message translates to:
  /// **'Your photo'**
  String get paletteFromPhotoValue;

  /// Role line of a colour taken from the photo, with the share of the photo it covers.
  ///
  /// In en, this message translates to:
  /// **'Photo colour · {percent} %'**
  String paletteFromPhotoRole(int percent);

  /// Error when no colours (or no owned markers) came out of the photo.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t get colours from this photo'**
  String get paletteFromPhotoEmpty;

  /// Note shown when a photo colour has no usable owned marker close to it.
  ///
  /// In en, this message translates to:
  /// **'Some photo colours have no close marker in your collection'**
  String get paletteFromPhotoFarNote;

  /// No description provided for @sceneCategoryCharacters.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get sceneCategoryCharacters;

  /// No description provided for @sceneCategorySkin.
  ///
  /// In en, this message translates to:
  /// **'Skin and portraits'**
  String get sceneCategorySkin;

  /// No description provided for @sceneCategorySkyWater.
  ///
  /// In en, this message translates to:
  /// **'Sky and water'**
  String get sceneCategorySkyWater;

  /// No description provided for @sceneCategoryNature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get sceneCategoryNature;

  /// No description provided for @sceneCategoryMaterials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get sceneCategoryMaterials;

  /// No description provided for @sceneCategoryAnimals.
  ///
  /// In en, this message translates to:
  /// **'Animals and fur'**
  String get sceneCategoryAnimals;

  /// No description provided for @sceneCategoryFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get sceneCategoryFood;

  /// No description provided for @sceneCategoryHolidays.
  ///
  /// In en, this message translates to:
  /// **'Holidays and moods'**
  String get sceneCategoryHolidays;

  /// No description provided for @sceneCategoryInteriors.
  ///
  /// In en, this message translates to:
  /// **'Interiors'**
  String get sceneCategoryInteriors;

  /// No description provided for @sceneCategoryPatterns.
  ///
  /// In en, this message translates to:
  /// **'Patterns'**
  String get sceneCategoryPatterns;

  /// No description provided for @sceneCategoryFantasy.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get sceneCategoryFantasy;

  /// No description provided for @paletteSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get paletteSizeTitle;

  /// No description provided for @paletteSizeSemantic.
  ///
  /// In en, this message translates to:
  /// **'Palette size'**
  String get paletteSizeSemantic;

  /// No description provided for @paletteGenerateButton.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get paletteGenerateButton;

  /// No description provided for @paletteRegenerateButton.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get paletteRegenerateButton;

  /// No description provided for @paletteClearButton.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get paletteClearButton;

  /// No description provided for @paletteSuggestAiButton.
  ///
  /// In en, this message translates to:
  /// **'Suggest with AI'**
  String get paletteSuggestAiButton;

  /// No description provided for @paletteSuggestAiLoading.
  ///
  /// In en, this message translates to:
  /// **'Suggesting…'**
  String get paletteSuggestAiLoading;

  /// No description provided for @paletteAiBadge.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get paletteAiBadge;

  /// No description provided for @paletteSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save palette'**
  String get paletteSaveButton;

  /// No description provided for @paletteSavedButton.
  ///
  /// In en, this message translates to:
  /// **'Palette saved'**
  String get paletteSavedButton;

  /// Button that renders the palette on screen as an image and opens the system share sheet.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get paletteShareButton;

  /// Notice when rendering or sharing an image (palette or swatch chart) fails.
  ///
  /// In en, this message translates to:
  /// **'Could not share the image.'**
  String get shareFailed;

  /// No description provided for @paletteOkButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get paletteOkButton;

  /// No description provided for @paletteBaseMarkerTitle.
  ///
  /// In en, this message translates to:
  /// **'Base marker'**
  String get paletteBaseMarkerTitle;

  /// No description provided for @paletteVariationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Variations'**
  String get paletteVariationsLabel;

  /// No description provided for @palettePaintPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Paint order'**
  String get palettePaintPlanTitle;

  /// No description provided for @palettePaintTipBase.
  ///
  /// In en, this message translates to:
  /// **'Block the overall shape with the base colour first.'**
  String get palettePaintTipBase;

  /// No description provided for @palettePaintTipShadow.
  ///
  /// In en, this message translates to:
  /// **'Lay this shadow where light does not reach.'**
  String get palettePaintTipShadow;

  /// No description provided for @palettePaintTipHighlight.
  ///
  /// In en, this message translates to:
  /// **'Place the highlight where light hits directly.'**
  String get palettePaintTipHighlight;

  /// No description provided for @palettePaintTipAccent.
  ///
  /// In en, this message translates to:
  /// **'Reserve the accent for focal areas only.'**
  String get palettePaintTipAccent;

  /// No description provided for @palettePaintTipSupport.
  ///
  /// In en, this message translates to:
  /// **'Use this support tone to blend transitions.'**
  String get palettePaintTipSupport;

  /// No description provided for @paletteSubtitleIdle.
  ///
  /// In en, this message translates to:
  /// **'Build a palette from a base marker you own'**
  String get paletteSubtitleIdle;

  /// No description provided for @paletteLockButton.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get paletteLockButton;

  /// No description provided for @paletteUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get paletteUnlockButton;

  /// No description provided for @paletteSaveDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Save palette'**
  String get paletteSaveDialogTitle;

  /// No description provided for @paletteSaveDialogHint.
  ///
  /// In en, this message translates to:
  /// **'Palette name'**
  String get paletteSaveDialogHint;

  /// No description provided for @paletteSaveDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get paletteSaveDialogCancel;

  /// No description provided for @paletteSaveDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get paletteSaveDialogConfirm;

  /// No description provided for @paletteSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved palettes'**
  String get paletteSavedTitle;

  /// No description provided for @paletteSavedEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved palettes for this brand yet.'**
  String get paletteSavedEmpty;

  /// Summary of the paint order disclosure: how many steps the palette is painted in.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 step} other{{count} steps}}'**
  String palettePaintPlanSummary(int count);

  /// No description provided for @paletteLoadButton.
  ///
  /// In en, this message translates to:
  /// **'Load'**
  String get paletteLoadButton;

  /// No description provided for @paletteDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get paletteDeleteButton;

  /// No description provided for @paletteDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete palette?'**
  String get paletteDeleteDialogTitle;

  /// No description provided for @paletteDeleteDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get paletteDeleteDialogBody;

  /// Quiet button under an AI palette suggestion that lets the user report it to the developer.
  ///
  /// In en, this message translates to:
  /// **'Report this suggestion'**
  String get paletteAiReportButton;

  /// Title of the dialog to report an AI palette suggestion.
  ///
  /// In en, this message translates to:
  /// **'Report this suggestion'**
  String get paletteAiReportTitle;

  /// Explanation in the report dialog: what is sent and that the user decides.
  ///
  /// In en, this message translates to:
  /// **'Tell us if the AI wrote something offensive, inappropriate or wrong. Your email app will open with the suggestion\'s text; you decide whether to send it. Your API key is never included.'**
  String get paletteAiReportBody;

  /// Reason option in the AI report dialog.
  ///
  /// In en, this message translates to:
  /// **'Offensive or inappropriate'**
  String get paletteAiReportOffensive;

  /// Reason option in the AI report dialog.
  ///
  /// In en, this message translates to:
  /// **'Wrong or makes no sense'**
  String get paletteAiReportWrong;

  /// Reason option in the AI report dialog.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get paletteAiReportOther;

  /// Confirm button of the AI report dialog; opens the email app.
  ///
  /// In en, this message translates to:
  /// **'Send by email'**
  String get paletteAiReportSend;

  /// Snack bar after the email app was opened for an AI report.
  ///
  /// In en, this message translates to:
  /// **'Thanks, this helps us improve the suggestions'**
  String get paletteAiReportThanks;

  /// Snack bar when no email app opens; the report was copied to the clipboard.
  ///
  /// In en, this message translates to:
  /// **'No email app found. The report was copied: paste it in an email to inklab@mainshai.com'**
  String get paletteAiReportCopied;

  /// No description provided for @paletteAiFellBack.
  ///
  /// In en, this message translates to:
  /// **'AI unavailable. Showing local suggestions.'**
  String get paletteAiFellBack;

  /// No description provided for @paletteEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a base marker to build a palette, or choose Scenes as the palette type.'**
  String get paletteEmptyHint;

  /// Title of the empty state of a collection that owns no marker of the brand yet.
  ///
  /// In en, this message translates to:
  /// **'You don\'t own {brand} markers yet'**
  String missingMarkersTitle(String brand);

  /// Button that opens the collection, where the user ticks the markers they own.
  ///
  /// In en, this message translates to:
  /// **'Go to My collection'**
  String get missingMarkersAction;

  /// No description provided for @paletteCustomModeHint.
  ///
  /// In en, this message translates to:
  /// **'Custom palette mode is manual: load a saved palette or apply one from Ideas.'**
  String get paletteCustomModeHint;

  /// No description provided for @paletteNoSuggestions.
  ///
  /// In en, this message translates to:
  /// **'No palette could be built from your collection. Try another mode or add more markers.'**
  String get paletteNoSuggestions;

  /// No description provided for @paletteScenarioTitle.
  ///
  /// In en, this message translates to:
  /// **'Scenes'**
  String get paletteScenarioTitle;

  /// No description provided for @palettePickBaseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Choose from your markers'**
  String get palettePickBaseTooltip;

  /// No description provided for @palettePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a base marker'**
  String get palettePickerTitle;

  /// No description provided for @palettePickerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Code or name'**
  String get palettePickerSearchHint;

  /// No description provided for @palettePickerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No marker matches your search.'**
  String get palettePickerEmpty;

  /// No description provided for @paletteUndoButton.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get paletteUndoButton;

  /// No description provided for @paletteBaseReplaced.
  ///
  /// In en, this message translates to:
  /// **'{code} is now the base. Your previous palette was replaced.'**
  String paletteBaseReplaced(String code);

  /// No description provided for @paletteIdeaApplied.
  ///
  /// In en, this message translates to:
  /// **'“{title}” palette applied ({count} markers).'**
  String paletteIdeaApplied(String title, int count);

  /// No description provided for @swatchesTitle.
  ///
  /// In en, this message translates to:
  /// **'Swatches'**
  String get swatchesTitle;

  /// No description provided for @swatchesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Code, name or hex'**
  String get swatchesSearchHint;

  /// No description provided for @swatchesClosestTo.
  ///
  /// In en, this message translates to:
  /// **'Closest to {hex}'**
  String swatchesClosestTo(String hex);

  /// No description provided for @swatchesClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get swatchesClearSearch;

  /// No description provided for @swatchesAllFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get swatchesAllFilter;

  /// No description provided for @swatchesFavoritesOnly.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get swatchesFavoritesOnly;

  /// No description provided for @swatchesOwnedOnly.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get swatchesOwnedOnly;

  /// No description provided for @swatchesFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get swatchesFilters;

  /// No description provided for @swatchesFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get swatchesFiltersTitle;

  /// No description provided for @swatchesLabelPack.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get swatchesLabelPack;

  /// No description provided for @swatchesLabelLayout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get swatchesLabelLayout;

  /// No description provided for @swatchesAllPacks.
  ///
  /// In en, this message translates to:
  /// **'All sets'**
  String get swatchesAllPacks;

  /// No description provided for @swatchesClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get swatchesClearFilters;

  /// No description provided for @swatchesClearSearchAndFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear search and filters'**
  String get swatchesClearSearchAndFilters;

  /// No description provided for @swatchesLoadingSemantics.
  ///
  /// In en, this message translates to:
  /// **'Loading colours'**
  String get swatchesLoadingSemantics;

  /// No description provided for @swatchesClosestAlternatives.
  ///
  /// In en, this message translates to:
  /// **'Closest alternatives'**
  String get swatchesClosestAlternatives;

  /// No description provided for @swatchesNoCloseAlternatives.
  ///
  /// In en, this message translates to:
  /// **'No close alternatives'**
  String get swatchesNoCloseAlternatives;

  /// No description provided for @swatchesInPacks.
  ///
  /// In en, this message translates to:
  /// **'In sets'**
  String get swatchesInPacks;

  /// No description provided for @swatchesLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get swatchesLocation;

  /// No description provided for @swatchesAddToPalette.
  ///
  /// In en, this message translates to:
  /// **'Add to palette'**
  String get swatchesAddToPalette;

  /// No description provided for @swatchesLayoutGrid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get swatchesLayoutGrid;

  /// No description provided for @swatchesLayoutList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get swatchesLayoutList;

  /// No description provided for @swatchesOwned.
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get swatchesOwned;

  /// No description provided for @swatchesNewLabels.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get swatchesNewLabels;

  /// No description provided for @swatchesOldLabels.
  ///
  /// In en, this message translates to:
  /// **'Old'**
  String get swatchesOldLabels;

  /// No description provided for @swatchesBothLabels.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get swatchesBothLabels;

  /// No description provided for @swatchesLabelMode.
  ///
  /// In en, this message translates to:
  /// **'Labels'**
  String get swatchesLabelMode;

  /// No description provided for @swatchesToggleLayout.
  ///
  /// In en, this message translates to:
  /// **'Switch between the grid and the list'**
  String get swatchesToggleLayout;

  /// No description provided for @swatchesGridLayout.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get swatchesGridLayout;

  /// No description provided for @swatchesListLayout.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get swatchesListLayout;

  /// No description provided for @swatchesNewCode.
  ///
  /// In en, this message translates to:
  /// **'New code'**
  String get swatchesNewCode;

  /// No description provided for @swatchesOldCode.
  ///
  /// In en, this message translates to:
  /// **'Old code'**
  String get swatchesOldCode;

  /// No description provided for @swatchesNewName.
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get swatchesNewName;

  /// No description provided for @swatchesOldName.
  ///
  /// In en, this message translates to:
  /// **'Old name'**
  String get swatchesOldName;

  /// No description provided for @swatchesHex.
  ///
  /// In en, this message translates to:
  /// **'Hex'**
  String get swatchesHex;

  /// No description provided for @swatchesCopyHex.
  ///
  /// In en, this message translates to:
  /// **'Copy hex'**
  String get swatchesCopyHex;

  /// No description provided for @swatchesHexCopied.
  ///
  /// In en, this message translates to:
  /// **'Hex copied to the clipboard'**
  String get swatchesHexCopied;

  /// No description provided for @swatchesAddFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add to favourites'**
  String get swatchesAddFavorite;

  /// No description provided for @swatchesRemoveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favourites'**
  String get swatchesRemoveFavorite;

  /// No description provided for @swatchesEmptyNoOwnedTitle.
  ///
  /// In en, this message translates to:
  /// **'No markers yet'**
  String get swatchesEmptyNoOwnedTitle;

  /// No description provided for @swatchesEmptyNoOwnedBody.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any markers yet. Tell the app which sets and markers you have.'**
  String get swatchesEmptyNoOwnedBody;

  /// No description provided for @swatchesEmptyNoOwnedAction.
  ///
  /// In en, this message translates to:
  /// **'Set up my collection'**
  String get swatchesEmptyNoOwnedAction;

  /// No description provided for @swatchesEmptyNoOwnedHint.
  ///
  /// In en, this message translates to:
  /// **'Open Settings, then My collection.'**
  String get swatchesEmptyNoOwnedHint;

  /// No description provided for @swatchesEmptySearchTitle.
  ///
  /// In en, this message translates to:
  /// **'No colours found'**
  String get swatchesEmptySearchTitle;

  /// No description provided for @swatchesEmptySearchBody.
  ///
  /// In en, this message translates to:
  /// **'No colour of this collection matches your search.'**
  String get swatchesEmptySearchBody;

  /// No description provided for @swatchesEmptyFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show'**
  String get swatchesEmptyFiltersTitle;

  /// No description provided for @swatchesEmptyFiltersBody.
  ///
  /// In en, this message translates to:
  /// **'This brand has no colours for the selected sets and filters.'**
  String get swatchesEmptyFiltersBody;

  /// No description provided for @swatchesEmptyNoFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'No favourites yet'**
  String get swatchesEmptyNoFavoritesTitle;

  /// No description provided for @swatchesEmptyNoFavoritesBody.
  ///
  /// In en, this message translates to:
  /// **'Tap the star in a colour\'s details to add one.'**
  String get swatchesEmptyNoFavoritesBody;

  /// No description provided for @swatchesEmptyNoFavoritesAction.
  ///
  /// In en, this message translates to:
  /// **'Show all colours'**
  String get swatchesEmptyNoFavoritesAction;

  /// No description provided for @swatchesEmptyFavoritesNotMineTitle.
  ///
  /// In en, this message translates to:
  /// **'No favourites in your collection'**
  String get swatchesEmptyFavoritesNotMineTitle;

  /// No description provided for @swatchesEmptyFavoritesNotMineBody.
  ///
  /// In en, this message translates to:
  /// **'None of your favourites is one of the markers you own.'**
  String get swatchesEmptyFavoritesNotMineBody;

  /// No description provided for @swatchesEmptyFavoritesNotMineAction.
  ///
  /// In en, this message translates to:
  /// **'Show all favourites'**
  String get swatchesEmptyFavoritesNotMineAction;

  /// No description provided for @swatchesLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading colours…'**
  String get swatchesLoading;

  /// No description provided for @swatchesLoadFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Colours unavailable'**
  String get swatchesLoadFailedTitle;

  /// No description provided for @swatchesLoadFailedBody.
  ///
  /// In en, this message translates to:
  /// **'The marker catalogue could not be read, so no colours can be shown.'**
  String get swatchesLoadFailedBody;

  /// No description provided for @swatchesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The app services are not available, so the swatches cannot be shown.'**
  String get swatchesUnavailable;

  /// No description provided for @swatchesVisibleCount.
  ///
  /// In en, this message translates to:
  /// **'Colours'**
  String get swatchesVisibleCount;

  /// No description provided for @swatchesScopeCollection.
  ///
  /// In en, this message translates to:
  /// **'Your collection'**
  String get swatchesScopeCollection;

  /// No description provided for @swatchesScopePack.
  ///
  /// In en, this message translates to:
  /// **'Pack'**
  String get swatchesScopePack;

  /// No description provided for @ideasTitle.
  ///
  /// In en, this message translates to:
  /// **'Ideas'**
  String get ideasTitle;

  /// No description provided for @ideasHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exercises for your markers'**
  String get ideasHeaderSubtitle;

  /// No description provided for @ideasSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search ideas'**
  String get ideasSearchHint;

  /// No description provided for @ideasCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get ideasCategoryAll;

  /// No description provided for @ideasApplyButton.
  ///
  /// In en, this message translates to:
  /// **'Use in Palette'**
  String get ideasApplyButton;

  /// No description provided for @ideasMoreDetails.
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get ideasMoreDetails;

  /// No description provided for @ideasGuideOnlyNote.
  ///
  /// In en, this message translates to:
  /// **'This exercise uses your whole collection, so it has no fixed palette.'**
  String get ideasGuideOnlyNote;

  /// No description provided for @ideasCategoriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get ideasCategoriesLabel;

  /// No description provided for @ideasEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No ideas found'**
  String get ideasEmptyTitle;

  /// No description provided for @ideasClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get ideasClearFilters;

  /// No description provided for @ideasEmptySearch.
  ///
  /// In en, this message translates to:
  /// **'No ideas match your search.'**
  String get ideasEmptySearch;

  /// No description provided for @ideasNoMarkers.
  ///
  /// In en, this message translates to:
  /// **'No markers currently available'**
  String get ideasNoMarkers;

  /// Line shown in an idea when the collection owns no marker of the brand yet.
  ///
  /// In en, this message translates to:
  /// **'Tick the markers you own in My collection to see which ones to use'**
  String get missingMarkersHint;

  /// Line shown when the collection owns markers but all of them are dried out.
  ///
  /// In en, this message translates to:
  /// **'All your markers are dried out. Mark them as usable again to use them.'**
  String get allMarkersDried;

  /// No description provided for @ideasTulipFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Tulip field'**
  String get ideasTulipFieldTitle;

  /// No description provided for @ideasTulipFieldSummary.
  ///
  /// In en, this message translates to:
  /// **'Rows of red and yellow tulips running to the horizon, spring green between them.'**
  String get ideasTulipFieldSummary;

  /// No description provided for @ideasTulipFieldPractice.
  ///
  /// In en, this message translates to:
  /// **'Flat bands that break into dots as they come closer.'**
  String get ideasTulipFieldPractice;

  /// No description provided for @ideasTulipFieldSubject.
  ///
  /// In en, this message translates to:
  /// **'Rows of tulips seen from low down, with a low horizon.'**
  String get ideasTulipFieldSubject;

  /// No description provided for @ideasTulipFieldTip.
  ///
  /// In en, this message translates to:
  /// **'The nearest row is dots, the furthest is a stripe: change the mark as the row goes back.'**
  String get ideasTulipFieldTip;

  /// No description provided for @ideasTulipFieldStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil rows that narrow towards a low horizon.'**
  String get ideasTulipFieldStep1;

  /// No description provided for @ideasTulipFieldStep2.
  ///
  /// In en, this message translates to:
  /// **'Red in the first rows: single blobs near, a solid stripe further back.'**
  String get ideasTulipFieldStep2;

  /// No description provided for @ideasTulipFieldStep3.
  ///
  /// In en, this message translates to:
  /// **'Yellow in the next rows, the same way.'**
  String get ideasTulipFieldStep3;

  /// No description provided for @ideasTulipFieldStep4.
  ///
  /// In en, this message translates to:
  /// **'Light green between the rows, and along the horizon.'**
  String get ideasTulipFieldStep4;

  /// No description provided for @ideasTulipFieldStep5.
  ///
  /// In en, this message translates to:
  /// **'Darker green in a thin line at the foot of each row.'**
  String get ideasTulipFieldStep5;

  /// No description provided for @ideasSummerBeachTitle.
  ///
  /// In en, this message translates to:
  /// **'At the beach'**
  String get ideasSummerBeachTitle;

  /// No description provided for @ideasSummerBeachSummary.
  ///
  /// In en, this message translates to:
  /// **'Sand, a strip of sea, a parasol: three flat bands and one bright accent.'**
  String get ideasSummerBeachSummary;

  /// No description provided for @ideasSummerBeachPractice.
  ///
  /// In en, this message translates to:
  /// **'Three flat bands and a single accent that carries the eye.'**
  String get ideasSummerBeachPractice;

  /// No description provided for @ideasSummerBeachSubject.
  ///
  /// In en, this message translates to:
  /// **'A beach seen from the sand, with a parasol.'**
  String get ideasSummerBeachSubject;

  /// No description provided for @ideasSummerBeachTip.
  ///
  /// In en, this message translates to:
  /// **'Leave the foam as paper: it is the brightest line in the sea.'**
  String get ideasSummerBeachTip;

  /// No description provided for @ideasSummerBeachStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three horizontal bands (sky, sea, sand) and a parasol in the sand.'**
  String get ideasSummerBeachStep1;

  /// No description provided for @ideasSummerBeachStep2.
  ///
  /// In en, this message translates to:
  /// **'Pale sand with a very light hand; leave the wet sand near the water lighter.'**
  String get ideasSummerBeachStep2;

  /// No description provided for @ideasSummerBeachStep3.
  ///
  /// In en, this message translates to:
  /// **'Light teal for the sea, with a line of paper for the foam.'**
  String get ideasSummerBeachStep3;

  /// No description provided for @ideasSummerBeachStep4.
  ///
  /// In en, this message translates to:
  /// **'Deeper teal at the horizon.'**
  String get ideasSummerBeachStep4;

  /// No description provided for @ideasSummerBeachStep5.
  ///
  /// In en, this message translates to:
  /// **'Red parasol and its small shadow on the sand, painted with a second layer of the sand colour.'**
  String get ideasSummerBeachStep5;

  /// No description provided for @ideasWatermelonSliceTitle.
  ///
  /// In en, this message translates to:
  /// **'Watermelon'**
  String get ideasWatermelonSliceTitle;

  /// No description provided for @ideasWatermelonSliceSummary.
  ///
  /// In en, this message translates to:
  /// **'A slice of watermelon: red flesh, white rind, green skin, black seeds.'**
  String get ideasWatermelonSliceSummary;

  /// No description provided for @ideasWatermelonSlicePractice.
  ///
  /// In en, this message translates to:
  /// **'A quick blend and a flat stripe, with the white rind left as paper.'**
  String get ideasWatermelonSlicePractice;

  /// No description provided for @ideasWatermelonSliceSubject.
  ///
  /// In en, this message translates to:
  /// **'A triangular slice of watermelon with a curved base.'**
  String get ideasWatermelonSliceSubject;

  /// No description provided for @ideasWatermelonSliceTip.
  ///
  /// In en, this message translates to:
  /// **'The white rind is paper: do not colour it at all.'**
  String get ideasWatermelonSliceTip;

  /// No description provided for @ideasWatermelonSliceStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a triangle with a curved base and a thin white band inside the green.'**
  String get ideasWatermelonSliceStep1;

  /// No description provided for @ideasWatermelonSliceStep2.
  ///
  /// In en, this message translates to:
  /// **'The light red over the flesh, paler near the rind.'**
  String get ideasWatermelonSliceStep2;

  /// No description provided for @ideasWatermelonSliceStep3.
  ///
  /// In en, this message translates to:
  /// **'Deeper red towards the point, blended while wet.'**
  String get ideasWatermelonSliceStep3;

  /// No description provided for @ideasWatermelonSliceStep4.
  ///
  /// In en, this message translates to:
  /// **'Green on the skin, with dark green stripes in a second layer.'**
  String get ideasWatermelonSliceStep4;

  /// No description provided for @ideasWatermelonSliceStep5.
  ///
  /// In en, this message translates to:
  /// **'Seeds with the liner, each a small teardrop.'**
  String get ideasWatermelonSliceStep5;

  /// No description provided for @ideasForestMushroomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Mushrooms on the forest floor'**
  String get ideasForestMushroomsTitle;

  /// No description provided for @ideasForestMushroomsSummary.
  ///
  /// In en, this message translates to:
  /// **'A cluster of mushrooms among brown leaves in autumn.'**
  String get ideasForestMushroomsSummary;

  /// No description provided for @ideasForestMushroomsPractice.
  ///
  /// In en, this message translates to:
  /// **'Round caps with small blends and a loose, dry ground.'**
  String get ideasForestMushroomsPractice;

  /// No description provided for @ideasForestMushroomsSubject.
  ///
  /// In en, this message translates to:
  /// **'Three mushrooms of different heights among fallen leaves.'**
  String get ideasForestMushroomsSubject;

  /// No description provided for @ideasForestMushroomsTip.
  ///
  /// In en, this message translates to:
  /// **'The forest floor wants loose, broken strokes of brown, not solid fills.'**
  String get ideasForestMushroomsTip;

  /// No description provided for @ideasForestMushroomsStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three mushrooms of different heights and a few leaves around them.'**
  String get ideasForestMushroomsStep1;

  /// No description provided for @ideasForestMushroomsStep2.
  ///
  /// In en, this message translates to:
  /// **'Pale beige on the stems and the underside of the caps.'**
  String get ideasForestMushroomsStep2;

  /// No description provided for @ideasForestMushroomsStep3.
  ///
  /// In en, this message translates to:
  /// **'The red-brown on the caps, darker at the edge.'**
  String get ideasForestMushroomsStep3;

  /// No description provided for @ideasForestMushroomsStep4.
  ///
  /// In en, this message translates to:
  /// **'Brown on the leaves and the ground.'**
  String get ideasForestMushroomsStep4;

  /// No description provided for @ideasForestMushroomsStep5.
  ///
  /// In en, this message translates to:
  /// **'Darkest under the caps and where the stems meet the ground; white gel spots on the caps if you like.'**
  String get ideasForestMushroomsStep5;

  /// No description provided for @ideasHarvestBasketTitle.
  ///
  /// In en, this message translates to:
  /// **'Harvest basket'**
  String get ideasHarvestBasketTitle;

  /// No description provided for @ideasHarvestBasketSummary.
  ///
  /// In en, this message translates to:
  /// **'Apples, a pear and a small squash in a basket, each a different colour, shaded with one grey.'**
  String get ideasHarvestBasketSummary;

  /// No description provided for @ideasHarvestBasketPractice.
  ///
  /// In en, this message translates to:
  /// **'One grey shading three strong colours so they belong together.'**
  String get ideasHarvestBasketPractice;

  /// No description provided for @ideasHarvestBasketSubject.
  ///
  /// In en, this message translates to:
  /// **'A basket full of fruit: apples, a pear and a squash.'**
  String get ideasHarvestBasketSubject;

  /// No description provided for @ideasHarvestBasketTip.
  ///
  /// In en, this message translates to:
  /// **'Shade every fruit with the same grey. It is what keeps a busy still life together.'**
  String get ideasHarvestBasketTip;

  /// No description provided for @ideasHarvestBasketStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the basket and the fruit overlapping.'**
  String get ideasHarvestBasketStep1;

  /// No description provided for @ideasHarvestBasketStep2.
  ///
  /// In en, this message translates to:
  /// **'Red for the apples, with the highlight left as paper.'**
  String get ideasHarvestBasketStep2;

  /// No description provided for @ideasHarvestBasketStep3.
  ///
  /// In en, this message translates to:
  /// **'Yellow-green for the pear.'**
  String get ideasHarvestBasketStep3;

  /// No description provided for @ideasHarvestBasketStep4.
  ///
  /// In en, this message translates to:
  /// **'Orange for the squash, with its ridges as darker lines of a second layer.'**
  String get ideasHarvestBasketStep4;

  /// No description provided for @ideasHarvestBasketStep5.
  ///
  /// In en, this message translates to:
  /// **'The same grey for every shadow and the inside of the basket.'**
  String get ideasHarvestBasketStep5;

  /// No description provided for @ideasHarvestBasketStep6.
  ///
  /// In en, this message translates to:
  /// **'The darkest marker for the weave lines of the basket.'**
  String get ideasHarvestBasketStep6;

  /// No description provided for @ideasHotChocolateTitle.
  ///
  /// In en, this message translates to:
  /// **'Hot chocolate'**
  String get ideasHotChocolateTitle;

  /// No description provided for @ideasHotChocolateSummary.
  ///
  /// In en, this message translates to:
  /// **'A mug of chocolate with steam, a marshmallow and a red mitten.'**
  String get ideasHotChocolateSummary;

  /// No description provided for @ideasHotChocolatePractice.
  ///
  /// In en, this message translates to:
  /// **'Warm browns, one red accent and steam lifted out of the background.'**
  String get ideasHotChocolatePractice;

  /// No description provided for @ideasHotChocolateSubject.
  ///
  /// In en, this message translates to:
  /// **'A mug of hot chocolate with a marshmallow and a mitten beside it.'**
  String get ideasHotChocolateSubject;

  /// No description provided for @ideasHotChocolateTip.
  ///
  /// In en, this message translates to:
  /// **'Steam is either paper or a shape lifted with the blender, never a drawn line.'**
  String get ideasHotChocolateTip;

  /// No description provided for @ideasHotChocolateStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the mug, the surface of the drink, a marshmallow and a mitten resting against it.'**
  String get ideasHotChocolateStep1;

  /// No description provided for @ideasHotChocolateStep2.
  ///
  /// In en, this message translates to:
  /// **'Pale brown on the lit side of the mug and on the shadow of the marshmallow.'**
  String get ideasHotChocolateStep2;

  /// No description provided for @ideasHotChocolateStep3.
  ///
  /// In en, this message translates to:
  /// **'Brown on the surface of the drink and the shadow side of the mug.'**
  String get ideasHotChocolateStep3;

  /// No description provided for @ideasHotChocolateStep4.
  ///
  /// In en, this message translates to:
  /// **'Red mitten, two layers.'**
  String get ideasHotChocolateStep4;

  /// No description provided for @ideasHotChocolateStep5.
  ///
  /// In en, this message translates to:
  /// **'Steam: lift wisps out of the background with the blender, or leave them as paper.'**
  String get ideasHotChocolateStep5;

  /// No description provided for @ideasLunarNewYearTitle.
  ///
  /// In en, this message translates to:
  /// **'Lunar New Year'**
  String get ideasLunarNewYearTitle;

  /// No description provided for @ideasLunarNewYearSummary.
  ///
  /// In en, this message translates to:
  /// **'Red lanterns with gold trim against a red wall.'**
  String get ideasLunarNewYearSummary;

  /// No description provided for @ideasLunarNewYearPractice.
  ///
  /// In en, this message translates to:
  /// **'One red family in three steps and a flat gold accent.'**
  String get ideasLunarNewYearPractice;

  /// No description provided for @ideasLunarNewYearSubject.
  ///
  /// In en, this message translates to:
  /// **'Three round lanterns hanging at different heights, with tassels.'**
  String get ideasLunarNewYearSubject;

  /// No description provided for @ideasLunarNewYearTip.
  ///
  /// In en, this message translates to:
  /// **'Lay the gold on top of the dry red, never the other way round.'**
  String get ideasLunarNewYearTip;

  /// No description provided for @ideasLunarNewYearStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three lanterns hanging at different heights, with tassels.'**
  String get ideasLunarNewYearStep1;

  /// No description provided for @ideasLunarNewYearStep2.
  ///
  /// In en, this message translates to:
  /// **'Light red over the lanterns, paler on the lit side.'**
  String get ideasLunarNewYearStep2;

  /// No description provided for @ideasLunarNewYearStep3.
  ///
  /// In en, this message translates to:
  /// **'The red on the shadow side and the ribs, blended while wet.'**
  String get ideasLunarNewYearStep3;

  /// No description provided for @ideasLunarNewYearStep4.
  ///
  /// In en, this message translates to:
  /// **'Dark red between the ribs and inside the rims.'**
  String get ideasLunarNewYearStep4;

  /// No description provided for @ideasLunarNewYearStep5.
  ///
  /// In en, this message translates to:
  /// **'Gold yellow on the rims, the caps and the tassels, left crisp.'**
  String get ideasLunarNewYearStep5;

  /// No description provided for @ideasDiwaliLampsTitle.
  ///
  /// In en, this message translates to:
  /// **'Diwali lamps'**
  String get ideasDiwaliLampsTitle;

  /// No description provided for @ideasDiwaliLampsSummary.
  ///
  /// In en, this message translates to:
  /// **'A row of clay lamps with small flames and a rangoli of bright colours around them.'**
  String get ideasDiwaliLampsSummary;

  /// No description provided for @ideasDiwaliLampsPractice.
  ///
  /// In en, this message translates to:
  /// **'A flat saturated pattern next to a two-step blend on the lamps.'**
  String get ideasDiwaliLampsPractice;

  /// No description provided for @ideasDiwaliLampsSubject.
  ///
  /// In en, this message translates to:
  /// **'Five little clay lamps in a curve, with a simple symmetrical pattern around them.'**
  String get ideasDiwaliLampsSubject;

  /// No description provided for @ideasDiwaliLampsTip.
  ///
  /// In en, this message translates to:
  /// **'Keep the pattern flat and hard-edged. It is the contrast with the lamps that makes it work.'**
  String get ideasDiwaliLampsTip;

  /// No description provided for @ideasDiwaliLampsStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil five little lamps in a curve and a simple symmetrical pattern around them.'**
  String get ideasDiwaliLampsStep1;

  /// No description provided for @ideasDiwaliLampsStep2.
  ///
  /// In en, this message translates to:
  /// **'Light terracotta on the lamps.'**
  String get ideasDiwaliLampsStep2;

  /// No description provided for @ideasDiwaliLampsStep3.
  ///
  /// In en, this message translates to:
  /// **'Deeper terracotta on their shadow side.'**
  String get ideasDiwaliLampsStep3;

  /// No description provided for @ideasDiwaliLampsStep4.
  ///
  /// In en, this message translates to:
  /// **'Yellow for each flame and a glow on the rim of each lamp.'**
  String get ideasDiwaliLampsStep4;

  /// No description provided for @ideasDiwaliLampsStep5.
  ///
  /// In en, this message translates to:
  /// **'Magenta in the alternating sections of the pattern, flat and hard-edged.'**
  String get ideasDiwaliLampsStep5;

  /// No description provided for @ideasDiwaliLampsStep6.
  ///
  /// In en, this message translates to:
  /// **'Teal in the other sections, then white gel dots on the flames if you like.'**
  String get ideasDiwaliLampsStep6;

  /// No description provided for @ideasHanukkahCandlesTitle.
  ///
  /// In en, this message translates to:
  /// **'Hanukkah'**
  String get ideasHanukkahCandlesTitle;

  /// No description provided for @ideasHanukkahCandlesSummary.
  ///
  /// In en, this message translates to:
  /// **'A menorah with its candles lit, blue and white with gold flames.'**
  String get ideasHanukkahCandlesSummary;

  /// No description provided for @ideasHanukkahCandlesPractice.
  ///
  /// In en, this message translates to:
  /// **'White shapes kept as paper against a blue field.'**
  String get ideasHanukkahCandlesPractice;

  /// No description provided for @ideasHanukkahCandlesSubject.
  ///
  /// In en, this message translates to:
  /// **'A menorah with its candles lit in front of a blue background.'**
  String get ideasHanukkahCandlesSubject;

  /// No description provided for @ideasHanukkahCandlesTip.
  ///
  /// In en, this message translates to:
  /// **'The candles are paper: colour around them and they come out white.'**
  String get ideasHanukkahCandlesTip;

  /// No description provided for @ideasHanukkahCandlesStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the menorah and the candles; the candles stay paper.'**
  String get ideasHanukkahCandlesStep1;

  /// No description provided for @ideasHanukkahCandlesStep2.
  ///
  /// In en, this message translates to:
  /// **'Light blue background around everything.'**
  String get ideasHanukkahCandlesStep2;

  /// No description provided for @ideasHanukkahCandlesStep3.
  ///
  /// In en, this message translates to:
  /// **'Deeper blue at the edges of the page, blended inwards.'**
  String get ideasHanukkahCandlesStep3;

  /// No description provided for @ideasHanukkahCandlesStep4.
  ///
  /// In en, this message translates to:
  /// **'The dark blue for the menorah itself.'**
  String get ideasHanukkahCandlesStep4;

  /// No description provided for @ideasHanukkahCandlesStep5.
  ///
  /// In en, this message translates to:
  /// **'Yellow flames and a soft glow around each, then a white gel core in each flame.'**
  String get ideasHanukkahCandlesStep5;

  /// No description provided for @ideasPaintedEggsTitle.
  ///
  /// In en, this message translates to:
  /// **'Painted eggs'**
  String get ideasPaintedEggsTitle;

  /// No description provided for @ideasPaintedEggsSummary.
  ///
  /// In en, this message translates to:
  /// **'Three decorated eggs with stripes, dots and zigzags in mid-strength colours.'**
  String get ideasPaintedEggsSummary;

  /// No description provided for @ideasPaintedEggsPractice.
  ///
  /// In en, this message translates to:
  /// **'Three ways to make a pattern: paper, shape and second layer.'**
  String get ideasPaintedEggsPractice;

  /// No description provided for @ideasPaintedEggsSubject.
  ///
  /// In en, this message translates to:
  /// **'Three eggs, each with a different pattern.'**
  String get ideasPaintedEggsSubject;

  /// No description provided for @ideasPaintedEggsTip.
  ///
  /// In en, this message translates to:
  /// **'Mid-strength colours let a second layer show without turning muddy.'**
  String get ideasPaintedEggsTip;

  /// No description provided for @ideasPaintedEggsStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three eggs and a different pattern on each.'**
  String get ideasPaintedEggsStep1;

  /// No description provided for @ideasPaintedEggsStep2.
  ///
  /// In en, this message translates to:
  /// **'First egg: base colour flat, with the pattern left as paper.'**
  String get ideasPaintedEggsStep2;

  /// No description provided for @ideasPaintedEggsStep3.
  ///
  /// In en, this message translates to:
  /// **'Second egg: fill the pattern shapes only, the rest stays paper.'**
  String get ideasPaintedEggsStep3;

  /// No description provided for @ideasPaintedEggsStep4.
  ///
  /// In en, this message translates to:
  /// **'Third egg: colour it, then add the pattern in the same colour as a second layer.'**
  String get ideasPaintedEggsStep4;

  /// No description provided for @ideasPaintedEggsStep5.
  ///
  /// In en, this message translates to:
  /// **'One grey for the shadow side of each egg and the small shadow under it.'**
  String get ideasPaintedEggsStep5;

  /// No description provided for @ideasDiaDeMuertosTitle.
  ///
  /// In en, this message translates to:
  /// **'Día de Muertos'**
  String get ideasDiaDeMuertosTitle;

  /// No description provided for @ideasDiaDeMuertosSummary.
  ///
  /// In en, this message translates to:
  /// **'Marigolds and a decorated skull in orange, magenta and teal on a dark ground.'**
  String get ideasDiaDeMuertosSummary;

  /// No description provided for @ideasDiaDeMuertosPractice.
  ///
  /// In en, this message translates to:
  /// **'Saturated flat pattern on a dark field.'**
  String get ideasDiaDeMuertosPractice;

  /// No description provided for @ideasDiaDeMuertosSubject.
  ///
  /// In en, this message translates to:
  /// **'A decorated skull with flower shapes round the eyes and a bank of marigolds below.'**
  String get ideasDiaDeMuertosSubject;

  /// No description provided for @ideasDiaDeMuertosTip.
  ///
  /// In en, this message translates to:
  /// **'Lay the dark ground last and slowly: dark ink runs into the light areas.'**
  String get ideasDiaDeMuertosTip;

  /// No description provided for @ideasDiaDeMuertosStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a skull with flower shapes round the eyes and a bank of marigolds below.'**
  String get ideasDiaDeMuertosStep1;

  /// No description provided for @ideasDiaDeMuertosStep2.
  ///
  /// In en, this message translates to:
  /// **'Light orange on the marigolds, each as a rough circle.'**
  String get ideasDiaDeMuertosStep2;

  /// No description provided for @ideasDiaDeMuertosStep3.
  ///
  /// In en, this message translates to:
  /// **'Deeper orange in short strokes inside each circle for the petals.'**
  String get ideasDiaDeMuertosStep3;

  /// No description provided for @ideasDiaDeMuertosStep4.
  ///
  /// In en, this message translates to:
  /// **'Magenta for the patterns of the skull, flat and symmetrical.'**
  String get ideasDiaDeMuertosStep4;

  /// No description provided for @ideasDiaDeMuertosStep5.
  ///
  /// In en, this message translates to:
  /// **'Teal for the other half of the patterns of the skull.'**
  String get ideasDiaDeMuertosStep5;

  /// No description provided for @ideasDiaDeMuertosStep6.
  ///
  /// In en, this message translates to:
  /// **'The darkest marker for the eye sockets and the background, then liner details.'**
  String get ideasDiaDeMuertosStep6;

  /// No description provided for @ideasValentineCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Valentine card'**
  String get ideasValentineCardTitle;

  /// No description provided for @ideasValentineCardSummary.
  ///
  /// In en, this message translates to:
  /// **'A card with three hearts, from pale pink to deep red, and a shadow line that lifts them off the paper.'**
  String get ideasValentineCardSummary;

  /// No description provided for @ideasValentineCardPractice.
  ///
  /// In en, this message translates to:
  /// **'Three flat fills and a drop-shadow line.'**
  String get ideasValentineCardPractice;

  /// No description provided for @ideasValentineCardSubject.
  ///
  /// In en, this message translates to:
  /// **'Three overlapping hearts, the biggest at the back.'**
  String get ideasValentineCardSubject;

  /// No description provided for @ideasValentineCardTip.
  ///
  /// In en, this message translates to:
  /// **'Draw the drop shadow as one thin line: it lifts the heart without more colour.'**
  String get ideasValentineCardTip;

  /// No description provided for @ideasValentineCardStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three overlapping hearts, the biggest at the back.'**
  String get ideasValentineCardStep1;

  /// No description provided for @ideasValentineCardStep2.
  ///
  /// In en, this message translates to:
  /// **'Pale pink on the back heart.'**
  String get ideasValentineCardStep2;

  /// No description provided for @ideasValentineCardStep3.
  ///
  /// In en, this message translates to:
  /// **'Pink on the middle one.'**
  String get ideasValentineCardStep3;

  /// No description provided for @ideasValentineCardStep4.
  ///
  /// In en, this message translates to:
  /// **'Red on the front one, and a thin line of it under the other two as a drop shadow.'**
  String get ideasValentineCardStep4;

  /// No description provided for @ideasValentineCardStep5.
  ///
  /// In en, this message translates to:
  /// **'A white gel highlight on each heart, top left.'**
  String get ideasValentineCardStep5;

  /// No description provided for @ideasCarnivalMaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Carnival mask'**
  String get ideasCarnivalMaskTitle;

  /// No description provided for @ideasCarnivalMaskSummary.
  ///
  /// In en, this message translates to:
  /// **'A mask with feathers in violet, teal and gold.'**
  String get ideasCarnivalMaskSummary;

  /// No description provided for @ideasCarnivalMaskPractice.
  ///
  /// In en, this message translates to:
  /// **'Flicks for feathers, a blend for the mask and flat gold.'**
  String get ideasCarnivalMaskPractice;

  /// No description provided for @ideasCarnivalMaskSubject.
  ///
  /// In en, this message translates to:
  /// **'A half mask with three feathers rising from one side.'**
  String get ideasCarnivalMaskSubject;

  /// No description provided for @ideasCarnivalMaskTip.
  ///
  /// In en, this message translates to:
  /// **'Flick the feathers outwards from the quill: the soft edge is what makes them read as feathers.'**
  String get ideasCarnivalMaskTip;

  /// No description provided for @ideasCarnivalMaskStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a half mask and three feathers rising from one side.'**
  String get ideasCarnivalMaskStep1;

  /// No description provided for @ideasCarnivalMaskStep2.
  ///
  /// In en, this message translates to:
  /// **'Violet on the mask, two layers where it curves away.'**
  String get ideasCarnivalMaskStep2;

  /// No description provided for @ideasCarnivalMaskStep3.
  ///
  /// In en, this message translates to:
  /// **'Teal on the feathers, flicked outwards from the quill so the edges are soft.'**
  String get ideasCarnivalMaskStep3;

  /// No description provided for @ideasCarnivalMaskStep4.
  ///
  /// In en, this message translates to:
  /// **'Gold on the edge of the mask and the eye rims.'**
  String get ideasCarnivalMaskStep4;

  /// No description provided for @ideasCarnivalMaskStep5.
  ///
  /// In en, this message translates to:
  /// **'Darkest inside the eye holes, then gel dots as sequins.'**
  String get ideasCarnivalMaskStep5;

  /// No description provided for @ideasMidsummerCrownTitle.
  ///
  /// In en, this message translates to:
  /// **'Midsummer flower crown'**
  String get ideasMidsummerCrownTitle;

  /// No description provided for @ideasMidsummerCrownSummary.
  ///
  /// In en, this message translates to:
  /// **'A crown of wildflowers and leaves: blue, yellow and pink on green.'**
  String get ideasMidsummerCrownSummary;

  /// No description provided for @ideasMidsummerCrownPractice.
  ///
  /// In en, this message translates to:
  /// **'Many small dabs of the fine nib on a dry green base.'**
  String get ideasMidsummerCrownPractice;

  /// No description provided for @ideasMidsummerCrownSubject.
  ///
  /// In en, this message translates to:
  /// **'A ring of leaves with three kinds of small wildflowers.'**
  String get ideasMidsummerCrownSubject;

  /// No description provided for @ideasMidsummerCrownTip.
  ///
  /// In en, this message translates to:
  /// **'Dabs of colour on a dry base stay crisp. Wait for the green to dry before you start the flowers.'**
  String get ideasMidsummerCrownTip;

  /// No description provided for @ideasMidsummerCrownStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a ring of leaves and small flowers in three kinds.'**
  String get ideasMidsummerCrownStep1;

  /// No description provided for @ideasMidsummerCrownStep2.
  ///
  /// In en, this message translates to:
  /// **'Light green on all the leaves.'**
  String get ideasMidsummerCrownStep2;

  /// No description provided for @ideasMidsummerCrownStep3.
  ///
  /// In en, this message translates to:
  /// **'Darker green where leaves overlap and underneath.'**
  String get ideasMidsummerCrownStep3;

  /// No description provided for @ideasMidsummerCrownStep4.
  ///
  /// In en, this message translates to:
  /// **'Blue on the first kind of flower.'**
  String get ideasMidsummerCrownStep4;

  /// No description provided for @ideasMidsummerCrownStep5.
  ///
  /// In en, this message translates to:
  /// **'Yellow on the second kind of flower.'**
  String get ideasMidsummerCrownStep5;

  /// No description provided for @ideasMidsummerCrownStep6.
  ///
  /// In en, this message translates to:
  /// **'Pink on the third, with a tiny second layer at the centre of each flower.'**
  String get ideasMidsummerCrownStep6;

  /// No description provided for @ideasEidNightTitle.
  ///
  /// In en, this message translates to:
  /// **'Eid night'**
  String get ideasEidNightTitle;

  /// No description provided for @ideasEidNightSummary.
  ///
  /// In en, this message translates to:
  /// **'A crescent moon and a hanging lantern against a deep teal and violet sky.'**
  String get ideasEidNightSummary;

  /// No description provided for @ideasEidNightPractice.
  ///
  /// In en, this message translates to:
  /// **'A clean wet blend from teal to violet, with gold laid on top.'**
  String get ideasEidNightPractice;

  /// No description provided for @ideasEidNightSubject.
  ///
  /// In en, this message translates to:
  /// **'A crescent moon and a patterned lantern against a night sky.'**
  String get ideasEidNightSubject;

  /// No description provided for @ideasEidNightTip.
  ///
  /// In en, this message translates to:
  /// **'Blend the teal into the violet while both are wet. Once dry, the sky stays clean.'**
  String get ideasEidNightTip;

  /// No description provided for @ideasEidNightStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the crescent and a patterned lantern; both stay paper for now.'**
  String get ideasEidNightStep1;

  /// No description provided for @ideasEidNightStep2.
  ///
  /// In en, this message translates to:
  /// **'Teal across the sky, lightest near the moon.'**
  String get ideasEidNightStep2;

  /// No description provided for @ideasEidNightStep3.
  ///
  /// In en, this message translates to:
  /// **'Deeper teal towards the edges.'**
  String get ideasEidNightStep3;

  /// No description provided for @ideasEidNightStep4.
  ///
  /// In en, this message translates to:
  /// **'Violet blended into the top corners while the teal is still damp.'**
  String get ideasEidNightStep4;

  /// No description provided for @ideasEidNightStep5.
  ///
  /// In en, this message translates to:
  /// **'Gold on the crescent and the lantern frame; the panes stay pale, then white gel stars.'**
  String get ideasEidNightStep5;

  /// No description provided for @ideasHoliColoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Holi'**
  String get ideasHoliColoursTitle;

  /// No description provided for @ideasHoliColoursSummary.
  ///
  /// In en, this message translates to:
  /// **'Clouds of coloured powder on white: soft edges, hard centres, four bright colours.'**
  String get ideasHoliColoursSummary;

  /// No description provided for @ideasHoliColoursPractice.
  ///
  /// In en, this message translates to:
  /// **'Colour with no edge: the blender dissolves an edge into paper.'**
  String get ideasHoliColoursPractice;

  /// No description provided for @ideasHoliColoursSubject.
  ///
  /// In en, this message translates to:
  /// **'Four overlapping clouds of coloured powder on white paper.'**
  String get ideasHoliColoursSubject;

  /// No description provided for @ideasHoliColoursTip.
  ///
  /// In en, this message translates to:
  /// **'Let each cloud dry before you add the next one, or the colours all turn to mud.'**
  String get ideasHoliColoursTip;

  /// No description provided for @ideasHoliColoursStep1.
  ///
  /// In en, this message translates to:
  /// **'Scribble a loose cloud with the first colour, dense in the middle.'**
  String get ideasHoliColoursStep1;

  /// No description provided for @ideasHoliColoursStep2.
  ///
  /// In en, this message translates to:
  /// **'Pull its edges out with the blender into the white paper until they vanish.'**
  String get ideasHoliColoursStep2;

  /// No description provided for @ideasHoliColoursStep3.
  ///
  /// In en, this message translates to:
  /// **'A second cloud overlapping the first a little; where they meet, let them mix.'**
  String get ideasHoliColoursStep3;

  /// No description provided for @ideasHoliColoursStep4.
  ///
  /// In en, this message translates to:
  /// **'A third cloud, smaller, in a gap.'**
  String get ideasHoliColoursStep4;

  /// No description provided for @ideasHoliColoursStep5.
  ///
  /// In en, this message translates to:
  /// **'A fourth cloud in the last gap, then flick a few dots of each colour around it.'**
  String get ideasHoliColoursStep5;

  /// No description provided for @ideasSummerIceCreamTitle.
  ///
  /// In en, this message translates to:
  /// **'Ice cream'**
  String get ideasSummerIceCreamTitle;

  /// No description provided for @ideasSummerIceCreamSummary.
  ///
  /// In en, this message translates to:
  /// **'Three scoops of different flavours on a cone.'**
  String get ideasSummerIceCreamSummary;

  /// No description provided for @ideasSummerIceCreamPractice.
  ///
  /// In en, this message translates to:
  /// **'Three round blends and one grey shading all of them.'**
  String get ideasSummerIceCreamPractice;

  /// No description provided for @ideasSummerIceCreamSubject.
  ///
  /// In en, this message translates to:
  /// **'Three stacked scoops on a cone with a waffle grid.'**
  String get ideasSummerIceCreamSubject;

  /// No description provided for @ideasSummerIceCreamTip.
  ///
  /// In en, this message translates to:
  /// **'Use the same grey for every scoop: that is what keeps three different colours together.'**
  String get ideasSummerIceCreamTip;

  /// No description provided for @ideasSummerIceCreamStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a cone with a waffle grid and three stacked scoops.'**
  String get ideasSummerIceCreamStep1;

  /// No description provided for @ideasSummerIceCreamStep2.
  ///
  /// In en, this message translates to:
  /// **'The first flavour on the bottom scoop, with a highlight of paper left on it.'**
  String get ideasSummerIceCreamStep2;

  /// No description provided for @ideasSummerIceCreamStep3.
  ///
  /// In en, this message translates to:
  /// **'The second flavour on the middle scoop, with its own highlight.'**
  String get ideasSummerIceCreamStep3;

  /// No description provided for @ideasSummerIceCreamStep4.
  ///
  /// In en, this message translates to:
  /// **'The third flavour on the top scoop.'**
  String get ideasSummerIceCreamStep4;

  /// No description provided for @ideasSummerIceCreamStep5.
  ///
  /// In en, this message translates to:
  /// **'The same light grey on the underside of every scoop and where they overlap.'**
  String get ideasSummerIceCreamStep5;

  /// No description provided for @ideasSummerIceCreamStep6.
  ///
  /// In en, this message translates to:
  /// **'The cone in beige, with the grid lines in a second layer.'**
  String get ideasSummerIceCreamStep6;

  /// No description provided for @ideasNewYearFireworksTitle.
  ///
  /// In en, this message translates to:
  /// **'New Year fireworks'**
  String get ideasNewYearFireworksTitle;

  /// No description provided for @ideasNewYearFireworksSummary.
  ///
  /// In en, this message translates to:
  /// **'Three bursts of fireworks over a dark sky, each a different colour.'**
  String get ideasNewYearFireworksSummary;

  /// No description provided for @ideasNewYearFireworksPractice.
  ///
  /// In en, this message translates to:
  /// **'Bright colour over a dark fill, with the lines kept as paper.'**
  String get ideasNewYearFireworksPractice;

  /// No description provided for @ideasNewYearFireworksSubject.
  ///
  /// In en, this message translates to:
  /// **'Three bursts of fireworks with light lines radiating from each centre.'**
  String get ideasNewYearFireworksSubject;

  /// No description provided for @ideasNewYearFireworksTip.
  ///
  /// In en, this message translates to:
  /// **'Fill the sky around the lines, not over them: the white paper is what makes the fireworks glow.'**
  String get ideasNewYearFireworksTip;

  /// No description provided for @ideasNewYearFireworksStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three centres and light radiating lines from each; the lines stay paper for now.'**
  String get ideasNewYearFireworksStep1;

  /// No description provided for @ideasNewYearFireworksStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the sky dark, going round the lines with the fine nib (they can be uneven).'**
  String get ideasNewYearFireworksStep2;

  /// No description provided for @ideasNewYearFireworksStep3.
  ///
  /// In en, this message translates to:
  /// **'Trace the lines of the first burst with the first colour, pressing harder at the tips.'**
  String get ideasNewYearFireworksStep3;

  /// No description provided for @ideasNewYearFireworksStep4.
  ///
  /// In en, this message translates to:
  /// **'The lines of the second burst in the second colour.'**
  String get ideasNewYearFireworksStep4;

  /// No description provided for @ideasNewYearFireworksStep5.
  ///
  /// In en, this message translates to:
  /// **'The lines of the third burst in the third colour.'**
  String get ideasNewYearFireworksStep5;

  /// No description provided for @ideasNewYearFireworksStep6.
  ///
  /// In en, this message translates to:
  /// **'White gel at the centre of each burst and a few sparks at the tips.'**
  String get ideasNewYearFireworksStep6;

  /// No description provided for @ideasCozyLampTitle.
  ///
  /// In en, this message translates to:
  /// **'Cosy corner'**
  String get ideasCozyLampTitle;

  /// No description provided for @ideasCozyLampSummary.
  ///
  /// In en, this message translates to:
  /// **'An armchair under a lamp in the evening: a warm pool of light and soft brown shadows.'**
  String get ideasCozyLampSummary;

  /// No description provided for @ideasCozyLampPractice.
  ///
  /// In en, this message translates to:
  /// **'Planning a lit area and letting the rest of the room fall into warm brown.'**
  String get ideasCozyLampPractice;

  /// No description provided for @ideasCozyLampSubject.
  ///
  /// In en, this message translates to:
  /// **'An armchair, a floor lamp and a wall behind them.'**
  String get ideasCozyLampSubject;

  /// No description provided for @ideasCozyLampTip.
  ///
  /// In en, this message translates to:
  /// **'Keep the darkest brown out of the circle of light: the lamp reaches no corner.'**
  String get ideasCozyLampTip;

  /// No description provided for @ideasCozyLampStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the chair, the lamp and the circle of light it throws on the floor and the wall.'**
  String get ideasCozyLampStep1;

  /// No description provided for @ideasCozyLampStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the circle of light with the pale yellow and fade it out with the colourless blender.'**
  String get ideasCozyLampStep2;

  /// No description provided for @ideasCozyLampStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the rest of the room with the light warm beige, flat and even.'**
  String get ideasCozyLampStep3;

  /// No description provided for @ideasCozyLampStep4.
  ///
  /// In en, this message translates to:
  /// **'Put the warm brown on the chair and on the side of the room that is away from the lamp.'**
  String get ideasCozyLampStep4;

  /// No description provided for @ideasCozyLampStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the dark brown in the corners and under the chair, and keep it off the circle of light.'**
  String get ideasCozyLampStep5;

  /// No description provided for @ideasFoggyMorningTitle.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get ideasFoggyMorningTitle;

  /// No description provided for @ideasFoggyMorningSummary.
  ///
  /// In en, this message translates to:
  /// **'Trees disappearing into fog: the nearer ones darker, the further ones paler.'**
  String get ideasFoggyMorningSummary;

  /// No description provided for @ideasFoggyMorningPractice.
  ///
  /// In en, this message translates to:
  /// **'Depth with a pale glaze over dark shapes.'**
  String get ideasFoggyMorningPractice;

  /// No description provided for @ideasFoggyMorningSubject.
  ///
  /// In en, this message translates to:
  /// **'Three rows of trees on a road, each row further back.'**
  String get ideasFoggyMorningSubject;

  /// No description provided for @ideasFoggyMorningTip.
  ///
  /// In en, this message translates to:
  /// **'A pale glaze over a dark shape is the simplest fog there is: the ink under it stays.'**
  String get ideasFoggyMorningTip;

  /// No description provided for @ideasFoggyMorningStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three rows of trees, each row further back, and mark where the ground starts.'**
  String get ideasFoggyMorningStep1;

  /// No description provided for @ideasFoggyMorningStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the furthest row with the palest marker only, without any detail.'**
  String get ideasFoggyMorningStep2;

  /// No description provided for @ideasFoggyMorningStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the middle row with the base tone and soften its lower edge into the ground with the blender.'**
  String get ideasFoggyMorningStep3;

  /// No description provided for @ideasFoggyMorningStep4.
  ///
  /// In en, this message translates to:
  /// **'Draw the nearest trees with the dark marker and add a few branches.'**
  String get ideasFoggyMorningStep4;

  /// No description provided for @ideasFoggyMorningStep5.
  ///
  /// In en, this message translates to:
  /// **'Glaze the pale marker over the top of every row, so the fog lies over the whole scene.'**
  String get ideasFoggyMorningStep5;

  /// No description provided for @ideasRainyWindowTitle.
  ///
  /// In en, this message translates to:
  /// **'Rain on the window'**
  String get ideasRainyWindowTitle;

  /// No description provided for @ideasRainyWindowSummary.
  ///
  /// In en, this message translates to:
  /// **'Blurred lights seen through a wet window, with drops running down the glass.'**
  String get ideasRainyWindowSummary;

  /// No description provided for @ideasRainyWindowPractice.
  ///
  /// In en, this message translates to:
  /// **'Glowing lights behind glass, and crisp marks on top of them.'**
  String get ideasRainyWindowPractice;

  /// No description provided for @ideasRainyWindowSubject.
  ///
  /// In en, this message translates to:
  /// **'A window at night with street lights outside and three drops on the glass.'**
  String get ideasRainyWindowSubject;

  /// No description provided for @ideasRainyWindowTip.
  ///
  /// In en, this message translates to:
  /// **'The lights must dry completely before the blue goes over them, or the colours mix.'**
  String get ideasRainyWindowTip;

  /// No description provided for @ideasRainyWindowStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the window frame and a few blurred blobs of light outside, and mark the path of three drops.'**
  String get ideasRainyWindowStep1;

  /// No description provided for @ideasRainyWindowStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the warm lights as soft blobs and melt their edges with the blender.'**
  String get ideasRainyWindowStep2;

  /// No description provided for @ideasRainyWindowStep3.
  ///
  /// In en, this message translates to:
  /// **'Cover the whole glass with the light blue, working around the lights.'**
  String get ideasRainyWindowStep3;

  /// No description provided for @ideasRainyWindowStep4.
  ///
  /// In en, this message translates to:
  /// **'Add the base blue towards the corners and leave the drop paths a little lighter.'**
  String get ideasRainyWindowStep4;

  /// No description provided for @ideasRainyWindowStep5.
  ///
  /// In en, this message translates to:
  /// **'Colour the frame dark and put a dark crescent on the side of each drop away from the light.'**
  String get ideasRainyWindowStep5;

  /// No description provided for @ideasRainyWindowStep6.
  ///
  /// In en, this message translates to:
  /// **'Once dry, add a touch of white gel on the lit side of each drop.'**
  String get ideasRainyWindowStep6;

  /// No description provided for @ideasEerieForestTitle.
  ///
  /// In en, this message translates to:
  /// **'Eerie woods'**
  String get ideasEerieForestTitle;

  /// No description provided for @ideasEerieForestSummary.
  ///
  /// In en, this message translates to:
  /// **'Thin trees at dusk in sickly greens, with a violet sky between them.'**
  String get ideasEerieForestSummary;

  /// No description provided for @ideasEerieForestPractice.
  ///
  /// In en, this message translates to:
  /// **'Letting two colours mix where they meet, on purpose.'**
  String get ideasEerieForestPractice;

  /// No description provided for @ideasEerieForestSubject.
  ///
  /// In en, this message translates to:
  /// **'Tall thin trunks on a low horizon at dusk.'**
  String get ideasEerieForestSubject;

  /// No description provided for @ideasEerieForestTip.
  ///
  /// In en, this message translates to:
  /// **'The green and the violet turn grey where they meet. That grey is the mood, not a mistake.'**
  String get ideasEerieForestTip;

  /// No description provided for @ideasEerieForestStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil tall thin trunks and a low horizon.'**
  String get ideasEerieForestStep1;

  /// No description provided for @ideasEerieForestStep2.
  ///
  /// In en, this message translates to:
  /// **'Put a pale yellow-green along the horizon, between the trunks.'**
  String get ideasEerieForestStep2;

  /// No description provided for @ideasEerieForestStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the violet above it and blend it into the green while it is damp.'**
  String get ideasEerieForestStep3;

  /// No description provided for @ideasEerieForestStep4.
  ///
  /// In en, this message translates to:
  /// **'Colour the green on the ground and on the lower part of the trunks.'**
  String get ideasEerieForestStep4;

  /// No description provided for @ideasEerieForestStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest green on the trunks in uneven strokes, and add long shadows across the ground.'**
  String get ideasEerieForestStep5;

  /// No description provided for @ideasGoldenHourTitle.
  ///
  /// In en, this message translates to:
  /// **'Golden hour'**
  String get ideasGoldenHourTitle;

  /// No description provided for @ideasGoldenHourSummary.
  ///
  /// In en, this message translates to:
  /// **'A white wall and a doorway at the end of the afternoon: orange light, long violet shadows.'**
  String get ideasGoldenHourSummary;

  /// No description provided for @ideasGoldenHourPractice.
  ///
  /// In en, this message translates to:
  /// **'One warm glaze over everything, with hard-edged cool shadows on top.'**
  String get ideasGoldenHourPractice;

  /// No description provided for @ideasGoldenHourSubject.
  ///
  /// In en, this message translates to:
  /// **'A wall with a door, a plant and the long shadow the plant throws on the wall.'**
  String get ideasGoldenHourSubject;

  /// No description provided for @ideasGoldenHourTip.
  ///
  /// In en, this message translates to:
  /// **'The wall is not white here: in this light it is orange. Paint it so.'**
  String get ideasGoldenHourTip;

  /// No description provided for @ideasGoldenHourStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a wall with a door and a plant, and the long shadow the plant throws across the wall.'**
  String get ideasGoldenHourStep1;

  /// No description provided for @ideasGoldenHourStep2.
  ///
  /// In en, this message translates to:
  /// **'Wash the whole wall with the pale orange: that is the white wall in this light.'**
  String get ideasGoldenHourStep2;

  /// No description provided for @ideasGoldenHourStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the deeper orange under the lintel and on the door.'**
  String get ideasGoldenHourStep3;

  /// No description provided for @ideasGoldenHourStep4.
  ///
  /// In en, this message translates to:
  /// **'Add the violet-grey in the shadow of the plant and in the doorway, with a crisp edge.'**
  String get ideasGoldenHourStep4;

  /// No description provided for @ideasGoldenHourStep5.
  ///
  /// In en, this message translates to:
  /// **'Keep the darkest marker for the depth of the doorway only.'**
  String get ideasGoldenHourStep5;

  /// No description provided for @ideasStormySeaTitle.
  ///
  /// In en, this message translates to:
  /// **'Stormy sea'**
  String get ideasStormySeaTitle;

  /// No description provided for @ideasStormySeaSummary.
  ///
  /// In en, this message translates to:
  /// **'Grey-green waves under a dark sky, with white paper for the foam.'**
  String get ideasStormySeaSummary;

  /// No description provided for @ideasStormySeaPractice.
  ///
  /// In en, this message translates to:
  /// **'Pale flat water against a heavy sky, with the foam left as paper.'**
  String get ideasStormySeaPractice;

  /// No description provided for @ideasStormySeaSubject.
  ///
  /// In en, this message translates to:
  /// **'A low horizon, two big waves and the foam breaking on them.'**
  String get ideasStormySeaSubject;

  /// No description provided for @ideasStormySeaTip.
  ///
  /// In en, this message translates to:
  /// **'The foam is paper you did not touch: plan where it breaks before you colour the water.'**
  String get ideasStormySeaTip;

  /// No description provided for @ideasStormySeaStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the horizon low, two big waves and where the foam breaks. The foam stays paper.'**
  String get ideasStormySeaStep1;

  /// No description provided for @ideasStormySeaStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the water with the pale grey-green, going round the foam.'**
  String get ideasStormySeaStep2;

  /// No description provided for @ideasStormySeaStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the darker water in the troughs and under each crest.'**
  String get ideasStormySeaStep3;

  /// No description provided for @ideasStormySeaStep4.
  ///
  /// In en, this message translates to:
  /// **'Fill the sky with the dark marker, darkest at the top, and the deepest water under the breaking wave.'**
  String get ideasStormySeaStep4;

  /// No description provided for @ideasStormySeaStep5.
  ///
  /// In en, this message translates to:
  /// **'Once dry, add white gel for the spray flicked off the crests: a few dots only.'**
  String get ideasStormySeaStep5;

  /// No description provided for @ideasCandleFlameTitle.
  ///
  /// In en, this message translates to:
  /// **'By candlelight'**
  String get ideasCandleFlameTitle;

  /// No description provided for @ideasCandleFlameSummary.
  ///
  /// In en, this message translates to:
  /// **'A candle on a table in a dark room: everything warm, and nothing far from the flame visible.'**
  String get ideasCandleFlameSummary;

  /// No description provided for @ideasCandleFlamePractice.
  ///
  /// In en, this message translates to:
  /// **'Concentric rings of warm colour, blended wet into each other.'**
  String get ideasCandleFlamePractice;

  /// No description provided for @ideasCandleFlameSubject.
  ///
  /// In en, this message translates to:
  /// **'A candle in a holder, with the table and the far wall behind it.'**
  String get ideasCandleFlameSubject;

  /// No description provided for @ideasCandleFlameTip.
  ///
  /// In en, this message translates to:
  /// **'Only what the flame touches is visible: the far room can be almost one dark shape.'**
  String get ideasCandleFlameTip;

  /// No description provided for @ideasCandleFlameStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the candle, its flame and a circle of light on the table. The core of the flame stays paper.'**
  String get ideasCandleFlameStep1;

  /// No description provided for @ideasCandleFlameStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the halo of the flame and the nearest part of the table with the yellow, melted outwards with the blender.'**
  String get ideasCandleFlameStep2;

  /// No description provided for @ideasCandleFlameStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the warm orange on the lit side of the candle and on the next ring of the table.'**
  String get ideasCandleFlameStep3;

  /// No description provided for @ideasCandleFlameStep4.
  ///
  /// In en, this message translates to:
  /// **'Colour brown everything beyond the circle of light.'**
  String get ideasCandleFlameStep4;

  /// No description provided for @ideasCandleFlameStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest brown for the far room and the shadow side of the candle, with a soft edge against the light.'**
  String get ideasCandleFlameStep5;

  /// No description provided for @ideasDesertNoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Desert noon'**
  String get ideasDesertNoonTitle;

  /// No description provided for @ideasDesertNoonSummary.
  ///
  /// In en, this message translates to:
  /// **'Sand, one rock and a hard shadow under a bleached sky.'**
  String get ideasDesertNoonSummary;

  /// No description provided for @ideasDesertNoonPractice.
  ///
  /// In en, this message translates to:
  /// **'A flat pale fill against one hard, dark shadow.'**
  String get ideasDesertNoonPractice;

  /// No description provided for @ideasDesertNoonSubject.
  ///
  /// In en, this message translates to:
  /// **'A high horizon, a single rock and its short shadow straight under it.'**
  String get ideasDesertNoonSubject;

  /// No description provided for @ideasDesertNoonTip.
  ///
  /// In en, this message translates to:
  /// **'Leave a band of white paper at the horizon: that band is what makes the sky look hot.'**
  String get ideasDesertNoonTip;

  /// No description provided for @ideasDesertNoonStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a high horizon, one rock and its short shadow straight under it.'**
  String get ideasDesertNoonStep1;

  /// No description provided for @ideasDesertNoonStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the sand below the horizon with the pale yellow, in one very light pass.'**
  String get ideasDesertNoonStep2;

  /// No description provided for @ideasDesertNoonStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the sky with the pale blue and leave it paler near the horizon.'**
  String get ideasDesertNoonStep3;

  /// No description provided for @ideasDesertNoonStep4.
  ///
  /// In en, this message translates to:
  /// **'Put the orange on the shadow side of the rock and on the ripples of the sand.'**
  String get ideasDesertNoonStep4;

  /// No description provided for @ideasDesertNoonStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the violet-blue only in the shadow the rock casts, with a hard edge.'**
  String get ideasDesertNoonStep5;

  /// No description provided for @ideasBokehLightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Blurred lights'**
  String get ideasBokehLightsTitle;

  /// No description provided for @ideasBokehLightsSummary.
  ///
  /// In en, this message translates to:
  /// **'A background of soft out-of-focus circles of light.'**
  String get ideasBokehLightsSummary;

  /// No description provided for @ideasBokehLightsPractice.
  ///
  /// In en, this message translates to:
  /// **'Making a soft disc with the blender on a flat field.'**
  String get ideasBokehLightsPractice;

  /// No description provided for @ideasBokehLightsSubject.
  ///
  /// In en, this message translates to:
  /// **'A dark field with a dozen blurred lights of different sizes.'**
  String get ideasBokehLightsSubject;

  /// No description provided for @ideasBokehLightsTip.
  ///
  /// In en, this message translates to:
  /// **'Press the blender flat: a pointed nib draws a line, not a disc.'**
  String get ideasBokehLightsTip;

  /// No description provided for @ideasBokehLightsStep1.
  ///
  /// In en, this message translates to:
  /// **'Fill the whole area with the base colour, in flat strokes.'**
  String get ideasBokehLightsStep1;

  /// No description provided for @ideasBokehLightsStep2.
  ///
  /// In en, this message translates to:
  /// **'Darken the corners and blend the dark inwards while the ink is damp.'**
  String get ideasBokehLightsStep2;

  /// No description provided for @ideasBokehLightsStep3.
  ///
  /// In en, this message translates to:
  /// **'Let it dry, then press the broad nib of the blender flat in circles of different sizes.'**
  String get ideasBokehLightsStep3;

  /// No description provided for @ideasBokehLightsStep4.
  ///
  /// In en, this message translates to:
  /// **'Touch the light marker into the centre of a few of the discs so they glow.'**
  String get ideasBokehLightsStep4;

  /// No description provided for @ideasBokehLightsStep5.
  ///
  /// In en, this message translates to:
  /// **'Put a white gel dot inside two or three of the discs, not in all of them.'**
  String get ideasBokehLightsStep5;

  /// No description provided for @ideasRetroPosterTitle.
  ///
  /// In en, this message translates to:
  /// **'Retro poster'**
  String get ideasRetroPosterTitle;

  /// No description provided for @ideasRetroPosterSummary.
  ///
  /// In en, this message translates to:
  /// **'Three flat, slightly dusty colours and one dark, with no blending at all.'**
  String get ideasRetroPosterSummary;

  /// No description provided for @ideasRetroPosterPractice.
  ///
  /// In en, this message translates to:
  /// **'Flat fills and hard edges, the way a printed poster looks.'**
  String get ideasRetroPosterPractice;

  /// No description provided for @ideasRetroPosterSubject.
  ///
  /// In en, this message translates to:
  /// **'A lighthouse, a car or a bottle drawn as a few big flat shapes.'**
  String get ideasRetroPosterSubject;

  /// No description provided for @ideasRetroPosterTip.
  ///
  /// In en, this message translates to:
  /// **'Leave a hair of white paper between the colours, as if the print had slipped a little.'**
  String get ideasRetroPosterTip;

  /// No description provided for @ideasRetroPosterStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a simple subject as big flat shapes: a lighthouse, a car, a bottle.'**
  String get ideasRetroPosterStep1;

  /// No description provided for @ideasRetroPosterStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the biggest shapes flat, in one pass.'**
  String get ideasRetroPosterStep2;

  /// No description provided for @ideasRetroPosterStep3.
  ///
  /// In en, this message translates to:
  /// **'Fill the next shapes and leave a hair of paper between the colours.'**
  String get ideasRetroPosterStep3;

  /// No description provided for @ideasRetroPosterStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the third colour on the smallest shapes.'**
  String get ideasRetroPosterStep4;

  /// No description provided for @ideasRetroPosterStep5.
  ///
  /// In en, this message translates to:
  /// **'Draw the shadows as separate flat shapes with the dark marker.'**
  String get ideasRetroPosterStep5;

  /// No description provided for @ideasRetroPosterStep6.
  ///
  /// In en, this message translates to:
  /// **'Add a few liner lines where the printed poster would have them.'**
  String get ideasRetroPosterStep6;

  /// No description provided for @ideasFreshCitrusTitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh and zesty'**
  String get ideasFreshCitrusTitle;

  /// No description provided for @ideasFreshCitrusSummary.
  ///
  /// In en, this message translates to:
  /// **'A lemon, a lime and a glass of water, with lots of white paper and at most two layers.'**
  String get ideasFreshCitrusSummary;

  /// No description provided for @ideasFreshCitrusPractice.
  ///
  /// In en, this message translates to:
  /// **'Bright colour on white, stopped early.'**
  String get ideasFreshCitrusPractice;

  /// No description provided for @ideasFreshCitrusSubject.
  ///
  /// In en, this message translates to:
  /// **'A lemon, a lime and a glass of water on a table.'**
  String get ideasFreshCitrusSubject;

  /// No description provided for @ideasFreshCitrusTip.
  ///
  /// In en, this message translates to:
  /// **'Stop after two layers: a third one takes the fresh out of the colour.'**
  String get ideasFreshCitrusTip;

  /// No description provided for @ideasFreshCitrusStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the fruit and the glass, and keep the composition airy.'**
  String get ideasFreshCitrusStep1;

  /// No description provided for @ideasFreshCitrusStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the lemon with the yellow in one pass, leaving a white highlight.'**
  String get ideasFreshCitrusStep2;

  /// No description provided for @ideasFreshCitrusStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the lime with the green, also in one pass.'**
  String get ideasFreshCitrusStep3;

  /// No description provided for @ideasFreshCitrusStep4.
  ///
  /// In en, this message translates to:
  /// **'The darker yellow on the shadow side of the lemon, and a second pass of green on the shadow side of the lime.'**
  String get ideasFreshCitrusStep4;

  /// No description provided for @ideasFreshCitrusStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the pale blue for the water in the glass and a small shadow under each fruit.'**
  String get ideasFreshCitrusStep5;

  /// No description provided for @ideasTropicalNoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Tropical noon'**
  String get ideasTropicalNoonTitle;

  /// No description provided for @ideasTropicalNoonSummary.
  ///
  /// In en, this message translates to:
  /// **'Big leaves, a hot pink flower and a slice of blue sky, saturated and hard-edged.'**
  String get ideasTropicalNoonSummary;

  /// No description provided for @ideasTropicalNoonPractice.
  ///
  /// In en, this message translates to:
  /// **'Strong flat colour with crisp overlaps, without any blending.'**
  String get ideasTropicalNoonPractice;

  /// No description provided for @ideasTropicalNoonSubject.
  ///
  /// In en, this message translates to:
  /// **'Two or three big leaves overlapping, one flower and the sky in the gaps.'**
  String get ideasTropicalNoonSubject;

  /// No description provided for @ideasTropicalNoonTip.
  ///
  /// In en, this message translates to:
  /// **'Leave the edge of each leaf sharp: the overlap is what sells the depth here.'**
  String get ideasTropicalNoonTip;

  /// No description provided for @ideasTropicalNoonStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil two or three large leaves overlapping, one flower and the sky in the gaps between them.'**
  String get ideasTropicalNoonStep1;

  /// No description provided for @ideasTropicalNoonStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the leaves with the light green, following the veins.'**
  String get ideasTropicalNoonStep2;

  /// No description provided for @ideasTropicalNoonStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the mid green on the leaves behind and under the others, with hard edges where they overlap.'**
  String get ideasTropicalNoonStep3;

  /// No description provided for @ideasTropicalNoonStep4.
  ///
  /// In en, this message translates to:
  /// **'Colour the hot pink on the flower, with two layers.'**
  String get ideasTropicalNoonStep4;

  /// No description provided for @ideasTropicalNoonStep5.
  ///
  /// In en, this message translates to:
  /// **'Colour the blue sky in the gaps, right up to the edge of the leaves.'**
  String get ideasTropicalNoonStep5;

  /// No description provided for @ideasGreenhouseLightTitle.
  ///
  /// In en, this message translates to:
  /// **'In the greenhouse'**
  String get ideasGreenhouseLightTitle;

  /// No description provided for @ideasGreenhouseLightSummary.
  ///
  /// In en, this message translates to:
  /// **'Plants behind glass in damp green light, with pale grey panes.'**
  String get ideasGreenhouseLightSummary;

  /// No description provided for @ideasGreenhouseLightPractice.
  ///
  /// In en, this message translates to:
  /// **'A pale glaze over a scene, the way glass veils it.'**
  String get ideasGreenhouseLightPractice;

  /// No description provided for @ideasGreenhouseLightSubject.
  ///
  /// In en, this message translates to:
  /// **'A glass wall with its bars and pots of plants behind it.'**
  String get ideasGreenhouseLightSubject;

  /// No description provided for @ideasGreenhouseLightTip.
  ///
  /// In en, this message translates to:
  /// **'The green glaze goes on last: it is the damp light of the place, not the colour of the plants.'**
  String get ideasGreenhouseLightTip;

  /// No description provided for @ideasGreenhouseLightStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a glass wall with its bars and pots of plants behind it.'**
  String get ideasGreenhouseLightStep1;

  /// No description provided for @ideasGreenhouseLightStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the plants with the base green, softer the further they are behind the glass.'**
  String get ideasGreenhouseLightStep2;

  /// No description provided for @ideasGreenhouseLightStep3.
  ///
  /// In en, this message translates to:
  /// **'Keep the dark green for the nearest leaves only.'**
  String get ideasGreenhouseLightStep3;

  /// No description provided for @ideasGreenhouseLightStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the light grey for the bars and for the reflection streaks on the panes.'**
  String get ideasGreenhouseLightStep4;

  /// No description provided for @ideasGreenhouseLightStep5.
  ///
  /// In en, this message translates to:
  /// **'Once dry, glaze the whole glass area with the pale green: the light inside is green.'**
  String get ideasGreenhouseLightStep5;

  /// No description provided for @ideasDustyAtticTitle.
  ///
  /// In en, this message translates to:
  /// **'Dusty attic'**
  String get ideasDustyAtticTitle;

  /// No description provided for @ideasDustyAtticSummary.
  ///
  /// In en, this message translates to:
  /// **'Warm greys, an old trunk and one shaft of light with dust in it.'**
  String get ideasDustyAtticSummary;

  /// No description provided for @ideasDustyAtticPractice.
  ///
  /// In en, this message translates to:
  /// **'A grey room with one bright place left untouched.'**
  String get ideasDustyAtticPractice;

  /// No description provided for @ideasDustyAtticSubject.
  ///
  /// In en, this message translates to:
  /// **'A small high window, the shaft of light it throws and an old trunk in it.'**
  String get ideasDustyAtticSubject;

  /// No description provided for @ideasDustyAtticTip.
  ///
  /// In en, this message translates to:
  /// **'Keep the shaft of light the brightest thing in the picture: it is the only white paper left.'**
  String get ideasDustyAtticTip;

  /// No description provided for @ideasDustyAtticStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a small window high up, the shaft of light it throws and a trunk inside it.'**
  String get ideasDustyAtticStep1;

  /// No description provided for @ideasDustyAtticStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover everything with the lightest warm grey, except the inside of the shaft.'**
  String get ideasDustyAtticStep2;

  /// No description provided for @ideasDustyAtticStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the mid warm grey on the walls away from the window and on the sides of the trunk.'**
  String get ideasDustyAtticStep3;

  /// No description provided for @ideasDustyAtticStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest grey in the corners and under the trunk.'**
  String get ideasDustyAtticStep4;

  /// No description provided for @ideasDustyAtticStep5.
  ///
  /// In en, this message translates to:
  /// **'Add a faint pale yellow glaze inside the shaft of light.'**
  String get ideasDustyAtticStep5;

  /// No description provided for @ideasDustyAtticStep6.
  ///
  /// In en, this message translates to:
  /// **'Once dry, add a few white gel specks of dust in the shaft.'**
  String get ideasDustyAtticStep6;

  /// No description provided for @ideasColourGreyBlackTitle.
  ///
  /// In en, this message translates to:
  /// **'Colour, grey and black'**
  String get ideasColourGreyBlackTitle;

  /// No description provided for @ideasColourGreyBlackSummary.
  ///
  /// In en, this message translates to:
  /// **'Only three markers: one colour, one grey and one very dark.'**
  String get ideasColourGreyBlackSummary;

  /// No description provided for @ideasColourGreyBlackPractice.
  ///
  /// In en, this message translates to:
  /// **'Placing the light with the fewest markers you have.'**
  String get ideasColourGreyBlackPractice;

  /// No description provided for @ideasColourGreyBlackSubject.
  ///
  /// In en, this message translates to:
  /// **'A bike, a boot or a teapot with one clear colour.'**
  String get ideasColourGreyBlackSubject;

  /// No description provided for @ideasColourGreyBlackTip.
  ///
  /// In en, this message translates to:
  /// **'With three nibs there is nothing to decide but where the light goes. Plan the light first.'**
  String get ideasColourGreyBlackTip;

  /// No description provided for @ideasColourGreyBlackStep1.
  ///
  /// In en, this message translates to:
  /// **'Pick a subject with one main colour and mark in pencil where the light comes from.'**
  String get ideasColourGreyBlackStep1;

  /// No description provided for @ideasColourGreyBlackStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the whole subject with the colour, and give it two layers where it turns away from the light.'**
  String get ideasColourGreyBlackStep2;

  /// No description provided for @ideasColourGreyBlackStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the grey for the cast shadow and for anything that is not the subject.'**
  String get ideasColourGreyBlackStep3;

  /// No description provided for @ideasColourGreyBlackStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep the dark marker for the contact lines and the deepest corners.'**
  String get ideasColourGreyBlackStep4;

  /// No description provided for @ideasColourGreyBlackStep5.
  ///
  /// In en, this message translates to:
  /// **'Step back: the drawing reads with just three values, and the grey holds them together.'**
  String get ideasColourGreyBlackStep5;

  /// No description provided for @ideasAnalogousTrioTitle.
  ///
  /// In en, this message translates to:
  /// **'Three neighbours'**
  String get ideasAnalogousTrioTitle;

  /// No description provided for @ideasAnalogousTrioSummary.
  ///
  /// In en, this message translates to:
  /// **'Three colours that sit next to each other on the wheel, and nothing from the other side.'**
  String get ideasAnalogousTrioSummary;

  /// No description provided for @ideasAnalogousTrioPractice.
  ///
  /// In en, this message translates to:
  /// **'Building a scheme out of neighbouring hues.'**
  String get ideasAnalogousTrioPractice;

  /// No description provided for @ideasAnalogousTrioSubject.
  ///
  /// In en, this message translates to:
  /// **'A sunflower, a sea or a field of one colour.'**
  String get ideasAnalogousTrioSubject;

  /// No description provided for @ideasAnalogousTrioTip.
  ///
  /// In en, this message translates to:
  /// **'Neighbouring colours blend while wet without turning grey. Keep them wet and let them mix.'**
  String get ideasAnalogousTrioTip;

  /// No description provided for @ideasAnalogousTrioStep1.
  ///
  /// In en, this message translates to:
  /// **'Choose a subject that is naturally one colour, such as a sunflower or a sea, and draw it.'**
  String get ideasAnalogousTrioStep1;

  /// No description provided for @ideasAnalogousTrioStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover most of the subject with the middle colour of the three.'**
  String get ideasAnalogousTrioStep2;

  /// No description provided for @ideasAnalogousTrioStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the neighbour on the lit side and blend it into the middle colour while it is wet.'**
  String get ideasAnalogousTrioStep3;

  /// No description provided for @ideasAnalogousTrioStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the other neighbour in the shadows, away from the light.'**
  String get ideasAnalogousTrioStep4;

  /// No description provided for @ideasAnalogousTrioStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the dark of the middle colour only in the deepest places, and leave the rest in the three.'**
  String get ideasAnalogousTrioStep5;

  /// No description provided for @ideasTriadTitle.
  ///
  /// In en, this message translates to:
  /// **'A triad'**
  String get ideasTriadTitle;

  /// No description provided for @ideasTriadSummary.
  ///
  /// In en, this message translates to:
  /// **'Three colours equally spaced on the wheel; one leads and two support.'**
  String get ideasTriadSummary;

  /// No description provided for @ideasTriadPractice.
  ///
  /// In en, this message translates to:
  /// **'Using a three-colour scheme with one colour in charge.'**
  String get ideasTriadPractice;

  /// No description provided for @ideasTriadSubject.
  ///
  /// In en, this message translates to:
  /// **'A poster, a book cover or a big flower with small details.'**
  String get ideasTriadSubject;

  /// No description provided for @ideasTriadTip.
  ///
  /// In en, this message translates to:
  /// **'Keep the three colours apart on the paper. One grey over all of them ties the scheme together.'**
  String get ideasTriadTip;

  /// No description provided for @ideasTriadStep1.
  ///
  /// In en, this message translates to:
  /// **'Decide which of the three colours leads: it gets most of the paper.'**
  String get ideasTriadStep1;

  /// No description provided for @ideasTriadStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the main areas with the leading colour.'**
  String get ideasTriadStep2;

  /// No description provided for @ideasTriadStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the second colour on about a quarter of the drawing, and never let it touch the first while it is wet.'**
  String get ideasTriadStep3;

  /// No description provided for @ideasTriadStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the third colour in a few small spots only.'**
  String get ideasTriadStep4;

  /// No description provided for @ideasTriadStep5.
  ///
  /// In en, this message translates to:
  /// **'Shade all three colours with the same grey so they belong together.'**
  String get ideasTriadStep5;

  /// No description provided for @ideasSplitComplementTitle.
  ///
  /// In en, this message translates to:
  /// **'Split Complementary'**
  String get ideasSplitComplementTitle;

  /// No description provided for @ideasSplitComplementSummary.
  ///
  /// In en, this message translates to:
  /// **'One colour family and the two colours on either side of its opposite.'**
  String get ideasSplitComplementSummary;

  /// No description provided for @ideasSplitComplementPractice.
  ///
  /// In en, this message translates to:
  /// **'Balancing a main family with two colours close to its opposite.'**
  String get ideasSplitComplementPractice;

  /// No description provided for @ideasSplitComplementSubject.
  ///
  /// In en, this message translates to:
  /// **'A vase with two flowers, or a cup with two small objects beside it.'**
  String get ideasSplitComplementSubject;

  /// No description provided for @ideasSplitComplementTip.
  ///
  /// In en, this message translates to:
  /// **'A near-opposite reads as a clash or a harmony depending on how much of it you use.'**
  String get ideasSplitComplementTip;

  /// No description provided for @ideasSplitComplementStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw a subject with one big area and two small ones, such as a vase with two flowers.'**
  String get ideasSplitComplementStep1;

  /// No description provided for @ideasSplitComplementStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the big area with the light tone of the main family.'**
  String get ideasSplitComplementStep2;

  /// No description provided for @ideasSplitComplementStep3.
  ///
  /// In en, this message translates to:
  /// **'Add its shadow where the light does not reach.'**
  String get ideasSplitComplementStep3;

  /// No description provided for @ideasSplitComplementStep4.
  ///
  /// In en, this message translates to:
  /// **'Use one of the two opposites on the first small area.'**
  String get ideasSplitComplementStep4;

  /// No description provided for @ideasSplitComplementStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the other opposite on the second small area and keep the two apart.'**
  String get ideasSplitComplementStep5;

  /// No description provided for @ideasTwoGrayTemperaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Warm greys, cool greys'**
  String get ideasTwoGrayTemperaturesTitle;

  /// No description provided for @ideasTwoGrayTemperaturesSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour the same stone twice, once with warm greys and once with cool ones.'**
  String get ideasTwoGrayTemperaturesSummary;

  /// No description provided for @ideasTwoGrayTemperaturesPractice.
  ///
  /// In en, this message translates to:
  /// **'Telling warm grey from cool grey by eye.'**
  String get ideasTwoGrayTemperaturesPractice;

  /// No description provided for @ideasTwoGrayTemperaturesSubject.
  ///
  /// In en, this message translates to:
  /// **'The same pebble or a folded cloth, drawn twice side by side.'**
  String get ideasTwoGrayTemperaturesSubject;

  /// No description provided for @ideasTwoGrayTemperaturesTip.
  ///
  /// In en, this message translates to:
  /// **'Most brands sell warm, cool and neutral greys as separate families. Pick one family for each half.'**
  String get ideasTwoGrayTemperaturesTip;

  /// No description provided for @ideasTwoGrayTemperaturesStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the same pebble twice, side by side, and mark the light on each.'**
  String get ideasTwoGrayTemperaturesStep1;

  /// No description provided for @ideasTwoGrayTemperaturesStep2.
  ///
  /// In en, this message translates to:
  /// **'First pebble: the light warm grey all over.'**
  String get ideasTwoGrayTemperaturesStep2;

  /// No description provided for @ideasTwoGrayTemperaturesStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the darker warm grey on the shadow side and darken the contact with the ground.'**
  String get ideasTwoGrayTemperaturesStep3;

  /// No description provided for @ideasTwoGrayTemperaturesStep4.
  ///
  /// In en, this message translates to:
  /// **'Second pebble: the light cool grey all over.'**
  String get ideasTwoGrayTemperaturesStep4;

  /// No description provided for @ideasTwoGrayTemperaturesStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the darker cool grey the same way, then compare: one pebble sits in the sun, the other in the shade.'**
  String get ideasTwoGrayTemperaturesStep5;

  /// No description provided for @ideasGrayPlusAccentTitle.
  ///
  /// In en, this message translates to:
  /// **'Grey with one accent'**
  String get ideasGrayPlusAccentTitle;

  /// No description provided for @ideasGrayPlusAccentSummary.
  ///
  /// In en, this message translates to:
  /// **'Everything in grey except one small thing in colour.'**
  String get ideasGrayPlusAccentSummary;

  /// No description provided for @ideasGrayPlusAccentPractice.
  ///
  /// In en, this message translates to:
  /// **'Making one colour carry the whole drawing.'**
  String get ideasGrayPlusAccentPractice;

  /// No description provided for @ideasGrayPlusAccentSubject.
  ///
  /// In en, this message translates to:
  /// **'A street with a red door, or a yellow umbrella in a grey town.'**
  String get ideasGrayPlusAccentSubject;

  /// No description provided for @ideasGrayPlusAccentTip.
  ///
  /// In en, this message translates to:
  /// **'The accent wants to be as strong as it can be: two layers of the same marker.'**
  String get ideasGrayPlusAccentTip;

  /// No description provided for @ideasGrayPlusAccentStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw a scene with one object you want the eye to land on, such as a red door in a street.'**
  String get ideasGrayPlusAccentStep1;

  /// No description provided for @ideasGrayPlusAccentStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover everything but that object with the light grey.'**
  String get ideasGrayPlusAccentStep2;

  /// No description provided for @ideasGrayPlusAccentStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the mid grey in the shadows, as if the scene were a photograph.'**
  String get ideasGrayPlusAccentStep3;

  /// No description provided for @ideasGrayPlusAccentStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest grey for the windows, under the eaves and the contact lines.'**
  String get ideasGrayPlusAccentStep4;

  /// No description provided for @ideasGrayPlusAccentStep5.
  ///
  /// In en, this message translates to:
  /// **'Colour the object alone, with two layers so the accent is as strong as it can be.'**
  String get ideasGrayPlusAccentStep5;

  /// No description provided for @ideasEarthTonesTitle.
  ///
  /// In en, this message translates to:
  /// **'Earth tones'**
  String get ideasEarthTonesTitle;

  /// No description provided for @ideasEarthTonesSummary.
  ///
  /// In en, this message translates to:
  /// **'Browns, ochres and an olive green, nothing bright.'**
  String get ideasEarthTonesSummary;

  /// No description provided for @ideasEarthTonesPractice.
  ///
  /// In en, this message translates to:
  /// **'Layering low-chroma colours without them going dull.'**
  String get ideasEarthTonesPractice;

  /// No description provided for @ideasEarthTonesSubject.
  ///
  /// In en, this message translates to:
  /// **'Bread, a basket or a ploughed field.'**
  String get ideasEarthTonesSubject;

  /// No description provided for @ideasEarthTonesTip.
  ///
  /// In en, this message translates to:
  /// **'Low-chroma colours layer well because the paper keeps lighting them from underneath.'**
  String get ideasEarthTonesTip;

  /// No description provided for @ideasEarthTonesStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw something that came from the land, such as bread, a basket or a ploughed field.'**
  String get ideasEarthTonesStep1;

  /// No description provided for @ideasEarthTonesStep2.
  ///
  /// In en, this message translates to:
  /// **'Lay the pale ochre over everything as the first layer.'**
  String get ideasEarthTonesStep2;

  /// No description provided for @ideasEarthTonesStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the brown where the form turns away from the light.'**
  String get ideasEarthTonesStep3;

  /// No description provided for @ideasEarthTonesStep4.
  ///
  /// In en, this message translates to:
  /// **'Put the olive green on anything green, and let the ochre under it mute it.'**
  String get ideasEarthTonesStep4;

  /// No description provided for @ideasEarthTonesStep5.
  ///
  /// In en, this message translates to:
  /// **'Keep the darkest brown for the deepest places only.'**
  String get ideasEarthTonesStep5;

  /// No description provided for @ideasJewelTonesTitle.
  ///
  /// In en, this message translates to:
  /// **'Jewel tones'**
  String get ideasJewelTonesTitle;

  /// No description provided for @ideasJewelTonesSummary.
  ///
  /// In en, this message translates to:
  /// **'Deep, saturated colours with a gold accent, like a velvet box.'**
  String get ideasJewelTonesSummary;

  /// No description provided for @ideasJewelTonesPractice.
  ///
  /// In en, this message translates to:
  /// **'Painting dark saturated colours that keep their shine.'**
  String get ideasJewelTonesPractice;

  /// No description provided for @ideasJewelTonesSubject.
  ///
  /// In en, this message translates to:
  /// **'A few gems or bottles with a highlight planned on each.'**
  String get ideasJewelTonesSubject;

  /// No description provided for @ideasJewelTonesTip.
  ///
  /// In en, this message translates to:
  /// **'Dark saturated ink stays glossy on marker paper. A white gel dot on top gives the glass look.'**
  String get ideasJewelTonesTip;

  /// No description provided for @ideasJewelTonesStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw a few simple gems or bottles and plan a highlight on each one.'**
  String get ideasJewelTonesStep1;

  /// No description provided for @ideasJewelTonesStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the biggest shape with the deep blue-green, in two layers.'**
  String get ideasJewelTonesStep2;

  /// No description provided for @ideasJewelTonesStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the deep violet on the next shape.'**
  String get ideasJewelTonesStep3;

  /// No description provided for @ideasJewelTonesStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the deep red on the smallest one.'**
  String get ideasJewelTonesStep4;

  /// No description provided for @ideasJewelTonesStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the gold yellow to the settings or the caps, then a hard white gel dot on every highlight.'**
  String get ideasJewelTonesStep5;

  /// No description provided for @ideasLowKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Dark markers only'**
  String get ideasLowKeyTitle;

  /// No description provided for @ideasLowKeySummary.
  ///
  /// In en, this message translates to:
  /// **'Draw with markers darker than mid grey and let a few bits of paper carry all the light.'**
  String get ideasLowKeySummary;

  /// No description provided for @ideasLowKeyPractice.
  ///
  /// In en, this message translates to:
  /// **'Painting a dark picture with light left out on purpose.'**
  String get ideasLowKeyPractice;

  /// No description provided for @ideasLowKeySubject.
  ///
  /// In en, this message translates to:
  /// **'A cat with lit eyes, a lamp in a dark room or a profile.'**
  String get ideasLowKeySubject;

  /// No description provided for @ideasLowKeyTip.
  ///
  /// In en, this message translates to:
  /// **'Dark alcohol ink covers evenly in one pass, so the white shapes you leave stay clean.'**
  String get ideasLowKeyTip;

  /// No description provided for @ideasLowKeyStep1.
  ///
  /// In en, this message translates to:
  /// **'Plan the drawing as a few shapes of paper left white on a dark field: a cat\'s eyes, a lamp, a profile.'**
  String get ideasLowKeyStep1;

  /// No description provided for @ideasLowKeyStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover everything except the white shapes with the least dark marker.'**
  String get ideasLowKeyStep2;

  /// No description provided for @ideasLowKeyStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the middle marker on the bigger shadows.'**
  String get ideasLowKeyStep3;

  /// No description provided for @ideasLowKeyStep4.
  ///
  /// In en, this message translates to:
  /// **'Put the darkest marker on the edges of the light shapes, so they glow by contrast.'**
  String get ideasLowKeyStep4;

  /// No description provided for @ideasLowKeyStep5.
  ///
  /// In en, this message translates to:
  /// **'Add white gel on one or two points only, no more.'**
  String get ideasLowKeyStep5;

  /// No description provided for @ideasComplementGradientTitle.
  ///
  /// In en, this message translates to:
  /// **'Through the middle'**
  String get ideasComplementGradientTitle;

  /// No description provided for @ideasComplementGradientSummary.
  ///
  /// In en, this message translates to:
  /// **'Blend two opposite colours into each other and see the grey they make where they meet.'**
  String get ideasComplementGradientSummary;

  /// No description provided for @ideasComplementGradientPractice.
  ///
  /// In en, this message translates to:
  /// **'Mixing two colours on the paper and reading the result.'**
  String get ideasComplementGradientPractice;

  /// No description provided for @ideasComplementGradientSubject.
  ///
  /// In en, this message translates to:
  /// **'A long strip of paper with the two colours meeting in the middle.'**
  String get ideasComplementGradientSubject;

  /// No description provided for @ideasComplementGradientTip.
  ///
  /// In en, this message translates to:
  /// **'Wet opposites mix on the paper at once. Keep both damp and let them meet in the middle.'**
  String get ideasComplementGradientTip;

  /// No description provided for @ideasComplementGradientStep1.
  ///
  /// In en, this message translates to:
  /// **'Tape a long strip of paper down.'**
  String get ideasComplementGradientStep1;

  /// No description provided for @ideasComplementGradientStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the left third and fade the colour out towards the middle.'**
  String get ideasComplementGradientStep2;

  /// No description provided for @ideasComplementGradientStep3.
  ///
  /// In en, this message translates to:
  /// **'Fill the right third and fade it into the middle while the first colour is still damp.'**
  String get ideasComplementGradientStep3;

  /// No description provided for @ideasComplementGradientStep4.
  ///
  /// In en, this message translates to:
  /// **'Compare the muddy middle with a stroke of your grey next to it.'**
  String get ideasComplementGradientStep4;

  /// No description provided for @ideasComplementGradientStep5.
  ///
  /// In en, this message translates to:
  /// **'Redo the strip with the grey laid in the middle first and the two colours blended into it: a cleaner way through.'**
  String get ideasComplementGradientStep5;

  /// No description provided for @ideasWarmLightCoolShadowTitle.
  ///
  /// In en, this message translates to:
  /// **'Warm light, cool shadow'**
  String get ideasWarmLightCoolShadowTitle;

  /// No description provided for @ideasWarmLightCoolShadowSummary.
  ///
  /// In en, this message translates to:
  /// **'One object, lit side in warm colours and shadow side in cool ones.'**
  String get ideasWarmLightCoolShadowSummary;

  /// No description provided for @ideasWarmLightCoolShadowPractice.
  ///
  /// In en, this message translates to:
  /// **'Glazing warm and cool over one base colour.'**
  String get ideasWarmLightCoolShadowPractice;

  /// No description provided for @ideasWarmLightCoolShadowSubject.
  ///
  /// In en, this message translates to:
  /// **'A round fruit, an egg or a ball.'**
  String get ideasWarmLightCoolShadowSubject;

  /// No description provided for @ideasWarmLightCoolShadowTip.
  ///
  /// In en, this message translates to:
  /// **'Leave a thin band of the plain base between the warm and the cool: it keeps the form turning.'**
  String get ideasWarmLightCoolShadowTip;

  /// No description provided for @ideasWarmLightCoolShadowStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw a round object and mark where the light comes from.'**
  String get ideasWarmLightCoolShadowStep1;

  /// No description provided for @ideasWarmLightCoolShadowStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the whole object with its own colour.'**
  String get ideasWarmLightCoolShadowStep2;

  /// No description provided for @ideasWarmLightCoolShadowStep3.
  ///
  /// In en, this message translates to:
  /// **'Glaze the warm colour over the lit half and blend it into the base while it is wet.'**
  String get ideasWarmLightCoolShadowStep3;

  /// No description provided for @ideasWarmLightCoolShadowStep4.
  ///
  /// In en, this message translates to:
  /// **'Glaze the cool colour over the shadow half, and leave a thin band of plain base between the two.'**
  String get ideasWarmLightCoolShadowStep4;

  /// No description provided for @ideasWarmLightCoolShadowStep5.
  ///
  /// In en, this message translates to:
  /// **'Keep the darkest marker for the contact with the ground only.'**
  String get ideasWarmLightCoolShadowStep5;

  /// No description provided for @ideasVividAndMutedTitle.
  ///
  /// In en, this message translates to:
  /// **'Vivid and muted'**
  String get ideasVividAndMutedTitle;

  /// No description provided for @ideasVividAndMutedSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour the same flower with a bright pair and then a muted pair of the same hue.'**
  String get ideasVividAndMutedSummary;

  /// No description provided for @ideasVividAndMutedPractice.
  ///
  /// In en, this message translates to:
  /// **'Telling a vivid colour from its dusty version.'**
  String get ideasVividAndMutedPractice;

  /// No description provided for @ideasVividAndMutedSubject.
  ///
  /// In en, this message translates to:
  /// **'The same flower drawn twice, side by side.'**
  String get ideasVividAndMutedSubject;

  /// No description provided for @ideasVividAndMutedTip.
  ///
  /// In en, this message translates to:
  /// **'Most ranges carry a vivid and a dusty version of each hue. Choosing between them is the whole exercise.'**
  String get ideasVividAndMutedTip;

  /// No description provided for @ideasVividAndMutedStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the same flower twice, side by side.'**
  String get ideasVividAndMutedStep1;

  /// No description provided for @ideasVividAndMutedStep2.
  ///
  /// In en, this message translates to:
  /// **'First flower: the vivid light tone.'**
  String get ideasVividAndMutedStep2;

  /// No description provided for @ideasVividAndMutedStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the vivid shadow of the same hue.'**
  String get ideasVividAndMutedStep3;

  /// No description provided for @ideasVividAndMutedStep4.
  ///
  /// In en, this message translates to:
  /// **'Second flower: the muted light tone of the same hue.'**
  String get ideasVividAndMutedStep4;

  /// No description provided for @ideasVividAndMutedStep5.
  ///
  /// In en, this message translates to:
  /// **'Add its muted shadow, then decide which flower would go in the foreground of a drawing and which in the background.'**
  String get ideasVividAndMutedStep5;

  /// No description provided for @ideasOneMarkerBlenderTitle.
  ///
  /// In en, this message translates to:
  /// **'One marker and the blender'**
  String get ideasOneMarkerBlenderTitle;

  /// No description provided for @ideasOneMarkerBlenderSummary.
  ///
  /// In en, this message translates to:
  /// **'Four values out of one dark marker by diluting it with the colourless blender.'**
  String get ideasOneMarkerBlenderSummary;

  /// No description provided for @ideasOneMarkerBlenderPractice.
  ///
  /// In en, this message translates to:
  /// **'Diluting ink to get lighter values without another marker.'**
  String get ideasOneMarkerBlenderPractice;

  /// No description provided for @ideasOneMarkerBlenderSubject.
  ///
  /// In en, this message translates to:
  /// **'Four small squares of paper taped side by side.'**
  String get ideasOneMarkerBlenderSubject;

  /// No description provided for @ideasOneMarkerBlenderTip.
  ///
  /// In en, this message translates to:
  /// **'The blender is pure solvent: it turns a single dark marker into its own light family.'**
  String get ideasOneMarkerBlenderTip;

  /// No description provided for @ideasOneMarkerBlenderStep1.
  ///
  /// In en, this message translates to:
  /// **'Tape four small squares of paper side by side.'**
  String get ideasOneMarkerBlenderStep1;

  /// No description provided for @ideasOneMarkerBlenderStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the first square with the marker at full strength.'**
  String get ideasOneMarkerBlenderStep2;

  /// No description provided for @ideasOneMarkerBlenderStep3.
  ///
  /// In en, this message translates to:
  /// **'Second square: one stroke of marker, then the blender over it while it is wet.'**
  String get ideasOneMarkerBlenderStep3;

  /// No description provided for @ideasOneMarkerBlenderStep4.
  ///
  /// In en, this message translates to:
  /// **'Third square: blender first, then marker into the wet blender. Fourth: touch the marker to the blender nib and paint with the blender only.'**
  String get ideasOneMarkerBlenderStep4;

  /// No description provided for @ideasOneMarkerBlenderStep5.
  ///
  /// In en, this message translates to:
  /// **'Line them up: a four-step ladder out of a single marker.'**
  String get ideasOneMarkerBlenderStep5;

  /// No description provided for @ideasColourWheelTitle.
  ///
  /// In en, this message translates to:
  /// **'Your colour wheel'**
  String get ideasColourWheelTitle;

  /// No description provided for @ideasColourWheelSummary.
  ///
  /// In en, this message translates to:
  /// **'Lay out twelve of your markers as a wheel and find the gaps in your collection.'**
  String get ideasColourWheelSummary;

  /// No description provided for @ideasColourWheelPractice.
  ///
  /// In en, this message translates to:
  /// **'Reading a colour wheel with the markers you own.'**
  String get ideasColourWheelPractice;

  /// No description provided for @ideasColourWheelSubject.
  ///
  /// In en, this message translates to:
  /// **'A circle about ten centimetres across, divided into twelve wedges.'**
  String get ideasColourWheelSubject;

  /// No description provided for @ideasColourWheelTip.
  ///
  /// In en, this message translates to:
  /// **'A marker wheel is a shopping list and a mixing guide on one page.'**
  String get ideasColourWheelTip;

  /// No description provided for @ideasColourWheelStep1.
  ///
  /// In en, this message translates to:
  /// **'Trace a circle round a cup and divide it into twelve wedges.'**
  String get ideasColourWheelStep1;

  /// No description provided for @ideasColourWheelStep2.
  ///
  /// In en, this message translates to:
  /// **'Pick the marker closest to pure yellow, then to red and then to blue, and fill their wedges, four wedges apart.'**
  String get ideasColourWheelStep2;

  /// No description provided for @ideasColourWheelStep3.
  ///
  /// In en, this message translates to:
  /// **'Fill the wedges between with the closest markers you own: orange, green, violet, then the six in-betweens.'**
  String get ideasColourWheelStep3;

  /// No description provided for @ideasColourWheelStep4.
  ///
  /// In en, this message translates to:
  /// **'Write each code under its wedge. An empty or doubtful wedge is a marker you might want next.'**
  String get ideasColourWheelStep4;

  /// No description provided for @ideasDeepSkinTitle.
  ///
  /// In en, this message translates to:
  /// **'Deep skin tones'**
  String get ideasDeepSkinTitle;

  /// No description provided for @ideasDeepSkinSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour a face in deep skin tones, with a warm light and a reddish blush.'**
  String get ideasDeepSkinSummary;

  /// No description provided for @ideasDeepSkinPractice.
  ///
  /// In en, this message translates to:
  /// **'Shading deep skin with a long range of one hue.'**
  String get ideasDeepSkinPractice;

  /// No description provided for @ideasDeepSkinSubject.
  ///
  /// In en, this message translates to:
  /// **'A face in three-quarter view, lit from the front.'**
  String get ideasDeepSkinSubject;

  /// No description provided for @ideasDeepSkinTip.
  ///
  /// In en, this message translates to:
  /// **'Deep skin needs a long lightness range in one hue, which marker families are built for.'**
  String get ideasDeepSkinTip;

  /// No description provided for @ideasDeepSkinStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a face and mark the forehead, the nose and the cheekbones as the lit planes.'**
  String get ideasDeepSkinStep1;

  /// No description provided for @ideasDeepSkinStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the whole face with the lightest brown.'**
  String get ideasDeepSkinStep2;

  /// No description provided for @ideasDeepSkinStep3.
  ///
  /// In en, this message translates to:
  /// **'While the first layer is damp, add the red-brown on the cheeks and the lips.'**
  String get ideasDeepSkinStep3;

  /// No description provided for @ideasDeepSkinStep4.
  ///
  /// In en, this message translates to:
  /// **'Add the base brown everywhere except on the lit planes.'**
  String get ideasDeepSkinStep4;

  /// No description provided for @ideasDeepSkinStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest marker under the brows, the nose, the lower lip and the jaw, and leave the lit planes with only the first layer.'**
  String get ideasDeepSkinStep5;

  /// No description provided for @ideasBlackObjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Black without black'**
  String get ideasBlackObjectTitle;

  /// No description provided for @ideasBlackObjectSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour a black cat or boot with dark blues and violets, saving the black marker for last.'**
  String get ideasBlackObjectSummary;

  /// No description provided for @ideasBlackObjectPractice.
  ///
  /// In en, this message translates to:
  /// **'Building a dark object out of dark colours instead of black.'**
  String get ideasBlackObjectPractice;

  /// No description provided for @ideasBlackObjectSubject.
  ///
  /// In en, this message translates to:
  /// **'A black cat, a boot or a shiny kettle.'**
  String get ideasBlackObjectSubject;

  /// No description provided for @ideasBlackObjectTip.
  ///
  /// In en, this message translates to:
  /// **'A flat black marker kills the form. Layered dark colours keep it.'**
  String get ideasBlackObjectTip;

  /// No description provided for @ideasBlackObjectStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the object and the shape of its reflections: black things mirror the sky and the room.'**
  String get ideasBlackObjectStep1;

  /// No description provided for @ideasBlackObjectStep2.
  ///
  /// In en, this message translates to:
  /// **'Use the pale cool grey-blue on the reflections and the top planes.'**
  String get ideasBlackObjectStep2;

  /// No description provided for @ideasBlackObjectStep3.
  ///
  /// In en, this message translates to:
  /// **'Cover most of the object with the dark blue.'**
  String get ideasBlackObjectStep3;

  /// No description provided for @ideasBlackObjectStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the dark violet on the underside.'**
  String get ideasBlackObjectStep4;

  /// No description provided for @ideasBlackObjectStep5.
  ///
  /// In en, this message translates to:
  /// **'Keep the darkest marker for the deepest creases, and add a white gel glint if the surface is shiny.'**
  String get ideasBlackObjectStep5;

  /// No description provided for @ideasWhiteObjectTitle.
  ///
  /// In en, this message translates to:
  /// **'White without white'**
  String get ideasWhiteObjectTitle;

  /// No description provided for @ideasWhiteObjectSummary.
  ///
  /// In en, this message translates to:
  /// **'A white cup or egg with pale greys, one tinted shadow and plenty of untouched paper.'**
  String get ideasWhiteObjectSummary;

  /// No description provided for @ideasWhiteObjectPractice.
  ///
  /// In en, this message translates to:
  /// **'Painting a white object without painting over the paper.'**
  String get ideasWhiteObjectPractice;

  /// No description provided for @ideasWhiteObjectSubject.
  ///
  /// In en, this message translates to:
  /// **'A white cup, an egg or a folded napkin.'**
  String get ideasWhiteObjectSubject;

  /// No description provided for @ideasWhiteObjectTip.
  ///
  /// In en, this message translates to:
  /// **'A white object is mostly paper. Markers reward leaving it alone.'**
  String get ideasWhiteObjectTip;

  /// No description provided for @ideasWhiteObjectStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the object and mark the lit side: that side stays paper.'**
  String get ideasWhiteObjectStep1;

  /// No description provided for @ideasWhiteObjectStep2.
  ///
  /// In en, this message translates to:
  /// **'Use the very pale tinted marker on the shadow side only.'**
  String get ideasWhiteObjectStep2;

  /// No description provided for @ideasWhiteObjectStep3.
  ///
  /// In en, this message translates to:
  /// **'Put the light grey inside that, towards the darkest part.'**
  String get ideasWhiteObjectStep3;

  /// No description provided for @ideasWhiteObjectStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the slightly darker cool grey only along the edge furthest from the light and where the object meets the table.'**
  String get ideasWhiteObjectStep4;

  /// No description provided for @ideasWhiteObjectStep5.
  ///
  /// In en, this message translates to:
  /// **'Add a hint of the colour of the table reflected into the underside of the object.'**
  String get ideasWhiteObjectStep5;

  /// No description provided for @ideasFeatheredEdgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Feathered edge'**
  String get ideasFeatheredEdgeTitle;

  /// No description provided for @ideasFeatheredEdgeSummary.
  ///
  /// In en, this message translates to:
  /// **'Make one side of a shape fade into white paper and keep the other side crisp.'**
  String get ideasFeatheredEdgeSummary;

  /// No description provided for @ideasFeatheredEdgePractice.
  ///
  /// In en, this message translates to:
  /// **'A soft edge next to a hard one: the simplest way to give a shape light.'**
  String get ideasFeatheredEdgePractice;

  /// No description provided for @ideasFeatheredEdgeSubject.
  ///
  /// In en, this message translates to:
  /// **'A leaf, a petal or a fold of cloth.'**
  String get ideasFeatheredEdgeSubject;

  /// No description provided for @ideasFeatheredEdgeTip.
  ///
  /// In en, this message translates to:
  /// **'Lift the nib as you go: the ink runs out of the stroke on its own.'**
  String get ideasFeatheredEdgeTip;

  /// No description provided for @ideasFeatheredEdgeStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a leaf and decide which edge is in the light.'**
  String get ideasFeatheredEdgeStep1;

  /// No description provided for @ideasFeatheredEdgeStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the dark edge with the base in short strokes that all point towards the light side.'**
  String get ideasFeatheredEdgeStep2;

  /// No description provided for @ideasFeatheredEdgeStep3.
  ///
  /// In en, this message translates to:
  /// **'Pull the light marker from the middle out over the ends of those strokes, lifting the nib as you go so each stroke dies out.'**
  String get ideasFeatheredEdgeStep3;

  /// No description provided for @ideasFeatheredEdgeStep4.
  ///
  /// In en, this message translates to:
  /// **'Go over the join again, always moving from colour into white.'**
  String get ideasFeatheredEdgeStep4;

  /// No description provided for @ideasFeatheredEdgeStep5.
  ///
  /// In en, this message translates to:
  /// **'Compare the two edges: one soft, one hard. That contrast is what makes the shape read.'**
  String get ideasFeatheredEdgeStep5;

  /// No description provided for @ideasTipToTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Tip to tip'**
  String get ideasTipToTipTitle;

  /// No description provided for @ideasTipToTipSummary.
  ///
  /// In en, this message translates to:
  /// **'Load a dark colour onto a light marker nib and lay a gradient in one pass.'**
  String get ideasTipToTipSummary;

  /// No description provided for @ideasTipToTipPractice.
  ///
  /// In en, this message translates to:
  /// **'Borrowing ink from one marker to another for a quick gradient.'**
  String get ideasTipToTipPractice;

  /// No description provided for @ideasTipToTipSubject.
  ///
  /// In en, this message translates to:
  /// **'A strip of paper the width of two fingers.'**
  String get ideasTipToTipSubject;

  /// No description provided for @ideasTipToTipTip.
  ///
  /// In en, this message translates to:
  /// **'Hold the dark marker still: the light nib only takes ink from the tip.'**
  String get ideasTipToTipTip;

  /// No description provided for @ideasTipToTipStep1.
  ///
  /// In en, this message translates to:
  /// **'Tape a strip about the width of two fingers.'**
  String get ideasTipToTipStep1;

  /// No description provided for @ideasTipToTipStep2.
  ///
  /// In en, this message translates to:
  /// **'Hold the dark marker still and touch the light marker nib to it for a couple of seconds.'**
  String get ideasTipToTipStep2;

  /// No description provided for @ideasTipToTipStep3.
  ///
  /// In en, this message translates to:
  /// **'Start at the bottom of the strip with the loaded nib: the first strokes are dark, then the colour of the marker comes back.'**
  String get ideasTipToTipStep3;

  /// No description provided for @ideasTipToTipStep4.
  ///
  /// In en, this message translates to:
  /// **'Scribble the nib on a scrap until it runs clean again: the light marker is not spoilt.'**
  String get ideasTipToTipStep4;

  /// No description provided for @ideasTipToTipStep5.
  ///
  /// In en, this message translates to:
  /// **'Repeat on a second strip, loading the nib for longer: the dark part reaches further.'**
  String get ideasTipToTipStep5;

  /// No description provided for @ideasBlenderPatternTitle.
  ///
  /// In en, this message translates to:
  /// **'Blender patterns'**
  String get ideasBlenderPatternTitle;

  /// No description provided for @ideasBlenderPatternSummary.
  ///
  /// In en, this message translates to:
  /// **'Lift dots and lines out of a flat colour with the colourless blender.'**
  String get ideasBlenderPatternSummary;

  /// No description provided for @ideasBlenderPatternPractice.
  ///
  /// In en, this message translates to:
  /// **'Moving ink instead of erasing it: dots, lines and patterns.'**
  String get ideasBlenderPatternPractice;

  /// No description provided for @ideasBlenderPatternSubject.
  ///
  /// In en, this message translates to:
  /// **'A square of colour to draw the pattern on.'**
  String get ideasBlenderPatternSubject;

  /// No description provided for @ideasBlenderPatternTip.
  ///
  /// In en, this message translates to:
  /// **'Wait between touches: two marks too close run into one.'**
  String get ideasBlenderPatternTip;

  /// No description provided for @ideasBlenderPatternStep1.
  ///
  /// In en, this message translates to:
  /// **'Fill a square with the base and let it dry fully.'**
  String get ideasBlenderPatternStep1;

  /// No description provided for @ideasBlenderPatternStep2.
  ///
  /// In en, this message translates to:
  /// **'Press the fine point of the blender into the colour and hold for a second: a pale dot opens with a darker rim.'**
  String get ideasBlenderPatternStep2;

  /// No description provided for @ideasBlenderPatternStep3.
  ///
  /// In en, this message translates to:
  /// **'Draw a line with the broad nib of the blender: the pushed ink gathers at the edges.'**
  String get ideasBlenderPatternStep3;

  /// No description provided for @ideasBlenderPatternStep4.
  ///
  /// In en, this message translates to:
  /// **'Make a pattern: polka dots, stripes or a row of fish scales.'**
  String get ideasBlenderPatternStep4;

  /// No description provided for @ideasBlenderPatternStep5.
  ///
  /// In en, this message translates to:
  /// **'Wait between the touches or the dots run together.'**
  String get ideasBlenderPatternStep5;

  /// No description provided for @ideasOneMarkerLayersTitle.
  ///
  /// In en, this message translates to:
  /// **'One marker, three layers'**
  String get ideasOneMarkerLayersTitle;

  /// No description provided for @ideasOneMarkerLayersSummary.
  ///
  /// In en, this message translates to:
  /// **'Shade a cube with a single marker by layering one, two and three passes.'**
  String get ideasOneMarkerLayersSummary;

  /// No description provided for @ideasOneMarkerLayersPractice.
  ///
  /// In en, this message translates to:
  /// **'How much range one marker has when the layers dry one on top of the other.'**
  String get ideasOneMarkerLayersPractice;

  /// No description provided for @ideasOneMarkerLayersSubject.
  ///
  /// In en, this message translates to:
  /// **'A cube with the light coming from one top corner.'**
  String get ideasOneMarkerLayersSubject;

  /// No description provided for @ideasOneMarkerLayersTip.
  ///
  /// In en, this message translates to:
  /// **'Let every layer dry: a wet second pass moves the ink instead of darkening it.'**
  String get ideasOneMarkerLayersTip;

  /// No description provided for @ideasOneMarkerLayersStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a cube with the light coming from one top corner.'**
  String get ideasOneMarkerLayersStep1;

  /// No description provided for @ideasOneMarkerLayersStep2.
  ///
  /// In en, this message translates to:
  /// **'One pass on every face. Let it dry.'**
  String get ideasOneMarkerLayersStep2;

  /// No description provided for @ideasOneMarkerLayersStep3.
  ///
  /// In en, this message translates to:
  /// **'A second pass on the two faces away from the light.'**
  String get ideasOneMarkerLayersStep3;

  /// No description provided for @ideasOneMarkerLayersStep4.
  ///
  /// In en, this message translates to:
  /// **'A third pass only on the darkest face and along the bottom edges.'**
  String get ideasOneMarkerLayersStep4;

  /// No description provided for @ideasOneMarkerLayersStep5.
  ///
  /// In en, this message translates to:
  /// **'Look at the three values: that is how much range a single marker has.'**
  String get ideasOneMarkerLayersStep5;

  /// No description provided for @ideasStipplePeelTitle.
  ///
  /// In en, this message translates to:
  /// **'Stippled orange peel'**
  String get ideasStipplePeelTitle;

  /// No description provided for @ideasStipplePeelSummary.
  ///
  /// In en, this message translates to:
  /// **'Build the dimpled texture of a citrus peel with dots over a blend.'**
  String get ideasStipplePeelSummary;

  /// No description provided for @ideasStipplePeelPractice.
  ///
  /// In en, this message translates to:
  /// **'Stippling on top of a dry blend, without smearing it.'**
  String get ideasStipplePeelPractice;

  /// No description provided for @ideasStipplePeelSubject.
  ///
  /// In en, this message translates to:
  /// **'An orange with a soft highlight on its upper side.'**
  String get ideasStipplePeelSubject;

  /// No description provided for @ideasStipplePeelTip.
  ///
  /// In en, this message translates to:
  /// **'Use the fine point of the nib: it gives clean specks.'**
  String get ideasStipplePeelTip;

  /// No description provided for @ideasStipplePeelStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil an orange and a soft highlight on its upper side.'**
  String get ideasStipplePeelStep1;

  /// No description provided for @ideasStipplePeelStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the orange, keeping the highlight paler.'**
  String get ideasStipplePeelStep2;

  /// No description provided for @ideasStipplePeelStep3.
  ///
  /// In en, this message translates to:
  /// **'Blend the base into the shadow half while it is wet.'**
  String get ideasStipplePeelStep3;

  /// No description provided for @ideasStipplePeelStep4.
  ///
  /// In en, this message translates to:
  /// **'Once dry, tap the fine point of the shadow marker in loose dots, closer together in the shadow and almost none near the highlight.'**
  String get ideasStipplePeelStep4;

  /// No description provided for @ideasStipplePeelStep5.
  ///
  /// In en, this message translates to:
  /// **'Tap a few light dots inside the shadow dots to break them up.'**
  String get ideasStipplePeelStep5;

  /// No description provided for @ideasClearGlassTitle.
  ///
  /// In en, this message translates to:
  /// **'A clear glass'**
  String get ideasClearGlassTitle;

  /// No description provided for @ideasClearGlassSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour an empty drinking glass with greys and almost nothing else.'**
  String get ideasClearGlassSummary;

  /// No description provided for @ideasClearGlassPractice.
  ///
  /// In en, this message translates to:
  /// **'Grey and white paper: the lightest way to draw glass.'**
  String get ideasClearGlassPractice;

  /// No description provided for @ideasClearGlassSubject.
  ///
  /// In en, this message translates to:
  /// **'A tumbler with the rim, the foot and two vertical highlights.'**
  String get ideasClearGlassSubject;

  /// No description provided for @ideasClearGlassTip.
  ///
  /// In en, this message translates to:
  /// **'Glass is darkest where it is thickest: the rim and the foot.'**
  String get ideasClearGlassTip;

  /// No description provided for @ideasClearGlassStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the glass and mark the rim, the base and two vertical highlights that stay white paper.'**
  String get ideasClearGlassStep1;

  /// No description provided for @ideasClearGlassStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the glass with the lightest grey, leaving the highlights and most of the middle white.'**
  String get ideasClearGlassStep2;

  /// No description provided for @ideasClearGlassStep3.
  ///
  /// In en, this message translates to:
  /// **'Darken the rim, the thick base and the far edge: glass is darkest where it is thickest.'**
  String get ideasClearGlassStep3;

  /// No description provided for @ideasClearGlassStep4.
  ///
  /// In en, this message translates to:
  /// **'Lay a patch of colour behind the glass and let a paler version of it show through the glass, over the light grey.'**
  String get ideasClearGlassStep4;

  /// No description provided for @ideasClearGlassStep5.
  ///
  /// In en, this message translates to:
  /// **'White gel on the rim and the base edge for the sharpest glints.'**
  String get ideasClearGlassStep5;

  /// No description provided for @ideasPolishedMetalTitle.
  ///
  /// In en, this message translates to:
  /// **'Polished metal'**
  String get ideasPolishedMetalTitle;

  /// No description provided for @ideasPolishedMetalSummary.
  ///
  /// In en, this message translates to:
  /// **'Make a spoon look like metal with hard bands of grey and one reflected colour.'**
  String get ideasPolishedMetalSummary;

  /// No description provided for @ideasPolishedMetalPractice.
  ///
  /// In en, this message translates to:
  /// **'Hard-edged bands and a long range of values: how metal reads.'**
  String get ideasPolishedMetalPractice;

  /// No description provided for @ideasPolishedMetalSubject.
  ///
  /// In en, this message translates to:
  /// **'A spoon with the bands of its reflection drawn in.'**
  String get ideasPolishedMetalSubject;

  /// No description provided for @ideasPolishedMetalTip.
  ///
  /// In en, this message translates to:
  /// **'Metal has no soft transitions: keep the edges of the bands crisp.'**
  String get ideasPolishedMetalTip;

  /// No description provided for @ideasPolishedMetalStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the spoon and draw its reflections as bands: a dark one across the bowl, a light one next to it, no soft transitions.'**
  String get ideasPolishedMetalStep1;

  /// No description provided for @ideasPolishedMetalStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the bowl and the handle with the lightest grey.'**
  String get ideasPolishedMetalStep2;

  /// No description provided for @ideasPolishedMetalStep3.
  ///
  /// In en, this message translates to:
  /// **'Lay the dark bands with crisp edges, following the curve of the bowl.'**
  String get ideasPolishedMetalStep3;

  /// No description provided for @ideasPolishedMetalStep4.
  ///
  /// In en, this message translates to:
  /// **'Put the darkest grey right next to the brightest band: metal lives on that contrast.'**
  String get ideasPolishedMetalStep4;

  /// No description provided for @ideasPolishedMetalStep5.
  ///
  /// In en, this message translates to:
  /// **'Let a smudge of the colour of the table reflect in the lower half of the bowl, then white gel on the sharpest glint.'**
  String get ideasPolishedMetalStep5;

  /// No description provided for @ideasCastShadowTitle.
  ///
  /// In en, this message translates to:
  /// **'The shadow on the table'**
  String get ideasCastShadowTitle;

  /// No description provided for @ideasCastShadowSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw a cup and get its cast shadow right: dark at the contact, soft further away.'**
  String get ideasCastShadowSummary;

  /// No description provided for @ideasCastShadowPractice.
  ///
  /// In en, this message translates to:
  /// **'Cast shadows: the contact line, the fade and the grey that draws them.'**
  String get ideasCastShadowPractice;

  /// No description provided for @ideasCastShadowSubject.
  ///
  /// In en, this message translates to:
  /// **'A cup on a table, with the light from one side.'**
  String get ideasCastShadowSubject;

  /// No description provided for @ideasCastShadowTip.
  ///
  /// In en, this message translates to:
  /// **'The shadow starts where the object touches the table, not where the light ends.'**
  String get ideasCastShadowTip;

  /// No description provided for @ideasCastShadowStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a cup and the shape of its shadow on the table, longer on the side away from the light.'**
  String get ideasCastShadowStep1;

  /// No description provided for @ideasCastShadowStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the cup; shade its far side with the same marker in a second layer.'**
  String get ideasCastShadowStep2;

  /// No description provided for @ideasCastShadowStep3.
  ///
  /// In en, this message translates to:
  /// **'Fill the cast shadow with the grey, starting at the base of the cup and lifting as you move away.'**
  String get ideasCastShadowStep3;

  /// No description provided for @ideasCastShadowStep4.
  ///
  /// In en, this message translates to:
  /// **'Add a thin dark line where the cup touches the table.'**
  String get ideasCastShadowStep4;

  /// No description provided for @ideasCastShadowStep5.
  ///
  /// In en, this message translates to:
  /// **'Soften the far edge of the shadow with a second light touch of grey while the first is still damp.'**
  String get ideasCastShadowStep5;

  /// No description provided for @ideasSoftCloudsTitle.
  ///
  /// In en, this message translates to:
  /// **'Soft clouds'**
  String get ideasSoftCloudsTitle;

  /// No description provided for @ideasSoftCloudsSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour the sky around the clouds and leave the clouds as paper.'**
  String get ideasSoftCloudsSummary;

  /// No description provided for @ideasSoftCloudsPractice.
  ///
  /// In en, this message translates to:
  /// **'Negative painting: the shape is the paper you did not touch.'**
  String get ideasSoftCloudsPractice;

  /// No description provided for @ideasSoftCloudsSubject.
  ///
  /// In en, this message translates to:
  /// **'Two or three clouds with round tops and flat bottoms.'**
  String get ideasSoftCloudsSubject;

  /// No description provided for @ideasSoftCloudsTip.
  ///
  /// In en, this message translates to:
  /// **'Work around the clouds with the broad nib: their edges keep a ragged look.'**
  String get ideasSoftCloudsTip;

  /// No description provided for @ideasSoftCloudsStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil two or three cloud shapes very lightly: round tops, flatter bottoms.'**
  String get ideasSoftCloudsStep1;

  /// No description provided for @ideasSoftCloudsStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the sky with the light blue, working around the clouds with the broad nib so their edges stay a bit ragged.'**
  String get ideasSoftCloudsStep2;

  /// No description provided for @ideasSoftCloudsStep3.
  ///
  /// In en, this message translates to:
  /// **'Darken the sky towards the top and blend down into the light blue while it is wet.'**
  String get ideasSoftCloudsStep3;

  /// No description provided for @ideasSoftCloudsStep4.
  ///
  /// In en, this message translates to:
  /// **'Shade the underside of each cloud with the light grey, keeping the tops white.'**
  String get ideasSoftCloudsStep4;

  /// No description provided for @ideasSoftCloudsStep5.
  ///
  /// In en, this message translates to:
  /// **'Soften any hard sky edge against a cloud with the blender, pushing the colour outwards.'**
  String get ideasSoftCloudsStep5;

  /// No description provided for @ideasStillWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflection in still water'**
  String get ideasStillWaterTitle;

  /// No description provided for @ideasStillWaterSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw a tree on a bank and its upside-down, slightly darker copy in the water.'**
  String get ideasStillWaterSummary;

  /// No description provided for @ideasStillWaterPractice.
  ///
  /// In en, this message translates to:
  /// **'Glazing a colour over another one: how a reflection is made.'**
  String get ideasStillWaterPractice;

  /// No description provided for @ideasStillWaterSubject.
  ///
  /// In en, this message translates to:
  /// **'A tree on a bank with its reflection in the water below.'**
  String get ideasStillWaterSubject;

  /// No description provided for @ideasStillWaterTip.
  ///
  /// In en, this message translates to:
  /// **'Paint the reflection in horizontal strokes only: the water moves sideways.'**
  String get ideasStillWaterTip;

  /// No description provided for @ideasStillWaterStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a horizon line, a simple tree above it and its mirror image below.'**
  String get ideasStillWaterStep1;

  /// No description provided for @ideasStillWaterStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the tree; colour its reflection with the same marker in horizontal strokes only.'**
  String get ideasStillWaterStep2;

  /// No description provided for @ideasStillWaterStep3.
  ///
  /// In en, this message translates to:
  /// **'Lay the light blue over the whole water area, including the reflection, in long horizontal strokes.'**
  String get ideasStillWaterStep3;

  /// No description provided for @ideasStillWaterStep4.
  ///
  /// In en, this message translates to:
  /// **'Darken the water near the bank and the far edge; a few broken horizontal lines of base across the reflection.'**
  String get ideasStillWaterStep4;

  /// No description provided for @ideasStillWaterStep5.
  ///
  /// In en, this message translates to:
  /// **'Put the dark blue where the bank meets the water, then two or three thin white gel lines for ripples.'**
  String get ideasStillWaterStep5;

  /// No description provided for @ideasTwistedRibbonTitle.
  ///
  /// In en, this message translates to:
  /// **'Twisted ribbon'**
  String get ideasTwistedRibbonTitle;

  /// No description provided for @ideasTwistedRibbonSummary.
  ///
  /// In en, this message translates to:
  /// **'Blend a gradient that bends with a ribbon as it twists over and under itself.'**
  String get ideasTwistedRibbonSummary;

  /// No description provided for @ideasTwistedRibbonPractice.
  ///
  /// In en, this message translates to:
  /// **'Repeating a short blend on every turn of a shape.'**
  String get ideasTwistedRibbonPractice;

  /// No description provided for @ideasTwistedRibbonSubject.
  ///
  /// In en, this message translates to:
  /// **'A ribbon with two twists, over and under itself.'**
  String get ideasTwistedRibbonSubject;

  /// No description provided for @ideasTwistedRibbonTip.
  ///
  /// In en, this message translates to:
  /// **'Blend along the curve of the ribbon, never straight across it.'**
  String get ideasTwistedRibbonTip;

  /// No description provided for @ideasTwistedRibbonStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a ribbon with two twists; mark which segments show the front and which the back.'**
  String get ideasTwistedRibbonStep1;

  /// No description provided for @ideasTwistedRibbonStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill every segment with the light marker.'**
  String get ideasTwistedRibbonStep2;

  /// No description provided for @ideasTwistedRibbonStep3.
  ///
  /// In en, this message translates to:
  /// **'On each segment, add the base on the side that curves away from you, in strokes that follow the curve and not straight across.'**
  String get ideasTwistedRibbonStep3;

  /// No description provided for @ideasTwistedRibbonStep4.
  ///
  /// In en, this message translates to:
  /// **'Darken only where a segment passes under another, as a narrow band right at the overlap.'**
  String get ideasTwistedRibbonStep4;

  /// No description provided for @ideasTwistedRibbonStep5.
  ///
  /// In en, this message translates to:
  /// **'Blend with the blender along each band where the gradient looks stepped.'**
  String get ideasTwistedRibbonStep5;

  /// No description provided for @ideasNoLineLeafTitle.
  ///
  /// In en, this message translates to:
  /// **'No-line colouring'**
  String get ideasNoLineLeafTitle;

  /// No description provided for @ideasNoLineLeafSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour a leaf from a pencil sketch and let the edges of the colour do the work of the outline.'**
  String get ideasNoLineLeafSummary;

  /// No description provided for @ideasNoLineLeafPractice.
  ///
  /// In en, this message translates to:
  /// **'Drawing without a liner: the edge of the colour is the outline.'**
  String get ideasNoLineLeafPractice;

  /// No description provided for @ideasNoLineLeafSubject.
  ///
  /// In en, this message translates to:
  /// **'A simple leaf with its central vein.'**
  String get ideasNoLineLeafSubject;

  /// No description provided for @ideasNoLineLeafTip.
  ///
  /// In en, this message translates to:
  /// **'Lift the pencil with a soft eraser until you can only just see it.'**
  String get ideasNoLineLeafTip;

  /// No description provided for @ideasNoLineLeafStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw the leaf and its central vein very lightly in pencil, then lift most of the graphite with a soft eraser until you can only just see it.'**
  String get ideasNoLineLeafStep1;

  /// No description provided for @ideasNoLineLeafStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the leaf; stop exactly at the pencil line.'**
  String get ideasNoLineLeafStep2;

  /// No description provided for @ideasNoLineLeafStep3.
  ///
  /// In en, this message translates to:
  /// **'Shade one half and the base of the leaf while the first layer is damp.'**
  String get ideasNoLineLeafStep3;

  /// No description provided for @ideasNoLineLeafStep4.
  ///
  /// In en, this message translates to:
  /// **'Define the edge on the shadow side with a thin line of the darkest marker instead of a liner.'**
  String get ideasNoLineLeafStep4;

  /// No description provided for @ideasNoLineLeafStep5.
  ///
  /// In en, this message translates to:
  /// **'Erase any pencil still showing once the ink is dry.'**
  String get ideasNoLineLeafStep5;

  /// No description provided for @ideasShortFurTitle.
  ///
  /// In en, this message translates to:
  /// **'Short fur'**
  String get ideasShortFurTitle;

  /// No description provided for @ideasShortFurSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour the ear of a cat with short flicks in two directions.'**
  String get ideasShortFurSummary;

  /// No description provided for @ideasShortFurPractice.
  ///
  /// In en, this message translates to:
  /// **'Short strokes that follow the direction the hair grows.'**
  String get ideasShortFurPractice;

  /// No description provided for @ideasShortFurSubject.
  ///
  /// In en, this message translates to:
  /// **'A cat ear with a few arrows showing the way the fur grows.'**
  String get ideasShortFurSubject;

  /// No description provided for @ideasShortFurTip.
  ///
  /// In en, this message translates to:
  /// **'Flick from the roots outwards: press, move fast and lift.'**
  String get ideasShortFurTip;

  /// No description provided for @ideasShortFurStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the ear and draw the direction the fur grows with a few arrows.'**
  String get ideasShortFurStep1;

  /// No description provided for @ideasShortFurStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the ear with the light marker, flicking outward at the rim so the edge is furry and not solid.'**
  String get ideasShortFurStep2;

  /// No description provided for @ideasShortFurStep3.
  ///
  /// In en, this message translates to:
  /// **'Short flicks of base from the inner edge outward, following the arrows.'**
  String get ideasShortFurStep3;

  /// No description provided for @ideasShortFurStep4.
  ///
  /// In en, this message translates to:
  /// **'Fewer and darker flicks inside the ear and at the base where it meets the head.'**
  String get ideasShortFurStep4;

  /// No description provided for @ideasShortFurStep5.
  ///
  /// In en, this message translates to:
  /// **'Flick the light marker back over the joins to merge the layers and soften the darkest flicks.'**
  String get ideasShortFurStep5;

  /// No description provided for @ideasWoodGrainTitle.
  ///
  /// In en, this message translates to:
  /// **'Wood plank'**
  String get ideasWoodGrainTitle;

  /// No description provided for @ideasWoodGrainSummary.
  ///
  /// In en, this message translates to:
  /// **'A plank with grain lines and a knot, in three browns.'**
  String get ideasWoodGrainSummary;

  /// No description provided for @ideasWoodGrainPractice.
  ///
  /// In en, this message translates to:
  /// **'Long strokes that follow the shape of the material.'**
  String get ideasWoodGrainPractice;

  /// No description provided for @ideasWoodGrainSubject.
  ///
  /// In en, this message translates to:
  /// **'A wooden plank with a knot near one end.'**
  String get ideasWoodGrainSubject;

  /// No description provided for @ideasWoodGrainTip.
  ///
  /// In en, this message translates to:
  /// **'The grain flows around the knot: draw the lines bending, never straight.'**
  String get ideasWoodGrainTip;

  /// No description provided for @ideasWoodGrainStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a plank and a knot; the grain flows around the knot like water around a stone.'**
  String get ideasWoodGrainStep1;

  /// No description provided for @ideasWoodGrainStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the plank with long strokes along the grain.'**
  String get ideasWoodGrainStep2;

  /// No description provided for @ideasWoodGrainStep3.
  ///
  /// In en, this message translates to:
  /// **'Long, slightly wavy lines of base along the grain, bunching up near the knot.'**
  String get ideasWoodGrainStep3;

  /// No description provided for @ideasWoodGrainStep4.
  ///
  /// In en, this message translates to:
  /// **'A few darker lines and the rings of the knot; darken the lower edge of the plank.'**
  String get ideasWoodGrainStep4;

  /// No description provided for @ideasWoodGrainStep5.
  ///
  /// In en, this message translates to:
  /// **'Go back over the lines with the light marker to soften where they look drawn on.'**
  String get ideasWoodGrainStep5;

  /// No description provided for @ideasBrickWallTitle.
  ///
  /// In en, this message translates to:
  /// **'Brick wall'**
  String get ideasBrickWallTitle;

  /// No description provided for @ideasBrickWallSummary.
  ///
  /// In en, this message translates to:
  /// **'A patch of brick wall with bricks of slightly different colours and pale mortar.'**
  String get ideasBrickWallSummary;

  /// No description provided for @ideasBrickWallPractice.
  ///
  /// In en, this message translates to:
  /// **'Flat fills, one brick at a time, and the grey of the mortar.'**
  String get ideasBrickWallPractice;

  /// No description provided for @ideasBrickWallSubject.
  ///
  /// In en, this message translates to:
  /// **'A patch of wall with about twenty bricks.'**
  String get ideasBrickWallSubject;

  /// No description provided for @ideasBrickWallTip.
  ///
  /// In en, this message translates to:
  /// **'Leave the mortar as paper: it is lighter than any brick.'**
  String get ideasBrickWallTip;

  /// No description provided for @ideasBrickWallStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the mortar grid; leave it as paper for now.'**
  String get ideasBrickWallStep1;

  /// No description provided for @ideasBrickWallStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill every brick with the light marker, letting each brick dry as a separate shape.'**
  String get ideasBrickWallStep2;

  /// No description provided for @ideasBrickWallStep3.
  ///
  /// In en, this message translates to:
  /// **'Go over about half the bricks with the base, chosen at random, so the wall is not uniform.'**
  String get ideasBrickWallStep3;

  /// No description provided for @ideasBrickWallStep4.
  ///
  /// In en, this message translates to:
  /// **'Shadow on the lower edge of each brick, plus a few chips and some darker bricks.'**
  String get ideasBrickWallStep4;

  /// No description provided for @ideasBrickWallStep5.
  ///
  /// In en, this message translates to:
  /// **'Fill the mortar lines with the light grey.'**
  String get ideasBrickWallStep5;

  /// No description provided for @ideasFoldedClothTitle.
  ///
  /// In en, this message translates to:
  /// **'Folded cloth'**
  String get ideasFoldedClothTitle;

  /// No description provided for @ideasFoldedClothSummary.
  ///
  /// In en, this message translates to:
  /// **'Shade the folds of a hanging cloth with four values and one direction of light.'**
  String get ideasFoldedClothSummary;

  /// No description provided for @ideasFoldedClothPractice.
  ///
  /// In en, this message translates to:
  /// **'The same gradient repeated on every fold.'**
  String get ideasFoldedClothPractice;

  /// No description provided for @ideasFoldedClothSubject.
  ///
  /// In en, this message translates to:
  /// **'A cloth hanging over a line, with three or four folds.'**
  String get ideasFoldedClothSubject;

  /// No description provided for @ideasFoldedClothTip.
  ///
  /// In en, this message translates to:
  /// **'The darkest line goes only where the cloth turns under itself.'**
  String get ideasFoldedClothTip;

  /// No description provided for @ideasFoldedClothStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a cloth draped over a line, three or four folds; mark the top of each fold.'**
  String get ideasFoldedClothStep1;

  /// No description provided for @ideasFoldedClothStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the cloth.'**
  String get ideasFoldedClothStep2;

  /// No description provided for @ideasFoldedClothStep3.
  ///
  /// In en, this message translates to:
  /// **'Base on the side of each fold away from the light, blended into the light while it is damp.'**
  String get ideasFoldedClothStep3;

  /// No description provided for @ideasFoldedClothStep4.
  ///
  /// In en, this message translates to:
  /// **'Shadow deep inside each fold, where the cloth turns under.'**
  String get ideasFoldedClothStep4;

  /// No description provided for @ideasFoldedClothStep5.
  ///
  /// In en, this message translates to:
  /// **'A thin dark line only at the very bottom of the deepest folds; blend with the blender any hard step on the round parts.'**
  String get ideasFoldedClothStep5;

  /// No description provided for @ideasWaterDropsTitle.
  ///
  /// In en, this message translates to:
  /// **'Drops on a leaf'**
  String get ideasWaterDropsTitle;

  /// No description provided for @ideasWaterDropsSummary.
  ///
  /// In en, this message translates to:
  /// **'Three water drops on a leaf, each with a shadow, a dark edge and a bright glint.'**
  String get ideasWaterDropsSummary;

  /// No description provided for @ideasWaterDropsPractice.
  ///
  /// In en, this message translates to:
  /// **'A few crisp marks on top of a finished blend.'**
  String get ideasWaterDropsPractice;

  /// No description provided for @ideasWaterDropsSubject.
  ///
  /// In en, this message translates to:
  /// **'A leaf with three drops of water on it.'**
  String get ideasWaterDropsSubject;

  /// No description provided for @ideasWaterDropsTip.
  ///
  /// In en, this message translates to:
  /// **'The drop reverses the light: shade the side that faces it.'**
  String get ideasWaterDropsTip;

  /// No description provided for @ideasWaterDropsStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a leaf and three drops; mark in each drop a small highlight on the light side.'**
  String get ideasWaterDropsStep1;

  /// No description provided for @ideasWaterDropsStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the whole leaf, drops included; the drops are the leaf seen through water.'**
  String get ideasWaterDropsStep2;

  /// No description provided for @ideasWaterDropsStep3.
  ///
  /// In en, this message translates to:
  /// **'Shade the leaf, and inside each drop shade the side towards the light, because the drop acts as a lens and reverses it.'**
  String get ideasWaterDropsStep3;

  /// No description provided for @ideasWaterDropsStep4.
  ///
  /// In en, this message translates to:
  /// **'A thin dark crescent on the far side of each drop and a small cast shadow under it.'**
  String get ideasWaterDropsStep4;

  /// No description provided for @ideasWaterDropsStep5.
  ///
  /// In en, this message translates to:
  /// **'White gel: one hard dot per drop on the light side, plus a faint lighter rim opposite it.'**
  String get ideasWaterDropsStep5;

  /// No description provided for @ideasStrawberrySeedsTitle.
  ///
  /// In en, this message translates to:
  /// **'Strawberry'**
  String get ideasStrawberrySeedsTitle;

  /// No description provided for @ideasStrawberrySeedsSummary.
  ///
  /// In en, this message translates to:
  /// **'A strawberry whose seeds sit in small dimples, with a green cap.'**
  String get ideasStrawberrySeedsSummary;

  /// No description provided for @ideasStrawberrySeedsPractice.
  ///
  /// In en, this message translates to:
  /// **'Texture made of small marks: dimples, seeds and a cap.'**
  String get ideasStrawberrySeedsPractice;

  /// No description provided for @ideasStrawberrySeedsSubject.
  ///
  /// In en, this message translates to:
  /// **'A strawberry with a loose grid of seeds.'**
  String get ideasStrawberrySeedsSubject;

  /// No description provided for @ideasStrawberrySeedsTip.
  ///
  /// In en, this message translates to:
  /// **'Tap the dimples while the colour is still damp: the darker ring forms by itself.'**
  String get ideasStrawberrySeedsTip;

  /// No description provided for @ideasStrawberrySeedsStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the strawberry and a loose grid of seed dots, closer together towards the tip.'**
  String get ideasStrawberrySeedsStep1;

  /// No description provided for @ideasStrawberrySeedsStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the fruit, leaving a soft highlight.'**
  String get ideasStrawberrySeedsStep2;

  /// No description provided for @ideasStrawberrySeedsStep3.
  ///
  /// In en, this message translates to:
  /// **'Blend the base around the sides; while damp, press a slightly darker dot above each seed position.'**
  String get ideasStrawberrySeedsStep3;

  /// No description provided for @ideasStrawberrySeedsStep4.
  ///
  /// In en, this message translates to:
  /// **'Darken the lower half and the dimple above each seed.'**
  String get ideasStrawberrySeedsStep4;

  /// No description provided for @ideasStrawberrySeedsStep5.
  ///
  /// In en, this message translates to:
  /// **'Colour the leaves and the stalk with the green, then a tiny pale gel dot in each dimple for the seed.'**
  String get ideasStrawberrySeedsStep5;

  /// No description provided for @ideasPaletteMixingTitle.
  ///
  /// In en, this message translates to:
  /// **'Mixing on a palette'**
  String get ideasPaletteMixingTitle;

  /// No description provided for @ideasPaletteMixingSummary.
  ///
  /// In en, this message translates to:
  /// **'Make a third colour by mixing two markers on a plastic surface and picking it up with the blender.'**
  String get ideasPaletteMixingSummary;

  /// No description provided for @ideasPaletteMixingPractice.
  ///
  /// In en, this message translates to:
  /// **'Mixing two inks outside the paper, with the blender as the brush.'**
  String get ideasPaletteMixingPractice;

  /// No description provided for @ideasPaletteMixingSubject.
  ///
  /// In en, this message translates to:
  /// **'A plastic lid or a blending card, plus a scrap of paper.'**
  String get ideasPaletteMixingSubject;

  /// No description provided for @ideasPaletteMixingTip.
  ///
  /// In en, this message translates to:
  /// **'The blender only carries what is wet: do not let the puddles dry.'**
  String get ideasPaletteMixingTip;

  /// No description provided for @ideasPaletteMixingStep1.
  ///
  /// In en, this message translates to:
  /// **'Scribble the first marker onto a non-porous scrap, such as a blending card, a plastic lid or a zip bag.'**
  String get ideasPaletteMixingStep1;

  /// No description provided for @ideasPaletteMixingStep2.
  ///
  /// In en, this message translates to:
  /// **'Scribble the second marker next to it so the two puddles touch.'**
  String get ideasPaletteMixingStep2;

  /// No description provided for @ideasPaletteMixingStep3.
  ///
  /// In en, this message translates to:
  /// **'Pick the mixture up with the broad nib of the colourless blender and paint a swatch with it; next to it, swatch each marker alone.'**
  String get ideasPaletteMixingStep3;

  /// No description provided for @ideasPaletteMixingStep4.
  ///
  /// In en, this message translates to:
  /// **'Try a second mix with more of one of the two colours.'**
  String get ideasPaletteMixingStep4;

  /// No description provided for @ideasPaletteMixingStep5.
  ///
  /// In en, this message translates to:
  /// **'Note which mixes you would like to own as a marker.'**
  String get ideasPaletteMixingStep5;

  /// No description provided for @ideasLongHairTitle.
  ///
  /// In en, this message translates to:
  /// **'Long hair'**
  String get ideasLongHairTitle;

  /// No description provided for @ideasLongHairSummary.
  ///
  /// In en, this message translates to:
  /// **'A fall of hair with a band of light across it and strands that follow the head.'**
  String get ideasLongHairSummary;

  /// No description provided for @ideasLongHairPractice.
  ///
  /// In en, this message translates to:
  /// **'Long tapered strokes and a band of light that is only paper.'**
  String get ideasLongHairPractice;

  /// No description provided for @ideasLongHairSubject.
  ///
  /// In en, this message translates to:
  /// **'A head of hair with a few big locks and a band of light.'**
  String get ideasLongHairSubject;

  /// No description provided for @ideasLongHairTip.
  ///
  /// In en, this message translates to:
  /// **'Press less inside the band of light: the paper does the work.'**
  String get ideasLongHairTip;

  /// No description provided for @ideasLongHairStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the hair as a few big locks and not as single hairs, and a curved band where the light hits.'**
  String get ideasLongHairStep1;

  /// No description provided for @ideasLongHairStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill all the hair, pressing less inside the light band.'**
  String get ideasLongHairStep2;

  /// No description provided for @ideasLongHairStep3.
  ///
  /// In en, this message translates to:
  /// **'Long strokes from the parting down, each lifting as it reaches the light band, then from the ends up towards it.'**
  String get ideasLongHairStep3;

  /// No description provided for @ideasLongHairStep4.
  ///
  /// In en, this message translates to:
  /// **'Darken between the locks and under the ear and the neck.'**
  String get ideasLongHairStep4;

  /// No description provided for @ideasLongHairStep5.
  ///
  /// In en, this message translates to:
  /// **'A few thin strands of the darkest marker, then two or three fine white gel strands only inside the light band.'**
  String get ideasLongHairStep5;

  /// No description provided for @ideasOverlapGlazesTitle.
  ///
  /// In en, this message translates to:
  /// **'Overlapping glazes'**
  String get ideasOverlapGlazesTitle;

  /// No description provided for @ideasOverlapGlazesSummary.
  ///
  /// In en, this message translates to:
  /// **'Overlap three transparent circles and see which new colours appear.'**
  String get ideasOverlapGlazesSummary;

  /// No description provided for @ideasOverlapGlazesPractice.
  ///
  /// In en, this message translates to:
  /// **'Transparent layers: every overlap is a real mix.'**
  String get ideasOverlapGlazesPractice;

  /// No description provided for @ideasOverlapGlazesSubject.
  ///
  /// In en, this message translates to:
  /// **'Three overlapping circles, like a Venn diagram.'**
  String get ideasOverlapGlazesSubject;

  /// No description provided for @ideasOverlapGlazesTip.
  ///
  /// In en, this message translates to:
  /// **'The order matters: the lighter colour on top always looks different.'**
  String get ideasOverlapGlazesTip;

  /// No description provided for @ideasOverlapGlazesStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil three circles that overlap like a Venn diagram.'**
  String get ideasOverlapGlazesStep1;

  /// No description provided for @ideasOverlapGlazesStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the first circle and let it dry completely.'**
  String get ideasOverlapGlazesStep2;

  /// No description provided for @ideasOverlapGlazesStep3.
  ///
  /// In en, this message translates to:
  /// **'Fill the second, including the overlap; the overlap turns a third colour.'**
  String get ideasOverlapGlazesStep3;

  /// No description provided for @ideasOverlapGlazesStep4.
  ///
  /// In en, this message translates to:
  /// **'Fill the third circle; the middle, where all three meet, is the darkest mix.'**
  String get ideasOverlapGlazesStep4;

  /// No description provided for @ideasOverlapGlazesStep5.
  ///
  /// In en, this message translates to:
  /// **'Repeat with the markers in another order: the lighter one on top always looks different.'**
  String get ideasOverlapGlazesStep5;

  /// No description provided for @ideasFadedBackgroundTitle.
  ///
  /// In en, this message translates to:
  /// **'Faded background'**
  String get ideasFadedBackgroundTitle;

  /// No description provided for @ideasFadedBackgroundSummary.
  ///
  /// In en, this message translates to:
  /// **'Give a drawing a halo of colour that fades to white long before the edge of the paper.'**
  String get ideasFadedBackgroundSummary;

  /// No description provided for @ideasFadedBackgroundPractice.
  ///
  /// In en, this message translates to:
  /// **'A vignette made with circular strokes and the blender.'**
  String get ideasFadedBackgroundPractice;

  /// No description provided for @ideasFadedBackgroundSubject.
  ///
  /// In en, this message translates to:
  /// **'A mug, a bird or any small subject in the middle of the page.'**
  String get ideasFadedBackgroundSubject;

  /// No description provided for @ideasFadedBackgroundTip.
  ///
  /// In en, this message translates to:
  /// **'Stop before you reach the edge of the paper: the halo fades on its own.'**
  String get ideasFadedBackgroundTip;

  /// No description provided for @ideasFadedBackgroundStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil a simple subject, such as a mug or a bird, in the middle of the page.'**
  String get ideasFadedBackgroundStep1;

  /// No description provided for @ideasFadedBackgroundStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour a ring of base around the subject, about a finger wide, in circular strokes.'**
  String get ideasFadedBackgroundStep2;

  /// No description provided for @ideasFadedBackgroundStep3.
  ///
  /// In en, this message translates to:
  /// **'Pull the light marker outwards from the ring in overlapping circles until it runs pale.'**
  String get ideasFadedBackgroundStep3;

  /// No description provided for @ideasFadedBackgroundStep4.
  ///
  /// In en, this message translates to:
  /// **'Follow with the blender beyond the colour, pushing the last of it into the paper so there is no edge at all.'**
  String get ideasFadedBackgroundStep4;

  /// No description provided for @ideasFadedBackgroundStep5.
  ///
  /// In en, this message translates to:
  /// **'Finish the subject so it is darker than the halo.'**
  String get ideasFadedBackgroundStep5;

  /// No description provided for @ideasHatchShadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Hatched shading'**
  String get ideasHatchShadingTitle;

  /// No description provided for @ideasHatchShadingSummary.
  ///
  /// In en, this message translates to:
  /// **'Shade an apple with lines only, no blending: hatching for the mid-tone and cross-hatching for the shadow.'**
  String get ideasHatchShadingSummary;

  /// No description provided for @ideasHatchShadingPractice.
  ///
  /// In en, this message translates to:
  /// **'Hatching and cross-hatching: lines that read as a tone.'**
  String get ideasHatchShadingPractice;

  /// No description provided for @ideasHatchShadingSubject.
  ///
  /// In en, this message translates to:
  /// **'An apple with the highlight marked in.'**
  String get ideasHatchShadingSubject;

  /// No description provided for @ideasHatchShadingTip.
  ///
  /// In en, this message translates to:
  /// **'Keep the lines parallel and evenly spaced: the eye does the rest.'**
  String get ideasHatchShadingTip;

  /// No description provided for @ideasHatchShadingStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil an apple and mark the highlight.'**
  String get ideasHatchShadingStep1;

  /// No description provided for @ideasHatchShadingStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the apple flat and let it dry.'**
  String get ideasHatchShadingStep2;

  /// No description provided for @ideasHatchShadingStep3.
  ///
  /// In en, this message translates to:
  /// **'Hatch the shadow half with parallel lines of the fine nib, closer together as they get further from the light.'**
  String get ideasHatchShadingStep3;

  /// No description provided for @ideasHatchShadingStep4.
  ///
  /// In en, this message translates to:
  /// **'Cross the darkest area with a second set of lines at an angle, and add the contact shadow under the apple.'**
  String get ideasHatchShadingStep4;

  /// No description provided for @ideasHatchShadingStep5.
  ///
  /// In en, this message translates to:
  /// **'Step back: from a distance the lines turn into a shade.'**
  String get ideasHatchShadingStep5;

  /// No description provided for @ideasCategoryTechnique.
  ///
  /// In en, this message translates to:
  /// **'Techniques'**
  String get ideasCategoryTechnique;

  /// No description provided for @ideasCategoryColorChallenge.
  ///
  /// In en, this message translates to:
  /// **'Colour challenges'**
  String get ideasCategoryColorChallenge;

  /// No description provided for @ideasCategoryMood.
  ///
  /// In en, this message translates to:
  /// **'Moods'**
  String get ideasCategoryMood;

  /// No description provided for @ideasCategorySeason.
  ///
  /// In en, this message translates to:
  /// **'Seasons'**
  String get ideasCategorySeason;

  /// No description provided for @ideasDifficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get ideasDifficultyEasy;

  /// No description provided for @ideasDifficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get ideasDifficultyMedium;

  /// No description provided for @ideasDifficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get ideasDifficultyHard;

  /// No description provided for @ideasSeasonSpring.
  ///
  /// In en, this message translates to:
  /// **'Spring'**
  String get ideasSeasonSpring;

  /// No description provided for @ideasSeasonSummer.
  ///
  /// In en, this message translates to:
  /// **'Summer'**
  String get ideasSeasonSummer;

  /// No description provided for @ideasSeasonAutumn.
  ///
  /// In en, this message translates to:
  /// **'Autumn'**
  String get ideasSeasonAutumn;

  /// No description provided for @ideasSeasonWinter.
  ///
  /// In en, this message translates to:
  /// **'Winter'**
  String get ideasSeasonWinter;

  /// No description provided for @ideasSectionAnyTime.
  ///
  /// In en, this message translates to:
  /// **'Any time'**
  String get ideasSectionAnyTime;

  /// No description provided for @ideasSeeAllSemantic.
  ///
  /// In en, this message translates to:
  /// **'See all {count} ideas in {category}'**
  String ideasSeeAllSemantic(int count, String category);

  /// No description provided for @ideasFeaturedLabel.
  ///
  /// In en, this message translates to:
  /// **'Idea of the day'**
  String get ideasFeaturedLabel;

  /// No description provided for @ideasOtherMarkersButton.
  ///
  /// In en, this message translates to:
  /// **'Other markers'**
  String get ideasOtherMarkersButton;

  /// No description provided for @ideasPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'What you practise'**
  String get ideasPracticeTitle;

  /// No description provided for @ideasSubjectTitle.
  ///
  /// In en, this message translates to:
  /// **'What to draw'**
  String get ideasSubjectTitle;

  /// No description provided for @ideasMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Your markers'**
  String get ideasMarkersTitle;

  /// No description provided for @ideasStepsTitle.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get ideasStepsTitle;

  /// No description provided for @ideasTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get ideasTipTitle;

  /// No description provided for @ideasMaterialsTitle.
  ///
  /// In en, this message translates to:
  /// **'You need'**
  String get ideasMaterialsTitle;

  /// No description provided for @ideasMaterialPaper.
  ///
  /// In en, this message translates to:
  /// **'marker paper with a sheet underneath'**
  String get ideasMaterialPaper;

  /// No description provided for @ideasMaterialBlender.
  ///
  /// In en, this message translates to:
  /// **'colourless blender'**
  String get ideasMaterialBlender;

  /// No description provided for @ideasMaterialWhiteGel.
  ///
  /// In en, this message translates to:
  /// **'white gel pen'**
  String get ideasMaterialWhiteGel;

  /// No description provided for @ideasMaterialPigmentLiner.
  ///
  /// In en, this message translates to:
  /// **'black pigment liner'**
  String get ideasMaterialPigmentLiner;

  /// No description provided for @ideasMaterialPencil.
  ///
  /// In en, this message translates to:
  /// **'pencil'**
  String get ideasMaterialPencil;

  /// No description provided for @ideasMaterialTape.
  ///
  /// In en, this message translates to:
  /// **'masking tape'**
  String get ideasMaterialTape;

  /// No description provided for @ideasBackLabel.
  ///
  /// In en, this message translates to:
  /// **'Back to ideas'**
  String get ideasBackLabel;

  /// No description provided for @ideasMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String ideasMinutes(int minutes);

  /// No description provided for @ideasMissingMarkers.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Your collection is missing 1 marker for this idea.} other{Your collection is missing {count} markers for this idea.}}'**
  String ideasMissingMarkers(int count);

  /// No description provided for @ideasMarkerSemantic.
  ///
  /// In en, this message translates to:
  /// **'{role}: {code} {name}'**
  String ideasMarkerSemantic(String role, String code, String name);

  /// No description provided for @ideasSmoothFillTitle.
  ///
  /// In en, this message translates to:
  /// **'Streak-free fill'**
  String get ideasSmoothFillTitle;

  /// No description provided for @ideasSmoothFillSummary.
  ///
  /// In en, this message translates to:
  /// **'Fill a square with one marker without visible streaks.'**
  String get ideasSmoothFillSummary;

  /// No description provided for @ideasSmoothFillPractice.
  ///
  /// In en, this message translates to:
  /// **'Even, streak-free coverage, the base of every marker drawing.'**
  String get ideasSmoothFillPractice;

  /// No description provided for @ideasSmoothFillSubject.
  ///
  /// In en, this message translates to:
  /// **'A 5 × 5 cm square framed with masking tape, then a simple flat shape such as a leaf.'**
  String get ideasSmoothFillSubject;

  /// No description provided for @ideasSmoothFillTip.
  ///
  /// In en, this message translates to:
  /// **'If the paper starts to pill, stop: it is saturated. Let it dry completely before another layer.'**
  String get ideasSmoothFillTip;

  /// No description provided for @ideasSmoothFillStep1.
  ///
  /// In en, this message translates to:
  /// **'Tape a 5 × 5 cm square on marker paper and slip a scrap sheet underneath.'**
  String get ideasSmoothFillStep1;

  /// No description provided for @ideasSmoothFillStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the square with the light marker in small overlapping circles, without stopping.'**
  String get ideasSmoothFillStep2;

  /// No description provided for @ideasSmoothFillStep3.
  ///
  /// In en, this message translates to:
  /// **'Keep a wet edge: always go back over ink that is still shiny, never over dry ink.'**
  String get ideasSmoothFillStep3;

  /// No description provided for @ideasSmoothFillStep4.
  ///
  /// In en, this message translates to:
  /// **'Let it dry, then add a second layer with the same marker, at right angles to the first.'**
  String get ideasSmoothFillStep4;

  /// No description provided for @ideasSmoothFillStep5.
  ///
  /// In en, this message translates to:
  /// **'Repeat the square with the darker marker and compare: streaks show more in dark colours.'**
  String get ideasSmoothFillStep5;

  /// No description provided for @ideasSmoothFillStep6.
  ///
  /// In en, this message translates to:
  /// **'Peel the tape off slowly to reveal a clean edge.'**
  String get ideasSmoothFillStep6;

  /// No description provided for @ideasThreeMarkerBlendTitle.
  ///
  /// In en, this message translates to:
  /// **'Three-marker blend'**
  String get ideasThreeMarkerBlendTitle;

  /// No description provided for @ideasThreeMarkerBlendSummary.
  ///
  /// In en, this message translates to:
  /// **'Blend a light, a mid and a dark marker of one family on a ball.'**
  String get ideasThreeMarkerBlendSummary;

  /// No description provided for @ideasThreeMarkerBlendPractice.
  ///
  /// In en, this message translates to:
  /// **'Smooth light-to-dark blending within one colour family.'**
  String get ideasThreeMarkerBlendPractice;

  /// No description provided for @ideasThreeMarkerBlendSubject.
  ///
  /// In en, this message translates to:
  /// **'A ball lit from the top left, with its shadow on the table.'**
  String get ideasThreeMarkerBlendSubject;

  /// No description provided for @ideasThreeMarkerBlendTip.
  ///
  /// In en, this message translates to:
  /// **'Pick markers that are close in tone: if the jump between them is too big, a line will show.'**
  String get ideasThreeMarkerBlendTip;

  /// No description provided for @ideasThreeMarkerBlendStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw a circle in light pencil and mark where the light comes from.'**
  String get ideasThreeMarkerBlendStep1;

  /// No description provided for @ideasThreeMarkerBlendStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the whole ball with the light marker, leaving a small spot of white paper for the highlight.'**
  String get ideasThreeMarkerBlendStep2;

  /// No description provided for @ideasThreeMarkerBlendStep3.
  ///
  /// In en, this message translates to:
  /// **'While it is still damp, add the mid marker on the shadow half, in curved strokes that follow the shape.'**
  String get ideasThreeMarkerBlendStep3;

  /// No description provided for @ideasThreeMarkerBlendStep4.
  ///
  /// In en, this message translates to:
  /// **'Add the dark marker only along the edge furthest from the light.'**
  String get ideasThreeMarkerBlendStep4;

  /// No description provided for @ideasThreeMarkerBlendStep5.
  ///
  /// In en, this message translates to:
  /// **'Go back over the joins with the mid marker and then with the light one to melt the steps together.'**
  String get ideasThreeMarkerBlendStep5;

  /// No description provided for @ideasThreeMarkerBlendStep6.
  ///
  /// In en, this message translates to:
  /// **'Soften any hard edge around the highlight with the colourless blender.'**
  String get ideasThreeMarkerBlendStep6;

  /// No description provided for @ideasFlickingTitle.
  ///
  /// In en, this message translates to:
  /// **'Flicking strokes'**
  String get ideasFlickingTitle;

  /// No description provided for @ideasFlickingSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw hair or grass with quick strokes that fade out at the end.'**
  String get ideasFlickingSummary;

  /// No description provided for @ideasFlickingPractice.
  ///
  /// In en, this message translates to:
  /// **'Flicking: fast strokes that taper off, to blend without hard edges.'**
  String get ideasFlickingPractice;

  /// No description provided for @ideasFlickingSubject.
  ///
  /// In en, this message translates to:
  /// **'A ponytail or a tuft of grass.'**
  String get ideasFlickingSubject;

  /// No description provided for @ideasFlickingTip.
  ///
  /// In en, this message translates to:
  /// **'Try it on a scrap first: the faster you move, the thinner the tail of the stroke.'**
  String get ideasFlickingTip;

  /// No description provided for @ideasFlickingStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the main locks or blades as simple shapes, without detail.'**
  String get ideasFlickingStep1;

  /// No description provided for @ideasFlickingStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover each shape with the light marker in one flat layer and let it dry.'**
  String get ideasFlickingStep2;

  /// No description provided for @ideasFlickingStep3.
  ///
  /// In en, this message translates to:
  /// **'Flick the mid marker from the roots outwards: press, move fast and lift before the end of the stroke.'**
  String get ideasFlickingStep3;

  /// No description provided for @ideasFlickingStep4.
  ///
  /// In en, this message translates to:
  /// **'Do the same with the dark marker, only from the roots and shorter, where the locks overlap.'**
  String get ideasFlickingStep4;

  /// No description provided for @ideasFlickingStep5.
  ///
  /// In en, this message translates to:
  /// **'Flick the light marker from the tips back towards the roots to soften the change of tone.'**
  String get ideasFlickingStep5;

  /// No description provided for @ideasFlickingStep6.
  ///
  /// In en, this message translates to:
  /// **'Leave a band of the first layer where the hair catches the light.'**
  String get ideasFlickingStep6;

  /// No description provided for @ideasGrayscaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Shades of grey'**
  String get ideasGrayscaleTitle;

  /// No description provided for @ideasGrayscaleSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw a simple object with one grey family to see how light and shadow build form.'**
  String get ideasGrayscaleSummary;

  /// No description provided for @ideasGrayscalePractice.
  ///
  /// In en, this message translates to:
  /// **'Seeing light and shadow as steps from light to dark.'**
  String get ideasGrayscalePractice;

  /// No description provided for @ideasGrayscaleSubject.
  ///
  /// In en, this message translates to:
  /// **'A mug, an apple or an egg under a single lamp.'**
  String get ideasGrayscaleSubject;

  /// No description provided for @ideasGrayscaleTip.
  ///
  /// In en, this message translates to:
  /// **'Do not mix warm and cool greys in the same object: pick one family.'**
  String get ideasGrayscaleTip;

  /// No description provided for @ideasGrayscaleStep1.
  ///
  /// In en, this message translates to:
  /// **'Pick a simple object and mark in pencil where the light comes from.'**
  String get ideasGrayscaleStep1;

  /// No description provided for @ideasGrayscaleStep2.
  ///
  /// In en, this message translates to:
  /// **'Leave the highlight as white paper. Never colour over it.'**
  String get ideasGrayscaleStep2;

  /// No description provided for @ideasGrayscaleStep3.
  ///
  /// In en, this message translates to:
  /// **'Cover the whole object with the lightest grey and let it dry.'**
  String get ideasGrayscaleStep3;

  /// No description provided for @ideasGrayscaleStep4.
  ///
  /// In en, this message translates to:
  /// **'Add the next grey on the shadow side, blending the edge while it is still wet.'**
  String get ideasGrayscaleStep4;

  /// No description provided for @ideasGrayscaleStep5.
  ///
  /// In en, this message translates to:
  /// **'Repeat with each darker grey, covering a smaller area each time.'**
  String get ideasGrayscaleStep5;

  /// No description provided for @ideasGrayscaleStep6.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest grey only for the cast shadow and the contact line under the object.'**
  String get ideasGrayscaleStep6;

  /// No description provided for @ideasStickerEffectTitle.
  ///
  /// In en, this message translates to:
  /// **'Sticker effect'**
  String get ideasStickerEffectTitle;

  /// No description provided for @ideasStickerEffectSummary.
  ///
  /// In en, this message translates to:
  /// **'Make a character look like a cut-out sticker with a paper-white border and a coloured background.'**
  String get ideasStickerEffectSummary;

  /// No description provided for @ideasStickerEffectPractice.
  ///
  /// In en, this message translates to:
  /// **'Keeping the white of the paper on purpose.'**
  String get ideasStickerEffectPractice;

  /// No description provided for @ideasStickerEffectSubject.
  ///
  /// In en, this message translates to:
  /// **'A cat, a slice of pizza or a cartoon star.'**
  String get ideasStickerEffectSubject;

  /// No description provided for @ideasStickerEffectTip.
  ///
  /// In en, this message translates to:
  /// **'The white must be the paper. White gel over marker ink looks patchy.'**
  String get ideasStickerEffectTip;

  /// No description provided for @ideasStickerEffectStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw your subject, then pencil a second outline 3–5 mm outside it: that is the sticker border.'**
  String get ideasStickerEffectStep1;

  /// No description provided for @ideasStickerEffectStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the subject from light to dark without touching the border.'**
  String get ideasStickerEffectStep2;

  /// No description provided for @ideasStickerEffectStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the background around the border in one flat colour, so the white edge shows.'**
  String get ideasStickerEffectStep3;

  /// No description provided for @ideasStickerEffectStep4.
  ///
  /// In en, this message translates to:
  /// **'When it is dry, go over the outside of the border with a black liner or brush pen.'**
  String get ideasStickerEffectStep4;

  /// No description provided for @ideasStickerEffectStep5.
  ///
  /// In en, this message translates to:
  /// **'Add a grey shadow along one side of the border to lift the sticker off the page.'**
  String get ideasStickerEffectStep5;

  /// No description provided for @ideasGlossyCherriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Glossy cherries'**
  String get ideasGlossyCherriesTitle;

  /// No description provided for @ideasGlossyCherriesSummary.
  ///
  /// In en, this message translates to:
  /// **'Make two cherries shine with a kept highlight and a reflected light.'**
  String get ideasGlossyCherriesSummary;

  /// No description provided for @ideasGlossyCherriesPractice.
  ///
  /// In en, this message translates to:
  /// **'Crisp highlights and reflected light, the keys to a shiny surface.'**
  String get ideasGlossyCherriesPractice;

  /// No description provided for @ideasGlossyCherriesSubject.
  ///
  /// In en, this message translates to:
  /// **'Two cherries on a stalk, lit from one side.'**
  String get ideasGlossyCherriesSubject;

  /// No description provided for @ideasGlossyCherriesTip.
  ///
  /// In en, this message translates to:
  /// **'Shiny surfaces have hard-edged highlights: do not blend them, keep the border crisp.'**
  String get ideasGlossyCherriesTip;

  /// No description provided for @ideasGlossyCherriesStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the cherries and the shape of each highlight: a crisp bean shape near the top.'**
  String get ideasGlossyCherriesStep1;

  /// No description provided for @ideasGlossyCherriesStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover each cherry with the light marker, going around the highlights so they stay white paper.'**
  String get ideasGlossyCherriesStep2;

  /// No description provided for @ideasGlossyCherriesStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the base everywhere except a thin crescent along the bottom edge: that is the reflected light.'**
  String get ideasGlossyCherriesStep3;

  /// No description provided for @ideasGlossyCherriesStep4.
  ///
  /// In en, this message translates to:
  /// **'Lay the shadow on the side away from the light and blend it into the base while it is wet.'**
  String get ideasGlossyCherriesStep4;

  /// No description provided for @ideasGlossyCherriesStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the darkest marker in a narrow band between the shadow and the reflected light.'**
  String get ideasGlossyCherriesStep5;

  /// No description provided for @ideasGlossyCherriesStep6.
  ///
  /// In en, this message translates to:
  /// **'Draw the shadow on the table with the grey and, once dry, add a white gel dot on each highlight.'**
  String get ideasGlossyCherriesStep6;

  /// No description provided for @ideasColoredShadowsTitle.
  ///
  /// In en, this message translates to:
  /// **'Coloured shadows'**
  String get ideasColoredShadowsTitle;

  /// No description provided for @ideasColoredShadowsSummary.
  ///
  /// In en, this message translates to:
  /// **'Shade the same lemon twice, once with grey and once with violet, and compare.'**
  String get ideasColoredShadowsSummary;

  /// No description provided for @ideasColoredShadowsPractice.
  ///
  /// In en, this message translates to:
  /// **'Choosing shadow colours that keep a drawing alive.'**
  String get ideasColoredShadowsPractice;

  /// No description provided for @ideasColoredShadowsSubject.
  ///
  /// In en, this message translates to:
  /// **'Two lemons side by side on a white table.'**
  String get ideasColoredShadowsSubject;

  /// No description provided for @ideasColoredShadowsTip.
  ///
  /// In en, this message translates to:
  /// **'A shadow often leans towards the opposite of the light: violet under yellow, blue under orange.'**
  String get ideasColoredShadowsTip;

  /// No description provided for @ideasColoredShadowsStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw two identical lemons side by side, with the light coming from the same side.'**
  String get ideasColoredShadowsStep1;

  /// No description provided for @ideasColoredShadowsStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour both with the yellow, leaving a small highlight of white paper.'**
  String get ideasColoredShadowsStep2;

  /// No description provided for @ideasColoredShadowsStep3.
  ///
  /// In en, this message translates to:
  /// **'On the first lemon, shade the dark side and the shadow on the table with the grey.'**
  String get ideasColoredShadowsStep3;

  /// No description provided for @ideasColoredShadowsStep4.
  ///
  /// In en, this message translates to:
  /// **'On the second, do the same with the violet, gently: one layer is enough.'**
  String get ideasColoredShadowsStep4;

  /// No description provided for @ideasColoredShadowsStep5.
  ///
  /// In en, this message translates to:
  /// **'Go over the edge of the second shadow with the yellow to blend it in.'**
  String get ideasColoredShadowsStep5;

  /// No description provided for @ideasColoredShadowsStep6.
  ///
  /// In en, this message translates to:
  /// **'Look at them from a distance: the violet shadow looks brighter and more natural next to the yellow.'**
  String get ideasColoredShadowsStep6;

  /// No description provided for @ideasStainedGlassTitle.
  ///
  /// In en, this message translates to:
  /// **'Stained glass'**
  String get ideasStainedGlassTitle;

  /// No description provided for @ideasStainedGlassSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour the glass panes with simple gradients and add the lead lines at the end.'**
  String get ideasStainedGlassSummary;

  /// No description provided for @ideasStainedGlassPractice.
  ///
  /// In en, this message translates to:
  /// **'Clean gradients in small areas; the black lines hide uneven edges.'**
  String get ideasStainedGlassPractice;

  /// No description provided for @ideasStainedGlassSubject.
  ///
  /// In en, this message translates to:
  /// **'A round window with a flower or a sun in the middle.'**
  String get ideasStainedGlassSubject;

  /// No description provided for @ideasStainedGlassTip.
  ///
  /// In en, this message translates to:
  /// **'If you draw the black lines first, use pigment ink that resists alcohol: ordinary ink smears under the marker.'**
  String get ideasStainedGlassTip;

  /// No description provided for @ideasStainedGlassStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the window and divide it into panes of different sizes.'**
  String get ideasStainedGlassStep1;

  /// No description provided for @ideasStainedGlassStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the panes of the main colour first, each one as a gradient: darker at one edge, lighter in the middle.'**
  String get ideasStainedGlassStep2;

  /// No description provided for @ideasStainedGlassStep3.
  ///
  /// In en, this message translates to:
  /// **'Do the same with the second and third colours, letting each pane dry before colouring the one next to it.'**
  String get ideasStainedGlassStep3;

  /// No description provided for @ideasStainedGlassStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the accent in just a few small panes so they stand out.'**
  String get ideasStainedGlassStep4;

  /// No description provided for @ideasStainedGlassStep5.
  ///
  /// In en, this message translates to:
  /// **'When everything is dry, go over the borders with thick lines of black liner or brush pen.'**
  String get ideasStainedGlassStep5;

  /// No description provided for @ideasStainedGlassStep6.
  ///
  /// In en, this message translates to:
  /// **'Add a small stroke of white gel on a few panes to suggest the shine of the glass.'**
  String get ideasStainedGlassStep6;

  /// No description provided for @ideasSwatchChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your own colour chart'**
  String get ideasSwatchChartTitle;

  /// No description provided for @ideasSwatchChartSummary.
  ///
  /// In en, this message translates to:
  /// **'Test how each marker looks with one, two and three layers.'**
  String get ideasSwatchChartSummary;

  /// No description provided for @ideasSwatchChartPractice.
  ///
  /// In en, this message translates to:
  /// **'Knowing how your markers really look on paper, not on the cap.'**
  String get ideasSwatchChartPractice;

  /// No description provided for @ideasSwatchChartSubject.
  ///
  /// In en, this message translates to:
  /// **'A grid with one row per marker, grouped by colour family.'**
  String get ideasSwatchChartSubject;

  /// No description provided for @ideasSwatchChartTip.
  ///
  /// In en, this message translates to:
  /// **'Make the chart on the paper you really use: the same marker changes a lot from one paper to another.'**
  String get ideasSwatchChartTip;

  /// No description provided for @ideasSwatchChartStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw a grid on the paper you usually use: one row per marker and four squares per row.'**
  String get ideasSwatchChartStep1;

  /// No description provided for @ideasSwatchChartStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill the first square with one layer, the second with two and the third with three, letting each layer dry.'**
  String get ideasSwatchChartStep2;

  /// No description provided for @ideasSwatchChartStep3.
  ///
  /// In en, this message translates to:
  /// **'In the fourth square, lay one layer and lift part of the ink with the colourless blender.'**
  String get ideasSwatchChartStep3;

  /// No description provided for @ideasSwatchChartStep4.
  ///
  /// In en, this message translates to:
  /// **'Write the code under each row in pencil or with a liner.'**
  String get ideasSwatchChartStep4;

  /// No description provided for @ideasSwatchChartStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the Swatches tab to mark the markers you own and compare them with your chart.'**
  String get ideasSwatchChartStep5;

  /// No description provided for @ideasOneColorTitle.
  ///
  /// In en, this message translates to:
  /// **'One colour family'**
  String get ideasOneColorTitle;

  /// No description provided for @ideasOneColorSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw a whole scene with four markers of a single colour family.'**
  String get ideasOneColorSummary;

  /// No description provided for @ideasOneColorPractice.
  ///
  /// In en, this message translates to:
  /// **'Building depth with layers and with lighter and darker markers.'**
  String get ideasOneColorPractice;

  /// No description provided for @ideasOneColorSubject.
  ///
  /// In en, this message translates to:
  /// **'A steaming cup of tea, or a small plant in a pot.'**
  String get ideasOneColorSubject;

  /// No description provided for @ideasOneColorTip.
  ///
  /// In en, this message translates to:
  /// **'Pressing lightly does not make a marker paler. For light areas, use the lighter marker or the colourless blender.'**
  String get ideasOneColorTip;

  /// No description provided for @ideasOneColorStep1.
  ///
  /// In en, this message translates to:
  /// **'Pick a simple subject and mark in pencil where the light comes from.'**
  String get ideasOneColorStep1;

  /// No description provided for @ideasOneColorStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover everything except the highlights with the lightest marker.'**
  String get ideasOneColorStep2;

  /// No description provided for @ideasOneColorStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the base marker to the parts facing away from the light.'**
  String get ideasOneColorStep3;

  /// No description provided for @ideasOneColorStep4.
  ///
  /// In en, this message translates to:
  /// **'Put the shadow marker in the darkest areas and blend the edges while they are wet.'**
  String get ideasOneColorStep4;

  /// No description provided for @ideasOneColorStep5.
  ///
  /// In en, this message translates to:
  /// **'Keep the darkest marker for contact shadows and a few small details.'**
  String get ideasOneColorStep5;

  /// No description provided for @ideasOneColorStep6.
  ///
  /// In en, this message translates to:
  /// **'To darken a tone without changing markers, add another layer of the same one once the first is dry.'**
  String get ideasOneColorStep6;

  /// No description provided for @ideasTwoMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Two-marker challenge'**
  String get ideasTwoMarkersTitle;

  /// No description provided for @ideasTwoMarkersSummary.
  ///
  /// In en, this message translates to:
  /// **'Just one light and one dark marker, nothing else.'**
  String get ideasTwoMarkersSummary;

  /// No description provided for @ideasTwoMarkersPractice.
  ///
  /// In en, this message translates to:
  /// **'Deciding what stays light and what goes dark before you start.'**
  String get ideasTwoMarkersPractice;

  /// No description provided for @ideasTwoMarkersSubject.
  ///
  /// In en, this message translates to:
  /// **'A mushroom, a sitting cat or a house with a roof.'**
  String get ideasTwoMarkersSubject;

  /// No description provided for @ideasTwoMarkersTip.
  ///
  /// In en, this message translates to:
  /// **'With only two markers, the white of the paper does a lot of the work: plan it from the start.'**
  String get ideasTwoMarkersTip;

  /// No description provided for @ideasTwoMarkersStep1.
  ///
  /// In en, this message translates to:
  /// **'Make a small sketch first and decide which areas are light and which are dark.'**
  String get ideasTwoMarkersStep1;

  /// No description provided for @ideasTwoMarkersStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover everything except the highlights with the light marker.'**
  String get ideasTwoMarkersStep2;

  /// No description provided for @ideasTwoMarkersStep3.
  ///
  /// In en, this message translates to:
  /// **'Add a second layer of the light marker on the half-shadows.'**
  String get ideasTwoMarkersStep3;

  /// No description provided for @ideasTwoMarkersStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the dark marker only for the deepest shadows and a few details.'**
  String get ideasTwoMarkersStep4;

  /// No description provided for @ideasTwoMarkersStep5.
  ///
  /// In en, this message translates to:
  /// **'Leave the white paper in the brightest spots: it is your third tone.'**
  String get ideasTwoMarkersStep5;

  /// No description provided for @ideasTwoColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Two opposite colours'**
  String get ideasTwoColorsTitle;

  /// No description provided for @ideasTwoColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Use two opposite colours and one grey, and keep them apart.'**
  String get ideasTwoColorsSummary;

  /// No description provided for @ideasTwoColorsPractice.
  ///
  /// In en, this message translates to:
  /// **'Handling opposite colours, which turn muddy when they overlap.'**
  String get ideasTwoColorsPractice;

  /// No description provided for @ideasTwoColorsSubject.
  ///
  /// In en, this message translates to:
  /// **'An orange on a blue cloth, or a red flower with green leaves.'**
  String get ideasTwoColorsSubject;

  /// No description provided for @ideasTwoColorsTip.
  ///
  /// In en, this message translates to:
  /// **'Two opposite colours layered on top of each other turn grey or brown. Use that only where you want a dull shadow.'**
  String get ideasTwoColorsTip;

  /// No description provided for @ideasTwoColorsStep1.
  ///
  /// In en, this message translates to:
  /// **'Decide which areas belong to each colour and keep them as separate shapes.'**
  String get ideasTwoColorsStep1;

  /// No description provided for @ideasTwoColorsStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the shapes of the first colour, from light to dark.'**
  String get ideasTwoColorsStep2;

  /// No description provided for @ideasTwoColorsStep3.
  ///
  /// In en, this message translates to:
  /// **'Add its shadow while the first layer is still damp.'**
  String get ideasTwoColorsStep3;

  /// No description provided for @ideasTwoColorsStep4.
  ///
  /// In en, this message translates to:
  /// **'Let it dry completely, then colour the shapes of the second colour, stopping at the border.'**
  String get ideasTwoColorsStep4;

  /// No description provided for @ideasTwoColorsStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the shadow of the second colour in the same way.'**
  String get ideasTwoColorsStep5;

  /// No description provided for @ideasTwoColorsStep6.
  ///
  /// In en, this message translates to:
  /// **'Use the grey for shadows that cross from one colour to the other.'**
  String get ideasTwoColorsStep6;

  /// No description provided for @ideasFiftyFiftyTitle.
  ///
  /// In en, this message translates to:
  /// **'Half warm, half cool'**
  String get ideasFiftyFiftyTitle;

  /// No description provided for @ideasFiftyFiftySummary.
  ///
  /// In en, this message translates to:
  /// **'Split one drawing in two: warm colours on one side, cool ones on the other.'**
  String get ideasFiftyFiftySummary;

  /// No description provided for @ideasFiftyFiftyPractice.
  ///
  /// In en, this message translates to:
  /// **'Seeing how warm and cool colours change the mood of the same subject.'**
  String get ideasFiftyFiftyPractice;

  /// No description provided for @ideasFiftyFiftySubject.
  ///
  /// In en, this message translates to:
  /// **'A face or a house split down the middle.'**
  String get ideasFiftyFiftySubject;

  /// No description provided for @ideasFiftyFiftyTip.
  ///
  /// In en, this message translates to:
  /// **'Wet edges run into each other: never let a wet warm area touch a wet cool one.'**
  String get ideasFiftyFiftyTip;

  /// No description provided for @ideasFiftyFiftyStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw your subject and a line that splits it in two.'**
  String get ideasFiftyFiftyStep1;

  /// No description provided for @ideasFiftyFiftyStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the warm half first, from light to dark.'**
  String get ideasFiftyFiftyStep2;

  /// No description provided for @ideasFiftyFiftyStep3.
  ///
  /// In en, this message translates to:
  /// **'Add its shadows and let the whole half dry completely.'**
  String get ideasFiftyFiftyStep3;

  /// No description provided for @ideasFiftyFiftyStep4.
  ///
  /// In en, this message translates to:
  /// **'Colour the cool half, stopping a millimetre short of the line, and close the gap once the other side is dry.'**
  String get ideasFiftyFiftyStep4;

  /// No description provided for @ideasFiftyFiftyStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the cool shadows in the same places as on the warm half.'**
  String get ideasFiftyFiftyStep5;

  /// No description provided for @ideasFiftyFiftyStep6.
  ///
  /// In en, this message translates to:
  /// **'Use the grey only in the darkest spots, so both halves share it.'**
  String get ideasFiftyFiftyStep6;

  /// No description provided for @ideasRandomColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Five random markers'**
  String get ideasRandomColorsTitle;

  /// No description provided for @ideasRandomColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw anything with five markers picked at random from your collection.'**
  String get ideasRandomColorsSummary;

  /// No description provided for @ideasRandomColorsPractice.
  ///
  /// In en, this message translates to:
  /// **'Making any colours work together by controlling light and dark.'**
  String get ideasRandomColorsPractice;

  /// No description provided for @ideasRandomColorsSubject.
  ///
  /// In en, this message translates to:
  /// **'Anything you like: a bird, a teapot or a monster.'**
  String get ideasRandomColorsSubject;

  /// No description provided for @ideasRandomColorsTip.
  ///
  /// In en, this message translates to:
  /// **'Light and dark matter more than colour: a drawing with clear contrast works with almost any colours.'**
  String get ideasRandomColorsTip;

  /// No description provided for @ideasRandomColorsStep1.
  ///
  /// In en, this message translates to:
  /// **'Look at the five markers above: they are sorted from lightest to darkest.'**
  String get ideasRandomColorsStep1;

  /// No description provided for @ideasRandomColorsStep2.
  ///
  /// In en, this message translates to:
  /// **'Use the lightest one for the large lit areas.'**
  String get ideasRandomColorsStep2;

  /// No description provided for @ideasRandomColorsStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the middle ones for the main shapes.'**
  String get ideasRandomColorsStep3;

  /// No description provided for @ideasRandomColorsStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep the darkest one for shadows and outlines.'**
  String get ideasRandomColorsStep4;

  /// No description provided for @ideasRandomColorsStep5.
  ///
  /// In en, this message translates to:
  /// **'If two colours clash, separate them with a thin line of white paper.'**
  String get ideasRandomColorsStep5;

  /// No description provided for @ideasRandomColorsStep6.
  ///
  /// In en, this message translates to:
  /// **'Tap Other markers for a new draw and try again.'**
  String get ideasRandomColorsStep6;

  /// No description provided for @ideasUnlikelyColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unexpected colours'**
  String get ideasUnlikelyColorsTitle;

  /// No description provided for @ideasUnlikelyColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour a familiar object in colours that are not its own.'**
  String get ideasUnlikelyColorsSummary;

  /// No description provided for @ideasUnlikelyColorsPractice.
  ///
  /// In en, this message translates to:
  /// **'Keeping light and dark right so the object still reads, whatever its colour.'**
  String get ideasUnlikelyColorsPractice;

  /// No description provided for @ideasUnlikelyColorsSubject.
  ///
  /// In en, this message translates to:
  /// **'A banana, a dog or your own trainer.'**
  String get ideasUnlikelyColorsSubject;

  /// No description provided for @ideasUnlikelyColorsTip.
  ///
  /// In en, this message translates to:
  /// **'If you squint and the drawing still reads, the light and dark are right, whatever the colours.'**
  String get ideasUnlikelyColorsTip;

  /// No description provided for @ideasUnlikelyColorsStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw the object from life or from a photo and notice where its light and dark areas are.'**
  String get ideasUnlikelyColorsStep1;

  /// No description provided for @ideasUnlikelyColorsStep2.
  ///
  /// In en, this message translates to:
  /// **'Use the lightest marker where the real object is lightest.'**
  String get ideasUnlikelyColorsStep2;

  /// No description provided for @ideasUnlikelyColorsStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the base where the real object has its middle tones.'**
  String get ideasUnlikelyColorsStep3;

  /// No description provided for @ideasUnlikelyColorsStep4.
  ///
  /// In en, this message translates to:
  /// **'Use the shadow marker where the real object is darkest.'**
  String get ideasUnlikelyColorsStep4;

  /// No description provided for @ideasUnlikelyColorsStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the accent in one small area to catch the eye.'**
  String get ideasUnlikelyColorsStep5;

  /// No description provided for @ideasPastelTitle.
  ///
  /// In en, this message translates to:
  /// **'Soft pastels'**
  String get ideasPastelTitle;

  /// No description provided for @ideasPastelSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour a soft, airy drawing with light markers and plenty of white paper.'**
  String get ideasPastelSummary;

  /// No description provided for @ideasPastelPractice.
  ///
  /// In en, this message translates to:
  /// **'Light, even layers and keeping the white of the paper.'**
  String get ideasPastelPractice;

  /// No description provided for @ideasPastelSubject.
  ///
  /// In en, this message translates to:
  /// **'A cupcake, a bunny or a bunch of flowers.'**
  String get ideasPastelSubject;

  /// No description provided for @ideasPastelTip.
  ///
  /// In en, this message translates to:
  /// **'Pressing lightly does not make a marker paler: choose a lighter marker instead.'**
  String get ideasPastelTip;

  /// No description provided for @ideasPastelStep1.
  ///
  /// In en, this message translates to:
  /// **'Pick a gentle subject and keep the pencil lines very light.'**
  String get ideasPastelStep1;

  /// No description provided for @ideasPastelStep2.
  ///
  /// In en, this message translates to:
  /// **'Decide where the paper stays white: the highlights and part of the background.'**
  String get ideasPastelStep2;

  /// No description provided for @ideasPastelStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour each area with one light marker in a single even layer, in small circles.'**
  String get ideasPastelStep3;

  /// No description provided for @ideasPastelStep4.
  ///
  /// In en, this message translates to:
  /// **'Make the shadow with a second layer of the same marker, not with a darker colour.'**
  String get ideasPastelStep4;

  /// No description provided for @ideasPastelStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the slightly deeper marker only for the smallest shadows.'**
  String get ideasPastelStep5;

  /// No description provided for @ideasPastelStep6.
  ///
  /// In en, this message translates to:
  /// **'Soften any hard edge with the colourless blender.'**
  String get ideasPastelStep6;

  /// No description provided for @ideasSkinTonesTitle.
  ///
  /// In en, this message translates to:
  /// **'Skin with four markers'**
  String get ideasSkinTonesTitle;

  /// No description provided for @ideasSkinTonesSummary.
  ///
  /// In en, this message translates to:
  /// **'Colour a face with a light tone, a base, a shadow and a blush.'**
  String get ideasSkinTonesSummary;

  /// No description provided for @ideasSkinTonesPractice.
  ///
  /// In en, this message translates to:
  /// **'Soft skin blending and warm shadows on a face.'**
  String get ideasSkinTonesPractice;

  /// No description provided for @ideasSkinTonesSubject.
  ///
  /// In en, this message translates to:
  /// **'A face in three-quarter view, lit from one side.'**
  String get ideasSkinTonesSubject;

  /// No description provided for @ideasSkinTonesTip.
  ///
  /// In en, this message translates to:
  /// **'Skin shadows are warm: avoid greys, they make the face look dirty.'**
  String get ideasSkinTonesTip;

  /// No description provided for @ideasSkinTonesStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw the face lightly and mark the shadow shapes: under the brow, beside the nose, under the lip and along the jaw.'**
  String get ideasSkinTonesStep1;

  /// No description provided for @ideasSkinTonesStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover all the skin with the light marker, leaving the brightest spots of the forehead, nose and cheek as white paper.'**
  String get ideasSkinTonesStep2;

  /// No description provided for @ideasSkinTonesStep3.
  ///
  /// In en, this message translates to:
  /// **'While it is damp, add the blush on the cheeks, the tip of the nose and the ears.'**
  String get ideasSkinTonesStep3;

  /// No description provided for @ideasSkinTonesStep4.
  ///
  /// In en, this message translates to:
  /// **'Put the base on the shadow shapes and blend their edges with the light marker.'**
  String get ideasSkinTonesStep4;

  /// No description provided for @ideasSkinTonesStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the shadow marker only where shapes meet: under the chin, inside the ear and around the nostrils.'**
  String get ideasSkinTonesStep5;

  /// No description provided for @ideasSkinTonesStep6.
  ///
  /// In en, this message translates to:
  /// **'Soften any hard line with the light marker rather than the colourless blender, so the skin does not go blotchy.'**
  String get ideasSkinTonesStep6;

  /// No description provided for @ideasMidnightTitle.
  ///
  /// In en, this message translates to:
  /// **'Moonlit night'**
  String get ideasMidnightTitle;

  /// No description provided for @ideasMidnightSummary.
  ///
  /// In en, this message translates to:
  /// **'A small house at night, lit by the moon and one warm window.'**
  String get ideasMidnightSummary;

  /// No description provided for @ideasMidnightPractice.
  ///
  /// In en, this message translates to:
  /// **'Planning a night scene: cool shadows and a few clean, warm lights.'**
  String get ideasMidnightPractice;

  /// No description provided for @ideasMidnightSubject.
  ///
  /// In en, this message translates to:
  /// **'A small house at night with one lit window.'**
  String get ideasMidnightSubject;

  /// No description provided for @ideasMidnightTip.
  ///
  /// In en, this message translates to:
  /// **'Do not let the blue and the yellow touch while either is wet: together they turn green.'**
  String get ideasMidnightTip;

  /// No description provided for @ideasMidnightStep1.
  ///
  /// In en, this message translates to:
  /// **'Before you start, decide where the lights are: the moon and the window stay white paper.'**
  String get ideasMidnightStep1;

  /// No description provided for @ideasMidnightStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the window and a soft glow around it with the yellow, and let it dry completely.'**
  String get ideasMidnightStep2;

  /// No description provided for @ideasMidnightStep3.
  ///
  /// In en, this message translates to:
  /// **'Cover the sky and the lit walls with the light blue, working away from the moon.'**
  String get ideasMidnightStep3;

  /// No description provided for @ideasMidnightStep4.
  ///
  /// In en, this message translates to:
  /// **'Add the base blue to everything in shadow, a few millimetres away from the yellow glow.'**
  String get ideasMidnightStep4;

  /// No description provided for @ideasMidnightStep5.
  ///
  /// In en, this message translates to:
  /// **'Darken the sky towards the top and the shadows under the roof and the trees.'**
  String get ideasMidnightStep5;

  /// No description provided for @ideasMidnightStep6.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest marker for the deepest shadows and, once dry, add a few stars with white gel.'**
  String get ideasMidnightStep6;

  /// No description provided for @ideasUnderwaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Under the sea'**
  String get ideasUnderwaterTitle;

  /// No description provided for @ideasUnderwaterSummary.
  ///
  /// In en, this message translates to:
  /// **'Sunbeams in blue water around a small fish.'**
  String get ideasUnderwaterSummary;

  /// No description provided for @ideasUnderwaterPractice.
  ///
  /// In en, this message translates to:
  /// **'Lifting rays of light with the colourless blender.'**
  String get ideasUnderwaterPractice;

  /// No description provided for @ideasUnderwaterSubject.
  ///
  /// In en, this message translates to:
  /// **'A small fish swimming above a coral.'**
  String get ideasUnderwaterSubject;

  /// No description provided for @ideasUnderwaterTip.
  ///
  /// In en, this message translates to:
  /// **'Try the blender rays on a scrap first: they only work while the ink is still slightly damp.'**
  String get ideasUnderwaterTip;

  /// No description provided for @ideasUnderwaterStep1.
  ///
  /// In en, this message translates to:
  /// **'Colour the fish and the coral first with the accent and let them dry.'**
  String get ideasUnderwaterStep1;

  /// No description provided for @ideasUnderwaterStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover the water with the light blue, stopping just short of the fish.'**
  String get ideasUnderwaterStep2;

  /// No description provided for @ideasUnderwaterStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the base blue to the lower half and blend it upwards while it is wet.'**
  String get ideasUnderwaterStep3;

  /// No description provided for @ideasUnderwaterStep4.
  ///
  /// In en, this message translates to:
  /// **'Darken the bottom and the area behind the fish so it stands out.'**
  String get ideasUnderwaterStep4;

  /// No description provided for @ideasUnderwaterStep5.
  ///
  /// In en, this message translates to:
  /// **'While the blues are still damp, pull diagonal rays down from the surface with the colourless blender: it pushes the ink away.'**
  String get ideasUnderwaterStep5;

  /// No description provided for @ideasUnderwaterStep6.
  ///
  /// In en, this message translates to:
  /// **'Add the darkest marker at the very bottom and, once dry, finish with tiny bubbles in white gel.'**
  String get ideasUnderwaterStep6;

  /// No description provided for @ideasGalaxyTitle.
  ///
  /// In en, this message translates to:
  /// **'Galaxy'**
  String get ideasGalaxyTitle;

  /// No description provided for @ideasGalaxySummary.
  ///
  /// In en, this message translates to:
  /// **'Blend glowing nebula colours into a dark sky and finish with stars.'**
  String get ideasGalaxySummary;

  /// No description provided for @ideasGalaxyPractice.
  ///
  /// In en, this message translates to:
  /// **'Blending wet into wet, and lifting ink to make stars.'**
  String get ideasGalaxyPractice;

  /// No description provided for @ideasGalaxySubject.
  ///
  /// In en, this message translates to:
  /// **'A nebula over the silhouette of a mountain.'**
  String get ideasGalaxySubject;

  /// No description provided for @ideasGalaxyTip.
  ///
  /// In en, this message translates to:
  /// **'Keep the big stars to a handful: too many flatten the depth.'**
  String get ideasGalaxyTip;

  /// No description provided for @ideasGalaxyStep1.
  ///
  /// In en, this message translates to:
  /// **'Use marker paper that does not bleed through and put a sheet underneath: this exercise takes a lot of ink.'**
  String get ideasGalaxyStep1;

  /// No description provided for @ideasGalaxyStep2.
  ///
  /// In en, this message translates to:
  /// **'Start with the lightest nebula colours in soft, irregular clouds.'**
  String get ideasGalaxyStep2;

  /// No description provided for @ideasGalaxyStep3.
  ///
  /// In en, this message translates to:
  /// **'While they are still wet, blend the middle colour into their edges.'**
  String get ideasGalaxyStep3;

  /// No description provided for @ideasGalaxyStep4.
  ///
  /// In en, this message translates to:
  /// **'Fill the rest of the sky with the darkest markers, working towards the clouds, not over them.'**
  String get ideasGalaxyStep4;

  /// No description provided for @ideasGalaxyStep5.
  ///
  /// In en, this message translates to:
  /// **'Dab the colourless blender on the dark areas to lift little dots of ink: they will be distant stars.'**
  String get ideasGalaxyStep5;

  /// No description provided for @ideasGalaxyStep6.
  ///
  /// In en, this message translates to:
  /// **'Once dry, add a few bright stars and a cross-shaped sparkle with white gel.'**
  String get ideasGalaxyStep6;

  /// No description provided for @ideasNeonTitle.
  ///
  /// In en, this message translates to:
  /// **'Neon sign'**
  String get ideasNeonTitle;

  /// No description provided for @ideasNeonSummary.
  ///
  /// In en, this message translates to:
  /// **'Make a sign glow with a white core and a dark background.'**
  String get ideasNeonSummary;

  /// No description provided for @ideasNeonPractice.
  ///
  /// In en, this message translates to:
  /// **'Glow: a white core, a bright halo and a dark background.'**
  String get ideasNeonPractice;

  /// No description provided for @ideasNeonSubject.
  ///
  /// In en, this message translates to:
  /// **'The word OPEN, or a heart drawn as a neon tube.'**
  String get ideasNeonSubject;

  /// No description provided for @ideasNeonTip.
  ///
  /// In en, this message translates to:
  /// **'Fluorescent markers are see-through: use them on white, never over dark ink.'**
  String get ideasNeonTip;

  /// No description provided for @ideasNeonStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw a simple word or shape in pencil with thick strokes.'**
  String get ideasNeonStep1;

  /// No description provided for @ideasNeonStep2.
  ///
  /// In en, this message translates to:
  /// **'Leave a thin line of white paper in the middle of each stroke: that is the hot core.'**
  String get ideasNeonStep2;

  /// No description provided for @ideasNeonStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the rest of the stroke with the light version of your neon colour.'**
  String get ideasNeonStep3;

  /// No description provided for @ideasNeonStep4.
  ///
  /// In en, this message translates to:
  /// **'Flick the bright colour outwards from the stroke to make a soft halo.'**
  String get ideasNeonStep4;

  /// No description provided for @ideasNeonStep5.
  ///
  /// In en, this message translates to:
  /// **'When the halo is dry, fill the background with the darkest marker, stopping a few millimetres from the halo.'**
  String get ideasNeonStep5;

  /// No description provided for @ideasNeonStep6.
  ///
  /// In en, this message translates to:
  /// **'Blend that gap with the dark marker so the glow fades into the night.'**
  String get ideasNeonStep6;

  /// No description provided for @ideasSepiaPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Old sepia photo'**
  String get ideasSepiaPhotoTitle;

  /// No description provided for @ideasSepiaPhotoSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw a portrait or a building as if it were an old brown photograph.'**
  String get ideasSepiaPhotoSummary;

  /// No description provided for @ideasSepiaPhotoPractice.
  ///
  /// In en, this message translates to:
  /// **'Working with one warm family of browns, like a light-and-dark study in colour.'**
  String get ideasSepiaPhotoPractice;

  /// No description provided for @ideasSepiaPhotoSubject.
  ///
  /// In en, this message translates to:
  /// **'An old house, a cowboy hat or a portrait of a grandparent.'**
  String get ideasSepiaPhotoSubject;

  /// No description provided for @ideasSepiaPhotoTip.
  ///
  /// In en, this message translates to:
  /// **'Avoid black and cool greys: they break the warm sepia look.'**
  String get ideasSepiaPhotoTip;

  /// No description provided for @ideasSepiaPhotoStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the subject and frame it with a border that stays white paper.'**
  String get ideasSepiaPhotoStep1;

  /// No description provided for @ideasSepiaPhotoStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover everything except the brightest spots with the lightest brown.'**
  String get ideasSepiaPhotoStep2;

  /// No description provided for @ideasSepiaPhotoStep3.
  ///
  /// In en, this message translates to:
  /// **'Build the middle tones with the base brown.'**
  String get ideasSepiaPhotoStep3;

  /// No description provided for @ideasSepiaPhotoStep4.
  ///
  /// In en, this message translates to:
  /// **'Add the shadows with the shadow brown, blending the edges while they are wet.'**
  String get ideasSepiaPhotoStep4;

  /// No description provided for @ideasSepiaPhotoStep5.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest brown instead of black for the deepest shadows.'**
  String get ideasSepiaPhotoStep5;

  /// No description provided for @ideasSepiaPhotoStep6.
  ///
  /// In en, this message translates to:
  /// **'Darken the corners of the picture slightly with the warm grey to make it look old.'**
  String get ideasSepiaPhotoStep6;

  /// No description provided for @ideasSunsetTitle.
  ///
  /// In en, this message translates to:
  /// **'Sunset sky'**
  String get ideasSunsetTitle;

  /// No description provided for @ideasSunsetSummary.
  ///
  /// In en, this message translates to:
  /// **'Blend a sky from yellow to violet and add a dark silhouette.'**
  String get ideasSunsetSummary;

  /// No description provided for @ideasSunsetPractice.
  ///
  /// In en, this message translates to:
  /// **'Blending neighbouring colours wet into wet over a large area.'**
  String get ideasSunsetPractice;

  /// No description provided for @ideasSunsetSubject.
  ///
  /// In en, this message translates to:
  /// **'A sunset over the sea with a palm tree or a city skyline in silhouette.'**
  String get ideasSunsetSubject;

  /// No description provided for @ideasSunsetTip.
  ///
  /// In en, this message translates to:
  /// **'Only blend neighbouring colours: yellow next to violet turns brownish while wet.'**
  String get ideasSunsetTip;

  /// No description provided for @ideasSunsetStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the horizon and the silhouette; keep the sun as a circle of white paper.'**
  String get ideasSunsetStep1;

  /// No description provided for @ideasSunsetStep2.
  ///
  /// In en, this message translates to:
  /// **'Start at the sun: colour a wide band of yellow around it.'**
  String get ideasSunsetStep2;

  /// No description provided for @ideasSunsetStep3.
  ///
  /// In en, this message translates to:
  /// **'While the yellow is wet, add the orange above it and blend the join.'**
  String get ideasSunsetStep3;

  /// No description provided for @ideasSunsetStep4.
  ///
  /// In en, this message translates to:
  /// **'Carry on upwards with the pink, blending each band into the last while it is wet.'**
  String get ideasSunsetStep4;

  /// No description provided for @ideasSunsetStep5.
  ///
  /// In en, this message translates to:
  /// **'Finish the top of the sky with the violet.'**
  String get ideasSunsetStep5;

  /// No description provided for @ideasSunsetStep6.
  ///
  /// In en, this message translates to:
  /// **'When the sky is dry, fill the silhouette with the darkest marker in flat, even strokes.'**
  String get ideasSunsetStep6;

  /// No description provided for @ideasSpringTitle.
  ///
  /// In en, this message translates to:
  /// **'Spring blossom'**
  String get ideasSpringTitle;

  /// No description provided for @ideasSpringSummary.
  ///
  /// In en, this message translates to:
  /// **'A branch of cherry blossom with soft pink petals.'**
  String get ideasSpringSummary;

  /// No description provided for @ideasSpringPractice.
  ///
  /// In en, this message translates to:
  /// **'Delicate petals: light layers and soft edges.'**
  String get ideasSpringPractice;

  /// No description provided for @ideasSpringSubject.
  ///
  /// In en, this message translates to:
  /// **'A branch with five or six blossoms and a few leaves.'**
  String get ideasSpringSubject;

  /// No description provided for @ideasSpringTip.
  ///
  /// In en, this message translates to:
  /// **'Petals are thin: two light layers look more delicate than one dark one.'**
  String get ideasSpringTip;

  /// No description provided for @ideasSpringStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw the branch and the flowers lightly, with five petals each.'**
  String get ideasSpringStep1;

  /// No description provided for @ideasSpringStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour each petal with the light pink, leaving a thin white edge on some of them.'**
  String get ideasSpringStep2;

  /// No description provided for @ideasSpringStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the base pink near the centre of each flower, flicking outwards.'**
  String get ideasSpringStep3;

  /// No description provided for @ideasSpringStep4.
  ///
  /// In en, this message translates to:
  /// **'Touch the deepest pink only in the centre and where petals overlap.'**
  String get ideasSpringStep4;

  /// No description provided for @ideasSpringStep5.
  ///
  /// In en, this message translates to:
  /// **'Colour the leaves and the young shoots with the green.'**
  String get ideasSpringStep5;

  /// No description provided for @ideasSpringStep6.
  ///
  /// In en, this message translates to:
  /// **'Shade the underside of the leaves with the dark green.'**
  String get ideasSpringStep6;

  /// No description provided for @ideasAutumnTitle.
  ///
  /// In en, this message translates to:
  /// **'Autumn leaves'**
  String get ideasAutumnTitle;

  /// No description provided for @ideasAutumnSummary.
  ///
  /// In en, this message translates to:
  /// **'A still life of fallen leaves in warm, glowing colours.'**
  String get ideasAutumnSummary;

  /// No description provided for @ideasAutumnPractice.
  ///
  /// In en, this message translates to:
  /// **'Blending neighbouring warm colours and keeping the veins light.'**
  String get ideasAutumnPractice;

  /// No description provided for @ideasAutumnSubject.
  ///
  /// In en, this message translates to:
  /// **'Three fallen leaves on a table: oak, maple and chestnut.'**
  String get ideasAutumnSubject;

  /// No description provided for @ideasAutumnTip.
  ///
  /// In en, this message translates to:
  /// **'Leave the veins as a lighter line: it is easier than drawing them on top later.'**
  String get ideasAutumnTip;

  /// No description provided for @ideasAutumnStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw the leaves and their main veins in light pencil.'**
  String get ideasAutumnStep1;

  /// No description provided for @ideasAutumnStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the lightest leaf with the yellow, going around the veins so they stay light.'**
  String get ideasAutumnStep2;

  /// No description provided for @ideasAutumnStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the next leaf with the light orange and blend a little yellow into its edges while wet.'**
  String get ideasAutumnStep3;

  /// No description provided for @ideasAutumnStep4.
  ///
  /// In en, this message translates to:
  /// **'Colour the third leaf with the base and blend the light orange into its tip.'**
  String get ideasAutumnStep4;

  /// No description provided for @ideasAutumnStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the red along the edges and in a few patches, as if the leaf were changing colour.'**
  String get ideasAutumnStep5;

  /// No description provided for @ideasAutumnStep6.
  ///
  /// In en, this message translates to:
  /// **'Shade where the leaves overlap and where they touch the table with the dark orange.'**
  String get ideasAutumnStep6;

  /// No description provided for @ideasWinterTitle.
  ///
  /// In en, this message translates to:
  /// **'Snowy cabin'**
  String get ideasWinterTitle;

  /// No description provided for @ideasWinterSummary.
  ///
  /// In en, this message translates to:
  /// **'A cabin in the snow where the white is the paper itself.'**
  String get ideasWinterSummary;

  /// No description provided for @ideasWinterPractice.
  ///
  /// In en, this message translates to:
  /// **'Drawing snow with blue-grey shadows and lots of white paper.'**
  String get ideasWinterPractice;

  /// No description provided for @ideasWinterSubject.
  ///
  /// In en, this message translates to:
  /// **'A wooden cabin with snow on the roof and one lit window.'**
  String get ideasWinterSubject;

  /// No description provided for @ideasWinterTip.
  ///
  /// In en, this message translates to:
  /// **'Do not shade snow with warm grey: blue-greys make it look cold and clean.'**
  String get ideasWinterTip;

  /// No description provided for @ideasWinterStep1.
  ///
  /// In en, this message translates to:
  /// **'Pencil the cabin and where the snow ends: the snow is white paper, so plan it first.'**
  String get ideasWinterStep1;

  /// No description provided for @ideasWinterStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the window with the yellow and let it dry.'**
  String get ideasWinterStep2;

  /// No description provided for @ideasWinterStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the wooden walls with the brown without touching the snow on the roof.'**
  String get ideasWinterStep3;

  /// No description provided for @ideasWinterStep4.
  ///
  /// In en, this message translates to:
  /// **'Shade the snow with the light blue-grey only where the light does not reach.'**
  String get ideasWinterStep4;

  /// No description provided for @ideasWinterStep5.
  ///
  /// In en, this message translates to:
  /// **'Add the darker blue-grey under the roof and in the footprints, blending it into the light one.'**
  String get ideasWinterStep5;

  /// No description provided for @ideasWinterStep6.
  ///
  /// In en, this message translates to:
  /// **'Use the darkest marker for the door and the deepest shadows and, once dry, add falling snow with white gel.'**
  String get ideasWinterStep6;

  /// No description provided for @ideasChristmasTitle.
  ///
  /// In en, this message translates to:
  /// **'Christmas baubles'**
  String get ideasChristmasTitle;

  /// No description provided for @ideasChristmasSummary.
  ///
  /// In en, this message translates to:
  /// **'Shiny red baubles hanging from a green fir branch.'**
  String get ideasChristmasSummary;

  /// No description provided for @ideasChristmasPractice.
  ///
  /// In en, this message translates to:
  /// **'Round, shiny shapes with a kept highlight and reflections.'**
  String get ideasChristmasPractice;

  /// No description provided for @ideasChristmasSubject.
  ///
  /// In en, this message translates to:
  /// **'Two red baubles hanging from a fir branch.'**
  String get ideasChristmasSubject;

  /// No description provided for @ideasChristmasTip.
  ///
  /// In en, this message translates to:
  /// **'Draw the branch after the baubles, so the green never runs into the red.'**
  String get ideasChristmasTip;

  /// No description provided for @ideasChristmasStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw the baubles and plan a window-shaped highlight on each one.'**
  String get ideasChristmasStep1;

  /// No description provided for @ideasChristmasStep2.
  ///
  /// In en, this message translates to:
  /// **'Cover each bauble with the light red, going around the highlight.'**
  String get ideasChristmasStep2;

  /// No description provided for @ideasChristmasStep3.
  ///
  /// In en, this message translates to:
  /// **'Add the base red in a ring that follows the round shape, leaving the middle lighter.'**
  String get ideasChristmasStep3;

  /// No description provided for @ideasChristmasStep4.
  ///
  /// In en, this message translates to:
  /// **'Darken the edge furthest from the light, keeping a thin lighter rim for the reflection.'**
  String get ideasChristmasStep4;

  /// No description provided for @ideasChristmasStep5.
  ///
  /// In en, this message translates to:
  /// **'Flick the needles of the branch with the green, from the stem outwards.'**
  String get ideasChristmasStep5;

  /// No description provided for @ideasChristmasStep6.
  ///
  /// In en, this message translates to:
  /// **'Add the dark green where the needles overlap and, once dry, a white gel sparkle on each bauble.'**
  String get ideasChristmasStep6;

  /// No description provided for @ideasHalloweenTitle.
  ///
  /// In en, this message translates to:
  /// **'Halloween pumpkin'**
  String get ideasHalloweenTitle;

  /// No description provided for @ideasHalloweenSummary.
  ///
  /// In en, this message translates to:
  /// **'A glowing carved pumpkin in a dark violet night.'**
  String get ideasHalloweenSummary;

  /// No description provided for @ideasHalloweenPractice.
  ///
  /// In en, this message translates to:
  /// **'Light coming from inside an object, against a dark background.'**
  String get ideasHalloweenPractice;

  /// No description provided for @ideasHalloweenSubject.
  ///
  /// In en, this message translates to:
  /// **'A carved pumpkin with a candle inside, on a doorstep.'**
  String get ideasHalloweenSubject;

  /// No description provided for @ideasHalloweenTip.
  ///
  /// In en, this message translates to:
  /// **'Lay the dark background last and slowly near the edge: dark ink runs into light areas.'**
  String get ideasHalloweenTip;

  /// No description provided for @ideasHalloweenStep1.
  ///
  /// In en, this message translates to:
  /// **'Draw the pumpkin and its carved face; the inside of the face will be the brightest part.'**
  String get ideasHalloweenStep1;

  /// No description provided for @ideasHalloweenStep2.
  ///
  /// In en, this message translates to:
  /// **'Colour the carved holes with the light orange, leaving a white core in the middle.'**
  String get ideasHalloweenStep2;

  /// No description provided for @ideasHalloweenStep3.
  ///
  /// In en, this message translates to:
  /// **'Colour the pumpkin with the base orange, following its ribs with curved strokes.'**
  String get ideasHalloweenStep3;

  /// No description provided for @ideasHalloweenStep4.
  ///
  /// In en, this message translates to:
  /// **'Shade the grooves between the ribs and the side away from the glow.'**
  String get ideasHalloweenStep4;

  /// No description provided for @ideasHalloweenStep5.
  ///
  /// In en, this message translates to:
  /// **'Colour the stalk with the green.'**
  String get ideasHalloweenStep5;

  /// No description provided for @ideasHalloweenStep6.
  ///
  /// In en, this message translates to:
  /// **'When everything is dry, fill the night with the dark violet, starting a few millimetres away from the pumpkin.'**
  String get ideasHalloweenStep6;

  /// No description provided for @ideasRoleLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get ideasRoleLight;

  /// No description provided for @ideasReasonLight.
  ///
  /// In en, this message translates to:
  /// **'First layer, over almost everything'**
  String get ideasReasonLight;

  /// No description provided for @ideasRoleLightMid.
  ///
  /// In en, this message translates to:
  /// **'Light mid'**
  String get ideasRoleLightMid;

  /// No description provided for @ideasReasonLightMid.
  ///
  /// In en, this message translates to:
  /// **'Second step, softens the jump to the base'**
  String get ideasReasonLightMid;

  /// No description provided for @ideasRoleBase.
  ///
  /// In en, this message translates to:
  /// **'Base'**
  String get ideasRoleBase;

  /// No description provided for @ideasReasonBase.
  ///
  /// In en, this message translates to:
  /// **'Main colour of the shapes'**
  String get ideasReasonBase;

  /// No description provided for @ideasRoleShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow'**
  String get ideasRoleShadow;

  /// No description provided for @ideasReasonShadow.
  ///
  /// In en, this message translates to:
  /// **'Where the light does not reach'**
  String get ideasReasonShadow;

  /// No description provided for @ideasRoleDeepShadow.
  ///
  /// In en, this message translates to:
  /// **'Deep shadow'**
  String get ideasRoleDeepShadow;

  /// No description provided for @ideasReasonDeepShadow.
  ///
  /// In en, this message translates to:
  /// **'Only the darkest corners and contact lines'**
  String get ideasReasonDeepShadow;

  /// No description provided for @ideasRoleShadowGray.
  ///
  /// In en, this message translates to:
  /// **'Shadow grey'**
  String get ideasRoleShadowGray;

  /// No description provided for @ideasReasonShadowGray.
  ///
  /// In en, this message translates to:
  /// **'Neutral shadows and cast shadows'**
  String get ideasReasonShadowGray;

  /// No description provided for @ideasRoleAccent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get ideasRoleAccent;

  /// No description provided for @ideasReasonAccent.
  ///
  /// In en, this message translates to:
  /// **'Small touches that draw the eye'**
  String get ideasReasonAccent;

  /// No description provided for @ideasRoleBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get ideasRoleBackground;

  /// No description provided for @ideasReasonBackground.
  ///
  /// In en, this message translates to:
  /// **'Around the subject, laid last'**
  String get ideasReasonBackground;

  /// No description provided for @ideasRoleMainColor.
  ///
  /// In en, this message translates to:
  /// **'Main colour'**
  String get ideasRoleMainColor;

  /// No description provided for @ideasReasonMainColor.
  ///
  /// In en, this message translates to:
  /// **'First colour of the pair'**
  String get ideasReasonMainColor;

  /// No description provided for @ideasRoleMainShadow.
  ///
  /// In en, this message translates to:
  /// **'Main shadow'**
  String get ideasRoleMainShadow;

  /// No description provided for @ideasReasonMainShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow of the first colour'**
  String get ideasReasonMainShadow;

  /// No description provided for @ideasRoleSecondColor.
  ///
  /// In en, this message translates to:
  /// **'Second colour'**
  String get ideasRoleSecondColor;

  /// No description provided for @ideasReasonSecondColor.
  ///
  /// In en, this message translates to:
  /// **'Second colour of the scheme'**
  String get ideasReasonSecondColor;

  /// No description provided for @ideasRoleSecondShadow.
  ///
  /// In en, this message translates to:
  /// **'Second shadow'**
  String get ideasRoleSecondShadow;

  /// No description provided for @ideasReasonSecondShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow of the second colour'**
  String get ideasReasonSecondShadow;

  /// No description provided for @ideasRoleThirdColor.
  ///
  /// In en, this message translates to:
  /// **'Third colour'**
  String get ideasRoleThirdColor;

  /// No description provided for @ideasReasonThirdColor.
  ///
  /// In en, this message translates to:
  /// **'Third colour of the scheme'**
  String get ideasReasonThirdColor;

  /// No description provided for @ideasRoleBlush.
  ///
  /// In en, this message translates to:
  /// **'Blush'**
  String get ideasRoleBlush;

  /// No description provided for @ideasReasonBlush.
  ///
  /// In en, this message translates to:
  /// **'Cheeks, nose and ears, blended while wet'**
  String get ideasReasonBlush;

  /// No description provided for @ideasRoleWarmLight.
  ///
  /// In en, this message translates to:
  /// **'Warm light'**
  String get ideasRoleWarmLight;

  /// No description provided for @ideasReasonWarmLight.
  ///
  /// In en, this message translates to:
  /// **'Lit areas of the warm half'**
  String get ideasReasonWarmLight;

  /// No description provided for @ideasRoleWarmShadow.
  ///
  /// In en, this message translates to:
  /// **'Warm shadow'**
  String get ideasRoleWarmShadow;

  /// No description provided for @ideasReasonWarmShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadows of the warm half'**
  String get ideasReasonWarmShadow;

  /// No description provided for @ideasRoleCoolLight.
  ///
  /// In en, this message translates to:
  /// **'Cool light'**
  String get ideasRoleCoolLight;

  /// No description provided for @ideasReasonCoolLight.
  ///
  /// In en, this message translates to:
  /// **'Lit areas of the cool half'**
  String get ideasReasonCoolLight;

  /// No description provided for @ideasRoleCoolShadow.
  ///
  /// In en, this message translates to:
  /// **'Cool shadow'**
  String get ideasRoleCoolShadow;

  /// No description provided for @ideasReasonCoolShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadows of the cool half'**
  String get ideasReasonCoolShadow;

  /// No description provided for @ideasRoleColorShadow.
  ///
  /// In en, this message translates to:
  /// **'Colour shadow'**
  String get ideasRoleColorShadow;

  /// No description provided for @ideasReasonColorShadow.
  ///
  /// In en, this message translates to:
  /// **'A coloured shadow to compare with the grey one'**
  String get ideasReasonColorShadow;

  /// No description provided for @matchTitle.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get matchTitle;

  /// No description provided for @matchPrivacyCaption.
  ///
  /// In en, this message translates to:
  /// **'Photos stay on this phone.'**
  String get matchPrivacyCaption;

  /// No description provided for @matchCameraButton.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get matchCameraButton;

  /// No description provided for @matchGalleryButton.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get matchGalleryButton;

  /// No description provided for @matchLoadingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Reading photo…'**
  String get matchLoadingPhoto;

  /// No description provided for @matchEmptyPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Match a colour from a photo'**
  String get matchEmptyPhotoTitle;

  /// No description provided for @matchEmptyPhotoMessage.
  ///
  /// In en, this message translates to:
  /// **'Photograph something, tap a colour on it and see the closest markers.'**
  String get matchEmptyPhotoMessage;

  /// No description provided for @matchPhotoSemantics.
  ///
  /// In en, this message translates to:
  /// **'Photo to sample a colour from'**
  String get matchPhotoSemantics;

  /// No description provided for @matchPickToSample.
  ///
  /// In en, this message translates to:
  /// **'Tap or drag on the photo to sample a colour.'**
  String get matchPickToSample;

  /// No description provided for @matchSampledLabel.
  ///
  /// In en, this message translates to:
  /// **'Sampled'**
  String get matchSampledLabel;

  /// No description provided for @matchBestMatchTitle.
  ///
  /// In en, this message translates to:
  /// **'Best match'**
  String get matchBestMatchTitle;

  /// No description provided for @matchAlternatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Alternatives'**
  String get matchAlternatesTitle;

  /// No description provided for @matchSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get matchSaveButton;

  /// No description provided for @matchRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent picks'**
  String get matchRecentTitle;

  /// No description provided for @matchRecentDetailSampled.
  ///
  /// In en, this message translates to:
  /// **'Sampled'**
  String get matchRecentDetailSampled;

  /// No description provided for @matchRecentEmpty.
  ///
  /// In en, this message translates to:
  /// **'No recent picks yet. Tap a match to save it here.'**
  String get matchRecentEmpty;

  /// No description provided for @matchClearButton.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get matchClearButton;

  /// No description provided for @matchRemoveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get matchRemoveTooltip;

  /// No description provided for @matchCloseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get matchCloseTooltip;

  /// No description provided for @matchRecentPickLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent pick'**
  String get matchRecentPickLabel;

  /// No description provided for @matchClearDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear recent picks?'**
  String get matchClearDialogTitle;

  /// No description provided for @matchClearDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Every saved pick is removed. This cannot be undone.'**
  String get matchClearDialogBody;

  /// No description provided for @matchCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get matchCancelButton;

  /// No description provided for @matchCancelNotice.
  ///
  /// In en, this message translates to:
  /// **'No photo selected.'**
  String get matchCancelNotice;

  /// No description provided for @matchCameraDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera access is off. Allow it in your device settings, or pick a photo from the gallery instead.'**
  String get matchCameraDenied;

  /// No description provided for @matchGalleryDenied.
  ///
  /// In en, this message translates to:
  /// **'Photo access is off. Allow it in your device settings, then try again.'**
  String get matchGalleryDenied;

  /// No description provided for @matchDecodeFailed.
  ///
  /// In en, this message translates to:
  /// **'That photo could not be read. Try another one.'**
  String get matchDecodeFailed;

  /// No description provided for @matchPickFailed.
  ///
  /// In en, this message translates to:
  /// **'The photo could not be opened. Try again.'**
  String get matchPickFailed;

  /// No description provided for @matchOkButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get matchOkButton;

  /// No description provided for @matchTakePhotoButton.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get matchTakePhotoButton;

  /// No description provided for @matchChooseGalleryButton.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get matchChooseGalleryButton;

  /// No description provided for @matchValuesButton.
  ///
  /// In en, this message translates to:
  /// **'Values'**
  String get matchValuesButton;

  /// No description provided for @matchValuesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show the photo and the matches in greyscale to check their value contrast'**
  String get matchValuesTooltip;

  /// No description provided for @matchPhotoSampleHint.
  ///
  /// In en, this message translates to:
  /// **'Double-tap to sample the middle of the photo. Use the actions to move the sample point.'**
  String get matchPhotoSampleHint;

  /// No description provided for @matchSampleMiddle.
  ///
  /// In en, this message translates to:
  /// **'Sample the middle of the photo'**
  String get matchSampleMiddle;

  /// No description provided for @matchMoveLeft.
  ///
  /// In en, this message translates to:
  /// **'Move the sample point left'**
  String get matchMoveLeft;

  /// No description provided for @matchMoveRight.
  ///
  /// In en, this message translates to:
  /// **'Move the sample point right'**
  String get matchMoveRight;

  /// No description provided for @matchMoveUp.
  ///
  /// In en, this message translates to:
  /// **'Move the sample point up'**
  String get matchMoveUp;

  /// No description provided for @matchMoveDown.
  ///
  /// In en, this message translates to:
  /// **'Move the sample point down'**
  String get matchMoveDown;

  /// No description provided for @matchSampleSpoken.
  ///
  /// In en, this message translates to:
  /// **'Sampled colour {hex}. Closest marker: {code}, {name}, {quality}.'**
  String matchSampleSpoken(
    String hex,
    String code,
    String name,
    String quality,
  );

  /// No description provided for @matchSampleSpokenNone.
  ///
  /// In en, this message translates to:
  /// **'Sampled colour {hex}.'**
  String matchSampleSpokenNone(String hex);

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ink Lab'**
  String get appTitle;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonOwned.
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get commonOwned;

  /// No description provided for @commonFavourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get commonFavourite;

  /// No description provided for @commonAddToFavourites.
  ///
  /// In en, this message translates to:
  /// **'Add to favourites'**
  String get commonAddToFavourites;

  /// No description provided for @commonRemoveFromFavourites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favourites'**
  String get commonRemoveFromFavourites;

  /// No description provided for @commonClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get commonClearSearch;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// Tooltip of the three-dot overflow button that opens a menu with the secondary actions of a card, sheet or screen.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get commonMoreActions;

  /// One-line colour match quality: the CIELAB distance and the quality word, for example 'ΔE 10.8 · Rough'.
  ///
  /// In en, this message translates to:
  /// **'ΔE {value} · {quality}'**
  String commonQualityLine(double value, String quality);

  /// No description provided for @commonBaseLocked.
  ///
  /// In en, this message translates to:
  /// **'Base locked'**
  String get commonBaseLocked;

  /// No description provided for @commonDeltaE.
  ///
  /// In en, this message translates to:
  /// **'ΔE {value}'**
  String commonDeltaE(double value);

  /// No description provided for @commonRgb.
  ///
  /// In en, this message translates to:
  /// **'RGB {r} {g} {b}'**
  String commonRgb(int r, int g, int b);

  /// No description provided for @commonOldCode.
  ///
  /// In en, this message translates to:
  /// **'Old {code}'**
  String commonOldCode(String code);

  /// No description provided for @commonMarkersAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 marker available} other{{count} markers available}}'**
  String commonMarkersAvailable(int count);

  /// No description provided for @commonColorCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 colour} other{{count} colours}}'**
  String commonColorCount(int count);

  /// No description provided for @commonCardLocation.
  ///
  /// In en, this message translates to:
  /// **'Swatch card {number}'**
  String commonCardLocation(int number);

  /// No description provided for @navTabHint.
  ///
  /// In en, this message translates to:
  /// **'Tab {index} of {count}'**
  String navTabHint(int index, int count);

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get settingsLanguageGerman;

  /// No description provided for @settingsLanguageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get settingsLanguageFrench;

  /// No description provided for @settingsLanguagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get settingsLanguagePortuguese;

  /// No description provided for @settingsLanguageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get settingsLanguageItalian;

  /// No description provided for @settingsOwnedCount.
  ///
  /// In en, this message translates to:
  /// **'{owned} of {total} markers'**
  String settingsOwnedCount(int owned, int total);

  /// No description provided for @settingsPacksSelected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 pack selected} other{{count} packs selected}}'**
  String settingsPacksSelected(int count);

  /// No description provided for @settingsImportUnsupportedVersion.
  ///
  /// In en, this message translates to:
  /// **'This backup has the unsupported version {version}.'**
  String settingsImportUnsupportedVersion(int version);

  /// No description provided for @settingsImportFailed.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be imported: {reason}'**
  String settingsImportFailed(String reason);

  /// No description provided for @settingsAiOnDeviceProgressTotal.
  ///
  /// In en, this message translates to:
  /// **'{bytes} of {total} MB downloaded ({percent}%)'**
  String settingsAiOnDeviceProgressTotal(
    String bytes,
    String total,
    int percent,
  );

  /// No description provided for @settingsAiOnDeviceProgressBytes.
  ///
  /// In en, this message translates to:
  /// **'{bytes} MB downloaded'**
  String settingsAiOnDeviceProgressBytes(String bytes);

  /// No description provided for @settingsAiConnectionOk.
  ///
  /// In en, this message translates to:
  /// **'Connection OK ({count, plural, =1{1 model} other{{count} models}} available).'**
  String settingsAiConnectionOk(int count);

  /// No description provided for @settingsAiConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed: {reason}'**
  String settingsAiConnectionFailed(String reason);

  /// No description provided for @settingsAiFallbacksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} of {max}'**
  String settingsAiFallbacksCount(int count, int max);

  /// No description provided for @settingsAiUseTyped.
  ///
  /// In en, this message translates to:
  /// **'Use \"{id}\"'**
  String settingsAiUseTyped(String id);

  /// No description provided for @settingsAiFallbacksHint.
  ///
  /// In en, this message translates to:
  /// **'Tried in order when the model above fails (up to {max}).'**
  String settingsAiFallbacksHint(int max);

  /// No description provided for @settingsAiOnDeviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'On-device AI is not available on this phone right now. Colour theory is used until it is.'**
  String get settingsAiOnDeviceUnavailable;

  /// No description provided for @settingsAiOnDeviceNotEnabledIos.
  ///
  /// In en, this message translates to:
  /// **'To use on-device AI, turn on Apple Intelligence in Settings → Apple Intelligence & Siri.'**
  String get settingsAiOnDeviceNotEnabledIos;

  /// No description provided for @paletteSizeChip.
  ///
  /// In en, this message translates to:
  /// **'{size} colours'**
  String paletteSizeChip(int size);

  /// No description provided for @paletteAiLabel.
  ///
  /// In en, this message translates to:
  /// **'AI · {name}'**
  String paletteAiLabel(String name);

  /// No description provided for @paletteAiLabelPartial.
  ///
  /// In en, this message translates to:
  /// **'AI + colour theory · {name} · {aiCount}/{total}'**
  String paletteAiLabelPartial(String name, int aiCount, int total);

  /// No description provided for @paletteResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Combinations ({count})'**
  String paletteResultTitle(int count);

  /// No description provided for @paletteSavedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{mode} · {size} colours'**
  String paletteSavedSubtitle(String mode, int size);

  /// No description provided for @paletteSubtitleCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom palette · {count, plural, =1{1 marker} other{{count} markers}}'**
  String paletteSubtitleCustom(int count);

  /// No description provided for @paletteSavedNotice.
  ///
  /// In en, this message translates to:
  /// **'Palette \"{name}\" saved.'**
  String paletteSavedNotice(String name);

  /// No description provided for @paletteLoadedNotice.
  ///
  /// In en, this message translates to:
  /// **'Palette \"{name}\" loaded.'**
  String paletteLoadedNotice(String name);

  /// No description provided for @paletteVariationApplied.
  ///
  /// In en, this message translates to:
  /// **'{label} variation applied.'**
  String paletteVariationApplied(String label);

  /// No description provided for @paletteDraftApplied.
  ///
  /// In en, this message translates to:
  /// **'Ideas palette applied ({count} colours).'**
  String paletteDraftApplied(int count);

  /// No description provided for @paletteUsingDefaultBase.
  ///
  /// In en, this message translates to:
  /// **'Using {code} as the default base for {scenario}. Enter a code to override it.'**
  String paletteUsingDefaultBase(String code, String scenario);

  /// No description provided for @paletteUnknownCode.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{{input} is not a DecoTime marker code. Try {example}.} copic{{input} is not a Copic marker code. Try {example}.} finecolour{{input} is not a Finecolour marker code. Try {example}.} touchTwin{{input} is not a Touch Twin marker code. Try {example}.} promarker{{input} is not a Promarker marker code. Try {example}.} prismacolor{{input} is not a Prismacolor Premier marker code. Try {example}.} spectrumNoir{{input} is not a Spectrum Noir marker code. Try {example}.} promarkerBrush{{input} is not a Promarker Brush marker code. Try {example}.} arrtx{{input} is not an Arrtx marker code. Try {example}.} kurecolor{{input} is not a ZIG Kurecolor marker code. Try {example}.} graphit{{input} is not a Graph\'it marker code. Try {example}.} marvyLePlume{{input} is not a Marvy Le Plume marker code. Try {example}.} blickBrush{{input} is not a Blick Studio Brush marker code. Try {example}.} artistsLoft{{input} is not an Artist\'s Loft marker code. Try {example}.} other{{input} is not an Ink Lab marker code. Try {example}.}}'**
  String paletteUnknownCode(String brand, String input, String example);

  /// No description provided for @paletteNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{{input} is not in your collection. Try {example} or add it in My collection.} copic{{input} is not in your collection. Try {example} or add it in My collection.} finecolour{{input} is not in your collection. Try {example} or add it in My collection.} other{{input} is not in your collection. Try {example} or add it in My collection.}}'**
  String paletteNotAvailable(String brand, String input, String example);

  /// No description provided for @paletteNoAvailableColors.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{There are no DecoTime markers in your collection yet. Add them in My collection.} copic{There are no Copic markers in your collection yet. Add them in My collection.} finecolour{There are no Finecolour markers in your collection yet. Add them in My collection.} touchTwin{There are no Touch Twin markers in your collection yet. Add them in My collection.} promarker{There are no Promarker markers in your collection yet. Add them in My collection.} prismacolor{There are no Prismacolor Premier markers in your collection yet. Add them in My collection.} spectrumNoir{There are no Spectrum Noir markers in your collection yet. Add them in My collection.} promarkerBrush{There are no Promarker Brush markers in your collection yet. Add them in My collection.} arrtx{There are no Arrtx markers in your collection yet. Add them in My collection.} kurecolor{There are no ZIG Kurecolor markers in your collection yet. Add them in My collection.} graphit{There are no Graph\'it markers in your collection yet. Add them in My collection.} marvyLePlume{There are no Marvy Le Plume markers in your collection yet. Add them in My collection.} blickBrush{There are no Blick Studio Brush markers in your collection yet. Add them in My collection.} artistsLoft{There are no Artist\'s Loft markers in your collection yet. Add them in My collection.} other{There are no markers in your collection yet. Add them in My collection.}}'**
  String paletteNoAvailableColors(String brand);

  /// No description provided for @paletteMissingBase.
  ///
  /// In en, this message translates to:
  /// **'Pick a base marker, such as {example}, or choose Scenes as the palette type.'**
  String paletteMissingBase(String example);

  /// No description provided for @paletteBaseDried.
  ///
  /// In en, this message translates to:
  /// **'{code} is dried out. Mark it as usable in Details or choose another.'**
  String paletteBaseDried(String code);

  /// No description provided for @swatchesFiltersCount.
  ///
  /// In en, this message translates to:
  /// **'Filters · {count}'**
  String swatchesFiltersCount(int count);

  /// No description provided for @swatchesCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'{code} copied. Paste it as the base colour on the Palette tab.'**
  String swatchesCodeCopied(String code);

  /// No description provided for @swatchesAlternativeSemantics.
  ///
  /// In en, this message translates to:
  /// **'{code}, {name}, delta E {value}'**
  String swatchesAlternativeSemantics(String code, String name, double value);

  /// No description provided for @swatchesCountOf.
  ///
  /// In en, this message translates to:
  /// **'{visible} of {total}'**
  String swatchesCountOf(int visible, int total);

  /// No description provided for @swatchesOwnedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{brand} · {count} owned'**
  String swatchesOwnedSubtitle(String brand, int count);

  /// No description provided for @swatchesFilteredColorCount.
  ///
  /// In en, this message translates to:
  /// **'{visible} of {total} colours'**
  String swatchesFilteredColorCount(int visible, int total);

  /// No description provided for @swatchesSwatchSemantics.
  ///
  /// In en, this message translates to:
  /// **'{favorite, select, true{{code}, {name}, favourite} other{{code}, {name}}}'**
  String swatchesSwatchSemantics(String code, String name, String favorite);

  /// No description provided for @swatchesClassicPack.
  ///
  /// In en, this message translates to:
  /// **'Classic {label}'**
  String swatchesClassicPack(String label);

  /// No description provided for @ideasPaletteSent.
  ///
  /// In en, this message translates to:
  /// **'The “{title}” palette is ready in Palette.'**
  String ideasPaletteSent(String title);

  /// No description provided for @matchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Matching against your {count, plural, =1{1 marker} other{{count} markers}}'**
  String matchSubtitle(int count);

  /// No description provided for @matchQualityExcellent.
  ///
  /// In en, this message translates to:
  /// **'Nearly exact'**
  String get matchQualityExcellent;

  /// No description provided for @matchQualityVeryClose.
  ///
  /// In en, this message translates to:
  /// **'Very close'**
  String get matchQualityVeryClose;

  /// No description provided for @matchQualityClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get matchQualityClose;

  /// No description provided for @matchQualityFair.
  ///
  /// In en, this message translates to:
  /// **'Rough'**
  String get matchQualityFair;

  /// No description provided for @matchQualityApproximate.
  ///
  /// In en, this message translates to:
  /// **'Far off'**
  String get matchQualityApproximate;

  /// No description provided for @matchRecorded.
  ///
  /// In en, this message translates to:
  /// **'{code} saved to recent picks.'**
  String matchRecorded(String code);

  /// No description provided for @errDisabled.
  ///
  /// In en, this message translates to:
  /// **'AI suggestions are turned off.'**
  String get errDisabled;

  /// No description provided for @errMissingKey.
  ///
  /// In en, this message translates to:
  /// **'No API key configured.'**
  String get errMissingKey;

  /// No description provided for @errNoModelSelected.
  ///
  /// In en, this message translates to:
  /// **'No AI model selected.'**
  String get errNoModelSelected;

  /// No description provided for @errUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'The API key was rejected.'**
  String get errUnauthorized;

  /// No description provided for @errPaymentRequired.
  ///
  /// In en, this message translates to:
  /// **'The account has no credit or the key is out of quota.'**
  String get errPaymentRequired;

  /// No description provided for @errRateLimited.
  ///
  /// In en, this message translates to:
  /// **'The provider is rate limiting requests. Try again shortly.'**
  String get errRateLimited;

  /// No description provided for @errServerError.
  ///
  /// In en, this message translates to:
  /// **'The provider had a server error. Try again later.'**
  String get errServerError;

  /// No description provided for @errHttpError.
  ///
  /// In en, this message translates to:
  /// **'The provider rejected the request.'**
  String get errHttpError;

  /// No description provided for @errNetworkError.
  ///
  /// In en, this message translates to:
  /// **'The provider could not be reached. Check the connection.'**
  String get errNetworkError;

  /// No description provided for @errInvalidJson.
  ///
  /// In en, this message translates to:
  /// **'The provider returned an unreadable response.'**
  String get errInvalidJson;

  /// No description provided for @errInvalidResponse.
  ///
  /// In en, this message translates to:
  /// **'The provider returned no usable palette.'**
  String get errInvalidResponse;

  /// No description provided for @errNoValidSuggestions.
  ///
  /// In en, this message translates to:
  /// **'The provider suggested colours that are not in the active collection.'**
  String get errNoValidSuggestions;

  /// No description provided for @errNoAvailableColors.
  ///
  /// In en, this message translates to:
  /// **'There are no available markers to choose from.'**
  String get errNoAvailableColors;

  /// No description provided for @errInvalidBaseColor.
  ///
  /// In en, this message translates to:
  /// **'The base marker is not in your collection.'**
  String get errInvalidBaseColor;

  /// No description provided for @errBaseDried.
  ///
  /// In en, this message translates to:
  /// **'The base marker is dried out. Mark it as usable or choose another.'**
  String get errBaseDried;

  /// No description provided for @errNoSuggestions.
  ///
  /// In en, this message translates to:
  /// **'No suggestions could be generated.'**
  String get errNoSuggestions;

  /// No description provided for @errTimeout.
  ///
  /// In en, this message translates to:
  /// **'The on-device model took too long. Try again.'**
  String get errTimeout;

  /// No description provided for @errOnDeviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The on-device model is not ready on this phone.'**
  String get errOnDeviceUnavailable;

  /// No description provided for @errUnknown.
  ///
  /// In en, this message translates to:
  /// **'AI suggestions are unavailable.'**
  String get errUnknown;

  /// No description provided for @errAiUnavailableWithReason.
  ///
  /// In en, this message translates to:
  /// **'AI unavailable ({reason}) Showing local suggestions.'**
  String errAiUnavailableWithReason(String reason);

  /// No description provided for @roleMainTone.
  ///
  /// In en, this message translates to:
  /// **'Main tone'**
  String get roleMainTone;

  /// No description provided for @roleMidtone.
  ///
  /// In en, this message translates to:
  /// **'Midtone'**
  String get roleMidtone;

  /// No description provided for @roleShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow'**
  String get roleShadow;

  /// No description provided for @roleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Highlight'**
  String get roleHighlight;

  /// No description provided for @roleBlend.
  ///
  /// In en, this message translates to:
  /// **'Blend'**
  String get roleBlend;

  /// No description provided for @roleToneA.
  ///
  /// In en, this message translates to:
  /// **'Tone A'**
  String get roleToneA;

  /// No description provided for @roleToneAShadow.
  ///
  /// In en, this message translates to:
  /// **'Tone A shadow'**
  String get roleToneAShadow;

  /// No description provided for @roleToneB.
  ///
  /// In en, this message translates to:
  /// **'Tone B'**
  String get roleToneB;

  /// No description provided for @roleToneBShadow.
  ///
  /// In en, this message translates to:
  /// **'Tone B shadow'**
  String get roleToneBShadow;

  /// No description provided for @roleBridge.
  ///
  /// In en, this message translates to:
  /// **'Bridge'**
  String get roleBridge;

  /// No description provided for @roleWarmBase.
  ///
  /// In en, this message translates to:
  /// **'Warm base'**
  String get roleWarmBase;

  /// No description provided for @roleWarmShadow.
  ///
  /// In en, this message translates to:
  /// **'Warm shadow'**
  String get roleWarmShadow;

  /// No description provided for @roleSunlitAccent.
  ///
  /// In en, this message translates to:
  /// **'Sunlit accent'**
  String get roleSunlitAccent;

  /// No description provided for @roleDepthTone.
  ///
  /// In en, this message translates to:
  /// **'Depth tone'**
  String get roleDepthTone;

  /// No description provided for @roleCoolBase.
  ///
  /// In en, this message translates to:
  /// **'Cool base'**
  String get roleCoolBase;

  /// No description provided for @roleCoolShadow.
  ///
  /// In en, this message translates to:
  /// **'Cool shadow'**
  String get roleCoolShadow;

  /// No description provided for @roleAtmosphere.
  ///
  /// In en, this message translates to:
  /// **'Atmosphere'**
  String get roleAtmosphere;

  /// No description provided for @roleDeepCool.
  ///
  /// In en, this message translates to:
  /// **'Deep cool'**
  String get roleDeepCool;

  /// No description provided for @rolePastelBase.
  ///
  /// In en, this message translates to:
  /// **'Pastel base'**
  String get rolePastelBase;

  /// No description provided for @roleSoftShade.
  ///
  /// In en, this message translates to:
  /// **'Soft shade'**
  String get roleSoftShade;

  /// No description provided for @rolePastelHighlight.
  ///
  /// In en, this message translates to:
  /// **'Pastel highlight'**
  String get rolePastelHighlight;

  /// No description provided for @roleAccent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get roleAccent;

  /// No description provided for @roleSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get roleSupport;

  /// No description provided for @roleNeonLead.
  ///
  /// In en, this message translates to:
  /// **'Neon lead'**
  String get roleNeonLead;

  /// No description provided for @roleNeonSecondary.
  ///
  /// In en, this message translates to:
  /// **'Neon secondary'**
  String get roleNeonSecondary;

  /// No description provided for @roleGlow.
  ///
  /// In en, this message translates to:
  /// **'Glow'**
  String get roleGlow;

  /// No description provided for @rolePopAccent.
  ///
  /// In en, this message translates to:
  /// **'Pop accent'**
  String get rolePopAccent;

  /// No description provided for @roleHue1.
  ///
  /// In en, this message translates to:
  /// **'Hue 1'**
  String get roleHue1;

  /// No description provided for @roleHue2.
  ///
  /// In en, this message translates to:
  /// **'Hue 2'**
  String get roleHue2;

  /// No description provided for @roleHue3.
  ///
  /// In en, this message translates to:
  /// **'Hue 3'**
  String get roleHue3;

  /// No description provided for @roleHue4.
  ///
  /// In en, this message translates to:
  /// **'Hue 4'**
  String get roleHue4;

  /// No description provided for @roleHue5.
  ///
  /// In en, this message translates to:
  /// **'Hue 5'**
  String get roleHue5;

  /// No description provided for @roleUnexpectedLead.
  ///
  /// In en, this message translates to:
  /// **'Unexpected lead'**
  String get roleUnexpectedLead;

  /// No description provided for @roleContrastPair.
  ///
  /// In en, this message translates to:
  /// **'Contrast pair'**
  String get roleContrastPair;

  /// No description provided for @roleTensionAccent.
  ///
  /// In en, this message translates to:
  /// **'Tension accent'**
  String get roleTensionAccent;

  /// No description provided for @roleOffbeatSupport.
  ///
  /// In en, this message translates to:
  /// **'Offbeat support'**
  String get roleOffbeatSupport;

  /// No description provided for @roleRandom1.
  ///
  /// In en, this message translates to:
  /// **'Random 1'**
  String get roleRandom1;

  /// No description provided for @roleRandom2.
  ///
  /// In en, this message translates to:
  /// **'Random 2'**
  String get roleRandom2;

  /// No description provided for @roleRandom3.
  ///
  /// In en, this message translates to:
  /// **'Random 3'**
  String get roleRandom3;

  /// No description provided for @roleRandom4.
  ///
  /// In en, this message translates to:
  /// **'Random 4'**
  String get roleRandom4;

  /// No description provided for @roleRandom5.
  ///
  /// In en, this message translates to:
  /// **'Random 5'**
  String get roleRandom5;

  /// No description provided for @roleLightValue.
  ///
  /// In en, this message translates to:
  /// **'Light value'**
  String get roleLightValue;

  /// No description provided for @roleMidLight.
  ///
  /// In en, this message translates to:
  /// **'Mid-light'**
  String get roleMidLight;

  /// No description provided for @roleMid.
  ///
  /// In en, this message translates to:
  /// **'Mid'**
  String get roleMid;

  /// No description provided for @roleMidDark.
  ///
  /// In en, this message translates to:
  /// **'Mid-dark'**
  String get roleMidDark;

  /// No description provided for @roleDarkValue.
  ///
  /// In en, this message translates to:
  /// **'Dark value'**
  String get roleDarkValue;

  /// No description provided for @roleWarmSideA.
  ///
  /// In en, this message translates to:
  /// **'Warm side A'**
  String get roleWarmSideA;

  /// No description provided for @roleWarmSideB.
  ///
  /// In en, this message translates to:
  /// **'Warm side B'**
  String get roleWarmSideB;

  /// No description provided for @roleCoolSideA.
  ///
  /// In en, this message translates to:
  /// **'Cool side A'**
  String get roleCoolSideA;

  /// No description provided for @roleCoolSideB.
  ///
  /// In en, this message translates to:
  /// **'Cool side B'**
  String get roleCoolSideB;

  /// No description provided for @roleBridgeTone.
  ///
  /// In en, this message translates to:
  /// **'Bridge tone'**
  String get roleBridgeTone;

  /// No description provided for @roleSeasonLead.
  ///
  /// In en, this message translates to:
  /// **'Season lead'**
  String get roleSeasonLead;

  /// No description provided for @roleSeasonSupport.
  ///
  /// In en, this message translates to:
  /// **'Season support'**
  String get roleSeasonSupport;

  /// No description provided for @roleFestiveRed.
  ///
  /// In en, this message translates to:
  /// **'Festive red'**
  String get roleFestiveRed;

  /// No description provided for @roleEvergreen.
  ///
  /// In en, this message translates to:
  /// **'Evergreen'**
  String get roleEvergreen;

  /// No description provided for @roleGoldAccent.
  ///
  /// In en, this message translates to:
  /// **'Gold accent'**
  String get roleGoldAccent;

  /// No description provided for @rolePineShadow.
  ///
  /// In en, this message translates to:
  /// **'Pine shadow'**
  String get rolePineShadow;

  /// No description provided for @roleSnowSupport.
  ///
  /// In en, this message translates to:
  /// **'Snow support'**
  String get roleSnowSupport;

  /// No description provided for @roleRomanticLead.
  ///
  /// In en, this message translates to:
  /// **'Romantic lead'**
  String get roleRomanticLead;

  /// No description provided for @roleRoseShadow.
  ///
  /// In en, this message translates to:
  /// **'Rose shadow'**
  String get roleRoseShadow;

  /// No description provided for @roleSoftBlush.
  ///
  /// In en, this message translates to:
  /// **'Soft blush'**
  String get roleSoftBlush;

  /// No description provided for @roleBalanceTone.
  ///
  /// In en, this message translates to:
  /// **'Balance tone'**
  String get roleBalanceTone;

  /// No description provided for @roleBase.
  ///
  /// In en, this message translates to:
  /// **'Base'**
  String get roleBase;

  /// No description provided for @roleGlowZone.
  ///
  /// In en, this message translates to:
  /// **'Glow zone'**
  String get roleGlowZone;

  /// No description provided for @rolePatternAccent.
  ///
  /// In en, this message translates to:
  /// **'Pattern accent'**
  String get rolePatternAccent;

  /// No description provided for @roleContrastColor.
  ///
  /// In en, this message translates to:
  /// **'Contrast colour'**
  String get roleContrastColor;

  /// No description provided for @rolePrimary1.
  ///
  /// In en, this message translates to:
  /// **'Primary 1'**
  String get rolePrimary1;

  /// No description provided for @rolePrimary2.
  ///
  /// In en, this message translates to:
  /// **'Primary 2'**
  String get rolePrimary2;

  /// No description provided for @rolePrimary3.
  ///
  /// In en, this message translates to:
  /// **'Primary 3'**
  String get rolePrimary3;

  /// No description provided for @roleSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get roleSecondary;

  /// No description provided for @roleSepiaLight.
  ///
  /// In en, this message translates to:
  /// **'Sepia light'**
  String get roleSepiaLight;

  /// No description provided for @roleDustMidtone.
  ///
  /// In en, this message translates to:
  /// **'Dust midtone'**
  String get roleDustMidtone;

  /// No description provided for @roleLeatherShadow.
  ///
  /// In en, this message translates to:
  /// **'Leather shadow'**
  String get roleLeatherShadow;

  /// No description provided for @roleAgedAccent.
  ///
  /// In en, this message translates to:
  /// **'Aged accent'**
  String get roleAgedAccent;

  /// No description provided for @roleSmokeNeutral.
  ///
  /// In en, this message translates to:
  /// **'Smoke neutral'**
  String get roleSmokeNeutral;

  /// No description provided for @roleHauntBase.
  ///
  /// In en, this message translates to:
  /// **'Haunt base'**
  String get roleHauntBase;

  /// No description provided for @rolePumpkinGlow.
  ///
  /// In en, this message translates to:
  /// **'Pumpkin glow'**
  String get rolePumpkinGlow;

  /// No description provided for @roleNightShadow.
  ///
  /// In en, this message translates to:
  /// **'Night shadow'**
  String get roleNightShadow;

  /// No description provided for @roleEerieAccent.
  ///
  /// In en, this message translates to:
  /// **'Eerie accent'**
  String get roleEerieAccent;

  /// No description provided for @roleFogSupport.
  ///
  /// In en, this message translates to:
  /// **'Fog support'**
  String get roleFogSupport;

  /// No description provided for @roleNightBase.
  ///
  /// In en, this message translates to:
  /// **'Night base'**
  String get roleNightBase;

  /// No description provided for @roleDeepShadow.
  ///
  /// In en, this message translates to:
  /// **'Deep shadow'**
  String get roleDeepShadow;

  /// No description provided for @roleMoonlitEdge.
  ///
  /// In en, this message translates to:
  /// **'Moonlit edge'**
  String get roleMoonlitEdge;

  /// No description provided for @roleCoolAccent.
  ///
  /// In en, this message translates to:
  /// **'Cool accent'**
  String get roleCoolAccent;

  /// No description provided for @roleMist.
  ///
  /// In en, this message translates to:
  /// **'Mist'**
  String get roleMist;

  /// No description provided for @roleWaterBase.
  ///
  /// In en, this message translates to:
  /// **'Water base'**
  String get roleWaterBase;

  /// No description provided for @roleDepth.
  ///
  /// In en, this message translates to:
  /// **'Depth'**
  String get roleDepth;

  /// No description provided for @roleShadowWater.
  ///
  /// In en, this message translates to:
  /// **'Shadow water'**
  String get roleShadowWater;

  /// No description provided for @roleLightBeam.
  ///
  /// In en, this message translates to:
  /// **'Light beam'**
  String get roleLightBeam;

  /// No description provided for @roleBubbleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Bubble highlight'**
  String get roleBubbleHighlight;

  /// No description provided for @roleSpookyBase.
  ///
  /// In en, this message translates to:
  /// **'Spooky base'**
  String get roleSpookyBase;

  /// No description provided for @roleColdShadow.
  ///
  /// In en, this message translates to:
  /// **'Cold shadow'**
  String get roleColdShadow;

  /// No description provided for @roleHauntedAccent.
  ///
  /// In en, this message translates to:
  /// **'Haunted accent'**
  String get roleHauntedAccent;

  /// No description provided for @roleEerieHighlight.
  ///
  /// In en, this message translates to:
  /// **'Eerie highlight'**
  String get roleEerieHighlight;

  /// No description provided for @roleFogTone.
  ///
  /// In en, this message translates to:
  /// **'Fog tone'**
  String get roleFogTone;

  /// No description provided for @roleMysticBase.
  ///
  /// In en, this message translates to:
  /// **'Mystic base'**
  String get roleMysticBase;

  /// No description provided for @roleSpellShadow.
  ///
  /// In en, this message translates to:
  /// **'Spell shadow'**
  String get roleSpellShadow;

  /// No description provided for @roleMagicalAccent.
  ///
  /// In en, this message translates to:
  /// **'Magical accent'**
  String get roleMagicalAccent;

  /// No description provided for @roleRuneGlow.
  ///
  /// In en, this message translates to:
  /// **'Rune glow'**
  String get roleRuneGlow;

  /// No description provided for @roleMoodLead.
  ///
  /// In en, this message translates to:
  /// **'Mood lead'**
  String get roleMoodLead;

  /// No description provided for @roleMoodShadow.
  ///
  /// In en, this message translates to:
  /// **'Mood shadow'**
  String get roleMoodShadow;

  /// No description provided for @roleEmotionAccent.
  ///
  /// In en, this message translates to:
  /// **'Emotion accent'**
  String get roleEmotionAccent;

  /// No description provided for @roleMaterialBase.
  ///
  /// In en, this message translates to:
  /// **'Material base'**
  String get roleMaterialBase;

  /// No description provided for @rolePlaneShift.
  ///
  /// In en, this message translates to:
  /// **'Plane shift'**
  String get rolePlaneShift;

  /// No description provided for @roleHardShadow.
  ///
  /// In en, this message translates to:
  /// **'Hard shadow'**
  String get roleHardShadow;

  /// No description provided for @roleSpecularEdge.
  ///
  /// In en, this message translates to:
  /// **'Specular edge'**
  String get roleSpecularEdge;

  /// No description provided for @rolePatinaAccent.
  ///
  /// In en, this message translates to:
  /// **'Patina accent'**
  String get rolePatinaAccent;

  /// No description provided for @roleSpaceBase.
  ///
  /// In en, this message translates to:
  /// **'Space base'**
  String get roleSpaceBase;

  /// No description provided for @roleNebulaGlow.
  ///
  /// In en, this message translates to:
  /// **'Nebula glow'**
  String get roleNebulaGlow;

  /// No description provided for @roleDeepVoid.
  ///
  /// In en, this message translates to:
  /// **'Deep void'**
  String get roleDeepVoid;

  /// No description provided for @roleStarAccent.
  ///
  /// In en, this message translates to:
  /// **'Star accent'**
  String get roleStarAccent;

  /// No description provided for @roleDustCloud.
  ///
  /// In en, this message translates to:
  /// **'Dust cloud'**
  String get roleDustCloud;

  /// No description provided for @roleGlassPaneA.
  ///
  /// In en, this message translates to:
  /// **'Glass pane A'**
  String get roleGlassPaneA;

  /// No description provided for @roleGlassPaneB.
  ///
  /// In en, this message translates to:
  /// **'Glass pane B'**
  String get roleGlassPaneB;

  /// No description provided for @roleGlassPaneC.
  ///
  /// In en, this message translates to:
  /// **'Glass pane C'**
  String get roleGlassPaneC;

  /// No description provided for @roleGlassPaneD.
  ///
  /// In en, this message translates to:
  /// **'Glass pane D'**
  String get roleGlassPaneD;

  /// No description provided for @roleLightHit.
  ///
  /// In en, this message translates to:
  /// **'Light hit'**
  String get roleLightHit;

  /// No description provided for @roleShade.
  ///
  /// In en, this message translates to:
  /// **'Shade'**
  String get roleShade;

  /// No description provided for @roleContrast.
  ///
  /// In en, this message translates to:
  /// **'Contrast'**
  String get roleContrast;

  /// No description provided for @roleSoftShadow.
  ///
  /// In en, this message translates to:
  /// **'Soft shadow'**
  String get roleSoftShadow;

  /// No description provided for @roleBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get roleBackground;

  /// No description provided for @roleCompanionHue.
  ///
  /// In en, this message translates to:
  /// **'Companion hue'**
  String get roleCompanionHue;

  /// No description provided for @rolePrimaryShadow.
  ///
  /// In en, this message translates to:
  /// **'Primary shadow'**
  String get rolePrimaryShadow;

  /// No description provided for @roleMysticAccent.
  ///
  /// In en, this message translates to:
  /// **'Mystic accent'**
  String get roleMysticAccent;

  /// No description provided for @roleSecondaryAccent.
  ///
  /// In en, this message translates to:
  /// **'Secondary accent'**
  String get roleSecondaryAccent;

  /// No description provided for @rolePumpkinShadow.
  ///
  /// In en, this message translates to:
  /// **'Pumpkin shadow'**
  String get rolePumpkinShadow;

  /// No description provided for @roleWitchyPurple.
  ///
  /// In en, this message translates to:
  /// **'Witchy purple'**
  String get roleWitchyPurple;

  /// No description provided for @roleToxicAccent.
  ///
  /// In en, this message translates to:
  /// **'Toxic accent'**
  String get roleToxicAccent;

  /// No description provided for @roleNightBackground.
  ///
  /// In en, this message translates to:
  /// **'Night background'**
  String get roleNightBackground;

  /// No description provided for @roleRibbonRed.
  ///
  /// In en, this message translates to:
  /// **'Ribbon red'**
  String get roleRibbonRed;

  /// No description provided for @rolePineDepth.
  ///
  /// In en, this message translates to:
  /// **'Pine depth'**
  String get rolePineDepth;

  /// No description provided for @roleSnowHighlight.
  ///
  /// In en, this message translates to:
  /// **'Snow highlight'**
  String get roleSnowHighlight;

  /// No description provided for @roleBudShadow.
  ///
  /// In en, this message translates to:
  /// **'Bud shadow'**
  String get roleBudShadow;

  /// No description provided for @roleBlossomTint.
  ///
  /// In en, this message translates to:
  /// **'Blossom tint'**
  String get roleBlossomTint;

  /// No description provided for @roleFreshLeaf.
  ///
  /// In en, this message translates to:
  /// **'Fresh leaf'**
  String get roleFreshLeaf;

  /// No description provided for @roleDaffodilLight.
  ///
  /// In en, this message translates to:
  /// **'Daffodil light'**
  String get roleDaffodilLight;

  /// No description provided for @roleRainySky.
  ///
  /// In en, this message translates to:
  /// **'Rainy sky'**
  String get roleRainySky;

  /// No description provided for @roleSkinSubjectShadow.
  ///
  /// In en, this message translates to:
  /// **'Skin/subject shadow'**
  String get roleSkinSubjectShadow;

  /// No description provided for @roleWarmCompanion.
  ///
  /// In en, this message translates to:
  /// **'Warm companion'**
  String get roleWarmCompanion;

  /// No description provided for @roleNeutralBalance.
  ///
  /// In en, this message translates to:
  /// **'Neutral balance'**
  String get roleNeutralBalance;

  /// No description provided for @roleBarkShadow.
  ///
  /// In en, this message translates to:
  /// **'Bark shadow'**
  String get roleBarkShadow;

  /// No description provided for @roleMapleRed.
  ///
  /// In en, this message translates to:
  /// **'Maple red'**
  String get roleMapleRed;

  /// No description provided for @roleOliveAccent.
  ///
  /// In en, this message translates to:
  /// **'Olive accent'**
  String get roleOliveAccent;

  /// No description provided for @roleMorningMist.
  ///
  /// In en, this message translates to:
  /// **'Morning mist'**
  String get roleMorningMist;

  /// No description provided for @roleSubjectShadow.
  ///
  /// In en, this message translates to:
  /// **'Subject shadow'**
  String get roleSubjectShadow;

  /// No description provided for @roleCoolCompanion.
  ///
  /// In en, this message translates to:
  /// **'Cool companion'**
  String get roleCoolCompanion;

  /// No description provided for @roleAiryHighlight.
  ///
  /// In en, this message translates to:
  /// **'Airy highlight'**
  String get roleAiryHighlight;

  /// No description provided for @roleSnowShadow.
  ///
  /// In en, this message translates to:
  /// **'Snow shadow'**
  String get roleSnowShadow;

  /// No description provided for @roleFrostHighlight.
  ///
  /// In en, this message translates to:
  /// **'Frost highlight'**
  String get roleFrostHighlight;

  /// No description provided for @roleEvergreenDepth.
  ///
  /// In en, this message translates to:
  /// **'Evergreen depth'**
  String get roleEvergreenDepth;

  /// No description provided for @roleBerryAccent.
  ///
  /// In en, this message translates to:
  /// **'Berry accent'**
  String get roleBerryAccent;

  /// No description provided for @roleTwilightSky.
  ///
  /// In en, this message translates to:
  /// **'Twilight sky'**
  String get roleTwilightSky;

  /// No description provided for @roleGroundShadow.
  ///
  /// In en, this message translates to:
  /// **'Ground shadow'**
  String get roleGroundShadow;

  /// No description provided for @roleSkyBlend.
  ///
  /// In en, this message translates to:
  /// **'Sky blend'**
  String get roleSkyBlend;

  /// No description provided for @roleSunHighlight.
  ///
  /// In en, this message translates to:
  /// **'Sun highlight'**
  String get roleSunHighlight;

  /// No description provided for @roleContrastAccent.
  ///
  /// In en, this message translates to:
  /// **'Contrast accent'**
  String get roleContrastAccent;

  /// No description provided for @roleNeutralBuffer.
  ///
  /// In en, this message translates to:
  /// **'Neutral buffer'**
  String get roleNeutralBuffer;

  /// No description provided for @rolePalmShadow.
  ///
  /// In en, this message translates to:
  /// **'Palm shadow'**
  String get rolePalmShadow;

  /// No description provided for @roleCoralAccent.
  ///
  /// In en, this message translates to:
  /// **'Coral accent'**
  String get roleCoralAccent;

  /// No description provided for @roleOceanSplash.
  ///
  /// In en, this message translates to:
  /// **'Ocean splash'**
  String get roleOceanSplash;

  /// No description provided for @roleSunbeamHighlight.
  ///
  /// In en, this message translates to:
  /// **'Sunbeam highlight'**
  String get roleSunbeamHighlight;

  /// No description provided for @roleWarmSand.
  ///
  /// In en, this message translates to:
  /// **'Warm sand'**
  String get roleWarmSand;

  /// No description provided for @roleLeafShadow.
  ///
  /// In en, this message translates to:
  /// **'Leaf shadow'**
  String get roleLeafShadow;

  /// No description provided for @roleMossMidtone.
  ///
  /// In en, this message translates to:
  /// **'Moss midtone'**
  String get roleMossMidtone;

  /// No description provided for @roleSunlitLeaf.
  ///
  /// In en, this message translates to:
  /// **'Sunlit leaf'**
  String get roleSunlitLeaf;

  /// No description provided for @roleTrunkAccent.
  ///
  /// In en, this message translates to:
  /// **'Trunk accent'**
  String get roleTrunkAccent;

  /// No description provided for @roleSkyFog.
  ///
  /// In en, this message translates to:
  /// **'Sky/fog'**
  String get roleSkyFog;

  /// No description provided for @rolePetalShadow.
  ///
  /// In en, this message translates to:
  /// **'Petal shadow'**
  String get rolePetalShadow;

  /// No description provided for @rolePetalHighlight.
  ///
  /// In en, this message translates to:
  /// **'Petal highlight'**
  String get rolePetalHighlight;

  /// No description provided for @roleSecondaryPetal.
  ///
  /// In en, this message translates to:
  /// **'Secondary petal'**
  String get roleSecondaryPetal;

  /// No description provided for @roleLeafAccent.
  ///
  /// In en, this message translates to:
  /// **'Leaf accent'**
  String get roleLeafAccent;

  /// No description provided for @rolePatternBackground.
  ///
  /// In en, this message translates to:
  /// **'Pattern background'**
  String get rolePatternBackground;

  /// No description provided for @roleToneC.
  ///
  /// In en, this message translates to:
  /// **'Tone C'**
  String get roleToneC;

  /// No description provided for @roleToneD.
  ///
  /// In en, this message translates to:
  /// **'Tone D'**
  String get roleToneD;

  /// No description provided for @roleNeutralLinework.
  ///
  /// In en, this message translates to:
  /// **'Neutral linework'**
  String get roleNeutralLinework;

  /// No description provided for @roleComplement.
  ///
  /// In en, this message translates to:
  /// **'Complement'**
  String get roleComplement;

  /// No description provided for @roleNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get roleNeutral;

  /// No description provided for @roleCompanion.
  ///
  /// In en, this message translates to:
  /// **'Companion'**
  String get roleCompanion;

  /// No description provided for @reasonScenarioSupport.
  ///
  /// In en, this message translates to:
  /// **'Scenario support'**
  String get reasonScenarioSupport;

  /// No description provided for @reasonBalancedPairing.
  ///
  /// In en, this message translates to:
  /// **'Balanced pairing'**
  String get reasonBalancedPairing;

  /// No description provided for @reasonShadowDepth.
  ///
  /// In en, this message translates to:
  /// **'Shadow depth'**
  String get reasonShadowDepth;

  /// No description provided for @reasonSoftNearbyHue.
  ///
  /// In en, this message translates to:
  /// **'Soft nearby hue'**
  String get reasonSoftNearbyHue;

  /// No description provided for @reasonControlledContrast.
  ///
  /// In en, this message translates to:
  /// **'Controlled contrast'**
  String get reasonControlledContrast;

  /// No description provided for @reasonHighlightLift.
  ///
  /// In en, this message translates to:
  /// **'Highlight lift'**
  String get reasonHighlightLift;

  /// No description provided for @reasonLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get reasonLocked;

  /// No description provided for @reasonVariationSupport.
  ///
  /// In en, this message translates to:
  /// **'Variation support'**
  String get reasonVariationSupport;

  /// No description provided for @reasonOppositeHueContrast.
  ///
  /// In en, this message translates to:
  /// **'Opposite hue contrast'**
  String get reasonOppositeHueContrast;

  /// No description provided for @reasonSplitComplementContrast.
  ///
  /// In en, this message translates to:
  /// **'Split complement contrast'**
  String get reasonSplitComplementContrast;

  /// No description provided for @reasonTriadBalance.
  ///
  /// In en, this message translates to:
  /// **'Triad balance'**
  String get reasonTriadBalance;

  /// No description provided for @reasonSquareHarmony.
  ///
  /// In en, this message translates to:
  /// **'Square harmony'**
  String get reasonSquareHarmony;

  /// No description provided for @reasonRectangleHarmony.
  ///
  /// In en, this message translates to:
  /// **'Rectangle harmony'**
  String get reasonRectangleHarmony;

  /// No description provided for @reasonSameFamilyDeeperTone.
  ///
  /// In en, this message translates to:
  /// **'Same family, deeper tone'**
  String get reasonSameFamilyDeeperTone;

  /// No description provided for @reasonSameFamilyLighterTone.
  ///
  /// In en, this message translates to:
  /// **'Same family, lighter tone'**
  String get reasonSameFamilyLighterTone;

  /// No description provided for @reasonManualPalette.
  ///
  /// In en, this message translates to:
  /// **'Manual palette'**
  String get reasonManualPalette;

  /// No description provided for @reasonSupportTone.
  ///
  /// In en, this message translates to:
  /// **'Support tone'**
  String get reasonSupportTone;

  /// No description provided for @reasonAISuggestion.
  ///
  /// In en, this message translates to:
  /// **'AI suggestion'**
  String get reasonAISuggestion;

  /// No description provided for @reasonLoadedPalette.
  ///
  /// In en, this message translates to:
  /// **'Loaded palette'**
  String get reasonLoadedPalette;

  /// No description provided for @reasonAppliedFromIdeas.
  ///
  /// In en, this message translates to:
  /// **'Applied from Ideas'**
  String get reasonAppliedFromIdeas;

  /// No description provided for @reasonNearbyHue.
  ///
  /// In en, this message translates to:
  /// **'Nearby hue harmony ({degrees}deg)'**
  String reasonNearbyHue(int degrees);

  /// No description provided for @reasonShadowTone.
  ///
  /// In en, this message translates to:
  /// **'Shadow tone ({percent}% darker)'**
  String reasonShadowTone(int percent);

  /// No description provided for @reasonVariation.
  ///
  /// In en, this message translates to:
  /// **'{prefix}: {reason}'**
  String reasonVariation(String prefix, String reason);

  /// No description provided for @variationPrefixVibrant.
  ///
  /// In en, this message translates to:
  /// **'Vibrant'**
  String get variationPrefixVibrant;

  /// No description provided for @variationPrefixSoft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get variationPrefixSoft;

  /// No description provided for @variationPrefixContrast.
  ///
  /// In en, this message translates to:
  /// **'Contrast'**
  String get variationPrefixContrast;

  /// No description provided for @variationPrefixWarm.
  ///
  /// In en, this message translates to:
  /// **'Warm'**
  String get variationPrefixWarm;

  /// No description provided for @variationPrefixCool.
  ///
  /// In en, this message translates to:
  /// **'Cool'**
  String get variationPrefixCool;

  /// No description provided for @variationLabelMoreVibrant.
  ///
  /// In en, this message translates to:
  /// **'More vibrant'**
  String get variationLabelMoreVibrant;

  /// No description provided for @variationLabelSofter.
  ///
  /// In en, this message translates to:
  /// **'Softer'**
  String get variationLabelSofter;

  /// No description provided for @variationLabelHigherContrast.
  ///
  /// In en, this message translates to:
  /// **'Higher contrast'**
  String get variationLabelHigherContrast;

  /// No description provided for @variationLabelWarmer.
  ///
  /// In en, this message translates to:
  /// **'Warmer'**
  String get variationLabelWarmer;

  /// No description provided for @variationLabelCooler.
  ///
  /// In en, this message translates to:
  /// **'Cooler'**
  String get variationLabelCooler;

  /// No description provided for @modeRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get modeRecommended;

  /// No description provided for @modeComplementary.
  ///
  /// In en, this message translates to:
  /// **'Complementary'**
  String get modeComplementary;

  /// No description provided for @modeAnalogous.
  ///
  /// In en, this message translates to:
  /// **'Analogous'**
  String get modeAnalogous;

  /// No description provided for @modeSplitComplementary.
  ///
  /// In en, this message translates to:
  /// **'Split Complementary'**
  String get modeSplitComplementary;

  /// No description provided for @modeTriad.
  ///
  /// In en, this message translates to:
  /// **'Triad'**
  String get modeTriad;

  /// No description provided for @modeSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get modeSquare;

  /// No description provided for @modeRectangle.
  ///
  /// In en, this message translates to:
  /// **'Rectangle'**
  String get modeRectangle;

  /// No description provided for @modeMonochrome.
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get modeMonochrome;

  /// No description provided for @modeCustomPalette.
  ///
  /// In en, this message translates to:
  /// **'Custom Palette'**
  String get modeCustomPalette;

  /// No description provided for @modeShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow'**
  String get modeShadow;

  /// No description provided for @packLabel120New.
  ///
  /// In en, this message translates to:
  /// **'120 New'**
  String get packLabel120New;

  /// No description provided for @packLabel36Skin.
  ///
  /// In en, this message translates to:
  /// **'36 Skin'**
  String get packLabel36Skin;

  /// No description provided for @packLabel36Gray.
  ///
  /// In en, this message translates to:
  /// **'36 Gray'**
  String get packLabel36Gray;

  /// No description provided for @packLabel48Pastel.
  ///
  /// In en, this message translates to:
  /// **'48 Pastel'**
  String get packLabel48Pastel;

  /// No description provided for @categorySignature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get categorySignature;

  /// No description provided for @categoryChallenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get categoryChallenges;

  /// No description provided for @categoryAtmosphere.
  ///
  /// In en, this message translates to:
  /// **'Atmosphere'**
  String get categoryAtmosphere;

  /// No description provided for @settingsLinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Series you own'**
  String get settingsLinesTitle;

  /// No description provided for @settingsLinesHint.
  ///
  /// In en, this message translates to:
  /// **'Pick every Ohuhu series you own. Turning a series off removes its packs from your selection.'**
  String get settingsLinesHint;

  /// No description provided for @settingsLineSelectedOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{selected} of {total} packs selected'**
  String settingsLineSelectedOfTotal(int selected, int total);

  /// No description provided for @settingsCurrentPacks.
  ///
  /// In en, this message translates to:
  /// **'Current packs ({count})'**
  String settingsCurrentPacks(int count);

  /// No description provided for @settingsLegacyPacks.
  ///
  /// In en, this message translates to:
  /// **'Older / community packs ({count})'**
  String settingsLegacyPacks(int count);

  /// No description provided for @settingsLegacyPacksNote.
  ///
  /// In en, this message translates to:
  /// **'Pack list from the community; may no longer be sold.'**
  String get settingsLegacyPacksNote;

  /// No description provided for @settingsPackColorsSemantics.
  ///
  /// In en, this message translates to:
  /// **'{pack}, {count, plural, =1{1 colour} other{{count} colours}}'**
  String settingsPackColorsSemantics(String pack, int count);

  /// No description provided for @swatchesLines.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get swatchesLines;

  /// No description provided for @swatchesLabelLine.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get swatchesLabelLine;

  /// No description provided for @swatchesAllLines.
  ///
  /// In en, this message translates to:
  /// **'All series'**
  String get swatchesAllLines;

  /// No description provided for @swatchesLegacyPacks.
  ///
  /// In en, this message translates to:
  /// **'Older sets'**
  String get swatchesLegacyPacks;

  /// No description provided for @packLabelSkin.
  ///
  /// In en, this message translates to:
  /// **'{n} Skin'**
  String packLabelSkin(String n);

  /// No description provided for @packLabelPastel.
  ///
  /// In en, this message translates to:
  /// **'{n} Pastel'**
  String packLabelPastel(String n);

  /// No description provided for @packLabelPastels.
  ///
  /// In en, this message translates to:
  /// **'{n} Pastels'**
  String packLabelPastels(String n);

  /// No description provided for @packLabelBasic.
  ///
  /// In en, this message translates to:
  /// **'{n} Basic'**
  String packLabelBasic(String n);

  /// No description provided for @packLabelIllustration.
  ///
  /// In en, this message translates to:
  /// **'{n} Illustration'**
  String packLabelIllustration(String n);

  /// No description provided for @packLabelLandscape.
  ///
  /// In en, this message translates to:
  /// **'{n} Landscape'**
  String packLabelLandscape(String n);

  /// No description provided for @packLabelSweetPastels.
  ///
  /// In en, this message translates to:
  /// **'{n} Sweetness Pastels'**
  String packLabelSweetPastels(String n);

  /// No description provided for @packLabelMidTones.
  ///
  /// In en, this message translates to:
  /// **'{n} Mid-Tones'**
  String packLabelMidTones(String n);

  /// No description provided for @packLabelBlossomPastels.
  ///
  /// In en, this message translates to:
  /// **'{n} Blossoming Pastels'**
  String packLabelBlossomPastels(String n);

  /// No description provided for @packLabelWhiteCase.
  ///
  /// In en, this message translates to:
  /// **'White Case {n}'**
  String packLabelWhiteCase(String n);

  /// No description provided for @packLabelWhiteCaseVersion.
  ///
  /// In en, this message translates to:
  /// **'White Case {n} (V{v})'**
  String packLabelWhiteCaseVersion(String n, String v);

  /// No description provided for @packLabelJapanVersion.
  ///
  /// In en, this message translates to:
  /// **'Japan {n} (V{v})'**
  String packLabelJapanVersion(String n, String v);

  /// No description provided for @packFullLabel.
  ///
  /// In en, this message translates to:
  /// **'{line} {pack}'**
  String packFullLabel(String line, String pack);

  /// No description provided for @swatchesMorePacks.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  String swatchesMorePacks(int count);

  /// No description provided for @settingsMatchingGroup.
  ///
  /// In en, this message translates to:
  /// **'Colour matching'**
  String get settingsMatchingGroup;

  /// No description provided for @settingsMatchSuggestUnowned.
  ///
  /// In en, this message translates to:
  /// **'Show the whole range'**
  String get settingsMatchSuggestUnowned;

  /// No description provided for @settingsMatchSuggestUnownedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When none of your markers is close, Match also shows the closest one of the whole range.'**
  String get settingsMatchSuggestUnownedSubtitle;

  /// No description provided for @settingsSetupAgain.
  ///
  /// In en, this message translates to:
  /// **'Run the setup again'**
  String get settingsSetupAgain;

  /// No description provided for @matchNoCloseMatch.
  ///
  /// In en, this message translates to:
  /// **'No close match in your markers.'**
  String get matchNoCloseMatch;

  /// No description provided for @matchRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Whole {brand} range'**
  String matchRangeTitle(String brand);

  /// No description provided for @matchNotOwnedBadge.
  ///
  /// In en, this message translates to:
  /// **'You don\'t own it'**
  String get matchNotOwnedBadge;

  /// No description provided for @matchBestOfRange.
  ///
  /// In en, this message translates to:
  /// **'Best of the whole {brand} range'**
  String matchBestOfRange(String brand);

  /// No description provided for @matchNotOwnedLine.
  ///
  /// In en, this message translates to:
  /// **'Not in your collection'**
  String get matchNotOwnedLine;

  /// No description provided for @matchSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all ({count})'**
  String matchSeeAll(int count);

  /// No description provided for @matchSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'No markers in your collection yet'**
  String get matchSubtitleEmpty;

  /// No description provided for @swatchesWholeRangeNotice.
  ///
  /// In en, this message translates to:
  /// **'Showing the whole {brand} range'**
  String swatchesWholeRangeNotice(String brand);

  /// No description provided for @swatchesWholeRangeAction.
  ///
  /// In en, this message translates to:
  /// **'Set up'**
  String get swatchesWholeRangeAction;

  /// No description provided for @matchWholeRangeBody.
  ///
  /// In en, this message translates to:
  /// **'Until you set up your collection, matching uses the whole {brand} range.'**
  String matchWholeRangeBody(String brand);

  /// No description provided for @matchWholeRangeAction.
  ///
  /// In en, this message translates to:
  /// **'Go to My collection'**
  String get matchWholeRangeAction;

  /// No description provided for @collectionTitle.
  ///
  /// In en, this message translates to:
  /// **'My collection'**
  String get collectionTitle;

  /// No description provided for @collectionMarkers.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No markers} =1{1 marker} other{{count} markers}}'**
  String collectionMarkers(int count);

  /// No description provided for @collectionSets.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 set} other{{count} sets}}'**
  String collectionSets(int count);

  /// No description provided for @collectionNotSetUp.
  ///
  /// In en, this message translates to:
  /// **'Not set up yet'**
  String get collectionNotSetUp;

  /// No description provided for @collectionSeriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Series you own'**
  String get collectionSeriesTitle;

  /// No description provided for @collectionHonoluluNote.
  ///
  /// In en, this message translates to:
  /// **'Honolulu B, Honolulu S and Honolulu² use the same colour codes as Honolulu; only the tips differ.'**
  String get collectionHonoluluNote;

  /// No description provided for @collectionSetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sets you own'**
  String get collectionSetsTitle;

  /// No description provided for @collectionSetsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Pick a series to see its sets.'**
  String get collectionSetsEmpty;

  /// No description provided for @collectionOlderSets.
  ///
  /// In en, this message translates to:
  /// **'Older sets ({count})'**
  String collectionOlderSets(int count);

  /// No description provided for @collectionOlderSetsNote.
  ///
  /// In en, this message translates to:
  /// **'Discontinued or regional editions, from community data.'**
  String get collectionOlderSetsNote;

  /// No description provided for @collectionExtrasTitle.
  ///
  /// In en, this message translates to:
  /// **'Extra markers'**
  String get collectionExtrasTitle;

  /// No description provided for @collectionExtrasHint.
  ///
  /// In en, this message translates to:
  /// **'Bought single markers? Tick them here. Markers in your sets already count.'**
  String get collectionExtrasHint;

  /// No description provided for @collectionDecoMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Your markers'**
  String get collectionDecoMarkersTitle;

  /// No description provided for @collectionIndividualMarkersShort.
  ///
  /// In en, this message translates to:
  /// **'Tick the ones you have'**
  String get collectionIndividualMarkersShort;

  /// No description provided for @collectionDecoHint.
  ///
  /// In en, this message translates to:
  /// **'DecoTime does not publish which colours each set holds, so tick the ones you own or add a whole family.'**
  String get collectionDecoHint;

  /// No description provided for @collectionDecoSizesHint.
  ///
  /// In en, this message translates to:
  /// **'Action sells DecoTime sets of 100, 150, 160, 200 and 300 markers.'**
  String get collectionDecoSizesHint;

  /// No description provided for @collectionFamiliesTitle.
  ///
  /// In en, this message translates to:
  /// **'Add by family'**
  String get collectionFamiliesTitle;

  /// No description provided for @collectionFamilyChip.
  ///
  /// In en, this message translates to:
  /// **'{family} {owned}/{total}'**
  String collectionFamilyChip(String family, int owned, int total);

  /// No description provided for @collectionFamilyColours.
  ///
  /// In en, this message translates to:
  /// **'Colours'**
  String get collectionFamilyColours;

  /// No description provided for @collectionFamilyWarmGrey.
  ///
  /// In en, this message translates to:
  /// **'Warm greys'**
  String get collectionFamilyWarmGrey;

  /// No description provided for @collectionFamilyCoolGrey.
  ///
  /// In en, this message translates to:
  /// **'Cool greys'**
  String get collectionFamilyCoolGrey;

  /// No description provided for @collectionFamilyBlueGrey.
  ///
  /// In en, this message translates to:
  /// **'Blue greys'**
  String get collectionFamilyBlueGrey;

  /// No description provided for @collectionFamilyGreenGrey.
  ///
  /// In en, this message translates to:
  /// **'Green greys'**
  String get collectionFamilyGreenGrey;

  /// No description provided for @collectionImportCodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Import codes'**
  String get collectionImportCodesTitle;

  /// No description provided for @collectionImportCodesHint.
  ///
  /// In en, this message translates to:
  /// **'Paste a list of codes'**
  String get collectionImportCodesHint;

  /// No description provided for @collectionDecoRange.
  ///
  /// In en, this message translates to:
  /// **'DecoTime range'**
  String get collectionDecoRange;

  /// No description provided for @collectionWholeRange.
  ///
  /// In en, this message translates to:
  /// **'Whole range'**
  String get collectionWholeRange;

  /// No description provided for @collectionSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search code or name'**
  String get collectionSearchHint;

  /// No description provided for @collectionTickVisible.
  ///
  /// In en, this message translates to:
  /// **'Tick all'**
  String get collectionTickVisible;

  /// No description provided for @collectionTickManyTitle.
  ///
  /// In en, this message translates to:
  /// **'Tick {count} markers?'**
  String collectionTickManyTitle(int count);

  /// No description provided for @collectionTickManyBody.
  ///
  /// In en, this message translates to:
  /// **'They all count as markers you own. You can take them out again with “Untick all”.'**
  String get collectionTickManyBody;

  /// No description provided for @collectionUntickVisible.
  ///
  /// In en, this message translates to:
  /// **'Untick all'**
  String get collectionUntickVisible;

  /// No description provided for @collectionRemoveMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Remove 1 marker?} other{Remove {count} markers?}}'**
  String collectionRemoveMarkersTitle(int count);

  /// No description provided for @collectionRemoveFromTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Remove 1 marker of {name}?} other{Remove {count} markers of {name}?}}'**
  String collectionRemoveFromTitle(int count, String name);

  /// No description provided for @collectionRemoveMarkersBody.
  ///
  /// In en, this message translates to:
  /// **'The markers you already own leave your collection. You can add them again at any time.'**
  String get collectionRemoveMarkersBody;

  /// No description provided for @collectionRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get collectionRemoveConfirm;

  /// No description provided for @collectionReplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace your collection?'**
  String get collectionReplaceTitle;

  /// No description provided for @collectionReplaceBody.
  ///
  /// In en, this message translates to:
  /// **'When the setup ends, the sets and markers you own now are replaced by the ones you choose here.'**
  String get collectionReplaceBody;

  /// No description provided for @collectionReplaceConfirm.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get collectionReplaceConfirm;

  /// No description provided for @collectionInYourSets.
  ///
  /// In en, this message translates to:
  /// **'In your set'**
  String get collectionInYourSets;

  /// No description provided for @collectionNoResults.
  ///
  /// In en, this message translates to:
  /// **'No marker matches the search.'**
  String get collectionNoResults;

  /// No description provided for @collectionReset.
  ///
  /// In en, this message translates to:
  /// **'Reset collection'**
  String get collectionReset;

  /// No description provided for @collectionOwnedGroup.
  ///
  /// In en, this message translates to:
  /// **'What you own'**
  String get collectionOwnedGroup;

  /// No description provided for @collectionShoppingGroup.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get collectionShoppingGroup;

  /// No description provided for @collectionToolsGroup.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get collectionToolsGroup;

  /// No description provided for @toolsMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Colour map'**
  String get toolsMapTitle;

  /// No description provided for @toolsMapHint.
  ///
  /// In en, this message translates to:
  /// **'Where your markers sit by hue and value, and where the gaps are.'**
  String get toolsMapHint;

  /// No description provided for @toolsTranslateTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate a recipe'**
  String get toolsTranslateTitle;

  /// No description provided for @toolsTranslateHint.
  ///
  /// In en, this message translates to:
  /// **'Turn a tutorial\'s marker codes into the closest ones you own.'**
  String get toolsTranslateHint;

  /// No description provided for @toolsBlendsTitle.
  ///
  /// In en, this message translates to:
  /// **'My recipes'**
  String get toolsBlendsTitle;

  /// No description provided for @toolsBlendsHint.
  ///
  /// In en, this message translates to:
  /// **'Blends you save: markers in order, a note and a photo.'**
  String get toolsBlendsHint;

  /// No description provided for @toolsTransferTitle.
  ///
  /// In en, this message translates to:
  /// **'Export and import'**
  String get toolsTransferTitle;

  /// No description provided for @toolsTransferHint.
  ///
  /// In en, this message translates to:
  /// **'Share your markers as a list or CSV, or add many by code.'**
  String get toolsTransferHint;

  /// No description provided for @toolsMapIntro.
  ///
  /// In en, this message translates to:
  /// **'Each dot is a marker you own. Hatched areas have none.'**
  String get toolsMapIntro;

  /// No description provided for @toolsMapShowRange.
  ///
  /// In en, this message translates to:
  /// **'Show the whole range'**
  String get toolsMapShowRange;

  /// No description provided for @toolsMapShowRangeHint.
  ///
  /// In en, this message translates to:
  /// **'Faint dots for every marker of your brands, to see what is missing.'**
  String get toolsMapShowRangeHint;

  /// No description provided for @toolsMapAxes.
  ///
  /// In en, this message translates to:
  /// **'Left to right: hue. Top to bottom: light to dark.'**
  String get toolsMapAxes;

  /// No description provided for @toolsMapGreysTitle.
  ///
  /// In en, this message translates to:
  /// **'Greys and neutrals'**
  String get toolsMapGreysTitle;

  /// No description provided for @toolsMapGreysAxis.
  ///
  /// In en, this message translates to:
  /// **'Left to right: dark to light.'**
  String get toolsMapGreysAxis;

  /// No description provided for @toolsMapFamiliesTitle.
  ///
  /// In en, this message translates to:
  /// **'By hue'**
  String get toolsMapFamiliesTitle;

  /// No description provided for @toolsHueRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get toolsHueRed;

  /// No description provided for @toolsHueOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get toolsHueOrange;

  /// No description provided for @toolsHueYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get toolsHueYellow;

  /// No description provided for @toolsHueGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get toolsHueGreen;

  /// No description provided for @toolsHueTeal.
  ///
  /// In en, this message translates to:
  /// **'Teal'**
  String get toolsHueTeal;

  /// No description provided for @toolsHueBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get toolsHueBlue;

  /// No description provided for @toolsHueViolet.
  ///
  /// In en, this message translates to:
  /// **'Violet'**
  String get toolsHueViolet;

  /// No description provided for @toolsHueMagenta.
  ///
  /// In en, this message translates to:
  /// **'Magenta'**
  String get toolsHueMagenta;

  /// How many markers of one hue band are light, mid-tone and dark.
  ///
  /// In en, this message translates to:
  /// **'Light {light} · Mid {mid} · Dark {dark}'**
  String toolsFamilyBands(int light, int mid, int dark);

  /// No description provided for @toolsMapDriedNote.
  ///
  /// In en, this message translates to:
  /// **'Dried-out markers are left out.'**
  String get toolsMapDriedNote;

  /// Spoken summary of the colour map chart: the number of markers (already worded, for example "12 markers"), how many of the grid cells are empty and how many cells there are.
  ///
  /// In en, this message translates to:
  /// **'Colour map of {markers}. {empty} of {cells} areas have no marker. The list below has the same markers by hue.'**
  String toolsMapSummary(String markers, int empty, int cells);

  /// No description provided for @toolsMarkerOwned.
  ///
  /// In en, this message translates to:
  /// **'In your collection'**
  String get toolsMarkerOwned;

  /// No description provided for @toolsMarkerNotOwned.
  ///
  /// In en, this message translates to:
  /// **'Not in your collection'**
  String get toolsMarkerNotOwned;

  /// No description provided for @toolsTranslateIntro.
  ///
  /// In en, this message translates to:
  /// **'Type or paste the marker codes of a tutorial, in the brand it uses. Commas, spaces and lists all work.'**
  String get toolsTranslateIntro;

  /// No description provided for @toolsTranslateBrand.
  ///
  /// In en, this message translates to:
  /// **'Recipe brand'**
  String get toolsTranslateBrand;

  /// No description provided for @toolsTranslateCodes.
  ///
  /// In en, this message translates to:
  /// **'Marker codes'**
  String get toolsTranslateCodes;

  /// No description provided for @toolsTranslateResults.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get toolsTranslateResults;

  /// No description provided for @toolsTranslateEmpty.
  ///
  /// In en, this message translates to:
  /// **'The codes you type appear here.'**
  String get toolsTranslateEmpty;

  /// No description provided for @toolsTranslateMine.
  ///
  /// In en, this message translates to:
  /// **'Closest you own'**
  String get toolsTranslateMine;

  /// No description provided for @toolsTranslateNotOwned.
  ///
  /// In en, this message translates to:
  /// **'Not owned'**
  String get toolsTranslateNotOwned;

  /// No description provided for @toolsTranslateMissing.
  ///
  /// In en, this message translates to:
  /// **'Nothing close in your collection.'**
  String get toolsTranslateMissing;

  /// No description provided for @toolsTranslateUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not found in {brand}'**
  String toolsTranslateUnknown(String brand);

  /// No description provided for @toolsCopyList.
  ///
  /// In en, this message translates to:
  /// **'Copy list'**
  String get toolsCopyList;

  /// No description provided for @toolsShareList.
  ///
  /// In en, this message translates to:
  /// **'Share list'**
  String get toolsShareList;

  /// No description provided for @toolsListCopied.
  ///
  /// In en, this message translates to:
  /// **'List copied.'**
  String get toolsListCopied;

  /// No description provided for @toolsShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not share the list.'**
  String get toolsShareFailed;

  /// No description provided for @toolsBlendsNew.
  ///
  /// In en, this message translates to:
  /// **'New recipe'**
  String get toolsBlendsNew;

  /// No description provided for @toolsBlendsEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit recipe'**
  String get toolsBlendsEditTitle;

  /// No description provided for @toolsBlendsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No recipes yet'**
  String get toolsBlendsEmptyTitle;

  /// No description provided for @toolsBlendsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Save the blends you like: markers in order, a note and a photo.'**
  String get toolsBlendsEmptyBody;

  /// No description provided for @toolsBlendsName.
  ///
  /// In en, this message translates to:
  /// **'Recipe name'**
  String get toolsBlendsName;

  /// No description provided for @toolsBlendsMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Markers, in order'**
  String get toolsBlendsMarkersTitle;

  /// No description provided for @toolsBlendsMarkersHelp.
  ///
  /// In en, this message translates to:
  /// **'Drag the handle to change the order.'**
  String get toolsBlendsMarkersHelp;

  /// No description provided for @toolsBlendsDrag.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get toolsBlendsDrag;

  /// No description provided for @toolsBlendsRemoveMarker.
  ///
  /// In en, this message translates to:
  /// **'Remove {code}'**
  String toolsBlendsRemoveMarker(String code);

  /// No description provided for @toolsBlendsNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get toolsBlendsNote;

  /// No description provided for @toolsBlendsPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Photo of the result'**
  String get toolsBlendsPhotoTitle;

  /// No description provided for @toolsBlendsPhotoHelp.
  ///
  /// In en, this message translates to:
  /// **'Optional. It stays on this phone.'**
  String get toolsBlendsPhotoHelp;

  /// No description provided for @toolsBlendsPhotoSemantic.
  ///
  /// In en, this message translates to:
  /// **'Photo of the recipe'**
  String get toolsBlendsPhotoSemantic;

  /// No description provided for @toolsBlendsSave.
  ///
  /// In en, this message translates to:
  /// **'Save recipe'**
  String get toolsBlendsSave;

  /// No description provided for @toolsBlendsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete recipe'**
  String get toolsBlendsDelete;

  /// No description provided for @toolsBlendsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this recipe?'**
  String get toolsBlendsDeleteTitle;

  /// No description provided for @toolsBlendsDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The recipe and its photo will be removed from this phone.'**
  String get toolsBlendsDeleteBody;

  /// No description provided for @toolsTransferExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get toolsTransferExport;

  /// No description provided for @toolsTransferBrands.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 brand} other{{count} brands}}'**
  String toolsTransferBrands(int count);

  /// No description provided for @toolsTransferExportBrands.
  ///
  /// In en, this message translates to:
  /// **'Includes every brand you own: {brands}.'**
  String toolsTransferExportBrands(String brands);

  /// No description provided for @toolsTransferCsv.
  ///
  /// In en, this message translates to:
  /// **'Share as CSV'**
  String get toolsTransferCsv;

  /// No description provided for @toolsTransferImport.
  ///
  /// In en, this message translates to:
  /// **'Import by code'**
  String get toolsTransferImport;

  /// No description provided for @toolsTransferImportHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose the brand and paste its codes. Nothing is added until you press the button.'**
  String get toolsTransferImportHelp;

  /// No description provided for @toolsTransferNew.
  ///
  /// In en, this message translates to:
  /// **'New markers'**
  String get toolsTransferNew;

  /// No description provided for @toolsTransferAlready.
  ///
  /// In en, this message translates to:
  /// **'Already yours'**
  String get toolsTransferAlready;

  /// No description provided for @toolsTransferUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not recognised'**
  String get toolsTransferUnknown;

  /// No description provided for @toolsTransferAdd.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Add markers} =1{Add 1 marker} other{Add {count} markers}}'**
  String toolsTransferAdd(int count);

  /// No description provided for @toolsTransferAdded.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 marker added.} other{{count} markers added.}}'**
  String toolsTransferAdded(int count);

  /// No description provided for @commonSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all ({count})'**
  String commonSeeAll(int count);

  /// No description provided for @collectionChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Printable swatch chart'**
  String get collectionChartTitle;

  /// No description provided for @swatchesOtherBrandsTitle.
  ///
  /// In en, this message translates to:
  /// **'In other brands'**
  String get swatchesOtherBrandsTitle;

  /// No description provided for @swatchesOtherBrandsOnlyMine.
  ///
  /// In en, this message translates to:
  /// **'Only mine'**
  String get swatchesOtherBrandsOnlyMine;

  /// No description provided for @swatchesOtherBrandsNone.
  ///
  /// In en, this message translates to:
  /// **'There is no other brand to compare with.'**
  String get swatchesOtherBrandsNone;

  /// No description provided for @swatchesOtherBrandsNoneMine.
  ///
  /// In en, this message translates to:
  /// **'You have no usable markers in other brands.'**
  String get swatchesOtherBrandsNoneMine;

  /// No description provided for @swatchesOtherBrandsFailed.
  ///
  /// In en, this message translates to:
  /// **'The other brands could not be read.'**
  String get swatchesOtherBrandsFailed;

  /// No description provided for @swatchesOtherBrandsPaletteNote.
  ///
  /// In en, this message translates to:
  /// **'Palettes use the brand chosen in Settings, so this marker cannot be added to one.'**
  String get swatchesOtherBrandsPaletteNote;

  /// No description provided for @paletteVisionTitle.
  ///
  /// In en, this message translates to:
  /// **'Colour vision'**
  String get paletteVisionTitle;

  /// No description provided for @paletteVisionNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get paletteVisionNormal;

  /// No description provided for @paletteVisionProtanopia.
  ///
  /// In en, this message translates to:
  /// **'Protanopia'**
  String get paletteVisionProtanopia;

  /// No description provided for @paletteVisionDeuteranopia.
  ///
  /// In en, this message translates to:
  /// **'Deuteranopia'**
  String get paletteVisionDeuteranopia;

  /// No description provided for @paletteVisionTritanopia.
  ///
  /// In en, this message translates to:
  /// **'Tritanopia'**
  String get paletteVisionTritanopia;

  /// No description provided for @paletteVisionAchromatopsia.
  ///
  /// In en, this message translates to:
  /// **'Achromatopsia'**
  String get paletteVisionAchromatopsia;

  /// No description provided for @paletteVisionPairs.
  ///
  /// In en, this message translates to:
  /// **'Hard to tell apart: {pairs}'**
  String paletteVisionPairs(String pairs);

  /// No description provided for @paletteVisionPairsMore.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  String paletteVisionPairsMore(int count);

  /// No description provided for @paletteVisionNoPairs.
  ///
  /// In en, this message translates to:
  /// **'Every colour stays easy to tell apart.'**
  String get paletteVisionNoPairs;

  /// No description provided for @paletteVisionPreviewNote.
  ///
  /// In en, this message translates to:
  /// **'Preview only. Saving and sharing keep the true colours.'**
  String get paletteVisionPreviewNote;

  /// No description provided for @paletteEaselTitle.
  ///
  /// In en, this message translates to:
  /// **'Easel mode'**
  String get paletteEaselTitle;

  /// No description provided for @paletteEaselExit.
  ///
  /// In en, this message translates to:
  /// **'Exit easel mode'**
  String get paletteEaselExit;

  /// No description provided for @paletteShareTextButton.
  ///
  /// In en, this message translates to:
  /// **'Share as text'**
  String get paletteShareTextButton;

  /// No description provided for @paletteTextHeader.
  ///
  /// In en, this message translates to:
  /// **'Ink Lab palette · {brand} · {title}'**
  String paletteTextHeader(String brand, String title);

  /// No description provided for @paletteImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Import from text'**
  String get paletteImportTitle;

  /// No description provided for @paletteImportHint.
  ///
  /// In en, this message translates to:
  /// **'Paste a shared palette or a list of marker codes.'**
  String get paletteImportHint;

  /// No description provided for @paletteImportPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paletteImportPaste;

  /// No description provided for @paletteImportAction.
  ///
  /// In en, this message translates to:
  /// **'Load palette'**
  String get paletteImportAction;

  /// No description provided for @paletteImportNothing.
  ///
  /// In en, this message translates to:
  /// **'No marker codes found in this text.'**
  String get paletteImportNothing;

  /// No description provided for @paletteImportNoneKnown.
  ///
  /// In en, this message translates to:
  /// **'None of these codes belongs to {brand}: {codes}.'**
  String paletteImportNoneKnown(String brand, String codes);

  /// No description provided for @paletteImportNoneKnownMixed.
  ///
  /// In en, this message translates to:
  /// **'None of these codes belongs to your brands: {codes}.'**
  String paletteImportNoneKnownMixed(String codes);

  /// No description provided for @paletteImportOtherBrand.
  ///
  /// In en, this message translates to:
  /// **'This palette is for {brand}. Change the brand in Settings to import it.'**
  String paletteImportOtherBrand(String brand);

  /// No description provided for @paletteImportDone.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Imported a palette of 1 marker.} other{Imported a palette of {count} markers.}}'**
  String paletteImportDone(int count);

  /// No description provided for @paletteImportUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not recognised: {codes}.'**
  String paletteImportUnknown(String codes);

  /// No description provided for @paletteImportRepeated.
  ///
  /// In en, this message translates to:
  /// **'Repeated codes were counted once.'**
  String get paletteImportRepeated;

  /// No description provided for @collectionChartHint.
  ///
  /// In en, this message translates to:
  /// **'Empty boxes labelled with the code and name of each marker you own, to swatch your real markers. Shared as A4 images to print or save.'**
  String get collectionChartHint;

  /// No description provided for @collectionChartShowColour.
  ///
  /// In en, this message translates to:
  /// **'Catalogue colour'**
  String get collectionChartShowColour;

  /// No description provided for @collectionChartShowColourHint.
  ///
  /// In en, this message translates to:
  /// **'Show it as a thin strip in each box, to compare.'**
  String get collectionChartShowColourHint;

  /// No description provided for @collectionChartCreate.
  ///
  /// In en, this message translates to:
  /// **'Create and share'**
  String get collectionChartCreate;

  /// No description provided for @collectionChartPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing…'**
  String get collectionChartPreparing;

  /// No description provided for @collectionChartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Choose your sets or markers first.'**
  String get collectionChartEmpty;

  /// No description provided for @collectionChartPages.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 page} other{{count} pages}}'**
  String collectionChartPages(int count);

  /// Subtitle drawn inside each page of the printable swatch chart image.
  ///
  /// In en, this message translates to:
  /// **'Swatch chart'**
  String get chartImageTitle;

  /// Page number drawn inside each page of the printable swatch chart image.
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {total}'**
  String chartImagePage(int page, int total);

  /// No description provided for @collectionResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your {brand} collection?'**
  String collectionResetTitle(String brand);

  /// No description provided for @collectionResetBody.
  ///
  /// In en, this message translates to:
  /// **'Your sets and extra markers of this brand are removed. Favourites and palettes stay.'**
  String get collectionResetBody;

  /// No description provided for @collectionOwnedCount.
  ///
  /// In en, this message translates to:
  /// **'{owned} of {total}'**
  String collectionOwnedCount(int owned, int total);

  /// No description provided for @collectionLooseTicked.
  ///
  /// In en, this message translates to:
  /// **'{loose} loose ticked · {sets} in your sets'**
  String collectionLooseTicked(int loose, int sets);

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ink Lab'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Browse your markers, match colours from photos and build palettes. First, tell us which markers you have.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingOhuhuLine.
  ///
  /// In en, this message translates to:
  /// **'Sets by series: Oahu, Honolulu, Kaala'**
  String get onboardingOhuhuLine;

  /// No description provided for @onboardingDecoLine.
  ///
  /// In en, this message translates to:
  /// **'One range of 313 colours, sets at Action'**
  String get onboardingDecoLine;

  /// No description provided for @onboardingSeriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Which series do you have?'**
  String get onboardingSeriesTitle;

  /// No description provided for @onboardingSeriesBody.
  ///
  /// In en, this message translates to:
  /// **'Pick every series you have markers from.'**
  String get onboardingSeriesBody;

  /// No description provided for @onboardingSetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Which sets do you have?'**
  String get onboardingSetsTitle;

  /// No description provided for @onboardingSetsBody.
  ///
  /// In en, this message translates to:
  /// **'Pick the boxes you bought. Extra markers can be added later.'**
  String get onboardingSetsBody;

  /// No description provided for @onboardingDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'All set'**
  String get onboardingDoneTitle;

  /// No description provided for @onboardingLaterNote.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in My collection.'**
  String get onboardingLaterNote;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @onboardingFinish.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboardingFinish;

  /// Header of the first setup step: no total, because the number of steps depends on the brand chosen here.
  ///
  /// In en, this message translates to:
  /// **'Step 1'**
  String get onboardingStepFirst;

  /// Preview card of the markers step in the first-run setup: how many markers of the brand are ticked.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ticked} other{{count} ticked}}'**
  String onboardingMarkersTicked(int count);

  /// Status line of the markers card in the first-run setup when nothing is ticked yet: the size of the brand's range follows, for example 'None ticked yet · 358 colours'.
  ///
  /// In en, this message translates to:
  /// **'None ticked yet · {range}'**
  String onboardingMarkersNoneTicked(String range);

  /// No description provided for @onboardingStep.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String onboardingStep(int step, int total);

  /// No description provided for @collectionSeriesOahuTips.
  ///
  /// In en, this message translates to:
  /// **'Fine and chisel tips'**
  String get collectionSeriesOahuTips;

  /// No description provided for @collectionSeriesHonoluluTips.
  ///
  /// In en, this message translates to:
  /// **'Brush and chisel tips'**
  String get collectionSeriesHonoluluTips;

  /// No description provided for @collectionSeriesKaalaTips.
  ///
  /// In en, this message translates to:
  /// **'Brush tip'**
  String get collectionSeriesKaalaTips;

  /// No description provided for @collectionSummaryNoSets.
  ///
  /// In en, this message translates to:
  /// **'No sets yet: Match and Swatches show the whole range; Palette and Ideas need markers you own'**
  String get collectionSummaryNoSets;

  /// No description provided for @collectionSummaryNoMarkers.
  ///
  /// In en, this message translates to:
  /// **'You have not ticked any markers yet'**
  String get collectionSummaryNoMarkers;

  /// No description provided for @collectionExtrasAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add loose markers'**
  String get collectionExtrasAddTitle;

  /// No description provided for @collectionDecoMarkersButton.
  ///
  /// In en, this message translates to:
  /// **'Tick your markers'**
  String get collectionDecoMarkersButton;

  /// No description provided for @collectionExtrasCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No loose markers} =1{1 loose marker} other{{count} loose markers}}'**
  String collectionExtrasCount(int count);

  /// No description provided for @wishlistTitle.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlistTitle;

  /// No description provided for @wishlistCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Nothing on your wishlist yet} =1{1 marker to buy} other{{count} markers to buy}}'**
  String wishlistCount(int count);

  /// No description provided for @wishlistSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add them from a colour\'s details'**
  String get wishlistSubtitle;

  /// No description provided for @wishlistEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add the markers you want to buy from the detail of any marker.'**
  String get wishlistEmpty;

  /// No description provided for @wishlistAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to wishlist'**
  String get wishlistAdd;

  /// No description provided for @wishlistRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from wishlist'**
  String get wishlistRemove;

  /// No description provided for @wishlistCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy list'**
  String get wishlistCopy;

  /// No description provided for @wishlistCopied.
  ///
  /// In en, this message translates to:
  /// **'Shopping list copied'**
  String get wishlistCopied;

  /// No description provided for @wishlistOfferTitle.
  ///
  /// In en, this message translates to:
  /// **'Add to your wishlist?'**
  String get wishlistOfferTitle;

  /// No description provided for @wishlistOfferBody.
  ///
  /// In en, this message translates to:
  /// **'{code} is dried out. Add it to your wishlist to buy a refill or a replacement.'**
  String wishlistOfferBody(String code);

  /// No description provided for @driedTitle.
  ///
  /// In en, this message translates to:
  /// **'Dried out'**
  String get driedTitle;

  /// No description provided for @driedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No dried out markers} =1{1 dried out marker} other{{count} dried out markers}}'**
  String driedCount(int count);

  /// No description provided for @driedHint.
  ///
  /// In en, this message translates to:
  /// **'They stay in your collection, but Match, Palette and Ideas do not suggest them.'**
  String get driedHint;

  /// No description provided for @driedEmpty.
  ///
  /// In en, this message translates to:
  /// **'When a marker stops working, mark it as dried out from its detail.'**
  String get driedEmpty;

  /// No description provided for @driedMark.
  ///
  /// In en, this message translates to:
  /// **'Mark as dried out'**
  String get driedMark;

  /// No description provided for @driedUnmark.
  ///
  /// In en, this message translates to:
  /// **'Mark as usable'**
  String get driedUnmark;

  /// No description provided for @driedNote.
  ///
  /// In en, this message translates to:
  /// **'Dried out: Match, Palette and Ideas skip it until you mark it as usable.'**
  String get driedNote;

  /// No description provided for @commonDried.
  ///
  /// In en, this message translates to:
  /// **'Dried out'**
  String get commonDried;

  /// No description provided for @buyNextTitle.
  ///
  /// In en, this message translates to:
  /// **'What to buy next'**
  String get buyNextTitle;

  /// No description provided for @buyNextIntro.
  ///
  /// In en, this message translates to:
  /// **'Markers you do not have that would bring your colours closest to the most scenes.'**
  String get buyNextIntro;

  /// No description provided for @buyNextReasonScenes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Improves 1 scene: {scenes}} other{Improves {count} scenes: {scenes}}}'**
  String buyNextReasonScenes(int count, String scenes);

  /// No description provided for @buyNextReasonGap.
  ///
  /// In en, this message translates to:
  /// **'Fills a gap in your range of colours'**
  String get buyNextReasonGap;

  /// No description provided for @buyNextNoCollection.
  ///
  /// In en, this message translates to:
  /// **'Tick the markers you own to see what to buy next.'**
  String get buyNextNoCollection;

  /// No description provided for @buyNextComplete.
  ///
  /// In en, this message translates to:
  /// **'Nothing to suggest: your markers already cover every scene well.'**
  String get buyNextComplete;

  /// No description provided for @buyNextRefill.
  ///
  /// In en, this message translates to:
  /// **'Dried out: a refill brings it back.'**
  String get buyNextRefill;

  /// No description provided for @onboardingDoneWholeRange.
  ///
  /// In en, this message translates to:
  /// **'Until you pick sets, Match and Swatches show the whole {brand} range. Palette and Ideas need the markers you own.'**
  String onboardingDoneWholeRange(String brand);

  /// No description provided for @onboardingDoneNext.
  ///
  /// In en, this message translates to:
  /// **'What next: browse colours in Swatches, match a photo in Match or build a palette in Palette.'**
  String get onboardingDoneNext;

  /// No description provided for @collectionVisibleScope.
  ///
  /// In en, this message translates to:
  /// **'Applies to the markers that match your search.'**
  String get collectionVisibleScope;

  /// No description provided for @matchWhiteBalanceButton.
  ///
  /// In en, this message translates to:
  /// **'Fix white balance'**
  String get matchWhiteBalanceButton;

  /// No description provided for @matchWhiteBalanceHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a point of the photo that should be white paper.'**
  String get matchWhiteBalanceHint;

  /// No description provided for @matchWhiteBalanceOn.
  ///
  /// In en, this message translates to:
  /// **'White balance on'**
  String get matchWhiteBalanceOn;

  /// No description provided for @matchWhiteBalanceReset.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get matchWhiteBalanceReset;

  /// No description provided for @matchWhiteBalanceTooDark.
  ///
  /// In en, this message translates to:
  /// **'That point is too dark to be paper. Pick a lighter one.'**
  String get matchWhiteBalanceTooDark;

  /// No description provided for @matchWhiteBalanceTooColourful.
  ///
  /// In en, this message translates to:
  /// **'That point has too much colour to be paper. Pick a white area.'**
  String get matchWhiteBalanceTooColourful;

  /// No description provided for @commonOwnColour.
  ///
  /// In en, this message translates to:
  /// **'My colour'**
  String get commonOwnColour;

  /// No description provided for @swatchesMyColourTitle.
  ///
  /// In en, this message translates to:
  /// **'My colour'**
  String get swatchesMyColourTitle;

  /// No description provided for @swatchesMyColourHelp.
  ///
  /// In en, this message translates to:
  /// **'Catalogue colours are estimates. Store the colour your marker really gives on paper.'**
  String get swatchesMyColourHelp;

  /// No description provided for @swatchesMyColourReset.
  ///
  /// In en, this message translates to:
  /// **'Back to catalogue'**
  String get swatchesMyColourReset;

  /// No description provided for @swatchesMyColourSaved.
  ///
  /// In en, this message translates to:
  /// **'Your colour was saved'**
  String get swatchesMyColourSaved;

  /// No description provided for @swatchesMyColourWasReset.
  ///
  /// In en, this message translates to:
  /// **'Back to the catalogue colour'**
  String get swatchesMyColourWasReset;

  /// No description provided for @swatchesMyColourSame.
  ///
  /// In en, this message translates to:
  /// **'Same as the catalogue'**
  String get swatchesMyColourSame;

  /// The colour the user stored for this marker, for example "Yours: #0A0B0C".
  ///
  /// In en, this message translates to:
  /// **'Yours: {hex}'**
  String swatchesMyColourValue(String hex);

  /// No description provided for @swatchesStatusWished.
  ///
  /// In en, this message translates to:
  /// **'On your wishlist'**
  String get swatchesStatusWished;

  /// No description provided for @swatchesDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get swatchesDetailsTitle;

  /// No description provided for @swatchesCatalogueLabel.
  ///
  /// In en, this message translates to:
  /// **'Catalogue'**
  String get swatchesCatalogueLabel;

  /// No description provided for @swatchesMineLabel.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get swatchesMineLabel;

  /// No description provided for @ownColorTitle.
  ///
  /// In en, this message translates to:
  /// **'My colour for {code}'**
  String ownColorTitle(String code);

  /// No description provided for @ownColorHexLabel.
  ///
  /// In en, this message translates to:
  /// **'Hex colour'**
  String get ownColorHexLabel;

  /// No description provided for @ownColorHexInvalid.
  ///
  /// In en, this message translates to:
  /// **'Type 3 or 6 hex digits, like 3A7F9C.'**
  String get ownColorHexInvalid;

  /// No description provided for @ownColorPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'From a photo'**
  String get ownColorPhotoTitle;

  /// No description provided for @ownColorPhotoHelp.
  ///
  /// In en, this message translates to:
  /// **'Paint the marker on white paper, take a photo and tap the painted area.'**
  String get ownColorPhotoHelp;

  /// No description provided for @ownColorPhotoTap.
  ///
  /// In en, this message translates to:
  /// **'Tap the painted area.'**
  String get ownColorPhotoTap;

  /// No description provided for @ownColorSave.
  ///
  /// In en, this message translates to:
  /// **'Save my colour'**
  String get ownColorSave;

  /// No description provided for @settingsOwnColors.
  ///
  /// In en, this message translates to:
  /// **'Use my colours'**
  String get settingsOwnColors;

  /// No description provided for @settingsOwnColorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Match, Palette and Ideas use the colour you stored for a marker instead of the catalogue one.'**
  String get settingsOwnColorsSubtitle;

  /// No description provided for @settingsOwnColorsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No colours of your own yet} =1{1 colour of your own} other{{count} colours of your own}}'**
  String settingsOwnColorsCount(int count);

  /// No description provided for @settingsOwnColorsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get settingsOwnColorsReset;

  /// No description provided for @settingsOwnColorsResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your colours?'**
  String get settingsOwnColorsResetTitle;

  /// No description provided for @settingsOwnColorsResetBody.
  ///
  /// In en, this message translates to:
  /// **'Every marker goes back to its catalogue colour. This cannot be undone.'**
  String get settingsOwnColorsResetBody;

  /// No description provided for @settingsJoinBeta.
  ///
  /// In en, this message translates to:
  /// **'Join the Google Play beta'**
  String get settingsJoinBeta;

  /// No description provided for @collectionCopicHint.
  ///
  /// In en, this message translates to:
  /// **'Copic markers are bought one by one. Tick the markers you own.'**
  String get collectionCopicHint;

  /// No description provided for @collectionFinecolourHint.
  ///
  /// In en, this message translates to:
  /// **'Finecolour markers are bought one by one. Tick the markers you own.'**
  String get collectionFinecolourHint;

  /// No description provided for @onboardingCopicLine.
  ///
  /// In en, this message translates to:
  /// **'358 colours · Mark the markers you own'**
  String get onboardingCopicLine;

  /// No description provided for @onboardingFinecolourLine.
  ///
  /// In en, this message translates to:
  /// **'480 colours · Mark the markers you own'**
  String get onboardingFinecolourLine;

  /// No description provided for @onboardingMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Your {brand} markers'**
  String onboardingMarkersTitle(String brand);

  /// No description provided for @onboardingNoMarkers.
  ///
  /// In en, this message translates to:
  /// **'You have not ticked any {brand} markers yet: tick them in My collection.'**
  String onboardingNoMarkers(String brand);

  /// No description provided for @ideasDiarySegment.
  ///
  /// In en, this message translates to:
  /// **'Diary'**
  String get ideasDiarySegment;

  /// No description provided for @ideasDiarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your artworks, newest first'**
  String get ideasDiarySubtitle;

  /// No description provided for @diaryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your diary is empty'**
  String get diaryEmptyTitle;

  /// No description provided for @diaryEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Log the pages and sheets you paint, with their markers, notes and photos.'**
  String get diaryEmptyMessage;

  /// No description provided for @diaryAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to diary'**
  String get diaryAdd;

  /// Tooltip and screen reader label of the button that shares a diary entry as an image.
  ///
  /// In en, this message translates to:
  /// **'Share this entry'**
  String get diaryShareButton;

  /// No description provided for @diaryStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get diaryStatusLabel;

  /// No description provided for @diaryStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get diaryStatusInProgress;

  /// No description provided for @diaryStatusFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get diaryStatusFinished;

  /// No description provided for @diaryNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New entry'**
  String get diaryNewTitle;

  /// No description provided for @diaryEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit entry'**
  String get diaryEditTitle;

  /// No description provided for @diaryTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get diaryTitleLabel;

  /// No description provided for @diaryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get diaryDateLabel;

  /// No description provided for @diaryOnWhatLabel.
  ///
  /// In en, this message translates to:
  /// **'Painted on'**
  String get diaryOnWhatLabel;

  /// No description provided for @diaryOnWhatHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. a colouring book or a sketchbook'**
  String get diaryOnWhatHint;

  /// No description provided for @diaryMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Markers used'**
  String get diaryMarkersTitle;

  /// No description provided for @diaryMarkersChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose markers'**
  String get diaryMarkersChoose;

  /// No description provided for @diaryMarkerRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove {code}'**
  String diaryMarkerRemove(String code);

  /// No description provided for @diaryPaletteTitle.
  ///
  /// In en, this message translates to:
  /// **'Palette'**
  String get diaryPaletteTitle;

  /// No description provided for @diaryPaletteNone.
  ///
  /// In en, this message translates to:
  /// **'No palette'**
  String get diaryPaletteNone;

  /// No description provided for @diaryPaletteChoose.
  ///
  /// In en, this message translates to:
  /// **'Link a saved palette'**
  String get diaryPaletteChoose;

  /// No description provided for @diaryPaletteMissing.
  ///
  /// In en, this message translates to:
  /// **'This palette is no longer saved.'**
  String get diaryPaletteMissing;

  /// No description provided for @diaryPaletteEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no saved palettes yet.'**
  String get diaryPaletteEmpty;

  /// No description provided for @diaryNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get diaryNotesLabel;

  /// No description provided for @diaryNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Technique, paper, blending...'**
  String get diaryNotesHint;

  /// Title of the collapsed block of the diary entry form that holds the optional fields (painted on, date, palette, notes).
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get diaryMoreDetails;

  /// No description provided for @diaryPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get diaryPhotosTitle;

  /// No description provided for @diaryPhotosHelp.
  ///
  /// In en, this message translates to:
  /// **'Up to {count} photos. They stay on this phone.'**
  String diaryPhotosHelp(int count);

  /// No description provided for @diaryPhotoRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get diaryPhotoRemove;

  /// No description provided for @diaryPhotoSemantic.
  ///
  /// In en, this message translates to:
  /// **'Photo {number} of {total}'**
  String diaryPhotoSemantic(int number, int total);

  /// No description provided for @diarySave.
  ///
  /// In en, this message translates to:
  /// **'Save entry'**
  String get diarySave;

  /// No description provided for @diaryDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get diaryDelete;

  /// No description provided for @diaryDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get diaryDeleteTitle;

  /// No description provided for @diaryDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The entry and its photos are removed from this phone. This cannot be undone.'**
  String get diaryDeleteBody;

  /// No description provided for @diaryDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get diaryDeleteConfirm;

  /// No description provided for @diaryAddedNotice.
  ///
  /// In en, this message translates to:
  /// **'Added to the diary'**
  String get diaryAddedNotice;

  /// No description provided for @diaryStatsArtworks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 artwork} other{{count} artworks}}'**
  String diaryStatsArtworks(int count);

  /// No description provided for @diaryStatsFinished.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 finished} other{{count} finished}}'**
  String diaryStatsFinished(int count);

  /// No description provided for @diaryStatsInProgress.
  ///
  /// In en, this message translates to:
  /// **'{count} in progress'**
  String diaryStatsInProgress(int count);

  /// No description provided for @diaryStatsOpen.
  ///
  /// In en, this message translates to:
  /// **'See the numbers'**
  String get diaryStatsOpen;

  /// No description provided for @diaryStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Diary numbers'**
  String get diaryStatsTitle;

  /// No description provided for @diaryStatsStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Finished and in progress'**
  String get diaryStatsStatusTitle;

  /// No description provided for @diaryStatsMonthsTitle.
  ///
  /// In en, this message translates to:
  /// **'Entries per month'**
  String get diaryStatsMonthsTitle;

  /// No description provided for @diaryStatsMonthsLatest.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Showing the latest month.} other{Showing the latest {count} months.}}'**
  String diaryStatsMonthsLatest(int count);

  /// No description provided for @diaryStatsMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Markers you use most'**
  String get diaryStatsMarkersTitle;

  /// No description provided for @diaryStatsMarkersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No entry has markers yet.'**
  String get diaryStatsMarkersEmpty;

  /// No description provided for @diaryStatsEntries.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 entry} other{{count} entries}}'**
  String diaryStatsEntries(int count);

  /// No description provided for @diaryStatsUnusedTitle.
  ///
  /// In en, this message translates to:
  /// **'Markers not used yet'**
  String get diaryStatsUnusedTitle;

  /// No description provided for @diaryStatsUnusedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 marker you own is not in any entry.} other{{count} markers you own are not in any entry.}}'**
  String diaryStatsUnusedCount(int count);

  /// No description provided for @diaryStatsUnusedNone.
  ///
  /// In en, this message translates to:
  /// **'Every marker you own is in an entry.'**
  String get diaryStatsUnusedNone;

  /// No description provided for @diaryStatsUnusedNoCollection.
  ///
  /// In en, this message translates to:
  /// **'Add your markers in My collection to see which ones you have not used.'**
  String get diaryStatsUnusedNoCollection;

  /// No description provided for @diaryStatsUnusedShow.
  ///
  /// In en, this message translates to:
  /// **'Show the list'**
  String get diaryStatsUnusedShow;

  /// No description provided for @diaryStatsUnusedHide.
  ///
  /// In en, this message translates to:
  /// **'Hide the list'**
  String get diaryStatsUnusedHide;

  /// No description provided for @diaryStatsPalettesTitle.
  ///
  /// In en, this message translates to:
  /// **'Palettes you link most'**
  String get diaryStatsPalettesTitle;

  /// No description provided for @diaryStatsPalettesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No entry links a saved palette yet.'**
  String get diaryStatsPalettesEmpty;

  /// No description provided for @diaryShareMore.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  String diaryShareMore(int count);

  /// No description provided for @settingsLicences.
  ///
  /// In en, this message translates to:
  /// **'Open-source licences'**
  String get settingsLicences;

  /// No description provided for @settingsLicencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The licences of the code, the fonts and the packages the app uses'**
  String get settingsLicencesSubtitle;

  /// No description provided for @settingsLicencesLegalese.
  ///
  /// In en, this message translates to:
  /// **'Ink Lab code: MIT licence. Texts, ideas and documentation: CC BY-SA 4.0. Bundled fonts: SIL Open Font Licence 1.1.'**
  String get settingsLicencesLegalese;

  /// No description provided for @settingsSendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get settingsSendFeedback;

  /// No description provided for @settingsSendFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Opens your email app with the app and system version. You decide whether to send it.'**
  String get settingsSendFeedbackSubtitle;

  /// Settings, About: row that opens the app's own store page so the person can leave a rating or review.
  ///
  /// In en, this message translates to:
  /// **'Rate Ink Lab'**
  String get settingsRateApp;

  /// No description provided for @settingsRateAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A review helps others find it'**
  String get settingsRateAppSubtitle;

  /// No description provided for @settingsFeedbackNoMail.
  ///
  /// In en, this message translates to:
  /// **'No email app was found. The address {address} was copied.'**
  String settingsFeedbackNoMail(String address);

  /// No description provided for @settingsErrorLogShare.
  ///
  /// In en, this message translates to:
  /// **'Share error log'**
  String get settingsErrorLogShare;

  /// No description provided for @settingsErrorLogShareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Technical details of the errors the app had, without your diary or your API key. Nothing is sent unless you share it.'**
  String get settingsErrorLogShareSubtitle;

  /// No description provided for @settingsErrorLogClear.
  ///
  /// In en, this message translates to:
  /// **'Clear error log'**
  String get settingsErrorLogClear;

  /// No description provided for @settingsErrorLogCleared.
  ///
  /// In en, this message translates to:
  /// **'The error log was cleared'**
  String get settingsErrorLogCleared;

  /// No description provided for @settingsErrorLogShareFailed.
  ///
  /// In en, this message translates to:
  /// **'The error log could not be shared'**
  String get settingsErrorLogShareFailed;

  /// No description provided for @settingsLastBackup.
  ///
  /// In en, this message translates to:
  /// **'Last backup: {date}'**
  String settingsLastBackup(DateTime date);

  /// No description provided for @settingsNoBackupYet.
  ///
  /// In en, this message translates to:
  /// **'No backup yet'**
  String get settingsNoBackupYet;

  /// No description provided for @settingsBackupReminderNever.
  ///
  /// In en, this message translates to:
  /// **'You have data in the app and no backup yet. Save a backup file to keep it safe if you change or reset your phone.'**
  String get settingsBackupReminderNever;

  /// No description provided for @settingsBackupReminderOld.
  ///
  /// In en, this message translates to:
  /// **'Your last backup is more than a month old. Save a new file to keep your latest work safe.'**
  String get settingsBackupReminderOld;

  /// No description provided for @collectionTouchTwinHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Touch Twin markers you own.'**
  String get collectionTouchTwinHint;

  /// No description provided for @onboardingTouchTwinLine.
  ///
  /// In en, this message translates to:
  /// **'202 colours · Mark the markers you own'**
  String get onboardingTouchTwinLine;

  /// No description provided for @collectionPromarkerHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Promarker markers you own.'**
  String get collectionPromarkerHint;

  /// No description provided for @onboardingPromarkerLine.
  ///
  /// In en, this message translates to:
  /// **'148 colours · Mark the markers you own'**
  String get onboardingPromarkerLine;

  /// No description provided for @collectionPrismacolorHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Prismacolor Premier markers you own.'**
  String get collectionPrismacolorHint;

  /// No description provided for @onboardingPrismacolorLine.
  ///
  /// In en, this message translates to:
  /// **'200 colours · Mark the markers you own'**
  String get onboardingPrismacolorLine;

  /// No description provided for @collectionSpectrumNoirHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Spectrum Noir markers you own.'**
  String get collectionSpectrumNoirHint;

  /// No description provided for @onboardingSpectrumNoirLine.
  ///
  /// In en, this message translates to:
  /// **'216 colours · Mark the markers you own'**
  String get onboardingSpectrumNoirLine;

  /// No description provided for @collectionPromarkerBrushHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Promarker Brush markers you own.'**
  String get collectionPromarkerBrushHint;

  /// No description provided for @onboardingPromarkerBrushLine.
  ///
  /// In en, this message translates to:
  /// **'72 colours · Mark the markers you own'**
  String get onboardingPromarkerBrushLine;

  /// No description provided for @collectionArrtxHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Arrtx markers you own.'**
  String get collectionArrtxHint;

  /// No description provided for @onboardingArrtxLine.
  ///
  /// In en, this message translates to:
  /// **'328 colours · Mark the markers you own'**
  String get onboardingArrtxLine;

  /// No description provided for @collectionKurecolorHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the ZIG Kurecolor markers you own.'**
  String get collectionKurecolorHint;

  /// No description provided for @onboardingKurecolorLine.
  ///
  /// In en, this message translates to:
  /// **'136 colours · Mark the markers you own'**
  String get onboardingKurecolorLine;

  /// No description provided for @collectionGraphitHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Graph\'it markers you own.'**
  String get collectionGraphitHint;

  /// No description provided for @onboardingGraphitLine.
  ///
  /// In en, this message translates to:
  /// **'168 colours · Mark the markers you own'**
  String get onboardingGraphitLine;

  /// No description provided for @collectionMarvyLePlumeHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Marvy Le Plume markers you own.'**
  String get collectionMarvyLePlumeHint;

  /// No description provided for @onboardingMarvyLePlumeLine.
  ///
  /// In en, this message translates to:
  /// **'144 colours · Mark the markers you own'**
  String get onboardingMarvyLePlumeLine;

  /// No description provided for @collectionBlickBrushHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Blick Studio Brush markers you own.'**
  String get collectionBlickBrushHint;

  /// No description provided for @onboardingBlickBrushLine.
  ///
  /// In en, this message translates to:
  /// **'96 colours · Mark the markers you own'**
  String get onboardingBlickBrushLine;

  /// No description provided for @collectionArtistsLoftHint.
  ///
  /// In en, this message translates to:
  /// **'Mark the Artist\'s Loft markers you own.'**
  String get collectionArtistsLoftHint;

  /// No description provided for @onboardingArtistsLoftLine.
  ///
  /// In en, this message translates to:
  /// **'56 colours · Mark the markers you own'**
  String get onboardingArtistsLoftLine;

  /// No description provided for @shortcutMatchLabel.
  ///
  /// In en, this message translates to:
  /// **'Match a colour'**
  String get shortcutMatchLabel;

  /// No description provided for @shortcutNewPaletteLabel.
  ///
  /// In en, this message translates to:
  /// **'New palette'**
  String get shortcutNewPaletteLabel;

  /// No description provided for @shortcutSearchSwatchesLabel.
  ///
  /// In en, this message translates to:
  /// **'Search swatches'**
  String get shortcutSearchSwatchesLabel;

  /// No description provided for @brandSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search brands'**
  String get brandSearchHint;

  /// No description provided for @brandGroupPopular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get brandGroupPopular;

  /// No description provided for @brandGroupMore.
  ///
  /// In en, this message translates to:
  /// **'More brands'**
  String get brandGroupMore;

  /// No description provided for @brandSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No brand matches your search.'**
  String get brandSearchEmpty;

  /// No description provided for @brandGroupOwned.
  ///
  /// In en, this message translates to:
  /// **'Your brands'**
  String get brandGroupOwned;

  /// No description provided for @brandOwnedLine.
  ///
  /// In en, this message translates to:
  /// **'{owned} of {total} owned'**
  String brandOwnedLine(int owned, int total);

  /// No description provided for @navRailExpand.
  ///
  /// In en, this message translates to:
  /// **'Expand menu'**
  String get navRailExpand;

  /// No description provided for @navRailCollapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse menu'**
  String get navRailCollapse;

  /// No description provided for @inkLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Ink level'**
  String get inkLevelTitle;

  /// No description provided for @inkLevelFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get inkLevelFull;

  /// No description provided for @commonRunningOut.
  ///
  /// In en, this message translates to:
  /// **'Running out'**
  String get commonRunningOut;

  /// No description provided for @refillNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Refill note'**
  String get refillNoteTitle;

  /// No description provided for @refillNoteEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a note, like “refilled 3 Nov”'**
  String get refillNoteEmpty;

  /// No description provided for @refillNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Refilled 3 Nov'**
  String get refillNoteHint;

  /// No description provided for @refillNoteSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get refillNoteSave;

  /// No description provided for @refillNoteRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove note'**
  String get refillNoteRemove;

  /// No description provided for @swatchPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Real swatch'**
  String get swatchPhotoTitle;

  /// No description provided for @swatchPhotoEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a photo of your paper swatch'**
  String get swatchPhotoEmpty;

  /// No description provided for @swatchPhotoHas.
  ///
  /// In en, this message translates to:
  /// **'Your paper swatch'**
  String get swatchPhotoHas;

  /// No description provided for @swatchPhotoView.
  ///
  /// In en, this message translates to:
  /// **'View photo'**
  String get swatchPhotoView;

  /// No description provided for @swatchPhotoTake.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get swatchPhotoTake;

  /// No description provided for @swatchPhotoChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get swatchPhotoChoose;

  /// No description provided for @swatchPhotoSaved.
  ///
  /// In en, this message translates to:
  /// **'Photo saved'**
  String get swatchPhotoSaved;

  /// No description provided for @swatchPhotoSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'The photo could not be saved. Try another one.'**
  String get swatchPhotoSaveFailed;

  /// No description provided for @swatchPhotoRemoved.
  ///
  /// In en, this message translates to:
  /// **'Photo removed'**
  String get swatchPhotoRemoved;

  /// No description provided for @swatchShadowLightTitle.
  ///
  /// In en, this message translates to:
  /// **'Shadow and light'**
  String get swatchShadowLightTitle;

  /// No description provided for @swatchShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow'**
  String get swatchShadow;

  /// No description provided for @swatchLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get swatchLight;

  /// No description provided for @swatchShadowLightNone.
  ///
  /// In en, this message translates to:
  /// **'None in your collection'**
  String get swatchShadowLightNone;

  /// No description provided for @swatchBlendWith.
  ///
  /// In en, this message translates to:
  /// **'Blend with…'**
  String get swatchBlendWith;

  /// No description provided for @swatchBlendTitle.
  ///
  /// In en, this message translates to:
  /// **'Blend with'**
  String get swatchBlendTitle;

  /// No description provided for @swatchBlendSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search your markers'**
  String get swatchBlendSearchHint;

  /// No description provided for @swatchBlendNoMarkers.
  ///
  /// In en, this message translates to:
  /// **'You have no other markers to blend with.'**
  String get swatchBlendNoMarkers;

  /// No description provided for @swatchBlendNoResults.
  ///
  /// In en, this message translates to:
  /// **'No marker matches your search.'**
  String get swatchBlendNoResults;

  /// No description provided for @swatchBlendSteps.
  ///
  /// In en, this message translates to:
  /// **'In between, from your collection'**
  String get swatchBlendSteps;

  /// No description provided for @swatchBlendNothingBetween.
  ///
  /// In en, this message translates to:
  /// **'These two are close enough to blend straight into each other.'**
  String get swatchBlendNothingBetween;

  /// No description provided for @swatchBlendNoneBetween.
  ///
  /// In en, this message translates to:
  /// **'None of your markers sits between them.'**
  String get swatchBlendNoneBetween;

  /// No description provided for @swatchBlendBuy.
  ///
  /// In en, this message translates to:
  /// **'Big jump. To fill the gap, the closest marker you do not own is {code}.'**
  String swatchBlendBuy(String code);

  /// No description provided for @swatchBlendStripSemantics.
  ///
  /// In en, this message translates to:
  /// **'Gradient from {from} to {to}'**
  String swatchBlendStripSemantics(String from, String to);

  /// No description provided for @swatchDuplicatesTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{You already have 1 marker very close to this} other{You already have {count} markers very close to this}}'**
  String swatchDuplicatesTitle(int count);

  /// No description provided for @swatchDuplicatesHint.
  ///
  /// In en, this message translates to:
  /// **'Almost the same colour, so a new one adds little.'**
  String get swatchDuplicatesHint;

  /// No description provided for @swatchDuplicatesMore.
  ///
  /// In en, this message translates to:
  /// **'and {count} more'**
  String swatchDuplicatesMore(int count);

  /// No description provided for @swatchDuplicatesNone.
  ///
  /// In en, this message translates to:
  /// **'Nothing in your collection is very close to this: it would add a new colour.'**
  String get swatchDuplicatesNone;

  /// No description provided for @wishlistDuplicateNote.
  ///
  /// In en, this message translates to:
  /// **'Very close to {codes} in your collection'**
  String wishlistDuplicateNote(String codes);

  /// No description provided for @wishlistRunningOutCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Nothing running out} =1{1 marker running out} other{{count} markers running out}}'**
  String wishlistRunningOutCount(int count);

  /// No description provided for @wishlistRunningOutHint.
  ///
  /// In en, this message translates to:
  /// **'Still in use. Add them to your list when you want to buy or refill them.'**
  String get wishlistRunningOutHint;

  /// No description provided for @swatchesAllBrands.
  ///
  /// In en, this message translates to:
  /// **'All brands ({count})'**
  String swatchesAllBrands(int count);

  /// No description provided for @swatchesOtherBrandsYours.
  ///
  /// In en, this message translates to:
  /// **'Your brands'**
  String get swatchesOtherBrandsYours;

  /// No description provided for @inkLevelFullNote.
  ///
  /// In en, this message translates to:
  /// **'Full: Match, Palette and Ideas can suggest it.'**
  String get inkLevelFullNote;

  /// No description provided for @inkLevelRunningOutNote.
  ///
  /// In en, this message translates to:
  /// **'Running out: still used everywhere. It shows in the Running out group of your wishlist.'**
  String get inkLevelRunningOutNote;

  /// Shown in the detail pane next to the Swatches grid on tablets while no marker is selected.
  ///
  /// In en, this message translates to:
  /// **'Tap a marker to see its details here.'**
  String get swatchesDetailPaneEmpty;

  /// Switch in My collection: Palette, Ideas, the Colour map, the AI and the home widget use the markers of every brand the user owns, not only the active brand. One line.
  ///
  /// In en, this message translates to:
  /// **'Mix my brands'**
  String get collectionMixBrands;

  /// One-line subtitle of the Mix my brands switch when more than two brands are mixed: the first two brand names and how many more.
  ///
  /// In en, this message translates to:
  /// **'{first}, {second} and {count} more'**
  String collectionMoreBrands(String first, String second, int count);

  /// One-line subtitle of the Mix my brands switch when the brand names do not fit on the line: how many brands are mixed (two or more).
  ///
  /// In en, this message translates to:
  /// **'{count} brands'**
  String collectionBrandsCount(int count);

  /// Snack bar shown after an action replaced the palette on screen (Regenerate, Suggest with AI, a variation, another type, scene or size). It has an Undo button.
  ///
  /// In en, this message translates to:
  /// **'Palette changed'**
  String get paletteChanged;

  /// Title of the question asked before replacing a palette the user worked on (loaded or saved and then changed, or with locked colours that would be lost).
  ///
  /// In en, this message translates to:
  /// **'Replace this palette?'**
  String get paletteReplaceTitle;

  /// Body of the question asked before replacing a palette the user worked on.
  ///
  /// In en, this message translates to:
  /// **'The palette on screen will be replaced, with your changes and your locked colours. You can undo it right afterwards.'**
  String get paletteReplaceBody;

  /// Button that confirms replacing the palette on screen.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get paletteReplaceButton;

  /// Error under the base marker field when Mix my brands is on and the typed code exists in two of the brands the user owns.
  ///
  /// In en, this message translates to:
  /// **'More than one of your brands has this code. Choose the brand in the list.'**
  String get paletteAmbiguousBase;

  /// Note over a blending chain built from the whole range when Mix my brands is on: the range is the one of every brand in the mix, so no single brand is named.
  ///
  /// In en, this message translates to:
  /// **'Showing the whole range of your brands, markers you don\'t own included.'**
  String get paletteChainWholeRangeNoteMixed;

  /// Error under the base marker field when the base is a marker of a brand that is not the one in use (the palette on screen was kept after the brand changed, or was loaded from another brand). It replaces 'not in your collection', which would be false.
  ///
  /// In en, this message translates to:
  /// **'{code} is from {brand}, and {brand} is not in use right now. Try {example}, or change the brand in My collection.'**
  String paletteBaseOtherBrand(String code, String brand, String example);

  /// Import error when fewer than two different known markers were found; the current palette is kept.
  ///
  /// In en, this message translates to:
  /// **'Add at least two different recognised marker codes to import a palette.'**
  String get paletteImportTooFew;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
