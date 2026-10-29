"""Ink Lab brand assets: one geometry, two outputs (SVG + PNG).

Reproducible, stdlib + Pillow only (no SVG renderer needed): every mark is
described once as flat shapes in a 1024-unit square, then written out as SVG
and rasterised with Pillow (4x supersampling, Lanczos downscale). Run from the
repo root:

    python tool/brand/render.py

Outputs
    assets/brand/icon.svg, icon-foreground.svg, icon-monochrome.svg
    assets/brand/options/*.svg are static round-2 concept references
    assets/brand/png/*.png           inputs for flutter_launcher_icons / splash
    docs/readme/es/header.png, docs/readme/en/header.png
    docs/release/store/feature-graphic.png (en), feature-graphic-es.png,
    docs/release/store/icon-512.png

Colours are real Ohuhu Oahu markers (code and hex from
assets/data/ohuhu_colors.json) on the Design G neutrals (docs/DESIGN_SPEC.md).
"""

from __future__ import annotations

import math
import os
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[2]
BRAND = ROOT / "assets" / "brand"
PNG = BRAND / "png"
FONTS = ROOT / "assets" / "fonts"

# Design G neutrals.
BG_LIGHT = "#F5F5F3"
BG_DARK = "#181A18"
ACTION = "#30382F"
FG = "#20211F"
FG2 = "#5C5F59"
FG_DARK = "#F2F3EF"
FG2_DARK = "#B7BDB3"
ACTION_DARK = "#D7DFCF"

# Real Ohuhu marker colours (newCode -> hex).
OHUHU = {
    "R014": "#DF3E35",  # Deep Vermilion
    "Y213": "#E49C01",  # Dark Marigold
    "BV312": "#2670B7",  # Deep Royal Blue
    "B111": "#07A5D7",  # Pool Blue
    "RV314": "#AE0777",  # Grape Juice
    "YR014": "#DA8560",  # Tuscan Orange
    "G013": "#7CB1B0",  # Muted Turquoise
    "G48": "#89C589",  # Lettuce
    "B114": "#2D6E9C",  # Cerulean Blue
}
CUT = "CUT"  # monochrome only: erase from the ink mask

U = 1024.0  # design units per icon side


# --------------------------------------------------------------------------
# Shapes. Each is a dict; `rot` = (degrees, cx, cy) rotates it about a point.
# --------------------------------------------------------------------------

def rrect(x, y, w, h, r, fill, rot=None):
    if isinstance(r, (int, float)):
        r = (r, r, r, r)  # tl, tr, br, bl
    return {"k": "rr", "x": x, "y": y, "w": w, "h": h, "r": r, "fill": fill, "rot": rot}


def poly(pts, fill, rot=None):
    return {"k": "poly", "pts": pts, "fill": fill, "rot": rot}


def circle(cx, cy, r, fill):
    return {"k": "circle", "cx": cx, "cy": cy, "r": r, "fill": fill, "rot": None}


def _rr_points(s, steps=24):
    x, y, w, h = s["x"], s["y"], s["w"], s["h"]
    tl, tr, br, bl = s["r"]
    pts = []

    def arc(cx, cy, rad, a0, a1):
        if rad <= 0:
            pts.append((cx, cy))
            return
        for i in range(steps + 1):
            a = math.radians(a0 + (a1 - a0) * i / steps)
            pts.append((cx + rad * math.cos(a), cy + rad * math.sin(a)))

    arc(x + tl, y + tl, tl, 180, 270)
    arc(x + w - tr, y + tr, tr, 270, 360)
    arc(x + w - br, y + h - br, br, 0, 90)
    arc(x + bl, y + h - bl, bl, 90, 180)
    return pts


def _rotate(pts, rot):
    if not rot:
        return pts
    deg, cx, cy = rot
    a = math.radians(deg)
    c, s = math.cos(a), math.sin(a)
    return [(cx + (px - cx) * c - (py - cy) * s, cy + (px - cx) * s + (py - cy) * c) for px, py in pts]


