<!--
No es asesoramiento jurídico. Resume qué hace la app con los datos, comprobado contra el código el 1-nov-2026;
conviene que lo revise un profesional antes del lanzamiento en las tiendas.
-->

# Privacidad y cumplimiento

Resume qué hace la app con los datos, comprobado contra el código el 1-nov-2026. La política para el usuario está en
[`docs/legal/politica-privacidad.md`](legal/politica-privacidad.md) y tiene que decir lo mismo que este documento.
English version: [`privacy.en.md`](privacy.en.md).

## Flujo de datos
- **Por defecto la app no habla con ningún servidor.** No hay cuentas, servidor propio, analítica ni telemetría
  propias, anuncios, compras ni informes de errores. Con la IA apagada no hay tráfico de red (medido en emulador) y la
  app no llama a ML Kit. Los catálogos de rotuladores (Ohuhu, Copic y Finecolour, `assets/data/*_colors.json`) van
  incluidos en la app y el motor de paletas es Dart local (`lib/core/`): todo funciona sin conexión. También se
  calculan solo en el móvil, con esos catálogos y los datos del usuario, las equivalencias «En otras marcas» del
  detalle de un rotulador, la previsualización «Visión del color» de Paleta (solo cambia lo que se dibuja; guardar y
  compartir usan los colores reales) y los «Números del diario».
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
  Google), no la app. iOS aún no tiene modelo en el dispositivo ni ML Kit.
- **Sin analítica ni dependencias de rastreo propias:** `pubspec.yaml` no incluye SDK de analítica, publicidad ni
  informes de errores. La única telemetría es la de ML Kit hacia Google descrita arriba, solo con la IA activada. La app
  no usa el identificador publicitario.
- **App gratuita y de código abierto:** código MIT, contenido propio CC BY-SA 4.0 (`LICENSE`, `LICENSE-CONTENT.es.md`).
- Todo funciona sin pedir nombre, correo, teléfono ni edad.

## Qué se guarda en el móvil
En `shared_preferences` (almacenamiento privado de la app): marca activa, packs y rotuladores propios, favoritos
(`favorite_marker_ids`), lista de deseos (`wishlist_marker_ids`, ids de rotulador con marca), rotuladores marcados
como secos (`dried_marker_ids`), colores propios por rotulador (`own_marker_colors`, `brandId:CODE` → hex: solo el hex
derivado, nunca la foto), paletas guardadas (`saved_palettes:<brandId>`), historial de las últimas elecciones de Match
(`color_match_history`: color muestreado, rotulador emparejado y distancia; nunca la foto), el diario de obras
(`artwork_diary`: título, fecha, sobre qué se pintó, estado, rotuladores usados, paleta enlazada y notas), las ideas
favoritas y las vistas hace poco (`idea_favorites`, `idea_recent`: solo ids de idea,
`lib/data/idea_favorites_repository.dart`), preferencias de apariencia y los ajustes de IA **sin la clave**
(`ai_settings`). Sin identificadores de dispositivo ni
de usuario. La clave de OpenRouter, si el usuario la guarda, va aparte: Android Keystore (`flutter_secure_storage`) o
Keychain de iOS «solo este dispositivo» (`lib/data/secure_secret_store.dart`).

Las fotos del diario no están en `shared_preferences`: son ficheros en `getApplicationDocumentsDirectory()/artworks/` (la
carpeta `artworks/` del directorio de documentos de la app), como máximo 4 por entrada, y se copian reducidas a 2048
píxeles de lado al añadirlas (`lib/main.dart`, `lib/data/artwork_photo_store.dart`). El diario guarda solo el **nombre**
del fichero, nunca una ruta (`lib/data/artwork_diary_repository.dart`). Las fotos se borran al quitar la foto o la
entrada, y con la app al desinstalarla.

