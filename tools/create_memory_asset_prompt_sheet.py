from __future__ import annotations

import math
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "docs" / "星光收集_一页提示词总览.png"
WIDTH, HEIGHT = 2400, 3200

WHITE = "#ffffff"
INK = "#2d2923"
MUTED = "#7a7064"
LINE = "#d9d0c2"
PAPER = "#f4ecde"
PAPER_DARK = "#d8c5a4"
GOLD = "#c49543"
PALE_GOLD = "#ead5a5"

REGULAR_FONT = "C:/Windows/Fonts/msyh.ttc"
BOLD_FONT = "C:/Windows/Fonts/msyhbd.ttc"
SERIF_FONT = "C:/Windows/Fonts/simsun.ttc"


def font(size: int, *, bold: bool = False, serif: bool = False) -> ImageFont.FreeTypeFont:
    path = SERIF_FONT if serif else (BOLD_FONT if bold else REGULAR_FONT)
    return ImageFont.truetype(path, size=size)


def color(hex_value: str, alpha: int = 255) -> tuple[int, int, int, int]:
    value = hex_value.lstrip("#")
    return (
        int(value[0:2], 16),
        int(value[2:4], 16),
        int(value[4:6], 16),
        alpha,
    )


def wrap_text(
    draw: ImageDraw.ImageDraw,
    text: str,
    text_font: ImageFont.FreeTypeFont,
    max_width: int,
) -> list[str]:
    lines: list[str] = []
    for paragraph in text.split("\n"):
        if not paragraph:
            lines.append("")
            continue
        current = ""
        for char in paragraph:
            trial = current + char
            if draw.textbbox((0, 0), trial, font=text_font)[2] <= max_width:
                current = trial
            else:
                lines.append(current)
                current = char
        if current:
            lines.append(current)
    return lines


def draw_paragraph(
    draw: ImageDraw.ImageDraw,
    xy: tuple[int, int],
    text: str,
    text_font: ImageFont.FreeTypeFont,
    fill: tuple[int, int, int, int],
    max_width: int,
    line_gap: int = 8,
) -> int:
    x, y = xy
    text_height = draw.textbbox((0, 0), "国", font=text_font)[3]
    for line in wrap_text(draw, text, text_font, max_width):
        draw.text((x, y), line, font=text_font, fill=fill)
        y += text_height + line_gap
    return y


def star_points(cx: float, cy: float, radius: float, inner: float = 0.43) -> list[tuple[float, float]]:
    points: list[tuple[float, float]] = []
    for index in range(10):
        angle = -math.pi / 2 + index * math.pi / 5
        reach = radius if index % 2 == 0 else radius * inner
        points.append((cx + math.cos(angle) * reach, cy + math.sin(angle) * reach))
    return points


def draw_star(
    draw: ImageDraw.ImageDraw,
    cx: float,
    cy: float,
    radius: float,
    accent: str,
    *,
    filled: bool = True,
    glow: bool = True,
) -> None:
    points = star_points(cx, cy, radius)
    if glow:
        for ring in range(3):
            ring_points = star_points(cx, cy, radius * (1.18 + ring * 0.13))
            draw.polygon(ring_points, outline=color(accent, 42 - ring * 8))
    if filled:
        draw.polygon(points, fill=color(accent))
    else:
        draw.polygon(points, fill=color(PAPER, 225), outline=color(accent))
    draw.line(
        points + [points[0]],
        fill=color("#6e4b25", 180 if filled else 220),
        width=max(2, int(radius * 0.08)),
        joint="curve",
    )


def card(
    draw: ImageDraw.ImageDraw,
    rect: tuple[int, int, int, int],
    *,
    fill: str = "#fffefd",
    outline: str = LINE,
    radius: int = 26,
    shadow: bool = True,
) -> None:
    x1, y1, x2, y2 = rect
    if shadow:
        draw.rounded_rectangle(
            (x1 + 7, y1 + 9, x2 + 7, y2 + 9),
            radius=radius,
            fill=color("#1d1812", 18),
        )
    draw.rounded_rectangle(rect, radius=radius, fill=color(fill), outline=color(outline), width=3)


def section_heading(draw: ImageDraw.ImageDraw, x: int, y: int, number: str, title: str, note: str) -> None:
    draw.rounded_rectangle((x, y + 6, x + 58, y + 64), radius=18, fill=color(GOLD))
    draw.text((x + 17, y + 13), number, font=font(28, bold=True), fill=color(WHITE))
    draw.text((x + 78, y), title, font=font(40, bold=True), fill=color(INK))
    draw.text((x + 80, y + 53), note, font=font(20), fill=color(MUTED))


