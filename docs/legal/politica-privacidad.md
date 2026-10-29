<!--
No es asesoramiento jurídico. Texto redactado el 29-oct-2026 contra el código de esa fecha (docs/privacy.md es la
fuente de verdad técnica); conviene que lo revise un profesional antes del lanzamiento en las tiendas.
El generador HTML (web/legal/md2html.py) omite este comentario.
-->

# Política de privacidad de Ink Lab

Última actualización: 29 de octubre de 2026

Ink Lab es una app para quien dibuja con rotuladores de alcohol: consulta las muestras de color, empareja el color de
una foto con un rotulador de tu colección y construye paletas con teoría del color. Es una app independiente: no está
creada, revisada ni respaldada por Ohuhu, DecoTime ni ninguna otra marca.

Resumen: **no tienes cuenta, no hay servidor propio y todo se queda en tu móvil.** La app es totalmente gratuita y de
código abierto, y no incluye analítica, anuncios ni rastreo. Solo envía datos fuera del móvil si **tú** activas la IA
con tu propia clave de OpenRouter, y entonces se envía justo lo que se explica más abajo.

## 1. Responsable del tratamiento

- Titular: Daniel Mont Ferrandiz
- Correo de contacto: dev@mainshai.com

## 2. Qué datos se tratan

### Datos que se quedan en tu móvil (no los recibimos)
Tu marca activa, los packs y rotuladores que tienes, tus favoritos, tus paletas guardadas, el historial de tus últimas
elecciones al emparejar colores y tus ajustes se guardan solo en el almacenamiento privado de la app, en tu
dispositivo. Los catálogos de rotuladores van dentro de la app y todo funciona sin conexión. No hay sincronización ni
copia en ningún servidor nuestro.

La copia de seguridad del sistema de Android está **desactivada** para esta app, de modo que ni tus ajustes ni tu clave
salen del móvil por esa vía. En iPhone, las preferencias entran en la copia del dispositivo que gestionas con tu cuenta
de Apple.

### Cámara y galería
Solo cuando usas «Emparejar» y eliges hacer una foto o elegir una de la galería, la app pide el permiso o abre el
selector del sistema. La foto se decodifica y se muestrea **en tu móvil** para hallar el rotulador más parecido: no se
sube a ningún sitio, no se guarda y nunca se envía a un proveedor de IA. De la elección solo se conserva el color
muestreado y el rotulador emparejado, en tu historial local.

### Copia de seguridad
«Exportar copia» (Ajustes) genera un texto JSON con tus colecciones, favoritos, paletas e historial, y lo **copia al
portapapeles** para que lo pegues donde quieras; «Importar copia» lo recibe pegándolo. No está cifrado, no lleva ningún
identificador y nunca incluye tu clave de API. Lo que hagas con él después (guardarlo en tu nube, mandarlo por un
mensaje...) queda fuera de la app. Ten en cuenta que, según tu sistema, el portapapeles puede ser visible para tu
teclado o para otras apps.

### IA opcional
Está **apagada de serie**. Con ella apagada, la app no abre ninguna conexión de red. Si la activas, antes te enseña qué
saldría del móvil y puedes elegir entre:

- **Teoría del color (motor local):** sin IA y sin red.
- **En el móvil (Gemini Nano, en Android compatible):** tu escenario y los códigos de color se procesan en tu teléfono y
  Ink Lab no los envía a ningún sitio. Si el modelo no está en el móvil, Android lo descarga una vez a través de los
  servicios de Google; esa descarga y el modelo se rigen por las condiciones de Google.
- **OpenRouter con tu clave:** al pulsar «Sugerir con IA», la app envía, **desde tu móvil directamente a
  `openrouter.ai`, por HTTPS y con tu propia clave y tu propia cuenta**: la marca y el escenario o modo que has elegido,
  el código, el nombre y el color hex del rotulador base, los códigos, nombres y colores hex de los rotuladores
  candidatos de tu colección, el tamaño de la paleta y los ajustes de generación (modelo, temperatura y límite de
  longitud). Para mostrarte los modelos disponibles, la app consulta el catálogo de OpenRouter (con tu clave, si la has
  guardado). **Nunca** se envían fotos, tus favoritos, tus paletas guardadas ni identificadores tuyos. OpenRouter y el
  proveedor del modelo que elijas reciben esa petición y aplican **sus propias** condiciones y políticas de privacidad,
  que puedes leer en https://openrouter.ai/privacy. El desarrollador no la ve, no pasa por ningún servidor suyo y no se
  guarda.

Tu clave de OpenRouter se guarda en el almacén seguro del sistema (Android Keystore o Keychain de iOS, solo en este
dispositivo). No se sube al desarrollador, no se incluye en las copias de seguridad y puedes borrarla en Ajustes cuando
quieras. Si la IA falla, la app vuelve a la teoría del color.

### Permisos
La app pide el permiso de **cámara o fotos** solo cuando usas «Emparejar», y declara el acceso a **red** solo para la IA
opcional con OpenRouter. No pide ubicación, contactos, calendario, micrófono ni notificaciones, y no usa el
identificador publicitario.

