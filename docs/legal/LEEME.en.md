<!-- Not legal advice; have a professional review these documents before the store launch. -->

# Legal documents

Spanish version (authoritative): [LEEME.md](LEEME.md).

| File | What it is | Status |
|---|---|---|
| `politica-privacidad.md` | Privacy policy to publish (GDPR and Spanish LOPDGDD), informal register. Mirrors [`docs/privacy.md`](../privacy.md), the technical source of truth. | No placeholders: holder, email and date are filled in. Review the "Notas para el titular" at the end, which the HTML generator **omits**. |
| `politica-privacidad.en.md` | Courtesy English translation. The Spanish one applies. | Keep in step with the Spanish one. |
| `../privacy.md` and `../privacy.en.md` | Technical inventory of data, permissions, backups, AI and exports, checked against the code. | Review whenever the data flow changes. |
| `../../PRIVACY.md` | Short pointer to the documents above. | — |
| `../../SECURITY.md` and `SECURITY.en.md` | How to report a vulnerability without sending real data. | — |
| `../../LICENSE` and `../../LICENSE-CONTENT.md` (`.en.md`) | MIT for the code; CC BY-SA 4.0 for own content; the catalogue data and third-party materials set apart. | — |

Convention: the Spanish text is the one that applies; each document has its English version in `*.en.md` next to it.

## How they are kept in sync with the website
The policy is published as a static page generated **from this markdown**, never hand-edited HTML, with the same
scheme as Cuadrante and Ley al Blanco (`web/legal/`):

1. The source is `docs/legal/politica-privacidad.md`. The generator (`web/legal/md2html.py`) turns the markdown into
   `web/legal/privacidad/index.html` and **omits** HTML comments and the "Notas para el titular" section. The English
   version is generated the same way from `politica-privacidad.en.md` into `web/legal/privacidad/en/index.html`.
2. A test (`web/legal/test_legal.py`) compares the generated HTML with the markdown and fails if they differ, so nobody
   hand-edits the HTML or forgets to regenerate. CI runs it.
3. The page is published on GitHub Pages of the public repository
   (`https://dferrandizmont.github.io/ink-lab/privacidad/`, to be confirmed once the repository exists).
4. That same URL goes in both store listings.
5. **If the data flow changes**, these are updated together and in the same commit: `docs/privacy.md`, this policy (and
   both English versions), the "Last updated" date and the store declarations. Then regenerate the HTML and publish
   again.

## Publication checklist
1. Review the "Notas para el titular" and, if needed, change the email retention period or the date.
2. Generate the HTML (`python -B web/legal/md2html.py`), pass the test and publish `web/legal/dist/`
   (`web/legal/LEEME.md`).
3. Put the URL in both store listings and check that it matches "Data safety" (Play) and "App privacy" (Apple).
