#!/usr/bin/env python3
"""Generate assets/data/spectrum_noir_colors.json: one Spectrum Noir brand.

Python 3.9+, standard library only (the chart PDFs are read by the generators
that produce the two intermediate files; this one never opens a PDF).

Spectrum Noir is a single ink-code system sold in several ranges, so the app
has one brand keyed by code, with three `lines`:

* `illustrator`: every colour of the official "Classique & Illustrator
  Dual-Tip colour chart" (216). Name and hex are the chart's.
* `classic`: the classic range, 168 of those 216 (the Illustrator range is the
  classic one plus 48 colours). Membership comes from MarkerMatchDB's
  `spectrumMarkers` line; only the membership, because its hex values are
  wrong (median 37 per channel away from the chart). Its `BLENDER` and
  `TRUEBLACK` are the chart's `BL` and `TB`, and its `BT6` (malformed hex
  there) is on the chart.
* `triblend`: the 144 tones of the official TriBlend chart. A TriBlend tone is
  an ordinary ink code, so it is the same colour as the Illustrator one. Where
  the two charts disagree on a hex (`FS7`) the Illustrator chart wins.

Inputs (all pinned in tool/data/baseline/):
  spectrum_noir_illustrator_chart_colors.json  (generate_spectrum_noir_illustrator.py)
  spectrum_noir_triblend_chart_colors.json     (generate_spectrum_noir_triblend.py)
  markermatch_source.csv                       (MarkerMatchDB, Apache-2.0)

Usage: python tool/data/generate_spectrum_noir.py [--check] [--out FILE]
"""

import argparse
import importlib.util
import json
from pathlib import Path
import re
import sys

HERE = Path(__file__).resolve().parent
DEFAULT_ILLUSTRATOR = HERE / "baseline/spectrum_noir_illustrator_chart_colors.json"
DEFAULT_TRIBLEND = HERE / "baseline/spectrum_noir_triblend_chart_colors.json"
DEFAULT_SOURCE = HERE / "baseline/markermatch_source.csv"
DEFAULT_OUT = HERE.parents[1] / "assets/data/spectrum_noir_colors.json"

# MarkerMatchDB spells two codes out; the chart (and the pens) use these.
ALIASES = {"BLENDER": "BL", "TRUEBLACK": "TB"}
LINE_ORDER = ("classic", "illustrator", "triblend")
EXPECTED = {"total": 216, "classic": 168, "illustrator": 216, "triblend": 144}


def _markermatch():
    spec = importlib.util.spec_from_file_location(
        "generate_markermatch", HERE / "generate_markermatch.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def classic_codes(rows):
    """Chart codes of MarkerMatchDB's Spectrum Noir line, aliases resolved."""
    codes = []
    for code in _markermatch().line_codes(rows, "spectrumMarkers"):
        code = ALIASES.get(code, code)
        if code in codes:
            raise ValueError("duplicate classic code after aliases: %s" % code)
        codes.append(code)
    return codes


def _chart(entries, label):
    by_code = {}
    for entry in entries:
        code = entry["code"]
        if code in by_code:
            raise ValueError("%s: duplicate code %s" % (label, code))
        if not re.fullmatch(r"[0-9a-f]{6}", entry["hex"]):
            raise ValueError("%s: invalid hex for %s" % (label, code))
        if not entry["name"].strip():
            raise ValueError("%s: empty name for %s" % (label, code))
        by_code[code] = entry
    return by_code


def build(illustrator, triblend, classic):
    """Merge the three sources; every cross-check failure is an error."""
    chart = _chart(illustrator, "illustrator chart")
    tones = _chart(triblend, "TriBlend chart")
    classic = set(classic)
    unknown = sorted((classic | set(tones)) - set(chart))
    if unknown:
        raise ValueError("codes missing from the Illustrator chart: %s"
                         % ", ".join(unknown))
    colors = []
    for code, entry in chart.items():
        lines = [line for line, member in (("classic", code in classic),
                                           ("illustrator", True),
                                           ("triblend", code in tones)) if member]
        colors.append({"code": code, "name": entry["name"], "hex": entry["hex"],
                       "sets": [], "lines": lines})
    counts = {line: sum(line in c["lines"] for c in colors) for line in LINE_ORDER}
    counts["total"] = len(colors)
    if counts != EXPECTED:
        raise ValueError("expected %s, got %s" % (EXPECTED, counts))
    return colors


def render(colors):
    return json.dumps(colors, ensure_ascii=True, indent=2) + "\n"


def generate(illustrator_path=DEFAULT_ILLUSTRATOR, triblend_path=DEFAULT_TRIBLEND,
             source_path=DEFAULT_SOURCE):
    illustrator = json.loads(Path(illustrator_path).read_text(encoding="utf-8"))
    triblend = json.loads(Path(triblend_path).read_text(encoding="utf-8"))
    rows = _markermatch().load_rows(source_path)
    return build(illustrator, triblend, classic_codes(rows))


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--check", action="store_true",
                        help="do not write; exit 1 if the file would change")
    args = parser.parse_args(argv)
    try:
        data = render(generate()).encode("utf-8")
    except (OSError, ValueError, KeyError) as error:
        print("Generation failed: %s" % error, file=sys.stderr)
        return 1
    if args.check:
        if not args.out.is_file() or args.out.read_bytes() != data:
            print("CHECK FAILED: %s differs from generated output" % args.out)
            return 1
        print("check ok: %s is up to date" % args.out)
        return 0
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_bytes(data)
    print("Wrote %s" % args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
