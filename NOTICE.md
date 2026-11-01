# NOTICE

Ink Lab is an independent, community-driven project. This notice explains the
relationship between this repository and the marker brands whose colour data it
references, and credits the public sources the datasets were compiled from.

## Trademarks and affiliation

"Ohuhu", "Oahu", "DecoTime", "Copic" and "Finecolour" are trademarks of their respective owners.
Their logos, product artwork, photographs, packaging and marketing material are the
property of those owners.

This project:

- is **not** affiliated with, associated with, endorsed by, sponsored by or
  approved by Ohuhu, DecoTime, Copic or Finecolour (or any of their subsidiaries or resellers);
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

The Ohuhu, Copic and Finecolour JSON datasets in `assets/data/` are generated by
`tool/data/generate_ohuhu.py`, `tool/data/generate_copic.py` and
`tool/data/generate_finecolour.py`. The Copic
generator imports codes, names and official hex values from the pinned
meodai/copic-colors revision above, with no retail set membership. DecoTime
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
