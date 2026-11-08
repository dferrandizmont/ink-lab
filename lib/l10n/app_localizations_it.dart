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
  String get swatchesClearSearch => 'Cancella la ricerca';

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
  String get swatchesLoadingSemantics => 'Caricamento colori';

  @override
  String get swatchesClosestAlternatives => 'Alternative più vicine';

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
    return 'Scegli un pennarello base, come $example, oppure una scena con il chip Scene.';
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
    return '$count finite';
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
    return 'Gli ultimi $count mesi.';
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
