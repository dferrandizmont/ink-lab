<!-- Not legal advice; have a professional review these documents before the store launch. -->

# Legal documents

Spanish version (authoritative): [LEEME.md](LEEME.md).

| File | What it is | Status |
|---|---|---|
| `politica-privacidad.md` | Privacy policy to publish (GDPR and Spanish LOPDGDD), informal register. Mirrors [`docs/privacy.md`](../privacy.md), the technical source of truth. | No placeholders: holder, email and date are filled in. The drafting notes are at the end of this file; the policy carries no comments or internal notes. |
| `politica-privacidad.en.md` | Courtesy English translation. The Spanish one applies. | Keep in step with the Spanish one. |
| `../privacy.md` and `../privacy.en.md` | Technical inventory of data, permissions, backups, AI and exports, checked against the code. | Review whenever the data flow changes. |
| `../../PRIVACY.md` | Short pointer to the documents above. | — |
| `../../SECURITY.md` and `SECURITY.es.md` | How to report a vulnerability without sending real data. | — |
| `../../LICENSE` and `../../LICENSE-CONTENT.md` (`.es.md`) | MIT for the code; CC BY-SA 4.0 for own content; the catalogue data and third-party materials set apart. | — |

Convention: the Spanish text is the one that applies; each document has its English version in `*.en.md` next to it.

## How they are kept in sync with the website
The policy is published on the app's website, **generated from this markdown**, never hand-edited HTML:

1. The source is `docs/legal/politica-privacidad.md` (and `politica-privacidad.en.md`). The site in `web/`
   (`site.toml → privacy`) converts it as is with the shared `mainshai-web` generator (`web-app` skill) and publishes
   it at `https://inklab.mainshai.com/es/privacy/` and `https://inklab.mainshai.com/privacy/` (English).
2. That is why the policy carries no HTML comments or internal notes: they live in this file. The "Last updated" line
   is in `YYYY-MM-DD` and must match `privacy_date` in `web/content/<language>.json`; `sitegen check ink-lab` checks
   it.
3. Those URLs go in both store listings and in the app (`lib/ui/pages/settings/constants.dart`).
4. **If the data flow changes**, these are updated together and in the same commit: `docs/privacy.md`, this policy
   (and both English versions), the "Last updated" date, `privacy_date` and the store declarations. Then rebuild and
   redeploy the website.

The old GitHub Pages site (`web/legal/`) is retired once its pages redirect to the new one.

## Publication checklist
1. Review the "Drafting notes" below and, if needed, change the email retention period or the date.
2. Build, check and deploy the website from `mainshai-web` (`sitegen build/check ink-lab`, `DEPLOYMENT.md`).
3. Check that the store listing URLs match and that the policy agrees with "Data safety" (Play) and "App privacy"
   (Apple).

## Drafting notes
Not legal advice. The policy was written on 29 Oct 2026 and updated on 30 Oct 2026 against the code of that date
(`docs/privacy.md` is the technical source of truth); have a professional review it before the store launch. These
notes used to live inside the policy and moved out when it was published on `inklab.mainshai.com`, whose generator
converts the Markdown as is.

Decisions already taken in the text, in case you want to change them: holder Daniel Mont Ferrandiz and email
`inklab@mainshai.com`; emails kept "one year from the last reply"; the last-updated date (in `YYYY-MM-DD`, which the
website reads) is the drafting date; on-device AI is described as Gemini Nano on Android through ML Kit, with its
diagnostics to Google (iOS does not have it yet, see `docs/privacy.md`). The published URL goes in both store listings;
check it matches "Data safety" (Play) and "App privacy" (Apple). The English version (`politica-privacidad.en.md`) is a
courtesy translation; the Spanish one prevails.