### Datos que NO se tratan
- No pedimos ni guardamos nombre, correo, teléfono, edad ni ningún dato de cuenta: no hay cuentas.
- No hay analítica, ni anuncios, ni publicidad personalizada, ni rastreo entre apps, ni informes de errores.
- No recibimos tus fotos, tus colecciones, tus paletas ni tu clave.

### Si nos escribes
Puedes escribirnos a dev@mainshai.com. Trataremos tu dirección de correo y lo que nos cuentes solo para responderte.
No nos mandes tu clave de API ni copias de seguridad con datos que no quieras compartir: para un fallo nos basta con
datos de prueba.

## 3. Para qué y con qué base jurídica

| Tratamiento | Finalidad | Base jurídica (RGPD) |
|---|---|---|
| Colecciones, favoritos, paletas y ajustes en tu móvil | Que uses la app y conserves tu trabajo | No los recibimos: se quedan en tu dispositivo, bajo tu control |
| Foto de «Emparejar» | Hallar el rotulador más parecido | Se procesa solo en tu móvil, a petición tuya; no la recibimos |
| IA con OpenRouter (opcional) | Generar sugerencias de paleta | Tu consentimiento al activarla y usar tu propia clave; el tratamiento lo hace OpenRouter bajo sus condiciones |
| Correos de soporte | Responder a tu consulta | Tu solicitud y nuestro interés legítimo en atenderla (art. 6.1.f) |

No tomamos decisiones automatizadas ni elaboramos perfiles sobre ti.

## 4. Quién recibe los datos
La app no transmite datos al desarrollador ni a terceros por su cuenta. Si activas la IA con OpenRouter, la petición
descrita arriba la reciben OpenRouter y el proveedor del modelo que elijas, en tu nombre y con tu clave. Si envías un
correo de soporte, lo recibe el titular en dev@mainshai.com mediante el servicio de correo que elijas.

## 5. Transferencias internacionales
El desarrollador no realiza transferencias de datos. Si usas la IA con OpenRouter, la petición va al proveedor que
elijas, que puede tratarla en otras regiones y bajo sus propias condiciones. Los demás servicios que decidas utilizar
(correo, nube, destino de un texto copiado) se rigen por sus propias condiciones.

## 6. Cuánto tiempo se conservan

- **Datos en tu móvil:** hasta que desinstales la app o borres sus datos desde los ajustes del sistema (y, en su caso,
  de los textos de copia que hayas guardado).
- **Correos de soporte:** el tiempo necesario para atender tu consulta y, como máximo, un año desde la última
  respuesta.

## 7. Tus derechos

Puedes ejercer tus derechos de **acceso, rectificación, supresión, oposición, limitación del tratamiento y
portabilidad** escribiendo a dev@mainshai.com. Te responderemos en el plazo de un mes.

No recibimos los datos guardados en tu móvil, así que no podemos verlos ni borrarlos por ti. Puedes borrarlos
desinstalando la app o borrando sus datos desde los ajustes del sistema, y llevártelos con «Exportar copia». Para lo que
hayas enviado a OpenRouter, ejerce tus derechos ante OpenRouter y el proveedor del modelo.

Si crees que no hemos tratado bien tus datos, puedes reclamar ante la Agencia Española de Protección de Datos:
https://www.aepd.es

## 8. Menores

La app no está dirigida a menores de 13 años (o la edad mínima equivalente en tu país). No pide la edad ni recoge datos
personales de nadie, tampoco de menores: no hay cuentas y todo se queda en el dispositivo. La IA con OpenRouter exige
una cuenta propia en un tercero, que los menores no deben crear sin permiso de sus padres o tutores.

## 9. Seguridad
No hay servidor del desarrollador ni transmisión de datos desde la app salvo la IA opcional. Tus datos están en el
espacio privado de la app; tu clave, en el Keystore o el Keychain; las conexiones a OpenRouter usan HTTPS y no siguen
redirecciones. Proteger tu móvil (bloqueo de pantalla, cifrado, sin root ni jailbreak) es cosa tuya. El código es
público y cualquiera puede comprobar lo que hace.

## 10. Cambios en esta política

Si cambia lo que hace la app con los datos, actualizaremos esta página y la fecha de arriba. Si el cambio es
importante (por ejemplo, si alguna función enviara datos fuera del móvil), te lo indicaremos también dentro de la app y
solo se activaría con tu consentimiento.

## 11. Contacto

dev@mainshai.com

---

## Notas para el titular (no publicar)
Borra esta sección antes de publicar (el generador HTML la omite). Decisiones ya tomadas en este texto, por si quieres
cambiarlas: titular Daniel Mont Ferrandiz y correo `dev@mainshai.com`; conservación de correos «un año desde la última
respuesta»; la fecha de última actualización es la de la redacción; la IA en el móvil se describe como Gemini Nano en Android
(iOS aún no la tiene, véase `docs/privacy.md`). Publica la URL (`docs/legal/LEEME.md`) y ponla en las
fichas de las tiendas; comprueba que coincide con «Seguridad de los datos» (Play) y «Privacidad de la app» (Apple). La
versión inglesa (`politica-privacidad.en.md`) es una traducción de cortesía; manda la española.
