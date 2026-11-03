# Ink Lab privacy policy


Last updated: 2026-11-03

Courtesy translation. The [Spanish version](https://inklab.mainshai.com/es/privacy/) is the one that
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
- Contact email: inklab@mainshai.com

## 2. What data is processed


### Data that stays on your phone (we do not receive it)
Your active brand, the packs and markers you own, your favourites, your wishlist, the markers you mark as dried out,
the own colours you store for your markers, your saved palettes, the history of your latest colour matches, the
entries and photos of your diary, your favourite and recently viewed ideas and your settings are stored only in the
app's private storage, on your device. For each own colour only its hex code is stored, never the photo you took it
from. The marker catalogues ship inside the app and everything works offline; "In other brands" (in a marker's
detail), the "Colour vision" preview (in Palette) and the "Diary numbers" are computed on your phone from those
catalogues and your data, sending nothing. There is no synchronisation or copy on any server of ours.

Android's system backup is **switched off** for this app: it excludes all of the app's files from cloud backup and
from device-to-device transfer, so neither your settings, nor your key, nor your data, nor the diary photos leave the
phone that way. On iPhone, the preferences and the diary photos may be part of the device or iCloud backup that you
manage with your Apple account: that is Apple's mechanism, under your control, not a transfer by the developer.

### Camera and gallery
Only when you use "Match", "From a photo" (in Palette) or "My colour" (in a marker's detail), or add a photo to a
"Diary" entry (in Ideas), and choose to take a photo or pick one from the gallery, the app asks for the permission or
opens the system picker. The photo is decoded and analysed **on your phone**: it is not uploaded anywhere and it is
never sent to an AI provider; except in the diary (see below), it is not stored either. In "Match", only the sampled
colour and the matched marker are kept, in your local history. In "From a photo", its main colours are found to
suggest markers from your collection; the photo is only kept in memory while you look at the result, and if you save
the palette, the marker codes are saved, never the photo. In "My colour", you tap the painted swatch in the photo and
only its colour is saved, as a hex code, never the photo.

### Diary
In the Ideas tab, "Diary" lets you log the artworks you paint: title, date, what it was painted on, status, markers
used, linked palette and notes. The entries are stored on your phone like the rest of your data. Each entry can hold up
to 4 photos, taken with the camera or picked from the gallery, which the app copies, shrunk to at most 2048 pixels on
a side, into its private folder; the original photo in your gallery is not changed. Those photos are not uploaded
anywhere and are not sent to the AI features (not to OpenRouter, Gemini Nano or ML Kit), and they are deleted when you
remove the photo or the entry, and with the app when you uninstall it. "Share this entry" draws, only when you tap it,
an image with the title, the date, the status, the first photo, the markers used and the colours of the linked
palette, and hands it only to the app you pick in the system share sheet.

### Backup
"Export" (Settings → Backup) produces a JSON text, not a file, with your settings, the non-secret AI settings, your
collection, favourites, wishlist, dried-out markers, own colours, palettes, history, favourite and recently viewed
ideas and the diary entries (with the internal file names of their photos, not the photos), and **copies it to the
clipboard** for you to paste wherever you like; "Import" receives it by pasting. Importing replaces your current data,
the diary included: entries that are not in the backup are deleted along with their photos, and the app warns you
before. The backup is not encrypted, carries no identifier and never includes your API key or the diary photos. What
you do with it afterwards (saving it in your cloud, sending it in a message...) is outside the app. Note that,
depending on your system, the clipboard may be visible to your keyboard or to other apps.

"Save backup file" (Settings → Your data → Backup file) makes a ZIP file with that same backup and, in addition, the
diary photos, writes it to the app's temporary (cache) folder and opens the system share sheet for you to save it to
Files, Drive or the app you choose: it only goes where you send it, and the app deletes the earlier backup files in
that folder when it makes the next one. "Restore from file" opens the system document picker, which needs no
permission (the picker leaves a copy of the chosen file in the app's cache, and the app deletes it when it is done);
the file is checked whole before anything is written and the app asks you to confirm, because it replaces your
current data, photos included, and deletes the diary photos that are not in the file. No backup, neither the clipboard
one nor the file, includes your API key.

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
- **On the iPhone (Apple Intelligence, on iOS 26 or later and a compatible iPhone):** your scenario and colour codes are
  processed on your phone by Apple's model that comes with Apple Intelligence, through Apple's Foundation Models
  framework. The app does not download the model (iOS installs and manages it), uses no other service for this option
  and sends nothing: not your requests, your colours or your photos.
- **OpenRouter with your key:** only if you choose OpenRouter, save your key and tap "Suggest with AI" in Palette, the
  app sends, **from your phone straight to `openrouter.ai`, over HTTPS and with your own key and your own account**: the
  brand (id and name), the palette mode, the scene name (in English), the code and name of the base marker (if any) and
  whether it is locked, the palette size, the codes and catalogue hex colours of the candidate markers from your
  collection (not their names), the generation settings (model, temperature and length limit), fixed instructions from
  the app and an `X-Title: Ink Lab` header. To show you the available models, the app queries the OpenRouter catalogue
  (with your key, if you saved one). Photos (the request states that no image is attached and the app has no way to
  attach one), your own colours, your favourites, your saved palettes and identifiers of yours are **never** sent. As
  with any internet connection, OpenRouter and the model provider see your device's IP address. They receive that
  request and apply **their own** terms and privacy policies, including how long they keep it, which you can read at
  https://openrouter.ai/privacy. The developer does not see it, it does not pass through any server of the developer and
  the app does not store it.

Your OpenRouter key is stored in the system's secure storage (Android Keystore or iOS Keychain, on this device only).
It is not uploaded to the developer, it is not included in backups, and you can delete it in Settings at any time. If
the AI fails, the app goes back to colour theory.

### Permissions
The app asks for the **camera or photos** permission only when you use "Match", "From a photo" or "My colour", or add
a photo to the "Diary". On Android it declares **internet** and **network state** access (`INTERNET` and
`ACCESS_NETWORK_STATE`), which are only used with AI turned on: for the optional AI with OpenRouter and for the
diagnostics ML Kit sends Google when the on-device AI is used. It does not ask for location, contacts, calendar,
microphone or notifications, and it does not use the advertising identifier. If you share a palette, a swatch chart or
a diary entry as an image, or a backup file, it is only handed to the app you pick in the system share sheet; the app
needs no permission for it, nor to pick a backup file with the system picker.

### Data that is NOT processed
- We do not ask for or keep your name, email, phone, age or any account data: there are no accounts.
- The developer uses no analytics and no crash reports, and there are no ads, no personalised advertising and no
  cross-app tracking. The only exception is the diagnostics and usage data ML Kit sends Google when you use the
  on-device AI (see "Optional AI"); the developer does not receive it.
- We do not receive your photos, your collections, your palettes or your key.

### If you write to us
You can write to inklab@mainshai.com. We will process your email address and what you tell us only to reply to you. Do not
send your API key or backups containing data you do not want to share: test data is enough to fix a bug.

If you report an AI suggestion ("Report this suggestion", in Palette), the app opens your email app with a message
already written to inklab@mainshai.com: the reason you choose, the app version, the AI provider and model, the brand, the
mode or scene, the base marker's code and that suggestion's codes, roles and reasons. It never includes your API key or photos. It only
reaches us if you send it, and we use it to review the reported content and improve the suggestions. If there is no
email app, the report is copied to the clipboard for you to paste.

## 3. Purposes and legal basis


| Processing | Purpose | Legal basis (GDPR) |
|---|---|---|
| Collections, wishlist, own colours, favourites, palettes, diary and settings on your phone | So that you can use the app and keep your work | We do not receive them: they stay on your device, under your control |
| "Match", "From a photo", "My colour" or "Diary" photo | Finding the closest markers, reading the colour of your swatch or keeping the photo of an artwork in your diary | Processed (and, in the diary, stored) only on your phone, at your request; we do not receive it |
| ML Kit diagnostics (only with the on-device AI, on Android) | Diagnostics and usage analytics of the SDK, according to Google | Sent only if you choose to turn on the optional AI; Google processes them as the provider of ML Kit, under its own terms and privacy policy; we do not receive them |
| AI with OpenRouter (optional) | Generating palette suggestions | Your consent when you turn it on and use your own key; OpenRouter performs the processing under its own terms |
| Support emails and AI suggestion reports | Replying to your query and reviewing the reported content | Your request and our legitimate interest in handling it (art. 6.1.f) |

We make no automated decisions and build no profiles about you.

## 4. Who receives the data
The app does not transmit data to the developer. If you turn on AI, on Android **Google** receives the diagnostics and
usage data ML Kit sends when the on-device AI is used. If you use AI with OpenRouter, the request described above is
received by **OpenRouter** and the **model provider** you choose, on your behalf and with your key.
If you send a support email or a suggestion report, the holder receives it at inklab@mainshai.com (or at dev@mainshai.com, the address the app used up to version 0.6.2) through the email service you choose.

## 5. International transfers
The developer makes no data transfers. If you use AI with OpenRouter, the request goes to the provider you choose,
which may process it in other regions and under its own terms. Google may process the ML Kit diagnostics in other
countries, under its own terms. Any other service you decide to use (email, cloud, the
destination of copied text or of a shared file or image) is governed by its own terms.

## 6. How long it is kept


- **Data on your phone:** until you uninstall the app or clear its data from the system settings (and, where
  applicable, from the backup texts or files you saved). The diary photos are also deleted as soon as you remove the
  photo or the entry.
- **Support emails:** as long as needed to handle your query and, at most, one year after the last reply.

## 7. Your rights


You can exercise your rights of **access, rectification, erasure, objection, restriction of processing and
portability** by writing to inklab@mainshai.com. We will reply within one month.

We do not receive the data stored on your phone, so we cannot see or delete it for you. You can delete it by
uninstalling the app or clearing its data from the system settings, and take it with you with "Export" (Settings →
Backup; the diary photos are not part of that text) or with "Save backup file" (which does include them). For anything
sent to OpenRouter, exercise your rights with
OpenRouter and the model provider; for the ML Kit diagnostics, with Google.

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


inklab@mainshai.com
