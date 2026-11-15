"""Extract the paper-scroll UI sample from the supplied 4096px art sheet.

The source is an opaque JPG, so the edge treatment is intentionally conservative:
grabCut separates the scroll from the near-white backdrop, then a small
morphological cleanup removes isolated sheet noise. The original paper remains
fully opaque and is never chroma-keyed by whiteness.
"""

from __future__ import annotations

from pathlib import Path

import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont


PROJECT_ROOT = Path(__file__).resolve().parents[1]
SOURCE = PROJECT_ROOT.parent / "参考图" / "l_wvKKFGqV-PCyKHsTF_d.jpg"
OUTPUT_DIR = PROJECT_ROOT / "assets" / "ui" / "_sample"
FONT_PATH = PROJECT_ROOT / "assets" / "ui" / "fonts" / "ZCOOLXiaoWei-Regular.ttf"

# This crop includes the complete upper and lower rolls. The small dark marks
# visible at the top edge are from the preceding row and are excluded by the
# foreground mask.
CROP = (40, 640, 1090, 1280)


def _make_trimap(shape: tuple[int, int]) -> np.ndarray:
    height, width = shape
    mask = np.full((height, width), cv2.GC_PR_BGD, dtype=np.uint8)

    # The paper body is almost white, so grabCut needs a truthful interior seed
    # rather than a rectangular "everything is foreground" assumption.
    body = np.array(
        [
            (82, 180),
            (90, 139),
            (127, 105),
            (205, 119),
            (292, 124),
            (385, 116),
            (468, 125),
            (555, 120),
            (648, 114),
            (740, 122),
            (830, 117),
            (905, 110),
            (946, 120),
            (951, 172),
            (927, 205),
            (933, 260),
            (924, 316),
            (932, 372),
            (925, 430),
            (932, 486),
            (918, 537),
            (884, 560),
            (812, 544),
            (737, 556),
            (662, 552),
            (586, 559),
            (512, 553),
            (438, 562),
            (367, 557),
            (294, 565),
            (220, 558),
            (150, 564),
            (119, 531),
            (106, 468),
            (114, 400),
            (105, 332),
            (115, 265),
            (105, 205),
        ],
        dtype=np.int32,
    )
    cv2.fillPoly(mask, [body], cv2.GC_PR_FGD)

    # Keep the centre unambiguous. This protects the white paper face from being
    # mistaken for the similarly coloured backdrop.
    core = np.array(
        [
            (180, 190),
            (185, 150),
            (885, 150),
            (887, 530),
            (180, 530),
        ],
        dtype=np.int32,
    )
    cv2.fillPoly(mask, [core], cv2.GC_FGD)

    # Reserve border pixels as known background, except where the lower roll
    # reaches the crop edge.
    border = 12
    mask[:border, :] = cv2.GC_BGD
    mask[:, :border] = cv2.GC_BGD
    mask[:, -border:] = cv2.GC_BGD
    mask[-border:, :] = cv2.GC_BGD
    return mask


def _clean_alpha(binary: np.ndarray, source_rgb: np.ndarray) -> np.ndarray:
    # Remove the near-white studio backdrop wherever it remains connected to
    # the crop border. Gold trim, paper shadows and the scroll silhouette stop
    # the flood before it can enter the white paper face.
    maximum = source_rgb.max(axis=2)
    minimum = source_rgb.min(axis=2)
    passable = ((maximum >= 228) & ((maximum - minimum) <= 18)).astype(np.uint8)
    _, labels = cv2.connectedComponents(passable, connectivity=8)
    border_labels = np.unique(
        np.concatenate(
            (
                labels[0, :],
                labels[-1, :],
                labels[:, 0],
                labels[:, -1],
            )
        )
    )
    border_labels = border_labels[border_labels != 0]
    connected_background = np.isin(labels, border_labels)
    binary[connected_background] = 0

    # Keep the scroll's main component and discard tiny JPEG flecks.
    count, labels, stats, _ = cv2.connectedComponentsWithStats(binary, 8)
    if count > 1:
        largest = 1 + int(np.argmax(stats[1:, cv2.CC_STAT_AREA]))
        binary = np.where(labels == largest, 255, 0).astype(np.uint8)

    # Close pinholes and bridge sub-pixel gaps in white-on-white edges.
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5))
    binary = cv2.morphologyEx(binary, cv2.MORPH_CLOSE, kernel, iterations=2)

    # Fill enclosed transparent islands inside the paper body.
    flood = binary.copy()
    fill_mask = np.zeros((binary.shape[0] + 2, binary.shape[1] + 2), np.uint8)
    cv2.floodFill(flood, fill_mask, (0, 0), 255)
    holes = cv2.bitwise_not(flood)
    binary = cv2.bitwise_or(binary, holes)

    # A one-pixel inward trim prevents bright JPEG fringe from printing around
    # the artwork on dark in-game backgrounds. Feathering restores a clean edge.
    binary = cv2.erode(binary, cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 3)))
    return cv2.GaussianBlur(binary, (0, 0), 0.85)


