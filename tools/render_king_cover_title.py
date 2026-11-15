from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "docs" / "previews" / "cover-king-left-clean.png"
OUTPUT = ROOT / "docs" / "previews" / "cover-king-final.png"
FONT_DIR = Path("C:/Windows/Fonts")
SCALE = 2

CREAM = (244, 231, 202, 255)
CHAMPAGNE = (214, 181, 118, 235)
MUTED = (206, 189, 158, 218)
SHADOW = (5, 13, 31, 190)
PAGE_LINE = (230, 210, 177, 142)
PAGE_LINE_DIM = (218, 190, 149, 92)
PAGE_CORNER_FILL = (230, 210, 177, 22)


def load_font(path: Path, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(str(path), size=size * SCALE)


def text_width(draw: ImageDraw.ImageDraw, text: str, font: ImageFont.FreeTypeFont) -> int:
    box = draw.textbbox((0, 0), text, font=font)
    return box[2] - box[0]


def draw_tracked(
    draw: ImageDraw.ImageDraw,
    center_x: int,
    y: int,
    text: str,
    font: ImageFont.FreeTypeFont,
    fill: tuple[int, int, int, int],
    tracking: int,
) -> None:
    widths = [draw.textlength(character, font=font) for character in text]
    total = sum(widths) + tracking * SCALE * max(0, len(text) - 1)
    x = center_x - total / 2
    for character, width in zip(text, widths):
        draw.text((x, y), character, font=font, fill=fill, anchor="la")
        x += width + tracking * SCALE


def draw_centered(
    draw: ImageDraw.ImageDraw,
    center_x: int,
    y: int,
    text: str,
    font: ImageFont.FreeTypeFont,
    fill: tuple[int, int, int, int],
) -> None:
    draw.text((center_x, y), text, font=font, fill=fill, anchor="ma")


def bezier_points(
    start: tuple[float, float],
    control_a: tuple[float, float],
    control_b: tuple[float, float],
    end: tuple[float, float],
    steps: int = 40,
) -> list[tuple[float, float]]:
    points = []
    for index in range(steps + 1):
        t = index / steps
        inverse = 1.0 - t
        x = (
            inverse**3 * start[0]
            + 3.0 * inverse**2 * t * control_a[0]
            + 3.0 * inverse * t**2 * control_b[0]
            + t**3 * end[0]
        )
        y = (
            inverse**3 * start[1]
            + 3.0 * inverse**2 * t * control_a[1]
            + 3.0 * inverse * t**2 * control_b[1]
            + t**3 * end[1]
        )
        points.append((x * SCALE, y * SCALE))
    return points


def draw_polyline(
    draw: ImageDraw.ImageDraw,
    points: list[tuple[float, float]],
    fill: tuple[int, int, int, int],
    width: int = 1,
) -> None:
    draw.line(points, fill=fill, width=width * SCALE, joint="curve")


base = Image.open(SOURCE).convert("RGBA")
canvas = Image.new("RGBA", (base.width * SCALE, base.height * SCALE), (0, 0, 0, 0))
ornament_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
text_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
shadow_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))

ornament_draw = ImageDraw.Draw(ornament_layer)
draw = ImageDraw.Draw(text_layer)
shadow_draw = ImageDraw.Draw(shadow_layer)

block_center = 1180 * SCALE

script_font = load_font(FONT_DIR / "FRSCRIPT.TTF", 92)
title_font = load_font(ROOT / "assets" / "ui" / "fonts" / "ZCOOLXiaoWei-Regular.ttf", 142)
subtitle_font = load_font(ROOT / "assets" / "ui" / "fonts" / "ZCOOLXiaoWei-Regular.ttf", 77)
meta_font = load_font(FONT_DIR / "NotoSerifSC-VF.ttf", 27)
tagline_font = load_font(FONT_DIR / "NotoSerifSC-VF.ttf", 22)

