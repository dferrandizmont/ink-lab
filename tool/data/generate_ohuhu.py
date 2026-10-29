#!/usr/bin/env python3
"""Generate assets/data/ohuhu_colors.json (Ohuhu Oahu + Honolulu + Kaala).

Standard library only. Python 3.9+.

Sources (public Google Sheets CSV exports, factual colour data only):
  * "The BIG Ohuhu Legend" community sheet, tab "Oahu Set Comparison":
    codes, names, per-line legacy codes and set membership (one column/set).
  * The community hex sheet (published CSV): `New Code -> Hex`.

The generator is deterministic for a given pair of input CSVs: baseline
colours keep their frozen order, added colours follow in natural code order,
set ids follow SET_DEFS order, keys are written in a fixed order.

Rules worth knowing (see tool/data/README.md for details):
  * BASELINE: the 321 original Oahu colours (tool/data/baseline/
    oahu_colors_v1.json) are frozen. Their newName/oldCode/oldName/hex come
    from the baseline, never from the live sheet, and the membership of the
    12 original Oahu sets must equal the baseline. Any drift in the live sheet
    is printed as a WARNING instead of being silently applied.
  * Colours that belong to no imported set are skipped (and listed).
  * A set whose marker count does not match the count implied by its name is
    skipped and reported (never "fixed").

Usage:
  python tool/data/generate_ohuhu.py                  # download + write
  python tool/data/generate_ohuhu.py --cache-dir DIR  # also keep the CSVs
  python tool/data/generate_ohuhu.py --from-cache DIR # offline, reuse CSVs
  python tool/data/generate_ohuhu.py --check          # exit 1 if file differs
"""

import argparse
import csv
import functools
import io
import json
import os
import re
import sys
import urllib.parse
import urllib.request

SHEET_CSV_URL = (
    "https://docs.google.com/spreadsheets/d/"
    "1Y4F6jlvxUpsU1CoanMljjwTiW4Ngxk8u2AoxfBuQz_A/"
    "gviz/tq?tqx=out:csv&sheet=Oahu%20Set%20Comparison"
)
HEX_CSV_URL = (
    "https://docs.google.com/spreadsheets/d/e/"
    "2PACX-1vTXyBuMZShW6A_T96cn-InrAbiv2ef9C4aEuVBewjqaaSaZ5Y8irlKwE3sKHwf4jA/"
    "pub?output=csv"
)
SHEET_CACHE_NAME = "oahu_set_comparison.csv"
HEX_CACHE_NAME = "hex.csv"

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(os.path.dirname(HERE))
DEFAULT_OUT = os.path.join(REPO, "assets", "data", "ohuhu_colors.json")
BASELINE_PATH = os.path.join(HERE, "baseline", "oahu_colors_v1.json")

# Fixed layout of the "Oahu Set Comparison" tab (0-based CSV columns).
COL_NEW_CODE = 1
COL_NEW_NAME = 2
COL_OAHU_CODE = 9
COL_OAHU_NAME = 10
COL_HONOLULU_CODE = 34
COL_HONOLULU_NAME = 35
COL_KAALA_CODE = 102
COL_KAALA_NAME = 103
COL_HEX = 118
HEADER_ROW_GROUP = 0  # group titles ("White Case Sets ...")
HEADER_ROW_LABEL = 1  # short labels ("40", "36 S", ...)
FIRST_DATA_ROW = 2

