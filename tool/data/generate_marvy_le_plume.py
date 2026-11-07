#!/usr/bin/env python3
"""Generate assets/data/marvy_le_plume_colors.json from the official colour chart.

Source: Marvy Uchida "Color Spectrum Chart" for Le Plume (pinned in
tool/data/baseline/marvy_le_plume_chart.pdf, URL in the .SOURCE.txt next to it).
Needs PyMuPDF (`pip install pymupdf`), nothing else.

The chart is a colour wheel with 122 coded segments plus a grid of 22 neutral
and opaque swatches. Codes are the chart's own text (letters for the colour
range, three digits). Only the grid swatches carry names; for the wheel the
name is the code itself, nothing is invented. Each code is matched to its
swatch by position: the page is rendered without its text and the median of a
9x9 patch at the centre of the code's text is taken (the label sits inside its
own segment). Two grid swatches, OP920 White and N900 Blender, are drawn as
unfilled outlines: they are white (ffffff).

Hex values are approximate screen colours from the official chart.
"""

import argparse
from pathlib import Path
import re
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import chart_tools as tools  # noqa: E402

DEFAULT_PDF = HERE / "baseline/marvy_le_plume_chart.pdf"
DEFAULT_OUT = HERE.parents[1] / "assets/data/marvy_le_plume_colors.json"
EXPECTED_COUNT = 144
EXPECTED_NAMED = 22  # AG, CG, N and OP grid swatches
CODE = re.compile(r"[A-Z]{1,2}\d{3}")
GRID_PREFIXES = ("AG", "CG", "N", "OP")
# Drawn as outlines on the chart, no fill: white paper.
UNFILLED_WHITE = {"OP920", "N900"}


def extract(pdf_path):
    """Return [(code, name or None, hex)] in chart text order."""
    import fitz
    document = fitz.open(str(pdf_path))
    page = document[0]
    words = [w for w in tools.text_words(page) if CODE.fullmatch(w[0])]
    lines = tools.text_lines(page)
    pixmap = tools.render_without_text(document, 0)
    rows = []
    for text, x0, y0, x1, y1 in words:
        name = None
        if text.startswith(GRID_PREFIXES) and re.match(r"(AG|CG|N|OP)\d", text):
            below = [l for l in lines
                     if abs(l[1] - x0) < 3 and y1 - 3 < l[2] < y1 + 10 and not CODE.fullmatch(l[0])]
            if len(below) != 1:
                raise ValueError("%s: expected one name line below the code, found %r"
                                 % (text, below))
            name = below[0][0]
        hex_value = "ffffff" if text in UNFILLED_WHITE else tools.median_hex(
            pixmap, (x0 + x1) / 2, (y0 + y1) / 2)
        rows.append((text, name, hex_value))
    return rows


def code_key(code):
    return (int(re.search(r"\d+", code).group()), code)


def build(rows):
    if len(rows) != EXPECTED_COUNT:
        raise ValueError("expected exactly %d codes, found %d" % (EXPECTED_COUNT, len(rows)))
    if sum(1 for _c, name, _h in rows if name) != EXPECTED_NAMED:
        raise ValueError("expected %d named swatches" % EXPECTED_NAMED)
    colors, codes = [], set()
    for code, name, hex_value in sorted(rows, key=lambda r: code_key(r[0])):
        if code in codes:
            raise ValueError("duplicate code: %s" % code)
        if not tools.valid_hex(hex_value):
            raise ValueError("invalid hex: %s" % code)
        codes.add(code)
        colors.append({"code": code, "name": name or code, "hex": hex_value, "sets": []})
    return colors


def render(colors):
    return tools.render_json(colors)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--from-file", type=Path, default=DEFAULT_PDF,
                        help="chart PDF (default: the pinned baseline)")
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
