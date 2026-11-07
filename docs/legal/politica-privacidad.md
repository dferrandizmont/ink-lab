# Política de privacidad de Ink Lab


Última actualización: 2026-11-07

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
Tu marca activa, los packs y rotuladores que tienes, tus favoritos, tu lista de deseos, el nivel de tinta de tus
rotuladores (lleno, se acaba o seco) y tus notas de recarga, las fotos de tus muestras reales, los colores propios que
guardas para tus rotuladores, tus paletas guardadas, tus recetas de mezcla y sus fotos, el historial de tus últimas
elecciones al emparejar colores, las entradas y las fotos de tu diario, tus ideas favoritas y vistas hace poco, tus
ajustes, el punto de la bienvenida en que te quedaste, la fecha en que guardaste tu última copia en archivo y el
registro de errores (ver más abajo) se guardan solo en el almacenamiento privado de la app, en tu dispositivo. De cada
color propio solo se guarda su código hex, nunca la foto de la que lo sacaste. Los catálogos de las 15 marcas de
rotuladores (Ohuhu, DecoTime, Copic, Finecolour, Touch Twin, Promarker, Promarker Brush, Prismacolor Premier, Spectrum
Noir, Arrtx, ZIG Kurecolor, Graph'it, Marvy Le Plume, Blick Studio Brush y Artist's Loft) van dentro de la app y todo
funciona sin conexión. «En otras marcas», «Sombra y luz», «Mezclar con…» y el aviso de rotuladores casi iguales (en el
detalle de un rotulador), la búsqueda por hex, la vista «Valores» en gris, la previsualización de «Visión del color»
(en Paleta), el «Mapa de color» y el traductor de recetas (en Mi colección → Herramientas) y los «Números del diario»
se calculan en tu móvil con esos catálogos y tus datos, sin enviar nada. No hay sincronización ni copia en ningún
servidor nuestro.

La copia de seguridad del sistema de Android está **desactivada** para esta app: excluye todos sus ficheros de la copia
en la nube y de la transferencia entre dispositivos, de modo que ni tus ajustes, ni tu clave, ni tus datos, ni las fotos
del diario ni el registro de errores salen del móvil por esa vía. En iPhone, las preferencias, el diario, las recetas de
mezcla, las fotos que guarda la app y el registro de errores pueden entrar en la copia del dispositivo o de iCloud que
gestionas con tu cuenta de Apple: es un mecanismo de Apple bajo tu control, no un envío del desarrollador.

### Cámara y galería
Solo cuando usas «Emparejar», «Desde una foto» (en Paleta) o «Mi color» (en el detalle de un rotulador), o añades una
foto a una entrada del «Diario» (en Ideas), a la «Muestra real» de un rotulador o a una receta de mezcla, y eliges
hacer una foto o elegir una de la galería, la app pide el permiso o abre el selector del sistema. La foto se decodifica
y se analiza **en tu móvil**: no se sube a ningún sitio y nunca se envía a un proveedor de IA; salvo en el diario, en
la muestra real y en las recetas (ver más abajo), tampoco se guarda. En «Emparejar», de la elección
solo se conserva el color muestreado y el rotulador emparejado, en tu historial local. En «Desde una foto» se sacan
sus colores principales para proponerte rotuladores de tu colección; la foto solo se mantiene en memoria mientras ves
el resultado, y si guardas la paleta se guardan los códigos de los rotuladores, nunca la foto. En «Mi color», tocas la
muestra pintada en la foto y solo se guarda su color como código hex, nunca la foto.

### Diario
En la pestaña Ideas, «Diario» te deja anotar las obras que pintas: título, fecha, sobre qué la pintaste, estado,
rotuladores usados, paleta enlazada y notas. Las entradas se guardan en tu móvil como el resto de tus datos. Cada
entrada admite hasta 4 fotos, hechas con la cámara o elegidas de la galería, que la app copia reducidas (como máximo
2048 píxeles de lado) a su carpeta privada; la foto original de tu galería no se modifica. Esas fotos no se suben a
ningún sitio ni se envían a las funciones de IA (ni a OpenRouter, ni a Gemini Nano, ni a ML Kit), y se borran cuando
quitas la foto o la entrada, y con la app al desinstalarla. «Compartir esta entrada» dibuja, solo cuando lo tocas, una
imagen con el título, la fecha, el estado, la primera foto, los rotuladores usados y los colores de la paleta
enlazada, y la entrega únicamente a la app que elijas en el menú de compartir del sistema.

