#!/usr/bin/env python3
"""Generate tool/data/baseline/spectrum_noir_illustrator_chart_colors.json from the official chart.

Source: Spectrum Noir "Classique & Illustrator Dual-Tip colour chart, 216 colours"
(pinned in tool/data/baseline/spectrum_noir_illustrator_chart.pdf, URL in the
.SOURCE.txt next to it). Needs PyMuPDF (`pip install pymupdf`), nothing else.

Codes and names are the chart's own text, matched to each hexagon by position
(the two text lines under it). Hex values are approximate screen colours: the
page is rendered without its text and the median of a 9x9 patch at the centre
of each hexagon is taken. The chart paints its swatches with Pantone spot
colours (Lab alternates) and, for some pale ones, blend modes; MuPDF resolves
both when it renders, so the sample is the colour a person sees in a PDF viewer.
"""

import argparse
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import chart_tools as tools  # noqa: E402

DEFAULT_PDF = HERE / "baseline/spectrum_noir_illustrator_chart.pdf"
DEFAULT_OUT = HERE / "baseline/spectrum_noir_illustrator_chart_colors.json"
EXPECTED_COUNT = 216
# The chart title says "Classique & Illustrator": both ranges share these colours.
LINES = ["classique", "illustrator"]


def extract(pdf_path):
    import fitz
    document = fitz.open(str(pdf_path))
    rows = []
    for number in range(len(document)):
        hexagons = tools.fills(document[number], items=6)
        if not hexagons:
            continue  # uncoloured colouring-in copies and the like
        lines = tools.text_lines(document[number])
        pixmap = tools.render_without_text(document, number)
        # Reading order: rows top to bottom, then left to right.
        hexagons.sort(key=lambda h: (round((h[0].y0 + h[0].y1) / 2 / 20), h[0].x0))
        for rect, _fill, _points in hexagons:
            cx, cy = (rect.x0 + rect.x1) / 2, (rect.y0 + rect.y1) / 2
            label = sorted((l for l in lines
                            if abs((l[1] + l[3]) / 2 - cx) < 30 and rect.y1 < l[2] < rect.y1 + 30),
                           key=lambda l: l[2])
            if len(label) != 2:
                raise ValueError("page %d: expected name and code under the hexagon at "
                                 "x=%.0f, y=%.0f, found %r" % (number + 1, cx, cy, label))
            rows.append((label[0][0], label[1][0], tools.median_hex(pixmap, cx, cy)))
    return rows


def build(rows):
    if len(rows) != EXPECTED_COUNT:
        raise ValueError("expected exactly %d swatches, found %d" % (EXPECTED_COUNT, len(rows)))
    colors, codes = [], set()
    for name, code, hex_value in rows:
        code = code.strip().upper()
        if not code or " " in code:
            raise ValueError("invalid code: %r" % code)
        if code in codes:
            raise ValueError("duplicate code: %s" % code)
        if not name:
            raise ValueError("empty name: %s" % code)
        if not tools.valid_hex(hex_value):
            raise ValueError("invalid hex: %s" % code)
        codes.add(code)
        colors.append({"code": code, "name": name, "hex": hex_value,
                       "sets": [], "lines": list(LINES)})
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
