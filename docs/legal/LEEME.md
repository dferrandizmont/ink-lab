<!-- No son asesoramiento jurídico; conviene que los revise un profesional antes del lanzamiento en las tiendas. -->

# Documentos legales

English version: [LEEME.en.md](LEEME.en.md).

| Fichero | Qué es | Estado |
|---|---|---|
| `politica-privacidad.md` | Política de privacidad para publicar (RGPD y LOPDGDD), en tuteo. Refleja [`docs/privacy.md`](../privacy.md), que es la fuente de verdad técnica. | Sin marcadores: titular, correo y fecha ya rellenos. Revisar las «Notas para el titular» del final, que el generador HTML **omite**. |
| `politica-privacidad.en.md` | Traducción de cortesía al inglés. Manda la española. | Mantenerla al día con la española. |
| `../privacy.md` y `../privacy.en.md` | Inventario técnico de datos, permisos, copias, IA y exportaciones, comprobado contra el código. | Revisar cada vez que cambie el flujo de datos. |
| `../../PRIVACY.md` | Puntero corto a los documentos anteriores. | — |
| `../../SECURITY.md` y `SECURITY.en.md` | Cómo avisar de una vulnerabilidad sin mandar datos reales. | — |
| `../../LICENSE` y `../../LICENSE-CONTENT.md` (`.en.md`) | MIT para el código; CC BY-SA 4.0 para el contenido propio; los datos de los catálogos y los materiales de terceros, aparte. | — |

Convención: el texto en español es el que vale; cada documento tiene su versión inglesa en `*.en.md` al lado.

## Cómo se mantienen en sincronía con la web
La política se publica como página estática generada **desde este markdown**, nunca editada a mano en HTML, con el
mismo esquema que Cuadrante y Ley al Blanco (`web/legal/`):

1. La fuente es `docs/legal/politica-privacidad.md`. El generador (`web/legal/md2html.py`) convierte el markdown a
   `web/legal/privacidad/index.html` y **omite** los comentarios HTML y la sección «Notas para el titular». La versión
   inglesa se genera igual desde `politica-privacidad.en.md` a `web/legal/privacidad/en/index.html`.
2. Un test (`web/legal/test_legal.py`) compara el HTML generado con el markdown y falla si no coinciden, para que
   nadie edite el HTML por su cuenta ni se olvide de regenerar. La CI lo ejecuta.
3. La página se sube a GitHub Pages del repositorio público (`https://dferrandizmont.github.io/ink-lab/privacidad/`,
   a confirmar cuando exista el repositorio).
4. Esa misma URL va en las fichas de las dos tiendas.
5. **Si cambia el flujo de datos**, se actualizan a la vez y en el mismo commit: `docs/privacy.md`, esta política (y
   las dos versiones inglesas), la fecha de «Última actualización» y las declaraciones de las tiendas. Después se
   regenera el HTML y se vuelve a publicar.

## Lista para publicar
1. Revisar las «Notas para el titular» y, si procede, cambiar el plazo de conservación de los correos o la fecha.
2. Generar el HTML (`python -B web/legal/md2html.py`), pasar el test y publicar `web/legal/dist/` (`web/legal/LEEME.md`).
3. Poner la URL en las fichas de las tiendas y comprobar que coincide con «Seguridad de los datos» (Play) y
   «Privacidad de la app» (Apple).