### Muestras reales, nivel de tinta y recetas de mezcla
En el detalle de un rotulador que tienes puedes marcar su nivel de tinta (lleno, se acaba o seco), escribir una nota
de recarga de hasta 80 caracteres y añadir una foto de tu muestra real en papel, que la app copia reducida (unos 1024
píxeles de lado) a su carpeta privada. En Mi colección → Herramientas puedes guardar tus propias recetas de mezcla
(nombre, rotuladores, notas y una foto opcional, reducida a 2048 píxeles de lado). Todo eso se queda en tu móvil: las
fotos no se suben a ningún sitio ni se envían a las funciones de IA, se borran cuando las quitas o borras la receta, y
con la app al desinstalarla. Solo salen del móvil si tú guardas una copia en archivo (ver más abajo) y la mandas a
algún sitio.

### Compartir como texto
«Compartir como texto» (en Paleta), la exportación de tu colección en CSV o texto y la receta traducida (en
Herramientas) preparan un texto con los rotuladores (la marca, los códigos y, según el caso, los nombres, los colores
y si están secos) y, solo cuando lo tocas, lo entregan a la app que elijas en el menú de compartir del sistema o lo
copian al portapapeles. «Importar desde texto» y
la importación de códigos leen únicamente el texto que pegas o escribes; no abren enlaces ni se conectan a nada.

### Valoración en la tienda
Una sola vez, después de guardar tu tercera paleta o tu primera entrada del diario, la app pide al sistema que muestre
el diálogo de valoración de la tienda (Google Play en Android, App Store en iPhone). Es la tienda la que decide si lo
enseña y la que recibe tu valoración si la escribes, bajo sus propias condiciones; Ink Lab no recibe la nota ni el
texto, no sabe si has valorado y no envía nada. En Android es una comunicación interna del móvil con la app de Google
Play. La app solo apunta en tu móvil que ya lo pidió, para no volver a hacerlo, y deja de intentarlo si la tienda no
puede mostrar el diálogo tres veces.

### Modo caballete y accesos directos
El modo caballete (en Paleta) muestra la paleta en grande y mantiene la pantalla encendida mientras está abierto; al
cerrarlo, la pantalla vuelve a apagarse con normalidad. No pide permisos ni guarda o envía datos. Los accesos directos
de la pantalla de inicio (pulsación larga en el icono en Android, acciones rápidas en iPhone) solo abren Emparejar,
Nueva paleta o Buscar muestras: no llevan datos tuyos.

### Copia de seguridad
«Exportar» (Ajustes → Copia de seguridad) genera un texto JSON, no un fichero, con tus ajustes, los ajustes de la IA
que no son secretos, tu colección, favoritos, lista de deseos, rotuladores secos, nivel de tinta y notas de recarga,
colores propios, paletas, historial, ideas favoritas y vistas hace poco, las entradas del diario y tus recetas de
mezcla (con los nombres internos de los ficheros de sus fotos y de las fotos de tus muestras, no las fotos), y lo
**copia al portapapeles** para que lo pegues donde quieras; «Importar» lo recibe pegándolo. Al
importar, la copia reemplaza tus datos actuales, también el diario: las entradas que no estén en ella se borran junto
con sus fotos, y la app te lo avisa antes. La copia no está cifrada, no lleva ningún identificador y nunca incluye tu
clave de API ni ninguna foto. Lo que hagas con él después (guardarlo en tu nube, mandarlo por un mensaje...)
queda fuera de la app. Ten en cuenta que, según tu sistema, el portapapeles puede ser visible para tu teclado o para
otras apps.

