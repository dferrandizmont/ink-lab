#!/usr/bin/env python3
"""Generate six alcohol-marker catalogues from pinned MarkerMatchDB (Apache-2.0).

Python 3.9+, standard library only. See NOTICE.md for attribution and limitations.
Usage: python tool/data/generate_markermatch.py [--from-file SOURCE.csv] [--check]

Besides the six catalogues, other generators reuse this source for line
membership only (`line_codes`): Copic Ciao/Classic (generate_copic.py) and
Spectrum Noir's classic range (generate_spectrum_noir.py). Spectrum Noir itself
is not generated here: its hex values in MarkerMatchDB are wrong, so its colours
come from the official chart.
"""

import argparse
import csv
import io
import json
from pathlib import Path
import re
import sys
import urllib.request

SOURCE_REPO = "https://github.com/GrumpyCockatiel/MarkerMatchDB"
SOURCE_COMMIT = "b6e2afedd85887ecf9d5b9a6dcc34aecf627f68f"
SOURCE_URL = ("https://raw.githubusercontent.com/GrumpyCockatiel/MarkerMatchDB/"
              + SOURCE_COMMIT + "/MarkerMatchDB.csv")
DEFAULT_OUT = Path(__file__).resolve().parents[2] / "assets/data"
DEFAULT_SOURCE = Path(__file__).resolve().parent / "baseline/markermatch_source.csv"
EXPECTED_COUNTS = {"touch_twin": 202, "promarker": 148, "promarker_brush": 72,
                   "prismacolor": 200, "blick_brush": 96, "artists_loft": 56}
# Brand id -> the single source line it is built from.
SIMPLE_LINES = {"promarker": "winsorPromarker",
                "promarker_brush": "winsorBrushmarker",
                "blick_brush": "blickBrush",
                "artists_loft": "artistsLoftDTS"}
SOURCE_LINES = ("touchTwinMarker", "touchTwinBrush", "prismaPM", "prismaPB",
                *SIMPLE_LINES.values())


def read_rows(source):
    reader = csv.DictReader(io.StringIO(source.lstrip("\ufeff"), newline=""))
    if reader.fieldnames != ["id", "line", "code", "name", "hex", "rgb", "cmyk"]:
        raise ValueError("unexpected CSV columns")
    return list(reader)


def build(rows, report=None):
    """Validate selected lines, collapse identical variants, preserve source order.

    Malformed hex rows are omitted and reported before exact output counts are
    checked. No fallback is inferred from RGB/CMYK or from a different catalogue.
    Touch availability is metadata, like Finecolour (no retail-set selection).
    Prismacolor's PB prefix reuses MarkerColor.oldCode as an alternative to PM
    (PM23 with the alias PB23: the source's space is dropped).
    """
    if report is None:
        report = lambda message: print(message, file=sys.stderr)
    lines = {line: {} for line in SOURCE_LINES}
    ambiguous = {line: set() for line in SOURCE_LINES}
    row_ids = {line: {} for line in SOURCE_LINES}
    for row in rows:
        line = row.get("line")
        if line not in lines:
            continue
        code = (row.get("code") or "").strip().upper()
        name = (row.get("name") or "").strip()
        if not code or not name:
            raise ValueError("empty code/name in row %s" % row["id"])
        hex_value = (row.get("hex") or "").strip().removeprefix("#").lower()
        if not re.fullmatch(r"[0-9a-f]{6}", hex_value):
            report("Dropped row %s (%s, %s): invalid hex %r"
                   % (row["id"], line, code, row["hex"]))
            continue
        color = {"code": code, "name": name, "hex": hex_value, "sets": []}
        if code in ambiguous[line]:
            report("Dropped row %s (%s, %s): ambiguous duplicate code"
                   % (row["id"], line, code))
            continue
        if code in lines[line]:
            if lines[line][code] == color:
                raise ValueError("duplicate code in %s: %s" % (line, code))
            # A code assigned two different colours cannot identify either.
            # Quarantine both, rather than arbitrarily retaining one hex.
            report("Dropped rows %s and %s (%s, %s): conflicting names/hex"
                   % (row_ids[line][code], row["id"], line, code))
            ambiguous[line].add(code)
            del lines[line][code]
            continue
        lines[line][code] = color
        row_ids[line][code] = row["id"]

    if lines["touchTwinMarker"] != lines["touchTwinBrush"]:
        raise ValueError("Touch Twin marker/brush codes, names or hex differ")
    touch = [dict(color, lines=["touchTwinMarker", "touchTwinBrush"])
             for color in lines["touchTwinMarker"].values()]
    pm = lines["prismaPM"]
    pb = lines["prismaPB"]
    if any(not c.startswith("PM ") for c in pm):
        raise ValueError("unexpected Prismacolor PM prefix")
    if {c.replace("PM ", "PB ", 1) for c in pm} != set(pb):
        raise ValueError("Prismacolor PM/PB colour codes differ")
    prisma = []
    for code, color in pm.items():
        alternative = code.replace("PM ", "PB ", 1)
        if any(color[key] != pb[alternative][key] for key in ("name", "hex")):
            raise ValueError("Prismacolor PM/PB colour differs: %s" % code)
        # The source spells "PM 23"; the app's codes never contain a space, and
        # search ignores spaces, so the record is PM23 with the alias PB23.
        prisma.append(dict(color, code=code.replace(" ", ""),
                           oldCode=alternative.replace(" ", "")))
    catalogues = {"touch_twin": touch,
                  "promarker": list(lines["winsorPromarker"].values()),
                  "promarker_brush": list(lines["winsorBrushmarker"].values()),
                  "prismacolor": prisma,
                  "blick_brush": list(lines["blickBrush"].values()),
                  "artists_loft": list(lines["artistsLoftDTS"].values())}
    for brand, colors in catalogues.items():
        if len(colors) != EXPECTED_COUNTS[brand]:
            raise ValueError("%s: expected exactly %s colours, got %s"
                             % (brand, EXPECTED_COUNTS[brand], len(colors)))
        if len({c["code"] for c in colors}) != len(colors):
            raise ValueError("duplicate output codes: %s" % brand)
    return catalogues