def draw_rose(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    accent = "#c25f82"
    draw.line((cx, cy + scale * 0.12, cx, cy + scale * 0.52), fill=color("#5f784b"), width=max(4, int(scale * 0.10)))
    draw.ellipse(
        (cx - scale * 0.34, cy - scale * 0.20, cx - scale * 0.08, cy + scale * 0.06),
        fill=color("#719161"),
    )
    for dx, dy, r in [(-0.18, -0.05, 0.20), (0.18, -0.05, 0.20), (0, -0.22, 0.22), (0, 0.05, 0.24)]:
        draw.ellipse(
            (
                cx + scale * (dx - r),
                cy + scale * (dy - r),
                cx + scale * (dx + r),
                cy + scale * (dy + r),
            ),
            fill=color(accent),
            outline=color("#7a3450"),
            width=2,
        )
    draw.arc(
        (cx - scale * 0.13, cy - scale * 0.13, cx + scale * 0.13, cy + scale * 0.13),
        30,
        310,
        fill=color("#f0a8bb"),
        width=4,
    )


def draw_dome(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    accent = "#87a7b8"
    draw.arc(
        (cx - scale * 0.42, cy - scale * 0.52, cx + scale * 0.42, cy + scale * 0.32),
        180,
        360,
        fill=color(accent),
        width=max(4, int(scale * 0.06)),
    )
    draw.line(
        (cx - scale * 0.42, cy - scale * 0.10, cx - scale * 0.42, cy + scale * 0.30),
        fill=color(accent),
        width=4,
    )
    draw.line(
        (cx + scale * 0.42, cy - scale * 0.10, cx + scale * 0.42, cy + scale * 0.30),
        fill=color(accent),
        width=4,
    )
    draw.line(
        (cx - scale * 0.48, cy + scale * 0.32, cx + scale * 0.48, cy + scale * 0.32),
        fill=color("#806a52"),
        width=6,
    )
    draw.ellipse(
        (cx - scale * 0.12, cy - scale * 0.02, cx + scale * 0.12, cy + scale * 0.24),
        fill=color("#d57a99"),
    )


def draw_mirror(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    draw.ellipse(
        (cx - scale * 0.34, cy - scale * 0.48, cx + scale * 0.34, cy + scale * 0.34),
        fill=color("#cbb8dc"),
        outline=color("#805d99"),
        width=6,
    )
    draw.ellipse(
        (cx - scale * 0.25, cy - scale * 0.38, cx + scale * 0.25, cy + scale * 0.22),
        fill=color("#f0ebf7", 220),
    )
    draw.line((cx, cy + scale * 0.34, cx, cy + scale * 0.62), fill=color("#6e4d34"), width=8)
    draw.line((cx - scale * 0.23, cy + scale * 0.63, cx + scale * 0.23, cy + scale * 0.63), fill=color("#6e4d34"), width=7)


def draw_petals(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    for index in range(5):
        angle = index * math.tau / 5
        px = cx + math.cos(angle) * scale * 0.22
        py = cy + math.sin(angle) * scale * 0.18
        draw.ellipse(
            (px - scale * 0.18, py - scale * 0.14, px + scale * 0.18, py + scale * 0.14),
            fill=color("#ce78ad"),
            outline=color("#8f4f78"),
            width=2,
        )


def draw_lamp(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    draw.line((cx, cy - scale * 0.62, cx, cy - scale * 0.28), fill=color("#6e4d34"), width=6)
    draw.polygon(
        [
            (cx, cy - scale * 0.34),
            (cx + scale * 0.25, cy - scale * 0.12),
            (cx, cy + scale * 0.28),
            (cx - scale * 0.25, cy - scale * 0.12),
        ],
        fill=color("#f0c66e"),
        outline=color("#9c6b2c"),
    )
    draw.ellipse(
        (cx - scale * 0.10, cy - scale * 0.16, cx + scale * 0.10, cy + scale * 0.06),
        fill=color("#fff7cb"),
    )


def draw_ledger(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    draw.rounded_rectangle(
        (cx - scale * 0.34, cy - scale * 0.44, cx + scale * 0.34, cy + scale * 0.42),
        radius=8,
        fill=color("#7e5b91"),
        outline=color("#513d60"),
        width=4,
    )
    for row in range(4):
        y = cy - scale * 0.23 + row * scale * 0.15
        draw.line((cx - scale * 0.22, y, cx + scale * 0.22, y), fill=color("#dfcbe8"), width=3)


def draw_fox(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    points = [
        (cx - scale * 0.42, cy + scale * 0.22),
        (cx - scale * 0.26, cy - scale * 0.34),
        (cx - scale * 0.06, cy - scale * 0.06),
        (cx + scale * 0.06, cy - scale * 0.06),
        (cx + scale * 0.26, cy - scale * 0.34),
        (cx + scale * 0.42, cy + scale * 0.22),
        (cx + scale * 0.20, cy + scale * 0.42),
        (cx - scale * 0.20, cy + scale * 0.42),
    ]
    draw.polygon(points, fill=color("#d9773b"), outline=color("#864421"), width=4)
    draw.ellipse(
        (cx - scale * 0.12, cy + scale * 0.03, cx + scale * 0.12, cy + scale * 0.27),
        fill=color("#f0d4af"),
    )


def draw_wheat(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    draw.line((cx, cy - scale * 0.52, cx, cy + scale * 0.55), fill=color("#9b6d28"), width=5)
    for row in range(4):
        y = cy - scale * 0.36 + row * scale * 0.18
        draw.line((cx, y, cx - scale * 0.24, y - scale * 0.11), fill=color("#dba844"), width=6)
        draw.line((cx, y, cx + scale * 0.24, y - scale * 0.11), fill=color("#dba844"), width=6)


def draw_sun(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    draw.ellipse(
        (cx - scale * 0.30, cy - scale * 0.30, cx + scale * 0.30, cy + scale * 0.30),
        fill=color("#e4ad45"),
        outline=color("#9d6d23"),
        width=4,
    )
    for index in range(12):
        angle = index * math.tau / 12
        draw.line(
            (
                cx + math.cos(angle) * scale * 0.38,
                cy + math.sin(angle) * scale * 0.38,
                cx + math.cos(angle) * scale * 0.54,
                cy + math.sin(angle) * scale * 0.54,
            ),
            fill=color("#c58b2e"),
            width=4,
        )


def draw_crown(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    points = [
        (cx - scale * 0.44, cy + scale * 0.26),
        (cx - scale * 0.37, cy - scale * 0.30),
        (cx - scale * 0.11, cy + scale * 0.00),
        (cx, cy - scale * 0.43),
        (cx + scale * 0.11, cy + scale * 0.00),
        (cx + scale * 0.37, cy - scale * 0.30),
        (cx + scale * 0.44, cy + scale * 0.26),
    ]
    draw.polygon(points, fill=color("#d6a84a"), outline=color("#855a1a"), width=4)
    draw.line((cx - scale * 0.39, cy + scale * 0.31, cx + scale * 0.39, cy + scale * 0.31), fill=color("#855a1a"), width=5)


def draw_chair(canvas: Image.Image, draw: ImageDraw.ImageDraw, cx: float, cy: float, scale: float) -> None:
    draw.line((cx - scale * 0.24, cy - scale * 0.45, cx - scale * 0.24, cy + scale * 0.45), fill=color("#8a5d30"), width=9)
    draw.line((cx + scale * 0.24, cy - scale * 0.45, cx + scale * 0.24, cy + scale * 0.45), fill=color("#8a5d30"), width=9)
    draw.line((cx - scale * 0.34, cy + scale * 0.05, cx + scale * 0.34, cy + scale * 0.05), fill=color("#b27a3d"), width=10)
    draw.line((cx - scale * 0.34, cy + scale * 0.05, cx - scale * 0.27, cy + scale * 0.45), fill=color("#8a5d30"), width=7)
    draw.line((cx + scale * 0.34, cy + scale * 0.05, cx + scale * 0.27, cy + scale * 0.45), fill=color("#8a5d30"), width=7)


def draw_backpack(draw: ImageDraw.ImageDraw, box: tuple[int, int, int, int], *, open_state: bool, filled: int) -> None:
    x1, y1, x2, y2 = box
    cx = (x1 + x2) / 2
    cy = (y1 + y2) / 2
    scale = min(x2 - x1, y2 - y1) / 2
    body = [
        (cx - scale * 0.70, cy - scale * 0.28),
        (cx - scale * 0.49, cy - scale * 0.45),
        (cx + scale * 0.52, cy - scale * 0.42),
        (cx + scale * 0.72, cy - scale * 0.20),
        (cx + scale * 0.60, cy + scale * 0.68),
        (cx - scale * 0.58, cy + scale * 0.68),
    ]
    draw.polygon(body, fill=color("#b9854e"), outline=color("#6f4926"))
    flap_y = cy - scale * (0.50 if open_state else 0.34)
    flap = [
        (cx - scale * 0.58, cy - scale * 0.26),
        (cx - scale * 0.36, flap_y),
        (cx + scale * 0.42, flap_y - scale * 0.04),
        (cx + scale * 0.62, cy - scale * 0.26),
        (cx + scale * 0.42, cy - scale * 0.03),
        (cx - scale * 0.38, cy - scale * 0.02),
    ]
    draw.polygon(flap, fill=color("#d1a36b"), outline=color("#7b5731"))
    colors = ["#c25f82", "#e3ad45", "#b476cb", "#d17c3d", "#65a9cc", "#dd9638"]
    for index in range(6):
        t = index / 5
        sx = x1 + (x2 - x1) * (0.20 + 0.60 * t)
        sy = cy + scale * (0.18 - 0.10 * math.sin(t * math.pi))
        draw_star(draw, sx, sy, scale * 0.09, colors[index] if index < filled else GOLD, filled=index < filled, glow=index < filled)


def draw_asset_card(
    canvas: Image.Image,
    title: str,
    subtitle: str,
    rect: tuple[int, int, int, int],
    draw_icon,
) -> None:
    draw = ImageDraw.Draw(canvas)
    card(draw, rect)
    x1, y1, x2, y2 = rect
    draw.text((x1 + 28, y1 + 20), title, font=font(28, bold=True), fill=color(INK))
    draw.text((x1 + 28, y1 + 58), subtitle, font=font(17), fill=color(MUTED))
    icon_box = (x1 + 28, y1 + 96, x2 - 28, y2 - 22)
    draw.rounded_rectangle(
        icon_box,
        radius=18,
        fill=color("#fffefd"),
        outline=color("#e3dacb"),
        width=2,
    )
    draw_icon(draw, icon_box)


def main() -> None:
    canvas = Image.new("RGBA", (WIDTH, HEIGHT), color(WHITE))
    draw = ImageDraw.Draw(canvas)

    draw.text((100, 72), "LITTLE PRINCE · STAR MEMORY COLLECTION", font=font(20, bold=True), fill=color(GOLD))
    draw.text((100, 112), "星光收集 · 单页美术资产提示词总览", font=font(66, bold=True, serif=True), fill=color(INK))
    draw.text(
        (104, 205),
        "一次生图完成整套资产提案 · 纯白底 · 每项单独留白 · 方便后期抠图与切分",
        font=font(28),
        fill=color(MUTED),
    )
    draw.rounded_rectangle((1906, 102, 2300, 164), radius=20, fill=color("#f4eee2"), outline=color(LINE), width=2)
    draw.text((1936, 115), "WHITE BACKGROUND", font=font(22, bold=True), fill=color(GOLD))
    draw.line((100, 254, 2300, 254), fill=color(LINE), width=2)

    card(draw, (100, 286, 2300, 590), fill="#fffcf6", outline="#d9c6a4")
    draw.text((134, 314), "统一生图主提示词", font=font(32, bold=True), fill=color(INK))
    master_prompt = (
        "Create one polished art-direction contact sheet on a pure white background for a children's storybook game,\n"
        "showing a cohesive family of handmade paper-cut star-memory assets. Use warm ivory paper, soft torn fibers,\n"
        "subtle layered shadows, muted jewel accents and fine gold rims. Keep every item isolated with generous white\n"
        "margins, front-facing and uncluttered, so each can be cut out. Include six star-button color variants,\n"
        "one paper backpack in closed / open / fully-lit states, twelve tiny memory silhouettes in two-item pairs,\n"
        "six restrained magical light sources, and a six-star constellation pointing toward a seventh hollow paper star.\n"
        "No text, no labels, no watermark, no background scenery."
    )
    draw_paragraph(draw, (134, 360), master_prompt, font(21), color(INK), 2120, 5)

    section_heading(draw, 100, 626, "01", "核心 UI", "星光按钮的六种主色 · 背包关闭 / 开口 / 六枚点亮")
    card(draw, (100, 720, 1140, 1165))
    draw.text((132, 748), "纸星星 · 状态与主色", font=font(28, bold=True), fill=color(INK))
    colors = ["#c25f82", "#e3ad45", "#b476cb", "#6ea8c7", "#d17c3d", "#dd9638"]
    star_x = [230, 375, 520, 665, 810, 955]
    for x, accent in zip(star_x, colors):
        draw_star(draw, x, 906, 56, accent)
    draw.text((132, 1000), "默认  ·  悬停放大  ·  点击轻呼吸", font=font(22), fill=color(MUTED))
    draw_star(draw, 252, 1090, 32, colors[0], filled=False)
    draw_star(draw, 370, 1090, 40, colors[0])
    draw_star(draw, 495, 1090, 32, colors[0])
    draw.text((560, 1064), "同一轮廓，仅色纸内芯不同", font=font(23), fill=color(INK))

    card(draw, (1180, 720, 2300, 1165))
    draw.text((1212, 748), "纸雕背包 · 三段状态", font=font(28, bold=True), fill=color(INK))
    draw_backpack(draw, (1240, 830, 1510, 1100), open_state=False, filled=0)
    draw_backpack(draw, (1570, 810, 1855, 1100), open_state=True, filled=2)
    draw_backpack(draw, (1905, 830, 2245, 1100), open_state=False, filled=6)
    for x, label in [(1375, "关闭"), (1712, "接住纸片"), (2075, "六星全亮")]:
        text_box = draw.textbbox((0, 0), label, font=font(21, bold=True))
        draw.text((x - (text_box[2] - text_box[0]) / 2, 1112), label, font=font(21, bold=True), fill=color(MUTED))

    section_heading(draw, 100, 1205, "02", "十二枚记忆纸片", "每颗星两枚 · 半透明纸雕剪影 · 统一尺寸")
    fragment_specs = [
        ("玫瑰", "玫瑰 / 玻璃罩", lambda d, b: (draw_rose(canvas, d, b[0] + (b[2] - b[0]) * 0.30, b[1] + (b[3] - b[1]) * 0.56, 95), draw_dome(canvas, d, b[0] + (b[2] - b[0]) * 0.70, b[1] + (b[3] - b[1]) * 0.56, 90))),
        ("国王", "太阳 / 王冠", lambda d, b: (draw_sun(canvas, d, b[0] + (b[2] - b[0]) * 0.30, b[1] + (b[3] - b[1]) * 0.56, 86), draw_crown(canvas, d, b[0] + (b[2] - b[0]) * 0.70, b[1] + (b[3] - b[1]) * 0.56, 88))),
        ("虚荣者", "花瓣 / 镜子", lambda d, b: (draw_petals(canvas, d, b[0] + (b[2] - b[0]) * 0.30, b[1] + (b[3] - b[1]) * 0.56, 88), draw_mirror(canvas, d, b[0] + (b[2] - b[0]) * 0.70, b[1] + (b[3] - b[1]) * 0.56, 84))),
        ("地球", "狐狸 / 麦子", lambda d, b: (draw_fox(canvas, d, b[0] + (b[2] - b[0]) * 0.30, b[1] + (b[3] - b[1]) * 0.56, 80), draw_wheat(canvas, d, b[0] + (b[2] - b[0]) * 0.70, b[1] + (b[3] - b[1]) * 0.56, 88))),
        ("商人", "星灯 / 账簿", lambda d, b: (draw_lamp(canvas, d, b[0] + (b[2] - b[0]) * 0.30, b[1] + (b[3] - b[1]) * 0.56, 80), draw_ledger(canvas, d, b[0] + (b[2] - b[0]) * 0.70, b[1] + (b[3] - b[1]) * 0.56, 80))),
        ("点灯人", "灯焰 / 椅子", lambda d, b: (draw_lamp(canvas, d, b[0] + (b[2] - b[0]) * 0.30, b[1] + (b[3] - b[1]) * 0.56, 85), draw_chair(canvas, d, b[0] + (b[2] - b[0]) * 0.70, b[1] + (b[3] - b[1]) * 0.56, 76))),
    ]
    grid = [(100, 1300, 820, 1570), (840, 1300, 1560, 1570), (1580, 1300, 2300, 1570), (100, 1592, 820, 1862), (840, 1592, 1560, 1862), (1580, 1592, 2300, 1862)]
    for (planet, items, painter), rect in zip(fragment_specs, grid):
        x1, y1, x2, y2 = rect
        card(draw, rect)
        draw.text((x1 + 26, y1 + 18), planet, font=font(27, bold=True), fill=color(INK))
        draw.text((x1 + 150, y1 + 25), items, font=font(19), fill=color(MUTED))
        painter(draw, (x1 + 20, y1 + 60, x2 - 20, y2 - 12))

    section_heading(draw, 100, 1918, "03", "生成源与第七星", "六种克制的纸雕光效 · 全收集后形成指向第七星的星座")
    card(draw, (100, 2010, 1480, 2450))
    source_labels = ["玫瑰 · 玻璃水汽", "国王 · 太阳余晖", "虚荣者 · 镜心", "地球 · 日落麦浪", "商人 · 无编号灯串", "点灯人 · 灯焰"]
    for idx, label in enumerate(source_labels):
        col = idx % 3
        row = idx // 3
        x = 155 + col * 410
        y = 2090 + row * 160
        accent = colors[idx]
        for ring in range(3):
            draw.ellipse((x + ring * 7, y - 32 + ring * 7, x + 104 - ring * 7, y + 72 - ring * 7), outline=color(accent, 105 - ring * 28), width=2)
        draw_star(draw, x + 52, y + 20, 29, accent)
        draw.text((x + 125, y - 4), label, font=font(21, fill=False) if False else font(21), fill=color(INK))
    card(draw, (1520, 2010, 2300, 2450))
    draw.text((1550, 2040), "第七星小星座", font=font(28, bold=True), fill=color(INK))
    constellation = [(1605, 2290), (1700, 2240), (1802, 2270), (1902, 2205), (2005, 2230), (2100, 2165)]
    for idx in range(len(constellation) - 1):
        draw.line((constellation[idx], constellation[idx + 1]), fill=color(GOLD, 170), width=3)
    for idx, point in enumerate(constellation):
        draw_star(draw, point[0], point[1], 18, colors[idx])
    draw.line((2100, 2165, 2205, 2078), fill=color(GOLD, 150), width=2)
    draw_star(draw, 2212, 2072, 25, GOLD, filled=False)
    draw.text((1990, 2390), "六枚亮星 → 第七星", font=font(21), fill=color(MUTED))

    section_heading(draw, 100, 2492, "04", "一次性整页生图提示词", "把下面整段直接作为单次生图请求，不要拆成多次")
    card(draw, (100, 2586, 2300, 2990), fill="#fffdf8", outline="#d9c6a4")
    consolidated = (
        "生成一张横向或方形白底的游戏资产总览图。主题是“小王子纸雕星图·星光收集”。"
        "整体必须统一为手剪纸雕、多层纸张、轻微纤维毛边、柔和层叠投影的儿童绘本质感；"
        "颜色为暖象牙纸、低饱和宝石色、细金色描边。页面元素之间保留充足纯白间隔，"
        "所有物件正面展示、轮廓清楚，便于单独抠图。包含：一枚不规则五角纸星星的六种主色版本；"
        "一只棕色纸雕小背包的关闭、打开、六枚星槽点亮三个状态；"
        "十二枚小型记忆剪影，成对为玫瑰与玻璃罩、太阳与王冠、花瓣与镜子、狐狸与麦束、星灯与账簿、灯焰与椅子；"
        "六种星光生成源，分别为玻璃水汽、太阳余晖、镜心、日落麦浪、无编号灯串、灯焰；"
        "以及由六颗彩色纸星连成、指向第七颗空心纸星的温柔小星座。"
        "不要写实 3D、不要塑料质感、不要霓虹、不要复杂粒子、不要黑色粗描边、不要圆形按钮、不要文字、不要水印、不要背景场景。"
    )
    draw_paragraph(draw, (134, 2628), consolidated, font(24), color(INK), 2110, 9)

    draw.line((100, 3040, 2300, 3040), fill=color(LINE), width=2)
    draw.text((100, 3070), "NEGATIVE PROMPT", font=font(21, bold=True), fill=color(GOLD))
    draw.text(
        (348, 3068),
        "realistic 3D, glossy plastic, neon, dense sparkles, hard black outlines, circular close button, text, watermark, scenery, cropped objects, inconsistent paper style",
        font=font(21),
        fill=color(MUTED),
    )

    canvas.convert("RGB").save(OUTPUT, "PNG", optimize=True)
    print(OUTPUT)


if __name__ == "__main__":
    main()
