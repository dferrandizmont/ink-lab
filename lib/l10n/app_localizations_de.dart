// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get settingsTitle => 'Optionen';

  @override
  String get settingsCollectionGroup => 'Meine Sammlung';

  @override
  String get settingsDisplayGroup => 'Anzeige';

  @override
  String get settingsDataGroup => 'Deine Daten';

  @override
  String get settingsAiGroup => 'KI-Assistent';

  @override
  String get settingsAiOffByDefault => 'Standardmäßig aus';

  @override
  String get settingsUnavailable =>
      'Die App-Dienste sind nicht verfügbar, daher können die Einstellungen nicht angezeigt werden.';

  @override
  String get settingsBrandTitle => 'Marke';

  @override
  String get settingsBrandSubtitle =>
      'Die Marke bestimmt den Katalog der Marker, mit dem die App arbeitet.';

  @override
  String get settingsPalettesTitle => 'Gespeicherte Paletten';

  @override
  String get settingsClearPalettes => 'Alle löschen';

  @override
  String get settingsClearPalettesTitle =>
      'Alle gespeicherten Paletten löschen?';

  @override
  String get settingsClearPalettesBody =>
      'Die für diese Marke gespeicherten Paletten werden gelöscht. Das lässt sich nicht rückgängig machen.';

  @override
  String get settingsFavoritesTitle => 'Favoriten';

  @override
  String get settingsFavoritesEmpty => 'Noch keine Farbe als Favorit.';

  @override
  String get settingsClearFavorites => 'Alle löschen';

  @override
  String get settingsClearFavoritesTitle => 'Alle Favoriten entfernen?';

  @override
  String get settingsClearFavoritesBody =>
      'Die Lieblingsfarben dieser Marke werden entfernt. Das lässt sich nicht rückgängig machen.';

  @override
  String get settingsDeleteFavorite => 'Favorit entfernen';

  @override
  String get settingsLabelsTitle => 'Ohuhu-Codes';

  @override
  String get settingsLabelsSubtitle => 'Ohuhu hat seine Codes 2023 umbenannt.';

  @override
  String get settingsNewLabels => 'Aktuell';

  @override
  String get settingsOldLabels => 'Alt';

  @override
  String get settingsBothLabels => 'Beide';

  @override
  String get settingsAppearanceTitle => 'Darstellung';

  @override
  String get settingsAppearanceSystem => 'System';

  @override
  String get settingsAppearanceLight => 'Hell';

  @override
  String get settingsAppearanceDark => 'Dunkel';

  @override
  String get settingsBackupSubtitle =>
      'Kopiert deine Daten (Sammlung, Paletten, Tagebuch, Verlauf und Einstellungen) als Text in die Zwischenablage, um sie später zu importieren. Fotos und der API-Schlüssel sind nicht dabei.';

  @override
  String get settingsExportBackup => 'Export';

  @override
  String get settingsImportBackup => 'Import';

  @override
  String get settingsBackupExported =>
      'Sicherung in die Zwischenablage kopiert, ohne Fotos';

  @override
  String get settingsBackupImported => 'Sicherung importiert';

  @override
  String get settingsImportTitle => 'Sicherung importieren';

  @override
  String get settingsImportHint => 'Exportiertes JSON hier einfügen';

  @override
  String get settingsImportConfirm => 'Importieren';

  @override
  String get settingsCancel => 'Abbrechen';

  @override
  String get settingsImportConfirmTitle => 'Deine aktuellen Daten ersetzen?';

  @override
  String get settingsImportConfirmBody =>
      'Die Sicherung ersetzt deine aktuellen Daten: Sammlung, Paletten, Tagebuch, Verlauf und Einstellungen. Tagebucheinträge, die nicht darin sind, werden mit ihren Fotos gelöscht; Fotos sind nie Teil einer Sicherung.';

  @override
  String get ideasFavoritesChip => 'Favoriten';

  @override
  String get ideasFavoritesEmptyTitle => 'Noch keine Lieblingsideen';

  @override
  String get ideasFavoritesEmptyMessage =>
      'Tippe auf das Herz einer Idee, um sie hier zu behalten.';

  @override
  String get ideasRecentTitle => 'Zuletzt angesehen';

  @override
  String get settingsBackupFileCaption =>
      'Eine ZIP-Datei mit deinen Daten und allen Fotos: Tagebuch, Farbmuster und Rezepte. Wähle im Teilen-Menü Dateien, Drive oder eine andere App, um sie aufzubewahren. Der API-Schlüssel ist nie enthalten.';

  @override
  String get settingsBackupTextTitle => 'Kopie als Text (ohne Fotos)';

  @override
  String get settingsSaveBackupFile => 'Sicherungsdatei teilen';

  @override
  String get settingsRestoreBackupFile => 'Aus Datei wiederherstellen';

  @override
  String get settingsBackupFileSaving => 'Daten und Fotos werden gepackt…';

  @override
  String get settingsBackupFileRestoring => 'Sicherung wird wiederhergestellt…';

  @override
  String get settingsRestoreConfirmBody =>
      'Die Datei ersetzt deine aktuellen Daten: Sammlung, Paletten, Tagebuch, Verlauf und Einstellungen. Die Fotos in der Datei werden mit wiederhergestellt. Tagebucheinträge, die nicht darin sind, werden mit ihren Fotos gelöscht.';

  @override
  String get settingsBackupFileRestored =>
      'Sicherung wiederhergestellt, mit Fotos';

  @override
  String get settingsBackupFileSaveFailed =>
      'Die Sicherungsdatei konnte nicht erstellt werden.';

  @override
  String get settingsBackupFileReadFailed =>
      'Die Datei konnte nicht gelesen werden.';

  @override
  String get settingsBackupFileNotZip => 'Diese Datei ist keine ZIP-Sicherung.';

  @override
  String get settingsBackupFileTooLarge =>
      'Die Sicherung ist zu groß für Ink Lab.';

  @override
  String get settingsBackupFileEntryTooLarge =>
      'Ein Foto in der Sicherung ist zu groß.';

  @override
  String get settingsBackupFileDamaged =>
      'Die Datei ist beschädigt oder keine Ink-Lab-Sicherung.';

  @override
  String get settingsBackupFileUnsupported =>
      'Diese Sicherung stammt aus einer Version, die Ink Lab nicht lesen kann.';

  @override
  String get settingsBackupFileNotAPhoto =>
      'Ein Foto in der Datei ist kein JPEG-, PNG- oder WebP-Bild.';

  @override
  String get settingsBackupFileWriteFailed =>
      'Die Fotos konnten nicht gespeichert werden. Deine Daten sind unverändert.';

  @override
  String get settingsImportInvalidJson => 'Der Text ist kein gültiges JSON.';

  @override
  String get settingsImportInvalidDocument =>
      'Der Text ist kein Sicherungsdokument.';

  @override
  String get settingsAiTitle => 'KI-Assistent';

  @override
  String get settingsAiSubtitle =>
      'Die KI schlägt nur Paletten vor. Sie ändert nie deine Sammlung.';

  @override
  String get settingsAiEnabled => 'Mit KI vorschlagen';

  @override
  String get settingsAiEnabledSubtitleColourTheory =>
      'Wähle unten Auf dem Gerät oder OpenRouter, um eine KI zu nutzen';

  @override
  String get settingsAiEnabledSubtitleColourTheoryNoOnDevice =>
      'Wähle unten OpenRouter, um eine KI zu nutzen';

  @override
  String get settingsAiEnabledSubtitleOnDevice =>
      'Gemini Nano auf diesem Handy';

  @override
  String get settingsAiEnabledSubtitleOpenRouter =>
      'Nutzt deinen eigenen OpenRouter-Schlüssel';

  @override
  String get settingsAiExplainColourTheory =>
      'Die Paletten kommen aus der eingebauten Farbtheorie-Engine. Keine KI, nichts verlässt dein Handy.';

  @override
  String get settingsAiExplainOnDevice =>
      'Gemini Nano läuft auf diesem Handy, und deine Anfragen bleiben darauf. Googles ML Kit sendet Nutzungsdiagnosen an Google.';

  @override
  String get settingsAiExplainOpenRouter =>
      'Anfragen gehen mit deinem eigenen Schlüssel an openrouter.ai. Fotos werden nie gesendet.';

  @override
  String get settingsAiProvider => 'Anbieter';

  @override
  String get settingsAiProviderColourTheory => 'Farbtheorie';

  @override
  String get settingsAiProviderOnDevice => 'Auf dem Gerät';

  @override
  String get settingsAiProviderOpenRouter => 'OpenRouter';

  @override
  String get settingsAiTextModel => 'Textmodell';

  @override
  String get settingsAiTextModelHint => 'Modell-ID für Textanfragen';

  @override
  String get settingsAiVisionModel => 'Bildmodell';

  @override
  String get settingsAiVisionModelHint => 'Modell-ID für Bildanfragen';

  @override
  String get settingsAiTemperature => 'Temperatur';

  @override
  String get settingsAiMaxTokens => 'Max. Tokens';

  @override
  String get settingsAiAutoFallback => 'Eingebaute Alternative';

  @override
  String get settingsAiAutoFallbackSubtitle =>
      'Schlägt die KI fehl, antwortet stattdessen die eingebaute Engine.';

  @override
  String get settingsAiApiKey => 'API-Schlüssel';

  @override
  String get settingsAiApiKeySubtitle =>
      'Dein eigener Schlüssel, im sicheren Speicher dieses Geräts abgelegt.';

  @override
  String get settingsAiApiKeySave => 'Schlüssel speichern';

  @override
  String get settingsAiApiKeyRemove => 'Entfernen';

  @override
  String get settingsAiApiKeySaved => 'Schlüssel gespeichert.';

  @override
  String get settingsAiRemoveKeyTitle => 'API-Schlüssel entfernen?';

  @override
  String get settingsAiRemoveKeyBody =>
      'Der Schlüssel wird von diesem Gerät gelöscht. KI-Vorschläge stehen erst wieder zur Verfügung, wenn du einen Schlüssel eingibst.';

  @override
  String get settingsAiRemoveKeyConfirm => 'Entfernen';

  @override
  String get settingsAiApiKeyInvalid =>
      'Das sieht nicht nach einem OpenRouter-Schlüssel aus. Er muss mit sk-or- beginnen und darf keine Leerzeichen enthalten.';

  @override
  String get settingsAiApiKeyUnreadable =>
      'Dein gespeicherter Schlüssel konnte nicht gelesen werden. Gib ihn erneut ein.';

  @override
  String get settingsAiApiKeyStorageError =>
      'Der Schlüssel konnte nicht gespeichert werden. Versuche es erneut.';

  @override
  String get settingsAiDisclosureTitle => 'KI-Vorschläge einschalten?';

  @override
  String get settingsAiDisclosure =>
      'Ist dies eingeschaltet und du bittest OpenRouter um einen Vorschlag, sendet die App mit deinem eigenen API-Schlüssel an openrouter.ai und den Modellanbieter: die Marke, den Palettenmodus und die Szene, Code und Name des Basismarkers und ob er gesperrt ist, die Palettengröße, die Codes und Hex-Farben der infrage kommenden Marker, die Modelleinstellungen und die festen Anweisungen der App. Fotos werden nie gesendet: Diese Funktion hat keinen Bild-Upload. Unter Android kann die App außerdem Googles ML Kit fragen, ob Gemini Nano verfügbar ist; ML Kit sendet Nutzungsdiagnosen an Google. Bei ausgeschaltetem Schalter wird gar nichts gesendet.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'Ist Farbtheorie gewählt, kommen die Paletten aus der eingebauten Engine: Es wird keine KI genutzt, und sie bleiben auf deinem Handy. Unter Android kann die App Googles ML Kit fragen, ob Gemini Nano verfügbar ist; ML Kit sendet Nutzungsdiagnosen an Google, nie deine Farben oder Fotos. Wähle Auf dem Gerät oder OpenRouter, um eine KI zu nutzen.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'Ist Farbtheorie gewählt, kommen die Paletten aus der eingebauten Engine: Es wird keine KI genutzt, und sie bleiben auf deinem Handy. Unter Android kann die App Googles ML Kit fragen, ob Gemini Nano verfügbar ist; ML Kit sendet Nutzungsdiagnosen an Google, nie deine Farben oder Fotos. Wähle OpenRouter, um eine KI zu nutzen.';

  @override
  String get settingsAiDisclosureConfirm => 'Aktivieren';

  @override
  String get settingsAiDisclosureCancel => 'Nicht jetzt';

  @override
  String get settingsAiDisclosureOnDevice =>
      'Anfragen an das Modell auf dem Gerät (Gemini Nano) beantwortet das Modell auf diesem Handy: Dein Szenario und deine Farbcodes verlassen es nie, und es ist kein Schlüssel nötig. Zum Prüfen, Herunterladen und Ausführen des Modells nutzt die App Googles ML Kit, das Nutzungsdiagnosen an Google sendet (Handymodell, App-Version, Kennungen pro Installation, Fehler und Größen), nie deine Eingaben, Farben oder Fotos. Bei ausgeschaltetem Schalter wird nichts gesendet.';

  @override
  String get settingsAiOnDeviceName => 'Auf dem Gerät (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Deine Anfragen bleiben auf diesem Handy. ML Kit sendet Nutzungsdiagnosen an Google, nie deine Eingaben, Farben oder Fotos.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'Das Modell ist noch nicht auf diesem Handy. Android lädt es einmal herunter und behält es für alle Apps.';

  @override
  String get settingsAiOnDeviceDownloading => 'Modell wird heruntergeladen …';

  @override
  String get settingsAiOnDevicePreparing =>
      'Android bereitet das Modell vor. Das kann dauern und auf WLAN und Laden warten. Du kannst diesen Bildschirm verlassen; der Download läuft im Hintergrund weiter.';

  @override
  String get settingsAiEnabledSubtitleOnDeviceIos =>
      'Apple Intelligence auf diesem Handy';

  @override
  String get settingsAiExplainOnDeviceIos =>
      'Apples Modell läuft auf diesem Handy, und deine Anfragen bleiben darauf.';

  @override
  String get settingsAiDisclosureOnDeviceIos =>
      'Anfragen an das Modell auf dem Gerät (Apple Intelligence) beantwortet Apples Modell auf diesem Handy: Dein Szenario und deine Farbcodes verlassen es nie, und es ist kein Schlüssel nötig. iOS installiert und verwaltet das Modell mit Apple Intelligence; die App lädt nichts herunter und nutzt dafür keinen anderen Dienst, es wird also nichts gesendet.';

  @override
  String get settingsAiOnDeviceNameIos => 'Auf dem Gerät (Apple Intelligence)';

  @override
  String get settingsAiOnDevicePrivacyIos =>
      'Deine Anfragen bleiben auf diesem Handy. Es wird nichts gesendet, weder Eingaben noch Farben oder Fotos.';

  @override
  String get settingsAiOnDevicePreparingIos =>
      'iOS bereitet das Modell von Apple Intelligence vor. Das kann dauern. Du kannst diesen Bildschirm verlassen; es läuft im Hintergrund weiter.';

  @override
  String get settingsAiDisclosureIos =>
      'Ist dies eingeschaltet und du bittest OpenRouter um einen Vorschlag, sendet die App mit deinem eigenen API-Schlüssel an openrouter.ai und den Modellanbieter: die Marke, den Palettenmodus und die Szene, Code und Name des Basismarkers und ob er gesperrt ist, die Palettengröße, die Codes und Hex-Farben der infrage kommenden Marker, die Modelleinstellungen und die festen Anweisungen der App. Fotos werden nie gesendet: Diese Funktion hat keinen Bild-Upload. Bei ausgeschaltetem Schalter wird gar nichts gesendet.';

  @override
  String get settingsAiDisclosureColourTheoryIos =>
      'Ist Farbtheorie gewählt, kommen die Paletten aus der eingebauten Engine: Es wird keine KI genutzt, und sie bleiben auf deinem Handy. Wähle Auf dem Gerät oder OpenRouter, um eine KI zu nutzen.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDeviceIos =>
      'Ist Farbtheorie gewählt, kommen die Paletten aus der eingebauten Engine: Es wird keine KI genutzt, und sie bleiben auf deinem Handy. Wähle OpenRouter, um eine KI zu nutzen.';

  @override
  String get settingsAiOnDeviceCheckAgain => 'Erneut prüfen';

  @override
  String get settingsAiOnDeviceReady =>
      'Das Modell ist auf diesem Handy bereit.';

  @override
  String get settingsAiOnDeviceDownload => 'Modell herunterladen';

  @override
  String get settingsAiOnDeviceFailed =>
      'Der Download wurde nicht abgeschlossen. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get settingsAiTestConnection => 'Verbindung testen';

  @override
  String get settingsAiTestingConnection => 'Wird getestet …';

  @override
  String get settingsAiModelsTitle => 'Modell';

  @override
  String get settingsAiModelsFilterFree => 'Gratis';

  @override
  String get settingsAiModelsFilterPaid => 'Bezahlt';

  @override
  String get settingsAiModelsFilterBoth => 'Beide';

  @override
  String get settingsAiModelsLoad => 'Modelle laden';

  @override
  String get settingsAiModelsEmpty => 'Kein Modell passt zu diesem Filter.';

  @override
  String get settingsAiModelsNeedsKey =>
      'Speichere einen Schlüssel, um die Modelle von OpenRouter zu laden.';

  @override
  String get settingsAiPrimaryModel => 'Textmodell';

  @override
  String get settingsAiModelNone => 'Nicht festgelegt';

  @override
  String get settingsAiModelsPickerHint =>
      'Lade die Modelle und wähle sie dann aus der Liste.';

  @override
  String get settingsAiModelSearchHint => 'Modelle suchen';

  @override
  String get settingsAiModelFree => 'Gratis';

  @override
  String get settingsAiModelPaid => 'Bezahlt';

  @override
  String get settingsAiModelsDone => 'Fertig';

  @override
  String get settingsAiModelsNotLoaded =>
      'Lade zuerst die Modelle oder gib oben eine Modell-ID ein.';

  @override
  String get settingsAiRecommended => 'Empfohlen';

  @override
  String get settingsAiFreeModelsNote =>
      'Gratis-Modelle können langsam oder unzuverlässig sein. Die empfohlenen Modelle sind günstig und antworten gleichmäßiger.';

  @override
  String get settingsAiAllModels => 'Alle Modelle';

  @override
  String get settingsAiRecommendedDefault => 'Empfohlener Standard';

  @override
  String get settingsAiFallbacksTitle => 'Alternativen';

  @override
  String get settingsAboutTitle => 'Info';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsSourceCode => 'Quellcode';

  @override
  String get settingsPrivacyPolicy => 'Datenschutzerklärung';

  @override
  String get settingsCopyRepository => 'Link kopieren';

  @override
  String get settingsRepositoryCopied => 'Link kopiert';

  @override
  String get settingsDisclaimer =>
      'Ink Lab ist ein unabhängiges Community-Projekt: Es ist mit keiner der aufgeführten Markermarken verbunden und wird von keiner unterstützt oder gesponsert. Ihre Markercodes, Namen und Farbwerte dienen nur als sachliche Referenzdaten.';

  @override
  String get paletteTitle => 'Palette';

  @override
  String get paletteBaseCodeLabel => 'Code des Basismarkers';

  @override
  String paletteBaseCodeHint(String first, String second) {
    return '$first oder $second';
  }

  @override
  String paletteBaseCodeHintOne(String code) {
    return '$code';
  }

  @override
  String get paletteScenarioToggle => 'Szenen';

  @override
  String get paletteTypeTitle => 'Palettentyp';

  @override
  String get paletteTypeSheetTitle => 'Palettentyp wählen';

  @override
  String get paletteTypeTheoryGroup => 'Farbtheorie';

  @override
  String get paletteTypeScenesGroup => 'Szenen';

  @override
  String get paletteTypeScenesHint => 'Fertige Rezepte nach Motiv';

  @override
  String get paletteTypeDescRecommended => 'Ausgewogen für deine Basis';

  @override
  String get paletteTypeDescComplementary => 'Gegenfarbe, starker Kontrast';

  @override
  String get paletteTypeDescAnalogous => 'Benachbarte Farbtöne, ruhig';

  @override
  String get paletteTypeDescSplitComplementary =>
      'Zwei Nachbarn der Gegenfarbe';

  @override
  String get paletteTypeDescTriad => 'Drei Töne, gleich verteilt';

  @override
  String get paletteTypeDescSquare => 'Vier Töne, gleich verteilt';

  @override
  String get paletteTypeDescRectangle => 'Zwei komplementäre Paare';

  @override
  String get paletteTypeDescMonochrome => 'Ein Farbton, von hell bis dunkel';

  @override
  String get paletteTypeDescShadow => 'Tiefere Töne zum Schattieren';

  @override
  String get paletteTypeDescCustomPalette => 'Von Hand zusammenstellen';

  @override
  String get modeBlendingChain => 'Blend-Kette';

  @override
  String get paletteTypeDescBlendingChain => 'Verblenden: hell bis dunkel';

  @override
  String paletteChainResultTitle(int count) {
    return 'Blend-Kette ($count)';
  }

  @override
  String paletteChainStep(int step, String role) {
    return 'Schritt $step · $role';
  }

  @override
  String get roleLightest => 'Hellster';

  @override
  String get roleLighter => 'Heller';

  @override
  String get roleDarker => 'Dunkler';

  @override
  String get roleDarkest => 'Dunkelster';

  @override
  String get paletteChainHint =>
      'Arbeite von hell nach dunkel und überlappe jeden Schritt, solange die Tinte noch nass ist. Verwische die Übergänge mit dem farblosen Blender, falls du einen hast.';

  @override
  String paletteChainShort(int count, int wanted) {
    return 'Nur $count deiner Marker lassen sich gut mit dieser Basis verblenden, weniger als die $wanted, die du wolltest.';
  }

  @override
  String get paletteChainNeedLighter =>
      'Noch keine Kette: Du brauchst einen helleren Marker in dieser Familie.';

  @override
  String get paletteChainNeedDarker =>
      'Noch keine Kette: Du brauchst einen dunkleren Marker in dieser Familie.';

  @override
  String get paletteChainNeedBoth =>
      'Noch keine Kette: Du brauchst einen helleren und einen dunkleren Marker in dieser Familie.';

  @override
  String get paletteChainBaseLightest =>
      'Du hast nichts Helleres in dieser Familie, daher beginnt die Kette bei deiner Basis.';

  @override
  String get paletteChainBaseDarkest =>
      'Du hast nichts Dunkleres in dieser Familie, daher endet die Kette bei deiner Basis.';

  @override
  String get paletteChainOptionsLabel => 'Weitere Ketten';

  @override
  String paletteChainOption(int number) {
    return 'Option $number';
  }

  @override
  String get paletteChainWholeRange => 'Im ganzen Sortiment suchen';

  @override
  String paletteChainWholeRangeNote(String brand) {
    return 'Das ganze $brand-Sortiment wird angezeigt, auch Marker, die du nicht besitzt.';
  }

  @override
  String get paletteChainMyMarkers => 'Zurück zu meinen Markern';

  @override
  String get palettePaintTipChainFirst =>
      'Trage zuerst die hellste Farbe über die ganze Fläche auf.';

  @override
  String get palettePaintTipChainMiddle =>
      'Überlappe den vorherigen Schritt, solange er noch nass ist.';

  @override
  String get palettePaintTipChainLast =>
      'Setze die dunkelste Farbe nur dort, wo der Schatten fällt.';

  @override
  String get swatchesBlendingChain => 'Blend-Kette';

  @override
  String paletteTypeSemantic(String value) {
    return 'Palettentyp, $value';
  }

  @override
  String get paletteSceneTitle => 'Szene';

  @override
  String get paletteSceneSheetTitle => 'Szene wählen';

  @override
  String get paletteSceneSearchHint => 'Szene oder Kategorie';

  @override
  String get paletteSceneEmpty => 'Keine Szene passt zu deiner Suche.';

  @override
  String paletteSceneSemantic(String value) {
    return 'Szene, $value';
  }

  @override
  String get paletteFromPhotoTitle => 'Aus einem Foto';

  @override
  String get paletteFromPhotoHint => 'Dein Foto, mit deinen Markern';

  @override
  String get paletteFromPhotoValue => 'Dein Foto';

  @override
  String paletteFromPhotoRole(int percent) {
    return 'Fotofarbe · $percent %';
  }

  @override
  String get paletteFromPhotoEmpty =>
      'Aus diesem Foto konnten keine Farben ermittelt werden';

  @override
  String get paletteFromPhotoFarNote =>
      'Für manche Fotofarben gibt es in deiner Sammlung keinen nahen Marker';

  @override
  String get sceneCategoryCharacters => 'Figuren';

  @override
  String get sceneCategorySkin => 'Haut und Porträts';

  @override
  String get sceneCategorySkyWater => 'Himmel und Wasser';

  @override
  String get sceneCategoryNature => 'Natur';

  @override
  String get sceneCategoryMaterials => 'Materialien';

  @override
  String get sceneCategoryAnimals => 'Tiere und Fell';

  @override
  String get sceneCategoryFood => 'Essen';

  @override
  String get sceneCategoryHolidays => 'Feste und Stimmungen';

  @override
  String get sceneCategoryInteriors => 'Innenräume';

  @override
  String get sceneCategoryPatterns => 'Muster';

  @override
  String get sceneCategoryFantasy => 'Fantasy';

  @override
  String get paletteSizeTitle => 'Größe';

  @override
  String get paletteSizeSemantic => 'Palettengröße';

  @override
  String get paletteGenerateButton => 'Erstellen';

  @override
  String get paletteRegenerateButton => 'Neu erstellen';

  @override
  String get paletteClearButton => 'Leeren';

  @override
  String get paletteSuggestAiButton => 'Mit KI vorschlagen';

  @override
  String get paletteSuggestAiLoading => 'Wird vorgeschlagen …';

  @override
  String get paletteAiBadge => 'KI';

  @override
  String get paletteSaveButton => 'Palette speichern';

  @override
  String get paletteSavedButton => 'Palette gespeichert';

  @override
  String get paletteShareButton => 'Teilen';

  @override
  String get shareFailed => 'Das Bild konnte nicht geteilt werden.';

  @override
  String get paletteOkButton => 'OK';

  @override
  String get paletteBaseMarkerTitle => 'Basismarker';

  @override
  String get paletteVariationsLabel => 'Varianten';

  @override
  String get palettePaintPlanTitle => 'Malreihenfolge';

  @override
  String get palettePaintTipBase =>
      'Lege zuerst die Grundform mit der Basisfarbe an.';

  @override
  String get palettePaintTipShadow =>
      'Trage diesen Schatten dort auf, wo kein Licht hinkommt.';

  @override
  String get palettePaintTipHighlight =>
      'Setze das Licht dort, wo es direkt trifft.';

  @override
  String get palettePaintTipAccent => 'Spare den Akzent für Blickpunkte auf.';

  @override
  String get palettePaintTipSupport =>
      'Nutze diesen Hilfston, um Übergänge zu verblenden.';

  @override
  String get paletteSubtitleIdle =>
      'Erstelle eine Palette aus einem Basismarker, den du besitzt';

  @override
  String get paletteLockButton => 'Sperren';

  @override
  String get paletteUnlockButton => 'Entsperren';

  @override
  String get paletteSaveDialogTitle => 'Palette speichern';

  @override
  String get paletteSaveDialogHint => 'Palettenname';

  @override
  String get paletteSaveDialogCancel => 'Abbrechen';

  @override
  String get paletteSaveDialogConfirm => 'Speichern';

  @override
  String get paletteSavedTitle => 'Gespeicherte Paletten';

  @override
  String get paletteSavedEmpty =>
      'Für diese Marke sind noch keine Paletten gespeichert.';

  @override
  String palettePaintPlanSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schritte',
      one: '1 Schritt',
    );
    return '$_temp0';
  }

  @override
  String get paletteLoadButton => 'Laden';

  @override
  String get paletteDeleteButton => 'Löschen';

  @override
  String get paletteDeleteDialogTitle => 'Palette löschen?';

  @override
  String get paletteDeleteDialogBody =>
      'Das lässt sich nicht rückgängig machen.';

  @override
  String get paletteAiReportButton => 'Diesen Vorschlag melden';

  @override
  String get paletteAiReportTitle => 'Diesen Vorschlag melden';

  @override
  String get paletteAiReportBody =>
      'Sag uns, wenn die KI etwas Anstößiges, Unpassendes oder Falsches geschrieben hat. Deine E-Mail-App öffnet sich mit dem Text des Vorschlags; du entscheidest, ob du ihn sendest. Dein API-Schlüssel wird nie mitgeschickt.';

  @override
  String get paletteAiReportOffensive => 'Anstößig oder unpassend';

  @override
  String get paletteAiReportWrong => 'Falsch oder ergibt keinen Sinn';

  @override
  String get paletteAiReportOther => 'Etwas anderes';

  @override
  String get paletteAiReportSend => 'Per E-Mail senden';

  @override
  String get paletteAiReportThanks =>
      'Danke, das hilft uns, die Vorschläge zu verbessern';

  @override
  String get paletteAiReportCopied =>
      'Keine E-Mail-App gefunden. Die Meldung wurde kopiert: Füge sie in eine E-Mail an inklab@mainshai.com ein';

  @override
  String get paletteAiFellBack =>
      'KI nicht verfügbar. Lokale Vorschläge werden angezeigt.';

  @override
  String get paletteEmptyHint =>
      'Wähle einen Basismarker für eine Palette oder Szenen als Palettentyp.';

  @override
  String missingMarkersTitle(String brand) {
    return 'Du hast noch keine $brand-Marker';
  }

  @override
  String get missingMarkersAction => 'Zu Meiner Sammlung';

  @override
  String get paletteCustomModeHint =>
      'Der Modus Eigene Palette ist manuell: Lade eine gespeicherte Palette oder übernimm eine aus Ideen.';

  @override
  String get paletteNoSuggestions =>
      'Aus deiner Sammlung ließ sich keine Palette erstellen. Probiere einen anderen Modus oder füge mehr Marker hinzu.';

  @override
  String get paletteScenarioTitle => 'Szenen';

  @override
  String get palettePickBaseTooltip => 'Aus deinen Markern wählen';

  @override
  String get palettePickerTitle => 'Basismarker wählen';

  @override
  String get palettePickerSearchHint => 'Code oder Name';

  @override
  String get palettePickerEmpty => 'Kein Marker passt zu deiner Suche.';

  @override
  String get paletteUndoButton => 'Rückgängig';

  @override
  String paletteBaseReplaced(String code) {
    return '$code ist jetzt die Basis. Deine vorherige Palette wurde ersetzt.';
  }

  @override
  String paletteIdeaApplied(String title, int count) {
    return 'Palette „$title“ übernommen ($count Marker).';
  }

  @override
  String get swatchesTitle => 'Farbmuster';

  @override
  String get swatchesSearchHint => 'Code, Name oder Hex';

  @override
  String swatchesClosestTo(String hex) {
    return 'Am nächsten an $hex';
  }

  @override
  String get swatchesClearSearch => 'Suche löschen';

  @override
  String get swatchesAllFilter => 'Alle';

  @override
  String get swatchesFavoritesOnly => 'Favoriten';

  @override
  String get swatchesOwnedOnly => 'Meine';

  @override
  String get swatchesFilters => 'Filter';

  @override
  String get swatchesFiltersTitle => 'Filter';

  @override
  String get swatchesLabelPack => 'Set';

  @override
  String get swatchesLabelLayout => 'Ansicht';

  @override
  String get swatchesAllPacks => 'Alle Sets';

  @override
  String get swatchesClearFilters => 'Filter löschen';

  @override
  String get swatchesClearSearchAndFilters => 'Suche und Filter löschen';

  @override
  String get swatchesLoadingSemantics => 'Farben werden geladen';

  @override
  String get swatchesClosestAlternatives => 'Nächste Alternativen';

  @override
  String get swatchesNoCloseAlternatives => 'Keine nahen Alternativen';

  @override
  String get swatchesInPacks => 'In Sets';

  @override
  String get swatchesLocation => 'Position';

  @override
  String get swatchesAddToPalette => 'Zur Palette';

  @override
  String get swatchesLayoutGrid => 'Raster';

  @override
  String get swatchesLayoutList => 'Liste';

  @override
  String get swatchesOwned => 'Besitze ich';

  @override
  String get swatchesNewLabels => 'Neu';

  @override
  String get swatchesOldLabels => 'Alt';

  @override
  String get swatchesBothLabels => 'Beide';

  @override
  String get swatchesLabelMode => 'Codes';

  @override
  String get swatchesToggleLayout => 'Zwischen Raster und Liste wechseln';

  @override
  String get swatchesGridLayout => 'Raster';

  @override
  String get swatchesListLayout => 'Liste';

  @override
  String get swatchesNewCode => 'Neuer Code';

  @override
  String get swatchesOldCode => 'Alter Code';

  @override
  String get swatchesNewName => 'Neuer Name';

  @override
  String get swatchesOldName => 'Alter Name';

  @override
  String get swatchesHex => 'Hex';

  @override
  String get swatchesCopyHex => 'Hex kopieren';

  @override
  String get swatchesHexCopied => 'Hex in die Zwischenablage kopiert';

  @override
  String get swatchesAddFavorite => 'Zu Favoriten hinzufügen';

  @override
  String get swatchesRemoveFavorite => 'Aus Favoriten entfernen';

  @override
  String get swatchesEmptyNoOwnedTitle => 'Noch keine Marker';

  @override
  String get swatchesEmptyNoOwnedBody =>
      'Du hast noch keine Marker hinzugefügt. Sag der App, welche Sets und Marker du hast.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Meine Sammlung einrichten';

  @override
  String get swatchesEmptyNoOwnedHint =>
      'Öffne die Optionen, dann Meine Sammlung.';

  @override
  String get swatchesEmptySearchTitle => 'Keine Farben gefunden';

  @override
  String get swatchesEmptySearchBody =>
      'Keine Farbe dieser Sammlung passt zu deiner Suche.';

  @override
  String get swatchesEmptyFiltersTitle => 'Nichts anzuzeigen';

  @override
  String get swatchesEmptyFiltersBody =>
      'Diese Marke hat keine Farben für die gewählten Sets und Filter.';

  @override
  String get swatchesEmptyNoFavoritesTitle => 'Noch keine Favoriten';

  @override
  String get swatchesEmptyNoFavoritesBody =>
      'Tippe in den Details einer Farbe auf den Stern, um sie hinzuzufügen.';

  @override
  String get swatchesEmptyNoFavoritesAction => 'Alle Farben zeigen';

  @override
  String get swatchesEmptyFavoritesNotMineTitle =>
      'Kein Favorit in deiner Sammlung';

  @override
  String get swatchesEmptyFavoritesNotMineBody =>
      'Keiner deiner Favoriten gehört zu den Markern, die du besitzt.';

  @override
  String get swatchesEmptyFavoritesNotMineAction => 'Alle Favoriten zeigen';

  @override
  String get swatchesLoading => 'Farben werden geladen …';

  @override
  String get swatchesLoadFailedTitle => 'Farben nicht verfügbar';

  @override
  String get swatchesLoadFailedBody =>
      'Der Markerkatalog konnte nicht gelesen werden, daher lassen sich keine Farben anzeigen.';

  @override
  String get swatchesUnavailable =>
      'Die App-Dienste sind nicht verfügbar, daher können die Farbmuster nicht angezeigt werden.';

  @override
  String get swatchesVisibleCount => 'Farben';

  @override
  String get swatchesScopeCollection => 'Deine Sammlung';

  @override
  String get swatchesScopePack => 'Pack';

  @override
  String get ideasTitle => 'Ideen';

  @override
  String get ideasHeaderSubtitle => 'Übungen für deine Marker';

  @override
  String get ideasSearchHint => 'Ideen suchen';

  @override
  String get ideasCategoryAll => 'Alle';

  @override
  String get ideasApplyButton => 'In Palette nutzen';

  @override
  String get ideasMoreDetails => 'Mehr Details';

  @override
  String get ideasGuideOnlyNote =>
      'Diese Übung nutzt deine ganze Sammlung und hat daher keine feste Palette.';

  @override
  String get ideasCategoriesLabel => 'Kategorien';

  @override
  String get ideasEmptyTitle => 'Keine Ideen gefunden';

  @override
  String get ideasClearFilters => 'Filter löschen';

  @override
  String get ideasEmptySearch => 'Keine Idee passt zu deiner Suche.';

  @override
  String get ideasNoMarkers => 'Derzeit keine Marker verfügbar';

  @override
  String get missingMarkersHint =>
      'Hake deine Marker in Meiner Sammlung an, um zu sehen, welche du verwenden kannst';

  @override
  String get allMarkersDried =>
      'Alle deine Marker sind ausgetrocknet. Markiere sie wieder als nutzbar, um sie weiter zu verwenden.';

  @override
  String get ideasTulipFieldTitle => 'Tulpenfeld';

  @override
  String get ideasTulipFieldSummary =>
      'Reihen aus roten und gelben Tulpen bis zum Horizont, dazwischen Frühlingsgrün.';

  @override
  String get ideasTulipFieldPractice =>
      'Flache Bänder, die in der Nähe in Punkte zerfallen.';

  @override
  String get ideasTulipFieldSubject =>
      'Tulpenreihen aus niedriger Perspektive, mit tiefem Horizont.';

  @override
  String get ideasTulipFieldTip =>
      'Die vorderste Reihe besteht aus Punkten, die hinterste aus einem Streifen: Ändere die Strichart, je weiter hinten die Reihe liegt.';

  @override
  String get ideasTulipFieldStep1 =>
      'Zeichne mit dem Bleistift Reihen, die zu einem tiefen Horizont schmaler werden.';

  @override
  String get ideasTulipFieldStep2 =>
      'Male die ersten Reihen rot: vorne einzelne Flecken, weiter hinten ein durchgehender Streifen.';

  @override
  String get ideasTulipFieldStep3 =>
      'Male die nächsten Reihen auf dieselbe Weise gelb.';

  @override
  String get ideasTulipFieldStep4 =>
      'Male mit dem hellen Grün zwischen die Reihen und entlang des Horizonts.';

  @override
  String get ideasTulipFieldStep5 =>
      'Zieh das dunklere Grün als dünne Linie an den Fuß jeder Reihe.';

  @override
  String get ideasSummerBeachTitle => 'Am Strand';

  @override
  String get ideasSummerBeachSummary =>
      'Sand, ein Streifen Meer, ein Sonnenschirm: drei flache Bänder und ein heller Akzent.';

  @override
  String get ideasSummerBeachPractice =>
      'Drei flache Bänder und ein einzelner Akzent, der den Blick lenkt.';

  @override
  String get ideasSummerBeachSubject =>
      'Ein Strand vom Sand aus gesehen, mit einem Sonnenschirm.';

  @override
  String get ideasSummerBeachTip =>
      'Lass die Gischt als Papier stehen: Sie ist die hellste Linie im Meer.';

  @override
  String get ideasSummerBeachStep1 =>
      'Zeichne mit dem Bleistift drei waagrechte Bänder (Himmel, Meer, Sand) und einen Sonnenschirm im Sand.';

  @override
  String get ideasSummerBeachStep2 =>
      'Male den hellen Sand mit sehr leichter Hand und lass den nassen Sand am Wasser heller.';

  @override
  String get ideasSummerBeachStep3 =>
      'Male das Meer in hellem Türkis und lass für die Gischt eine Linie Papier frei.';

  @override
  String get ideasSummerBeachStep4 => 'Setze dunkleres Türkis an den Horizont.';

  @override
  String get ideasSummerBeachStep5 =>
      'Male den roten Sonnenschirm und seinen kleinen Schatten auf dem Sand, den Schatten mit einer zweiten Schicht der Sandfarbe.';

  @override
  String get ideasWatermelonSliceTitle => 'Wassermelone';

  @override
  String get ideasWatermelonSliceSummary =>
      'Eine Scheibe Wassermelone: rotes Fruchtfleisch, weißer Rand, grüne Schale, schwarze Kerne.';

  @override
  String get ideasWatermelonSlicePractice =>
      'Ein schneller Verlauf und ein flacher Streifen, der weiße Rand bleibt Papier.';

  @override
  String get ideasWatermelonSliceSubject =>
      'Eine dreieckige Scheibe Wassermelone mit gebogener Unterseite.';

  @override
  String get ideasWatermelonSliceTip =>
      'Der weiße Rand ist Papier: Färbe ihn gar nicht.';

  @override
  String get ideasWatermelonSliceStep1 =>
      'Zeichne mit dem Bleistift ein Dreieck mit gebogener Unterseite und ein dünnes weißes Band innerhalb des Grüns.';

  @override
  String get ideasWatermelonSliceStep2 =>
      'Trage das helle Rot über das Fruchtfleisch auf, nahe dem Rand blasser.';

  @override
  String get ideasWatermelonSliceStep3 =>
      'Setze dunkleres Rot zur Spitze hin und verblende es, solange es nass ist.';

  @override
  String get ideasWatermelonSliceStep4 =>
      'Male die Schale grün, mit dunkelgrünen Streifen in einer zweiten Schicht.';

  @override
  String get ideasWatermelonSliceStep5 =>
      'Zeichne die Kerne mit dem Liner, jeder ein kleiner Tropfen.';

  @override
  String get ideasForestMushroomsTitle => 'Pilze am Waldboden';

  @override
  String get ideasForestMushroomsSummary =>
      'Eine Gruppe Pilze zwischen braunen Herbstblättern.';

  @override
  String get ideasForestMushroomsPractice =>
      'Runde Hüte mit kleinen Verläufen und ein lockerer, trockener Boden.';

  @override
  String get ideasForestMushroomsSubject =>
      'Drei Pilze unterschiedlicher Höhe zwischen gefallenen Blättern.';

  @override
  String get ideasForestMushroomsTip =>
      'Der Waldboden braucht lockere, unterbrochene braune Striche, keine volle Fläche.';

  @override
  String get ideasForestMushroomsStep1 =>
      'Zeichne mit dem Bleistift drei Pilze unterschiedlicher Höhe und ein paar Blätter drumherum.';

  @override
  String get ideasForestMushroomsStep2 =>
      'Setze blasses Beige auf die Stiele und die Unterseite der Hüte.';

  @override
  String get ideasForestMushroomsStep3 =>
      'Setze das Rotbraun auf die Hüte, am Rand dunkler.';

  @override
  String get ideasForestMushroomsStep4 =>
      'Male die Blätter und den Boden braun.';

  @override
  String get ideasForestMushroomsStep5 =>
      'Setze das dunkelste Braun unter die Hüte und dorthin, wo die Stiele den Boden berühren; auf die Hüte kannst du weiße Gelstiftpunkte setzen, wenn du magst.';

  @override
  String get ideasHarvestBasketTitle => 'Erntekorb';

  @override
  String get ideasHarvestBasketSummary =>
      'Äpfel, eine Birne und ein kleiner Kürbis im Korb, alle in verschiedenen Farben und mit einem einzigen Grau schattiert.';

  @override
  String get ideasHarvestBasketPractice =>
      'Ein einziges Grau, das drei kräftige Farben schattiert, damit sie zusammengehören.';

  @override
  String get ideasHarvestBasketSubject =>
      'Ein Korb voller Früchte: Äpfel, eine Birne und ein Kürbis.';

  @override
  String get ideasHarvestBasketTip =>
      'Schattiere jede Frucht mit demselben Grau. Das hält ein volles Stillleben zusammen.';

  @override
  String get ideasHarvestBasketStep1 =>
      'Zeichne mit dem Bleistift den Korb und die sich überlappenden Früchte.';

  @override
  String get ideasHarvestBasketStep2 =>
      'Male die Äpfel rot und lass das Glanzlicht als Papier stehen.';

  @override
  String get ideasHarvestBasketStep3 => 'Male die Birne gelbgrün.';

  @override
  String get ideasHarvestBasketStep4 =>
      'Male den Kürbis orange, seine Rippen als dunklere Linien in einer zweiten Schicht.';

  @override
  String get ideasHarvestBasketStep5 =>
      'Nimm dasselbe Grau für jeden Schatten und das Innere des Korbs.';

  @override
  String get ideasHarvestBasketStep6 =>
      'Nimm den dunkelsten Marker für die Flechtlinien des Korbs.';

  @override
  String get ideasHotChocolateTitle => 'Heiße Schokolade';

  @override
  String get ideasHotChocolateSummary =>
      'Ein Becher Schokolade mit Dampf, einem Marshmallow und einem roten Fäustling.';

  @override
  String get ideasHotChocolatePractice =>
      'Warme Brauntöne, ein roter Akzent und Dampf, der aus dem Hintergrund gehoben wird.';

  @override
  String get ideasHotChocolateSubject =>
      'Ein Becher heiße Schokolade mit Marshmallow und einem Fäustling daneben.';

  @override
  String get ideasHotChocolateTip =>
      'Dampf ist entweder Papier oder eine mit dem farblosen Blender herausgehobene Form, nie eine gezeichnete Linie.';

  @override
  String get ideasHotChocolateStep1 =>
      'Zeichne mit dem Bleistift den Becher, die Oberfläche des Getränks, einen Marshmallow und einen daran gelehnten Fäustling.';

  @override
  String get ideasHotChocolateStep2 =>
      'Setze blasses Braun auf die helle Seite des Bechers und auf den Schatten des Marshmallows.';

  @override
  String get ideasHotChocolateStep3 =>
      'Setze Braun auf die Oberfläche des Getränks und die Schattenseite des Bechers.';

  @override
  String get ideasHotChocolateStep4 =>
      'Male den Fäustling rot, in zwei Schichten.';

  @override
  String get ideasHotChocolateStep5 =>
      'Dampf: Heb Schwaden mit dem farblosen Blender aus dem Hintergrund oder lass sie als Papier stehen.';

  @override
  String get ideasLunarNewYearTitle => 'Mondneujahr';

  @override
  String get ideasLunarNewYearSummary =>
      'Rote Laternen mit goldenem Rand vor einer roten Wand.';

  @override
  String get ideasLunarNewYearPractice =>
      'Eine rote Farbfamilie in drei Schritten und ein flacher Goldakzent.';

  @override
  String get ideasLunarNewYearSubject =>
      'Drei runde Laternen in unterschiedlicher Höhe, mit Quasten.';

  @override
  String get ideasLunarNewYearTip =>
      'Trage das Gold auf das trockene Rot auf, nie umgekehrt.';

  @override
  String get ideasLunarNewYearStep1 =>
      'Zeichne mit dem Bleistift drei Laternen in unterschiedlicher Höhe, mit Quasten.';

  @override
  String get ideasLunarNewYearStep2 =>
      'Trage das helle Rot über die Laternen auf, auf der hellen Seite blasser.';

  @override
  String get ideasLunarNewYearStep3 =>
      'Setze das Rot auf die Schattenseite und die Rippen und verblende es, solange es nass ist.';

  @override
  String get ideasLunarNewYearStep4 =>
      'Setze Dunkelrot zwischen die Rippen und in die Ränder.';

  @override
  String get ideasLunarNewYearStep5 =>
      'Setze Goldgelb auf die Ränder, die Kappen und die Quasten, mit scharfen Kanten.';

  @override
  String get ideasDiwaliLampsTitle => 'Diwali-Lichter';

  @override
  String get ideasDiwaliLampsSummary =>
      'Eine Reihe Tonlampen mit kleinen Flammen und ein Rangoli in leuchtenden Farben darum.';

  @override
  String get ideasDiwaliLampsPractice =>
      'Ein flaches, gesättigtes Muster neben einem zweistufigen Verlauf auf den Lampen.';

  @override
  String get ideasDiwaliLampsSubject =>
      'Fünf kleine Tonlampen im Bogen, mit einem einfachen symmetrischen Muster darum.';

  @override
  String get ideasDiwaliLampsTip =>
      'Halte das Muster flach und scharfkantig. Der Kontrast zu den Lampen macht die Wirkung aus.';

  @override
  String get ideasDiwaliLampsStep1 =>
      'Zeichne mit dem Bleistift fünf kleine Lampen im Bogen und ein einfaches symmetrisches Muster darum.';

  @override
  String get ideasDiwaliLampsStep2 => 'Male die Lampen in hellem Terrakotta.';

  @override
  String get ideasDiwaliLampsStep3 =>
      'Setze dunkleres Terrakotta auf ihre Schattenseite.';

  @override
  String get ideasDiwaliLampsStep4 =>
      'Male jede Flamme gelb und setze ein Leuchten an den Rand jeder Lampe.';

  @override
  String get ideasDiwaliLampsStep5 =>
      'Setze Magenta in jeden zweiten Abschnitt des Musters, flach und scharfkantig.';

  @override
  String get ideasDiwaliLampsStep6 =>
      'Setze Türkis in die anderen Abschnitte, dann weiße Gelstiftpunkte auf die Flammen, wenn du magst.';

  @override
  String get ideasHanukkahCandlesTitle => 'Chanukka';

  @override
  String get ideasHanukkahCandlesSummary =>
      'Eine Menora mit brennenden Kerzen, Blau und Weiß mit goldenen Flammen.';

  @override
  String get ideasHanukkahCandlesPractice =>
      'Weiße Formen als Papier vor einer blauen Fläche.';

  @override
  String get ideasHanukkahCandlesSubject =>
      'Eine Menora mit brennenden Kerzen vor blauem Hintergrund.';

  @override
  String get ideasHanukkahCandlesTip =>
      'Die Kerzen sind Papier: Färbe um sie herum, dann bleiben sie weiß.';

  @override
  String get ideasHanukkahCandlesStep1 =>
      'Zeichne mit dem Bleistift die Menora und die Kerzen; die Kerzen bleiben Papier.';

  @override
  String get ideasHanukkahCandlesStep2 =>
      'Male den Hintergrund um alles herum in hellem Blau.';

  @override
  String get ideasHanukkahCandlesStep3 =>
      'Setze dunkleres Blau an die Ränder des Blatts und verblende es nach innen.';

  @override
  String get ideasHanukkahCandlesStep4 =>
      'Nimm das dunkle Blau für die Menora selbst.';

  @override
  String get ideasHanukkahCandlesStep5 =>
      'Male gelbe Flammen mit einem weichen Leuchten um jede, dann einen Kern aus weißem Gelstift in jede Flamme.';

  @override
  String get ideasPaintedEggsTitle => 'Bemalte Eier';

  @override
  String get ideasPaintedEggsSummary =>
      'Drei verzierte Eier mit Streifen, Punkten und Zickzack in mittelstarken Farben.';

  @override
  String get ideasPaintedEggsPractice =>
      'Drei Wege zu einem Muster: Papier, Form und zweite Schicht.';

  @override
  String get ideasPaintedEggsSubject =>
      'Drei Eier, jedes mit einem anderen Muster.';

  @override
  String get ideasPaintedEggsTip =>
      'Mittelstarke Farben lassen eine zweite Schicht sichtbar werden, ohne schmutzig zu wirken.';

  @override
  String get ideasPaintedEggsStep1 =>
      'Zeichne mit dem Bleistift drei Eier und auf jedem ein anderes Muster.';

  @override
  String get ideasPaintedEggsStep2 =>
      'Erstes Ei: Male die Grundfarbe flach und lass das Muster als Papier stehen.';

  @override
  String get ideasPaintedEggsStep3 =>
      'Zweites Ei: Fülle nur die Musterformen, der Rest bleibt Papier.';

  @override
  String get ideasPaintedEggsStep4 =>
      'Drittes Ei: Färbe es ein, dann setze das Muster in derselben Farbe als zweite Schicht darauf.';

  @override
  String get ideasPaintedEggsStep5 =>
      'Nimm ein Grau für die Schattenseite jedes Eies und den kleinen Schatten darunter.';

  @override
  String get ideasDiaDeMuertosTitle => 'Día de Muertos';

  @override
  String get ideasDiaDeMuertosSummary =>
      'Studentenblumen und ein verzierter Totenkopf in Orange, Magenta und Türkis auf dunklem Grund.';

  @override
  String get ideasDiaDeMuertosPractice =>
      'Gesättigtes, flaches Muster auf dunkler Fläche.';

  @override
  String get ideasDiaDeMuertosSubject =>
      'Ein verzierter Totenkopf mit Blumenformen um die Augen und einem Beet Studentenblumen darunter.';

  @override
  String get ideasDiaDeMuertosTip =>
      'Trage den dunklen Grund zuletzt und langsam auf: Dunkle Tinte läuft in die hellen Bereiche.';

  @override
  String get ideasDiaDeMuertosStep1 =>
      'Zeichne mit dem Bleistift einen Totenkopf mit Blumenformen um die Augen und einem Beet Studentenblumen darunter.';

  @override
  String get ideasDiaDeMuertosStep2 =>
      'Male die Studentenblumen in hellem Orange, jede als groben Kreis.';

  @override
  String get ideasDiaDeMuertosStep3 =>
      'Setze dunkleres Orange in kurzen Strichen in jeden Kreis für die Blütenblätter.';

  @override
  String get ideasDiaDeMuertosStep4 =>
      'Male die Muster des Totenkopfs in Magenta, flach und symmetrisch.';

  @override
  String get ideasDiaDeMuertosStep5 =>
      'Male die andere Hälfte der Muster des Totenkopfs in Türkis.';

  @override
  String get ideasDiaDeMuertosStep6 =>
      'Nimm den dunkelsten Marker für die Augenhöhlen und den Hintergrund, dann Details mit dem Liner.';

  @override
  String get ideasValentineCardTitle => 'Valentinskarte';

  @override
  String get ideasValentineCardSummary =>
      'Eine Karte mit drei Herzen von blassem Rosa bis tiefem Rot und eine Schattenlinie, die sie vom Papier abhebt.';

  @override
  String get ideasValentineCardPractice =>
      'Drei flache Füllungen und eine Schattenlinie.';

  @override
  String get ideasValentineCardSubject =>
      'Drei sich überlappende Herzen, das größte hinten.';

  @override
  String get ideasValentineCardTip =>
      'Zeichne den Schlagschatten als eine dünne Linie: Sie hebt das Herz ab, ohne weitere Farbe.';

  @override
  String get ideasValentineCardStep1 =>
      'Zeichne mit dem Bleistift drei sich überlappende Herzen, das größte hinten.';

  @override
  String get ideasValentineCardStep2 =>
      'Male das hintere Herz in blassem Rosa.';

  @override
  String get ideasValentineCardStep3 => 'Male das mittlere Herz in Rosa.';

  @override
  String get ideasValentineCardStep4 =>
      'Male das vordere Herz rot und zieh eine dünne Linie davon unter die anderen beiden, als Schlagschatten.';

  @override
  String get ideasValentineCardStep5 =>
      'Setze auf jedes Herz oben links ein Glanzlicht aus weißem Gelstift.';

  @override
  String get ideasCarnivalMaskTitle => 'Karnevalsmaske';

  @override
  String get ideasCarnivalMaskSummary =>
      'Eine Maske mit Federn in Violett, Türkis und Gold.';

  @override
  String get ideasCarnivalMaskPractice =>
      'Schnelle Striche für Federn, ein Verlauf für die Maske und flaches Gold.';

  @override
  String get ideasCarnivalMaskSubject =>
      'Eine Halbmaske mit drei Federn, die an einer Seite aufsteigen.';

  @override
  String get ideasCarnivalMaskTip =>
      'Zieh die Federn vom Kiel nach außen: Der weiche Rand lässt sie wie Federn wirken.';

  @override
  String get ideasCarnivalMaskStep1 =>
      'Zeichne mit dem Bleistift eine Halbmaske und drei Federn, die an einer Seite aufsteigen.';

  @override
  String get ideasCarnivalMaskStep2 =>
      'Male die Maske violett, mit zwei Schichten dort, wo sie sich wegwölbt.';

  @override
  String get ideasCarnivalMaskStep3 =>
      'Male die Federn türkis und zieh sie vom Kiel nach außen, damit die Ränder weich sind.';

  @override
  String get ideasCarnivalMaskStep4 =>
      'Setze Gold auf den Rand der Maske und die Augenränder.';

  @override
  String get ideasCarnivalMaskStep5 =>
      'Nimm das Dunkelste für das Innere der Augenlöcher, dann Gelstiftpunkte als Pailletten.';

  @override
  String get ideasMidsummerCrownTitle => 'Mittsommerkranz';

  @override
  String get ideasMidsummerCrownSummary =>
      'Ein Kranz aus Wildblumen und Blättern: Blau, Gelb und Rosa auf Grün.';

  @override
  String get ideasMidsummerCrownPractice =>
      'Viele kleine Tupfer mit der feinen Spitze auf trockenem grünem Grund.';

  @override
  String get ideasMidsummerCrownSubject =>
      'Ein Ring aus Blättern mit drei Arten kleiner Wildblumen.';

  @override
  String get ideasMidsummerCrownTip =>
      'Farbtupfer auf trockenem Grund bleiben scharf. Warte, bis das Grün trocken ist, bevor du mit den Blumen anfängst.';

  @override
  String get ideasMidsummerCrownStep1 =>
      'Zeichne mit dem Bleistift einen Ring aus Blättern und kleinen Blumen in drei Arten.';

  @override
  String get ideasMidsummerCrownStep2 => 'Male alle Blätter in hellem Grün.';

  @override
  String get ideasMidsummerCrownStep3 =>
      'Setze dunkleres Grün dorthin, wo sich Blätter überlappen, und darunter.';

  @override
  String get ideasMidsummerCrownStep4 => 'Male die erste Blumenart blau.';

  @override
  String get ideasMidsummerCrownStep5 => 'Male die zweite Blumenart gelb.';

  @override
  String get ideasMidsummerCrownStep6 =>
      'Male die dritte rosa, mit einer winzigen zweiten Schicht in der Mitte jeder Blume.';

  @override
  String get ideasEidNightTitle => 'Id-Nacht';

  @override
  String get ideasEidNightSummary =>
      'Eine Mondsichel und eine hängende Laterne vor einem Himmel in tiefem Türkis und Violett.';

  @override
  String get ideasEidNightPractice =>
      'Ein sauberer nasser Verlauf von Türkis zu Violett, mit Gold obendrauf.';

  @override
  String get ideasEidNightSubject =>
      'Eine Mondsichel und eine gemusterte Laterne vor dem Nachthimmel.';

  @override
  String get ideasEidNightTip =>
      'Verblende das Türkis ins Violett, solange beide nass sind. Trocken bleibt der Himmel sauber.';

  @override
  String get ideasEidNightStep1 =>
      'Zeichne mit dem Bleistift die Sichel und eine gemusterte Laterne; beide bleiben vorerst Papier.';

  @override
  String get ideasEidNightStep2 =>
      'Male den Himmel türkis, am hellsten nahe dem Mond.';

  @override
  String get ideasEidNightStep3 => 'Male dunkleres Türkis zu den Rändern hin.';

  @override
  String get ideasEidNightStep4 =>
      'Verblende Violett in die oberen Ecken, solange das Türkis noch feucht ist.';

  @override
  String get ideasEidNightStep5 =>
      'Setze Gold auf die Sichel und den Laternenrahmen; die Scheiben bleiben hell. Dann male Sterne mit weißem Gelstift.';

  @override
  String get ideasHoliColoursTitle => 'Holi';

  @override
  String get ideasHoliColoursSummary =>
      'Wolken aus Farbpulver auf Weiß: weiche Ränder, harte Zentren, vier leuchtende Farben.';

  @override
  String get ideasHoliColoursPractice =>
      'Farbe ohne Kante: Der farblose Blender löst eine Kante ins Papier auf.';

  @override
  String get ideasHoliColoursSubject =>
      'Vier sich überlappende Wolken aus Farbpulver auf weißem Papier.';

  @override
  String get ideasHoliColoursTip =>
      'Lass jede Wolke trocknen, bevor du die nächste aufträgst, sonst werden alle Farben matschig.';

  @override
  String get ideasHoliColoursStep1 =>
      'Kritzle eine lockere Wolke mit der ersten Farbe, in der Mitte dicht.';

  @override
  String get ideasHoliColoursStep2 =>
      'Zieh ihre Ränder mit dem farblosen Blender ins weiße Papier, bis sie verschwinden.';

  @override
  String get ideasHoliColoursStep3 =>
      'Setze eine zweite Wolke, die die erste leicht überlappt; wo sie sich treffen, lass sie sich mischen.';

  @override
  String get ideasHoliColoursStep4 =>
      'Setze eine dritte, kleinere Wolke in eine Lücke.';

  @override
  String get ideasHoliColoursStep5 =>
      'Setze eine vierte Wolke in die letzte Lücke, dann spritz ein paar Punkte jeder Farbe darum.';

  @override
  String get ideasSummerIceCreamTitle => 'Eis';

  @override
  String get ideasSummerIceCreamSummary =>
      'Drei Kugeln verschiedener Sorten auf einer Waffel.';

  @override
  String get ideasSummerIceCreamPractice =>
      'Drei runde Verläufe und ein Grau, das alle schattiert.';

  @override
  String get ideasSummerIceCreamSubject =>
      'Drei gestapelte Kugeln auf einer Waffel mit Gittermuster.';

  @override
  String get ideasSummerIceCreamTip =>
      'Nimm für jede Kugel dasselbe Grau: Das hält drei verschiedene Farben zusammen.';

  @override
  String get ideasSummerIceCreamStep1 =>
      'Zeichne mit dem Bleistift eine Waffel mit Gittermuster und drei gestapelte Kugeln.';

  @override
  String get ideasSummerIceCreamStep2 =>
      'Male die untere Kugel in der ersten Sorte und lass ein Glanzlicht aus Papier frei.';

  @override
  String get ideasSummerIceCreamStep3 =>
      'Male die mittlere Kugel in der zweiten Sorte, ebenfalls mit eigenem Glanzlicht.';

  @override
  String get ideasSummerIceCreamStep4 =>
      'Male die obere Kugel in der dritten Sorte.';

  @override
  String get ideasSummerIceCreamStep5 =>
      'Setze dasselbe helle Grau auf die Unterseite jeder Kugel und dorthin, wo sie sich überlappen.';

  @override
  String get ideasSummerIceCreamStep6 =>
      'Male die Waffel beige, mit den Gitterlinien in einer zweiten Schicht.';

  @override
  String get ideasNewYearFireworksTitle => 'Silvesterfeuerwerk';

  @override
  String get ideasNewYearFireworksSummary =>
      'Drei Feuerwerke über dunklem Himmel, jedes in anderer Farbe.';

  @override
  String get ideasNewYearFireworksPractice =>
      'Helle Farbe über dunkler Füllung, die Linien bleiben Papier.';

  @override
  String get ideasNewYearFireworksSubject =>
      'Drei Feuerwerke mit hellen Linien, die von jedem Zentrum ausstrahlen.';

  @override
  String get ideasNewYearFireworksTip =>
      'Fülle den Himmel um die Linien herum, nicht darüber: Das weiße Papier lässt das Feuerwerk leuchten.';

  @override
  String get ideasNewYearFireworksStep1 =>
      'Zeichne mit dem Bleistift drei Zentren und helle, ausstrahlende Linien von jedem; die Linien bleiben vorerst Papier.';

  @override
  String get ideasNewYearFireworksStep2 =>
      'Fülle den Himmel dunkel und fahre mit der feinen Spitze um die Linien herum (sie dürfen uneben sein).';

  @override
  String get ideasNewYearFireworksStep3 =>
      'Zieh die Linien des ersten Feuerwerks mit der ersten Farbe nach und drück an den Spitzen stärker.';

  @override
  String get ideasNewYearFireworksStep4 =>
      'Zieh die Linien des zweiten Feuerwerks mit der zweiten Farbe nach.';

  @override
  String get ideasNewYearFireworksStep5 =>
      'Zieh die Linien des dritten Feuerwerks mit der dritten Farbe nach.';

  @override
  String get ideasNewYearFireworksStep6 =>
      'Setze weißen Gelstift in die Mitte jedes Feuerwerks und ein paar Funken an die Spitzen.';

  @override
  String get ideasCozyLampTitle => 'Gemütliche Ecke';

  @override
  String get ideasCozyLampSummary =>
      'Ein Sessel unter einer Lampe am Abend: eine warme Lichtinsel und weiche braune Schatten.';

  @override
  String get ideasCozyLampPractice =>
      'Einen beleuchteten Bereich planen und den Rest des Raums ins warme Braun fallen lassen.';

  @override
  String get ideasCozyLampSubject =>
      'Ein Sessel, eine Stehlampe und eine Wand dahinter.';

  @override
  String get ideasCozyLampTip =>
      'Halte das dunkelste Braun aus dem Lichtkreis heraus: Die Lampe erreicht keine Ecke.';

  @override
  String get ideasCozyLampStep1 =>
      'Zeichne mit dem Bleistift Sessel und Lampe und den Lichtkreis, den sie auf Boden und Wand wirft.';

  @override
  String get ideasCozyLampStep2 =>
      'Fülle den Lichtkreis mit dem hellen Gelb und lass ihn mit dem farblosen Blender auslaufen.';

  @override
  String get ideasCozyLampStep3 =>
      'Färbe den restlichen Raum mit dem hellen warmen Beige, flach und gleichmäßig.';

  @override
  String get ideasCozyLampStep4 =>
      'Setze das warme Braun auf den Sessel und auf die Seite des Raums, die von der Lampe abgewandt ist.';

  @override
  String get ideasCozyLampStep5 =>
      'Nutze das dunkle Braun in den Ecken und unter dem Sessel, und halte es aus dem Lichtkreis heraus.';

  @override
  String get ideasFoggyMorningTitle => 'Nebel';

  @override
  String get ideasFoggyMorningSummary =>
      'Bäume, die im Nebel verschwinden: die näheren dunkler, die ferneren heller.';

  @override
  String get ideasFoggyMorningPractice =>
      'Tiefe durch eine helle Lasur über dunklen Formen.';

  @override
  String get ideasFoggyMorningSubject =>
      'Drei Baumreihen an einem Weg, jede weiter hinten.';

  @override
  String get ideasFoggyMorningTip =>
      'Eine helle Lasur über einer dunklen Form ist der einfachste Nebel: Die Tinte darunter bleibt.';

  @override
  String get ideasFoggyMorningStep1 =>
      'Zeichne drei Baumreihen mit Bleistift, jede weiter hinten, und markiere, wo der Boden beginnt.';

  @override
  String get ideasFoggyMorningStep2 =>
      'Färbe die hinterste Reihe nur mit dem hellsten Marker, ohne jedes Detail.';

  @override
  String get ideasFoggyMorningStep3 =>
      'Färbe die mittlere Reihe mit dem Basiston und weiche ihre Unterkante mit dem farblosen Blender in den Boden aus.';

  @override
  String get ideasFoggyMorningStep4 =>
      'Male die vordersten Bäume mit dem dunklen Marker und setze ein paar Äste dazu.';

  @override
  String get ideasFoggyMorningStep5 =>
      'Zieh den hellen Marker als Lasur über alle Reihen, damit der Nebel über der ganzen Szene liegt.';

  @override
  String get ideasRainyWindowTitle => 'Regen auf der Scheibe';

  @override
  String get ideasRainyWindowSummary =>
      'Unscharfe Lichter hinter einer nassen Scheibe, mit Tropfen, die hinunterlaufen.';

  @override
  String get ideasRainyWindowPractice =>
      'Leuchtende Lichter hinter Glas und klare Striche darauf.';

  @override
  String get ideasRainyWindowSubject =>
      'Ein Fenster bei Nacht mit Straßenlaternen draußen und drei Tropfen auf dem Glas.';

  @override
  String get ideasRainyWindowTip =>
      'Die Lichter müssen ganz trocknen, bevor das Blau darübergeht, sonst vermischen sich die Farben.';

  @override
  String get ideasRainyWindowStep1 =>
      'Zeichne den Fensterrahmen und ein paar unscharfe Lichtflecken draußen mit Bleistift und markiere den Weg von drei Tropfen.';

  @override
  String get ideasRainyWindowStep2 =>
      'Färbe die warmen Lichter als weiche Flecken und verblende ihre Ränder mit dem farblosen Blender.';

  @override
  String get ideasRainyWindowStep3 =>
      'Bedecke das ganze Glas mit dem hellen Blau, rund um die Lichter herum.';

  @override
  String get ideasRainyWindowStep4 =>
      'Trage das Basisblau zu den Ecken hin auf und lass die Tropfenwege etwas heller.';

  @override
  String get ideasRainyWindowStep5 =>
      'Färbe den Rahmen dunkel und setze auf die dem Licht abgewandte Seite jedes Tropfens eine dunkle Sichel.';

  @override
  String get ideasRainyWindowStep6 =>
      'Wenn alles trocken ist, setze auf die dem Licht zugewandte Seite jedes Tropfens einen Hauch weißen Gelstift.';

  @override
  String get ideasEerieForestTitle => 'Unheimlicher Wald';

  @override
  String get ideasEerieForestSummary =>
      'Schlanke Bäume in der Dämmerung in kränklichen Grüntönen, dazwischen ein violetter Himmel.';

  @override
  String get ideasEerieForestPractice =>
      'Zwei Farben an der Grenze absichtlich miteinander verschmelzen lassen.';

  @override
  String get ideasEerieForestSubject =>
      'Hohe, schlanke Stämme auf einem niedrigen Horizont in der Dämmerung.';

  @override
  String get ideasEerieForestTip =>
      'Grün und Violett werden an der Grenze grau. Dieses Grau ist die Stimmung, kein Fehler.';

  @override
  String get ideasEerieForestStep1 =>
      'Zeichne hohe, schlanke Stämme und einen niedrigen Horizont mit Bleistift.';

  @override
  String get ideasEerieForestStep2 =>
      'Setze ein blasses Gelbgrün entlang des Horizonts, zwischen den Stämmen.';

  @override
  String get ideasEerieForestStep3 =>
      'Färbe darüber das Violett und verblende es, solange es noch feucht ist, mit dem Grün.';

  @override
  String get ideasEerieForestStep4 =>
      'Färbe das Grün auf den Boden und auf den unteren Teil der Stämme.';

  @override
  String get ideasEerieForestStep5 =>
      'Nutze das dunkelste Grün in ungleichmäßigen Strichen auf den Stämmen und ziehe lange Schatten über den Boden.';

  @override
  String get ideasGoldenHourTitle => 'Goldene Stunde';

  @override
  String get ideasGoldenHourSummary =>
      'Eine weiße Wand und eine Tür am Ende des Nachmittags: orangefarbenes Licht, lange violette Schatten.';

  @override
  String get ideasGoldenHourPractice =>
      'Eine warme Lasur über allem, mit hartkantigen kühlen Schatten darauf.';

  @override
  String get ideasGoldenHourSubject =>
      'Eine Wand mit einer Tür, einer Pflanze und dem langen Schatten, den die Pflanze wirft.';

  @override
  String get ideasGoldenHourTip =>
      'Die Wand ist hier nicht weiß: In diesem Licht ist sie orange. Male sie so.';

  @override
  String get ideasGoldenHourStep1 =>
      'Zeichne eine Wand mit einer Tür und einer Pflanze mit Bleistift und den langen Schatten, den die Pflanze über die Wand wirft.';

  @override
  String get ideasGoldenHourStep2 =>
      'Überziehe die ganze Wand mit dem hellen Orange: Das ist die weiße Wand in diesem Licht.';

  @override
  String get ideasGoldenHourStep3 =>
      'Setze das kräftigere Orange unter den Türsturz und auf die Tür.';

  @override
  String get ideasGoldenHourStep4 =>
      'Trage das Violettgrau im Schatten der Pflanze und in der Türöffnung auf, mit einem klaren Rand.';

  @override
  String get ideasGoldenHourStep5 =>
      'Spare den dunkelsten Marker nur für die Tiefe der Türöffnung auf.';

  @override
  String get ideasStormySeaTitle => 'Stürmische See';

  @override
  String get ideasStormySeaSummary =>
      'Graugrüne Wellen unter einem dunklen Himmel, mit weißem Papier für den Schaum.';

  @override
  String get ideasStormySeaPractice =>
      'Flaches, helles Wasser gegen einen schweren Himmel, mit dem Schaum als Papier.';

  @override
  String get ideasStormySeaSubject =>
      'Ein niedriger Horizont, zwei große Wellen und der Schaum, der auf ihnen bricht.';

  @override
  String get ideasStormySeaTip =>
      'Der Schaum ist Papier, das du nicht berührt hast: Plane, wo er bricht, bevor du das Wasser färbst.';

  @override
  String get ideasStormySeaStep1 =>
      'Zeichne den Horizont niedrig, zwei große Wellen und wo der Schaum bricht. Der Schaum bleibt Papier.';

  @override
  String get ideasStormySeaStep2 =>
      'Bedecke das Wasser mit dem hellen Graugrün, rund um den Schaum herum.';

  @override
  String get ideasStormySeaStep3 =>
      'Setze das dunklere Wasser in die Wellentäler und unter jede Welle.';

  @override
  String get ideasStormySeaStep4 =>
      'Fülle den Himmel mit dem dunklen Marker, oben am dunkelsten, und das tiefste Wasser unter der brechenden Welle.';

  @override
  String get ideasStormySeaStep5 =>
      'Wenn alles trocken ist, setze weißen Gelstift für die Gischt, die von den Wellenkämmen spritzt: nur ein paar Punkte.';

  @override
  String get ideasCandleFlameTitle => 'Bei Kerzenlicht';

  @override
  String get ideasCandleFlameSummary =>
      'Eine Kerze auf einem Tisch in einem dunklen Raum: alles warm, und nichts weit weg von der Flamme ist zu sehen.';

  @override
  String get ideasCandleFlamePractice =>
      'Konzentrische Ringe aus warmen Farben, nass ineinander verblendet.';

  @override
  String get ideasCandleFlameSubject =>
      'Eine Kerze im Leuchter, mit Tisch und Rückwand dahinter.';

  @override
  String get ideasCandleFlameTip =>
      'Sichtbar ist nur, was die Flamme berührt: Der hintere Raum kann fast eine dunkle Fläche sein.';

  @override
  String get ideasCandleFlameStep1 =>
      'Zeichne die Kerze, ihre Flamme und einen Lichtkreis auf dem Tisch mit Bleistift. Der Kern der Flamme bleibt Papier.';

  @override
  String get ideasCandleFlameStep2 =>
      'Färbe den Hof der Flamme und den nächstgelegenen Teil des Tisches mit dem Gelb und verblende es mit dem farblosen Blender nach außen.';

  @override
  String get ideasCandleFlameStep3 =>
      'Setze das warme Orange auf die beleuchtete Seite der Kerze und auf den nächsten Ring des Tisches.';

  @override
  String get ideasCandleFlameStep4 =>
      'Färbe alles außerhalb des Lichtkreises braun.';

  @override
  String get ideasCandleFlameStep5 =>
      'Nutze das dunkelste Braun für den hinteren Raum und die Schattenseite der Kerze, mit einem weichen Rand zum Licht hin.';

  @override
  String get ideasDesertNoonTitle => 'Mittag in der Wüste';

  @override
  String get ideasDesertNoonSummary =>
      'Sand, ein Fels und ein harter Schatten unter einem ausgebleichten Himmel.';

  @override
  String get ideasDesertNoonPractice =>
      'Eine flache, helle Füllung gegen einen harten, dunklen Schatten.';

  @override
  String get ideasDesertNoonSubject =>
      'Ein hoher Horizont, ein einzelner Fels und sein kurzer Schatten direkt darunter.';

  @override
  String get ideasDesertNoonTip =>
      'Lass am Horizont einen Streifen weißes Papier frei: Dieser Streifen lässt den Himmel heiß wirken.';

  @override
  String get ideasDesertNoonStep1 =>
      'Zeichne einen hohen Horizont, einen Fels und seinen kurzen Schatten direkt darunter mit Bleistift.';

  @override
  String get ideasDesertNoonStep2 =>
      'Bedecke den Sand unter dem Horizont mit dem hellen Gelb, in einem sehr leichten Durchgang.';

  @override
  String get ideasDesertNoonStep3 =>
      'Färbe den Himmel mit dem hellen Blau und lass ihn am Horizont heller.';

  @override
  String get ideasDesertNoonStep4 =>
      'Setze das Orange auf die Schattenseite des Felsens und auf die Wellenlinien im Sand.';

  @override
  String get ideasDesertNoonStep5 =>
      'Nutze das Violettblau nur im Schlagschatten des Felsens, mit einem harten Rand.';

  @override
  String get ideasBokehLightsTitle => 'Unscharfe Lichter';

  @override
  String get ideasBokehLightsSummary =>
      'Ein Hintergrund aus weichen, unscharfen Lichtkreisen.';

  @override
  String get ideasBokehLightsPractice =>
      'Einen weichen Kreis mit dem Blender auf einer flachen Fläche machen.';

  @override
  String get ideasBokehLightsSubject =>
      'Ein dunkles Feld mit einem Dutzend unscharfer Lichter in verschiedenen Größen.';

  @override
  String get ideasBokehLightsTip =>
      'Drück den Blender flach auf: Eine schmale Spitze zeichnet eine Linie, keinen Kreis.';

  @override
  String get ideasBokehLightsStep1 =>
      'Fülle die ganze Fläche mit dem Basiston, in flachen Strichen.';

  @override
  String get ideasBokehLightsStep2 =>
      'Dunkle die Ecken ab und verblende die Dunkelheit nach innen, solange die Tinte feucht ist.';

  @override
  String get ideasBokehLightsStep3 =>
      'Lass es trocknen und drück dann die breite Spitze des farblosen Blenders flach auf, in Kreisen verschiedener Größe.';

  @override
  String get ideasBokehLightsStep4 =>
      'Tupfe den hellen Marker in die Mitte einiger Kreise, damit sie leuchten.';

  @override
  String get ideasBokehLightsStep5 =>
      'Setze in zwei oder drei Kreise einen Punkt mit weißem Gelstift, nicht in alle.';

  @override
  String get ideasRetroPosterTitle => 'Retro-Plakat';

  @override
  String get ideasRetroPosterSummary =>
      'Drei flache, leicht staubige Farben und eine dunkle, ganz ohne Verblenden.';

  @override
  String get ideasRetroPosterPractice =>
      'Flache Füllungen und harte Kanten, so wie ein gedrucktes Plakat aussieht.';

  @override
  String get ideasRetroPosterSubject =>
      'Ein Leuchtturm, ein Auto oder eine Flasche, gezeichnet als wenige große flache Formen.';

  @override
  String get ideasRetroPosterTip =>
      'Lass zwischen den Farben einen Hauch weißes Papier frei, als wäre der Druck ein wenig verrutscht.';

  @override
  String get ideasRetroPosterStep1 =>
      'Zeichne mit Bleistift ein einfaches Motiv als große flache Formen: einen Leuchtturm, ein Auto, eine Flasche.';

  @override
  String get ideasRetroPosterStep2 =>
      'Fülle die größten Formen flach, in einem Zug.';

  @override
  String get ideasRetroPosterStep3 =>
      'Fülle die nächsten Formen und lass zwischen den Farben einen Hauch Papier frei.';

  @override
  String get ideasRetroPosterStep4 =>
      'Nimm die dritte Farbe für die kleinsten Formen.';

  @override
  String get ideasRetroPosterStep5 =>
      'Zeichne die Schatten als eigene flache Formen mit dem dunklen Marker.';

  @override
  String get ideasRetroPosterStep6 =>
      'Zieh ein paar Linien mit dem Liner dorthin, wo das gedruckte Plakat sie hätte.';

  @override
  String get ideasFreshCitrusTitle => 'Frisch und spritzig';

  @override
  String get ideasFreshCitrusSummary =>
      'Eine Zitrone, eine Limette und ein Glas Wasser, mit viel weißem Papier und höchstens zwei Schichten.';

  @override
  String get ideasFreshCitrusPractice =>
      'Leuchtende Farbe auf Weiß, rechtzeitig aufhören.';

  @override
  String get ideasFreshCitrusSubject =>
      'Eine Zitrone, eine Limette und ein Glas Wasser auf einem Tisch.';

  @override
  String get ideasFreshCitrusTip =>
      'Hör nach zwei Schichten auf: Eine dritte nimmt der Farbe die Frische.';

  @override
  String get ideasFreshCitrusStep1 =>
      'Zeichne die Früchte und das Glas mit Bleistift und halte die Komposition luftig.';

  @override
  String get ideasFreshCitrusStep2 =>
      'Färbe die Zitrone mit dem Gelb in einem Zug und lass ein weißes Glanzlicht frei.';

  @override
  String get ideasFreshCitrusStep3 =>
      'Färbe die Limette mit dem Grün, ebenfalls in einem Zug.';

  @override
  String get ideasFreshCitrusStep4 =>
      'Setze das dunklere Gelb auf die Schattenseite der Zitrone und eine zweite Schicht Grün auf die Schattenseite der Limette.';

  @override
  String get ideasFreshCitrusStep5 =>
      'Nimm das helle Blau für das Wasser im Glas und einen kleinen Schatten unter jede Frucht.';

  @override
  String get ideasTropicalNoonTitle => 'Tropischer Mittag';

  @override
  String get ideasTropicalNoonSummary =>
      'Große Blätter, eine heißrosa Blüte und ein Stück blauer Himmel, kräftig und mit harten Kanten.';

  @override
  String get ideasTropicalNoonPractice =>
      'Kräftige Flächenfarbe mit klaren Überlappungen, ganz ohne Verblenden.';

  @override
  String get ideasTropicalNoonSubject =>
      'Zwei oder drei große sich überlappende Blätter, eine Blüte und der Himmel in den Lücken.';

  @override
  String get ideasTropicalNoonTip =>
      'Lass den Rand jedes Blattes scharf: Die Überlappung macht hier die Tiefe.';

  @override
  String get ideasTropicalNoonStep1 =>
      'Zeichne zwei oder drei große sich überlappende Blätter, eine Blüte und den Himmel in den Lücken mit Bleistift.';

  @override
  String get ideasTropicalNoonStep2 =>
      'Färbe die Blätter mit dem hellen Grün und folge dabei den Blattadern.';

  @override
  String get ideasTropicalNoonStep3 =>
      'Setze das mittlere Grün auf die Blätter dahinter und unter den anderen, mit harten Kanten, wo sie sich überlappen.';

  @override
  String get ideasTropicalNoonStep4 =>
      'Färbe die Blüte in Heißrosa, mit zwei Schichten.';

  @override
  String get ideasTropicalNoonStep5 =>
      'Färbe den blauen Himmel in den Lücken, bis genau an den Rand der Blätter.';

  @override
  String get ideasGreenhouseLightTitle => 'Im Gewächshaus';

  @override
  String get ideasGreenhouseLightSummary =>
      'Pflanzen hinter Glas in feuchtem grünem Licht, mit blassgrauen Scheiben.';

  @override
  String get ideasGreenhouseLightPractice =>
      'Eine helle Lasur über einer Szene, wie Glas sie verschleiert.';

  @override
  String get ideasGreenhouseLightSubject =>
      'Eine Glaswand mit ihren Sprossen und Töpfen mit Pflanzen dahinter.';

  @override
  String get ideasGreenhouseLightTip =>
      'Die grüne Lasur kommt zuletzt: Sie ist das feuchte Licht des Ortes, nicht die Farbe der Pflanzen.';

  @override
  String get ideasGreenhouseLightStep1 =>
      'Zeichne mit dem Bleistift eine Glaswand mit ihren Sprossen und dahinter Töpfe mit Pflanzen.';

  @override
  String get ideasGreenhouseLightStep2 =>
      'Färbe die Pflanzen mit dem Basisgrün, weicher, je weiter sie hinter dem Glas stehen.';

  @override
  String get ideasGreenhouseLightStep3 =>
      'Nimm das dunkle Grün nur für die vordersten Blätter.';

  @override
  String get ideasGreenhouseLightStep4 =>
      'Nimm das helle Grau für die Sprossen und die Reflexstreifen auf den Scheiben.';

  @override
  String get ideasGreenhouseLightStep5 =>
      'Wenn alles trocken ist, leg das blasse Grün als Lasur über die ganze Glasfläche: Das Licht drinnen ist grün.';

  @override
  String get ideasDustyAtticTitle => 'Staubiger Dachboden';

  @override
  String get ideasDustyAtticSummary =>
      'Warme Grautöne, ein alter Koffer und ein Lichtstrahl mit Staub darin.';

  @override
  String get ideasDustyAtticPractice =>
      'Ein grauer Raum mit einer hellen Stelle, die unberührt bleibt.';

  @override
  String get ideasDustyAtticSubject =>
      'Ein kleines Fenster hoch oben, der Lichtstrahl, den es wirft, und ein alter Koffer darin.';

  @override
  String get ideasDustyAtticTip =>
      'Lass den Lichtstrahl das Hellste im Bild sein: Er ist das einzige weiße Papier, das übrig bleibt.';

  @override
  String get ideasDustyAtticStep1 =>
      'Zeichne mit Bleistift ein kleines Fenster hoch oben, den Lichtstrahl, den es wirft, und einen Koffer darin.';

  @override
  String get ideasDustyAtticStep2 =>
      'Bedecke alles mit dem hellsten warmen Grau, außer dem Inneren des Lichtstrahls.';

  @override
  String get ideasDustyAtticStep3 =>
      'Setze das mittlere warme Grau auf die Wände weg vom Fenster und auf die Seiten des Koffers.';

  @override
  String get ideasDustyAtticStep4 =>
      'Nutze das dunkelste Grau in den Ecken und unter dem Koffer.';

  @override
  String get ideasDustyAtticStep5 =>
      'Lege eine zarte, blassgelbe Lasur in den Lichtstrahl.';

  @override
  String get ideasDustyAtticStep6 =>
      'Wenn alles trocken ist, setze ein paar Staubkörnchen mit weißem Gelstift in den Lichtstrahl.';

  @override
  String get ideasColourGreyBlackTitle => 'Farbe, Grau und Schwarz';

  @override
  String get ideasColourGreyBlackSummary =>
      'Nur drei Marker: eine Farbe, ein Grau und ein sehr dunkler.';

  @override
  String get ideasColourGreyBlackPractice =>
      'Das Licht setzen mit so wenigen Markern wie möglich.';

  @override
  String get ideasColourGreyBlackSubject =>
      'Ein Fahrrad, ein Stiefel oder eine Kanne mit einer klaren Farbe.';

  @override
  String get ideasColourGreyBlackTip =>
      'Mit drei Spitzen gibt es nichts zu entscheiden, außer wo das Licht hinkommt. Plane zuerst das Licht.';

  @override
  String get ideasColourGreyBlackStep1 =>
      'Wähle ein Motiv mit einer Hauptfarbe und markiere mit Bleistift, woher das Licht kommt.';

  @override
  String get ideasColourGreyBlackStep2 =>
      'Färbe das ganze Motiv mit der Farbe und gib dort zwei Schichten, wo es sich vom Licht abwendet.';

  @override
  String get ideasColourGreyBlackStep3 =>
      'Nimm das Grau für den Schlagschatten und für alles, was nicht das Motiv ist.';

  @override
  String get ideasColourGreyBlackStep4 =>
      'Spare den dunklen Marker für die Kontaktlinien und die tiefsten Ecken auf.';

  @override
  String get ideasColourGreyBlackStep5 =>
      'Geh ein Stück zurück: Die Zeichnung liest sich mit nur drei Werten, und das Grau hält sie zusammen.';

  @override
  String get ideasAnalogousTrioTitle => 'Drei Nachbarn';

  @override
  String get ideasAnalogousTrioSummary =>
      'Drei Farben, die auf dem Farbkreis nebeneinander liegen, und nichts von der anderen Seite.';

  @override
  String get ideasAnalogousTrioPractice =>
      'Ein Schema aus benachbarten Farbtönen bauen.';

  @override
  String get ideasAnalogousTrioSubject =>
      'Eine Sonnenblume, das Meer oder ein Feld in einer einzigen Farbe.';

  @override
  String get ideasAnalogousTrioTip =>
      'Benachbarte Farben mischen sich nass, ohne grau zu werden. Halte sie nass und lass sie sich mischen.';

  @override
  String get ideasAnalogousTrioStep1 =>
      'Wähle ein Motiv, das von Natur aus eine Farbe hat, wie eine Sonnenblume oder das Meer, und zeichne es.';

  @override
  String get ideasAnalogousTrioStep2 =>
      'Bedecke den größten Teil des Motivs mit der mittleren der drei Farben.';

  @override
  String get ideasAnalogousTrioStep3 =>
      'Setze den Nachbarn auf die beleuchtete Seite und verblende ihn nass in die mittlere Farbe.';

  @override
  String get ideasAnalogousTrioStep4 =>
      'Nimm den anderen Nachbarn in den Schatten, fern vom Licht.';

  @override
  String get ideasAnalogousTrioStep5 =>
      'Setze den dunklen Ton der mittleren Farbe nur in die tiefsten Stellen und lass alles andere in den drei Farben.';

  @override
  String get ideasTriadTitle => 'Eine Triade';

  @override
  String get ideasTriadSummary =>
      'Drei gleichmäßig verteilte Farben auf dem Farbkreis: eine führt, zwei stützen.';

  @override
  String get ideasTriadPractice =>
      'Ein Dreifarbschema einsetzen, in dem eine Farbe das Sagen hat.';

  @override
  String get ideasTriadSubject =>
      'Ein Plakat, ein Buchcover oder eine große Blume mit kleinen Details.';

  @override
  String get ideasTriadTip =>
      'Halte die drei Farben auf dem Papier auseinander. Ein gemeinsames Grau über allen dreien bindet das Schema zusammen.';

  @override
  String get ideasTriadStep1 =>
      'Entscheide, welche der drei Farben führt: Sie bekommt den größten Teil des Papiers.';

  @override
  String get ideasTriadStep2 =>
      'Färbe die Hauptflächen mit der führenden Farbe.';

  @override
  String get ideasTriadStep3 =>
      'Nimm die zweite Farbe auf ungefähr ein Viertel der Zeichnung und lass sie die erste nie nass berühren.';

  @override
  String get ideasTriadStep4 =>
      'Nimm die dritte Farbe nur an ein paar kleinen Stellen.';

  @override
  String get ideasTriadStep5 =>
      'Schattiere alle drei Farben mit demselben Grau, damit sie zusammengehören.';

  @override
  String get ideasSplitComplementTitle => 'Geteilt komplementär';

  @override
  String get ideasSplitComplementSummary =>
      'Eine Farbfamilie und die beiden Farben neben ihrer Gegenfarbe.';

  @override
  String get ideasSplitComplementPractice =>
      'Eine Hauptfamilie mit zwei Farben nahe ihrer Gegenfarbe ausbalancieren.';

  @override
  String get ideasSplitComplementSubject =>
      'Eine Vase mit zwei Blumen oder eine Tasse mit zwei kleinen Dingen daneben.';

  @override
  String get ideasSplitComplementTip =>
      'Eine fast gegenüberliegende Farbe wirkt mal grell, mal harmonisch, je nachdem, wie viel du davon einsetzt.';

  @override
  String get ideasSplitComplementStep1 =>
      'Zeichne ein Motiv mit einer großen Fläche und zwei kleinen, zum Beispiel eine Vase mit zwei Blumen.';

  @override
  String get ideasSplitComplementStep2 =>
      'Bedecke die große Fläche mit dem hellen Ton der Hauptfamilie.';

  @override
  String get ideasSplitComplementStep3 =>
      'Setze seinen Schatten dorthin, wo das Licht nicht hinkommt.';

  @override
  String get ideasSplitComplementStep4 =>
      'Nimm eine der beiden Gegenfarben für die erste kleine Fläche.';

  @override
  String get ideasSplitComplementStep5 =>
      'Nimm die andere Gegenfarbe für die zweite kleine Fläche und halte beide getrennt.';

  @override
  String get ideasTwoGrayTemperaturesTitle => 'Warmes und kühles Grau';

  @override
  String get ideasTwoGrayTemperaturesSummary =>
      'Färbe denselben Stein zweimal, einmal mit warmen und einmal mit kühlen Grautönen.';

  @override
  String get ideasTwoGrayTemperaturesPractice =>
      'Warmes Grau von kaltem Grau mit dem Auge unterscheiden.';

  @override
  String get ideasTwoGrayTemperaturesSubject =>
      'Derselbe Stein oder ein gefaltetes Tuch, zweimal nebeneinander gezeichnet.';

  @override
  String get ideasTwoGrayTemperaturesTip =>
      'Die meisten Marken verkaufen warme, kühle und neutrale Grautöne als getrennte Familien. Wähle für jede Hälfte eine Familie.';

  @override
  String get ideasTwoGrayTemperaturesStep1 =>
      'Zeichne denselben Stein zweimal mit dem Bleistift nebeneinander und markiere bei jedem das Licht.';

  @override
  String get ideasTwoGrayTemperaturesStep2 =>
      'Erster Stein: das helle warme Grau überall.';

  @override
  String get ideasTwoGrayTemperaturesStep3 =>
      'Setze das dunklere warme Grau auf die Schattenseite und dunkle den Kontakt zum Boden ab.';

  @override
  String get ideasTwoGrayTemperaturesStep4 =>
      'Zweiter Stein: das helle kühle Grau überall.';

  @override
  String get ideasTwoGrayTemperaturesStep5 =>
      'Setze das dunklere kühle Grau auf dieselbe Weise und vergleiche: Ein Stein liegt in der Sonne, der andere im Schatten.';

  @override
  String get ideasGrayPlusAccentTitle => 'Grau mit einem Akzent';

  @override
  String get ideasGrayPlusAccentSummary =>
      'Alles in Grau, bis auf eine Kleinigkeit in Farbe.';

  @override
  String get ideasGrayPlusAccentPractice =>
      'Eine Farbe die ganze Zeichnung tragen lassen.';

  @override
  String get ideasGrayPlusAccentSubject =>
      'Eine Straße mit einer roten Tür oder ein gelber Schirm in einer grauen Stadt.';

  @override
  String get ideasGrayPlusAccentTip =>
      'Der Akzent soll so kräftig wie möglich sein: zwei Schichten desselben Markers.';

  @override
  String get ideasGrayPlusAccentStep1 =>
      'Zeichne eine Szene mit einem Objekt, auf dem der Blick landen soll, zum Beispiel eine rote Tür in einer Straße.';

  @override
  String get ideasGrayPlusAccentStep2 =>
      'Bedecke alles außer diesem Objekt mit dem hellen Grau.';

  @override
  String get ideasGrayPlusAccentStep3 =>
      'Setze das mittlere Grau in die Schatten, als wäre die Szene ein Foto.';

  @override
  String get ideasGrayPlusAccentStep4 =>
      'Nimm das dunkelste Grau für die Fenster, unter den Dachvorsprüngen und für die Kontaktlinien.';

  @override
  String get ideasGrayPlusAccentStep5 =>
      'Färbe nur das Objekt, mit zwei Schichten, damit der Akzent so kräftig wie möglich wird.';

  @override
  String get ideasEarthTonesTitle => 'Erdtöne';

  @override
  String get ideasEarthTonesSummary =>
      'Braun, Ocker und ein Olivgrün, nichts Grelles.';

  @override
  String get ideasEarthTonesPractice =>
      'Gedämpfte Farben übereinanderlegen, ohne dass sie stumpf werden.';

  @override
  String get ideasEarthTonesSubject =>
      'Brot, ein Korb oder ein gepflügtes Feld.';

  @override
  String get ideasEarthTonesTip =>
      'Gedämpfte Farben lassen sich gut übereinanderlegen, weil das Papier sie von unten weiter aufhellt.';

  @override
  String get ideasEarthTonesStep1 =>
      'Zeichne etwas, das vom Land kommt, wie Brot, einen Korb oder ein gepflügtes Feld.';

  @override
  String get ideasEarthTonesStep2 =>
      'Trage das helle Ocker überall als erste Schicht auf.';

  @override
  String get ideasEarthTonesStep3 =>
      'Setze das Braun dorthin, wo die Form sich vom Licht abwendet.';

  @override
  String get ideasEarthTonesStep4 =>
      'Gib das Olivgrün auf alles Grüne und lass das Ocker darunter es dämpfen.';

  @override
  String get ideasEarthTonesStep5 =>
      'Reserviere das dunkelste Braun nur für die tiefsten Stellen.';

  @override
  String get ideasJewelTonesTitle => 'Juwelentöne';

  @override
  String get ideasJewelTonesSummary =>
      'Tiefe, gesättigte Farben mit goldenem Akzent, wie in einem Samtetui.';

  @override
  String get ideasJewelTonesPractice =>
      'Dunkle, gesättigte Farben malen, die ihren Glanz behalten.';

  @override
  String get ideasJewelTonesSubject =>
      'Ein paar Edelsteine oder Flaschen mit je einem geplanten Glanzlicht.';

  @override
  String get ideasJewelTonesTip =>
      'Dunkle gesättigte Tinte bleibt auf Markerpapier glänzend. Ein Punkt mit weißem Gelstift darüber gibt die Glasoptik.';

  @override
  String get ideasJewelTonesStep1 =>
      'Zeichne ein paar einfache Edelsteine oder Flaschen und plane für jeden ein Glanzlicht.';

  @override
  String get ideasJewelTonesStep2 =>
      'Bedecke die größte Form mit dem tiefen Blaugrün, in zwei Schichten.';

  @override
  String get ideasJewelTonesStep3 =>
      'Nimm das tiefe Violett für die nächste Form.';

  @override
  String get ideasJewelTonesStep4 => 'Nimm das tiefe Rot für die kleinste.';

  @override
  String get ideasJewelTonesStep5 =>
      'Setze das Goldgelb auf die Fassungen oder die Kappen und dann einen harten Punkt mit weißem Gelstift auf jedes Glanzlicht.';

  @override
  String get ideasLowKeyTitle => 'Nur dunkle Marker';

  @override
  String get ideasLowKeySummary =>
      'Zeichne mit Markern, die dunkler sind als Mittelgrau, und lass ein paar Papierstellen das ganze Licht tragen.';

  @override
  String get ideasLowKeyPractice =>
      'Ein dunkles Bild malen und das Licht absichtlich weglassen.';

  @override
  String get ideasLowKeySubject =>
      'Eine Katze mit leuchtenden Augen, eine Lampe in einem dunklen Zimmer oder ein Profil.';

  @override
  String get ideasLowKeyTip =>
      'Dunkle Alkoholtinte deckt in einem Durchgang gleichmäßig, so bleiben die weißen Formen sauber.';

  @override
  String get ideasLowKeyStep1 =>
      'Plane die Zeichnung als ein paar Formen, die weiß auf dunklem Grund bleiben: Augen einer Katze, eine Lampe, ein Profil.';

  @override
  String get ideasLowKeyStep2 =>
      'Bedecke alles außer den weißen Formen mit dem am wenigsten dunklen Marker.';

  @override
  String get ideasLowKeyStep3 =>
      'Nimm den mittleren Marker für die großen Schatten.';

  @override
  String get ideasLowKeyStep4 =>
      'Setze den dunkelsten Marker auf die Ränder der hellen Formen, damit sie durch Kontrast leuchten.';

  @override
  String get ideasLowKeyStep5 =>
      'Setz weißen Gelstift nur auf einen oder zwei Punkte, mehr nicht.';

  @override
  String get ideasComplementGradientTitle => 'Durch die Mitte';

  @override
  String get ideasComplementGradientSummary =>
      'Verblende zwei Gegenfarben ineinander und sieh das Grau, das entsteht, wo sie sich treffen.';

  @override
  String get ideasComplementGradientPractice =>
      'Zwei Farben auf dem Papier mischen und das Ergebnis lesen.';

  @override
  String get ideasComplementGradientSubject =>
      'Ein langer Papierstreifen, in dem sich die beiden Farben in der Mitte treffen.';

  @override
  String get ideasComplementGradientTip =>
      'Nasse Gegenfarben mischen sich sofort auf dem Papier. Halte beide feucht und lass sie sich in der Mitte treffen.';

  @override
  String get ideasComplementGradientStep1 =>
      'Klebe einen langen Streifen Papier fest.';

  @override
  String get ideasComplementGradientStep2 =>
      'Fülle das linke Drittel und lass die Farbe zur Mitte hin auslaufen.';

  @override
  String get ideasComplementGradientStep3 =>
      'Fülle das rechte Drittel und lass es in die Mitte auslaufen, solange die erste Farbe noch feucht ist.';

  @override
  String get ideasComplementGradientStep4 =>
      'Vergleiche die matschige Mitte mit einem Strich deines grauen Markers daneben.';

  @override
  String get ideasComplementGradientStep5 =>
      'Mach den Streifen noch einmal: Leg zuerst das Grau in die Mitte und verblende die beiden Farben hinein, ein sauberer Weg hindurch.';

  @override
  String get ideasWarmLightCoolShadowTitle => 'Licht warm, Schatten kühl';

  @override
  String get ideasWarmLightCoolShadowSummary =>
      'Ein Objekt: die beleuchtete Seite in warmen, die Schattenseite in kühlen Farben.';

  @override
  String get ideasWarmLightCoolShadowPractice =>
      'Warme und kühle Lasuren über einer Grundfarbe.';

  @override
  String get ideasWarmLightCoolShadowSubject =>
      'Eine runde Frucht, ein Ei oder ein Ball.';

  @override
  String get ideasWarmLightCoolShadowTip =>
      'Lass zwischen Warm und Kühl einen schmalen Streifen reiner Grundfarbe: So dreht sich die Form weiter.';

  @override
  String get ideasWarmLightCoolShadowStep1 =>
      'Zeichne ein rundes Objekt und markiere, woher das Licht kommt.';

  @override
  String get ideasWarmLightCoolShadowStep2 =>
      'Bedecke das ganze Objekt mit seiner eigenen Farbe.';

  @override
  String get ideasWarmLightCoolShadowStep3 =>
      'Lege die warme Farbe als Lasur über die beleuchtete Hälfte und verblende sie nass in die Grundfarbe.';

  @override
  String get ideasWarmLightCoolShadowStep4 =>
      'Lege die kühle Farbe als Lasur über die Schattenhälfte und lass einen schmalen Streifen reiner Grundfarbe dazwischen.';

  @override
  String get ideasWarmLightCoolShadowStep5 =>
      'Spare den dunkelsten Marker nur für den Kontakt zum Boden auf.';

  @override
  String get ideasVividAndMutedTitle => 'Leuchtend und gedämpft';

  @override
  String get ideasVividAndMutedSummary =>
      'Färbe dieselbe Blume mit einem leuchtenden Paar und dann mit einem gedämpften Paar desselben Farbtons.';

  @override
  String get ideasVividAndMutedPractice =>
      'Eine leuchtende Farbe von ihrer gedämpften Version unterscheiden.';

  @override
  String get ideasVividAndMutedSubject =>
      'Dieselbe Blume zweimal gezeichnet, nebeneinander.';

  @override
  String get ideasVividAndMutedTip =>
      'Die meisten Sortimente haben eine leuchtende und eine gedämpfte Version jedes Farbtons. Die Wahl zwischen beiden ist die ganze Übung.';

  @override
  String get ideasVividAndMutedStep1 =>
      'Zeichne mit dem Bleistift dieselbe Blume zweimal nebeneinander.';

  @override
  String get ideasVividAndMutedStep2 =>
      'Erste Blume: Nimm den leuchtenden hellen Ton.';

  @override
  String get ideasVividAndMutedStep3 =>
      'Setze den leuchtenden Schatten desselben Farbtons dazu.';

  @override
  String get ideasVividAndMutedStep4 =>
      'Zweite Blume: Nimm den gedämpften hellen Ton desselben Farbtons.';

  @override
  String get ideasVividAndMutedStep5 =>
      'Setze ihren gedämpften Schatten dazu und entscheide dann, welche Blume in den Vordergrund eines Bildes passt und welche in den Hintergrund.';

  @override
  String get ideasOneMarkerBlenderTitle => 'Ein Marker und der Blender';

  @override
  String get ideasOneMarkerBlenderSummary =>
      'Vier Werte aus einem dunklen Marker, indem du ihn mit dem farblosen Blender verdünnst.';

  @override
  String get ideasOneMarkerBlenderPractice =>
      'Tinte verdünnen, um hellere Werte zu bekommen, ohne einen zweiten Marker.';

  @override
  String get ideasOneMarkerBlenderSubject =>
      'Vier kleine Papierquadrate, mit Malerkrepp nebeneinander geklebt.';

  @override
  String get ideasOneMarkerBlenderTip =>
      'Der Blender ist reines Lösungsmittel: Er macht aus einem einzigen dunklen Marker eine eigene helle Familie.';

  @override
  String get ideasOneMarkerBlenderStep1 =>
      'Klebe vier kleine Papierquadrate nebeneinander fest.';

  @override
  String get ideasOneMarkerBlenderStep2 =>
      'Fülle das erste Quadrat mit dem Marker in voller Stärke.';

  @override
  String get ideasOneMarkerBlenderStep3 =>
      'Zweites Quadrat: ein Strich Marker, dann der farblose Blender darüber, solange es nass ist.';

  @override
  String get ideasOneMarkerBlenderStep4 =>
      'Drittes Quadrat: erst der Blender, dann der Marker in den nassen Blender. Viertes: Berühre mit dem Marker die Spitze des Blenders und male nur mit dem Blender.';

  @override
  String get ideasOneMarkerBlenderStep5 =>
      'Leg sie nebeneinander: eine vierstufige Treppe aus einem einzigen Marker.';

  @override
  String get ideasColourWheelTitle => 'Dein Farbkreis';

  @override
  String get ideasColourWheelSummary =>
      'Lege zwölf deiner Marker als Kreis und finde die Lücken in deiner Sammlung.';

  @override
  String get ideasColourWheelPractice =>
      'Einen Farbkreis mit den Markern lesen, die du hast.';

  @override
  String get ideasColourWheelSubject =>
      'Ein Kreis von etwa zehn Zentimetern Durchmesser, in zwölf Sektoren geteilt.';

  @override
  String get ideasColourWheelTip =>
      'Ein Marker-Farbkreis ist auf einer Seite Einkaufsliste und Mischführer zugleich.';

  @override
  String get ideasColourWheelStep1 =>
      'Zeichne mit einer Tasse einen Kreis nach und teile ihn in zwölf Sektoren.';

  @override
  String get ideasColourWheelStep2 =>
      'Wähle den Marker, der dem reinen Gelb am nächsten kommt, dann den für Rot und dann den für Blau, und fülle ihre Sektoren im Abstand von vier.';

  @override
  String get ideasColourWheelStep3 =>
      'Fülle die Sektoren dazwischen mit den nächsten Markern, die du hast: Orange, Grün, Violett, dann die sechs Zwischentöne.';

  @override
  String get ideasColourWheelStep4 =>
      'Schreibe jeden Code unter seinen Sektor. Ein leerer oder zweifelhafter Sektor ist ein Marker, den du vielleicht als Nächstes willst.';

  @override
  String get ideasDeepSkinTitle => 'Tiefe Hauttöne';

  @override
  String get ideasDeepSkinSummary =>
      'Färbe ein Gesicht in tiefen Hauttönen, mit warmem Licht und einer rötlichen Wangenröte.';

  @override
  String get ideasDeepSkinPractice =>
      'Tiefe Haut mit einer langen Helligkeitsreihe in einem Ton schattieren.';

  @override
  String get ideasDeepSkinSubject =>
      'Ein Gesicht im Dreiviertelprofil, von vorn beleuchtet.';

  @override
  String get ideasDeepSkinTip =>
      'Tiefe Haut braucht eine lange Helligkeitsreihe in einem Ton, und dafür sind Markerfamilien gebaut.';

  @override
  String get ideasDeepSkinStep1 =>
      'Zeichne mit Bleistift ein Gesicht und markiere Stirn, Nase und Wangenknochen als die beleuchteten Ebenen.';

  @override
  String get ideasDeepSkinStep2 =>
      'Bedecke das ganze Gesicht mit dem hellsten Braun.';

  @override
  String get ideasDeepSkinStep3 =>
      'Gib, solange die erste Schicht noch feucht ist, das Rotbraun auf die Wangen und die Lippen.';

  @override
  String get ideasDeepSkinStep4 =>
      'Setze das mittlere Braun überall außer auf die beleuchteten Ebenen.';

  @override
  String get ideasDeepSkinStep5 =>
      'Nimm den dunkelsten Marker unter den Brauen, unter der Nase, unter der Unterlippe und am Kinn, und lass die beleuchteten Ebenen nur mit der ersten Schicht.';

  @override
  String get ideasBlackObjectTitle => 'Schwarz ohne Schwarz';

  @override
  String get ideasBlackObjectSummary =>
      'Färbe eine schwarze Katze oder einen schwarzen Stiefel mit dunklen Blautönen und Violett und spare den schwarzen Marker für den Schluss auf.';

  @override
  String get ideasBlackObjectPractice =>
      'Ein dunkles Ding aus dunklen Farben bauen statt aus Schwarz.';

  @override
  String get ideasBlackObjectSubject =>
      'Eine schwarze Katze, ein Stiefel oder ein glänzender Wasserkocher.';

  @override
  String get ideasBlackObjectTip =>
      'Ein flacher schwarzer Marker nimmt dem Objekt die Form. Übereinandergelegte dunkle Farben behalten sie.';

  @override
  String get ideasBlackObjectStep1 =>
      'Zeichne mit Bleistift das Objekt und die Form seiner Spiegelungen: Schwarze Dinge spiegeln Himmel und Raum.';

  @override
  String get ideasBlackObjectStep2 =>
      'Nimm das helle kühle Graublau für die Spiegelungen und die oberen Flächen.';

  @override
  String get ideasBlackObjectStep3 =>
      'Bedecke den größten Teil des Objekts mit dem dunklen Blau.';

  @override
  String get ideasBlackObjectStep4 =>
      'Nimm das dunkle Violett für die Unterseite.';

  @override
  String get ideasBlackObjectStep5 =>
      'Spare den dunkelsten Marker für die tiefsten Falten auf und setz einen Glanzpunkt mit weißem Gelstift, wenn die Oberfläche glänzt.';

  @override
  String get ideasWhiteObjectTitle => 'Weiß ohne Weiß';

  @override
  String get ideasWhiteObjectSummary =>
      'Eine weiße Tasse oder ein weißes Ei mit hellen Grautönen, einem getönten Schatten und viel unberührtem Papier.';

  @override
  String get ideasWhiteObjectPractice =>
      'Ein weißes Objekt malen, ohne das Papier zuzudecken.';

  @override
  String get ideasWhiteObjectSubject =>
      'Eine weiße Tasse, ein Ei oder eine gefaltete Serviette.';

  @override
  String get ideasWhiteObjectTip =>
      'Ein weißes Objekt ist hauptsächlich Papier. Die Marker belohnen es, wenn du es in Ruhe lässt.';

  @override
  String get ideasWhiteObjectStep1 =>
      'Zeichne mit dem Bleistift das Objekt und markiere die beleuchtete Seite: Sie bleibt Papier.';

  @override
  String get ideasWhiteObjectStep2 =>
      'Nimm den sehr hellen getönten Marker nur auf der Schattenseite.';

  @override
  String get ideasWhiteObjectStep3 =>
      'Setze das helle Grau hinein, zum dunkelsten Teil hin.';

  @override
  String get ideasWhiteObjectStep4 =>
      'Nimm das etwas dunklere kühle Grau nur an der Kante, die am weitesten vom Licht entfernt ist, und wo das Objekt den Tisch berührt.';

  @override
  String get ideasWhiteObjectStep5 =>
      'Füge an der Unterseite des Objekts einen Hauch der Tischfarbe hinzu, als Spiegelung.';

  @override
  String get ideasFeatheredEdgeTitle => 'Weicher Rand';

  @override
  String get ideasFeatheredEdgeSummary =>
      'Lass eine Seite einer Form ins weiße Papier auslaufen und die andere Kante hart bleiben.';

  @override
  String get ideasFeatheredEdgePractice =>
      'Ein weicher Rand neben einem harten: der einfachste Weg, einer Form Licht zu geben.';

  @override
  String get ideasFeatheredEdgeSubject =>
      'Ein Blatt, ein Blütenblatt oder eine Stofffalte.';

  @override
  String get ideasFeatheredEdgeTip =>
      'Heb die Spitze beim Ziehen an: Die Tinte läuft im Strich von selbst aus.';

  @override
  String get ideasFeatheredEdgeStep1 =>
      'Zeichne mit dem Bleistift ein Blatt und entscheide, welche Kante im Licht liegt.';

  @override
  String get ideasFeatheredEdgeStep2 =>
      'Färbe die dunkle Kante mit der Grundfarbe in kurzen Strichen, die alle zur Lichtseite zeigen.';

  @override
  String get ideasFeatheredEdgeStep3 =>
      'Zieh den hellen Marker von der Mitte nach außen über die Enden dieser Striche und heb die Spitze dabei an, damit jeder Strich ausläuft.';

  @override
  String get ideasFeatheredEdgeStep4 =>
      'Geh noch mal über die Naht, immer vom Farbigen ins Weiße.';

  @override
  String get ideasFeatheredEdgeStep5 =>
      'Vergleiche die beiden Kanten: eine weich, eine hart. Dieser Kontrast lässt die Form lesen.';

  @override
  String get ideasTipToTipTitle => 'Spitze an Spitze';

  @override
  String get ideasTipToTipSummary =>
      'Lade eine dunkle Farbe auf die Spitze eines hellen Markers und ziehe einen Verlauf in einem Zug.';

  @override
  String get ideasTipToTipPractice =>
      'Tinte von einem Marker zum anderen borgen für einen schnellen Verlauf.';

  @override
  String get ideasTipToTipSubject => 'Ein Papierstreifen von zwei Fingerbreit.';

  @override
  String get ideasTipToTipTip =>
      'Halte den dunklen Marker still: Die helle Spitze nimmt die Tinte nur von der Spitze auf.';

  @override
  String get ideasTipToTipStep1 =>
      'Klebe mit Malerkrepp einen Streifen von etwa zwei Fingerbreit auf.';

  @override
  String get ideasTipToTipStep2 =>
      'Halte den dunklen Marker still und leg die Spitze des hellen Markers ein paar Sekunden darauf.';

  @override
  String get ideasTipToTipStep3 =>
      'Fang mit der geladenen Spitze unten auf dem Streifen an: Die ersten Striche sind dunkel, dann kommt die eigene Farbe des Markers zurück.';

  @override
  String get ideasTipToTipStep4 =>
      'Kratz die Spitze auf einem Schmierblatt ab, bis sie wieder sauber ist: Der helle Marker ist nicht verdorben.';

  @override
  String get ideasTipToTipStep5 =>
      'Wiederhole es auf einem zweiten Streifen und lade die Spitze länger: Der dunkle Teil reicht weiter.';

  @override
  String get ideasBlenderPatternTitle => 'Muster mit dem Blender';

  @override
  String get ideasBlenderPatternSummary =>
      'Heb Punkte und Linien aus einer Fläche mit dem farblosen Blender.';

  @override
  String get ideasBlenderPatternPractice =>
      'Tinte bewegen statt löschen: Punkte, Linien und Muster.';

  @override
  String get ideasBlenderPatternSubject =>
      'Ein Farbquadrat, auf dem du das Muster zeichnest.';

  @override
  String get ideasBlenderPatternTip =>
      'Warte zwischen den Berührungen: Zwei zu nahe Spuren verschmelzen.';

  @override
  String get ideasBlenderPatternStep1 =>
      'Fülle ein Quadrat mit der Grundfarbe und lass es ganz trocknen.';

  @override
  String get ideasBlenderPatternStep2 =>
      'Drück die feine Spitze des Blenders in die Farbe und halte sie eine Sekunde: Ein heller Punkt öffnet sich mit dunklem Rand.';

  @override
  String get ideasBlenderPatternStep3 =>
      'Zieh eine Linie mit der breiten Spitze: Die weggeschobene Tinte sammelt sich an den Rändern.';

  @override
  String get ideasBlenderPatternStep4 =>
      'Mach ein Muster: Punkte, Streifen oder eine Reihe Fischschuppen.';

  @override
  String get ideasBlenderPatternStep5 =>
      'Warte zwischen den Berührungen, sonst laufen die Punkte ineinander.';

  @override
  String get ideasOneMarkerLayersTitle => 'Ein Marker, drei Schichten';

  @override
  String get ideasOneMarkerLayersSummary =>
      'Schattiere einen Würfel mit einem einzigen Marker, indem du einmal, zweimal und dreimal darüber gehst.';

  @override
  String get ideasOneMarkerLayersPractice =>
      'Wie viel Spielraum ein Marker hat, wenn die Schichten trocken aufeinanderliegen.';

  @override
  String get ideasOneMarkerLayersSubject =>
      'Ein Würfel mit Licht aus einer oberen Ecke.';

  @override
  String get ideasOneMarkerLayersTip =>
      'Lass jede Schicht trocknen: Eine nasse zweite Schicht bewegt die Tinte, statt sie dunkler zu machen.';

  @override
  String get ideasOneMarkerLayersStep1 =>
      'Zeichne mit dem Bleistift einen Würfel, mit dem Licht aus einer oberen Ecke.';

  @override
  String get ideasOneMarkerLayersStep2 =>
      'Ein Durchgang über jede Fläche. Lass trocknen.';

  @override
  String get ideasOneMarkerLayersStep3 =>
      'Ein zweiter Durchgang über die beiden Flächen, die vom Licht weg sind.';

  @override
  String get ideasOneMarkerLayersStep4 =>
      'Ein dritter Durchgang nur auf der dunkelsten Fläche und an den unteren Kanten.';

  @override
  String get ideasOneMarkerLayersStep5 =>
      'Schau dir die drei Werte an: So viel Spielraum hat ein einzelner Marker.';

  @override
  String get ideasStipplePeelTitle => 'Gepunktete Orangenschale';

  @override
  String get ideasStipplePeelSummary =>
      'Bau die genoppte Struktur einer Zitrusschale mit Punkten über einem Verlauf auf.';

  @override
  String get ideasStipplePeelPractice =>
      'Punkten über einem trockenen Verlauf, ohne ihn zu verschmieren.';

  @override
  String get ideasStipplePeelSubject =>
      'Eine Orange mit einem weichen Glanzlicht auf der Oberseite.';

  @override
  String get ideasStipplePeelTip =>
      'Nimm die feine Spitze: Sie gibt saubere Sprenkel.';

  @override
  String get ideasStipplePeelStep1 =>
      'Zeichne mit dem Bleistift eine Orange und ein weiches Glanzlicht auf ihrer Oberseite.';

  @override
  String get ideasStipplePeelStep2 =>
      'Fülle die Orange und lass das Glanzlicht heller.';

  @override
  String get ideasStipplePeelStep3 =>
      'Verblende die Grundfarbe in die Schattenseite, solange es nass ist.';

  @override
  String get ideasStipplePeelStep4 =>
      'Wenn alles trocken ist, tippe mit der feinen Spitze des dunklen Markers lockere Punkte: in den Schatten dichter, am Glanz fast keine.';

  @override
  String get ideasStipplePeelStep5 =>
      'Tippe ein paar helle Punkte in die dunklen, um sie aufzubrechen.';

  @override
  String get ideasClearGlassTitle => 'Ein klares Glas';

  @override
  String get ideasClearGlassSummary =>
      'Färbe ein leeres Trinkglas mit Grautönen und sonst fast nichts.';

  @override
  String get ideasClearGlassPractice =>
      'Grau und weißes Papier: der einfachste Weg, Glas zu zeichnen.';

  @override
  String get ideasClearGlassSubject =>
      'Ein Glas mit Rand, Fuß und zwei senkrechten Glanzlichtern.';

  @override
  String get ideasClearGlassTip =>
      'Glas ist am dunkelsten, wo es am dicksten ist: am Rand und am Fuß.';

  @override
  String get ideasClearGlassStep1 =>
      'Zeichne das Glas mit dem Bleistift und markiere Rand, Fuß und zwei senkrechte Glanzlichter, die weißes Papier bleiben.';

  @override
  String get ideasClearGlassStep2 =>
      'Färbe das Glas mit dem hellsten Grau und lass die Glanzlichter und den größten Teil der Mitte weiß.';

  @override
  String get ideasClearGlassStep3 =>
      'Verdunkle Rand, dicken Fuß und die hintere Kante: Glas ist am dunkelsten, wo es am dicksten ist.';

  @override
  String get ideasClearGlassStep4 =>
      'Leg einen Farbfleck hinter das Glas und lass eine hellere Version davon durch das Glas scheinen, über dem hellen Grau.';

  @override
  String get ideasClearGlassStep5 =>
      'Setze weißen Gelstift auf Rand und Fußkante für die schärfsten Glanzpunkte.';

  @override
  String get ideasPolishedMetalTitle => 'Poliertes Metall';

  @override
  String get ideasPolishedMetalSummary =>
      'Lass einen Löffel mit harten Graubändern und einer gespiegelten Farbe wie Metall aussehen.';

  @override
  String get ideasPolishedMetalPractice =>
      'Harte Kanten und eine lange Werteskala: so liest sich Metall.';

  @override
  String get ideasPolishedMetalSubject =>
      'Ein Löffel mit den eingezeichneten Bändern seiner Spiegelung.';

  @override
  String get ideasPolishedMetalTip =>
      'Metall hat keine weichen Übergänge: Lass die Kanten der Bänder hart.';

  @override
  String get ideasPolishedMetalStep1 =>
      'Zeichne den Löffel mit dem Bleistift und seine Spiegelungen als Bänder: ein dunkles quer über die Schale, ein helles daneben, keine weichen Übergänge.';

  @override
  String get ideasPolishedMetalStep2 =>
      'Fülle Schale und Griff mit dem hellsten Grau.';

  @override
  String get ideasPolishedMetalStep3 =>
      'Setze die dunklen Bänder mit harten Kanten, die der Rundung der Schale folgen.';

  @override
  String get ideasPolishedMetalStep4 =>
      'Setze das dunkelste Grau direkt neben das hellste Band: Metall lebt von diesem Kontrast.';

  @override
  String get ideasPolishedMetalStep5 =>
      'Lass einen Fleck in der Farbe des Tisches in der unteren Hälfte der Schale spiegeln und setze dann weißen Gelstift auf den schärfsten Glanz.';

  @override
  String get ideasCastShadowTitle => 'Der Schatten auf dem Tisch';

  @override
  String get ideasCastShadowSummary =>
      'Zeichne eine Tasse und ihren Schlagschatten richtig: dunkel am Kontakt, weich weiter weg.';

  @override
  String get ideasCastShadowPractice =>
      'Schlagschatten: die Kontaktlinie, das Auslaufen und das Grau, das sie zeichnet.';

  @override
  String get ideasCastShadowSubject =>
      'Eine Tasse auf einem Tisch, mit Licht von einer Seite.';

  @override
  String get ideasCastShadowTip =>
      'Der Schatten beginnt dort, wo das Objekt den Tisch berührt, nicht dort, wo das Licht endet.';

  @override
  String get ideasCastShadowStep1 =>
      'Zeichne mit dem Bleistift eine Tasse und die Form ihres Schattens auf dem Tisch, länger auf der vom Licht abgewandten Seite.';

  @override
  String get ideasCastShadowStep2 =>
      'Färbe die Tasse und schattiere ihre vom Licht abgewandte Seite mit demselben Marker in einer zweiten Schicht.';

  @override
  String get ideasCastShadowStep3 =>
      'Fülle den Schlagschatten mit dem Grau: an der Basis der Tasse beginnen und die Spitze anheben, wenn du dich entfernst.';

  @override
  String get ideasCastShadowStep4 =>
      'Füge eine dünne dunkle Linie dort hinzu, wo die Tasse den Tisch berührt.';

  @override
  String get ideasCastShadowStep5 =>
      'Weiche den äußeren Rand des Schattens mit einem zweiten leichten Strich Grau ab, solange der erste noch feucht ist.';

  @override
  String get ideasSoftCloudsTitle => 'Weiche Wolken';

  @override
  String get ideasSoftCloudsSummary =>
      'Färbe den Himmel um die Wolken herum und lass die Wolken als weißes Papier stehen.';

  @override
  String get ideasSoftCloudsPractice =>
      'Negativ malen: Die Form ist das Papier, das du nicht berührt hast.';

  @override
  String get ideasSoftCloudsSubject =>
      'Zwei oder drei Wolken mit runden Oberseiten und flacheren Unterseiten.';

  @override
  String get ideasSoftCloudsTip =>
      'Arbeite mit der breiten Spitze um die Wolken: Ihre Ränder bleiben etwas unregelmäßig.';

  @override
  String get ideasSoftCloudsStep1 =>
      'Zeichne mit dem Bleistift sehr leicht zwei oder drei Wolken: runde Oberseiten, flachere Unterseiten.';

  @override
  String get ideasSoftCloudsStep2 =>
      'Fülle den Himmel mit dem hellen Blau und arbeite mit der breiten Spitze um die Wolken, damit ihre Ränder etwas unregelmäßig bleiben.';

  @override
  String get ideasSoftCloudsStep3 =>
      'Verdunkle den Himmel nach oben und verblende ihn nach unten in das helle Blau, solange es nass ist.';

  @override
  String get ideasSoftCloudsStep4 =>
      'Schattiere die Unterseite jeder Wolke mit dem hellen Grau und lass die Oberseiten weiß.';

  @override
  String get ideasSoftCloudsStep5 =>
      'Weiche mit dem farblosen Blender jeden harten Himmelsrand an einer Wolke ab und schieb die Farbe nach außen.';

  @override
  String get ideasStillWaterTitle => 'Spiegelung im stillen Wasser';

  @override
  String get ideasStillWaterSummary =>
      'Zeichne einen Baum am Ufer und seine auf dem Kopf stehende, etwas dunklere Kopie im Wasser.';

  @override
  String get ideasStillWaterPractice =>
      'Eine Farbe über eine andere legen: so entsteht eine Spiegelung.';

  @override
  String get ideasStillWaterSubject =>
      'Ein Baum am Ufer mit seiner Spiegelung im Wasser darunter.';

  @override
  String get ideasStillWaterTip =>
      'Mal die Spiegelung nur in waagerechten Strichen: Wasser bewegt sich zur Seite.';

  @override
  String get ideasStillWaterStep1 =>
      'Zeichne mit dem Bleistift eine Horizontlinie, einen einfachen Baum darüber und sein Spiegelbild darunter.';

  @override
  String get ideasStillWaterStep2 =>
      'Färbe den Baum und seine Spiegelung mit demselben Marker, die Spiegelung nur in waagerechten Strichen.';

  @override
  String get ideasStillWaterStep3 =>
      'Breite das helle Blau über die ganze Wasserfläche, auch über die Spiegelung, in langen waagerechten Strichen.';

  @override
  String get ideasStillWaterStep4 =>
      'Verdunkle das Wasser am Ufer und am fernen Rand; ein paar gebrochene waagerechte Linien in der Grundfarbe über der Spiegelung.';

  @override
  String get ideasStillWaterStep5 =>
      'Setze das dunkle Blau dort, wo das Ufer das Wasser trifft, und zieh dann zwei oder drei dünne weiße Gelstiftlinien für die Wellen.';

  @override
  String get ideasTwistedRibbonTitle => 'Verdrehtes Band';

  @override
  String get ideasTwistedRibbonSummary =>
      'Verblende einen Verlauf, der einem Band folgt, das sich über und unter sich windet.';

  @override
  String get ideasTwistedRibbonPractice =>
      'Einen kurzen Verlauf auf jeder Biegung wiederholen.';

  @override
  String get ideasTwistedRibbonSubject =>
      'Ein Band mit zwei Drehungen, über und unter sich.';

  @override
  String get ideasTwistedRibbonTip =>
      'Verblende entlang der Kurve des Bands, nie quer darüber.';

  @override
  String get ideasTwistedRibbonStep1 =>
      'Zeichne mit dem Bleistift ein Band mit zwei Drehungen und markiere, welche Abschnitte vorne und welche hinten liegen.';

  @override
  String get ideasTwistedRibbonStep2 =>
      'Fülle jeden Abschnitt mit dem hellen Marker.';

  @override
  String get ideasTwistedRibbonStep3 =>
      'Gib jedem Abschnitt die Grundfarbe auf der Seite, die sich von dir wegbiegt, in Strichen, die der Kurve folgen und nicht quer laufen.';

  @override
  String get ideasTwistedRibbonStep4 =>
      'Verdunkle nur dort, wo ein Abschnitt unter einem anderen durchgeht: als schmales Band genau an der Überlappung.';

  @override
  String get ideasTwistedRibbonStep5 =>
      'Geh mit dem farblosen Blender an jedem Band entlang, wo der Verlauf gestuft aussieht.';

  @override
  String get ideasNoLineLeafTitle => 'Färben ohne Linien';

  @override
  String get ideasNoLineLeafSummary =>
      'Färbe ein Blatt nach einer Bleistiftskizze und lass die Farbkanten die Kontur übernehmen.';

  @override
  String get ideasNoLineLeafPractice =>
      'Zeichnen ohne Liner: Die Kante der Farbe ist die Kontur.';

  @override
  String get ideasNoLineLeafSubject => 'Ein einfaches Blatt mit mittiger Ader.';

  @override
  String get ideasNoLineLeafTip =>
      'Heb den Bleistift mit einem weichen Radiergummi ab, bis du ihn kaum noch siehst.';

  @override
  String get ideasNoLineLeafStep1 =>
      'Zeichne das Blatt und seine Mittelader sehr leicht mit dem Bleistift und nimm dann den meisten Graphit mit einem weichen Radiergummi weg, bis du ihn kaum noch siehst.';

  @override
  String get ideasNoLineLeafStep2 =>
      'Fülle das Blatt und höre genau an der Bleistiftlinie auf.';

  @override
  String get ideasNoLineLeafStep3 =>
      'Schattiere eine Hälfte und die Basis des Blatts, solange die erste Schicht feucht ist.';

  @override
  String get ideasNoLineLeafStep4 =>
      'Zieh die Kante auf der Schattenseite mit einer dünnen Linie des dunkelsten Markers nach, statt mit einem Liner.';

  @override
  String get ideasNoLineLeafStep5 =>
      'Radier den Bleistift, der noch zu sehen ist, erst weg, wenn die Tinte trocken ist.';

  @override
  String get ideasShortFurTitle => 'Kurzes Fell';

  @override
  String get ideasShortFurSummary =>
      'Färbe ein Katzenohr mit kurzen Strichen in zwei Richtungen.';

  @override
  String get ideasShortFurPractice =>
      'Kurze Striche, die der Haarrichtung folgen.';

  @override
  String get ideasShortFurSubject =>
      'Ein Katzenohr mit ein paar Pfeilen, die die Haarrichtung zeigen.';

  @override
  String get ideasShortFurTip =>
      'Zieh von den Wurzeln nach außen: aufdrücken, schnell bewegen und abheben.';

  @override
  String get ideasShortFurStep1 =>
      'Zeichne mit dem Bleistift das Ohr und die Haarrichtung mit ein paar Pfeilen.';

  @override
  String get ideasShortFurStep2 =>
      'Fülle das Ohr mit dem hellen Marker und zieh am Rand nach außen, damit die Kante fellig und nicht fest wirkt.';

  @override
  String get ideasShortFurStep3 =>
      'Kurze Striche mit der Grundfarbe von der Innenkante nach außen, den Pfeilen folgend.';

  @override
  String get ideasShortFurStep4 =>
      'Weniger und dunklere Striche im Ohr und an der Basis, wo es auf den Kopf trifft.';

  @override
  String get ideasShortFurStep5 =>
      'Streich mit dem hellen Marker noch mal über die Nähte, um die Schichten zu verbinden und die dunkelsten Striche zu mildern.';

  @override
  String get ideasWoodGrainTitle => 'Holzbrett';

  @override
  String get ideasWoodGrainSummary =>
      'Ein Brett mit Maserung und einem Knoten, in drei Brauntönen.';

  @override
  String get ideasWoodGrainPractice =>
      'Lange Striche, die der Form des Materials folgen.';

  @override
  String get ideasWoodGrainSubject =>
      'Ein Holzbrett mit einem Knoten nahe an einem Ende.';

  @override
  String get ideasWoodGrainTip =>
      'Die Maserung fließt um den Knoten herum: Zeichne die Linien gebogen, nie gerade.';

  @override
  String get ideasWoodGrainStep1 =>
      'Zeichne mit dem Bleistift ein Brett mit einem Knoten; die Maserung fließt um den Knoten wie Wasser um einen Stein.';

  @override
  String get ideasWoodGrainStep2 =>
      'Fülle das Brett mit langen Strichen entlang der Maserung.';

  @override
  String get ideasWoodGrainStep3 =>
      'Lange, leicht gewellte Linien in der Grundfarbe entlang der Maserung, die sich am Knoten verdichten.';

  @override
  String get ideasWoodGrainStep4 =>
      'Ein paar dunklere Linien und die Ringe des Knotens; verdunkle die untere Kante des Bretts.';

  @override
  String get ideasWoodGrainStep5 =>
      'Geh mit dem hellen Marker noch mal über die Linien, damit sie weniger aufgemalt wirken.';

  @override
  String get ideasBrickWallTitle => 'Ziegelmauer';

  @override
  String get ideasBrickWallSummary =>
      'Ein Stück Ziegelmauer mit leicht unterschiedlichen Ziegelfarben und hellem Mörtel.';

  @override
  String get ideasBrickWallPractice =>
      'Flächige Füllungen, Ziegel für Ziegel, und das Grau des Mörtels.';

  @override
  String get ideasBrickWallSubject =>
      'Ein Stück Mauer mit etwa zwanzig Ziegeln.';

  @override
  String get ideasBrickWallTip =>
      'Lass den Mörtel Papier bleiben: Er ist heller als jeder Ziegel.';

  @override
  String get ideasBrickWallStep1 =>
      'Zeichne mit dem Bleistift das Mörtelraster und lass es vorerst Papier.';

  @override
  String get ideasBrickWallStep2 =>
      'Fülle jeden Ziegel mit dem hellen Marker und lass jeden Ziegel als eigene Form trocknen.';

  @override
  String get ideasBrickWallStep3 =>
      'Geh mit der Grundfarbe über etwa die Hälfte der Ziegel, zufällig gewählt, damit die Mauer nicht einheitlich wirkt.';

  @override
  String get ideasBrickWallStep4 =>
      'Schattiere die untere Kante jedes Ziegels, dazu ein paar abgeplatzte Stellen und dunklere Ziegel.';

  @override
  String get ideasBrickWallStep5 =>
      'Fülle die Mörtelfugen mit dem hellen Grau.';

  @override
  String get ideasFoldedClothTitle => 'Gefalteter Stoff';

  @override
  String get ideasFoldedClothSummary =>
      'Schattiere die Falten eines hängenden Stoffes mit vier Werten und einer Lichtrichtung.';

  @override
  String get ideasFoldedClothPractice =>
      'Derselbe Verlauf auf jeder Falte wiederholt.';

  @override
  String get ideasFoldedClothSubject =>
      'Ein Stoff über einer Leine, mit drei oder vier Falten.';

  @override
  String get ideasFoldedClothTip =>
      'Die dunkelste Linie kommt nur dorthin, wo der Stoff unter sich selbst dreht.';

  @override
  String get ideasFoldedClothStep1 =>
      'Zeichne mit dem Bleistift einen Stoff über einer Leine, mit drei oder vier Falten, und markiere den oberen Rand jeder Falte.';

  @override
  String get ideasFoldedClothStep2 => 'Fülle den Stoff.';

  @override
  String get ideasFoldedClothStep3 =>
      'Grundfarbe auf der vom Licht abgewandten Seite jeder Falte, in das Helle verblendet, solange es feucht ist.';

  @override
  String get ideasFoldedClothStep4 =>
      'Schatten tief in jeder Falte, wo der Stoff umschlägt.';

  @override
  String get ideasFoldedClothStep5 =>
      'Eine dünne dunkle Linie nur ganz unten in den tiefsten Falten; geh mit dem farblosen Blender über jeden harten Sprung auf den runden Teilen.';

  @override
  String get ideasWaterDropsTitle => 'Tropfen auf einem Blatt';

  @override
  String get ideasWaterDropsSummary =>
      'Drei Wassertropfen auf einem Blatt, jeder mit Schatten, dunklem Rand und hellem Glanzlicht.';

  @override
  String get ideasWaterDropsPractice =>
      'Ein paar harte Striche und Punkte über einem fertigen Verlauf.';

  @override
  String get ideasWaterDropsSubject =>
      'Ein Blatt mit drei Wassertropfen darauf.';

  @override
  String get ideasWaterDropsTip =>
      'Der Tropfen dreht das Licht um: Schattiere die Seite, die zum Licht zeigt.';

  @override
  String get ideasWaterDropsStep1 =>
      'Zeichne mit dem Bleistift ein Blatt und drei Tropfen; markiere in jedem Tropfen ein kleines Glanzlicht auf der Lichtseite.';

  @override
  String get ideasWaterDropsStep2 =>
      'Färbe das ganze Blatt, die Tropfen eingeschlossen; die Tropfen sind das Blatt durch Wasser gesehen.';

  @override
  String get ideasWaterDropsStep3 =>
      'Schattiere das Blatt und in jedem Tropfen die Seite zum Licht, denn der Tropfen wirkt wie eine Lupe und dreht es um.';

  @override
  String get ideasWaterDropsStep4 =>
      'Eine dünne dunkle Sichel auf der abgewandten Seite jedes Tropfens und ein kleiner Schlagschatten darunter.';

  @override
  String get ideasWaterDropsStep5 =>
      'Weißer Gelstift: ein harter Punkt je Tropfen auf der Lichtseite und ein schwacher heller Saum gegenüber.';

  @override
  String get ideasStrawberrySeedsTitle => 'Erdbeere';

  @override
  String get ideasStrawberrySeedsSummary =>
      'Eine Erdbeere, deren Samen in kleinen Mulden sitzen, mit grünem Kelch.';

  @override
  String get ideasStrawberrySeedsPractice =>
      'Textur aus kleinen Punkten und Tupfern: Mulden, Samen und Kelch.';

  @override
  String get ideasStrawberrySeedsSubject =>
      'Eine Erdbeere mit einem lockeren Raster aus Samen.';

  @override
  String get ideasStrawberrySeedsTip =>
      'Tippe die Mulden, solange die Farbe noch feucht ist: Der dunklere Ring bildet sich von selbst.';

  @override
  String get ideasStrawberrySeedsStep1 =>
      'Zeichne mit dem Bleistift die Erdbeere und ein lockeres Raster aus Samenpunkten, dichter zur Spitze hin.';

  @override
  String get ideasStrawberrySeedsStep2 =>
      'Fülle die Frucht und lass ein weiches Glanzlicht frei.';

  @override
  String get ideasStrawberrySeedsStep3 =>
      'Verblende die Grundfarbe an den Seiten; drück, solange es feucht ist, über jedem Samen einen etwas dunkleren Punkt.';

  @override
  String get ideasStrawberrySeedsStep4 =>
      'Verdunkle die untere Hälfte und die Mulde über jedem Samen.';

  @override
  String get ideasStrawberrySeedsStep5 =>
      'Färbe die Blätter und den Stiel mit dem Grün und setze dann einen kleinen hellen Gelstiftpunkt in jede Mulde für den Samen.';

  @override
  String get ideasPaletteMixingTitle => 'Mischen auf einer Palette';

  @override
  String get ideasPaletteMixingSummary =>
      'Mische zwei Marker auf einer Plastikfläche zu einer dritten Farbe und nimm sie mit dem farblosen Blender auf.';

  @override
  String get ideasPaletteMixingPractice =>
      'Zwei Tinten außerhalb des Papiers mischen, mit dem Blender als Pinsel.';

  @override
  String get ideasPaletteMixingSubject =>
      'Ein Plastikdeckel oder eine Mischkarte, dazu ein Schmierblatt.';

  @override
  String get ideasPaletteMixingTip =>
      'Der Blender trägt nur, was nass ist: Lass die Farbtropfen nicht antrocknen.';

  @override
  String get ideasPaletteMixingStep1 =>
      'Kritzel mit dem ersten Marker auf eine nicht saugende Fläche, etwa eine Mischkarte, einen Plastikdeckel oder eine Gefriertüte.';

  @override
  String get ideasPaletteMixingStep2 =>
      'Kritzel den zweiten Marker daneben, sodass sich die beiden Tropfen berühren.';

  @override
  String get ideasPaletteMixingStep3 =>
      'Nimm die Mischung mit der breiten Spitze des farblosen Blenders auf und male damit eine Probe; daneben male jeden Marker allein.';

  @override
  String get ideasPaletteMixingStep4 =>
      'Probier eine zweite Mischung mit mehr von einer Farbe.';

  @override
  String get ideasPaletteMixingStep5 =>
      'Notier dir, welche Mischungen du gern als Marker hättest.';

  @override
  String get ideasLongHairTitle => 'Langes Haar';

  @override
  String get ideasLongHairSummary =>
      'Fallendes Haar mit einem Lichtband quer darüber und Strähnen, die der Kopfform folgen.';

  @override
  String get ideasLongHairPractice =>
      'Lange, sich verjüngende Striche und ein Band Licht, das nur Papier ist.';

  @override
  String get ideasLongHairSubject =>
      'Ein Haarschopf aus wenigen großen Strähnen und einem Band Licht.';

  @override
  String get ideasLongHairTip =>
      'Drück im Lichtband weniger: Das Papier übernimmt die Arbeit.';

  @override
  String get ideasLongHairStep1 =>
      'Zeichne mit dem Bleistift das Haar in wenigen großen Strähnen, nicht in einzelnen Haaren, und ein gekrümmtes Band, wo das Licht trifft.';

  @override
  String get ideasLongHairStep2 =>
      'Fülle das ganze Haar und drück im Lichtband weniger.';

  @override
  String get ideasLongHairStep3 =>
      'Lange Striche vom Scheitel nach unten, die die Spitze anheben, wenn sie das Lichtband erreichen, und dann von den Enden nach oben.';

  @override
  String get ideasLongHairStep4 =>
      'Verdunkle zwischen den Strähnen und unter Ohr und Hals.';

  @override
  String get ideasLongHairStep5 =>
      'Ein paar dünne Strähnen mit dem dunkelsten Marker, dann zwei oder drei feine Strähnen mit weißem Gelstift nur im Lichtband.';

  @override
  String get ideasOverlapGlazesTitle => 'Übereinanderliegende Lasuren';

  @override
  String get ideasOverlapGlazesSummary =>
      'Leg drei durchscheinende Kreise übereinander und sieh, welche neuen Farben entstehen.';

  @override
  String get ideasOverlapGlazesPractice =>
      'Durchsichtige Schichten: Jede Überlappung ist eine echte Mischung.';

  @override
  String get ideasOverlapGlazesSubject =>
      'Drei überlappende Kreise, wie ein Venn-Diagramm.';

  @override
  String get ideasOverlapGlazesTip =>
      'Die Reihenfolge zählt: Die hellere Farbe oben sieht immer anders aus.';

  @override
  String get ideasOverlapGlazesStep1 =>
      'Zeichne mit dem Bleistift drei Kreise, die sich wie ein Venn-Diagramm überlappen.';

  @override
  String get ideasOverlapGlazesStep2 =>
      'Fülle den ersten Kreis und lass ihn ganz trocknen.';

  @override
  String get ideasOverlapGlazesStep3 =>
      'Fülle den zweiten, auch die Überlappung; die Überlappung wird zur dritten Farbe.';

  @override
  String get ideasOverlapGlazesStep4 =>
      'Fülle den dritten Kreis; die Mitte, wo sich alle drei treffen, ist die dunkelste Mischung.';

  @override
  String get ideasOverlapGlazesStep5 =>
      'Wiederhole die Marker in anderer Reihenfolge: Die hellere oben sieht immer anders aus.';

  @override
  String get ideasFadedBackgroundTitle => 'Verblassender Hintergrund';

  @override
  String get ideasFadedBackgroundSummary =>
      'Gib einer Zeichnung einen Farbschein, der lange vor dem Papierrand zu Weiß ausläuft.';

  @override
  String get ideasFadedBackgroundPractice =>
      'Eine Vignette aus runden Strichen und dem farblosen Blender.';

  @override
  String get ideasFadedBackgroundSubject =>
      'Eine Tasse, ein Vogel oder ein anderes kleines Motiv in der Seitenmitte.';

  @override
  String get ideasFadedBackgroundTip =>
      'Hör vor dem Papierrand auf: Der Schein läuft von selbst aus.';

  @override
  String get ideasFadedBackgroundStep1 =>
      'Zeichne mit dem Bleistift ein einfaches Motiv, etwa eine Tasse oder einen Vogel, in die Seitenmitte.';

  @override
  String get ideasFadedBackgroundStep2 =>
      'Färbe einen Ring in der Grundfarbe um das Motiv, etwa fingerbreit, in runden Strichen.';

  @override
  String get ideasFadedBackgroundStep3 =>
      'Zieh den hellen Marker vom Ring nach außen in sich überlappenden Kreisen, bis er verblasst.';

  @override
  String get ideasFadedBackgroundStep4 =>
      'Geh mit dem farblosen Blender über die Farbe hinaus und schieb den Rest ins Papier, damit gar keine Kante bleibt.';

  @override
  String get ideasFadedBackgroundStep5 =>
      'Vollende das Motiv so, dass es dunkler ist als der Schein.';

  @override
  String get ideasHatchShadingTitle => 'Schraffierte Schattierung';

  @override
  String get ideasHatchShadingSummary =>
      'Schattiere einen Apfel nur mit Linien, ohne zu verblenden: Schraffur für den Mittelton, Kreuzschraffur für den Schatten.';

  @override
  String get ideasHatchShadingPractice =>
      'Schraffur und Kreuzschraffur: Linien, die als Ton gelesen werden.';

  @override
  String get ideasHatchShadingSubject =>
      'Ein Apfel mit eingezeichnetem Glanzlicht.';

  @override
  String get ideasHatchShadingTip =>
      'Halte die Linien parallel und gleichmäßig: Das Auge macht den Rest.';

  @override
  String get ideasHatchShadingStep1 =>
      'Zeichne mit dem Bleistift einen Apfel und markiere das Glanzlicht.';

  @override
  String get ideasHatchShadingStep2 =>
      'Fülle den Apfel flach und lass ihn trocknen.';

  @override
  String get ideasHatchShadingStep3 =>
      'Schraffiere die Schattenhälfte mit parallelen Linien der feinen Spitze, je weiter vom Licht entfernt, desto dichter.';

  @override
  String get ideasHatchShadingStep4 =>
      'Kreuze die dunkelste Stelle mit einem zweiten Satz Linien in einem anderen Winkel und setze den Kontaktschatten unter den Apfel.';

  @override
  String get ideasHatchShadingStep5 =>
      'Geh ein Stück zurück: Aus der Ferne wird aus den Linien ein Ton.';

  @override
  String get ideasCategoryTechnique => 'Techniken';

  @override
  String get ideasCategoryColorChallenge => 'Farb-Challenges';

  @override
  String get ideasCategoryMood => 'Stimmungen';

  @override
  String get ideasCategorySeason => 'Jahreszeiten';

  @override
  String get ideasDifficultyEasy => 'Leicht';

  @override
  String get ideasDifficultyMedium => 'Mittel';

  @override
  String get ideasDifficultyHard => 'Schwer';

  @override
  String get ideasSeasonSpring => 'Frühling';

  @override
  String get ideasSeasonSummer => 'Sommer';

  @override
  String get ideasSeasonAutumn => 'Herbst';

  @override
  String get ideasSeasonWinter => 'Winter';

  @override
  String get ideasSectionAnyTime => 'Jederzeit';

  @override
  String ideasSeeAllSemantic(int count, String category) {
    return 'Alle $count Ideen in $category anzeigen';
  }

  @override
  String get ideasFeaturedLabel => 'Idee des Tages';

  @override
  String get ideasOtherMarkersButton => 'Andere Marker';

  @override
  String get ideasPracticeTitle => 'Das übst du';

  @override
  String get ideasSubjectTitle => 'Das zeichnest du';

  @override
  String get ideasMarkersTitle => 'Deine Marker';

  @override
  String get ideasStepsTitle => 'Schritte';

  @override
  String get ideasTipTitle => 'Tipp';

  @override
  String get ideasMaterialsTitle => 'Das brauchst du';

  @override
  String get ideasMaterialPaper => 'Markerpapier mit einem Blatt darunter';

  @override
  String get ideasMaterialBlender => 'farbloser Blender';

  @override
  String get ideasMaterialWhiteGel => 'weißer Gelstift';

  @override
  String get ideasMaterialPigmentLiner => 'schwarzer Pigmentliner';

  @override
  String get ideasMaterialPencil => 'Bleistift';

  @override
  String get ideasMaterialTape => 'Malerkrepp';

  @override
  String get ideasBackLabel => 'Zurück zu den Ideen';

  @override
  String ideasMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String ideasMissingMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Für diese Idee fehlen dir $count Marker.',
      one: 'Für diese Idee fehlt dir 1 Marker.',
    );
    return '$_temp0';
  }

  @override
  String ideasMarkerSemantic(String role, String code, String name) {
    return '$role: $code $name';
  }

  @override
  String get ideasSmoothFillTitle => 'Streifenfreie Fläche';

  @override
  String get ideasSmoothFillSummary =>
      'Fülle ein Quadrat mit einem Marker ohne sichtbare Streifen.';

  @override
  String get ideasSmoothFillPractice =>
      'Gleichmäßige, streifenfreie Deckung, die Grundlage jeder Markerzeichnung.';

  @override
  String get ideasSmoothFillSubject =>
      'Ein 5 × 5 cm großes Quadrat, mit Malerkrepp eingerahmt, dann eine einfache flache Form wie ein Blatt.';

  @override
  String get ideasSmoothFillTip =>
      'Fängt das Papier an zu pillen, hör auf: Es ist gesättigt. Lass es ganz trocknen, bevor du eine weitere Schicht aufträgst.';

  @override
  String get ideasSmoothFillStep1 =>
      'Klebe ein 5 × 5 cm großes Quadrat auf Markerpapier und lege ein Blatt Altpapier darunter.';

  @override
  String get ideasSmoothFillStep2 =>
      'Fülle das Quadrat mit dem hellen Marker in kleinen, überlappenden Kreisen, ohne abzusetzen.';

  @override
  String get ideasSmoothFillStep3 =>
      'Halte eine nasse Kante: Geh immer über Tinte, die noch glänzt, nie über trockene.';

  @override
  String get ideasSmoothFillStep4 =>
      'Lass es trocknen und trage dann mit demselben Marker eine zweite Schicht im rechten Winkel zur ersten auf.';

  @override
  String get ideasSmoothFillStep5 =>
      'Wiederhole das Quadrat mit dem dunkleren Marker und vergleiche: Streifen fallen bei dunklen Farben stärker auf.';

  @override
  String get ideasSmoothFillStep6 =>
      'Zieh das Krepp langsam ab, damit eine saubere Kante entsteht.';

  @override
  String get ideasThreeMarkerBlendTitle => 'Verlauf mit drei Markern';

  @override
  String get ideasThreeMarkerBlendSummary =>
      'Verblende einen hellen, einen mittleren und einen dunklen Marker einer Familie auf einer Kugel.';

  @override
  String get ideasThreeMarkerBlendPractice =>
      'Weiches Verblenden von hell nach dunkel innerhalb einer Farbfamilie.';

  @override
  String get ideasThreeMarkerBlendSubject =>
      'Eine Kugel mit Licht von links oben und ihrem Schatten auf dem Tisch.';

  @override
  String get ideasThreeMarkerBlendTip =>
      'Wähle Marker mit ähnlichem Ton: Ist der Sprung zwischen ihnen zu groß, bleibt eine Linie sichtbar.';

  @override
  String get ideasThreeMarkerBlendStep1 =>
      'Zeichne mit leichtem Bleistift einen Kreis und markiere, woher das Licht kommt.';

  @override
  String get ideasThreeMarkerBlendStep2 =>
      'Bedecke die ganze Kugel mit dem hellen Marker und lass eine kleine weiße Stelle fürs Glanzlicht frei.';

  @override
  String get ideasThreeMarkerBlendStep3 =>
      'Trage den mittleren Marker noch feucht auf die Schattenhälfte auf, in gebogenen Strichen entlang der Form.';

  @override
  String get ideasThreeMarkerBlendStep4 =>
      'Setze den dunklen Marker nur am Rand auf, der am weitesten vom Licht entfernt ist.';

  @override
  String get ideasThreeMarkerBlendStep5 =>
      'Geh über die Übergänge zuerst mit dem mittleren, dann mit dem hellen Marker, damit die Stufen verschmelzen.';

  @override
  String get ideasThreeMarkerBlendStep6 =>
      'Mildere harte Kanten um das Glanzlicht mit dem farblosen Blender.';

  @override
  String get ideasFlickingTitle => 'Auslaufende Striche';

  @override
  String get ideasFlickingSummary =>
      'Zeichne Haare oder Gras mit schnellen Strichen, die am Ende auslaufen.';

  @override
  String get ideasFlickingPractice =>
      'Flicking: schnelle, auslaufende Striche, um ohne harte Kanten zu verblenden.';

  @override
  String get ideasFlickingSubject => 'Ein Pferdeschwanz oder ein Grasbüschel.';

  @override
  String get ideasFlickingTip =>
      'Probiere es zuerst auf einem Schmierblatt: Je schneller du dich bewegst, desto dünner läuft der Strich aus.';

  @override
  String get ideasFlickingStep1 =>
      'Zeichne die Hauptsträhnen oder Halme mit Bleistift als einfache Formen, ohne Details.';

  @override
  String get ideasFlickingStep2 =>
      'Bedecke jede Form mit dem hellen Marker in einer flachen Schicht und lass sie trocknen.';

  @override
  String get ideasFlickingStep3 =>
      'Ziehe den mittleren Marker von den Wurzeln nach außen: aufdrücken, schnell bewegen und vor dem Strichende abheben.';

  @override
  String get ideasFlickingStep4 =>
      'Mach dasselbe mit dem dunklen Marker, nur von den Wurzeln aus und kürzer, wo sich die Strähnen überlappen.';

  @override
  String get ideasFlickingStep5 =>
      'Ziehe den hellen Marker von den Spitzen zurück zu den Wurzeln, um den Tonwechsel zu mildern.';

  @override
  String get ideasFlickingStep6 =>
      'Lass dort ein Band der ersten Schicht stehen, wo das Haar das Licht fängt.';

  @override
  String get ideasGrayscaleTitle => 'Graustufen';

  @override
  String get ideasGrayscaleSummary =>
      'Zeichne einen einfachen Gegenstand mit einer Grau-Familie, um zu sehen, wie Licht und Schatten Form aufbauen.';

  @override
  String get ideasGrayscalePractice =>
      'Licht und Schatten als Stufen von hell nach dunkel sehen.';

  @override
  String get ideasGrayscaleSubject =>
      'Eine Tasse, ein Apfel oder ein Ei unter einer einzigen Lampe.';

  @override
  String get ideasGrayscaleTip =>
      'Mische keine warmen und kühlen Grautöne an einem Gegenstand: Wähle eine Familie.';

  @override
  String get ideasGrayscaleStep1 =>
      'Wähle einen einfachen Gegenstand und markiere mit Bleistift, woher das Licht kommt.';

  @override
  String get ideasGrayscaleStep2 =>
      'Lass das Glanzlicht als weißes Papier stehen. Male nie darüber.';

  @override
  String get ideasGrayscaleStep3 =>
      'Bedecke den ganzen Gegenstand mit dem hellsten Grau und lass es trocknen.';

  @override
  String get ideasGrayscaleStep4 =>
      'Trage das nächste Grau auf der Schattenseite auf und verblende die Kante, solange sie nass ist.';

  @override
  String get ideasGrayscaleStep5 =>
      'Wiederhole das mit jedem dunkleren Grau, jedes Mal auf kleinerer Fläche.';

  @override
  String get ideasGrayscaleStep6 =>
      'Nutze das dunkelste Grau nur für den Schlagschatten und die Kontaktlinie unter dem Gegenstand.';

  @override
  String get ideasStickerEffectTitle => 'Sticker-Effekt';

  @override
  String get ideasStickerEffectSummary =>
      'Lass eine Figur wie einen ausgeschnittenen Sticker mit papierweißem Rand und farbigem Hintergrund aussehen.';

  @override
  String get ideasStickerEffectPractice =>
      'Das Weiß des Papiers bewusst stehen lassen.';

  @override
  String get ideasStickerEffectSubject =>
      'Eine Katze, ein Stück Pizza oder ein Cartoon-Stern.';

  @override
  String get ideasStickerEffectTip =>
      'Das Weiß muss das Papier sein. Weißer Gelstift über Markertinte wirkt fleckig.';

  @override
  String get ideasStickerEffectStep1 =>
      'Zeichne dein Motiv und dann mit Bleistift eine zweite Kontur 3–5 mm außerhalb: Das ist der Stickerrand.';

  @override
  String get ideasStickerEffectStep2 =>
      'Male das Motiv von hell nach dunkel, ohne den Rand zu berühren.';

  @override
  String get ideasStickerEffectStep3 =>
      'Male den Hintergrund um den Rand in einer flachen Farbe, damit die weiße Kante sichtbar bleibt.';

  @override
  String get ideasStickerEffectStep4 =>
      'Wenn es trocken ist, fahre die Außenseite des Rands mit einem schwarzen Liner oder Brush Pen nach.';

  @override
  String get ideasStickerEffectStep5 =>
      'Füge entlang einer Seite des Rands einen grauen Schatten hinzu, damit der Sticker vom Blatt abhebt.';

  @override
  String get ideasGlossyCherriesTitle => 'Glänzende Kirschen';

  @override
  String get ideasGlossyCherriesSummary =>
      'Lass zwei Kirschen mit ausgespartem Glanzlicht und Widerschein glänzen.';

  @override
  String get ideasGlossyCherriesPractice =>
      'Scharfe Glanzlichter und Widerschein, die Schlüssel zu einer glänzenden Oberfläche.';

  @override
  String get ideasGlossyCherriesSubject =>
      'Zwei Kirschen an einem Stiel, von einer Seite beleuchtet.';

  @override
  String get ideasGlossyCherriesTip =>
      'Glänzende Oberflächen haben scharf begrenzte Glanzlichter: Verblende sie nicht, halte den Rand klar.';

  @override
  String get ideasGlossyCherriesStep1 =>
      'Zeichne die Kirschen vor und die Form jedes Glanzlichts: eine scharfe Bohnenform nahe der Oberseite.';

  @override
  String get ideasGlossyCherriesStep2 =>
      'Bedecke jede Kirsche mit dem hellen Marker und spare die Glanzlichter als weißes Papier aus.';

  @override
  String get ideasGlossyCherriesStep3 =>
      'Trage die Basis überall auf, außer an einer schmalen Sichel am unteren Rand: Das ist der Widerschein.';

  @override
  String get ideasGlossyCherriesStep4 =>
      'Lege den Schatten auf die vom Licht abgewandte Seite und verblende ihn, solange er nass ist, in die Basis.';

  @override
  String get ideasGlossyCherriesStep5 =>
      'Setze den dunkelsten Marker in einem schmalen Band zwischen Schatten und Widerschein.';

  @override
  String get ideasGlossyCherriesStep6 =>
      'Zeichne den Schatten auf dem Tisch mit dem Grau und setze nach dem Trocknen einen weißen Gelpunkt auf jedes Glanzlicht.';

  @override
  String get ideasColoredShadowsTitle => 'Farbige Schatten';

  @override
  String get ideasColoredShadowsSummary =>
      'Schattiere dieselbe Zitrone zweimal, einmal mit Grau und einmal mit Violett, und vergleiche.';

  @override
  String get ideasColoredShadowsPractice =>
      'Schattenfarben wählen, die eine Zeichnung lebendig halten.';

  @override
  String get ideasColoredShadowsSubject =>
      'Zwei Zitronen nebeneinander auf einem weißen Tisch.';

  @override
  String get ideasColoredShadowsTip =>
      'Ein Schatten neigt oft zum Gegenteil des Lichts: Violett unter Gelb, Blau unter Orange.';

  @override
  String get ideasColoredShadowsStep1 =>
      'Zeichne zwei gleiche Zitronen nebeneinander, mit Licht von derselben Seite.';

  @override
  String get ideasColoredShadowsStep2 =>
      'Male beide mit dem Gelb aus und lass ein kleines Glanzlicht als weißes Papier frei.';

  @override
  String get ideasColoredShadowsStep3 =>
      'Schattiere bei der ersten Zitrone die dunkle Seite und den Schatten auf dem Tisch mit dem Grau.';

  @override
  String get ideasColoredShadowsStep4 =>
      'Mach bei der zweiten dasselbe mit dem Violett, sanft: Eine Schicht reicht.';

  @override
  String get ideasColoredShadowsStep5 =>
      'Geh mit dem Gelb über den Rand des zweiten Schattens, um ihn zu verblenden.';

  @override
  String get ideasColoredShadowsStep6 =>
      'Schau sie dir aus der Entfernung an: Der violette Schatten wirkt neben dem Gelb leuchtender und natürlicher.';

  @override
  String get ideasStainedGlassTitle => 'Buntglas';

  @override
  String get ideasStainedGlassSummary =>
      'Male die Glasfelder mit einfachen Verläufen und zieh am Ende die Bleilinien.';

  @override
  String get ideasStainedGlassPractice =>
      'Saubere Verläufe auf kleinen Flächen; die schwarzen Linien verdecken unregelmäßige Kanten.';

  @override
  String get ideasStainedGlassSubject =>
      'Ein rundes Fenster mit einer Blume oder einer Sonne in der Mitte.';

  @override
  String get ideasStainedGlassTip =>
      'Wenn du die schwarzen Linien zuerst ziehst, nimm alkoholfeste Pigmenttinte: Normale Tinte verschmiert unter dem Marker.';

  @override
  String get ideasStainedGlassStep1 =>
      'Zeichne das Fenster mit Bleistift vor und teile es in Felder unterschiedlicher Größe.';

  @override
  String get ideasStainedGlassStep2 =>
      'Male zuerst die Felder der Hauptfarbe, jedes als Verlauf: an einer Kante dunkler, in der Mitte heller.';

  @override
  String get ideasStainedGlassStep3 =>
      'Mach dasselbe mit der zweiten und dritten Farbe und lass jedes Feld trocknen, bevor du das Nachbarfeld malst.';

  @override
  String get ideasStainedGlassStep4 =>
      'Setze den Akzent nur in wenigen kleinen Feldern ein, damit sie hervorstechen.';

  @override
  String get ideasStainedGlassStep5 =>
      'Wenn alles trocken ist, fahre die Ränder mit dicken Linien aus schwarzem Liner oder Brush Pen nach.';

  @override
  String get ideasStainedGlassStep6 =>
      'Setze auf einigen Feldern einen kleinen Strich mit weißem Gelstift, um den Glanz des Glases anzudeuten.';

  @override
  String get ideasSwatchChartTitle => 'Deine eigene Farbkarte';

  @override
  String get ideasSwatchChartSummary =>
      'Teste, wie jeder Marker mit einer, zwei und drei Schichten aussieht.';

  @override
  String get ideasSwatchChartPractice =>
      'Wissen, wie deine Marker wirklich auf dem Papier aussehen, nicht auf der Kappe.';

  @override
  String get ideasSwatchChartSubject =>
      'Ein Raster mit einer Zeile pro Marker, nach Farbfamilie gruppiert.';

  @override
  String get ideasSwatchChartTip =>
      'Mach die Karte auf dem Papier, das du wirklich nutzt: Derselbe Marker wirkt auf verschiedenen Papieren sehr unterschiedlich.';

  @override
  String get ideasSwatchChartStep1 =>
      'Zeichne auf deinem üblichen Papier ein Raster: eine Zeile pro Marker und vier Quadrate pro Zeile.';

  @override
  String get ideasSwatchChartStep2 =>
      'Fülle das erste Quadrat mit einer Schicht, das zweite mit zwei und das dritte mit drei, und lass jede Schicht trocknen.';

  @override
  String get ideasSwatchChartStep3 =>
      'Trage im vierten Quadrat eine Schicht auf und hebe einen Teil der Tinte mit dem farblosen Blender ab.';

  @override
  String get ideasSwatchChartStep4 =>
      'Schreibe den Code mit Bleistift oder Liner unter jede Zeile.';

  @override
  String get ideasSwatchChartStep5 =>
      'Markiere im Tab Farbmuster die Marker, die du besitzt, und vergleiche sie mit deiner Karte.';

  @override
  String get ideasOneColorTitle => 'Eine Farbfamilie';

  @override
  String get ideasOneColorSummary =>
      'Zeichne eine ganze Szene mit vier Markern einer einzigen Farbfamilie.';

  @override
  String get ideasOneColorPractice =>
      'Tiefe mit Schichten sowie helleren und dunkleren Markern aufbauen.';

  @override
  String get ideasOneColorSubject =>
      'Eine dampfende Tasse Tee oder eine kleine Topfpflanze.';

  @override
  String get ideasOneColorTip =>
      'Leichter Druck macht einen Marker nicht heller. Für helle Stellen nimm den helleren Marker oder den farblosen Blender.';

  @override
  String get ideasOneColorStep1 =>
      'Wähle ein einfaches Motiv und markiere mit Bleistift, woher das Licht kommt.';

  @override
  String get ideasOneColorStep2 =>
      'Bedecke alles außer den Glanzlichtern mit dem hellsten Marker.';

  @override
  String get ideasOneColorStep3 =>
      'Trage den Basismarker auf die vom Licht abgewandten Teile auf.';

  @override
  String get ideasOneColorStep4 =>
      'Setze den Schattenmarker in die dunkelsten Bereiche und verblende die Ränder, solange sie nass sind.';

  @override
  String get ideasOneColorStep5 =>
      'Spare den dunkelsten Marker für Kontaktschatten und ein paar kleine Details auf.';

  @override
  String get ideasOneColorStep6 =>
      'Um einen Ton abzudunkeln, ohne den Marker zu wechseln, trage nach dem Trocknen der ersten eine weitere Schicht desselben auf.';

  @override
  String get ideasTwoMarkersTitle => 'Zwei-Marker-Challenge';

  @override
  String get ideasTwoMarkersSummary =>
      'Nur ein heller und ein dunkler Marker, sonst nichts.';

  @override
  String get ideasTwoMarkersPractice =>
      'Vor dem Start entscheiden, was hell bleibt und was dunkel wird.';

  @override
  String get ideasTwoMarkersSubject =>
      'Ein Pilz, eine sitzende Katze oder ein Haus mit Dach.';

  @override
  String get ideasTwoMarkersTip =>
      'Mit nur zwei Markern leistet das Weiß des Papiers viel: Plane es von Anfang an ein.';

  @override
  String get ideasTwoMarkersStep1 =>
      'Mach zuerst eine kleine Skizze und entscheide, welche Bereiche hell und welche dunkel sind.';

  @override
  String get ideasTwoMarkersStep2 =>
      'Bedecke alles außer den Glanzlichtern mit dem hellen Marker.';

  @override
  String get ideasTwoMarkersStep3 =>
      'Trage auf den Halbschatten eine zweite Schicht des hellen Markers auf.';

  @override
  String get ideasTwoMarkersStep4 =>
      'Nutze den dunklen Marker nur für die tiefsten Schatten und ein paar Details.';

  @override
  String get ideasTwoMarkersStep5 =>
      'Lass das weiße Papier an den hellsten Stellen stehen: Es ist dein dritter Ton.';

  @override
  String get ideasTwoColorsTitle => 'Zwei Gegenfarben';

  @override
  String get ideasTwoColorsSummary =>
      'Nutze zwei Gegenfarben und ein Grau und halte sie getrennt.';

  @override
  String get ideasTwoColorsPractice =>
      'Mit Gegenfarben umgehen, die beim Überlappen schmutzig werden.';

  @override
  String get ideasTwoColorsSubject =>
      'Eine Orange auf einem blauen Tuch oder eine rote Blume mit grünen Blättern.';

  @override
  String get ideasTwoColorsTip =>
      'Zwei Gegenfarben übereinander werden grau oder braun. Nutze das nur dort, wo du einen stumpfen Schatten willst.';

  @override
  String get ideasTwoColorsStep1 =>
      'Entscheide, welche Bereiche zu welcher Farbe gehören, und halte sie als getrennte Formen.';

  @override
  String get ideasTwoColorsStep2 =>
      'Male die Formen der ersten Farbe von hell nach dunkel.';

  @override
  String get ideasTwoColorsStep3 =>
      'Füge ihren Schatten hinzu, solange die erste Schicht noch feucht ist.';

  @override
  String get ideasTwoColorsStep4 =>
      'Lass alles ganz trocknen, male dann die Formen der zweiten Farbe und höre an der Grenze auf.';

  @override
  String get ideasTwoColorsStep5 =>
      'Füge den Schatten der zweiten Farbe auf dieselbe Weise hinzu.';

  @override
  String get ideasTwoColorsStep6 =>
      'Nutze das Grau für Schatten, die von einer Farbe in die andere übergehen.';

  @override
  String get ideasFiftyFiftyTitle => 'Halb warm, halb kühl';

  @override
  String get ideasFiftyFiftySummary =>
      'Teile eine Zeichnung in zwei Hälften: warme Farben auf der einen Seite, kühle auf der anderen.';

  @override
  String get ideasFiftyFiftyPractice =>
      'Sehen, wie warme und kühle Farben die Stimmung desselben Motivs verändern.';

  @override
  String get ideasFiftyFiftySubject =>
      'Ein Gesicht oder ein Haus, in der Mitte geteilt.';

  @override
  String get ideasFiftyFiftyTip =>
      'Nasse Kanten laufen ineinander: Lass nie eine nasse warme Fläche eine nasse kühle berühren.';

  @override
  String get ideasFiftyFiftyStep1 =>
      'Zeichne dein Motiv und eine Linie, die es in zwei Hälften teilt.';

  @override
  String get ideasFiftyFiftyStep2 =>
      'Male zuerst die warme Hälfte von hell nach dunkel.';

  @override
  String get ideasFiftyFiftyStep3 =>
      'Füge ihre Schatten hinzu und lass die ganze Hälfte vollständig trocknen.';

  @override
  String get ideasFiftyFiftyStep4 =>
      'Male die kühle Hälfte und höre einen Millimeter vor der Linie auf; schließe die Lücke, wenn die andere Seite trocken ist.';

  @override
  String get ideasFiftyFiftyStep5 =>
      'Setze die kühlen Schatten an dieselben Stellen wie auf der warmen Hälfte.';

  @override
  String get ideasFiftyFiftyStep6 =>
      'Nutze das Grau nur an den dunkelsten Stellen, damit beide Hälften es teilen.';

  @override
  String get ideasRandomColorsTitle => 'Fünf Zufallsmarker';

  @override
  String get ideasRandomColorsSummary =>
      'Zeichne irgendetwas mit fünf Markern, die zufällig aus deiner Sammlung gezogen werden.';

  @override
  String get ideasRandomColorsPractice =>
      'Beliebige Farben zusammenwirken lassen, indem du Hell und Dunkel steuerst.';

  @override
  String get ideasRandomColorsSubject =>
      'Was du magst: ein Vogel, eine Teekanne oder ein Monster.';

  @override
  String get ideasRandomColorsTip =>
      'Hell und Dunkel zählen mehr als die Farbe: Eine Zeichnung mit klarem Kontrast funktioniert mit fast allen Farben.';

  @override
  String get ideasRandomColorsStep1 =>
      'Sieh dir die fünf Marker oben an: Sie sind von hell nach dunkel sortiert.';

  @override
  String get ideasRandomColorsStep2 =>
      'Nutze den hellsten für die großen beleuchteten Flächen.';

  @override
  String get ideasRandomColorsStep3 =>
      'Nutze die mittleren für die Hauptformen.';

  @override
  String get ideasRandomColorsStep4 =>
      'Spare den dunkelsten für Schatten und Konturen auf.';

  @override
  String get ideasRandomColorsStep5 =>
      'Beißen sich zwei Farben, trenne sie mit einer dünnen Linie aus weißem Papier.';

  @override
  String get ideasRandomColorsStep6 =>
      'Tippe auf Andere Marker für eine neue Auswahl und versuche es noch einmal.';

  @override
  String get ideasUnlikelyColorsTitle => 'Unerwartete Farben';

  @override
  String get ideasUnlikelyColorsSummary =>
      'Male einen vertrauten Gegenstand in Farben, die nicht seine eigenen sind.';

  @override
  String get ideasUnlikelyColorsPractice =>
      'Hell und Dunkel richtig halten, damit der Gegenstand lesbar bleibt, egal welche Farbe er hat.';

  @override
  String get ideasUnlikelyColorsSubject =>
      'Eine Banane, ein Hund oder dein eigener Sneaker.';

  @override
  String get ideasUnlikelyColorsTip =>
      'Wenn die Zeichnung beim Blinzeln noch lesbar ist, stimmen Hell und Dunkel, egal welche Farben du nutzt.';

  @override
  String get ideasUnlikelyColorsStep1 =>
      'Zeichne den Gegenstand nach der Natur oder einem Foto und achte auf seine hellen und dunklen Bereiche.';

  @override
  String get ideasUnlikelyColorsStep2 =>
      'Nutze den hellsten Marker dort, wo der echte Gegenstand am hellsten ist.';

  @override
  String get ideasUnlikelyColorsStep3 =>
      'Nutze die Basis dort, wo der echte Gegenstand seine Mitteltöne hat.';

  @override
  String get ideasUnlikelyColorsStep4 =>
      'Nutze den Schattenmarker dort, wo der echte Gegenstand am dunkelsten ist.';

  @override
  String get ideasUnlikelyColorsStep5 =>
      'Setze den Akzent auf eine kleine Stelle, die den Blick fängt.';

  @override
  String get ideasPastelTitle => 'Zarte Pastelle';

  @override
  String get ideasPastelSummary =>
      'Male eine zarte, luftige Zeichnung mit hellen Markern und viel weißem Papier.';

  @override
  String get ideasPastelPractice =>
      'Helle, gleichmäßige Schichten und das Weiß des Papiers bewahren.';

  @override
  String get ideasPastelSubject =>
      'Ein Cupcake, ein Häschen oder ein Blumenstrauß.';

  @override
  String get ideasPastelTip =>
      'Leichter Druck macht einen Marker nicht heller: Wähle stattdessen einen helleren Marker.';

  @override
  String get ideasPastelStep1 =>
      'Wähle ein sanftes Motiv und halte die Bleistiftlinien sehr leicht.';

  @override
  String get ideasPastelStep2 =>
      'Entscheide, wo das Papier weiß bleibt: die Glanzlichter und ein Teil des Hintergrunds.';

  @override
  String get ideasPastelStep3 =>
      'Male jeden Bereich mit einem hellen Marker in einer einzigen gleichmäßigen Schicht, in kleinen Kreisen.';

  @override
  String get ideasPastelStep4 =>
      'Mach den Schatten mit einer zweiten Schicht desselben Markers, nicht mit einer dunkleren Farbe.';

  @override
  String get ideasPastelStep5 =>
      'Nutze den etwas tieferen Marker nur für die kleinsten Schatten.';

  @override
  String get ideasPastelStep6 =>
      'Mildere harte Kanten mit dem farblosen Blender.';

  @override
  String get ideasSkinTonesTitle => 'Haut mit vier Markern';

  @override
  String get ideasSkinTonesSummary =>
      'Male ein Gesicht mit einem hellen Ton, einer Basis, einem Schatten und einer Röte.';

  @override
  String get ideasSkinTonesPractice =>
      'Weiches Verblenden der Haut und warme Schatten im Gesicht.';

  @override
  String get ideasSkinTonesSubject =>
      'Ein Gesicht in Dreiviertelansicht, von einer Seite beleuchtet.';

  @override
  String get ideasSkinTonesTip =>
      'Hautschatten sind warm: Meide Grautöne, sie lassen das Gesicht schmutzig wirken.';

  @override
  String get ideasSkinTonesStep1 =>
      'Zeichne das Gesicht leicht vor und markiere die Schattenformen: unter der Braue, neben der Nase, unter der Lippe und entlang des Kiefers.';

  @override
  String get ideasSkinTonesStep2 =>
      'Bedecke die ganze Haut mit dem hellen Marker und lass die hellsten Stellen von Stirn, Nase und Wange als weißes Papier frei.';

  @override
  String get ideasSkinTonesStep3 =>
      'Füge noch feucht die Röte auf Wangen, Nasenspitze und Ohren hinzu.';

  @override
  String get ideasSkinTonesStep4 =>
      'Setze die Basis auf die Schattenformen und verblende ihre Ränder mit dem hellen Marker.';

  @override
  String get ideasSkinTonesStep5 =>
      'Nutze den Schattenmarker nur dort, wo Formen aufeinandertreffen: unter dem Kinn, im Ohr und um die Nasenlöcher.';

  @override
  String get ideasSkinTonesStep6 =>
      'Mildere harte Linien mit dem hellen Marker statt mit dem farblosen Blender, damit die Haut nicht fleckig wird.';

  @override
  String get ideasMidnightTitle => 'Mondnacht';

  @override
  String get ideasMidnightSummary =>
      'Ein kleines Haus bei Nacht, vom Mond und einem warmen Fenster beleuchtet.';

  @override
  String get ideasMidnightPractice =>
      'Eine Nachtszene planen: kühle Schatten und ein paar saubere, warme Lichter.';

  @override
  String get ideasMidnightSubject =>
      'Ein kleines Haus bei Nacht mit einem erleuchteten Fenster.';

  @override
  String get ideasMidnightTip =>
      'Lass Blau und Gelb sich nicht berühren, solange eines nass ist: Zusammen werden sie grün.';

  @override
  String get ideasMidnightStep1 =>
      'Entscheide vor dem Start, wo die Lichter sind: Mond und Fenster bleiben weißes Papier.';

  @override
  String get ideasMidnightStep2 =>
      'Male das Fenster und einen weichen Schein darum mit dem Gelb und lass es ganz trocknen.';

  @override
  String get ideasMidnightStep3 =>
      'Bedecke den Himmel und die beleuchteten Wände mit dem hellen Blau und arbeite vom Mond weg.';

  @override
  String get ideasMidnightStep4 =>
      'Trage das Basisblau auf alles im Schatten auf, einige Millimeter vom gelben Schein entfernt.';

  @override
  String get ideasMidnightStep5 =>
      'Dunkle den Himmel nach oben hin ab, ebenso die Schatten unter dem Dach und den Bäumen.';

  @override
  String get ideasMidnightStep6 =>
      'Nutze den dunkelsten Marker für die tiefsten Schatten und setze nach dem Trocknen mit weißem Gelstift ein paar Sterne.';

  @override
  String get ideasUnderwaterTitle => 'Unter Wasser';

  @override
  String get ideasUnderwaterSummary =>
      'Sonnenstrahlen in blauem Wasser um einen kleinen Fisch.';

  @override
  String get ideasUnderwaterPractice =>
      'Lichtstrahlen mit dem farblosen Blender herausheben.';

  @override
  String get ideasUnderwaterSubject =>
      'Ein kleiner Fisch, der über einer Koralle schwimmt.';

  @override
  String get ideasUnderwaterTip =>
      'Probiere die Blender-Strahlen zuerst auf einem Schmierblatt: Sie funktionieren nur, solange die Tinte noch leicht feucht ist.';

  @override
  String get ideasUnderwaterStep1 =>
      'Male zuerst den Fisch und die Koralle mit dem Akzent und lass sie trocknen.';

  @override
  String get ideasUnderwaterStep2 =>
      'Bedecke das Wasser mit dem hellen Blau und höre knapp vor dem Fisch auf.';

  @override
  String get ideasUnderwaterStep3 =>
      'Trage das Basisblau auf die untere Hälfte auf und verblende es nach oben, solange es nass ist.';

  @override
  String get ideasUnderwaterStep4 =>
      'Dunkle den Boden und den Bereich hinter dem Fisch ab, damit er hervortritt.';

  @override
  String get ideasUnderwaterStep5 =>
      'Zieh mit dem farblosen Blender diagonale Strahlen von der Oberfläche nach unten, solange die Blautöne noch feucht sind: Er schiebt die Tinte weg.';

  @override
  String get ideasUnderwaterStep6 =>
      'Setze den dunkelsten Marker ganz unten ein und male nach dem Trocknen winzige Blasen mit weißem Gelstift.';

  @override
  String get ideasGalaxyTitle => 'Galaxie';

  @override
  String get ideasGalaxySummary =>
      'Verblende leuchtende Nebelfarben in einen dunklen Himmel und setze zum Schluss Sterne.';

  @override
  String get ideasGalaxyPractice =>
      'Nass in nass verblenden und Tinte abheben, um Sterne zu erzeugen.';

  @override
  String get ideasGalaxySubject =>
      'Ein Nebel über der Silhouette eines Berges.';

  @override
  String get ideasGalaxyTip =>
      'Halte die großen Sterne auf eine Handvoll begrenzt: Zu viele machen die Tiefe flach.';

  @override
  String get ideasGalaxyStep1 =>
      'Nimm Markerpapier, das nicht durchschlägt, und lege ein Blatt darunter: Diese Übung braucht viel Tinte.';

  @override
  String get ideasGalaxyStep2 =>
      'Beginne mit den hellsten Nebelfarben in weichen, unregelmäßigen Wolken.';

  @override
  String get ideasGalaxyStep3 =>
      'Verblende die mittlere Farbe in ihre Ränder, solange sie noch nass sind.';

  @override
  String get ideasGalaxyStep4 =>
      'Fülle den Rest des Himmels mit den dunkelsten Markern und arbeite auf die Wolken zu, nicht über sie.';

  @override
  String get ideasGalaxyStep5 =>
      'Tupfe den farblosen Blender auf die dunklen Bereiche, um kleine Tintenpunkte abzuheben: Das werden ferne Sterne.';

  @override
  String get ideasGalaxyStep6 =>
      'Setze nach dem Trocknen mit weißem Gelstift ein paar helle Sterne und ein kreuzförmiges Funkeln.';

  @override
  String get ideasNeonTitle => 'Neonschild';

  @override
  String get ideasNeonSummary =>
      'Lass ein Schild mit weißem Kern und dunklem Hintergrund leuchten.';

  @override
  String get ideasNeonPractice =>
      'Leuchten: ein weißer Kern, ein heller Hof und ein dunkler Hintergrund.';

  @override
  String get ideasNeonSubject => 'Das Wort OPEN oder ein Herz als Neonröhre.';

  @override
  String get ideasNeonTip =>
      'Neonmarker sind durchsichtig: Nutze sie auf Weiß, nie über dunkler Tinte.';

  @override
  String get ideasNeonStep1 =>
      'Zeichne ein einfaches Wort oder eine Form mit dicken Strichen vor.';

  @override
  String get ideasNeonStep2 =>
      'Lass in der Mitte jedes Strichs eine dünne Linie weißes Papier frei: Das ist der heiße Kern.';

  @override
  String get ideasNeonStep3 =>
      'Male den Rest des Strichs mit der hellen Version deiner Neonfarbe.';

  @override
  String get ideasNeonStep4 =>
      'Ziehe die leuchtende Farbe vom Strich nach außen, um einen weichen Hof zu erzeugen.';

  @override
  String get ideasNeonStep5 =>
      'Wenn der Hof trocken ist, fülle den Hintergrund mit dem dunkelsten Marker und höre einige Millimeter vor dem Hof auf.';

  @override
  String get ideasNeonStep6 =>
      'Verblende diese Lücke mit dem dunklen Marker, damit das Leuchten in die Nacht ausläuft.';

  @override
  String get ideasSepiaPhotoTitle => 'Altes Sepiafoto';

  @override
  String get ideasSepiaPhotoSummary =>
      'Zeichne ein Porträt oder ein Gebäude, als wäre es ein altes braunes Foto.';

  @override
  String get ideasSepiaPhotoPractice =>
      'Mit einer warmen Familie aus Brauntönen arbeiten, wie eine Hell-Dunkel-Studie in Farbe.';

  @override
  String get ideasSepiaPhotoSubject =>
      'Ein altes Haus, ein Cowboyhut oder ein Porträt eines Großelternteils.';

  @override
  String get ideasSepiaPhotoTip =>
      'Meide Schwarz und kühle Grautöne: Sie zerstören den warmen Sepia-Look.';

  @override
  String get ideasSepiaPhotoStep1 =>
      'Zeichne das Motiv vor und umrahme es mit einem Rand, der weißes Papier bleibt.';

  @override
  String get ideasSepiaPhotoStep2 =>
      'Bedecke alles außer den hellsten Stellen mit dem hellsten Braun.';

  @override
  String get ideasSepiaPhotoStep3 =>
      'Baue die Mitteltöne mit dem Basisbraun auf.';

  @override
  String get ideasSepiaPhotoStep4 =>
      'Füge die Schatten mit dem Schattenbraun hinzu und verblende die Ränder, solange sie nass sind.';

  @override
  String get ideasSepiaPhotoStep5 =>
      'Nutze das dunkelste Braun statt Schwarz für die tiefsten Schatten.';

  @override
  String get ideasSepiaPhotoStep6 =>
      'Dunkle die Ecken des Bildes leicht mit dem warmen Grau ab, damit es alt wirkt.';

  @override
  String get ideasSunsetTitle => 'Abendhimmel';

  @override
  String get ideasSunsetSummary =>
      'Verblende einen Himmel von Gelb zu Violett und füge eine dunkle Silhouette hinzu.';

  @override
  String get ideasSunsetPractice =>
      'Benachbarte Farben nass in nass auf einer großen Fläche verblenden.';

  @override
  String get ideasSunsetSubject =>
      'Ein Sonnenuntergang über dem Meer mit einer Palme oder einer Skyline als Silhouette.';

  @override
  String get ideasSunsetTip =>
      'Verblende nur benachbarte Farben: Gelb neben Violett wird im nassen Zustand bräunlich.';

  @override
  String get ideasSunsetStep1 =>
      'Zeichne Horizont und Silhouette vor; lass die Sonne als Kreis aus weißem Papier.';

  @override
  String get ideasSunsetStep2 =>
      'Beginne bei der Sonne: Male ein breites gelbes Band um sie herum.';

  @override
  String get ideasSunsetStep3 =>
      'Trage über dem noch nassen Gelb das Orange auf und verblende den Übergang.';

  @override
  String get ideasSunsetStep4 =>
      'Arbeite mit dem Rosa nach oben weiter und verblende jedes Band in das letzte, solange es nass ist.';

  @override
  String get ideasSunsetStep5 =>
      'Schließe den oberen Himmel mit dem Violett ab.';

  @override
  String get ideasSunsetStep6 =>
      'Wenn der Himmel trocken ist, fülle die Silhouette mit dem dunkelsten Marker in flachen, gleichmäßigen Strichen.';

  @override
  String get ideasSpringTitle => 'Frühlingsblüte';

  @override
  String get ideasSpringSummary =>
      'Ein Kirschblütenzweig mit zarten rosa Blütenblättern.';

  @override
  String get ideasSpringPractice =>
      'Zarte Blütenblätter: helle Schichten und weiche Kanten.';

  @override
  String get ideasSpringSubject =>
      'Ein Zweig mit fünf oder sechs Blüten und ein paar Blättern.';

  @override
  String get ideasSpringTip =>
      'Blütenblätter sind dünn: Zwei helle Schichten wirken zarter als eine dunkle.';

  @override
  String get ideasSpringStep1 =>
      'Zeichne den Zweig und die Blüten leicht, jeweils mit fünf Blütenblättern.';

  @override
  String get ideasSpringStep2 =>
      'Male jedes Blütenblatt mit dem hellen Rosa und lass bei einigen einen dünnen weißen Rand.';

  @override
  String get ideasSpringStep3 =>
      'Trage das Basisrosa nahe der Mitte jeder Blüte auf und ziehe es nach außen aus.';

  @override
  String get ideasSpringStep4 =>
      'Setze das tiefste Rosa nur in die Mitte und dorthin, wo sich Blütenblätter überlappen.';

  @override
  String get ideasSpringStep5 =>
      'Male die Blätter und die jungen Triebe mit dem Grün.';

  @override
  String get ideasSpringStep6 =>
      'Schattiere die Blattunterseiten mit dem dunklen Grün.';

  @override
  String get ideasAutumnTitle => 'Herbstblätter';

  @override
  String get ideasAutumnSummary =>
      'Ein Stillleben aus gefallenen Blättern in warmen, leuchtenden Farben.';

  @override
  String get ideasAutumnPractice =>
      'Benachbarte warme Farben verblenden und die Blattadern hell halten.';

  @override
  String get ideasAutumnSubject =>
      'Drei gefallene Blätter auf einem Tisch: Eiche, Ahorn und Kastanie.';

  @override
  String get ideasAutumnTip =>
      'Lass die Adern als hellere Linie stehen: Das ist einfacher, als sie später darüberzuzeichnen.';

  @override
  String get ideasAutumnStep1 =>
      'Zeichne die Blätter und ihre Hauptadern mit leichtem Bleistift vor.';

  @override
  String get ideasAutumnStep2 =>
      'Male das hellste Blatt mit dem Gelb und umfahre die Adern, damit sie hell bleiben.';

  @override
  String get ideasAutumnStep3 =>
      'Male das nächste Blatt mit dem hellen Orange und verblende nass etwas Gelb in seine Ränder.';

  @override
  String get ideasAutumnStep4 =>
      'Male das dritte Blatt mit der Basis und verblende das helle Orange in seine Spitze.';

  @override
  String get ideasAutumnStep5 =>
      'Setze das Rot an den Rändern und in ein paar Flecken auf, als würde sich das Blatt verfärben.';

  @override
  String get ideasAutumnStep6 =>
      'Schattiere mit dem dunklen Orange dort, wo sich die Blätter überlappen und den Tisch berühren.';

  @override
  String get ideasWinterTitle => 'Verschneite Hütte';

  @override
  String get ideasWinterSummary =>
      'Eine Hütte im Schnee, bei der das Weiß das Papier selbst ist.';

  @override
  String get ideasWinterPractice =>
      'Schnee mit blaugrauen Schatten und viel weißem Papier zeichnen.';

  @override
  String get ideasWinterSubject =>
      'Eine Holzhütte mit Schnee auf dem Dach und einem erleuchteten Fenster.';

  @override
  String get ideasWinterTip =>
      'Schattiere Schnee nicht mit warmem Grau: Blaugrau lässt ihn kalt und sauber wirken.';

  @override
  String get ideasWinterStep1 =>
      'Zeichne die Hütte vor und wo der Schnee endet: Der Schnee ist weißes Papier, plane ihn also zuerst.';

  @override
  String get ideasWinterStep2 =>
      'Male das Fenster mit dem Gelb und lass es trocknen.';

  @override
  String get ideasWinterStep3 =>
      'Male die Holzwände mit dem Braun, ohne den Schnee auf dem Dach zu berühren.';

  @override
  String get ideasWinterStep4 =>
      'Schattiere den Schnee mit dem hellen Blaugrau nur dort, wo das Licht nicht hinkommt.';

  @override
  String get ideasWinterStep5 =>
      'Setze das dunklere Blaugrau unter das Dach und in die Fußspuren und verblende es in das helle.';

  @override
  String get ideasWinterStep6 =>
      'Nutze den dunkelsten Marker für die Tür und die tiefsten Schatten und male nach dem Trocknen mit weißem Gelstift fallenden Schnee.';

  @override
  String get ideasChristmasTitle => 'Weihnachtskugeln';

  @override
  String get ideasChristmasSummary =>
      'Glänzende rote Kugeln an einem grünen Tannenzweig.';

  @override
  String get ideasChristmasPractice =>
      'Runde, glänzende Formen mit ausgespartem Glanzlicht und Spiegelungen.';

  @override
  String get ideasChristmasSubject => 'Zwei rote Kugeln an einem Tannenzweig.';

  @override
  String get ideasChristmasTip =>
      'Zeichne den Zweig nach den Kugeln, damit das Grün nie ins Rot läuft.';

  @override
  String get ideasChristmasStep1 =>
      'Zeichne die Kugeln und plane auf jeder ein fensterförmiges Glanzlicht.';

  @override
  String get ideasChristmasStep2 =>
      'Bedecke jede Kugel mit dem hellen Rot und umfahre das Glanzlicht.';

  @override
  String get ideasChristmasStep3 =>
      'Trage das Basisrot in einem Ring auf, der der runden Form folgt, und lass die Mitte heller.';

  @override
  String get ideasChristmasStep4 =>
      'Dunkle den vom Licht am weitesten entfernten Rand ab und lass einen dünnen helleren Saum für die Spiegelung.';

  @override
  String get ideasChristmasStep5 =>
      'Ziehe die Nadeln des Zweigs mit dem Grün vom Stiel nach außen.';

  @override
  String get ideasChristmasStep6 =>
      'Füge das dunkle Grün dort hinzu, wo sich die Nadeln überlappen, und setze nach dem Trocknen einen weißen Gelfunken auf jede Kugel.';

  @override
  String get ideasHalloweenTitle => 'Halloween-Kürbis';

  @override
  String get ideasHalloweenSummary =>
      'Ein leuchtender geschnitzter Kürbis in einer dunkelvioletten Nacht.';

  @override
  String get ideasHalloweenPractice =>
      'Licht, das aus dem Inneren eines Gegenstands kommt, vor dunklem Hintergrund.';

  @override
  String get ideasHalloweenSubject =>
      'Ein geschnitzter Kürbis mit einer Kerze darin, auf einer Türschwelle.';

  @override
  String get ideasHalloweenTip =>
      'Male den dunklen Hintergrund zuletzt und am Rand langsam: Dunkle Tinte läuft in helle Bereiche.';

  @override
  String get ideasHalloweenStep1 =>
      'Zeichne den Kürbis und sein geschnitztes Gesicht; das Innere des Gesichts wird der hellste Teil.';

  @override
  String get ideasHalloweenStep2 =>
      'Male die ausgeschnittenen Löcher mit dem hellen Orange und lass in der Mitte einen weißen Kern.';

  @override
  String get ideasHalloweenStep3 =>
      'Male den Kürbis mit dem Basisorange und folge seinen Rippen mit gebogenen Strichen.';

  @override
  String get ideasHalloweenStep4 =>
      'Schattiere die Furchen zwischen den Rippen und die vom Schein abgewandte Seite.';

  @override
  String get ideasHalloweenStep5 => 'Male den Stiel mit dem Grün.';

  @override
  String get ideasHalloweenStep6 =>
      'Wenn alles trocken ist, fülle die Nacht mit dem dunklen Violett und beginne einige Millimeter vom Kürbis entfernt.';

  @override
  String get ideasRoleLight => 'Hell';

  @override
  String get ideasReasonLight => 'Erste Schicht, über fast alles';

  @override
  String get ideasRoleLightMid => 'Mittelhell';

  @override
  String get ideasReasonLightMid =>
      'Zweiter Schritt, mildert den Sprung zur Basis';

  @override
  String get ideasRoleBase => 'Basis';

  @override
  String get ideasReasonBase => 'Hauptfarbe der Formen';

  @override
  String get ideasRoleShadow => 'Schatten';

  @override
  String get ideasReasonShadow => 'Wo das Licht nicht hinkommt';

  @override
  String get ideasRoleDeepShadow => 'Tiefer Schatten';

  @override
  String get ideasReasonDeepShadow =>
      'Nur die dunkelsten Ecken und Kontaktlinien';

  @override
  String get ideasRoleShadowGray => 'Schattengrau';

  @override
  String get ideasReasonShadowGray => 'Neutrale Schatten und Schlagschatten';

  @override
  String get ideasRoleAccent => 'Akzent';

  @override
  String get ideasReasonAccent => 'Kleine Tupfer, die den Blick lenken';

  @override
  String get ideasRoleBackground => 'Hintergrund';

  @override
  String get ideasReasonBackground => 'Um das Motiv herum, zuletzt aufgetragen';

  @override
  String get ideasRoleMainColor => 'Hauptfarbe';

  @override
  String get ideasReasonMainColor => 'Erste Farbe des Paares';

  @override
  String get ideasRoleMainShadow => 'Hauptschatten';

  @override
  String get ideasReasonMainShadow => 'Schatten der ersten Farbe';

  @override
  String get ideasRoleSecondColor => 'Zweite Farbe';

  @override
  String get ideasReasonSecondColor => 'Zweite Farbe des Schemas';

  @override
  String get ideasRoleSecondShadow => 'Zweiter Schatten';

  @override
  String get ideasReasonSecondShadow => 'Schatten der zweiten Farbe';

  @override
  String get ideasRoleThirdColor => 'Dritte Farbe';

  @override
  String get ideasReasonThirdColor => 'Dritte Farbe des Schemas';

  @override
  String get ideasRoleBlush => 'Röte';

  @override
  String get ideasReasonBlush => 'Wangen, Nase und Ohren, nass verblendet';

  @override
  String get ideasRoleWarmLight => 'Warmes Licht';

  @override
  String get ideasReasonWarmLight => 'Beleuchtete Bereiche der warmen Hälfte';

  @override
  String get ideasRoleWarmShadow => 'Warmer Schatten';

  @override
  String get ideasReasonWarmShadow => 'Schatten der warmen Hälfte';

  @override
  String get ideasRoleCoolLight => 'Kühles Licht';

  @override
  String get ideasReasonCoolLight => 'Beleuchtete Bereiche der kühlen Hälfte';

  @override
  String get ideasRoleCoolShadow => 'Kühler Schatten';

  @override
  String get ideasReasonCoolShadow => 'Schatten der kühlen Hälfte';

  @override
  String get ideasRoleColorShadow => 'Farbiger Schatten';

  @override
  String get ideasReasonColorShadow =>
      'Ein farbiger Schatten zum Vergleich mit dem grauen';

  @override
  String get matchTitle => 'Abgleich';

  @override
  String get matchPrivacyCaption => 'Fotos bleiben auf diesem Handy.';

  @override
  String get matchCameraButton => 'Kamera';

  @override
  String get matchGalleryButton => 'Galerie';

  @override
  String get matchLoadingPhoto => 'Foto wird gelesen …';

  @override
  String get matchEmptyPhotoTitle => 'Eine Farbe aus einem Foto finden';

  @override
  String get matchEmptyPhotoMessage =>
      'Mach ein Foto, tippe auf eine Farbe darin und sieh dir die nächsten Marker an.';

  @override
  String get matchPhotoSemantics => 'Foto zum Abtasten einer Farbe';

  @override
  String get matchPickToSample =>
      'Tippe oder ziehe auf dem Foto, um eine Farbe abzutasten.';

  @override
  String get matchSampledLabel => 'Abgetastet';

  @override
  String get matchBestMatchTitle => 'Beste Übereinstimmung';

  @override
  String get matchAlternatesTitle => 'Alternativen';

  @override
  String get matchSaveButton => 'Speichern';

  @override
  String get matchRecentTitle => 'Letzte Auswahlen';

  @override
  String get matchRecentDetailSampled => 'Abgetastet';

  @override
  String get matchRecentEmpty =>
      'Noch keine letzten Auswahlen. Tippe auf einen Treffer, um ihn hier zu speichern.';

  @override
  String get matchClearButton => 'Leeren';

  @override
  String get matchRemoveTooltip => 'Entfernen';

  @override
  String get matchCloseTooltip => 'Schließen';

  @override
  String get matchRecentPickLabel => 'Letzte Auswahl';

  @override
  String get matchClearDialogTitle => 'Letzte Auswahlen leeren?';

  @override
  String get matchClearDialogBody =>
      'Alle gespeicherten Auswahlen werden entfernt. Das lässt sich nicht rückgängig machen.';

  @override
  String get matchCancelButton => 'Abbrechen';

  @override
  String get matchCancelNotice => 'Kein Foto ausgewählt.';

  @override
  String get matchCameraDenied =>
      'Der Kamerazugriff ist aus. Erlaube ihn in den Geräteeinstellungen oder wähle stattdessen ein Foto aus der Galerie.';

  @override
  String get matchGalleryDenied =>
      'Der Fotozugriff ist aus. Erlaube ihn in den Geräteeinstellungen und versuche es dann erneut.';

  @override
  String get matchDecodeFailed =>
      'Dieses Foto konnte nicht gelesen werden. Versuche ein anderes.';

  @override
  String get matchPickFailed =>
      'Das Foto konnte nicht geöffnet werden. Versuche es erneut.';

  @override
  String get matchOkButton => 'OK';

  @override
  String get matchTakePhotoButton => 'Foto aufnehmen';

  @override
  String get matchChooseGalleryButton => 'Aus der Galerie wählen';

  @override
  String get matchValuesButton => 'Tonwerte';

  @override
  String get matchValuesTooltip =>
      'Foto und Treffer in Graustufen zeigen, um den Tonwertkontrast zu prüfen';

  @override
  String get matchPhotoSampleHint =>
      'Doppeltippen, um die Fotomitte abzutasten. Mit den Aktionen verschiebst du den Messpunkt.';

  @override
  String get matchSampleMiddle => 'Fotomitte abtasten';

  @override
  String get matchMoveLeft => 'Messpunkt nach links verschieben';

  @override
  String get matchMoveRight => 'Messpunkt nach rechts verschieben';

  @override
  String get matchMoveUp => 'Messpunkt nach oben verschieben';

  @override
  String get matchMoveDown => 'Messpunkt nach unten verschieben';

  @override
  String matchSampleSpoken(
    String hex,
    String code,
    String name,
    String quality,
  ) {
    return 'Abgetastete Farbe $hex. Nächster Marker: $code, $name, $quality.';
  }

  @override
  String matchSampleSpokenNone(String hex) {
    return 'Abgetastete Farbe $hex.';
  }

  @override
  String get appTitle => 'Ink Lab';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOwned => 'Besitze ich';

  @override
  String get commonFavourite => 'Favorit';

  @override
  String get commonAddToFavourites => 'Zu Favoriten hinzufügen';

  @override
  String get commonRemoveFromFavourites => 'Aus Favoriten entfernen';

  @override
  String get commonClearSearch => 'Suche leeren';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonMoreActions => 'Weitere Aktionen';

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
  String get commonBaseLocked => 'Basis gesperrt';

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
    return 'Alt $code';
  }

  @override
  String commonMarkersAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker verfügbar',
      one: '1 Marker verfügbar',
    );
    return '$_temp0';
  }

  @override
  String commonColorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Farben',
      one: '1 Farbe',
    );
    return '$_temp0';
  }

  @override
  String commonCardLocation(int number) {
    return 'Farbkarte $number';
  }

  @override
  String navTabHint(int index, int count) {
    return 'Tab $index von $count';
  }

  @override
  String get settingsLanguageTitle => 'Sprache';

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
    return '$owned von $total Markern';
  }

  @override
  String settingsPacksSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Packs ausgewählt',
      one: '1 Pack ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String settingsImportUnsupportedVersion(int version) {
    return 'Diese Sicherung hat die nicht unterstützte Version $version.';
  }

  @override
  String settingsImportFailed(String reason) {
    return 'Die Sicherung konnte nicht importiert werden: $reason';
  }

  @override
  String settingsAiOnDeviceProgressTotal(
    String bytes,
    String total,
    int percent,
  ) {
    return '$bytes von $total MB heruntergeladen ($percent %)';
  }

  @override
  String settingsAiOnDeviceProgressBytes(String bytes) {
    return '$bytes MB heruntergeladen';
  }

  @override
  String settingsAiConnectionOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Modelle',
      one: '1 Modell',
    );
    return 'Verbindung OK ($_temp0 verfügbar).';
  }

  @override
  String settingsAiConnectionFailed(String reason) {
    return 'Verbindung fehlgeschlagen: $reason';
  }

  @override
  String settingsAiFallbacksCount(int count, int max) {
    return '$count von $max';
  }

  @override
  String settingsAiUseTyped(String id) {
    return '„$id“ verwenden';
  }

  @override
  String settingsAiFallbacksHint(int max) {
    return 'Werden der Reihe nach versucht, wenn das obige Modell fehlschlägt (bis zu $max).';
  }

  @override
  String get settingsAiOnDeviceUnavailable =>
      'Die KI auf dem Gerät ist auf diesem Handy gerade nicht verfügbar. Bis dahin wird die Farbtheorie genutzt.';

  @override
  String get settingsAiOnDeviceNotEnabledIos =>
      'Um die KI auf dem Gerät zu nutzen, aktiviere Apple Intelligence unter Einstellungen → Apple Intelligence & Siri.';

  @override
  String paletteSizeChip(int size) {
    return '$size Farben';
  }

  @override
  String paletteAiLabel(String name) {
    return 'KI · $name';
  }

  @override
  String paletteAiLabelPartial(String name, int aiCount, int total) {
    return 'KI + Farbtheorie · $name · $aiCount/$total';
  }

  @override
  String paletteResultTitle(int count) {
    return 'Kombinationen ($count)';
  }

  @override
  String paletteSavedSubtitle(String mode, int size) {
    return '$mode · $size Farben';
  }

  @override
  String paletteSubtitleCustom(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker',
      one: '1 Marker',
    );
    return 'Eigene Palette · $_temp0';
  }

  @override
  String paletteSavedNotice(String name) {
    return 'Palette „$name“ gespeichert.';
  }

  @override
  String paletteLoadedNotice(String name) {
    return 'Palette „$name“ geladen.';
  }

  @override
  String paletteVariationApplied(String label) {
    return 'Variante $label angewendet.';
  }

  @override
  String paletteDraftApplied(int count) {
    return 'Ideen-Palette übernommen ($count Farben).';
  }

  @override
  String paletteUsingDefaultBase(String code, String scenario) {
    return '$code wird als Standardbasis für $scenario genutzt. Gib einen Code ein, um sie zu ändern.';
  }

  @override
  String paletteUnknownCode(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': '$input ist kein DecoTime-Markercode. Versuche $example.',
      'copic': '$input ist kein Copic-Markercode. Versuche $example.',
      'finecolour': '$input ist kein Finecolour-Markercode. Versuche $example.',
      'touchTwin': '$input ist kein Touch Twin-Markercode. Versuche $example.',
      'promarker': '$input ist kein Promarker-Markercode. Versuche $example.',
      'prismacolor':
          '$input ist kein Prismacolor Premier-Markercode. Versuche $example.',
      'spectrumNoir':
          '$input ist kein Spectrum Noir-Markercode. Versuche $example.',
      'promarkerBrush':
          '$input ist kein Promarker Brush-Markercode. Versuche $example.',
      'arrtx': '$input ist kein Arrtx-Markercode. Versuche $example.',
      'kurecolor':
          '$input ist kein ZIG Kurecolor-Markercode. Versuche $example.',
      'graphit': '$input ist kein Graph\'it-Markercode. Versuche $example.',
      'marvyLePlume':
          '$input ist kein Marvy Le Plume-Markercode. Versuche $example.',
      'blickBrush':
          '$input ist kein Blick Studio Brush-Markercode. Versuche $example.',
      'artistsLoft':
          '$input ist kein Artist\'s Loft-Markercode. Versuche $example.',
      'other': '$input ist kein Ink-Lab-Markercode. Versuche $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input ist nicht in deiner Sammlung. Versuche $example oder füge ihn in Meine Sammlung hinzu.',
      'copic':
          '$input ist nicht in deiner Sammlung. Versuche $example oder füge ihn in Meine Sammlung hinzu.',
      'finecolour':
          '$input ist nicht in deiner Sammlung. Versuche $example oder füge ihn in Meine Sammlung hinzu.',
      'other':
          '$input ist nicht in deiner Sammlung. Versuche $example oder füge ihn in Meine Sammlung hinzu.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'Du hast noch keine DecoTime-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'copic': 'Du hast noch keine Copic-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'finecolour': 'Du hast noch keine Finecolour-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'touchTwin': 'Du hast noch keine Touch Twin-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'promarker': 'Du hast noch keine Promarker-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'prismacolor': 'Du hast noch keine Prismacolor Premier-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'spectrumNoir': 'Du hast noch keine Spectrum Noir-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'promarkerBrush': 'Du hast noch keine Promarker Brush-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'arrtx': 'Du hast noch keine Arrtx-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'kurecolor': 'Du hast noch keine ZIG Kurecolor-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'graphit': 'Du hast noch keine Graph\'it-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'marvyLePlume': 'Du hast noch keine Marvy Le Plume-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'blickBrush': 'Du hast noch keine Blick Studio Brush-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'artistsLoft': 'Du hast noch keine Artist\'s Loft-Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
      'other': 'Du hast noch keine Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Wähle einen Basismarker, zum Beispiel $example, oder wähle Szenen als Palettentyp.';
  }

  @override
  String paletteBaseDried(String code) {
    return '$code ist ausgetrocknet. Markiere ihn unter „Details“ als nutzbar oder wähle einen anderen.';
  }

  @override
  String swatchesFiltersCount(int count) {
    return 'Filter · $count';
  }

  @override
  String swatchesCodeCopied(String code) {
    return '$code kopiert. Füge ihn im Tab Palette als Basisfarbe ein.';
  }

  @override
  String swatchesAlternativeSemantics(String code, String name, double value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String valueString = valueNumberFormat.format(value);

    return '$code, $name, Delta E $valueString';
  }

  @override
  String swatchesCountOf(int visible, int total) {
    return '$visible von $total';
  }

  @override
  String swatchesOwnedSubtitle(String brand, int count) {
    return '$brand · $count im Besitz';
  }

  @override
  String swatchesFilteredColorCount(int visible, int total) {
    return '$visible von $total Farben';
  }

  @override
  String swatchesSwatchSemantics(String code, String name, String favorite) {
    String _temp0 = intl.Intl.selectLogic(favorite, {
      'true': '$code, $name, Favorit',
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
    return 'Die Palette „$title“ ist in Palette bereit.';
  }

  @override
  String matchSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'deinen $count Markern',
      one: 'deinem 1 Marker',
    );
    return 'Abgleich mit $_temp0';
  }

  @override
  String get matchQualityExcellent => 'Fast exakt';

  @override
  String get matchQualityVeryClose => 'Sehr nah';

  @override
  String get matchQualityClose => 'Nah';

  @override
  String get matchQualityFair => 'Grob';

  @override
  String get matchQualityApproximate => 'Weit weg';

  @override
  String matchRecorded(String code) {
    return '$code in den letzten Auswahlen gespeichert.';
  }

  @override
  String get errDisabled => 'KI-Vorschläge sind ausgeschaltet.';

  @override
  String get errMissingKey => 'Kein API-Schlüssel eingerichtet.';

  @override
  String get errNoModelSelected => 'Kein KI-Modell ausgewählt.';

  @override
  String get errUnauthorized => 'Der API-Schlüssel wurde abgelehnt.';

  @override
  String get errPaymentRequired =>
      'Das Konto hat kein Guthaben oder das Kontingent des Schlüssels ist aufgebraucht.';

  @override
  String get errRateLimited =>
      'Der Anbieter begrenzt die Anfragen. Versuche es gleich noch einmal.';

  @override
  String get errServerError =>
      'Beim Anbieter ist ein Serverfehler aufgetreten. Versuche es später erneut.';

  @override
  String get errHttpError => 'Der Anbieter hat die Anfrage abgelehnt.';

  @override
  String get errNetworkError =>
      'Der Anbieter war nicht erreichbar. Prüfe die Verbindung.';

  @override
  String get errInvalidJson =>
      'Der Anbieter hat eine unlesbare Antwort geliefert.';

  @override
  String get errInvalidResponse =>
      'Der Anbieter hat keine verwertbare Palette geliefert.';

  @override
  String get errNoValidSuggestions =>
      'Der Anbieter hat Farben vorgeschlagen, die nicht in der aktiven Sammlung sind.';

  @override
  String get errNoAvailableColors =>
      'Es sind keine Marker zur Auswahl verfügbar.';

  @override
  String get errInvalidBaseColor =>
      'Der Basis-Marker ist nicht in deiner Sammlung.';

  @override
  String get errBaseDried =>
      'Der Basis-Marker ist ausgetrocknet. Markiere ihn als nutzbar oder wähle einen anderen.';

  @override
  String get errNoSuggestions => 'Es konnten keine Vorschläge erstellt werden.';

  @override
  String get errTimeout =>
      'Das Modell auf dem Gerät hat zu lange gebraucht. Versuche es erneut.';

  @override
  String get errOnDeviceUnavailable =>
      'Das Modell auf dem Gerät ist auf diesem Handy nicht bereit.';

  @override
  String get errUnknown => 'KI-Vorschläge sind nicht verfügbar.';

  @override
  String errAiUnavailableWithReason(String reason) {
    return 'KI nicht verfügbar ($reason) Lokale Vorschläge werden angezeigt.';
  }

  @override
  String get roleMainTone => 'Hauptton';

  @override
  String get roleMidtone => 'Mittelton';

  @override
  String get roleShadow => 'Schatten';

  @override
  String get roleHighlight => 'Glanzlicht';

  @override
  String get roleBlend => 'Übergang';

  @override
  String get roleToneA => 'Ton A';

  @override
  String get roleToneAShadow => 'Schatten von Ton A';

  @override
  String get roleToneB => 'Ton B';

  @override
  String get roleToneBShadow => 'Schatten von Ton B';

  @override
  String get roleBridge => 'Brücke';

  @override
  String get roleWarmBase => 'Warme Basis';

  @override
  String get roleWarmShadow => 'Warmer Schatten';

  @override
  String get roleSunlitAccent => 'Sonniger Akzent';

  @override
  String get roleDepthTone => 'Tiefenton';

  @override
  String get roleCoolBase => 'Kühle Basis';

  @override
  String get roleCoolShadow => 'Kühler Schatten';

  @override
  String get roleAtmosphere => 'Atmosphäre';

  @override
  String get roleDeepCool => 'Tiefes Kühl';

  @override
  String get rolePastelBase => 'Pastellbasis';

  @override
  String get roleSoftShade => 'Weicher Schatten';

  @override
  String get rolePastelHighlight => 'Pastelllicht';

  @override
  String get roleAccent => 'Akzent';

  @override
  String get roleSupport => 'Hilfston';

  @override
  String get roleNeonLead => 'Neon-Hauptfarbe';

  @override
  String get roleNeonSecondary => 'Neon-Zweitfarbe';

  @override
  String get roleGlow => 'Leuchten';

  @override
  String get rolePopAccent => 'Pop-Akzent';

  @override
  String get roleHue1 => 'Farbton 1';

  @override
  String get roleHue2 => 'Farbton 2';

  @override
  String get roleHue3 => 'Farbton 3';

  @override
  String get roleHue4 => 'Farbton 4';

  @override
  String get roleHue5 => 'Farbton 5';

  @override
  String get roleUnexpectedLead => 'Überraschende Hauptfarbe';

  @override
  String get roleContrastPair => 'Kontrastpartner';

  @override
  String get roleTensionAccent => 'Spannungsakzent';

  @override
  String get roleOffbeatSupport => 'Ungewöhnlicher Hilfston';

  @override
  String get roleRandom1 => 'Zufall 1';

  @override
  String get roleRandom2 => 'Zufall 2';

  @override
  String get roleRandom3 => 'Zufall 3';

  @override
  String get roleRandom4 => 'Zufall 4';

  @override
  String get roleRandom5 => 'Zufall 5';

  @override
  String get roleLightValue => 'Heller Wert';

  @override
  String get roleMidLight => 'Mittelhell';

  @override
  String get roleMid => 'Mittel';

  @override
  String get roleMidDark => 'Mitteldunkel';

  @override
  String get roleDarkValue => 'Dunkler Wert';

  @override
  String get roleWarmSideA => 'Warme Seite A';

  @override
  String get roleWarmSideB => 'Warme Seite B';

  @override
  String get roleCoolSideA => 'Kühle Seite A';

  @override
  String get roleCoolSideB => 'Kühle Seite B';

  @override
  String get roleBridgeTone => 'Brückenton';

  @override
  String get roleSeasonLead => 'Jahreszeit-Hauptfarbe';

  @override
  String get roleSeasonSupport => 'Jahreszeit-Hilfston';

  @override
  String get roleFestiveRed => 'Festliches Rot';

  @override
  String get roleEvergreen => 'Immergrün';

  @override
  String get roleGoldAccent => 'Goldakzent';

  @override
  String get rolePineShadow => 'Tannenschatten';

  @override
  String get roleSnowSupport => 'Schnee-Hilfston';

  @override
  String get roleRomanticLead => 'Romantische Hauptfarbe';

  @override
  String get roleRoseShadow => 'Rosenschatten';

  @override
  String get roleSoftBlush => 'Zarte Röte';

  @override
  String get roleBalanceTone => 'Ausgleichston';

  @override
  String get roleBase => 'Basis';

  @override
  String get roleGlowZone => 'Leuchtzone';

  @override
  String get rolePatternAccent => 'Musterakzent';

  @override
  String get roleContrastColor => 'Kontrastfarbe';

  @override
  String get rolePrimary1 => 'Primär 1';

  @override
  String get rolePrimary2 => 'Primär 2';

  @override
  String get rolePrimary3 => 'Primär 3';

  @override
  String get roleSecondary => 'Sekundär';

  @override
  String get roleSepiaLight => 'Sepialicht';

  @override
  String get roleDustMidtone => 'Staub-Mittelton';

  @override
  String get roleLeatherShadow => 'Lederschatten';

  @override
  String get roleAgedAccent => 'Alterungsakzent';

  @override
  String get roleSmokeNeutral => 'Rauchneutral';

  @override
  String get roleHauntBase => 'Spukbasis';

  @override
  String get rolePumpkinGlow => 'Kürbisleuchten';

  @override
  String get roleNightShadow => 'Nachtschatten';

  @override
  String get roleEerieAccent => 'Gruselakzent';

  @override
  String get roleFogSupport => 'Nebel-Hilfston';

  @override
  String get roleNightBase => 'Nachtbasis';

  @override
  String get roleDeepShadow => 'Tiefer Schatten';

  @override
  String get roleMoonlitEdge => 'Mondbeschienener Rand';

  @override
  String get roleCoolAccent => 'Kühler Akzent';

  @override
  String get roleMist => 'Dunst';

  @override
  String get roleWaterBase => 'Wasserbasis';

  @override
  String get roleDepth => 'Tiefe';

  @override
  String get roleShadowWater => 'Wasserschatten';

  @override
  String get roleLightBeam => 'Lichtstrahl';

  @override
  String get roleBubbleHighlight => 'Blasenlicht';

  @override
  String get roleSpookyBase => 'Gruselbasis';

  @override
  String get roleColdShadow => 'Kalter Schatten';

  @override
  String get roleHauntedAccent => 'Spukakzent';

  @override
  String get roleEerieHighlight => 'Grusellicht';

  @override
  String get roleFogTone => 'Nebelton';

  @override
  String get roleMysticBase => 'Mystikbasis';

  @override
  String get roleSpellShadow => 'Zauberschatten';

  @override
  String get roleMagicalAccent => 'Magischer Akzent';

  @override
  String get roleRuneGlow => 'Runenleuchten';

  @override
  String get roleMoodLead => 'Stimmungs-Hauptfarbe';

  @override
  String get roleMoodShadow => 'Stimmungsschatten';

  @override
  String get roleEmotionAccent => 'Gefühlsakzent';

  @override
  String get roleMaterialBase => 'Materialbasis';

  @override
  String get rolePlaneShift => 'Flächenwechsel';

  @override
  String get roleHardShadow => 'Harter Schatten';

  @override
  String get roleSpecularEdge => 'Glanzkante';

  @override
  String get rolePatinaAccent => 'Patina-Akzent';

  @override
  String get roleSpaceBase => 'Weltraumbasis';

  @override
  String get roleNebulaGlow => 'Nebelleuchten';

  @override
  String get roleDeepVoid => 'Tiefe Leere';

  @override
  String get roleStarAccent => 'Sternakzent';

  @override
  String get roleDustCloud => 'Staubwolke';

  @override
  String get roleGlassPaneA => 'Glasfeld A';

  @override
  String get roleGlassPaneB => 'Glasfeld B';

  @override
  String get roleGlassPaneC => 'Glasfeld C';

  @override
  String get roleGlassPaneD => 'Glasfeld D';

  @override
  String get roleLightHit => 'Lichttreffer';

  @override
  String get roleShade => 'Schatten';

  @override
  String get roleContrast => 'Kontrast';

  @override
  String get roleSoftShadow => 'Weicher Schatten';

  @override
  String get roleBackground => 'Hintergrund';

  @override
  String get roleCompanionHue => 'Begleitfarbton';

  @override
  String get rolePrimaryShadow => 'Primärschatten';

  @override
  String get roleMysticAccent => 'Mystischer Akzent';

  @override
  String get roleSecondaryAccent => 'Sekundärakzent';

  @override
  String get rolePumpkinShadow => 'Kürbisschatten';

  @override
  String get roleWitchyPurple => 'Hexenviolett';

  @override
  String get roleToxicAccent => 'Giftakzent';

  @override
  String get roleNightBackground => 'Nachthintergrund';

  @override
  String get roleRibbonRed => 'Schleifenrot';

  @override
  String get rolePineDepth => 'Tannentiefe';

  @override
  String get roleSnowHighlight => 'Schneelicht';

  @override
  String get roleBudShadow => 'Knospenschatten';

  @override
  String get roleBlossomTint => 'Blütentönung';

  @override
  String get roleFreshLeaf => 'Frisches Blatt';

  @override
  String get roleDaffodilLight => 'Osterglockenlicht';

  @override
  String get roleRainySky => 'Regenhimmel';

  @override
  String get roleSkinSubjectShadow => 'Haut-/Motivschatten';

  @override
  String get roleWarmCompanion => 'Warmer Begleiter';

  @override
  String get roleNeutralBalance => 'Neutraler Ausgleich';

  @override
  String get roleBarkShadow => 'Rindenschatten';

  @override
  String get roleMapleRed => 'Ahornrot';

  @override
  String get roleOliveAccent => 'Olivakzent';

  @override
  String get roleMorningMist => 'Morgendunst';

  @override
  String get roleSubjectShadow => 'Motivschatten';

  @override
  String get roleCoolCompanion => 'Kühler Begleiter';

  @override
  String get roleAiryHighlight => 'Luftiges Licht';

  @override
  String get roleSnowShadow => 'Schneeschatten';

  @override
  String get roleFrostHighlight => 'Frostlicht';

  @override
  String get roleEvergreenDepth => 'Immergrüntiefe';

  @override
  String get roleBerryAccent => 'Beerenakzent';

  @override
  String get roleTwilightSky => 'Dämmerhimmel';

  @override
  String get roleGroundShadow => 'Bodenschatten';

  @override
  String get roleSkyBlend => 'Himmelsverlauf';

  @override
  String get roleSunHighlight => 'Sonnenlicht';

  @override
  String get roleContrastAccent => 'Kontrastakzent';

  @override
  String get roleNeutralBuffer => 'Neutraler Puffer';

  @override
  String get rolePalmShadow => 'Palmenschatten';

  @override
  String get roleCoralAccent => 'Korallenakzent';

  @override
  String get roleOceanSplash => 'Meeresgischt';

  @override
  String get roleSunbeamHighlight => 'Sonnenstrahllicht';

  @override
  String get roleWarmSand => 'Warmer Sand';

  @override
  String get roleLeafShadow => 'Blattschatten';

  @override
  String get roleMossMidtone => 'Moos-Mittelton';

  @override
  String get roleSunlitLeaf => 'Sonniges Blatt';

  @override
  String get roleTrunkAccent => 'Stammakzent';

  @override
  String get roleSkyFog => 'Himmel/Nebel';

  @override
  String get rolePetalShadow => 'Blütenblattschatten';

  @override
  String get rolePetalHighlight => 'Blütenblattlicht';

  @override
  String get roleSecondaryPetal => 'Zweites Blütenblatt';

  @override
  String get roleLeafAccent => 'Blattakzent';

  @override
  String get rolePatternBackground => 'Musterhintergrund';

  @override
  String get roleToneC => 'Ton C';

  @override
  String get roleToneD => 'Ton D';

  @override
  String get roleNeutralLinework => 'Neutrale Linien';

  @override
  String get roleComplement => 'Komplement';

  @override
  String get roleNeutral => 'Neutral';

  @override
  String get roleCompanion => 'Begleiter';

  @override
  String get reasonScenarioSupport => 'Unterstützt das Szenario';

  @override
  String get reasonBalancedPairing => 'Ausgewogene Paarung';

  @override
  String get reasonShadowDepth => 'Schattentiefe';

  @override
  String get reasonSoftNearbyHue => 'Sanfter Nachbarfarbton';

  @override
  String get reasonControlledContrast => 'Kontrollierter Kontrast';

  @override
  String get reasonHighlightLift => 'Lichtakzent';

  @override
  String get reasonLocked => 'Gesperrt';

  @override
  String get reasonVariationSupport => 'Unterstützt die Variante';

  @override
  String get reasonOppositeHueContrast => 'Kontrast durch Gegenfarbton';

  @override
  String get reasonSplitComplementContrast =>
      'Kontrast durch geteilte Komplementärfarben';

  @override
  String get reasonTriadBalance => 'Triaden-Balance';

  @override
  String get reasonSquareHarmony => 'Quadrat-Harmonie';

  @override
  String get reasonRectangleHarmony => 'Rechteck-Harmonie';

  @override
  String get reasonSameFamilyDeeperTone => 'Gleiche Familie, tieferer Ton';

  @override
  String get reasonSameFamilyLighterTone => 'Gleiche Familie, hellerer Ton';

  @override
  String get reasonManualPalette => 'Manuelle Palette';

  @override
  String get reasonSupportTone => 'Hilfston';

  @override
  String get reasonAISuggestion => 'KI-Vorschlag';

  @override
  String get reasonLoadedPalette => 'Geladene Palette';

  @override
  String get reasonAppliedFromIdeas => 'Aus Ideen übernommen';

  @override
  String reasonNearbyHue(int degrees) {
    return 'Harmonie mit Nachbarfarbton ($degrees°)';
  }

  @override
  String reasonShadowTone(int percent) {
    return 'Schattenton ($percent % dunkler)';
  }

  @override
  String reasonVariation(String prefix, String reason) {
    return '$prefix: $reason';
  }

  @override
  String get variationPrefixVibrant => 'Lebhaft';

  @override
  String get variationPrefixSoft => 'Sanft';

  @override
  String get variationPrefixContrast => 'Kontrast';

  @override
  String get variationPrefixWarm => 'Warm';

  @override
  String get variationPrefixCool => 'Kühl';

  @override
  String get variationLabelMoreVibrant => 'Lebhafter';

  @override
  String get variationLabelSofter => 'Sanfter';

  @override
  String get variationLabelHigherContrast => 'Mehr Kontrast';

  @override
  String get variationLabelWarmer => 'Wärmer';

  @override
  String get variationLabelCooler => 'Kühler';

  @override
  String get modeRecommended => 'Empfohlen';

  @override
  String get modeComplementary => 'Komplementär';

  @override
  String get modeAnalogous => 'Analog';

  @override
  String get modeSplitComplementary => 'Geteilt komplementär';

  @override
  String get modeTriad => 'Triade';

  @override
  String get modeSquare => 'Quadrat';

  @override
  String get modeRectangle => 'Rechteck';

  @override
  String get modeMonochrome => 'Monochrom';

  @override
  String get modeCustomPalette => 'Eigene Palette';

  @override
  String get modeShadow => 'Schatten';

  @override
  String get packLabel120New => '120 Neu';

  @override
  String get packLabel36Skin => '36 Haut';

  @override
  String get packLabel36Gray => '36 Grau';

  @override
  String get packLabel48Pastel => '48 Pastell';

  @override
  String get categorySignature => 'Signature';

  @override
  String get categoryChallenges => 'Challenges';

  @override
  String get categoryAtmosphere => 'Atmosphäre';

  @override
  String get settingsLinesTitle => 'Deine Serien';

  @override
  String get settingsLinesHint =>
      'Wähle jede Ohuhu-Serie, die du besitzt. Schaltest du eine Serie aus, werden ihre Packs aus deiner Auswahl entfernt.';

  @override
  String settingsLineSelectedOfTotal(int selected, int total) {
    return '$selected von $total Packs ausgewählt';
  }

  @override
  String settingsCurrentPacks(int count) {
    return 'Aktuelle Packs ($count)';
  }

  @override
  String settingsLegacyPacks(int count) {
    return 'Ältere / Community-Packs ($count)';
  }

  @override
  String get settingsLegacyPacksNote =>
      'Packliste aus der Community; wird möglicherweise nicht mehr verkauft.';

  @override
  String settingsPackColorsSemantics(String pack, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Farben',
      one: '1 Farbe',
    );
    return '$pack, $_temp0';
  }

  @override
  String get swatchesLines => 'Serien';

  @override
  String get swatchesLabelLine => 'Serie';

  @override
  String get swatchesAllLines => 'Alle Serien';

  @override
  String get swatchesLegacyPacks => 'Ältere Sets';

  @override
  String packLabelSkin(String n) {
    return '$n Haut';
  }

  @override
  String packLabelPastel(String n) {
    return '$n Pastell';
  }

  @override
  String packLabelPastels(String n) {
    return '$n Pastelle';
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
    return '$n Landschaft';
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
    return '+$count weitere';
  }

  @override
  String get settingsMatchingGroup => 'Farbabgleich';

  @override
  String get settingsMatchSuggestUnowned => 'Alle Farben zeigen';

  @override
  String get settingsMatchSuggestUnownedSubtitle =>
      'Ist keiner deiner Marker nah dran, zeigt der Abgleich auch den nächsten des ganzen Sortiments.';

  @override
  String get settingsSetupAgain => 'Einrichtung wiederholen';

  @override
  String get matchNoCloseMatch => 'Kein naher Treffer unter deinen Markern.';

  @override
  String matchRangeTitle(String brand) {
    return 'Ganzes $brand-Sortiment';
  }

  @override
  String get matchNotOwnedBadge => 'Besitzt du nicht';

  @override
  String matchBestOfRange(String brand) {
    return 'Bester aus dem ganzen $brand-Sortiment';
  }

  @override
  String get matchNotOwnedLine => 'Nicht in deiner Sammlung';

  @override
  String matchSeeAll(int count) {
    return 'Alle ansehen ($count)';
  }

  @override
  String get matchSubtitleEmpty => 'Noch keine Marker in deiner Sammlung';

  @override
  String swatchesWholeRangeNotice(String brand) {
    return 'Das ganze $brand-Sortiment wird angezeigt';
  }

  @override
  String get swatchesWholeRangeAction => 'Einrichten';

  @override
  String matchWholeRangeBody(String brand) {
    return 'Bis du deine Sammlung einrichtest, nutzt der Abgleich das ganze $brand-Sortiment.';
  }

  @override
  String get matchWholeRangeAction => 'Zu Meiner Sammlung';

  @override
  String get collectionTitle => 'Meine Sammlung';

  @override
  String collectionMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker',
      one: '1 Marker',
      zero: 'Keine Marker',
    );
    return '$_temp0';
  }

  @override
  String collectionSets(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sets',
      one: '1 Set',
    );
    return '$_temp0';
  }

  @override
  String get collectionNotSetUp => 'Noch nicht eingerichtet';

  @override
  String get collectionSeriesTitle => 'Serien, die du besitzt';

  @override
  String get collectionHonoluluNote =>
      'Honolulu B, Honolulu S und Honolulu² nutzen dieselben Farbcodes wie Honolulu; nur die Spitzen unterscheiden sich.';

  @override
  String get collectionSetsTitle => 'Sets, die du besitzt';

  @override
  String get collectionSetsEmpty => 'Wähle eine Serie, um ihre Sets zu sehen.';

  @override
  String collectionOlderSets(int count) {
    return 'Ältere Sets ($count)';
  }

  @override
  String get collectionOlderSetsNote =>
      'Eingestellte oder regionale Editionen, aus Community-Daten.';

  @override
  String get collectionExtrasTitle => 'Einzelne Marker';

  @override
  String get collectionExtrasHint =>
      'Einzelmarker gekauft? Hake sie hier an. Marker aus deinen Sets zählen schon.';

  @override
  String get collectionDecoMarkersTitle => 'Deine Marker';

  @override
  String get collectionIndividualMarkersShort => 'Hake an, was du hast';

  @override
  String get collectionDecoHint =>
      'DecoTime veröffentlicht nicht, welche Farben in welchem Set stecken. Hake also an, was du besitzt, oder füge eine ganze Familie hinzu.';

  @override
  String get collectionDecoSizesHint =>
      'Action verkauft DecoTime-Sets mit 100, 150, 160, 200 und 300 Markern.';

  @override
  String get collectionFamiliesTitle => 'Nach Familie hinzufügen';

  @override
  String collectionFamilyChip(String family, int owned, int total) {
    return '$family $owned/$total';
  }

  @override
  String get collectionFamilyColours => 'Farben';

  @override
  String get collectionFamilyWarmGrey => 'Warme Grautöne';

  @override
  String get collectionFamilyCoolGrey => 'Kühle Grautöne';

  @override
  String get collectionFamilyBlueGrey => 'Blaugrautöne';

  @override
  String get collectionFamilyGreenGrey => 'Grüngrautöne';

  @override
  String get collectionImportCodesTitle => 'Codes importieren';

  @override
  String get collectionImportCodesHint => 'Füge eine Liste von Codes ein';

  @override
  String get collectionDecoRange => 'DecoTime-Sortiment';

  @override
  String get collectionWholeRange => 'Ganzes Sortiment';

  @override
  String get collectionSearchHint => 'Code oder Name suchen';

  @override
  String get collectionTickVisible => 'Alle anhaken';

  @override
  String collectionTickManyTitle(int count) {
    return '$count Marker anhaken?';
  }

  @override
  String get collectionTickManyBody =>
      'Alle zählen dann als Marker, die du besitzt. Mit „Alle abwählen“ nimmst du sie wieder heraus.';

  @override
  String get collectionUntickVisible => 'Alle abwählen';

  @override
  String collectionRemoveMarkersTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker entfernen?',
      one: '1 Marker entfernen?',
    );
    return '$_temp0';
  }

  @override
  String collectionRemoveFromTitle(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$name: $count Marker entfernen?',
      one: '$name: 1 Marker entfernen?',
    );
    return '$_temp0';
  }

  @override
  String get collectionRemoveMarkersBody =>
      'Die Marker, die du schon hast, verlassen deine Sammlung. Du kannst sie jederzeit wieder hinzufügen.';

  @override
  String get collectionRemoveConfirm => 'Entfernen';

  @override
  String get collectionReplaceTitle => 'Deine Sammlung ersetzen?';

  @override
  String get collectionReplaceBody =>
      'Wenn die Einrichtung endet, werden die Sets und Marker, die du jetzt hast, durch die ersetzt, die du hier auswählst.';

  @override
  String get collectionReplaceConfirm => 'Ersetzen';

  @override
  String get collectionInYourSets => 'In deinem Set';

  @override
  String get collectionNoResults => 'Kein Marker passt zur Suche.';

  @override
  String get collectionReset => 'Zurücksetzen';

  @override
  String get collectionOwnedGroup => 'Was du besitzt';

  @override
  String get collectionShoppingGroup => 'Einkäufe';

  @override
  String get collectionToolsGroup => 'Werkzeuge';

  @override
  String get toolsMapTitle => 'Farbkarte';

  @override
  String get toolsMapHint =>
      'Wo deine Marker nach Farbton und Helligkeit liegen und wo Lücken sind.';

  @override
  String get toolsTranslateTitle => 'Rezept übersetzen';

  @override
  String get toolsTranslateHint =>
      'Wandelt die Codes aus einer Anleitung in die ähnlichsten deiner Marker um.';

  @override
  String get toolsBlendsTitle => 'Meine Rezepte';

  @override
  String get toolsBlendsHint =>
      'Verläufe, die du speicherst: Marker in Reihenfolge, Notiz und Foto.';

  @override
  String get toolsTransferTitle => 'Export und Import';

  @override
  String get toolsTransferHint =>
      'Teile deine Marker als Liste oder CSV oder füge viele per Code hinzu.';

  @override
  String get toolsMapIntro =>
      'Jeder Punkt ist ein Marker, den du besitzt. Schraffierte Bereiche haben keinen.';

  @override
  String get toolsMapShowRange => 'Ganzes Sortiment zeigen';

  @override
  String get toolsMapShowRangeHint =>
      'Blasse Punkte für alle Marker deiner Marken, damit du siehst, was fehlt.';

  @override
  String get toolsMapAxes =>
      'Von links nach rechts: Farbton. Von oben nach unten: von hell nach dunkel.';

  @override
  String get toolsMapGreysTitle => 'Grau- und Neutraltöne';

  @override
  String get toolsMapGreysAxis =>
      'Von links nach rechts: von dunkel nach hell.';

  @override
  String get toolsMapFamiliesTitle => 'Nach Farbton';

  @override
  String get toolsHueRed => 'Rot';

  @override
  String get toolsHueOrange => 'Orange';

  @override
  String get toolsHueYellow => 'Gelb';

  @override
  String get toolsHueGreen => 'Grün';

  @override
  String get toolsHueTeal => 'Türkis';

  @override
  String get toolsHueBlue => 'Blau';

  @override
  String get toolsHueViolet => 'Violett';

  @override
  String get toolsHueMagenta => 'Magenta';

  @override
  String toolsFamilyBands(int light, int mid, int dark) {
    return 'Hell $light · Mittel $mid · Dunkel $dark';
  }

  @override
  String get toolsMapDriedNote => 'Ausgetrocknete Marker sind nicht enthalten.';

  @override
  String toolsMapSummary(String markers, int empty, int cells) {
    return 'Farbkarte mit $markers. $empty von $cells Bereichen haben keinen Marker. Die Liste darunter zeigt dieselben Marker nach Farbton.';
  }

  @override
  String get toolsMarkerOwned => 'In deiner Sammlung';

  @override
  String get toolsMarkerNotOwned => 'Nicht in deiner Sammlung';

  @override
  String get toolsTranslateIntro =>
      'Tippe oder füge die Codes aus einer Anleitung ein, in der Marke, die sie nutzt. Kommas, Leerzeichen und Listen funktionieren.';

  @override
  String get toolsTranslateBrand => 'Marke des Rezepts';

  @override
  String get toolsTranslateCodes => 'Codes';

  @override
  String get toolsTranslateResults => 'Übersetzung';

  @override
  String get toolsTranslateEmpty =>
      'Die Codes, die du eingibst, erscheinen hier.';

  @override
  String get toolsTranslateMine => 'Dein ähnlichster Marker';

  @override
  String get toolsTranslateNotOwned => 'Nicht vorhanden';

  @override
  String get toolsTranslateMissing => 'Nichts Ähnliches in deiner Sammlung.';

  @override
  String toolsTranslateUnknown(String brand) {
    return 'Nicht in $brand gefunden';
  }

  @override
  String get toolsCopyList => 'Liste kopieren';

  @override
  String get toolsShareList => 'Liste teilen';

  @override
  String get toolsListCopied => 'Liste kopiert.';

  @override
  String get toolsShareFailed => 'Die Liste konnte nicht geteilt werden.';

  @override
  String get toolsBlendsNew => 'Neues Rezept';

  @override
  String get toolsBlendsEditTitle => 'Rezept bearbeiten';

  @override
  String get toolsBlendsEmptyTitle => 'Noch keine Rezepte';

  @override
  String get toolsBlendsEmptyBody =>
      'Speichere Verläufe, die dir gefallen: Marker in Reihenfolge, Notiz und Foto.';

  @override
  String get toolsBlendsName => 'Name des Rezepts';

  @override
  String get toolsBlendsMarkersTitle => 'Marker in Reihenfolge';

  @override
  String get toolsBlendsMarkersHelp =>
      'Ziehe am Griff, um die Reihenfolge zu ändern.';

  @override
  String get toolsBlendsDrag => 'Ziehen zum Umsortieren';

  @override
  String toolsBlendsRemoveMarker(String code) {
    return '$code entfernen';
  }

  @override
  String get toolsBlendsNote => 'Notiz';

  @override
  String get toolsBlendsPhotoTitle => 'Foto des Ergebnisses';

  @override
  String get toolsBlendsPhotoHelp => 'Optional. Es bleibt auf diesem Handy.';

  @override
  String get toolsBlendsPhotoSemantic => 'Foto des Rezepts';

  @override
  String get toolsBlendsSave => 'Rezept speichern';

  @override
  String get toolsBlendsDelete => 'Rezept löschen';

  @override
  String get toolsBlendsDeleteTitle => 'Dieses Rezept löschen?';

  @override
  String get toolsBlendsDeleteBody =>
      'Das Rezept und sein Foto werden von diesem Handy entfernt.';

  @override
  String get toolsTransferExport => 'Exportieren';

  @override
  String toolsTransferBrands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marken',
      one: '1 Marke',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferExportBrands(String brands) {
    return 'Enthält alle deine Marken: $brands.';
  }

  @override
  String get toolsTransferCsv => 'Als CSV teilen';

  @override
  String get toolsTransferImport => 'Per Code importieren';

  @override
  String get toolsTransferImportHelp =>
      'Wähle die Marke und füge ihre Codes ein. Es wird nichts hinzugefügt, bis du auf den Button tippst.';

  @override
  String get toolsTransferNew => 'Neue Marker';

  @override
  String get toolsTransferAlready => 'Schon vorhanden';

  @override
  String get toolsTransferUnknown => 'Nicht erkannt';

  @override
  String toolsTransferAdd(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker hinzufügen',
      one: '1 Marker hinzufügen',
      zero: 'Marker hinzufügen',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker hinzugefügt.',
      one: '1 Marker hinzugefügt.',
    );
    return '$_temp0';
  }

  @override
  String commonSeeAll(int count) {
    return 'Alle anzeigen ($count)';
  }

  @override
  String get collectionChartTitle => 'Druckbare Farbkarte';

  @override
  String get swatchesOtherBrandsTitle => 'In anderen Marken';

  @override
  String get swatchesOtherBrandsOnlyMine => 'Nur meine';

  @override
  String get swatchesOtherBrandsNone =>
      'Es gibt keine andere Marke zum Vergleichen.';

  @override
  String get swatchesOtherBrandsNoneMine =>
      'Du hast keine nutzbaren Marker anderer Marken.';

  @override
  String get swatchesOtherBrandsFailed =>
      'Die anderen Marken konnten nicht gelesen werden.';

  @override
  String get swatchesOtherBrandsPaletteNote =>
      'Paletten nutzen die in den Optionen gewählte Marke, daher lässt sich dieser Marker keiner hinzufügen.';

  @override
  String get paletteVisionTitle => 'Farbsehen';

  @override
  String get paletteVisionNormal => 'Normal';

  @override
  String get paletteVisionProtanopia => 'Protanopie';

  @override
  String get paletteVisionDeuteranopia => 'Deuteranopie';

  @override
  String get paletteVisionTritanopia => 'Tritanopie';

  @override
  String get paletteVisionAchromatopsia => 'Achromatopsie';

  @override
  String paletteVisionPairs(String pairs) {
    return 'Schwer zu unterscheiden: $pairs';
  }

  @override
  String paletteVisionPairsMore(int count) {
    return '+$count weitere';
  }

  @override
  String get paletteVisionNoPairs => 'Alle Farben bleiben gut unterscheidbar.';

  @override
  String get paletteVisionPreviewNote =>
      'Nur eine Vorschau. Beim Speichern und Teilen bleiben die echten Farben erhalten.';

  @override
  String get paletteEaselTitle => 'Staffelei-Modus';

  @override
  String get paletteEaselExit => 'Staffelei-Modus beenden';

  @override
  String get paletteShareTextButton => 'Als Text teilen';

  @override
  String paletteTextHeader(String brand, String title) {
    return 'Ink-Lab-Palette · $brand · $title';
  }

  @override
  String get paletteImportTitle => 'Aus Text importieren';

  @override
  String get paletteImportHint =>
      'Füge eine geteilte Palette oder eine Liste von Markercodes ein.';

  @override
  String get paletteImportPaste => 'Einfügen';

  @override
  String get paletteImportAction => 'Palette laden';

  @override
  String get paletteImportNothing =>
      'In diesem Text wurden keine Markercodes gefunden.';

  @override
  String paletteImportNoneKnown(String brand, String codes) {
    return 'Keiner dieser Codes ist ein $brand-Marker: $codes.';
  }

  @override
  String paletteImportNoneKnownMixed(String codes) {
    return 'Keiner dieser Codes gehört zu deinen Marken: $codes.';
  }

  @override
  String paletteImportOtherBrand(String brand) {
    return 'Diese Palette gehört zu $brand. Wechsle die Marke in den Optionen, um sie zu importieren.';
  }

  @override
  String paletteImportDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Palette mit $count Markern importiert.',
      one: 'Palette mit 1 Marker importiert.',
    );
    return '$_temp0';
  }

  @override
  String paletteImportUnknown(String codes) {
    return 'Nicht erkannt: $codes.';
  }

  @override
  String get paletteImportRepeated =>
      'Doppelte Codes wurden nur einmal gezählt.';

  @override
  String get collectionChartHint =>
      'Leere Kästchen mit Code und Name jedes Markers, den du besitzt, um deine echten Marker auszuprobieren. Wird als A4-Bilder zum Drucken oder Speichern geteilt.';

  @override
  String get collectionChartShowColour => 'Katalogfarbe';

  @override
  String get collectionChartShowColourHint =>
      'Als schmaler Streifen in jedem Kästchen zum Vergleich anzeigen.';

  @override
  String get collectionChartCreate => 'Erstellen und teilen';

  @override
  String get collectionChartPreparing => 'Wird vorbereitet …';

  @override
  String get collectionChartEmpty => 'Wähle zuerst deine Sets oder Marker.';

  @override
  String collectionChartPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Seiten',
      one: '1 Seite',
    );
    return '$_temp0';
  }

  @override
  String get chartImageTitle => 'Farbkarte';

  @override
  String chartImagePage(int page, int total) {
    return 'Seite $page von $total';
  }

  @override
  String collectionResetTitle(String brand) {
    return 'Deine $brand-Sammlung zurücksetzen?';
  }

  @override
  String get collectionResetBody =>
      'Deine Sets und Einzelmarker dieser Marke werden entfernt. Favoriten und Paletten bleiben.';

  @override
  String collectionOwnedCount(int owned, int total) {
    return '$owned von $total';
  }

  @override
  String collectionLooseTicked(int loose, int sets) {
    return '$loose einzelne angehakt · $sets in deinen Sets';
  }

  @override
  String get onboardingWelcomeTitle => 'Willkommen bei Ink Lab';

  @override
  String get onboardingWelcomeBody =>
      'Durchsuche deine Marker, gleiche Farben mit Fotos ab und erstelle Paletten. Sag uns zuerst, welche Marker du hast.';

  @override
  String get onboardingOhuhuLine => 'Sets nach Serie: Oahu, Honolulu, Kaala';

  @override
  String get onboardingDecoLine =>
      'Ein Sortiment mit 313 Farben, Sets bei Action';

  @override
  String get onboardingSeriesTitle => 'Welche Serien hast du?';

  @override
  String get onboardingSeriesBody =>
      'Wähle jede Serie, von der du Marker hast.';

  @override
  String get onboardingSetsTitle => 'Welche Sets hast du?';

  @override
  String get onboardingSetsBody =>
      'Wähle die Boxen, die du gekauft hast. Einzelne Marker kannst du später hinzufügen.';

  @override
  String get onboardingDoneTitle => 'Alles bereit';

  @override
  String get onboardingLaterNote =>
      'Du kannst das später in Meine Sammlung ändern.';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingBack => 'Zurück';

  @override
  String get onboardingFinish => 'Los geht’s';

  @override
  String get onboardingStepFirst => 'Schritt 1';

  @override
  String onboardingMarkersTicked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count angehakt',
      one: '1 angehakt',
    );
    return '$_temp0';
  }

  @override
  String onboardingMarkersNoneTicked(String range) {
    return 'Noch keiner angehakt · $range';
  }

  @override
  String onboardingStep(int step, int total) {
    return 'Schritt $step von $total';
  }

  @override
  String get collectionSeriesOahuTips => 'Fein- und Keilspitze';

  @override
  String get collectionSeriesHonoluluTips => 'Pinsel- und Keilspitze';

  @override
  String get collectionSeriesKaalaTips => 'Pinselspitze';

  @override
  String get collectionSummaryNoSets =>
      'Noch keine Sets: Abgleich und Farbmuster zeigen das ganze Sortiment; Palette und Ideen brauchen deine eigenen Marker';

  @override
  String get collectionSummaryNoMarkers => 'Du hast noch keine Marker angehakt';

  @override
  String get collectionExtrasAddTitle => 'Einzelne Marker hinzufügen';

  @override
  String get collectionDecoMarkersButton => 'Marker anhaken';

  @override
  String collectionExtrasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count einzelne Marker',
      one: '1 einzelner Marker',
      zero: 'Keine einzelnen Marker',
    );
    return '$_temp0';
  }

  @override
  String get wishlistTitle => 'Wunschliste';

  @override
  String wishlistCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker zu kaufen',
      one: '1 Marker zu kaufen',
      zero: 'Noch nichts auf deiner Wunschliste',
    );
    return '$_temp0';
  }

  @override
  String get wishlistSubtitle => 'Füge sie im Detail einer Farbe hinzu';

  @override
  String get wishlistEmpty =>
      'Füge die Marker, die du kaufen willst, im Detail eines beliebigen Markers hinzu.';

  @override
  String get wishlistAdd => 'Zur Wunschliste';

  @override
  String get wishlistRemove => 'Aus Liste entfernen';

  @override
  String get wishlistCopy => 'Liste kopieren';

  @override
  String get wishlistCopied => 'Einkaufsliste kopiert';

  @override
  String get wishlistOfferTitle => 'Zur Wunschliste hinzufügen?';

  @override
  String wishlistOfferBody(String code) {
    return '$code ist ausgetrocknet. Füge ihn deiner Wunschliste hinzu, um Ersatz zu kaufen.';
  }

  @override
  String get driedTitle => 'Ausgetrocknet';

  @override
  String driedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausgetrocknete Marker',
      one: '1 ausgetrockneter Marker',
      zero: 'Keine ausgetrockneten Marker',
    );
    return '$_temp0';
  }

  @override
  String get driedHint =>
      'Sie bleiben in deiner Sammlung, aber Abgleich, Palette und Ideen schlagen sie nicht vor.';

  @override
  String get driedEmpty =>
      'Wenn ein Marker nicht mehr funktioniert, markiere ihn in seinem Detail als ausgetrocknet.';

  @override
  String get driedMark => 'Als ausgetrocknet markieren';

  @override
  String get driedUnmark => 'Als nutzbar markieren';

  @override
  String get driedNote =>
      'Ausgetrocknet: Abgleich, Palette und Ideen überspringen ihn, bis du ihn als nutzbar markierst.';

  @override
  String get commonDried => 'Ausgetrocknet';

  @override
  String get buyNextTitle => 'Was als Nächstes kaufen';

  @override
  String get buyNextIntro =>
      'Marker, die du nicht hast und die deine Farben den meisten Szenen am nächsten bringen würden.';

  @override
  String buyNextReasonScenes(int count, String scenes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Verbessert $count Szenen: $scenes',
      one: 'Verbessert 1 Szene: $scenes',
    );
    return '$_temp0';
  }

  @override
  String get buyNextReasonGap => 'Schließt eine Lücke in deinem Farbspektrum';

  @override
  String get buyNextNoCollection =>
      'Hake die Marker an, die du besitzt, um zu sehen, was du als Nächstes kaufen kannst.';

  @override
  String get buyNextComplete =>
      'Nichts vorzuschlagen: Deine Marker decken schon alle Szenen gut ab.';

  @override
  String get buyNextRefill => 'Ausgetrocknet: Mit Nachfüllen ist er wieder da.';

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Bis du Sets wählst, zeigen Abgleich und Farbmuster das ganze $brand-Sortiment. Palette und Ideen brauchen deine eigenen Marker.';
  }

  @override
  String get onboardingDoneNext =>
      'Wie weiter: Durchsuche Farben unter Farbmuster, gleiche ein Foto unter Abgleich ab oder erstelle eine Palette unter Palette.';

  @override
  String get collectionVisibleScope =>
      'Gilt für die Marker, die zu deiner Suche passen.';

  @override
  String get matchWhiteBalanceButton => 'Weißabgleich';

  @override
  String get matchWhiteBalanceHint =>
      'Tippe auf eine Stelle des Fotos, die weißes Papier sein sollte.';

  @override
  String get matchWhiteBalanceOn => 'Weißabgleich an';

  @override
  String get matchWhiteBalanceReset => 'Rückgängig';

  @override
  String get matchWhiteBalanceTooDark =>
      'Diese Stelle ist zu dunkel für Papier. Wähle eine hellere.';

  @override
  String get matchWhiteBalanceTooColourful =>
      'Diese Stelle hat zu viel Farbe für Papier. Wähle eine weiße Fläche.';

  @override
  String get commonOwnColour => 'Meine Farbe';

  @override
  String get swatchesMyColourTitle => 'Meine Farbe';

  @override
  String get swatchesMyColourHelp =>
      'Katalogfarben sind Schätzungen. Speichere die Farbe, die dein Marker wirklich auf Papier ergibt.';

  @override
  String get swatchesMyColourReset => 'Zurück zum Katalog';

  @override
  String get swatchesMyColourSaved => 'Deine Farbe wurde gespeichert';

  @override
  String get swatchesMyColourWasReset => 'Zurück zur Katalogfarbe';

  @override
  String get swatchesMyColourSame => 'Wie im Katalog';

  @override
  String swatchesMyColourValue(String hex) {
    return 'Deins: $hex';
  }

  @override
  String get swatchesStatusWished => 'Auf deiner Wunschliste';

  @override
  String get swatchesDetailsTitle => 'Details';

  @override
  String get swatchesCatalogueLabel => 'Katalog';

  @override
  String get swatchesMineLabel => 'Meine';

  @override
  String ownColorTitle(String code) {
    return 'Meine Farbe für $code';
  }

  @override
  String get ownColorHexLabel => 'Hex-Farbe';

  @override
  String get ownColorHexInvalid => 'Gib 3 oder 6 Hex-Ziffern ein, etwa 3A7F9C.';

  @override
  String get ownColorPhotoTitle => 'Aus einem Foto';

  @override
  String get ownColorPhotoHelp =>
      'Male den Marker auf weißes Papier, mach ein Foto und tippe auf die bemalte Fläche.';

  @override
  String get ownColorPhotoTap => 'Tippe auf die bemalte Fläche.';

  @override
  String get ownColorSave => 'Meine Farbe speichern';

  @override
  String get settingsOwnColors => 'Meine Farben nutzen';

  @override
  String get settingsOwnColorsSubtitle =>
      'Abgleich, Palette und Ideen nutzen die Farbe, die du für einen Marker gespeichert hast, statt der aus dem Katalog.';

  @override
  String settingsOwnColorsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eigene Farben',
      one: '1 eigene Farbe',
      zero: 'Noch keine eigenen Farben',
    );
    return '$_temp0';
  }

  @override
  String get settingsOwnColorsReset => 'Zurücksetzen';

  @override
  String get settingsOwnColorsResetTitle => 'Deine Farben zurücksetzen?';

  @override
  String get settingsOwnColorsResetBody =>
      'Jeder Marker kehrt zu seiner Katalogfarbe zurück. Das lässt sich nicht rückgängig machen.';

  @override
  String get settingsJoinBeta => 'Der Google-Play-Beta beitreten';

  @override
  String get collectionCopicHint =>
      'Copic-Marker werden einzeln gekauft. Markiere die Marker, die du besitzt.';

  @override
  String get collectionFinecolourHint =>
      'Finecolour-Marker werden einzeln gekauft. Markiere die Marker, die du besitzt.';

  @override
  String get onboardingCopicLine =>
      '358 Farben · Markiere die Marker, die du besitzt';

  @override
  String get onboardingFinecolourLine =>
      '480 Farben · Markiere die Marker, die du besitzt';

  @override
  String onboardingMarkersTitle(String brand) {
    return 'Deine $brand-Marker';
  }

  @override
  String onboardingNoMarkers(String brand) {
    return 'Du hast noch keine $brand-Marker markiert: Markiere sie unter „Meine Sammlung“.';
  }

  @override
  String get ideasDiarySegment => 'Tagebuch';

  @override
  String get ideasDiarySubtitle => 'Deine Werke, die neuesten zuerst';

  @override
  String get diaryEmptyTitle => 'Dein Tagebuch ist leer';

  @override
  String get diaryEmptyMessage =>
      'Halte die Seiten und Blätter fest, die du malst, mit Markern, Notizen und Fotos.';

  @override
  String get diaryAdd => 'Zum Tagebuch hinzufügen';

  @override
  String get diaryShareButton => 'Diesen Eintrag teilen';

  @override
  String get diaryStatusLabel => 'Status';

  @override
  String get diaryStatusInProgress => 'In Arbeit';

  @override
  String get diaryStatusFinished => 'Fertig';

  @override
  String get diaryNewTitle => 'Neuer Eintrag';

  @override
  String get diaryEditTitle => 'Eintrag bearbeiten';

  @override
  String get diaryTitleLabel => 'Titel';

  @override
  String get diaryDateLabel => 'Datum';

  @override
  String get diaryOnWhatLabel => 'Gemalt auf';

  @override
  String get diaryOnWhatHint => 'z. B. ein Malbuch oder ein Skizzenbuch';

  @override
  String get diaryMarkersTitle => 'Verwendete Marker';

  @override
  String get diaryMarkersChoose => 'Marker wählen';

  @override
  String diaryMarkerRemove(String code) {
    return '$code entfernen';
  }

  @override
  String get diaryPaletteTitle => 'Palette';

  @override
  String get diaryPaletteNone => 'Keine Palette';

  @override
  String get diaryPaletteChoose => 'Gespeicherte Palette verknüpfen';

  @override
  String get diaryPaletteMissing => 'Diese Palette ist nicht mehr gespeichert.';

  @override
  String get diaryPaletteEmpty => 'Du hast noch keine gespeicherten Paletten.';

  @override
  String get diaryNotesLabel => 'Notizen';

  @override
  String get diaryNotesHint => 'Technik, Papier, Verblenden ...';

  @override
  String get diaryMoreDetails => 'Mehr Details';

  @override
  String get diaryPhotosTitle => 'Fotos';

  @override
  String diaryPhotosHelp(int count) {
    return 'Bis zu $count Fotos. Sie bleiben auf diesem Handy.';
  }

  @override
  String get diaryPhotoRemove => 'Foto entfernen';

  @override
  String diaryPhotoSemantic(int number, int total) {
    return 'Foto $number von $total';
  }

  @override
  String get diarySave => 'Eintrag speichern';

  @override
  String get diaryDelete => 'Eintrag löschen';

  @override
  String get diaryDeleteTitle => 'Diesen Eintrag löschen?';

  @override
  String get diaryDeleteBody =>
      'Der Eintrag und seine Fotos werden von diesem Handy entfernt. Das lässt sich nicht rückgängig machen.';

  @override
  String get diaryDeleteConfirm => 'Löschen';

  @override
  String get diaryAddedNotice => 'Zum Tagebuch hinzugefügt';

  @override
  String diaryStatsArtworks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Werke',
      one: '1 Werk',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsFinished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fertig',
      one: '1 fertig',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsInProgress(int count) {
    return '$count in Arbeit';
  }

  @override
  String get diaryStatsOpen => 'Zahlen ansehen';

  @override
  String get diaryStatsTitle => 'Zahlen des Tagebuchs';

  @override
  String get diaryStatsStatusTitle => 'Fertig und in Arbeit';

  @override
  String get diaryStatsMonthsTitle => 'Einträge pro Monat';

  @override
  String diaryStatsMonthsLatest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Die letzten $count Monate.',
      one: 'Der letzte Monat.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsMarkersTitle => 'Marker, die du am meisten nutzt';

  @override
  String get diaryStatsMarkersEmpty => 'Noch kein Eintrag hat Marker.';

  @override
  String diaryStatsEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge',
      one: '1 Eintrag',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedTitle => 'Noch nicht genutzte Marker';

  @override
  String diaryStatsUnusedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker von dir stecken in keinem Eintrag.',
      one: '1 Marker von dir steckt in keinem Eintrag.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedNone => 'Alle deine Marker stecken in Einträgen.';

  @override
  String get diaryStatsUnusedNoCollection =>
      'Füge deine Marker unter Meine Sammlung hinzu, um zu sehen, welche du nicht genutzt hast.';

  @override
  String get diaryStatsUnusedShow => 'Liste zeigen';

  @override
  String get diaryStatsUnusedHide => 'Liste ausblenden';

  @override
  String get diaryStatsPalettesTitle =>
      'Paletten, die du am meisten verknüpfst';

  @override
  String get diaryStatsPalettesEmpty =>
      'Noch kein Eintrag verknüpft eine gespeicherte Palette.';

  @override
  String diaryShareMore(int count) {
    return '+$count weitere';
  }

  @override
  String get settingsLicences => 'Open-Source-Lizenzen';

  @override
  String get settingsLicencesSubtitle =>
      'Die Lizenzen des Codes, der Schriften und der Pakete, die die App nutzt';

  @override
  String get settingsLicencesLegalese =>
      'Ink-Lab-Code: MIT-Lizenz. Texte, Ideen und Dokumentation: CC BY-SA 4.0. Enthaltene Schriften: SIL Open Font License 1.1.';

  @override
  String get settingsSendFeedback => 'Feedback senden';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Öffnet deine E-Mail-App mit App- und Systemversion. Du entscheidest, ob du sie abschickst.';

  @override
  String get settingsRateApp => 'Ink Lab bewerten';

  @override
  String get settingsRateAppSubtitle =>
      'Eine Bewertung hilft anderen, die App zu finden';

  @override
  String settingsFeedbackNoMail(String address) {
    return 'Keine E-Mail-App gefunden. Die Adresse $address wurde kopiert.';
  }

  @override
  String get settingsErrorLogShare => 'Fehlerprotokoll teilen';

  @override
  String get settingsErrorLogShareSubtitle =>
      'Technische Details zu Fehlern der App, ohne dein Tagebuch und deinen API-Schlüssel. Es wird nichts gesendet, solange du es nicht teilst.';

  @override
  String get settingsErrorLogClear => 'Fehlerprotokoll löschen';

  @override
  String get settingsErrorLogCleared => 'Das Fehlerprotokoll wurde gelöscht';

  @override
  String get settingsErrorLogShareFailed =>
      'Das Fehlerprotokoll konnte nicht geteilt werden';

  @override
  String settingsLastBackup(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Letzte Sicherung: $dateString';
  }

  @override
  String get settingsNoBackupYet => 'Noch keine Sicherung';

  @override
  String get settingsBackupReminderNever =>
      'Du hast Daten in der App, aber noch keine Sicherung. Speichere eine Sicherungsdatei, damit nichts verloren geht, wenn du dein Handy wechselst oder zurücksetzt.';

  @override
  String get settingsBackupReminderOld =>
      'Deine letzte Sicherung ist über einen Monat alt. Speichere eine neue Datei, um deine neuesten Arbeiten zu schützen.';

  @override
  String get collectionTouchTwinHint =>
      'Markiere die Touch Twin-Marker, die du besitzt.';

  @override
  String get onboardingTouchTwinLine =>
      '202 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionPromarkerHint =>
      'Markiere die Promarker-Marker, die du besitzt.';

  @override
  String get onboardingPromarkerLine =>
      '148 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionPrismacolorHint =>
      'Markiere die Prismacolor Premier-Marker, die du besitzt.';

  @override
  String get onboardingPrismacolorLine =>
      '200 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionSpectrumNoirHint =>
      'Markiere die Spectrum Noir-Marker, die du besitzt.';

  @override
  String get onboardingSpectrumNoirLine =>
      '216 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionPromarkerBrushHint =>
      'Markiere die Promarker Brush-Marker, die du besitzt.';

  @override
  String get onboardingPromarkerBrushLine =>
      '72 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionArrtxHint =>
      'Markiere die Arrtx-Marker, die du besitzt.';

  @override
  String get onboardingArrtxLine =>
      '328 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionKurecolorHint =>
      'Markiere die ZIG Kurecolor-Marker, die du besitzt.';

  @override
  String get onboardingKurecolorLine =>
      '136 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionGraphitHint =>
      'Markiere die Graph\'it-Marker, die du besitzt.';

  @override
  String get onboardingGraphitLine =>
      '168 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionMarvyLePlumeHint =>
      'Markiere die Marvy Le Plume-Marker, die du besitzt.';

  @override
  String get onboardingMarvyLePlumeLine =>
      '144 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionBlickBrushHint =>
      'Markiere die Blick Studio Brush-Marker, die du besitzt.';

  @override
  String get onboardingBlickBrushLine =>
      '96 Farben · Markiere die Marker, die du besitzt';

  @override
  String get collectionArtistsLoftHint =>
      'Markiere die Artist\'s Loft-Marker, die du besitzt.';

  @override
  String get onboardingArtistsLoftLine =>
      '56 Farben · Markiere die Marker, die du besitzt';

  @override
  String get shortcutMatchLabel => 'Farbe abgleichen';

  @override
  String get shortcutNewPaletteLabel => 'Neue Palette';

  @override
  String get shortcutSearchSwatchesLabel => 'Farbmuster suchen';

  @override
  String get brandSearchHint => 'Marke suchen';

  @override
  String get brandGroupPopular => 'Beliebt';

  @override
  String get brandGroupMore => 'Weitere Marken';

  @override
  String get brandSearchEmpty => 'Keine Marke passt zu deiner Suche.';

  @override
  String get brandGroupOwned => 'Deine Marken';

  @override
  String brandOwnedLine(int owned, int total) {
    return '$owned von $total im Besitz';
  }

  @override
  String get navRailExpand => 'Menü ausklappen';

  @override
  String get navRailCollapse => 'Menü einklappen';

  @override
  String get inkLevelTitle => 'Tintenstand';

  @override
  String get inkLevelFull => 'Voll';

  @override
  String get commonRunningOut => 'Fast leer';

  @override
  String get refillNoteTitle => 'Nachfüll-Notiz';

  @override
  String get refillNoteEmpty =>
      'Notiz hinzufügen, z. B. „am 3. Nov. nachgefüllt“';

  @override
  String get refillNoteHint => 'Am 3. Nov. nachgefüllt';

  @override
  String get refillNoteSave => 'Speichern';

  @override
  String get refillNoteRemove => 'Notiz entfernen';

  @override
  String get swatchPhotoTitle => 'Echtes Farbmuster';

  @override
  String get swatchPhotoEmpty =>
      'Foto deines Farbmusters auf Papier hinzufügen';

  @override
  String get swatchPhotoHas => 'Dein Farbmuster auf Papier';

  @override
  String get swatchPhotoView => 'Foto ansehen';

  @override
  String get swatchPhotoTake => 'Foto aufnehmen';

  @override
  String get swatchPhotoChoose => 'Aus der Galerie wählen';

  @override
  String get swatchPhotoSaved => 'Foto gespeichert';

  @override
  String get swatchPhotoSaveFailed =>
      'Das Foto konnte nicht gespeichert werden. Versuche ein anderes.';

  @override
  String get swatchPhotoRemoved => 'Foto entfernt';

  @override
  String get swatchShadowLightTitle => 'Schatten und Licht';

  @override
  String get swatchShadow => 'Schatten';

  @override
  String get swatchLight => 'Licht';

  @override
  String get swatchShadowLightNone => 'Keiner in deiner Sammlung';

  @override
  String get swatchBlendWith => 'Verblenden mit …';

  @override
  String get swatchBlendTitle => 'Verblenden mit';

  @override
  String get swatchBlendSearchHint => 'Marker suchen';

  @override
  String get swatchBlendNoMarkers =>
      'Du hast keine anderen Marker zum Verblenden.';

  @override
  String get swatchBlendNoResults => 'Kein Marker passt zu deiner Suche.';

  @override
  String get swatchBlendSteps => 'Dazwischen, aus deiner Sammlung';

  @override
  String get swatchBlendNothingBetween =>
      'Die beiden liegen nah genug beieinander, um direkt ineinander zu verlaufen.';

  @override
  String get swatchBlendNoneBetween => 'Keiner deiner Marker liegt dazwischen.';

  @override
  String swatchBlendBuy(String code) {
    return 'Großer Sprung. Die Lücke füllt am besten $code, den du noch nicht hast.';
  }

  @override
  String swatchBlendStripSemantics(String from, String to) {
    return 'Verlauf von $from zu $to';
  }

  @override
  String swatchDuplicatesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du hast schon $count Marker, die sehr nah daran liegen',
      one: 'Du hast schon 1 Marker, der sehr nah daran liegt',
    );
    return '$_temp0';
  }

  @override
  String get swatchDuplicatesHint =>
      'Fast dieselbe Farbe, ein neuer bringt kaum etwas.';

  @override
  String swatchDuplicatesMore(int count) {
    return 'und $count weitere';
  }

  @override
  String get swatchDuplicatesNone =>
      'Nichts in deiner Sammlung liegt sehr nah daran: Er würde eine neue Farbe bringen.';

  @override
  String wishlistDuplicateNote(String codes) {
    return 'Sehr ähnlich wie $codes in deiner Sammlung';
  }

  @override
  String wishlistRunningOutCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Marker fast leer',
      one: '1 Marker fast leer',
      zero: 'Kein Marker fast leer',
    );
    return '$_temp0';
  }

  @override
  String get wishlistRunningOutHint =>
      'Sie werden weiter genutzt. Setz sie auf die Liste, wenn du kaufen oder nachfüllen willst.';

  @override
  String swatchesAllBrands(int count) {
    return 'Alle Marken ($count)';
  }

  @override
  String get swatchesOtherBrandsYours => 'Deine Marken';

  @override
  String get inkLevelFullNote =>
      'Voll: Abgleich, Palette und Ideen können ihn vorschlagen.';

  @override
  String get inkLevelRunningOutNote =>
      'Fast leer: wird weiter überall genutzt. Er steht in der Gruppe „Fast leer“ deiner Wunschliste.';

  @override
  String get swatchesDetailPaneEmpty =>
      'Tippe auf einen Marker, um hier seine Details zu sehen.';

  @override
  String get collectionMixBrands => 'Meine Marken mischen';

  @override
  String collectionMoreBrands(String first, String second, int count) {
    return '$first, $second und $count weitere';
  }

  @override
  String collectionBrandsCount(int count) {
    return '$count Marken';
  }

  @override
  String get paletteChanged => 'Palette geändert';

  @override
  String get paletteReplaceTitle => 'Diese Palette ersetzen?';

  @override
  String get paletteReplaceBody =>
      'Die Palette auf dem Bildschirm wird ersetzt, mit deinen Änderungen und deinen gesperrten Farben. Du kannst das direkt danach rückgängig machen.';

  @override
  String get paletteReplaceButton => 'Ersetzen';

  @override
  String get paletteAmbiguousBase =>
      'Diesen Code gibt es in mehreren deiner Marken. Wähle die Marke in der Liste.';

  @override
  String get paletteChainWholeRangeNoteMixed =>
      'Das ganze Sortiment deiner Marken wird angezeigt, auch Marker, die du nicht besitzt.';

  @override
  String paletteBaseOtherBrand(String code, String brand, String example) {
    return '$code ist ein Marker von $brand, und $brand ist gerade nicht in Gebrauch. Versuche $example oder wechsle die Marke in Meiner Sammlung.';
  }

  @override
  String get paletteImportTooFew =>
      'Füge mindestens zwei unterschiedliche, bekannte Markercodes hinzu, um eine Palette zu importieren.';
}
