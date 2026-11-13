<!--
Not legal advice. Summarises what the app does with data, checked against the code.
-->

# Privacy and compliance

Summarises what the app does with data, checked against the code on 7 Nov 2026. The user-facing policy is
[`docs/legal/politica-privacidad.md`](legal/politica-privacidad.md) (English:
[`politica-privacidad.en.md`](legal/politica-privacidad.en.md)) and must say the same as this document.
Spanish version (authoritative): [`privacy.md`](privacy.md).

## Data flow
- **By default the app talks to no server.** No accounts, own server, own analytics or telemetry, ads, purchases or
  crash reports. With AI off there is no network traffic (measured on an emulator) and the app does not call ML Kit. The catalogues of the 15 marker brands (Ohuhu, DecoTime, Copic,
  Finecolour, Touch Twin, Promarker, Promarker Brush, Prismacolor Premier, Spectrum Noir, Arrtx, ZIG Kurecolor, Graph'it,
  Marvy Le Plume, Blick Studio Brush and Artist's Loft; 3,420 colours in `assets/data/*_colors.json`) ship inside the
  app and the palette engine is local Dart (`lib/core/`): everything works offline. Also computed only on the phone,
  from those catalogues and the user's data: the "In other brands" equivalents in a marker's detail, "Shadow and
  light", "Blend with…" and the near-duplicate warning (`lib/core/shadow_light.dart`, `lib/core/gradient_preview.dart`),
  the hex search (`lib/core/hex_search.dart`), the greyscale "Values" view (`lib/core/value_view.dart`), the "Colour
  vision" preview in Palette (it only changes what is drawn; saving and sharing use the true colours), the "Colour map"
  and the recipe translator in Tools (`lib/core/collection_wheel.dart`, `lib/core/recipe_codes.dart`) and the "Diary
  numbers".
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
  and shares it between apps; the system (Google services) performs that download, not the app. On iOS 26+ the
  "On device" option uses Apple Intelligence (the Foundation Models framework, `ios/Runner/OnDeviceAiChannel.swift`):
  iOS installs and manages the model, the app downloads nothing, there is no ML Kit or other SDK and nothing leaves the
  phone.
- **Store review, three times at most** (`lib/core/review_policy.dart`, `lib/data/review_prompt.dart`, package
  `in_app_review`): when a palette or a new diary entry is saved, the app may ask the system to show the store's review
  dialog (Google Play In-App Review on Android, StoreKit on iOS), only if 7 days have passed since the first recorded
  launch, the app was opened on 5 different days, there is a saved palette or a diary entry, the first-run setup is
  over, no backup restore or import happened in this session, and requests are left (3 in all, one per version, 90
  days apart). The store decides whether it appears; the app only tells it which app it is (its package or Apple ID),
  receives neither the rating nor the text, does not know whether a review was left and passes nothing else. Google or Apple
  receives the review with the user's store account. On Android it is an inter-process call (IPC) to the Play Store
  app on the phone. "Rate Ink Lab" (Settings → About) opens the app's store page (`openStoreListing`, Apple ID
  `6830184034`). The counters live in `shared_preferences` (`review_state`, one JSON: first and last day opened,
  number of distinct days, number of requests, day and version of the last one, times the store had no dialog),
  outside `AppSettingsState` and both app backups; the old keys `review_prompt_asked` and `review_prompt_unavailable`
  are moved into `review_state` once and removed. If the store cannot show the dialog (an app installed without Play,
  for instance) it counts that and stops trying after the third time. On Android the system backup is off; on iOS
  they are part of the iPhone or iCloud backup when the user has it on, like the rest of `UserDefaults`.
- **Easel mode** (Palette): while it is open, `wakelock_plus` (`lib/ui/screen_awake.dart`) keeps the screen on (a
  window flag on Android, the idle timer on iOS) and releases it on close. It asks for no permission (no `WAKE_LOCK`)
  and stores or sends no data.
- **Home-screen shortcuts** (`quick_actions`, `lib/ui/shell/app_shortcuts.dart`): a long press on the icon (Android)
  or the quick actions (iOS) open Match, New palette or Search swatches. They are three fixed entries with the app's
  own labels: no user data, no permissions.
- **Palettes and collections as text:** "Share as text" (Palette), the collection export as CSV or text and the
  translated recipe (Tools) are handed, only when tapped, to the system share sheet or the clipboard
  (`lib/ui/pages/palette/palette_text_flow.dart`, `lib/ui/pages/tools/`). "Import from text" and the code import read
  only the text the user pastes or types, with a size cap (`lib/core/palette_text.dart`), and open no links.
- **No analytics or tracking dependencies of our own:** `pubspec.yaml` includes no analytics, advertising or
  crash-reporting SDK. The only telemetry is ML Kit's to Google described above, only with AI turned on. The app does
  not use the advertising identifier.
