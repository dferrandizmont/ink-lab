<!--
Not legal advice. Summarises what the app does with data, checked against the code on 1 Nov 2026;
have a professional review it before the store launch.
-->

# Privacy and compliance

Summarises what the app does with data, checked against the code on 1 Nov 2026. The user-facing policy is
[`docs/legal/politica-privacidad.md`](legal/politica-privacidad.md) (English:
[`politica-privacidad.en.md`](legal/politica-privacidad.en.md)) and must say the same as this document.
Spanish version (authoritative): [`privacy.md`](privacy.md).

## Data flow
- **By default the app talks to no server.** No accounts, own server, own analytics or telemetry, ads, purchases or
  crash reports. With AI off there is no network traffic (measured on an emulator) and the app does not call ML Kit. The marker catalogues (Ohuhu, Copic and Finecolour, `assets/data/*_colors.json`) ship inside the app and the palette engine is local Dart
  (`lib/core/`): everything works offline. The "In other brands" equivalents in a marker's detail, the "Colour vision"
  preview in Palette (it only changes what is drawn; saving and sharing use the true colours) and the "Diary numbers"
  are also computed only on the phone, from those catalogues and the user's data.
- **The artwork diary stays on the phone:** the photos the user adds to a "Diary" entry (Ideas → Diary) are copied
  reduced into the app's private folder and are uploaded nowhere: not to an own server, not to the AI features
  (OpenRouter, Gemini Nano or ML Kit). The rest of the diary (title, date, markers used, notes) is text in the app's
  private storage. "Share this entry" (`lib/ui/share/diary_entry_renderer.dart`) draws, only when tapped, a PNG with
  the title, date, surface, status, the first photo, the markers and the colours of the linked palette, and hands it to
  the system share sheet; the photo is decoded for that image and released when it is done.
