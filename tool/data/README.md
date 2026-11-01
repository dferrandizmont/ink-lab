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
`sets: []`: ownership is selected per marker. Validation requires exactly
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

These `python` suites are run by hand; no CI job runs them (the catalogue suite
does run in `flutter test`).

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
