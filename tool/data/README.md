# Catalog data tooling

`generate_ohuhu.py` rebuilds `assets/data/ohuhu_colors.json`, the Ohuhu
catalog (lines Oahu, Honolulu and Kaala). Standard library only, Python 3.9+.

```
python tool/data/generate_ohuhu.py                       # download and write
python tool/data/generate_ohuhu.py --cache-dir /tmp/csv  # also keep the CSVs
python tool/data/generate_ohuhu.py --from-cache /tmp/csv # offline rebuild
python tool/data/generate_ohuhu.py --check               # exit 1 if the file would change
```

The only network access is HTTPS to `docs.google.com` (redirects to
`*.googleusercontent.com`, Google's own CSV mirror, are followed; anything
else is refused).

## Sources

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
* Pack `source`: `official` = named on Ohuhu's index; `community` = only in
  the community sheet (white cases, 6 packs, Japan sets, `V1/V2` editions,
  Kaala 60 Pastels / 108). The two Honolulu 48 pastel sets could not be
  matched to the official "48 Pastel" / "New 48 Pastel" and are community;
  Honolulu 96 is matched to the official 96 by size only.
* Whether the community-only Oahu/Honolulu packs ship a colourless blender
  is unknown; they are modelled without one.

## Adding or changing a pack

1. Add a row to `SET_DEFS` in the generator (id, line, column, header label,
   named count, blender flag).
2. Add the matching value to `OahuSet` (`lib/core/model/oahu_set.dart`).
3. Re-run the generator; `flutter test test/core` checks that the JSON and
   the enum agree and that member counts match the pack names.