| Dónde | Qué pasa |
|---|---|
| Copia del sistema de Android | **Desactivada:** `allowBackup="false"` y reglas explícitas que excluyen las preferencias (`sharedpref`), la base de datos (`database`), los ficheros de la app (`file`) y `root/app_flutter/`, que es `getApplicationDocumentsDirectory()` (las fotos del diario), tanto en la copia en la nube como en la transferencia entre móviles (`android/app/src/main/res/xml/backup_rules.xml`, `android/app/src/main/res/xml/data_extraction_rules.xml`). Ni los ajustes, ni la clave, ni las fotos salen por esa vía. |
| Copia del sistema de iOS | **Sin banderas de exclusión:** la app no declara ninguna. La clave está en el Keychain «solo este dispositivo» y no pasa a otro iPhone; las preferencias y las fotos del diario sí entran en la copia del iPhone o de iCloud que gestiona el usuario con su Apple ID. |
| Copia `Exportar` de la app (portapapeles) | Ver «Copia de seguridad». Nunca incluye la clave ni las fotos: solo el nombre interno de los ficheros de las fotos del diario. |
| Copia en archivo de la app (ZIP) | Ver «Copia de seguridad». Lleva el mismo documento y, además, las fotos del diario; nunca la clave. Solo sale del móvil por el menú de compartir del sistema, a donde el usuario la mande. |

## Permisos
Se piden cuando el usuario toca la función, nunca al arrancar.

| Permiso | Para qué | Dónde |
|---|---|---|
| Cámara y fotos (`NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` en iOS; selector del sistema en Android) | Emparejar el color de una foto con un rotulador, sacar los colores principales de una foto para una paleta («Escena desde una foto»), leer el color propio de un rotulador en la foto de una muestra pintada («Mi color»; solo se guarda el hex) y añadir fotos a una entrada del «Diario» (Ideas → Diario). La foto se decodifica y se analiza **en el móvil** y nunca se envía a ningún proveedor de IA. En «Emparejar», «Escena desde una foto» y «Mi color» no se guarda; en el «Diario» se guarda una copia reducida en la carpeta privada de la app (ver «Qué se guarda en el móvil»). | `ios/Runner/Info.plist`, `lib/ui/pages/match/`, `lib/ui/pages/palette/palette_photo_scene.dart`, `lib/ui/pages/swatches/own_color_page.dart`, `lib/ui/pages/diary/` |
| Red (`INTERNET`, y `ACCESS_NETWORK_STATE` vía ML Kit, Android) | Solo con la IA activada: la IA opcional con OpenRouter y los diagnósticos de ML Kit a Google al usar la IA en el móvil. Con la IA apagada, la app no abre ningún socket. | `AndroidManifest.xml`, manifiesto fusionado |

Sin permisos de ubicación, contactos, calendario, micrófono, almacenamiento general, notificaciones ni
identificador publicitario. `ios/Runner/PrivacyInfo.xcprivacy` declara sin seguimiento y sin datos recogidos; solo
usa la API de `UserDefaults` con el motivo `CA92.1`.
Compartir una paleta, una carta de muestras o una entrada del diario como imagen, o la copia en archivo, no necesita
permiso: la imagen o el ZIP solo se entregan a la app que el usuario elige en el menú de compartir del sistema
(`share_plus`, `lib/ui/share/`, `lib/ui/pages/settings/backup_file_io.dart`). Elegir un archivo de copia tampoco:
`file_selector` abre el selector de documentos del sistema sin declarar ningún permiso.

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
entradas del diario (`artworkDiary`), los ajustes de IA no secretos (`aiSettings`) y las ideas favoritas y vistas hace
poco (`ideaFavorites`, `recentIdeas`) (`lib/data/backup_service.dart`). Lo entrega **copiándolo al portapapeles**;
«Importar copia» lo recibe pegándolo.
Dónde acabe ese texto es decisión del usuario. El portapapeles del sistema puede ser visible para el teclado o para
otras apps según el sistema operativo, así que conviene no dejar la copia pegada. La clave de API nunca forma parte de
la copia, y las fotos del diario tampoco: las entradas viajan con el **nombre interno** del fichero de cada foto, nunca
con la foto.

Al importar, la copia **reemplaza** los datos que trae; las secciones que no estén en ella se dejan como están. Como el
diario va completo, las entradas que no estén en la copia se **borran junto con sus fotos**, y la app lo avisa antes de
importar («¿Reemplazar tus datos actuales?»).

