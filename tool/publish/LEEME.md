# Exportar el repositorio público

[English](LEEME.en.md)

Desde la raíz, con Git, una shell POSIX (Git Bash en Windows o `sh` en macOS) y
Python 3.9 o superior, sin paquetes adicionales:

```sh
sh tool/publish/export_public.sh HEAD /ruta/vacia/ink-lab-publico
```

El destino debe estar fuera del repositorio y vacío, incluidos los ficheros
ocultos. No se admiten enlaces simbólicos en su ruta. Se crea si no existe.
No se modifica el repositorio de origen. El exportador no usa la red.

Puedes fijar intérprete e identidad pública:

```sh
PUBLIC_PYTHON=python3 PUBLIC_AUTHOR_NAME='Tu nombre' \
PUBLIC_AUTHOR_EMAIL='publico@example.org' \
sh tool/publish/export_public.sh COMMIT /ruta/vacia/ink-lab-publico
```

Por defecto prueba `python` y, si no existe, `python3`. En Git Bash usa rutas
de Windows con barras `/` para `PUBLIC_PYTHON` si indicas un ejecutable completo.
El autor **y el committer** por defecto son Daniel Mont Ferrandiz
`<dev@mainshai.com>`. El único commit se titula «Initial public release of Ink Lab» (los commits del repositorio público van en inglés).
La rama es `main`, sin remoto, tags ni historial privado. No hay push.

## Qué se selecciona

`allowlist.txt` es la política de la copia del exportador que ejecutas. Usa la
versión revisada para el candidato. Cada línea es una ruta relativa POSIX o un
patrón `fnmatch` de Python (`*` también cruza `/`); `#` introduce un comentario.
La lista inicial contiene **rutas exactas**, revisadas con `git ls-files`:
los ficheros futuros no entran hasta que se añaden expresamente. En concreto,
cuando existan y se hayan revisado, hay que añadir a mano los ficheros de
`lib/l10n/` (ARB y generados), las imágenes de `docs/readme/` y los generadores de
catálogos de `tools/`.

El script resuelve el commit, inventaría su árbol con `git ls-tree` y lee
`git archive` como un flujo. Solo escribe las entradas permitidas de ese commit;
no copia el directorio de trabajo, los ignorados ni sus cambios sin confirmar.
Los enlaces simbólicos y submódulos seleccionados provocan un fallo. También
falla si `export-ignore` elimina un fichero de la selección. El commit debe
contener `pubspec.yaml` en la raíz.

Se incluyen el código Flutter, los nativos de Android e iOS, las pruebas, los
catálogos y fuentes de `assets/`, la CI, los README, las licencias, los avisos de
seguridad y privacidad, la web legal y los contratos técnicos de colaboración
(`docs/ARCHITECTURE.md`, `docs/RELEASING.md`, `docs/privacy*.md`, `docs/legal/`).
Las reglas públicas están en `CONTRIBUTING.md` y `CONTRIBUTING.en.md`.

Exclusiones revisadas:

| Ficheros o grupo | Motivo |
|---|---|
| `.mcp.json`, `.claude/`, `.shots/`, `.handoff.md`, `.plan-gratis.md`, `CLAUDE.md`, `AGENTS.md` | Configuración, entorno y guías internas |
| `docs/HANDOFF.md` | Traspaso interno entre sesiones de trabajo |
| `docs/DESIGN_SPEC.md`, `docs/design-mockups/` | Especificación y maquetas de diseño internas; algunos comentarios del código aún las citan |
| `docs/release/` (`STORE_RELEASE.md`, `MAC_IOS_SETUP.md`) | Plan interno de tiendas, decisiones pendientes y pasos del Mac; algunos comentarios del código aún los citan |
| `docs/ROADMAP.md` | Calendario interno y desactualizado; hay que refrescarlo antes de publicarlo |
| APK/AAB, keystores, `key.properties`, `.env*` | No son fuentes públicas; las claves nunca van al repositorio |
| Logs, capturas de QA, claves y copias personales | No son fuentes públicas ni datos de prueba |
| `gradlew` y `gradle-wrapper.jar` | No están versionados; Flutter 3.47.7 repone el wrapper al compilar Android |

Para invocar `./gradlew` directamente en una copia recién exportada hace falta
reponer antes el wrapper; la entrada recomendada es `flutter build apk`.
Las pruebas Dart no leen los documentos excluidos. La CI del repositorio público
(`.github/workflows/ci.yml`) ejecuta `flutter analyze`, `flutter test` y
`web/legal/test_legal.py`.

## Comprobaciones y límites

Antes de crear Git, se comprueban nombres y contenido del árbol exacto:

- Rutas personales de Windows y macOS e identificador local de desarrollo.
- Nombres internos, cachés, logs, APK, AAB, `.env*`, `*.env`, `key.properties`,
  `local.properties`, keystores, claves privadas (`.p8`, `.p12`, `.pem`, `.key`,
  `.mobileprovision`), `google-services.json`, `GoogleService-Info.plist` y
  `secrets.*`.
