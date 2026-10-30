# Política de privacidad de Ink Lab

Última actualización: 2026-10-30

Ink Lab es una app para quien dibuja con rotuladores de alcohol: consulta las muestras de color, empareja el color de
una foto con un rotulador de tu colección y construye paletas con teoría del color. Es una app independiente: no está
creada, revisada ni respaldada por Ohuhu, DecoTime ni ninguna otra marca.

Resumen: **no tienes cuenta, no hay servidor propio y tus datos se quedan en tu móvil.** La app es totalmente gratuita
y de código abierto, y no incluye analítica propia, anuncios ni rastreo. **Si no activas la IA, la app no usa la red.**
Si la activas, en Android la IA en el móvil usa ML Kit de Google, que envía a Google datos de diagnóstico y de uso
(nunca tus peticiones, tus colores ni tus fotos); y si eliges OpenRouter con tu propia clave, se envía justo lo que se
explica más abajo.

## 1. Responsable del tratamiento

- Titular: Daniel Mont Ferrandiz
- Correo de contacto: inklab@mainshai.com

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
Solo cuando usas «Emparejar» o «Escena desde una foto» (en Paleta) y eliges hacer una foto o elegir una de la galería,
la app pide el permiso o abre el selector del sistema. La foto se decodifica y se analiza **en tu móvil**: no se sube a
ningún sitio, no se guarda y nunca se envía a un proveedor de IA. En «Emparejar», de la elección solo se conserva el
color muestreado y el rotulador emparejado, en tu historial local. En «Escena desde una foto» se sacan sus colores
principales para proponerte rotuladores de tu colección; la foto solo se mantiene en memoria mientras ves el resultado,
y si guardas la paleta se guardan los códigos de los rotuladores, nunca la foto.

### Copia de seguridad
«Exportar copia» (Ajustes) genera un texto JSON con tus colecciones, favoritos, paletas e historial, y lo **copia al
portapapeles** para que lo pegues donde quieras; «Importar copia» lo recibe pegándolo. No está cifrado, no lleva ningún
identificador y nunca incluye tu clave de API. Lo que hagas con él después (guardarlo en tu nube, mandarlo por un
mensaje...) queda fuera de la app. Ten en cuenta que, según tu sistema, el portapapeles puede ser visible para tu
teclado o para otras apps.

### IA opcional
Está **apagada de serie** (Ajustes → Asistente de IA → Sugerir con IA). Con ella apagada, la app no abre ninguna
conexión de red y no llama a ML Kit. Si la activas, antes te enseña qué saldría del móvil y puedes elegir entre:

- **Teoría del color (motor local):** sin IA y sin red.
- **En el móvil (Gemini Nano, en Android compatible, mediante ML Kit de Google):** tu escenario y los códigos de color
  se procesan en tu teléfono y no se envían a ningún sitio. Al activar la IA, la app usa ML Kit para comprobar si Gemini
  Nano está disponible y, si eliges esta opción, para descargarlo y generar las sugerencias. Al usarse, **ML Kit envía a
  Google**, por HTTPS y en lotes (más o menos una vez al día), datos de diagnóstico y de uso: información del
  dispositivo (fabricante, modelo, versión y compilación del sistema), de la app (nombre del paquete y versión),
  identificadores del dispositivo y otros, incluidos identificadores por instalación, métricas de rendimiento, la
  configuración de la API, el tamaño de la entrada y de la salida, la versión de la función, el tipo de evento, códigos
  de error y los idiomas configurados. Google indica que los usa para diagnóstico y analítica de uso y que no los
  transfiere a terceros (https://developers.google.com/ml-kit/android-data-disclosure). Ese envío no incluye el
  contenido de tus peticiones, tus colores ni tus fotos, solo su tamaño. El desarrollador no recibe esos datos: los trata
  Google según sus propias condiciones y su política de privacidad (https://policies.google.com/privacy). Si el modelo
  no está en el móvil, Android lo descarga una vez a través de los servicios de Google; esa descarga y el modelo se
  rigen por las condiciones de Google. En iPhone no hay IA en el móvil ni ML Kit.
- **OpenRouter con tu clave:** solo si eliges OpenRouter, guardas tu clave y pulsas «Sugerir con IA» en Paleta, la app
  envía, **desde tu móvil directamente a `openrouter.ai`, por HTTPS y con tu propia clave y tu propia cuenta**: la marca
  (identificador y nombre), el modo de paleta, el nombre de la escena (en inglés), el código y el nombre del rotulador
  base (si lo hay) y si está fijado, el tamaño de la paleta, los códigos y colores hex de los rotuladores candidatos de
  tu colección (no sus nombres), los ajustes de generación (modelo, temperatura y límite de longitud), unas
  instrucciones fijas de la app y la cabecera `X-Title: Ink Lab`. Para mostrarte los modelos disponibles, la app
  consulta el catálogo de OpenRouter (con tu clave, si la has guardado). **Nunca** se envían fotos (la petición indica
  que no lleva imagen y la app no tiene forma de adjuntarla), tus favoritos, tus paletas guardadas ni identificadores
  tuyos. Como en cualquier conexión a internet, OpenRouter y el proveedor del modelo ven la dirección IP de tu
  dispositivo. Reciben esa petición y aplican **sus propias** condiciones y políticas de privacidad, también sobre cuánto
  tiempo la conservan, que puedes leer en https://openrouter.ai/privacy. El desarrollador no la ve, no pasa por ningún
  servidor suyo y la app no la guarda.

Tu clave de OpenRouter se guarda en el almacén seguro del sistema (Android Keystore o Keychain de iOS, solo en este
dispositivo). No se sube al desarrollador, no se incluye en las copias de seguridad y puedes borrarla en Ajustes cuando
quieras. Si la IA falla, la app vuelve a la teoría del color.

### Permisos
La app pide el permiso de **cámara o fotos** solo cuando usas «Emparejar» o «Escena desde una foto». En Android declara
el acceso a **internet** y al **estado de la red** (`INTERNET` y `ACCESS_NETWORK_STATE`), que solo se usan con la IA
activada: para la IA opcional con OpenRouter y para los diagnósticos que ML Kit envía a Google cuando se usa la IA en el
móvil. No pide ubicación, contactos, calendario, micrófono ni notificaciones, y no usa el identificador publicitario.

### Datos que NO se tratan
- No pedimos ni guardamos nombre, correo, teléfono, edad ni ningún dato de cuenta: no hay cuentas.
- El desarrollador no usa analítica ni informes de errores, y no hay anuncios, publicidad personalizada ni rastreo
  entre apps. La única excepción son los datos de diagnóstico y de uso que ML Kit envía a Google cuando usas la IA en
  el móvil (ver «IA opcional»); el desarrollador no los recibe.
- No recibimos tus fotos, tus colecciones, tus paletas ni tu clave.

### Si nos escribes
Puedes escribirnos a inklab@mainshai.com. Trataremos tu dirección de correo y lo que nos cuentes solo para responderte.
No nos mandes tu clave de API ni copias de seguridad con datos que no quieras compartir: para un fallo nos basta con
datos de prueba.

Si reportas una sugerencia de la IA («Reportar esta sugerencia», en Paleta), la app abre tu app de correo con un
mensaje ya escrito para inklab@mainshai.com: el motivo que elijas, la versión de la app, el proveedor y el modelo de IA,
la marca, el modo o la escena, el código del rotulador base y los códigos, papeles y motivos de esa sugerencia. Nunca incluye tu clave de
API ni fotos. Solo nos llega si tú lo envías, y lo usamos para revisar el contenido reportado y mejorar las
sugerencias. Si no hay app de correo, el informe se copia al portapapeles para que lo pegues tú.

## 3. Para qué y con qué base jurídica

| Tratamiento | Finalidad | Base jurídica (RGPD) |
|---|---|---|
| Colecciones, favoritos, paletas y ajustes en tu móvil | Que uses la app y conserves tu trabajo | No los recibimos: se quedan en tu dispositivo, bajo tu control |
| Foto de «Emparejar» o de «Escena desde una foto» | Hallar los rotuladores más parecidos | Se procesa solo en tu móvil, a petición tuya; no la recibimos |
| Diagnósticos de ML Kit (solo con la IA en el móvil, en Android) | Diagnóstico y analítica de uso del SDK, según Google | Se envían solo si decides activar la IA opcional; los trata Google como proveedor de ML Kit, bajo sus propias condiciones y su política de privacidad; no los recibimos |
| IA con OpenRouter (opcional) | Generar sugerencias de paleta | Tu consentimiento al activarla y usar tu propia clave; el tratamiento lo hace OpenRouter bajo sus condiciones |
| Correos de soporte y reportes de sugerencias de IA | Responder a tu consulta y revisar el contenido reportado | Tu solicitud y nuestro interés legítimo en atenderla (art. 6.1.f) |

No tomamos decisiones automatizadas ni elaboramos perfiles sobre ti.

## 4. Quién recibe los datos
La app no transmite datos al desarrollador. Si activas la IA, en Android **Google** recibe los datos de diagnóstico y
de uso que envía ML Kit al usarse la IA en el móvil. Si usas la IA con OpenRouter, la petición descrita arriba la
reciben **OpenRouter** y el **proveedor del modelo** que elijas, en tu nombre y con tu clave. Si envías un
correo de soporte o un reporte de una sugerencia, lo recibe el titular en inklab@mainshai.com (o en dev@mainshai.com, el buzón que usaba la app hasta la versión 0.6.2) mediante el servicio de correo que elijas.

## 5. Transferencias internacionales
El desarrollador no realiza transferencias de datos. Si usas la IA con OpenRouter, la petición va al proveedor que
elijas, que puede tratarla en otras regiones y bajo sus propias condiciones. Google puede tratar los diagnósticos de ML Kit en
otros países, según sus propias condiciones. Los demás servicios que decidas utilizar
(correo, nube, destino de un texto copiado) se rigen por sus propias condiciones.

## 6. Cuánto tiempo se conservan

- **Datos en tu móvil:** hasta que desinstales la app o borres sus datos desde los ajustes del sistema (y, en su caso,
  de los textos de copia que hayas guardado).
- **Correos de soporte:** el tiempo necesario para atender tu consulta y, como máximo, un año desde la última
  respuesta.

## 7. Tus derechos

Puedes ejercer tus derechos de **acceso, rectificación, supresión, oposición, limitación del tratamiento y
portabilidad** escribiendo a inklab@mainshai.com. Te responderemos en el plazo de un mes.

No recibimos los datos guardados en tu móvil, así que no podemos verlos ni borrarlos por ti. Puedes borrarlos
desinstalando la app o borrando sus datos desde los ajustes del sistema, y llevártelos con «Exportar copia». Para lo que
hayas enviado a OpenRouter, ejerce tus derechos ante OpenRouter y el proveedor del modelo; para los diagnósticos de
ML Kit, ante Google.

Si crees que no hemos tratado bien tus datos, puedes reclamar ante la Agencia Española de Protección de Datos:
https://www.aepd.es

## 8. Menores

La app no está dirigida a menores de 13 años (o la edad mínima equivalente en tu país). No pide la edad ni recoge datos
personales de nadie, tampoco de menores: no hay cuentas y tus datos se quedan en el dispositivo. La IA con OpenRouter exige
una cuenta propia en un tercero, que los menores no deben crear sin permiso de sus padres o tutores.

## 9. Seguridad
No hay servidor del desarrollador ni transmisión de datos desde la app salvo con la IA opcional activada. Tus datos están en el
espacio privado de la app; tu clave, en el Keystore o el Keychain; las conexiones a OpenRouter usan HTTPS y no siguen
redirecciones. Proteger tu móvil (bloqueo de pantalla, cifrado, sin root ni jailbreak) es cosa tuya. El código es
público y cualquiera puede comprobar lo que hace.

## 10. Cambios en esta política

Si cambia lo que hace la app con los datos, actualizaremos esta página y la fecha de arriba. Si el cambio es
importante (por ejemplo, si alguna función enviara datos fuera del móvil), te lo indicaremos también dentro de la app y
solo se activaría con tu consentimiento.

## 11. Contacto

inklab@mainshai.com
