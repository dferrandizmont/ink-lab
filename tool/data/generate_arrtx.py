#!/usr/bin/env python3
"""Generate assets/data/arrtx_colors.json from the pinned Arrtx chart images.

Pillow and the standard library only, Python 3.9+. Offline: it reads only
tool/data/baseline/ (never the network).

Codes, official names and the OROS/ALP line of each colour are a hand
transcription of Arrtx's published colour cards, kept in
baseline/arrtx_codes.csv (see baseline/arrtx_codes.SOURCE.txt). The hex
values are sampled here from two pinned chart images: the swatch chips that
Arrtx prints on its own product pages (OROS 160 chart and the OROS
"Color card comparison"). They are approximate screen values, not measured
ink. The CSV gives each colour's chip centre; the sample is the dominant
colour cluster inside a patch well within the chip (so the printed code
text is ignored).

    python tool/data/generate_arrtx.py            # write assets/data/arrtx_colors.json
    python tool/data/generate_arrtx.py --check    # exit 1 if the file would change
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
DEFAULT_OUT = HERE.parents[1] / "assets/data/arrtx_colors.json"
CODES_CSV = "arrtx_codes.csv"

# swatch id -> (pinned file, sha256)
SWATCHES = {
    "oros160": ("arrtx_oros160_swatches.jpg",
                "6f092c456ff9c7f3f88e9b65dab6ac82a6ae98494440c3b0aa9c8ee1e8d4e479"),
    "card_90": ("arrtx_oros_color_card_comparison.jpg",
                "951ad0b494c3eb1b749356ef0a51c166ab561c6a10686c3dbc7ddbe5e12871f7"),
}
SWATCHES["card_80"] = SWATCHES["card_66"] = SWATCHES["card_48"] = SWATCHES["card_90"]

LINES = ("OROS", "ALP")
EXPECTED_TOTAL = 328
EXPECTED_ALP = 226
EXPECTED_UNNAMED = 90
UNNAMED_PREFIX = ""  # Arrtx publishes no name for the 160-only colours: the code is the name
# Sampling patch (pixels): half width and half height inside a pill chip,
# radius inside a disc chip. Pill chips are 133x94 (90 block) or about
# 104x65 (80, 66 and 48 blocks); discs are 76 wide.
PILL_HALF = (38, 22)
DISC_RADIUS = 30


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def dominant_color(pixels):
    """Median of the main colour cluster (4-bit bins, +-1 neighbours).

    The main cluster is the bin whose 3x3x3 neighbourhood holds the most
    pixels, so JPEG noise that splits a flat colour over several bins cannot
    lose against a single-bin minority (the white digits on a pale chip).
    """
    bins = Counter((r >> 4, g >> 4, b >> 4) for r, g, b in pixels)
    best = max(bins, key=lambda k: (sum(
        bins.get((k[0] + i, k[1] + j, k[2] + m), 0)
        for i in (-1, 0, 1) for j in (-1, 0, 1) for m in (-1, 0, 1)), k))
    chosen = [p for p in pixels
              if all(abs((p[k] >> 4) - best[k]) <= 1 for k in range(3))]
    return tuple(sorted(p[k] for p in chosen)[len(chosen) // 2] for k in range(3))


def sample_chip(image, shape, cx, cy):
    px = image.load()
    if shape == "pill":
        hw, hh = PILL_HALF
        pixels = [px[x, y]
                  for y in range(int(cy - hh), int(cy + hh) + 1)
                  for x in range(int(cx - hw), int(cx + hw) + 1)]
    elif shape == "disc":
        r = DISC_RADIUS
        pixels = [px[x, y]
                  for y in range(int(cy - r), int(cy + r) + 1)
                  for x in range(int(cx - r), int(cx + r) + 1)
                  if (x - cx) ** 2 + (y - cy) ** 2 <= r * r]
    else:
        raise ValueError("unknown chip shape: %s" % shape)
    return "%02x%02x%02x" % dominant_color(pixels)


def read_codes(path):
    with path.open(encoding="utf-8", newline="") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise ValueError("empty codes CSV")
    return rows


def build(rows, baseline=BASELINE):
    images = {}
    colors, codes = [], set()
    for row in rows:
        code = (row.get("code") or "").strip()
        name = (row.get("name") or "").strip()
        if not code or not name:
            raise ValueError("empty code or name: %r" % (row,))
        if code in codes:
            raise ValueError("duplicate code: %s" % code)
        lines = row["lines"].split(";")
        if (not lines or any(line not in LINES for line in lines)
                or len(set(lines)) != len(lines)):
            raise ValueError("invalid lines for %s" % code)
        if "OROS" not in lines:
            raise ValueError("every colour must belong to OROS: %s" % code)
        swatch = row["swatch"]
        if swatch not in SWATCHES:
            raise ValueError("unknown swatch source for %s: %s" % (code, swatch))
        filename, digest = SWATCHES[swatch]
        if filename not in images:
            path = baseline / filename
            if sha256(path) != digest:
                raise ValueError("pinned image changed: %s" % filename)
            images[filename] = Image.open(path).convert("RGB")
        hex_value = sample_chip(images[filename], row["shape"],
                                float(row["x"]), float(row["y"]))
        if not re.fullmatch(r"[0-9a-f]{6}", hex_value):
            raise ValueError("invalid hex: %s" % code)
        codes.add(code)
        colors.append({"code": code, "name": name, "hex": hex_value,
                       "sets": [], "lines": list(lines)})
    return colors


def validate(colors):
    if len(colors) != EXPECTED_TOTAL:
        raise ValueError("expected %d colours, got %d" % (EXPECTED_TOTAL, len(colors)))
    alp = sum(1 for c in colors if "ALP" in c["lines"])
    if alp != EXPECTED_ALP:
        raise ValueError("expected %d ALP colours, got %d" % (EXPECTED_ALP, alp))
    unnamed = sum(1 for c in colors if c["name"] == UNNAMED_PREFIX + c["code"])
    if unnamed != EXPECTED_UNNAMED:
        raise ValueError("expected %d unnamed colours, got %d" % (EXPECTED_UNNAMED, unnamed))


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
        validate(colors)
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
