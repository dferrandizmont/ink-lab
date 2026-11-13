# Catalog data tooling

`generate_ohuhu.py` rebuilds `assets/data/ohuhu_colors.json`, the Ohuhu
catalog (lines Oahu, Honolulu and Kaala). Standard library only, Python 3.9+.

```
python tool/data/generate_ohuhu.py                       # download and write
python tool/data/generate_ohuhu.py --cache-dir /tmp/csv  # also keep the CSVs
python tool/data/generate_ohuhu.py --from-cache /tmp/csv # offline rebuild
python tool/data/generate_ohuhu.py --check               # exit 1 if the file would change
```

The Ohuhu generator's only network access is HTTPS to `docs.google.com` (redirects to
`*.googleusercontent.com`, Google's own CSV mirror, are followed; anything
else is refused).

## Sources

### Copic

`generate_copic.py` rebuilds `assets/data/copic_colors.json` using only the
Python 3.9+ standard library. The source is `colors.json` from
<https://github.com/meodai/copic-colors>, pinned to commit
`b495dad1e26202534d48587bf271aa3c0247f215` in the script. The default download
is HTTPS from `raw.githubusercontent.com`; it does not scrape Copic's sites.

```
python tool/data/generate_copic.py
python tool/data/generate_copic.py --from-file /tmp/colors.json
python tool/data/generate_copic.py --from-file /tmp/colors.json --check
python -B tool/data/test_generate_copic.py
```

`baseline/copic_colors_source.json` is the full upstream `colors.json` at the
pinned commit, kept offline (all eight upstream fields; the generator imports
only `number`, `name` and the official `hex` and ignores the rest). The MIT
source allows bundling it, and the test feeds it back through the generator to
prove it still reproduces the committed `copic_colors.json` byte for byte. Its
LICENSE ships as `baseline/copic_colors_source.LICENSE`.

The output keeps source order and imports only `number` as `code`, `name`
and the official `hex` field (never `extractedColor`). Every record has
`sets: []`: ownership is selected per marker, and `lines` (`sketch`, `ciao`,
`classic`) from MarkerMatchDB, see "Copic product lines" below. Validation requires exactly
358 unique codes, non-empty names, six lowercase hex digits and the
colourless blender `0`. The source is MIT, Copyright (c) 2023 David Aerne;
the full notice is reproduced in [NOTICE.md](../../NOTICE.md).

### Ohuhu

| What | Source |
|---|---|
| Codes, names, per-line legacy codes, set membership | Community sheet "The BIG Ohuhu Legend" (MysticSparkleWings), tab "Oahu Set Comparison": `https://docs.google.com/spreadsheets/d/1Y4F6jlvxUpsU1CoanMljjwTiW4Ngxk8u2AoxfBuQz_A` |
| Hex colours | Community hex sheet (published CSV): `https://docs.google.com/spreadsheets/d/e/2PACX-1vTXyBuMZShW6A_T96cn-InrAbiv2ef9C4aEuVBewjqaaSaZ5Y8irlKwE3sKHwf4jA/pub?output=csv` |
| Which packs are official | Ohuhu's colour-codes index, `https://ohuhu.com/pages/color-codes-index` (checked 2026-10-29 during research; not fetched by the generator) |

## Licence notes

The catalog contains factual data only (product codes, colour names, packs,
approximate hex values). Brand and product names (Ohuhu, Oahu, Honolulu,
Kaala, DecoTime) are trademarks of their owners; this project is not
affiliated with them. The spreadsheets are community work published without
an explicit licence: credit the authors, keep the links above, and do not
bundle their text or formatting. If an owner asks for removal, remove it.

## Output rules

* Order: the 321 baseline colours first, in their frozen baseline order (so
  existing lists do not move), then every added colour in natural code order
  (same rule as `lib/core/natural_sort.dart`, ties by plain string order).
  Set ids follow the order of `SET_DEFS`; JSON keys have a fixed order; LF
  line endings.