def transform(shapes, scale, dx=0.0, dy=0.0, fill=None):
    """Scale about the canvas centre then translate; optional flat recolour."""
    out = []
    c = U / 2

    def p(px, py):
        return (c + (px - c) * scale + dx, c + (py - c) * scale + dy)

    for s in shapes:
        s = dict(s)
        if fill:
            s["fill"] = fill
        if s["k"] == "rr":
            s["x"], s["y"] = p(s["x"], s["y"])
            s["w"] *= scale
            s["h"] *= scale
            s["r"] = tuple(v * scale for v in s["r"])
        elif s["k"] == "poly":
            s["pts"] = [p(*q) for q in s["pts"]]
        elif s["k"] == "circle":
            s["cx"], s["cy"] = p(s["cx"], s["cy"])
            s["r"] *= scale
        if s["rot"]:
            deg, rx, ry = s["rot"]
            s["rot"] = (deg, *p(rx, ry))
        out.append(s)
    return out


# --------------------------------------------------------------------------
# SVG output
# --------------------------------------------------------------------------

def _f(v):
    return f"{v:.2f}".rstrip("0").rstrip(".")


def _svg_shape(s):
    fill = s["fill"]
    tr = ""
    if s["rot"]:
        deg, cx, cy = s["rot"]
        tr = f' transform="rotate({_f(deg)} {_f(cx)} {_f(cy)})"'
    if s["k"] == "circle":
        return f'<circle cx="{_f(s["cx"])}" cy="{_f(s["cy"])}" r="{_f(s["r"])}" fill="{fill}"/>'
    if s["k"] == "poly":
        pts = " ".join(f"{_f(x)},{_f(y)}" for x, y in s["pts"])
        return f'<polygon points="{pts}" fill="{fill}"{tr}/>'
    x, y, w, h = s["x"], s["y"], s["w"], s["h"]
    tl, trr, br, bl = s["r"]
    if tl == trr == br == bl:
        rx = f' rx="{_f(tl)}"' if tl else ""
        return f'<rect x="{_f(x)}" y="{_f(y)}" width="{_f(w)}" height="{_f(h)}"{rx} fill="{fill}"{tr}/>'
    d = (
        f"M{_f(x + tl)} {_f(y)}H{_f(x + w - trr)}"
        + (f"A{_f(trr)} {_f(trr)} 0 0 1 {_f(x + w)} {_f(y + trr)}" if trr else "")
        + f"V{_f(y + h - br)}"
        + (f"A{_f(br)} {_f(br)} 0 0 1 {_f(x + w - br)} {_f(y + h)}" if br else "")
        + f"H{_f(x + bl)}"
        + (f"A{_f(bl)} {_f(bl)} 0 0 1 {_f(x)} {_f(y + h - bl)}" if bl else "")
        + f"V{_f(y + tl)}"
        + (f"A{_f(tl)} {_f(tl)} 0 0 1 {_f(x + tl)} {_f(y)}" if tl else "")
        + "Z"
    )
    return f'<path d="{d}" fill="{fill}"{tr}/>'


def write_svg(path, shapes, title, bg=None, bg_radius=0):
    body = []
    if bg:
        rx = f' rx="{bg_radius}"' if bg_radius else ""
        body.append(f'<rect width="1024" height="1024"{rx} fill="{bg}"/>')
    body += [_svg_shape(s) for s in shapes]
    svg = (
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" width="1024" height="1024">\n'
        f"  <title>{title}</title>\n  " + "\n  ".join(body) + "\n</svg>\n"
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(svg, encoding="utf-8")


# --------------------------------------------------------------------------
# PNG output (Pillow)
# --------------------------------------------------------------------------

SS = 4  # supersampling


def draw_shapes(img, shapes, box=(0, 0), size=None):
    """Draw unit-space shapes into img at box (x, y) with side `size` px."""
    size = size or img.width
    big = Image.new("RGBA", (size * SS, size * SS), (0, 0, 0, 0))
    d = ImageDraw.Draw(big)
    k = size * SS / U
    for s in shapes:
        if s["k"] == "circle":
            cx, cy, r = s["cx"] * k, s["cy"] * k, s["r"] * k
            d.ellipse((cx - r, cy - r, cx + r, cy + r), fill=s["fill"])
            continue
        pts = s["pts"] if s["k"] == "poly" else _rr_points(s)
        pts = _rotate(pts, s["rot"])
        d.polygon([(x * k, y * k) for x, y in pts], fill=s["fill"])
    small = big.resize((size, size), Image.LANCZOS)
    img.alpha_composite(small, dest=(int(box[0]), int(box[1])))


def icon_png(shapes, size, bg=None, radius=0, alpha=True):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    if bg:
        tile = [rrect(0, 0, U, U, radius, bg)] if radius else [rrect(0, 0, U, U, 0, bg)]
        draw_shapes(img, tile)
    draw_shapes(img, shapes)
    if not alpha:
        flat = Image.new("RGB", img.size, bg or "#FFFFFF")
        flat.paste(img, mask=img.split()[3])
        return flat
    return img


# --------------------------------------------------------------------------
# Marks
# --------------------------------------------------------------------------

def mark_chisel_i():
    """(Alternate, round 1) Chisel-stroke "I": two strokes of a chisel nib (the slanted ends a
    marker leaves) bracketing a swatch-chip stem. Vermilion, marigold, royal
    blue: R014, Y213, BV312."""
    slant = 44
    t = 136  # stroke thickness
    gap = 28
    x0, x1 = 232, 792
    top = 236
    stem_top = top + t + gap
    bot = 788 - t
    stem_w = 144
    sx = 512 - stem_w / 2
    return [
        poly([(x0 + slant, top), (x1, top), (x1 - slant, top + t), (x0, top + t)], OHUHU["R014"]),
        rrect(sx, stem_top, stem_w, bot - gap - stem_top, 14, OHUHU["Y213"]),
        poly([(x0 + slant, bot), (x1, bot), (x1 - slant, bot + t), (x0, bot + t)], OHUHU["BV312"]),
    ]


def _hex2rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i:i + 2], 16) / 255 for i in (0, 2, 4))


