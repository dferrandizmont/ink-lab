<!-- Not legal advice; have a professional review these documents before the store launch. -->

# Legal documents

Spanish version (authoritative): [LEEME.md](LEEME.md).

| File | What it is | Status |
|---|---|---|
| `politica-privacidad.md` | Privacy policy to publish (GDPR and Spanish LOPDGDD), informal register. Mirrors [`docs/privacy.md`](../privacy.md), the technical source of truth. | No placeholders: holder, email and date are filled in. The drafting notes are at the end of this file; the policy carries no comments or internal notes. |
| `politica-privacidad.en.md` | Courtesy English translation. The Spanish one applies. | Keep in step with the Spanish one. |
| `politica-privacidad.de.md`, `.fr.md`, `.pt.md`, `.it.md` | Courtesy German, French, Portuguese and Italian translations (de, fr and pt in formal address; it informal). The Spanish one applies. Each quotes the UI labels in its own language (`lib/l10n/app_<language>.arb`). | Keep in step with the Spanish one; same "Last updated" date in all six. |
| `../privacy.md` and `../privacy.en.md` | Technical inventory of data, permissions, backups, AI and exports, checked against the code. | Review whenever the data flow changes. |
| `../../PRIVACY.md` | Short pointer to the documents above. | — |
| `../../SECURITY.md` and `SECURITY.es.md` | How to report a vulnerability without sending real data. | — |
| `../../LICENSE` and `../../LICENSE-CONTENT.md` (`.es.md`) | MIT for the code; CC BY-SA 4.0 for own content; the catalogue data and third-party materials set apart. | — |

Convention: the Spanish text is the one that applies; each document has its English version in `*.en.md` next to it,
and the policy also in `*.de.md`, `*.fr.md`, `*.pt.md` and `*.it.md`.

| Policy | Language | Address | Last updated |
|---|---|---|---|
| `politica-privacidad.md` | Spanish (original) | Informal | 2026-11-20 |
| `politica-privacidad.en.md` | English | — | 2026-11-20 |
| `politica-privacidad.de.md` | German | Formal (Sie) | 2026-11-20 |
| `politica-privacidad.fr.md` | French | Formal (vous) | 2026-11-20 |
| `politica-privacidad.pt.md` | Portuguese | Formal (você) | 2026-11-20 |
| `politica-privacidad.it.md` | Italian | Informal | 2026-11-20 |

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
   (and its five translations), the "Last updated" date, `privacy_date` and the store declarations. Then rebuild and
   redeploy the website.

The old GitHub Pages site (`web/legal/`) is retired once its pages redirect to the new one.

## Publication checklist
1. Review the "Drafting notes" below and, if needed, change the email retention period or the date.
2. Build, check and deploy the website from `mainshai-web` (`sitegen build/check ink-lab`, `DEPLOYMENT.md`).
3. Check that the store listing URLs match and that the policy agrees with "Data safety" (Play) and "App privacy"
   (Apple).

## Drafting notes
Not legal advice. The policy was written on 29 Oct 2026 and updated on 30 Oct 2026 and 31 Oct 2026 (artwork diary with
photos, clipboard backup and exclusion from Android backups, version 0.7) against the code of that date
(`docs/privacy.md` is the technical source of truth); have a professional review it before the store launch. These
notes used to live inside the policy and moved out when it was published on `inklab.mainshai.com`, whose generator
converts the Markdown as is.

Decisions already taken in the text, in case you want to change them: holder Daniel Mont Ferrandiz and email
`inklab@mainshai.com`; emails kept in Gmail and Proton "at most one year from the last message in the conversation", with a clean-up every three months; since 20 Nov 2026 replies go out through Resend, with no open or click tracking, which, according to its documentation, keeps each reply and its sending log for 30 days and its backups for seven days (Brevo, the intended service before that, only ever sent the holder's test emails); the last-updated date (in `YYYY-MM-DD`, which the
website reads) is the drafting date; on-device AI is described as Gemini Nano on Android through ML Kit, with its
diagnostics to Google (iOS does not have it yet, see `docs/privacy.md`). The published URL goes in both store listings;
check it matches "Data safety" (Play) and "App privacy" (Apple). The English, German, French, Portuguese and Italian
versions are courtesy translations; the Spanish one prevails.

### Replies through Resend (2026-11-20)
**Daniel's decision (20 Nov 2026):** no more tracking on support replies in any of his apps. On its free plan Brevo
added a pixel and rewrote the links, which requires prior consent that was not being asked for (ePrivacy, Art. 5(3);
Spanish LSSI, Art. 22.2). **Resend** is chosen (free, tracking off, SMTP).

**Flow since 20 Nov 2026:** Cloudflare Email Routing receives and forwards to the Gmail mailbox, with a copy to Proton
(unchanged); Gmail "Send mail as" for inklab@mainshai.com sends through `smtp.resend.com`. Tested that day: links not
rewritten, no pixel, no unsubscribe footer; Resend records no opens. Domain `mainshai.com` in the Ireland region
(eu-west-1), with open and click tracking turned off.

