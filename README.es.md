[English](README.md) · **Español**

<p align="center">
  <img src="docs/readme/es/header.png" alt="Ink Lab — Tus rotuladores, tus paletas. Gratis y sin conexión." width="1024">
</p>

# Ink Lab

[![Código: MIT](https://img.shields.io/badge/C%C3%B3digo-MIT-30382F)](LICENSE)
[![Contenido: CC BY-SA 4.0](https://img.shields.io/badge/Contenido-CC_BY--SA_4.0-30382F)](LICENSE-CONTENT.es.md)
[![Versión](https://img.shields.io/github/v/release/dferrandizmont/ink-lab?include_prereleases&label=versi%C3%B3n&color=30382F)](https://github.com/dferrandizmont/ink-lab/releases)
[![Descargas](https://img.shields.io/github/downloads/dferrandizmont/ink-lab/total?label=descargas&color=30382F)](https://github.com/dferrandizmont/ink-lab/releases)

Compañero de muestras y paletas para quien dibuja con rotuladores de alcohol.
Busca el código de un color, descubre qué rotulador de tu colección se parece más
a una foto y construye paletas con teoría del color usando solo los rotuladores
que tienes. Para Android, con modo claro y oscuro, raíl lateral en tablets y
textos en español e inglés.

**Gratis · Sin anuncios · Sin cuenta · Sin conexión · Código abierto**

La IA es opcional y está apagada de serie.

## Descargas

<p>
  <a href="https://github.com/dferrandizmont/ink-lab/releases/latest"><img src="https://img.shields.io/badge/Disponible_en-GitHub-181717?logo=github&amp;style=for-the-badge" alt="Disponible en GitHub"></a>
  <!--
  <a href="[ENLACE_GOOGLE_PLAY]"><img src="https://img.shields.io/badge/Google_Play-Descargar-414141?logo=googleplay&amp;style=for-the-badge" alt="Disponible en Google Play"></a>
  <a href="[ENLACE_APP_STORE]"><img src="https://img.shields.io/badge/App_Store-Descargar-0D96F6?logo=appstore&amp;style=for-the-badge" alt="Disponible en App Store"></a>
  -->
</p>

Android ya; iOS y Google Play próximamente.

<details>
<summary>Instalar el APK desde GitHub</summary>

1. Descarga el APK y `SHA256SUMS.txt` de la [última
   versión](https://github.com/dferrandizmont/ink-lab/releases/latest). Cada
   versión lleva los dos, así que puedes comprobar la descarga con
   `sha256sum -c SHA256SUMS.txt`.
2. Permite «instalar aplicaciones de origen desconocido» cuando el móvil lo
   pida y abre el APK.

</details>

## Capturas

<p>
  <a href="docs/readme/es/01-swatches.png"><img src="docs/readme/es/01-swatches.png" width="19%" alt="Muestras con código, nombre y color"></a>
  <a href="docs/readme/es/02-swatch-detail.png"><img src="docs/readme/es/02-swatch-detail.png" width="19%" alt="Detalle de un rotulador con sus códigos y su hex"></a>
  <a href="docs/readme/es/03-match.png"><img src="docs/readme/es/03-match.png" width="19%" alt="Color de una foto emparejado con el rotulador más cercano"></a>
  <a href="docs/readme/es/04-palette.png"><img src="docs/readme/es/04-palette.png" width="19%" alt="Paleta por teoría del color"></a>
  <a href="docs/readme/es/05-ideas.png"><img src="docs/readme/es/05-ideas.png" width="19%" alt="Ideas con técnica y paleta"></a>
</p>

<details>
<summary>Más capturas</summary>

<p>
  <a href="docs/readme/es/06-settings.png"><img src="docs/readme/es/06-settings.png" width="19%" alt="Ajustes"></a>
</p>

</details>

Pulsa una captura para ampliarla.

## Funciones

- **Muestras:** el catálogo por código y nombre, con el hex de cada rotulador,
  búsqueda, filtro por tus packs y favoritos. En Ohuhu Oahu indica además dónde
  está cada rotulador en la tarjeta de colores.
- **Emparejar con una foto:** haz una foto o elige una de la galería, toca un
  punto y la app te dice qué rotulador de tu colección se le parece más.
- **Paletas con teoría del color:** elige un color base y obtén armonías
  (complementarios, análogos, complementarios divididos, tríada, cuadrado,
  rectángulo, monocromo y sombra), resueltas siempre con los rotuladores que
  tienes.
- **Ideas:** retos y técnicas con una paleta que tiene en cuenta tu colección
  activa.
- **Dos marcas:** Ohuhu (Oahu, Honolulu y Kaala, 503 colores, con el código nuevo
  y el antiguo) y DecoTime (313 colores, con selección de rotuladores propios,
  porque se vende en sets cerrados).
- **IA opcional:** o bien **en el móvil** (Gemini Nano, en Android compatible), o
  bien con **tu propia clave de OpenRouter**. Si no la activas, la app nunca usa
  la red.
- **Copia de seguridad:** exporta e importa tus colecciones, favoritos, paletas y
  ajustes como texto JSON, sin cuenta.

## Privacidad

Todo se guarda en el móvil. No hay cuentas, servidor propio, analítica, anuncios
ni rastreo. La cámara y la galería solo se usan al emparejar una foto, y la foto
nunca sale del dispositivo.

[Política de privacidad](https://dferrandizmont.github.io/ink-lab/privacidad/) ·
[Detalle técnico](docs/privacy.md) · Soporte: **dev@mainshai.com**.

## Novedades

Consulta el [CHANGELOG.md](CHANGELOG.md).

## Contribuir

Los fallos, las ideas y las traducciones son bienvenidos. Cómo compilar, probar y
colaborar: [CONTRIBUTING.es.md](CONTRIBUTING.es.md).

## Licencia

Código [MIT](LICENSE), Copyright (c) 2026 Daniel Mont Ferrandiz. Documentación y
textos propios: [CC BY-SA 4.0](LICENSE-CONTENT.es.md). Los datos de los catálogos
son referencias factuales de terceros y quedan fuera de MIT y de CC BY-SA 4.0;
las fuentes tipográficas (SIL OFL 1.1) y los materiales de terceros conservan
sus licencias, detalladas en [NOTICE.md](NOTICE.md).

Proyecto independiente: **no está afiliado, patrocinado ni respaldado por Ohuhu
ni por DecoTime**. «Ohuhu», «Oahu» y «DecoTime» son marcas de sus propietarios.
Las fuentes públicas y los avisos completos están en [NOTICE.md](NOTICE.md).

Para comunicar una vulnerabilidad: [SECURITY.es.md](SECURITY.es.md).