def multiply(*hs):
    """Flat stand-in for alcohol-ink layering (subtractive overlap)."""
    r = [1.0, 1.0, 1.0]
    for h in hs:
        r = [a * b for a, b in zip(r, _hex2rgb(h))]
    return "#" + "".join(f"{round(v * 255):02X}" for v in r)


def _area(pl):
    return sum(pl[i][0] * pl[i - 1][1] - pl[i - 1][0] * pl[i][1] for i in range(len(pl))) / 2


def clip(subject, clipper):
    """Sutherland-Hodgman; the clipper must be convex."""
    sign = 1 if _area(clipper) > 0 else -1
    out = list(subject)
    n = len(clipper)
    for i in range(n):
        a, b = clipper[i - 1], clipper[i]

        def inside(p):
            return sign * ((b[0] - a[0]) * (p[1] - a[1]) - (b[1] - a[1]) * (p[0] - a[0])) <= 0

        def inter(p, q):
            x1, y1, x2, y2 = p[0], p[1], q[0], q[1]
            x3, y3, x4, y4 = a[0], a[1], b[0], b[1]
            den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
            t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den
            return (x1 + t * (x2 - x1), y1 + t * (y2 - y1))

        inp, out = out, []
        if not inp:
            break
        for j in range(len(inp)):
            cur, prev = inp[j], inp[j - 1]
            if inside(cur):
                if not inside(prev):
                    out.append(inter(prev, cur))
                out.append(cur)
            elif inside(prev):
                out.append(inter(prev, cur))
    return out


def _rr_pts(x, y, w, h, r):
    return _rr_points(rrect(x, y, w, h, r, "#000"))


def mark_main():
    """Ink Cross (MAIN): a nib test. A broad chisel stroke (slanted ends, R014
    vermilion) crossed by a round fine-nib line (B114 blue); the crossing is
    the darker layered ink. Returns (colour shapes, monochrome shapes)."""
    broad = _rotate([(300, 430), (850, 430), (724, 594), (174, 594)], (-20, 512, 512))
    fine = _rotate(_rr_pts(206, 478, 612, 68, 34), (66, 512, 512))
    over = clip(fine, broad)
    col = [
        poly(broad, OHUHU["R014"]),
        poly(fine, OHUHU["B114"]),
        poly(over, multiply(OHUHU["R014"], OHUHU["B114"])),
    ]
    gap = _rotate(_rr_pts(206 - 26, 478 - 26, 612 + 52, 68 + 52, 60), (66, 512, 512))
    mono = [poly(broad, "#FFFFFF"), poly(gap, CUT), poly(fine, "#FFFFFF")]
    return col, mono


def mono_mask(shapes, size):
    big = Image.new("L", (size * SS, size * SS), 0)
    d = ImageDraw.Draw(big)
    k = size * SS / U
    for s in shapes:
        v = 0 if s["fill"] == CUT else 255
        pts = s["pts"] if s["k"] == "poly" else _rr_points(s)
        pts = _rotate(pts, s["rot"])
        d.polygon([(x * k, y * k) for x, y in pts], fill=v)
    return big.resize((size, size), Image.LANCZOS)


def mono_png(shapes, size):
    img = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    img.putalpha(mono_mask(shapes, size))
    return img


