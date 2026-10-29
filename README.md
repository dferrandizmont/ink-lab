[Español](README.md) · [English](README.en.md)

<!--
TODO(imagenes): cuando existan la cabecera y las capturas, descomenta este bloque y sube los PNG a docs/readme/es/
(header.png de 1024 px). No se incluyen imágenes inventadas.
<p align="center">
  <img src="docs/readme/es/header.png" alt="Ink Lab — Tus rotuladores, tus paletas. Gratis y sin conexión." width="1024">
</p>
-->

# Ink Lab

[![Código: MIT](https://img.shields.io/badge/C%C3%B3digo-MIT-30382F)](LICENSE)
[![Contenido: CC BY-SA 4.0](https://img.shields.io/badge/Contenido-CC_BY--SA_4.0-30382F)](LICENSE-CONTENT.md)
[![Última versión](https://img.shields.io/github/v/release/dferrandizmont/ink-lab?include_prereleases&label=versi%C3%B3n)](https://github.com/dferrandizmont/ink-lab/releases)
[![CI](https://github.com/dferrandizmont/ink-lab/actions/workflows/ci.yml/badge.svg)](https://github.com/dferrandizmont/ink-lab/actions/workflows/ci.yml)

Compañero de muestras y paletas para quien dibuja con rotuladores de alcohol.
Busca el código de un color, descubre qué rotulador de tu colección se parece más
a una foto y construye paletas con teoría del color usando solo los rotuladores
que tienes.

**Gratis, sin anuncios, sin cuentas y sin conexión. Código abierto.** Para Android
e iOS, con modo claro y oscuro. La IA es opcional y está apagada de serie.

## Descargas

<p>
  <a href="https://github.com/dferrandizmont/ink-lab/releases/latest"><img src="https://img.shields.io/badge/Disponible_en-GitHub-181717?logo=github&amp;style=for-the-badge" alt="Disponible en GitHub"></a>
  <!--
  <a href="[ENLACE_GOOGLE_PLAY]"><img src="https://img.shields.io/badge/Google_Play-Descargar-414141?logo=googleplay&amp;style=for-the-badge" alt="Disponible en Google Play"></a>
  <a href="[ENLACE_APP_STORE]"><img src="https://img.shields.io/badge/App_Store-Descargar-0D96F6?logo=appstore&amp;style=for-the-badge" alt="Disponible en App Store"></a>
  -->
</p>

Puedes descargar el APK de la [última versión](https://github.com/dferrandizmont/ink-lab/releases/latest)
e instalarlo a mano (hay que permitir «instalar aplicaciones de origen desconocido»).
Cada versión lleva un `SHA256SUMS.txt` para comprobar la descarga con
`sha256sum -c SHA256SUMS.txt`.

Próximamente en Google Play y en App Store.

## Capturas

<!--
TODO(imagenes): sustituye este comentario por las capturas reales (pantallas con datos de prueba) en docs/readme/es/:
<p>
  <a href="docs/readme/es/01-muestras.png"><img src="docs/readme/es/01-muestras.png" width="160" alt="Muestras con código, nombre y color de cada rotulador"></a>
  <a href="docs/readme/es/02-foto.png"><img src="docs/readme/es/02-foto.png" width="160" alt="Color de una foto emparejado con el rotulador más cercano"></a>
  <a href="docs/readme/es/03-paleta.png"><img src="docs/readme/es/03-paleta.png" width="160" alt="Paleta por teoría del color con los rotuladores que tienes"></a>
  <a href="docs/readme/es/04-ideas.png"><img src="docs/readme/es/04-ideas.png" width="160" alt="Ideas con técnica y paleta sugerida"></a>
  <a href="docs/readme/es/05-ajustes.png"><img src="docs/readme/es/05-ajustes.png" width="160" alt="Ajustes: marca, packs, rotuladores propios y copia de seguridad"></a>
</p>
-->

Próximamente: capturas de pantalla, en preparación. Hay otra versión [en inglés](README.en.md#screenshots).

## Funciones

- **Muestras:** el catálogo por código y nombre, con el color hex de cada
  rotulador, búsqueda, filtro por tus packs y favoritos. Para Ohuhu Oahu indica
  además dónde está cada rotulador en la tarjeta de colores.
- **Emparejar con una foto:** haz una foto o elige una de la galería, toca un
  punto y la app te dice qué rotulador de tu colección se le parece más. La foto
  se procesa en el móvil; no se sube ni se guarda.
- **Paletas con teoría del color:** elige un color base y obtén armonías
  (complementarios, análogos, complementarios divididos, tríada, cuadrado,
  rectángulo, monocromo y sombra), resueltas siempre con los rotuladores que
  tienes. Todo esto funciona sin conexión y sin IA.
- **Ideas:** retos y técnicas con una paleta sugerida que tiene en cuenta tu
  colección activa.
- **Dos marcas:** Ohuhu Oahu (con el código nuevo y el antiguo) y DecoTime
  (con selección de rotuladores propios, porque se vende en sets cerrados).
- **IA opcional:** o bien **en el móvil** (Gemini Nano, en Android compatible;
  nada sale del móvil), o bien con **tu propia clave de OpenRouter**. Si no la
  activas, la app nunca usa la red.
- **Copia de seguridad:** exporta e importa tus colecciones, favoritos, paletas
  y ajustes como texto JSON, sin cuenta.
- Modo claro y oscuro, tablets con raíl lateral y textos en español e inglés.

## Privacidad

Todo se guarda en el móvil. No hay cuentas, servidor propio, analítica, anuncios
ni rastreo. La copia de seguridad de Android está desactivada. La cámara y la
galería solo se usan al emparejar una foto, y la foto nunca sale del dispositivo.

La IA es opcional:

- **En el móvil** (Gemini Nano): la petición se resuelve en tu teléfono.
- **OpenRouter con tu clave:** al pulsar «Sugerir con IA» se envía, directamente
  desde tu móvil a `openrouter.ai` y por HTTPS, la marca, el escenario, el color
  base y los candidatos (código, nombre y hex). La clave se guarda en el Keystore
  (Android) o el Keychain (iOS). Nunca se envían fotos, favoritos ni paletas
  guardadas, y el desarrollador no ve nada.

[Política de privacidad](https://dferrandizmont.github.io/ink-lab/privacidad/) ·
[Detalle técnico](docs/privacy.md) · Soporte: **dev@mainshai.com**.

## Datos y marcas

Ink Lab incluye catálogos sin conexión de **Ohuhu Oahu** y **DecoTime** (más de
300 colores por gama). Solo se guardan códigos, nombres, valores hex y la
pertenencia a sets, como datos factuales de referencia para que identifiques los
rotuladores que ya tienes. No hay logotipos, fotografías de producto ni tarjetas
de color de ninguna marca.

Proyecto independiente: **no está afiliado, patrocinado ni respaldado por Ohuhu
ni por DecoTime**. «Ohuhu», «Oahu» y «DecoTime» son marcas de sus propietarios.
Las fuentes públicas y los avisos completos están en [NOTICE.md](NOTICE.md). Si
un color, un nombre o un código es incorrecto, abre una incidencia de
[corrección de datos](https://github.com/dferrandizmont/ink-lab/issues/new).

## Compilar y probar

Requisitos: **Flutter 3.47.7** (canal estable), Android SDK para Android o macOS
con Xcode y CocoaPods para iPhone.

```bash
git clone https://github.com/dferrandizmont/ink-lab.git
cd ink-lab
flutter pub get
flutter analyze
flutter test
flutter run
```

Un APK de pruebas locales, firmado con la clave de depuración (nunca para
tiendas):

```bash
flutter build apk --release --android-project-arg=allowDebugSigning=true
```

Los APK públicos se firman con una clave del dueño que no está en el
repositorio. La estructura del código y
sus reglas están en [la arquitectura](docs/ARCHITECTURE.md). Para colaborar:
[CONTRIBUTING.md](CONTRIBUTING.md).

La selección pública se prepara con el [exportador](tool/publish/LEEME.md) y la
página de privacidad se genera con [web/legal](web/legal/LEEME.md).

## Novedades

Lo que cambia en cada versión está en [CHANGELOG.md](CHANGELOG.md).

## Licencias y seguridad

Código [MIT](LICENSE), Copyright (c) 2026 Daniel Mont Ferrandiz. Documentación y
textos propios: [CC BY-SA 4.0](LICENSE-CONTENT.md). Los datos de los catálogos
son referencias factuales de terceros y quedan fuera de MIT y de CC BY-SA 4.0;
las fuentes tipográficas (SIL OFL 1.1) y los materiales de terceros conservan
sus licencias, detalladas en [NOTICE.md](NOTICE.md).

Para comunicar una vulnerabilidad: [SECURITY.md](SECURITY.md).
