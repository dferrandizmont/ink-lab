**English** · [Español](README.es.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Português](README.pt.md) · [Italiano](README.it.md)

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
a colour code, find the marker you own closest to a photo and build colour-theory
palettes with only your markers. Android app with light and dark themes, a tablet
side rail and six languages.

**Free · No ads · No account · Works offline · Open source**

AI is optional and off by default.

## Download

<p>
  <a href="https://play.google.com/apps/testing/es.inklab.app"><img src="https://img.shields.io/badge/Google_Play-Beta-414141?logo=googleplay&amp;style=for-the-badge" alt="Beta on Google Play"></a>
  <a href="https://github.com/dferrandizmont/ink-lab/releases/latest"><img src="https://img.shields.io/badge/Available_on-GitHub-181717?logo=github&amp;style=for-the-badge" alt="Available on GitHub"></a>
  <!--
  <a href="[APP_STORE_LINK]"><img src="https://img.shields.io/badge/App_Store-Download-0D96F6?logo=appstore&amp;style=for-the-badge" alt="Available on the App Store"></a>
  -->
</p>

Android on GitHub, and in closed testing on Google Play. iOS is coming.

<details>
<summary>Join the beta on Google Play</summary>

1. Join [ink-lab-testers](https://groups.google.com/g/ink-lab-testers). Sign in to Google and press «Join group».
2. Accept the test: [play.google.com/apps/testing/es.inklab.app](https://play.google.com/apps/testing/es.inklab.app).
3. Install the app from Google Play. It updates itself.

Stay for 14 days: Google requires 12 testers for 14 days before public release.
Feedback: inklab@mainshai.com.

</details>

<details>
<summary>Install the APK from GitHub</summary>

1. Download the APK and `SHA256SUMS.txt` of the [latest
   release](https://github.com/dferrandizmont/ink-lab/releases/latest). Verify with
   `sha256sum -c SHA256SUMS.txt`.
2. Allow installing apps from unknown sources when your phone asks, then open
   the APK.

</details>

## Screenshots

<p>
  <a href="docs/readme/en/01-swatches.png"><img src="docs/readme/en/01-swatches.png" width="19%" alt="Swatches: the colours of the brand, each with its code and its name"></a>
  <a href="docs/readme/en/02-swatch-detail.png"><img src="docs/readme/en/02-swatch-detail.png" width="19%" alt="A marker's detail: its hex, its closest alternatives and the same colour in other brands"></a>
  <a href="docs/readme/en/03-match.png"><img src="docs/readme/en/03-match.png" width="19%" alt="A colour tapped in a photo, matched to the closest marker of your collection"></a>
  <a href="docs/readme/en/04-palette.png"><img src="docs/readme/en/04-palette.png" width="19%" alt="A scene palette, with the role and the code of every colour"></a>
  <a href="docs/readme/en/05-diary.png"><img src="docs/readme/en/05-diary.png" width="19%" alt="The artwork diary: a summary of your work and the last entries"></a>
</p>

<details>
<summary>More screenshots</summary>

<p>
  <a href="docs/readme/en/06-photo-scene.png"><img src="docs/readme/en/06-photo-scene.png" width="19%" alt="A palette built from the colours of your own photo"></a>
  <a href="docs/readme/en/07-ideas.png"><img src="docs/readme/en/07-ideas.png" width="19%" alt="Ideas: exercises and techniques, with their palettes and your favourites"></a>
  <a href="docs/readme/en/08-collection.png"><img src="docs/readme/en/08-collection.png" width="19%" alt="My collection: what you own, and what to buy next"></a>
  <a href="docs/readme/en/09-settings-dark.png"><img src="docs/readme/en/09-settings-dark.png" width="19%" alt="Settings in the dark theme"></a>
</p>

</details>

Tap a screenshot to enlarge it.

## Features

- **Artwork diary.** A log of what you paint, with its photos, the markers you
  used and the numbers behind it.
- **Four brands.** Ohuhu (503 colours), DecoTime (313), Copic (358) and Finecolour
  (480), with the closest marker of every other brand under «In other brands».
- **Match.** Tap a point in a photo to find the marker you own closest to it, and
  fix the white balance.
- **Palettes and scenes.** Colour-theory harmonies, blending chains, and 67
  ready-made scenes in 11 categories.
- **Backup.** Save everything in a `.zip` file, with the diary photos inside.
- **Shopping.** A wishlist, the markers that dried out, and what to buy next.

<details>
<summary>More features</summary>

- **Colour vision.** Preview a palette as a person with protanopia, deuteranopia,
  tritanopia or achromatopsia sees it.
- **Printable swatch chart.** A4 pages with a labelled box for each marker you own.
- **Ideas.** Exercises and techniques with their own palettes, and your favourites.
- **Swatches and your own colours.** Codes, names and hex values, plus the colour
  your marker really gives.
- **Share.** Send a palette, a chart or a diary entry to another app as an image.
- **AI, if you want it.** Optional palette suggestions: Gemini Nano on the phone,
  or OpenRouter with your own key.

</details>

## Privacy

Data stays on your phone: no accounts, no server of ours, no analytics, no ads or
tracking, and without AI no network use. On-device AI’s ML Kit sends Google usage
diagnostics, never prompts, colours or photos. Camera and gallery access is only
for photo matching, scenes, your own marker colours and the diary; those photos
are processed on the device, and the diary’s stay in the app’s private folder,
never uploaded. Sharing a palette, a chart or the `.zip` backup hands the file to
the app you pick, and nothing else.

[Website](https://inklab.mainshai.com) · [Privacy policy](https://inklab.mainshai.com/privacy/) ·
[Technical details](docs/privacy.en.md) · Support: **inklab@mainshai.com**.

## What's new

Version 0.9.2 is out. The 0.9 series tidied the app up: a calmer marker sheet,
better-ordered screens and fixes for large system text. Full list in
[CHANGELOG.md](CHANGELOG.md) and in the
[releases](https://github.com/dferrandizmont/ink-lab/releases).

## Contributing

Bug reports, ideas and translations are welcome. How to build, test and
contribute: [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Code under [MIT](LICENSE), Copyright (c) 2026 Daniel Mont Ferrandiz. Own
documentation and texts: [CC BY-SA 4.0](LICENSE-CONTENT.md). The catalogue data
are third-party factual references outside both licences; the typefaces (SIL
OFL 1.1) and other third-party material keep their own terms.

An independent project: **not affiliated with, sponsored by or endorsed by Ohuhu,
DecoTime, Copic or Finecolour**. "Ohuhu", "Oahu", "DecoTime", "Copic" and "Finecolour" are trademarks of their owners.
Full notices: [NOTICE.md](NOTICE.md).

To report a vulnerability: [SECURITY.md](SECURITY.md).
