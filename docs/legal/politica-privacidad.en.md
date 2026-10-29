<!--
Not legal advice. Courtesy translation of the Spanish policy, written on 29 Oct 2026 against the code of that date;
have a professional review it before the store launch. The HTML generator (web/legal/md2html.py) omits this comment.
-->

# Ink Lab privacy policy

Last updated: 29 October 2026

Courtesy translation. The Spanish version ([politica-privacidad.md](politica-privacidad.md)) is the one that
applies.

Ink Lab is an app for people who draw with alcohol markers: browse colour swatches, match the colour of a photo to a
marker in your collection, and build palettes with colour theory. It is an independent app: not created, reviewed or
endorsed by Ohuhu, DecoTime or any other brand.

Summary: **you have no account, there is no server of ours and everything stays on your phone.** The app is entirely
free and open source, and includes no analytics, ads or tracking. It only sends data off the phone if **you** turn on
AI with your own OpenRouter key, and then it sends exactly what is explained below.

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
It is **off by default**. With it off, the app opens no network connection. If you turn it on, the app first shows you
what would leave the phone, and you can choose between:

- **Colour theory (local engine):** no AI and no network.
- **On the device (Gemini Nano, on compatible Android phones):** your scenario and the colour codes are processed on
  your phone and Ink Lab sends them nowhere. If the model is not on the phone, Android downloads it once through
  Google services; that download and the model are governed by Google's terms.
- **OpenRouter with your key:** when you tap "Suggest with AI", the app sends, **from your phone straight to
  `openrouter.ai`, over HTTPS and with your own key and your own account**: the brand and the scenario or mode you
  chose, the code, name and hex colour of the base marker, the codes, names and hex colours of the candidate markers
  from your collection, the palette size and the generation settings (model, temperature and length limit). To show
  you the available models, the app queries the OpenRouter catalogue (with your key, if you saved one). Photos, your
  favourites, your saved palettes and identifiers of yours are **never** sent. OpenRouter and the model provider you
  choose receive that request and apply **their own** terms and privacy policies, which you can read at
  https://openrouter.ai/privacy. The developer does not see it, it does not pass through any server of the developer and it is
  not stored.

Your OpenRouter key is stored in the system's secure storage (Android Keystore or iOS Keychain, on this device only).
It is not uploaded to the developer, it is not included in backups, and you can delete it in Settings at any time. If
the AI fails, the app goes back to colour theory.

### Permissions
The app asks for the **camera or photos** permission only when you use "Match" or "Scene from a photo", and declares **network** access only
for the optional AI with OpenRouter. It does not ask for location, contacts, calendar, microphone or notifications, and
it does not use the advertising identifier.

### Data that is NOT processed
- We do not ask for or keep your name, email, phone, age or any account data: there are no accounts.
- There is no analytics, no ads, no personalised advertising, no cross-app tracking and no crash reports.
- We do not receive your photos, your collections, your palettes or your key.

### If you write to us
You can write to dev@mainshai.com. We will process your email address and what you tell us only to reply to you. Do not
send your API key or backups containing data you do not want to share: test data is enough to fix a bug.

## 3. Purposes and legal basis

| Processing | Purpose | Legal basis (GDPR) |
|---|---|---|
| Collections, favourites, palettes and settings on your phone | So that you can use the app and keep your work | We do not receive them: they stay on your device, under your control |
| "Match" or "Scene from a photo" photo | Finding the closest markers | Processed only on your phone, at your request; we do not receive it |
| AI with OpenRouter (optional) | Generating palette suggestions | Your consent when you turn it on and use your own key; OpenRouter performs the processing under its own terms |
| Support emails | Replying to your query | Your request and our legitimate interest in handling it (art. 6.1.f) |

We make no automated decisions and build no profiles about you.

## 4. Who receives the data
The app does not transmit data to the developer or to third parties on its own. If you turn on AI with OpenRouter, the
request described above is received by OpenRouter and the model provider you choose, on your behalf and with your key.
If you send a support email, the holder receives it at dev@mainshai.com through the email service you choose.

## 5. International transfers
The developer makes no data transfers. If you use AI with OpenRouter, the request goes to the provider you choose,
which may process it in other regions and under its own terms. Any other service you decide to use (email, cloud, the
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
anything sent to OpenRouter, exercise your rights with OpenRouter and the model provider.

If you believe we have not handled your data properly, you can complain to the Spanish Data Protection Agency:
https://www.aepd.es

## 8. Children

The app is not directed at children under 13 (or the equivalent minimum age in your country). It does not ask for age
or collect personal data from anyone, including children: there are no accounts and everything stays on the device.
AI with OpenRouter requires your own account with a third party, which minors should not create without the permission
of a parent or guardian.

## 9. Security
There is no developer server and no data transmission from the app, except the optional AI. Your data is in the app's
private space; your key, in the Keystore or the Keychain; connections to OpenRouter use HTTPS and follow no redirects.
Protecting your phone (screen lock, encryption, no root or jailbreak) is up to you. The code is public and anyone can
check what it does.

## 10. Changes to this policy

If what the app does with data changes, we will update this page and the date above. If the change is important (for
example, if a feature were to send data off the phone), we will also tell you inside the app and it would only be
turned on with your consent.

## 11. Contact

dev@mainshai.com