**Facts about Resend (checked on 20 Nov 2026):**
- Entity: Plus Five Five, Inc. (USA). It stores the data in the USA (the content of each reply and the sending log) even
  though the emails are sent from Ireland: 30 days on the free plan; backups are kept for seven days
  (https://resend.com/security/gdpr.md, https://resend.com/pricing). "Backups persist for 7 days" says how long backups
  last, not that each email leaves them seven days after the 30: that is why the policy does not say "7 more days".
- Art. 28 DPA for every account and plan (https://resend.com/legal/dpa). Transfer: DPF (Resend on
  https://www.dataprivacyframework.gov/list, with the status "Active - Re-certification under Review" on 20 Nov 2026)
  and the Commission's SCCs, module 2, included in the DPA. If Resend left that list, remove the DPF sentence from the
  policy (in all six languages) and rely on the SCCs.
- A specific email can only be deleted sooner by asking Resend's support team with the identifiers from the dashboard
  (Emails); there is no button or API. Sub-processors: AWS and others, in the USA
  (https://resend.com/legal/subprocessors).

**Brevo:** not used since 20 Nov 2026. The whole Brevo account holds only the holder's test emails (confirmed by Daniel
on 20 Nov 2026): no one was ever replied to through Brevo from inklab@mainshai.com. Brevo keeps the log of those tests
under its twelve-month rule (up to one more day). The policy does not say "no copy", because there may be previews of
tests sent before that rule. Brevo holds no data about users, so it is left out of erasure and of the retention
section 6.

**What changed in the policy (six languages; first draft, corrected in round 1):** "Data that is NOT processed", without Brevo's tracking; in "If you
write to us", a Resend item (sending from Ireland, data in the USA, copy and log for 30 days, backups 7 more, tracking
off, sub-processors such as AWS), a "Brevo, until 20 November 2026" paragraph and "How long we keep it" with Resend,
what remains at Brevo and erasure (Gmail, Proton, a request to Resend's support team and Brevo's logs); removed "If we
stop using one of those services, we delete what is in it", which would not be true until Brevo deletes; in section 4,
a Resend row, a Brevo row in the past and the sentence on Resend's DPA; in section 5, DPF + SCC Module 2 for Resend; in
section 6, Resend and Brevo's old logs. Date: 2026-11-20 (unchanged, like `privacy_date`).

**Pending for Daniel:** ask Brevo in writing to delete the history, remove its DNS records and close the account (note
here what was asked, what it confirmed and when). Once Brevo confirms the deletion, change the Brevo paragraph (and the
rows in sections 4 and 6) to say nothing remains, in all six languages.

**Review round 1 (20 Nov 2026; Astra high FIX, Fable high PASS, on the Gift Huddle model):** wording of Resend's backup
period ("it keeps backups for seven days", not "7 more days"); Brevo described as the intended service, which only sent
the holder's test emails, and left out of erasure and of section 6; legal bases for data protection rights requests
(art. 6.1.c) and for keeping a conversation for a legal claim (art. 6.1.f), in "If you write to us" and in section 3;
"each at the step shown in the table" in section 4; link to the DPA and "you can also ask us for information" in
section 5; link to Resend's list of sub-processors.

**Review round 2 (20 Nov 2026; Astra high FIX, Fable high PASS):** erasure of support email follows Art. 17(3)(e)
("Where the right to erasure applies…" and "If we need to keep any data, we will explain what we keep and why"), with
Resend deleting replies and sending logs; the Summary describes the email route (Cloudflare, Gmail, Proton, Resend with
no tracking); language fixes in de, fr, it and pt; exact DPF status in these notes. The text on Cloudflare's log
(period not confirmed) does not change: it is still pending.

**dev@mainshai.com (open question):** the policy used to say that the whole flow "also applies" to dev@mainshai.com,
the address of versions up to 0.6.2. It is only verified that support replies are sent through Resend from
inklab@mainshai.com; whether dev@mainshai.com has "Send mail as" through Resend has not been checked. So the policy now
says that Cloudflare, Google and Proton take part in the same way for whatever reaches dev@mainshai.com and that
replies go out from inklab@mainshai.com. If a reply is ever sent from dev@mainshai.com, first check that it goes
through `smtp.resend.com` with no tracking.

**Rights over support email (how to handle them):**
- Proportionate verification: if the request only concerns email, it is enough that it comes from the same address or
  in the same thread, without asking for documents unless needed.
- Erasure: the Art. 17(3)(e) criterion applies. Before deleting, check whether any data must be kept and document the
  reason; if something is kept, tell the person what and why.
- Access: a faithful and intelligible copy of the data kept (Art. 15(3)), with the context needed to understand it and
  protecting third parties' data; an extract may be prepared without duplicating what is identical in Gmail and
  Proton. It includes Cloudflare's forwarding log if it holds data about the person (if the dashboard does not show it,
  ask Cloudflare). There is nothing to hand over from Brevo.
- Resend: find the replies from the last 30 days in the dashboard (Emails) by recipient and check on each email that
  the sender is inklab@mainshai.com, because the account also sends for other apps. To delete, ask Resend's support
  team (https://resend.com/support) from the account's address, with the identifiers: there is no button or API. If an
  email is unclear, clear it up with Resend before handing anything over or deleting.
- The final email saying what was deleted also goes through Resend and leaves a new copy there (30 days) and in Gmail's
  Sent folder: say so in that email; it is deleted at the next clean-up.
- The first time something is delivered with an attachment, check in the dashboard whether Resend keeps the attachment
  and note it here.
- Quarterly clean-up: besides Gmail and Proton, check in Resend (Domains) that `mainshai.com` still has open and click
  tracking turned off; in Gmail, that "Send mail as" still uses `smtp.resend.com`; that Resend is still on
  https://www.dataprivacyframework.gov/list ("Active - Re-certification under Review" on 20 Nov 2026); that https://resend.com/security/gdpr.md still says 30 days and seven-day
  backups (if anything changes, review the policy); and the Brevo item still pending, checking meanwhile that nothing new
  goes out from inklab@mainshai.com through Brevo.