# (set id, line, csv column, expected row-1 label, expected row-0 fragment,
#  named colour count, includes the colourless blender).
# The row-0 fragment is lower-cased and only used to detect a moved column.
# Order here = order of set ids inside every colour record.
SET_DEFS = [
    # ---- Oahu: original twelve (unchanged ids) ----
    ("classic_40", "oahu", 12, "40", "", 40, True),
    ("classic_60", "oahu", 13, "60", "classic\" 60", 60, True),
    ("classic_80", "oahu", 14, "80", "classic\" 80", 80, True),
    ("classic_100", "oahu", 15, "100", "classic\" 100", 100, True),
    ("classic_120", "oahu", 16, "120", "classic\"  120", 120, True),
    ("classic_160", "oahu", 17, "160", "classic\" 160", 160, True),
    ("classic_200", "oahu", 18, "200", "classic\" 200", 200, True),
    ("new_120", "oahu", 19, "120 b", "new\" 120", 120, True),
    ("classic_320", "oahu", 20, "320", "classic\" 320", 320, True),
    ("skin_36", "oahu", 21, "36 s", "36 skin", 36, False),
    ("gray_36", "oahu", 22, "36 g", "36 grey", 36, False),
    ("pastel_48", "oahu", 23, "48 p", "48 pastels", 48, False),
    # ---- Honolulu 6 packs: sold officially as "Honolulu 6 Colors"
    # (ohuhu.com, 2024-08). The sheet lists them in its Oahu section; ids are
    # persisted, so they keep their old names. Membership is the sheet's. ----
    ("basic_6", "honolulu", 24, "6 pr", "basic/primary 6", 6, False),
    ("pastel_6", "honolulu", 25, "6 pa", "pastels 6", 6, False),
    ("skin_6", "honolulu", 26, "6 po", "portrait/skin tones 6", 6, False),
    # ---- Oahu: community-only sets (white cases) ----
    ("white_24", "oahu", 27, "24", "white case 24", 24, False),
    ("white_48", "oahu", 28, "48", "white case 48", 48, False),
    ("white_72", "oahu", 29, "72", "white case 72", 72, False),
    ("white_128", "oahu", 30, "128", "white case 128", 128, False),
    ("white_200", "oahu", 31, "200", "white case 200", 200, False),
    # ---- Honolulu ----
    ("honolulu_24", "honolulu", 36, "24", "", 24, False),
    ("honolulu_48", "honolulu", 37, "48", "classic\" 48", 48, False),
    ("honolulu_72", "honolulu", 38, "72", "classic\" 72", 72, False),
    ("honolulu_104", "honolulu", 44, "104", "classic\" 104", 104, False),
    ("honolulu_120", "honolulu", 39, "120", "classic\" 120", 120, False),
    ("honolulu_168", "honolulu", 41, "168", "classic\" 168", 168, False),
    ("honolulu_216", "honolulu", 43, "216", "classic\" 216", 216, False),
    ("honolulu_320", "honolulu", 45, "320", "classic\" 320", 320, False),
    ("honolulu_pastel_sweet_48", "honolulu", 40, "48 ps", "sweetness pastels", 48, False),
    ("honolulu_midtones_48", "honolulu", 42, "48 m", "mid-tones", 48, False),
    ("honolulu_pastel_blossom_48", "honolulu", 50, "48 pb", "blossoming pastels", 48, False),
    ("honolulu_pastel_96", "honolulu", 51, "96", "96 pastels", 96, False),
    ("honolulu_skin_24", "honolulu", 47, "24 sn", "24 skin tones", 24, False),
    ("honolulu_skin_36", "honolulu", 48, "36 s", "36 portrait/skin", 36, False),
    ("honolulu_gray_36", "honolulu", 49, "36 g", "36 grey", 36, False),
    ("honolulu_japan_80_v1", "honolulu", 52, "80 jp", "japan excl. 80 set (v1)", 80, False),
    ("honolulu_japan_80_v2", "honolulu", 53, "80 jp", "japan excl. 80 set (v2)", 80, False),
    ("honolulu_white_24_v1", "honolulu", 81, "24", "white case 24", 24, False),
    ("honolulu_white_24_v2", "honolulu", 82, "24", "white case 24 (v2)", 24, False),
    ("honolulu_white_40", "honolulu", 83, "40", "white case 40", 40, False),
    ("honolulu_white_80_v1", "honolulu", 84, "80", "white case 80 (v1)", 80, False),
    ("honolulu_white_80_v2", "honolulu", 85, "80", "white case 80 (v2)", 80, False),
    ("honolulu_white_120_v1", "honolulu", 86, "120", "white case 120 (v1)", 120, False),
    ("honolulu_white_120_v2", "honolulu", 87, "120", "white case 120 (v2)", 120, False),
    ("honolulu_white_200_v1", "honolulu", 88, "200", "white case 200 (v1)", 200, False),
    ("honolulu_white_200_v2", "honolulu", 89, "200", "white case 200 (v2)", 200, False),
    # ---- Kaala ----
    ("kaala_basic_24", "kaala", 104, "24 b", "kaala 24 basic", 24, False),
    ("kaala_skin_24", "kaala", 105, "24 s", "kaala 24 skin", 24, False),
    ("kaala_illustration_60", "kaala", 106, "60 i", "60 illustration", 60, False),
    ("kaala_landscape_60", "kaala", 107, "60 l", "60 landscape", 60, False),
    ("kaala_pastel_60", "kaala", 108, "60 p", "kaala 60 pastels", 60, False),
    ("kaala_basic_108", "kaala", 109, "108", "kaala 108", 108, False),
]

