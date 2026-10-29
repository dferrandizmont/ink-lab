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
  /// **'Collection'**
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

  /// No description provided for @settingsBrandDecoTimeHint.
  ///
  /// In en, this message translates to:
  /// **'DecoTime shows only the markers you mark as owned.'**
  String get settingsBrandDecoTimeHint;

  /// No description provided for @settingsBrandSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The brand selects the catalogue of markers the app works with.'**
  String get settingsBrandSubtitle;

  /// No description provided for @settingsPacksTitle.
  ///
  /// In en, this message translates to:
  /// **'Ohuhu packs'**
  String get settingsPacksTitle;

  /// No description provided for @settingsPacksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The packs that make up your Ohuhu collection.'**
  String get settingsPacksSubtitle;

  /// No description provided for @settingsPackMode.
  ///
  /// In en, this message translates to:
  /// **'Pack selection'**
  String get settingsPackMode;

  /// No description provided for @settingsSinglePackHint.
  ///
  /// In en, this message translates to:
  /// **'With a single pack only the first selected pack is used.'**
  String get settingsSinglePackHint;

  /// No description provided for @settingsCorePacks.
  ///
  /// In en, this message translates to:
  /// **'Core packs'**
  String get settingsCorePacks;

  /// No description provided for @settingsAddonPacks.
  ///
  /// In en, this message translates to:
  /// **'Add-on packs'**
  String get settingsAddonPacks;

  /// No description provided for @settingsOwnedTitle.
  ///
  /// In en, this message translates to:
  /// **'Owned markers'**
  String get settingsOwnedTitle;

  /// No description provided for @settingsOwnedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tick the markers you own. DecoTime only shows the colors of the markers you own.'**
  String get settingsOwnedSubtitle;

  /// No description provided for @settingsOwnedSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search markers'**
  String get settingsOwnedSearchHint;

  /// No description provided for @settingsSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get settingsSelectAll;

  /// No description provided for @settingsSelectNone.
  ///
  /// In en, this message translates to:
  /// **'Select none'**
  String get settingsSelectNone;

  /// No description provided for @settingsClearOwned.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get settingsClearOwned;

  /// No description provided for @settingsClearOwnedTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove every owned marker?'**
  String get settingsClearOwnedTitle;

  /// No description provided for @settingsClearOwnedBody.
  ///
  /// In en, this message translates to:
  /// **'The markers you own will be forgotten. You can tick them again afterwards.'**
  String get settingsClearOwnedBody;

  /// No description provided for @settingsOwnedEmpty.
  ///
  /// In en, this message translates to:
  /// **'No marker is owned yet. Tick the ones you have.'**
  String get settingsOwnedEmpty;

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
  /// **'Favorites'**
  String get settingsFavoritesTitle;

  /// No description provided for @settingsFavoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No color is a favorite yet.'**
  String get settingsFavoritesEmpty;

  /// No description provided for @settingsClearFavorites.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get settingsClearFavorites;

  /// No description provided for @settingsClearFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove every favorite?'**
  String get settingsClearFavoritesTitle;

  /// No description provided for @settingsClearFavoritesBody.
  ///
  /// In en, this message translates to:
  /// **'The favorite colors of this brand will be removed. This cannot be undone.'**
  String get settingsClearFavoritesBody;

  /// No description provided for @settingsDeleteFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove the favorite'**
  String get settingsDeleteFavorite;

  /// No description provided for @settingsLabelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Name display'**
  String get settingsLabelsTitle;

  /// No description provided for @settingsLabelsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How the marker codes and names are shown in the app.'**
  String get settingsLabelsSubtitle;

  /// No description provided for @settingsNewLabels.
  ///
  /// In en, this message translates to:
  /// **'New'**
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
  /// **'The backup replaces your settings, your saved palettes, your color match history and your AI settings.'**
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
  /// **'Gemini Nano runs on this phone. Nothing leaves your phone.'**
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
  /// **'Fall back to colour theory'**
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
  /// **'When this is on and you use a suggestion with OpenRouter, the app sends your scenario, the base colour code, name and hex value, and the list of candidate colours to openrouter.ai and to the model provider, using your own API key. Photos are never sent: this feature has no image upload. Nothing at all is sent while this switch is off.'**
  String get settingsAiDisclosure;

  /// No description provided for @settingsAiDisclosureColourTheory.
  ///
  /// In en, this message translates to:
  /// **'With Colour theory selected, palettes come from the built-in engine: no AI is used and nothing leaves your phone. Choose On-device or OpenRouter to use an AI.'**
  String get settingsAiDisclosureColourTheory;

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
  /// **'On-device (Gemini Nano) requests are answered by the model on this phone. Your scenario and colour codes never leave it, and no key is needed.'**
  String get settingsAiDisclosureOnDevice;

  /// No description provided for @settingsAiOnDeviceName.
  ///
  /// In en, this message translates to:
  /// **'On-device (Gemini Nano)'**
  String get settingsAiOnDeviceName;

  /// No description provided for @settingsAiOnDevicePrivacy.
  ///
  /// In en, this message translates to:
  /// **'On-device requests never leave your phone.'**
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
  /// **'Ink Lab is an independent community project: it is not affiliated with, endorsed by or sponsored by Ohuhu or DecoTime, and it uses their marker codes, names and color values only as factual reference data.'**
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

  /// No description provided for @paletteHarmonyLabel.
  ///
  /// In en, this message translates to:
  /// **'Harmony'**
  String get paletteHarmonyLabel;

  /// No description provided for @paletteScenarioToggle.
  ///
  /// In en, this message translates to:
  /// **'Scenes'**
  String get paletteScenarioToggle;

  /// No description provided for @paletteScenarioTitle.
  ///
  /// In en, this message translates to:
  /// **'Scenarios'**
  String get paletteScenarioTitle;

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
  /// **'Block the overall shape with the base color first.'**
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
  /// **'Enter a base marker code to build a palette, or turn on Scenario mode.'**
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

  /// No description provided for @swatchesTitle.
  ///
  /// In en, this message translates to:
  /// **'Swatches'**
  String get swatchesTitle;

  /// No description provided for @swatchesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Code, name, hex or old code'**
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
  /// **'Owned'**
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
  /// **'Pack'**
  String get swatchesLabelPack;

  /// No description provided for @swatchesLabelLayout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get swatchesLabelLayout;

  /// No description provided for @swatchesAllPacks.
  ///
  /// In en, this message translates to:
  /// **'All packs'**
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
  /// **'In packs'**
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
  /// **'Add to favorites'**
  String get swatchesAddFavorite;

  /// No description provided for @swatchesRemoveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get swatchesRemoveFavorite;

  /// No description provided for @swatchesEmptyNoOwnedTitle.
  ///
  /// In en, this message translates to:
  /// **'No markers added yet'**
  String get swatchesEmptyNoOwnedTitle;

  /// No description provided for @swatchesEmptyNoOwnedBody.
  ///
  /// In en, this message translates to:
  /// **'DecoTime swatches only show the markers you own. Add the markers you have in Settings, in the owned markers manager, and their colours will show up here.'**
  String get swatchesEmptyNoOwnedBody;

  /// No description provided for @swatchesEmptyNoOwnedAction.
  ///
  /// In en, this message translates to:
  /// **'Add my markers'**
  String get swatchesEmptyNoOwnedAction;

  /// No description provided for @swatchesEmptyNoOwnedHint.
  ///
  /// In en, this message translates to:
  /// **'Open the Settings tab and use the owned markers manager.'**
  String get swatchesEmptyNoOwnedHint;

  /// No description provided for @swatchesEmptySearchTitle.
  ///
  /// In en, this message translates to:
  /// **'No colors found'**
  String get swatchesEmptySearchTitle;

  /// No description provided for @swatchesEmptySearchBody.
  ///
  /// In en, this message translates to:
  /// **'No color of this collection matches your search.'**
  String get swatchesEmptySearchBody;

  /// No description provided for @swatchesEmptyFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show'**
  String get swatchesEmptyFiltersTitle;

  /// No description provided for @swatchesEmptyFiltersBody.
  ///
  /// In en, this message translates to:
  /// **'This brand has no colors for the selected packs and filters.'**
  String get swatchesEmptyFiltersBody;

  /// No description provided for @swatchesLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading colors…'**
  String get swatchesLoading;

  /// No description provided for @swatchesLoadFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Colors unavailable'**
  String get swatchesLoadFailedTitle;

  /// No description provided for @swatchesLoadFailedBody.
  ///
  /// In en, this message translates to:
  /// **'The marker catalogue could not be read, so no colors can be shown.'**
  String get swatchesLoadFailedBody;

  /// No description provided for @swatchesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The app services are not available, so the swatches cannot be shown.'**
  String get swatchesUnavailable;

  /// No description provided for @swatchesVisibleCount.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
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
  /// **'Guides and challenges for your markers'**
  String get ideasHeaderSubtitle;

  /// No description provided for @ideasSelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get ideasSelectedLabel;

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

  /// No description provided for @ideasBadgeGuideOnly.
  ///
  /// In en, this message translates to:
  /// **'Guide only'**
  String get ideasBadgeGuideOnly;

  /// No description provided for @ideasBadgeGuideAndPalette.
  ///
  /// In en, this message translates to:
  /// **'Guide + palette'**
  String get ideasBadgeGuideAndPalette;

  /// No description provided for @ideasShowTechnique.
  ///
  /// In en, this message translates to:
  /// **'Show technique'**
  String get ideasShowTechnique;

  /// No description provided for @ideasGenerateIdea.
  ///
  /// In en, this message translates to:
  /// **'Generate idea'**
  String get ideasGenerateIdea;

  /// No description provided for @ideasApplyButton.
  ///
  /// In en, this message translates to:
  /// **'Apply to Palette'**
  String get ideasApplyButton;

  /// No description provided for @ideasHowToTitle.
  ///
  /// In en, this message translates to:
  /// **'How to execute'**
  String get ideasHowToTitle;

  /// No description provided for @ideasExtraTouchesTitle.
  ///
  /// In en, this message translates to:
  /// **'Extra touches'**
  String get ideasExtraTouchesTitle;

  /// No description provided for @ideasSuggestedColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggested colors'**
  String get ideasSuggestedColorsTitle;

  /// No description provided for @ideasGuideOnlyNote.
  ///
  /// In en, this message translates to:
  /// **'This idea is intentionally technique-first. It does not enforce a fixed palette, so you can choose colors freely.'**
  String get ideasGuideOnlyNote;

  /// No description provided for @ideasNoMarkersDecoTime.
  ///
  /// In en, this message translates to:
  /// **'Select your owned DecoTime markers in Settings to generate color suggestions for this idea.'**
  String get ideasNoMarkersDecoTime;

  /// No description provided for @ideasNoMarkersOther.
  ///
  /// In en, this message translates to:
  /// **'No markers available for the current collection filters.'**
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

  /// No description provided for @ideasSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Pick an idea to see how to execute it.'**
  String get ideasSelectHint;

  /// No description provided for @ideasNoMarkers.
  ///
  /// In en, this message translates to:
  /// **'No markers currently available'**
  String get ideasNoMarkers;

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

  /// No description provided for @matchNoMarkers.
  ///
  /// In en, this message translates to:
  /// **'No markers are available for the current collection. Check the active brand and sets in Settings.'**
  String get matchNoMarkers;

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
  /// **'{count, plural, =1{1 color} other{{count} colors}}'**
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
  /// **'{size} colors'**
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
  /// **'{mode} · {size} colors'**
  String paletteSavedSubtitle(String mode, int size);

  /// No description provided for @paletteSubtitleFrom.
  ///
  /// In en, this message translates to:
  /// **'{mode} from {base} · {available}'**
  String paletteSubtitleFrom(String mode, String base, String available);

  /// No description provided for @paletteSubtitleScenario.
  ///
  /// In en, this message translates to:
  /// **'{scenario} · {available}'**
  String paletteSubtitleScenario(String scenario, String available);

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
  /// **'Ideas palette applied ({count} colors).'**
  String paletteDraftApplied(int count);

  /// No description provided for @paletteUsingDefaultBase.
  ///
  /// In en, this message translates to:
  /// **'Using {code} as the default base for {scenario}. Enter a code to override it.'**
  String paletteUsingDefaultBase(String code, String scenario);

  /// No description provided for @paletteUnknownCode.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{{input} is not a DecoTime marker code. Try {example} or check your owned markers in Settings.} other{{input} is not an Ink Lab marker code. Try {example}.}}'**
  String paletteUnknownCode(String brand, String input, String example);

  /// No description provided for @paletteNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{{input} is not in your owned DecoTime markers. Try {example} or update Owned markers in Settings.} other{{input} is not in your active collection. Try {example} or switch sets in Settings.}}'**
  String paletteNotAvailable(String brand, String input, String example);

  /// No description provided for @paletteNoAvailableColors.
  ///
  /// In en, this message translates to:
  /// **'{brand, select, decoTime{No DecoTime markers are selected. Go to Settings > Collection > Owned markers and select the markers you own.} other{No markers are available for the current collection filters.}}'**
  String paletteNoAvailableColors(String brand);

  /// No description provided for @paletteMissingBase.
  ///
  /// In en, this message translates to:
  /// **'Enter a base marker code, like {example}, or turn on Scenario mode.'**
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
  /// **'{visible} of {total} colors'**
  String swatchesFilteredColorCount(int visible, int total);

  /// No description provided for @swatchesSwatchSemantics.
  ///
  /// In en, this message translates to:
  /// **'{favorite, select, true{{code}, {name}, favorite} other{{code}, {name}}}'**
  String swatchesSwatchSemantics(String code, String name, String favorite);

  /// No description provided for @swatchesClassicPack.
  ///
  /// In en, this message translates to:
  /// **'Classic {label}'**
  String swatchesClassicPack(String label);

  /// No description provided for @ideasPaletteSent.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" palette sent to the Palette tab.'**
  String ideasPaletteSent(String title);

  /// No description provided for @matchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Matching against your {count, plural, =1{1 marker} other{{count} markers}}'**
  String matchSubtitle(int count);

  /// No description provided for @matchQualityExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
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
  /// **'Fair'**
  String get matchQualityFair;

  /// No description provided for @matchQualityApproximate.
  ///
  /// In en, this message translates to:
  /// **'Approximate'**
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
  /// **'Contrast color'**
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

  /// No description provided for @scenarioGhostCharacter.
  ///
  /// In en, this message translates to:
  /// **'Ghost Character'**
  String get scenarioGhostCharacter;

  /// No description provided for @scenarioCuteCharacter.
  ///
  /// In en, this message translates to:
  /// **'Cute Character'**
  String get scenarioCuteCharacter;

  /// No description provided for @scenarioFantasyCreature.
  ///
  /// In en, this message translates to:
  /// **'Fantasy Creature'**
  String get scenarioFantasyCreature;

  /// No description provided for @scenarioWarmPortrait.
  ///
  /// In en, this message translates to:
  /// **'Warm Portrait'**
  String get scenarioWarmPortrait;

  /// No description provided for @scenarioCoolPortrait.
  ///
  /// In en, this message translates to:
  /// **'Cool Portrait'**
  String get scenarioCoolPortrait;

  /// No description provided for @scenarioSunsetLandscape.
  ///
  /// In en, this message translates to:
  /// **'Sunset Landscape'**
  String get scenarioSunsetLandscape;

  /// No description provided for @scenarioForestScene.
  ///
  /// In en, this message translates to:
  /// **'Forest Scene'**
  String get scenarioForestScene;

  /// No description provided for @scenarioOceanScene.
  ///
  /// In en, this message translates to:
  /// **'Ocean Scene'**
  String get scenarioOceanScene;

  /// No description provided for @scenarioAutumnScene.
  ///
  /// In en, this message translates to:
  /// **'Autumn Scene'**
  String get scenarioAutumnScene;

  /// No description provided for @scenarioSpringGarden.
  ///
  /// In en, this message translates to:
  /// **'Spring Garden'**
  String get scenarioSpringGarden;

  /// No description provided for @scenarioCozyInterior.
  ///
  /// In en, this message translates to:
  /// **'Cozy Interior'**
  String get scenarioCozyInterior;

  /// No description provided for @scenarioVintageRoom.
  ///
  /// In en, this message translates to:
  /// **'Vintage Room'**
  String get scenarioVintageRoom;

  /// No description provided for @scenarioPastelDream.
  ///
  /// In en, this message translates to:
  /// **'Pastel Dream'**
  String get scenarioPastelDream;

  /// No description provided for @scenarioNeonNight.
  ///
  /// In en, this message translates to:
  /// **'Neon Night'**
  String get scenarioNeonNight;

  /// No description provided for @scenarioMoodyNight.
  ///
  /// In en, this message translates to:
  /// **'Moody Night'**
  String get scenarioMoodyNight;

  /// No description provided for @scenarioFloralPattern.
  ///
  /// In en, this message translates to:
  /// **'Floral Pattern'**
  String get scenarioFloralPattern;

  /// No description provided for @scenarioGeometricPattern.
  ///
  /// In en, this message translates to:
  /// **'Geometric Pattern'**
  String get scenarioGeometricPattern;

  /// No description provided for @scenarioPlaidPattern.
  ///
  /// In en, this message translates to:
  /// **'Plaid Pattern'**
  String get scenarioPlaidPattern;

  /// No description provided for @scenarioPolkaDotPattern.
  ///
  /// In en, this message translates to:
  /// **'Polka Dot Pattern'**
  String get scenarioPolkaDotPattern;

  /// No description provided for @scenarioCandyStripes.
  ///
  /// In en, this message translates to:
  /// **'Candy Stripes'**
  String get scenarioCandyStripes;

  /// No description provided for @scenarioHalloweenMood.
  ///
  /// In en, this message translates to:
  /// **'Halloween Mood'**
  String get scenarioHalloweenMood;

  /// No description provided for @scenarioChristmasMood.
  ///
  /// In en, this message translates to:
  /// **'Christmas Mood'**
  String get scenarioChristmasMood;

  /// No description provided for @scenarioSpringMood.
  ///
  /// In en, this message translates to:
  /// **'Spring Mood'**
  String get scenarioSpringMood;

  /// No description provided for @scenarioSummerMood.
  ///
  /// In en, this message translates to:
  /// **'Summer Mood'**
  String get scenarioSummerMood;

  /// No description provided for @scenarioAutumnMood.
  ///
  /// In en, this message translates to:
  /// **'Autumn Mood'**
  String get scenarioAutumnMood;

  /// No description provided for @scenarioWinterMood.
  ///
  /// In en, this message translates to:
  /// **'Winter Mood'**
  String get scenarioWinterMood;

  /// No description provided for @scenarioWinterSnow.
  ///
  /// In en, this message translates to:
  /// **'Winter Snow'**
  String get scenarioWinterSnow;

  /// No description provided for @packModeSinglePack.
  ///
  /// In en, this message translates to:
  /// **'Single pack'**
  String get packModeSinglePack;

  /// No description provided for @packModeComparePacks.
  ///
  /// In en, this message translates to:
  /// **'Compare packs'**
  String get packModeComparePacks;

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

  /// No description provided for @ideaStickerEffectTitle.
  ///
  /// In en, this message translates to:
  /// **'Sticker Effect'**
  String get ideaStickerEffectTitle;

  /// No description provided for @ideaStickerEffectSummary.
  ///
  /// In en, this message translates to:
  /// **'Make subjects look like cut-out stickers using a white halo and black outer outline.'**
  String get ideaStickerEffectSummary;

  /// No description provided for @ideaStickerEffectOverview.
  ///
  /// In en, this message translates to:
  /// **'Technique-first challenge. The illusion comes from edge treatment, not from a specific palette.'**
  String get ideaStickerEffectOverview;

  /// No description provided for @ideaStickerEffectStep1.
  ///
  /// In en, this message translates to:
  /// **'Color the main subject normally first.'**
  String get ideaStickerEffectStep1;

  /// No description provided for @ideaStickerEffectStep2.
  ///
  /// In en, this message translates to:
  /// **'Add a clean white halo around the full silhouette.'**
  String get ideaStickerEffectStep2;

  /// No description provided for @ideaStickerEffectStep3.
  ///
  /// In en, this message translates to:
  /// **'Trace the outside edge of that white halo with a black line.'**
  String get ideaStickerEffectStep3;

  /// No description provided for @ideaStickerEffectStep4.
  ///
  /// In en, this message translates to:
  /// **'Optional: add a tiny drop shadow under one side to make it pop.'**
  String get ideaStickerEffectStep4;

  /// No description provided for @ideaStickerEffectEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Keep halo width consistent for a cleaner cut-out look.'**
  String get ideaStickerEffectEmbellishment1;

  /// No description provided for @ideaStickerEffectEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'If edges feel noisy, smooth with white pen before black contour.'**
  String get ideaStickerEffectEmbellishment2;

  /// No description provided for @ideaPolaroidFrameTitle.
  ///
  /// In en, this message translates to:
  /// **'Polaroid Frame'**
  String get ideaPolaroidFrameTitle;

  /// No description provided for @ideaPolaroidFrameSummary.
  ///
  /// In en, this message translates to:
  /// **'Draw a Polaroid frame, color only inside it, and keep everything outside in grayscale.'**
  String get ideaPolaroidFrameSummary;

  /// No description provided for @ideaPolaroidFrameOverview.
  ///
  /// In en, this message translates to:
  /// **'Build a fake instant-photo composition. The interior gets full color while the rest stays in controlled grayscale.'**
  String get ideaPolaroidFrameOverview;

  /// No description provided for @ideaPolaroidFrameStep1.
  ///
  /// In en, this message translates to:
  /// **'Sketch a Polaroid frame with a wider bottom border.'**
  String get ideaPolaroidFrameStep1;

  /// No description provided for @ideaPolaroidFrameStep2.
  ///
  /// In en, this message translates to:
  /// **'Block everything outside the frame using 2-3 grayscale values.'**
  String get ideaPolaroidFrameStep2;

  /// No description provided for @ideaPolaroidFrameStep3.
  ///
  /// In en, this message translates to:
  /// **'Color only the interior photo window with your subject colors.'**
  String get ideaPolaroidFrameStep3;

  /// No description provided for @ideaPolaroidFrameStep4.
  ///
  /// In en, this message translates to:
  /// **'Add a subtle frame shadow so the photo appears on top of the page.'**
  String get ideaPolaroidFrameStep4;

  /// No description provided for @ideaPolaroidFrameEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Write a tiny date caption on the bottom frame for realism.'**
  String get ideaPolaroidFrameEmbellishment1;

  /// No description provided for @ideaPolaroidFrameEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Make outside grayscale slightly cooler to boost interior warmth.'**
  String get ideaPolaroidFrameEmbellishment2;

  /// No description provided for @ideaSpotlightTitle.
  ///
  /// In en, this message translates to:
  /// **'Spotlight'**
  String get ideaSpotlightTitle;

  /// No description provided for @ideaSpotlightSummary.
  ///
  /// In en, this message translates to:
  /// **'Create a strong focal light with dark edges and smooth value falloff.'**
  String get ideaSpotlightSummary;

  /// No description provided for @ideaSpotlightOverview.
  ///
  /// In en, this message translates to:
  /// **'Direct attention with value contrast: bright center, dark perimeter, and clear light falloff.'**
  String get ideaSpotlightOverview;

  /// No description provided for @ideaSpotlightStep1.
  ///
  /// In en, this message translates to:
  /// **'Mark the spotlight center before laying color.'**
  String get ideaSpotlightStep1;

  /// No description provided for @ideaSpotlightStep2.
  ///
  /// In en, this message translates to:
  /// **'Keep the focal zone bright and high-contrast.'**
  String get ideaSpotlightStep2;

  /// No description provided for @ideaSpotlightStep3.
  ///
  /// In en, this message translates to:
  /// **'Darken values gradually as you move away from the center.'**
  String get ideaSpotlightStep3;

  /// No description provided for @ideaSpotlightStep4.
  ///
  /// In en, this message translates to:
  /// **'Finish with a soft vignette around page edges.'**
  String get ideaSpotlightStep4;

  /// No description provided for @ideaSpotlightEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Use harder edges near the focal point, softer edges far away.'**
  String get ideaSpotlightEmbellishment1;

  /// No description provided for @ideaSpotlightEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Avoid bright accents in corners so focus stays centered.'**
  String get ideaSpotlightEmbellishment2;

  /// No description provided for @ideaOneColorTitle.
  ///
  /// In en, this message translates to:
  /// **'One Color'**
  String get ideaOneColorTitle;

  /// No description provided for @ideaOneColorSummary.
  ///
  /// In en, this message translates to:
  /// **'Use a single hue family and control contrast only through value and saturation.'**
  String get ideaOneColorSummary;

  /// No description provided for @ideaOneColorOverview.
  ///
  /// In en, this message translates to:
  /// **'One hue, many values. Depth comes from shifts in lightness and saturation, not hue variety.'**
  String get ideaOneColorOverview;

  /// No description provided for @ideaOneColorStep1.
  ///
  /// In en, this message translates to:
  /// **'Choose one dominant hue family for the full piece.'**
  String get ideaOneColorStep1;

  /// No description provided for @ideaOneColorStep2.
  ///
  /// In en, this message translates to:
  /// **'Separate planes with value shifts, not hue shifts.'**
  String get ideaOneColorStep2;

  /// No description provided for @ideaOneColorStep3.
  ///
  /// In en, this message translates to:
  /// **'Reserve highest contrast for your focal element.'**
  String get ideaOneColorStep3;

  /// No description provided for @ideaOneColorStep4.
  ///
  /// In en, this message translates to:
  /// **'Use saturation variation to avoid flat areas.'**
  String get ideaOneColorStep4;

  /// No description provided for @ideaOneColorEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Use texture shifts to separate materials when hue variety is limited.'**
  String get ideaOneColorEmbellishment1;

  /// No description provided for @ideaOneColorEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Keep one micro-accent at the brightest value for focal clarity.'**
  String get ideaOneColorEmbellishment2;

  /// No description provided for @ideaTwoColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Two Colors'**
  String get ideaTwoColorsTitle;

  /// No description provided for @ideaTwoColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Build the scene using only two dominant hue families plus subtle support tones.'**
  String get ideaTwoColorsSummary;

  /// No description provided for @ideaTwoColorsOverview.
  ///
  /// In en, this message translates to:
  /// **'Restrict the scene to two hue families and let contrast come from value, not palette breadth.'**
  String get ideaTwoColorsOverview;

  /// No description provided for @ideaTwoColorsStep1.
  ///
  /// In en, this message translates to:
  /// **'Assign each major area to one of the two hue families.'**
  String get ideaTwoColorsStep1;

  /// No description provided for @ideaTwoColorsStep2.
  ///
  /// In en, this message translates to:
  /// **'Keep transitions clean to preserve the two-tone concept.'**
  String get ideaTwoColorsStep2;

  /// No description provided for @ideaTwoColorsStep3.
  ///
  /// In en, this message translates to:
  /// **'Use one neutral bridge only where needed.'**
  String get ideaTwoColorsStep3;

  /// No description provided for @ideaTwoColorsStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep one hue dominant and one supporting.'**
  String get ideaTwoColorsStep4;

  /// No description provided for @ideaTwoColorsEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Let one hue occupy larger shapes and the second hue act as accent.'**
  String get ideaTwoColorsEmbellishment1;

  /// No description provided for @ideaTwoColorsEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'If harmony breaks, add a low-saturation bridge tone in transitions.'**
  String get ideaTwoColorsEmbellishment2;

  /// No description provided for @ideaFiftyFiftyTitle.
  ///
  /// In en, this message translates to:
  /// **'50/50 Split'**
  String get ideaFiftyFiftyTitle;

  /// No description provided for @ideaFiftyFiftySummary.
  ///
  /// In en, this message translates to:
  /// **'Split the composition in two moods. One side warm, the other cool, with a bridge color.'**
  String get ideaFiftyFiftySummary;

  /// No description provided for @ideaFiftyFiftyOverview.
  ///
  /// In en, this message translates to:
  /// **'Compose two distinct moods in one image. Keep each side coherent and blend with one bridge tone.'**
  String get ideaFiftyFiftyOverview;

  /// No description provided for @ideaFiftyFiftyStep1.
  ///
  /// In en, this message translates to:
  /// **'Split the page vertically or horizontally.'**
  String get ideaFiftyFiftyStep1;

  /// No description provided for @ideaFiftyFiftyStep2.
  ///
  /// In en, this message translates to:
  /// **'Assign warm hues to one side and cool hues to the other.'**
  String get ideaFiftyFiftyStep2;

  /// No description provided for @ideaFiftyFiftyStep3.
  ///
  /// In en, this message translates to:
  /// **'Use one bridge tone at the boundary so the split feels intentional.'**
  String get ideaFiftyFiftyStep3;

  /// No description provided for @ideaFiftyFiftyStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep each half internally consistent in value and saturation.'**
  String get ideaFiftyFiftyStep4;

  /// No description provided for @ideaFiftyFiftyEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Mirror one small motif on both halves to tie the concept together.'**
  String get ideaFiftyFiftyEmbellishment1;

  /// No description provided for @ideaFiftyFiftyEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Keep one side slightly darker to avoid visual symmetry fatigue.'**
  String get ideaFiftyFiftyEmbellishment2;

  /// No description provided for @ideaWarmColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Warm Colors'**
  String get ideaWarmColorsTitle;

  /// No description provided for @ideaWarmColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Use only warm hues for an energetic, cozy, sunlit scene.'**
  String get ideaWarmColorsSummary;

  /// No description provided for @ideaWarmColorsOverview.
  ///
  /// In en, this message translates to:
  /// **'Warm hues carry energy and intimacy. Keep shadows warm instead of neutral gray.'**
  String get ideaWarmColorsOverview;

  /// No description provided for @ideaCoolColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cool Colors'**
  String get ideaCoolColorsTitle;

  /// No description provided for @ideaCoolColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Use cool hues for calm, depth, and atmospheric distance.'**
  String get ideaCoolColorsSummary;

  /// No description provided for @ideaCoolColorsOverview.
  ///
  /// In en, this message translates to:
  /// **'Cool hues create depth and calm. Control value steps to avoid a flat finish.'**
  String get ideaCoolColorsOverview;

  /// No description provided for @ideaPastelTitle.
  ///
  /// In en, this message translates to:
  /// **'Pastel'**
  String get ideaPastelTitle;

  /// No description provided for @ideaPastelSummary.
  ///
  /// In en, this message translates to:
  /// **'Light value and low saturation for a soft, dreamy finish.'**
  String get ideaPastelSummary;

  /// No description provided for @ideaPastelOverview.
  ///
  /// In en, this message translates to:
  /// **'Pastel scenes rely on value control and subtle contrast more than hue intensity.'**
  String get ideaPastelOverview;

  /// No description provided for @ideaNeonTitle.
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get ideaNeonTitle;

  /// No description provided for @ideaNeonSummary.
  ///
  /// In en, this message translates to:
  /// **'High-energy, vivid colors that pop against dark support tones.'**
  String get ideaNeonSummary;

  /// No description provided for @ideaNeonOverview.
  ///
  /// In en, this message translates to:
  /// **'Neon needs contrast. Reserve at least one dark support area so bright accents can glow.'**
  String get ideaNeonOverview;

  /// No description provided for @ideaRainbowTitle.
  ///
  /// In en, this message translates to:
  /// **'Rainbow'**
  String get ideaRainbowTitle;

  /// No description provided for @ideaRainbowSummary.
  ///
  /// In en, this message translates to:
  /// **'Distribute hue families across the artwork while keeping values controlled.'**
  String get ideaRainbowSummary;

  /// No description provided for @ideaRainbowOverview.
  ///
  /// In en, this message translates to:
  /// **'Use broad hue coverage but keep one dominant hue family so the piece still feels unified.'**
  String get ideaRainbowOverview;

  /// No description provided for @ideaUnlikelyColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlikely Colors'**
  String get ideaUnlikelyColorsTitle;

  /// No description provided for @ideaUnlikelyColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Try unexpected color pairings to make ordinary subjects feel stylized.'**
  String get ideaUnlikelyColorsSummary;

  /// No description provided for @ideaUnlikelyColorsOverview.
  ///
  /// In en, this message translates to:
  /// **'Unexpected combinations can feel intentional when value hierarchy stays clear.'**
  String get ideaUnlikelyColorsOverview;

  /// No description provided for @ideaRandomColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Random Colors'**
  String get ideaRandomColorsTitle;

  /// No description provided for @ideaRandomColorsSummary.
  ///
  /// In en, this message translates to:
  /// **'Use a randomized palette and force cohesion through value planning.'**
  String get ideaRandomColorsSummary;

  /// No description provided for @ideaRandomColorsOverview.
  ///
  /// In en, this message translates to:
  /// **'Random palettes look coherent if you keep one focal area and controlled contrast.'**
  String get ideaRandomColorsOverview;

  /// No description provided for @ideaGrayscaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Grayscale'**
  String get ideaGrayscaleTitle;

  /// No description provided for @ideaGrayscaleSummary.
  ///
  /// In en, this message translates to:
  /// **'Work in values only to improve depth and contrast control.'**
  String get ideaGrayscaleSummary;

  /// No description provided for @ideaGrayscaleOverview.
  ///
  /// In en, this message translates to:
  /// **'Limit color information and focus on depth, hierarchy, and material separation through value only.'**
  String get ideaGrayscaleOverview;

  /// No description provided for @ideaSeasonalTitle.
  ///
  /// In en, this message translates to:
  /// **'Seasonal'**
  String get ideaSeasonalTitle;

  /// No description provided for @ideaSeasonalSummary.
  ///
  /// In en, this message translates to:
  /// **'Blend spring, summer, autumn, or winter cues into a cohesive palette.'**
  String get ideaSeasonalSummary;

  /// No description provided for @ideaSeasonalOverview.
  ///
  /// In en, this message translates to:
  /// **'Seasonal palettes work best when one season dominates and others support the mood.'**
  String get ideaSeasonalOverview;

  /// No description provided for @ideaChristmasTitle.
  ///
  /// In en, this message translates to:
  /// **'Christmas'**
  String get ideaChristmasTitle;

  /// No description provided for @ideaChristmasSummary.
  ///
  /// In en, this message translates to:
  /// **'Classic red-green-gold range for festive contrast and cozy highlights.'**
  String get ideaChristmasSummary;

  /// No description provided for @ideaChristmasOverview.
  ///
  /// In en, this message translates to:
  /// **'Classic holiday balance: warm highlights, rich reds/greens, and selective bright accents.'**
  String get ideaChristmasOverview;

  /// No description provided for @ideaValentinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Valentine\'s Day'**
  String get ideaValentinesTitle;

  /// No description provided for @ideaValentinesSummary.
  ///
  /// In en, this message translates to:
  /// **'Romantic reds and pinks with soft highlights and warm transitions.'**
  String get ideaValentinesSummary;

  /// No description provided for @ideaValentinesOverview.
  ///
  /// In en, this message translates to:
  /// **'Romantic harmony comes from warm transitions and gentle highlight placement.'**
  String get ideaValentinesOverview;

  /// No description provided for @ideaWhiteEffectsTitle.
  ///
  /// In en, this message translates to:
  /// **'White Effects'**
  String get ideaWhiteEffectsTitle;

  /// No description provided for @ideaWhiteEffectsSummary.
  ///
  /// In en, this message translates to:
  /// **'Plan the palette to leave room for white-pen sparkles and shine accents.'**
  String get ideaWhiteEffectsSummary;

  /// No description provided for @ideaWhiteEffectsOverview.
  ///
  /// In en, this message translates to:
  /// **'Reserve whitespace and bright value zones so white-ink effects read clearly.'**
  String get ideaWhiteEffectsOverview;

  /// No description provided for @ideaWhiteEffectsEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Use white pen for sparkles on metal, eyes, and water reflections.'**
  String get ideaWhiteEffectsEmbellishment1;

  /// No description provided for @ideaWhiteEffectsEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Dot highlights in clusters, not evenly, for natural shine.'**
  String get ideaWhiteEffectsEmbellishment2;

  /// No description provided for @ideaBlackEffectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Black Effects'**
  String get ideaBlackEffectsTitle;

  /// No description provided for @ideaBlackEffectsSummary.
  ///
  /// In en, this message translates to:
  /// **'Use black line details, dots, and pattern overlays to enhance contrast.'**
  String get ideaBlackEffectsSummary;

  /// No description provided for @ideaBlackEffectsOverview.
  ///
  /// In en, this message translates to:
  /// **'Plan midtone areas where black pen details can add texture and graphic punch.'**
  String get ideaBlackEffectsOverview;

  /// No description provided for @ideaBlackEffectsEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Use black dots/stripes to add texture after color layers dry.'**
  String get ideaBlackEffectsEmbellishment1;

  /// No description provided for @ideaBlackEffectsEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Concentrate black details near focal areas for stronger emphasis.'**
  String get ideaBlackEffectsEmbellishment2;

  /// No description provided for @ideaCrayonsOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Crayons Only'**
  String get ideaCrayonsOnlyTitle;

  /// No description provided for @ideaCrayonsOnlySummary.
  ///
  /// In en, this message translates to:
  /// **'Simple bold palette that mimics classic crayon behavior and texture.'**
  String get ideaCrayonsOnlySummary;

  /// No description provided for @ideaCrayonsOnlyOverview.
  ///
  /// In en, this message translates to:
  /// **'Crayon style favors simple blocks, bold primaries, and visible stroke texture.'**
  String get ideaCrayonsOnlyOverview;

  /// No description provided for @ideaOldWestTitle.
  ///
  /// In en, this message translates to:
  /// **'Old West'**
  String get ideaOldWestTitle;

  /// No description provided for @ideaOldWestSummary.
  ///
  /// In en, this message translates to:
  /// **'Dusty sepia range with muted warmth, like an aged Western print.'**
  String get ideaOldWestSummary;

  /// No description provided for @ideaOldWestOverview.
  ///
  /// In en, this message translates to:
  /// **'Aged-photo atmosphere with dusty mids, muted warms, and restrained highlights.'**
  String get ideaOldWestOverview;

  /// No description provided for @ideaOldWestStep1.
  ///
  /// In en, this message translates to:
  /// **'Lay a sepia-like base across major areas.'**
  String get ideaOldWestStep1;

  /// No description provided for @ideaOldWestStep2.
  ///
  /// In en, this message translates to:
  /// **'Use dusty midtones and avoid highly saturated accents.'**
  String get ideaOldWestStep2;

  /// No description provided for @ideaOldWestStep3.
  ///
  /// In en, this message translates to:
  /// **'Push shadows with muted browns instead of pure black.'**
  String get ideaOldWestStep3;

  /// No description provided for @ideaOldWestStep4.
  ///
  /// In en, this message translates to:
  /// **'Reserve highlights for worn edges and sun hit points.'**
  String get ideaOldWestStep4;

  /// No description provided for @ideaOldWestEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Add subtle grain dots in empty regions for aged texture.'**
  String get ideaOldWestEmbellishment1;

  /// No description provided for @ideaOldWestEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Use broken edges on highlights to mimic worn print paper.'**
  String get ideaOldWestEmbellishment2;

  /// No description provided for @ideaHorrorHalloweenTitle.
  ///
  /// In en, this message translates to:
  /// **'Horror/Halloween'**
  String get ideaHorrorHalloweenTitle;

  /// No description provided for @ideaHorrorHalloweenSummary.
  ///
  /// In en, this message translates to:
  /// **'Dark values and eerie accents to transform normal scenes into spooky mood.'**
  String get ideaHorrorHalloweenSummary;

  /// No description provided for @ideaHorrorHalloweenOverview.
  ///
  /// In en, this message translates to:
  /// **'Push darkness and selective eerie accents to convert normal scenes into unsettling ones.'**
  String get ideaHorrorHalloweenOverview;

  /// No description provided for @ideaHorrorHalloweenStep1.
  ///
  /// In en, this message translates to:
  /// **'Drop overall value to establish darkness first.'**
  String get ideaHorrorHalloweenStep1;

  /// No description provided for @ideaHorrorHalloweenStep2.
  ///
  /// In en, this message translates to:
  /// **'Place eerie accent hues only near focal shapes.'**
  String get ideaHorrorHalloweenStep2;

  /// No description provided for @ideaHorrorHalloweenStep3.
  ///
  /// In en, this message translates to:
  /// **'Use harder edge shadows for tension.'**
  String get ideaHorrorHalloweenStep3;

  /// No description provided for @ideaHorrorHalloweenStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep bright highlights sparse and directional.'**
  String get ideaHorrorHalloweenStep4;

  /// No description provided for @ideaHorrorHalloweenEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Add subtle color noise in shadows for unsettling texture.'**
  String get ideaHorrorHalloweenEmbellishment1;

  /// No description provided for @ideaHorrorHalloweenEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Use one sharp high-contrast edge to create visual tension.'**
  String get ideaHorrorHalloweenEmbellishment2;

  /// No description provided for @ideaMidnightTitle.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get ideaMidnightTitle;

  /// No description provided for @ideaMidnightSummary.
  ///
  /// In en, this message translates to:
  /// **'Turn daytime scenes into night by pushing cool shadows and selective highlights.'**
  String get ideaMidnightSummary;

  /// No description provided for @ideaMidnightOverview.
  ///
  /// In en, this message translates to:
  /// **'Night conversion depends on cooler shadows, lower values, and sparse light accents.'**
  String get ideaMidnightOverview;

  /// No description provided for @ideaMidnightStep1.
  ///
  /// In en, this message translates to:
  /// **'Convert warm daytime areas into cooler night tones.'**
  String get ideaMidnightStep1;

  /// No description provided for @ideaMidnightStep2.
  ///
  /// In en, this message translates to:
  /// **'Push sky/background values darker than midground.'**
  String get ideaMidnightStep2;

  /// No description provided for @ideaMidnightStep3.
  ///
  /// In en, this message translates to:
  /// **'Add moonlight accents on top-facing edges.'**
  String get ideaMidnightStep3;

  /// No description provided for @ideaMidnightStep4.
  ///
  /// In en, this message translates to:
  /// **'Soften distant elements to increase nocturnal depth.'**
  String get ideaMidnightStep4;

  /// No description provided for @ideaMidnightEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Keep highlights cool and sparse to avoid reintroducing daytime feel.'**
  String get ideaMidnightEmbellishment1;

  /// No description provided for @ideaMidnightEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Darken corners more than center to create natural nighttime framing.'**
  String get ideaMidnightEmbellishment2;

  /// No description provided for @ideaUnderwaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Underwater'**
  String get ideaUnderwaterTitle;

  /// No description provided for @ideaUnderwaterSummary.
  ///
  /// In en, this message translates to:
  /// **'Cool aquatic palette with depth haze, light rays, and bubble accents.'**
  String get ideaUnderwaterSummary;

  /// No description provided for @ideaUnderwaterOverview.
  ///
  /// In en, this message translates to:
  /// **'Water depth appears through cool shifts, softened distance, suspended particles, and bubbles.'**
  String get ideaUnderwaterOverview;

  /// No description provided for @ideaUnderwaterStep1.
  ///
  /// In en, this message translates to:
  /// **'Start with cool blue-green base layers.'**
  String get ideaUnderwaterStep1;

  /// No description provided for @ideaUnderwaterStep2.
  ///
  /// In en, this message translates to:
  /// **'Fade distant elements by lowering contrast.'**
  String get ideaUnderwaterStep2;

  /// No description provided for @ideaUnderwaterStep3.
  ///
  /// In en, this message translates to:
  /// **'Add directional light rays to suggest water depth.'**
  String get ideaUnderwaterStep3;

  /// No description provided for @ideaUnderwaterStep4.
  ///
  /// In en, this message translates to:
  /// **'Use pale highlights sparingly on bubbles and reflective edges.'**
  String get ideaUnderwaterStep4;

  /// No description provided for @ideaUnderwaterEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Add bubble clusters of different sizes, denser near the light path.'**
  String get ideaUnderwaterEmbellishment1;

  /// No description provided for @ideaUnderwaterEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Paint tiny suspended particles for volume in the water.'**
  String get ideaUnderwaterEmbellishment2;

  /// No description provided for @ideaUnderwaterEmbellishment3.
  ///
  /// In en, this message translates to:
  /// **'Curve light rays slightly for a natural underwater feel.'**
  String get ideaUnderwaterEmbellishment3;

  /// No description provided for @ideaSpookyTitle.
  ///
  /// In en, this message translates to:
  /// **'Spooky'**
  String get ideaSpookyTitle;

  /// No description provided for @ideaSpookySummary.
  ///
  /// In en, this message translates to:
  /// **'Haunted-place vibe using desaturated darks and chilling accent tones.'**
  String get ideaSpookySummary;

  /// No description provided for @ideaSpookyOverview.
  ///
  /// In en, this message translates to:
  /// **'A haunted look uses desaturated dark fields and isolated eerie accents.'**
  String get ideaSpookyOverview;

  /// No description provided for @ideaSpookyStep1.
  ///
  /// In en, this message translates to:
  /// **'Start from a dim neutral base with low saturation.'**
  String get ideaSpookyStep1;

  /// No description provided for @ideaSpookyStep2.
  ///
  /// In en, this message translates to:
  /// **'Introduce one eerie accent hue in key focal areas.'**
  String get ideaSpookyStep2;

  /// No description provided for @ideaSpookyStep3.
  ///
  /// In en, this message translates to:
  /// **'Use uneven shadow edges for haunted atmosphere.'**
  String get ideaSpookyStep3;

  /// No description provided for @ideaSpookyStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep backgrounds subdued so the subject feels isolated.'**
  String get ideaSpookyStep4;

  /// No description provided for @ideaFantasyTitle.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get ideaFantasyTitle;

  /// No description provided for @ideaFantasySummary.
  ///
  /// In en, this message translates to:
  /// **'Magical tones with luminous accents and stylized contrast.'**
  String get ideaFantasySummary;

  /// No description provided for @ideaFantasyOverview.
  ///
  /// In en, this message translates to:
  /// **'Push stylized hue choices and luminous accents while keeping shadows readable.'**
  String get ideaFantasyOverview;

  /// No description provided for @ideaInTheMoodTitle.
  ///
  /// In en, this message translates to:
  /// **'In the Mood'**
  String get ideaInTheMoodTitle;

  /// No description provided for @ideaInTheMoodSummary.
  ///
  /// In en, this message translates to:
  /// **'Express one emotional tone through value rhythm and hue bias.'**
  String get ideaInTheMoodSummary;

  /// No description provided for @ideaInTheMoodOverview.
  ///
  /// In en, this message translates to:
  /// **'Choose one emotional direction and keep every hue/value decision aligned with it.'**
  String get ideaInTheMoodOverview;

  /// No description provided for @ideaSculptureTitle.
  ///
  /// In en, this message translates to:
  /// **'Sculpture'**
  String get ideaSculptureTitle;

  /// No description provided for @ideaSculptureSummary.
  ///
  /// In en, this message translates to:
  /// **'Metallic or stone-like palette focused on material highlights and hard edges.'**
  String get ideaSculptureSummary;

  /// No description provided for @ideaSculptureOverview.
  ///
  /// In en, this message translates to:
  /// **'Material realism comes from edge control, value planes, and restrained saturation.'**
  String get ideaSculptureOverview;

  /// No description provided for @ideaGalaxyTitle.
  ///
  /// In en, this message translates to:
  /// **'Galaxy'**
  String get ideaGalaxyTitle;

  /// No description provided for @ideaGalaxySummary.
  ///
  /// In en, this message translates to:
  /// **'Nebula-inspired range with deep space shadows and starlight accents.'**
  String get ideaGalaxySummary;

  /// No description provided for @ideaGalaxyOverview.
  ///
  /// In en, this message translates to:
  /// **'Cosmic scenes need deep darks, vibrant nebula zones, and tiny high-contrast stars.'**
  String get ideaGalaxyOverview;

  /// No description provided for @ideaStainedGlassTitle.
  ///
  /// In en, this message translates to:
  /// **'Stained Glass'**
  String get ideaStainedGlassTitle;

  /// No description provided for @ideaStainedGlassSummary.
  ///
  /// In en, this message translates to:
  /// **'Jewel-tone palette with dark separators to mimic leaded glass pieces.'**
  String get ideaStainedGlassSummary;

  /// No description provided for @ideaStainedGlassOverview.
  ///
  /// In en, this message translates to:
  /// **'Think in colored panels and dark separators rather than smooth painterly blending.'**
  String get ideaStainedGlassOverview;

  /// No description provided for @ideaStainedGlassStep1.
  ///
  /// In en, this message translates to:
  /// **'Block separate color panels before any blending.'**
  String get ideaStainedGlassStep1;

  /// No description provided for @ideaStainedGlassStep2.
  ///
  /// In en, this message translates to:
  /// **'Leave dark separators between major shapes.'**
  String get ideaStainedGlassStep2;

  /// No description provided for @ideaStainedGlassStep3.
  ///
  /// In en, this message translates to:
  /// **'Increase saturation in center panels for luminosity.'**
  String get ideaStainedGlassStep3;

  /// No description provided for @ideaStainedGlassStep4.
  ///
  /// In en, this message translates to:
  /// **'Use highlights as reflected light, not smooth gradients.'**
  String get ideaStainedGlassStep4;

  /// No description provided for @ideaStainedGlassEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Use thin black separators to mimic lead came lines.'**
  String get ideaStainedGlassEmbellishment1;

  /// No description provided for @ideaStainedGlassEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Keep each panel hue clean and avoid muddy mixes.'**
  String get ideaStainedGlassEmbellishment2;

  /// No description provided for @ideaDefaultOverview.
  ///
  /// In en, this message translates to:
  /// **'Creative challenge'**
  String get ideaDefaultOverview;

  /// No description provided for @ideaDefaultStep1.
  ///
  /// In en, this message translates to:
  /// **'Block large shapes with your dominant tones.'**
  String get ideaDefaultStep1;

  /// No description provided for @ideaDefaultStep2.
  ///
  /// In en, this message translates to:
  /// **'Build depth using one lighter and one darker support color.'**
  String get ideaDefaultStep2;

  /// No description provided for @ideaDefaultStep3.
  ///
  /// In en, this message translates to:
  /// **'Use your accent color only on focal areas.'**
  String get ideaDefaultStep3;

  /// No description provided for @ideaDefaultStep4.
  ///
  /// In en, this message translates to:
  /// **'Finish with line cleanup and controlled highlights.'**
  String get ideaDefaultStep4;

  /// No description provided for @ideaDefaultEmbellishment1.
  ///
  /// In en, this message translates to:
  /// **'Run a final pass to simplify accents and keep one clear focal area.'**
  String get ideaDefaultEmbellishment1;

  /// No description provided for @ideaDefaultEmbellishment2.
  ///
  /// In en, this message translates to:
  /// **'Reserve your brightest highlight for the subject you want first attention on.'**
  String get ideaDefaultEmbellishment2;

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
  /// **'Older / community'**
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
