[Español](README.md) · [English](README.en.md)

<!--
TODO(images): once the header and the screenshots exist, uncomment this block and add the PNG files to docs/readme/en/
(header.png, 1024 px wide). No invented images are included.
<p align="center">
  <img src="docs/readme/en/header.png" alt="Ink Lab — Your markers, your palettes. Free and offline." width="1024">
</p>
-->

# Ink Lab

[![Code: MIT](https://img.shields.io/badge/Code-MIT-30382F)](LICENSE)
[![Content: CC BY-SA 4.0](https://img.shields.io/badge/Content-CC_BY--SA_4.0-30382F)](LICENSE-CONTENT.en.md)
[![Latest version](https://img.shields.io/github/v/release/dferrandizmont/ink-lab?include_prereleases&label=version)](https://github.com/dferrandizmont/ink-lab/releases)
[![CI](https://github.com/dferrandizmont/ink-lab/actions/workflows/ci.yml/badge.svg)](https://github.com/dferrandizmont/ink-lab/actions/workflows/ci.yml)

A swatch and palette companion for people who draw with alcohol markers. Look up
the code of a colour, find out which marker in your collection is closest to a
photo, and build palettes with colour theory using only the markers you own.

**Free, no ads, no accounts, offline. Open source.** For Android and iOS, with
light and dark themes. AI is optional and off by default.

## Downloads

<p>
  <a href="https://github.com/dferrandizmont/ink-lab/releases/latest"><img src="https://img.shields.io/badge/Available_on-GitHub-181717?logo=github&amp;style=for-the-badge" alt="Available on GitHub"></a>
  <!--
  <a href="[GOOGLE_PLAY_LINK]"><img src="https://img.shields.io/badge/Google_Play-Download-414141?logo=googleplay&amp;style=for-the-badge" alt="Available on Google Play"></a>
  <a href="[APP_STORE_LINK]"><img src="https://img.shields.io/badge/App_Store-Download-0D96F6?logo=appstore&amp;style=for-the-badge" alt="Available on the App Store"></a>
  -->
</p>

You can download the APK of the [latest release](https://github.com/dferrandizmont/ink-lab/releases/latest)
and install it by hand (you have to allow installing apps from unknown sources).
Every release ships a `SHA256SUMS.txt` so you can verify the download with
`sha256sum -c SHA256SUMS.txt`.

Coming soon on Google Play and the App Store.

## Screenshots

<!--
TODO(images): replace this comment with the real screenshots (screens with test data) in docs/readme/en/:
<p>
  <a href="docs/readme/en/01-swatches.png"><img src="docs/readme/en/01-swatches.png" width="160" alt="Swatches with the code, name and colour of each marker"></a>
  <a href="docs/readme/en/02-match.png"><img src="docs/readme/en/02-match.png" width="160" alt="A photo colour matched to the closest marker"></a>
  <a href="docs/readme/en/03-palette.png"><img src="docs/readme/en/03-palette.png" width="160" alt="A colour-theory palette using the markers you own"></a>
  <a href="docs/readme/en/04-ideas.png"><img src="docs/readme/en/04-ideas.png" width="160" alt="Ideas with a technique and a suggested palette"></a>
  <a href="docs/readme/en/05-settings.png"><img src="docs/readme/en/05-settings.png" width="160" alt="Settings: brand, packs, owned markers and backup"></a>
</p>
-->

Coming soon: screenshots, in preparation. A [Spanish version](README.md#capturas) is also available.

## Features

- **Swatches:** the catalogue by code and name, with the hex colour of each
  marker, search, filtering by your packs, and favourites. For Ohuhu Oahu it also
  tells you where each marker sits on the colour card.
- **Match from a photo:** take a photo or pick one from the gallery, tap a point
  and the app tells you which marker in your collection is closest. The photo is
  processed on your phone; it is neither uploaded nor stored.
- **Colour-theory palettes:** pick a base colour and get harmonies
  (complementary, analogous, split complementary, triad, square, rectangle,
  monochrome and shadow), always resolved with the markers you own. All of this
  works offline and without AI.
- **Ideas:** challenges and techniques with a suggested palette that takes your
  active collection into account.
- **Two brands:** Ohuhu Oahu (with the new and the legacy codes) and DecoTime
  (with an owned-markers selection, because it is sold in fixed sets).
- **Optional AI:** either **on the device** (Gemini Nano, on compatible Android
  phones; nothing leaves the phone) or with **your own OpenRouter key**. If you do
  not turn it on, the app never uses the network.
- **Backup:** export and import your collections, favourites, palettes and
  settings as JSON text, with no account.
- Light and dark themes, tablets with a side rail, and Spanish and English texts.

## Privacy

Everything is stored on the phone. There are no accounts, no server of ours, no
analytics, no ads and no tracking. Android's cloud backup is switched off. The
camera and the gallery are only used to match a photo, and the photo never
leaves the device.

AI is optional:

- **On the device** (Gemini Nano): the request is answered on your phone.
- **OpenRouter with your key:** when you tap "Suggest with AI", the brand, the
  scenario, the base colour and the candidates (code, name and hex) are sent
  straight from your phone to `openrouter.ai` over HTTPS. The key is stored in
  the Keystore (Android) or the Keychain (iOS). Photos, favourites and saved
  palettes are never sent, and the developer sees nothing.

[Privacy policy](https://dferrandizmont.github.io/ink-lab/privacidad/en/) ·
[Technical details](docs/privacy.en.md) · Support: **dev@mainshai.com**.

## Data and trademarks

Ink Lab ships offline catalogues for **Ohuhu Oahu** and **DecoTime** (over 300
colours per range). Only codes, names, hex values and set membership are stored,
as factual reference data so you can identify the markers you already own. There
are no logos, product photographs or colour cards from any brand.

An independent project: **not affiliated with, sponsored by or endorsed by Ohuhu
or DecoTime**. "Ohuhu", "Oahu" and "DecoTime" are trademarks of their owners.
Public sources and the full notices are in [NOTICE.md](NOTICE.md). If a colour,
a name or a code is wrong, open a
[data fix](https://github.com/dferrandizmont/ink-lab/issues/new) issue.

## Build and test

Requirements: **Flutter 3.47.7** (stable channel), the Android SDK for Android,
or macOS with Xcode and CocoaPods for iPhone.

```bash
git clone https://github.com/dferrandizmont/ink-lab.git
cd ink-lab
flutter pub get
flutter analyze
flutter test
flutter run
```

A local test APK, signed with the debug key (never for stores):

```bash
flutter build apk --release --android-project-arg=allowDebugSigning=true
```

Public APKs are signed with the owner's key, which is not in the repository.
The code structure and its rules are in
the [architecture](docs/ARCHITECTURE.md). To contribute, see
[CONTRIBUTING.en.md](CONTRIBUTING.en.md).

The public selection is prepared with the [exporter](tool/publish/LEEME.en.md)
and the privacy page is generated with [web/legal](web/legal/LEEME.md).

## What's new

What changes in each version is in [CHANGELOG.md](CHANGELOG.md).

## Licences and security

Code under [MIT](LICENSE), Copyright (c) 2026 Daniel Mont Ferrandiz. Own
documentation and texts: [CC BY-SA 4.0](LICENSE-CONTENT.en.md). The catalogue
data are third-party factual references and fall outside both MIT and CC BY-SA
4.0; the typefaces (SIL OFL 1.1) and other third-party material keep their own
licences, listed in [NOTICE.md](NOTICE.md).

To report a vulnerability: [SECURITY.en.md](SECURITY.en.md).
