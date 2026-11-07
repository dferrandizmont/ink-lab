<!--
No es asesoramiento jurídico. Resume qué hace la app con los datos, comprobado contra el código el 7-nov-2026;
conviene que lo revise un profesional antes del lanzamiento en las tiendas.
-->

# Privacidad y cumplimiento

Resume qué hace la app con los datos, comprobado contra el código el 7-nov-2026. La política para el usuario está en
[`docs/legal/politica-privacidad.md`](legal/politica-privacidad.md) y tiene que decir lo mismo que este documento.
English version: [`privacy.en.md`](privacy.en.md).

## Flujo de datos
- **Por defecto la app no habla con ningún servidor.** No hay cuentas, servidor propio, analítica ni telemetría
  propias, anuncios, compras ni informes de errores. Con la IA apagada no hay tráfico de red (medido en emulador) y la
  app no llama a ML Kit. Los catálogos de las 15 marcas de rotuladores (Ohuhu, DecoTime, Copic, Finecolour, Touch
  Twin, Promarker, Promarker Brush, Prismacolor Premier, Spectrum Noir, Arrtx, ZIG Kurecolor, Graph'it, Marvy Le Plume,
  Blick Studio Brush y Artist's Loft; 3420 colores en `assets/data/*_colors.json`) van incluidos en la app y el motor
  de paletas es Dart local (`lib/core/`): todo funciona sin conexión. También se calculan solo en el móvil, con esos
  catálogos y los datos del usuario, las equivalencias «En otras marcas» del detalle de un rotulador, «Sombra y luz»,
  «Mezclar con…» y el aviso de casi duplicados (`lib/core/shadow_light.dart`, `lib/core/gradient_preview.dart`), la
  búsqueda por hex (`lib/core/hex_search.dart`), la vista «Valores» en gris (`lib/core/value_view.dart`), la
  previsualización «Visión del color» de Paleta (solo cambia lo que se dibuja; guardar y compartir usan los colores
  reales), el «Mapa de color» y el traductor de recetas de Herramientas (`lib/core/collection_wheel.dart`,
  `lib/core/recipe_codes.dart`) y los «Números del diario».
- **El diario de obras se queda en el móvil:** las fotos que el usuario añade a una entrada del «Diario» (Ideas →
  Diario) se copian reducidas a la carpeta privada de la app y no se suben a ningún sitio: ni a un servidor propio, ni
  a las funciones de IA (OpenRouter, Gemini Nano o ML Kit). El resto del diario (título, fecha, rotuladores usados,
  notas) es texto en el almacenamiento privado de la app. «Compartir esta entrada» (`lib/ui/share/diary_entry_renderer.dart`)
  dibuja, solo al tocarlo, un PNG con título, fecha, soporte, estado, la primera foto, los rotuladores y los colores de
  la paleta enlazada, y lo entrega al menú de compartir del sistema; la foto se decodifica para esa imagen y se libera
  al terminar.
- **Solo hay red si el usuario activa la IA** (Ajustes → Asistente de IA → Sugerir con IA): con OpenRouter y su propia
  clave, y en Android por los diagnósticos que ML Kit envía a Google al usar la IA en el móvil (ver abajo). El manifiesto
  de Android declara `INTERNET`; el manifiesto fusionado añade `ACCESS_NETWORK_STATE` y el componente
  `com.google.android.datatransport` (el transporte de registros de Google que usa ML Kit); `usesCleartextTraffic="false"` y `network_security_config.xml` rechazan
  el tráfico sin cifrar. El cliente (`lib/ai/open_router_client.dart`) solo habla con `openrouter.ai` por HTTPS, no
  sigue redirecciones, limita el tamaño de las respuestas y sanea el texto que recibe.
- **IA en el móvil (Android):** Gemini Nano mediante ML Kit GenAI Prompt API (`com.google.mlkit:genai-prompt` en
  `android/app/build.gradle.kts`) y AICore (`lib/ai/platform_on_device_palette_advisor.dart`,
  `android/.../OnDeviceAiChannel.kt`). La petición (escenario y códigos de color) se resuelve en el teléfono y no se
  envía a ningún sitio. La app solo llama a ML Kit con la IA activada; a partir de ahí comprueba si Gemini Nano está
  disponible y, al comprobar, descargar o generar, **ML Kit envía a Google** por HTTPS (a
  `firebaselogging.googleapis.com`, en lotes, con prioridad baja, más o menos una vez al día) datos de diagnóstico y
  de uso. Según la [divulgación de datos de ML Kit para Android](https://developers.google.com/ml-kit/android-data-disclosure):
  información del dispositivo (fabricante, modelo, versión y compilación del sistema), de la app (paquete y versión),
  identificadores del dispositivo y otros (incluidos identificadores por instalación), métricas de rendimiento,
  configuración de la API, tamaño de entrada y salida, versión de la función, tipo de evento, códigos de error y, en
  GenAI, los idiomas configurados. Finalidad: diagnóstico y analítica de uso; Google dice que no los transfiere a
  terceros. No incluye el contenido de la petición, los colores ni fotos (solo tamaños). El desarrollador no recibe
  esos datos; Google los trata según su [política de privacidad](https://policies.google.com/privacy). Si el modelo no
  está en el móvil, Android lo descarga una vez y lo comparte entre apps; esa descarga la hace el sistema (servicios de
  Google), no la app. En iOS 26+ la opción «En el dispositivo» usa Apple Intelligence (framework Foundation
  Models, `ios/Runner/OnDeviceAiChannel.swift`): el modelo lo instala y gestiona iOS, la app no descarga nada, no hay
  ML Kit ni otro SDK y no sale nada del teléfono.
- **Valoración en la tienda, como mucho una vez** (`lib/data/review_prompt.dart`, paquete `in_app_review`): tras la
  tercera paleta guardada o la primera entrada del diario, la app pide al sistema que muestre el diálogo de valoración de
  la tienda (Google Play In-App Review en Android, StoreKit en iOS). La tienda decide si aparece; la app no recibe la
  nota ni el texto, no sabe si se valoró y no envía nada. En Android es una llamada entre procesos (IPC) a la app de Play
  Store del teléfono. Se apunta en `shared_preferences` que ya se pidió (`review_prompt_asked`, fuera de las copias) y no
  se vuelve a pedir; si la tienda no puede mostrar el diálogo (una app instalada sin Play, por ejemplo), lo cuenta
  (`review_prompt_unavailable`) y deja de intentarlo a la tercera.
- **Modo caballete** (Paleta): mientras está abierto, `wakelock_plus` (`lib/ui/screen_awake.dart`) mantiene la pantalla
  encendida (una bandera de la ventana en Android, el temporizador de reposo en iOS) y la suelta al cerrarlo. No pide
  permisos (no declara `WAKE_LOCK`) ni guarda o envía datos.
- **Accesos directos en la pantalla de inicio** (`quick_actions`, `lib/ui/shell/app_shortcuts.dart`): una pulsación
  larga en el icono (Android) o las acciones rápidas (iOS) abren Emparejar, Nueva paleta o Buscar muestras. Son tres
  entradas fijas con textos de la app: no llevan datos del usuario ni piden permisos.
- **Paletas y colecciones como texto:** «Compartir como texto» (Paleta), la exportación de la colección en CSV o texto
  y la receta traducida (Herramientas) se entregan, solo al tocarlas, al menú de compartir del sistema o al portapapeles
  (`lib/ui/pages/palette/palette_text_flow.dart`, `lib/ui/pages/tools/`). «Importar desde texto» y la importación de
  códigos leen solo el texto que el usuario pega o escribe, con un tope de tamaño (`lib/core/palette_text.dart`), y no
  abren enlaces.
- **Sin analítica ni dependencias de rastreo propias:** `pubspec.yaml` no incluye SDK de analítica, publicidad ni
  informes de errores. La única telemetría es la de ML Kit hacia Google descrita arriba, solo con la IA activada. La app
  no usa el identificador publicitario.
- **Registro de errores local, que nunca se envía solo:** los errores inesperados que captura `runGuardedByErrorLog`
  (`lib/main.dart`, `lib/core/error_log.dart`) se añaden a `ink-lab-errors.log` en
  `getApplicationSupportDirectory()/error_log/` (almacenamiento privado de la app). Cada anotación: hora, versión de la
  app, plataforma y versión del sistema, dónde se capturó el error, la primera línea del mensaje (como máximo 300
  caracteres) y una traza recortada (como máximo 40 líneas y 4000 caracteres). Antes de escribir, `ErrorLog.redact`
  sustituye los parámetros de las URL, los tokens bearer, los secretos con nombre y las claves `sk-`, los tokens largos,
  las direcciones de correo y los nombres de carpeta de la app y del usuario. Al llegar a unos 200 KB el fichero pasa a
  `ink-lab-errors.1.log` (se conserva un único fichero anterior). No hay subida ni SDK de informes de errores. Ajustes →
  Acerca de: «Compartir registro de errores» entrega el texto al menú de compartir del sistema (`share_plus`,
  `lib/ui/share/share_sink.dart`, `lib/ui/pages/settings/about_section.dart`) y «Borrar registro de errores» borra los
  dos ficheros. Android: dominio `file`, excluido de la copia y de la transferencia; iOS: dentro del contenedor de la
  app, así que puede entrar en la copia del iPhone o de iCloud del usuario.
- **App gratuita y de código abierto:** código MIT, contenido propio CC BY-SA 4.0 (`LICENSE`, `LICENSE-CONTENT.es.md`).
- Todo funciona sin pedir nombre, correo, teléfono ni edad.

## Qué se guarda en el móvil
En `shared_preferences` (almacenamiento privado de la app): marca activa, packs y rotuladores propios, favoritos
(`favorite_marker_ids`), lista de deseos (`wishlist_marker_ids`, ids de rotulador con marca), rotuladores marcados como
secos (`dried_marker_ids`), nivel de tinta: rotuladores que se acaban (`running_out_marker_ids`), notas de recarga de hasta 80
caracteres (`marker_refill_notes`), los nombres de archivo de las fotos de las muestras reales en papel
(`marker_swatch_photos`; las fotos son archivos en la carpeta privada de la app, junto a las del diario), colores propios
por rotulador (`own_marker_colors`, `brandId:CODE` → hex: solo el hex
derivado, nunca la foto), paletas guardadas (`saved_palettes:<brandId>`), historial de las últimas elecciones de Match
(`color_match_history`: color muestreado, rotulador emparejado y distancia; nunca la foto), el diario de obras
(`artwork_diary`, solo en instalaciones anteriores a la 1.0.0: al arrancar se pasa a su propio fichero, ver abajo),
las ideas favoritas y las vistas hace poco (`idea_favorites`, `idea_recent`: solo ids de idea,
`lib/data/idea_favorites_repository.dart`), el borrador de la bienvenida (`onboarding_draft`: marca y packs elegidos
hasta pulsar Empezar u Omitir, que lo borran), si ya se pidió la valoración en la tienda (`review_prompt_asked`,
`review_prompt_unavailable`), preferencias de apariencia, la fecha del último archivo de copia
(`last_backup_at`, milisegundos desde epoch; se muestra en Ajustes y sirve para proponer una copia nueva pasados 30
días; nunca entra en una copia) y los ajustes de IA **sin la clave** (`ai_settings`). Sin identificadores de dispositivo
ni de usuario. La clave de OpenRouter, si el usuario la guarda, va aparte: Android Keystore (`flutter_secure_storage`) o
Keychain de iOS «solo este dispositivo» (`lib/data/secure_secret_store.dart`).

El widget de Android para la pantalla de inicio («Idea del día») lee su propio fichero privado de preferencias,
`HomeWidgetPreferences` (clave `ideas`), que escribe la app: el catálogo de ideas en el idioma de la app (título,
resumen, categoría y minutos) y hasta cinco colores hex por idea, elegidos entre los rotuladores del usuario
(`lib/data/idea_widget_sync.dart`). Sin identificadores, notas, fotos ni datos del diario. El widget se actualiza solo
con una alarma no exacta a medianoche (sin permiso de alarmas exactas); los permisos de WorkManager que añadiría la
librería del widget (`WAKE_LOCK`, `RECEIVE_BOOT_COMPLETED`, `FOREGROUND_SERVICE`) se quitan del manifiesto.

El diario de obras (título, fecha, sobre qué se pintó, estado, rotuladores usados, paleta enlazada y notas) es un
fichero JSON propio, `artwork_diary.json`, en `getApplicationDocumentsDirectory()`, que se reemplaza de forma atómica y
deja una copia `.bak` del anterior (`lib/data/artwork_diary_storage.dart`). Las recetas de mezcla propias
(Herramientas → Mis recetas: nombre, rotuladores, notas y una foto opcional) van en `blend_recipes.json`, en la misma
carpeta y con las mismas garantías (`lib/data/blend_recipe_repository.dart`).

Las fotos del diario no están en `shared_preferences`: son ficheros en `getApplicationDocumentsDirectory()/artworks/` (la
carpeta `artworks/` del directorio de documentos de la app), como máximo 4 por entrada, y se copian reducidas a 2048
píxeles de lado al añadirlas (`lib/main.dart`, `lib/data/artwork_photo_store.dart`). El diario guarda solo el **nombre**
del fichero, nunca una ruta (`lib/data/artwork_diary_repository.dart`). Las fotos se borran al quitar la foto o la
entrada, y con la app al desinstalarla.

La foto de la muestra real en papel de un rotulador (la fila «Muestra real» del detalle) es un fichero en la misma
carpeta, con un nombre que empieza por `sw-`, una por rotulador, reducida por el selector a unos 1024 píxeles de lado
(`lib/data/marker_extras_repository.dart`). Sigue las mismas reglas que las del diario: nunca se envía, se borra al
quitarla o sustituirla, viaja en el ZIP de la copia y no en la del portapapeles, y la copia del sistema de Android la
deja fuera. La foto de una receta de mezcla es otro fichero de esa carpeta (reducida a 2048 píxeles de lado, JPEG de
calidad 85) con las mismas reglas: nunca se envía, se borra al quitarla o al borrar la receta y viaja en el ZIP.

| Dónde | Qué pasa |
|---|---|
| Copia del sistema de Android | **Desactivada:** `allowBackup="false"` y reglas explícitas que excluyen las preferencias (`sharedpref`), la base de datos (`database`), los ficheros de la app (`file`) y `root/app_flutter/`, que es `getApplicationDocumentsDirectory()` (las fotos del diario), tanto en la copia en la nube como en la transferencia entre móviles (`android/app/src/main/res/xml/backup_rules.xml`, `android/app/src/main/res/xml/data_extraction_rules.xml`). Ni los ajustes, ni la clave, ni las fotos, ni el registro de errores (`files/error_log/`) salen por esa vía. |
| Copia del sistema de iOS | **Sin banderas de exclusión:** la app no declara ninguna. La clave está en el Keychain «solo este dispositivo» y no pasa a otro iPhone; las preferencias, el diario, las recetas de mezcla, todas las fotos guardadas y el registro de errores sí entran en la copia del iPhone o de iCloud que gestiona el usuario con su Apple ID. |
| Copia `Exportar` de la app (portapapeles) | Ver «Copia de seguridad». Nunca incluye la clave ni las fotos: solo el nombre interno de los ficheros de las fotos. |
| Copia en archivo de la app (ZIP) | Ver «Copia de seguridad». Lleva el mismo documento y, además, las fotos del diario, de las muestras reales y de las recetas; nunca la clave. Solo sale del móvil por el menú de compartir del sistema, a donde el usuario la mande. |

## Permisos
Se piden cuando el usuario toca la función, nunca al arrancar.

| Permiso | Para qué | Dónde |
|---|---|---|
| Cámara y fotos (`NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` en iOS; selector del sistema en Android) | Emparejar el color de una foto con un rotulador, sacar los colores principales de una foto para una paleta («Escena desde una foto»), leer el color propio de un rotulador en la foto de una muestra pintada («Mi color»; solo se guarda el hex) y añadir fotos a una entrada del «Diario» (Ideas → Diario), la foto de la muestra real de un rotulador («Muestra real», en el detalle) o la de una receta de mezcla (Herramientas). La foto se decodifica y se analiza **en el móvil** y nunca se envía a ningún proveedor de IA. En «Emparejar», «Escena desde una foto» y «Mi color» no se guarda; en el «Diario», en «Muestra real» y en las recetas se guarda una copia reducida en la carpeta privada de la app (ver «Qué se guarda en el móvil»). | `ios/Runner/Info.plist`, `lib/ui/pages/match/`, `lib/ui/pages/palette/palette_photo_scene.dart`, `lib/ui/pages/swatches/`, `lib/ui/pages/diary/`, `lib/ui/pages/tools/blend_recipe_page.dart` |
| Red (`INTERNET`, y `ACCESS_NETWORK_STATE` vía ML Kit, Android) | Solo con la IA activada: la IA opcional con OpenRouter y los diagnósticos de ML Kit a Google al usar la IA en el móvil. Con la IA apagada, la app no abre ningún socket. | `AndroidManifest.xml`, manifiesto fusionado |

Sin permisos de ubicación, contactos, calendario, micrófono, almacenamiento general, notificaciones ni identificador
publicitario. El modo caballete, los accesos directos y la valoración en la tienda no añaden permisos.
`ios/Runner/PrivacyInfo.xcprivacy` declara sin seguimiento y sin datos recogidos, y dos API con motivo: `UserDefaults`
(`CA92.1`) y las fechas de los ficheros (`NSPrivacyAccessedAPICategoryFileTimestamp`, `C617.1`), que enlaza
`package_info_plus` (dependencia de `wakelock_plus`) y que solo se usan con los ficheros de la propia app, dentro de su
contenedor. Compartir una paleta, una carta de muestras o una entrada del diario como imagen,
la copia en archivo o el registro de errores, no necesita permiso: la imagen, el ZIP o el registro solo se entregan a la
app que el usuario elige en el menú de compartir del sistema (`share_plus`, `lib/ui/share/`,
`lib/ui/pages/settings/backup_file_io.dart`). Elegir un archivo de copia tampoco: `file_selector` abre el selector de
documentos del sistema sin declarar ningún permiso.

## IA opcional
Apagada por defecto. Antes de activarla, la app muestra qué saldría del móvil.

- **Motor local (teoría del color):** no usa IA ni red.
- **En el móvil (Gemini Nano, Android):** el escenario y los códigos de color se procesan en el teléfono; ML Kit envía
  a Google los diagnósticos descritos en «Flujo de datos».
- **OpenRouter con clave propia:** solo con la IA activada, OpenRouter elegido, clave guardada y al pulsar «Sugerir con
  IA» (o al abrir la lista de modelos). La app envía, desde el móvil a `openrouter.ai` por HTTPS y con la clave del
  usuario en la cabecera `Authorization` (`lib/ai/open_router_client.dart`, `lib/ai/open_router_palette_advisor.dart`):
  marca (`BRAND_ID`, `BRAND_LABEL`), modo de paleta (`MODE`), nombre de la escena en inglés (`SCENARIO`), código y
  nombre del rotulador base si lo hay (`BASE_CODE`, `BASE_NAME`), si está fijado (`BASE_LOCKED`), tamaño de la paleta
  (`PALETTE_SIZE`), códigos y hex del catálogo de los candidatos sin sus nombres (`AVAILABLE_COLORS`; nunca los colores
  propios, `test/ai/own_color_privacy_test.dart`), ajustes de generación (modelo, temperatura, límite de tokens), un
  prompt de sistema fijo y la cabecera `X-Title: Ink Lab`. La consulta del catálogo de modelos envía la clave. **Nunca**
  se envían fotos (`IMAGE_ATTACHED=false`; ningún camino del código adjunta una imagen), colores propios, favoritos,
  paletas guardadas ni identificadores. OpenRouter y el proveedor del modelo ven la IP del dispositivo, como en
  cualquier conexión, y aplican sus propias condiciones y su conservación (https://openrouter.ai/privacy); el
  desarrollador no ve nada.
- Si la IA falla, la app vuelve al motor local. Importar una copia de seguridad nunca activa la IA.

## Copia de seguridad
«Exportar copia» (Ajustes) genera un **texto JSON** (no un fichero), con versión (`version`) y **sin cifrar**, con estas
secciones: ajustes de la app (`appSettings`), paletas guardadas (`savedPalettes`), historial de Match
(`colorMatchHistory`), colores propios (`ownColors`), lista de deseos (`wishlist`), rotuladores secos (`driedMarkers`),
rotuladores que se acaban (`runningOutMarkers`), notas de recarga (`refillNotes`), nombres de las fotos de muestras
(`swatchPhotos`), entradas del diario (`artworkDiary`), recetas de mezcla (`blendRecipes`, con el nombre de su foto), los ajustes de IA no secretos (`aiSettings`) y las ideas favoritas y vistas hace
poco (`ideaFavorites`, `recentIdeas`) (`lib/data/backup_service.dart`). Lo entrega **copiándolo al portapapeles**;
«Importar copia» lo recibe pegándolo.
Dónde acabe ese texto es decisión del usuario. El portapapeles del sistema puede ser visible para el teclado o para
otras apps según el sistema operativo, así que conviene no dejar la copia pegada. La clave de API nunca forma parte de
la copia, y las fotos (del diario, de las muestras y de las recetas) tampoco: las entradas viajan con el **nombre interno** del fichero de cada foto, nunca
con la foto.

Al importar, la copia **reemplaza** los datos que trae; las secciones que no estén en ella se dejan como están. Como el
diario va completo, las entradas que no estén en la copia se **borran junto con sus fotos**, y la app lo avisa antes de
importar («¿Reemplazar tus datos actuales?»).

**Copia en archivo** (Ajustes → Tus datos → Copia en archivo, `lib/ui/pages/settings/backup_section.dart`). «Guardar
copia en un archivo» construye en memoria un ZIP (`package:archive`, `lib/data/backup_archive.dart`) con `manifest.json`
(formato `ink-lab-backup`, versión del formato, versión de la app y número de fotos), `backup.json` (exactamente el
mismo documento que la copia del portapapeles: **nunca la clave de API**) y `photos/<nombre>` con las fotos del diario,
de las muestras reales y de las recetas de mezcla que referencia el documento. `SystemBackupFileIo` (`lib/ui/pages/settings/backup_file_io.dart`) lo escribe como
`ink-lab-backup-AAAA-MM-DD.zip` en la carpeta temporal de la app (`getTemporaryDirectory()`, caché que el sistema puede
vaciar), borra antes los `ink-lab-backup-*.zip` anteriores de esa carpeta y abre el menú de compartir del sistema
(`share_plus`): el archivo solo va a donde el usuario lo mande (Archivos, Drive, otra app...); no se borra al cerrar el
menú porque la app elegida puede seguir leyéndolo, y lo borra el siguiente guardado. «Restaurar desde un archivo» abre
el selector de documentos del sistema (`file_selector`, filtrado a ZIP; sin permisos declarados). En Android el selector
copia el archivo elegido a una carpeta propia dentro de la caché de la app; la app borra esa copia (nunca el original
del usuario) al terminar, con éxito o sin él. El archivo se comprueba entero antes de escribir nada (tamaño máximo 100
MB, entrada máxima 32 MB, 2000 entradas, nombres de foto saneados, cada foto decodificada como imagen); una copia
rechazada deja los datos y las fotos como estaban. Tras la confirmación, la importación reemplaza los datos como la del
portapapeles y, además, escribe las fotos del archivo y **borra las fotos del diario, de las muestras y de las recetas que no estén en él**; si una foto no
se puede escribir, se deshace y los datos quedan como estaban. La importación nunca activa la IA ni toca la clave.

## Soporte y enlaces
La dirección de soporte es **inklab@mainshai.com**. «Acerca de» ofrece **copiar** la URL del repositorio al
portapapeles; la app no abre el navegador. Solo abre el correo cuando tocas «Enviar comentarios» (Acerca de) o «Reportar
esta sugerencia» en un resultado de IA (Paleta), y no se envía nada si no mandas tú el correo. «Enviar comentarios»
(`lib/ui/pages/settings/feedback_email.dart`) prepara un `mailto:` a inklab@mainshai.com con el asunto
`Ink Lab <versión> feedback` y un cuerpo con espacio para escribir más la versión de la app, la plataforma y la versión del
sistema; no adjunta nada (tampoco el registro de errores) y, sin app de correo, se copia la dirección al portapapeles.
«Reportar esta sugerencia» abre un mensaje ya escrito para inklab@mainshai.com que tú decides si envías: motivo,
versión, proveedor y modelo, marca, modo o escena y los códigos y textos de la sugerencia; nunca la clave de API ni
fotos. Sin app de correo, el informe se copia al portapapeles. La política de privacidad se publica en
`https://inklab.mainshai.com/es/privacy/` (inglés: `https://inklab.mainshai.com/privacy/`), generada desde
`docs/legal/politica-privacidad.md` (`docs/legal/LEEME.md`).

## Declaraciones en tiendas
- App Store, App Privacy: la app no recoge datos y no hace seguimiento (iOS no tiene ML Kit; Apple Intelligence funciona en
  el dispositivo y no envía nada). Si se quiere ser prudente por la IA opcional
  con OpenRouter (un tercero integrado por el usuario con su propia clave), se puede declarar el envío opcional de
  «otros datos de uso» sin vincular a la identidad ni usar para seguimiento.
- Google Play, Seguridad de los datos: hay que declarar los datos que recoge el SDK ML Kit (identificadores del
  dispositivo, diagnósticos y otros datos de rendimiento; opcionales, solo con la IA activada; para analítica; cifrados
  en tránsito) y la petición opcional a OpenRouter. Respuestas finales en `docs/tienda/google-play.md`.
- Las fotos (del diario, de las muestras y de las recetas) nunca salen del móvil, así que los formularios no cambian: ni en Google Play (Seguridad de los
  datos) ni en Apple (etiquetas de privacidad) hay datos nuevos que recoger ni que compartir.
- Lo de la 0.8 tampoco los cambia: la copia en archivo y la imagen de una entrada del diario solo salen por el menú de
  compartir del sistema, a donde el usuario las mande (transferencia iniciada por el usuario, que las tiendas no
  cuentan como recogida ni compartición); las equivalencias entre marcas, la visión del color, los números del diario,
  las ideas favoritas y recientes y el catálogo Finecolour se calculan o van dentro de la app, sin red; el selector de
  archivos no añade permisos.
- El registro de errores, «Enviar comentarios» y la fecha de la última copia no envían nada por sí solos: el registro
  solo sale por el menú de compartir del sistema y el correo de comentarios por la app de correo del usuario, cuando él
  lo decide; la fecha se queda en el móvil. Con el binario final, comprobar si los formularios deben mencionar los
  diagnósticos (detalles del error, versión de la app y del sistema) que un usuario puede enviar a mano.
- Lo de la 1.0.0 tampoco los cambia: las fotos de las muestras y de las recetas, el nivel de tinta y las notas de
  recarga se quedan en el móvil; los catálogos nuevos van dentro de la app; el texto de una paleta o de la colección
  solo sale por el menú de compartir o el portapapeles, cuando lo decide el usuario; el modo caballete y los accesos
  directos no tratan datos; y el diálogo de valoración lo muestra la tienda (Play o App Store), sin que la app reciba ni
  envíe nada. En App Privacy no hay nada nuevo que declarar; el manifiesto ya incluye el motivo `C617.1`.
- No hay cuentas que borrar; los datos se eliminan desinstalando la app o borrando sus datos desde el sistema.
- Revisar los formularios con el AAB/IPA definitivo y publicar una URL de política coherente con estos hechos.

## Pendiente antes del lanzamiento en las tiendas
- [ ] Publicar la política (URL), enlazarla desde las dos tiendas y desde Ajustes si se quiere.
- [ ] Rellenar App Privacy (Apple) y Seguridad de los datos (Play) con el binario final.
- [ ] Revisar este documento cada vez que cambie el flujo de datos (permisos, copias, IA, exportaciones, soporte).
