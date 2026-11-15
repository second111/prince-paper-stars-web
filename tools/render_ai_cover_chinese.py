from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont


SOURCE = Path("C:/Users/ctyb/Desktop/20261114144316-b8053e6d-53001735.png")
PROJECT_OUTPUT = (
    Path(__file__).resolve().parents[1]
    / "docs"
    / "previews"
    / "cover-king-ai-chinese.png"
)
DESKTOP_OUTPUT = Path(
    "C:/Users/ctyb/Desktop/20261114144316-b8053e6d-53001735_中文标题版.png"
)

ROOT = Path(__file__).resolve().parents[1]
FONT_DIR = Path("C:/Windows/Fonts")
SCALE = 3

CREAM = (249, 235, 202, 255)
CHAMPAGNE = (220, 181, 113, 245)
MUTED = (225, 202, 159, 225)
SHADOW = (3, 12, 34, 205)


def font(path: Path, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(str(path), size=size * SCALE)


def tracked_width(
    draw: ImageDraw.ImageDraw,
    text: str,
    text_font: ImageFont.FreeTypeFont,
    tracking: int,
) -> float:
    return (
        sum(draw.textlength(character, font=text_font) for character in text)
        + tracking * SCALE * max(0, len(text) - 1)
    )


def draw_tracked(
    draw: ImageDraw.ImageDraw,
    center_x: int,
    y: int,
    text: str,
    text_font: ImageFont.FreeTypeFont,
    fill: tuple[int, int, int, int],
    tracking: int,
) -> None:
    widths = [draw.textlength(character, font=text_font) for character in text]
    x = center_x - tracked_width(draw, text, text_font, tracking) / 2
    for character, width in zip(text, widths):
        draw.text((x, y), character, font=text_font, fill=fill, anchor="la")
        x += width + tracking * SCALE


def draw_centered(
    draw: ImageDraw.ImageDraw,
    center_x: int,
    y: int,
    text: str,
    text_font: ImageFont.FreeTypeFont,
    fill: tuple[int, int, int, int],
) -> None:
    draw.text((center_x, y), text, font=text_font, fill=fill, anchor="ma")


base = Image.open(SOURCE).convert("RGBA")
canvas = Image.new("RGBA", (base.width * SCALE, base.height * SCALE), (0, 0, 0, 0))
text_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
shadow_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))

draw = ImageDraw.Draw(text_layer)
shadow_draw = ImageDraw.Draw(shadow_layer)

center_x = 1180 * SCALE
series_font = font(ROOT / "assets" / "ui" / "fonts" / "ZCOOLXiaoWei-Regular.ttf", 51)
subtitle_font = font(FONT_DIR / "NotoSerifSC-VF.ttf", 25)
tagline_font = font(FONT_DIR / "NotoSerifSC-VF.ttf", 19)

draw_tracked(draw, center_x, 600 * SCALE, "纸间星旅", series_font, CHAMPAGNE, 11)
draw_tracked(
    shadow_draw,
    center_x + 2 * SCALE,
    605 * SCALE,
    "纸间星旅",
    series_font,
    SHADOW,
    11,
)

divider_y = 689 * SCALE
line_half = 194 * SCALE
for start_x, end_x in (
    (center_x - line_half, center_x - 19 * SCALE),
    (center_x + 19 * SCALE, center_x + line_half),
):
    draw.line(
        (start_x, divider_y, end_x, divider_y),
        fill=CHAMPAGNE,
        width=1 * SCALE,
    )
diamond = 5 * SCALE
draw.polygon(
    [
        (center_x, divider_y - diamond),
        (center_x + diamond, divider_y),
        (center_x, divider_y + diamond),
        (center_x - diamond, divider_y),
    ],
    fill=CHAMPAGNE,
)

draw_centered(draw, center_x, 723 * SCALE, "3D 星球互动叙事", subtitle_font, CREAM)
draw_centered(
    draw,
    center_x,
    763 * SCALE,
    "一场穿行于六颗星球的互动叙事",
    tagline_font,
    MUTED,
)

shadow_layer = shadow_layer.filter(ImageFilter.GaussianBlur(5 * SCALE))
canvas.alpha_composite(shadow_layer)
canvas.alpha_composite(text_layer)
canvas = canvas.resize(base.size, Image.Resampling.LANCZOS)

result = Image.alpha_composite(base, canvas).convert("RGB")
PROJECT_OUTPUT.parent.mkdir(parents=True, exist_ok=True)
result.save(PROJECT_OUTPUT, quality=96)
result.save(DESKTOP_OUTPUT, quality=96)
print(PROJECT_OUTPUT)
print(DESKTOP_OUTPUT)
