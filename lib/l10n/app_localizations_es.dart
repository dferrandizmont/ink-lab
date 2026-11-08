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
  String get settingsClearPalettes => 'Borrar todo';

  @override
  String get settingsClearPalettesTitle =>
      '¿Borrar todas las paletas guardadas?';

  @override
  String get settingsClearPalettesBody =>
      'Se borrarán las paletas guardadas de esta marca. No se puede deshacer.';

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
  String get settingsBackupSubtitle =>
      'Copia tus datos (colección, paletas, diario, historial y ajustes) al portapapeles como texto para importarlos más tarde. No incluye las fotos ni la clave de la API.';

  @override
  String get settingsExportBackup => 'Exportar';

  @override
  String get settingsImportBackup => 'Importar';

  @override
  String get settingsBackupExported =>
      'Copia copiada al portapapeles, sin las fotos';

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
      'La copia reemplaza tus datos actuales: colección, paletas, diario, historial y ajustes. Las entradas del diario que no estén en ella se borran junto con sus fotos; las fotos nunca van en la copia.';

  @override
  String get ideasFavoritesChip => 'Favoritas';

  @override
  String get ideasFavoritesEmptyTitle => 'Aún no hay ideas favoritas';

  @override
  String get ideasFavoritesEmptyMessage =>
      'Toca el corazón de una idea para guardarla aquí.';

  @override
  String get ideasRecentTitle => 'Vistas hace poco';

  @override
  String get settingsBackupFileCaption =>
      'Un archivo ZIP con tus datos y todas tus fotos: diario, muestras y recetas. En el menú de compartir elige Archivos, Drive o cualquier app para guardarlo. La clave de la API nunca se incluye.';

  @override
  String get settingsBackupTextTitle => 'Copia por texto (sin fotos)';

  @override
  String get settingsSaveBackupFile => 'Compartir copia de seguridad';

  @override
  String get settingsRestoreBackupFile => 'Restaurar desde un archivo';

  @override
  String get settingsBackupFileSaving => 'Preparando tus datos y fotos…';

  @override
  String get settingsBackupFileRestoring => 'Restaurando tu copia…';

  @override
  String get settingsRestoreConfirmBody =>
      'El archivo reemplaza tus datos actuales: colección, paletas, diario, historial y ajustes. Las fotos del archivo también se restauran. Las entradas del diario que no estén en él se borran junto con sus fotos.';

  @override
  String get settingsBackupFileRestored => 'Copia restaurada, con las fotos';

  @override
  String get settingsBackupFileSaveFailed =>
      'No se pudo crear el archivo de copia.';

  @override
  String get settingsBackupFileReadFailed => 'No se pudo leer el archivo.';

  @override
  String get settingsBackupFileNotZip => 'Ese archivo no es una copia en ZIP.';

  @override
  String get settingsBackupFileTooLarge =>
      'La copia es demasiado grande para Ink Lab.';

  @override
  String get settingsBackupFileEntryTooLarge =>
      'Una foto de la copia es demasiado grande.';

  @override
  String get settingsBackupFileDamaged =>
      'El archivo está dañado o no es una copia de Ink Lab.';

  @override
  String get settingsBackupFileUnsupported =>
      'Esta copia es de una versión que Ink Lab no puede leer.';

  @override
  String get settingsBackupFileNotAPhoto =>
      'Una foto del archivo no es una imagen JPEG, PNG o WebP.';

  @override
  String get settingsBackupFileWriteFailed =>
      'No se pudieron guardar las fotos. Tus datos no han cambiado.';

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
  String get settingsAiEnabledSubtitleOnDevice => 'Gemini Nano en este móvil';

  @override
  String get settingsAiEnabledSubtitleOpenRouter =>
      'Usa tu propia clave de OpenRouter';

  @override
  String get settingsAiExplainColourTheory =>
      'Las paletas salen del motor de teoría del color integrado. Sin IA y sin que nada salga de tu móvil.';

  @override
  String get settingsAiExplainOnDevice =>
      'Gemini Nano funciona en este móvil y tus peticiones no salen de él. ML Kit de Google envía a Google diagnósticos de uso.';

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
      'Con Teoría del color seleccionada, las paletas salen del motor integrado: no se usa IA y no salen de tu móvil. En Android, la app puede preguntar a ML Kit de Google si Gemini Nano está disponible; ML Kit envía a Google diagnósticos de uso, nunca tus colores ni fotos. Elige En el dispositivo u OpenRouter para usar una IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'Con Teoría del color seleccionada, las paletas salen del motor integrado: no se usa IA y no salen de tu móvil. En Android, la app puede preguntar a ML Kit de Google si Gemini Nano está disponible; ML Kit envía a Google diagnósticos de uso, nunca tus colores ni fotos. Elige OpenRouter para usar una IA.';

  @override
  String get settingsAiDisclosureConfirm => 'Activar';

  @override
  String get settingsAiDisclosureCancel => 'Ahora no';

  @override
  String get settingsAiDisclosureOnDevice =>
      'Las peticiones En el dispositivo (Gemini Nano) las responde el modelo de este móvil: tu escenario y los códigos de color nunca salen de él y no hace falta clave. Para comprobar, descargar y usar el modelo, la app usa ML Kit de Google, que envía a Google diagnósticos de uso (modelo del móvil, versión de la app, identificadores de instalación, errores y tamaños), nunca tus peticiones, colores ni fotos. No se envía nada mientras este interruptor esté desactivado.';

  @override
  String get settingsAiOnDeviceName => 'IA en el dispositivo (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Tus peticiones no salen de este móvil. ML Kit envía a Google diagnósticos de uso, nunca tus peticiones, colores ni fotos.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'El modelo aún no está en este móvil. Android lo descarga una vez y lo conserva para todas las apps.';

  @override
  String get settingsAiOnDeviceDownloading => 'Descargando el modelo...';

  @override
  String get settingsAiOnDevicePreparing =>
      'Android está preparando el modelo. Puede tardar y esperar a tener Wi‑Fi y carga. Puedes salir de esta pantalla; la descarga continúa en segundo plano.';

  @override
  String get settingsAiEnabledSubtitleOnDeviceIos =>
      'Apple Intelligence en este móvil';

  @override
  String get settingsAiExplainOnDeviceIos =>
      'El modelo de Apple funciona en este móvil y tus peticiones no salen de él.';

  @override
  String get settingsAiDisclosureOnDeviceIos =>
      'Las peticiones En el dispositivo (Apple Intelligence) las responde el modelo de Apple en este móvil: tu escenario y los códigos de color nunca salen de él y no hace falta clave. iOS instala y gestiona el modelo con Apple Intelligence; la app no descarga nada ni usa ningún otro servicio para ello, así que no se envía nada.';

  @override
  String get settingsAiOnDeviceNameIos =>
      'IA en el dispositivo (Apple Intelligence)';

  @override
  String get settingsAiOnDevicePrivacyIos =>
      'Tus peticiones no salen de este móvil. No se envía nada: ni tus peticiones, ni colores, ni fotos.';

  @override
  String get settingsAiOnDevicePreparingIos =>
      'iOS está preparando el modelo de Apple Intelligence. Puede tardar. Puedes salir de esta pantalla; sigue en segundo plano.';

  @override
  String get settingsAiDisclosureIos =>
      'Con esto activado, cuando pidas una sugerencia a OpenRouter, la app envía a openrouter.ai y al proveedor del modelo, con tu propia clave de API: la marca, el modo de paleta y la escena, el código y el nombre del rotulador base y si está fijado, el tamaño de la paleta, los códigos y colores hex de los rotuladores candidatos, los ajustes del modelo y las instrucciones fijas de la app. Las fotos nunca se envían: esta función no sube imágenes. No se envía nada mientras este interruptor esté desactivado.';

  @override
  String get settingsAiDisclosureColourTheoryIos =>
      'Con Teoría del color seleccionada, las paletas salen del motor integrado: no se usa IA y no salen de tu móvil. Elige En el dispositivo u OpenRouter para usar una IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDeviceIos =>
      'Con Teoría del color seleccionada, las paletas salen del motor integrado: no se usa IA y no salen de tu móvil. Elige OpenRouter para usar una IA.';

  @override
  String get settingsAiOnDeviceCheckAgain => 'Comprobar de nuevo';

  @override
  String get settingsAiOnDeviceReady => 'El modelo está listo en este móvil.';

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
      'Ink Lab es un proyecto comunitario independiente: no está afiliado, respaldado ni patrocinado por ninguna de las marcas de rotuladores que incluye. Usa sus códigos, nombres y valores de color solo como datos factuales de referencia.';

  @override
  String get paletteTitle => 'Paleta';

  @override
  String get paletteBaseCodeLabel => 'Código del rotulador base';

  @override
  String paletteBaseCodeHint(String first, String second) {
    return '$first o $second';
  }

  @override
  String paletteBaseCodeHintOne(String code) {
    return '$code';
  }

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
  String get modeBlendingChain => 'Degradado para fundir';

  @override
  String get paletteTypeDescBlendingChain => 'Claro a oscuro, para fundir';

  @override
  String paletteChainResultTitle(int count) {
    return 'Degradado ($count)';
  }

  @override
  String paletteChainStep(int step, String role) {
    return 'Paso $step · $role';
  }

  @override
  String get roleLightest => 'Más claro';

  @override
  String get roleLighter => 'Claro';

  @override
  String get roleDarker => 'Oscuro';

  @override
  String get roleDarkest => 'Más oscuro';

  @override
  String get paletteChainHint =>
      'Trabaja de claro a oscuro y solapa cada paso mientras la tinta sigue húmeda. Suaviza las uniones con el difuminador incoloro si lo tienes.';

  @override
  String paletteChainShort(int count, int wanted) {
    return 'Solo $count de tus rotuladores funden bien con esta base, menos de los $wanted que pediste.';
  }

  @override
  String get paletteChainNeedLighter =>
      'Aún no hay degradado: te falta un rotulador más claro de esta familia.';

  @override
  String get paletteChainNeedDarker =>
      'Aún no hay degradado: te falta un rotulador más oscuro de esta familia.';

  @override
  String get paletteChainNeedBoth =>
      'Aún no hay degradado: te faltan un rotulador más claro y otro más oscuro de esta familia.';

  @override
  String get paletteChainBaseLightest =>
      'No tienes nada más claro en esta familia, así que el degradado empieza en tu base.';

  @override
  String get paletteChainBaseDarkest =>
      'No tienes nada más oscuro en esta familia, así que el degradado termina en tu base.';

  @override
  String get paletteChainOptionsLabel => 'Otros degradados';

  @override
  String paletteChainOption(int number) {
    return 'Opción $number';
  }

  @override
  String get paletteChainWholeRange => 'Buscar en toda la gama';

  @override
  String paletteChainWholeRangeNote(String brand) {
    return 'Se muestra toda la gama $brand, también rotuladores que no tienes.';
  }

  @override
  String get paletteChainMyMarkers => 'Volver a mis rotuladores';

  @override
  String get palettePaintTipChainFirst =>
      'Cubre primero toda la zona con el color más claro.';

  @override
  String get palettePaintTipChainMiddle =>
      'Solapa el paso anterior mientras sigue húmedo.';

  @override
  String get palettePaintTipChainLast =>
      'Termina con el más oscuro solo donde cae la sombra.';

  @override
  String get swatchesBlendingChain => 'Degradado';

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
  String get paletteShareButton => 'Compartir';

  @override
  String get shareFailed => 'No se pudo compartir la imagen.';

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
  String palettePaintPlanSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pasos',
      one: '1 paso',
    );
    return '$_temp0';
  }

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
      'No hay app de correo. Se ha copiado el informe: pégalo en un correo a inklab@mainshai.com';

  @override
  String get paletteAiFellBack =>
      'IA no disponible. Se muestran sugerencias locales.';

  @override
  String get paletteEmptyHint =>
      'Elige un rotulador base para crear una paleta, o una escena con el chip Escenas.';

  @override
  String get paletteCustomModeHint =>
      'El modo de paleta personalizada es manual: carga una paleta guardada o aplica una desde Ideas.';

  @override
  String get paletteNoSuggestions =>
      'No se pudo crear ninguna paleta con tu colección. Prueba otro modo o añade más rotuladores.';

  @override
  String get paletteScenarioTitle => 'Escenas';

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
  String swatchesClosestTo(String hex) {
    return 'Más cercanos a $hex';
  }

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
  String get ideasHeaderSubtitle => 'Ejercicios con tus rotuladores';

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
  String get ideasMoreDetails => 'Más detalles';

  @override
  String get ideasGuideOnlyNote =>
      'Este ejercicio usa toda tu colección, así que no tiene una paleta fija.';

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
  String get ideasTulipFieldTitle => 'Campo de tulipanes';

  @override
  String get ideasTulipFieldSummary =>
      'Hileras de tulipanes rojos y amarillos hasta el horizonte, con verde de primavera entre ellas.';

  @override
  String get ideasTulipFieldPractice =>
      'Bandas planas que se rompen en puntos al acercarse.';

  @override
  String get ideasTulipFieldSubject =>
      'Hileras de tulipanes vistas desde abajo, con el horizonte bajo.';

  @override
  String get ideasTulipFieldTip =>
      'La hilera más cercana son puntos y la más lejana una franja: cambia la marca según se aleja la hilera.';

  @override
  String get ideasTulipFieldStep1 =>
      'Dibuja a lápiz hileras que se estrechan hacia un horizonte bajo.';

  @override
  String get ideasTulipFieldStep2 =>
      'Rojo en las primeras hileras: manchas sueltas cerca y una franja sólida más lejos.';

  @override
  String get ideasTulipFieldStep3 =>
      'Amarillo en las hileras siguientes, igual que antes.';

  @override
  String get ideasTulipFieldStep4 =>
      'Verde claro entre las hileras y a lo largo del horizonte.';

  @override
  String get ideasTulipFieldStep5 =>
      'Verde más oscuro en una línea fina al pie de cada hilera.';

  @override
  String get ideasSummerBeachTitle => 'En la playa';

  @override
  String get ideasSummerBeachSummary =>
      'Arena, una franja de mar y una sombrilla: tres bandas planas y un acento vivo.';

  @override
  String get ideasSummerBeachPractice =>
      'Tres bandas planas y un único acento que lleva la mirada.';

  @override
  String get ideasSummerBeachSubject =>
      'Una playa vista desde la arena, con una sombrilla.';

  @override
  String get ideasSummerBeachTip =>
      'Deja la espuma como papel: es la línea más clara del mar.';

  @override
  String get ideasSummerBeachStep1 =>
      'Dibuja a lápiz tres bandas horizontales (cielo, mar, arena) y una sombrilla en la arena.';

  @override
  String get ideasSummerBeachStep2 =>
      'Arena pálida con la mano muy ligera; deja más clara la arena mojada junto al agua.';

  @override
  String get ideasSummerBeachStep3 =>
      'Turquesa claro para el mar, con una línea de papel para la espuma.';

  @override
  String get ideasSummerBeachStep4 => 'Turquesa más oscuro en el horizonte.';

  @override
  String get ideasSummerBeachStep5 =>
      'Sombrilla roja y su pequeña sombra en la arena, hecha con una segunda capa del color de la arena.';

  @override
  String get ideasWatermelonSliceTitle => 'Sandía';

  @override
  String get ideasWatermelonSliceSummary =>
      'Una raja de sandía: pulpa roja, corteza blanca, piel verde y pepitas negras.';

  @override
  String get ideasWatermelonSlicePractice =>
      'Un degradado rápido y una franja plana, con la corteza blanca dejada como papel.';

  @override
  String get ideasWatermelonSliceSubject =>
      'Una raja triangular de sandía con la base curva.';

  @override
  String get ideasWatermelonSliceTip =>
      'La corteza blanca es papel: no la colorees.';

  @override
  String get ideasWatermelonSliceStep1 =>
      'Dibuja a lápiz un triángulo con la base curva y una franja blanca fina dentro del verde.';

  @override
  String get ideasWatermelonSliceStep2 =>
      'Rojo claro sobre la pulpa, más pálido junto a la corteza.';

  @override
  String get ideasWatermelonSliceStep3 =>
      'Rojo más intenso hacia la punta, fundido mientras está húmedo.';

  @override
  String get ideasWatermelonSliceStep4 =>
      'Verde en la piel, con rayas de verde oscuro en una segunda capa.';

  @override
  String get ideasWatermelonSliceStep5 =>
      'Pepitas con el rotulador calibrado, cada una como una gota pequeña.';

  @override
  String get ideasForestMushroomsTitle => 'Setas en el suelo del bosque';

  @override
  String get ideasForestMushroomsSummary =>
      'Un grupo de setas entre hojas marrones en otoño.';

  @override
  String get ideasForestMushroomsPractice =>
      'Sombreros redondos con degradados pequeños y un suelo de trazos sueltos.';

  @override
  String get ideasForestMushroomsSubject =>
      'Tres setas de distintas alturas entre hojas caídas.';

  @override
  String get ideasForestMushroomsTip =>
      'El suelo del bosque pide trazos sueltos y rotos de marrón, no rellenos macizos.';

  @override
  String get ideasForestMushroomsStep1 =>
      'Dibuja a lápiz tres setas de distintas alturas y unas hojas alrededor.';

  @override
  String get ideasForestMushroomsStep2 =>
      'Beige pálido en los tallos y en la parte de abajo de los sombreros.';

  @override
  String get ideasForestMushroomsStep3 =>
      'Marrón rojizo en los sombreros, más oscuro en el borde.';

  @override
  String get ideasForestMushroomsStep4 => 'Marrón en las hojas y en el suelo.';

  @override
  String get ideasForestMushroomsStep5 =>
      'El más oscuro bajo los sombreros y donde los tallos tocan el suelo; si quieres, motas de gel blanco en los sombreros.';

  @override
  String get ideasHarvestBasketTitle => 'Cesta de la cosecha';

  @override
  String get ideasHarvestBasketSummary =>
      'Manzanas, una pera y una calabaza pequeña en una cesta, cada una de un color, sombreadas con un mismo gris.';

  @override
  String get ideasHarvestBasketPractice =>
      'Un solo gris sombreando tres colores fuertes para que encajen juntos.';

  @override
  String get ideasHarvestBasketSubject =>
      'Una cesta llena de fruta: manzanas, una pera y una calabaza.';

  @override
  String get ideasHarvestBasketTip =>
      'Sombrea toda la fruta con el mismo gris. Es lo que mantiene unido un bodegón con muchas piezas.';

  @override
  String get ideasHarvestBasketStep1 =>
      'Dibuja a lápiz la cesta y la fruta superpuesta.';

  @override
  String get ideasHarvestBasketStep2 =>
      'Rojo para las manzanas, dejando el brillo como papel.';

  @override
  String get ideasHarvestBasketStep3 => 'Verde amarillento para la pera.';

  @override
  String get ideasHarvestBasketStep4 =>
      'Naranja para la calabaza, con sus nervios como líneas más oscuras de una segunda capa.';

  @override
  String get ideasHarvestBasketStep5 =>
      'El mismo gris para todas las sombras y el interior de la cesta.';

  @override
  String get ideasHarvestBasketStep6 =>
      'El rotulador más oscuro para las líneas del trenzado de la cesta.';

  @override
  String get ideasHotChocolateTitle => 'Chocolate caliente';

  @override
  String get ideasHotChocolateSummary =>
      'Una taza de chocolate con vapor, una nube de azúcar y una manopla roja.';

  @override
  String get ideasHotChocolatePractice =>
      'Marrones cálidos, un acento rojo y vapor levantado del fondo.';

  @override
  String get ideasHotChocolateSubject =>
      'Una taza de chocolate caliente con una nube de azúcar y una manopla al lado.';

  @override
  String get ideasHotChocolateTip =>
      'El vapor es papel o una forma levantada con el difuminador, nunca una línea dibujada.';

  @override
  String get ideasHotChocolateStep1 =>
      'Dibuja a lápiz la taza, la superficie de la bebida, una nube de azúcar y una manopla apoyada en ella.';

  @override
  String get ideasHotChocolateStep2 =>
      'Marrón pálido en el lado iluminado de la taza y en la sombra de la nube.';

  @override
  String get ideasHotChocolateStep3 =>
      'Marrón en la superficie de la bebida y en el lado de la sombra de la taza.';

  @override
  String get ideasHotChocolateStep4 => 'Manopla roja, dos capas.';

  @override
  String get ideasHotChocolateStep5 =>
      'Vapor: levanta jirones del fondo con el difuminador, o déjalo como papel.';

  @override
  String get ideasLunarNewYearTitle => 'Año Nuevo Lunar';

  @override
  String get ideasLunarNewYearSummary =>
      'Farolillos rojos con adornos dorados contra una pared roja.';

  @override
  String get ideasLunarNewYearPractice =>
      'Una familia de rojos en tres pasos y un acento dorado plano.';

  @override
  String get ideasLunarNewYearSubject =>
      'Tres farolillos redondos colgados a distintas alturas, con borlas.';

  @override
  String get ideasLunarNewYearTip =>
      'Pon el oro encima del rojo ya seco, nunca al revés.';

  @override
  String get ideasLunarNewYearStep1 =>
      'Dibuja a lápiz tres farolillos colgados a distintas alturas, con borlas.';

  @override
  String get ideasLunarNewYearStep2 =>
      'Rojo claro sobre los farolillos, más pálido en el lado iluminado.';

  @override
  String get ideasLunarNewYearStep3 =>
      'El rojo en el lado de la sombra y en los nervios, fundido mientras está húmedo.';

  @override
  String get ideasLunarNewYearStep4 =>
      'Rojo oscuro entre los nervios y dentro de los bordes.';

  @override
  String get ideasLunarNewYearStep5 =>
      'Amarillo dorado en los bordes, las tapas y las borlas, con bordes nítidos.';

  @override
  String get ideasDiwaliLampsTitle => 'Lámparas de Diwali';

  @override
  String get ideasDiwaliLampsSummary =>
      'Una fila de lámparas de barro con pequeñas llamas y un rangoli de colores vivos alrededor.';

  @override
  String get ideasDiwaliLampsPractice =>
      'Un patrón plano y saturado junto a un degradado de dos pasos en las lámparas.';

  @override
  String get ideasDiwaliLampsSubject =>
      'Cinco pequeñas lámparas de barro en curva, con un patrón simétrico sencillo alrededor.';

  @override
  String get ideasDiwaliLampsTip =>
      'Mantén el patrón plano y de bordes duros. El contraste con las lámparas es lo que lo hace funcionar.';

  @override
  String get ideasDiwaliLampsStep1 =>
      'Dibuja a lápiz cinco pequeñas lámparas en curva y un patrón simétrico sencillo alrededor.';

  @override
  String get ideasDiwaliLampsStep2 => 'Terracota clara en las lámparas.';

  @override
  String get ideasDiwaliLampsStep3 =>
      'Terracota más oscura en el lado de la sombra.';

  @override
  String get ideasDiwaliLampsStep4 =>
      'Amarillo para cada llama y un halo en el borde de cada lámpara.';

  @override
  String get ideasDiwaliLampsStep5 =>
      'Magenta en las secciones alternas del patrón, plano y de bordes duros.';

  @override
  String get ideasDiwaliLampsStep6 =>
      'Turquesa en las otras secciones y, si quieres, motas de gel blanco en las llamas.';

  @override
  String get ideasHanukkahCandlesTitle => 'Hanukká';

  @override
  String get ideasHanukkahCandlesSummary =>
      'Un candelabro de Hanukká con las velas encendidas, azul y blanco con llamas doradas.';

  @override
  String get ideasHanukkahCandlesPractice =>
      'Formas blancas conservadas como papel sobre un campo azul.';

  @override
  String get ideasHanukkahCandlesSubject =>
      'Un candelabro de Hanukká con las velas encendidas delante de un fondo azul.';

  @override
  String get ideasHanukkahCandlesTip =>
      'Las velas son papel: colorea alrededor y saldrán blancas.';

  @override
  String get ideasHanukkahCandlesStep1 =>
      'Dibuja a lápiz el candelabro y las velas; las velas se quedan en papel.';

  @override
  String get ideasHanukkahCandlesStep2 => 'Fondo azul claro alrededor de todo.';

  @override
  String get ideasHanukkahCandlesStep3 =>
      'Azul más intenso en los bordes de la hoja, fundido hacia dentro.';

  @override
  String get ideasHanukkahCandlesStep4 =>
      'El azul oscuro para el propio candelabro.';

  @override
  String get ideasHanukkahCandlesStep5 =>
      'Llamas amarillas y un halo suave alrededor, y luego un centro de gel blanco en cada llama.';

  @override
  String get ideasPaintedEggsTitle => 'Huevos pintados';

  @override
  String get ideasPaintedEggsSummary =>
      'Tres huevos decorados con rayas, puntos y zigzag en colores de intensidad media.';

  @override
  String get ideasPaintedEggsPractice =>
      'Tres formas de hacer un patrón: papel, forma y segunda capa.';

  @override
  String get ideasPaintedEggsSubject =>
      'Tres huevos, cada uno con un patrón distinto.';

  @override
  String get ideasPaintedEggsTip =>
      'Los colores de intensidad media dejan ver la segunda capa sin ensuciarse.';

  @override
  String get ideasPaintedEggsStep1 =>
      'Dibuja a lápiz tres huevos y un patrón distinto en cada uno.';

  @override
  String get ideasPaintedEggsStep2 =>
      'Primer huevo: color base plano, con el patrón reservado en papel.';

  @override
  String get ideasPaintedEggsStep3 =>
      'Segundo huevo: rellena solo las formas del patrón, el resto se queda en papel.';

  @override
  String get ideasPaintedEggsStep4 =>
      'Tercer huevo: colóralo y luego añade el patrón con el mismo color como segunda capa.';

  @override
  String get ideasPaintedEggsStep5 =>
      'Un gris para el lado de la sombra de cada huevo y la pequeña sombra debajo.';

  @override
  String get ideasDiaDeMuertosTitle => 'Día de Muertos';

  @override
  String get ideasDiaDeMuertosSummary =>
      'Flores de cempasúchil y una calavera decorada en naranja, magenta y turquesa sobre un fondo oscuro.';

  @override
  String get ideasDiaDeMuertosPractice =>
      'Patrón plano y saturado sobre un campo oscuro.';

  @override
  String get ideasDiaDeMuertosSubject =>
      'Una calavera decorada con formas de flor alrededor de los ojos y un grupo de flores de cempasúchil debajo.';

  @override
  String get ideasDiaDeMuertosTip =>
      'Pon el fondo oscuro al final y despacio: la tinta oscura se corre hacia las zonas claras.';

  @override
  String get ideasDiaDeMuertosStep1 =>
      'Dibuja a lápiz una calavera con formas de flor alrededor de los ojos y un grupo de flores de cempasúchil debajo.';

  @override
  String get ideasDiaDeMuertosStep2 =>
      'Naranja claro en las flores, cada una como un círculo tosco.';

  @override
  String get ideasDiaDeMuertosStep3 =>
      'Naranja más intenso en trazos cortos dentro de cada círculo para los pétalos.';

  @override
  String get ideasDiaDeMuertosStep4 =>
      'Magenta para los patrones de la calavera, planos y simétricos.';

  @override
  String get ideasDiaDeMuertosStep5 =>
      'Turquesa para la otra mitad de los patrones de la calavera.';

  @override
  String get ideasDiaDeMuertosStep6 =>
      'El rotulador más oscuro para las cuencas de los ojos y el fondo, y después los detalles con el rotulador calibrado.';

  @override
  String get ideasValentineCardTitle => 'Tarjeta de San Valentín';

  @override
  String get ideasValentineCardSummary =>
      'Una tarjeta con tres corazones, del rosa pálido al rojo profundo, y una línea de sombra que los despega del papel.';

  @override
  String get ideasValentineCardPractice =>
      'Tres rellenos planos y una línea de sombra proyectada.';

  @override
  String get ideasValentineCardSubject =>
      'Tres corazones superpuestos, el más grande detrás.';

  @override
  String get ideasValentineCardTip =>
      'Dibuja la sombra proyectada como una línea fina: despega el corazón sin añadir color.';

  @override
  String get ideasValentineCardStep1 =>
      'Dibuja a lápiz tres corazones superpuestos, el más grande detrás.';

  @override
  String get ideasValentineCardStep2 => 'Rosa pálido en el corazón de atrás.';

  @override
  String get ideasValentineCardStep3 => 'Rosa en el del medio.';

  @override
  String get ideasValentineCardStep4 =>
      'Rojo en el de delante y una línea fina del mismo bajo los otros dos como sombra proyectada.';

  @override
  String get ideasValentineCardStep5 =>
      'Un brillo de gel blanco en cada corazón, arriba a la izquierda.';

  @override
  String get ideasCarnivalMaskTitle => 'Máscara de carnaval';

  @override
  String get ideasCarnivalMaskSummary =>
      'Una máscara con plumas en violeta, turquesa y oro.';

  @override
  String get ideasCarnivalMaskPractice =>
      'Trazos rápidos para las plumas, un degradado para la máscara y oro plano.';

  @override
  String get ideasCarnivalMaskSubject =>
      'Una media máscara con tres plumas que suben por un lado.';

  @override
  String get ideasCarnivalMaskTip =>
      'Haz las plumas con trazos rápidos hacia fuera desde el cañón: el borde suave es lo que las hace parecer plumas.';

  @override
  String get ideasCarnivalMaskStep1 =>
      'Dibuja a lápiz una media máscara y tres plumas que suben por un lado.';

  @override
  String get ideasCarnivalMaskStep2 =>
      'Violeta en la máscara, dos capas donde se curva hacia atrás.';

  @override
  String get ideasCarnivalMaskStep3 =>
      'Turquesa en las plumas, con trazos rápidos hacia fuera desde el cañón para que los bordes queden suaves.';

  @override
  String get ideasCarnivalMaskStep4 =>
      'Oro en el borde de la máscara y en los contornos de los ojos.';

  @override
  String get ideasCarnivalMaskStep5 =>
      'El más oscuro dentro de los huecos de los ojos y, después, puntos de gel como lentejuelas.';

  @override
  String get ideasMidsummerCrownTitle => 'Corona de flores de verano';

  @override
  String get ideasMidsummerCrownSummary =>
      'Una corona de flores silvestres y hojas: azul, amarillo y rosa sobre verde.';

  @override
  String get ideasMidsummerCrownPractice =>
      'Muchos toques pequeños de la punta fina sobre un verde ya seco.';

  @override
  String get ideasMidsummerCrownSubject =>
      'Un anillo de hojas con tres tipos de flores silvestres pequeñas.';

  @override
  String get ideasMidsummerCrownTip =>
      'Los toques de color sobre una base seca quedan nítidos. Espera a que el verde se seque antes de empezar con las flores.';

  @override
  String get ideasMidsummerCrownStep1 =>
      'Dibuja a lápiz un anillo de hojas y pequeñas flores de tres tipos.';

  @override
  String get ideasMidsummerCrownStep2 => 'Verde claro en todas las hojas.';

  @override
  String get ideasMidsummerCrownStep3 =>
      'Verde más oscuro donde las hojas se solapan y por debajo.';

  @override
  String get ideasMidsummerCrownStep4 => 'Azul en el primer tipo de flor.';

  @override
  String get ideasMidsummerCrownStep5 => 'Amarillo en el segundo tipo de flor.';

  @override
  String get ideasMidsummerCrownStep6 =>
      'Rosa en el tercero, con una pequeña segunda capa en el centro de cada flor.';

  @override
  String get ideasEidNightTitle => 'Noche de Eid';

  @override
  String get ideasEidNightSummary =>
      'Una luna creciente y un farol colgante contra un cielo turquesa y violeta profundos.';

  @override
  String get ideasEidNightPractice =>
      'Un fundido limpio de turquesa a violeta en húmedo, con el oro encima.';

  @override
  String get ideasEidNightSubject =>
      'Una luna creciente y un farol con dibujo contra un cielo nocturno.';

  @override
  String get ideasEidNightTip =>
      'Funde el turquesa con el violeta mientras ambos estén húmedos. Una vez seco, el cielo queda limpio.';

  @override
  String get ideasEidNightStep1 =>
      'Dibuja a lápiz la luna creciente y un farol con dibujo; los dos se quedan en papel por ahora.';

  @override
  String get ideasEidNightStep2 =>
      'Turquesa por todo el cielo, más claro junto a la luna.';

  @override
  String get ideasEidNightStep3 => 'Turquesa más intenso hacia los bordes.';

  @override
  String get ideasEidNightStep4 =>
      'Violeta fundido en las esquinas de arriba mientras el turquesa sigue húmedo.';

  @override
  String get ideasEidNightStep5 =>
      'Oro en la luna y en la estructura del farol; los paneles quedan claros y luego añades estrellas de gel blanco.';

  @override
  String get ideasHoliColoursTitle => 'Holi';

  @override
  String get ideasHoliColoursSummary =>
      'Nubes de polvo de color sobre blanco: bordes suaves, centros duros, cuatro colores vivos.';

  @override
  String get ideasHoliColoursPractice =>
      'Color sin borde: el difuminador disuelve un borde en el papel.';

  @override
  String get ideasHoliColoursSubject =>
      'Cuatro nubes de polvo de color superpuestas sobre papel blanco.';

  @override
  String get ideasHoliColoursTip =>
      'Deja secar cada nube antes de añadir la siguiente, o todos los colores se vuelven barro.';

  @override
  String get ideasHoliColoursStep1 =>
      'Garabatea una nube suelta con el primer color, densa en el centro.';

  @override
  String get ideasHoliColoursStep2 =>
      'Estira sus bordes con el difuminador hacia el papel blanco hasta que desaparezcan.';

  @override
  String get ideasHoliColoursStep3 =>
      'Una segunda nube que se solape un poco con la primera; donde se toquen, deja que se mezclen.';

  @override
  String get ideasHoliColoursStep4 =>
      'Una tercera nube, más pequeña, en un hueco.';

  @override
  String get ideasHoliColoursStep5 =>
      'Una cuarta nube en el último hueco y luego unos puntos de cada color a su alrededor.';

  @override
  String get ideasSummerIceCreamTitle => 'Helado';

  @override
  String get ideasSummerIceCreamSummary =>
      'Tres bolas de sabores distintos sobre un cucurucho.';

  @override
  String get ideasSummerIceCreamPractice =>
      'Tres degradados redondos y un gris que los sombrea a todos.';

  @override
  String get ideasSummerIceCreamSubject =>
      'Tres bolas apiladas sobre un cucurucho con un enrejado.';

  @override
  String get ideasSummerIceCreamTip =>
      'Usa el mismo gris para todas las bolas: eso mantiene juntos tres colores distintos.';

  @override
  String get ideasSummerIceCreamStep1 =>
      'Dibuja a lápiz un cucurucho con enrejado y tres bolas apiladas.';

  @override
  String get ideasSummerIceCreamStep2 =>
      'El primer sabor en la bola de abajo, dejando en ella un brillo de papel.';

  @override
  String get ideasSummerIceCreamStep3 =>
      'El segundo sabor en la bola del medio, también con su brillo.';

  @override
  String get ideasSummerIceCreamStep4 =>
      'El tercer sabor en la bola de arriba.';

  @override
  String get ideasSummerIceCreamStep5 =>
      'El mismo gris claro en la parte de abajo de cada bola y donde se solapan.';

  @override
  String get ideasSummerIceCreamStep6 =>
      'El cucurucho en beige, con las líneas del enrejado en una segunda capa.';

  @override
  String get ideasNewYearFireworksTitle => 'Fuegos de Año Nuevo';

  @override
  String get ideasNewYearFireworksSummary =>
      'Tres estallidos de fuegos artificiales sobre un cielo oscuro, cada uno de un color.';

  @override
  String get ideasNewYearFireworksPractice =>
      'Color vivo sobre un relleno oscuro, con las líneas reservadas en papel.';

  @override
  String get ideasNewYearFireworksSubject =>
      'Tres estallidos de fuegos artificiales con líneas finas que salen de cada centro.';

  @override
  String get ideasNewYearFireworksTip =>
      'Rellena el cielo alrededor de las líneas, no encima: el papel blanco es lo que hace brillar los fuegos.';

  @override
  String get ideasNewYearFireworksStep1 =>
      'Dibuja a lápiz tres centros y líneas finas que salgan de cada uno; las líneas se quedan en papel por ahora.';

  @override
  String get ideasNewYearFireworksStep2 =>
      'Rellena el cielo de oscuro, rodeando las líneas con la punta fina (pueden quedar desiguales).';

  @override
  String get ideasNewYearFireworksStep3 =>
      'Sigue las líneas del primer estallido con el primer color, presionando más en las puntas.';

  @override
  String get ideasNewYearFireworksStep4 =>
      'Las líneas del segundo estallido con el segundo color.';

  @override
  String get ideasNewYearFireworksStep5 =>
      'Las líneas del tercer estallido con el tercer color.';

  @override
  String get ideasNewYearFireworksStep6 =>
      'Gel blanco en el centro de cada estallido y unas chispas en las puntas.';

  @override
  String get ideasCozyLampTitle => 'Rincón acogedor';

  @override
  String get ideasCozyLampSummary =>
      'Un sillón bajo una lámpara por la tarde: un charco de luz cálida y sombras marrones suaves.';

  @override
  String get ideasCozyLampPractice =>
      'Planear una zona iluminada y dejar que el resto de la habitación caiga en un marrón cálido.';

  @override
  String get ideasCozyLampSubject =>
      'Un sillón, una lámpara de pie y una pared detrás.';

  @override
  String get ideasCozyLampTip =>
      'No metas el marrón más oscuro en el círculo de luz: la lámpara no llega a ningún rincón.';

  @override
  String get ideasCozyLampStep1 =>
      'Dibuja a lápiz el sillón, la lámpara y el círculo de luz que lanza sobre el suelo y la pared.';

  @override
  String get ideasCozyLampStep2 =>
      'Rellena el círculo de luz con el amarillo pálido y difumínalo con el difuminador incoloro.';

  @override
  String get ideasCozyLampStep3 =>
      'Colorea el resto de la habitación con el beige cálido claro, plano y uniforme.';

  @override
  String get ideasCozyLampStep4 =>
      'Pon el marrón cálido en el sillón y en el lado de la habitación lejos de la lámpara.';

  @override
  String get ideasCozyLampStep5 =>
      'Usa el marrón oscuro en los rincones y bajo el sillón, y no lo metas en el círculo de luz.';

  @override
  String get ideasFoggyMorningTitle => 'Niebla';

  @override
  String get ideasFoggyMorningSummary =>
      'Árboles que se pierden en la niebla: los de cerca más oscuros, los de lejos más pálidos.';

  @override
  String get ideasFoggyMorningPractice =>
      'Profundidad con una veladura pálida sobre formas oscuras.';

  @override
  String get ideasFoggyMorningSubject =>
      'Tres filas de árboles en un camino, cada una más al fondo.';

  @override
  String get ideasFoggyMorningTip =>
      'Una veladura pálida sobre una forma oscura es la niebla más simple que hay: la tinta de debajo se queda.';

  @override
  String get ideasFoggyMorningStep1 =>
      'Dibuja a lápiz tres filas de árboles, cada una más al fondo, y marca dónde empieza el suelo.';

  @override
  String get ideasFoggyMorningStep2 =>
      'Colorea la fila más lejana solo con el rotulador más pálido, sin ningún detalle.';

  @override
  String get ideasFoggyMorningStep3 =>
      'Colorea la fila del medio con el tono base y suaviza su borde inferior hacia el suelo con el difuminador.';

  @override
  String get ideasFoggyMorningStep4 =>
      'Dibuja los árboles más cercanos con el rotulador oscuro y añade unas pocas ramas.';

  @override
  String get ideasFoggyMorningStep5 =>
      'Pasa una veladura del rotulador pálido por encima de todas las filas, para que la niebla cubra toda la escena.';

  @override
  String get ideasRainyWindowTitle => 'Lluvia en la ventana';

  @override
  String get ideasRainyWindowSummary =>
      'Luces difusas vistas a través de un cristal mojado, con gotas que resbalan.';

  @override
  String get ideasRainyWindowPractice =>
      'Luces que brillan detrás del cristal y marcas nítidas por encima.';

  @override
  String get ideasRainyWindowSubject =>
      'Una ventana de noche con farolas fuera y tres gotas en el cristal.';

  @override
  String get ideasRainyWindowTip =>
      'Las luces deben secarse del todo antes de pasar el azul por encima, o los colores se mezclan.';

  @override
  String get ideasRainyWindowStep1 =>
      'Dibuja a lápiz el marco de la ventana y unas manchas difusas de luz fuera, y marca el recorrido de tres gotas.';

  @override
  String get ideasRainyWindowStep2 =>
      'Colorea las luces cálidas como manchas suaves y funde sus bordes con el difuminador.';

  @override
  String get ideasRainyWindowStep3 =>
      'Cubre todo el cristal con el azul claro, rodeando las luces.';

  @override
  String get ideasRainyWindowStep4 =>
      'Añade el azul base hacia las esquinas y deja los recorridos de las gotas algo más claros.';

  @override
  String get ideasRainyWindowStep5 =>
      'Colorea el marco en oscuro y pon una media luna oscura en el lado de cada gota opuesto a la luz.';

  @override
  String get ideasRainyWindowStep6 =>
      'Cuando esté seco, añade un toque de gel blanco en el lado iluminado de cada gota.';

  @override
  String get ideasEerieForestTitle => 'Bosque inquietante';

  @override
  String get ideasEerieForestSummary =>
      'Árboles finos al anochecer en verdes enfermizos, con un cielo violeta entre ellos.';

  @override
  String get ideasEerieForestPractice =>
      'Dejar que dos colores se mezclen al tocarse, a propósito.';

  @override
  String get ideasEerieForestSubject =>
      'Troncos altos y finos sobre un horizonte bajo al anochecer.';

  @override
  String get ideasEerieForestTip =>
      'El verde y el violeta se vuelven grises donde se tocan. Ese gris es el ambiente, no un error.';

  @override
  String get ideasEerieForestStep1 =>
      'Dibuja a lápiz troncos altos y finos y un horizonte bajo.';

  @override
  String get ideasEerieForestStep2 =>
      'Pon un verde amarillento pálido a lo largo del horizonte, entre los troncos.';

  @override
  String get ideasEerieForestStep3 =>
      'Colorea el violeta de arriba y fúndelo con el verde mientras esté húmedo.';

  @override
  String get ideasEerieForestStep4 =>
      'Colorea el verde del suelo y de la parte baja de los troncos.';

  @override
  String get ideasEerieForestStep5 =>
      'Usa el verde más oscuro en los troncos con trazos desiguales, y añade sombras largas por el suelo.';

  @override
  String get ideasGoldenHourTitle => 'Hora dorada';

  @override
  String get ideasGoldenHourSummary =>
      'Una pared blanca y una puerta al final de la tarde: luz naranja, sombras violetas largas.';

  @override
  String get ideasGoldenHourPractice =>
      'Una veladura cálida sobre todo, con sombras frías de borde nítido encima.';

  @override
  String get ideasGoldenHourSubject =>
      'Una pared con una puerta, una planta y la sombra larga que la planta proyecta.';

  @override
  String get ideasGoldenHourTip =>
      'La pared aquí no es blanca: con esta luz es naranja. Píntala así.';

  @override
  String get ideasGoldenHourStep1 =>
      'Dibuja a lápiz una pared con una puerta y una planta, y la sombra larga que la planta proyecta.';

  @override
  String get ideasGoldenHourStep2 =>
      'Cubre toda la pared con el naranja pálido: esa es la pared blanca con esta luz.';

  @override
  String get ideasGoldenHourStep3 =>
      'Pon el naranja más intenso bajo el dintel y en la puerta.';

  @override
  String get ideasGoldenHourStep4 =>
      'Añade el gris violeta en la sombra de la planta y en el hueco de la puerta, con un borde nítido.';

  @override
  String get ideasGoldenHourStep5 =>
      'Reserva el rotulador más oscuro para el fondo del hueco de la puerta.';

  @override
  String get ideasStormySeaTitle => 'Mar tormentoso';

  @override
  String get ideasStormySeaSummary =>
      'Olas gris verdosas bajo un cielo oscuro, con papel blanco para la espuma.';

  @override
  String get ideasStormySeaPractice =>
      'Un agua plana y pálida frente a un cielo pesado, con la espuma sin tocar.';

  @override
  String get ideasStormySeaSubject =>
      'Un horizonte bajo, dos olas grandes y la espuma que rompe en ellas.';

  @override
  String get ideasStormySeaTip =>
      'La espuma es papel que no has tocado: planifica dónde rompe antes de colorear el agua.';

  @override
  String get ideasStormySeaStep1 =>
      'Dibuja a lápiz el horizonte bajo, dos olas grandes y dónde rompe la espuma. La espuma se queda sin tocar.';

  @override
  String get ideasStormySeaStep2 =>
      'Cubre el agua con el gris verdoso pálido, rodeando la espuma.';

  @override
  String get ideasStormySeaStep3 =>
      'Pon el agua más oscura en los valles entre olas y bajo cada cresta.';

  @override
  String get ideasStormySeaStep4 =>
      'Rellena el cielo con el rotulador oscuro, más oscuro arriba, y el agua más profunda bajo la ola que rompe.';

  @override
  String get ideasStormySeaStep5 =>
      'Cuando esté seco, añade gel blanco para la espuma que salta de las crestas: solo unos puntos.';

  @override
  String get ideasCandleFlameTitle => 'A la luz de la vela';

  @override
  String get ideasCandleFlameSummary =>
      'Una vela sobre una mesa en una habitación oscura: todo cálido, y nada visible lejos de la llama.';

  @override
  String get ideasCandleFlamePractice =>
      'Anillos concéntricos de color cálido, fundidos en húmedo unos con otros.';

  @override
  String get ideasCandleFlameSubject =>
      'Una vela en su candelero, con la mesa y la pared de fondo.';

  @override
  String get ideasCandleFlameTip =>
      'Solo se ve lo que toca la llama: el fondo de la habitación puede ser casi una mancha oscura.';

  @override
  String get ideasCandleFlameStep1 =>
      'Dibuja a lápiz la vela, su llama y un círculo de luz sobre la mesa. El núcleo de la llama se queda sin tocar.';

  @override
  String get ideasCandleFlameStep2 =>
      'Colorea el halo de la llama y la parte más cercana de la mesa con el amarillo, difuminado hacia fuera con el difuminador.';

  @override
  String get ideasCandleFlameStep3 =>
      'Pon el naranja cálido en el lado iluminado de la vela y en el siguiente anillo de la mesa.';

  @override
  String get ideasCandleFlameStep4 =>
      'Colorea de marrón todo lo que queda fuera del círculo de luz.';

  @override
  String get ideasCandleFlameStep5 =>
      'Usa el marrón más oscuro para el fondo de la habitación y el lado en sombra de la vela, con un borde suave contra la luz.';

  @override
  String get ideasDesertNoonTitle => 'Mediodía en el desierto';

  @override
  String get ideasDesertNoonSummary =>
      'Arena, una roca y una sombra dura bajo un cielo blanqueado.';

  @override
  String get ideasDesertNoonPractice =>
      'Un relleno plano y pálido contra una sombra dura y oscura.';

  @override
  String get ideasDesertNoonSubject =>
      'Un horizonte alto, una sola roca y su sombra corta justo debajo.';

  @override
  String get ideasDesertNoonTip =>
      'Deja una franja de papel blanco en el horizonte: esa franja es lo que hace que el cielo parezca caliente.';

  @override
  String get ideasDesertNoonStep1 =>
      'Dibuja a lápiz un horizonte alto, una roca y su sombra corta justo debajo.';

  @override
  String get ideasDesertNoonStep2 =>
      'Cubre la arena de debajo del horizonte con el amarillo pálido, en una sola pasada muy ligera.';

  @override
  String get ideasDesertNoonStep3 =>
      'Colorea el cielo con el azul pálido y déjalo más claro cerca del horizonte.';

  @override
  String get ideasDesertNoonStep4 =>
      'Pon el naranja en el lado en sombra de la roca y en las ondulaciones de la arena.';

  @override
  String get ideasDesertNoonStep5 =>
      'Usa el azul violeta solo en la sombra que proyecta la roca, con un borde duro.';

  @override
  String get ideasBokehLightsTitle => 'Luces difusas';

  @override
  String get ideasBokehLightsSummary =>
      'Un fondo de círculos de luz suaves y fuera de foco.';

  @override
  String get ideasBokehLightsPractice =>
      'Hacer un disco suave con el difuminador sobre un campo plano.';

  @override
  String get ideasBokehLightsSubject =>
      'Un campo oscuro con una docena de luces difusas de tamaños distintos.';

  @override
  String get ideasBokehLightsTip =>
      'Apoya el difuminador plano: una punta fina dibuja una línea, no un disco.';

  @override
  String get ideasBokehLightsStep1 =>
      'Rellena toda la zona con el color base, con trazos planos.';

  @override
  String get ideasBokehLightsStep2 =>
      'Oscurece las esquinas y funde la oscuridad hacia dentro mientras la tinta está húmeda.';

  @override
  String get ideasBokehLightsStep3 =>
      'Deja secar y luego apoya la punta ancha del difuminador en círculos de tamaños distintos.';

  @override
  String get ideasBokehLightsStep4 =>
      'Toca el rotulador claro en el centro de algunos discos para que brillen.';

  @override
  String get ideasBokehLightsStep5 =>
      'Pon un punto de gel blanco dentro de dos o tres discos, no en todos.';

  @override
  String get ideasRetroPosterTitle => 'Cartel retro';

  @override
  String get ideasRetroPosterSummary =>
      'Tres colores planos, algo apagados, y uno oscuro, sin fundir nada.';

  @override
  String get ideasRetroPosterPractice =>
      'Rellenos planos y bordes duros, como se ve un cartel impreso.';

  @override
  String get ideasRetroPosterSubject =>
      'Un faro, un coche o una botella dibujados con unas pocas formas planas.';

  @override
  String get ideasRetroPosterTip =>
      'Deja un hilo de papel blanco entre los colores, como si la impresión se hubiera movido un poco.';

  @override
  String get ideasRetroPosterStep1 =>
      'Dibuja a lápiz un motivo sencillo con formas grandes y planas: un faro, un coche, una botella.';

  @override
  String get ideasRetroPosterStep2 =>
      'Rellena las formas más grandes en plano, en una sola pasada.';

  @override
  String get ideasRetroPosterStep3 =>
      'Rellena las formas siguientes y deja un hilo de papel entre los colores.';

  @override
  String get ideasRetroPosterStep4 =>
      'Usa el tercer color en las formas más pequeñas.';

  @override
  String get ideasRetroPosterStep5 =>
      'Dibuja las sombras como formas planas aparte con el rotulador oscuro.';

  @override
  String get ideasRetroPosterStep6 =>
      'Añade unas pocas líneas de rotulador calibrado donde las tendría el cartel impreso.';

  @override
  String get ideasFreshCitrusTitle => 'Fresco y cítrico';

  @override
  String get ideasFreshCitrusSummary =>
      'Un limón, una lima y un vaso de agua, con mucho papel blanco y como mucho dos capas.';

  @override
  String get ideasFreshCitrusPractice =>
      'Color brillante sobre blanco, acabado pronto.';

  @override
  String get ideasFreshCitrusSubject =>
      'Un limón, una lima y un vaso de agua sobre una mesa.';

  @override
  String get ideasFreshCitrusTip =>
      'Para en la segunda capa: una tercera le quita lo fresco al color.';

  @override
  String get ideasFreshCitrusStep1 =>
      'Dibuja a lápiz la fruta y el vaso, y deja la composición aireada.';

  @override
  String get ideasFreshCitrusStep2 =>
      'Colorea el limón con el amarillo en una pasada, dejando un brillo blanco.';

  @override
  String get ideasFreshCitrusStep3 =>
      'Colorea la lima con el verde, también en una pasada.';

  @override
  String get ideasFreshCitrusStep4 =>
      'El amarillo más oscuro en el lado en sombra del limón, y una segunda pasada de verde en el lado en sombra de la lima.';

  @override
  String get ideasFreshCitrusStep5 =>
      'Usa el azul pálido para el agua del vaso y una sombra pequeña bajo cada fruta.';

  @override
  String get ideasTropicalNoonTitle => 'Mediodía tropical';

  @override
  String get ideasTropicalNoonSummary =>
      'Hojas grandes, una flor rosa intenso y un trozo de cielo azul, saturados y de borde duro.';

  @override
  String get ideasTropicalNoonPractice =>
      'Color fuerte y plano con solapes nítidos, sin fundir nada.';

  @override
  String get ideasTropicalNoonSubject =>
      'Dos o tres hojas grandes superpuestas, una flor y el cielo en los huecos.';

  @override
  String get ideasTropicalNoonTip =>
      'Deja el borde de cada hoja nítido: el solape es lo que da profundidad aquí.';

  @override
  String get ideasTropicalNoonStep1 =>
      'Dibuja a lápiz dos o tres hojas grandes superpuestas, una flor y el cielo en los huecos.';

  @override
  String get ideasTropicalNoonStep2 =>
      'Colorea las hojas con el verde claro, siguiendo las nervaduras.';

  @override
  String get ideasTropicalNoonStep3 =>
      'Pon el verde medio en las hojas de detrás y debajo de las otras, con bordes duros donde se solapan.';

  @override
  String get ideasTropicalNoonStep4 =>
      'Colorea el rosa intenso de la flor, con dos capas.';

  @override
  String get ideasTropicalNoonStep5 =>
      'Colorea el cielo azul en los huecos, hasta el borde de las hojas.';

  @override
  String get ideasGreenhouseLightTitle => 'En el invernadero';

  @override
  String get ideasGreenhouseLightSummary =>
      'Plantas detrás del cristal con una luz verde y húmeda, y cristales gris pálido.';

  @override
  String get ideasGreenhouseLightPractice =>
      'Una veladura pálida sobre la escena, como un velo de cristal.';

  @override
  String get ideasGreenhouseLightSubject =>
      'Un muro de cristal con sus barrotes y macetas de plantas detrás.';

  @override
  String get ideasGreenhouseLightTip =>
      'La veladura verde va al final: es la luz húmeda del sitio, no el color de las plantas.';

  @override
  String get ideasGreenhouseLightStep1 =>
      'Dibuja a lápiz un muro de cristal con sus barrotes y macetas de plantas detrás.';

  @override
  String get ideasGreenhouseLightStep2 =>
      'Colorea las plantas con el verde base, más suave cuanto más lejos estén tras el cristal.';

  @override
  String get ideasGreenhouseLightStep3 =>
      'Reserva el verde oscuro solo para las hojas más cercanas.';

  @override
  String get ideasGreenhouseLightStep4 =>
      'Usa el gris claro para los barrotes y para los reflejos en los cristales.';

  @override
  String get ideasGreenhouseLightStep5 =>
      'Cuando esté seco, pasa una veladura de verde pálido por toda la zona del cristal: la luz de dentro es verde.';

  @override
  String get ideasDustyAtticTitle => 'Desván polvoriento';

  @override
  String get ideasDustyAtticSummary =>
      'Grises cálidos, un baúl viejo y un rayo de luz con polvo dentro.';

  @override
  String get ideasDustyAtticPractice =>
      'Una habitación gris con un solo sitio brillante sin tocar.';

  @override
  String get ideasDustyAtticSubject =>
      'Una ventana pequeña y alta, el rayo de luz que lanza y un baúl viejo dentro.';

  @override
  String get ideasDustyAtticTip =>
      'Que el rayo de luz sea lo más brillante del dibujo: es el único papel blanco que queda.';

  @override
  String get ideasDustyAtticStep1 =>
      'Dibuja a lápiz una ventana pequeña arriba, el rayo de luz que lanza y un baúl dentro.';

  @override
  String get ideasDustyAtticStep2 =>
      'Cubre todo con el gris cálido más claro, menos el interior del rayo de luz.';

  @override
  String get ideasDustyAtticStep3 =>
      'Pon el gris cálido medio en las paredes lejos de la ventana y en los lados del baúl.';

  @override
  String get ideasDustyAtticStep4 =>
      'Usa el gris más oscuro en los rincones y bajo el baúl.';

  @override
  String get ideasDustyAtticStep5 =>
      'Añade una veladura amarilla pálida dentro del rayo de luz.';

  @override
  String get ideasDustyAtticStep6 =>
      'Cuando esté seco, añade unos puntos de gel blanco de polvo en el rayo de luz.';

  @override
  String get ideasColourGreyBlackTitle => 'Color, gris y negro';

  @override
  String get ideasColourGreyBlackSummary =>
      'Solo tres rotuladores: un color, un gris y uno muy oscuro.';

  @override
  String get ideasColourGreyBlackPractice =>
      'Colocar la luz con el mínimo de rotuladores.';

  @override
  String get ideasColourGreyBlackSubject =>
      'Una bicicleta, una bota o una tetera de un solo color.';

  @override
  String get ideasColourGreyBlackTip =>
      'Con tres puntas no hay nada que decidir salvo dónde va la luz. Planea la luz primero.';

  @override
  String get ideasColourGreyBlackStep1 =>
      'Elige un motivo de un solo color principal y marca a lápiz de dónde viene la luz.';

  @override
  String get ideasColourGreyBlackStep2 =>
      'Colorea todo el motivo con el color y dale dos capas donde se aparta de la luz.';

  @override
  String get ideasColourGreyBlackStep3 =>
      'Usa el gris para la sombra proyectada y para todo lo que no sea el motivo.';

  @override
  String get ideasColourGreyBlackStep4 =>
      'Reserva el rotulador oscuro para las líneas de contacto y los rincones más profundos.';

  @override
  String get ideasColourGreyBlackStep5 =>
      'Aléjate un poco: el dibujo se lee con solo tres valores y el gris los mantiene unidos.';

  @override
  String get ideasAnalogousTrioTitle => 'Tres vecinos';

  @override
  String get ideasAnalogousTrioSummary =>
      'Tres colores contiguos en la rueda, y nada del otro lado.';

  @override
  String get ideasAnalogousTrioPractice =>
      'Montar un esquema con tonos vecinos.';

  @override
  String get ideasAnalogousTrioSubject =>
      'Un girasol, el mar o un campo de un solo color.';

  @override
  String get ideasAnalogousTrioTip =>
      'Los colores vecinos se funden en húmedo sin volverse grises. Déjalos húmedos y que se mezclen.';

  @override
  String get ideasAnalogousTrioStep1 =>
      'Elige un motivo que sea de un solo color por naturaleza, como un girasol o el mar, y dibújalo.';

  @override
  String get ideasAnalogousTrioStep2 =>
      'Cubre la mayor parte del motivo con el color central de los tres.';

  @override
  String get ideasAnalogousTrioStep3 =>
      'Pon el vecino del lado iluminado y funde con el color central mientras esté húmedo.';

  @override
  String get ideasAnalogousTrioStep4 =>
      'Usa el otro vecino en las sombras, lejos de la luz.';

  @override
  String get ideasAnalogousTrioStep5 =>
      'Añade el oscuro del color central solo en los sitios más profundos y deja el resto con los tres colores.';

  @override
  String get ideasTriadTitle => 'Una tríada';

  @override
  String get ideasTriadSummary =>
      'Tres colores equidistantes en la rueda: uno manda y los otros dos apoyan.';

  @override
  String get ideasTriadPractice =>
      'Usar un esquema de tres colores con uno al mando.';

  @override
  String get ideasTriadSubject =>
      'Un cartel, una portada o una flor grande con detalles pequeños.';

  @override
  String get ideasTriadTip =>
      'Mantén los tres colores separados en el papel. Un gris sobre los tres ata el esquema.';

  @override
  String get ideasTriadStep1 =>
      'Decide cuál de los tres colores manda: ese se lleva la mayor parte del papel.';

  @override
  String get ideasTriadStep2 =>
      'Colorea las zonas principales con el color que manda.';

  @override
  String get ideasTriadStep3 =>
      'Usa el segundo color en una cuarta parte del dibujo y no lo dejes tocar el primero en húmedo.';

  @override
  String get ideasTriadStep4 =>
      'Usa el tercer color solo en unos pocos puntos pequeños.';

  @override
  String get ideasTriadStep5 =>
      'Sombrea los tres colores con el mismo gris para que vayan juntos.';

  @override
  String get ideasSplitComplementTitle => 'Complemento dividido';

  @override
  String get ideasSplitComplementSummary =>
      'Una familia de color y los dos colores a los lados de su opuesto.';

  @override
  String get ideasSplitComplementPractice =>
      'Equilibrar una familia principal con dos colores cercanos a su opuesto.';

  @override
  String get ideasSplitComplementSubject =>
      'Un jarrón con dos flores o una taza con dos objetos pequeños al lado.';

  @override
  String get ideasSplitComplementTip =>
      'Un casi opuesto parece choque o armonía según la cantidad que uses de él.';

  @override
  String get ideasSplitComplementStep1 =>
      'Dibuja un motivo con una zona grande y dos pequeñas, como un jarrón con dos flores.';

  @override
  String get ideasSplitComplementStep2 =>
      'Cubre la zona grande con el tono claro de la familia principal.';

  @override
  String get ideasSplitComplementStep3 =>
      'Añade su sombra donde no llega la luz.';

  @override
  String get ideasSplitComplementStep4 =>
      'Usa uno de los dos opuestos en la primera zona pequeña.';

  @override
  String get ideasSplitComplementStep5 =>
      'Usa el otro opuesto en la segunda zona pequeña y mantén las dos separadas.';

  @override
  String get ideasTwoGrayTemperaturesTitle => 'Grises cálidos, grises fríos';

  @override
  String get ideasTwoGrayTemperaturesSummary =>
      'Colorea la misma piedra dos veces, con grises cálidos y con grises fríos.';

  @override
  String get ideasTwoGrayTemperaturesPractice =>
      'Distinguir a ojo un gris cálido de un gris frío.';

  @override
  String get ideasTwoGrayTemperaturesSubject =>
      'La misma piedra o una tela plegada, dibujada dos veces una al lado de la otra.';

  @override
  String get ideasTwoGrayTemperaturesTip =>
      'La mayoría de marcas venden los grises cálidos, fríos y neutros como familias aparte. Elige una familia para cada mitad.';

  @override
  String get ideasTwoGrayTemperaturesStep1 =>
      'Dibuja a lápiz la misma piedra dos veces, una al lado de la otra, y marca la luz en cada una.';

  @override
  String get ideasTwoGrayTemperaturesStep2 =>
      'Primera piedra: el gris cálido claro por toda la superficie.';

  @override
  String get ideasTwoGrayTemperaturesStep3 =>
      'Añade el gris cálido más oscuro en el lado de la sombra y oscurece el contacto con el suelo.';

  @override
  String get ideasTwoGrayTemperaturesStep4 =>
      'Segunda piedra: el gris frío claro por toda la superficie.';

  @override
  String get ideasTwoGrayTemperaturesStep5 =>
      'Añade el gris frío más oscuro igual que antes y compara: una piedra parece estar al sol y la otra en la sombra.';

  @override
  String get ideasGrayPlusAccentTitle => 'Gris con un acento';

  @override
  String get ideasGrayPlusAccentSummary =>
      'Todo en gris menos una cosa pequeña en color.';

  @override
  String get ideasGrayPlusAccentPractice =>
      'Hacer que un solo color cargue con todo el dibujo.';

  @override
  String get ideasGrayPlusAccentSubject =>
      'Una calle con una puerta roja o un paraguas amarillo en un pueblo gris.';

  @override
  String get ideasGrayPlusAccentTip =>
      'El acento quiere ser lo más fuerte posible: dos capas del mismo rotulador.';

  @override
  String get ideasGrayPlusAccentStep1 =>
      'Dibuja una escena con un objeto al que quieras llevar la mirada, como una puerta roja en una calle.';

  @override
  String get ideasGrayPlusAccentStep2 =>
      'Cubre todo menos ese objeto con el gris claro.';

  @override
  String get ideasGrayPlusAccentStep3 =>
      'Pon el gris medio en las sombras, como si la escena fuera una foto.';

  @override
  String get ideasGrayPlusAccentStep4 =>
      'Usa el gris más oscuro en las ventanas, bajo los aleros y en las líneas de contacto.';

  @override
  String get ideasGrayPlusAccentStep5 =>
      'Colorea solo el objeto, con dos capas para que el acento sea lo más fuerte posible.';

  @override
  String get ideasEarthTonesTitle => 'Tonos tierra';

  @override
  String get ideasEarthTonesSummary =>
      'Marrones, ocres y un verde oliva, nada brillante.';

  @override
  String get ideasEarthTonesPractice =>
      'Superponer colores de poco croma sin que se apaguen.';

  @override
  String get ideasEarthTonesSubject => 'Pan, una cesta o un campo labrado.';

  @override
  String get ideasEarthTonesTip =>
      'Los colores de poco croma se superponen bien porque el papel sigue iluminándolos por debajo.';

  @override
  String get ideasEarthTonesStep1 =>
      'Dibuja algo que venga de la tierra, como pan, una cesta o un campo labrado.';

  @override
  String get ideasEarthTonesStep2 =>
      'Cubre todo con el ocre claro como primera capa.';

  @override
  String get ideasEarthTonesStep3 =>
      'Añade el marrón donde la forma se aparta de la luz.';

  @override
  String get ideasEarthTonesStep4 =>
      'Pon el verde oliva en lo que sea verde y deja que el ocre de debajo lo apague.';

  @override
  String get ideasEarthTonesStep5 =>
      'Reserva el marrón más oscuro solo para los sitios más profundos.';

  @override
  String get ideasJewelTonesTitle => 'Tonos joya';

  @override
  String get ideasJewelTonesSummary =>
      'Colores profundos y saturados con un acento dorado, como una caja de terciopelo.';

  @override
  String get ideasJewelTonesPractice =>
      'Pintar colores oscuros saturados que conservan el brillo.';

  @override
  String get ideasJewelTonesSubject =>
      'Unas gemas o botellas con un brillo planeado en cada una.';

  @override
  String get ideasJewelTonesTip =>
      'La tinta oscura saturada sigue brillando en el papel para rotuladores. Un punto de gel blanco encima da el aspecto de cristal.';

  @override
  String get ideasJewelTonesStep1 =>
      'Dibuja unas gemas o botellas sencillas y planea un brillo en cada una.';

  @override
  String get ideasJewelTonesStep2 =>
      'Cubre la forma más grande con el verde azulado profundo, en dos capas.';

  @override
  String get ideasJewelTonesStep3 =>
      'Usa el violeta profundo en la siguiente forma.';

  @override
  String get ideasJewelTonesStep4 => 'Usa el rojo profundo en la más pequeña.';

  @override
  String get ideasJewelTonesStep5 =>
      'Añade el amarillo dorado en las monturas o las tapas y luego un punto de gel blanco en cada brillo.';

  @override
  String get ideasLowKeyTitle => 'Solo rotuladores oscuros';

  @override
  String get ideasLowKeySummary =>
      'Dibuja con rotuladores más oscuros que el gris medio y deja que un poco de papel lleve toda la luz.';

  @override
  String get ideasLowKeyPractice =>
      'Pintar un dibujo oscuro dejando la luz en blanco a propósito.';

  @override
  String get ideasLowKeySubject =>
      'Un gato con los ojos iluminados, una lámpara en una habitación oscura o un perfil.';

  @override
  String get ideasLowKeyTip =>
      'La tinta de alcohol oscura cubre uniforme en una pasada, así que las formas blancas que dejes quedan limpias.';

  @override
  String get ideasLowKeyStep1 =>
      'Planea el dibujo como unas formas de papel que quedan blancas sobre un fondo oscuro: los ojos de un gato, una lámpara, un perfil.';

  @override
  String get ideasLowKeyStep2 =>
      'Cubre todo menos las formas blancas con el rotulador menos oscuro.';

  @override
  String get ideasLowKeyStep3 =>
      'Usa el rotulador intermedio en las sombras grandes.';

  @override
  String get ideasLowKeyStep4 =>
      'Pon el rotulador más oscuro en los bordes de las formas claras, para que brillen por contraste.';

  @override
  String get ideasLowKeyStep5 =>
      'Añade gel blanco solo en uno o dos puntos, no más.';

  @override
  String get ideasComplementGradientTitle => 'Por el medio';

  @override
  String get ideasComplementGradientSummary =>
      'Funde dos colores opuestos uno en otro y mira el gris que forman donde se encuentran.';

  @override
  String get ideasComplementGradientPractice =>
      'Mezclar dos colores sobre el papel y leer el resultado.';

  @override
  String get ideasComplementGradientSubject =>
      'Una tira larga de papel donde los dos colores se encuentran en el centro.';

  @override
  String get ideasComplementGradientTip =>
      'Los opuestos húmedos se mezclan en el papel al momento. Mantén los dos húmedos y deja que se encuentren en el centro.';

  @override
  String get ideasComplementGradientStep1 =>
      'Pega con cinta una tira larga de papel.';

  @override
  String get ideasComplementGradientStep2 =>
      'Rellena el tercio izquierdo y difumina el color hacia el centro.';

  @override
  String get ideasComplementGradientStep3 =>
      'Rellena el tercio derecho y difumínalo hacia el centro mientras el primero sigue húmedo.';

  @override
  String get ideasComplementGradientStep4 =>
      'Compara el centro turbio con un trazo de tu gris al lado.';

  @override
  String get ideasComplementGradientStep5 =>
      'Repite la tira poniendo primero el gris en el centro y fundiendo los dos colores hacia él: un paso más limpio.';

  @override
  String get ideasWarmLightCoolShadowTitle => 'Luz cálida, sombra fría';

  @override
  String get ideasWarmLightCoolShadowSummary =>
      'Un objeto, el lado iluminado en colores cálidos y el lado en sombra en fríos.';

  @override
  String get ideasWarmLightCoolShadowPractice =>
      'Superponer cálido y frío sobre un mismo color base.';

  @override
  String get ideasWarmLightCoolShadowSubject =>
      'Una fruta redonda, un huevo o una pelota.';

  @override
  String get ideasWarmLightCoolShadowTip =>
      'Deja una franja fina del color base entre el cálido y el frío: así la forma sigue girando.';

  @override
  String get ideasWarmLightCoolShadowStep1 =>
      'Dibuja un objeto redondo y marca de dónde viene la luz.';

  @override
  String get ideasWarmLightCoolShadowStep2 =>
      'Cubre todo el objeto con su propio color.';

  @override
  String get ideasWarmLightCoolShadowStep3 =>
      'Superpón el color cálido en la mitad iluminada y funde con la base mientras esté húmeda.';

  @override
  String get ideasWarmLightCoolShadowStep4 =>
      'Superpón el color frío en la mitad en sombra y deja una franja fina de base entre las dos.';

  @override
  String get ideasWarmLightCoolShadowStep5 =>
      'Reserva el rotulador más oscuro solo para el contacto con el suelo.';

  @override
  String get ideasVividAndMutedTitle => 'Vivo y apagado';

  @override
  String get ideasVividAndMutedSummary =>
      'Colorea la misma flor con una pareja viva y después con una pareja apagada del mismo tono.';

  @override
  String get ideasVividAndMutedPractice =>
      'Distinguir un color vivo de su versión apagada.';

  @override
  String get ideasVividAndMutedSubject =>
      'La misma flor dibujada dos veces, una al lado de la otra.';

  @override
  String get ideasVividAndMutedTip =>
      'La mayoría de gamas tienen una versión viva y otra apagada de cada tono. Elegir entre las dos es todo el ejercicio.';

  @override
  String get ideasVividAndMutedStep1 =>
      'Dibuja a lápiz la misma flor dos veces, una al lado de la otra.';

  @override
  String get ideasVividAndMutedStep2 => 'Primera flor: el tono claro y vivo.';

  @override
  String get ideasVividAndMutedStep3 => 'Añade la sombra viva del mismo tono.';

  @override
  String get ideasVividAndMutedStep4 =>
      'Segunda flor: el tono claro y apagado del mismo color.';

  @override
  String get ideasVividAndMutedStep5 =>
      'Añade su sombra apagada y decide qué flor iría en primer plano en un dibujo y cuál en el fondo.';

  @override
  String get ideasOneMarkerBlenderTitle => 'Un rotulador y el difuminador';

  @override
  String get ideasOneMarkerBlenderSummary =>
      'Cuatro valores con un solo rotulador oscuro, diluyéndolo con el difuminador incoloro.';

  @override
  String get ideasOneMarkerBlenderPractice =>
      'Diluir la tinta para lograr valores más claros sin otro rotulador.';

  @override
  String get ideasOneMarkerBlenderSubject =>
      'Cuatro cuadrados de papel pegados con cinta uno al lado del otro.';

  @override
  String get ideasOneMarkerBlenderTip =>
      'El difuminador es disolvente puro: convierte un solo rotulador oscuro en su propia familia clara.';

  @override
  String get ideasOneMarkerBlenderStep1 =>
      'Pega con cinta cuatro cuadrados pequeños de papel uno al lado del otro.';

  @override
  String get ideasOneMarkerBlenderStep2 =>
      'Rellena el primer cuadrado con el rotulador a plena intensidad.';

  @override
  String get ideasOneMarkerBlenderStep3 =>
      'Segundo cuadrado: un trazo de rotulador y luego el difuminador encima mientras esté húmedo.';

  @override
  String get ideasOneMarkerBlenderStep4 =>
      'Tercer cuadrado: difuminador primero y luego rotulador sobre el difuminador húmedo. Cuarto: toca el rotulador en la punta del difuminador y pinta solo con el difuminador.';

  @override
  String get ideasOneMarkerBlenderStep5 =>
      'Ponlos en fila: una escalera de cuatro escalones con un solo rotulador.';

  @override
  String get ideasColourWheelTitle => 'Tu rueda de color';

  @override
  String get ideasColourWheelSummary =>
      'Coloca doce de tus rotuladores en forma de rueda y encuentra los huecos de tu colección.';

  @override
  String get ideasColourWheelPractice =>
      'Leer una rueda de color con los rotuladores que tienes.';

  @override
  String get ideasColourWheelSubject =>
      'Un círculo de unos diez centímetros de diámetro, dividido en doce sectores.';

  @override
  String get ideasColourWheelTip =>
      'Una rueda de rotuladores es una lista de la compra y una guía de mezclas en una sola página.';

  @override
  String get ideasColourWheelStep1 =>
      'Dibuja un círculo siguiendo el borde de una taza y divídelo en doce sectores.';

  @override
  String get ideasColourWheelStep2 =>
      'Elige el rotulador más cercano al amarillo puro, luego al rojo y luego al azul, y rellena sus sectores, separados cuatro sectores entre sí.';

  @override
  String get ideasColourWheelStep3 =>
      'Rellena los sectores intermedios con los rotuladores más cercanos que tengas: naranja, verde, violeta y luego los seis de entremedios.';

  @override
  String get ideasColourWheelStep4 =>
      'Escribe el código de cada rotulador bajo su sector. Un sector vacío o dudoso es un rotulador que quizá quieras después.';

  @override
  String get ideasDeepSkinTitle => 'Tonos de piel profunda';

  @override
  String get ideasDeepSkinSummary =>
      'Colorea una cara en tonos de piel profundos, con una luz cálida y un colorete rojizo.';

  @override
  String get ideasDeepSkinPractice =>
      'Sombrear piel profunda con un recorrido largo de un solo tono.';

  @override
  String get ideasDeepSkinSubject =>
      'Una cara de tres cuartos, iluminada de frente.';

  @override
  String get ideasDeepSkinTip =>
      'La piel profunda necesita un recorrido largo de claridad en un solo tono, y las familias de rotuladores están hechas para eso.';

  @override
  String get ideasDeepSkinStep1 =>
      'Dibuja a lápiz una cara y marca la frente, la nariz y los pómulos como las zonas iluminadas.';

  @override
  String get ideasDeepSkinStep2 =>
      'Cubre toda la cara con el marrón más claro.';

  @override
  String get ideasDeepSkinStep3 =>
      'Mientras la primera capa esté húmeda, añade el marrón rojizo en las mejillas y los labios.';

  @override
  String get ideasDeepSkinStep4 =>
      'Añade el marrón base en toda la cara menos las zonas iluminadas.';

  @override
  String get ideasDeepSkinStep5 =>
      'Usa el rotulador más oscuro bajo las cejas, la nariz, el labio inferior y la mandíbula, y deja las zonas iluminadas solo con la primera capa.';

  @override
  String get ideasBlackObjectTitle => 'Negro sin negro';

  @override
  String get ideasBlackObjectSummary =>
      'Colorea un gato o una bota negros con azules y violetas oscuros, y guarda el negro para el final.';

  @override
  String get ideasBlackObjectPractice =>
      'Construir un objeto oscuro con colores oscuros en vez de negro.';

  @override
  String get ideasBlackObjectSubject =>
      'Un gato negro, una bota o una tetera brillante.';

  @override
  String get ideasBlackObjectTip =>
      'Un rotulador negro plano mata el volumen. Los colores oscuros superpuestos lo conservan.';

  @override
  String get ideasBlackObjectStep1 =>
      'Dibuja a lápiz el objeto y la forma de sus reflejos: las cosas negras reflejan el cielo y la habitación.';

  @override
  String get ideasBlackObjectStep2 =>
      'Usa el gris azulado frío y claro en los reflejos y en las caras superiores.';

  @override
  String get ideasBlackObjectStep3 =>
      'Cubre la mayor parte del objeto con el azul oscuro.';

  @override
  String get ideasBlackObjectStep4 =>
      'Usa el violeta oscuro en la parte de abajo.';

  @override
  String get ideasBlackObjectStep5 =>
      'Reserva el rotulador más oscuro para los pliegues más profundos y añade un brillo de gel blanco si la superficie es brillante.';

  @override
  String get ideasWhiteObjectTitle => 'Blanco sin blanco';

  @override
  String get ideasWhiteObjectSummary =>
      'Una taza o un huevo blanco con grises pálidos, una sombra con color y mucho papel sin tocar.';

  @override
  String get ideasWhiteObjectPractice =>
      'Pintar un objeto blanco sin pintar el papel.';

  @override
  String get ideasWhiteObjectSubject =>
      'Una taza blanca, un huevo o una servilleta plegada.';

  @override
  String get ideasWhiteObjectTip =>
      'Un objeto blanco es sobre todo papel. Los rotuladores agradecen que no lo pintes.';

  @override
  String get ideasWhiteObjectStep1 =>
      'Dibuja a lápiz el objeto y marca el lado iluminado: ese lado se queda como papel.';

  @override
  String get ideasWhiteObjectStep2 =>
      'Usa el rotulador pálido con un toque de color solo en el lado en sombra.';

  @override
  String get ideasWhiteObjectStep3 =>
      'Pon el gris claro dentro, hacia la parte más oscura.';

  @override
  String get ideasWhiteObjectStep4 =>
      'Usa el gris frío algo más oscuro solo en el borde más alejado de la luz y donde el objeto toca la mesa.';

  @override
  String get ideasWhiteObjectStep5 =>
      'Añade un toque del color de la mesa reflejado en la parte de abajo del objeto.';

  @override
  String get ideasFeatheredEdgeTitle => 'Borde difuminado';

  @override
  String get ideasFeatheredEdgeSummary =>
      'Haz que un lado de una forma se desvanezca en el papel blanco y el otro quede nítido.';

  @override
  String get ideasFeatheredEdgePractice =>
      'Un borde suave junto a uno duro: la manera más sencilla de dar luz a una forma.';

  @override
  String get ideasFeatheredEdgeSubject =>
      'Una hoja, un pétalo o un pliegue de tela.';

  @override
  String get ideasFeatheredEdgeTip =>
      'Levanta la punta al avanzar: la tinta se acaba sola en el trazo.';

  @override
  String get ideasFeatheredEdgeStep1 =>
      'Dibuja a lápiz una hoja y decide qué borde recibe la luz.';

  @override
  String get ideasFeatheredEdgeStep2 =>
      'Colorea el borde oscuro con la base en trazos cortos que apuntan todos hacia el lado iluminado.';

  @override
  String get ideasFeatheredEdgeStep3 =>
      'Pasa el rotulador claro desde el centro hacia fuera sobre los finales de esos trazos, levantando la punta para que cada trazo se apague.';

  @override
  String get ideasFeatheredEdgeStep4 =>
      'Vuelve a pasar por la unión, siempre del color al blanco.';

  @override
  String get ideasFeatheredEdgeStep5 =>
      'Compara los dos bordes: uno suave, uno duro. Ese contraste es lo que hace que la forma se lea.';

  @override
  String get ideasTipToTipTitle => 'Punta contra punta';

  @override
  String get ideasTipToTipSummary =>
      'Carga un color oscuro en la punta de un rotulador claro y haz un degradado de una sola pasada.';

  @override
  String get ideasTipToTipPractice =>
      'Robar tinta de un rotulador a otro para un degradado rápido.';

  @override
  String get ideasTipToTipSubject =>
      'Una tira de papel del ancho de dos dedos.';

  @override
  String get ideasTipToTipTip =>
      'Sujeta el rotulador oscuro quieto: la punta clara solo toma tinta de la punta.';

  @override
  String get ideasTipToTipStep1 =>
      'Marca con cinta una tira de unos dos dedos de ancho.';

  @override
  String get ideasTipToTipStep2 =>
      'Sujeta el rotulador oscuro quieto y apoya la punta del claro encima un par de segundos.';

  @override
  String get ideasTipToTipStep3 =>
      'Empieza por abajo de la tira con la punta cargada: los primeros trazos son oscuros y luego vuelve el color del rotulador.';

  @override
  String get ideasTipToTipStep4 =>
      'Garabatea la punta en un papel aparte hasta que vuelva a salir limpia: el rotulador claro no se estropea.';

  @override
  String get ideasTipToTipStep5 =>
      'Repite en otra tira cargando la punta más tiempo: la parte oscura llega más lejos.';

  @override
  String get ideasBlenderPatternTitle => 'Patrones con difuminador';

  @override
  String get ideasBlenderPatternSummary =>
      'Levanta puntos y líneas de un color plano con el difuminador incoloro.';

  @override
  String get ideasBlenderPatternPractice =>
      'Mover tinta en vez de borrarla: puntos, líneas y patrones.';

  @override
  String get ideasBlenderPatternSubject =>
      'Un cuadrado de color donde dibujar el patrón.';

  @override
  String get ideasBlenderPatternTip =>
      'Espera entre toques: dos marcas muy juntas se unen.';

  @override
  String get ideasBlenderPatternStep1 =>
      'Rellena un cuadrado con la base y deja que se seque del todo.';

  @override
  String get ideasBlenderPatternStep2 =>
      'Presiona la punta fina del difuminador en el color y mantenla un segundo: se abre un punto claro con un borde más oscuro.';

  @override
  String get ideasBlenderPatternStep3 =>
      'Dibuja una línea con la punta ancha del difuminador: la tinta empujada se acumula en los bordes.';

  @override
  String get ideasBlenderPatternStep4 =>
      'Haz un patrón: puntos, rayas o una hilera de escamas.';

  @override
  String get ideasBlenderPatternStep5 =>
      'Espera entre toques o los puntos se juntan.';

  @override
  String get ideasOneMarkerLayersTitle => 'Un rotulador, tres capas';

  @override
  String get ideasOneMarkerLayersSummary =>
      'Sombrea un cubo con un solo rotulador superponiendo una, dos y tres capas.';

  @override
  String get ideasOneMarkerLayersPractice =>
      'Cuánto recorrido tiene un rotulador cuando las capas se secan una sobre otra.';

  @override
  String get ideasOneMarkerLayersSubject =>
      'Un cubo con la luz desde una esquina de arriba.';

  @override
  String get ideasOneMarkerLayersTip =>
      'Deja secar cada capa: una segunda pasada en húmedo mueve la tinta en vez de oscurecerla.';

  @override
  String get ideasOneMarkerLayersStep1 =>
      'Dibuja a lápiz un cubo con la luz desde una esquina de arriba.';

  @override
  String get ideasOneMarkerLayersStep2 =>
      'Una pasada en cada cara. Deja secar.';

  @override
  String get ideasOneMarkerLayersStep3 =>
      'Una segunda pasada en las dos caras alejadas de la luz.';

  @override
  String get ideasOneMarkerLayersStep4 =>
      'Una tercera pasada solo en la cara más oscura y en los bordes de abajo.';

  @override
  String get ideasOneMarkerLayersStep5 =>
      'Mira los tres valores: ese es el recorrido de un solo rotulador.';

  @override
  String get ideasStipplePeelTitle => 'Piel de naranja punteada';

  @override
  String get ideasStipplePeelSummary =>
      'Crea la textura de hoyitos de la piel de un cítrico con puntos sobre un degradado.';

  @override
  String get ideasStipplePeelPractice =>
      'Puntear sobre un degradado seco, sin emborronarlo.';

  @override
  String get ideasStipplePeelSubject =>
      'Una naranja con un brillo suave en su parte de arriba.';

  @override
  String get ideasStipplePeelTip => 'Usa la punta fina: da motas limpias.';

  @override
  String get ideasStipplePeelStep1 =>
      'Dibuja a lápiz una naranja y un brillo suave en su parte de arriba.';

  @override
  String get ideasStipplePeelStep2 =>
      'Rellena la naranja dejando el brillo más claro.';

  @override
  String get ideasStipplePeelStep3 =>
      'Funde la base en la mitad de la sombra mientras está húmedo.';

  @override
  String get ideasStipplePeelStep4 =>
      'Cuando esté seco, da toques con la punta fina del rotulador oscuro: puntos sueltos, más juntos en la sombra y casi ninguno junto al brillo.';

  @override
  String get ideasStipplePeelStep5 =>
      'Da unos toques claros dentro de los puntos oscuros para romperlos.';

  @override
  String get ideasClearGlassTitle => 'Un vaso de cristal';

  @override
  String get ideasClearGlassSummary =>
      'Colorea un vaso vacío con grises y casi nada más.';

  @override
  String get ideasClearGlassPractice =>
      'Gris y papel blanco: la manera más ligera de dibujar cristal.';

  @override
  String get ideasClearGlassSubject =>
      'Un vaso con el borde, la base y dos brillos verticales.';

  @override
  String get ideasClearGlassTip =>
      'El vidrio es más oscuro donde es más grueso: en el borde y en la base.';

  @override
  String get ideasClearGlassStep1 =>
      'Dibuja a lápiz el vaso y marca el borde, la base y dos brillos verticales que quedan en papel blanco.';

  @override
  String get ideasClearGlassStep2 =>
      'Colorea el vaso con el gris más claro, dejando los brillos y casi todo el centro en blanco.';

  @override
  String get ideasClearGlassStep3 =>
      'Oscurece el borde, la base gruesa y el canto lejano: el vidrio es más oscuro donde es más grueso.';

  @override
  String get ideasClearGlassStep4 =>
      'Pon una mancha de color detrás del vaso y deja que una versión más pálida se vea a través del vaso, sobre el gris claro.';

  @override
  String get ideasClearGlassStep5 =>
      'Gel blanco en el borde y en la base para los brillos más nítidos.';

  @override
  String get ideasPolishedMetalTitle => 'Metal pulido';

  @override
  String get ideasPolishedMetalSummary =>
      'Haz que una cuchara parezca metal con bandas duras de gris y un color reflejado.';

  @override
  String get ideasPolishedMetalPractice =>
      'Bandas de borde nítido y un recorrido largo de valores: así se lee el metal.';

  @override
  String get ideasPolishedMetalSubject =>
      'Una cuchara con las bandas de su reflejo ya dibujadas.';

  @override
  String get ideasPolishedMetalTip =>
      'El metal no tiene transiciones suaves: deja los bordes de las bandas nítidos.';

  @override
  String get ideasPolishedMetalStep1 =>
      'Dibuja a lápiz la cuchara y sus reflejos como bandas: una oscura cruzando el cuenco, otra clara al lado, sin transiciones suaves.';

  @override
  String get ideasPolishedMetalStep2 =>
      'Rellena el cuenco y el mango con el gris más claro.';

  @override
  String get ideasPolishedMetalStep3 =>
      'Pon las bandas oscuras con bordes nítidos, siguiendo la curva del cuenco.';

  @override
  String get ideasPolishedMetalStep4 =>
      'Pon el gris más oscuro justo junto a la banda más clara: el metal vive de ese contraste.';

  @override
  String get ideasPolishedMetalStep5 =>
      'Deja que una mancha del color de la mesa se refleje en la mitad de abajo del cuenco y pon gel blanco en el brillo más nítido.';

  @override
  String get ideasCastShadowTitle => 'La sombra sobre la mesa';

  @override
  String get ideasCastShadowSummary =>
      'Dibuja una taza y acierta con su sombra proyectada: oscura en el contacto, suave más lejos.';

  @override
  String get ideasCastShadowPractice =>
      'Sombras proyectadas: la línea de contacto, el degradado y el gris que las dibuja.';

  @override
  String get ideasCastShadowSubject =>
      'Una taza sobre una mesa, con la luz desde un lado.';

  @override
  String get ideasCastShadowTip =>
      'La sombra empieza donde el objeto toca la mesa, no donde acaba la luz.';

  @override
  String get ideasCastShadowStep1 =>
      'Dibuja a lápiz una taza y la forma de su sombra en la mesa, más larga en el lado contrario a la luz.';

  @override
  String get ideasCastShadowStep2 =>
      'Colorea la taza y sombrea su lado lejano con el mismo rotulador en una segunda capa.';

  @override
  String get ideasCastShadowStep3 =>
      'Rellena la sombra proyectada con el gris, empezando en la base de la taza y levantando la punta según te alejas.';

  @override
  String get ideasCastShadowStep4 =>
      'Añade una línea oscura fina donde la taza toca la mesa.';

  @override
  String get ideasCastShadowStep5 =>
      'Suaviza el borde lejano de la sombra con otra pasada ligera de gris mientras la primera sigue húmeda.';

  @override
  String get ideasSoftCloudsTitle => 'Nubes suaves';

  @override
  String get ideasSoftCloudsSummary =>
      'Colorea el cielo alrededor de las nubes y deja las nubes como papel.';

  @override
  String get ideasSoftCloudsPractice =>
      'Pintar en negativo: la forma es el papel que no tocaste.';

  @override
  String get ideasSoftCloudsSubject =>
      'Dos o tres nubes con la parte de arriba redondeada y la de abajo más plana.';

  @override
  String get ideasSoftCloudsTip =>
      'Rodea las nubes con la punta ancha: sus bordes quedan irregulares.';

  @override
  String get ideasSoftCloudsStep1 =>
      'Dibuja a lápiz, muy suave, dos o tres nubes: arriba redondeadas, abajo más planas.';

  @override
  String get ideasSoftCloudsStep2 =>
      'Rellena el cielo con el azul claro, rodeando las nubes con la punta ancha para que sus bordes queden algo irregulares.';

  @override
  String get ideasSoftCloudsStep3 =>
      'Oscurece el cielo hacia arriba y funde hacia el azul claro mientras está húmedo.';

  @override
  String get ideasSoftCloudsStep4 =>
      'Sombrea la parte de abajo de cada nube con el gris claro, dejando arriba en blanco.';

  @override
  String get ideasSoftCloudsStep5 =>
      'Suaviza con el difuminador cualquier borde duro del cielo contra una nube, empujando el color hacia fuera.';

  @override
  String get ideasStillWaterTitle => 'Reflejo en agua quieta';

  @override
  String get ideasStillWaterSummary =>
      'Dibuja un árbol en la orilla y su copia invertida, algo más oscura, en el agua.';

  @override
  String get ideasStillWaterPractice =>
      'Superponer un color sobre otro: así se hace un reflejo.';

  @override
  String get ideasStillWaterSubject =>
      'Un árbol en la orilla con su reflejo en el agua de abajo.';

  @override
  String get ideasStillWaterTip =>
      'Pinta el reflejo solo con trazos horizontales: el agua se mueve de lado.';

  @override
  String get ideasStillWaterStep1 =>
      'Dibuja a lápiz una línea de horizonte, un árbol sencillo encima y su reflejo debajo.';

  @override
  String get ideasStillWaterStep2 =>
      'Colorea el árbol y su reflejo con el mismo rotulador, solo en trazos horizontales.';

  @override
  String get ideasStillWaterStep3 =>
      'Extiende el azul claro por todo el agua, incluido el reflejo, con trazos horizontales largos.';

  @override
  String get ideasStillWaterStep4 =>
      'Oscurece el agua cerca de la orilla y en el borde lejano; añade unas líneas horizontales rotas de base sobre el reflejo.';

  @override
  String get ideasStillWaterStep5 =>
      'Pon el azul oscuro donde la orilla toca el agua y añade dos o tres líneas finas de gel blanco para las ondas.';

  @override
  String get ideasTwistedRibbonTitle => 'Cinta retorcida';

  @override
  String get ideasTwistedRibbonSummary =>
      'Funde un degradado que se curva con una cinta al girarse sobre sí misma.';

  @override
  String get ideasTwistedRibbonPractice =>
      'Repetir un degradado corto en cada vuelta de una forma.';

  @override
  String get ideasTwistedRibbonSubject =>
      'Una cinta con dos vueltas, por encima y por debajo.';

  @override
  String get ideasTwistedRibbonTip =>
      'Funde siguiendo la curva de la cinta, nunca en recto.';

  @override
  String get ideasTwistedRibbonStep1 =>
      'Dibuja a lápiz una cinta con dos vueltas; marca qué tramos se ven por delante y cuáles por detrás.';

  @override
  String get ideasTwistedRibbonStep2 =>
      'Rellena cada tramo con el rotulador claro.';

  @override
  String get ideasTwistedRibbonStep3 =>
      'En cada tramo, pon la base en el lado que se curva hacia atrás, con trazos que sigan la curva y no rectos.';

  @override
  String get ideasTwistedRibbonStep4 =>
      'Oscurece solo donde un tramo pasa por debajo de otro, con una franja estrecha justo en el cruce.';

  @override
  String get ideasTwistedRibbonStep5 =>
      'Pasa el difuminador por cada franja donde el degradado se ve escalonado.';

  @override
  String get ideasNoLineLeafTitle => 'Colorear sin contorno';

  @override
  String get ideasNoLineLeafSummary =>
      'Colorea una hoja partiendo de un boceto a lápiz y deja que los bordes del color hagan de contorno.';

  @override
  String get ideasNoLineLeafPractice =>
      'Dibujar sin rotulador calibrado: el borde del color es el contorno.';

  @override
  String get ideasNoLineLeafSubject =>
      'Una hoja sencilla con su nervio central.';

  @override
  String get ideasNoLineLeafTip =>
      'Borra el lápiz con una goma blanda hasta que apenas se vea.';

  @override
  String get ideasNoLineLeafStep1 =>
      'Dibuja la hoja y su nervio central muy suave a lápiz y borra casi todo el grafito con una goma blanda hasta que apenas se vea.';

  @override
  String get ideasNoLineLeafStep2 =>
      'Rellena la hoja y para justo en la línea de lápiz.';

  @override
  String get ideasNoLineLeafStep3 =>
      'Sombrea media hoja y la base mientras la primera capa sigue húmeda.';

  @override
  String get ideasNoLineLeafStep4 =>
      'Define el borde del lado de la sombra con una línea fina del rotulador más oscuro, en vez de con un rotulador calibrado.';

  @override
  String get ideasNoLineLeafStep5 =>
      'Borra el lápiz que aún se vea cuando la tinta esté seca.';

  @override
  String get ideasShortFurTitle => 'Pelo corto';

  @override
  String get ideasShortFurSummary =>
      'Colorea la oreja de un gato con trazos cortos en dos direcciones.';

  @override
  String get ideasShortFurPractice =>
      'Trazos cortos que siguen la dirección del pelo.';

  @override
  String get ideasShortFurSubject =>
      'Una oreja de gato con unas flechas que marcan por dónde crece el pelo.';

  @override
  String get ideasShortFurTip =>
      'Trazos rápidos desde la raíz hacia fuera: apoya, mueve rápido y levanta.';

  @override
  String get ideasShortFurStep1 =>
      'Dibuja a lápiz la oreja y marca con unas flechas hacia dónde crece el pelo.';

  @override
  String get ideasShortFurStep2 =>
      'Rellena la oreja con el rotulador claro, con trazos rápidos hacia fuera en el borde para que quede peluda y no sólida.';

  @override
  String get ideasShortFurStep3 =>
      'Trazos cortos y rápidos de base desde el borde interior hacia fuera, siguiendo las flechas.';

  @override
  String get ideasShortFurStep4 =>
      'Menos trazos y más oscuros dentro de la oreja y en la base, donde se une con la cabeza.';

  @override
  String get ideasShortFurStep5 =>
      'Pasa el rotulador claro otra vez por las uniones para fundir las capas y suavizar los trazos más oscuros.';

  @override
  String get ideasWoodGrainTitle => 'Tabla de madera';

  @override
  String get ideasWoodGrainSummary =>
      'Una tabla con veta y un nudo, en tres marrones.';

  @override
  String get ideasWoodGrainPractice =>
      'Trazos largos que siguen la forma del material.';

  @override
  String get ideasWoodGrainSubject =>
      'Una tabla de madera con un nudo cerca de un extremo.';

  @override
  String get ideasWoodGrainTip =>
      'La veta pasa alrededor del nudo: dibuja las líneas curvadas, nunca rectas.';

  @override
  String get ideasWoodGrainStep1 =>
      'Dibuja a lápiz una tabla con un nudo; la veta pasa alrededor del nudo como el agua alrededor de una piedra.';

  @override
  String get ideasWoodGrainStep2 =>
      'Rellena la tabla con trazos largos a lo largo de la veta.';

  @override
  String get ideasWoodGrainStep3 =>
      'Líneas largas y algo onduladas de base siguiendo la veta, agrupándose cerca del nudo.';

  @override
  String get ideasWoodGrainStep4 =>
      'Unas líneas más oscuras y los anillos del nudo; oscurece el borde de abajo de la tabla.';

  @override
  String get ideasWoodGrainStep5 =>
      'Vuelve a pasar el claro por las líneas para suavizar donde parecen trazadas encima.';

  @override
  String get ideasBrickWallTitle => 'Muro de ladrillos';

  @override
  String get ideasBrickWallSummary =>
      'Un trozo de muro de ladrillos de colores algo distintos y mortero claro.';

  @override
  String get ideasBrickWallPractice =>
      'Rellenos planos, ladrillo a ladrillo, y el gris del mortero.';

  @override
  String get ideasBrickWallSubject =>
      'Un trozo de muro con unos veinte ladrillos.';

  @override
  String get ideasBrickWallTip =>
      'Deja el mortero como papel: es más claro que cualquier ladrillo.';

  @override
  String get ideasBrickWallStep1 =>
      'Dibuja a lápiz la retícula del mortero y déjalo como papel por ahora.';

  @override
  String get ideasBrickWallStep2 =>
      'Rellena cada ladrillo con el rotulador claro, dejando que cada uno se seque por separado.';

  @override
  String get ideasBrickWallStep3 =>
      'Pasa la base por más o menos la mitad de los ladrillos, elegidos al azar, para que el muro no sea uniforme.';

  @override
  String get ideasBrickWallStep4 =>
      'Sombra en el borde de abajo de cada ladrillo, más algunos desconchones y ladrillos más oscuros.';

  @override
  String get ideasBrickWallStep5 =>
      'Rellena las juntas de mortero con el gris claro.';

  @override
  String get ideasFoldedClothTitle => 'Paño plegado';

  @override
  String get ideasFoldedClothSummary =>
      'Sombrea los pliegues de un paño colgante con cuatro valores y una sola dirección de luz.';

  @override
  String get ideasFoldedClothPractice =>
      'El mismo degradado repetido en cada pliegue.';

  @override
  String get ideasFoldedClothSubject =>
      'Un paño colgando de un cordón, con tres o cuatro pliegues.';

  @override
  String get ideasFoldedClothTip =>
      'La línea más oscura va solo donde la tela se dobla sobre sí misma.';

  @override
  String get ideasFoldedClothStep1 =>
      'Dibuja a lápiz un paño colgando de un cordón, con tres o cuatro pliegues; marca la parte alta de cada pliegue.';

  @override
  String get ideasFoldedClothStep2 => 'Rellena el paño.';

  @override
  String get ideasFoldedClothStep3 =>
      'Pon la base en el lado de cada pliegue apartado de la luz y fúndela con el claro mientras está húmedo.';

  @override
  String get ideasFoldedClothStep4 =>
      'Sombra en el fondo de cada pliegue, donde la tela se dobla.';

  @override
  String get ideasFoldedClothStep5 =>
      'Una línea oscura fina solo al fondo de los pliegues más profundos; pasa el difuminador por cualquier salto duro de las partes curvas.';

  @override
  String get ideasWaterDropsTitle => 'Gotas sobre una hoja';

  @override
  String get ideasWaterDropsSummary =>
      'Tres gotas de agua sobre una hoja, cada una con su sombra, su borde oscuro y su brillo.';

  @override
  String get ideasWaterDropsPractice =>
      'Unas marcas nítidas encima de un degradado ya terminado.';

  @override
  String get ideasWaterDropsSubject => 'Una hoja con tres gotas de agua.';

  @override
  String get ideasWaterDropsTip =>
      'La gota invierte la luz: sombrea el lado que mira hacia ella.';

  @override
  String get ideasWaterDropsStep1 =>
      'Dibuja a lápiz una hoja y tres gotas; marca en cada gota un brillo pequeño en el lado iluminado.';

  @override
  String get ideasWaterDropsStep2 =>
      'Colorea toda la hoja, gotas incluidas; las gotas son la hoja vista a través del agua.';

  @override
  String get ideasWaterDropsStep3 =>
      'Sombrea la hoja y, dentro de cada gota, el lado que mira a la luz, porque la gota actúa como una lente y lo invierte.';

  @override
  String get ideasWaterDropsStep4 =>
      'Una media luna oscura fina en el lado opuesto de cada gota y una sombra pequeña debajo.';

  @override
  String get ideasWaterDropsStep5 =>
      'Gel blanco: un punto duro por gota en el lado iluminado y un filo más claro justo en el contrario.';

  @override
  String get ideasStrawberrySeedsTitle => 'Fresa';

  @override
  String get ideasStrawberrySeedsSummary =>
      'Una fresa con las semillas hundidas en pequeños hoyos y una corona verde.';

  @override
  String get ideasStrawberrySeedsPractice =>
      'Textura hecha de marcas pequeñas: hoyos, semillas y corona.';

  @override
  String get ideasStrawberrySeedsSubject =>
      'Una fresa con una rejilla suelta de semillas.';

  @override
  String get ideasStrawberrySeedsTip =>
      'Marca los hoyos con el color aún húmedo: el anillo oscuro se forma solo.';

  @override
  String get ideasStrawberrySeedsStep1 =>
      'Dibuja a lápiz la fresa y una rejilla suelta de puntitos de semilla, más juntos hacia la punta.';

  @override
  String get ideasStrawberrySeedsStep2 =>
      'Rellena el fruto dejando un brillo suave.';

  @override
  String get ideasStrawberrySeedsStep3 =>
      'Funde la base por los lados; mientras esté húmedo, presiona un punto algo más oscuro sobre cada semilla.';

  @override
  String get ideasStrawberrySeedsStep4 =>
      'Oscurece la mitad de abajo y el hoyo sobre cada semilla.';

  @override
  String get ideasStrawberrySeedsStep5 =>
      'Colorea las hojas y el tallo con el verde y pon un punto diminuto de gel blanco en cada hoyo para la semilla.';

  @override
  String get ideasPaletteMixingTitle => 'Mezclar en una paleta';

  @override
  String get ideasPaletteMixingSummary =>
      'Haz un tercer color mezclando dos rotuladores sobre una superficie de plástico y recógelo con el difuminador.';

  @override
  String get ideasPaletteMixingPractice =>
      'Mezclar dos tintas fuera del papel, con el difuminador como pincel.';

  @override
  String get ideasPaletteMixingSubject =>
      'Una tapa de plástico o una tarjeta de mezcla, y un papel aparte.';

  @override
  String get ideasPaletteMixingTip =>
      'El difuminador solo lleva lo que está húmedo: no dejes secar los charcos.';

  @override
  String get ideasPaletteMixingStep1 =>
      'Garabatea el primer rotulador en un trozo que no absorba, como una tarjeta de mezcla, una tapa de plástico o una bolsa de congelación.';

  @override
  String get ideasPaletteMixingStep2 =>
      'Garabatea el segundo rotulador al lado para que los dos charcos se toquen.';

  @override
  String get ideasPaletteMixingStep3 =>
      'Coge la mezcla con la punta ancha del difuminador incoloro y pinta una muestra; al lado, muestra cada rotulador por separado.';

  @override
  String get ideasPaletteMixingStep4 =>
      'Prueba otra mezcla con más cantidad de uno de los dos colores.';

  @override
  String get ideasPaletteMixingStep5 =>
      'Anota qué mezclas te gustaría tener como rotulador.';

  @override
  String get ideasLongHairTitle => 'Pelo largo';

  @override
  String get ideasLongHairSummary =>
      'Una melena con una banda de luz y mechones que siguen la forma de la cabeza.';

  @override
  String get ideasLongHairPractice =>
      'Trazos largos que se afinan y una banda de luz que es solo papel.';

  @override
  String get ideasLongHairSubject =>
      'Una melena con unos pocos mechones grandes y una banda de luz.';

  @override
  String get ideasLongHairTip =>
      'Presiona menos dentro de la banda de luz: el papel hace el trabajo.';

  @override
  String get ideasLongHairStep1 =>
      'Dibuja a lápiz el pelo en pocos mechones grandes y no en pelos sueltos, y una banda curva donde da la luz.';

  @override
  String get ideasLongHairStep2 =>
      'Rellena todo el pelo, presionando menos dentro de la banda de luz.';

  @override
  String get ideasLongHairStep3 =>
      'Trazos largos desde la raya hacia abajo, levantando la punta al llegar a la banda de luz, y luego desde las puntas hacia arriba.';

  @override
  String get ideasLongHairStep4 =>
      'Oscurece entre los mechones y bajo la oreja y el cuello.';

  @override
  String get ideasLongHairStep5 =>
      'Unas hebras finas del rotulador más oscuro y dos o tres hilos finos de gel blanco solo dentro de la banda de luz.';

  @override
  String get ideasOverlapGlazesTitle => 'Capas superpuestas';

  @override
  String get ideasOverlapGlazesSummary =>
      'Superpone tres círculos transparentes y mira qué colores nuevos aparecen.';

  @override
  String get ideasOverlapGlazesPractice =>
      'Capas transparentes: cada solape es una mezcla de verdad.';

  @override
  String get ideasOverlapGlazesSubject =>
      'Tres círculos que se solapan, como un diagrama de Venn.';

  @override
  String get ideasOverlapGlazesTip =>
      'El orden importa: el color más claro arriba siempre se ve distinto.';

  @override
  String get ideasOverlapGlazesStep1 =>
      'Dibuja a lápiz tres círculos que se solapen como un diagrama de Venn.';

  @override
  String get ideasOverlapGlazesStep2 =>
      'Rellena el primer círculo y deja que se seque del todo.';

  @override
  String get ideasOverlapGlazesStep3 =>
      'Rellena el segundo, incluido el solape; el solape se vuelve un tercer color.';

  @override
  String get ideasOverlapGlazesStep4 =>
      'Rellena el tercer círculo; el centro, donde se encuentran los tres, es la mezcla más oscura.';

  @override
  String get ideasOverlapGlazesStep5 =>
      'Repite con los rotuladores en otro orden: el más claro arriba siempre se ve distinto.';

  @override
  String get ideasFadedBackgroundTitle => 'Fondo difuminado';

  @override
  String get ideasFadedBackgroundSummary =>
      'Da a un dibujo un halo de color que se apaga en blanco mucho antes del borde del papel.';

  @override
  String get ideasFadedBackgroundPractice =>
      'Un viñeteado hecho con trazos circulares y el difuminador.';

  @override
  String get ideasFadedBackgroundSubject =>
      'Una taza, un pájaro o cualquier motivo pequeño en el centro de la página.';

  @override
  String get ideasFadedBackgroundTip =>
      'Para antes de llegar al borde del papel: el halo se apaga solo.';

  @override
  String get ideasFadedBackgroundStep1 =>
      'Dibuja a lápiz un motivo sencillo, como una taza o un pájaro, en el centro de la página.';

  @override
  String get ideasFadedBackgroundStep2 =>
      'Colorea un anillo de base alrededor del motivo, de un dedo de ancho, con trazos circulares.';

  @override
  String get ideasFadedBackgroundStep3 =>
      'Lleva el rotulador claro hacia fuera del anillo en círculos que se solapen hasta que el color se aclare.';

  @override
  String get ideasFadedBackgroundStep4 =>
      'Continúa con el difuminador más allá del color, empujando lo que queda hacia el papel para que no haya borde.';

  @override
  String get ideasFadedBackgroundStep5 =>
      'Termina el motivo para que sea más oscuro que el halo.';

  @override
  String get ideasHatchShadingTitle => 'Sombreado a rayas';

  @override
  String get ideasHatchShadingSummary =>
      'Sombrea una manzana solo con líneas, sin fundir: rayas para el tono medio y rayas cruzadas para la sombra.';

  @override
  String get ideasHatchShadingPractice =>
      'Rayas y rayas cruzadas: líneas que se leen como un tono.';

  @override
  String get ideasHatchShadingSubject => 'Una manzana con el brillo marcado.';

  @override
  String get ideasHatchShadingTip =>
      'Mantén las líneas paralelas y a la misma distancia: el ojo hace el resto.';

  @override
  String get ideasHatchShadingStep1 =>
      'Dibuja a lápiz una manzana y marca el brillo.';

  @override
  String get ideasHatchShadingStep2 =>
      'Rellena la manzana de plano y deja secar.';

  @override
  String get ideasHatchShadingStep3 =>
      'Raya la mitad en sombra con líneas paralelas de la punta fina, más juntas cuanto más lejos de la luz.';

  @override
  String get ideasHatchShadingStep4 =>
      'Cruza la zona más oscura con un segundo grupo de líneas en otro ángulo y añade la sombra de contacto bajo la manzana.';

  @override
  String get ideasHatchShadingStep5 =>
      'Aléjate un poco: a distancia las líneas se vuelven un tono.';

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
  String get ideasSeasonSpring => 'Primavera';

  @override
  String get ideasSeasonSummer => 'Verano';

  @override
  String get ideasSeasonAutumn => 'Otoño';

  @override
  String get ideasSeasonWinter => 'Invierno';

  @override
  String get ideasSectionAnyTime => 'Cualquier época';

  @override
  String ideasSeeAllSemantic(int count, String category) {
    return 'Ver las $count ideas de $category';
  }

  @override
  String get ideasFeaturedLabel => 'Idea del día';

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
  String get matchPrivacyCaption => 'Las fotos se quedan en este móvil.';

  @override
  String get matchCameraButton => 'Cámara';

  @override
  String get matchGalleryButton => 'Galería';

  @override
  String get matchLoadingPhoto => 'Leyendo la foto…';

  @override
  String get matchEmptyPhotoTitle => 'Encuentra un color a partir de una foto';

  @override
  String get matchEmptyPhotoMessage =>
      'Haz una foto, toca un color en ella y mira los rotuladores más cercanos.';

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
  String get matchTakePhotoButton => 'Hacer una foto';

  @override
  String get matchChooseGalleryButton => 'Elegir de la galería';

  @override
  String get matchValuesButton => 'Valores';

  @override
  String get matchValuesTooltip =>
      'Muestra la foto y las coincidencias en escala de grises para comprobar el contraste de valor';

  @override
  String get matchPhotoSampleHint =>
      'Toca dos veces para tomar el color del centro de la foto. Usa las acciones para mover el punto.';

  @override
  String get matchSampleMiddle => 'Tomar el color del centro de la foto';

  @override
  String get matchMoveLeft => 'Mover el punto a la izquierda';

  @override
  String get matchMoveRight => 'Mover el punto a la derecha';

  @override
  String get matchMoveUp => 'Mover el punto hacia arriba';

  @override
  String get matchMoveDown => 'Mover el punto hacia abajo';

  @override
  String matchSampleSpoken(
    String hex,
    String code,
    String name,
    String quality,
  ) {
    return 'Color tomado $hex. Rotulador más cercano: $code, $name, $quality.';
  }

  @override
  String matchSampleSpokenNone(String hex) {
    return 'Color tomado $hex.';
  }

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
  String get commonMoreActions => 'Más acciones';

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
  String get settingsLanguageGerman => 'Deutsch';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageItalian => 'Italiano';

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
      'La IA en el dispositivo no está disponible ahora en este móvil. Se usa la teoría del color hasta que lo esté.';

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
      'copic':
          '$input no es un código de rotulador de Copic. Prueba con $example.',
      'finecolour':
          '$input no es un código de rotulador de Finecolour. Prueba con $example.',
      'touchTwin':
          '$input no es un código de rotulador de Touch Twin. Prueba con $example.',
      'promarker':
          '$input no es un código de rotulador de Promarker. Prueba con $example.',
      'prismacolor':
          '$input no es un código de rotulador de Prismacolor Premier. Prueba con $example.',
      'spectrumNoir':
          '$input no es un código de rotulador de Spectrum Noir. Prueba con $example.',
      'promarkerBrush':
          '$input no es un código de rotulador de Promarker Brush. Prueba con $example.',
      'arrtx':
          '$input no es un código de rotulador de Arrtx. Prueba con $example.',
      'kurecolor':
          '$input no es un código de rotulador de ZIG Kurecolor. Prueba con $example.',
      'graphit':
          '$input no es un código de rotulador de Graph\'it. Prueba con $example.',
      'marvyLePlume':
          '$input no es un código de rotulador de Marvy Le Plume. Prueba con $example.',
      'blickBrush':
          '$input no es un código de rotulador de Blick Studio Brush. Prueba con $example.',
      'artistsLoft':
          '$input no es un código de rotulador de Artist\'s Loft. Prueba con $example.',
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
      'copic':
          '$input no está en tu colección. Prueba con $example o añádelo en Mi colección.',
      'finecolour':
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
      'copic': 'Aún no hay rotuladores Copic en tu colección. Añádelos en Mi colección.',
      'finecolour': 'Aún no hay rotuladores Finecolour en tu colección. Añádelos en Mi colección.',
      'touchTwin': 'Aún no hay rotuladores Touch Twin en tu colección. Añádelos en Mi colección.',
      'promarker': 'Aún no hay rotuladores Promarker en tu colección. Añádelos en Mi colección.',
      'prismacolor': 'Aún no hay rotuladores Prismacolor Premier en tu colección. Añádelos en Mi colección.',
      'spectrumNoir': 'Aún no hay rotuladores Spectrum Noir en tu colección. Añádelos en Mi colección.',
      'promarkerBrush': 'Aún no hay rotuladores Promarker Brush en tu colección. Añádelos en Mi colección.',
      'arrtx': 'Aún no hay rotuladores Arrtx en tu colección. Añádelos en Mi colección.',
      'kurecolor': 'Aún no hay rotuladores ZIG Kurecolor en tu colección. Añádelos en Mi colección.',
      'graphit': 'Aún no hay rotuladores Graph\'it en tu colección. Añádelos en Mi colección.',
      'marvyLePlume': 'Aún no hay rotuladores Marvy Le Plume en tu colección. Añádelos en Mi colección.',
      'blickBrush': 'Aún no hay rotuladores Blick Studio Brush en tu colección. Añádelos en Mi colección.',
      'artistsLoft': 'Aún no hay rotuladores Artist\'s Loft en tu colección. Añádelos en Mi colección.',
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
      'El modelo del dispositivo no está listo en este móvil.';

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
  String matchBestOfRange(String brand) {
    return 'Mejor de toda la gama $brand';
  }

  @override
  String get matchNotOwnedLine => 'No está en tu colección';

  @override
  String matchSeeAll(int count) {
    return 'Ver todas ($count)';
  }

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
  String get collectionOwnedGroup => 'Lo que tienes';

  @override
  String get collectionShoppingGroup => 'Compras';

  @override
  String get collectionToolsGroup => 'Herramientas';

  @override
  String get toolsMapTitle => 'Mapa de color';

  @override
  String get toolsMapHint =>
      'Dónde caen tus rotuladores por tono y luminosidad, y qué huecos hay.';

  @override
  String get toolsTranslateTitle => 'Traducir una receta';

  @override
  String get toolsTranslateHint =>
      'Convierte los códigos de un tutorial en los más parecidos que tienes.';

  @override
  String get toolsBlendsTitle => 'Mis recetas';

  @override
  String get toolsBlendsHint =>
      'Degradados que guardas: rotuladores en orden, una nota y una foto.';

  @override
  String get toolsTransferTitle => 'Exportar e importar';

  @override
  String get toolsTransferHint =>
      'Comparte tus rotuladores como lista o CSV, o añade muchos por código.';

  @override
  String get toolsMapEmptyTitle => 'Aún no hay rotuladores que mapear';

  @override
  String get toolsMapIntro =>
      'Cada punto es un rotulador que tienes. Las zonas rayadas no tienen ninguno.';

  @override
  String get toolsMapShowRange => 'Mostrar toda la gama';

  @override
  String get toolsMapShowRangeHint =>
      'Puntos tenues con todos los rotuladores de tus marcas, para ver qué falta.';

  @override
  String get toolsMapAxes =>
      'De izquierda a derecha: tono. De arriba abajo: de claro a oscuro.';

  @override
  String get toolsMapGreysTitle => 'Grises y neutros';

  @override
  String get toolsMapGreysAxis => 'De izquierda a derecha: de oscuro a claro.';

  @override
  String get toolsMapFamiliesTitle => 'Por tono';

  @override
  String get toolsHueRed => 'Rojo';

  @override
  String get toolsHueOrange => 'Naranja';

  @override
  String get toolsHueYellow => 'Amarillo';

  @override
  String get toolsHueGreen => 'Verde';

  @override
  String get toolsHueTeal => 'Turquesa';

  @override
  String get toolsHueBlue => 'Azul';

  @override
  String get toolsHueViolet => 'Violeta';

  @override
  String get toolsHueMagenta => 'Magenta';

  @override
  String toolsFamilyBands(int light, int mid, int dark) {
    return 'Claros $light · Medios $mid · Oscuros $dark';
  }

  @override
  String get toolsMapDriedNote => 'Los rotuladores secos no se incluyen.';

  @override
  String toolsMapSummary(String markers, int empty, int cells) {
    return 'Mapa de color de $markers. $empty de $cells zonas no tienen ningún rotulador. La lista de abajo muestra los mismos rotuladores por tono.';
  }

  @override
  String get toolsMarkerOwned => 'En tu colección';

  @override
  String get toolsMarkerNotOwned => 'No está en tu colección';

  @override
  String get toolsTranslateIntro =>
      'Escribe o pega los códigos de un tutorial, en la marca que usa. Valen comas, espacios y listas.';

  @override
  String get toolsTranslateBrand => 'Marca de la receta';

  @override
  String get toolsTranslateCodes => 'Códigos';

  @override
  String get toolsTranslateResults => 'Traducción';

  @override
  String get toolsTranslateEmpty => 'Los códigos que escribas aparecen aquí.';

  @override
  String get toolsTranslateMine => 'Lo más parecido que tienes';

  @override
  String get toolsTranslateNotOwned => 'No lo tienes';

  @override
  String get toolsTranslateMissing => 'Nada parecido en tu colección.';

  @override
  String toolsTranslateUnknown(String brand) {
    return 'No existe en $brand';
  }

  @override
  String get toolsCopyList => 'Copiar lista';

  @override
  String get toolsShareList => 'Compartir lista';

  @override
  String get toolsListCopied => 'Lista copiada.';

  @override
  String get toolsShareFailed => 'No se pudo compartir la lista.';

  @override
  String get toolsBlendsNew => 'Nueva receta';

  @override
  String get toolsBlendsEditTitle => 'Editar receta';

  @override
  String get toolsBlendsEmptyTitle => 'Aún no hay recetas';

  @override
  String get toolsBlendsEmptyBody =>
      'Guarda los degradados que te gustan: rotuladores en orden, una nota y una foto.';

  @override
  String get toolsBlendsName => 'Nombre de la receta';

  @override
  String get toolsBlendsMarkersTitle => 'Rotuladores, en orden';

  @override
  String get toolsBlendsMarkersHelp => 'Arrastra el asa para cambiar el orden.';

  @override
  String get toolsBlendsDrag => 'Arrastrar para reordenar';

  @override
  String toolsBlendsRemoveMarker(String code) {
    return 'Quitar $code';
  }

  @override
  String get toolsBlendsNote => 'Nota';

  @override
  String get toolsBlendsPhotoTitle => 'Foto del resultado';

  @override
  String get toolsBlendsPhotoHelp => 'Opcional. Se queda en este móvil.';

  @override
  String get toolsBlendsPhotoSemantic => 'Foto de la receta';

  @override
  String get toolsBlendsSave => 'Guardar receta';

  @override
  String get toolsBlendsDelete => 'Borrar receta';

  @override
  String get toolsBlendsDeleteTitle => '¿Borrar esta receta?';

  @override
  String get toolsBlendsDeleteBody =>
      'La receta y su foto se quitarán de este móvil.';

  @override
  String get toolsTransferExport => 'Exportar';

  @override
  String toolsTransferBrands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcas',
      one: '1 marca',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferExportBrands(String brands) {
    return 'Incluye todas las marcas que tienes: $brands.';
  }

  @override
  String get toolsTransferCsv => 'Compartir como CSV';

  @override
  String get toolsTransferImport => 'Importar por código';

  @override
  String get toolsTransferImportHelp =>
      'Elige la marca y pega sus códigos. No se añade nada hasta que pulses el botón.';

  @override
  String get toolsTransferNew => 'Rotuladores nuevos';

  @override
  String get toolsTransferAlready => 'Ya los tienes';

  @override
  String get toolsTransferUnknown => 'No reconocidos';

  @override
  String toolsTransferAdd(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Añadir $count rotuladores',
      one: 'Añadir 1 rotulador',
      zero: 'Añadir rotuladores',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores añadidos.',
      one: '1 rotulador añadido.',
    );
    return '$_temp0';
  }

  @override
  String commonSeeAll(int count) {
    return 'Ver todas ($count)';
  }

  @override
  String get collectionChartTitle => 'Carta de muestras para imprimir';

  @override
  String get swatchesOtherBrandsTitle => 'En otras marcas';

  @override
  String get swatchesOtherBrandsOnlyMine => 'Solo los míos';

  @override
  String get swatchesOtherBrandsNone =>
      'No hay otra marca con la que comparar.';

  @override
  String get swatchesOtherBrandsNoneMine =>
      'No tienes rotuladores utilizables de otras marcas.';

  @override
  String get swatchesOtherBrandsFailed =>
      'No se pudieron leer las otras marcas.';

  @override
  String get swatchesOtherBrandsPaletteNote =>
      'Las paletas usan la marca elegida en Ajustes, así que este rotulador no se puede añadir a una.';

  @override
  String get paletteVisionTitle => 'Visión del color';

  @override
  String get paletteVisionNormal => 'Normal';

  @override
  String get paletteVisionProtanopia => 'Protanopía';

  @override
  String get paletteVisionDeuteranopia => 'Deuteranopía';

  @override
  String get paletteVisionTritanopia => 'Tritanopía';

  @override
  String get paletteVisionAchromatopsia => 'Acromatopsia';

  @override
  String paletteVisionPairs(String pairs) {
    return 'Difíciles de distinguir: $pairs';
  }

  @override
  String paletteVisionPairsMore(int count) {
    return '+$count más';
  }

  @override
  String get paletteVisionNoPairs => 'Todos los colores se distinguen bien.';

  @override
  String get paletteVisionPreviewNote =>
      'Solo es una vista previa. Al guardar y compartir se mantienen los colores reales.';

  @override
  String get paletteEaselTitle => 'Modo caballete';

  @override
  String get paletteEaselExit => 'Salir del modo caballete';

  @override
  String get paletteShareTextButton => 'Compartir como texto';

  @override
  String paletteTextHeader(String brand, String title) {
    return 'Paleta de Ink Lab · $brand · $title';
  }

  @override
  String get paletteImportTitle => 'Importar desde texto';

  @override
  String get paletteImportHint =>
      'Pega una paleta compartida o una lista de códigos de rotuladores.';

  @override
  String get paletteImportPaste => 'Pegar';

  @override
  String get paletteImportAction => 'Cargar paleta';

  @override
  String get paletteImportNothing =>
      'No se encontró ningún código de rotulador en este texto.';

  @override
  String paletteImportNoneKnown(String brand, String codes) {
    return 'Ninguno de estos códigos es un rotulador de $brand: $codes.';
  }

  @override
  String paletteImportOtherBrand(String brand) {
    return 'Esta paleta es de $brand. Cambia la marca en Ajustes para importarla.';
  }

  @override
  String paletteImportDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Paleta importada con $count rotuladores.',
      one: 'Paleta importada con 1 rotulador.',
    );
    return '$_temp0';
  }

  @override
  String paletteImportUnknown(String codes) {
    return 'No reconocidos: $codes.';
  }

  @override
  String get paletteImportRepeated =>
      'Los códigos repetidos se han contado una vez.';

  @override
  String get collectionChartHint =>
      'Cajas vacías con el código y el nombre de cada rotulador que tienes, para pintar tus muestras reales. Se comparten como imágenes A4 para imprimir o guardar.';

  @override
  String get collectionChartShowColour => 'Color del catálogo';

  @override
  String get collectionChartShowColourHint =>
      'Muéstralo como una franja fina en cada caja, para comparar.';

  @override
  String get collectionChartCreate => 'Crear y compartir';

  @override
  String get collectionChartPreparing => 'Preparando…';

  @override
  String get collectionChartEmpty => 'Elige antes tus sets o rotuladores.';

  @override
  String collectionChartPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
    );
    return '$_temp0';
  }

  @override
  String get chartImageTitle => 'Carta de muestras';

  @override
  String chartImagePage(int page, int total) {
    return 'Página $page de $total';
  }

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
  String get wishlistTitle => 'Lista de deseos';

  @override
  String wishlistCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores por comprar',
      one: '1 rotulador por comprar',
      zero: 'Tu lista de deseos está vacía',
    );
    return '$_temp0';
  }

  @override
  String get wishlistEmpty =>
      'Añade los rotuladores que quieres comprar desde el detalle de cualquiera.';

  @override
  String get wishlistAdd => 'A la lista de deseos';

  @override
  String get wishlistRemove => 'Quitar de la lista';

  @override
  String get wishlistCopy => 'Copiar lista';

  @override
  String get wishlistCopied => 'Lista de la compra copiada';

  @override
  String get wishlistOfferTitle => '¿Añadir a tu lista de deseos?';

  @override
  String wishlistOfferBody(String code) {
    return '$code se ha secado. Añádelo a tu lista de deseos para comprar una recarga o un repuesto.';
  }

  @override
  String get driedTitle => 'Secos';

  @override
  String driedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores secos',
      one: '1 rotulador seco',
      zero: 'Ningún rotulador seco',
    );
    return '$_temp0';
  }

  @override
  String get driedHint =>
      'Siguen en tu colección, pero Emparejar, Paleta e Ideas no los sugieren.';

  @override
  String get driedEmpty =>
      'Cuando un rotulador deje de pintar, márcalo como seco desde su detalle.';

  @override
  String get driedMark => 'Marcar como seco';

  @override
  String get driedUnmark => 'Marcar como usable';

  @override
  String get driedNote =>
      'Seco: Emparejar, Paleta e Ideas lo omiten hasta que lo marques como usable.';

  @override
  String get commonDried => 'Seco';

  @override
  String get buyNextTitle => 'Qué comprar ahora';

  @override
  String get buyNextIntro =>
      'Rotuladores que no tienes y que acercarían tus colores a los de más escenas.';

  @override
  String buyNextReasonScenes(int count, String scenes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mejora $count escenas: $scenes',
      one: 'Mejora 1 escena: $scenes',
    );
    return '$_temp0';
  }

  @override
  String get buyNextReasonGap => 'Rellena un hueco en tu gama de colores';

  @override
  String get buyNextNoCollection =>
      'Marca los rotuladores que tienes para ver qué comprar.';

  @override
  String get buyNextComplete =>
      'Nada que sugerir: tus rotuladores ya cubren bien todas las escenas.';

  @override
  String get buyNextRefill => 'Seco: una recarga lo recupera.';

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Hasta que elijas sets, la app muestra toda la gama de $brand.';
  }

  @override
  String get onboardingDoneNext =>
      'Qué sigue: mira tus colores en Muestras, empareja una foto en Emparejar o crea una paleta en Paleta.';

  @override
  String get collectionVisibleScope =>
      'Afecta a los rotuladores que coinciden con la búsqueda.';

  @override
  String get matchWhiteBalanceButton => 'Corregir blancos';

  @override
  String get matchWhiteBalanceHint =>
      'Toca un punto de la foto que debería ser papel blanco.';

  @override
  String get matchWhiteBalanceOn => 'Blancos corregidos';

  @override
  String get matchWhiteBalanceReset => 'Quitar';

  @override
  String get matchWhiteBalanceTooDark =>
      'Ese punto es demasiado oscuro para ser papel. Elige uno más claro.';

  @override
  String get matchWhiteBalanceTooColourful =>
      'Ese punto tiene demasiado color para ser papel. Elige una zona blanca.';

  @override
  String get commonOwnColour => 'Mi color';

  @override
  String get swatchesMyColourTitle => 'Mi color';

  @override
  String get swatchesMyColourHelp =>
      'Los colores del catálogo son aproximados. Guarda el que da de verdad tu rotulador sobre el papel.';

  @override
  String get swatchesMyColourReset => 'Volver al catálogo';

  @override
  String get swatchesMyColourSaved => 'Tu color se ha guardado';

  @override
  String get swatchesMyColourWasReset => 'Vuelve el color del catálogo';

  @override
  String get swatchesMyColourSame => 'Igual que el catálogo';

  @override
  String swatchesMyColourValue(String hex) {
    return 'Tuyo: $hex';
  }

  @override
  String get swatchesStatusWished => 'En tu lista de deseos';

  @override
  String get swatchesDetailsTitle => 'Detalles';

  @override
  String get swatchesCatalogueLabel => 'Catálogo';

  @override
  String get swatchesMineLabel => 'Mío';

  @override
  String ownColorTitle(String code) {
    return 'Mi color de $code';
  }

  @override
  String get ownColorHexLabel => 'Color hex';

  @override
  String get ownColorHexInvalid => 'Escribe 3 o 6 dígitos hex, como 3A7F9C.';

  @override
  String get ownColorPhotoTitle => 'Desde una foto';

  @override
  String get ownColorPhotoHelp =>
      'Pinta con el rotulador sobre papel blanco, haz una foto y toca la zona pintada.';

  @override
  String get ownColorPhotoTap => 'Toca la zona pintada.';

  @override
  String get ownColorSave => 'Guardar mi color';

  @override
  String get settingsOwnColors => 'Usar mis colores';

  @override
  String get settingsOwnColorsSubtitle =>
      'Emparejar, Paleta e Ideas usan el color que guardaste de un rotulador en vez del del catálogo.';

  @override
  String settingsOwnColorsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colores propios',
      one: '1 color propio',
      zero: 'Aún no tienes colores propios',
    );
    return '$_temp0';
  }

  @override
  String get settingsOwnColorsReset => 'Restablecer';

  @override
  String get settingsOwnColorsResetTitle => '¿Restablecer tus colores?';

  @override
  String get settingsOwnColorsResetBody =>
      'Todos los rotuladores vuelven al color del catálogo. No se puede deshacer.';

  @override
  String get settingsJoinBeta => 'Únete a la beta de Google Play';

  @override
  String get collectionCopicHint =>
      'Los rotuladores Copic se compran uno a uno. Marca los que tienes.';

  @override
  String get collectionFinecolourHint =>
      'Los rotuladores Finecolour se compran uno a uno. Marca los que tienes.';

  @override
  String get onboardingCopicLine =>
      '358 colores · Marca los rotuladores que tienes';

  @override
  String get onboardingFinecolourLine =>
      '480 colores · Marca los rotuladores que tienes';

  @override
  String onboardingMarkersTitle(String brand) {
    return 'Tus rotuladores $brand';
  }

  @override
  String onboardingNoMarkers(String brand) {
    return 'Todavía no has marcado rotuladores $brand: márcalos en Mi colección.';
  }

  @override
  String ideasNoMarkersBrand(String brand) {
    return 'Añade en Mi colección los rotuladores $brand que tienes para ver una paleta para esta idea.';
  }

  @override
  String get ideasDiarySegment => 'Diario';

  @override
  String get ideasDiarySubtitle => 'Tus obras, las más recientes primero';

  @override
  String get diaryEmptyTitle => 'Tu diario está vacío';

  @override
  String get diaryEmptyMessage =>
      'Apunta las páginas y hojas que pintas, con sus rotuladores, notas y fotos.';

  @override
  String get diaryAdd => 'Añadir al diario';

  @override
  String get diaryShareButton => 'Compartir esta entrada';

  @override
  String get diaryStatusLabel => 'Estado';

  @override
  String get diaryStatusInProgress => 'En curso';

  @override
  String get diaryStatusFinished => 'Terminada';

  @override
  String get diaryNewTitle => 'Nueva entrada';

  @override
  String get diaryEditTitle => 'Editar entrada';

  @override
  String get diaryTitleLabel => 'Título';

  @override
  String get diaryDateLabel => 'Fecha';

  @override
  String get diaryOnWhatLabel => 'Pintado en';

  @override
  String get diaryOnWhatHint => 'p. ej., un libro de colorear o un cuaderno';

  @override
  String get diaryMarkersTitle => 'Rotuladores usados';

  @override
  String get diaryMarkersChoose => 'Elegir rotuladores';

  @override
  String diaryMarkerRemove(String code) {
    return 'Quitar $code';
  }

  @override
  String get diaryPaletteTitle => 'Paleta';

  @override
  String get diaryPaletteNone => 'Sin paleta';

  @override
  String get diaryPaletteChoose => 'Vincular una paleta guardada';

  @override
  String get diaryPaletteMissing => 'Esta paleta ya no está guardada.';

  @override
  String get diaryPaletteEmpty => 'Aún no tienes paletas guardadas.';

  @override
  String get diaryNotesLabel => 'Notas';

  @override
  String get diaryNotesHint => 'Técnica, papel, mezclas...';

  @override
  String get diaryMoreDetails => 'Más detalles';

  @override
  String get diaryPhotosTitle => 'Fotos';

  @override
  String diaryPhotosHelp(int count) {
    return 'Hasta $count fotos. Se quedan en este móvil.';
  }

  @override
  String get diaryPhotoRemove => 'Quitar foto';

  @override
  String diaryPhotoSemantic(int number, int total) {
    return 'Foto $number de $total';
  }

  @override
  String get diarySave => 'Guardar entrada';

  @override
  String get diaryDelete => 'Borrar entrada';

  @override
  String get diaryDeleteTitle => '¿Borrar esta entrada?';

  @override
  String get diaryDeleteBody =>
      'La entrada y sus fotos se borran de este móvil. No se puede deshacer.';

  @override
  String get diaryDeleteConfirm => 'Borrar';

  @override
  String get diaryAddedNotice => 'Añadido al diario';

  @override
  String diaryStatsArtworks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count obras',
      one: '1 obra',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsFinished(int count) {
    return '$count terminadas';
  }

  @override
  String diaryStatsInProgress(int count) {
    return '$count en curso';
  }

  @override
  String get diaryStatsOpen => 'Ver los números';

  @override
  String get diaryStatsTitle => 'Números del diario';

  @override
  String get diaryStatsStatusTitle => 'Terminadas y en curso';

  @override
  String get diaryStatsMonthsTitle => 'Entradas por mes';

  @override
  String diaryStatsMonthsLatest(int count) {
    return 'Mostrando los últimos $count meses.';
  }

  @override
  String get diaryStatsMarkersTitle => 'Rotuladores que más usas';

  @override
  String get diaryStatsMarkersEmpty =>
      'Ninguna entrada tiene rotuladores todavía.';

  @override
  String diaryStatsEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas',
      one: '1 entrada',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedTitle => 'Rotuladores sin usar';

  @override
  String diaryStatsUnusedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores que tienes no están en ninguna entrada.',
      one: '1 rotulador que tienes no está en ninguna entrada.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedNone =>
      'Todos tus rotuladores están en alguna entrada.';

  @override
  String get diaryStatsUnusedNoCollection =>
      'Añade tus rotuladores en Mi colección para ver cuáles no has usado.';

  @override
  String get diaryStatsUnusedShow => 'Mostrar la lista';

  @override
  String get diaryStatsUnusedHide => 'Ocultar la lista';

  @override
  String get diaryStatsPalettesTitle => 'Paletas que más enlazas';

  @override
  String get diaryStatsPalettesEmpty =>
      'Ninguna entrada enlaza una paleta guardada todavía.';

  @override
  String diaryShareMore(int count) {
    return '+$count más';
  }

  @override
  String get settingsLicences => 'Licencias de código abierto';

  @override
  String get settingsLicencesSubtitle =>
      'Las licencias del código, las fuentes y los paquetes que usa la app';

  @override
  String get settingsLicencesLegalese =>
      'Código de Ink Lab: licencia MIT. Textos, ideas y documentación: CC BY-SA 4.0. Fuentes incluidas: licencia SIL Open Font 1.1.';

  @override
  String get settingsSendFeedback => 'Enviar comentarios';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Abre tu app de correo con la versión de la app y del sistema. Tú decides si lo envías.';

  @override
  String settingsFeedbackNoMail(String address) {
    return 'No se encontró ninguna app de correo. Se copió la dirección $address.';
  }

  @override
  String get settingsErrorLogShare => 'Compartir registro de errores';

  @override
  String get settingsErrorLogShareSubtitle =>
      'Detalles técnicos de los errores que ha tenido la app, sin tu diario ni tu clave de API. No se envía nada si no lo compartes tú.';

  @override
  String get settingsErrorLogClear => 'Borrar registro de errores';

  @override
  String get settingsErrorLogCleared => 'Registro de errores borrado';

  @override
  String get settingsErrorLogShareFailed =>
      'No se pudo compartir el registro de errores';

  @override
  String settingsLastBackup(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Última copia: $dateString';
  }

  @override
  String get settingsNoBackupYet => 'Aún no hay copia de seguridad';

  @override
  String get settingsBackupReminderNever =>
      'Tienes datos en la app y todavía no has hecho ninguna copia. Guarda un archivo de copia para no perderlos si cambias o reinicias el móvil.';

  @override
  String get settingsBackupReminderOld =>
      'Tu última copia tiene más de un mes. Guarda un archivo nuevo para tener a salvo tu trabajo más reciente.';

  @override
  String get collectionTouchTwinHint =>
      'Marca los rotuladores Touch Twin que tienes.';

  @override
  String get onboardingTouchTwinLine =>
      '202 colores · Marca los rotuladores que tienes';

  @override
  String get collectionPromarkerHint =>
      'Marca los rotuladores Promarker que tienes.';

  @override
  String get onboardingPromarkerLine =>
      '148 colores · Marca los rotuladores que tienes';

  @override
  String get collectionPrismacolorHint =>
      'Marca los rotuladores Prismacolor Premier que tienes.';

  @override
  String get onboardingPrismacolorLine =>
      '200 colores · Marca los rotuladores que tienes';

  @override
  String get collectionSpectrumNoirHint =>
      'Marca los rotuladores Spectrum Noir que tienes.';

  @override
  String get onboardingSpectrumNoirLine =>
      '216 colores · Marca los rotuladores que tienes';

  @override
  String get collectionPromarkerBrushHint =>
      'Marca los rotuladores Promarker Brush que tienes.';

  @override
  String get onboardingPromarkerBrushLine =>
      '72 colores · Marca los rotuladores que tienes';

  @override
  String get collectionArrtxHint => 'Marca los rotuladores Arrtx que tienes.';

  @override
  String get onboardingArrtxLine =>
      '328 colores · Marca los rotuladores que tienes';

  @override
  String get collectionKurecolorHint =>
      'Marca los rotuladores ZIG Kurecolor que tienes.';

  @override
  String get onboardingKurecolorLine =>
      '136 colores · Marca los rotuladores que tienes';

  @override
  String get collectionGraphitHint =>
      'Marca los rotuladores Graph\'it que tienes.';

  @override
  String get onboardingGraphitLine =>
      '168 colores · Marca los rotuladores que tienes';

  @override
  String get collectionMarvyLePlumeHint =>
      'Marca los rotuladores Marvy Le Plume que tienes.';

  @override
  String get onboardingMarvyLePlumeLine =>
      '144 colores · Marca los rotuladores que tienes';

  @override
  String get collectionBlickBrushHint =>
      'Marca los rotuladores Blick Studio Brush que tienes.';

  @override
  String get onboardingBlickBrushLine =>
      '96 colores · Marca los rotuladores que tienes';

  @override
  String get collectionArtistsLoftHint =>
      'Marca los rotuladores Artist\'s Loft que tienes.';

  @override
  String get onboardingArtistsLoftLine =>
      '56 colores · Marca los rotuladores que tienes';

  @override
  String get shortcutMatchLabel => 'Emparejar un color';

  @override
  String get shortcutNewPaletteLabel => 'Nueva paleta';

  @override
  String get shortcutSearchSwatchesLabel => 'Buscar muestras';

  @override
  String get brandSearchHint => 'Buscar marca';

  @override
  String get brandGroupPopular => 'Populares';

  @override
  String get brandGroupMore => 'Más marcas';

  @override
  String get brandSearchEmpty => 'Ninguna marca coincide con tu búsqueda.';

  @override
  String get brandGroupOwned => 'Tus marcas';

  @override
  String brandOwnedLine(int owned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      owned,
      locale: localeName,
      other: '$owned de $total tuyos',
      one: '1 de $total tuyo',
    );
    return '$_temp0';
  }

  @override
  String get navRailExpand => 'Desplegar menú';

  @override
  String get navRailCollapse => 'Plegar menú';

  @override
  String get inkLevelTitle => 'Nivel de tinta';

  @override
  String get inkLevelFull => 'Lleno';

  @override
  String get commonRunningOut => 'Se acaba';

  @override
  String get refillNoteTitle => 'Nota de recarga';

  @override
  String get refillNoteEmpty => 'Añade una nota, como «recargado el 3 nov»';

  @override
  String get refillNoteHint => 'Recargado el 3 nov';

  @override
  String get refillNoteSave => 'Guardar';

  @override
  String get refillNoteRemove => 'Quitar nota';

  @override
  String get swatchPhotoTitle => 'Muestra real';

  @override
  String get swatchPhotoEmpty => 'Añade una foto de tu muestra en papel';

  @override
  String get swatchPhotoHas => 'Tu muestra en papel';

  @override
  String get swatchPhotoView => 'Ver foto';

  @override
  String get swatchPhotoTake => 'Hacer una foto';

  @override
  String get swatchPhotoChoose => 'Elegir de la galería';

  @override
  String get swatchPhotoSaved => 'Foto guardada';

  @override
  String get swatchPhotoSaveFailed =>
      'No se pudo guardar la foto. Prueba con otra.';

  @override
  String get swatchPhotoRemoved => 'Foto quitada';

  @override
  String get swatchShadowLightTitle => 'Sombra y luz';

  @override
  String get swatchShadow => 'Sombra';

  @override
  String get swatchLight => 'Luz';

  @override
  String get swatchShadowLightNone => 'Ninguno en tu colección';

  @override
  String get swatchBlendWith => 'Fundir con…';

  @override
  String get swatchBlendTitle => 'Fundir con';

  @override
  String get swatchBlendSearchHint => 'Buscar rotuladores';

  @override
  String get swatchBlendNoMarkers =>
      'No tienes otros rotuladores con los que fundir.';

  @override
  String get swatchBlendNoResults =>
      'Ningún rotulador coincide con tu búsqueda.';

  @override
  String get swatchBlendSteps => 'Entre medias, de tu colección';

  @override
  String get swatchBlendNothingBetween =>
      'Estos dos están lo bastante cerca para fundirse directamente.';

  @override
  String get swatchBlendNoneBetween =>
      'Ninguno de tus rotuladores queda entre ellos.';

  @override
  String swatchBlendBuy(String code) {
    return 'Hay un salto grande. Para cubrirlo, el rotulador más cercano que no tienes es $code.';
  }

  @override
  String swatchBlendStripSemantics(String from, String to) {
    return 'Degradado de $from a $to';
  }

  @override
  String swatchDuplicatesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ya tienes $count rotuladores muy parecidos a este',
      one: 'Ya tienes 1 rotulador muy parecido a este',
    );
    return '$_temp0';
  }

  @override
  String get swatchDuplicatesHint =>
      'Casi el mismo color: uno nuevo aporta poco.';

  @override
  String swatchDuplicatesMore(int count) {
    return 'y $count más';
  }

  @override
  String get swatchDuplicatesNone =>
      'Nada de tu colección se parece mucho: añadiría un color nuevo.';

  @override
  String wishlistDuplicateNote(String codes) {
    return 'Muy parecido a $codes de tu colección';
  }

  @override
  String wishlistRunningOutCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotuladores se acaban',
      one: '1 rotulador se acaba',
      zero: 'Nada se está acabando',
    );
    return '$_temp0';
  }

  @override
  String get wishlistRunningOutHint =>
      'Se siguen usando. Añádelos a la lista cuando quieras comprar o recargar.';

  @override
  String swatchesAllBrands(int count) {
    return 'Todas las marcas ($count)';
  }

  @override
  String get swatchesOtherBrandsYours => 'Tus marcas';

  @override
  String get inkLevelFullNote =>
      'Lleno: Emparejar, Paleta e Ideas pueden sugerirlo.';

  @override
  String get inkLevelRunningOutNote =>
      'Se acaba: se sigue usando en todas partes. Aparece en el grupo «Se acaba» de tu lista de deseos.';

  @override
  String get swatchesDetailPaneEmpty =>
      'Toca un rotulador para ver aquí sus detalles.';
}