«Compartir copia de seguridad» (Ajustes → Tus datos → Copia en archivo) crea un archivo ZIP con esa misma copia y,
además, las fotos del diario, de tus muestras reales y de tus recetas de mezcla, lo escribe en la carpeta temporal (caché) de la app y abre el menú de compartir del
sistema para que lo guardes en Archivos, Drive o la app que elijas: solo va a donde tú lo mandes, y la app borra los
archivos de copia anteriores de esa carpeta al crear el siguiente. «Restaurar desde un archivo» abre el selector de
documentos del sistema, que no necesita ningún permiso (el selector deja una copia del archivo elegido en la caché de
la app, y la app la borra al terminar); el archivo se comprueba entero antes de escribir nada y la app te pide
confirmación, porque reemplaza tus datos actuales, fotos incluidas, y borra las fotos que no estén en el archivo. Ninguna copia, ni la del portapapeles ni la del archivo, incluye tu clave de API.

La app recuerda además, solo en tu móvil, la fecha en que guardaste por última vez una copia en archivo, para
mostrártela y proponerte una copia nueva cuando hayan pasado más de 30 días. Esa fecha no forma parte de ninguna copia.

### Registro de errores
Si la app sufre un error inesperado, escribe una breve anotación en un fichero de su almacenamiento privado, en tu
móvil, para que el fallo pueda localizarse y corregirse. Cada anotación recoge la hora, la versión de la app, la
plataforma y la versión del sistema, la parte de la app en la que se capturó el error, la primera línea del mensaje de
error (como máximo 300 caracteres) y una traza técnica del código (stack trace) recortada. Antes de guardar una
anotación, la app sustituye los parámetros de las direcciones web, los tokens y las claves, las direcciones de correo y
los nombres de carpeta que identifican la app o al usuario del dispositivo. El registro está pensado para datos
técnicos, no para tu contenido, aunque un mensaje de error puede incluir alguna vez un fragmento de lo que la app estaba
manejando en ese momento. El fichero tiene un tope de unos 200 KB y se conserva un único fichero anterior; las
anotaciones más antiguas se descartan. El registro **nunca sale del móvil por sí solo**: no se sube nada y la app no usa
ningún servicio de informes de errores. En Ajustes → Acerca de, «Compartir registro de errores» entrega el fichero, solo
cuando lo tocas, a la app que elijas en el menú de compartir del sistema, y solo va a donde tú lo mandes; «Borrar
registro de errores» lo elimina, junto con el fichero anterior. En Android queda excluido de la copia en la nube y de la
transferencia entre dispositivos, como el resto de los datos de la app; en iPhone puede entrar en la copia del
dispositivo o de iCloud, también como el resto de los datos de la app.

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
  rigen por las condiciones de Google. En iPhone no se usa ML Kit: la IA en el móvil es Apple Intelligence (ver el
  apartado siguiente).
- **En el iPhone (Apple Intelligence, en iOS 26 o posterior y iPhone compatible):** tu escenario y los códigos de color
  los procesa en tu teléfono el modelo de Apple que viene con Apple Intelligence, mediante el framework Foundation Models
  de Apple. La app no descarga el modelo (lo instala y gestiona iOS), no usa ningún otro servicio para esta opción y no
  envía nada: ni tus peticiones, ni tus colores, ni tus fotos.
- **OpenRouter con tu clave:** solo si eliges OpenRouter, guardas tu clave y pulsas «Sugerir con IA» en Paleta, la app
  envía, **desde tu móvil directamente a `openrouter.ai`, por HTTPS y con tu propia clave y tu propia cuenta**: la marca
  (identificador y nombre), el modo de paleta, el nombre de la escena (en inglés), el código y el nombre del rotulador
  base (si lo hay) y si está fijado, el tamaño de la paleta, los códigos y colores hex del catálogo de los rotuladores
  candidatos de tu colección (no sus nombres), los ajustes de generación (modelo, temperatura y límite de longitud),
  unas instrucciones fijas de la app y la cabecera `X-Title: Ink Lab`. Para mostrarte los modelos disponibles, la app
  consulta el catálogo de OpenRouter (con tu clave, si la has guardado). **Nunca** se envían fotos (la petición indica
  que no lleva imagen y la app no tiene forma de adjuntarla), tus colores propios, tus favoritos, tus paletas guardadas
  ni identificadores tuyos. Como en cualquier conexión a internet, OpenRouter y el proveedor del modelo ven la dirección
  IP de tu dispositivo. Reciben esa petición y aplican **sus propias** condiciones y políticas de privacidad, también
  sobre cuánto tiempo la conservan, que puedes leer en https://openrouter.ai/privacy. El desarrollador no la ve, no pasa
  por ningún servidor suyo y la app no la guarda.

