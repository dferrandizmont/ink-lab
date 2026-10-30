**English** · [Español](README.es.md)

<p align="center">
  <img src="docs/readme/en/header.png" alt="Ink Lab — Your markers, your palettes. Free and offline." width="1024">
</p>

# Ink Lab

[![Code: MIT](https://img.shields.io/badge/Code-MIT-30382F)](LICENSE)
[![Content: CC BY-SA 4.0](https://img.shields.io/badge/Content-CC_BY--SA_4.0-30382F)](LICENSE-CONTENT.md)
[![Version](https://img.shields.io/github/v/release/dferrandizmont/ink-lab?include_prereleases&label=version&color=30382F)](https://github.com/dferrandizmont/ink-lab/releases)
[![Downloads](https://img.shields.io/github/downloads/dferrandizmont/ink-lab/total?label=downloads&color=30382F)](https://github.com/dferrandizmont/ink-lab/releases)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-Buy_me_a_coffee-FF5E5B?logo=kofi&logoColor=white)](https://ko-fi.com/danielmfdev)

A swatch and palette companion for people who draw with alcohol markers. Look up
the code of a colour, find out which marker in your collection is closest to a
photo, and build palettes with colour theory using only the markers you own.
For Android, with light and dark themes, a side rail on tablets and Spanish and
English texts.

**Free · No ads · No account · Works offline · Open source**

AI is optional and off by default.

## Download

<p>
  <a href="https://github.com/dferrandizmont/ink-lab/releases/latest"><img src="https://img.shields.io/badge/Available_on-GitHub-181717?logo=github&amp;style=for-the-badge" alt="Available on GitHub"></a>
  <!--
  <a href="[GOOGLE_PLAY_LINK]"><img src="https://img.shields.io/badge/Google_Play-Download-414141?logo=googleplay&amp;style=for-the-badge" alt="Available on Google Play"></a>
  <a href="[APP_STORE_LINK]"><img src="https://img.shields.io/badge/App_Store-Download-0D96F6?logo=appstore&amp;style=for-the-badge" alt="Available on the App Store"></a>
  -->
</p>

Android on GitHub, and in closed testing on Google Play. iOS is coming.

<details>
<summary>Join the beta on Google Play</summary>

Ink Lab is in closed testing on Google Play before its public launch, and testers are welcome:

1. Join the [ink-lab-testers](https://groups.google.com/g/ink-lab-testers) Google Group
   (`ink-lab-testers@googlegroups.com`) with the Google account you use on Google Play.
2. Open the [testing invitation](https://play.google.com/apps/testing/es.inklab.app), accept it and install
   Ink Lab from Google Play. The invitation works once the test is live; if it says the app isn't
   available, try again in a few days.
3. Keep it installed for at least 14 days. Send what you find to dev@mainshai.com.

</details>

<details>
<summary>Install the APK from GitHub</summary>

1. Download the APK and `SHA256SUMS.txt` of the [latest
   release](https://github.com/dferrandizmont/ink-lab/releases/latest). Every
   release ships both, so you can verify the download with
   `sha256sum -c SHA256SUMS.txt`.
2. Allow installing apps from unknown sources when your phone asks, then open
   the APK.

</details>

## Screenshots

<p>
  <a href="docs/readme/en/01-swatches.png"><img src="docs/readme/en/01-swatches.png" width="19%" alt="Swatches with codes, names and colours"></a>
  <a href="docs/readme/en/03-match.png"><img src="docs/readme/en/03-match.png" width="19%" alt="A photo matched to the closest marker"></a>
  <a href="docs/readme/en/04-palette.png"><img src="docs/readme/en/04-palette.png" width="19%" alt="A palette with its type, scene and colours"></a>
  <a href="docs/readme/en/06-photo-scene.png"><img src="docs/readme/en/06-photo-scene.png" width="19%" alt="A scene made from a photo with your markers"></a>
  <a href="docs/readme/en/07-ideas.png"><img src="docs/readme/en/07-ideas.png" width="19%" alt="Ideas with a technique and a palette"></a>
</p>

<details>
<summary>More screenshots</summary>

<p>
  <a href="docs/readme/en/02-swatch-detail.png"><img src="docs/readme/en/02-swatch-detail.png" width="19%" alt="Marker detail with its codes and hex"></a>
  <a href="docs/readme/en/05-scenes.png"><img src="docs/readme/en/05-scenes.png" width="19%" alt="The scene list, by category"></a>
  <a href="docs/readme/en/08-settings-dark.png"><img src="docs/readme/en/08-settings-dark.png" width="19%" alt="Settings in the dark theme"></a>
</p>

</details>

Tap a screenshot to enlarge it.

## Features

- **My markers.** One collection per brand, built from the series you use, the
  sets you own and any loose markers. A short first-run guide sets it up.
- **Swatches.** The catalogue by code and name, with the hex of each marker,
  search, filters, your own markers and favourites. On Ohuhu Oahu it also shows where each
  marker sits on the colour card.
- **Match from a photo.** Take a photo or pick one from the gallery, tap a point
  and the app tells you which marker in your collection is closest, or says so
  when none is close.
- **Colour-theory palettes.** Pick a base colour and get harmonies
  (complementary, analogous, split complementary, triad, square, rectangle,
  monochrome and shadow), always resolved with the markers you own.
- **Scenes.** 67 ready-made recipes in 11 categories (skin, sky and water,
  nature, animals, food, fantasy…), searchable, each with its colour roles.
- **Scene from a photo.** The app finds the main colours of a photo and turns
  them into the closest markers you own.
- **Two brands.** Ohuhu (Oahu, Honolulu and Kaala, 503 colours, with the new
  and legacy codes) and DecoTime (313 colours, with an owned-markers
  selection, as it is sold in fixed sets).

<details>
<summary>More features</summary>

- **Ideas.** Challenges and techniques with a palette from your active
  collection.
- **Optional AI.** Either **on the device** (Gemini Nano, on compatible Android
  phones, through Google's ML Kit, which sends Google usage diagnostics but never
  your prompts, colours or photos) or with **your own OpenRouter key**. If you
  do not turn it on, the app never uses the network.
- **Backup.** Export and import your collections, favourites, palettes and
  settings as JSON text, with no account.

</details>

## Privacy

Everything is stored on the phone. There are no accounts, no server of ours, no
analytics of ours, no ads and no tracking. If you do not turn on AI, the app
never uses the network. On-device AI uses Google's ML Kit, which sends Google
usage diagnostics, never your prompts, colours or photos. The camera and the
gallery are only used to match a photo or to make a scene from one, and the
photo never leaves the device.

[Privacy policy](https://dferrandizmont.github.io/ink-lab/privacidad/en/) ·
[Technical details](docs/privacy.en.md) · Support: **dev@mainshai.com**.

## What's new

See [CHANGELOG.md](CHANGELOG.md).

## Contributing

Bug reports, ideas and translations are welcome. How to build, test and
contribute: [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Code under [MIT](LICENSE), Copyright (c) 2026 Daniel Mont Ferrandiz. Own
documentation and texts: [CC BY-SA 4.0](LICENSE-CONTENT.md). The catalogue
data are third-party factual references and fall outside both MIT and CC BY-SA
4.0; the typefaces (SIL OFL 1.1) and other third-party material keep their own
licences, listed in [NOTICE.md](NOTICE.md).

An independent project: **not affiliated with, sponsored by or endorsed by Ohuhu
or DecoTime**. "Ohuhu", "Oahu" and "DecoTime" are trademarks of their owners.
Sources and full notices are in [NOTICE.md](NOTICE.md).

To report a vulnerability: [SECURITY.md](SECURITY.md).
