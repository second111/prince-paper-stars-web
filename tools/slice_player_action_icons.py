from pathlib import Path

from PIL import Image


PROJECT_ROOT = Path(__file__).resolve().parents[1]
SOURCE_PATH = (
    PROJECT_ROOT
    / "assets"
    / "ui"
    / "paper_ui"
    / "source"
    / "ui_player_actions_source.png"
)
OUTPUT_DIR = PROJECT_ROOT / "assets" / "ui" / "paper_ui" / "player_actions"
ICON_NAMES = [
    "lock",
    "rotate_left",
    "rotate_right",
    "duplicate",
    "delete",
]


def contiguous_alpha_groups(mask: Image.Image) -> list[tuple[int, int, int, int]]:
    width, height = mask.size
    occupied_columns = [
        x
        for x in range(width)
        if mask.crop((x, 0, x + 1, height)).getbbox() is not None
    ]
    groups: list[tuple[int, int, int, int]] = []
    start = previous = occupied_columns[0]
    for x in occupied_columns[1:]:
        if x != previous + 1:
            groups.append((start, previous, 0, 0))
            start = x
        previous = x
    groups.append((start, previous, 0, 0))

    result: list[tuple[int, int, int, int]] = []
    for left, right, _, _ in groups:
        bounds = mask.crop((left, 0, right + 1, height)).getbbox()
        if bounds is None:
            continue
        _, top, _, bottom = bounds
        result.append((left, top, right + 1, bottom))
    return result


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    sheet = Image.open(SOURCE_PATH).convert("RGBA")
    alpha = sheet.getchannel("A")
    mask = alpha.point(lambda value: 255 if value > 1 else 0)
    groups = contiguous_alpha_groups(mask)
    if len(groups) != len(ICON_NAMES):
        raise RuntimeError(f"Expected 5 icon groups, found {len(groups)}")

    output_size = 192
    content_size = output_size - 4
    for name, bounds in zip(ICON_NAMES, groups):
        icon = sheet.crop(bounds)
        scale = content_size / max(icon.size)
        resized = icon.resize(
            (
                max(1, round(icon.width * scale)),
                max(1, round(icon.height * scale)),
            ),
            Image.Resampling.LANCZOS,
        )
        canvas = Image.new("RGBA", (output_size, output_size), (0, 0, 0, 0))
        canvas.alpha_composite(
            resized,
            (
                (output_size - resized.width) // 2,
                (output_size - resized.height) // 2,
            ),
        )
        destination = OUTPUT_DIR / f"{name}.png"
        canvas.save(destination, optimize=True)
        print(f"{name}: {bounds} -> {destination}")


if __name__ == "__main__":
    main()