- Marcadores de claves privadas, tokens GitHub/OpenAI y access keys AWS; además
  claves de Google API (`AIza…`), de Stripe en producción (`sk_live…`), de Slack
  (`xox…`), de RevenueCat (`appl…`, `goog…`), los JWT (tres segmentos base64url
  separados por puntos, el primero empieza por `eyJ…` y el payload puede ser
  `e30`) y las asignaciones de `storePassword` y `keyPassword` en JSON, YAML,
  Gradle o Groovy. Asignar la contraseña desde las variables de Gradle
  `releaseStorePassword` y `releaseKeyPassword` (que se leen de `key.properties` o
  del entorno) no es un valor y se admite, igual que leerla con
  `keyProperties.getProperty("storePassword")`.
- Correos: no se admite ninguna dirección `@gmail.com` ni el correo del autor del
  repositorio de origen. Un dominio que solo empieza por `gmail.com` no es una
  dirección de Gmail y sí se admite. Ese correo se lee en tiempo de ejecución con
  `git config user.email` y no está escrito en el código: el exportador se
  adapta a quien firma, sin dejar la dirección escrita en ninguna parte.
- `.gitattributes`: se comprueban los atributos efectivos de cada fichero
  exportado (`git check-attr export-subst export-ignore`), los mismos que Git
  aplica al archivar: los `.gitattributes` del commit y
  `$GIT_DIR/info/attributes`, que no está versionado. Solo falla si el atributo
  está activo; uno desactivado (`-export-ignore`) o comentado no cambia nada.
- Bytes: los bytes exportados se comparan con el blob del commit. Solo se
  admite la diferencia de fin de línea que Git aplica con el atributo `eol`;
  cualquier otra reescritura, como la de `export-subst`, hace fallar la
  exportación.
- Binarios: solo en `assets/` (fuentes), `test/`, `docs/readme/` y PNG de iconos
  nativos (`android/app/src/main/res/` e `ios/Runner/Assets.xcassets/`).

El identificador local se rechaza también si aparece en una URL pública de
GitHub o GitHub Pages. No hay excepciones implícitas por tratarse de un enlace
(la cuenta pública `dferrandizmont` sí se admite, no así el nombre de usuario
local): si el candidato conserva esa identidad en README o web, la exportación
falla. Hay que resolver expresamente ese criterio antes de aprobar la primera copia.

Se leen de nuevo los bytes exportados y se crea el commit en una carpeta temporal
hermana. Se comprueba que contiene exactamente la selección, un solo commit,
ningún remoto y ningún cambio pendiente. Si hay un fallo de validación, el destino
queda vacío y se elimina únicamente el temporal de esta ejecución. Un destino
ocupado nunca se vacía ni se sobrescribe. No se muestran líneas ni valores de
posibles secretos en los errores.

El análisis automático no acredita licencias, procedencia de datos, metadatos
de imágenes ni ausencia absoluta de secretos. Antes de publicar, el líder debe
revisar el árbol, las imágenes y la identidad final. Publicar es otro paso.

## Verificación reproducible

```sh
python -B tool/publish/test_export_public.py
sh tool/publish/export_public.sh HEAD /ruta/vacia/ink-lab-publico
cd /ruta/vacia/ink-lab-publico
python -B web/legal/test_legal.py
flutter pub get
flutter analyze
flutter test
```

La revisión debe partir de un commit que incluya todos los cambios: ejecutar el
exportador con cambios locales sin confirmar **no los publica**. Si trabajas con
un agente que no puede confirmar su rama, quien recibe la entrega debe confirmar
y repetir la exportación de `HEAD` antes de dar por validado el candidato
definitivo.

## Crear y actualizar el repositorio público

El exportador crea siempre un repositorio nuevo de un commit. Para la primera
publicación de `dferrandizmont/ink-lab`:

1. Exporta `HEAD` a una carpeta vacía y comprueba el resultado.
   Si falla alguna comprobación, se corrige en el repositorio privado y se vuelve a exportar.
2. Revisa el árbol, las imágenes y la identidad. Crea el repositorio público
   vacío en GitHub (con el «sí» del dueño), añade el remoto y haz `git push -u origin main`.
3. Activa GitHub Pages con el contenido de `web/legal/dist/` (`web/legal/LEEME.md`).

Para publicar cambios después sin perder el historial público:

1. Exporta `HEAD` a una carpeta vacía: `sh tool/publish/export_public.sh HEAD ../il-public-export`.
2. En el clon del público (`../ink-lab-public`, al día con `origin/main`), sustituye el árbol entero:
   `git rm -r -q --cached .`, borra todo menos `.git`, y extrae la exportación con
   `(cd ../il-public-export && git archive HEAD) | tar -x -C .`; luego `git add -A`.
3. Commit **en inglés** con la identidad pública:
   `git -c user.name="Daniel Mont Ferrandiz" -c user.email="dev@mainshai.com" commit -m "<resumen>"`.
4. `git push origin main` (con el «sí» del dueño) y borra `../il-public-export`.

Las releases públicas llevan los APK firmados con la upload key (`docs/RELEASING.md`), con
`SHA256SUMS.txt` y la huella SHA-256 del certificado en las notas, en español e inglés.