# Sheet columns that exist but are intentionally NOT imported (reported only).
NOT_IMPORTED = [
    (46, "Honolulu 24 Skin Tones (Discontinued)",
     "marker count 23 does not match the named 24"),
    (54, "Honolulu Plastic Box 60", "retail bundle, not imported"),
    (55, "Honolulu 6 and 12 packs (cols 55-69)", "marketing bundles"),
    (70, "Coloring-book packs, gift bags, kits, collabs (cols 70-80)",
     "marketing bundles / collaborations"),
    (90, "Honolulu S series (cols 90-94)", "pre-2026 S series"),
    (98, "Honolulu Plus 24 / 36 (cols 98-99)", "separate Plus code system"),
]

# The twelve sets that existed before this generator grew; their membership
# must equal the frozen baseline.
ORIGINAL_SET_IDS = [d[0] for d in SET_DEFS[:12]]
CORE_BLENDER_SET_IDS = [d[0] for d in SET_DEFS[:9]]  # classic_* + new_120
LINE_COLUMNS = {
    "oahu": (COL_OAHU_CODE, "oahu"),
    "honolulu": (COL_HONOLULU_CODE, "honolulu"),
    "kaala": (COL_KAALA_CODE, "kaala"),
}
LINE_ORDER = ["oahu", "honolulu", "kaala"]
HEX_RE = re.compile(r"^[0-9a-f]{6}$")


# ---------------------------------------------------------------- download


class _HostRestrictedRedirect(urllib.request.HTTPRedirectHandler):
    """Follow redirects only inside Google's own sheet hosts."""

    def redirect_request(self, req, fp, code, msg, headers, newurl):
        _check_host(newurl)
        return super().redirect_request(req, fp, code, msg, headers, newurl)


def _check_host(url):
    parts = urllib.parse.urlparse(url)
    host = (parts.hostname or "").lower()
    ok = parts.scheme == "https" and (
        host == "docs.google.com" or host.endswith(".googleusercontent.com")
    )
    if not ok:
        raise ValueError("refusing to fetch outside Google Sheets: " + url)


def download(url):
    _check_host(url)
    opener = urllib.request.build_opener(_HostRestrictedRedirect)
    with opener.open(url, timeout=60) as response:
        return response.read().decode("utf-8")


def load_inputs(args):
    """Return (sheet_csv_text, hex_csv_text)."""
    if args.from_cache:
        base = args.from_cache
        with open(os.path.join(base, SHEET_CACHE_NAME), encoding="utf-8") as f:
            sheet = f.read()
        with open(os.path.join(base, HEX_CACHE_NAME), encoding="utf-8") as f:
            hexes = f.read()
        return sheet, hexes
    sheet = download(SHEET_CSV_URL)
    hexes = download(HEX_CSV_URL)
    if args.cache_dir:
        os.makedirs(args.cache_dir, exist_ok=True)
        with open(os.path.join(args.cache_dir, SHEET_CACHE_NAME), "w",
                  encoding="utf-8", newline="") as f:
            f.write(sheet)
        with open(os.path.join(args.cache_dir, HEX_CACHE_NAME), "w",
                  encoding="utf-8", newline="") as f:
            f.write(hexes)
    return sheet, hexes


