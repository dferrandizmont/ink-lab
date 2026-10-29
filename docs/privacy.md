<!--
No es asesoramiento jurídico. Resume qué hace la app con los datos, comprobado contra el código el 29-oct-2026;
conviene que lo revise un profesional antes del lanzamiento en las tiendas.
-->

# Privacidad y cumplimiento

Resume qué hace la app con los datos, comprobado contra el código el 29-oct-2026. La política para el usuario está en
[`docs/legal/politica-privacidad.md`](legal/politica-privacidad.md) y tiene que decir lo mismo que este documento.
English version: [`privacy.en.md`](privacy.en.md).

## Flujo de datos
- **Por defecto la app no habla con ningún servidor.** No hay cuentas, servidor propio, analítica, telemetría,
  anuncios, compras ni informes de errores. Los catálogos de rotuladores van incluidos en la app (`assets/data/`) y el
  motor de paletas es Dart local (`lib/core/`): todo funciona sin conexión.
- **Solo hay red si el usuario activa la IA con OpenRouter y pone su propia clave.** El manifiesto de Android declara
  `INTERNET` únicamente por esa vía opcional; `usesCleartextTraffic="false"` y `network_security_config.xml` rechazan
  el tráfico sin cifrar. El cliente (`lib/ai/open_router_client.dart`) solo habla con `openrouter.ai` por HTTPS, no
  sigue redirecciones, limita el tamaño de las respuestas y sanea el texto que recibe.
- **IA en el móvil (Android):** Gemini Nano mediante ML Kit GenAI y AICore (`lib/ai/platform_on_device_palette_advisor.dart`,
  `android/.../OnDeviceAiChannel.kt`). La petición se resuelve en el teléfono y la app no la envía a ningún sitio.
  Si el modelo no está en el móvil, Android lo descarga una vez y lo comparte entre apps; esa descarga la hace el
  sistema (servicios de Google), no la app. iOS aún no tiene modelo en el dispositivo.
- **Sin telemetría ni dependencias de rastreo:** `pubspec.yaml` no incluye SDK de analítica, publicidad ni informes de
  errores. La app no usa el identificador publicitario.
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
| Red (`INTERNET`, Android) | Solo la IA opcional con OpenRouter. Sin ella, la app no abre ningún socket. | `AndroidManifest.xml` |

Sin permisos de ubicación, contactos, calendario, micrófono, almacenamiento general, notificaciones ni
identificador publicitario. `ios/Runner/PrivacyInfo.xcprivacy` declara sin seguimiento y sin datos recogidos; solo
usa la API de `UserDefaults` con el motivo `CA92.1`.

## IA opcional
Apagada por defecto. Antes de activarla, la app muestra qué saldría del móvil.

- **Motor local (teoría del color):** no usa IA ni red.
- **En el móvil (Gemini Nano, Android):** el escenario y los códigos de color se procesan en el teléfono.
- **OpenRouter con clave propia:** al pedir una sugerencia, la app envía, desde el móvil a `openrouter.ai` y con la
  clave del usuario en la cabecera `Authorization`: la marca, el modo o escenario, el código, nombre y hex del
  color base, los códigos, nombres y hex de los candidatos de su colección, el tamaño de la paleta y los ajustes de
  generación (modelo, temperatura, límite de longitud). Para listar los modelos disponibles, la app consulta el
  catálogo de OpenRouter (con la clave, si está guardada). **Nunca** se envían fotos, favoritos, paletas guardadas ni
  identificadores. OpenRouter y el proveedor del modelo aplican sus propias condiciones; el desarrollador no ve nada.
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
- App Store, App Privacy: la app no recoge datos y no hace seguimiento. Si se quiere ser prudente por la IA opcional
  con OpenRouter (un tercero integrado por el usuario con su propia clave), se puede declarar el envío opcional de
  «otros datos de uso» sin vincular a la identidad ni usar para seguimiento.
- Google Play, Seguridad de los datos: sin datos recogidos por el desarrollador; la IA opcional envía datos a un tercero
  solo por decisión del usuario. Declarar el permiso de red y que el dispositivo cifra el tráfico (HTTPS).
- No hay cuentas que borrar; los datos se eliminan desinstalando la app o borrando sus datos desde el sistema.
- Revisar los formularios con el AAB/IPA definitivo y publicar una URL de política coherente con estos hechos.

## Pendiente antes del lanzamiento en las tiendas
- [ ] Publicar la política (URL), enlazarla desde las dos tiendas y desde Ajustes si se quiere.
- [ ] Rellenar App Privacy (Apple) y Seguridad de los datos (Play) con el binario final.
- [ ] Revisar este documento cada vez que cambie el flujo de datos (permisos, copias, IA, exportaciones, soporte).