- **Local error log, never sent on its own:** unexpected errors caught by `runGuardedByErrorLog` (`lib/main.dart`,
  `lib/core/error_log.dart`) are appended to `ink-lab-errors.log` in `getApplicationSupportDirectory()/error_log/` (the
  app's private storage). Each entry: time, app version, platform and OS version, where the error was caught, the first
  line of the message (at most 300 characters) and a trimmed stack (at most 40 lines and 4000 characters). Before
  writing, `ErrorLog.redact` replaces URL query parameters, bearer tokens, named secrets and `sk-` keys, long tokens,
  email addresses and app and user folder names. At about 200 KB the file rotates to `ink-lab-errors.1.log` (one
  previous file kept). There is no upload and no crash-reporting SDK. Settings → About: "Share error log" hands the text
  to the system share sheet (`share_plus`, `lib/ui/share/share_sink.dart`, `lib/ui/pages/settings/about_section.dart`)
  and "Clear error log" deletes both files. Android: `file` domain, excluded from backup and transfer; iOS: inside the
  app container, so it can enter the user's iPhone or iCloud backup.
- **Free and open source app:** MIT code, CC BY-SA 4.0 own content (`LICENSE`, `LICENSE-CONTENT.md`).
- Everything works without asking for a name, email, phone number or age.

## What is stored on the phone
In `shared_preferences` (the app's private storage): active brand, packs and owned markers, favourites
(`favorite_marker_ids`), wishlist (`wishlist_marker_ids`, brand-scoped marker ids), markers marked as dried out
(`dried_marker_ids`), the ink level: markers that are running out (`running_out_marker_ids`), refill notes of up to 80 characters
(`marker_refill_notes`), the file names of the photos of the real paper swatches (`marker_swatch_photos`; the photos
themselves are files in the app's private folder, next to the diary's), own colours per marker (`own_marker_colors`, `brandId:CODE` → hex: only the derived hex, never the
photo), saved palettes (`saved_palettes:<brandId>`), the history of the latest Match picks (`color_match_history`:
sampled colour, matched marker and distance; never the photo), the artwork diary (`artwork_diary`, only on installs from
before 1.0.0: at launch it moves to its own file, see below), the favourite and recently viewed ideas
(`idea_favorites`, `idea_recent`: idea ids only, `lib/data/idea_favorites_repository.dart`), the onboarding draft
(`onboarding_draft`: the brand and packs chosen so far, deleted by Start or Skip), the store review counters
(`review_state`), appearance preferences, the
date of the last backup file (`last_backup_at`, epoch milliseconds; shown in Settings and used to suggest a new backup
after 30 days; never part of a backup) and the AI settings **without the key** (`ai_settings`). No device or user
identifiers. The OpenRouter key, if the user saves it, is kept apart: Android Keystore (`flutter_secure_storage`) or iOS
Keychain "this device only" (`lib/data/secure_secret_store.dart`).

The Android home-screen widget ("Idea of the day") reads its own private preferences file, `HomeWidgetPreferences`
(key `ideas`), which the app writes: the ideas catalogue in the app language (title, summary, category, minutes) and
up to five hex colours per idea, picked from the user's markers (`lib/data/idea_widget_sync.dart`). No identifiers,
notes, photos or diary data. The widget refreshes itself with an inexact alarm at midnight (no exact-alarm
permission); the WorkManager permissions the widget library would add (`WAKE_LOCK`, `RECEIVE_BOOT_COMPLETED`,
`FOREGROUND_SERVICE`) are removed from the manifest.

The artwork diary (title, date, what it was painted on, status, markers used, linked palette and notes) is a JSON file
of its own, `artwork_diary.json`, in `getApplicationDocumentsDirectory()`, replaced atomically with a `.bak` copy of the
previous one (`lib/data/artwork_diary_storage.dart`). The user's own blending recipes (Tools → My recipes: name,
markers, notes and an optional photo) are kept in `blend_recipes.json`, in the same folder and with the same guarantees
(`lib/data/blend_recipe_repository.dart`).

The diary's photos are not in `shared_preferences`: they are files in `getApplicationDocumentsDirectory()/artworks/` (the
`artworks/` folder of the app's documents directory), at most 4 per entry, copied reduced to 2048 pixels per side when
they are added (`lib/main.dart`, `lib/data/artwork_photo_store.dart`). The diary only stores the **file name**, never a
path (`lib/data/artwork_diary_repository.dart`). The photos are deleted when the photo or the entry is removed, and with
the app when it is uninstalled.

The photo of the real paper swatch of a marker (the "Real swatch" row of the marker detail) is a file in the same
folder, under a name that starts with `sw-`, one per marker, scaled by the picker to about 1024 pixels per side
(`lib/data/marker_extras_repository.dart`). It follows the same rules as the diary photos: it is never sent, it is
deleted when it is removed or replaced, it travels in the backup ZIP and not in the clipboard backup, and the Android
system backup leaves it out. The photo of a blending recipe is another file in that folder (reduced to 2048 pixels per
side, JPEG quality 85) under the same rules: never sent, deleted when it is removed or the recipe is deleted, carried in
the ZIP.

| Where | What happens |
|---|---|
| Android system backup | **Disabled:** `allowBackup="false"` plus explicit rules excluding the preferences (`sharedpref`), the database (`database`), the app's files (`file`) and `root/app_flutter/`, which is `getApplicationDocumentsDirectory()` (the diary photos), both for the cloud backup and for the phone-to-phone transfer (`android/app/src/main/res/xml/backup_rules.xml`, `android/app/src/main/res/xml/data_extraction_rules.xml`). Neither the settings, nor the key, nor the photos, nor the error log (`files/error_log/`) leave that way. |
| iOS system backup | **No exclusion flag:** the app declares none. The key is in the Keychain "this device only" and does not move to another iPhone; the preferences, the diary, the blending recipes, every stored photo and the error log do enter the iPhone or iCloud backup that the user manages with their Apple ID. |
| The app's own `Export` backup (clipboard) | See "Backup". It never includes the key nor the photos: only the internal file name of each photo. |
| The app's backup file (ZIP) | See "Backup". It carries the same document plus the diary, swatch and recipe photos; never the key. It only leaves the phone through the system share sheet, to wherever the user sends it. |

## Permissions
They are requested when the user taps the feature, never at launch.

| Permission | What for | Where |
|---|---|---|
| Camera and photos (`NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` on iOS; system picker on Android) | Matching the colour of a photo to a marker, finding a photo's main colours for a palette ("Scene from a photo"), reading a marker's own colour from a photo of a painted swatch ("My colour"; only the hex is stored) and adding photos to a "Diary" entry (Ideas → Diary), to a marker's real swatch ("Real swatch", in the detail) or to a blending recipe (Tools). The photo is decoded and analysed **on the phone** and is never sent to any AI provider. In "Match", "Scene from a photo" and "My colour" it is not stored; in the "Diary", "Real swatch" and the recipes a reduced copy is stored in the app's private folder (see "What is stored on the phone"). | `ios/Runner/Info.plist`, `lib/ui/pages/match/`, `lib/ui/pages/palette/palette_photo_scene.dart`, `lib/ui/pages/swatches/`, `lib/ui/pages/diary/`, `lib/ui/pages/tools/blend_recipe_page.dart` |
| Network (`INTERNET`, and `ACCESS_NETWORK_STATE` via ML Kit, Android) | Only with AI turned on: the optional AI with OpenRouter and ML Kit's diagnostics to Google when the on-device AI is used. With AI off the app opens no socket. | `AndroidManifest.xml`, merged manifest |

No location, contacts, calendar, microphone, general storage, notifications or advertising identifier. Easel mode, the
shortcuts and the store review add no permission. Sharing a
palette, a swatch chart or a diary entry as an image, the backup file or the error log, needs no permission: the image,
the ZIP or the log is only handed to the app the user picks in the system share sheet (`share_plus`, `lib/ui/share/`,
`lib/ui/pages/settings/backup_file_io.dart`). Neither does picking a backup file: `file_selector` opens the system
document picker without declaring any permission. `ios/Runner/PrivacyInfo.xcprivacy` declares no tracking and no
collected data, and two APIs with a reason: `UserDefaults` (`CA92.1`) and file timestamps
(`NSPrivacyAccessedAPICategoryFileTimestamp`, `C617.1`), linked by `package_info_plus` (a dependency of `wakelock_plus`)
and only used on the app's own files, inside its container.

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
the markers that are running out (`runningOutMarkers`), the refill notes (`refillNotes`), the names of the swatch photos
(`swatchPhotos`), the diary entries (`artworkDiary`), the blending recipes (`blendRecipes`, with the name of their photo), the non-secret AI settings (`aiSettings`) and the favourite and recently viewed
ideas (`ideaFavorites`, `recentIdeas`) (`lib/data/backup_service.dart`). It hands it over **by copying it to the
clipboard**; "Import backup" receives it by pasting. Where that text ends up is the user's decision. The system clipboard may be visible to the keyboard or to other
apps depending on the operating system, so do not leave the backup pasted around. The API key is never part of the
backup, and neither are the photos (diary, swatch or recipe photos): the entries travel with the **internal file name** of each
photo, never with the photo.

Importing **replaces** the data the document carries; the sections that are not in it are left as they are. Since the
diary travels complete, the entries that are not in the backup are **deleted along with their photos**, and the app warns
before importing ("Replace your current data?").

**Backup file** (Settings → Your data → Backup file, `lib/ui/pages/settings/backup_section.dart`). "Share backup file"
builds a ZIP in memory (`package:archive`, `lib/data/backup_archive.dart`) with `manifest.json` (format `ink-lab-backup`,
format version, app version and photo count), `backup.json` (exactly the same document as the clipboard backup: **never
the API key**) and `photos/<name>` with the diary, real-swatch and blending-recipe photos the document refers to. `SystemBackupFileIo`
(`lib/ui/pages/settings/backup_file_io.dart`) writes it as `ink-lab-backup-YYYY-MM-DD.zip` in the app's temporary
folder (`getTemporaryDirectory()`, cache the system may clear), first deletes the earlier `ink-lab-backup-*.zip` files
there and opens the system share sheet (`share_plus`): the file only goes where the user sends it (Files, Drive, another
app...); it is not deleted when the sheet closes, because the chosen app may still be reading it, and the next save
deletes it. "Restore from file" opens the system document picker (`file_selector`, filtered to ZIP; no permission
declared). On Android the picker copies the chosen file into a folder of its own inside the app's cache; the app deletes
that copy (never the user's original) when it is done, whether or not the restore succeeded. The file is checked whole
before anything is written (at most 100 MB, 32 MB per entry, 2000 entries, sanitised photo names, every photo decoded as
an image); a refused file leaves the data and the photos as they were. After confirmation, the import replaces the data
like the clipboard one does and, in addition, writes the photos from the file and **deletes the diary, swatch and recipe photos
that are not in it**; if a photo cannot be written, it is undone and the data stays as it was. The import never turns the AI on or
touches the key.

## Support and links
The support address is **inklab@mainshai.com**. "About" offers to **copy** the repository URL to the clipboard; the app
never opens the browser. It opens the email client only when you tap "Send feedback" (About) or "Report this suggestion"
on an AI result (Palette), and nothing is sent unless you send the email. "Send feedback"
(`lib/ui/pages/settings/feedback_email.dart`) writes a `mailto:` to inklab@mainshai.com with the subject
`Ink Lab <version> feedback` and a body with room to write plus the app version, platform and OS version; it attaches nothing
(not the error log), and without an email app the address is copied to the clipboard. "Report this suggestion" opens a
message already written to inklab@mainshai.com that you decide whether to send: reason, version, provider and model,
brand, mode or scene and the suggestion's codes and texts; never the API key or photos. Without an email app, the report
is copied to the clipboard. The privacy policy is published at `https://inklab.mainshai.com/privacy/` (Spanish:
`https://inklab.mainshai.com/es/privacy/`), generated from `docs/legal/politica-privacidad.md`
(`docs/legal/LEEME.en.md`).

## Store declarations
- App Store, App Privacy: the app collects no data and does no tracking (iOS has no ML Kit). To be cautious about the optional AI with
  OpenRouter (a third party the user connects with their own key), the optional sending of "other usage data" can be
  declared as not linked to identity and not used for tracking.
- Google Play, Data safety: declare the data collected by the ML Kit SDK (device IDs, diagnostics and other
  performance data; optional, only with AI on; for analytics; encrypted in transit) and the optional OpenRouter request.
- The photos (diary, swatches, recipes) never leave the phone, so the forms do not change: neither Google Play (Data safety) nor Apple
  (privacy labels) has any new data collected or shared.
- Nor does 0.8 change them: the backup file and the image of a diary entry only leave through the system share sheet,
  to wherever the user sends them (a user-initiated transfer, which the stores count neither as collection nor as
  sharing); the brand equivalents, the colour-vision preview, the diary numbers, the favourite and recent ideas and the
  Finecolour catalogue are computed on, or bundled with, the app, without network; the file picker adds no permission.
- The error log, "Send feedback" and the last-backup date send nothing automatically: the log only leaves through the
  system share sheet and the feedback email through the user's own email app, when the user chooses; the date stays on
  the phone. With the final binary, check whether the forms should mention the diagnostics (error details, app and OS
  version) that a user may send by hand.
- Nor does 1.0.0 change them: the swatch and recipe photos, the ink level and the refill notes stay on the phone; the
  new catalogues ship inside the app; the text of a palette or of the collection only leaves through the share sheet or
  the clipboard, when the user chooses; easel mode and the shortcuts handle no data; and the review dialog is shown by
  the store (Play or App Store) without the app receiving or sending anything. Nothing new to declare in App Privacy;
  the manifest already carries reason `C617.1`.
- There are no accounts to delete; data is removed by uninstalling the app or clearing its data in the system.
