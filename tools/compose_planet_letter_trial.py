from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont, ImageOps


ROOT = Path(__file__).resolve().parents[1]
DESKTOP = Path.home() / "Desktop"
FRAME_PATH = DESKTOP / "3331.png"
BACKDROP_PATH = DESKTOP / "20261109082558-6c1bf090-e6d7d0fd.png"
ASSET_SHEET_PATH = DESKTOP / "20261109083436-dd9c7831-f73022f9.png"
PHOTO_PATH = ROOT / "analysis" / "current_player_layout_clean.png"
OUTPUT_PATH = ROOT / "analysis" / "planet_letter_composition_trial.png"
FONT_PATH = ROOT / "assets" / "ui" / "fonts" / "ZCOOLXiaoWei-Regular.ttf"
BODY_FONT_PATH = Path("C:/Windows/Fonts/NotoSerifSC-VF.ttf")

WIDTH = 1440
HEIGHT = 1440


def crop_alpha(image: Image.Image, box: tuple[int, int, int, int]) -> Image.Image:
    cropped = image.crop(box)
    alpha = cropped.getchannel("A")
    return cropped.crop(alpha.getbbox() or (0, 0, *cropped.size))


def fit_fill(image: Image.Image, size: tuple[int, int]) -> Image.Image:
    return ImageOps.fit(
        image.convert("RGB"),
        size,
        method=Image.Resampling.LANCZOS,
        centering=(0.5, 0.48),
    )


def paste_rotated(
    canvas: Image.Image,
    asset: Image.Image,
    center: tuple[int, int],
    size: tuple[int, int],
    angle: float,
    shadow: bool = False,
) -> None:
    resized = asset.resize(size, Image.Resampling.LANCZOS)
    rotated = resized.rotate(
        angle,
        resample=Image.Resampling.BICUBIC,
        expand=True,
    )
    position = (
        round(center[0] - rotated.width / 2),
        round(center[1] - rotated.height / 2),
    )
    if shadow:
        alpha = rotated.getchannel("A")
        shadow_image = Image.new(
            "RGBA",
            rotated.size,
            (26, 22, 17, 0),
        )
        shadow_image.putalpha(alpha.point(lambda value: value * 0.28))
        shadow_image = shadow_image.filter(ImageFilter.GaussianBlur(10))
        canvas.alpha_composite(
            shadow_image,
            (position[0] + 8, position[1] + 12),
        )
    canvas.alpha_composite(rotated, position)


def wrap_by_width(
    draw: ImageDraw.ImageDraw,
    text: str,
    font: ImageFont.FreeTypeFont,
    width: int,
) -> list[str]:
    lines: list[str] = []
    current = ""
    for character in text:
        candidate = current + character
        if not current or draw.textlength(candidate, font=font) <= width:
            current = candidate
            continue
        lines.append(current)
        current = character
    if current:
        lines.append(current)
    return lines


def font_line_height(font: ImageFont.FreeTypeFont) -> int:
    ascent, descent = font.getmetrics()
    return ascent + descent


def load_bold_font(size: int) -> ImageFont.FreeTypeFont:
    font = ImageFont.truetype(str(BODY_FONT_PATH), size)
    font.set_variation_by_name("Bold")
    return font


def draw_left_block(
    draw: ImageDraw.ImageDraw,
    text: str,
    font: ImageFont.FreeTypeFont,
    left: int,
    top: int,
    width: int,
    fill: tuple[int, int, int, int],
    line_height: int,
) -> int:
    lines = wrap_by_width(draw, text, font, width)
    y = top
    for line in lines:
        draw.text(
            (left, y),
            line,
            font=font,
            fill=fill,
            anchor="la",
        )
        y += line_height
    return y


def main() -> None:
    backdrop = Image.open(BACKDROP_PATH).convert("RGBA")
    frame = Image.open(FRAME_PATH).convert("RGBA")
    assets = Image.open(ASSET_SHEET_PATH).convert("RGBA")
    photo = Image.open(PHOTO_PATH).convert("RGB")

    backdrop_page = backdrop.resize((WIDTH, WIDTH), Image.Resampling.LANCZOS)
    canvas = Image.new("RGBA", (WIDTH, HEIGHT), (18, 38, 63, 255))
    canvas.alpha_composite(backdrop_page, (0, 0))

    # The supplied photo frame is kept upright in its source file. The demo
    # rotates the complete card, including the inserted screenshot.
    frame_crop = frame.crop(frame.getchannel("A").getbbox())
    frame_card = frame_crop.copy()
    window_box = (110, 107, 727, 494)
    window_size = (
        window_box[2] - window_box[0],
        window_box[3] - window_box[1],
    )
    frame_card.alpha_composite(
        fit_fill(photo, window_size).convert("RGBA"),
        (window_box[0], window_box[1]),
    )
    paste_rotated(
        canvas,
        frame_card,
        (720, 1118),
        (700, 498),
        -1.8,
        shadow=True,
    )

    seal = crop_alpha(assets, (54, 42, 477, 463))
    stamp = crop_alpha(assets, (570, 30, 944, 472))

    paste_rotated(canvas, seal, (385, 238), (190, 190), -4.5, shadow=True)
    paste_rotated(canvas, stamp, (1210, 223), (178, 224), 5.5, shadow=True)

    draw = ImageDraw.Draw(canvas, "RGBA")
    title_font = ImageFont.truetype(str(FONT_PATH), 60)
    class_font = load_bold_font(34)
    body_font = load_bold_font(26)
    label_font = load_bold_font(24)
    body_line_height = font_line_height(body_font)
    label_line_height = font_line_height(label_font)

    draw.text(
        (724, 206),
        "晚风小星球",
        font=title_font,
        fill=(118, 50, 39, 255),
        anchor="ma",
    )
    draw.text(
        (724, 328),
        "温柔 · 自在星球",
        font=class_font,
        fill=(69, 102, 64, 255),
        anchor="ma",
    )

    narrative = (
        "你用茶香、花和一点点陪伴，把这里布置成一颗愿意倾听的星球。"
    )
    next_y = draw_left_block(
        draw,
        narrative,
        body_font,
        340,
        405,
        760,
        (74, 51, 36, 255),
        body_line_height,
    )

    paragraph_gap = body_line_height
    label_y = next_y + paragraph_gap
    draw.text(
        (340, label_y),
        "星球手记",
        font=label_font,
        fill=(151, 107, 52, 255),
        anchor="la",
    )
    what_done = (
        "你搭起小屋，围着长桌与野餐垫摆好面包、书和花瓶，"
        "又让秋千、长椅、纸船、花丛和路灯散在草地周围。"
        "狐狸、麦子、玫瑰、镜子和账簿也从旅途中来到了这里。"
    )
    next_y = draw_left_block(
        draw,
        what_done,
        body_font,
        340,
        label_y + label_line_height,
        760,
        (74, 51, 36, 255),
        body_line_height,
    )

    label_y = next_y + paragraph_gap
    draw.text(
        (340, label_y),
        "此刻的星球",
        font=label_font,
        fill=(151, 107, 52, 255),
        anchor="la",
    )
    echo = (
        "小王子与长发小人并肩站在草地中央。小屋的灯和路灯一起亮着，"
        "纸船停在小桥边；玫瑰、狐狸和镜子留在近旁，"
        "远处的瀑布把夜色轻轻带下去。"
    )
    draw_left_block(
        draw,
        echo,
        body_font,
        340,
        label_y + label_line_height,
        760,
        (74, 51, 36, 255),
        body_line_height,
    )

    canvas.convert("RGB").save(OUTPUT_PATH, quality=95)
    print(f"WROTE {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
