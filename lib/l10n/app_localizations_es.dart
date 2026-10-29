// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsCollectionGroup => 'Colección';

  @override
  String get settingsDisplayGroup => 'Pantalla';

  @override
  String get settingsDataGroup => 'Tus datos';

  @override
  String get settingsAiGroup => 'Asistente de IA';

  @override
  String get settingsAiOffByDefault => 'Desactivado por defecto';

  @override
  String get settingsUnavailable =>
      'Los servicios de la app no están disponibles, así que no se pueden mostrar los ajustes.';

  @override
  String get settingsBrandTitle => 'Marca';

  @override
  String get settingsBrandDecoTimeHint =>
      'DecoTime solo muestra los rotuladores que marcas como tuyos.';

  @override
  String get settingsBrandSubtitle =>
      'La marca elige el catálogo de rotuladores con el que trabaja la app.';

  @override
  String get settingsPacksTitle => 'Packs de Ohuhu';

  @override
  String get settingsPacksSubtitle =>
      'Los packs que forman tu colección de Ohuhu.';

  @override
  String get settingsPackMode => 'Selección de packs';

  @override
  String get settingsSinglePackHint =>
      'Con un solo pack se usa únicamente el primer pack seleccionado.';

  @override
  String get settingsCorePacks => 'Packs principales';

  @override
  String get settingsAddonPacks => 'Packs adicionales';

  @override
  String get settingsOwnedTitle => 'Mis rotuladores';

  @override
  String get settingsOwnedSubtitle =>
      'Marca los rotuladores que tienes. DecoTime solo muestra los colores de los rotuladores que tienes.';

  @override
  String get settingsOwnedSearchHint => 'Buscar rotuladores';

  @override
  String get settingsSelectAll => 'Seleccionar todo';

  @override
  String get settingsSelectNone => 'Quitar selección';

  @override
  String get settingsClearOwned => 'Borrar todo';

  @override
  String get settingsClearOwnedTitle => '¿Quitar todos tus rotuladores?';

  @override
  String get settingsClearOwnedBody =>
      'Se olvidarán los rotuladores que tienes. Después puedes volver a marcarlos.';

  @override
  String get settingsOwnedEmpty =>
      'Aún no has marcado ningún rotulador. Marca los que tienes.';

  @override
  String get settingsPalettesTitle => 'Paletas guardadas';

  @override
  String get settingsPalettesEmpty => 'Aún no has guardado ninguna paleta.';

  @override
  String get settingsClearPalettes => 'Borrar todo';

  @override
  String get settingsClearPalettesTitle =>
      '¿Borrar todas las paletas guardadas?';

  @override
  String get settingsClearPalettesBody =>
      'Se borrarán las paletas guardadas de esta marca. No se puede deshacer.';

  @override
  String get settingsDeletePalette => 'Borrar la paleta';

  @override
  String get settingsFavoritesTitle => 'Favoritos';

  @override
  String get settingsFavoritesEmpty => 'Aún no tienes ningún color favorito.';

  @override
  String get settingsClearFavorites => 'Borrar todo';

  @override
  String get settingsClearFavoritesTitle => '¿Quitar todos los favoritos?';

  @override
  String get settingsClearFavoritesBody =>
      'Se quitarán los colores favoritos de esta marca. No se puede deshacer.';

  @override
  String get settingsDeleteFavorite => 'Quitar el favorito';

  @override
  String get settingsLabelsTitle => 'Nombres en pantalla';

  @override
  String get settingsLabelsSubtitle =>
      'Cómo se muestran en la app los códigos y nombres de los rotuladores.';

  @override
  String get settingsNewLabels => 'Nuevo';

  @override
  String get settingsOldLabels => 'Antiguo';

  @override
  String get settingsBothLabels => 'Ambos';

  @override
  String get settingsAppearanceTitle => 'Aspecto';

  @override
  String get settingsAppearanceSystem => 'Sistema';

  @override
  String get settingsAppearanceLight => 'Claro';

  @override
  String get settingsAppearanceDark => 'Oscuro';

  @override
  String get settingsBackupTitle => 'Copia de seguridad';

  @override
  String get settingsBackupSubtitle =>
      'Tus ajustes, paletas, historial y ajustes de IA se pueden exportar como archivo JSON e importar de nuevo.';

  @override
  String get settingsExportBackup => 'Exportar';

  @override
  String get settingsImportBackup => 'Importar';

  @override
  String get settingsBackupExported => 'Copia copiada al portapapeles';

  @override
  String get settingsBackupImported => 'Copia importada';

  @override
  String get settingsImportTitle => 'Importar una copia';

  @override
  String get settingsImportHint => 'Pega aquí el JSON exportado';

  @override
  String get settingsImportConfirm => 'Importar';

  @override
  String get settingsCancel => 'Cancelar';

  @override
  String get settingsImportConfirmTitle => '¿Reemplazar tus datos actuales?';

  @override
  String get settingsImportConfirmBody =>
      'La copia reemplaza tus ajustes, tus paletas guardadas, tu historial de colores igualados y tus ajustes de IA.';

  @override
  String get settingsImportInvalidJson => 'El texto no es un JSON válido.';

  @override
  String get settingsImportInvalidDocument =>
      'El texto no es una copia de seguridad.';

  @override
  String get settingsAiTitle => 'Asistente de IA';

  @override
  String get settingsAiSubtitle =>
      'La IA solo sugiere paletas. Nunca cambia tu colección.';

  @override
  String get settingsAiEnabled => 'Sugerir con IA';

  @override
  String get settingsAiEnabledSubtitleColourTheory =>
      'Elige En el dispositivo u OpenRouter abajo para usar una IA';

  @override
  String get settingsAiEnabledSubtitleOnDevice =>
      'Gemini Nano en este teléfono';

  @override
  String get settingsAiEnabledSubtitleOpenRouter =>
      'Usa tu propia clave de OpenRouter';

  @override
  String get settingsAiExplainColourTheory =>
      'Las paletas salen del motor de teoría del color integrado. Sin IA y sin que nada salga de tu teléfono.';

  @override
  String get settingsAiExplainOnDevice =>
      'Gemini Nano se ejecuta en este teléfono. Nada sale de tu teléfono.';

  @override
  String get settingsAiExplainOpenRouter =>
      'Las peticiones van a openrouter.ai con tu propia clave. Las fotos nunca se envían.';

  @override
  String get settingsAiProvider => 'Proveedor';

  @override
  String get settingsAiProviderColourTheory => 'Teoría del color';

  @override
  String get settingsAiProviderOnDevice => 'En el dispositivo';

  @override
  String get settingsAiProviderOpenRouter => 'OpenRouter';

  @override
  String get settingsAiTextModel => 'Modelo de texto';

  @override
  String get settingsAiTextModelHint =>
      'ID del modelo para peticiones de texto';

  @override
  String get settingsAiVisionModel => 'Modelo de visión';

  @override
  String get settingsAiVisionModelHint =>
      'ID del modelo para peticiones con imagen';

  @override
  String get settingsAiTemperature => 'Temperatura';

  @override
  String get settingsAiMaxTokens => 'Máximo de tokens';

  @override
  String get settingsAiAutoFallback => 'Recurrir a la teoría del color';

  @override
  String get settingsAiAutoFallbackSubtitle =>
      'Si falla la IA, responde el motor integrado.';

  @override
  String get settingsAiApiKey => 'Clave de API';

  @override
  String get settingsAiApiKeySubtitle =>
      'Tu propia clave, guardada en el almacén seguro de este dispositivo.';

  @override
  String get settingsAiApiKeySave => 'Guardar clave';

  @override
  String get settingsAiApiKeyRemove => 'Quitar clave';

  @override
  String get settingsAiApiKeySaved => 'Clave guardada.';

  @override
  String get settingsAiRemoveKeyTitle => '¿Quitar la clave de API?';

  @override
  String get settingsAiRemoveKeyBody =>
      'La clave se borra de este dispositivo. Las sugerencias de IA se detienen hasta que vuelvas a introducir una clave.';

  @override
  String get settingsAiRemoveKeyConfirm => 'Quitar';

  @override
  String get settingsAiApiKeyInvalid =>
      'Eso no parece una clave de OpenRouter. Debe empezar por sk-or- y no tener espacios.';

  @override
  String get settingsAiApiKeyUnreadable =>
      'No se pudo leer la clave guardada. Introdúcela de nuevo.';

  @override
  String get settingsAiApiKeyStorageError =>
      'No se pudo guardar la clave. Inténtalo de nuevo.';

  @override
  String get settingsAiDisclosureTitle => '¿Activar las sugerencias de IA?';

  @override
  String get settingsAiDisclosure =>
      'Con esto activado, cuando uses una sugerencia con OpenRouter, la app envía tu escenario, el código, el nombre y el valor hex del color base y la lista de colores candidatos a openrouter.ai y al proveedor del modelo, con tu propia clave de API. Las fotos nunca se envían: esta función no sube imágenes. No se envía nada mientras este interruptor esté desactivado.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'Con Teoría del color seleccionada, las paletas salen del motor integrado: no se usa IA y nada sale de tu teléfono. Elige En el dispositivo u OpenRouter para usar una IA.';

  @override
  String get settingsAiDisclosureConfirm => 'Activar';

  @override
  String get settingsAiDisclosureCancel => 'Ahora no';

  @override
  String get settingsAiDisclosureOnDevice =>
      'Las peticiones En el dispositivo (Gemini Nano) las responde el modelo de este teléfono. Tu escenario y los códigos de color nunca salen de él y no hace falta clave.';

  @override
  String get settingsAiOnDeviceName => 'IA en el dispositivo (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Las peticiones en el dispositivo nunca salen de tu teléfono.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'El modelo aún no está en este teléfono. Android lo descarga una vez y lo conserva para todas las apps.';

  @override
  String get settingsAiOnDeviceDownloading => 'Descargando el modelo...';

  @override
  String get settingsAiOnDevicePreparing =>
      'Android está preparando el modelo. Puede tardar y esperar a tener Wi‑Fi y carga. Puedes salir de esta pantalla; la descarga continúa en segundo plano.';

  @override
  String get settingsAiOnDeviceCheckAgain => 'Comprobar de nuevo';

  @override
  String get settingsAiOnDeviceReady =>
      'El modelo está listo en este teléfono.';

  @override
  String get settingsAiOnDeviceDownload => 'Descargar modelo';

  @override
  String get settingsAiOnDeviceFailed =>
      'La descarga no terminó. Revisa la conexión e inténtalo de nuevo.';

  @override
  String get settingsAiTestConnection => 'Probar conexión';

  @override
  String get settingsAiTestingConnection => 'Probando...';

  @override
  String get settingsAiModelsTitle => 'Modelo';

  @override
  String get settingsAiModelsFilterFree => 'Gratis';

  @override
  String get settingsAiModelsFilterPaid => 'De pago';

  @override
  String get settingsAiModelsFilterBoth => 'Ambos';

  @override
  String get settingsAiModelsLoad => 'Cargar modelos';

  @override
  String get settingsAiModelsEmpty => 'Ningún modelo coincide con este filtro.';

  @override
  String get settingsAiModelsNeedsKey =>
      'Guarda una clave para cargar los modelos de OpenRouter.';

  @override
  String get settingsAiPrimaryModel => 'Modelo de texto';

  @override
  String get settingsAiModelNone => 'Sin definir';

  @override
  String get settingsAiModelsPickerHint =>
      'Carga los modelos y elígelos de la lista.';

  @override
  String get settingsAiModelSearchHint => 'Buscar modelos';

  @override
  String get settingsAiModelFree => 'Gratis';

  @override
  String get settingsAiModelPaid => 'De pago';

  @override
  String get settingsAiModelsDone => 'Hecho';

  @override
  String get settingsAiModelsNotLoaded =>
      'Carga primero los modelos o escribe arriba un ID de modelo.';

  @override
  String get settingsAiRecommended => 'Recomendados';

  @override
  String get settingsAiFreeModelsNote =>
      'Los modelos gratuitos pueden ser lentos o poco fiables. Los recomendados son económicos y responden de forma más constante.';

  @override
  String get settingsAiAllModels => 'Todos los modelos';

  @override
  String get settingsAiRecommendedDefault => 'Predeterminado recomendado';

  @override
  String get settingsAiFallbacksTitle => 'Modelos de reserva';

  @override
  String get settingsAboutTitle => 'Acerca de';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get settingsSourceCode => 'Código fuente';

  @override
  String get settingsCopyRepository => 'Copiar el enlace';

  @override
  String get settingsRepositoryCopied => 'Enlace copiado';

  @override
  String get settingsDisclaimer =>
      'Ink Lab es un proyecto comunitario independiente: no está afiliado, respaldado ni patrocinado por Ohuhu ni DecoTime, y usa los códigos, nombres y valores de color de sus rotuladores solo como datos factuales de referencia.';

  @override
  String get paletteTitle => 'Paleta';

  @override
  String get paletteBaseCodeLabel => 'Código del rotulador base';

  @override
  String get paletteBaseCodeHint => 'E08 o B271';

  @override
  String get paletteHarmonyLabel => 'Armonía';

  @override
  String get paletteScenarioToggle => 'Escenas';

  @override
  String get paletteScenarioTitle => 'Escenarios';

  @override
  String get paletteSizeTitle => 'Tamaño';

  @override
  String get paletteSizeSemantic => 'Tamaño de la paleta';

  @override
  String get paletteGenerateButton => 'Generar';

  @override
  String get paletteRegenerateButton => 'Regenerar';

  @override
  String get paletteClearButton => 'Borrar';

  @override
  String get paletteSuggestAiButton => 'Sugerir con IA';

  @override
  String get paletteSuggestAiLoading => 'Sugiriendo…';

  @override
  String get paletteAiBadge => 'IA';

  @override
  String get paletteSaveButton => 'Guardar paleta';

  @override
  String get paletteOkButton => 'OK';

  @override
  String get paletteBaseMarkerTitle => 'Rotulador base';

  @override
  String get paletteVariationsLabel => 'Variaciones';

  @override
  String get palettePaintPlanTitle => 'Orden de pintado';

  @override
  String get palettePaintTipBase =>
      'Cubre primero la forma general con el color base.';

  @override
  String get palettePaintTipShadow => 'Pon esta sombra donde no llega la luz.';

  @override
  String get palettePaintTipHighlight =>
      'Coloca la luz donde incide directamente.';

  @override
  String get palettePaintTipAccent =>
      'Reserva el acento solo para las zonas focales.';

  @override
  String get palettePaintTipSupport =>
      'Usa este tono de apoyo para suavizar las transiciones.';

  @override
  String get paletteSubtitleIdle =>
      'Crea una paleta a partir de un rotulador que tengas';

  @override
  String get paletteAiOptionalNote => 'La IA es opcional y viene desactivada.';

  @override
  String get paletteLockButton => 'Bloquear';

  @override
  String get paletteUnlockButton => 'Desbloquear';

  @override
  String get paletteSaveDialogTitle => 'Guardar paleta';

  @override
  String get paletteSaveDialogHint => 'Nombre de la paleta';

  @override
  String get paletteSaveDialogCancel => 'Cancelar';

  @override
  String get paletteSaveDialogConfirm => 'Guardar';

  @override
  String get paletteSavedTitle => 'Paletas guardadas';

  @override
  String get paletteSavedEmpty =>
      'Aún no hay paletas guardadas para esta marca.';

  @override
  String get paletteLoadButton => 'Cargar';

  @override
  String get paletteDeleteButton => 'Borrar';

  @override
  String get paletteDeleteDialogTitle => '¿Borrar la paleta?';

  @override
  String get paletteDeleteDialogBody => 'Esta acción no se puede deshacer.';

  @override
  String get paletteAiFellBack =>
      'IA no disponible. Se muestran sugerencias locales.';

  @override
  String get paletteEmptyHint =>
      'Introduce el código de un rotulador base para crear una paleta o activa el modo Escenarios.';

  @override
  String get paletteCustomModeHint =>
      'El modo de paleta personalizada es manual: carga una paleta guardada o aplica una desde Ideas.';

  @override
  String get paletteNoSuggestions =>
      'No se pudo crear ninguna paleta con tu colección. Prueba otro modo o añade más rotuladores.';

  @override
  String get swatchesTitle => 'Muestras';

  @override
  String get swatchesSearchHint => 'Código, nombre, hex o código antiguo';

  @override
  String get swatchesClearSearch => 'Borrar la búsqueda';

  @override
  String get swatchesAllFilter => 'Todos';

  @override
  String get swatchesFavoritesOnly => 'Favoritos';

  @override
  String get swatchesOwnedOnly => 'Míos';

  @override
  String get swatchesFilters => 'Filtros';

  @override
  String get swatchesFiltersTitle => 'Filtros';

  @override
  String get swatchesLabelPack => 'Pack';

  @override
  String get swatchesLabelLayout => 'Vista';

  @override
  String get swatchesAllPacks => 'Todos los packs';

  @override
  String get swatchesClearFilters => 'Quitar filtros';

  @override
  String get swatchesLoadingSemantics => 'Cargando colores';

  @override
  String get swatchesClosestAlternatives => 'Alternativas más cercanas';

  @override
  String get swatchesDeltaEUnit => 'ΔE 76';

  @override
  String get swatchesInPacks => 'En los packs';

  @override
  String get swatchesLocation => 'Ubicación';

  @override
  String get swatchesAddToPalette => 'Añadir a la paleta';

  @override
  String get swatchesLayoutGrid => 'Cuadrícula';

  @override
  String get swatchesLayoutList => 'Lista';

  @override
  String get swatchesOwned => 'Lo tengo';

  @override
  String get swatchesNewLabels => 'Nuevo';

  @override
  String get swatchesOldLabels => 'Antiguo';

  @override
  String get swatchesBothLabels => 'Ambos';

  @override
  String get swatchesLabelMode => 'Nombres';

  @override
  String get swatchesToggleLayout => 'Cambiar entre cuadrícula y lista';

  @override
  String get swatchesGridLayout => 'Cuadrícula';

  @override
  String get swatchesListLayout => 'Lista';

  @override
  String get swatchesNewCode => 'Código nuevo';

  @override
  String get swatchesOldCode => 'Código antiguo';

  @override
  String get swatchesNewName => 'Nombre nuevo';

  @override
  String get swatchesOldName => 'Nombre antiguo';

  @override
  String get swatchesHex => 'Hex';

  @override
  String get swatchesCopyHex => 'Copiar hex';

  @override
  String get swatchesHexCopied => 'Hex copiado al portapapeles';

  @override
  String get swatchesAddFavorite => 'Añadir a favoritos';

  @override
  String get swatchesRemoveFavorite => 'Quitar de favoritos';

  @override
  String get swatchesEmptyNoOwnedTitle => 'Aún no hay rotuladores';

  @override
  String get swatchesEmptyNoOwnedBody =>
      'Las muestras de DecoTime solo enseñan los rotuladores que tienes. Añade los tuyos en Ajustes, en el gestor de rotuladores, y sus colores aparecerán aquí.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Añadir mis rotuladores';

  @override
  String get swatchesEmptyNoOwnedHint =>
      'Abre la pestaña Ajustes y usa el gestor de rotuladores.';

  @override
  String get swatchesEmptySearchTitle => 'No hay colores';

  @override
  String get swatchesEmptySearchBody =>
      'Ningún color de esta colección coincide con tu búsqueda.';

  @override
  String get swatchesEmptyFiltersTitle => 'Nada que mostrar';

  @override
  String get swatchesEmptyFiltersBody =>
      'Esta marca no tiene colores para los packs y filtros seleccionados.';

  @override
  String get swatchesLoading => 'Cargando colores…';

  @override
  String get swatchesLoadFailedTitle => 'Colores no disponibles';

  @override
  String get swatchesLoadFailedBody =>
      'No se pudo leer el catálogo de rotuladores, así que no hay colores que mostrar.';

  @override
  String get swatchesUnavailable =>
      'Los servicios de la app no están disponibles, así que no se pueden mostrar las muestras.';

  @override
  String get swatchesVisibleCount => 'Colores';

  @override
  String get swatchesScopeCollection => 'Tu colección';

  @override
  String get swatchesScopePack => 'Pack';

  @override
  String get ideasTitle => 'Ideas';

  @override
  String get ideasHeaderSubtitle => 'Guías y retos para tus rotuladores';

  @override
  String get ideasSelectedLabel => 'Seleccionada';

  @override
  String get ideasSearchHint => 'Buscar ideas';

  @override
  String get ideasCategoryAll => 'Todas';

  @override
  String get ideasBadgeGuideOnly => 'Solo guía';

  @override
  String get ideasBadgeGuideAndPalette => 'Guía + paleta';

  @override
  String get ideasShowTechnique => 'Ver técnica';

  @override
  String get ideasGenerateIdea => 'Generar idea';

  @override
  String get ideasApplyButton => 'Aplicar a Paleta';

  @override
  String get ideasHowToTitle => 'Cómo hacerlo';

  @override
  String get ideasExtraTouchesTitle => 'Toques extra';

  @override
  String get ideasSuggestedColorsTitle => 'Colores sugeridos';

  @override
  String get ideasGuideOnlyNote =>
      'Esta idea prioriza la técnica. No impone una paleta fija, así que puedes elegir los colores con libertad.';

  @override
  String get ideasNoMarkersDecoTime =>
      'Selecciona tus rotuladores DecoTime en Ajustes para generar sugerencias de color para esta idea.';

  @override
  String get ideasNoMarkersOther =>
      'No hay rotuladores disponibles con los filtros actuales de la colección.';

  @override
  String get ideasCategoriesLabel => 'Categorías';

  @override
  String get ideasEmptyTitle => 'No hay ideas';

  @override
  String get ideasClearFilters => 'Quitar filtros';

  @override
  String get ideasEmptySearch => 'Ninguna idea coincide con tu búsqueda.';

  @override
  String get ideasSelectHint => 'Elige una idea para ver cómo hacerla.';

  @override
  String get ideasNoMarkers => 'Ahora mismo no hay rotuladores disponibles';

  @override
  String get matchTitle => 'Igualar';

  @override
  String get matchPrivacyCaption => 'Las fotos se quedan en este teléfono.';

  @override
  String get matchCameraButton => 'Cámara';

  @override
  String get matchGalleryButton => 'Galería';

  @override
  String get matchLoadingPhoto => 'Leyendo la foto…';

  @override
  String get matchEmptyPhotoTitle => 'Aún no hay foto';

  @override
  String get matchEmptyPhotoMessage =>
      'Haz una foto o elige una de la galería para encontrar el rotulador más cercano.';

  @override
  String get matchPhotoSemantics => 'Foto de la que tomar un color';

  @override
  String get matchPickToSample =>
      'Toca o arrastra sobre la foto para tomar un color.';

  @override
  String get matchSampledLabel => 'Color tomado';

  @override
  String get matchBestMatchTitle => 'Mejor coincidencia';

  @override
  String get matchAlternatesTitle => 'Alternativas';

  @override
  String get matchDeltaMethod => 'ΔE 76';

  @override
  String get matchSaveButton => 'Guardar';

  @override
  String get matchRecentTitle => 'Elecciones recientes';

  @override
  String get matchRecentDetailSampled => 'Color tomado';

  @override
  String get matchRecentEmpty =>
      'Aún no hay elecciones recientes. Toca una coincidencia para guardarla aquí.';

  @override
  String get matchClearButton => 'Borrar';

  @override
  String get matchRemoveTooltip => 'Quitar';

  @override
  String get matchCloseTooltip => 'Cerrar';

  @override
  String get matchRecentPickLabel => 'Elección reciente';

  @override
  String get matchClearDialogTitle => '¿Borrar las elecciones recientes?';

  @override
  String get matchClearDialogBody =>
      'Se quitan todas las elecciones guardadas. No se puede deshacer.';

  @override
  String get matchCancelButton => 'Cancelar';

  @override
  String get matchCancelNotice => 'No se ha seleccionado ninguna foto.';

  @override
  String get matchCameraDenied =>
      'El acceso a la cámara está desactivado. Actívalo en los ajustes del dispositivo o elige una foto de la galería.';

  @override
  String get matchGalleryDenied =>
      'El acceso a las fotos está desactivado. Actívalo en los ajustes del dispositivo y vuelve a intentarlo.';

  @override
  String get matchDecodeFailed => 'No se pudo leer esa foto. Prueba con otra.';

  @override
  String get matchPickFailed => 'No se pudo abrir la foto. Inténtalo de nuevo.';

  @override
  String get matchNoMarkers =>
      'No hay rotuladores disponibles en la colección actual. Revisa la marca y los packs activos en Ajustes.';

  @override
  String get matchOkButton => 'OK';

  @override
  String get appTitle => 'Ink Lab';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOwned => 'Lo tengo';

  @override
  String get commonFavourite => 'Favorito';

  @override
  String get commonAddToFavourites => 'Añadir a favoritos';

  @override
  String get commonRemoveFromFavourites => 'Quitar de favoritos';

  @override
  String get commonClearSearch => 'Borrar búsqueda';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonBaseLocked => 'Base bloqueada';

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
    return 'Antiguo $code';
  }

  @override
  String commonMarkersAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores disponibles',
      one: '1 rotulador disponible',
    );
    return '$_temp0';
  }

  @override
  String commonColorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colores',
      one: '1 color',
    );
    return '$_temp0';
  }

  @override
  String commonCardLocation(int number) {
    return 'Carta de colores $number';
  }

  @override
  String navTabHint(int index, int count) {
    return 'Pestaña $index de $count';
  }

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Sistema';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String settingsOwnedCount(int owned, int total) {
    return '$owned de $total rotuladores';
  }

  @override
  String settingsPacksSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count packs seleccionados',
      one: '1 pack seleccionado',
    );
    return '$_temp0';
  }

  @override
  String settingsPaletteDescription(String mode, String colors) {
    return '$mode · $colors';
  }

  @override
  String settingsImportUnsupportedVersion(int version) {
    return 'Esta copia tiene una versión no compatible: $version.';
  }

  @override
  String settingsImportFailed(String reason) {
    return 'No se pudo importar la copia: $reason';
  }

  @override
  String settingsAiOnDeviceProgressTotal(
    String bytes,
    String total,
    int percent,
  ) {
    return '$bytes de $total MB descargados ($percent %)';
  }

  @override
  String settingsAiOnDeviceProgressBytes(String bytes) {
    return '$bytes MB descargados';
  }

  @override
  String settingsAiConnectionOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modelos disponibles',
      one: '1 modelo disponible',
    );
    return 'Conexión correcta ($_temp0).';
  }

  @override
  String settingsAiConnectionFailed(String reason) {
    return 'Error de conexión: $reason';
  }

  @override
  String settingsAiFallbacksCount(int count, int max) {
    return '$count de $max';
  }

  @override
  String settingsAiUseTyped(String id) {
    return 'Usar «$id»';
  }

  @override
  String settingsAiFallbacksHint(int max) {
    return 'Se prueban en orden cuando falla el modelo de arriba (hasta $max).';
  }

  @override
  String get settingsAiOnDeviceUnavailable =>
      'La IA en el dispositivo no está disponible ahora en este teléfono. Se usa la teoría del color hasta que lo esté.';

  @override
  String paletteSizeChip(int size) {
    return '$size colores';
  }

  @override
  String paletteAiLabel(String name) {
    return 'IA · $name';
  }

  @override
  String paletteAiLabelPartial(String name, int aiCount, int total) {
    return 'IA + teoría del color · $name · $aiCount/$total';
  }

  @override
  String paletteResultTitle(int count) {
    return 'Combinaciones ($count)';
  }

  @override
  String paletteSavedSubtitle(String mode, int size) {
    return '$mode · $size colores';
  }

  @override
  String paletteSubtitleFrom(String mode, String base, String available) {
    return '$mode desde $base · $available';
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
      other: '$count rotuladores',
      one: '1 rotulador',
    );
    return 'Paleta personalizada · $_temp0';
  }

  @override
  String paletteSavedNotice(String name) {
    return 'Paleta «$name» guardada.';
  }

  @override
  String paletteLoadedNotice(String name) {
    return 'Paleta «$name» cargada.';
  }

  @override
  String paletteVariationApplied(String label) {
    return 'Variación aplicada: $label.';
  }

  @override
  String paletteDraftApplied(int count) {
    return 'Paleta de Ideas aplicada ($count colores).';
  }

  @override
  String paletteUsingDefaultBase(String code, String scenario) {
    return 'Se usa $code como base predeterminada para $scenario. Introduce un código para cambiarla.';
  }

  @override
  String paletteUnknownCode(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input no es un código de rotulador de DecoTime. Prueba con $example o revisa tus rotuladores en Ajustes.',
      'other':
          '$input no es un código de rotulador de Ink Lab. Prueba con $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input no está entre tus rotuladores DecoTime. Prueba con $example o actualiza Mis rotuladores en Ajustes.',
      'other':
          '$input no está en tu colección activa. Prueba con $example o cambia de pack en Ajustes.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'No hay rotuladores DecoTime seleccionados. Ve a Ajustes > Colección > Mis rotuladores y selecciona los que tienes.',
      'other': 'No hay rotuladores disponibles con los filtros actuales de la colección.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Introduce el código de un rotulador base, como $example, o activa el modo Escenarios.';
  }

  @override
  String swatchesFiltersCount(int count) {
    return 'Filtros · $count';
  }

  @override
  String swatchesCodeCopied(String code) {
    return '$code copiado. Pégalo como color base en la pestaña Paleta.';
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
    return '$visible de $total';
  }

  @override
  String swatchesOwnedSubtitle(String brand, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuyos',
      one: '1 tuyo',
    );
    return '$brand · $_temp0';
  }

  @override
  String swatchesFilteredColorCount(int visible, int total) {
    return '$visible de $total colores';
  }

  @override
  String swatchesSwatchSemantics(String code, String name, String favorite) {
    String _temp0 = intl.Intl.selectLogic(favorite, {
      'true': '$code, $name, favorito',
      'other': '$code, $name',
    });
    return '$_temp0';
  }

  @override
  String swatchesClassicPack(String label) {
    return 'Clásico $label';
  }

  @override
  String ideasPaletteSent(String title) {
    return 'Paleta «$title» enviada a la pestaña Paleta.';
  }

  @override
  String matchSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tus $count rotuladores',
      one: 'tu rotulador',
    );
    return 'Comparando con $_temp0';
  }

  @override
  String get matchQualityExcellent => 'Excelente';

  @override
  String get matchQualityVeryClose => 'Muy cercano';

  @override
  String get matchQualityClose => 'Cercano';

  @override
  String get matchQualityFair => 'Aceptable';

  @override
  String get matchQualityApproximate => 'Aproximado';

  @override
  String matchRecorded(String code) {
    return '$code guardado en elecciones recientes.';
  }

  @override
  String get errDisabled => 'Las sugerencias de IA están desactivadas.';

  @override
  String get errMissingKey => 'No hay ninguna clave de API configurada.';

  @override
  String get errNoModelSelected => 'No hay ningún modelo de IA seleccionado.';

  @override
  String get errUnauthorized => 'Se ha rechazado la clave de API.';

  @override
  String get errPaymentRequired =>
      'La cuenta no tiene saldo o la clave ha agotado su cuota.';

  @override
  String get errRateLimited =>
      'El proveedor está limitando las peticiones. Inténtalo de nuevo en un momento.';

  @override
  String get errServerError =>
      'El proveedor ha tenido un error de servidor. Inténtalo más tarde.';

  @override
  String get errHttpError => 'El proveedor ha rechazado la petición.';

  @override
  String get errNetworkError =>
      'No se pudo contactar con el proveedor. Revisa la conexión.';

  @override
  String get errInvalidJson =>
      'El proveedor ha devuelto una respuesta ilegible.';

  @override
  String get errInvalidResponse =>
      'El proveedor no ha devuelto ninguna paleta utilizable.';

  @override
  String get errNoValidSuggestions =>
      'El proveedor ha sugerido colores que no están en la colección activa.';

  @override
  String get errNoAvailableColors =>
      'No hay rotuladores disponibles entre los que elegir.';

  @override
  String get errNoSuggestions => 'No se pudo generar ninguna sugerencia.';

  @override
  String get errTimeout =>
      'El modelo del dispositivo ha tardado demasiado. Inténtalo de nuevo.';

  @override
  String get errOnDeviceUnavailable =>
      'El modelo del dispositivo no está listo en este teléfono.';

  @override
  String get errUnknown => 'Las sugerencias de IA no están disponibles.';

  @override
  String errAiUnavailableWithReason(String reason) {
    return 'IA no disponible ($reason) Se muestran sugerencias locales.';
  }

  @override
  String get roleMainTone => 'Tono principal';

  @override
  String get roleMidtone => 'Tono medio';

  @override
  String get roleShadow => 'Sombra';

  @override
  String get roleHighlight => 'Luz';

  @override
  String get roleBlend => 'Mezcla';

  @override
  String get roleToneA => 'Tono A';

  @override
  String get roleToneAShadow => 'Sombra del tono A';

  @override
  String get roleToneB => 'Tono B';

  @override
  String get roleToneBShadow => 'Sombra del tono B';

  @override
  String get roleBridge => 'Puente';

  @override
  String get roleWarmBase => 'Base cálida';

  @override
  String get roleWarmShadow => 'Sombra cálida';

  @override
  String get roleSunlitAccent => 'Acento soleado';

  @override
  String get roleDepthTone => 'Tono de profundidad';

  @override
  String get roleCoolBase => 'Base fría';

  @override
  String get roleCoolShadow => 'Sombra fría';

  @override
  String get roleAtmosphere => 'Atmósfera';

  @override
  String get roleDeepCool => 'Frío profundo';

  @override
  String get rolePastelBase => 'Base pastel';

  @override
  String get roleSoftShade => 'Sombra tenue';

  @override
  String get rolePastelHighlight => 'Luz pastel';

  @override
  String get roleAccent => 'Acento';

  @override
  String get roleSupport => 'Apoyo';

  @override
  String get roleNeonLead => 'Neón principal';

  @override
  String get roleNeonSecondary => 'Neón secundario';

  @override
  String get roleGlow => 'Resplandor';

  @override
  String get rolePopAccent => 'Acento vivo';

  @override
  String get roleHue1 => 'Matiz 1';

  @override
  String get roleHue2 => 'Matiz 2';

  @override
  String get roleHue3 => 'Matiz 3';

  @override
  String get roleHue4 => 'Matiz 4';

  @override
  String get roleHue5 => 'Matiz 5';

  @override
  String get roleUnexpectedLead => 'Protagonista inesperado';

  @override
  String get roleContrastPair => 'Pareja de contraste';

  @override
  String get roleTensionAccent => 'Acento de tensión';

  @override
  String get roleOffbeatSupport => 'Apoyo atípico';

  @override
  String get roleRandom1 => 'Aleatorio 1';

  @override
  String get roleRandom2 => 'Aleatorio 2';

  @override
  String get roleRandom3 => 'Aleatorio 3';

  @override
  String get roleRandom4 => 'Aleatorio 4';

  @override
  String get roleRandom5 => 'Aleatorio 5';

  @override
  String get roleLightValue => 'Valor claro';

  @override
  String get roleMidLight => 'Medio claro';

  @override
  String get roleMid => 'Medio';

  @override
  String get roleMidDark => 'Medio oscuro';

  @override
  String get roleDarkValue => 'Valor oscuro';

  @override
  String get roleWarmSideA => 'Lado cálido A';

  @override
  String get roleWarmSideB => 'Lado cálido B';

  @override
  String get roleCoolSideA => 'Lado frío A';

  @override
  String get roleCoolSideB => 'Lado frío B';

  @override
  String get roleBridgeTone => 'Tono puente';

  @override
  String get roleSeasonLead => 'Estación principal';

  @override
  String get roleSeasonSupport => 'Estación de apoyo';

  @override
  String get roleFestiveRed => 'Rojo festivo';

  @override
  String get roleEvergreen => 'Verde abeto';

  @override
  String get roleGoldAccent => 'Acento dorado';

  @override
  String get rolePineShadow => 'Sombra de pino';

  @override
  String get roleSnowSupport => 'Apoyo nieve';

  @override
  String get roleRomanticLead => 'Romántico principal';

  @override
  String get roleRoseShadow => 'Sombra rosa';

  @override
  String get roleSoftBlush => 'Rubor suave';

  @override
  String get roleBalanceTone => 'Tono de equilibrio';

  @override
  String get roleBase => 'Base';

  @override
  String get roleGlowZone => 'Zona de brillo';

  @override
  String get rolePatternAccent => 'Acento del patrón';

  @override
  String get roleContrastColor => 'Color de contraste';

  @override
  String get rolePrimary1 => 'Primario 1';

  @override
  String get rolePrimary2 => 'Primario 2';

  @override
  String get rolePrimary3 => 'Primario 3';

  @override
  String get roleSecondary => 'Secundario';

  @override
  String get roleSepiaLight => 'Sepia clara';

  @override
  String get roleDustMidtone => 'Medio polvoriento';

  @override
  String get roleLeatherShadow => 'Sombra de cuero';

  @override
  String get roleAgedAccent => 'Acento envejecido';

  @override
  String get roleSmokeNeutral => 'Neutro humo';

  @override
  String get roleHauntBase => 'Base encantada';

  @override
  String get rolePumpkinGlow => 'Brillo de calabaza';

  @override
  String get roleNightShadow => 'Sombra nocturna';

  @override
  String get roleEerieAccent => 'Acento siniestro';

  @override
  String get roleFogSupport => 'Apoyo niebla';

  @override
  String get roleNightBase => 'Base nocturna';

  @override
  String get roleDeepShadow => 'Sombra profunda';

  @override
  String get roleMoonlitEdge => 'Borde de luna';

  @override
  String get roleCoolAccent => 'Acento frío';

  @override
  String get roleMist => 'Bruma';

  @override
  String get roleWaterBase => 'Base de agua';

  @override
  String get roleDepth => 'Profundidad';

  @override
  String get roleShadowWater => 'Agua en sombra';

  @override
  String get roleLightBeam => 'Haz de luz';

  @override
  String get roleBubbleHighlight => 'Luz de burbuja';

  @override
  String get roleSpookyBase => 'Base tenebrosa';

  @override
  String get roleColdShadow => 'Sombra gélida';

  @override
  String get roleHauntedAccent => 'Acento fantasmal';

  @override
  String get roleEerieHighlight => 'Luz siniestra';

  @override
  String get roleFogTone => 'Tono niebla';

  @override
  String get roleMysticBase => 'Base mística';

  @override
  String get roleSpellShadow => 'Sombra de hechizo';

  @override
  String get roleMagicalAccent => 'Acento mágico';

  @override
  String get roleRuneGlow => 'Brillo de runa';

  @override
  String get roleMoodLead => 'Ánimo principal';

  @override
  String get roleMoodShadow => 'Sombra anímica';

  @override
  String get roleEmotionAccent => 'Acento emotivo';

  @override
  String get roleMaterialBase => 'Base del material';

  @override
  String get rolePlaneShift => 'Cambio de plano';

  @override
  String get roleHardShadow => 'Sombra dura';

  @override
  String get roleSpecularEdge => 'Borde especular';

  @override
  String get rolePatinaAccent => 'Acento de pátina';

  @override
  String get roleSpaceBase => 'Base espacial';

  @override
  String get roleNebulaGlow => 'Brillo de nebulosa';

  @override
  String get roleDeepVoid => 'Vacío profundo';

  @override
  String get roleStarAccent => 'Acento estelar';

  @override
  String get roleDustCloud => 'Nube de polvo';

  @override
  String get roleGlassPaneA => 'Cristal A';

  @override
  String get roleGlassPaneB => 'Cristal B';

  @override
  String get roleGlassPaneC => 'Cristal C';

  @override
  String get roleGlassPaneD => 'Cristal D';

  @override
  String get roleLightHit => 'Impacto de luz';

  @override
  String get roleShade => 'Sombreado';

  @override
  String get roleContrast => 'Contraste';

  @override
  String get roleSoftShadow => 'Sombra suave';

  @override
  String get roleBackground => 'Fondo';

  @override
  String get roleCompanionHue => 'Matiz acompañante';

  @override
  String get rolePrimaryShadow => 'Sombra principal';

  @override
  String get roleMysticAccent => 'Acento místico';

  @override
  String get roleSecondaryAccent => 'Acento secundario';

  @override
  String get rolePumpkinShadow => 'Sombra de calabaza';

  @override
  String get roleWitchyPurple => 'Morado brujeril';

  @override
  String get roleToxicAccent => 'Acento tóxico';

  @override
  String get roleNightBackground => 'Fondo nocturno';

  @override
  String get roleRibbonRed => 'Rojo del lazo';

  @override
  String get rolePineDepth => 'Profundidad de pino';

  @override
  String get roleSnowHighlight => 'Luz de nieve';

  @override
  String get roleBudShadow => 'Sombra de brote';

  @override
  String get roleBlossomTint => 'Tinte de flor';

  @override
  String get roleFreshLeaf => 'Hoja fresca';

  @override
  String get roleDaffodilLight => 'Luz de narciso';

  @override
  String get roleRainySky => 'Cielo lluvioso';

  @override
  String get roleSkinSubjectShadow => 'Sombra de piel/sujeto';

  @override
  String get roleWarmCompanion => 'Acompañante cálido';

  @override
  String get roleNeutralBalance => 'Equilibrio neutro';

  @override
  String get roleBarkShadow => 'Sombra de corteza';

  @override
  String get roleMapleRed => 'Rojo arce';

  @override
  String get roleOliveAccent => 'Acento oliva';

  @override
  String get roleMorningMist => 'Neblina matinal';

  @override
  String get roleSubjectShadow => 'Sombra del sujeto';

  @override
  String get roleCoolCompanion => 'Acompañante frío';

  @override
  String get roleAiryHighlight => 'Luz aérea';

  @override
  String get roleSnowShadow => 'Sombra de nieve';

  @override
  String get roleFrostHighlight => 'Luz de escarcha';

  @override
  String get roleEvergreenDepth => 'Profundidad perenne';

  @override
  String get roleBerryAccent => 'Acento de baya';

  @override
  String get roleTwilightSky => 'Cielo crepuscular';

  @override
  String get roleGroundShadow => 'Sombra del suelo';

  @override
  String get roleSkyBlend => 'Mezcla de cielo';

  @override
  String get roleSunHighlight => 'Luz solar';

  @override
  String get roleContrastAccent => 'Acento de contraste';

  @override
  String get roleNeutralBuffer => 'Neutro de transición';

  @override
  String get rolePalmShadow => 'Sombra de palmera';

  @override
  String get roleCoralAccent => 'Acento coral';

  @override
  String get roleOceanSplash => 'Salpicadura de mar';

  @override
  String get roleSunbeamHighlight => 'Luz de rayo de sol';

  @override
  String get roleWarmSand => 'Arena cálida';

  @override
  String get roleLeafShadow => 'Sombra de hoja';

  @override
  String get roleMossMidtone => 'Medio musgo';

  @override
  String get roleSunlitLeaf => 'Hoja soleada';

  @override
  String get roleTrunkAccent => 'Acento de tronco';

  @override
  String get roleSkyFog => 'Cielo/niebla';

  @override
  String get rolePetalShadow => 'Sombra de pétalo';

  @override
  String get rolePetalHighlight => 'Luz de pétalo';

  @override
  String get roleSecondaryPetal => 'Pétalo secundario';

  @override
  String get roleLeafAccent => 'Acento de hoja';

  @override
  String get rolePatternBackground => 'Fondo del patrón';

  @override
  String get roleToneC => 'Tono C';

  @override
  String get roleToneD => 'Tono D';

  @override
  String get roleNeutralLinework => 'Línea neutra';

  @override
  String get roleComplement => 'Complementario';

  @override
  String get roleNeutral => 'Neutro';

  @override
  String get roleCompanion => 'Acompañante';

  @override
  String get reasonScenarioSupport => 'Apoyo de la escena';

  @override
  String get reasonBalancedPairing => 'Combinación equilibrada';

  @override
  String get reasonShadowDepth => 'Profundidad de sombra';

  @override
  String get reasonSoftNearbyHue => 'Matiz cercano suave';

  @override
  String get reasonControlledContrast => 'Contraste controlado';

  @override
  String get reasonHighlightLift => 'Realce de luz';

  @override
  String get reasonLocked => 'Bloqueado';

  @override
  String get reasonVariationSupport => 'Apoyo de la variación';

  @override
  String get reasonOppositeHueContrast => 'Contraste de matiz opuesto';

  @override
  String get reasonSplitComplementContrast =>
      'Contraste complementario dividido';

  @override
  String get reasonTriadBalance => 'Equilibrio en tríada';

  @override
  String get reasonSquareHarmony => 'Armonía cuadrada';

  @override
  String get reasonRectangleHarmony => 'Armonía rectangular';

  @override
  String get reasonSameFamilyDeeperTone => 'Misma familia, tono más profundo';

  @override
  String get reasonSameFamilyLighterTone => 'Misma familia, tono más claro';

  @override
  String get reasonManualPalette => 'Paleta manual';

  @override
  String get reasonSupportTone => 'Tono de apoyo';

  @override
  String get reasonAISuggestion => 'Sugerencia de la IA';

  @override
  String get reasonLoadedPalette => 'Paleta cargada';

  @override
  String get reasonAppliedFromIdeas => 'Aplicada desde Ideas';

  @override
  String reasonNearbyHue(int degrees) {
    return 'Armonía de matiz cercano ($degrees°)';
  }

  @override
  String reasonShadowTone(int percent) {
    return 'Tono de sombra ($percent % más oscuro)';
  }

  @override
  String reasonVariation(String prefix, String reason) {
    return '$prefix: $reason';
  }

  @override
  String get variationPrefixVibrant => 'Vivo';

  @override
  String get variationPrefixSoft => 'Suave';

  @override
  String get variationPrefixContrast => 'Contraste';

  @override
  String get variationPrefixWarm => 'Cálido';

  @override
  String get variationPrefixCool => 'Frío';

  @override
  String get variationLabelMoreVibrant => 'Más vivo';

  @override
  String get variationLabelSofter => 'Más suave';

  @override
  String get variationLabelHigherContrast => 'Más contraste';

  @override
  String get variationLabelWarmer => 'Más cálido';

  @override
  String get variationLabelCooler => 'Más frío';

  @override
  String get modeRecommended => 'Recomendada';

  @override
  String get modeComplementary => 'Complementaria';

  @override
  String get modeAnalogous => 'Análoga';

  @override
  String get modeSplitComplementary => 'Complementaria dividida';

  @override
  String get modeTriad => 'Tríada';

  @override
  String get modeSquare => 'Cuadrada';

  @override
  String get modeRectangle => 'Rectangular';

  @override
  String get modeMonochrome => 'Monocroma';

  @override
  String get modeCustomPalette => 'Paleta personalizada';

  @override
  String get modeShadow => 'Sombra';

  @override
  String get scenarioGhostCharacter => 'Personaje fantasma';

  @override
  String get scenarioCuteCharacter => 'Personaje adorable';

  @override
  String get scenarioFantasyCreature => 'Criatura fantástica';

  @override
  String get scenarioWarmPortrait => 'Retrato cálido';

  @override
  String get scenarioCoolPortrait => 'Retrato frío';

  @override
  String get scenarioSunsetLandscape => 'Paisaje al atardecer';

  @override
  String get scenarioForestScene => 'Escena de bosque';

  @override
  String get scenarioOceanScene => 'Escena marina';

  @override
  String get scenarioAutumnScene => 'Escena otoñal';

  @override
  String get scenarioSpringGarden => 'Jardín primaveral';

  @override
  String get scenarioCozyInterior => 'Interior acogedor';

  @override
  String get scenarioVintageRoom => 'Habitación vintage';

  @override
  String get scenarioPastelDream => 'Sueño pastel';

  @override
  String get scenarioNeonNight => 'Noche de neón';

  @override
  String get scenarioMoodyNight => 'Noche melancólica';

  @override
  String get scenarioFloralPattern => 'Patrón floral';

  @override
  String get scenarioGeometricPattern => 'Patrón geométrico';

  @override
  String get scenarioPlaidPattern => 'Patrón de cuadros';

  @override
  String get scenarioPolkaDotPattern => 'Patrón de lunares';

  @override
  String get scenarioCandyStripes => 'Rayas de caramelo';

  @override
  String get scenarioHalloweenMood => 'Ambiente de Halloween';

  @override
  String get scenarioChristmasMood => 'Ambiente navideño';

  @override
  String get scenarioSpringMood => 'Ambiente primaveral';

  @override
  String get scenarioSummerMood => 'Ambiente veraniego';

  @override
  String get scenarioAutumnMood => 'Ambiente otoñal';

  @override
  String get scenarioWinterMood => 'Ambiente invernal';

  @override
  String get scenarioWinterSnow => 'Nieve de invierno';

  @override
  String get packModeSinglePack => 'Un solo pack';

  @override
  String get packModeComparePacks => 'Comparar packs';

  @override
  String get packLabel120New => '120 Nuevo';

  @override
  String get packLabel36Skin => '36 Piel';

  @override
  String get packLabel36Gray => '36 Grises';

  @override
  String get packLabel48Pastel => '48 Pastel';

  @override
  String get categorySignature => 'Firma';

  @override
  String get categoryChallenges => 'Retos';

  @override
  String get categoryAtmosphere => 'Atmósfera';

  @override
  String get ideaStickerEffectTitle => 'Efecto pegatina';

  @override
  String get ideaStickerEffectSummary =>
      'Haz que los sujetos parezcan pegatinas recortadas con un halo blanco y un contorno exterior negro.';

  @override
  String get ideaStickerEffectOverview =>
      'Reto de técnica. La ilusión viene del tratamiento de los bordes, no de una paleta concreta.';

  @override
  String get ideaStickerEffectStep1 =>
      'Colorea primero el sujeto principal de forma normal.';

  @override
  String get ideaStickerEffectStep2 =>
      'Añade un halo blanco limpio alrededor de toda la silueta.';

  @override
  String get ideaStickerEffectStep3 =>
      'Repasa el borde exterior de ese halo blanco con una línea negra.';

  @override
  String get ideaStickerEffectStep4 =>
      'Opcional: añade una pequeña sombra proyectada en un lado para que destaque.';

  @override
  String get ideaStickerEffectEmbellishment1 =>
      'Mantén el grosor del halo constante para un recorte más limpio.';

  @override
  String get ideaStickerEffectEmbellishment2 =>
      'Si los bordes quedan irregulares, suavízalos con bolígrafo blanco antes del contorno negro.';

  @override
  String get ideaPolaroidFrameTitle => 'Marco Polaroid';

  @override
  String get ideaPolaroidFrameSummary =>
      'Dibuja un marco Polaroid, colorea solo el interior y deja todo lo de fuera en escala de grises.';

  @override
  String get ideaPolaroidFrameOverview =>
      'Crea una composición de foto instantánea falsa. El interior lleva todo el color y el resto se queda en grises controlados.';

  @override
  String get ideaPolaroidFrameStep1 =>
      'Dibuja un marco Polaroid con el borde inferior más ancho.';

  @override
  String get ideaPolaroidFrameStep2 =>
      'Cubre todo lo de fuera del marco con 2 o 3 valores de gris.';

  @override
  String get ideaPolaroidFrameStep3 =>
      'Colorea solo la ventana interior de la foto con los colores de tu sujeto.';

  @override
  String get ideaPolaroidFrameStep4 =>
      'Añade una sombra suave al marco para que la foto parezca estar sobre la página.';

  @override
  String get ideaPolaroidFrameEmbellishment1 =>
      'Escribe una pequeña fecha en el borde inferior para darle realismo.';

  @override
  String get ideaPolaroidFrameEmbellishment2 =>
      'Haz el gris exterior algo más frío para realzar la calidez del interior.';

  @override
  String get ideaSpotlightTitle => 'Foco de luz';

  @override
  String get ideaSpotlightSummary =>
      'Crea una luz focal intensa con bordes oscuros y una caída de valores suave.';

  @override
  String get ideaSpotlightOverview =>
      'Dirige la atención con el contraste de valores: centro luminoso, perímetro oscuro y una caída de luz clara.';

  @override
  String get ideaSpotlightStep1 =>
      'Marca el centro del foco antes de poner color.';

  @override
  String get ideaSpotlightStep2 =>
      'Mantén la zona focal brillante y con mucho contraste.';

  @override
  String get ideaSpotlightStep3 =>
      'Oscurece los valores poco a poco al alejarte del centro.';

  @override
  String get ideaSpotlightStep4 =>
      'Termina con una viñeta suave en los bordes de la página.';

  @override
  String get ideaSpotlightEmbellishment1 =>
      'Usa bordes más duros cerca del punto focal y más suaves lejos de él.';

  @override
  String get ideaSpotlightEmbellishment2 =>
      'Evita acentos brillantes en las esquinas para que el foco siga centrado.';

  @override
  String get ideaOneColorTitle => 'Un solo color';

  @override
  String get ideaOneColorSummary =>
      'Usa una única familia de matiz y controla el contraste solo con el valor y la saturación.';

  @override
  String get ideaOneColorOverview =>
      'Un matiz, muchos valores. La profundidad viene de los cambios de luminosidad y saturación, no de la variedad de matices.';

  @override
  String get ideaOneColorStep1 =>
      'Elige una familia de matiz dominante para toda la obra.';

  @override
  String get ideaOneColorStep2 =>
      'Separa los planos con cambios de valor, no de matiz.';

  @override
  String get ideaOneColorStep3 =>
      'Reserva el mayor contraste para tu elemento focal.';

  @override
  String get ideaOneColorStep4 =>
      'Varía la saturación para evitar zonas planas.';

  @override
  String get ideaOneColorEmbellishment1 =>
      'Cambia la textura para separar materiales cuando hay poca variedad de matiz.';

  @override
  String get ideaOneColorEmbellishment2 =>
      'Deja un micro acento en el valor más brillante para dar claridad al foco.';

  @override
  String get ideaTwoColorsTitle => 'Dos colores';

  @override
  String get ideaTwoColorsSummary =>
      'Construye la escena con solo dos familias de matiz dominantes y tonos de apoyo sutiles.';

  @override
  String get ideaTwoColorsOverview =>
      'Limita la escena a dos familias de matiz y deja que el contraste venga del valor, no de la amplitud de la paleta.';

  @override
  String get ideaTwoColorsStep1 =>
      'Asigna cada zona principal a una de las dos familias de matiz.';

  @override
  String get ideaTwoColorsStep2 =>
      'Mantén las transiciones limpias para conservar el concepto de dos tonos.';

  @override
  String get ideaTwoColorsStep3 =>
      'Usa un único neutro de puente solo donde haga falta.';

  @override
  String get ideaTwoColorsStep4 =>
      'Haz que un matiz domine y el otro acompañe.';

  @override
  String get ideaTwoColorsEmbellishment1 =>
      'Deja que un matiz ocupe las formas grandes y el segundo actúe como acento.';

  @override
  String get ideaTwoColorsEmbellishment2 =>
      'Si se rompe la armonía, añade un tono puente poco saturado en las transiciones.';

  @override
  String get ideaFiftyFiftyTitle => 'Mitad y mitad';

  @override
  String get ideaFiftyFiftySummary =>
      'Divide la composición en dos ambientes: un lado cálido, otro frío y un color puente.';

  @override
  String get ideaFiftyFiftyOverview =>
      'Compón dos ambientes distintos en una sola imagen. Mantén cada lado coherente y únelos con un tono puente.';

  @override
  String get ideaFiftyFiftyStep1 =>
      'Divide la página en vertical o en horizontal.';

  @override
  String get ideaFiftyFiftyStep2 =>
      'Asigna matices cálidos a un lado y fríos al otro.';

  @override
  String get ideaFiftyFiftyStep3 =>
      'Usa un tono puente en el límite para que la división parezca intencionada.';

  @override
  String get ideaFiftyFiftyStep4 =>
      'Mantén cada mitad coherente en valor y saturación.';

  @override
  String get ideaFiftyFiftyEmbellishment1 =>
      'Repite un pequeño motivo en ambas mitades para unir el concepto.';

  @override
  String get ideaFiftyFiftyEmbellishment2 =>
      'Haz un lado algo más oscuro para evitar la fatiga de una simetría perfecta.';

  @override
  String get ideaWarmColorsTitle => 'Colores cálidos';

  @override
  String get ideaWarmColorsSummary =>
      'Usa solo matices cálidos para una escena enérgica, acogedora y soleada.';

  @override
  String get ideaWarmColorsOverview =>
      'Los matices cálidos transmiten energía e intimidad. Mantén las sombras cálidas en lugar de grises neutros.';

  @override
  String get ideaCoolColorsTitle => 'Colores fríos';

  @override
  String get ideaCoolColorsSummary =>
      'Usa matices fríos para dar calma, profundidad y distancia atmosférica.';

  @override
  String get ideaCoolColorsOverview =>
      'Los matices fríos crean profundidad y calma. Controla los escalones de valor para evitar un acabado plano.';

  @override
  String get ideaPastelTitle => 'Pastel';

  @override
  String get ideaPastelSummary =>
      'Valores claros y poca saturación para un acabado suave y soñador.';

  @override
  String get ideaPastelOverview =>
      'Las escenas pastel dependen del control del valor y de un contraste sutil más que de la intensidad del matiz.';

  @override
  String get ideaNeonTitle => 'Neón';

  @override
  String get ideaNeonSummary =>
      'Colores vivos y llenos de energía que resaltan sobre tonos de apoyo oscuros.';

  @override
  String get ideaNeonOverview =>
      'El neón necesita contraste. Reserva al menos una zona oscura de apoyo para que los acentos brillantes resplandezcan.';

  @override
  String get ideaRainbowTitle => 'Arcoíris';

  @override
  String get ideaRainbowSummary =>
      'Reparte familias de matiz por toda la obra manteniendo los valores controlados.';

  @override
  String get ideaRainbowOverview =>
      'Usa una amplia gama de matices, pero deja una familia dominante para que la obra siga sintiéndose unificada.';

  @override
  String get ideaUnlikelyColorsTitle => 'Colores improbables';

  @override
  String get ideaUnlikelyColorsSummary =>
      'Prueba combinaciones inesperadas para dar un aire estilizado a sujetos corrientes.';

  @override
  String get ideaUnlikelyColorsOverview =>
      'Las combinaciones inesperadas pueden parecer intencionadas si la jerarquía de valores sigue clara.';

  @override
  String get ideaRandomColorsTitle => 'Colores al azar';

  @override
  String get ideaRandomColorsSummary =>
      'Usa una paleta aleatoria y consigue cohesión con una buena planificación de valores.';

  @override
  String get ideaRandomColorsOverview =>
      'Las paletas aleatorias resultan coherentes si mantienes una zona focal y un contraste controlado.';

  @override
  String get ideaGrayscaleTitle => 'Escala de grises';

  @override
  String get ideaGrayscaleSummary =>
      'Trabaja solo con valores para mejorar la profundidad y el control del contraste.';

  @override
  String get ideaGrayscaleOverview =>
      'Limita la información de color y céntrate en la profundidad, la jerarquía y la separación de materiales solo con el valor.';

  @override
  String get ideaSeasonalTitle => 'De temporada';

  @override
  String get ideaSeasonalSummary =>
      'Mezcla señales de primavera, verano, otoño o invierno en una paleta cohesionada.';

  @override
  String get ideaSeasonalOverview =>
      'Las paletas de temporada funcionan mejor cuando una estación domina y las demás refuerzan el ambiente.';

  @override
  String get ideaChristmasTitle => 'Navidad';

  @override
  String get ideaChristmasSummary =>
      'Gama clásica de rojo, verde y dorado para un contraste festivo y luces acogedoras.';

  @override
  String get ideaChristmasOverview =>
      'Equilibrio navideño clásico: luces cálidas, rojos y verdes intensos y acentos brillantes puntuales.';

  @override
  String get ideaValentinesTitle => 'San Valentín';

  @override
  String get ideaValentinesSummary =>
      'Rojos y rosas románticos con luces suaves y transiciones cálidas.';

  @override
  String get ideaValentinesOverview =>
      'La armonía romántica nace de transiciones cálidas y de colocar las luces con delicadeza.';

  @override
  String get ideaWhiteEffectsTitle => 'Efectos blancos';

  @override
  String get ideaWhiteEffectsSummary =>
      'Planifica la paleta para dejar espacio a destellos y brillos hechos con bolígrafo blanco.';

  @override
  String get ideaWhiteEffectsOverview =>
      'Reserva espacios en blanco y zonas de valor alto para que los efectos de tinta blanca se lean con claridad.';

  @override
  String get ideaWhiteEffectsEmbellishment1 =>
      'Usa el bolígrafo blanco para destellos en metal, ojos y reflejos en el agua.';

  @override
  String get ideaWhiteEffectsEmbellishment2 =>
      'Pon los puntos de luz en grupos, no a intervalos regulares, para un brillo más natural.';

  @override
  String get ideaBlackEffectsTitle => 'Efectos negros';

  @override
  String get ideaBlackEffectsSummary =>
      'Usa detalles de línea negra, puntos y tramas superpuestas para reforzar el contraste.';

  @override
  String get ideaBlackEffectsOverview =>
      'Planifica zonas de tonos medios donde los detalles a bolígrafo negro aporten textura y fuerza gráfica.';

  @override
  String get ideaBlackEffectsEmbellishment1 =>
      'Usa puntos o rayas negras para dar textura cuando las capas de color se hayan secado.';

  @override
  String get ideaBlackEffectsEmbellishment2 =>
      'Concentra los detalles negros cerca de las zonas focales para darles más énfasis.';

  @override
  String get ideaCrayonsOnlyTitle => 'Solo ceras';

  @override
  String get ideaCrayonsOnlySummary =>
      'Paleta sencilla y atrevida que imita el comportamiento y la textura de las ceras clásicas.';

  @override
  String get ideaCrayonsOnlyOverview =>
      'El estilo cera prefiere bloques simples, primarios intensos y una textura de trazo visible.';

  @override
  String get ideaOldWestTitle => 'Lejano Oeste';

  @override
  String get ideaOldWestSummary =>
      'Gama sepia polvorienta con calidez apagada, como una estampa antigua del Oeste.';

  @override
  String get ideaOldWestOverview =>
      'Atmósfera de foto envejecida con medios tonos polvorientos, cálidos apagados y luces contenidas.';

  @override
  String get ideaOldWestStep1 =>
      'Extiende una base de tono sepia por las zonas principales.';

  @override
  String get ideaOldWestStep2 =>
      'Usa medios tonos polvorientos y evita los acentos muy saturados.';

  @override
  String get ideaOldWestStep3 =>
      'Refuerza las sombras con marrones apagados en lugar de negro puro.';

  @override
  String get ideaOldWestStep4 =>
      'Reserva las luces para los bordes desgastados y los puntos donde da el sol.';

  @override
  String get ideaOldWestEmbellishment1 =>
      'Añade puntitos de grano sutiles en las zonas vacías para dar textura envejecida.';

  @override
  String get ideaOldWestEmbellishment2 =>
      'Usa bordes rotos en las luces para imitar el papel impreso desgastado.';

  @override
  String get ideaHorrorHalloweenTitle => 'Terror/Halloween';

  @override
  String get ideaHorrorHalloweenSummary =>
      'Valores oscuros y acentos siniestros para convertir escenas normales en algo tenebroso.';

  @override
  String get ideaHorrorHalloweenOverview =>
      'Acentúa la oscuridad y los acentos siniestros puntuales para convertir escenas normales en inquietantes.';

  @override
  String get ideaHorrorHalloweenStep1 =>
      'Baja el valor general para establecer primero la oscuridad.';

  @override
  String get ideaHorrorHalloweenStep2 =>
      'Coloca los matices siniestros solo cerca de las formas focales.';

  @override
  String get ideaHorrorHalloweenStep3 =>
      'Usa sombras de borde más duro para crear tensión.';

  @override
  String get ideaHorrorHalloweenStep4 =>
      'Mantén las luces brillantes escasas y direccionales.';

  @override
  String get ideaHorrorHalloweenEmbellishment1 =>
      'Añade un ruido de color sutil en las sombras para una textura inquietante.';

  @override
  String get ideaHorrorHalloweenEmbellishment2 =>
      'Usa un borde nítido y de mucho contraste para crear tensión visual.';

  @override
  String get ideaMidnightTitle => 'Medianoche';

  @override
  String get ideaMidnightSummary =>
      'Convierte escenas diurnas en nocturnas con sombras frías y luces selectivas.';

  @override
  String get ideaMidnightOverview =>
      'La conversión a noche depende de sombras más frías, valores más bajos y acentos de luz escasos.';

  @override
  String get ideaMidnightStep1 =>
      'Convierte las zonas cálidas del día en tonos nocturnos más fríos.';

  @override
  String get ideaMidnightStep2 =>
      'Haz el cielo y el fondo más oscuros que el plano medio.';

  @override
  String get ideaMidnightStep3 =>
      'Añade acentos de luz de luna en los bordes orientados hacia arriba.';

  @override
  String get ideaMidnightStep4 =>
      'Suaviza los elementos lejanos para aumentar la profundidad nocturna.';

  @override
  String get ideaMidnightEmbellishment1 =>
      'Mantén las luces frías y escasas para no devolver la sensación de día.';

  @override
  String get ideaMidnightEmbellishment2 =>
      'Oscurece más las esquinas que el centro para lograr un encuadre nocturno natural.';

  @override
  String get ideaUnderwaterTitle => 'Bajo el agua';

  @override
  String get ideaUnderwaterSummary =>
      'Paleta acuática fría con bruma de profundidad, rayos de luz y acentos de burbujas.';

  @override
  String get ideaUnderwaterOverview =>
      'La profundidad del agua se logra con cambios fríos, distancia suavizada, partículas en suspensión y burbujas.';

  @override
  String get ideaUnderwaterStep1 =>
      'Empieza con capas base de azul verdoso frío.';

  @override
  String get ideaUnderwaterStep2 =>
      'Difumina los elementos lejanos bajando el contraste.';

  @override
  String get ideaUnderwaterStep3 =>
      'Añade rayos de luz direccionales para sugerir la profundidad del agua.';

  @override
  String get ideaUnderwaterStep4 =>
      'Usa luces pálidas con moderación en burbujas y bordes reflectantes.';

  @override
  String get ideaUnderwaterEmbellishment1 =>
      'Añade grupos de burbujas de distintos tamaños, más densos junto al haz de luz.';

  @override
  String get ideaUnderwaterEmbellishment2 =>
      'Pinta diminutas partículas en suspensión para dar volumen al agua.';

  @override
  String get ideaUnderwaterEmbellishment3 =>
      'Curva un poco los rayos de luz para lograr un efecto submarino natural.';

  @override
  String get ideaSpookyTitle => 'Tenebroso';

  @override
  String get ideaSpookySummary =>
      'Ambiente de lugar encantado con oscuros desaturados y tonos de acento escalofriantes.';

  @override
  String get ideaSpookyOverview =>
      'Un aire encantado usa campos oscuros desaturados y acentos siniestros aislados.';

  @override
  String get ideaSpookyStep1 =>
      'Parte de una base neutra tenue y poco saturada.';

  @override
  String get ideaSpookyStep2 =>
      'Introduce un matiz siniestro en las zonas focales clave.';

  @override
  String get ideaSpookyStep3 =>
      'Usa bordes de sombra irregulares para una atmósfera encantada.';

  @override
  String get ideaSpookyStep4 =>
      'Mantén los fondos discretos para que el sujeto se vea aislado.';

  @override
  String get ideaFantasyTitle => 'Fantasía';

  @override
  String get ideaFantasySummary =>
      'Tonos mágicos con acentos luminosos y un contraste estilizado.';

  @override
  String get ideaFantasyOverview =>
      'Apuesta por matices estilizados y acentos luminosos sin perder la legibilidad de las sombras.';

  @override
  String get ideaInTheMoodTitle => 'Según el ánimo';

  @override
  String get ideaInTheMoodSummary =>
      'Expresa un tono emocional mediante el ritmo de valores y la inclinación del matiz.';

  @override
  String get ideaInTheMoodOverview =>
      'Elige una dirección emocional y alinea con ella cada decisión de matiz y valor.';

  @override
  String get ideaSculptureTitle => 'Escultura';

  @override
  String get ideaSculptureSummary =>
      'Paleta metálica o pétrea centrada en las luces del material y los bordes duros.';

  @override
  String get ideaSculptureOverview =>
      'El realismo del material nace del control de los bordes, los planos de valor y una saturación contenida.';

  @override
  String get ideaGalaxyTitle => 'Galaxia';

  @override
  String get ideaGalaxySummary =>
      'Gama inspirada en nebulosas, con sombras de espacio profundo y acentos de luz estelar.';

  @override
  String get ideaGalaxyOverview =>
      'Las escenas cósmicas necesitan oscuros profundos, zonas de nebulosa vibrantes y estrellitas de mucho contraste.';

  @override
  String get ideaStainedGlassTitle => 'Vidriera';

  @override
  String get ideaStainedGlassSummary =>
      'Paleta de tonos joya con separadores oscuros que imitan piezas de vidrio emplomado.';

  @override
  String get ideaStainedGlassOverview =>
      'Piensa en paneles de color y separadores oscuros en lugar de mezclas suaves y pictóricas.';

  @override
  String get ideaStainedGlassStep1 =>
      'Rellena paneles de color separados antes de mezclar nada.';

  @override
  String get ideaStainedGlassStep2 =>
      'Deja separadores oscuros entre las formas principales.';

  @override
  String get ideaStainedGlassStep3 =>
      'Aumenta la saturación en los paneles centrales para ganar luminosidad.';

  @override
  String get ideaStainedGlassStep4 =>
      'Usa las luces como luz reflejada, no como degradados suaves.';

  @override
  String get ideaStainedGlassEmbellishment1 =>
      'Usa separadores negros finos para imitar las líneas de plomo.';

  @override
  String get ideaStainedGlassEmbellishment2 =>
      'Mantén limpio el matiz de cada panel y evita mezclas sucias.';

  @override
  String get ideaDefaultOverview => 'Reto creativo';

  @override
  String get ideaDefaultStep1 =>
      'Cubre las formas grandes con tus tonos dominantes.';

  @override
  String get ideaDefaultStep2 =>
      'Crea profundidad con un color de apoyo más claro y otro más oscuro.';

  @override
  String get ideaDefaultStep3 =>
      'Usa el color de acento solo en las zonas focales.';

  @override
  String get ideaDefaultStep4 =>
      'Termina limpiando las líneas y con luces controladas.';

  @override
  String get ideaDefaultEmbellishment1 =>
      'Haz una pasada final para simplificar los acentos y dejar una única zona focal clara.';

  @override
  String get ideaDefaultEmbellishment2 =>
      'Reserva tu luz más brillante para el sujeto al que quieras dar la primera atención.';

  @override
  String get settingsLinesTitle => 'Líneas que tienes';

  @override
  String get settingsLinesHint =>
      'Elige todas las líneas de Ohuhu que tengas. Si desactivas una línea, sus packs se quitan de tu selección.';

  @override
  String settingsLineSelectedOfTotal(int selected, int total) {
    return '$selected de $total packs seleccionados';
  }

  @override
  String settingsCurrentPacks(int count) {
    return 'Packs actuales ($count)';
  }

  @override
  String settingsLegacyPacks(int count) {
    return 'Packs antiguos / de la comunidad ($count)';
  }

  @override
  String get settingsLegacyPacksNote =>
      'Lista de packs aportada por la comunidad; puede que ya no se vendan.';

  @override
  String settingsPackColorsSemantics(String pack, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colores',
      one: '1 color',
    );
    return '$pack, $_temp0';
  }

  @override
  String get swatchesLines => 'Líneas';

  @override
  String get swatchesLabelLine => 'Línea';

  @override
  String get swatchesAllLines => 'Todas las líneas';

  @override
  String get swatchesLegacyPacks => 'Antiguos / comunidad';

  @override
  String packLabelSkin(String n) {
    return '$n Piel';
  }

  @override
  String packLabelPastel(String n) {
    return '$n Pastel';
  }

  @override
  String packLabelPastels(String n) {
    return '$n Pasteles';
  }

  @override
  String packLabelBasic(String n) {
    return '$n Básico';
  }

  @override
  String packLabelIllustration(String n) {
    return '$n Ilustración';
  }

  @override
  String packLabelLandscape(String n) {
    return '$n Paisaje';
  }

  @override
  String packLabelSweetPastels(String n) {
    return '$n Pasteles dulces';
  }

  @override
  String packLabelMidTones(String n) {
    return '$n Tonos medios';
  }

  @override
  String packLabelBlossomPastels(String n) {
    return '$n Pasteles en flor';
  }

  @override
  String packLabelWhiteCase(String n) {
    return 'Estuche blanco $n';
  }

  @override
  String packLabelWhiteCaseVersion(String n, String v) {
    return 'Estuche blanco $n (V$v)';
  }

  @override
  String packLabelJapanVersion(String n, String v) {
    return 'Japón $n (V$v)';
  }

  @override
  String packFullLabel(String line, String pack) {
    return '$line $pack';
  }

  @override
  String swatchesMorePacks(int count) {
    return '+$count más';
  }
}