def line_codes(rows, line):
    """Codes of one source line in source order, upper case, hex not checked.

    Used for membership only (which colours a product line sells), so a row
    whose hex is malformed still counts: the other generators take hex, names
    and everything else from a better source.
    """
    codes = []
    for row in rows:
        if row.get("line") == line:
            code = (row.get("code") or "").strip().upper()
            if not code:
                raise ValueError("empty code in row %s" % row["id"])
            if code in codes:
                raise ValueError("duplicate code in %s: %s" % (line, code))
            codes.append(code)
    return codes


def load_rows(path=DEFAULT_SOURCE):
    """The pinned snapshot's rows (CRLF or LF, with or without BOM)."""
    return read_rows(Path(path).read_text(encoding="utf-8-sig"))


def render(colors):
    return json.dumps(colors, ensure_ascii=True, indent=2) + "\n"


class PinnedSourceOnly(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, request, fp, code, message, headers, newurl):
        # Reject before following, so a redirect cannot contact another host.
        if newurl != SOURCE_URL:
            raise ValueError("unexpected MarkerMatchDB source redirect")
        return super().redirect_request(request, fp, code, message, headers, newurl)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--from-file", type=Path, help="offline source CSV")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT,
                        help="directory for the six JSON files")
    parser.add_argument("--check", action="store_true",
                        help="do not write; exit 1 if any file would change")
    args = parser.parse_args(argv)
    try:
        if args.from_file:
            source = args.from_file.read_text(encoding="utf-8-sig")
        else:
            opener = urllib.request.build_opener(PinnedSourceOnly())
            with opener.open(SOURCE_URL, timeout=30) as response:
                if response.geturl() != SOURCE_URL:
                    raise ValueError("unexpected MarkerMatchDB source URL")
                source = response.read().decode("utf-8-sig")
        outputs = {args.out / (brand + "_colors.json"): render(colors).encode("utf-8")
                   for brand, colors in build(read_rows(source)).items()}
        if args.check:
            different = False
            for path, data in outputs.items():
                if not path.is_file() or path.read_bytes() != data:
                    print("CHECK FAILED: %s differs from generated output" % path)
                    different = True
            if different:
                return 1
            print("check ok: all six catalogues are up to date")
        else:
            args.out.mkdir(parents=True, exist_ok=True)
            for path, data in outputs.items():
                path.write_bytes(data)
                print("Wrote %s" % path)
        return 0
    except (OSError, ValueError, KeyError, csv.Error) as error:
        print("Generation failed: %s" % error, file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
