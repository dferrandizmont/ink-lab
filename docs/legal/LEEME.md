<!-- No son asesoramiento jurídico; conviene que los revise un profesional antes del lanzamiento en las tiendas. -->

# Documentos legales

English version: [LEEME.en.md](LEEME.en.md).

| Fichero | Qué es | Estado |
|---|---|---|
| `politica-privacidad.md` | Política de privacidad para publicar (RGPD y LOPDGDD), en tuteo. Refleja [`docs/privacy.md`](../privacy.md), que es la fuente de verdad técnica. | Sin marcadores: titular, correo y fecha ya rellenos. Las notas de redacción están al final de este fichero; la política no lleva comentarios ni notas internas. |
| `politica-privacidad.en.md` | Traducción de cortesía al inglés. Manda la española. | Mantenerla al día con la española. |
| `../privacy.md` y `../privacy.en.md` | Inventario técnico de datos, permisos, copias, IA y exportaciones, comprobado contra el código. | Revisar cada vez que cambie el flujo de datos. |
| `../../PRIVACY.md` | Puntero corto a los documentos anteriores. | — |
| `../../SECURITY.es.md` y `SECURITY.md` | Cómo avisar de una vulnerabilidad sin mandar datos reales. | — |
| `../../LICENSE` y `../../LICENSE-CONTENT.es.md` (`.md`) | MIT para el código; CC BY-SA 4.0 para el contenido propio; los datos de los catálogos y los materiales de terceros, aparte. | — |

Convención: el texto en español es el que vale; cada documento tiene su versión inglesa en `*.en.md` al lado.

## Cómo se mantienen en sincronía con la web
La política se publica en la web de la app, **generada desde este markdown** y nunca editada a mano en HTML:

1. La fuente es `docs/legal/politica-privacidad.md` (y `politica-privacidad.en.md`). La web de `web/` (`site.toml →
   privacy`) la convierte tal cual con el generador común de `mainshai-web` (skill `web-app`) y la publica en
   `https://inklab.mainshai.com/es/privacy/` y `https://inklab.mainshai.com/privacy/` (inglés).
2. Por eso la política no lleva comentarios HTML ni notas internas: van en este fichero. La línea «Última
   actualización» va en `AAAA-MM-DD` y tiene que coincidir con `privacy_date` de `web/content/<idioma>.json`;
   `sitegen check ink-lab` lo comprueba.
3. Esas URL van en las fichas de las dos tiendas y en la app (`lib/ui/pages/settings/constants.dart`).
4. **Si cambia el flujo de datos**, se actualizan a la vez y en el mismo commit: `docs/privacy.md`, esta política (y
   las dos versiones inglesas), la fecha de «Última actualización», `privacy_date` y las declaraciones de las
   tiendas. Después se vuelve a generar y desplegar la web.

La web antigua de GitHub Pages (`web/legal/`) queda retirada en cuanto sus páginas redirijan a la nueva.

## Lista para publicar
1. Revisar las «Notas de redacción» de abajo y, si procede, cambiar el plazo de conservación de los correos o la fecha.
2. Generar, comprobar y desplegar la web desde `mainshai-web` (`sitegen build/check ink-lab`, `DEPLOYMENT.md`).
3. Comprobar que las URL de las fichas de las tiendas coinciden y que la política cuadra con «Seguridad de los datos»
   (Play) y «Privacidad de la app» (Apple).

## Notas de redacción
No son asesoramiento jurídico. La política se redactó el 29-oct-2026 y se actualizó el 30-oct-2026 contra el código de esa
fecha (`docs/privacy.md` es la fuente de verdad técnica); conviene que la revise un profesional antes del lanzamiento en
las tiendas. Estas notas vivían dentro de la política y salieron de ella al publicarla en `inklab.mainshai.com`, cuyo
generador convierte el Markdown tal cual.

Decisiones ya tomadas en el texto, por si quieres cambiarlas: titular Daniel Mont Ferrandiz y correo
`inklab@mainshai.com`; conservación de correos «un año desde la última respuesta»; la fecha de última actualización
(en formato `AAAA-MM-DD`, la que lee la web) es la de la redacción; la IA en el móvil se describe como Gemini Nano en
Android mediante ML Kit, con sus diagnósticos a Google (iOS aún no la tiene, véase `docs/privacy.md`). La URL publicada
va en las fichas de las tiendas; comprueba que coincide con «Seguridad de los datos» (Play) y «Privacidad de la app»
(Apple). La versión inglesa (`politica-privacidad.en.md`) es una traducción de cortesía; manda la española.