# ----------------------------------------------------------------- helpers


def parse_csv(text):
    return list(csv.reader(io.StringIO(text)))


def cell(row, index):
    return row[index].strip() if len(row) > index else ""


def clean_text(value):
    """Collapse whitespace and drop the sheet's trailing "*" footnote marker."""
    text = re.sub(r"\s+", " ", value or "").strip()
    return re.sub(r"\s*\*+$", "", text)


def sanitize_hex(raw):
    value = (raw or "").strip().lower().lstrip("#")
    return value if HEX_RE.match(value) else ""


def natural_compare(left, right):
    """Port of lib/core/natural_sort.dart naturalCodeComparator."""
    token = re.compile(r"\d+|\D+")
    a = token.findall(left.upper())
    b = token.findall(right.upper())
    for x, y in zip(a, b):
        if x.isdigit() and y.isdigit():
            result = (int(x) > int(y)) - (int(x) < int(y))
        else:
            result = (x > y) - (x < y)
        if result:
            return result
    return (len(a) > len(b)) - (len(a) < len(b))


NATURAL_KEY = functools.cmp_to_key(natural_compare)


def build_hex_lookup(rows):
    lookup = {}
    for row in rows[1:]:
        code = cell(row, 0)
        value = sanitize_hex(cell(row, 8))
        if code and value:
            lookup[code] = value
    return lookup


def verify_layout(rows, log):
    """Fail loudly if the sheet columns moved."""
    problems = []
    if len(rows) <= FIRST_DATA_ROW:
        raise SystemExit("sheet has no data rows")
    label_row = rows[HEADER_ROW_LABEL]
    group_row = rows[HEADER_ROW_GROUP]
    expectations = [
        (COL_NEW_CODE, "new codes"), (COL_NEW_NAME, "new names"),
        (COL_OAHU_CODE, "o code"), (COL_HONOLULU_CODE, "h code"),
        (COL_KAALA_CODE, "k code"), (COL_HEX, "hex code"),
    ]
    for col, expected in expectations:
        if cell(label_row, col).lower() != expected:
            problems.append("col %d expected label %r, found %r"
                            % (col, expected, cell(label_row, col)))
    for set_id, _line, col, label, fragment, _count, _bl in SET_DEFS:
        found = cell(label_row, col).lower()
        if found != label:
            problems.append("set %s col %d expected label %r, found %r"
                            % (set_id, col, label, found))
        if fragment and fragment not in cell(group_row, col).lower().replace(
                "\n", " "):
            log.append("NOTE set %s col %d group header %r lacks %r"
                       % (set_id, col, cell(group_row, col)[:60], fragment))
    if problems:
        raise SystemExit("sheet layout changed:\n  " + "\n  ".join(problems))


# ------------------------------------------------------------------ build


def load_baseline():
    with open(BASELINE_PATH, encoding="utf-8") as handle:
        items = json.load(handle)
    return {item["newCode"]: item for item in items}


