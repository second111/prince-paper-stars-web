from __future__ import annotations

from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
ASSET_DIR = ROOT / "assets" / "ui" / "star_memories"
SLUGS = ["rose", "king", "vain", "earth", "merchant", "pointlighter"]

SLOT_POINTS = {
    "closed": [
        (61.7, 104.6),
        (101.9, 104.6),
        (142.1, 104.6),
        (61.8, 148.9),
        (102.0, 148.9),
        (142.0, 148.9),
    ],
    "open": [
        (61.7, 128.4),
        (102.0, 128.4),
        (142.2, 128.4),
        (61.9, 167.6),
        (102.0, 167.6),
        (142.1, 167.6),
    ],
}


def fit_image(image: Image.Image, width: int, height: int) -> Image.Image:
    scale = min(width / image.width, height / image.height)
    size = (round(image.width * scale), round(image.height * scale))
    return image.resize(size, Image.Resampling.LANCZOS)


def compose(base_name: str, filled_count: int, mode: str) -> Image.Image:
    base = Image.open(ASSET_DIR / f"backpack_{base_name}.png").convert("RGBA")
    stars = [
        Image.open(ASSET_DIR / f"star_{slug}.png").convert("RGBA")
        for slug in SLUGS
    ]
    for index in range(filled_count):
        star = fit_image(stars[index], 32, 32)
        center_x, center_y = SLOT_POINTS[mode][index]
        position = (
            round(center_x - star.width * 0.5),
            round(center_y - star.height * 0.5),
        )
        base.alpha_composite(star, position)
    return base


def main() -> None:
    for mode, source_name in [("closed", "closed"), ("open", "open")]:
        for mask in range(64):
            if mask == 0:
                image = Image.open(
                    ASSET_DIR / f"backpack_{source_name}.png"
                ).convert("RGBA")
            else:
                image = Image.open(
                    ASSET_DIR / f"backpack_{source_name}.png"
                ).convert("RGBA")
                stars = [
                    Image.open(ASSET_DIR / f"star_{slug}.png").convert("RGBA")
                    for slug in SLUGS
                ]
                for index, star_source in enumerate(stars):
                    if mask & (1 << index) == 0:
                        continue
                    star = fit_image(star_source, 32, 32)
                    center_x, center_y = SLOT_POINTS[mode][index]
                    position = (
                        round(center_x - star.width * 0.5),
                        round(center_y - star.height * 0.5),
                    )
                    image.alpha_composite(star, position)
            image.save(
                ASSET_DIR / f"backpack_{mode}_mask_{mask:02d}.png",
                "PNG",
                optimize=True,
            )
    print("Wrote all 64 closed/open backpack combinations.")


if __name__ == "__main__":
    main()