# An incomplete folio frame follows the open edge of a book page. The short
# left-side strokes intentionally leave the composition open toward the planet.
draw_polyline(
    ornament_draw,
    [
        (914 * SCALE, 91 * SCALE),
        (914 * SCALE, 130 * SCALE),
    ],
    PAGE_LINE,
    width=2,
)
draw_polyline(
    ornament_draw,
    [
        (927 * SCALE, 71 * SCALE),
        (1457 * SCALE, 66 * SCALE),
        (1518 * SCALE, 67 * SCALE),
    ]
    + bezier_points(
        (1518, 67),
        (1551, 68),
        (1571, 79),
        (1572, 109),
    )
    + [
        (1572 * SCALE, 818 * SCALE),
    ],
    PAGE_LINE,
    width=2,
)
draw_polyline(
    ornament_draw,
    [
        (1585 * SCALE, 143 * SCALE),
        (1586 * SCALE, 372 * SCALE),
        (1585 * SCALE, 638 * SCALE),
        (1585 * SCALE, 742 * SCALE),
    ],
    PAGE_LINE_DIM,
)
draw_polyline(
    ornament_draw,
    [
        (914 * SCALE, 790 * SCALE),
        (914 * SCALE, 870 * SCALE),
    ]
    + bezier_points(
        (914, 870),
        (914, 889),
        (925, 900),
        (946, 900),
    )
    + [
        (980 * SCALE, 899 * SCALE),
    ],
    PAGE_LINE,
    width=2,
)

# A sharply folded paper corner replaces the former rounded bottom-right arc.
fold_top = (1572 * SCALE, 818 * SCALE)
fold_inner = (1492 * SCALE, 900 * SCALE)
fold_outer = (1572 * SCALE, 900 * SCALE)
ornament_draw.polygon(
    [fold_top, fold_inner, fold_outer],
    fill=PAGE_CORNER_FILL,
)
draw_polyline(
    ornament_draw,
    [
        fold_inner,
        fold_top,
        fold_outer,
        fold_inner,
    ],
    PAGE_LINE,
    width=2,
)
draw_polyline(
    ornament_draw,
    [
        (1559 * SCALE, 836 * SCALE),
        (1520 * SCALE, 873 * SCALE),
        (1537 * SCALE, 888 * SCALE),
    ],
    PAGE_LINE_DIM,
)
draw_polyline(
    ornament_draw,
    [
        (1368 * SCALE, 900 * SCALE),
        (1492 * SCALE, 900 * SCALE),
    ],
    PAGE_LINE,
    width=2,
)

# A restrained script line introduces the Chinese title without competing with it.
draw_centered(draw, block_center, 200 * SCALE, "Le Petit Prince", script_font, CHAMPAGNE)
draw_centered(shadow_draw, block_center + 2 * SCALE, 204 * SCALE, "Le Petit Prince", script_font, SHADOW)

draw_tracked(
    draw,
    block_center,
    310 * SCALE,
    "小王子",
    title_font,
    CREAM,
    22,
)
draw_tracked(
    shadow_draw,
    block_center + 2 * SCALE,
    315 * SCALE,
    "小王子",
    title_font,
    SHADOW,
    22,
)

draw_tracked(
    draw,
    block_center,
    474 * SCALE,
    "纸间星旅",
    subtitle_font,
    CREAM,
    14,
)
draw_tracked(
    shadow_draw,
    block_center + 2 * SCALE,
    478 * SCALE,
    "纸间星旅",
    subtitle_font,
    SHADOW,
    14,
)

# The divider echoes the thin gold orbit line around the planet.
divider_y = 592 * SCALE
line_half = 244 * SCALE
draw.line(
    (
        block_center - line_half,
        divider_y,
        block_center - 22 * SCALE,
        divider_y,
    ),
    fill=CHAMPAGNE,
    width=1 * SCALE,
)
draw.line(
    (
        block_center + 22 * SCALE,
        divider_y,
        block_center + line_half,
        divider_y,
    ),
    fill=CHAMPAGNE,
    width=1 * SCALE,
)
diamond = 6 * SCALE
draw.polygon(
    [
        (block_center, divider_y - diamond),
        (block_center + diamond, divider_y),
        (block_center, divider_y + diamond),
        (block_center - diamond, divider_y),
    ],
    fill=CHAMPAGNE,
)

draw_centered(draw, block_center, 631 * SCALE, "3D 星球互动叙事", meta_font, CREAM)
draw_centered(
    draw,
    block_center,
    686 * SCALE,
    "一场穿行于六颗星球的互动叙事",
    tagline_font,
    MUTED,
)

# A soft, colored shadow keeps the type legible over stars without a hard box.
shadow_layer = shadow_layer.filter(ImageFilter.GaussianBlur(7 * SCALE))
canvas.alpha_composite(shadow_layer)
canvas.alpha_composite(ornament_layer)
canvas.alpha_composite(text_layer)
canvas = canvas.resize(base.size, Image.Resampling.LANCZOS)

final = Image.alpha_composite(base, canvas).convert("RGB")
OUTPUT.parent.mkdir(parents=True, exist_ok=True)
final.save(OUTPUT, quality=96)
print(OUTPUT)