def build(sheet_rows, hex_rows):
    log = []  # human-readable warnings / notes
    verify_layout(sheet_rows, log)
    baseline = load_baseline()
    hex_lookup = build_hex_lookup(hex_rows)

    raw = []
    seen = set()
    for row in sheet_rows[FIRST_DATA_ROW:]:
        code = cell(row, COL_NEW_CODE)
        name = clean_text(cell(row, COL_NEW_NAME))
        if not code or not name or code in ("NEW Codes",):
            continue
        if code in seen:
            raise SystemExit("duplicate new code in sheet: " + code)
        seen.add(code)
        raw.append(row)

    # set -> member codes (counts are checked on the sheet's marker columns)
    members = {d[0]: [] for d in SET_DEFS}
    row_sets = {}
    for row in raw:
        code = cell(row, COL_NEW_CODE)
        mine = []
        for set_id, _line, col, _label, _frag, _count, _bl in SET_DEFS:
            if cell(row, col):
                mine.append(set_id)
                members[set_id].append(code)
        row_sets[code] = mine

    # Count check per set (named count + blender when the set has one).
    skipped_sets = {}
    for set_id, line, col, _label, _frag, count, blender in SET_DEFS:
        markers = len(members[set_id])
        expected = count  # the blender is never a sheet marker
        if markers != expected:
            skipped_sets[set_id] = (markers, expected)
            log.append("MISMATCH set %s: %d markers in sheet, name implies %d "
                       "-> SET SKIPPED" % (set_id, markers, expected))

    colors = {}
    skipped_colors = []
    for row in raw:
        code = cell(row, COL_NEW_CODE)
        is_blender = code == "0"
        sets = [s for s in row_sets[code] if s not in skipped_sets]
        if is_blender:
            sets = list(CORE_BLENDER_SET_IDS)
        in_baseline = code in baseline
        if not sets and not in_baseline:
            skipped_colors.append(
                (code, clean_text(cell(row, COL_NEW_NAME)),
                 "belongs to no imported set"))
            continue

        oahu_code = cell(row, COL_OAHU_CODE)
        honolulu_code = cell(row, COL_HONOLULU_CODE)
        kaala_code = cell(row, COL_KAALA_CODE)
        sheet_name = clean_text(cell(row, COL_NEW_NAME))

        if in_baseline:
            base = baseline[code]
            new_name, old_code = base["newName"], base["oldCode"]
            old_name, hex_value = base["oldName"], base["hex"]
            if sheet_name != new_name:
                log.append("DRIFT %s name: baseline %r, sheet %r (baseline kept)"
                           % (code, new_name, sheet_name))
            sheet_old = (cell(row, COL_OAHU_CODE),
                         clean_text(cell(row, COL_OAHU_NAME)))
            if not is_blender and sheet_old != (old_code, old_name):
                log.append("DRIFT %s old code/name: baseline %r, sheet %r "
                           "(baseline kept)"
                           % (code, (old_code, old_name), sheet_old))
            live_hex = hex_lookup.get(code, "")
            if live_hex != hex_value:
                log.append("DRIFT %s hex: baseline %s, hex sheet %r "
                           "(baseline kept)" % (code, hex_value, live_hex))
            base_sets = [s for s in base["sets"]]
            live_orig = [s for s in sets if s in ORIGINAL_SET_IDS]
            if sorted(base_sets) != sorted(live_orig):
                log.append("DRIFT %s original-set membership: baseline %s, "
                           "sheet %s (baseline kept)"
                           % (code, base_sets, live_orig))
                sets = [s for s in sets if s not in ORIGINAL_SET_IDS] + base_sets
        else:
            new_name = sheet_name
            if oahu_code:
                old_code = oahu_code
                old_name = clean_text(cell(row, COL_OAHU_NAME))
            elif honolulu_code:
                old_code = honolulu_code
                old_name = clean_text(cell(row, COL_HONOLULU_NAME))
            elif kaala_code:
                old_code = kaala_code
                old_name = clean_text(cell(row, COL_KAALA_NAME))
            else:
                old_code, old_name = code, new_name
            old_name = old_name or new_name
            hex_value = hex_lookup.get(code, "")
            sheet_hex = sanitize_hex(cell(row, COL_HEX))
            if hex_value and sheet_hex and hex_value != sheet_hex:
                log.append("WARN %s hex differs: hex sheet %s vs set sheet %s "
                           "(hex sheet used)" % (code, hex_value, sheet_hex))
            if not hex_value:
                hex_value = sheet_hex
                if hex_value:
                    log.append("NOTE %s hex taken from set-sheet column 'Hex "
                               "Code' (absent in hex sheet)" % code)
            if not hex_value:
                skipped_colors.append((code, new_name, "no hex available"))
                continue

        lines = []
        for line in LINE_ORDER:
            col = LINE_COLUMNS[line][0]
            in_line_sets = any(
                d[1] == line and d[0] in sets for d in SET_DEFS)
            if cell(row, col) or in_line_sets or is_blender:
                lines.append(line)
        if not lines:
            lines = ["oahu"]  # cannot happen for imported colours; be explicit

        # set order = SET_DEFS order, deterministic
        order = {d[0]: i for i, d in enumerate(SET_DEFS)}
        sets = sorted(set(sets), key=lambda s: order[s])
        colors[code] = {
            "newCode": code,
            "newName": new_name,
            "oldCode": old_code,
            "oldName": old_name,
            "hex": hex_value,
            "lines": lines,
            "sets": sets,
        }

    # Baseline colours must all survive.
    missing = [c for c in baseline if c not in colors]
    if missing:
        raise SystemExit("baseline colours missing from sheet: %s" % missing)

    # Order: the frozen baseline colours first, in baseline order (existing
    # users and tests see them where they always were), then every added
    # colour in natural code order. Numeric ties (BV15 / BV015) fall back to
    # plain string order, so the output never depends on sheet row order.
    baseline_index = {code: i for i, code in enumerate(baseline)}
    ordered = sorted(
        colors.values(),
        key=lambda c: (
            (0, baseline_index[c["newCode"]], (), "")
            if c["newCode"] in baseline_index
            else (1, 0, NATURAL_KEY(c["newCode"]), c["newCode"])))
    return ordered, log, skipped_sets, skipped_colors


