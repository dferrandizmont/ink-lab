// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsCollectionGroup => 'Ma collection';

  @override
  String get settingsDisplayGroup => 'Affichage';

  @override
  String get settingsDataGroup => 'Tes données';

  @override
  String get settingsAiGroup => 'Assistant IA';

  @override
  String get settingsAiOffByDefault => 'Désactivé par défaut';

  @override
  String get settingsUnavailable =>
      'Les services de l’appli ne sont pas disponibles, les réglages ne peuvent pas s’afficher.';

  @override
  String get settingsBrandTitle => 'Marque';

  @override
  String get settingsBrandSubtitle =>
      'La marque détermine le catalogue de marqueurs avec lequel l’appli travaille.';

  @override
  String get settingsPalettesTitle => 'Palettes enregistrées';

  @override
  String get settingsClearPalettes => 'Tout effacer';

  @override
  String get settingsClearPalettesTitle =>
      'Supprimer toutes les palettes enregistrées ?';

  @override
  String get settingsClearPalettesBody =>
      'Les palettes enregistrées pour cette marque seront supprimées. Cette action est irréversible.';

  @override
  String get settingsFavoritesTitle => 'Favoris';

  @override
  String get settingsFavoritesEmpty =>
      'Aucune couleur en favori pour l’instant.';

  @override
  String get settingsClearFavorites => 'Tout effacer';

  @override
  String get settingsClearFavoritesTitle => 'Retirer tous les favoris ?';

  @override
  String get settingsClearFavoritesBody =>
      'Les couleurs favorites de cette marque seront retirées. Cette action est irréversible.';

  @override
  String get settingsDeleteFavorite => 'Retirer le favori';

  @override
  String get settingsLabelsTitle => 'Codes Ohuhu';

  @override
  String get settingsLabelsSubtitle => 'Ohuhu a changé ses codes en 2023.';

  @override
  String get settingsNewLabels => 'Récents';

  @override
  String get settingsOldLabels => 'Anciens';

  @override
  String get settingsBothLabels => 'Les deux';

  @override
  String get settingsAppearanceTitle => 'Apparence';

  @override
  String get settingsAppearanceSystem => 'Système';

  @override
  String get settingsAppearanceLight => 'Clair';

  @override
  String get settingsAppearanceDark => 'Sombre';

  @override
  String get settingsBackupSubtitle =>
      'Copie tes données (collection, palettes, journal, historique et réglages) dans le presse-papiers sous forme de texte, pour les réimporter plus tard. Sans les photos ni la clé d’API.';

  @override
  String get settingsExportBackup => 'Exporter';

  @override
  String get settingsImportBackup => 'Importer';

  @override
  String get settingsBackupExported =>
      'Sauvegarde copiée dans le presse-papiers, sans les photos';

  @override
  String get settingsBackupImported => 'Sauvegarde importée';

  @override
  String get settingsImportTitle => 'Importer une sauvegarde';

  @override
  String get settingsImportHint => 'Colle ici le JSON exporté';

  @override
  String get settingsImportConfirm => 'Importer';

  @override
  String get settingsCancel => 'Annuler';

  @override
  String get settingsImportConfirmTitle => 'Remplacer tes données actuelles ?';

  @override
  String get settingsImportConfirmBody =>
      'La sauvegarde remplace tes données actuelles : collection, palettes, journal, historique et réglages. Les entrées du journal qui n’y sont pas sont supprimées avec leurs photos ; les photos ne sont jamais dans une sauvegarde.';

  @override
  String get ideasFavoritesChip => 'Favoris';

  @override
  String get ideasFavoritesEmptyTitle => 'Aucune idée en favori';

  @override
  String get ideasFavoritesEmptyMessage =>
      'Touche le cœur d’une idée pour la garder ici.';

  @override
  String get ideasRecentTitle => 'Vues récemment';

  @override
  String get settingsBackupFileCaption =>
      'Un fichier ZIP avec tes données et toutes tes photos : journal, échantillons et recettes. Dans le menu de partage, choisis Fichiers, Drive ou une autre app pour le garder. La clé d’API n’y est jamais incluse.';

  @override
  String get settingsBackupTextTitle => 'Copier en texte (sans photos)';

  @override
  String get settingsSaveBackupFile => 'Partager la sauvegarde';

  @override
  String get settingsRestoreBackupFile => 'Restaurer depuis un fichier';

  @override
  String get settingsBackupFileSaving => 'Préparation des données et photos…';

  @override
  String get settingsBackupFileRestoring => 'Restauration de ta sauvegarde…';

  @override
  String get settingsRestoreConfirmBody =>
      'Le fichier remplace tes données actuelles : collection, palettes, journal, historique et réglages. Les photos du fichier sont aussi restaurées. Les entrées du journal qui n’y sont pas sont supprimées avec leurs photos.';

  @override
  String get settingsBackupFileRestored =>
      'Sauvegarde restaurée, photos comprises';

  @override
  String get settingsBackupFileSaveFailed =>
      'Impossible de créer le fichier de sauvegarde.';

  @override
  String get settingsBackupFileReadFailed => 'Impossible de lire le fichier.';

  @override
  String get settingsBackupFileNotZip =>
      'Ce fichier n’est pas une sauvegarde ZIP.';

  @override
  String get settingsBackupFileTooLarge =>
      'La sauvegarde est trop volumineuse pour Ink Lab.';

  @override
  String get settingsBackupFileEntryTooLarge =>
      'Une photo de la sauvegarde est trop volumineuse.';

  @override
  String get settingsBackupFileDamaged =>
      'Le fichier est endommagé ou n’est pas une sauvegarde Ink Lab.';

  @override
  String get settingsBackupFileUnsupported =>
      'Cette sauvegarde vient d’une version qu’Ink Lab ne sait pas lire.';

  @override
  String get settingsBackupFileNotAPhoto =>
      'Une photo du fichier n’est pas une image JPEG, PNG ou WebP.';

  @override
  String get settingsBackupFileWriteFailed =>
      'Impossible d’enregistrer les photos. Tes données n’ont pas changé.';

  @override
  String get settingsImportInvalidJson => 'Le texte n’est pas un JSON valide.';

  @override
  String get settingsImportInvalidDocument =>
      'Le texte n’est pas une sauvegarde.';

  @override
  String get settingsAiTitle => 'Assistant IA';

  @override
  String get settingsAiSubtitle =>
      'L’IA ne fait que suggérer des palettes. Elle ne modifie jamais ta collection.';

  @override
  String get settingsAiEnabled => 'Suggérer avec l’IA';

  @override
  String get settingsAiEnabledSubtitleColourTheory =>
      'Choisis Sur l’appareil ou OpenRouter ci-dessous pour utiliser une IA';

  @override
  String get settingsAiEnabledSubtitleColourTheoryNoOnDevice =>
      'Choisis OpenRouter ci-dessous pour utiliser une IA';

  @override
  String get settingsAiEnabledSubtitleOnDevice =>
      'Gemini Nano sur ce téléphone';

  @override
  String get settingsAiEnabledSubtitleOpenRouter =>
      'Utilise ta propre clé OpenRouter';

  @override
  String get settingsAiExplainColourTheory =>
      'Les palettes viennent du moteur de théorie des couleurs intégré. Pas d’IA, rien ne quitte ton téléphone.';

  @override
  String get settingsAiExplainOnDevice =>
      'Gemini Nano fonctionne sur ce téléphone et tes demandes y restent. ML Kit de Google envoie à Google des diagnostics d’utilisation.';

  @override
  String get settingsAiExplainOpenRouter =>
      'Les demandes partent vers openrouter.ai avec ta propre clé. Les photos ne sont jamais envoyées.';

  @override
  String get settingsAiProvider => 'Fournisseur';

  @override
  String get settingsAiProviderColourTheory => 'Théorie des couleurs';

  @override
  String get settingsAiProviderOnDevice => 'Sur l’appareil';

  @override
  String get settingsAiProviderOpenRouter => 'OpenRouter';

  @override
  String get settingsAiTextModel => 'Modèle de texte';

  @override
  String get settingsAiTextModelHint =>
      'ID du modèle pour les demandes de texte';

  @override
  String get settingsAiVisionModel => 'Modèle de vision';

  @override
  String get settingsAiVisionModelHint =>
      'ID du modèle pour les demandes avec image';

  @override
  String get settingsAiTemperature => 'Température';

  @override
  String get settingsAiMaxTokens => 'Tokens maximum';

  @override
  String get settingsAiAutoFallback => 'Repli intégré';

  @override
  String get settingsAiAutoFallbackSubtitle =>
      'Si l’IA échoue, le moteur intégré répond à sa place.';

  @override
  String get settingsAiApiKey => 'Clé d’API';

  @override
  String get settingsAiApiKeySubtitle =>
      'Ta propre clé, conservée dans le stockage sécurisé de cet appareil.';

  @override
  String get settingsAiApiKeySave => 'Enregistrer la clé';

  @override
  String get settingsAiApiKeyRemove => 'Retirer la clé';

  @override
  String get settingsAiApiKeySaved => 'Clé enregistrée.';

  @override
  String get settingsAiRemoveKeyTitle => 'Retirer la clé d’API ?';

  @override
  String get settingsAiRemoveKeyBody =>
      'La clé est supprimée de cet appareil. Les suggestions de l’IA s’arrêtent jusqu’à ce que tu saisisses une clé.';

  @override
  String get settingsAiRemoveKeyConfirm => 'Retirer';

  @override
  String get settingsAiApiKeyInvalid =>
      'Cela ne ressemble pas à une clé OpenRouter. Elle doit commencer par sk-or- et ne pas contenir d’espaces.';

  @override
  String get settingsAiApiKeyUnreadable =>
      'Impossible de lire ta clé enregistrée. Saisis-la de nouveau.';

  @override
  String get settingsAiApiKeyStorageError =>
      'Impossible d’enregistrer la clé. Réessaie.';

  @override
  String get settingsAiDisclosureTitle => 'Activer les suggestions de l’IA ?';

  @override
  String get settingsAiDisclosure =>
      'Si cette option est activée et que tu demandes une suggestion à OpenRouter, l’appli envoie à openrouter.ai et au fournisseur du modèle, avec ta propre clé d’API : la marque, le mode de palette et la scène, le code et le nom du marqueur de base et s’il est verrouillé, la taille de la palette, les codes et les couleurs hex des marqueurs candidats, les réglages du modèle et les instructions fixes de l’appli. Les photos ne sont jamais envoyées : cette fonction ne transmet aucune image. Sur Android, l’appli peut aussi demander à ML Kit de Google si Gemini Nano est disponible ; ML Kit envoie à Google des diagnostics d’utilisation. Rien n’est envoyé tant que cet interrupteur est désactivé.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'Avec Théorie des couleurs sélectionnée, les palettes viennent du moteur intégré : aucune IA n’est utilisée et rien ne quitte ton téléphone. Sur Android, l’appli peut demander à ML Kit de Google si Gemini Nano est disponible ; ML Kit envoie à Google des diagnostics d’utilisation, jamais tes couleurs ni tes photos. Choisis Sur l’appareil ou OpenRouter pour utiliser une IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'Avec Théorie des couleurs sélectionnée, les palettes viennent du moteur intégré : aucune IA n’est utilisée et rien ne quitte ton téléphone. Sur Android, l’appli peut demander à ML Kit de Google si Gemini Nano est disponible ; ML Kit envoie à Google des diagnostics d’utilisation, jamais tes couleurs ni tes photos. Choisis OpenRouter pour utiliser une IA.';

  @override
  String get settingsAiDisclosureConfirm => 'Activer';

  @override
  String get settingsAiDisclosureCancel => 'Pas maintenant';

  @override
  String get settingsAiDisclosureOnDevice =>
      'Les demandes Sur l’appareil (Gemini Nano) sont traitées par le modèle de ce téléphone : ton scénario et tes codes couleur ne le quittent jamais, et aucune clé n’est nécessaire. Pour vérifier, télécharger et utiliser le modèle, l’appli s’appuie sur ML Kit de Google, qui envoie à Google des diagnostics d’utilisation (modèle du téléphone, version de l’appli, identifiants d’installation, erreurs et tailles), jamais tes demandes, tes couleurs ni tes photos. Rien n’est envoyé tant que cet interrupteur est désactivé.';

  @override
  String get settingsAiOnDeviceName => 'Sur l’appareil (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Tes demandes restent sur ce téléphone. ML Kit envoie à Google des diagnostics d’utilisation, jamais tes demandes, tes couleurs ni tes photos.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'Le modèle n’est pas encore sur ce téléphone. Android le télécharge une fois et le garde pour toutes les applis.';

  @override
  String get settingsAiOnDeviceDownloading => 'Téléchargement du modèle...';

  @override
  String get settingsAiOnDevicePreparing =>
      'Android prépare le modèle. Cela peut prendre du temps et attendre le Wi‑Fi et la charge. Tu peux quitter cet écran ; le téléchargement continue en arrière-plan.';

  @override
  String get settingsAiEnabledSubtitleOnDeviceIos =>
      'Apple Intelligence sur ce téléphone';

  @override
  String get settingsAiExplainOnDeviceIos =>
      'Le modèle d’Apple fonctionne sur ce téléphone et tes demandes y restent.';

  @override
  String get settingsAiDisclosureOnDeviceIos =>
      'Les demandes Sur l’appareil (Apple Intelligence) sont traitées par le modèle d’Apple sur ce téléphone : ton scénario et tes codes couleur ne le quittent jamais, et aucune clé n’est nécessaire. iOS installe et gère le modèle avec Apple Intelligence ; l’appli ne télécharge rien et n’utilise aucun autre service pour cela, donc rien n’est envoyé.';

  @override
  String get settingsAiOnDeviceNameIos => 'Sur l’appareil (Apple Intelligence)';

  @override
  String get settingsAiOnDevicePrivacyIos =>
      'Tes demandes restent sur ce téléphone. Rien n’est envoyé, ni tes demandes, ni tes couleurs, ni tes photos.';

  @override
  String get settingsAiOnDevicePreparingIos =>
      'iOS prépare le modèle d’Apple Intelligence. Cela peut prendre du temps. Tu peux quitter cet écran ; cela continue en arrière-plan.';

  @override
  String get settingsAiDisclosureIos =>
      'Si cette option est activée et que tu demandes une suggestion à OpenRouter, l’appli envoie à openrouter.ai et au fournisseur du modèle, avec ta propre clé d’API : la marque, le mode de palette et la scène, le code et le nom du marqueur de base et s’il est verrouillé, la taille de la palette, les codes et les couleurs hex des marqueurs candidats, les réglages du modèle et les instructions fixes de l’appli. Les photos ne sont jamais envoyées : cette fonction ne transmet aucune image. Rien n’est envoyé tant que cet interrupteur est désactivé.';

  @override
  String get settingsAiDisclosureColourTheoryIos =>
      'Avec Théorie des couleurs sélectionnée, les palettes viennent du moteur intégré : aucune IA n’est utilisée et rien ne quitte ton téléphone. Choisis Sur l’appareil ou OpenRouter pour utiliser une IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDeviceIos =>
      'Avec Théorie des couleurs sélectionnée, les palettes viennent du moteur intégré : aucune IA n’est utilisée et rien ne quitte ton téléphone. Choisis OpenRouter pour utiliser une IA.';

  @override
  String get settingsAiOnDeviceCheckAgain => 'Vérifier de nouveau';

  @override
  String get settingsAiOnDeviceReady => 'Le modèle est prêt sur ce téléphone.';

  @override
  String get settingsAiOnDeviceDownload => 'Télécharger le modèle';

  @override
  String get settingsAiOnDeviceFailed =>
      'Le téléchargement n’a pas abouti. Vérifie la connexion et réessaie.';

  @override
  String get settingsAiTestConnection => 'Tester la connexion';

  @override
  String get settingsAiTestingConnection => 'Test en cours...';

  @override
  String get settingsAiModelsTitle => 'Modèle';

  @override
  String get settingsAiModelsFilterFree => 'Gratuits';

  @override
  String get settingsAiModelsFilterPaid => 'Payants';

  @override
  String get settingsAiModelsFilterBoth => 'Les deux';

  @override
  String get settingsAiModelsLoad => 'Charger les modèles';

  @override
  String get settingsAiModelsEmpty => 'Aucun modèle ne correspond à ce filtre.';

  @override
  String get settingsAiModelsNeedsKey =>
      'Enregistre une clé pour charger les modèles d’OpenRouter.';

  @override
  String get settingsAiPrimaryModel => 'Modèle de texte';

  @override
  String get settingsAiModelNone => 'Non défini';

  @override
  String get settingsAiModelsPickerHint =>
      'Charge les modèles, puis choisis-les dans la liste.';

  @override
  String get settingsAiModelSearchHint => 'Rechercher des modèles';

  @override
  String get settingsAiModelFree => 'Gratuit';

  @override
  String get settingsAiModelPaid => 'Payant';

  @override
  String get settingsAiModelsDone => 'Terminé';

  @override
  String get settingsAiModelsNotLoaded =>
      'Charge d’abord les modèles, ou saisis un ID de modèle ci-dessus.';

  @override
  String get settingsAiRecommended => 'Recommandés';

  @override
  String get settingsAiFreeModelsNote =>
      'Les modèles gratuits peuvent être lents ou peu fiables. Les modèles recommandés sont peu coûteux et répondent de façon plus régulière.';

  @override
  String get settingsAiAllModels => 'Tous les modèles';

  @override
  String get settingsAiRecommendedDefault => 'Modèle recommandé par défaut';

  @override
  String get settingsAiFallbacksTitle => 'Modèles de secours';

  @override
  String get settingsAboutTitle => 'À propos';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsSourceCode => 'Code source';

  @override
  String get settingsPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get settingsCopyRepository => 'Copier le lien';

  @override
  String get settingsRepositoryCopied => 'Lien copié';

  @override
  String get settingsDisclaimer =>
      'Ink Lab est un projet communautaire indépendant : il n’est ni affilié aux marques de marqueurs présentées, ni approuvé ou sponsorisé par elles. Il utilise leurs codes, noms et valeurs de couleur uniquement comme données factuelles de référence.';

  @override
  String get paletteTitle => 'Palette';

  @override
  String get paletteBaseCodeLabel => 'Code du marqueur de base';

  @override
  String paletteBaseCodeHint(String first, String second) {
    return '$first ou $second';
  }

  @override
  String paletteBaseCodeHintOne(String code) {
    return '$code';
  }

  @override
  String get paletteScenarioToggle => 'Scènes';

  @override
  String get paletteTypeTitle => 'Type de palette';

  @override
  String get paletteTypeSheetTitle => 'Choisis le type de palette';

  @override
  String get paletteTypeTheoryGroup => 'Théorie des couleurs';

  @override
  String get paletteTypeScenesGroup => 'Scènes';

  @override
  String get paletteTypeScenesHint => 'Recettes toutes prêtes par sujet';

  @override
  String get paletteTypeDescRecommended => 'Équilibré pour ta base';

  @override
  String get paletteTypeDescComplementary => 'Teinte opposée, fort contraste';

  @override
  String get paletteTypeDescAnalogous => 'Teintes voisines, calme';

  @override
  String get paletteTypeDescSplitComplementary =>
      'Deux teintes autour de l’opposée';

  @override
  String get paletteTypeDescTriad => 'Trois teintes équidistantes';

  @override
  String get paletteTypeDescSquare => 'Quatre teintes équidistantes';

  @override
  String get paletteTypeDescRectangle => 'Deux paires complémentaires';

  @override
  String get paletteTypeDescMonochrome => 'Une teinte, du clair au foncé';

  @override
  String get paletteTypeDescShadow => 'Tons plus foncés pour ombrer';

  @override
  String get paletteTypeDescCustomPalette => 'À composer à la main';

  @override
  String get modeBlendingChain => 'Dégradé';

  @override
  String get paletteTypeDescBlendingChain => 'Du clair au foncé, prêt à fondre';

  @override
  String paletteChainResultTitle(int count) {
    return 'Dégradé ($count)';
  }

  @override
  String paletteChainStep(int step, String role) {
    return 'Étape $step · $role';
  }

  @override
  String get roleLightest => 'Le plus clair';

  @override
  String get roleLighter => 'Plus clair';

  @override
  String get roleDarker => 'Plus foncé';

  @override
  String get roleDarkest => 'Le plus foncé';

  @override
  String get paletteChainHint =>
      'Travaille du clair au foncé et chevauche chaque étape tant que l’encre est encore humide. Adoucis les jonctions avec le blender incolore si tu en as un.';

  @override
  String paletteChainShort(int count, int wanted) {
    return 'Seulement $count de tes marqueurs se fondent bien avec cette base, moins que les $wanted demandés.';
  }

  @override
  String get paletteChainNeedLighter =>
      'Pas encore de dégradé : il te faut un marqueur plus clair dans cette famille.';

  @override
  String get paletteChainNeedDarker =>
      'Pas encore de dégradé : il te faut un marqueur plus foncé dans cette famille.';

  @override
  String get paletteChainNeedBoth =>
      'Pas encore de dégradé : il te faut un marqueur plus clair et un plus foncé dans cette famille.';

  @override
  String get paletteChainBaseLightest =>
      'Tu n’as rien de plus clair dans cette famille : le dégradé commence à ta base.';

  @override
  String get paletteChainBaseDarkest =>
      'Tu n’as rien de plus foncé dans cette famille : le dégradé se termine à ta base.';

  @override
  String get paletteChainOptionsLabel => 'Autres dégradés';

  @override
  String paletteChainOption(int number) {
    return 'Option $number';
  }

  @override
  String get paletteChainWholeRange => 'Chercher dans toute la gamme';

  @override
  String paletteChainWholeRangeNote(String brand) {
    return 'Toute la gamme $brand s’affiche, y compris les marqueurs que tu n’as pas.';
  }

  @override
  String get paletteChainMyMarkers => 'Retour à mes marqueurs';

  @override
  String get palettePaintTipChainFirst =>
      'Couvre d’abord toute la zone avec la couleur la plus claire.';

  @override
  String get palettePaintTipChainMiddle =>
      'Chevauche l’étape précédente tant qu’elle est encore humide.';

  @override
  String get palettePaintTipChainLast =>
      'Termine avec le plus foncé, seulement là où tombe l’ombre.';

  @override
  String get swatchesBlendingChain => 'Dégradé';

  @override
  String paletteTypeSemantic(String value) {
    return 'Type de palette, $value';
  }

  @override
  String get paletteSceneTitle => 'Scène';

  @override
  String get paletteSceneSheetTitle => 'Choisis une scène';

  @override
  String get paletteSceneSearchHint => 'Scène ou catégorie';

  @override
  String get paletteSceneEmpty => 'Aucune scène ne correspond à ta recherche.';

  @override
  String paletteSceneSemantic(String value) {
    return 'Scène, $value';
  }

  @override
  String get paletteFromPhotoTitle => 'À partir d’une photo';

  @override
  String get paletteFromPhotoHint => 'Ta photo, avec tes marqueurs';

  @override
  String get paletteFromPhotoValue => 'Ta photo';

  @override
  String paletteFromPhotoRole(int percent) {
    return 'Couleur de la photo · $percent %';
  }

  @override
  String get paletteFromPhotoEmpty =>
      'Impossible d’extraire des couleurs de cette photo';

  @override
  String get paletteFromPhotoFarNote =>
      'Certaines couleurs de la photo n’ont aucun marqueur proche dans ta collection';

  @override
  String get sceneCategoryCharacters => 'Personnages';

  @override
  String get sceneCategorySkin => 'Peau et portraits';

  @override
  String get sceneCategorySkyWater => 'Ciel et eau';

  @override
  String get sceneCategoryNature => 'Nature';

  @override
  String get sceneCategoryMaterials => 'Matières';

  @override
  String get sceneCategoryAnimals => 'Animaux et pelage';

  @override
  String get sceneCategoryFood => 'Nourriture';

  @override
  String get sceneCategoryHolidays => 'Fêtes et ambiances';

  @override
  String get sceneCategoryInteriors => 'Intérieurs';

  @override
  String get sceneCategoryPatterns => 'Motifs';

  @override
  String get sceneCategoryFantasy => 'Fantasy';

  @override
  String get paletteSizeTitle => 'Taille';

  @override
  String get paletteSizeSemantic => 'Taille de la palette';

  @override
  String get paletteGenerateButton => 'Générer';

  @override
  String get paletteRegenerateButton => 'Régénérer';

  @override
  String get paletteClearButton => 'Effacer';

  @override
  String get paletteSuggestAiButton => 'Suggérer avec l’IA';

  @override
  String get paletteSuggestAiLoading => 'Suggestion…';

  @override
  String get paletteAiBadge => 'IA';

  @override
  String get paletteSaveButton => 'Enregistrer la palette';

  @override
  String get paletteSavedButton => 'Palette enregistrée';

  @override
  String get paletteShareButton => 'Partager';

  @override
  String get shareFailed => 'Impossible de partager l’image.';

  @override
  String get paletteOkButton => 'OK';

  @override
  String get paletteBaseMarkerTitle => 'Marqueur de base';

  @override
  String get paletteVariationsLabel => 'Variantes';

  @override
  String get palettePaintPlanTitle => 'Ordre de peinture';

  @override
  String get palettePaintTipBase =>
      'Couvre d’abord la forme générale avec la couleur de base.';

  @override
  String get palettePaintTipShadow =>
      'Pose cette ombre là où la lumière n’arrive pas.';

  @override
  String get palettePaintTipHighlight =>
      'Place la lumière là où elle frappe directement.';

  @override
  String get palettePaintTipAccent => 'Réserve l’accent aux zones centrales.';

  @override
  String get palettePaintTipSupport =>
      'Utilise ce ton d’appui pour adoucir les transitions.';

  @override
  String get paletteSubtitleIdle =>
      'Crée une palette à partir d’un marqueur que tu possèdes';

  @override
  String get paletteLockButton => 'Verrouiller';

  @override
  String get paletteUnlockButton => 'Déverrouiller';

  @override
  String get paletteSaveDialogTitle => 'Enregistrer la palette';

  @override
  String get paletteSaveDialogHint => 'Nom de la palette';

  @override
  String get paletteSaveDialogCancel => 'Annuler';

  @override
  String get paletteSaveDialogConfirm => 'Enregistrer';

  @override
  String get paletteSavedTitle => 'Palettes enregistrées';

  @override
  String get paletteSavedEmpty =>
      'Aucune palette enregistrée pour cette marque.';

  @override
  String palettePaintPlanSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count étapes',
      one: '1 étape',
    );
    return '$_temp0';
  }

  @override
  String get paletteLoadButton => 'Charger';

  @override
  String get paletteDeleteButton => 'Supprimer';

  @override
  String get paletteDeleteDialogTitle => 'Supprimer la palette ?';

  @override
  String get paletteDeleteDialogBody => 'Cette action est irréversible.';

  @override
  String get paletteAiReportButton => 'Signaler cette suggestion';

  @override
  String get paletteAiReportTitle => 'Signaler cette suggestion';

  @override
  String get paletteAiReportBody =>
      'Dis-nous si l’IA a écrit quelque chose d’offensant, d’inapproprié ou d’erroné. Ton appli de messagerie s’ouvrira avec le texte de la suggestion ; c’est toi qui décides de l’envoyer ou non. Ta clé d’API n’est jamais incluse.';

  @override
  String get paletteAiReportOffensive => 'Offensante ou inappropriée';

  @override
  String get paletteAiReportWrong => 'Erronée ou absurde';

  @override
  String get paletteAiReportOther => 'Autre chose';

  @override
  String get paletteAiReportSend => 'Envoyer par e-mail';

  @override
  String get paletteAiReportThanks =>
      'Merci, cela nous aide à améliorer les suggestions';

  @override
  String get paletteAiReportCopied =>
      'Aucune appli de messagerie trouvée. Le signalement a été copié : colle-le dans un e-mail à inklab@mainshai.com';

  @override
  String get paletteAiFellBack =>
      'IA indisponible. Affichage de suggestions locales.';

  @override
  String get paletteEmptyHint =>
      'Choisis un marqueur de base pour créer une palette, ou sélectionne Scènes comme type de palette.';

  @override
  String get paletteCustomModeHint =>
      'Le mode palette personnalisée est manuel : charge une palette enregistrée ou applique-en une depuis Idées.';

  @override
  String get paletteNoSuggestions =>
      'Impossible de créer une palette avec ta collection. Essaie un autre mode ou ajoute des marqueurs.';

  @override
  String get paletteScenarioTitle => 'Scènes';

  @override
  String get palettePickBaseTooltip => 'Choisir parmi tes marqueurs';

  @override
  String get palettePickerTitle => 'Choisis le marqueur de base';

  @override
  String get palettePickerSearchHint => 'Code ou nom';

  @override
  String get palettePickerEmpty =>
      'Aucun marqueur ne correspond à ta recherche.';

  @override
  String get paletteUndoButton => 'Annuler';

  @override
  String paletteBaseReplaced(String code) {
    return '$code est maintenant la base. Ta palette précédente a été remplacée.';
  }

  @override
  String paletteIdeaApplied(String title, int count) {
    return 'Palette « $title » appliquée ($count marqueurs).';
  }

  @override
  String get swatchesTitle => 'Nuanciers';

  @override
  String get swatchesSearchHint => 'Code, nom ou hex';

  @override
  String swatchesClosestTo(String hex) {
    return 'Les plus proches de $hex';
  }

  @override
  String get swatchesClearSearch => 'Effacer la recherche';

  @override
  String get swatchesAllFilter => 'Tous';

  @override
  String get swatchesFavoritesOnly => 'Favoris';

  @override
  String get swatchesOwnedOnly => 'Les miens';

  @override
  String get swatchesFilters => 'Filtres';

  @override
  String get swatchesFiltersTitle => 'Filtres';

  @override
  String get swatchesLabelPack => 'Coffret';

  @override
  String get swatchesLabelLayout => 'Vue';

  @override
  String get swatchesAllPacks => 'Tous les coffrets';

  @override
  String get swatchesClearFilters => 'Retirer les filtres';

  @override
  String get swatchesClearSearchAndFilters => 'Effacer recherche et filtres';

  @override
  String get swatchesLoadingSemantics => 'Chargement des couleurs';

  @override
  String get swatchesClosestAlternatives => 'Alternatives proches';

  @override
  String get swatchesNoCloseAlternatives => 'Aucune alternative proche';

  @override
  String get swatchesInPacks => 'Dans les coffrets';

  @override
  String get swatchesLocation => 'Emplacement';

  @override
  String get swatchesAddToPalette => 'Ajouter à la palette';

  @override
  String get swatchesLayoutGrid => 'Grille';

  @override
  String get swatchesLayoutList => 'Liste';

  @override
  String get swatchesOwned => 'Possédé';

  @override
  String get swatchesNewLabels => 'Récent';

  @override
  String get swatchesOldLabels => 'Ancien';

  @override
  String get swatchesBothLabels => 'Les deux';

  @override
  String get swatchesLabelMode => 'Noms';

  @override
  String get swatchesToggleLayout => 'Basculer entre la grille et la liste';

  @override
  String get swatchesGridLayout => 'Grille';

  @override
  String get swatchesListLayout => 'Liste';

  @override
  String get swatchesNewCode => 'Nouveau code';

  @override
  String get swatchesOldCode => 'Ancien code';

  @override
  String get swatchesNewName => 'Nouveau nom';

  @override
  String get swatchesOldName => 'Ancien nom';

  @override
  String get swatchesHex => 'Hex';

  @override
  String get swatchesCopyHex => 'Copier l’hex';

  @override
  String get swatchesHexCopied => 'Hex copié dans le presse-papiers';

  @override
  String get swatchesAddFavorite => 'Ajouter aux favoris';

  @override
  String get swatchesRemoveFavorite => 'Retirer des favoris';

  @override
  String get swatchesEmptyNoOwnedTitle => 'Pas encore de marqueurs';

  @override
  String get swatchesEmptyNoOwnedBody =>
      'Tu n’as pas encore ajouté de marqueurs. Indique à l’appli quels coffrets et marqueurs tu possèdes.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Configurer ma collection';

  @override
  String get swatchesEmptyNoOwnedHint => 'Ouvre Réglages, puis Ma collection.';

  @override
  String get swatchesEmptySearchTitle => 'Aucune couleur trouvée';

  @override
  String get swatchesEmptySearchBody =>
      'Aucune couleur de cette collection ne correspond à ta recherche.';

  @override
  String get swatchesEmptyFiltersTitle => 'Rien à afficher';

  @override
  String get swatchesEmptyFiltersBody =>
      'Cette marque n’a aucune couleur pour les coffrets et filtres sélectionnés.';

  @override
  String get swatchesEmptyNoFavoritesTitle => 'Pas encore de favoris';

  @override
  String get swatchesEmptyNoFavoritesBody =>
      'Touche l’étoile dans la fiche d’une couleur pour l’ajouter.';

  @override
  String get swatchesEmptyNoFavoritesAction => 'Voir toutes les couleurs';

  @override
  String get swatchesEmptyFavoritesNotMineTitle =>
      'Aucun favori dans ta collection';

  @override
  String get swatchesEmptyFavoritesNotMineBody =>
      'Aucun de tes favoris n’est un marqueur que tu possèdes.';

  @override
  String get swatchesEmptyFavoritesNotMineAction => 'Voir tous les favoris';

  @override
  String get swatchesLoading => 'Chargement des couleurs…';

  @override
  String get swatchesLoadFailedTitle => 'Couleurs indisponibles';

  @override
  String get swatchesLoadFailedBody =>
      'Impossible de lire le catalogue de marqueurs, aucune couleur ne peut s’afficher.';

  @override
  String get swatchesUnavailable =>
      'Les services de l’appli ne sont pas disponibles, les nuanciers ne peuvent pas s’afficher.';

  @override
  String get swatchesVisibleCount => 'Couleurs';

  @override
  String get swatchesScopeCollection => 'Ta collection';

  @override
  String get swatchesScopePack => 'Coffret';

  @override
  String get ideasTitle => 'Idées';

  @override
  String get ideasHeaderSubtitle => 'Exercices avec tes marqueurs';

  @override
  String get ideasHeaderSubtitleWholeRange =>
      'Des exercices avec une palette tirée de toute la gamme';

  @override
  String get ideasSearchHint => 'Chercher des idées';

  @override
  String get ideasCategoryAll => 'Toutes';

  @override
  String get ideasApplyButton => 'Utiliser dans Palette';

  @override
  String get ideasMoreDetails => 'Plus de détails';

  @override
  String get ideasGuideOnlyNote =>
      'Cet exercice utilise toute ta collection, il n’a donc pas de palette fixe.';

  @override
  String get ideasNoMarkersOther =>
      'Ajoute dans Ma collection les marqueurs que tu possèdes pour obtenir une palette pour cette idée.';

  @override
  String get ideasCategoriesLabel => 'Catégories';

  @override
  String get ideasEmptyTitle => 'Aucune idée trouvée';

  @override
  String get ideasClearFilters => 'Retirer les filtres';

  @override
  String get ideasEmptySearch => 'Aucune idée ne correspond à ta recherche.';

  @override
  String get ideasNoMarkers => 'Aucun marqueur disponible pour le moment';

  @override
  String get ideasTulipFieldTitle => 'Champ de tulipes';

  @override
  String get ideasTulipFieldSummary =>
      'Des rangs de tulipes rouges et jaunes jusqu’à l’horizon, avec du vert printanier entre eux.';

  @override
  String get ideasTulipFieldPractice =>
      'Des bandes plates qui se brisent en points en se rapprochant.';

  @override
  String get ideasTulipFieldSubject =>
      'Des rangs de tulipes vus d’en bas, avec un horizon bas.';

  @override
  String get ideasTulipFieldTip =>
      'Le rang le plus proche est fait de points, le plus lointain est une bande : change la marque à mesure que le rang s’éloigne.';

  @override
  String get ideasTulipFieldStep1 =>
      'Dessine au crayon des rangs qui se resserrent vers un horizon bas.';

  @override
  String get ideasTulipFieldStep2 =>
      'Du rouge dans les premiers rangs : des taches isolées près de toi, une bande pleine plus loin.';

  @override
  String get ideasTulipFieldStep3 =>
      'Du jaune dans les rangs suivants, de la même façon.';

  @override
  String get ideasTulipFieldStep4 =>
      'Du vert clair entre les rangs et le long de l’horizon.';

  @override
  String get ideasTulipFieldStep5 =>
      'Un vert plus foncé en trait fin au pied de chaque rang.';

  @override
  String get ideasSummerBeachTitle => 'À la plage';

  @override
  String get ideasSummerBeachSummary =>
      'Du sable, une bande de mer, un parasol : trois bandes plates et un accent vif.';

  @override
  String get ideasSummerBeachPractice =>
      'Trois bandes plates et un seul accent qui guide le regard.';

  @override
  String get ideasSummerBeachSubject =>
      'Une plage vue depuis le sable, avec un parasol.';

  @override
  String get ideasSummerBeachTip =>
      'Laisse l’écume en papier : c’est la ligne la plus claire de la mer.';

  @override
  String get ideasSummerBeachStep1 =>
      'Dessine au crayon trois bandes horizontales (ciel, mer, sable) et un parasol dans le sable.';

  @override
  String get ideasSummerBeachStep2 =>
      'Du sable pâle, d’une main très légère ; laisse le sable mouillé près de l’eau plus clair.';

  @override
  String get ideasSummerBeachStep3 =>
      'Un turquoise clair pour la mer, avec une ligne de papier pour l’écume.';

  @override
  String get ideasSummerBeachStep4 => 'Un turquoise plus profond à l’horizon.';

  @override
  String get ideasSummerBeachStep5 =>
      'Le parasol rouge et sa petite ombre sur le sable, faite avec une deuxième couche de la couleur du sable.';

  @override
  String get ideasWatermelonSliceTitle => 'Pastèque';

  @override
  String get ideasWatermelonSliceSummary =>
      'Une tranche de pastèque : chair rouge, écorce blanche, peau verte, pépins noirs.';

  @override
  String get ideasWatermelonSlicePractice =>
      'Un dégradé rapide et une bande plate, avec l’écorce blanche laissée en papier.';

  @override
  String get ideasWatermelonSliceSubject =>
      'Une tranche triangulaire de pastèque avec une base courbe.';

  @override
  String get ideasWatermelonSliceTip =>
      'L’écorce blanche, c’est le papier : ne la colore pas du tout.';

  @override
  String get ideasWatermelonSliceStep1 =>
      'Dessine au crayon un triangle à base courbe et une fine bande blanche dans le vert.';

  @override
  String get ideasWatermelonSliceStep2 =>
      'Le rouge clair sur la chair, plus pâle près de l’écorce.';

  @override
  String get ideasWatermelonSliceStep3 =>
      'Un rouge plus profond vers la pointe, fondu pendant que c’est humide.';

  @override
  String get ideasWatermelonSliceStep4 =>
      'Du vert sur la peau, avec des rayures vert foncé en deuxième couche.';

  @override
  String get ideasWatermelonSliceStep5 =>
      'Les pépins au feutre fin, chacun en petite goutte.';

  @override
  String get ideasForestMushroomsTitle => 'Champignons en forêt';

  @override
  String get ideasForestMushroomsSummary =>
      'Un groupe de champignons parmi des feuilles brunes en automne.';

  @override
  String get ideasForestMushroomsPractice =>
      'Des chapeaux ronds avec de petits dégradés et un sol sec fait de traits libres.';

  @override
  String get ideasForestMushroomsSubject =>
      'Trois champignons de hauteurs différentes parmi des feuilles tombées.';

  @override
  String get ideasForestMushroomsTip =>
      'Le sol de la forêt demande des traits bruns libres et brisés, pas des aplats.';

  @override
  String get ideasForestMushroomsStep1 =>
      'Dessine au crayon trois champignons de hauteurs différentes et quelques feuilles autour.';

  @override
  String get ideasForestMushroomsStep2 =>
      'Un beige pâle sur les pieds et sous les chapeaux.';

  @override
  String get ideasForestMushroomsStep3 =>
      'Le brun-rouge sur les chapeaux, plus foncé au bord.';

  @override
  String get ideasForestMushroomsStep4 => 'Du brun sur les feuilles et le sol.';

  @override
  String get ideasForestMushroomsStep5 =>
      'Le plus foncé sous les chapeaux et là où les pieds touchent le sol ; des points de stylo gel blanc sur les chapeaux si tu veux.';

  @override
  String get ideasHarvestBasketTitle => 'Panier de récolte';

  @override
  String get ideasHarvestBasketSummary =>
      'Des pommes, une poire et une petite courge dans un panier, chacune d’une couleur différente, ombrées avec un seul gris.';

  @override
  String get ideasHarvestBasketPractice =>
      'Un seul gris pour ombrer trois couleurs fortes afin qu’elles s’accordent.';

  @override
  String get ideasHarvestBasketSubject =>
      'Un panier plein de fruits : des pommes, une poire et une courge.';

  @override
  String get ideasHarvestBasketTip =>
      'Ombre tous les fruits avec le même gris. C’est ce qui tient ensemble une nature morte chargée.';

  @override
  String get ideasHarvestBasketStep1 =>
      'Dessine au crayon le panier et les fruits qui se chevauchent.';

  @override
  String get ideasHarvestBasketStep2 =>
      'Du rouge pour les pommes, avec la brillance laissée en papier.';

  @override
  String get ideasHarvestBasketStep3 => 'Du jaune-vert pour la poire.';

  @override
  String get ideasHarvestBasketStep4 =>
      'De l’orange pour la courge, avec ses côtes en lignes plus foncées en deuxième couche.';

  @override
  String get ideasHarvestBasketStep5 =>
      'Le même gris pour chaque ombre et l’intérieur du panier.';

  @override
  String get ideasHarvestBasketStep6 =>
      'Le marqueur le plus foncé pour les lignes du tressage du panier.';

  @override
  String get ideasHotChocolateTitle => 'Chocolat chaud';

  @override
  String get ideasHotChocolateSummary =>
      'Une tasse de chocolat avec de la vapeur, une guimauve et une moufle rouge.';

  @override
  String get ideasHotChocolatePractice =>
      'Des bruns chauds, un accent rouge et de la vapeur soulevée du fond.';

  @override
  String get ideasHotChocolateSubject =>
      'Une tasse de chocolat chaud avec une guimauve et une moufle à côté.';

  @override
  String get ideasHotChocolateTip =>
      'La vapeur, c’est soit du papier, soit une forme soulevée avec le blender, jamais un trait dessiné.';

  @override
  String get ideasHotChocolateStep1 =>
      'Dessine au crayon la tasse, la surface de la boisson, une guimauve et une moufle posée contre la tasse.';

  @override
  String get ideasHotChocolateStep2 =>
      'Un brun pâle sur le côté éclairé de la tasse et sur l’ombre de la guimauve.';

  @override
  String get ideasHotChocolateStep3 =>
      'Du brun sur la surface de la boisson et sur le côté ombré de la tasse.';

  @override
  String get ideasHotChocolateStep4 => 'La moufle rouge, en deux couches.';

  @override
  String get ideasHotChocolateStep5 =>
      'La vapeur : soulève des volutes du fond avec le blender, ou laisse-les en papier.';

  @override
  String get ideasLunarNewYearTitle => 'Nouvel An lunaire';

  @override
  String get ideasLunarNewYearSummary =>
      'Des lanternes rouges aux liserés dorés sur un mur rouge.';

  @override
  String get ideasLunarNewYearPractice =>
      'Une seule famille de rouges en trois étapes et un accent doré plat.';

  @override
  String get ideasLunarNewYearSubject =>
      'Trois lanternes rondes suspendues à des hauteurs différentes, avec des glands.';

  @override
  String get ideasLunarNewYearTip =>
      'Pose l’or sur le rouge sec, jamais l’inverse.';

  @override
  String get ideasLunarNewYearStep1 =>
      'Dessine au crayon trois lanternes suspendues à des hauteurs différentes, avec des glands.';

  @override
  String get ideasLunarNewYearStep2 =>
      'Du rouge clair sur les lanternes, plus pâle du côté éclairé.';

  @override
  String get ideasLunarNewYearStep3 =>
      'Le rouge du côté ombré et des côtes, fondu pendant que c’est humide.';

  @override
  String get ideasLunarNewYearStep4 =>
      'Un rouge foncé entre les côtes et à l’intérieur des bords.';

  @override
  String get ideasLunarNewYearStep5 =>
      'Un jaune doré sur les bords, les capuchons et les glands, laissé net.';

  @override
  String get ideasDiwaliLampsTitle => 'Lampes de Diwali';

  @override
  String get ideasDiwaliLampsSummary =>
      'Une rangée de lampes en argile avec de petites flammes et un rangoli aux couleurs vives autour.';

  @override
  String get ideasDiwaliLampsPractice =>
      'Un motif plat et saturé à côté d’un dégradé en deux étapes sur les lampes.';

  @override
  String get ideasDiwaliLampsSubject =>
      'Cinq petites lampes en argile en courbe, avec un motif simple et symétrique autour.';

  @override
  String get ideasDiwaliLampsTip =>
      'Garde le motif plat, aux bords nets. C’est le contraste avec les lampes qui le fait fonctionner.';

  @override
  String get ideasDiwaliLampsStep1 =>
      'Dessine au crayon cinq petites lampes en courbe et un motif simple et symétrique autour.';

  @override
  String get ideasDiwaliLampsStep2 =>
      'De la terre cuite claire sur les lampes.';

  @override
  String get ideasDiwaliLampsStep3 =>
      'Une terre cuite plus profonde sur leur côté ombré.';

  @override
  String get ideasDiwaliLampsStep4 =>
      'Du jaune pour chaque flamme et une lueur sur le bord de chaque lampe.';

  @override
  String get ideasDiwaliLampsStep5 =>
      'Du magenta dans les sections alternées du motif, à plat et aux bords nets.';

  @override
  String get ideasDiwaliLampsStep6 =>
      'Du turquoise dans les autres sections, puis des points de stylo gel blanc sur les flammes si tu veux.';

  @override
  String get ideasHanukkahCandlesTitle => 'Hanoucca';

  @override
  String get ideasHanukkahCandlesSummary =>
      'Une menorah aux bougies allumées, bleue et blanche avec des flammes dorées.';

  @override
  String get ideasHanukkahCandlesPractice =>
      'Des formes blanches gardées en papier sur un fond bleu.';

  @override
  String get ideasHanukkahCandlesSubject =>
      'Une menorah aux bougies allumées devant un fond bleu.';

  @override
  String get ideasHanukkahCandlesTip =>
      'Les bougies, c’est du papier : colore autour et elles ressortent en blanc.';

  @override
  String get ideasHanukkahCandlesStep1 =>
      'Dessine au crayon la menorah et les bougies ; les bougies restent en papier.';

  @override
  String get ideasHanukkahCandlesStep2 => 'Un fond bleu clair tout autour.';

  @override
  String get ideasHanukkahCandlesStep3 =>
      'Un bleu plus profond aux bords de la page, fondu vers l’intérieur.';

  @override
  String get ideasHanukkahCandlesStep4 =>
      'Le bleu foncé pour la menorah elle-même.';

  @override
  String get ideasHanukkahCandlesStep5 =>
      'Des flammes jaunes et une lueur douce autour de chacune, puis un cœur de stylo gel blanc dans chaque flamme.';

  @override
  String get ideasPaintedEggsTitle => 'Œufs peints';

  @override
  String get ideasPaintedEggsSummary =>
      'Trois œufs décorés de rayures, de points et de zigzags dans des couleurs d’intensité moyenne.';

  @override
  String get ideasPaintedEggsPractice =>
      'Trois façons de faire un motif : papier, forme et deuxième couche.';

  @override
  String get ideasPaintedEggsSubject =>
      'Trois œufs, chacun avec un motif différent.';

  @override
  String get ideasPaintedEggsTip =>
      'Des couleurs d’intensité moyenne laissent voir une deuxième couche sans devenir boueuses.';

  @override
  String get ideasPaintedEggsStep1 =>
      'Dessine au crayon trois œufs et un motif différent sur chacun.';

  @override
  String get ideasPaintedEggsStep2 =>
      'Premier œuf : la couleur de base à plat, avec le motif laissé en papier.';

  @override
  String get ideasPaintedEggsStep3 =>
      'Deuxième œuf : remplis seulement les formes du motif, le reste reste en papier.';

  @override
  String get ideasPaintedEggsStep4 =>
      'Troisième œuf : colore-le, puis ajoute le motif de la même couleur en deuxième couche.';

  @override
  String get ideasPaintedEggsStep5 =>
      'Un gris pour le côté ombré de chaque œuf et la petite ombre dessous.';

  @override
  String get ideasDiaDeMuertosTitle => 'Día de Muertos';

  @override
  String get ideasDiaDeMuertosSummary =>
      'Des œillets d’Inde et un crâne décoré en orange, magenta et turquoise sur un fond sombre.';

  @override
  String get ideasDiaDeMuertosPractice =>
      'Un motif plat et saturé sur un fond sombre.';

  @override
  String get ideasDiaDeMuertosSubject =>
      'Un crâne décoré avec des fleurs autour des yeux et un massif d’œillets d’Inde en dessous.';

  @override
  String get ideasDiaDeMuertosTip =>
      'Pose le fond sombre en dernier et lentement : l’encre foncée coule dans les zones claires.';

  @override
  String get ideasDiaDeMuertosStep1 =>
      'Dessine au crayon un crâne avec des fleurs autour des yeux et un massif d’œillets d’Inde en dessous.';

  @override
  String get ideasDiaDeMuertosStep2 =>
      'De l’orange clair sur les œillets d’Inde, chacun en cercle approximatif.';

  @override
  String get ideasDiaDeMuertosStep3 =>
      'Un orange plus profond en petits traits dans chaque cercle pour les pétales.';

  @override
  String get ideasDiaDeMuertosStep4 =>
      'Du magenta pour les motifs du crâne, à plat et symétriques.';

  @override
  String get ideasDiaDeMuertosStep5 =>
      'Du turquoise pour l’autre moitié des motifs du crâne.';

  @override
  String get ideasDiaDeMuertosStep6 =>
      'Le marqueur le plus foncé pour les orbites et le fond, puis les détails au feutre fin.';

  @override
  String get ideasValentineCardTitle => 'Carte de Saint-Valentin';

  @override
  String get ideasValentineCardSummary =>
      'Une carte avec trois cœurs, du rose pâle au rouge profond, et un trait d’ombre qui les détache du papier.';

  @override
  String get ideasValentineCardPractice =>
      'Trois aplats et un trait d’ombre portée.';

  @override
  String get ideasValentineCardSubject =>
      'Trois cœurs qui se chevauchent, le plus grand derrière.';

  @override
  String get ideasValentineCardTip =>
      'Dessine l’ombre portée en un seul trait fin : elle détache le cœur sans ajouter de couleur.';

  @override
  String get ideasValentineCardStep1 =>
      'Dessine au crayon trois cœurs qui se chevauchent, le plus grand derrière.';

  @override
  String get ideasValentineCardStep2 => 'Du rose pâle sur le cœur du fond.';

  @override
  String get ideasValentineCardStep3 => 'Du rose sur celui du milieu.';

  @override
  String get ideasValentineCardStep4 =>
      'Du rouge sur celui de devant, et un trait fin de cette couleur sous les deux autres comme ombre portée.';

  @override
  String get ideasValentineCardStep5 =>
      'Une brillance au stylo gel blanc sur chaque cœur, en haut à gauche.';

  @override
  String get ideasCarnivalMaskTitle => 'Masque de carnaval';

  @override
  String get ideasCarnivalMaskSummary =>
      'Un masque à plumes en violet, turquoise et or.';

  @override
  String get ideasCarnivalMaskPractice =>
      'Des traits rapides pour les plumes, un dégradé pour le masque et de l’or à plat.';

  @override
  String get ideasCarnivalMaskSubject =>
      'Un demi-masque avec trois plumes qui montent d’un côté.';

  @override
  String get ideasCarnivalMaskTip =>
      'Fais des traits vers l’extérieur depuis la tige de la plume : le bord doux est ce qui les fait reconnaître comme des plumes.';

  @override
  String get ideasCarnivalMaskStep1 =>
      'Dessine au crayon un demi-masque et trois plumes qui montent d’un côté.';

  @override
  String get ideasCarnivalMaskStep2 =>
      'Du violet sur le masque, en deux couches là où il s’incurve.';

  @override
  String get ideasCarnivalMaskStep3 =>
      'Du turquoise sur les plumes, en traits rapides vers l’extérieur depuis la tige pour que les bords soient doux.';

  @override
  String get ideasCarnivalMaskStep4 =>
      'De l’or sur le bord du masque et le contour des yeux.';

  @override
  String get ideasCarnivalMaskStep5 =>
      'Le plus foncé dans les trous des yeux, puis des points de gel en guise de paillettes.';

  @override
  String get ideasMidsummerCrownTitle => 'Couronne de fleurs';

  @override
  String get ideasMidsummerCrownSummary =>
      'Une couronne de fleurs sauvages et de feuilles : bleu, jaune et rose sur du vert.';

  @override
  String get ideasMidsummerCrownPractice =>
      'Beaucoup de petites touches de la pointe fine sur une base verte sèche.';

  @override
  String get ideasMidsummerCrownSubject =>
      'Un anneau de feuilles avec trois sortes de petites fleurs sauvages.';

  @override
  String get ideasMidsummerCrownTip =>
      'Les touches de couleur sur une base sèche restent nettes. Attends que le vert sèche avant de commencer les fleurs.';

  @override
  String get ideasMidsummerCrownStep1 =>
      'Dessine au crayon un anneau de feuilles et de petites fleurs de trois sortes.';

  @override
  String get ideasMidsummerCrownStep2 =>
      'Du vert clair sur toutes les feuilles.';

  @override
  String get ideasMidsummerCrownStep3 =>
      'Un vert plus foncé là où les feuilles se chevauchent et en dessous.';

  @override
  String get ideasMidsummerCrownStep4 =>
      'Du bleu sur la première sorte de fleur.';

  @override
  String get ideasMidsummerCrownStep5 =>
      'Du jaune sur la deuxième sorte de fleur.';

  @override
  String get ideasMidsummerCrownStep6 =>
      'Du rose sur la troisième, avec une minuscule deuxième couche au centre de chaque fleur.';

  @override
  String get ideasEidNightTitle => 'Nuit de l’Aïd';

  @override
  String get ideasEidNightSummary =>
      'Un croissant de lune et une lanterne suspendue dans un ciel turquoise profond et violet.';

  @override
  String get ideasEidNightPractice =>
      'Un beau dégradé humide du turquoise au violet, avec de l’or par-dessus.';

  @override
  String get ideasEidNightSubject =>
      'Un croissant de lune et une lanterne ouvragée dans un ciel de nuit.';

  @override
  String get ideasEidNightTip =>
      'Fonds le turquoise dans le violet pendant que les deux sont humides. Une fois sec, le ciel reste propre.';

  @override
  String get ideasEidNightStep1 =>
      'Dessine au crayon le croissant et une lanterne ouvragée ; les deux restent en papier pour l’instant.';

  @override
  String get ideasEidNightStep2 =>
      'Du turquoise sur tout le ciel, plus clair près de la lune.';

  @override
  String get ideasEidNightStep3 => 'Un turquoise plus profond vers les bords.';

  @override
  String get ideasEidNightStep4 =>
      'Du violet fondu dans les coins du haut pendant que le turquoise est encore humide.';

  @override
  String get ideasEidNightStep5 =>
      'De l’or sur le croissant et le cadre de la lanterne ; les vitres restent pâles, puis des étoiles au stylo gel blanc.';

  @override
  String get ideasHoliColoursTitle => 'Holi';

  @override
  String get ideasHoliColoursSummary =>
      'Des nuages de poudre colorée sur du blanc : bords doux, centres francs, quatre couleurs vives.';

  @override
  String get ideasHoliColoursPractice =>
      'De la couleur sans bord : le blender dissout un bord dans le papier.';

  @override
  String get ideasHoliColoursSubject =>
      'Quatre nuages de poudre colorée qui se chevauchent sur du papier blanc.';

  @override
  String get ideasHoliColoursTip =>
      'Laisse sécher chaque nuage avant d’ajouter le suivant, sinon toutes les couleurs deviennent boueuses.';

  @override
  String get ideasHoliColoursStep1 =>
      'Griffonne un nuage libre avec la première couleur, dense au milieu.';

  @override
  String get ideasHoliColoursStep2 =>
      'Étire ses bords avec le blender dans le papier blanc jusqu’à ce qu’ils disparaissent.';

  @override
  String get ideasHoliColoursStep3 =>
      'Un deuxième nuage qui chevauche un peu le premier ; là où ils se rencontrent, laisse-les se mélanger.';

  @override
  String get ideasHoliColoursStep4 =>
      'Un troisième nuage, plus petit, dans un espace libre.';

  @override
  String get ideasHoliColoursStep5 =>
      'Un quatrième nuage dans le dernier espace libre, puis fais jaillir quelques points de chaque couleur tout autour.';

  @override
  String get ideasSummerIceCreamTitle => 'Glace';

  @override
  String get ideasSummerIceCreamSummary =>
      'Trois boules de parfums différents sur un cornet.';

  @override
  String get ideasSummerIceCreamPractice =>
      'Trois dégradés ronds et un seul gris qui les ombre toutes.';

  @override
  String get ideasSummerIceCreamSubject =>
      'Trois boules empilées sur un cornet à quadrillage gaufré.';

  @override
  String get ideasSummerIceCreamTip =>
      'Utilise le même gris pour chaque boule : c’est ce qui tient ensemble trois couleurs différentes.';

  @override
  String get ideasSummerIceCreamStep1 =>
      'Dessine au crayon un cornet à quadrillage gaufré et trois boules empilées.';

  @override
  String get ideasSummerIceCreamStep2 =>
      'Le premier parfum sur la boule du bas, avec une brillance de papier laissée dessus.';

  @override
  String get ideasSummerIceCreamStep3 =>
      'Le deuxième parfum sur la boule du milieu, avec sa propre brillance.';

  @override
  String get ideasSummerIceCreamStep4 =>
      'Le troisième parfum sur la boule du haut.';

  @override
  String get ideasSummerIceCreamStep5 =>
      'Le même gris clair sous chaque boule et là où elles se chevauchent.';

  @override
  String get ideasSummerIceCreamStep6 =>
      'Le cornet en beige, avec les lignes du quadrillage en deuxième couche.';

  @override
  String get ideasNewYearFireworksTitle => 'Feux d’artifice';

  @override
  String get ideasNewYearFireworksSummary =>
      'Trois bouquets de feux d’artifice dans un ciel sombre, chacun d’une couleur différente.';

  @override
  String get ideasNewYearFireworksPractice =>
      'Une couleur vive sur un fond sombre, avec les lignes laissées en papier.';

  @override
  String get ideasNewYearFireworksSubject =>
      'Trois bouquets de feux d’artifice avec des lignes de lumière qui partent de chaque centre.';

  @override
  String get ideasNewYearFireworksTip =>
      'Remplis le ciel autour des lignes, pas par-dessus : le papier blanc est ce qui fait briller les feux d’artifice.';

  @override
  String get ideasNewYearFireworksStep1 =>
      'Dessine au crayon trois centres et des lignes de lumière qui en rayonnent ; les lignes restent en papier pour l’instant.';

  @override
  String get ideasNewYearFireworksStep2 =>
      'Remplis le ciel en foncé en contournant les lignes avec la pointe fine (elles peuvent être irrégulières).';

  @override
  String get ideasNewYearFireworksStep3 =>
      'Repasse les lignes du premier bouquet avec la première couleur, en appuyant plus aux extrémités.';

  @override
  String get ideasNewYearFireworksStep4 =>
      'Les lignes du deuxième bouquet avec la deuxième couleur.';

  @override
  String get ideasNewYearFireworksStep5 =>
      'Les lignes du troisième bouquet avec la troisième couleur.';

  @override
  String get ideasNewYearFireworksStep6 =>
      'Du stylo gel blanc au centre de chaque bouquet et quelques étincelles aux extrémités.';

  @override
  String get ideasCozyLampTitle => 'Coin douillet';

  @override
  String get ideasCozyLampSummary =>
      'Un fauteuil sous une lampe le soir : une flaque de lumière chaude et des ombres brunes douces.';

  @override
  String get ideasCozyLampPractice =>
      'Planifier une zone éclairée et laisser le reste de la pièce tomber dans un brun chaud.';

  @override
  String get ideasCozyLampSubject =>
      'Un fauteuil, un lampadaire et un mur derrière eux.';

  @override
  String get ideasCozyLampTip =>
      'Garde le brun le plus foncé hors du cercle de lumière : la lampe n’atteint aucun coin.';

  @override
  String get ideasCozyLampStep1 =>
      'Dessine au crayon le fauteuil, la lampe et le cercle de lumière qu’elle pose au sol et sur le mur.';

  @override
  String get ideasCozyLampStep2 =>
      'Remplis le cercle de lumière avec le jaune pâle et estompe-le avec le blender incolore.';

  @override
  String get ideasCozyLampStep3 =>
      'Colore le reste de la pièce avec le beige chaud clair, en aplat et bien égal.';

  @override
  String get ideasCozyLampStep4 =>
      'Mets le brun chaud sur le fauteuil et sur le côté de la pièce éloigné de la lampe.';

  @override
  String get ideasCozyLampStep5 =>
      'Utilise le brun foncé dans les coins et sous le fauteuil, et garde-le hors du cercle de lumière.';

  @override
  String get ideasFoggyMorningTitle => 'Brouillard';

  @override
  String get ideasFoggyMorningSummary =>
      'Des arbres qui disparaissent dans le brouillard : les plus proches plus foncés, les plus lointains plus pâles.';

  @override
  String get ideasFoggyMorningPractice =>
      'De la profondeur avec un voile clair sur des formes sombres.';

  @override
  String get ideasFoggyMorningSubject =>
      'Trois rangées d’arbres le long d’une route, chacune plus loin.';

  @override
  String get ideasFoggyMorningTip =>
      'Un voile clair sur une forme sombre, c’est le brouillard le plus simple : l’encre du dessous reste.';

  @override
  String get ideasFoggyMorningStep1 =>
      'Dessine au crayon trois rangées d’arbres, chacune plus loin, et marque où commence le sol.';

  @override
  String get ideasFoggyMorningStep2 =>
      'Colore la rangée la plus lointaine avec le marqueur le plus pâle seulement, sans aucun détail.';

  @override
  String get ideasFoggyMorningStep3 =>
      'Colore la rangée du milieu avec le ton de base et adoucis son bord inférieur vers le sol avec le blender.';

  @override
  String get ideasFoggyMorningStep4 =>
      'Dessine les arbres les plus proches avec le marqueur foncé et ajoute quelques branches.';

  @override
  String get ideasFoggyMorningStep5 =>
      'Passe un voile du marqueur pâle sur toutes les rangées, pour que le brouillard couvre toute la scène.';

  @override
  String get ideasRainyWindowTitle => 'Pluie sur la vitre';

  @override
  String get ideasRainyWindowSummary =>
      'Des lumières floues vues à travers une vitre mouillée, avec des gouttes qui descendent.';

  @override
  String get ideasRainyWindowPractice =>
      'Des lumières qui brillent derrière le verre, et des marques nettes par-dessus.';

  @override
  String get ideasRainyWindowSubject =>
      'Une fenêtre de nuit avec des réverbères dehors et trois gouttes sur la vitre.';

  @override
  String get ideasRainyWindowTip =>
      'Les lumières doivent sécher complètement avant que le bleu passe par-dessus, sinon les couleurs se mélangent.';

  @override
  String get ideasRainyWindowStep1 =>
      'Dessine au crayon le cadre de la fenêtre et quelques taches de lumière floues dehors, et marque le chemin de trois gouttes.';

  @override
  String get ideasRainyWindowStep2 =>
      'Colore les lumières chaudes en taches douces et fais fondre leurs bords avec le blender.';

  @override
  String get ideasRainyWindowStep3 =>
      'Couvre toute la vitre avec le bleu clair, en contournant les lumières.';

  @override
  String get ideasRainyWindowStep4 =>
      'Ajoute le bleu de base vers les coins et laisse les chemins des gouttes un peu plus clairs.';

  @override
  String get ideasRainyWindowStep5 =>
      'Colore le cadre en foncé et mets un croissant sombre du côté de chaque goutte opposé à la lumière.';

  @override
  String get ideasRainyWindowStep6 =>
      'Une fois sec, ajoute une touche de gel blanc du côté éclairé de chaque goutte.';

  @override
  String get ideasEerieForestTitle => 'Bois inquiétant';

  @override
  String get ideasEerieForestSummary =>
      'Des arbres fins au crépuscule, dans des verts malades, avec un ciel violet entre eux.';

  @override
  String get ideasEerieForestPractice =>
      'Laisser deux couleurs se mélanger là où elles se touchent, exprès.';

  @override
  String get ideasEerieForestSubject =>
      'De hauts troncs minces sur un horizon bas, au crépuscule.';

  @override
  String get ideasEerieForestTip =>
      'Le vert et le violet deviennent gris là où ils se touchent. Ce gris est l’ambiance, pas une erreur.';

  @override
  String get ideasEerieForestStep1 =>
      'Dessine au crayon de hauts troncs minces et un horizon bas.';

  @override
  String get ideasEerieForestStep2 =>
      'Mets un vert-jaune pâle le long de l’horizon, entre les troncs.';

  @override
  String get ideasEerieForestStep3 =>
      'Colore le violet au-dessus et fond-le dans le vert pendant qu’il est humide.';

  @override
  String get ideasEerieForestStep4 =>
      'Colore le vert au sol et sur le bas des troncs.';

  @override
  String get ideasEerieForestStep5 =>
      'Utilise le vert le plus foncé sur les troncs en traits irréguliers, et ajoute de longues ombres sur le sol.';

  @override
  String get ideasGoldenHourTitle => 'Heure dorée';

  @override
  String get ideasGoldenHourSummary =>
      'Un mur blanc et une porte à la fin de l’après-midi : lumière orange, longues ombres violettes.';

  @override
  String get ideasGoldenHourPractice =>
      'Un voile chaud sur tout, avec des ombres froides nettes par-dessus.';

  @override
  String get ideasGoldenHourSubject =>
      'Un mur avec une porte, une plante et la longue ombre que la plante projette.';

  @override
  String get ideasGoldenHourTip =>
      'Le mur n’est pas blanc ici : avec cette lumière, il est orange. Peins-le comme ça.';

  @override
  String get ideasGoldenHourStep1 =>
      'Dessine au crayon un mur avec une porte et une plante, et la longue ombre que la plante projette sur le mur.';

  @override
  String get ideasGoldenHourStep2 =>
      'Couvre tout le mur avec l’orange pâle : c’est le mur blanc dans cette lumière.';

  @override
  String get ideasGoldenHourStep3 =>
      'Mets l’orange plus foncé sous le linteau et sur la porte.';

  @override
  String get ideasGoldenHourStep4 =>
      'Ajoute le gris-violet dans l’ombre de la plante et dans l’embrasure, avec un bord net.';

  @override
  String get ideasGoldenHourStep5 =>
      'Réserve le marqueur le plus foncé à l’intérieur de l’embrasure, et à rien d’autre.';

  @override
  String get ideasStormySeaTitle => 'Mer déchaînée';

  @override
  String get ideasStormySeaSummary =>
      'Des vagues gris-vert sous un ciel sombre, avec le papier blanc pour l’écume.';

  @override
  String get ideasStormySeaPractice =>
      'Une eau plate et pâle contre un ciel lourd, avec l’écume laissée en papier.';

  @override
  String get ideasStormySeaSubject =>
      'Un horizon bas, deux grosses vagues et l’écume qui casse dessus.';

  @override
  String get ideasStormySeaTip =>
      'L’écume, c’est du papier que tu n’as pas touché : planifie où elle casse avant de colorier l’eau.';

  @override
  String get ideasStormySeaStep1 =>
      'Dessine au crayon l’horizon bas, deux grosses vagues et où l’écume casse. L’écume reste en papier.';

  @override
  String get ideasStormySeaStep2 =>
      'Couvre l’eau avec le gris-vert pâle, en contournant l’écume.';

  @override
  String get ideasStormySeaStep3 =>
      'Mets l’eau plus sombre dans les creux et sous chaque crête.';

  @override
  String get ideasStormySeaStep4 =>
      'Remplis le ciel avec le marqueur foncé, plus sombre en haut, et l’eau la plus profonde sous la vague qui casse.';

  @override
  String get ideasStormySeaStep5 =>
      'Une fois sec, ajoute du gel blanc pour l’écume qui jaillit des crêtes : quelques points seulement.';

  @override
  String get ideasCandleFlameTitle => 'À la lueur de la bougie';

  @override
  String get ideasCandleFlameSummary =>
      'Une bougie sur une table dans une pièce sombre : tout est chaud, et rien de ce qui est loin de la flamme ne se voit.';

  @override
  String get ideasCandleFlamePractice =>
      'Des anneaux concentriques de couleurs chaudes, fondus les uns dans les autres tant que c’est humide.';

  @override
  String get ideasCandleFlameSubject =>
      'Une bougie dans son bougeoir, avec la table et le mur du fond derrière.';

  @override
  String get ideasCandleFlameTip =>
      'On ne voit que ce que la flamme touche : le fond de la pièce peut n’être qu’une forme sombre.';

  @override
  String get ideasCandleFlameStep1 =>
      'Dessine au crayon la bougie, sa flamme et un cercle de lumière sur la table. Le cœur de la flamme reste en papier.';

  @override
  String get ideasCandleFlameStep2 =>
      'Colore le halo de la flamme et la partie de la table la plus proche avec le jaune, fondu vers l’extérieur avec le blender.';

  @override
  String get ideasCandleFlameStep3 =>
      'Mets l’orange chaud sur le côté éclairé de la bougie et sur l’anneau suivant de la table.';

  @override
  String get ideasCandleFlameStep4 =>
      'Colore en brun tout ce qui est au-delà du cercle de lumière.';

  @override
  String get ideasCandleFlameStep5 =>
      'Utilise le brun le plus foncé pour le fond de la pièce et le côté à l’ombre de la bougie, avec un bord doux vers la lumière.';

  @override
  String get ideasDesertNoonTitle => 'Midi au désert';

  @override
  String get ideasDesertNoonSummary =>
      'Du sable, un rocher et une ombre dure sous un ciel délavé.';

  @override
  String get ideasDesertNoonPractice =>
      'Un aplat pâle contre une ombre dure et sombre.';

  @override
  String get ideasDesertNoonSubject =>
      'Un horizon haut, un seul rocher et son ombre courte juste en dessous.';

  @override
  String get ideasDesertNoonTip =>
      'Laisse une bande de papier blanc à l’horizon : c’est elle qui fait que le ciel paraît chaud.';

  @override
  String get ideasDesertNoonStep1 =>
      'Dessine au crayon un horizon haut, un rocher et son ombre courte juste en dessous.';

  @override
  String get ideasDesertNoonStep2 =>
      'Couvre le sable sous l’horizon avec le jaune pâle, en une passe très légère.';

  @override
  String get ideasDesertNoonStep3 =>
      'Colore le ciel avec le bleu pâle et laisse-le plus clair près de l’horizon.';

  @override
  String get ideasDesertNoonStep4 =>
      'Mets l’orange sur le côté à l’ombre du rocher et sur les ondulations du sable.';

  @override
  String get ideasDesertNoonStep5 =>
      'Utilise le bleu-violet seulement dans l’ombre projetée par le rocher, avec un bord dur.';

  @override
  String get ideasBokehLightsTitle => 'Lumières floues';

  @override
  String get ideasBokehLightsSummary =>
      'Un fond de cercles de lumière doux, hors mise au point.';

  @override
  String get ideasBokehLightsPractice =>
      'Faire un disque doux avec le blender sur un aplat.';

  @override
  String get ideasBokehLightsSubject =>
      'Un fond sombre avec une douzaine de lumières floues de tailles différentes.';

  @override
  String get ideasBokehLightsTip =>
      'Appuie le blender à plat : une pointe fine trace une ligne, pas un disque.';

  @override
  String get ideasBokehLightsStep1 =>
      'Remplis toute la zone avec la couleur de base, en traits à plat.';

  @override
  String get ideasBokehLightsStep2 =>
      'Assombris les coins et fonds la couleur foncée vers l’intérieur pendant que l’encre est humide.';

  @override
  String get ideasBokehLightsStep3 =>
      'Laisse sécher, puis appuie la pointe large du blender à plat en cercles de tailles différentes.';

  @override
  String get ideasBokehLightsStep4 =>
      'Touche le marqueur clair au centre de quelques disques pour qu’ils brillent.';

  @override
  String get ideasBokehLightsStep5 =>
      'Mets un point de gel blanc dans deux ou trois disques, pas dans tous.';

  @override
  String get ideasRetroPosterTitle => 'Affiche rétro';

  @override
  String get ideasRetroPosterSummary =>
      'Trois couleurs plates, légèrement passées, et une foncée, sans aucun mélange.';

  @override
  String get ideasRetroPosterPractice =>
      'Des aplats et des bords nets, comme une affiche imprimée.';

  @override
  String get ideasRetroPosterSubject =>
      'Un phare, une voiture ou une bouteille, dessinés en quelques grandes formes plates.';

  @override
  String get ideasRetroPosterTip =>
      'Laisse entre les couleurs un fil de papier blanc, comme si l’impression avait glissé un peu.';

  @override
  String get ideasRetroPosterStep1 =>
      'Dessine au crayon un sujet simple en grandes formes plates : un phare, une voiture, une bouteille.';

  @override
  String get ideasRetroPosterStep2 =>
      'Remplis les plus grandes formes à plat, en une passe.';

  @override
  String get ideasRetroPosterStep3 =>
      'Remplis les formes suivantes et laisse un fil de papier entre les couleurs.';

  @override
  String get ideasRetroPosterStep4 =>
      'Utilise la troisième couleur pour les plus petites formes.';

  @override
  String get ideasRetroPosterStep5 =>
      'Dessine les ombres comme des formes plates à part, avec le marqueur foncé.';

  @override
  String get ideasRetroPosterStep6 =>
      'Ajoute quelques traits de feutre fin là où l’affiche imprimée en aurait.';

  @override
  String get ideasFreshCitrusTitle => 'Frais et vif';

  @override
  String get ideasFreshCitrusSummary =>
      'Un citron, un citron vert et un verre d’eau, avec beaucoup de papier blanc et deux couches au plus.';

  @override
  String get ideasFreshCitrusPractice =>
      'De la couleur vive sur du blanc, arrêtée tôt.';

  @override
  String get ideasFreshCitrusSubject =>
      'Un citron, un citron vert et un verre d’eau sur une table.';

  @override
  String get ideasFreshCitrusTip =>
      'Arrête-toi après deux couches : une troisième fait perdre sa fraîcheur à la couleur.';

  @override
  String get ideasFreshCitrusStep1 =>
      'Dessine au crayon les fruits et le verre, et garde la composition légère.';

  @override
  String get ideasFreshCitrusStep2 =>
      'Colore le citron en jaune, en une passe, en laissant une brillance de papier blanc.';

  @override
  String get ideasFreshCitrusStep3 =>
      'Colore le citron vert en vert, aussi en une passe.';

  @override
  String get ideasFreshCitrusStep4 =>
      'Mets le jaune plus foncé du côté de l’ombre du citron, et repasse une seconde fois le vert du côté de l’ombre du citron vert.';

  @override
  String get ideasFreshCitrusStep5 =>
      'Utilise le bleu pâle pour l’eau dans le verre et une petite ombre sous chaque fruit.';

  @override
  String get ideasTropicalNoonTitle => 'Midi tropical';

  @override
  String get ideasTropicalNoonSummary =>
      'De grandes feuilles, une fleur rose vif et un morceau de ciel bleu, saturés et aux bords nets.';

  @override
  String get ideasTropicalNoonPractice =>
      'De la couleur forte à plat avec des superpositions nettes, sans aucun mélange.';

  @override
  String get ideasTropicalNoonSubject =>
      'Deux ou trois grandes feuilles qui se chevauchent, une fleur et le ciel entre les feuilles.';

  @override
  String get ideasTropicalNoonTip =>
      'Laisse le bord de chaque feuille net : c’est le chevauchement qui donne la profondeur ici.';

  @override
  String get ideasTropicalNoonStep1 =>
      'Dessine au crayon deux ou trois grandes feuilles qui se chevauchent, une fleur et le ciel entre les feuilles.';

  @override
  String get ideasTropicalNoonStep2 =>
      'Colore les feuilles en vert clair, en suivant les nervures.';

  @override
  String get ideasTropicalNoonStep3 =>
      'Mets le vert moyen sur les feuilles derrière et sous les autres, avec des bords nets là où elles se chevauchent.';

  @override
  String get ideasTropicalNoonStep4 =>
      'Colore la fleur en rose vif, avec deux couches.';

  @override
  String get ideasTropicalNoonStep5 =>
      'Colore le ciel bleu entre les feuilles, jusqu’au bord des feuilles.';

  @override
  String get ideasGreenhouseLightTitle => 'Dans la serre';

  @override
  String get ideasGreenhouseLightSummary =>
      'Des plantes derrière le verre dans une lumière verte et humide, avec des vitres gris pâle.';

  @override
  String get ideasGreenhouseLightPractice =>
      'Un voile clair sur une scène, comme le verre la voile.';

  @override
  String get ideasGreenhouseLightSubject =>
      'Un mur de verre avec ses montants et des pots de plantes derrière.';

  @override
  String get ideasGreenhouseLightTip =>
      'Le voile vert se met en dernier : c’est la lumière humide du lieu, pas la couleur des plantes.';

  @override
  String get ideasGreenhouseLightStep1 =>
      'Dessine au crayon un mur de verre avec ses montants et des pots de plantes derrière.';

  @override
  String get ideasGreenhouseLightStep2 =>
      'Colore les plantes avec le vert de base, plus doux à mesure qu’elles sont loin derrière le verre.';

  @override
  String get ideasGreenhouseLightStep3 =>
      'Réserve le vert foncé aux feuilles les plus proches.';

  @override
  String get ideasGreenhouseLightStep4 =>
      'Utilise le gris clair pour les montants et pour les stries de reflet sur les vitres.';

  @override
  String get ideasGreenhouseLightStep5 =>
      'Une fois sec, passe un voile de vert pâle sur toute la zone de verre : la lumière du dedans est verte.';

  @override
  String get ideasDustyAtticTitle => 'Grenier poussiéreux';

  @override
  String get ideasDustyAtticSummary =>
      'Des gris chauds, un vieux coffre et un rayon de lumière avec de la poussière dedans.';

  @override
  String get ideasDustyAtticPractice =>
      'Une pièce grise avec un seul endroit clair laissé intact.';

  @override
  String get ideasDustyAtticSubject =>
      'Une petite fenêtre en hauteur, le rayon de lumière qu’elle jette et un vieux coffre dedans.';

  @override
  String get ideasDustyAtticTip =>
      'Garde le rayon de lumière comme la chose la plus lumineuse du dessin : c’est le seul papier blanc qui reste.';

  @override
  String get ideasDustyAtticStep1 =>
      'Dessine au crayon une petite fenêtre en hauteur, le rayon de lumière qu’elle jette et un coffre dedans.';

  @override
  String get ideasDustyAtticStep2 =>
      'Couvre tout avec le gris chaud le plus clair, sauf l’intérieur du rayon de lumière.';

  @override
  String get ideasDustyAtticStep3 =>
      'Mets le gris chaud moyen sur les murs loin de la fenêtre et sur les côtés du coffre.';

  @override
  String get ideasDustyAtticStep4 =>
      'Utilise le gris le plus foncé dans les coins et sous le coffre.';

  @override
  String get ideasDustyAtticStep5 =>
      'Ajoute un léger voile jaune pâle dans le rayon de lumière.';

  @override
  String get ideasDustyAtticStep6 =>
      'Une fois sec, ajoute quelques grains de poussière au gel blanc dans le rayon de lumière.';

  @override
  String get ideasColourGreyBlackTitle => 'Couleur, gris et noir';

  @override
  String get ideasColourGreyBlackSummary =>
      'Trois marqueurs seulement : une couleur, un gris et un très foncé.';

  @override
  String get ideasColourGreyBlackPractice =>
      'Placer la lumière avec le moins de marqueurs possible.';

  @override
  String get ideasColourGreyBlackSubject =>
      'Un vélo, une botte ou une théière d’une seule couleur.';

  @override
  String get ideasColourGreyBlackTip =>
      'Avec trois pointes, il n’y a rien à décider sauf où va la lumière. Prévois d’abord la lumière.';

  @override
  String get ideasColourGreyBlackStep1 =>
      'Choisis un sujet d’une seule couleur principale et marque au crayon d’où vient la lumière.';

  @override
  String get ideasColourGreyBlackStep2 =>
      'Colore tout le sujet avec la couleur, et donne deux couches là où il se détourne de la lumière.';

  @override
  String get ideasColourGreyBlackStep3 =>
      'Utilise le gris pour l’ombre portée et pour tout ce qui n’est pas le sujet.';

  @override
  String get ideasColourGreyBlackStep4 =>
      'Réserve le marqueur foncé pour les lignes de contact et les coins les plus profonds.';

  @override
  String get ideasColourGreyBlackStep5 =>
      'Recule d’un pas : le dessin se lit avec trois valeurs seulement, et le gris les relie.';

  @override
  String get ideasAnalogousTrioTitle => 'Trois voisines';

  @override
  String get ideasAnalogousTrioSummary =>
      'Trois couleurs voisines sur le cercle chromatique, et rien de l’autre côté.';

  @override
  String get ideasAnalogousTrioPractice =>
      'Construire un schéma avec des teintes voisines.';

  @override
  String get ideasAnalogousTrioSubject =>
      'Un tournesol, la mer ou un champ d’une seule couleur.';

  @override
  String get ideasAnalogousTrioTip =>
      'Des couleurs voisines se fondent tant qu’elles sont humides, sans virer au gris. Garde-les humides et laisse-les se mélanger.';

  @override
  String get ideasAnalogousTrioStep1 =>
      'Choisis un sujet naturellement d’une seule couleur, comme un tournesol ou la mer, et dessine-le.';

  @override
  String get ideasAnalogousTrioStep2 =>
      'Couvre l’essentiel du sujet avec la couleur du milieu.';

  @override
  String get ideasAnalogousTrioStep3 =>
      'Mets la voisine du côté éclairé et fond-la dans la couleur du milieu tant qu’elle est humide.';

  @override
  String get ideasAnalogousTrioStep4 =>
      'Utilise l’autre voisine dans les ombres, loin de la lumière.';

  @override
  String get ideasAnalogousTrioStep5 =>
      'Ajoute le ton foncé de la couleur du milieu seulement dans les recoins les plus sombres, et laisse tout le reste dans les trois.';

  @override
  String get ideasTriadTitle => 'Une triade';

  @override
  String get ideasTriadSummary =>
      'Trois couleurs également espacées sur le cercle : une domine, deux soutiennent.';

  @override
  String get ideasTriadPractice =>
      'Utiliser un schéma à trois couleurs avec une couleur qui domine.';

  @override
  String get ideasTriadSubject =>
      'Une affiche, une couverture de livre ou une grande fleur avec de petits détails.';

  @override
  String get ideasTriadTip =>
      'Garde les trois couleurs séparées sur le papier. Un même gris posé sur les trois lie le schéma.';

  @override
  String get ideasTriadStep1 =>
      'Décide laquelle des trois couleurs domine : elle prend la plus grande part du papier.';

  @override
  String get ideasTriadStep2 =>
      'Colore les grandes surfaces avec la couleur dominante.';

  @override
  String get ideasTriadStep3 =>
      'Utilise la deuxième couleur sur environ un quart du dessin, sans jamais la laisser toucher la première tant qu’elle est humide.';

  @override
  String get ideasTriadStep4 =>
      'Utilise la troisième couleur seulement dans quelques petites touches.';

  @override
  String get ideasTriadStep5 =>
      'Ombre les trois couleurs avec le même gris pour qu’elles aillent bien ensemble.';

  @override
  String get ideasSplitComplementTitle => 'Complémentaire divisée';

  @override
  String get ideasSplitComplementSummary =>
      'Une famille de couleurs et les deux couleurs de part et d’autre de son opposé.';

  @override
  String get ideasSplitComplementPractice =>
      'Équilibrer une famille principale avec deux couleurs proches de son opposé.';

  @override
  String get ideasSplitComplementSubject =>
      'Un vase avec deux fleurs, ou une tasse avec deux petits objets à côté.';

  @override
  String get ideasSplitComplementTip =>
      'Une couleur presque opposée peut jurer ou s’harmoniser selon la quantité que tu en mets.';

  @override
  String get ideasSplitComplementStep1 =>
      'Dessine un sujet avec une grande surface et deux petites, par exemple un vase avec deux fleurs.';

  @override
  String get ideasSplitComplementStep2 =>
      'Couvre la grande surface avec le ton clair de la famille principale.';

  @override
  String get ideasSplitComplementStep3 =>
      'Ajoute son ombre là où la lumière n’arrive pas.';

  @override
  String get ideasSplitComplementStep4 =>
      'Utilise l’une des deux couleurs presque opposées sur la première petite surface.';

  @override
  String get ideasSplitComplementStep5 =>
      'Utilise l’autre sur la deuxième petite surface et garde les deux séparées.';

  @override
  String get ideasTwoGrayTemperaturesTitle => 'Gris chauds, gris froids';

  @override
  String get ideasTwoGrayTemperaturesSummary =>
      'Colore le même caillou deux fois, une fois avec des gris chauds et une fois avec des gris froids.';

  @override
  String get ideasTwoGrayTemperaturesPractice =>
      'Distinguer à l’œil un gris chaud d’un gris froid.';

  @override
  String get ideasTwoGrayTemperaturesSubject =>
      'Le même caillou ou le même tissu plié, dessiné deux fois côte à côte.';

  @override
  String get ideasTwoGrayTemperaturesTip =>
      'La plupart des marques vendent les gris chauds, froids et neutres comme des familles à part. Choisis une famille pour chaque moitié.';

  @override
  String get ideasTwoGrayTemperaturesStep1 =>
      'Dessine le même caillou deux fois au crayon, côte à côte, et marque la lumière sur chacun.';

  @override
  String get ideasTwoGrayTemperaturesStep2 =>
      'Premier caillou : le gris chaud clair partout.';

  @override
  String get ideasTwoGrayTemperaturesStep3 =>
      'Ajoute le gris chaud plus sombre du côté de l’ombre et assombris le contact avec le sol.';

  @override
  String get ideasTwoGrayTemperaturesStep4 =>
      'Deuxième caillou : le gris froid clair partout.';

  @override
  String get ideasTwoGrayTemperaturesStep5 =>
      'Ajoute le gris froid plus sombre de la même façon, puis compare : un caillou semble au soleil, l’autre à l’ombre.';

  @override
  String get ideasGrayPlusAccentTitle => 'Gris et un seul accent';

  @override
  String get ideasGrayPlusAccentSummary =>
      'Tout en gris, sauf une petite chose en couleur.';

  @override
  String get ideasGrayPlusAccentPractice =>
      'Faire porter tout le dessin par une seule couleur.';

  @override
  String get ideasGrayPlusAccentSubject =>
      'Une rue avec une porte rouge, ou un parapluie jaune dans une ville grise.';

  @override
  String get ideasGrayPlusAccentTip =>
      'L’accent doit être le plus fort possible : deux couches du même marqueur.';

  @override
  String get ideasGrayPlusAccentStep1 =>
      'Dessine une scène avec un objet sur lequel tu veux que l’œil se pose, par exemple une porte rouge dans une rue.';

  @override
  String get ideasGrayPlusAccentStep2 =>
      'Couvre tout sauf cet objet avec le gris clair.';

  @override
  String get ideasGrayPlusAccentStep3 =>
      'Mets le gris moyen dans les ombres, comme si la scène était une photo.';

  @override
  String get ideasGrayPlusAccentStep4 =>
      'Utilise le gris le plus foncé pour les fenêtres, sous les avant-toits et pour les lignes de contact.';

  @override
  String get ideasGrayPlusAccentStep5 =>
      'Colore l’objet seul, en deux couches pour que l’accent soit aussi fort que possible.';

  @override
  String get ideasEarthTonesTitle => 'Tons terre';

  @override
  String get ideasEarthTonesSummary =>
      'Bruns, ocres et un vert olive, rien de vif.';

  @override
  String get ideasEarthTonesPractice =>
      'Superposer des couleurs peu saturées sans qu’elles s’éteignent.';

  @override
  String get ideasEarthTonesSubject =>
      'Du pain, un panier ou un champ labouré.';

  @override
  String get ideasEarthTonesTip =>
      'Les couleurs peu saturées se superposent bien, parce que le papier continue de les éclairer par en dessous.';

  @override
  String get ideasEarthTonesStep1 =>
      'Dessine quelque chose qui vient de la terre : du pain, un panier ou un champ labouré.';

  @override
  String get ideasEarthTonesStep2 =>
      'Pose l’ocre pâle partout comme première couche.';

  @override
  String get ideasEarthTonesStep3 =>
      'Ajoute le brun là où la forme se détourne de la lumière.';

  @override
  String get ideasEarthTonesStep4 =>
      'Mets le vert olive sur tout ce qui est vert, et laisse l’ocre du dessous l’atténuer.';

  @override
  String get ideasEarthTonesStep5 =>
      'Réserve le brun le plus foncé aux endroits les plus profonds seulement.';

  @override
  String get ideasJewelTonesTitle => 'Tons bijoux';

  @override
  String get ideasJewelTonesSummary =>
      'Des couleurs profondes et saturées avec un accent doré, comme un écrin de velours.';

  @override
  String get ideasJewelTonesPractice =>
      'Peindre des couleurs sombres saturées qui gardent leur éclat.';

  @override
  String get ideasJewelTonesSubject =>
      'Quelques pierres ou bouteilles simples avec un reflet prévu sur chacune.';

  @override
  String get ideasJewelTonesTip =>
      'L’encre foncée saturée reste brillante sur le papier pour marqueurs. Un point de gel blanc par-dessus donne l’effet verre.';

  @override
  String get ideasJewelTonesStep1 =>
      'Dessine quelques pierres ou bouteilles simples et prévois un reflet sur chacune.';

  @override
  String get ideasJewelTonesStep2 =>
      'Couvre la plus grande forme avec le bleu-vert profond, en deux couches.';

  @override
  String get ideasJewelTonesStep3 =>
      'Utilise le violet profond sur la forme suivante.';

  @override
  String get ideasJewelTonesStep4 =>
      'Utilise le rouge profond sur la plus petite.';

  @override
  String get ideasJewelTonesStep5 =>
      'Ajoute le jaune doré sur les montures ou les bouchons, puis un point de gel blanc net sur chaque reflet.';

  @override
  String get ideasLowKeyTitle => 'Que des marqueurs foncés';

  @override
  String get ideasLowKeySummary =>
      'Dessine avec des marqueurs plus foncés que le gris moyen et laisse quelques morceaux de papier porter toute la lumière.';

  @override
  String get ideasLowKeyPractice =>
      'Peindre une image sombre en réservant la lumière exprès.';

  @override
  String get ideasLowKeySubject =>
      'Un chat aux yeux allumés, une lampe dans une pièce sombre ou un profil.';

  @override
  String get ideasLowKeyTip =>
      'L’encre alcool foncée couvre uniformément en un seul passage, donc les formes blanches que tu laisses restent nettes.';

  @override
  String get ideasLowKeyStep1 =>
      'Planifie le dessin comme quelques formes de papier laissées blanches sur un fond sombre : les yeux d’un chat, une lampe, un profil.';

  @override
  String get ideasLowKeyStep2 =>
      'Couvre tout sauf les formes blanches avec le marqueur le moins foncé.';

  @override
  String get ideasLowKeyStep3 =>
      'Utilise le marqueur intermédiaire sur les grandes ombres.';

  @override
  String get ideasLowKeyStep4 =>
      'Mets le marqueur le plus foncé sur les bords des formes claires, pour qu’elles brillent par contraste.';

  @override
  String get ideasLowKeyStep5 =>
      'Ajoute du gel blanc sur un ou deux points seulement, pas plus.';

  @override
  String get ideasComplementGradientTitle => 'Par le milieu';

  @override
  String get ideasComplementGradientSummary =>
      'Mélange deux couleurs opposées l’une dans l’autre et regarde le gris qu’elles font là où elles se rencontrent.';

  @override
  String get ideasComplementGradientPractice =>
      'Mélanger deux couleurs sur le papier et lire le résultat.';

  @override
  String get ideasComplementGradientSubject =>
      'Une longue bande de papier où les deux couleurs se rencontrent au milieu.';

  @override
  String get ideasComplementGradientTip =>
      'Des opposés humides se mélangent tout de suite sur le papier. Garde les deux humides et laisse-les se rencontrer au milieu.';

  @override
  String get ideasComplementGradientStep1 =>
      'Colle une longue bande de papier.';

  @override
  String get ideasComplementGradientStep2 =>
      'Remplis le tiers gauche et fais s’estomper la couleur vers le milieu.';

  @override
  String get ideasComplementGradientStep3 =>
      'Remplis le tiers droit et fais-le s’estomper vers le milieu tant que la première couleur est encore humide.';

  @override
  String get ideasComplementGradientStep4 =>
      'Compare le milieu boueux avec un trait de ton gris à côté.';

  @override
  String get ideasComplementGradientStep5 =>
      'Refais la bande en posant d’abord le gris au milieu et en fondant les deux couleurs dedans : le passage est plus propre.';

  @override
  String get ideasWarmLightCoolShadowTitle => 'Lumière chaude, ombre froide';

  @override
  String get ideasWarmLightCoolShadowSummary =>
      'Un objet, le côté éclairé en couleurs chaudes et le côté à l’ombre en couleurs froides.';

  @override
  String get ideasWarmLightCoolShadowPractice =>
      'Superposer du chaud et du froid sur une même couleur de base.';

  @override
  String get ideasWarmLightCoolShadowSubject =>
      'Un fruit rond, un œuf ou une balle.';

  @override
  String get ideasWarmLightCoolShadowTip =>
      'Laisse une fine bande de la base pure entre le chaud et le froid : elle garde la forme qui tourne.';

  @override
  String get ideasWarmLightCoolShadowStep1 =>
      'Dessine un objet rond et marque d’où vient la lumière.';

  @override
  String get ideasWarmLightCoolShadowStep2 =>
      'Couvre tout l’objet avec sa propre couleur.';

  @override
  String get ideasWarmLightCoolShadowStep3 =>
      'Passe la couleur chaude en couche transparente sur la moitié éclairée et fonds-la dans la base tant qu’elle est humide.';

  @override
  String get ideasWarmLightCoolShadowStep4 =>
      'Passe la couleur froide en couche transparente sur la moitié à l’ombre, et laisse une fine bande de base pure entre les deux.';

  @override
  String get ideasWarmLightCoolShadowStep5 =>
      'Réserve le marqueur le plus foncé au seul contact avec le sol.';

  @override
  String get ideasVividAndMutedTitle => 'Vif et sourd';

  @override
  String get ideasVividAndMutedSummary =>
      'Colore la même fleur avec une paire vive, puis avec une paire sourde de la même teinte.';

  @override
  String get ideasVividAndMutedPractice =>
      'Distinguer une couleur vive de sa version sourde.';

  @override
  String get ideasVividAndMutedSubject =>
      'La même fleur dessinée deux fois, côte à côte.';

  @override
  String get ideasVividAndMutedTip =>
      'La plupart des gammes ont une version vive et une version grisée de chaque teinte. Choisir entre les deux, c’est tout l’exercice.';

  @override
  String get ideasVividAndMutedStep1 =>
      'Dessine la même fleur deux fois au crayon, côte à côte.';

  @override
  String get ideasVividAndMutedStep2 => 'Première fleur : le ton clair et vif.';

  @override
  String get ideasVividAndMutedStep3 =>
      'Ajoute l’ombre vive de la même teinte.';

  @override
  String get ideasVividAndMutedStep4 =>
      'Deuxième fleur : le ton clair et sourd de la même teinte.';

  @override
  String get ideasVividAndMutedStep5 =>
      'Ajoute son ombre sourde, puis décide quelle fleur irait au premier plan d’un dessin et laquelle à l’arrière-plan.';

  @override
  String get ideasOneMarkerBlenderTitle => 'Un marqueur et le blender';

  @override
  String get ideasOneMarkerBlenderSummary =>
      'Quatre valeurs avec un seul marqueur foncé, en le diluant avec le blender incolore.';

  @override
  String get ideasOneMarkerBlenderPractice =>
      'Diluer l’encre pour obtenir des valeurs plus claires sans un deuxième marqueur.';

  @override
  String get ideasOneMarkerBlenderSubject =>
      'Quatre petits carrés de papier collés côte à côte.';

  @override
  String get ideasOneMarkerBlenderTip =>
      'Le blender est du solvant pur : il transforme un seul marqueur foncé en sa propre famille claire.';

  @override
  String get ideasOneMarkerBlenderStep1 =>
      'Colle quatre petits carrés de papier côte à côte.';

  @override
  String get ideasOneMarkerBlenderStep2 =>
      'Remplis le premier carré avec le marqueur à pleine intensité.';

  @override
  String get ideasOneMarkerBlenderStep3 =>
      'Deuxième carré : un trait de marqueur, puis le blender par-dessus tant que c’est humide.';

  @override
  String get ideasOneMarkerBlenderStep4 =>
      'Troisième carré : le blender d’abord, puis le marqueur dans le blender humide. Quatrième : touche la pointe du marqueur sur celle du blender et peins seulement avec le blender.';

  @override
  String get ideasOneMarkerBlenderStep5 =>
      'Aligne-les : une échelle de quatre valeurs avec un seul marqueur.';

  @override
  String get ideasColourWheelTitle => 'Ton cercle chromatique';

  @override
  String get ideasColourWheelSummary =>
      'Dispose douze de tes marqueurs en cercle et repère les manques de ta collection.';

  @override
  String get ideasColourWheelPractice =>
      'Lire un cercle chromatique avec les marqueurs que tu as.';

  @override
  String get ideasColourWheelSubject =>
      'Un cercle d’une dizaine de centimètres de diamètre, divisé en douze parts.';

  @override
  String get ideasColourWheelTip =>
      'Un cercle de marqueurs est à la fois une liste de courses et un guide de mélange sur une page.';

  @override
  String get ideasColourWheelStep1 =>
      'Trace un cercle autour d’une tasse et divise-le en douze parts.';

  @override
  String get ideasColourWheelStep2 =>
      'Choisis le marqueur le plus proche du jaune pur, puis du rouge, puis du bleu, et remplis leurs parts en les espaçant de quatre parts.';

  @override
  String get ideasColourWheelStep3 =>
      'Remplis les parts entre elles avec les marqueurs les plus proches que tu as : orange, vert, violet, puis les six teintes intermédiaires.';

  @override
  String get ideasColourWheelStep4 =>
      'Écris chaque code sous sa part. Une part vide ou douteuse indique un marqueur que tu voudras peut-être acheter ensuite.';

  @override
  String get ideasDeepSkinTitle => 'Teintes de peau foncées';

  @override
  String get ideasDeepSkinSummary =>
      'Colore un visage dans des teintes de peau foncées, avec une lumière chaude et un blush rougeâtre.';

  @override
  String get ideasDeepSkinPractice =>
      'Ombrer une peau foncée avec une longue gamme de valeurs dans une seule teinte.';

  @override
  String get ideasDeepSkinSubject =>
      'Un visage aux trois quarts, éclairé de face.';

  @override
  String get ideasDeepSkinTip =>
      'La peau foncée demande une longue gamme de clarté dans une seule teinte, et les familles de marqueurs sont faites pour ça.';

  @override
  String get ideasDeepSkinStep1 =>
      'Dessine un visage au crayon et marque le front, le nez et les pommettes comme les plans éclairés.';

  @override
  String get ideasDeepSkinStep2 =>
      'Couvre tout le visage avec le brun le plus clair.';

  @override
  String get ideasDeepSkinStep3 =>
      'Tant que la première couche est humide, ajoute le brun rougeâtre sur les joues et les lèvres.';

  @override
  String get ideasDeepSkinStep4 =>
      'Ajoute le brun de base partout sauf sur les plans éclairés.';

  @override
  String get ideasDeepSkinStep5 =>
      'Utilise le marqueur le plus foncé sous les sourcils, le nez, la lèvre inférieure et la mâchoire, et laisse les plans éclairés avec la première couche seulement.';

  @override
  String get ideasBlackObjectTitle => 'Noir sans noir';

  @override
  String get ideasBlackObjectSummary =>
      'Colore un chat noir ou une botte noire avec des bleus et des violets sombres, et garde le marqueur noir pour la fin.';

  @override
  String get ideasBlackObjectPractice =>
      'Construire un objet sombre avec des couleurs sombres plutôt qu’avec du noir.';

  @override
  String get ideasBlackObjectSubject =>
      'Un chat noir, une botte ou une bouilloire brillante.';

  @override
  String get ideasBlackObjectTip =>
      'Un aplat de marqueur noir tue la forme. Des couleurs foncées superposées la gardent.';

  @override
  String get ideasBlackObjectStep1 =>
      'Dessine l’objet au crayon et la forme de ses reflets : les objets noirs reflètent le ciel et la pièce.';

  @override
  String get ideasBlackObjectStep2 =>
      'Utilise le gris-bleu froid clair sur les reflets et les faces supérieures.';

  @override
  String get ideasBlackObjectStep3 =>
      'Couvre l’essentiel de l’objet avec le bleu foncé.';

  @override
  String get ideasBlackObjectStep4 => 'Utilise le violet foncé sur le dessous.';

  @override
  String get ideasBlackObjectStep5 =>
      'Réserve le marqueur le plus foncé aux plis les plus profonds, et ajoute un éclat de gel blanc si la surface brille.';

  @override
  String get ideasWhiteObjectTitle => 'Blanc sans blanc';

  @override
  String get ideasWhiteObjectSummary =>
      'Une tasse ou un œuf blancs avec des gris pâles, une ombre teintée et beaucoup de papier intact.';

  @override
  String get ideasWhiteObjectPractice =>
      'Peindre un objet blanc sans peindre par-dessus le papier.';

  @override
  String get ideasWhiteObjectSubject =>
      'Une tasse blanche, un œuf ou une serviette pliée.';

  @override
  String get ideasWhiteObjectTip =>
      'Un objet blanc, c’est surtout du papier. Avec les marqueurs, mieux vaut ne pas y toucher.';

  @override
  String get ideasWhiteObjectStep1 =>
      'Dessine l’objet au crayon et marque le côté éclairé : il reste du papier.';

  @override
  String get ideasWhiteObjectStep2 =>
      'Utilise le marqueur teinté très pâle sur le côté à l’ombre seulement.';

  @override
  String get ideasWhiteObjectStep3 =>
      'Mets le gris clair à l’intérieur de cette zone, vers la partie la plus sombre.';

  @override
  String get ideasWhiteObjectStep4 =>
      'Utilise le gris froid un peu plus sombre seulement le long du bord le plus éloigné de la lumière et là où l’objet touche la table.';

  @override
  String get ideasWhiteObjectStep5 =>
      'Ajoute un soupçon de la couleur de la table, réfléchie dans le dessous de l’objet.';

  @override
  String get ideasFeatheredEdgeTitle => 'Bord fondu';

  @override
  String get ideasFeatheredEdgeSummary =>
      'Fais disparaître un côté d’une forme dans le papier blanc et garde l’autre bord net.';

  @override
  String get ideasFeatheredEdgePractice =>
      'Un bord doux à côté d’un bord dur : le moyen le plus simple de donner de la lumière à une forme.';

  @override
  String get ideasFeatheredEdgeSubject =>
      'Une feuille, un pétale ou un pli de tissu.';

  @override
  String get ideasFeatheredEdgeTip =>
      'Lève la pointe en avançant : l’encre s’épuise toute seule dans le trait.';

  @override
  String get ideasFeatheredEdgeStep1 =>
      'Dessine une feuille au crayon et décide quel bord est dans la lumière.';

  @override
  String get ideasFeatheredEdgeStep2 =>
      'Colore le bord sombre avec la couleur de base en traits courts qui pointent tous vers le côté éclairé.';

  @override
  String get ideasFeatheredEdgeStep3 =>
      'Passe le marqueur clair du centre vers l’extérieur sur la fin de ces traits, en levant la pointe pour que chaque trait s’éteigne.';

  @override
  String get ideasFeatheredEdgeStep4 =>
      'Repasse sur la jointure, toujours de la couleur vers le blanc.';

  @override
  String get ideasFeatheredEdgeStep5 =>
      'Compare les deux bords : l’un doux, l’autre dur. C’est ce contraste qui fait lire la forme.';

  @override
  String get ideasTipToTipTitle => 'Pointe contre pointe';

  @override
  String get ideasTipToTipSummary =>
      'Charge une couleur sombre sur la pointe d’un marqueur clair et fais un dégradé en un seul passage.';

  @override
  String get ideasTipToTipPractice =>
      'Emprunter l’encre d’un marqueur à l’autre pour un dégradé rapide.';

  @override
  String get ideasTipToTipSubject =>
      'Une bande de papier de la largeur de deux doigts.';

  @override
  String get ideasTipToTipTip =>
      'Garde le marqueur sombre immobile : la pointe claire ne prend l’encre que sur la pointe.';

  @override
  String get ideasTipToTipStep1 =>
      'Colle au ruban une bande d’environ deux doigts de large.';

  @override
  String get ideasTipToTipStep2 =>
      'Garde le marqueur sombre immobile et pose la pointe du marqueur clair dessus pendant quelques secondes.';

  @override
  String get ideasTipToTipStep3 =>
      'Commence en bas de la bande avec la pointe chargée : les premiers traits sont foncés, puis la couleur du marqueur revient.';

  @override
  String get ideasTipToTipStep4 =>
      'Frotte la pointe sur un brouillon jusqu’à ce qu’elle sorte propre : le marqueur clair n’est pas abîmé.';

  @override
  String get ideasTipToTipStep5 =>
      'Recommence sur une deuxième bande en chargeant la pointe plus longtemps : la partie foncée va plus loin.';

  @override
  String get ideasBlenderPatternTitle => 'Motifs au blender';

  @override
  String get ideasBlenderPatternSummary =>
      'Soulève des points et des lignes dans une couleur plate avec le blender incolore.';

  @override
  String get ideasBlenderPatternPractice =>
      'Déplacer l’encre au lieu de l’effacer : points, lignes et motifs.';

  @override
  String get ideasBlenderPatternSubject =>
      'Un carré de couleur sur lequel dessiner le motif.';

  @override
  String get ideasBlenderPatternTip =>
      'Attends entre deux touches : deux marques trop proches se confondent.';

  @override
  String get ideasBlenderPatternStep1 =>
      'Remplis un carré avec la couleur de base et laisse-le sécher complètement.';

  @override
  String get ideasBlenderPatternStep2 =>
      'Enfonce la pointe fine du blender dans la couleur et garde-la une seconde : un point clair s’ouvre avec un bord plus sombre.';

  @override
  String get ideasBlenderPatternStep3 =>
      'Trace une ligne avec la pointe large : l’encre repoussée s’accumule sur les bords.';

  @override
  String get ideasBlenderPatternStep4 =>
      'Fais un motif : des points, des rayures ou une rangée d’écailles.';

  @override
  String get ideasBlenderPatternStep5 =>
      'Attends entre les touches, sinon les points se rejoignent.';

  @override
  String get ideasOneMarkerLayersTitle => 'Un marqueur, trois couches';

  @override
  String get ideasOneMarkerLayersSummary =>
      'Ombre un cube avec un seul marqueur en superposant un, deux et trois passages.';

  @override
  String get ideasOneMarkerLayersPractice =>
      'Voir l’étendue de tons d’un seul marqueur quand les couches sèchent l’une sur l’autre.';

  @override
  String get ideasOneMarkerLayersSubject =>
      'Un cube éclairé par un coin du haut.';

  @override
  String get ideasOneMarkerLayersTip =>
      'Laisse sécher chaque couche : un deuxième passage humide déplace l’encre au lieu de l’assombrir.';

  @override
  String get ideasOneMarkerLayersStep1 =>
      'Dessine un cube au crayon, avec la lumière venant d’un coin du haut.';

  @override
  String get ideasOneMarkerLayersStep2 =>
      'Un passage sur chaque face. Laisse sécher.';

  @override
  String get ideasOneMarkerLayersStep3 =>
      'Un deuxième passage sur les deux faces éloignées de la lumière.';

  @override
  String get ideasOneMarkerLayersStep4 =>
      'Un troisième passage seulement sur la face la plus sombre et le long des arêtes du bas.';

  @override
  String get ideasOneMarkerLayersStep5 =>
      'Regarde les trois valeurs : voilà l’étendue de tons d’un seul marqueur.';

  @override
  String get ideasStipplePeelTitle => 'Peau d’orange ponctuée';

  @override
  String get ideasStipplePeelSummary =>
      'Construis la texture bosselée d’une peau d’agrume avec des points sur un dégradé.';

  @override
  String get ideasStipplePeelPractice =>
      'Pointiller sur un dégradé sec, sans l’étaler.';

  @override
  String get ideasStipplePeelSubject =>
      'Une orange avec une brillance douce sur le dessus.';

  @override
  String get ideasStipplePeelTip =>
      'Utilise la pointe fine : elle donne des points nets.';

  @override
  String get ideasStipplePeelStep1 =>
      'Dessine une orange au crayon et une brillance douce sur sa partie haute.';

  @override
  String get ideasStipplePeelStep2 =>
      'Remplis l’orange en laissant la brillance plus claire.';

  @override
  String get ideasStipplePeelStep3 =>
      'Fonds la couleur de base dans la moitié à l’ombre pendant que c’est encore humide.';

  @override
  String get ideasStipplePeelStep4 =>
      'Une fois sec, tapote avec la pointe fine du marqueur foncé en points espacés : plus serrés dans l’ombre, presque aucun près de la brillance.';

  @override
  String get ideasStipplePeelStep5 =>
      'Tape quelques points clairs dans les points sombres pour les casser.';

  @override
  String get ideasClearGlassTitle => 'Un verre transparent';

  @override
  String get ideasClearGlassSummary =>
      'Colore un verre à boire vide avec des gris et presque rien d’autre.';

  @override
  String get ideasClearGlassPractice =>
      'Gris et papier blanc : la façon la plus légère de dessiner du verre.';

  @override
  String get ideasClearGlassSubject =>
      'Un verre avec le bord, le pied et deux reflets verticaux.';

  @override
  String get ideasClearGlassTip =>
      'Le verre est plus sombre là où il est plus épais : au bord et au pied.';

  @override
  String get ideasClearGlassStep1 =>
      'Dessine le verre au crayon et marque le bord, le pied et deux reflets verticaux qui restent en papier blanc.';

  @override
  String get ideasClearGlassStep2 =>
      'Colore le verre avec le gris le plus clair, en laissant les reflets et la plupart du centre en blanc.';

  @override
  String get ideasClearGlassStep3 =>
      'Assombris le bord, le pied épais et le bord du fond : le verre est plus sombre là où il est plus épais.';

  @override
  String get ideasClearGlassStep4 =>
      'Pose une tache de couleur derrière le verre : une version plus pâle doit transparaître à travers le verre, par-dessus le gris clair.';

  @override
  String get ideasClearGlassStep5 =>
      'Du stylo gel blanc sur le bord et le pied pour les reflets les plus nets.';

  @override
  String get ideasPolishedMetalTitle => 'Métal poli';

  @override
  String get ideasPolishedMetalSummary =>
      'Donne à une cuillère l’air du métal avec des bandes de gris nettes et une couleur réfléchie.';

  @override
  String get ideasPolishedMetalPractice =>
      'Des bandes à bord dur et une longue plage de valeurs : voilà comment se lit le métal.';

  @override
  String get ideasPolishedMetalSubject =>
      'Une cuillère avec les bandes de son reflet déjà dessinées.';

  @override
  String get ideasPolishedMetalTip =>
      'Le métal n’a pas de transitions douces : garde les bords des bandes nets.';

  @override
  String get ideasPolishedMetalStep1 =>
      'Dessine la cuillère au crayon et ses reflets sous forme de bandes : une sombre en travers de la coupelle, une claire à côté, sans transition douce.';

  @override
  String get ideasPolishedMetalStep2 =>
      'Remplis la coupelle et le manche avec le gris le plus clair.';

  @override
  String get ideasPolishedMetalStep3 =>
      'Pose les bandes sombres à bords nets, en suivant la courbe de la coupelle.';

  @override
  String get ideasPolishedMetalStep4 =>
      'Mets le gris le plus sombre juste à côté de la bande la plus claire : le métal vit de ce contraste.';

  @override
  String get ideasPolishedMetalStep5 =>
      'Laisse une trace de la couleur de la table se refléter dans la moitié basse de la coupelle, puis du gel blanc sur le reflet le plus net.';

  @override
  String get ideasCastShadowTitle => 'L’ombre sur la table';

  @override
  String get ideasCastShadowSummary =>
      'Dessine une tasse et réussis son ombre portée : sombre au contact, douce plus loin.';

  @override
  String get ideasCastShadowPractice =>
      'Les ombres portées : la ligne de contact, le dégradé et le gris qui les dessine.';

  @override
  String get ideasCastShadowSubject =>
      'Une tasse sur une table, avec la lumière d’un côté.';

  @override
  String get ideasCastShadowTip =>
      'L’ombre commence là où l’objet touche la table, pas là où la lumière s’arrête.';

  @override
  String get ideasCastShadowStep1 =>
      'Dessine au crayon une tasse et la forme de son ombre sur la table, plus longue du côté opposé à la lumière.';

  @override
  String get ideasCastShadowStep2 =>
      'Colore la tasse et ombre son côté opposé à la lumière avec le même marqueur, en une deuxième couche.';

  @override
  String get ideasCastShadowStep3 =>
      'Remplis l’ombre portée avec le gris : commence à la base de la tasse et lève la pointe en t’éloignant.';

  @override
  String get ideasCastShadowStep4 =>
      'Ajoute une fine ligne sombre là où la tasse touche la table.';

  @override
  String get ideasCastShadowStep5 =>
      'Adoucis le bord éloigné de l’ombre avec une seconde touche légère de gris pendant que la première est encore humide.';

  @override
  String get ideasSoftCloudsTitle => 'Nuages doux';

  @override
  String get ideasSoftCloudsSummary =>
      'Colore le ciel autour des nuages et laisse les nuages en papier.';

  @override
  String get ideasSoftCloudsPractice =>
      'Peindre en négatif : la forme, c’est le papier que tu n’as pas touché.';

  @override
  String get ideasSoftCloudsSubject =>
      'Deux ou trois nuages avec le dessus rond et le dessous plus plat.';

  @override
  String get ideasSoftCloudsTip =>
      'Travaille autour des nuages avec la pointe large : leurs bords restent un peu irréguliers.';

  @override
  String get ideasSoftCloudsStep1 =>
      'Dessine très légèrement au crayon deux ou trois nuages : dessus ronds, dessous plus plats.';

  @override
  String get ideasSoftCloudsStep2 =>
      'Remplis le ciel avec le bleu clair en tournant autour des nuages avec la pointe large pour que leurs bords restent un peu irréguliers.';

  @override
  String get ideasSoftCloudsStep3 =>
      'Assombris le ciel vers le haut et fonds vers le bleu clair pendant que c’est humide.';

  @override
  String get ideasSoftCloudsStep4 =>
      'Ombre le dessous de chaque nuage avec le gris clair, en gardant le dessus blanc.';

  @override
  String get ideasSoftCloudsStep5 =>
      'Adoucis avec le blender tout bord de ciel trop net contre un nuage, en poussant la couleur vers l’extérieur.';

  @override
  String get ideasStillWaterTitle => 'Reflet dans l’eau calme';

  @override
  String get ideasStillWaterSummary =>
      'Dessine un arbre au bord de l’eau et sa copie à l’envers, un peu plus sombre, dans l’eau.';

  @override
  String get ideasStillWaterPractice =>
      'Poser une couleur sur une autre : voilà comment se fait un reflet.';

  @override
  String get ideasStillWaterSubject =>
      'Un arbre au bord de l’eau avec son reflet en dessous.';

  @override
  String get ideasStillWaterTip =>
      'Peins le reflet en traits horizontaux seulement : l’eau bouge de côté.';

  @override
  String get ideasStillWaterStep1 =>
      'Dessine au crayon une ligne d’horizon, un arbre simple au-dessus et son image miroir en dessous.';

  @override
  String get ideasStillWaterStep2 =>
      'Colore l’arbre et son reflet avec le même marqueur, le reflet en traits horizontaux seulement.';

  @override
  String get ideasStillWaterStep3 =>
      'Étale le bleu clair sur toute la surface de l’eau, reflet compris, en longs traits horizontaux.';

  @override
  String get ideasStillWaterStep4 =>
      'Assombris l’eau près de la berge et sur le bord du fond ; quelques lignes horizontales brisées de couleur de base sur le reflet.';

  @override
  String get ideasStillWaterStep5 =>
      'Mets le bleu sombre là où la berge touche l’eau, puis deux ou trois fines lignes de gel blanc pour les remous.';

  @override
  String get ideasTwistedRibbonTitle => 'Ruban torsadé';

  @override
  String get ideasTwistedRibbonSummary =>
      'Fonds un dégradé qui épouse un ruban torsadé, tantôt dessus, tantôt dessous.';

  @override
  String get ideasTwistedRibbonPractice =>
      'Répéter un court dégradé à chaque courbe d’une forme.';

  @override
  String get ideasTwistedRibbonSubject =>
      'Un ruban avec deux torsades, dessus et dessous.';

  @override
  String get ideasTwistedRibbonTip =>
      'Fonds le long de la courbe du ruban, jamais en travers.';

  @override
  String get ideasTwistedRibbonStep1 =>
      'Dessine au crayon un ruban avec deux torsades et marque les segments qui passent devant et ceux qui passent derrière.';

  @override
  String get ideasTwistedRibbonStep2 =>
      'Remplis chaque segment avec le marqueur clair.';

  @override
  String get ideasTwistedRibbonStep3 =>
      'Sur chaque segment, ajoute la couleur de base du côté qui s’éloigne de toi en se courbant, avec des traits qui suivent la courbe et non en travers.';

  @override
  String get ideasTwistedRibbonStep4 =>
      'Assombris seulement là où un segment passe sous un autre, en une bande étroite juste au croisement.';

  @override
  String get ideasTwistedRibbonStep5 =>
      'Passe le blender sur chaque bande où le dégradé fait des paliers.';

  @override
  String get ideasNoLineLeafTitle => 'Coloriage sans contour';

  @override
  String get ideasNoLineLeafSummary =>
      'Colore une feuille d’après un croquis au crayon et laisse les bords de la couleur faire le contour.';

  @override
  String get ideasNoLineLeafPractice =>
      'Dessiner sans feutre fin : le bord de la couleur est le contour.';

  @override
  String get ideasNoLineLeafSubject =>
      'Une feuille simple avec sa nervure centrale.';

  @override
  String get ideasNoLineLeafTip =>
      'Efface le crayon avec une gomme douce jusqu’à ce que tu le voies à peine.';

  @override
  String get ideasNoLineLeafStep1 =>
      'Dessine la feuille et sa nervure centrale très légèrement au crayon, puis efface l’essentiel du graphite avec une gomme douce jusqu’à ce que tu le voies à peine.';

  @override
  String get ideasNoLineLeafStep2 =>
      'Remplis la feuille et arrête-toi exactement sur la ligne de crayon.';

  @override
  String get ideasNoLineLeafStep3 =>
      'Ombre une moitié et la base de la feuille pendant que la première couche est encore humide.';

  @override
  String get ideasNoLineLeafStep4 =>
      'Définis le bord du côté de l’ombre avec un fin trait du marqueur le plus foncé, au lieu d’un feutre fin.';

  @override
  String get ideasNoLineLeafStep5 =>
      'Efface le crayon qui ressort encore une fois l’encre sèche.';

  @override
  String get ideasShortFurTitle => 'Poil court';

  @override
  String get ideasShortFurSummary =>
      'Colore l’oreille d’un chat avec de courts traits dans deux directions.';

  @override
  String get ideasShortFurPractice =>
      'Des traits courts qui suivent la direction du poil.';

  @override
  String get ideasShortFurSubject =>
      'Une oreille de chat avec quelques flèches qui montrent dans quel sens pousse le poil.';

  @override
  String get ideasShortFurTip =>
      'Fais des traits depuis les racines vers l’extérieur : appuie, va vite et lève.';

  @override
  String get ideasShortFurStep1 =>
      'Dessine l’oreille au crayon et la direction du poil avec quelques flèches.';

  @override
  String get ideasShortFurStep2 =>
      'Remplis l’oreille avec le marqueur clair, en faisant des traits vers l’extérieur sur le bord pour que le contour soit poilu et pas plein.';

  @override
  String get ideasShortFurStep3 =>
      'De courts traits de couleur de base du bord intérieur vers l’extérieur, en suivant les flèches.';

  @override
  String get ideasShortFurStep4 =>
      'Moins de traits et plus sombres dans l’oreille et à la base, là où elle rejoint la tête.';

  @override
  String get ideasShortFurStep5 =>
      'Repasse le marqueur clair sur les jointures pour fondre les couches et adoucir les traits les plus sombres.';

  @override
  String get ideasWoodGrainTitle => 'Planche de bois';

  @override
  String get ideasWoodGrainSummary =>
      'Une planche avec des veines et un nœud, en trois bruns.';

  @override
  String get ideasWoodGrainPractice =>
      'De longs traits qui suivent la forme de la matière.';

  @override
  String get ideasWoodGrainSubject =>
      'Une planche de bois avec un nœud près d’un bout.';

  @override
  String get ideasWoodGrainTip =>
      'Les veines contournent le nœud : dessine les lignes courbes, jamais droites.';

  @override
  String get ideasWoodGrainStep1 =>
      'Dessine au crayon une planche avec un nœud ; les veines contournent le nœud comme l’eau contourne une pierre.';

  @override
  String get ideasWoodGrainStep2 =>
      'Remplis la planche de longs traits dans le sens des veines.';

  @override
  String get ideasWoodGrainStep3 =>
      'De longues lignes de couleur de base, légèrement ondulées, dans le sens des veines, qui se resserrent près du nœud.';

  @override
  String get ideasWoodGrainStep4 =>
      'Quelques lignes plus sombres et les anneaux du nœud ; assombris le bord bas de la planche.';

  @override
  String get ideasWoodGrainStep5 =>
      'Repasse le marqueur clair sur les lignes pour adoucir ce qui a l’air dessiné par-dessus.';

  @override
  String get ideasBrickWallTitle => 'Mur de briques';

  @override
  String get ideasBrickWallSummary =>
      'Un pan de mur en briques de couleurs légèrement différentes et un mortier clair.';

  @override
  String get ideasBrickWallPractice =>
      'Des aplats, brique par brique, et le gris du mortier.';

  @override
  String get ideasBrickWallSubject =>
      'Un pan de mur avec une vingtaine de briques.';

  @override
  String get ideasBrickWallTip =>
      'Laisse le mortier en papier : il est plus clair que n’importe quelle brique.';

  @override
  String get ideasBrickWallStep1 =>
      'Dessine au crayon le quadrillage du mortier et laisse-le en papier pour l’instant.';

  @override
  String get ideasBrickWallStep2 =>
      'Remplis chaque brique avec le marqueur clair, en laissant chaque brique sécher comme une forme à part.';

  @override
  String get ideasBrickWallStep3 =>
      'Passe la couleur de base sur la moitié des briques environ, choisies au hasard, pour que le mur ne soit pas uniforme.';

  @override
  String get ideasBrickWallStep4 =>
      'Ombre le bord bas de chaque brique, plus quelques éclats et quelques briques plus sombres.';

  @override
  String get ideasBrickWallStep5 =>
      'Remplis les joints de mortier avec le gris clair.';

  @override
  String get ideasFoldedClothTitle => 'Tissu plié';

  @override
  String get ideasFoldedClothSummary =>
      'Ombre les plis d’un tissu suspendu avec quatre valeurs et une seule direction de lumière.';

  @override
  String get ideasFoldedClothPractice =>
      'Le même dégradé répété sur chaque pli.';

  @override
  String get ideasFoldedClothSubject =>
      'Un tissu pendu sur une corde, avec trois ou quatre plis.';

  @override
  String get ideasFoldedClothTip =>
      'Le trait le plus sombre va seulement là où le tissu se retourne sur lui-même.';

  @override
  String get ideasFoldedClothStep1 =>
      'Dessine au crayon un tissu pendu sur une corde, avec trois ou quatre plis, et marque le haut de chaque pli.';

  @override
  String get ideasFoldedClothStep2 => 'Remplis le tissu.';

  @override
  String get ideasFoldedClothStep3 =>
      'La couleur de base du côté de chaque pli éloigné de la lumière, fondue dans le clair pendant que c’est humide.';

  @override
  String get ideasFoldedClothStep4 =>
      'De l’ombre au fond de chaque pli, là où le tissu se retourne.';

  @override
  String get ideasFoldedClothStep5 =>
      'Un fin trait sombre seulement tout en bas des plis les plus profonds ; passe le blender sur chaque palier dur des parties rondes.';

  @override
  String get ideasWaterDropsTitle => 'Des gouttes sur une feuille';

  @override
  String get ideasWaterDropsSummary =>
      'Trois gouttes d’eau sur une feuille, chacune avec son ombre, son bord sombre et son reflet.';

  @override
  String get ideasWaterDropsPractice =>
      'Quelques marques nettes par-dessus un dégradé terminé.';

  @override
  String get ideasWaterDropsSubject => 'Une feuille avec trois gouttes d’eau.';

  @override
  String get ideasWaterDropsTip =>
      'La goutte inverse la lumière : ombre le côté qui la regarde.';

  @override
  String get ideasWaterDropsStep1 =>
      'Dessine au crayon une feuille et trois gouttes ; marque dans chaque goutte un petit reflet du côté éclairé.';

  @override
  String get ideasWaterDropsStep2 =>
      'Colore toute la feuille, gouttes comprises ; les gouttes sont la feuille vue à travers l’eau.';

  @override
  String get ideasWaterDropsStep3 =>
      'Ombre la feuille et, dans chaque goutte, le côté qui fait face à la lumière, car la goutte agit comme une loupe et l’inverse.';

  @override
  String get ideasWaterDropsStep4 =>
      'Un fin croissant sombre du côté opposé de chaque goutte et une petite ombre portée dessous.';

  @override
  String get ideasWaterDropsStep5 =>
      'Du gel blanc : un point net par goutte du côté éclairé, plus un liseré plus clair à l’opposé.';

  @override
  String get ideasStrawberrySeedsTitle => 'Fraise';

  @override
  String get ideasStrawberrySeedsSummary =>
      'Une fraise dont les graines sont logées dans de petits creux, avec un chapeau vert.';

  @override
  String get ideasStrawberrySeedsPractice =>
      'Une texture faite de petites marques : creux, graines et chapeau.';

  @override
  String get ideasStrawberrySeedsSubject =>
      'Une fraise avec une grille libre de graines.';

  @override
  String get ideasStrawberrySeedsTip =>
      'Marque les creux pendant que la couleur est encore humide : l’anneau plus sombre se forme tout seul.';

  @override
  String get ideasStrawberrySeedsStep1 =>
      'Dessine au crayon la fraise et une grille libre de points de graines, plus serrés vers la pointe.';

  @override
  String get ideasStrawberrySeedsStep2 =>
      'Remplis le fruit en laissant une brillance douce.';

  @override
  String get ideasStrawberrySeedsStep3 =>
      'Fonds la couleur de base sur les côtés ; pendant que c’est humide, pose un point un peu plus sombre au-dessus de chaque graine.';

  @override
  String get ideasStrawberrySeedsStep4 =>
      'Assombris la moitié basse et le creux au-dessus de chaque graine.';

  @override
  String get ideasStrawberrySeedsStep5 =>
      'Colore les feuilles et la tige en vert, puis mets un minuscule point de gel clair dans chaque creux pour la graine.';

  @override
  String get ideasPaletteMixingTitle => 'Mélanger sur une palette';

  @override
  String get ideasPaletteMixingSummary =>
      'Crée une troisième couleur en mélangeant deux marqueurs sur une surface plastique et en la reprenant avec le blender.';

  @override
  String get ideasPaletteMixingPractice =>
      'Mélanger deux encres hors du papier, avec le blender comme pinceau.';

  @override
  String get ideasPaletteMixingSubject =>
      'Un couvercle en plastique ou une carte de mélange, plus un brouillon.';

  @override
  String get ideasPaletteMixingTip =>
      'Le blender ne transporte que ce qui est mouillé : ne laisse pas sécher les flaques.';

  @override
  String get ideasPaletteMixingStep1 =>
      'Gribouille le premier marqueur sur une surface non absorbante, comme une carte de mélange, un couvercle en plastique ou un sachet zip.';

  @override
  String get ideasPaletteMixingStep2 =>
      'Gribouille le second marqueur à côté, pour que les deux flaques se touchent.';

  @override
  String get ideasPaletteMixingStep3 =>
      'Reprends le mélange avec la pointe large du blender incolore et peins-en un échantillon ; à côté, fais un échantillon de chaque marqueur seul.';

  @override
  String get ideasPaletteMixingStep4 =>
      'Essaie un second mélange avec plus de l’une des couleurs.';

  @override
  String get ideasPaletteMixingStep5 =>
      'Note les mélanges que tu aimerais avoir comme marqueur.';

  @override
  String get ideasLongHairTitle => 'Cheveux longs';

  @override
  String get ideasLongHairSummary =>
      'Une chute de cheveux avec une bande de lumière en travers et des mèches qui suivent la tête.';

  @override
  String get ideasLongHairPractice =>
      'De longs traits qui s’affinent et une bande de lumière qui n’est que du papier.';

  @override
  String get ideasLongHairSubject =>
      'Une coiffure avec quelques grosses mèches et une bande de lumière.';

  @override
  String get ideasLongHairTip =>
      'Appuie moins dans la bande de lumière : le papier fait le travail.';

  @override
  String get ideasLongHairStep1 =>
      'Dessine au crayon les cheveux en quelques grosses mèches, pas en cheveux séparés, et une bande courbe là où la lumière tombe.';

  @override
  String get ideasLongHairStep2 =>
      'Remplis tous les cheveux en appuyant moins dans la bande de lumière.';

  @override
  String get ideasLongHairStep3 =>
      'De longs traits depuis la raie vers le bas, chacun levant la pointe en arrivant à la bande de lumière, puis des pointes vers le haut.';

  @override
  String get ideasLongHairStep4 =>
      'Assombris entre les mèches, sous l’oreille et près du cou.';

  @override
  String get ideasLongHairStep5 =>
      'Quelques fins cheveux au marqueur le plus foncé, puis deux ou trois fins cheveux au gel blanc seulement dans la bande de lumière.';

  @override
  String get ideasOverlapGlazesTitle => 'Couches superposées';

  @override
  String get ideasOverlapGlazesSummary =>
      'Superpose trois cercles transparents et regarde quelles nouvelles couleurs apparaissent.';

  @override
  String get ideasOverlapGlazesPractice =>
      'Des couches transparentes : chaque chevauchement est un vrai mélange.';

  @override
  String get ideasOverlapGlazesSubject =>
      'Trois cercles qui se chevauchent, comme un diagramme de Venn.';

  @override
  String get ideasOverlapGlazesTip =>
      'L’ordre compte : la couleur la plus claire dessus change toujours le rendu.';

  @override
  String get ideasOverlapGlazesStep1 =>
      'Dessine au crayon trois cercles qui se chevauchent comme un diagramme de Venn.';

  @override
  String get ideasOverlapGlazesStep2 =>
      'Remplis le premier cercle et laisse-le sécher complètement.';

  @override
  String get ideasOverlapGlazesStep3 =>
      'Remplis le deuxième, chevauchement compris ; le chevauchement devient une troisième couleur.';

  @override
  String get ideasOverlapGlazesStep4 =>
      'Remplis le troisième cercle ; le milieu, où les trois se rencontrent, est le mélange le plus sombre.';

  @override
  String get ideasOverlapGlazesStep5 =>
      'Recommence avec les marqueurs dans un autre ordre : la couleur la plus claire dessus change toujours le rendu.';

  @override
  String get ideasFadedBackgroundTitle => 'Fond estompé';

  @override
  String get ideasFadedBackgroundSummary =>
      'Donne à un dessin un halo de couleur qui s’éteint en blanc bien avant le bord du papier.';

  @override
  String get ideasFadedBackgroundPractice =>
      'Une vignette faite de traits circulaires et du blender.';

  @override
  String get ideasFadedBackgroundSubject =>
      'Une tasse, un oiseau ou n’importe quel petit sujet au milieu de la page.';

  @override
  String get ideasFadedBackgroundTip =>
      'Arrête-toi avant le bord du papier : le halo s’éteint tout seul.';

  @override
  String get ideasFadedBackgroundStep1 =>
      'Dessine au crayon un sujet simple, comme une tasse ou un oiseau, au milieu de la page.';

  @override
  String get ideasFadedBackgroundStep2 =>
      'Colore un anneau de couleur de base autour du sujet, d’un doigt de large, en traits circulaires.';

  @override
  String get ideasFadedBackgroundStep3 =>
      'Passe le marqueur clair de l’anneau vers l’extérieur en cercles qui se chevauchent, jusqu’à ce qu’il pâlisse.';

  @override
  String get ideasFadedBackgroundStep4 =>
      'Continue au blender au-delà de la couleur, en poussant le reste dans le papier pour qu’il n’y ait plus aucun bord.';

  @override
  String get ideasFadedBackgroundStep5 =>
      'Termine le sujet pour qu’il soit plus sombre que le halo.';

  @override
  String get ideasHatchShadingTitle => 'Ombrage hachuré';

  @override
  String get ideasHatchShadingSummary =>
      'Ombre une pomme avec des lignes seulement, sans fondre : hachures pour le ton moyen, hachures croisées pour l’ombre.';

  @override
  String get ideasHatchShadingPractice =>
      'Hachures et hachures croisées : des lignes qui se lisent comme un ton.';

  @override
  String get ideasHatchShadingSubject => 'Une pomme avec la brillance marquée.';

  @override
  String get ideasHatchShadingTip =>
      'Garde les lignes parallèles et régulièrement espacées : l’œil fait le reste.';

  @override
  String get ideasHatchShadingStep1 =>
      'Dessine une pomme au crayon et marque la brillance.';

  @override
  String get ideasHatchShadingStep2 =>
      'Remplis la pomme à plat et laisse sécher.';

  @override
  String get ideasHatchShadingStep3 =>
      'Hachure la moitié à l’ombre avec la pointe fine, en lignes parallèles de plus en plus serrées en t’éloignant de la lumière.';

  @override
  String get ideasHatchShadingStep4 =>
      'Croise la zone la plus sombre avec un second jeu de lignes en biais, et ajoute l’ombre de contact sous la pomme.';

  @override
  String get ideasHatchShadingStep5 =>
      'Recule d’un pas : de loin, les lignes deviennent un ton.';

  @override
  String get ideasCategoryTechnique => 'Techniques';

  @override
  String get ideasCategoryColorChallenge => 'Défis de couleur';

  @override
  String get ideasCategoryMood => 'Ambiances';

  @override
  String get ideasCategorySeason => 'Saisons';

  @override
  String get ideasDifficultyEasy => 'Facile';

  @override
  String get ideasDifficultyMedium => 'Moyen';

  @override
  String get ideasDifficultyHard => 'Difficile';

  @override
  String get ideasSeasonSpring => 'Printemps';

  @override
  String get ideasSeasonSummer => 'Été';

  @override
  String get ideasSeasonAutumn => 'Automne';

  @override
  String get ideasSeasonWinter => 'Hiver';

  @override
  String get ideasSectionAnyTime => 'Toute l’année';

  @override
  String ideasSeeAllSemantic(int count, String category) {
    return 'Voir les $count idées : $category';
  }

  @override
  String get ideasFeaturedLabel => 'Idée du jour';

  @override
  String get ideasOtherMarkersButton => 'Autres marqueurs';

  @override
  String get ideasPracticeTitle => 'Ce que tu travailles';

  @override
  String get ideasSubjectTitle => 'Quoi dessiner';

  @override
  String get ideasMarkersTitle => 'Tes marqueurs';

  @override
  String get ideasStepsTitle => 'Étapes';

  @override
  String get ideasTipTitle => 'Astuce';

  @override
  String get ideasMaterialsTitle => 'Il te faut';

  @override
  String get ideasMaterialPaper =>
      'du papier pour marqueurs avec une feuille dessous';

  @override
  String get ideasMaterialBlender => 'un blender incolore';

  @override
  String get ideasMaterialWhiteGel => 'un stylo gel blanc';

  @override
  String get ideasMaterialPigmentLiner =>
      'un feutre fin noir à encre pigmentée';

  @override
  String get ideasMaterialPencil => 'un crayon';

  @override
  String get ideasMaterialTape => 'du ruban de masquage';

  @override
  String get ideasBackLabel => 'Retour aux idées';

  @override
  String ideasMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String ideasMissingMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il manque $count marqueurs à ta collection pour cette idée.',
      one: 'Il manque 1 marqueur à ta collection pour cette idée.',
    );
    return '$_temp0';
  }

  @override
  String ideasMarkerSemantic(String role, String code, String name) {
    return '$role : $code $name';
  }

  @override
  String get ideasSmoothFillTitle => 'Aplat sans traces';

  @override
  String get ideasSmoothFillSummary =>
      'Remplis un carré avec un seul marqueur sans traces visibles.';

  @override
  String get ideasSmoothFillPractice =>
      'Une couverture régulière et sans traces, la base de tout dessin au marqueur.';

  @override
  String get ideasSmoothFillSubject =>
      'Un carré de 5 × 5 cm délimité au ruban de masquage, puis une forme plate simple, comme une feuille.';

  @override
  String get ideasSmoothFillTip =>
      'Si le papier commence à boulocher, arrête : il est saturé. Laisse-le sécher complètement avant une autre couche.';

  @override
  String get ideasSmoothFillStep1 =>
      'Colle un carré de 5 × 5 cm au ruban sur du papier pour marqueurs et glisse une feuille de brouillon dessous.';

  @override
  String get ideasSmoothFillStep2 =>
      'Remplis le carré avec le marqueur clair en petits cercles qui se chevauchent, sans t’arrêter.';

  @override
  String get ideasSmoothFillStep3 =>
      'Garde un bord humide : repasse toujours sur l’encre encore brillante, jamais sur de l’encre sèche.';

  @override
  String get ideasSmoothFillStep4 =>
      'Laisse sécher, puis applique une seconde couche du même marqueur, perpendiculaire à la première.';

  @override
  String get ideasSmoothFillStep5 =>
      'Refais le carré avec le marqueur plus foncé et compare : les traces se voient davantage sur les couleurs sombres.';

  @override
  String get ideasSmoothFillStep6 =>
      'Retire le ruban lentement pour révéler un bord net.';

  @override
  String get ideasThreeMarkerBlendTitle => 'Dégradé à trois marqueurs';

  @override
  String get ideasThreeMarkerBlendSummary =>
      'Fonds un marqueur clair, un moyen et un foncé d’une même famille sur une balle.';

  @override
  String get ideasThreeMarkerBlendPractice =>
      'Fondre en douceur du clair au foncé dans une même famille de couleur.';

  @override
  String get ideasThreeMarkerBlendSubject =>
      'Une balle éclairée en haut à gauche, avec son ombre sur la table.';

  @override
  String get ideasThreeMarkerBlendTip =>
      'Choisis des marqueurs aux tons proches : si le saut est trop grand, une ligne apparaîtra.';

  @override
  String get ideasThreeMarkerBlendStep1 =>
      'Dessine un cercle au crayon très léger et note d’où vient la lumière.';

  @override
  String get ideasThreeMarkerBlendStep2 =>
      'Couvre toute la balle avec le marqueur clair, en laissant un petit point de papier blanc pour la brillance.';

  @override
  String get ideasThreeMarkerBlendStep3 =>
      'Tant que c’est encore humide, ajoute le marqueur moyen sur la moitié dans l’ombre, par traits courbes qui suivent la forme.';

  @override
  String get ideasThreeMarkerBlendStep4 =>
      'Ajoute le marqueur foncé seulement le long du bord le plus éloigné de la lumière.';

  @override
  String get ideasThreeMarkerBlendStep5 =>
      'Repasse sur les jonctions avec le marqueur moyen, puis avec le clair, pour fondre les paliers.';

  @override
  String get ideasThreeMarkerBlendStep6 =>
      'Adoucis tout bord dur autour de la brillance avec le blender incolore.';

  @override
  String get ideasFlickingTitle => 'Traits rapides (flicking)';

  @override
  String get ideasFlickingSummary =>
      'Dessine des cheveux ou de l’herbe avec des traits rapides qui s’effilent à la fin.';

  @override
  String get ideasFlickingPractice =>
      'Le flicking : des traits rapides qui s’effilent, pour fondre sans bords durs.';

  @override
  String get ideasFlickingSubject =>
      'Une queue de cheval ou une touffe d’herbe.';

  @override
  String get ideasFlickingTip =>
      'Essaie d’abord sur un brouillon : plus tu vas vite, plus la fin du trait est fine.';

  @override
  String get ideasFlickingStep1 =>
      'Esquisse au crayon les mèches ou brins principaux en formes simples, sans détails.';

  @override
  String get ideasFlickingStep2 =>
      'Couvre chaque forme avec le marqueur clair en une couche plate et laisse sécher.';

  @override
  String get ideasFlickingStep3 =>
      'Fais des traits rapides avec le marqueur moyen depuis la racine vers l’extérieur : appuie, va vite et lève avant la fin du trait.';

  @override
  String get ideasFlickingStep4 =>
      'Fais pareil avec le foncé, seulement depuis la racine et plus court, là où les mèches se chevauchent.';

  @override
  String get ideasFlickingStep5 =>
      'Avec le clair, fais des traits des pointes vers la racine pour adoucir le passage entre les tons.';

  @override
  String get ideasFlickingStep6 =>
      'Laisse une bande de la première couche là où les cheveux captent la lumière.';

  @override
  String get ideasGrayscaleTitle => 'Échelle de gris';

  @override
  String get ideasGrayscaleSummary =>
      'Dessine un objet simple avec une seule famille de gris pour voir comment la lumière et l’ombre créent le volume.';

  @override
  String get ideasGrayscalePractice =>
      'Voir la lumière et l’ombre comme des paliers du clair au foncé.';

  @override
  String get ideasGrayscaleSubject =>
      'Une tasse, une pomme ou un œuf sous une seule lampe.';

  @override
  String get ideasGrayscaleTip =>
      'Ne mélange pas gris chauds et gris froids sur le même objet : choisis une seule famille.';

  @override
  String get ideasGrayscaleStep1 =>
      'Choisis un objet simple et note au crayon d’où vient la lumière.';

  @override
  String get ideasGrayscaleStep2 =>
      'Laisse la brillance en papier blanc. Ne colorie jamais dessus.';

  @override
  String get ideasGrayscaleStep3 =>
      'Couvre tout l’objet avec le gris le plus clair et laisse sécher.';

  @override
  String get ideasGrayscaleStep4 =>
      'Ajoute le gris suivant du côté de l’ombre, en fondant le bord tant qu’il est humide.';

  @override
  String get ideasGrayscaleStep5 =>
      'Répète avec chaque gris plus foncé, en couvrant à chaque fois une zone plus petite.';

  @override
  String get ideasGrayscaleStep6 =>
      'Utilise le gris le plus foncé seulement pour l’ombre portée et la ligne de contact sous l’objet.';

  @override
  String get ideasStickerEffectTitle => 'Effet autocollant';

  @override
  String get ideasStickerEffectSummary =>
      'Donne à un personnage l’allure d’un autocollant découpé, avec un contour de papier blanc et un fond coloré.';

  @override
  String get ideasStickerEffectPractice =>
      'Garder volontairement le blanc du papier.';

  @override
  String get ideasStickerEffectSubject =>
      'Un chat, une part de pizza ou une étoile de dessin animé.';

  @override
  String get ideasStickerEffectTip =>
      'Le blanc doit être celui du papier. Le gel blanc sur l’encre de marqueur donne un rendu irrégulier.';

  @override
  String get ideasStickerEffectStep1 =>
      'Dessine ton sujet, puis trace au crayon un second contour à 3–5 mm à l’extérieur : ce sera le bord de l’autocollant.';

  @override
  String get ideasStickerEffectStep2 =>
      'Colorie le sujet du clair au foncé sans toucher le bord.';

  @override
  String get ideasStickerEffectStep3 =>
      'Colorie le fond autour du bord d’une couleur unie, pour que le liseré blanc ressorte.';

  @override
  String get ideasStickerEffectStep4 =>
      'Une fois sec, repasse l’extérieur du bord avec un feutre fin ou un feutre pinceau noir.';

  @override
  String get ideasStickerEffectStep5 =>
      'Ajoute une ombre grise le long d’un côté du bord pour décoller l’autocollant de la page.';

  @override
  String get ideasGlossyCherriesTitle => 'Cerises brillantes';

  @override
  String get ideasGlossyCherriesSummary =>
      'Fais briller deux cerises avec une brillance réservée et une lumière réfléchie.';

  @override
  String get ideasGlossyCherriesPractice =>
      'Des brillances nettes et la lumière réfléchie, les clés d’une surface brillante.';

  @override
  String get ideasGlossyCherriesSubject =>
      'Deux cerises sur leur queue, éclairées d’un côté.';

  @override
  String get ideasGlossyCherriesTip =>
      'Une surface brillante a des brillances aux bords durs : ne les estompe pas, garde le contour net.';

  @override
  String get ideasGlossyCherriesStep1 =>
      'Dessine les cerises au crayon et la forme de chaque brillance : une tache allongée et nette près du haut.';

  @override
  String get ideasGlossyCherriesStep2 =>
      'Couvre chaque cerise avec le marqueur clair en contournant les brillances pour qu’elles restent en papier blanc.';

  @override
  String get ideasGlossyCherriesStep3 =>
      'Pose la couleur de base partout sauf sur un fin croissant le long du bord du bas : c’est la lumière réfléchie.';

  @override
  String get ideasGlossyCherriesStep4 =>
      'Pose l’ombre du côté opposé à la lumière et fonds-la dans la base tant qu’elle est humide.';

  @override
  String get ideasGlossyCherriesStep5 =>
      'Ajoute le marqueur le plus foncé en bande étroite entre l’ombre et la lumière réfléchie.';

  @override
  String get ideasGlossyCherriesStep6 =>
      'Dessine l’ombre sur la table avec le gris puis, une fois sec, ajoute un point de gel blanc sur chaque brillance.';

  @override
  String get ideasColoredShadowsTitle => 'Ombres colorées';

  @override
  String get ideasColoredShadowsSummary =>
      'Ombre deux fois le même citron, une fois en gris et une fois en violet, et compare.';

  @override
  String get ideasColoredShadowsPractice =>
      'Choisir des couleurs d’ombre qui gardent un dessin vivant.';

  @override
  String get ideasColoredShadowsSubject =>
      'Deux citrons côte à côte sur une table blanche.';

  @override
  String get ideasColoredShadowsTip =>
      'Une ombre penche souvent vers l’opposé de la lumière : violet sous le jaune, bleu sous l’orange.';

  @override
  String get ideasColoredShadowsStep1 =>
      'Dessine deux citrons identiques côte à côte, avec la lumière venant du même côté.';

  @override
  String get ideasColoredShadowsStep2 =>
      'Colorie les deux avec le jaune, en laissant une petite brillance de papier blanc.';

  @override
  String get ideasColoredShadowsStep3 =>
      'Sur le premier, ombre avec le gris le côté sombre et l’ombre sur la table.';

  @override
  String get ideasColoredShadowsStep4 =>
      'Sur le second, fais pareil avec le violet, en douceur : une couche suffit.';

  @override
  String get ideasColoredShadowsStep5 =>
      'Repasse le jaune sur le bord de la seconde ombre pour la fondre.';

  @override
  String get ideasColoredShadowsStep6 =>
      'Regarde-les de loin : l’ombre violette paraît plus lumineuse et plus naturelle à côté du jaune.';

  @override
  String get ideasStainedGlassTitle => 'Vitrail';

  @override
  String get ideasStainedGlassSummary =>
      'Colorie les vitres avec de simples dégradés et ajoute les plombs à la fin.';

  @override
  String get ideasStainedGlassPractice =>
      'Des dégradés propres sur de petites zones ; les lignes noires cachent les bords irréguliers.';

  @override
  String get ideasStainedGlassSubject =>
      'Une rosace avec une fleur ou un soleil au centre.';

  @override
  String get ideasStainedGlassTip =>
      'Si tu traces d’abord les lignes noires, utilise une encre pigmentée résistante à l’alcool : une encre ordinaire bave sous le marqueur.';

  @override
  String get ideasStainedGlassStep1 =>
      'Dessine la fenêtre au crayon et divise-la en vitres de tailles différentes.';

  @override
  String get ideasStainedGlassStep2 =>
      'Colorie d’abord les vitres de la couleur principale, chacune en dégradé : plus foncé sur un bord, plus clair au centre.';

  @override
  String get ideasStainedGlassStep3 =>
      'Fais pareil avec la deuxième et la troisième couleur, en laissant sécher chaque vitre avant de colorier la voisine.';

  @override
  String get ideasStainedGlassStep4 =>
      'Utilise l’accent sur quelques petites vitres seulement pour qu’elles ressortent.';

  @override
  String get ideasStainedGlassStep5 =>
      'Quand tout est sec, repasse les bordures en lignes épaisses avec un feutre fin ou un feutre pinceau noir.';

  @override
  String get ideasStainedGlassStep6 =>
      'Ajoute un petit trait de gel blanc sur quelques vitres pour suggérer l’éclat du verre.';

  @override
  String get ideasSwatchChartTitle => 'Ton propre nuancier';

  @override
  String get ideasSwatchChartSummary =>
      'Teste le rendu de chaque marqueur en une, deux et trois couches.';

  @override
  String get ideasSwatchChartPractice =>
      'Savoir comment tes marqueurs rendent vraiment sur le papier, et pas sur le capuchon.';

  @override
  String get ideasSwatchChartSubject =>
      'Une grille avec une ligne par marqueur, regroupée par familles de couleur.';

  @override
  String get ideasSwatchChartTip =>
      'Fais le nuancier sur le papier que tu utilises vraiment : le même marqueur change beaucoup d’un papier à l’autre.';

  @override
  String get ideasSwatchChartStep1 =>
      'Trace une grille sur le papier que tu utilises d’habitude : une ligne par marqueur et quatre cases par ligne.';

  @override
  String get ideasSwatchChartStep2 =>
      'Remplis la première case d’une couche, la deuxième de deux et la troisième de trois, en laissant sécher chaque couche.';

  @override
  String get ideasSwatchChartStep3 =>
      'Dans la quatrième, passe une couche et retire une partie de l’encre avec le blender incolore.';

  @override
  String get ideasSwatchChartStep4 =>
      'Écris le code sous chaque ligne au crayon ou avec un feutre fin.';

  @override
  String get ideasSwatchChartStep5 =>
      'Utilise l’onglet Nuanciers pour repérer les marqueurs que tu possèdes et compare-les avec ton nuancier.';

  @override
  String get ideasOneColorTitle => 'Une seule famille de couleur';

  @override
  String get ideasOneColorSummary =>
      'Dessine une scène entière avec quatre marqueurs d’une seule famille de couleur.';

  @override
  String get ideasOneColorPractice =>
      'Créer de la profondeur avec des couches et des marqueurs plus clairs et plus foncés.';

  @override
  String get ideasOneColorSubject =>
      'Une tasse de thé fumante, ou une petite plante en pot.';

  @override
  String get ideasOneColorTip =>
      'Appuyer moins fort n’éclaircit pas un marqueur. Pour les zones claires, utilise le marqueur plus clair ou le blender incolore.';

  @override
  String get ideasOneColorStep1 =>
      'Choisis un sujet simple et note au crayon d’où vient la lumière.';

  @override
  String get ideasOneColorStep2 =>
      'Couvre tout sauf les brillances avec le marqueur le plus clair.';

  @override
  String get ideasOneColorStep3 =>
      'Ajoute le marqueur de base sur les parties tournées à l’opposé de la lumière.';

  @override
  String get ideasOneColorStep4 =>
      'Pose le marqueur d’ombre dans les zones les plus sombres et fonds les bords tant qu’ils sont humides.';

  @override
  String get ideasOneColorStep5 =>
      'Garde le plus foncé pour les ombres de contact et quelques petits détails.';

  @override
  String get ideasOneColorStep6 =>
      'Pour assombrir un ton sans changer de marqueur, ajoute une autre couche du même une fois la première sèche.';

  @override
  String get ideasTwoMarkersTitle => 'Défi des deux marqueurs';

  @override
  String get ideasTwoMarkersSummary =>
      'Seulement un marqueur clair et un foncé, rien d’autre.';

  @override
  String get ideasTwoMarkersPractice =>
      'Décider avant de commencer ce qui reste clair et ce qui devient foncé.';

  @override
  String get ideasTwoMarkersSubject =>
      'Un champignon, un chat assis ou une maison avec un toit.';

  @override
  String get ideasTwoMarkersTip =>
      'Avec seulement deux marqueurs, le blanc du papier fait une bonne part du travail : prévois-le dès le départ.';

  @override
  String get ideasTwoMarkersStep1 =>
      'Fais d’abord un petit croquis et décide quelles zones sont claires et lesquelles sont foncées.';

  @override
  String get ideasTwoMarkersStep2 =>
      'Couvre tout sauf les brillances avec le marqueur clair.';

  @override
  String get ideasTwoMarkersStep3 =>
      'Ajoute une seconde couche du clair sur les demi-ombres.';

  @override
  String get ideasTwoMarkersStep4 =>
      'Utilise le foncé seulement pour les ombres les plus profondes et quelques détails.';

  @override
  String get ideasTwoMarkersStep5 =>
      'Laisse le papier blanc aux endroits les plus lumineux : c’est ton troisième ton.';

  @override
  String get ideasTwoColorsTitle => 'Deux couleurs opposées';

  @override
  String get ideasTwoColorsSummary =>
      'Utilise deux couleurs opposées et un gris, et garde-les séparées.';

  @override
  String get ideasTwoColorsPractice =>
      'Gérer des couleurs opposées, qui se salissent quand elles se chevauchent.';

  @override
  String get ideasTwoColorsSubject =>
      'Une orange sur une nappe bleue, ou une fleur rouge avec des feuilles vertes.';

  @override
  String get ideasTwoColorsTip =>
      'Deux couleurs opposées superposées virent au gris ou au brun. Ne l’utilise que là où tu veux une ombre terne.';

  @override
  String get ideasTwoColorsStep1 =>
      'Décide quelles zones vont à chaque couleur et garde-les en formes séparées.';

  @override
  String get ideasTwoColorsStep2 =>
      'Colorie les formes de la première couleur, du clair au foncé.';

  @override
  String get ideasTwoColorsStep3 =>
      'Ajoute son ombre tant que la première couche est encore humide.';

  @override
  String get ideasTwoColorsStep4 =>
      'Laisse sécher complètement, puis colorie les formes de la seconde couleur en t’arrêtant à la limite.';

  @override
  String get ideasTwoColorsStep5 =>
      'Ajoute l’ombre de la seconde couleur de la même manière.';

  @override
  String get ideasTwoColorsStep6 =>
      'Utilise le gris pour les ombres qui passent d’une couleur à l’autre.';

  @override
  String get ideasFiftyFiftyTitle => 'Moitié chaud, moitié froid';

  @override
  String get ideasFiftyFiftySummary =>
      'Sépare un dessin en deux : couleurs chaudes d’un côté, froides de l’autre.';

  @override
  String get ideasFiftyFiftyPractice =>
      'Voir comment les couleurs chaudes et froides changent l’ambiance d’un même sujet.';

  @override
  String get ideasFiftyFiftySubject =>
      'Un visage ou une maison coupés en deux.';

  @override
  String get ideasFiftyFiftyTip =>
      'Les bords humides coulent l’un dans l’autre : ne laisse jamais une zone chaude humide toucher une zone froide humide.';

  @override
  String get ideasFiftyFiftyStep1 =>
      'Dessine ton sujet et une ligne qui le sépare en deux.';

  @override
  String get ideasFiftyFiftyStep2 =>
      'Colorie d’abord la moitié chaude, du clair au foncé.';

  @override
  String get ideasFiftyFiftyStep3 =>
      'Ajoute ses ombres et laisse toute cette moitié sécher complètement.';

  @override
  String get ideasFiftyFiftyStep4 =>
      'Colorie la moitié froide en t’arrêtant à un millimètre de la ligne, et comble l’espace une fois l’autre côté sec.';

  @override
  String get ideasFiftyFiftyStep5 =>
      'Ajoute les ombres froides aux mêmes endroits que sur la moitié chaude.';

  @override
  String get ideasFiftyFiftyStep6 =>
      'Utilise le gris seulement aux points les plus sombres, pour que les deux moitiés le partagent.';

  @override
  String get ideasRandomColorsTitle => 'Cinq marqueurs au hasard';

  @override
  String get ideasRandomColorsSummary =>
      'Dessine ce que tu veux avec cinq marqueurs tirés au hasard dans ta collection.';

  @override
  String get ideasRandomColorsPractice =>
      'Faire fonctionner n’importe quelles couleurs en maîtrisant les clairs et les foncés.';

  @override
  String get ideasRandomColorsSubject =>
      'Ce que tu veux : un oiseau, une théière ou un monstre.';

  @override
  String get ideasRandomColorsTip =>
      'Le clair et le foncé comptent plus que la couleur : un dessin bien contrasté marche avec presque toutes les couleurs.';

  @override
  String get ideasRandomColorsStep1 =>
      'Regarde les cinq marqueurs ci-dessus : ils sont classés du plus clair au plus foncé.';

  @override
  String get ideasRandomColorsStep2 =>
      'Utilise le plus clair pour les grandes zones éclairées.';

  @override
  String get ideasRandomColorsStep3 =>
      'Utilise ceux du milieu pour les formes principales.';

  @override
  String get ideasRandomColorsStep4 =>
      'Garde le plus foncé pour les ombres et les contours.';

  @override
  String get ideasRandomColorsStep5 =>
      'Si deux couleurs jurent, sépare-les par un fin trait de papier blanc.';

  @override
  String get ideasRandomColorsStep6 =>
      'Touche Autres marqueurs pour un nouveau tirage et réessaie.';

  @override
  String get ideasUnlikelyColorsTitle => 'Couleurs inattendues';

  @override
  String get ideasUnlikelyColorsSummary =>
      'Colorie un objet familier avec des couleurs qui ne sont pas les siennes.';

  @override
  String get ideasUnlikelyColorsPractice =>
      'Respecter les clairs et les foncés pour que l’objet reste lisible, quelle que soit sa couleur.';

  @override
  String get ideasUnlikelyColorsSubject =>
      'Une banane, un chien ou ta propre basket.';

  @override
  String get ideasUnlikelyColorsTip =>
      'Si tu plisses les yeux et que le dessin se lit encore, les clairs et les foncés sont justes, quelles que soient les couleurs.';

  @override
  String get ideasUnlikelyColorsStep1 =>
      'Dessine l’objet d’après nature ou une photo et repère où sont ses zones claires et foncées.';

  @override
  String get ideasUnlikelyColorsStep2 =>
      'Utilise le marqueur le plus clair là où l’objet réel est le plus clair.';

  @override
  String get ideasUnlikelyColorsStep3 =>
      'Utilise la base là où l’objet réel a ses tons moyens.';

  @override
  String get ideasUnlikelyColorsStep4 =>
      'Utilise le marqueur d’ombre là où l’objet réel est le plus foncé.';

  @override
  String get ideasUnlikelyColorsStep5 =>
      'Ajoute l’accent sur une petite zone pour attirer le regard.';

  @override
  String get ideasPastelTitle => 'Tons pastel';

  @override
  String get ideasPastelSummary =>
      'Colorie un dessin doux et aérien avec des marqueurs clairs et beaucoup de papier blanc.';

  @override
  String get ideasPastelPractice =>
      'Des couches claires et régulières, et garder le blanc du papier.';

  @override
  String get ideasPastelSubject =>
      'Un cupcake, un lapin ou un bouquet de fleurs.';

  @override
  String get ideasPastelTip =>
      'Appuyer moins fort n’éclaircit pas un marqueur : choisis plutôt un marqueur plus clair.';

  @override
  String get ideasPastelStep1 =>
      'Choisis un sujet tout doux et garde les traits de crayon très légers.';

  @override
  String get ideasPastelStep2 =>
      'Décide où le papier reste blanc : les brillances et une partie du fond.';

  @override
  String get ideasPastelStep3 =>
      'Colorie chaque zone avec un marqueur clair en une seule couche régulière, en petits cercles.';

  @override
  String get ideasPastelStep4 =>
      'Fais l’ombre avec une seconde couche du même marqueur, pas avec une couleur plus foncée.';

  @override
  String get ideasPastelStep5 =>
      'Utilise le marqueur un peu plus intense seulement pour les plus petites ombres.';

  @override
  String get ideasPastelStep6 =>
      'Adoucis tout bord dur avec le blender incolore.';

  @override
  String get ideasSkinTonesTitle => 'Peau avec quatre marqueurs';

  @override
  String get ideasSkinTonesSummary =>
      'Colorie un visage avec un ton clair, une base, une ombre et un blush.';

  @override
  String get ideasSkinTonesPractice =>
      'Fondre la peau en douceur et utiliser des ombres chaudes sur un visage.';

  @override
  String get ideasSkinTonesSubject =>
      'Un visage de trois quarts, éclairé d’un côté.';

  @override
  String get ideasSkinTonesTip =>
      'Les ombres de la peau sont chaudes : évite les gris, ils salissent le visage.';

  @override
  String get ideasSkinTonesStep1 =>
      'Dessine le visage légèrement et marque les formes d’ombre : sous le sourcil, à côté du nez, sous la lèvre et le long de la mâchoire.';

  @override
  String get ideasSkinTonesStep2 =>
      'Couvre toute la peau avec le marqueur clair, en laissant en papier blanc les points les plus lumineux du front, du nez et de la joue.';

  @override
  String get ideasSkinTonesStep3 =>
      'Tant que c’est humide, ajoute le blush sur les joues, le bout du nez et les oreilles.';

  @override
  String get ideasSkinTonesStep4 =>
      'Pose la base sur les formes d’ombre et fonds leurs bords avec le marqueur clair.';

  @override
  String get ideasSkinTonesStep5 =>
      'Utilise celui d’ombre seulement là où les formes se rejoignent : sous le menton, dans l’oreille et autour des narines.';

  @override
  String get ideasSkinTonesStep6 =>
      'Adoucis toute ligne dure avec le marqueur clair plutôt qu’avec le blender incolore, pour que la peau ne devienne pas tachetée.';

  @override
  String get ideasMidnightTitle => 'Nuit de pleine lune';

  @override
  String get ideasMidnightSummary =>
      'Une petite maison la nuit, éclairée par la lune et une fenêtre chaude.';

  @override
  String get ideasMidnightPractice =>
      'Préparer une scène de nuit : ombres froides et quelques lumières chaudes et nettes.';

  @override
  String get ideasMidnightSubject =>
      'Une petite maison la nuit avec une fenêtre allumée.';

  @override
  String get ideasMidnightTip =>
      'Ne laisse pas le bleu et le jaune se toucher tant que l’un des deux est humide : ensemble, ils virent au vert.';

  @override
  String get ideasMidnightStep1 =>
      'Avant de commencer, décide où sont les lumières : la lune et la fenêtre restent en papier blanc.';

  @override
  String get ideasMidnightStep2 =>
      'Colorie la fenêtre et un halo doux autour avec le jaune, et laisse sécher complètement.';

  @override
  String get ideasMidnightStep3 =>
      'Couvre le ciel et les murs éclairés avec le bleu clair, en t’éloignant de la lune.';

  @override
  String get ideasMidnightStep4 =>
      'Ajoute le bleu de base partout où c’est dans l’ombre, à quelques millimètres du halo jaune.';

  @override
  String get ideasMidnightStep5 =>
      'Assombris le ciel vers le haut et les ombres sous le toit et les arbres.';

  @override
  String get ideasMidnightStep6 =>
      'Utilise le plus foncé pour les ombres les plus profondes et, une fois sec, ajoute quelques étoiles au gel blanc.';

  @override
  String get ideasUnderwaterTitle => 'Sous la mer';

  @override
  String get ideasUnderwaterSummary =>
      'Des rayons de soleil dans l’eau bleue autour d’un petit poisson.';

  @override
  String get ideasUnderwaterPractice =>
      'Dégager des rayons de lumière avec le blender incolore.';

  @override
  String get ideasUnderwaterSubject =>
      'Un petit poisson nageant au-dessus d’un corail.';

  @override
  String get ideasUnderwaterTip =>
      'Essaie d’abord les rayons au blender sur un brouillon : ils ne marchent que tant que l’encre est encore un peu humide.';

  @override
  String get ideasUnderwaterStep1 =>
      'Colorie d’abord le poisson et le corail avec l’accent et laisse-les sécher.';

  @override
  String get ideasUnderwaterStep2 =>
      'Couvre l’eau avec le bleu clair, en t’arrêtant juste avant le poisson.';

  @override
  String get ideasUnderwaterStep3 =>
      'Ajoute le bleu de base sur la moitié du bas et fonds-le vers le haut tant qu’il est humide.';

  @override
  String get ideasUnderwaterStep4 =>
      'Assombris le fond et la zone derrière le poisson pour le faire ressortir.';

  @override
  String get ideasUnderwaterStep5 =>
      'Tant que les bleus sont humides, tire des rayons en diagonale depuis la surface avec le blender incolore : il repousse l’encre.';

  @override
  String get ideasUnderwaterStep6 =>
      'Ajoute le plus foncé tout en bas et, une fois sec, termine avec de minuscules bulles au gel blanc.';

  @override
  String get ideasGalaxyTitle => 'Galaxie';

  @override
  String get ideasGalaxySummary =>
      'Fonds les couleurs lumineuses d’une nébuleuse dans un ciel sombre et termine avec des étoiles.';

  @override
  String get ideasGalaxyPractice =>
      'Fondre en humide sur humide, et retirer de l’encre pour faire des étoiles.';

  @override
  String get ideasGalaxySubject =>
      'Une nébuleuse au-dessus de la silhouette d’une montagne.';

  @override
  String get ideasGalaxyTip =>
      'Mets peu de grandes étoiles : trop d’étoiles aplatissent la profondeur.';

  @override
  String get ideasGalaxyStep1 =>
      'Utilise du papier pour marqueurs qui ne traverse pas et glisse une feuille dessous : cet exercice demande beaucoup d’encre.';

  @override
  String get ideasGalaxyStep2 =>
      'Commence par les couleurs les plus claires de la nébuleuse, en nuages doux et irréguliers.';

  @override
  String get ideasGalaxyStep3 =>
      'Tant qu’ils sont humides, fonds la couleur du milieu dans leurs bords.';

  @override
  String get ideasGalaxyStep4 =>
      'Remplis le reste du ciel avec les marqueurs les plus foncés, en allant vers les nuages, pas par-dessus.';

  @override
  String get ideasGalaxyStep5 =>
      'Tamponne le blender incolore sur les zones sombres pour retirer de petits points d’encre : ce seront des étoiles lointaines.';

  @override
  String get ideasGalaxyStep6 =>
      'Une fois sec, ajoute quelques étoiles brillantes et une étincelle en croix au gel blanc.';

  @override
  String get ideasNeonTitle => 'Enseigne néon';

  @override
  String get ideasNeonSummary =>
      'Fais briller une enseigne avec un cœur blanc et un fond sombre.';

  @override
  String get ideasNeonPractice =>
      'La lueur : un cœur blanc, un halo vif et un fond sombre.';

  @override
  String get ideasNeonSubject =>
      'Le mot OPEN, ou un cœur dessiné comme un tube de néon.';

  @override
  String get ideasNeonTip =>
      'Les marqueurs fluo sont transparents : utilise-les sur du blanc, jamais sur de l’encre sombre.';

  @override
  String get ideasNeonStep1 =>
      'Dessine au crayon un mot ou une forme simple avec des traits épais.';

  @override
  String get ideasNeonStep2 =>
      'Laisse un fin trait de papier blanc au milieu de chaque trait : c’est le cœur lumineux.';

  @override
  String get ideasNeonStep3 =>
      'Colorie le reste du trait avec la version claire de ta couleur néon.';

  @override
  String get ideasNeonStep4 =>
      'Fais des traits rapides de la couleur vive vers l’extérieur pour créer un halo doux.';

  @override
  String get ideasNeonStep5 =>
      'Quand le halo est sec, remplis le fond avec le marqueur le plus foncé, en t’arrêtant à quelques millimètres du halo.';

  @override
  String get ideasNeonStep6 =>
      'Fonds cet espace avec le marqueur foncé pour que la lueur s’éteigne dans la nuit.';

  @override
  String get ideasSepiaPhotoTitle => 'Vieille photo sépia';

  @override
  String get ideasSepiaPhotoSummary =>
      'Dessine un portrait ou un bâtiment comme s’il s’agissait d’une vieille photo brune.';

  @override
  String get ideasSepiaPhotoPractice =>
      'Travailler avec une seule famille chaude de bruns, comme une étude de clairs et de foncés en couleur.';

  @override
  String get ideasSepiaPhotoSubject =>
      'Une vieille maison, un chapeau de cow-boy ou un portrait de grand-parent.';

  @override
  String get ideasSepiaPhotoTip =>
      'Évite le noir et les gris froids : ils cassent l’aspect chaud du sépia.';

  @override
  String get ideasSepiaPhotoStep1 =>
      'Dessine le sujet au crayon et encadre-le d’une bordure qui reste en papier blanc.';

  @override
  String get ideasSepiaPhotoStep2 =>
      'Couvre tout sauf les points les plus lumineux avec le brun le plus clair.';

  @override
  String get ideasSepiaPhotoStep3 =>
      'Construis les tons moyens avec le brun de base.';

  @override
  String get ideasSepiaPhotoStep4 =>
      'Ajoute les ombres avec le brun d’ombre, en fondant les bords tant qu’ils sont humides.';

  @override
  String get ideasSepiaPhotoStep5 =>
      'Utilise le brun le plus foncé à la place du noir pour les ombres les plus profondes.';

  @override
  String get ideasSepiaPhotoStep6 =>
      'Assombris légèrement les coins de l’image avec le gris chaud pour la vieillir.';

  @override
  String get ideasSunsetTitle => 'Ciel de coucher de soleil';

  @override
  String get ideasSunsetSummary =>
      'Fonds un ciel du jaune au violet et ajoute une silhouette sombre.';

  @override
  String get ideasSunsetPractice =>
      'Fondre en humide des couleurs voisines sur une grande surface.';

  @override
  String get ideasSunsetSubject =>
      'Un coucher de soleil sur la mer avec un palmier ou une ville en silhouette.';

  @override
  String get ideasSunsetTip =>
      'Ne fonds que des couleurs voisines : le jaune à côté du violet vire au brun tant qu’il est humide.';

  @override
  String get ideasSunsetStep1 =>
      'Dessine au crayon l’horizon et la silhouette ; laisse le soleil en cercle de papier blanc.';

  @override
  String get ideasSunsetStep2 =>
      'Commence par le soleil : colorie une large bande de jaune autour.';

  @override
  String get ideasSunsetStep3 =>
      'Tant que le jaune est humide, ajoute l’orange au-dessus et fonds la jonction.';

  @override
  String get ideasSunsetStep4 =>
      'Continue vers le haut avec le rose, en fondant chaque bande dans la précédente tant qu’elle est humide.';

  @override
  String get ideasSunsetStep5 => 'Termine le haut du ciel avec le violet.';

  @override
  String get ideasSunsetStep6 =>
      'Quand le ciel est sec, remplis la silhouette avec le marqueur le plus foncé en traits plats et réguliers.';

  @override
  String get ideasSpringTitle => 'Cerisier en fleurs';

  @override
  String get ideasSpringSummary =>
      'Une branche de cerisier en fleurs aux pétales d’un rose doux.';

  @override
  String get ideasSpringPractice =>
      'Des pétales délicats : couches claires et bords doux.';

  @override
  String get ideasSpringSubject =>
      'Une branche avec cinq ou six fleurs et quelques feuilles.';

  @override
  String get ideasSpringTip =>
      'Les pétales sont fins : deux couches claires rendent plus délicat qu’une seule foncée.';

  @override
  String get ideasSpringStep1 =>
      'Dessine la branche et les fleurs légèrement, avec cinq pétales chacune.';

  @override
  String get ideasSpringStep2 =>
      'Colorie chaque pétale avec le rose clair, en laissant un fin liseré blanc sur certains.';

  @override
  String get ideasSpringStep3 =>
      'Ajoute le rose de base près du centre de chaque fleur, en traits rapides vers l’extérieur.';

  @override
  String get ideasSpringStep4 =>
      'Touche le rose le plus intense seulement au centre et là où les pétales se chevauchent.';

  @override
  String get ideasSpringStep5 =>
      'Colorie les feuilles et les jeunes pousses avec le vert.';

  @override
  String get ideasSpringStep6 =>
      'Ombre le dessous des feuilles avec le vert foncé.';

  @override
  String get ideasAutumnTitle => 'Feuilles d’automne';

  @override
  String get ideasAutumnSummary =>
      'Une nature morte de feuilles tombées aux couleurs chaudes et lumineuses.';

  @override
  String get ideasAutumnPractice =>
      'Fondre des couleurs chaudes voisines et garder les nervures claires.';

  @override
  String get ideasAutumnSubject =>
      'Trois feuilles tombées sur une table : chêne, érable et châtaignier.';

  @override
  String get ideasAutumnTip =>
      'Laisse les nervures en ligne plus claire : c’est plus simple que de les dessiner par-dessus ensuite.';

  @override
  String get ideasAutumnStep1 =>
      'Dessine les feuilles et leurs nervures principales au crayon léger.';

  @override
  String get ideasAutumnStep2 =>
      'Colorie la feuille la plus claire avec le jaune, en contournant les nervures pour qu’elles restent claires.';

  @override
  String get ideasAutumnStep3 =>
      'Colorie la feuille suivante avec l’orange clair et fonds un peu de jaune dans ses bords tant qu’elle est humide.';

  @override
  String get ideasAutumnStep4 =>
      'Colorie la troisième avec la base et fonds l’orange clair dans sa pointe.';

  @override
  String get ideasAutumnStep5 =>
      'Ajoute le rouge le long des bords et par endroits, comme si la feuille changeait de couleur.';

  @override
  String get ideasAutumnStep6 =>
      'Ombre avec l’orange foncé là où les feuilles se chevauchent et là où elles touchent la table.';

  @override
  String get ideasWinterTitle => 'Cabane enneigée';

  @override
  String get ideasWinterSummary =>
      'Une cabane dans la neige où le blanc est le papier lui-même.';

  @override
  String get ideasWinterPractice =>
      'Dessiner la neige avec des ombres gris-bleu et beaucoup de papier blanc.';

  @override
  String get ideasWinterSubject =>
      'Une cabane en bois avec de la neige sur le toit et une fenêtre allumée.';

  @override
  String get ideasWinterTip =>
      'N’ombre pas la neige avec un gris chaud : les gris-bleu la rendent froide et propre.';

  @override
  String get ideasWinterStep1 =>
      'Dessine la cabane au crayon et où s’arrête la neige : la neige, c’est le papier blanc, alors prévois-la d’abord.';

  @override
  String get ideasWinterStep2 =>
      'Colorie la fenêtre avec le jaune et laisse sécher.';

  @override
  String get ideasWinterStep3 =>
      'Colorie les murs en bois avec le brun sans toucher la neige du toit.';

  @override
  String get ideasWinterStep4 =>
      'Ombre la neige avec le gris-bleu clair seulement là où la lumière n’arrive pas.';

  @override
  String get ideasWinterStep5 =>
      'Ajoute le gris-bleu plus foncé sous le toit et dans les traces de pas, en le fondant dans le clair.';

  @override
  String get ideasWinterStep6 =>
      'Utilise le plus foncé pour la porte et les ombres les plus profondes et, une fois sec, ajoute des flocons au gel blanc.';

  @override
  String get ideasChristmasTitle => 'Boules de Noël';

  @override
  String get ideasChristmasSummary =>
      'De brillantes boules rouges suspendues à une branche de sapin verte.';

  @override
  String get ideasChristmasPractice =>
      'Des formes rondes et brillantes avec une brillance réservée et des reflets.';

  @override
  String get ideasChristmasSubject =>
      'Deux boules rouges suspendues à une branche de sapin.';

  @override
  String get ideasChristmasTip =>
      'Dessine la branche après les boules, pour que le vert ne coule jamais dans le rouge.';

  @override
  String get ideasChristmasStep1 =>
      'Dessine les boules et prévois sur chacune une brillance en forme de fenêtre.';

  @override
  String get ideasChristmasStep2 =>
      'Couvre chaque boule avec le rouge clair, en contournant la brillance.';

  @override
  String get ideasChristmasStep3 =>
      'Ajoute le rouge de base en anneau qui suit la forme ronde, en laissant le centre plus clair.';

  @override
  String get ideasChristmasStep4 =>
      'Assombris le bord le plus éloigné de la lumière, en gardant un fin liseré plus clair pour le reflet.';

  @override
  String get ideasChristmasStep5 =>
      'Fais les aiguilles de la branche avec le vert, en traits rapides de la tige vers l’extérieur.';

  @override
  String get ideasChristmasStep6 =>
      'Ajoute le vert foncé là où les aiguilles se chevauchent et, une fois sec, une étincelle de gel blanc sur chaque boule.';

  @override
  String get ideasHalloweenTitle => 'Citrouille d’Halloween';

  @override
  String get ideasHalloweenSummary =>
      'Une citrouille sculptée qui brille dans une nuit violet foncé.';

  @override
  String get ideasHalloweenPractice =>
      'La lumière qui vient de l’intérieur d’un objet, sur un fond sombre.';

  @override
  String get ideasHalloweenSubject =>
      'Une citrouille sculptée avec une bougie à l’intérieur, sur un perron.';

  @override
  String get ideasHalloweenTip =>
      'Pose le fond sombre en dernier et lentement près du bord : l’encre foncée coule vers les zones claires.';

  @override
  String get ideasHalloweenStep1 =>
      'Dessine la citrouille et son visage sculpté ; l’intérieur du visage sera la partie la plus lumineuse.';

  @override
  String get ideasHalloweenStep2 =>
      'Colorie les creux sculptés avec l’orange clair, en laissant un cœur blanc au milieu.';

  @override
  String get ideasHalloweenStep3 =>
      'Colorie la citrouille avec l’orange de base, en suivant ses côtes par traits courbes.';

  @override
  String get ideasHalloweenStep4 =>
      'Ombre les creux entre les côtes et le côté opposé à la lueur.';

  @override
  String get ideasHalloweenStep5 => 'Colorie la queue avec le vert.';

  @override
  String get ideasHalloweenStep6 =>
      'Quand tout est sec, remplis la nuit avec le violet foncé, en commençant à quelques millimètres de la citrouille.';

  @override
  String get ideasRoleLight => 'Lumière';

  @override
  String get ideasReasonLight => 'Première couche, presque partout';

  @override
  String get ideasRoleLightMid => 'Clair moyen';

  @override
  String get ideasReasonLightMid =>
      'Deuxième palier, adoucit le passage à la base';

  @override
  String get ideasRoleBase => 'Base';

  @override
  String get ideasReasonBase => 'Couleur principale des formes';

  @override
  String get ideasRoleShadow => 'Ombre';

  @override
  String get ideasReasonShadow => 'Là où la lumière n’arrive pas';

  @override
  String get ideasRoleDeepShadow => 'Ombre profonde';

  @override
  String get ideasReasonDeepShadow =>
      'Seulement les recoins les plus sombres et les lignes de contact';

  @override
  String get ideasRoleShadowGray => 'Gris d’ombre';

  @override
  String get ideasReasonShadowGray => 'Ombres neutres et ombres portées';

  @override
  String get ideasRoleAccent => 'Accent';

  @override
  String get ideasReasonAccent => 'Petites touches qui attirent le regard';

  @override
  String get ideasRoleBackground => 'Fond';

  @override
  String get ideasReasonBackground => 'Autour du sujet, posé en dernier';

  @override
  String get ideasRoleMainColor => 'Couleur principale';

  @override
  String get ideasReasonMainColor => 'Première couleur du duo';

  @override
  String get ideasRoleMainShadow => 'Ombre principale';

  @override
  String get ideasReasonMainShadow => 'Ombre de la première couleur';

  @override
  String get ideasRoleSecondColor => 'Deuxième couleur';

  @override
  String get ideasReasonSecondColor => 'Deuxième couleur du schéma';

  @override
  String get ideasRoleSecondShadow => 'Deuxième ombre';

  @override
  String get ideasReasonSecondShadow => 'Ombre de la deuxième couleur';

  @override
  String get ideasRoleThirdColor => 'Troisième couleur';

  @override
  String get ideasReasonThirdColor => 'Troisième couleur du schéma';

  @override
  String get ideasRoleBlush => 'Blush';

  @override
  String get ideasReasonBlush => 'Joues, nez et oreilles, fondu en humide';

  @override
  String get ideasRoleWarmLight => 'Lumière chaude';

  @override
  String get ideasReasonWarmLight => 'Zones éclairées de la moitié chaude';

  @override
  String get ideasRoleWarmShadow => 'Ombre chaude';

  @override
  String get ideasReasonWarmShadow => 'Ombres de la moitié chaude';

  @override
  String get ideasRoleCoolLight => 'Lumière froide';

  @override
  String get ideasReasonCoolLight => 'Zones éclairées de la moitié froide';

  @override
  String get ideasRoleCoolShadow => 'Ombre froide';

  @override
  String get ideasReasonCoolShadow => 'Ombres de la moitié froide';

  @override
  String get ideasRoleColorShadow => 'Ombre colorée';

  @override
  String get ideasReasonColorShadow =>
      'Une ombre colorée à comparer avec la grise';

  @override
  String get matchTitle => 'Associer';

  @override
  String get matchPrivacyCaption => 'Les photos restent sur ce téléphone.';

  @override
  String get matchCameraButton => 'Caméra';

  @override
  String get matchGalleryButton => 'Galerie';

  @override
  String get matchLoadingPhoto => 'Lecture de la photo…';

  @override
  String get matchEmptyPhotoTitle => 'Trouver une couleur à partir d’une photo';

  @override
  String get matchEmptyPhotoMessage =>
      'Prends une photo, touche une couleur et vois les marqueurs les plus proches.';

  @override
  String get matchPhotoSemantics => 'Photo où prélever une couleur';

  @override
  String get matchPickToSample =>
      'Touche ou fais glisser sur la photo pour prélever une couleur.';

  @override
  String get matchSampledLabel => 'Prélevée';

  @override
  String get matchBestMatchTitle => 'Meilleure correspondance';

  @override
  String get matchAlternatesTitle => 'Alternatives';

  @override
  String get matchSaveButton => 'Enregistrer';

  @override
  String get matchRecentTitle => 'Choix récents';

  @override
  String get matchRecentDetailSampled => 'Prélevée';

  @override
  String get matchRecentEmpty =>
      'Aucun choix récent pour l’instant. Touche une correspondance pour l’enregistrer ici.';

  @override
  String get matchClearButton => 'Effacer';

  @override
  String get matchRemoveTooltip => 'Retirer';

  @override
  String get matchCloseTooltip => 'Fermer';

  @override
  String get matchRecentPickLabel => 'Choix récent';

  @override
  String get matchClearDialogTitle => 'Effacer les choix récents ?';

  @override
  String get matchClearDialogBody =>
      'Tous les choix enregistrés sont supprimés. Cette action est irréversible.';

  @override
  String get matchCancelButton => 'Annuler';

  @override
  String get matchCancelNotice => 'Aucune photo sélectionnée.';

  @override
  String get matchCameraDenied =>
      'L’accès à l’appareil photo est désactivé. Autorise-le dans les réglages de l’appareil, ou choisis plutôt une photo dans la galerie.';

  @override
  String get matchGalleryDenied =>
      'L’accès aux photos est désactivé. Autorise-le dans les réglages de l’appareil, puis réessaie.';

  @override
  String get matchDecodeFailed =>
      'Impossible de lire cette photo. Essaie-en une autre.';

  @override
  String get matchPickFailed => 'Impossible d’ouvrir la photo. Réessaie.';

  @override
  String get matchOkButton => 'OK';

  @override
  String get matchTakePhotoButton => 'Prendre une photo';

  @override
  String get matchChooseGalleryButton => 'Choisir dans la galerie';

  @override
  String get matchValuesButton => 'Valeurs';

  @override
  String get matchValuesTooltip =>
      'Affiche la photo et les correspondances en niveaux de gris pour vérifier le contraste des valeurs';

  @override
  String get matchPhotoSampleHint =>
      'Touche deux fois pour prélever le centre de la photo. Utilise les actions pour déplacer le point.';

  @override
  String get matchSampleMiddle => 'Prélever le centre de la photo';

  @override
  String get matchMoveLeft => 'Déplacer le point vers la gauche';

  @override
  String get matchMoveRight => 'Déplacer le point vers la droite';

  @override
  String get matchMoveUp => 'Déplacer le point vers le haut';

  @override
  String get matchMoveDown => 'Déplacer le point vers le bas';

  @override
  String matchSampleSpoken(
    String hex,
    String code,
    String name,
    String quality,
  ) {
    return 'Couleur prélevée $hex. Marqueur le plus proche : $code, $name, $quality.';
  }

  @override
  String matchSampleSpokenNone(String hex) {
    return 'Couleur prélevée $hex.';
  }

  @override
  String get appTitle => 'Ink Lab';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOwned => 'Possédé';

  @override
  String get commonFavourite => 'Favori';

  @override
  String get commonAddToFavourites => 'Ajouter aux favoris';

  @override
  String get commonRemoveFromFavourites => 'Retirer des favoris';

  @override
  String get commonClearSearch => 'Effacer la recherche';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonMoreActions => 'Plus d’actions';

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
  String get commonBaseLocked => 'Base verrouillée';

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
    return 'Ancien $code';
  }

  @override
  String commonMarkersAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs disponibles',
      one: '$count marqueur disponible',
    );
    return '$_temp0';
  }

  @override
  String commonColorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count couleurs',
      one: '$count couleur',
    );
    return '$_temp0';
  }

  @override
  String commonCardLocation(int number) {
    return 'Carte de nuancier $number';
  }

  @override
  String navTabHint(int index, int count) {
    return 'Onglet $index sur $count';
  }

  @override
  String get settingsLanguageTitle => 'Langue';

  @override
  String get settingsLanguageSystem => 'Système';

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
    return '$owned marqueurs sur $total';
  }

  @override
  String settingsPacksSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count coffrets sélectionnés',
      one: '$count coffret sélectionné',
    );
    return '$_temp0';
  }

  @override
  String settingsImportUnsupportedVersion(int version) {
    return 'Cette sauvegarde a une version non prise en charge : $version.';
  }

  @override
  String settingsImportFailed(String reason) {
    return 'Impossible d’importer la sauvegarde : $reason';
  }

  @override
  String settingsAiOnDeviceProgressTotal(
    String bytes,
    String total,
    int percent,
  ) {
    return '$bytes Mo sur $total Mo téléchargés ($percent %)';
  }

  @override
  String settingsAiOnDeviceProgressBytes(String bytes) {
    return '$bytes Mo téléchargés';
  }

  @override
  String settingsAiConnectionOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modèles disponibles',
      one: '$count modèle disponible',
    );
    return 'Connexion réussie ($_temp0).';
  }

  @override
  String settingsAiConnectionFailed(String reason) {
    return 'Échec de la connexion : $reason';
  }

  @override
  String settingsAiFallbacksCount(int count, int max) {
    return '$count sur $max';
  }

  @override
  String settingsAiUseTyped(String id) {
    return 'Utiliser « $id »';
  }

  @override
  String settingsAiFallbacksHint(int max) {
    return 'Essayés dans l’ordre quand le modèle ci-dessus échoue (jusqu’à $max).';
  }

  @override
  String get settingsAiOnDeviceUnavailable =>
      'L’IA sur l’appareil n’est pas disponible sur ce téléphone pour le moment. La théorie des couleurs est utilisée en attendant.';

  @override
  String get settingsAiOnDeviceNotEnabledIos =>
      'Pour utiliser l’IA sur l’appareil, active Apple Intelligence dans Réglages → Apple Intelligence et Siri.';

  @override
  String paletteSizeChip(int size) {
    return '$size couleurs';
  }

  @override
  String paletteAiLabel(String name) {
    return 'IA · $name';
  }

  @override
  String paletteAiLabelPartial(String name, int aiCount, int total) {
    return 'IA + théorie des couleurs · $name · $aiCount/$total';
  }

  @override
  String paletteResultTitle(int count) {
    return 'Combinaisons ($count)';
  }

  @override
  String paletteSavedSubtitle(String mode, int size) {
    return '$mode · $size couleurs';
  }

  @override
  String paletteSubtitleCustom(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs',
      one: '$count marqueur',
    );
    return 'Palette personnalisée · $_temp0';
  }

  @override
  String paletteSavedNotice(String name) {
    return 'Palette « $name » enregistrée.';
  }

  @override
  String paletteLoadedNotice(String name) {
    return 'Palette « $name » chargée.';
  }

  @override
  String paletteVariationApplied(String label) {
    return 'Variante appliquée : $label.';
  }

  @override
  String paletteDraftApplied(int count) {
    return 'Palette d’Idées appliquée ($count couleurs).';
  }

  @override
  String paletteUsingDefaultBase(String code, String scenario) {
    return '$code est utilisé comme base par défaut pour $scenario. Saisis un code pour la changer.';
  }

  @override
  String paletteUnknownCode(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input n’est pas un code de marqueur DecoTime. Essaie $example.',
      'copic': '$input n’est pas un code de marqueur Copic. Essaie $example.',
      'finecolour':
          '$input n’est pas un code de marqueur Finecolour. Essaie $example.',
      'touchTwin':
          '$input n’est pas un code de marqueur Touch Twin. Essaie $example.',
      'promarker':
          '$input n’est pas un code de marqueur Promarker. Essaie $example.',
      'prismacolor':
          '$input n’est pas un code de marqueur Prismacolor Premier. Essaie $example.',
      'spectrumNoir':
          '$input n’est pas un code de marqueur Spectrum Noir. Essaie $example.',
      'promarkerBrush':
          '$input n’est pas un code de marqueur Promarker Brush. Essaie $example.',
      'arrtx': '$input n’est pas un code de marqueur Arrtx. Essaie $example.',
      'kurecolor':
          '$input n’est pas un code de marqueur ZIG Kurecolor. Essaie $example.',
      'graphit':
          '$input n’est pas un code de marqueur Graph\'it. Essaie $example.',
      'marvyLePlume':
          '$input n’est pas un code de marqueur Marvy Le Plume. Essaie $example.',
      'blickBrush':
          '$input n’est pas un code de marqueur Blick Studio Brush. Essaie $example.',
      'artistsLoft':
          '$input n’est pas un code de marqueur Artist\'s Loft. Essaie $example.',
      'other': '$input n’est pas un code de marqueur Ink Lab. Essaie $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input n’est pas dans ta collection. Essaie $example ou ajoute-le dans Ma collection.',
      'copic':
          '$input n’est pas dans ta collection. Essaie $example ou ajoute-le dans Ma collection.',
      'finecolour':
          '$input n’est pas dans ta collection. Essaie $example ou ajoute-le dans Ma collection.',
      'other':
          '$input n’est pas dans ta collection. Essaie $example ou ajoute-le dans Ma collection.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'Aucun marqueur DecoTime dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'copic': 'Aucun marqueur Copic dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'finecolour': 'Aucun marqueur Finecolour dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'touchTwin': 'Aucun marqueur Touch Twin dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'promarker': 'Aucun marqueur Promarker dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'prismacolor': 'Aucun marqueur Prismacolor Premier dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'spectrumNoir': 'Aucun marqueur Spectrum Noir dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'promarkerBrush': 'Aucun marqueur Promarker Brush dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'arrtx': 'Aucun marqueur Arrtx dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'kurecolor': 'Aucun marqueur ZIG Kurecolor dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'graphit': 'Aucun marqueur Graph\'it dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'marvyLePlume': 'Aucun marqueur Marvy Le Plume dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'blickBrush': 'Aucun marqueur Blick Studio Brush dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'artistsLoft': 'Aucun marqueur Artist\'s Loft dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
      'other': 'Aucun marqueur dans ta collection pour l’instant. Ajoute-en dans Ma collection.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Choisis un marqueur de base, comme $example, ou sélectionne Scènes comme type de palette.';
  }

  @override
  String swatchesFiltersCount(int count) {
    return 'Filtres · $count';
  }

  @override
  String swatchesCodeCopied(String code) {
    return '$code copié. Colle-le comme couleur de base dans l’onglet Palette.';
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
    return '$visible sur $total';
  }

  @override
  String swatchesOwnedSubtitle(String brand, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count possédés',
      one: '$count possédé',
    );
    return '$brand · $_temp0';
  }

  @override
  String swatchesFilteredColorCount(int visible, int total) {
    return '$visible couleurs sur $total';
  }

  @override
  String swatchesSwatchSemantics(String code, String name, String favorite) {
    String _temp0 = intl.Intl.selectLogic(favorite, {
      'true': '$code, $name, favori',
      'other': '$code, $name',
    });
    return '$_temp0';
  }

  @override
  String swatchesClassicPack(String label) {
    return 'Classique $label';
  }

  @override
  String ideasPaletteSent(String title) {
    return 'La palette « $title » est prête dans Palette.';
  }

  @override
  String matchSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tes $count marqueurs',
      one: 'ton marqueur',
    );
    return 'Comparaison avec $_temp0';
  }

  @override
  String get matchQualityExcellent => 'Quasi exacte';

  @override
  String get matchQualityVeryClose => 'Très proche';

  @override
  String get matchQualityClose => 'Proche';

  @override
  String get matchQualityFair => 'Approximative';

  @override
  String get matchQualityApproximate => 'Éloignée';

  @override
  String matchRecorded(String code) {
    return '$code enregistré dans les choix récents.';
  }

  @override
  String get errDisabled => 'Les suggestions de l’IA sont désactivées.';

  @override
  String get errMissingKey => 'Aucune clé d’API configurée.';

  @override
  String get errNoModelSelected => 'Aucun modèle d’IA sélectionné.';

  @override
  String get errUnauthorized => 'La clé d’API a été refusée.';

  @override
  String get errPaymentRequired =>
      'Le compte n’a plus de crédit ou la clé a épuisé son quota.';

  @override
  String get errRateLimited =>
      'Le fournisseur limite les requêtes. Réessaie dans un instant.';

  @override
  String get errServerError =>
      'Le fournisseur a rencontré une erreur de serveur. Réessaie plus tard.';

  @override
  String get errHttpError => 'Le fournisseur a refusé la requête.';

  @override
  String get errNetworkError =>
      'Impossible de joindre le fournisseur. Vérifie la connexion.';

  @override
  String get errInvalidJson =>
      'Le fournisseur a renvoyé une réponse illisible.';

  @override
  String get errInvalidResponse =>
      'Le fournisseur n’a renvoyé aucune palette exploitable.';

  @override
  String get errNoValidSuggestions =>
      'Le fournisseur a suggéré des couleurs qui ne sont pas dans la collection active.';

  @override
  String get errNoAvailableColors =>
      'Aucun marqueur disponible parmi lesquels choisir.';

  @override
  String get errNoSuggestions => 'Impossible de générer une suggestion.';

  @override
  String get errTimeout =>
      'Le modèle sur l’appareil a mis trop de temps. Réessaie.';

  @override
  String get errOnDeviceUnavailable =>
      'Le modèle sur l’appareil n’est pas prêt sur ce téléphone.';

  @override
  String get errUnknown => 'Les suggestions de l’IA sont indisponibles.';

  @override
  String errAiUnavailableWithReason(String reason) {
    return 'IA indisponible ($reason) Affichage de suggestions locales.';
  }

  @override
  String get roleMainTone => 'Ton principal';

  @override
  String get roleMidtone => 'Ton moyen';

  @override
  String get roleShadow => 'Ombre';

  @override
  String get roleHighlight => 'Lumière';

  @override
  String get roleBlend => 'Mélange';

  @override
  String get roleToneA => 'Ton A';

  @override
  String get roleToneAShadow => 'Ombre du ton A';

  @override
  String get roleToneB => 'Ton B';

  @override
  String get roleToneBShadow => 'Ombre du ton B';

  @override
  String get roleBridge => 'Liaison';

  @override
  String get roleWarmBase => 'Base chaude';

  @override
  String get roleWarmShadow => 'Ombre chaude';

  @override
  String get roleSunlitAccent => 'Accent ensoleillé';

  @override
  String get roleDepthTone => 'Ton de profondeur';

  @override
  String get roleCoolBase => 'Base froide';

  @override
  String get roleCoolShadow => 'Ombre froide';

  @override
  String get roleAtmosphere => 'Atmosphère';

  @override
  String get roleDeepCool => 'Froid profond';

  @override
  String get rolePastelBase => 'Base pastel';

  @override
  String get roleSoftShade => 'Ombre douce';

  @override
  String get rolePastelHighlight => 'Lumière pastel';

  @override
  String get roleAccent => 'Accent';

  @override
  String get roleSupport => 'Appui';

  @override
  String get roleNeonLead => 'Néon principal';

  @override
  String get roleNeonSecondary => 'Néon secondaire';

  @override
  String get roleGlow => 'Lueur';

  @override
  String get rolePopAccent => 'Accent vif';

  @override
  String get roleHue1 => 'Teinte 1';

  @override
  String get roleHue2 => 'Teinte 2';

  @override
  String get roleHue3 => 'Teinte 3';

  @override
  String get roleHue4 => 'Teinte 4';

  @override
  String get roleHue5 => 'Teinte 5';

  @override
  String get roleUnexpectedLead => 'Vedette inattendue';

  @override
  String get roleContrastPair => 'Paire de contraste';

  @override
  String get roleTensionAccent => 'Accent de tension';

  @override
  String get roleOffbeatSupport => 'Appui décalé';

  @override
  String get roleRandom1 => 'Aléatoire 1';

  @override
  String get roleRandom2 => 'Aléatoire 2';

  @override
  String get roleRandom3 => 'Aléatoire 3';

  @override
  String get roleRandom4 => 'Aléatoire 4';

  @override
  String get roleRandom5 => 'Aléatoire 5';

  @override
  String get roleLightValue => 'Valeur claire';

  @override
  String get roleMidLight => 'Mi-clair';

  @override
  String get roleMid => 'Moyen';

  @override
  String get roleMidDark => 'Mi-foncé';

  @override
  String get roleDarkValue => 'Valeur foncée';

  @override
  String get roleWarmSideA => 'Côté chaud A';

  @override
  String get roleWarmSideB => 'Côté chaud B';

  @override
  String get roleCoolSideA => 'Côté froid A';

  @override
  String get roleCoolSideB => 'Côté froid B';

  @override
  String get roleBridgeTone => 'Ton de liaison';

  @override
  String get roleSeasonLead => 'Saison principale';

  @override
  String get roleSeasonSupport => 'Saison d’appui';

  @override
  String get roleFestiveRed => 'Rouge festif';

  @override
  String get roleEvergreen => 'Vert sapin';

  @override
  String get roleGoldAccent => 'Accent doré';

  @override
  String get rolePineShadow => 'Ombre de pin';

  @override
  String get roleSnowSupport => 'Appui neige';

  @override
  String get roleRomanticLead => 'Romantique principal';

  @override
  String get roleRoseShadow => 'Ombre rose';

  @override
  String get roleSoftBlush => 'Blush doux';

  @override
  String get roleBalanceTone => 'Ton d’équilibre';

  @override
  String get roleBase => 'Base';

  @override
  String get roleGlowZone => 'Zone de lueur';

  @override
  String get rolePatternAccent => 'Accent du motif';

  @override
  String get roleContrastColor => 'Couleur de contraste';

  @override
  String get rolePrimary1 => 'Primaire 1';

  @override
  String get rolePrimary2 => 'Primaire 2';

  @override
  String get rolePrimary3 => 'Primaire 3';

  @override
  String get roleSecondary => 'Secondaire';

  @override
  String get roleSepiaLight => 'Sépia clair';

  @override
  String get roleDustMidtone => 'Ton moyen poussiéreux';

  @override
  String get roleLeatherShadow => 'Ombre de cuir';

  @override
  String get roleAgedAccent => 'Accent vieilli';

  @override
  String get roleSmokeNeutral => 'Neutre fumée';

  @override
  String get roleHauntBase => 'Base hantée';

  @override
  String get rolePumpkinGlow => 'Lueur de citrouille';

  @override
  String get roleNightShadow => 'Ombre nocturne';

  @override
  String get roleEerieAccent => 'Accent sinistre';

  @override
  String get roleFogSupport => 'Appui brouillard';

  @override
  String get roleNightBase => 'Base nocturne';

  @override
  String get roleDeepShadow => 'Ombre profonde';

  @override
  String get roleMoonlitEdge => 'Bord de lune';

  @override
  String get roleCoolAccent => 'Accent froid';

  @override
  String get roleMist => 'Brume';

  @override
  String get roleWaterBase => 'Base d’eau';

  @override
  String get roleDepth => 'Profondeur';

  @override
  String get roleShadowWater => 'Eau dans l’ombre';

  @override
  String get roleLightBeam => 'Rayon de lumière';

  @override
  String get roleBubbleHighlight => 'Lumière de bulle';

  @override
  String get roleSpookyBase => 'Base lugubre';

  @override
  String get roleColdShadow => 'Ombre glaciale';

  @override
  String get roleHauntedAccent => 'Accent fantomatique';

  @override
  String get roleEerieHighlight => 'Lumière sinistre';

  @override
  String get roleFogTone => 'Ton brouillard';

  @override
  String get roleMysticBase => 'Base mystique';

  @override
  String get roleSpellShadow => 'Ombre de sort';

  @override
  String get roleMagicalAccent => 'Accent magique';

  @override
  String get roleRuneGlow => 'Lueur de rune';

  @override
  String get roleMoodLead => 'Humeur principale';

  @override
  String get roleMoodShadow => 'Ombre d’humeur';

  @override
  String get roleEmotionAccent => 'Accent émotionnel';

  @override
  String get roleMaterialBase => 'Base de la matière';

  @override
  String get rolePlaneShift => 'Changement de plan';

  @override
  String get roleHardShadow => 'Ombre dure';

  @override
  String get roleSpecularEdge => 'Bord spéculaire';

  @override
  String get rolePatinaAccent => 'Accent de patine';

  @override
  String get roleSpaceBase => 'Base spatiale';

  @override
  String get roleNebulaGlow => 'Lueur de nébuleuse';

  @override
  String get roleDeepVoid => 'Vide profond';

  @override
  String get roleStarAccent => 'Accent stellaire';

  @override
  String get roleDustCloud => 'Nuage de poussière';

  @override
  String get roleGlassPaneA => 'Vitre A';

  @override
  String get roleGlassPaneB => 'Vitre B';

  @override
  String get roleGlassPaneC => 'Vitre C';

  @override
  String get roleGlassPaneD => 'Vitre D';

  @override
  String get roleLightHit => 'Impact de lumière';

  @override
  String get roleShade => 'Ombrage';

  @override
  String get roleContrast => 'Contraste';

  @override
  String get roleSoftShadow => 'Ombre douce';

  @override
  String get roleBackground => 'Fond';

  @override
  String get roleCompanionHue => 'Teinte d’accompagnement';

  @override
  String get rolePrimaryShadow => 'Ombre principale';

  @override
  String get roleMysticAccent => 'Accent mystique';

  @override
  String get roleSecondaryAccent => 'Accent secondaire';

  @override
  String get rolePumpkinShadow => 'Ombre de citrouille';

  @override
  String get roleWitchyPurple => 'Violet sorcière';

  @override
  String get roleToxicAccent => 'Accent toxique';

  @override
  String get roleNightBackground => 'Fond nocturne';

  @override
  String get roleRibbonRed => 'Rouge du ruban';

  @override
  String get rolePineDepth => 'Profondeur de pin';

  @override
  String get roleSnowHighlight => 'Lumière de neige';

  @override
  String get roleBudShadow => 'Ombre de bourgeon';

  @override
  String get roleBlossomTint => 'Teinte de fleur';

  @override
  String get roleFreshLeaf => 'Feuille fraîche';

  @override
  String get roleDaffodilLight => 'Lumière de jonquille';

  @override
  String get roleRainySky => 'Ciel pluvieux';

  @override
  String get roleSkinSubjectShadow => 'Ombre peau/sujet';

  @override
  String get roleWarmCompanion => 'Compagnon chaud';

  @override
  String get roleNeutralBalance => 'Équilibre neutre';

  @override
  String get roleBarkShadow => 'Ombre d’écorce';

  @override
  String get roleMapleRed => 'Rouge érable';

  @override
  String get roleOliveAccent => 'Accent olive';

  @override
  String get roleMorningMist => 'Brume matinale';

  @override
  String get roleSubjectShadow => 'Ombre du sujet';

  @override
  String get roleCoolCompanion => 'Compagnon froid';

  @override
  String get roleAiryHighlight => 'Lumière aérienne';

  @override
  String get roleSnowShadow => 'Ombre de neige';

  @override
  String get roleFrostHighlight => 'Lumière de givre';

  @override
  String get roleEvergreenDepth => 'Profondeur persistante';

  @override
  String get roleBerryAccent => 'Accent de baie';

  @override
  String get roleTwilightSky => 'Ciel crépusculaire';

  @override
  String get roleGroundShadow => 'Ombre du sol';

  @override
  String get roleSkyBlend => 'Mélange de ciel';

  @override
  String get roleSunHighlight => 'Lumière solaire';

  @override
  String get roleContrastAccent => 'Accent de contraste';

  @override
  String get roleNeutralBuffer => 'Neutre de transition';

  @override
  String get rolePalmShadow => 'Ombre de palmier';

  @override
  String get roleCoralAccent => 'Accent corail';

  @override
  String get roleOceanSplash => 'Éclaboussure marine';

  @override
  String get roleSunbeamHighlight => 'Lumière de rayon de soleil';

  @override
  String get roleWarmSand => 'Sable chaud';

  @override
  String get roleLeafShadow => 'Ombre de feuille';

  @override
  String get roleMossMidtone => 'Ton moyen mousse';

  @override
  String get roleSunlitLeaf => 'Feuille ensoleillée';

  @override
  String get roleTrunkAccent => 'Accent de tronc';

  @override
  String get roleSkyFog => 'Ciel/brouillard';

  @override
  String get rolePetalShadow => 'Ombre de pétale';

  @override
  String get rolePetalHighlight => 'Lumière de pétale';

  @override
  String get roleSecondaryPetal => 'Pétale secondaire';

  @override
  String get roleLeafAccent => 'Accent de feuille';

  @override
  String get rolePatternBackground => 'Fond du motif';

  @override
  String get roleToneC => 'Ton C';

  @override
  String get roleToneD => 'Ton D';

  @override
  String get roleNeutralLinework => 'Trait neutre';

  @override
  String get roleComplement => 'Complémentaire';

  @override
  String get roleNeutral => 'Neutre';

  @override
  String get roleCompanion => 'Compagnon';

  @override
  String get reasonScenarioSupport => 'Appui de la scène';

  @override
  String get reasonBalancedPairing => 'Association équilibrée';

  @override
  String get reasonShadowDepth => 'Profondeur d’ombre';

  @override
  String get reasonSoftNearbyHue => 'Teinte voisine douce';

  @override
  String get reasonControlledContrast => 'Contraste maîtrisé';

  @override
  String get reasonHighlightLift => 'Rehaut de lumière';

  @override
  String get reasonLocked => 'Verrouillé';

  @override
  String get reasonVariationSupport => 'Appui de la variante';

  @override
  String get reasonOppositeHueContrast => 'Contraste de teinte opposée';

  @override
  String get reasonSplitComplementContrast => 'Contraste complémentaire divisé';

  @override
  String get reasonTriadBalance => 'Équilibre en triade';

  @override
  String get reasonSquareHarmony => 'Harmonie en carré';

  @override
  String get reasonRectangleHarmony => 'Harmonie en rectangle';

  @override
  String get reasonSameFamilyDeeperTone => 'Même famille, ton plus profond';

  @override
  String get reasonSameFamilyLighterTone => 'Même famille, ton plus clair';

  @override
  String get reasonManualPalette => 'Palette manuelle';

  @override
  String get reasonSupportTone => 'Ton d’appui';

  @override
  String get reasonAISuggestion => 'Suggestion de l’IA';

  @override
  String get reasonLoadedPalette => 'Palette chargée';

  @override
  String get reasonAppliedFromIdeas => 'Appliquée depuis Idées';

  @override
  String reasonNearbyHue(int degrees) {
    return 'Harmonie de teinte voisine ($degrees°)';
  }

  @override
  String reasonShadowTone(int percent) {
    return 'Ton d’ombre ($percent % plus foncé)';
  }

  @override
  String reasonVariation(String prefix, String reason) {
    return '$prefix : $reason';
  }

  @override
  String get variationPrefixVibrant => 'Vif';

  @override
  String get variationPrefixSoft => 'Doux';

  @override
  String get variationPrefixContrast => 'Contraste';

  @override
  String get variationPrefixWarm => 'Chaud';

  @override
  String get variationPrefixCool => 'Froid';

  @override
  String get variationLabelMoreVibrant => 'Plus vif';

  @override
  String get variationLabelSofter => 'Plus doux';

  @override
  String get variationLabelHigherContrast => 'Plus de contraste';

  @override
  String get variationLabelWarmer => 'Plus chaud';

  @override
  String get variationLabelCooler => 'Plus froid';

  @override
  String get modeRecommended => 'Recommandée';

  @override
  String get modeComplementary => 'Complémentaire';

  @override
  String get modeAnalogous => 'Analogue';

  @override
  String get modeSplitComplementary => 'Complémentaire divisée';

  @override
  String get modeTriad => 'Triade';

  @override
  String get modeSquare => 'Carré';

  @override
  String get modeRectangle => 'Rectangle';

  @override
  String get modeMonochrome => 'Monochrome';

  @override
  String get modeCustomPalette => 'Palette personnalisée';

  @override
  String get modeShadow => 'Ombre';

  @override
  String get packLabel120New => '120 Récent';

  @override
  String get packLabel36Skin => '36 Peau';

  @override
  String get packLabel36Gray => '36 Gris';

  @override
  String get packLabel48Pastel => '48 Pastel';

  @override
  String get categorySignature => 'Signature';

  @override
  String get categoryChallenges => 'Défis';

  @override
  String get categoryAtmosphere => 'Atmosphère';

  @override
  String get settingsLinesTitle => 'Séries que tu possèdes';

  @override
  String get settingsLinesHint =>
      'Choisis toutes les séries Ohuhu que tu possèdes. Désactiver une série retire ses coffrets de ta sélection.';

  @override
  String settingsLineSelectedOfTotal(int selected, int total) {
    return '$selected coffrets sélectionnés sur $total';
  }

  @override
  String settingsCurrentPacks(int count) {
    return 'Coffrets actuels ($count)';
  }

  @override
  String settingsLegacyPacks(int count) {
    return 'Anciens coffrets / de la communauté ($count)';
  }

  @override
  String get settingsLegacyPacksNote =>
      'Liste de coffrets fournie par la communauté ; ils ne sont peut-être plus en vente.';

  @override
  String settingsPackColorsSemantics(String pack, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count couleurs',
      one: '$count couleur',
    );
    return '$pack, $_temp0';
  }

  @override
  String get swatchesLines => 'Séries';

  @override
  String get swatchesLabelLine => 'Série';

  @override
  String get swatchesAllLines => 'Toutes les séries';

  @override
  String get swatchesLegacyPacks => 'Anciens coffrets';

  @override
  String packLabelSkin(String n) {
    return '$n Peau';
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
    return '$n Basique';
  }

  @override
  String packLabelIllustration(String n) {
    return '$n Illustration';
  }

  @override
  String packLabelLandscape(String n) {
    return '$n Paysage';
  }

  @override
  String packLabelSweetPastels(String n) {
    return '$n Pastels doux';
  }

  @override
  String packLabelMidTones(String n) {
    return '$n Tons moyens';
  }

  @override
  String packLabelBlossomPastels(String n) {
    return '$n Pastels en fleur';
  }

  @override
  String packLabelWhiteCase(String n) {
    return 'Étui blanc $n';
  }

  @override
  String packLabelWhiteCaseVersion(String n, String v) {
    return 'Étui blanc $n (V$v)';
  }

  @override
  String packLabelJapanVersion(String n, String v) {
    return 'Japon $n (V$v)';
  }

  @override
  String packFullLabel(String line, String pack) {
    return '$line $pack';
  }

  @override
  String swatchesMorePacks(int count) {
    return '+$count de plus';
  }

  @override
  String get settingsMatchingGroup => 'Association des couleurs';

  @override
  String get settingsMatchSuggestUnowned => 'Voir toute la gamme';

  @override
  String get settingsMatchSuggestUnownedSubtitle =>
      'Quand aucun de tes marqueurs ne s’en approche, Associer montre aussi le plus proche de toute la gamme.';

  @override
  String get settingsSetupAgain => 'Refaire la configuration';

  @override
  String get matchNoCloseMatch => 'Aucun de tes marqueurs ne s’en approche.';

  @override
  String matchRangeTitle(String brand) {
    return 'Toute la gamme $brand';
  }

  @override
  String get matchNotOwnedBadge => 'Tu ne l’as pas';

  @override
  String matchBestOfRange(String brand) {
    return 'Le meilleur de toute la gamme $brand';
  }

  @override
  String get matchNotOwnedLine => 'Pas dans ta collection';

  @override
  String matchSeeAll(int count) {
    return 'Tout voir ($count)';
  }

  @override
  String get matchSubtitleEmpty => 'Pas encore de marqueurs dans ta collection';

  @override
  String swatchesWholeRangeNotice(String brand) {
    return 'Toute la gamme $brand s’affiche';
  }

  @override
  String get swatchesWholeRangeAction => 'Configurer';

  @override
  String matchWholeRangeBody(String brand) {
    return 'Tant que tu n’as pas configuré ta collection, l’association utilise toute la gamme $brand.';
  }

  @override
  String get matchWholeRangeAction => 'Aller à Ma collection';

  @override
  String get collectionTitle => 'Ma collection';

  @override
  String collectionMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs',
      one: '$count marqueur',
      zero: 'Aucun marqueur',
    );
    return '$_temp0';
  }

  @override
  String collectionSets(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count coffrets',
      one: '$count coffret',
    );
    return '$_temp0';
  }

  @override
  String get collectionNotSetUp => 'Pas encore configurée';

  @override
  String get collectionSeriesTitle => 'Séries que tu possèdes';

  @override
  String get collectionHonoluluNote =>
      'Honolulu B, Honolulu S et Honolulu² utilisent les mêmes codes couleur que Honolulu ; seules les pointes changent.';

  @override
  String get collectionSetsTitle => 'Coffrets que tu possèdes';

  @override
  String get collectionSetsEmpty => 'Choisis une série pour voir ses coffrets.';

  @override
  String collectionOlderSets(int count) {
    return 'Anciens coffrets ($count)';
  }

  @override
  String get collectionOlderSetsNote =>
      'Éditions retirées ou régionales, d’après des données de la communauté.';

  @override
  String get collectionExtrasTitle => 'Marqueurs à l’unité';

  @override
  String get collectionExtrasHint =>
      'Tu as acheté des marqueurs à l’unité ? Coche-les ici. Ceux de tes coffrets comptent déjà.';

  @override
  String get collectionDecoMarkersTitle => 'Tes marqueurs';

  @override
  String get collectionDecoHint =>
      'DecoTime ne publie pas les couleurs de chaque coffret : coche celles que tu possèdes ou ajoute une famille entière.';

  @override
  String get collectionDecoSizesHint =>
      'Action vend des coffrets DecoTime de 100, 150, 160, 200 et 300 marqueurs.';

  @override
  String get collectionFamiliesTitle => 'Ajouter par famille';

  @override
  String collectionFamilyChip(String family, int owned, int total) {
    return '$family $owned/$total';
  }

  @override
  String get collectionFamilyColours => 'Couleurs';

  @override
  String get collectionFamilyWarmGrey => 'Gris chauds';

  @override
  String get collectionFamilyCoolGrey => 'Gris froids';

  @override
  String get collectionFamilyBlueGrey => 'Gris bleutés';

  @override
  String get collectionFamilyGreenGrey => 'Gris verdâtres';

  @override
  String get collectionDecoRange => 'Gamme DecoTime';

  @override
  String get collectionWholeRange => 'Toute la gamme';

  @override
  String get collectionSearchHint => 'Chercher code ou nom';

  @override
  String get collectionTickVisible => 'Tout cocher';

  @override
  String collectionTickManyTitle(int count) {
    return 'Cocher $count marqueurs ?';
  }

  @override
  String get collectionTickManyBody =>
      'Tous comptent comme des marqueurs que tu as. Tu peux les retirer avec « Décocher ».';

  @override
  String get collectionUntickVisible => 'Décocher';

  @override
  String get collectionInYourSets => 'Dans ton coffret';

  @override
  String get collectionNoResults =>
      'Aucun marqueur ne correspond à la recherche.';

  @override
  String get collectionReset => 'Vider la collection';

  @override
  String get collectionOwnedGroup => 'Ce que tu possèdes';

  @override
  String get collectionShoppingGroup => 'Achats';

  @override
  String get collectionToolsGroup => 'Outils';

  @override
  String get toolsMapTitle => 'Carte des couleurs';

  @override
  String get toolsMapHint =>
      'Où se placent tes marqueurs par teinte et par luminosité, et où sont les trous.';

  @override
  String get toolsTranslateTitle => 'Traduire une recette';

  @override
  String get toolsTranslateHint =>
      'Transforme les codes d’un tutoriel en tes marqueurs les plus proches.';

  @override
  String get toolsBlendsTitle => 'Mes recettes';

  @override
  String get toolsBlendsHint =>
      'Tes dégradés enregistrés : marqueurs dans l’ordre, une note et une photo.';

  @override
  String get toolsTransferTitle => 'Export et import';

  @override
  String get toolsTransferHint =>
      'Partage tes marqueurs en liste ou en CSV, ou ajoute-en beaucoup par code.';

  @override
  String get toolsMapEmptyTitle => 'Aucun marqueur à afficher';

  @override
  String get toolsMapIntro =>
      'Chaque point est un marqueur que tu possèdes. Les zones hachurées n’en ont aucun.';

  @override
  String get toolsMapShowRange => 'Afficher toute la gamme';

  @override
  String get toolsMapShowRangeHint =>
      'Points pâles pour tous les marqueurs de tes marques, pour voir ce qui manque.';

  @override
  String get toolsMapAxes =>
      'De gauche à droite : teinte. De haut en bas : du clair au foncé.';

  @override
  String get toolsMapGreysTitle => 'Gris et neutres';

  @override
  String get toolsMapGreysAxis => 'De gauche à droite : du foncé au clair.';

  @override
  String get toolsMapFamiliesTitle => 'Par teinte';

  @override
  String get toolsHueRed => 'Rouge';

  @override
  String get toolsHueOrange => 'Orange';

  @override
  String get toolsHueYellow => 'Jaune';

  @override
  String get toolsHueGreen => 'Vert';

  @override
  String get toolsHueTeal => 'Turquoise';

  @override
  String get toolsHueBlue => 'Bleu';

  @override
  String get toolsHueViolet => 'Violet';

  @override
  String get toolsHueMagenta => 'Magenta';

  @override
  String toolsFamilyBands(int light, int mid, int dark) {
    return 'Clairs $light · Moyens $mid · Foncés $dark';
  }

  @override
  String get toolsMapDriedNote => 'Les marqueurs à sec sont exclus.';

  @override
  String toolsMapSummary(String markers, int empty, int cells) {
    return 'Carte des couleurs de $markers. $empty zones sur $cells n’ont aucun marqueur. La liste ci-dessous reprend les mêmes marqueurs par teinte.';
  }

  @override
  String get toolsMarkerOwned => 'Dans ta collection';

  @override
  String get toolsMarkerNotOwned => 'Pas dans ta collection';

  @override
  String get toolsTranslateIntro =>
      'Saisis ou colle les codes d’un tutoriel, dans la marque qu’il utilise. Virgules, espaces et listes fonctionnent.';

  @override
  String get toolsTranslateBrand => 'Marque de la recette';

  @override
  String get toolsTranslateCodes => 'Codes';

  @override
  String get toolsTranslateResults => 'Traduction';

  @override
  String get toolsTranslateEmpty => 'Les codes saisis apparaissent ici.';

  @override
  String get toolsTranslateMine => 'Le plus proche chez toi';

  @override
  String get toolsTranslateNotOwned => 'Non possédé';

  @override
  String get toolsTranslateMissing => 'Rien de proche dans ta collection.';

  @override
  String toolsTranslateUnknown(String brand) {
    return 'Introuvable dans $brand';
  }

  @override
  String get toolsCopyList => 'Copier la liste';

  @override
  String get toolsShareList => 'Partager la liste';

  @override
  String get toolsListCopied => 'Liste copiée.';

  @override
  String get toolsShareFailed => 'Impossible de partager la liste.';

  @override
  String get toolsBlendsNew => 'Nouvelle recette';

  @override
  String get toolsBlendsEditTitle => 'Modifier la recette';

  @override
  String get toolsBlendsEmptyTitle => 'Aucune recette';

  @override
  String get toolsBlendsEmptyBody =>
      'Enregistre les dégradés que tu aimes : marqueurs dans l’ordre, une note et une photo.';

  @override
  String get toolsBlendsName => 'Nom de la recette';

  @override
  String get toolsBlendsMarkersTitle => 'Marqueurs, dans l’ordre';

  @override
  String get toolsBlendsMarkersHelp =>
      'Fais glisser la poignée pour changer l’ordre.';

  @override
  String get toolsBlendsDrag => 'Glisser pour réordonner';

  @override
  String toolsBlendsRemoveMarker(String code) {
    return 'Retirer $code';
  }

  @override
  String get toolsBlendsNote => 'Notes';

  @override
  String get toolsBlendsPhotoTitle => 'Photo du résultat';

  @override
  String get toolsBlendsPhotoHelp =>
      'Facultative. Elle reste sur ce téléphone.';

  @override
  String get toolsBlendsPhotoSemantic => 'Photo de la recette';

  @override
  String get toolsBlendsSave => 'Enregistrer la recette';

  @override
  String get toolsBlendsDelete => 'Supprimer la recette';

  @override
  String get toolsBlendsDeleteTitle => 'Supprimer cette recette ?';

  @override
  String get toolsBlendsDeleteBody =>
      'La recette et sa photo seront retirées de ce téléphone.';

  @override
  String get toolsTransferExport => 'Exporter';

  @override
  String toolsTransferBrands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marques',
      one: '$count marque',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferExportBrands(String brands) {
    return 'Inclut toutes tes marques : $brands.';
  }

  @override
  String get toolsTransferCsv => 'Partager en CSV';

  @override
  String get toolsTransferImport => 'Importer par code';

  @override
  String get toolsTransferImportHelp =>
      'Choisis la marque et colle ses codes. Rien n’est ajouté avant que tu appuies sur le bouton.';

  @override
  String get toolsTransferNew => 'Nouveaux marqueurs';

  @override
  String get toolsTransferAlready => 'Déjà chez toi';

  @override
  String get toolsTransferUnknown => 'Non reconnus';

  @override
  String toolsTransferAdd(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ajouter $count marqueurs',
      one: 'Ajouter $count marqueur',
      zero: 'Ajouter des marqueurs',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs ajoutés.',
      one: '$count marqueur ajouté.',
    );
    return '$_temp0';
  }

  @override
  String commonSeeAll(int count) {
    return 'Voir tout ($count)';
  }

  @override
  String get collectionChartTitle => 'Nuancier imprimable';

  @override
  String get swatchesOtherBrandsTitle => 'Dans d’autres marques';

  @override
  String get swatchesOtherBrandsOnlyMine => 'Seulement les miens';

  @override
  String get swatchesOtherBrandsNone => 'Aucune autre marque à comparer.';

  @override
  String get swatchesOtherBrandsNoneMine =>
      'Tu n’as aucun marqueur utilisable d’autres marques.';

  @override
  String get swatchesOtherBrandsFailed =>
      'Impossible de lire les autres marques.';

  @override
  String get swatchesOtherBrandsPaletteNote =>
      'Les palettes utilisent la marque choisie dans les réglages ; ce marqueur ne peut donc pas y être ajouté.';

  @override
  String get paletteVisionTitle => 'Vision des couleurs';

  @override
  String get paletteVisionNormal => 'Normale';

  @override
  String get paletteVisionProtanopia => 'Protanopie';

  @override
  String get paletteVisionDeuteranopia => 'Deutéranopie';

  @override
  String get paletteVisionTritanopia => 'Tritanopie';

  @override
  String get paletteVisionAchromatopsia => 'Achromatopsie';

  @override
  String paletteVisionPairs(String pairs) {
    return 'Difficiles à distinguer : $pairs';
  }

  @override
  String paletteVisionPairsMore(int count) {
    return '+$count autres';
  }

  @override
  String get paletteVisionNoPairs =>
      'Toutes les couleurs restent faciles à distinguer.';

  @override
  String get paletteVisionPreviewNote =>
      'Simple aperçu. L’enregistrement et le partage gardent les vraies couleurs.';

  @override
  String get paletteEaselTitle => 'Mode chevalet';

  @override
  String get paletteEaselExit => 'Quitter le mode chevalet';

  @override
  String get paletteShareTextButton => 'Partager en texte';

  @override
  String paletteTextHeader(String brand, String title) {
    return 'Palette Ink Lab · $brand · $title';
  }

  @override
  String get paletteImportTitle => 'Importer depuis un texte';

  @override
  String get paletteImportHint =>
      'Colle une palette partagée ou une liste de codes de marqueurs.';

  @override
  String get paletteImportPaste => 'Coller';

  @override
  String get paletteImportAction => 'Charger la palette';

  @override
  String get paletteImportNothing =>
      'Aucun code de marqueur trouvé dans ce texte.';

  @override
  String paletteImportNoneKnown(String brand, String codes) {
    return 'Aucun de ces codes n’est un marqueur $brand : $codes.';
  }

  @override
  String paletteImportOtherBrand(String brand) {
    return 'Cette palette est pour $brand. Change de marque dans les Réglages pour l’importer.';
  }

  @override
  String paletteImportDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Palette de $count marqueurs importée.',
      one: 'Palette de $count marqueur importée.',
    );
    return '$_temp0';
  }

  @override
  String paletteImportUnknown(String codes) {
    return 'Non reconnus : $codes.';
  }

  @override
  String get paletteImportRepeated =>
      'Les codes répétés n’ont été comptés qu’une fois.';

  @override
  String get collectionChartHint =>
      'Des cases vides avec le code et le nom de chaque marqueur que tu possèdes, pour peindre tes vrais nuanciers. Partagé en images A4 à imprimer ou à enregistrer.';

  @override
  String get collectionChartShowColour => 'Couleur du catalogue';

  @override
  String get collectionChartShowColourHint =>
      'Affichée en fine bande dans chaque case, pour comparer.';

  @override
  String get collectionChartCreate => 'Créer et partager';

  @override
  String get collectionChartPreparing => 'Préparation…';

  @override
  String get collectionChartEmpty =>
      'Choisis d’abord tes coffrets ou marqueurs.';

  @override
  String collectionChartPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '$count page',
    );
    return '$_temp0';
  }

  @override
  String get chartImageTitle => 'Nuancier';

  @override
  String chartImagePage(int page, int total) {
    return 'Page $page sur $total';
  }

  @override
  String collectionResetTitle(String brand) {
    return 'Vider ta collection $brand ?';
  }

  @override
  String get collectionResetBody =>
      'Les coffrets et marqueurs à l’unité de cette marque sont retirés. Les favoris et les palettes restent.';

  @override
  String collectionOwnedCount(int owned, int total) {
    return '$owned sur $total';
  }

  @override
  String collectionLooseTicked(int loose, int sets) {
    return '$loose à l’unité cochés · $sets dans tes coffrets';
  }

  @override
  String get onboardingWelcomeTitle => 'Bienvenue dans Ink Lab';

  @override
  String get onboardingWelcomeBody =>
      'Parcours tes marqueurs, associe des couleurs à partir de photos et crée des palettes. D’abord, dis-nous quels marqueurs tu as.';

  @override
  String get onboardingOhuhuLine =>
      'Coffrets par série : Oahu, Honolulu, Kaala';

  @override
  String get onboardingDecoLine =>
      'Une gamme de 313 couleurs, coffrets chez Action';

  @override
  String get onboardingSeriesTitle => 'Quelles séries as-tu ?';

  @override
  String get onboardingSeriesBody =>
      'Choisis toutes les séries dont tu as des marqueurs.';

  @override
  String get onboardingSetsTitle => 'Quels coffrets as-tu ?';

  @override
  String get onboardingSetsBody =>
      'Choisis les boîtes que tu as achetées. Les marqueurs à l’unité s’ajoutent plus tard.';

  @override
  String get onboardingDoneTitle => 'Tout est prêt';

  @override
  String get onboardingLaterNote =>
      'Tu pourras le modifier plus tard dans Ma collection.';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingBack => 'Retour';

  @override
  String get onboardingFinish => 'Commencer';

  @override
  String get onboardingStepFirst => 'Étape 1';

  @override
  String onboardingMarkersTicked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cochés',
      one: '$count coché',
    );
    return '$_temp0';
  }

  @override
  String onboardingMarkersNoneTicked(String range) {
    return 'Aucun coché · $range';
  }

  @override
  String onboardingStep(int step, int total) {
    return 'Étape $step sur $total';
  }

  @override
  String get collectionSeriesOahuTips => 'Pointe fine et biseautée';

  @override
  String get collectionSeriesHonoluluTips => 'Pointe pinceau et biseautée';

  @override
  String get collectionSeriesKaalaTips => 'Pointe pinceau';

  @override
  String get collectionSummaryNoSets =>
      'Tu n’as pas encore choisi de coffrets : toute la gamme est utilisée';

  @override
  String get collectionSummaryNoMarkers =>
      'Tu n’as pas encore coché de marqueurs';

  @override
  String get collectionExtrasAddTitle => 'Marqueurs à l’unité';

  @override
  String get collectionDecoMarkersButton => 'Cocher tes marqueurs';

  @override
  String collectionExtrasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs à l’unité',
      one: '$count marqueur à l’unité',
      zero: 'Aucun marqueur à l’unité',
    );
    return '$_temp0';
  }

  @override
  String get wishlistTitle => 'Liste de souhaits';

  @override
  String wishlistCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs à acheter',
      one: '$count marqueur à acheter',
      zero: 'Ta liste de souhaits est vide',
    );
    return '$_temp0';
  }

  @override
  String get wishlistSubtitle => 'Ajoute-les depuis le détail d’une couleur';

  @override
  String get wishlistEmpty =>
      'Ajoute les marqueurs que tu veux acheter depuis la fiche de n’importe quel marqueur.';

  @override
  String get wishlistAdd => 'À la liste de souhaits';

  @override
  String get wishlistRemove => 'Retirer de la liste';

  @override
  String get wishlistCopy => 'Copier la liste';

  @override
  String get wishlistCopied => 'Liste de courses copiée';

  @override
  String get wishlistOfferTitle => 'Ajouter à ta liste de souhaits ?';

  @override
  String wishlistOfferBody(String code) {
    return '$code est à sec. Ajoute-le à ta liste de souhaits pour acheter une recharge ou un remplaçant.';
  }

  @override
  String get driedTitle => 'À sec';

  @override
  String driedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs à sec',
      one: '$count marqueur à sec',
      zero: 'Aucun marqueur à sec',
    );
    return '$_temp0';
  }

  @override
  String get driedHint =>
      'Ils restent dans ta collection, mais Associer, Palette et Idées ne les suggèrent pas.';

  @override
  String get driedEmpty =>
      'Quand un marqueur ne marque plus, indique-le comme à sec depuis sa fiche.';

  @override
  String get driedMark => 'Marquer comme à sec';

  @override
  String get driedUnmark => 'Marquer comme utilisable';

  @override
  String get driedNote =>
      'À sec : Associer, Palette et Idées l’ignorent tant que tu ne l’as pas marqué comme utilisable.';

  @override
  String get commonDried => 'À sec';

  @override
  String get buyNextTitle => 'Que racheter ensuite';

  @override
  String get buyNextIntro =>
      'Des marqueurs que tu n’as pas et qui rapprocheraient tes couleurs de celles du plus grand nombre de scènes.';

  @override
  String buyNextReasonScenes(int count, String scenes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Améliore $count scènes : $scenes',
      one: 'Améliore $count scène : $scenes',
    );
    return '$_temp0';
  }

  @override
  String get buyNextReasonGap => 'Comble un trou dans ta gamme de couleurs';

  @override
  String get buyNextNoCollection =>
      'Coche les marqueurs que tu possèdes pour voir quoi acheter ensuite.';

  @override
  String get buyNextComplete =>
      'Rien à suggérer : tes marqueurs couvrent déjà bien toutes les scènes.';

  @override
  String get buyNextRefill => 'À sec : une recharge le ranime.';

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Tant que tu n’as pas choisi de coffrets, l’appli affiche toute la gamme $brand.';
  }

  @override
  String get onboardingDoneNext =>
      'Et ensuite : parcours les couleurs dans Nuanciers, associe une photo dans Associer ou crée une palette dans Palette.';

  @override
  String get collectionVisibleScope =>
      'S’applique aux marqueurs qui correspondent à la recherche.';

  @override
  String get matchWhiteBalanceButton => 'Corriger les blancs';

  @override
  String get matchWhiteBalanceHint =>
      'Touche un point de la photo qui devrait être du papier blanc.';

  @override
  String get matchWhiteBalanceOn => 'Blancs corrigés';

  @override
  String get matchWhiteBalanceReset => 'Annuler';

  @override
  String get matchWhiteBalanceTooDark =>
      'Ce point est trop sombre pour être du papier. Choisis-en un plus clair.';

  @override
  String get matchWhiteBalanceTooColourful =>
      'Ce point a trop de couleur pour être du papier. Choisis une zone blanche.';

  @override
  String get commonOwnColour => 'Ma couleur';

  @override
  String get swatchesMyColourTitle => 'Ma couleur';

  @override
  String get swatchesMyColourHelp =>
      'Les couleurs du catalogue sont approximatives. Enregistre celle que ton marqueur donne vraiment sur le papier.';

  @override
  String get swatchesMyColourReset => 'Revenir au catalogue';

  @override
  String get swatchesMyColourSaved => 'Ta couleur a été enregistrée';

  @override
  String get swatchesMyColourWasReset => 'Retour à la couleur du catalogue';

  @override
  String get swatchesMyColourSame => 'Comme le catalogue';

  @override
  String swatchesMyColourValue(String hex) {
    return 'Le tien : $hex';
  }

  @override
  String get swatchesStatusWished => 'Sur ta liste de souhaits';

  @override
  String get swatchesDetailsTitle => 'Détails';

  @override
  String get swatchesCatalogueLabel => 'Catalogue';

  @override
  String get swatchesMineLabel => 'La mienne';

  @override
  String ownColorTitle(String code) {
    return 'Ma couleur pour $code';
  }

  @override
  String get ownColorHexLabel => 'Couleur hex';

  @override
  String get ownColorHexInvalid => 'Saisis 3 ou 6 chiffres hex, comme 3A7F9C.';

  @override
  String get ownColorPhotoTitle => 'À partir d’une photo';

  @override
  String get ownColorPhotoHelp =>
      'Peins avec le marqueur sur du papier blanc, prends une photo et touche la zone peinte.';

  @override
  String get ownColorPhotoTap => 'Touche la zone peinte.';

  @override
  String get ownColorSave => 'Enregistrer ma couleur';

  @override
  String get settingsOwnColors => 'Utiliser mes couleurs';

  @override
  String get settingsOwnColorsSubtitle =>
      'Associer, Palette et Idées utilisent la couleur que tu as enregistrée pour un marqueur au lieu de celle du catalogue.';

  @override
  String settingsOwnColorsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count couleurs à toi',
      one: '$count couleur à toi',
      zero: 'Aucune couleur à toi',
    );
    return '$_temp0';
  }

  @override
  String get settingsOwnColorsReset => 'Réinitialiser';

  @override
  String get settingsOwnColorsResetTitle => 'Réinitialiser tes couleurs ?';

  @override
  String get settingsOwnColorsResetBody =>
      'Tous les marqueurs reprennent leur couleur du catalogue. Cette action est irréversible.';

  @override
  String get settingsJoinBeta => 'Rejoindre la bêta Google Play';

  @override
  String get collectionCopicHint =>
      'Les marqueurs Copic s’achètent à l’unité. Coche ceux que tu possèdes.';

  @override
  String get collectionFinecolourHint =>
      'Les marqueurs Finecolour s’achètent à l’unité. Coche ceux que tu possèdes.';

  @override
  String get onboardingCopicLine =>
      '358 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get onboardingFinecolourLine =>
      '480 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String onboardingMarkersTitle(String brand) {
    return 'Tes marqueurs $brand';
  }

  @override
  String onboardingNoMarkers(String brand) {
    return 'Tu n’as pas encore coché de marqueurs $brand : coche-les dans Ma collection.';
  }

  @override
  String ideasNoMarkersBrand(String brand) {
    return 'Ajoute les marqueurs $brand que tu possèdes dans Ma collection pour obtenir une palette pour cette idée.';
  }

  @override
  String get ideasDiarySegment => 'Journal';

  @override
  String get ideasDiarySubtitle => 'Tes œuvres, les plus récentes d’abord';

  @override
  String get diaryEmptyTitle => 'Ton journal est vide';

  @override
  String get diaryEmptyMessage =>
      'Note les pages et feuilles que tu colories, avec leurs marqueurs, notes et photos.';

  @override
  String get diaryAdd => 'Ajouter au journal';

  @override
  String get diaryShareButton => 'Partager cette entrée';

  @override
  String get diaryStatusLabel => 'Statut';

  @override
  String get diaryStatusInProgress => 'En cours';

  @override
  String get diaryStatusFinished => 'Terminée';

  @override
  String get diaryNewTitle => 'Nouvelle entrée';

  @override
  String get diaryEditTitle => 'Modifier l’entrée';

  @override
  String get diaryTitleLabel => 'Titre';

  @override
  String get diaryDateLabel => 'Date';

  @override
  String get diaryOnWhatLabel => 'Colorié sur';

  @override
  String get diaryOnWhatHint => 'p. ex. un livre de coloriage ou un carnet';

  @override
  String get diaryMarkersTitle => 'Marqueurs utilisés';

  @override
  String get diaryMarkersChoose => 'Choisir des marqueurs';

  @override
  String diaryMarkerRemove(String code) {
    return 'Retirer $code';
  }

  @override
  String get diaryPaletteTitle => 'Palette';

  @override
  String get diaryPaletteNone => 'Aucune palette';

  @override
  String get diaryPaletteChoose => 'Lier une palette enregistrée';

  @override
  String get diaryPaletteMissing => 'Cette palette n’est plus enregistrée.';

  @override
  String get diaryPaletteEmpty => 'Tu n’as pas encore de palette enregistrée.';

  @override
  String get diaryNotesLabel => 'Notes';

  @override
  String get diaryNotesHint => 'Technique, papier, fondu...';

  @override
  String get diaryMoreDetails => 'Plus de détails';

  @override
  String get diaryPhotosTitle => 'Photos';

  @override
  String diaryPhotosHelp(int count) {
    return 'Jusqu’à $count photos. Elles restent sur ce téléphone.';
  }

  @override
  String get diaryPhotoRemove => 'Retirer la photo';

  @override
  String diaryPhotoSemantic(int number, int total) {
    return 'Photo $number sur $total';
  }

  @override
  String get diarySave => 'Enregistrer l’entrée';

  @override
  String get diaryDelete => 'Supprimer l’entrée';

  @override
  String get diaryDeleteTitle => 'Supprimer cette entrée ?';

  @override
  String get diaryDeleteBody =>
      'L’entrée et ses photos sont supprimées de ce téléphone. Cette action est irréversible.';

  @override
  String get diaryDeleteConfirm => 'Supprimer';

  @override
  String get diaryAddedNotice => 'Ajouté au journal';

  @override
  String diaryStatsArtworks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count œuvres',
      one: '1 œuvre',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsFinished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count terminées',
      one: '$count terminée',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsInProgress(int count) {
    return '$count en cours';
  }

  @override
  String get diaryStatsOpen => 'Voir les chiffres';

  @override
  String get diaryStatsTitle => 'Chiffres du journal';

  @override
  String get diaryStatsStatusTitle => 'Terminées et en cours';

  @override
  String get diaryStatsMonthsTitle => 'Entrées par mois';

  @override
  String diaryStatsMonthsLatest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Les $count derniers mois.',
      one: 'Le dernier mois.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsMarkersTitle => 'Marqueurs que tu utilises le plus';

  @override
  String get diaryStatsMarkersEmpty => 'Aucune entrée n’a encore de marqueurs.';

  @override
  String diaryStatsEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entrées',
      one: '1 entrée',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedTitle => 'Marqueurs pas encore utilisés';

  @override
  String diaryStatsUnusedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs que tu as ne sont dans aucune entrée.',
      one: '1 marqueur que tu as n’est dans aucune entrée.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedNone => 'Tous tes marqueurs sont dans une entrée.';

  @override
  String get diaryStatsUnusedNoCollection =>
      'Ajoute tes marqueurs dans Ma collection pour voir lesquels tu n’as pas utilisés.';

  @override
  String get diaryStatsUnusedShow => 'Afficher la liste';

  @override
  String get diaryStatsUnusedHide => 'Masquer la liste';

  @override
  String get diaryStatsPalettesTitle => 'Palettes que tu lies le plus';

  @override
  String get diaryStatsPalettesEmpty =>
      'Aucune entrée ne lie encore une palette enregistrée.';

  @override
  String diaryShareMore(int count) {
    return '+$count de plus';
  }

  @override
  String get settingsLicences => 'Licences open source';

  @override
  String get settingsLicencesSubtitle =>
      'Les licences du code, des polices et des paquets utilisés par l’app';

  @override
  String get settingsLicencesLegalese =>
      'Code d’Ink Lab : licence MIT. Textes, idées et documentation : CC BY-SA 4.0. Polices incluses : licence SIL Open Font 1.1.';

  @override
  String get settingsSendFeedback => 'Envoyer un retour';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Ouvre ton app de messagerie avec la version de l’app et du système. Tu décides de l’envoyer ou non.';

  @override
  String settingsFeedbackNoMail(String address) {
    return 'Aucune app de messagerie trouvée. L’adresse $address a été copiée.';
  }

  @override
  String get settingsErrorLogShare => 'Partager l’historique des erreurs';

  @override
  String get settingsErrorLogShareSubtitle =>
      'Détails techniques des erreurs de l’app, sans ton journal ni ta clé d’API. Rien n’est envoyé si tu ne le partages pas.';

  @override
  String get settingsErrorLogClear => 'Effacer l’historique des erreurs';

  @override
  String get settingsErrorLogCleared => 'L’historique des erreurs a été effacé';

  @override
  String get settingsErrorLogShareFailed =>
      'Impossible de partager l’historique des erreurs';

  @override
  String settingsLastBackup(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Dernière sauvegarde : $dateString';
  }

  @override
  String get settingsNoBackupYet => 'Aucune sauvegarde pour l’instant';

  @override
  String get settingsBackupReminderNever =>
      'Tu as des données dans l’app mais aucune sauvegarde. Enregistre un fichier de sauvegarde pour ne rien perdre si tu changes ou réinitialises ton téléphone.';

  @override
  String get settingsBackupReminderOld =>
      'Ta dernière sauvegarde date de plus d’un mois. Enregistre un nouveau fichier pour protéger ton travail récent.';

  @override
  String get collectionTouchTwinHint =>
      'Coche les marqueurs Touch Twin que tu possèdes.';

  @override
  String get onboardingTouchTwinLine =>
      '202 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionPromarkerHint =>
      'Coche les marqueurs Promarker que tu possèdes.';

  @override
  String get onboardingPromarkerLine =>
      '148 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionPrismacolorHint =>
      'Coche les marqueurs Prismacolor Premier que tu possèdes.';

  @override
  String get onboardingPrismacolorLine =>
      '200 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionSpectrumNoirHint =>
      'Coche les marqueurs Spectrum Noir que tu possèdes.';

  @override
  String get onboardingSpectrumNoirLine =>
      '216 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionPromarkerBrushHint =>
      'Coche les marqueurs Promarker Brush que tu possèdes.';

  @override
  String get onboardingPromarkerBrushLine =>
      '72 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionArrtxHint =>
      'Coche les marqueurs Arrtx que tu possèdes.';

  @override
  String get onboardingArrtxLine =>
      '328 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionKurecolorHint =>
      'Coche les marqueurs ZIG Kurecolor que tu possèdes.';

  @override
  String get onboardingKurecolorLine =>
      '136 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionGraphitHint =>
      'Coche les marqueurs Graph\'it que tu possèdes.';

  @override
  String get onboardingGraphitLine =>
      '168 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionMarvyLePlumeHint =>
      'Coche les marqueurs Marvy Le Plume que tu possèdes.';

  @override
  String get onboardingMarvyLePlumeLine =>
      '144 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionBlickBrushHint =>
      'Coche les marqueurs Blick Studio Brush que tu possèdes.';

  @override
  String get onboardingBlickBrushLine =>
      '96 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get collectionArtistsLoftHint =>
      'Coche les marqueurs Artist\'s Loft que tu possèdes.';

  @override
  String get onboardingArtistsLoftLine =>
      '56 couleurs · Coche les marqueurs que tu possèdes';

  @override
  String get shortcutMatchLabel => 'Associer une couleur';

  @override
  String get shortcutNewPaletteLabel => 'Nouvelle palette';

  @override
  String get shortcutSearchSwatchesLabel => 'Chercher un nuancier';

  @override
  String get brandSearchHint => 'Chercher une marque';

  @override
  String get brandGroupPopular => 'Populaires';

  @override
  String get brandGroupMore => 'Autres marques';

  @override
  String get brandSearchEmpty => 'Aucune marque ne correspond à ta recherche.';

  @override
  String get brandGroupOwned => 'Tes marques';

  @override
  String brandOwnedLine(int owned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      owned,
      locale: localeName,
      other: '$owned sur $total possédés',
      one: '$owned sur $total possédé',
    );
    return '$_temp0';
  }

  @override
  String get navRailExpand => 'Déplier le menu';

  @override
  String get navRailCollapse => 'Replier le menu';

  @override
  String get inkLevelTitle => 'Niveau d’encre';

  @override
  String get inkLevelFull => 'Plein';

  @override
  String get commonRunningOut => 'Bientôt vide';

  @override
  String get refillNoteTitle => 'Note de recharge';

  @override
  String get refillNoteEmpty => 'Ajoute une note, comme « rechargé le 3 nov. »';

  @override
  String get refillNoteHint => 'Rechargé le 3 nov.';

  @override
  String get refillNoteSave => 'Enregistrer';

  @override
  String get refillNoteRemove => 'Retirer la note';

  @override
  String get swatchPhotoTitle => 'Échantillon réel';

  @override
  String get swatchPhotoEmpty =>
      'Ajoute une photo de ton échantillon sur papier';

  @override
  String get swatchPhotoHas => 'Ton échantillon sur papier';

  @override
  String get swatchPhotoView => 'Voir la photo';

  @override
  String get swatchPhotoTake => 'Prendre une photo';

  @override
  String get swatchPhotoChoose => 'Choisir dans la galerie';

  @override
  String get swatchPhotoSaved => 'Photo enregistrée';

  @override
  String get swatchPhotoSaveFailed =>
      'La photo n’a pas pu être enregistrée. Essaie-en une autre.';

  @override
  String get swatchPhotoRemoved => 'Photo retirée';

  @override
  String get swatchShadowLightTitle => 'Ombre et lumière';

  @override
  String get swatchShadow => 'Ombre';

  @override
  String get swatchLight => 'Lumière';

  @override
  String get swatchShadowLightNone => 'Aucun dans ta collection';

  @override
  String get swatchBlendWith => 'Fondre avec…';

  @override
  String get swatchBlendTitle => 'Fondre avec';

  @override
  String get swatchBlendSearchHint => 'Chercher un marqueur';

  @override
  String get swatchBlendNoMarkers =>
      'Tu n’as pas d’autres marqueurs à fondre avec celui-ci.';

  @override
  String get swatchBlendNoResults =>
      'Aucun marqueur ne correspond à ta recherche.';

  @override
  String get swatchBlendSteps => 'Entre les deux, dans ta collection';

  @override
  String get swatchBlendNothingBetween =>
      'Ces deux-là sont assez proches pour se fondre directement.';

  @override
  String get swatchBlendNoneBetween =>
      'Aucun de tes marqueurs ne se place entre les deux.';

  @override
  String swatchBlendBuy(String code) {
    return 'Grand écart. Pour le combler, le marqueur le plus proche que tu n’as pas est $code.';
  }

  @override
  String swatchBlendStripSemantics(String from, String to) {
    return 'Dégradé de $from à $to';
  }

  @override
  String swatchDuplicatesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tu as déjà $count marqueurs très proches de celui-ci',
      one: 'Tu as déjà 1 marqueur très proche de celui-ci',
    );
    return '$_temp0';
  }

  @override
  String get swatchDuplicatesHint =>
      'Presque la même couleur : un nouveau n’apporte presque rien.';

  @override
  String swatchDuplicatesMore(int count) {
    return 'et $count autres';
  }

  @override
  String get swatchDuplicatesNone =>
      'Rien dans ta collection n’en est très proche : il apporterait une nouvelle couleur.';

  @override
  String wishlistDuplicateNote(String codes) {
    return 'Très proche de $codes dans ta collection';
  }

  @override
  String wishlistRunningOutCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marqueurs bientôt vides',
      one: '$count marqueur bientôt vide',
      zero: 'Aucun marqueur bientôt vide',
    );
    return '$_temp0';
  }

  @override
  String get wishlistRunningOutHint =>
      'Ils servent encore. Ajoute-les à la liste quand tu voudras en racheter ou les recharger.';

  @override
  String swatchesAllBrands(int count) {
    return 'Toutes les marques ($count)';
  }

  @override
  String get swatchesOtherBrandsYours => 'Tes marques';

  @override
  String get inkLevelFullNote =>
      'Plein : Associer, Palette et Idées peuvent le suggérer.';

  @override
  String get inkLevelRunningOutNote =>
      'Bientôt vide : il sert encore partout. Il figure dans le groupe « Bientôt vide » de ta liste de souhaits.';

  @override
  String get swatchesDetailPaneEmpty =>
      'Touche un marqueur pour voir ici ses détails.';
}
