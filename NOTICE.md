# NOTICE

Ink Lab is an independent, community-driven project. This notice explains the
relationship between this repository and the marker brands whose colour data it
references, and credits the public sources the datasets were compiled from.

## Trademarks and affiliation

"Ohuhu", "Oahu", "DecoTime", "Copic", "Finecolour", "ShinHan", "Touch Twin",
"Winsor & Newton", "Promarker", "Prismacolor Premier", "Spectrum Noir",
"Arrtx", "OROS", "ALP", "ZIG", "Kurecolor", "Kuretake", "Graph'it", "Marvy",
"Le Plume", "Blick Studio Brush" and "Artist's Loft" are trademarks of their
respective owners.
Their logos, product artwork, photographs, packaging and marketing material are the
property of those owners.

This project:

- is **not** affiliated with, associated with, endorsed by, sponsored by or
  approved by any of those brands or their makers (Ohuhu, DecoTime, Copic,
  Finecolour, ShinHan, Winsor & Newton, Prismacolor, Spectrum Noir and
  Crafter's Companion, Arrtx, Kuretake, OZ International, Marvy Uchida, Blick
  Art Materials, Artist's Loft) or any of their subsidiaries or resellers;
- is **not** a product of, or an official tool for, those brands;
- uses marker brand names, marker codes, colour names and hexadecimal colour
  values **only** as factual reference data, so that users can identify the
  markers they already own and the colours those markers produce;
- contains **no** brand artwork, logos, packaging images, colour cards,
  photographs or other brand assets. Every image in this repository is either
  original work or explicitly licensed under the same terms as the repository
  contents.

If you are a trademark owner and believe any part of this repository makes an
incorrect use of your marks, please open a confidential report as described in
[SECURITY.md](SECURITY.md) and it will be handled promptly.

## Third-party software

This project is built with the [Flutter SDK](https://flutter.dev/) and uses the
packages listed in [`pubspec.yaml`](pubspec.yaml). Those dependencies remain
under their own licenses; see `LICENSE` files inside the packages for details.

## Colour data sources

The marker datasets under [`assets/data/`](assets/data) are compiled from the
following publicly available references. They contain codes, colour names and
hexadecimal values only — no artwork is reproduced from any of these sources.

### Ohuhu references

- Oahu set membership sheet (community maintained):
  <https://docs.google.com/spreadsheets/d/1Y4F6jlvxUpsU1CoanMljjwTiW4Ngxk8u2AoxfBuQz_A>
- Unified code + hex sheet used by Ohuhu palette community tooling:
  <https://docs.google.com/spreadsheets/d/e/2PACX-1vTXyBuMZShW6A_T96cn-InrAbiv2ef9C4aEuVBewjqaaSaZ5Y8irlKwE3sKHwf4jA/pub?output=csv>
- Official Ohuhu colour code index:
  <https://ohuhu.com/pages/color-codes-index>
- Official Ohuhu blank colour card download page:
  <https://ohuhu.com/pages/ohuhu-marker-set-blank-color-cards-download>

### DecoTime references

- DecoTime official site: <https://decotime.eu/>
- Twinmarkers colour card (PDF source used for extraction):
  <https://decotime.eu/wp-content/uploads/2021/05/ColourCard-New.pdf>

### Copic references

- Copic colour catalogue by David Aerne: <https://github.com/meodai/copic-colors>
  (revision `b495dad1e26202534d48587bf271aa3c0247f215`). The catalogue uses
  the `hex` values sourced from Copic's site, not `extractedColor`.
- Official Copic colour system: <https://copicmarkers.com/pages/copic-color-system>

The source catalogue is distributed under the following licence:

MIT License

Copyright (c) 2023 David Aerne

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### MarkerMatchDB references

- MarkerMatchDB by GrumpyCockatiel:
  <https://github.com/GrumpyCockatiel/MarkerMatchDB>, revision
  `b6e2afedd85887ecf9d5b9a6dcc34aecf627f68f`, `MarkerMatchDB.csv` (2,804 source rows).
- The full source CSV, byte for byte as published (CRLF line endings kept), and
  its unmodified Apache-2.0 `LICENSE` are bundled. On 2026-11-07 the upstream
  repository no longer answered (HTTP 404 for the repository and the pinned file),
  so these bundled copies are the reference. They are in
  `tool/data/baseline/markermatch_source.csv` and
  `tool/data/baseline/markermatch_source.LICENSE`.
- Colours imported from it (`tool/data/generate_markermatch.py`): the alcohol-marker lines
  `touchTwinMarker` and `touchTwinBrush` (Touch Twin, 202), `winsorPromarker`
  (Promarker, 148), `winsorBrushmarker` (Promarker Brush, 72), `prismaPM` and
  `prismaPB` (Prismacolor Premier, 200), `blickBrush` (Blick Studio Brush, 96)
  and `artistsLoftDTS` (Artist's Loft, 56). Transformations: lowercase hex,
  empty set lists, one Touch Twin record per unambiguous code with both line ids
  as metadata, and Prismacolor's PM primary codes with their PB aliases.
- Used for membership only (codes, never its names or hex): which Copic
  colours Copic Ciao (`copicCiao`, 180) and Copic Classic (`copicClassic`, 214)
  sell, and which colours belong to the classic Spectrum Noir range
  (`spectrumMarkers`, 168 codes). Everything else in those catalogues comes
  from the sources named below.
- Not used: Copic Sketch and Wide, Prismacolor PC, Polychromos, Letraset Tria,
  Tombow and ZIG Brushmarker lines.
- Source defects excluded without inventing corrections: Touch rows 8512/8578
  and 8112/8178, which assign `PB72` to both Napoleon Blue (`3771b4`) and
  Ultramarine (`575aaf`); both conflicting colours are omitted from each Touch
  line. Eight Promarker rows (`Y828` and the greys `CG02`, `CG03`, `CG05`,
  `WG01`, `WG03`, `WG04`, `WG05`) disagree with the Promarker Brush rows of the
  same code on name or colour; each brand keeps its rows as published.
- The source does not state where its hex values come from. They are unverified
  screen references, not official ink measurements; check ink on your paper.
  For Spectrum Noir they were found to be wrong (median 37 per channel away
  from the maker's chart), which is why that brand does not use them.

MarkerMatchDB is licensed under the Apache License, Version 2.0. Attribution:
GrumpyCockatiel and MarkerMatchDB contributors. The upstream licence contains
no completed copyright-owner notice and the repository has no NOTICE file; no
year or additional owner is inferred. The changes made to the data are the
transformations listed above. The derived JSON files retain that source
attribution and licence; the full licence is provided in the bundled file
alongside the source snapshot.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this source data except in compliance with the License. You may obtain a copy
of the License at <https://www.apache.org/licenses/LICENSE-2.0>.
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

### Official colour charts

These brands publish a colour chart (PDF or image). Codes and names are the
chart's own text. **The hexadecimal values are approximate screen colours
sampled from the chart (the colour a viewer shows for each swatch), not
measured ink specifications and not values published by the maker**: a printed
or screen chart can differ from the real ink, and from your paper. Check the
ink on your paper. No chart artwork is redistributed in the public repository;
`tool/data/baseline/*.SOURCE.txt` give each file's URL, retrieval date and
checksum.

- **Spectrum Noir** (Crafter's Companion): one brand with the lines `classic`
  (168), `illustrator` (216) and `triblend` (144), from two charts:
  "Classique & Illustrator Dual-Tip colour chart, 216 colours"
  <https://cdn.shopify.com/s/files/1/0672/5615/6478/files/CLASSIQUE_ILLUSTRATOR_DUAL-TIP_COLOUR_CHART_f2d122c8-a7fa-42ea-8ab1-4ea034d633e1.pdf>
  and "TriBlend 3-in-1 colour chart"
  <https://cdn.shopify.com/s/files/1/0672/5615/6478/files/TRIBLEND_3-IN-1_COLOUR_CHART.pdf>.
  Which colours are in the classic range comes from MarkerMatchDB (above).
  Where the two charts give a different hex for the same code the Illustrator
  chart is used. Pages are rendered with MuPDF and the median of a patch at the
  centre of each swatch is taken (`tool/data/generate_spectrum_noir_*.py`,
  `tool/data/generate_spectrum_noir.py`).
- **Graph'it** (OZ International): "Nuancier 168 couleurs", page 3 of the 2025
  French catalogue <https://graphit-marker.com/CATALOGUE_GRAPHIT_2025_FR.pdf>
  (168 colours). The swatch fills are flat sRGB colours read from the file;
  the maker also publishes HTML/CMYK values on its site, which were not used.
- **Marvy Le Plume** (Marvy Uchida): "Color Spectrum Chart"
  <https://cdn.shopify.com/s/files/1/0035/9723/8387/files/COLOR-SPECTRUM-CHART-pg.pdf>
  (144 colours). Only 22 swatches have a name on the chart; the other 122 show
  their code as their name. The chart is printed artwork: some neighbouring
  colours are identical on it.
- **Arrtx** (OROS and ALP): <https://arrtx.com/pages/arrtx-color-charts> and
  the product pages (328 colours, lines `OROS` and `ALP`). The downloadable
  cards are blank, so codes and names were transcribed by hand and the colours
  sampled from the printed chips of the official OROS 160 and "Color card
  comparison" product images. The 90 colours that only exist in the OROS 160
  set have no published name and show their code as their name.
- **ZIG Kurecolor KC-3000N** (Kuretake): the official "135 colors and Blender"
  chart <https://www.zig-cartoonist.com/images/lineup/colors-136.png>, found on
  <https://www.zig-cartoonist.com/KC-3000N.html> (136 colours). The chart sits
  in an HTML comment of that page, so it may be older than the current range.

### Finecolour references

- Finecolour catalogue by Scott G.F. Hong: <https://github.com/scottgfhong310/finecolour-color>
  (revision `20878c90aed7061e4380d19d0f2206ffd01eefed`,
  `public/apps/finecolour-color/data/finecolour-colors.js`). Only the 480
  alcohol markers (`space == "marker"`) are imported, with English names and
  EF100/EF101/EF102/EF103 availability. Fineliners and acrylics are excluded.
- Hex values are sampled from the maker's chart: approximate screen colours,
  not official ink specifications. Check the ink on your own paper.
- The pinned source and its licence are bundled in `tool/data/baseline/`.

MIT License

Copyright (c) 2026 Scott G.F. Hong

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### How the datasets are produced

The JSON datasets in `assets/data/` are generated by the scripts in
`tool/data/` (see its README for the commands and the pinned sources):
`generate_ohuhu.py`, `generate_copic.py` (Sketch from the pinned
meodai/copic-colors revision, plus the Ciao and Classic membership),
`generate_finecolour.py`, `generate_markermatch.py` (Touch Twin, Promarker,
Promarker Brush, Prismacolor Premier, Blick Studio Brush, Artist's Loft),
`generate_spectrum_noir.py` (merges the two chart extractions and the classic
membership), `generate_graphit.py`, `generate_marvy_le_plume.py`,
`generate_arrtx.py` and `generate_kurecolor.py`. The Copic generator imports
codes, names and official hex values from the pinned meodai/copic-colors
revision above, with no retail set membership. DecoTime
data comes from the colour-card extraction in the previous private codebase;
its generator has not yet been ported. The bundled datasets are the source
of truth for the app. Corrections are contributed through the
[new marker set / data fix](.github/ISSUE_TEMPLATE/data_fix.yml) issue
template.

## Reporting a data or trademark problem

Colour values, marker names and code mappings can drift from the
manufacturer's own documentation. If you find an incorrect entry, please open a
[data fix issue](.github/ISSUE_TEMPLATE/data_fix.yml) with the brand, the
marker code and the value you believe is correct, ideally with a link to a
public source. Trademark concerns should use the private channel in
[SECURITY.md](SECURITY.md) instead of a public issue.

## Photos in the screenshots

The photos shown inside the README and store screenshots are not part of the
app. Both come from Wikimedia Commons and need no attribution; they are credited
here as a courtesy:

- "Matterhorn sunset 2016" by Sam Ferrara (via Unsplash), CC0:
  https://commons.wikimedia.org/wiki/File:Matterhorn_sunset_2016_(Unsplash).jpg
- "Burano - 1" by Luu, public domain:
  https://commons.wikimedia.org/wiki/File:Burano_-_1.JPG

## Bundled fonts

- Inter: Copyright (c) 2016 The Inter Project Authors (https://github.com/rsms/inter).
- Archivo: Copyright 2020 The Archivo Project Authors
  (https://github.com/Omnibus-Type/Archivo).
- JetBrains Mono: Copyright 2020 The JetBrains Mono Project Authors
  (https://github.com/JetBrains/JetBrainsMono).

All three are unmodified variable fonts licensed under the SIL Open Font
License 1.1. Full texts and credits are in `assets/fonts/LICENSE-OFL.md`,
`assets/fonts/OFL-Archivo.txt` and `assets/fonts/OFL-JetBrainsMono.txt`. Fonts
are bundled with the app; nothing is downloaded at runtime.

## Feather icons

The CustomPainter icons in `lib/ui/icons/` are redrawn from Feather
(https://feathericons.com). MIT License, Copyright (c) 2013-2023 Cole Bemis.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
