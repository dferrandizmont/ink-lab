#!/usr/bin/env python3
"""Generate assets/data/kurecolor_colors.json (ZIG Kurecolor Twin WS KC-3000N).

Pillow and the standard library only, Python 3.9+. Offline: it reads only
tool/data/baseline/ (never the network).

Source: the official colour chart of the KC-3000N ("135 colors and Blender",
136 printed swatches with code and name) published by Kuretake's ZIG site,
pinned as baseline/kurecolor_colors_136.png (see baseline/kurecolor.SOURCE.txt).
Codes and names are a hand transcription of the chart (baseline/kurecolor_codes.csv,
with the swatch centre of each colour). The hex value is sampled here: the
dominant colour cluster inside a patch well within the printed swatch, so the
printed code text is ignored. Values are approximate screen colours.

    python tool/data/generate_kurecolor.py            # write the JSON
    python tool/data/generate_kurecolor.py --check    # exit 1 if it would change
"""

import argparse
import csv
import hashlib
import json
from collections import Counter
from pathlib import Path
import re
import sys

from PIL import Image

HERE = Path(__file__).resolve().parent
BASELINE = HERE / "baseline"
DEFAULT_OUT = HERE.parents[1] / "assets/data/kurecolor_colors.json"
CODES_CSV = "kurecolor_codes.csv"
CHART = "kurecolor_colors_136.png"
CHART_SHA256 = "8df5cb64aa477ca616df5554f320a354d688334d341b888a272a5e69c635dc55"
EXPECTED_TOTAL = 136  # 135 colours + the colourless blender B01
HALF = 22  # sampling patch half side; swatches are about 56 px wide


def dominant_color(pixels):
    """Median of the main colour cluster (4-bit bins, +-1 neighbours).

    The main cluster is the bin whose 3x3x3 neighbourhood holds the most
    pixels, so noise that splits a flat colour over several bins cannot lose
    against a single-bin minority (the printed digits).
    """
    bins = Counter((r >> 4, g >> 4, b >> 4) for r, g, b in pixels)
    best = max(bins, key=lambda k: (sum(
        bins.get((k[0] + i, k[1] + j, k[2] + m), 0)
        for i in (-1, 0, 1) for j in (-1, 0, 1) for m in (-1, 0, 1)), k))
    chosen = [p for p in pixels
              if all(abs((p[k] >> 4) - best[k]) <= 1 for k in range(3))]
    return tuple(sorted(p[k] for p in chosen)[len(chosen) // 2] for k in range(3))


def sample_swatch(image, cx, cy):
    px = image.load()
    pixels = [px[x, y]
              for y in range(int(cy - HALF), int(cy + HALF) + 1)
              for x in range(int(cx - HALF), int(cx + HALF) + 1)]
    return "%02x%02x%02x" % dominant_color(pixels)


def read_codes(path):
    with path.open(encoding="utf-8", newline="") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise ValueError("empty codes CSV")
    return rows


def build(rows, baseline=BASELINE):
    path = baseline / CHART
    if hashlib.sha256(path.read_bytes()).hexdigest() != CHART_SHA256:
        raise ValueError("pinned chart image changed: %s" % CHART)
    image = Image.open(path).convert("RGB")
    colors, codes = [], set()
    for row in rows:
        code = (row.get("code") or "").strip()
        name = (row.get("name") or "").strip()
        if not code or not name:
            raise ValueError("empty code or name: %r" % (row,))
        if code in codes:
            raise ValueError("duplicate code: %s" % code)
        hex_value = sample_swatch(image, float(row["x"]), float(row["y"]))
        if not re.fullmatch(r"[0-9a-f]{6}", hex_value):
            raise ValueError("invalid hex: %s" % code)
        codes.add(code)
        colors.append({"code": code, "name": name, "hex": hex_value, "sets": []})
    if len(colors) != EXPECTED_TOTAL:
        raise ValueError("expected %d colours, got %d" % (EXPECTED_TOTAL, len(colors)))
    return colors


def render(colors):
    return json.dumps(colors, ensure_ascii=True, indent=2) + "\n"


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--baseline-dir", type=Path, default=BASELINE)
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    try:
        colors = build(read_codes(args.baseline_dir / CODES_CSV), args.baseline_dir)
        text = render(colors)
    except (OSError, ValueError, KeyError) as error:
        print("Generation failed: %s" % error, file=sys.stderr)
        return 1
    if args.check:
        try:
            current = args.out.read_bytes()
        except OSError:
            current = None
        if current != text.encode("utf-8"):
            print("CHECK FAILED: %s differs from generated output" % args.out)
            return 1
        print("check ok: %s is up to date" % args.out)
        return 0
    args.out.parent.mkdir(parents=True, exist_ok=True)
    with args.out.open("w", encoding="utf-8", newline="\n") as handle:
        handle.write(text)
    print("Wrote %d colours to %s" % (len(colors), args.out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
