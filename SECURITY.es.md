# Avisos de seguridad
[English](SECURITY.md) · Español

Si encuentras una vulnerabilidad, escribe a **inklab@mainshai.com** o abre un
[aviso privado de seguridad](https://github.com/dferrandizmont/ink-lab/security/advisories/new)
en GitHub.

Incluye la versión afectada (Ajustes), la plataforma, los pasos para reproducir
el problema y su posible impacto. Comunica los detalles por ese canal antes de
abrir una incidencia pública, para permitir que se revise y prepare una
corrección. Solo recibe correcciones la última versión publicada.

## Qué se considera vulnerabilidad

- Una forma de que la app envíe datos a un destino que el usuario no activó.
- Una forma de leer o extraer datos locales, copias de seguridad o la clave de
  API de otra persona.
- Una forma de ejecutar código a través de una entrada controlada por un
  atacante, por ejemplo una copia de seguridad manipulada o la respuesta de un
  proveedor de IA.
- Un almacenamiento local inseguro de credenciales o datos personales.

No lo son los cierres inesperados sin impacto de seguridad, los colores que
difieren de la web del fabricante (eso es una
[corrección de datos](https://github.com/dferrandizmont/ink-lab/issues/new)), lo que exige acceso
físico a un móvil desbloqueado ni los hallazgos de escáneres sin impacto
demostrado.

## No adjuntes datos reales

- No mandes tu clave de OpenRouter ni ninguna otra clave, keystore o archivo
  `.env`. Si la has pegado por error, revócala y crea otra.
- Reproduce el problema con datos de prueba. Si necesitas mandar una copia de
  seguridad real, quita antes lo que te identifique.
- En las capturas, tapa lo que no sea de prueba.

Lo mismo vale para las incidencias y las solicitudes de cambio públicas.

English version: [SECURITY.md](SECURITY.md).