def _trim_to_alpha(rgba: np.ndarray) -> np.ndarray:
    alpha = rgba[:, :, 3]
    ys, xs = np.where(alpha > 2)
    if not len(xs):
        raise RuntimeError("No foreground pixels were detected.")
    left, right = max(0, xs.min() - 8), min(rgba.shape[1], xs.max() + 9)
    top, bottom = max(0, ys.min() - 8), min(rgba.shape[0], ys.max() + 9)
    return rgba[top:bottom, left:right]


def _checkerboard(size: tuple[int, int], cell: int = 24) -> Image.Image:
    width, height = size
    y, x = np.indices((height, width))
    board = ((x // cell + y // cell) % 2) * 38 + 204
    rgb = np.repeat(board[:, :, None], 3, axis=2).astype(np.uint8)
    return Image.fromarray(rgb, "RGB")


def _preview(cutout: Image.Image, source: Image.Image) -> Image.Image:
    canvas = Image.new("RGB", (1800, 1260), "#11182b")
    draw = ImageDraw.Draw(canvas)

    for y in range(canvas.height):
        t = y / (canvas.height - 1)
        colour = (
            round(12 + 12 * t),
            round(20 + 17 * t),
            round(40 + 24 * t),
        )
        draw.line((0, y, canvas.width, y), fill=colour)

    title_font = ImageFont.truetype(str(FONT_PATH), 42)
    label_font = ImageFont.truetype(str(FONT_PATH), 26)
    note_font = ImageFont.truetype(str(FONT_PATH), 21)
    draw.text((90, 48), "纸雕 UI 透明样张", font=title_font, fill="#f4e9cf")

    source.thumbnail((820, 470), Image.Resampling.LANCZOS)
    cutout_preview = cutout.copy()
    cutout_preview.thumbnail((800, 470), Image.Resampling.LANCZOS)

    checker = _checkerboard((800, 470))
    checker.paste(cutout_preview, ((checker.width - cutout_preview.width) // 2, (checker.height - cutout_preview.height) // 2), cutout_preview)
    canvas.paste(checker, (930, 250))

    # The same transparent PNG over a light parchment backdrop. This catches
    # cream halos that would disappear on the checkerboard.
    light = Image.new("RGB", (800, 470), "#d9c8a5")
    light_draw = ImageDraw.Draw(light)
    for y in range(light.height):
        t = y / (light.height - 1)
        light_draw.line(
            (0, y, light.width, y),
            fill=(round(226 - 15 * t), round(212 - 18 * t), round(181 - 22 * t)),
        )
    light.paste(cutout_preview, ((light.width - cutout_preview.width) // 2, (light.height - cutout_preview.height) // 2), cutout_preview)

    canvas.paste(source, (60, 250))
    canvas.paste(light, (930, 750))

    draw.text((80, 190), "原始切片（白底）", font=label_font, fill="#d2c7af")
    draw.text((930, 190), "透明 PNG（棋盘预览）", font=label_font, fill="#d2c7af")
    draw.text((930, 725), "透明 PNG（浅纸背景）", font=label_font, fill="#d2c7af")
    draw.text(
        (90, 1180),
        "检查重点：纸面完整、卷边与金线连续、轮廓外无白底方块。",
        font=note_font,
        fill="#c7bda7",
    )
    return canvas


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    source = Image.open(SOURCE).convert("RGB").crop(CROP)
    crop_bgr = cv2.cvtColor(np.asarray(source), cv2.COLOR_RGB2BGR)

    mask = _make_trimap(crop_bgr.shape[:2])
    background_model = np.zeros((1, 65), np.float64)
    foreground_model = np.zeros((1, 65), np.float64)
    cv2.grabCut(
        crop_bgr,
        mask,
        None,
        background_model,
        foreground_model,
        14,
        cv2.GC_INIT_WITH_MASK,
    )
    foreground = np.where(
        (mask == cv2.GC_FGD) | (mask == cv2.GC_PR_FGD), 255, 0
    ).astype(np.uint8)
    alpha = _clean_alpha(foreground, np.asarray(source))

    rgba = np.dstack((np.asarray(source), alpha))
    rgba = _trim_to_alpha(rgba)

    cutout_path = OUTPUT_DIR / "paper_scroll_cutout.png"
    Image.fromarray(rgba, "RGBA").save(cutout_path, optimize=True)

    cutout = Image.open(cutout_path).convert("RGBA")
    preview_path = OUTPUT_DIR / "paper_scroll_preview.png"
    _preview(cutout, source).save(preview_path, optimize=True)

    print(f"cutout={cutout_path}")
    print(f"preview={preview_path}")
    print(f"size={cutout.size}")


if __name__ == "__main__":
    main()
