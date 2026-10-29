<!--
Not legal advice. Summarises what the app does with data, checked against the code on 30 Oct 2026;
have a professional review it before the store launch.
-->

# Privacy and compliance

Summarises what the app does with data, checked against the code on 30 Oct 2026. The user-facing policy is
[`docs/legal/politica-privacidad.md`](legal/politica-privacidad.md) (English:
[`politica-privacidad.en.md`](legal/politica-privacidad.en.md)) and must say the same as this document.
Spanish version (authoritative): [`privacy.md`](privacy.md).

## Data flow
- **By default the app talks to no server.** No accounts, own server, own analytics or telemetry, ads, purchases or
  crash reports. With AI off there is no network traffic (measured on an emulator) and the app does not call ML Kit. The marker catalogues ship inside the app (`assets/data/`) and the palette engine is local Dart
  (`lib/core/`): everything works offline.
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
In `shared_preferences` (the app's private storage): active brand, packs and owned markers, favourites, saved palettes,
the history of the latest Match picks (sampled colour, matched marker and distance; never the photo), appearance
preferences and the AI settings **without the key**. No device or user identifiers. The OpenRouter key, if the user
saves it, is kept apart: Android Keystore (`flutter_secure_storage`) or iOS Keychain "this device only"
(`lib/data/secure_secret_store.dart`).

| Where | What happens |
|---|---|
| Android system backup | **Disabled:** `allowBackup="false"` plus explicit rules excluding everything (`backup_rules.xml`, `data_extraction_rules.xml`), also for phone-to-phone transfer. Neither the settings nor the key leave that way. |
| iOS system backup | The key is in the Keychain "this device only" and does not move to another iPhone. The preferences are part of the iPhone backup that the user manages with their Apple ID. |
| The app's own `Export` backup | See "Backup". It never includes the key. |

## Permissions
They are requested when the user taps the feature, never at launch.

| Permission | What for | Where |
|---|---|---|
| Camera and photos (`NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` on iOS; system picker on Android) | Matching the colour of a photo to a marker, and finding a photo's main colours for a palette ("Scene from a photo"). The photo is decoded and analysed **on the phone**; it is not uploaded, not stored and not sent to any AI provider. | `ios/Runner/Info.plist`, `lib/ui/pages/match/`, `lib/ui/pages/palette/palette_photo_scene.dart` |
| Network (`INTERNET`, and `ACCESS_NETWORK_STATE` via ML Kit, Android) | Only with AI turned on: the optional AI with OpenRouter and ML Kit's diagnostics to Google when the on-device AI is used. With AI off the app opens no socket. | `AndroidManifest.xml`, merged manifest |

No location, contacts, calendar, microphone, general storage, notifications or advertising identifier.
`ios/Runner/PrivacyInfo.xcprivacy` declares no tracking and no collected data; it only uses the `UserDefaults` API
with reason `CA92.1`.

## Optional AI
Off by default. Before turning it on, the app shows what would leave the phone.

- **Local engine (colour theory):** no AI and no network.
- **On-device (Gemini Nano, Android):** the scenario and the colour codes are processed on the phone; ML Kit sends
  Google the diagnostics described in "Data flow".
- **OpenRouter with your own key:** only with AI on, OpenRouter chosen, a key saved and after tapping "Suggest with
  AI" (or opening the model list). The app sends, from the phone to `openrouter.ai` over HTTPS and with the user's key
  in the `Authorization` header (`lib/ai/open_router_client.dart`, `lib/ai/open_router_palette_advisor.dart`): brand
  (`BRAND_ID`, `BRAND_LABEL`), palette mode (`MODE`), scene name in English (`SCENARIO`), code and name of the base
  marker if any (`BASE_CODE`, `BASE_NAME`), whether it is locked (`BASE_LOCKED`), palette size (`PALETTE_SIZE`), codes
  and hex of the candidates without their names (`AVAILABLE_COLORS`), generation settings (model, temperature, max
  tokens), a fixed system prompt and an `X-Title: Ink Lab` header. The model catalogue request sends the key. Photos
  (`IMAGE_ATTACHED=false`; no code path attaches an image), favourites, saved palettes and identifiers are **never**
  sent. OpenRouter and the model provider see the device's IP address, as with any connection, and apply their own
  terms and retention (https://openrouter.ai/privacy); the developer sees nothing.
- If the AI fails, the app falls back to the local engine. Importing a backup never turns the AI on.

## Backup
"Export backup" (Settings) produces a versioned, **unencrypted** JSON with the collections, favourites, saved
palettes, Match history and the non-secret settings (`lib/data/backup_service.dart`). It hands it over **by copying it
to the clipboard**; "Import backup" receives it by pasting. Where that text ends up is the user's decision. The system
clipboard may be visible to the keyboard or to other apps depending on the operating system, so do not leave the backup
pasted around. The API key is never part of the backup.

## Support and links
The support address is **dev@mainshai.com**. "About" offers to **copy** the repository URL to the clipboard; the app
opens neither the browser nor the email client by itself. The privacy policy is published at
`https://dferrandizmont.github.io/ink-lab/privacidad/` (English: `.../privacidad/en/`), generated from
`docs/legal/politica-privacidad.md` (`docs/legal/LEEME.en.md`).

## Store declarations
- App Store, App Privacy: the app collects no data and does no tracking (iOS has no ML Kit). To be cautious about the optional AI with
  OpenRouter (a third party the user connects with their own key), the optional sending of "other usage data" can be
  declared as not linked to identity and not used for tracking.
- Google Play, Data safety: declare the data collected by the ML Kit SDK (device IDs, diagnostics and other
  performance data; optional, only with AI on; for analytics; encrypted in transit) and the optional OpenRouter request.
  Final answers in `docs/tienda/google-play.md`.
- There are no accounts to delete; data is removed by uninstalling the app or clearing its data in the system.
- Review the forms with the final AAB/IPA and publish a policy URL consistent with these facts.

## Pending before the store launch
- [ ] Publish the policy (URL), link it from both stores and from Settings if wanted.
- [ ] Fill in App Privacy (Apple) and Data safety (Play) with the final binary.
- [ ] Review this document whenever the data flow changes (permissions, backups, AI, exports, support).