Tu clave de OpenRouter se guarda en el almacén seguro del sistema (Android Keystore o Keychain de iOS, solo en este
dispositivo). No se sube al desarrollador, no se incluye en las copias de seguridad y puedes borrarla en Ajustes cuando
quieras. Si la IA falla, la app vuelve a la teoría del color.

### Permisos
La app pide el permiso de **cámara o fotos** solo cuando usas «Emparejar», «Desde una foto» o «Mi color», o añades una
foto al «Diario», a una muestra real o a una receta de mezcla. En Android declara el acceso a **internet** y al **estado de la red** (`INTERNET` y
`ACCESS_NETWORK_STATE`), que solo se usan con la IA activada: para la IA opcional con OpenRouter y para los diagnósticos
que ML Kit envía a Google cuando se usa la IA en el móvil. No pide ubicación, contactos, calendario, micrófono ni
notificaciones, y no usa el identificador publicitario. Si compartes una paleta, una carta de muestras o una entrada del
diario como imagen, una copia en archivo o el registro de errores, solo se entrega a la app que elijas en el menú de
compartir del sistema; la app no necesita ningún permiso para ello, ni tampoco para elegir un archivo de copia con el
selector del sistema. El modo caballete, los accesos directos y la valoración en la tienda no necesitan permisos. En
iPhone, el manifiesto de privacidad de la app declara, como exige Apple, que una librería que usa la app (para leer su
propia versión) puede consultar la fecha de los ficheros; solo lo hace con los ficheros de la propia app, dentro de su
espacio privado (motivo C617.1), y esa información no sale del móvil.

### Datos que NO se tratan
- No pedimos ni guardamos nombre, correo, teléfono, edad ni ningún dato de cuenta: no hay cuentas.
- El desarrollador no usa analítica ni informes de errores, y no hay anuncios, publicidad personalizada ni rastreo
  entre apps. La única excepción son los datos de diagnóstico y de uso que ML Kit envía a Google cuando usas la IA en
  el móvil (ver «IA opcional»); el desarrollador no los recibe.
- El registro de errores (ver «Registro de errores») no es un informe de errores automático: no se envía nada por sí
  solo, y solo sale del móvil si lo compartes tú.
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

«Enviar comentarios» (Ajustes → Acerca de) abre tu app de correo con un mensaje para inklab@mainshai.com que ya lleva la
versión de la app, la plataforma y la versión del sistema, y deja espacio para que escribas. No se envía nada si no
mandas tú el correo, y no se adjunta el registro de errores. Si no hay app de correo, la dirección se copia al
portapapeles. Si nos mandas el registro de errores, lo usamos solo para localizar y corregir el fallo.

## 3. Para qué y con qué base jurídica


