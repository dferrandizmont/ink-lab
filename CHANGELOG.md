# Changelog

What changes in each version of Ink Lab, newest first. The "Unreleased" section fills up as changes land and becomes
the next version on the day it ships.

Numbering: the last number goes up with fixes (0.3.1 → 0.3.2), the middle one with new features (→ 0.4.0), and 1.0.0
will be the production launch in the stores. Every version ships on
[GitHub](https://github.com/dferrandizmont/ink-lab/releases); Google Play and the App Store may get several at once,
so they can skip numbers.

## 0.9.2 · 2026-11-03

- Swatches with large system text: the grid shows two columns instead of three when the names would not fit, so
  colour names are no longer split inside a word ("Turquoi / se") or cut short. At normal text size nothing changes.

## 0.9.1 · 2026-11-02

Fixes found testing 0.9.0 on a real phone:

- The marker sheet no longer cuts long names ("Cotton Candy Blue" showed as "Cotton Can…" at normal text size): the
  name now uses the full width under the menu and close buttons, up to three lines.
- My collection: the brand is chosen from a list ("Brand  Ohuhu ›"), like the language, instead of a row of tabs that
  looked cut off with four brands.
- Palette: "Colour vision" in the ⋯ menu has its icon, aligned with Share and Clear.

## 0.9.0 · 2026-11-02

- Ideas, tidied up: the list's featured card is now one big tap target (no separate "Open" button) and "Recently viewed"
  is a row that unfolds on demand instead of a block that always takes space. The idea sheet has been reordered: name,
  heart and the ⋯ menu on top, then a one-line summary, the markers it uses as a strip of colours, one clear
  full-width button to use the idea, and only then the rest folded away — the full list of named markers behind its
  count, and what you practise, what to draw, a tip and what you need behind "More details". Everything is reachable
  with a screen reader and stays inside the sheet at every text size.
- Diary (Ideas › Diary): the entry form starts with Title, Photos and Markers used, and then Status; "Painted on",
  Date (today by default), Palette and Notes move into a folded "More details" group, open only when one of them already
  has a value. Share and Delete entry move to the "⋯" menu in the header and "Save entry" is the only primary button.
  In the list, "Add to diary" is now the segment's primary action in the same 48 dp slot the search field uses in Ideas,
  so nothing moves when you switch segment, and "Palettes you link most" is folded, like "unused" already was.
- My collection: the page is now three groups of caps headings — "What you own" (the brand switch, the summary, and
  the series, the sets and the loose markers folded into summary rows that unfold what they hold), "Shopping" (what to
  buy next, showing the three first suggestions and a "See all" that opens the full ranking in a sheet; the wishlist
  and the dried-out markers, folded behind their counts) and "Tools" (the printable swatch chart, folded behind its
  marker and page count). "Reset collection" is a text button in the error colour. The section titles, the counts and
  every shortcut stay the same.
- Match: the screen is quieter and the buttons stay put. The camera and the gallery sit in a fixed row right under the
  photo, as small secondary buttons, with "Fix white balance" as a text button at the right; the row is the same with
  or without a photo, so taking a picture never moves it. The sampled colour shows only its hex, the alternatives lose
  the "ΔE 76" note, the best marker of the whole range is folded (its code and distance are in the summary), a marker
  that is not in the collection says so in a quiet line instead of a badge, and the recent picks show one row of six
  with "See all (n)" opening the rest in a sheet.
- Settings: the lists that could grow are not painted in the page any more. "Favourites" is now a row with the number
  of colours and a chevron; tapping it opens a draggable sheet with the list, where every colour can be removed and
  where the "⋯" menu clears them all. Settings is exactly as long with 40 favourites as with none.
- Settings: the backup card has one clear order. "Save backup file" is the primary button, "Restore from file" the
  secondary one, and the copy as text (without photos) is folded in a block of its own, with Export and Import inside.
- Settings: the AI card only shows the switch and one line of explanation while the AI is off. The provider, the key
  and the built-in fallback come when it is turned on.
- Palette: the saved palettes leave the page. A bookmark button in the header ("Saved palettes") opens them in a
  selector sheet: tap a row to load it, and its "⋯" holds Share, Add to diary and Delete. The result has one "⋯" for
  Share, Colour vision, Report (with AI) and Clear, so the page shows one primary button ("Save palette") and one
  secondary. The paint order folds away, the notes are single lines without cards, and the base marker and Size share
  a row when they fit.
- Swatches: the marker sheet is calmer. It opens at half height and you drag it up for the rest. The star sits beside
  the name, tapping the hex copies it, and there is one main action (add to palette, or the wishlist for another
  brand); copy, blending chain, wishlist, dried out and "back to catalogue colour" moved to a "⋯" menu. "My colour" is
  one compact row, "Closest alternatives" and "Details" fold away, and "In other brands" shows one folded group per
  brand with only its best match (small text and dots instead of the wide "Approximate" bar).
- Swatches: the grid is lighter. A cell shows the code and the name, without the hex (it stays in the list view and in
  the detail sheet), so the cells are lower and more colours fit on the screen. The owned ✓ only shows with the "All"
  filter: with "Mine" (or "Favourites") every cell would carry it and it would say nothing. The subtitle of the header
  says the brand and its series instead of repeating a count that is already on the title line, and the header reserves
  the room of the tallest subtitle, so changing the collection moves nothing.
- Polish after the review: nothing jumps any more. "Add to diary" really sits in the same 48 dp slot as the search field
  of Ideas, so switching between Ideas and Diary does not move the list 4 dp; the diary form takes its photos with the
  same small secondary buttons as Match; in the palette the secondaries ("Generate"/"Regenerate" and "Suggest with AI")
  share one row and are all the same size, with "Save palette" alone on its own full-width row below — the row is
  already there before there is a result, so the result never pushes anything — and in the marker sheet the hex keeps
  its 44 dp tap target without forcing the line to grow, while the star leaves the same room at the right as the code,
  so it never ends up under the "⋯" or the ✕ of the sheet.

## 0.8.1 · 2026-11-01

- Language: Settings > Display shows one "Language" row with the current choice (in its own name) instead of a list of
  radio buttons. Tapping it opens a scrollable picker: System first, then every language by its own name, the current
  one ticked; choosing one applies it at once and closes the picker. The list can grow to many more languages without
  taking over the page.
- Nothing jumps when you switch: on the Ideas tab the "Ideas | Diary" control no longer moves up and down because the
  subtitle above it has one line in one view and two in the other. The header reserves the room of the tallest subtitle
  in every language, width and text size. The same fix is in Palette (switching the type changed the subtitle and moved
  the type field) and in the AI model picker (the Free | Paid | Both control moved when the filter shortened the list).
- Tests: a reusable layout-stability helper records where each control sits for every segment and checks they are
  identical in the six languages, at 360 and 412 dp and at text scale 1.0 and 1.3; it covers Ideas | Diary, the Palette
  type, the My collection brand selector, the Swatches filters, Settings > Appearance and the AI model picker.

## 0.8.0 · 2026-11-01

- Finecolour: 480 alcohol-marker colours, selected one by one in setup and My collection,
  available in Swatches, Match, Palette, Ideas, purchase suggestions, blending chains,
  own colours and backups. Pinned MIT source bundled for offline regeneration.

- Data quality: the test suite now validates every bundled colour catalogue on
  its own (it discovers `assets/data/*_colors.json`, so a brand added later is
  checked too): JSON shape, non-empty codes and names, six-digit hex values,
  unique codes and entries, set/line ids the app knows, the Oahu card
  locations and that a legacy Ohuhu code never repeats inside one product line.
  The Copic and Finecolour generators are also checked offline against pinned
  full-source snapshots, and the Ohuhu generator against its pure helpers. The catalogue
  suite runs in the ordinary `flutter test`; the three generator suites are run
  by hand with plain `python`. Nothing here needs network, new packages or CI.
- Brand equivalents: the detail sheet of a marker (Swatches) has an "In other brands" section with the closest markers of
  every other brand (three each): swatch, code, name, how far it is and the same wording the app uses elsewhere
  ("nearly exact", "very close"…). Your own colours are the ones that count, and "Only mine" limits the list to the
  markers you own and leaves out the dried-out ones. Tapping one opens that marker in the same sheet, with its brand
  named; a marker of another brand cannot be added to a palette, which only holds the brand chosen in Settings.
- Colour vision: on the Palette page (any palette type, blending chains and the saved palettes) a "Colour vision"
  control previews the palette as a person with protanopia, deuteranopia, tritanopia or achromatopsia sees it, and
  names the pairs of colours that become hard to tell apart. It only changes what is drawn: saving and sharing keep the
  true colours.
- Artwork diary numbers: the Diary segment starts with a summary card ("12 artworks · 9 finished · 3 in progress", with the
  markers you use most as small swatches). Tap it for the numbers: entries per month, finished against still in
  progress, your ten most used markers, how many of the markers you own you have never used (with the list on request)
  and the saved palettes you link most.
- Share a diary entry as an image: the entry page has a Share button that draws the title, date, what it was painted on,
  status, the first photo, the markers used and the linked palette's colours on a light image like the palette one, and
  opens the share sheet. Only when you tap it; the photo stays on your phone otherwise.
- Ideas: every idea has a heart, on its card and in its sheet. A new "Favourites" filter next to the categories shows only
  the ideas you hearted (with a hint when there are none yet), and a "Recently viewed" row on top of the list brings back
  the last ideas you opened, newest first. Both are kept on the phone and go in the backup; older backups still import.
- Backup to a file: Settings > Your data > Backup file has "Save backup file", which makes a ZIP with the whole backup and
  the photos of the artwork diary and opens the share sheet to save it to Files, Drive or any app (the clipboard copy stays),
  and "Restore from file", which asks you to pick the ZIP and confirm before it replaces your data, photos included (the
  diary photos that are not in the file are deleted). It shows progress and a short message when the file is not a backup
  (not a ZIP, too big, damaged, a photo that is not an image). The file is checked whole before anything is written, and a
  photo that cannot be written leaves your data as it was. New package: file_selector (flutter.dev) for the file picker.

## 0.7.1 · 2026-11-01

- Match and a marker's own colour: a portrait photo now fills the photo box instead of showing as a narrow strip
  between empty bars, so it is easier to see and to tap the colour you want. Landscape photos look as before.
- Swatches: with a large system font size, the second line of long marker names ("Robin's Egg Blue") is no longer cut
  at the bottom of the card; the cells grow with the text size.

## 0.7.0 · 2026-11-01

- Copic: 358 colours, with individual marker selection in setup and My collection, available throughout the app and
  in backups.
- Match: "Fix white balance" under the photo. Tap a point that should be white paper and every colour you sample from
  that photo is corrected to match (a point that is too dark or too coloured to be paper is refused). It applies to
  that photo only; "Undo" brings the original colours back.
- Your own colour for each marker: the catalogue colour is only an estimate of the ink on paper, so in a marker's
  detail you can set the colour you really get, typing its hex or tapping the painted swatch in a photo (with the same
  white balance fix). The detail shows both colours side by side and can go back to the catalogue. Photos are never
  saved, only the colour.
- Match, Palette (colour theory, scenes and scene from a photo), Ideas and Swatches use your colours, marked with a small
  corner square. Settings > Colour matching has a "Use my colours" switch (on by default), how many you have and a
  way to reset them all. They are part of the backup; older backups still import. The OpenRouter request still sends
  only catalogue colours.
- Settings > About: "Join the Google Play beta" with the link to copy.
- Palette: a "Share" button turns the palette on screen (also AI and scene palettes) or a saved palette into an image
  (1080 px wide, always light) with its title, brand and, for each colour, the role, code, name and hex, and opens the
  system share sheet.
- My collection: "Printable swatch chart" makes A4 pages (300 dpi) with an empty, labelled box for each marker you own,
  in code order, and shares them all at once so you can print or save them. A switch adds a thin strip with the
  catalogue colour in each box.
- Privacy: an image is only handed to the app you pick in the system share sheet; Ink Lab sends nothing anywhere.
- Wishlist: from any marker's detail, "Add to wishlist". My collection has a Wishlist card for the active brand, with
  each marker's code, name and swatch, a button to remove it and "Copy list", which copies a plain-text shopping list
  (brand, code and name per line). A marker leaves the list by itself when you add it to your collection. The wishlist
  is part of the backup; older backups still import.
- Dried out: an owned marker can be marked "Dried out" from its detail. It stays in your collection, shows a small
  struck-through drop in Swatches, and Match, Palette (colour theory, scenes and AI) and Ideas stop suggesting it until
  you mark it usable again. Marking one offers to add it to the wishlist, and My collection has a card with how many
  are dried and the list to see them. Part of the backup too.
- My collection: "What to buy next" ranks the single markers you do not have by how many of the 67 scenes would get a
  closer colour for their roles (a dried-out marker counts as missing), with the two scenes it helps most and a button
  to put it on the wishlist. When two markers help equally, the one that fills the emptiest part of your range goes
  first. It all runs on the phone.
- Palette: a new type, "Blending Chain", for the way alcohol markers are layered. From a base marker it picks three to
  five of your markers of the same colour family, lightest first, with lightness steps that are even and small enough
  to blend (and a short tip to work light to dark while the ink is wet). If your collection has no good chain it says
  which marker you lack (a lighter or a darker one) instead of forcing one, warns when the chain is shorter than the
  size you asked for, offers other chains, and can look in the whole range on request. It saves, shares as an image and
  undoes like any other type, and Swatches > a marker's detail has a "Blending chain" action that opens it.
- The app is now also in German, French, Portuguese and Italian, on top of English and Spanish. It follows the phone's
  language, or you pick one in Settings > Display > Language; scene names, roles, ideas and the privacy policy link
  follow it too.
- Artwork diary: the Ideas tab has a new "Diary" segment, a log of what you paint (a colouring book page, a sheet, a
  sketchbook page, anything). Each entry has a title, a date, what it was painted on, finished or in progress, the
  markers used (picked from your collection), a link to one of your saved palettes, notes and up to four photos
  (camera or gallery, tap for full screen). "Add to diary" also sits on every saved palette (it links the palette
  and its markers) and in an idea's sheet (it fills in the title). Newest first; edit or delete (with a
  confirmation) any entry. Photos are copied into the app's private folder, shrunk to 2048 px, never uploaded or sent
  to the AI features, and deleted with their entry or photo. The entries are part of the backup, the photos are not
  (the backup goes to the clipboard); older backups still import.

## 0.6.3 · 2026-10-31

- Support address is now inklab@mainshai.com (in About, AI suggestion reports and the privacy policy). Mail to
  dev@mainshai.com still arrives.
- About links to the privacy policy on the new website, https://inklab.mainshai.com (the old GitHub Pages
  addresses redirect there).

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