**Copia en archivo** (Ajustes → Tus datos → Copia en archivo, `lib/ui/pages/settings/backup_section.dart`). «Guardar
copia en un archivo» construye en memoria un ZIP (`package:archive`, `lib/data/backup_archive.dart`) con `manifest.json`
(formato `ink-lab-backup`, versión del formato, versión de la app y número de fotos), `backup.json` (exactamente el
mismo documento que la copia del portapapeles: **nunca la clave de API**) y `photos/<nombre>` con las fotos del diario
que referencian las entradas. `SystemBackupFileIo` (`lib/ui/pages/settings/backup_file_io.dart`) lo escribe como
`ink-lab-backup-AAAA-MM-DD.zip` en la carpeta temporal de la app (`getTemporaryDirectory()`, caché que el sistema puede
vaciar), borra antes los `ink-lab-backup-*.zip` anteriores de esa carpeta y abre el menú de compartir del sistema
(`share_plus`): el archivo solo va a donde el usuario lo mande (Archivos, Drive, otra app...); no se borra al cerrar el
menú porque la app elegida puede seguir leyéndolo, y lo borra el siguiente guardado. «Restaurar desde un archivo» abre
el selector de documentos del sistema (`file_selector`, filtrado a ZIP; sin permisos declarados). En Android el selector
copia el archivo elegido a una carpeta propia dentro de la caché de la app; la app borra esa copia (nunca el original
del usuario) al terminar, con éxito o sin él. El archivo se comprueba entero antes de escribir nada (tamaño máximo 100
MB, entrada máxima 32 MB, 2000 entradas, nombres de foto saneados, cada foto decodificada como imagen); una copia
rechazada deja los datos y las fotos como estaban. Tras la confirmación, la importación reemplaza los datos como la del
portapapeles y, además, escribe las fotos del archivo y **borra las fotos del diario que no estén en él**; si una foto no
se puede escribir, se deshace y los datos quedan como estaban. La importación nunca activa la IA ni toca la clave.

## Soporte y enlaces
La dirección de soporte es **inklab@mainshai.com**. «Acerca de» ofrece **copiar** la URL del repositorio al portapapeles;
la app no abre el navegador. Solo abre el correo cuando tocas «Reportar esta sugerencia» en un resultado de IA
(Paleta), con un mensaje ya escrito para inklab@mainshai.com que tú decides si envías: motivo, versión, proveedor y
modelo, marca, modo o escena y los códigos y textos de la sugerencia; nunca la clave de API ni fotos. Sin app de
correo, el informe se copia al portapapeles. La política de privacidad se publica en
`https://inklab.mainshai.com/es/privacy/` (inglés: `https://inklab.mainshai.com/privacy/`), generada desde
`docs/legal/politica-privacidad.md` (`docs/legal/LEEME.md`).

## Declaraciones en tiendas
- App Store, App Privacy: la app no recoge datos y no hace seguimiento (iOS no tiene ML Kit). Si se quiere ser prudente por la IA opcional
  con OpenRouter (un tercero integrado por el usuario con su propia clave), se puede declarar el envío opcional de
  «otros datos de uso» sin vincular a la identidad ni usar para seguimiento.
- Google Play, Seguridad de los datos: hay que declarar los datos que recoge el SDK ML Kit (identificadores del
  dispositivo, diagnósticos y otros datos de rendimiento; opcionales, solo con la IA activada; para analítica; cifrados
  en tránsito) y la petición opcional a OpenRouter. Respuestas finales en `docs/tienda/google-play.md`.
- Las fotos del diario nunca salen del móvil, así que los formularios no cambian: ni en Google Play (Seguridad de los
  datos) ni en Apple (etiquetas de privacidad) hay datos nuevos que recoger ni que compartir.
- Lo de la 0.8 tampoco los cambia: la copia en archivo y la imagen de una entrada del diario solo salen por el menú de
  compartir del sistema, a donde el usuario las mande (transferencia iniciada por el usuario, que las tiendas no
  cuentan como recogida ni compartición); las equivalencias entre marcas, la visión del color, los números del diario,
  las ideas favoritas y recientes y el catálogo Finecolour se calculan o van dentro de la app, sin red; el selector de
  archivos no añade permisos.
- No hay cuentas que borrar; los datos se eliminan desinstalando la app o borrando sus datos desde el sistema.
- Revisar los formularios con el AAB/IPA definitivo y publicar una URL de política coherente con estos hechos.

## Pendiente antes del lanzamiento en las tiendas
- [ ] Publicar la política (URL), enlazarla desde las dos tiendas y desde Ajustes si se quiere.
- [ ] Rellenar App Privacy (Apple) y Seguridad de los datos (Play) con el binario final.
- [ ] Revisar este documento cada vez que cambie el flujo de datos (permisos, copias, IA, exportaciones, soporte).