def summarize(colors, skipped_sets, skipped_colors, log):
    out = []
    counts = {d[0]: 0 for d in SET_DEFS}
    line_counts = {l: 0 for l in LINE_ORDER}
    for c in colors:
        for s in c["sets"]:
            counts[s] += 1
        for l in c["lines"]:
            line_counts[l] += 1
    out.append("Colours written: %d" % len(colors))
    for line in LINE_ORDER:
        out.append("  line %-8s %d colours" % (line, line_counts[line]))
    out.append("Sets (members incl. blender):")
    for set_id, line, _col, _l, _f, count, blender in SET_DEFS:
        if set_id in skipped_sets:
            out.append("  %-28s SKIPPED %s" % (set_id, skipped_sets[set_id]))
            continue
        want = count + (1 if blender else 0)
        flag = "" if counts[set_id] == want else "  <-- expected %d" % want
        out.append("  %-28s %-9s %4d%s" % (set_id, line, counts[set_id], flag))
    out.append("Skipped colours: %d" % len(skipped_colors))
    for code, name, why in skipped_colors:
        out.append("  %-8s %-26s %s" % (code, name, why))
    out.append("Not imported sheet sets:")
    for _col, name, why in NOT_IMPORTED:
        out.append("  %s: %s" % (name, why))
    out.append("Log (%d):" % len(log))
    for line in log:
        out.append("  " + line)
    return "\n".join(out)


def render(colors):
    """Deterministic JSON text (stable key order, LF, trailing newline)."""
    return json.dumps(colors, ensure_ascii=True, indent=2) + "\n"


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--out", default=DEFAULT_OUT)
    parser.add_argument("--cache-dir", help="save the downloaded CSVs here")
    parser.add_argument("--from-cache", help="read CSVs from here, no network")
    parser.add_argument("--check", action="store_true",
                        help="do not write; exit 1 if the file would change")
    parser.add_argument("--quiet", action="store_true")
    args = parser.parse_args(argv)

    sheet_text, hex_text = load_inputs(args)
    colors, log, skipped_sets, skipped_colors = build(
        parse_csv(sheet_text), parse_csv(hex_text))
    text = render(colors)

    if not args.quiet:
        sys.stdout.reconfigure(encoding="utf-8")
        print(summarize(colors, skipped_sets, skipped_colors, log))

    if args.check:
        try:
            with open(args.out, encoding="utf-8", newline="") as handle:
                current = handle.read()
        except OSError:
            current = None
        if current != text:
            print("CHECK FAILED: %s differs from generated output" % args.out)
            return 1
        print("check ok: %s is up to date" % args.out)
        return 0

    os.makedirs(os.path.dirname(args.out), exist_ok=True)
    with open(args.out, "w", encoding="utf-8", newline="\n") as handle:
        handle.write(text)
    print("Wrote %d colours to %s" % (len(colors), args.out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
