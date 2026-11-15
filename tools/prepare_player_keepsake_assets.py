from pathlib import Path

from PIL import Image, ImageDraw


ROOT = Path(__file__).resolve().parents[1]
DESKTOP = Path.home() / "Desktop"
OUTPUT_DIR = ROOT / "assets" / "ui" / "letter"

PHOTO_FRAME_SOURCE = DESKTOP / "3331.png"
LETTER_BACKDROP_SOURCE = DESKTOP / "20261109082558-6c1bf090-e6d7d0fd.png"
DECORATION_SHEET_SOURCE = DESKTOP / "20261109083436-dd9c7831-f73022f9.png"


def cut_white_background(source: Image.Image) -> Image.Image:
    image = source.convert("RGBA")
    marker = (255, 0, 255, 255)
    width, height = image.size
    starts = [
        (0, 0),
        (width - 1, 0),
        (0, height - 1),
        (width - 1, height - 1),
    ]
    for point in starts:
        if image.getpixel(point)[:3] != marker[:3]:
            ImageDraw.floodfill(image, point, marker, thresh=18)
    pixels = image.load()
    for y in range(height):
        for x in range(width):
            if pixels[x, y][:3] == marker[:3]:
                pixels[x, y] = (0, 0, 0, 0)
    alpha_box = image.getchannel("A").getbbox()
    return image.crop(alpha_box) if alpha_box is not None else image


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    frame = cut_white_background(Image.open(PHOTO_FRAME_SOURCE))
    frame.save(OUTPUT_DIR / "planet_photo_frame.png")

    backdrop = Image.open(LETTER_BACKDROP_SOURCE).convert("RGB")
    backdrop.resize((1440, 1440), Image.Resampling.LANCZOS).save(
        OUTPUT_DIR / "planet_letter_backdrop.png"
    )

    sheet = Image.open(DECORATION_SHEET_SOURCE).convert("RGBA")
    seal = cut_white_background(sheet.crop((45, 35, 486, 475)))
    seal.save(OUTPUT_DIR / "letter_wax_seal.png")

    postage_stamp = cut_white_background(sheet.crop((565, 42, 949, 472)))
    postage_stamp.save(OUTPUT_DIR / "letter_postage_stamp.png")

    qr_plaque = cut_white_background(sheet.crop((545, 535, 950, 944)))
    qr_plaque.save(OUTPUT_DIR / "letter_qr_plaque.png")

    prepared = [
        "planet_photo_frame.png",
        "planet_letter_backdrop.png",
        "letter_wax_seal.png",
        "letter_postage_stamp.png",
        "letter_qr_plaque.png",
    ]
    print("Prepared:", ", ".join(prepared))


if __name__ == "__main__":
    main()
