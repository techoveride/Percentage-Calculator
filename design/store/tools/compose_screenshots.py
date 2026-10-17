"""Frames raw app captures into Google Play screenshots (9:16) with captions."""
import os, sys
from PIL import Image, ImageDraw, ImageFilter, ImageFont

project, fonts = sys.argv[1], sys.argv[2]
raw_root = os.path.join(project, "design", "store", "screenshots", "raw")
out_root = os.path.join(project, "design", "store", "screenshots")

NAVY, BLUE, TEAL, GREEN, PURPLE = (11, 31, 58), (21, 101, 192), (0, 172, 193), (67, 160, 71), (106, 27, 154)

CAPTIONS = {
    "01_home": ("11 calculators", "in one app"),
    "02_percentage": ("Answers appear", "as you type"),
    "03_tip": ("Split the bill", "in seconds"),
    "04_discount": ("See exactly", "what you save"),
    "05_loan": ("Monthly payments", "made clear"),
    "06_history": ("Every calculation", "saved for later"),
    "07_dark": ("Easy on the eyes", "in dark mode"),
    "08_tax": ("Add or remove", "VAT instantly"),
}

# canvas size, raw-capture pixel ratio (to size the status bar)
DEVICES = {
    "phone": ((1080, 1920), 3),
    "tablet7": ((1440, 2560), 2),
    "tablet10": ((2160, 3840), 2),
}


def font(weight, size):
    return ImageFont.truetype(os.path.join(fonts, f"Poppins-{weight}.ttf"), size)


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def background(W, H):
    bg = Image.new("RGB", (W, H))
    d = ImageDraw.Draw(bg)
    for y in range(H):
        d.line([(0, y), (W, y)], fill=lerp(NAVY, BLUE, y / (H - 1)))
    img = bg.convert("RGBA")
    glow = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    g = ImageDraw.Draw(glow)
    g.ellipse([W * 0.45, H * 0.35, W * 1.35, H * 1.05], fill=TEAL + (90,))
    g.ellipse([-W * 0.4, H * 0.55, W * 0.45, H * 1.15], fill=PURPLE + (60,))
    img.alpha_composite(glow.filter(ImageFilter.GaussianBlur(W * 0.12)))
    return img


def with_status_bar(screen, ratio, inset_dp=16):
    """Adds a 24dp Android status bar in the app bar's colour."""
    h = int(24 * ratio)
    color = screen.getpixel((4, 4))[:3]
    dark_text = sum(color) / 3 > 140
    fg = (30, 30, 34) if dark_text else (240, 240, 245)
    out = Image.new("RGBA", (screen.width, screen.height + h), color + (255,))
    out.paste(screen, (0, h))
    d = ImageDraw.Draw(out)
    f = font("Medium", int(13 * ratio))
    d.text((int(inset_dp * ratio), h // 2), "9:41", font=f, fill=fg, anchor="lm")
    # battery
    bw, bh = int(20 * ratio), int(10 * ratio)
    bx, by = screen.width - int(inset_dp * ratio) - bw, h // 2 - bh // 2
    d.rounded_rectangle([bx, by, bx + bw, by + bh], radius=int(2 * ratio), outline=fg, width=max(1, int(ratio)))
    d.rectangle([bx + int(2 * ratio), by + int(2 * ratio), bx + int(bw * 0.8), by + bh - int(2 * ratio)], fill=fg)
    # signal bars
    sx = bx - int(26 * ratio)
    for i in range(4):
        bar_h = int((3 + i * 2.5) * ratio)
        x0 = sx + i * int(4 * ratio)
        d.rectangle([x0, h // 2 + int(5 * ratio) - bar_h, x0 + int(2.5 * ratio), h // 2 + int(5 * ratio)], fill=fg)
    return out


def frame(screen, target_h, corner):
    scale = target_h / screen.height
    s = screen.resize((int(screen.width * scale), target_h), Image.LANCZOS)
    bezel = max(10, int(s.width * 0.03))
    W, H = s.width + bezel * 2, s.height + bezel * 2
    body = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(body).rounded_rectangle([0, 0, W - 1, H - 1], radius=corner + bezel, fill=(24, 25, 30, 255))
    mask = Image.new("L", s.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, s.width - 1, s.height - 1], radius=corner, fill=255)
    body.paste(s, (bezel, bezel), mask)
    return body


for device, ((W, H), ratio) in DEVICES.items():
    out_dir = os.path.join(out_root, device)
    os.makedirs(out_dir, exist_ok=True)
    for name, (line1, line2) in CAPTIONS.items():
        raw = Image.open(os.path.join(raw_root, device, f"{name}.png")).convert("RGBA")
        screen = with_status_bar(raw, ratio, inset_dp=16 if device == 'phone' else 28)

        canvas = background(W, H)
        d = ImageDraw.Draw(canvas)
        size = int(W * 0.068)
        cap_top = int(H * 0.055)
        d.text((W // 2, cap_top + size), line1, font=font("Bold", size), fill=(255, 255, 255), anchor="ms")
        d.text((W // 2, cap_top + int(size * 2.25)), line2, font=font("Bold", size), fill=(158, 202, 255), anchor="ms")

        top = cap_top + int(size * 2.9)
        avail_h = H - top - int(H * 0.04)
        max_w = int(W * 0.84)
        target_h = min(avail_h, int(max_w * screen.height / screen.width))
        corner = int(min(target_h * 0.035, target_h * screen.width / screen.height * 0.05))
        phone = frame(screen, target_h, corner=corner)

        shadow = Image.new("RGBA", (W, H), (0, 0, 0, 0))
        px = (W - phone.width) // 2
        ImageDraw.Draw(shadow).rounded_rectangle(
            [px + 10, top + 30, px + phone.width + 10, top + phone.height + 30],
            radius=int(target_h * 0.04), fill=(0, 0, 0, 120))
        canvas.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(W * 0.02)))
        canvas.alpha_composite(phone, (px, top))

        path = os.path.join(out_dir, f"{name}.png")
        canvas.convert("RGB").save(path, optimize=True)
    print(device, (W, H), "->", out_dir)
