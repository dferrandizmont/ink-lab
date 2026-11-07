"""Shared helpers for the generators that read official PDF colour charts.

Standard library plus PyMuPDF (`fitz`) only. The charts are drawn as vector
shapes (or flat fills inside transparency groups), so the colour a person sees
is obtained by rendering the page *without its text* and taking the median of
a small patch at a known point of the swatch. Medians, not single pixels, so
anti-aliasing and printing marks cannot decide the value.

Hex values obtained this way are approximate screen colours from the official
chart, not measured ink specifications.
"""

import re
import statistics
import unicodedata

import fitz  # PyMuPDF

DPI = 144
SCALE = DPI / 72.0
PATCH = 4  # half-size in pixels: a 9x9 patch


def clean_text(value):
    """NFKC (ligatures such as the fi in Starfish), single spaces, stripped."""
    return re.sub(r"\s+", " ", unicodedata.normalize("NFKC", value)).strip()


def text_lines(page):
    """Every text line of the page as (text, x0, y0, x1, y1), in page points."""
    lines = []
    for block in page.get_text("dict")["blocks"]:
        for line in block.get("lines", []):
            text = clean_text("".join(span["text"] for span in line["spans"]))
            if text:
                x0, y0, x1, y1 = line["bbox"]
                lines.append((text, x0, y0, x1, y1))
    return lines


def text_words(page):
    """Words of the page as (text, x0, y0, x1, y1)."""
    return [(clean_text(w[4]), w[0], w[1], w[2], w[3])
            for w in page.get_text("words") if clean_text(w[4])]


def render_without_text(document, page_number):
    """Render a page with its text removed (in memory; nothing is saved)."""
    page = document[page_number]
    for word in page.get_text("words"):
        page.add_redact_annot(fitz.Rect(word[:4]))
    page.apply_redactions(images=fitz.PDF_REDACT_IMAGE_NONE,
                          graphics=fitz.PDF_REDACT_LINE_ART_NONE)
    return page.get_pixmap(dpi=DPI, alpha=False)


def median_hex(pixmap, x, y):
    """Lowercase hex of the per-channel median of a 9x9 patch at page point."""
    px, py = int(round(x * SCALE)), int(round(y * SCALE))
    samples = [pixmap.pixel(px + dx, py + dy)
               for dx in range(-PATCH, PATCH + 1)
               for dy in range(-PATCH, PATCH + 1)]
    channels = [int(statistics.median(sample[i] for sample in samples))
                for i in range(3)]
    return "%02x%02x%02x" % tuple(channels)


def fills(page, items=None, max_width=None):
    """Filled vector shapes as (rect, rgb 0-255 tuple, points)."""
    result = []
    for drawing in page.get_drawings():
        if not drawing["fill"]:
            continue
        if items is not None and len(drawing["items"]) != items:
            continue
        rect = drawing["rect"]
        if max_width is not None and rect.width > max_width:
            continue
        points = []
        for item in drawing["items"]:
            if item[0] == "l":
                points += [item[1], item[2]]
        result.append((rect, tuple(round(255 * v) for v in drawing["fill"]),
                       points))
    return result


def hex_distance(a, b):
    return max(abs(int(a[i:i + 2], 16) - int(b[i:i + 2], 16)) for i in (0, 2, 4))


def valid_hex(value):
    return isinstance(value, str) and re.fullmatch(r"[0-9a-f]{6}", value) is not None


def render_json(colors):
    import json
    return json.dumps(colors, ensure_ascii=True, indent=2) + "\n"


def check_or_write(text, out, check, label):
    """Shared --check/write tail. Returns the process exit code."""
    if check:
        try:
            current = out.read_bytes()
        except OSError:
            current = None
        if current != text.encode("utf-8"):
            print("CHECK FAILED: %s differs from generated output" % out)
            return 1
        print("check ok: %s is up to date" % out)
        return 0
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", encoding="utf-8", newline="\n") as handle:
        handle.write(text)
    print("Wrote %s to %s" % (label, out))
    return 0
