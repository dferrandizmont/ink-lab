<!-- No son asesoramiento jurídico; conviene que los revise un profesional antes del lanzamiento en las tiendas. -->

# Documentos legales

English version: [LEEME.en.md](LEEME.en.md).

| Fichero | Qué es | Estado |
|---|---|---|
| `politica-privacidad.md` | Política de privacidad para publicar (RGPD y LOPDGDD), en tuteo. Refleja [`docs/privacy.md`](../privacy.md), que es la fuente de verdad técnica. | Sin marcadores: titular, correo y fecha ya rellenos. Las notas de redacción están al final de este fichero; la política no lleva comentarios ni notas internas. |
| `politica-privacidad.en.md` | Traducción de cortesía al inglés. Manda la española. | Mantenerla al día con la española. |
| `politica-privacidad.de.md`, `.fr.md`, `.pt.md`, `.it.md` | Traducciones de cortesía al alemán, francés, portugués e italiano (de, fr y pt en trato formal; it en tuteo). Manda la española. Cada una cita las etiquetas de la interfaz en su idioma (`lib/l10n/app_<idioma>.arb`). | Mantenerlas al día con la española; misma fecha de «Última actualización» en las seis. |
| `../privacy.md` y `../privacy.en.md` | Inventario técnico de datos, permisos, copias, IA y exportaciones, comprobado contra el código. | Revisar cada vez que cambie el flujo de datos. |
| `../../PRIVACY.md` | Puntero corto a los documentos anteriores. | — |
| `../../SECURITY.es.md` y `SECURITY.md` | Cómo avisar de una vulnerabilidad sin mandar datos reales. | — |
| `../../LICENSE` y `../../LICENSE-CONTENT.es.md` (`.md`) | MIT para el código; CC BY-SA 4.0 para el contenido propio; los datos de los catálogos y los materiales de terceros, aparte. | — |

Convención: el texto en español es el que vale; cada documento tiene su versión inglesa en `*.en.md` al lado, y la
política además en `*.de.md`, `*.fr.md`, `*.pt.md` y `*.it.md`.

| Política | Idioma | Trato | Última actualización |
|---|---|---|---|
| `politica-privacidad.md` | Español (original) | Tuteo | 2026-11-20 |
| `politica-privacidad.en.md` | Inglés | — | 2026-11-20 |
| `politica-privacidad.de.md` | Alemán | Formal (Sie) | 2026-11-20 |
| `politica-privacidad.fr.md` | Francés | Formal (vous) | 2026-11-20 |
| `politica-privacidad.pt.md` | Portugués | Formal (você) | 2026-11-20 |
| `politica-privacidad.it.md` | Italiano | Tuteo | 2026-11-20 |

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
   sus cinco traducciones), la fecha de «Última actualización», `privacy_date` y las declaraciones de las
   tiendas. Después se vuelve a generar y desplegar la web.

La web antigua de GitHub Pages (`web/legal/`) queda retirada en cuanto sus páginas redirijan a la nueva.

## Lista para publicar
1. Revisar las «Notas de redacción» de abajo y, si procede, cambiar el plazo de conservación de los correos o la fecha.
2. Generar, comprobar y desplegar la web desde `mainshai-web` (`sitegen build/check ink-lab`, `DEPLOYMENT.md`).
3. Comprobar que las URL de las fichas de las tiendas coinciden y que la política cuadra con «Seguridad de los datos»
   (Play) y «Privacidad de la app» (Apple).

## Notas de redacción
No son asesoramiento jurídico. La política se redactó el 29-oct-2026 y se actualizó el 30-oct-2026 y el 31-oct-2026
(diario de obras con fotos, copia de seguridad al portapapeles y exclusión de las copias de Android, versión 0.7) contra
el código de esa fecha (`docs/privacy.md` es la fuente de verdad técnica); conviene que la revise un profesional antes
del lanzamiento en las tiendas. Estas notas vivían dentro de la política y salieron de ella al publicarla en `inklab.mainshai.com`, cuyo
generador convierte el Markdown tal cual.

