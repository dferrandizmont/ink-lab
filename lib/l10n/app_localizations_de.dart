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
      'Eine ZIP-Datei mit deinen Daten und den Tagebuchfotos. Speichere sie in Dateien, Drive oder wo du willst. Der API-Schlüssel ist nie enthalten.';

  @override
  String get settingsBackupTextTitle => 'Kopie als Text (ohne Fotos)';

  @override
  String get settingsSaveBackupFile => 'Sicherungsdatei speichern';

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
      'Ink Lab ist ein unabhängiges Community-Projekt: Es steht in keiner Verbindung zu Ohuhu, DecoTime, Copic oder Finecolour und wird weder von ihnen empfohlen noch gesponsert. Die App nutzt deren Markercodes, Namen und Farbwerte nur als sachliche Referenzdaten.';

  @override
  String get paletteTitle => 'Palette';

  @override
  String get paletteBaseCodeLabel => 'Code des Basismarkers';

  @override
  String get paletteBaseCodeHint => 'E08 oder B271';

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
  String get paletteCustomModeHint =>
      'Der Modus Eigene Palette ist manuell: Lade eine gespeicherte Palette oder übernimm eine aus Ideen.';

  @override
  String get paletteNoSuggestions =>
      'Aus deiner Sammlung ließ sich keine Palette erstellen. Probiere einen anderen Modus oder füge mehr Marker hinzu.';

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
  String get swatchesClearSearch => 'Suche leeren';

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
  String get swatchesLoadingSemantics => 'Farben werden geladen';

  @override
  String get swatchesClosestAlternatives => 'Nächste Alternativen';

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
  String get ideasHeaderSubtitleWholeRange =>
      'Übungen mit einer Palette aus dem ganzen Sortiment';

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
  String get ideasNoMarkersOther =>
      'Füge in Meine Sammlung die Marker hinzu, die du besitzt, um eine Palette für diese Idee zu erhalten.';

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
  String get matchEmptyPhotoTitle => 'Noch kein Foto';

  @override
  String get matchEmptyPhotoMessage =>
      'Mach ein Foto oder wähle eines aus der Galerie, um den nächsten Marker zu finden.';

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
      'other': 'Du hast noch keine Marker in deiner Sammlung. Füge sie in Meine Sammlung hinzu.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Wähle einen Basismarker, zum Beispiel $example, oder eine Szene mit dem Chip Szenen.';
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
  String get matchWholeRangeAction => 'Zu Meine Sammlung';

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
  String get collectionDecoRange => 'DecoTime-Sortiment';

  @override
  String get collectionWholeRange => 'Ganzes Sortiment';

  @override
  String get collectionSearchHint => 'Code oder Name suchen';

  @override
  String get collectionTickVisible => 'Alle anhaken';

  @override
  String get collectionUntickVisible => 'Alle abwählen';

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
      'Du hast noch keine Sets gewählt: Es wird das ganze Sortiment genutzt';

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
    return 'Bis du Sets wählst, zeigt die App das ganze $brand-Sortiment.';
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
  String ideasNoMarkersBrand(String brand) {
    return 'Füge unter „Meine Sammlung“ deine $brand-Marker hinzu, um eine Palette für diese Idee zu erhalten.';
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
    return '$count fertig';
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
    return 'Die letzten $count Monate.';
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
}
