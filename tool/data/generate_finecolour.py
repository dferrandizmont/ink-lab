#!/usr/bin/env python3
"""Generate assets/data/finecolour_colors.json from the pinned MIT catalogue.

Standard library only, Python 3.9+. Copyright (c) 2026 Scott G.F. Hong.
Hex values are sampled from the maker's chart and are approximate.
Use --from-file tool/data/baseline/finecolour_colors_source.js offline.
"""

import argparse
import json
from pathlib import Path
import re
import sys
import urllib.request

SOURCE_REPO = "https://github.com/scottgfhong310/finecolour-color"
SOURCE_COMMIT = "20878c90aed7061e4380d19d0f2206ffd01eefed"
SOURCE_URL = (
    "https://raw.githubusercontent.com/scottgfhong310/finecolour-color/"
    + SOURCE_COMMIT + "/public/apps/finecolour-color/data/finecolour-colors.js"
)
DEFAULT_OUT = Path(__file__).resolve().parents[2] / "assets/data/finecolour_colors.json"
EXPECTED_COUNT = 480
KNOWN_LINES = {"EF100", "EF101", "EF102", "EF103"}


def parse_source(source):
    """Ignore the preceding metadata; decode only the final JSON assignment.

    No JavaScript is executed. Expressions, trailing statements, comments inside
    the array and other non-JSON syntax are refused by json.loads.
    """
    assignments = list(re.finditer(r"^window\.FINECOLOUR_COLORS\s*=\s*", source, re.M))
    if len(assignments) != 1:
        raise ValueError("expected one FINECOLOUR_COLORS assignment")
    payload = source[assignments[0].end():].strip()
    if payload.endswith(";"):
        payload = payload[:-1].rstrip()
    return json.loads(payload, parse_constant=lambda value: _invalid_constant(value))


def _invalid_constant(value):
    raise ValueError("invalid JSON constant: %s" % value)


def build(rows):
    """Import only alcohol markers, in source order, with no retail sets."""
    if not isinstance(rows, list) or any(not isinstance(row, dict) for row in rows):
        raise ValueError("expected a list of colour objects")
    markers = [row for row in rows if row.get("space") == "marker"]
    if len(markers) != EXPECTED_COUNT:
        raise ValueError("expected exactly 480 markers")
    colors, codes = [], set()
    for row in markers:
        code, name, hex_value = row.get("code"), row.get("name"), row.get("hex")
        if not isinstance(code, str) or not code.strip():
            raise ValueError("empty or invalid code")
        code = code.strip().upper()
        if code in codes:
            raise ValueError("duplicate code: %s" % code)
        if not isinstance(name, str) or not name.strip():
            raise ValueError("empty name: %s" % code)
        if not isinstance(hex_value, str):
            raise ValueError("invalid hex: %s" % code)
        hex_value = hex_value.strip().removeprefix("#").lower()
        if not re.fullmatch(r"[0-9a-f]{6}", hex_value):
            raise ValueError("invalid hex: %s" % code)
        lines = row.get("lines")
        if (not isinstance(lines, list) or not lines
                or any(not isinstance(line, str) or line not in KNOWN_LINES for line in lines)
                or len(set(lines)) != len(lines)):
            raise ValueError("invalid lines: %s" % code)
        codes.add(code)
        colors.append({"code": code, "name": name.strip(), "hex": hex_value,
                       "sets": [], "lines": list(lines)})
    return colors


def render(colors):
    return json.dumps(colors, ensure_ascii=True, indent=2) + "\n"


class PinnedRedirectHandler(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        # Reject before following, so downloads never visit another host/commit.
        if newurl != SOURCE_URL:
            raise ValueError("unexpected Finecolour source redirect")
        return super().redirect_request(req, fp, code, msg, headers, newurl)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--from-file", type=Path)
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    try:
        if args.from_file:
            source = args.from_file.read_text(encoding="utf-8")
        else:
            opener = urllib.request.build_opener(PinnedRedirectHandler())
            with opener.open(SOURCE_URL, timeout=30) as response:
                if response.geturl() != SOURCE_URL:
                    raise ValueError("unexpected Finecolour source redirect")
                source = response.read().decode("utf-8")
        text = render(build(parse_source(source)))
    except (OSError, ValueError) as error:
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
    print("Wrote 480 colours to %s" % args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
