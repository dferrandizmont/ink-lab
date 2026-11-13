# Ink Lab privacy policy


Last updated: 2026-11-13

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
Your active brand, the packs and markers you own, your favourites, your wishlist, the ink level of your markers (full,
running out or dried out) and your refill notes, the photos of your real swatches, the own colours you store for your
markers, your saved palettes, your blending recipes and their photos, the history of your latest colour matches, the
entries and photos of your diary, your favourite and recently viewed ideas, your settings, how far you got in the
welcome steps, the date you last saved a backup file, the store review counters and the error log (see below) are stored
only in the app's private storage, on your device. For each own colour only its hex code is stored, never the photo you
took it from. The catalogues of the 15 marker brands (Ohuhu, DecoTime, Copic, Finecolour, Touch Twin, Promarker,
Promarker Brush, Prismacolor Premier, Spectrum Noir, Arrtx, ZIG Kurecolor, Graph'it, Marvy Le Plume, Blick Studio Brush
and Artist's Loft) ship inside the app and everything works offline. "In other brands", "Shadow and light", "Blend
with…" and the warning about near-identical markers (in a marker's detail), the hex search, the greyscale "Values" view,
the "Colour vision" preview (in Palette), the "Colour map" and the recipe translator (in My collection → Tools) and the
"Diary numbers" are computed on your phone from those catalogues and your data, sending nothing. There is no
synchronisation or copy on any server of ours.

Android's system backup is **switched off** for this app: it excludes all of the app's files from cloud backup and from
device-to-device transfer, so neither your settings, nor your key, nor your data, nor your photos, nor the error
log leave the phone that way. On iPhone, the preferences, the diary, the blending recipes, the photos the app keeps and
the error log may be part of the device or iCloud backup that you manage with your Apple account: that is Apple's mechanism, under your control, not a transfer
by the developer.

### Camera and gallery
Only when you use "Match", "From a photo" (in Palette) or "My colour" (in a marker's detail), or add a photo to a
"Diary" entry (in Ideas), to a marker's "Real swatch" or to a blending recipe, and choose to take a photo or pick one
from the gallery, the app asks for the permission or opens the system picker. The photo is decoded and analysed **on
your phone**: it is not uploaded anywhere and it is never sent to an AI provider; except in the diary, the real swatch
and the recipes (see below), it is not stored either. In "Match", only the sampled
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

### Real swatches, ink level and blending recipes
In the detail of a marker you own you can set its ink level (full, running out or dried out), write a refill note of
up to 80 characters and add a photo of your real paper swatch, which the app copies, shrunk to about 1024 pixels on a
side, into its private folder. In My collection → Tools you can keep your own blending recipes (name, markers, notes
and an optional photo, shrunk to at most 2048 pixels on a side). All of this stays on your phone: the photos are not
uploaded anywhere and are not sent to the AI features, they are deleted when you remove them or delete the recipe, and
with the app when you uninstall it. They only leave the phone if you save a backup file (see below) and send it
somewhere.

### Sharing as text
"Share as text" (in Palette), the export of your collection as CSV or text and the translated recipe (in Tools) build a
text with the markers (the brand, the codes and, depending on the case, the names, the colours and whether they are
dried out) and, only when you tap it, hand it to the app you pick in the system share sheet or copy it to the
clipboard. "Import from text" and the code import only read the text you paste or type; they open no links and connect
to nothing.

### Store review
Now and then, after you save a palette or a new diary entry, Ink Lab may ask the store (Google Play on Android, the App
Store on iPhone and iPad) to show you its window for rating the app. It does not ask during the first week, during a
restore or right after you restore or import a backup, or more than three times in all (at most once per version and at
least 90 days apart), and **the store decides** whether the window appears. To ask for that window, the app uses Google
Play's review library on Android (an internal exchange on the phone with the Google Play app) and the system feature on
iPhone and iPad. **Ink Lab only tells the store which app it is:** it does not pass on your palettes, your collection or
any other data of yours, and it does not know whether you rated it or what you wrote. You write your rating and your
review in the store's window, and **Google or Apple receives them, with your store account** and under its own terms.
You can also open Ink Lab's page in the store at any time with "Rate Ink Lab" (Settings → About).

To decide when to ask, the app keeps a few counters on your phone: the day you first opened it, the last day you opened
it, on how many different days you have opened it, how many times it has asked for a review, the day and app version of
the last time it asked, and how many times the store could not show the window (it stops trying after the third). They
are only dates and counts: they hold nothing about what you do inside the app or what you write. These counters are not
part of the app's backup (neither the text nor the file), and Ink Lab sends them to no one. On Android they do not leave
the phone either, because the system backup is turned off for this app; on iPhone and iPad they may be part of your
device or iCloud backup, if you have it turned on, like the rest of the app's settings.

### Easel mode and shortcuts
Easel mode (in Palette) shows the palette in large and keeps the screen on while it is open; when you close it, the
screen goes back to turning off as usual. It needs no permission and stores or sends no data. The home-screen shortcuts
(a long press on the icon on Android, quick actions on iPhone) only open Match, New palette or Search swatches: they
carry none of your data.

### Backup
"Export" (Settings → Backup) produces a JSON text, not a file, with your settings, the non-secret AI settings, your
collection, favourites, wishlist, dried-out markers, ink levels and refill notes, own colours, palettes, history,
favourite and recently viewed ideas, the diary entries and your blending recipes (with the internal file names of their
photos and of your swatch photos, not the photos), and **copies it to the clipboard** for you to paste wherever you like; "Import" receives it by pasting. Importing replaces your current data,
the diary included: entries that are not in the backup are deleted along with their photos, and the app warns you
before. The backup is not encrypted, carries no identifier and never includes your API key or any photo. What
you do with it afterwards (saving it in your cloud, sending it in a message...) is outside the app. Note that,
depending on your system, the clipboard may be visible to your keyboard or to other apps.

"Share backup file" (Settings → Your data → Backup file) makes a ZIP file with that same backup and, in addition, the
photos of your diary, your real swatches and your blending recipes, writes it to the app's temporary (cache) folder and opens the system share sheet for you to save it to
Files, Drive or the app you choose: it only goes where you send it, and the app deletes the earlier backup files in
that folder when it makes the next one. "Restore from file" opens the system document picker, which needs no
permission (the picker leaves a copy of the chosen file in the app's cache, and the app deletes it when it is done);
the file is checked whole before anything is written and the app asks you to confirm, because it replaces your
current data, photos included, and deletes the photos that are not in the file. No backup, neither the clipboard
one nor the file, includes your API key.

The app also remembers, only on your phone, the date you last saved a backup file, to show it to you and to suggest a
new backup when more than 30 days have passed. That date is not part of any backup.

### Error log
If the app hits an unexpected error, it writes a short entry to a file in its private storage on your phone, so that the
fault can be found and fixed. Each entry holds the time, the app version, the platform and system version, the part of
the app where the error was caught, the first line of the error message (at most 300 characters) and a shortened
technical trace of the code (stack trace). Before an entry is saved, the app replaces the parameters of web addresses,
tokens and keys, email addresses and the folder names that identify the app or the device user. The log is meant for
technical details, not for your content, although an error message may occasionally include a fragment of what the app
was handling at that moment. The file is capped at about 200 KB and one previous file is kept; older entries are
discarded. The log **never leaves your phone on its own**: nothing is uploaded and the app uses no crash-reporting
service. In Settings → About, "Share error log" hands the file, only when you tap it, to the app you pick in the system
share sheet, and it only goes where you send it; "Clear error log" deletes it, together with the previous file. On
Android it is excluded from cloud backup and device-to-device transfer, like the rest of the app's data; on iPhone it
may be part of your device or iCloud backup, also like the rest of the app's data.

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
  ML Kit is not used: on-device AI there is Apple Intelligence (see the next item).
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
The app asks for the **camera or photos** permission only when you use "Match", "From a photo" or "My colour", or add a
photo to the "Diary", to a real swatch or to a blending recipe. On Android it declares **internet** and **network state** access (`INTERNET` and
`ACCESS_NETWORK_STATE`), which are only used with AI turned on: for the optional AI with OpenRouter and for the
diagnostics ML Kit sends Google when the on-device AI is used. It does not ask for location, contacts, calendar,
microphone or notifications, and it does not use the advertising identifier. If you share a palette, a swatch chart or a
diary entry as an image, a backup file or the error log, it is only handed to the app you pick in the system share
sheet; the app needs no permission for it, nor to pick a backup file with the system picker. Easel mode, the shortcuts
and the store review need no permission. On iPhone, the app's privacy manifest declares, as Apple requires, that a
library the app uses (to read its own version) may look up file dates; it only does so for the app's own files, inside
its private space (reason C617.1), and that information does not leave the phone.

### Data that is NOT processed
- We do not ask for or keep your name, email, phone, age or any account data: there are no accounts.
- The developer uses no analytics and no crash reports, and there are no ads, no personalised advertising and no
  cross-app tracking. The only exception is the diagnostics and usage data ML Kit sends Google when you use the
  on-device AI (see "Optional AI"); the developer does not receive it.
- The error log (see "Error log") is not a crash report: nothing is sent automatically, and it only leaves your phone if
  you share it yourself.
- We do not receive your photos, your collections, your palettes or your key.

### If you write to us
You can write to inklab@mainshai.com. We will process your email address and what you tell us only to reply to you. Do not
send your API key or backups containing data you do not want to share: test data is enough to fix a bug.

If you report an AI suggestion ("Report this suggestion", in Palette), the app opens your email app with a message
already written to inklab@mainshai.com: the reason you choose, the app version, the AI provider and model, the brand, the
mode or scene, the base marker's code and that suggestion's codes, roles and reasons. It never includes your API key or photos. It only
reaches us if you send it, and we use it to review the reported content and improve the suggestions. If there is no
email app, the report is copied to the clipboard for you to paste.

"Send feedback" (Settings → About) opens your email app with a message to inklab@mainshai.com, pre-filled with the app
version, the platform and the system version, and room for you to write. Nothing is sent unless you send the email
yourself, and the error log is not attached. If there is no email app, the address is copied to the clipboard. If you
send us the error log, we use it only to find and fix the error.

## 3. Purposes and legal basis


| Processing | Purpose | Legal basis (GDPR) |
|---|---|---|
| Collections, ink levels and notes, wishlist, own colours, favourites, palettes, blending recipes, diary and settings on your phone | So that you can use the app and keep your work | We do not receive them: they stay on your device, under your control |
| "Match", "From a photo", "My colour", "Diary", real swatch or blending recipe photo | Finding the closest markers, reading the colour of your swatch or keeping the photo of an artwork, a swatch or a recipe | Processed (and, in the diary, the real swatch and the recipes, stored) only on your phone, at your request; we do not receive it |
| Error log on your phone | Finding and fixing the app's errors | Kept only on your phone; we do not receive it. If you choose to send it to us: your request and our legitimate interest in fixing the error (art. 6.1.f) |
| ML Kit diagnostics (only with the on-device AI, on Android) | Diagnostics and usage analytics of the SDK, according to Google | Sent only if you choose to turn on the optional AI; Google processes them as the provider of ML Kit, under its own terms and privacy policy; we do not receive them |
| AI with OpenRouter (optional) | Generating palette suggestions | Your consent when you turn it on and use your own key; OpenRouter performs the processing under its own terms |
| Support emails, feedback and AI suggestion reports | Replying to your query and reviewing the reported content | Your request and our legitimate interest in handling it (art. 6.1.f) |

We make no automated decisions and build no profiles about you.

## 4. Who receives the data
The app does not transmit data to the developer. If you turn on AI, on Android **Google** receives the diagnostics and
usage data ML Kit sends when the on-device AI is used. If you use AI with OpenRouter, the request described above is
received by **OpenRouter** and the **model provider** you choose, on your behalf and with your key. If you send us a
support email, feedback, a suggestion report or the error log, the holder receives it at inklab@mainshai.com (or at
dev@mainshai.com, the address the app used up to version 0.6.2) through the service you choose. If you share the error
log with another person or service, only that recipient receives it. If you rate the app in the store, **Google** or
**Apple** receives your rating and your review directly, with your store account; they do not go through the app. The
developer only sees afterwards what the store publishes or shows in its console (the rating, the review and your public
name; on Google Play, also technical details such as the device model and the system and app versions) and can reply to
you there.

## 5. International transfers
The developer makes no data transfers. If you use AI with OpenRouter, the request goes to the provider you choose, which
may process it in other regions and under its own terms. Google may process the ML Kit diagnostics in other countries,
under its own terms. The store where you rate the app (Google Play or the App Store) may process your rating and your
review in other countries, under its own terms. Any other service you decide to use (email, cloud, the destination of
copied text or of a shared file or image) is governed by its own terms.

## 6. How long it is kept


- **Data on your phone:** until you uninstall the app or clear its data from the system settings (and, where
  applicable, from the backup texts or files you saved). The diary, swatch and recipe photos are also deleted as soon as
  you remove the photo, the entry or the recipe.
- **Error log:** on your phone, until you delete it with "Clear error log", clear the app's data or uninstall the app.
  As it never grows beyond about 200 KB plus one previous file, the oldest entries are discarded along the way.
- **Support emails, feedback and error logs you send us:** as long as needed to handle your query and, at most, one year
  after the last reply.

## 7. Your rights


You can exercise your rights of **access, rectification, erasure, objection, restriction of processing and
portability** by writing to inklab@mainshai.com. We will reply within one month.

We do not receive the data stored on your phone, so we cannot see or delete it for you. You can delete it by
uninstalling the app or clearing its data from the system settings, and take it with you with "Export" (Settings →
Backup; the photos are not part of that text) or with "Share backup file" (which does include them). For anything
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
There is no developer server and no data transmission from the app, except with the optional AI turned on (the review
window is shown by the store, not by the app; see "Store review"). Your data is in the app's private space; your key, in
the Keystore or the Keychain; connections to OpenRouter use HTTPS and follow no redirects. Protecting your phone (screen
lock, encryption, no root or jailbreak) is up to you. The code is public and anyone can check what it does.

## 10. Changes to this policy


If what the app does with data changes, we will update this page and the date above. If the change is important (for
example, if a feature were to send data off the phone), we will also tell you inside the app and it would only be
turned on with your consent.

## 11. Contact


inklab@mainshai.com
