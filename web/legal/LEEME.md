# Web antigua de GitHub Pages (retirada)

La web de Ink Lab y su política de privacidad están en **https://inklab.mainshai.com**, generadas desde `web/`
(`site.toml`, `content/`, `templates/`, `assets/`) con el generador común de `mainshai-web` (skill `web-app`). La
política se convierte tal cual desde `docs/legal/politica-privacidad.md` y `.en.md` (`docs/legal/LEEME.md`).

Hasta el 30-oct-2026 la política se publicaba en `https://dferrandizmont.github.io/ink-lab/`, desde la rama `gh-pages`
del repositorio público. Para no romper los enlaces antiguos (fichas de tienda, versiones de la app hasta la 0.6.2),
esa rama solo sirve ahora estas redirecciones:

| Página antigua | Redirige a |
|---|---|
| `/ink-lab/` | `https://inklab.mainshai.com/` |
| `/ink-lab/privacidad/` | `https://inklab.mainshai.com/es/privacy/` |
| `/ink-lab/privacidad/en/` | `https://inklab.mainshai.com/privacy/` |

GitHub Pages no admite redirecciones 301: cada página lleva `meta refresh` a 0 segundos, `rel=canonical` y el enlace
visible. `python -B web/legal/test_legal.py` (en la CI) comprueba que solo hay estas páginas, `robots.txt` y
`.nojekyll`.

Si alguna vez hay que tocarlas, se cambian aquí y se copia el mismo contenido (sin `LEEME.md`, `test_legal.py` ni
`.gitignore`) a la raíz de `gh-pages`, con la identidad pública `Daniel Mont Ferrandiz <dev@mainshai.com>`. Cuando ya
nada enlace a las URL antiguas, se puede desactivar GitHub Pages y borrar la rama.
