# Changelog

What changes in each version of Ink Lab, newest first. The "Unreleased" section fills up as changes land and becomes
the next version on the day it ships.

Numbering: the last number goes up with fixes (0.3.1 → 0.3.2), the middle one with new features (→ 0.4.0), and 1.0.0
will be the production launch in the stores. Every version ships on
[GitHub](https://github.com/dferrandizmont/ink-lab/releases); Google Play and the App Store may get several at once,
so they can skip numbers.

## Unreleased

## 0.6.2 · 2026-10-30

- Palette: AI results have a "Report this suggestion" button. You pick a reason and your email app opens with the
  suggestion's codes and texts (never your API key or photos), ready to send to the developer; without an email app
  the report is copied. The privacy policy explains it.

## 0.6.1 · 2026-10-30

- Privacy: with AI off, the app no longer asks Android's ML Kit whether Gemini Nano is available (opening Settings
  used to), so nothing leaves the phone until you turn on AI.
- With AI off, OpenRouter "Test connection" and "Load models" are disabled too, turning AI off stops a Gemini Nano
  download in progress, and Palette no longer re-checks the on-device model on every AI setting change.
- Privacy policy and in-app texts: they now say that on-device AI uses Google's ML Kit, which sends Google usage
  diagnostics (never your prompts, colours or photos), and list exactly what goes to OpenRouter (no marker names, base
  hex or photos).

## 0.6.0 · 2026-10-29

- Palette: the palette type and the scene are chosen from fields that open a list, instead of rows of chips. The scene
  list has a search box, categories and a colour preview for each scene.
- 67 scenes in 11 categories (characters, skin and portraits, sky and water, nature, materials, animals, food,
  holidays, interiors, patterns and fantasy), up from 27. Palettes saved with the old scenes still open.
- Scene from a photo: in Palette → Scenes, "From a photo" takes a photo or picks one from the gallery, finds its main
  colours on the phone and turns them into the closest markers you own. The photo never leaves the phone and is not
  saved; only the marker codes are, if you save the palette.
- Fix: you can now leave Scenes by choosing a colour-theory type again.
- Combinations and paint order show the role above the marker name, each on one line, so long Spanish roles no longer
  break in two. Loaded palettes show their marker names instead of "Loaded palette" on every row.
- Saved palettes made from a scene show the scene's name instead of a colour-theory type.

## 0.5.0 · 2026-10-29

- New app id `es.inklab.app` and new Ink Cross icon. Android sees this as a different app from the 0.4.0 test build:
  export your data from the old build first (Settings → Your data), then uninstall it.
- My markers: one collection per brand, built from the Ohuhu series you use (Oahu, Honolulu, Kaala), the sets you own
  and any extra loose markers. A short first-run guide sets it up, and My collection lets you change it later.
- Switching brand now updates every screen. DecoTime works without sets: you mark the markers you own.
- Swatches opens on your own markers when you have a collection; "All" still shows the whole range.
- Match is honest about distance: it says when nothing you own is close and can search the whole range instead.
- Settings reorganised: My collection, Display, Match colours, AI, Your data and About.
- Ideas redesigned, with technique-correct texts, an idea of the day and palettes that use real roles. Palette lets you
  pick the base colour and undo a change.
- New look: rectangular controls with small corners, Archivo titles, and texts that fit in Spanish and English without
  being cut or wrapped.

## 0.4.0 · 2026-10-29

- On-device AI on Android: the optional AI can now run on the phone with Gemini Nano (ML Kit GenAI Prompt API, through
  Android's AICore). Your scenario and colour codes never leave the phone. If the model is not on the phone yet, the app
  asks Android to download it in the background and shows the progress. The prompt is trimmed to the model's small
  context, code matching is lenient and a partly valid answer still gives you a palette. iOS has no on-device model yet.
- The optional AI texts now tell you which provider is active (on-device or OpenRouter) and what would leave the phone.
- Fix: merged DecoTime names are shown correctly.
- Android: ML Kit registrars are kept under R8, so the release build keeps the on-device AI.
- iOS (in preparation): privacy manifest declaring no tracking and no collected data, and the export-compliance flag so
  the app no longer asks about encryption on every upload. Camera and photo-library texts say photos stay on the phone.
- Internationalisation: the interface texts move to translation files, in Spanish and English.
- Public repository: bilingual (Spanish and English) documentation, privacy policy and GitHub Pages page, content
  licence, security policy, and an exporter that publishes a reviewed selection of the private repository.

## 0.3.1 · 2026-10-29

- Safer storage of the OpenRouter key: the Keystore/Keychain key no longer needs biometrics, which made reading the saved
  key fail on some phones.
- AI suggestions are more robust: tolerant parsing of the model response, one narrower retry, recommended default
  models, colour roles taken from the model, an "AI" tag on suggested palettes, wrapped reasons and a sanitised model
  catalogue. The free/paid filter uses the real pricing.
- Fix: a crash when the settings screen re-listened to a stream.
- "Add my markers" for DecoTime, autocomplete when searching, a clearer model picker, feedback while the AI works and
  the base colour in the palette strip.
- Consistent spacing across screens, based on semantic tokens.

## 0.3.0 · 2026-10-29

New visual design (design G): neutral surfaces, light and dark themes, bundled Inter, Archivo and JetBrains Mono fonts
(SIL OFL 1.1) and Feather-style icons, applied to Swatches, Match, Palette, Ideas and Settings.

- "Add to palette" from a swatch, Ohuhu Oahu card locations and an appearance setting (system, light or dark).
- Pack chips, safe-area handling on every page and a first-run flow that hides the brand flag.

## 0.2.0 · 2026-10-28

Internal test build (private prerelease).

- The optional AI advisor is wired into Settings and Palette, with a disclosure of exactly what leaves the phone before
  you can turn it on, and a model picker.
- Your OpenRouter key is stored in the Android Keystore or the iOS Keychain. Requests go only to `openrouter.ai`, over
  HTTPS, without following redirects; responses are size-capped and sanitised, and any failure falls back to the local
  engine.
- Android: system cloud backup disabled and cleartext traffic refused. Importing a backup never turns the AI on.
- Release builds are signed with an upload key, with R8 minification and a hardened release workflow.

## 0.1.0 · 2026-10-28

First Flutter version, a rewrite of the original Android app for Android and iOS (private prerelease).

- Pure-Dart core: marker models, colour maths (Lab and OKLab), the palette generator (analogous, complementary, split
  complementary, triad, square, rectangle, monochrome, shadow and more) and the Ideas engine.
- Offline catalogues for Ohuhu Oahu (new and legacy codes, packs) and DecoTime (owned-markers selection).
- Swatches, Match (a photo colour to the nearest marker, processed on the device), Palette, Ideas and Settings.
- Local storage, favourites, saved palettes and a plain JSON backup you can export and import.
- Completely free and open source: no account, no ads, no analytics.
