<!--
No es asesoramiento jurídico. Resume qué hace la app con los datos, comprobado contra el código el 30-oct-2026;
conviene que lo revise un profesional antes del lanzamiento en las tiendas.
-->

# Privacidad y cumplimiento

Resume qué hace la app con los datos, comprobado contra el código el 30-oct-2026. La política para el usuario está en
[`docs/legal/politica-privacidad.md`](legal/politica-privacidad.md) y tiene que decir lo mismo que este documento.
English version: [`privacy.en.md`](privacy.en.md).

## Flujo de datos
- **Por defecto la app no habla con ningún servidor.** No hay cuentas, servidor propio, analítica ni telemetría
  propias, anuncios, compras ni informes de errores. Con la IA apagada no hay tráfico de red (medido en emulador) y la
  app no llama a ML Kit. Los catálogos de rotuladores van incluidos en la app (`assets/data/`) y el
  motor de paletas es Dart local (`lib/core/`): todo funciona sin conexión.
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
En `shared_preferences` (almacenamiento privado de la app): marca activa, packs y rotuladores propios, favoritos,
paletas guardadas, historial de las últimas elecciones de Match (color muestreado, rotulador emparejado y distancia;
nunca la foto), preferencias de apariencia y los ajustes de IA **sin la clave**. Sin identificadores de
dispositivo ni de usuario. La clave de OpenRouter, si el usuario la guarda, va aparte: Android Keystore
(`flutter_secure_storage`) o Keychain de iOS «solo este dispositivo» (`lib/data/secure_secret_store.dart`).

| Dónde | Qué pasa |
|---|---|
| Copia del sistema de Android | **Desactivada:** `allowBackup="false"` y reglas explícitas que excluyen todo (`backup_rules.xml`, `data_extraction_rules.xml`), también la transferencia entre móviles. Ni los ajustes ni la clave salen por esa vía. |
| Copia del sistema de iOS | La clave está en el Keychain «solo este dispositivo» y no pasa a otro iPhone. Las preferencias entran en la copia del iPhone que gestiona el usuario con su Apple ID. |
| Copia `Exportar` de la app | Ver «Copia de seguridad». Nunca incluye la clave. |

## Permisos
Se piden cuando el usuario toca la función, nunca al arrancar.

| Permiso | Para qué | Dónde |
|---|---|---|
| Cámara y fotos (`NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` en iOS; selector del sistema en Android) | Emparejar el color de una foto con un rotulador, y sacar los colores principales de una foto para una paleta («Escena desde una foto»). La foto se decodifica y se analiza **en el móvil**; no se sube, no se guarda y no se envía a ningún proveedor de IA. | `ios/Runner/Info.plist`, `lib/ui/pages/match/`, `lib/ui/pages/palette/palette_photo_scene.dart` |
| Red (`INTERNET`, y `ACCESS_NETWORK_STATE` vía ML Kit, Android) | Solo con la IA activada: la IA opcional con OpenRouter y los diagnósticos de ML Kit a Google al usar la IA en el móvil. Con la IA apagada, la app no abre ningún socket. | `AndroidManifest.xml`, manifiesto fusionado |

Sin permisos de ubicación, contactos, calendario, micrófono, almacenamiento general, notificaciones ni
identificador publicitario. `ios/Runner/PrivacyInfo.xcprivacy` declara sin seguimiento y sin datos recogidos; solo
usa la API de `UserDefaults` con el motivo `CA92.1`.

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
  (`PALETTE_SIZE`), códigos y hex de los candidatos sin sus nombres (`AVAILABLE_COLORS`), ajustes de generación
  (modelo, temperatura, límite de tokens), un prompt de sistema fijo y la cabecera `X-Title: Ink Lab`. La consulta del
  catálogo de modelos envía la clave. **Nunca** se envían fotos (`IMAGE_ATTACHED=false`; ningún camino del código
  adjunta una imagen), favoritos, paletas guardadas ni identificadores. OpenRouter y el proveedor del modelo ven la IP
  del dispositivo, como en cualquier conexión, y aplican sus propias condiciones y su conservación
  (https://openrouter.ai/privacy); el desarrollador no ve nada.
- Si la IA falla, la app vuelve al motor local. Importar una copia de seguridad nunca activa la IA.

## Copia de seguridad
«Exportar copia» (Ajustes) genera un JSON con versión, **sin cifrar**, con las colecciones, favoritos, paletas
guardadas, historial de Match y los ajustes no secretos (`lib/data/backup_service.dart`). Lo entrega **copiándolo al
portapapeles**; «Importar copia» lo recibe pegándolo. Dónde acabe ese texto es decisión del usuario. El portapapeles
del sistema puede ser visible para el teclado o para otras apps según el sistema operativo, así que conviene no dejar
la copia pegada. La clave de API nunca forma parte de la copia.

## Soporte y enlaces
La dirección de soporte es **dev@mainshai.com**. «Acerca de» ofrece **copiar** la URL del repositorio al portapapeles;
la app no abre el navegador ni el correo por sí misma. La política de privacidad se publica en
`https://dferrandizmont.github.io/ink-lab/privacidad/` (inglés: `.../privacidad/en/`), generada desde
`docs/legal/politica-privacidad.md` (`docs/legal/LEEME.md`).

## Declaraciones en tiendas
- App Store, App Privacy: la app no recoge datos y no hace seguimiento (iOS no tiene ML Kit). Si se quiere ser prudente por la IA opcional
  con OpenRouter (un tercero integrado por el usuario con su propia clave), se puede declarar el envío opcional de
  «otros datos de uso» sin vincular a la identidad ni usar para seguimiento.
- Google Play, Seguridad de los datos: hay que declarar los datos que recoge el SDK ML Kit (identificadores del
  dispositivo, diagnósticos y otros datos de rendimiento; opcionales, solo con la IA activada; para analítica; cifrados
  en tránsito) y la petición opcional a OpenRouter. Respuestas finales en `docs/tienda/google-play.md`.
- No hay cuentas que borrar; los datos se eliminan desinstalando la app o borrando sus datos desde el sistema.
- Revisar los formularios con el AAB/IPA definitivo y publicar una URL de política coherente con estos hechos.

## Pendiente antes del lanzamiento en las tiendas
- [ ] Publicar la política (URL), enlazarla desde las dos tiendas y desde Ajustes si se quiere.
- [ ] Rellenar App Privacy (Apple) y Seguridad de los datos (Play) con el binario final.
- [ ] Revisar este documento cada vez que cambie el flujo de datos (permisos, copias, IA, exportaciones, soporte).
