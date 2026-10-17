"""Google Play feature graphic, 1024x500. Rendered at 2x and downscaled."""
import os, sys
from PIL import Image, ImageDraw, ImageFilter, ImageFont

project, fonts = sys.argv[1], sys.argv[2]
out_dir = os.path.join(project, "design", "store")
os.makedirs(out_dir, exist_ok=True)

S = 2
W, H = 1024 * S, 500 * S
NAVY, BLUE, TEAL, GREEN, PURPLE = (11, 31, 58), (21, 101, 192), (0, 172, 193), (67, 160, 71), (106, 27, 154)


def font(weight, size):
    return ImageFont.truetype(os.path.join(fonts, f"Poppins-{weight}.ttf"), size * S)


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


# Background: navy → brand blue, left to right
bg = Image.new("RGB", (W, H))
px = bg.load()
for x in range(W):
    t = x / (W - 1)
    c = lerp(NAVY, BLUE, min(1, t * 1.15))
    for y in range(H):
        px[x, y] = c
img = bg.convert("RGBA")

# Soft glows behind the tile
glow = Image.new("RGBA", (W, H), (0, 0, 0, 0))
g = ImageDraw.Draw(glow)
g.ellipse([W * 0.62, H * -0.15, W * 1.08, H * 0.85], fill=TEAL + (120,))
g.ellipse([W * 0.70, H * 0.45, W * 1.05, H * 1.25], fill=GREEN + (70,))
g.ellipse([W * 0.55, H * 0.55, W * 0.80, H * 1.20], fill=PURPLE + (60,))
img.alpha_composite(glow.filter(ImageFilter.GaussianBlur(90 * S)))

# Faint oversized % watermark on the left for texture
def percent_mask(size, stroke=0.085):
    m = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(m)
    r, w = size * 0.17, size * stroke
    for cx, cy in ((size * 0.30, size * 0.29), (size * 0.70, size * 0.71)):
        d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=255)
        d.ellipse([cx - r + w, cy - r + w, cx + r - w, cy + r - w], fill=0)
    a, b = (size * 0.24, size * 0.86), (size * 0.76, size * 0.14)
    d.line([a, b], fill=255, width=int(w))
    for x, y in (a, b):
        d.ellipse([x - w / 2, y - w / 2, x + w / 2, y + w / 2], fill=255)
    return m

wm = percent_mask(int(H * 1.3))
wm_layer = Image.new("RGBA", wm.size, (255, 255, 255, 0))
wm_layer.putalpha(wm.point(lambda v: v * 0.05))
img.alpha_composite(wm_layer, (int(-H * 0.35), int(-H * 0.15)))

# Right: white rounded tile with the gradient % (same mark as the splash)
tile = int(250 * S)
tx, ty = int(W * 0.735 - tile / 2), int(H / 2 - tile / 2)
shadow = Image.new("RGBA", (W, H), (0, 0, 0, 0))
ImageDraw.Draw(shadow).rounded_rectangle([tx + 6 * S, ty + 14 * S, tx + tile + 6 * S, ty + tile + 14 * S], radius=56 * S, fill=(0, 0, 0, 110))
img.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(18 * S)))
ImageDraw.Draw(img).rounded_rectangle([tx, ty, tx + tile, ty + tile], radius=56 * S, fill=(255, 255, 255, 255))

gsize = int(tile * 0.74)
grad = Image.new("RGB", (gsize, gsize))
gp = grad.load()
stops = [PURPLE, BLUE, TEAL, GREEN]
for y in range(gsize):
    for x in range(gsize):
        t = (x + y) / (2 * (gsize - 1))
        i = min(int(t * 3), 2)
        gp[x, y] = lerp(stops[i], stops[i + 1], t * 3 - i)
glyph = grad.convert("RGBA")
glyph.putalpha(percent_mask(gsize * 4).resize((gsize, gsize), Image.LANCZOS))
img.alpha_composite(glyph, (tx + (tile - gsize) // 2, ty + (tile - gsize) // 2))

# Example-result chips around the tile
def chip(text, cx, cy, accent):
    f = font("SemiBold", 19)
    d = ImageDraw.Draw(img)
    tw = d.textlength(text, font=f)
    pad_x, h = 20 * S, 44 * S
    x0, y0 = int(cx - tw / 2 - pad_x), int(cy - h / 2)
    x1, y1 = int(cx + tw / 2 + pad_x), int(cy + h / 2)
    sh = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(sh).rounded_rectangle([x0, y0 + 6 * S, x1, y1 + 6 * S], radius=h // 2, fill=(0, 0, 0, 80))
    img.alpha_composite(sh.filter(ImageFilter.GaussianBlur(10 * S)))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([x0, y0, x1, y1], radius=h // 2, fill=(255, 255, 255, 245))
    d.ellipse([x0 + 14 * S, cy - 6 * S, x0 + 26 * S, cy + 6 * S], fill=accent)
    d.text((x0 + pad_x + 12 * S, cy), text, font=f, fill=NAVY, anchor="lm")

chip("15% of 240 = 36", W * 0.735, ty - 6 * S, BLUE)
chip("80 − 25% = 60", tx + tile + 4 * S, H * 0.60, GREEN)
chip("Tip 10% = 12", tx - 18 * S, H * 0.70, TEAL)

# Left: name + tagline
d = ImageDraw.Draw(img)
left = int(72 * S)
d.text((left, int(H * 0.30)), "Percentage", font=font("Bold", 62), fill=(255, 255, 255), anchor="ls")
d.text((left, int(H * 0.30) + 72 * S), "Calculator", font=font("Bold", 62), fill=(255, 255, 255), anchor="ls")
d.rounded_rectangle([left, int(H * 0.30) + 96 * S, left + 70 * S, int(H * 0.30) + 102 * S], radius=3 * S, fill=TEAL)
tag = font("Medium", 22)
lines = ["Percent · Tip · Discount · VAT", "Margin · Grades · Loans"]
for i, line in enumerate(lines):
    d.text((left, int(H * 0.30) + 146 * S + i * 36 * S), line, font=tag, fill=(214, 227, 255), anchor="ls")

final = img.convert("RGB").resize((1024, 500), Image.LANCZOS)
path = os.path.join(out_dir, "feature_graphic_1024x500.png")
final.save(path, optimize=True)
print(path, final.size, os.path.getsize(path) // 1024, "KB")
