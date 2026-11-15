from __future__ import annotations

import json
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT.parent / "参考图" / "20261104134128-b3e9c75a-a88cb834.png"
OUTPUT_DIR = ROOT / "assets" / "ui" / "star_memories"


CROPS = {
    "star_rose": (30, 28, 188, 176),
    "star_king": (196, 28, 345, 176),
    "star_vain": (357, 27, 506, 176),
    "star_earth": (519, 29, 668, 176),
    "star_merchant": (679, 29, 829, 176),
    "star_pointlighter": (841, 28, 990, 176),
    "backpack_closed": (14, 190, 214, 425),
    "backpack_open": (247, 187, 447, 425),
    "backpack_full": (477, 187, 677, 425),
    "constellation_seventh": (674, 184, 1005, 426),
    "fragment_rose": (41, 422, 158, 602),
    "fragment_sun": (196, 422, 345, 602),
    "fragment_petal": (379, 422, 489, 602),
    "fragment_fox": (529, 422, 665, 602),
    "fragment_lamp": (702, 422, 829, 602),
    "fragment_flame": (875, 422, 986, 602),
    "fragment_dome": (32, 604, 166, 792),
    "fragment_crown": (197, 604, 334, 792),
    "fragment_mirror": (353, 604, 501, 792),
    "fragment_wheat": (528, 604, 660, 792),
    "fragment_ledger": (683, 604, 848, 792),
    "fragment_chair": (865, 604, 995, 792),
    "source_rose": (27, 810, 178, 953),
    "source_king": (192, 810, 347, 953),
    "source_vain": (360, 810, 502, 953),
    "source_earth": (519, 810, 677, 953),
    "source_merchant": (692, 810, 836, 953),
    "source_pointlighter": (867, 810, 979, 953),
}


def trim_with_margin(image: Image.Image, margin: int = 6) -> Image.Image:
    alpha = image.getchannel("A")
    bounds = alpha.getbbox()
    if bounds is None:
        return image
    left = max(0, bounds[0] - margin)
    top = max(0, bounds[1] - margin)
    right = min(image.width, bounds[2] + margin)
    bottom = min(image.height, bounds[3] + margin)
    return image.crop((left, top, right, bottom))


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    sheet = Image.open(SOURCE).convert("RGBA")
    manifest = {}
    for name, box in CROPS.items():
        crop = sheet.crop(box)
        crop = trim_with_margin(crop)
        output_path = OUTPUT_DIR / f"{name}.png"
        crop.save(output_path, "PNG", optimize=True)
        manifest[name] = {
            "source_box": list(box),
            "output_size": list(crop.size),
        }
    (OUTPUT_DIR / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    print(f"Wrote {len(manifest)} transparent assets to {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