* Record: `newCode, newName, oldCode, oldName, hex, lines, sets`.
  `oldCode/oldName` come from Oahu, else Honolulu, else Kaala.
* `lines` lists `oahu`, `honolulu`, `kaala`: the line has a legacy code for
  the colour or a pack of that line contains it. All three lines share one
  code system (since 2023), so one record serves all lines.
* **Baseline.** `baseline/oahu_colors_v1.json` is the frozen pre-lines Oahu
  catalog (321 colours). Their name, old code/name and hex are taken from
  it, and the membership of the 12 original Oahu packs must equal it. If the
  live sheet disagrees the generator prints a `DRIFT` warning and keeps the
  baseline. `test/core/ohuhu_catalog_test.dart` compares the output with it.
* A colour that belongs to no imported pack is skipped (and listed).
* A pack whose marker count differs from the count in its name is skipped and
  reported, never "fixed".
* The generator verifies the sheet layout (column labels) and stops if the
  columns moved.

## Known gaps (2026-10-29 run)

* 40 colours that are in no pack of the sheet are not imported: 26 exist only
  in Ohuhu's colour index (old Kaala codes such as `BG25`, shown as `?`), 14
  have no legacy code at all (`B00 Ice`, `BV30 Snow`, `Y40 Lemon Meringue`,
  ...). They are probably unreleased or open-stock only; re-run the generator
  when the sheet assigns them a pack.
* Packs deliberately not imported: Honolulu 6/12 packs, coloring-book kits,
  gift bags, collaborations (Jazza, Bobbie Goods, Coco Wyo, Creachick, Jade
  Summer), S series (pre-2026), Plus 24/36 (separate code system), Plastic
  Box 60. Add a `SET_DEFS` row (and an `OahuSet` value) to import one.
* "Honolulu 24 Skin Tones (Discontinued)" has 23 markers for a name that
  says 24: skipped, mismatch reported by the generator.
* Hex values are community data. The hex sheet has shifted rows in places
  (upstream currently shows the Fluorescent Violet value on `FY03` and has no
  `FY04`); the baseline keeps the correct historical values. Values for the
  182 added colours could not be checked against Ohuhu and are unverified.
* Upstream renamed `BV415` to "Antwerp"; the baseline name "Antwerp Blue" is
  kept.
* Pack `source`: `official` = sold on ohuhu.com or named on Ohuhu's index;
  `community` = only in the community sheet (white cases, Japan sets,
  `V1/V2` editions, Kaala 60 Pastels). Honolulu 96 is matched to the
  official 96 Pastel by size only.
* Fixes of 2026-10-29, from official sources only (brand research):
  Honolulu 48 Pastel (Sweetness) and New 48 Pastel (Blossoming) are
  official; the 6 packs (Basic / Pastel / Skin) are sold as "Honolulu 6
  Colors" and belong to the Honolulu line (ids `basic_6`, `pastel_6`,
  `skin_6` are kept because they are persisted; BV27, Y08 and E613 gain the
  Honolulu line); Kaala 108 Basic is official (2025-09). DecoTime code 33 is
  "Pineapple" on the official colour card (`decotime_colors.json`, which has
  no generator).
* Whether the community-only Oahu/Honolulu packs ship a colourless blender
  is unknown; they are modelled without one.

## Open questions

Left unchanged until an official source settles them:

* **Blender in sets.** Ohuhu's texts say every Honolulu set and the Oahu
  add-ons (36 Skin, 36 Gray, 48 Pastel) ship "plus a colourless blender";
  here only the Oahu classic sets include code 0.
* **Oahu 40 count.** The product text says "40 colors including a colorless
  blender" (39 + blender); `classic_40` has 40 + blender. Check the oahu-40
  PDF on the colour-codes index.
* **Kaala 60 Pastels.** No official product exists; kept as community data.
* **Honolulu 6 packs membership.** The sheet lists them in its Oahu section;
  whether they equal the official Honolulu 6 Colors is unverified.