Decisiones ya tomadas en el texto, por si quieres cambiarlas: titular Daniel Mont Ferrandiz y correo
`inklab@mainshai.com`; conservación de correos en Gmail y Proton «como máximo un año desde el último mensaje de la conversación», con limpieza cada tres meses; desde el 20-11-2026 las respuestas salen por Resend, sin seguimiento de aperturas ni de clics, que, según su documentación, conserva cada respuesta y su registro de envío 30 días y sus copias de seguridad, siete días (por Brevo, el servicio previsto antes, solo salieron pruebas del titular); la fecha de última actualización
(en formato `AAAA-MM-DD`, la que lee la web) es la de la redacción; la IA en el móvil se describe como Gemini Nano en
Android mediante ML Kit, con sus diagnósticos a Google (iOS aún no la tiene, véase `docs/privacy.md`). La URL publicada
va en las fichas de las tiendas; comprueba que coincide con «Seguridad de los datos» (Play) y «Privacidad de la app»
(Apple). Las versiones inglesa, alemana, francesa, portuguesa e italiana son traducciones de cortesía; manda la
española.

### Respuestas por Resend (2026-11-20)
**Decisión de Daniel (20-11-2026):** fuera el seguimiento de las respuestas de soporte en todas sus apps. Brevo, en el
plan gratuito, ponía un píxel y reescribía los enlaces, lo que pide un consentimiento previo que no se pedía (ePrivacy,
art. 5.3; LSSI, art. 22.2). Se elige **Resend** (gratis, seguimiento apagado, SMTP).

**Circuito desde el 20-11-2026:** Cloudflare Email Routing recibe y reenvía al buzón de Gmail, con copia a Proton (sin
cambios); Gmail «Enviar como» de inklab@mainshai.com envía por `smtp.resend.com`. Probado ese día: enlaces sin
reescribir, sin píxel, sin pie de baja; Resend no registra aperturas. Dominio `mainshai.com` en la región Ireland
(eu-west-1), con el seguimiento de aperturas y clics desactivado.

