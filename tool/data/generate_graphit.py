#!/usr/bin/env python3
"""Generate assets/data/graphit_colors.json from the official Graph'it nuancier.

Source: "Nuancier Graph'it - 168 couleurs" in the Graph'it 2025 catalogue (OZ
International), pinned in tool/data/baseline/graphit_nuancier_168.pdf (page 3 of
the catalogue; URL and checksums in the .SOURCE.txt next to it). Needs PyMuPDF
(`pip install pymupdf`), nothing else. The full catalogue PDF also works: the
nuancier page is found by its text.

Each marker cap is a flat filled ellipse with two text lines under it: the
name and the code (GI0xxxx). Codes and names are the chart's own text,
matched to the cap by position. The caps are plain filled shapes in the sRGB
colour space (ICC profile "sRGB IEC 61966-2.1"), so the hex is the fill colour
itself (each channel rounded to 0-255), no conversion needed. The chart warns
that its colours are limited by four-colour printing; the maker publishes
HTML/CMYK values on its own site, which this generator does not use.

The Blender cap is a black-to-white gradient, not a colour: it is recorded as
colourless, ffffff (same convention as Copic 0).

Hex values are approximate screen colours from the official chart.
"""

import argparse
from pathlib import Path
import re
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import chart_tools as tools  # noqa: E402

DEFAULT_PDF = HERE / "baseline/graphit_nuancier_168.pdf"
DEFAULT_OUT = HERE.parents[1] / "assets/data/graphit_colors.json"
EXPECTED_COUNT = 168
CODE = re.compile(r"GI\d{4,5}")
BLENDER_CODE = "GI0000"


def find_page(document):
    """The nuancier page: the one with 168 distinct Graph'it codes."""
    for number in range(len(document)):
        text = document[number].get_text()
        found = set(CODE.findall(text))
        if "NUANCIER" in text.upper() and len(found) >= EXPECTED_COUNT:
            return number
    raise ValueError("nuancier page not found")


def extract(pdf_path):
    """Return [(code, name, hex)] in reading order (rows, then left to right)."""
    import fitz
    document = fitz.open(str(pdf_path))
    number = find_page(document)
    page = document[number]
    lines = tools.text_lines(page)
    caps = tools.fills(page, items=4, max_width=60)
    codes = sorted((l for l in lines if CODE.fullmatch(l[0])),
                   key=lambda l: (round(l[2] / 20), l[1]))
    rows = []
    for text, x0, y0, x1, y1 in codes:
        cx = (x0 + x1) / 2
        # The name is the text line right above the code, centred on it.
        names = [l for l in lines
                 if abs((l[1] + l[3]) / 2 - cx) < 12 and 0 < y0 - l[2] < 14
                 and not CODE.fullmatch(l[0])]
        if len(names) != 1:
            raise ValueError("%s: expected one name above the code, found %r" % (text, names))
        name = names[0][0]
        if text == BLENDER_CODE:
            rows.append((text, name, "ffffff"))
            continue
        # The cap above the name: horizontally centred on the label.
        above = [c for c in caps
                 if abs((c[0].x0 + c[0].x1) / 2 - cx) < 6 and -5 < names[0][2] - c[0].y1 < 25]
        if len(above) != 1:
            raise ValueError("%s: expected one cap above the label, found %d" % (text, len(above)))
        rows.append((text, name, "%02x%02x%02x" % above[0][1]))
    return rows


def build(rows):
    if len(rows) != EXPECTED_COUNT:
        raise ValueError("expected exactly %d colours, found %d" % (EXPECTED_COUNT, len(rows)))
    colors, codes = [], set()
    for code, name, hex_value in rows:
        if code in codes:
            raise ValueError("duplicate code: %s" % code)
        if not name:
            raise ValueError("empty name: %s" % code)
        if not tools.valid_hex(hex_value):
            raise ValueError("invalid hex: %s" % code)
        codes.add(code)
        colors.append({"code": code, "name": name, "hex": hex_value, "sets": []})
    return colors


def render(colors):
    return tools.render_json(colors)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--from-file", type=Path, default=DEFAULT_PDF,
                        help="nuancier PDF (default: the pinned baseline)")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    try:
        text = render(build(extract(args.from_file)))
    except (OSError, ValueError, RuntimeError) as error:
        print("Generation failed: %s" % error, file=sys.stderr)
        return 1
    return tools.check_or_write(text, args.out, args.check, "%d colours" % EXPECTED_COUNT)


if __name__ == "__main__":
    sys.exit(main())
