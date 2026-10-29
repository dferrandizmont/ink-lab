import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
    Locale('en'),
    Locale('es'),
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

  /// No description provided for @settingsPalettesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No palette has been saved yet.'**
  String get settingsPalettesEmpty;

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

  /// No description provided for @settingsDeletePalette.
  ///
  /// In en, this message translates to:
  /// **'Delete the palette'**
  String get settingsDeletePalette;

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

  /// No description provided for @settingsBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get settingsBackupTitle;

  /// No description provided for @settingsBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your settings, palettes, history and AI settings can be exported as a JSON file and imported back.'**
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
  /// **'Backup copied to the clipboard'**
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
  /// **'The backup replaces your settings, your saved palettes, your colour match history and your AI settings.'**
  String get settingsImportConfirmBody;

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
  /// **'Ink Lab is an independent community project: it is not affiliated with, endorsed by or sponsored by Ohuhu or DecoTime, and it uses their marker codes, names and colour values only as factual reference data.'**
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

  /// No description provided for @paletteBaseCodeHint.
  ///
  /// In en, this message translates to:
  /// **'E08 or B271'**
  String get paletteBaseCodeHint;

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

  /// No description provided for @paletteAiOptionalNote.
  ///
  /// In en, this message translates to:
  /// **'AI is optional and off by default.'**
  String get paletteAiOptionalNote;

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

  /// No description provided for @swatchesClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear the search'**
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

  /// No description provided for @swatchesDeltaEUnit.
  ///
  /// In en, this message translates to:
  /// **'ΔE 76'**
  String get swatchesDeltaEUnit;

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
  /// **'Exercises for your markers, with a palette from your collection'**
  String get ideasHeaderSubtitle;

  /// No description provided for @ideasHeaderSubtitleWholeRange.
  ///
  /// In en, this message translates to:
  /// **'Exercises with a palette from the whole range'**
  String get ideasHeaderSubtitleWholeRange;

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

  /// No description provided for @ideasGuideOnlyNote.
  ///
  /// In en, this message translates to:
  /// **'This exercise uses your whole collection, so it has no fixed palette.'**
  String get ideasGuideOnlyNote;

  /// No description provided for @ideasNoMarkersDecoTime.
  ///
  /// In en, this message translates to:
  /// **'Add the DecoTime markers you own in My collection to get a palette for this idea.'**
  String get ideasNoMarkersDecoTime;

  /// No description provided for @ideasNoMarkersOther.
  ///
  /// In en, this message translates to:
  /// **'Add the markers you own in My collection to get a palette for this idea.'**
  String get ideasNoMarkersOther;

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

  /// No description provided for @ideasFeaturedLabel.
  ///
  /// In en, this message translates to:
  /// **'Idea of the day'**
  String get ideasFeaturedLabel;

  /// No description provided for @ideasOpenButton.
  ///
  /// In en, this message translates to:
  /// **'See steps'**
  String get ideasOpenButton;

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
  /// **'No photo yet'**
  String get matchEmptyPhotoTitle;

  /// No description provided for @matchEmptyPhotoMessage.
  ///
  /// In en, this message translates to:
  /// **'Take a photo or pick one from the gallery to find the closest marker.'**
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

  /// No description provided for @matchDeltaMethod.
  ///
  /// In en, this message translates to:
  /// **'ΔE 76'**
  String get matchDeltaMethod;

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

  /// No description provided for @settingsPaletteDescription.
  ///
  /// In en, this message translates to:
  /// **'{mode} · {colors}'**
  String settingsPaletteDescription(String mode, String colors);

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
  /// **'{brand, select, decoTime{{input} is not a DecoTime marker code. Try {example}.} other{{input} is not an Ink Lab marker code. Try {example}.}}'**
  String paletteUnknownCode(String brand, String input, String example);

  /// No description provided for @paletteNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{{input} is not in your collection. Try {example} or add it in My collection.} other{{input} is not in your collection. Try {example} or add it in My collection.}}'**
  String paletteNotAvailable(String brand, String input, String example);

  /// No description provided for @paletteNoAvailableColors.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{There are no DecoTime markers in your collection yet. Add them in My collection.} other{There are no markers in your collection yet. Add them in My collection.}}'**
  String paletteNoAvailableColors(String brand);

  /// No description provided for @paletteMissingBase.
  ///
  /// In en, this message translates to:
  /// **'Pick a base marker, such as {example}, or choose a scene with the Scenes chip.'**
  String paletteMissingBase(String example);

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
  /// **'Lines you own'**
  String get settingsLinesTitle;

  /// No description provided for @settingsLinesHint.
  ///
  /// In en, this message translates to:
  /// **'Pick every Ohuhu line you own. Turning a line off removes its packs from your selection.'**
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
  /// **'Lines'**
  String get swatchesLines;

  /// No description provided for @swatchesLabelLine.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get swatchesLabelLine;

  /// No description provided for @swatchesAllLines.
  ///
  /// In en, this message translates to:
  /// **'All lines'**
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

  /// No description provided for @collectionUntickVisible.
  ///
  /// In en, this message translates to:
  /// **'Untick all'**
  String get collectionUntickVisible;

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

  /// No description provided for @onboardingDecoTitle.
  ///
  /// In en, this message translates to:
  /// **'Your DecoTime markers'**
  String get onboardingDecoTitle;

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
  /// **'You have not picked any sets yet: the whole range is used'**
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

  /// No description provided for @onboardingDoneWholeRange.
  ///
  /// In en, this message translates to:
  /// **'Until you pick sets, the app shows the whole {brand} range.'**
  String onboardingDoneWholeRange(String brand);

  /// No description provided for @onboardingDoneNoMarkers.
  ///
  /// In en, this message translates to:
  /// **'You have not ticked any DecoTime markers yet: tick them in My collection.'**
  String get onboardingDoneNoMarkers;

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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