**Hechos de Resend (consultados el 20-11-2026):**
- Entidad: Plus Five Five, Inc. (EE. UU.). Guarda los datos en EE. UU. (contenido de cada respuesta y registro de envío)
  aunque el envío salga de Irlanda: 30 días en el plan gratuito; las copias de seguridad se conservan siete días
  (https://resend.com/security/gdpr.md, https://resend.com/pricing). «Backups persist for 7 days» dice cuánto duran las
  copias, no que cada correo salga de ellas siete días después de los 30: por eso la política no dice «7 días más».
- DPA del art. 28 para todas las cuentas y planes (https://resend.com/legal/dpa). Transferencia: DPF (Resend en
  https://www.dataprivacyframework.gov/list, con el estado «Active - Re-certification under Review» el 20-11-2026) y SCC
  de la Comisión, módulo 2, incorporadas al DPA. Si Resend saliera de esa lista, quitar de la política la frase del DPF
  (en los seis idiomas) y quedarse con las SCC.
- Un correo concreto solo se borra antes pidiéndolo al soporte de Resend con los identificadores del panel (Emails); no
  hay botón ni API. Subencargados: AWS y otros, en EE. UU. (https://resend.com/legal/subprocessors).

**Brevo:** no se usa desde el 20-11-2026. En toda la cuenta de Brevo solo hay pruebas del titular (confirmado por Daniel
el 20-11-2026): desde inklab@mainshai.com no se respondió a nadie por Brevo. Brevo conserva el registro de esas pruebas
con su regla de doce meses (hasta un día más). La política no dice «sin copia», porque puede haber vistas previas de
pruebas anteriores a esa regla. Brevo no tiene datos de personas usuarias, así que sale de la supresión y del
apartado 6 de plazos.

**Qué cambió en la política (seis idiomas; primera redacción, corregida en la ronda 1):** «Datos que NO se tratan», sin el seguimiento de Brevo; en «Si nos
escribes», viñeta de Resend (envío desde Irlanda, datos en EE. UU., copia y registro 30 días, copias de seguridad 7
más, seguimiento desactivado, subencargados como AWS), párrafo «Brevo, hasta el 20 de noviembre de 2026» y «Cuánto lo
guardamos» con Resend, lo que queda en Brevo y la supresión (Gmail, Proton, petición al soporte de Resend y registros
de Brevo); fuera «Si dejamos de usar alguno de esos servicios, borramos lo que haya en él», que con Brevo recién dejado
no sería cierto hasta que Brevo borre; en el apartado 4, fila de Resend, fila de Brevo en pasado y frase del DPA de
Resend; en el 5, DPF + SCC módulo 2 para Resend; en el 6, Resend y los registros antiguos de Brevo. Fecha: 2026-11-20
(sin cambios, igual que `privacy_date`).

**Pendiente de Daniel:** pedir a Brevo por escrito que borre el historial, quitar sus DNS y cerrar la cuenta (anotar
aquí qué se pidió, qué confirmó y cuándo). Cuando Brevo confirme el borrado, cambiar el párrafo de Brevo (y las filas
de los apartados 4 y 6) para decir que ya no queda nada, en los seis idiomas.

**Ronda 1 de revisión (20-11-2026; Astra high FIX, Fable high PASS, sobre el modelo de Gift Huddle):** plazo de las
copias de seguridad de Resend («se conservan durante siete días», no «7 días más»); Brevo descrito como el servicio
previsto, que solo envió pruebas del titular, y fuera de la supresión y del apartado 6; bases jurídicas de las
solicitudes de derechos (art. 6.1.c) y de la conservación por una reclamación (art. 6.1.f), en «Si nos escribes» y en
el apartado 3; «cada uno en el paso que indica la tabla» en el apartado 4; enlace al DPA y «puedes pedirnos información»
en el 5; enlace a la lista de subencargados de Resend.

**Ronda 2 de revisión (20-11-2026; Astra high FIX, Fable high PASS):** la supresión del correo sigue el art. 17.3.e
(«Si procede la supresión…» y «Si debemos conservar algún dato, te explicaremos cuál y por qué»), con Resend borrando
respuestas y registros de envío; el Resumen dice el recorrido del correo (Cloudflare, Gmail, Proton, Resend sin
seguimiento); retoques de lengua en de, fr, it y pt; estado exacto del DPF en estas notas. El texto del registro de
Cloudflare (plazo sin confirmar) no cambia: sigue pendiente.

**dev@mainshai.com (duda abierta):** la política decía que todo el circuito «vale también» para dev@mainshai.com, la
dirección de las versiones hasta la 0.6.2. Solo está comprobado que las respuestas de soporte salen por Resend desde
inklab@mainshai.com; no se ha comprobado si dev@mainshai.com tiene «Enviar como» por Resend. Por eso la política dice
ahora que Cloudflare, Google y Proton intervienen igual en lo que llegue a dev@mainshai.com y que las respuestas salen
desde inklab@mainshai.com. Si alguna vez se responde desde dev@mainshai.com, comprobar antes que sale por
`smtp.resend.com` y sin seguimiento.

**Derechos sobre el correo de soporte (cómo atenderlos):**
- Verificación proporcional: si la petición se limita al correo, basta con que la pida desde la misma dirección o en el
  mismo hilo, sin pedir documentos si no hace falta.
- Supresión: se aplica el criterio del art. 17.3.e. Antes del borrado, comprobar si procede conservar algún dato y
  documentar la razón; si se conserva algo, explicarle a la persona qué y por qué.
- Acceso: copia fiel e inteligible de los datos que se conserven (art. 15.3), con el contexto necesario y protegiendo
  los datos de terceros; se puede preparar un extracto sin duplicar lo que esté igual en Gmail y en Proton. Incluye el
  registro del reenvío de Cloudflare si guarda datos de la persona (si el panel no deja verlo, pedírselo a Cloudflare).
  En Brevo no hay nada que entregar.
- Resend: localizar las respuestas de los últimos 30 días en el panel (Emails) por destinatario y comprobar en cada
  envío que el remitente es inklab@mainshai.com, porque la cuenta envía también por otras apps. Para borrar, pedirlo al
  soporte de Resend (https://resend.com/support) desde la dirección de la cuenta, con los identificadores: no hay botón
  ni API. Si un envío es dudoso, aclararlo con Resend antes de entregar o borrar.
- El correo final que cuenta qué se ha borrado también sale por Resend y deja una copia nueva allí (30 días) y en
  Enviados de Gmail: decirlo en ese correo; se borra en la limpieza siguiente.
- La primera vez que se entregue algo con adjunto, mirar en el panel si Resend guarda el adjunto y anotarlo aquí.
- Limpieza trimestral: además de Gmail y Proton, comprobar en Resend (Domains) que `mainshai.com` sigue con el
  seguimiento de aperturas y de clics desactivado; en Gmail, que «Enviar como» sigue usando `smtp.resend.com`; que
  Resend sigue en https://www.dataprivacyframework.gov/list («Active - Re-certification under Review» el 20-11-2026); que https://resend.com/security/gdpr.md sigue
  diciendo 30 días y copias de siete días (si algo cambia, revisar la política); y el pendiente de Brevo, comprobando
  mientras tanto que no sale nada nuevo de inklab@mainshai.com por Brevo.
