# Colaborar en Ink Lab

[English](CONTRIBUTING.md) · Español

Ink Lab es gratuita, sin cuentas, anuncios ni compras. El código Flutter está en
la raíz (`lib/`, `test/`) y la estructura en [ARCHITECTURE.md](docs/ARCHITECTURE.md).
Explica el problema, el comportamiento esperado y cómo lo has comprobado. Para
cambios de interfaz o de alcance, acuerda primero la propuesta en una issue.
Al participar aceptas el [Código de conducta](CODE_OF_CONDUCT.md).

| Quiero... | Haz esto |
|---|---|
| Avisar de un fallo | [Incidencia de error](https://github.com/dferrandizmont/ink-lab/issues/new) |
| Proponer una función | [Incidencia de función](https://github.com/dferrandizmont/ink-lab/issues/new) |
| Corregir un color, un nombre o un código | [Incidencia de corrección de datos](https://github.com/dferrandizmont/ink-lab/issues/new) |
| Avisar de un problema de seguridad | [SECURITY.es.md](SECURITY.es.md), nunca una incidencia pública |
| Enviar código | Bifurca, crea una rama y abre una [solicitud de cambio](.github/PULL_REQUEST_TEMPLATE.md) |

- `lib/core/` es **Dart puro**: sin imports de Flutter, sin E/S y sin canales de
  plataforma. La interfaz no calcula colores ni llama a la red; los asesores de
  IA (`lib/ai/`) son opcionales y siempre pueden volver al motor local.
- Sigue los lints de `analysis_options.yaml` (`flutter_lints`) y formatea con
  `dart format .`. Cambios pequeños y enfocados; prueba todo cambio de lógica.
- Los datos de marcadores (`assets/data/`) son ficheros **generados**: no los
  edites a mano. Abre una incidencia de corrección con la marca, el código, el
  valor actual, el correcto y una fuente pública; una foto de la muestra física
  ayuda. Para añadir una marca o un set, propónlo antes en una issue.
- No incluyas logotipos, fotografías de producto, embalajes ni tarjetas de color
  de ninguna marca: solo códigos, nombres, valores hex y pertenencia a sets
  ([NOTICE.md](NOTICE.md)).
- No adjuntes claves ni datos personales. Para reproducir un fallo usa datos de
  prueba, y nunca pegues una copia de seguridad real ni una clave de API.
- Mensajes de commit breves y en imperativo, con prefijo opcional
  (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`).

## Compilar y probar

Requisitos: **Flutter 3.47.7** (canal estable), Android SDK para Android o macOS
con Xcode y CocoaPods para iPhone.

```sh
git clone https://github.com/dferrandizmont/ink-lab.git
cd ink-lab
flutter pub get
flutter analyze
flutter test
flutter run
```

La CI ejecuta `flutter pub get`, `flutter analyze` y `flutter test` en cada
solicitud de cambio. Incluye en tu PR los comandos ejecutados y su resultado, y
una captura si cambias la interfaz. Si cambias la política de privacidad,
actualiza a la vez `docs/privacy.md`, `docs/legal/politica-privacidad.md` (y las
versiones inglesas); la web (`web/`, publicada en https://inklab.mainshai.com)
muestra la política tal cual.

Un APK de pruebas locales, firmado con la clave de depuración (nunca para
tiendas):

```sh
flutter build apk --release --android-project-arg=allowDebugSigning=true
```

Los APK públicos se firman con una clave del dueño que no está en el
repositorio. La selección pública se prepara con el
[exportador](tool/publish/LEEME.md) y la web vive en `web/` (la antigua de
GitHub Pages solo redirige, véase [web/legal](web/legal/LEEME.md)).

Al contribuir aceptas que tu código se ofrezca bajo [MIT](LICENSE) y que tu
documentación y tus textos se ofrezcan bajo [CC BY-SA 4.0](LICENSE-CONTENT.es.md).