| Tratamiento | Finalidad | Base jurídica (RGPD) |
|---|---|---|
| Colecciones, nivel de tinta y notas, lista de deseos, colores propios, favoritos, paletas, recetas de mezcla, diario y ajustes en tu móvil | Que uses la app y conserves tu trabajo | No los recibimos: se quedan en tu dispositivo, bajo tu control |
| Foto de «Emparejar», de «Desde una foto», de «Mi color», del «Diario», de una muestra real o de una receta de mezcla | Hallar los rotuladores más parecidos, leer el color de tu muestra o guardar la foto de una obra, de una muestra o de una receta | Se procesa (y, en el diario, la muestra real y las recetas, se guarda) solo en tu móvil, a petición tuya; no la recibimos |
| Registro de errores en tu móvil | Localizar y corregir los fallos de la app | Se guarda solo en tu móvil y no lo recibimos. Si decides mandárnoslo: tu solicitud y nuestro interés legítimo en corregir el fallo (art. 6.1.f) |
| Diagnósticos de ML Kit (solo con la IA en el móvil, en Android) | Diagnóstico y analítica de uso del SDK, según Google | Se envían solo si decides activar la IA opcional; los trata Google como proveedor de ML Kit, bajo sus propias condiciones y su política de privacidad; no los recibimos |
| IA con OpenRouter (opcional) | Generar sugerencias de paleta | Tu consentimiento al activarla y usar tu propia clave; el tratamiento lo hace OpenRouter bajo sus condiciones |
| Correos de soporte, comentarios y reportes de sugerencias de IA | Responder a tu consulta y revisar el contenido reportado | Tu solicitud y nuestro interés legítimo en atenderla (art. 6.1.f) |

No tomamos decisiones automatizadas ni elaboramos perfiles sobre ti.

## 4. Quién recibe los datos
La app no transmite datos al desarrollador. Si activas la IA, en Android **Google** recibe los datos de diagnóstico y de
uso que envía ML Kit al usarse la IA en el móvil. Si usas la IA con OpenRouter, la petición descrita arriba la reciben
**OpenRouter** y el **proveedor del modelo** que elijas, en tu nombre y con tu clave. Si nos envías un correo de
soporte, unos comentarios, un reporte de una sugerencia o el registro de errores, lo recibe el titular en
inklab@mainshai.com (o en dev@mainshai.com, el buzón que usaba la app hasta la versión 0.6.2) mediante el servicio que
elijas. Si compartes el registro de errores con otra persona o servicio, solo lo recibe ese destinatario. Si escribes
una valoración en el diálogo de la tienda, la recibe **Google** o **Apple** directamente, no la app.

## 5. Transferencias internacionales
El desarrollador no realiza transferencias de datos. Si usas la IA con OpenRouter, la petición va al proveedor que
elijas, que puede tratarla en otras regiones y bajo sus propias condiciones. Google puede tratar los diagnósticos de ML Kit en
otros países, según sus propias condiciones. Los demás servicios que decidas utilizar
(correo, nube, destino de un texto copiado o de un archivo o imagen compartidos) se rigen por sus propias condiciones.

## 6. Cuánto tiempo se conservan


- **Datos en tu móvil:** hasta que desinstales la app o borres sus datos desde los ajustes del sistema (y, en su caso,
  de los textos o archivos de copia que hayas guardado). Las fotos del diario, de las muestras y de las recetas, además,
  se borran en cuanto quitas la foto, la entrada o la receta.
- **Registro de errores:** en tu móvil, hasta que lo borres con «Borrar registro de errores», borres los datos de la app
  o la desinstales. Como no pasa de unos 200 KB más un fichero anterior, las anotaciones más antiguas se van
  descartando.
- **Correos de soporte, comentarios y registros de errores que nos mandes:** el tiempo necesario para atender tu
  consulta y, como máximo, un año desde la última respuesta.

## 7. Tus derechos


Puedes ejercer tus derechos de **acceso, rectificación, supresión, oposición, limitación del tratamiento y
portabilidad** escribiendo a inklab@mainshai.com. Te responderemos en el plazo de un mes.

No recibimos los datos guardados en tu móvil, así que no podemos verlos ni borrarlos por ti. Puedes borrarlos
desinstalando la app o borrando sus datos desde los ajustes del sistema, y llevártelos con «Exportar» (Ajustes → Copia
de seguridad; las fotos no van en ese texto) o con «Compartir copia de seguridad» (que sí las incluye). Para
lo que hayas enviado a OpenRouter, ejerce tus derechos
ante OpenRouter y el proveedor del modelo; para los diagnósticos de ML Kit, ante Google.

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