def write_mono_svg(path, shapes, title):
    body = []
    for s in shapes:
        s = dict(s)
        s["fill"] = "#000000" if s["fill"] == CUT else "#FFFFFF"
        body.append(_svg_shape(s))
    svg = (
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" width="1024" height="1024">\n'
        f"  <title>{title}</title>\n"
        '  <mask id="m" maskUnits="userSpaceOnUse" x="0" y="0" width="1024" height="1024">\n'
        '    <rect width="1024" height="1024" fill="#000000"/>\n    '
        + "\n    ".join(body)
        + '\n  </mask>\n  <rect width="1024" height="1024" fill="#FFFFFF" mask="url(#m)"/>\n</svg>\n'
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(svg, encoding="utf-8")


def plate(size, radius_frac, bg):
    """Rounded plate (for the mark on dark grounds)."""
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw_shapes(img, [rrect(0, 0, U, U, U * radius_frac, bg)])
    return img


def mark_alt1():
    """(Alternate) Marker caps from above: seven markers standing in a cup, seen top-down,
    each a dark cap shell around its colour-coded end. Hex-packed like a real
    bundle; centre R014, ring Y213 YR014 RV314 BV312 B111 G48."""
    c, d, r = 512, 236, 110
    ring = ["Y213", "YR014", "RV314", "BV312", "B111", "G48"]
    centres = [(c, c, "R014")] + [
        (c + d * math.cos(math.radians(-90 + 60 * i)), c + d * math.sin(math.radians(-90 + 60 * i)), ring[i])
        for i in range(6)
    ]
    out = []
    for x, y, code in centres:
        out.append(circle(x, y, r, ACTION))
        out.append(circle(x, y, r * 0.66, OHUHU[code]))
    return out


def mark_alt2():
    """(Alternate) Swatch fan deck: four swatch cards (colour block over a white body, the
    app's swatch cell) fanned from one rivet. YR014, R014, RV314, BV312."""
    pivot = (512, 736)
    w, h, r = 200, 480, 30
    out = []
    cols = [OHUHU["Y213"], OHUHU["R014"], OHUHU["RV314"], OHUHU["BV312"]]
    for i, ang in enumerate([-33, -11, 11, 33]):
        x, y = pivot[0] - w / 2, pivot[1] - h + 52
        rot = (ang, *pivot)
        out.append(rrect(x - 10, y - 10, w + 20, h + 20, r + 10, BG_DARK, rot))  # cut line
        out.append(rrect(x, y, w, h, r, "#FFFFFF", rot))
        out.append(rrect(x, y, w, h * 0.62, (r, r, 0, 0), cols[i], rot))
    out.append(circle(*pivot, 26, BG_DARK))
    out.append(circle(*pivot, 12, "#D5D7D1"))
    return out


# Adaptive icon safe zone: 66 of 108 dp (circle of radius 0.306 U). The mark
# is scaled so its farthest point stays inside radius 0.30 U.
def _fit_scale():
    col, _ = mark_main()
    far = 0.0
    for s in col:
        for x, y in s["pts"]:
            far = max(far, math.hypot(x - U / 2, y - U / 2))
    return min(0.74, 0.30 * U / far)


FG_SCALE = _fit_scale()
# flutter_launcher_icons wraps the foreground/monochrome PNGs in a 16 % inset
# (drawn at 68 %), so its inputs are pre-scaled to land exactly on FG_SCALE.
FG_INPUT_SCALE = FG_SCALE / 0.68


def main():
    PNG.mkdir(parents=True, exist_ok=True)
    m, mono = mark_main()

    # ---- SVG sources
    write_svg(BRAND / "icon.svg", m, "Ink Lab", bg=BG_LIGHT, bg_radius=224)
    write_svg(BRAND / "icon-foreground.svg", transform(m, FG_SCALE), "Ink Lab adaptive foreground")
    write_mono_svg(BRAND / "icon-monochrome.svg", transform(mono, FG_SCALE), "Ink Lab monochrome")

    # ---- launcher inputs
    icon_png(m, 1024, bg=BG_LIGHT, alpha=False).save(PNG / "icon-1024.png")  # iOS: no alpha
    icon_png(transform(m, FG_INPUT_SCALE), 1024).save(PNG / "icon-foreground.png")
    mono_png(transform(mono, FG_INPUT_SCALE), 1024).save(PNG / "icon-monochrome.png")

    # ---- splash: mark only, transparent (classic: 4x image; Android 12: 1152 canvas)
    icon_png(transform(m, 0.62), 768).save(PNG / "splash.png")
    icon_png(transform(m, 0.62), 1152).save(PNG / "splash-android12.png")
    # Dark ground: the overlap ink is near-black, so the mark rides a light plate.
    for size, scale, plate_scale, frac, name in [
        (768, 0.62, 0.70, 0.22, "splash-dark.png"),
        (1152, 0.46, 0.50, 0.5, "splash-android12-dark.png"),
    ]:
        img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
        ps = int(size * plate_scale)
        off = (size - ps) // 2
        img.alpha_composite(plate(ps, frac, BG_LIGHT), dest=(off, off))
        img.alpha_composite(icon_png(transform(m, scale), size))
        img.save(PNG / name)

    # ---- store icon
    store = ROOT / "docs" / "release" / "store"
    store.mkdir(parents=True, exist_ok=True)
    icon_png(m, 512, bg=BG_LIGHT, alpha=False).save(store / "icon-512.png")

    # ---- banners
    banner(ROOT / "docs" / "readme" / "es" / "header.png", "Tus rotuladores, tus paletas.", dark=False)
    banner(ROOT / "docs" / "readme" / "en" / "header.png", "Your markers, your palettes.", dark=False)
    banner(store / "feature-graphic.png", "Your markers, your palettes.", dark=True)
    banner(store / "feature-graphic-es.png", "Tus rotuladores, tus paletas.", dark=True)
    print("ok", round(FG_SCALE, 3))


# --------------------------------------------------------------------------
# Banners (1024 x 500, the proportions of the reference repos' headers and
# the Google Play feature graphic)
# --------------------------------------------------------------------------

def font(name, size, **axes):
    f = ImageFont.truetype(str(FONTS / name), size)
    vals = []
    for a in f.get_variation_axes():
        n = a["name"].decode() if isinstance(a["name"], bytes) else a["name"]
        vals.append(axes.get(n, a["default"]))
    f.set_variation_by_axes(vals)
    return f


STRIP = ["Y213", "YR014", "R014", "RV314", "BV312", "B111", "G013"]


def banner(path, tagline, dark):
    W, H = 1024, 500
    bg = ACTION if dark else BG_LIGHT
    fg = FG_DARK if dark else FG
    fg2 = ACTION_DARK if dark else FG2
    img = Image.new("RGBA", (W, H), bg)
    tile = 256
    ty = (H - tile) // 2
    # Icon tile: the light icon on both grounds.
    tile_img = icon_png(mark_main()[0], tile, bg=BG_LIGHT, radius=224)
    if not dark:  # hairline so the light tile holds its edge on the light banner
        edge = icon_png([], tile + 4, bg="#D9DAD5", radius=226)
        img.alpha_composite(edge, dest=(62, ty - 2))
    img.alpha_composite(tile_img, dest=(64, ty))

    d = ImageDraw.Draw(img)
    x = 64 + tile + 48
    title = font("archivo_variable.ttf", 104, Weight=800)
    d.text((x - 4, ty - 6), "Ink Lab", font=title, fill=fg)
    tag = font("inter_variable.ttf", 32, Weight=600, **{"Optical size": 32})
    d.text((x, ty + 116), tagline, font=tag, fill=fg)

    # Palette strip of real markers, codes below in JetBrains Mono.
    sw, sh = 72, 44
    sy = ty + 182
    strip = Image.new("RGBA", (sw * len(STRIP) * SS, sh * SS), (0, 0, 0, 0))
    sd = ImageDraw.Draw(strip)
    for i, c in enumerate(STRIP):
        sd.rectangle((i * sw * SS, 0, (i + 1) * sw * SS, sh * SS), fill=OHUHU[c])
    mask = Image.new("L", strip.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, strip.width - 1, strip.height - 1), radius=12 * SS, fill=255)
    strip.putalpha(mask)
    strip = strip.resize((sw * len(STRIP), sh), Image.LANCZOS)
    img.alpha_composite(strip, dest=(x, sy))
    mono = font("jetbrains_mono_variable.ttf", 15, Weight=500)
    for i, c in enumerate(STRIP):
        cx = x + i * sw + sw / 2
        d.text((cx, sy + sh + 10), c, font=mono, fill=fg2, anchor="mt")

    path.parent.mkdir(parents=True, exist_ok=True)
    img.convert("RGB").save(path)


if __name__ == "__main__":
    os.chdir(ROOT)
    main()
