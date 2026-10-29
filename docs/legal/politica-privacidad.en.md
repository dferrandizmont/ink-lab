<!--
Not legal advice. Courtesy translation of the Spanish policy, written on 29 Oct 2026 and updated on 30 Oct 2026 against the code of that date;
have a professional review it before the store launch. The HTML generator (web/legal/md2html.py) omits this comment.
-->

# Ink Lab privacy policy

Last updated: 30 October 2026

Courtesy translation. The Spanish version ([politica-privacidad.md](politica-privacidad.md)) is the one that
applies.

Ink Lab is an app for people who draw with alcohol markers: browse colour swatches, match the colour of a photo to a
marker in your collection, and build palettes with colour theory. It is an independent app: not created, reviewed or
endorsed by Ohuhu, DecoTime or any other brand.

Summary: **you have no account, there is no server of ours and your data stays on your phone.** The app is entirely
free and open source, and includes no analytics of ours, ads or tracking. **If you do not turn on AI, the app does not
use the network.** If you turn it on, on Android the on-device AI uses Google's ML Kit, which sends Google diagnostics
and usage data (never your prompts, your colours or your photos); and if you choose OpenRouter with your own key, it
sends exactly what is explained below.

## 1. Controller

- Holder: Daniel Mont Ferrandiz
- Contact email: dev@mainshai.com

## 2. What data is processed

### Data that stays on your phone (we do not receive it)
Your active brand, the packs and markers you own, your favourites, your saved palettes, the history of your latest
colour matches and your settings are stored only in the app's private storage, on your device. The marker catalogues
ship inside the app and everything works offline. There is no synchronisation or copy on any server of ours.

Android's system backup is **switched off** for this app, so neither your settings nor your key leave the phone that
way. On iPhone, the preferences are part of the device backup that you manage with your Apple account.

### Camera and gallery
Only when you use "Match" or "Scene from a photo" (in Palette) and choose to take a photo or pick one from the gallery,
the app asks for the permission or opens the system picker. The photo is decoded and analysed **on your phone**: it is
not uploaded anywhere, it is not stored and it is never sent to an AI provider. In "Match", only the sampled colour and
the matched marker are kept, in your local history. In "Scene from a photo", its main colours are found to suggest
markers from your collection; the photo is only kept in memory while you look at the result, and if you save the
palette, the marker codes are saved, never the photo.

### Backup
"Export backup" (Settings) produces a JSON text with your collections, favourites, palettes and history, and **copies
it to the clipboard** for you to paste wherever you like; "Import backup" receives it by pasting. It is not encrypted,
carries no identifier and never includes your API key. What you do with it afterwards (saving it in your cloud,
sending it in a message...) is outside the app. Note that, depending on your system, the clipboard may be visible to
your keyboard or to other apps.

### Optional AI
It is **off by default** (Settings → AI assistant → Suggest with AI). With it off, the app opens no network connection
and does not call ML Kit. If you turn it on, the app first shows you what would leave the phone, and you can choose
between:

- **Colour theory (local engine):** no AI and no network.
- **On the device (Gemini Nano, on compatible Android phones, through Google's ML Kit):** your scenario and the colour
  codes are processed on your phone and sent nowhere. When you turn AI on, the app uses ML Kit to check whether Gemini
  Nano is available and, if you choose this option, to download it and generate the suggestions. When it is used,
  **ML Kit sends Google**, over HTTPS and in batches (roughly once a day), diagnostics and usage data: device
  information (manufacturer, model, system version and build), app information (package name and version), device or
  other identifiers, including per-installation identifiers, performance metrics, the API configuration, the input and
  output size, the feature version, the event type, error codes and the configured languages. Google says it uses them
  for diagnostics and usage analytics and does not transfer them to third parties
  (https://developers.google.com/ml-kit/android-data-disclosure). That data does not include the content of your
  prompts, your colours or your photos, only their size. The developer does not receive it: Google processes it under
  its own terms and privacy policy (https://policies.google.com/privacy). If the model is not on the phone, Android
  downloads it once through Google services; that download and the model are governed by Google's terms. On iPhone
  there is no on-device AI and no ML Kit.
- **OpenRouter with your key:** only if you choose OpenRouter, save your key and tap "Suggest with AI" in Palette, the
  app sends, **from your phone straight to `openrouter.ai`, over HTTPS and with your own key and your own account**:
  the brand (id and name), the palette mode, the scene name (in English), the code and name of the base marker (if
  any) and whether it is locked, the palette size, the codes and hex colours of the candidate markers from your
  collection (not their names), the generation settings (model, temperature and length limit), fixed instructions from
  the app and an `X-Title: Ink Lab` header. To show you the available models, the app queries the OpenRouter catalogue
  (with your key, if you saved one). Photos (the request states that no image is attached and the app has no way to
  attach one), your favourites, your saved palettes and identifiers of yours are **never** sent. As with any internet
  connection, OpenRouter and the model provider see your device's IP address. They receive that request and apply
  **their own** terms and privacy policies, including how long they keep it, which you can read at
  https://openrouter.ai/privacy. The developer does not see it, it does not pass through any server of the developer
  and the app does not store it.

Your OpenRouter key is stored in the system's secure storage (Android Keystore or iOS Keychain, on this device only).
It is not uploaded to the developer, it is not included in backups, and you can delete it in Settings at any time. If
the AI fails, the app goes back to colour theory.

### Permissions
The app asks for the **camera or photos** permission only when you use "Match" or "Scene from a photo". On Android it
declares **internet** and **network state** access (`INTERNET` and `ACCESS_NETWORK_STATE`), which are only used with AI
turned on: for the optional AI with OpenRouter and for the diagnostics ML Kit sends Google when the on-device AI is
used. It does not ask for location, contacts, calendar, microphone or notifications, and it does not use the
advertising identifier.

### Data that is NOT processed
- We do not ask for or keep your name, email, phone, age or any account data: there are no accounts.
- The developer uses no analytics and no crash reports, and there are no ads, no personalised advertising and no
  cross-app tracking. The only exception is the diagnostics and usage data ML Kit sends Google when you use the
  on-device AI (see "Optional AI"); the developer does not receive it.
- We do not receive your photos, your collections, your palettes or your key.

### If you write to us
You can write to dev@mainshai.com. We will process your email address and what you tell us only to reply to you. Do not
send your API key or backups containing data you do not want to share: test data is enough to fix a bug.

## 3. Purposes and legal basis

| Processing | Purpose | Legal basis (GDPR) |
|---|---|---|
| Collections, favourites, palettes and settings on your phone | So that you can use the app and keep your work | We do not receive them: they stay on your device, under your control |
| "Match" or "Scene from a photo" photo | Finding the closest markers | Processed only on your phone, at your request; we do not receive it |
| ML Kit diagnostics (only with the on-device AI, on Android) | Diagnostics and usage analytics of the SDK, according to Google | Sent only if you choose to turn on the optional AI; Google processes them as the provider of ML Kit, under its own terms and privacy policy; we do not receive them |
| AI with OpenRouter (optional) | Generating palette suggestions | Your consent when you turn it on and use your own key; OpenRouter performs the processing under its own terms |
| Support emails | Replying to your query | Your request and our legitimate interest in handling it (art. 6.1.f) |

We make no automated decisions and build no profiles about you.

## 4. Who receives the data
The app does not transmit data to the developer. If you turn on AI, on Android **Google** receives the diagnostics and
usage data ML Kit sends when the on-device AI is used. If you use AI with OpenRouter, the request described above is
received by **OpenRouter** and the **model provider** you choose, on your behalf and with your key.
If you send a support email, the holder receives it at dev@mainshai.com through the email service you choose.

## 5. International transfers
The developer makes no data transfers. If you use AI with OpenRouter, the request goes to the provider you choose,
which may process it in other regions and under its own terms. Google may process the ML Kit diagnostics in other
countries, under its own terms. Any other service you decide to use (email, cloud, the
destination of copied text) is governed by its own terms.

## 6. How long it is kept

- **Data on your phone:** until you uninstall the app or clear its data from the system settings (and, where
  applicable, from the backup texts you saved).
- **Support emails:** as long as needed to handle your query and, at most, one year after the last reply.

## 7. Your rights

You can exercise your rights of **access, rectification, erasure, objection, restriction of processing and
portability** by writing to dev@mainshai.com. We will reply within one month.

We do not receive the data stored on your phone, so we cannot see or delete it for you. You can delete it by
uninstalling the app or clearing its data from the system settings, and take it with you with "Export backup". For
anything sent to OpenRouter, exercise your rights with OpenRouter and the model provider; for the ML Kit diagnostics,
with Google.

If you believe we have not handled your data properly, you can complain to the Spanish Data Protection Agency:
https://www.aepd.es

## 8. Children

The app is not directed at children under 13 (or the equivalent minimum age in your country). It does not ask for age
or collect personal data from anyone, including children: there are no accounts and your data stays on the device.
AI with OpenRouter requires your own account with a third party, which minors should not create without the permission
of a parent or guardian.

## 9. Security
There is no developer server and no data transmission from the app, except with the optional AI turned on. Your data is in the app's
private space; your key, in the Keystore or the Keychain; connections to OpenRouter use HTTPS and follow no redirects.
Protecting your phone (screen lock, encryption, no root or jailbreak) is up to you. The code is public and anyone can
check what it does.

## 10. Changes to this policy

If what the app does with data changes, we will update this page and the date above. If the change is important (for
example, if a feature were to send data off the phone), we will also tell you inside the app and it would only be
turned on with your consent.

## 11. Contact

dev@mainshai.com
