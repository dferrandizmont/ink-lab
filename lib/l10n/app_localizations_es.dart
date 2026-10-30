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
  String get settingsCollectionGroup => 'Mi colección';

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
  String get settingsBrandSubtitle =>
      'La marca elige el catálogo de rotuladores con el que trabaja la app.';

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
  String get settingsLabelsTitle => 'Códigos de Ohuhu';

  @override
  String get settingsLabelsSubtitle => 'Ohuhu cambió sus códigos en 2023.';

  @override
  String get settingsNewLabels => 'Actuales';

  @override
  String get settingsOldLabels => 'Antiguos';

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
      'La copia reemplaza tus ajustes, tus paletas guardadas, tu historial de colores emparejados y tus ajustes de IA.';

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
  String get settingsAiEnabledSubtitleColourTheoryNoOnDevice =>
      'Elige OpenRouter abajo para usar una IA';

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
      'Gemini Nano funciona en este teléfono y tus peticiones no salen de él. ML Kit de Google envía a Google diagnósticos de uso.';

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
  String get settingsAiAutoFallback => 'Respaldo integrado';

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
      'Con esto activado, cuando pidas una sugerencia a OpenRouter, la app envía a openrouter.ai y al proveedor del modelo, con tu propia clave de API: la marca, el modo de paleta y la escena, el código y el nombre del rotulador base y si está fijado, el tamaño de la paleta, los códigos y colores hex de los rotuladores candidatos, los ajustes del modelo y las instrucciones fijas de la app. Las fotos nunca se envían: esta función no sube imágenes. En Android, la app también puede preguntar a ML Kit de Google si Gemini Nano está disponible; ML Kit envía a Google diagnósticos de uso. No se envía nada mientras este interruptor esté desactivado.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'Con Teoría del color seleccionada, las paletas salen del motor integrado: no se usa IA y no salen de tu teléfono. En Android, la app puede preguntar a ML Kit de Google si Gemini Nano está disponible; ML Kit envía a Google diagnósticos de uso, nunca tus colores ni fotos. Elige En el dispositivo u OpenRouter para usar una IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'Con Teoría del color seleccionada, las paletas salen del motor integrado: no se usa IA y no salen de tu teléfono. En Android, la app puede preguntar a ML Kit de Google si Gemini Nano está disponible; ML Kit envía a Google diagnósticos de uso, nunca tus colores ni fotos. Elige OpenRouter para usar una IA.';

  @override
  String get settingsAiDisclosureConfirm => 'Activar';

  @override
  String get settingsAiDisclosureCancel => 'Ahora no';

  @override
  String get settingsAiDisclosureOnDevice =>
      'Las peticiones En el dispositivo (Gemini Nano) las responde el modelo de este teléfono: tu escenario y los códigos de color nunca salen de él y no hace falta clave. Para comprobar, descargar y usar el modelo, la app usa ML Kit de Google, que envía a Google diagnósticos de uso (modelo del móvil, versión de la app, identificadores de instalación, errores y tamaños), nunca tus peticiones, colores ni fotos. No se envía nada mientras este interruptor esté desactivado.';

  @override
  String get settingsAiOnDeviceName => 'IA en el dispositivo (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Tus peticiones no salen de este teléfono. ML Kit envía a Google diagnósticos de uso, nunca tus peticiones, colores ni fotos.';

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
  String get settingsPrivacyPolicy => 'Política de privacidad';

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
  String get paletteScenarioToggle => 'Escenas';

  @override
  String get paletteTypeTitle => 'Tipo de paleta';

  @override
  String get paletteTypeSheetTitle => 'Elige el tipo de paleta';

  @override
  String get paletteTypeTheoryGroup => 'Teoría del color';

  @override
  String get paletteTypeScenesGroup => 'Escenas';

  @override
  String get paletteTypeScenesHint => 'Recetas listas por motivo';

  @override
  String get paletteTypeDescRecommended => 'Combinaciones para tu base';

  @override
  String get paletteTypeDescComplementary => 'Matiz opuesto, contraste fuerte';

  @override
  String get paletteTypeDescAnalogous => 'Matices vecinos, en calma';

  @override
  String get paletteTypeDescSplitComplementary =>
      'Dos matices junto al opuesto';

  @override
  String get paletteTypeDescTriad => 'Tres matices equidistantes';

  @override
  String get paletteTypeDescSquare => 'Cuatro matices equidistantes';

  @override
  String get paletteTypeDescRectangle => 'Dos pares complementarios';

  @override
  String get paletteTypeDescMonochrome => 'Un matiz, de claro a oscuro';

  @override
  String get paletteTypeDescShadow => 'Tonos oscuros para sombrear';

  @override
  String get paletteTypeDescCustomPalette => 'Constrúyela a mano';

  @override
  String paletteTypeSemantic(String value) {
    return 'Tipo de paleta, $value';
  }

  @override
  String get paletteSceneTitle => 'Escena';

  @override
  String get paletteSceneSheetTitle => 'Elige una escena';

  @override
  String get paletteSceneSearchHint => 'Busca escena o categoría';

  @override
  String get paletteSceneEmpty => 'Ninguna escena coincide con tu búsqueda.';

  @override
  String paletteSceneSemantic(String value) {
    return 'Escena, $value';
  }

  @override
  String get paletteFromPhotoTitle => 'Desde una foto';

  @override
  String get paletteFromPhotoHint => 'Tu foto, con tus rotuladores';

  @override
  String get paletteFromPhotoValue => 'Tu foto';

  @override
  String paletteFromPhotoRole(int percent) {
    return 'Color de la foto · $percent %';
  }

  @override
  String get paletteFromPhotoEmpty =>
      'No se han podido sacar colores de esta foto';

  @override
  String get paletteFromPhotoFarNote =>
      'Algunos colores de la foto no tienen un rotulador parecido en tu colección';

  @override
  String get sceneCategoryCharacters => 'Personajes';

  @override
  String get sceneCategorySkin => 'Pieles y retratos';

  @override
  String get sceneCategorySkyWater => 'Cielos y agua';

  @override
  String get sceneCategoryNature => 'Naturaleza';

  @override
  String get sceneCategoryMaterials => 'Materiales';

  @override
  String get sceneCategoryAnimals => 'Animales y pelaje';

  @override
  String get sceneCategoryFood => 'Comida';

  @override
  String get sceneCategoryHolidays => 'Fiestas y ambientes';

  @override
  String get sceneCategoryInteriors => 'Interiores';

  @override
  String get sceneCategoryPatterns => 'Patrones';

  @override
  String get sceneCategoryFantasy => 'Fantasía';

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
      'Crea una paleta con un rotulador que tengas';

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
  String get paletteAiReportButton => 'Reportar esta sugerencia';

  @override
  String get paletteAiReportTitle => 'Reportar esta sugerencia';

  @override
  String get paletteAiReportBody =>
      'Avísanos si la IA ha escrito algo ofensivo, inapropiado o erróneo. Se abrirá tu app de correo con el texto de la sugerencia; tú decides si lo envías. Tu clave de API nunca se incluye.';

  @override
  String get paletteAiReportOffensive => 'Ofensiva o inapropiada';

  @override
  String get paletteAiReportWrong => 'Errónea o sin sentido';

  @override
  String get paletteAiReportOther => 'Otra cosa';

  @override
  String get paletteAiReportSend => 'Enviar por correo';

  @override
  String get paletteAiReportThanks =>
      'Gracias, nos ayuda a mejorar las sugerencias';

  @override
  String get paletteAiReportCopied =>
      'No hay app de correo. Se ha copiado el informe: pégalo en un correo a dev@mainshai.com';

  @override
  String get paletteAiFellBack =>
      'IA no disponible. Se muestran sugerencias locales.';

  @override
  String get paletteEmptyHint =>
      'Elige un rotulador base para crear una paleta, o elige Escenas como tipo de paleta.';

  @override
  String get paletteCustomModeHint =>
      'El modo de paleta personalizada es manual: carga una paleta guardada o aplica una desde Ideas.';

  @override
  String get paletteNoSuggestions =>
      'No se pudo crear ninguna paleta con tu colección. Prueba otro modo o añade más rotuladores.';

  @override
  String get palettePickBaseTooltip => 'Elegir de tus rotuladores';

  @override
  String get palettePickerTitle => 'Elige el rotulador base';

  @override
  String get palettePickerSearchHint => 'Código o nombre';

  @override
  String get palettePickerEmpty => 'Ningún rotulador coincide con tu búsqueda.';

  @override
  String get paletteUndoButton => 'Deshacer';

  @override
  String paletteBaseReplaced(String code) {
    return '$code es ahora la base. Se ha sustituido la paleta anterior.';
  }

  @override
  String paletteIdeaApplied(String title, int count) {
    return 'Paleta de «$title» aplicada ($count rotuladores).';
  }

  @override
  String get swatchesTitle => 'Muestras';

  @override
  String get swatchesSearchHint => 'Código, nombre o hex';

  @override
  String get swatchesClearSearch => 'Borrar la búsqueda';

  @override
  String get swatchesAllFilter => 'Todos';

  @override
  String get swatchesFavoritesOnly => 'Favoritos';

  @override
  String get swatchesOwnedOnly => 'Los míos';

  @override
  String get swatchesFilters => 'Filtros';

  @override
  String get swatchesFiltersTitle => 'Filtros';

  @override
  String get swatchesLabelPack => 'Set';

  @override
  String get swatchesLabelLayout => 'Vista';

  @override
  String get swatchesAllPacks => 'Todos los sets';

  @override
  String get swatchesClearFilters => 'Quitar filtros';

  @override
  String get swatchesLoadingSemantics => 'Cargando colores';

  @override
  String get swatchesClosestAlternatives => 'Alternativas cercanas';

  @override
  String get swatchesDeltaEUnit => 'ΔE 76';

  @override
  String get swatchesInPacks => 'En sets';

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
      'Aún no has añadido rotuladores. Dile a la app qué sets y rotuladores tienes.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Configurar mi colección';

  @override
  String get swatchesEmptyNoOwnedHint => 'Abre Ajustes y luego Mi colección.';

  @override
  String get swatchesEmptySearchTitle => 'No hay colores';

  @override
  String get swatchesEmptySearchBody =>
      'Ningún color de esta colección coincide con tu búsqueda.';

  @override
  String get swatchesEmptyFiltersTitle => 'Nada que mostrar';

  @override
  String get swatchesEmptyFiltersBody =>
      'Esta marca no tiene colores para los sets y filtros seleccionados.';

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
  String get ideasHeaderSubtitle =>
      'Ejercicios para tus rotuladores, con la paleta sacada de tu colección';

  @override
  String get ideasHeaderSubtitleWholeRange =>
      'Ejercicios con la paleta sacada de toda la gama';

  @override
  String get ideasSearchHint => 'Buscar ideas';

  @override
  String get ideasCategoryAll => 'Todas';

  @override
  String get ideasApplyButton => 'Usar en Paleta';

  @override
  String get ideasGuideOnlyNote =>
      'Este ejercicio usa toda tu colección, así que no tiene una paleta fija.';

  @override
  String get ideasNoMarkersDecoTime =>
      'Añade en Mi colección los rotuladores DecoTime que tienes para ver una paleta para esta idea.';

  @override
  String get ideasNoMarkersOther =>
      'Añade en Mi colección los rotuladores que tienes para ver una paleta para esta idea.';

  @override
  String get ideasCategoriesLabel => 'Categorías';

  @override
  String get ideasEmptyTitle => 'No hay ideas';

  @override
  String get ideasClearFilters => 'Quitar filtros';

  @override
  String get ideasEmptySearch => 'Ninguna idea coincide con tu búsqueda.';

  @override
  String get ideasNoMarkers => 'Ahora mismo no hay rotuladores disponibles';

  @override
  String get ideasCategoryTechnique => 'Técnicas';

  @override
  String get ideasCategoryColorChallenge => 'Retos de color';

  @override
  String get ideasCategoryMood => 'Ambientes';

  @override
  String get ideasCategorySeason => 'Temporadas';

  @override
  String get ideasDifficultyEasy => 'Fácil';

  @override
  String get ideasDifficultyMedium => 'Media';

  @override
  String get ideasDifficultyHard => 'Difícil';

  @override
  String get ideasFeaturedLabel => 'Idea del día';

  @override
  String get ideasOpenButton => 'Ver pasos';

  @override
  String get ideasOtherMarkersButton => 'Otros rotuladores';

  @override
  String get ideasPracticeTitle => 'Qué practicas';

  @override
  String get ideasSubjectTitle => 'Qué dibujar';

  @override
  String get ideasMarkersTitle => 'Tus rotuladores';

  @override
  String get ideasStepsTitle => 'Pasos';

  @override
  String get ideasTipTitle => 'Truco';

  @override
  String get ideasMaterialsTitle => 'Necesitas';

  @override
  String get ideasMaterialPaper => 'papel para rotuladores con una hoja debajo';

  @override
  String get ideasMaterialBlender => 'difuminador incoloro';

  @override
  String get ideasMaterialWhiteGel => 'bolígrafo de gel blanco';

  @override
  String get ideasMaterialPigmentLiner =>
      'rotulador calibrado negro de tinta pigmentada';

  @override
  String get ideasMaterialPencil => 'lápiz';

  @override
  String get ideasMaterialTape => 'cinta de carrocero';

  @override
  String get ideasBackLabel => 'Volver a las ideas';

  @override
  String ideasMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String ideasMissingMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A tu colección le faltan $count rotuladores para esta idea.',
      one: 'A tu colección le falta 1 rotulador para esta idea.',
    );
    return '$_temp0';
  }

  @override
  String ideasMarkerSemantic(String role, String code, String name) {
    return '$role: $code $name';
  }

  @override
  String get ideasSmoothFillTitle => 'Relleno sin rayas';

  @override
  String get ideasSmoothFillSummary =>
      'Rellena un cuadrado con un solo rotulador sin que se noten las rayas.';

  @override
  String get ideasSmoothFillPractice =>
      'Cubrir una zona de forma uniforme, la base de cualquier dibujo con rotuladores.';

  @override
  String get ideasSmoothFillSubject =>
      'Un cuadrado de 5 × 5 cm enmarcado con cinta de carrocero y después una forma plana sencilla, como una hoja.';

  @override
  String get ideasSmoothFillTip =>
      'Si el papel empieza a hacer bolitas, para: está saturado. Deja que se seque del todo antes de otra capa.';

  @override
  String get ideasSmoothFillStep1 =>
      'Marca con cinta un cuadrado de 5 × 5 cm en papel para rotuladores y pon una hoja debajo.';

  @override
  String get ideasSmoothFillStep2 =>
      'Rellena el cuadrado con el rotulador claro haciendo círculos pequeños que se solapen, sin pararte.';

  @override
  String get ideasSmoothFillStep3 =>
      'Trabaja siempre sobre tinta húmeda: vuelve a pasar por donde aún brilla, nunca por encima de lo seco.';

  @override
  String get ideasSmoothFillStep4 =>
      'Deja secar y da una segunda capa con el mismo rotulador, en perpendicular a la primera.';

  @override
  String get ideasSmoothFillStep5 =>
      'Repite el cuadrado con el rotulador más oscuro y compara: en los colores oscuros las rayas se notan más.';

  @override
  String get ideasSmoothFillStep6 =>
      'Despega la cinta despacio para dejar un borde limpio.';

  @override
  String get ideasThreeMarkerBlendTitle => 'Degradado con tres rotuladores';

  @override
  String get ideasThreeMarkerBlendSummary =>
      'Funde un rotulador claro, uno medio y uno oscuro de la misma familia en una pelota.';

  @override
  String get ideasThreeMarkerBlendPractice =>
      'Degradar de claro a oscuro sin cortes dentro de una familia de color.';

  @override
  String get ideasThreeMarkerBlendSubject =>
      'Una pelota iluminada desde arriba a la izquierda, con su sombra sobre la mesa.';

  @override
  String get ideasThreeMarkerBlendTip =>
      'Elige rotuladores de tonos cercanos: si el salto entre ellos es muy grande, se verá una línea.';

  @override
  String get ideasThreeMarkerBlendStep1 =>
      'Dibuja un círculo con el lápiz muy suave y marca de dónde viene la luz.';

  @override
  String get ideasThreeMarkerBlendStep2 =>
      'Cubre toda la pelota con el rotulador claro, dejando un punto de papel blanco para el brillo.';

  @override
  String get ideasThreeMarkerBlendStep3 =>
      'Mientras sigue húmedo, añade el rotulador medio en la mitad de la sombra, con trazos curvos que sigan la forma.';

  @override
  String get ideasThreeMarkerBlendStep4 =>
      'Añade el rotulador oscuro solo junto al borde más alejado de la luz.';

  @override
  String get ideasThreeMarkerBlendStep5 =>
      'Vuelve a pasar el medio y luego el claro por las uniones para fundir los saltos.';

  @override
  String get ideasThreeMarkerBlendStep6 =>
      'Suaviza con el difuminador incoloro cualquier borde duro alrededor del brillo.';

  @override
  String get ideasFlickingTitle => 'Trazos rápidos (flicking)';

  @override
  String get ideasFlickingSummary =>
      'Dibuja pelo o hierba con trazos rápidos que se desvanecen al final.';

  @override
  String get ideasFlickingPractice =>
      'El flicking: trazos rápidos que se afinan, para fundir sin bordes duros.';

  @override
  String get ideasFlickingSubject => 'Una coleta o una mata de hierba.';

  @override
  String get ideasFlickingTip =>
      'Prueba antes en un papel aparte: cuanto más rápido vas, más fina queda la cola del trazo.';

  @override
  String get ideasFlickingStep1 =>
      'Dibuja a lápiz los mechones o briznas principales como formas sencillas, sin detalle.';

  @override
  String get ideasFlickingStep2 =>
      'Cubre cada forma con el rotulador claro en una capa plana y deja secar.';

  @override
  String get ideasFlickingStep3 =>
      'Haz trazos rápidos con el rotulador medio desde la raíz hacia fuera: apoya, mueve rápido y levanta antes de acabar.';

  @override
  String get ideasFlickingStep4 =>
      'Haz lo mismo con el oscuro, solo desde la raíz y más corto, donde se solapan los mechones.';

  @override
  String get ideasFlickingStep5 =>
      'Con el claro, haz trazos desde las puntas hacia la raíz para suavizar el paso entre tonos.';

  @override
  String get ideasFlickingStep6 =>
      'Deja una franja con la primera capa donde el pelo recibe la luz.';

  @override
  String get ideasGrayscaleTitle => 'Escalera de grises';

  @override
  String get ideasGrayscaleSummary =>
      'Dibuja un objeto sencillo con una sola familia de grises para ver cómo la luz y la sombra crean volumen.';

  @override
  String get ideasGrayscalePractice =>
      'Ver la luz y la sombra como escalones de claro a oscuro.';

  @override
  String get ideasGrayscaleSubject =>
      'Una taza, una manzana o un huevo bajo una sola lámpara.';

  @override
  String get ideasGrayscaleTip =>
      'No mezcles grises cálidos y fríos en el mismo objeto: elige una sola familia.';

  @override
  String get ideasGrayscaleStep1 =>
      'Elige un objeto sencillo y marca a lápiz de dónde viene la luz.';

  @override
  String get ideasGrayscaleStep2 =>
      'Deja el brillo con el blanco del papel. No pintes nunca encima.';

  @override
  String get ideasGrayscaleStep3 =>
      'Cubre todo el objeto con el gris más claro y deja que se seque.';

  @override
  String get ideasGrayscaleStep4 =>
      'Añade el siguiente gris en el lado de la sombra y funde el borde mientras aún está húmedo.';

  @override
  String get ideasGrayscaleStep5 =>
      'Repite con cada gris más oscuro, cubriendo cada vez una zona más pequeña.';

  @override
  String get ideasGrayscaleStep6 =>
      'Usa el gris más oscuro solo para la sombra proyectada y la línea de contacto bajo el objeto.';

  @override
  String get ideasStickerEffectTitle => 'Efecto pegatina';

  @override
  String get ideasStickerEffectSummary =>
      'Haz que un personaje parezca una pegatina recortada, con un borde de papel blanco y un fondo de color.';

  @override
  String get ideasStickerEffectPractice =>
      'Reservar el blanco del papel a propósito.';

  @override
  String get ideasStickerEffectSubject =>
      'Un gato, una porción de pizza o una estrella de dibujos animados.';

  @override
  String get ideasStickerEffectTip =>
      'El blanco tiene que ser el del papel. El gel blanco encima de la tinta queda a parches.';

  @override
  String get ideasStickerEffectStep1 =>
      'Dibuja el motivo y, a lápiz, un segundo contorno a 3–5 mm por fuera: será el borde de la pegatina.';

  @override
  String get ideasStickerEffectStep2 =>
      'Colorea el motivo de claro a oscuro sin tocar el borde.';

  @override
  String get ideasStickerEffectStep3 =>
      'Colorea el fondo alrededor del borde con un color plano, para que se vea el blanco.';

  @override
  String get ideasStickerEffectStep4 =>
      'Cuando esté seco, repasa el exterior del borde con un rotulador calibrado o de punta pincel negro.';

  @override
  String get ideasStickerEffectStep5 =>
      'Añade una sombra gris en un lado del borde para que la pegatina se despegue de la página.';

  @override
  String get ideasGlossyCherriesTitle => 'Cerezas brillantes';

  @override
  String get ideasGlossyCherriesSummary =>
      'Haz que dos cerezas brillen con un brillo reservado y una luz reflejada.';

  @override
  String get ideasGlossyCherriesPractice =>
      'Brillos con borde nítido y luz reflejada, las claves de una superficie brillante.';

  @override
  String get ideasGlossyCherriesSubject =>
      'Dos cerezas con su rabito, iluminadas desde un lado.';

  @override
  String get ideasGlossyCherriesTip =>
      'Una superficie brillante tiene brillos de borde duro: no los difumines, deja el contorno nítido.';

  @override
  String get ideasGlossyCherriesStep1 =>
      'Dibuja a lápiz las cerezas y la forma de cada brillo: una mancha alargada y nítida cerca de la parte de arriba.';

  @override
  String get ideasGlossyCherriesStep2 =>
      'Cubre cada cereza con el rotulador claro, rodeando los brillos para que queden con el blanco del papel.';

  @override
  String get ideasGlossyCherriesStep3 =>
      'Pon la base en todo menos en una media luna fina junto al borde de abajo: es la luz reflejada.';

  @override
  String get ideasGlossyCherriesStep4 =>
      'Pon la sombra en el lado contrario a la luz y fúndela con la base mientras sigue húmeda.';

  @override
  String get ideasGlossyCherriesStep5 =>
      'Añade el rotulador más oscuro en una franja estrecha entre la sombra y la luz reflejada.';

  @override
  String get ideasGlossyCherriesStep6 =>
      'Dibuja con el gris la sombra sobre la mesa y, cuando esté seco, añade un punto de gel blanco en cada brillo.';

  @override
  String get ideasColoredShadowsTitle => 'Sombras de color';

  @override
  String get ideasColoredShadowsSummary =>
      'Sombrea dos veces el mismo limón, una con gris y otra con violeta, y compáralos.';

  @override
  String get ideasColoredShadowsPractice =>
      'Elegir colores de sombra que mantengan vivo el dibujo.';

  @override
  String get ideasColoredShadowsSubject =>
      'Dos limones juntos sobre una mesa blanca.';

  @override
  String get ideasColoredShadowsTip =>
      'La sombra suele tirar al color opuesto de la luz: violeta bajo el amarillo, azul bajo el naranja.';

  @override
  String get ideasColoredShadowsStep1 =>
      'Dibuja dos limones iguales, uno al lado del otro, con la luz llegando por el mismo lado.';

  @override
  String get ideasColoredShadowsStep2 =>
      'Colorea los dos con el amarillo, dejando un pequeño brillo con el blanco del papel.';

  @override
  String get ideasColoredShadowsStep3 =>
      'En el primero, sombrea con el gris el lado oscuro y la sombra sobre la mesa.';

  @override
  String get ideasColoredShadowsStep4 =>
      'En el segundo, haz lo mismo con el violeta, con suavidad: basta con una capa.';

  @override
  String get ideasColoredShadowsStep5 =>
      'Pasa el amarillo por el borde de la segunda sombra para fundirla.';

  @override
  String get ideasColoredShadowsStep6 =>
      'Míralos de lejos: la sombra violeta se ve más luminosa y natural junto al amarillo.';

  @override
  String get ideasStainedGlassTitle => 'Vidriera';

  @override
  String get ideasStainedGlassSummary =>
      'Colorea los cristales con degradados sencillos y añade el emplomado al final.';

  @override
  String get ideasStainedGlassPractice =>
      'Degradados limpios en zonas pequeñas; las líneas negras disimulan los bordes irregulares.';

  @override
  String get ideasStainedGlassSubject =>
      'Un rosetón con una flor o un sol en el centro.';

  @override
  String get ideasStainedGlassTip =>
      'Si dibujas las líneas negras primero, usa tinta pigmentada resistente al alcohol: la tinta normal se corre con el rotulador.';

  @override
  String get ideasStainedGlassStep1 =>
      'Dibuja a lápiz la ventana y divídela en cristales de distintos tamaños.';

  @override
  String get ideasStainedGlassStep2 =>
      'Colorea primero los cristales del color principal, cada uno degradado: más oscuro en un borde y más claro en el centro.';

  @override
  String get ideasStainedGlassStep3 =>
      'Haz lo mismo con el segundo y el tercer color, dejando secar cada cristal antes de pintar el de al lado.';

  @override
  String get ideasStainedGlassStep4 =>
      'Usa el acento solo en unos pocos cristales pequeños para que destaquen.';

  @override
  String get ideasStainedGlassStep5 =>
      'Cuando todo esté seco, repasa los bordes con líneas gruesas de rotulador calibrado o de punta pincel negro.';

  @override
  String get ideasStainedGlassStep6 =>
      'Añade un pequeño trazo de gel blanco en algunos cristales para sugerir el brillo del vidrio.';

  @override
  String get ideasSwatchChartTitle => 'Tu carta de colores';

  @override
  String get ideasSwatchChartSummary =>
      'Comprueba cómo queda cada rotulador con una, dos y tres capas.';

  @override
  String get ideasSwatchChartPractice =>
      'Saber cómo quedan de verdad tus rotuladores en el papel, no en el capuchón.';

  @override
  String get ideasSwatchChartSubject =>
      'Una cuadrícula con una fila por rotulador, agrupada por familias de color.';

  @override
  String get ideasSwatchChartTip =>
      'Haz la carta en el papel que usas de verdad: el mismo rotulador cambia mucho de un papel a otro.';

  @override
  String get ideasSwatchChartStep1 =>
      'Dibuja una cuadrícula en el papel que sueles usar: una fila por rotulador y cuatro casillas por fila.';

  @override
  String get ideasSwatchChartStep2 =>
      'Rellena la primera casilla con una capa, la segunda con dos y la tercera con tres, dejando secar entre capas.';

  @override
  String get ideasSwatchChartStep3 =>
      'En la cuarta, da una capa y levanta parte de la tinta con el difuminador incoloro.';

  @override
  String get ideasSwatchChartStep4 =>
      'Escribe el código debajo de cada fila a lápiz o con un rotulador calibrado.';

  @override
  String get ideasSwatchChartStep5 =>
      'Usa la pestaña Muestras para marcar los rotuladores que tienes y compáralos con tu carta.';

  @override
  String get ideasOneColorTitle => 'Una sola familia de color';

  @override
  String get ideasOneColorSummary =>
      'Dibuja una escena entera con cuatro rotuladores de la misma familia de color.';

  @override
  String get ideasOneColorPractice =>
      'Dar profundidad superponiendo capas y eligiendo rotuladores más claros y más oscuros.';

  @override
  String get ideasOneColorSubject =>
      'Una taza de té humeante o una planta pequeña en su maceta.';

  @override
  String get ideasOneColorTip =>
      'Apretar menos no aclara el color. Para las zonas claras usa el rotulador más claro o el difuminador incoloro.';

  @override
  String get ideasOneColorStep1 =>
      'Elige un motivo sencillo y marca a lápiz de dónde viene la luz.';

  @override
  String get ideasOneColorStep2 =>
      'Cubre todo menos los brillos con el rotulador más claro.';

  @override
  String get ideasOneColorStep3 =>
      'Añade el rotulador base en las zonas que no miran a la luz.';

  @override
  String get ideasOneColorStep4 =>
      'Pon el de sombra en las partes más oscuras y funde los bordes mientras siguen húmedos.';

  @override
  String get ideasOneColorStep5 =>
      'Reserva el más oscuro para las sombras de contacto y algún detalle pequeño.';

  @override
  String get ideasOneColorStep6 =>
      'Para oscurecer un tono sin cambiar de rotulador, da otra capa del mismo cuando la primera esté seca.';

  @override
  String get ideasTwoMarkersTitle => 'Reto de dos rotuladores';

  @override
  String get ideasTwoMarkersSummary =>
      'Solo un rotulador claro y uno oscuro, nada más.';

  @override
  String get ideasTwoMarkersPractice =>
      'Decidir antes de empezar qué queda claro y qué va oscuro.';

  @override
  String get ideasTwoMarkersSubject =>
      'Una seta, un gato sentado o una casa con tejado.';

  @override
  String get ideasTwoMarkersTip =>
      'Con solo dos rotuladores, el blanco del papel trabaja mucho: planéalo desde el principio.';

  @override
  String get ideasTwoMarkersStep1 =>
      'Haz primero un boceto pequeño y decide qué zonas van claras y cuáles oscuras.';

  @override
  String get ideasTwoMarkersStep2 =>
      'Cubre todo menos los brillos con el rotulador claro.';

  @override
  String get ideasTwoMarkersStep3 =>
      'Da una segunda capa del claro en las medias sombras.';

  @override
  String get ideasTwoMarkersStep4 =>
      'Usa el oscuro solo para las sombras más profundas y algún detalle.';

  @override
  String get ideasTwoMarkersStep5 =>
      'Deja el blanco del papel en los puntos de más luz: es tu tercer tono.';

  @override
  String get ideasTwoColorsTitle => 'Dos colores opuestos';

  @override
  String get ideasTwoColorsSummary =>
      'Usa dos colores opuestos y un gris, y mantenlos separados.';

  @override
  String get ideasTwoColorsPractice =>
      'Controlar los colores opuestos, que se ensucian cuando se mezclan.';

  @override
  String get ideasTwoColorsSubject =>
      'Una naranja sobre un mantel azul o una flor roja con hojas verdes.';

  @override
  String get ideasTwoColorsTip =>
      'Dos colores opuestos superpuestos se vuelven grises o marrones. Úsalo solo donde quieras una sombra apagada.';

  @override
  String get ideasTwoColorsStep1 =>
      'Decide qué zonas van de cada color y mantenlas en formas separadas.';

  @override
  String get ideasTwoColorsStep2 =>
      'Colorea las formas del primer color, de claro a oscuro.';

  @override
  String get ideasTwoColorsStep3 =>
      'Añade su sombra mientras la primera capa sigue húmeda.';

  @override
  String get ideasTwoColorsStep4 =>
      'Deja que se seque del todo y colorea las formas del segundo color, parando en el borde.';

  @override
  String get ideasTwoColorsStep5 =>
      'Añade la sombra del segundo color de la misma manera.';

  @override
  String get ideasTwoColorsStep6 =>
      'Usa el gris para las sombras que pasan de un color al otro.';

  @override
  String get ideasFiftyFiftyTitle => 'Mitad cálida, mitad fría';

  @override
  String get ideasFiftyFiftySummary =>
      'Divide un dibujo en dos: colores cálidos a un lado y fríos al otro.';

  @override
  String get ideasFiftyFiftyPractice =>
      'Notar cómo los colores cálidos y fríos cambian el ambiente del mismo motivo.';

  @override
  String get ideasFiftyFiftySubject =>
      'Una cara o una casa partida por la mitad.';

  @override
  String get ideasFiftyFiftyTip =>
      'Los bordes húmedos se corren entre sí: no dejes que una zona cálida húmeda toque una fría húmeda.';

  @override
  String get ideasFiftyFiftyStep1 =>
      'Dibuja el motivo y una línea que lo divida en dos.';

  @override
  String get ideasFiftyFiftyStep2 =>
      'Colorea primero la mitad cálida, de claro a oscuro.';

  @override
  String get ideasFiftyFiftyStep3 =>
      'Añade sus sombras y deja que esa mitad se seque del todo.';

  @override
  String get ideasFiftyFiftyStep4 =>
      'Colorea la mitad fría parando a un milímetro de la línea y cierra el hueco cuando el otro lado esté seco.';

  @override
  String get ideasFiftyFiftyStep5 =>
      'Añade las sombras frías en los mismos sitios que en la mitad cálida.';

  @override
  String get ideasFiftyFiftyStep6 =>
      'Usa el gris solo en los puntos más oscuros, para que lo compartan las dos mitades.';

  @override
  String get ideasRandomColorsTitle => 'Cinco rotuladores al azar';

  @override
  String get ideasRandomColorsSummary =>
      'Dibuja lo que quieras con cinco rotuladores elegidos al azar de tu colección.';

  @override
  String get ideasRandomColorsPractice =>
      'Hacer que cualquier color funcione controlando los claros y los oscuros.';

  @override
  String get ideasRandomColorsSubject =>
      'Lo que quieras: un pájaro, una tetera o un monstruo.';

  @override
  String get ideasRandomColorsTip =>
      'Lo claro y lo oscuro importan más que el color: un dibujo con buen contraste funciona casi con cualquier color.';

  @override
  String get ideasRandomColorsStep1 =>
      'Mira los cinco rotuladores de arriba: están ordenados del más claro al más oscuro.';

  @override
  String get ideasRandomColorsStep2 =>
      'Usa el más claro para las zonas grandes iluminadas.';

  @override
  String get ideasRandomColorsStep3 =>
      'Usa los intermedios para las formas principales.';

  @override
  String get ideasRandomColorsStep4 =>
      'Guarda el más oscuro para las sombras y los contornos.';

  @override
  String get ideasRandomColorsStep5 =>
      'Si dos colores chocan, sepáralos con una línea fina de papel blanco.';

  @override
  String get ideasRandomColorsStep6 =>
      'Pulsa Otros rotuladores para sacar otra combinación y vuelve a probar.';

  @override
  String get ideasUnlikelyColorsTitle => 'Colores inesperados';

  @override
  String get ideasUnlikelyColorsSummary =>
      'Colorea un objeto conocido con colores que no son los suyos.';

  @override
  String get ideasUnlikelyColorsPractice =>
      'Respetar los claros y oscuros para que el objeto se reconozca, sea del color que sea.';

  @override
  String get ideasUnlikelyColorsSubject =>
      'Un plátano, un perro o tu propia zapatilla.';

  @override
  String get ideasUnlikelyColorsTip =>
      'Si entrecierras los ojos y el dibujo se entiende, los claros y oscuros están bien, sean del color que sean.';

  @override
  String get ideasUnlikelyColorsStep1 =>
      'Dibuja el objeto del natural o de una foto y fíjate en dónde están sus zonas claras y oscuras.';

  @override
  String get ideasUnlikelyColorsStep2 =>
      'Usa el rotulador más claro donde el objeto real es más claro.';

  @override
  String get ideasUnlikelyColorsStep3 =>
      'Usa la base donde el objeto real tiene sus tonos medios.';

  @override
  String get ideasUnlikelyColorsStep4 =>
      'Usa el de sombra donde el objeto real es más oscuro.';

  @override
  String get ideasUnlikelyColorsStep5 =>
      'Añade el acento en una zona pequeña para atraer la mirada.';

  @override
  String get ideasPastelTitle => 'Tonos pastel';

  @override
  String get ideasPastelSummary =>
      'Colorea un dibujo suave y luminoso con rotuladores claros y mucho blanco del papel.';

  @override
  String get ideasPastelPractice =>
      'Capas claras y uniformes, y reservar el blanco del papel.';

  @override
  String get ideasPastelSubject =>
      'Una magdalena, un conejito o un ramo de flores.';

  @override
  String get ideasPastelTip =>
      'Apretar menos no aclara el color: elige un rotulador más claro.';

  @override
  String get ideasPastelStep1 =>
      'Elige un motivo amable y deja las líneas de lápiz muy suaves.';

  @override
  String get ideasPastelStep2 =>
      'Decide dónde se queda blanco el papel: los brillos y parte del fondo.';

  @override
  String get ideasPastelStep3 =>
      'Colorea cada zona con un rotulador claro en una sola capa uniforme, con círculos pequeños.';

  @override
  String get ideasPastelStep4 =>
      'Haz la sombra con una segunda capa del mismo rotulador, no con un color más oscuro.';

  @override
  String get ideasPastelStep5 =>
      'Usa el rotulador algo más intenso solo para las sombras más pequeñas.';

  @override
  String get ideasPastelStep6 =>
      'Suaviza los bordes duros con el difuminador incoloro.';

  @override
  String get ideasSkinTonesTitle => 'Piel con cuatro rotuladores';

  @override
  String get ideasSkinTonesSummary =>
      'Colorea una cara con un tono claro, una base, una sombra y un colorete.';

  @override
  String get ideasSkinTonesPractice =>
      'Fundir la piel con suavidad y usar sombras cálidas en una cara.';

  @override
  String get ideasSkinTonesSubject =>
      'Una cara de tres cuartos, iluminada desde un lado.';

  @override
  String get ideasSkinTonesTip =>
      'Las sombras de la piel son cálidas: evita los grises, ensucian la cara.';

  @override
  String get ideasSkinTonesStep1 =>
      'Dibuja la cara con trazo suave y marca las formas de sombra: bajo la ceja, junto a la nariz, bajo el labio y en la mandíbula.';

  @override
  String get ideasSkinTonesStep2 =>
      'Cubre toda la piel con el rotulador claro y deja con el blanco del papel los puntos de más luz de la frente, la nariz y la mejilla.';

  @override
  String get ideasSkinTonesStep3 =>
      'Mientras está húmedo, añade el colorete en las mejillas, la punta de la nariz y las orejas.';

  @override
  String get ideasSkinTonesStep4 =>
      'Pon la base en las formas de sombra y funde sus bordes con el rotulador claro.';

  @override
  String get ideasSkinTonesStep5 =>
      'Usa el de sombra solo donde se juntan las formas: bajo la barbilla, dentro de la oreja y en las aletas de la nariz.';

  @override
  String get ideasSkinTonesStep6 =>
      'Suaviza cualquier línea dura con el rotulador claro y no con el difuminador incoloro, para que la piel no quede a manchas.';

  @override
  String get ideasMidnightTitle => 'Noche de luna';

  @override
  String get ideasMidnightSummary =>
      'Una casita de noche, iluminada por la luna y una ventana cálida.';

  @override
  String get ideasMidnightPractice =>
      'Planificar una escena nocturna: sombras frías y unas pocas luces cálidas y limpias.';

  @override
  String get ideasMidnightSubject =>
      'Una casita de noche con una ventana encendida.';

  @override
  String get ideasMidnightTip =>
      'No dejes que el azul y el amarillo se toquen mientras alguno esté húmedo: juntos se vuelven verdes.';

  @override
  String get ideasMidnightStep1 =>
      'Antes de empezar, decide dónde están las luces: la luna y la ventana se quedan con el blanco del papel.';

  @override
  String get ideasMidnightStep2 =>
      'Colorea la ventana y un halo suave alrededor con el amarillo, y deja que se seque del todo.';

  @override
  String get ideasMidnightStep3 =>
      'Cubre el cielo y las paredes iluminadas con el azul claro, alejándote de la luna.';

  @override
  String get ideasMidnightStep4 =>
      'Añade el azul base en todo lo que está en sombra, a unos milímetros del halo amarillo.';

  @override
  String get ideasMidnightStep5 =>
      'Oscurece el cielo hacia arriba y las sombras bajo el tejado y los árboles.';

  @override
  String get ideasMidnightStep6 =>
      'Usa el más oscuro para las sombras más profundas y, cuando esté seco, añade unas estrellas con gel blanco.';

  @override
  String get ideasUnderwaterTitle => 'Bajo el mar';

  @override
  String get ideasUnderwaterSummary =>
      'Rayos de sol en el agua azul alrededor de un pececillo.';

  @override
  String get ideasUnderwaterPractice =>
      'Abrir rayos de luz con el difuminador incoloro.';

  @override
  String get ideasUnderwaterSubject => 'Un pez pequeño nadando sobre un coral.';

  @override
  String get ideasUnderwaterTip =>
      'Prueba antes los rayos en un papel aparte: solo funcionan mientras la tinta sigue algo húmeda.';

  @override
  String get ideasUnderwaterStep1 =>
      'Colorea primero el pez y el coral con el acento y deja que se sequen.';

  @override
  String get ideasUnderwaterStep2 =>
      'Cubre el agua con el azul claro, parando justo antes del pez.';

  @override
  String get ideasUnderwaterStep3 =>
      'Añade el azul base en la mitad de abajo y fúndelo hacia arriba mientras está húmedo.';

  @override
  String get ideasUnderwaterStep4 =>
      'Oscurece el fondo y la zona detrás del pez para que destaque.';

  @override
  String get ideasUnderwaterStep5 =>
      'Con los azules aún húmedos, abre rayos en diagonal desde la superficie con el difuminador incoloro: empuja la tinta.';

  @override
  String get ideasUnderwaterStep6 =>
      'Añade el más oscuro en el fondo del todo y, cuando esté seco, termina con burbujitas de gel blanco.';

  @override
  String get ideasGalaxyTitle => 'Galaxia';

  @override
  String get ideasGalaxySummary =>
      'Funde los colores luminosos de una nebulosa en un cielo oscuro y termina con estrellas.';

  @override
  String get ideasGalaxyPractice =>
      'Fundir en húmedo y levantar tinta para hacer estrellas.';

  @override
  String get ideasGalaxySubject =>
      'Una nebulosa sobre la silueta de una montaña.';

  @override
  String get ideasGalaxyTip =>
      'Pon pocas estrellas grandes: si hay demasiadas, se pierde la profundidad.';

  @override
  String get ideasGalaxyStep1 =>
      'Usa papel para rotuladores que no traspase y pon una hoja debajo: este ejercicio lleva mucha tinta.';

  @override
  String get ideasGalaxyStep2 =>
      'Empieza por los colores más claros de la nebulosa, en nubes suaves e irregulares.';

  @override
  String get ideasGalaxyStep3 =>
      'Mientras siguen húmedos, funde el color medio en sus bordes.';

  @override
  String get ideasGalaxyStep4 =>
      'Rellena el resto del cielo con los rotuladores más oscuros, avanzando hacia las nubes, no por encima.';

  @override
  String get ideasGalaxyStep5 =>
      'Da toquecitos con el difuminador incoloro sobre lo oscuro para levantar puntos de tinta: serán estrellas lejanas.';

  @override
  String get ideasGalaxyStep6 =>
      'Cuando esté seco, añade unas pocas estrellas brillantes y un destello en cruz con gel blanco.';

  @override
  String get ideasNeonTitle => 'Cartel de neón';

  @override
  String get ideasNeonSummary =>
      'Haz que un cartel brille dejando un centro blanco y un fondo oscuro.';

  @override
  String get ideasNeonPractice =>
      'Hacer brillar: centro blanco, halo intenso y fondo oscuro.';

  @override
  String get ideasNeonSubject =>
      'La palabra ABIERTO o un corazón dibujado como un tubo de neón.';

  @override
  String get ideasNeonTip =>
      'Los rotuladores fluorescentes son transparentes: úsalos sobre blanco, nunca encima de tinta oscura.';

  @override
  String get ideasNeonStep1 =>
      'Dibuja a lápiz una palabra o forma sencilla con trazos gruesos.';

  @override
  String get ideasNeonStep2 =>
      'Deja una línea fina de papel blanco en el centro de cada trazo: es el núcleo de luz.';

  @override
  String get ideasNeonStep3 =>
      'Colorea el resto del trazo con la versión clara de tu color neón.';

  @override
  String get ideasNeonStep4 =>
      'Haz trazos rápidos hacia fuera con el color intenso para crear un halo suave.';

  @override
  String get ideasNeonStep5 =>
      'Cuando el halo esté seco, rellena el fondo con el rotulador más oscuro, parando a unos milímetros del halo.';

  @override
  String get ideasNeonStep6 =>
      'Funde ese hueco con el rotulador oscuro para que el brillo se apague en la noche.';

  @override
  String get ideasSepiaPhotoTitle => 'Foto antigua en sepia';

  @override
  String get ideasSepiaPhotoSummary =>
      'Dibuja un retrato o un edificio como si fuera una foto antigua en tonos marrones.';

  @override
  String get ideasSepiaPhotoPractice =>
      'Trabajar con una sola familia cálida de marrones, como un estudio de claros y oscuros en color.';

  @override
  String get ideasSepiaPhotoSubject =>
      'Una casa antigua, un sombrero de vaquero o el retrato de un abuelo.';

  @override
  String get ideasSepiaPhotoTip =>
      'Evita el negro y los grises fríos: rompen el aire cálido de la foto en sepia.';

  @override
  String get ideasSepiaPhotoStep1 =>
      'Dibuja el motivo a lápiz y enmárcalo con un borde que se quede con el blanco del papel.';

  @override
  String get ideasSepiaPhotoStep2 =>
      'Cubre todo menos los puntos de más luz con el marrón más claro.';

  @override
  String get ideasSepiaPhotoStep3 =>
      'Construye los tonos medios con el marrón base.';

  @override
  String get ideasSepiaPhotoStep4 =>
      'Añade las sombras con el marrón de sombra, fundiendo los bordes mientras siguen húmedos.';

  @override
  String get ideasSepiaPhotoStep5 =>
      'Usa el marrón más oscuro en lugar del negro para las sombras más profundas.';

  @override
  String get ideasSepiaPhotoStep6 =>
      'Oscurece un poco las esquinas de la imagen con el gris cálido para envejecerla.';

  @override
  String get ideasSunsetTitle => 'Cielo de atardecer';

  @override
  String get ideasSunsetSummary =>
      'Funde un cielo del amarillo al violeta y añade una silueta oscura.';

  @override
  String get ideasSunsetPractice =>
      'Fundir en húmedo colores vecinos en una zona grande.';

  @override
  String get ideasSunsetSubject =>
      'Una puesta de sol sobre el mar con una palmera o los edificios de una ciudad a contraluz.';

  @override
  String get ideasSunsetTip =>
      'Funde solo colores vecinos: el amarillo junto al violeta se vuelve marrón en húmedo.';

  @override
  String get ideasSunsetStep1 =>
      'Dibuja a lápiz el horizonte y la silueta; deja el sol como un círculo de papel blanco.';

  @override
  String get ideasSunsetStep2 =>
      'Empieza por el sol: colorea una franja ancha de amarillo a su alrededor.';

  @override
  String get ideasSunsetStep3 =>
      'Con el amarillo aún húmedo, añade el naranja encima y funde la unión.';

  @override
  String get ideasSunsetStep4 =>
      'Sigue hacia arriba con el rosa, fundiendo cada franja con la anterior mientras está húmeda.';

  @override
  String get ideasSunsetStep5 =>
      'Termina la parte de arriba del cielo con el violeta.';

  @override
  String get ideasSunsetStep6 =>
      'Cuando el cielo esté seco, rellena la silueta con el rotulador más oscuro con trazos planos y uniformes.';

  @override
  String get ideasSpringTitle => 'Flor de cerezo';

  @override
  String get ideasSpringSummary =>
      'Una rama de cerezo en flor con pétalos de un rosa suave.';

  @override
  String get ideasSpringPractice =>
      'Pétalos delicados: capas claras y bordes suaves.';

  @override
  String get ideasSpringSubject =>
      'Una rama con cinco o seis flores y unas pocas hojas.';

  @override
  String get ideasSpringTip =>
      'Los pétalos son finos: dos capas claras quedan más delicadas que una oscura.';

  @override
  String get ideasSpringStep1 =>
      'Dibuja la rama y las flores con trazo suave, de cinco pétalos cada una.';

  @override
  String get ideasSpringStep2 =>
      'Colorea cada pétalo con el rosa claro, dejando un borde fino de papel blanco en algunos.';

  @override
  String get ideasSpringStep3 =>
      'Añade el rosa base cerca del centro de cada flor, con trazos rápidos hacia fuera.';

  @override
  String get ideasSpringStep4 =>
      'Toca el rosa más intenso solo en el centro y donde se solapan los pétalos.';

  @override
  String get ideasSpringStep5 => 'Colorea las hojas y los brotes con el verde.';

  @override
  String get ideasSpringStep6 =>
      'Sombrea la parte de abajo de las hojas con el verde oscuro.';

  @override
  String get ideasAutumnTitle => 'Hojas de otoño';

  @override
  String get ideasAutumnSummary =>
      'Un bodegón de hojas caídas con colores cálidos y luminosos.';

  @override
  String get ideasAutumnPractice =>
      'Fundir colores cálidos vecinos y dejar los nervios claros.';

  @override
  String get ideasAutumnSubject =>
      'Tres hojas caídas sobre una mesa: de roble, de arce y de castaño.';

  @override
  String get ideasAutumnTip =>
      'Deja los nervios como una línea más clara: es más fácil que dibujarlos encima después.';

  @override
  String get ideasAutumnStep1 =>
      'Dibuja las hojas y sus nervios principales con lápiz suave.';

  @override
  String get ideasAutumnStep2 =>
      'Colorea la hoja más clara con el amarillo, rodeando los nervios para que queden claros.';

  @override
  String get ideasAutumnStep3 =>
      'Colorea la siguiente con el naranja claro y funde un poco de amarillo en los bordes mientras está húmeda.';

  @override
  String get ideasAutumnStep4 =>
      'Colorea la tercera con la base y funde el naranja claro en la punta.';

  @override
  String get ideasAutumnStep5 =>
      'Añade el rojo en los bordes y en algunas manchas, como si la hoja estuviera cambiando de color.';

  @override
  String get ideasAutumnStep6 =>
      'Sombrea con el naranja oscuro donde las hojas se solapan y donde tocan la mesa.';

  @override
  String get ideasWinterTitle => 'Cabaña nevada';

  @override
  String get ideasWinterSummary =>
      'Una cabaña en la nieve en la que el blanco es el propio papel.';

  @override
  String get ideasWinterPractice =>
      'Dibujar nieve con sombras gris azuladas y mucho papel en blanco.';

  @override
  String get ideasWinterSubject =>
      'Una cabaña de madera con nieve en el tejado y una ventana encendida.';

  @override
  String get ideasWinterTip =>
      'No sombrees la nieve con gris cálido: los grises azulados la hacen fría y limpia.';

  @override
  String get ideasWinterStep1 =>
      'Dibuja a lápiz la cabaña y dónde acaba la nieve: la nieve es el papel blanco, así que planéala primero.';

  @override
  String get ideasWinterStep2 =>
      'Colorea la ventana con el amarillo y deja que se seque.';

  @override
  String get ideasWinterStep3 =>
      'Colorea las paredes de madera con el marrón sin tocar la nieve del tejado.';

  @override
  String get ideasWinterStep4 =>
      'Sombrea la nieve con el gris azulado claro solo donde no llega la luz.';

  @override
  String get ideasWinterStep5 =>
      'Añade el gris azulado más oscuro bajo el tejado y en las huellas, fundiéndolo con el claro.';

  @override
  String get ideasWinterStep6 =>
      'Usa el más oscuro para la puerta y las sombras más profundas y, cuando esté seco, añade copos con gel blanco.';

  @override
  String get ideasChristmasTitle => 'Bolas de Navidad';

  @override
  String get ideasChristmasSummary =>
      'Bolas rojas brillantes colgando de una rama verde de abeto.';

  @override
  String get ideasChristmasPractice =>
      'Formas redondas y brillantes con un brillo reservado y reflejos.';

  @override
  String get ideasChristmasSubject =>
      'Dos bolas rojas colgadas de una rama de abeto.';

  @override
  String get ideasChristmasTip =>
      'Dibuja la rama después de las bolas, para que el verde no se meta en el rojo.';

  @override
  String get ideasChristmasStep1 =>
      'Dibuja las bolas y planea en cada una un brillo con forma de ventana.';

  @override
  String get ideasChristmasStep2 =>
      'Cubre cada bola con el rojo claro, rodeando el brillo.';

  @override
  String get ideasChristmasStep3 =>
      'Añade el rojo base en un anillo que siga la forma redonda, dejando el centro más claro.';

  @override
  String get ideasChristmasStep4 =>
      'Oscurece el borde más alejado de la luz y deja un filo fino más claro para el reflejo.';

  @override
  String get ideasChristmasStep5 =>
      'Haz las agujas de la rama con el verde, con trazos rápidos desde el tallo hacia fuera.';

  @override
  String get ideasChristmasStep6 =>
      'Añade el verde oscuro donde se solapan las agujas y, cuando esté seco, un destello de gel blanco en cada bola.';

  @override
  String get ideasHalloweenTitle => 'Calabaza de Halloween';

  @override
  String get ideasHalloweenSummary =>
      'Una calabaza tallada que brilla en una noche violeta oscura.';

  @override
  String get ideasHalloweenPractice =>
      'La luz que sale de dentro de un objeto, sobre un fondo oscuro.';

  @override
  String get ideasHalloweenSubject =>
      'Una calabaza tallada con una vela dentro, en la puerta de una casa.';

  @override
  String get ideasHalloweenTip =>
      'Pon el fondo oscuro al final y despacio cerca del borde: la tinta oscura se corre hacia las zonas claras.';

  @override
  String get ideasHalloweenStep1 =>
      'Dibuja la calabaza y su cara tallada; el interior de la cara será la parte más luminosa.';

  @override
  String get ideasHalloweenStep2 =>
      'Colorea los huecos tallados con el naranja claro, dejando un centro blanco.';

  @override
  String get ideasHalloweenStep3 =>
      'Colorea la calabaza con el naranja base, siguiendo los gajos con trazos curvos.';

  @override
  String get ideasHalloweenStep4 =>
      'Sombrea las hendiduras entre gajos y el lado más alejado del brillo.';

  @override
  String get ideasHalloweenStep5 => 'Colorea el tallo con el verde.';

  @override
  String get ideasHalloweenStep6 =>
      'Cuando todo esté seco, rellena la noche con el violeta oscuro, empezando a unos milímetros de la calabaza.';

  @override
  String get ideasRoleLight => 'Luz';

  @override
  String get ideasReasonLight => 'Primera capa, casi sobre todo';

  @override
  String get ideasRoleLightMid => 'Medio claro';

  @override
  String get ideasReasonLightMid =>
      'Segundo escalón, suaviza el paso a la base';

  @override
  String get ideasRoleBase => 'Base';

  @override
  String get ideasReasonBase => 'Color principal de las formas';

  @override
  String get ideasRoleShadow => 'Sombra';

  @override
  String get ideasReasonShadow => 'Donde no llega la luz';

  @override
  String get ideasRoleDeepShadow => 'Sombra profunda';

  @override
  String get ideasReasonDeepShadow =>
      'Solo los rincones más oscuros y las líneas de contacto';

  @override
  String get ideasRoleShadowGray => 'Gris de sombra';

  @override
  String get ideasReasonShadowGray => 'Sombras neutras y sombras proyectadas';

  @override
  String get ideasRoleAccent => 'Acento';

  @override
  String get ideasReasonAccent => 'Toques pequeños que atraen la mirada';

  @override
  String get ideasRoleBackground => 'Fondo';

  @override
  String get ideasReasonBackground => 'Alrededor del motivo, al final';

  @override
  String get ideasRoleMainColor => 'Color principal';

  @override
  String get ideasReasonMainColor => 'Primer color de la pareja';

  @override
  String get ideasRoleMainShadow => 'Sombra principal';

  @override
  String get ideasReasonMainShadow => 'Sombra del primer color';

  @override
  String get ideasRoleSecondColor => 'Segundo color';

  @override
  String get ideasReasonSecondColor => 'Segundo color del esquema';

  @override
  String get ideasRoleSecondShadow => 'Segunda sombra';

  @override
  String get ideasReasonSecondShadow => 'Sombra del segundo color';

  @override
  String get ideasRoleThirdColor => 'Tercer color';

  @override
  String get ideasReasonThirdColor => 'Tercer color del esquema';

  @override
  String get ideasRoleBlush => 'Colorete';

  @override
  String get ideasReasonBlush => 'Mejillas, nariz y orejas, fundido en húmedo';

  @override
  String get ideasRoleWarmLight => 'Luz cálida';

  @override
  String get ideasReasonWarmLight => 'Zonas iluminadas de la mitad cálida';

  @override
  String get ideasRoleWarmShadow => 'Sombra cálida';

  @override
  String get ideasReasonWarmShadow => 'Sombras de la mitad cálida';

  @override
  String get ideasRoleCoolLight => 'Luz fría';

  @override
  String get ideasReasonCoolLight => 'Zonas iluminadas de la mitad fría';

  @override
  String get ideasRoleCoolShadow => 'Sombra fría';

  @override
  String get ideasReasonCoolShadow => 'Sombras de la mitad fría';

  @override
  String get ideasRoleColorShadow => 'Sombra de color';

  @override
  String get ideasReasonColorShadow =>
      'Una sombra de color para comparar con la gris';

  @override
  String get matchTitle => 'Emparejar';

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
          '$input no es un código de rotulador de DecoTime. Prueba con $example.',
      'other':
          '$input no es un código de rotulador de Ink Lab. Prueba con $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input no está en tu colección. Prueba con $example o añádelo en Mi colección.',
      'other':
          '$input no está en tu colección. Prueba con $example o añádelo en Mi colección.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'Aún no hay rotuladores DecoTime en tu colección. Añádelos en Mi colección.',
      'other':
          'Aún no hay rotuladores en tu colección. Añádelos en Mi colección.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Elige un rotulador base, como $example, o una escena con el chip Escenas.';
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
    return 'La paleta de «$title» ya está en Paleta.';
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
  String get matchQualityExcellent => 'Casi exacto';

  @override
  String get matchQualityVeryClose => 'Muy cercano';

  @override
  String get matchQualityClose => 'Cercano';

  @override
  String get matchQualityFair => 'Aproximado';

  @override
  String get matchQualityApproximate => 'Lejano';

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
  String get swatchesLegacyPacks => 'Sets antiguos';

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

  @override
  String get settingsMatchingGroup => 'Emparejar colores';

  @override
  String get settingsMatchSuggestUnowned => 'Ver toda la gama';

  @override
  String get settingsMatchSuggestUnownedSubtitle =>
      'Si ninguno de tus rotuladores se parece, Emparejar muestra también el más cercano de toda la gama.';

  @override
  String get settingsSetupAgain => 'Repetir la configuración';

  @override
  String get matchNoCloseMatch => 'Ninguno de tus rotuladores se parece.';

  @override
  String matchRangeTitle(String brand) {
    return 'Toda la gama $brand';
  }

  @override
  String get matchNotOwnedBadge => 'No lo tienes';

  @override
  String get matchSubtitleEmpty => 'Aún no hay rotuladores en tu colección';

  @override
  String swatchesWholeRangeNotice(String brand) {
    return 'Viendo toda la gama de $brand';
  }

  @override
  String get swatchesWholeRangeAction => 'Configurar';

  @override
  String matchWholeRangeBody(String brand) {
    return 'Hasta que configures tu colección, comparamos con toda la gama de $brand.';
  }

  @override
  String get matchWholeRangeAction => 'Ir a Mi colección';

  @override
  String get collectionTitle => 'Mi colección';

  @override
  String collectionMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores',
      one: '1 rotulador',
      zero: 'Sin rotuladores',
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
  String get collectionNotSetUp => 'Sin configurar';

  @override
  String get collectionSeriesTitle => 'Series que tienes';

  @override
  String get collectionHonoluluNote =>
      'Honolulu B, Honolulu S y Honolulu² usan los mismos códigos de color que Honolulu; solo cambian las puntas.';

  @override
  String get collectionSetsTitle => 'Sets que tienes';

  @override
  String get collectionSetsEmpty => 'Elige una serie para ver sus sets.';

  @override
  String collectionOlderSets(int count) {
    return 'Sets antiguos ($count)';
  }

  @override
  String get collectionOlderSetsNote =>
      'Ediciones retiradas o regionales, según datos de la comunidad.';

  @override
  String get collectionExtrasTitle => 'Rotuladores sueltos';

  @override
  String get collectionExtrasHint =>
      '¿Compraste rotuladores sueltos? Márcalos aquí. Los de tus sets ya cuentan.';

  @override
  String get collectionDecoMarkersTitle => 'Tus rotuladores';

  @override
  String get collectionDecoHint =>
      'DecoTime no publica qué colores trae cada set: marca los que tienes o añade una familia entera.';

  @override
  String get collectionDecoSizesHint =>
      'Action vende sets DecoTime de 100, 150, 160, 200 y 300 rotuladores.';

  @override
  String get collectionFamiliesTitle => 'Añadir por familia';

  @override
  String collectionFamilyChip(String family, int owned, int total) {
    return '$family $owned/$total';
  }

  @override
  String get collectionFamilyColours => 'Colores';

  @override
  String get collectionFamilyWarmGrey => 'Grises cálidos';

  @override
  String get collectionFamilyCoolGrey => 'Grises fríos';

  @override
  String get collectionFamilyBlueGrey => 'Grises azulados';

  @override
  String get collectionFamilyGreenGrey => 'Grises verdosos';

  @override
  String get collectionDecoRange => 'Gama DecoTime';

  @override
  String get collectionWholeRange => 'Toda la gama';

  @override
  String get collectionSearchHint => 'Buscar código o nombre';

  @override
  String get collectionTickVisible => 'Marcar todos';

  @override
  String get collectionUntickVisible => 'Quitar todos';

  @override
  String get collectionInYourSets => 'En tu set';

  @override
  String get collectionNoResults =>
      'Ningún rotulador coincide con la búsqueda.';

  @override
  String get collectionReset => 'Vaciar colección';

  @override
  String collectionResetTitle(String brand) {
    return '¿Vaciar tu colección de $brand?';
  }

  @override
  String get collectionResetBody =>
      'Se quitan los sets y rotuladores sueltos de esta marca. Favoritos y paletas se mantienen.';

  @override
  String collectionOwnedCount(int owned, int total) {
    return '$owned de $total';
  }

  @override
  String get onboardingWelcomeTitle => 'Te damos la bienvenida';

  @override
  String get onboardingWelcomeBody =>
      'Explora tus rotuladores, empareja colores de tus fotos y crea paletas. Primero, dinos qué rotuladores tienes.';

  @override
  String get onboardingOhuhuLine => 'Sets por series: Oahu, Honolulu, Kaala';

  @override
  String get onboardingDecoLine => 'Una gama de 313 colores, sets en Action';

  @override
  String get onboardingSeriesTitle => '¿Qué series tienes?';

  @override
  String get onboardingSeriesBody =>
      'Elige todas las series de las que tienes rotuladores.';

  @override
  String get onboardingSetsTitle => '¿Qué sets tienes?';

  @override
  String get onboardingSetsBody =>
      'Elige las cajas que compraste. Los rotuladores sueltos se añaden después.';

  @override
  String get onboardingDecoTitle => 'Tus rotuladores DecoTime';

  @override
  String get onboardingDoneTitle => 'Todo listo';

  @override
  String get onboardingLaterNote => 'Puedes cambiarlo luego en Mi colección.';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingBack => 'Atrás';

  @override
  String get onboardingFinish => 'Empezar';

  @override
  String onboardingStep(int step, int total) {
    return 'Paso $step de $total';
  }

  @override
  String get collectionSeriesOahuTips => 'Punta fina y cincel';

  @override
  String get collectionSeriesHonoluluTips => 'Pincel y cincel';

  @override
  String get collectionSeriesKaalaTips => 'Punta pincel';

  @override
  String get collectionSummaryNoSets =>
      'Aún no has elegido sets: se usa toda la gama';

  @override
  String get collectionSummaryNoMarkers => 'Aún no has marcado rotuladores';

  @override
  String get collectionExtrasAddTitle => 'Añadir rotuladores sueltos';

  @override
  String get collectionDecoMarkersButton => 'Marcar rotuladores';

  @override
  String collectionExtrasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores sueltos',
      one: '1 rotulador suelto',
      zero: 'Sin rotuladores sueltos',
    );
    return '$_temp0';
  }

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Hasta que elijas sets, la app muestra toda la gama de $brand.';
  }

  @override
  String get onboardingDoneNoMarkers =>
      'Todavía no has marcado rotuladores DecoTime: márcalos en Mi colección.';

  @override
  String get onboardingDoneNext =>
      'Qué sigue: mira tus colores en Muestras, empareja una foto en Emparejar o crea una paleta en Paleta.';

  @override
  String get collectionVisibleScope =>
      'Afecta a los rotuladores que coinciden con la búsqueda.';
}