- **The network is only used if the user turns on AI** (Settings → AI assistant → Suggest with AI): with OpenRouter and
  their own key, and on Android for the diagnostics ML Kit sends Google when the on-device AI is used (see below). The
  Android manifest declares `INTERNET`; the merged manifest adds `ACCESS_NETWORK_STATE` and the
  `com.google.android.datatransport` component (Google's log transport used by ML Kit); `usesCleartextTraffic="false"` and `network_security_config.xml`
  refuse unencrypted traffic. The client (`lib/ai/open_router_client.dart`) only talks to `openrouter.ai` over HTTPS,
  follows no redirects, caps response sizes and sanitises the text it receives.
- **On-device AI (Android):** Gemini Nano through the ML Kit GenAI Prompt API (`com.google.mlkit:genai-prompt` in
  `android/app/build.gradle.kts`) and AICore (`lib/ai/platform_on_device_palette_advisor.dart`,
  `android/.../OnDeviceAiChannel.kt`). The request (scenario and colour codes) is answered on the phone and sent
  nowhere. The app only calls ML Kit with AI turned on; from then on it checks whether Gemini Nano is available and,
  when checking, downloading or generating, **ML Kit sends Google** over HTTPS (to `firebaselogging.googleapis.com`,
  batched, low priority, roughly once a day) diagnostics and usage data. According to the
  [ML Kit Android data disclosure](https://developers.google.com/ml-kit/android-data-disclosure): device information
  (manufacturer, model, OS version and build), app information (package name, app version), device or other
  identifiers (including per-installation identifiers), performance metrics, API configuration, input/output size,
  feature version, event type, error codes and, for GenAI, the configured languages. Purpose: diagnostics and usage
  analytics; Google says it does not transfer this data to third parties. It includes no prompt content, colours or
  photos (only sizes). The developer does not receive it; Google processes it under its
  [privacy policy](https://policies.google.com/privacy). If the model is not on the phone, Android downloads it once
  and shares it between apps; the system (Google services) performs that download, not the app. iOS has no on-device
  model yet and no ML Kit.
- **No analytics or tracking dependencies of our own:** `pubspec.yaml` includes no analytics, advertising or
  crash-reporting SDK. The only telemetry is ML Kit's to Google described above, only with AI turned on. The app does
  not use the advertising identifier.
- **Free and open source app:** MIT code, CC BY-SA 4.0 own content (`LICENSE`, `LICENSE-CONTENT.md`).
- Everything works without asking for a name, email, phone number or age.

## What is stored on the phone
In `shared_preferences` (the app's private storage): active brand, packs and owned markers, favourites
(`favorite_marker_ids`), wishlist (`wishlist_marker_ids`, brand-scoped marker ids), markers marked as dried out
(`dried_marker_ids`), own colours per marker (`own_marker_colors`, `brandId:CODE` → hex: only the derived hex, never
the photo), saved palettes (`saved_palettes:<brandId>`), the history of the latest Match picks (`color_match_history`:
sampled colour, matched marker and distance; never the photo), the artwork diary (`artwork_diary`: title, date, what
it was painted on, status, markers used, linked palette and notes), the favourite and recently viewed ideas
(`idea_favorites`, `idea_recent`: idea ids only, `lib/data/idea_favorites_repository.dart`), appearance preferences and
the AI settings **without the key** (`ai_settings`). No device or user identifiers. The OpenRouter key, if the user
saves it, is kept apart:
Android Keystore (`flutter_secure_storage`) or iOS Keychain "this device only"
(`lib/data/secure_secret_store.dart`).

The diary's photos are not in `shared_preferences`: they are files in `getApplicationDocumentsDirectory()/artworks/` (the
`artworks/` folder of the app's documents directory), at most 4 per entry, copied reduced to 2048 pixels per side when
they are added (`lib/main.dart`, `lib/data/artwork_photo_store.dart`). The diary only stores the **file name**, never a
path (`lib/data/artwork_diary_repository.dart`). The photos are deleted when the photo or the entry is removed, and with
the app when it is uninstalled.

| Where | What happens |
|---|---|
| Android system backup | **Disabled:** `allowBackup="false"` plus explicit rules excluding the preferences (`sharedpref`), the database (`database`), the app's files (`file`) and `root/app_flutter/`, which is `getApplicationDocumentsDirectory()` (the diary photos), both for the cloud backup and for the phone-to-phone transfer (`android/app/src/main/res/xml/backup_rules.xml`, `android/app/src/main/res/xml/data_extraction_rules.xml`). Neither the settings, nor the key, nor the photos leave that way. |
| iOS system backup | **No exclusion flag:** the app declares none. The key is in the Keychain "this device only" and does not move to another iPhone; the preferences and the diary photos do enter the iPhone or iCloud backup that the user manages with their Apple ID. |
| The app's own `Export` backup (clipboard) | See "Backup". It never includes the key nor the photos: only the internal file name of each diary photo. |
| The app's backup file (ZIP) | See "Backup". It carries the same document plus the diary photos; never the key. It only leaves the phone through the system share sheet, to wherever the user sends it. |

## Permissions
They are requested when the user taps the feature, never at launch.

| Permission | What for | Where |
|---|---|---|
| Camera and photos (`NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` on iOS; system picker on Android) | Matching the colour of a photo to a marker, finding a photo's main colours for a palette ("Scene from a photo"), reading a marker's own colour from a photo of a painted swatch ("My colour"; only the hex is stored) and adding photos to a "Diary" entry (Ideas → Diary). The photo is decoded and analysed **on the phone** and is never sent to any AI provider. In "Match", "Scene from a photo" and "My colour" it is not stored; in the "Diary" a reduced copy is stored in the app's private folder (see "What is stored on the phone"). | `ios/Runner/Info.plist`, `lib/ui/pages/match/`, `lib/ui/pages/palette/palette_photo_scene.dart`, `lib/ui/pages/swatches/own_color_page.dart`, `lib/ui/pages/diary/` |
| Network (`INTERNET`, and `ACCESS_NETWORK_STATE` via ML Kit, Android) | Only with AI turned on: the optional AI with OpenRouter and ML Kit's diagnostics to Google when the on-device AI is used. With AI off the app opens no socket. | `AndroidManifest.xml`, merged manifest |

No location, contacts, calendar, microphone, general storage, notifications or advertising identifier. Sharing a palette,
a swatch chart or a diary entry as an image, or the backup file, needs no permission: the image or the ZIP is only handed
to the app the user picks in the system share sheet (`share_plus`, `lib/ui/share/`,
`lib/ui/pages/settings/backup_file_io.dart`). Neither does picking a backup file: `file_selector` opens the system
document picker without declaring any permission.
`ios/Runner/PrivacyInfo.xcprivacy` declares no tracking and no collected data; it only uses the `UserDefaults` API
with reason `CA92.1`.

## Optional AI
Off by default. Before turning it on, the app shows what would leave the phone.

- **Local engine (colour theory):** no AI and no network.
- **On-device (Gemini Nano, Android):** the scenario and the colour codes are processed on the phone; ML Kit sends
  Google the diagnostics described in "Data flow".
- **OpenRouter with your own key:** only with AI on, OpenRouter chosen, a key saved and after tapping "Suggest with AI"
  (or opening the model list). The app sends, from the phone to `openrouter.ai` over HTTPS and with the user's key in
  the `Authorization` header (`lib/ai/open_router_client.dart`, `lib/ai/open_router_palette_advisor.dart`): brand
  (`BRAND_ID`, `BRAND_LABEL`), palette mode (`MODE`), scene name in English (`SCENARIO`), code and name of the base
  marker if any (`BASE_CODE`, `BASE_NAME`), whether it is locked (`BASE_LOCKED`), palette size (`PALETTE_SIZE`), codes
  and catalogue hex of the candidates without their names (`AVAILABLE_COLORS`; never the user's own colours,
  `test/ai/own_color_privacy_test.dart`), generation settings (model, temperature, max tokens), a fixed system prompt
  and an `X-Title: Ink Lab` header. The model catalogue request sends the key. Photos (`IMAGE_ATTACHED=false`; no code
  path attaches an image), own colours, favourites, saved palettes and identifiers are **never** sent. OpenRouter and
  the model provider see the device's IP address, as with any connection, and apply their own terms and retention
  (https://openrouter.ai/privacy); the developer sees nothing.
- If the AI fails, the app falls back to the local engine. Importing a backup never turns the AI on.

## Backup
"Export backup" (Settings) produces a **JSON text** (not a file), with a version (`version`) and **unencrypted**, with
these sections: the app settings (`appSettings`), the saved palettes (`savedPalettes`), the Match history
(`colorMatchHistory`), the own colours (`ownColors`), the wishlist (`wishlist`), the dried-out markers (`driedMarkers`),
the diary entries (`artworkDiary`), the non-secret AI settings (`aiSettings`) and the favourite and recently viewed
ideas (`ideaFavorites`, `recentIdeas`) (`lib/data/backup_service.dart`). It hands it over **by copying it to the
clipboard**; "Import backup" receives it by pasting. Where that text ends up is the user's decision. The system clipboard may be visible to the keyboard or to other
apps depending on the operating system, so do not leave the backup pasted around. The API key is never part of the
backup, and neither are the diary photos: the entries travel with the **internal file name** of each photo, never with
the photo.

Importing **replaces** the data the document carries; the sections that are not in it are left as they are. Since the
diary travels complete, the entries that are not in the backup are **deleted along with their photos**, and the app warns
before importing ("Replace your current data?").

**Backup file** (Settings → Your data → Backup file, `lib/ui/pages/settings/backup_section.dart`). "Save backup file"
builds a ZIP in memory (`package:archive`, `lib/data/backup_archive.dart`) with `manifest.json` (format `ink-lab-backup`,
format version, app version and photo count), `backup.json` (exactly the same document as the clipboard backup: **never
the API key**) and `photos/<name>` with the diary photos the entries refer to. `SystemBackupFileIo`
(`lib/ui/pages/settings/backup_file_io.dart`) writes it as `ink-lab-backup-YYYY-MM-DD.zip` in the app's temporary
folder (`getTemporaryDirectory()`, cache the system may clear), first deletes the earlier `ink-lab-backup-*.zip` files
there and opens the system share sheet (`share_plus`): the file only goes where the user sends it (Files, Drive, another
app...); it is not deleted when the sheet closes, because the chosen app may still be reading it, and the next save
deletes it. "Restore from file" opens the system document picker (`file_selector`, filtered to ZIP; no permission
declared). On Android the picker copies the chosen file into a folder of its own inside the app's cache; the app deletes
that copy (never the user's original) when it is done, whether or not the restore succeeded. The file is checked whole
before anything is written (at most 100 MB, 32 MB per entry, 2000 entries, sanitised photo names, every photo decoded as
an image); a refused file leaves the data and the photos as they were. After confirmation, the import replaces the data
like the clipboard one does and, in addition, writes the photos from the file and **deletes the diary photos that are not
in it**; if a photo cannot be written, it is undone and the data stays as it was. The import never turns the AI on or
touches the key.

## Support and links
The support address is **inklab@mainshai.com**. "About" offers to **copy** the repository URL to the clipboard; the app
never opens the browser. It opens the email client only when you tap "Report this suggestion" on an AI result
(Palette), with a message already written to inklab@mainshai.com that you decide whether to send: reason, version,
provider and model, brand, mode or scene and the suggestion's codes and texts; never the API key or photos. Without
an email app, the report is copied to the clipboard. The privacy policy is published at
`https://inklab.mainshai.com/privacy/` (Spanish: `https://inklab.mainshai.com/es/privacy/`), generated from
`docs/legal/politica-privacidad.md` (`docs/legal/LEEME.en.md`).

## Store declarations
- App Store, App Privacy: the app collects no data and does no tracking (iOS has no ML Kit). To be cautious about the optional AI with
  OpenRouter (a third party the user connects with their own key), the optional sending of "other usage data" can be
  declared as not linked to identity and not used for tracking.
- Google Play, Data safety: declare the data collected by the ML Kit SDK (device IDs, diagnostics and other
  performance data; optional, only with AI on; for analytics; encrypted in transit) and the optional OpenRouter request.
  Final answers in `docs/tienda/google-play.md`.
- The diary photos never leave the phone, so the forms do not change: neither Google Play (Data safety) nor Apple
  (privacy labels) has any new data collected or shared.
- Nor does 0.8 change them: the backup file and the image of a diary entry only leave through the system share sheet,
  to wherever the user sends them (a user-initiated transfer, which the stores count neither as collection nor as
  sharing); the brand equivalents, the colour-vision preview, the diary numbers, the favourite and recent ideas and the
  Finecolour catalogue are computed on, or bundled with, the app, without network; the file picker adds no permission.
- There are no accounts to delete; data is removed by uninstalling the app or clearing its data in the system.
- Review the forms with the final AAB/IPA and publish a policy URL consistent with these facts.

## Pending before the store launch
- [ ] Publish the policy (URL), link it from both stores and from Settings if wanted.
- [ ] Fill in App Privacy (Apple) and Data safety (Play) with the final binary.
- [ ] Review this document whenever the data flow changes (permissions, backups, AI, exports, support).
