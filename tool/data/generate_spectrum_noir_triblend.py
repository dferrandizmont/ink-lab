#!/usr/bin/env python3
"""Generate the Spectrum Noir TriBlend catalogue from the official chart.

Writes two files from the pinned chart tool/data/baseline/spectrum_noir_triblend_chart.pdf:

* tool/data/baseline/spectrum_noir_triblend_chart_colors.json: 144 records, one per tone
  (3 tones in each of the 48 markers). `code` is the tone code printed on the
  chart (it is the code of the ordinary Spectrum Noir ink, e.g. DR1), `name` is
  the name of that ink on the Illustrator chart, `hex` is sampled from the
  TriBlend chart, `lines` is ["triblend"].
* tool/data/baseline/spectrum_noir_triblend_chart_markers.json: the 48 markers, in chart
  order, with the chart's name ("Dark Red Blend") and their 3 tone codes
  (left, right, bottom swatch).

Hex values are approximate screen colours: the page is rendered without its
text and the median of a 9x9 patch at the centre of each swatch is taken.
Needs PyMuPDF; the baseline PDFs are in tool/data/baseline.
"""

import argparse
from pathlib import Path
import re
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import chart_tools as tools  # noqa: E402
import generate_spectrum_noir_illustrator as illustrator  # noqa: E402

DEFAULT_PDF = HERE / "baseline/spectrum_noir_triblend_chart.pdf"
DEFAULT_ILLUSTRATOR_PDF = illustrator.DEFAULT_PDF
DEFAULT_OUT = HERE / "baseline/spectrum_noir_triblend_chart_colors.json"
DEFAULT_MARKERS_OUT = HERE / "baseline/spectrum_noir_triblend_chart_markers.json"
EXPECTED_MARKERS = 48
EXPECTED_TONES = 144
LINES = ["triblend"]
# The chart prints "True Bluelue Shades" (TB5/TB6/TB9); the marker is True Blue Shades.
NAME_FIXES = {"True Bluelue Shades": "True Blue Shades"}
CODE_PATTERN = re.compile(r"[A-Z]{2}\d(\s?\d)?")


def extract(pdf_path):
    """Return [(marker name, [(tone code, hex) x 3])] in chart order."""
    import fitz
    document = fitz.open(str(pdf_path))
    page = document[0]
    lines = tools.text_lines(page)
    quads = tools.fills(page, items=4)
    pixmap = tools.render_without_text(document, 0)
    # The wide bottom swatch of each marker anchors its two upper swatches.
    bottoms = sorted((q for q in quads if q[0].width > 40),
                     key=lambda q: (round(q[0].y0 / 50), q[0].x0))
    markers = []
    for rect, fill, points in bottoms:
        upper = [q for q in quads if q[0].width < 40 and rect.y0 - 40 < q[0].y0 < rect.y0]
        left = [q for q in upper if abs(q[0].x0 - rect.x0) < 2]
        right = [q for q in upper if abs(q[0].x1 - rect.x1) < 2]
        if len(left) != 1 or len(right) != 1:
            raise ValueError("marker at x=%.0f y=%.0f: expected 2 upper swatches, found %d/%d"
                             % (rect.x0, rect.y0, len(left), len(right)))
        tones = []
        for r, _fill, pts in (left[0], right[0], (rect, fill, points)):
            codes = [l[0] for l in lines
                     if r.x0 <= (l[1] + l[3]) / 2 <= r.x1 and r.y0 <= (l[2] + l[4]) / 2 <= r.y1
                     and CODE_PATTERN.fullmatch(l[0])]
            if len(codes) != 1:
                raise ValueError("swatch at x=%.0f y=%.0f: expected one code, found %r"
                                 % (r.x0, r.y0, codes))
            cx = sum(p.x for p in pts) / len(pts)
            cy = sum(p.y for p in pts) / len(pts)
            # The chart prints two-digit numbers with a gap ("CR1 0").
            tones.append((re.sub(r"\s+", "", codes[0]), tools.median_hex(pixmap, cx, cy)))
        cx = (rect.x0 + rect.x1) / 2
        label = sorted((l for l in lines
                        if abs((l[1] + l[3]) / 2 - cx) < 30 and rect.y1 < l[2] < rect.y1 + 45),
                       key=lambda l: l[2])
        name = " ".join(l[0] for l in label)
        markers.append((NAME_FIXES.get(name, name), tones))
    return markers


def illustrator_names(pdf_path):
    return {code.strip().upper(): name for name, code, _hex in illustrator.extract(pdf_path)}


def build(markers, names):
    """Return (colors, marker records), validated."""
    if len(markers) != EXPECTED_MARKERS:
        raise ValueError("expected %d markers, found %d" % (EXPECTED_MARKERS, len(markers)))
    colors, records, codes = [], [], set()
    for marker_name, tones in markers:
        if not marker_name or len(tones) != 3:
            raise ValueError("invalid marker: %r" % (marker_name,))
        for code, hex_value in tones:
            if code in codes:
                raise ValueError("duplicate tone code: %s" % code)
            if code not in names:
                raise ValueError("tone %s is not on the Illustrator chart" % code)
            if not tools.valid_hex(hex_value):
                raise ValueError("invalid hex: %s" % code)
            codes.add(code)
            colors.append({"code": code, "name": names[code], "hex": hex_value,
                           "sets": [], "lines": list(LINES)})
        records.append({"name": marker_name, "tones": [code for code, _ in tones]})
    if len(colors) != EXPECTED_TONES:
        raise ValueError("expected %d tones, found %d" % (EXPECTED_TONES, len(colors)))
    return colors, records


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--from-file", type=Path, default=DEFAULT_PDF,
                        help="TriBlend chart PDF (default: the pinned baseline)")
    parser.add_argument("--illustrator-file", type=Path, default=DEFAULT_ILLUSTRATOR_PDF,
                        help="Illustrator chart PDF, used for the tone names")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--markers-out", type=Path, default=DEFAULT_MARKERS_OUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    try:
        colors, markers = build(extract(args.from_file), illustrator_names(args.illustrator_file))
        text = tools.render_json(colors)
        markers_text = tools.render_json(markers)
    except (OSError, ValueError, RuntimeError) as error:
        print("Generation failed: %s" % error, file=sys.stderr)
        return 1
    first = tools.check_or_write(text, args.out, args.check, "%d tones" % EXPECTED_TONES)
    second = tools.check_or_write(markers_text, args.markers_out, args.check,
                                  "%d markers" % EXPECTED_MARKERS)
    return first or second


if __name__ == "__main__":
    sys.exit(main())
