from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "docs" / "previews" / "cover-font-samples.png"
FONT_DIR = Path("C:/Windows/Fonts")


def font(path: Path, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(str(path), size=size)


canvas = Image.new("RGB", (1800, 1450), "#11162a")
draw = ImageDraw.Draw(canvas)
cream = (244, 231, 203)
muted = (198, 178, 146)
gold = (211, 174, 106)

draw.text((70, 50), "中文标题候选", font=font(FONT_DIR / "NotoSerifSC-VF.ttf", 34), fill=gold)
draw.line((70, 100, 1730, 100), fill=(80, 78, 92), width=1)

chinese_candidates = [
    ("ZCOOL 小薇", ROOT / "assets" / "ui" / "fonts" / "ZCOOLXiaoWei-Regular.ttf", 96),
    ("华文中宋", FONT_DIR / "STZHONGS.TTF", 92),
    ("华文宋体", FONT_DIR / "STSONG.TTF", 92),
    ("华文楷体", FONT_DIR / "STKAITI.TTF", 100),
    ("思源宋体", FONT_DIR / "NotoSerifSC-VF.ttf", 92),
]
y = 130
for label, path, size in chinese_candidates:
    draw.text((70, y), label, font=font(FONT_DIR / "NotoSerifSC-VF.ttf", 22), fill=muted)
    draw.text((300, y - 28), "小王子 · 纸间星旅", font=font(path, size), fill=cream)
    y += 150

draw.text((70, 915), "英文花体候选", font=font(FONT_DIR / "NotoSerifSC-VF.ttf", 34), fill=gold)
draw.line((70, 965, 1730, 965), fill=(80, 78, 92), width=1)

english_candidates = [
    ("French Script", FONT_DIR / "FRSCRIPT.TTF", 92),
    ("Edwardian Script", FONT_DIR / "ITCEDSCR.TTF", 88),
    ("Palace Script", FONT_DIR / "PALSCRI.TTF", 95),
    ("Vladimir Script", FONT_DIR / "VLADIMIR.TTF", 90),
    ("Freebooter Script", FONT_DIR / "FREESCPT.TTF", 86),
    ("Pristina", FONT_DIR / "PRISTINA.TTF", 86),
]
y = 985
for label, path, size in english_candidates:
    draw.text((70, y + 22), label, font=font(FONT_DIR / "NotoSerifSC-VF.ttf", 19), fill=muted)
    draw.text((300, y), "Le Petit Prince", font=font(path, size), fill=cream)
    y += 70

OUTPUT.parent.mkdir(parents=True, exist_ok=True)
canvas.save(OUTPUT, quality=95)
print(OUTPUT)
