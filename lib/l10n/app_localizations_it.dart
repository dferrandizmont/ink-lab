// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get settingsTitle => 'Opzioni';

  @override
  String get settingsCollectionGroup => 'La mia collezione';

  @override
  String get settingsDisplayGroup => 'Aspetto';

  @override
  String get settingsDataGroup => 'I tuoi dati';

  @override
  String get settingsAiGroup => 'Assistente IA';

  @override
  String get settingsAiOffByDefault => 'Disattivata di default';

  @override
  String get settingsUnavailable =>
      'I servizi dell’app non sono disponibili, quindi non si possono mostrare le impostazioni.';

  @override
  String get settingsBrandTitle => 'Marca';

  @override
  String get settingsBrandSubtitle =>
      'La marca sceglie il catalogo di pennarelli con cui lavora l’app.';

  @override
  String get settingsPalettesTitle => 'Palette salvate';

  @override
  String get settingsClearPalettes => 'Elimina tutte';

  @override
  String get settingsClearPalettesTitle =>
      'Eliminare tutte le palette salvate?';

  @override
  String get settingsClearPalettesBody =>
      'Le palette salvate per questa marca verranno eliminate. Non si può annullare.';

  @override
  String get settingsFavoritesTitle => 'Preferiti';

  @override
  String get settingsFavoritesEmpty => 'Nessun colore tra i preferiti.';

  @override
  String get settingsClearFavorites => 'Rimuovi tutti';

  @override
  String get settingsClearFavoritesTitle => 'Rimuovere tutti i preferiti?';

  @override
  String get settingsClearFavoritesBody =>
      'I colori preferiti di questa marca verranno rimossi. Non si può annullare.';

  @override
  String get settingsDeleteFavorite => 'Rimuovi dai preferiti';

  @override
  String get settingsLabelsTitle => 'Codici Ohuhu';

  @override
  String get settingsLabelsSubtitle =>
      'Nel 2023 Ohuhu ha cambiato i suoi codici.';

  @override
  String get settingsNewLabels => 'Nuovi';

  @override
  String get settingsOldLabels => 'Vecchi';

  @override
  String get settingsBothLabels => 'Entrambi';

  @override
  String get settingsAppearanceTitle => 'Tema';

  @override
  String get settingsAppearanceSystem => 'Sistema';

  @override
  String get settingsAppearanceLight => 'Chiaro';

  @override
  String get settingsAppearanceDark => 'Scuro';

  @override
  String get settingsBackupSubtitle =>
      'Copia i tuoi dati (collezione, palette, diario, cronologia e impostazioni) negli appunti come testo, per importarli più tardi. Foto e chiave API non sono incluse.';

  @override
  String get settingsExportBackup => 'Esporta';

  @override
  String get settingsImportBackup => 'Importa';

  @override
  String get settingsBackupExported =>
      'Backup copiato negli appunti, senza le foto';

  @override
  String get settingsBackupImported => 'Backup importato';

  @override
  String get settingsImportTitle => 'Importa un backup';

  @override
  String get settingsImportHint => 'Incolla qui il JSON esportato';

  @override
  String get settingsImportConfirm => 'Importa';

  @override
  String get settingsCancel => 'Annulla';

  @override
  String get settingsImportConfirmTitle => 'Sostituire i tuoi dati attuali?';

  @override
  String get settingsImportConfirmBody =>
      'Il backup sostituisce i tuoi dati attuali: collezione, palette, diario, cronologia e impostazioni. Le voci del diario che non contiene vengono eliminate con le loro foto; le foto non fanno mai parte di un backup.';

  @override
  String get ideasFavoritesChip => 'Preferite';

  @override
  String get ideasFavoritesEmptyTitle => 'Ancora nessuna idea preferita';

  @override
  String get ideasFavoritesEmptyMessage =>
      'Tocca il cuore di un’idea per tenerla qui.';

  @override
  String get ideasRecentTitle => 'Viste di recente';

  @override
  String get settingsBackupFileCaption =>
      'Un file ZIP con i tuoi dati e tutte le tue foto: diario, campioni e ricette. Nel menu di condivisione scegli File, Drive o un’altra app per conservarlo. La chiave API non è mai inclusa.';

  @override
  String get settingsBackupTextTitle => 'Copia come testo (senza foto)';

  @override
  String get settingsSaveBackupFile => 'Condividi il file di backup';

  @override
  String get settingsRestoreBackupFile => 'Ripristina da file';

  @override
  String get settingsBackupFileSaving => 'Preparo i tuoi dati e le foto…';

  @override
  String get settingsBackupFileRestoring => 'Ripristino del backup…';

  @override
  String get settingsRestoreConfirmBody =>
      'Il file sostituisce i tuoi dati attuali: collezione, palette, diario, cronologia e impostazioni. Vengono ripristinate anche le foto del file. Le voci del diario che non contiene vengono eliminate con le loro foto.';

  @override
  String get settingsBackupFileRestored => 'Backup ripristinato, foto comprese';

  @override
  String get settingsBackupFileSaveFailed =>
      'Non è stato possibile creare il file di backup.';

  @override
  String get settingsBackupFileReadFailed =>
      'Non è stato possibile leggere il file.';

  @override
  String get settingsBackupFileNotZip => 'Quel file non è un backup ZIP.';

  @override
  String get settingsBackupFileTooLarge =>
      'Il backup è troppo grande per Ink Lab.';

  @override
  String get settingsBackupFileEntryTooLarge =>
      'Una foto del backup è troppo grande.';

  @override
  String get settingsBackupFileDamaged =>
      'Il file è danneggiato o non è un backup di Ink Lab.';

  @override
  String get settingsBackupFileUnsupported =>
      'Questo backup viene da una versione che Ink Lab non sa leggere.';

  @override
  String get settingsBackupFileNotAPhoto =>
      'Una foto del file non è un’immagine JPEG, PNG o WebP.';

  @override
  String get settingsBackupFileWriteFailed =>
      'Non è stato possibile salvare le foto. I tuoi dati non sono cambiati.';

  @override
  String get settingsImportInvalidJson => 'Il testo non è un JSON valido.';

  @override
  String get settingsImportInvalidDocument =>
      'Il testo non è un documento di backup.';

  @override
  String get settingsAiTitle => 'Assistente IA';

  @override
  String get settingsAiSubtitle =>
      'L’IA suggerisce solo palette. Non modifica mai la tua collezione.';

  @override
  String get settingsAiEnabled => 'Suggerisci con l’IA';

  @override
  String get settingsAiEnabledSubtitleColourTheory =>
      'Scegli Sul dispositivo o OpenRouter qui sotto per usare un’IA';

  @override
  String get settingsAiEnabledSubtitleColourTheoryNoOnDevice =>
      'Scegli OpenRouter qui sotto per usare un’IA';

  @override
  String get settingsAiEnabledSubtitleOnDevice =>
      'Gemini Nano su questo telefono';

  @override
  String get settingsAiEnabledSubtitleOpenRouter =>
      'Usa la tua chiave OpenRouter';

  @override
  String get settingsAiExplainColourTheory =>
      'Le palette arrivano dal motore di teoria del colore integrato. Nessuna IA, niente esce dal telefono.';

  @override
  String get settingsAiExplainOnDevice =>
      'Gemini Nano gira su questo telefono e le tue richieste restano qui. ML Kit di Google invia a Google dati diagnostici di utilizzo.';

  @override
  String get settingsAiExplainOpenRouter =>
      'Le richieste vanno a openrouter.ai con la tua chiave. Le foto non vengono mai inviate.';

  @override
  String get settingsAiProvider => 'Fornitore';

  @override
  String get settingsAiProviderColourTheory => 'Teoria del colore';

  @override
  String get settingsAiProviderOnDevice => 'Sul dispositivo';

  @override
  String get settingsAiProviderOpenRouter => 'OpenRouter';

  @override
  String get settingsAiTextModel => 'Modello di testo';

  @override
  String get settingsAiTextModelHint =>
      'ID del modello per le richieste di testo';

  @override
  String get settingsAiVisionModel => 'Modello visivo';

  @override
  String get settingsAiVisionModelHint =>
      'ID del modello per le richieste con immagini';

  @override
  String get settingsAiTemperature => 'Temperatura';

  @override
  String get settingsAiMaxTokens => 'Token massimi';

  @override
  String get settingsAiAutoFallback => 'Alternativa integrata';

  @override
  String get settingsAiAutoFallbackSubtitle =>
      'Se l’IA non funziona, risponde il motore integrato.';

  @override
  String get settingsAiApiKey => 'Chiave API';

  @override
  String get settingsAiApiKeySubtitle =>
      'La tua chiave, conservata nell’archivio sicuro di questo dispositivo.';

  @override
  String get settingsAiApiKeySave => 'Salva chiave';

  @override
  String get settingsAiApiKeyRemove => 'Rimuovi';

  @override
  String get settingsAiApiKeySaved => 'Chiave salvata.';

  @override
  String get settingsAiRemoveKeyTitle => 'Rimuovere la chiave API?';

  @override
  String get settingsAiRemoveKeyBody =>
      'La chiave viene eliminata da questo dispositivo. I suggerimenti IA si fermano finché non inserisci di nuovo una chiave.';

  @override
  String get settingsAiRemoveKeyConfirm => 'Rimuovi';

  @override
  String get settingsAiApiKeyInvalid =>
      'Non sembra una chiave OpenRouter. Deve iniziare con sk-or- e non avere spazi.';

  @override
  String get settingsAiApiKeyUnreadable =>
      'Non è stato possibile leggere la chiave salvata. Inseriscila di nuovo.';

  @override
  String get settingsAiApiKeyStorageError =>
      'Non è stato possibile salvare la chiave. Riprova.';

  @override
  String get settingsAiDisclosureTitle => 'Attivare i suggerimenti IA?';

  @override
  String get settingsAiDisclosure =>
      'Quando è attivo e chiedi un suggerimento a OpenRouter, l’app invia a openrouter.ai e al fornitore del modello, con la tua chiave API: la marca, la modalità e la scena della palette, il codice e il nome del pennarello base e se è bloccato, la dimensione della palette, i codici e i colori hex dei pennarelli candidati, le impostazioni del modello e le istruzioni fisse dell’app. Le foto non vengono mai inviate: questa funzione non carica immagini. Su Android l’app può anche chiedere a ML Kit di Google se Gemini Nano è disponibile; ML Kit invia a Google dati diagnostici di utilizzo. Non viene inviato nulla finché questo interruttore è spento.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'Con la teoria del colore selezionata, le palette arrivano dal motore integrato: non si usa alcuna IA e restano sul telefono. Su Android l’app può chiedere a ML Kit di Google se Gemini Nano è disponibile; ML Kit invia a Google dati diagnostici di utilizzo, mai i tuoi colori né le tue foto. Scegli Sul dispositivo o OpenRouter per usare un’IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'Con la teoria del colore selezionata, le palette arrivano dal motore integrato: non si usa alcuna IA e restano sul telefono. Su Android l’app può chiedere a ML Kit di Google se Gemini Nano è disponibile; ML Kit invia a Google dati diagnostici di utilizzo, mai i tuoi colori né le tue foto. Scegli OpenRouter per usare un’IA.';

  @override
  String get settingsAiDisclosureConfirm => 'Attiva';

  @override
  String get settingsAiDisclosureCancel => 'Non ora';

  @override
  String get settingsAiDisclosureOnDevice =>
      'Le richieste sul dispositivo (Gemini Nano) trovano risposta nel modello di questo telefono: lo scenario e i codici colore non lo lasciano mai e non serve alcuna chiave. Per verificare, scaricare ed eseguire il modello, l’app usa ML Kit di Google, che invia a Google dati diagnostici di utilizzo (modello del telefono, versione dell’app, identificatori per installazione, errori e dimensioni), mai i tuoi prompt, colori o foto. Non viene inviato nulla finché questo interruttore è spento.';

  @override
  String get settingsAiOnDeviceName => 'Sul dispositivo (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Le tue richieste restano su questo telefono. ML Kit invia a Google dati diagnostici di utilizzo, mai i tuoi prompt, colori o foto.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'Il modello non è ancora su questo telefono. Android lo scarica una volta e lo tiene per tutte le app.';

  @override
  String get settingsAiOnDeviceDownloading => 'Download del modello…';

  @override
  String get settingsAiOnDevicePreparing =>
      'Android sta preparando il modello. Può volerci un po’ e potrebbe aspettare il Wi‑Fi e la ricarica. Puoi uscire da questa schermata: il download continua in background.';

  @override
  String get settingsAiEnabledSubtitleOnDeviceIos =>
      'Apple Intelligence su questo telefono';

  @override
  String get settingsAiExplainOnDeviceIos =>
      'Il modello di Apple gira su questo telefono e le tue richieste restano qui.';

  @override
  String get settingsAiDisclosureOnDeviceIos =>
      'Le richieste sul dispositivo (Apple Intelligence) trovano risposta nel modello di Apple su questo telefono: lo scenario e i codici colore non lo lasciano mai e non serve alcuna chiave. iOS installa e gestisce il modello con Apple Intelligence; l’app non scarica nulla e non usa altri servizi per questo, quindi non viene inviato nulla.';

  @override
  String get settingsAiOnDeviceNameIos =>
      'Sul dispositivo (Apple Intelligence)';

  @override
  String get settingsAiOnDevicePrivacyIos =>
      'Le tue richieste restano su questo telefono. Non viene inviato nulla: né prompt, né colori, né foto.';

  @override
  String get settingsAiOnDevicePreparingIos =>
      'iOS sta preparando il modello di Apple Intelligence. Può volerci un po’. Puoi uscire da questa schermata: continua in background.';

  @override
  String get settingsAiDisclosureIos =>
      'Quando è attivo e chiedi un suggerimento a OpenRouter, l’app invia a openrouter.ai e al fornitore del modello, con la tua chiave API: la marca, la modalità e la scena della palette, il codice e il nome del pennarello base e se è bloccato, la dimensione della palette, i codici e i colori hex dei pennarelli candidati, le impostazioni del modello e le istruzioni fisse dell’app. Le foto non vengono mai inviate: questa funzione non carica immagini. Non viene inviato nulla finché questo interruttore è spento.';

  @override
  String get settingsAiDisclosureColourTheoryIos =>
      'Con la teoria del colore selezionata, le palette arrivano dal motore integrato: non si usa alcuna IA e restano sul telefono. Scegli Sul dispositivo o OpenRouter per usare un’IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDeviceIos =>
      'Con la teoria del colore selezionata, le palette arrivano dal motore integrato: non si usa alcuna IA e restano sul telefono. Scegli OpenRouter per usare un’IA.';

  @override
  String get settingsAiOnDeviceCheckAgain => 'Controlla di nuovo';

  @override
  String get settingsAiOnDeviceReady =>
      'Il modello è pronto su questo telefono.';

  @override
  String get settingsAiOnDeviceDownload => 'Scarica il modello';

  @override
  String get settingsAiOnDeviceFailed =>
      'Il download non è terminato. Controlla la connessione e riprova.';

  @override
  String get settingsAiTestConnection => 'Prova la connessione';

  @override
  String get settingsAiTestingConnection => 'Prova in corso…';

  @override
  String get settingsAiModelsTitle => 'Modello';

  @override
  String get settingsAiModelsFilterFree => 'Gratis';

  @override
  String get settingsAiModelsFilterPaid => 'A pagamento';

  @override
  String get settingsAiModelsFilterBoth => 'Tutti';

  @override
  String get settingsAiModelsLoad => 'Carica modelli';

  @override
  String get settingsAiModelsEmpty =>
      'Nessun modello corrisponde a questo filtro.';

  @override
  String get settingsAiModelsNeedsKey =>
      'Salva una chiave per caricare i modelli da OpenRouter.';

  @override
  String get settingsAiPrimaryModel => 'Modello di testo';

  @override
  String get settingsAiModelNone => 'Non impostato';

  @override
  String get settingsAiModelsPickerHint =>
      'Carica i modelli, poi scegli dall’elenco.';

  @override
  String get settingsAiModelSearchHint => 'Cerca modelli';

  @override
  String get settingsAiModelFree => 'Gratis';

  @override
  String get settingsAiModelPaid => 'A pagamento';

  @override
  String get settingsAiModelsDone => 'Fatto';

  @override
  String get settingsAiModelsNotLoaded =>
      'Carica prima i modelli, o scrivi un ID modello qui sopra.';

  @override
  String get settingsAiRecommended => 'Consigliati';

  @override
  String get settingsAiFreeModelsNote =>
      'I modelli gratuiti possono essere lenti o poco affidabili. I consigliati costano poco e rispondono in modo più costante.';

  @override
  String get settingsAiAllModels => 'Tutti i modelli';

  @override
  String get settingsAiRecommendedDefault => 'Predefinito consigliato';

  @override
  String get settingsAiFallbacksTitle => 'Alternative';

  @override
  String get settingsAboutTitle => 'Informazioni';

  @override
  String get settingsVersion => 'Versione';

  @override
  String get settingsSourceCode => 'Codice sorgente';

  @override
  String get settingsPrivacyPolicy => 'Informativa sulla privacy';

  @override
  String get settingsCopyRepository => 'Copia il link';

  @override
  String get settingsRepositoryCopied => 'Link copiato';

  @override
  String get settingsDisclaimer =>
      'Ink Lab è un progetto indipendente della comunità: non è affiliato, approvato né sponsorizzato da nessuna delle marche di pennarelli elencate. Usa i loro codici, nomi e valori di colore solo come dati di riferimento fattuali.';

  @override
  String get paletteTitle => 'Palette';

  @override
  String get paletteBaseCodeLabel => 'Codice del pennarello base';

  @override
  String paletteBaseCodeHint(String first, String second) {
    return '$first o $second';
  }

  @override
  String paletteBaseCodeHintOne(String code) {
    return '$code';
  }

  @override
  String get paletteScenarioToggle => 'Scene';

  @override
  String get paletteTypeTitle => 'Tipo di palette';

  @override
  String get paletteTypeSheetTitle => 'Scegli il tipo di palette';

  @override
  String get paletteTypeTheoryGroup => 'Teoria del colore';

  @override
  String get paletteTypeScenesGroup => 'Scene';

  @override
  String get paletteTypeScenesHint => 'Ricette pronte per soggetto';

  @override
  String get paletteTypeDescRecommended => 'Scelte equilibrate per la tua base';

  @override
  String get paletteTypeDescComplementary => 'Tinta opposta, forte contrasto';

  @override
  String get paletteTypeDescAnalogous => 'Tinte vicine, calme';

  @override
  String get paletteTypeDescSplitComplementary =>
      'Due tinte accanto all’opposta';

  @override
  String get paletteTypeDescTriad => 'Tre tinte equidistanti';

  @override
  String get paletteTypeDescSquare => 'Quattro tinte equidistanti';

  @override
  String get paletteTypeDescRectangle => 'Due coppie complementari';

  @override
  String get paletteTypeDescMonochrome => 'Una tinta, da chiara a scura';

  @override
  String get paletteTypeDescShadow => 'Toni più profondi per le ombre';

  @override
  String get paletteTypeDescCustomPalette => 'Costruiscila a mano';

  @override
  String get modeBlendingChain => 'Catena di sfumature';

  @override
  String get paletteTypeDescBlendingChain => 'Chiaro-scuro, da sfumare';

  @override
  String paletteChainResultTitle(int count) {
    return 'Sfumature ($count)';
  }

  @override
  String paletteChainStep(int step, String role) {
    return 'Passo $step · $role';
  }

  @override
  String get roleLightest => 'Il più chiaro';

  @override
  String get roleLighter => 'Più chiaro';

  @override
  String get roleDarker => 'Più scuro';

  @override
  String get roleDarkest => 'Il più scuro';

  @override
  String get paletteChainHint =>
      'Lavora da chiaro a scuro e sovrapponi ogni passo mentre l’inchiostro è ancora bagnato. Ammorbidisci i passaggi con il blender incolore, se ce l’hai.';

  @override
  String paletteChainShort(int count, int wanted) {
    return 'Solo $count dei tuoi pennarelli si sfumano bene con questa base, meno dei $wanted richiesti.';
  }

  @override
  String get paletteChainNeedLighter =>
      'Ancora nessuna catena: ti serve un pennarello più chiaro in questa famiglia.';

  @override
  String get paletteChainNeedDarker =>
      'Ancora nessuna catena: ti serve un pennarello più scuro in questa famiglia.';

  @override
  String get paletteChainNeedBoth =>
      'Ancora nessuna catena: ti servono un pennarello più chiaro e uno più scuro in questa famiglia.';

  @override
  String get paletteChainBaseLightest =>
      'Non hai niente di più chiaro in questa famiglia, quindi la catena parte dalla tua base.';

  @override
  String get paletteChainBaseDarkest =>
      'Non hai niente di più scuro in questa famiglia, quindi la catena finisce sulla tua base.';

  @override
  String get paletteChainOptionsLabel => 'Altre catene';

  @override
  String paletteChainOption(int number) {
    return 'Opzione $number';
  }

  @override
  String get paletteChainWholeRange => 'Cerca in tutta la gamma';

  @override
  String paletteChainWholeRangeNote(String brand) {
    return 'Mostra tutta la gamma $brand, anche i pennarelli che non hai.';
  }

  @override
  String get paletteChainMyMarkers => 'Torna ai miei pennarelli';

  @override
  String get palettePaintTipChainFirst =>
      'Stendi prima il colore più chiaro su tutta l’area.';

  @override
  String get palettePaintTipChainMiddle =>
      'Sovrapponi il passo precedente mentre è ancora bagnato.';

  @override
  String get palettePaintTipChainLast =>
      'Finisci con il più scuro solo dove cade l’ombra.';

  @override
  String get swatchesBlendingChain => 'Catena di sfumature';

  @override
  String paletteTypeSemantic(String value) {
    return 'Tipo di palette, $value';
  }

  @override
  String get paletteSceneTitle => 'Scena';

  @override
  String get paletteSceneSheetTitle => 'Scegli una scena';

  @override
  String get paletteSceneSearchHint => 'Cerca scena o categoria';

  @override
  String get paletteSceneEmpty => 'Nessuna scena corrisponde alla ricerca.';

  @override
  String paletteSceneSemantic(String value) {
    return 'Scena, $value';
  }

  @override
  String get paletteFromPhotoTitle => 'Da una foto';

  @override
  String get paletteFromPhotoHint => 'La tua foto, con i tuoi pennarelli';

  @override
  String get paletteFromPhotoValue => 'La tua foto';

  @override
  String paletteFromPhotoRole(int percent) {
    return 'Colore della foto · $percent %';
  }

  @override
  String get paletteFromPhotoEmpty =>
      'Non è stato possibile ricavare colori da questa foto';

  @override
  String get paletteFromPhotoFarNote =>
      'Alcuni colori della foto non hanno un pennarello vicino nella tua collezione';

  @override
  String get sceneCategoryCharacters => 'Personaggi';

  @override
  String get sceneCategorySkin => 'Pelle e ritratti';

  @override
  String get sceneCategorySkyWater => 'Cielo e acqua';

  @override
  String get sceneCategoryNature => 'Natura';

  @override
  String get sceneCategoryMaterials => 'Materiali';

  @override
  String get sceneCategoryAnimals => 'Animali e pelo';

  @override
  String get sceneCategoryFood => 'Cibo';

  @override
  String get sceneCategoryHolidays => 'Feste e atmosfere';

  @override
  String get sceneCategoryInteriors => 'Interni';

  @override
  String get sceneCategoryPatterns => 'Motivi';

  @override
  String get sceneCategoryFantasy => 'Fantasy';

  @override
  String get paletteSizeTitle => 'Dimensione';

  @override
  String get paletteSizeSemantic => 'Dimensione della palette';

  @override
  String get paletteGenerateButton => 'Genera';

  @override
  String get paletteRegenerateButton => 'Rigenera';

  @override
  String get paletteClearButton => 'Cancella';

  @override
  String get paletteSuggestAiButton => 'Suggerisci con l’IA';

  @override
  String get paletteSuggestAiLoading => 'Sto suggerendo…';

  @override
  String get paletteAiBadge => 'IA';

  @override
  String get paletteSaveButton => 'Salva palette';

  @override
  String get paletteSavedButton => 'Palette salvata';

  @override
  String get paletteShareButton => 'Condividi';

  @override
  String get shareFailed => 'Non è stato possibile condividere l’immagine.';

  @override
  String get paletteOkButton => 'OK';

  @override
  String get paletteBaseMarkerTitle => 'Pennarello base';

  @override
  String get paletteVariationsLabel => 'Varianti';

  @override
  String get palettePaintPlanTitle => 'Ordine di colorazione';

  @override
  String get palettePaintTipBase =>
      'Prima campisci la forma generale con il colore base.';

  @override
  String get palettePaintTipShadow =>
      'Stendi quest’ombra dove la luce non arriva.';

  @override
  String get palettePaintTipHighlight =>
      'Metti la luce dove colpisce direttamente.';

  @override
  String get palettePaintTipAccent =>
      'Riserva l’accento solo alle zone focali.';

  @override
  String get palettePaintTipSupport =>
      'Usa questo tono di supporto per sfumare i passaggi.';

  @override
  String get paletteSubtitleIdle =>
      'Crea una palette da un pennarello base che hai';

  @override
  String get paletteLockButton => 'Blocca';

  @override
  String get paletteUnlockButton => 'Sblocca';

  @override
  String get paletteSaveDialogTitle => 'Salva palette';

  @override
  String get paletteSaveDialogHint => 'Nome della palette';

  @override
  String get paletteSaveDialogCancel => 'Annulla';

  @override
  String get paletteSaveDialogConfirm => 'Salva';

  @override
  String get paletteSavedTitle => 'Palette salvate';

  @override
  String get paletteSavedEmpty =>
      'Ancora nessuna palette salvata per questa marca.';

  @override
  String palettePaintPlanSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count passi',
      one: '1 passo',
    );
    return '$_temp0';
  }

  @override
  String get paletteLoadButton => 'Carica';

  @override
  String get paletteDeleteButton => 'Elimina';

  @override
  String get paletteDeleteDialogTitle => 'Eliminare la palette?';

  @override
  String get paletteDeleteDialogBody => 'Questa azione non si può annullare.';

  @override
  String get paletteAiReportButton => 'Segnala questo suggerimento';

  @override
  String get paletteAiReportTitle => 'Segnala questo suggerimento';

  @override
  String get paletteAiReportBody =>
      'Dicci se l’IA ha scritto qualcosa di offensivo, inappropriato o sbagliato. Si aprirà la tua app di posta con il testo del suggerimento; decidi tu se inviarlo. La tua chiave API non è mai inclusa.';

  @override
  String get paletteAiReportOffensive => 'Offensivo o inappropriato';

  @override
  String get paletteAiReportWrong => 'Sbagliato o senza senso';

  @override
  String get paletteAiReportOther => 'Altro';

  @override
  String get paletteAiReportSend => 'Invia per e-mail';

  @override
  String get paletteAiReportThanks =>
      'Grazie, ci aiuta a migliorare i suggerimenti';

  @override
  String get paletteAiReportCopied =>
      'Nessuna app di posta trovata. La segnalazione è stata copiata: incollala in un’e-mail a inklab@mainshai.com';

  @override
  String get paletteAiFellBack =>
      'IA non disponibile. Mostro i suggerimenti locali.';

  @override
  String get paletteEmptyHint =>
      'Scegli un pennarello base per creare una palette, oppure scegli Scene come tipo di palette.';

  @override
  String get paletteCustomModeHint =>
      'La modalità palette personalizzata è manuale: carica una palette salvata o applicane una da Idee.';

  @override
  String get paletteNoSuggestions =>
      'Con la tua collezione non è stato possibile creare nessuna palette. Prova un’altra modalità o aggiungi altri pennarelli.';

  @override
  String get paletteScenarioTitle => 'Scene';

  @override
  String get palettePickBaseTooltip => 'Scegli tra i tuoi pennarelli';

  @override
  String get palettePickerTitle => 'Scegli un pennarello base';

  @override
  String get palettePickerSearchHint => 'Codice o nome';

  @override
  String get palettePickerEmpty =>
      'Nessun pennarello corrisponde alla ricerca.';

  @override
  String get paletteUndoButton => 'Annulla';

  @override
  String paletteBaseReplaced(String code) {
    return '$code è ora la base. La palette precedente è stata sostituita.';
  }

  @override
  String paletteIdeaApplied(String title, int count) {
    return 'Palette «$title» applicata ($count pennarelli).';
  }

  @override
  String get swatchesTitle => 'Campioni';

  @override
  String get swatchesSearchHint => 'Codice, nome o hex';

  @override
  String swatchesClosestTo(String hex) {
    return 'Più vicini a $hex';
  }

  @override
  String get swatchesClearSearch => 'Azzera ricerca';

  @override
  String get swatchesAllFilter => 'Tutti';

  @override
  String get swatchesFavoritesOnly => 'Preferiti';

  @override
  String get swatchesOwnedOnly => 'Miei';

  @override
  String get swatchesFilters => 'Filtri';

  @override
  String get swatchesFiltersTitle => 'Filtri';

  @override
  String get swatchesLabelPack => 'Set';

  @override
  String get swatchesLabelLayout => 'Vista';

  @override
  String get swatchesAllPacks => 'Tutti i set';

  @override
  String get swatchesClearFilters => 'Azzera filtri';

  @override
  String get swatchesClearSearchAndFilters => 'Azzera ricerca e filtri';

  @override
  String get swatchesLoadingSemantics => 'Caricamento colori';

  @override
  String get swatchesClosestAlternatives => 'Alternative più vicine';

  @override
  String get swatchesNoCloseAlternatives => 'Nessuna alternativa vicina';

  @override
  String get swatchesInPacks => 'Nei set';

  @override
  String get swatchesLocation => 'Posizione';

  @override
  String get swatchesAddToPalette => 'Aggiungi alla palette';

  @override
  String get swatchesLayoutGrid => 'Griglia';

  @override
  String get swatchesLayoutList => 'Elenco';

  @override
  String get swatchesOwned => 'Posseduto';

  @override
  String get swatchesNewLabels => 'Nuovi';

  @override
  String get swatchesOldLabels => 'Vecchi';

  @override
  String get swatchesBothLabels => 'Entrambi';

  @override
  String get swatchesLabelMode => 'Codici';

  @override
  String get swatchesToggleLayout => 'Passa tra griglia ed elenco';

  @override
  String get swatchesGridLayout => 'Griglia';

  @override
  String get swatchesListLayout => 'Elenco';

  @override
  String get swatchesNewCode => 'Codice nuovo';

  @override
  String get swatchesOldCode => 'Codice vecchio';

  @override
  String get swatchesNewName => 'Nome nuovo';

  @override
  String get swatchesOldName => 'Nome vecchio';

  @override
  String get swatchesHex => 'Hex';

  @override
  String get swatchesCopyHex => 'Copia hex';

  @override
  String get swatchesHexCopied => 'Hex copiato negli appunti';

  @override
  String get swatchesAddFavorite => 'Aggiungi ai preferiti';

  @override
  String get swatchesRemoveFavorite => 'Rimuovi dai preferiti';

  @override
  String get swatchesEmptyNoOwnedTitle => 'Ancora nessun pennarello';

  @override
  String get swatchesEmptyNoOwnedBody =>
      'Non hai ancora aggiunto nessun pennarello. Dì all’app quali set e pennarelli hai.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Configura la mia collezione';

  @override
  String get swatchesEmptyNoOwnedHint => 'Apri Opzioni, poi La mia collezione.';

  @override
  String get swatchesEmptySearchTitle => 'Nessun colore trovato';

  @override
  String get swatchesEmptySearchBody =>
      'Nessun colore di questa collezione corrisponde alla ricerca.';

  @override
  String get swatchesEmptyFiltersTitle => 'Niente da mostrare';

  @override
  String get swatchesEmptyFiltersBody =>
      'Questa marca non ha colori per i set e i filtri scelti.';

  @override
  String get swatchesEmptyNoFavoritesTitle => 'Ancora nessun preferito';

  @override
  String get swatchesEmptyNoFavoritesBody =>
      'Tocca la stella nei dettagli di un colore per aggiungerlo.';

  @override
  String get swatchesEmptyNoFavoritesAction => 'Mostra tutti i colori';

  @override
  String get swatchesEmptyFavoritesNotMineTitle =>
      'Nessun preferito nella tua collezione';

  @override
  String get swatchesEmptyFavoritesNotMineBody =>
      'Nessuno dei tuoi preferiti è tra i pennarelli che hai.';

  @override
  String get swatchesEmptyFavoritesNotMineAction => 'Mostra tutti i preferiti';

  @override
  String get swatchesLoading => 'Caricamento colori…';

  @override
  String get swatchesLoadFailedTitle => 'Colori non disponibili';

  @override
  String get swatchesLoadFailedBody =>
      'Non è stato possibile leggere il catalogo dei pennarelli, quindi non si possono mostrare i colori.';

  @override
  String get swatchesUnavailable =>
      'I servizi dell’app non sono disponibili, quindi non si possono mostrare i campioni.';

  @override
  String get swatchesVisibleCount => 'Colori';

  @override
  String get swatchesScopeCollection => 'La tua collezione';

  @override
  String get swatchesScopePack => 'Set';

  @override
  String get ideasTitle => 'Idee';

  @override
  String get ideasHeaderSubtitle => 'Esercizi con i tuoi pennarelli';

  @override
  String get ideasHeaderSubtitleWholeRange =>
      'Esercizi con una palette di tutta la gamma';

  @override
  String get ideasSearchHint => 'Cerca idee';

  @override
  String get ideasCategoryAll => 'Tutte';

  @override
  String get ideasApplyButton => 'Usa in Palette';

  @override
  String get ideasMoreDetails => 'Più dettagli';

  @override
  String get ideasGuideOnlyNote =>
      'Questo esercizio usa tutta la tua collezione, quindi non ha una palette fissa.';

  @override
  String get ideasNoMarkersOther =>
      'Aggiungi in La mia collezione i pennarelli che hai per ottenere una palette per questa idea.';

  @override
  String get ideasCategoriesLabel => 'Categorie';

  @override
  String get ideasEmptyTitle => 'Nessuna idea trovata';

  @override
  String get ideasClearFilters => 'Azzera filtri';

  @override
  String get ideasEmptySearch => 'Nessuna idea corrisponde alla ricerca.';

  @override
  String get ideasNoMarkers => 'Nessun pennarello disponibile al momento';

  @override
  String get ideasTulipFieldTitle => 'Campo di tulipani';

  @override
  String get ideasTulipFieldSummary =>
      'File di tulipani rossi e gialli fino all’orizzonte, con il verde primaverile in mezzo.';

  @override
  String get ideasTulipFieldPractice =>
      'Bande piatte che si spezzano in punti man mano che si avvicinano.';

  @override
  String get ideasTulipFieldSubject =>
      'File di tulipani viste dal basso, con l’orizzonte basso.';

  @override
  String get ideasTulipFieldTip =>
      'La fila più vicina è fatta di punti, la più lontana è una striscia: cambia il segno man mano che la fila si allontana.';

  @override
  String get ideasTulipFieldStep1 =>
      'Disegna a matita file che si restringono verso un orizzonte basso.';

  @override
  String get ideasTulipFieldStep2 =>
      'Colora di rosso le prime file: macchie singole vicino, una striscia piena più lontano.';

  @override
  String get ideasTulipFieldStep3 =>
      'Colora di giallo le file successive, allo stesso modo.';

  @override
  String get ideasTulipFieldStep4 =>
      'Colora di verde chiaro tra le file e lungo l’orizzonte.';

  @override
  String get ideasTulipFieldStep5 =>
      'Aggiungi un verde più scuro in una linea sottile ai piedi di ogni fila.';

  @override
  String get ideasSummerBeachTitle => 'In spiaggia';

  @override
  String get ideasSummerBeachSummary =>
      'Sabbia, una striscia di mare, un ombrellone: tre bande piatte e un accento vivace.';

  @override
  String get ideasSummerBeachPractice =>
      'Tre bande piatte e un solo accento che guida lo sguardo.';

  @override
  String get ideasSummerBeachSubject =>
      'Una spiaggia vista dalla sabbia, con un ombrellone.';

  @override
  String get ideasSummerBeachTip =>
      'Lascia la schiuma come carta: è la linea più luminosa del mare.';

  @override
  String get ideasSummerBeachStep1 =>
      'Disegna a matita tre bande orizzontali (cielo, mare, sabbia) e un ombrellone sulla sabbia.';

  @override
  String get ideasSummerBeachStep2 =>
      'Colora la sabbia chiara con mano leggera; lascia più chiara la sabbia bagnata vicino all’acqua.';

  @override
  String get ideasSummerBeachStep3 =>
      'Colora il mare di verde acqua chiaro, lasciando una linea di carta per la schiuma.';

  @override
  String get ideasSummerBeachStep4 =>
      'Aggiungi un verde acqua più intenso all’orizzonte.';

  @override
  String get ideasSummerBeachStep5 =>
      'Colora l’ombrellone di rosso e fai la sua piccola ombra sulla sabbia con un secondo strato del colore della sabbia.';

  @override
  String get ideasWatermelonSliceTitle => 'Anguria';

  @override
  String get ideasWatermelonSliceSummary =>
      'Una fetta di anguria: polpa rossa, parte bianca, buccia verde, semi neri.';

  @override
  String get ideasWatermelonSlicePractice =>
      'Una sfumatura veloce e una striscia piatta, con la parte bianca lasciata come carta.';

  @override
  String get ideasWatermelonSliceSubject =>
      'Una fetta triangolare di anguria con la base curva.';

  @override
  String get ideasWatermelonSliceTip =>
      'La parte bianca è carta: non colorarla affatto.';

  @override
  String get ideasWatermelonSliceStep1 =>
      'Disegna a matita un triangolo con la base curva e una banda bianca sottile dentro il verde.';

  @override
  String get ideasWatermelonSliceStep2 =>
      'Stendi il rosso chiaro sulla polpa, più pallido vicino alla parte bianca.';

  @override
  String get ideasWatermelonSliceStep3 =>
      'Aggiungi un rosso più intenso verso la punta e sfumalo mentre è bagnato.';

  @override
  String get ideasWatermelonSliceStep4 =>
      'Colora di verde la buccia, con strisce di verde scuro in un secondo strato.';

  @override
  String get ideasWatermelonSliceStep5 =>
      'Disegna i semi con il liner, ognuno una piccola goccia.';

  @override
  String get ideasForestMushroomsTitle => 'Funghi nel bosco';

  @override
  String get ideasForestMushroomsSummary =>
      'Un gruppo di funghi tra foglie marroni in autunno.';

  @override
  String get ideasForestMushroomsPractice =>
      'Cappelle tonde con piccole sfumature e un terreno libero e asciutto.';

  @override
  String get ideasForestMushroomsSubject =>
      'Tre funghi di altezze diverse tra le foglie cadute.';

  @override
  String get ideasForestMushroomsTip =>
      'Il sottobosco vuole tratti marroni liberi e spezzati, non campiture piene.';

  @override
  String get ideasForestMushroomsStep1 =>
      'Disegna a matita tre funghi di altezze diverse e qualche foglia intorno.';

  @override
  String get ideasForestMushroomsStep2 =>
      'Colora di beige chiaro i gambi e la parte sotto le cappelle.';

  @override
  String get ideasForestMushroomsStep3 =>
      'Colora le cappelle di rosso-marrone, più scuro sul bordo.';

  @override
  String get ideasForestMushroomsStep4 =>
      'Colora di marrone le foglie e il terreno.';

  @override
  String get ideasForestMushroomsStep5 =>
      'Usa il colore più scuro sotto le cappelle e dove i gambi toccano il terreno; se ti va, aggiungi macchioline di gel bianco sulle cappelle.';

  @override
  String get ideasHarvestBasketTitle => 'Cesto del raccolto';

  @override
  String get ideasHarvestBasketSummary =>
      'Mele, una pera e una piccola zucca in un cesto, ognuna di un colore diverso, ombreggiate con un solo grigio.';

  @override
  String get ideasHarvestBasketPractice =>
      'Un solo grigio che ombreggia tre colori forti perché stiano bene insieme.';

  @override
  String get ideasHarvestBasketSubject =>
      'Un cesto pieno di frutta: mele, una pera e una zucca.';

  @override
  String get ideasHarvestBasketTip =>
      'Ombreggia ogni frutto con lo stesso grigio. È quello che tiene insieme una natura morta ricca.';

  @override
  String get ideasHarvestBasketStep1 =>
      'Disegna a matita il cesto e la frutta che si sovrappone.';

  @override
  String get ideasHarvestBasketStep2 =>
      'Colora di rosso le mele, lasciando la luce come carta.';

  @override
  String get ideasHarvestBasketStep3 => 'Colora di giallo-verde la pera.';

  @override
  String get ideasHarvestBasketStep4 =>
      'Colora di arancione la zucca, con le coste come linee più scure di un secondo strato.';

  @override
  String get ideasHarvestBasketStep5 =>
      'Usa lo stesso grigio per ogni ombra e per l’interno del cesto.';

  @override
  String get ideasHarvestBasketStep6 =>
      'Usa il pennarello più scuro per le linee dell’intreccio del cesto.';

  @override
  String get ideasHotChocolateTitle => 'Cioccolata calda';

  @override
  String get ideasHotChocolateSummary =>
      'Una tazza di cioccolata con il vapore, un marshmallow e una muffola rossa.';

  @override
  String get ideasHotChocolatePractice =>
      'Marroni caldi, un accento rosso e il vapore sollevato dallo sfondo.';

  @override
  String get ideasHotChocolateSubject =>
      'Una tazza di cioccolata calda con un marshmallow e una muffola accanto.';

  @override
  String get ideasHotChocolateTip =>
      'Il vapore è carta o una forma sollevata con il blender, mai una linea disegnata.';

  @override
  String get ideasHotChocolateStep1 =>
      'Disegna a matita la tazza, la superficie della bevanda, un marshmallow e una muffola appoggiata accanto.';

  @override
  String get ideasHotChocolateStep2 =>
      'Marrone chiaro sul lato illuminato della tazza e sull’ombra del marshmallow.';

  @override
  String get ideasHotChocolateStep3 =>
      'Colora di marrone la superficie della bevanda e il lato in ombra della tazza.';

  @override
  String get ideasHotChocolateStep4 =>
      'Colora di rosso la muffola, in due strati.';

  @override
  String get ideasHotChocolateStep5 =>
      'Vapore: solleva dei filamenti dallo sfondo con il blender, oppure lasciali come carta.';

  @override
  String get ideasLunarNewYearTitle => 'Capodanno lunare';

  @override
  String get ideasLunarNewYearSummary =>
      'Lanterne rosse con bordi dorati su una parete rossa.';

  @override
  String get ideasLunarNewYearPractice =>
      'Una sola famiglia di rossi in tre passaggi e un accento oro piatto.';

  @override
  String get ideasLunarNewYearSubject =>
      'Tre lanterne tonde appese ad altezze diverse, con le nappe.';

  @override
  String get ideasLunarNewYearTip =>
      'Stendi l’oro sopra il rosso asciutto, mai al contrario.';

  @override
  String get ideasLunarNewYearStep1 =>
      'Disegna a matita tre lanterne appese ad altezze diverse, con le nappe.';

  @override
  String get ideasLunarNewYearStep2 =>
      'Colora le lanterne di rosso chiaro, più pallido sul lato illuminato.';

  @override
  String get ideasLunarNewYearStep3 =>
      'Aggiungi il rosso sul lato in ombra e sulle nervature, sfumato mentre è bagnato.';

  @override
  String get ideasLunarNewYearStep4 =>
      'Aggiungi il rosso scuro tra le nervature e dentro i bordi.';

  @override
  String get ideasLunarNewYearStep5 =>
      'Colora di giallo oro i bordi, i coperchi e le nappe, lasciandoli netti.';

  @override
  String get ideasDiwaliLampsTitle => 'Lampade di Diwali';

  @override
  String get ideasDiwaliLampsSummary =>
      'Una fila di lampade d’argilla con piccole fiamme e una rangoli di colori vivaci intorno.';

  @override
  String get ideasDiwaliLampsPractice =>
      'Un motivo piatto e saturo accanto a una sfumatura in due passaggi sulle lampade.';

  @override
  String get ideasDiwaliLampsSubject =>
      'Cinque piccole lampade d’argilla in una curva, con un semplice motivo simmetrico intorno.';

  @override
  String get ideasDiwaliLampsTip =>
      'Tieni il motivo piatto e a bordi netti. È il contrasto con le lampade che lo fa funzionare.';

  @override
  String get ideasDiwaliLampsStep1 =>
      'Disegna a matita cinque piccole lampade in una curva e un semplice motivo simmetrico intorno.';

  @override
  String get ideasDiwaliLampsStep2 => 'Colora le lampade di terracotta chiaro.';

  @override
  String get ideasDiwaliLampsStep3 =>
      'Aggiungi un terracotta più intenso sul loro lato in ombra.';

  @override
  String get ideasDiwaliLampsStep4 =>
      'Colora di giallo ogni fiamma e aggiungi un alone sul bordo di ogni lampada.';

  @override
  String get ideasDiwaliLampsStep5 =>
      'Colora di magenta le sezioni alternate del motivo, in modo piatto e a bordi netti.';

  @override
  String get ideasDiwaliLampsStep6 =>
      'Colora di verde acqua le altre sezioni, poi aggiungi puntini di gel bianco sulle fiamme, se ti va.';

  @override
  String get ideasHanukkahCandlesTitle => 'Hanukkah';

  @override
  String get ideasHanukkahCandlesSummary =>
      'Una menorah con le candele accese, blu e bianca con fiamme dorate.';

  @override
  String get ideasHanukkahCandlesPractice =>
      'Forme bianche lasciate come carta su un fondo blu.';

  @override
  String get ideasHanukkahCandlesSubject =>
      'Una menorah con le candele accese davanti a uno sfondo blu.';

  @override
  String get ideasHanukkahCandlesTip =>
      'Le candele sono carta: colora intorno e restano bianche.';

  @override
  String get ideasHanukkahCandlesStep1 =>
      'Disegna a matita la menorah e le candele; le candele restano carta.';

  @override
  String get ideasHanukkahCandlesStep2 =>
      'Colora lo sfondo di azzurro intorno a tutto.';

  @override
  String get ideasHanukkahCandlesStep3 =>
      'Aggiungi un blu più intenso ai bordi del foglio, sfumato verso l’interno.';

  @override
  String get ideasHanukkahCandlesStep4 =>
      'Usa il blu scuro per la menorah stessa.';

  @override
  String get ideasHanukkahCandlesStep5 =>
      'Fiamme gialle e un alone morbido intorno a ognuna, poi un nucleo di gel bianco in ogni fiamma.';

  @override
  String get ideasPaintedEggsTitle => 'Uova dipinte';

  @override
  String get ideasPaintedEggsSummary =>
      'Tre uova decorate con strisce, puntini e zigzag in colori di media intensità.';

  @override
  String get ideasPaintedEggsPractice =>
      'Tre modi di fare un motivo: carta, forma e secondo strato.';

  @override
  String get ideasPaintedEggsSubject =>
      'Tre uova, ognuna con un motivo diverso.';

  @override
  String get ideasPaintedEggsTip =>
      'I colori di media intensità lasciano vedere un secondo strato senza diventare fangosi.';

  @override
  String get ideasPaintedEggsStep1 =>
      'Disegna a matita tre uova e un motivo diverso su ognuna.';

  @override
  String get ideasPaintedEggsStep2 =>
      'Primo uovo: colore base piatto, con il motivo lasciato come carta.';

  @override
  String get ideasPaintedEggsStep3 =>
      'Secondo uovo: riempi solo le forme del motivo, il resto resta carta.';

  @override
  String get ideasPaintedEggsStep4 =>
      'Terzo uovo: coloralo, poi aggiungi il motivo con lo stesso colore in un secondo strato.';

  @override
  String get ideasPaintedEggsStep5 =>
      'Usa un grigio per il lato in ombra di ogni uovo e per la piccola ombra sotto.';

  @override
  String get ideasDiaDeMuertosTitle => 'Día de Muertos';

  @override
  String get ideasDiaDeMuertosSummary =>
      'Tagete e un teschio decorato in arancione, magenta e verde acqua su fondo scuro.';

  @override
  String get ideasDiaDeMuertosPractice =>
      'Motivo piatto e saturo su fondo scuro.';

  @override
  String get ideasDiaDeMuertosSubject =>
      'Un teschio decorato con forme di fiori intorno agli occhi e una fila di tagete sotto.';

  @override
  String get ideasDiaDeMuertosTip =>
      'Stendi il fondo scuro per ultimo e lentamente: l’inchiostro scuro sbava nelle zone chiare.';

  @override
  String get ideasDiaDeMuertosStep1 =>
      'Disegna a matita un teschio con forme di fiori intorno agli occhi e una fila di tagete sotto.';

  @override
  String get ideasDiaDeMuertosStep2 =>
      'Colora i tagete di arancione chiaro, ognuno come un cerchio irregolare.';

  @override
  String get ideasDiaDeMuertosStep3 =>
      'Aggiungi un arancione più intenso in brevi tratti dentro ogni cerchio per i petali.';

  @override
  String get ideasDiaDeMuertosStep4 =>
      'Usa il magenta per i motivi del teschio, in modo piatto e simmetrico.';

  @override
  String get ideasDiaDeMuertosStep5 =>
      'Usa il verde acqua per l’altra metà dei motivi del teschio.';

  @override
  String get ideasDiaDeMuertosStep6 =>
      'Usa il pennarello più scuro per le orbite e lo sfondo, poi aggiungi i dettagli con il liner.';

  @override
  String get ideasValentineCardTitle => 'Biglietto di San Valentino';

  @override
  String get ideasValentineCardSummary =>
      'Un biglietto con tre cuori, dal rosa pallido al rosso intenso, e una linea d’ombra che li stacca dalla carta.';

  @override
  String get ideasValentineCardPractice =>
      'Tre campiture piatte e una linea di ombra portata.';

  @override
  String get ideasValentineCardSubject =>
      'Tre cuori sovrapposti, il più grande dietro.';

  @override
  String get ideasValentineCardTip =>
      'Disegna l’ombra portata come una sola linea sottile: stacca il cuore senza altro colore.';

  @override
  String get ideasValentineCardStep1 =>
      'Disegna a matita tre cuori sovrapposti, il più grande dietro.';

  @override
  String get ideasValentineCardStep2 =>
      'Colora di rosa pallido il cuore dietro.';

  @override
  String get ideasValentineCardStep3 => 'Colora di rosa quello in mezzo.';

  @override
  String get ideasValentineCardStep4 =>
      'Colora di rosso quello davanti e aggiungi una sottile linea dello stesso rosso sotto gli altri due come ombra portata.';

  @override
  String get ideasValentineCardStep5 =>
      'Aggiungi una luce di gel bianco su ogni cuore, in alto a sinistra.';

  @override
  String get ideasCarnivalMaskTitle => 'Maschera di Carnevale';

  @override
  String get ideasCarnivalMaskSummary =>
      'Una maschera con piume viola, verde acqua e oro.';

  @override
  String get ideasCarnivalMaskPractice =>
      'Tratti rapidi per le piume, una sfumatura per la maschera e oro piatto.';

  @override
  String get ideasCarnivalMaskSubject =>
      'Una mezza maschera con tre piume che salgono da un lato.';

  @override
  String get ideasCarnivalMaskTip =>
      'Fai le piume con tratti rapidi verso l’esterno partendo dal calamo: il bordo morbido le fa sembrare piume.';

  @override
  String get ideasCarnivalMaskStep1 =>
      'Disegna a matita una mezza maschera e tre piume che salgono da un lato.';

  @override
  String get ideasCarnivalMaskStep2 =>
      'Colora di viola la maschera, con due strati dove si curva via.';

  @override
  String get ideasCarnivalMaskStep3 =>
      'Colora di verde acqua le piume, con colpi di polso verso l’esterno partendo dal calamo, perché i bordi restino morbidi.';

  @override
  String get ideasCarnivalMaskStep4 =>
      'Aggiungi l’oro sul bordo della maschera e sui contorni degli occhi.';

  @override
  String get ideasCarnivalMaskStep5 =>
      'Usa il colore più scuro dentro i fori degli occhi, poi aggiungi puntini di gel come paillettes.';

  @override
  String get ideasMidsummerCrownTitle => 'Corona di fiori';

  @override
  String get ideasMidsummerCrownSummary =>
      'Una corona di fiori di campo e foglie: blu, giallo e rosa sul verde.';

  @override
  String get ideasMidsummerCrownPractice =>
      'Tanti piccoli tocchi con la punta fine su una base verde asciutta.';

  @override
  String get ideasMidsummerCrownSubject =>
      'Un anello di foglie con tre tipi di piccoli fiori di campo.';

  @override
  String get ideasMidsummerCrownTip =>
      'I tocchi di colore su una base asciutta restano nitidi. Aspetta che il verde si asciughi prima di iniziare i fiori.';

  @override
  String get ideasMidsummerCrownStep1 =>
      'Disegna a matita un anello di foglie e piccoli fiori di tre tipi.';

  @override
  String get ideasMidsummerCrownStep2 =>
      'Colora di verde chiaro tutte le foglie.';

  @override
  String get ideasMidsummerCrownStep3 =>
      'Aggiungi un verde più scuro dove le foglie si sovrappongono e sotto.';

  @override
  String get ideasMidsummerCrownStep4 =>
      'Colora di blu il primo tipo di fiore.';

  @override
  String get ideasMidsummerCrownStep5 =>
      'Colora di giallo il secondo tipo di fiore.';

  @override
  String get ideasMidsummerCrownStep6 =>
      'Colora di rosa il terzo, con un minuscolo secondo strato al centro di ogni fiore.';

  @override
  String get ideasEidNightTitle => 'Notte di Eid';

  @override
  String get ideasEidNightSummary =>
      'Una luna crescente e una lanterna appesa su un cielo verde acqua scuro e viola.';

  @override
  String get ideasEidNightPractice =>
      'Una sfumatura pulita da bagnato dal verde acqua al viola, con l’oro sopra.';

  @override
  String get ideasEidNightSubject =>
      'Una luna crescente e una lanterna decorata su un cielo notturno.';

  @override
  String get ideasEidNightTip =>
      'Sfuma il verde acqua nel viola mentre sono entrambi bagnati. Una volta asciutto, il cielo resta pulito.';

  @override
  String get ideasEidNightStep1 =>
      'Disegna a matita la luna crescente e una lanterna decorata; per ora restano entrambe carta.';

  @override
  String get ideasEidNightStep2 =>
      'Colora di verde acqua tutto il cielo, più chiaro vicino alla luna.';

  @override
  String get ideasEidNightStep3 =>
      'Aggiungi un verde acqua più intenso verso i bordi.';

  @override
  String get ideasEidNightStep4 =>
      'Sfuma il viola negli angoli in alto mentre il verde acqua è ancora umido.';

  @override
  String get ideasEidNightStep5 =>
      'Colora d’oro la luna e il telaio della lanterna; i vetri restano chiari. Poi aggiungi stelle di gel bianco.';

  @override
  String get ideasHoliColoursTitle => 'Holi';

  @override
  String get ideasHoliColoursSummary =>
      'Nuvole di polvere colorata sul bianco: bordi morbidi, centri netti, quattro colori vivaci.';

  @override
  String get ideasHoliColoursPractice =>
      'Colore senza bordo: il blender scioglie un bordo nella carta.';

  @override
  String get ideasHoliColoursSubject =>
      'Quattro nuvole sovrapposte di polvere colorata su carta bianca.';

  @override
  String get ideasHoliColoursTip =>
      'Lascia asciugare ogni nuvola prima di aggiungere la successiva, altrimenti i colori diventano tutti fango.';

  @override
  String get ideasHoliColoursStep1 =>
      'Scarabocchia una nuvola libera con il primo colore, fitta al centro.';

  @override
  String get ideasHoliColoursStep2 =>
      'Tira fuori i suoi bordi con il blender verso la carta bianca finché spariscono.';

  @override
  String get ideasHoliColoursStep3 =>
      'Fai una seconda nuvola che si sovrappone un po’ alla prima; dove si incontrano, lasciale mescolare.';

  @override
  String get ideasHoliColoursStep4 =>
      'Fai una terza nuvola, più piccola, in uno spazio libero.';

  @override
  String get ideasHoliColoursStep5 =>
      'Fai una quarta nuvola nell’ultimo spazio, poi schizza qualche punto di ogni colore intorno.';

  @override
  String get ideasSummerIceCreamTitle => 'Gelato';

  @override
  String get ideasSummerIceCreamSummary =>
      'Tre palline di gusti diversi su un cono.';

  @override
  String get ideasSummerIceCreamPractice =>
      'Tre sfumature tonde e un solo grigio che le ombreggia tutte.';

  @override
  String get ideasSummerIceCreamSubject =>
      'Tre palline impilate su un cono con la griglia a cialda.';

  @override
  String get ideasSummerIceCreamTip =>
      'Usa lo stesso grigio per ogni pallina: è quello che tiene insieme tre colori diversi.';

  @override
  String get ideasSummerIceCreamStep1 =>
      'Disegna a matita un cono con la griglia a cialda e tre palline impilate.';

  @override
  String get ideasSummerIceCreamStep2 =>
      'Colora la pallina in basso con il primo gusto, lasciando una luce di carta.';

  @override
  String get ideasSummerIceCreamStep3 =>
      'Colora la pallina in mezzo con il secondo gusto, con la sua luce.';

  @override
  String get ideasSummerIceCreamStep4 =>
      'Colora la pallina in alto con il terzo gusto.';

  @override
  String get ideasSummerIceCreamStep5 =>
      'Usa lo stesso grigio chiaro sotto ogni pallina e dove si sovrappongono.';

  @override
  String get ideasSummerIceCreamStep6 =>
      'Colora il cono di beige, con le linee della griglia in un secondo strato.';

  @override
  String get ideasNewYearFireworksTitle => 'Fuochi di Capodanno';

  @override
  String get ideasNewYearFireworksSummary =>
      'Tre scoppi di fuochi d’artificio su un cielo scuro, ognuno di un colore diverso.';

  @override
  String get ideasNewYearFireworksPractice =>
      'Colore vivace su un fondo scuro, con le linee lasciate come carta.';

  @override
  String get ideasNewYearFireworksSubject =>
      'Tre scoppi di fuochi d’artificio con linee di luce che partono da ogni centro.';

  @override
  String get ideasNewYearFireworksTip =>
      'Riempi il cielo intorno alle linee, non sopra: la carta bianca fa brillare i fuochi.';

  @override
  String get ideasNewYearFireworksStep1 =>
      'Disegna a matita tre centri e linee di luce che partono da ognuno; per ora le linee restano carta.';

  @override
  String get ideasNewYearFireworksStep2 =>
      'Riempi il cielo di scuro, girando intorno alle linee con la punta fine (possono essere irregolari).';

  @override
  String get ideasNewYearFireworksStep3 =>
      'Ripassa le linee del primo scoppio con il primo colore, premendo di più sulle punte.';

  @override
  String get ideasNewYearFireworksStep4 =>
      'Colora le linee del secondo scoppio con il secondo colore.';

  @override
  String get ideasNewYearFireworksStep5 =>
      'Colora le linee del terzo scoppio con il terzo colore.';

  @override
  String get ideasNewYearFireworksStep6 =>
      'Aggiungi il gel bianco al centro di ogni scoppio e qualche scintilla sulle punte.';

  @override
  String get ideasCozyLampTitle => 'Angolino accogliente';

  @override
  String get ideasCozyLampSummary =>
      'Una poltrona sotto una lampada la sera: una pozza di luce calda e ombre marroni delicate.';

  @override
  String get ideasCozyLampPractice =>
      'Pianificare una zona illuminata e lasciare che il resto della stanza cada nel marrone caldo.';

  @override
  String get ideasCozyLampSubject =>
      'Una poltrona, una lampada a stelo e una parete dietro di loro.';

  @override
  String get ideasCozyLampTip =>
      'Tieni il marrone più scuro fuori dal cerchio di luce: la lampada non raggiunge nessun angolo.';

  @override
  String get ideasCozyLampStep1 =>
      'Disegna a matita la poltrona, la lampada e il cerchio di luce che getta sul pavimento e sulla parete.';

  @override
  String get ideasCozyLampStep2 =>
      'Riempi il cerchio di luce con il giallo chiaro e sfumalo con il blender incolore.';

  @override
  String get ideasCozyLampStep3 =>
      'Colora il resto della stanza con il beige caldo chiaro, in modo piatto e uniforme.';

  @override
  String get ideasCozyLampStep4 =>
      'Metti il marrone caldo sulla poltrona e sul lato della stanza lontano dalla lampada.';

  @override
  String get ideasCozyLampStep5 =>
      'Usa il marrone scuro negli angoli e sotto la poltrona, e tienilo fuori dal cerchio di luce.';

  @override
  String get ideasFoggyMorningTitle => 'Nebbia';

  @override
  String get ideasFoggyMorningSummary =>
      'Alberi che spariscono nella nebbia: i più vicini più scuri, i più lontani più chiari.';

  @override
  String get ideasFoggyMorningPractice =>
      'La profondità con una velatura chiara sopra forme scure.';

  @override
  String get ideasFoggyMorningSubject =>
      'Tre file di alberi lungo una strada, ognuna più lontana.';

  @override
  String get ideasFoggyMorningTip =>
      'Una velatura chiara sopra una forma scura è la nebbia più semplice: l’inchiostro sotto resta.';

  @override
  String get ideasFoggyMorningStep1 =>
      'Disegna a matita tre file di alberi, ognuna più lontana, e segna dove comincia il terreno.';

  @override
  String get ideasFoggyMorningStep2 =>
      'Colora la fila più lontana solo con il pennarello più chiaro, senza alcun dettaglio.';

  @override
  String get ideasFoggyMorningStep3 =>
      'Colora la fila di mezzo con il tono base e ammorbidisci il suo bordo inferiore verso il terreno con il blender.';

  @override
  String get ideasFoggyMorningStep4 =>
      'Disegna gli alberi più vicini con il pennarello scuro e aggiungi qualche ramo.';

  @override
  String get ideasFoggyMorningStep5 =>
      'Passa una velatura del pennarello chiaro sopra tutte le file, così che la nebbia copra tutta la scena.';

  @override
  String get ideasRainyWindowTitle => 'Pioggia sul vetro';

  @override
  String get ideasRainyWindowSummary =>
      'Luci sfocate viste attraverso un vetro bagnato, con gocce che scendono.';

  @override
  String get ideasRainyWindowPractice =>
      'Luci che brillano dietro il vetro e segni netti sopra.';

  @override
  String get ideasRainyWindowSubject =>
      'Una finestra di notte con i lampioni fuori e tre gocce sul vetro.';

  @override
  String get ideasRainyWindowTip =>
      'Le luci devono asciugare del tutto prima che il blu passi sopra, o i colori si mescolano.';

  @override
  String get ideasRainyWindowStep1 =>
      'Disegna a matita il telaio della finestra e qualche macchia di luce sfocata fuori, e segna il percorso di tre gocce.';

  @override
  String get ideasRainyWindowStep2 =>
      'Colora le luci calde come macchie morbide e sciogli i loro bordi con il blender.';

  @override
  String get ideasRainyWindowStep3 =>
      'Copri tutto il vetro con il blu chiaro, girando attorno alle luci.';

  @override
  String get ideasRainyWindowStep4 =>
      'Aggiungi il blu base verso gli angoli e lascia i percorsi delle gocce un po’ più chiari.';

  @override
  String get ideasRainyWindowStep5 =>
      'Colora il telaio in scuro e metti una mezzaluna scura sul lato di ogni goccia opposto alla luce.';

  @override
  String get ideasRainyWindowStep6 =>
      'A secco, aggiungi un tocco di gel bianco sul lato illuminato di ogni goccia.';

  @override
  String get ideasEerieForestTitle => 'Bosco inquietante';

  @override
  String get ideasEerieForestSummary =>
      'Alberi sottili al crepuscolo, in verdi malati, con un cielo viola in mezzo.';

  @override
  String get ideasEerieForestPractice =>
      'Far mescolare due colori dove si toccano, di proposito.';

  @override
  String get ideasEerieForestSubject =>
      'Fusti alti e sottili su un orizzonte basso al crepuscolo.';

  @override
  String get ideasEerieForestTip =>
      'Il verde e il viola diventano grigi dove si toccano. Quel grigio è l’atmosfera, non un errore.';

  @override
  String get ideasEerieForestStep1 =>
      'Disegna a matita fusti alti e sottili e un orizzonte basso.';

  @override
  String get ideasEerieForestStep2 =>
      'Metti un verde giallognolo pallido lungo l’orizzonte, tra i fusti.';

  @override
  String get ideasEerieForestStep3 =>
      'Colora il viola sopra e sfumalo nel verde mentre è ancora umido.';

  @override
  String get ideasEerieForestStep4 =>
      'Colora di verde il terreno e la parte bassa dei fusti.';

  @override
  String get ideasEerieForestStep5 =>
      'Usa il verde più scuro sui fusti con tratti disuguali, e aggiungi ombre lunghe sul terreno.';

  @override
  String get ideasGoldenHourTitle => 'Ora d’oro';

  @override
  String get ideasGoldenHourSummary =>
      'Un muro bianco e una porta alla fine del pomeriggio: luce arancione, ombre viola lunghe.';

  @override
  String get ideasGoldenHourPractice =>
      'Una velatura calda su tutto, con ombre fredde a bordo netto sopra.';

  @override
  String get ideasGoldenHourSubject =>
      'Un muro con una porta, una pianta e la lunga ombra che la pianta getta sul muro.';

  @override
  String get ideasGoldenHourTip =>
      'Il muro qui non è bianco: con questa luce è arancione. Dipingilo così.';

  @override
  String get ideasGoldenHourStep1 =>
      'Disegna a matita un muro con una porta e una pianta, e la lunga ombra che la pianta getta sul muro.';

  @override
  String get ideasGoldenHourStep2 =>
      'Stendi l’arancione chiaro su tutto il muro: è il muro bianco con questa luce.';

  @override
  String get ideasGoldenHourStep3 =>
      'Metti l’arancione più acceso sotto l’architrave e sulla porta.';

  @override
  String get ideasGoldenHourStep4 =>
      'Aggiungi il grigio-viola nell’ombra della pianta e nel vano della porta, con un bordo netto.';

  @override
  String get ideasGoldenHourStep5 =>
      'Tieni il pennarello più scuro solo per il fondo del vano della porta.';

  @override
  String get ideasStormySeaTitle => 'Mare in tempesta';

  @override
  String get ideasStormySeaSummary =>
      'Onde grigio-verdi sotto un cielo scuro, con carta bianca per la schiuma.';

  @override
  String get ideasStormySeaPractice =>
      'Un’acqua piatta e chiara contro un cielo pesante, con la schiuma lasciata sulla carta.';

  @override
  String get ideasStormySeaSubject =>
      'Un orizzonte basso, due onde grandi e la schiuma che si rompe su di esse.';

  @override
  String get ideasStormySeaTip =>
      'La schiuma è carta che non hai toccato: decidi dove si rompe prima di colorare l’acqua.';

  @override
  String get ideasStormySeaStep1 =>
      'Disegna a matita l’orizzonte basso, due onde grandi e dove si rompe la schiuma. La schiuma resta carta.';

  @override
  String get ideasStormySeaStep2 =>
      'Copri l’acqua con il grigio-verde chiaro, girando attorno alla schiuma.';

  @override
  String get ideasStormySeaStep3 =>
      'Metti l’acqua più scura nei cavi e sotto ogni cresta.';

  @override
  String get ideasStormySeaStep4 =>
      'Riempi il cielo con il pennarello scuro, più scuro in alto, e l’acqua più profonda sotto l’onda che si rompe.';

  @override
  String get ideasStormySeaStep5 =>
      'A secco, aggiungi del gel bianco per la schiuma che schizza dalle creste: solo qualche punto.';

  @override
  String get ideasCandleFlameTitle => 'A lume di candela';

  @override
  String get ideasCandleFlameSummary =>
      'Una candela su un tavolo in una stanza buia: tutto caldo, e non si vede niente di ciò che è lontano dalla fiamma.';

  @override
  String get ideasCandleFlamePractice =>
      'Anelli concentrici di colori caldi, sfumati l’uno nell’altro da bagnati.';

  @override
  String get ideasCandleFlameSubject =>
      'Una candela nel suo portacandela, con il tavolo e la parete in fondo.';

  @override
  String get ideasCandleFlameTip =>
      'Si vede solo ciò che la fiamma tocca: il fondo della stanza può essere quasi una sola forma scura.';

  @override
  String get ideasCandleFlameStep1 =>
      'Disegna a matita la candela, la sua fiamma e un cerchio di luce sul tavolo. Il cuore della fiamma resta carta.';

  @override
  String get ideasCandleFlameStep2 =>
      'Colora l’alone della fiamma e la parte di tavolo più vicina con il giallo, sfumato verso l’esterno con il blender.';

  @override
  String get ideasCandleFlameStep3 =>
      'Metti l’arancione caldo sul lato illuminato della candela e sull’anello successivo del tavolo.';

  @override
  String get ideasCandleFlameStep4 =>
      'Colora di marrone tutto ciò che sta oltre il cerchio di luce.';

  @override
  String get ideasCandleFlameStep5 =>
      'Usa il marrone più scuro per il fondo della stanza e il lato in ombra della candela, con un bordo morbido verso la luce.';

  @override
  String get ideasDesertNoonTitle => 'Mezzogiorno nel deserto';

  @override
  String get ideasDesertNoonSummary =>
      'Sabbia, una roccia e un’ombra netta sotto un cielo sbiancato.';

  @override
  String get ideasDesertNoonPractice =>
      'Un riempimento piatto e chiaro contro un’ombra netta e scura.';

  @override
  String get ideasDesertNoonSubject =>
      'Un orizzonte alto, una sola roccia e la sua ombra breve subito sotto.';

  @override
  String get ideasDesertNoonTip =>
      'Lascia una fascia di carta bianca all’orizzonte: è quella fascia che fa sembrare il cielo caldo.';

  @override
  String get ideasDesertNoonStep1 =>
      'Disegna a matita un orizzonte alto, una roccia e la sua ombra breve subito sotto.';

  @override
  String get ideasDesertNoonStep2 =>
      'Copri la sabbia sotto l’orizzonte con il giallo chiaro, in una passata molto leggera.';

  @override
  String get ideasDesertNoonStep3 =>
      'Colora il cielo con il blu chiaro e lascialo più chiaro vicino all’orizzonte.';

  @override
  String get ideasDesertNoonStep4 =>
      'Metti l’arancione sul lato in ombra della roccia e sulle ondulazioni della sabbia.';

  @override
  String get ideasDesertNoonStep5 =>
      'Usa il blu-viola solo nell’ombra portata dalla roccia, con un bordo netto.';

  @override
  String get ideasBokehLightsTitle => 'Luci sfocate';

  @override
  String get ideasBokehLightsSummary =>
      'Uno sfondo di cerchi di luce morbidi e fuori fuoco.';

  @override
  String get ideasBokehLightsPractice =>
      'Fare un disco morbido con il blender su un campo piatto.';

  @override
  String get ideasBokehLightsSubject =>
      'Un campo scuro con una dozzina di luci sfocate di dimensioni diverse.';

  @override
  String get ideasBokehLightsTip =>
      'Appoggia il blender di piatto: una punta appuntita traccia una linea, non un disco.';

  @override
  String get ideasBokehLightsStep1 =>
      'Riempi tutta l’area con il colore base, a tratti piatti.';

  @override
  String get ideasBokehLightsStep2 =>
      'Scurisci gli angoli e sfuma il buio verso l’interno mentre l’inchiostro è umido.';

  @override
  String get ideasBokehLightsStep3 =>
      'Lascia asciugare, poi appoggia la punta larga del blender di piatto in cerchi di dimensioni diverse.';

  @override
  String get ideasBokehLightsStep4 =>
      'Tocca il pennarello chiaro al centro di alcuni dischi, così brillano.';

  @override
  String get ideasBokehLightsStep5 =>
      'Metti un punto di gel bianco dentro due o tre dischi, non in tutti.';

  @override
  String get ideasRetroPosterTitle => 'Manifesto retrò';

  @override
  String get ideasRetroPosterSummary =>
      'Tre colori piatti, un po’ polverosi, e uno scuro, senza nessuna sfumatura.';

  @override
  String get ideasRetroPosterPractice =>
      'Riempimenti piatti e bordi netti, come in un manifesto stampato.';

  @override
  String get ideasRetroPosterSubject =>
      'Un faro, un’auto o una bottiglia, disegnati come poche grandi forme piatte.';

  @override
  String get ideasRetroPosterTip =>
      'Lascia tra i colori un filo di carta bianca, come se la stampa fosse scivolata un po’.';

  @override
  String get ideasRetroPosterStep1 =>
      'Disegna a matita un soggetto semplice come grandi forme piatte: un faro, un’auto, una bottiglia.';

  @override
  String get ideasRetroPosterStep2 =>
      'Riempi le forme più grandi in piano, in una passata.';

  @override
  String get ideasRetroPosterStep3 =>
      'Riempi le forme successive e lascia un filo di carta tra i colori.';

  @override
  String get ideasRetroPosterStep4 =>
      'Usa il terzo colore sulle forme più piccole.';

  @override
  String get ideasRetroPosterStep5 =>
      'Disegna le ombre come forme piatte a parte, con il pennarello scuro.';

  @override
  String get ideasRetroPosterStep6 =>
      'Aggiungi qualche linea di liner dove il manifesto stampato le avrebbe.';

  @override
  String get ideasFreshCitrusTitle => 'Fresco e agrumato';

  @override
  String get ideasFreshCitrusSummary =>
      'Un limone, un lime e un bicchiere d’acqua, con molta carta bianca e al massimo due strati.';

  @override
  String get ideasFreshCitrusPractice =>
      'Colore vivo sulla carta bianca, fermandosi per tempo.';

  @override
  String get ideasFreshCitrusSubject =>
      'Un limone, un lime e un bicchiere d’acqua su un tavolo.';

  @override
  String get ideasFreshCitrusTip =>
      'Fermati dopo due strati: il terzo toglie la freschezza al colore.';

  @override
  String get ideasFreshCitrusStep1 =>
      'Disegna a matita la frutta e il bicchiere, e mantieni la composizione ariosa.';

  @override
  String get ideasFreshCitrusStep2 =>
      'Colora il limone di giallo in una passata, lasciando una luce bianca.';

  @override
  String get ideasFreshCitrusStep3 =>
      'Colora il lime di verde, anche in una passata.';

  @override
  String get ideasFreshCitrusStep4 =>
      'Aggiungi il giallo più scuro sul lato in ombra del limone e una seconda passata di verde sul lato in ombra del lime.';

  @override
  String get ideasFreshCitrusStep5 =>
      'Usa il blu chiaro per l’acqua nel bicchiere e una piccola ombra sotto ogni frutto.';

  @override
  String get ideasTropicalNoonTitle => 'Mezzogiorno tropicale';

  @override
  String get ideasTropicalNoonSummary =>
      'Foglie grandi, un fiore rosa acceso e una fetta di cielo blu, saturi e a bordi netti.';

  @override
  String get ideasTropicalNoonPractice =>
      'Colore forte e piatto con sovrapposizioni nette, senza sfumature.';

  @override
  String get ideasTropicalNoonSubject =>
      'Due o tre foglie grandi sovrapposte, un fiore e il cielo tra i vuoti.';

  @override
  String get ideasTropicalNoonTip =>
      'Lascia il bordo di ogni foglia netto: è la sovrapposizione che dà la profondità qui.';

  @override
  String get ideasTropicalNoonStep1 =>
      'Disegna a matita due o tre foglie grandi sovrapposte, un fiore e il cielo tra i vuoti.';

  @override
  String get ideasTropicalNoonStep2 =>
      'Colora le foglie di verde chiaro, seguendo le nervature.';

  @override
  String get ideasTropicalNoonStep3 =>
      'Metti il verde medio sulle foglie dietro e sotto le altre, con bordi netti dove si sovrappongono.';

  @override
  String get ideasTropicalNoonStep4 =>
      'Colora il fiore di rosa acceso, con due strati.';

  @override
  String get ideasTropicalNoonStep5 =>
      'Colora il cielo blu nei vuoti, fino al bordo delle foglie.';

  @override
  String get ideasGreenhouseLightTitle => 'Nella serra';

  @override
  String get ideasGreenhouseLightSummary =>
      'Piante dietro il vetro in una luce verde e umida, con i vetri grigio chiaro.';

  @override
  String get ideasGreenhouseLightPractice =>
      'Una velatura chiara sopra una scena, come fa il vetro.';

  @override
  String get ideasGreenhouseLightSubject =>
      'Un muro di vetro con i suoi montanti e vasi di piante dietro.';

  @override
  String get ideasGreenhouseLightTip =>
      'La velatura verde va per ultima: è la luce umida del posto, non il colore delle piante.';

  @override
  String get ideasGreenhouseLightStep1 =>
      'Disegna a matita un muro di vetro con i suoi montanti e vasi di piante dietro.';

  @override
  String get ideasGreenhouseLightStep2 =>
      'Colora le piante con il verde base, più morbido quanto più sono dietro il vetro.';

  @override
  String get ideasGreenhouseLightStep3 =>
      'Tieni il verde scuro solo per le foglie più vicine.';

  @override
  String get ideasGreenhouseLightStep4 =>
      'Usa il grigio chiaro per i montanti e per le strisce di riflesso sui vetri.';

  @override
  String get ideasGreenhouseLightStep5 =>
      'Quando è asciutto, stendi una velatura di verde chiaro su tutta l’area del vetro: la luce dentro è verde.';

  @override
  String get ideasDustyAtticTitle => 'Sottotetto polveroso';

  @override
  String get ideasDustyAtticSummary =>
      'Grigi caldi, un vecchio baule e un raggio di luce con dentro la polvere.';

  @override
  String get ideasDustyAtticPractice =>
      'Una stanza grigia con un solo punto luminoso lasciato intatto.';

  @override
  String get ideasDustyAtticSubject =>
      'Una piccola finestra in alto, il raggio di luce che getta e un vecchio baule dentro.';

  @override
  String get ideasDustyAtticTip =>
      'Lascia il raggio di luce come la cosa più luminosa del quadro: è l’unica carta bianca rimasta.';

  @override
  String get ideasDustyAtticStep1 =>
      'Disegna a matita una piccola finestra in alto, il raggio di luce che getta e un baule dentro.';

  @override
  String get ideasDustyAtticStep2 =>
      'Copri tutto con il grigio caldo più chiaro, tranne l’interno del raggio di luce.';

  @override
  String get ideasDustyAtticStep3 =>
      'Metti il grigio caldo medio sui muri lontani dalla finestra e sui lati del baule.';

  @override
  String get ideasDustyAtticStep4 =>
      'Usa il grigio più scuro negli angoli e sotto il baule.';

  @override
  String get ideasDustyAtticStep5 =>
      'Aggiungi una leggera velatura giallo pallido dentro il raggio di luce.';

  @override
  String get ideasDustyAtticStep6 =>
      'A secco, aggiungi qualche granello di polvere di gel bianco nel raggio di luce.';

  @override
  String get ideasColourGreyBlackTitle => 'Colore, grigio e nero';

  @override
  String get ideasColourGreyBlackSummary =>
      'Solo tre pennarelli: un colore, un grigio e uno molto scuro.';

  @override
  String get ideasColourGreyBlackPractice =>
      'Dare luce a un disegno con il minor numero di pennarelli possibile.';

  @override
  String get ideasColourGreyBlackSubject =>
      'Una bicicletta, uno stivale o una teiera di un solo colore.';

  @override
  String get ideasColourGreyBlackTip =>
      'Con tre punte non c’è nulla da decidere se non dove va la luce. Pianifica la luce per prima.';

  @override
  String get ideasColourGreyBlackStep1 =>
      'Scegli un soggetto con un solo colore principale e segna a matita da dove viene la luce.';

  @override
  String get ideasColourGreyBlackStep2 =>
      'Colora tutto il soggetto con il colore e dai due strati dove si allontana dalla luce.';

  @override
  String get ideasColourGreyBlackStep3 =>
      'Usa il grigio per l’ombra portata e per tutto ciò che non è il soggetto.';

  @override
  String get ideasColourGreyBlackStep4 =>
      'Tieni il pennarello scuro per le linee di contatto e per gli angoli più profondi.';

  @override
  String get ideasColourGreyBlackStep5 =>
      'Fai un passo indietro: il disegno si legge con soli tre valori e il grigio li tiene insieme.';

  @override
  String get ideasAnalogousTrioTitle => 'Tre colori vicini';

  @override
  String get ideasAnalogousTrioSummary =>
      'Tre colori vicini sulla ruota dei colori, e niente dall’altro lato.';

  @override
  String get ideasAnalogousTrioPractice =>
      'Costruire uno schema con tinte vicine.';

  @override
  String get ideasAnalogousTrioSubject =>
      'Un girasole, il mare o un campo di un solo colore.';

  @override
  String get ideasAnalogousTrioTip =>
      'I colori vicini si fondono da bagnati senza diventare grigi. Lasciali bagnati e lasciali mescolare.';

  @override
  String get ideasAnalogousTrioStep1 =>
      'Scegli un soggetto che è naturalmente di un solo colore, come un girasole o il mare, e disegnalo.';

  @override
  String get ideasAnalogousTrioStep2 =>
      'Copri la maggior parte del soggetto con il colore centrale.';

  @override
  String get ideasAnalogousTrioStep3 =>
      'Metti uno dei due colori vicini sul lato della luce e fondilo nel colore centrale mentre è bagnato.';

  @override
  String get ideasAnalogousTrioStep4 =>
      'Usa l’altro colore vicino nelle ombre, lontano dalla luce.';

  @override
  String get ideasAnalogousTrioStep5 =>
      'Aggiungi il tono scuro del colore centrale solo nei punti più profondi e lascia il resto nei tre colori.';

  @override
  String get ideasTriadTitle => 'Una triade';

  @override
  String get ideasTriadSummary =>
      'Tre colori equidistanti sulla ruota: uno guida e due sostengono.';

  @override
  String get ideasTriadPractice =>
      'Usare uno schema a tre colori con un colore in testa.';

  @override
  String get ideasTriadSubject =>
      'Una locandina, una copertina o un fiore grande con piccoli dettagli.';

  @override
  String get ideasTriadTip =>
      'Tieni i tre colori separati sulla carta. Un unico grigio sopra tutti e tre li tiene insieme.';

  @override
  String get ideasTriadStep1 =>
      'Decidi quale dei tre colori guida: quello prende la parte più grande del foglio.';

  @override
  String get ideasTriadStep2 =>
      'Colora le zone principali con il colore che guida.';

  @override
  String get ideasTriadStep3 =>
      'Usa il secondo colore su circa un quarto del disegno e non farlo mai toccare il primo quando è bagnato.';

  @override
  String get ideasTriadStep4 =>
      'Usa il terzo colore solo in qualche piccolo punto.';

  @override
  String get ideasTriadStep5 =>
      'Ombreggia tutti e tre i colori con lo stesso grigio, così stanno bene insieme.';

  @override
  String get ideasSplitComplementTitle => 'Complementare divisa';

  @override
  String get ideasSplitComplementSummary =>
      'Una famiglia di colori e i due colori ai lati del suo opposto.';

  @override
  String get ideasSplitComplementPractice =>
      'Bilanciare una famiglia principale con due colori vicini al suo opposto.';

  @override
  String get ideasSplitComplementSubject =>
      'Un vaso con due fiori o una tazza con due oggetti piccoli accanto.';

  @override
  String get ideasSplitComplementTip =>
      'Un quasi-opposto si legge come uno scontro o come un’armonia a seconda di quanto ne usi.';

  @override
  String get ideasSplitComplementStep1 =>
      'Disegna un soggetto con una zona grande e due piccole, per esempio un vaso con due fiori.';

  @override
  String get ideasSplitComplementStep2 =>
      'Copri la zona grande con il tono chiaro della famiglia principale.';

  @override
  String get ideasSplitComplementStep3 =>
      'Aggiungi la sua ombra dove la luce non arriva.';

  @override
  String get ideasSplitComplementStep4 =>
      'Usa uno dei due opposti sulla prima zona piccola.';

  @override
  String get ideasSplitComplementStep5 =>
      'Usa l’altro opposto sulla seconda zona piccola e tieni le due separate.';

  @override
  String get ideasTwoGrayTemperaturesTitle => 'Grigi caldi, grigi freddi';

  @override
  String get ideasTwoGrayTemperaturesSummary =>
      'Colora la stessa pietra due volte, una con grigi caldi e una con grigi freddi.';

  @override
  String get ideasTwoGrayTemperaturesPractice =>
      'Distinguere a occhio un grigio caldo da un grigio freddo.';

  @override
  String get ideasTwoGrayTemperaturesSubject =>
      'La stessa pietra o un panno piegato, disegnati due volte uno accanto all’altro.';

  @override
  String get ideasTwoGrayTemperaturesTip =>
      'La maggior parte dei marchi vende grigi caldi, freddi e neutri come famiglie a parte. Scegli una famiglia per ogni metà.';

  @override
  String get ideasTwoGrayTemperaturesStep1 =>
      'Disegna la stessa pietra due volte a matita, una accanto all’altra, e segna la luce su ognuna.';

  @override
  String get ideasTwoGrayTemperaturesStep2 =>
      'Prima pietra: colora tutto con il grigio caldo chiaro.';

  @override
  String get ideasTwoGrayTemperaturesStep3 =>
      'Aggiungi il grigio caldo più scuro sul lato in ombra e scurisci il contatto con il terreno.';

  @override
  String get ideasTwoGrayTemperaturesStep4 =>
      'Seconda pietra: colora tutto con il grigio freddo chiaro.';

  @override
  String get ideasTwoGrayTemperaturesStep5 =>
      'Aggiungi il grigio freddo più scuro allo stesso modo, poi confronta: una pietra sembra al sole, l’altra all’ombra.';

  @override
  String get ideasGrayPlusAccentTitle => 'Grigio con un accento';

  @override
  String get ideasGrayPlusAccentSummary =>
      'Tutto in grigio tranne una cosa piccola a colori.';

  @override
  String get ideasGrayPlusAccentPractice =>
      'Far reggere tutto il disegno a un solo colore.';

  @override
  String get ideasGrayPlusAccentSubject =>
      'Una strada con una porta rossa o un ombrello giallo in una città grigia.';

  @override
  String get ideasGrayPlusAccentTip =>
      'L’accento deve essere il più forte possibile: due strati dello stesso pennarello.';

  @override
  String get ideasGrayPlusAccentStep1 =>
      'Disegna una scena con un oggetto su cui vuoi far posare l’occhio, per esempio una porta rossa in una strada.';

  @override
  String get ideasGrayPlusAccentStep2 =>
      'Copri tutto tranne quell’oggetto con il grigio chiaro.';

  @override
  String get ideasGrayPlusAccentStep3 =>
      'Metti il grigio medio nelle ombre, come se la scena fosse una fotografia.';

  @override
  String get ideasGrayPlusAccentStep4 =>
      'Usa il grigio più scuro per le finestre, sotto i cornicioni e per le linee di contatto.';

  @override
  String get ideasGrayPlusAccentStep5 =>
      'Colora solo l’oggetto, con due strati, così l’accento è il più forte possibile.';

  @override
  String get ideasEarthTonesTitle => 'Toni della terra';

  @override
  String get ideasEarthTonesSummary =>
      'Marroni, ocra e un verde oliva, niente di vivo.';

  @override
  String get ideasEarthTonesPractice =>
      'Sovrapporre colori poco saturi senza che diventino spenti.';

  @override
  String get ideasEarthTonesSubject => 'Pane, un cesto o un campo arato.';

  @override
  String get ideasEarthTonesTip =>
      'I colori poco saturi si sovrappongono bene, perché la carta continua a illuminarli da sotto.';

  @override
  String get ideasEarthTonesStep1 =>
      'Disegna qualcosa che viene dalla terra: pane, un cesto o un campo arato.';

  @override
  String get ideasEarthTonesStep2 =>
      'Stendi l’ocra chiara ovunque come primo strato.';

  @override
  String get ideasEarthTonesStep3 =>
      'Aggiungi il marrone dove la forma si allontana dalla luce.';

  @override
  String get ideasEarthTonesStep4 =>
      'Metti il verde oliva su tutto ciò che è verde e lascia che l’ocra sotto lo attenui.';

  @override
  String get ideasEarthTonesStep5 =>
      'Tieni il marrone più scuro solo per i punti più profondi.';

  @override
  String get ideasJewelTonesTitle => 'Toni gioiello';

  @override
  String get ideasJewelTonesSummary =>
      'Colori profondi e saturi con un accento dorato, come in un cofanetto di velluto.';

  @override
  String get ideasJewelTonesPractice =>
      'Dipingere colori scuri saturi che conservano la lucentezza.';

  @override
  String get ideasJewelTonesSubject =>
      'Alcune gemme o bottiglie semplici con una luce prevista su ciascuna.';

  @override
  String get ideasJewelTonesTip =>
      'L’inchiostro scuro saturo resta lucido sulla carta da pennarello. Un punto di gel bianco sopra dà l’effetto vetro.';

  @override
  String get ideasJewelTonesStep1 =>
      'Disegna alcune gemme o bottiglie semplici e prevedi una luce su ciascuna.';

  @override
  String get ideasJewelTonesStep2 =>
      'Copri la forma più grande con il blu-verde profondo, in due strati.';

  @override
  String get ideasJewelTonesStep3 =>
      'Usa il viola profondo sulla forma successiva.';

  @override
  String get ideasJewelTonesStep4 => 'Usa il rosso profondo sulla più piccola.';

  @override
  String get ideasJewelTonesStep5 =>
      'Aggiungi il giallo dorato alle montature o ai tappi e poi un punto netto di gel bianco su ogni luce.';

  @override
  String get ideasLowKeyTitle => 'Solo pennarelli scuri';

  @override
  String get ideasLowKeySummary =>
      'Disegna con pennarelli più scuri del grigio medio e lascia che qualche pezzo di carta porti tutta la luce.';

  @override
  String get ideasLowKeyPractice =>
      'Fare un disegno scuro lasciando la luce fuori di proposito.';

  @override
  String get ideasLowKeySubject =>
      'Un gatto con gli occhi accesi, una lampada in una stanza buia o un profilo.';

  @override
  String get ideasLowKeyTip =>
      'L’inchiostro alcolico scuro copre in modo uniforme in una passata, quindi le forme bianche che lasci restano pulite.';

  @override
  String get ideasLowKeyStep1 =>
      'Pianifica il disegno come alcune forme di carta lasciate bianche su un fondo scuro: gli occhi di un gatto, una lampada, un profilo.';

  @override
  String get ideasLowKeyStep2 =>
      'Copri tutto tranne le forme bianche con il pennarello meno scuro.';

  @override
  String get ideasLowKeyStep3 =>
      'Usa il pennarello intermedio sulle ombre più grandi.';

  @override
  String get ideasLowKeyStep4 =>
      'Metti il pennarello più scuro sui bordi delle forme chiare, così brillano per contrasto.';

  @override
  String get ideasLowKeyStep5 =>
      'Aggiungi gel bianco solo su uno o due punti, non di più.';

  @override
  String get ideasComplementGradientTitle => 'Attraverso il centro';

  @override
  String get ideasComplementGradientSummary =>
      'Fondi due colori opposti l’uno nell’altro e guarda il grigio che fanno dove si incontrano.';

  @override
  String get ideasComplementGradientPractice =>
      'Miscelare due colori sulla carta e leggere il risultato.';

  @override
  String get ideasComplementGradientSubject =>
      'Una striscia lunga di carta dove i due colori si incontrano al centro.';

  @override
  String get ideasComplementGradientTip =>
      'Gli opposti bagnati si miscelano subito sulla carta. Tieni entrambi bagnati e lascia che si incontrino al centro.';

  @override
  String get ideasComplementGradientStep1 =>
      'Fissa con il nastro una lunga striscia di carta.';

  @override
  String get ideasComplementGradientStep2 =>
      'Riempi il terzo sinistro e sfuma il colore verso il centro.';

  @override
  String get ideasComplementGradientStep3 =>
      'Riempi il terzo destro e sfumalo verso il centro mentre il primo colore è ancora bagnato.';

  @override
  String get ideasComplementGradientStep4 =>
      'Confronta il centro fangoso con un tratto del tuo grigio accanto.';

  @override
  String get ideasComplementGradientStep5 =>
      'Rifai la striscia mettendo prima il grigio al centro e sfumando i due colori verso di esso: un passaggio più pulito.';

  @override
  String get ideasWarmLightCoolShadowTitle => 'Luce calda, ombra fredda';

  @override
  String get ideasWarmLightCoolShadowSummary =>
      'Un oggetto, il lato illuminato in colori caldi e il lato in ombra in colori freddi.';

  @override
  String get ideasWarmLightCoolShadowPractice =>
      'Sovrapporre caldo e freddo sopra un unico colore di base.';

  @override
  String get ideasWarmLightCoolShadowSubject =>
      'Un frutto tondo, un uovo o una palla.';

  @override
  String get ideasWarmLightCoolShadowTip =>
      'Lascia una striscia sottile di base pura tra il caldo e il freddo: così la forma continua a girare.';

  @override
  String get ideasWarmLightCoolShadowStep1 =>
      'Disegna un oggetto tondo e segna da dove viene la luce.';

  @override
  String get ideasWarmLightCoolShadowStep2 =>
      'Copri tutto l’oggetto con il suo stesso colore.';

  @override
  String get ideasWarmLightCoolShadowStep3 =>
      'Passa il colore caldo sulla metà illuminata e fondilo con la base mentre è bagnato.';

  @override
  String get ideasWarmLightCoolShadowStep4 =>
      'Passa il colore freddo sulla metà in ombra e lascia una striscia sottile di base pura fra le due.';

  @override
  String get ideasWarmLightCoolShadowStep5 =>
      'Tieni il pennarello più scuro solo per il contatto con il terreno.';

  @override
  String get ideasVividAndMutedTitle => 'Vivido e spento';

  @override
  String get ideasVividAndMutedSummary =>
      'Colora lo stesso fiore con una coppia vivida e poi con una coppia spenta della stessa tinta.';

  @override
  String get ideasVividAndMutedPractice =>
      'Distinguere un colore vivido dalla sua versione spenta.';

  @override
  String get ideasVividAndMutedSubject =>
      'Lo stesso fiore disegnato due volte, uno accanto all’altro.';

  @override
  String get ideasVividAndMutedTip =>
      'La maggior parte delle gamme ha una versione vivida e una versione polverosa di ogni tinta. Scegliere tra le due è tutto l’esercizio.';

  @override
  String get ideasVividAndMutedStep1 =>
      'Disegna lo stesso fiore due volte a matita, uno accanto all’altro.';

  @override
  String get ideasVividAndMutedStep2 =>
      'Primo fiore: colora tutto con il tono chiaro e vivido.';

  @override
  String get ideasVividAndMutedStep3 =>
      'Aggiungi l’ombra vivida della stessa tinta.';

  @override
  String get ideasVividAndMutedStep4 =>
      'Secondo fiore: colora tutto con il tono chiaro e spento della stessa tinta.';

  @override
  String get ideasVividAndMutedStep5 =>
      'Aggiungi la sua ombra spenta, poi decidi quale fiore useresti in primo piano e quale sullo sfondo.';

  @override
  String get ideasOneMarkerBlenderTitle => 'Un pennarello e il blender';

  @override
  String get ideasOneMarkerBlenderSummary =>
      'Quattro valori con un solo pennarello scuro, diluendolo con il blender incolore.';

  @override
  String get ideasOneMarkerBlenderPractice =>
      'Diluire l’inchiostro per ottenere valori più chiari senza un secondo pennarello.';

  @override
  String get ideasOneMarkerBlenderSubject =>
      'Quattro piccoli quadratini di carta attaccati uno accanto all’altro.';

  @override
  String get ideasOneMarkerBlenderTip =>
      'Il blender è puro solvente: trasforma un solo pennarello scuro in una famiglia chiara tutta sua.';

  @override
  String get ideasOneMarkerBlenderStep1 =>
      'Fissa con il nastro di carta quattro piccoli quadrati di carta uno accanto all’altro.';

  @override
  String get ideasOneMarkerBlenderStep2 =>
      'Riempi il primo quadratino con il pennarello a piena forza.';

  @override
  String get ideasOneMarkerBlenderStep3 =>
      'Secondo quadratino: un tratto di pennarello e poi il blender sopra mentre è bagnato.';

  @override
  String get ideasOneMarkerBlenderStep4 =>
      'Terzo quadrato: prima il blender, poi il pennarello nel blender bagnato. Quarto: appoggia la punta del pennarello alla punta del blender e colora solo con il blender.';

  @override
  String get ideasOneMarkerBlenderStep5 =>
      'Mettili in fila: una scala di quattro gradini con un solo pennarello.';

  @override
  String get ideasColourWheelTitle => 'La tua ruota dei colori';

  @override
  String get ideasColourWheelSummary =>
      'Disponi dodici dei tuoi pennarelli a ruota e trova i buchi della tua collezione.';

  @override
  String get ideasColourWheelPractice =>
      'Leggere una ruota dei colori con i pennarelli che hai.';

  @override
  String get ideasColourWheelSubject =>
      'Un cerchio di circa dieci centimetri di diametro, diviso in dodici spicchi.';

  @override
  String get ideasColourWheelTip =>
      'Una ruota di pennarelli è, in una pagina sola, una lista della spesa e una guida alle mescolanze.';

  @override
  String get ideasColourWheelStep1 =>
      'Traccia un cerchio attorno a una tazza e dividilo in dodici spicchi.';

  @override
  String get ideasColourWheelStep2 =>
      'Scegli il pennarello più vicino al giallo puro, poi al rosso e poi al blu, e riempi i loro spicchi a quattro spicchi di distanza l’uno dall’altro.';

  @override
  String get ideasColourWheelStep3 =>
      'Riempi gli spicchi in mezzo con i pennarelli più vicini che hai: arancione, verde, viola e poi i sei di mezzo.';

  @override
  String get ideasColourWheelStep4 =>
      'Scrivi il codice di ogni pennarello sotto il suo spicchio. Uno spicchio vuoto o incerto è un pennarello che potresti comprare come prossimo.';

  @override
  String get ideasDeepSkinTitle => 'Toni di pelle scura';

  @override
  String get ideasDeepSkinSummary =>
      'Colora un viso con toni di pelle scura, con una luce calda e un tocco rossastro sulle guance.';

  @override
  String get ideasDeepSkinPractice =>
      'Ombreggiare la pelle scura con una lunga gamma di valori in un solo tono.';

  @override
  String get ideasDeepSkinSubject =>
      'Un viso di tre quarti, illuminato dal davanti.';

  @override
  String get ideasDeepSkinTip =>
      'La pelle scura ha bisogno di una lunga gamma di luminosità in un solo tono, e le famiglie di pennarelli sono fatte per questo.';

  @override
  String get ideasDeepSkinStep1 =>
      'Disegna un viso a matita e segna la fronte, il naso e gli zigomi come i piani illuminati.';

  @override
  String get ideasDeepSkinStep2 =>
      'Copri tutto il viso con il marrone più chiaro.';

  @override
  String get ideasDeepSkinStep3 =>
      'Mentre il primo strato è ancora bagnato, aggiungi il marrone rossastro sulle guance e sulle labbra.';

  @override
  String get ideasDeepSkinStep4 =>
      'Aggiungi il marrone base ovunque tranne che sui piani illuminati.';

  @override
  String get ideasDeepSkinStep5 =>
      'Usa il pennarello più scuro sotto le sopracciglia, il naso, il labbro inferiore e la mandibola, e lascia i piani illuminati solo con il primo strato.';

  @override
  String get ideasBlackObjectTitle => 'Nero senza nero';

  @override
  String get ideasBlackObjectSummary =>
      'Colora un gatto nero o uno stivale nero con blu e viola scuri, e tieni da parte il pennarello nero per la fine.';

  @override
  String get ideasBlackObjectPractice =>
      'Costruire un oggetto scuro con colori scuri invece che con il nero.';

  @override
  String get ideasBlackObjectSubject =>
      'Un gatto nero, uno stivale o un bollitore lucido.';

  @override
  String get ideasBlackObjectTip =>
      'Un pennarello nero piatto uccide la forma. I colori scuri sovrapposti la mantengono.';

  @override
  String get ideasBlackObjectStep1 =>
      'Disegna a matita l’oggetto e la forma dei suoi riflessi: le cose nere riflettono il cielo e la stanza.';

  @override
  String get ideasBlackObjectStep2 =>
      'Usa il grigio-blu chiaro e freddo sui riflessi e sulle facce superiori.';

  @override
  String get ideasBlackObjectStep3 =>
      'Copri gran parte dell’oggetto con il blu scuro.';

  @override
  String get ideasBlackObjectStep4 =>
      'Usa il viola scuro sulla parte inferiore.';

  @override
  String get ideasBlackObjectStep5 =>
      'Tieni il pennarello più scuro per le pieghe più profonde e aggiungi un bagliore di gel bianco se la superficie è lucida.';

  @override
  String get ideasWhiteObjectTitle => 'Bianco senza bianco';

  @override
  String get ideasWhiteObjectSummary =>
      'Una tazza o un uovo bianchi con grigi chiari, un’ombra tinta e molta carta intatta.';

  @override
  String get ideasWhiteObjectPractice =>
      'Colorare un oggetto bianco senza coprire la carta.';

  @override
  String get ideasWhiteObjectSubject =>
      'Una tazza bianca, un uovo o un tovagliolo piegato.';

  @override
  String get ideasWhiteObjectTip =>
      'Un oggetto bianco è per lo più carta. Con i pennarelli conviene lasciarlo stare.';

  @override
  String get ideasWhiteObjectStep1 =>
      'Disegna a matita l’oggetto e segna il lato illuminato: quello resta carta.';

  @override
  String get ideasWhiteObjectStep2 =>
      'Usa un pennarello dalla tinta molto pallida solo sul lato in ombra.';

  @override
  String get ideasWhiteObjectStep3 =>
      'Metti il grigio chiaro dentro, verso la parte più scura.';

  @override
  String get ideasWhiteObjectStep4 =>
      'Usa il grigio freddo un po’ più scuro solo lungo il bordo più lontano dalla luce e dove l’oggetto tocca il tavolo.';

  @override
  String get ideasWhiteObjectStep5 =>
      'Aggiungi un accenno del colore del tavolo riflesso nella parte inferiore dell’oggetto.';

  @override
  String get ideasFeatheredEdgeTitle => 'Bordo sfumato';

  @override
  String get ideasFeatheredEdgeSummary =>
      'Fai sparire un lato di una forma nella carta bianca e lascia l’altro bordo nitido.';

  @override
  String get ideasFeatheredEdgePractice =>
      'Un bordo morbido accanto a uno netto: il modo più semplice di dare luce a una forma.';

  @override
  String get ideasFeatheredEdgeSubject =>
      'Una foglia, un petalo o una piega di tessuto.';

  @override
  String get ideasFeatheredEdgeTip =>
      'Alza la punta mentre procedi: l’inchiostro si esaurisce da solo nel tratto.';

  @override
  String get ideasFeatheredEdgeStep1 =>
      'Disegna a matita una foglia e decidi quale bordo è nella luce.';

  @override
  String get ideasFeatheredEdgeStep2 =>
      'Colora il bordo scuro con il colore base in tratti corti che puntano tutti verso il lato illuminato.';

  @override
  String get ideasFeatheredEdgeStep3 =>
      'Passa il pennarello chiaro dal centro verso l’esterno sulle estremità di quei tratti, alzando la punta perché ogni tratto si spenga.';

  @override
  String get ideasFeatheredEdgeStep4 =>
      'Ripassa sulla giunzione, sempre dal colore verso il bianco.';

  @override
  String get ideasFeatheredEdgeStep5 =>
      'Confronta i due bordi: uno morbido, uno netto. È quel contrasto che fa leggere la forma.';

  @override
  String get ideasTipToTipTitle => 'Punta contro punta';

  @override
  String get ideasTipToTipSummary =>
      'Carica un colore scuro sulla punta di un pennarello chiaro e fai una sfumatura in una passata.';

  @override
  String get ideasTipToTipPractice =>
      'Rubare l’inchiostro da un pennarello all’altro per una sfumatura veloce.';

  @override
  String get ideasTipToTipSubject => 'Una striscia di carta larga due dita.';

  @override
  String get ideasTipToTipTip =>
      'Tieni fermo il pennarello scuro: la punta chiara prende inchiostro solo dalla punta dell’altro.';

  @override
  String get ideasTipToTipStep1 =>
      'Fissa con il nastro di carta una striscia larga circa due dita.';

  @override
  String get ideasTipToTipStep2 =>
      'Tieni fermo il pennarello scuro e appoggiaci sopra per qualche secondo la punta di quello chiaro.';

  @override
  String get ideasTipToTipStep3 =>
      'Comincia in basso sulla striscia con la punta carica: i primi tratti sono scuri, poi torna il colore del pennarello.';

  @override
  String get ideasTipToTipStep4 =>
      'Scarabocchia la punta su un foglio di scarto finché torna pulita: il pennarello chiaro non si rovina.';

  @override
  String get ideasTipToTipStep5 =>
      'Ripeti su una seconda striscia, caricando la punta più a lungo: la parte scura arriva più lontano.';

  @override
  String get ideasBlenderPatternTitle => 'Motivi con il blender';

  @override
  String get ideasBlenderPatternSummary =>
      'Solleva punti e linee da un colore piatto con il blender incolore.';

  @override
  String get ideasBlenderPatternPractice =>
      'Spostare l’inchiostro invece di cancellarlo: punti, linee e motivi.';

  @override
  String get ideasBlenderPatternSubject =>
      'Un quadrato di colore su cui disegnare il motivo.';

  @override
  String get ideasBlenderPatternTip =>
      'Aspetta fra un tocco e l’altro: due segni troppo vicini si uniscono.';

  @override
  String get ideasBlenderPatternStep1 =>
      'Riempi un quadrato con il colore base e lascialo asciugare del tutto.';

  @override
  String get ideasBlenderPatternStep2 =>
      'Premi la punta fine del blender nel colore e tienila un secondo: si apre un punto chiaro con un bordo più scuro.';

  @override
  String get ideasBlenderPatternStep3 =>
      'Traccia una linea con la punta larga: l’inchiostro spinto si raccoglie sui bordi.';

  @override
  String get ideasBlenderPatternStep4 =>
      'Fai un motivo: pois, strisce o una fila di squame di pesce.';

  @override
  String get ideasBlenderPatternStep5 =>
      'Aspetta fra i tocchi, altrimenti i punti si uniscono.';

  @override
  String get ideasOneMarkerLayersTitle => 'Un pennarello, tre strati';

  @override
  String get ideasOneMarkerLayersSummary =>
      'Ombreggia un cubo con un solo pennarello sovrapponendo una, due e tre passate.';

  @override
  String get ideasOneMarkerLayersPractice =>
      'Quanta gamma di toni ha un solo pennarello quando gli strati si asciugano uno sull’altro.';

  @override
  String get ideasOneMarkerLayersSubject =>
      'Un cubo con la luce da un angolo in alto.';

  @override
  String get ideasOneMarkerLayersTip =>
      'Lascia asciugare ogni strato: una seconda passata umida sposta l’inchiostro invece di scurirlo.';

  @override
  String get ideasOneMarkerLayersStep1 =>
      'Disegna a matita un cubo, con la luce che viene da un angolo in alto.';

  @override
  String get ideasOneMarkerLayersStep2 =>
      'Una passata su ogni faccia. Lascia asciugare.';

  @override
  String get ideasOneMarkerLayersStep3 =>
      'Una seconda passata sulle due facce lontane dalla luce.';

  @override
  String get ideasOneMarkerLayersStep4 =>
      'Una terza passata solo sulla faccia più scura e lungo gli spigoli in basso.';

  @override
  String get ideasOneMarkerLayersStep5 =>
      'Guarda i tre valori: è tutta la gamma di un solo pennarello.';

  @override
  String get ideasStipplePeelTitle => 'Buccia d’arancia puntinata';

  @override
  String get ideasStipplePeelSummary =>
      'Costruisci la texture porosa della buccia di un agrume con punti sopra una sfumatura.';

  @override
  String get ideasStipplePeelPractice =>
      'Puntinare sopra una sfumatura asciutta, senza spalmarla.';

  @override
  String get ideasStipplePeelSubject =>
      'Un’arancia con una luce morbida sulla parte alta.';

  @override
  String get ideasStipplePeelTip => 'Usa la punta fine: dà dei punti puliti.';

  @override
  String get ideasStipplePeelStep1 =>
      'Disegna a matita un’arancia e una luce morbida sulla parte alta.';

  @override
  String get ideasStipplePeelStep2 =>
      'Riempi l’arancia lasciando la luce più chiara.';

  @override
  String get ideasStipplePeelStep3 =>
      'Fondi il colore base nella metà in ombra mentre il colore è ancora bagnato.';

  @override
  String get ideasStipplePeelStep4 =>
      'Quando è asciutto, picchietta la punta fine del pennarello d’ombra in punti sparsi: più fitti nell’ombra, quasi nessuno vicino alla luce.';

  @override
  String get ideasStipplePeelStep5 =>
      'Picchietta qualche punto chiaro dentro i punti scuri per spezzarli.';

  @override
  String get ideasClearGlassTitle => 'Un bicchiere trasparente';

  @override
  String get ideasClearGlassSummary =>
      'Colora un bicchiere vuoto con i grigi e quasi nient’altro.';

  @override
  String get ideasClearGlassPractice =>
      'Grigi e carta bianca: il modo più leggero di disegnare il vetro.';

  @override
  String get ideasClearGlassSubject =>
      'Un bicchiere con il bordo, il piede e due riflessi verticali.';

  @override
  String get ideasClearGlassTip =>
      'Il vetro è più scuro dove è più spesso: sul bordo e al piede.';

  @override
  String get ideasClearGlassStep1 =>
      'Disegna il bicchiere a matita e segna il bordo, il piede e due riflessi verticali che restano carta bianca.';

  @override
  String get ideasClearGlassStep2 =>
      'Colora il bicchiere con il grigio più chiaro, lasciando in bianco i riflessi e quasi tutto il centro.';

  @override
  String get ideasClearGlassStep3 =>
      'Scurisci il bordo, il piede spesso e il bordo lontano: il vetro è più scuro dove è più spesso.';

  @override
  String get ideasClearGlassStep4 =>
      'Stendi una macchia di colore dietro il bicchiere e lascia che una versione più tenue si veda attraverso il vetro, sopra il grigio chiaro.';

  @override
  String get ideasClearGlassStep5 =>
      'Penna gel bianca sul bordo e sul piede per i bagliori più netti.';

  @override
  String get ideasPolishedMetalTitle => 'Metallo lucido';

  @override
  String get ideasPolishedMetalSummary =>
      'Fai sembrare di metallo un cucchiaio, con bande di grigio a bordi netti e un colore riflesso.';

  @override
  String get ideasPolishedMetalPractice =>
      'Bande a bordo duro e una lunga gamma di valori: così si legge il metallo.';

  @override
  String get ideasPolishedMetalSubject =>
      'Un cucchiaio con le bande del suo riflesso già disegnate.';

  @override
  String get ideasPolishedMetalTip =>
      'Il metallo non ha passaggi morbidi: lascia netti i bordi delle bande.';

  @override
  String get ideasPolishedMetalStep1 =>
      'Disegna a matita il cucchiaio e i suoi riflessi come bande: una scura attraverso la coppa, una chiara accanto, senza passaggi morbidi.';

  @override
  String get ideasPolishedMetalStep2 =>
      'Riempi coppa e manico con il grigio più chiaro.';

  @override
  String get ideasPolishedMetalStep3 =>
      'Metti le bande scure a bordi netti, seguendo la curva della coppa.';

  @override
  String get ideasPolishedMetalStep4 =>
      'Metti il grigio più scuro proprio accanto alla banda più chiara: il metallo vive di quel contrasto.';

  @override
  String get ideasPolishedMetalStep5 =>
      'Lascia che una macchia del colore del tavolo si rifletta nella metà bassa della coppa e metti il gel bianco sul riflesso più netto.';

  @override
  String get ideasCastShadowTitle => 'L’ombra sul tavolo';

  @override
  String get ideasCastShadowSummary =>
      'Disegna una tazza e la sua ombra portata come si deve: scura al contatto, morbida più lontano.';

  @override
  String get ideasCastShadowPractice =>
      'Ombre portate: la linea di contatto, la sfumatura verso l’esterno e il grigio che le disegna.';

  @override
  String get ideasCastShadowSubject =>
      'Una tazza su un tavolo, con la luce da un lato.';

  @override
  String get ideasCastShadowTip =>
      'L’ombra comincia dove l’oggetto tocca il tavolo, non dove finisce la luce.';

  @override
  String get ideasCastShadowStep1 =>
      'Disegna a matita una tazza e la forma della sua ombra sul tavolo, più lunga dal lato opposto alla luce.';

  @override
  String get ideasCastShadowStep2 =>
      'Colora la tazza e ombreggia il lato lontano dalla luce con lo stesso pennarello in un secondo strato.';

  @override
  String get ideasCastShadowStep3 =>
      'Riempi l’ombra portata con il grigio: parti dalla base della tazza e alza la punta man mano che ti allontani.';

  @override
  String get ideasCastShadowStep4 =>
      'Aggiungi una linea scura sottile dove la tazza tocca il tavolo.';

  @override
  String get ideasCastShadowStep5 =>
      'Addolcisci il bordo lontano dell’ombra con un secondo tocco leggero di grigio mentre il primo è ancora bagnato.';

  @override
  String get ideasSoftCloudsTitle => 'Nuvole morbide';

  @override
  String get ideasSoftCloudsSummary =>
      'Colora il cielo intorno alle nuvole e lascia le nuvole in carta bianca.';

  @override
  String get ideasSoftCloudsPractice =>
      'Colorare in negativo: la forma è la carta che non hai toccato.';

  @override
  String get ideasSoftCloudsSubject =>
      'Due o tre nuvole con la parte sopra tonda e quella sotto più piatta.';

  @override
  String get ideasSoftCloudsTip =>
      'Lavora intorno alle nuvole con la punta larga: i bordi restano un po’ irregolari.';

  @override
  String get ideasSoftCloudsStep1 =>
      'Disegna a matita, molto leggero, due o tre nuvole: sopra tonde, sotto più piatte.';

  @override
  String get ideasSoftCloudsStep2 =>
      'Riempi il cielo con l’azzurro chiaro, lavorando intorno alle nuvole con la punta larga perché i loro bordi restino un po’ irregolari.';

  @override
  String get ideasSoftCloudsStep3 =>
      'Scurisci il cielo verso l’alto e fondilo con l’azzurro chiaro mentre è bagnato.';

  @override
  String get ideasSoftCloudsStep4 =>
      'Ombreggia la parte sotto di ogni nuvola con il grigio chiaro, lasciando bianche le cime.';

  @override
  String get ideasSoftCloudsStep5 =>
      'Addolcisci con il blender ogni bordo netto del cielo contro una nuvola, spingendo il colore verso l’esterno.';

  @override
  String get ideasStillWaterTitle => 'Riflesso nell’acqua ferma';

  @override
  String get ideasStillWaterSummary =>
      'Disegna un albero sulla riva e la sua copia capovolta, un po’ più scura, nell’acqua.';

  @override
  String get ideasStillWaterPractice =>
      'Sovrapporre un colore a un altro: così si fa un riflesso.';

  @override
  String get ideasStillWaterSubject =>
      'Un albero sulla riva con il suo riflesso nell’acqua sotto.';

  @override
  String get ideasStillWaterTip =>
      'Dipingi il riflesso solo con tratti orizzontali: l’acqua si muove di lato.';

  @override
  String get ideasStillWaterStep1 =>
      'Disegna a matita una linea d’orizzonte, un albero semplice sopra e la sua immagine speculare sotto.';

  @override
  String get ideasStillWaterStep2 =>
      'Colora l’albero e il suo riflesso con lo stesso pennarello, il riflesso solo con tratti orizzontali.';

  @override
  String get ideasStillWaterStep3 =>
      'Stendi l’azzurro chiaro su tutta l’acqua, riflesso compreso, con lunghi tratti orizzontali.';

  @override
  String get ideasStillWaterStep4 =>
      'Scurisci l’acqua vicino alla riva e sul bordo lontano; aggiungi qualche linea orizzontale spezzata di colore base sul riflesso.';

  @override
  String get ideasStillWaterStep5 =>
      'Metti l’azzurro scuro dove la riva tocca l’acqua e traccia due o tre linee sottili di gel bianco per le increspature.';

  @override
  String get ideasTwistedRibbonTitle => 'Nastro attorcigliato';

  @override
  String get ideasTwistedRibbonSummary =>
      'Fondi una sfumatura che segue la curva di un nastro che si attorciglia, passando sopra e sotto sé stesso.';

  @override
  String get ideasTwistedRibbonPractice =>
      'Ripetere una sfumatura breve su ogni curva di una forma.';

  @override
  String get ideasTwistedRibbonSubject =>
      'Un nastro con due attorcigliature, sopra e sotto sé.';

  @override
  String get ideasTwistedRibbonTip =>
      'Fondi lungo la curva del nastro, mai di traverso.';

  @override
  String get ideasTwistedRibbonStep1 =>
      'Disegna a matita un nastro con due attorcigliature e segna quali tratti mostrano il davanti e quali il retro.';

  @override
  String get ideasTwistedRibbonStep2 =>
      'Riempi ogni tratto con il pennarello chiaro.';

  @override
  String get ideasTwistedRibbonStep3 =>
      'Su ogni tratto metti il colore base sul lato che si curva via da te, con tratti che seguono la curva e non vanno di traverso.';

  @override
  String get ideasTwistedRibbonStep4 =>
      'Scurisci solo dove un tratto passa sotto un altro, in una banda stretta proprio all’incrocio.';

  @override
  String get ideasTwistedRibbonStep5 =>
      'Passa il blender su ogni banda dove la sfumatura sembra a scalini.';

  @override
  String get ideasNoLineLeafTitle => 'Colorazione senza contorno';

  @override
  String get ideasNoLineLeafSummary =>
      'Colora una foglia partendo da uno schizzo a matita e lascia che i bordi del colore facciano da contorno.';

  @override
  String get ideasNoLineLeafPractice =>
      'Disegnare senza liner: il bordo del colore è il contorno.';

  @override
  String get ideasNoLineLeafSubject =>
      'Una foglia semplice con la nervatura centrale.';

  @override
  String get ideasNoLineLeafTip =>
      'Schiarisci la matita con una gomma morbida finché la vedi appena.';

  @override
  String get ideasNoLineLeafStep1 =>
      'Disegna la foglia e la nervatura centrale molto leggere a matita, poi schiarisci la grafite con una gomma morbida finché la vedi appena.';

  @override
  String get ideasNoLineLeafStep2 =>
      'Riempi la foglia e fermati esattamente sulla linea di matita.';

  @override
  String get ideasNoLineLeafStep3 =>
      'Ombreggia metà foglia e la base mentre il primo strato è ancora bagnato.';

  @override
  String get ideasNoLineLeafStep4 =>
      'Definisci il bordo dal lato in ombra con una linea sottile del pennarello più scuro, invece che con un liner.';

  @override
  String get ideasNoLineLeafStep5 =>
      'Cancella la matita che ancora si vede quando l’inchiostro è asciutto.';

  @override
  String get ideasShortFurTitle => 'Pelo corto';

  @override
  String get ideasShortFurSummary =>
      'Colora un orecchio di gatto con colpi di polso corti in due direzioni.';

  @override
  String get ideasShortFurPractice =>
      'Tratti corti che seguono la direzione del pelo.';

  @override
  String get ideasShortFurSubject =>
      'Un orecchio di gatto con qualche freccia che mostra da che parte cresce il pelo.';

  @override
  String get ideasShortFurTip =>
      'Dai colpi di polso dalle radici verso l’esterno: premi, muoviti veloce e solleva.';

  @override
  String get ideasShortFurStep1 =>
      'Disegna a matita l’orecchio e la direzione del pelo con qualche freccia.';

  @override
  String get ideasShortFurStep2 =>
      'Riempi l’orecchio con il pennarello chiaro, dando colpi di polso verso l’esterno sul bordo, così il contorno sembra peloso e non pieno.';

  @override
  String get ideasShortFurStep3 =>
      'Dai colpi di polso brevi con il colore base dal bordo interno verso l’esterno, seguendo le frecce.';

  @override
  String get ideasShortFurStep4 =>
      'Fai meno colpi di polso, e più scuri, dentro l’orecchio e alla base, dove si unisce alla testa.';

  @override
  String get ideasShortFurStep5 =>
      'Ripassa il pennarello chiaro sulle giunzioni con colpi di polso, per fondere gli strati e addolcire i colpi più scuri.';

  @override
  String get ideasWoodGrainTitle => 'Tavola di legno';

  @override
  String get ideasWoodGrainSummary =>
      'Una tavola con le venature e un nodo, in tre marroni.';

  @override
  String get ideasWoodGrainPractice =>
      'Tratti lunghi che seguono la forma del materiale.';

  @override
  String get ideasWoodGrainSubject =>
      'Una tavola di legno con un nodo vicino a un’estremità.';

  @override
  String get ideasWoodGrainTip =>
      'Le venature girano attorno al nodo: disegna le linee curve, mai dritte.';

  @override
  String get ideasWoodGrainStep1 =>
      'Disegna a matita una tavola con un nodo; le venature girano attorno al nodo come l’acqua attorno a una pietra.';

  @override
  String get ideasWoodGrainStep2 =>
      'Riempi la tavola con tratti lunghi lungo le venature.';

  @override
  String get ideasWoodGrainStep3 =>
      'Aggiungi linee lunghe e un po’ ondulate di colore base lungo le venature, più fitte vicino al nodo.';

  @override
  String get ideasWoodGrainStep4 =>
      'Aggiungi qualche linea più scura e gli anelli del nodo; scurisci il bordo inferiore della tavola.';

  @override
  String get ideasWoodGrainStep5 =>
      'Ripassa il pennarello chiaro sulle linee per addolcire le zone in cui sembrano disegnate sopra.';

  @override
  String get ideasBrickWallTitle => 'Muro di mattoni';

  @override
  String get ideasBrickWallSummary =>
      'Un tratto di muro in mattoni di colori leggermente diversi e malta chiara.';

  @override
  String get ideasBrickWallPractice =>
      'Riempimenti piatti, mattone per mattone, e il grigio della malta.';

  @override
  String get ideasBrickWallSubject =>
      'Un tratto di muro con una ventina di mattoni.';

  @override
  String get ideasBrickWallTip =>
      'Lascia la malta come carta: è più chiara di qualsiasi mattone.';

  @override
  String get ideasBrickWallStep1 =>
      'Disegna a matita la griglia della malta e lasciala per ora come carta.';

  @override
  String get ideasBrickWallStep2 =>
      'Riempi ogni mattone con il pennarello chiaro, lasciando che ogni mattone asciughi come una forma a sé.';

  @override
  String get ideasBrickWallStep3 =>
      'Passa il colore base su circa metà dei mattoni, scelti a caso, perché il muro non sia uniforme.';

  @override
  String get ideasBrickWallStep4 =>
      'Ombreggia il bordo inferiore di ogni mattone e aggiungi qualche scheggiatura e qualche mattone più scuro.';

  @override
  String get ideasBrickWallStep5 =>
      'Riempi le giunture di malta con il grigio chiaro.';

  @override
  String get ideasFoldedClothTitle => 'Tessuto piegato';

  @override
  String get ideasFoldedClothSummary =>
      'Ombreggia le pieghe di un tessuto appeso con quattro valori e una sola direzione di luce.';

  @override
  String get ideasFoldedClothPractice =>
      'La stessa sfumatura ripetuta su ogni piega.';

  @override
  String get ideasFoldedClothSubject =>
      'Un tessuto appeso a una corda, con tre o quattro pieghe.';

  @override
  String get ideasFoldedClothTip =>
      'La linea più scura va solo dove il tessuto si ripiega su sé stesso.';

  @override
  String get ideasFoldedClothStep1 =>
      'Disegna a matita un tessuto appeso a una corda, con tre o quattro pieghe, e segna la parte alta di ogni piega.';

  @override
  String get ideasFoldedClothStep2 => 'Riempi il tessuto.';

  @override
  String get ideasFoldedClothStep3 =>
      'Aggiungi il colore base sul lato di ogni piega lontano dalla luce e fondilo nel chiaro mentre è bagnato.';

  @override
  String get ideasFoldedClothStep4 =>
      'Aggiungi l’ombra in fondo a ogni piega, dove il tessuto si ripiega.';

  @override
  String get ideasFoldedClothStep5 =>
      'Aggiungi una linea scura sottile solo in fondo alle pieghe più profonde; sfuma con il blender ogni scalino netto nelle parti tonde.';

  @override
  String get ideasWaterDropsTitle => 'Gocce su una foglia';

  @override
  String get ideasWaterDropsSummary =>
      'Tre gocce d’acqua su una foglia, ognuna con un’ombra, un bordo scuro e un puntino di luce.';

  @override
  String get ideasWaterDropsPractice =>
      'Qualche segno netto sopra una sfumatura già finita.';

  @override
  String get ideasWaterDropsSubject => 'Una foglia con tre gocce d’acqua.';

  @override
  String get ideasWaterDropsTip =>
      'La goccia inverte la luce: ombreggia il lato rivolto verso la luce.';

  @override
  String get ideasWaterDropsStep1 =>
      'Disegna a matita una foglia e tre gocce; segna in ogni goccia una piccola luce sul lato illuminato.';

  @override
  String get ideasWaterDropsStep2 =>
      'Colora tutta la foglia, gocce comprese; le gocce sono la foglia vista attraverso l’acqua.';

  @override
  String get ideasWaterDropsStep3 =>
      'Ombreggia la foglia e, dentro ogni goccia, il lato verso la luce, perché la goccia funziona da lente e la inverte.';

  @override
  String get ideasWaterDropsStep4 =>
      'Aggiungi una sottile mezzaluna scura sul lato opposto di ogni goccia e una piccola ombra portata sotto.';

  @override
  String get ideasWaterDropsStep5 =>
      'Con la penna gel bianca: un punto netto per goccia sul lato illuminato e un bordo chiaro e tenue sul lato opposto.';

  @override
  String get ideasStrawberrySeedsTitle => 'Fragola';

  @override
  String get ideasStrawberrySeedsSummary =>
      'Una fragola con i semi annidati in piccoli avvallamenti e una corona verde.';

  @override
  String get ideasStrawberrySeedsPractice =>
      'Texture fatta di piccoli segni: avvallamenti, semi e corona.';

  @override
  String get ideasStrawberrySeedsSubject =>
      'Una fragola con una griglia libera di semi.';

  @override
  String get ideasStrawberrySeedsTip =>
      'Picchietta gli avvallamenti mentre il colore è ancora bagnato: l’anello più scuro si forma da solo.';

  @override
  String get ideasStrawberrySeedsStep1 =>
      'Disegna a matita la fragola e una griglia libera di punti di seme, più ravvicinati verso la punta.';

  @override
  String get ideasStrawberrySeedsStep2 =>
      'Riempi il frutto lasciando una luce morbida.';

  @override
  String get ideasStrawberrySeedsStep3 =>
      'Fondi il colore base sui lati; mentre è bagnato, premi un punto un po’ più scuro sopra ogni seme.';

  @override
  String get ideasStrawberrySeedsStep4 =>
      'Scurisci la metà bassa e l’avvallamento sopra ogni seme.';

  @override
  String get ideasStrawberrySeedsStep5 =>
      'Colora le foglie e il peduncolo con il verde, poi metti un minuscolo punto di gel chiaro in ogni avvallamento per il seme.';

  @override
  String get ideasPaletteMixingTitle => 'Miscelare su una palette';

  @override
  String get ideasPaletteMixingSummary =>
      'Crea un terzo colore mescolando due pennarelli su una superficie di plastica e riprendilo con il blender.';

  @override
  String get ideasPaletteMixingPractice =>
      'Mescolare due inchiostri fuori dal foglio, con il blender come pennello.';

  @override
  String get ideasPaletteMixingSubject =>
      'Un coperchio di plastica o una scheda per miscelare, più un foglio di scarto.';

  @override
  String get ideasPaletteMixingTip =>
      'Il blender porta solo ciò che è bagnato: non lasciare asciugare le macchie.';

  @override
  String get ideasPaletteMixingStep1 =>
      'Scarabocchia il primo pennarello su una superficie che non assorbe, come una scheda per miscelare, un coperchio di plastica o una bustina con chiusura zip.';

  @override
  String get ideasPaletteMixingStep2 =>
      'Scarabocchia il secondo pennarello accanto, così che le due macchie si tocchino.';

  @override
  String get ideasPaletteMixingStep3 =>
      'Prendi il misto con la punta larga del blender incolore e fai un campione; accanto fai un campione di ogni pennarello da solo.';

  @override
  String get ideasPaletteMixingStep4 =>
      'Prova una seconda miscela con più inchiostro di uno dei due colori.';

  @override
  String get ideasPaletteMixingStep5 =>
      'Annota quali miscele vorresti avere come pennarelli.';

  @override
  String get ideasLongHairTitle => 'Capelli lunghi';

  @override
  String get ideasLongHairSummary =>
      'Una cascata di capelli con una fascia di luce e ciocche che seguono la testa.';

  @override
  String get ideasLongHairPractice =>
      'Tratti lunghi che si assottigliano e una fascia di luce che è solo carta.';

  @override
  String get ideasLongHairSubject =>
      'Una chioma con poche ciocche grandi e una fascia di luce.';

  @override
  String get ideasLongHairTip =>
      'Premi meno dentro la fascia di luce: ci pensa la carta.';

  @override
  String get ideasLongHairStep1 =>
      'Disegna a matita i capelli in poche ciocche grandi, non in capelli singoli, e una fascia curva dove arriva la luce.';

  @override
  String get ideasLongHairStep2 =>
      'Riempi tutti i capelli premendo meno dentro la fascia di luce.';

  @override
  String get ideasLongHairStep3 =>
      'Fai tratti lunghi dalla scriminatura verso il basso, sollevando la punta quando arrivi alla fascia di luce; poi altri dalle punte verso l’alto, fino alla fascia.';

  @override
  String get ideasLongHairStep4 =>
      'Scurisci tra le ciocche, sotto l’orecchio e sul collo.';

  @override
  String get ideasLongHairStep5 =>
      'Aggiungi qualche filo sottile del pennarello più scuro, poi due o tre fili fini di gel bianco solo dentro la fascia di luce.';

  @override
  String get ideasOverlapGlazesTitle => 'Strati sovrapposti';

  @override
  String get ideasOverlapGlazesSummary =>
      'Sovrapponi tre cerchi trasparenti e guarda quali colori nuovi compaiono.';

  @override
  String get ideasOverlapGlazesPractice =>
      'Strati trasparenti: ogni sovrapposizione è una vera miscela.';

  @override
  String get ideasOverlapGlazesSubject =>
      'Tre cerchi sovrapposti, come un diagramma di Venn.';

  @override
  String get ideasOverlapGlazesTip =>
      'L’ordine conta: il colore più chiaro sopra sembra sempre diverso.';

  @override
  String get ideasOverlapGlazesStep1 =>
      'Disegna a matita tre cerchi che si sovrappongono come un diagramma di Venn.';

  @override
  String get ideasOverlapGlazesStep2 =>
      'Riempi il primo cerchio e lascialo asciugare del tutto.';

  @override
  String get ideasOverlapGlazesStep3 =>
      'Riempi il secondo, sovrapposizione compresa; la sovrapposizione diventa un terzo colore.';

  @override
  String get ideasOverlapGlazesStep4 =>
      'Riempi il terzo cerchio; il centro, dove si incontrano tutti e tre, è la miscela più scura.';

  @override
  String get ideasOverlapGlazesStep5 =>
      'Ripeti con i pennarelli in un altro ordine: il colore più chiaro sopra sembra sempre diverso.';

  @override
  String get ideasFadedBackgroundTitle => 'Sfondo sfumato';

  @override
  String get ideasFadedBackgroundSummary =>
      'Dai a un disegno un alone di colore che svanisce nel bianco molto prima del bordo del foglio.';

  @override
  String get ideasFadedBackgroundPractice =>
      'Una vignetta fatta di tratti circolari e del blender.';

  @override
  String get ideasFadedBackgroundSubject =>
      'Una tazza, un uccellino o un altro piccolo soggetto al centro del foglio.';

  @override
  String get ideasFadedBackgroundTip =>
      'Fermati prima del bordo del foglio: l’alone svanisce da solo.';

  @override
  String get ideasFadedBackgroundStep1 =>
      'Disegna a matita un soggetto semplice, come una tazza o un uccellino, al centro del foglio.';

  @override
  String get ideasFadedBackgroundStep2 =>
      'Colora un anello di colore base intorno al soggetto, largo un dito, con tratti circolari.';

  @override
  String get ideasFadedBackgroundStep3 =>
      'Porta il pennarello chiaro dall’anello verso l’esterno in cerchi sovrapposti finché si sbiadisce.';

  @override
  String get ideasFadedBackgroundStep4 =>
      'Continua con il blender oltre il colore, spingendo il resto dentro la carta perché non resti alcun bordo.';

  @override
  String get ideasFadedBackgroundStep5 =>
      'Finisci il soggetto in modo che sia più scuro dell’alone.';

  @override
  String get ideasHatchShadingTitle => 'Ombreggiatura a tratteggio';

  @override
  String get ideasHatchShadingSummary =>
      'Ombreggia una mela solo con linee, senza fondere: tratteggio per il tono medio e tratteggio incrociato per l’ombra.';

  @override
  String get ideasHatchShadingPractice =>
      'Tratteggio e tratteggio incrociato: linee che si leggono come un tono.';

  @override
  String get ideasHatchShadingSubject => 'Una mela con la luce segnata.';

  @override
  String get ideasHatchShadingTip =>
      'Tieni le linee parallele e regolarmente distanziate: fa il resto l’occhio.';

  @override
  String get ideasHatchShadingStep1 =>
      'Disegna a matita una mela e segna la luce.';

  @override
  String get ideasHatchShadingStep2 =>
      'Riempi la mela in piano e lascia asciugare.';

  @override
  String get ideasHatchShadingStep3 =>
      'Tratteggia la metà in ombra con linee parallele della punta fine, sempre più ravvicinate man mano che ti allontani dalla luce.';

  @override
  String get ideasHatchShadingStep4 =>
      'Incrocia la zona più scura con una seconda serie di linee con un’altra inclinazione e aggiungi l’ombra di contatto sotto la mela.';

  @override
  String get ideasHatchShadingStep5 =>
      'Fai un passo indietro: da lontano le linee diventano un tono.';

  @override
  String get ideasCategoryTechnique => 'Tecniche';

  @override
  String get ideasCategoryColorChallenge => 'Sfide di colore';

  @override
  String get ideasCategoryMood => 'Atmosfere';

  @override
  String get ideasCategorySeason => 'Stagioni';

  @override
  String get ideasDifficultyEasy => 'Facile';

  @override
  String get ideasDifficultyMedium => 'Media';

  @override
  String get ideasDifficultyHard => 'Difficile';

  @override
  String get ideasSeasonSpring => 'Primavera';

  @override
  String get ideasSeasonSummer => 'Estate';

  @override
  String get ideasSeasonAutumn => 'Autunno';

  @override
  String get ideasSeasonWinter => 'Inverno';

  @override
  String get ideasSectionAnyTime => 'Tutto l’anno';

  @override
  String ideasSeeAllSemantic(int count, String category) {
    return 'Vedi le $count idee in $category';
  }

  @override
  String get ideasFeaturedLabel => 'Idea del giorno';

  @override
  String get ideasOtherMarkersButton => 'Altri pennarelli';

  @override
  String get ideasPracticeTitle => 'Cosa eserciti';

  @override
  String get ideasSubjectTitle => 'Cosa disegnare';

  @override
  String get ideasMarkersTitle => 'I tuoi pennarelli';

  @override
  String get ideasStepsTitle => 'Passi';

  @override
  String get ideasTipTitle => 'Consiglio';

  @override
  String get ideasMaterialsTitle => 'Ti serve';

  @override
  String get ideasMaterialPaper => 'carta per pennarelli con un foglio sotto';

  @override
  String get ideasMaterialBlender => 'blender incolore';

  @override
  String get ideasMaterialWhiteGel => 'penna gel bianca';

  @override
  String get ideasMaterialPigmentLiner => 'liner nero a pigmento';

  @override
  String get ideasMaterialPencil => 'matita';

  @override
  String get ideasMaterialTape => 'nastro di carta';

  @override
  String get ideasBackLabel => 'Torna alle idee';

  @override
  String ideasMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String ideasMissingMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Alla tua collezione mancano $count pennarelli per questa idea.',
      one: 'Alla tua collezione manca 1 pennarello per questa idea.',
    );
    return '$_temp0';
  }

  @override
  String ideasMarkerSemantic(String role, String code, String name) {
    return '$role: $code $name';
  }

  @override
  String get ideasSmoothFillTitle => 'Campitura senza righe';

  @override
  String get ideasSmoothFillSummary =>
      'Riempi un quadrato con un solo pennarello senza righe visibili.';

  @override
  String get ideasSmoothFillPractice =>
      'Copertura uniforme e senza righe, la base di ogni disegno a pennarello.';

  @override
  String get ideasSmoothFillSubject =>
      'Un quadrato di 5 × 5 cm delimitato con nastro di carta, poi una forma piatta semplice come una foglia.';

  @override
  String get ideasSmoothFillTip =>
      'Se la carta inizia a formare pallini, fermati: è satura. Lasciala asciugare del tutto prima di un altro strato.';

  @override
  String get ideasSmoothFillStep1 =>
      'Fissa con il nastro un quadrato di 5 × 5 cm su carta per pennarelli e metti un foglio di scarto sotto.';

  @override
  String get ideasSmoothFillStep2 =>
      'Riempi il quadrato con il pennarello chiaro a piccoli cerchi sovrapposti, senza fermarti.';

  @override
  String get ideasSmoothFillStep3 =>
      'Mantieni il bordo bagnato: ripassa sempre sull’inchiostro ancora lucido, mai su quello asciutto.';

  @override
  String get ideasSmoothFillStep4 =>
      'Lascia asciugare, poi aggiungi un secondo strato con lo stesso pennarello, ad angolo retto rispetto al primo.';

  @override
  String get ideasSmoothFillStep5 =>
      'Ripeti il quadrato con il pennarello più scuro e confronta: le righe si vedono di più nei colori scuri.';

  @override
  String get ideasSmoothFillStep6 =>
      'Stacca il nastro lentamente per scoprire un bordo pulito.';

  @override
  String get ideasThreeMarkerBlendTitle => 'Sfumatura a tre pennarelli';

  @override
  String get ideasThreeMarkerBlendSummary =>
      'Sfuma un pennarello chiaro, uno medio e uno scuro della stessa famiglia su una palla.';

  @override
  String get ideasThreeMarkerBlendPractice =>
      'Sfumare con dolcezza da chiaro a scuro in una famiglia di colore.';

  @override
  String get ideasThreeMarkerBlendSubject =>
      'Una palla illuminata da in alto a sinistra, con la sua ombra sul tavolo.';

  @override
  String get ideasThreeMarkerBlendTip =>
      'Scegli pennarelli vicini di tono: se il salto è troppo grande, si vedrà una linea.';

  @override
  String get ideasThreeMarkerBlendStep1 =>
      'Disegna un cerchio a matita leggera e segna da dove viene la luce.';

  @override
  String get ideasThreeMarkerBlendStep2 =>
      'Copri tutta la palla con il pennarello chiaro, lasciando un piccolo punto di carta bianca per la luce.';

  @override
  String get ideasThreeMarkerBlendStep3 =>
      'Mentre è ancora umido, aggiungi il pennarello medio sulla metà in ombra, con tratti curvi che seguono la forma.';

  @override
  String get ideasThreeMarkerBlendStep4 =>
      'Aggiungi il pennarello scuro solo lungo il bordo più lontano dalla luce.';

  @override
  String get ideasThreeMarkerBlendStep5 =>
      'Ripassa i punti di unione con il pennarello medio e poi con quello chiaro per fondere i passaggi.';

  @override
  String get ideasThreeMarkerBlendStep6 =>
      'Ammorbidisci ogni bordo netto attorno alla luce con il blender incolore.';

  @override
  String get ideasFlickingTitle => 'Tratti a sventaglio';

  @override
  String get ideasFlickingSummary =>
      'Disegna capelli o erba con tratti rapidi che sfumano alla fine.';

  @override
  String get ideasFlickingPractice =>
      'Il flicking: tratti veloci che si assottigliano, per sfumare senza bordi netti.';

  @override
  String get ideasFlickingSubject => 'Una coda di cavallo o un ciuffo d’erba.';

  @override
  String get ideasFlickingTip =>
      'Prova prima su un foglio di scarto: più vai veloce, più sottile è la coda del tratto.';

  @override
  String get ideasFlickingStep1 =>
      'Abbozza a matita le ciocche o i fili d’erba principali come forme semplici, senza dettagli.';

  @override
  String get ideasFlickingStep2 =>
      'Copri ogni forma con il pennarello chiaro in uno strato piatto e lascia asciugare.';

  @override
  String get ideasFlickingStep3 =>
      'Dai un colpo di polso con il pennarello medio dalle radici verso l’esterno: premi, muoviti veloce e solleva prima della fine del tratto.';

  @override
  String get ideasFlickingStep4 =>
      'Fai lo stesso con il pennarello scuro, solo dalle radici e più corto, dove le ciocche si sovrappongono.';

  @override
  String get ideasFlickingStep5 =>
      'Dai un colpo di polso con il pennarello chiaro dalle punte verso le radici per ammorbidire il cambio di tono.';

  @override
  String get ideasFlickingStep6 =>
      'Lascia una fascia del primo strato dove i capelli prendono la luce.';

  @override
  String get ideasGrayscaleTitle => 'Sfumature di grigio';

  @override
  String get ideasGrayscaleSummary =>
      'Disegna un oggetto semplice con una sola famiglia di grigi per vedere come luce e ombra costruiscono la forma.';

  @override
  String get ideasGrayscalePractice =>
      'Vedere luce e ombra come passi da chiaro a scuro.';

  @override
  String get ideasGrayscaleSubject =>
      'Una tazza, una mela o un uovo sotto una sola lampada.';

  @override
  String get ideasGrayscaleTip =>
      'Non mescolare grigi caldi e freddi nello stesso oggetto: scegli una famiglia.';

  @override
  String get ideasGrayscaleStep1 =>
      'Scegli un oggetto semplice e segna a matita da dove viene la luce.';

  @override
  String get ideasGrayscaleStep2 =>
      'Lascia la luce come carta bianca. Non colorarla mai.';

  @override
  String get ideasGrayscaleStep3 =>
      'Copri tutto l’oggetto con il grigio più chiaro e lascia asciugare.';

  @override
  String get ideasGrayscaleStep4 =>
      'Aggiungi il grigio successivo sul lato in ombra, sfumando il bordo mentre è ancora bagnato.';

  @override
  String get ideasGrayscaleStep5 =>
      'Ripeti con ogni grigio più scuro, coprendo ogni volta un’area più piccola.';

  @override
  String get ideasGrayscaleStep6 =>
      'Usa il grigio più scuro solo per l’ombra portata e la linea di contatto sotto l’oggetto.';

  @override
  String get ideasStickerEffectTitle => 'Effetto adesivo';

  @override
  String get ideasStickerEffectSummary =>
      'Fai sembrare un personaggio un adesivo ritagliato, con un bordo bianco carta e uno sfondo colorato.';

  @override
  String get ideasStickerEffectPractice =>
      'Mantenere apposta il bianco della carta.';

  @override
  String get ideasStickerEffectSubject =>
      'Un gatto, una fetta di pizza o una stella da fumetto.';

  @override
  String get ideasStickerEffectTip =>
      'Il bianco deve essere la carta. Il gel bianco sopra l’inchiostro dei pennarelli viene a macchie.';

  @override
  String get ideasStickerEffectStep1 =>
      'Disegna il soggetto, poi traccia a matita un secondo contorno 3–5 mm all’esterno: è il bordo dell’adesivo.';

  @override
  String get ideasStickerEffectStep2 =>
      'Colora il soggetto da chiaro a scuro senza toccare il bordo.';

  @override
  String get ideasStickerEffectStep3 =>
      'Colora lo sfondo attorno al bordo con un colore piatto, così il bordo bianco risalta.';

  @override
  String get ideasStickerEffectStep4 =>
      'Quando è asciutto, ripassa l’esterno del bordo con un liner nero o una brush pen.';

  @override
  String get ideasStickerEffectStep5 =>
      'Aggiungi un’ombra grigia lungo un lato del bordo per staccare l’adesivo dalla pagina.';

  @override
  String get ideasGlossyCherriesTitle => 'Ciliegie lucide';

  @override
  String get ideasGlossyCherriesSummary =>
      'Fai brillare due ciliegie con una luce lasciata in bianco e una luce riflessa.';

  @override
  String get ideasGlossyCherriesPractice =>
      'Luci nette e luce riflessa, le chiavi di una superficie lucida.';

  @override
  String get ideasGlossyCherriesSubject =>
      'Due ciliegie su un gambo, illuminate da un lato.';

  @override
  String get ideasGlossyCherriesTip =>
      'Le superfici lucide hanno luci dal bordo netto: non sfumarle, tieni il bordo preciso.';

  @override
  String get ideasGlossyCherriesStep1 =>
      'Disegna a matita le ciliegie e la forma di ogni luce: una forma a fagiolo netta vicino alla cima.';

  @override
  String get ideasGlossyCherriesStep2 =>
      'Copri ogni ciliegia con il pennarello chiaro, aggirando le luci perché restino carta bianca.';

  @override
  String get ideasGlossyCherriesStep3 =>
      'Aggiungi la base ovunque tranne una sottile mezzaluna lungo il bordo inferiore: è la luce riflessa.';

  @override
  String get ideasGlossyCherriesStep4 =>
      'Stendi l’ombra sul lato opposto alla luce e sfumala nella base mentre è bagnata.';

  @override
  String get ideasGlossyCherriesStep5 =>
      'Aggiungi il pennarello più scuro in una banda stretta tra l’ombra e la luce riflessa.';

  @override
  String get ideasGlossyCherriesStep6 =>
      'Disegna l’ombra sul tavolo con il grigio e, a secco, aggiungi un punto di gel bianco su ogni luce.';

  @override
  String get ideasColoredShadowsTitle => 'Ombre colorate';

  @override
  String get ideasColoredShadowsSummary =>
      'Ombreggia lo stesso limone due volte, una con il grigio e una con il viola, e confronta.';

  @override
  String get ideasColoredShadowsPractice =>
      'Scegliere colori d’ombra che tengano vivo il disegno.';

  @override
  String get ideasColoredShadowsSubject =>
      'Due limoni affiancati su un tavolo bianco.';

  @override
  String get ideasColoredShadowsTip =>
      'Un’ombra spesso tende all’opposto della luce: viola sotto il giallo, blu sotto l’arancione.';

  @override
  String get ideasColoredShadowsStep1 =>
      'Disegna due limoni identici affiancati, con la luce che arriva dallo stesso lato.';

  @override
  String get ideasColoredShadowsStep2 =>
      'Colora entrambi con il giallo, lasciando una piccola luce di carta bianca.';

  @override
  String get ideasColoredShadowsStep3 =>
      'Sul primo limone, ombreggia il lato scuro e l’ombra sul tavolo con il grigio.';

  @override
  String get ideasColoredShadowsStep4 =>
      'Sul secondo, fai lo stesso con il viola, con delicatezza: basta uno strato.';

  @override
  String get ideasColoredShadowsStep5 =>
      'Ripassa il bordo della seconda ombra con il giallo per fonderla.';

  @override
  String get ideasColoredShadowsStep6 =>
      'Guardali da lontano: l’ombra viola appare più viva e naturale accanto al giallo.';

  @override
  String get ideasStainedGlassTitle => 'Vetrata';

  @override
  String get ideasStainedGlassSummary =>
      'Colora i vetri con semplici sfumature e aggiungi le linee di piombo alla fine.';

  @override
  String get ideasStainedGlassPractice =>
      'Sfumature pulite in aree piccole; le linee nere nascondono i bordi irregolari.';

  @override
  String get ideasStainedGlassSubject =>
      'Una finestra rotonda con un fiore o un sole al centro.';

  @override
  String get ideasStainedGlassTip =>
      'Se disegni prima le linee nere, usa un inchiostro a pigmento che resista all’alcol: l’inchiostro normale sbava sotto il pennarello.';

  @override
  String get ideasStainedGlassStep1 =>
      'Disegna a matita la finestra e dividila in vetri di varie dimensioni.';

  @override
  String get ideasStainedGlassStep2 =>
      'Colora prima i vetri del colore principale, ognuno come sfumatura: più scuro a un bordo, più chiaro al centro.';

  @override
  String get ideasStainedGlassStep3 =>
      'Fai lo stesso con il secondo e il terzo colore, lasciando asciugare ogni vetro prima di colorare quello accanto.';

  @override
  String get ideasStainedGlassStep4 =>
      'Usa l’accento solo in pochi vetri piccoli, perché risaltino.';

  @override
  String get ideasStainedGlassStep5 =>
      'Quando è tutto asciutto, ripassa i bordi con linee spesse di liner nero o brush pen.';

  @override
  String get ideasStainedGlassStep6 =>
      'Aggiungi un piccolo tratto di gel bianco su alcuni vetri per suggerire la brillantezza.';

  @override
  String get ideasSwatchChartTitle => 'La tua cartella colori';

  @override
  String get ideasSwatchChartSummary =>
      'Prova come appare ogni pennarello con uno, due e tre strati.';

  @override
  String get ideasSwatchChartPractice =>
      'Sapere come appaiono davvero i tuoi pennarelli sulla carta, non sul tappo.';

  @override
  String get ideasSwatchChartSubject =>
      'Una griglia con una riga per pennarello, raggruppata per famiglia di colore.';

  @override
  String get ideasSwatchChartTip =>
      'Fai la cartella sulla carta che usi davvero: lo stesso pennarello cambia molto da una carta all’altra.';

  @override
  String get ideasSwatchChartStep1 =>
      'Disegna una griglia sulla carta che usi di solito: una riga per pennarello e quattro quadrati per riga.';

  @override
  String get ideasSwatchChartStep2 =>
      'Riempi il primo quadrato con uno strato, il secondo con due e il terzo con tre, lasciando asciugare ogni strato.';

  @override
  String get ideasSwatchChartStep3 =>
      'Nel quarto quadrato stendi uno strato e solleva parte dell’inchiostro con il blender incolore.';

  @override
  String get ideasSwatchChartStep4 =>
      'Scrivi il codice sotto ogni riga a matita o con un liner.';

  @override
  String get ideasSwatchChartStep5 =>
      'Usa la scheda Campioni per segnare i pennarelli che hai e confrontarli con la tua cartella.';

  @override
  String get ideasOneColorTitle => 'Una famiglia di colore';

  @override
  String get ideasOneColorSummary =>
      'Disegna un’intera scena con quattro pennarelli di una sola famiglia di colore.';

  @override
  String get ideasOneColorPractice =>
      'Costruire profondità con gli strati e con pennarelli più chiari e più scuri.';

  @override
  String get ideasOneColorSubject =>
      'Una tazza di tè fumante o una piantina in un vaso.';

  @override
  String get ideasOneColorTip =>
      'Premere leggero non rende un pennarello più chiaro. Per le zone chiare usa il pennarello più chiaro o il blender incolore.';

  @override
  String get ideasOneColorStep1 =>
      'Scegli un soggetto semplice e segna a matita da dove viene la luce.';

  @override
  String get ideasOneColorStep2 =>
      'Copri tutto tranne le luci con il pennarello più chiaro.';

  @override
  String get ideasOneColorStep3 =>
      'Aggiungi il pennarello base alle parti rivolte lontano dalla luce.';

  @override
  String get ideasOneColorStep4 =>
      'Metti il pennarello d’ombra nelle zone più scure e sfuma i bordi mentre sono bagnati.';

  @override
  String get ideasOneColorStep5 =>
      'Tieni il pennarello più scuro per le ombre di contatto e pochi piccoli dettagli.';

  @override
  String get ideasOneColorStep6 =>
      'Per scurire un tono senza cambiare pennarello, aggiungi un altro strato dello stesso quando il primo è asciutto.';

  @override
  String get ideasTwoMarkersTitle => 'Sfida dei due pennarelli';

  @override
  String get ideasTwoMarkersSummary =>
      'Solo un pennarello chiaro e uno scuro, nient’altro.';

  @override
  String get ideasTwoMarkersPractice =>
      'Decidere cosa resta chiaro e cosa diventa scuro prima di iniziare.';

  @override
  String get ideasTwoMarkersSubject =>
      'Un fungo, un gatto seduto o una casa con il tetto.';

  @override
  String get ideasTwoMarkersTip =>
      'Con solo due pennarelli il bianco della carta fa gran parte del lavoro: pianificalo dall’inizio.';

  @override
  String get ideasTwoMarkersStep1 =>
      'Fai prima un piccolo schizzo e decidi quali zone sono chiare e quali scure.';

  @override
  String get ideasTwoMarkersStep2 =>
      'Copri tutto tranne le luci con il pennarello chiaro.';

  @override
  String get ideasTwoMarkersStep3 =>
      'Aggiungi un secondo strato del pennarello chiaro sulle mezze ombre.';

  @override
  String get ideasTwoMarkersStep4 =>
      'Usa il pennarello scuro solo per le ombre più profonde e pochi dettagli.';

  @override
  String get ideasTwoMarkersStep5 =>
      'Lascia la carta bianca nei punti più luminosi: è il tuo terzo tono.';

  @override
  String get ideasTwoColorsTitle => 'Due colori opposti';

  @override
  String get ideasTwoColorsSummary =>
      'Usa due colori opposti e un grigio, e tienili separati.';

  @override
  String get ideasTwoColorsPractice =>
      'Gestire colori opposti, che diventano fangosi se si sovrappongono.';

  @override
  String get ideasTwoColorsSubject =>
      'Un’arancia su un panno blu o un fiore rosso con foglie verdi.';

  @override
  String get ideasTwoColorsTip =>
      'Due colori opposti sovrapposti diventano grigi o marroni. Usalo solo dove vuoi un’ombra spenta.';

  @override
  String get ideasTwoColorsStep1 =>
      'Decidi quali zone appartengono a ciascun colore e tienile come forme separate.';

  @override
  String get ideasTwoColorsStep2 =>
      'Colora le forme del primo colore, da chiaro a scuro.';

  @override
  String get ideasTwoColorsStep3 =>
      'Aggiungi la sua ombra mentre il primo strato è ancora umido.';

  @override
  String get ideasTwoColorsStep4 =>
      'Lascia asciugare del tutto, poi colora le forme del secondo colore, fermandoti al bordo.';

  @override
  String get ideasTwoColorsStep5 =>
      'Aggiungi l’ombra del secondo colore allo stesso modo.';

  @override
  String get ideasTwoColorsStep6 =>
      'Usa il grigio per le ombre che passano da un colore all’altro.';

  @override
  String get ideasFiftyFiftyTitle => 'Metà caldo, metà freddo';

  @override
  String get ideasFiftyFiftySummary =>
      'Dividi un disegno in due: colori caldi da un lato, freddi dall’altro.';

  @override
  String get ideasFiftyFiftyPractice =>
      'Vedere come i colori caldi e freddi cambiano l’atmosfera dello stesso soggetto.';

  @override
  String get ideasFiftyFiftySubject => 'Un volto o una casa divisi a metà.';

  @override
  String get ideasFiftyFiftyTip =>
      'I bordi bagnati si mescolano: non lasciare mai che una zona calda bagnata tocchi una fredda bagnata.';

  @override
  String get ideasFiftyFiftyStep1 =>
      'Disegna il soggetto e una linea che lo divide in due.';

  @override
  String get ideasFiftyFiftyStep2 =>
      'Colora prima la metà calda, da chiaro a scuro.';

  @override
  String get ideasFiftyFiftyStep3 =>
      'Aggiungi le sue ombre e lascia asciugare del tutto quella metà.';

  @override
  String get ideasFiftyFiftyStep4 =>
      'Colora la metà fredda, fermandoti un millimetro prima della linea, e chiudi lo spazio quando l’altro lato è asciutto.';

  @override
  String get ideasFiftyFiftyStep5 =>
      'Aggiungi le ombre fredde negli stessi punti della metà calda.';

  @override
  String get ideasFiftyFiftyStep6 =>
      'Usa il grigio solo nei punti più scuri, così lo condividono entrambe le metà.';

  @override
  String get ideasRandomColorsTitle => 'Cinque pennarelli a caso';

  @override
  String get ideasRandomColorsSummary =>
      'Disegna quello che vuoi con cinque pennarelli scelti a caso dalla tua collezione.';

  @override
  String get ideasRandomColorsPractice =>
      'Far funzionare insieme qualsiasi colore controllando chiari e scuri.';

  @override
  String get ideasRandomColorsSubject =>
      'Quello che preferisci: un uccello, una teiera o un mostro.';

  @override
  String get ideasRandomColorsTip =>
      'Chiaro e scuro contano più del colore: un disegno con un contrasto chiaro funziona con quasi tutti i colori.';

  @override
  String get ideasRandomColorsStep1 =>
      'Guarda i cinque pennarelli qui sopra: sono ordinati dal più chiaro al più scuro.';

  @override
  String get ideasRandomColorsStep2 =>
      'Usa il più chiaro per le grandi zone illuminate.';

  @override
  String get ideasRandomColorsStep3 =>
      'Usa quelli di mezzo per le forme principali.';

  @override
  String get ideasRandomColorsStep4 =>
      'Tieni il più scuro per ombre e contorni.';

  @override
  String get ideasRandomColorsStep5 =>
      'Se due colori stonano, separali con una sottile linea di carta bianca.';

  @override
  String get ideasRandomColorsStep6 =>
      'Tocca Altri pennarelli per una nuova estrazione e riprova.';

  @override
  String get ideasUnlikelyColorsTitle => 'Colori inattesi';

  @override
  String get ideasUnlikelyColorsSummary =>
      'Colora un oggetto familiare con colori che non sono i suoi.';

  @override
  String get ideasUnlikelyColorsPractice =>
      'Mantenere giusti chiari e scuri perché l’oggetto si riconosca, qualunque sia il colore.';

  @override
  String get ideasUnlikelyColorsSubject =>
      'Una banana, un cane o la tua scarpa da ginnastica.';

  @override
  String get ideasUnlikelyColorsTip =>
      'Se strizzi gli occhi e il disegno si legge ancora, chiari e scuri sono giusti, qualunque sia il colore.';

  @override
  String get ideasUnlikelyColorsStep1 =>
      'Disegna l’oggetto dal vero o da una foto e nota dove sono le sue zone chiare e scure.';

  @override
  String get ideasUnlikelyColorsStep2 =>
      'Usa il pennarello più chiaro dove l’oggetto reale è più chiaro.';

  @override
  String get ideasUnlikelyColorsStep3 =>
      'Usa la base dove l’oggetto reale ha i mezzi toni.';

  @override
  String get ideasUnlikelyColorsStep4 =>
      'Usa il pennarello d’ombra dove l’oggetto reale è più scuro.';

  @override
  String get ideasUnlikelyColorsStep5 =>
      'Aggiungi l’accento in una piccola zona per catturare lo sguardo.';

  @override
  String get ideasPastelTitle => 'Pastelli delicati';

  @override
  String get ideasPastelSummary =>
      'Colora un disegno morbido e leggero con pennarelli chiari e molta carta bianca.';

  @override
  String get ideasPastelPractice =>
      'Strati leggeri e uniformi e mantenere il bianco della carta.';

  @override
  String get ideasPastelSubject =>
      'Un cupcake, un coniglietto o un mazzo di fiori.';

  @override
  String get ideasPastelTip =>
      'Premere leggero non rende un pennarello più chiaro: scegli piuttosto un pennarello più chiaro.';

  @override
  String get ideasPastelStep1 =>
      'Scegli un soggetto delicato e tieni le linee a matita molto leggere.';

  @override
  String get ideasPastelStep2 =>
      'Decidi dove la carta resta bianca: le luci e parte dello sfondo.';

  @override
  String get ideasPastelStep3 =>
      'Colora ogni zona con un pennarello chiaro in un unico strato uniforme, a piccoli cerchi.';

  @override
  String get ideasPastelStep4 =>
      'Fai l’ombra con un secondo strato dello stesso pennarello, non con un colore più scuro.';

  @override
  String get ideasPastelStep5 =>
      'Usa il pennarello appena più intenso solo per le ombre più piccole.';

  @override
  String get ideasPastelStep6 =>
      'Ammorbidisci ogni bordo netto con il blender incolore.';

  @override
  String get ideasSkinTonesTitle => 'Pelle con quattro pennarelli';

  @override
  String get ideasSkinTonesSummary =>
      'Colora un volto con un tono chiaro, una base, un’ombra e un tocco di rosa.';

  @override
  String get ideasSkinTonesPractice =>
      'Sfumature morbide della pelle e ombre calde su un volto.';

  @override
  String get ideasSkinTonesSubject =>
      'Un volto di tre quarti, illuminato da un lato.';

  @override
  String get ideasSkinTonesTip =>
      'Le ombre della pelle sono calde: evita i grigi, sporcano il volto.';

  @override
  String get ideasSkinTonesStep1 =>
      'Disegna il volto con tratto leggero e segna le forme delle ombre: sotto il sopracciglio, accanto al naso, sotto il labbro e lungo la mandibola.';

  @override
  String get ideasSkinTonesStep2 =>
      'Copri tutta la pelle con il pennarello chiaro, lasciando come carta bianca i punti più luminosi di fronte, naso e guancia.';

  @override
  String get ideasSkinTonesStep3 =>
      'Mentre è umido, aggiungi il rosa sulle guance, sulla punta del naso e sulle orecchie.';

  @override
  String get ideasSkinTonesStep4 =>
      'Metti la base sulle forme d’ombra e sfuma i loro bordi con il pennarello chiaro.';

  @override
  String get ideasSkinTonesStep5 =>
      'Usa il pennarello d’ombra solo dove le forme si incontrano: sotto il mento, dentro l’orecchio e attorno alle narici.';

  @override
  String get ideasSkinTonesStep6 =>
      'Ammorbidisci ogni linea netta con il pennarello chiaro anziché con il blender incolore, così la pelle non diventa macchiata.';

  @override
  String get ideasMidnightTitle => 'Notte di luna';

  @override
  String get ideasMidnightSummary =>
      'Una casetta di notte, illuminata dalla luna e da una finestra calda.';

  @override
  String get ideasMidnightPractice =>
      'Pianificare una scena notturna: ombre fredde e poche luci calde e pulite.';

  @override
  String get ideasMidnightSubject =>
      'Una casetta di notte con una finestra illuminata.';

  @override
  String get ideasMidnightTip =>
      'Non far toccare il blu e il giallo finché uno dei due è bagnato: insieme diventano verdi.';

  @override
  String get ideasMidnightStep1 =>
      'Prima di iniziare, decidi dove sono le luci: la luna e la finestra restano carta bianca.';

  @override
  String get ideasMidnightStep2 =>
      'Colora la finestra e un morbido alone attorno con il giallo, e lascia asciugare del tutto.';

  @override
  String get ideasMidnightStep3 =>
      'Copri il cielo e i muri illuminati con il blu chiaro, lavorando lontano dalla luna.';

  @override
  String get ideasMidnightStep4 =>
      'Aggiungi il blu base a tutto ciò che è in ombra, a pochi millimetri dall’alone giallo.';

  @override
  String get ideasMidnightStep5 =>
      'Scurisci il cielo verso l’alto e le ombre sotto il tetto e gli alberi.';

  @override
  String get ideasMidnightStep6 =>
      'Usa il pennarello più scuro per le ombre più profonde e, a secco, aggiungi qualche stella con il gel bianco.';

  @override
  String get ideasUnderwaterTitle => 'Sott’acqua';

  @override
  String get ideasUnderwaterSummary =>
      'Raggi di sole in acqua blu attorno a un pesciolino.';

  @override
  String get ideasUnderwaterPractice =>
      'Sollevare raggi di luce con il blender incolore.';

  @override
  String get ideasUnderwaterSubject =>
      'Un pesciolino che nuota sopra un corallo.';

  @override
  String get ideasUnderwaterTip =>
      'Prova prima i raggi con il blender su un foglio di scarto: funzionano solo finché l’inchiostro è ancora leggermente umido.';

  @override
  String get ideasUnderwaterStep1 =>
      'Colora per primi il pesce e il corallo con l’accento e lasciali asciugare.';

  @override
  String get ideasUnderwaterStep2 =>
      'Copri l’acqua con il blu chiaro, fermandoti poco prima del pesce.';

  @override
  String get ideasUnderwaterStep3 =>
      'Aggiungi il blu base nella metà inferiore e sfumalo verso l’alto mentre è bagnato.';

  @override
  String get ideasUnderwaterStep4 =>
      'Scurisci il fondo e la zona dietro il pesce perché risalti.';

  @override
  String get ideasUnderwaterStep5 =>
      'Mentre i blu sono ancora umidi, tira dei raggi diagonali dalla superficie con il blender incolore: spinge via l’inchiostro.';

  @override
  String get ideasUnderwaterStep6 =>
      'Aggiungi il pennarello più scuro proprio sul fondo e, a secco, finisci con minuscole bolle di gel bianco.';

  @override
  String get ideasGalaxyTitle => 'Galassia';

  @override
  String get ideasGalaxySummary =>
      'Sfuma i colori luminosi di una nebulosa in un cielo scuro e finisci con le stelle.';

  @override
  String get ideasGalaxyPractice =>
      'Sfumare bagnato su bagnato e sollevare l’inchiostro per fare le stelle.';

  @override
  String get ideasGalaxySubject =>
      'Una nebulosa sopra la sagoma di una montagna.';

  @override
  String get ideasGalaxyTip =>
      'Tieni le stelle grandi a una manciata: troppe appiattiscono la profondità.';

  @override
  String get ideasGalaxyStep1 =>
      'Usa carta per pennarelli che non trapassi e metti un foglio sotto: questo esercizio consuma molto inchiostro.';

  @override
  String get ideasGalaxyStep2 =>
      'Inizia con i colori più chiari della nebulosa in nuvole morbide e irregolari.';

  @override
  String get ideasGalaxyStep3 =>
      'Mentre sono ancora bagnati, sfuma il colore di mezzo nei loro bordi.';

  @override
  String get ideasGalaxyStep4 =>
      'Riempi il resto del cielo con i pennarelli più scuri, lavorando verso le nuvole, non sopra.';

  @override
  String get ideasGalaxyStep5 =>
      'Tampona il blender incolore sulle zone scure per sollevare puntini di inchiostro: saranno stelle lontane.';

  @override
  String get ideasGalaxyStep6 =>
      'A secco, aggiungi alcune stelle brillanti e uno scintillio a croce con il gel bianco.';

  @override
  String get ideasNeonTitle => 'Insegna al neon';

  @override
  String get ideasNeonSummary =>
      'Fai brillare un’insegna con un nucleo bianco e uno sfondo scuro.';

  @override
  String get ideasNeonPractice =>
      'Il bagliore: un nucleo bianco, un alone luminoso e uno sfondo scuro.';

  @override
  String get ideasNeonSubject =>
      'La parola OPEN o un cuore disegnato come un tubo al neon.';

  @override
  String get ideasNeonTip =>
      'I pennarelli fluo sono trasparenti: usali sul bianco, mai sopra l’inchiostro scuro.';

  @override
  String get ideasNeonStep1 =>
      'Disegna a matita una parola o una forma semplice con tratti spessi.';

  @override
  String get ideasNeonStep2 =>
      'Lascia una sottile linea di carta bianca al centro di ogni tratto: è il nucleo incandescente.';

  @override
  String get ideasNeonStep3 =>
      'Colora il resto del tratto con la versione chiara del tuo colore neon.';

  @override
  String get ideasNeonStep4 =>
      'Dai un colpo di polso con il colore vivo verso l’esterno del tratto per fare un alone morbido.';

  @override
  String get ideasNeonStep5 =>
      'Quando l’alone è asciutto, riempi lo sfondo con il pennarello più scuro, fermandoti a pochi millimetri dall’alone.';

  @override
  String get ideasNeonStep6 =>
      'Sfuma quello spazio con il pennarello scuro perché il bagliore svanisca nella notte.';

  @override
  String get ideasSepiaPhotoTitle => 'Vecchia foto seppia';

  @override
  String get ideasSepiaPhotoSummary =>
      'Disegna un ritratto o un edificio come se fosse una vecchia fotografia marrone.';

  @override
  String get ideasSepiaPhotoPractice =>
      'Lavorare con una sola famiglia calda di marroni, come uno studio di chiari e scuri a colori.';

  @override
  String get ideasSepiaPhotoSubject =>
      'Una vecchia casa, un cappello da cowboy o il ritratto di un nonno.';

  @override
  String get ideasSepiaPhotoTip =>
      'Evita il nero e i grigi freddi: rovinano l’effetto seppia caldo.';

  @override
  String get ideasSepiaPhotoStep1 =>
      'Disegna a matita il soggetto e cornicialo con un bordo che resta carta bianca.';

  @override
  String get ideasSepiaPhotoStep2 =>
      'Copri tutto tranne i punti più luminosi con il marrone più chiaro.';

  @override
  String get ideasSepiaPhotoStep3 =>
      'Costruisci i mezzi toni con il marrone base.';

  @override
  String get ideasSepiaPhotoStep4 =>
      'Aggiungi le ombre con il marrone d’ombra, sfumando i bordi mentre sono bagnati.';

  @override
  String get ideasSepiaPhotoStep5 =>
      'Usa il marrone più scuro al posto del nero per le ombre più profonde.';

  @override
  String get ideasSepiaPhotoStep6 =>
      'Scurisci leggermente gli angoli dell’immagine con il grigio caldo per farla sembrare vecchia.';

  @override
  String get ideasSunsetTitle => 'Cielo al tramonto';

  @override
  String get ideasSunsetSummary =>
      'Sfuma un cielo dal giallo al viola e aggiungi una sagoma scura.';

  @override
  String get ideasSunsetPractice =>
      'Sfumare colori vicini bagnato su bagnato su un’area ampia.';

  @override
  String get ideasSunsetSubject =>
      'Un tramonto sul mare con una palma o uno skyline in sagoma.';

  @override
  String get ideasSunsetTip =>
      'Sfuma solo colori vicini: il giallo accanto al viola diventa brunastro quando è bagnato.';

  @override
  String get ideasSunsetStep1 =>
      'Disegna a matita l’orizzonte e la sagoma; lascia il sole come un cerchio di carta bianca.';

  @override
  String get ideasSunsetStep2 =>
      'Parti dal sole: colora attorno a esso una larga fascia di giallo.';

  @override
  String get ideasSunsetStep3 =>
      'Mentre il giallo è bagnato, aggiungi sopra l’arancione e sfuma l’unione.';

  @override
  String get ideasSunsetStep4 =>
      'Prosegui verso l’alto con il rosa, sfumando ogni fascia nella precedente mentre è bagnata.';

  @override
  String get ideasSunsetStep5 =>
      'Finisci la parte alta del cielo con il viola.';

  @override
  String get ideasSunsetStep6 =>
      'Quando il cielo è asciutto, riempi la sagoma con il pennarello più scuro a tratti piatti e uniformi.';

  @override
  String get ideasSpringTitle => 'Fiori di primavera';

  @override
  String get ideasSpringSummary =>
      'Un ramo di ciliegio in fiore con morbidi petali rosa.';

  @override
  String get ideasSpringPractice =>
      'Petali delicati: strati leggeri e bordi morbidi.';

  @override
  String get ideasSpringSubject =>
      'Un ramo con cinque o sei fiori e qualche foglia.';

  @override
  String get ideasSpringTip =>
      'I petali sono sottili: due strati leggeri sembrano più delicati di uno scuro.';

  @override
  String get ideasSpringStep1 =>
      'Disegna il ramo e i fiori con tratto leggero, con cinque petali ciascuno.';

  @override
  String get ideasSpringStep2 =>
      'Colora ogni petalo con il rosa chiaro, lasciando un sottile bordo bianco su alcuni.';

  @override
  String get ideasSpringStep3 =>
      'Aggiungi il rosa base vicino al centro di ogni fiore, con un colpo di polso verso l’esterno.';

  @override
  String get ideasSpringStep4 =>
      'Tocca il rosa più intenso solo al centro e dove i petali si sovrappongono.';

  @override
  String get ideasSpringStep5 => 'Colora le foglie e i germogli con il verde.';

  @override
  String get ideasSpringStep6 =>
      'Ombreggia la parte inferiore delle foglie con il verde scuro.';

  @override
  String get ideasAutumnTitle => 'Foglie d’autunno';

  @override
  String get ideasAutumnSummary =>
      'Una natura morta di foglie cadute in colori caldi e luminosi.';

  @override
  String get ideasAutumnPractice =>
      'Sfumare colori caldi vicini e mantenere chiare le nervature.';

  @override
  String get ideasAutumnSubject =>
      'Tre foglie cadute su un tavolo: quercia, acero e castagno.';

  @override
  String get ideasAutumnTip =>
      'Lascia le nervature come linea più chiara: è più facile che disegnarle sopra dopo.';

  @override
  String get ideasAutumnStep1 =>
      'Disegna le foglie e le loro nervature principali a matita leggera.';

  @override
  String get ideasAutumnStep2 =>
      'Colora la foglia più chiara con il giallo, aggirando le nervature perché restino chiare.';

  @override
  String get ideasAutumnStep3 =>
      'Colora la foglia successiva con l’arancione chiaro e sfuma un po’ di giallo sui suoi bordi mentre è bagnata.';

  @override
  String get ideasAutumnStep4 =>
      'Colora la terza foglia con la base e sfuma l’arancione chiaro sulla punta.';

  @override
  String get ideasAutumnStep5 =>
      'Aggiungi il rosso lungo i bordi e in qualche macchia, come se la foglia stesse cambiando colore.';

  @override
  String get ideasAutumnStep6 =>
      'Ombreggia con l’arancione scuro dove le foglie si sovrappongono e dove toccano il tavolo.';

  @override
  String get ideasWinterTitle => 'Baita nella neve';

  @override
  String get ideasWinterSummary =>
      'Una baita nella neve dove il bianco è la carta stessa.';

  @override
  String get ideasWinterPractice =>
      'Disegnare la neve con ombre grigio-azzurre e molta carta bianca.';

  @override
  String get ideasWinterSubject =>
      'Una baita di legno con neve sul tetto e una finestra illuminata.';

  @override
  String get ideasWinterTip =>
      'Non ombreggiare la neve con un grigio caldo: i grigio-azzurri la fanno sembrare fredda e pulita.';

  @override
  String get ideasWinterStep1 =>
      'Disegna a matita la baita e dove finisce la neve: la neve è carta bianca, quindi pianificala prima.';

  @override
  String get ideasWinterStep2 =>
      'Colora la finestra con il giallo e lascia asciugare.';

  @override
  String get ideasWinterStep3 =>
      'Colora le pareti di legno con il marrone senza toccare la neve sul tetto.';

  @override
  String get ideasWinterStep4 =>
      'Ombreggia la neve con il grigio-azzurro chiaro solo dove la luce non arriva.';

  @override
  String get ideasWinterStep5 =>
      'Aggiungi il grigio-azzurro più scuro sotto il tetto e nelle impronte, sfumandolo in quello chiaro.';

  @override
  String get ideasWinterStep6 =>
      'Usa il pennarello più scuro per la porta e le ombre più profonde e, a secco, aggiungi la neve che cade con il gel bianco.';

  @override
  String get ideasChristmasTitle => 'Palline di Natale';

  @override
  String get ideasChristmasSummary =>
      'Lucide palline rosse appese a un ramo di abete verde.';

  @override
  String get ideasChristmasPractice =>
      'Forme tonde e lucide con una luce lasciata in bianco e riflessi.';

  @override
  String get ideasChristmasSubject =>
      'Due palline rosse appese a un ramo di abete.';

  @override
  String get ideasChristmasTip =>
      'Disegna il ramo dopo le palline, così il verde non invade mai il rosso.';

  @override
  String get ideasChristmasStep1 =>
      'Disegna le palline e pianifica su ognuna una luce a forma di finestra.';

  @override
  String get ideasChristmasStep2 =>
      'Copri ogni pallina con il rosso chiaro, aggirando la luce.';

  @override
  String get ideasChristmasStep3 =>
      'Aggiungi il rosso base in un anello che segue la forma tonda, lasciando il centro più chiaro.';

  @override
  String get ideasChristmasStep4 =>
      'Scurisci il bordo più lontano dalla luce, mantenendo un sottile orlo più chiaro per il riflesso.';

  @override
  String get ideasChristmasStep5 =>
      'Dai colpi di polso con il verde per gli aghi del ramo, dal fusto verso l’esterno.';

  @override
  String get ideasChristmasStep6 =>
      'Aggiungi il verde scuro dove gli aghi si sovrappongono e, a secco, un luccichio di gel bianco su ogni pallina.';

  @override
  String get ideasHalloweenTitle => 'Zucca di Halloween';

  @override
  String get ideasHalloweenSummary =>
      'Una zucca intagliata luminosa in una notte viola scuro.';

  @override
  String get ideasHalloweenPractice =>
      'La luce che viene dall’interno di un oggetto, contro uno sfondo scuro.';

  @override
  String get ideasHalloweenSubject =>
      'Una zucca intagliata con una candela dentro, sulla soglia di casa.';

  @override
  String get ideasHalloweenTip =>
      'Stendi lo sfondo scuro per ultimo e piano vicino al bordo: l’inchiostro scuro invade le zone chiare.';

  @override
  String get ideasHalloweenStep1 =>
      'Disegna la zucca e il suo volto intagliato; l’interno del volto sarà la parte più luminosa.';

  @override
  String get ideasHalloweenStep2 =>
      'Colora i buchi dell’intaglio con l’arancione chiaro, lasciando un nucleo bianco al centro.';

  @override
  String get ideasHalloweenStep3 =>
      'Colora la zucca con l’arancione base, seguendo le sue coste con tratti curvi.';

  @override
  String get ideasHalloweenStep4 =>
      'Ombreggia i solchi tra le coste e il lato lontano dal bagliore.';

  @override
  String get ideasHalloweenStep5 => 'Colora il picciolo con il verde.';

  @override
  String get ideasHalloweenStep6 =>
      'Quando è tutto asciutto, riempi la notte con il viola scuro, partendo a pochi millimetri dalla zucca.';

  @override
  String get ideasRoleLight => 'Chiaro';

  @override
  String get ideasReasonLight => 'Primo strato, su quasi tutto';

  @override
  String get ideasRoleLightMid => 'Medio chiaro';

  @override
  String get ideasReasonLightMid =>
      'Secondo passo, ammorbidisce il salto verso la base';

  @override
  String get ideasRoleBase => 'Base';

  @override
  String get ideasReasonBase => 'Colore principale delle forme';

  @override
  String get ideasRoleShadow => 'Ombra';

  @override
  String get ideasReasonShadow => 'Dove la luce non arriva';

  @override
  String get ideasRoleDeepShadow => 'Ombra profonda';

  @override
  String get ideasReasonDeepShadow =>
      'Solo gli angoli più scuri e le linee di contatto';

  @override
  String get ideasRoleShadowGray => 'Grigio d’ombra';

  @override
  String get ideasReasonShadowGray => 'Ombre neutre e ombre portate';

  @override
  String get ideasRoleAccent => 'Accento';

  @override
  String get ideasReasonAccent => 'Piccoli tocchi che attirano lo sguardo';

  @override
  String get ideasRoleBackground => 'Sfondo';

  @override
  String get ideasReasonBackground => 'Attorno al soggetto, steso per ultimo';

  @override
  String get ideasRoleMainColor => 'Colore principale';

  @override
  String get ideasReasonMainColor => 'Primo colore della coppia';

  @override
  String get ideasRoleMainShadow => 'Ombra principale';

  @override
  String get ideasReasonMainShadow => 'Ombra del primo colore';

  @override
  String get ideasRoleSecondColor => 'Secondo colore';

  @override
  String get ideasReasonSecondColor => 'Secondo colore dello schema';

  @override
  String get ideasRoleSecondShadow => 'Seconda ombra';

  @override
  String get ideasReasonSecondShadow => 'Ombra del secondo colore';

  @override
  String get ideasRoleThirdColor => 'Terzo colore';

  @override
  String get ideasReasonThirdColor => 'Terzo colore dello schema';

  @override
  String get ideasRoleBlush => 'Rosa';

  @override
  String get ideasReasonBlush => 'Guance, naso e orecchie, sfumati da bagnati';

  @override
  String get ideasRoleWarmLight => 'Luce calda';

  @override
  String get ideasReasonWarmLight => 'Zone illuminate della metà calda';

  @override
  String get ideasRoleWarmShadow => 'Ombra calda';

  @override
  String get ideasReasonWarmShadow => 'Ombre della metà calda';

  @override
  String get ideasRoleCoolLight => 'Luce fredda';

  @override
  String get ideasReasonCoolLight => 'Zone illuminate della metà fredda';

  @override
  String get ideasRoleCoolShadow => 'Ombra fredda';

  @override
  String get ideasReasonCoolShadow => 'Ombre della metà fredda';

  @override
  String get ideasRoleColorShadow => 'Ombra colorata';

  @override
  String get ideasReasonColorShadow =>
      'Un’ombra colorata da confrontare con quella grigia';

  @override
  String get matchTitle => 'Abbina';

  @override
  String get matchPrivacyCaption => 'Le foto restano su questo telefono.';

  @override
  String get matchCameraButton => 'Camera';

  @override
  String get matchGalleryButton => 'Galleria';

  @override
  String get matchLoadingPhoto => 'Lettura della foto…';

  @override
  String get matchEmptyPhotoTitle => 'Trova un colore da una foto';

  @override
  String get matchEmptyPhotoMessage =>
      'Scatta una foto, tocca un colore e guarda i pennarelli più vicini.';

  @override
  String get matchPhotoSemantics => 'Foto da cui campionare un colore';

  @override
  String get matchPickToSample =>
      'Tocca o trascina sulla foto per campionare un colore.';

  @override
  String get matchSampledLabel => 'Campionato';

  @override
  String get matchBestMatchTitle => 'Miglior abbinamento';

  @override
  String get matchAlternatesTitle => 'Alternative';

  @override
  String get matchSaveButton => 'Salva';

  @override
  String get matchRecentTitle => 'Scelte recenti';

  @override
  String get matchRecentDetailSampled => 'Campionato';

  @override
  String get matchRecentEmpty =>
      'Ancora nessuna scelta recente. Tocca un abbinamento per salvarlo qui.';

  @override
  String get matchClearButton => 'Cancella';

  @override
  String get matchRemoveTooltip => 'Rimuovi';

  @override
  String get matchCloseTooltip => 'Chiudi';

  @override
  String get matchRecentPickLabel => 'Scelta recente';

  @override
  String get matchClearDialogTitle => 'Cancellare le scelte recenti?';

  @override
  String get matchClearDialogBody =>
      'Tutte le scelte salvate vengono rimosse. Non si può annullare.';

  @override
  String get matchCancelButton => 'Annulla';

  @override
  String get matchCancelNotice => 'Nessuna foto selezionata.';

  @override
  String get matchCameraDenied =>
      'L’accesso alla fotocamera è disattivato. Consentilo nelle impostazioni del dispositivo, oppure scegli una foto dalla galleria.';

  @override
  String get matchGalleryDenied =>
      'L’accesso alle foto è disattivato. Consentilo nelle impostazioni del dispositivo, poi riprova.';

  @override
  String get matchDecodeFailed =>
      'Non è stato possibile leggere quella foto. Provane un’altra.';

  @override
  String get matchPickFailed =>
      'Non è stato possibile aprire la foto. Riprova.';

  @override
  String get matchOkButton => 'OK';

  @override
  String get matchTakePhotoButton => 'Scatta una foto';

  @override
  String get matchChooseGalleryButton => 'Scegli dalla galleria';

  @override
  String get matchValuesButton => 'Valori';

  @override
  String get matchValuesTooltip =>
      'Mostra la foto e gli abbinamenti in scala di grigi per controllare il contrasto dei valori';

  @override
  String get matchPhotoSampleHint =>
      'Tocca due volte per campionare il centro della foto. Usa le azioni per spostare il punto.';

  @override
  String get matchSampleMiddle => 'Campiona il centro della foto';

  @override
  String get matchMoveLeft => 'Sposta il punto a sinistra';

  @override
  String get matchMoveRight => 'Sposta il punto a destra';

  @override
  String get matchMoveUp => 'Sposta il punto in alto';

  @override
  String get matchMoveDown => 'Sposta il punto in basso';

  @override
  String matchSampleSpoken(
    String hex,
    String code,
    String name,
    String quality,
  ) {
    return 'Colore campionato $hex. Pennarello più vicino: $code, $name, $quality.';
  }

  @override
  String matchSampleSpokenNone(String hex) {
    return 'Colore campionato $hex.';
  }

  @override
  String get appTitle => 'Ink Lab';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOwned => 'Posseduto';

  @override
  String get commonFavourite => 'Preferito';

  @override
  String get commonAddToFavourites => 'Aggiungi ai preferiti';

  @override
  String get commonRemoveFromFavourites => 'Rimuovi dai preferiti';

  @override
  String get commonClearSearch => 'Cancella la ricerca';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonMoreActions => 'Altre azioni';

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
  String get commonBaseLocked => 'Base bloccata';

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
    return 'Vecchio $code';
  }

  @override
  String commonMarkersAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli disponibili',
      one: '1 pennarello disponibile',
    );
    return '$_temp0';
  }

  @override
  String commonColorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colori',
      one: '1 colore',
    );
    return '$_temp0';
  }

  @override
  String commonCardLocation(int number) {
    return 'Cartella colori $number';
  }

  @override
  String navTabHint(int index, int count) {
    return 'Scheda $index di $count';
  }

  @override
  String get settingsLanguageTitle => 'Lingua';

  @override
  String get settingsLanguageSystem => 'Sistema';

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
    return '$owned di $total pennarelli';
  }

  @override
  String settingsPacksSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count set selezionati',
      one: '1 set selezionato',
    );
    return '$_temp0';
  }

  @override
  String settingsImportUnsupportedVersion(int version) {
    return 'Questo backup ha una versione non supportata: $version.';
  }

  @override
  String settingsImportFailed(String reason) {
    return 'Non è stato possibile importare il backup: $reason';
  }

  @override
  String settingsAiOnDeviceProgressTotal(
    String bytes,
    String total,
    int percent,
  ) {
    return '$bytes di $total MB scaricati ($percent%)';
  }

  @override
  String settingsAiOnDeviceProgressBytes(String bytes) {
    return '$bytes MB scaricati';
  }

  @override
  String settingsAiConnectionOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modelli disponibili',
      one: '1 modello disponibile',
    );
    return 'Connessione OK ($_temp0).';
  }

  @override
  String settingsAiConnectionFailed(String reason) {
    return 'Connessione non riuscita: $reason';
  }

  @override
  String settingsAiFallbacksCount(int count, int max) {
    return '$count di $max';
  }

  @override
  String settingsAiUseTyped(String id) {
    return 'Usa «$id»';
  }

  @override
  String settingsAiFallbacksHint(int max) {
    return 'Provati in ordine quando il modello qui sopra fallisce (fino a $max).';
  }

  @override
  String get settingsAiOnDeviceUnavailable =>
      'L’IA sul dispositivo al momento non è disponibile su questo telefono. Si usa la teoria del colore finché non lo sarà.';

  @override
  String get settingsAiOnDeviceNotEnabledIos =>
      'Per usare l’IA sul dispositivo, attiva Apple Intelligence in Impostazioni → Apple Intelligence e Siri.';

  @override
  String paletteSizeChip(int size) {
    return '$size colori';
  }

  @override
  String paletteAiLabel(String name) {
    return 'IA · $name';
  }

  @override
  String paletteAiLabelPartial(String name, int aiCount, int total) {
    return 'IA + teoria del colore · $name · $aiCount/$total';
  }

  @override
  String paletteResultTitle(int count) {
    return 'Combinazioni ($count)';
  }

  @override
  String paletteSavedSubtitle(String mode, int size) {
    return '$mode · $size colori';
  }

  @override
  String paletteSubtitleCustom(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli',
      one: '1 pennarello',
    );
    return 'Palette personalizzata · $_temp0';
  }

  @override
  String paletteSavedNotice(String name) {
    return 'Palette «$name» salvata.';
  }

  @override
  String paletteLoadedNotice(String name) {
    return 'Palette «$name» caricata.';
  }

  @override
  String paletteVariationApplied(String label) {
    return 'Variante $label applicata.';
  }

  @override
  String paletteDraftApplied(int count) {
    return 'Palette di Idee applicata ($count colori).';
  }

  @override
  String paletteUsingDefaultBase(String code, String scenario) {
    return 'Uso $code come base predefinita per $scenario. Inserisci un codice per cambiarla.';
  }

  @override
  String paletteUnknownCode(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input non è un codice di pennarello DecoTime. Prova $example.',
      'copic': '$input non è un codice di pennarello Copic. Prova $example.',
      'finecolour':
          '$input non è un codice di pennarello Finecolour. Prova $example.',
      'touchTwin':
          '$input non è un codice di pennarello Touch Twin. Prova $example.',
      'promarker':
          '$input non è un codice di pennarello Promarker. Prova $example.',
      'prismacolor':
          '$input non è un codice di pennarello Prismacolor Premier. Prova $example.',
      'spectrumNoir':
          '$input non è un codice di pennarello Spectrum Noir. Prova $example.',
      'promarkerBrush':
          '$input non è un codice di pennarello Promarker Brush. Prova $example.',
      'arrtx': '$input non è un codice di pennarello Arrtx. Prova $example.',
      'kurecolor':
          '$input non è un codice di pennarello ZIG Kurecolor. Prova $example.',
      'graphit':
          '$input non è un codice di pennarello Graph\'it. Prova $example.',
      'marvyLePlume':
          '$input non è un codice di pennarello Marvy Le Plume. Prova $example.',
      'blickBrush':
          '$input non è un codice di pennarello Blick Studio Brush. Prova $example.',
      'artistsLoft':
          '$input non è un codice di pennarello Artist\'s Loft. Prova $example.',
      'other': '$input non è un codice di pennarello Ink Lab. Prova $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input non è nella tua collezione. Prova $example o aggiungilo in La mia collezione.',
      'copic':
          '$input non è nella tua collezione. Prova $example o aggiungilo in La mia collezione.',
      'finecolour':
          '$input non è nella tua collezione. Prova $example o aggiungilo in La mia collezione.',
      'other':
          '$input non è nella tua collezione. Prova $example o aggiungilo in La mia collezione.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'Non hai ancora pennarelli DecoTime nella tua collezione. Aggiungili in La mia collezione.',
      'copic': 'Non hai ancora pennarelli Copic nella tua collezione. Aggiungili in La mia collezione.',
      'finecolour': 'Non hai ancora pennarelli Finecolour nella tua collezione. Aggiungili in La mia collezione.',
      'touchTwin': 'Non hai ancora pennarelli Touch Twin nella tua collezione. Aggiungili in La mia collezione.',
      'promarker': 'Non hai ancora pennarelli Promarker nella tua collezione. Aggiungili in La mia collezione.',
      'prismacolor': 'Non hai ancora pennarelli Prismacolor Premier nella tua collezione. Aggiungili in La mia collezione.',
      'spectrumNoir': 'Non hai ancora pennarelli Spectrum Noir nella tua collezione. Aggiungili in La mia collezione.',
      'promarkerBrush': 'Non hai ancora pennarelli Promarker Brush nella tua collezione. Aggiungili in La mia collezione.',
      'arrtx': 'Non hai ancora pennarelli Arrtx nella tua collezione. Aggiungili in La mia collezione.',
      'kurecolor': 'Non hai ancora pennarelli ZIG Kurecolor nella tua collezione. Aggiungili in La mia collezione.',
      'graphit': 'Non hai ancora pennarelli Graph\'it nella tua collezione. Aggiungili in La mia collezione.',
      'marvyLePlume': 'Non hai ancora pennarelli Marvy Le Plume nella tua collezione. Aggiungili in La mia collezione.',
      'blickBrush': 'Non hai ancora pennarelli Blick Studio Brush nella tua collezione. Aggiungili in La mia collezione.',
      'artistsLoft': 'Non hai ancora pennarelli Artist\'s Loft nella tua collezione. Aggiungili in La mia collezione.',
      'other': 'Non hai ancora pennarelli nella tua collezione. Aggiungili in La mia collezione.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Scegli un pennarello base, come $example, oppure scegli Scene come tipo di palette.';
  }

  @override
  String swatchesFiltersCount(int count) {
    return 'Filtri · $count';
  }

  @override
  String swatchesCodeCopied(String code) {
    return '$code copiato. Incollalo come colore base nella scheda Palette.';
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
    return '$visible di $total';
  }

  @override
  String swatchesOwnedSubtitle(String brand, int count) {
    return '$brand · $count posseduti';
  }

  @override
  String swatchesFilteredColorCount(int visible, int total) {
    return '$visible di $total colori';
  }

  @override
  String swatchesSwatchSemantics(String code, String name, String favorite) {
    String _temp0 = intl.Intl.selectLogic(favorite, {
      'true': '$code, $name, preferito',
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
    return 'La palette «$title» è pronta in Palette.';
  }

  @override
  String matchSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'i tuoi $count pennarelli',
      one: 'il tuo pennarello',
    );
    return 'Abbinamento con $_temp0';
  }

  @override
  String get matchQualityExcellent => 'Quasi identico';

  @override
  String get matchQualityVeryClose => 'Molto vicino';

  @override
  String get matchQualityClose => 'Vicino';

  @override
  String get matchQualityFair => 'Approssimativo';

  @override
  String get matchQualityApproximate => 'Lontano';

  @override
  String matchRecorded(String code) {
    return '$code salvato nelle scelte recenti.';
  }

  @override
  String get errDisabled => 'I suggerimenti IA sono disattivati.';

  @override
  String get errMissingKey => 'Nessuna chiave API configurata.';

  @override
  String get errNoModelSelected => 'Nessun modello IA selezionato.';

  @override
  String get errUnauthorized => 'La chiave API è stata rifiutata.';

  @override
  String get errPaymentRequired =>
      'L’account non ha credito o la chiave ha esaurito la quota.';

  @override
  String get errRateLimited =>
      'Il fornitore sta limitando le richieste. Riprova tra poco.';

  @override
  String get errServerError =>
      'Il fornitore ha avuto un errore del server. Riprova più tardi.';

  @override
  String get errHttpError => 'Il fornitore ha rifiutato la richiesta.';

  @override
  String get errNetworkError =>
      'Impossibile raggiungere il fornitore. Controlla la connessione.';

  @override
  String get errInvalidJson =>
      'Il fornitore ha restituito una risposta illeggibile.';

  @override
  String get errInvalidResponse =>
      'Il fornitore non ha restituito nessuna palette utilizzabile.';

  @override
  String get errNoValidSuggestions =>
      'Il fornitore ha suggerito colori che non sono nella collezione attiva.';

  @override
  String get errNoAvailableColors =>
      'Non ci sono pennarelli disponibili tra cui scegliere.';

  @override
  String get errNoSuggestions => 'Non è stato possibile generare suggerimenti.';

  @override
  String get errTimeout =>
      'Il modello sul dispositivo ha impiegato troppo. Riprova.';

  @override
  String get errOnDeviceUnavailable =>
      'Il modello sul dispositivo non è pronto su questo telefono.';

  @override
  String get errUnknown => 'I suggerimenti IA non sono disponibili.';

  @override
  String errAiUnavailableWithReason(String reason) {
    return 'IA non disponibile ($reason). Mostro i suggerimenti locali.';
  }

  @override
  String get roleMainTone => 'Tono principale';

  @override
  String get roleMidtone => 'Mezzo tono';

  @override
  String get roleShadow => 'Ombra';

  @override
  String get roleHighlight => 'Luce';

  @override
  String get roleBlend => 'Sfumatura';

  @override
  String get roleToneA => 'Tono A';

  @override
  String get roleToneAShadow => 'Ombra del tono A';

  @override
  String get roleToneB => 'Tono B';

  @override
  String get roleToneBShadow => 'Ombra del tono B';

  @override
  String get roleBridge => 'Ponte';

  @override
  String get roleWarmBase => 'Base calda';

  @override
  String get roleWarmShadow => 'Ombra calda';

  @override
  String get roleSunlitAccent => 'Accento al sole';

  @override
  String get roleDepthTone => 'Tono di profondità';

  @override
  String get roleCoolBase => 'Base fredda';

  @override
  String get roleCoolShadow => 'Ombra fredda';

  @override
  String get roleAtmosphere => 'Atmosfera';

  @override
  String get roleDeepCool => 'Freddo profondo';

  @override
  String get rolePastelBase => 'Base pastello';

  @override
  String get roleSoftShade => 'Ombra morbida';

  @override
  String get rolePastelHighlight => 'Luce pastello';

  @override
  String get roleAccent => 'Accento';

  @override
  String get roleSupport => 'Supporto';

  @override
  String get roleNeonLead => 'Neon principale';

  @override
  String get roleNeonSecondary => 'Neon secondario';

  @override
  String get roleGlow => 'Bagliore';

  @override
  String get rolePopAccent => 'Accento pop';

  @override
  String get roleHue1 => 'Tinta 1';

  @override
  String get roleHue2 => 'Tinta 2';

  @override
  String get roleHue3 => 'Tinta 3';

  @override
  String get roleHue4 => 'Tinta 4';

  @override
  String get roleHue5 => 'Tinta 5';

  @override
  String get roleUnexpectedLead => 'Principale inatteso';

  @override
  String get roleContrastPair => 'Coppia a contrasto';

  @override
  String get roleTensionAccent => 'Accento di tensione';

  @override
  String get roleOffbeatSupport => 'Supporto insolito';

  @override
  String get roleRandom1 => 'Casuale 1';

  @override
  String get roleRandom2 => 'Casuale 2';

  @override
  String get roleRandom3 => 'Casuale 3';

  @override
  String get roleRandom4 => 'Casuale 4';

  @override
  String get roleRandom5 => 'Casuale 5';

  @override
  String get roleLightValue => 'Valore chiaro';

  @override
  String get roleMidLight => 'Medio chiaro';

  @override
  String get roleMid => 'Medio';

  @override
  String get roleMidDark => 'Medio scuro';

  @override
  String get roleDarkValue => 'Valore scuro';

  @override
  String get roleWarmSideA => 'Lato caldo A';

  @override
  String get roleWarmSideB => 'Lato caldo B';

  @override
  String get roleCoolSideA => 'Lato freddo A';

  @override
  String get roleCoolSideB => 'Lato freddo B';

  @override
  String get roleBridgeTone => 'Tono ponte';

  @override
  String get roleSeasonLead => 'Principale di stagione';

  @override
  String get roleSeasonSupport => 'Supporto di stagione';

  @override
  String get roleFestiveRed => 'Rosso festivo';

  @override
  String get roleEvergreen => 'Sempreverde';

  @override
  String get roleGoldAccent => 'Accento oro';

  @override
  String get rolePineShadow => 'Ombra di pino';

  @override
  String get roleSnowSupport => 'Supporto neve';

  @override
  String get roleRomanticLead => 'Principale romantico';

  @override
  String get roleRoseShadow => 'Ombra rosa';

  @override
  String get roleSoftBlush => 'Rosa tenue';

  @override
  String get roleBalanceTone => 'Tono di equilibrio';

  @override
  String get roleBase => 'Base';

  @override
  String get roleGlowZone => 'Zona di bagliore';

  @override
  String get rolePatternAccent => 'Accento del motivo';

  @override
  String get roleContrastColor => 'Colore a contrasto';

  @override
  String get rolePrimary1 => 'Primario 1';

  @override
  String get rolePrimary2 => 'Primario 2';

  @override
  String get rolePrimary3 => 'Primario 3';

  @override
  String get roleSecondary => 'Secondario';

  @override
  String get roleSepiaLight => 'Luce seppia';

  @override
  String get roleDustMidtone => 'Mezzo tono polvere';

  @override
  String get roleLeatherShadow => 'Ombra cuoio';

  @override
  String get roleAgedAccent => 'Accento invecchiato';

  @override
  String get roleSmokeNeutral => 'Neutro fumo';

  @override
  String get roleHauntBase => 'Base stregata';

  @override
  String get rolePumpkinGlow => 'Bagliore zucca';

  @override
  String get roleNightShadow => 'Ombra notte';

  @override
  String get roleEerieAccent => 'Accento inquietante';

  @override
  String get roleFogSupport => 'Supporto nebbia';

  @override
  String get roleNightBase => 'Base notte';

  @override
  String get roleDeepShadow => 'Ombra profonda';

  @override
  String get roleMoonlitEdge => 'Bordo al chiaro di luna';

  @override
  String get roleCoolAccent => 'Accento freddo';

  @override
  String get roleMist => 'Foschia';

  @override
  String get roleWaterBase => 'Base acqua';

  @override
  String get roleDepth => 'Profondità';

  @override
  String get roleShadowWater => 'Ombra acqua';

  @override
  String get roleLightBeam => 'Raggio di luce';

  @override
  String get roleBubbleHighlight => 'Luce delle bolle';

  @override
  String get roleSpookyBase => 'Base spettrale';

  @override
  String get roleColdShadow => 'Ombra gelida';

  @override
  String get roleHauntedAccent => 'Accento infestato';

  @override
  String get roleEerieHighlight => 'Luce inquietante';

  @override
  String get roleFogTone => 'Tono nebbia';

  @override
  String get roleMysticBase => 'Base mistica';

  @override
  String get roleSpellShadow => 'Ombra d’incantesimo';

  @override
  String get roleMagicalAccent => 'Accento magico';

  @override
  String get roleRuneGlow => 'Bagliore di rune';

  @override
  String get roleMoodLead => 'Principale d’atmosfera';

  @override
  String get roleMoodShadow => 'Ombra d’atmosfera';

  @override
  String get roleEmotionAccent => 'Accento emotivo';

  @override
  String get roleMaterialBase => 'Base del materiale';

  @override
  String get rolePlaneShift => 'Cambio di piano';

  @override
  String get roleHardShadow => 'Ombra dura';

  @override
  String get roleSpecularEdge => 'Bordo speculare';

  @override
  String get rolePatinaAccent => 'Accento patina';

  @override
  String get roleSpaceBase => 'Base spazio';

  @override
  String get roleNebulaGlow => 'Bagliore nebulosa';

  @override
  String get roleDeepVoid => 'Vuoto profondo';

  @override
  String get roleStarAccent => 'Accento stella';

  @override
  String get roleDustCloud => 'Nube di polvere';

  @override
  String get roleGlassPaneA => 'Vetro A';

  @override
  String get roleGlassPaneB => 'Vetro B';

  @override
  String get roleGlassPaneC => 'Vetro C';

  @override
  String get roleGlassPaneD => 'Vetro D';

  @override
  String get roleLightHit => 'Colpo di luce';

  @override
  String get roleShade => 'Ombreggiatura';

  @override
  String get roleContrast => 'Contrasto';

  @override
  String get roleSoftShadow => 'Ombra morbida';

  @override
  String get roleBackground => 'Sfondo';

  @override
  String get roleCompanionHue => 'Tinta compagna';

  @override
  String get rolePrimaryShadow => 'Ombra primaria';

  @override
  String get roleMysticAccent => 'Accento mistico';

  @override
  String get roleSecondaryAccent => 'Accento secondario';

  @override
  String get rolePumpkinShadow => 'Ombra zucca';

  @override
  String get roleWitchyPurple => 'Viola stregato';

  @override
  String get roleToxicAccent => 'Accento tossico';

  @override
  String get roleNightBackground => 'Sfondo notte';

  @override
  String get roleRibbonRed => 'Rosso nastro';

  @override
  String get rolePineDepth => 'Profondità di pino';

  @override
  String get roleSnowHighlight => 'Luce di neve';

  @override
  String get roleBudShadow => 'Ombra del bocciolo';

  @override
  String get roleBlossomTint => 'Sfumatura di fiore';

  @override
  String get roleFreshLeaf => 'Foglia fresca';

  @override
  String get roleDaffodilLight => 'Luce di narciso';

  @override
  String get roleRainySky => 'Cielo di pioggia';

  @override
  String get roleSkinSubjectShadow => 'Ombra pelle/soggetto';

  @override
  String get roleWarmCompanion => 'Compagno caldo';

  @override
  String get roleNeutralBalance => 'Equilibrio neutro';

  @override
  String get roleBarkShadow => 'Ombra corteccia';

  @override
  String get roleMapleRed => 'Rosso acero';

  @override
  String get roleOliveAccent => 'Accento oliva';

  @override
  String get roleMorningMist => 'Foschia del mattino';

  @override
  String get roleSubjectShadow => 'Ombra del soggetto';

  @override
  String get roleCoolCompanion => 'Compagno freddo';

  @override
  String get roleAiryHighlight => 'Luce leggera';

  @override
  String get roleSnowShadow => 'Ombra di neve';

  @override
  String get roleFrostHighlight => 'Luce di brina';

  @override
  String get roleEvergreenDepth => 'Profondità di sempreverde';

  @override
  String get roleBerryAccent => 'Accento bacca';

  @override
  String get roleTwilightSky => 'Cielo crepuscolare';

  @override
  String get roleGroundShadow => 'Ombra del terreno';

  @override
  String get roleSkyBlend => 'Sfumatura di cielo';

  @override
  String get roleSunHighlight => 'Luce del sole';

  @override
  String get roleContrastAccent => 'Accento a contrasto';

  @override
  String get roleNeutralBuffer => 'Cuscinetto neutro';

  @override
  String get rolePalmShadow => 'Ombra di palma';

  @override
  String get roleCoralAccent => 'Accento corallo';

  @override
  String get roleOceanSplash => 'Spruzzo d’oceano';

  @override
  String get roleSunbeamHighlight => 'Luce di raggio solare';

  @override
  String get roleWarmSand => 'Sabbia calda';

  @override
  String get roleLeafShadow => 'Ombra di foglia';

  @override
  String get roleMossMidtone => 'Mezzo tono muschio';

  @override
  String get roleSunlitLeaf => 'Foglia al sole';

  @override
  String get roleTrunkAccent => 'Accento tronco';

  @override
  String get roleSkyFog => 'Cielo/nebbia';

  @override
  String get rolePetalShadow => 'Ombra di petalo';

  @override
  String get rolePetalHighlight => 'Luce di petalo';

  @override
  String get roleSecondaryPetal => 'Petalo secondario';

  @override
  String get roleLeafAccent => 'Accento foglia';

  @override
  String get rolePatternBackground => 'Sfondo del motivo';

  @override
  String get roleToneC => 'Tono C';

  @override
  String get roleToneD => 'Tono D';

  @override
  String get roleNeutralLinework => 'Contorni neutri';

  @override
  String get roleComplement => 'Complementare';

  @override
  String get roleNeutral => 'Neutro';

  @override
  String get roleCompanion => 'Compagno';

  @override
  String get reasonScenarioSupport => 'Supporto della scena';

  @override
  String get reasonBalancedPairing => 'Abbinamento equilibrato';

  @override
  String get reasonShadowDepth => 'Profondità d’ombra';

  @override
  String get reasonSoftNearbyHue => 'Tinta vicina morbida';

  @override
  String get reasonControlledContrast => 'Contrasto controllato';

  @override
  String get reasonHighlightLift => 'Slancio di luce';

  @override
  String get reasonLocked => 'Bloccato';

  @override
  String get reasonVariationSupport => 'Supporto della variante';

  @override
  String get reasonOppositeHueContrast => 'Contrasto di tinta opposta';

  @override
  String get reasonSplitComplementContrast => 'Contrasto complementare diviso';

  @override
  String get reasonTriadBalance => 'Equilibrio della triade';

  @override
  String get reasonSquareHarmony => 'Armonia del quadrato';

  @override
  String get reasonRectangleHarmony => 'Armonia del rettangolo';

  @override
  String get reasonSameFamilyDeeperTone => 'Stessa famiglia, tono più profondo';

  @override
  String get reasonSameFamilyLighterTone => 'Stessa famiglia, tono più chiaro';

  @override
  String get reasonManualPalette => 'Palette manuale';

  @override
  String get reasonSupportTone => 'Tono di supporto';

  @override
  String get reasonAISuggestion => 'Suggerimento IA';

  @override
  String get reasonLoadedPalette => 'Palette caricata';

  @override
  String get reasonAppliedFromIdeas => 'Applicata da Idee';

  @override
  String reasonNearbyHue(int degrees) {
    return 'Armonia di tinta vicina ($degrees°)';
  }

  @override
  String reasonShadowTone(int percent) {
    return 'Tono d’ombra ($percent % più scuro)';
  }

  @override
  String reasonVariation(String prefix, String reason) {
    return '$prefix: $reason';
  }

  @override
  String get variationPrefixVibrant => 'Vivace';

  @override
  String get variationPrefixSoft => 'Morbida';

  @override
  String get variationPrefixContrast => 'Contrasto';

  @override
  String get variationPrefixWarm => 'Calda';

  @override
  String get variationPrefixCool => 'Fredda';

  @override
  String get variationLabelMoreVibrant => 'Più vivace';

  @override
  String get variationLabelSofter => 'Più morbida';

  @override
  String get variationLabelHigherContrast => 'Più contrasto';

  @override
  String get variationLabelWarmer => 'Più calda';

  @override
  String get variationLabelCooler => 'Più fredda';

  @override
  String get modeRecommended => 'Consigliata';

  @override
  String get modeComplementary => 'Complementare';

  @override
  String get modeAnalogous => 'Analoga';

  @override
  String get modeSplitComplementary => 'Complementare divisa';

  @override
  String get modeTriad => 'Triade';

  @override
  String get modeSquare => 'Quadrato';

  @override
  String get modeRectangle => 'Rettangolo';

  @override
  String get modeMonochrome => 'Monocromatica';

  @override
  String get modeCustomPalette => 'Personalizzata';

  @override
  String get modeShadow => 'Ombra';

  @override
  String get packLabel120New => '120 Nuovo';

  @override
  String get packLabel36Skin => '36 Pelle';

  @override
  String get packLabel36Gray => '36 Grigi';

  @override
  String get packLabel48Pastel => '48 Pastello';

  @override
  String get categorySignature => 'Firma';

  @override
  String get categoryChallenges => 'Sfide';

  @override
  String get categoryAtmosphere => 'Atmosfera';

  @override
  String get settingsLinesTitle => 'Serie che hai';

  @override
  String get settingsLinesHint =>
      'Scegli ogni serie Ohuhu che hai. Disattivando una serie, i suoi set vengono tolti dalla selezione.';

  @override
  String settingsLineSelectedOfTotal(int selected, int total) {
    return '$selected di $total set selezionati';
  }

  @override
  String settingsCurrentPacks(int count) {
    return 'Set attuali ($count)';
  }

  @override
  String settingsLegacyPacks(int count) {
    return 'Set vecchi / della comunità ($count)';
  }

  @override
  String get settingsLegacyPacksNote =>
      'Elenco di set della comunità; potrebbero non essere più in vendita.';

  @override
  String settingsPackColorsSemantics(String pack, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colori',
      one: '1 colore',
    );
    return '$pack, $_temp0';
  }

  @override
  String get swatchesLines => 'Serie';

  @override
  String get swatchesLabelLine => 'Serie';

  @override
  String get swatchesAllLines => 'Tutte le serie';

  @override
  String get swatchesLegacyPacks => 'Set vecchi';

  @override
  String packLabelSkin(String n) {
    return '$n Pelle';
  }

  @override
  String packLabelPastel(String n) {
    return '$n Pastello';
  }

  @override
  String packLabelPastels(String n) {
    return '$n Pastelli';
  }

  @override
  String packLabelBasic(String n) {
    return '$n Base';
  }

  @override
  String packLabelIllustration(String n) {
    return '$n Illustrazione';
  }

  @override
  String packLabelLandscape(String n) {
    return '$n Paesaggio';
  }

  @override
  String packLabelSweetPastels(String n) {
    return '$n Pastelli dolci';
  }

  @override
  String packLabelMidTones(String n) {
    return '$n Mezzi toni';
  }

  @override
  String packLabelBlossomPastels(String n) {
    return '$n Pastelli in fiore';
  }

  @override
  String packLabelWhiteCase(String n) {
    return 'Astuccio bianco $n';
  }

  @override
  String packLabelWhiteCaseVersion(String n, String v) {
    return 'Astuccio bianco $n (V$v)';
  }

  @override
  String packLabelJapanVersion(String n, String v) {
    return 'Giappone $n (V$v)';
  }

  @override
  String packFullLabel(String line, String pack) {
    return '$line $pack';
  }

  @override
  String swatchesMorePacks(int count) {
    return '+$count altri';
  }

  @override
  String get settingsMatchingGroup => 'Abbinamento dei colori';

  @override
  String get settingsMatchSuggestUnowned => 'Mostra tutta la gamma';

  @override
  String get settingsMatchSuggestUnownedSubtitle =>
      'Quando nessuno dei tuoi pennarelli è vicino, Abbina mostra anche il più vicino di tutta la gamma.';

  @override
  String get settingsSetupAgain => 'Ripeti la configurazione';

  @override
  String get matchNoCloseMatch =>
      'Nessun abbinamento vicino tra i tuoi pennarelli.';

  @override
  String matchRangeTitle(String brand) {
    return 'Tutta la gamma $brand';
  }

  @override
  String get matchNotOwnedBadge => 'Non ce l’hai';

  @override
  String matchBestOfRange(String brand) {
    return 'Il migliore di tutta la gamma $brand';
  }

  @override
  String get matchNotOwnedLine => 'Non è nella tua collezione';

  @override
  String matchSeeAll(int count) {
    return 'Vedi tutte ($count)';
  }

  @override
  String get matchSubtitleEmpty =>
      'Ancora nessun pennarello nella tua collezione';

  @override
  String swatchesWholeRangeNotice(String brand) {
    return 'Mostra tutta la gamma $brand';
  }

  @override
  String get swatchesWholeRangeAction => 'Configura';

  @override
  String matchWholeRangeBody(String brand) {
    return 'Finché non configuri la collezione, l’abbinamento usa tutta la gamma $brand.';
  }

  @override
  String get matchWholeRangeAction => 'Vai alla collezione';

  @override
  String get collectionTitle => 'La mia collezione';

  @override
  String collectionMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli',
      one: '1 pennarello',
      zero: 'Nessun pennarello',
    );
    return '$_temp0';
  }

  @override
  String collectionSets(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count set',
      one: '1 set',
    );
    return '$_temp0';
  }

  @override
  String get collectionNotSetUp => 'Da configurare';

  @override
  String get collectionSeriesTitle => 'Serie che hai';

  @override
  String get collectionHonoluluNote =>
      'Honolulu B, Honolulu S e Honolulu² usano gli stessi codici colore di Honolulu; cambiano solo le punte.';

  @override
  String get collectionSetsTitle => 'Set che hai';

  @override
  String get collectionSetsEmpty => 'Scegli una serie per vedere i suoi set.';

  @override
  String collectionOlderSets(int count) {
    return 'Set vecchi ($count)';
  }

  @override
  String get collectionOlderSetsNote =>
      'Edizioni fuori produzione o regionali, da dati della comunità.';

  @override
  String get collectionExtrasTitle => 'Pennarelli extra';

  @override
  String get collectionExtrasHint =>
      'Hai comprato pennarelli singoli? Spuntali qui. I pennarelli dei tuoi set contano già.';

  @override
  String get collectionDecoMarkersTitle => 'I tuoi pennarelli';

  @override
  String get collectionDecoHint =>
      'DecoTime non pubblica quali colori contiene ogni set, quindi spunta quelli che hai o aggiungi un’intera famiglia.';

  @override
  String get collectionDecoSizesHint =>
      'Action vende set DecoTime da 100, 150, 160, 200 e 300 pennarelli.';

  @override
  String get collectionFamiliesTitle => 'Aggiungi per famiglia';

  @override
  String collectionFamilyChip(String family, int owned, int total) {
    return '$family $owned/$total';
  }

  @override
  String get collectionFamilyColours => 'Colori';

  @override
  String get collectionFamilyWarmGrey => 'Grigi caldi';

  @override
  String get collectionFamilyCoolGrey => 'Grigi freddi';

  @override
  String get collectionFamilyBlueGrey => 'Grigi azzurri';

  @override
  String get collectionFamilyGreenGrey => 'Grigi verdi';

  @override
  String get collectionDecoRange => 'Gamma DecoTime';

  @override
  String get collectionWholeRange => 'Tutta la gamma';

  @override
  String get collectionSearchHint => 'Cerca codice o nome';

  @override
  String get collectionTickVisible => 'Spunta tutti';

  @override
  String collectionTickManyTitle(int count) {
    return 'Spuntare $count pennarelli?';
  }

  @override
  String get collectionTickManyBody =>
      'Contano tutti come pennarelli che hai. Puoi toglierli di nuovo con «Togli tutti».';

  @override
  String get collectionUntickVisible => 'Togli tutti';

  @override
  String get collectionInYourSets => 'Nel tuo set';

  @override
  String get collectionNoResults =>
      'Nessun pennarello corrisponde alla ricerca.';

  @override
  String get collectionReset => 'Azzera collezione';

  @override
  String get collectionOwnedGroup => 'Quello che hai';

  @override
  String get collectionShoppingGroup => 'Acquisti';

  @override
  String get collectionToolsGroup => 'Strumenti';

  @override
  String get toolsMapTitle => 'Mappa dei colori';

  @override
  String get toolsMapHint =>
      'Dove cadono i tuoi pennarelli per tonalità e luminosità, e dove ci sono vuoti.';

  @override
  String get toolsTranslateTitle => 'Traduci una ricetta';

  @override
  String get toolsTranslateHint =>
      'Trasforma i codici di un tutorial nei tuoi pennarelli più vicini.';

  @override
  String get toolsBlendsTitle => 'Le mie ricette';

  @override
  String get toolsBlendsHint =>
      'Sfumature che salvi: pennarelli in ordine, una nota e una foto.';

  @override
  String get toolsTransferTitle => 'Esporta e importa';

  @override
  String get toolsTransferHint =>
      'Condividi i tuoi pennarelli come elenco o CSV, oppure aggiungine molti con i codici.';

  @override
  String get toolsMapEmptyTitle => 'Ancora nessun pennarello da mappare';

  @override
  String get toolsMapIntro =>
      'Ogni punto è un pennarello che possiedi. Le zone tratteggiate non ne hanno.';

  @override
  String get toolsMapShowRange => 'Mostra tutta la gamma';

  @override
  String get toolsMapShowRangeHint =>
      'Punti tenui per tutti i pennarelli delle tue marche, per vedere cosa manca.';

  @override
  String get toolsMapAxes =>
      'Da sinistra a destra: tonalità. Dall’alto in basso: da chiaro a scuro.';

  @override
  String get toolsMapGreysTitle => 'Grigi e neutri';

  @override
  String get toolsMapGreysAxis => 'Da sinistra a destra: da scuro a chiaro.';

  @override
  String get toolsMapFamiliesTitle => 'Per tonalità';

  @override
  String get toolsHueRed => 'Rosso';

  @override
  String get toolsHueOrange => 'Arancione';

  @override
  String get toolsHueYellow => 'Giallo';

  @override
  String get toolsHueGreen => 'Verde';

  @override
  String get toolsHueTeal => 'Turchese';

  @override
  String get toolsHueBlue => 'Blu';

  @override
  String get toolsHueViolet => 'Viola';

  @override
  String get toolsHueMagenta => 'Magenta';

  @override
  String toolsFamilyBands(int light, int mid, int dark) {
    return 'Chiari $light · Medi $mid · Scuri $dark';
  }

  @override
  String get toolsMapDriedNote => 'I pennarelli secchi sono esclusi.';

  @override
  String toolsMapSummary(String markers, int empty, int cells) {
    return 'Mappa dei colori di $markers. $empty zone su $cells non hanno pennarelli. L’elenco qui sotto riporta gli stessi pennarelli per tonalità.';
  }

  @override
  String get toolsMarkerOwned => 'Nella tua collezione';

  @override
  String get toolsMarkerNotOwned => 'Non è nella tua collezione';

  @override
  String get toolsTranslateIntro =>
      'Scrivi o incolla i codici di un tutorial, nella marca che usa. Virgole, spazi ed elenchi vanno bene.';

  @override
  String get toolsTranslateBrand => 'Marca della ricetta';

  @override
  String get toolsTranslateCodes => 'Codici';

  @override
  String get toolsTranslateResults => 'Traduzione';

  @override
  String get toolsTranslateEmpty => 'I codici che scrivi compaiono qui.';

  @override
  String get toolsTranslateMine => 'Il più vicino che hai';

  @override
  String get toolsTranslateNotOwned => 'Non lo hai';

  @override
  String get toolsTranslateMissing => 'Niente di simile nella tua collezione.';

  @override
  String toolsTranslateUnknown(String brand) {
    return 'Non presente in $brand';
  }

  @override
  String get toolsCopyList => 'Copia elenco';

  @override
  String get toolsShareList => 'Condividi elenco';

  @override
  String get toolsListCopied => 'Elenco copiato.';

  @override
  String get toolsShareFailed => 'Impossibile condividere l’elenco.';

  @override
  String get toolsBlendsNew => 'Nuova ricetta';

  @override
  String get toolsBlendsEditTitle => 'Modifica ricetta';

  @override
  String get toolsBlendsEmptyTitle => 'Ancora nessuna ricetta';

  @override
  String get toolsBlendsEmptyBody =>
      'Salva le sfumature che ti piacciono: pennarelli in ordine, una nota e una foto.';

  @override
  String get toolsBlendsName => 'Nome della ricetta';

  @override
  String get toolsBlendsMarkersTitle => 'Pennarelli, in ordine';

  @override
  String get toolsBlendsMarkersHelp =>
      'Trascina la maniglia per cambiare l’ordine.';

  @override
  String get toolsBlendsDrag => 'Trascina per riordinare';

  @override
  String toolsBlendsRemoveMarker(String code) {
    return 'Rimuovi $code';
  }

  @override
  String get toolsBlendsNote => 'Nota';

  @override
  String get toolsBlendsPhotoTitle => 'Foto del risultato';

  @override
  String get toolsBlendsPhotoHelp => 'Facoltativa. Resta su questo telefono.';

  @override
  String get toolsBlendsPhotoSemantic => 'Foto della ricetta';

  @override
  String get toolsBlendsSave => 'Salva ricetta';

  @override
  String get toolsBlendsDelete => 'Elimina ricetta';

  @override
  String get toolsBlendsDeleteTitle => 'Eliminare questa ricetta?';

  @override
  String get toolsBlendsDeleteBody =>
      'La ricetta e la sua foto saranno rimosse da questo telefono.';

  @override
  String get toolsTransferExport => 'Esporta';

  @override
  String toolsTransferBrands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marche',
      one: '1 marca',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferExportBrands(String brands) {
    return 'Include tutte le marche che hai: $brands.';
  }

  @override
  String get toolsTransferCsv => 'Condividi come CSV';

  @override
  String get toolsTransferImport => 'Importa con i codici';

  @override
  String get toolsTransferImportHelp =>
      'Scegli la marca e incolla i suoi codici. Non viene aggiunto nulla finché non premi il pulsante.';

  @override
  String get toolsTransferNew => 'Pennarelli nuovi';

  @override
  String get toolsTransferAlready => 'Già tuoi';

  @override
  String get toolsTransferUnknown => 'Non riconosciuti';

  @override
  String toolsTransferAdd(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aggiungi $count pennarelli',
      one: 'Aggiungi 1 pennarello',
      zero: 'Aggiungi pennarelli',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli aggiunti.',
      one: '1 pennarello aggiunto.',
    );
    return '$_temp0';
  }

  @override
  String commonSeeAll(int count) {
    return 'Vedi tutto ($count)';
  }

  @override
  String get collectionChartTitle => 'Cartella colori stampabile';

  @override
  String get swatchesOtherBrandsTitle => 'In altre marche';

  @override
  String get swatchesOtherBrandsOnlyMine => 'Solo i miei';

  @override
  String get swatchesOtherBrandsNone =>
      'Non c’è un’altra marca con cui confrontare.';

  @override
  String get swatchesOtherBrandsNoneMine =>
      'Non hai pennarelli utilizzabili di altre marche.';

  @override
  String get swatchesOtherBrandsFailed =>
      'Non è stato possibile leggere le altre marche.';

  @override
  String get swatchesOtherBrandsPaletteNote =>
      'Le palette usano la marca scelta nelle opzioni, quindi questo pennarello non può essere aggiunto a una.';

  @override
  String get paletteVisionTitle => 'Visione dei colori';

  @override
  String get paletteVisionNormal => 'Normale';

  @override
  String get paletteVisionProtanopia => 'Protanopia';

  @override
  String get paletteVisionDeuteranopia => 'Deuteranopia';

  @override
  String get paletteVisionTritanopia => 'Tritanopia';

  @override
  String get paletteVisionAchromatopsia => 'Acromatopsia';

  @override
  String paletteVisionPairs(String pairs) {
    return 'Difficili da distinguere: $pairs';
  }

  @override
  String paletteVisionPairsMore(int count) {
    return '+$count altri';
  }

  @override
  String get paletteVisionNoPairs =>
      'Tutti i colori restano facili da distinguere.';

  @override
  String get paletteVisionPreviewNote =>
      'Solo un’anteprima. Salvando e condividendo restano i colori reali.';

  @override
  String get paletteEaselTitle => 'Modalità cavalletto';

  @override
  String get paletteEaselExit => 'Esci dalla modalità cavalletto';

  @override
  String get paletteShareTextButton => 'Condividi come testo';

  @override
  String paletteTextHeader(String brand, String title) {
    return 'Palette di Ink Lab · $brand · $title';
  }

  @override
  String get paletteImportTitle => 'Importa da testo';

  @override
  String get paletteImportHint =>
      'Incolla una palette condivisa o un elenco di codici di pennarelli.';

  @override
  String get paletteImportPaste => 'Incolla';

  @override
  String get paletteImportAction => 'Carica palette';

  @override
  String get paletteImportNothing =>
      'Nessun codice di pennarello trovato in questo testo.';

  @override
  String paletteImportNoneKnown(String brand, String codes) {
    return 'Nessuno di questi codici è un pennarello $brand: $codes.';
  }

  @override
  String paletteImportOtherBrand(String brand) {
    return 'Questa palette è per $brand. Cambia marca nelle Opzioni per importarla.';
  }

  @override
  String paletteImportDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Palette importata con $count pennarelli.',
      one: 'Palette importata con 1 pennarello.',
    );
    return '$_temp0';
  }

  @override
  String paletteImportUnknown(String codes) {
    return 'Non riconosciuti: $codes.';
  }

  @override
  String get paletteImportRepeated =>
      'I codici ripetuti sono stati contati una sola volta.';

  @override
  String get collectionChartHint =>
      'Riquadri vuoti con il codice e il nome di ogni pennarello che hai, per campionare i tuoi pennarelli reali. Condivisa come immagini A4 da stampare o salvare.';

  @override
  String get collectionChartShowColour => 'Colore del catalogo';

  @override
  String get collectionChartShowColourHint =>
      'Mostralo come una sottile striscia in ogni riquadro, per confrontare.';

  @override
  String get collectionChartCreate => 'Crea e condividi';

  @override
  String get collectionChartPreparing => 'Preparazione…';

  @override
  String get collectionChartEmpty => 'Scegli prima i tuoi set o pennarelli.';

  @override
  String collectionChartPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagine',
      one: '1 pagina',
    );
    return '$_temp0';
  }

  @override
  String get chartImageTitle => 'Cartella colori';

  @override
  String chartImagePage(int page, int total) {
    return 'Pagina $page di $total';
  }

  @override
  String collectionResetTitle(String brand) {
    return 'Azzerare la tua collezione $brand?';
  }

  @override
  String get collectionResetBody =>
      'I tuoi set e i pennarelli extra di questa marca vengono rimossi. Preferiti e palette restano.';

  @override
  String collectionOwnedCount(int owned, int total) {
    return '$owned di $total';
  }

  @override
  String collectionLooseTicked(int loose, int sets) {
    return '$loose singoli spuntati · $sets nei tuoi set';
  }

  @override
  String get onboardingWelcomeTitle => 'Benvenuto in Ink Lab';

  @override
  String get onboardingWelcomeBody =>
      'Sfoglia i tuoi pennarelli, abbina i colori dalle foto e crea palette. Prima, dicci quali pennarelli hai.';

  @override
  String get onboardingOhuhuLine => 'Set per serie: Oahu, Honolulu, Kaala';

  @override
  String get onboardingDecoLine => 'Una gamma di 313 colori, set da Action';

  @override
  String get onboardingSeriesTitle => 'Quali serie hai?';

  @override
  String get onboardingSeriesBody => 'Scegli ogni serie di cui hai pennarelli.';

  @override
  String get onboardingSetsTitle => 'Quali set hai?';

  @override
  String get onboardingSetsBody =>
      'Scegli le confezioni che hai comprato. I pennarelli extra si possono aggiungere dopo.';

  @override
  String get onboardingDoneTitle => 'Tutto pronto';

  @override
  String get onboardingLaterNote =>
      'Potrai cambiarlo dopo in La mia collezione.';

  @override
  String get onboardingSkip => 'Salta';

  @override
  String get onboardingNext => 'Avanti';

  @override
  String get onboardingBack => 'Indietro';

  @override
  String get onboardingFinish => 'Inizia';

  @override
  String get onboardingStepFirst => 'Passo 1';

  @override
  String onboardingMarkersTicked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spuntati',
      one: '1 spuntato',
    );
    return '$_temp0';
  }

  @override
  String onboardingMarkersNoneTicked(String range) {
    return 'Nessuno spuntato · $range';
  }

  @override
  String onboardingStep(int step, int total) {
    return 'Passo $step di $total';
  }

  @override
  String get collectionSeriesOahuTips => 'Punte fini e scalpello';

  @override
  String get collectionSeriesHonoluluTips => 'Pennello e scalpello';

  @override
  String get collectionSeriesKaalaTips => 'Punta a pennello';

  @override
  String get collectionSummaryNoSets =>
      'Non hai ancora scelto nessun set: si usa tutta la gamma';

  @override
  String get collectionSummaryNoMarkers =>
      'Non hai ancora spuntato nessun pennarello';

  @override
  String get collectionExtrasAddTitle => 'Aggiungi pennarelli singoli';

  @override
  String get collectionDecoMarkersButton => 'Spunta i pennarelli';

  @override
  String collectionExtrasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli singoli',
      one: '1 pennarello singolo',
      zero: 'Nessun pennarello singolo',
    );
    return '$_temp0';
  }

  @override
  String get wishlistTitle => 'Lista dei desideri';

  @override
  String wishlistCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli da comprare',
      one: '1 pennarello da comprare',
      zero: 'Ancora niente nella lista dei desideri',
    );
    return '$_temp0';
  }

  @override
  String get wishlistSubtitle => 'Aggiungili dal dettaglio di un colore';

  @override
  String get wishlistEmpty =>
      'Aggiungi i pennarelli che vuoi comprare dal dettaglio di qualsiasi pennarello.';

  @override
  String get wishlistAdd => 'Aggiungi ai desideri';

  @override
  String get wishlistRemove => 'Togli dai desideri';

  @override
  String get wishlistCopy => 'Copia l’elenco';

  @override
  String get wishlistCopied => 'Lista della spesa copiata';

  @override
  String get wishlistOfferTitle => 'Aggiungere alla lista dei desideri?';

  @override
  String wishlistOfferBody(String code) {
    return '$code è secco. Aggiungilo alla lista dei desideri per comprare una ricarica o un sostituto.';
  }

  @override
  String get driedTitle => 'Secchi';

  @override
  String driedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli secchi',
      one: '1 pennarello secco',
      zero: 'Nessun pennarello secco',
    );
    return '$_temp0';
  }

  @override
  String get driedHint =>
      'Restano nella tua collezione, ma Abbina, Palette e Idee non li suggeriscono.';

  @override
  String get driedEmpty =>
      'Quando un pennarello smette di funzionare, segnalo come secco dal suo dettaglio.';

  @override
  String get driedMark => 'Segna come secco';

  @override
  String get driedUnmark => 'Segna come utilizzabile';

  @override
  String get driedNote =>
      'Secco: Abbina, Palette e Idee lo saltano finché non lo segni come utilizzabile.';

  @override
  String get commonDried => 'Secco';

  @override
  String get buyNextTitle => 'Cosa comprare dopo';

  @override
  String get buyNextIntro =>
      'Pennarelli che non hai e che avvicinerebbero di più i tuoi colori al maggior numero di scene.';

  @override
  String buyNextReasonScenes(int count, String scenes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Migliora $count scene: $scenes',
      one: 'Migliora 1 scena: $scenes',
    );
    return '$_temp0';
  }

  @override
  String get buyNextReasonGap => 'Colma un vuoto nella tua gamma di colori';

  @override
  String get buyNextNoCollection =>
      'Spunta i pennarelli che hai per vedere cosa comprare dopo.';

  @override
  String get buyNextComplete =>
      'Niente da suggerire: i tuoi pennarelli coprono già bene ogni scena.';

  @override
  String get buyNextRefill => 'Secco: una ricarica lo riporta in vita.';

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Finché non scegli i set, l’app mostra tutta la gamma $brand.';
  }

  @override
  String get onboardingDoneNext =>
      'E ora: sfoglia i colori in Campioni, abbina una foto in Abbina o crea una palette in Palette.';

  @override
  String get collectionVisibleScope =>
      'Vale per i pennarelli che corrispondono alla ricerca.';

  @override
  String get matchWhiteBalanceButton => 'Correggi il bianco';

  @override
  String get matchWhiteBalanceHint =>
      'Tocca un punto della foto che dovrebbe essere carta bianca.';

  @override
  String get matchWhiteBalanceOn => 'Bianco corretto';

  @override
  String get matchWhiteBalanceReset => 'Annulla';

  @override
  String get matchWhiteBalanceTooDark =>
      'Quel punto è troppo scuro per essere carta. Scegline uno più chiaro.';

  @override
  String get matchWhiteBalanceTooColourful =>
      'Quel punto ha troppo colore per essere carta. Scegli una zona bianca.';

  @override
  String get commonOwnColour => 'Il mio colore';

  @override
  String get swatchesMyColourTitle => 'Il mio colore';

  @override
  String get swatchesMyColourHelp =>
      'I colori del catalogo sono stime. Salva il colore che il tuo pennarello dà davvero sulla carta.';

  @override
  String get swatchesMyColourReset => 'Torna al catalogo';

  @override
  String get swatchesMyColourSaved => 'Il tuo colore è stato salvato';

  @override
  String get swatchesMyColourWasReset => 'Tornato al colore del catalogo';

  @override
  String get swatchesMyColourSame => 'Come il catalogo';

  @override
  String swatchesMyColourValue(String hex) {
    return 'Tuo: $hex';
  }

  @override
  String get swatchesStatusWished => 'Nella tua lista di desideri';

  @override
  String get swatchesDetailsTitle => 'Dettagli';

  @override
  String get swatchesCatalogueLabel => 'Catalogo';

  @override
  String get swatchesMineLabel => 'Mio';

  @override
  String ownColorTitle(String code) {
    return 'Il mio colore per $code';
  }

  @override
  String get ownColorHexLabel => 'Colore hex';

  @override
  String get ownColorHexInvalid =>
      'Scrivi 3 o 6 cifre esadecimali, come 3A7F9C.';

  @override
  String get ownColorPhotoTitle => 'Da una foto';

  @override
  String get ownColorPhotoHelp =>
      'Colora con il pennarello su carta bianca, scatta una foto e tocca la zona colorata.';

  @override
  String get ownColorPhotoTap => 'Tocca la zona colorata.';

  @override
  String get ownColorSave => 'Salva il mio colore';

  @override
  String get settingsOwnColors => 'Usa i miei colori';

  @override
  String get settingsOwnColorsSubtitle =>
      'Abbina, Palette e Idee usano il colore che hai salvato per un pennarello al posto di quello del catalogo.';

  @override
  String settingsOwnColorsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colori tuoi',
      one: '1 colore tuo',
      zero: 'Ancora nessun colore tuo',
    );
    return '$_temp0';
  }

  @override
  String get settingsOwnColorsReset => 'Azzera';

  @override
  String get settingsOwnColorsResetTitle => 'Azzerare i tuoi colori?';

  @override
  String get settingsOwnColorsResetBody =>
      'Ogni pennarello torna al suo colore del catalogo. Non si può annullare.';

  @override
  String get settingsJoinBeta => 'Unisciti alla beta di Google Play';

  @override
  String get collectionCopicHint =>
      'I pennarelli Copic si acquistano singolarmente. Spunta quelli che hai.';

  @override
  String get collectionFinecolourHint =>
      'I pennarelli Finecolour si acquistano singolarmente. Spunta quelli che hai.';

  @override
  String get onboardingCopicLine => '358 colori · Spunta i pennarelli che hai';

  @override
  String get onboardingFinecolourLine =>
      '480 colori · Spunta i pennarelli che hai';

  @override
  String onboardingMarkersTitle(String brand) {
    return 'I tuoi pennarelli $brand';
  }

  @override
  String onboardingNoMarkers(String brand) {
    return 'Non hai ancora spuntato pennarelli $brand: spuntali in La mia collezione.';
  }

  @override
  String ideasNoMarkersBrand(String brand) {
    return 'Aggiungi i pennarelli $brand che hai in La mia collezione per ottenere una palette per questa idea.';
  }

  @override
  String get ideasDiarySegment => 'Diario';

  @override
  String get ideasDiarySubtitle => 'Le tue opere, le più recenti per prime';

  @override
  String get diaryEmptyTitle => 'Il tuo diario è vuoto';

  @override
  String get diaryEmptyMessage =>
      'Annota le pagine e i fogli che colori, con pennarelli, note e foto.';

  @override
  String get diaryAdd => 'Aggiungi al diario';

  @override
  String get diaryShareButton => 'Condividi questa voce';

  @override
  String get diaryStatusLabel => 'Stato';

  @override
  String get diaryStatusInProgress => 'In corso';

  @override
  String get diaryStatusFinished => 'Finita';

  @override
  String get diaryNewTitle => 'Nuova voce';

  @override
  String get diaryEditTitle => 'Modifica voce';

  @override
  String get diaryTitleLabel => 'Titolo';

  @override
  String get diaryDateLabel => 'Data';

  @override
  String get diaryOnWhatLabel => 'Dipinto su';

  @override
  String get diaryOnWhatHint => 'es. un libro da colorare o un album';

  @override
  String get diaryMarkersTitle => 'Pennarelli usati';

  @override
  String get diaryMarkersChoose => 'Scegli i pennarelli';

  @override
  String diaryMarkerRemove(String code) {
    return 'Rimuovi $code';
  }

  @override
  String get diaryPaletteTitle => 'Palette';

  @override
  String get diaryPaletteNone => 'Nessuna palette';

  @override
  String get diaryPaletteChoose => 'Collega una palette salvata';

  @override
  String get diaryPaletteMissing => 'Questa palette non è più salvata.';

  @override
  String get diaryPaletteEmpty => 'Non hai ancora palette salvate.';

  @override
  String get diaryNotesLabel => 'Note';

  @override
  String get diaryNotesHint => 'Tecnica, carta, sfumature...';

  @override
  String get diaryMoreDetails => 'Più dettagli';

  @override
  String get diaryPhotosTitle => 'Foto';

  @override
  String diaryPhotosHelp(int count) {
    return 'Fino a $count foto. Restano su questo telefono.';
  }

  @override
  String get diaryPhotoRemove => 'Rimuovi foto';

  @override
  String diaryPhotoSemantic(int number, int total) {
    return 'Foto $number di $total';
  }

  @override
  String get diarySave => 'Salva voce';

  @override
  String get diaryDelete => 'Elimina voce';

  @override
  String get diaryDeleteTitle => 'Eliminare questa voce?';

  @override
  String get diaryDeleteBody =>
      'La voce e le sue foto vengono rimosse da questo telefono. Questa azione non si può annullare.';

  @override
  String get diaryDeleteConfirm => 'Elimina';

  @override
  String get diaryAddedNotice => 'Aggiunto al diario';

  @override
  String diaryStatsArtworks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count opere',
      one: '1 opera',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsFinished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count finite',
      one: '1 finita',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsInProgress(int count) {
    return '$count in corso';
  }

  @override
  String get diaryStatsOpen => 'Vedi i numeri';

  @override
  String get diaryStatsTitle => 'Numeri del diario';

  @override
  String get diaryStatsStatusTitle => 'Finite e in corso';

  @override
  String get diaryStatsMonthsTitle => 'Voci per mese';

  @override
  String diaryStatsMonthsLatest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gli ultimi $count mesi.',
      one: 'L’ultimo mese.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsMarkersTitle => 'Pennarelli che usi di più';

  @override
  String get diaryStatsMarkersEmpty => 'Nessuna voce ha ancora pennarelli.';

  @override
  String diaryStatsEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count voci',
      one: '1 voce',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedTitle => 'Pennarelli non ancora usati';

  @override
  String diaryStatsUnusedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli che hai non sono in nessuna voce.',
      one: '1 pennarello che hai non è in nessuna voce.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedNone =>
      'Tutti i tuoi pennarelli sono in una voce.';

  @override
  String get diaryStatsUnusedNoCollection =>
      'Aggiungi i tuoi pennarelli in La mia collezione per vedere quali non hai usato.';

  @override
  String get diaryStatsUnusedShow => 'Mostra l’elenco';

  @override
  String get diaryStatsUnusedHide => 'Nascondi l’elenco';

  @override
  String get diaryStatsPalettesTitle => 'Palette che colleghi di più';

  @override
  String get diaryStatsPalettesEmpty =>
      'Nessuna voce collega ancora una palette salvata.';

  @override
  String diaryShareMore(int count) {
    return '+$count in più';
  }

  @override
  String get settingsLicences => 'Licenze open source';

  @override
  String get settingsLicencesSubtitle =>
      'Le licenze del codice, dei caratteri e dei pacchetti usati dall’app';

  @override
  String get settingsLicencesLegalese =>
      'Codice di Ink Lab: licenza MIT. Testi, idee e documentazione: CC BY-SA 4.0. Caratteri inclusi: licenza SIL Open Font 1.1.';

  @override
  String get settingsSendFeedback => 'Invia un commento';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Apre la tua app di posta con la versione dell’app e del sistema. Decidi tu se inviarla.';

  @override
  String settingsFeedbackNoMail(String address) {
    return 'Nessuna app di posta trovata. L’indirizzo $address è stato copiato.';
  }

  @override
  String get settingsErrorLogShare => 'Condividi il registro degli errori';

  @override
  String get settingsErrorLogShareSubtitle =>
      'Dettagli tecnici degli errori dell’app, senza il tuo diario né la tua chiave API. Non viene inviato nulla se non lo condividi.';

  @override
  String get settingsErrorLogClear => 'Cancella il registro degli errori';

  @override
  String get settingsErrorLogCleared =>
      'Il registro degli errori è stato cancellato';

  @override
  String get settingsErrorLogShareFailed =>
      'Impossibile condividere il registro degli errori';

  @override
  String settingsLastBackup(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Ultimo backup: $dateString';
  }

  @override
  String get settingsNoBackupYet => 'Ancora nessun backup';

  @override
  String get settingsBackupReminderNever =>
      'Hai dei dati nell’app ma nessun backup. Salva un file di backup per non perderli se cambi o ripristini il telefono.';

  @override
  String get settingsBackupReminderOld =>
      'Il tuo ultimo backup ha più di un mese. Salva un nuovo file per proteggere il tuo lavoro più recente.';

  @override
  String get collectionTouchTwinHint =>
      'Spunta i pennarelli Touch Twin che hai.';

  @override
  String get onboardingTouchTwinLine =>
      '202 colori · Spunta i pennarelli che hai';

  @override
  String get collectionPromarkerHint =>
      'Spunta i pennarelli Promarker che hai.';

  @override
  String get onboardingPromarkerLine =>
      '148 colori · Spunta i pennarelli che hai';

  @override
  String get collectionPrismacolorHint =>
      'Spunta i pennarelli Prismacolor Premier che hai.';

  @override
  String get onboardingPrismacolorLine =>
      '200 colori · Spunta i pennarelli che hai';

  @override
  String get collectionSpectrumNoirHint =>
      'Spunta i pennarelli Spectrum Noir che hai.';

  @override
  String get onboardingSpectrumNoirLine =>
      '216 colori · Spunta i pennarelli che hai';

  @override
  String get collectionPromarkerBrushHint =>
      'Spunta i pennarelli Promarker Brush che hai.';

  @override
  String get onboardingPromarkerBrushLine =>
      '72 colori · Spunta i pennarelli che hai';

  @override
  String get collectionArrtxHint => 'Spunta i pennarelli Arrtx che hai.';

  @override
  String get onboardingArrtxLine => '328 colori · Spunta i pennarelli che hai';

  @override
  String get collectionKurecolorHint =>
      'Spunta i pennarelli ZIG Kurecolor che hai.';

  @override
  String get onboardingKurecolorLine =>
      '136 colori · Spunta i pennarelli che hai';

  @override
  String get collectionGraphitHint => 'Spunta i pennarelli Graph\'it che hai.';

  @override
  String get onboardingGraphitLine =>
      '168 colori · Spunta i pennarelli che hai';

  @override
  String get collectionMarvyLePlumeHint =>
      'Spunta i pennarelli Marvy Le Plume che hai.';

  @override
  String get onboardingMarvyLePlumeLine =>
      '144 colori · Spunta i pennarelli che hai';

  @override
  String get collectionBlickBrushHint =>
      'Spunta i pennarelli Blick Studio Brush che hai.';

  @override
  String get onboardingBlickBrushLine =>
      '96 colori · Spunta i pennarelli che hai';

  @override
  String get collectionArtistsLoftHint =>
      'Spunta i pennarelli Artist\'s Loft che hai.';

  @override
  String get onboardingArtistsLoftLine =>
      '56 colori · Spunta i pennarelli che hai';

  @override
  String get shortcutMatchLabel => 'Abbina un colore';

  @override
  String get shortcutNewPaletteLabel => 'Nuova palette';

  @override
  String get shortcutSearchSwatchesLabel => 'Cerca campioni';

  @override
  String get brandSearchHint => 'Cerca una marca';

  @override
  String get brandGroupPopular => 'Popolari';

  @override
  String get brandGroupMore => 'Altre marche';

  @override
  String get brandSearchEmpty => 'Nessuna marca corrisponde alla tua ricerca.';

  @override
  String get brandGroupOwned => 'Le tue marche';

  @override
  String brandOwnedLine(int owned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      owned,
      locale: localeName,
      other: '$owned di $total posseduti',
      one: '1 di $total posseduto',
    );
    return '$_temp0';
  }

  @override
  String get navRailExpand => 'Espandi il menu';

  @override
  String get navRailCollapse => 'Comprimi il menu';

  @override
  String get inkLevelTitle => 'Livello d’inchiostro';

  @override
  String get inkLevelFull => 'Pieno';

  @override
  String get commonRunningOut => 'In esaurimento';

  @override
  String get refillNoteTitle => 'Nota di ricarica';

  @override
  String get refillNoteEmpty => 'Aggiungi una nota, come «ricaricato il 3 nov»';

  @override
  String get refillNoteHint => 'Ricaricato il 3 nov';

  @override
  String get refillNoteSave => 'Salva';

  @override
  String get refillNoteRemove => 'Rimuovi nota';

  @override
  String get swatchPhotoTitle => 'Campione reale';

  @override
  String get swatchPhotoEmpty => 'Aggiungi una foto del tuo campione su carta';

  @override
  String get swatchPhotoHas => 'Il tuo campione su carta';

  @override
  String get swatchPhotoView => 'Vedi foto';

  @override
  String get swatchPhotoTake => 'Scatta una foto';

  @override
  String get swatchPhotoChoose => 'Scegli dalla galleria';

  @override
  String get swatchPhotoSaved => 'Foto salvata';

  @override
  String get swatchPhotoSaveFailed =>
      'Non è stato possibile salvare la foto. Provane un’altra.';

  @override
  String get swatchPhotoRemoved => 'Foto rimossa';

  @override
  String get swatchShadowLightTitle => 'Ombra e luce';

  @override
  String get swatchShadow => 'Ombra';

  @override
  String get swatchLight => 'Luce';

  @override
  String get swatchShadowLightNone => 'Nessuno nella tua collezione';

  @override
  String get swatchBlendWith => 'Sfuma con…';

  @override
  String get swatchBlendTitle => 'Sfuma con';

  @override
  String get swatchBlendSearchHint => 'Cerca pennarelli';

  @override
  String get swatchBlendNoMarkers => 'Non hai altri pennarelli da sfumare.';

  @override
  String get swatchBlendNoResults =>
      'Nessun pennarello corrisponde alla ricerca.';

  @override
  String get swatchBlendSteps => 'Nel mezzo, dalla tua collezione';

  @override
  String get swatchBlendNothingBetween =>
      'Questi due sono abbastanza vicini da sfumare direttamente.';

  @override
  String get swatchBlendNoneBetween =>
      'Nessuno dei tuoi pennarelli sta nel mezzo.';

  @override
  String swatchBlendBuy(String code) {
    return 'Salto grande. Per colmarlo, il pennarello più vicino che non hai è $code.';
  }

  @override
  String swatchBlendStripSemantics(String from, String to) {
    return 'Sfumatura da $from a $to';
  }

  @override
  String swatchDuplicatesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hai già $count pennarelli molto simili a questo',
      one: 'Hai già 1 pennarello molto simile a questo',
    );
    return '$_temp0';
  }

  @override
  String get swatchDuplicatesHint =>
      'Quasi lo stesso colore: uno nuovo aggiunge poco.';

  @override
  String swatchDuplicatesMore(int count) {
    return 'e altri $count';
  }

  @override
  String get swatchDuplicatesNone =>
      'Niente nella tua collezione è molto simile: aggiungerebbe un colore nuovo.';

  @override
  String wishlistDuplicateNote(String codes) {
    return 'Molto simile a $codes nella tua collezione';
  }

  @override
  String wishlistRunningOutCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pennarelli in esaurimento',
      one: '1 pennarello in esaurimento',
      zero: 'Nessuno in esaurimento',
    );
    return '$_temp0';
  }

  @override
  String get wishlistRunningOutHint =>
      'Si usano ancora. Aggiungili alla lista quando vuoi comprarli o ricaricarli.';

  @override
  String swatchesAllBrands(int count) {
    return 'Tutte le marche ($count)';
  }

  @override
  String get swatchesOtherBrandsYours => 'Le tue marche';

  @override
  String get inkLevelFullNote =>
      'Pieno: Abbina, Palette e Idee possono suggerirlo.';

  @override
  String get inkLevelRunningOutNote =>
      'In esaurimento: si usa ancora ovunque. Compare nel gruppo «In esaurimento» della tua lista dei desideri.';

  @override
  String get swatchesDetailPaneEmpty =>
      'Tocca un pennarello per vederne qui i dettagli.';
}
