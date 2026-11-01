#!/usr/bin/env python3
"""Generate assets/data/copic_colors.json from the pinned Copic catalogue.

Standard library only, Python 3.9+. Source: meodai/copic-colors (MIT,
Copyright (c) 2023 David Aerne; full notice in NOTICE.md).
Only factual number/name/hex fields are imported, never extractedColor.

Usage:
  python tool/data/generate_copic.py
  python tool/data/generate_copic.py --from-file /tmp/colors.json
  python tool/data/generate_copic.py --from-file /tmp/colors.json --check
"""

import argparse
import json
from pathlib import Path
import re
import sys
import urllib.request

SOURCE_REPO = "https://github.com/meodai/copic-colors"
SOURCE_COMMIT = "b495dad1e26202534d48587bf271aa3c0247f215"
SOURCE_URL = (
    "https://raw.githubusercontent.com/meodai/copic-colors/"
    + SOURCE_COMMIT + "/colors.json"
)
DEFAULT_OUT = Path(__file__).resolve().parents[2] / "assets/data/copic_colors.json"
EXPECTED_COUNT = 358


def build(rows):
    """Validate the entire input before returning records in source order."""
    if not isinstance(rows, list) or len(rows) != EXPECTED_COUNT:
        raise ValueError("expected exactly 358 colours")
    colors = []
    codes = set()
    for row in rows:
        if not isinstance(row, dict):
            raise ValueError("expected a colour object")
        code = row.get("number")
        name = row.get("name")
        hex_value = row.get("hex")
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
        codes.add(code)
        colors.append({"code": code, "name": name.strip(),
                       "hex": hex_value, "sets": []})
    if "0" not in codes:
        raise ValueError("missing colourless blender (0)")
    return colors


def render(colors):
    """Stable key/source order, LF endings and one trailing newline."""
    return json.dumps(colors, ensure_ascii=True, indent=2) + "\n"


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--from-file", type=Path,
                        help="offline rebuild from the source colors.json")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--check", action="store_true",
                        help="do not write; exit 1 if the file would change")
    args = parser.parse_args(argv)
    try:
        if args.from_file:
            source = args.from_file.read_text(encoding="utf-8")
        else:
            with urllib.request.urlopen(SOURCE_URL, timeout=30) as response:
                if not response.geturl().startswith(
                    "https://raw.githubusercontent.com/meodai/copic-colors/"
                ):
                    raise ValueError("unexpected Copic source redirect")
                source = response.read().decode("utf-8")
        text = render(build(json.loads(source)))
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
    print("Wrote 358 colours to %s" % args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