* **Honolulu B / S / 2.** Ohuhu says Honolulu B has the same palette;
  Honolulu S and Honolulu 2 reuse the set names and codes, but no membership
  list is published. The app treats them as Honolulu (a note in My
  collection), not as separate sets.
* **DecoTime sets.** Action sells 100 / 150 / 160 / 200 / 300 sets; no source
  lists their colours, so the app shows the sizes as a hint and offers
  colour families, never auto-filled sets.

## Automating the checks

The generated data is covered offline, with no network, by two suites: the
catalogue itself and the generators. Run `flutter test
test/data/catalog_validation_test.dart` (it also runs as part of the plain
`flutter test` suite) to list every `assets/data/*_colors.json`, parse each
brand the way the app does and check codes, names, hex values, unique entries,
known set/line ids, the card locations and that a legacy Ohuhu code never
repeats inside a single product line.

The generators have a separate `python` suite each (Finecolour commands are
in its section below). `python -B
tool/data/test_generate_copic.py` checks that the Copic generator, from its
pinned offline snapshot, still reproduces the committed `copic_colors.json`
byte for byte. `python -B tool/data/test_generate_ohuhu.py` checks only the
Ohuhu generator's pure helpers (natural ordering, text and hex cleaning, the
sheet-layout guard and the download-host restriction): its community Google
Sheets have no explicit licence, so no snapshot is bundled and its `build()`
and `render()` output is not regenerated (the committed Ohuhu file is covered
by the catalogue suite above and by `test/core/ohuhu_catalog_test.dart`). The
Copic snapshot is the upstream `colors.json` at the pinned commit, bundled with
its MIT licence (`baseline/copic_colors_source.LICENSE`).

To run every generator suite at once (about 30 s; the chart ones need PyMuPDF and
Pillow and the private `baseline/` binaries):

```sh
for t in tool/data/test_generate_*.py; do python -I -B "$t" || break; done
```

`test/core/all_brands_catalog_test.dart` pins the exact size of the fifteen
catalogues (3,420 colours), the product lines and the stable brand ids.

These `python` suites are run by hand; no CI job runs them (the catalogue suites
do run in `flutter test`).

## Adding or changing a pack

1. Add a row to `SET_DEFS` in the generator (id, line, column, header label,
   named count, blender flag).
2. Add the matching value to `OahuSet` (`lib/core/model/oahu_set.dart`).
3. Re-run the generator; `flutter test test/core` checks that the JSON and
   the enum agree and that member counts match the pack names.

## Finecolour (480 alcohol markers)

