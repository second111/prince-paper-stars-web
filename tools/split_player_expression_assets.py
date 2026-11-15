from __future__ import annotations

from pathlib import Path

from PIL import Image


PLAYER_SOURCE = Path(r"C:\Users\ctyb\Desktop\57ff71581145a70f0b72e972132ed4ad.png")
PRINCE_SOURCE = Path(r"C:\Users\ctyb\Desktop\20261108100016-ef05e3ff-b3b03f08.png")
SYMBOL_SOURCE = Path(r"C:\Users\ctyb\Desktop\111.png")

OUTPUT_ROOT = Path(
    r"C:\Users\ctyb\Desktop\视觉小说\GodotProject\assets\ui\player_interactions"
)

PLAYER_NAMES = [
    "heart",
    "smile",
    "laugh",
    "shy",
    "surprise",
    "think",
    "cheer",
    "sad",
    "invite",
    "goodnight",
]

PRINCE_NAMES = [
    "heart",
    "smile",
    "laugh",
    "star",
    "surprise",
    "nod",
    "cheer",
    "worry",
    "invite",
    "goodnight",
]

SYMBOL_NAMES = ["dialogue", "sticker"]


def save_cell(
    source: Image.Image,
    box: tuple[int, int, int, int],
    destination: Path,
    canvas_size: int = 256,
    padding: int = 16,
) -> None:
    cell = source.crop(box).convert("RGBA")
    alpha_bounds = cell.getchannel("A").getbbox()
    if alpha_bounds is None:
        raise ValueError(f"No opaque pixels in {box}")
    trimmed = cell.crop(alpha_bounds)
    max_edge = canvas_size - padding * 2
    scale = min(max_edge / trimmed.width, max_edge / trimmed.height, 1.0)
    resized = trimmed.resize(
        (
            max(1, round(trimmed.width * scale)),
            max(1, round(trimmed.height * scale)),
        ),
        Image.Resampling.LANCZOS,
    )
    canvas = Image.new("RGBA", (canvas_size, canvas_size), (0, 0, 0, 0))
    offset = (
        (canvas_size - resized.width) // 2,
        (canvas_size - resized.height) // 2,
    )
    canvas.alpha_composite(resized, offset)
    destination.parent.mkdir(parents=True, exist_ok=True)
    canvas.save(destination, "PNG", optimize=True)


def split_grid(
    source_path: Path,
    names: list[str],
    output_dir: Path,
    x_boundaries: list[int],
    y_boundaries: list[int],
) -> None:
    source = Image.open(source_path).convert("RGBA")
    columns = len(x_boundaries) - 1
    for index, name in enumerate(names):
        column = index % columns
        row = index // columns
        left = x_boundaries[column]
        right = x_boundaries[column + 1]
        top = y_boundaries[row]
        bottom = y_boundaries[row + 1]
        save_cell(source, (left, top, right, bottom), output_dir / f"{name}.png")


def main() -> None:
    split_grid(
        PLAYER_SOURCE,
        PLAYER_NAMES,
        OUTPUT_ROOT / "expressions" / "player",
        x_boundaries=[0, 306, 637, 927, 1228, 1536],
        y_boundaries=[0, 768, 1536],
    )
    split_grid(
        PRINCE_SOURCE,
        PRINCE_NAMES,
        OUTPUT_ROOT / "expressions" / "prince",
        x_boundaries=[0, 316, 615, 902, 1198, 1536],
        y_boundaries=[0, 512, 1024],
    )
    source = Image.open(SYMBOL_SOURCE).convert("RGBA")
    width, height = source.size
    for index, name in enumerate(SYMBOL_NAMES):
        left = round(index * width / 2)
        right = round((index + 1) * width / 2)
        save_cell(
            source,
            (left, 0, right, height),
            OUTPUT_ROOT / "symbols" / f"{name}.png",
        )


if __name__ == "__main__":
    main()