Source: [scottgfhong310/finecolour-color](https://github.com/scottgfhong310/finecolour-color),
pinned at `20878c90aed7061e4380d19d0f2206ffd01eefed`, file
`public/apps/finecolour-color/data/finecolour-colors.js`. MIT License,
Copyright (c) 2026 Scott G.F. Hong (full notice in `NOTICE.md`). The exact
source and LICENSE are bundled as `baseline/finecolour_colors_source.js`
and `baseline/finecolour_colors_source.LICENSE`.

`generate_finecolour.py` downloads only that pinned raw GitHub URL. It strips
the `window.FINECOLOUR_COLORS` assignment and parses strict JSON, never eval.
It imports only `space == "marker"`: 480 unique codes, non-empty English
names and six-digit hex values. Fineliners and acrylics are excluded. Hex
values are sampled from the maker's chart and are approximate, not measured
ink specifications. EF100/EF101/EF102/EF103 availability is retained in
`lines`; `sets` is empty and ownership is selected marker by marker, like Copic.

```sh
python -B tool/data/generate_finecolour.py
python -B tool/data/generate_finecolour.py --from-file tool/data/baseline/finecolour_colors_source.js --check
python -B tool/data/test_generate_finecolour.py
```

The offline test regenerates the committed JSON byte for byte and checks
space filtering, malformed input and the pinned download restriction.

## MarkerMatchDB: six alcohol-marker brands, plus line membership

`generate_markermatch.py` (stdlib only, Python 3.9+) reads MarkerMatchDB by
GrumpyCockatiel, Apache-2.0, pinned to commit `b6e2afedd85887ecf9d5b9a6dcc34aecf627f68f`.
The 2,804-row CSV and licence are stored in
`baseline/markermatch_source.csv` and `baseline/markermatch_source.LICENSE`.
**The CSV keeps the bytes of the upstream file (CRLF line endings).** A
`.gitattributes` rule (`-text`) stops Git from converting them, and the test
checks the sha256, so a regenerated or re-saved copy cannot slip in.
Only the pinned HTTPS URL on `raw.githubusercontent.com` is fetched;
redirects away from that exact URL are rejected before following them.
**On 2026-11-07 that URL answered 404 (the upstream repository was gone), so the
download no longer works: always pass `--from-file` with the bundled snapshot,
which is now the only copy we know of.**

```sh
python -B tool/data/generate_markermatch.py
python -B tool/data/generate_markermatch.py --from-file tool/data/baseline/markermatch_source.csv
python -B tool/data/generate_markermatch.py --from-file tool/data/baseline/markermatch_source.csv --check
```

`--out DIRECTORY` chooses the output directory for all six JSON files.
`--check` compares bytes without writing. Validation finishes for all six
catalogues before writing; codes must be unique, names non-empty, hex six
lowercase digits, and counts exactly:

| Asset | Colours | Selected source lines |
| --- | ---: | --- |
| `touch_twin_colors.json` | 202 | `touchTwinMarker`, `touchTwinBrush` |
| `promarker_colors.json` | 148 | `winsorPromarker` |
| `promarker_brush_colors.json` | 72 | `winsorBrushmarker` |
| `prismacolor_colors.json` | 200 | `prismaPM`, `prismaPB` |
| `blick_brush_colors.json` | 96 | `blickBrush` (Blick Studio Brush) |
| `artists_loft_colors.json` | 56 | `artistsLoftDTS` (Artist's Loft dual tip) |

Skipped on purpose: Copic Sketch and Wide, Prismacolor PC, Polychromos, Letraset
Tria, Tombow and ZIG Brushmarker (`zigBM`).

* **Touch Twin.** Marker and brush codes, names and hex agree. Each colour lists both
  source line ids in `lines` (`touchTwinMarker`, `touchTwinBrush`). Ownership is
  selected marker by marker.
* **Prismacolor Premier.** PM/PB colours agree; one record uses the source PM code
  with the source's space dropped, `PM23`) and the PB alias as `oldCode` (`PB23`),
  which the existing search and palette resolver support; typing `PM 23` with a
  space finds it too.
* **Promarker Brush is its own brand** (`promarker_brush`), not a line of Promarker.
  The two ranges do not line up: 15 of the 72 Brushmarker codes do not exist in
  Promarker's 148, and 8 of the 57 shared codes carry a different name and colour
  (`Y828` and the greys `CG02`, `CG03`, `CG05`, `WG01`, `WG03`, `WG04`, `WG05`, where
  Promarker has "Ice Grey 5" dark and Brushmarker "Cool Grey 2" light under the same
  code). Putting them in one brand would make one code two colours. The grey rows
  of Promarker itself look unreliable in the source (the same code is a dark
  "Ice Grey 5" there and a pale "Cool Grey 2" in the brush list); they are kept as
  published.
* **Blick Studio Brush and Artist's Loft.** Plain catalogues, codes such as `069`
  keep their leading zeros as text.
* All `sets` are empty.

Two source rows per Touch line are excluded and reported: both conflicting `PB72`
entries (rows 8512/8578 and 8112/8178: Napoleon Blue `3771b4`, Ultramarine
`575aaf`). Neither hex is chosen for the ambiguous code; no code is invented.
The source does not explain its hex provenance; these are unverified screen
references (see `NOTICE.md`).

**Membership only.** `line_codes(rows, line)` returns the codes of one source line
without looking at hex or names. Other generators use it, never the source's
colours: `generate_copic.py` (Copic Ciao 180, Copic Classic 214) and
`generate_spectrum_noir.py` (the 168 classic Spectrum Noir codes). Spectrum Noir is
not generated from this file because its hex values are wrong (median 37 per
channel away from the maker's chart) and its names are only codes.

```sh
python -B tool/data/test_generate_markermatch.py
flutter test --no-pub test/core/all_brands_catalog_test.dart test/data/all_brands_backup_test.dart test/ui/onboarding/all_brands_onboarding_test.dart
```

The Python tests reproduce the six committed JSONs byte for byte from the
full offline baseline and cover validation, filtering, membership, download
restrictions, `--check` and the CSV's bytes. The Dart tests cover all fifteen
catalogues, ownership, matching, equivalents across all brands, onboarding and
backup.

## Copic product lines (Sketch, Ciao, Classic)

`copic_colors.json` is still the Sketch range (358). Each record now has
`lines`: `["sketch"]` plus `"ciao"` (180 colours) and/or `"classic"` (214). The
membership comes from MarkerMatchDB's `copicCiao` and `copicClassic` lines (codes
only; every one is a Sketch code with the same name, which the generator checks).
`generate_copic.py` reads it from `baseline/markermatch_source.csv`; `--markermatch`
chooses another file. Colour ids (`copic:<code>`) do not change, so favourites,
owned markers, saved palettes and backups keep working; a payload without `lines`
parses as before. The fluorescent codes (`FB`, `FBG`, ...) are Sketch only.

## Spectrum Noir (one brand, three lines)

`generate_spectrum_noir.py` (stdlib only) writes `assets/data/spectrum_noir_colors.json`
(216 records, keyed by code) from three pinned inputs:

* `baseline/spectrum_noir_illustrator_chart_colors.json`, the official "Classique &
  Illustrator" chart extraction (`generate_spectrum_noir_illustrator.py`): the name
  and hex of every colour.
* `baseline/spectrum_noir_triblend_chart_colors.json`, the TriBlend chart extraction
  (`generate_spectrum_noir_triblend.py`): membership of line `triblend`. A TriBlend
  tone is an ordinary ink code. `FS7` differs between the charts (`fce6d6` vs
  `fae0ce`); the Illustrator chart wins. The 48 marker packs
  (`baseline/spectrum_noir_triblend_chart_markers.json`) are not used by the app.
* `baseline/markermatch_source.csv`: membership of line `classic`.

Lines: `classic` 168, `illustrator` 216 (the whole chart: the Illustrator range is the
classic one plus 48 colours), `triblend` 144. The chart-based files used to live in
`assets/data/`; they are intermediates now, so they are in `baseline/` and are not
bundled. `BLENDER` and `TRUEBLACK` in MarkerMatchDB are `BL` and `TB`; `BT6` (malformed
hex in MarkerMatchDB, on the chart) is included. Official chart names and hex win over
MarkerMatchDB's.

```sh
python -B tool/data/generate_spectrum_noir.py [--check]
python -B tool/data/test_generate_spectrum_noir.py
```

## Arrtx (328 colours: OROS + ALP)

`generate_arrtx.py` rebuilds `assets/data/arrtx_colors.json` offline (Pillow +
standard library) from files pinned in `baseline/`; the URLs, hashes and the
cards each name was read from are in `baseline/arrtx.SOURCE.txt`.

```sh
python -I -B tool/data/generate_arrtx.py
python -I -B tool/data/generate_arrtx.py --check
python -I -B tool/data/test_generate_arrtx.py
```

* **Source.** Arrtx's own published charts
  (<https://arrtx.com/pages/arrtx-color-charts> and the product pages). The
  PDF/JPG cards on the charts page are blank colouring cards (no fill), so
  they give codes and names but no colour; the colours come from the printed
  chips of two official product images: the OROS 160 chart (every code of the
  160 set) and the "Color card comparison" of the OROS 90 page (the 90, 80,
  66 and 48 skin tone sets).
* **Codes and names.** `baseline/arrtx_codes.csv`, a hand transcription
  (the PDFs draw their text as vector outlines, so it was read from 150 dpi
  renders). Codes were read twice independently and agree: the card of each
  set against the chip order of the comparison image (90, 80, 66, 48), and
  the blank OROS 160 card against the 160 chip image. 238 colours have an
  official name (OROS 90B, 80A, 66 and 48 cards; no code has two names).
  **The 90 colours that exist only in the OROS 160 set (codes 502 to 950 and
  the new BG/CG/GG/WG codes of that chart) have no published name.** Their
  name is their code (`502`, not `OROS 502`; column `name_card` is `-`), so the
  app shows the code where a name would be; replace them if Arrtx ever
  publishes names.
* **Hex.** A sample from the printed chip: `x,y` of its centre in the CSV,
  and the generator takes the median of the dominant colour cluster inside a
  patch well within the chip (so the printed code text is ignored). They are
  approximate screen values from the official chart, not measured ink (same
  approach as DecoTime). Chip source per colour: the OROS 160 chart for every
  code that is on it, else the comparison chip (skin tone block first, then
  90, 80, 66). The two images are rendered slightly differently (about 8
  levels of difference on the 70 codes in both), so the groups have a faint
  seam. Code 305 is the exception to the rule: the 160 chart prints the
  colour of "306 Dark Suntan" under 305, so the 48 skin tone card chip
  (light, matching the name "Light Suntan") is used.
* **Lines.** One brand, one record per code, `lines` = `["OROS"]` (102) or
  `["OROS", "ALP"]` (226). Arrtx states that ALP 80/90 and OROS 80/90 are the
  same colours, and the ALP 90B, 80A, 66/40 and 36 cards carry exactly the
  OROS codes and names (ALP 36 skin tone = 301-334 + blender). OROS 160,
  and the 48 skin tone codes 371-389, are OROS only. The only difference
  between the lines is the tip (brush and chisel for OROS, fine and chisel
  for ALP). `sets` is empty; ownership is picked per marker.
* **ALP swatches not used.** The swatch charts on the ALP product pages
  (90, 80, 36) print very different colours for the same codes (mean channel
  difference about 40 against the OROS chips; the 80 chart has typos and
  wrong names, for example WG0.5 as dark brown). They are not used for hex.
* **Names as printed.** Spelling is kept ("Canaria Yellow", "Penoy",
  "Colorless Blender", "Barley Beige Light"). Only "Pale purple" (89) is
  capitalised. The ALP cards differ in a few labels ("27 Powder Pink",
  "304 Barley Beige"); the OROS card name wins.
* The colourless blender `0` is `ffffff`, as in the other catalogues.
* Pillow's JPEG decoder could shift a sample by one level in another
  version; if the byte-for-byte test fails on such a difference, regenerate
  and review the diff.

## ZIG Kurecolor (KC-3000N Twin, 136 swatches)

`generate_kurecolor.py` rebuilds `assets/data/kurecolor_colors.json` offline
from `baseline/kurecolor_colors_136.png`, the official "135 colors and
Blender" chart of Kuretake's ZIG site
(<https://www.zig-cartoonist.com/images/lineup/colors-136.png>, on the
product page `KC-3000N.html`; see `baseline/kurecolor.SOURCE.txt`). The
chart is inside an HTML comment of that page (not displayed), so it may be
older than the current range; its codes match the KC-3000N item codes of
retailers. `baseline/kurecolor_codes.csv` is the hand transcription of code,
name and swatch centre (136 rows); hex is sampled like Arrtx's
(approximate screen values). The printed grey/blender codes `C.01`, `W.01`,
`B.01` are stored without the dot (`C01`, `W01`, `B01`, the item-code form);
`B01` is the colourless blender. Names are the printed upper case names in
title case ("Gray" as printed). One line, so no `lines`; `sets` is empty.

```sh
python -I -B tool/data/generate_kurecolor.py
python -I -B tool/data/generate_kurecolor.py --check
python -I -B tool/data/test_generate_kurecolor.py
```

Both catalogues are registered brands (`arrtx`, with lines `OROS` and `ALP`, and
`kurecolor`); `test/data/catalog_validation_test.dart` checks them with the rest.

## Official PDF colour charts (Graph'it, Spectrum Noir, Marvy Le Plume)

Four generators read the brand's own public colour chart, pinned in
`baseline/` (each PDF has a `.SOURCE.txt` sidecar with the URL, retrieval date
and sha256). They need **PyMuPDF** (`pip install pymupdf`, tested with 1.27.1)
on top of the standard library; nothing is downloaded when they run. They share
`chart_tools.py`. Each has `--check` (exit 1 if the committed JSON would
change), `--from-file <pdf>` and `--out`:

```sh
python -B tool/data/generate_graphit.py [--check]
python -B tool/data/generate_spectrum_noir_illustrator.py [--check]
python -B tool/data/generate_spectrum_noir_triblend.py [--check]
python -B tool/data/generate_marvy_le_plume.py [--check]
python -B tool/data/test_generate_graphit.py        # one test file per generator
```

| Output | Source (pinned in `baseline/`) | Records |
|---|---|---|
| `assets/data/graphit_colors.json` | Graph'it "Nuancier 168 couleurs", page 3 of the 2025 FR catalogue (`graphit_nuancier_168.pdf`; the original is 9.8 MB, only that page is kept, checksums in the sidecar) | 168 (`GI0xxxx`, incl. Blender `GI0000`) |
| `baseline/spectrum_noir_illustrator_chart_colors.json` (intermediate) | Spectrum Noir "Classique & Illustrator Dual-Tip colour chart, 216 colours" (`spectrum_noir_illustrator_chart.pdf`, pages 1-4; 5-8 are uncoloured copies) | 216, `lines: ["classique", "illustrator"]` |
| `baseline/spectrum_noir_triblend_chart_colors.json` + `..._chart_markers.json` (intermediates) | Spectrum Noir "TriBlend 3-in-1 colour chart" (`spectrum_noir_triblend_chart.pdf`, page 1) | 144 tones (`lines: ["triblend"]`) and 48 markers |
| `assets/data/marvy_le_plume_colors.json` | Marvy Uchida Le Plume "Color Spectrum Chart" (`marvy_le_plume_chart.pdf`) | 144 (122 wheel codes + 22 grid swatches) |

**Method.** Codes and names are the chart's own text, matched to a swatch by
position (the text lines under or inside it; ligatures such as "Starfish"
normalised, split numbers such as `CR1 0` re-joined). Hex values are
**approximate screen colours from the official chart**, not measured ink
specifications (same approach as DecoTime):

* Graph'it: the caps are flat shapes in sRGB (ICC "sRGB IEC 61966-2.1"), so the
  hex is the fill colour itself. No CMYK/RGB conversion anywhere.
* Spectrum Noir and Le Plume: the page is rendered at 144 dpi with its text
  removed (PyMuPDF redaction, in memory) and the per-channel median of a 9x9
  patch at the centre of the swatch is taken. The Spectrum Noir charts paint
  swatches with Pantone spot colours (Lab D50 alternates, resolved by MuPDF)
  and, for some pale colours, blend modes, so the vector fill alone is not what
  a viewer shows; rendering handles both. No CMYK is involved in any chart.
  Rendering depends on MuPDF's colour management: another PyMuPDF release can
  shift a value by one step, in which case regenerate and review the diff.
* The charts are printed/screen artwork: neighbouring colours can look alike
  and some are identical on the chart itself (Le Plume `Y615`/`Y625`,
  `G664`/`G668`, `R800`/`R813`, `V750`/`P780`).

**Per-brand notes**

* Graph'it: the Blender cap is a black-to-white gradient, recorded as
  colourless `ffffff` (same as Copic `0`). Names are kept as printed, including
  `Sun (Y)`, `Cyan (C)`, `Magenta (M)`, `Black (K)` and the chart's spellings
  (`Artic Blue`). The chart notes that colours are limited by four-colour
  printing and that the maker publishes HTML/CMYK values on its site; those
  were not used.
* Spectrum Noir Illustrator/Classique: 216 unique codes. 165 of the 167
  classic Spectrum Noir codes of the MarkerMatchDB import (brand "Spectrum
  Noir") are on this chart with the same code; the other two are `BLENDER` ->
  `BL` and `TRUEBLACK` -> `TB`. The remaining 49 codes are not in that import:
  48 new colours (families `AB`, `AG`, `AP`, `BO`, `DP`, `GY`, `MB`, `MG`,
  `PV`, `RB`, `VB`, `YG`) and `BT6`, a classic colour the import lacks
  (it has 167, not 168). So Illustrator/Classique is the classic range plus 48
  colours. The hex values of the 165 shared codes differ a lot from the
  MarkerMatchDB ones (median channel difference 37, up to 131, e.g. `EB1`
  `fdfbee` vs `cc926b` here); the official chart should win.
* Spectrum Noir TriBlend: each marker has 3 tones, and the chart prints the
  ordinary ink code on each tone (`DR1 DR3 DR4`...). All 144 tone codes are
  among the Illustrator 216 and their hex agrees with that chart within 8 steps
  (printing noise). The chart has no TriBlend-specific codes (no `TB-xx-n`), so
  a tone record uses the ink code, and its `name` is the ink's name from the
  Illustrator chart (`DR1` Red). `spectrum_noir_triblend_markers.json` lists the
  48 markers as the chart names them (`Dark Red Blend`, `Coral Shades`) with
  their tone codes in chart order (left, right, bottom). The chart prints
  "True Bluelue Shades" for `TB5/TB6/TB9`: corrected to "True Blue Shades".
* Marvy Le Plume: only the 22 grid swatches (`AG`, `CG`, `N`, `OP`) have names
  on the chart; the 122 wheel colours have only a code, so `name` equals the
  code (nothing invented). `OP920` White and `N900` Blender are drawn as
  outlines without fill and recorded as `ffffff`; `OP921` Gold and `OP922`
  Silver are flat colours on the chart (approximate, not metallic). Output is
  sorted by code number, which groups the colour families.

**Modelling Spectrum Noir.** Decided: one brand "Spectrum Noir" keyed by `code`, with
`lines` `classic`, `illustrator` and `triblend`; see "Spectrum Noir" above.
`generate_spectrum_noir.py` merges the two chart extractions here and the classic
membership of MarkerMatchDB into the one bundled `spectrum_noir_colors.json`.

**Integration.** Graph'it (`graphit`) and Marvy Le Plume (`marvy_le_plume`) are bundled
as they are (`graphit_colors.json`, `marvy_le_plume_colors.json`). The Spectrum Noir
extractions are intermediates in `baseline/`, so `test/data/catalog_validation_test.dart`
(which requires every `assets/data/*_colors.json` to be a registered `MarkerBrand`
declared in `pubspec.yaml`) only sees the merged file.

**Public export.** The brand charts (PDF, JPG, PNG in `baseline/`) are third-party
artwork and the exporter only lets binaries into `assets/`, `docs/readme/` and `test/`,
so they stay in the private repository. The public allowlist carries the generators,
the text baselines and the `*.SOURCE.txt` files (URL, date, sha256) so the method can be
audited; the tests of the chart generators need the binaries and are not exported.
