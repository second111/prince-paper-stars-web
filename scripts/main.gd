extends Node

const COSMOS := "res://assets/layers/00_cosmos.png"
const CLOUD_FAR := "res://assets/layers/02_tunnel_far.png"
const CLOUD_MID := "res://assets/layers/04_tunnel_mid.png"
const CLOUD_NEAR := "res://assets/layers/06_tunnel_near.png"
const BOOK_PAGE := "res://assets/transition/torn-book-page.png"
const BOOK_EDGE := "res://assets/transition/book-edge-underlay.png"
const PRINCE_FLIGHT := "res://assets/transition/prince-flight.png"
const SCREENSHOT_SAVE_DIRECTORY := "C:/Users/ctyb/Desktop/截图"
const SHOW_MAP_SKIP_BUTTON := false
const SHOW_LAYOUT_BUTTON := false
const MAX_CACHED_GENERATED_PLANETS := 1
const PRINCE_WIDTH_RATIO := 0.62
const PRINCE_LEFT_RATIO := -0.07
const PRINCE_BOTTOM_RATIO := -0.14
const PRINCE_MAX_HEIGHT_RATIO := 0.76
const PRINCE_PIVOT_RATIO := Vector2(0.52, 0.52)
const PRINCE_MAP_REVEAL_SCALE := 0.56
const PRINCE_MAP_REVEAL_OFFSET_RATIO := Vector2(-0.115, -0.045)
const PRINCE_BURST_OFFSET_RATIO := Vector2(0.23, -0.11)
const PRINCE_RETURN_OFFSET_RATIO := Vector2(0.12, -0.06)
const PAPER_UI_DIR := "res://assets/ui/paper_ui/"
const UI_PRIMARY_BUTTON := PAPER_UI_DIR + "primary_button.png"
const UI_BACK_BUTTON := PAPER_UI_DIR + "back_button.png"
const UI_PLANET_TAG := PAPER_UI_DIR + "planet_tag.png"
const UI_FOCUS_RING := PAPER_UI_DIR + "focus_ring_gilded.png"
const UI_CLICK_GUIDE := PAPER_UI_DIR + "click_guide.png"
const UI_CHAIR_TARGET := PAPER_UI_DIR + "chair_target.png"
const UI_PLANET_DETAIL_CARD := PAPER_UI_DIR + "planet_detail_card.png"
const UI_SCENE_TITLE_PLATE := PAPER_UI_DIR + "scene_title_plate.png"
const UI_CHOICE_STRIP := PAPER_UI_DIR + "choice_strip_plain.png"
const UI_HINT_STRIP := PAPER_UI_DIR + "hint_strip.png"
const UI_PLAYER_ACTION_DIR := PAPER_UI_DIR + "player_actions/"
const UI_PLAYER_ACTION_LOCK := UI_PLAYER_ACTION_DIR + "lock.png"
const UI_PLAYER_ACTION_ROTATE_LEFT := UI_PLAYER_ACTION_DIR + "rotate_left.png"
const UI_PLAYER_ACTION_ROTATE_RIGHT := UI_PLAYER_ACTION_DIR + "rotate_right.png"
const UI_PLAYER_ACTION_DUPLICATE := UI_PLAYER_ACTION_DIR + "duplicate.png"
const UI_PLAYER_ACTION_DELETE := UI_PLAYER_ACTION_DIR + "delete.png"
const PLAYER_INTERACTION_UI_DIR := "res://assets/ui/player_interactions/"
const PLAYER_EXPRESSION_DIR := PLAYER_INTERACTION_UI_DIR + "expressions/player/"
const PRINCE_EXPRESSION_DIR := PLAYER_INTERACTION_UI_DIR + "expressions/prince/"
const PLAYER_DIALOGUE_SYMBOL := PLAYER_INTERACTION_UI_DIR + "symbols/dialogue.png"
const PLAYER_STICKER_SYMBOL := PLAYER_INTERACTION_UI_DIR + "symbols/sticker.png"
const PLAYER_PLACE_SYMBOL := PLAYER_INTERACTION_UI_DIR + "symbols/place.png"
const PLAYER_SAVE_SYMBOL := PLAYER_INTERACTION_UI_DIR + "symbols/save.png"
const PLAYER_PHOTO_SYMBOL := PLAYER_INTERACTION_UI_DIR + "symbols/camera.png"
const PLAYER_KEEPSAKE_FLOW_SCRIPT := preload(
	"res://scripts/player_keepsake_flow.gd"
)
const PLAYER_DAY_NIGHT_RIPPLE_SCRIPT := preload(
	"res://scripts/player_day_night_beacon_ripple.gd"
)
const PLAYER_EXPRESSIONS := [
	{"id": "heart", "label": "比心", "prince": "heart"},
	{"id": "smile", "label": "微笑", "prince": "smile"},
	{"id": "laugh", "label": "大笑", "prince": "laugh"},
	{"id": "shy", "label": "害羞", "prince": "star"},
	{"id": "surprise", "label": "惊讶", "prince": "surprise"},
	{"id": "think", "label": "认真", "prince": "nod"},
	{"id": "cheer", "label": "加油", "prince": "cheer"},
	{"id": "sad", "label": "难过", "prince": "worry"},
	{"id": "invite", "label": "邀请", "prince": "invite"},
	{"id": "goodnight", "label": "晚安", "prince": "goodnight"},
]
const PLAYER_PLANET_NAME := "我的星球"
const PLAYER_OBJECT_DRAG_THRESHOLD := 5.0
const PLAYER_DAY_NIGHT_BEACON_POSITION := Vector3(0.62, 1.58, 0.35)
const PLAYER_DAY_BEACON_COLOR := Color(1.0, 0.64, 0.16)
const PLAYER_NIGHT_BEACON_COLOR := Color(0.66, 0.80, 1.0)
const DIALOGUE_PAPER_PATH := PAPER_UI_DIR + "dialogue_card_20261106.png"
const PLANET_3D := "res://assets/3d/lamplighter.glb"
const GENERATED_3D_DIR := "res://assets/3d/generated/"
const RIGGED_CHARACTER_DIR := "res://assets/3d/characters/"
const PLANET_BASE_3D := GENERATED_3D_DIR + "planet_base.glb"
const HOUSE_3D := GENERATED_3D_DIR + "house.glb"
const LAMP_3D := GENERATED_3D_DIR + "lamp.glb"
const LADDER_3D := GENERATED_3D_DIR + "ladder.glb"
const LAMPLIGHTER_3D := RIGGED_CHARACTER_DIR + "lamplighter_rigged.glb"
const CHAIR_3D := GENERATED_3D_DIR + "chair.glb"
const SEATED_PRINCE_3D := GENERATED_3D_DIR + "seated_prince.glb"
const STANDING_PRINCE_3D := RIGGED_CHARACTER_DIR + "prince_rigged.glb"
const PRINCE_WALK_ANIMATION_3D := RIGGED_CHARACTER_DIR + "prince_walk_rigged.glb"
const PRINCE_SIT_ANIMATION_3D := RIGGED_CHARACTER_DIR + "prince_sit_rigged.glb"
const PRINCE_REACTIONS_ANIMATION_3D := RIGGED_CHARACTER_DIR + "prince_reactions_rigged.glb"
const MERCHANT_CHARACTER_3D := RIGGED_CHARACTER_DIR + "stylized_character_rigged.glb"
const MERCHANT_AGREE_ANIMATION_3D := RIGGED_CHARACTER_DIR + "merchant_agree_rigged.glb"
const VAIN_CHARACTER_3D := RIGGED_CHARACTER_DIR + "gentleman_rigged.glb"
const VAIN_REACTIONS_ANIMATION_3D := RIGGED_CHARACTER_DIR + "vain_reactions_rigged.glb"
const FOX_RIGGED_3D := "res://assets/3d/earth/quaternius_fox_animated.glb"
const EARTH_SEATED_PRINCE_3D := "res://assets/3d/rose/seated_prince_unplaced.glb"
const ROUND_TREE_3D := GENERATED_3D_DIR + "round_tree.glb"
const PINE_TREE_3D := GENERATED_3D_DIR + "pine_tree.glb"
const STONE_PATH_3D := GENERATED_3D_DIR + "stone_path.glb"
const ROCKS_3D := GENERATED_3D_DIR + "rocks.glb"
const GRASS_3D := GENERATED_3D_DIR + "grass.glb"
const KING_3D_DIR := "res://assets/3d/king/"
const KING_BASE_3D := KING_3D_DIR + "king_planet_base.glb"
const KING_CROWN_3D := KING_3D_DIR + "king_crown.glb"
const KING_CANOPY_3D := KING_3D_DIR + "king_canopy_frame.glb"
const KING_DRAPES_3D := KING_3D_DIR + "king_drapes.glb"
const KING_THRONE_3D := KING_3D_DIR + "king_throne.glb"
const KING_BANNERS_3D := KING_3D_DIR + "king_banners.glb"
const KING_TOWER_A_3D := KING_3D_DIR + "king_tower_a.glb"
const KING_TOWER_B_3D := KING_3D_DIR + "king_tower_b.glb"
const KING_CHARACTER_3D := RIGGED_CHARACTER_DIR + "king_sit_rigged.glb"
const KING_LOOKING_UP_PRINCE_3D := STANDING_PRINCE_3D
const KING_ASSET_PATHS := [
	KING_BASE_3D,
	KING_CANOPY_3D,
	KING_CROWN_3D,
	KING_DRAPES_3D,
	KING_THRONE_3D,
	KING_BANNERS_3D,
	KING_TOWER_A_3D,
	KING_TOWER_B_3D,
	KING_CHARACTER_3D,
	KING_LOOKING_UP_PRINCE_3D,
]
const ROSE_3D_DIR := "res://assets/3d/rose/"
const VAIN_3D_DIR := "res://assets/3d/vain/"
const MERCHANT_3D_DIR := "res://assets/3d/merchant/"
const EARTH_3D_DIR := "res://assets/3d/earth/"
const PLAYER_3D_DIR := "res://assets/3d/player/"
const PLAYER_PROPS_3D_DIR := "res://assets/3d/player/props/"
const PLAYER_SCENE_BASE_3D := PLAYER_3D_DIR + "player_planet_base_surface_plane.glb"
const PLAYER_BRIDGE_3D := PLAYER_PROPS_3D_DIR + "小桥.glb"
const PLAYER_LOCKED_BRIDGE_POSITION := Vector3(
	0.95152884721756,
	0.892026007175446,
	1.07271254062653
)
const PLAYER_LOCKED_BRIDGE_NORMAL := Vector3(
	0.336531281471252,
	0.929661750793457,
	-0.149919018149376
)
const PLAYER_LOCKED_BRIDGE_HEIGHT_OFFSET := 0.04
const PLAYER_LOCKED_BRIDGE_SCALE := 0.8
const PLAYER_LOCKED_BRIDGE_YAW := -24.0
const PLAYER_LOCKED_BRIDGE_TILT := 15.5
const PLAYER_PLACEMENT_PLANE_CENTER_LOCAL := Vector3(0.2944, 0.06665, 0.13323)
const PLAYER_PLACEMENT_PLANE_NORMAL_LOCAL := Vector3(0.30075, 0.95238, 0.05013)
const PLAYER_PLACEMENT_PLANE_RIGHT_LOCAL := Vector3(0.95370, -0.30034, -0.01581)
const PLAYER_PLACEMENT_PLANE_FORWARD_LOCAL := Vector3(0.0, 0.05256, -0.99862)
const PLAYER_PLACEMENT_PLANE_HALF_RIGHT_LOCAL := 0.29
const PLAYER_PLACEMENT_PLANE_HALF_FORWARD_LOCAL := 0.28
const PLAYER_PLACEMENT_PLANE_LIFT_LOCAL := 0.012
const PLAYER_HEIGHT_OFFSET_MIN := -1.0
const PLAYER_HEIGHT_OFFSET_MAX := 2.0
const PLAYER_HEIGHT_OFFSET_STEP := 0.01
const PLAYER_HEIGHT_SCHEMA_VERSION := 2
const PLAYER_ITEM_HEIGHT_LOCK_VERSION := 1
const PLAYER_SUPPORT_SURFACE_KINDS := [
	"player_long_table",
	"player_picnic_blanket",
]
const PLAYER_TABLE_SUPPORT_KINDS := [
	"player_tea_set",
	"player_open_book",
	"player_bread_plate",
	"player_vase",
	"player_camping_lamp",
	"player_picnic_basket",
]
const PLAYER_SUPPORT_SURFACE_INSET := 0.94
const PLAYER_SUPPORT_SURFACE_CLEARANCE := 0.02
const PLAYER_PLACEABLE_ASSETS := [
	{"kind": "player_tea_set", "label": "茶具", "path": PLAYER_PROPS_3D_DIR + "茶具.glb", "extent": 0.48, "yaw": 0.0},
	{"kind": "player_open_book", "label": "翻开的书", "path": PLAYER_PROPS_3D_DIR + "翻开的书.glb", "extent": 0.50, "yaw": -12.0},
	{"kind": "player_bread_plate", "label": "面包盘", "path": PLAYER_PROPS_3D_DIR + "面包盘.glb", "extent": 0.42, "yaw": 8.0},
	{"kind": "player_picnic_basket", "label": "野餐篮", "path": PLAYER_PROPS_3D_DIR + "野餐篮.glb", "extent": 0.58, "yaw": -18.0},
	{"kind": "player_picnic_blanket", "label": "野餐垫", "path": PLAYER_PROPS_3D_DIR + "野餐垫.glb", "extent": 1.08, "yaw": 12.0},
	{
		"kind": "player_camping_lamp",
		"label": "露营灯",
		"path": PLAYER_PROPS_3D_DIR + "露营灯.glb",
		"extent": 0.54,
		"yaw": 0.0,
		"light": {
			"offset": Vector3(0.0, 0.285, 0.045),
			"energy": 0.35,
			"range": 32.0,
			"attenuation": 1.15,
			"glow_scale": 0.11,
			"color": Color(1.0, 0.84, 0.54),
		},
	},
	{"kind": "player_vase", "label": "花瓶", "path": PLAYER_PROPS_3D_DIR + "花瓶.glb", "extent": 0.52, "yaw": 0.0},
	{"kind": "player_flowers", "label": "花丛", "path": PLAYER_PROPS_3D_DIR + "花丛.glb", "extent": 0.64, "yaw": 20.0},
	{"kind": "player_mailbox", "label": "信箱", "path": PLAYER_PROPS_3D_DIR + "信箱.glb", "extent": 0.62, "yaw": -8.0},
	{"kind": "player_paper_boat", "label": "纸船", "path": PLAYER_PROPS_3D_DIR + "纸船.glb", "extent": 0.46, "yaw": 28.0},
	{"kind": "player_bench", "label": "长椅", "path": PLAYER_PROPS_3D_DIR + "长椅.glb", "extent": 1.06, "yaw": -10.0},
	{"kind": "player_long_table", "label": "长桌", "path": PLAYER_PROPS_3D_DIR + "长桌.glb", "extent": 1.22, "yaw": 8.0},
	{"kind": "player_swing", "label": "秋千", "path": PLAYER_PROPS_3D_DIR + "秋千.glb", "extent": 1.18, "yaw": 0.0},
	{"kind": "player_cottage", "label": "小屋", "path": PLAYER_PROPS_3D_DIR + "小屋.glb", "extent": 1.00, "yaw": 0.0},
	{"kind": "player_tent", "label": "帐篷", "path": PLAYER_PROPS_3D_DIR + "帐篷.glb", "extent": 1.16, "yaw": -8.0},
]
const PLAYER_CHARACTER_ASSETS := [
	{"kind": "player_prince", "label": "小王子", "path": STANDING_PRINCE_3D, "extent": 0.62, "yaw": 0.0},
	{"kind": "player_long_hair_person", "label": "长发小人", "path": PLAYER_PROPS_3D_DIR + "长发小人.glb", "extent": 0.58, "yaw": -12.0},
	{"kind": "player_short_hair_person", "label": "短发小人", "path": PLAYER_PROPS_3D_DIR + "短发小人.glb", "extent": 0.58, "yaw": 12.0},
]
const STAR_BACKPACK_PLACEABLE_ASSETS := {
	"rose": [
		{
			"kind": "player_star_rose_combo",
			"label": "玫瑰 | 底座 | 玻璃罩",
			"path": ROSE_3D_DIR + "glass_dome.glb",
			"extent": 1.24,
			"yaw": 0.0,
			"layout_source": "res://rose_layout.json",
			"layout_anchor": "pedestal",
			"layout_kinds": ["pedestal", "rose_model", "glass_dome"],
			"layout_light_ids": ["king_light-copy-65"],
		},
	],
	"king": [
		{
			"kind": "player_star_king_throne",
			"label": "王座",
			"path": KING_THRONE_3D,
			"extent": 0.72,
			"yaw": 0.0,
		},
		{
			"kind": "player_star_king_banner",
			"label": "旗帜",
			"path": KING_BANNERS_3D,
			"extent": 0.72,
			"yaw": -8.0,
		},
	],
	"vain": [
		{
			"kind": "player_star_vain_petals",
			"label": "花瓣堆",
			"path": VAIN_3D_DIR + "petal_pile.glb",
			"extent": 0.64,
			"yaw": 10.0,
		},
		{
			"kind": "player_star_vain_mirror",
			"label": "镜子",
			"path": VAIN_3D_DIR + "ornate_mirror.glb",
			"extent": 0.72,
			"yaw": 0.0,
		},
	],
	"earth": [
		{
			"kind": "player_star_earth_fox",
			"label": "狐狸",
			"path": FOX_RIGGED_3D,
			"extent": 0.72,
			"yaw": -12.0,
		},
		{
			"kind": "player_star_earth_wheat_bundle",
			"label": "一束麦子",
			"path": EARTH_3D_DIR + "wheat_bundle.glb",
			"extent": 0.66,
			"yaw": 8.0,
		},
	],
	"merchant": [
		{
			"kind": "player_star_merchant_ledger",
			"label": "厚账簿",
			"path": MERCHANT_3D_DIR + "ledger.glb",
			"extent": 0.66,
			"yaw": -8.0,
		},
	],
	"pointlighter": [
		{
			"kind": "player_star_pointlighter_lamp",
			"label": "路灯",
			"path": LAMP_3D,
			"extent": 0.76,
			"yaw": 0.0,
			"light": {
				"offset": Vector3(0.0, 0.56, 0.115),
				"energy": 0.65,
				"range": 36.0,
				"attenuation": 1.15,
				"glow_scale": 0.15,
				"color": Color(1.0, 0.82, 0.52),
			},
		},
		{
			"kind": "player_star_pointlighter_chair",
			"label": "椅子",
			"path": CHAIR_3D,
			"extent": 0.68,
			"yaw": 8.0,
		},
	],
}
const LEGACY_STAR_PLACEABLE_KIND_MAP := {
	"player_star_rose": "player_star_rose_combo",
	"player_star_king": "player_star_king_throne",
	"player_star_vain": "player_star_vain_petals",
	"player_star_earth": "player_star_earth_wheat_bundle",
	"player_star_pointlighter": "player_star_pointlighter_lamp",
}
const MERCHANT_ABACUS_BEADS_3D := MERCHANT_3D_DIR + "abacus_beads.glb"
const MERCHANT_MID_ROPE_3D := MERCHANT_3D_DIR + "mid_rope.glb"
const MERCHANT_SHORT_ROPE_3D := MERCHANT_3D_DIR + "short_rope.glb"
const MERCHANT_LONG_HANGING_ROPE_3D := MERCHANT_3D_DIR + "long_hanging_rope.glb"
const MERCHANT_SHORT_SCROLL_3D := MERCHANT_3D_DIR + "short_scroll.glb"
const MERCHANT_OPEN_SCROLL_3D := MERCHANT_3D_DIR + "open_scroll.glb"
const MERCHANT_TALL_SCROLL_3D := MERCHANT_3D_DIR + "tall_scroll.glb"
const MERCHANT_DRAPED_SCROLL_3D := MERCHANT_3D_DIR + "draped_scroll.glb"
const MERCHANT_SCROLL_ASSETS := [
	{"kind": "short_scroll", "label": "短卷轴", "path": MERCHANT_SHORT_SCROLL_3D, "normal": Vector3(-0.46, 0.72, 0.52), "extent": 0.76, "radius": 2.84, "upright": false, "yaw": -24.0},
	{"kind": "open_scroll", "label": "翻开的卷轴", "path": MERCHANT_OPEN_SCROLL_3D, "normal": Vector3(0.20, 0.66, 0.72), "extent": 0.88, "radius": 2.83, "upright": false, "yaw": 12.0},
	{"kind": "tall_scroll", "label": "长卷轴", "path": MERCHANT_TALL_SCROLL_3D, "normal": Vector3(0.56, 0.73, 0.39), "extent": 1.04, "radius": 2.86, "upright": true, "yaw": 64.0},
	{"kind": "draped_scroll", "label": "垂落卷轴", "path": MERCHANT_DRAPED_SCROLL_3D, "normal": Vector3(-0.66, 0.50, 0.56), "extent": 1.02, "radius": 2.88, "upright": false, "yaw": -18.0},
]
const MERCHANT_CHARACTER_ASSET := {
	"kind": "merchant_character",
	"label": "商人",
	"path": MERCHANT_CHARACTER_3D,
	"normal": Vector3(0.12, 0.40, 0.91),
	"extent": 0.76,
	"radius": 2.72,
	"upright": true,
	"yaw": 0.0,
}
const VAIN_CHARACTER_ASSET := {
	"kind": "vain_character",
	"label": "爱慕虚荣的人",
	"path": VAIN_CHARACTER_3D,
	"normal": Vector3(0.0, 0.42, 0.91),
	"extent": 0.76,
	"radius": 2.72,
	"upright": true,
	"yaw": 0.0,
}
const PRINCE_COMPANION_ASSETS := {
	"rose": {
		"kind": "prince_character",
		"label": "小王子",
		"path": STANDING_PRINCE_3D,
		"normal": Vector3(-0.42, 0.46, 0.78),
		"extent": 0.68,
		"radius": 2.64,
		"upright": true,
		"yaw": 0.0,
		"default_animation": "ambient_idle",
	},
	"vain": {
		"kind": "prince_character",
		"label": "小王子",
		"path": STANDING_PRINCE_3D,
		"normal": Vector3(0.46, 0.40, 0.79),
		"extent": 0.68,
		"radius": 2.67,
		"upright": true,
		"yaw": 0.0,
		"default_animation": "ambient_idle",
	},
	"merchant": {
		"kind": "prince_character",
		"label": "小王子",
		"path": STANDING_PRINCE_3D,
		"normal": Vector3(-0.52, 0.38, 0.76),
		"extent": 0.70,
		"radius": 2.72,
		"upright": true,
		"yaw": 0.0,
		"default_animation": "ambient_idle",
	},
	"earth": {
		"kind": "prince_character",
		"label": "小王子",
		"path": STANDING_PRINCE_3D,
		"normal": Vector3(-0.52, 0.34, 0.78),
		"extent": 0.68,
		"radius": 2.61,
		"upright": true,
		"yaw": 0.0,
		"default_animation": "ambient_idle",
	},
}
const ABACUS_BEAD_ROW_Y := [0.146, 0.244, 0.343, 0.445, 0.543, 0.639]
const ABACUS_BEAD_INITIAL_ROWS := [
	[-0.150, -0.079, -0.011, 0.067, 0.149],
	[-0.143, -0.047, 0.031, 0.105, 0.151],
	[-0.151, -0.091, -0.020, 0.041, 0.143],
	[-0.139, -0.057, 0.026, 0.088, 0.148],
	[-0.147, -0.034, 0.038, 0.071, 0.149],
	[-0.152, -0.083, 0.001, 0.052, 0.146],
]
# The metal collars begin at about +/-0.178; keep their visible bevel clear.
const ABACUS_BEAD_MIN_Z := -0.172
const ABACUS_BEAD_MAX_Z := 0.172
const ABACUS_BEAD_VISUAL_SIZE := 0.0578
# This matches the bead silhouette along the rod instead of its wider diagonal
# source bounds, so touching beads leave only their natural rendering gap.
const ABACUS_BEAD_COLLISION_RADIUS := ABACUS_BEAD_VISUAL_SIZE * 0.375
const ABACUS_BEAD_HOLE_ALIGNMENT_YAW := -PI / 4.0
const ABACUS_BEAD_DRAG_RESPONSE := 26.0
const ABACUS_BEAD_SLIDE_DAMPING := 2.8
const ABACUS_BEAD_COLLISION_RESTITUTION := 0.34
const ABACUS_BEAD_END_RESTITUTION := 0.46
const ABACUS_BEAD_RELEASE_GAIN := 18.0
const ABACUS_BEAD_MAX_SPEED := 1.15
const ABACUS_BEAD_IMPACT_DECAY := 4.8
const ABACUS_BEAD_MAX_DRAG_STEP := ABACUS_BEAD_COLLISION_RADIUS * 0.72
const STAR_LAMP_SWING_OMEGA := 8.4
const STAR_LAMP_SWING_DAMPING := 2.25
const STAR_LAMP_SWING_MAX_ANGLE := deg_to_rad(13.0)
const STAR_LAMP_SWING_MAX_SPEED := 6.2
const STAR_LAMP_SWING_DRIVE := 24.0
const STAR_LAMP_SWING_DRIVE_MAX := 30.0
const STAR_LAMP_SWING_DRIVE_DECAY := 13.0
const PLAYER_WATERWAYS_SCRIPT := preload("res://scripts/player_waterways.gd")
const PLAYER_ASSET_CARD_SCRIPT := preload("res://scripts/player_asset_card.gd")
const PLAYER_DROP_SURFACE_SCRIPT := preload("res://scripts/player_drop_surface.gd")
const PLAYER_THUMBNAIL_RENDERER_SCRIPT := preload("res://scripts/player_thumbnail_renderer.gd")
const PLAYER_ASSET_FACTORY_SCRIPT := preload("res://scripts/player_asset_factory.gd")
const PLAYER_LIGHT_STRING_SCRIPT := preload("res://scripts/player_light_string.gd")
const PLAYER_LIGHT_STRING_MAX := 3
const PLAYER_LIGHT_STRING_ANCHOR_HEIGHT := 0.48
const PLAYER_LIGHT_STRING_MIN_SPAN := 0.18
const PLAYER_LIGHT_STRING_PICK_RADIUS := 9.0
const PLAYER_PERSON_KINDS := [
	"player_long_hair_person",
	"player_short_hair_person",
]
const PLAYER_AVATAR_OPTIONS := [
	{
		"kind": "player_short_hair_person",
		"label": "形象一",
		"caption": "清爽、轻盈，像一页刚刚翻开的故事。",
	},
	{
		"kind": "player_long_hair_person",
		"label": "形象二",
		"caption": "安静、柔和，像晚风里的一束星光。",
	},
]
const PLAYER_CHARACTER_KINDS := [
	"player_long_hair_person",
	"player_short_hair_person",
	"player_prince",
]
const PLAYER_SEAT_KINDS := [
	"player_bench",
	"player_star_pointlighter_chair",
	"player_star_king_throne",
	"player_swing",
]
const FOX_IDLE_CYCLE_CLIPS := [
	"Idle",
	"Idle_2",
	"Idle_2_HeadLow",
]
const PLAYER_SEAT_POSE_SCHEMA_VERSION := 1
const PLAYER_NAV_WALK_SPEED := 0.62
const PLAYER_NAV_PRINCE_TRAIL_OFFSET := 0.22
const PLAYER_NAV_PRINCE_SHOULDER_OFFSET := 0.07
const PLAYER_NAV_PRINCE_HANDHOLD_SIDE_OFFSET := 0.12
const PLAYER_NAV_ARRIVE_DISTANCE := 0.025
const PLAYER_NAV_TURN_DURATION := 0.24
const PLAYER_NAV_FOLLOW_START_DISTANCE := 0.46
const PLAYER_NAV_FOLLOW_TARGET_DISTANCE := 0.035
const PLAYER_NAV_STUCK_TIMEOUT := 0.8
const PLAYER_NAV_PROGRESS_EPSILON := 0.004
const PLAYER_HANDHOLD_ATTACH_DISTANCE := 0.38
const PLAYER_SEAT_POSE_HOLD_TIME := 0.95
const PLAYER_GLANCE_TURN_DURATION := 0.52
const PLAYER_GLANCE_HOLD_DURATION := 2.0
const PLAYER_GLANCE_RETURN_DURATION := 0.60
const PLAYER_SEATED_GLANCE_INTERVAL := 3.0
const PLAYER_DIALOGUE_CLOSE_DISTANCE := 1.2
const PLAYER_DIALOGUE_CAMERA_LIFT := 0.075
const NON_PLAYER_DIALOGUE_ZOOM_SCALE := 1.85
const PLAYER_DIALOGUE_BUBBLE_MIN_WIDTH := 220.0
const PLAYER_DIALOGUE_BUBBLE_MAX_WIDTH := 660.0
const PLAYER_DIALOGUE_BUBBLE_MAX := 3
const PLAYER_DIALOGUE_SPOT_ENERGY := 1.0
const PLAYER_DIALOGUE_PRINCE_SPOT_ENERGY := 0.6
const PLAYER_DIALOGUE_FILL_ENERGY := 0.18
const PRINCE_EXPRESSION_REPLY_DELAY := 1.24
const PRINCE_CHARACTER_KINDS := [
	"standing_prince",
	"prince_character",
	"looking_up_prince",
	"player_prince",
]
const PLANET_BASE_LIGHTING_MIN := 0.25
const PLANET_BASE_LIGHTING_MAX := 2.0
const PLANET_BASE_LIGHTING_STEP := 0.05
const EARTH_WHEAT_TONE_SHADER := "res://shaders/earth_wheat_tone.gdshader"
const EARTH_WHEAT_DEFAULT_BRIGHTNESS := 0.88
const EARTH_WHEAT_DEFAULT_SATURATION := 0.82
const EARTH_WHEAT_TONE_STEP := 0.05
const EARTH_WHEAT_TONE_VERSION := 2
const EARTH_LIGHT_DEFAULT_YAW := 34.0
const EARTH_LIGHT_YAW_STEP := 10.0
const GENERATED_PLANET_SCENES := {
	"玫瑰": {
		"slug": "rose",
		"kicker": "第六颗星 | ASTEROID B-612",
		"quote": "“一朵玫瑰，把整颗星球变成了家。”",
		"base": ROSE_3D_DIR + "rose_planet_base.glb",
		"atmosphere": Color(0.58, 0.42, 0.76, 0.34),
		"assets": [
			{"kind": "glass_dome", "label": "玻璃罩", "path": ROSE_3D_DIR + "glass_dome.glb", "normal": Vector3(0.08, 0.72, 0.69), "extent": 1.30, "upright": true, "yaw": 0.0},
			{"kind": "small_house", "label": "小屋", "path": ROSE_3D_DIR + "small_house.glb", "normal": Vector3(-0.55, 0.52, 0.65), "extent": 0.98, "upright": true, "yaw": -10.0},
			{"kind": "baobab", "label": "猴面包树", "path": ROSE_3D_DIR + "baobab.glb", "normal": Vector3(-0.86, 0.42, 0.28), "extent": 1.12, "upright": true, "yaw": 18.0},
			{"kind": "volcano", "label": "火山", "path": ROSE_3D_DIR + "volcano.glb", "normal": Vector3(0.73, 0.43, 0.52), "extent": 0.82, "upright": true, "yaw": 40.0},
			{"kind": "fence", "label": "栅栏", "path": ROSE_3D_DIR + "fence.glb", "normal": Vector3(0.38, 0.48, 0.79), "extent": 1.10, "upright": true, "yaw": 8.0},
			{"kind": "stone_path", "label": "石板路", "path": ROSE_3D_DIR + "stone_path.glb", "normal": Vector3(-0.10, 0.34, 0.94), "extent": 1.22, "upright": false, "yaw": -8.0},
			{"kind": "grass", "label": "草丛", "path": ROSE_3D_DIR + "grass.glb", "normal": Vector3(0.62, 0.28, 0.73), "extent": 0.46, "upright": true, "yaw": 0.0},
			{"kind": "flower_cluster", "label": "花簇", "path": ROSE_3D_DIR + "flower_cluster.glb", "normal": Vector3(-0.71, 0.29, 0.64), "extent": 0.54, "upright": true, "yaw": 0.0},
			{"kind": "flower_patch", "label": "花丛", "path": ROSE_3D_DIR + "flower_patch.glb", "normal": Vector3(0.22, 0.24, 0.94), "extent": 0.68, "upright": true, "yaw": 0.0},
			{"kind": "pedestal", "label": "底座", "path": ROSE_3D_DIR + "pedestal.glb", "normal": Vector3(-0.22, 0.82, -0.52), "extent": 0.58, "upright": true, "yaw": 0.0},
			{"kind": "rose_model", "label": "玫瑰", "path": ROSE_3D_DIR + "rose_model.glb", "normal": Vector3(-0.0626, 0.9659, 0.2513), "extent": 0.95, "radius": 2.46, "upright": true, "yaw": 0.0},
			{"kind": "round_tree", "label": "圆冠树", "path": ROUND_TREE_3D, "normal": Vector3(-0.64, 0.54, 0.55), "extent": 0.72, "upright": true, "yaw": 0.0},
			{"kind": "pine_tree", "label": "针叶树", "path": PINE_TREE_3D, "normal": Vector3(0.66, 0.52, 0.54), "extent": 0.74, "upright": true, "yaw": 0.0},
			{"kind": "grass", "label": "草丛（点灯人）", "path": GRASS_3D, "normal": Vector3(0.35, 0.28, 0.89), "extent": 0.44, "upright": true, "yaw": 0.0},
		],
	},
	"爱慕虚荣的人": {
		"slug": "vain",
		"kicker": "第二颗星 | ASTEROID 326",
		"quote": "“他要所有的掌声，却不敢看镜子背面。”",
		"base": VAIN_3D_DIR + "vain_planet_base.glb",
		"atmosphere": Color(0.68, 0.42, 0.88, 0.34),
		"assets": [
			{"kind": "gazebo", "label": "镜亭", "path": VAIN_3D_DIR + "gazebo.glb", "normal": Vector3(0.02, 0.58, 0.81), "extent": 1.62, "upright": true, "yaw": 0.0},
			{"kind": "ornate_mirror", "label": "华丽镜子", "path": VAIN_3D_DIR + "ornate_mirror.glb", "normal": Vector3(-0.04, 0.70, 0.71), "extent": 0.95, "upright": true, "yaw": 0.0},
			{"kind": "mirror_fan", "label": "镜扇雕塑", "path": VAIN_3D_DIR + "mirror_fan.glb", "normal": Vector3(-0.54, 0.47, 0.70), "extent": 0.80, "upright": true, "yaw": -24.0},
			{"kind": "purple_curtain", "label": "紫色帷幕", "path": VAIN_3D_DIR + "purple_curtain.glb", "normal": Vector3(0.49, 0.46, 0.74), "extent": 0.88, "upright": true, "yaw": 20.0},
			{"kind": "top_hat", "label": "礼帽", "path": VAIN_3D_DIR + "top_hat.glb", "normal": Vector3(0.16, 0.25, 0.95), "extent": 0.52, "upright": true, "yaw": 0.0},
			{"kind": "mirror_base", "label": "镜子底座", "path": VAIN_3D_DIR + "mirror_base.glb", "normal": Vector3(-0.24, 0.35, 0.90), "extent": 0.62, "upright": true, "yaw": 0.0},
			{"kind": "star_clasp", "label": "星星扣", "path": VAIN_3D_DIR + "star_clasp.glb", "normal": Vector3(0.70, 0.24, 0.67), "extent": 0.48, "upright": true, "yaw": 0.0, "glow": 0.38, "light_energy": 0.70, "light_range": 2.20},
			{"kind": "purple_rocks", "label": "紫色岩簇", "path": VAIN_3D_DIR + "purple_rocks.glb", "normal": Vector3(-0.76, 0.20, 0.61), "extent": 0.66, "upright": true, "yaw": 0.0},
			{"kind": "petal_pile", "label": "花瓣堆", "path": VAIN_3D_DIR + "petal_pile.glb", "normal": Vector3(0.30, 0.13, 0.94), "extent": 0.62, "upright": false, "yaw": 0.0},
			{"kind": "round_tree", "label": "圆冠树", "path": ROUND_TREE_3D, "normal": Vector3(-0.68, 0.50, 0.54), "extent": 0.70, "upright": true, "yaw": 0.0},
			{"kind": "pine_tree", "label": "针叶树", "path": PINE_TREE_3D, "normal": Vector3(0.67, 0.49, 0.56), "extent": 0.72, "upright": true, "yaw": 0.0},
			{"kind": "grass", "label": "草丛（点灯人）", "path": GRASS_3D, "normal": Vector3(0.28, 0.24, 0.93), "extent": 0.44, "upright": true, "yaw": 0.0},
			{"kind": "purple_curtain_feature", "label": "紫色帷幕 02", "path": VAIN_3D_DIR + "purple_curtain.glb", "normal": Vector3(0.18, 0.54, 0.82), "extent": 1.25, "radius": 2.62, "upright": true, "yaw": -12.0},
		],
	},
	"商人": {
		"slug": "merchant",
		"kicker": "第四颗星 | ASTEROID 328",
		"quote": "“他把星星编上号码，却从不抬头看它们。”",
		"base": MERCHANT_3D_DIR + "merchant_planet_base.glb",
		"atmosphere": Color(0.38, 0.50, 0.76, 0.30),
		"assets": [
			{"kind": "tall_tower", "label": "高塔", "path": MERCHANT_3D_DIR + "tall_tower.glb", "normal": Vector3(-0.66, 0.45, 0.60), "extent": 1.16, "upright": true, "yaw": 28.0},
			{"kind": "short_tower", "label": "矮塔", "path": MERCHANT_3D_DIR + "short_tower.glb", "normal": Vector3(0.66, 0.43, 0.62), "extent": 1.02, "upright": true, "yaw": -25.0},
			{"kind": "filing_cabinet", "label": "档案柜", "path": MERCHANT_3D_DIR + "filing_cabinet.glb", "normal": Vector3(-0.34, 0.26, 0.90), "extent": 0.80, "upright": true, "yaw": 0.0},
			{"kind": "safe", "label": "保险箱", "path": MERCHANT_3D_DIR + "safe.glb", "normal": Vector3(0.38, 0.22, 0.90), "extent": 0.76, "upright": true, "yaw": 0.0},
			{"kind": "abacus", "label": "算盘", "path": MERCHANT_3D_DIR + "abacus.glb", "normal": Vector3(0.02, 0.19, 0.98), "extent": 0.78, "upright": true, "yaw": 0.0},
			{"kind": "ledger", "label": "账簿", "path": MERCHANT_3D_DIR + "ledger.glb", "normal": Vector3(0.25, 0.12, 0.96), "extent": 0.56, "upright": false, "yaw": -12.0},
			{"kind": "star_tag", "label": "星星标签", "path": MERCHANT_3D_DIR + "star_tag.glb", "normal": Vector3(-0.26, 0.14, 0.95), "extent": 0.50, "upright": true, "yaw": 0.0},
			{"kind": "square_lamp", "label": "小方灯", "path": MERCHANT_3D_DIR + "square_lamp.glb", "normal": Vector3(-0.78, 0.19, 0.59), "extent": 0.56, "upright": true, "yaw": 0.0, "glow": 0.55},
			{"kind": "star_lamp", "label": "星星灯", "path": MERCHANT_3D_DIR + "star_lamp.glb", "normal": Vector3(0.78, 0.20, 0.59), "extent": 0.68, "upright": true, "yaw": 0.0, "glow": 0.68},
			{"kind": "short_cabinet", "label": "矮柜", "path": MERCHANT_3D_DIR + "short_cabinet.glb", "normal": Vector3(0.58, 0.30, 0.76), "extent": 0.78, "upright": true, "yaw": -8.0},
			{"kind": "round_tree", "label": "圆冠树", "path": ROUND_TREE_3D, "normal": Vector3(-0.62, 0.55, 0.56), "extent": 0.72, "upright": true, "yaw": 0.0},
			{"kind": "pine_tree", "label": "针叶树", "path": PINE_TREE_3D, "normal": Vector3(0.65, 0.52, 0.55), "extent": 0.74, "upright": true, "yaw": 0.0},
			{"kind": "grass", "label": "草丛（点灯人）", "path": GRASS_3D, "normal": Vector3(0.34, 0.25, 0.91), "extent": 0.44, "upright": true, "yaw": 0.0},
			{"kind": "mid_rope", "label": "中绳", "path": MERCHANT_MID_ROPE_3D, "normal": Vector3(-0.72, 0.60, 0.35), "extent": 0.62, "radius": 2.66, "upright": true, "yaw": 8.0},
			{"kind": "short_rope", "label": "短绳", "path": MERCHANT_SHORT_ROPE_3D, "normal": Vector3(0.72, 0.60, 0.35), "extent": 0.54, "radius": 2.66, "upright": true, "yaw": -12.0},
			{"kind": "long_hanging_rope", "label": "吊绳长", "path": MERCHANT_LONG_HANGING_ROPE_3D, "normal": Vector3(-0.08, 0.64, 0.76), "extent": 0.76, "radius": 2.64, "upright": true, "yaw": 16.0},
		],
	},
	"狐狸与麦田": {
		"slug": "earth",
		"kicker": "第三颗星 | EARTH",
		"quote": "“麦浪会记住一种脚步声。”",
		"base": EARTH_3D_DIR + "earth_planet_base.glb",
		"atmosphere": Color(0.42, 0.62, 0.90, 0.30),
		"assets": [
			{"kind": "earth_hill", "label": "山坡", "path": EARTH_3D_DIR + "earth_hill.glb", "normal": Vector3(-0.36, 0.43, 0.83), "extent": 1.42, "upright": true, "yaw": -18.0},
			{"kind": "wheat_field", "label": "麦田", "path": EARTH_3D_DIR + "wheat_field.glb", "normal": Vector3(0.08, 0.26, 0.96), "extent": 1.38, "upright": true, "yaw": 4.0},
			{"kind": "grass_wheat_patch", "label": "草麦地", "path": EARTH_3D_DIR + "grass_wheat_patch.glb", "normal": Vector3(0.56, 0.20, 0.80), "extent": 1.08, "upright": true, "yaw": 14.0},
			{"kind": "wheat", "label": "麦穗 01", "path": EARTH_3D_DIR + "wheat.glb", "normal": Vector3(-0.70, 0.19, 0.69), "extent": 0.62, "upright": true, "yaw": 0.0},
			{"kind": "wheat", "label": "麦穗 02", "path": EARTH_3D_DIR + "wheat.glb", "normal": Vector3(0.38, 0.13, 0.92), "extent": 0.56, "upright": true, "yaw": 21.0},
			{"kind": "round_tree", "label": "圆冠树", "path": ROUND_TREE_3D, "normal": Vector3(-0.63, 0.54, 0.56), "extent": 0.72, "upright": true, "yaw": 0.0},
			{"kind": "pine_tree", "label": "针叶树", "path": PINE_TREE_3D, "normal": Vector3(0.66, 0.51, 0.55), "extent": 0.74, "upright": true, "yaw": 0.0},
			{"kind": "grass", "label": "草丛（点灯人）", "path": GRASS_3D, "normal": Vector3(0.31, 0.24, 0.92), "extent": 0.44, "upright": true, "yaw": 0.0},
			{"kind": "fox", "label": "狐狸", "path": FOX_RIGGED_3D, "normal": Vector3(0.18, 0.28, 0.94), "extent": 0.66, "radius": 2.58, "upright": true, "yaw": -10.0},
			{"kind": "seated_prince_origami", "label": "坐着的小王子", "path": EARTH_SEATED_PRINCE_3D, "normal": Vector3(-0.22, 0.30, 0.93), "extent": 0.58, "radius": 2.59, "upright": true, "yaw": 0.0},
		],
	},
	"我的星球": {
		"slug": "player",
		"kicker": "第七颗星 | YOUR OWN PLANET",
		"quote": "“这一次，星球由你来写。”",
		"base": PLAYER_SCENE_BASE_3D,
		"atmosphere": Color(0.44, 0.68, 0.70, 0.30),
		"assets": [],
	},
}
const POINTLIGHTER_LAYOUT_PATH := "user://pointlighter_layout.json"
const KING_LAYOUT_PATH := "user://king_layout.json"
const INITIAL_VIEW_CONFIG_PATH := "user://planet_initial_views.json"
const INITIAL_VIEW_PROJECT_PATH := "res://planet_initial_views.json"
const GENERATED_PLANET_RADIUS := 2.35
const VISUAL_PLANET_BASE_RADIUS := 2.52
const VISUAL_PLANET_BASE_Y_OFFSET := 0.45
const HOUSE_SURFACE_NORMAL := Vector3(0.3100, 0.8200, 0.4800)
const LAMP_SURFACE_NORMAL := Vector3(-0.3400, 0.6800, 0.6500)
const NORMALIZED_PLANET_HEIGHT := 3.15
const PLANET_HOME_DISTANCE := 6.4
const PLANET_HOME_FOCUS_Y := 0.82 - NORMALIZED_PLANET_HEIGHT * 0.25
const PLANET_HOME_CAMERA_HEIGHT := PLANET_HOME_FOCUS_Y + 0.34
const POINTLIGHTER_HOME_DISTANCE := PLANET_HOME_DISTANCE
const POINTLIGHTER_MIN_DISTANCE := 4.2
const POINTLIGHTER_MAX_DISTANCE := 10.0
const CAMERA_ZOOM_MIN_DISTANCE := 2.8
const CAMERA_ZOOM_MAX_DISTANCE := 24.0
const GENERATED_PLANET_HOME_DISTANCE := PLANET_HOME_DISTANCE
const ROSE_GLASS_CLEAR_COLOR := Color(0.62, 0.84, 1.0, 0.12)
const ROSE_GLASS_FOG_COLOR := Color(0.84, 0.86, 0.84, 0.58)
const ROSE_GLASS_CLEAR_ROUGHNESS := 0.035
const ROSE_GLASS_FOG_ROUGHNESS := 0.74
const KING_HOME_DISTANCE := PLANET_HOME_DISTANCE
const KING_MIN_DISTANCE := 3.15
const KING_HOME_YAW_DEGREES := -16.0
const KING_CELESTIAL_CENTER_Y := -0.22
const KING_CELESTIAL_TILT_DEGREES := 0.0
const KING_CLOTH_WIND_SHADER := "res://shaders/king_cloth_wind.gdshader"
const KING_CLOTH_WIND_ENABLED := false
const ROSE_BLOOM_SHADER := "res://shaders/rose_bloom.gdshader"
const FOX_PAPER_SHADER := "res://shaders/fox_paper.gdshader"
const EARTH_FOX_DIALOGUE_IDLE_CLIPS := [
	"Idle",
	"Idle_2",
	"Idle_2_HeadLow",
]
const EARTH_FOX_DIALOGUE_IDLE_SECONDS := 2.4
const EARTH_FOX_DIALOGUE_PRINCE_HEAD_TILT_DEGREES := -30.0
const EARTH_FOX_CAVE_FRONT_LOCAL := Vector3.RIGHT
const EARTH_FOX_CAVE_ENTRANCE_LOCAL := Vector3(0.80, 0.065, 0.0)
const EARTH_FOX_CAVE_INSIDE_LOCAL := Vector3(0.50, 0.065, 0.0)
const EARTH_FOX_SURFACE_CLEARANCE := 0.012
const ROSE_DIALOGUE_MOODS := {
	"intro": {
		"bloom": 0.52,
		"sway": 0.0021,
		"breath": 0.0055,
		"tremble": 0.06,
		"leaf": 0.55,
		"glow": 0.09,
		"turn": 0.12,
		"fog": 0.0,
	},
	"wind": {
		"bloom": 0.25,
		"sway": 0.0028,
		"breath": 0.0022,
		"tremble": 0.62,
		"leaf": 1.0,
		"glow": 0.04,
		"turn": -0.34,
		"fog": 0.14,
	},
	"dome": {
		"bloom": 0.33,
		"sway": 0.0019,
		"breath": 0.0032,
		"tremble": 0.22,
		"leaf": 0.42,
		"glow": 0.06,
		"turn": -0.18,
		"fog": 0.28,
	},
	"unique": {
		"bloom": 0.72,
		"sway": 0.0031,
		"breath": 0.0095,
		"tremble": 0.04,
		"leaf": 0.72,
		"glow": 0.17,
		"turn": 0.38,
		"fog": 0.40,
	},
	"core": {
		"bloom": 0.46,
		"sway": 0.0022,
		"breath": 0.0048,
		"tremble": 0.12,
		"leaf": 0.55,
		"glow": 0.10,
		"turn": 0.30,
		"fog": 0.50,
	},
	"core_care": {
		"bloom": 0.76,
		"sway": 0.0030,
		"breath": 0.0090,
		"tremble": 0.04,
		"leaf": 0.80,
		"glow": 0.22,
		"turn": 0.68,
		"fog": 0.58,
	},
	"core_leave": {
		"bloom": 0.24,
		"sway": 0.0025,
		"breath": 0.0026,
		"tremble": 0.38,
		"leaf": 0.95,
		"glow": 0.03,
		"turn": -0.78,
		"fog": 0.65,
	},
	"core_here": {
		"bloom": 0.61,
		"sway": 0.0024,
		"breath": 0.0068,
		"tremble": 0.05,
		"leaf": 0.82,
		"glow": 0.16,
		"turn": 0.86,
		"fog": 0.72,
	},
	"core_here_reply": {
		"bloom": 0.81,
		"sway": 0.0028,
		"breath": 0.0100,
		"tremble": 0.02,
		"leaf": 1.0,
		"glow": 0.27,
		"turn": 0.96,
		"fog": 0.80,
	},
	"reflection": {
		"bloom": 0.43,
		"sway": 0.0020,
		"breath": 0.0042,
		"tremble": 0.20,
		"leaf": 0.68,
		"glow": 0.13,
		"turn": 0.48,
		"fog": 0.90,
	},
	"ending": {
		"bloom": 0.57,
		"sway": 0.0018,
		"breath": 0.0055,
		"tremble": 0.30,
		"leaf": 0.62,
		"glow": 0.31,
		"turn": 0.58,
		"fog": 1.0,
	},
}
const KING_LIGHT_KIND := "king_light"
const KING_SIT_HOLD_POSITION := 4.0
const KING_SIT_HOLD_DURATION := 5.0
const EDITABLE_LIGHT_KINDS := [
	"square_lamp",
	"star_lamp",
	"star_clasp",
	"player_camping_lamp",
	"player_star_pointlighter_lamp",
	KING_LIGHT_KIND,
]
const DEFAULT_GLOW_POINT_NORMALS := {
	"pointlighter": Vector3(-0.38, 0.78, 0.50),
	"rose": Vector3(0.46, 0.76, 0.46),
	"vain": Vector3(-0.52, 0.74, 0.43),
	"merchant": Vector3(0.30, 0.80, 0.52),
	"earth": Vector3(-0.35, 0.77, 0.53),
}
const BLUR_SHADER := "res://shaders/mono_blur.gdshader"
const COVER_BACKDROP_SCRIPT := preload("res://scripts/cover_backdrop.gd")
const STARMAP_BACKDROP_SCRIPT := preload("res://scripts/starmap_backdrop.gd")
const CHAT_BUBBLE_BUTTON_SCRIPT := preload("res://scripts/chat_bubble_button.gd")
const PLANET_ITEM_GLOW_SCRIPT := preload("res://scripts/planet_item_glow.gd")
const PLANET_ITEM_STARFIELD_GAP := 120.0
const PLANET_ITEM_OUTLINE_GAP := 24.0
const FACE_ARROW_BUTTON_SCRIPT := preload("res://scripts/face_arrow_button.gd")
const PAPER_CLOSE_BUTTON_SCRIPT := preload("res://scripts/paper_close_button.gd")
const PAPER_CLOTH_BUTTON_SCRIPT := preload("res://scripts/paper_cloth_button.gd")
const MEMORY_STAR_BUTTON_SCRIPT := preload("res://scripts/memory_star_button.gd")
const PAPER_BACKPACK_SCRIPT := preload("res://scripts/paper_backpack.gd")
const MEMORY_PAPER_FRAGMENT_SCRIPT := preload("res://scripts/memory_paper_fragment.gd")
const MEMORY_SOURCE_AURA_SCRIPT := preload("res://scripts/memory_source_aura.gd")
const JOURNEY_CONSTELLATION_SCRIPT := preload(
	"res://scripts/journey_constellation.gd"
)
const EDITABLE_DIALOGUE_TEXT_SCRIPT := preload("res://scripts/editable_dialogue_text.gd")
const UI_LAYOUT_EDITOR_SCRIPT := preload("res://scripts/ui_layout_editor.gd")
const DIALOGUE_TEXT_LAYOUT_PATH := "res://dialogue_text_layout.json"
const DIALOGUE_TEXT_USER_LAYOUT_PATH := "user://dialogue_text_layout.json"
const DIALOGUE_TEXT_DEFAULT_RECT := Rect2(32.0, 7.0, 385.0, 40.0)
const UI_FONT_CAPTION := 16
const UI_FONT_ACTION := 18
const UI_FONT_BODY := 20
const WEB_FONT_PATH := "res://assets/ui/fonts/ZCOOLXiaoWei-Regular.ttf"
const DIALOGUE_TEXT_DEFAULT_FONT_SIZE := 22
const DIALOGUE_TEXT_DEFAULT_LINE_SPACING := 0
const WIND_KINDS := ["round_tree", "pine_tree", "grass"]
const EARTH_WHEAT_KINDS := ["wheat_field", "grass_wheat_patch"]
const MERCHANT_ROPE_KINDS := ["mid_rope", "short_rope", "long_hanging_rope"]
const ALWAYS_SURFACE_UPRIGHT_KINDS := [
	"standing_prince",
	"prince_character",
	"player_prince",
]
const CLICK_FEEDBACK_KINDS := [
	"round_tree",
	"pine_tree",
	"grass",
	"rocks",
	"stone_path",
	"ladder",
]
const ROSE_JELLY_EXCLUDED_KINDS := [
	"rose_model",
	"procedural_rose",
	"glass_dome",
	"pedestal",
	"small_house",
	"prince_character",
	"king_light",
]
const ROSE_JELLY_KINDS := [
	"baobab",
	"volcano",
	"fence",
	"stone_path",
	"grass",
	"flower_cluster",
	"flower_patch",
	"round_tree",
	"pine_tree",
	"rocks",
]
const MERCHANT_TREE_JELLY_KINDS := [
	"round_tree",
	"pine_tree",
]

const STORY_DIALOGUE_DATA := preload("res://scripts/planet_story_dialogues.gd")
const PLAYER_PRINCE_DIALOGUE_DATA := preload(
	"res://scripts/player_prince_dialogue.gd"
)
const DIALOGUE_NODES := STORY_DIALOGUE_DATA.POINTLIGHTER_DIALOGUE_NODES
const STORY_SCENE_SLUGS := ["rose", "vain", "merchant", "earth"]
const PLANET_STORY_STATE_PATH := "user://planet_story.cfg"
const STAR_MEMORY_STATE_PATH := "user://star_memories.cfg"
const JOURNEY_STATE_PATH := "user://journey.cfg"
const ONBOARDING_STATE_PATH := "user://onboarding_state.cfg"
const MEMORY_ORDER := ["rose", "king", "vain", "earth", "merchant", "pointlighter"]
const MAP_IDLE_HINTS := [
	"移动鼠标 | 点击星球 | ESC 返回",
	"编号是路标，不是顺序",
]
const PLAYER_IDLE_HINTS := [
	"按住拖动看四周 | 滚轮缩放 | 双击复位",
	"点地面或发光座位，角色会自己走过去",
	"点击星球上方的光点，切换白天与夜晚",
	"人物未能前进时会自动回到安全站位",
	"右下角：保存、拍照、对话、贴纸",
]
const STORY_HINT_CYCLE_SECONDS := 6.5
const VAIN_DIALOGUE_BUBBLE_OFFSET := Vector2(150.0, -56.0)
const VAIN_DANCE_CLIP := "dance_01_001"
const VAIN_DANCE_BLEND_SECONDS := 0.55
const MEMORY_DEFINITIONS := {
	"rose": {
		"title": "玫瑰与玻璃罩",
		"quote": "不是摘走那朵花，而是记住你曾经让隔在中间的玻璃重新变透明。",
		"accent": Color(0.90, 0.42, 0.60),
		"fragments": ["rose", "dome"],
		"anchor": "glass_dome",
	},
	"king": {
		"title": "太阳余晖与王冠",
		"quote": "权力不是让世界停下，而是让每一次升落都有人回应。",
		"accent": Color(0.97, 0.73, 0.30),
		"fragments": ["sun", "crown"],
		"anchor": "king_sun",
	},
	"vain": {
		"title": "花瓣与镜子",
		"quote": "你带走的不是掌声，也不是镜中的倒影。",
		"accent": Color(0.80, 0.52, 0.94),
		"fragments": ["petal", "mirror"],
		"anchor": "ornate_mirror",
	},
	"earth": {
		"title": "狐狸与一束麦子",
		"quote": "麦子以后还是麦子。只是每次被风吹动，都会像一种熟悉的脚步。",
		"accent": Color(0.96, 0.61, 0.25),
		"fragments": ["fox", "wheat"],
		"anchor": "fox",
	},
	"merchant": {
		"title": "星灯与厚账簿",
		"quote": "这串灯没有编号。它只负责在夜里亮着。",
		"accent": Color(0.49, 0.77, 0.92),
		"fragments": ["lamp", "ledger"],
		"anchor": "star_lamp",
	},
	"pointlighter": {
		"title": "灯焰与一把椅子",
		"quote": "夜色第一次没有催促任何人。",
		"accent": Color(0.98, 0.68, 0.29),
		"fragments": ["lamp", "chair"],
		"anchor": "main_lamp",
	},
}

const KING_DIALOGUE_NODES := {
	"intro": {
		"speaker": "国王",
		"text": "啊，来了一位臣民。走近些，让我看看你。\n\n我统治星星、天空，还有你脚下的这颗星球。",
		"choices": [
			{"id": "alone", "label": "这里除了您，还有谁可以让您管呢？", "next": "alone"},
			{"id": "obedience", "label": "如果没有人听，您说的话还算命令吗？", "next": "obedience"},
			{"id": "sun", "label": "您每天都和太阳说些什么呀？", "next": "sun"},
			{"label": "那您想让我做什么呀？", "next": "invitation"},
		],
	},
	"alone": {
		"speaker": "国王",
		"text": "至少现在有你。你看，我的星球终于有了第二位居民。",
		"narration": "他把“第二位”说得很轻，像怕那两个字也会被风吹走。",
		"returns_to_menu": true,
		"choices": [],
	},
	"obedience": {
		"speaker": "国王",
		"text": "命令先留在我的口中；只有当另一个人回应，它才会变成现实。",
		"narration": "他望向空空的台阶，仿佛那里仍站着未曾离开的臣民。",
		"returns_to_menu": true,
		"choices": [],
	},
	"sun": {
		"speaker": "国王",
		"text": "我当然可以命令它。但太阳只应在该落下时落下。\n\n权威首先必须合理。若一道命令违背世界，那不是世界失了礼，而是我说错了时间。",
		"narration": "他抬起头，没有立刻开口下令。",
		"returns_to_menu": true,
		"choices": [],
	},
	"invitation": {
		"speaker": "国王",
		"text": "我命令你留下。\n\n你看，我没有让你做做不到的事。这是一道多么合理的命令。",
		"narration": "他说完，悄悄看了一眼身后的王座，像在确认它是否还在。",
		"choices": [
			{"id": "easy_order", "label": "只让我留下，也看不出您有多厉害呀。", "next": "easy_order"},
			{"id": "useful_order", "label": "那就说一件这颗星现在真的需要您做的事吧。", "next": "useful_order"},
			{"id": "refuse", "label": "如果我不听呢？", "next": "refuse"},
		],
	},
	"easy_order": {
		"speaker": "国王",
		"text": "难道忠诚不是从一件小事里才看得见吗？",
		"narration": "他的语气仍然威严，手指却已经握紧了座椅边缘。",
		"choices": [{"label": "可是小事也要别人心里愿意才行呀。", "next": "reflection"}],
	},
	"useful_order": {
		"speaker": "国王",
		"text": "真正需要的命令？\n\n我已经太久只对空椅子说话，竟忘了世界也会向我提出要求。",
		"narration": "王冠的影子落在红毯上，第一次显得比王冠本身更沉重。",
		"choices": [{"label": "那先听听星星现在在做什么吧。", "next": "reflection"}],
	},
	"refuse": {
		"speaker": "国王",
		"text": "那我就命令你不许拒绝。\n\n……这句话听起来，比前一句还要空。",
		"narration": "他难得地停住了，没有把第二枚想象中的印章盖下去。",
		"choices": [{"label": "不让人说不，听起来就像一个人在自言自语。", "next": "reflection"}],
	},
	"reflection": {
		"speaker": "国王",
		"text": "我总想让星星、太阳和你都停下来，好让这顶王冠继续有分量。\n\n可如果世界真的停了，我还能命令谁去做什么呢？",
		"narration": "王座旁的小灯照着一段落满灰尘的旧命令。红毯尽头，仍然没有人应声。",
		"choices": [
			{"label": "让太阳升起来吧。我陪您过完一整天。", "next": "help"},
		],
	},
	"help": {
		"speaker": "国王",
		"text": "好。不是替王冠，也不是替我。\n\n只替这颗还在转动的星。",
		"narration": "他把扶着王座的手慢慢抬起来，像第一次松开一件并不属于自己的东西。",
		"choices": [
			{"label": "结束对话", "action": "begin_king_ritual"},
		],
	},
}

const PLANETS := [
	{
		"name": "玫瑰",
		"id": "B-612",
		"slug": "rose",
		"center": Vector2(470, 370),
		"size": Vector2(190, 181),
		"radius": 76.0,
		"brightness": 0.92,
		"text": "一朵玫瑰，把整颗星球变成了家。"
	},
	{
		"name": "国王",
		"id": "325",
		"slug": "king",
		"center": Vector2(1240, 240),
		"size": Vector2(145, 162),
		"radius": 60.0,
		"brightness": 1.14,
		"text": "他统治着空无一人的星球，却依然相信命令是合理的。"
	},
	{
		"name": "爱慕虚荣的人",
		"id": "326",
		"slug": "vain",
		"center": Vector2(1040, 430),
		"size": Vector2(170, 180),
		"radius": 64.0,
		"brightness": 0.73,
		"text": "他要所有的掌声，却不敢看镜子背面。"
	},
	{
		"name": "狐狸与麦田",
		"id": "地球",
		"slug": "fox",
		"center": Vector2(740, 685),
		"size": Vector2(225, 217),
		"radius": 95.0,
		"brightness": 0.92,
		"text": "麦浪会记住一种脚步声。"
	},
	{
		"name": "商人",
		"id": "328",
		"slug": "merchant",
		"center": Vector2(1090, 660),
		"size": Vector2(210, 232),
		"radius": 80.0,
		"brightness": 1.02,
		"text": "他把星星编上号码，却从不抬头看它们。"
	},
	{
		"name": "点灯人",
		"id": "329",
		"slug": "lamplighter",
		"center": Vector2(1280, 500),
		"size": Vector2(150, 181),
		"radius": 60.0,
		"brightness": 1.06,
		"text": "星球转得太快，一分钟就是一次日落。"
	},
	{
		"name": PLAYER_PLANET_NAME,
		"id": "第七星",
		"slug": "player",
		"center": Vector2(420, 684),
		"size": Vector2(228, 228),
		"radius": 89.0,
		"brightness": 0.84,
		"text": "一片还等着被写下故事的空地。",
		"hidden_until_memories": true,
	},
]

const PLANET_ITEM_INTROS := {
	"rose": [
		{
			"kind": "rose_model",
			"name": "玫瑰",
			"text": "“娇气是真的，想被珍惜也是真的。”",
			"glow_screen_offset": Vector2(-100.0, 70.0),
		},
		{
			"kind": "glass_dome",
			"name": "玻璃罩",
			"text": "“挡住风和虫，也挡住她说出口的脆弱。”",
			"glow_screen_offset": Vector2(90.0, -90.0),
		},
		{
			"kind": "baobab",
			"name": "猴面包树",
			"text": "“若不趁小的时候拔掉，它会撑裂整颗星球。”",
			"glow_screen_offset": Vector2(-15.0, 15.0),
		},
	],
	"king": [
		{
			"kind": "king_throne",
			"name": "王座",
			"text": "“坐得越高，听见的‘遵命’却越像回声。”",
		},
		{
			"kind": "king_crown",
			"name": "皇冠",
			"text": "“它被举得很高，因为戴着它的人只有自己。”",
		},
		{
			"kind": "king_banners",
			"name": "旗帜",
			"text": "“没有臣民仰望，它仍每天准时宣布统治。”",
		},
	],
	"vain": [
		{
			"kind": "ornate_mirror",
			"name": "华丽镜子",
			"text": "“他最怕的不是镜子，而是镜子里没有掌声。”",
		},
		{
			"kind": "gazebo",
			"name": "镜亭",
			"text": "“每面镜子都只映出他想看见的模样。”",
		},
		{
			"kind": "top_hat",
			"name": "礼帽",
			"text": "“装饰越亮，越需要有人一直看着。”",
		},
	],
	"merchant": [
		{
			"kind": "star_lamp",
			"name": "星星灯",
			"text": "“他给星星编了号码，却忘了它们原本会发光。”",
		},
		{
			"kind": "ledger",
			"name": "账簿",
			"text": "“每一页都记着价格，没有一页写着晚霞。”",
		},
		{
			"kind": "abacus",
			"name": "算盘",
			"text": "“珠子拨得再快，也算不出星星走过的路。”",
		},
	],
	"earth": [
		{
			"kind": "fox",
			"name": "狐狸",
			"text": "“你驯养了我，麦田才开始像你的头发。”",
		},
		{
			"kind": "wheat_field",
			"name": "麦田",
			"text": "“风一吹，整片金色都在回应一种脚步声。”",
		},
		{
			"kind": "wheat",
			"name": "一束麦子",
			"text": "“普通的黄麦，从此有了想被记住的颜色。”",
			"fallback_kind": "grass_wheat_patch",
		},
	],
	"pointlighter": [
		{
			"kind": "main_lamp",
			"name": "主灯",
			"text": "“它只亮一分钟，却守着一整颗星球的黑夜。”",
		},
		{
			"kind": "ladder",
			"name": "梯子",
			"text": "“上上下下太多次，连木头也记住了他的脚步。”",
		},
		{
			"kind": "house",
			"name": "小屋",
			"text": "“屋里没有别人，门却一直替夜晚留着。”",
		},
	],
}

# Planet titles share a left visual anchor while the number line follows each
# name's measured width. Values are fractions of the title-paper size so the
# composition remains identical in windowed and fullscreen modes.
const STAR_TITLE_LAYOUT_RATIOS := {
	"rose": {
		"name_x": 0.1804,
		"kicker_x": 0.3967,
	},
	"fox": {
		"name_x": 0.1752,
		"kicker_x": 0.5693,
	},
	"merchant": {
		"name_x": 0.1817,
		"kicker_x": 0.3823,
	},
	"vain": {
		"name_x": 0.1712,
		"kicker_x": 0.5784,
	},
	"lamplighter": {
		"name_x": 0.1856,
		"kicker_x": 0.4268,
	},
	"king": {
		"name_x": 0.1843,
		"kicker_x": 0.3889,
	},
	"player": {
		"name_x": 0.1843,
		"kicker_x": 0.5200,
	},
}

var main_ui: Control
var ui_clean_mode_active := false
var ui_clean_mode_restore_states: Array[Dictionary] = []
var ui_clean_mode_planet_states: Array[Dictionary] = []
var interface_theme: Theme
var interface_font: Font
var body_font: Font
var cover: Control
var cover_content: Control
var cover_enter_button: Button
var cover_load_button: Button
var cover_new_game_button: Button
var save_slot_overlay: Control
var save_slot_panel: PanelContainer
var save_slot_status: Label
var save_slot_buttons: Array[Button] = []
var new_game_confirm_overlay: Control
var new_game_confirm_body: Label
var map_screen: Control
var map_backdrop: Control
var map_cosmos_layer: Control
var map_cloud_far_layer: Control
var map_cloud_mid_layer: Control
var map_cloud_near_layer: Control
var map_planet_layer: Control
var map_route_layer
var map_zoom_root: Control
var map_scene_label: Label
var map_hint: Label
var map_onboarding_overlay: Control
var map_onboarding_panel: PanelContainer
var map_onboarding_button: Button
var map_onboarding_triggered := false
var map_onboarding_completed := false
var map_hint_cycle_elapsed := 0.0
var map_hint_cycle_index := 0
var map_hint_cycle_tween: Tween
var map_back_button: Button
var map_skip_button: Button
var map_loading_overlay: Control
var map_loading_flyer: TextureRect
var map_loading_progress: ProgressBar
var planet_loading_generation := 0
var planet_loading_name := ""
var planet_loading_fly_tween: Tween
var king_loading_requested := false
var king_loading_failed := false
var passage: Control
var passage_glow: ColorRect
var passage_page: TextureRect
var passage_edge: TextureRect
var passage_prince_above: TextureRect
var passage_prince_below: TextureRect
var detail_screen: Control
var detail_name: Label
var detail_text: Label
var detail_back_button: Button
var stage_3d: Node3D
var hud_3d: CanvasLayer
var dream_grade_layer: CanvasLayer
var camera_3d: Camera3D
var current_3d_scene := ""
var pointlighter_model_3d: Node3D
var pointlighter_model_loading := false
var pointlighter_model_ready := false
var pointlighter_editable_objects: Array[Dictionary] = []
var pointlighter_selected_editable_index := -1
var pointlighter_deleted_editable_ids: Array[String] = []
var king_model_3d: Node3D
var king_editable_objects: Array[Dictionary] = []
var king_selected_editable_index := -1
var king_deleted_editable_ids: Array[String] = []
var king_celestial_root: Node3D
var king_sun_root: Node3D
var king_moon_root: Node3D
var king_sun_material: ShaderMaterial
var king_moon_material: ShaderMaterial
var king_celestial_orbit_material: StandardMaterial3D
var king_sun_glow: Sprite3D
var king_moon_glow: Sprite3D
var earth_story_sun: Node3D
var earth_story_sun_material: ShaderMaterial
var earth_story_sun_glow: Sprite3D
var earth_story_sun_tween: Tween
var earth_fox_search_active := false
var earth_fox_search_running := false
var earth_fox_search_generation := 0
var earth_fox_cave_normal := Vector3.ZERO
var earth_fox_cave_radius := 2.7
var earth_fox_route_bend := 0.0
var earth_fox_route_radii: Array[float] = []
var earth_fox_inside_cave := false
var earth_fox_exit_running := false
var earth_fox_exit_generation := 0
var earth_fox_ground_body: StaticBody3D
var earth_fox_dialogue_idle_active := false
var earth_fox_dialogue_idle_generation := 0
var king_day_night_blend := 0.0
var king_day_night_target := 0.0
var king_celestial_rotation := 0.0
var king_celestial_target_rotation := 0.0
var king_celestial_time := 0.0
var king_celestial_was_pressed := false
var king_character_3d: Node3D
var king_sit_hold_states: Dictionary = {}
var king_prince_3d: Node3D
var king_dialogue_complete := false
var king_ritual_active := false
var king_ritual_phase := ""
var king_ritual_generation := 0
var king_ritual_sun_was_pressed := false
var king_light_was_pressed := -1
var king_floor_y := 3.15
var generated_planet_models: Dictionary = {}
var generated_planet_editable_objects: Dictionary = {}
var generated_planet_selected_indices: Dictionary = {}
var generated_planet_deleted_ids: Dictionary = {}
var generated_planet_ready: Dictionary = {}
var generated_planet_last_used: Dictionary = {}
var generated_planet_cache_tick := 0
var generated_model_scene_cache: Dictionary = {}
var pending_player_river_layout: Dictionary = {}
var hud_scene_title_plate: NinePatchRect
var hud_scene_kicker: Label
var hud_scene_title: Label
var hud_scene_quote: Label
var hud_scene_hint: Label
var earth_fox_search_controls: Label
var planet_item_glow_layer: Control
var planet_item_glows: Array[Dictionary] = []
var planet_item_note_panel: PanelContainer
var planet_item_note_label: Label
var planet_item_glow_scene_key := ""
var planet_item_note_target := ""
var planet_item_note_age := 0.0
var planet_item_glow_time := 0.0
var planet_item_outline_mesh_samples: Dictionary = {}
var planet_item_outline_cache := PackedVector2Array()
var planet_item_outline_cache_key := ""
var planet_item_outline_cache_at_msec := -100000
var stage_environment: Environment
var planet_light_rig: Node3D
var stage_key_light: DirectionalLight3D
var stage_rim_light: DirectionalLight3D
var stage_cool_fill: OmniLight3D
var stage_front_fill: OmniLight3D
var earth_front_light: DirectionalLight3D
var warm_fill_light: OmniLight3D
var player_dialogue_spotlights: Array[SpotLight3D] = []
var player_dialogue_fill_light: OmniLight3D
var player_dialogue_light_tween: Tween
var player_dialogue_light_generation := 0
var model_3d: Node3D
var main_lamp_node: Node3D
var main_lamp_light_anchor: Node3D
var main_lamp_light: OmniLight3D
var main_lamp_glow_sprites: Array[Sprite3D] = []
var main_lamp_emissive_materials: Array[Dictionary] = []
var main_lamp_on := true
var main_lamp_level := 1.0
var main_lamp_target_level := 1.0
var chair_3d: Node3D
var seated_prince_3d: Node3D
var model_spin_velocity := Vector2.ZERO
var model_drag_distance := 0.0
var lamp_was_pressed := false
var hovered_feedback_index := -1
var prop_wobble_states: Dictionary = {}
var starfield_root: Node3D
var atmosphere_sprites: Array[Sprite3D] = []
var cloud_sprites: Array[Dictionary] = []
var soft_glow_sprites: Array[Dictionary] = []
var firefly_sprites: Array[Dictionary] = []
var atmosphere_time := 0.0
var wheat_hover_pointer := Vector2.ZERO
var wheat_hover_pointer_valid := false
var wheat_hover_pointer_velocity := Vector2.ZERO
var earth_wheat_materials: Array[ShaderMaterial] = []
var earth_wheat_wind_time := 0.0
var earth_wheat_wind_strength := 0.0
var earth_wheat_wind_origin := Vector3.ZERO
var earth_wheat_wind_direction := Vector3(0.0, 0.0, 1.0)
var earth_wheat_wind_origin_valid := false
var editor_panel: PanelContainer
var editor_scroll: ScrollContainer
var editor_edit_button: Button
var editor_heading: Label
var editor_subheading: Label
var editor_object_select: ItemList
var editor_scale_slider: HSlider
var editor_yaw_slider: HSlider
var editor_distance_slider: HSlider
var editor_distance_title: Label
var editor_height_row: HBoxContainer
var editor_height_title: Label
var editor_height_slider: HSlider
var editor_height_value: Label
var editor_height_lock_row: HBoxContainer
var editor_standing_height_lock_button: Button
var editor_sitting_height_lock_button: Button
var editor_scale_value: Label
var editor_yaw_value: Label
var editor_camera_distance_slider: HSlider
var editor_camera_distance_value: Label
var editor_planet_height_value: Label
var editor_surface_tilt_slider: HSlider
var editor_surface_tilt_value: Label
var editor_distance_value: Label
var editor_light_x: SpinBox
var editor_light_y: SpinBox
var editor_light_z: SpinBox
var editor_position_label: Label
var editor_visible_check: CheckBox
var editor_light_on_check: CheckBox
var editor_brightness_row: HBoxContainer
var editor_brightness_slider: HSlider
var editor_brightness_value: Label
var editor_base_lighting_slider: HSlider
var editor_base_lighting_value: Label
var editor_character_animation_row: HBoxContainer
var editor_character_animation_select: OptionButton
var editor_character_animation_value: Label
var editor_earth_wheat_controls: VBoxContainer
var editor_earth_wheat_brightness_value: Label
var editor_earth_wheat_saturation_value: Label
var editor_earth_light_yaw_value: Label
var editor_add_light_button: Button
var editor_status_label: Label
var editor_lock_button: Button
var editor_delete_button: Button
var editor_selection_ring: MeshInstance3D
var king_ritual_subtitle: Label
var king_sun_click_guide: Button
var editable_3d_objects: Array[Dictionary] = []
var deleted_editable_ids: Array[String] = []
var planet_base_lighting_levels: Dictionary = {}
var selected_editable_index := -1
var editor_active := false
var editor_dragging_object := false
var editor_drag_travel := 0.0
var editable_serial := 0
var standing_prince_3d: Node3D
var lamplighter_3d: Node3D
var chair_state := "hidden"
var chair_dragging := false
var chair_drag_distance := 0.0
var chair_target_transform := Transform3D.IDENTITY
var chair_float_transform := Transform3D.IDENTITY
var chair_target_normal := Vector3.UP
var chair_target_root_radius := 2.35
var chair_target_yaw := 0.0
var chair_target_scale := Vector3.ONE
var chair_action_button: Button
var chair_target_marker: PanelContainer
var chair_status_label: Label
var chair_subtitle_label: Label
var lamp_dialogue_trigger: Button
var dialogue_panel: PanelContainer
var dialogue_scroll: ScrollContainer
var dialogue_log: VBoxContainer
var dialogue_choices: VBoxContainer
var dialogue_body_frame: MarginContainer
var dialogue_active := false
var dialogue_busy := false
var dialogue_scene := ""
var dialogue_heading: Label
var dialogue_node_id := "intro"
var dialogue_generation := 0
var asked_dialogue_questions: Dictionary = {}
var dialogue_text_edit_active := false
var dialogue_text_toolbar: PanelContainer
var dialogue_text_status: Label
var dialogue_text_edit_button: Button
var dialogue_text_widgets: Array[Control] = []
var dialogue_text_slots: Array[Dictionary] = []
var selected_dialogue_text_index := 0
var ui_layout_editor: CanvasLayer
var planet_story_states := {
	"rose": "new",
	"vain": "new",
	"merchant": "new",
	"earth": "new",
}
var story_action_button: Button
var rose_cloth_button: Button
var story_subtitle_panel: Control
var story_subtitle_label: Label
var story_hint_panel: PanelContainer
var story_hint_label: Label
var story_hint_cycle_elapsed := 0.0
var story_hint_cycle_index := 0
var story_hint_cycle_scene := ""
var story_hint_cycle_hints: Array[String] = []
var story_hint_cycle_tween: Tween
var story_hint_override_text := ""
var story_hint_override_until_msec := 0
var story_camera_hint_shown := false
var story_item_hint_shown := false
var story_dialogue_hint_shown := false
var story_star_hint_shown := false
var story_recap_shown := false
var story_action_phase := ""
var story_action_slug := ""
var story_action_generation := 0
var story_reaction_generation := 0
var story_wipe_dragging := false
var story_wipe_progress := 0.0
var story_glass_materials: Array[Dictionary] = []
var rose_animation_root: Node3D
var rose_animation_materials: Array[ShaderMaterial] = []
var rose_animation_toward := Vector2.RIGHT
var rose_animation_bloom := 0.5
var rose_animation_sway := 0.0007
var rose_animation_breath := 0.0018
var rose_animation_tremble := 0.0
var rose_animation_leaf := 0.22
var rose_animation_glow := 0.02
var rose_animation_turn := 0.0
var rose_animation_target_bloom := 0.5
var rose_animation_target_sway := 0.0007
var rose_animation_target_breath := 0.0018
var rose_animation_target_tremble := 0.0
var rose_animation_target_leaf := 0.22
var rose_animation_target_glow := 0.02
var rose_animation_target_turn := 0.0
var rose_glass_fog := 0.0
var rose_glass_fog_target := 0.0
var rose_animation_base_transform := Transform3D.IDENTITY
var rose_animation_transform_active := false
var rose_animation_time := 0.0
var story_action_actor: Node3D
var story_action_target: Node3D
var story_merchant_bead_index := -1
var story_camera_focus_active := false
var story_camera_saved_position := Vector3.ZERO
var story_camera_saved_focus := Vector3.ZERO
var story_camera_saved_distance := POINTLIGHTER_HOME_DISTANCE
var story_camera_saved_h_offset := 0.0
var story_camera_saved_v_offset := 0.0
var story_camera_saved_up := Vector3.UP
var story_model_saved_position := Vector3.ZERO
var story_model_saved_scale := Vector3.ONE
var story_model_saved_quaternion := Quaternion.IDENTITY
var story_camera_from_position := Vector3.ZERO
var story_camera_to_position := Vector3.ZERO
var story_camera_from_focus := Vector3.ZERO
var story_camera_to_focus := Vector3.ZERO
var story_camera_from_up := Vector3.UP
var story_camera_to_up := Vector3.UP
var story_camera_from_h_offset := 0.0
var story_camera_to_h_offset := 0.0
var story_camera_from_v_offset := 0.0
var story_camera_to_v_offset := 0.0
var story_model_from_position := Vector3.ZERO
var story_model_to_position := Vector3.ZERO
var story_model_from_scale := Vector3.ONE
var story_model_to_scale := Vector3.ONE
var story_model_from_quaternion := Quaternion.IDENTITY
var story_model_to_quaternion := Quaternion.IDENTITY
var story_camera_tween_generation := 0
var story_camera_tween: Tween
var memory_star_button: Button
var memory_source_aura: Control
var memory_backpack: Control
var memory_backpack_label: Label
var memory_fragment_layer: Control
var memory_collection_states: Dictionary = {}
var memory_reveal_after: Dictionary = {}
var memory_collection_busy := false
var memory_collection_generation := 0
var prince_fade_progress := 0.0
var prince_sitting := false
var planet_records: Dictionary = {}
var awake_planets: Dictionary = {}
var journey_slugs: Array[String] = []
var journey_legacy_reconstructed := false
var journey_finale_played := false
var journey_finale_sequence_active := false
var journey_finale_generation := 0
var planet_initial_orientations: Dictionary = {}
var planet_framing_offsets: Dictionary = {}
var transition_running := false
var dragging_3d := false
var camera_distance := 5.8
var camera_home_position := Vector3.ZERO
var camera_focus_point := Vector3.ZERO
var model_orbit_enabled := false
var abacus_bead_targets: Array[Dictionary] = []
var abacus_bead_dragging := false
var abacus_bead_hover_index := -1
var abacus_bead_drag_index := -1
var abacus_bead_drag_target_z := 0.0
var star_lamp_hovered_index := -1
var star_lamp_swing_states: Dictionary = {}
var star_lamp_kick_times: Dictionary = {}
var merchant_lamp_assembly_pivots: Array[Node3D] = []
var rigged_animation_cache: Dictionary = {}
var prince_ambient_idle_states: Dictionary = {}
var earth_wheat_brightness := EARTH_WHEAT_DEFAULT_BRIGHTNESS
var earth_wheat_saturation := EARTH_WHEAT_DEFAULT_SATURATION
var earth_light_yaw := EARTH_LIGHT_DEFAULT_YAW
var merchant_hover_pointer := Vector2.ZERO
var merchant_hover_pointer_valid := false
var map_parallax := Vector2.ZERO
var map_parallax_target := Vector2.ZERO
var preview_mode_active := false
var king_cutout_bright_background := false
var active_planet_name := ""
var planet_zoom_active := false
var planet_zoom_returning := false
var planet_zoom_request := 0
var planet_zoom_tween: Tween
var passage_prince_base_position := Vector2.ZERO
var passage_prince_base_size := Vector2.ZERO
var passage_prince_map_position_offset := Vector2.ZERO
var passage_prince_map_offset_ratio := Vector2.ZERO
var passage_prince_map_scale := 1.0
var passage_settled_elapsed := 0.0
var cover_title_labels: Array[Label] = []
var player_planet_revealed := false
var player_planet_reveal_tween: Tween
var player_place_button: Button
var player_character_reset_button: Button
var player_place_dock: PanelContainer
var player_place_scroll: ScrollContainer
var player_place_row: HBoxContainer
var player_place_status: Label
var player_place_items_tab: Button
var player_place_stars_tab: Button
var player_place_page := "items"
var player_place_height_row: HBoxContainer
var player_place_height_title: Label
var player_place_height_slider: HSlider
var player_place_height_value: Label
var player_height_lock_row: HBoxContainer
var player_standing_height_lock_button: Button
var player_sitting_height_lock_button: Button
var player_item_action_arc: Control
var player_item_lock_button: Button
var player_item_action_buttons: Array[Button] = []
var player_drop_surface: Control
var player_dragged_asset_index := -1
var player_drag_last_screen_position := Vector2.ZERO
var player_3d_drag_preview: Node3D
var player_3d_drag_preview_asset_index := -1
var player_3d_drag_preview_scale := 1.0
var player_3d_drag_preview_footprint := 0.1
var player_3d_drag_preview_height_offset := 0.0
var player_3d_drag_preview_user_scale := 1.0
var player_placement_surface_body: StaticBody3D
var player_placement_surface_mesh: MeshInstance3D
var player_placement_plane_ready := false
var player_placement_plane_center := Vector3.ZERO
var player_placement_plane_normal := Vector3.UP
var player_placement_plane_right := Vector3.RIGHT
var player_placement_plane_forward := Vector3.BACK
var player_placement_plane_half_right := 1.0
var player_placement_plane_half_forward := 1.0
var player_asset_height_offsets: Dictionary = {}
var player_asset_support_height_offsets: Dictionary = {}
var player_asset_scale_defaults: Dictionary = {}
var player_seat_pose_offsets: Dictionary = {}
var player_standing_height_locks: Dictionary = {}
var player_sitting_height_locks: Dictionary = {}
var active_player_character_id := ""
var player_navigation_active := false
var player_navigation_phase := "idle"
var player_navigation_serial := 0
var player_navigation_leader_id := ""
var player_navigation_prince_id := ""
var player_navigation_target_position := Vector3.ZERO
var player_navigation_target_normal := Vector3.UP
var player_navigation_leader_direction := Vector3.BACK
var player_character_reset_states: Dictionary = {}
var player_navigation_turn_elapsed := 0.0
var player_navigation_leader_turn_from := 0.0
var player_navigation_leader_turn_to := 0.0
var player_navigation_prince_turn_from := 0.0
var player_navigation_prince_turn_to := 0.0
var player_navigation_prince_turn_elapsed := 0.0
var player_navigation_prince_follow_state := "idle"
var player_navigation_prince_follow_target := Vector3.ZERO
var player_navigation_stuck_elapsed := 0.0
var player_navigation_progress_distance := INF
var player_navigation_follower_stuck_elapsed := 0.0
var player_navigation_follower_progress_distance := INF
var player_handhold_active := false
var player_handhold_target: Node3D
var player_handhold_skeletons: Array[Skeleton3D] = []
var player_handhold_leader_side := ""
var player_handhold_prince_side := ""
var player_handhold_pair_direction := Vector3.ZERO
var player_handhold_leader_palm_center := Vector3.ZERO
var player_handhold_prince_palm_center := Vector3.ZERO
var player_prince_interaction_open := false
var player_prince_interaction_button: Button
var player_prince_look_button: Button
var player_prince_look_active := false
var player_prince_look_generation := 0
var player_seated_glance_loop_active := false
var player_character_interaction_open := false
var player_dialogue_stage_active := false
var player_dialogue_stage_saved: Dictionary = {}
var player_dialogue_bubble_root: Control
var player_dialogue_bubbles: Array[Dictionary] = []
var player_dialogue_bubble_generation := 0
var player_dialogue_symbol_button: Button
var player_sticker_symbol_button: Button
var player_save_symbol_button: Button
var player_photo_symbol_button: Button
var player_save_toast: Label
var player_save_toast_tween: Tween
var player_keepsake_flow
var player_expression_bar: PanelContainer
var player_expression_scroll: ScrollContainer
var player_expression_row: HBoxContainer
var player_expression_buttons: Array[Button] = []
var player_expression_overlay: Control
var player_expression_popup: TextureRect
var prince_expression_popup: TextureRect
var player_expression_tween: Tween
var prince_expression_tween: Tween
var player_expression_generation := 0
var player_expression_cooldown_until_msec := 0
var player_expression_last_sent := ""
var player_expression_last_reply := ""
var player_expression_history: Array[Dictionary] = []
var player_navigation_planned_seat: Dictionary = {}
var player_navigation_pointer_seat: Dictionary = {}
var player_navigation_marker: Node3D
var player_navigation_marker_materials: Array[StandardMaterial3D] = []
var player_navigation_marker_time := 0.0
var player_navigation_marker_fading := false
var player_navigation_marker_fade_elapsed := 0.0
var player_seat_glow_markers: Array[Dictionary] = []
var player_placement_selected_index := -1
var player_placement_object_dragging := false
var player_placement_object_drag_moved := false
var player_placement_drag_press_position := Vector2.ZERO
var player_placement_drag_screen_offset := Vector2.ZERO
var player_placement_drag_travel := 0.0
var player_asset_cards: Array[Control] = []
var player_placeable_entries: Array[Dictionary] = []
var player_thumbnail_textures: Dictionary = {}
var player_thumbnail_renderer
var player_thumbnail_generation_started := false
var player_thumbnail_generation_serial := 0
var player_thumbnail_generation_busy := false
var player_thumbnail_generation_requested := false
var player_light_strings: Array[Dictionary] = []
var player_light_string_drawing := false
var player_light_string_has_start := false
var player_light_string_start := Vector3.ZERO
var player_light_string_preview: Node3D
var player_light_string_selected_index := -1
var player_light_string_dragged_handle := -1
var player_light_string_snap_label := ""
var player_light_string_operation_hint: Label
var player_day_night_blend := 1.0
var player_day_night_target := 1.0
var player_firefly_opacity := 0.0
var player_day_night_beacon: Node3D
var player_day_night_beacon_core: MeshInstance3D
var player_day_night_beacon_halo: Sprite3D
var player_day_night_beacon_outer_halo: Sprite3D
var player_day_night_beacon_light: OmniLight3D
var player_day_night_beacon_core_material: StandardMaterial3D
var player_day_night_beacon_was_pressed := false
var player_day_night_beacon_hovered := false
var player_day_night_beacon_color := PLAYER_DAY_BEACON_COLOR
var player_day_night_beacon_ripple: Control
var player_onboarding_overlay: Control
var player_onboarding_panel: PanelContainer
var player_onboarding_title: Label
var player_onboarding_body: Label
var player_onboarding_note: Label
var player_onboarding_button: Button
var player_onboarding_step := -1
var player_onboarding_triggered := false
var player_onboarding_completed := false
var player_avatar_selected := false
var player_move_guide_completed := false
var player_move_guide_active := false
var player_day_night_guide_completed := false
var player_day_night_guide_active := false
var player_move_guide: TextureRect
var player_move_guide_caption: Label
var player_move_guide_target := Vector3.ZERO
var player_move_guide_time := 0.0
var player_place_button_feedback_started_msec := 0
var player_item_lock_feedback_tween: Tween
var player_hint_cycle_elapsed := 0.0
var player_hint_cycle_index := 0
var player_hint_cycle_tween: Tween
var player_avatar_picker_overlay: Control
var player_avatar_picker_panel: PanelContainer
var player_avatar_picker_cards: Array[Button] = []
var player_avatar_picker_previews: Array[TextureRect] = []
var player_avatar_picker_preview_renderer
var player_avatar_picker_generation := 0
var player_avatar_picker_open := false
var player_avatar_picker_completed := false
var player_avatar_picker_choice_locked := false


func _ready() -> void:
	king_cutout_bright_background = OS.get_cmdline_user_args().has(
		"--king-cutout-bright-bg"
	)
	get_window().title = "小王子 | 纸雕星图"
	_load_awake_state()
	_load_planet_story_state()
	_load_memory_state()
	_load_journey_state()
	_load_onboarding_state()
	_load_planet_initial_orientations()
	_load_dialogue_text_layout()
	ui_layout_editor = UI_LAYOUT_EDITOR_SCRIPT.new()
	ui_layout_editor.name = "UiLayoutEditor"
	add_child(ui_layout_editor)
	_build_ui()
	_build_3d_stage()
	_show_cover()
	call_deferred("_resume_pending_session_target")
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	get_window().focus_exited.connect(_on_window_focus_exited)
	call_deferred("_apply_preview_mode")
	call_deferred("_on_viewport_size_changed")


func _process(delta: float) -> void:
	if ui_layout_editor != null:
		var ui_scope := ""
		if stage_3d != null and stage_3d.visible:
			ui_scope = "hud"
		elif map_screen != null and map_screen.visible:
			ui_scope = "map"
		elif cover != null and cover.visible:
			ui_scope = "cover"
		ui_layout_editor.set_context_available(not ui_scope.is_empty(), ui_scope)
		# Scene-title text changes can trigger a delayed label layout update.
		# Reassert the saved title transform every frame while leaving the
		# live drag untouched whenever the layout editor is active.
		if ui_scope == "hud" and not ui_layout_editor.edit_active:
			_reapply_star_title_layout(current_3d_scene)
	_recover_stalled_pointer_interactions()
	_update_3d_atmosphere(delta)
	_update_king_celestial(delta)
	_update_player_day_night(delta)
	_update_king_ritual_ui()
	_update_rose_dialogue_animation(delta)
	_update_editable_wind_and_wobble(delta)
	_update_prince_chair(delta)
	_update_player_seated_pose_holds()
	_update_3d_interaction_ui()
	_update_player_movement_guide(delta)
	_update_planet_item_glows(delta)
	_update_player_item_action_arc()
	_update_player_light_string_operation_hint()
	_update_planet_story_ui()
	_update_memory_collection_ui()
	_update_map_hint_cycle(delta)
	_update_story_hint_cycle(delta)
	_update_player_hint_cycle(delta)
	_maintain_dialogue_camera_focus()
	_update_player_dialogue_bubbles(delta)
	_update_player_dialogue_lights()
	_update_model_orbit(delta)
	_update_merchant_hover_interactions()
	_update_abacus_beads(delta)
	_update_star_lamp_swings(delta)
	_update_player_navigation(delta)
	_update_prince_ambient_idle(delta)
	_update_vain_default_dance()
	_update_king_sitting_animation(delta)
	if map_planet_layer == null or map_backdrop == null:
		return
	var map_interactive := (
		map_screen.visible
		and not transition_running
		and not planet_zoom_active
		and not stage_3d.visible
	)
	if map_interactive:
		var viewport_size: Vector2 = get_viewport().get_visible_rect().size
		if viewport_size.x > 0.0 and viewport_size.y > 0.0:
			var pointer := get_viewport().get_mouse_position() / viewport_size - Vector2(0.5, 0.5)
			map_parallax_target = pointer.limit_length(1.0)
	else:
		map_parallax_target = Vector2.ZERO
	if planet_zoom_active or not map_screen.visible:
		return
	var blend := 1.0 - exp(-delta * 6.5)
	map_parallax = map_parallax.lerp(map_parallax_target, blend)
	_apply_map_parallax()
	if (
		passage != null
		and passage.visible
		and (not transition_running or journey_finale_sequence_active)
		and passage_prince_below != null
		and passage_prince_below.modulate.a > 0.0
	):
		passage_settled_elapsed += delta
		var bob := 0.5 - 0.5 * cos(passage_settled_elapsed * TAU / 4.2)
		passage_prince_below.position = (
			passage_prince_base_position
			+ passage_prince_map_offset_ratio * main_ui.size
			+ Vector2(0.0, -main_ui.size.y * 0.011 * bob)
		)
		passage_prince_below.scale = (
			Vector2.ONE
			* passage_prince_map_scale
			* lerpf(0.96, 1.0, bob)
		)
		passage_prince_below.rotation = deg_to_rad(lerpf(-0.8, -0.2, bob))


func _apply_map_parallax() -> void:
	if map_planet_layer == null:
		return
	# Matches the web prototype's data-depth translation exactly.
	map_planet_layer.position = -map_parallax * Vector2(6.6, 4.2)
	map_cosmos_layer.position = Vector2.ZERO
	map_cloud_far_layer.position = -map_parallax * Vector2(3.52, 2.24)
	map_cloud_mid_layer.position = -map_parallax * Vector2(4.84, 3.08)
	map_cloud_near_layer.position = -map_parallax * Vector2(11.0, 7.0)


func _build_ui() -> void:
	var ui_layer := CanvasLayer.new()
	ui_layer.name = "Interface"
	add_child(ui_layer)

	main_ui = Control.new()
	main_ui.name = "MainUI"
	ui_layer.add_child(main_ui)
	main_ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var story_body_font := load(WEB_FONT_PATH) as Font
	body_font = story_body_font
	interface_font = story_body_font
	interface_theme = Theme.new()
	if interface_font != null:
		interface_theme.default_font = interface_font
	interface_theme.default_font_size = UI_FONT_BODY
	main_ui.theme = interface_theme

	_build_cover()
	_build_map()
	_build_passage()
	_build_detail()


func _add_background(parent: Control, path: String, tint := Color.WHITE) -> TextureRect:
	var texture_rect := TextureRect.new()
	parent.add_child(texture_rect)
	texture_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	texture_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	texture_rect.texture = load(path)
	texture_rect.modulate = tint
	return texture_rect


func _add_label(
	parent: Control,
	text: String,
	position: Vector2,
	size: Vector2,
	font_size: int,
	color := Color(0.91, 0.87, 0.78),
	alignment := HORIZONTAL_ALIGNMENT_CENTER
) -> Label:
	var label := Label.new()
	parent.add_child(label)
	label.text = text
	label.position = position
	label.size = size
	label.horizontal_alignment = alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override(
		"font_size",
		_readable_ui_font_size(font_size)
	)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_shadow_color", Color(0.01, 0.02, 0.04, 0.9))
	label.add_theme_constant_override("shadow_offset_x", 0)
	label.add_theme_constant_override("shadow_offset_y", 3)
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return label


func _readable_ui_font_size(font_size: int) -> int:
	if font_size <= 14:
		return UI_FONT_CAPTION
	if font_size <= 16:
		return UI_FONT_ACTION
	if font_size <= 18:
		return UI_FONT_BODY
	return font_size


func _register_ui_control(
	control: Control,
	id: String,
	label: String,
	editable_font := true
) -> void:
	if ui_layout_editor != null and control != null:
		ui_layout_editor.register_control(control, id, label, editable_font)


func _reapply_star_title_layout(slug := "") -> void:
	if ui_layout_editor == null:
		return
	for id in ["hud.title.paper", "hud.title.kicker", "hud.title.name"]:
		ui_layout_editor.reapply_saved_layout(id)
	_apply_star_title_text_layout(slug if not slug.is_empty() else current_3d_scene)


func _apply_star_title_text_layout(slug: String) -> void:
	if (
		hud_scene_title_plate == null
		or hud_scene_title == null
		or hud_scene_kicker == null
	):
		return
	var ratios: Dictionary = STAR_TITLE_LAYOUT_RATIOS.get(slug, {})
	if ratios.is_empty():
		return
	var plate_size := hud_scene_title_plate.size
	hud_scene_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	hud_scene_kicker.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	hud_scene_title.position.x = plate_size.x * float(ratios.name_x)
	hud_scene_kicker.position.x = plate_size.x * float(ratios.kicker_x)
	hud_scene_title.size.x = minf(
		hud_scene_title.size.x,
		maxf(120.0, plate_size.x - hud_scene_title.position.x - 6.0)
	)
	hud_scene_kicker.size.x = minf(
		hud_scene_kicker.size.x,
		maxf(120.0, plate_size.x - hud_scene_kicker.position.x - 6.0)
	)


func _reapply_planet_tag_layouts() -> void:
	if ui_layout_editor == null:
		return
	for data in PLANETS:
		var slug := String(data.slug)
		for part in ["tag_paper", "tag_text"]:
			ui_layout_editor.reapply_saved_layout(
				"map.planet.%s.%s" % [slug, part]
			)


func _style_button(button: Button, accent := Color(0.78, 0.65, 0.42)) -> void:
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.91, 0.86, 0.75, 0.92)
	normal.border_color = Color(accent.r * 0.62, accent.g * 0.55, accent.b * 0.48, 0.88)
	normal.set_border_width_all(1)
	normal.border_width_left = 4
	normal.set_corner_radius_all(2)
	normal.content_margin_left = 16
	normal.content_margin_right = 16
	normal.content_margin_top = 9
	normal.content_margin_bottom = 9
	normal.shadow_color = Color(0.04, 0.025, 0.015, 0.30)
	normal.shadow_size = 4
	normal.shadow_offset = Vector2(2, 3)
	var hover := normal.duplicate()
	hover.bg_color = Color(0.98, 0.90, 0.71, 0.98)
	hover.border_color = Color(0.43, 0.27, 0.15, 0.98)
	hover.shadow_size = 7
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", hover)
	button.add_theme_stylebox_override("focus", hover)
	button.add_theme_color_override("font_color", Color(0.20, 0.15, 0.11, 0.96))
	button.add_theme_color_override("font_hover_color", Color(0.24, 0.12, 0.08, 1.0))
	button.add_theme_color_override("font_pressed_color", Color(0.24, 0.12, 0.08, 1.0))
	button.add_theme_color_override("font_focus_color", Color(0.24, 0.12, 0.08, 1.0))
	button.add_theme_font_size_override("font_size", UI_FONT_BODY)
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _style_player_arc_button(
	button: Button,
	accent := Color(0.78, 0.65, 0.42)
) -> void:
	var normal := StyleBoxEmpty.new()
	var hover := StyleBoxFlat.new()
	hover.bg_color = Color(1.0, 0.94, 0.76, 0.14)
	hover.border_color = Color(
		accent.r * 0.52,
		accent.g * 0.46,
		accent.b * 0.38,
		0.52
	)
	hover.set_border_width_all(1)
	hover.set_corner_radius_all(22)
	hover.shadow_color = Color(0.98, 0.83, 0.53, 0.22)
	hover.shadow_size = 7
	var pressed := hover.duplicate()
	pressed.bg_color = Color(0.86, 0.73, 0.50, 0.22)
	pressed.shadow_size = 3
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", pressed)
	button.add_theme_stylebox_override("focus", hover)
	button.custom_minimum_size = Vector2(44.0, 44.0)
	button.size = Vector2(44.0, 44.0)
	button.expand_icon = true
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _set_player_arc_button_icon(button: Button, texture_path: String) -> bool:
	var texture := load(texture_path) as Texture2D
	if texture == null:
		push_warning("Player action icon is missing: " + texture_path)
		return false
	button.text = ""
	button.icon = texture
	button.expand_icon = true
	button.add_theme_constant_override("icon_max_width", 44)
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
	button.custom_minimum_size = Vector2(44.0, 44.0)
	button.size = Vector2(44.0, 44.0)
	return true


func _make_paper_style(
	path: String,
	texture_margin: Vector4,
	content_margin: Vector4
) -> StyleBoxTexture:
	var style := StyleBoxTexture.new()
	style.texture = load(path) as Texture2D
	style.texture_margin_left = texture_margin.x
	style.texture_margin_top = texture_margin.y
	style.texture_margin_right = texture_margin.z
	style.texture_margin_bottom = texture_margin.w
	style.content_margin_left = content_margin.x
	style.content_margin_top = content_margin.y
	style.content_margin_right = content_margin.z
	style.content_margin_bottom = content_margin.w
	return style


func _apply_paper_button_style(
	button: Button,
	path: String,
	texture_margin: Vector4,
	content_margin: Vector4,
	font_color := Color(0.30, 0.20, 0.13, 1.0)
) -> void:
	var normal := _make_paper_style(path, texture_margin, content_margin)
	var hover := normal.duplicate() as StyleBoxTexture
	hover.modulate_color = Color(1.08, 1.06, 0.98, 1.0)
	var pressed := normal.duplicate() as StyleBoxTexture
	pressed.modulate_color = Color(0.88, 0.84, 0.75, 1.0)
	var disabled := normal.duplicate() as StyleBoxTexture
	disabled.modulate_color = Color(0.62, 0.61, 0.58, 0.72)
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", pressed)
	button.add_theme_stylebox_override("focus", hover)
	button.add_theme_stylebox_override("disabled", disabled)
	button.add_theme_color_override("font_color", font_color)
	button.add_theme_color_override("font_hover_color", Color(0.22, 0.12, 0.07, 1.0))
	button.add_theme_color_override("font_pressed_color", Color(0.18, 0.10, 0.06, 1.0))
	button.add_theme_color_override("font_focus_color", Color(0.22, 0.12, 0.07, 1.0))
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _load_planet_initial_orientations() -> void:
	planet_initial_orientations.clear()
	planet_framing_offsets.clear()
	for path in [INITIAL_VIEW_PROJECT_PATH, INITIAL_VIEW_CONFIG_PATH]:
		_merge_planet_initial_orientations(path)


func _merge_planet_initial_orientations(path: String) -> void:
	if not FileAccess.file_exists(path):
		return
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	var orientations = parsed.get("orientations", {})
	if typeof(orientations) != TYPE_DICTIONARY:
		return
	for scene_key_value in orientations:
		var scene_key := String(scene_key_value)
		var values = orientations[scene_key_value]
		if scene_key.is_empty() or typeof(values) != TYPE_ARRAY or values.size() < 4:
			continue
		var orientation := Quaternion(
			float(values[0]),
			float(values[1]),
			float(values[2]),
			float(values[3])
		)
		if orientation.length_squared() <= 0.000001:
			continue
		planet_initial_orientations[scene_key] = orientation.normalized()
	var framing_offsets = parsed.get("framing_offsets", {})
	if typeof(framing_offsets) == TYPE_DICTIONARY:
		for scene_key_value in framing_offsets:
			var scene_key := String(scene_key_value)
			if scene_key.is_empty():
				continue
			planet_framing_offsets[scene_key] = clampf(
				float(framing_offsets[scene_key_value]),
				-1.6,
				1.6
			)


func _get_initial_planet_orientation(scene_key: String) -> Quaternion:
	var saved = planet_initial_orientations.get(scene_key, null)
	if saved is Quaternion:
		return saved
	if scene_key == "king":
		return Quaternion(Vector3.UP, deg_to_rad(KING_HOME_YAW_DEGREES))
	return Quaternion.IDENTITY


func _get_planet_framing_offset(scene_key: String) -> float:
	return clampf(float(planet_framing_offsets.get(scene_key, 0.0)), -1.6, 1.6)


func _set_current_orientation_as_initial_view() -> void:
	if model_3d == null or current_3d_scene.is_empty():
		return
	var scene_key := _current_layout_key()
	planet_initial_orientations[scene_key] = model_3d.quaternion.normalized()
	model_spin_velocity = Vector2.ZERO
	if not _save_planet_view_configuration():
		_editor_set_status("初始视角保存失败：%s" % error_string(FileAccess.get_open_error()))
		return
	_editor_set_status(
		"已将“%s”的当前朝向设为初始视角，并保存画面高度 %+.2f。"
		% [
			_current_planet_display_name(),
			_get_planet_framing_offset(scene_key),
		]
	)


func _nudge_planet_framing_height(amount: float) -> void:
	if model_3d == null or current_3d_scene.is_empty():
		return
	var scene_key := _current_layout_key()
	var previous_offset := _get_planet_framing_offset(scene_key)
	var next_offset := clampf(previous_offset + amount, -1.6, 1.6)
	if is_equal_approx(previous_offset, next_offset):
		_editor_set_status("画面高度已到调整上限。")
		return
	planet_framing_offsets[scene_key] = next_offset
	_shift_camera_with_planet_height(-(next_offset - previous_offset))
	_sync_planet_height_control()
	if not _save_planet_view_configuration():
		planet_framing_offsets[scene_key] = previous_offset
		_shift_camera_with_planet_height(previous_offset - next_offset)
		_sync_planet_height_control()
		_editor_set_status("画面高度保存失败：%s" % error_string(FileAccess.get_open_error()))
		return
	var direction := "上移" if amount > 0.0 else "下移"
	_editor_set_status(
		"已将“%s”%s；当前画面高度 %+.2f。"
		% [_current_planet_display_name(), direction, next_offset]
	)


func _shift_camera_with_planet_height(camera_y_shift: float) -> void:
	if camera_3d == null:
		return
	camera_focus_point.y += camera_y_shift
	camera_home_position.y += camera_y_shift
	camera_3d.position.y += camera_y_shift
	camera_3d.look_at(camera_focus_point)


func _sync_planet_height_control() -> void:
	if editor_planet_height_value == null:
		return
	var offset := _get_planet_framing_offset(_current_layout_key())
	editor_planet_height_value.text = "%+.2f" % offset


func _save_planet_view_configuration() -> bool:
	var orientation_data: Dictionary = {}
	for key_value in planet_initial_orientations:
		var orientation: Quaternion = planet_initial_orientations[key_value]
		orientation_data[String(key_value)] = [
			orientation.x,
			orientation.y,
			orientation.z,
			orientation.w,
		]
	var framing_offset_data: Dictionary = {}
	for key_value in planet_framing_offsets:
		framing_offset_data[String(key_value)] = _get_planet_framing_offset(
			String(key_value)
		)
	var payload := JSON.stringify({
		"version": 1,
		"orientations": orientation_data,
		"framing_offsets": framing_offset_data,
	}, "\t")
	var user_saved := _write_text_file(INITIAL_VIEW_CONFIG_PATH, payload)
	var project_saved := _write_text_file(INITIAL_VIEW_PROJECT_PATH, payload)
	if not user_saved and not project_saved:
		return false
	return true


func _write_text_file(path: String, content: String) -> bool:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		return false
	file.store_string(content)
	file.close()
	return true


func _current_planet_display_name() -> String:
	if current_3d_scene == "pointlighter":
		return "点灯人"
	if current_3d_scene == "king":
		return "国王"
	for planet_name_value in GENERATED_PLANET_SCENES:
		var scene_data: Dictionary = GENERATED_PLANET_SCENES[planet_name_value]
		if String(scene_data.get("slug", "")) == current_3d_scene:
			return String(planet_name_value)
	return current_3d_scene


func _build_cover() -> void:
	cover = Control.new()
	cover.name = "Cover"
	main_ui.add_child(cover)
	cover.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var backdrop := COVER_BACKDROP_SCRIPT.new()
	backdrop.name = "PaperSkyBackdrop"
	cover.add_child(backdrop)
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	cover_content = Control.new()
	cover_content.name = "CoverContent"
	cover.add_child(cover_content)
	cover_content.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var serif_font := load(WEB_FONT_PATH) as Font

	var glyphs := [
		{"text": "小", "position": Vector2(395, 295), "rotation": -1.4},
		{"text": "王", "position": Vector2(680, 288), "rotation": 0.6},
		{"text": "子", "position": Vector2(965, 300), "rotation": -0.8},
	]
	for index in 3:
		var glyph: Dictionary = glyphs[index]
		var title := _add_label(
			cover_content,
			String(glyph.text),
			glyph.position,
			Vector2(240, 240),
			190,
			Color(0.94, 0.9, 0.81)
		)
		title.rotation_degrees = float(glyph.rotation)
		title.add_theme_font_override("font", serif_font)
		title.add_theme_color_override("font_shadow_color", Color(0.28, 0.23, 0.17, 0.7))
		title.add_theme_constant_override("shadow_offset_x", 0)
		title.add_theme_constant_override("shadow_offset_y", 9)
		cover_title_labels.append(title)
	_layout_cover_title()
	for index in cover_title_labels.size():
		_register_ui_control(
			cover_title_labels[index],
			"cover.title.%d" % index,
			"封面标题 | %d" % (index + 1)
		)

	var rule_a := ColorRect.new()
	rule_a.color = Color(0.78, 0.66, 0.44, 0.3)
	rule_a.position = Vector2(660, 625)
	rule_a.size = Vector2(126, 1)
	cover_content.add_child(rule_a)
	var rule_b := ColorRect.new()
	rule_b.color = Color(0.78, 0.66, 0.44, 0.3)
	rule_b.position = Vector2(814, 625)
	rule_b.size = Vector2(126, 1)
	cover_content.add_child(rule_b)
	var diamond := ColorRect.new()
	diamond.color = Color(0.78, 0.66, 0.44, 0.68)
	diamond.position = Vector2(795, 620)
	diamond.size = Vector2(10, 10)
	diamond.rotation_degrees = 45
	cover_content.add_child(diamond)

	var subtitle := _add_label(
		cover_content,
		"L E   P E T I T   P R I N C E",
		Vector2(440, 555),
		Vector2(720, 54),
		20,
		Color(0.77, 0.67, 0.49, 0.82)
	)
	subtitle.add_theme_font_override("font", serif_font)
	_register_ui_control(subtitle, "cover.subtitle", "封面副标题")

	cover_enter_button = Button.new()
	cover_enter_button.text = "|   进入星图   |"
	cover_enter_button.position = Vector2(675, 654)
	cover_enter_button.size = Vector2(250, 80)
	_apply_paper_button_style(
		cover_enter_button,
		UI_PRIMARY_BUTTON,
		Vector4(54, 14, 54, 16),
		Vector4(38, 13, 38, 18),
		Color(0.31, 0.21, 0.14, 1.0)
	)
	cover_enter_button.add_theme_font_override("font", serif_font)
	cover_enter_button.add_theme_font_size_override("font_size", 24)
	cover_enter_button.pressed.connect(_start_passage)
	cover_content.add_child(cover_enter_button)
	_register_ui_control(cover_enter_button, "cover.enter", "进入星图按钮")

	cover_load_button = Button.new()
	cover_load_button.text = "读取进度"
	cover_load_button.position = Vector2(649, 746)
	cover_load_button.size = Vector2(142, 50)
	_apply_paper_button_style(
		cover_load_button,
		UI_CHOICE_STRIP,
		Vector4(28, 22, 28, 22),
		Vector4(18, 6, 18, 8)
	)
	cover_load_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	cover_load_button.pressed.connect(_open_load_slot_picker)
	cover_content.add_child(cover_load_button)
	_register_ui_control(cover_load_button, "cover.load", "读取进度按钮")

	cover_new_game_button = Button.new()
	cover_new_game_button.text = "新游戏"
	cover_new_game_button.position = Vector2(809, 746)
	cover_new_game_button.size = Vector2(142, 50)
	_apply_paper_button_style(
		cover_new_game_button,
		UI_CHOICE_STRIP,
		Vector4(28, 22, 28, 22),
		Vector4(18, 6, 18, 8)
	)
	cover_new_game_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	cover_new_game_button.pressed.connect(_open_new_game_confirmation)
	cover_content.add_child(cover_new_game_button)
	_register_ui_control(cover_new_game_button, "cover.new_game", "新游戏按钮")

	var cover_hint := _add_label(
		cover_content,
		"自动存档   |   读取进度会回到星盘",
		Vector2(500, 806),
		Vector2(600, 36),
		13,
		Color(0.84, 0.82, 0.76, 0.42)
	)
	_register_ui_control(cover_hint, "cover.hint", "封面操作提示")
	_build_save_slot_overlay()
	_build_new_game_confirmation()
	if ui_layout_editor != null:
		ui_layout_editor.set_scope_root("cover", cover)


func _build_save_slot_overlay() -> void:
	save_slot_overlay = Control.new()
	save_slot_overlay.name = "LoadProgressOverlay"
	save_slot_overlay.z_index = 160
	save_slot_overlay.visible = false
	save_slot_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	cover.add_child(save_slot_overlay)
	save_slot_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var shade := ColorRect.new()
	shade.color = Color(0.015, 0.025, 0.045, 0.72)
	shade.mouse_filter = Control.MOUSE_FILTER_STOP
	shade.gui_input.connect(_on_modal_shade_input.bind(save_slot_overlay))
	save_slot_overlay.add_child(shade)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	save_slot_panel = PanelContainer.new()
	save_slot_panel.name = "LoadProgressPanel"
	save_slot_panel.anchor_left = 0.5
	save_slot_panel.anchor_top = 0.5
	save_slot_panel.anchor_right = 0.5
	save_slot_panel.anchor_bottom = 0.5
	save_slot_panel.offset_left = -470.0
	save_slot_panel.offset_top = -300.0
	save_slot_panel.offset_right = 470.0
	save_slot_panel.offset_bottom = 300.0
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.055, 0.075, 0.115, 0.985)
	panel_style.border_color = Color(0.78, 0.66, 0.44, 0.82)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(14)
	panel_style.shadow_color = Color(0.0, 0.0, 0.0, 0.45)
	panel_style.shadow_size = 18
	save_slot_panel.add_theme_stylebox_override("panel", panel_style)
	save_slot_overlay.add_child(save_slot_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 42)
	margin.add_theme_constant_override("margin_top", 32)
	margin.add_theme_constant_override("margin_right", 42)
	margin.add_theme_constant_override("margin_bottom", 30)
	save_slot_panel.add_child(margin)
	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 14)
	margin.add_child(column)

	var title := Label.new()
	title.text = "读取进度"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 32)
	title.add_theme_color_override("font_color", Color(0.94, 0.89, 0.78, 1.0))
	column.add_child(title)

	var description := Label.new()
	description.text = "选择一个自动存档。读取后会直接回到星盘。"
	description.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	description.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	description.add_theme_color_override("font_color", Color(0.76, 0.73, 0.65, 0.88))
	column.add_child(description)

	save_slot_buttons.clear()
	for slot in range(1, SaveManager.SLOT_COUNT + 1):
		var slot_button := Button.new()
		slot_button.name = "AutoSaveSlot%d" % slot
		slot_button.custom_minimum_size = Vector2(0.0, 76.0)
		slot_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		slot_button.add_theme_font_size_override("font_size", UI_FONT_BODY)
		_style_button(slot_button, Color(0.78, 0.65, 0.42))
		var empty_style := StyleBoxFlat.new()
		empty_style.bg_color = Color(0.07, 0.09, 0.13, 0.88)
		empty_style.border_color = Color(0.44, 0.42, 0.36, 0.48)
		empty_style.set_border_width_all(1)
		empty_style.set_corner_radius_all(2)
		empty_style.content_margin_left = 16
		empty_style.content_margin_right = 16
		empty_style.content_margin_top = 9
		empty_style.content_margin_bottom = 9
		slot_button.add_theme_stylebox_override("disabled", empty_style)
		slot_button.add_theme_color_override(
			"font_disabled_color",
			Color(0.69, 0.66, 0.58, 0.86)
		)
		slot_button.pressed.connect(_load_auto_save_slot.bind(slot))
		column.add_child(slot_button)
		save_slot_buttons.append(slot_button)

	save_slot_status = Label.new()
	save_slot_status.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	save_slot_status.custom_minimum_size = Vector2(0.0, 28.0)
	save_slot_status.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	save_slot_status.add_theme_color_override("font_color", Color(0.96, 0.62, 0.48, 1.0))
	column.add_child(save_slot_status)

	var close_button := Button.new()
	close_button.text = "返回封面"
	close_button.custom_minimum_size = Vector2(180.0, 46.0)
	close_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	close_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	_style_button(close_button, Color(0.64, 0.55, 0.40))
	close_button.pressed.connect(_close_load_slot_picker)
	column.add_child(close_button)


func _build_new_game_confirmation() -> void:
	new_game_confirm_overlay = Control.new()
	new_game_confirm_overlay.name = "NewGameConfirmation"
	new_game_confirm_overlay.z_index = 170
	new_game_confirm_overlay.visible = false
	new_game_confirm_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	cover.add_child(new_game_confirm_overlay)
	new_game_confirm_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var shade := ColorRect.new()
	shade.color = Color(0.015, 0.025, 0.045, 0.74)
	shade.mouse_filter = Control.MOUSE_FILTER_STOP
	shade.gui_input.connect(
		_on_modal_shade_input.bind(new_game_confirm_overlay)
	)
	new_game_confirm_overlay.add_child(shade)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var panel := PanelContainer.new()
	panel.anchor_left = 0.5
	panel.anchor_top = 0.5
	panel.anchor_right = 0.5
	panel.anchor_bottom = 0.5
	panel.offset_left = -360.0
	panel.offset_top = -210.0
	panel.offset_right = 360.0
	panel.offset_bottom = 210.0
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.055, 0.075, 0.115, 0.99)
	panel_style.border_color = Color(0.78, 0.66, 0.44, 0.84)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(14)
	panel_style.shadow_color = Color(0.0, 0.0, 0.0, 0.45)
	panel_style.shadow_size = 18
	panel.add_theme_stylebox_override("panel", panel_style)
	new_game_confirm_overlay.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 42)
	margin.add_theme_constant_override("margin_top", 34)
	margin.add_theme_constant_override("margin_right", 42)
	margin.add_theme_constant_override("margin_bottom", 32)
	panel.add_child(margin)
	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 20)
	margin.add_child(column)

	var title := Label.new()
	title.text = "开始新游戏？"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 32)
	title.add_theme_color_override("font_color", Color(0.94, 0.89, 0.78, 1.0))
	column.add_child(title)

	new_game_confirm_body = Label.new()
	new_game_confirm_body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	new_game_confirm_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	new_game_confirm_body.custom_minimum_size = Vector2(0.0, 112.0)
	new_game_confirm_body.add_theme_font_size_override("font_size", UI_FONT_BODY)
	new_game_confirm_body.add_theme_color_override("font_color", Color(0.82, 0.79, 0.71, 1.0))
	new_game_confirm_body.add_theme_constant_override("line_spacing", 6)
	column.add_child(new_game_confirm_body)

	var button_row := HBoxContainer.new()
	button_row.alignment = BoxContainer.ALIGNMENT_CENTER
	button_row.add_theme_constant_override("separation", 18)
	column.add_child(button_row)

	var cancel_button := Button.new()
	cancel_button.text = "取消"
	cancel_button.custom_minimum_size = Vector2(170.0, 48.0)
	cancel_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	_style_button(cancel_button, Color(0.64, 0.55, 0.40))
	cancel_button.pressed.connect(_close_new_game_confirmation)
	button_row.add_child(cancel_button)

	var confirm_button := Button.new()
	confirm_button.text = "开始新游戏"
	confirm_button.custom_minimum_size = Vector2(190.0, 48.0)
	confirm_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	_style_button(confirm_button, Color(0.72, 0.50, 0.28))
	confirm_button.pressed.connect(_confirm_new_game)
	button_row.add_child(confirm_button)


func _on_modal_shade_input(event: InputEvent, overlay: Control) -> void:
	if (
		event is InputEventMouseButton
		and (event as InputEventMouseButton).pressed
		and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
		and overlay != null
	):
		overlay.visible = false


func _refresh_cover_session_controls() -> void:
	if cover_enter_button != null:
		cover_enter_button.text = (
			"|   继续星图   |"
			if SaveManager.active_slot_has_save()
			else "|   进入星图   |"
		)
	if cover_load_button != null:
		cover_load_button.disabled = not SaveManager.has_any_save()


func _open_load_slot_picker() -> void:
	if save_slot_overlay == null or not SaveManager.has_any_save():
		return
	AudioDirector.play_sfx("ui_soft")
	_close_new_game_confirmation()
	save_slot_status.text = ""
	_refresh_load_slot_buttons()
	save_slot_overlay.visible = true
	save_slot_overlay.modulate.a = 0.0
	var reveal := create_tween()
	reveal.tween_property(save_slot_overlay, "modulate:a", 1.0, 0.2) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _refresh_load_slot_buttons() -> void:
	var slots := SaveManager.list_slots()
	for index in save_slot_buttons.size():
		if index >= slots.size():
			continue
		var slot_data: Dictionary = slots[index]
		var meta: Dictionary = slot_data.get("meta", {})
		var button := save_slot_buttons[index]
		var exists := bool(slot_data.get("exists", false))
		var valid := bool(slot_data.get("valid", false))
		if not exists:
			button.text = "自动存档 %d     |     尚无进度" % (index + 1)
			button.disabled = true
			continue
		if not valid:
			button.text = "自动存档 %d     |     存档文件不完整" % (index + 1)
			button.disabled = true
			continue
		var active_marker := "   |   当前档位" if index + 1 == SaveManager.active_slot else ""
		button.text = "%s\n%s" % [
			_format_slot_title(index + 1, meta, active_marker),
			_format_slot_summary(meta),
		]
		button.disabled = false


func _format_slot_title(slot: int, meta: Dictionary, marker: String) -> String:
	var saved_at := String(meta.get("saved_at_text", ""))
	if saved_at.length() > 16:
		saved_at = saved_at.substr(5, 11)
	return "自动存档 %d     |     %s%s" % [slot, saved_at, marker]


func _format_slot_summary(meta: Dictionary) -> String:
	var chapter := String(meta.get("chapter", "星图探索"))
	var awake_count := int(meta.get("awake_count", 0))
	var memory_count := int(meta.get("memory_count", 0))
	return "        %s   |   已点亮 %d/6   |   星光 %d/6" % [
		chapter,
		awake_count,
		memory_count,
	]


func _close_load_slot_picker() -> void:
	if save_slot_overlay == null or not save_slot_overlay.visible:
		return
	AudioDirector.play_sfx("ui_soft")
	save_slot_overlay.visible = false
	save_slot_status.text = ""


func _load_auto_save_slot(slot: int) -> void:
	if transition_running:
		return
	var result := SaveManager.load_slot(slot)
	if not bool(result.get("ok", false)):
		save_slot_status.text = String(result.get("error", "读取失败。"))
		AudioDirector.play_sfx("ui_soft")
		return
	AudioDirector.play_sfx("ui_primary")
	save_slot_overlay.visible = false
	transition_running = true
	get_tree().reload_current_scene()


func _open_new_game_confirmation() -> void:
	if new_game_confirm_overlay == null:
		return
	AudioDirector.play_sfx("ui_soft")
	_close_load_slot_picker()
	var target_slot := SaveManager.preview_new_game_slot()
	var overwrite := SaveManager.new_game_will_overwrite(target_slot)
	var slot_message := (
		"自动存档 %d 会将最旧的进度覆盖。" % target_slot
		if overwrite
		else "新进度会写入自动存档 %d。" % target_slot
	)
	new_game_confirm_body.text = (
		"当前剧情进度会被清除。%s\n\n读取进度按钮仍会显示所有完整自动存档。"
		% slot_message
	)
	new_game_confirm_overlay.visible = true
	new_game_confirm_overlay.modulate.a = 0.0
	var reveal := create_tween()
	reveal.tween_property(new_game_confirm_overlay, "modulate:a", 1.0, 0.2) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _close_new_game_confirmation() -> void:
	if new_game_confirm_overlay == null or not new_game_confirm_overlay.visible:
		return
	AudioDirector.play_sfx("ui_soft")
	new_game_confirm_overlay.visible = false


func _confirm_new_game() -> void:
	if transition_running:
		return
	AudioDirector.play_sfx("ui_primary")
	SaveManager.start_new_game()
	new_game_confirm_overlay.visible = false
	transition_running = true
	get_tree().reload_current_scene()


func _resume_pending_session_target() -> void:
	match SaveManager.consume_resume_target():
		"map":
			_show_loaded_starmap()
		"new_game":
			_start_passage()


func _show_loaded_starmap() -> void:
	AudioDirector.play_music("main")
	_restore_planet_map_instant()
	cover.visible = false
	cover.modulate.a = 1.0
	map_screen.visible = true
	map_screen.modulate = Color.WHITE
	transition_running = false
	_show_map_prince_layer()
	if _all_memories_collected():
		if journey_finale_played:
			_reveal_player_planet_on_map()
		else:
			call_deferred("_play_final_journey_sequence")
	else:
		_apply_player_planet_map_reveal(false)


func _build_map() -> void:
	map_screen = Control.new()
	map_screen.name = "StarMap"
	map_screen.visible = false
	main_ui.add_child(map_screen)
	map_screen.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	map_zoom_root = Control.new()
	map_zoom_root.name = "SceneZoom"
	map_zoom_root.mouse_filter = Control.MOUSE_FILTER_PASS
	map_screen.add_child(map_zoom_root)
	map_zoom_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	map_backdrop = Control.new()
	map_backdrop.name = "BackdropLayer"
	map_backdrop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_zoom_root.add_child(map_backdrop)
	map_backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var backdrop := STARMAP_BACKDROP_SCRIPT.new()
	backdrop.name = "StarMapBackdrop"
	map_backdrop.add_child(backdrop)
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	map_cosmos_layer = _make_art_layer(
		map_zoom_root,
		"CosmosPaper",
		COSMOS,
		Vector2(0, -200),
		Vector2(1600, 1600),
		Color(0.82, 0.85, 0.84, 0.88)
	)
	map_cloud_far_layer = _make_art_layer(
		map_zoom_root,
		"PaperCloudsFar",
		CLOUD_FAR,
		Vector2(150, -250),
		Vector2(1600, 1600),
		Color(0.60, 0.62, 0.64, 0.86)
	)
	map_cloud_mid_layer = _make_art_layer(
		map_zoom_root,
		"PaperCloudsMid",
		CLOUD_MID,
		Vector2(-50, -420),
		Vector2(1750, 1750),
		Color(0.48, 0.51, 0.55, 0.9)
	)
	map_cloud_near_layer = _make_art_layer(
		map_zoom_root,
		"PaperCloudsNear",
		CLOUD_NEAR,
		Vector2(-180, -500),
		Vector2(1900, 1900),
		Color(0.42, 0.44, 0.48, 0.93)
	)

	var atmosphere := ColorRect.new()
	atmosphere.name = "PaperAtmosphere"
	atmosphere.color = Color(0.008, 0.018, 0.034, 0.16)
	atmosphere.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_zoom_root.add_child(atmosphere)
	atmosphere.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	map_planet_layer = Control.new()
	map_planet_layer.name = "PlanetLayer"
	map_planet_layer.mouse_filter = Control.MOUSE_FILTER_PASS
	map_zoom_root.add_child(map_planet_layer)
	map_planet_layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	map_route_layer = JOURNEY_CONSTELLATION_SCRIPT.new()
	map_route_layer.name = "JourneyConstellation"
	map_planet_layer.add_child(map_route_layer)
	map_route_layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	map_scene_label = _add_label(
		map_zoom_root,
		"星　图",
		Vector2(650, 105),
		Vector2(300, 60),
		17,
		Color(0.9, 0.88, 0.8, 0.36)
	)
	map_scene_label.add_theme_constant_override("outline_size", 0)
	_register_ui_control(map_scene_label, "map.heading", "星图页标题")

	var shader_resource := load(BLUR_SHADER) as Shader
	for index in PLANETS.size():
		_add_planet_button(PLANETS[index], index, shader_resource)
	_sync_player_planet_map_state(false)
	_refresh_journey_constellation(false)

	map_hint = _add_label(
		map_screen,
		"移动鼠标 | 点击星球 | ESC 返回封面",
		Vector2(500, 920),
		Vector2(600, 36),
		13,
		Color(0.88, 0.84, 0.74, 0.78)
	)
	map_hint.add_theme_color_override(
		"font_shadow_color",
		Color(0.01, 0.02, 0.04, 0.82)
	)
	map_hint.add_theme_constant_override("shadow_offset_y", 1)
	_register_ui_control(map_hint, "map.hint_text", "星图提示文字")
	map_back_button = FACE_ARROW_BUTTON_SCRIPT.new()
	map_back_button.set_arrow_angle(180.0)
	map_back_button.set_paper_texture(load(UI_BACK_BUTTON) as Texture2D)
	map_back_button.tooltip_text = "返回封面"
	map_back_button.position = Vector2(34, 28)
	map_back_button.size = Vector2(58, 54)
	map_back_button.pressed.connect(_return_to_cover)
	map_screen.add_child(map_back_button)
	_register_ui_control(map_back_button, "map.back", "星盘返回按钮", false)
	map_skip_button = Button.new()
	map_skip_button.name = "SkipToSeventhPlanet"
	map_skip_button.text = "跳过"
	map_skip_button.tooltip_text = "测试用：收集六枚星光并重播完整星路"
	map_skip_button.visible = SHOW_MAP_SKIP_BUTTON
	map_skip_button.disabled = not SHOW_MAP_SKIP_BUTTON
	map_skip_button.position = Vector2(108, 28)
	map_skip_button.size = Vector2(96, 54)
	map_skip_button.add_theme_font_size_override("font_size", UI_FONT_BODY)
	_style_button(map_skip_button, Color(0.72, 0.54, 0.30))
	map_skip_button.pressed.connect(_skip_to_seventh_planet)
	map_screen.add_child(map_skip_button)
	_register_ui_control(map_skip_button, "map.skip", "星盘跳过按钮")
	_build_map_onboarding()
	_build_planet_loading_ui()
	if ui_layout_editor != null:
		ui_layout_editor.set_scope_root("map", map_screen)


func _build_map_onboarding() -> void:
	map_onboarding_overlay = Control.new()
	map_onboarding_overlay.name = "MapOnboarding"
	map_onboarding_overlay.z_index = 90
	map_onboarding_overlay.visible = false
	map_onboarding_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	map_onboarding_overlay.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	map_screen.add_child(map_onboarding_overlay)

	var shade := ColorRect.new()
	shade.name = "MapOnboardingShade"
	shade.color = Color(0.012, 0.024, 0.045, 0.42)
	shade.mouse_filter = Control.MOUSE_FILTER_STOP
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	map_onboarding_overlay.add_child(shade)

	var center := CenterContainer.new()
	center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	map_onboarding_overlay.add_child(center)

	map_onboarding_panel = PanelContainer.new()
	map_onboarding_panel.name = "MapOnboardingPanel"
	map_onboarding_panel.custom_minimum_size = Vector2(540.0, 188.0)
	map_onboarding_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.96, 0.93, 0.85, 0.97)
	panel_style.border_color = Color(0.50, 0.39, 0.25, 0.72)
	panel_style.set_border_width_all(1)
	panel_style.set_corner_radius_all(3)
	panel_style.shadow_color = Color(0.01, 0.015, 0.025, 0.30)
	panel_style.shadow_size = 9
	panel_style.shadow_offset = Vector2(0.0, 4.0)
	map_onboarding_panel.add_theme_stylebox_override("panel", panel_style)
	center.add_child(map_onboarding_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 34)
	margin.add_theme_constant_override("margin_right", 34)
	margin.add_theme_constant_override("margin_top", 20)
	margin.add_theme_constant_override("margin_bottom", 20)
	map_onboarding_panel.add_child(margin)

	var column := VBoxContainer.new()
	column.alignment = BoxContainer.ALIGNMENT_CENTER
	column.add_theme_constant_override("separation", 7)
	margin.add_child(column)

	var title := _add_label(
		column,
		"星图",
		Vector2.ZERO,
		Vector2(472.0, 34.0),
		24,
		Color(0.24, 0.16, 0.09, 1.0),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	title.name = "MapOnboardingTitle"
	title.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	title.add_theme_constant_override("line_spacing", 2)

	var body := _add_label(
		column,
		"移动鼠标让纸云散开，点击一颗星球出发。",
		Vector2.ZERO,
		Vector2(472.0, 30.0),
		17,
		Color(0.29, 0.21, 0.14, 0.96),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	body.name = "MapOnboardingBody"
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	body.add_theme_constant_override("line_spacing", 2)

	var note := _add_label(
		column,
		"编号只是路标，不必按顺序。",
		Vector2.ZERO,
		Vector2(472.0, 24.0),
		14,
		Color(0.43, 0.34, 0.25, 0.82),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	note.name = "MapOnboardingNote"
	note.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	note.add_theme_constant_override("line_spacing", 2)

	var button_row := HBoxContainer.new()
	button_row.alignment = BoxContainer.ALIGNMENT_CENTER
	column.add_child(button_row)

	map_onboarding_button = Button.new()
	map_onboarding_button.name = "MapOnboardingButton"
	map_onboarding_button.text = "知道了"
	map_onboarding_button.custom_minimum_size = Vector2(160.0, 40.0)
	_style_button(map_onboarding_button, Color(0.62, 0.49, 0.31))
	map_onboarding_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	map_onboarding_button.pressed.connect(_complete_map_onboarding)
	button_row.add_child(map_onboarding_button)


func _show_map_onboarding_if_needed() -> void:
	if (
		map_onboarding_triggered
		or preview_mode_active
		or map_onboarding_overlay == null
		or map_screen == null
		or not map_screen.visible
	):
		return
	_mark_map_onboarding_triggered()
	map_onboarding_overlay.visible = true
	map_onboarding_overlay.modulate.a = 0.0
	var reveal := create_tween()
	reveal.tween_property(
		map_onboarding_overlay,
		"modulate:a",
		1.0,
		0.28
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if map_onboarding_button != null:
		map_onboarding_button.grab_focus()


func _complete_map_onboarding() -> void:
	if map_onboarding_overlay == null:
		return
	AudioDirector.play_sfx("ui_soft")
	map_onboarding_completed = true
	var fade := create_tween()
	fade.tween_property(
		map_onboarding_overlay,
		"modulate:a",
		0.0,
		0.22
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await fade.finished
	if map_onboarding_overlay != null:
		map_onboarding_overlay.visible = false
		map_onboarding_overlay.modulate.a = 1.0
	_begin_map_hint_cycle()


func _begin_map_hint_cycle() -> void:
	if map_hint == null or MAP_IDLE_HINTS.is_empty():
		return
	map_hint_cycle_index = 0
	map_hint_cycle_elapsed = 0.0
	map_hint.text = String(MAP_IDLE_HINTS[0])
	map_hint.modulate.a = 1.0


func _update_map_hint_cycle(delta: float) -> void:
	if (
		map_screen == null
		or not map_screen.visible
		or transition_running
		or planet_zoom_active
		or (stage_3d != null and stage_3d.visible)
		or (detail_screen != null and detail_screen.visible)
		or (map_onboarding_overlay != null and map_onboarding_overlay.visible)
		or _all_memories_collected()
		or map_hint == null
	):
		return
	map_hint_cycle_elapsed += delta
	if map_hint_cycle_elapsed < STORY_HINT_CYCLE_SECONDS:
		return
	map_hint_cycle_elapsed = 0.0
	map_hint_cycle_index = (
		(map_hint_cycle_index + 1) % MAP_IDLE_HINTS.size()
	)
	_set_map_hint_animated(String(MAP_IDLE_HINTS[map_hint_cycle_index]))


func _set_map_hint_animated(text: String) -> void:
	if map_hint == null or map_hint.text == text:
		return
	if map_hint_cycle_tween != null and map_hint_cycle_tween.is_valid():
		map_hint_cycle_tween.kill()
	map_hint_cycle_tween = create_tween()
	map_hint_cycle_tween.tween_property(
		map_hint,
		"modulate:a",
		0.0,
		0.18
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	map_hint_cycle_tween.tween_callback(
		func() -> void:
			if map_hint != null:
				map_hint.text = text
	)
	map_hint_cycle_tween.tween_property(
		map_hint,
		"modulate:a",
		1.0,
		0.24
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _build_planet_loading_ui() -> void:
	map_loading_overlay = Control.new()
	map_loading_overlay.name = "PlanetLoading"
	map_loading_overlay.visible = false
	map_loading_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	map_loading_overlay.z_index = 50
	map_screen.add_child(map_loading_overlay)
	map_loading_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var dim := ColorRect.new()
	dim.color = Color(0.008, 0.016, 0.032, 0.20)
	dim.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_loading_overlay.add_child(dim)
	dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	map_loading_flyer = TextureRect.new()
	map_loading_flyer.name = "PrinceAndBirds"
	map_loading_flyer.texture = load(PRINCE_FLIGHT)
	map_loading_flyer.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	map_loading_flyer.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	map_loading_flyer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_loading_flyer.size = Vector2(460, 460)
	map_loading_flyer.pivot_offset = map_loading_flyer.size * 0.5
	map_loading_overlay.add_child(map_loading_flyer)

	map_loading_progress = ProgressBar.new()
	map_loading_progress.name = "LoadingProgress"
	map_loading_progress.position = Vector2(500, 790)
	map_loading_progress.size = Vector2(600, 16)
	map_loading_progress.min_value = 0.0
	map_loading_progress.max_value = 100.0
	map_loading_progress.value = 0.0
	map_loading_progress.show_percentage = false
	map_loading_progress.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var background := StyleBoxFlat.new()
	background.bg_color = Color(0.025, 0.045, 0.07, 0.82)
	background.border_color = Color(0.82, 0.70, 0.47, 0.42)
	background.set_border_width_all(1)
	background.set_corner_radius_all(8)
	var fill := StyleBoxFlat.new()
	fill.bg_color = Color(0.94, 0.70, 0.30, 0.92)
	fill.shadow_color = Color(1.0, 0.62, 0.20, 0.42)
	fill.shadow_size = 9
	fill.set_corner_radius_all(8)
	map_loading_progress.add_theme_stylebox_override("background", background)
	map_loading_progress.add_theme_stylebox_override("fill", fill)
	map_loading_overlay.add_child(map_loading_progress)


func _make_art_layer(
	parent: Control,
	layer_name: String,
	texture_path: String,
	texture_position: Vector2,
	texture_size: Vector2,
	tint: Color
) -> Control:
	var layer := Control.new()
	layer.name = layer_name
	layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(layer)
	layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var art := TextureRect.new()
	art.texture = load(texture_path)
	art.position = texture_position
	art.size = texture_size
	art.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	art.modulate = tint
	art.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(art)
	return layer


func _add_planet_button(data: Dictionary, index: int, shader_resource: Shader) -> void:
	var holder_size := Vector2(320, 340)
	var holder := Control.new()
	holder.name = "Planet_" + String(data.slug)
	holder.position = data.center - holder_size * 0.5
	holder.size = holder_size
	holder.pivot_offset = holder_size * 0.5
	holder.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# The planet illustration is presentation-only in UI edit mode. Locking
	# the whole artwork subtree keeps its large bounds from stealing clicks
	# from the independently editable planet-number labels.
	holder.set_meta("ui_layout_locked", true)
	map_planet_layer.add_child(holder)

	var art_group := Control.new()
	art_group.name = "PlanetArtwork"
	art_group.size = holder_size
	art_group.pivot_offset = holder_size * 0.5
	art_group.mouse_filter = Control.MOUSE_FILTER_PASS
	holder.add_child(art_group)

	var button := TextureButton.new()
	button.name = "Button"
	button.position = (holder_size - data.size) * 0.5
	button.size = data.size
	button.ignore_texture_size = true
	button.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.tooltip_text = String(data.name)
	button.focus_mode = Control.FOCUS_ALL
	button.pivot_offset = data.size * 0.5
	art_group.add_child(button)

	var dormant_texture := load("res://assets/planets/%s-dormant.png" % data.slug) as Texture2D
	var awake_texture := load("res://assets/planets/%s-awake.png" % data.slug) as Texture2D
	var material := ShaderMaterial.new()
	material.shader = shader_resource
	material.set_shader_parameter("blur_pixels", 2.25)
	material.set_shader_parameter("brightness", float(data.brightness))
	button.material = material

	var awake_view := TextureRect.new()
	awake_view.name = "AwakeArtwork"
	awake_view.position = button.position
	awake_view.size = data.size
	awake_view.texture = awake_texture
	awake_view.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	awake_view.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	awake_view.mouse_filter = Control.MOUSE_FILTER_IGNORE
	awake_view.modulate.a = 0.0
	art_group.add_child(awake_view)

	var focus_ring := TextureRect.new()
	focus_ring.name = "PaperFocusRing"
	focus_ring.texture = load(UI_FOCUS_RING)
	focus_ring.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	focus_ring.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	focus_ring.custom_minimum_size = Vector2.ZERO
	focus_ring.position = Vector2(10, 20)
	focus_ring.size = Vector2(300, 300)
	focus_ring.modulate.a = 0.0
	focus_ring.visible = false
	focus_ring.mouse_filter = Control.MOUSE_FILTER_IGNORE
	art_group.add_child(focus_ring)

	var tag_y: float = holder_size.y * 0.5 + float(data.size.y) * 0.5 + 6.0
	var tag_frame := TextureRect.new()
	tag_frame.name = "PlanetNumberPaper"
	tag_frame.texture = load(UI_PLANET_TAG)
	tag_frame.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	tag_frame.custom_minimum_size = Vector2.ZERO
	tag_frame.position = Vector2((holder_size.x - 86.0) * 0.5, tag_y)
	tag_frame.size = Vector2(86, 28)
	tag_frame.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	tag_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	holder.add_child(tag_frame)
	_register_ui_control(
		tag_frame,
		"map.planet.%s.tag_paper" % String(data.slug),
		"%s | 星球编号底板" % String(data.name),
		false
	)
	var label := _add_label(
		holder,
		String(data.id),
		Vector2((holder_size.x - 86.0) * 0.5, tag_y + 3.0),
		Vector2(86, 22),
		13,
		Color(0.34, 0.23, 0.14, 0.9)
	)
	label.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	_register_ui_control(
		label,
		"map.planet.%s.tag_text" % String(data.slug),
		"%s | 星球编号文字" % String(data.name)
	)

	planet_records[String(data.name)] = {
		"holder": holder,
		"button": button,
		"art_group": art_group,
		"awake_view": awake_view,
		"focus_ring": focus_ring,
		"label": label,
		"tag_frame": tag_frame,
		"material": material,
		"dormant": dormant_texture,
		"awake": awake_texture,
		"data": data,
		"base_brightness": float(data.brightness),
		"fixed_position": holder.position,
	}
	if bool(data.get("hidden_until_memories", false)):
		holder.visible = true
		holder.modulate.a = 1.0
		button.disabled = true

	button.texture_normal = dormant_texture
	button.texture_hover = dormant_texture
	button.texture_pressed = dormant_texture
	button.texture_focused = dormant_texture
	button.pressed.connect(_on_planet_pressed.bind(String(data.name)))
	button.mouse_entered.connect(_set_planet_hover.bind(String(data.name), true))
	button.mouse_exited.connect(_set_planet_hover.bind(String(data.name), false))

	var tween := create_tween().set_loops()
	var duration := 2.0 + float(index % 3) * 0.27
	var lift := 6.0 + float(index % 2) * 2.0
	tween.tween_property(holder, "position:y", holder.position.y - lift, duration) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(holder, "position:y", holder.position.y, duration) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	if bool(awake_planets.get(String(data.name), false)):
		_apply_awake_visual(String(data.name), false, false)


func _set_planet_hover(name: String, hovered: bool) -> void:
	if planet_zoom_active or not planet_records.has(name):
		return
	var record: Dictionary = planet_records[name]
	if not (record.holder as Control).visible or (record.button as BaseButton).disabled:
		return
	if map_route_layer != null:
		map_route_layer.call(
			"set_hovered_planet",
			_journey_slug_for_planet_name(name) if hovered else ""
		)
	var art_group := record.art_group as Control
	if record.has("hover_tween"):
		var previous := record.hover_tween as Tween
		if previous != null and previous.is_valid():
			previous.kill()

	var tween := create_tween().set_parallel(true)
	record["hover_tween"] = tween
	var target_scale := Vector2.ONE * (1.055 if hovered else 1.0)
	tween.tween_property(art_group, "scale", target_scale, 0.2) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var focus_ring := record.focus_ring as TextureRect
	if hovered:
		focus_ring.visible = true
	tween.tween_property(focus_ring, "modulate:a", 0.92 if hovered else 0.0, 0.18) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if not hovered:
		tween.chain().tween_callback(
			func() -> void:
				if not planet_zoom_active:
					focus_ring.visible = false
		)

	var button := record.button as TextureButton
	var material := button.material as ShaderMaterial
	if material != null:
		var base_brightness := float(record.base_brightness)
		var current_blur := float(material.get_shader_parameter("blur_pixels"))
		var current_brightness := float(material.get_shader_parameter("brightness"))
		tween.tween_method(
			_set_shader_float.bind(material, "blur_pixels"),
			current_blur,
			0.8 if hovered else 2.25,
			0.2
		)
		tween.tween_method(
			_set_shader_float.bind(material, "brightness"),
			current_brightness,
			base_brightness * 1.18 if hovered else base_brightness,
			0.2
		)

	var label := record.label as Label
	if hovered:
		label.add_theme_color_override("font_color", Color(0.55, 0.34, 0.12, 1.0))
	elif bool(awake_planets.get(name, false)):
		label.add_theme_color_override("font_color", Color(0.47, 0.32, 0.16, 0.94))
	else:
		label.add_theme_color_override("font_color", Color(0.34, 0.23, 0.14, 0.9))


func _set_shader_float(value: float, material: ShaderMaterial, parameter: String) -> void:
	material.set_shader_parameter(parameter, value)


func _build_passage() -> void:
	passage = Control.new()
	passage.name = "BookPassage"
	passage.visible = false
	passage.mouse_filter = Control.MOUSE_FILTER_STOP
	main_ui.add_child(passage)
	passage.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	passage_glow = ColorRect.new()
	passage_glow.color = Color(0.95, 0.82, 0.55, 0.025)
	passage_glow.mouse_filter = Control.MOUSE_FILTER_IGNORE
	passage.add_child(passage_glow)
	passage_glow.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	passage_edge = _add_background(passage, BOOK_EDGE, Color(1, 1, 1, 0.5))
	passage_prince_below = _make_flight_prince()
	passage_prince_below.modulate.a = 0.0
	passage.add_child(passage_prince_below)

	passage_page = TextureRect.new()
	passage_page.texture = load(BOOK_PAGE)
	passage_page.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	passage_page.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	passage_page.mouse_filter = Control.MOUSE_FILTER_IGNORE
	passage.add_child(passage_page)
	passage_page.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	passage_prince_above = _make_flight_prince()
	passage.add_child(passage_prince_above)
	_layout_passage_prince()

func _make_flight_prince() -> TextureRect:
	var prince := TextureRect.new()
	prince.texture = load(PRINCE_FLIGHT)
	prince.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	prince.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	prince.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return prince


func _layout_passage_prince() -> void:
	if main_ui == null:
		return
	var view_size := main_ui.size
	if view_size.x <= 0.0 or view_size.y <= 0.0:
		view_size = get_viewport().get_visible_rect().size
	var box_width := view_size.x * PRINCE_WIDTH_RATIO
	var box_height := minf(box_width, view_size.y * PRINCE_MAX_HEIGHT_RATIO)
	passage_prince_base_size = Vector2(box_width, box_height)
	passage_prince_base_position = Vector2(
		view_size.x * PRINCE_LEFT_RATIO,
		view_size.y * (1.0 - PRINCE_BOTTOM_RATIO) - box_height
	)
	for prince in [passage_prince_above, passage_prince_below]:
		if prince == null:
			continue
		prince.size = passage_prince_base_size
		prince.pivot_offset = passage_prince_base_size * PRINCE_PIVOT_RATIO
	passage_page.pivot_offset = view_size * 0.5


func _layout_cover_title() -> void:
	if cover_title_labels.is_empty():
		return
	var view_width := main_ui.size.x
	if view_width <= 0.0:
		view_width = get_viewport().get_visible_rect().size.x
	var group_center := view_width * 0.5
	for index in cover_title_labels.size():
		var title := cover_title_labels[index]
		title.position.x = group_center - title.size.x * 0.5 + (index - 1) * 285.0
		_register_ui_control(
			title,
			"cover.title.%d" % index,
			"封面标题 | %d" % (index + 1)
		)


func _set_passage_prince_base(prince: TextureRect) -> void:
	if prince == null:
		return
	prince.position = passage_prince_base_position
	prince.size = passage_prince_base_size
	prince.pivot_offset = passage_prince_base_size * PRINCE_PIVOT_RATIO


func _show_map_prince_layer() -> void:
	if (
		map_screen == null
		or not map_screen.visible
		or passage == null
		or passage_prince_below == null
	):
		return
	passage.visible = true
	passage.mouse_filter = Control.MOUSE_FILTER_IGNORE
	passage_page.visible = false
	passage_edge.modulate.a = 0.52
	passage_glow.modulate.a = 0.0
	passage_prince_above.modulate.a = 0.0
	_layout_passage_prince()
	_set_passage_prince_base(passage_prince_below)
	passage_prince_below.position = (
		passage_prince_base_position
		+ passage_prince_map_offset_ratio * main_ui.size
	)
	passage_prince_below.scale = Vector2.ONE * passage_prince_map_scale
	passage_prince_below.rotation = deg_to_rad(-0.8)
	passage_prince_below.modulate.a = 1.0


func _on_viewport_size_changed() -> void:
	_reset_pointer_interactions()
	_layout_passage_prince()
	_layout_cover_title()
	if transition_running or passage == null or not passage.visible:
		return
	if passage_prince_above != null:
		_set_passage_prince_base(passage_prince_above)
	if passage_prince_below != null:
		_set_passage_prince_base(passage_prince_below)
		passage_prince_below.position = (
			passage_prince_base_position
			+ passage_prince_map_offset_ratio * main_ui.size
		)
		passage_prince_below.scale = Vector2.ONE * passage_prince_map_scale * 0.96
		passage_prince_below.rotation = deg_to_rad(-0.8)


func _start_passage() -> void:
	if transition_running:
		return
	AudioDirector.play_sfx("ui_primary")
	transition_running = true
	map_screen.visible = true
	map_screen.modulate = Color(1, 1, 1, 0.18)
	passage.visible = true
	passage.mouse_filter = Control.MOUSE_FILTER_STOP
	passage.modulate.a = 0.0
	passage_glow.modulate.a = 1.0
	passage_page.visible = true
	passage_page.modulate.a = 1.0
	passage_page.scale = Vector2(1.06, 1.06)
	passage_edge.modulate.a = 0.5
	_layout_passage_prince()
	passage_settled_elapsed = 0.0
	_set_passage_prince_base(passage_prince_above)
	passage_prince_above.modulate.a = 1.0
	passage_prince_above.scale = Vector2(1.0, 1.0)
	passage_prince_above.rotation = deg_to_rad(-1.2)
	_set_passage_prince_base(passage_prince_below)
	passage_prince_below.modulate.a = 0.0
	passage_prince_below.scale = Vector2(1.0, 1.0)
	passage_prince_below.rotation = deg_to_rad(-1.2)
	var burst_position := passage_prince_base_position + Vector2(
		main_ui.size.x * PRINCE_BURST_OFFSET_RATIO.x,
		main_ui.size.y * PRINCE_BURST_OFFSET_RATIO.y
	)
	var return_position := passage_prince_base_position + Vector2(
		main_ui.size.x * PRINCE_RETURN_OFFSET_RATIO.x,
		main_ui.size.y * PRINCE_RETURN_OFFSET_RATIO.y
	)
	var intro := create_tween().set_parallel(true)
	intro.tween_property(passage, "modulate:a", 1.0, 0.36)
	intro.tween_property(cover, "modulate:a", 0.0, 0.42)
	intro.tween_property(passage_prince_above, "position", burst_position, 1.05) \
		.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	intro.tween_property(passage_prince_above, "scale", Vector2.ONE * 0.76, 1.05) \
		.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	intro.tween_property(passage_prince_above, "rotation", deg_to_rad(0.3), 1.05) \
		.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	await intro.finished
	cover.visible = false
	passage_prince_below.position = passage_prince_above.position
	passage_prince_below.scale = passage_prince_above.scale
	passage_prince_below.rotation = passage_prince_above.rotation
	var handoff := create_tween().set_parallel(true)
	handoff.tween_property(passage_prince_above, "modulate:a", 0.0, 0.24)
	handoff.tween_property(passage_prince_below, "modulate:a", 1.0, 0.24)
	await handoff.finished
	await get_tree().create_timer(0.28).timeout
	var dissolve := create_tween().set_parallel(true)
	dissolve.tween_property(passage_page, "scale", Vector2(1.42, 1.42), 1.25) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	dissolve.tween_property(passage_page, "modulate:a", 0.0, 0.92).set_delay(0.32)
	dissolve.tween_property(map_screen, "modulate:a", 1.0, 1.0).set_delay(0.1)
	dissolve.tween_property(passage_glow, "modulate:a", 0.0, 0.7)
	var prince_return := create_tween().set_parallel(true)
	prince_return.tween_property(passage_prince_below, "position", return_position, 0.5) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	prince_return.tween_property(passage_prince_below, "scale", Vector2.ONE * 0.84, 0.5) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	prince_return.tween_property(passage_prince_below, "rotation", deg_to_rad(0.1), 0.5) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	prince_return.chain().tween_property(passage_prince_below, "position", passage_prince_base_position, 0.65) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	prince_return.parallel().tween_property(passage_prince_below, "scale", Vector2.ONE * 0.96, 0.65) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	prince_return.parallel().tween_property(passage_prince_below, "rotation", deg_to_rad(-0.8), 0.65) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await dissolve.finished
	cover.visible = false
	passage_page.visible = false
	passage_edge.modulate.a = 0.52
	passage_glow.modulate.a = 0.0
	passage.modulate.a = 1.0
	passage.mouse_filter = Control.MOUSE_FILTER_IGNORE
	passage_prince_above.modulate.a = 0.0
	passage_prince_below.modulate.a = 1.0
	_set_passage_prince_base(passage_prince_below)
	passage_prince_below.scale = Vector2.ONE * 0.96
	passage_prince_below.rotation = deg_to_rad(-0.8)
	passage_settled_elapsed = 0.0
	cover.modulate.a = 1.0
	transition_running = false
	if not map_onboarding_triggered:
		call_deferred("_show_map_onboarding_if_needed")


func _build_detail() -> void:
	detail_screen = Control.new()
	detail_screen.name = "PlanetDetail"
	detail_screen.visible = false
	detail_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	main_ui.add_child(detail_screen)
	detail_screen.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var shade := ColorRect.new()
	shade.color = Color(0.015, 0.025, 0.05, 0.67)
	shade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	detail_screen.add_child(shade)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var panel := NinePatchRect.new()
	panel.texture = load(UI_PLANET_DETAIL_CARD)
	panel.position = Vector2(205, 690)
	panel.size = Vector2(1190, 235)
	panel.patch_margin_left = 72
	panel.patch_margin_right = 70
	panel.patch_margin_top = 52
	panel.patch_margin_bottom = 48
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	detail_screen.add_child(panel)
	_register_ui_control(
		panel,
		"map.detail.paper",
		"星球详情底板",
		false
	)

	detail_name = _add_label(
		detail_screen,
		"",
		Vector2(334, 728),
		Vector2(920, 44),
		22,
		Color(0.30, 0.19, 0.11, 1.0),
		HORIZONTAL_ALIGNMENT_LEFT
	)
	detail_name.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	_register_ui_control(detail_name, "map.detail.title", "星球详情标题")
	detail_text = _add_label(
		detail_screen,
		"",
		Vector2(334, 780),
		Vector2(900, 72),
		28,
		Color(0.14, 0.11, 0.08, 1.0),
		HORIZONTAL_ALIGNMENT_LEFT
	)
	detail_text.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	detail_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_register_ui_control(detail_text, "map.detail.text", "星球详情正文")

	detail_back_button = FACE_ARROW_BUTTON_SCRIPT.new()
	detail_back_button.set_arrow_angle(180.0)
	detail_back_button.set_paper_texture(load(UI_BACK_BUTTON) as Texture2D)
	detail_back_button.tooltip_text = "返回星图"
	detail_back_button.position = Vector2(1386, 820)
	detail_back_button.size = Vector2(58, 56)
	detail_back_button.pressed.connect(_exit_planet_detail)
	detail_screen.add_child(detail_back_button)
	_register_ui_control(
		detail_back_button,
		"map.detail.back",
		"详情返回按钮",
		false
	)


func _on_planet_pressed(name: String) -> void:
	if transition_running or planet_zoom_active or not planet_records.has(name):
		return
	var pressed_record: Dictionary = planet_records[name]
	if (
		not (pressed_record.holder as Control).visible
		or (pressed_record.button as BaseButton).disabled
	):
		return
	AudioDirector.play_sfx("ui_primary")
	planet_zoom_request += 1
	var request_id := planet_zoom_request
	if not _begin_planet_zoom(name):
		return
	_apply_awake_visual(name, true, true)
	var generated_scene: Dictionary = GENERATED_PLANET_SCENES.get(name, {})
	var generated_slug := String(generated_scene.get("slug", ""))
	var needs_generated_load := (
		not generated_slug.is_empty()
		and not generated_planet_models.has(generated_slug)
	)
	var needs_pointlighter_load := (
		name == "点灯人"
		and pointlighter_model_3d == null
	)
	_start_planet_loading(
		name,
		request_id,
		(name == "国王" and king_model_3d == null)
			or needs_generated_load
			or needs_pointlighter_load
	)
	if name == "点灯人":
		if needs_pointlighter_load:
			if not pointlighter_model_loading:
				call_deferred("_load_pointlighter_model")
			await get_tree().process_frame
			while pointlighter_model_loading and not pointlighter_model_ready:
				await get_tree().process_frame
		_set_planet_loading_progress(100.0)
		await get_tree().create_timer(0.68).timeout
		if _is_planet_zoom_current(name, request_id):
			await _wait_for_simulated_planet_loading(request_id)
		if _is_planet_zoom_current(name, request_id):
			_show_pointlighter_3d()
			_finish_planet_loading()
		return
	if name == "国王":
		await get_tree().create_timer(0.68).timeout
		if _is_planet_zoom_current(name, request_id):
			await _show_king_3d()
		return
	if not generated_slug.is_empty():
		await get_tree().create_timer(0.68).timeout
		if _is_planet_zoom_current(name, request_id):
			await _show_generated_planet_3d(name, request_id)
		return
	var record: Dictionary = planet_records[name]
	var data: Dictionary = record.data
	detail_name.text = "星球 | %s | %s" % [data.id, data.name]
	detail_text.text = String(data.text)
	await _wait_for_simulated_planet_loading(request_id)
	if not _is_planet_zoom_current(name, request_id):
		return
	_finish_planet_loading()
	detail_screen.visible = true
	detail_screen.modulate.a = 0.0
	var reveal := create_tween()
	reveal.tween_property(detail_screen, "modulate:a", 1.0, 0.34) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	detail_back_button.grab_focus()


func _start_planet_loading(name: String, request_id: int, actual_loading: bool) -> void:
	if map_loading_overlay == null or map_loading_flyer == null:
		return
	planet_loading_generation = request_id
	planet_loading_name = name
	map_loading_overlay.visible = true
	map_loading_overlay.modulate.a = 1.0
	map_loading_progress.value = 0.0
	if passage_prince_above != null:
		passage_prince_above.visible = false
	if passage_prince_below != null:
		passage_prince_below.visible = false
	if planet_loading_fly_tween != null and planet_loading_fly_tween.is_valid():
		planet_loading_fly_tween.kill()
	var target_center := Vector2(950, 460)
	if name == "国王":
		target_center = Vector2(800, 470)
	elif name == "点灯人":
		target_center = Vector2(800, 500)
	elif name == PLAYER_PLANET_NAME:
		target_center = Vector2(800, 500)
	map_loading_flyer.size = Vector2(460, 460)
	map_loading_flyer.pivot_offset = map_loading_flyer.size * 0.5
	map_loading_flyer.position = Vector2(-390, 520)
	map_loading_flyer.scale = Vector2(0.78, 0.78)
	map_loading_flyer.rotation = deg_to_rad(-8.0)
	map_loading_flyer.modulate = Color(1.0, 0.94, 0.78, 0.0)
	planet_loading_fly_tween = create_tween().set_parallel(true)
	planet_loading_fly_tween.tween_property(
		map_loading_flyer,
		"position",
		target_center + Vector2(-250, -205),
		1.15
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	planet_loading_fly_tween.tween_property(
		map_loading_flyer,
		"scale",
		Vector2(0.48, 0.48),
		1.15
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	planet_loading_fly_tween.tween_property(
		map_loading_flyer,
		"rotation",
		deg_to_rad(7.0),
		1.15
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	planet_loading_fly_tween.tween_property(
		map_loading_flyer,
		"modulate:a",
		1.0,
		0.24
	)
	planet_loading_fly_tween.chain().tween_callback(_start_loading_flyer_bob)
	if not actual_loading:
		var progress_tween := create_tween()
		progress_tween.tween_property(map_loading_progress, "value", 100.0, 1.65) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)


func _start_loading_flyer_bob() -> void:
	if map_loading_overlay == null or not map_loading_overlay.visible:
		return
	var base_position := map_loading_flyer.position
	planet_loading_fly_tween = create_tween().set_loops()
	planet_loading_fly_tween.tween_property(
		map_loading_flyer,
		"position:y",
		base_position.y - 13.0,
		0.82
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	planet_loading_fly_tween.tween_property(
		map_loading_flyer,
		"position:y",
		base_position.y,
		0.82
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _wait_for_simulated_planet_loading(request_id: int) -> void:
	while map_loading_progress != null and map_loading_progress.value < 99.5:
		if planet_loading_generation != request_id or not planet_zoom_active:
			return
		await get_tree().process_frame


func _set_planet_loading_progress(progress: float) -> void:
	if map_loading_progress == null:
		return
	map_loading_progress.value = clampf(progress, 0.0, 100.0)


func _finish_planet_loading() -> void:
	if map_loading_overlay != null:
		map_loading_overlay.visible = false
	if passage_prince_above != null:
		passage_prince_above.visible = true
	if passage_prince_below != null:
		passage_prince_below.visible = true
	planet_loading_name = ""
	if planet_loading_fly_tween != null and planet_loading_fly_tween.is_valid():
		planet_loading_fly_tween.kill()


func _request_king_asset_loading() -> void:
	if king_loading_requested or king_loading_failed:
		return
	for path in KING_ASSET_PATHS:
		var error := ResourceLoader.load_threaded_request(path, "PackedScene", true)
		if error != OK and error != ERR_BUSY:
			king_loading_failed = true
			push_warning("Failed to request king asset: %s (%s)" % [path, error_string(error)])
			return
	king_loading_requested = true


func _wait_for_king_assets(request_id: int) -> bool:
	_request_king_asset_loading()
	if king_loading_failed:
		return false
	while true:
		if request_id > 0 and planet_loading_generation != request_id:
			return false
		if request_id > 0 and not planet_zoom_active:
			return false
		var total_progress := 0.0
		var all_loaded := true
		for path in KING_ASSET_PATHS:
			var progress: Array = []
			var status := ResourceLoader.load_threaded_get_status(path, progress)
			if status == ResourceLoader.THREAD_LOAD_LOADED:
				total_progress += 1.0
			elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				all_loaded = false
				if not progress.is_empty():
					total_progress += clampf(float(progress[0]), 0.0, 1.0)
			else:
				king_loading_failed = true
				push_warning("King asset loading failed: " + path)
				return false
		_set_planet_loading_progress(
			total_progress / float(KING_ASSET_PATHS.size()) * 90.0
		)
		if all_loaded:
			for path in KING_ASSET_PATHS:
				var resource := ResourceLoader.load_threaded_get(path)
				if resource == null:
					king_loading_failed = true
					return false
			_set_planet_loading_progress(94.0)
			return true
		await get_tree().process_frame
	return false


func _begin_planet_zoom(name: String) -> bool:
	if planet_zoom_active or not planet_records.has(name) or map_zoom_root == null:
		return false
	_restore_map_ui_clean_mode()
	planet_zoom_active = true
	planet_zoom_returning = false
	active_planet_name = name
	detail_screen.visible = false
	var record: Dictionary = planet_records[name]
	var data: Dictionary = record.data
	var selected_center: Vector2 = data.center
	var target_center := Vector2(950, 460)
	var camera_scale := 2.0
	var focus_override := 0.0
	if name == "点灯人":
		target_center = Vector2(800, 500)
		camera_scale = 2.15
		focus_override = 3.0
	elif name == "国王":
		target_center = Vector2(800, 470)
		camera_scale = 2.15
		focus_override = 3.0
	elif name == PLAYER_PLANET_NAME:
		target_center = Vector2(800, 500)
		camera_scale = 2.15
		focus_override = 3.0
	var focus_scale := focus_override
	if focus_scale <= 0.0:
		focus_scale = minf(
			3.4,
			maxf(1.05, 240.0 / (float(data.radius) * camera_scale))
		)

	_kill_planet_zoom_tween()
	for planet_name in planet_records:
		var other: Dictionary = planet_records[planet_name]
		if other.has("hover_tween"):
			var hover_tween := other.hover_tween as Tween
			if hover_tween != null and hover_tween.is_valid():
				hover_tween.kill()
		var art_group := other.art_group as Control
		art_group.scale = Vector2.ONE
		var holder := other.holder as Control
		holder.scale = Vector2.ONE
		holder.modulate = Color.WHITE
		var focus_ring := other.focus_ring as TextureRect
		focus_ring.visible = false
		focus_ring.modulate.a = 0.0
		var label := other.label as Label
		label.modulate.a = 1.0

	map_zoom_root.position = Vector2.ZERO
	map_zoom_root.scale = Vector2.ONE
	map_zoom_root.pivot_offset = selected_center
	if map_route_layer != null:
		map_route_layer.call("set_hovered_planet", "")
		map_route_layer.modulate.a = 1.0
	map_hint.modulate.a = 1.0
	map_back_button.disabled = true
	if map_skip_button != null:
		map_skip_button.disabled = true

	planet_zoom_tween = create_tween().set_parallel(true)
	planet_zoom_tween.tween_property(
		map_zoom_root,
		"position",
		target_center - selected_center,
		1.25
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	planet_zoom_tween.tween_property(
		map_zoom_root,
		"scale",
		Vector2.ONE * camera_scale,
		1.25
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	planet_zoom_tween.tween_property(map_hint, "modulate:a", 0.0, 0.25)
	if map_route_layer != null:
		planet_zoom_tween.tween_property(map_route_layer, "modulate:a", 0.16, 0.42)
	for planet_name in planet_records:
		var item: Dictionary = planet_records[planet_name]
		var holder := item.holder as Control
		var label := item.label as Label
		var selected: bool = String(planet_name) == name
		var holder_scale := focus_scale if selected else 0.82 / camera_scale
		var holder_alpha := 1.0 if selected else 0.38
		planet_zoom_tween.tween_property(
			holder,
			"scale",
			Vector2.ONE * holder_scale,
			1.25
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		planet_zoom_tween.tween_property(holder, "modulate:a", holder_alpha, 1.25)
		planet_zoom_tween.tween_property(label, "modulate:a", 0.0, 0.3)
	return true


func _is_planet_zoom_current(name: String, request_id: int) -> bool:
	return (
		planet_zoom_active
		and not planet_zoom_returning
		and active_planet_name == name
		and planet_zoom_request == request_id
		and map_screen.visible
		and not stage_3d.visible
	)


func _kill_planet_zoom_tween() -> void:
	if planet_zoom_tween != null and planet_zoom_tween.is_valid():
		planet_zoom_tween.kill()
	planet_zoom_tween = null


func _exit_planet_detail() -> void:
	if detail_screen == null:
		return
	if planet_zoom_returning:
		return
	AudioDirector.play_sfx("ui_soft")
	if not planet_zoom_active:
		detail_screen.visible = false
		return
	planet_zoom_returning = true
	planet_zoom_request += 1
	_finish_planet_loading()
	var return_request := planet_zoom_request
	detail_screen.visible = false
	var previous_name := active_planet_name
	_kill_planet_zoom_tween()
	planet_zoom_tween = create_tween().set_parallel(true)
	planet_zoom_tween.tween_property(map_zoom_root, "position", Vector2.ZERO, 1.3) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	planet_zoom_tween.tween_property(map_zoom_root, "scale", Vector2.ONE, 1.3) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	planet_zoom_tween.tween_property(map_hint, "modulate:a", 1.0, 0.35).set_delay(0.7)
	if map_route_layer != null:
		planet_zoom_tween.tween_property(
			map_route_layer,
			"modulate:a",
			1.0,
			0.55
		).set_delay(0.55)
	for planet_name in planet_records:
		var item: Dictionary = planet_records[planet_name]
		var holder := item.holder as Control
		var label := item.label as Label
		var art_group := item.art_group as Control
		planet_zoom_tween.tween_property(holder, "scale", Vector2.ONE, 1.3) \
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		planet_zoom_tween.tween_property(holder, "modulate:a", 1.0, 1.0)
		planet_zoom_tween.tween_property(art_group, "scale", Vector2.ONE, 0.2)
		planet_zoom_tween.tween_property(label, "modulate:a", 1.0, 0.35).set_delay(0.8)
	await planet_zoom_tween.finished
	if planet_zoom_request != return_request:
		return
	planet_zoom_returning = false
	planet_zoom_active = false
	active_planet_name = ""
	map_back_button.disabled = false
	map_hint.modulate.a = 1.0
	if map_skip_button != null:
		map_skip_button.visible = SHOW_MAP_SKIP_BUTTON and not _all_memories_collected()
		map_skip_button.disabled = _all_memories_collected()
		map_skip_button.text = "跳过"
	if planet_records.has(previous_name):
		var previous: Dictionary = planet_records[previous_name]
		var label := previous.label as Label
		label.modulate.a = 1.0
		var button := previous.button as TextureButton
		button.grab_focus()


func _restore_planet_map_instant(preserve_loading := false) -> void:
	if not preserve_loading:
		_finish_planet_loading()
	planet_zoom_request += 1
	_kill_planet_zoom_tween()
	planet_zoom_active = false
	planet_zoom_returning = false
	active_planet_name = ""
	if detail_screen != null:
		detail_screen.visible = false
		detail_screen.modulate.a = 1.0
	if map_zoom_root != null:
		map_zoom_root.position = Vector2.ZERO
		map_zoom_root.scale = Vector2.ONE
	if map_route_layer != null:
		map_route_layer.modulate.a = 1.0
		map_route_layer.call("set_hovered_planet", "")
	for planet_name in planet_records:
		var record: Dictionary = planet_records[planet_name]
		var holder := record.holder as Control
		var art_group := record.art_group as Control
		var focus_ring := record.focus_ring as TextureRect
		var label := record.label as Label
		holder.scale = Vector2.ONE
		holder.modulate = Color.WHITE
		art_group.scale = Vector2.ONE
		focus_ring.visible = false
		focus_ring.modulate.a = 0.0
		label.modulate.a = 1.0
	if map_hint != null:
		map_hint.modulate.a = 1.0
	if map_back_button != null:
		map_back_button.disabled = false
	if map_skip_button != null:
		map_skip_button.visible = SHOW_MAP_SKIP_BUTTON and not _all_memories_collected()
		map_skip_button.disabled = _all_memories_collected()
		map_skip_button.text = "跳过"
	_reapply_planet_tag_layouts()


func _apply_awake_visual(name: String, remember: bool, animated := true) -> void:
	if not planet_records.has(name):
		return
	var record: Dictionary = planet_records[name]
	var button := record.button as TextureButton
	var awake_view := record.awake_view as TextureRect
	var was_awake := bool(awake_planets.get(name, false))
	if record.has("awake_tween"):
		var previous_tween := record.awake_tween as Tween
		if previous_tween != null and previous_tween.is_valid():
			previous_tween.kill()
	var label := record.label as Label
	label.add_theme_color_override("font_color", Color(0.43, 0.29, 0.15, 0.96))
	awake_planets[name] = true
	if animated and not was_awake:
		var crossfade := create_tween().set_parallel(true)
		record["awake_tween"] = crossfade
		crossfade.tween_property(button, "modulate:a", 0.0, 0.55) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		crossfade.tween_property(awake_view, "modulate:a", 1.0, 0.55) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		crossfade.chain().tween_callback(func() -> void: button.material = null)
	else:
		button.modulate.a = 0.0
		awake_view.modulate.a = 1.0
		button.material = null
	if remember and not preview_mode_active:
		_save_awake_state()


func _all_memories_collected() -> bool:
	for slug in MEMORY_ORDER:
		if String(memory_collection_states.get(slug, "locked")) != "collected":
			return false
	return true


func _skip_to_seventh_planet() -> void:
	if transition_running or planet_zoom_active:
		return
	for slug in MEMORY_ORDER:
		memory_collection_states[slug] = "collected"
	journey_slugs.clear()
	for slug in MEMORY_ORDER:
		journey_slugs.append(String(slug))
	journey_legacy_reconstructed = false
	_save_journey_state()
	for slug in STORY_SCENE_SLUGS:
		planet_story_states[slug] = "complete"
	memory_reveal_after.clear()
	memory_collection_busy = false
	_save_memory_state()
	_save_planet_story_state()
	for planet_name in planet_records:
		if String(planet_name) == PLAYER_PLANET_NAME:
			continue
		awake_planets[planet_name] = true
		_apply_awake_visual(String(planet_name), false, false)
	_save_awake_state()
	journey_finale_played = false
	journey_finale_sequence_active = false
	player_planet_revealed = false
	_apply_player_planet_map_reveal(false)
	_refresh_journey_constellation(false)
	if map_skip_button != null:
		map_skip_button.visible = false
		map_skip_button.disabled = true
	call_deferred("_play_final_journey_sequence")


func _sync_player_planet_map_state(animated := false) -> void:
	if not planet_records.has(PLAYER_PLANET_NAME):
		return
	if _all_memories_collected():
		if journey_finale_sequence_active:
			return
		if journey_finale_played or player_planet_revealed:
			_apply_player_planet_map_reveal(true)
		elif map_screen != null and map_screen.visible:
			call_deferred("_play_final_journey_sequence")
		else:
			_apply_player_planet_map_reveal(false)
		return
	_apply_player_planet_map_reveal(false)


func _reveal_player_planet_on_map() -> void:
	if not _all_memories_collected():
		return
	if map_skip_button != null:
		map_skip_button.visible = false
		map_skip_button.disabled = true
	var record: Dictionary = planet_records[PLAYER_PLANET_NAME]
	var holder := record.holder as Control
	var button := record.button as TextureButton
	holder.visible = true
	button.disabled = true
	holder.modulate.a = 1.0
	holder.scale = Vector2.ONE * 0.94
	_show_map_prince_layer()
	if player_planet_reveal_tween != null and player_planet_reveal_tween.is_valid():
		player_planet_reveal_tween.kill()
	player_planet_reveal_tween = create_tween().set_parallel(true)
	player_planet_reveal_tween.tween_property(
		holder,
		"scale",
		Vector2.ONE,
		0.9
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	player_planet_reveal_tween.tween_property(
		self,
		"passage_prince_map_scale",
		PRINCE_MAP_REVEAL_SCALE,
		1.18
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	player_planet_reveal_tween.tween_property(
		self,
		"passage_prince_map_offset_ratio",
		PRINCE_MAP_REVEAL_OFFSET_RATIO,
		1.18
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	player_planet_reveal_tween.chain().tween_callback(
		func() -> void:
			player_planet_revealed = true
			journey_finale_played = true
			journey_finale_sequence_active = false
			button.disabled = false
			button.grab_focus()
			_save_journey_state()
			if map_hint != null:
				map_hint.text = "新的星路已出现 | 点击第七星开始布置"
	)


func _play_final_journey_sequence() -> void:
	if (
		not _all_memories_collected()
		or journey_finale_played
		or journey_finale_sequence_active
		or map_screen == null
		or not map_screen.visible
		or map_route_layer == null
	):
		return
	journey_finale_sequence_active = true
	journey_finale_generation += 1
	var generation := journey_finale_generation
	transition_running = true
	if map_skip_button != null:
		map_skip_button.visible = false
		map_skip_button.disabled = true
	if map_back_button != null:
		map_back_button.disabled = true
	if map_hint != null:
		map_hint.text = "星路正在按旅途顺序重新连接……"
	_apply_player_planet_map_reveal(false)
	_refresh_journey_constellation(false)
	await get_tree().process_frame
	if generation != journey_finale_generation:
		return
	var replay: Tween = map_route_layer.call("replay_route", 0.62)
	if replay != null and replay.is_valid():
		await replay.finished
	if generation != journey_finale_generation:
		return
	await get_tree().create_timer(0.18).timeout
	if generation != journey_finale_generation:
		return
	_reveal_player_planet_on_map()
	var reveal_tween := player_planet_reveal_tween
	if reveal_tween != null and reveal_tween.is_valid():
		await reveal_tween.finished
	if generation != journey_finale_generation:
		return
	journey_finale_sequence_active = false
	transition_running = false
	if map_back_button != null:
		map_back_button.disabled = false


func _apply_player_planet_map_reveal(revealed: bool) -> void:
	if not planet_records.has(PLAYER_PLANET_NAME):
		return
	if player_planet_reveal_tween != null and player_planet_reveal_tween.is_valid():
		player_planet_reveal_tween.kill()
	var record: Dictionary = planet_records[PLAYER_PLANET_NAME]
	var holder := record.holder as Control
	var button := record.button as TextureButton
	holder.visible = true
	button.disabled = not revealed
	holder.modulate.a = 1.0
	holder.scale = Vector2.ONE
	passage_prince_map_scale = PRINCE_MAP_REVEAL_SCALE if revealed else 1.0
	passage_prince_map_offset_ratio = (
		PRINCE_MAP_REVEAL_OFFSET_RATIO if revealed else Vector2.ZERO
	)
	_show_map_prince_layer()
	if passage_prince_below != null and not transition_running:
		passage_prince_below.position = (
			passage_prince_base_position
			+ passage_prince_map_offset_ratio * main_ui.size
		)
		passage_prince_below.scale = Vector2.ONE * passage_prince_map_scale
	if map_hint != null:
		map_hint.text = (
			"新的星路已出现 | 点击第七星开始布置"
			if revealed
			else "移动鼠标 | 点击星球 | ESC 返回封面"
		)


func _show_cover() -> void:
	AudioDirector.play_music("main")
	_restore_planet_map_instant()
	map_screen.visible = false
	map_screen.modulate = Color.WHITE
	cover.visible = true
	cover.modulate.a = 1.0
	if passage != null:
		passage.visible = false
		passage.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if passage_page != null:
		passage_page.visible = true
		passage_page.modulate.a = 1.0
		passage_page.scale = Vector2(1.06, 1.06)
	if passage_prince_above != null:
		passage_prince_above.modulate.a = 1.0
		_set_passage_prince_base(passage_prince_above)
		passage_prince_above.scale = Vector2.ONE
		passage_prince_above.rotation = deg_to_rad(-1.2)
	if passage_prince_below != null:
		passage_prince_below.modulate.a = 0.0
		_set_passage_prince_base(passage_prince_below)
		passage_prince_below.scale = Vector2.ONE
		passage_prince_below.rotation = deg_to_rad(-1.2)
	if passage_glow != null:
		passage_glow.modulate.a = 1.0
	if passage_edge != null:
		passage_edge.modulate.a = 0.5
	_exit_3d(false)
	if save_slot_overlay != null:
		save_slot_overlay.visible = false
	if new_game_confirm_overlay != null:
		new_game_confirm_overlay.visible = false
	_refresh_cover_session_controls()
	if cover_content != null:
		cover_content.modulate.a = 0.0
		cover_content.position = Vector2(0, 10)
		var reveal := create_tween().set_parallel(true)
		reveal.tween_property(cover_content, "modulate:a", 1.0, 0.75)
		reveal.tween_property(cover_content, "position:y", 0.0, 0.9) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _return_to_cover() -> void:
	AudioDirector.play_sfx("ui_soft")
	_restore_map_ui_clean_mode()
	_request_autosave()
	_show_cover()


func _build_3d_stage() -> void:
	stage_3d = Node3D.new()
	stage_3d.name = "PointlighterStage"
	stage_3d.visible = false
	add_child(stage_3d)

	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.025, 0.053, 0.112)
	environment.background_energy_multiplier = 1.0
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.46, 0.56, 0.76)
	environment.ambient_light_energy = 0.76
	environment.tonemap_mode = Environment.TONE_MAPPER_ACES
	environment.tonemap_exposure = 0.80
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.075, 0.115, 0.21)
	environment.fog_light_energy = 0.62
	environment.fog_density = 0.016
	environment.adjustment_enabled = true
	environment.adjustment_brightness = 0.92
	environment.adjustment_contrast = 0.96
	environment.adjustment_saturation = 0.90
	world.environment = environment
	stage_environment = environment
	stage_3d.add_child(world)

	camera_3d = Camera3D.new()
	camera_distance = POINTLIGHTER_HOME_DISTANCE
	camera_3d.position = Vector3(0, 0.72, camera_distance)
	camera_3d.fov = 34.0
	stage_3d.add_child(camera_3d)
	camera_3d.look_at(Vector3(0, 0.08, 0))
	camera_3d.current = true

	planet_light_rig = Node3D.new()
	planet_light_rig.name = "PlanetLightRig"
	stage_3d.add_child(planet_light_rig)

	var key_light := DirectionalLight3D.new()
	key_light.rotation_degrees = Vector3(-50, 34, 0)
	key_light.light_color = Color(0.82, 0.88, 1.0)
	key_light.light_energy = 0.36
	key_light.shadow_enabled = true
	key_light.shadow_blur = 2.8
	key_light.shadow_opacity = 0.54
	planet_light_rig.add_child(key_light)
	stage_key_light = key_light

	var rim_light := DirectionalLight3D.new()
	rim_light.rotation_degrees = Vector3(-12, 142, 0)
	rim_light.light_color = Color(0.48, 0.60, 0.96)
	rim_light.light_energy = 0.36
	planet_light_rig.add_child(rim_light)
	stage_rim_light = rim_light

	var cool_fill := OmniLight3D.new()
	cool_fill.position = Vector3(-5.5, 2.2, 4.5)
	cool_fill.light_color = Color(0.36, 0.59, 0.86)
	cool_fill.light_energy = 0.23
	cool_fill.omni_range = 11.0
	cool_fill.omni_attenuation = 0.72
	planet_light_rig.add_child(cool_fill)
	stage_cool_fill = cool_fill

	var warm_fill := OmniLight3D.new()
	warm_fill.position = Vector3(-2.2, 2.8, 4.8)
	warm_fill.light_color = Color(1.0, 0.72, 0.43)
	warm_fill.light_energy = 0.20
	warm_fill.omni_range = 9.0
	warm_fill.omni_attenuation = 0.68
	planet_light_rig.add_child(warm_fill)
	warm_fill_light = warm_fill

	var front_fill := OmniLight3D.new()
	front_fill.position = Vector3(0.0, 2.1, 4.8)
	front_fill.light_color = Color(0.54, 0.66, 0.90)
	front_fill.light_energy = 0.20
	front_fill.omni_range = 9.5
	front_fill.omni_attenuation = 0.72
	planet_light_rig.add_child(front_fill)
	stage_front_fill = front_fill
	_build_player_dialogue_lights()

	var earth_front := DirectionalLight3D.new()
	earth_front.name = "EarthFrontFill"
	earth_front.rotation_degrees = Vector3(-20.0, -24.0, 0.0)
	earth_front.light_color = Color(1.0, 0.90, 0.72)
	earth_front.light_energy = 0.0
	earth_front.shadow_enabled = false
	earth_front.visible = false
	stage_3d.add_child(earth_front)
	earth_front_light = earth_front

	_build_3d_sky()
	_build_player_day_night_beacon()
	_build_king_celestial()
	_build_dream_grade()
	_build_3d_hud()


func _build_player_dialogue_lights() -> void:
	player_dialogue_spotlights.clear()
	for index in 2:
		var spot := SpotLight3D.new()
		spot.name = "PlayerDialogueSpot%d" % (index + 1)
		spot.light_color = Color(1.0, 0.88, 0.68)
		spot.light_energy = 0.0
		spot.spot_range = 2.2
		spot.spot_attenuation = 0.92
		spot.spot_angle = 18.0
		spot.spot_angle_attenuation = 0.72
		spot.shadow_enabled = true
		spot.shadow_blur = 1.4
		spot.shadow_opacity = 0.24
		spot.visible = false
		stage_3d.add_child(spot)
		player_dialogue_spotlights.append(spot)

	var fill := OmniLight3D.new()
	fill.name = "PlayerDialogueFaceFill"
	fill.light_color = Color(1.0, 0.94, 0.82)
	fill.light_energy = 0.0
	fill.omni_range = 1.8
	fill.omni_attenuation = 0.92
	fill.shadow_enabled = false
	fill.visible = false
	stage_3d.add_child(fill)
	player_dialogue_fill_light = fill


func _set_player_dialogue_lights_active(active: bool) -> void:
	player_dialogue_light_generation += 1
	var generation := player_dialogue_light_generation
	if player_dialogue_light_tween != null and player_dialogue_light_tween.is_valid():
		player_dialogue_light_tween.kill()
	var lights: Array[Light3D] = []
	for spot in player_dialogue_spotlights:
		lights.append(spot)
	if player_dialogue_fill_light != null:
		lights.append(player_dialogue_fill_light)
	if active:
		for light in lights:
			light.visible = true
		_update_player_dialogue_lights()
		player_dialogue_light_tween = create_tween().set_parallel(true)
		for index in player_dialogue_spotlights.size():
			var light := player_dialogue_spotlights[index]
			var target_energy := (
				PLAYER_DIALOGUE_PRINCE_SPOT_ENERGY
				if index == 1
				else PLAYER_DIALOGUE_SPOT_ENERGY
			)
			player_dialogue_light_tween.tween_property(
				light,
				"light_energy",
				target_energy,
				0.28
			).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		if player_dialogue_fill_light != null:
			player_dialogue_light_tween.tween_property(
				player_dialogue_fill_light,
				"light_energy",
				PLAYER_DIALOGUE_FILL_ENERGY,
				0.28
			).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		return
	player_dialogue_light_tween = create_tween().set_parallel(true)
	for light in lights:
		player_dialogue_light_tween.tween_property(
			light,
			"light_energy",
			0.0,
			0.24
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	player_dialogue_light_tween.chain().tween_callback(
		func() -> void:
			if generation != player_dialogue_light_generation:
				return
			for light in lights:
				if is_instance_valid(light):
					light.visible = false
	)


func _update_player_dialogue_lights() -> void:
	if (
		not dialogue_active
		or dialogue_scene != "player"
		or camera_3d == null
		or player_dialogue_spotlights.is_empty()
	):
		return
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	var nodes: Array[Node3D] = []
	for index in [leader_index, prince_index]:
		if index < 0 or index >= editable_3d_objects.size():
			continue
		var node := editable_3d_objects[index].get("node") as Node3D
		if node != null and is_instance_valid(node):
			nodes.append(node)
	if nodes.size() < 2:
		return
	var heads: Array[Vector3] = []
	for node in nodes:
		heads.append(_player_character_head_world_position(node))
	var camera_right := camera_3d.global_basis.x.normalized()
	for index in mini(nodes.size(), player_dialogue_spotlights.size()):
		var node := nodes[index]
		var head := heads[index]
		var up := node.global_transform.basis.y.normalized()
		var to_camera := camera_3d.global_position - head
		if to_camera.length_squared() <= 0.000001:
			to_camera = Vector3.BACK
		to_camera = to_camera.normalized()
		var side_offset := (-0.08 if index == 0 else 0.08)
		var spot := player_dialogue_spotlights[index]
		spot.global_position = (
			head
			+ to_camera * 0.56
			+ up * 0.28
			+ camera_right * side_offset
		)
		spot.look_at(head - up * 0.12, up)
	if player_dialogue_fill_light != null:
		var midpoint := (heads[0] + heads[1]) * 0.5
		var up := nodes[0].global_transform.basis.y.normalized()
		var to_camera := camera_3d.global_position - midpoint
		if to_camera.length_squared() <= 0.000001:
			to_camera = Vector3.BACK
		to_camera = to_camera.normalized()
		player_dialogue_fill_light.global_position = (
			midpoint + to_camera * 0.52 + up * 0.12
		)


func _build_3d_sky() -> void:
	starfield_root = Node3D.new()
	starfield_root.name = "StarAtmosphere"
	stage_3d.add_child(starfield_root)
	_add_star_layer(540, 9.0, 19.0, 0.012, Color(0.84, 0.9, 1.0, 0.76), 31)
	_add_star_layer(190, 7.0, 15.0, 0.020, Color(1.0, 0.93, 0.75, 0.84), 73)
	_add_star_layer(82, 5.8, 11.0, 0.033, Color(1.0, 0.8, 0.53, 0.92), 113)

	var cool_mist_texture := _make_radial_texture(
		Color(0.42, 0.62, 0.98, 0.82),
		Color(0.08, 0.12, 0.25, 0.0)
	)
	var warm_mist_texture := _make_radial_texture(
		Color(0.95, 0.66, 0.38, 0.55),
		Color(0.25, 0.12, 0.04, 0.0)
	)
	_add_atmosphere_sprite(
		cool_mist_texture,
		Vector3(-0.8, 1.2, -4.8),
		Vector3(9.4, 9.4, 1.0),
		Color(0.62, 0.79, 1.0, 0.66),
		0.0
	)
	_add_atmosphere_sprite(
		warm_mist_texture,
		Vector3(-2.5, 2.7, -3.8),
		Vector3(5.8, 5.8, 1.0),
		Color(1.0, 0.75, 0.48, 0.36),
		1.7
	)
	_add_atmosphere_sprite(
		cool_mist_texture,
		Vector3(2.9, 1.0, -3.0),
		Vector3(4.8, 3.4, 1.0),
		Color(0.55, 0.72, 1.0, 0.34),
		3.1
	)
	_build_floating_clouds()
	_build_dream_particles()


func _build_floating_clouds() -> void:
	var cool_cloud := _make_soft_orb_texture(
		Color(0.56, 0.70, 0.90, 0.34),
		Color(0.24, 0.38, 0.62, 0.16),
		Color(0.08, 0.14, 0.28, 0.0)
	)
	var warm_cloud := _make_soft_orb_texture(
		Color(0.86, 0.75, 0.64, 0.26),
		Color(0.50, 0.42, 0.46, 0.12),
		Color(0.22, 0.18, 0.24, 0.0)
	)
	var clouds := [
		[cool_cloud, Vector3(-3.3, 1.2, -2.2), Vector3(2.8, 1.0, 1.0), Color(0.62, 0.78, 1.0, 0.20), 0.2, 0.13],
		[cool_cloud, Vector3(3.2, 1.5, -2.6), Vector3(2.6, 0.9, 1.0), Color(0.55, 0.69, 0.94, 0.18), 1.6, 0.11],
		[cool_cloud, Vector3(0.0, 3.4, -2.3), Vector3(4.2, 0.75, 1.0), Color(0.58, 0.73, 0.96, 0.13), 2.8, 0.09],
		[cool_cloud, Vector3(-3.1, 0.45, 1.2), Vector3(2.15, 0.55, 1.0), Color(0.61, 0.76, 0.96, 0.10), 4.1, 0.16],
		[warm_cloud, Vector3(3.2, 0.75, 1.5), Vector3(2.3, 0.65, 1.0), Color(0.88, 0.74, 0.59, 0.09), 5.0, 0.14],
		[warm_cloud, Vector3(-2.8, 2.5, 1.8), Vector3(2.4, 0.65, 1.0), Color(0.82, 0.72, 0.66, 0.075), 0.9, 0.12],
		[cool_cloud, Vector3(2.7, 2.7, 2.0), Vector3(2.1, 0.55, 1.0), Color(0.60, 0.75, 0.99, 0.07), 3.4, 0.10],
		[cool_cloud, Vector3(0.0, -0.45, -1.6), Vector3(4.6, 0.75, 1.0), Color(0.48, 0.62, 0.86, 0.15), 5.7, 0.08],
	]
	for cloud_data in clouds:
		var texture := cloud_data[0] as Texture2D
		var position := cloud_data[1] as Vector3
		var sprite_scale := cloud_data[2] as Vector3
		var tint := cloud_data[3] as Color
		var phase := float(cloud_data[4])
		var speed := float(cloud_data[5])
		var sprite := Sprite3D.new()
		sprite.name = "FloatingCloud"
		sprite.texture = texture
		sprite.pixel_size = 0.01
		sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		sprite.shaded = false
		sprite.modulate = tint
		sprite.position = position
		sprite.scale = sprite_scale
		sprite.render_priority = -1
		sprite.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		stage_3d.add_child(sprite)
		cloud_sprites.append({
			"sprite": sprite,
			"base_position": position,
			"base_scale": sprite_scale,
			"base_alpha": tint.a,
			"phase": phase,
			"speed": speed,
		})


func _build_dream_grade() -> void:
	dream_grade_layer = CanvasLayer.new()
	dream_grade_layer.name = "DreamGrade"
	dream_grade_layer.layer = 0
	dream_grade_layer.visible = false
	add_child(dream_grade_layer)
	var grade := ColorRect.new()
	grade.name = "SoftBloomAndDepth"
	grade.color = Color.WHITE
	grade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var material := ShaderMaterial.new()
	material.shader = load("res://shaders/dream_grade.gdshader") as Shader
	material.set_shader_parameter("edge_softness", 0.30)
	material.set_shader_parameter("bloom_strength", 0.20)
	material.set_shader_parameter("bloom_threshold", 0.52)
	material.set_shader_parameter("warmth", 0.34)
	material.set_shader_parameter("vignette_strength", 0.20)
	material.set_shader_parameter("tilt_shift_strength", 0.86)
	material.set_shader_parameter("tilt_focus_center", 0.34)
	material.set_shader_parameter("tilt_focus_band", 0.18)
	material.set_shader_parameter("tilt_focus_falloff", 0.56)
	material.set_shader_parameter("tilt_blur_radius", 7.8)
	grade.material = material
	dream_grade_layer.add_child(grade)
	grade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)


func _build_dream_particles() -> void:
	var dust_texture := _make_soft_orb_texture(
		Color(0.86, 0.91, 1.0, 0.52),
		Color(0.35, 0.45, 0.70, 0.16),
		Color(0.16, 0.24, 0.45, 0.0)
	)
	_add_dream_particle_field(
		"DustMotes",
		dust_texture,
		430,
		0.026,
		0.068,
		17.0,
		Color(0.74, 0.82, 1.0, 0.36),
		Vector3(0.0, 1.05, 0.0),
		Vector3(4.25, 2.7, 3.3)
	)


func _build_firefly_flock(for_player := false) -> void:
	if model_3d == null:
		return
	if for_player:
		var previous_root := model_3d.get_node_or_null(
			"PlayerNightFireflies"
		) as Node3D
		if previous_root != null:
			previous_root.queue_free()
		for index in range(firefly_sprites.size() - 1, -1, -1):
			var previous_data: Dictionary = firefly_sprites[index]
			if bool(previous_data.get("player_firefly", false)):
				firefly_sprites.remove_at(index)
	var firefly_root := Node3D.new()
	firefly_root.name = (
		"PlayerNightFireflies" if for_player else "SurfaceFireflies"
	)
	model_3d.add_child(firefly_root)
	var texture := _make_soft_orb_texture(
		Color(1.0, 0.98, 0.80, 0.94),
		Color(1.0, 0.67, 0.25, 0.30),
		Color(1.0, 0.35, 0.04, 0.0)
	)
	var rng := RandomNumberGenerator.new()
	rng.seed = 329612
	var surface_fly_count := 26 if for_player else 46
	for index in surface_fly_count:
		var latitude := deg_to_rad(
			rng.randf_range(37.0, 72.0)
			if for_player
			else rng.randf_range(8.0, 78.0)
		)
		var longitude := rng.randf_range(-PI, PI)
		var normal := Vector3(
			cos(latitude) * sin(longitude),
			sin(latitude),
			cos(latitude) * cos(longitude)
		)
		var base_position: Vector3
		if for_player:
			base_position = (
				Vector3(0.0, 0.45, 0.0)
				+ normal * rng.randf_range(2.62, 2.76)
			)
		elif index % 7 == 0:
			# A few free-floating lights break up the surface-only ring.
			base_position = Vector3(
				rng.randf_range(-2.45, 2.45),
				rng.randf_range(1.35, 2.65),
				rng.randf_range(-2.15, 2.15)
			)
		else:
			var altitude := rng.randf_range(0.08, 1.15)
			if index % 5 == 0:
				altitude = rng.randf_range(0.85, 1.65)
			base_position = (
				Vector3(0.0, rng.randf_range(0.10, 0.45), 0.0)
				+ normal * (rng.randf_range(2.50, 2.72) + altitude)
			)
		var size := (
			rng.randf_range(0.048, 0.084)
			if for_player
			else rng.randf_range(0.072, 0.142)
		)
		var alpha := (
			rng.randf_range(0.62, 0.90)
			if for_player
			else rng.randf_range(0.58, 0.88)
		)
		var sprite := Sprite3D.new()
		sprite.name = "SurfaceFirefly_%02d" % (index + 1)
		sprite.texture = texture
		sprite.pixel_size = 0.01
		sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		sprite.shaded = false
		sprite.modulate = Color(1.0, 0.78, 0.38, alpha)
		sprite.scale = Vector3.ONE * size
		sprite.position = base_position
		sprite.render_priority = 3
		sprite.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		firefly_root.add_child(sprite)
		firefly_sprites.append({
			"sprite": sprite,
			"base_position": base_position,
			"base_scale": size,
			"base_alpha": alpha,
			"phase": rng.randf_range(0.0, TAU),
			"speed": rng.randf_range(0.62, 1.0),
			"motion_amplitude": (
				0.045 if for_player else rng.randf_range(0.09, 0.16)
			),
			"player_firefly": for_player,
		})
	if for_player and player_placement_plane_ready:
		for index in 22:
			var base_position := (
				player_placement_plane_center
				+ player_placement_plane_right
					* rng.randf_range(
						-player_placement_plane_half_right * 0.88,
						player_placement_plane_half_right * 0.88
					)
				+ player_placement_plane_forward
					* rng.randf_range(
						-player_placement_plane_half_forward * 0.82,
						player_placement_plane_half_forward * 0.82
					)
				+ player_placement_plane_normal
					* rng.randf_range(0.12, 0.48)
			)
			var size := rng.randf_range(0.044, 0.078)
			var alpha := rng.randf_range(0.64, 0.92)
			var sprite := Sprite3D.new()
			sprite.name = "PlacementFirefly_%02d" % (index + 1)
			sprite.texture = texture
			sprite.pixel_size = 0.01
			sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
			sprite.shaded = false
			sprite.modulate = Color(1.0, 0.84, 0.48, alpha)
			sprite.scale = Vector3.ONE * size
			sprite.position = base_position
			sprite.render_priority = 3
			sprite.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
			firefly_root.add_child(sprite)
			firefly_sprites.append({
				"sprite": sprite,
				"base_position": base_position,
				"base_scale": size,
				"base_alpha": alpha,
				"phase": rng.randf_range(0.0, TAU),
				"speed": rng.randf_range(0.55, 0.92),
				"motion_amplitude": 0.045,
				"player_firefly": true,
			})


func _register_main_lamp() -> void:
	if main_lamp_node == null or main_lamp_light_anchor == null:
		return
	main_lamp_light = main_lamp_light_anchor.find_child("WarmLight", true, false) as OmniLight3D
	if main_lamp_light != null:
		main_lamp_light.set_meta("base_energy", main_lamp_light.light_energy)
	for item in main_lamp_light_anchor.find_children("*", "Sprite3D", true, false):
		var sprite := item as Sprite3D
		main_lamp_glow_sprites.append(sprite)
		sprite.set_meta("main_lamp_glow", true)

	var anchor_position := main_lamp_light_anchor.position
	for item in main_lamp_node.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var relative_transform := main_lamp_node.global_transform.affine_inverse() \
			* mesh_instance.global_transform
		var center := relative_transform * mesh_instance.get_aabb().get_center()
		if center.distance_to(anchor_position) > 0.62:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var material := mesh_instance.get_active_material(surface)
			if material is not StandardMaterial3D:
				continue
			var standard := material as StandardMaterial3D
			if not standard.emission_enabled:
				continue
			main_lamp_emissive_materials.append({
				"material": standard,
				"base_energy": standard.emission_energy_multiplier,
			})
	main_lamp_level = 1.0
	main_lamp_target_level = 1.0
	main_lamp_on = true


func _add_dream_particle_field(
	field_name: String,
	texture: Texture2D,
	count: int,
	min_size: float,
	max_size: float,
	lifetime: float,
	tint: Color,
	field_position: Vector3,
	field_extents: Vector3
) -> void:
	var particles := CPUParticles3D.new()
	particles.name = field_name
	particles.amount = count
	particles.lifetime = lifetime
	particles.randomness = 0.88
	particles.lifetime_randomness = 0.7
	particles.preprocess = lifetime
	particles.position = field_position
	particles.emission_shape = CPUParticles3D.EMISSION_SHAPE_BOX
	particles.emission_box_extents = field_extents
	particles.direction = Vector3(0.0, 0.15, 0.0)
	particles.spread = 180.0
	particles.gravity = Vector3(0.0, 0.006, 0.0)
	particles.initial_velocity_min = 0.018
	particles.initial_velocity_max = 0.085
	particles.scale_amount_min = min_size
	particles.scale_amount_max = max_size
	particles.color = tint
	var fade := Gradient.new()
	fade.offsets = PackedFloat32Array([0.0, 0.16, 0.72, 1.0])
	fade.colors = PackedColorArray([
		Color(tint.r, tint.g, tint.b, 0.0),
		Color(tint.r, tint.g, tint.b, tint.a),
		Color(tint.r * 1.07, tint.g * 1.03, tint.b, tint.a * 0.72),
		Color(tint.r, tint.g, tint.b, 0.0)
	])
	particles.color_ramp = fade

	var quad := QuadMesh.new()
	quad.size = Vector2.ONE
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
	material.billboard_mode = BaseMaterial3D.BILLBOARD_PARTICLES
	material.albedo_texture = texture
	material.vertex_color_use_as_albedo = true
	material.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_DISABLED
	quad.material = material
	particles.mesh = quad
	stage_3d.add_child(particles)


func _make_soft_orb_texture(center: Color, middle: Color, edge: Color) -> GradientTexture2D:
	var gradient := Gradient.new()
	gradient.offsets = PackedFloat32Array([0.0, 0.08, 0.28, 0.62, 1.0])
	gradient.colors = PackedColorArray([
		center,
		center.lerp(middle, 0.36),
		middle,
		middle.lerp(edge, 0.72),
		edge
	])
	var texture := GradientTexture2D.new()
	texture.width = 256
	texture.height = 256
	texture.fill = GradientTexture2D.FILL_RADIAL
	texture.fill_from = Vector2(0.5, 0.5)
	texture.fill_to = Vector2(1.0, 0.5)
	texture.gradient = gradient
	return texture


func _add_star_layer(
	count: int,
	min_radius: float,
	max_radius: float,
	size: float,
	color: Color,
	seed_value: int
) -> void:
	var sphere := SphereMesh.new()
	sphere.radius = 1.0
	sphere.height = 2.0
	sphere.radial_segments = 6
	sphere.rings = 3
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color
	material.emission_energy_multiplier = 1.35
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	sphere.material = material

	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = sphere
	multimesh.instance_count = count
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value
	for index in count:
		var random_point := Vector3(
			rng.randf_range(-1.0, 1.0),
			rng.randf_range(-1.0, 1.0),
			rng.randf_range(-1.0, 1.0)
		)
		if random_point.length_squared() < 0.001:
			random_point = Vector3.UP
		var position := random_point.normalized() * rng.randf_range(min_radius, max_radius)
		var star_scale := size * rng.randf_range(0.6, 1.8)
		multimesh.set_instance_transform(
			index,
			Transform3D(Basis().scaled(Vector3.ONE * star_scale), position)
		)
	var mesh_instance := MultiMeshInstance3D.new()
	mesh_instance.multimesh = multimesh
	mesh_instance.name = "StarLayer"
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	starfield_root.add_child(mesh_instance)


func _make_radial_texture(inner: Color, outer: Color) -> GradientTexture2D:
	var gradient := Gradient.new()
	gradient.colors = PackedColorArray([inner, outer])
	gradient.offsets = PackedFloat32Array([0.0, 1.0])
	var texture := GradientTexture2D.new()
	texture.width = 256
	texture.height = 256
	texture.fill = GradientTexture2D.FILL_RADIAL
	texture.fill_from = Vector2(0.5, 0.5)
	texture.fill_to = Vector2(1.0, 0.5)
	texture.gradient = gradient
	return texture


func _add_atmosphere_sprite(
	texture: Texture2D,
	position: Vector3,
	sprite_scale: Vector3,
	modulate_color: Color,
	phase: float
) -> void:
	var sprite := Sprite3D.new()
	sprite.name = "AtmosphereMist"
	sprite.texture = texture
	sprite.pixel_size = 0.01
	sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite.shaded = false
	sprite.modulate = modulate_color
	sprite.position = position
	sprite.scale = sprite_scale
	sprite.render_priority = -2
	sprite.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	sprite.set_meta("base_alpha", modulate_color.a)
	sprite.set_meta("base_position", position)
	sprite.set_meta("phase", phase)
	stage_3d.add_child(sprite)
	atmosphere_sprites.append(sprite)


func _add_warm_glow(
	parent: Node3D,
	local_position: Vector3,
	light_energy: float,
	light_range: float,
	glow_scale: float
) -> Node3D:
	var anchor := Node3D.new()
	anchor.name = "LightAnchor"
	anchor.position = local_position
	parent.add_child(anchor)

	var light := OmniLight3D.new()
	light.name = "WarmLight"
	light.light_color = Color(1.0, 0.57, 0.25)
	light.light_energy = light_energy
	light.omni_range = light_range
	light.omni_attenuation = 0.68
	light.shadow_enabled = false
	light.set_meta("base_energy", light_energy)
	light.set_meta("base_range", light_range)
	light.set_meta("editable_light_brightness", 1.0)
	light.set_meta("editable_light_on", true)
	anchor.add_child(light)

	var glow_texture := _make_soft_orb_texture(
		Color(1.0, 1.0, 0.91, 1.0),
		Color(1.0, 0.70, 0.31, 0.54),
		Color(1.0, 0.31, 0.05, 0.0)
	)
	_add_warm_glow_sprite(anchor, glow_texture, "GlowCore", glow_scale, 0.88, 4)
	_add_warm_glow_sprite(anchor, glow_texture, "GlowBloom", glow_scale * 2.15, 0.30, 3)
	_add_warm_glow_sprite(anchor, glow_texture, "GlowHalo", glow_scale * 4.8, 0.15, 2)
	if light_range >= 6.0:
		_add_warm_glow_sprite(anchor, glow_texture, "PlanetLightWash", glow_scale * 6.4, 0.045, 1)
	return anchor


func _add_warm_glow_sprite(
	parent: Node3D,
	texture: Texture2D,
	sprite_name: String,
	sprite_scale: float,
	alpha: float,
	render_priority: int
) -> void:
	var glow := Sprite3D.new()
	glow.name = sprite_name
	glow.texture = texture
	glow.pixel_size = 0.01
	glow.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	glow.shaded = false
	glow.modulate = Color(1.0, 0.82, 0.55, alpha)
	glow.scale = Vector3.ONE * sprite_scale
	glow.render_priority = render_priority
	glow.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	glow.set_meta("base_alpha", alpha)
	glow.set_meta("editable_light_brightness", 1.0)
	glow.set_meta("editable_light_on", true)
	parent.add_child(glow)
	soft_glow_sprites.append({
		"sprite": glow,
		"base_scale": sprite_scale,
		"base_alpha": alpha,
		"phase": float(soft_glow_sprites.size()) * 0.83,
	})


func _add_character_fill(parent: Node3D) -> void:
	var fill := OmniLight3D.new()
	fill.name = "CharacterFill"
	fill.position = Vector3(0.0, 0.7, 0.72)
	fill.light_color = Color(0.84, 0.82, 0.95)
	fill.light_energy = 0.38
	fill.omni_range = 1.65
	fill.omni_attenuation = 0.8
	fill.shadow_enabled = false
	parent.add_child(fill)


func _lift_character_materials(parent: Node3D) -> void:
	for item in parent.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		var material := mesh_instance.get_active_material(0)
		if material is StandardMaterial3D:
			var lifted := (material as StandardMaterial3D).duplicate() as StandardMaterial3D
			lifted.albedo_color = Color(1.22, 1.25, 1.32)
			lifted.emission_enabled = true
			lifted.emission = Color(0.035, 0.045, 0.065)
			lifted.emission_energy_multiplier = 0.55
			mesh_instance.material_override = lifted


func _add_planet_atmosphere(parent: Node3D) -> void:
	_add_planet_atmosphere_with_radius(
		parent,
		2.095,
		Color(0.36, 0.58, 0.94, 0.30)
	)


func _add_planet_atmosphere_with_radius(
	parent: Node3D,
	radius: float,
	rim_color: Color
) -> void:
	var sphere := SphereMesh.new()
	sphere.radius = radius
	sphere.height = radius * 2.0
	sphere.radial_segments = 64
	sphere.rings = 32
	var shader := load("res://shaders/planet_atmosphere.gdshader") as Shader
	if shader == null:
		return
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("rim_color", rim_color)
	material.set_shader_parameter("rim_power", 2.35)
	var atmosphere := MeshInstance3D.new()
	atmosphere.name = "PlanetAtmosphere"
	atmosphere.mesh = sphere
	atmosphere.material_override = material
	atmosphere.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	parent.add_child(atmosphere)


func _update_3d_atmosphere(delta: float) -> void:
	if stage_3d == null or not stage_3d.visible:
		return
	atmosphere_time += delta
	if starfield_root != null:
		starfield_root.rotation.y = atmosphere_time * 0.006
	for index in range(atmosphere_sprites.size() - 1, -1, -1):
		var sprite: Sprite3D = atmosphere_sprites[index]
		if not is_instance_valid(sprite):
			atmosphere_sprites.remove_at(index)
			continue
		var phase := float(sprite.get_meta("phase", 0.0))
		var base_alpha := float(sprite.get_meta("base_alpha", 0.0))
		sprite.modulate.a = base_alpha * (0.82 + 0.18 * sin(atmosphere_time * 0.36 + phase))
		var base_position: Vector3 = sprite.get_meta("base_position", sprite.position)
		sprite.position = base_position + Vector3(
			sin(atmosphere_time * 0.13 + phase) * 0.12,
			cos(atmosphere_time * 0.16 + phase) * 0.07,
			0.0
		)
	for index in range(cloud_sprites.size() - 1, -1, -1):
		var cloud_data: Dictionary = cloud_sprites[index]
		var cloud_value: Variant = cloud_data.get("sprite")
		if not is_instance_valid(cloud_value):
			cloud_sprites.remove_at(index)
			continue
		var cloud := cloud_value as Sprite3D
		var cloud_phase := atmosphere_time * float(cloud_data.speed) + float(cloud_data.phase)
		var cloud_base := cloud_data.base_position as Vector3
		cloud.position = cloud_base + Vector3(
			sin(cloud_phase) * 0.24,
			cos(cloud_phase * 0.72 + 0.8) * 0.10,
			sin(cloud_phase * 0.53) * 0.12
		)
		var cloud_scale := cloud_data.base_scale as Vector3
		cloud.scale = cloud_scale * (1.0 + sin(cloud_phase * 0.61 + 1.3) * 0.035)
		cloud.modulate.a = float(cloud_data.base_alpha) * (
			0.82 + sin(cloud_phase * 0.47 + 0.4) * 0.18
		)
	for index in range(soft_glow_sprites.size() - 1, -1, -1):
		var glow_data: Dictionary = soft_glow_sprites[index]
		var glow_value: Variant = glow_data.get("sprite")
		if not is_instance_valid(glow_value):
			soft_glow_sprites.remove_at(index)
			continue
		var glow := glow_value as Sprite3D
		var glow_phase := atmosphere_time * 1.48 + float(glow_data.phase)
		var halo_pulse := 1.0 + sin(glow_phase * 0.71 + 0.8) * 0.075
		glow.scale = Vector3.ONE * float(glow_data.base_scale) * halo_pulse
		var lamp_factor := main_lamp_level if glow.has_meta("main_lamp_glow") else 1.0
		var editable_factor := float(
			glow.get_meta("editable_light_brightness", 1.0)
		)
		if not bool(glow.get_meta("editable_light_on", true)):
			editable_factor = 0.0
		glow.modulate.a = float(glow_data.base_alpha) * lamp_factor * editable_factor * (
			0.94 + sin(glow_phase * 0.82) * 0.06
		)
	for index in range(firefly_sprites.size() - 1, -1, -1):
		var firefly_data: Dictionary = firefly_sprites[index]
		var firefly_value: Variant = firefly_data.get("sprite")
		if not is_instance_valid(firefly_value):
			firefly_sprites.remove_at(index)
			continue
		var firefly := firefly_value as Sprite3D
		var firefly_phase := atmosphere_time * float(firefly_data.speed) + float(firefly_data.phase)
		var base_position: Vector3 = firefly_data.base_position
		var motion_amplitude := float(
			firefly_data.get("motion_amplitude", 0.045)
		)
		firefly.position = base_position + Vector3(
			sin(firefly_phase * 0.83) * motion_amplitude,
			sin(firefly_phase * 0.57 + 1.1) * motion_amplitude * 1.20,
			cos(firefly_phase * 0.64) * motion_amplitude * 0.90
		)
		var pulse := 0.9 + sin(firefly_phase * 1.37) * 0.10
		firefly.scale = Vector3.ONE * float(firefly_data.base_scale) * pulse
		var player_visibility := (
			player_firefly_opacity
			if bool(firefly_data.get("player_firefly", false))
			else 1.0
		)
		firefly.modulate.a = float(firefly_data.base_alpha) * player_visibility * (
			0.68 + 0.32 * (0.5 + 0.5 * sin(firefly_phase * 1.21 + 0.6))
		)
	if current_3d_scene == "pointlighter":
		_update_main_lamp(delta)


func _update_main_lamp(delta: float) -> void:
	main_lamp_level = lerpf(
		main_lamp_level,
		main_lamp_target_level,
		1.0 - exp(-delta * 5.2)
	)
	if absf(main_lamp_level - main_lamp_target_level) < 0.002:
		main_lamp_level = main_lamp_target_level
	if main_lamp_light != null:
		var base_energy := float(main_lamp_light.get_meta("base_energy", 5.6))
		main_lamp_light.light_energy = base_energy * main_lamp_level
	for entry in main_lamp_emissive_materials:
		var material := entry.material as StandardMaterial3D
		if material != null:
			material.emission_energy_multiplier = float(entry.base_energy) * main_lamp_level
	if warm_fill_light != null:
		warm_fill_light.light_energy = lerpf(0.045, 0.20, main_lamp_level)
	if stage_key_light != null:
		stage_key_light.light_energy = lerpf(0.08, 0.36, main_lamp_level)
	if stage_rim_light != null:
		stage_rim_light.light_energy = lerpf(0.075, 0.36, main_lamp_level)
	if stage_cool_fill != null:
		stage_cool_fill.light_energy = lerpf(0.045, 0.23, main_lamp_level)
	if stage_front_fill != null:
		stage_front_fill.light_energy = lerpf(0.035, 0.20, main_lamp_level)
	if stage_environment != null:
		stage_environment.tonemap_exposure = lerpf(0.58, 0.80, main_lamp_level)
		stage_environment.ambient_light_energy = lerpf(0.34, 0.76, main_lamp_level)
		stage_environment.adjustment_brightness = lerpf(0.76, 0.92, main_lamp_level)
		stage_environment.fog_light_energy = lerpf(0.34, 0.62, main_lamp_level)
	_apply_planet_base_lighting_multiplier()


func _editable_record_base_transform(record: Dictionary) -> Transform3D:
	# Zero degrees keeps the object's base perpendicular to the local surface.
	# The tilt is applied around the local tangent after surface alignment.
	var tilt_degrees := float(record.get("surface_tilt", 0.0))
	if String(record.kind) in ALWAYS_SURFACE_UPRIGHT_KINDS:
		tilt_degrees = 0.0
	var surface_tilt := Basis(
		Vector3.RIGHT,
		deg_to_rad(tilt_degrees)
	)
	if String(record.get("layout_mode", "sphere")) == "plane":
		var plane_basis := Basis(Vector3.UP, deg_to_rad(float(record.yaw)))
		var plane_position: Vector3 = record.position as Vector3
		if record.has("placement_plane_normal"):
			var placement_normal: Vector3 = (
				record.placement_plane_normal as Vector3
			).normalized()
			plane_basis = _normal_surface_basis(
				placement_normal,
				float(record.yaw)
			)
			plane_position += placement_normal * float(
				record.get("placement_height_offset", 0.0)
			)
		return Transform3D(
			plane_basis * surface_tilt,
			plane_position
		)
	var normal: Vector3 = (record.normal as Vector3).normalized()
	var position := normal * float(record.root_radius)
	var basis: Basis
	if String(record.kind) in MERCHANT_ROPE_KINDS:
		basis = _upright_surface_basis(normal, position)
		basis *= Basis(Vector3.UP, deg_to_rad(float(record.yaw)))
	elif bool(record.upright):
		# Use the surface normal as the object's local up axis. This is
		# deterministic, so wind-animated props do not turn toward the camera.
		basis = _normal_surface_basis(normal, float(record.yaw))
	else:
		basis = _normal_surface_basis(normal, float(record.yaw))
	return Transform3D(basis * surface_tilt, position)


func _update_editable_wind_and_wobble(delta: float) -> void:
	if stage_3d == null or not stage_3d.visible:
		return
	_update_earth_wheat_wind(delta)
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		var kind := String(record.kind)
		var is_wind := kind in WIND_KINDS
		var has_wobble := prop_wobble_states.has(index)
		if not is_wind and not has_wobble:
			continue
		var node := record.node as Node3D
		if node == null or not node.visible:
			continue
		var base := _editable_record_base_transform(record)
		var rotation := Basis.IDENTITY
		var squash := 0.0
		if is_wind and not editor_active:
			var phase := float(index) * 0.83
			var wind := (
				sin(atmosphere_time * 0.78 + phase) * 0.62
				+ sin(atmosphere_time * 1.43 + phase * 0.37) * 0.38
			)
			var strength := 2.8 if kind == "grass" else 1.15
			rotation *= Basis(Vector3.RIGHT, deg_to_rad(wind * strength))
			rotation *= Basis(
				Vector3.BACK,
				deg_to_rad(cos(atmosphere_time * 0.61 + phase) * strength * 0.34)
			)
		if has_wobble:
			var state: Dictionary = prop_wobble_states[index]
			var elapsed := float(state.get("elapsed", 0.0)) + delta
			state["elapsed"] = elapsed
			var decay := exp(-elapsed * 4.6)
			var angle := sin(elapsed * 21.0) * float(state.get("strength", 5.0)) * decay
			rotation *= Basis(state.get("axis", Vector3.RIGHT) as Vector3, deg_to_rad(angle))
			squash = sin(elapsed * 27.0) * decay * float(state.get("squash", 0.045))
			if elapsed > 1.6:
				prop_wobble_states.erase(index)
		node.transform = Transform3D(base.basis * rotation, base.origin)
		var scale_value := float(record.scale)
		node.scale = Vector3(
			scale_value * (1.0 + squash * 0.35),
			scale_value * (1.0 - squash),
			scale_value * (1.0 + squash * 0.35)
		)


func _update_earth_wheat_wind(delta: float) -> void:
	var hover_enabled := (
		current_3d_scene == "earth"
		and not editor_active
		and not dragging_3d
	)
	if not hover_enabled:
		earth_wheat_wind_origin_valid = false
	var pointer := get_viewport().get_mouse_position()
	var pointer_velocity := Vector2.ZERO
	if wheat_hover_pointer_valid and delta > 0.0:
		pointer_velocity = (pointer - wheat_hover_pointer) / delta
	if hover_enabled:
		wheat_hover_pointer_velocity = wheat_hover_pointer_velocity.lerp(
			pointer_velocity,
			1.0 - exp(-delta * 12.0)
		)
	else:
		wheat_hover_pointer_velocity = Vector2.ZERO
	wheat_hover_pointer = pointer
	wheat_hover_pointer_valid = true

	var nearest_distance := INF
	var nearest_anchor := Vector3.ZERO
	var found_wheat := false
	if hover_enabled:
		for record in editable_3d_objects:
			if String(record.get("kind", "")) not in EARTH_WHEAT_KINDS:
				continue
			var node := record.get("node") as Node3D
			if node == null or not node.is_visible_in_tree():
				continue
			var anchor := (
				node.global_transform * Vector3(0.0, 0.10, 0.0)
			)
			if camera_3d.is_position_behind(anchor):
				continue
			var screen_distance := camera_3d.unproject_position(
				anchor
			).distance_to(pointer)
			if screen_distance < nearest_distance:
				nearest_distance = screen_distance
				nearest_anchor = anchor
				found_wheat = true

	var target_strength := 0.0
	if found_wheat and nearest_distance < 132.0:
		var proximity := 1.0 - smoothstep(
			28.0,
			132.0,
			nearest_distance
		)
		var speed := smoothstep(
			6.0,
			320.0,
			wheat_hover_pointer_velocity.length()
		)
		target_strength = proximity * speed
	var response_rate := (
		6.5
		if target_strength > earth_wheat_wind_strength
		else 2.1
	)
	earth_wheat_wind_strength = lerp(
		earth_wheat_wind_strength,
		target_strength,
		1.0 - exp(-delta * response_rate)
	)
	if earth_wheat_wind_strength < 0.001:
		earth_wheat_wind_strength = 0.0
	if found_wheat:
		var target_origin := _earth_wheat_pointer_surface_point(
			pointer,
			nearest_anchor
		)
		if earth_wheat_wind_origin_valid:
			earth_wheat_wind_origin = earth_wheat_wind_origin.lerp(
				target_origin,
				1.0 - exp(-delta * 24.0)
			)
		else:
			earth_wheat_wind_origin = target_origin
			earth_wheat_wind_origin_valid = true
	if found_wheat and wheat_hover_pointer_velocity.length() > 8.0:
		var screen_direction := (
			wheat_hover_pointer_velocity.normalized()
		)
		var world_direction := (
			camera_3d.global_basis.x * screen_direction.x
			- camera_3d.global_basis.y * screen_direction.y
		)
		if world_direction.length_squared() > 0.001:
			earth_wheat_wind_direction = world_direction.normalized()
	earth_wheat_wind_time += delta * (
		0.45 + earth_wheat_wind_strength * 1.25
	)
	for material in earth_wheat_materials:
		material.set_shader_parameter(
			"wind_strength",
			earth_wheat_wind_strength
		)
		material.set_shader_parameter(
			"wind_time",
			earth_wheat_wind_time
		)
		material.set_shader_parameter(
			"wind_origin",
			earth_wheat_wind_origin
		)
		material.set_shader_parameter(
			"wind_direction",
			earth_wheat_wind_direction
		)


func _earth_wheat_pointer_surface_point(
	pointer: Vector2,
	nearest_anchor: Vector3
) -> Vector3:
	if camera_3d == null or model_3d == null:
		return nearest_anchor
	var planet_center := model_3d.global_transform.origin
	var sphere_radius := maxf(
		planet_center.distance_to(nearest_anchor),
		0.1
	)
	var ray_origin := camera_3d.project_ray_origin(pointer)
	var ray_direction := camera_3d.project_ray_normal(pointer).normalized()
	var offset := ray_origin - planet_center
	var along_ray := offset.dot(ray_direction)
	var discriminant := (
		along_ray * along_ray
		- offset.length_squared()
		+ sphere_radius * sphere_radius
	)
	if discriminant < 0.0:
		return ray_origin + ray_direction * (-along_ray)
	var root := sqrt(discriminant)
	var distance_along_ray := -along_ray - root
	if distance_along_ray < 0.0:
		distance_along_ray = -along_ray + root
	if distance_along_ray < 0.0:
		return nearest_anchor
	return ray_origin + ray_direction * distance_along_ray


func _start_prop_wobble(index: int, screen_position: Vector2) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	var kind := String(record.kind)
	if not _supports_prop_feedback(kind):
		return
	var node := record.node as Node3D
	if node == null:
		return
	var center := _editable_world_bounds(node).get_center()
	var center_screen := camera_3d.unproject_position(center)
	var horizontal := signf(screen_position.x - center_screen.x)
	if horizontal == 0.0:
		horizontal = 1.0
	var vertical := signf(screen_position.y - center_screen.y)
	var axes := {
		"round_tree": Vector3(0.82 * horizontal, 0.0, 0.28),
		"pine_tree": Vector3(0.74 * horizontal, 0.0, 0.34 * vertical),
		"grass": Vector3(0.68 * horizontal, 0.0, 0.52 * vertical),
		"rocks": Vector3(0.88 * horizontal, 0.0, 0.22),
		"stone_path": Vector3(0.92, 0.0, 0.18 * vertical),
		"ladder": Vector3(0.82, 0.0, 0.28 * vertical),
		"baobab": Vector3(0.78 * horizontal, 0.0, 0.36 * vertical),
		"volcano": Vector3(0.84 * horizontal, 0.0, 0.22 * vertical),
		"fence": Vector3(0.72 * horizontal, 0.0, 0.22 * vertical),
		"flower_cluster": Vector3(0.76 * horizontal, 0.0, 0.48 * vertical),
		"flower_patch": Vector3(0.80 * horizontal, 0.0, 0.44 * vertical),
	}
	var strengths := {
		"round_tree": 7.2,
		"pine_tree": 6.6,
		"grass": 10.0,
		"rocks": 8.0,
		"stone_path": 4.0,
		"ladder": 7.0,
		"baobab": 6.5,
		"volcano": 5.4,
		"fence": 4.2,
		"flower_cluster": 8.2,
		"flower_patch": 7.4,
	}
	var axis: Vector3 = axes.get(
		kind,
		Vector3(0.78 * horizontal, 0.0, 0.30 * vertical)
	)
	var strength := float(strengths.get(kind, 6.0))
	prop_wobble_states[index] = {
		"elapsed": 0.0,
		"axis": axis.normalized(),
		"strength": strength,
		"squash": (
			0.07
			if kind in ["grass", "flower_cluster", "flower_patch"]
			else 0.045
		),
	}


func _build_merchant_lamp_swing_assemblies() -> void:
	if current_3d_scene != "merchant" or model_3d == null:
		return
	# Rebuild the combined rope + star-lamp groups from the current editable
	# records. The rope and its paired star are siblings under one top pivot.
	for pivot in merchant_lamp_assembly_pivots:
		if not is_instance_valid(pivot):
			continue
		for child in pivot.get_children():
			if child is Node3D:
				(child as Node3D).reparent(model_3d, true)
		pivot.queue_free()
	merchant_lamp_assembly_pivots.clear()
	star_lamp_swing_states.clear()

	for record in editable_3d_objects:
		var node := record.get("node") as Node3D
		if node != null and node.get_parent() != model_3d:
			node.reparent(model_3d, true)

	var rope_nodes: Array[Node3D] = []
	var star_nodes: Array[Node3D] = []
	for record in editable_3d_objects:
		var node := record.get("node") as Node3D
		if node == null:
			continue
		var kind := String(record.get("kind", ""))
		if kind in MERCHANT_ROPE_KINDS:
			rope_nodes.append(node)
		elif kind == "star_lamp":
			star_nodes.append(node)

	var paired_stars: Dictionary = {}
	var assembly_index := 0
	for rope in rope_nodes:
		var best_star: Node3D = null
		var best_distance := INF
		for star in star_nodes:
			if paired_stars.has(star):
				continue
			var distance := rope.global_position.distance_squared_to(
				star.global_position
			)
			if distance < best_distance:
				best_distance = distance
				best_star = star
		if best_star == null:
			continue
		paired_stars[best_star] = true
		var rope_bounds := _node_bounds_relative_to(rope)
		if rope_bounds.size == Vector3.ZERO:
			continue
		var rope_top_local := Vector3(
			rope_bounds.get_center().x,
			rope_bounds.end.y,
			rope_bounds.get_center().z
		)
		var rope_top_world := rope.global_transform * rope_top_local
		var anchor_local := (
			model_3d.global_transform.affine_inverse() * rope_top_world
		)
		var pivot := Node3D.new()
		assembly_index += 1
		pivot.name = "MerchantLampAssembly_%02d" % assembly_index
		pivot.transform = Transform3D(Basis.IDENTITY, anchor_local)
		model_3d.add_child(pivot)
		rope.reparent(pivot, true)
		best_star.reparent(pivot, true)
		rope.set_meta("lamp_swing_pivot", pivot)
		best_star.set_meta("lamp_swing_pivot", pivot)
		merchant_lamp_assembly_pivots.append(pivot)


func _node_bounds_relative_to(parent: Node3D) -> AABB:
	var bounds := AABB()
	var has_bounds := false
	var parent_inverse := parent.global_transform.affine_inverse()
	for item in parent.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var local_transform := parent_inverse * mesh_instance.global_transform
		var mesh_bounds := local_transform * mesh_instance.get_aabb()
		bounds = mesh_bounds if not has_bounds else bounds.merge(mesh_bounds)
		has_bounds = true
	return bounds


func _star_lamp_swing_state(pivot: Node3D) -> Dictionary:
	var key := pivot.get_instance_id()
	if not star_lamp_swing_states.has(key):
		star_lamp_swing_states[key] = {
			"angle": Vector3.ZERO,
			"angular_velocity": Vector3.ZERO,
		}
	return star_lamp_swing_states[key] as Dictionary


func _kick_star_lamp(index: int, pointer_delta: Vector2) -> void:
	if (
		index < 0
		or index >= editable_3d_objects.size()
		or String(editable_3d_objects[index].get("kind", "")) != "star_lamp"
		or camera_3d == null
	):
		return
	var wrapper := editable_3d_objects[index].node as Node3D
	if wrapper == null or not wrapper.is_visible_in_tree():
		return
	var pivot := wrapper.get_meta("lamp_swing_pivot", null) as Node3D
	if pivot == null:
		return
	var model_basis_inverse := model_3d.global_transform.basis.inverse()
	var local_screen_right := (
		model_basis_inverse * camera_3d.global_basis.x
	)
	var local_screen_up := (
		model_basis_inverse * camera_3d.global_basis.y
	)
	local_screen_right.y = 0.0
	local_screen_up.y = 0.0
	var swing_direction := (
		local_screen_right.normalized() * pointer_delta.x
		+ local_screen_up.normalized() * pointer_delta.y * 0.35
	)
	swing_direction.y = 0.0
	if swing_direction.length_squared() < 0.0001:
		swing_direction = local_screen_right.normalized()
	if swing_direction.length_squared() < 0.0001:
		swing_direction = Vector3.RIGHT
	var swing_axis := Vector3.UP.cross(swing_direction).normalized()
	var state := _star_lamp_swing_state(pivot)
	var drive: Vector3 = state.get("drive", Vector3.ZERO)
	state["drive"] = (
		drive + swing_axis * STAR_LAMP_SWING_DRIVE
	).limit_length(STAR_LAMP_SWING_DRIVE_MAX)


func _update_star_lamp_swings(delta: float) -> void:
	if (
		current_3d_scene != "merchant"
		or stage_3d == null
		or not stage_3d.visible
	):
		return
	for pivot in merchant_lamp_assembly_pivots:
		if not is_instance_valid(pivot) or not pivot.is_visible_in_tree():
			continue
		var state := _star_lamp_swing_state(pivot)
		var angle: Vector3 = state.get("angle", Vector3.ZERO)
		var angular_velocity: Vector3 = state.get(
			"angular_velocity",
			Vector3.ZERO
		)
		var drive: Vector3 = state.get("drive", Vector3.ZERO)
		var acceleration := (
			-STAR_LAMP_SWING_OMEGA * STAR_LAMP_SWING_OMEGA * angle
			- STAR_LAMP_SWING_DAMPING * angular_velocity
			+ drive
		)
		angular_velocity = (
			angular_velocity + acceleration * delta
		).limit_length(STAR_LAMP_SWING_MAX_SPEED)
		angle += angular_velocity * delta
		if angle.length() > STAR_LAMP_SWING_MAX_ANGLE:
			angle = angle.normalized() * STAR_LAMP_SWING_MAX_ANGLE
		if angle.length_squared() < 0.0000001 and angular_velocity.length_squared() < 0.0000001:
			angle = Vector3.ZERO
			angular_velocity = Vector3.ZERO
		state["angle"] = angle
		state["angular_velocity"] = angular_velocity
		state["drive"] = drive * exp(-STAR_LAMP_SWING_DRIVE_DECAY * delta)
		if angle.length_squared() > 0.0000001:
			pivot.quaternion = Quaternion(angle.normalized(), angle.length())
		else:
			pivot.quaternion = Quaternion.IDENTITY


func _reset_star_lamp_swings() -> void:
	for pivot in merchant_lamp_assembly_pivots:
		if is_instance_valid(pivot):
			pivot.quaternion = Quaternion.IDENTITY
	star_lamp_swing_states.clear()
	star_lamp_kick_times.clear()
	star_lamp_hovered_index = -1
	merchant_hover_pointer_valid = false


func _pick_star_lamp_at_screen(screen_position: Vector2) -> int:
	if (
		current_3d_scene != "merchant"
		or camera_3d == null
	):
		return -1
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var best_index := -1
	var best_distance := INF
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		if String(record.get("kind", "")) != "star_lamp":
			continue
		var wrapper := record.node as Node3D
		if wrapper == null or not wrapper.is_visible_in_tree():
			continue
		var world_bounds := _editable_world_bounds(wrapper)
		if world_bounds.size == Vector3.ZERO:
			continue
		var broad_distance := _ray_aabb_distance(
			ray_origin,
			ray_direction,
			world_bounds
		)
		if broad_distance == INF:
			continue
		if broad_distance < best_distance:
			best_distance = broad_distance
			best_index = index
	return best_index


func _pick_abacus_bead_at_screen(screen_position: Vector2) -> int:
	if (
		current_3d_scene != "merchant"
		or camera_3d == null
		or abacus_bead_targets.is_empty()
	):
		return -1
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var best_index := -1
	var best_distance := INF
	for index in abacus_bead_targets.size():
		var target: Dictionary = abacus_bead_targets[index]
		var pivot := target.node as Node3D
		var visual := target.visual as Node3D
		if pivot == null or visual == null or not pivot.is_visible_in_tree():
			continue
		var world_bounds := _editable_world_bounds(visual)
		world_bounds = world_bounds.grow(
			maxf(world_bounds.size.x, maxf(world_bounds.size.y, world_bounds.size.z))
			* 0.08
		)
		var broad_distance := _ray_aabb_distance(
			ray_origin,
			ray_direction,
			world_bounds
		)
		if broad_distance == INF:
			continue
		var hit_distance := _object_ray_hit_distance(
			visual,
			ray_origin,
			ray_direction
		)
		if hit_distance < best_distance:
			best_distance = hit_distance
			best_index = index
	return best_index


func _update_merchant_hover_interactions(pointer_override := Vector2.INF) -> void:
	if (
		current_3d_scene != "merchant"
		or stage_3d == null
		or not stage_3d.visible
	):
		merchant_hover_pointer_valid = false
		return
	var pointer := (
		get_viewport().get_mouse_position()
		if pointer_override == Vector2.INF
		else pointer_override
	)
	if (
		editor_active
		or (
			dialogue_active
			and dialogue_panel != null
			and dialogue_panel.get_global_rect().has_point(pointer)
		)
	):
		if abacus_bead_dragging:
			_finish_abacus_bead_drag()
		abacus_bead_hover_index = -1
		star_lamp_hovered_index = -1
		merchant_hover_pointer_valid = false
		return
	if not merchant_hover_pointer_valid:
		merchant_hover_pointer = pointer
		merchant_hover_pointer_valid = true
	var pointer_delta := pointer - merchant_hover_pointer
	merchant_hover_pointer = pointer
	if dragging_3d:
		if abacus_bead_dragging:
			_finish_abacus_bead_drag()
		abacus_bead_hover_index = -1
		star_lamp_hovered_index = -1
		return

	var pointer_moved := pointer_delta.length_squared() > 0.000001
	var bead_index := _pick_abacus_bead_at_screen(pointer)
	if bead_index != abacus_bead_hover_index:
		if abacus_bead_dragging:
			_finish_abacus_bead_drag()
		abacus_bead_hover_index = bead_index
	if bead_index >= 0 and pointer_moved:
		if (
			not abacus_bead_dragging
			or abacus_bead_drag_index != bead_index
		):
			_begin_abacus_bead_drag(bead_index)
		_update_abacus_bead_drag(pointer_delta)

	var lamp_index := (
		_pick_star_lamp_at_screen(pointer)
		if bead_index < 0
		else -1
	)
	if lamp_index != star_lamp_hovered_index:
		star_lamp_hovered_index = lamp_index
	if lamp_index >= 0 and pointer_moved:
		var now := Time.get_ticks_msec()
		var last_kick := int(star_lamp_kick_times.get(lamp_index, -100000))
		if now - last_kick >= 650:
			_kick_star_lamp(lamp_index, pointer_delta)
			star_lamp_kick_times[lamp_index] = now
	Input.set_default_cursor_shape(
		Input.CURSOR_POINTING_HAND
		if bead_index >= 0 or lamp_index >= 0
		else Input.CURSOR_ARROW
	)


func _begin_abacus_bead_drag(index: int) -> bool:
	if index < 0 or index >= abacus_bead_targets.size():
		return false
	abacus_bead_dragging = true
	abacus_bead_drag_index = index
	var target: Dictionary = abacus_bead_targets[index]
	var pivot := target.node as Node3D
	if pivot == null:
		abacus_bead_dragging = false
		abacus_bead_drag_index = -1
		return false
	abacus_bead_drag_target_z = pivot.position.z
	target["velocity"] = 0.0
	model_spin_velocity = Vector2.ZERO
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	return true


func _update_abacus_bead_drag(pointer_delta: Vector2) -> void:
	if (
		not abacus_bead_dragging
		or abacus_bead_drag_index < 0
		or abacus_bead_drag_index >= abacus_bead_targets.size()
	):
		return
	var target: Dictionary = abacus_bead_targets[abacus_bead_drag_index]
	var pivot := target.node as Node3D
	if pivot == null:
		_finish_abacus_bead_drag()
		return
	var parent := pivot.get_parent() as Node3D
	if parent == null:
		return
	var row_y := float(target.row_y)
	var min_z := float(target.min_z)
	var max_z := float(target.max_z)
	var start_world := parent.global_transform * Vector3(0.0, row_y, min_z)
	var end_world := parent.global_transform * Vector3(0.0, row_y, max_z)
	var screen_start := camera_3d.unproject_position(start_world)
	var screen_end := camera_3d.unproject_position(end_world)
	var screen_axis := screen_end - screen_start
	var screen_length := screen_axis.length()
	if screen_length < 3.0:
		return
	var local_delta := (
		pointer_delta.dot(screen_axis / screen_length)
		* (max_z - min_z)
		/ screen_length
	)
	var active_index := int(target.bead_index)
	var row_bead_count := int(target.get("row_bead_count", 5))
	var active_min_z := min_z + (
		active_index * ABACUS_BEAD_COLLISION_RADIUS * 2.0
	)
	var active_max_z := max_z - (
		(row_bead_count - 1 - active_index)
		* ABACUS_BEAD_COLLISION_RADIUS * 2.0
	)
	abacus_bead_drag_target_z = clampf(
		abacus_bead_drag_target_z + local_delta,
		active_min_z,
		active_max_z
	)


func _update_abacus_beads(delta: float) -> void:
	# Each row is a constrained one-dimensional bead chain. The visual motion is
	# solved explicitly so it stays aligned with the rotated abacus during orbit.
	if (
		current_3d_scene != "merchant"
		or stage_3d == null
		or not stage_3d.visible
		or abacus_bead_targets.is_empty()
	):
		return
	var frame_delta := maxf(delta, 0.0001)
	for row_index in ABACUS_BEAD_ROW_Y.size():
		var row_targets: Array[Dictionary] = []
		var row_bead_count := int(
			ABACUS_BEAD_INITIAL_ROWS[row_index].size()
		)
		var start_index := row_index * row_bead_count
		for bead_index in row_bead_count:
			var target_index := start_index + bead_index
			if target_index >= abacus_bead_targets.size():
				break
			var target: Dictionary = abacus_bead_targets[target_index]
			if target.node == null:
				continue
			row_targets.append(target)
		if row_targets.is_empty():
			continue

		for target in row_targets:
			var pivot := target.node as Node3D
			if pivot == null:
				continue
			var old_z := float(target.get("z", pivot.position.z))
			var velocity := float(target.get("velocity", 0.0))
			var min_z := float(target.min_z)
			var max_z := float(target.max_z)
			var next_z := old_z
			if (
				abacus_bead_dragging
				and abacus_bead_targets[abacus_bead_drag_index].node == pivot
			):
				var active_index := int(target.bead_index)
				var active_min_z := min_z + (
					active_index * ABACUS_BEAD_COLLISION_RADIUS * 2.0
				)
				var active_max_z := max_z - (
					(int(target.get("row_bead_count", 5)) - 1 - active_index)
					* ABACUS_BEAD_COLLISION_RADIUS * 2.0
				)
				var response := 1.0 - exp(-ABACUS_BEAD_DRAG_RESPONSE * frame_delta)
				next_z = move_toward(
					old_z,
					clampf(
						lerpf(old_z, abacus_bead_drag_target_z, response),
						active_min_z,
						active_max_z
					),
					ABACUS_BEAD_MAX_DRAG_STEP
				)
				velocity = (next_z - old_z) / frame_delta
			else:
				next_z = old_z + velocity * frame_delta
				velocity *= exp(-ABACUS_BEAD_SLIDE_DAMPING * frame_delta)
			next_z = clampf(next_z, min_z, max_z)
			if is_equal_approx(next_z, min_z) and velocity < 0.0:
				velocity = -velocity * ABACUS_BEAD_END_RESTITUTION
				target["impact"] = maxf(
					float(target.get("impact", 0.0)),
					clampf(absf(velocity) * 2.8, 0.16, 0.72)
				)
			elif is_equal_approx(next_z, max_z) and velocity > 0.0:
				velocity = -velocity * ABACUS_BEAD_END_RESTITUTION
				target["impact"] = maxf(
					float(target.get("impact", 0.0)),
					clampf(absf(velocity) * 2.8, 0.16, 0.72)
				)
			target["z"] = next_z
			target["velocity"] = clampf(
				velocity,
				-ABACUS_BEAD_MAX_SPEED,
				ABACUS_BEAD_MAX_SPEED
			)

		_resolve_abacus_bead_collisions(row_targets)
		for target in row_targets:
			var pivot := target.node as Node3D
			if pivot == null:
				continue
			var previous_z := float(target.get("rendered_z", pivot.position.z))
			var next_z := float(target.z)
			pivot.position.z = next_z
			var rotation_angle := float(target.get("rotation_angle", pivot.rotation.z))
			rotation_angle -= (next_z - previous_z) / maxf(
				ABACUS_BEAD_COLLISION_RADIUS,
				0.001
			)
			target["rendered_z"] = next_z
			target["rotation_angle"] = rotation_angle
			pivot.rotation.z = wrapf(rotation_angle, -PI, PI)
			var impact := maxf(
				0.0,
				float(target.get("impact", 0.0))
				- ABACUS_BEAD_IMPACT_DECAY * frame_delta
			)
			target["impact"] = impact
			var impact_pivot := target.get("impact_pivot") as Node3D
			if impact_pivot != null:
				impact_pivot.scale = Vector3(
					1.0 + impact * 0.045,
					1.0 + impact * 0.035,
					1.0 - impact * 0.12
				)


func _resolve_abacus_bead_collisions(row_targets: Array[Dictionary]) -> void:
	var contact_distance := ABACUS_BEAD_COLLISION_RADIUS * 2.0
	for pass_index in row_targets.size():
		for index in row_targets.size() - 1:
			var left: Dictionary = row_targets[index]
			var right: Dictionary = row_targets[index + 1]
			var gap := float(right.z) - float(left.z)
			if gap >= contact_distance:
				continue
			var overlap := contact_distance - gap
			var left_active: bool = (
				abacus_bead_dragging
				and abacus_bead_targets[abacus_bead_drag_index].node == left.node
			)
			var right_active: bool = (
				abacus_bead_dragging
				and abacus_bead_targets[abacus_bead_drag_index].node == right.node
			)
			if left_active:
				var right_target := minf(
					float(right.z) + overlap,
					float(right.max_z)
				)
				var residual := float(right.z) + overlap - right_target
				right["z"] = right_target
				left["z"] = float(left.z) - residual
			elif right_active:
				var left_target := maxf(
					float(left.z) - overlap,
					float(left.min_z)
				)
				var residual := float(left.z) - overlap - left_target
				left["z"] = left_target
				right["z"] = float(right.z) - residual
			else:
				left["z"] = float(left.z) - overlap * 0.5
				right["z"] = float(right.z) + overlap * 0.5

			var relative_velocity := (
				float(right.get("velocity", 0.0))
				- float(left.get("velocity", 0.0))
			)
			if relative_velocity < 0.0:
				var impulse := (
					-(1.0 + ABACUS_BEAD_COLLISION_RESTITUTION)
					* relative_velocity
					* 0.5
				)
				left["velocity"] = clampf(
					float(left.get("velocity", 0.0)) - impulse,
					-ABACUS_BEAD_MAX_SPEED,
					ABACUS_BEAD_MAX_SPEED
				)
				right["velocity"] = clampf(
					float(right.get("velocity", 0.0)) + impulse,
					-ABACUS_BEAD_MAX_SPEED,
					ABACUS_BEAD_MAX_SPEED
				)
				var impact := clampf(absf(relative_velocity) * 5.5, 0.24, 1.0)
				left["impact"] = maxf(float(left.get("impact", 0.0)), impact)
				right["impact"] = maxf(float(right.get("impact", 0.0)), impact)

		for target in row_targets:
			var min_z := float(target.min_z)
			var max_z := float(target.max_z)
			var clamped_z := clampf(float(target.z), min_z, max_z)
			if not is_equal_approx(clamped_z, float(target.z)):
				var velocity := float(target.get("velocity", 0.0))
				if (
					(clamped_z <= min_z and velocity < 0.0)
					or (clamped_z >= max_z and velocity > 0.0)
				):
					velocity = -velocity * ABACUS_BEAD_END_RESTITUTION
				target["velocity"] = velocity
				target["z"] = clamped_z
				target["impact"] = maxf(
					float(target.get("impact", 0.0)),
					0.18
				)


func _finish_abacus_bead_drag() -> void:
	var advanced_story_bead := false
	if (
		abacus_bead_dragging
		and abacus_bead_drag_index >= 0
		and abacus_bead_drag_index < abacus_bead_targets.size()
	):
		var target: Dictionary = abacus_bead_targets[abacus_bead_drag_index]
		var pivot := target.node as Node3D
		if pivot != null:
			var release_velocity := (
				abacus_bead_drag_target_z - pivot.position.z
			) * ABACUS_BEAD_RELEASE_GAIN
			if absf(release_velocity) > absf(float(target.get("velocity", 0.0))):
				target["velocity"] = clampf(
					release_velocity,
					-ABACUS_BEAD_MAX_SPEED,
					ABACUS_BEAD_MAX_SPEED
				)
			if (
				current_3d_scene == "merchant"
				and story_action_phase == "merchant_bead"
				and abacus_bead_drag_index == story_merchant_bead_index
				and absf(float(target.get("z", pivot.position.z)) - pivot.position.z) > 0.012
			):
				advanced_story_bead = true
	abacus_bead_dragging = false
	abacus_bead_drag_index = -1
	abacus_bead_hover_index = -1
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if advanced_story_bead:
		_advance_merchant_bead_guide()


func _pick_prop_feedback_target(screen_position: Vector2) -> int:
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var planet_hit := INF
	var planet_base_root := model_3d.find_child("PlanetBase", true, false)
	if planet_base_root != null:
		var planet_meshes := planet_base_root.find_children("*", "MeshInstance3D", true, false)
		if not planet_meshes.is_empty():
			var planet_mesh := planet_meshes[0] as MeshInstance3D
			var planet_bounds := planet_mesh.global_transform * planet_mesh.get_aabb()
			var planet_radius := minf(
				planet_bounds.size.x,
				minf(planet_bounds.size.y, planet_bounds.size.z)
			) * 0.5
			planet_hit = _ray_sphere_distance(
				ray_origin,
				ray_direction,
				planet_bounds.get_center(),
				planet_radius
			)
	var best_index := -1
	var best_distance := INF
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		if not _supports_prop_feedback(String(record.kind)):
			continue
		var node := record.node as Node3D
		if node == null or not node.visible:
			continue
		var bounds := _editable_world_bounds(node)
		if bounds.size == Vector3.ZERO:
			continue
		var object_center := bounds.get_center()
		var screen_point := camera_3d.unproject_position(object_center)
		var horizontal_radius := camera_3d.unproject_position(
			object_center + camera_3d.global_basis.x * bounds.size.x * 0.5
		).distance_to(screen_point)
		var vertical_radius := camera_3d.unproject_position(
			object_center + camera_3d.global_basis.y * bounds.size.y * 0.5
		).distance_to(screen_point)
		var screen_radius := maxf(horizontal_radius, vertical_radius)
		var hit_radius := clampf(maxf(24.0, screen_radius * 0.92), 24.0, 96.0)
		var screen_distance := screen_point.distance_to(screen_position)
		if screen_distance > hit_radius:
			continue
		var center_distance := (object_center - ray_origin).dot(ray_direction)
		if planet_hit < INF and center_distance > planet_hit + 1.1:
			continue
		if screen_distance < best_distance:
			best_distance = screen_distance
			best_index = index
	return best_index


func _supports_prop_feedback(kind: String) -> bool:
	if current_3d_scene == "merchant":
		return kind in MERCHANT_TREE_JELLY_KINDS
	if current_3d_scene == "rose":
		return (
			kind in ROSE_JELLY_KINDS
			and kind not in ROSE_JELLY_EXCLUDED_KINDS
		)
	return kind in CLICK_FEEDBACK_KINDS


func _update_prince_chair(delta: float) -> void:
	if current_3d_scene != "pointlighter" or chair_3d == null:
		return
	if chair_state == "floating" and chair_3d.visible:
		var bob := sin(atmosphere_time * 1.55) * 0.055
		var sway := Basis(Vector3.UP, sin(atmosphere_time * 0.83) * 0.055)
		chair_3d.transform = Transform3D(
			chair_float_transform.basis * sway,
			chair_float_transform.origin + Vector3(0.0, bob, 0.0)
		)
	if not prince_sitting:
		return
	prince_fade_progress = minf(1.0, prince_fade_progress + delta / 1.15)
	var eased := prince_fade_progress * prince_fade_progress * (3.0 - 2.0 * prince_fade_progress)
	_set_model_alpha(standing_prince_3d, 1.0 - eased)
	_set_model_alpha(seated_prince_3d, eased)
	if prince_fade_progress < 1.0:
		return
	prince_sitting = false
	if standing_prince_3d != null:
		standing_prince_3d.visible = false
	if seated_prince_3d != null:
		seated_prince_3d.visible = true
		_set_model_alpha(seated_prince_3d, 1.0)
	chair_state = "seated"
	_mark_memory_available("pointlighter", 1.0)
	chair_subtitle_label.text = "灯还亮着。他终于也坐了下来。"
	chair_subtitle_label.visible = true
	chair_status_label.text = "夜色第一次没有催促任何人。"
	await get_tree().create_timer(5.2).timeout
	if chair_state == "seated":
		chair_subtitle_label.visible = false
		chair_status_label.visible = false


func _update_3d_interaction_ui() -> void:
	if (
		chair_action_button == null
		or chair_3d == null
		or camera_3d == null
		or stage_3d == null
		or not stage_3d.visible
	):
		return
	_update_player_character_interaction_buttons()
	_update_player_expression_popups()
	var show_scene_title := not dialogue_active and not king_ritual_active
	if hud_scene_title_plate != null:
		hud_scene_title_plate.visible = show_scene_title
	if hud_scene_kicker != null:
		hud_scene_kicker.visible = show_scene_title
	if hud_scene_title != null:
		hud_scene_title.visible = show_scene_title
	if current_3d_scene == "king":
		if chair_action_button != null:
			chair_action_button.visible = false
		if chair_target_marker != null:
			chair_target_marker.visible = false
		if chair_status_label != null:
			chair_status_label.visible = false
		if chair_subtitle_label != null:
			chair_subtitle_label.visible = false
		if editor_edit_button != null:
			editor_edit_button.visible = SHOW_LAYOUT_BUTTON and not dialogue_active and not king_ritual_active
		var can_talk_to_king := (
			not dialogue_active
			and not editor_active
			and not king_dialogue_complete
			and not king_ritual_active
			and king_character_3d != null
		)
		if lamp_dialogue_trigger != null:
			lamp_dialogue_trigger.tooltip_text = ""
			lamp_dialogue_trigger.visible = can_talk_to_king
			if can_talk_to_king:
				var character_bounds := _editable_world_bounds(king_character_3d)
				var head_world := (
					character_bounds.get_center()
					+ Vector3.UP * character_bounds.size.y * 0.38
				)
				var trigger_screen := camera_3d.unproject_position(head_world)
				lamp_dialogue_trigger.position = trigger_screen + Vector2(-103, -52)
		return
	if current_3d_scene in STORY_SCENE_SLUGS:
		if chair_action_button != null:
			chair_action_button.visible = false
		if chair_target_marker != null:
			chair_target_marker.visible = false
		if chair_status_label != null:
			chair_status_label.visible = false
		if chair_subtitle_label != null:
			chair_subtitle_label.visible = false
		return
	if current_3d_scene != "pointlighter":
		if chair_action_button != null:
			chair_action_button.visible = false
		if chair_target_marker != null:
			chair_target_marker.visible = false
		if chair_status_label != null:
			chair_status_label.visible = false
		if chair_subtitle_label != null:
			chair_subtitle_label.visible = false
		if lamp_dialogue_trigger != null:
			lamp_dialogue_trigger.visible = false
		if editor_edit_button != null:
			editor_edit_button.visible = SHOW_LAYOUT_BUTTON and current_3d_scene != "player"
		return
	if editor_edit_button != null:
		editor_edit_button.visible = SHOW_LAYOUT_BUTTON and not dialogue_active and not chair_dragging
	var allow_chair := not dialogue_active and not editor_active
	var action_visible := false
	if chair_state == "floating" and allow_chair:
		chair_action_button.set_arrow_angle(-90.0)
		chair_action_button.tooltip_text = ""
		action_visible = true
	elif chair_state == "placed" and allow_chair:
		chair_action_button.set_arrow_angle(90.0)
		chair_action_button.tooltip_text = ""
		action_visible = true
	chair_action_button.visible = action_visible
	if action_visible:
		var chair_up := chair_3d.global_transform.basis.y.normalized()
		var chair_screen := camera_3d.unproject_position(
			chair_3d.global_position + chair_up * 0.55
		)
		chair_action_button.position = chair_screen - chair_action_button.size * 0.5 + Vector2(0, -20)
	if chair_state == "dragging":
		var target_world := model_3d.global_transform * chair_target_transform.origin
		var target_screen := camera_3d.unproject_position(target_world)
		chair_target_marker.visible = true
		chair_target_marker.position = target_screen - chair_target_marker.size * 0.5
	else:
		chair_target_marker.visible = false
	chair_status_label.visible = false
	if chair_state == "floating":
		chair_status_label.text = "小王子搬来了一把椅子 | 拖到点灯人身边"
	elif chair_state == "dragging":
		chair_status_label.text = "拖到金色标记附近，再松开"

	var can_talk := (
		not dialogue_active
		and not editor_active
		and not prince_sitting
		and chair_state in ["hidden", "placed"]
		and lamplighter_3d != null
	)
	lamp_dialogue_trigger.tooltip_text = ""
	lamp_dialogue_trigger.visible = can_talk
	if can_talk:
		var character_bounds := _editable_world_bounds(lamplighter_3d)
		var head_world := character_bounds.get_center() + Vector3.UP * character_bounds.size.y * 0.42
		var trigger_screen := camera_3d.unproject_position(head_world)
		lamp_dialogue_trigger.position = trigger_screen + Vector2(-82, -50)


func _start_chair_sequence() -> void:
	if chair_state != "hidden" or chair_3d == null or dialogue_active:
		return
	chair_state = "floating"
	chair_3d.visible = true
	chair_3d.transform = chair_float_transform
	chair_3d.scale = chair_target_scale
	chair_status_label.visible = false
	chair_subtitle_label.visible = true
	chair_subtitle_label.text = "小王子搬来了一把椅子"
	await get_tree().create_timer(3.0).timeout
	if chair_state == "floating":
		chair_subtitle_label.visible = false


func _on_chair_action_pressed() -> void:
	if chair_state == "placed":
		_start_prince_sitting()


func _on_chair_action_button_down() -> void:
	if chair_state == "floating":
		_begin_chair_drag()


func _begin_chair_drag() -> void:
	if chair_state != "floating" or chair_3d == null:
		return
	chair_state = "dragging"
	chair_dragging = true
	chair_drag_distance = 0.0
	chair_action_button.visible = false
	chair_target_marker.visible = true
	chair_status_label.visible = false
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)


func _update_chair_drag(screen_position: Vector2) -> void:
	if chair_state != "dragging" or chair_3d == null:
		return
	var normal := _screen_position_to_planet_normal(screen_position)
	if normal == Vector3.ZERO:
		return
	var chair_index := _find_editable_record_index_by_kind("chair")
	if chair_index < 0:
		return
	var record: Dictionary = editable_3d_objects[chair_index]
	record["normal"] = normal
	record["root_radius"] = 2.35
	_apply_editable_3d_record(chair_index)


func _finish_chair_drag() -> void:
	if chair_state != "dragging" or chair_3d == null:
		return
	chair_dragging = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	var current_screen := camera_3d.unproject_position(chair_3d.global_position)
	var target_world := model_3d.global_transform * chair_target_transform.origin
	var target_screen := camera_3d.unproject_position(target_world)
	var close_enough := chair_drag_distance >= 8.0 and current_screen.distance_to(target_screen) < 115.0
	var chair_index := _find_editable_record_index_by_kind("chair")
	if close_enough and chair_index >= 0:
		var record: Dictionary = editable_3d_objects[chair_index]
		record["normal"] = chair_target_normal
		record["root_radius"] = chair_target_root_radius
		record["yaw"] = chair_target_yaw
		_apply_editable_3d_record(chair_index)
		chair_3d.transform = chair_target_transform
		chair_3d.scale = chair_target_scale
		chair_state = "placed"
		chair_status_label.text = "椅子放好了 | 让他也歇一会儿"
		return
	chair_state = "floating"
	chair_3d.transform = chair_float_transform
	chair_3d.scale = chair_target_scale
	chair_status_label.text = "再靠近金色标记一点，就能放稳"


func _start_prince_sitting() -> void:
	if (
		chair_state != "placed"
		or chair_3d == null
		or seated_prince_3d == null
		or standing_prince_3d == null
	):
		return
	if dialogue_active:
		_close_lamplighter_dialogue()
	seated_prince_3d.visible = true
	_set_model_alpha(seated_prince_3d, 0.0)
	prince_fade_progress = 0.0
	prince_sitting = true
	chair_state = "sitting"
	chair_subtitle_label.text = "小王子在星星边坐了下来。"
	chair_subtitle_label.visible = true
	chair_status_label.visible = false


func _build_dialogue_message(role: String, text: String, narration := "") -> void:
	if dialogue_scene == "player":
		_push_player_dialogue_bubble(role, text)
		return
	var entry := VBoxContainer.new()
	entry.add_theme_constant_override("separation", 8)
	entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var author := Label.new()
	if dialogue_scene == "player":
		author.text = "我" if role == "user" else "小王子"
	elif role == "user":
		author.text = "小王子"
	elif dialogue_scene == "king":
		author.text = "国王"
	else:
		author.text = String(
			STORY_DIALOGUE_DATA.SPEAKER_BY_SCENE.get(
				dialogue_scene,
				"星球居民"
			)
		)
	author.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	author.add_theme_constant_override("line_spacing", 1)
	author.add_theme_color_override(
		"font_color",
		Color(0.42, 0.25, 0.20, 0.96)
		if role != "user"
		else Color(0.18, 0.29, 0.34, 0.92)
	)
	entry.add_child(author)
	var body := Label.new()
	body.text = text
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body.custom_minimum_size = Vector2(0, 0)
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.add_theme_font_size_override("font_size", 24)
	body.add_theme_constant_override("line_spacing", 4)
	if body_font != null:
		body.add_theme_font_override("font", body_font)
	body.add_theme_color_override("font_color", Color(0.17, 0.13, 0.10, 1.0))
	entry.add_child(body)
	if narration != "":
		var note := Label.new()
		note.text = narration
		note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		note.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
		note.add_theme_constant_override("line_spacing", 1)
		if body_font != null:
			note.add_theme_font_override("font", body_font)
		note.add_theme_color_override("font_color", Color(0.29, 0.33, 0.35, 0.84))
		entry.add_child(note)
	dialogue_log.add_child(entry)
	_scroll_dialogue_to_bottom.call_deferred()


func _player_dialogue_bubble_font() -> Font:
	if body_font == null:
		return ThemeDB.fallback_font
	var bold := FontVariation.new()
	bold.base_font = body_font
	bold.variation_embolden = 0.75
	return bold


func _player_dialogue_bubble_width(text: String, font: Font) -> float:
	var measured := 0.0
	for line in text.split("\n"):
		measured = maxf(
			measured,
			font.get_string_size(
				line,
				HORIZONTAL_ALIGNMENT_LEFT,
				-1.0,
				UI_FONT_BODY
			).x
		)
	return clampf(
		measured + 70.0,
		PLAYER_DIALOGUE_BUBBLE_MIN_WIDTH,
		PLAYER_DIALOGUE_BUBBLE_MAX_WIDTH
	)


func _push_player_dialogue_bubble(role: String, text: String) -> void:
	if player_dialogue_bubble_root == null:
		return
	var clean_text := text.strip_edges().replace("\n\n", "\n")
	var bubble_font := _player_dialogue_bubble_font()
	var bubble_width := _player_dialogue_bubble_width(clean_text, bubble_font)
	var bubble := PanelContainer.new()
	bubble.name = "DialogueBubble%02d" % (
		Time.get_ticks_msec() % 1000
	)
	bubble.custom_minimum_size = Vector2(bubble_width, 0)
	bubble.size = Vector2(bubble_width, 56)
	bubble.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.025, 0.053, 0.112, 0.80)
	style.border_color = (
		Color(0.66, 0.80, 1.0, 0.42)
		if role == "user"
		else Color(0.94, 0.78, 0.48, 0.42)
	)
	style.set_border_width_all(1)
	style.set_corner_radius_all(20)
	style.shadow_color = Color(0.0, 0.01, 0.04, 0.46)
	style.shadow_size = 8
	style.content_margin_left = 18
	style.content_margin_right = 18
	style.content_margin_top = 10
	style.content_margin_bottom = 10
	bubble.add_theme_stylebox_override("panel", style)

	var stars := Control.new()
	stars.name = "BubbleStars"
	stars.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	stars.mouse_filter = Control.MOUSE_FILTER_IGNORE
	bubble.add_child(stars)
	var rng := RandomNumberGenerator.new()
	rng.seed = (
		player_dialogue_bubble_generation * 7919
		+ (31 if role == "user" else 73)
	)
	for star_index in 16:
		var star := ColorRect.new()
		star.name = "StarDot%02d" % (star_index + 1)
		star.mouse_filter = Control.MOUSE_FILTER_IGNORE
		star.color = (
			Color(0.78, 0.89, 1.0, rng.randf_range(0.34, 0.82))
			if star_index % 4 != 0
			else Color(1.0, 0.87, 0.61, rng.randf_range(0.32, 0.72))
		)
		var star_size := rng.randf_range(1.0, 2.2)
		star.anchor_left = rng.randf_range(0.04, 0.96)
		star.anchor_top = rng.randf_range(0.14, 0.86)
		star.anchor_right = star.anchor_left
		star.anchor_bottom = star.anchor_top
		star.offset_left = -star_size * 0.5
		star.offset_top = -star_size * 0.5
		star.offset_right = star_size * 0.5
		star.offset_bottom = star_size * 0.5
		stars.add_child(star)

	var row := HBoxContainer.new()
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_theme_constant_override("separation", 12)
	bubble.add_child(row)
	var accent := ColorRect.new()
	accent.color = (
		Color(0.33, 0.52, 0.66, 0.82)
		if role == "user"
		else Color(0.67, 0.46, 0.20, 0.86)
	)
	accent.custom_minimum_size = Vector2(4, 0)
	accent.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_child(accent)
	var copy := VBoxContainer.new()
	copy.add_theme_constant_override("separation", 2)
	copy.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(copy)
	var speaker := Label.new()
	speaker.name = "BubbleSpeaker"
	speaker.text = "我" if role == "user" else "小王子"
	speaker.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	speaker.add_theme_color_override(
		"font_color",
		Color(0.68, 0.82, 1.0, 0.98)
		if role == "user"
		else Color(1.0, 0.84, 0.55, 0.98)
	)
	speaker.add_theme_color_override(
		"font_shadow_color",
		Color(0.0, 0.0, 0.0, 0.52)
	)
	if bubble_font != null:
		speaker.add_theme_font_override("font", bubble_font)
	copy.add_child(speaker)
	var body := Label.new()
	body.name = "BubbleText"
	body.text = clean_text
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body.custom_minimum_size = Vector2(
		bubble_width - 70.0,
		0
	)
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.add_theme_font_size_override("font_size", UI_FONT_BODY)
	body.add_theme_constant_override("line_spacing", 1)
	body.add_theme_color_override(
		"font_color",
		Color(0.94, 0.96, 1.0, 1.0)
	)
	body.add_theme_color_override(
		"font_shadow_color",
		Color(0.0, 0.0, 0.0, 0.58)
	)
	if bubble_font != null:
		body.add_theme_font_override("font", bubble_font)
	copy.add_child(body)

	player_dialogue_bubble_root.add_child(bubble)
	player_dialogue_bubble_generation += 1
	player_dialogue_bubbles.append({
		"node": bubble,
		"role": role,
		"positioned": false,
		"generation": player_dialogue_bubble_generation,
	})
	bubble.modulate.a = 0.0
	bubble.scale = Vector2.ONE * 0.94
	bubble.pivot_offset = Vector2(bubble_width * 0.5, 28.0)
	var reveal := create_tween().set_parallel(true)
	reveal.tween_property(bubble, "modulate:a", 1.0, 0.20)
	reveal.tween_property(
		bubble,
		"scale",
		Vector2.ONE,
		0.24
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	while player_dialogue_bubbles.size() > PLAYER_DIALOGUE_BUBBLE_MAX:
		var oldest_value: Dictionary = player_dialogue_bubbles.pop_front()
		var oldest := oldest_value.get("node") as Control
		if oldest != null:
			var fade := create_tween()
			fade.tween_property(oldest, "modulate:a", 0.0, 0.22)
			fade.tween_callback(oldest.queue_free)
	_update_player_dialogue_bubbles(get_process_delta_time())


func _update_player_dialogue_bubbles(delta: float) -> void:
	if player_dialogue_bubble_root == null:
		return
	var bubble_mode := dialogue_active and dialogue_scene == "player"
	player_dialogue_bubble_root.visible = bubble_mode
	if not bubble_mode or player_dialogue_bubbles.is_empty():
		return
	var actor_screens := _player_dialogue_actor_screen_positions()
	if actor_screens.is_empty():
		return
	var viewport_size := get_viewport().get_visible_rect().size
	var panel_left := (
		dialogue_panel.get_global_rect().position.x
		if dialogue_panel != null
		else viewport_size.x
	)
	var anchor_y := minf(
		(actor_screens.get("user", Vector2(viewport_size.x * 0.3, 360.0)) as Vector2).y,
		(actor_screens.get("npc", Vector2(viewport_size.x * 0.4, 360.0)) as Vector2).y
	) - 14.0
	var cursor_y := anchor_y
	for index in range(player_dialogue_bubbles.size() - 1, -1, -1):
		var bubble_data: Dictionary = player_dialogue_bubbles[index]
		var bubble := bubble_data.get("node") as Control
		if bubble == null or not is_instance_valid(bubble):
			continue
		var role := String(bubble_data.get("role", "npc"))
		var actor_screen: Vector2 = actor_screens.get(
			role,
			Vector2(viewport_size.x * 0.4, 360.0)
		)
		var bubble_width := maxf(
			bubble.size.x,
			bubble.get_combined_minimum_size().x
		)
		var center_min := bubble_width * 0.5 + 22.0
		var center_max := minf(
			viewport_size.x - bubble_width * 0.5 - 22.0,
			panel_left - bubble_width * 0.5 - 28.0
		)
		var desired_center_x := clampf(
			actor_screen.x,
			center_min,
			center_max
		)
		var bubble_height := maxf(
			maxf(bubble.size.y, bubble.get_combined_minimum_size().y),
			54.0
		)
		var target := Vector2(
			desired_center_x - bubble_width * 0.5,
			cursor_y - bubble_height
		)
		target.y = maxf(target.y, 4.0)
		var positioned := bool(bubble_data.get("positioned", false))
		if positioned:
			var weight := 1.0 - exp(-maxf(delta, 0.001) * 16.0)
			bubble.position = bubble.position.lerp(target, weight)
		else:
			bubble.position = target
			bubble_data["positioned"] = true
		cursor_y = target.y - 9.0


func _player_dialogue_actor_screen_positions() -> Dictionary:
	if camera_3d == null:
		return {}
	var screens: Dictionary = {}
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	for item in [
		{"role": "user", "index": leader_index},
		{"role": "npc", "index": prince_index},
	]:
		var index := int(item.get("index", -1))
		if index < 0 or index >= editable_3d_objects.size():
			continue
		var node := editable_3d_objects[index].get("node") as Node3D
		if node == null or not is_instance_valid(node):
			continue
		var head_world := (
			_player_character_head_world_position(node)
			+ node.global_transform.basis.y.normalized() * 0.045
		)
		screens[String(item.get("role", ""))] = (
			camera_3d.unproject_position(head_world)
		)
	return screens


func _clear_player_dialogue_bubbles() -> void:
	for bubble_value in player_dialogue_bubbles:
		var bubble := bubble_value.get("node") as Control
		if bubble != null:
			bubble.queue_free()
	player_dialogue_bubbles.clear()
	player_dialogue_bubble_generation += 1
	if player_dialogue_bubble_root != null:
		player_dialogue_bubble_root.visible = false


func _set_player_dialogue_bubble_mode(enabled: bool) -> void:
	if dialogue_body_frame != null:
		dialogue_body_frame.visible = not enabled
	if player_dialogue_bubble_root != null:
		player_dialogue_bubble_root.visible = enabled
	if dialogue_panel != null:
		dialogue_panel.position = (
			Vector2(930, 145)
			if enabled
			else Vector2(930, 135)
		)
		dialogue_panel.size = (
			Vector2(615, 700)
			if enabled
			else Vector2(615, 805)
		)
	if enabled:
		if dialogue_heading != null:
			dialogue_heading.text = "*  想问小王子什么？"
	else:
		_set_player_dialogue_lights_active(false)
		_clear_player_dialogue_bubbles()


func _fit_player_dialogue_panel_to_choices() -> void:
	if (
		not dialogue_active
		or dialogue_scene != "player"
		or dialogue_panel == null
		or dialogue_choices == null
	):
		return
	await get_tree().process_frame
	if (
		not dialogue_active
		or dialogue_scene != "player"
		or dialogue_panel == null
		or dialogue_choices == null
	):
		return
	var choice_height := dialogue_choices.get_combined_minimum_size().y
	dialogue_panel.size.y = clampf(236.0 + choice_height, 330.0, 700.0)


func _scroll_dialogue_to_bottom() -> void:
	if dialogue_scroll == null:
		return
	await get_tree().process_frame
	if dialogue_scroll != null:
		dialogue_scroll.scroll_vertical = int(dialogue_scroll.get_v_scroll_bar().max_value)


func _active_dialogue_nodes() -> Dictionary:
	if dialogue_scene == "king":
		return KING_DIALOGUE_NODES
	if dialogue_scene == "player":
		return PLAYER_PRINCE_DIALOGUE_DATA.NODES
	return STORY_DIALOGUE_DATA.NODES_BY_SCENE.get(dialogue_scene, {})


func _default_dialogue_text_slot() -> Dictionary:
	return {
		"x": DIALOGUE_TEXT_DEFAULT_RECT.position.x,
		"y": DIALOGUE_TEXT_DEFAULT_RECT.position.y,
		"width": DIALOGUE_TEXT_DEFAULT_RECT.size.x,
		"height": DIALOGUE_TEXT_DEFAULT_RECT.size.y,
		"font_size": DIALOGUE_TEXT_DEFAULT_FONT_SIZE,
		"horizontal_alignment": HORIZONTAL_ALIGNMENT_LEFT,
		"vertical_alignment": VERTICAL_ALIGNMENT_CENTER,
		"line_spacing": DIALOGUE_TEXT_DEFAULT_LINE_SPACING,
	}


func _load_dialogue_text_layout() -> void:
	dialogue_text_slots.clear()
	var layout_path := DIALOGUE_TEXT_USER_LAYOUT_PATH
	if not FileAccess.file_exists(layout_path):
		layout_path = DIALOGUE_TEXT_LAYOUT_PATH
	var saved_slots: Array = []
	var layout_version := 1
	if FileAccess.file_exists(layout_path):
		var file := FileAccess.open(layout_path, FileAccess.READ)
		if file != null:
			var parsed = JSON.parse_string(file.get_as_text())
			file.close()
			if typeof(parsed) == TYPE_DICTIONARY:
				layout_version = int(parsed.get("version", 1))
				var values = parsed.get("slots", [])
				if typeof(values) == TYPE_ARRAY:
					saved_slots = values
	var slot_count := maxi(4, saved_slots.size())
	for slot_index in slot_count:
		var slot := _default_dialogue_text_slot()
		if slot_index < saved_slots.size():
			var saved = saved_slots[slot_index]
			if typeof(saved) == TYPE_DICTIONARY:
				slot.x = float(saved.get("x", slot.x))
				slot.y = float(saved.get("y", slot.y))
				slot.width = maxf(80.0, float(saved.get("width", slot.width)))
				slot.height = maxf(24.0, float(saved.get("height", slot.height)))
				slot.font_size = clampi(
					int(saved.get("font_size", slot.font_size)),
					UI_FONT_CAPTION,
					36
				)
				slot.horizontal_alignment = clampi(
					int(saved.get(
						"horizontal_alignment",
						slot.horizontal_alignment
					)),
					HORIZONTAL_ALIGNMENT_LEFT,
					HORIZONTAL_ALIGNMENT_RIGHT
				)
				slot.vertical_alignment = clampi(
					int(saved.get(
						"vertical_alignment",
						slot.vertical_alignment
					)),
					VERTICAL_ALIGNMENT_TOP,
					VERTICAL_ALIGNMENT_BOTTOM
				)
				slot.line_spacing = clampi(
					int(saved.get("line_spacing", slot.line_spacing)),
					-20,
					30
				)
				# Version 6 tightens the question group into the ruled frame
				# while preserving each slot's horizontal center and Y anchor.
				if layout_version < 6:
					if slot.font_size <= 20:
						slot.font_size = DIALOGUE_TEXT_DEFAULT_FONT_SIZE
					slot.line_spacing = DIALOGUE_TEXT_DEFAULT_LINE_SPACING
					slot.x = DIALOGUE_TEXT_DEFAULT_RECT.position.x
					slot.width = DIALOGUE_TEXT_DEFAULT_RECT.size.x
					slot.height = clampf(float(slot.height), 40.0, 56.0)
				if layout_version < 7 and slot.font_size <= 22:
					slot.font_size = DIALOGUE_TEXT_DEFAULT_FONT_SIZE
		dialogue_text_slots.append(slot)


func _save_dialogue_text_layout(announce := true) -> bool:
	var payload := JSON.stringify({
		"version": 7,
		"description": "Dialogue choice text boxes. Edit in game with the 调字 button.",
		"slots": dialogue_text_slots,
	}, "\t")
	var saved_targets: Array[String] = []
	for path in [DIALOGUE_TEXT_USER_LAYOUT_PATH, DIALOGUE_TEXT_LAYOUT_PATH]:
		var file := FileAccess.open(path, FileAccess.WRITE)
		if file != null:
			file.store_string(payload)
			file.close()
			saved_targets.append(
				"用户设置" if path == DIALOGUE_TEXT_USER_LAYOUT_PATH else "项目文件"
			)
	if dialogue_text_status != null and announce:
		dialogue_text_status.text = (
			"文字位置已保存：%s" % "、".join(PackedStringArray(saved_targets))
			if not saved_targets.is_empty()
			else "保存失败：%s" % error_string(FileAccess.get_open_error())
		)
	return not saved_targets.is_empty()


func _select_dialogue_text_box(slot_index: int) -> void:
	if dialogue_text_slots.is_empty():
		return
	selected_dialogue_text_index = clampi(
		slot_index,
		0,
		dialogue_text_widgets.size() - 1
	)
	for index in dialogue_text_widgets.size():
		var text_box := dialogue_text_widgets[index]
		text_box.set_selected(index == selected_dialogue_text_index)
	var slot := dialogue_text_slots[selected_dialogue_text_index]
	if dialogue_text_status != null:
		var alignment_name: String = String(
			["左齐", "居中", "右齐"][
				clampi(int(slot.horizontal_alignment), 0, 2)
			]
		)
		dialogue_text_status.text = (
			"第 %d 个文字框 | x %.0f  y %.0f  w %.0f  h %.0f | %s | 行距 %d"
			% [
				selected_dialogue_text_index + 1,
				float(slot.x),
				float(slot.y),
				float(slot.width),
				float(slot.height),
				alignment_name,
				int(slot.line_spacing),
			]
		)


func _on_dialogue_text_box_selected(slot_index: int) -> void:
	_select_dialogue_text_box(slot_index)


func _on_dialogue_text_box_layout_changed(slot_index: int) -> void:
	if slot_index < 0 or slot_index >= dialogue_text_widgets.size():
		return
	var text_box := dialogue_text_widgets[slot_index]
	if slot_index >= dialogue_text_slots.size():
		dialogue_text_slots.append(_default_dialogue_text_slot())
	var slot := dialogue_text_slots[slot_index]
	slot.x = text_box.position.x
	slot.y = text_box.position.y
	slot.width = text_box.size.x
	slot.height = text_box.size.y
	_sync_dialogue_choice_row_height(slot_index)
	_select_dialogue_text_box(slot_index)


func _sync_dialogue_choice_row_height(slot_index: int) -> void:
	if (
		slot_index < 0
		or slot_index >= dialogue_text_widgets.size()
		or slot_index >= dialogue_text_slots.size()
	):
		return
	var text_box := dialogue_text_widgets[slot_index]
	var button := text_box.get_parent() as Button
	if button == null:
		return
	var required_height: float = text_box.required_text_height()
	if text_box.size.y < required_height:
		text_box.size.y = required_height
		dialogue_text_slots[slot_index].height = required_height
	button.custom_minimum_size.y = maxf(
		46.0,
		text_box.position.y + text_box.size.y + 4.0
	)


func _adjust_dialogue_text_font(delta: int) -> void:
	if dialogue_text_slots.is_empty() or dialogue_text_widgets.is_empty():
		return
	var index := clampi(
		selected_dialogue_text_index,
		0,
		mini(dialogue_text_slots.size(), dialogue_text_widgets.size()) - 1
	)
	var slot := dialogue_text_slots[index]
	slot.font_size = clampi(
		int(slot.get("font_size", DIALOGUE_TEXT_DEFAULT_FONT_SIZE)) + delta,
		UI_FONT_CAPTION,
		36
	)
	dialogue_text_widgets[index].set_font_size(int(slot.font_size))
	_select_dialogue_text_box(index)


func _set_dialogue_text_alignment(alignment: int) -> void:
	if dialogue_text_slots.is_empty() or dialogue_text_widgets.is_empty():
		return
	var index := clampi(
		selected_dialogue_text_index,
		0,
		mini(dialogue_text_slots.size(), dialogue_text_widgets.size()) - 1
	)
	var slot := dialogue_text_slots[index]
	slot.horizontal_alignment = clampi(
		alignment,
		HORIZONTAL_ALIGNMENT_LEFT,
		HORIZONTAL_ALIGNMENT_RIGHT
	)
	dialogue_text_widgets[index].set_horizontal_alignment(
		int(slot.horizontal_alignment)
	)
	_select_dialogue_text_box(index)


func _adjust_dialogue_text_line_spacing(delta: int) -> void:
	if dialogue_text_slots.is_empty() or dialogue_text_widgets.is_empty():
		return
	var index := clampi(
		selected_dialogue_text_index,
		0,
		mini(dialogue_text_slots.size(), dialogue_text_widgets.size()) - 1
	)
	var slot := dialogue_text_slots[index]
	slot.line_spacing = clampi(
		int(slot.get("line_spacing", 0)) + delta,
		-20,
		30
	)
	dialogue_text_widgets[index].set_line_spacing(int(slot.line_spacing))
	_select_dialogue_text_box(index)


func _apply_dialogue_text_slot_style(index: int) -> void:
	if (
		index < 0
		or index >= dialogue_text_widgets.size()
		or index >= dialogue_text_slots.size()
	):
		return
	var slot := dialogue_text_slots[index]
	var text_box := dialogue_text_widgets[index]
	text_box.set_font_size(int(slot.font_size))
	text_box.set_horizontal_alignment(int(slot.horizontal_alignment))
	text_box.set_vertical_alignment(int(slot.vertical_alignment))
	text_box.set_line_spacing(int(slot.line_spacing))


func _reset_dialogue_text_boxes() -> void:
	for index in dialogue_text_slots.size():
		dialogue_text_slots[index] = _default_dialogue_text_slot()
	for index in dialogue_text_widgets.size():
		if index >= dialogue_text_slots.size():
			break
		var slot := dialogue_text_slots[index]
		var text_box := dialogue_text_widgets[index]
		text_box.position = Vector2(float(slot.x), float(slot.y))
		text_box.size = Vector2(float(slot.width), float(slot.height))
		_apply_dialogue_text_slot_style(index)
		var button := text_box.get_parent() as Button
		if button != null:
			button.custom_minimum_size.y = 46.0
	_select_dialogue_text_box(0)
	if dialogue_text_status != null:
		dialogue_text_status.text = "已恢复默认文字框；点“保存”可覆盖已有设置。"


func _set_dialogue_text_edit_mode(enabled: bool) -> void:
	if enabled and not dialogue_active:
		return
	dialogue_text_edit_active = enabled
	if dialogue_text_toolbar != null:
		dialogue_text_toolbar.visible = enabled
	if dialogue_text_edit_button != null:
		dialogue_text_edit_button.text = "完成" if enabled else "调字"
	if dialogue_choices != null:
		for child in dialogue_choices.get_children():
			var button := child as Button
			if button == null:
				continue
			button.disabled = enabled
			if enabled:
				button.add_theme_stylebox_override(
					"disabled",
					button.get_theme_stylebox("normal")
				)
	for index in dialogue_text_widgets.size():
		var text_box := dialogue_text_widgets[index]
		text_box.set_edit_mode(enabled)
		text_box.set_selected(enabled and index == selected_dialogue_text_index)
	if enabled:
		_select_dialogue_text_box(selected_dialogue_text_index)
	elif dialogue_text_status != null:
		dialogue_text_status.text = ""
		_save_dialogue_text_layout(false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _toggle_dialogue_text_edit_mode() -> void:
	_set_dialogue_text_edit_mode(not dialogue_text_edit_active)


func _render_dialogue_choices(node_id: String) -> void:
	var dialogue_nodes := _active_dialogue_nodes()
	if dialogue_choices == null or not dialogue_nodes.has(node_id):
		return
	dialogue_node_id = node_id
	for child in dialogue_choices.get_children():
		child.queue_free()
	dialogue_text_widgets.clear()
	var node: Dictionary = dialogue_nodes[node_id]
	for choice_value in node.get("choices", []):
		var choice := choice_value as Dictionary
		if (
			choice.has("id")
			and asked_dialogue_questions.has(String(choice.id))
		):
			continue
		var slot_index := dialogue_text_widgets.size()
		while dialogue_text_slots.size() <= slot_index:
			dialogue_text_slots.append(_default_dialogue_text_slot())
		var slot := dialogue_text_slots[slot_index]
		var button := Button.new()
		button.name = "ChoiceTextSlot%d" % (slot_index + 1)
		button.text = ""
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.custom_minimum_size = Vector2(
			0,
			maxf(46.0, float(slot.y) + float(slot.height) + 4.0)
		)
		_apply_paper_button_style(
			button,
			UI_CHOICE_STRIP,
			Vector4(30, 18, 30, 18),
			Vector4.ZERO,
			Color(0.30, 0.20, 0.13, 1.0)
		)
		button.tooltip_text = String(choice.get("label", ""))
		button.pressed.connect(_on_dialogue_choice.bind(choice))
		dialogue_choices.add_child(button)
		var text_box = EDITABLE_DIALOGUE_TEXT_SCRIPT.new()
		text_box.slot_index = slot_index
		button.add_child(text_box)
		text_box.configure(
			String(choice.get("label", "")),
			body_font,
			Rect2(
				Vector2(float(slot.x), float(slot.y)),
				Vector2(float(slot.width), float(slot.height))
			),
			int(slot.font_size)
		)
		text_box.set_horizontal_alignment(int(slot.horizontal_alignment))
		text_box.set_vertical_alignment(int(slot.vertical_alignment))
		text_box.set_line_spacing(int(slot.line_spacing))
		text_box.selection_requested.connect(_on_dialogue_text_box_selected)
		text_box.layout_changed.connect(_on_dialogue_text_box_layout_changed)
		text_box.set_edit_mode(dialogue_text_edit_active)
		dialogue_text_widgets.append(text_box)
		_sync_dialogue_choice_row_height(slot_index)
	if not dialogue_text_widgets.is_empty():
		selected_dialogue_text_index = clampi(
			selected_dialogue_text_index,
			0,
			dialogue_text_widgets.size() - 1
		)
		if dialogue_text_edit_active:
			_select_dialogue_text_box(selected_dialogue_text_index)
	if dialogue_scene == "player":
		_fit_player_dialogue_panel_to_choices.call_deferred()


func _start_current_dialogue() -> void:
	AudioDirector.play_sfx("ui_soft")
	if current_3d_scene == "earth" and earth_fox_inside_cave:
		await _walk_earth_fox_to_cave_entrance()
		if current_3d_scene != "earth" or earth_fox_exit_running:
			return
	if current_3d_scene == "player":
		_start_player_prince_dialogue()
	elif current_3d_scene == "king":
		_start_king_dialogue()
	elif current_3d_scene == "pointlighter":
		_start_lamplighter_dialogue()
	elif current_3d_scene in STORY_SCENE_SLUGS:
		_start_generated_story_dialogue(current_3d_scene)


func _dialogue_focus_nodes() -> Array[Node3D]:
	var nodes: Array[Node3D] = []
	if current_3d_scene == "king":
		if king_character_3d != null:
			nodes.append(king_character_3d)
		if king_prince_3d != null:
			nodes.append(king_prince_3d)
	elif current_3d_scene == "player":
		var leader_index := _get_active_player_character_index()
		var prince_index := _player_prince_record_index()
		if leader_index >= 0:
			var leader_node := (
				editable_3d_objects[leader_index].get("node") as Node3D
			)
			if leader_node != null:
				nodes.append(leader_node)
		if prince_index >= 0:
			var prince_node := (
				editable_3d_objects[prince_index].get("node") as Node3D
			)
			if prince_node != null:
				nodes.append(prince_node)
	elif current_3d_scene == "pointlighter":
		if lamplighter_3d != null:
			nodes.append(lamplighter_3d)
		if standing_prince_3d != null:
			nodes.append(standing_prince_3d)
	else:
		var npc := _story_anchor_node(current_3d_scene)
		if npc != null:
			nodes.append(npc)
		var prince := _story_node_by_kind("prince_character")
		if prince != null and prince != npc:
			nodes.append(prince)
	return nodes


func _player_character_head_world_position(node: Node3D) -> Vector3:
	if node == null or not is_instance_valid(node):
		return Vector3.ZERO
	var skeletons := node.find_children("*", "Skeleton3D", true, false)
	if not skeletons.is_empty():
		var skeleton := skeletons[0] as Skeleton3D
		var head_bone := skeleton.find_bone("Head")
		if head_bone >= 0:
			return (
				skeleton.global_transform
				* skeleton.get_bone_global_pose(head_bone).origin
			)
	var bounds := _editable_world_bounds(node)
	return (
		bounds.get_center()
		+ node.global_transform.basis.y.normalized()
			* bounds.size.y * 0.34
	)


func _begin_dialogue_camera_focus() -> void:
	if camera_3d == null or model_3d == null:
		return
	_restore_dialogue_camera(true)
	dragging_3d = false
	model_orbit_enabled = false
	model_spin_velocity = Vector2.ZERO
	var camera_generation := dialogue_generation
	var nodes := _dialogue_focus_nodes()
	var attempts := 0
	while (
		nodes.size() < 2
		and attempts < 180
		and dialogue_active
		and camera_generation == dialogue_generation
	):
		await get_tree().process_frame
		nodes = _dialogue_focus_nodes()
		attempts += 1
	if nodes.size() < 2 or camera_generation != dialogue_generation:
		return
	story_camera_saved_position = camera_3d.position
	story_camera_saved_focus = camera_focus_point
	story_camera_saved_distance = camera_distance
	story_camera_saved_h_offset = camera_3d.h_offset
	story_camera_saved_v_offset = camera_3d.v_offset
	story_camera_saved_up = camera_3d.global_basis.y.normalized()
	story_model_saved_position = model_3d.position
	story_model_saved_scale = model_3d.scale
	story_model_saved_quaternion = model_3d.quaternion.normalized()
	story_camera_focus_active = true

	# Dialogue always starts from the planet's authored initial composition.
	# Current orbit and zoom are restored after the conversation instead of
	# leaking an arbitrary player-controlled angle into the close-up.
	var target_scale := (
		story_model_saved_scale * NON_PLAYER_DIALOGUE_ZOOM_SCALE
	)
	if current_3d_scene == "player":
		target_scale = story_model_saved_scale
	var initial_camera_pose := _dialogue_initial_camera_pose()
	var initial_camera_position: Vector3 = initial_camera_pose.position
	var initial_camera_focus: Vector3 = initial_camera_pose.focus
	model_3d.quaternion = _get_initial_planet_orientation(
		current_3d_scene
	)
	model_3d.scale = target_scale
	var focus_center := Vector3.ZERO
	for node in nodes:
		focus_center += _editable_world_bounds(node).get_center()
	focus_center /= float(nodes.size())
	var target_camera_position := initial_camera_position
	var target_focus := initial_camera_focus
	var target_h_offset := 0.0
	var target_v_offset := 0.0
	var target_model_position := story_model_saved_position
	camera_3d.position = initial_camera_position
	camera_3d.h_offset = 0.0
	camera_3d.v_offset = 0.0
	camera_3d.look_at(initial_camera_focus)
	var target_camera_up := camera_3d.global_basis.y.normalized()
	var close_player_camera := current_3d_scene == "player"
	if close_player_camera:
		var dialogue_up := _dialogue_camera_up(nodes)
		var character_span := nodes[1].global_position - nodes[0].global_position
		character_span -= dialogue_up * character_span.dot(dialogue_up)
		var view_direction := dialogue_up.cross(character_span).normalized()
		var canonical_view := initial_camera_position - initial_camera_focus
		canonical_view -= dialogue_up * canonical_view.dot(dialogue_up)
		if view_direction.dot(canonical_view) < 0.0:
			view_direction = -view_direction
		if view_direction.length_squared() <= 0.000001:
			view_direction = (
				canonical_view
				- dialogue_up * canonical_view.dot(dialogue_up)
			).normalized()
		target_focus = focus_center + dialogue_up * PLAYER_DIALOGUE_CAMERA_LIFT
		target_camera_position = (
			target_focus
			+ view_direction * PLAYER_DIALOGUE_CLOSE_DISTANCE
		)
		camera_3d.position = target_camera_position
		camera_3d.look_at(target_focus, dialogue_up)
		target_camera_up = camera_3d.global_basis.y.normalized()
		_face_player_dialogue_characters_toward_camera(
			target_camera_position
		)
	var desired_screen := Vector2(
		470.0,
		get_viewport().get_visible_rect().size.y * 0.56
	)
	if close_player_camera:
		target_h_offset = _camera_h_offset_for_screen_x(
			focus_center,
			desired_screen.x
		)
		camera_3d.h_offset = target_h_offset
		target_v_offset = _camera_v_offset_for_screen_y(
			focus_center,
			desired_screen.y
		)
		camera_3d.v_offset = target_v_offset
	else:
		var screen_center := camera_3d.unproject_position(focus_center)
		var screen_delta := desired_screen - screen_center
		var right_point := camera_3d.unproject_position(
			focus_center + camera_3d.global_basis.x.normalized()
		)
		var pixels_per_right := right_point.x - screen_center.x
		if absf(pixels_per_right) < 0.001:
			pixels_per_right = 0.001
		var up_point := camera_3d.unproject_position(
			focus_center + camera_3d.global_basis.y.normalized()
		)
		var pixels_per_up := up_point.y - screen_center.y
		if absf(pixels_per_up) < 0.001:
			pixels_per_up = -0.001
		var model_shift := (
			camera_3d.global_basis.x.normalized()
			* (screen_delta.x / pixels_per_right)
			+ camera_3d.global_basis.y.normalized()
			* (screen_delta.y / pixels_per_up)
		)
		target_model_position = story_model_saved_position + model_shift
	if preview_mode_active:
		print(
			"QA_DIALOGUE_CAMERA=",
			"scene=", current_3d_scene,
			" focus_center=", focus_center,
			" screen=", camera_3d.unproject_position(focus_center),
			" model_shift=", target_model_position - story_model_saved_position,
			" h_offset=", target_h_offset,
			" v_offset=", target_v_offset,
			" model_scale=", target_scale
		)
	model_3d.quaternion = story_model_saved_quaternion
	model_3d.scale = story_model_saved_scale
	model_3d.position = story_model_saved_position
	camera_3d.position = story_camera_saved_position
	camera_focus_point = story_camera_saved_focus
	camera_3d.h_offset = story_camera_saved_h_offset
	camera_3d.v_offset = story_camera_saved_v_offset
	camera_3d.look_at(camera_focus_point, story_camera_saved_up)

	story_camera_from_position = story_camera_saved_position
	story_camera_to_position = target_camera_position
	story_camera_from_focus = story_camera_saved_focus
	story_camera_to_focus = target_focus
	story_camera_from_up = story_camera_saved_up
	story_camera_to_up = target_camera_up
	story_camera_from_h_offset = story_camera_saved_h_offset
	story_camera_to_h_offset = target_h_offset
	story_camera_from_v_offset = story_camera_saved_v_offset
	story_camera_to_v_offset = target_v_offset
	story_model_from_position = story_model_saved_position
	story_model_to_position = target_model_position
	story_model_from_scale = story_model_saved_scale
	story_model_to_scale = target_scale
	story_model_from_quaternion = story_model_saved_quaternion
	story_model_to_quaternion = _get_initial_planet_orientation(
		current_3d_scene
	)
	story_camera_tween_generation = dialogue_generation
	story_camera_tween = create_tween()
	story_camera_tween.tween_method(
		Callable(self, "_update_dialogue_camera_tween"),
		0.0,
		1.0,
		0.92
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)


func _dialogue_initial_camera_pose() -> Dictionary:
	var framing_offset := _get_planet_framing_offset(current_3d_scene)
	return {
		"focus": Vector3(
			0.0,
			PLANET_HOME_FOCUS_Y - framing_offset,
			0.0
		),
		"position": Vector3(
			0.0,
			PLANET_HOME_CAMERA_HEIGHT - framing_offset,
			PLANET_HOME_DISTANCE
		),
	}


func _dialogue_camera_up(nodes: Array[Node3D]) -> Vector3:
	var up := Vector3.ZERO
	for node in nodes:
		if node != null and is_instance_valid(node):
			up += node.global_transform.basis.y.normalized()
	if up.length_squared() <= 0.000001:
		return Vector3.UP
	up = up.normalized()
	return -up if up.dot(Vector3.UP) < 0.0 else up


func _camera_h_offset_for_screen_x(
	world_point: Vector3,
	desired_x: float
) -> float:
	if camera_3d == null:
		return 0.0
	var saved_offset := camera_3d.h_offset
	camera_3d.h_offset = 0.0
	var base_x := camera_3d.unproject_position(world_point).x
	camera_3d.h_offset = 1.0
	var shifted_x := camera_3d.unproject_position(world_point).x
	camera_3d.h_offset = saved_offset
	var slope := shifted_x - base_x
	if absf(slope) <= 0.0001:
		return saved_offset
	return (desired_x - base_x) / slope


func _camera_v_offset_for_screen_y(
	world_point: Vector3,
	desired_y: float
) -> float:
	if camera_3d == null:
		return 0.0
	var saved_offset := camera_3d.v_offset
	camera_3d.v_offset = 0.0
	var base_y := camera_3d.unproject_position(world_point).y
	camera_3d.v_offset = 1.0
	var shifted_y := camera_3d.unproject_position(world_point).y
	camera_3d.v_offset = saved_offset
	var slope := shifted_y - base_y
	if absf(slope) <= 0.0001:
		return saved_offset
	return (desired_y - base_y) / slope


func _update_dialogue_camera_tween(weight: float) -> void:
	if (
		not story_camera_focus_active
		or story_camera_tween_generation != dialogue_generation
	):
		return
	var eased := smoothstep(0.0, 1.0, weight)
	camera_focus_point = story_camera_from_focus.lerp(
		story_camera_to_focus,
		eased
	)
	camera_3d.position = story_camera_from_position.lerp(
		story_camera_to_position,
		eased
	)
	camera_3d.h_offset = lerpf(
		story_camera_from_h_offset,
		story_camera_to_h_offset,
		eased
	)
	camera_3d.v_offset = lerpf(
		story_camera_from_v_offset,
		story_camera_to_v_offset,
		eased
	)
	camera_3d.look_at(
		camera_focus_point,
		story_camera_from_up.slerp(story_camera_to_up, eased).normalized()
	)
	model_3d.position = story_model_from_position.lerp(
		story_model_to_position,
		eased
	)
	model_3d.scale = story_model_from_scale.lerp(
		story_model_to_scale,
		eased
	)
	model_3d.quaternion = (
		story_model_from_quaternion.slerp(
			story_model_to_quaternion,
			eased
		).normalized()
	)
	if preview_mode_active and weight >= 0.999:
		var preview_nodes := _dialogue_focus_nodes()
		if not preview_nodes.is_empty():
			var preview_focus := Vector3.ZERO
			for preview_node in preview_nodes:
				preview_focus += _editable_world_bounds(preview_node).get_center()
			preview_focus /= float(preview_nodes.size())
			print(
				"QA_DIALOGUE_CAMERA_FINAL=",
				camera_3d.unproject_position(preview_focus),
				" model_pos=", model_3d.position,
				" camera_pos=", camera_3d.position
			)
	camera_distance = camera_3d.position.distance_to(camera_focus_point)


func _maintain_dialogue_camera_focus() -> void:
	if (
		not story_camera_focus_active
		or not dialogue_active
		or camera_3d == null
		or model_3d == null
		or dialogue_scene != current_3d_scene
	):
		return
	if (
		story_camera_tween != null
		and story_camera_tween.is_valid()
		and story_camera_tween.is_running()
	):
		return
	# Planet loading and older view-reset callbacks can finish after the opening
	# tween. Reassert the final composition until the dialogue is closed.
	camera_3d.position = story_camera_to_position
	camera_focus_point = story_camera_to_focus
	camera_3d.h_offset = story_camera_to_h_offset
	camera_3d.v_offset = story_camera_to_v_offset
	camera_3d.look_at(camera_focus_point, story_camera_to_up)
	model_3d.position = story_model_to_position
	model_3d.scale = story_model_to_scale
	model_3d.quaternion = story_model_to_quaternion
	camera_distance = camera_3d.position.distance_to(camera_focus_point)
	story_camera_tween = null


func _restore_dialogue_camera(immediate := false) -> void:
	if not story_camera_focus_active or camera_3d == null:
		return
	if story_camera_tween != null and story_camera_tween.is_valid():
		story_camera_tween.kill()
	story_camera_tween = null
	if immediate:
		camera_3d.position = story_camera_saved_position
		camera_focus_point = story_camera_saved_focus
		camera_distance = story_camera_saved_distance
		camera_3d.h_offset = story_camera_saved_h_offset
		camera_3d.v_offset = story_camera_saved_v_offset
		camera_3d.look_at(camera_focus_point, story_camera_saved_up)
		if model_3d != null:
			model_3d.position = story_model_saved_position
			model_3d.scale = story_model_saved_scale
			model_3d.quaternion = story_model_saved_quaternion
		story_camera_focus_active = false
		return
	story_camera_from_position = camera_3d.position
	story_camera_to_position = story_camera_saved_position
	story_camera_from_focus = camera_focus_point
	story_camera_to_focus = story_camera_saved_focus
	story_camera_from_up = camera_3d.global_basis.y.normalized()
	story_camera_to_up = story_camera_saved_up
	story_camera_from_h_offset = camera_3d.h_offset
	story_camera_to_h_offset = story_camera_saved_h_offset
	story_camera_from_v_offset = camera_3d.v_offset
	story_camera_to_v_offset = story_camera_saved_v_offset
	story_model_from_position = (
		model_3d.position if model_3d != null else story_model_saved_position
	)
	story_model_to_position = story_model_saved_position
	story_model_from_scale = (
		model_3d.scale if model_3d != null else story_model_saved_scale
	)
	story_model_to_scale = story_model_saved_scale
	story_model_from_quaternion = (
		model_3d.quaternion.normalized()
		if model_3d != null
		else story_model_saved_quaternion
	)
	story_model_to_quaternion = story_model_saved_quaternion
	story_camera_tween_generation = dialogue_generation
	story_camera_tween = create_tween()
	story_camera_tween.tween_method(
		Callable(self, "_update_dialogue_camera_tween"),
		0.0,
		1.0,
		0.62
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	story_camera_tween.finished.connect(_finish_dialogue_camera_restore)


func _finish_dialogue_camera_restore() -> void:
	camera_distance = story_camera_saved_distance
	camera_focus_point = story_camera_saved_focus
	camera_3d.position = story_camera_saved_position
	camera_3d.h_offset = story_camera_saved_h_offset
	camera_3d.v_offset = story_camera_saved_v_offset
	camera_3d.look_at(camera_focus_point, story_camera_saved_up)
	if model_3d != null:
		model_3d.position = story_model_saved_position
		model_3d.scale = story_model_saved_scale
		model_3d.quaternion = story_model_saved_quaternion
	story_camera_focus_active = false


func _start_king_dialogue() -> void:
	if (
		current_3d_scene != "king"
		or dialogue_active
		or dialogue_panel == null
		or king_dialogue_complete
	):
		return
	if editor_active:
		_toggle_3d_editor()
	dialogue_scene = "king"
	_set_player_dialogue_bubble_mode(false)
	dialogue_active = true
	dialogue_busy = false
	dialogue_generation += 1
	dialogue_node_id = "intro"
	asked_dialogue_questions.clear()
	lamp_dialogue_trigger.visible = false
	dialogue_panel.visible = true
	dialogue_panel.modulate.a = 1.0
	dialogue_heading.text = "*  国王"
	AudioDirector.set_dialogue_duck(true)
	_begin_dialogue_camera_focus()
	for child in dialogue_log.get_children():
		child.queue_free()
	for child in dialogue_choices.get_children():
		child.queue_free()
	var intro: Dictionary = KING_DIALOGUE_NODES.intro
	_build_dialogue_message("king", String(intro.text))
	_render_dialogue_choices("intro")


func _start_lamplighter_dialogue() -> void:
	if dialogue_active or dialogue_panel == null or chair_state not in ["hidden", "placed", "seated"]:
		return
	if editor_active:
		_toggle_3d_editor()
	dialogue_scene = "pointlighter"
	_set_player_dialogue_bubble_mode(false)
	dialogue_active = true
	dialogue_busy = false
	dialogue_generation += 1
	dialogue_node_id = "intro"
	asked_dialogue_questions.clear()
	lamp_dialogue_trigger.visible = false
	dialogue_panel.visible = true
	dialogue_panel.modulate.a = 1.0
	dialogue_heading.text = "*  点灯人"
	AudioDirector.set_dialogue_duck(true)
	_begin_dialogue_camera_focus()
	_play_lamplighter_reaction("agree_001")
	for child in dialogue_log.get_children():
		child.queue_free()
	for child in dialogue_choices.get_children():
		child.queue_free()
	var intro: Dictionary = DIALOGUE_NODES.intro
	_build_dialogue_message("point", String(intro.text))
	_render_dialogue_choices("intro")


func _start_player_prince_dialogue() -> void:
	if (
		current_3d_scene != "player"
		or dialogue_active
		or dialogue_panel == null
		or _get_active_player_character_index() < 0
		or _player_prince_record_index() < 0
	):
		return
	if editor_active:
		_toggle_3d_editor()
	if player_navigation_active:
		_cancel_player_navigation(false)
	if player_handhold_active:
		_release_player_handhold()
	_close_player_character_interaction()
	_close_player_prince_interaction()
	player_prince_look_generation += 1
	player_prince_look_active = false
	dialogue_scene = "player"
	_set_player_dialogue_bubble_mode(true)
	dialogue_active = true
	_update_player_character_interaction_buttons()
	dialogue_busy = false
	dialogue_generation += 1
	dialogue_node_id = "intro"
	asked_dialogue_questions.clear()
	if lamp_dialogue_trigger != null:
		lamp_dialogue_trigger.visible = false
	_clear_player_dialogue_bubbles()
	if not _stage_player_prince_dialogue():
		_set_player_dialogue_lights_active(false)
		dialogue_active = false
		dialogue_scene = ""
		dialogue_generation += 1
		return
	_set_player_dialogue_lights_active(true)
	dialogue_panel.visible = true
	dialogue_panel.modulate.a = 1.0
	dialogue_heading.text = "*  想问小王子什么？"
	AudioDirector.set_dialogue_duck(true)
	_begin_dialogue_camera_focus()
	if hud_scene_hint != null:
		hud_scene_hint.text = ""
	_clear_story_action_ui()
	for child in dialogue_log.get_children():
		child.queue_free()
	for child in dialogue_choices.get_children():
		child.queue_free()
	_render_dialogue_choices("intro")


func _stage_player_prince_dialogue() -> bool:
	if player_dialogue_stage_active:
		return true
	if (
		current_3d_scene != "player"
		or camera_3d == null
		or model_3d == null
	):
		return false
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if (
		leader_index < 0
		or prince_index < 0
		or leader_index == prince_index
	):
		return false
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	var prince_record: Dictionary = editable_3d_objects[prince_index]
	var leader_id := String(leader_record.get("id", ""))
	var prince_id := String(prince_record.get("id", ""))
	if leader_id.is_empty() or prince_id.is_empty():
		return false
	player_dialogue_stage_saved = {
		"leader_id": leader_id,
		"prince_id": prince_id,
		"records": {
			leader_id: leader_record.duplicate(),
			prince_id: prince_record.duplicate(),
		},
	}
	player_dialogue_stage_active = true
	return true


func _face_player_dialogue_characters_toward_camera(
	camera_position: Vector3
) -> void:
	if not player_dialogue_stage_active:
		return
	for id_key in ["leader_id", "prince_id"]:
		var record_id := String(player_dialogue_stage_saved.get(id_key, ""))
		var index := _find_editable_record_index(record_id, -1)
		if index < 0:
			continue
		var record: Dictionary = editable_3d_objects[index]
		var normal := _align_player_surface_normal(
			record.get(
				"placement_plane_normal",
				player_placement_plane_normal
			)
		)
		var world_position := model_3d.global_transform * (
			record.get("position", Vector3.ZERO) as Vector3
		)
		var camera_direction := (
			model_3d.global_transform.basis.inverse()
			* (camera_position - world_position)
		)
		record["yaw"] = _player_navigation_facing_yaw(
			camera_direction,
			normal
		)
		_apply_editable_3d_record(index)


func _restore_player_prince_dialogue_staging() -> void:
	if not player_dialogue_stage_active:
		return
	player_dialogue_stage_active = false
	var saved_records_value = player_dialogue_stage_saved.get("records", {})
	var saved_records: Dictionary = (
		saved_records_value
		if typeof(saved_records_value) == TYPE_DICTIONARY
		else {}
	)
	for record_id_value in saved_records.keys():
		var record_id := String(record_id_value)
		var index := _find_editable_record_index(record_id, -1)
		if index < 0:
			continue
		var record: Dictionary = editable_3d_objects[index]
		var snapshot_value = saved_records[record_id]
		if typeof(snapshot_value) != TYPE_DICTIONARY:
			continue
		var snapshot: Dictionary = snapshot_value
		for key in snapshot.keys():
			if String(key) == "node":
				continue
			record[key] = snapshot[key]
		_apply_editable_3d_record(index)
		var node := record.get("node") as Node3D
		var resume_animation := String(
			record.get("selected_animation", "ambient_idle")
		)
		if not resume_animation.is_empty():
			_apply_character_animation_choice(
				node,
				resume_animation,
				true
			)
	_restore_player_character_seating()
	player_dialogue_stage_saved.clear()


func _start_generated_story_dialogue(slug: String) -> void:
	if (
		slug not in STORY_SCENE_SLUGS
		or current_3d_scene != slug
		or dialogue_active
		or dialogue_panel == null
	):
		return
	if editor_active:
		_toggle_3d_editor()
	dialogue_scene = slug
	_set_player_dialogue_bubble_mode(false)
	dialogue_active = true
	dialogue_busy = false
	dialogue_generation += 1
	if slug == "earth":
		_begin_earth_fox_dialogue_idle_cycle()
		var prince := _story_node_by_kind("prince_character")
		if prince != null:
			_set_prince_idle_head_tilt(
				prince,
				EARTH_FOX_DIALOGUE_PRINCE_HEAD_TILT_DEGREES
			)
	dialogue_node_id = "intro"
	asked_dialogue_questions.clear()
	lamp_dialogue_trigger.visible = false
	dialogue_panel.visible = true
	dialogue_panel.modulate.a = 1.0
	dialogue_heading.text = "*  " + String(
		STORY_DIALOGUE_DATA.TITLE_BY_SCENE.get(slug, slug)
	)
	AudioDirector.set_dialogue_duck(true)
	_begin_dialogue_camera_focus()
	hud_scene_hint.text = ""
	_clear_story_action_ui()
	if slug == "rose":
		_begin_rose_dialogue_animation()
	for child in dialogue_log.get_children():
		child.queue_free()
	for child in dialogue_choices.get_children():
		child.queue_free()
	var nodes: Dictionary = STORY_DIALOGUE_DATA.NODES_BY_SCENE.get(slug, {})
	if not nodes.has("intro"):
		_close_active_dialogue(false)
		return
	var intro: Dictionary = nodes.intro
	_build_dialogue_message("npc", String(intro.text))
	if slug == "vain":
		_begin_vain_dialogue_intro_transition(intro)
	else:
		_play_story_dialogue_reaction(intro, "intro")
	_render_dialogue_choices("intro")


func _on_dialogue_choice(choice: Dictionary) -> void:
	if dialogue_busy or not dialogue_active:
		return
	AudioDirector.play_sfx("dialogue_choice")
	var action := String(choice.get("action", ""))
	if action == "close":
		_close_active_dialogue(false)
		return
	if action == "begin_king_ritual":
		_close_king_dialogue(true)
		_begin_king_ritual()
		return
	if action in [
		"begin_rose_wipe",
		"begin_vain_applause",
		"begin_merchant_tally",
		"begin_fox_sunset",
	]:
		var slug := dialogue_scene
		if slug not in STORY_SCENE_SLUGS:
			return
		var replaying_complete := (
			String(planet_story_states.get(slug, "new")) == "complete"
		)
		_close_generated_story_dialogue(false)
		_begin_planet_story_action(slug, replaying_complete)
		return
	var next_id := String(choice.get("next", ""))
	var dialogue_nodes := _active_dialogue_nodes()
	if not dialogue_nodes.has(next_id):
		return
	dialogue_busy = true
	_build_dialogue_message("user", String(choice.label))
	for child in dialogue_choices.get_children():
		child.queue_free()
	var generation := dialogue_generation
	await get_tree().create_timer(0.55).timeout
	if not dialogue_active or generation != dialogue_generation:
		return
	var next_node: Dictionary = dialogue_nodes[next_id]
	_build_dialogue_message(
		"npc",
		String(next_node.text),
		String(next_node.get("narration", ""))
	)
	_play_story_dialogue_reaction(next_node, next_id)
	if choice.has("id"):
		asked_dialogue_questions[String(choice.id)] = true
	dialogue_busy = false
	if bool(next_node.get("returns_to_menu", false)):
		_render_dialogue_choices("intro")
	else:
		_render_dialogue_choices(next_id)


func _begin_king_ritual() -> void:
	if current_3d_scene != "king" or king_ritual_active:
		return
	king_ritual_generation += 1
	king_ritual_active = true
	king_ritual_phase = "sunrise"
	king_dialogue_complete = false
	lamp_dialogue_trigger.visible = false
	editor_edit_button.visible = false
	if king_day_night_target >= 0.5:
		king_day_night_target = 0.0
		king_day_night_blend = 0.0
		king_celestial_target_rotation = king_celestial_rotation
		_apply_king_day_night(0.0)
	hud_scene_hint.text = ""
	king_ritual_subtitle.text = "点击太阳，让天慢慢亮起来"
	king_ritual_subtitle.visible = true
	king_sun_click_guide.visible = true


func _advance_king_ritual() -> void:
	if (
		not king_ritual_active
		or king_ritual_phase not in ["sunrise", "sunset"]
		or current_3d_scene != "king"
	):
		return
	AudioDirector.play_sfx("ui_primary")
	var generation := king_ritual_generation
	if king_ritual_phase == "sunrise":
		king_ritual_phase = "sunrise_turning"
		king_sun_click_guide.visible = false
		king_ritual_subtitle.text = "太阳正在升起……"
		_set_king_day_night_phase(true)
		await _wait_for_king_day_night_phase(true, generation)
		if not king_ritual_active or generation != king_ritual_generation:
			return
		king_ritual_phase = "sunset"
		king_ritual_subtitle.text = "再点一次太阳，让黑夜落下来"
		king_sun_click_guide.visible = true
		return
	king_ritual_phase = "sunset_turning"
	king_sun_click_guide.visible = false
	king_ritual_subtitle.text = "太阳正在落下……"
	_set_king_day_night_phase(false)
	await _wait_for_king_day_night_phase(false, generation)
	if not king_ritual_active or generation != king_ritual_generation:
		return
	king_ritual_phase = "complete"
	king_ritual_active = false
	king_dialogue_complete = true
	_mark_memory_available("king", 1.0)
	king_sun_click_guide.visible = false
	king_ritual_subtitle.text = (
		"一个完整的昼夜完成了。\n"
		+ "权力不是让世界停下，而是让每一次升落都有人回应。"
	)
	hud_scene_quote.text = "“权力不是让世界停下，而是让每一次升落都有人回应。”"
	hud_scene_hint.text = ""
	await get_tree().create_timer(5.0).timeout
	if generation == king_ritual_generation:
		king_ritual_subtitle.visible = false


func _wait_for_king_day_night_phase(daytime: bool, generation: int) -> void:
	var target := 1.0 if daytime else 0.0
	while king_ritual_active and generation == king_ritual_generation:
		var blend_ready := absf(king_day_night_blend - target) <= 0.002
		var rotation_ready := (
			absf(king_celestial_rotation - king_celestial_target_rotation) <= 0.002
		)
		if blend_ready and rotation_ready:
			return
		await get_tree().process_frame


func _update_king_ritual_ui() -> void:
	if current_3d_scene != "king" or not king_ritual_active:
		if king_sun_click_guide != null:
			king_sun_click_guide.visible = false
		return
	var waiting_for_click := king_ritual_phase in ["sunrise", "sunset"]
	king_sun_click_guide.visible = waiting_for_click and king_sun_root != null
	if not king_sun_click_guide.visible:
		return
	var sun_position := camera_3d.unproject_position(king_sun_root.global_position)
	if camera_3d.is_position_behind(king_sun_root.global_position):
		king_sun_click_guide.visible = false
		return
	var guide_position := sun_position + Vector2(54.0, 38.0)
	guide_position.x = clampf(guide_position.x, 20.0, 1540.0)
	guide_position.y = clampf(guide_position.y, 20.0, 930.0)
	king_sun_click_guide.position = guide_position
	var pulse := 1.0 + sin(atmosphere_time * 4.2) * 0.08
	king_sun_click_guide.scale = Vector2.ONE * pulse


func _close_active_dialogue(play_feedback := true) -> void:
	if play_feedback:
		AudioDirector.play_sfx("ui_soft")
	if dialogue_scene == "king":
		_close_king_dialogue()
	elif dialogue_scene == "pointlighter":
		_close_lamplighter_dialogue()
	else:
		_close_generated_story_dialogue()


func _close_king_dialogue(preserve_hud := false) -> void:
	if not dialogue_active:
		return
	AudioDirector.set_dialogue_duck(false)
	if dialogue_text_edit_active:
		_set_dialogue_text_edit_mode(false)
	dialogue_active = false
	dialogue_busy = false
	dialogue_generation += 1
	dialogue_panel.visible = false
	dialogue_scene = ""
	lamp_dialogue_trigger.visible = false
	_restore_dialogue_camera()
	if preserve_hud:
		return
	if king_dialogue_complete:
		hud_scene_quote.text = "“权力不是让世界停下，而是让每一次升落都有人回应。”"
		hud_scene_hint.text = ""
	else:
		hud_scene_quote.text = "“我命令你留下。这样，我的命令便终于有了对象。”"
		hud_scene_hint.text = ""


func _close_lamplighter_dialogue() -> void:
	if not dialogue_active:
		return
	AudioDirector.set_dialogue_duck(false)
	if dialogue_text_edit_active:
		_set_dialogue_text_edit_mode(false)
	var was_pointlighter := dialogue_scene == "pointlighter"
	dialogue_active = false
	dialogue_busy = false
	dialogue_generation += 1
	dialogue_panel.visible = false
	dialogue_scene = ""
	_restore_dialogue_camera()
	if was_pointlighter and chair_state == "hidden":
		await get_tree().create_timer(0.65).timeout
		if not dialogue_active and stage_3d != null and stage_3d.visible:
			_start_chair_sequence()


func _close_generated_story_dialogue(mark_dialogue_complete := false) -> void:
	if not dialogue_active:
		return
	AudioDirector.set_dialogue_duck(false)
	if dialogue_text_edit_active:
		_set_dialogue_text_edit_mode(false)
	var was_story_scene := dialogue_scene in STORY_SCENE_SLUGS
	var closed_scene := dialogue_scene
	_stop_earth_fox_dialogue_idle_cycle()
	if closed_scene == "earth":
		var prince := _story_node_by_kind("prince_character")
		if prince != null:
			_set_prince_idle_head_tilt(prince, 0.0)
	dialogue_active = false
	dialogue_busy = false
	dialogue_generation += 1
	dialogue_panel.visible = false
	dialogue_scene = ""
	lamp_dialogue_trigger.visible = false
	if closed_scene == "player":
		_set_player_dialogue_bubble_mode(false)
		_restore_player_prince_dialogue_staging()
	elif closed_scene == "rose":
		_end_rose_dialogue_animation()
	_restore_dialogue_camera()
	story_reaction_generation += 1
	if was_story_scene and closed_scene == "vain":
		_play_vain_default_dance(
			_story_node_by_kind("vain_character"),
			VAIN_DANCE_BLEND_SECONDS
		)
	if was_story_scene and mark_dialogue_complete:
		planet_story_states[closed_scene] = "dialogue_done"
		_save_planet_story_state()


func _story_node_by_kind(kind: String) -> Node3D:
	var index := _find_editable_record_index_by_kind(kind)
	if index < 0:
		return null
	return editable_3d_objects[index].get("node") as Node3D


func _story_anchor_node(slug: String) -> Node3D:
	match slug:
		"rose":
			return _story_node_by_kind("rose_model")
		"vain":
			return _story_node_by_kind("vain_character")
		"merchant":
			return _story_node_by_kind("merchant_character")
		"earth":
			return _story_node_by_kind("fox")
	return null


func _set_story_character_animation(
	kind: String,
	clip_name: String,
	loop := true
) -> Node3D:
	var root := _story_node_by_kind(kind)
	if root == null:
		return null
	for record in editable_3d_objects:
		if record.get("node") == root:
			record["selected_animation"] = clip_name
			break
	_play_character_animation(root, [clip_name], loop, 0.22)
	return root


func _play_vain_default_dance(
	actor: Node3D,
	blend_time := VAIN_DANCE_BLEND_SECONDS
) -> bool:
	if actor == null:
		return false
	var player := _find_rig_animation_player(actor)
	if player == null or not player.has_animation(VAIN_DANCE_CLIP):
		return false
	player.speed_scale = 1.0
	if (
		player.current_animation != VAIN_DANCE_CLIP
		or not player.is_playing()
	):
		if not _play_character_animation(
			actor,
			[VAIN_DANCE_CLIP],
			true,
			blend_time
		):
			return false
	for record in editable_3d_objects:
		if record.get("node") == actor:
			record["selected_animation"] = VAIN_DANCE_CLIP
			break
	return true


func _update_vain_default_dance() -> void:
	if (
		current_3d_scene != "vain"
		or dialogue_active
		or editor_active
		or not story_action_phase.is_empty()
		or stage_3d == null
		or not stage_3d.visible
	):
		return
	_play_vain_default_dance(_story_node_by_kind("vain_character"))


func _play_story_dialogue_reaction(
	node: Dictionary,
	node_id: String
) -> void:
	if dialogue_scene == "rose":
		_set_rose_dialogue_mood(node_id)
		return
	if dialogue_scene != "vain":
		return
	var clip_name := String(node.get("animation", ""))
	if clip_name.is_empty():
		return
	var actor := _story_node_by_kind("vain_character")
	var player := _find_rig_animation_player(actor)
	if player == null or not player.has_animation(clip_name):
		return
	story_reaction_generation += 1
	_play_vain_reaction(
		actor,
		clip_name,
		story_reaction_generation
	)


func _begin_vain_dialogue_intro_transition(intro: Dictionary) -> void:
	var actor := _story_node_by_kind("vain_character")
	var player := _find_rig_animation_player(actor)
	if player == null:
		return
	story_reaction_generation += 1
	var generation := story_reaction_generation
	player.speed_scale = 1.0
	if (
		player.current_animation == "dance_01_001"
		and player.is_playing()
	):
		var settle := create_tween()
		settle.tween_property(player, "speed_scale", 0.38, 0.32) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await settle.finished
	if (
		not dialogue_active
		or dialogue_scene != "vain"
		or generation != story_reaction_generation
	):
		player.speed_scale = 1.0
		return
	_play_character_animation(
		actor,
		["vain_idle_001", "agree_001"],
		true,
		0.68
	)
	await get_tree().create_timer(0.38).timeout
	if (
		not dialogue_active
		or dialogue_scene != "vain"
		or generation != story_reaction_generation
	):
		player.speed_scale = 1.0
		return
	player.speed_scale = 1.0
	var clip_name := String(intro.get("animation", ""))
	if clip_name.is_empty() or not player.has_animation(clip_name):
		return
	_play_vain_reaction(actor, clip_name, generation, 0.46)


func _play_vain_reaction(
	actor: Node3D,
	clip_name: String,
	generation: int,
	blend_time := 0.42
) -> void:
	var player := _find_rig_animation_player(actor)
	if player == null or not player.has_animation(clip_name):
		return
	_play_character_animation(
		actor,
		[clip_name],
		false,
		blend_time
	)
	var duration := player.get_animation(clip_name).length
	await get_tree().create_timer(maxf(0.3, duration)).timeout
	if (
		dialogue_active
		and dialogue_scene == "vain"
		and generation == story_reaction_generation
	):
		_play_character_animation(
			actor,
			["vain_idle_001", "agree_001"],
			true,
			0.35
		)


func _hide_story_action_ui() -> void:
	if story_action_button != null:
		story_action_button.visible = false
	if rose_cloth_button != null:
		rose_cloth_button.visible = false
		rose_cloth_button.set_grabbed(false)
	if story_subtitle_label != null:
		story_subtitle_label.visible = false
	if story_subtitle_panel != null:
		story_subtitle_panel.visible = false
	if story_hint_label != null:
		story_hint_label.visible = false
	if story_hint_panel != null:
		story_hint_panel.visible = false


func _restore_rose_glass_materials(make_clear := false) -> void:
	for entry in story_glass_materials:
		var material := entry.get("material") as StandardMaterial3D
		if material == null:
			continue
		if make_clear:
			material.albedo_color = entry.get(
				"clear_color",
				ROSE_GLASS_CLEAR_COLOR
			)
			material.roughness = float(
				entry.get(
					"clear_roughness",
					ROSE_GLASS_CLEAR_ROUGHNESS
				)
			)
		else:
			material.albedo_color = ROSE_GLASS_FOG_COLOR
			material.roughness = ROSE_GLASS_FOG_ROUGHNESS
	story_glass_materials.clear()


func _clear_story_action_ui() -> void:
	story_action_generation += 1
	_stop_earth_story_sun()
	_restore_rose_glass_materials()
	_set_earth_fox_hint_style(false)
	story_action_phase = ""
	story_action_slug = ""
	story_wipe_dragging = false
	story_wipe_progress = 0.0
	story_action_actor = null
	story_action_target = null
	story_merchant_bead_index = -1
	_hide_story_action_ui()


func _story_planet_idle_hints(slug: String) -> Array[String]:
	var hints: Array[String] = []
	if not story_camera_hint_shown:
		hints.append("按住拖动看四周 | 滚轮缩放 | 双击复位")
		story_camera_hint_shown = true
	if not story_item_hint_shown:
		hints.append("蓝色光点藏着物件的话，点一下看看")
		story_item_hint_shown = true
	if not story_dialogue_hint_shown:
		hints.append("点人物头顶的气泡，选择你想问的问题")
		story_dialogue_hint_shown = true
	match slug:
		"rose":
			hints.append("点击蓝色光点，读一件物件留下的短记")
		"king":
			hints.append("点击太阳或月亮，可以切换昼夜")
			hints.append("点击蓝色光点，阅读王座、皇冠或旗帜的短记")
		"vain":
			hints.append("点击蓝色光点，听镜子、镜亭和礼帽的心事")
		"merchant":
			hints.append("鼠标掠过算盘珠，珠子会滑动")
			hints.append("轻扫星星灯，吊灯会摇晃")
			hints.append("点击蓝色光点，看看账簿与星签的短记")
		"earth":
			hints.append("鼠标轻轻扫过麦田，麦穗会顺着风摆动")
			hints.append("点击蓝色光点，读麦田和洞穴留下的短记")
		"pointlighter":
			hints.append("点击主路灯，可以点亮或熄灭整颗星球")
			hints.append("点击蓝色光点，阅读路灯、小屋和椅子的短记")
	return hints


func _begin_story_hint_cycle(slug: String) -> void:
	if slug == "player" or slug not in MEMORY_ORDER or hud_scene_hint == null:
		_clear_story_hint_cycle()
		return
	if story_hint_cycle_tween != null and story_hint_cycle_tween.is_valid():
		story_hint_cycle_tween.kill()
	story_hint_cycle_scene = slug
	story_hint_cycle_hints = _story_planet_idle_hints(slug)
	story_hint_cycle_index = 0
	story_hint_cycle_elapsed = 0.0
	story_hint_override_text = ""
	story_hint_override_until_msec = 0
	if story_hint_cycle_hints.is_empty():
		hud_scene_hint.text = ""
		return
	hud_scene_hint.text = story_hint_cycle_hints[0]
	hud_scene_hint.modulate.a = 1.0


func _clear_story_hint_cycle() -> void:
	if story_hint_cycle_tween != null and story_hint_cycle_tween.is_valid():
		story_hint_cycle_tween.kill()
	story_hint_cycle_hints.clear()
	story_hint_cycle_scene = ""
	story_hint_cycle_index = 0
	story_hint_cycle_elapsed = 0.0
	story_hint_override_text = ""
	story_hint_override_until_msec = 0
	if hud_scene_hint != null:
		hud_scene_hint.text = ""
		hud_scene_hint.modulate.a = 1.0


func _story_hint_cycle_blocked() -> bool:
	return (
		stage_3d == null
		or not stage_3d.visible
		or current_3d_scene not in MEMORY_ORDER
		or dialogue_active
		or editor_active
		or story_camera_focus_active
		or king_ritual_active
		or story_action_phase != ""
		or (story_hint_panel != null and story_hint_panel.visible)
		or memory_collection_busy
		or (map_loading_overlay != null and map_loading_overlay.visible)
		or (
			current_3d_scene == "pointlighter"
			and chair_state != "hidden"
		)
	)


func _update_story_hint_cycle(delta: float) -> void:
	if hud_scene_hint == null or current_3d_scene not in MEMORY_ORDER:
		return
	if (
		not story_hint_override_text.is_empty()
		and Time.get_ticks_msec() < story_hint_override_until_msec
	):
		hud_scene_hint.text = story_hint_override_text
		hud_scene_hint.modulate.a = 1.0
		return
	if _story_hint_cycle_blocked():
		hud_scene_hint.text = ""
		return
	if not story_hint_override_text.is_empty():
		story_hint_override_text = ""
		story_hint_override_until_msec = 0
		story_hint_cycle_elapsed = STORY_HINT_CYCLE_SECONDS
	if story_hint_cycle_scene != current_3d_scene:
		_begin_story_hint_cycle(current_3d_scene)
		return
	if story_hint_cycle_hints.is_empty():
		return
	if hud_scene_hint.text.is_empty():
		hud_scene_hint.text = story_hint_cycle_hints[story_hint_cycle_index]
		hud_scene_hint.modulate.a = 1.0
		return
	story_hint_cycle_elapsed += delta
	if story_hint_cycle_elapsed < STORY_HINT_CYCLE_SECONDS:
		return
	story_hint_cycle_elapsed = 0.0
	story_hint_cycle_index = (
		(story_hint_cycle_index + 1) % story_hint_cycle_hints.size()
	)
	_set_story_hint_animated(
		story_hint_cycle_hints[story_hint_cycle_index]
	)


func _set_story_hint_animated(text: String) -> void:
	if hud_scene_hint == null or hud_scene_hint.text == text:
		return
	if story_hint_cycle_tween != null and story_hint_cycle_tween.is_valid():
		story_hint_cycle_tween.kill()
	story_hint_cycle_tween = create_tween()
	story_hint_cycle_tween.tween_property(
		hud_scene_hint,
		"modulate:a",
		0.0,
		0.18
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	story_hint_cycle_tween.tween_callback(
		func() -> void:
			if hud_scene_hint != null:
				hud_scene_hint.text = text
	)
	story_hint_cycle_tween.tween_property(
		hud_scene_hint,
		"modulate:a",
		1.0,
		0.24
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _set_story_hint_override(text: String, duration: float) -> void:
	if hud_scene_hint == null:
		return
	if story_hint_cycle_tween != null and story_hint_cycle_tween.is_valid():
		story_hint_cycle_tween.kill()
	story_hint_override_text = text
	story_hint_override_until_msec = Time.get_ticks_msec() + int(
		maxf(duration, 0.1) * 1000.0
	)
	hud_scene_hint.text = text
	hud_scene_hint.modulate.a = 1.0


func _set_story_hint(text: String) -> void:
	if story_hint_label == null:
		return
	story_hint_label.text = text
	story_hint_label.visible = not text.is_empty()
	if story_hint_panel != null:
		story_hint_panel.visible = not text.is_empty()
	if not text.is_empty() and hud_scene_hint != null:
		hud_scene_hint.text = ""


func _set_story_subtitle(text: String) -> void:
	if story_subtitle_label == null:
		return
	story_subtitle_label.text = text.replace("\n\n", "\n")
	story_subtitle_label.visible = not text.is_empty()
	if story_subtitle_panel != null:
		story_subtitle_panel.visible = not text.is_empty()


func _resume_planet_story_after_enter(slug: String) -> void:
	await get_tree().create_timer(0.35).timeout
	if (
		current_3d_scene != slug
		or not stage_3d.visible
		or dialogue_active
		or editor_active
	):
		return
	var state := String(planet_story_states.get(slug, "new"))
	if slug == "earth" and state == "fox_found":
		_place_earth_fox_in_cave()
		return
	if state == "dialogue_done":
		if slug == "earth":
			_place_earth_fox_at_cave_entrance()
		_begin_planet_story_action(slug)
	elif state == "complete" and slug == "earth":
		_place_earth_fox_at_cave_entrance()
		_show_fox_seated_state()
	elif state == "new" and slug == "earth":
		_begin_earth_fox_search()


func _begin_planet_story_action(
	slug: String,
	force_replay := false
) -> void:
	var story_state := String(planet_story_states.get(slug, "new"))
	if (
		slug not in STORY_SCENE_SLUGS
		or current_3d_scene != slug
		or (story_state == "complete" and not force_replay)
	):
		return
	if story_state != "complete":
		planet_story_states[slug] = "dialogue_done"
		_save_planet_story_state()
	story_action_generation += 1
	story_action_slug = slug
	story_action_phase = ""
	story_action_actor = _story_anchor_node(slug)
	story_action_target = null
	story_merchant_bead_index = -1
	story_wipe_dragging = false
	story_wipe_progress = 0.0
	hud_scene_hint.text = ""
	_restore_rose_glass_materials()
	_story_set_subtitle_empty()
	_hide_story_action_ui()
	lamp_dialogue_trigger.visible = false
	editor_edit_button.visible = false
	match slug:
		"rose":
			_begin_rose_wipe()
		"vain":
			story_action_phase = "vain_applause"
			_set_story_character_animation("prince_character", "ambient_idle", true)
			_play_vain_default_dance(
				_story_node_by_kind("vain_character"),
				VAIN_DANCE_BLEND_SECONDS
			)
			story_action_button.set_arrow_angle(-90.0)
			story_action_button.visible = true
			_set_story_hint("点击人物上方的箭头，为他鼓一次掌")
		"merchant":
			story_action_phase = "merchant_bead"
			story_merchant_bead_index = 0 if not abacus_bead_targets.is_empty() else -1
			story_action_target = (
				abacus_bead_targets[story_merchant_bead_index].node as Node3D
				if story_merchant_bead_index >= 0
				else _story_node_by_kind("abacus")
			)
			story_action_button.set_arrow_angle(-90.0)
			story_action_button.visible = true
			_set_story_hint("拨动发亮的算珠")
		"earth":
			story_action_phase = "fox_sit"
			story_action_button.set_arrow_angle(90.0)
			story_action_button.visible = true
			_set_story_hint("点击狐狸旁的箭头，陪他们坐到麦田边")


func _story_set_subtitle_empty() -> void:
	if story_subtitle_label != null:
		story_subtitle_label.text = ""
		story_subtitle_label.visible = false
	if story_subtitle_panel != null:
		story_subtitle_panel.visible = false


func _position_story_button_at_node(node: Node3D, y_ratio := 0.52) -> void:
	if node == null or camera_3d == null or story_action_button == null:
		story_action_button.visible = false
		return
	var bounds := _editable_world_bounds(node)
	var world_position := bounds.get_center() + Vector3.UP * bounds.size.y * y_ratio
	if camera_3d.is_position_behind(world_position):
		story_action_button.visible = false
		return
	var screen_position := camera_3d.unproject_position(world_position)
	story_action_button.position = screen_position - story_action_button.size * 0.5
	var pulse := 1.0 + sin(atmosphere_time * 4.4) * 0.055
	story_action_button.scale = Vector2.ONE * pulse


func _update_planet_story_ui() -> void:
	if (
		stage_3d == null
		or not stage_3d.visible
		or current_3d_scene not in STORY_SCENE_SLUGS
	):
		return
	var slug := current_3d_scene
	var state := String(planet_story_states.get(slug, "new"))
	var anchor := _story_anchor_node(slug)
	if (
		dialogue_active
		or editor_active
	):
		lamp_dialogue_trigger.visible = false
		if story_action_button != null:
			story_action_button.visible = false
		if rose_cloth_button != null:
			rose_cloth_button.visible = false
		if dialogue_active and editor_edit_button != null:
			editor_edit_button.visible = false
		return
	if story_action_phase in [
			"vain_waiting",
			"vain_silence",
			"merchant_tallying",
			"fox_waiting",
			"rose_finishing",
		]:
		lamp_dialogue_trigger.visible = false
		if story_action_button != null:
			story_action_button.visible = false
		if rose_cloth_button != null:
			rose_cloth_button.visible = false
		return
	# Dialogue is also a memory/reflection entry after the action is complete.
	# Keep the bubble available and preserve the saved progress when revisiting.
	var can_talk := (
		state in ["new", "fox_found", "dialogue_done", "complete"]
		and story_action_phase.is_empty()
		and not earth_fox_exit_running
	)
	lamp_dialogue_trigger.visible = can_talk
	if can_talk and anchor != null:
		var bounds := _editable_world_bounds(anchor)
		var head_world := bounds.get_center() + Vector3.UP * bounds.size.y * 0.42
		if camera_3d.is_position_behind(head_world):
			lamp_dialogue_trigger.visible = false
		else:
			var screen_position := camera_3d.unproject_position(head_world)
			var trigger_offset := Vector2(0.0, -24.0)
			if slug == "vain":
				trigger_offset = VAIN_DIALOGUE_BUBBLE_OFFSET
			lamp_dialogue_trigger.position = (
				screen_position
				- lamp_dialogue_trigger.size * 0.5
				+ trigger_offset
			)
	var show_button := story_action_phase in [
		"vain_applause",
		"vain_stop",
		"merchant_bead",
		"merchant_tag",
		"fox_sit",
	]
	story_action_button.visible = show_button
	if show_button:
		var button_node := story_action_actor
		var button_height_ratio := 0.34
		if story_action_phase in ["merchant_bead", "merchant_tag"]:
			button_node = story_action_target
			button_height_ratio = 0.56
		elif story_action_phase.begins_with("vain"):
			button_height_ratio = 0.52
		_position_story_button_at_node(button_node, button_height_ratio)
	rose_cloth_button.visible = story_action_phase == "rose_cloth"
	if rose_cloth_button.visible and not story_wipe_dragging:
		rose_cloth_button.position.x = clampf(
			rose_cloth_button.position.x,
			20.0,
			930.0 - rose_cloth_button.size.x
		)
		rose_cloth_button.position.y = clampf(
			rose_cloth_button.position.y,
			20.0,
			940.0 - rose_cloth_button.size.y
		)
	editor_edit_button.visible = (
		SHOW_LAYOUT_BUTTON
		and not dialogue_active
		and not editor_active
		and story_action_phase.is_empty()
	)


func _finish_planet_story_action(slug: String, subtitle: String) -> void:
	if current_3d_scene != slug:
		return
	planet_story_states[slug] = "complete"
	_save_planet_story_state()
	_mark_memory_available(slug, 1.0)
	story_action_phase = ""
	story_wipe_dragging = false
	_hide_story_action_ui()
	_set_story_subtitle(subtitle)
	var quote := String(STORY_DIALOGUE_DATA.COMPLETION_QUOTES.get(slug, ""))
	if hud_scene_quote != null and not quote.is_empty():
		hud_scene_quote.text = quote
	var generation := story_action_generation
	await get_tree().create_timer(7.0).timeout
	if (
		generation == story_action_generation
		and current_3d_scene == slug
		and not dialogue_active
	):
		_story_set_subtitle_empty()


func _update_memory_collection_ui() -> void:
	if (
		memory_star_button == null
		or memory_source_aura == null
		or memory_backpack == null
		or stage_3d == null
		or not stage_3d.visible
	):
		return
	var scene_has_memory := current_3d_scene in MEMORY_ORDER
	var show_backpack := (
		scene_has_memory
		and not dialogue_active
		and not editor_active
		and (map_loading_overlay == null or not map_loading_overlay.visible)
	)
	memory_backpack.visible = show_backpack
	if memory_backpack_label != null:
		memory_backpack_label.visible = show_backpack
	if not show_backpack:
		memory_star_button.visible = false
		memory_source_aura.visible = false
		return
	var slug := current_3d_scene
	var reveal_at := int(memory_reveal_after.get(slug, 0))
	var reveal_ready := Time.get_ticks_msec() >= reveal_at
	var action_blocked := (
		not story_action_phase.is_empty()
		or memory_collection_busy
		or (slug == "king" and king_ritual_active)
		or (
			slug == "pointlighter"
			and chair_state in ["floating", "dragging", "sitting"]
		)
	)
	if not _memory_is_available(slug) or action_blocked or not reveal_ready:
		memory_star_button.visible = false
		memory_source_aura.visible = false
		return
	var anchor := _memory_anchor_node(slug)
	var screen_position := Vector2(470.0, 360.0)
	var aura_size := Vector2(180.0, 140.0)
	if anchor != null and anchor.is_visible_in_tree():
		var bounds := _editable_world_bounds(anchor)
		var bound_center := bounds.get_center()
		var world_position := (
			bound_center + Vector3.UP * maxf(bounds.size.y * 0.62, 0.18)
		)
		if camera_3d.is_position_behind(world_position):
			memory_star_button.visible = false
			memory_source_aura.visible = false
			return
		screen_position = camera_3d.unproject_position(world_position)
		screen_position += Vector2(0.0, -38.0)
		var center_screen := camera_3d.unproject_position(bound_center)
		var horizontal_radius := camera_3d.unproject_position(
			bound_center + camera_3d.global_basis.x * bounds.size.x * 0.52
		).distance_to(center_screen)
		var vertical_radius := camera_3d.unproject_position(
			bound_center + camera_3d.global_basis.y * bounds.size.y * 0.56
		).distance_to(center_screen)
		var aura_radius := clampf(
			maxf(horizontal_radius, vertical_radius) * 1.35,
			56.0,
			176.0
		)
		aura_size = Vector2(aura_radius * 2.0, aura_radius * 1.55)
		memory_source_aura.position = center_screen - aura_size * 0.5
	screen_position.x = clampf(screen_position.x, 52.0, 1512.0)
	screen_position.y = clampf(screen_position.y, 72.0, 840.0)
	memory_star_button.position = screen_position - memory_star_button.size * 0.5
	memory_star_button.visible = true
	memory_source_aura.size = aura_size
	memory_source_aura.visible = true
	if not story_star_hint_shown:
		story_star_hint_shown = true
		_set_story_hint_override(
			"一颗星光出现了。点击它，把这段记忆带回去。",
			7.0
		)
	var memory_data: Dictionary = MEMORY_DEFINITIONS[slug]
	memory_star_button.call("set_accent", memory_data.accent)
	memory_star_button.call(
		"set_art",
		load("res://assets/ui/star_memories/star_%s.png" % slug)
	)
	memory_source_aura.call("set_accent", memory_data.accent)
	memory_source_aura.call(
		"set_art",
		load("res://assets/ui/star_memories/source_%s.png" % slug)
	)


func _memory_anchor_node(slug: String) -> Node3D:
	match slug:
		"rose":
			return _story_node_by_kind("glass_dome")
		"vain":
			return _story_node_by_kind("ornate_mirror")
		"merchant":
			return _story_node_by_kind("star_lamp")
		"earth":
			return _story_node_by_kind("fox")
		"king":
			return king_sun_root if king_sun_root != null else king_character_3d
		"pointlighter":
			return main_lamp_node if main_lamp_node != null else lamplighter_3d
	return null


func _collect_current_memory() -> void:
	var slug := current_3d_scene
	if (
		memory_collection_busy
		or not _memory_is_available(slug)
		or dialogue_active
		or editor_active
		or memory_star_button == null
	):
		return
	AudioDirector.play_sfx("memory_reward", -3.0)
	memory_collection_busy = true
	memory_collection_generation += 1
	var generation := memory_collection_generation
	story_action_generation += 1
	memory_star_button.visible = false
	memory_source_aura.visible = false
	var memory_data: Dictionary = MEMORY_DEFINITIONS[slug]
	var accent: Color = memory_data.accent
	var start := memory_star_button.position + memory_star_button.size * 0.5
	var target := memory_backpack.position + Vector2(
			memory_backpack.size.x * 0.52,
			memory_backpack.size.y * 0.60
	)
	var fragments: Array = memory_data.fragments
	for index in mini(2, fragments.size()):
		_spawn_memory_fragment(
			String(fragments[index]),
			accent,
			start,
			target,
			1.55 + index * 0.07,
			0.15 + index * 0.15,
			Vector2(index * 14.0 - 7.0, index * 8.0 - 4.0)
		)
	var anchor := _memory_anchor_node(slug)
	if anchor != null:
		var base_scale := anchor.scale
		var breath := create_tween()
		breath.tween_property(anchor, "scale", base_scale * 1.035, 0.16) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		breath.tween_property(anchor, "scale", base_scale, 0.28) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(1.22).timeout
	if generation != memory_collection_generation:
		return
	memory_backpack.call("set_open", true)
	await get_tree().create_timer(0.75).timeout
	if (
		generation != memory_collection_generation
		or current_3d_scene != slug
		or not stage_3d.visible
	):
		return
	_finish_memory_collection(slug, generation)


func _spawn_memory_fragment(
	kind: String,
	accent: Color,
	start: Vector2,
	target: Vector2,
	duration: float,
	delay: float,
	offset: Vector2
) -> void:
	var fragment := MEMORY_PAPER_FRAGMENT_SCRIPT.new()
	fragment.size = Vector2(58.0, 50.0)
	fragment.pivot_offset = fragment.size * 0.5
	fragment.position = start - fragment.size * 0.5 + offset
	memory_fragment_layer.add_child(fragment)
	fragment.call(
		"setup",
		kind,
		accent,
		load("res://assets/ui/star_memories/fragment_%s.png" % kind)
	)
	var start_position := fragment.position
	var target_position := target - fragment.size * 0.5 + offset * 0.35
	var tween := create_tween()
	tween.tween_method(
		Callable(self, "_update_memory_fragment_flight").bind(
			fragment,
			start_position,
			target_position
		),
		0.0,
		1.0,
		duration
	).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(fragment.queue_free)


func _update_memory_fragment_flight(
	progress: float,
	fragment: Control,
	start: Vector2,
	target: Vector2
) -> void:
	if not is_instance_valid(fragment):
		return
	var eased := smoothstep(0.0, 1.0, progress)
	var position_now := start.lerp(target, eased)
	position_now.y -= sin(progress * PI) * 118.0
	fragment.position = position_now
	fragment.rotation = sin(progress * PI * 2.0) * 0.22
	var shrink_start := 0.76
	var shrink := clampf(
		(progress - shrink_start) / (1.0 - shrink_start),
		0.0,
		1.0
	)
	fragment.scale = Vector2.ONE * lerpf(1.0, 0.34, shrink)
	fragment.modulate.a = lerpf(1.0, 0.22, shrink)


func _finish_memory_collection(slug: String, generation: int) -> void:
	if (
		generation != memory_collection_generation
		or String(memory_collection_states.get(slug, "locked")) == "collected"
	):
		return
	memory_collection_states[slug] = "collected"
	_record_journey_stop(slug)
	_save_memory_state()
	memory_collection_busy = false
	if not story_recap_shown:
		story_recap_shown = true
		_set_story_hint_override(
			"你已经完成了一颗星球：看物件、问问题、做一件事、收集星光。",
			8.0
		)
	memory_backpack.call(
		"set_states",
		memory_collection_states.duplicate()
	)
	var slot_index := MEMORY_ORDER.find(slug)
	memory_backpack.call("flash_slot", slot_index)
	var memory_data: Dictionary = MEMORY_DEFINITIONS[slug]
	var collected_count := 0
	for memory_slug in MEMORY_ORDER:
		if String(memory_collection_states.get(memory_slug, "locked")) == "collected":
			collected_count += 1
	var subtitle := "已带回：%s\n\n%s" % [
		String(memory_data.title),
		String(memory_data.quote),
	]
	var completed_all_memories := collected_count == MEMORY_ORDER.size()
	if completed_all_memories:
		subtitle = (
			"六枚星光已经连成一条小路。\n\n"
			+ "背带上的小星座正指向那颗还没有名字的第七星。"
		)
	_set_story_hint("")
	_set_story_subtitle(subtitle)
	await get_tree().create_timer(3.8).timeout
	if (
		generation == memory_collection_generation
		and current_3d_scene == slug
		and not dialogue_active
	):
		memory_backpack.call("set_open", false)
		_story_set_subtitle_empty()
	if (
		completed_all_memories
		and generation == memory_collection_generation
		and current_3d_scene == slug
		and stage_3d.visible
	):
		await get_tree().create_timer(1.0).timeout
		if (
			generation == memory_collection_generation
			and current_3d_scene == slug
			and stage_3d.visible
		):
			_exit_3d()


func _clear_memory_collection_ui() -> void:
	memory_collection_generation += 1
	memory_collection_busy = false
	if memory_star_button != null:
		memory_star_button.visible = false
	if memory_source_aura != null:
		memory_source_aura.visible = false
	if memory_fragment_layer != null:
		for child in memory_fragment_layer.get_children():
			child.queue_free()
	if memory_backpack != null:
		memory_backpack.call("set_open", false)


func _begin_rose_wipe() -> void:
	var dome := _story_node_by_kind("glass_dome")
	story_action_target = dome
	story_action_phase = "rose_cloth"
	_start_rose_rigid_motion()
	rose_animation_toward = _rose_direction_toward_prince()
	story_glass_materials.clear()
	if dome == null:
		_set_story_hint("玻璃罩暂时不可见，请退出编辑模式后再试")
		return
	for item in dome.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var source := mesh_instance.get_active_material(surface) as StandardMaterial3D
			if source == null:
				continue
			var clear_color: Color = mesh_instance.get_meta(
				"story_glass_clear_color",
				source.albedo_color
			)
			var clear_roughness := float(mesh_instance.get_meta(
				"story_glass_clear_roughness",
				source.roughness
			))
			mesh_instance.set_meta("story_glass_clear_color", clear_color)
			mesh_instance.set_meta("story_glass_clear_roughness", clear_roughness)
			var fogged := source.duplicate() as StandardMaterial3D
			fogged.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			fogged.cull_mode = BaseMaterial3D.CULL_DISABLED
			mesh_instance.set_surface_override_material(surface, fogged)
			story_glass_materials.append({
				"material": fogged,
				"clear_color": clear_color,
				"clear_roughness": clear_roughness,
			})
	_reset_rose_cloth_position()
	rose_cloth_button.visible = true
	_set_story_hint("抓住布料，拖到玻璃罩上")
	_apply_rose_wipe_fog(0.0)


func _reset_rose_cloth_position() -> void:
	if story_action_target == null or camera_3d == null:
		return
	var bounds := _editable_world_bounds(story_action_target)
	var center := camera_3d.unproject_position(bounds.get_center())
	rose_cloth_button.position = (
		center
		- rose_cloth_button.size * 0.5
		+ Vector2(-118.0, 126.0)
	)


func _begin_rose_cloth_drag() -> void:
	if story_action_phase != "rose_cloth" or current_3d_scene != "rose":
		return
	story_wipe_dragging = true
	rose_cloth_button.set_grabbed(true)
	_set_story_hint("按住布料，沿罩面来回擦动")


func _apply_rose_wipe_fog(progress: float) -> void:
	story_wipe_progress = clampf(progress, 0.0, 1.0)
	_update_rose_wipe_animation(story_wipe_progress)
	var fog_amount := 1.0 - story_wipe_progress
	for entry in story_glass_materials:
		var material := entry.get("material") as StandardMaterial3D
		if material == null:
			continue
		var clear_color: Color = entry.get(
			"clear_color",
			ROSE_GLASS_CLEAR_COLOR
		)
		var clear_roughness := float(entry.get(
			"clear_roughness",
			ROSE_GLASS_CLEAR_ROUGHNESS
		))
		var color := clear_color.lerp(ROSE_GLASS_FOG_COLOR, fog_amount)
		color.a = lerpf(
			clear_color.a,
			ROSE_GLASS_FOG_COLOR.a,
			fog_amount
		)
		material.albedo_color = color
		material.roughness = lerpf(
			clear_roughness,
			ROSE_GLASS_FOG_ROUGHNESS,
			fog_amount
		)


func _finish_rose_wipe() -> void:
	if story_action_phase != "rose_cloth" or current_3d_scene != "rose":
		return
	story_action_phase = "rose_finishing"
	story_wipe_dragging = false
	rose_cloth_button.set_grabbed(false)
	rose_cloth_button.visible = false
	story_action_button.visible = false
	_apply_rose_wipe_fog(1.0)
	rose_animation_target_bloom = 0.84
	rose_animation_target_sway = 0.0026
	rose_animation_target_breath = 0.0100
	rose_animation_target_tremble = 0.0
	rose_animation_target_leaf = 0.68
	rose_animation_target_glow = 0.36
	rose_animation_target_turn = 0.52
	_set_story_hint("玻璃上的雾气散开了")
	var generation := story_action_generation
	await get_tree().create_timer(0.9).timeout
	if generation != story_action_generation or current_3d_scene != "rose":
		return
	_restore_rose_glass_materials(true)
	rose_glass_fog = 0.0
	rose_glass_fog_target = 0.0
	_apply_rose_glass_fog(0.0)
	_end_rose_dialogue_animation()
	_finish_planet_story_action(
		"rose",
		"现在我能看清你了。\n\n玻璃罩还留在原处。风被挡在外面，月光重新落进来。"
	)


func _on_story_action_pressed() -> void:
	if story_action_phase.is_empty():
		return
	AudioDirector.play_sfx("ui_primary")
	match story_action_phase:
		"vain_applause":
			_start_vain_applause()
		"vain_stop":
			_stop_vain_applause()
		"merchant_bead":
			_advance_merchant_bead_guide()
		"merchant_tag":
			_start_merchant_tally()
		"fox_sit":
			_start_fox_wait()


func _start_vain_applause() -> void:
	if story_action_phase != "vain_applause" or current_3d_scene != "vain":
		return
	story_action_phase = "vain_waiting"
	story_action_button.visible = false
	_set_story_hint("掌声还在继续……")
	_play_character_animation(
		story_action_actor,
		["dance_01_001", "laugh_02_001", "cheer_001"],
		true,
		0.22
	)
	_set_story_character_animation("prince_character", "clap_001", true)
	var generation := story_action_generation
	await get_tree().create_timer(3.0).timeout
	if generation != story_action_generation or current_3d_scene != "vain":
		return
	story_action_phase = "vain_stop"
	story_action_button.set_arrow_angle(90.0)
	story_action_button.visible = true
	_set_story_hint("再点箭头，让掌声停下来")
	_set_story_subtitle("……再多一点。\n\n不对。")


func _stop_vain_applause() -> void:
	if story_action_phase != "vain_stop" or current_3d_scene != "vain":
		return
	story_action_phase = "vain_silence"
	story_action_button.visible = false
	_set_story_hint("")
	var player := _find_rig_animation_player(story_action_actor)
	if player != null:
		player.stop()
		player.seek(0.0, true)
		player.pause()
	_play_character_animation(
		story_action_actor,
		["vain_idle_001", "agree_001"],
		true,
		0.38
	)
	var prince := _story_node_by_kind("prince_character")
	for record in editable_3d_objects:
		if record.get("node") == prince:
			record["selected_animation"] = "ambient_idle"
			break
	_apply_character_animation_choice(prince, "ambient_idle", true)
	_set_story_subtitle(
		"……再多一点。\n\n不对。\n\n原来安静也没有把我带走。"
	)
	var generation := story_action_generation
	await get_tree().create_timer(2.6).timeout
	if generation != story_action_generation or current_3d_scene != "vain":
		return
	_finish_planet_story_action(
		"vain",
		"原来安静也没有把我带走。\n\n他低头整理袖口。这一次，他没有先问镜子好不好看。"
	)


func _advance_merchant_bead_guide() -> void:
	if story_action_phase != "merchant_bead" or current_3d_scene != "merchant":
		return
	if (
		story_merchant_bead_index >= 0
		and story_merchant_bead_index < abacus_bead_targets.size()
	):
		var bead: Dictionary = abacus_bead_targets[story_merchant_bead_index]
		bead["z"] = float(bead.get("max_z", 0.17))
		bead["velocity"] = 0.0
	story_action_phase = "merchant_tag"
	story_action_target = _story_node_by_kind("star_tag")
	story_action_button.set_arrow_angle(-90.0)
	story_action_button.visible = true
	_set_story_hint("点击抽屉里的星签，核对这颗星")


func _start_merchant_tally() -> void:
	if story_action_phase != "merchant_tag" or current_3d_scene != "merchant":
		return
	story_action_phase = "merchant_tallying"
	_set_story_hint("算珠正在停稳……")
	if story_action_target != null:
		var base_scale := story_action_target.scale
		var pulse := create_tween()
		pulse.tween_property(
			story_action_target,
			"scale",
			base_scale * 1.08,
			0.18
		)
		pulse.tween_property(story_action_target, "scale", base_scale, 0.35)
	if not abacus_bead_targets.is_empty():
		var target: Dictionary = abacus_bead_targets[0]
		target["z"] = float(target.get("max_z", 0.17))
		target["velocity"] = 0.0
	var merchant_actor := _story_node_by_kind("merchant_character")
	_play_character_animation(merchant_actor, ["agree_001"], false, 0.24)
	var generation := story_action_generation
	await get_tree().create_timer(1.45).timeout
	if generation != story_action_generation or current_3d_scene != "merchant":
		return
	_play_character_animation(merchant_actor, ["fold_arms_001"], true, 0.3)
	_finish_planet_story_action(
		"merchant",
		"第 501,620,001 号，核对无误。\n\n抽屉里没有星星，只有一块写着号码的星签。"
	)


func _show_fox_seated_state() -> void:
	var standing := _story_node_by_kind("prince_character")
	var seated := _story_node_by_kind("seated_prince_origami")
	if standing != null:
		standing.visible = false
	if seated != null:
		seated.visible = true
		_set_model_alpha(seated, 1.0)


func _show_fox_standing_state() -> void:
	var standing := _story_node_by_kind("prince_character")
	var seated := _story_node_by_kind("seated_prince_origami")
	if standing != null:
		standing.visible = true
		_set_model_alpha(standing, 1.0)
	if seated != null:
		seated.visible = false


func _set_earth_fox_hint_style(fox_search_style: bool) -> void:
	if hud_scene_hint == null:
		return
	if earth_fox_search_controls != null:
		earth_fox_search_controls.visible = (
			fox_search_style
			and earth_fox_search_active
			and not earth_fox_search_running
		)
	if fox_search_style:
		hud_scene_hint.position = Vector2(440, 108)
		hud_scene_hint.size = Vector2(560, 56)
		hud_scene_hint.add_theme_font_size_override("font_size", 24)
		hud_scene_hint.add_theme_color_override(
			"font_color",
			Color(1.0, 0.93, 0.78, 1.0)
		)
		hud_scene_hint.add_theme_color_override(
			"font_shadow_color",
			Color(0.01, 0.02, 0.05, 0.92)
		)
		hud_scene_hint.add_theme_constant_override("shadow_offset_x", 1)
		hud_scene_hint.add_theme_constant_override("shadow_offset_y", 2)
		hud_scene_hint.add_theme_constant_override("outline_size", 2)
		return
	hud_scene_hint.position = Vector2(400, 923)
	hud_scene_hint.size = Vector2(800, 44)
	hud_scene_hint.add_theme_font_size_override("font_size", UI_FONT_BODY)
	hud_scene_hint.add_theme_color_override(
		"font_color",
		Color(1.0, 0.91, 0.75, 0.96)
	)
	hud_scene_hint.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	hud_scene_hint.add_theme_constant_override("shadow_offset_x", 0)
	hud_scene_hint.add_theme_constant_override("shadow_offset_y", 0)
	hud_scene_hint.add_theme_constant_override("outline_size", 1)


func _begin_earth_fox_search() -> void:
	if (
		current_3d_scene != "earth"
		or earth_fox_search_active
		or earth_fox_search_running
		or camera_3d == null
		or model_3d == null
	):
		return
	var fox_index := _find_editable_record_index_by_kind("fox")
	if fox_index < 0:
		return
	var record: Dictionary = editable_3d_objects[fox_index]
	var fox := record.get("node") as Node3D
	if fox == null:
		return
	_show_fox_standing_state()
	_set_story_character_animation(
		"prince_character",
		"look_around_001",
		true
	)
	_play_character_animation(
		fox,
		["Idle_2_HeadLow", "Idle_2", "Idle"],
		true,
		0.25
	)
	var camera_local := (
		model_3d.global_transform.basis.inverse()
		* (camera_3d.global_position - model_3d.global_position).normalized()
	)
	var hidden_normal := (-camera_local).normalized()
	hidden_normal = (
		Basis(Vector3.UP, deg_to_rad(28.0))
		* hidden_normal
	).normalized()
	var hidden_radius := _earth_fox_surface_radius(hidden_normal)
	record["normal"] = hidden_normal
	record["root_radius"] = hidden_radius
	record["yaw"] = 0.0
	record["selected_animation"] = "Idle_2_HeadLow"
	_apply_editable_3d_record(fox_index)
	fox.scale = Vector3.ONE * float(record.get("scale", 1.0)) * 1.35
	earth_fox_inside_cave = false
	earth_fox_exit_running = false
	earth_fox_exit_generation += 1
	earth_fox_search_active = true
	earth_fox_search_running = false
	earth_fox_search_generation += 1
	story_action_phase = "fox_search"
	model_spin_velocity = Vector2.ZERO
	lamp_dialogue_trigger.visible = false
	editor_edit_button.visible = false
	_set_earth_fox_hint_style(true)
	_set_story_hint_override("寻找到狐狸", 900.0)


func _begin_earth_fox_dialogue_idle_cycle() -> void:
	if (
		current_3d_scene != "earth"
		or dialogue_scene != "earth"
		or not dialogue_active
	):
		return
	var fox := _story_node_by_kind("fox")
	if fox == null:
		return
	earth_fox_dialogue_idle_generation += 1
	var generation := earth_fox_dialogue_idle_generation
	earth_fox_dialogue_idle_active = true
	while (
		earth_fox_dialogue_idle_active
		and generation == earth_fox_dialogue_idle_generation
		and dialogue_active
		and dialogue_scene == "earth"
		and current_3d_scene == "earth"
	):
		for clip_name in EARTH_FOX_DIALOGUE_IDLE_CLIPS:
			if (
				not earth_fox_dialogue_idle_active
				or generation != earth_fox_dialogue_idle_generation
				or not dialogue_active
				or dialogue_scene != "earth"
				or current_3d_scene != "earth"
			):
				break
			_play_character_animation(
				fox,
				[String(clip_name)],
				true,
				0.32
			)
			await get_tree().create_timer(
				EARTH_FOX_DIALOGUE_IDLE_SECONDS
			).timeout


func _stop_earth_fox_dialogue_idle_cycle() -> void:
	if not earth_fox_dialogue_idle_active:
		return
	earth_fox_dialogue_idle_active = false
	earth_fox_dialogue_idle_generation += 1
	if current_3d_scene != "earth":
		return
	var fox := _story_node_by_kind("fox")
	if fox != null:
		_play_character_animation(
			fox,
			["Idle_2", "Idle"],
			true,
			0.26
		)


func _earth_fox_hit_at_screen(screen_position: Vector2) -> bool:
	var picked := _pick_editable_object(screen_position)
	if picked < 0 or picked >= editable_3d_objects.size():
		return false
	return String(editable_3d_objects[picked].get("kind", "")) == "fox"


func _start_earth_fox_return() -> void:
	if (
		current_3d_scene != "earth"
		or not earth_fox_search_active
		or earth_fox_search_running
	):
		return
	var fox_index := _find_editable_record_index_by_kind("fox")
	var hill_index := _find_editable_record_index_by_kind("earth_hill")
	if fox_index < 0 or hill_index < 0:
		return
	var fox_record: Dictionary = editable_3d_objects[fox_index]
	var hill_record: Dictionary = editable_3d_objects[hill_index]
	var fox := fox_record.get("node") as Node3D
	var hill := hill_record.get("node") as Node3D
	if fox == null or hill == null:
		return
	earth_fox_search_running = true
	earth_fox_search_generation += 1
	var generation := earth_fox_search_generation
	if earth_fox_search_controls != null:
		earth_fox_search_controls.visible = false
	story_action_phase = "fox_return"
	model_spin_velocity = Vector2.ZERO
	dragging_3d = false
	_set_story_hint_override("狐狸发现你了，正往洞穴跑去", 7.2)
	_set_story_character_animation(
		"prince_character",
		"ambient_idle",
		true
	)
	AudioDirector.play_sfx("ui_soft")
	_play_character_animation(
		fox,
		["Idle_HitReact_Right", "Idle_HitReact_Left"],
		false,
		0.08
	)
	var fox_player := _find_rig_animation_player(fox)
	if fox_player != null:
		fox_player.speed_scale = 0.72
	await get_tree().create_timer(0.65).timeout
	if (
		generation != earth_fox_search_generation
		or current_3d_scene != "earth"
	):
		return
	var start_normal := (fox_record.get("normal", Vector3.FORWARD) as Vector3).normalized()
	var approach_point := _earth_fox_cave_point(hill, false)
	var approach_local := (
		model_3d.global_transform.affine_inverse()
		* approach_point
	)
	var target_normal := approach_local.normalized()
	if start_normal.dot(target_normal) > 0.995:
		var tangent := Vector3.UP.cross(target_normal).normalized()
		if tangent.length_squared() < 0.001:
			tangent = Vector3.RIGHT
		target_normal = (target_normal + tangent * 0.20).normalized()
	var target_radius := approach_local.length()
	earth_fox_cave_normal = target_normal
	earth_fox_cave_radius = target_radius
	_build_earth_fox_route(start_normal, target_normal)
	_play_character_animation(fox, ["Gallop"], true, 0.16)
	await _animate_earth_fox_path(
		generation,
		fox_record,
		start_normal,
		target_normal,
		target_radius,
		0.0,
		0.52,
		1.75
	)
	if generation != earth_fox_search_generation:
		return
	_play_character_animation(fox, ["Gallop_Jump"], false, 0.14)
	await _animate_earth_fox_path(
		generation,
		fox_record,
		start_normal,
		target_normal,
		target_radius,
		0.52,
		0.68,
		0.72
	)
	if generation != earth_fox_search_generation:
		return
	_play_character_animation(fox, ["Gallop"], true, 0.14)
	await _animate_earth_fox_path(
		generation,
		fox_record,
		start_normal,
		target_normal,
		target_radius,
		0.68,
		0.88,
		1.30
	)
	if generation != earth_fox_search_generation:
		return
	_play_character_animation(fox, ["Walk"], true, 0.24)
	await _animate_earth_fox_path(
		generation,
		fox_record,
		start_normal,
		target_normal,
		target_radius,
		0.88,
		1.0,
		0.82
	)
	if generation != earth_fox_search_generation:
		return
	await _animate_earth_fox_cave_entry(
		generation,
		fox_record,
		hill
	)
	if (
		generation != earth_fox_search_generation
		or current_3d_scene != "earth"
	):
		return
	await _turn_earth_fox_inside_cave(generation, fox_record, hill)
	if (
		generation != earth_fox_search_generation
		or current_3d_scene != "earth"
	):
		return
	_play_character_animation(fox, ["Idle_2", "Idle"], true, 0.28)
	if fox_player != null:
		fox_player.speed_scale = 1.0
	_set_earth_fox_cave_transform(fox, fox_record, hill, true)
	earth_fox_inside_cave = true
	earth_fox_exit_running = false
	fox_record["normal"] = target_normal
	fox_record["root_radius"] = target_radius
	fox_record["initial_normal"] = target_normal
	fox_record["initial_root_radius"] = target_radius
	fox_record["selected_animation"] = "Idle_2"
	fox_record["yaw"] = 0.0
	fox_record["initial_yaw"] = 0.0
	fox_record["locked"] = true
	planet_story_states["earth"] = "fox_found"
	_save_planet_story_state()
	if not preview_mode_active:
		_save_3d_layout()
	earth_fox_search_active = false
	earth_fox_search_running = false
	story_action_phase = ""
	editor_edit_button.visible = SHOW_LAYOUT_BUTTON
	_begin_story_hint_cycle("earth")
	_set_story_hint_override("狐狸在洞穴入口等你", 2.8)
	AudioDirector.play_sfx("ui_primary")
	await get_tree().create_timer(3.0).timeout
	if (
		generation == earth_fox_search_generation
		and current_3d_scene == "earth"
	):
		_set_earth_fox_hint_style(false)


func _earth_fox_cave_point(hill: Node3D, inside: bool) -> Vector3:
	var local_point := (
		EARTH_FOX_CAVE_INSIDE_LOCAL
		if inside
		else EARTH_FOX_CAVE_ENTRANCE_LOCAL
	)
	return hill.global_transform * local_point


func _ensure_earth_fox_ground_collision() -> void:
	if current_3d_scene != "earth" or model_3d == null:
		return
	if earth_fox_ground_body != null and is_instance_valid(earth_fox_ground_body):
		return
	var base_root := model_3d.find_child("PlanetBase", true, false) as Node3D
	if base_root == null:
		return
	var ground_mesh: MeshInstance3D
	for item in base_root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance != null and mesh_instance.mesh != null:
			ground_mesh = mesh_instance
			break
	if ground_mesh == null:
		return
	var shape := _make_concave_mesh_shape(ground_mesh.mesh)
	if shape.get_faces().is_empty():
		return
	earth_fox_ground_body = StaticBody3D.new()
	earth_fox_ground_body.name = "EarthFoxGround"
	earth_fox_ground_body.collision_layer = 1 << 19
	earth_fox_ground_body.collision_mask = 0
	var collision_shape := CollisionShape3D.new()
	collision_shape.name = "EarthFoxGroundShape"
	collision_shape.shape = shape
	earth_fox_ground_body.add_child(collision_shape)
	ground_mesh.add_child(earth_fox_ground_body)


func _earth_fox_surface_radius(normal: Vector3) -> float:
	if model_3d == null:
		return VISUAL_PLANET_BASE_RADIUS
	var world_normal := (
		model_3d.global_transform.basis.orthonormalized()
		* normal.normalized()
	).normalized()
	if (
		earth_fox_ground_body != null
		and is_instance_valid(earth_fox_ground_body)
		and camera_3d != null
		and camera_3d.get_world_3d() != null
	):
		var ray_origin := model_3d.global_position + world_normal * 7.0
		var query := PhysicsRayQueryParameters3D.create(
			ray_origin,
			ray_origin - world_normal * 7.0,
			1 << 19
		)
		query.collide_with_areas = false
		query.collide_with_bodies = true
		var result: Dictionary = (
			camera_3d.get_world_3d().direct_space_state.intersect_ray(query)
		)
		if not result.is_empty():
			var hit_local := (
				model_3d.global_transform.affine_inverse()
				* (result.position as Vector3)
			)
			return maxf(hit_local.length(), 0.1) + EARTH_FOX_SURFACE_CLEARANCE
	var base_root := model_3d.find_child("PlanetBase", true, false) as Node3D
	if base_root == null:
		return VISUAL_PLANET_BASE_RADIUS
	var ray_origin := model_3d.global_position + world_normal * 7.0
	var hit_distance := _object_ray_hit_distance(
		base_root,
		ray_origin,
		-world_normal
	)
	if hit_distance == INF:
		return VISUAL_PLANET_BASE_RADIUS
	var hit_world := ray_origin - world_normal * hit_distance
	var hit_local := (
		model_3d.global_transform.affine_inverse()
		* hit_world
	)
	return maxf(hit_local.length(), 0.1) + EARTH_FOX_SURFACE_CLEARANCE


func _earth_fox_route_normal(
	start_normal: Vector3,
	target_normal: Vector3,
	progress: float,
	bend: float
) -> Vector3:
	var normal := _slerp_surface_normal(
		start_normal,
		target_normal,
		progress
	)
	if absf(bend) < 0.001:
		return normal
	var path_axis := start_normal.normalized().cross(target_normal.normalized())
	if path_axis.length_squared() < 0.001:
		path_axis = start_normal.normalized().cross(Vector3.UP)
	if path_axis.length_squared() < 0.001:
		path_axis = Vector3.RIGHT
	var lateral := path_axis.normalized().cross(normal).normalized()
	var offset := sin(PI * clampf(progress, 0.0, 1.0)) * bend
	return (normal * cos(offset) + lateral * sin(offset)).normalized()


func _build_earth_fox_route(
	start_normal: Vector3,
	target_normal: Vector3
) -> void:
	var candidates: Array[float] = [
		-0.72,
		-0.50,
		-0.30,
		-0.15,
		0.0,
		0.15,
		0.30,
		0.50,
		0.72,
	]
	var sample_count := 25
	var best_score := INF
	var best_bend := 0.0
	var best_radii: Array[float] = []
	for bend in candidates:
		var radii: Array[float] = []
		for sample_index in sample_count:
			var progress := float(sample_index) / float(sample_count - 1)
			var normal := _earth_fox_route_normal(
				start_normal,
				target_normal,
				progress,
				bend
			)
			radii.append(_earth_fox_surface_radius(normal))
		var sorted_radii := radii.duplicate()
		sorted_radii.sort()
		var baseline := float(
			sorted_radii[int(float(sorted_radii.size()) * 0.32)]
		)
		var score := absf(bend) * 0.12
		for sample_index in sample_count:
			var progress := float(sample_index) / float(sample_count - 1)
			if progress > 0.90:
				continue
			var excess := maxf(
				float(radii[sample_index]) - baseline - 0.055,
				0.0
			)
			score += excess * excess * 520.0 + excess * 5.0
		if score < best_score:
			best_score = score
			best_bend = bend
			best_radii = radii
	earth_fox_route_bend = best_bend
	earth_fox_route_radii = best_radii


func _earth_fox_route_radius(progress: float) -> float:
	if earth_fox_route_radii.is_empty():
		return VISUAL_PLANET_BASE_RADIUS
	var scaled := clampf(progress, 0.0, 1.0) * float(
		earth_fox_route_radii.size() - 1
	)
	var first_index := int(floor(scaled))
	var second_index := mini(first_index + 1, earth_fox_route_radii.size() - 1)
	return lerpf(
		float(earth_fox_route_radii[first_index]),
		float(earth_fox_route_radii[second_index]),
		scaled - float(first_index)
	)


func _animate_earth_fox_path(
	generation: int,
	record: Dictionary,
	start_normal: Vector3,
	target_normal: Vector3,
	target_radius: float,
	from_progress: float,
	to_progress: float,
	duration: float
) -> void:
	var tween := create_tween()
	tween.tween_method(
		Callable(self, "_update_earth_fox_path").bind(
			generation,
			record,
			start_normal,
			target_normal,
			target_radius
		),
		from_progress,
		to_progress,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func _update_earth_fox_path(
	progress: float,
	generation: int,
	record: Dictionary,
	start_normal: Vector3,
	target_normal: Vector3,
	target_radius: float
) -> void:
	if (
		generation != earth_fox_search_generation
		or current_3d_scene != "earth"
	):
		return
	var fox := record.get("node") as Node3D
	if fox == null:
		return
	var clamped_progress := clampf(progress, 0.0, 1.0)
	var normal := _earth_fox_route_normal(
		start_normal,
		target_normal,
		clamped_progress,
		earth_fox_route_bend
	)
	var radius := _earth_fox_route_radius(clamped_progress)
	radius = lerpf(
		radius,
		target_radius,
		smoothstep(0.82, 1.0, clamped_progress)
	)
	var point := normal * radius
	var target_point := target_normal * target_radius
	var basis := _upright_surface_basis_toward(
		normal,
		point,
		target_point
	)
	fox.transform = Transform3D(basis, point)
	var search_scale := lerpf(
		1.35,
		1.0,
		smoothstep(0.72, 1.0, clamped_progress)
	)
	fox.scale = (
		Vector3.ONE
		* float(record.get("scale", 1.0))
		* search_scale
	)
	_follow_earth_fox_with_camera(normal)


func _earth_fox_hill_basis_in_model(
	hill: Node3D,
	face_out := false
) -> Basis:
	var cave_yaw := PI * 0.5 if face_out else -PI * 0.5
	if model_3d == null:
		var fallback := hill.global_transform.basis.orthonormalized()
		return fallback * Basis(Vector3.UP, cave_yaw)
	var local_basis := (
		model_3d.global_transform.basis.inverse()
		* hill.global_transform.basis.orthonormalized()
	).orthonormalized()
	return local_basis * Basis(Vector3.UP, cave_yaw)


func _set_earth_fox_cave_transform(
	fox: Node3D,
	record: Dictionary,
	hill: Node3D,
	inside: bool,
	scale_multiplier := 1.0,
	face_out := true
) -> void:
	if fox == null or model_3d == null:
		return
	var world_point := _earth_fox_cave_point(hill, inside)
	var local_point := (
		model_3d.global_transform.affine_inverse()
		* world_point
	)
	fox.transform = Transform3D(
		_earth_fox_hill_basis_in_model(hill, face_out),
		local_point
	)
	fox.scale = (
		Vector3.ONE
		* float(record.get("scale", 1.0))
		* scale_multiplier
	)


func _animate_earth_fox_cave_entry(
	generation: int,
	record: Dictionary,
	hill: Node3D
) -> void:
	var fox := record.get("node") as Node3D
	if fox == null or model_3d == null:
		return
	_play_character_animation(fox, ["Walk"], true, 0.18)
	var model_inverse := model_3d.global_transform.affine_inverse()
	var entrance_point := model_inverse * _earth_fox_cave_point(hill, false)
	var inside_point := model_inverse * _earth_fox_cave_point(hill, true)
	var tween := create_tween()
	tween.tween_method(
		Callable(self, "_update_earth_fox_cave_entry").bind(
			generation,
			record,
			hill,
			entrance_point,
			inside_point
		),
		0.0,
		1.0,
		1.05
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func _update_earth_fox_cave_entry(
	progress: float,
	generation: int,
	record: Dictionary,
	hill: Node3D,
	entrance_point: Vector3,
	inside_point: Vector3
) -> void:
	if (
		generation != earth_fox_search_generation
		or current_3d_scene != "earth"
	):
		return
	var fox := record.get("node") as Node3D
	if fox == null:
		return
	var point := entrance_point.lerp(inside_point, clampf(progress, 0.0, 1.0))
	fox.transform = Transform3D(
		_earth_fox_hill_basis_in_model(hill),
		point
	)
	fox.scale = (
		Vector3.ONE
		* float(record.get("scale", 1.0))
		* lerpf(1.0, 1.0, progress)
	)
	_follow_earth_fox_with_camera(point.normalized())


func _turn_earth_fox_inside_cave(
	generation: int,
	record: Dictionary,
	hill: Node3D
) -> void:
	var fox := record.get("node") as Node3D
	if fox == null:
		return
	var start_quaternion := (
		fox.transform.basis.orthonormalized().get_rotation_quaternion()
	)
	var target_quaternion := (
		_earth_fox_hill_basis_in_model(hill, true)
		.get_rotation_quaternion()
	)
	var tween := create_tween()
	tween.tween_method(
		Callable(self, "_update_earth_fox_cave_turn").bind(
			generation,
			fox,
			start_quaternion,
			target_quaternion
		),
		0.0,
		1.0,
		0.42
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func _update_earth_fox_cave_turn(
	progress: float,
	generation: int,
	fox: Node3D,
	start_quaternion: Quaternion,
	target_quaternion: Quaternion
) -> void:
	if (
		generation != earth_fox_search_generation
		or current_3d_scene != "earth"
		or fox == null
	):
		return
	fox.quaternion = start_quaternion.slerp(
		target_quaternion,
		clampf(progress, 0.0, 1.0)
	).normalized()


func _follow_earth_fox_with_camera(surface_normal: Vector3) -> void:
	if model_3d == null or camera_3d == null:
		return
	var world_normal := (
		model_3d.global_transform.basis.orthonormalized()
		* surface_normal.normalized()
	)
	var current_horizontal := Vector3(
		world_normal.x,
		0.0,
		world_normal.z
	)
	var camera_heading := (
		camera_3d.global_position - model_3d.global_position
	)
	camera_heading.y = 0.0
	if (
		current_horizontal.length_squared() < 0.0001
		or camera_heading.length_squared() < 0.0001
	):
		return
	current_horizontal = current_horizontal.normalized()
	camera_heading = camera_heading.normalized()
	var follow_angle := current_horizontal.signed_angle_to(
		camera_heading,
		Vector3.UP
	)
	var preserved_scale := model_3d.scale
	model_3d.basis = (
		Basis(Vector3.UP, follow_angle)
		* model_3d.basis.orthonormalized()
	)
	model_3d.scale = preserved_scale
	_sync_planet_light_rig()


func _place_earth_fox_in_cave() -> void:
	if current_3d_scene != "earth":
		return
	var fox_index := _find_editable_record_index_by_kind("fox")
	var hill_index := _find_editable_record_index_by_kind("earth_hill")
	if fox_index < 0 or hill_index < 0:
		return
	var record: Dictionary = editable_3d_objects[fox_index]
	var hill := editable_3d_objects[hill_index].get("node") as Node3D
	var fox := record.get("node") as Node3D
	if fox == null or hill == null:
		return
	_set_earth_fox_cave_transform(fox, record, hill, true)
	_play_character_animation(fox, ["Idle_2", "Idle"], true, 0.24)
	earth_fox_inside_cave = true
	earth_fox_exit_running = false


func _place_earth_fox_at_cave_entrance() -> void:
	if current_3d_scene != "earth":
		return
	var fox_index := _find_editable_record_index_by_kind("fox")
	var hill_index := _find_editable_record_index_by_kind("earth_hill")
	if fox_index < 0 or hill_index < 0:
		return
	var record: Dictionary = editable_3d_objects[fox_index]
	var hill := editable_3d_objects[hill_index].get("node") as Node3D
	var fox := record.get("node") as Node3D
	if fox == null or hill == null:
		return
	_set_earth_fox_cave_transform(fox, record, hill, false)
	_play_character_animation(fox, ["Idle_2", "Idle"], true, 0.24)
	earth_fox_inside_cave = false
	earth_fox_exit_running = false


func _walk_earth_fox_to_cave_entrance() -> void:
	if (
		current_3d_scene != "earth"
		or not earth_fox_inside_cave
		or earth_fox_exit_running
	):
		return
	var fox_index := _find_editable_record_index_by_kind("fox")
	var hill_index := _find_editable_record_index_by_kind("earth_hill")
	if fox_index < 0 or hill_index < 0:
		return
	var record: Dictionary = editable_3d_objects[fox_index]
	var hill := editable_3d_objects[hill_index].get("node") as Node3D
	var fox := record.get("node") as Node3D
	if fox == null or hill == null:
		return
	earth_fox_exit_running = true
	earth_fox_exit_generation += 1
	var generation := earth_fox_exit_generation
	lamp_dialogue_trigger.visible = false
	editor_edit_button.visible = false
	_set_story_hint_override("狐狸从洞穴里走了出来", 2.4)
	var fox_player := _find_rig_animation_player(fox)
	if fox_player != null:
		fox_player.speed_scale = 0.78
	_play_character_animation(fox, ["Walk"], true, 0.18)
	var model_inverse := model_3d.global_transform.affine_inverse()
	var inside_point := model_inverse * _earth_fox_cave_point(hill, true)
	var entrance_point := model_inverse * _earth_fox_cave_point(hill, false)
	var tween := create_tween()
	tween.tween_method(
		Callable(self, "_update_earth_fox_cave_exit").bind(
			generation,
			record,
			hill,
			inside_point,
			entrance_point
		),
		0.0,
		1.0,
		0.95
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	if (
		generation != earth_fox_exit_generation
		or current_3d_scene != "earth"
	):
		return
	if fox_player != null:
		fox_player.speed_scale = 1.0
	_play_character_animation(fox, ["Idle_2", "Idle"], true, 0.24)
	_set_earth_fox_cave_transform(fox, record, hill, false)
	earth_fox_inside_cave = false
	earth_fox_exit_running = false
	editor_edit_button.visible = SHOW_LAYOUT_BUTTON
	_set_story_hint_override("", 0.1)


func _update_earth_fox_cave_exit(
	progress: float,
	generation: int,
	record: Dictionary,
	hill: Node3D,
	inside_point: Vector3,
	entrance_point: Vector3
) -> void:
	if (
		generation != earth_fox_exit_generation
		or current_3d_scene != "earth"
	):
		return
	var fox := record.get("node") as Node3D
	if fox == null:
		return
	var point := inside_point.lerp(entrance_point, clampf(progress, 0.0, 1.0))
	fox.transform = Transform3D(
		_earth_fox_hill_basis_in_model(hill, true),
		point
	)
	fox.scale = Vector3.ONE * float(record.get("scale", 1.0))
	_follow_earth_fox_with_camera(point.normalized())


func _slerp_surface_normal(
	from_normal: Vector3,
	to_normal: Vector3,
	weight: float
) -> Vector3:
	var from := from_normal.normalized()
	var to := to_normal.normalized()
	var dot := clampf(from.dot(to), -1.0, 1.0)
	if dot > 0.9995:
		return from.lerp(to, weight).normalized()
	if dot < -0.9995:
		var side := Vector3.UP.cross(from)
		if side.length_squared() < 0.001:
			side = Vector3.RIGHT
		return (
			from * cos(PI * weight)
			+ side.normalized() * sin(PI * weight)
		).normalized()
	var theta := acos(dot)
	var sin_theta := sin(theta)
	return (
		from * (sin((1.0 - weight) * theta) / sin_theta)
		+ to * (sin(weight * theta) / sin_theta)
	).normalized()


func _ensure_earth_story_sun() -> void:
	if earth_story_sun != null and is_instance_valid(earth_story_sun):
		return
	earth_story_sun = Node3D.new()
	earth_story_sun.name = "EarthStorySun"
	earth_story_sun.visible = false
	stage_3d.add_child(earth_story_sun)
	var sun := _add_king_celestial_body(
		earth_story_sun,
		"Sun",
		Vector3.ZERO,
		0.26,
		Color(1.0, 0.72, 0.28, 1.0),
		Color(1.0, 0.42, 0.07, 0.38),
		2.35
	)
	earth_story_sun_material = sun.material as ShaderMaterial
	earth_story_sun_glow = sun.glow as Sprite3D
	if earth_story_sun_glow != null:
		# Keep the glow attached to the sun as it crosses above the planet.
		earth_story_sun_glow.no_depth_test = false


func _start_earth_story_sun(generation: int) -> void:
	_ensure_earth_story_sun()
	if earth_story_sun_tween != null and earth_story_sun_tween.is_valid():
		earth_story_sun_tween.kill()
	earth_story_sun.visible = true
	if earth_story_sun_glow != null:
		earth_story_sun_glow.visible = true
	earth_story_sun_tween = create_tween()
	earth_story_sun_tween.tween_method(
		Callable(self, "_update_earth_story_sun").bind(generation),
		0.0,
		1.0,
		8.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _update_earth_story_sun(progress: float, generation: int) -> void:
	if (
		generation != story_action_generation
		or current_3d_scene != "earth"
		or earth_story_sun == null
		or model_3d == null
		or camera_3d == null
	):
		_stop_earth_story_sun()
		return
	var t := clampf(progress, 0.0, 1.0)
	var one_minus_t := 1.0 - t
	var planet_bounds := _editable_world_bounds(model_3d)
	var viewport_size := get_viewport().get_visible_rect().size
	# The sun follows the complete red arc from the brief: it enters at the
	# upper-left of the planet, stays clear of the wheat silhouette across the
	# top of the frame, and leaves at the upper-right.
	var start := Vector2(viewport_size.x * 0.24, viewport_size.y * 0.69)
	var control_a := Vector2(viewport_size.x * 0.40, viewport_size.y * 0.03)
	var control_b := Vector2(viewport_size.x * 0.60, viewport_size.y * 0.03)
	var finish := Vector2(viewport_size.x * 0.76, viewport_size.y * 0.69)
	var screen_position := (
		start * pow(one_minus_t, 3.0)
		+ control_a * 3.0 * pow(one_minus_t, 2.0) * t
		+ control_b * 3.0 * one_minus_t * t * t
		+ finish * pow(t, 3.0)
	)
	var planet_view_position := (
		camera_3d.global_transform.affine_inverse()
		* planet_bounds.get_center()
	)
	var planet_depth := maxf(1.0, -planet_view_position.z)
	earth_story_sun.position = camera_3d.project_position(
		screen_position,
		maxf(0.5, planet_depth - 1.6)
	)
	if earth_story_sun_material != null:
		earth_story_sun_material.set_shader_parameter(
			"sun_energy",
			lerpf(1.55, 1.08, t)
		)
		earth_story_sun_material.set_shader_parameter(
			"sun_visibility",
			1.0
		)
	if earth_story_sun_glow != null:
		earth_story_sun_glow.modulate = Color(
			1.0,
			lerpf(0.78, 0.48, t),
			0.46,
			lerpf(0.72, 0.42, t)
		)
	if t >= 0.999:
		_stop_earth_story_sun()


func _stop_earth_story_sun() -> void:
	if earth_story_sun_tween != null and earth_story_sun_tween.is_valid():
		earth_story_sun_tween.kill()
	earth_story_sun_tween = null
	if earth_story_sun != null and is_instance_valid(earth_story_sun):
		earth_story_sun.visible = false
	if earth_story_sun_glow != null and is_instance_valid(earth_story_sun_glow):
		earth_story_sun_glow.visible = false


func _start_fox_wait() -> void:
	if story_action_phase != "fox_sit" or current_3d_scene != "earth":
		return
	story_action_phase = "fox_waiting"
	story_action_button.visible = false
	_set_story_hint("陪他们等一会儿")
	var standing := _story_node_by_kind("prince_character")
	var seated := _story_node_by_kind("seated_prince_origami")
	if seated != null:
		seated.visible = true
		_set_model_alpha(seated, 0.0)
	var generation := story_action_generation
	for step in 10:
		await get_tree().create_timer(0.08).timeout
		if generation != story_action_generation or current_3d_scene != "earth":
			return
		var weight := ease(float(step + 1) / 10.0, 0.7)
		if standing != null:
			_set_model_alpha(standing, 1.0 - weight)
		if seated != null:
			_set_model_alpha(seated, weight)
	if standing != null:
		standing.visible = false
	if seated != null:
		seated.visible = true
		_set_model_alpha(seated, 1.0)
	_start_earth_story_sun(generation)
	var sunset := create_tween().set_parallel(true)
	sunset.tween_property(
		stage_environment,
		"background_color",
		Color(0.075, 0.038, 0.034),
		8.5
	)
	sunset.tween_property(
		stage_environment,
		"ambient_light_color",
		Color(0.83, 0.46, 0.28),
		8.5
	)
	sunset.tween_property(stage_environment, "ambient_light_energy", 0.56, 8.5)
	sunset.tween_property(
		stage_key_light,
		"light_color",
		Color(1.0, 0.48, 0.20),
		8.5
	)
	sunset.tween_property(stage_key_light, "light_energy", 0.52, 8.5)
	sunset.tween_property(
		warm_fill_light,
		"light_color",
		Color(1.0, 0.42, 0.12),
		8.5
	)
	await get_tree().create_timer(8.6).timeout
	if generation != story_action_generation or current_3d_scene != "earth":
		return
	_finish_planet_story_action(
		"earth",
		"太阳落下了。\n\n现在，我大概会在看见麦子的时候想起你。"
	)


func _story_node_at_screen(node: Node3D, screen_position: Vector2) -> bool:
	if node == null or camera_3d == null or not node.is_visible_in_tree():
		return false
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	if _object_ray_hit_distance(node, ray_origin, ray_direction) != INF:
		return true
	var bounds := _editable_world_bounds(node)
	if bounds.size == Vector3.ZERO:
		return false
	var center := bounds.get_center()
	if camera_3d.is_position_behind(center):
		return false
	var center_screen := camera_3d.unproject_position(center)
	var radius := camera_3d.unproject_position(
		center + camera_3d.global_basis.y * bounds.size.y * 0.5
	).distance_to(center_screen)
	return center_screen.distance_to(screen_position) <= clampf(radius, 34.0, 110.0)


func _handle_story_pointer_event(event: InputEvent) -> bool:
	if (
		stage_3d == null
		or not stage_3d.visible
		or dialogue_active
		or editor_active
		or current_3d_scene not in STORY_SCENE_SLUGS
	):
		return false
	if current_3d_scene == "earth" and earth_fox_search_active:
		if earth_fox_search_running and event is InputEventMouseButton:
			return true
		if event is InputEventMouseMotion:
			var motion := event as InputEventMouseMotion
			var over_fox := (
				not earth_fox_search_running
				and _earth_fox_hit_at_screen(motion.position)
			)
			Input.set_default_cursor_shape(
				Input.CURSOR_POINTING_HAND
				if over_fox
				else Input.CURSOR_ARROW
			)
			return false
		if event is InputEventMouseButton:
			var mouse_button := event as InputEventMouseButton
			if (
				mouse_button.button_index == MOUSE_BUTTON_LEFT
				and mouse_button.pressed
				and not earth_fox_search_running
				and _earth_fox_hit_at_screen(mouse_button.position)
			):
				_start_earth_fox_return()
				return true
	if story_action_phase == "merchant_tag":
		if event is InputEventMouseButton:
			var merchant_click := event as InputEventMouseButton
			if (
				merchant_click.button_index == MOUSE_BUTTON_LEFT
				and merchant_click.pressed
				and _story_node_at_screen(
					_story_node_by_kind("star_tag"),
					merchant_click.position
				)
			):
				_start_merchant_tally()
				return true
		elif event is InputEventMouseMotion:
			var pointer := (event as InputEventMouseMotion).position
			var over_tag := _story_node_at_screen(
				_story_node_by_kind("star_tag"),
				pointer
			)
			Input.set_default_cursor_shape(
				Input.CURSOR_POINTING_HAND if over_tag else Input.CURSOR_ARROW
			)
	return false


func _update_model_orbit(delta: float) -> void:
	if (
		model_3d == null
		or stage_3d == null
		or not stage_3d.visible
		or dragging_3d
		or model_spin_velocity.length_squared() < 0.0000001
	):
		return
	var inertia := model_spin_velocity * delta * 60.0
	_apply_model_orbit_delta(inertia)
	model_spin_velocity *= exp(-delta * 7.5)


func _apply_model_orbit_delta(rotation_delta: Vector2) -> void:
	if model_3d == null or rotation_delta.is_zero_approx():
		return
	# Camera-facing axes stay fixed in screen space, so drag direction feels
	# identical on every part of the planet.
	var yaw_step := Basis(Vector3.UP, rotation_delta.x)
	var pitch_step := Basis(Vector3.RIGHT, rotation_delta.y * 0.55)
	var preserved_scale := model_3d.scale
	model_3d.basis = (
		pitch_step
		* yaw_step
		* model_3d.basis.orthonormalized()
	)
	# Orthonormalizing the basis removes its fitted scale. Reapply it so the
	# first drag rotates in place instead of snapping the whole planet closer.
	model_3d.scale = preserved_scale
	_sync_planet_light_rig()


func _sync_planet_light_rig() -> void:
	if planet_light_rig == null:
		return
	if current_3d_scene == "player" and model_3d != null:
		# Keep the complete studio rig in the planet's local frame. Rotating the
		# model then reveals different terrain without changing its light/shadow
		# balance. Other scenes retain their established world-space lighting.
		planet_light_rig.basis = model_3d.basis.orthonormalized()
	else:
		planet_light_rig.basis = Basis.IDENTITY


func _load_pointlighter_model() -> void:
	if pointlighter_model_3d != null:
		pointlighter_model_ready = true
		return
	if pointlighter_model_loading:
		return
	pointlighter_model_loading = true
	# This scene is built outside the generated-planet cache. Start from an
	# independent editable state so stale records from another planet cannot
	# shift the IDs used by pointlighter_layout.json and duplicate its objects.
	editable_3d_objects = []
	selected_editable_index = -1
	deleted_editable_ids = []
	editable_serial = 0
	model_3d = Node3D.new()
	model_3d.name = "GeneratedPointlighterPlanet"
	stage_3d.add_child(model_3d)
	pointlighter_model_3d = model_3d
	current_3d_scene = "pointlighter"
	_set_planet_loading_progress(8.0)
	var base_added := _add_generated_planet_base(model_3d)
	_set_planet_loading_progress(20.0)
	await get_tree().process_frame
	if not base_added:
		_add_legacy_model_fallback(model_3d)
		await get_tree().process_frame
		_fit_model_to_view()
		pointlighter_model_loading = false
		pointlighter_model_ready = true
		return
	_add_planet_atmosphere(model_3d)

	var house_transform := _upright_surface_transform(
		HOUSE_SURFACE_NORMAL,
		2.35
	)
	var house_wrapper := _add_generated_part(
		model_3d,
		HOUSE_3D,
		"House",
		house_transform,
		1.65
	)
	if house_wrapper != null:
		_register_editable_3d(
			house_wrapper,
			"house",
			"小屋",
			HOUSE_SURFACE_NORMAL,
			2.35,
			true,
			0.0,
			1.65,
			HOUSE_3D,
			false
		)
		var house_light := _add_warm_glow(
			house_wrapper,
			Vector3(0.0, 0.7, 0.34),
			1.35,
			5.2,
			0.34
		)
		_attach_editor_light_anchor(house_wrapper, house_light)
	_set_planet_loading_progress(36.0)
	await get_tree().process_frame

	var lamp_origin := LAMP_SURFACE_NORMAL.normalized() * 2.35
	var lamp_basis := _upright_surface_basis(LAMP_SURFACE_NORMAL, lamp_origin)
	var lamp_transform := Transform3D(lamp_basis, lamp_origin)
	var main_lamp_wrapper := _add_generated_part(
		model_3d,
		LAMP_3D,
		"MainLamp",
		lamp_transform,
		1.90
	)
	if main_lamp_wrapper != null:
		_register_editable_3d(
			main_lamp_wrapper,
			"main_lamp",
			"主灯",
			LAMP_SURFACE_NORMAL,
			2.35,
			true,
			0.0,
			1.90,
			LAMP_3D,
			false
		)
		var main_light := _add_warm_glow(
			main_lamp_wrapper,
			Vector3(0.0, 1.56, 0.32),
			5.6,
			11.0,
			0.90
		)
		main_lamp_node = main_lamp_wrapper
		main_lamp_light_anchor = main_light
		_attach_editor_light_anchor(main_lamp_wrapper, main_light)
	var ladder_wrapper := _add_generated_part(
		model_3d,
		LADDER_3D,
		"Ladder",
		lamp_transform,
		1.08,
		lamp_basis * Vector3(0.12, 0.02, 0.18)
	)
	if ladder_wrapper != null:
		var ladder_normal := ladder_wrapper.transform.origin.normalized()
		_register_editable_3d(
			ladder_wrapper,
			"ladder",
			"梯子",
			ladder_normal,
			ladder_wrapper.transform.origin.length(),
			true,
			0.0,
			1.08,
			LADDER_3D,
			false
		)
	var character_wrapper := _add_generated_part(
		model_3d,
		LAMPLIGHTER_3D,
		"LamplighterCharacter",
		lamp_transform,
		0.96,
		lamp_basis * Vector3(-0.62, 0.08, 0.20)
	)
	if character_wrapper != null:
		lamplighter_3d = character_wrapper
		var character_normal := character_wrapper.transform.origin.normalized()
		_register_editable_3d(
			character_wrapper,
			"lamplighter",
			"点灯人",
			character_normal,
			character_wrapper.transform.origin.length(),
			true,
			0.0,
			0.96,
			LAMPLIGHTER_3D,
			false
		)
		_add_character_fill(character_wrapper)
		_lift_character_materials(character_wrapper)
		_set_character_animation_default(
			character_wrapper,
			"idle_001"
		)
	_set_planet_loading_progress(68.0)
	await get_tree().process_frame

	var standing_prince_normal := Vector3(-0.17, 0.952, 0.255).normalized()
	var standing_prince_point := standing_prince_normal * 2.38
	standing_prince_3d = _add_generated_part(
		model_3d,
		STANDING_PRINCE_3D,
		"StandingPrince",
		Transform3D(
			_normal_surface_basis(
				standing_prince_normal,
				0.0
			),
			standing_prince_point
		),
		0.74
	)
	if standing_prince_3d != null:
		_keep_first_complete_mesh(standing_prince_3d)
		_prepare_prince_character_animations(standing_prince_3d)

	var side_lamp_normal := Vector3(0.6312, 0.48356, -0.60643).normalized()
	var side_lamp_wrapper := _add_generated_part(
		model_3d,
		LAMP_3D,
		"SideLamp",
		Transform3D(
			_normal_surface_basis(side_lamp_normal, 0.0),
			side_lamp_normal * 2.38
		),
		1.0
	)
	if side_lamp_wrapper != null:
		_register_editable_3d(
			side_lamp_wrapper,
			"side_lamp",
			"侧灯",
			side_lamp_normal,
			2.38,
			false,
			0.0,
			1.0,
			LAMP_3D,
			false
		)
		var side_light := _add_warm_glow(
			side_lamp_wrapper,
			Vector3(0.0, 0.82, 0.17),
			0.90,
			4.2,
			0.28
		)
		_attach_editor_light_anchor(side_lamp_wrapper, side_light)

	var chair_normal := Vector3(-0.04335, 0.98318, 0.17741).normalized()
	var chair_transform := Transform3D(
		_normal_surface_basis(chair_normal, 127.0),
		chair_normal * 2.39
	)
	chair_3d = _add_generated_part(
		model_3d,
		CHAIR_3D,
		"Chair",
		chair_transform,
		0.8
	)
	if chair_3d != null:
		chair_3d.visible = false
		_register_editable_3d(
			chair_3d,
			"chair",
			"椅子",
			chair_normal,
			2.39,
			false,
			127.0,
			0.8,
			CHAIR_3D,
			true
		)
	var prince_wrapper := _add_generated_part(
		model_3d,
		SEATED_PRINCE_3D,
		"SeatedPrince",
		chair_transform,
		1.0,
		chair_normal * 0.24
	)
	if prince_wrapper != null:
		prince_wrapper.visible = false
		seated_prince_3d = prince_wrapper
		_register_editable_3d(
			prince_wrapper,
			"seated_prince",
			"坐姿小王子",
			chair_normal,
			2.63,
			false,
			127.0,
			1.0,
			SEATED_PRINCE_3D,
			true
		)
	_set_planet_loading_progress(88.0)
	await get_tree().process_frame

	_place_layout_asset(
		"round_tree",
		"圆冠树 01",
		ROUND_TREE_3D,
		Vector3(-0.09245, 0.9791, -0.18116),
		0.60,
		false,
		2.34,
		0.0
	)
	_place_layout_asset(
		"round_tree",
		"圆冠树 02",
		ROUND_TREE_3D,
		Vector3(-0.73583, 0.67111, 0.0904),
		0.56,
		false,
		2.34,
		0.0
	)
	_place_layout_asset(
		"pine_tree",
		"针叶树 01",
		PINE_TREE_3D,
		Vector3(-0.15781, 0.9874, -0.01155),
		0.58,
		false,
		2.34,
		0.0
	)
	_place_layout_asset(
		"pine_tree",
		"针叶树 02",
		PINE_TREE_3D,
		Vector3(-0.68179, 0.64297, 0.34893),
		0.54,
		false,
		2.34,
		0.0
	)
	_place_layout_asset(
		"stone_path",
		"石板路",
		STONE_PATH_3D,
		Vector3(0.12, 0.82, 0.54),
		1.35,
		false,
		2.34,
		0.0
	)
	for index in 3:
		var angle := TAU * float(index) / 3.0
		_place_layout_asset(
			"rocks",
			"石块 %02d" % (index + 1),
			ROCKS_3D,
			Vector3(cos(angle) * 0.52, 0.74, sin(angle) * 0.38 + 0.23),
			0.58 + index * 0.08,
			false,
			2.34,
			index * 47.0
		)
	for index in 5:
		var angle := TAU * float(index) / 5.0
		_place_layout_asset(
			"grass",
			"草丛 %02d" % (index + 1),
			GRASS_3D,
			Vector3(cos(angle) * 0.64, 0.67, sin(angle) * 0.48 + 0.2),
			0.62 + (index % 2) * 0.08,
			false,
			2.35,
			index * 31.0
		)

	if standing_prince_3d != null:
		_register_editable_3d(
			standing_prince_3d,
			"standing_prince",
			"站姿小王子",
			standing_prince_normal,
			2.38,
			true,
			0.0,
			0.74,
			STANDING_PRINCE_3D,
			false
		)

	_ensure_default_glow_point()
	await _load_3d_editor_layout()
	_set_planet_loading_progress(99.0)
	await get_tree().process_frame
	_soften_model_materials(model_3d)
	_build_firefly_flock()
	_register_main_lamp()
	_fit_model_to_view()
	_prepare_prince_chair_interaction()
	pointlighter_editable_objects = editable_3d_objects
	pointlighter_selected_editable_index = selected_editable_index
	pointlighter_model_loading = false
	pointlighter_model_ready = true


func _load_king_model() -> void:
	if king_model_3d != null:
		return
	king_model_3d = Node3D.new()
	king_model_3d.name = "GeneratedKingPlanet"
	king_model_3d.visible = false
	stage_3d.add_child(king_model_3d)
	king_editable_objects.clear()
	editable_serial = 0

	var base_model := _instantiate_generated_model(KING_BASE_3D)
	if base_model == null:
		return
	var base_bounds := _node_local_bounds(base_model)
	if base_bounds.size.y <= 0.001:
		return
	var base_scale := 3.0 / base_bounds.size.y
	base_model.scale = Vector3.ONE * base_scale
	base_model.position = Vector3(
		-base_bounds.get_center().x * base_scale,
		-base_bounds.position.y * base_scale,
		-base_bounds.get_center().z * base_scale
	)
	base_model.name = "KingPlanetBase"
	king_model_3d.add_child(base_model)
	king_floor_y = base_bounds.size.y * base_scale
	await _yield_king_model_build(95.0)

	_add_king_orbit_ring()
	_add_king_part(
		KING_CANOPY_3D,
		"king_canopy",
		"顶棚主体与立柱",
		Vector3(0.0, king_floor_y + 0.01, 0.02),
		1.10,
		0.0
	)
	_add_king_part(
		KING_CROWN_3D,
		"king_crown",
		"皇冠顶棚",
		Vector3(0.0, king_floor_y + 1.08, 0.02),
		1.25,
		0.0
	)
	_add_king_part(
		KING_DRAPES_3D,
		"king_drapes",
		"帷幔",
		Vector3(0.0, king_floor_y + 0.03, 0.02),
		1.0,
		0.0
	)
	_add_king_part(
		KING_THRONE_3D,
		"king_throne",
		"王座",
		Vector3(0.0, king_floor_y + 0.02, 0.02),
		1.0,
		0.0
	)
	_add_king_part(
		KING_BANNERS_3D,
		"king_banners",
		"旗帜",
		Vector3(0.0, king_floor_y + 0.04, 0.12),
		0.95,
		0.0
	)
	_add_king_part(
		KING_TOWER_A_3D,
		"king_tower_a",
		"小塔楼 A",
		Vector3(-0.56, king_floor_y + 0.01, 0.0),
		0.45,
		0.0
	)
	_add_king_part(
		KING_TOWER_B_3D,
		"king_tower_b",
		"小塔楼 B",
		Vector3(0.56, king_floor_y + 0.01, 0.0),
		0.43,
		0.0
	)
	king_character_3d = _add_king_part(
		KING_CHARACTER_3D,
		"king_character",
		"国王",
		Vector3(0.0, king_floor_y + 0.02, 0.02),
		0.56,
		0.0
	)
	if king_character_3d != null:
		_prepare_king_character_animations(king_character_3d)
	king_prince_3d = _add_king_part(
		KING_LOOKING_UP_PRINCE_3D,
		"looking_up_prince",
		"抬头的小王子",
		Vector3(-0.65, king_floor_y + 0.01, 0.92),
		0.55,
		0.0
	)
	if king_prince_3d != null:
		_prepare_prince_character_animations(
			king_prince_3d,
			"ambient_idle"
		)
		_set_prince_idle_head_tilt(king_prince_3d, 30.0)
	_add_king_light(
		Vector3(-0.95, 2.43, 0.56),
		0.0,
		true
	)
	await _yield_king_model_build(96.0)

	await _load_3d_editor_layout()
	await _yield_king_model_build(97.0)
	_soften_model_materials(king_model_3d)
	model_3d = king_model_3d
	_fit_model_to_view()
	_build_firefly_flock()
	await _yield_king_model_build(98.0)
	king_model_3d.visible = false
	king_editable_objects = editable_3d_objects
	king_selected_editable_index = selected_editable_index
	king_deleted_editable_ids = deleted_editable_ids


func _load_generated_planet_scene(planet_name: String, request_id: int) -> bool:
	var scene_data: Dictionary = GENERATED_PLANET_SCENES.get(planet_name, {})
	var slug := String(scene_data.get("slug", ""))
	if slug.is_empty():
		return false
	var root := Node3D.new()
	root.name = "GeneratedPlanet_" + slug.capitalize()
	root.visible = false
	stage_3d.add_child(root)
	var generic_objects: Array[Dictionary] = []
	var generic_deleted_ids: Array[String] = []
	generated_planet_models[slug] = root
	generated_planet_editable_objects[slug] = generic_objects
	generated_planet_selected_indices[slug] = -1
	generated_planet_deleted_ids[slug] = generic_deleted_ids
	generated_planet_ready[slug] = false

	_capture_current_editable_state()
	current_3d_scene = slug
	model_3d = root
	editable_3d_objects = generic_objects
	selected_editable_index = -1
	deleted_editable_ids = generic_deleted_ids
	editable_serial = 0
	_set_planet_loading_progress(12.0)

	if not _add_generated_planet_base_for_path(root, String(scene_data.base)):
		push_warning("Planet base failed to load: " + String(scene_data.base))
		root.queue_free()
		generated_planet_models.erase(slug)
		return false
	if slug == "player":
		player_asset_height_offsets.clear()
		player_asset_support_height_offsets.clear()
		player_asset_scale_defaults.clear()
		player_placement_surface_mesh = null
		player_placement_surface_body = null
		_initialize_player_placement_plane(root)
		_add_player_bridge_to_scene()
		_build_firefly_flock(true)
	# Match the completed king scene: no separate outer atmosphere sphere.
	# The generated planet mesh and stage lighting define the silhouette.
	var assets: Array = scene_data.get("assets", [])
	for index in assets.size():
		if request_id > 0 and (
			planet_loading_generation != request_id
			or not planet_zoom_active
		):
			root.queue_free()
			generated_planet_models.erase(slug)
			return false
		if typeof(assets[index]) == TYPE_DICTIONARY:
			_place_generated_planet_asset(slug, assets[index])
		_set_planet_loading_progress(
			lerpf(18.0, 88.0, float(index + 1) / float(maxi(1, assets.size())))
		)
		await get_tree().process_frame

	_ensure_default_glow_point()
	if slug == "merchant":
		for scroll_data in MERCHANT_SCROLL_ASSETS:
			_place_generated_planet_asset(slug, scroll_data)
		_place_generated_planet_asset(slug, MERCHANT_CHARACTER_ASSET)
	elif slug == "vain":
		_place_generated_planet_asset(slug, VAIN_CHARACTER_ASSET)
	if PRINCE_COMPANION_ASSETS.has(slug):
		_place_generated_planet_asset(
			slug,
			PRINCE_COMPANION_ASSETS[slug]
		)
	await _load_3d_editor_layout()
	if slug == "player":
		_ensure_default_player_prince()
		_restore_player_character_seating()
		_initialize_player_navigation()
		if not player_avatar_picker_completed and _player_has_chosen_avatar():
			player_avatar_picker_completed = true
			if not player_avatar_selected:
				player_avatar_selected = true
				_save_onboarding_state()
		if not player_avatar_picker_completed:
			_hide_player_characters_for_avatar_picker()
	await get_tree().process_frame
	if slug == "merchant":
		_build_merchant_lamp_swing_assemblies()
	_soften_model_materials(root)
	_brighten_dark_generated_materials(root)
	if slug == "player":
		_soften_player_light_terminator(root)
	model_3d = root
	_fit_model_to_view()
	if slug != "player":
		_build_firefly_flock()
	if slug == "player":
		# The authored river guide is stored in the same object space as the
		# mesh. Apply the saved hero view before converting that guide into the
		# Godot water ribbon so both keep the same orientation.
		root.quaternion = _get_initial_planet_orientation(slug)
		_sync_planet_light_rig()
		_add_player_waterways(root)
		_remove_player_authoring_helpers(root)
	root.visible = false
	generated_planet_editable_objects[slug] = editable_3d_objects
	generated_planet_selected_indices[slug] = selected_editable_index
	generated_planet_deleted_ids[slug] = deleted_editable_ids
	generated_planet_ready[slug] = true
	_touch_generated_planet_cache(slug)
	_evict_generated_planet_cache(slug)
	return true


func _initialize_player_placement_plane(root: Node3D) -> void:
	player_placement_plane_ready = false
	var base_node := root.find_child("PlanetBase", true, false) as Node3D
	if base_node == null:
		push_warning("Player placement plane: base node is missing.")
		return
	_ensure_player_placement_surface_collision(base_node)
	if player_placement_surface_mesh == null:
		push_warning("Player placement plane: authored plane is missing.")
		return
	_hide_player_placement_helper_meshes(base_node)
	var plane_transform := (
		root.global_transform.affine_inverse()
		* player_placement_surface_mesh.global_transform
	)
	var plane_bounds := player_placement_surface_mesh.mesh.get_aabb()
	var local_normal := _mesh_area_weighted_normal(
		player_placement_surface_mesh.mesh
	)
	var local_center := (
		plane_bounds.get_center()
		+ local_normal
			* PLAYER_PLACEMENT_PLANE_LIFT_LOCAL
	)
	player_placement_plane_center = plane_transform * local_center
	player_placement_plane_normal = (
		plane_transform.basis.inverse().transposed() * local_normal
	).normalized()
	if player_placement_plane_normal.y < 0.0:
		player_placement_plane_normal = -player_placement_plane_normal
	player_placement_plane_right = (
		Vector3.RIGHT
		- player_placement_plane_normal
			* Vector3.RIGHT.dot(player_placement_plane_normal)
	).normalized()
	if player_placement_plane_right.length_squared() < 0.0001:
		player_placement_plane_right = Vector3.BACK.cross(
			player_placement_plane_normal
		).normalized()
	player_placement_plane_forward = (
		player_placement_plane_normal.cross(
			player_placement_plane_right
		)
	).normalized()
	var half_right := 0.0
	var half_forward := 0.0
	for x_sign in [-1.0, 1.0]:
		for y_sign in [-1.0, 1.0]:
			for z_sign in [-1.0, 1.0]:
				var local_corner := Vector3(
					plane_bounds.position.x + (
						plane_bounds.size.x if x_sign > 0.0 else 0.0
					),
					plane_bounds.position.y + (
						plane_bounds.size.y if y_sign > 0.0 else 0.0
					),
					plane_bounds.position.z + (
						plane_bounds.size.z if z_sign > 0.0 else 0.0
					)
				)
				var relative := (
					plane_transform * local_corner
					- player_placement_plane_center
				)
				half_right = maxf(
					half_right,
					absf(relative.dot(player_placement_plane_right))
				)
				half_forward = maxf(
					half_forward,
					absf(relative.dot(player_placement_plane_forward))
				)
	player_placement_plane_half_right = maxf(half_right, 0.20)
	player_placement_plane_half_forward = maxf(half_forward, 0.20)
	player_placement_surface_mesh.visible = false
	player_placement_plane_ready = true


func _hide_player_placement_helper_meshes(base_node: Node3D) -> void:
	for item in base_node.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance == null:
			continue
		if mesh_instance == player_placement_surface_mesh:
			mesh_instance.visible = false
		elif String(mesh_instance.name).begins_with("平面"):
			mesh_instance.visible = false
			mesh_instance.mesh = null
			mesh_instance.queue_free()
		elif String(mesh_instance.name) == "圆管":
			# The river builder reads this mesh once before the node is released.
			mesh_instance.visible = false


func _remove_player_authoring_helpers(root: Node3D) -> void:
	var guide_mesh := root.find_child("圆管", true, false) as MeshInstance3D
	if guide_mesh != null:
		guide_mesh.visible = false
		guide_mesh.mesh = null
		guide_mesh.queue_free()


func _ensure_player_placement_surface_collision(base_node: Node3D) -> void:
	if player_placement_surface_body != null and is_instance_valid(
		player_placement_surface_body
	):
		return
	player_placement_surface_mesh = _find_player_placement_mesh(base_node)
	if player_placement_surface_mesh == null:
		push_warning("Player placement surface mesh is missing.")
		return
	if player_placement_surface_mesh.mesh == null:
		return
	var shape := _make_concave_mesh_shape(player_placement_surface_mesh.mesh)
	if shape.get_faces().is_empty():
		push_warning("Player placement surface collision could not be built.")
		return
	player_placement_surface_body = StaticBody3D.new()
	player_placement_surface_body.name = "PlayerPlacementSurface"
	player_placement_surface_body.collision_layer = 1 << 18
	player_placement_surface_body.collision_mask = 0
	var collision_shape := CollisionShape3D.new()
	collision_shape.name = "PlayerPlacementSurfaceShape"
	collision_shape.shape = shape
	player_placement_surface_body.add_child(collision_shape)
	player_placement_surface_mesh.add_child(player_placement_surface_body)


func _find_player_placement_mesh(base_node: Node3D) -> MeshInstance3D:
	var named_plane_node := base_node.find_child("平面", true, false)
	if named_plane_node is MeshInstance3D:
		return named_plane_node as MeshInstance3D
	var named_plane := named_plane_node as Node3D
	if named_plane != null:
		var named_meshes := named_plane.find_children(
			"*",
			"MeshInstance3D",
			true,
			false
		)
		if not named_meshes.is_empty():
			return named_meshes[0] as MeshInstance3D
	for item in base_node.find_children(
		"*",
		"MeshInstance3D",
		true,
		false
	):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance == null:
			continue
		var node_name := String(mesh_instance.get_parent().name)
		if node_name == "平面":
			return mesh_instance
	return null


func _make_concave_mesh_shape(mesh: Mesh) -> ConcavePolygonShape3D:
	var faces := PackedVector3Array()
	for surface_index in mesh.get_surface_count():
		var arrays := mesh.surface_get_arrays(surface_index)
		var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		var indices_value = arrays[Mesh.ARRAY_INDEX]
		if indices_value == null or indices_value.size() == 0:
			for vertex_index in range(0, vertices.size() - 2, 3):
				faces.append(vertices[vertex_index])
				faces.append(vertices[vertex_index + 1])
				faces.append(vertices[vertex_index + 2])
			continue
		var indices: PackedInt32Array = indices_value
		for index in range(0, indices.size() - 2, 3):
			faces.append(vertices[indices[index]])
			faces.append(vertices[indices[index + 1]])
			faces.append(vertices[indices[index + 2]])
	var shape := ConcavePolygonShape3D.new()
	shape.set_faces(faces)
	return shape


func _mesh_area_weighted_normal(mesh: Mesh) -> Vector3:
	var weighted := Vector3.ZERO
	for surface_index in mesh.get_surface_count():
		var arrays := mesh.surface_get_arrays(surface_index)
		var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		var indices_value = arrays[Mesh.ARRAY_INDEX]
		if indices_value == null or indices_value.size() == 0:
			for vertex_index in range(0, vertices.size() - 2, 3):
				var edge_a := (
					vertices[vertex_index + 1] - vertices[vertex_index]
				)
				var edge_b := (
					vertices[vertex_index + 2] - vertices[vertex_index]
				)
				weighted += edge_a.cross(edge_b)
			continue
		var indices: PackedInt32Array = indices_value
		for index in range(0, indices.size() - 2, 3):
			var edge_a := (
				vertices[indices[index + 1]]
				- vertices[indices[index]]
			)
			var edge_b := (
				vertices[indices[index + 2]]
				- vertices[indices[index]]
			)
			weighted += edge_a.cross(edge_b)
	return weighted.normalized() if weighted.length_squared() > 0.000001 \
		else Vector3.UP


func _calibrate_player_placement_plane_from_base() -> bool:
	if current_3d_scene != "player" or model_3d == null or camera_3d == null:
		return false
	if (
		player_placement_plane_ready
		and player_placement_surface_mesh != null
		and is_instance_valid(player_placement_surface_mesh)
	):
		# The authored placement mesh already supplies its transform and bounds.
		# Camera-space calibration is only a fallback for older bases.
		return true
	var base_node := model_3d.find_child("PlanetBase", true, false) as Node3D
	if base_node == null:
		return false
	var base_meshes := base_node.find_children("*", "MeshInstance3D", true, false)
	if base_meshes.is_empty():
		return false
	var base_mesh := base_meshes[0] as MeshInstance3D
	var sample_screen_points := [
		Vector2(900.0, 583.0),
		Vector2(1100.0, 567.0),
		Vector2(1150.0, 667.0),
		Vector2(917.0, 692.0),
	]
	var sample_points: Array[Vector3] = []
	for screen_point in sample_screen_points:
		var ray_origin := camera_3d.project_ray_origin(screen_point)
		var ray_direction := camera_3d.project_ray_normal(screen_point).normalized()
		var distance := _mesh_ray_hit_distance(
			base_mesh,
			ray_origin,
			ray_direction
		)
		if distance == INF:
			continue
		var world_hit := ray_origin + ray_direction * distance
		sample_points.append(
			model_3d.global_transform.affine_inverse() * world_hit
		)
	if sample_points.size() < 3:
		push_warning("Player placement plane calibration could not hit the base.")
		return false

	var center := Vector3.ZERO
	for point in sample_points:
		center += point
	center /= float(sample_points.size())
	var right := sample_points[1] - sample_points[0]
	if sample_points.size() >= 4:
		right += sample_points[2] - sample_points[3]
	var forward := sample_points[sample_points.size() - 1] - sample_points[0]
	if sample_points.size() >= 4:
		forward += sample_points[2] - sample_points[1]
	var normal := right.cross(forward).normalized()
	if normal.dot(Vector3.UP) < 0.0:
		normal = -normal
	right = (right - normal * right.dot(normal)).normalized()
	if right.length_squared() < 0.0001:
		right = Vector3.RIGHT
	forward = normal.cross(right).normalized()

	var half_right := 0.0
	var half_forward := 0.0
	for point_index in sample_points.size():
		var relative := sample_points[point_index] - center
		half_right = maxf(half_right, absf(relative.dot(right)))
		half_forward = maxf(half_forward, absf(relative.dot(forward)))
	player_placement_plane_center = center + normal * 0.012
	player_placement_plane_normal = normal
	player_placement_plane_right = right
	player_placement_plane_forward = forward
	player_placement_plane_half_right = maxf(half_right * 1.08, 1.85)
	player_placement_plane_half_forward = maxf(half_forward * 1.08, 1.15)
	player_placement_plane_ready = true
	return true


func _migrate_player_objects_to_placement_plane() -> void:
	if current_3d_scene != "player" or not player_placement_plane_ready:
		return
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		if not _is_player_plane_kind(String(record.get("kind", ""))):
			continue
		if (
			not record.has("player_migration_source_position")
			and not bool(record.get("player_needs_plane_calibration", false))
		):
			continue
		var node := record.get("node") as Node3D
		if node == null:
			continue
		var screen_center := camera_3d.unproject_position(
			node.global_position
		)
		var migration_source = record.get("player_migration_source_position", null)
		if migration_source is Vector3:
			screen_center = camera_3d.unproject_position(
				model_3d.global_transform * (migration_source as Vector3)
			)
			record.erase("player_migration_source_position")
		else:
			var world_bounds := _editable_world_bounds(node)
			if world_bounds.size != Vector3.ZERO:
				screen_center = camera_3d.unproject_position(
					world_bounds.get_center()
				)
		var snapped_transform := _player_placement_transform(
			screen_center,
			float(record.get("yaw", 0.0)),
			float(record.get("placement_footprint", 0.10))
		)
		_configure_player_plane_record(
			record,
			snapped_transform.origin,
			snapped_transform.basis.y
		)
		record.erase("player_needs_plane_calibration")
		_apply_editable_3d_record(index)


func _configure_player_plane_record(
	record: Dictionary,
	position: Vector3,
	surface_normal := player_placement_plane_normal
) -> void:
	var clamped_position := _clamp_player_placement_plane_position(position)
	var aligned_normal := _align_player_surface_normal(surface_normal)
	record["layout_mode"] = "plane"
	record["position"] = clamped_position
	record["initial_position"] = clamped_position
	record["normal"] = aligned_normal
	record["initial_normal"] = aligned_normal
	record["placement_plane_normal"] = aligned_normal
	record["root_radius"] = clamped_position.y
	record["initial_root_radius"] = clamped_position.y
	record["upright"] = true
	if not record.has("placement_height_offset"):
		record["placement_height_offset"] = 0.0
	if not record.has("initial_placement_height_offset"):
		record["initial_placement_height_offset"] = float(
			record.placement_height_offset
		)


func _ensure_default_player_prince() -> void:
	if (
		current_3d_scene != "player"
		or not player_placement_plane_ready
		or model_3d == null
	):
		return
	var default_id := "player_prince_default"
	if default_id in deleted_editable_ids:
		return
	if _find_editable_record_index_by_kind("player_prince") >= 0:
		return
	var asset_data := _player_asset_definition_for_kind("player_prince")
	if asset_data.is_empty():
		return
	var yaw := float(asset_data.get("yaw", 0.0))
	var extent := float(asset_data.get("extent", 0.62))
	var footprint := clampf(extent * 0.30, 0.045, 0.34)
	var height_offset := float(player_asset_height_offsets.get(
		"player_prince",
		-0.07
	))
	var position := _clamp_player_placement_plane_position(
		player_placement_plane_center
		+ player_placement_plane_right * 0.92
		+ player_placement_plane_forward * 0.18
	)
	var surface_normal := player_placement_plane_normal
	var wrapper := _add_player_asset_fitted(
		model_3d,
		asset_data,
		"Layout_" + default_id,
		Transform3D(
			_normal_surface_basis(surface_normal, yaw),
			position + surface_normal * (0.018 + height_offset)
		),
		extent
	)
	if wrapper == null:
		return
	_register_editable_3d(
		wrapper,
		"player_prince",
		"小王子",
		surface_normal,
		0.0,
		true,
		yaw,
		1.0,
		String(asset_data.path),
		false
	)
	var record_index := editable_3d_objects.size() - 1
	var record: Dictionary = editable_3d_objects[record_index]
	record["id"] = default_id
	record["planet_slug"] = "player"
	record["player_placeable"] = true
	record["placement_footprint"] = footprint
	record["placement_height_offset"] = height_offset
	record["initial_placement_height_offset"] = height_offset
	record["scale"] = float(player_asset_scale_defaults.get(
		"player_prince",
		0.70
	))
	record["initial_scale"] = float(record.scale)
	_configure_player_plane_record(record, position, surface_normal)
	_apply_editable_3d_record(record_index)
	_apply_character_animation_choice(wrapper, "ambient_idle", true)
	_save_3d_layout()


func _is_player_character_kind(kind: String) -> bool:
	return kind in PLAYER_CHARACTER_KINDS


func _player_character_sit_clip(kind: String) -> String:
	return "sit_001" if kind == "player_prince" else "sit"


func _player_seat_pose_key(
	character_kind: String,
	seat_kind: String
) -> String:
	return character_kind + "::" + seat_kind


func _player_seat_capacity(seat_kind: String) -> int:
	# Every authored seat has saved per-character contact offsets. Keep three
	# slots available so the player and following Prince can always share the
	# same seating surface without moving another character.
	return 3 if seat_kind in PLAYER_SEAT_KINDS else 1


func _default_player_seat_offset(
	seat_node: Node3D,
	slot_index := 0,
	slot_count := 1
) -> Vector3:
	var bounds := _node_local_bounds(seat_node)
	if bounds.size == Vector3.ZERO:
		return Vector3.ZERO
	var height_ratio := 0.34
	var slot_ratio := 0.5
	if slot_count > 1 and slot_index == 1:
		slot_ratio = 0.26
	elif slot_count > 1 and slot_index >= 2:
		slot_ratio = 0.76
	return Vector3(
		bounds.position.x + bounds.size.x * slot_ratio,
		bounds.position.y + bounds.size.y * height_ratio,
		bounds.get_center().z
	)


func _player_seat_at_screen(
	screen_position: Vector2,
	character_record: Dictionary
) -> Dictionary:
	if camera_3d == null or model_3d == null:
		return {}
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(
		screen_position
	).normalized()
	var best_seat := {}
	var best_score := INF
	for seat_record_value in editable_3d_objects:
		var seat_record: Dictionary = seat_record_value
		var seat_kind := String(seat_record.get("kind", ""))
		if seat_kind not in PLAYER_SEAT_KINDS:
			continue
		var seat_node := seat_record.get("node") as Node3D
		if (
			seat_node == null
			or not is_instance_valid(seat_node)
			or not seat_node.visible
			or bool(seat_record.get("default_hidden", false))
		):
			continue
		var slot_count := _player_seat_capacity(seat_kind)
		var occupied_count := 0
		for other_value in editable_3d_objects:
			var other: Dictionary = other_value
			if (
				String(other.get("id", ""))
					== String(character_record.get("id", ""))
				or String(other.get("seat_state", "")) != "seated"
			):
				continue
			if (
				String(other.get("seat_id", ""))
				== String(seat_record.get("id", ""))
			):
				occupied_count += 1
		if occupied_count >= slot_count:
			continue
		var mesh_hit := _object_ray_hit_distance(
			seat_node,
			ray_origin,
			ray_direction
		)
		var world_bounds := _editable_world_bounds(seat_node)
		if world_bounds.size == Vector3.ZERO:
			continue
		var center := world_bounds.get_center()
		if camera_3d.is_position_behind(center):
			continue
		var screen_center := camera_3d.unproject_position(center)
		var screen_radius := camera_3d.unproject_position(
			center + camera_3d.global_basis.x * world_bounds.size.x * 0.5
		).distance_to(screen_center)
		var base_screen := camera_3d.unproject_position(
			seat_node.global_position
		)
		var screen_distance := minf(
			screen_center.distance_to(screen_position),
			base_screen.distance_to(screen_position)
		)
		var on_screen := screen_distance <= clampf(screen_radius * 0.85, 18.0, 86.0)
		if mesh_hit == INF and not on_screen:
			continue
		var score := mesh_hit if mesh_hit != INF else screen_distance + 1000.0
		if score >= best_score:
			continue
		best_score = score
		best_seat = seat_record.duplicate()
		best_seat["seat_slot_index"] = occupied_count
		best_seat["seat_slot_count"] = slot_count
	return best_seat


func _player_character_drop_screen(
	character_record: Dictionary,
	fallback: Vector2
) -> Vector2:
	var root := character_record.get("node") as Node3D
	if (
		root == null
		or not is_instance_valid(root)
		or camera_3d == null
		or camera_3d.is_position_behind(root.global_position)
	):
		return fallback
	return camera_3d.unproject_position(root.global_position)


func _try_sit_dropped_player_character(
	record_index: int,
	screen_position: Vector2,
	announce := false
) -> bool:
	if (
		current_3d_scene != "player"
		or record_index < 0
		or record_index >= editable_3d_objects.size()
	):
		return false
	var record: Dictionary = editable_3d_objects[record_index]
	if not _is_player_character_kind(String(record.get("kind", ""))):
		return false
	var seat_record := _player_seat_at_screen(screen_position, record)
	if not seat_record.is_empty():
		_sit_player_character_at_seat(record, seat_record)
		if announce:
			player_place_status.text = "已坐下：%s" % String(
				seat_record.get("label", "座位")
			)
		return true
	if String(record.get("seat_state", "")) == "seated":
		_stand_player_character(record)
	return false


func _refresh_player_seat_riders(seat_index: int) -> void:
	if (
		current_3d_scene != "player"
		or seat_index < 0
		or seat_index >= editable_3d_objects.size()
	):
		return
	var seat_record: Dictionary = editable_3d_objects[seat_index]
	var seat_id := String(seat_record.get("id", ""))
	if seat_id.is_empty():
		return
	for rider_value in editable_3d_objects:
		var rider: Dictionary = rider_value
		if (
			String(rider.get("seat_state", "")) != "seated"
			or String(rider.get("seat_id", "")) != seat_id
		):
			continue
		_apply_player_seat_pose(rider, seat_record)


func _apply_player_seat_pose(
	character_record: Dictionary,
	seat_record: Dictionary
) -> void:
	var character_node := character_record.get("node") as Node3D
	var seat_node := seat_record.get("node") as Node3D
	if character_node == null or seat_node == null:
		return
	var character_kind := String(character_record.get("kind", ""))
	var seat_kind := String(seat_record.get("kind", ""))
	var pose_key := _player_seat_pose_key(character_kind, seat_kind)
	var saved_pose = player_seat_pose_offsets.get(pose_key, {})
	var default_offset := _default_player_seat_offset(
		seat_node,
		int(character_record.get(
			"seat_slot_index",
			seat_record.get("seat_slot_index", 0)
		)),
		int(character_record.get(
			"seat_slot_count",
			seat_record.get("seat_slot_count", 1)
		))
	)
	var local_offset := default_offset
	var yaw_delta := 0.0
	var seat_height := 0.0
	if typeof(saved_pose) == TYPE_DICTIONARY:
		var pose := saved_pose as Dictionary
		var position_value = pose.get("position", [])
		if typeof(position_value) == TYPE_ARRAY and position_value.size() >= 3:
			local_offset = Vector3(
				float(position_value[0]),
				float(position_value[1]),
				float(position_value[2])
			)
		yaw_delta = float(pose.get("yaw_delta", 0.0))
		if pose.has("height_offset"):
			seat_height = float(pose.get("height_offset", 0.0))
			local_offset.y = default_offset.y + seat_height
		else:
			seat_height = local_offset.y - default_offset.y
	var character_local_position := seat_node.transform * local_offset
	var seat_normal := (
		seat_node.transform.basis * Vector3.UP
	).normalized()
	character_record["position"] = character_local_position
	character_record["initial_position"] = character_local_position
	character_record["normal"] = seat_normal
	character_record["initial_normal"] = seat_normal
	character_record["placement_plane_normal"] = seat_normal
	character_record["placement_height_offset"] = 0.0
	character_record["initial_placement_height_offset"] = 0.0
	character_record["placement_support_id"] = String(seat_record.get("id", ""))
	character_record["placement_support_normal"] = seat_normal
	character_record["seat_height"] = seat_height
	character_record["root_radius"] = character_local_position.y
	character_record["initial_root_radius"] = character_local_position.y
	character_record["yaw"] = wrapf(
		float(seat_record.get("yaw", 0.0)) + yaw_delta,
		-180.0,
		180.0
	)
	_apply_editable_3d_record(
		_find_editable_record_index(
			String(character_record.get("id", "")),
			-1
		)
	)


func _sit_player_character_at_seat(
	character_record: Dictionary,
	seat_record: Dictionary,
	animate := true
) -> void:
	var root := character_record.get("node") as Node3D
	if root == null or not is_instance_valid(root):
		return
	if String(character_record.get("seat_state", "")) != "seated":
		var resume_animation := String(
			character_record.get(
				"selected_animation",
				root.get_meta("preferred_character_animation", "ambient_idle")
			)
		)
		if resume_animation.is_empty():
			resume_animation = "ambient_idle"
		character_record["seat_resume_animation"] = resume_animation
	character_record["seat_state"] = "seated"
	character_record["seat_id"] = String(seat_record.get("id", ""))
	character_record["seat_kind"] = String(seat_record.get("kind", ""))
	character_record["seat_slot_index"] = int(
		seat_record.get("seat_slot_index", 0)
	)
	character_record["seat_slot_count"] = int(
		seat_record.get("seat_slot_count", 1)
	)
	_apply_player_seat_pose(character_record, seat_record)
	_sync_player_place_height_control()
	if editor_active:
		_sync_editor_controls()
	var player := _find_rig_animation_player(root)
	var clip_name := _player_character_sit_clip(
		String(character_record.get("kind", ""))
	)
	if player == null or not player.has_animation(clip_name):
		return
	var animation := player.get_animation(clip_name)
	animation.loop_mode = Animation.LOOP_NONE
	character_record["seat_pose_hold_time"] = minf(
		PLAYER_SEAT_POSE_HOLD_TIME,
		maxf(animation.length - 0.001, 0.0)
	)
	player.speed_scale = 1.0
	if animate:
		character_record["seat_pose_hold_pending"] = true
		player.play(clip_name, 0.18)
	else:
		_freeze_player_character_seat_pose(character_record)


func _update_player_seated_pose_holds() -> void:
	if current_3d_scene != "player":
		return
	for record in editable_3d_objects:
		if (
			not bool(record.get("seat_pose_hold_pending", false))
			or String(record.get("seat_state", "")) != "seated"
			or not _is_player_character_kind(String(record.get("kind", "")))
		):
			continue
		var root := record.get("node") as Node3D
		var player := _find_rig_animation_player(root)
		var clip_name := _player_character_sit_clip(
			String(record.get("kind", ""))
		)
		if player == null or not player.has_animation(clip_name):
			record.erase("seat_pose_hold_pending")
			continue
		var clip := player.get_animation(clip_name)
		var hold_time := clampf(
			float(record.get(
				"seat_pose_hold_time",
				minf(PLAYER_SEAT_POSE_HOLD_TIME, clip.length)
			)),
			0.0,
			maxf(clip.length - 0.001, 0.0)
		)
		if (
			player.current_animation == clip_name
			and (
				not player.is_playing()
				or player.current_animation_position >= hold_time - 0.04
			)
		):
			player.speed_scale = 0.0
			player.seek(hold_time, true)
			player.pause()
			record.erase("seat_pose_hold_pending")
			continue
		if (
			player.current_animation.is_empty()
			or not player.is_playing()
		):
			_freeze_player_character_seat_pose(record, hold_time)
	_schedule_seated_mutual_glance_if_ready()


func _freeze_player_character_seat_pose(
	character_record: Dictionary,
	hold_time := -1.0
) -> void:
	var root := character_record.get("node") as Node3D
	if root == null or not is_instance_valid(root):
		return
	var player := _find_rig_animation_player(root)
	var clip_name := _player_character_sit_clip(
		String(character_record.get("kind", ""))
	)
	if player == null or not player.has_animation(clip_name):
		return
	var animation := player.get_animation(clip_name)
	animation.loop_mode = Animation.LOOP_NONE
	var target_time := (
		hold_time
		if hold_time >= 0.0
		else float(character_record.get(
			"seat_pose_hold_time",
			PLAYER_SEAT_POSE_HOLD_TIME
		))
	)
	target_time = clampf(
		target_time,
		0.0,
		maxf(animation.length - 0.001, 0.0)
	)
	player.speed_scale = 1.0
	player.play(clip_name, 0.0)
	# The imported sit clip contains a long idle tail. Hold at the first settled
	# seated pose instead of waiting through the whole synchronized motion.
	player.seek(target_time, true)
	player.speed_scale = 0.0
	player.pause()
	character_record.erase("seat_pose_hold_pending")


func _schedule_seated_mutual_glance_if_ready() -> void:
	if player_seated_glance_loop_active:
		return
	if not _player_seated_glance_ready():
		return
	player_seated_glance_loop_active = true
	call_deferred("_run_player_seated_glance_loop")


func _player_seated_glance_ready() -> bool:
	if (
		current_3d_scene != "player"
		or player_navigation_active
		or player_handhold_active
		or editor_active
		or dialogue_active
		or (player_place_dock != null and player_place_dock.visible)
	):
		return false
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if (
		leader_index < 0
		or prince_index < 0
		or leader_index == prince_index
	):
		return false
	var leader: Dictionary = editable_3d_objects[leader_index]
	var prince: Dictionary = editable_3d_objects[prince_index]
	var seat_id := String(leader.get("seat_id", ""))
	return not (
		seat_id.is_empty()
		or String(leader.get("seat_state", "")) != "seated"
		or String(prince.get("seat_state", "")) != "seated"
		or String(prince.get("seat_id", "")) != seat_id
		or bool(leader.get("seat_pose_hold_pending", false))
		or bool(prince.get("seat_pose_hold_pending", false))
	)


func _run_player_seated_glance_loop() -> void:
	var first_cycle := true
	while _player_seated_glance_ready():
		await get_tree().create_timer(
			0.18 if first_cycle else PLAYER_SEATED_GLANCE_INTERVAL
		).timeout
		first_cycle = false
		if not _player_seated_glance_ready():
			break
		if player_prince_look_active:
			continue
		var leader_index := _get_active_player_character_index()
		var prince_index := _player_prince_record_index()
		if leader_index < 0 or prince_index < 0:
			break
		player_prince_look_generation += 1
		player_prince_look_active = true
		_close_player_prince_interaction()
		await _run_player_prince_look_interaction(
			leader_index,
			prince_index,
			player_prince_look_generation
		)
	player_seated_glance_loop_active = false


func _restore_player_character_seating() -> void:
	if current_3d_scene != "player":
		return
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		if not _is_player_character_kind(String(record.get("kind", ""))):
			continue
		var bound_seat_id := String(record.get("seat_id", ""))
		if not bound_seat_id.is_empty():
			var seat_index := _find_editable_record_index(bound_seat_id, -1)
			if seat_index >= 0:
				var seat_record: Dictionary = (
					editable_3d_objects[seat_index].duplicate()
				)
				seat_record["seat_slot_index"] = int(
					record.get("seat_slot_index", 0)
				)
				seat_record["seat_slot_count"] = int(
					record.get(
						"seat_slot_count",
						_player_seat_capacity(String(seat_record.get(
							"kind",
							""
						)))
					)
				)
				if (
					String(record.get("seat_state", "")) == "seated"
					and String(record.get("seat_id", "")) == bound_seat_id
				):
					_apply_player_seat_pose(record, seat_record)
					_freeze_player_character_seat_pose(record)
				else:
					_sit_player_character_at_seat(
						record,
						seat_record,
						false
					)
				continue
			record.erase("seat_id")
			record.erase("seat_state")
			record.erase("seat_kind")
		var selected_animation := String(
			record.get("selected_animation", "")
		)
		if selected_animation in ["sit", "sit_001"]:
			record["selected_animation"] = "ambient_idle"
			record["initial_selected_animation"] = "ambient_idle"
			var root := record.get("node") as Node3D
			_apply_character_animation_choice(
				root,
				"ambient_idle",
				true
			)


func _capture_player_character_seat_pose(record: Dictionary) -> void:
	if (
		current_3d_scene != "player"
		or String(record.get("seat_state", "")) != "seated"
	):
		return
	var seat_id := String(record.get("seat_id", ""))
	if seat_id.is_empty():
		return
	var seat_index := _find_editable_record_index(seat_id, -1)
	if seat_index < 0:
		return
	var seat_record: Dictionary = editable_3d_objects[seat_index]
	var seat_node := seat_record.get("node") as Node3D
	var character_node := record.get("node") as Node3D
	if seat_node == null or character_node == null:
		return
	var local_offset := (
		seat_node.transform.affine_inverse()
		* character_node.transform.origin
	)
	var default_offset := _default_player_seat_offset(
		seat_node,
		int(record.get("seat_slot_index", 0)),
		int(record.get("seat_slot_count", 1))
	)
	var height_offset := local_offset.y - default_offset.y
	record["seat_height"] = height_offset
	var pose_key := _player_seat_pose_key(
		String(record.get("kind", "")),
		String(seat_record.get("kind", ""))
	)
	player_seat_pose_offsets[pose_key] = {
		"position": [local_offset.x, local_offset.y, local_offset.z],
		"height_offset": height_offset,
		"yaw_delta": wrapf(
			float(record.get("yaw", 0.0))
				- float(seat_record.get("yaw", 0.0)),
			-180.0,
			180.0
		),
	}


func _capture_player_character_seat_poses() -> void:
	if current_3d_scene != "player":
		return
	for record in editable_3d_objects:
		_capture_player_character_seat_pose(record)


func _stand_player_character(
	record: Dictionary,
	wait_for_reverse := true
) -> void:
	if String(record.get("seat_state", "")) != "seated":
		return
	record["seat_state"] = "standing"
	var standing_height := float(player_asset_height_offsets.get(
		String(record.get("kind", "")),
		0.0
	))
	record["placement_height_offset"] = standing_height
	record["initial_placement_height_offset"] = standing_height
	record.erase("seat_pose_hold_pending")
	record.erase("seat_pose_hold_time")
	record.erase("seat_height")
	_sync_player_place_height_control()
	if editor_active:
		_sync_editor_controls()
	var root := record.get("node") as Node3D
	var player := _find_rig_animation_player(root)
	var clip_name := _player_character_sit_clip(
		String(record.get("kind", ""))
	)
	if player != null and player.has_animation(clip_name):
		var animation := player.get_animation(clip_name)
		animation.loop_mode = Animation.LOOP_NONE
		player.speed_scale = 1.0
		player.play_backwards(clip_name, 0.18)
		if not wait_for_reverse:
			_complete_player_standing(record)
			return
		await player.animation_finished
	_complete_player_standing(record)


func _complete_player_standing(record: Dictionary) -> void:
	var root := record.get("node") as Node3D
	if root == null or not is_instance_valid(root):
		return
	if String(record.get("seat_state", "")) != "standing":
		return
	record.erase("seat_id")
	record.erase("seat_kind")
	var resume_animation := String(
		record.get("seat_resume_animation", "ambient_idle")
	)
	record.erase("seat_resume_animation")
	if resume_animation == _player_character_sit_clip(
		String(record.get("kind", ""))
	):
		resume_animation = "ambient_idle"
	record["selected_animation"] = resume_animation
	_apply_character_animation_choice(root, resume_animation, true)


func _initialize_player_navigation() -> void:
	active_player_character_id = ""
	player_navigation_active = false
	player_navigation_phase = "idle"
	player_navigation_serial += 1
	player_navigation_leader_id = ""
	player_navigation_prince_id = ""
	player_navigation_prince_follow_state = "idle"
	player_navigation_prince_turn_elapsed = 0.0
	player_navigation_prince_follow_target = Vector3.ZERO
	player_navigation_stuck_elapsed = 0.0
	player_navigation_progress_distance = INF
	player_navigation_follower_stuck_elapsed = 0.0
	player_navigation_follower_progress_distance = INF
	player_navigation_planned_seat.clear()
	player_navigation_pointer_seat.clear()
	_clear_player_navigation_marker()
	_refresh_player_seat_glow_markers()
	_get_active_player_character_index()
	if player_character_reset_states.is_empty():
		_capture_player_character_reset_states()


func _restore_required_player_seats() -> void:
	if current_3d_scene != "player":
		return
	for required_kind in [
		"player_star_pointlighter_chair",
		"player_star_king_throne",
	]:
		var seat_index := _find_editable_record_index_by_kind(required_kind)
		if seat_index < 0:
			continue
		var record: Dictionary = editable_3d_objects[seat_index]
		var seat_node := record.get("node") as Node3D
		if seat_node == null or not is_instance_valid(seat_node):
			continue
		record["default_hidden"] = false
		record["initial_hidden"] = false
		seat_node.visible = true


func _capture_player_character_reset_states() -> void:
	player_character_reset_states.clear()
	for record_value in editable_3d_objects:
		var record: Dictionary = record_value
		var kind := String(record.get("kind", ""))
		if kind not in PLAYER_CHARACTER_KINDS:
			continue
		player_character_reset_states[kind] = {
			"position": record.get("position", Vector3.ZERO),
			"normal": record.get(
				"placement_plane_normal",
				player_placement_plane_normal
			),
			"yaw": float(record.get("yaw", 0.0)),
			"placement_height_offset": float(
				record.get("placement_height_offset", 0.0)
			),
			"seat_state": String(record.get("seat_state", "")),
		}


func _reset_player_characters_from_stuck(
	message := "人物已复位到安全站位"
) -> void:
	if (
		current_3d_scene != "player"
		or model_3d == null
		or not player_placement_plane_ready
	):
		return
	_cancel_player_navigation(false)
	_release_player_handhold()
	_cancel_player_placement_selection()
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if leader_index < 0 or prince_index < 0:
		return
	var normal := _align_player_surface_normal(player_placement_plane_normal)
	var side := _normal_surface_basis(normal, 0.0).x
	var safe_anchor := _clamp_player_placement_plane_position(
		player_placement_plane_center
		+ player_placement_plane_right * 0.34
		+ player_placement_plane_forward * 0.20
	)
	var leader_default := safe_anchor - side * 0.11
	var prince_default := safe_anchor + side * 0.11
	_reset_player_character_pose(
		leader_index,
		leader_default,
		normal
	)
	_reset_player_character_pose(
		prince_index,
		prince_default,
		normal
	)
	if player_place_status != null:
		player_place_status.text = message
	_save_3d_layout()


func _reset_player_character_pose(
	index: int,
	fallback_position: Vector3,
	fallback_normal: Vector3
) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	var kind := String(record.get("kind", ""))
	var saved_state_value = player_character_reset_states.get(kind, {})
	var saved_state: Dictionary = {}
	if typeof(saved_state_value) == TYPE_DICTIONARY:
		saved_state = saved_state_value
	var use_saved_position := (
		not saved_state.is_empty()
		and String(saved_state.get("seat_state", "")) != "seated"
		and (saved_state.get("position", Vector3.ZERO) as Vector3).length_squared()
			> 0.000001
	)
	var position: Vector3 = (
		saved_state.get("position", fallback_position)
		if use_saved_position
		else fallback_position
	)
	var normal := _align_player_surface_normal(
		saved_state.get("normal", fallback_normal)
		if use_saved_position
		else fallback_normal
	)
	var surface_sample := _player_surface_sample_at_position(
		position,
		float(record.get("placement_footprint", 0.10))
	)
	if not surface_sample.is_empty():
		position = surface_sample.position
		normal = surface_sample.normal
	var height_offset := float(
		saved_state.get(
			"placement_height_offset",
			record.get("placement_height_offset", 0.0)
		)
	)
	if _player_standing_height_locked(record):
		height_offset = float(player_asset_height_offsets.get(
			kind,
			height_offset
		))
	var yaw := float(
		saved_state.get("yaw", record.get("yaw", 0.0))
		if use_saved_position
		else _player_navigation_facing_yaw(
			player_placement_plane_forward,
			normal
		)
	)
	record["position"] = position
	record["normal"] = normal
	record["placement_plane_normal"] = normal
	record["root_radius"] = position.y
	record["yaw"] = wrapf(yaw, -180.0, 180.0)
	record["placement_height_offset"] = height_offset
	record["seat_state"] = "standing"
	record["selected_animation"] = "ambient_idle"
	record.erase("seat_id")
	record.erase("seat_kind")
	record.erase("seat_slot_index")
	record.erase("seat_slot_count")
	record.erase("seat_pose_hold_pending")
	record.erase("seat_pose_hold_time")
	record.erase("placement_support_id")
	record.erase("placement_support_normal")
	_apply_editable_3d_record(index)
	_set_player_navigation_walk(index, false)


func _toggle_player_handhold() -> void:
	if player_handhold_active:
		_release_player_handhold()
		return
	call_deferred("_start_player_handhold")


func _open_player_prince_interaction() -> void:
	if (
		current_3d_scene != "player"
		or editor_active
		or dialogue_active
		or (player_place_dock != null and player_place_dock.visible)
	):
		return
	player_prince_interaction_open = true
	_update_player_prince_interaction_button()


func _close_player_prince_interaction() -> void:
	player_prince_interaction_open = false
	if player_prince_interaction_button != null:
		player_prince_interaction_button.visible = false
	if player_prince_look_button != null:
		player_prince_look_button.visible = false


func _update_player_prince_interaction_button() -> void:
	var button := player_prince_interaction_button
	if button == null:
		return
	if (
		not player_prince_interaction_open
		or current_3d_scene != "player"
		or camera_3d == null
		or editor_active
		or dialogue_active
		or (player_place_dock != null and player_place_dock.visible)
	):
		button.visible = false
		if player_prince_look_button != null:
			player_prince_look_button.visible = false
		return
	var prince_index := _find_editable_record_index_by_kind("player_prince")
	if prince_index < 0 or prince_index >= editable_3d_objects.size():
		button.visible = false
		if player_prince_look_button != null:
			player_prince_look_button.visible = false
		return
	var prince_node := editable_3d_objects[prince_index].get("node") as Node3D
	if prince_node == null or not prince_node.is_visible_in_tree():
		button.visible = false
		if player_prince_look_button != null:
			player_prince_look_button.visible = false
		return
	var bounds := _editable_world_bounds(prince_node)
	var prince_up := prince_node.global_transform.basis.y.normalized()
	var head_world := (
		bounds.get_center()
		+ prince_up * maxf(bounds.size.y * 0.62, 0.30)
	)
	if camera_3d.is_position_behind(head_world):
		button.visible = false
		if player_prince_look_button != null:
			player_prince_look_button.visible = false
		return
	var viewport_size := get_viewport().get_visible_rect().size
	var screen_center := camera_3d.unproject_position(head_world)
	var leader_index := _get_active_player_character_index()
	var leader_node := (
		editable_3d_objects[leader_index].get("node") as Node3D
		if leader_index >= 0
		else null
	)
	var can_look := (
		not player_prince_look_active
		and not player_handhold_active
		and not player_navigation_active
		and not bool(editable_3d_objects[prince_index].get(
			"seat_pose_hold_pending",
			false
		))
		and not (
			leader_index >= 0
			and bool(editable_3d_objects[leader_index].get(
				"seat_pose_hold_pending",
				false
			))
		)
		and leader_node != null
		and leader_node.global_position.distance_to(prince_node.global_position) <= 0.72
	)
	var button_centers: Array[Vector2] = []
	if can_look:
		button_centers = [
			screen_center + Vector2(-31.0, 0.0),
			screen_center + Vector2(31.0, 0.0),
		]
	else:
		button_centers = [screen_center]
	for center_index in button_centers.size():
		var center := button_centers[center_index]
		center.x = clampf(center.x, 36.0, viewport_size.x - 36.0)
		center.y = clampf(center.y, 36.0, viewport_size.y - 36.0)
		button_centers[center_index] = center
	button.position = button_centers[0] - button.size * 0.5
	button.pivot_offset = button.size * 0.5
	button.scale = Vector2.ONE * (
		1.0 + 0.035 * sin(Time.get_ticks_msec() * 0.006)
	)
	button.tooltip_text = (
		"松开手"
		if player_handhold_active
		else "和小王子牵手"
	)
	button.modulate = (
		Color(1.0, 0.94, 0.72, 1.0)
		if player_handhold_active
		else Color.WHITE
	)
	button.visible = true
	var look_button := player_prince_look_button
	if look_button != null:
		look_button.visible = can_look
		if can_look:
			look_button.position = button_centers[1] - look_button.size * 0.5
			look_button.pivot_offset = look_button.size * 0.5
			look_button.scale = Vector2.ONE * (
				1.0 + 0.035 * sin(Time.get_ticks_msec() * 0.006 + 1.7)
			)
			var leader_record := editable_3d_objects[leader_index]
			var both_seated := (
				String(leader_record.get("seat_state", "")) == "seated"
				and String(editable_3d_objects[prince_index].get(
					"seat_state",
					""
				)) == "seated"
			)
			look_button.text = "看看" if both_seated else "互看"
			look_button.tooltip_text = (
				"转头看向小王子"
				if both_seated
				else "和小王子互相看看"
			)


func _on_player_prince_hand_action_pressed() -> void:
	AudioDirector.play_sfx("ui_soft")
	_toggle_player_handhold()


func _on_player_prince_look_action_pressed() -> void:
	if player_prince_look_active:
		return
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if leader_index < 0 or prince_index < 0 or leader_index == prince_index:
		return
	AudioDirector.play_sfx("ui_soft")
	player_prince_look_generation += 1
	player_prince_look_active = true
	_close_player_prince_interaction()
	call_deferred(
		"_run_player_prince_look_interaction",
		leader_index,
		prince_index,
		player_prince_look_generation
	)


func _run_player_prince_look_interaction(
	leader_index: int,
	prince_index: int,
	generation: int
) -> void:
	if (
		generation != player_prince_look_generation
		or current_3d_scene != "player"
		or leader_index < 0
		or prince_index < 0
		or leader_index >= editable_3d_objects.size()
		or prince_index >= editable_3d_objects.size()
	):
		_finish_player_prince_look_interaction(generation)
		return
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	var prince_record: Dictionary = editable_3d_objects[prince_index]
	var leader_node := leader_record.get("node") as Node3D
	var prince_node := prince_record.get("node") as Node3D
	if (
		leader_node == null
		or prince_node == null
		or not is_instance_valid(leader_node)
		or not is_instance_valid(prince_node)
	):
		_finish_player_prince_look_interaction(generation)
		return
	var leader_seated := String(leader_record.get("seat_state", "")) == "seated"
	var prince_seated := String(prince_record.get("seat_state", "")) == "seated"
	if not leader_seated and not prince_seated:
		await _face_player_characters_toward_each_other(
			leader_index,
			prince_index
		)
	if generation != player_prince_look_generation:
		return
	var leader_animation := _suspend_player_animation_for_glance(leader_node)
	var prince_animation := _suspend_player_animation_for_glance(prince_node)
	var leader_head := _capture_player_head_glance(leader_node, prince_node)
	var prince_head := _capture_player_head_glance(prince_node, leader_node)
	await _animate_player_mutual_head_glance(
		leader_head,
		prince_head
	)
	_restore_player_head_glance(prince_head)
	_restore_player_head_glance(leader_head)
	if not leader_seated:
		_resume_player_animation_after_glance(leader_animation)
	if not prince_seated:
		_resume_player_animation_after_glance(prince_animation)
	_finish_player_prince_look_interaction(generation)


func _finish_player_prince_look_interaction(generation: int) -> void:
	if generation != player_prince_look_generation:
		return
	player_prince_look_active = false
	_update_player_prince_interaction_button()


func _face_player_characters_toward_each_other(
	leader_index: int,
	prince_index: int
) -> void:
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	var prince_record: Dictionary = editable_3d_objects[prince_index]
	var leader_from := float(leader_record.get("yaw", 0.0))
	var prince_from := float(prince_record.get("yaw", 0.0))
	var leader_to := _player_character_yaw_toward_record(
		leader_record,
		prince_record
	)
	var prince_to := _player_character_yaw_toward_record(
		prince_record,
		leader_record
	)
	var leader_tween_to := leader_from + wrapf(
		leader_to - leader_from,
		-180.0,
		180.0
	)
	var prince_tween_to := prince_from + wrapf(
		prince_to - prince_from,
		-180.0,
		180.0
	)
	var duration := 0.30
	var elapsed := 0.0
	while elapsed < duration:
		elapsed += get_process_delta_time()
		var progress := clampf(elapsed / duration, 0.0, 1.0)
		var eased := progress * progress * (3.0 - 2.0 * progress)
		_set_player_character_yaw_for_glance(
			lerpf(leader_from, leader_tween_to, eased),
			leader_index
		)
		_set_player_character_yaw_for_glance(
			lerpf(prince_from, prince_tween_to, eased),
			prince_index
		)
		await get_tree().process_frame
	_set_player_character_yaw_for_glance(leader_to, leader_index)
	_set_player_character_yaw_for_glance(prince_to, prince_index)


func _turn_player_character_toward_record(
	source_index: int,
	target_index: int,
	duration := 0.30
) -> bool:
	if (
		source_index < 0
		or target_index < 0
		or source_index >= editable_3d_objects.size()
		or target_index >= editable_3d_objects.size()
		or source_index == target_index
	):
		return false
	var source_record: Dictionary = editable_3d_objects[source_index]
	var target_record: Dictionary = editable_3d_objects[target_index]
	var source_from := float(source_record.get("yaw", 0.0))
	var source_to := _player_character_yaw_toward_record(
		source_record,
		target_record
	)
	var tween_to := source_from + wrapf(
		source_to - source_from,
		-180.0,
		180.0
	)
	if absf(tween_to - source_from) <= 0.01:
		_set_player_character_yaw_for_glance(source_to, source_index)
		return true
	var elapsed := 0.0
	while elapsed < duration:
		elapsed += get_process_delta_time()
		var progress := clampf(elapsed / duration, 0.0, 1.0)
		var eased := progress * progress * (3.0 - 2.0 * progress)
		_set_player_character_yaw_for_glance(
			lerpf(source_from, tween_to, eased),
			source_index
		)
		await get_tree().process_frame
	_set_player_character_yaw_for_glance(source_to, source_index)
	return true


func _set_player_character_yaw_for_glance(
	value: float,
	index: int
) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	record["yaw"] = wrapf(value, -180.0, 180.0)
	_apply_editable_3d_record(index)


func _player_character_yaw_toward_record(
	source: Dictionary,
	target: Dictionary
) -> float:
	var normal := _align_player_surface_normal(
		source.get(
			"placement_plane_normal",
			source.get("normal", player_placement_plane_normal)
		)
	)
	var direction := (
		(target.get("position", Vector3.ZERO) as Vector3)
		- (source.get("position", Vector3.ZERO) as Vector3)
	)
	direction -= normal * direction.dot(normal)
	if direction.length_squared() <= 0.000001:
		return float(source.get("yaw", 0.0))
	return _player_navigation_facing_yaw(direction, normal)


func _suspend_player_animation_for_glance(root: Node3D) -> Dictionary:
	var player := _find_rig_animation_player(root)
	if player == null:
		return {}
	var state := {
		"player": player,
		"clip": player.current_animation,
		"position": player.current_animation_position,
		"speed": player.speed_scale,
		"playing": player.is_playing(),
	}
	player.pause()
	return state


func _resume_player_animation_after_glance(state: Dictionary) -> void:
	if state.is_empty():
		return
	var player := state.get("player") as AnimationPlayer
	if player == null or not is_instance_valid(player):
		return
	player.speed_scale = float(state.get("speed", 1.0))
	var clip_name := String(state.get("clip", ""))
	if clip_name.is_empty() or not player.has_animation(clip_name):
		return
	player.play(clip_name, 0.0)
	player.seek(float(state.get("position", 0.0)), true)
	if not bool(state.get("playing", true)):
		player.pause()


func _capture_player_head_glance(
	root: Node3D,
	target: Node3D
) -> Dictionary:
	var skeleton: Skeleton3D
	var skeletons := root.find_children("*", "Skeleton3D", true, false)
	if not skeletons.is_empty():
		skeleton = skeletons[0] as Skeleton3D
	if skeleton == null:
		return {}
	var bone_index := skeleton.find_bone("Head")
	if bone_index < 0:
		return {}
	var local_target := (
		root.global_transform.affine_inverse()
		* target.global_position
	)
	var turn_sign := signf(local_target.z)
	if is_zero_approx(turn_sign):
		turn_sign = 1.0 if local_target.x >= 0.0 else -1.0
	var spine_bone_index := skeleton.find_bone("Spine01")
	if spine_bone_index < 0:
		spine_bone_index = skeleton.find_bone("Spine02")
	return {
		"skeleton": skeleton,
		"bone": bone_index,
		"rotation": skeleton.get_bone_pose_rotation(bone_index),
		"spine_bone": spine_bone_index,
		"spine_rotation": (
			skeleton.get_bone_pose_rotation(spine_bone_index)
			if spine_bone_index >= 0
			else Quaternion.IDENTITY
		),
		"turn_sign": turn_sign,
	}


func _apply_player_head_glance(
	weight: float,
	pose: Dictionary,
	turn_degrees: float
) -> void:
	if pose.is_empty():
		return
	var skeleton := pose.get("skeleton") as Skeleton3D
	if skeleton == null or not is_instance_valid(skeleton):
		return
	var base := pose.get("rotation", Quaternion.IDENTITY) as Quaternion
	var turn := deg_to_rad(
		-float(pose.get("turn_sign", 1.0)) * turn_degrees * weight
	)
	var nod := deg_to_rad(-2.2 * weight)
	var gesture := (
		Quaternion(Vector3.UP, turn)
		* Quaternion(Vector3.RIGHT, nod)
	)
	skeleton.set_bone_pose_rotation(
		int(pose.get("bone", -1)),
		(base * gesture).normalized()
	)
	var spine_bone := int(pose.get("spine_bone", -1))
	if spine_bone >= 0:
		var spine_base := (
			pose.get("spine_rotation", Quaternion.IDENTITY)
			as Quaternion
		)
		var spine_turn := Quaternion(
			Vector3.UP,
			turn * 0.38
		)
		skeleton.set_bone_pose_rotation(
			spine_bone,
			(spine_base * spine_turn).normalized()
		)


func _animate_player_mutual_head_glance(
	leader_pose: Dictionary,
	prince_pose: Dictionary
) -> void:
	if leader_pose.is_empty() and prince_pose.is_empty():
		return
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(
		Callable(self, "_apply_player_head_glance").bind(
			leader_pose,
			42.0
		),
		0.0,
		1.0,
		PLAYER_GLANCE_TURN_DURATION
	)
	tween.parallel().tween_method(
		Callable(self, "_apply_player_head_glance").bind(
			prince_pose,
			52.0
		),
		0.0,
		1.0,
		PLAYER_GLANCE_TURN_DURATION
	)
	tween.tween_interval(PLAYER_GLANCE_HOLD_DURATION)
	tween.tween_method(
		Callable(self, "_apply_player_head_glance").bind(
			leader_pose,
			42.0
		),
		1.0,
		0.0,
		PLAYER_GLANCE_RETURN_DURATION
	)
	tween.parallel().tween_method(
		Callable(self, "_apply_player_head_glance").bind(
			prince_pose,
			52.0
		),
		1.0,
		0.0,
		PLAYER_GLANCE_RETURN_DURATION
	)
	await tween.finished


func _restore_player_head_glance(pose: Dictionary) -> void:
	if pose.is_empty():
		return
	var skeleton := pose.get("skeleton") as Skeleton3D
	if skeleton == null or not is_instance_valid(skeleton):
		return
	skeleton.set_bone_pose_rotation(
		int(pose.get("bone", -1)),
		pose.get("rotation", Quaternion.IDENTITY) as Quaternion
	)
	var spine_bone := int(pose.get("spine_bone", -1))
	if spine_bone >= 0:
		skeleton.set_bone_pose_rotation(
			spine_bone,
			pose.get("spine_rotation", Quaternion.IDENTITY) as Quaternion
		)


func _open_player_character_interaction(index: int) -> void:
	if (
		current_3d_scene != "player"
		or index < 0
		or index >= editable_3d_objects.size()
		or editor_active
		or dialogue_active
		or (player_place_dock != null and player_place_dock.visible)
	):
		return
	player_character_interaction_open = true
	if player_expression_bar != null:
		player_expression_bar.visible = false
	_update_player_character_interaction_buttons()


func _close_player_character_interaction(close_expression_bar := true) -> void:
	player_character_interaction_open = false
	if close_expression_bar and player_expression_bar != null:
		player_expression_bar.visible = false


func _on_player_dialogue_symbol_pressed() -> void:
	if (
		current_3d_scene == "player"
		and not dialogue_active
		and not editor_active
	):
		AudioDirector.play_sfx("ui_soft")
		_start_player_prince_dialogue()


func _on_player_save_symbol_pressed() -> void:
	if (
		current_3d_scene != "player"
		or editor_active
		or (
			player_keepsake_flow != null
			and bool(player_keepsake_flow.visible)
		)
	):
		return
	AudioDirector.play_sfx("ui_primary")
	_capture_current_editable_state()
	_save_3d_layout()
	if player_place_status != null:
		player_place_status.text = "当前摆放已保存"
	_show_player_save_toast("已保存")


func _show_player_save_toast(message: String) -> void:
	if player_save_toast == null:
		return
	if player_save_toast_tween != null and player_save_toast_tween.is_valid():
		player_save_toast_tween.kill()
	var viewport_size := get_viewport().get_visible_rect().size
	player_save_toast.text = message
	player_save_toast.position = Vector2(
		42.0,
		viewport_size.y - 160.0
	)
	player_save_toast.pivot_offset = player_save_toast.size * 0.5
	player_save_toast.visible = true
	player_save_toast.modulate = Color(1.0, 1.0, 1.0, 0.0)
	player_save_toast.scale = Vector2.ONE * 0.86
	player_save_toast_tween = create_tween()
	player_save_toast_tween.set_trans(Tween.TRANS_BACK).set_ease(
		Tween.EASE_OUT
	)
	player_save_toast_tween.tween_property(
		player_save_toast,
		"modulate:a",
		1.0,
		0.16
	)
	player_save_toast_tween.parallel().tween_property(
		player_save_toast,
		"scale",
		Vector2.ONE,
		0.20
	)
	player_save_toast_tween.tween_interval(1.15)
	player_save_toast_tween.tween_property(
		player_save_toast,
		"modulate:a",
		0.0,
		0.35
	)
	player_save_toast_tween.tween_callback(
		func() -> void:
			if player_save_toast != null:
				player_save_toast.visible = false
	)


func _on_player_photo_symbol_pressed() -> void:
	if (
		current_3d_scene != "player"
		or editor_active
		or camera_3d == null
		or player_keepsake_flow == null
	):
		return
	AudioDirector.play_sfx("ui_primary")
	_close_player_character_interaction()
	_close_player_prince_interaction()
	_close_player_placement_dock()
	_cancel_player_navigation(false)
	_cancel_player_placement_selection()
	_cancel_player_light_string_mode()
	_reset_pointer_interactions()
	model_spin_velocity = Vector2.ZERO
	player_keepsake_flow.open_capture()


func _on_player_keepsake_flow_closed() -> void:
	_update_player_character_interaction_buttons()
	_refresh_player_scene_hint()


func _on_player_keepsake_letter_saved(path: String) -> void:
	print("PLAYER_PLANET_LETTER_SAVED path=", path)


func _on_player_sticker_symbol_pressed() -> void:
	if (
		current_3d_scene != "player"
		or player_expression_bar == null
	):
		return
	AudioDirector.play_sfx("ui_soft")
	player_expression_bar.visible = not player_expression_bar.visible
	if player_expression_bar.visible and player_expression_scroll != null:
		player_expression_scroll.scroll_horizontal = 0
	_update_player_character_interaction_buttons()


func _update_player_character_interaction_buttons() -> void:
	var place_button := player_place_button
	var dialogue_button := player_dialogue_symbol_button
	var sticker_button := player_sticker_symbol_button
	var save_button := player_save_symbol_button
	var photo_button := player_photo_symbol_button
	if (
		place_button == null
		or dialogue_button == null
		or sticker_button == null
		or save_button == null
		or photo_button == null
	):
		return
	if (
		current_3d_scene != "player"
		or camera_3d == null
		or editor_active
		or dialogue_active
		or player_avatar_picker_open
		or (
			player_keepsake_flow != null
			and bool(player_keepsake_flow.visible)
		)
	):
		place_button.visible = false
		dialogue_button.visible = false
		sticker_button.visible = false
		save_button.visible = false
		photo_button.visible = false
		if player_expression_bar != null:
			player_expression_bar.visible = false
		return
	var leader_index := _get_active_player_character_index()
	var leader_record: Dictionary = {}
	var leader_node: Node3D = null
	if leader_index >= 0 and leader_index < editable_3d_objects.size():
		leader_record = editable_3d_objects[leader_index]
		leader_node = leader_record.get("node") as Node3D
	var has_leader := leader_node != null and leader_node.is_visible_in_tree()
	var prince_index := _player_prince_record_index()
	var has_prince := (
		prince_index >= 0
		and editable_3d_objects[prince_index].get("node") is Node3D
	)
	if not has_leader and player_expression_bar != null:
		player_expression_bar.visible = false
	var viewport_size := get_viewport().get_visible_rect().size
	var button_size := Vector2(80.0, 80.0)
	var right_margin := 44.0
	var symbol_gap := 14.0
	var column_buttons: Array[Button] = [
		place_button,
		save_button,
		photo_button,
		dialogue_button,
		sticker_button,
	]
	var column_height := 0.0
	for symbol_button in column_buttons:
		symbol_button.size = button_size
		symbol_button.add_theme_constant_override("icon_max_width", 74)
		column_height += symbol_button.size.y
	column_height += symbol_gap * float(column_buttons.size() - 1)
	var cursor_y := viewport_size.y * 0.5 - column_height * 0.5
	for symbol_button in column_buttons:
		var center := Vector2(
			viewport_size.x - right_margin - symbol_button.size.x * 0.5,
			cursor_y + symbol_button.size.y * 0.5
		)
		symbol_button.position = (
			center - symbol_button.size * 0.5
		)
		symbol_button.pivot_offset = symbol_button.size * 0.5
		var button_scale := 1.0 + 0.025 * sin(
			Time.get_ticks_msec() * 0.006
		)
		if symbol_button == place_button and player_place_dock.visible:
			var feedback_age := maxf(
				0.0,
				float(
					Time.get_ticks_msec()
					- player_place_button_feedback_started_msec
				) / 1000.0
			)
			button_scale = (
				1.07
				+ 0.13
				* exp(-7.0 * feedback_age)
				* maxf(cos(feedback_age * 18.0), 0.0)
			)
		symbol_button.scale = Vector2.ONE * button_scale
		symbol_button.visible = true
		cursor_y += symbol_button.size.y + symbol_gap
	place_button.disabled = false
	save_button.disabled = false
	photo_button.disabled = not has_leader
	dialogue_button.disabled = not (has_leader and has_prince)
	sticker_button.disabled = not has_leader
	sticker_button.modulate = (
		Color(1.0, 0.94, 0.73, 1.0)
		if (
			has_leader
			and player_expression_bar != null
			and player_expression_bar.visible
		)
		else (
			Color.WHITE
			if has_leader
			else Color(0.78, 0.80, 0.80, 0.50)
		)
	)
	photo_button.modulate = (
		Color.WHITE
		if has_leader
		else Color(0.78, 0.80, 0.80, 0.50)
	)
	dialogue_button.modulate = (
		Color.WHITE
		if has_leader and has_prince
		else Color(0.78, 0.80, 0.80, 0.50)
	)
	place_button.modulate = (
		Color(1.0, 0.82, 0.46, 1.0)
		if player_place_dock.visible
		else Color.WHITE
	)
	save_button.modulate = (
		Color(1.0, 0.95, 0.76, 1.0)
		if player_save_toast != null and player_save_toast.visible
		else Color.WHITE
	)
	if player_save_toast != null and player_save_toast.visible:
		player_save_toast.position = Vector2(
			save_button.position.x - player_save_toast.size.x - 12.0,
			save_button.position.y + (
				save_button.size.y - player_save_toast.size.y
			) * 0.5
		)


func _on_player_expression_pressed(expression_id: String) -> void:
	if (
		current_3d_scene != "player"
		or player_expression_bar == null
		or not player_expression_bar.visible
	):
		return
	var now := Time.get_ticks_msec()
	if now < player_expression_cooldown_until_msec:
		return
	var expression := _player_expression_data(expression_id)
	if expression.is_empty():
		return
	AudioDirector.play_sfx("ui_soft")
	var player_texture := load(
		PLAYER_EXPRESSION_DIR + expression_id + ".png"
	) as Texture2D
	var reply_id := String(expression.get("prince", ""))
	var prince_texture := load(
		PRINCE_EXPRESSION_DIR + reply_id + ".png"
	) as Texture2D
	if player_texture == null or prince_texture == null:
		return
	player_expression_cooldown_until_msec = now + 1200
	player_expression_last_sent = expression_id
	player_expression_last_reply = reply_id
	player_expression_history.append({
		"sent": expression_id,
		"reply": reply_id,
	})
	if player_expression_history.size() > 20:
		player_expression_history.pop_front()
	player_expression_generation += 1
	var generation := player_expression_generation
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	_cancel_player_navigation(false)
	if not await _turn_player_character_toward_record(
		leader_index,
		prince_index
	):
		return
	if (
		generation != player_expression_generation
		or current_3d_scene != "player"
	):
		return
	_show_player_expression_popup(player_texture)
	call_deferred(
		"_show_prince_expression_reply_after_delay",
		prince_texture,
		generation
	)


func _player_expression_data(expression_id: String) -> Dictionary:
	for value in PLAYER_EXPRESSIONS:
		var expression: Dictionary = value
		if String(expression.get("id", "")) == expression_id:
			return expression
	return {}


func _show_player_expression_popup(texture: Texture2D) -> void:
	if player_expression_popup == null:
		return
	if player_expression_tween != null and player_expression_tween.is_valid():
		player_expression_tween.kill()
	player_expression_popup.texture = texture
	player_expression_popup.visible = true
	player_expression_popup.modulate = Color(1.0, 1.0, 1.0, 0.0)
	player_expression_popup.scale = Vector2.ONE * 0.72
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		player_expression_popup,
		"modulate:a",
		1.0,
		0.18
	)
	tween.parallel().tween_property(
		player_expression_popup,
		"scale",
		Vector2.ONE * 1.05,
		0.24
	)
	tween.tween_interval(3.35)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(
		player_expression_popup,
		"modulate:a",
		0.0,
		0.38
	)
	tween.tween_callback(player_expression_popup.hide)
	player_expression_tween = tween


func _show_prince_expression_reply_after_delay(
	texture: Texture2D,
	generation: int
) -> void:
	await get_tree().create_timer(PRINCE_EXPRESSION_REPLY_DELAY).timeout
	if (
		generation != player_expression_generation
		or current_3d_scene != "player"
		or prince_expression_popup == null
	):
		return
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if not await _turn_player_character_toward_record(
		prince_index,
		leader_index
	):
		return
	if (
		generation != player_expression_generation
		or current_3d_scene != "player"
		or prince_expression_popup == null
	):
		return
	if prince_expression_tween != null and prince_expression_tween.is_valid():
		prince_expression_tween.kill()
	prince_expression_popup.texture = texture
	prince_expression_popup.visible = true
	prince_expression_popup.modulate = Color(1.0, 1.0, 1.0, 0.0)
	prince_expression_popup.scale = Vector2.ONE * 0.72
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		prince_expression_popup,
		"modulate:a",
		1.0,
		0.18
	)
	tween.parallel().tween_property(
		prince_expression_popup,
		"scale",
		Vector2.ONE * 1.05,
		0.24
	)
	tween.tween_interval(3.15)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(
		prince_expression_popup,
		"modulate:a",
		0.0,
		0.38
	)
	tween.tween_callback(prince_expression_popup.hide)
	prince_expression_tween = tween


func _update_player_expression_popups() -> void:
	if (
		player_expression_overlay == null
		or camera_3d == null
		or current_3d_scene != "player"
	):
		return
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	_position_expression_popup_for_record(
		player_expression_popup,
		leader_index,
		Vector2(-43.0, -10.0)
	)
	_position_expression_popup_for_record(
		prince_expression_popup,
		prince_index,
		Vector2(43.0, -10.0)
	)


func _position_expression_popup_for_record(
	popup: TextureRect,
	record_index: int,
	offset: Vector2
) -> void:
	if (
		popup == null
		or not popup.visible
		or record_index < 0
		or record_index >= editable_3d_objects.size()
		or camera_3d == null
	):
		return
	var node := editable_3d_objects[record_index].get("node") as Node3D
	if node == null or not is_instance_valid(node):
		popup.visible = false
		return
	var bounds := _editable_world_bounds(node)
	var up := node.global_transform.basis.y.normalized()
	var head_world := bounds.get_center() + up * maxf(
		bounds.size.y * 0.62,
		0.32
	)
	if camera_3d.is_position_behind(head_world):
		return
	var screen_center := camera_3d.unproject_position(head_world)
	var viewport_size := get_viewport().get_visible_rect().size
	var popup_center := screen_center + offset
	popup_center.x = clampf(
		popup_center.x,
		popup.size.x * 0.5 + 6.0,
		viewport_size.x - popup.size.x * 0.5 - 6.0
	)
	popup_center.y = clampf(
		popup_center.y,
		popup.size.y * 0.5 + 6.0,
		viewport_size.y - popup.size.y * 0.5 - 6.0
	)
	popup.position = popup_center - popup.size * 0.5


func _start_player_handhold() -> void:
	if (
		current_3d_scene != "player"
		or player_handhold_active
		or player_place_dock != null and player_place_dock.visible
	):
		return
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if leader_index < 0 or prince_index < 0:
		return
	if player_navigation_active:
		_cancel_player_navigation(false)
	player_handhold_active = true
	player_navigation_prince_follow_state = "idle"
	for character_index in [leader_index, prince_index]:
		var record: Dictionary = editable_3d_objects[character_index]
		if String(record.get("seat_state", "")) == "seated":
			await _stand_player_character(record, true)
	if not player_handhold_active or current_3d_scene != "player":
		return
	# Selecting an interaction closes the temporary interaction tree.
	_close_player_prince_interaction()
	if player_place_status != null:
		var leader_record: Dictionary = editable_3d_objects[leader_index]
		var prince_record: Dictionary = editable_3d_objects[prince_index]
		var leader_node := leader_record.get("node") as Node3D
		var prince_node := prince_record.get("node") as Node3D
		player_place_status.text = (
			"正在靠近小王子准备牵手"
			if (
				leader_node == null
				or prince_node == null
				or leader_node.global_position.distance_to(
					prince_node.global_position
				) > PLAYER_HANDHOLD_ATTACH_DISTANCE
			)
			else "已牵手 | 点击地面带着小王子走"
		)
	_update_player_handhold_link()


func _release_player_handhold() -> void:
	if not player_handhold_active:
		return
	player_handhold_active = false
	_clear_player_handhold_link()
	if player_navigation_prince_follow_state != "idle":
		player_navigation_prince_follow_state = "idle"
		_set_player_navigation_walk(_player_prince_record_index(), false)
	if player_place_status != null and current_3d_scene == "player":
		player_place_status.text = "已松开手 | 小王子恢复普通跟随"


func _update_player_handhold(delta: float) -> void:
	if not player_handhold_active:
		return
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if leader_index < 0 or prince_index < 0:
		_release_player_handhold()
		return
	_update_player_navigation_prince_follow(
		delta,
		leader_index,
		prince_index
	)
	_update_player_handhold_link()


func _update_player_handhold_link() -> void:
	if not player_handhold_active or current_3d_scene != "player":
		return
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if leader_index < 0 or prince_index < 0:
		_release_player_handhold()
		return
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	var prince_record: Dictionary = editable_3d_objects[prince_index]
	var leader_node := leader_record.get("node") as Node3D
	var prince_node := prince_record.get("node") as Node3D
	if leader_node == null or prince_node == null:
		return
	var character_distance := leader_node.global_position.distance_to(
		prince_node.global_position
	)
	if character_distance > PLAYER_HANDHOLD_ATTACH_DISTANCE:
		_clear_player_handhold_link()
		return
	var leader_skeleton := leader_node.find_child(
		"Skeleton3D",
		true,
		false
	) as Skeleton3D
	var prince_skeleton := prince_node.find_child(
		"Skeleton3D",
		true,
		false
	) as Skeleton3D
	if leader_skeleton == null or prince_skeleton == null:
		return
	var hand_pair := _player_handhold_hand_pair(
		leader_node,
		prince_node,
		leader_skeleton,
		prince_skeleton
	)
	if hand_pair.is_empty():
		_clear_player_handhold_link()
		return
	var target_world := _player_handhold_target_world(
		leader_node,
		prince_node,
		leader_skeleton,
		prince_skeleton,
		hand_pair
	)
	if player_handhold_target == null or not is_instance_valid(
		player_handhold_target
	):
		if not _setup_player_handhold_ik(
			leader_skeleton,
			prince_skeleton,
			target_world,
			hand_pair
		):
			return
	elif (
		String(hand_pair.get("leader", "")) != player_handhold_leader_side
		or String(hand_pair.get("prince", "")) != player_handhold_prince_side
	):
		if not _setup_player_handhold_ik(
			leader_skeleton,
			prince_skeleton,
			target_world,
			hand_pair
		):
			return
	else:
		_update_player_handhold_target(target_world)
	if player_place_status != null:
		player_place_status.text = "已牵手 | 点击地面带着小王子走"


func _player_handhold_target_world(
	leader_node: Node3D,
	prince_node: Node3D,
	leader_skeleton: Skeleton3D,
	prince_skeleton: Skeleton3D,
	hand_pair: Dictionary
) -> Vector3:
	var upperarm_center := Vector3.ZERO
	var upperarm_count := 0
	var arm_reach_total := 0.0
	for setup in [
		{"skeleton": leader_skeleton, "side": String(hand_pair.get("leader", ""))},
		{"skeleton": prince_skeleton, "side": String(hand_pair.get("prince", ""))},
	]:
		var skeleton := setup.skeleton as Skeleton3D
		var side := String(setup.side)
		var upperarm_index := skeleton.find_bone(side + "_Upperarm")
		var hand_index := skeleton.find_bone(side + "_Hand")
		if upperarm_index < 0 or hand_index < 0:
			continue
		var upperarm_world := (
			skeleton.global_transform
			* skeleton.get_bone_global_pose(upperarm_index).origin
		)
		var hand_world := (
			skeleton.global_transform
			* skeleton.get_bone_global_pose(hand_index).origin
		)
		upperarm_center += upperarm_world
		upperarm_count += 1
		arm_reach_total += upperarm_world.distance_to(hand_world)
	if upperarm_count > 0:
		var up := leader_node.global_transform.basis.y.normalized()
		var arm_reach := arm_reach_total / float(upperarm_count)
		var pair_direction := (
			prince_node.global_position - leader_node.global_position
		)
		pair_direction -= up * pair_direction.dot(up)
		if pair_direction.length_squared() > 0.000001:
			player_handhold_pair_direction = pair_direction.normalized()
		else:
			player_handhold_pair_direction = (
				leader_node.global_transform.basis.z.normalized()
			)
		# Hang the grip near its natural resting height. The hand bones extend
		# below their wrist origins, so placing those origins at the grip made
		# both wrists collapse into one point.
		return (
			upperarm_center / float(upperarm_count)
			- up * arm_reach * 0.72
		)
	var shoulder_center := Vector3.ZERO
	var shoulder_count := 0
	var skeleton_scale := 0.0
	for skeleton in [leader_skeleton, prince_skeleton]:
		skeleton_scale += absf(
			skeleton.global_transform.basis.get_scale().y
		)
		for shoulder_name in ["L_Clavicle", "R_Clavicle"]:
			var shoulder_index: int = skeleton.find_bone(shoulder_name)
			if shoulder_index < 0:
				continue
			shoulder_center += (
				skeleton.global_transform
				* skeleton.get_bone_global_pose(shoulder_index).origin
			)
			shoulder_count += 1
	skeleton_scale /= 2.0
	var target_world := (
		leader_node.global_position + prince_node.global_position
	) * 0.5
	if shoulder_count > 0:
		var up := leader_node.global_transform.basis.y.normalized()
		target_world = (
			shoulder_center / float(shoulder_count)
			- up * 0.18 * skeleton_scale
		)
	return target_world


func _setup_player_handhold_ik(
	leader_skeleton: Skeleton3D,
	prince_skeleton: Skeleton3D,
	target_world: Vector3,
	hand_pair: Dictionary
) -> bool:
	_clear_player_handhold_link()
	if model_3d == null:
		return false
	player_handhold_target = Node3D.new()
	player_handhold_target.name = "PlayerHandholdTarget"
	model_3d.add_child(player_handhold_target)
	player_handhold_target.global_position = target_world
	player_handhold_leader_side = String(hand_pair.get("leader", ""))
	player_handhold_prince_side = String(hand_pair.get("prince", ""))
	player_handhold_skeletons.append(leader_skeleton)
	player_handhold_skeletons.append(prince_skeleton)
	_update_player_handhold_target(target_world)
	return player_handhold_skeletons.size() == 2


func _player_handhold_hand_pair(
	leader_node: Node3D,
	prince_node: Node3D,
	leader_skeleton: Skeleton3D,
	prince_skeleton: Skeleton3D
) -> Dictionary:
	var leader_right := leader_node.global_transform.basis.z.normalized()
	var leader_up := leader_node.global_transform.basis.y.normalized()
	var offset := prince_node.global_position - leader_node.global_position
	offset -= leader_up * offset.dot(leader_up)
	var prince_is_on_right := offset.dot(leader_right) >= 0.0
	var leader_side := "R" if prince_is_on_right else "L"
	var prince_side := "L" if prince_is_on_right else "R"
	if (
		leader_skeleton.find_bone(leader_side + "_Hand") >= 0
		and prince_skeleton.find_bone(prince_side + "_Hand") >= 0
	):
		return {"leader": leader_side, "prince": prince_side}
	return {}


func _update_player_handhold_target(target_world: Vector3) -> void:
	if player_handhold_target != null and is_instance_valid(
		player_handhold_target
	):
		player_handhold_target.global_position = target_world
	if player_handhold_skeletons.size() == 2:
		_apply_player_handhold_arm_pose(
			player_handhold_skeletons[0],
			player_handhold_leader_side,
			target_world,
			true
		)
		_apply_player_handhold_arm_pose(
			player_handhold_skeletons[1],
			player_handhold_prince_side,
			target_world,
			false
		)


func _apply_player_handhold_arm_pose(
	skeleton: Skeleton3D,
	side: String,
	target_world: Vector3,
	is_leader: bool
) -> void:
	if skeleton == null or not is_instance_valid(skeleton):
		return
	var upperarm_index := skeleton.find_bone(side + "_Upperarm")
	var hand_index := skeleton.find_bone(side + "_Hand")
	var forearm_index := skeleton.get_bone_parent(hand_index)
	if upperarm_index < 0 or hand_index < 0 or forearm_index < 0:
		return
	var upperarm := skeleton.get_bone_global_pose(upperarm_index).origin
	var forearm := skeleton.get_bone_global_pose(forearm_index).origin
	var hand := skeleton.get_bone_global_pose(hand_index).origin
	var upper_length := upperarm.distance_to(forearm)
	var lower_length := forearm.distance_to(hand)
	var lower_length_world := (
		(skeleton.global_transform * forearm)
		.distance_to(skeleton.global_transform * hand)
	)
	var up_world := skeleton.global_transform.basis.y.normalized()
	var side_sign := -1.0 if is_leader else 1.0
	var pair_direction := player_handhold_pair_direction
	if pair_direction.length_squared() <= 0.000001:
		pair_direction = skeleton.global_transform.basis.z.normalized()
	var palm_offset := clampf(lower_length_world * 0.65, 0.006, 0.018)
	var hand_spacing := clampf(lower_length_world * 0.50, 0.007, 0.015)
	var inward_ratio := clampf(
		hand_spacing / maxf(palm_offset * 2.0, 0.0001),
		0.0,
		0.70
	)
	var inward_slope := (
		inward_ratio
		/ sqrt(maxf(1.0 - inward_ratio * inward_ratio, 0.0001))
	)
	var hand_direction_world := (
		-up_world + pair_direction * side_sign * inward_slope
	).normalized()
	var wrist_world := (
		target_world
		- hand_direction_world * palm_offset
	)
	var skeleton_inverse := skeleton.global_transform.affine_inverse()
	var wrist := skeleton_inverse * wrist_world
	var hand_direction := (
		skeleton_inverse.basis * hand_direction_world
	).normalized()
	var to_target := wrist - upperarm
	var target_distance := clampf(
		to_target.length(),
		absf(upper_length - lower_length) + 0.0001,
		upper_length + lower_length - 0.0001
	)
	if target_distance <= 0.0001:
		return
	var upper_direction := to_target.normalized()
	var along := (
		upper_length * upper_length
		- lower_length * lower_length
		+ target_distance * target_distance
	) / (2.0 * target_distance)
	var bend_direction := forearm - upperarm - upper_direction * along
	if bend_direction.length_squared() <= 0.000001:
		bend_direction = (
			Vector3.RIGHT
			- upper_direction * upper_direction.dot(Vector3.RIGHT)
		)
	if bend_direction.length_squared() <= 0.000001:
		bend_direction = (
			Vector3.UP
			- upper_direction * upper_direction.dot(Vector3.UP)
		)
	bend_direction = bend_direction.normalized()
	var elbow := (
		upperarm
		+ upper_direction * along
		+ bend_direction * sqrt(maxf(
			upper_length * upper_length - along * along,
			0.0
		))
	)
	var lower_direction := (wrist - elbow).normalized()
	_set_player_handhold_bone(
		skeleton,
		upperarm_index,
		upperarm,
		(elbow - upperarm).normalized()
	)
	_set_player_handhold_bone(skeleton, forearm_index, elbow, lower_direction)
	_set_player_handhold_bone(
		skeleton,
		hand_index,
		wrist,
		hand_direction
	)
	var rest := skeleton.get_bone_global_rest(hand_index)
	var hand_basis := (
		Basis(Quaternion(rest.basis.y.normalized(), hand_direction))
		* rest.basis
	).orthonormalized()
	var hand_direction_out := (
		skeleton.global_transform.basis * hand_basis.y.normalized()
	).normalized()
	var palm_center := (
		wrist_world + hand_direction_out * palm_offset
	)
	if is_leader:
		player_handhold_leader_palm_center = palm_center
	else:
		player_handhold_prince_palm_center = palm_center


func _set_player_handhold_bone(
	skeleton: Skeleton3D,
	bone_index: int,
	bone_position: Vector3,
	direction: Vector3
) -> void:
	if direction.length_squared() <= 0.000001:
		return
	var rest := skeleton.get_bone_global_rest(bone_index)
	var basis := (
		Basis(Quaternion(rest.basis.y.normalized(), direction.normalized()))
		* rest.basis
	).orthonormalized()
	skeleton.set_bone_global_pose_override(
		bone_index,
		Transform3D(basis, bone_position),
		1.0,
		true
	)


func _clear_player_handhold_link() -> void:
	for skeleton in player_handhold_skeletons:
		if skeleton != null and is_instance_valid(skeleton):
			skeleton.clear_bones_global_pose_override()
	player_handhold_skeletons.clear()
	player_handhold_leader_side = ""
	player_handhold_prince_side = ""
	player_handhold_pair_direction = Vector3.ZERO
	player_handhold_leader_palm_center = Vector3.ZERO
	player_handhold_prince_palm_center = Vector3.ZERO
	if player_handhold_target != null and is_instance_valid(
		player_handhold_target
	):
		player_handhold_target.queue_free()
	player_handhold_target = null


func _player_navigation_input_available() -> bool:
	return (
		current_3d_scene == "player"
		and model_3d != null
		and not player_avatar_picker_open
		and not editor_active
		and not dialogue_active
		and (
			player_place_dock == null
			or not player_place_dock.visible
		)
	)


func _get_active_player_character_index() -> int:
	var saved_index := _find_editable_record_index(
		active_player_character_id,
		-1
	)
	if (
		saved_index >= 0
		and String(editable_3d_objects[saved_index].get("kind", ""))
			in PLAYER_PERSON_KINDS
	):
		return saved_index
	for character_kind in PLAYER_PERSON_KINDS:
		var index := _find_editable_record_index_by_kind(character_kind)
		if index >= 0:
			active_player_character_id = String(
				editable_3d_objects[index].get("id", "")
			)
			return index
	active_player_character_id = ""
	return -1


func _set_active_player_character(index: int) -> void:
	if (
		index < 0
		or index >= editable_3d_objects.size()
		or String(editable_3d_objects[index].get("kind", ""))
			not in PLAYER_PERSON_KINDS
	):
		return
	active_player_character_id = String(
		editable_3d_objects[index].get("id", "")
	)
	if player_place_status != null:
		player_place_status.text = "玩家小人：%s" % String(
			editable_3d_objects[index].get("label", "小人")
		)


func _player_prince_record_index() -> int:
	var index := _find_editable_record_index_by_kind("player_prince")
	if index >= 0:
		return index
	_ensure_default_player_prince()
	return _find_editable_record_index_by_kind("player_prince")


func _player_seat_visible_slot_count(seat_kind: String) -> int:
	return 2 if seat_kind in ["player_bench", "player_swing"] else 1


func _player_seat_visual_layout(
	seat_record: Dictionary,
	visible_slot_index := 0,
	visible_slot_count := 1
) -> Dictionary:
	var seat_node := seat_record.get("node") as Node3D
	if seat_node == null:
		return {}
	var bounds := _node_local_bounds(seat_node)
	if bounds.size == Vector3.ZERO:
		return {}
	var slot_count := maxi(visible_slot_count, 1)
	var slot_ratio := 0.5
	if slot_count == 2:
		slot_ratio = 0.30 if visible_slot_index == 0 else 0.70
	elif slot_count > 2:
		slot_ratio = (
			float(visible_slot_index) + 0.5
		) / float(slot_count)
	var seat_kind := String(seat_record.get("kind", ""))
	var cushion_ratio := 0.40
	match seat_kind:
		"player_bench":
			cushion_ratio = 0.43
		"player_swing":
			cushion_ratio = 0.39
		"player_star_pointlighter_chair":
			cushion_ratio = 0.42
		"player_star_king_throne":
			cushion_ratio = 0.38
	# Use the furniture height to land above the floor and beneath the backrest.
	var cushion_height := (
		bounds.position.y + bounds.size.y * cushion_ratio + 0.012
	)
	var center := Vector3(
		bounds.position.x + bounds.size.x * slot_ratio,
		cushion_height,
		bounds.get_center().z
	)
	var seat_width := (
		bounds.size.x * absf(seat_node.scale.x)
		/ float(slot_count)
	)
	var radius := clampf(seat_width * 0.34, 0.068, 0.112)
	return {
		"center": center,
		"radius": radius,
	}


func _make_player_glow_material(
	color: Color,
	alpha: float,
	additive: bool
) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = Color(color.r, color.g, color.b, alpha)
	material.emission_enabled = true
	material.emission = color
	material.emission_energy_multiplier = 2.1
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	if additive:
		material.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
	material.set_meta("player_glow_base_alpha", alpha)
	material.set_meta("player_glow_base_energy", 2.1)
	return material


func _create_player_glow_ring(
	parent: Node3D,
	radius: float,
	node_name: String,
	color: Color
) -> Dictionary:
	if parent == null:
		return {}
	var root := Node3D.new()
	root.name = node_name
	parent.add_child(root)
	var materials: Array[StandardMaterial3D] = []
	var fill_material := _make_player_glow_material(color, 0.075, true)
	materials.append(fill_material)
	var fill_mesh := CylinderMesh.new()
	fill_mesh.top_radius = radius * 1.08
	fill_mesh.bottom_radius = fill_mesh.top_radius
	fill_mesh.height = 0.003
	fill_mesh.radial_segments = 40
	fill_mesh.rings = 1
	fill_mesh.material = fill_material
	var fill := MeshInstance3D.new()
	fill.name = "GlowFill"
	fill.mesh = fill_mesh
	fill.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	root.add_child(fill)
	for ring_index in 2:
		var ring_material := _make_player_glow_material(
			color,
			0.66 if ring_index == 0 else 0.22,
			true
		)
		materials.append(ring_material)
		var torus := TorusMesh.new()
		torus.inner_radius = radius * (0.85 if ring_index == 0 else 1.13)
		torus.outer_radius = radius * (1.0 if ring_index == 0 else 1.23)
		torus.rings = 40
		torus.ring_segments = 10
		torus.material = ring_material
		var ring := MeshInstance3D.new()
		ring.name = "GlowRing%d" % (ring_index + 1)
		ring.mesh = torus
		ring.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		root.add_child(ring)
	return {
		"node": root,
		"materials": materials,
	}


func _refresh_player_seat_glow_markers() -> void:
	for marker in player_seat_glow_markers:
		var marker_node := marker.get("node") as Node3D
		if marker_node != null and is_instance_valid(marker_node):
			marker_node.queue_free()
	player_seat_glow_markers.clear()
	if current_3d_scene != "player" or model_3d == null:
		return
	for seat_record_value in editable_3d_objects:
		var seat_record: Dictionary = seat_record_value
		if String(seat_record.get("kind", "")) not in PLAYER_SEAT_KINDS:
			continue
		var seat_node := seat_record.get("node") as Node3D
		if (
			seat_node == null
			or not is_instance_valid(seat_node)
			or bool(seat_record.get("default_hidden", false))
		):
			continue
		var seat_kind := String(seat_record.get("kind", ""))
		var visible_slot_count := _player_seat_visible_slot_count(seat_kind)
		for visible_slot_index in visible_slot_count:
			var layout := _player_seat_visual_layout(
				seat_record,
				visible_slot_index,
				visible_slot_count
			)
			if layout.is_empty():
				continue
			var ring := _create_player_glow_ring(
				model_3d,
				float(layout.radius),
				"PlayerSeatGlow_%s_%d" % [
					String(seat_record.get("id", "")),
					visible_slot_index,
				],
				Color(1.0, 0.79, 0.34)
			)
			if ring.is_empty():
				continue
			var ring_node := ring.get("node") as Node3D
			ring_node.visible = false
			player_seat_glow_markers.append({
				"seat_id": String(seat_record.get("id", "")),
				"seat_kind": seat_kind,
				"visible_slot_index": visible_slot_index,
				"visible_slot_count": visible_slot_count,
				"node": ring_node,
				"materials": ring.get("materials", []),
				"base_scale": 1.0,
			})


func _update_player_glow_materials(
	materials_value: Variant,
	intensity: float,
	fade := 1.0
) -> void:
	if typeof(materials_value) != TYPE_ARRAY:
		return
	var materials := materials_value as Array
	for material_value in materials:
		var material := material_value as StandardMaterial3D
		if material == null:
			continue
		var base_alpha := float(
			material.get_meta("player_glow_base_alpha", 0.5)
		)
		var base_energy := float(
			material.get_meta("player_glow_base_energy", 2.1)
		)
		var color := material.albedo_color
		color.a = clampf(base_alpha * intensity * fade, 0.0, 1.0)
		material.albedo_color = color
		material.emission_energy_multiplier = (
			base_energy * lerpf(0.65, 1.7, clampf(intensity, 0.0, 1.5))
			* fade
		)


func _update_player_navigation(delta: float) -> void:
	_update_player_navigation_marker(delta)
	if current_3d_scene != "player" or model_3d == null:
		_set_player_seat_glow_visibility(false)
		if player_navigation_active:
			_cancel_player_navigation(false)
		return
	if editor_active or dialogue_active or (
		player_place_dock != null and player_place_dock.visible
	):
		_set_player_seat_glow_visibility(false)
		if player_handhold_active:
			_release_player_handhold()
		if player_navigation_active:
			_cancel_player_navigation(true)
		return
	if player_seat_glow_markers.is_empty():
		_refresh_player_seat_glow_markers()
	var active_index := _get_active_player_character_index()
	var hovered_seat_id := ""
	if (
		active_index >= 0
		and not player_navigation_active
		and camera_3d != null
	):
		var seat_hover := _player_seat_at_screen(
			get_viewport().get_mouse_position(),
			editable_3d_objects[active_index]
		)
		hovered_seat_id = String(seat_hover.get("id", ""))
	var planned_seat_id := String(
		player_navigation_planned_seat.get("seat_id", "")
	)
	var pulse := 0.5 + 0.5 * sin(player_navigation_marker_time * 4.6)
	for marker in player_seat_glow_markers:
		var ring_node := marker.get("node") as Node3D
		var seat_index := _find_editable_record_index(
			String(marker.get("seat_id", "")),
			-1
		)
		if ring_node == null or seat_index < 0:
			if ring_node != null:
				ring_node.visible = false
			continue
		var seat_record: Dictionary = editable_3d_objects[seat_index]
		var seat_node := seat_record.get("node") as Node3D
		if (
			seat_node == null
			or not seat_node.visible
			or bool(seat_record.get("default_hidden", false))
		):
			ring_node.visible = false
			continue
		var layout := _player_seat_visual_layout(
			seat_record,
			int(marker.get("visible_slot_index", 0)),
			int(marker.get("visible_slot_count", 1))
		)
		if layout.is_empty():
			ring_node.visible = false
			continue
		var seat_id := String(marker.get("seat_id", ""))
		var seat_occupied := false
		for rider_value in editable_3d_objects:
			var rider: Dictionary = rider_value
			if (
				String(rider.get("seat_state", "")) == "seated"
				and String(rider.get("seat_id", "")) == seat_id
			):
				seat_occupied = true
				break
		if seat_occupied:
			ring_node.visible = false
			continue
		var is_focus := (
			seat_id == hovered_seat_id
			or (
				player_navigation_active
				and not planned_seat_id.is_empty()
				and seat_id == planned_seat_id
			)
		)
		var intensity := (
			1.12 + pulse * 0.25
			if is_focus
			else 0.42 + pulse * 0.10
		)
		var seat_transform := seat_node.transform
		var center: Vector3 = layout.center
		ring_node.transform = Transform3D(
			seat_transform.basis.orthonormalized(),
			seat_transform * center
		)
		ring_node.scale = Vector3.ONE * (
			1.0 + (0.07 if is_focus else 0.025) * pulse
		)
		ring_node.visible = true
		_update_player_glow_materials(
			marker.get("materials", []),
			intensity
		)
	if player_navigation_active:
		_update_player_navigation_motion(delta)
		if player_handhold_active:
			_update_player_handhold_link()
	elif player_handhold_active:
		_update_player_handhold(delta)


func _set_player_seat_glow_visibility(is_visible: bool) -> void:
	for marker in player_seat_glow_markers:
		var ring_node := marker.get("node") as Node3D
		if ring_node != null and is_instance_valid(ring_node):
			ring_node.visible = is_visible


func _clear_player_navigation_marker() -> void:
	if (
		player_navigation_marker != null
		and is_instance_valid(player_navigation_marker)
	):
		player_navigation_marker.queue_free()
	player_navigation_marker = null
	player_navigation_marker_materials.clear()
	player_navigation_marker_fading = false
	player_navigation_marker_fade_elapsed = 0.0


func _show_player_navigation_marker(
	position: Vector3,
	normal: Vector3
) -> void:
	if model_3d == null:
		return
	if (
		player_navigation_marker == null
		or not is_instance_valid(player_navigation_marker)
		or player_navigation_marker.get_parent() != model_3d
	):
		_clear_player_navigation_marker()
		var ring := _create_player_glow_ring(
			model_3d,
			0.091,
			"PlayerNavigationTarget",
			Color(1.0, 0.83, 0.30)
		)
		player_navigation_marker = ring.get("node") as Node3D
		var materials_value = ring.get("materials", [])
		if typeof(materials_value) == TYPE_ARRAY:
			for material_value in materials_value:
				var material := material_value as StandardMaterial3D
				if material != null:
					player_navigation_marker_materials.append(material)
	var aligned_normal := _align_player_surface_normal(normal)
	player_navigation_marker.transform = Transform3D(
		_normal_surface_basis(aligned_normal, 0.0),
		position + aligned_normal * 0.026
	)
	player_navigation_marker.visible = true
	player_navigation_marker_fading = false
	player_navigation_marker_fade_elapsed = 0.0


func _update_player_navigation_marker(delta: float) -> void:
	player_navigation_marker_time += delta
	if (
		player_navigation_marker == null
		or not is_instance_valid(player_navigation_marker)
		or not player_navigation_marker.visible
	):
		return
	var fade := 1.0
	if player_navigation_marker_fading:
		player_navigation_marker_fade_elapsed += delta
		fade = clampf(
			1.0 - player_navigation_marker_fade_elapsed / 0.7,
			0.0,
			1.0
		)
		if fade <= 0.0:
			player_navigation_marker.visible = false
			player_navigation_marker_fading = false
			return
	var pulse := 0.5 + 0.5 * sin(player_navigation_marker_time * 5.2)
	player_navigation_marker.scale = Vector3.ONE * (
		1.0 + pulse * 0.11
	) * lerpf(0.82, 1.0, fade)
	_update_player_glow_materials(
		player_navigation_marker_materials,
		1.22 + pulse * 0.28,
		fade
	)


func _fade_player_navigation_marker() -> void:
	if (
		player_navigation_marker != null
		and is_instance_valid(player_navigation_marker)
	):
		player_navigation_marker_fade_elapsed = 0.0
		player_navigation_marker_fading = true


func _player_navigation_seat_plan(
	seat_record: Dictionary,
	leader_record: Dictionary,
	prince_record: Dictionary
) -> Dictionary:
	var seat_id := String(seat_record.get("id", ""))
	if seat_id.is_empty():
		return {}
	var slot_count := _player_seat_capacity(
		String(seat_record.get("kind", ""))
	)
	var used: Dictionary = {}
	for other_value in editable_3d_objects:
		var other: Dictionary = other_value
		var other_id := String(other.get("id", ""))
		if (
			other_id == String(leader_record.get("id", ""))
			or other_id == String(prince_record.get("id", ""))
			or String(other.get("seat_state", "")) != "seated"
			or String(other.get("seat_id", "")) != seat_id
		):
			continue
		used[int(other.get("seat_slot_index", 0))] = true
	var leader_slot := -1
	if (
		String(leader_record.get("seat_state", "")) == "seated"
		and String(leader_record.get("seat_id", "")) == seat_id
	):
		leader_slot = int(leader_record.get("seat_slot_index", 0))
	else:
		for slot_index in slot_count:
			if not used.has(slot_index):
				leader_slot = slot_index
				break
	if leader_slot < 0:
		return {}
	used[leader_slot] = true
	var prince_slot := -1
	if (
		String(prince_record.get("seat_state", "")) == "seated"
		and String(prince_record.get("seat_id", "")) == seat_id
	):
		prince_slot = int(prince_record.get("seat_slot_index", 0))
	else:
		for slot_index in slot_count:
			if not used.has(slot_index):
				prince_slot = slot_index
				break
	if prince_slot < 0:
		return {}
	var leader_seat := seat_record.duplicate()
	leader_seat["seat_slot_index"] = leader_slot
	leader_seat["seat_slot_count"] = slot_count
	if _player_seat_visible_slot_count(
		String(seat_record.get("kind", ""))
	) == 1:
		return {
			"seat_id": seat_id,
			"leader": leader_seat,
			"prince_follow_only": true,
		}
	var prince_seat := seat_record.duplicate()
	prince_seat["seat_slot_index"] = prince_slot
	prince_seat["seat_slot_count"] = slot_count
	return {
		"seat_id": seat_id,
		"leader": leader_seat,
		"prince": prince_seat,
	}


func _begin_player_navigation(
	target_position: Vector3,
	target_normal: Vector3,
	seat_record: Dictionary = {}
) -> bool:
	if player_navigation_active or not _player_navigation_input_available():
		return false
	var leader_index := _get_active_player_character_index()
	var prince_index := _player_prince_record_index()
	if (
		leader_index < 0
		or prince_index < 0
		or leader_index == prince_index
	):
		return false
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	var prince_record: Dictionary = editable_3d_objects[prince_index]
	var seat_plan: Dictionary = {}
	if not seat_record.is_empty():
		seat_plan = _player_navigation_seat_plan(
			seat_record,
			leader_record,
			prince_record
		)
		if seat_plan.is_empty():
			return false
	var clamped_target := _clamp_player_placement_plane_position(
		target_position
	)
	var surface_sample := _player_surface_sample_at_position(
		clamped_target,
		float(leader_record.get("placement_footprint", 0.10))
	)
	var aligned_normal := _align_player_surface_normal(target_normal)
	if not surface_sample.is_empty():
		clamped_target = surface_sample.position
		aligned_normal = surface_sample.normal
	player_navigation_serial += 1
	player_navigation_active = true
	player_navigation_phase = "preparing"
	player_navigation_leader_id = String(leader_record.get("id", ""))
	player_navigation_prince_id = String(prince_record.get("id", ""))
	player_navigation_target_position = clamped_target
	player_navigation_target_normal = aligned_normal
	player_navigation_planned_seat = seat_plan
	player_navigation_stuck_elapsed = 0.0
	player_navigation_progress_distance = INF
	player_navigation_follower_stuck_elapsed = 0.0
	player_navigation_follower_progress_distance = INF
	var travel := (
		clamped_target - (leader_record.get("position") as Vector3)
	)
	travel -= aligned_normal * travel.dot(aligned_normal)
	player_navigation_leader_direction = (
		travel.normalized()
		if travel.length_squared() > 0.000001
		else player_placement_plane_forward
	)
	if seat_record.is_empty():
		_show_player_navigation_marker(clamped_target, aligned_normal)
	else:
		_fade_player_navigation_marker()
	if player_place_status != null:
		player_place_status.text = (
			"正在走向座位：%s" % String(seat_record.get("label", "座位"))
			if not seat_record.is_empty()
			else "正在走向目标点"
		)
	call_deferred(
		"_run_player_navigation_prepare",
		player_navigation_serial
	)
	return true


func _run_player_navigation_prepare(request_serial: int) -> void:
	for character_id in [
		player_navigation_leader_id,
		player_navigation_prince_id,
	]:
		if request_serial != player_navigation_serial:
			return
		var index := _find_editable_record_index(character_id, -1)
		if index < 0:
			_cancel_player_navigation(false)
			return
		var record: Dictionary = editable_3d_objects[index]
		if String(record.get("seat_state", "")) == "seated":
			await _stand_player_character(record, false)
	if (
		request_serial != player_navigation_serial
		or not player_navigation_active
	):
		return
	await get_tree().create_timer(0.18).timeout
	if (
		request_serial != player_navigation_serial
		or not player_navigation_active
	):
		return
	_start_player_navigation_turn()


func _start_player_navigation_turn() -> void:
	var leader_index := _find_editable_record_index(
		player_navigation_leader_id,
		-1
	)
	var prince_index := _find_editable_record_index(
		player_navigation_prince_id,
		-1
	)
	if leader_index < 0 or prince_index < 0:
		_cancel_player_navigation(false)
		return
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	var direction := player_navigation_leader_direction
	direction -= (
		player_navigation_target_normal
		* direction.dot(player_navigation_target_normal)
	)
	if direction.length_squared() <= 0.000001:
		_start_player_navigation_walk_phase()
		return
	direction = direction.normalized()
	player_navigation_leader_turn_from = float(
		leader_record.get("yaw", 0.0)
	)
	player_navigation_leader_turn_to = _player_navigation_facing_yaw(
		direction,
		player_navigation_target_normal
	)
	player_navigation_turn_elapsed = 0.0
	player_navigation_phase = "turning"
	if player_place_status != null:
		player_place_status.text = "正在转身朝向目的地"


func _player_navigation_facing_yaw(
	direction: Vector3,
	normal: Vector3
) -> float:
	var surface_normal := _align_player_surface_normal(normal)
	var tangent_direction := (
		direction
		- surface_normal * direction.dot(surface_normal)
	)
	if tangent_direction.length_squared() <= 0.000001:
		return 0.0
	tangent_direction = tangent_direction.normalized()
	var reference := _normal_surface_basis(surface_normal, 0.0)
	# These rigs face their local +X axis at yaw 0.
	return wrapf(
		rad_to_deg(
			atan2(
				-tangent_direction.dot(reference.z),
				tangent_direction.dot(reference.x)
			)
		),
		-180.0,
		180.0
	)


func _start_player_navigation_walk_phase() -> void:
	player_navigation_phase = "walking"
	player_navigation_stuck_elapsed = 0.0
	var leader_index := _find_editable_record_index(
		player_navigation_leader_id,
		-1
	)
	if leader_index >= 0:
		var leader_record: Dictionary = editable_3d_objects[leader_index]
		player_navigation_progress_distance = (
			leader_record.get("position", Vector3.ZERO) as Vector3
		).distance_to(player_navigation_target_position)
	_set_player_navigation_walk(
		leader_index,
		true
	)


func _set_player_navigation_walk(index: int, is_walking: bool) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	var root := record.get("node") as Node3D
	if root == null:
		return
	root.set_meta("player_navigation_walking", is_walking)
	var animation := _find_rig_animation_player(root)
	if animation == null:
		return
	if is_walking:
		_play_character_animation(root, ["walk_001"], true, 0.18)
		animation.speed_scale = 1.0
		return
	var resume_animation := String(
		record.get(
			"selected_animation",
			root.get_meta("preferred_character_animation", "ambient_idle")
		)
	)
	if resume_animation in ["", "walk_001", "sit", "sit_001"]:
		resume_animation = "ambient_idle"
	_apply_character_animation_choice(root, resume_animation, true)


func _move_player_navigation_character(
	index: int,
	target: Vector3,
	step_distance: float
) -> float:
	if index < 0 or index >= editable_3d_objects.size():
		return 0.0
	var record: Dictionary = editable_3d_objects[index]
	var current_position: Vector3 = record.get("position", Vector3.ZERO)
	var to_target := target - current_position
	var distance := to_target.length()
	if distance <= 0.00001:
		return 0.0
	var direction := to_target / distance
	var next_position := current_position + direction * minf(
		distance,
		step_distance
	)
	next_position = _clamp_player_placement_plane_position(next_position)
	var surface_sample := _player_surface_sample_at_position(
		next_position,
		float(record.get("placement_footprint", 0.10))
	)
	var normal := _align_player_surface_normal(
		record.get("placement_plane_normal", player_placement_plane_normal)
	)
	if not surface_sample.is_empty():
		next_position = surface_sample.position
		normal = surface_sample.normal
	record["position"] = next_position
	record["normal"] = normal
	record["initial_normal"] = normal
	record["placement_plane_normal"] = normal
	record["root_radius"] = next_position.y
	record["initial_root_radius"] = next_position.y
	if _player_standing_height_locked(record):
		var locked_height := float(player_asset_height_offsets.get(
			String(record.get("kind", "")),
			record.get("placement_height_offset", 0.0)
		))
		record["placement_height_offset"] = locked_height
		record["initial_placement_height_offset"] = locked_height
	record["seat_state"] = "standing"
	record.erase("seat_id")
	record.erase("seat_kind")
	record.erase("seat_slot_index")
	record.erase("seat_slot_count")
	record.erase("placement_support_id")
	record.erase("placement_support_normal")
	_apply_editable_3d_record(index)
	return next_position.distance_to(target)


func _update_player_navigation_motion(delta: float) -> void:
	if player_navigation_phase == "preparing":
		return
	var leader_index := _find_editable_record_index(
		player_navigation_leader_id,
		-1
	)
	var prince_index := _find_editable_record_index(
		player_navigation_prince_id,
		-1
	)
	if leader_index < 0 or prince_index < 0:
		_cancel_player_navigation(false)
		return
	if player_navigation_phase == "turning":
		_update_player_navigation_turn(delta, leader_index)
		return
	if player_navigation_phase == "walking":
		var leader_remaining := _move_player_navigation_character(
			leader_index,
			player_navigation_target_position,
			PLAYER_NAV_WALK_SPEED * delta
		)
		var leader_distance := (
			editable_3d_objects[leader_index].position as Vector3
		).distance_to(player_navigation_target_position)
		if (
			not is_finite(player_navigation_progress_distance)
			or leader_distance
				< player_navigation_progress_distance
					- PLAYER_NAV_PROGRESS_EPSILON
		):
			player_navigation_progress_distance = leader_distance
			player_navigation_stuck_elapsed = 0.0
		else:
			player_navigation_stuck_elapsed += delta
		if (
			player_navigation_stuck_elapsed >= PLAYER_NAV_STUCK_TIMEOUT
			and leader_distance > PLAYER_NAV_ARRIVE_DISTANCE
		):
			_recover_player_navigation_from_stuck()
			return
		if leader_remaining <= PLAYER_NAV_ARRIVE_DISTANCE:
			_set_player_navigation_walk(leader_index, false)
			player_navigation_phase = "waiting_follower"
			player_navigation_follower_stuck_elapsed = 0.0
			player_navigation_follower_progress_distance = INF
			if player_place_status != null:
				player_place_status.text = "小王子正在跟上"
	_update_player_navigation_prince_follow(
		delta,
		leader_index,
		prince_index
	)
	if player_navigation_phase == "waiting_follower":
		var prince_record: Dictionary = editable_3d_objects[prince_index]
		var follower_distance := (
			prince_record.get("position", Vector3.ZERO) as Vector3
		).distance_to(player_navigation_prince_follow_target)
		if (
			not is_finite(player_navigation_follower_progress_distance)
			or follower_distance
				< player_navigation_follower_progress_distance
					- PLAYER_NAV_PROGRESS_EPSILON
		):
			player_navigation_follower_progress_distance = follower_distance
			player_navigation_follower_stuck_elapsed = 0.0
		else:
			player_navigation_follower_stuck_elapsed += delta
		if (
			player_navigation_follower_stuck_elapsed
				>= PLAYER_NAV_STUCK_TIMEOUT
			and follower_distance > PLAYER_NAV_FOLLOW_TARGET_DISTANCE
		):
			_recover_player_navigation_from_stuck()
			return
	if (
		player_navigation_phase == "waiting_follower"
		and player_navigation_prince_follow_state == "idle"
	):
		var prince_record: Dictionary = editable_3d_objects[prince_index]
		var prince_remaining := (
			player_navigation_prince_follow_target
			- (prince_record.get("position") as Vector3)
		).length()
		if prince_remaining <= PLAYER_NAV_FOLLOW_TARGET_DISTANCE:
			_finish_player_navigation()


func _recover_player_navigation_from_stuck() -> void:
	if not player_navigation_active:
		return
	_reset_player_characters_from_stuck(
		"未能继续走向目标，人物已自动回到安全站位"
	)


func _update_player_navigation_turn(
	delta: float,
	leader_index: int
) -> void:
	player_navigation_turn_elapsed += delta
	var progress := clampf(
		player_navigation_turn_elapsed / PLAYER_NAV_TURN_DURATION,
		0.0,
		1.0
	)
	var eased := progress * progress * (3.0 - 2.0 * progress)
	var leader_yaw := rad_to_deg(lerp_angle(
		deg_to_rad(player_navigation_leader_turn_from),
		deg_to_rad(player_navigation_leader_turn_to),
		eased
	))
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	leader_record["yaw"] = wrapf(leader_yaw, -180.0, 180.0)
	_apply_editable_3d_record(leader_index)
	if progress < 1.0:
		return
	leader_record["yaw"] = player_navigation_leader_turn_to
	_apply_editable_3d_record(leader_index)
	_start_player_navigation_walk_phase()


func _update_player_navigation_prince_follow(
	delta: float,
	leader_index: int,
	prince_index: int
) -> void:
	var leader_record: Dictionary = editable_3d_objects[leader_index]
	var prince_record: Dictionary = editable_3d_objects[prince_index]
	var follow_normal := _align_player_surface_normal(
		leader_record.get(
			"placement_plane_normal",
			player_placement_plane_normal
		)
	)
	var side := _normal_surface_basis(
		follow_normal,
		0.0
	).z
	var leader_position: Vector3 = leader_record.get("position")
	var follow_position := leader_position
	if player_handhold_active:
		# Keep the dedicated hand-holding placement unchanged for now.
		follow_position += side * PLAYER_NAV_PRINCE_HANDHOLD_SIDE_OFFSET
	else:
		# The rigs face local +X. Resolve the trail direction from the leader's
		# current facing so left and right travel both place the Prince behind.
		var leader_facing := _normal_surface_basis(
			follow_normal,
			float(leader_record.get("yaw", 0.0))
		)
		follow_position += (
			-leader_facing.x * PLAYER_NAV_PRINCE_TRAIL_OFFSET
			+ leader_facing.z * PLAYER_NAV_PRINCE_SHOULDER_OFFSET
		)
	player_navigation_prince_follow_target = (
		_clamp_player_placement_plane_position(
			follow_position
		)
	)
	var prince_position: Vector3 = prince_record.get(
		"position",
		Vector3.ZERO
	)
	var player_distance := prince_position.distance_to(
		leader_record.get("position")
	)
	var distance_to_follow_target := prince_position.distance_to(
		player_navigation_prince_follow_target
	)
	if (
		player_handhold_active
		and player_distance <= PLAYER_HANDHOLD_ATTACH_DISTANCE
	):
		var leader_yaw := float(leader_record.get("yaw", 0.0))
		var prince_yaw := float(prince_record.get("yaw", 0.0))
		var facing_weight := 1.0 - exp(-delta * 18.0)
		prince_record["yaw"] = rad_to_deg(lerp_angle(
			deg_to_rad(prince_yaw),
			deg_to_rad(leader_yaw),
			facing_weight
		))
		_apply_editable_3d_record(prince_index)
	if player_navigation_prince_follow_state == "idle":
		if (
			player_distance > PLAYER_NAV_FOLLOW_START_DISTANCE
			or player_navigation_phase == "waiting_follower"
			or (
				player_handhold_active
				and distance_to_follow_target
					> PLAYER_NAV_FOLLOW_TARGET_DISTANCE + 0.02
			)
		):
			_start_player_navigation_prince_follow(
				prince_index,
				prince_record
			)
		return
	if player_navigation_prince_follow_state == "turning":
		player_navigation_prince_turn_elapsed += delta
		var progress := clampf(
			player_navigation_prince_turn_elapsed
				/ PLAYER_NAV_TURN_DURATION,
			0.0,
			1.0
		)
		var eased := progress * progress * (3.0 - 2.0 * progress)
		var prince_yaw := rad_to_deg(lerp_angle(
			deg_to_rad(player_navigation_prince_turn_from),
			deg_to_rad(player_navigation_prince_turn_to),
			eased
		))
		prince_record["yaw"] = wrapf(prince_yaw, -180.0, 180.0)
		_apply_editable_3d_record(prince_index)
		if progress >= 1.0:
			prince_record["yaw"] = player_navigation_prince_turn_to
			_apply_editable_3d_record(prince_index)
			player_navigation_prince_follow_state = "walking"
			_set_player_navigation_walk(prince_index, true)
		return
	if distance_to_follow_target <= PLAYER_NAV_FOLLOW_TARGET_DISTANCE:
		player_navigation_prince_follow_state = "idle"
		_set_player_navigation_walk(prince_index, false)
		return
	var prince_speed := clampf(
		PLAYER_NAV_WALK_SPEED
			+ maxf(distance_to_follow_target - 0.35, 0.0) * 1.1,
		PLAYER_NAV_WALK_SPEED,
		1.35
	)
	var remaining := _move_player_navigation_character(
		prince_index,
		player_navigation_prince_follow_target,
		prince_speed * delta
	)
	if remaining <= PLAYER_NAV_FOLLOW_TARGET_DISTANCE:
		player_navigation_prince_follow_state = "idle"
		_set_player_navigation_walk(prince_index, false)


func _start_player_navigation_prince_follow(
	prince_index: int,
	prince_record: Dictionary
) -> void:
	var prince_position: Vector3 = prince_record.get(
		"position",
		Vector3.ZERO
	)
	var direction := (
		player_navigation_prince_follow_target
		- prince_position
	)
	var normal := _align_player_surface_normal(
		prince_record.get(
			"placement_plane_normal",
			player_placement_plane_normal
		)
	)
	direction -= normal * direction.dot(normal)
	player_navigation_prince_turn_from = float(
		prince_record.get("yaw", 0.0)
	)
	if direction.length_squared() <= 0.000001:
		player_navigation_prince_follow_state = "walking"
		_set_player_navigation_walk(prince_index, true)
		return
	player_navigation_prince_turn_to = _player_navigation_facing_yaw(
		direction,
		normal
	)
	var turn_difference := absf(wrapf(
		player_navigation_prince_turn_to
			- player_navigation_prince_turn_from,
		-180.0,
		180.0
	))
	if turn_difference < 2.0:
		prince_record["yaw"] = player_navigation_prince_turn_to
		_apply_editable_3d_record(prince_index)
		player_navigation_prince_follow_state = "walking"
		_set_player_navigation_walk(prince_index, true)
		return
	player_navigation_prince_turn_elapsed = 0.0
	player_navigation_prince_follow_state = "turning"


func _finish_player_navigation() -> void:
	if not player_navigation_active:
		return
	var leader_index := _find_editable_record_index(
		player_navigation_leader_id,
		-1
	)
	var prince_index := _find_editable_record_index(
		player_navigation_prince_id,
		-1
	)
	var seat_id := String(
		player_navigation_planned_seat.get("seat_id", "")
	)
	if not seat_id.is_empty():
		_release_player_handhold()
	player_navigation_active = false
	player_navigation_phase = "idle"
	player_navigation_stuck_elapsed = 0.0
	player_navigation_progress_distance = INF
	player_navigation_follower_stuck_elapsed = 0.0
	player_navigation_follower_progress_distance = INF
	_set_player_navigation_walk(leader_index, false)
	_set_player_navigation_walk(prince_index, false)
	player_navigation_prince_follow_state = "idle"
	if seat_id.is_empty():
		_fade_player_navigation_marker()
		if player_place_status != null:
			player_place_status.text = "已抵达目标点"
	else:
		var leader_seat_value = player_navigation_planned_seat.get(
			"leader",
			{}
		)
		var prince_seat_value = player_navigation_planned_seat.get(
			"prince",
			{}
		)
		var prince_sat_down := (
			typeof(prince_seat_value) == TYPE_DICTIONARY
			and not (prince_seat_value as Dictionary).is_empty()
		)
		if (
			leader_index >= 0
			and typeof(leader_seat_value) == TYPE_DICTIONARY
		):
			_sit_player_character_at_seat(
				editable_3d_objects[leader_index],
				leader_seat_value
			)
		if (
			prince_index >= 0
			and typeof(prince_seat_value) == TYPE_DICTIONARY
		):
			_sit_player_character_at_seat(
				editable_3d_objects[prince_index],
				prince_seat_value
			)
		elif prince_index >= 0:
			_force_player_character_standing_at_follow_target(
				prince_index
			)
		if player_place_status != null:
			player_place_status.text = (
				"已坐下，小王子坐在旁边"
				if prince_sat_down
				else "已坐下，小王子站在旁边"
			)
	player_navigation_planned_seat.clear()
	player_navigation_pointer_seat.clear()
	_save_3d_layout()
	_finish_player_movement_onboarding()


func _force_player_character_standing_at_follow_target(
	index: int
) -> void:
	if (
		index < 0
		or index >= editable_3d_objects.size()
		or current_3d_scene != "player"
	):
		return
	var record: Dictionary = editable_3d_objects[index]
	if not _is_player_character_kind(String(record.get("kind", ""))):
		return
	record.erase("seat_id")
	record.erase("seat_kind")
	record.erase("seat_slot_index")
	record.erase("seat_slot_count")
	record.erase("seat_pose_hold_pending")
	record.erase("seat_pose_hold_time")
	record.erase("seat_height")
	record["seat_state"] = "standing"
	var raw_follow_target := player_navigation_prince_follow_target
	if raw_follow_target.length_squared() > 0.0001:
		var follow_target := _clamp_player_placement_plane_position(
			raw_follow_target
		)
		var surface_sample := _player_surface_sample_at_position(
			follow_target,
			float(record.get("placement_footprint", 0.10))
		)
		if not surface_sample.is_empty():
			_configure_player_plane_record(
				record,
				surface_sample.position,
				surface_sample.normal
			)
	var kind := String(record.get("kind", ""))
	var standing_height := float(player_asset_height_offsets.get(
		kind,
		-0.07
	))
	record["placement_height_offset"] = standing_height
	record["initial_placement_height_offset"] = standing_height
	record["selected_animation"] = "ambient_idle"
	record["initial_selected_animation"] = "ambient_idle"
	_apply_editable_3d_record(index)
	_apply_character_animation_choice(
		record.get("node") as Node3D,
		"ambient_idle",
		true
	)


func _cancel_player_navigation(save_layout: bool) -> void:
	player_navigation_pointer_seat.clear()
	if not player_navigation_active:
		return
	var leader_index := _find_editable_record_index(
		player_navigation_leader_id,
		-1
	)
	var prince_index := _find_editable_record_index(
		player_navigation_prince_id,
		-1
	)
	player_navigation_serial += 1
	player_navigation_active = false
	player_navigation_phase = "idle"
	player_navigation_stuck_elapsed = 0.0
	player_navigation_progress_distance = INF
	player_navigation_follower_stuck_elapsed = 0.0
	player_navigation_follower_progress_distance = INF
	_set_player_navigation_walk(leader_index, false)
	_set_player_navigation_walk(prince_index, false)
	player_navigation_prince_follow_state = "idle"
	player_navigation_planned_seat.clear()
	_fade_player_navigation_marker()
	if save_layout:
		_save_3d_layout()


func _try_start_player_navigation_at_screen(
	screen_position: Vector2
) -> bool:
	if player_navigation_active or not _player_navigation_input_available():
		return false
	var hit := _player_surface_hit(screen_position)
	if hit.is_empty():
		return false
	var target_position: Vector3 = hit.position
	var target_normal: Vector3 = hit.normal
	return _begin_player_navigation(
		target_position,
		target_normal,
		{}
	)


func _start_player_navigation_to_seat(seat_record: Dictionary) -> bool:
	if player_navigation_active or not _player_navigation_input_available():
		return false
	if seat_record.is_empty():
		return false
	return _begin_player_navigation(
		seat_record.get("position", Vector3.ZERO),
		seat_record.get("normal", player_placement_plane_normal),
		seat_record
	)


func _add_player_bridge_to_scene() -> void:
	if not ResourceLoader.exists(PLAYER_BRIDGE_3D):
		push_warning("Player bridge model is missing: " + PLAYER_BRIDGE_3D)
		return
	var bridge_normal := PLAYER_LOCKED_BRIDGE_NORMAL.normalized()
	var bridge_basis := (
		_normal_surface_basis(
			bridge_normal,
			PLAYER_LOCKED_BRIDGE_YAW
		)
		* Basis(
			Vector3.RIGHT,
			deg_to_rad(PLAYER_LOCKED_BRIDGE_TILT)
		)
	)
	var bridge_position := (
		PLAYER_LOCKED_BRIDGE_POSITION
		+ bridge_normal * PLAYER_LOCKED_BRIDGE_HEIGHT_OFFSET
	)
	var wrapper := _add_generated_part(
		model_3d,
		PLAYER_BRIDGE_3D,
		"PlayerBridgeLocked",
		Transform3D(bridge_basis, bridge_position),
		0.93949182445583
	)
	if wrapper == null:
		return
	wrapper.scale = Vector3.ONE * PLAYER_LOCKED_BRIDGE_SCALE
	wrapper.set_meta("player_locked_scene_asset", true)


func _add_player_waterways(root: Node3D) -> void:
	# The river is authored into the player scene and is no longer an editable
	# layout object. Ignore old deletion/layout records so it cannot move between
	# reloads or disappear after an accidental editor deletion.
	var wrapper := Node3D.new()
	wrapper.name = "Layout_player_river"
	root.add_child(wrapper)
	var waterways := PLAYER_WATERWAYS_SCRIPT.new() as Node3D
	waterways.name = "PlayerWaterways"
	wrapper.add_child(waterways)
	waterways.call(
		"configure_placement_darkening",
		player_placement_plane_center,
		player_placement_plane_normal
	)
	wrapper.set_meta("player_locked_scene_asset", true)
	pending_player_river_layout = {}


func _place_generated_planet_asset(slug: String, asset_data: Dictionary) -> Node3D:
	var normal_value = asset_data.get("normal", Vector3.UP)
	var normal := (
		normal_value as Vector3
		if normal_value is Vector3
		else Vector3(
			float(normal_value[0]),
			float(normal_value[1]),
			float(normal_value[2])
		)
	).normalized()
	var surface_radius := float(
		asset_data.get("radius", GENERATED_PLANET_RADIUS)
	)
	var surface_point := normal * surface_radius
	var upright := true
	var yaw := float(asset_data.get("yaw", 0.0))
	var kind := String(asset_data.get("kind", "prop"))
	var basis := (
		_upright_surface_basis(normal, surface_point)
		if kind in MERCHANT_ROPE_KINDS
		else _normal_surface_basis(normal, yaw)
	)
	var path := String(asset_data.get("path", ""))
	var wrapper: Node3D
	if kind == "procedural_rose":
		wrapper = _add_procedural_rose(
			model_3d,
			"Layout_" + slug + "_" + kind + "_" + str(editable_serial + 1),
			Transform3D(basis, surface_point),
			float(asset_data.get("extent", 0.92))
		)
	else:
		wrapper = _add_generated_part_fitted(
			model_3d,
			path,
			"Layout_" + slug + "_" + kind + "_" + str(editable_serial + 1),
			Transform3D(basis, surface_point),
			float(asset_data.get("extent", 0.8))
		)
	if wrapper == null:
		return null
	var fitted_scale := float(wrapper.get_meta("generated_part_scale", 1.0))
	if kind == "glass_dome":
		_make_generated_glass_material(wrapper)
	elif kind == "rose_model":
		_prepare_rose_dialogue_animation(wrapper)
	elif kind == "fox":
		_prepare_fox_animations(wrapper)
	_register_editable_3d(
		wrapper,
		kind,
		String(asset_data.get("label", kind)),
		normal,
		surface_radius,
		upright,
		yaw,
		fitted_scale,
		path,
		false
	)
	var record_index := editable_3d_objects.size() - 1
	editable_3d_objects[record_index]["id"] = "%s_%s-%02d" % [
		slug,
		kind,
		editable_serial,
	]
	editable_3d_objects[record_index]["planet_slug"] = slug
	if kind == "abacus":
		_build_interactive_abacus_beads(wrapper)
	var default_character_animation := ""
	if kind == "prince_character":
		_prepare_prince_character_animations(
			wrapper,
			String(asset_data.get("default_animation", "look_around_001"))
		)
	elif kind == "merchant_character":
		_install_rigged_animation(
			wrapper,
			MERCHANT_AGREE_ANIMATION_3D,
			"agree_001"
		)
		default_character_animation = "fold_arms_001"
	elif kind == "vain_character":
		_install_rigged_animation(
			wrapper,
			VAIN_REACTIONS_ANIMATION_3D,
			"agree_001"
		)
		_install_rigged_animation(
			wrapper,
			VAIN_REACTIONS_ANIMATION_3D,
			"look_around_001"
		)
		_install_rigged_animation(wrapper, VAIN_CHARACTER_3D, "cheer_001")
		_install_rigged_animation(wrapper, VAIN_CHARACTER_3D, "dance_01_001")
		_install_rigged_animation(wrapper, VAIN_CHARACTER_3D, "laugh_02_001")
		_build_subtle_idle_animation(
			wrapper,
			"agree_001",
			"vain_idle_001",
			0.16
		)
		default_character_animation = VAIN_DANCE_CLIP
	if not default_character_animation.is_empty():
		_set_character_animation_default(
			wrapper,
			default_character_animation
		)
	if asset_data.has("glow"):
		var extent := float(asset_data.get("extent", 0.8))
		var glow_scale := float(asset_data.get("glow", 0.5))
		var light_energy := float(asset_data.get("light_energy", 1.15))
		var light_range := float(asset_data.get("light_range", 3.4))
		var glow := _add_warm_glow(
			wrapper,
			Vector3(0.0, extent * 0.55, 0.0),
			light_energy,
			light_range,
			glow_scale
		)
		_attach_editor_light_anchor(wrapper, glow)
	return wrapper


func _build_interactive_abacus_beads(abacus: Node3D) -> void:
	abacus_bead_targets.clear()
	var group := Node3D.new()
	group.name = "InteractiveAbacusBeads"
	abacus.add_child(group)
	for row_index in ABACUS_BEAD_ROW_Y.size():
		var row_y := float(ABACUS_BEAD_ROW_Y[row_index])
		var row_initial_z: Array = ABACUS_BEAD_INITIAL_ROWS[row_index]
		for bead_index in row_initial_z.size():
			var initial_z := float(row_initial_z[bead_index])
			var pivot := Node3D.new()
			pivot.name = "Bead_Row%02d_%02d" % [row_index + 1, bead_index + 1]
			pivot.position = Vector3(0.0, row_y, initial_z)
			group.add_child(pivot)

			var impact_pivot := Node3D.new()
			impact_pivot.name = "BeadImpact"
			pivot.add_child(impact_pivot)
			var visual := _instantiate_generated_model(MERCHANT_ABACUS_BEADS_3D)
			if visual == null:
				pivot.queue_free()
				continue
			var bounds := _node_local_bounds(visual)
			var extent := maxf(
				bounds.size.x,
				maxf(bounds.size.y, bounds.size.z)
			)
			if extent <= 0.0001:
				pivot.queue_free()
				continue
			visual.name = "BeadVisual"
			var fitted_basis := (
				Basis(Vector3.UP, ABACUS_BEAD_HOLE_ALIGNMENT_YAW)
				* Basis.from_scale(
					Vector3.ONE * (ABACUS_BEAD_VISUAL_SIZE / extent)
				)
			)
			visual.basis = fitted_basis
			visual.position = -(fitted_basis * bounds.get_center())
			impact_pivot.add_child(visual)

			var collision_volume := Area3D.new()
			collision_volume.name = "BeadCollisionVolume"
			collision_volume.collision_layer = 1 << 19
			collision_volume.collision_mask = 0
			collision_volume.monitoring = false
			collision_volume.monitorable = false
			pivot.add_child(collision_volume)
			var collision_shape := CollisionShape3D.new()
			collision_shape.name = "CylinderShape"
			var bead_shape := CylinderShape3D.new()
			bead_shape.radius = ABACUS_BEAD_COLLISION_RADIUS
			bead_shape.height = ABACUS_BEAD_COLLISION_RADIUS * 2.0
			collision_shape.shape = bead_shape
			collision_shape.rotation.x = PI * 0.5
			collision_volume.add_child(collision_shape)
			abacus_bead_targets.append({
				"node": pivot,
				"visual": visual,
				"impact_pivot": impact_pivot,
				"collision_volume": collision_volume,
				"row_index": row_index,
				"bead_index": bead_index,
				"row_bead_count": row_initial_z.size(),
				"row_y": row_y,
				"min_z": ABACUS_BEAD_MIN_Z + ABACUS_BEAD_COLLISION_RADIUS,
				"max_z": ABACUS_BEAD_MAX_Z - ABACUS_BEAD_COLLISION_RADIUS,
				"z": initial_z,
				"rendered_z": initial_z,
				"velocity": 0.0,
				"rotation_angle": 0.0,
				"impact": 0.0,
			})


func _add_procedural_rose(
	parent: Node3D,
	part_name: String,
	part_transform: Transform3D,
	target_extent: float
) -> Node3D:
	var wrapper := Node3D.new()
	wrapper.name = part_name
	wrapper.transform = part_transform
	parent.add_child(wrapper)

	var model := Node3D.new()
	model.name = part_name + "Model"
	var size_factor := maxf(target_extent, 0.2) / 0.92
	model.scale = Vector3.ONE * size_factor
	wrapper.add_child(model)

	var stem_material := _make_rose_material(Color(0.18, 0.38, 0.17))
	var leaf_material := _make_rose_material(Color(0.28, 0.52, 0.22))
	var sepal_material := _make_rose_material(Color(0.24, 0.43, 0.18))
	var outer_petal_material := _make_rose_material(Color(0.62, 0.08, 0.18))
	var inner_petal_material := _make_rose_material(Color(0.82, 0.16, 0.25))
	var center_material := _make_rose_material(Color(0.94, 0.35, 0.34))

	var stem := CylinderMesh.new()
	stem.top_radius = 0.018
	stem.bottom_radius = 0.032
	stem.height = 0.68
	stem.radial_segments = 10
	var stem_instance := MeshInstance3D.new()
	stem_instance.name = "RoseStem"
	stem_instance.mesh = stem
	stem_instance.material_override = stem_material
	stem_instance.position.y = 0.34
	model.add_child(stem_instance)

	var petal_mesh := SphereMesh.new()
	petal_mesh.radius = 0.5
	petal_mesh.height = 1.0
	petal_mesh.radial_segments = 14
	petal_mesh.rings = 7

	for index in 10:
		var angle := TAU * float(index) / 10.0
		var petal := MeshInstance3D.new()
		petal.name = "OuterPetal_%02d" % index
		petal.mesh = petal_mesh
		petal.material_override = outer_petal_material
		petal.position = Vector3(
			cos(angle) * 0.105,
			0.77 + sin(float(index) * 2.4) * 0.018,
			sin(angle) * 0.105
		)
		petal.basis = (
			Basis(Vector3.UP, angle)
			* Basis(Vector3.RIGHT, deg_to_rad(24.0))
			* Basis().scaled(Vector3(0.105, 0.035, 0.17))
		)
		model.add_child(petal)

	for index in 7:
		var angle := TAU * float(index) / 7.0 + 0.24
		var petal := MeshInstance3D.new()
		petal.name = "InnerPetal_%02d" % index
		petal.mesh = petal_mesh
		petal.material_override = inner_petal_material
		petal.position = Vector3(
			cos(angle) * 0.052,
			0.82 + float(index % 2) * 0.018,
			sin(angle) * 0.052
		)
		petal.basis = (
			Basis(Vector3.UP, angle)
			* Basis(Vector3.RIGHT, deg_to_rad(38.0))
			* Basis().scaled(Vector3(0.065, 0.028, 0.11))
		)
		model.add_child(petal)

	var center := MeshInstance3D.new()
	center.name = "RoseHeart"
	center.mesh = petal_mesh
	center.material_override = center_material
	center.position = Vector3(0.0, 0.90, 0.0)
	center.scale = Vector3(0.058, 0.052, 0.058)
	model.add_child(center)

	for index in 5:
		var angle := TAU * float(index) / 5.0
		var sepal := MeshInstance3D.new()
		sepal.name = "Sepal_%02d" % index
		sepal.mesh = petal_mesh
		sepal.material_override = sepal_material
		sepal.position = Vector3(cos(angle) * 0.055, 0.69, sin(angle) * 0.055)
		sepal.basis = (
			Basis(Vector3.UP, angle)
			* Basis(Vector3.RIGHT, deg_to_rad(66.0))
			* Basis().scaled(Vector3(0.035, 0.018, 0.11))
		)
		model.add_child(sepal)

	for side in [-1.0, 1.0]:
		var leaf := MeshInstance3D.new()
		leaf.name = "RoseLeaf_%s" % ("L" if side < 0.0 else "R")
		leaf.mesh = petal_mesh
		leaf.material_override = leaf_material
		leaf.position = Vector3(0.13 * side, 0.35 + (0.09 if side > 0.0 else 0.0), 0.0)
		leaf.basis = (
			Basis(Vector3.UP, side * 0.7)
			* Basis(Vector3.BACK, deg_to_rad(28.0 * side))
			* Basis().scaled(Vector3(0.15, 0.025, 0.07))
		)
		model.add_child(leaf)

	wrapper.set_meta("generated_part_scale", size_factor)
	return wrapper


func _make_rose_material(color: Color) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.72
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	material.emission_enabled = true
	material.emission = color * Color(0.10, 0.06, 0.08, 1.0)
	material.emission_energy_multiplier = 0.22
	return material


func _prepare_rose_dialogue_animation(root: Node3D) -> void:
	rose_animation_root = root
	rose_animation_materials.clear()
	var rose_shader := load(ROSE_BLOOM_SHADER) as Shader
	if rose_shader == null:
		push_warning("Rose dialogue shader failed to load.")
		return
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var source := (
				mesh_instance.get_active_material(surface)
				as StandardMaterial3D
			)
			if source == null:
				continue
			var material := ShaderMaterial.new()
			material.shader = rose_shader
			material.set_shader_parameter("albedo_texture", source.albedo_texture)
			material.set_shader_parameter("normal_texture", source.normal_texture)
			material.set_shader_parameter(
				"roughness_texture",
				source.roughness_texture
			)
			material.set_shader_parameter(
				"has_albedo_texture",
				source.albedo_texture != null
			)
			material.set_shader_parameter(
				"has_normal_texture",
				source.normal_enabled and source.normal_texture != null
			)
			material.set_shader_parameter(
				"has_roughness_texture",
				source.roughness_texture != null
			)
			material.set_shader_parameter("albedo_tint", source.albedo_color)
			material.set_shader_parameter(
				"emission_tint",
				(
					source.emission
					if source.emission_enabled
					else Color(0.42, 0.08, 0.12, 1.0)
				)
			)
			material.set_shader_parameter("base_roughness", source.roughness)
			material.set_shader_parameter("base_metallic", source.metallic)
			mesh_instance.set_surface_override_material(surface, material)
			rose_animation_materials.append(material)
	_add_rose_inner_bloom(root)
	root.set_meta("rose_dialogue_animated", not rose_animation_materials.is_empty())
	_apply_rose_animation_parameters()


func _add_rose_inner_bloom(root: Node3D) -> void:
	if root.find_child("RoseInnerBloom", true, false) != null:
		return
	var combined_bounds := AABB()
	var has_bounds := false
	var inverse_root := root.global_transform.affine_inverse()
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var local_transform := inverse_root * mesh_instance.global_transform
		var mesh_bounds: AABB = local_transform * mesh_instance.get_aabb()
		combined_bounds = (
			mesh_bounds
			if not has_bounds
			else combined_bounds.merge(mesh_bounds)
		)
		has_bounds = true
	if not has_bounds or not combined_bounds.has_volume():
		return
	var petal_material := StandardMaterial3D.new()
	petal_material.albedo_color = Color(0.54, 0.045, 0.075)
	petal_material.roughness = 0.82
	petal_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	petal_material.emission_enabled = true
	petal_material.emission = Color(0.16, 0.012, 0.025)
	petal_material.emission_energy_multiplier = 0.18
	var petal_mesh := SphereMesh.new()
	petal_mesh.radius = 1.0
	petal_mesh.height = 2.0
	petal_mesh.radial_segments = 12
	petal_mesh.rings = 6
	petal_mesh.material = petal_material
	var bloom := Node3D.new()
	bloom.name = "RoseInnerBloom"
	bloom.position = Vector3(
		combined_bounds.get_center().x,
		combined_bounds.end.y - combined_bounds.size.y * 0.16,
		combined_bounds.get_center().z
	)
	root.add_child(bloom)
	for index in 7:
		var angle := TAU * float(index) / 7.0 + 0.18
		var petal := MeshInstance3D.new()
		petal.name = "InnerBloomPetal_%02d" % (index + 1)
		petal.mesh = petal_mesh
		petal.position = Vector3(
			cos(angle) * 0.042,
			0.0,
			sin(angle) * 0.042
		)
		petal.basis = (
			Basis(Vector3.UP, -angle)
			* Basis(Vector3.RIGHT, deg_to_rad(38.0))
			* Basis().scaled(Vector3(0.038, 0.020, 0.083))
		)
		petal.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		bloom.add_child(petal)
	for index in 5:
		var angle := TAU * float(index) / 5.0 + 0.46
		var petal := MeshInstance3D.new()
		petal.name = "InnerCorePetal_%02d" % (index + 1)
		petal.mesh = petal_mesh
		petal.position = Vector3(
			cos(angle) * 0.016,
			0.025,
			sin(angle) * 0.016
		)
		petal.basis = (
			Basis(Vector3.UP, -angle)
			* Basis(Vector3.RIGHT, deg_to_rad(68.0))
			* Basis().scaled(Vector3(0.025, 0.014, 0.054))
		)
		petal.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		bloom.add_child(petal)


func _begin_rose_dialogue_animation() -> void:
	if current_3d_scene != "rose":
		return
	_start_rose_rigid_motion()
	rose_animation_toward = _rose_direction_toward_prince()
	rose_glass_fog = 0.0
	rose_glass_fog_target = 0.0
	_apply_rose_glass_fog(0.0)
	_set_rose_dialogue_mood("intro")


func _end_rose_dialogue_animation() -> void:
	_stop_rose_rigid_motion()
	if rose_animation_materials.is_empty():
		return
	rose_animation_target_bloom = 0.5
	rose_animation_target_sway = 0.0007
	rose_animation_target_breath = 0.0018
	rose_animation_target_tremble = 0.0
	rose_animation_target_leaf = 0.22
	rose_animation_target_glow = 0.02
	rose_animation_target_turn = 0.0


func _start_rose_rigid_motion() -> void:
	if (
		rose_animation_root == null
		or not is_instance_valid(rose_animation_root)
	):
		return
	rose_animation_base_transform = rose_animation_root.transform
	rose_animation_transform_active = true


func _stop_rose_rigid_motion() -> void:
	if (
		rose_animation_transform_active
		and rose_animation_root != null
		and is_instance_valid(rose_animation_root)
	):
		rose_animation_root.transform = rose_animation_base_transform
	rose_animation_transform_active = false


func _set_rose_dialogue_mood(node_id: String) -> void:
	if dialogue_scene != "rose" or rose_animation_materials.is_empty():
		return
	var mood: Dictionary = ROSE_DIALOGUE_MOODS.get(
		node_id,
		ROSE_DIALOGUE_MOODS.intro
	)
	rose_animation_toward = _rose_direction_toward_prince()
	rose_animation_target_bloom = float(mood.get("bloom", 0.5))
	rose_animation_target_sway = float(mood.get("sway", 0.002))
	rose_animation_target_breath = float(mood.get("breath", 0.005))
	rose_animation_target_tremble = float(mood.get("tremble", 0.0))
	rose_animation_target_leaf = float(mood.get("leaf", 0.40))
	rose_animation_target_glow = float(mood.get("glow", 0.05))
	rose_animation_target_turn = float(mood.get("turn", 0.0))
	rose_glass_fog_target = maxf(
		rose_glass_fog_target,
		clampf(float(mood.get("fog", 0.0)), 0.0, 1.0)
	)


func _rose_direction_toward_prince() -> Vector2:
	var prince := _story_node_by_kind("prince_character")
	if (
		rose_animation_root == null
		or not is_instance_valid(rose_animation_root)
		or prince == null
		or not is_instance_valid(prince)
	):
		return Vector2.RIGHT
	var rose_center := _editable_world_bounds(rose_animation_root).get_center()
	var prince_center := _editable_world_bounds(prince).get_center()
	var delta := prince_center - rose_center
	var basis := rose_animation_root.global_transform.basis
	var direction := Vector2(
		delta.dot(basis.x.normalized()),
		delta.dot(basis.z.normalized())
	)
	if direction.length_squared() <= 0.000001:
		return Vector2.RIGHT
	return direction.normalized()


func _update_rose_dialogue_animation(delta: float) -> void:
	if (
		current_3d_scene != "rose"
		or rose_animation_root == null
		or not is_instance_valid(rose_animation_root)
		or rose_animation_materials.is_empty()
	):
		return
	var blend := 1.0 - exp(-delta * 2.6)
	rose_animation_time += delta * 0.36
	rose_animation_bloom = lerpf(
		rose_animation_bloom,
		rose_animation_target_bloom,
		blend
	)
	rose_animation_sway = lerpf(
		rose_animation_sway,
		rose_animation_target_sway,
		blend
	)
	rose_animation_breath = lerpf(
		rose_animation_breath,
		rose_animation_target_breath,
		blend
	)
	rose_animation_tremble = lerpf(
		rose_animation_tremble,
		rose_animation_target_tremble,
		blend
	)
	rose_animation_leaf = lerpf(
		rose_animation_leaf,
		rose_animation_target_leaf,
		blend
	)
	rose_animation_glow = lerpf(
		rose_animation_glow,
		rose_animation_target_glow,
		blend
	)
	rose_animation_turn = lerpf(
		rose_animation_turn,
		rose_animation_target_turn,
		blend
	)
	rose_glass_fog = lerpf(
		rose_glass_fog,
		rose_glass_fog_target,
		blend * 0.55
	)
	_apply_rose_animation_parameters()
	if story_action_phase not in ["rose_cloth", "rose_finishing"]:
		_apply_rose_glass_fog(rose_glass_fog)
	_apply_rose_rigid_motion()


func _apply_rose_rigid_motion() -> void:
	if (
		not rose_animation_transform_active
		or rose_animation_root == null
		or not is_instance_valid(rose_animation_root)
	):
		return
	var direction := Vector3(
		rose_animation_toward.x,
		0.0,
		rose_animation_toward.y
	).normalized()
	if direction.length_squared() <= 0.000001:
		direction = Vector3.RIGHT
	var lean_axis := Vector3.UP.cross(direction).normalized()
	var side_axis := direction.cross(Vector3.UP).normalized()
	var lean_angle := rose_animation_turn * 0.018
	var sway_angle := sin(rose_animation_time) * (
		0.0045
		+ rose_animation_sway * 1.8
	)
	var wave_angle := sin(rose_animation_time * 2.0) * (
		absf(rose_animation_turn) * 0.010
	)
	var animated_basis := (
		rose_animation_base_transform.basis
		* Basis(lean_axis, lean_angle + wave_angle)
		* Basis(side_axis, sway_angle)
	)
	rose_animation_root.transform = Transform3D(
		animated_basis,
		rose_animation_base_transform.origin
	)


func _apply_rose_animation_parameters() -> void:
	for material in rose_animation_materials:
		if material == null or not is_instance_valid(material):
			continue
		material.set_shader_parameter("bloom", rose_animation_bloom)
		material.set_shader_parameter("sway_strength", rose_animation_sway)
		material.set_shader_parameter("breath_strength", rose_animation_breath)
		material.set_shader_parameter("tremble_strength", rose_animation_tremble)
		material.set_shader_parameter("leaf_strength", rose_animation_leaf)
		material.set_shader_parameter("turn_strength", rose_animation_turn)
		material.set_shader_parameter(
			"turn_direction",
			rose_animation_toward
		)
		material.set_shader_parameter("glow_strength", rose_animation_glow)


func _apply_rose_glass_fog(amount: float) -> void:
	var fog_amount := clampf(amount, 0.0, 1.0)
	var dome := _story_node_by_kind("glass_dome")
	if dome == null:
		return
	for item in dome.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var material := (
				mesh_instance.get_active_material(surface)
				as StandardMaterial3D
			)
			if material == null:
				continue
			var color := ROSE_GLASS_CLEAR_COLOR.lerp(
				ROSE_GLASS_FOG_COLOR,
				fog_amount
			)
			color.a = lerpf(
				ROSE_GLASS_CLEAR_COLOR.a,
				ROSE_GLASS_FOG_COLOR.a,
				fog_amount
			)
			material.albedo_color = color
			material.roughness = lerpf(
				ROSE_GLASS_CLEAR_ROUGHNESS,
				ROSE_GLASS_FOG_ROUGHNESS,
				fog_amount
			)


func _update_rose_wipe_animation(progress: float) -> void:
	var amount := clampf(progress, 0.0, 1.0)
	rose_animation_target_bloom = lerpf(0.32, 0.74, amount)
	rose_animation_target_sway = lerpf(0.0015, 0.0025, amount)
	rose_animation_target_breath = lerpf(0.0030, 0.0085, amount)
	rose_animation_target_tremble = lerpf(0.18, 0.02, amount)
	rose_animation_target_leaf = lerpf(0.48, 0.78, amount)
	rose_animation_target_glow = lerpf(0.08, 0.29, amount)
	rose_animation_target_turn = lerpf(0.42, 0.72, amount)


func _make_generated_glass_material(root: Node3D) -> void:
	rose_glass_fog = 0.0
	rose_glass_fog_target = 0.0
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null or mesh_instance.skin != null:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var source := mesh_instance.get_active_material(surface)
			if source is not StandardMaterial3D:
				continue
			var glass := (source as StandardMaterial3D).duplicate() as StandardMaterial3D
			glass.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			glass.cull_mode = BaseMaterial3D.CULL_DISABLED
			mesh_instance.set_meta(
				"story_glass_clear_color",
				ROSE_GLASS_CLEAR_COLOR
			)
			mesh_instance.set_meta(
				"story_glass_clear_roughness",
				ROSE_GLASS_CLEAR_ROUGHNESS
			)
			glass.albedo_color = ROSE_GLASS_CLEAR_COLOR
			glass.metallic = 0.05
			glass.roughness = ROSE_GLASS_CLEAR_ROUGHNESS
			glass.emission_enabled = false
			mesh_instance.set_surface_override_material(surface, glass)


func _brighten_dark_generated_materials(root: Node3D) -> void:
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var source := mesh_instance.get_active_material(surface)
			if source is not StandardMaterial3D:
				continue
			var material := source as StandardMaterial3D
			if (
				material.albedo_texture != null
				or material.albedo_color.r + material.albedo_color.g + material.albedo_color.b
					>= 0.18
			):
				continue
			var lifted := material.duplicate() as StandardMaterial3D
			lifted.albedo_color = Color(0.24, 0.30, 0.40, material.albedo_color.a)
			lifted.emission_enabled = true
			lifted.emission = Color(0.035, 0.055, 0.085)
			lifted.emission_energy_multiplier = 0.28
			mesh_instance.set_surface_override_material(surface, lifted)


func _show_generated_planet_3d(planet_name: String, request_id: int) -> void:
	var scene_data: Dictionary = GENERATED_PLANET_SCENES.get(planet_name, {})
	var slug := String(scene_data.get("slug", ""))
	if slug.is_empty():
		_finish_planet_loading()
		_restore_planet_map_instant()
		return
	var was_cached := bool(generated_planet_ready.get(slug, false))
	if not was_cached:
		var loaded := await _load_generated_planet_scene(planet_name, request_id)
		if not loaded:
			_finish_planet_loading()
			_restore_planet_map_instant()
			return
	if request_id > 0 and (
		planet_loading_generation != request_id
		or not planet_zoom_active
	):
		return
	if was_cached:
		await _wait_for_simulated_planet_loading(request_id)
	if request_id > 0 and (
		planet_loading_generation != request_id
		or not planet_zoom_active
	):
		return

	_capture_current_editable_state()
	current_3d_scene = slug
	if editor_earth_wheat_controls != null:
		editor_earth_wheat_controls.visible = slug == "earth"
	model_3d = generated_planet_models.get(slug) as Node3D
	editable_3d_objects = []
	editable_3d_objects.assign(
		generated_planet_editable_objects.get(slug, [])
	)
	selected_editable_index = int(generated_planet_selected_indices.get(slug, -1))
	deleted_editable_ids = []
	deleted_editable_ids.assign(generated_planet_deleted_ids.get(slug, []))
	editable_serial = _highest_editable_serial(editable_3d_objects)
	if model_3d == null:
		_finish_planet_loading()
		_restore_planet_map_instant()
		return
	_touch_generated_planet_cache(slug)
	_evict_generated_planet_cache(slug)
	for cached_model in generated_planet_models.values():
		var cached_node := cached_model as Node3D
		if cached_node != null:
			cached_node.visible = false
	if pointlighter_model_3d != null:
		pointlighter_model_3d.visible = false
	if king_model_3d != null:
		king_model_3d.visible = false
	if king_celestial_root != null:
		king_celestial_root.visible = false
	model_3d.visible = true
	_apply_generated_planet_environment(slug)
	model_spin_velocity = Vector2.ZERO
	var story_state := String(planet_story_states.get(slug, "new"))
	if hud_scene_kicker != null:
		hud_scene_kicker.text = String(scene_data.kicker)
		hud_scene_title.text = planet_name
		hud_scene_quote.text = (
			String(STORY_DIALOGUE_DATA.COMPLETION_QUOTES.get(slug, scene_data.quote))
			if story_state == "complete"
			else String(scene_data.quote)
		)
		hud_scene_hint.text = ""
		if slug == "player":
			_refresh_player_scene_hint()
	_reapply_star_title_layout(slug)
	if chair_action_button != null:
		chair_action_button.visible = false
	if chair_target_marker != null:
		chair_target_marker.visible = false
	if chair_status_label != null:
		chair_status_label.visible = false
	if chair_subtitle_label != null:
		chair_subtitle_label.visible = false
	if lamp_dialogue_trigger != null:
		lamp_dialogue_trigger.visible = false
	_clear_story_action_ui()
	if editor_edit_button != null:
		editor_edit_button.visible = SHOW_LAYOUT_BUTTON and slug != "player"
	_update_player_placement_scene(slug)
	AudioDirector.play_music("player" if slug == "player" else "main")
	main_ui.visible = false
	stage_3d.visible = true
	hud_3d.visible = true
	if dream_grade_layer != null:
		dream_grade_layer.visible = true
	_reset_3d_view()
	if slug == "player":
		_clear_story_hint_cycle()
	else:
		_begin_story_hint_cycle(slug)
	if slug == "player":
		_calibrate_player_placement_plane_from_base()
		_migrate_player_objects_to_placement_plane()
	_restore_planet_map_instant(true)
	await get_tree().process_frame
	if slug == "earth":
		_ensure_earth_fox_ground_collision()
	await get_tree().process_frame
	_set_planet_loading_progress(100.0)
	await get_tree().process_frame
	_finish_planet_loading()
	if slug == "earth":
		if story_state == "complete":
			_show_fox_seated_state()
		else:
			_show_fox_standing_state()
		if story_state == "fox_found":
			_place_earth_fox_in_cave()
		elif story_state in ["dialogue_done", "complete"]:
			_place_earth_fox_at_cave_entrance()
		if story_state == "new":
			call_deferred("_begin_earth_fox_search")
	call_deferred("_resume_planet_story_after_enter", slug)
	if (
		slug == "player"
		and not player_avatar_picker_completed
		and not player_avatar_selected
	):
		call_deferred("_show_player_avatar_picker")
	elif slug == "player":
		player_avatar_picker_completed = true
		call_deferred("_maybe_start_player_onboarding")


func _warm_earth_wheat_materials(root: Node3D) -> void:
	if root == null:
		return
	var wheat_shader := load(EARTH_WHEAT_TONE_SHADER) as Shader
	if wheat_shader == null:
		return
	earth_wheat_materials.clear()
	var material_cache: Dictionary = {}
	var wheat_kinds := ["wheat_field", "grass_wheat_patch", "wheat"]
	for record in editable_3d_objects:
		if String(record.get("kind", "")) not in wheat_kinds:
			continue
		var wrapper := record.get("node") as Node3D
		if wrapper == null:
			continue
		for item in wrapper.find_children("*", "MeshInstance3D", true, false):
			var mesh_instance := item as MeshInstance3D
			if mesh_instance.mesh == null:
				continue
			# Dense procedural wheat self-shadows into large noisy bands. Turning
			# off its shadow casting keeps the paper-like color field readable.
			mesh_instance.cast_shadow = (
				GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
			)
			var mesh_bounds := mesh_instance.mesh.get_aabb()
			for surface in mesh_instance.mesh.get_surface_count():
				var current := mesh_instance.get_active_material(
					surface
				) as ShaderMaterial
				if current != null and current.shader == wheat_shader:
					if not earth_wheat_materials.has(current):
						earth_wheat_materials.append(current)
					current.set_shader_parameter(
						"brightness",
						earth_wheat_brightness
					)
					current.set_shader_parameter(
						"saturation",
						earth_wheat_saturation
					)
					continue
				var source := mesh_instance.get_active_material(surface)
				if source is not StandardMaterial3D:
					continue
				var texture := (
					source as StandardMaterial3D
				).albedo_texture
				var cache_key := "%s:%.4f:%.4f" % [
					texture.get_instance_id() if texture != null else 0,
					mesh_bounds.position.y,
					mesh_bounds.size.y,
				]
				var material := material_cache.get(
					cache_key,
					null
				) as ShaderMaterial
				if material == null:
					material = ShaderMaterial.new()
					material.shader = wheat_shader
					material.set_shader_parameter(
						"albedo_texture",
						texture
					)
					material.set_shader_parameter(
						"wind_floor_y",
						mesh_bounds.position.y
					)
					material.set_shader_parameter(
						"wind_height",
						maxf(mesh_bounds.size.y, 0.001)
					)
					material.set_shader_parameter(
						"wind_radius",
						0.72
					)
					material.set_shader_parameter(
						"wind_bend",
						0.12
					)
					material_cache[cache_key] = material
					earth_wheat_materials.append(material)
				material.set_shader_parameter(
					"brightness",
					earth_wheat_brightness
				)
				material.set_shader_parameter(
					"saturation",
					earth_wheat_saturation
				)
				mesh_instance.set_surface_override_material(
					surface,
					material
				)
			mesh_instance.set_meta("earth_wheat_warmed", true)


func _apply_generated_planet_environment(slug: String) -> void:
	if stage_environment == null:
		return
	if starfield_root != null:
		starfield_root.visible = (
			slug != "player" or player_day_night_blend < 0.68
		)
	stage_environment.background_energy_multiplier = 1.0
	stage_environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	stage_environment.fog_enabled = true
	stage_environment.adjustment_enabled = true
	stage_environment.tonemap_mode = Environment.TONE_MAPPER_ACES
	stage_key_light.rotation_degrees = Vector3(-50.0, 34.0, 0.0)
	stage_key_light.shadow_enabled = true
	stage_key_light.shadow_opacity = 0.54
	stage_rim_light.rotation_degrees = Vector3(-12.0, 142.0, 0.0)
	stage_cool_fill.position = Vector3(-5.5, 2.2, 4.5)
	warm_fill_light.position = Vector3(-2.2, 2.8, 4.8)
	stage_front_fill.position = Vector3(0.0, 2.1, 4.8)
	if earth_front_light != null:
		earth_front_light.visible = false
		earth_front_light.light_energy = 0.0
	match slug:
		"rose":
			stage_environment.background_color = Color(0.035, 0.028, 0.079)
			stage_environment.ambient_light_color = Color(0.57, 0.48, 0.68)
			stage_environment.ambient_light_energy = 0.70
			stage_environment.tonemap_exposure = 0.82
			stage_environment.fog_light_color = Color(0.11, 0.075, 0.17)
			stage_environment.fog_density = 0.012
			stage_environment.adjustment_brightness = 0.92
			stage_environment.adjustment_contrast = 1.01
			stage_environment.adjustment_saturation = 0.91
			stage_key_light.light_color = Color(1.0, 0.78, 0.66)
			stage_key_light.light_energy = 0.62
			stage_rim_light.light_color = Color(0.64, 0.46, 0.98)
			stage_rim_light.light_energy = 0.48
			warm_fill_light.light_color = Color(1.0, 0.50, 0.42)
			warm_fill_light.light_energy = 0.28
		"vain":
			stage_environment.background_color = Color(0.066, 0.025, 0.092)
			stage_environment.ambient_light_color = Color(0.67, 0.49, 0.76)
			stage_environment.ambient_light_energy = 0.67
			stage_environment.tonemap_exposure = 0.78
			stage_environment.fog_light_color = Color(0.18, 0.07, 0.22)
			stage_environment.fog_density = 0.014
			stage_environment.adjustment_brightness = 0.90
			stage_environment.adjustment_contrast = 1.02
			stage_environment.adjustment_saturation = 0.92
			stage_key_light.light_color = Color(0.98, 0.72, 0.72)
			stage_key_light.light_energy = 0.56
			stage_rim_light.light_color = Color(0.76, 0.42, 1.0)
			stage_rim_light.light_energy = 0.52
			warm_fill_light.light_color = Color(0.94, 0.45, 0.62)
			warm_fill_light.light_energy = 0.31
		"merchant":
			stage_environment.background_color = Color(0.022, 0.040, 0.070)
			stage_environment.ambient_light_color = Color(0.44, 0.54, 0.69)
			stage_environment.ambient_light_energy = 0.69
			stage_environment.tonemap_exposure = 0.79
			stage_environment.fog_light_color = Color(0.055, 0.095, 0.14)
			stage_environment.fog_density = 0.015
			stage_environment.adjustment_brightness = 0.91
			stage_environment.adjustment_contrast = 0.98
			stage_environment.adjustment_saturation = 0.86
			stage_key_light.light_color = Color(0.78, 0.84, 1.0)
			stage_key_light.light_energy = 0.56
			stage_rim_light.light_color = Color(1.0, 0.67, 0.32)
			stage_rim_light.light_energy = 0.46
			warm_fill_light.light_color = Color(1.0, 0.67, 0.30)
			warm_fill_light.light_energy = 0.37
		"earth":
			# Keep the sky cool enough for the golden field to read, but remove the
			# heavy blue fog that previously washed the wheat toward gray.
			stage_environment.background_color = Color(0.045, 0.048, 0.060)
			stage_environment.ambient_light_color = Color(0.62, 0.60, 0.53)
			stage_environment.ambient_light_energy = 0.76
			stage_environment.tonemap_exposure = 0.82
			stage_environment.fog_light_color = Color(0.12, 0.105, 0.075)
			stage_environment.fog_density = 0.0035
			stage_environment.adjustment_brightness = 0.93
			stage_environment.adjustment_contrast = 1.02
			stage_environment.adjustment_saturation = 0.98
			stage_key_light.light_color = Color(1.0, 0.82, 0.55)
			stage_key_light.light_energy = 0.74
			stage_key_light.rotation_degrees = Vector3(
				-50.0,
				earth_light_yaw,
				0.0
			)
			stage_key_light.shadow_enabled = false
			stage_rim_light.light_color = Color(0.58, 0.70, 0.92)
			stage_rim_light.light_energy = 0.28
			warm_fill_light.light_color = Color(1.0, 0.62, 0.22)
			warm_fill_light.light_energy = 0.42
			warm_fill_light.position = Vector3(1.8, 2.5, 5.2)
			stage_front_fill.light_color = Color(1.0, 0.84, 0.64)
			stage_front_fill.light_energy = 0.34
			stage_front_fill.position = Vector3(0.2, 2.5, 5.3)
			stage_cool_fill.light_energy = 0.16
			if earth_front_light != null:
				earth_front_light.visible = true
				earth_front_light.light_energy = 0.42
		"player":
			stage_environment.background_color = Color(0.040, 0.055, 0.080)
			stage_environment.ambient_light_color = Color(0.58, 0.65, 0.59)
			stage_environment.ambient_light_energy = 0.78
			stage_environment.tonemap_exposure = 0.86
			stage_environment.fog_light_color = Color(0.10, 0.14, 0.13)
			stage_environment.fog_density = 0.006
			stage_environment.adjustment_brightness = 0.96
			stage_environment.adjustment_contrast = 0.99
			stage_environment.adjustment_saturation = 0.91
			stage_key_light.light_color = Color(1.0, 0.87, 0.64)
			stage_key_light.light_energy = 0.70
			stage_rim_light.light_color = Color(0.54, 0.80, 0.82)
			stage_rim_light.light_energy = 0.42
			stage_cool_fill.light_color = Color(0.50, 0.72, 0.76)
			stage_cool_fill.light_energy = 0.22
			warm_fill_light.light_color = Color(1.0, 0.70, 0.38)
			warm_fill_light.light_energy = 0.34
			stage_front_fill.light_color = Color(0.72, 0.82, 0.74)
			stage_front_fill.light_energy = 0.26
		_:
			return
	stage_cool_fill.light_color = Color(0.37, 0.55, 0.84)
	stage_front_fill.light_color = Color(0.55, 0.67, 0.91)
	if slug == "earth":
		stage_cool_fill.light_color = Color(0.48, 0.58, 0.72)
		stage_front_fill.light_color = Color(1.0, 0.84, 0.64)
		_warm_earth_wheat_materials(model_3d)
	elif slug == "player":
		stage_cool_fill.light_color = Color(0.50, 0.72, 0.76)
		stage_front_fill.light_color = Color(0.72, 0.82, 0.74)
	if slug == "player":
		_apply_player_day_night(player_day_night_blend)
	else:
		_apply_planet_base_lighting_multiplier()
	_sync_planet_light_rig()


func _apply_player_day_night(day_amount: float) -> void:
	if stage_environment == null:
		return
	var day := clampf(day_amount, 0.0, 1.0)
	stage_environment.background_color = Color(0.012, 0.022, 0.055).lerp(
		Color(0.20, 0.39, 0.54),
		day
	)
	stage_environment.ambient_light_color = Color(0.48, 0.55, 0.72).lerp(
		Color(0.68, 0.72, 0.63),
		day
	)
	stage_environment.ambient_light_energy = lerpf(0.94, 0.96, day)
	stage_environment.tonemap_exposure = lerpf(0.82, 0.88, day)
	stage_environment.fog_light_color = Color(0.055, 0.080, 0.16).lerp(
		Color(0.28, 0.43, 0.42),
		day
	)
	stage_environment.fog_density = lerpf(0.014, 0.004, day)
	stage_environment.adjustment_brightness = lerpf(0.84, 0.98, day)
	stage_environment.adjustment_contrast = lerpf(1.04, 0.99, day)
	stage_environment.adjustment_saturation = lerpf(0.84, 0.94, day)
	if stage_key_light != null:
		stage_key_light.light_energy = 0.0
		stage_key_light.shadow_enabled = false
	if stage_rim_light != null:
		stage_rim_light.light_energy = lerpf(0.08, 0.14, day)
	if stage_cool_fill != null:
		stage_cool_fill.light_color = Color(0.25, 0.43, 0.86).lerp(
			Color(0.50, 0.72, 0.76),
			day
		)
		stage_cool_fill.light_energy = lerpf(0.56, 0.42, day)
	if warm_fill_light != null:
		warm_fill_light.light_color = Color(1.0, 0.48, 0.20).lerp(
			Color(1.0, 0.70, 0.38),
			day
		)
		warm_fill_light.light_energy = lerpf(0.10, 0.36, day)
	if stage_front_fill != null:
		stage_front_fill.light_color = Color(0.31, 0.46, 0.87).lerp(
			Color(0.72, 0.82, 0.74),
			day
		)
		stage_front_fill.light_energy = lerpf(0.72, 0.58, day)
		stage_front_fill.omni_range = lerpf(12.0, 10.0, day)
	if earth_front_light != null:
		earth_front_light.visible = false
		earth_front_light.light_energy = 0.0
	# Keep a quiet daytime presence so the player planet always retains its
	# signature fireflies; they become brightest after the night transition.
	player_firefly_opacity = lerpf(
		0.46,
		1.0,
		smoothstep(0.18, 0.82, 1.0 - day)
	)
	if starfield_root != null:
		starfield_root.visible = day < 0.68
	_update_player_day_night_beacon()
	_apply_planet_base_lighting_multiplier()


func _update_player_day_night(delta: float) -> void:
	if current_3d_scene != "player":
		return
	player_day_night_blend = move_toward(
		player_day_night_blend,
		player_day_night_target,
		delta / 1.35
	)
	_apply_player_day_night(player_day_night_blend)


func _toggle_player_day_night() -> void:
	if current_3d_scene != "player":
		return
	if player_day_night_beacon_ripple != null:
		player_day_night_beacon_ripple.call("trigger_click")
	player_day_night_target = (
		0.0 if player_day_night_target >= 0.5 else 1.0
	)
	_refresh_player_scene_hint()
	_save_3d_layout()
	_finish_player_day_night_onboarding()


func _build_player_day_night_beacon() -> void:
	if player_day_night_beacon != null or stage_3d == null:
		return
	player_day_night_beacon = Node3D.new()
	player_day_night_beacon.name = "PlayerDayNightBeacon"
	player_day_night_beacon.position = PLAYER_DAY_NIGHT_BEACON_POSITION
	player_day_night_beacon.visible = false
	stage_3d.add_child(player_day_night_beacon)

	player_day_night_beacon_outer_halo = _create_player_day_night_beacon_halo(
		0.58
	)
	player_day_night_beacon_outer_halo.name = "OuterBreathingHalo"
	player_day_night_beacon.add_child(player_day_night_beacon_outer_halo)

	player_day_night_beacon_halo = _create_player_day_night_beacon_halo(0.36)
	player_day_night_beacon_halo.name = "InnerBreathingHalo"
	player_day_night_beacon_halo.position.z = 0.006
	player_day_night_beacon.add_child(player_day_night_beacon_halo)

	var core_mesh := SphereMesh.new()
	core_mesh.radius = 0.054
	core_mesh.height = 0.108
	core_mesh.radial_segments = 32
	core_mesh.rings = 16
	player_day_night_beacon_core_material = StandardMaterial3D.new()
	player_day_night_beacon_core_material.shading_mode = (
		BaseMaterial3D.SHADING_MODE_UNSHADED
	)
	player_day_night_beacon_core_material.albedo_color = PLAYER_DAY_BEACON_COLOR
	player_day_night_beacon_core_material.emission_enabled = true
	player_day_night_beacon_core_material.emission = PLAYER_DAY_BEACON_COLOR
	player_day_night_beacon_core_material.emission_energy_multiplier = 3.4
	core_mesh.material = player_day_night_beacon_core_material
	player_day_night_beacon_core = MeshInstance3D.new()
	player_day_night_beacon_core.name = "BeaconCore"
	player_day_night_beacon_core.mesh = core_mesh
	player_day_night_beacon_core.cast_shadow = (
		GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	)
	player_day_night_beacon.add_child(player_day_night_beacon_core)

	player_day_night_beacon_light = OmniLight3D.new()
	player_day_night_beacon_light.name = "BeaconLight"
	player_day_night_beacon_light.light_color = PLAYER_DAY_BEACON_COLOR
	player_day_night_beacon_light.light_energy = 0.42
	player_day_night_beacon_light.omni_range = 0.92
	player_day_night_beacon_light.omni_attenuation = 1.1
	player_day_night_beacon_light.shadow_enabled = false
	player_day_night_beacon.add_child(player_day_night_beacon_light)


func _build_player_day_night_beacon_ripple(root: Control) -> void:
	if root == null:
		return
	player_day_night_beacon_ripple = PLAYER_DAY_NIGHT_RIPPLE_SCRIPT.new()
	player_day_night_beacon_ripple.name = "PlayerDayNightBeaconRipple"
	player_day_night_beacon_ripple.mouse_filter = Control.MOUSE_FILTER_IGNORE
	player_day_night_beacon_ripple.z_index = 35
	player_day_night_beacon_ripple.visible = false
	root.add_child(player_day_night_beacon_ripple)


func _create_player_day_night_beacon_halo(size: float) -> Sprite3D:
	var halo := Sprite3D.new()
	halo.texture = _make_soft_orb_texture(
		Color(1.0, 1.0, 1.0, 0.92),
		Color(1.0, 1.0, 1.0, 0.38),
		Color(1.0, 1.0, 1.0, 0.0)
	)
	halo.pixel_size = size / 256.0
	halo.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	halo.shaded = false
	halo.double_sided = true
	halo.modulate = PLAYER_DAY_BEACON_COLOR
	halo.render_priority = 3
	halo.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	return halo


func _update_player_day_night_beacon() -> void:
	if (
		player_day_night_beacon == null
		or player_day_night_beacon_core == null
		or player_day_night_beacon_core_material == null
	):
		return
	player_day_night_beacon.visible = (
		current_3d_scene == "player"
		and not editor_active
		and not dialogue_active
		and not player_avatar_picker_open
	)
	var day := clampf(player_day_night_blend, 0.0, 1.0)
	var beacon_color := PLAYER_NIGHT_BEACON_COLOR.lerp(
		PLAYER_DAY_BEACON_COLOR,
		smoothstep(0.0, 1.0, day)
	)
	player_day_night_beacon_color = beacon_color
	var pulse := 0.5 + 0.5 * sin(atmosphere_time * 1.72)
	var breath := smoothstep(0.0, 1.0, pulse)
	player_day_night_beacon_core_material.albedo_color = beacon_color
	player_day_night_beacon_core_material.emission = beacon_color
	player_day_night_beacon_core_material.emission_energy_multiplier = lerpf(
		1.6 + breath * 0.55,
		2.9 + breath * 1.2,
		smoothstep(0.0, 1.0, day)
	)
	player_day_night_beacon_core.scale = Vector3.ONE * (0.94 + breath * 0.10)
	if player_day_night_beacon_halo != null:
		player_day_night_beacon_halo.scale = Vector3.ONE * (
			0.88 + breath * 0.25
		)
		player_day_night_beacon_halo.modulate = Color(
			beacon_color.r,
			beacon_color.g,
			beacon_color.b,
			0.34 + breath * 0.22
		)
	if player_day_night_beacon_outer_halo != null:
		player_day_night_beacon_outer_halo.scale = Vector3.ONE * (
			0.92 + breath * 0.18
		)
		player_day_night_beacon_outer_halo.modulate = Color(
			beacon_color.r,
			beacon_color.g,
			beacon_color.b,
			0.11 + breath * 0.10
		)
	if player_day_night_beacon_light != null:
		player_day_night_beacon_light.light_color = beacon_color
		player_day_night_beacon_light.light_energy = 0.30 + breath * 0.20
	if player_day_night_beacon_ripple != null:
		var ripple_available := (
			player_day_night_beacon.visible
			and camera_3d != null
			and not camera_3d.is_position_behind(
				player_day_night_beacon.global_position
			)
		)
		if not ripple_available:
			player_day_night_beacon_hovered = false
			player_day_night_beacon_ripple.visible = false
			player_day_night_beacon_ripple.call(
				"set_feedback",
				false,
				beacon_color
			)
		else:
			var center := camera_3d.unproject_position(
				player_day_night_beacon.global_position
			)
			var projected_edge := camera_3d.unproject_position(
				player_day_night_beacon.global_position
				+ camera_3d.global_basis.x * 0.24
			)
			var diameter := clampf(
				center.distance_to(projected_edge) * 2.65,
				96.0,
				190.0
			)
			player_day_night_beacon_ripple.size = Vector2(
				diameter,
				diameter
			)
			player_day_night_beacon_ripple.position = (
				center - player_day_night_beacon_ripple.size * 0.5
			)
			player_day_night_beacon_ripple.visible = true
			player_day_night_beacon_ripple.call(
				"set_feedback",
				player_day_night_beacon_hovered,
				beacon_color
			)


func _is_player_day_night_beacon_at_screen(screen_position: Vector2) -> bool:
	if (
		current_3d_scene != "player"
		or camera_3d == null
		or player_day_night_beacon == null
		or not player_day_night_beacon.visible
		or camera_3d.is_position_behind(player_day_night_beacon.global_position)
	):
		return false
	var center := camera_3d.unproject_position(
		player_day_night_beacon.global_position
	)
	var projected_edge := camera_3d.unproject_position(
		player_day_night_beacon.global_position
		+ camera_3d.global_basis.x * 0.24
	)
	var hit_radius := clampf(
		center.distance_to(projected_edge) * 1.18,
		25.0,
		46.0
	)
	return center.distance_to(screen_position) <= hit_radius


func _capture_current_editable_state() -> void:
	if current_3d_scene == "pointlighter":
		pointlighter_editable_objects = editable_3d_objects
		pointlighter_selected_editable_index = selected_editable_index
		pointlighter_deleted_editable_ids = deleted_editable_ids
	elif current_3d_scene == "king":
		king_editable_objects = editable_3d_objects
		king_selected_editable_index = selected_editable_index
		king_deleted_editable_ids = deleted_editable_ids
	elif generated_planet_models.has(current_3d_scene):
		generated_planet_editable_objects[current_3d_scene] = editable_3d_objects
		generated_planet_selected_indices[current_3d_scene] = selected_editable_index
		generated_planet_deleted_ids[current_3d_scene] = deleted_editable_ids


func _highest_editable_serial(objects: Array) -> int:
	var highest := 0
	for record in objects:
		if typeof(record) != TYPE_DICTIONARY:
			continue
		var id := String(record.get("id", ""))
		var separator := id.rfind("-")
		if separator < 0 or separator + 1 >= id.length():
			continue
		highest = maxi(highest, int(id.substr(separator + 1)))
	return highest


func _yield_king_model_build(progress: float) -> void:
	_set_planet_loading_progress(progress)
	await get_tree().process_frame


func _add_king_part(
	path: String,
	kind: String,
	label: String,
	position: Vector3,
	base_scale: float,
	yaw_degrees: float
) -> Node3D:
	var rigged_override := _rigged_character_asset_for_kind(kind)
	if not rigged_override.is_empty():
		path = rigged_override
	var node := _add_generated_part(
		king_model_3d,
		path,
		"King_" + kind,
		Transform3D(Basis(Vector3.UP, deg_to_rad(yaw_degrees)), position),
		base_scale
	)
	if node == null:
		return null
	if path == KING_LOOKING_UP_PRINCE_3D:
		_ensure_mesh_lighting_data(node)
	elif path == KING_CHARACTER_3D:
		_ensure_mesh_lighting_data(node)
	elif (
		(path == KING_DRAPES_3D or path == KING_BANNERS_3D)
		and KING_CLOTH_WIND_ENABLED
	):
		_apply_king_cloth_wind(node, kind)
	editable_serial += 1
	var record := {
		"id": "king_%s-%02d" % [kind, editable_serial],
		"kind": kind,
		"label": label,
		"node": node,
		"asset_path": path,
		"base_scale": base_scale,
		"layout_mode": "plane",
		"position": position,
		"initial_position": position,
		"normal": Vector3.UP,
		"initial_normal": Vector3.UP,
		"root_radius": position.y,
		"initial_root_radius": position.y,
		"scale": 1.0,
		"initial_scale": 1.0,
		"yaw": yaw_degrees,
		"initial_yaw": yaw_degrees,
		"surface_tilt": 0.0,
		"initial_surface_tilt": 0.0,
		"upright": true,
		"locked": false,
		"default_hidden": false,
		"initial_hidden": false,
	}
	king_editable_objects.append(record)
	return node


func _rigged_character_asset_for_kind(kind: String) -> String:
	match kind:
		"lamplighter":
			return LAMPLIGHTER_3D
		"standing_prince":
			return STANDING_PRINCE_3D
		"prince_character":
			return STANDING_PRINCE_3D
		"king_character":
			return KING_CHARACTER_3D
		"looking_up_prince":
			return STANDING_PRINCE_3D
		"merchant_character":
			return MERCHANT_CHARACTER_3D
		"vain_character":
			return VAIN_CHARACTER_3D
		"fox":
			return FOX_RIGGED_3D
		"seated_prince_origami":
			return EARTH_SEATED_PRINCE_3D
	return ""


func _add_king_light(
	position: Vector3,
	yaw_degrees: float,
	light_on := true,
	layout_mode := "plane",
	surface_normal := Vector3.UP,
	root_radius := 0.0
) -> Node3D:
	var parent_model := (
		king_model_3d
		if layout_mode == "plane"
		else model_3d
	)
	if parent_model == null:
		return null
	editable_serial += 1
	var root := Node3D.new()
	root.name = "EditableGlowPoint_%02d" % editable_serial
	if layout_mode == "plane":
		root.transform = Transform3D(
			Basis(Vector3.UP, deg_to_rad(yaw_degrees)),
			position
		)
	else:
		var normal := surface_normal.normalized()
		root.transform = Transform3D(
			_normal_surface_basis(normal, yaw_degrees),
			normal * root_radius
		)
	parent_model.add_child(root)

	var core_material := StandardMaterial3D.new()
	core_material.albedo_color = Color(1.0, 0.86, 0.54)
	core_material.roughness = 0.18
	core_material.emission_enabled = true
	core_material.emission = Color(1.0, 0.52, 0.12)
	core_material.emission_energy_multiplier = 7.4
	core_material.set_meta("king_light_base_emission", 7.4)

	var core_mesh := SphereMesh.new()
	core_mesh.radius = 0.065
	core_mesh.height = 0.13
	core_mesh.radial_segments = 16
	core_mesh.rings = 8
	var core := MeshInstance3D.new()
	core.name = "GlowCoreMesh"
	core.mesh = core_mesh
	core.material_override = core_material
	core.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	# Rose's editable light should read as a soft inner glow, not a visible bulb.
	core.visible = current_3d_scene != "rose"
	root.add_child(core)

	var light_anchor := OmniLight3D.new()
	light_anchor.name = "LightAnchor"
	light_anchor.position = Vector3.ZERO
	light_anchor.light_color = Color(1.0, 0.58, 0.24)
	light_anchor.light_energy = 2.8
	light_anchor.omni_range = 2.25
	light_anchor.omni_attenuation = 0.82
	light_anchor.shadow_enabled = false
	light_anchor.set_meta("base_energy", 2.8)
	root.add_child(light_anchor)

	var glow_texture := _make_soft_orb_texture(
		Color(1.0, 1.0, 0.92, 1.0),
		Color(1.0, 0.68, 0.28, 0.68),
		Color(1.0, 0.27, 0.04, 0.0)
	)
	_add_king_light_glow(light_anchor, glow_texture, "GlowCore", 0.18, 0.96, 6)
	_add_king_light_glow(light_anchor, glow_texture, "GlowBloom", 0.36, 0.42, 5)
	_add_king_light_glow(light_anchor, glow_texture, "GlowHalo", 0.74, 0.16, 4)

	var record := {
		"id": "%s-%02d" % [KING_LIGHT_KIND, editable_serial],
		"kind": KING_LIGHT_KIND,
		"label": "发光点位",
		"node": root,
		"asset_path": "",
		"base_scale": 1.0,
		"layout_mode": layout_mode,
		"position": position,
		"initial_position": position,
		"normal": (
			surface_normal.normalized()
			if layout_mode == "sphere"
			else Vector3.UP
		),
		"initial_normal": (
			surface_normal.normalized()
			if layout_mode == "sphere"
			else Vector3.UP
		),
		"root_radius": root_radius if layout_mode == "sphere" else position.y,
		"initial_root_radius": root_radius if layout_mode == "sphere" else position.y,
		"scale": 1.0,
		"initial_scale": 1.0,
		"yaw": yaw_degrees,
		"initial_yaw": yaw_degrees,
		"surface_tilt": 0.0,
		"initial_surface_tilt": 0.0,
		"upright": true,
		"locked": false,
		"default_hidden": false,
		"initial_hidden": false,
		"light_anchor": light_anchor,
		"initial_light_offset": light_anchor.position,
		"light_on": light_on,
		"initial_light_on": light_on,
		"brightness": 1.0,
		"initial_brightness": 1.0,
		"light_range": 1.0,
		"initial_light_range": 1.0,
	}
	editable_3d_objects.append(record)
	_set_king_light_state(editable_3d_objects.size() - 1, light_on, false)
	return root


func _add_king_light_glow(
	parent: Node3D,
	texture: Texture2D,
	glow_name: String,
	glow_scale: float,
	alpha: float,
	render_priority: int
) -> void:
	var glow := Sprite3D.new()
	glow.name = glow_name
	glow.texture = texture
	glow.pixel_size = 0.01
	glow.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	glow.shaded = false
	glow.modulate = Color(1.0, 0.82, 0.55, alpha)
	glow.scale = Vector3.ONE * glow_scale
	glow.render_priority = render_priority
	glow.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	glow.set_meta("base_alpha", alpha)
	parent.add_child(glow)


func _set_king_light_state(index: int, light_on: bool, animate := true) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	if not _is_editable_light_record(record):
		return
	var root := record.node as Node3D
	if root == null:
		return
	record["light_on"] = light_on
	var brightness := clampf(float(record.get("brightness", 1.0)), 0.1, 2.5)
	var light_range := clampf(float(record.get("light_range", 1.0)), 0.35, 1.5)
	if String(record.get("kind", "")) != KING_LIGHT_KIND:
		_apply_lamp_light_state(
			root,
			brightness,
			light_range,
			light_on,
			animate
		)
		return
	var glow_brightness := clampf(brightness, 0.0, 1.0)
	var light_anchor := root.find_child("LightAnchor", true, false) as OmniLight3D
	var core := root.find_child("GlowCoreMesh", true, false) as MeshInstance3D
	var core_material := (
		core.get_active_material(0) as StandardMaterial3D
		if core != null
		else null
	)
	var previous_tween = record.get("light_tween", null)
	if previous_tween is Tween and (previous_tween as Tween).is_valid():
		(previous_tween as Tween).kill()
	var target_energy := 0.0
	if light_anchor != null:
		target_energy = (
			float(light_anchor.get_meta("base_energy", 2.8)) * brightness
			if light_on
			else 0.0
		)
		var base_range := float(
			light_anchor.get_meta("base_range", light_anchor.omni_range)
		)
		light_anchor.omni_range = base_range * light_range
	var target_emission := 0.0
	if core_material != null:
		target_emission = (
			float(core_material.get_meta("king_light_base_emission", 7.4))
			* brightness
			if light_on
			else 0.0
		)
	var glows := root.find_children("Glow*", "Sprite3D", true, false)
	if not animate:
		if light_anchor != null:
			light_anchor.light_energy = target_energy
		if core_material != null:
			core_material.emission_energy_multiplier = target_emission
		for item in glows:
			var glow := item as Sprite3D
			var glow_color := glow.modulate
			glow.modulate = Color(
				glow_color.r,
				glow_color.g,
				glow_color.b,
				float(glow.get_meta("base_alpha", 0.0)) * glow_brightness
				if light_on
				else 0.0
			)
		return
	var tween := create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if light_anchor != null:
		tween.tween_property(light_anchor, "light_energy", target_energy, 0.22)
	if core_material != null:
		tween.tween_property(core_material, "emission_energy_multiplier", target_emission, 0.22)
	for item in glows:
		var glow := item as Sprite3D
		var target_alpha := (
			float(glow.get_meta("base_alpha", 0.0)) * glow_brightness
			if light_on
			else 0.0
		)
		tween.tween_property(glow, "modulate:a", target_alpha, 0.22)
	record["light_tween"] = tween


func _is_editable_light_record(record: Dictionary) -> bool:
	return (
		String(record.get("kind", "")) in EDITABLE_LIGHT_KINDS
		and record.get("light_anchor", null) != null
	)


func _apply_lamp_light_state(
	root: Node3D,
	brightness: float,
	light_range: float,
	light_on: bool,
	animate: bool
) -> void:
	var anchor := root.find_child("LightAnchor", true, false) as Node3D
	if anchor == null:
		return
	var old_tween = (
		root.get_meta("editable_light_tween")
		if root.has_meta("editable_light_tween")
		else null
	)
	if old_tween is Tween and (old_tween as Tween).is_valid():
		(old_tween as Tween).kill()
	var light_targets: Array[Dictionary] = []
	for item in anchor.find_children("*", "OmniLight3D", true, false):
		var light := item as OmniLight3D
		if not light.has_meta("base_energy"):
			light.set_meta("base_energy", light.light_energy)
		if not light.has_meta("base_range"):
			light.set_meta("base_range", light.omni_range)
		light.set_meta("editable_light_brightness", brightness)
		light.set_meta("editable_light_range", light_range)
		light.set_meta("editable_light_on", light_on)
		light_targets.append({
			"node": light,
			"energy": (
				float(light.get_meta("base_energy", light.light_energy))
				* brightness
				if light_on
				else 0.0
			),
			"range": (
				float(light.get_meta("base_range", light.omni_range))
				* light_range
			),
		})
	var glow_targets: Array[Dictionary] = []
	for item in anchor.find_children("*", "Sprite3D", true, false):
		var glow := item as Sprite3D
		if not glow.has_meta("base_alpha"):
			glow.set_meta("base_alpha", glow.modulate.a)
		glow.set_meta("editable_light_brightness", brightness)
		glow.set_meta("editable_light_on", light_on)
		glow_targets.append({
			"node": glow,
			"alpha": (
				float(glow.get_meta("base_alpha", glow.modulate.a))
				* brightness
				if light_on
				else 0.0
			),
		})
	if not animate:
		for target in light_targets:
			var light := target.node as OmniLight3D
			light.light_energy = float(target.energy)
			light.omni_range = float(target.range)
		for target in glow_targets:
			var glow := target.node as Sprite3D
			var glow_color := glow.modulate
			glow_color.a = float(target.alpha)
			glow.modulate = glow_color
		return
	var tween := create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	for target in light_targets:
		tween.tween_property(
			target.node,
			"light_energy",
			float(target.energy),
			0.22
		)
		tween.tween_property(
			target.node,
			"omni_range",
			float(target.range),
			0.22
		)
	for target in glow_targets:
		tween.tween_property(target.node, "modulate:a", float(target.alpha), 0.22)
	root.set_meta("editable_light_tween", tween)


func _toggle_king_light(index: int) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	if not _is_editable_light_record(record):
		return
	var turning_on := not bool(record.get("light_on", true))
	_set_king_light_state(index, turning_on)
	model_spin_velocity = Vector2.ZERO


func _king_light_at_screen(screen_position: Vector2) -> int:
	if camera_3d == null:
		return -1
	var best_index := -1
	var best_distance := INF
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		if not _is_editable_light_record(record):
			continue
		var root := record.node as Node3D
		if root == null or not root.visible:
			continue
		var anchor := record.get("light_anchor") as Node3D
		if anchor == null:
			continue
		var world_position := anchor.global_position
		if camera_3d.is_position_behind(world_position):
			continue
		var center := camera_3d.unproject_position(world_position)
		var edge_world := world_position + camera_3d.global_basis.x * (0.18 * float(record.scale))
		var projected_radius := center.distance_to(camera_3d.unproject_position(edge_world))
		var hit_radius := clampf(maxf(22.0, projected_radius * 1.8), 22.0, 54.0)
		var screen_distance := center.distance_to(screen_position)
		if screen_distance <= hit_radius and screen_distance < best_distance:
			best_distance = screen_distance
			best_index = index
	return best_index


func _make_king_light_core_unique(root: Node3D) -> void:
	var core := root.find_child("GlowCoreMesh", true, false) as MeshInstance3D
	if core == null or core.material_override is not StandardMaterial3D:
		return
	core.material_override = (core.material_override as StandardMaterial3D).duplicate()


func _add_king_light_from_editor() -> void:
	if model_3d == null:
		return
	var light_count := 0
	for record in editable_3d_objects:
		if String(record.get("kind", "")) == KING_LIGHT_KIND:
			light_count += 1
	var node: Node3D
	if current_3d_scene == "king":
		var tower_points := [
			Vector3(-0.95, 2.43, 0.56),
			Vector3(0.74, 2.12, 0.86),
			Vector3(-0.95, 2.76, 0.56),
			Vector3(0.74, 2.45, 0.86),
		]
		node = _add_king_light(
			tower_points[light_count % tower_points.size()],
			0.0,
			true
		)
	else:
		var base_normal: Vector3 = DEFAULT_GLOW_POINT_NORMALS.get(
			current_3d_scene,
			Vector3(0.30, 0.78, 0.55)
		)
		base_normal = (
			Basis(Vector3.UP, deg_to_rad(float(light_count) * 53.0))
			* base_normal
		).normalized()
		var radius := _default_glow_point_radius()
		node = _add_king_light(
			base_normal * radius,
			0.0,
			true,
			"sphere",
			base_normal,
			radius
		)
	if node == null:
		return
	selected_editable_index = editable_3d_objects.size() - 1
	_refresh_editor_object_list()
	_update_editor_selection_ring()
	_editor_set_status("已添加发光点位。可在列表中选中并调整位置、亮度或复制。")


func _default_glow_point_radius() -> float:
	return 2.48 if current_3d_scene == "pointlighter" else 2.62


func _ensure_default_glow_point() -> void:
	if current_3d_scene == "player":
		return
	for record in editable_3d_objects:
		if String(record.get("kind", "")) == KING_LIGHT_KIND:
			return
	var normal: Vector3 = DEFAULT_GLOW_POINT_NORMALS.get(
		current_3d_scene,
		Vector3(0.30, 0.78, 0.55)
	)
	normal = normal.normalized()
	var radius := _default_glow_point_radius()
	_add_king_light(
		normal * radius,
		0.0,
		true,
		"sphere",
		normal,
		radius
	)


func _add_king_orbit_ring() -> void:
	var torus := TorusMesh.new()
	torus.inner_radius = 0.565
	torus.outer_radius = 0.585
	torus.rings = 72
	torus.ring_segments = 8
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color(0.82, 0.58, 0.18)
	material.emission_enabled = true
	material.emission = Color(0.86, 0.54, 0.14)
	material.emission_energy_multiplier = 0.45
	torus.material = material
	var ring := MeshInstance3D.new()
	ring.name = "KingGoldOrbitRing"
	ring.mesh = torus
	ring.position.y = king_floor_y * 0.42
	ring.rotation.x = deg_to_rad(7.0)
	ring.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	king_model_3d.add_child(ring)


func _add_generated_planet_base(parent: Node3D) -> bool:
	return _add_generated_planet_base_for_path(parent, PLANET_BASE_3D)


func _add_generated_planet_base_for_path(parent: Node3D, path: String) -> bool:
	var base_model := _instantiate_generated_model(path)
	if base_model == null:
		return false
	var bounds := _node_local_bounds(base_model)
	if bounds.size.x <= 0.0 or bounds.size.y <= 0.0 or bounds.size.z <= 0.0:
		base_model.queue_free()
		return false
	# The generated base is slightly compressed on its horizontal axis. Normalize
	# the exported bounds so the final base remains a genuinely round sphere.
	var base_scale := Vector3(
		VISUAL_PLANET_BASE_RADIUS * 2.0 / bounds.size.x,
		VISUAL_PLANET_BASE_RADIUS * 2.0 / bounds.size.y,
		VISUAL_PLANET_BASE_RADIUS * 2.0 / bounds.size.z
	)
	base_model.name = "PlanetBase"
	base_model.scale = base_scale
	base_model.position = -bounds.get_center() * base_scale
	base_model.position.y += VISUAL_PLANET_BASE_Y_OFFSET
	parent.add_child(base_model)
	return true


func _add_generated_part(
	parent: Node3D,
	path: String,
	part_name: String,
	part_transform: Transform3D,
	uniform_scale: float,
	local_offset := Vector3.ZERO
) -> Node3D:
	var model := _instantiate_generated_model(path)
	if model == null:
		return null
	var bounds := _node_local_bounds(model)
	var wrapper := Node3D.new()
	wrapper.name = part_name
	wrapper.transform = part_transform
	wrapper.position += part_transform.basis * local_offset
	model.name = part_name + "Model"
	model.scale = Vector3.ONE * uniform_scale
	model.position = -Vector3(bounds.get_center().x, 0.0, bounds.get_center().z) * uniform_scale
	wrapper.add_child(model)
	parent.add_child(wrapper)
	return wrapper


func _add_generated_part_fitted(
	parent: Node3D,
	path: String,
	part_name: String,
	part_transform: Transform3D,
	target_extent: float,
	local_offset := Vector3.ZERO
) -> Node3D:
	var model := _instantiate_generated_model(path)
	if model == null:
		return null
	var bounds := _node_local_bounds(model)
	var longest_extent := maxf(bounds.size.x, maxf(bounds.size.y, bounds.size.z))
	if longest_extent <= 0.0001:
		model.queue_free()
		return null
	var uniform_scale := maxf(target_extent, 0.02) / longest_extent
	var wrapper := Node3D.new()
	wrapper.name = part_name
	wrapper.transform = part_transform
	wrapper.position += part_transform.basis * local_offset
	model.name = part_name + "Model"
	model.scale = Vector3.ONE * uniform_scale
	model.position = -Vector3(
		bounds.get_center().x,
		bounds.position.y,
		bounds.get_center().z
	) * uniform_scale
	wrapper.add_child(model)
	wrapper.set_meta("generated_part_scale", uniform_scale)
	parent.add_child(wrapper)
	return wrapper


func _add_player_asset_fitted(
	parent: Node3D,
	asset_data: Dictionary,
	part_name: String,
	part_transform: Transform3D,
	target_extent: float
) -> Node3D:
	var model := PLAYER_ASSET_FACTORY_SCRIPT.instantiate_fitted(
		asset_data,
		target_extent
	) as Node3D
	if model == null:
		return null
	var wrapper := Node3D.new()
	wrapper.name = part_name
	wrapper.transform = part_transform
	model.name = part_name + "Model"
	wrapper.add_child(model)
	wrapper.set_meta("generated_part_scale", 1.0)
	parent.add_child(wrapper)
	_prepare_player_person_animations(
		wrapper,
		String(asset_data.get("kind", ""))
	)
	if String(asset_data.get("kind", "")) == "player_star_earth_fox":
		_prepare_fox_animations(wrapper)
	if String(asset_data.get("kind", "")) == "player_prince":
		# Keep the authored stance; the player-scene Prince must not receive the
		# extra upward head tilt used by the King planet's looking-up variant.
		_prepare_prince_character_animations(wrapper, "ambient_idle")
	_soften_player_light_terminator(wrapper)
	return wrapper


func _configure_player_asset_light(
	wrapper: Node3D,
	asset_data: Dictionary
) -> void:
	if wrapper == null or not asset_data.has("light"):
		return
	var light_data = asset_data.get("light")
	if typeof(light_data) != TYPE_DICTIONARY:
		return
	var data := light_data as Dictionary
	var offset: Vector3 = data.get("offset", Vector3.ZERO)
	var color: Color = data.get("color", Color(1.0, 0.61, 0.28))
	var glow := _add_warm_glow(
		wrapper,
		offset,
		float(data.get("energy", 3.2)),
		float(data.get("range", 4.0)),
		float(data.get("glow_scale", 0.28))
	)
	var cast_light := bool(data.get("cast_light", true))
	for item in glow.find_children("*", "OmniLight3D", true, false):
		var light := item as OmniLight3D
		if light != null:
			if cast_light:
				light.light_color = color
				light.omni_attenuation = float(
					data.get("attenuation", 3.0)
				)
			else:
				light.get_parent().remove_child(light)
				light.queue_free()
	var child_glow_texture := _make_soft_orb_texture(
		Color(1.0, 0.98, 0.84, 1.0),
		Color(1.0, 0.82, 0.48, 0.34),
		Color(1.0, 0.58, 0.20, 0.0)
	)
	for item in glow.find_children("*", "Sprite3D", true, false):
		var sprite := item as Sprite3D
		if sprite != null:
			sprite.texture = child_glow_texture
			var glow_color := sprite.modulate
			glow_color.r = color.r
			glow_color.g = color.g
			glow_color.b = color.b
			sprite.modulate = glow_color


func _player_asset_definition_for_kind(kind: String) -> Dictionary:
	for asset_value in PLAYER_PLACEABLE_ASSETS:
		if (
			typeof(asset_value) == TYPE_DICTIONARY
			and String(asset_value.get("kind", "")) == kind
		):
			return (asset_value as Dictionary).duplicate(true)
	for asset_value in PLAYER_CHARACTER_ASSETS:
		if (
			typeof(asset_value) == TYPE_DICTIONARY
			and String(asset_value.get("kind", "")) == kind
		):
			return (asset_value as Dictionary).duplicate(true)
	return _star_backpack_asset_for_kind(kind)


func _find_rig_animation_player(root: Node3D) -> AnimationPlayer:
	if root == null:
		return null
	return root.find_child("AnimationPlayer", true, false) as AnimationPlayer


func _prepare_fox_animations(root: Node3D) -> void:
	_apply_fox_paper_materials(root)
	var player := _find_rig_animation_player(root)
	if player == null:
		push_warning("Animated fox has no AnimationPlayer.")
		return
	var library := player.get_animation_library("")
	if library != null:
		for clip_name in player.get_animation_list().duplicate():
			var name := String(clip_name)
			if name.begins_with("AnimalArmature|"):
				library.remove_animation(name)
	var idle_clips := _fox_idle_clips(root)
	if idle_clips.is_empty():
		var clips := player.get_animation_list()
		if not clips.is_empty():
			idle_clips.append(String(clips[0]))
	if idle_clips.is_empty():
		return
	var preferred := String(idle_clips[0])
	root.set_meta("preferred_character_animation", preferred)
	root.set_meta("fox_idle_cycle_enabled", true)
	player.speed_scale = 1.0
	var finished_callable := _on_fox_idle_animation_finished.bind(root)
	if not player.animation_finished.is_connected(finished_callable):
		player.animation_finished.connect(finished_callable)
	_start_fox_idle_cycle(root, preferred)


func _fox_idle_clips(root: Node3D) -> Array[String]:
	var result: Array[String] = []
	var player := _find_rig_animation_player(root)
	if player == null:
		return result
	for clip_name in FOX_IDLE_CYCLE_CLIPS:
		if player.has_animation(clip_name):
			result.append(clip_name)
	return result


func _start_fox_idle_cycle(root: Node3D, requested_clip := "") -> bool:
	if (
		root == null
		or not is_instance_valid(root)
		or not bool(root.get_meta("fox_idle_cycle_enabled", false))
	):
		return false
	var clips := _fox_idle_clips(root)
	if clips.is_empty():
		return false
	var clip_index := clips.find(requested_clip)
	if clip_index < 0:
		clip_index = 0
	root.set_meta("fox_idle_cycle_active", true)
	root.set_meta("fox_idle_cycle_index", clip_index)
	return _play_fox_idle_cycle_clip(root, clip_index)


func _stop_fox_idle_cycle(root: Node3D) -> void:
	if root != null and is_instance_valid(root):
		root.set_meta("fox_idle_cycle_active", false)


func _play_fox_idle_cycle_clip(root: Node3D, clip_index: int) -> bool:
	var clips := _fox_idle_clips(root)
	if clips.is_empty():
		return false
	var player := _find_rig_animation_player(root)
	if player == null:
		return false
	var index := posmod(clip_index, clips.size())
	var clip_name := clips[index]
	var animation := player.get_animation(clip_name)
	animation.loop_mode = Animation.LOOP_NONE
	player.speed_scale = 1.0
	root.set_meta("fox_idle_cycle_index", index)
	player.play(clip_name, 0.36)
	return true


func _on_fox_idle_animation_finished(
	animation_name: StringName,
	root: Node3D
) -> void:
	if (
		root == null
		or not is_instance_valid(root)
		or not bool(root.get_meta("fox_idle_cycle_active", false))
		or String(animation_name) not in _fox_idle_clips(root)
	):
		return
	var current_index := int(root.get_meta("fox_idle_cycle_index", 0))
	_play_fox_idle_cycle_clip(root, current_index + 1)


func _apply_fox_paper_materials(root: Node3D) -> void:
	var shader := load(FOX_PAPER_SHADER) as Shader
	if shader == null:
		push_warning("Fox paper shader failed to load.")
		return
	var fallback_order := [
		Color(0.72, 0.29, 0.11, 1.0),
		Color(0.90, 0.76, 0.57, 1.0),
		Color(0.34, 0.22, 0.16, 1.0),
		Color(0.075, 0.048, 0.038, 1.0),
		Color(0.045, 0.028, 0.023, 1.0),
	]
	var palette := {
		"main": fallback_order[0],
		"main_light": fallback_order[1],
		"grey": fallback_order[2],
		"gray": fallback_order[2],
		"black": fallback_order[3],
		"eyes": fallback_order[4],
	}
	var surface_order := 0
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var source := (
				mesh_instance.get_active_material(surface)
				as StandardMaterial3D
			)
			var source_name := (
				source.resource_name.to_lower()
				if source != null
				else ""
			)
			var color: Color = palette.get(
				source_name,
				fallback_order[mini(surface_order, fallback_order.size() - 1)]
			)
			var is_eye := source_name.contains("eye")
			var is_dark := source_name in ["black", "eyes"]
			var material := ShaderMaterial.new()
			material.shader = shader
			material.set_shader_parameter("paper_color", color)
			material.set_shader_parameter(
				"paper_roughness",
				0.24 if is_eye else (0.62 if is_dark else 0.88)
			)
			material.set_shader_parameter(
				"grain_strength",
				0.05 if is_eye else (0.28 if is_dark else 0.58)
			)
			material.set_shader_parameter("grain_scale", 58.0 + surface_order * 4.0)
			mesh_instance.set_surface_override_material(surface, material)
			surface_order += 1
	root.set_meta("fox_paper_material", true)


func _load_rigged_animation_clip(path: String, clip_name: String) -> Animation:
	var cache_key := path + "::" + clip_name
	if rigged_animation_cache.has(cache_key):
		return rigged_animation_cache[cache_key] as Animation
	var packed := load(path) as PackedScene
	if packed == null:
		return null
	var instance := packed.instantiate() as Node3D
	if instance == null:
		return null
	var player := _find_rig_animation_player(instance)
	if player == null or not player.has_animation(clip_name):
		instance.free()
		return null
	var animation := player.get_animation(clip_name).duplicate(true) as Animation
	instance.free()
	rigged_animation_cache[cache_key] = animation
	return animation


func _install_rigged_animation(
	root: Node3D,
	source_path: String,
	source_clip: String,
	target_clip := ""
) -> AnimationPlayer:
	var player := _find_rig_animation_player(root)
	if player == null:
		return null
	var target_name := source_clip if target_clip.is_empty() else target_clip
	if not player.has_animation(target_name):
		var animation := _load_rigged_animation_clip(source_path, source_clip)
		if animation == null:
			return player
		if target_name == "walk_001":
			animation = _retarget_animation_to_skeleton(
				animation,
				_find_rig_skeleton(root),
				source_path
			)
			_make_walk_animation_in_place(root, animation)
		var library: AnimationLibrary = player.get_animation_library("")
		if library == null:
			library = AnimationLibrary.new()
			player.add_animation_library("", library)
		library.add_animation(target_name, animation)
	return player


func _find_rig_skeleton(root: Node3D) -> Skeleton3D:
	if root == null:
		return null
	var skeletons := root.find_children("*", "Skeleton3D", true, false)
	return skeletons[0] as Skeleton3D if not skeletons.is_empty() else null


func _retarget_animation_to_skeleton(
	animation: Animation,
	target_skeleton: Skeleton3D,
	source_path: String
) -> Animation:
	if animation == null or target_skeleton == null:
		return animation
	var packed := load(source_path) as PackedScene
	if packed == null:
		return animation
	var source_root := packed.instantiate() as Node3D
	if source_root == null:
		return animation
	var source_skeleton := _find_rig_skeleton(source_root)
	if source_skeleton == null:
		source_root.free()
		return animation
	var source_rotation_tracks := {}
	var track_root_path := "Armature/Skeleton3D"
	for track_index in animation.get_track_count():
		var track_path := String(animation.track_get_path(track_index))
		track_root_path = track_path.get_slice(":", 0)
		if animation.track_get_type(track_index) != Animation.TYPE_ROTATION_3D:
			continue
		var bone_name := track_path.get_slice(
			":",
			track_path.get_slice_count(":") - 1
		)
		source_rotation_tracks[bone_name] = track_index
	var source_rest_global: Array[Quaternion] = []
	var source_rest_local: Array[Quaternion] = []
	source_rest_global.resize(source_skeleton.get_bone_count())
	source_rest_local.resize(source_skeleton.get_bone_count())
	for bone in source_skeleton.get_bone_count():
		source_rest_global[bone] = (
			source_skeleton.get_bone_global_rest(bone).basis
			.get_rotation_quaternion()
			.normalized()
		)
		source_rest_local[bone] = (
			source_skeleton.get_bone_rest(bone).basis
			.get_rotation_quaternion()
			.normalized()
		)
	var target_rest_global: Array[Quaternion] = []
	var target_rest_local: Array[Quaternion] = []
	target_rest_global.resize(target_skeleton.get_bone_count())
	target_rest_local.resize(target_skeleton.get_bone_count())
	for bone in target_skeleton.get_bone_count():
		target_rest_global[bone] = (
			target_skeleton.get_bone_global_rest(bone).basis
			.get_rotation_quaternion()
			.normalized()
		)
		target_rest_local[bone] = (
			target_skeleton.get_bone_rest(bone).basis
			.get_rotation_quaternion()
			.normalized()
		)
	var retargeted := Animation.new()
	retargeted.length = animation.length
	retargeted.loop_mode = animation.loop_mode
	retargeted.step = 1.0 / 30.0
	var sample_fps := 30.0
	var sample_count := maxi(1, ceili(animation.length * sample_fps))
	var target_tracks: Array[int] = []
	var target_bones: Array[int] = []
	for target_bone in target_skeleton.get_bone_count():
		var bone_name := target_skeleton.get_bone_name(target_bone)
		var track := retargeted.add_track(Animation.TYPE_ROTATION_3D)
		retargeted.track_set_path(
			track,
			NodePath(track_root_path + ":" + bone_name)
		)
		retargeted.track_set_interpolation_type(
			track,
			Animation.INTERPOLATION_LINEAR
		)
		retargeted.track_set_interpolation_loop_wrap(track, true)
		target_tracks.append(track)
		target_bones.append(target_bone)
	for sample_index in sample_count + 1:
		var sample_time := minf(
			animation.length,
			float(sample_index) / sample_fps
		)
		var source_global: Array[Quaternion] = []
		source_global.resize(source_skeleton.get_bone_count())
		for source_bone in source_skeleton.get_bone_count():
			var bone_name := source_skeleton.get_bone_name(source_bone)
			var local_rotation := source_rest_local[source_bone]
			if source_rotation_tracks.has(bone_name):
				local_rotation = animation.rotation_track_interpolate(
					int(source_rotation_tracks[bone_name]),
					sample_time
				).normalized()
			var source_parent := source_skeleton.get_bone_parent(source_bone)
			var parent_global := (
				source_global[source_parent]
				if source_parent >= 0
				else Quaternion.IDENTITY
			)
			source_global[source_bone] = (
				parent_global * local_rotation
			).normalized()
		var target_global: Array[Quaternion] = []
		target_global.resize(target_skeleton.get_bone_count())
		for target_index in target_bones.size():
			var target_bone := target_bones[target_index]
			var track := target_tracks[target_index]
			var bone_name := target_skeleton.get_bone_name(target_bone)
			var source_bone := source_skeleton.find_bone(bone_name)
			var target_parent := target_skeleton.get_bone_parent(target_bone)
			var parent_global := (
				target_global[target_parent]
				if target_parent >= 0
				else Quaternion.IDENTITY
			)
			var local_rotation := target_rest_local[target_bone]
			if source_bone >= 0 and not bone_name.contains("ShareBone"):
				var source_delta := (
					source_global[source_bone]
					* source_rest_global[source_bone].inverse()
				).normalized()
				var desired_global := (
					source_delta * target_rest_global[target_bone]
				).normalized()
				local_rotation = (
					parent_global.inverse() * desired_global
				).normalized()
				if local_rotation.dot(target_rest_local[target_bone]) < 0.0:
					local_rotation = -local_rotation
			target_global[target_bone] = (
				parent_global * local_rotation
			).normalized()
			retargeted.track_insert_key(
				track,
				sample_time,
				local_rotation
			)
	source_root.free()
	return retargeted


func _make_walk_animation_in_place(
	root: Node3D,
	animation: Animation
) -> void:
	var skeleton := _find_rig_skeleton(root)
	if skeleton == null:
		return
	for track_index in animation.get_track_count():
		if animation.track_get_type(track_index) != Animation.TYPE_POSITION_3D:
			continue
		var track_path := String(animation.track_get_path(track_index))
		var bone_name := track_path.get_slice(":", track_path.get_slice_count(":") - 1)
		if bone_name not in ["BoneRoot", "Hip"]:
			continue
		var bone_index := skeleton.find_bone(bone_name)
		if bone_index < 0:
			continue
		var rest_position := skeleton.get_bone_rest(bone_index).origin
		for key_index in animation.track_get_key_count(track_index):
			animation.track_set_key_value(
				track_index,
				key_index,
				rest_position
			)


func _play_character_animation(
	root: Node3D,
	clip_names: Array[String],
	should_loop := true,
	blend_time := 0.2
) -> bool:
	var player := _find_rig_animation_player(root)
	if player == null:
		return false
	if bool(root.get_meta("fox_idle_cycle_enabled", false)) and not clip_names.is_empty():
		var requested_clip := clip_names[0]
		if requested_clip in FOX_IDLE_CYCLE_CLIPS:
			return _start_fox_idle_cycle(root, requested_clip)
		_stop_fox_idle_cycle(root)
	for clip_name in clip_names:
		if not player.has_animation(clip_name):
			continue
		var animation := player.get_animation(clip_name)
		animation.loop_mode = (
			Animation.LOOP_LINEAR
			if should_loop
			else Animation.LOOP_NONE
		)
		if player.current_animation != clip_name or not player.is_playing():
			player.play(clip_name, blend_time)
		return true
	return false


func _build_subtle_idle_animation(
	root: Node3D,
	source_name: String,
	target_name: String,
	amplitude := 0.32,
	head_tilt_up_degrees := 0.0
) -> void:
	var player := _find_rig_animation_player(root)
	if player == null or not player.has_animation(source_name):
		return
	if player.has_animation(target_name):
		return
	var animation := player.get_animation(source_name).duplicate(true) as Animation
	for track_index in animation.get_track_count():
		var track_type := animation.track_get_type(track_index)
		var key_count := animation.track_get_key_count(track_index)
		if key_count == 0:
			continue
		var track_path := String(animation.track_get_path(track_index))
		var head_tilt_weight := 0.0
		if track_type == Animation.TYPE_ROTATION_3D:
			if track_path.ends_with(":Head"):
				head_tilt_weight = 0.65
			elif track_path.ends_with(":NeckTwist01"):
				head_tilt_weight = 0.35
		# The source clip's first pose is the natural character stance. Blending
		# toward the bind pose would pull the arms back into the T-pose.
		var neutral_value = animation.track_get_key_value(track_index, 0)
		for key_index in animation.track_get_key_count(track_index):
			match track_type:
				Animation.TYPE_ROTATION_3D:
					var source_rotation := animation.track_get_key_value(
						track_index,
						key_index
					) as Quaternion
					var adjusted_rotation := (
						neutral_value as Quaternion
					).slerp(source_rotation, amplitude)
					if (
						head_tilt_weight > 0.0
						and not is_zero_approx(head_tilt_up_degrees)
					):
						var track_tilt := Quaternion(
							Vector3.BACK,
							deg_to_rad(
								head_tilt_up_degrees * head_tilt_weight
							)
						)
						adjusted_rotation = track_tilt * adjusted_rotation
					animation.track_set_key_value(
						track_index,
						key_index,
						adjusted_rotation
					)
				Animation.TYPE_POSITION_3D:
					var source_position := animation.track_get_key_value(
						track_index,
						key_index
					) as Vector3
					animation.track_set_key_value(
						track_index,
						key_index,
						(neutral_value as Vector3).lerp(
							source_position,
							amplitude
						)
					)
				Animation.TYPE_SCALE_3D:
					var source_scale := animation.track_get_key_value(
						track_index,
						key_index
					) as Vector3
					animation.track_set_key_value(
						track_index,
						key_index,
						(neutral_value as Vector3).lerp(
							source_scale,
							amplitude
						)
					)
	animation.loop_mode = Animation.LOOP_LINEAR
	var library := player.get_animation_library("")
	if library == null:
		library = AnimationLibrary.new()
		player.add_animation_library("", library)
	library.add_animation(target_name, animation)


func _apply_character_animation_choice(
	root: Node3D,
	clip_name: String,
	should_loop := true
) -> bool:
	if root == null:
		return false
	var player := _find_rig_animation_player(root)
	if player == null:
		return false
	if bool(root.get_meta("player_person_animation", false)):
		if clip_name in ["ambient_idle", "look_around"]:
			clip_name = "gentle_look_around"
		if clip_name == "gentle_look_around":
			player.speed_scale = 0.5
			return _play_character_animation(
				root,
				["gentle_look_around"],
				true,
				0.55
			)
		if clip_name == "sit":
			player.speed_scale = 1.0
			return _play_character_animation(
				root,
				["sit"],
				false,
				0.30
			)
	if clip_name == "ambient_idle" and player.has_animation("subtle_idle_001"):
		player.speed_scale = 0.5
		prince_ambient_idle_states[root.get_instance_id()] = {
			"phase": "subtle",
			"elapsed": 0.0,
		}
		return _play_character_animation(
			root,
			["subtle_idle_001"],
			true,
			0.55
		)
	if clip_name == "ambient_idle":
		return _play_character_animation(
			root,
			["look_around_001"],
			true,
			0.4
		)
	prince_ambient_idle_states.erase(root.get_instance_id())
	player.speed_scale = 1.0
	return _play_character_animation(
		root,
		[clip_name],
		should_loop,
		0.22
	)


func _update_prince_ambient_idle(delta: float) -> void:
	if (
		stage_3d == null
		or not stage_3d.visible
		or editor_active
	):
		return
	for record in editable_3d_objects:
		if String(record.get("kind", "")) not in PRINCE_CHARACTER_KINDS:
			continue
		if String(record.get("selected_animation", "")) != "ambient_idle":
			continue
		var root := record.get("node") as Node3D
		if (
			root == null
			or not root.is_visible_in_tree()
			or bool(root.get_meta("player_navigation_walking", false))
		):
			continue
		var player := _find_rig_animation_player(root)
		if (
			String(record.get("seat_state", "")) == "seated"
			or (
				player != null
				and player.current_animation == "sit_001"
				and player.is_playing()
			)
		):
			continue
		var key := root.get_instance_id()
		if not prince_ambient_idle_states.has(key):
			prince_ambient_idle_states[key] = {
				"phase": "subtle",
				"elapsed": 0.0,
			}
		var state: Dictionary = prince_ambient_idle_states[key]
		if player == null or not player.has_animation("subtle_idle_001"):
			continue
		state["elapsed"] = float(state.get("elapsed", 0.0)) + delta
		if String(state.get("phase", "subtle")) == "subtle":
			if player.current_animation != "subtle_idle_001":
				player.speed_scale = 0.5
				_play_character_animation(
					root,
					["subtle_idle_001"],
					true,
					0.55
				)
			if float(state.elapsed) >= 32.0:
				state["phase"] = "look"
				state["elapsed"] = 0.0
				player.speed_scale = 0.5
				_play_character_animation(
					root,
					["look_around_001"],
					false,
					0.7
				)
		else:
			if float(state.elapsed) >= 4.2:
				state["phase"] = "subtle"
				state["elapsed"] = 0.0
				player.speed_scale = 0.5
				_play_character_animation(
					root,
					["subtle_idle_001"],
					true,
					0.8
				)


func _update_king_sitting_animation(delta: float) -> void:
	if (
		stage_3d == null
		or not stage_3d.visible
		or current_3d_scene != "king"
	):
		return
	for record in editable_3d_objects:
		if String(record.get("kind", "")) != "king_character":
			continue
		var root := record.get("node") as Node3D
		if root == null or not root.is_visible_in_tree():
			continue
		var player := _find_rig_animation_player(root)
		if player == null:
			continue
		var key := root.get_instance_id()
		if (
			player.current_animation != "sit_001"
			or not player.is_playing()
		):
			if king_sit_hold_states.has(key):
				player.speed_scale = 1.0
				king_sit_hold_states.erase(key)
			continue
		if not king_sit_hold_states.has(key):
			king_sit_hold_states[key] = {
				"holding": false,
				"hold_elapsed": 0.0,
				"last_position": player.current_animation_position,
				"completed_this_loop": false,
			}
		var state: Dictionary = king_sit_hold_states[key]
		var position := player.current_animation_position
		var last_position := float(state.get("last_position", position))
		if position + 0.1 < last_position:
			state["completed_this_loop"] = false
		if bool(state.get("holding", false)):
			state["hold_elapsed"] = (
				float(state.get("hold_elapsed", 0.0)) + delta
			)
			if (
				float(state.hold_elapsed)
				>= KING_SIT_HOLD_DURATION
			):
				state["holding"] = false
				state["completed_this_loop"] = true
				player.speed_scale = 1.0
			else:
				player.speed_scale = 0.0
				player.seek(KING_SIT_HOLD_POSITION, true)
		elif (
			not bool(state.get("completed_this_loop", false))
			and last_position < KING_SIT_HOLD_POSITION
			and position >= KING_SIT_HOLD_POSITION
		):
			state["holding"] = true
			state["hold_elapsed"] = 0.0
			player.speed_scale = 0.0
			player.seek(KING_SIT_HOLD_POSITION, true)
		state["last_position"] = player.current_animation_position
		king_sit_hold_states[key] = state


func _prepare_prince_character_animations(
	root: Node3D,
	default_clip := "ambient_idle"
) -> void:
	if root == null:
		return
	_install_rigged_animation(
		root,
		PRINCE_WALK_ANIMATION_3D,
		"walk_001"
	)
	_install_rigged_animation(
		root,
		PRINCE_SIT_ANIMATION_3D,
		"sit_001"
	)
	_install_rigged_animation(
		root,
		PRINCE_REACTIONS_ANIMATION_3D,
		"look_around_001"
	)
	_install_rigged_animation(
		root,
		PRINCE_REACTIONS_ANIMATION_3D,
		"afraid_001"
	)
	_install_rigged_animation(
		root,
		STANDING_PRINCE_3D,
		"clap_001"
	)
	_build_subtle_idle_animation(
		root,
		"look_around_001",
		"subtle_idle_001",
		0.3
	)
	_set_character_animation_default(root, default_clip)


func _prepare_player_person_animations(
	root: Node3D,
	kind: String
) -> void:
	if root == null or kind not in PLAYER_PERSON_KINDS:
		return
	var player := _find_rig_animation_player(root)
	if player == null:
		return
	root.set_meta("player_person_animation", true)
	# The two player rigs use the same bone names as the Prince but have
	# different local rest orientations. Rotate each source bone delta into the
	# destination rest frame before applying the shared walk clip.
	_install_rigged_animation(
		root,
		PRINCE_WALK_ANIMATION_3D,
		"walk_001"
	)
	if (
		player.has_animation("look_around")
		and not player.has_animation("gentle_look_around")
	):
		_build_subtle_idle_animation(
			root,
			"look_around",
			"gentle_look_around",
			0.3,
			0.0
		)
	if player.has_animation("gentle_look_around"):
		_set_character_animation_default(root, "gentle_look_around")


func _set_prince_idle_head_tilt(
	root: Node3D,
	head_tilt_up_degrees: float
) -> void:
	root.set_meta("head_tilt_degrees", head_tilt_up_degrees)
	var player := _find_rig_animation_player(root)
	if player == null or not player.has_animation("look_around_001"):
		return
	var library := player.get_animation_library("")
	if library != null and library.has_animation("subtle_idle_001"):
		library.remove_animation("subtle_idle_001")
	_build_subtle_idle_animation(
		root,
		"look_around_001",
		"subtle_idle_001",
		0.3,
		head_tilt_up_degrees
	)
	_play_character_animation(
		root,
		["subtle_idle_001"],
		true,
		0.0
	)


func _prepare_king_character_animations(root: Node3D) -> void:
	if root == null:
		return
	_set_character_animation_default(root, "sit_001")


func _set_character_animation_default(
	root: Node3D,
	clip_name: String,
	autoplay := true
) -> void:
	if root == null:
		return
	root.set_meta("preferred_character_animation", clip_name)
	for record in editable_3d_objects:
		if record.get("node") == root:
			record["selected_animation"] = clip_name
			record["initial_selected_animation"] = clip_name
			break
	if autoplay:
		_apply_character_animation_choice(root, clip_name, true)


func _play_lamplighter_reaction(clip_name: String) -> void:
	if lamplighter_3d == null:
		return
	var player := _find_rig_animation_player(lamplighter_3d)
	if player == null or not player.has_animation(clip_name):
		return
	if not _play_character_animation(lamplighter_3d, [clip_name], false, 0.22):
		return
	await player.animation_finished
	if is_instance_valid(lamplighter_3d):
		_play_character_animation(lamplighter_3d, ["idle_001"], true, 0.28)


func _place_layout_asset(
	kind: String,
	label: String,
	path: String,
	normal: Vector3,
	base_scale: float,
	upright: bool,
	root_radius: float,
	yaw_degrees := 0.0,
	default_hidden := false
) -> Node3D:
	var rigged_override := _rigged_character_asset_for_kind(kind)
	if not rigged_override.is_empty():
		path = rigged_override
	var surface_normal := normal.normalized()
	var surface_point := surface_normal * root_radius
	var basis: Basis
	if upright:
		basis = Basis(Vector3.UP, deg_to_rad(yaw_degrees)) \
			* _upright_surface_basis(surface_normal, surface_point)
	else:
		basis = _normal_surface_basis(surface_normal, yaw_degrees)
	var wrapper := _add_generated_part(
		model_3d,
		path,
		"Layout_" + kind + "_" + str(editable_serial + 1),
		Transform3D(basis, surface_point),
		base_scale
	)
	if wrapper == null:
		return null
	wrapper.visible = not default_hidden
	if kind == "house":
		var house_light := _add_warm_glow(wrapper, Vector3(0.0, 0.7, 0.34), 1.35, 5.2, 0.34)
		_attach_editor_light_anchor(wrapper, house_light)
	elif kind == "main_lamp":
		var main_light := _add_warm_glow(wrapper, Vector3(0.0, 1.56, 0.32), 5.6, 11.0, 0.90)
		_attach_editor_light_anchor(wrapper, main_light)
	elif kind == "side_lamp":
		var side_light := _add_warm_glow(wrapper, Vector3(0.0, 0.82, 0.17), 0.90, 4.2, 0.28)
		_attach_editor_light_anchor(wrapper, side_light)
	elif kind in ["square_lamp", "star_lamp"]:
		var lamp_extent := maxf(0.24, base_scale * 1.2)
		var is_star_lamp := kind == "star_lamp"
		var accent_light := _add_warm_glow(
			wrapper,
			Vector3(0.0, lamp_extent * 0.60, 0.0),
			1.15,
			3.4,
			0.68 if is_star_lamp else 0.55
		)
		_attach_editor_light_anchor(wrapper, accent_light)
	elif kind == "star_clasp":
		var clasp_extent := maxf(0.24, base_scale * 1.16)
		var clasp_light := _add_warm_glow(
			wrapper,
			Vector3(0.0, clasp_extent * 0.55, 0.0),
			0.70,
			2.20,
			0.38
		)
		_attach_editor_light_anchor(wrapper, clasp_light)
	elif kind == "lamplighter":
		_add_character_fill(wrapper)
		_lift_character_materials(wrapper)
	_register_editable_3d(
		wrapper,
		kind,
		label,
		surface_normal,
		root_radius,
		upright,
		yaw_degrees,
		base_scale,
		path,
		default_hidden
	)
	return wrapper


func _soften_model_materials(root: Node) -> void:
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.has_meta("player_light_footprint"):
			continue
		if mesh_instance.mesh == null or mesh_instance.material_override is ShaderMaterial:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var source := mesh_instance.get_active_material(surface)
			if source is not StandardMaterial3D:
				continue
			var material := (source as StandardMaterial3D).duplicate() as StandardMaterial3D
			material.roughness = maxf(material.roughness, 0.84)
			material.metallic = minf(material.metallic, 0.08)
			if not material.emission_enabled:
				var base_tint := material.albedo_color
				if base_tint.r + base_tint.g + base_tint.b < 0.12:
					base_tint = Color(0.42, 0.50, 0.66)
				if material.albedo_texture != null:
					material.emission_texture = material.albedo_texture
				material.emission_enabled = true
				material.emission = base_tint.lerp(Color(1.0, 0.90, 0.72), 0.10)
				material.emission_energy_multiplier = 0.06
			mesh_instance.set_surface_override_material(surface, material)


func _soften_player_light_terminator(root: Node) -> void:
	if root == null:
		return
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if (
			mesh_instance == null
			or mesh_instance.mesh == null
			or mesh_instance.has_meta("player_light_footprint")
		):
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var source := mesh_instance.get_active_material(surface)
			if source is not StandardMaterial3D:
				continue
			var material := source as StandardMaterial3D
			if not material.has_meta("player_lambert_wrap"):
				material = material.duplicate() as StandardMaterial3D
				material.set_meta("player_lambert_wrap", true)
				mesh_instance.set_surface_override_material(surface, material)
			material.diffuse_mode = BaseMaterial3D.DIFFUSE_LAMBERT_WRAP


func _ensure_mesh_lighting_data(root: Node) -> void:
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null or mesh_instance.skin != null:
			continue
		var original_mesh := mesh_instance.mesh
		var needs_rebuild := false
		for surface in original_mesh.get_surface_count():
			if (original_mesh.surface_get_format(surface) & Mesh.ARRAY_FORMAT_NORMAL) == 0:
				needs_rebuild = true
				break
		if not needs_rebuild:
			continue
		var rebuilt := ArrayMesh.new()
		var rebuilt_any := false
		var materials: Array[Material] = []
		for surface in original_mesh.get_surface_count():
			var arrays := original_mesh.surface_get_arrays(surface)
			var vertex_value = arrays[Mesh.ARRAY_VERTEX]
			var index_value = arrays[Mesh.ARRAY_INDEX]
			var normal_value = arrays[Mesh.ARRAY_NORMAL]
			var tangent_value = arrays[Mesh.ARRAY_TANGENT]
			var uv_value = arrays[Mesh.ARRAY_TEX_UV]
			var vertices := (
				vertex_value as PackedVector3Array
				if vertex_value is PackedVector3Array
				else PackedVector3Array()
			)
			var indices := (
				index_value as PackedInt32Array
				if index_value is PackedInt32Array
				else PackedInt32Array()
			)
			var normals := (
				normal_value as PackedVector3Array
				if normal_value is PackedVector3Array
				else PackedVector3Array()
			)
			var tangents := (
				tangent_value as PackedFloat32Array
				if tangent_value is PackedFloat32Array
				else PackedFloat32Array()
			)
			var needs_normals := vertices.size() > 0 and normals.size() != vertices.size()
			if needs_normals:
				arrays[Mesh.ARRAY_NORMAL] = _generate_vertex_normals(vertices, indices)
				normals = arrays[Mesh.ARRAY_NORMAL]
				rebuilt_any = true
			var uv := (
				uv_value as PackedVector2Array
				if uv_value is PackedVector2Array
				else PackedVector2Array()
			)
			if needs_normals and tangents.size() != vertices.size() * 4 and uv.size() == vertices.size():
				arrays[Mesh.ARRAY_TANGENT] = _generate_vertex_tangents(
					vertices,
					indices,
					normals,
					uv
				)
				rebuilt_any = true
			rebuilt.add_surface_from_arrays(
				original_mesh.surface_get_primitive_type(surface),
				arrays
			)
			materials.append(mesh_instance.get_active_material(surface))
		if not rebuilt_any:
			continue
		for surface in materials.size():
			if materials[surface] != null:
				rebuilt.surface_set_material(surface, materials[surface])
		mesh_instance.mesh = rebuilt


func _generate_vertex_normals(
	vertices: PackedVector3Array,
	indices: PackedInt32Array
) -> PackedVector3Array:
	var accumulated := PackedVector3Array()
	accumulated.resize(vertices.size())
	var triangle_count := indices.size() / 3 if not indices.is_empty() else vertices.size() / 3
	for triangle in triangle_count:
		var index_a := indices[triangle * 3] if not indices.is_empty() else triangle * 3
		var index_b := indices[triangle * 3 + 1] if not indices.is_empty() else triangle * 3 + 1
		var index_c := indices[triangle * 3 + 2] if not indices.is_empty() else triangle * 3 + 2
		var face_normal := (
			vertices[index_b] - vertices[index_a]
		).cross(vertices[index_c] - vertices[index_a])
		accumulated[index_a] += face_normal
		accumulated[index_b] += face_normal
		accumulated[index_c] += face_normal
	var center := Vector3.ZERO
	for vertex in vertices:
		center += vertex
	if not vertices.is_empty():
		center /= float(vertices.size())
	var outward_score := 0.0
	for index in accumulated.size():
		if accumulated[index].length_squared() < 0.0000001:
			continue
		outward_score += accumulated[index].normalized().dot(vertices[index] - center)
	var flip := outward_score < 0.0
	for index in accumulated.size():
		if accumulated[index].length_squared() < 0.0000001:
			accumulated[index] = Vector3.UP
		else:
			accumulated[index] = accumulated[index].normalized() * (-1.0 if flip else 1.0)
	return accumulated


func _generate_vertex_tangents(
	vertices: PackedVector3Array,
	indices: PackedInt32Array,
	normals: PackedVector3Array,
	uv: PackedVector2Array
) -> PackedFloat32Array:
	var accumulated := PackedVector3Array()
	accumulated.resize(vertices.size())
	var triangle_count := indices.size() / 3 if not indices.is_empty() else vertices.size() / 3
	for triangle in triangle_count:
		var index_a := indices[triangle * 3] if not indices.is_empty() else triangle * 3
		var index_b := indices[triangle * 3 + 1] if not indices.is_empty() else triangle * 3 + 1
		var index_c := indices[triangle * 3 + 2] if not indices.is_empty() else triangle * 3 + 2
		var edge_a := vertices[index_b] - vertices[index_a]
		var edge_b := vertices[index_c] - vertices[index_a]
		var uv_a := uv[index_b] - uv[index_a]
		var uv_b := uv[index_c] - uv[index_a]
		var determinant := uv_a.x * uv_b.y - uv_b.x * uv_a.y
		if absf(determinant) < 0.000001:
			continue
		var tangent := (edge_a * uv_b.y - edge_b * uv_a.y) / determinant
		accumulated[index_a] += tangent
		accumulated[index_b] += tangent
		accumulated[index_c] += tangent
	var result := PackedFloat32Array()
	result.resize(vertices.size() * 4)
	for index in vertices.size():
		var normal := normals[index]
		var tangent := accumulated[index] - normal * accumulated[index].dot(normal)
		if tangent.length_squared() < 0.0000001:
			tangent = normal.cross(Vector3.UP)
		if tangent.length_squared() < 0.0000001:
			tangent = normal.cross(Vector3.RIGHT)
		tangent = tangent.normalized()
		result[index * 4] = tangent.x
		result[index * 4 + 1] = tangent.y
		result[index * 4 + 2] = tangent.z
		result[index * 4 + 3] = 1.0
	return result


func _apply_king_cloth_wind(root: Node, kind: String) -> void:
	var shader := load(KING_CLOTH_WIND_SHADER) as Shader
	if shader == null:
		push_warning("King cloth wind shader failed to load.")
		return
	var base_strength := 0.032
	var base_speed := 0.64
	var base_phase := 0.35
	if kind == "king_banners":
		base_strength = 0.038
		base_speed = 0.72
		base_phase = 1.35
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var bounds := mesh_instance.mesh.get_aabb()
		for surface in mesh_instance.mesh.get_surface_count():
			var source := mesh_instance.get_active_material(surface) as StandardMaterial3D
			if source == null:
				continue
			var material := ShaderMaterial.new()
			material.shader = shader
			material.set_shader_parameter("albedo_texture", source.albedo_texture)
			material.set_shader_parameter("normal_texture", source.normal_texture)
			material.set_shader_parameter(
				"metallic_roughness_texture",
				source.roughness_texture
			)
			material.set_shader_parameter("albedo_tint", source.albedo_color)
			material.set_shader_parameter("metallic_strength", minf(source.metallic, 0.08))
			material.set_shader_parameter("local_z_bottom", bounds.end.z)
			material.set_shader_parameter("local_z_top", bounds.position.z)
			material.set_shader_parameter("wind_strength", base_strength)
			material.set_shader_parameter("wind_phase", base_phase)
			material.set_shader_parameter("wind_speed", base_speed)
			mesh_instance.set_surface_override_material(surface, material)


func _build_king_celestial() -> void:
	king_celestial_root = Node3D.new()
	king_celestial_root.name = "KingCelestialBodies"
	king_celestial_root.visible = false
	king_celestial_root.position.y = KING_CELESTIAL_CENTER_Y
	king_celestial_root.basis = _king_celestial_basis(PI)
	king_celestial_rotation = PI
	king_celestial_target_rotation = PI
	stage_3d.add_child(king_celestial_root)
	var orbit := TorusMesh.new()
	orbit.inner_radius = 1.51
	orbit.outer_radius = 1.525
	orbit.rings = 96
	orbit.ring_segments = 4
	king_celestial_orbit_material = StandardMaterial3D.new()
	king_celestial_orbit_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	king_celestial_orbit_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	king_celestial_orbit_material.albedo_color = Color(0.55, 0.67, 0.92, 0.08)
	king_celestial_orbit_material.emission_enabled = true
	king_celestial_orbit_material.emission = Color(0.42, 0.58, 0.92)
	king_celestial_orbit_material.emission_energy_multiplier = 0.34
	orbit.material = king_celestial_orbit_material
	var orbit_instance := MeshInstance3D.new()
	orbit_instance.name = "CelestialOrbit"
	orbit_instance.mesh = orbit
	orbit_instance.position = Vector3(0.0, 0.0, -1.60)
	orbit_instance.rotation.x = deg_to_rad(90.0)
	orbit_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	king_celestial_root.add_child(orbit_instance)
	var sun := _add_king_celestial_body(
		king_celestial_root,
		"Sun",
		Vector3(0.0, 1.52, -1.60),
		0.32,
		Color(1.0, 0.72, 0.28, 1.0),
		Color(1.0, 0.42, 0.07, 0.38),
		2.35
	)
	king_sun_root = sun.root as Node3D
	king_sun_material = sun.material as ShaderMaterial
	king_sun_glow = sun.glow as Sprite3D
	var moon := _add_king_celestial_body(
		king_celestial_root,
		"Moon",
		Vector3(0.0, -1.52, -1.60),
		0.29,
		Color(0.68, 0.76, 1.0, 0.92),
		Color(0.36, 0.58, 1.0, 0.34),
		1.18
	)
	king_moon_root = moon.root as Node3D
	king_moon_material = moon.material as ShaderMaterial
	king_moon_glow = moon.glow as Sprite3D


func _add_king_celestial_body(
	parent: Node3D,
	body_name: String,
	body_position: Vector3,
	radius: float,
	color: Color,
	glow_color: Color,
	glow_scale: float
) -> Dictionary:
	var root := Node3D.new()
	root.name = body_name
	root.position = body_position
	parent.add_child(root)
	var sphere := SphereMesh.new()
	sphere.radius = radius
	sphere.height = radius * 2.0
	sphere.radial_segments = 48
	sphere.rings = 24
	var material := ShaderMaterial.new()
	material.shader = load(
		"res://shaders/king_sun.gdshader"
		if body_name == "Sun"
		else "res://shaders/king_moon.gdshader"
	)
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = body_name + "Disc"
	mesh_instance.mesh = sphere
	mesh_instance.material_override = material
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	root.add_child(mesh_instance)
	var glow := Sprite3D.new()
	glow.name = body_name + "Glow"
	glow.texture = _make_radial_texture(
		glow_color,
		Color(glow_color.r, glow_color.g, glow_color.b, 0.0)
	)
	glow.pixel_size = 0.01
	glow.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	glow.shaded = false
	glow.modulate = glow_color
	glow.scale = Vector3.ONE * glow_scale
	glow.render_priority = -2
	glow.no_depth_test = body_name != "Moon"
	glow.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	root.add_child(glow)
	return {"root": root, "material": material, "glow": glow}


func _update_king_celestial(delta: float) -> void:
	if current_3d_scene != "king" or king_celestial_root == null:
		return
	king_celestial_time += delta
	king_day_night_blend = move_toward(
		king_day_night_blend,
		king_day_night_target,
		delta / 1.35
	)
	var day_amount := smoothstep(0.0, 1.0, king_day_night_blend)
	_apply_king_day_night(day_amount)
	king_celestial_rotation = move_toward(
		king_celestial_rotation,
		king_celestial_target_rotation,
		delta * PI / 1.9
	)
	king_celestial_root.basis = _king_celestial_basis(king_celestial_rotation)
	if king_sun_root != null:
		king_sun_root.rotation.y = king_celestial_time * 0.16
	if king_moon_root != null:
		king_moon_root.rotation.y = king_celestial_time * 0.11


func _apply_king_day_night(day_amount: float) -> void:
	if stage_environment == null:
		return
	var day := clampf(day_amount, 0.0, 1.0)
	stage_environment.background_color = Color(0.035, 0.022, 0.061).lerp(
		Color(0.09, 0.17, 0.31),
		day
	)
	stage_environment.ambient_light_color = Color(0.54, 0.46, 0.66).lerp(
		Color(0.78, 0.77, 0.72),
		day
	)
	stage_environment.ambient_light_energy = lerpf(0.66, 0.68, day)
	stage_environment.tonemap_exposure = lerpf(0.76, 0.79, day)
	stage_environment.fog_light_color = Color(0.12, 0.065, 0.14).lerp(
		Color(0.38, 0.48, 0.65),
		day
	)
	stage_environment.fog_density = lerpf(0.013, 0.007, day)
	stage_environment.adjustment_brightness = lerpf(0.89, 0.91, day)
	stage_environment.adjustment_contrast = lerpf(0.99, 1.01, day)
	stage_environment.adjustment_saturation = lerpf(0.84, 0.90, day)
	if king_cutout_bright_background:
		stage_environment.background_color = Color(0.20, 0.26, 0.38)
		stage_environment.background_energy_multiplier = 1.25
		stage_environment.fog_light_color = Color(0.30, 0.37, 0.50)
		stage_environment.fog_density = 0.003
	if stage_key_light != null:
		stage_key_light.light_color = Color(0.96, 0.79, 0.66).lerp(
			Color(1.0, 0.91, 0.72),
			day
		)
		stage_key_light.light_energy = lerpf(0.58, 0.64, day)
	if stage_rim_light != null:
		stage_rim_light.light_color = Color(0.46, 0.34, 0.82).lerp(
			Color(0.98, 0.72, 0.38),
			day
		)
		stage_rim_light.light_energy = lerpf(0.43, 0.50, day)
	if stage_cool_fill != null:
		stage_cool_fill.light_energy = lerpf(0.20, 0.22, day)
	if warm_fill_light != null:
		warm_fill_light.light_color = Color(1.0, 0.61, 0.29).lerp(
			Color(1.0, 0.78, 0.46),
			day
		)
		warm_fill_light.light_energy = lerpf(0.32, 0.38, day)
	if stage_front_fill != null:
		stage_front_fill.light_energy = lerpf(0.23, 0.28, day)
	if king_sun_material != null:
		king_sun_material.set_shader_parameter("sun_energy", lerpf(0.62, 1.30, day))
		king_sun_material.set_shader_parameter("sun_visibility", lerpf(0.82, 1.0, day))
	if king_moon_material != null:
		king_moon_material.set_shader_parameter("moon_glow", lerpf(0.38, 0.05, day))
		king_moon_material.set_shader_parameter("moon_visibility", lerpf(1.0, 0.08, day))
	if king_sun_glow != null:
		var sun_glow_color := king_sun_glow.modulate
		sun_glow_color.a = lerpf(0.26, 0.42, day)
		king_sun_glow.modulate = sun_glow_color
	if king_moon_glow != null:
		var moon_glow_color := king_moon_glow.modulate
		moon_glow_color.a = lerpf(0.56, 0.04, day)
		king_moon_glow.modulate = moon_glow_color
	if king_celestial_orbit_material != null:
		var orbit_color := king_celestial_orbit_material.albedo_color
		orbit_color.a = lerpf(0.07, 0.13, day)
		king_celestial_orbit_material.albedo_color = orbit_color
	_apply_planet_base_lighting_multiplier()


func _toggle_king_day_night() -> void:
	if current_3d_scene != "king":
		return
	var daytime := king_day_night_target < 0.5
	_set_king_day_night_phase(daytime)
	if hud_scene_hint != null:
		hud_scene_hint.text = ""


func _set_king_day_night_phase(daytime: bool) -> void:
	if current_3d_scene != "king":
		return
	var next_target := 1.0 if daytime else 0.0
	if not is_equal_approx(king_day_night_target, next_target):
		# Advance by half a turn on every day/night change so the celestial
		# bodies continue in the same direction instead of rewinding.
		king_celestial_target_rotation = maxf(
			king_celestial_target_rotation,
			king_celestial_rotation
		) + PI
	king_day_night_target = next_target


func _king_celestial_basis(spin: float) -> Basis:
	return (
		Basis(Vector3.RIGHT, deg_to_rad(KING_CELESTIAL_TILT_DEGREES))
		* Basis(Vector3.BACK, spin)
	)


func _is_king_celestial_at_screen(screen_position: Vector2) -> bool:
	if (
		current_3d_scene != "king"
		or editor_active
		or king_celestial_root == null
		or not king_celestial_root.visible
		or camera_3d == null
	):
		return false
	if king_sun_root != null:
		var sun_screen := camera_3d.unproject_position(king_sun_root.global_position)
		if sun_screen.distance_to(screen_position) <= 76.0:
			return true
	if king_moon_root != null:
		var moon_screen := camera_3d.unproject_position(king_moon_root.global_position)
		if moon_screen.distance_to(screen_position) <= 58.0:
			return true
	return false


func _is_king_sun_at_screen(screen_position: Vector2) -> bool:
	if (
		current_3d_scene != "king"
		or editor_active
		or king_celestial_root == null
		or not king_celestial_root.visible
		or king_sun_root == null
		or camera_3d == null
	):
		return false
	var sun_screen := camera_3d.unproject_position(king_sun_root.global_position)
	return (
		not camera_3d.is_position_behind(king_sun_root.global_position)
		and sun_screen.distance_to(screen_position) <= 76.0
	)


func _keep_first_complete_mesh(root: Node3D) -> void:
	if root == null:
		return
	if not root.find_children("*", "Skeleton3D", true, false).is_empty():
		return
	var meshes := root.find_children("*", "MeshInstance3D", true, false)
	var kept := false
	for item in meshes:
		var mesh_instance := item as MeshInstance3D
		if not kept and mesh_instance.mesh != null and mesh_instance.mesh.get_surface_count() > 0:
			kept = true
			_trim_standing_prince_mesh(mesh_instance)
			continue
		mesh_instance.queue_free()
	if not kept:
		root.visible = false
		return
	var model_root := root.get_child(0) as Node3D
	if model_root != null:
		var bounds := _node_local_bounds(model_root)
		model_root.position.x -= bounds.get_center().x
		model_root.position.z -= bounds.get_center().z


func _trim_standing_prince_mesh(mesh_instance: MeshInstance3D) -> void:
	# The source GLB contains three complete prince variants merged into one
	# primitive. Keep only the first (leftmost) connected model by filtering the
	# triangle clusters before rebuilding the mesh.
	var arrays := mesh_instance.mesh.surface_get_arrays(0)
	var source_vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
	var source_indices: PackedInt32Array = arrays[Mesh.ARRAY_INDEX]
	if source_indices.is_empty():
		return
	var retained_indices := PackedInt32Array()
	for triangle in range(0, source_indices.size() - 2, 3):
		var a := source_indices[triangle]
		var b := source_indices[triangle + 1]
		var c := source_indices[triangle + 2]
		var center_x := (
			source_vertices[a].x + source_vertices[b].x + source_vertices[c].x
		) / 3.0
		if center_x < -0.17:
			retained_indices.append(a)
			retained_indices.append(b)
			retained_indices.append(c)
	if retained_indices.is_empty():
		return
	var remap: Dictionary = {}
	var rebuilt_indices := PackedInt32Array()
	rebuilt_indices.resize(retained_indices.size())
	for index in retained_indices.size():
		var source_index := retained_indices[index]
		if not remap.has(source_index):
			remap[source_index] = remap.size()
		rebuilt_indices[index] = int(remap[source_index])

	var rebuilt_arrays: Array = []
	rebuilt_arrays.resize(Mesh.ARRAY_MAX)
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var tangents := PackedFloat32Array()
	var colors := PackedColorArray()
	var uv := PackedVector2Array()
	var uv2 := PackedVector2Array()
	var source_normals = arrays[Mesh.ARRAY_NORMAL]
	var source_tangents = arrays[Mesh.ARRAY_TANGENT]
	var source_colors = arrays[Mesh.ARRAY_COLOR]
	var source_uv = arrays[Mesh.ARRAY_TEX_UV]
	var source_uv2 = arrays[Mesh.ARRAY_TEX_UV2]
	for source_index in remap.keys():
		var index := int(source_index)
		vertices.append(source_vertices[index])
		if source_normals != null and source_normals.size() > 0:
			normals.append(source_normals[index])
		if source_tangents != null and source_tangents.size() > 0:
			tangents.append_array(PackedFloat32Array([
				source_tangents[index * 4],
				source_tangents[index * 4 + 1],
				source_tangents[index * 4 + 2],
				source_tangents[index * 4 + 3],
			]))
		if source_colors != null and source_colors.size() > 0:
			colors.append(source_colors[index])
		if source_uv != null and source_uv.size() > 0:
			uv.append(source_uv[index])
		if source_uv2 != null and source_uv2.size() > 0:
			uv2.append(source_uv2[index])
	rebuilt_arrays[Mesh.ARRAY_VERTEX] = vertices
	if not normals.is_empty():
		rebuilt_arrays[Mesh.ARRAY_NORMAL] = normals
	if not tangents.is_empty():
		rebuilt_arrays[Mesh.ARRAY_TANGENT] = tangents
	if not colors.is_empty():
		rebuilt_arrays[Mesh.ARRAY_COLOR] = colors
	if not uv.is_empty():
		rebuilt_arrays[Mesh.ARRAY_TEX_UV] = uv
	if not uv2.is_empty():
		rebuilt_arrays[Mesh.ARRAY_TEX_UV2] = uv2
	rebuilt_arrays[Mesh.ARRAY_INDEX] = rebuilt_indices
	var rebuilt := ArrayMesh.new()
	rebuilt.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, rebuilt_arrays)
	var material := mesh_instance.get_active_material(0)
	if material != null:
		rebuilt.surface_set_material(0, material)
	mesh_instance.mesh = rebuilt


func _set_model_alpha(root: Node3D, alpha: float) -> void:
	if root == null:
		return
	var clamped_alpha := clampf(alpha, 0.0, 1.0)
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		for surface in mesh_instance.mesh.get_surface_count():
			var active := mesh_instance.get_active_material(surface)
			if active is not StandardMaterial3D:
				continue
			var material := active as StandardMaterial3D
			if not bool(material.get_meta("prince_fade_ready", false)):
				material = material.duplicate() as StandardMaterial3D
				material.set_meta("prince_fade_ready", true)
				material.set_meta("prince_original_transparency", material.transparency)
				material.set_meta("prince_original_albedo", material.albedo_color)
				mesh_instance.set_surface_override_material(surface, material)
			var original_color: Color = material.get_meta(
				"prince_original_albedo",
				material.albedo_color
			)
			var color := original_color
			if clamped_alpha >= 0.999:
				material.transparency = int(material.get_meta(
					"prince_original_transparency",
					BaseMaterial3D.TRANSPARENCY_DISABLED
				))
				color.a = original_color.a
			else:
				material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
				color.a = original_color.a * clamped_alpha
			material.albedo_color = color


func _prepare_prince_chair_interaction() -> void:
	if standing_prince_3d != null:
		standing_prince_3d.visible = true
		_set_model_alpha(standing_prince_3d, 1.0)
	if seated_prince_3d != null:
		seated_prince_3d.visible = false
		_set_model_alpha(seated_prince_3d, 0.0)
	if chair_3d == null:
		return
	var chair_index := _find_editable_record_index_by_kind("chair")
	if chair_index >= 0:
		var record := editable_3d_objects[chair_index]
		chair_target_normal = (record.normal as Vector3).normalized()
		chair_target_root_radius = float(record.root_radius)
		chair_target_yaw = float(record.yaw)
		chair_target_transform = chair_3d.transform
		chair_target_scale = chair_3d.scale
	chair_float_transform = Transform3D(
		_normal_surface_basis(Vector3(-0.19, 0.94, 0.28).normalized(), -58.0),
		Vector3(-1.18, 2.34, 1.54)
	)
	chair_state = "hidden"
	chair_3d.visible = false
	chair_dragging = false
	prince_sitting = false
	prince_fade_progress = 0.0


func _find_editable_record_index_by_kind(kind: String) -> int:
	for index in editable_3d_objects.size():
		if String(editable_3d_objects[index].kind) == kind:
			return index
	return -1


func _register_editable_3d(
	node: Node3D,
	kind: String,
	label: String,
	normal: Vector3,
	root_radius: float,
	upright: bool,
	yaw_degrees: float,
	base_scale: float,
	asset_path: String,
	default_hidden: bool
) -> void:
	if node == null:
		return
	editable_serial += 1
	var surface_normal := normal.normalized()
	var record := {
		"id": "%s-%02d" % [kind, editable_serial],
		"kind": kind,
		"label": label,
		"node": node,
		"asset_path": asset_path,
		"base_scale": base_scale,
		"normal": surface_normal,
		"initial_normal": surface_normal,
		"root_radius": root_radius,
		"initial_root_radius": root_radius,
		"scale": 1.0,
		"initial_scale": 1.0,
		"yaw": yaw_degrees,
		"initial_yaw": yaw_degrees,
		"surface_tilt": 0.0,
		"initial_surface_tilt": 0.0,
		"upright": upright,
		"locked": false,
		"default_hidden": default_hidden,
		"initial_hidden": default_hidden,
	}
	var light_anchor := node.find_child("LightAnchor", true, false) as Node3D
	if light_anchor != null:
		record["light_anchor"] = light_anchor
		record["initial_light_offset"] = light_anchor.position
		record["light_on"] = true
		record["initial_light_on"] = true
		record["brightness"] = 1.0
		record["initial_brightness"] = 1.0
		record["light_range"] = 1.0
		record["initial_light_range"] = 1.0
	var preferred_animation := String(
		node.get_meta("preferred_character_animation", "")
	)
	if not preferred_animation.is_empty():
		record["selected_animation"] = preferred_animation
		record["initial_selected_animation"] = preferred_animation
	editable_3d_objects.append(record)
	_apply_editable_3d_record(editable_3d_objects.size() - 1)


func _attach_editor_light_anchor(node: Node3D, anchor: Node3D) -> void:
	if node == null or anchor == null:
		return
	for record in editable_3d_objects:
		if record.node == node:
			record["light_anchor"] = anchor
			record["initial_light_offset"] = anchor.position
			if not record.has("light_on"):
				record["light_on"] = true
				record["initial_light_on"] = true
			if not record.has("brightness"):
				record["brightness"] = 1.0
				record["initial_brightness"] = 1.0
			if not record.has("light_range"):
				record["light_range"] = 1.0
				record["initial_light_range"] = 1.0
			return


func _apply_editable_3d_record(index: int) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	var node := record.node as Node3D
	if node == null:
		return
	_ensure_player_record_height_fields(record)
	var target_transform := _editable_record_base_transform(record)
	var parent := node.get_parent() as Node3D
	if parent != null and parent != model_3d:
		target_transform = parent.transform.affine_inverse() * target_transform
	node.transform = target_transform
	node.scale = Vector3.ONE * float(record.scale)
	if (
		current_3d_scene == "player"
		and String(record.get("kind", "")) in PLAYER_SEAT_KINDS
	):
		_refresh_player_seat_riders(index)
	if index == selected_editable_index:
		_update_editor_selection_ring()


func _duplicate_selected_3d_object() -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var source: Dictionary = editable_3d_objects[selected_editable_index]
	var source_node := source.node as Node3D
	if source_node == null:
		return
	editable_serial += 1
	var clone := source_node.duplicate() as Node3D
	if clone == null:
		return
	clone.name = "Layout_%s_Copy_%02d" % [String(source.kind), editable_serial]
	var record := source.duplicate()
	record["id"] = "%s-copy-%02d" % [String(source.kind), editable_serial]
	record["label"] = String(source.label).trim_suffix(" 副本") + " 副本"
	record["node"] = clone
	record["scale"] = float(source.scale)
	record["initial_scale"] = float(source.scale)
	record["yaw"] = float(source.yaw)
	record["initial_yaw"] = float(source.yaw)
	record["locked"] = false
	record.erase("light_tween")
	if String(source.get("layout_mode", "sphere")) == "plane":
		var new_position: Vector3 = (source.position as Vector3) + Vector3(0.22, 0.0, 0.06)
		new_position.x = clampf(new_position.x, -1.35, 1.35)
		new_position.z = clampf(new_position.z, -1.35, 1.35)
		record["position"] = new_position
		record["initial_position"] = new_position
		record["root_radius"] = new_position.y
		record["initial_root_radius"] = new_position.y
	else:
		var source_normal: Vector3 = source.normal
		var tangent := Vector3.UP.cross(source_normal).normalized()
		if tangent.length_squared() < 0.001:
			tangent = Vector3.RIGHT
		var new_normal := (source_normal + tangent * 0.12).normalized()
		record["normal"] = new_normal
		record["initial_normal"] = new_normal
		record["root_radius"] = float(source.root_radius)
		record["initial_root_radius"] = float(source.root_radius)
	record["default_hidden"] = false
	record["initial_hidden"] = false
	if _is_editable_light_record(source):
		record["light_on"] = bool(source.get("light_on", true))
		record["initial_light_on"] = bool(source.get("light_on", true))
		record["brightness"] = clampf(float(source.get("brightness", 1.0)), 0.1, 2.5)
		record["initial_brightness"] = float(record["brightness"])
		record["light_range"] = clampf(
			float(source.get("light_range", 1.0)),
			0.35,
			1.5
		)
		record["initial_light_range"] = float(record["light_range"])
	var cloned_light := clone.find_child("LightAnchor", true, false) as Node3D
	if cloned_light != null:
		record["light_anchor"] = cloned_light
		record["initial_light_offset"] = cloned_light.position
	editable_3d_objects.append(record)
	model_3d.add_child(clone)
	clone.visible = true
	if String(record.get("kind", "")) == KING_LIGHT_KIND:
		_make_king_light_core_unique(clone)
	selected_editable_index = editable_3d_objects.size() - 1
	_apply_editable_3d_record(selected_editable_index)
	if _is_editable_light_record(record):
		_set_king_light_state(selected_editable_index, bool(record.get("light_on", true)), false)
	if (
		current_3d_scene == "merchant"
		and (
			String(record.get("kind", "")) == "star_lamp"
			or String(record.get("kind", "")) in MERCHANT_ROPE_KINDS
		)
	):
		_build_merchant_lamp_swing_assemblies()
	_refresh_editor_object_list()
	_editor_set_status("已复制：%s" % String(record.label))


func _reset_selected_3d_object() -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if String(record.get("layout_mode", "sphere")) == "plane":
		record["position"] = record.initial_position
		record["root_radius"] = (record.initial_position as Vector3).y
		if _is_player_plane_record(record):
			record["normal"] = record.initial_normal
			record["placement_plane_normal"] = record.initial_normal
			record["placement_height_offset"] = float(
				record.get("initial_placement_height_offset", 0.0)
			)
			record[
				"support_height_offset"
				if not String(record.get("placement_support_id", "")).is_empty()
				else "ground_height_offset"
			] = float(record.placement_height_offset)
			if String(record.get("placement_support_id", "")).is_empty():
				player_asset_height_offsets[String(record.kind)] = float(
					record.placement_height_offset
				)
	else:
		record["normal"] = record.initial_normal
		record["root_radius"] = float(record.initial_root_radius)
	record["scale"] = float(record.get("initial_scale", 1.0))
	if _is_player_plane_record(record):
		player_asset_scale_defaults[String(record.kind)] = float(record.scale)
	record["yaw"] = float(record.initial_yaw)
	record["surface_tilt"] = float(record.get("initial_surface_tilt", 0.0))
	record["default_hidden"] = bool(record.initial_hidden)
	(record.node as Node3D).visible = not bool(record.initial_hidden)
	if record.has("light_anchor"):
		(record.light_anchor as Node3D).position = record.initial_light_offset
	_apply_editable_3d_record(selected_editable_index)
	if _is_editable_light_record(record):
		var initial_light_on := bool(record.get("initial_light_on", true))
		record["light_on"] = initial_light_on
		record["brightness"] = clampf(float(record.get("initial_brightness", 1.0)), 0.1, 2.5)
		record["light_range"] = clampf(
			float(record.get("initial_light_range", 1.0)),
			0.35,
			1.5
		)
		_set_king_light_state(selected_editable_index, initial_light_on, false)
	if record.has("initial_selected_animation"):
		var initial_animation := String(record.initial_selected_animation)
		record["selected_animation"] = initial_animation
		_apply_character_animation_choice(
			record.node as Node3D,
			initial_animation,
			true
		)
	_sync_editor_controls()
	_editor_set_status("已恢复当前对象的初始状态")


func _delete_selected_3d_object() -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	var node := record.node as Node3D
	var deleted_label := String(record.label)
	if node == main_lamp_node:
		main_lamp_node = null
		main_lamp_light_anchor = null
		main_lamp_light = null
	if node == chair_3d:
		chair_3d = null
	if node == seated_prince_3d:
		seated_prince_3d = null
	if node != null:
		node.queue_free()
	if not deleted_editable_ids.has(String(record.id)):
		deleted_editable_ids.append(String(record.id))
	editable_3d_objects.remove_at(selected_editable_index)
	if current_3d_scene == "player" and player_placement_selected_index >= 0:
		player_placement_selected_index = -1
		player_placement_object_dragging = false
	selected_editable_index = min(
		selected_editable_index,
		editable_3d_objects.size() - 1
	)
	prop_wobble_states.clear()
	if editor_selection_ring != null:
		editor_selection_ring.visible = false
	_refresh_editor_object_list()
	_update_editor_selection_ring()
	_editor_set_status("已删除：%s" % deleted_label)


func _toggle_3d_editor() -> void:
	_finish_abacus_bead_drag()
	if current_3d_scene == "player":
		_close_player_character_interaction()
	editor_active = not editor_active
	editor_panel.visible = editor_active
	editor_edit_button.text = "完成" if editor_active else "布局"
	if editor_active:
		_cancel_player_navigation(true)
		_close_player_placement_dock()
		_reset_star_lamp_swings()
	if editor_add_light_button != null:
		editor_add_light_button.visible = true
	_update_player_day_night_beacon()
	hovered_feedback_index = -1
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	model_spin_velocity = Vector2.ZERO
	dragging_3d = false
	editor_dragging_object = false
	if editor_active:
		if editor_scroll != null:
			editor_scroll.scroll_vertical = 0
		if editor_heading != null:
			editor_heading.text = "布局 | %s" % _current_scene_display_name()
		if editor_earth_wheat_controls != null:
			editor_earth_wheat_controls.visible = current_3d_scene == "earth"
		_sync_planet_base_lighting_control()
		_sync_earth_wheat_controls()
		_sync_camera_zoom_controls()
		_sync_planet_height_control()
		for record in editable_3d_objects:
			(record.node as Node3D).visible = true
		_refresh_editor_object_list()
		if selected_editable_index < 0 and not editable_3d_objects.is_empty():
			selected_editable_index = 0
			_refresh_editor_object_list()
		_ensure_editor_selection_ring()
		_update_editor_selection_ring()
		if current_3d_scene == "king":
			editor_subheading.text = "列表选物；空白处左拖或右键拖动可旋转场景"
			_editor_set_status("列表可选中被遮挡物件；右键/中键拖动始终旋转星球。")
		else:
			editor_subheading.text = "列表选物；空白处左拖或右键拖动可旋转星球"
			_editor_set_status("右键/中键拖动始终旋转星球；列表可选星球内部物件。")
	else:
		if editor_selection_ring != null:
			editor_selection_ring.visible = false
		for record in editable_3d_objects:
			(record.node as Node3D).visible = not bool(record.default_hidden)
		if current_3d_scene == "player":
			_restore_player_character_seating()
		_editor_set_status("")


func _refresh_editor_object_list() -> void:
	if editor_object_select == null:
		return
	editor_object_select.set_block_signals(true)
	editor_object_select.clear()
	if editable_3d_objects.is_empty():
		editor_object_select.add_item("星球基底已就绪 | 下一阶段加入可摆放模型")
		editor_object_select.set_item_disabled(0, true)
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		var lock_suffix := "  |  已锁定" if bool(record.get("locked", false)) else ""
		var hidden_suffix := (
			"  |  默认隐藏"
			if bool(record.get("default_hidden", false))
			else ""
		)
		editor_object_select.add_item(
			"%s  |  %s%s%s" % [
				String(record.label),
				String(record.id),
				lock_suffix,
				hidden_suffix,
			]
		)
		editor_object_select.set_item_tooltip(
			index,
			"点击选中；0° 球面倾角表示物件基座垂直于当前落点球面"
		)
		if index == selected_editable_index:
			editor_object_select.select(index)
	if selected_editable_index < 0 and not editable_3d_objects.is_empty():
		selected_editable_index = 0
		editor_object_select.select(0)
	editor_object_select.set_block_signals(false)
	_sync_editor_controls()


func _on_editor_object_selected(index: int) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	selected_editable_index = index
	_sync_editor_controls()
	_update_editor_selection_ring()


func _planet_base_lighting_level() -> float:
	return clampf(
		float(planet_base_lighting_levels.get(current_3d_scene, 1.0)),
		PLANET_BASE_LIGHTING_MIN,
		PLANET_BASE_LIGHTING_MAX
	)


func _sync_planet_base_lighting_control() -> void:
	if editor_base_lighting_slider == null:
		return
	var level := _planet_base_lighting_level()
	editor_base_lighting_slider.set_value_no_signal(level)
	if editor_base_lighting_value != null:
		editor_base_lighting_value.text = "%d%%" % roundi(level * 100.0)


func _on_editor_base_lighting_changed(value: float) -> void:
	var level := clampf(
		snappedf(value, PLANET_BASE_LIGHTING_STEP),
		PLANET_BASE_LIGHTING_MIN,
		PLANET_BASE_LIGHTING_MAX
	)
	planet_base_lighting_levels[current_3d_scene] = level
	_sync_planet_base_lighting_control()
	_apply_current_planet_lighting()


func _sync_earth_wheat_controls() -> void:
	if editor_earth_wheat_controls == null:
		return
	editor_earth_wheat_controls.visible = current_3d_scene == "earth"
	if editor_earth_wheat_brightness_value != null:
		editor_earth_wheat_brightness_value.text = "%d%%" % roundi(
			earth_wheat_brightness * 100.0
		)
	if editor_earth_wheat_saturation_value != null:
		editor_earth_wheat_saturation_value.text = "%d%%" % roundi(
			earth_wheat_saturation * 100.0
		)
	if editor_earth_light_yaw_value != null:
		editor_earth_light_yaw_value.text = "%+.0f°" % earth_light_yaw


func _nudge_earth_wheat_tone(property_name: String, delta: float) -> void:
	if current_3d_scene != "earth":
		return
	if property_name == "brightness":
		earth_wheat_brightness = clampf(
			snappedf(
				earth_wheat_brightness + delta,
				EARTH_WHEAT_TONE_STEP
			),
			0.60,
			1.15
		)
	elif property_name == "saturation":
		earth_wheat_saturation = clampf(
			snappedf(
				earth_wheat_saturation + delta,
				EARTH_WHEAT_TONE_STEP
			),
			0.60,
			1.15
		)
	_sync_earth_wheat_controls()
	_warm_earth_wheat_materials(model_3d)


func _nudge_earth_light_direction(delta_degrees: float) -> void:
	if current_3d_scene != "earth" or stage_key_light == null:
		return
	earth_light_yaw = wrapf(
		earth_light_yaw + delta_degrees,
		-180.0,
		180.0
	)
	stage_key_light.rotation_degrees = Vector3(
		-50.0,
		earth_light_yaw,
		0.0
	)
	_sync_earth_wheat_controls()
	_editor_set_status(
		"地球主光方向：%+.0f°" % earth_light_yaw
	)


func _reset_earth_wheat_tone() -> void:
	if current_3d_scene != "earth":
		return
	earth_wheat_brightness = EARTH_WHEAT_DEFAULT_BRIGHTNESS
	earth_wheat_saturation = EARTH_WHEAT_DEFAULT_SATURATION
	earth_light_yaw = EARTH_LIGHT_DEFAULT_YAW
	if stage_key_light != null:
		stage_key_light.rotation_degrees = Vector3(-50.0, earth_light_yaw, 0.0)
	_sync_earth_wheat_controls()
	_warm_earth_wheat_materials(model_3d)
	_editor_set_status("麦田明暗与饱和度已恢复默认。")


func _apply_current_planet_lighting() -> void:
	if stage_environment == null:
		return
	match current_3d_scene:
		"pointlighter":
			_apply_pointlighter_environment()
		"king":
			_apply_king_environment()
			_update_king_celestial(0.0)
		_:
			if generated_planet_models.has(current_3d_scene):
				_apply_generated_planet_environment(current_3d_scene)


func _apply_planet_base_lighting_multiplier(include_static_lights := true) -> void:
	if stage_environment == null:
		return
	var level := _planet_base_lighting_level()
	var exposure_scale := 1.0
	if level <= 1.0:
		exposure_scale = lerpf(
			0.94,
			1.0,
			(level - PLANET_BASE_LIGHTING_MIN)
			/ (1.0 - PLANET_BASE_LIGHTING_MIN)
		)
	else:
		exposure_scale = lerpf(
			1.0,
			1.06,
			(level - 1.0) / (PLANET_BASE_LIGHTING_MAX - 1.0)
		)
	stage_environment.ambient_light_energy *= level
	stage_environment.tonemap_exposure *= exposure_scale
	if stage_key_light != null:
		stage_key_light.light_energy *= level
	if not include_static_lights:
		return
	if stage_rim_light != null:
		stage_rim_light.light_energy *= level
	if stage_cool_fill != null:
		stage_cool_fill.light_energy *= level
	if stage_front_fill != null:
		stage_front_fill.light_energy *= level
	if earth_front_light != null:
		earth_front_light.light_energy *= level
	if warm_fill_light != null:
		warm_fill_light.light_energy *= level


func _character_animation_display_name(clip_name: String) -> String:
	match clip_name:
		"agree_001":
			return "点头同意"
		"afraid_001":
			return "害怕"
		"bow_001":
			return "鞠躬"
		"idle_001":
			return "待机"
		"clap_001":
			return "鼓掌"
		"walk_001":
			return "行走"
		"sit_001":
			return "坐下"
		"fold_arms_001":
			return "抱臂"
		"wait_001":
			return "等待"
		"vain_idle_001":
			return "自然待机"
		"cheer_001":
			return "欢呼"
		"dance_01_001":
			return "跳舞"
		"laugh_02_001":
			return "大笑"
		"look_around_001":
			return "环顾"
		"gentle_look_around":
			return "环顾（轻缓）"
		"sit":
			return "坐下"
		"Idle":
			return "待机"
		"Idle_2":
			return "待机 2"
		"Idle_2_HeadLow":
			return "低头待机"
		"Walk":
			return "行走"
		"Gallop":
			return "小跑"
		"Gallop_Jump":
			return "奔跑跳跃"
		"Jump_ToIdle":
			return "跳跃落地"
		"Eating":
			return "吃东西"
		"Attack":
			return "扑击"
		"Death":
			return "倒地"
		"Idle_HitReact_Left":
			return "左侧受惊"
		"Idle_HitReact_Right":
			return "右侧受惊"
	return clip_name.replace("_", " ")


func _sync_character_animation_controls(record: Dictionary) -> void:
	if (
		editor_character_animation_row == null
		or editor_character_animation_select == null
	):
		return
	editor_character_animation_row.visible = false
	editor_character_animation_select.clear()
	var root := record.get("node") as Node3D
	var player := _find_rig_animation_player(root)
	if player == null:
		return
	var clip_names := player.get_animation_list()
	if clip_names.is_empty():
		return
	var selected_animation := String(record.get("selected_animation", ""))
	if selected_animation.is_empty():
		selected_animation = String(
			root.get_meta(
				"preferred_character_animation",
				player.current_animation
			)
		)
	var selected_index := -1
	editor_character_animation_select.set_block_signals(true)
	if String(record.get("kind", "")) in PLAYER_PERSON_KINDS:
		if player.has_animation("gentle_look_around"):
			editor_character_animation_select.add_item(
				"环顾（轻缓）",
				0
			)
			editor_character_animation_select.set_item_metadata(
				0,
				"gentle_look_around"
			)
		if player.has_animation("walk_001"):
			var walk_item := editor_character_animation_select.item_count
			editor_character_animation_select.add_item("行走", walk_item)
			editor_character_animation_select.set_item_metadata(
				walk_item,
				"walk_001"
			)
		if player.has_animation("sit"):
			var sit_item := editor_character_animation_select.item_count
			editor_character_animation_select.add_item("坐下", sit_item)
			editor_character_animation_select.set_item_metadata(
				sit_item,
				"sit"
			)
		if selected_animation == "look_around":
			selected_animation = "gentle_look_around"
		for item_index in editor_character_animation_select.item_count:
			if String(
				editor_character_animation_select.get_item_metadata(item_index)
			) == selected_animation:
				selected_index = item_index
				break
		if selected_index < 0:
			selected_index = 0
			selected_animation = "gentle_look_around"
		editor_character_animation_select.select(selected_index)
		editor_character_animation_select.set_block_signals(false)
		record["selected_animation"] = selected_animation
		editor_character_animation_row.visible = true
		return
	var is_prince := String(record.get("kind", "")) in PRINCE_CHARACTER_KINDS
	if is_prince and player.has_animation("subtle_idle_001"):
		editor_character_animation_select.add_item("自然待机（轻缓）", 0)
		editor_character_animation_select.set_item_metadata(
			0,
			"ambient_idle"
		)
		if selected_animation == "ambient_idle":
			selected_index = 0
	for clip_index in clip_names.size():
		var clip_name := String(clip_names[clip_index])
		if clip_name == "subtle_idle_001":
			continue
		var item_index := editor_character_animation_select.item_count
		editor_character_animation_select.add_item(
			_character_animation_display_name(clip_name),
			item_index
		)
		editor_character_animation_select.set_item_metadata(
			item_index,
			clip_name
		)
		if clip_name == selected_animation:
			selected_index = item_index
	if selected_index < 0:
		selected_index = 0
		selected_animation = String(
			editor_character_animation_select.get_item_metadata(0)
		)
	editor_character_animation_select.select(selected_index)
	editor_character_animation_select.set_block_signals(false)
	record["selected_animation"] = selected_animation
	editor_character_animation_row.visible = true


func _on_editor_character_animation_selected(index: int) -> void:
	if (
		selected_editable_index < 0
		or selected_editable_index >= editable_3d_objects.size()
		or editor_character_animation_select == null
		or index < 0
	):
		return
	var clip_name := String(
		editor_character_animation_select.get_item_metadata(index)
	)
	if clip_name.is_empty():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	record["selected_animation"] = clip_name
	var root := record.get("node") as Node3D
	if _apply_character_animation_choice(root, clip_name, true):
		_editor_set_status(
			"“%s”正在循环播放：%s"
			% [
				String(record.label),
				_character_animation_display_name(clip_name),
			]
		)


func _sync_editor_controls() -> void:
	_sync_planet_base_lighting_control()
	_sync_earth_wheat_controls()
	if (
		editor_scale_slider == null
		or selected_editable_index < 0
		or selected_editable_index >= editable_3d_objects.size()
	):
		if editor_character_animation_row != null:
			editor_character_animation_row.visible = false
		if editor_height_lock_row != null:
			editor_height_lock_row.visible = false
		if editable_3d_objects.is_empty() and editor_position_label != null:
			editor_position_label.text = "当前只展示星球基底 | 可先调整镜头、朝向与基础光照"
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	_sync_character_animation_controls(record)
	var is_plane := String(record.get("layout_mode", "sphere")) == "plane"
	var is_player_plane := _is_player_plane_record(record)
	var is_player_character := _is_player_character_kind(
		String(record.get("kind", ""))
	)
	var is_player_character_seated := (
		is_player_character
		and String(record.get("seat_state", "")) == "seated"
	)
	editor_surface_tilt_slider.editable = (
		String(record.get("kind", "")) not in ALWAYS_SURFACE_UPRIGHT_KINDS
	)
	editor_scale_slider.set_value_no_signal(float(record.scale))
	editor_yaw_slider.set_value_no_signal(float(record.yaw))
	editor_surface_tilt_slider.set_block_signals(true)
	editor_surface_tilt_slider.set_value_no_signal(
		float(record.get("surface_tilt", 0.0))
	)
	editor_surface_tilt_slider.set_block_signals(false)
	editor_surface_tilt_value.text = "%+.1f°" % float(
		record.get("surface_tilt", 0.0)
	)
	editor_distance_slider.set_block_signals(true)
	if is_plane:
		var position: Vector3 = record.position
		var radial_distance := Vector2(position.x, position.z).length()
		editor_distance_slider.min_value = 0.0
		editor_distance_slider.max_value = 1.35
		editor_distance_slider.set_value_no_signal(radial_distance)
		editor_distance_title.text = "离中心"
		editor_distance_value.text = "%.2f" % radial_distance
	else:
		editor_distance_slider.min_value = 1.5
		editor_distance_slider.max_value = 8.0
		editor_distance_slider.set_value_no_signal(float(record.root_radius))
		editor_distance_title.text = "离球心"
		editor_distance_value.text = "%.2f" % float(record.root_radius)
	editor_distance_slider.set_block_signals(false)
	editor_height_row.visible = is_player_plane or (
		is_plane and (
			current_3d_scene == "king"
			or String(record.get("kind", "")) == "river"
		)
	)
	if editor_height_lock_row != null:
		editor_height_lock_row.visible = (
			is_player_character
			and current_3d_scene == "player"
		)
	var player_item_height_locked := (
		is_player_plane
		and not is_player_character
		and bool(record.get("placement_height_locked", false))
	)
	editor_height_slider.set_block_signals(true)
	if is_player_plane:
		var is_support_snapped := not String(
			record.get("placement_support_id", "")
		).is_empty()
		editor_height_title.text = (
			"坐姿高度"
			if is_player_character_seated
			else (
				"站立高度"
				if is_player_character
				else (
					"离吸附面"
					if is_support_snapped
					else "离星球摆放面"
				)
			)
		)
		editor_height_title.tooltip_text = (
			"沿吸附面法线调整物件高度；不会改变该物品在星球摆放面的默认高度"
			if is_support_snapped
			else (
				"沿星球摆放面法线调整物件高度"
				if not is_player_character
				else ""
			)
		)
		if player_item_height_locked:
			editor_height_title.text += "（已锁定）"
			editor_height_title.tooltip_text = "当前物件高度已锁定"
		editor_height_slider.min_value = PLAYER_HEIGHT_OFFSET_MIN
		editor_height_slider.max_value = PLAYER_HEIGHT_OFFSET_MAX
		editor_height_slider.step = PLAYER_HEIGHT_OFFSET_STEP
		var height_offset := clampf(
			float(record.get(
				"seat_height"
				if is_player_character_seated
				else "placement_height_offset",
				0.0
			)),
			PLAYER_HEIGHT_OFFSET_MIN,
			PLAYER_HEIGHT_OFFSET_MAX
		)
		editor_height_slider.set_value_no_signal(height_offset)
		editor_height_value.text = "%+.2f" % height_offset
	elif is_plane:
		editor_height_title.text = "离底部"
		editor_height_slider.min_value = 0.0
		editor_height_slider.max_value = 6.0
		editor_height_slider.step = 0.01
		var height_position: Vector3 = record.position
		editor_height_slider.max_value = maxf(6.0, height_position.y + 1.0)
		editor_height_slider.set_value_no_signal(height_position.y)
		editor_height_value.text = "%.2f" % height_position.y
	editor_height_slider.set_block_signals(false)
	editor_scale_value.text = "%d%%" % roundi(float(record.scale) * 100.0)
	editor_yaw_value.text = "%d°" % roundi(float(record.yaw))
	var position_locked := bool(record.get("locked", false))
	editor_distance_slider.editable = not position_locked
	var height_locked := false
	if is_player_character:
		var standing_locked := _player_standing_height_locked(record)
		var sitting_locked := _player_sitting_height_locked(record)
		height_locked = (
			sitting_locked
			if is_player_character_seated
			else standing_locked
		)
		editor_standing_height_lock_button.set_pressed_no_signal(
			standing_locked
		)
		editor_sitting_height_lock_button.set_pressed_no_signal(
			sitting_locked
		)
		editor_standing_height_lock_button.text = (
			"站立高度：已锁定"
			if standing_locked
			else "站立高度：锁定"
		)
		editor_sitting_height_lock_button.text = (
			"坐下高度：已锁定"
			if sitting_locked
			else "坐下高度：锁定"
		)
		editor_standing_height_lock_button.modulate = (
			Color.WHITE
			if not is_player_character_seated
			else Color(0.68, 0.70, 0.70, 0.72)
		)
		editor_sitting_height_lock_button.modulate = (
			Color.WHITE
			if is_player_character_seated
			else Color(0.68, 0.70, 0.70, 0.72)
		)
	editor_height_slider.editable = (
		(is_player_plane and not height_locked)
		or (not is_player_plane and not position_locked)
	) and not player_item_height_locked
	editor_lock_button.text = "解锁位置" if position_locked else "锁定位置"
	editor_visible_check.set_pressed_no_signal((record.node as Node3D).visible)
	var is_king_light := String(record.get("kind", "")) == KING_LIGHT_KIND
	var is_editable_light := _is_editable_light_record(record)
	editor_light_on_check.visible = is_editable_light
	editor_brightness_row.visible = is_editable_light
	if is_editable_light:
		editor_light_on_check.set_pressed_no_signal(bool(record.get("light_on", true)))
		var brightness := clampf(float(record.get("brightness", 1.0)), 0.1, 2.5)
		editor_brightness_slider.set_value_no_signal(brightness)
		editor_brightness_value.text = "%d%%" % roundi(brightness * 100.0)
	var light_anchor: Node3D = record.get("light_anchor", null)
	editor_light_x.editable = light_anchor != null and not is_king_light
	editor_light_y.editable = light_anchor != null and not is_king_light
	editor_light_z.editable = light_anchor != null and not is_king_light
	if light_anchor != null:
		editor_light_x.set_value_no_signal(light_anchor.position.x)
		editor_light_y.set_value_no_signal(light_anchor.position.y)
		editor_light_z.set_value_no_signal(light_anchor.position.z)
	if is_player_plane:
		var position: Vector3 = record.position
		var height_label := (
			"离吸附面"
			if not String(record.get("placement_support_id", "")).is_empty()
			else "离星球摆放面"
		)
		editor_position_label.text = (
			"平面位置  X %+.2f  |  Z %+.2f  |  %s %+.2f"
			% [
				position.x,
				position.z,
				height_label,
				float(record.get("placement_height_offset", 0.0)),
			]
		)
	elif is_plane:
		var position: Vector3 = record.position
		editor_position_label.text = "平面位置  X %+.2f  |  Z %+.2f  |  高度 %.2f" % [
			position.x,
			position.z,
			position.y,
		]
	else:
		var normal: Vector3 = record.normal
		var latitude := rad_to_deg(asin(clampf(normal.y, -1.0, 1.0)))
		var longitude := rad_to_deg(atan2(normal.x, normal.z))
		editor_position_label.text = "球面位置  纬度 %+.1f°  |  经度 %+.1f°" % [latitude, longitude]


func _on_editor_scale_changed(value: float) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	record["scale"] = value
	if _is_player_plane_record(record):
		player_asset_scale_defaults[String(record.kind)] = clampf(
			value,
			0.3,
			3.0
		)
		_editor_set_status(
			"“%s”缩放 %d%%；再次放置同类物件时会沿用此大小。"
			% [String(record.label), roundi(value * 100.0)]
		)
	editor_scale_value.text = "%d%%" % roundi(value * 100.0)
	_apply_editable_3d_record(selected_editable_index)


func _on_editor_yaw_changed(value: float) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	record["yaw"] = value
	editor_yaw_value.text = "%d°" % roundi(value)
	_apply_editable_3d_record(selected_editable_index)


func _on_editor_surface_tilt_changed(value: float) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	record["surface_tilt"] = clampf(value, -60.0, 60.0)
	editor_surface_tilt_value.text = "%+.1f°" % float(record.surface_tilt)
	_apply_editable_3d_record(selected_editable_index)


func _nudge_editor_surface_tilt(amount: float) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	var next_tilt := clampf(
		float(record.get("surface_tilt", 0.0)) + amount,
		-60.0,
		60.0
	)
	record["surface_tilt"] = next_tilt
	_sync_editor_controls()
	_apply_editable_3d_record(selected_editable_index)
	_editor_set_status(
		"球面倾角 %+.0f°：0° 为贴合落点球面的基准朝向。" % next_tilt
	)


func _align_selected_3d_object_to_surface() -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	record["surface_tilt"] = 0.0
	_sync_editor_controls()
	_apply_editable_3d_record(selected_editable_index)
	_editor_set_status("已将基座对准落点球面，球面倾角为 0°。")


func _set_3d_camera_distance(value: float) -> void:
	if camera_3d == null:
		return
	camera_distance = clampf(
		value,
		CAMERA_ZOOM_MIN_DISTANCE,
		CAMERA_ZOOM_MAX_DISTANCE
	)
	var home_offset := camera_home_position - camera_focus_point
	if home_offset.length_squared() > 0.000001:
		# Zoom along the initial sight line. Moving only on Z changes the camera
		# pitch and makes a zoom feel like an unwanted forced angle switch.
		camera_3d.position = (
			camera_focus_point
			+ home_offset.normalized() * camera_distance
		)
		camera_3d.look_at(camera_focus_point)
	else:
		camera_3d.position.z = camera_distance
	_sync_camera_zoom_controls()


func _on_editor_camera_distance_changed(value: float) -> void:
	_set_3d_camera_distance(value)


func _nudge_camera_distance(amount: float) -> void:
	_set_3d_camera_distance(camera_distance + amount)


func _sync_camera_zoom_controls() -> void:
	if editor_camera_distance_slider == null:
		return
	editor_camera_distance_slider.set_block_signals(true)
	editor_camera_distance_slider.set_value_no_signal(camera_distance)
	editor_camera_distance_slider.set_block_signals(false)
	if editor_camera_distance_value != null:
		editor_camera_distance_value.text = "%.1f" % camera_distance


func _on_editor_distance_changed(value: float) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if bool(record.get("locked", false)):
		return
	if String(record.get("layout_mode", "sphere")) == "plane":
		var position: Vector3 = record.position
		var horizontal := Vector2(position.x, position.z)
		if horizontal.length_squared() < 0.0001:
			horizontal = Vector2(0.0, 1.0)
		horizontal = horizontal.normalized() * value
		record["position"] = Vector3(horizontal.x, position.y, horizontal.y)
		editor_distance_value.text = "%.2f" % value
		_apply_editable_3d_record(selected_editable_index)
		var moved: Vector3 = record.position
		editor_position_label.text = "平面位置  X %+.2f  |  Z %+.2f  |  高度 %.2f" % [
			moved.x,
			moved.z,
			moved.y,
		]
		return
	record["root_radius"] = value
	editor_distance_value.text = "%.2f" % value
	_apply_editable_3d_record(selected_editable_index)
	var normal: Vector3 = record.normal
	var latitude := rad_to_deg(asin(clampf(normal.y, -1.0, 1.0)))
	var longitude := rad_to_deg(atan2(normal.x, normal.z))
	editor_position_label.text = "球面位置  纬度 %+.1f°  |  经度 %+.1f°" % [latitude, longitude]


func _on_editor_height_changed(value: float) -> void:
	if (
		selected_editable_index < 0
		or selected_editable_index >= editable_3d_objects.size()
	):
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if _is_player_plane_record(record):
		var character_kind := String(record.get("kind", ""))
		var is_player_character := _is_player_character_kind(character_kind)
		var is_seated := (
			is_player_character
			and String(record.get("seat_state", "")) == "seated"
		)
		var height_offset := clampf(
			value,
			PLAYER_HEIGHT_OFFSET_MIN,
			PLAYER_HEIGHT_OFFSET_MAX
		)
		if is_player_character:
			if (
				_player_sitting_height_locked(record)
				if is_seated
				else _player_standing_height_locked(record)
			):
				_sync_editor_controls()
				_editor_set_status(
					"坐下高度已锁定"
					if is_seated
					else "站立高度已锁定"
				)
				return
			if is_seated:
				_apply_player_character_seat_height(
					record,
					height_offset
				)
				editor_height_value.text = "%+.2f" % height_offset
				_update_editor_selection_ring()
				_sync_editor_controls()
				_editor_set_status(
					"“%s”坐姿高度 %+.2f；站立高度未改变。"
					% [String(record.label), height_offset]
				)
				return
		if (
			not is_player_character
			and bool(record.get("placement_height_locked", false))
		):
			_sync_editor_controls()
			_editor_set_status("当前物件高度已锁定，不能再次调整。")
			return
		if is_equal_approx(
			float(record.get("placement_height_offset", 0.0)),
			height_offset
		):
			return
		if is_player_character:
			record["placement_height_offset"] = height_offset
			if String(record.get("placement_support_id", "")).is_empty():
				player_asset_height_offsets[character_kind] = height_offset
		else:
			_set_player_record_height_for_context(
				record,
				not String(record.get("placement_support_id", "")).is_empty(),
				height_offset,
				true
			)
		editor_height_value.text = "%+.2f" % height_offset
		_apply_editable_3d_record(selected_editable_index)
		_update_editor_selection_ring()
		_sync_editor_controls()
		_editor_set_status((
			"“%s”站立高度 %+.2f；坐下高度未改变。"
			if is_player_character
			else (
				"“%s”离吸附面 %+.2f；星球摆放面高度未改变。"
				if not String(record.get("placement_support_id", "")).is_empty()
				else "“%s”离星球摆放面 %+.2f；再次在地面放置同类物件时会沿用此高度。"
			)
		) % [String(record.label), height_offset])
		return
	if (
		(
			current_3d_scene != "king"
			and String(record.get("kind", "")) != "river"
		)
		or
		bool(record.get("locked", false))
		or String(record.get("layout_mode", "sphere")) != "plane"
	):
		return
	var position: Vector3 = record.position
	position.y = value
	record["position"] = position
	record["root_radius"] = value
	editor_height_value.text = "%.2f" % value
	_apply_editable_3d_record(selected_editable_index)
	editor_position_label.text = "平面位置  X %+.2f  |  Z %+.2f  |  高度 %.2f" % [
		position.x,
		position.z,
		position.y,
	]


func _toggle_selected_3d_object_lock() -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	var locked := not bool(record.get("locked", false))
	record["locked"] = locked
	_refresh_editor_object_list()
	_update_editor_selection_ring()
	if locked:
		_editor_set_status("已锁定位置：%s。点击“解锁位置”后可继续拖动。" % String(record.label))
	else:
		_editor_set_status("已解锁位置：%s。" % String(record.label))


func _on_editor_light_offset_changed(value: float, axis: int) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	var light_anchor: Node3D = record.get("light_anchor", null)
	if light_anchor == null:
		return
	var offset := light_anchor.position
	offset[axis] = value
	light_anchor.position = offset


func _on_editor_visibility_toggled(visible_now: bool) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	var node := record.node as Node3D
	node.visible = visible_now
	record["default_hidden"] = not visible_now


func _on_editor_light_power_toggled(light_on: bool) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if not _is_editable_light_record(record):
		return
	record["light_on"] = light_on
	_set_king_light_state(selected_editable_index, light_on)


func _on_editor_brightness_changed(value: float) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if not _is_editable_light_record(record):
		return
	var brightness := clampf(value, 0.1, 2.5)
	record["brightness"] = brightness
	editor_brightness_value.text = "%d%%" % roundi(brightness * 100.0)
	_set_king_light_state(
		selected_editable_index,
		bool(record.get("light_on", true)),
		false
	)


func _ensure_editor_selection_ring() -> void:
	if model_3d == null:
		return
	if editor_selection_ring != null:
		if editor_selection_ring.get_parent() != model_3d:
			editor_selection_ring.reparent(model_3d, false)
		return
	var torus := TorusMesh.new()
	torus.inner_radius = 0.11
	torus.outer_radius = 0.135
	torus.rings = 24
	torus.ring_segments = 8
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color(1.0, 0.91, 0.22, 1.0)
	material.emission_enabled = true
	material.emission = Color(1.0, 0.78, 0.08)
	material.emission_energy_multiplier = 3.2
	material.no_depth_test = true
	editor_selection_ring = MeshInstance3D.new()
	editor_selection_ring.name = "SelectionRing"
	editor_selection_ring.mesh = torus
	editor_selection_ring.material_override = material
	editor_selection_ring.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	editor_selection_ring.visible = false
	model_3d.add_child(editor_selection_ring)


func _update_editor_selection_ring() -> void:
	if editor_selection_ring == null:
		return
	var player_placement_selected := (
		current_3d_scene == "player"
		and not editor_active
		and player_place_dock != null
		and player_place_dock.visible
		and player_placement_selected_index >= 0
		and selected_editable_index == player_placement_selected_index
	)
	if (
		(not editor_active and not player_placement_selected)
		or selected_editable_index < 0
		or selected_editable_index >= editable_3d_objects.size()
	):
		editor_selection_ring.visible = false
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if _is_player_plane_record(record):
		var selected_node := record.get("node") as Node3D
		if selected_node != null and is_instance_valid(selected_node):
			var ring_transform := selected_node.transform
			var ring_parent := selected_node.get_parent() as Node3D
			if ring_parent != null and ring_parent != model_3d:
				ring_transform = ring_parent.transform * ring_transform
			var ring_basis := ring_transform.basis.orthonormalized()
			editor_selection_ring.visible = true
			editor_selection_ring.position = (
				ring_transform.origin
				+ ring_basis.y.normalized() * 0.015
			)
			editor_selection_ring.basis = ring_basis.scaled(
				Vector3.ONE * 1.2
			)
			return
	if String(record.get("layout_mode", "sphere")) == "plane":
		editor_selection_ring.visible = true
		var plane_normal := (
			(record.get("placement_plane_normal", Vector3.UP) as Vector3).normalized()
		)
		editor_selection_ring.position = (
			(record.position as Vector3)
			+ plane_normal * (
				float(record.get("placement_height_offset", 0.0)) + 0.012
			)
		)
		editor_selection_ring.basis = (
			_normal_surface_basis(plane_normal, 0.0).scaled(Vector3.ONE * 1.2)
		)
		return
	var normal: Vector3 = (record.normal as Vector3).normalized()
	editor_selection_ring.visible = true
	editor_selection_ring.position = normal * (
		float(record.get("root_radius", 2.02)) + 0.012
	)
	editor_selection_ring.basis = _normal_surface_basis(normal, 0.0).scaled(Vector3.ONE * 1.25)


func _start_editor_object_drag(screen_position: Vector2) -> bool:
	if editable_3d_objects.is_empty():
		return false
	var picked := _pick_editable_object(screen_position)
	if picked < 0:
		return false
	selected_editable_index = picked
	editor_object_select.select(picked)
	_sync_editor_controls()
	_update_editor_selection_ring()
	editor_dragging_object = true
	editor_drag_travel = 0.0
	var record: Dictionary = editable_3d_objects[picked]
	if bool(record.get("locked", false)):
		_editor_set_status("“%s”的位置已锁定，先解锁再拖动。" % String(record.label))
	return true


func _pick_editable_object(
	screen_position: Vector2,
	player_placement_only := false
) -> int:
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var planet_hit := INF
	var planet_base_root := model_3d.find_child("PlanetBase", true, false)
	var planet_base: MeshInstance3D = null
	if planet_base_root != null:
		var base_meshes := planet_base_root.find_children("*", "MeshInstance3D", true, false)
		if not base_meshes.is_empty():
			planet_base = base_meshes[0] as MeshInstance3D
	if planet_base != null and current_3d_scene != "king":
		var planet_aabb := planet_base.global_transform * planet_base.get_aabb()
		if _ray_aabb_distance(ray_origin, ray_direction, planet_aabb) != INF:
			var planet_radius := minf(
				planet_aabb.size.x,
				minf(planet_aabb.size.y, planet_aabb.size.z)
			) * 0.5
			planet_hit = _ray_sphere_distance(
				ray_origin,
				ray_direction,
				planet_aabb.get_center(),
				planet_radius
			)
	var best_index := -1
	var best_distance := INF
	var best_mesh_index := -1
	var best_mesh_distance := INF
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		if player_placement_only and not _is_player_plane_record(record):
			continue
		var node := record.node as Node3D
		if node == null or not node.visible:
			continue
		var object_hit := _object_ray_hit_distance(
			node,
			ray_origin,
			ray_direction
		)
		if (
			object_hit != INF
			and (planet_hit == INF or object_hit <= planet_hit + 0.08)
			and object_hit < best_mesh_distance
		):
			best_mesh_distance = object_hit
			best_mesh_index = index
		var world_bounds := _editable_world_bounds(node)
		if world_bounds.size == Vector3.ZERO:
			continue
		var object_center := world_bounds.get_center()
		var screen_point := camera_3d.unproject_position(object_center)
		var horizontal_radius := camera_3d.unproject_position(
			object_center + camera_3d.global_basis.x * world_bounds.size.x * 0.5
		).distance_to(screen_point)
		var vertical_radius := camera_3d.unproject_position(
			object_center + camera_3d.global_basis.y * world_bounds.size.y * 0.5
		).distance_to(screen_point)
		var screen_radius := maxf(horizontal_radius, vertical_radius)
		var screen_distance := screen_point.distance_to(screen_position)
		var hit_radius := clampf(screen_radius * 0.95, 12.0, 110.0)
		if screen_distance > hit_radius:
			continue
		var center_distance := (object_center - ray_origin).dot(ray_direction)
		if planet_hit < INF and center_distance > planet_hit + 1.35:
			continue
		if screen_distance < best_distance:
			best_distance = screen_distance
			best_index = index
	return best_mesh_index if best_mesh_index >= 0 else best_index


func _editable_world_bounds(node: Node3D) -> AABB:
	var bounds := AABB()
	var has_bounds := false
	for item in node.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.has_meta("player_light_footprint"):
			continue
		if mesh_instance.mesh == null:
			continue
		var world_bounds := mesh_instance.global_transform * mesh_instance.get_aabb()
		bounds = world_bounds if not has_bounds else bounds.merge(world_bounds)
		has_bounds = true
	return bounds


func _object_ray_hit_distance(node: Node3D, ray_origin: Vector3, ray_direction: Vector3) -> float:
	var best_hit := INF
	for item in node.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.has_meta("player_light_footprint"):
			continue
		if mesh_instance.mesh == null:
			continue
		var world_bounds := mesh_instance.global_transform * mesh_instance.get_aabb()
		if _ray_aabb_distance(ray_origin, ray_direction, world_bounds) == INF:
			continue
		best_hit = minf(best_hit, _mesh_ray_hit_distance(mesh_instance, ray_origin, ray_direction))
	return best_hit


func _is_main_lamp_at_screen(screen_position: Vector2) -> bool:
	if (
		current_3d_scene != "pointlighter"
		or main_lamp_node == null
		or not main_lamp_node.visible
		or camera_3d == null
	):
		return false
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var lamp_distance := _object_ray_hit_distance(
		main_lamp_node,
		ray_origin,
		ray_direction
	)
	if lamp_distance == INF:
		return false
	var planet_base_root := model_3d.find_child("PlanetBase", true, false)
	if planet_base_root != null:
		var planet_meshes := planet_base_root.find_children("*", "MeshInstance3D", true, false)
		if not planet_meshes.is_empty():
			var planet_mesh := planet_meshes[0] as MeshInstance3D
			var planet_bounds := planet_mesh.global_transform * planet_mesh.get_aabb()
			var planet_radius := minf(
				planet_bounds.size.x,
				minf(planet_bounds.size.y, planet_bounds.size.z)
			) * 0.5
			var planet_distance := _ray_sphere_distance(
				ray_origin,
				ray_direction,
				planet_bounds.get_center(),
				planet_radius
			)
			if planet_distance < lamp_distance - 0.025:
				return false
	return true


func _toggle_main_lamp() -> void:
	main_lamp_on = not main_lamp_on
	main_lamp_target_level = 1.0 if main_lamp_on else 0.0
	model_spin_velocity = Vector2.ZERO


func _mesh_ray_hit_distance(
	mesh_instance: MeshInstance3D,
	ray_origin: Vector3,
	ray_direction: Vector3
) -> float:
	var inverse_transform := mesh_instance.global_transform.affine_inverse()
	var local_origin := inverse_transform * ray_origin
	var local_direction := (inverse_transform.basis * ray_direction).normalized()
	var best_world_hit := INF
	for surface_index in mesh_instance.mesh.get_surface_count():
		var arrays := mesh_instance.mesh.surface_get_arrays(surface_index)
		var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		var indices_value = arrays[Mesh.ARRAY_INDEX]
		if indices_value == null or indices_value.size() == 0:
			for vertex_index in range(0, vertices.size() - 2, 3):
				var hit := _ray_triangle_distance(
					local_origin,
					local_direction,
					vertices[vertex_index],
					vertices[vertex_index + 1],
					vertices[vertex_index + 2]
				)
				if hit != INF:
					var world_hit := mesh_instance.global_transform * (local_origin + local_direction * hit)
					best_world_hit = minf(best_world_hit, ray_origin.distance_to(world_hit))
		else:
			var indices: PackedInt32Array = indices_value
			for index in range(0, indices.size() - 2, 3):
				var hit := _ray_triangle_distance(
					local_origin,
					local_direction,
					vertices[indices[index]],
					vertices[indices[index + 1]],
					vertices[indices[index + 2]]
				)
				if hit != INF:
					var world_hit := mesh_instance.global_transform * (local_origin + local_direction * hit)
					best_world_hit = minf(best_world_hit, ray_origin.distance_to(world_hit))
	return best_world_hit


func _ray_triangle_distance(
	ray_origin: Vector3,
	ray_direction: Vector3,
	a: Vector3,
	b: Vector3,
	c: Vector3
) -> float:
	var edge_a := b - a
	var edge_b := c - a
	var p_vector := ray_direction.cross(edge_b)
	var determinant := edge_a.dot(p_vector)
	if absf(determinant) < 0.0000001:
		return INF
	var inverse_determinant := 1.0 / determinant
	var t_vector := ray_origin - a
	var u := t_vector.dot(p_vector) * inverse_determinant
	if u < 0.0 or u > 1.0:
		return INF
	var q_vector := t_vector.cross(edge_a)
	var v := ray_direction.dot(q_vector) * inverse_determinant
	if v < 0.0 or u + v > 1.0:
		return INF
	var distance := edge_b.dot(q_vector) * inverse_determinant
	return distance if distance > 0.0001 else INF


func _ray_aabb_distance(ray_origin: Vector3, ray_direction: Vector3, bounds: AABB) -> float:
	var tmin := 0.0
	var tmax := INF
	for axis in 3:
		var origin_component := ray_origin[axis]
		var direction_component := ray_direction[axis]
		var min_component := bounds.position[axis]
		var max_component := bounds.end[axis]
		if absf(direction_component) < 0.000001:
			if origin_component < min_component or origin_component > max_component:
				return INF
			continue
		var first := (min_component - origin_component) / direction_component
		var second := (max_component - origin_component) / direction_component
		if first > second:
			var swap_value := first
			first = second
			second = swap_value
		tmin = maxf(tmin, first)
		tmax = minf(tmax, second)
		if tmin > tmax:
			return INF
	return tmin if tmax >= 0.0 else INF


func _ray_sphere_distance(
	ray_origin: Vector3,
	ray_direction: Vector3,
	sphere_center: Vector3,
	sphere_radius: float
) -> float:
	var offset := ray_origin - sphere_center
	var b := offset.dot(ray_direction)
	var c := offset.length_squared() - sphere_radius * sphere_radius
	var discriminant := b * b - c
	if discriminant < 0.0:
		return INF
	var near_distance := -b - sqrt(discriminant)
	if near_distance > 0.0:
		return near_distance
	var far_distance := -b + sqrt(discriminant)
	return far_distance if far_distance > 0.0 else INF


func _ensure_player_record_height_fields(record: Dictionary) -> void:
	if not _is_player_plane_record(record):
		return
	var kind := String(record.get("kind", ""))
	var is_support_snapped := not String(
		record.get("placement_support_id", "")
	).is_empty()
	var active_height := float(record.get("placement_height_offset", 0.0))
	if bool(record.get("placement_height_locked", false)):
		if record.has("locked_ground_height_offset"):
			record["ground_height_offset"] = float(
				record.locked_ground_height_offset
			)
		if record.has("locked_support_height_offset"):
			record["support_height_offset"] = float(
				record.locked_support_height_offset
			)
	if not record.has("ground_height_offset"):
		record["ground_height_offset"] = float(
			player_asset_height_offsets.get(
				kind,
				active_height if not is_support_snapped else 0.0
			)
		)
	if not record.has("support_height_offset"):
		record["support_height_offset"] = float(
			player_asset_support_height_offsets.get(
				kind,
				active_height if is_support_snapped else 0.0
			)
		)


func _player_record_height_for_context(
	record: Dictionary,
	on_support: bool
) -> float:
	_ensure_player_record_height_fields(record)
	var field := (
		"support_height_offset" if on_support else "ground_height_offset"
	)
	return clampf(
		float(record.get(field, 0.0)),
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)


func _set_player_record_height_for_context(
	record: Dictionary,
	on_support: bool,
	height_offset: float,
	update_default := true
) -> void:
	if (
		update_default
		and bool(record.get("placement_height_locked", false))
	):
		return
	var kind := String(record.get("kind", ""))
	var clamped_height := clampf(
		height_offset,
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	record[
		"support_height_offset" if on_support else "ground_height_offset"
	] = clamped_height
	record["placement_height_offset"] = clamped_height
	if update_default:
		if on_support:
			player_asset_support_height_offsets[kind] = clamped_height
		else:
			player_asset_height_offsets[kind] = clamped_height


func _move_selected_editable_to_pointer(screen_position: Vector2) -> void:
	if selected_editable_index < 0 or selected_editable_index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if bool(record.get("locked", false)):
		return
	if String(record.get("layout_mode", "sphere")) == "plane":
		if (
			current_3d_scene == "player"
			and record.has("placement_plane_normal")
		):
			var exclude_support_node: Node = null
			if _is_player_support_surface_kind(
				String(record.get("kind", ""))
			):
				exclude_support_node = record.get("node") as Node3D
			var support_hit := _player_support_surface_hit(
				screen_position,
				exclude_support_node,
				String(record.get("kind", ""))
			)
			var lands_on_support := not support_hit.is_empty()
			var target_height := _player_record_height_for_context(
				record,
				lands_on_support
			)
			var placement_transform := _player_placement_transform(
				screen_position,
				float(record.get("yaw", 0.0)),
				float(record.get("placement_footprint", 0.10)),
				0.0,
				exclude_support_node,
				not _is_player_support_surface_kind(
					String(record.get("kind", ""))
				),
				String(record.get("kind", ""))
			)
			record["position"] = placement_transform.origin
			record["normal"] = placement_transform.basis.y.normalized()
			record["placement_plane_normal"] = (
				placement_transform.basis.y.normalized()
			)
			_assign_player_placement_support(
				record,
				screen_position,
				exclude_support_node
			)
			_set_player_record_height_for_context(
				record,
				not String(record.get("placement_support_id", "")).is_empty(),
				target_height,
				false
			)
			_apply_editable_3d_record(selected_editable_index)
			_sync_editor_controls()
			_update_editor_selection_ring()
			_sync_player_place_height_control()
			return
		var current_position: Vector3 = record.position
		var target_position := _screen_position_to_horizontal_plane(
			screen_position,
			current_position.y
		)
		if target_position == Vector3.INF:
			return
		record["position"] = target_position
		_apply_editable_3d_record(selected_editable_index)
		_sync_editor_controls()
		return
	var normal := _screen_position_to_planet_normal(screen_position)
	if normal == Vector3.ZERO:
		return
	record["normal"] = normal
	_apply_editable_3d_record(selected_editable_index)
	_sync_editor_controls()


func _screen_position_to_player_placement_plane(screen_position: Vector2) -> Vector3:
	if not player_placement_plane_ready or camera_3d == null or model_3d == null:
		return player_placement_plane_center
	var world_origin := camera_3d.project_ray_origin(screen_position)
	var world_direction := camera_3d.project_ray_normal(screen_position)
	var inverse_model := model_3d.global_transform.affine_inverse()
	var origin := inverse_model * world_origin
	var direction := (inverse_model.basis * world_direction).normalized()
	var denominator := direction.dot(player_placement_plane_normal)
	if absf(denominator) < 0.00001:
		return player_placement_plane_center
	var distance := (
		(player_placement_plane_center - origin).dot(player_placement_plane_normal)
		/ denominator
	)
	if distance <= 0.0:
		return player_placement_plane_center
	return _clamp_player_placement_plane_position(
		origin + direction * distance
	)


func _player_surface_hit(screen_position: Vector2) -> Dictionary:
	if camera_3d == null or model_3d == null or camera_3d.get_world_3d() == null:
		return {}
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var query := PhysicsRayQueryParameters3D.create(
		ray_origin,
		ray_origin + ray_direction * 80.0,
		1 << 18
	)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	var result: Dictionary = (
		camera_3d.get_world_3d().direct_space_state.intersect_ray(query)
	)
	if result.is_empty():
		return {}
	var inverse_root := model_3d.global_transform.affine_inverse()
	var local_position: Vector3 = inverse_root * (result.position as Vector3)
	var local_normal := (
		inverse_root.basis.transposed() * (result.normal as Vector3)
	).normalized()
	return {
		"position": local_position,
		"normal": _align_player_surface_normal(local_normal),
	}


func _align_player_surface_normal(normal: Vector3) -> Vector3:
	var aligned := normal.normalized()
	if aligned.length_squared() < 0.0001:
		return player_placement_plane_normal
	if aligned.dot(player_placement_plane_normal) < 0.0:
		aligned = -aligned
	if aligned.dot(player_placement_plane_normal) < 0.20:
		return player_placement_plane_normal
	return aligned


func _player_surface_sample_at_position(
	position: Vector3,
	footprint_radius: float
) -> Dictionary:
	if (
		camera_3d == null
		or model_3d == null
		or camera_3d.get_world_3d() == null
	):
		return {}
	var inverse_root := model_3d.global_transform.affine_inverse()
	var base_normal_world := (
		model_3d.global_transform.basis * player_placement_plane_normal
	).normalized()
	var center_world := model_3d.global_transform * position
	var query := PhysicsRayQueryParameters3D.create(
		center_world + base_normal_world * 1.2,
		center_world - base_normal_world * 1.2,
		1 << 18
	)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.hit_from_inside = true
	var result: Dictionary = (
		camera_3d.get_world_3d().direct_space_state.intersect_ray(query)
	)
	if result.is_empty():
		return {}
	var surface_position: Vector3 = inverse_root * (result.position as Vector3)
	var smoothed_normal := _player_surface_normal_at_position(
		surface_position,
		footprint_radius
	)
	return {
		"position": surface_position,
		"normal": smoothed_normal,
	}


func _player_surface_normal_at_position(
	position: Vector3,
	footprint_radius: float
) -> Vector3:
	if (
		camera_3d == null
		or model_3d == null
		or camera_3d.get_world_3d() == null
	):
		return player_placement_plane_normal
	var inverse_root := model_3d.global_transform.affine_inverse()
	var base_normal_world := (
		model_3d.global_transform.basis * player_placement_plane_normal
	).normalized()
	var center_world := model_3d.global_transform * position
	var center_query := PhysicsRayQueryParameters3D.create(
		center_world + base_normal_world * 0.8,
		center_world - base_normal_world * 0.8,
		1 << 18
	)
	center_query.collide_with_areas = false
	var center_hit: Dictionary = (
		camera_3d.get_world_3d().direct_space_state.intersect_ray(
			center_query
		)
	)
	if center_hit.is_empty():
		return player_placement_plane_normal
	var center_normal := _align_player_surface_normal(
		(
			inverse_root.basis.transposed()
			* (center_hit.normal as Vector3)
		).normalized()
	)
	var sample_radius := maxf(footprint_radius, 0.045)
	var tangent_basis := _normal_surface_basis(center_normal, 0.0)
	var right_world := (
		model_3d.global_transform.basis * tangent_basis.x
	).normalized()
	var forward_world := (
		model_3d.global_transform.basis * tangent_basis.z
	).normalized()
	var normal_sum := center_normal * 2.0
	var normal_weight := 2.0
	var offsets := [
		right_world * sample_radius,
		-right_world * sample_radius,
		forward_world * sample_radius,
		-forward_world * sample_radius,
		(right_world + forward_world) * sample_radius * 0.7071,
		(right_world - forward_world) * sample_radius * 0.7071,
		(-right_world + forward_world) * sample_radius * 0.7071,
		(-right_world - forward_world) * sample_radius * 0.7071,
	]
	var surface_samples: Array[Vector3] = []
	var surface_sample_valid: Array[bool] = []
	surface_samples.resize(offsets.size())
	surface_sample_valid.resize(offsets.size())
	for sample_index in offsets.size():
		surface_sample_valid[sample_index] = false
		var offset: Vector3 = offsets[sample_index]
		var sample_center: Vector3 = center_world + (offset as Vector3)
		var sample_query := PhysicsRayQueryParameters3D.create(
			sample_center + base_normal_world * 0.8,
			sample_center - base_normal_world * 0.8,
			1 << 18
		)
		sample_query.collide_with_areas = false
		var sample: Dictionary = (
			camera_3d.get_world_3d().direct_space_state.intersect_ray(
				sample_query
			)
		)
		if sample.is_empty():
			continue
		surface_samples[sample_index] = inverse_root * (sample.position as Vector3)
		surface_sample_valid[sample_index] = true
		var sample_normal := (
			inverse_root.basis.transposed()
			* (sample.normal as Vector3)
		).normalized()
		sample_normal = _align_player_surface_normal(sample_normal)
		if sample_normal.dot(center_normal) < 0.55:
			continue
		normal_sum += sample_normal
		normal_weight += 1.0
	var surface_normal := _align_player_surface_normal(normal_sum / normal_weight)
	if (
		surface_sample_valid.size() >= 4
		and surface_sample_valid[0]
		and surface_sample_valid[1]
		and surface_sample_valid[2]
		and surface_sample_valid[3]
	):
		var tangent_right := surface_samples[0] - surface_samples[1]
		var tangent_forward := surface_samples[2] - surface_samples[3]
		if (
			tangent_right.length_squared() > 0.000001
			and tangent_forward.length_squared() > 0.000001
		):
			surface_normal = _align_player_surface_normal(
				tangent_right.cross(tangent_forward)
			)
	return surface_normal


func _player_placement_transform(
	screen_position: Vector2,
	yaw: float,
	footprint_radius: float,
	height_offset := 0.0,
	exclude_support_node: Node = null,
	allow_support_snap := true,
	placement_kind := ""
) -> Transform3D:
	var support_hit := (
		_player_support_surface_hit(
			screen_position,
			exclude_support_node,
			placement_kind
		)
		if allow_support_snap
		else {}
	)
	if not support_hit.is_empty():
		var support_normal: Vector3 = support_hit.normal
		var support_position: Vector3 = support_hit.position
		return Transform3D(
			_normal_surface_basis(support_normal, yaw),
			support_position
				+ support_normal
					* (PLAYER_SUPPORT_SURFACE_CLEARANCE + height_offset)
		)
	var hit := _player_surface_hit(screen_position)
	if hit.is_empty():
		return Transform3D(
			_normal_surface_basis(player_placement_plane_normal, yaw),
			_screen_position_to_player_placement_plane(screen_position)
				+ player_placement_plane_normal * (0.018 + height_offset)
		)
	var center_position: Vector3 = hit.position
	var center_normal: Vector3 = (hit.normal as Vector3).normalized()
	var max_height := 0.0
	var normal_sum := center_normal * 2.0
	var normal_weight := 2.0
	var surface_samples: Array[Vector3] = []
	var surface_sample_valid: Array[bool] = []
	var sample_radius := maxf(footprint_radius, 0.0)
	if sample_radius > 0.001:
		var base_normal_world := (
			model_3d.global_transform.basis
			* player_placement_plane_normal
		).normalized()
		var tangent_basis := _normal_surface_basis(center_normal, 0.0)
		var right_world := (
			model_3d.global_transform.basis * tangent_basis.x
		).normalized()
		var forward_world := (
			model_3d.global_transform.basis * tangent_basis.z
		).normalized()
		var center_world: Vector3 = (
			model_3d.global_transform * center_position
		)
		var offsets := [
			right_world * sample_radius,
			-right_world * sample_radius,
			forward_world * sample_radius,
			-forward_world * sample_radius,
			(right_world + forward_world) * sample_radius * 0.7071,
			(right_world - forward_world) * sample_radius * 0.7071,
			(-right_world + forward_world) * sample_radius * 0.7071,
			(-right_world - forward_world) * sample_radius * 0.7071,
		]
		surface_samples.resize(offsets.size())
		surface_sample_valid.resize(offsets.size())
		for sample_index in offsets.size():
			surface_sample_valid[sample_index] = false
			var offset: Vector3 = offsets[sample_index]
			var sample_center: Vector3 = center_world + (offset as Vector3)
			var sample_query := PhysicsRayQueryParameters3D.create(
				sample_center + base_normal_world * 0.8,
				sample_center - base_normal_world * 0.8,
				1 << 18
			)
			sample_query.collide_with_areas = false
			var sample: Dictionary = (
				camera_3d.get_world_3d().direct_space_state.intersect_ray(
					sample_query
				)
			)
			if sample.is_empty():
				continue
			var inverse_root := model_3d.global_transform.affine_inverse()
			var sample_local: Vector3 = inverse_root * (sample.position as Vector3)
			surface_samples[sample_index] = sample_local
			surface_sample_valid[sample_index] = true
			var sample_normal := (
				inverse_root.basis.transposed() * (sample.normal as Vector3)
			).normalized()
			sample_normal = _align_player_surface_normal(sample_normal)
			var sample_height := (
				(sample_local - center_position).dot(
					center_normal
				)
			)
			var allowed_height := maxf(sample_radius * 0.75, 0.08)
			if (
				sample_height >= 0.0
				and sample_height <= allowed_height
			):
				max_height = maxf(max_height, sample_height)
			if sample_normal.dot(center_normal) >= 0.55:
				normal_sum += sample_normal
				normal_weight += 1.0
	# Use a footprint-smoothed local normal so the object is perpendicular to
	# the terrain at its current position without snapping between raw facets.
	var surface_normal := _align_player_surface_normal(normal_sum / normal_weight)
	if (
		surface_sample_valid.size() >= 4
		and surface_sample_valid[0]
		and surface_sample_valid[1]
		and surface_sample_valid[2]
		and surface_sample_valid[3]
	):
		var tangent_right := surface_samples[0] - surface_samples[1]
		var tangent_forward := surface_samples[2] - surface_samples[3]
		if (
			tangent_right.length_squared() > 0.000001
			and tangent_forward.length_squared() > 0.000001
		):
			surface_normal = _align_player_surface_normal(
				tangent_right.cross(tangent_forward)
			)
	var anchor := (
		center_position
		+ center_normal * (max_height + 0.018)
		+ surface_normal * height_offset
	)
	return Transform3D(
		_normal_surface_basis(surface_normal, yaw),
		anchor
	)


func _is_player_support_surface_kind(kind: String) -> bool:
	return kind in PLAYER_SUPPORT_SURFACE_KINDS


func _can_player_asset_snap_to_support(
	asset_kind: String,
	surface_kind: String
) -> bool:
	if asset_kind.is_empty():
		return true
	if surface_kind == "player_long_table":
		return asset_kind in PLAYER_TABLE_SUPPORT_KINDS
	return true


func _player_support_surfaces(
	exclude_node: Node = null,
	placement_kind := ""
) -> Array[Dictionary]:
	var surfaces: Array[Dictionary] = []
	if current_3d_scene != "player":
		return surfaces
	for record in editable_3d_objects:
		var kind := String(record.get("kind", ""))
		if not _is_player_support_surface_kind(kind):
			continue
		if not _can_player_asset_snap_to_support(placement_kind, kind):
			continue
		var support_node := record.get("node") as Node3D
		if (
			support_node == null
			or not is_instance_valid(support_node)
			or support_node == exclude_node
			or not support_node.visible
			or bool(record.get("default_hidden", false))
		):
			continue
		var local_bounds := _node_local_bounds(support_node)
		if local_bounds.size.x <= 0.0001 or local_bounds.size.z <= 0.0001:
			continue
		var global_transform := support_node.global_transform
		var surface_basis := global_transform.basis.orthonormalized()
		var surface_normal := surface_basis.y.normalized()
		var surface_center := (
			global_transform
				* Vector3(
					local_bounds.get_center().x,
					local_bounds.end.y,
					local_bounds.get_center().z
				)
		)
		surfaces.append({
			"id": String(record.get("id", "")),
			"label": String(record.get("label", kind)),
			"node": support_node,
			"position": surface_center,
			"normal": surface_normal,
			"right": surface_basis.x.normalized(),
			"forward": surface_basis.z.normalized(),
			"half_right": (
				local_bounds.size.x
				* absf(support_node.global_transform.basis.x.length())
				* 0.5
				* PLAYER_SUPPORT_SURFACE_INSET
			),
			"half_forward": (
				local_bounds.size.z
				* absf(support_node.global_transform.basis.z.length())
				* 0.5
				* PLAYER_SUPPORT_SURFACE_INSET
			),
		})
	return surfaces


func _player_support_surface_hit(
	screen_position: Vector2,
	exclude_node: Node = null,
	placement_kind := ""
) -> Dictionary:
	if (
		current_3d_scene != "player"
		or camera_3d == null
		or model_3d == null
	):
		return {}
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(
		screen_position
	).normalized()
	var best_hit := {}
	var best_distance := INF
	for surface in _player_support_surfaces(exclude_node, placement_kind):
		var surface_normal: Vector3 = surface.normal
		var denominator := ray_direction.dot(surface_normal)
		if absf(denominator) < 0.00001:
			continue
		var distance := (
			((surface.position as Vector3) - ray_origin).dot(surface_normal)
			/ denominator
		)
		if distance <= 0.0 or distance >= best_distance:
			continue
		var hit_position := ray_origin + ray_direction * distance
		var relative := hit_position - (surface.position as Vector3)
		if (
			absf(relative.dot(surface.right as Vector3))
				> float(surface.half_right)
			or absf(relative.dot(surface.forward as Vector3))
				> float(surface.half_forward)
		):
			continue
		best_distance = distance
		best_hit = surface.duplicate()
		var inverse_root := model_3d.global_transform.affine_inverse()
		var inverse_basis := inverse_root.basis
		best_hit["world_position"] = hit_position
		best_hit["position"] = inverse_root * hit_position
		best_hit["normal"] = (
			inverse_basis * surface_normal
		).normalized()
		best_hit["right"] = (
			inverse_basis * (surface.right as Vector3)
		).normalized()
		best_hit["forward"] = (
			inverse_basis * (surface.forward as Vector3)
		).normalized()
	return best_hit


func _assign_player_placement_support(
	record: Dictionary,
	screen_position: Vector2,
	exclude_node: Node = null
) -> void:
	record.erase("placement_support_id")
	record.erase("placement_support_normal")
	if _is_player_support_surface_kind(String(record.get("kind", ""))):
		return
	var support_hit := _player_support_surface_hit(
		screen_position,
		exclude_node,
		String(record.get("kind", ""))
	)
	if support_hit.is_empty():
		return
	record["placement_support_id"] = String(support_hit.get("id", ""))
	record["placement_support_normal"] = (
		support_hit.get("normal", Vector3.UP) as Vector3
	).normalized()


func _player_disallowed_table_hit(
	screen_position: Vector2,
	asset_kind: String
) -> Dictionary:
	var raw_hit := _player_support_surface_hit(screen_position)
	if raw_hit.is_empty():
		return {}
	if (
		String(raw_hit.get("id", "")).begins_with("player_long_table")
		and not _can_player_asset_snap_to_support(asset_kind, "player_long_table")
	):
		return raw_hit
	return {}


func _project_point_to_player_placement_plane(point: Vector3) -> Vector3:
	if not player_placement_plane_ready:
		return point
	var plane_distance := (
		(point - player_placement_plane_center).dot(player_placement_plane_normal)
	)
	return _clamp_player_placement_plane_position(
		point - player_placement_plane_normal * plane_distance
	)


func _clamp_player_placement_plane_position(point: Vector3) -> Vector3:
	if not player_placement_plane_ready:
		return Vector3.ZERO
	var relative := point - player_placement_plane_center
	var right_offset := clampf(
		relative.dot(player_placement_plane_right),
		-player_placement_plane_half_right,
		player_placement_plane_half_right
	)
	var forward_offset := clampf(
		relative.dot(player_placement_plane_forward),
		-player_placement_plane_half_forward,
		player_placement_plane_half_forward
	)
	var normal_offset := relative.dot(player_placement_plane_normal)
	return (
		player_placement_plane_center
		+ player_placement_plane_right * right_offset
		+ player_placement_plane_forward * forward_offset
		+ player_placement_plane_normal * normal_offset
	)


func _screen_position_to_horizontal_plane(screen_position: Vector2, plane_y: float) -> Vector3:
	var world_origin := camera_3d.project_ray_origin(screen_position)
	var world_direction := camera_3d.project_ray_normal(screen_position)
	var inverse_model := model_3d.global_transform.affine_inverse()
	var origin := inverse_model * world_origin
	var direction := (inverse_model.basis * world_direction).normalized()
	if absf(direction.y) < 0.00001:
		return Vector3.INF
	var distance := (plane_y - origin.y) / direction.y
	if distance <= 0.0:
		return Vector3.INF
	var hit := origin + direction * distance
	var horizontal := Vector2(hit.x, hit.z).limit_length(1.35)
	return Vector3(horizontal.x, plane_y, horizontal.y)


func _screen_position_to_planet_normal(screen_position: Vector2) -> Vector3:
	var world_origin := camera_3d.project_ray_origin(screen_position)
	var world_direction := camera_3d.project_ray_normal(screen_position)
	var inverse_model := model_3d.global_transform.affine_inverse()
	var origin := inverse_model * world_origin
	var direction := (inverse_model.basis * world_direction).normalized()
	var radius := GENERATED_PLANET_RADIUS * 1.008
	var b := origin.dot(direction)
	var c := origin.length_squared() - radius * radius
	var discriminant := b * b - c
	if discriminant < 0.0:
		# Near the silhouette there is no ray-sphere intersection. Fall back to
		# the point on the ray closest to the planet centre so objects parked on
		# the crown can still be dragged beyond the visible outline.
		var closest_distance := maxf(0.0, -b)
		var closest_point := origin + direction * closest_distance
		return closest_point.normalized() if closest_point.length_squared() > 0.000001 \
			else Vector3.ZERO
	var distance := -b - sqrt(discriminant)
	if distance < 0.0:
		distance = -b + sqrt(discriminant)
	if distance < 0.0:
		return Vector3.ZERO
	return (origin + direction * distance).normalized()


func _editor_set_status(message: String) -> void:
	if editor_status_label != null:
		editor_status_label.text = message


func _save_3d_layout() -> void:
	var layout_key := _current_layout_key()
	if layout_key == "player":
		_capture_player_character_seat_poses()
	var objects: Array = []
	var player_item_heights := player_asset_height_offsets.duplicate(true)
	var player_item_support_heights := (
		player_asset_support_height_offsets.duplicate(true)
	)
	var player_item_scales := player_asset_scale_defaults.duplicate(true)
	for record in editable_3d_objects:
		var normal: Vector3 = record.normal
		var saved_record := {
			"id": String(record.id),
			"kind": String(record.kind),
			"label": String(record.label),
			"asset_path": String(record.asset_path),
			"base_scale": float(record.base_scale),
			"normal": [normal.x, normal.y, normal.z],
			"root_radius": float(record.root_radius),
			"scale": float(record.scale),
			"yaw": float(record.yaw),
			"surface_tilt": float(record.get("surface_tilt", 0.0)),
			"upright": bool(record.upright),
			"visible": not bool(record.default_hidden),
			"locked": bool(record.get("locked", false)),
			"layout_mode": String(record.get("layout_mode", "sphere")),
		}
		if String(record.get("layout_mode", "sphere")) == "plane":
			var position: Vector3 = record.position
			saved_record["position"] = [position.x, position.y, position.z]
			if record.has("placement_plane_normal"):
				var placement_normal: Vector3 = record.placement_plane_normal
				saved_record["placement_plane_normal"] = [
					placement_normal.x,
					placement_normal.y,
					placement_normal.z,
				]
			if record.has("placement_footprint"):
				saved_record["placement_footprint"] = float(
					record.placement_footprint
				)
			if record.has("placement_height_offset"):
				saved_record["placement_height_offset"] = float(
					record.placement_height_offset
				)
			if record.has("ground_height_offset"):
				saved_record["ground_height_offset"] = float(
					record.ground_height_offset
				)
			if record.has("support_height_offset"):
				saved_record["support_height_offset"] = float(
					record.support_height_offset
				)
			if record.has("placement_height_locked"):
				saved_record["placement_height_locked"] = bool(
					record.placement_height_locked
				)
			if record.has("locked_ground_height_offset"):
				saved_record["locked_ground_height_offset"] = float(
					record.locked_ground_height_offset
				)
			if record.has("locked_support_height_offset"):
				saved_record["locked_support_height_offset"] = float(
					record.locked_support_height_offset
				)
			if record.has("placement_support_id"):
				saved_record["placement_support_id"] = String(
					record.placement_support_id
				)
			if record.has("placement_support_normal"):
				var support_normal: Vector3 = record.placement_support_normal
				saved_record["placement_support_normal"] = [
					support_normal.x,
					support_normal.y,
					support_normal.z,
				]
		if record.has("light_anchor") and String(record.get("kind", "")) != KING_LIGHT_KIND:
			var light_anchor: Node3D = record.light_anchor
			saved_record["light_offset"] = [
				light_anchor.position.x,
				light_anchor.position.y,
				light_anchor.position.z,
			]
		if _is_editable_light_record(record):
			saved_record["light_on"] = bool(record.get("light_on", true))
			saved_record["brightness"] = clampf(float(record.get("brightness", 1.0)), 0.1, 2.5)
			saved_record["light_range"] = clampf(
				float(record.get("light_range", 1.0)),
				0.35,
				1.5
			)
			if String(record.get("kind", "")) == KING_LIGHT_KIND:
				saved_record["glow_point"] = true
		if record.has("selected_animation"):
			saved_record["selected_animation"] = String(
				record.selected_animation
			)
		if (
			_is_player_character_kind(String(record.get("kind", "")))
			and String(record.get("seat_state", "")) == "seated"
		):
			saved_record["seat_id"] = String(record.get("seat_id", ""))
			saved_record["seat_slot_index"] = int(
				record.get("seat_slot_index", 0)
			)
			saved_record["seat_slot_count"] = int(
				record.get("seat_slot_count", 1)
			)
		if _is_player_plane_kind(String(record.get("kind", ""))):
			var player_kind := String(record.kind)
			if (
				String(record.get("placement_support_id", "")).is_empty()
				and not player_item_heights.has(player_kind)
			):
				player_item_heights[player_kind] = float(
					record.get("placement_height_offset", 0.0)
				)
			elif (
				not String(record.get("placement_support_id", "")).is_empty()
				and not player_item_support_heights.has(player_kind)
			):
				player_item_support_heights[player_kind] = float(
					record.get("placement_height_offset", 0.0)
				)
			if not player_item_scales.has(player_kind):
				player_item_scales[player_kind] = float(record.get("scale", 1.0))
		objects.append(saved_record)
	var saved_deleted_ids: Array[String] = []
	for saved_id in deleted_editable_ids:
		if String(saved_id) not in ["player_bridge", "player_river"]:
			saved_deleted_ids.append(String(saved_id))
	var payload_data := {
		"version": 3,
		"scene_slug": layout_key,
		"objects": objects,
		"deleted_ids": saved_deleted_ids,
		"base_lighting": _planet_base_lighting_level(),
		"wheat_brightness": earth_wheat_brightness,
		"wheat_saturation": earth_wheat_saturation,
		"wheat_tone_version": EARTH_WHEAT_TONE_VERSION,
		"earth_light_yaw": earth_light_yaw,
		"player_item_heights": player_item_heights,
		"player_item_support_heights": player_item_support_heights,
		"player_item_scales": player_item_scales,
		"player_height_schema": PLAYER_HEIGHT_SCHEMA_VERSION,
		"player_item_height_lock_version": PLAYER_ITEM_HEIGHT_LOCK_VERSION,
	}
	if layout_key == "player":
		payload_data["light_strings"] = _serialize_player_light_strings()
		payload_data["player_night"] = player_day_night_target < 0.5
		payload_data["player_item_heights_locked"] = true
		payload_data["player_item_support_heights_locked"] = true
		payload_data["player_seat_pose_offsets"] = (
			player_seat_pose_offsets.duplicate(true)
		)
		payload_data["player_seat_pose_schema"] = PLAYER_SEAT_POSE_SCHEMA_VERSION
		payload_data["player_standing_height_locks"] = (
			player_standing_height_locks.duplicate(true)
		)
		payload_data["player_sitting_height_locks"] = (
			player_sitting_height_locks.duplicate(true)
		)
	var payload := JSON.stringify(payload_data, "\t")
	var user_layout_path := "user://%s_layout.json" % layout_key
	var project_layout_path := "res://%s_layout.json" % layout_key
	var user_file := FileAccess.open(user_layout_path, FileAccess.WRITE)
	var user_saved := user_file != null
	if user_file != null:
		user_file.store_string(payload)
		user_file.close()
	var project_saved := false
	var cmdline := OS.get_cmdline_args()
	var running_script_test := "--script" in cmdline or "-s" in cmdline
	var write_project_layout := (
		layout_key != "player"
		and not preview_mode_active
		and not running_script_test
		and "--test-layout-user-only" not in OS.get_cmdline_user_args()
	)
	if write_project_layout:
		var project_file := FileAccess.open(project_layout_path, FileAccess.WRITE)
		project_saved = project_file != null
		if project_file != null:
			project_file.store_string(payload)
			project_file.close()
	if not user_saved and not project_saved:
		_editor_set_status("布局保存失败：%s" % error_string(FileAccess.get_open_error()))
		return
	var saved_targets: Array[String] = []
	if user_saved:
		saved_targets.append("用户布局")
	if project_saved:
		saved_targets.append("项目布局")
	_editor_set_status(
		"已保存 %d 个对象：%s" % [objects.size(), "、".join(PackedStringArray(saved_targets))]
	)
	_request_autosave()


func _load_3d_editor_layout() -> void:
	pending_player_river_layout = {}
	var layout_key := _current_layout_key()
	var template_only := (
		layout_key == "player"
		and SaveManager.consume_player_fresh_start()
	)
	var layout_path := "user://%s_layout.json" % layout_key
	if template_only:
		layout_path = "res://player_layout.json"
	elif not FileAccess.file_exists(layout_path):
		layout_path = "res://%s_layout.json" % layout_key
	if not FileAccess.file_exists(layout_path):
		return
	var file := FileAccess.open(layout_path, FileAccess.READ)
	if file == null:
		return
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	var saved_scene_slug := String(parsed.get("scene_slug", ""))
	if not saved_scene_slug.is_empty() and saved_scene_slug != layout_key:
		push_warning(
			"Ignoring layout for %s because it belongs to %s"
			% [layout_key, saved_scene_slug]
		)
		return
	if layout_key == "player":
		player_asset_height_offsets.clear()
		player_asset_support_height_offsets.clear()
		player_asset_scale_defaults.clear()
		player_seat_pose_offsets.clear()
		player_standing_height_locks.clear()
		player_sitting_height_locks.clear()
		var saved_seat_poses = parsed.get("player_seat_pose_offsets", {})
		if typeof(saved_seat_poses) == TYPE_DICTIONARY:
			for pose_key_value in saved_seat_poses:
				var saved_pose_value = saved_seat_poses[pose_key_value]
				if typeof(saved_pose_value) != TYPE_DICTIONARY:
					continue
				var saved_pose := saved_pose_value as Dictionary
				var position_value = saved_pose.get("position", [])
				if (
					typeof(position_value) != TYPE_ARRAY
					or position_value.size() < 3
				):
					continue
				var pose_data := {
					"position": [
						float(position_value[0]),
						float(position_value[1]),
						float(position_value[2]),
					],
					"yaw_delta": float(saved_pose.get("yaw_delta", 0.0)),
				}
				if saved_pose.has("height_offset"):
					pose_data["height_offset"] = float(
						saved_pose.get("height_offset", 0.0)
					)
				player_seat_pose_offsets[String(pose_key_value)] = pose_data
		var saved_standing_locks = parsed.get(
			"player_standing_height_locks",
			{}
		)
		if typeof(saved_standing_locks) == TYPE_DICTIONARY:
			for lock_key_value in saved_standing_locks:
				player_standing_height_locks[String(lock_key_value)] = bool(
					saved_standing_locks[lock_key_value]
				)
		var saved_sitting_locks = parsed.get(
			"player_sitting_height_locks",
			{}
		)
		if typeof(saved_sitting_locks) == TYPE_DICTIONARY:
			for lock_key_value in saved_sitting_locks:
				player_sitting_height_locks[String(lock_key_value)] = bool(
					saved_sitting_locks[lock_key_value]
				)
		var saved_player_night := bool(parsed.get("player_night", false))
		player_day_night_blend = 0.0 if saved_player_night else 1.0
		player_day_night_target = player_day_night_blend
		var saved_player_heights = parsed.get("player_item_heights", {})
		if typeof(saved_player_heights) == TYPE_DICTIONARY:
			for kind_value in saved_player_heights:
				player_asset_height_offsets[String(kind_value)] = clampf(
					float(saved_player_heights[kind_value]),
					PLAYER_HEIGHT_OFFSET_MIN,
					PLAYER_HEIGHT_OFFSET_MAX
				)
		var saved_support_heights = parsed.get(
			"player_item_support_heights",
			{}
		)
		if typeof(saved_support_heights) == TYPE_DICTIONARY:
			for kind_value in saved_support_heights:
				player_asset_support_height_offsets[String(kind_value)] = clampf(
					float(saved_support_heights[kind_value]),
					PLAYER_HEIGHT_OFFSET_MIN,
					PLAYER_HEIGHT_OFFSET_MAX
				)
		var saved_player_scales = parsed.get("player_item_scales", {})
		if typeof(saved_player_scales) == TYPE_DICTIONARY:
			for kind_value in saved_player_scales:
				player_asset_scale_defaults[String(kind_value)] = clampf(
					float(saved_player_scales[kind_value]),
					0.3,
					3.0
				)
	planet_base_lighting_levels[layout_key] = clampf(
		float(parsed.get("base_lighting", 1.0)),
		PLANET_BASE_LIGHTING_MIN,
		PLANET_BASE_LIGHTING_MAX
	)
	if layout_key == "earth":
		var wheat_tone_version := int(parsed.get("wheat_tone_version", 0))
		if wheat_tone_version >= EARTH_WHEAT_TONE_VERSION:
			earth_wheat_brightness = clampf(
				float(parsed.get(
					"wheat_brightness",
					EARTH_WHEAT_DEFAULT_BRIGHTNESS
				)),
				0.60,
				1.15
			)
			earth_wheat_saturation = clampf(
				float(parsed.get(
					"wheat_saturation",
					EARTH_WHEAT_DEFAULT_SATURATION
				)),
				0.60,
				1.15
			)
		else:
			earth_wheat_brightness = EARTH_WHEAT_DEFAULT_BRIGHTNESS
			earth_wheat_saturation = EARTH_WHEAT_DEFAULT_SATURATION
		earth_light_yaw = clampf(
			float(parsed.get("earth_light_yaw", EARTH_LIGHT_DEFAULT_YAW)),
			-180.0,
			180.0
		)
	_sync_planet_base_lighting_control()
	_sync_earth_wheat_controls()
	if template_only:
		_save_onboarding_state(false)
		return
	var saved_objects = parsed.get("objects", [])
	if typeof(saved_objects) != TYPE_ARRAY:
		return
	var layout_object_total := maxi(1, saved_objects.size())
	var player_height_schema := int(parsed.get("player_height_schema", 1))
	var saved_deleted_ids = parsed.get("deleted_ids", [])
	if typeof(saved_deleted_ids) == TYPE_ARRAY:
		for saved_id in saved_deleted_ids:
			var deleted_id := String(saved_id)
			if deleted_id in ["player_bridge", "player_river"]:
				continue
			if deleted_id != "" and not deleted_editable_ids.has(deleted_id):
				deleted_editable_ids.append(deleted_id)
			_remove_editable_record_by_id(deleted_id)
	for layout_object_index in saved_objects.size():
		var saved_value = saved_objects[layout_object_index]
		_set_planet_loading_progress(
			lerpf(92.0, 99.0, float(layout_object_index) / float(layout_object_total))
		)
		await get_tree().process_frame
		if typeof(saved_value) != TYPE_DICTIONARY:
			continue
		var saved: Dictionary = saved_value
		if (
			layout_key == "player"
			and player_height_schema < PLAYER_HEIGHT_SCHEMA_VERSION
			and saved.has("placement_height_offset")
			and is_equal_approx(
				float(saved.placement_height_offset),
				VISUAL_PLANET_BASE_Y_OFFSET
			)
		):
			# Older builds could persist the planet wrapper's visual Y offset as
			# an item height. Migrate that exact legacy artifact once.
			var legacy_kind := String(saved.get("kind", ""))
			saved["placement_height_offset"] = clampf(
				float(player_asset_height_offsets.get(legacy_kind, 0.0)),
				PLAYER_HEIGHT_OFFSET_MIN,
				PLAYER_HEIGHT_OFFSET_MAX
			)
		if String(saved.get("kind", "")) == "player_bridge":
			# The bridge is now a fixed part of the player scene. Ignore older
			# editable bridge records so it can never move on scene reload.
			continue
		if String(saved.get("kind", "")) == "river":
			# The river is fixed with the player base as well.
			continue
		var record_index := _find_editable_record_index(String(saved.get("id", "")), -1)
		if (
			record_index < 0
			and String(saved.get("kind", "")) == "procedural_rose"
		):
			record_index = _find_editable_record_index_by_kind("rose_model")
		if record_index < 0:
			var player_saved_kind := String(saved.get("kind", ""))
			if _is_player_plane_kind(player_saved_kind):
				var legacy_star_kind := (
					LEGACY_STAR_PLACEABLE_KIND_MAP.has(player_saved_kind)
				)
				var star_asset := _star_backpack_asset_for_kind(
					player_saved_kind
				)
				var canonical_player_kind := String(
					star_asset.get("kind", player_saved_kind)
				)
				var player_asset_path := String(saved.get("asset_path", ""))
				if (
					star_asset.is_empty()
					and (
						player_asset_path.is_empty()
						or not ResourceLoader.exists(player_asset_path)
					)
				):
					continue
				var player_position := _player_plane_position_from_saved(saved)
				var player_yaw := float(saved.get("yaw", 0.0))
				var player_basis := _normal_surface_basis(
					player_placement_plane_normal,
					player_yaw
				)
				var player_node: Node3D
				var saved_player_base_scale := float(
					saved.get("base_scale", 1.0)
				)
				var player_definition := star_asset
				if player_definition.is_empty():
					player_definition = _player_asset_definition_for_kind(
						canonical_player_kind
					)
				var use_fitted_player_asset := (
					star_asset.is_empty()
					and not player_definition.is_empty()
					and is_equal_approx(saved_player_base_scale, 1.0)
				)
				var player_base_scale := saved_player_base_scale
				if star_asset.is_empty() and not use_fitted_player_asset:
					player_node = _add_generated_part(
						model_3d,
						player_asset_path,
						"Layout_%s_%02d" % [
							player_saved_kind,
							editable_serial + 1,
						],
						Transform3D(player_basis, player_position),
						player_base_scale
					)
				else:
					player_base_scale = 1.0
					player_asset_path = String(player_definition.path)
					player_node = _add_player_asset_fitted(
						model_3d,
						player_definition,
						"Layout_%s_%02d" % [
							canonical_player_kind,
							editable_serial + 1,
						],
						Transform3D(player_basis, player_position),
						float(player_definition.get("extent", 0.7))
					)
				if player_node == null:
					continue
				_prepare_player_person_animations(
					player_node,
					canonical_player_kind
				)
				_configure_player_asset_light(
					player_node,
					player_definition
				)
				player_node.visible = bool(saved.get("visible", true))
				var player_label := String(saved.get("label", "物件"))
				if legacy_star_kind:
					player_label = String(star_asset.label)
				_register_editable_3d(
					player_node,
					canonical_player_kind,
					player_label,
					player_placement_plane_normal,
					0.0,
					true,
					player_yaw,
					player_base_scale,
					player_asset_path,
					not bool(saved.get("visible", true))
				)
				record_index = editable_3d_objects.size() - 1
				editable_3d_objects[record_index]["id"] = String(saved.id)
				editable_3d_objects[record_index]["label"] = player_label
			if (
				record_index < 0
				and String(saved.get("layout_mode", "sphere")) == "plane"
			):
				var position_value = saved.get("position", [])
				var asset_path := String(saved.get("asset_path", ""))
				if typeof(position_value) != TYPE_ARRAY or position_value.size() < 3:
					continue
				var position := Vector3(
					float(position_value[0]),
					float(position_value[1]),
					float(position_value[2])
				)
				var saved_kind := String(saved.get("kind", "king_prop"))
				var rigged_override := _rigged_character_asset_for_kind(
					saved_kind
				)
				if not rigged_override.is_empty():
					asset_path = rigged_override
				var plane_node: Node3D
				if saved_kind == KING_LIGHT_KIND:
					plane_node = _add_king_light(
						position,
						float(saved.get("yaw", 0.0)),
						bool(saved.get("light_on", true))
					)
				elif asset_path != "" and ResourceLoader.exists(asset_path):
					plane_node = _add_king_part(
						asset_path,
						saved_kind,
						String(saved.get("label", "物件")),
						position,
						float(saved.get("base_scale", 1.0)),
						float(saved.get("yaw", 0.0))
					)
				if plane_node == null:
					continue
				record_index = editable_3d_objects.size() - 1
				editable_3d_objects[record_index]["id"] = String(saved.id)
				editable_3d_objects[record_index]["label"] = (
					"发光点位" + (" 副本" if String(saved.label).ends_with(" 副本") else "")
					if saved_kind == KING_LIGHT_KIND
					else String(saved.label)
				)
			elif record_index < 0:
				var normal_value = saved.get("normal", [])
				if typeof(normal_value) != TYPE_ARRAY or normal_value.size() < 3:
					continue
				var normal := Vector3(
					float(normal_value[0]),
					float(normal_value[1]),
					float(normal_value[2])
				).normalized()
				var asset_path := String(saved.get("asset_path", ""))
				var saved_kind := String(saved.get("kind", "prop"))
				var rigged_override := _rigged_character_asset_for_kind(
					saved_kind
				)
				if not rigged_override.is_empty():
					asset_path = rigged_override
				var wrapper: Node3D
				if saved_kind == KING_LIGHT_KIND:
					var glow_radius := float(
						saved.get("root_radius", _default_glow_point_radius())
					)
					wrapper = _add_king_light(
						normal * glow_radius,
						float(saved.get("yaw", 0.0)),
						bool(saved.get("light_on", true)),
						"sphere",
						normal,
						glow_radius
					)
				elif saved_kind == "procedural_rose" and asset_path == "":
					var rose_path := ROSE_3D_DIR + "rose_model.glb"
					var surface_point := normal * float(saved.get("root_radius", 2.35))
					wrapper = _add_generated_part_fitted(
						model_3d,
						rose_path,
						"Layout_rose_model_" + str(editable_serial + 1),
						Transform3D(
							_normal_surface_basis(normal, float(saved.get("yaw", 0.0))),
							surface_point
						),
						0.95
					)
					if wrapper != null:
						wrapper.visible = bool(saved.get("visible", true))
						_register_editable_3d(
							wrapper,
							"rose_model",
							String(saved.get("label", "玫瑰")),
							normal,
							float(saved.get("root_radius", 2.35)),
							true,
							float(saved.get("yaw", 0.0)),
							float(wrapper.get_meta("generated_part_scale", 1.0)),
							rose_path,
							not bool(saved.get("visible", true))
						)
				elif asset_path != "" and ResourceLoader.exists(asset_path):
					wrapper = _place_layout_asset(
						saved_kind,
						String(saved.get("label", "对象")),
						asset_path,
						normal,
						float(saved.get("base_scale", 1.0)),
						bool(saved.get("upright", false)),
						float(saved.get("root_radius", 2.0)),
						float(saved.get("yaw", 0.0)),
						not bool(saved.get("visible", true))
					)
				if wrapper == null:
					continue
				record_index = editable_3d_objects.size() - 1
				editable_3d_objects[record_index]["id"] = String(saved.id)
				editable_3d_objects[record_index]["label"] = String(saved.label)
		if record_index < 0:
			continue
		var record: Dictionary = editable_3d_objects[record_index]
		var record_kind := String(record.get("kind", ""))
		if _is_player_plane_kind(record_kind):
			if _is_player_character_kind(record_kind):
				if saved.has("seat_id"):
					record["seat_id"] = String(saved.get("seat_id", ""))
					record["seat_slot_index"] = int(
						saved.get("seat_slot_index", 0)
					)
					record["seat_slot_count"] = int(
						saved.get("seat_slot_count", 1)
					)
				if saved.has("selected_animation"):
					record["selected_animation"] = String(
						saved.get("selected_animation", "")
					)
					record["initial_selected_animation"] = String(
						record.selected_animation
					)
			_apply_saved_player_plane_record(record_index, saved)
			if (
				_is_player_character_kind(record_kind)
				and record.has("selected_animation")
			):
				_apply_character_animation_choice(
					record.node as Node3D,
					String(record.selected_animation),
					true
				)
			continue
		var rigged_asset := _rigged_character_asset_for_kind(
			String(record.get("kind", ""))
		)
		if not rigged_asset.is_empty():
			record["asset_path"] = rigged_asset
		var force_prince_idle := (
			record_kind in PRINCE_CHARACTER_KINDS
			and record_kind != "player_prince"
		)
		var force_vain_dance := record_kind == "vain_character"
		if (
			force_prince_idle
			or force_vain_dance
			or saved.has("selected_animation")
		):
			var selected_animation := (
				VAIN_DANCE_CLIP
				if force_vain_dance
				else (
					"ambient_idle"
					if force_prince_idle
					else String(saved.get("selected_animation", ""))
				)
			)
			if not selected_animation.is_empty():
				record["selected_animation"] = selected_animation
				record["initial_selected_animation"] = selected_animation
				_apply_character_animation_choice(
					record.node as Node3D,
					selected_animation,
					true
				)
		if saved.has("locked"):
			record["locked"] = bool(saved.locked)
		if saved.has("surface_tilt"):
			record["surface_tilt"] = clampf(
				float(saved.surface_tilt),
				-60.0,
				60.0
			)
		if String(record.get("kind", "")) in ALWAYS_SURFACE_UPRIGHT_KINDS:
			record["surface_tilt"] = 0.0
			record["initial_surface_tilt"] = 0.0
		if String(record.get("layout_mode", "sphere")) == "plane":
			var position_value = saved.get("position", [])
			if typeof(position_value) == TYPE_ARRAY and position_value.size() >= 3:
				record["position"] = Vector3(
					float(position_value[0]),
					float(position_value[1]),
					float(position_value[2])
				)
			record["normal"] = Vector3.UP
			record["initial_normal"] = Vector3.UP
			record["root_radius"] = (record.position as Vector3).y
			record["initial_root_radius"] = (record.initial_position as Vector3).y
			if saved.has("scale"):
				record["scale"] = float(saved.scale)
			if saved.has("yaw"):
				record["yaw"] = float(saved.yaw)
			if saved.has("visible"):
				record["default_hidden"] = not bool(saved.visible)
			(record.node as Node3D).visible = not bool(record.default_hidden)
			var plane_light_offset = saved.get("light_offset", [])
			if (
				typeof(plane_light_offset) == TYPE_ARRAY
				and plane_light_offset.size() >= 3
				and record.has("light_anchor")
				and String(record.get("kind", "")) != KING_LIGHT_KIND
			):
				(record.light_anchor as Node3D).position = Vector3(
					float(plane_light_offset[0]),
					float(plane_light_offset[1]),
					float(plane_light_offset[2])
				)
			_apply_editable_3d_record(record_index)
			if String(record.get("kind", "")) == KING_LIGHT_KIND:
				var loaded_light_on := bool(saved.get("light_on", true))
				var loaded_brightness := clampf(float(saved.get("brightness", 1.0)), 0.1, 2.5)
				var loaded_light_range := clampf(
					float(saved.get("light_range", 1.0)),
					0.35,
					1.5
				)
				record["light_on"] = loaded_light_on
				record["initial_light_on"] = loaded_light_on
				record["brightness"] = loaded_brightness
				record["initial_brightness"] = loaded_brightness
				record["light_range"] = loaded_light_range
				record["initial_light_range"] = loaded_light_range
				(record.light_anchor as Node3D).position = Vector3.ZERO
				_set_king_light_state(record_index, loaded_light_on, false)
			continue
		var normal_value = saved.get("normal", [])
		if typeof(normal_value) == TYPE_ARRAY and normal_value.size() >= 3:
			record["normal"] = Vector3(
				float(normal_value[0]),
				float(normal_value[1]),
				float(normal_value[2])
			).normalized()
		if saved.has("root_radius"):
			var loaded_radius := maxf(float(saved.root_radius), GENERATED_PLANET_RADIUS)
			record["root_radius"] = loaded_radius
			record["initial_root_radius"] = maxf(
				float(record.initial_root_radius),
				loaded_radius
			)
		if saved.has("scale"):
			record["scale"] = float(saved.scale)
		if saved.has("yaw"):
			record["yaw"] = float(saved.yaw)
		if saved.has("visible"):
			record["default_hidden"] = not bool(saved.visible)
		var light_offset_value = saved.get("light_offset", [])
		if (
			typeof(light_offset_value) == TYPE_ARRAY
			and light_offset_value.size() >= 3
			and record.has("light_anchor")
		):
			(record.light_anchor as Node3D).position = Vector3(
				float(light_offset_value[0]),
				float(light_offset_value[1]),
				float(light_offset_value[2])
			)
		if _is_editable_light_record(record):
			var loaded_light_on := bool(saved.get("light_on", true))
			var loaded_brightness := clampf(
				float(saved.get("brightness", 1.0)),
				0.1,
				2.5
			)
			var loaded_light_range := clampf(
				float(saved.get("light_range", 1.0)),
				0.35,
				1.5
			)
			record["light_on"] = loaded_light_on
			record["initial_light_on"] = loaded_light_on
			record["brightness"] = loaded_brightness
			record["initial_brightness"] = loaded_brightness
			record["light_range"] = loaded_light_range
			record["initial_light_range"] = loaded_light_range
			_set_king_light_state(record_index, loaded_light_on, false)
		(record.node as Node3D).visible = not bool(record.default_hidden)
		_apply_editable_3d_record(record_index)
	if layout_key == "player":
		_restore_required_player_seats()
		_load_player_light_strings(parsed.get("light_strings", []))


func _is_player_plane_kind(kind: String) -> bool:
	return (
		current_3d_scene == "player"
		and (kind == "player_bridge" or kind.begins_with("player_"))
	)


func _player_plane_position_from_saved(saved: Dictionary) -> Vector3:
	var position := player_placement_plane_center
	var saved_position = saved.get("position", null)
	if typeof(saved_position) == TYPE_ARRAY and saved_position.size() >= 3:
		return _clamp_player_placement_plane_position(Vector3(
			float(saved_position[0]),
			float(saved_position[1]),
			float(saved_position[2])
		))
	else:
		var saved_normal = saved.get("normal", null)
		if typeof(saved_normal) == TYPE_ARRAY and saved_normal.size() >= 3:
			position = Vector3(
				float(saved_normal[0]),
				float(saved_normal[1]),
				float(saved_normal[2])
			).normalized() * float(saved.get("root_radius", 0.0))
			return _project_point_to_player_placement_plane(position)
	return _clamp_player_placement_plane_position(position)


func _apply_saved_player_plane_record(index: int, saved: Dictionary) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	var position := _player_plane_position_from_saved(saved)
	var surface_footprint := clampf(
		maxf(
			float(saved.get("placement_footprint", 0.0)),
			float(saved.get("base_scale", 1.0)) * 0.30
		),
		0.045,
		0.34
	)
	record.erase("player_needs_plane_calibration")
	var record_kind := String(record.get("kind", ""))
	var saved_support_id := String(saved.get("placement_support_id", ""))
	record["placement_height_offset"] = clampf(
		float(saved.get("placement_height_offset", 0.0)),
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	var fallback_ground_height := (
		float(record.placement_height_offset)
		if saved_support_id.is_empty()
		else float(player_asset_height_offsets.get(record_kind, 0.0))
	)
	var fallback_support_height := float(
		record.placement_height_offset
		if not saved_support_id.is_empty()
		else player_asset_support_height_offsets.get(record_kind, 0.0)
	)
	record["ground_height_offset"] = clampf(
		float(saved.get("ground_height_offset", fallback_ground_height)),
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	record["support_height_offset"] = clampf(
		float(saved.get("support_height_offset", fallback_support_height)),
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	record["placement_height_offset"] = float(
		record.support_height_offset
		if not saved_support_id.is_empty()
		else record.ground_height_offset
	)
	record["initial_placement_height_offset"] = float(
		record.placement_height_offset
	)
	if (
		saved_support_id.is_empty()
		and not player_asset_height_offsets.has(record_kind)
	):
		player_asset_height_offsets[record_kind] = float(
			record.placement_height_offset
		)
	elif (
		not saved_support_id.is_empty()
		and not player_asset_support_height_offsets.has(record_kind)
	):
		player_asset_support_height_offsets[record_kind] = float(
			record.support_height_offset
		)
	record["placement_footprint"] = surface_footprint
	if String(saved.get("layout_mode", "sphere")) == "sphere":
		var saved_normal = saved.get("normal", null)
		if typeof(saved_normal) == TYPE_ARRAY and saved_normal.size() >= 3:
			record["player_migration_source_position"] = (
				Vector3(
					float(saved_normal[0]),
					float(saved_normal[1]),
					float(saved_normal[2])
				).normalized() * float(saved.get("root_radius", 2.35))
			)
	record.erase("placement_support_id")
	record.erase("placement_support_normal")
	if not saved_support_id.is_empty():
		record["placement_support_id"] = saved_support_id
	var saved_support_normal = saved.get("placement_support_normal", null)
	var loaded_surface_normal := _player_surface_normal_at_position(
		position,
		surface_footprint
	)
	if (
		typeof(saved_support_normal) == TYPE_ARRAY
		and saved_support_normal.size() >= 3
	):
		var support_normal := Vector3(
			float(saved_support_normal[0]),
			float(saved_support_normal[1]),
			float(saved_support_normal[2])
		).normalized()
		if support_normal.length_squared() > 0.0001:
			loaded_surface_normal = support_normal
			record["placement_support_normal"] = support_normal
	elif not saved_support_id.is_empty():
		for surface in _player_support_surfaces():
			if String(surface.get("id", "")) == saved_support_id:
				loaded_surface_normal = surface.normal
				record["placement_support_normal"] = loaded_surface_normal
				break
	_configure_player_plane_record(
		record,
		position,
		loaded_surface_normal
	)
	if saved.has("scale"):
		record["scale"] = float(saved.scale)
		record["initial_scale"] = float(saved.scale)
	if not player_asset_scale_defaults.has(record_kind):
		player_asset_scale_defaults[record_kind] = float(record.scale)
	if saved.has("yaw"):
		record["yaw"] = float(saved.yaw)
		record["initial_yaw"] = float(saved.yaw)
	if saved.has("surface_tilt"):
		record["surface_tilt"] = clampf(float(saved.surface_tilt), -60.0, 60.0)
		record["initial_surface_tilt"] = float(record.surface_tilt)
	if saved.has("locked"):
		record["locked"] = bool(saved.locked)
	if (
		record_kind == "player_star_earth_fox"
		and not saved.has("placement_height_locked")
	):
		# Older player layouts predate the per-item height lock fields. Keep
		# the exact saved fox offset and migrate it into the locked baseline so
		# terrain resampling or a later scale edit cannot silently move it.
		record["placement_height_locked"] = true
		record["locked_ground_height_offset"] = float(
			saved.get(
				"ground_height_offset",
				record.get("ground_height_offset", record.placement_height_offset)
			)
		)
		record["locked_support_height_offset"] = float(
			saved.get(
				"support_height_offset",
				record.get("support_height_offset", 0.0)
			)
		)
	if saved.has("placement_height_locked"):
		record["placement_height_locked"] = bool(
			saved.placement_height_locked
		)
	if saved.has("locked_ground_height_offset"):
		record["locked_ground_height_offset"] = float(
			saved.locked_ground_height_offset
		)
	if saved.has("locked_support_height_offset"):
		record["locked_support_height_offset"] = float(
			saved.locked_support_height_offset
		)
	if bool(record.get("placement_height_locked", false)):
		record["placement_height_offset"] = (
			record.get(
				"locked_support_height_offset",
				record.get("support_height_offset", record.placement_height_offset)
			)
			if not saved_support_id.is_empty()
			else record.get(
				"locked_ground_height_offset",
				record.get("ground_height_offset", record.placement_height_offset)
			)
		)
	if saved.has("visible"):
		record["default_hidden"] = not bool(saved.visible)
	(record.node as Node3D).visible = not bool(record.default_hidden)
	_apply_editable_3d_record(index)


func _current_layout_key() -> String:
	if current_3d_scene in ["pointlighter", "king"]:
		return current_3d_scene
	for scene_data in GENERATED_PLANET_SCENES.values():
		if String(scene_data.get("slug", "")) == current_3d_scene:
			return current_3d_scene
	return "pointlighter"


func _current_scene_display_name() -> String:
	if current_3d_scene == "pointlighter":
		return "点灯人"
	if current_3d_scene == "king":
		return "国王"
	for planet_name in GENERATED_PLANET_SCENES:
		var data: Dictionary = GENERATED_PLANET_SCENES[planet_name]
		if String(data.get("slug", "")) == current_3d_scene:
			return planet_name
	return "当前星球"


func _find_editable_record_index(id: String, fallback: int) -> int:
	if id == "":
		return fallback
	for index in editable_3d_objects.size():
		if String(editable_3d_objects[index].id) == id:
			return index
	return fallback


func _remove_editable_record_by_id(id: String) -> void:
	if id == "":
		return
	var index := _find_editable_record_index(id, -1)
	if index < 0:
		return
	var node := editable_3d_objects[index].node as Node3D
	if node != null:
		node.queue_free()
	editable_3d_objects.remove_at(index)
	if selected_editable_index >= editable_3d_objects.size():
		selected_editable_index = editable_3d_objects.size() - 1


func _instantiate_generated_model(path: String) -> Node3D:
	if not ResourceLoader.exists(path):
		push_warning("Generated 3D model is missing: " + path)
		return null
	var packed := generated_model_scene_cache.get(path) as PackedScene
	if packed == null:
		packed = load(path) as PackedScene
		if packed != null:
			generated_model_scene_cache[path] = packed
	if packed == null:
		push_warning("Generated 3D model failed to load: " + path)
		return null
	return packed.instantiate() as Node3D


func _node_local_bounds(node: Node3D) -> AABB:
	return _collect_node_bounds(node, Transform3D.IDENTITY)


func _collect_node_bounds(node: Node, relative_transform: Transform3D) -> AABB:
	var bounds := AABB()
	var has_bounds := false
	if node is MeshInstance3D:
		var mesh_instance := node as MeshInstance3D
		if mesh_instance.mesh == null:
			return bounds
		bounds = relative_transform * mesh_instance.get_aabb()
		has_bounds = true
	for child in node.get_children():
		if not child is Node3D:
			continue
		var child_relative := relative_transform * (child as Node3D).transform
		var child_bounds := _collect_node_bounds(child, child_relative)
		if child_bounds.size == Vector3.ZERO:
			continue
		bounds = child_bounds if not has_bounds else bounds.merge(child_bounds)
		has_bounds = true
	return bounds


func _upright_surface_transform(normal: Vector3, surface_radius: float) -> Transform3D:
	var surface_normal := normal.normalized()
	var surface_point := surface_normal * surface_radius
	return Transform3D(
		_upright_surface_basis(surface_normal, surface_point),
		surface_point
	)


func _upright_surface_basis(normal: Vector3, surface_point: Vector3) -> Basis:
	var front := Vector3(
		camera_3d.global_position.x - surface_point.x,
		0.0,
		camera_3d.global_position.z - surface_point.z
	).normalized()
	if front.length_squared() < 0.0001:
		front = Vector3(0.0, 0.0, 1.0)
	var right := Vector3.UP.cross(front).normalized()
	return Basis(right, Vector3.UP, front)


func _upright_surface_basis_toward(
	normal: Vector3,
	surface_point: Vector3,
	target_point: Vector3
) -> Basis:
	var surface_normal := normal.normalized()
	var front := target_point - surface_point
	front -= surface_normal * front.dot(surface_normal)
	if front.length_squared() < 0.0001:
		return _upright_surface_basis(surface_normal, surface_point)
	front = front.normalized()
	var right := surface_normal.cross(front).normalized()
	return Basis(right, surface_normal, front)


func _normal_surface_basis(normal: Vector3, yaw_degrees: float) -> Basis:
	var surface_normal := normal.normalized()
	var align := Basis.IDENTITY
	var dot := Vector3.UP.dot(surface_normal)
	if dot < -0.9999:
		align = Basis(Vector3.RIGHT, PI)
	elif dot < 0.9999:
		align = Basis(Vector3.UP.cross(surface_normal).normalized(), acos(dot))
	var yaw := Basis(surface_normal, deg_to_rad(yaw_degrees))
	return yaw * align


func _add_legacy_model_fallback(parent: Node3D) -> void:
	if not ResourceLoader.exists(PLANET_3D):
		return
	var legacy := _instantiate_generated_model(PLANET_3D)
	if legacy != null:
		parent.add_child(legacy)


func _fit_model_to_view() -> void:
	if model_3d == null:
		return
	var meshes := model_3d.find_children("*", "MeshInstance3D", true, false)
	var bounds := AABB()
	var has_bounds := false
	for item in meshes:
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var local_transform := model_3d.global_transform.affine_inverse() * mesh_instance.global_transform
		var box: AABB = local_transform * mesh_instance.get_aabb()
		bounds = box if not has_bounds else bounds.merge(box)
		has_bounds = true
	if not has_bounds:
		camera_3d.position = Vector3(0, 1.0, 5.5)
		return
	var size := bounds.size
	var center := bounds.get_center()
	var target_height := NORMALIZED_PLANET_HEIGHT
	var factor := target_height / maxf(size.y, 0.001)
	model_3d.scale = Vector3.ONE * factor
	model_3d.position = -center * factor
	camera_distance = POINTLIGHTER_HOME_DISTANCE
	var framing_offset := _get_planet_framing_offset(current_3d_scene)
	camera_focus_point = Vector3(
		0.0,
		PLANET_HOME_FOCUS_Y - framing_offset,
		0.0
	)
	camera_home_position = Vector3(
		0.0,
		PLANET_HOME_CAMERA_HEIGHT - framing_offset,
		camera_distance
	)
	camera_3d.position = camera_home_position
	camera_3d.look_at(camera_focus_point)


func _build_3d_hud() -> void:
	hud_3d = CanvasLayer.new()
	hud_3d.name = "PointlighterHUD"
	hud_3d.layer = 10
	hud_3d.visible = false
	add_child(hud_3d)
	var root := Control.new()
	hud_3d.add_child(root)
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	if interface_theme != null:
		root.theme = interface_theme
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_build_planet_item_notes(root)
	_build_player_drop_surface(root)
	_build_player_day_night_beacon_ripple(root)
	var back := FACE_ARROW_BUTTON_SCRIPT.new()
	back.set_arrow_angle(180.0)
	back.set_paper_texture(load(UI_BACK_BUTTON) as Texture2D)
	back.tooltip_text = "返回星图"
	back.position = Vector2(34, 28)
	back.size = Vector2(58, 54)
	back.pressed.connect(_exit_3d)
	root.add_child(back)
	_register_ui_control(back, "hud.back", "星球页返回按钮", false)
	hud_scene_title_plate = NinePatchRect.new()
	hud_scene_title_plate.name = "SceneTitlePaper"
	hud_scene_title_plate.texture = load(UI_SCENE_TITLE_PLATE)
	hud_scene_title_plate.position = Vector2(1060, 20)
	hud_scene_title_plate.size = Vector2(510, 150)
	hud_scene_title_plate.patch_margin_left = 84
	hud_scene_title_plate.patch_margin_right = 98
	hud_scene_title_plate.patch_margin_top = 58
	hud_scene_title_plate.patch_margin_bottom = 48
	hud_scene_title_plate.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hud_scene_title_plate.clip_contents = true
	root.add_child(hud_scene_title_plate)
	_register_ui_control(
		hud_scene_title_plate,
		"hud.title.paper",
		"星球标题底板",
		false
	)
	hud_scene_kicker = _add_label(hud_scene_title_plate, "第五颗星 | ASTEROID B-612", Vector2(102, 44), Vector2(298, 22), 13, Color(0.40, 0.28, 0.18, 0.94), HORIZONTAL_ALIGNMENT_LEFT)
	hud_scene_kicker.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	_register_ui_control(hud_scene_kicker, "hud.title.kicker", "星球编号标题")
	hud_scene_title = _add_label(hud_scene_title_plate, "点灯人", Vector2(94, 72), Vector2(278, 42), 32, Color(0.27, 0.19, 0.13, 1.0), HORIZONTAL_ALIGNMENT_LEFT)
	hud_scene_title.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	_register_ui_control(hud_scene_title, "hud.title.name", "星球名称标题")
	hud_scene_quote = _add_label(
		root,
		"“每分钟点一次灯，因为他不知道还能做什么。”",
		Vector2(60, 868),
		Vector2(760, 60),
		20,
		Color(1.0, 0.94, 0.82, 1.0),
		HORIZONTAL_ALIGNMENT_LEFT
	)
	hud_scene_quote.add_theme_color_override(
		"font_shadow_color",
		Color(0.01, 0.02, 0.04, 0.88)
	)
	hud_scene_quote.add_theme_constant_override("shadow_offset_x", 1)
	hud_scene_quote.add_theme_constant_override("shadow_offset_y", 2)
	hud_scene_quote.add_theme_constant_override("outline_size", 1)
	hud_scene_quote.add_theme_color_override(
		"font_outline_color",
		Color(0.01, 0.02, 0.04, 0.72)
	)
	_register_ui_control(hud_scene_quote, "hud.quote", "星球页引文")
	hud_scene_hint = _add_label(
		root,
		"",
		Vector2(400, 923),
		Vector2(800, 44),
		17,
		Color(1.0, 0.91, 0.75, 0.96)
	)
	hud_scene_hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	hud_scene_hint.add_theme_constant_override("line_spacing", 2)
	hud_scene_hint.add_theme_color_override(
		"font_shadow_color",
		Color.TRANSPARENT
	)
	hud_scene_hint.add_theme_constant_override("outline_size", 1)
	hud_scene_hint.add_theme_color_override(
		"font_outline_color",
		Color(0.01, 0.02, 0.04, 0.72)
	)
	_register_ui_control(hud_scene_hint, "hud.hint", "星球页操作提示")
	earth_fox_search_controls = _add_label(
		root,
		"拖动星球寻找 | 滚轮缩放 | 双击复位",
		Vector2(420, 168),
		Vector2(600, 34),
		16,
		Color(0.92, 0.86, 0.73, 0.92)
	)
	earth_fox_search_controls.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	earth_fox_search_controls.add_theme_color_override(
		"font_shadow_color",
		Color(0.01, 0.02, 0.05, 0.9)
	)
	earth_fox_search_controls.add_theme_constant_override("shadow_offset_x", 1)
	earth_fox_search_controls.add_theme_constant_override("shadow_offset_y", 2)
	earth_fox_search_controls.add_theme_constant_override("outline_size", 1)
	earth_fox_search_controls.visible = false
	_register_ui_control(
		earth_fox_search_controls,
		"hud.earth_fox_search_controls",
		"寻找狐狸操作提示"
	)
	editor_edit_button = Button.new()
	editor_edit_button.text = "布局"
	editor_edit_button.tooltip_text = ""
	editor_edit_button.visible = SHOW_LAYOUT_BUTTON
	editor_edit_button.disabled = not SHOW_LAYOUT_BUTTON
	editor_edit_button.position = Vector2(1390, 204)
	editor_edit_button.size = Vector2(82, 44)
	_style_button(editor_edit_button)
	editor_edit_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	editor_edit_button.pressed.connect(_toggle_3d_editor)
	root.add_child(editor_edit_button)
	_register_ui_control(editor_edit_button, "hud.layout_button", "星球布局按钮")
	_build_3d_editor_ui(root)
	_build_chair_interaction_ui(root)
	_build_lamplighter_dialogue_ui(root)
	_build_king_ritual_ui(root)
	_build_story_action_ui(root)
	_build_memory_collection_ui(root)
	_build_player_placement_ui(root)
	if ui_layout_editor != null:
		ui_layout_editor.set_scope_root("hud", root)


func _build_planet_item_notes(root: Control) -> void:
	planet_item_glow_layer = Control.new()
	planet_item_glow_layer.name = "PlanetItemNotes"
	planet_item_glow_layer.z_index = 18
	planet_item_glow_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(planet_item_glow_layer)
	planet_item_glow_layer.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)

	planet_item_note_panel = PanelContainer.new()
	planet_item_note_panel.name = "PlanetItemNote"
	planet_item_note_panel.z_index = 3
	planet_item_note_panel.custom_minimum_size = Vector2(340.0, 0.0)
	planet_item_note_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	planet_item_note_panel.visible = false
	planet_item_note_panel.add_theme_stylebox_override(
		"panel",
		StyleBoxEmpty.new()
	)
	planet_item_glow_layer.add_child(planet_item_note_panel)

	var note_copy := VBoxContainer.new()
	note_copy.add_theme_constant_override("separation", 0)
	planet_item_note_panel.add_child(note_copy)
	planet_item_note_label = Label.new()
	planet_item_note_label.name = "ItemQuote"
	planet_item_note_label.custom_minimum_size = Vector2(340.0, 0.0)
	planet_item_note_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	planet_item_note_label.add_theme_font_size_override("font_size", UI_FONT_BODY)
	planet_item_note_label.add_theme_constant_override("line_spacing", 5)
	planet_item_note_label.add_theme_color_override(
		"font_color",
		Color(0.93, 0.97, 1.0, 0.98)
	)
	planet_item_note_label.add_theme_color_override(
		"font_shadow_color",
		Color(0.0, 0.015, 0.04, 0.92)
	)
	planet_item_note_label.add_theme_constant_override("shadow_offset_x", 1)
	planet_item_note_label.add_theme_constant_override("shadow_offset_y", 2)
	planet_item_note_label.add_theme_constant_override("outline_size", 2)
	planet_item_note_label.add_theme_color_override(
		"font_outline_color",
		Color(0.01, 0.025, 0.06, 0.78)
	)
	if body_font != null:
		planet_item_note_label.add_theme_font_override("font", body_font)
	note_copy.add_child(planet_item_note_label)


func _planet_item_intros_for_scene(slug: String) -> Array:
	var entries = PLANET_ITEM_INTROS.get(slug, [])
	return entries if entries is Array else []


func _first_visible_item_record_for_kind(
	kind: String,
	fallback_kind: String = ""
) -> Dictionary:
	var fallback := {}
	var viewport_size := get_viewport().get_visible_rect().size
	for record_value in editable_3d_objects:
		var record: Dictionary = record_value
		if String(record.get("kind", "")) != kind:
			continue
		var node := record.get("node") as Node3D
		if node == null or not is_instance_valid(node):
			continue
		if not node.is_visible_in_tree():
			continue
		if fallback.is_empty():
			fallback = record
		if camera_3d == null:
			return record
		var bounds := _editable_world_bounds(node)
		if bounds.size == Vector3.ZERO:
			continue
		var anchor_world := _planet_item_glow_anchor_world(node, bounds)
		if camera_3d.is_position_behind(anchor_world):
			continue
		var anchor_screen := camera_3d.unproject_position(anchor_world)
		if (
			anchor_screen.x >= 0.0
			and anchor_screen.y >= 0.0
			and anchor_screen.x <= viewport_size.x
			and anchor_screen.y <= viewport_size.y
		):
			return record
	if (
		not fallback_kind.is_empty()
		and fallback_kind != kind
	):
		return _first_visible_item_record_for_kind(fallback_kind)
	return fallback


func _planet_item_notes_available() -> bool:
	return (
		stage_3d != null
		and stage_3d.visible
		and camera_3d != null
		and not dialogue_active
		and not editor_active
		and not transition_running
		and not story_camera_focus_active
		and not earth_fox_search_active
		and not _planet_item_intros_for_scene(current_3d_scene).is_empty()
	)


func _rebuild_planet_item_glows() -> void:
	for entry_value in planet_item_glows:
		var old_button := entry_value.get("button") as Control
		if old_button != null and is_instance_valid(old_button):
			old_button.queue_free()
	planet_item_glows.clear()
	_hide_planet_item_note()
	planet_item_glow_scene_key = "%s:%d" % [
		current_3d_scene,
		editable_3d_objects.size(),
	]
	if planet_item_glow_layer == null:
		return
	for index in _planet_item_intros_for_scene(current_3d_scene).size():
		var intro: Dictionary = _planet_item_intros_for_scene(
			current_3d_scene
		)[index]
		var glow := PLANET_ITEM_GLOW_SCRIPT.new() as Button
		glow.name = "ItemGlow_%02d" % (index + 1)
		glow.tooltip_text = "查看“%s”" % String(intro.get("name", "物品"))
		glow.z_index = 30
		glow.mouse_filter = Control.MOUSE_FILTER_STOP
		glow.pulse_phase = float(index) * 1.7
		glow.pressed.connect(_on_planet_item_glow_pressed.bind(intro))
		planet_item_glow_layer.get_parent().add_child(glow)
		planet_item_glows.append({
			"kind": String(intro.get("kind", "")),
			"fallback_kind": String(intro.get("fallback_kind", "")),
			"screen_offset": intro.get(
				"glow_screen_offset",
				Vector2.ZERO
			),
			"button": glow,
			"intro": intro,
			"phase": float(index) * 1.37,
		})


func _hide_planet_item_note() -> void:
	planet_item_note_target = ""
	planet_item_note_age = 0.0
	if planet_item_note_panel != null:
		planet_item_note_panel.visible = false
		planet_item_note_panel.modulate.a = 1.0


func _set_planet_item_glow_buttons_visible(visible: bool) -> void:
	for entry_value in planet_item_glows:
		var button := entry_value.get("button") as Control
		if button != null and is_instance_valid(button):
			button.visible = visible


func _on_planet_item_glow_pressed(intro: Dictionary) -> void:
	AudioDirector.play_sfx("ui_soft")
	var kind := String(intro.get("kind", ""))
	if (
		planet_item_note_target == kind
		and planet_item_note_panel != null
		and planet_item_note_panel.visible
	):
		_hide_planet_item_note()
		return
	planet_item_note_target = kind
	planet_item_note_age = 0.0
	if planet_item_note_label != null:
		planet_item_note_label.text = "%s：%s" % [
			String(intro.get("name", "物品")),
			String(intro.get("text", "")),
		]
	if planet_item_note_panel != null:
		planet_item_note_panel.visible = true
		planet_item_note_panel.modulate.a = 0.0
		planet_item_note_panel.scale = Vector2.ONE * 0.96
		var reveal := create_tween().set_parallel(true)
		reveal.tween_property(
			planet_item_note_panel,
			"modulate:a",
			1.0,
			0.2
		)
		reveal.tween_property(
			planet_item_note_panel,
			"scale",
			Vector2.ONE,
			0.24
		).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _planet_item_glow_anchor_world(
	node: Node3D,
	bounds: AABB
) -> Vector3:
	var up := node.global_transform.basis.y.normalized()
	var camera_right := camera_3d.global_basis.x.normalized()
	return (
		bounds.get_center()
		+ up * minf(bounds.size.y * 0.32, 0.18)
		+ camera_right * minf(bounds.size.x * 0.34, 0.18)
	)


func _position_planet_item_note(glow: Control) -> void:
	if (
		planet_item_note_panel == null
		or glow == null
		or not planet_item_note_panel.visible
	):
		return
	var viewport_size := get_viewport().get_visible_rect().size
	var panel_size := Vector2(
		340.0,
		maxf(planet_item_note_panel.get_combined_minimum_size().y, 56.0)
	)
	planet_item_note_panel.size = panel_size
	var glow_center := glow.position + glow.size * 0.5
	var planet_rect := _planet_visual_screen_rect().grow(8.0)
	var note_y := clampf(
		glow_center.y - panel_size.y * 0.5,
		170.0,
		viewport_size.y - panel_size.y - 88.0
	)
	var planet_gap := 70.0 if current_3d_scene == "vain" else 18.0
	var left_edge := planet_rect.position.x - planet_gap
	var right_edge := planet_rect.end.x + planet_gap
	var glow_rects: Array[Rect2] = []
	for entry_value in planet_item_glows:
		var item_glow := entry_value.get("button") as Control
		if item_glow == null or not item_glow.visible:
			continue
		var item_rect := Rect2(
			item_glow.position,
			item_glow.size
		).grow(16.0)
		glow_rects.append(item_rect)
		if current_3d_scene == "vain":
			if item_rect.get_center().x < planet_rect.get_center().x:
				left_edge = minf(left_edge, item_rect.position.x - 12.0)
			else:
				right_edge = maxf(right_edge, item_rect.end.x + 12.0)
	var left_x := clampf(
		left_edge - panel_size.x,
		16.0,
		viewport_size.x - panel_size.x - 16.0
	)
	var right_x := clampf(
		right_edge,
		16.0,
		viewport_size.x - panel_size.x - 16.0
	)
	var candidates: Array[Vector2] = [
		Vector2(left_x, note_y),
		Vector2(right_x, note_y),
	]
	var vertical_shift := (
		panel_size.y * 0.5
		+ glow.size.y * 0.5
		+ 24.0
	)
	for side_x in [left_x, right_x]:
		for direction in [-1.0, 1.0]:
			candidates.append(Vector2(
				side_x,
				clampf(
					note_y + vertical_shift * direction,
					170.0,
					viewport_size.y - panel_size.y - 88.0
				)
			))
	var title_rect := (
		hud_scene_title_plate.get_global_rect().grow(8.0)
		if hud_scene_title_plate != null and hud_scene_title_plate.visible
		else Rect2()
	)
	var best_position := candidates[0]
	var best_score := INF
	var glow_rect := Rect2(glow.position, glow.size).grow(16.0)
	for candidate in candidates:
		var candidate_rect := Rect2(candidate, panel_size)
		var planet_overlap := _rect_overlap_area(
			candidate_rect,
			planet_rect
		)
		var title_overlap := (
			_rect_overlap_area(candidate_rect, title_rect)
			if title_rect.has_area()
			else 0.0
		)
		var glow_overlap := _rect_overlap_area(candidate_rect, glow_rect)
		for other_glow_rect in glow_rects:
			glow_overlap = maxf(
				glow_overlap,
				_rect_overlap_area(candidate_rect, other_glow_rect)
			)
		var score := (
			candidate.distance_to(glow_center)
			+ planet_overlap * 20.0
			+ title_overlap * 8.0
		)
		if glow_overlap > 0.0:
			score += 900000.0
		if planet_overlap > 0.0:
			score += 1000000.0
		if title_overlap > 0.0:
			score += 50000.0
		if score < best_score:
			best_score = score
			best_position = candidate
	planet_item_note_panel.position = best_position
	planet_item_note_panel.pivot_offset = panel_size * 0.5


func _planet_visual_screen_rect() -> Rect2:
	if model_3d == null or camera_3d == null:
		return Rect2()
	var largest_mesh: MeshInstance3D = null
	var largest_volume := 0.0
	for item in model_3d.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var world_bounds := (
			mesh_instance.global_transform
			* mesh_instance.get_aabb()
		)
		var volume := (
			world_bounds.size.x
			* world_bounds.size.y
			* world_bounds.size.z
		)
		if volume > largest_volume:
			largest_volume = volume
			largest_mesh = mesh_instance
	if largest_mesh == null:
		return Rect2()
	var planet_bounds := (
		largest_mesh.global_transform
		* largest_mesh.get_aabb()
	)
	var center := planet_bounds.get_center()
	var radius := minf(
		planet_bounds.size.x,
		minf(planet_bounds.size.y, planet_bounds.size.z)
	) * 0.39
	if camera_3d.is_position_behind(center):
		return Rect2()
	var center_screen := camera_3d.unproject_position(center)
	var right_screen := camera_3d.unproject_position(
		center + camera_3d.global_basis.x.normalized() * radius
	)
	var up_screen := camera_3d.unproject_position(
		center + camera_3d.global_basis.y.normalized() * radius
	)
	var screen_radius := Vector2(
		absf(right_screen.x - center_screen.x),
		absf(up_screen.y - center_screen.y)
	)
	return Rect2(center_screen - screen_radius, screen_radius * 2.0)


func _planet_item_glow_angle(item_screen: Vector2, planet_rect: Rect2) -> float:
	if not planet_rect.has_area():
		return 0.0
	var planet_center := planet_rect.get_center()
	var direction := item_screen - planet_center
	if direction.length_squared() < 0.01:
		direction = Vector2(0.0, -1.0)
	return direction.angle()


func _planet_item_glow_position_for_angle(
	angle: float,
	planet_rect: Rect2
) -> Vector2:
	if not planet_rect.has_area():
		return Vector2.ZERO
	var planet_center := planet_rect.get_center()
	var radii := planet_rect.size * 0.5
	var direction := Vector2.from_angle(angle)
	var ellipse_distance := 1.0 / sqrt(
		pow(direction.x / radii.x, 2.0)
		+ pow(direction.y / radii.y, 2.0)
	)
	# Clear the tallest scenery as well as the base silhouette, so the whole
	# shrunken breathing halo remains in the starfield instead of covering it.
	return planet_center + direction * (
		ellipse_distance
		+ PLANET_ITEM_STARFIELD_GAP
	)


func _planet_item_outline_screen(
	force_refresh := false
) -> PackedVector2Array:
	if model_3d == null or camera_3d == null:
		return PackedVector2Array()
	var cache_key := "%s:%d" % [
		current_3d_scene,
		model_3d.get_instance_id(),
	]
	if not planet_item_outline_mesh_samples.has(cache_key):
		planet_item_outline_mesh_samples[cache_key] = (
			_build_planet_item_outline_mesh_samples()
		)
	var now := Time.get_ticks_msec()
	if (
		not force_refresh
		and cache_key == planet_item_outline_cache_key
		and now - planet_item_outline_cache_at_msec < 90
	):
		return planet_item_outline_cache
	var projected_points := PackedVector2Array()
	var samples: Array = planet_item_outline_mesh_samples.get(cache_key, [])
	for sample_value in samples:
		var sample: Dictionary = sample_value
		var mesh_instance := sample.get("node") as MeshInstance3D
		if (
			mesh_instance == null
			or not is_instance_valid(mesh_instance)
			or mesh_instance.mesh == null
			or not mesh_instance.is_visible_in_tree()
		):
			continue
		var local_points: PackedVector3Array = sample.get(
			"points",
			PackedVector3Array()
		)
		var mesh_transform := mesh_instance.global_transform
		for local_point in local_points:
			var world_point := mesh_transform * local_point
			if camera_3d.is_position_behind(world_point):
				continue
			projected_points.append(
				camera_3d.unproject_position(world_point)
			)
	if projected_points.size() < 3:
		return PackedVector2Array()
	var hull := Geometry2D.convex_hull(projected_points)
	if (
		hull.size() > 1
		and hull[0].is_equal_approx(hull[hull.size() - 1])
	):
		hull.remove_at(hull.size() - 1)
	planet_item_outline_cache = hull
	planet_item_outline_cache_key = cache_key
	planet_item_outline_cache_at_msec = now
	return hull


func _build_planet_item_outline_mesh_samples() -> Array:
	var samples: Array = []
	for item in model_3d.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance == null or mesh_instance.mesh == null:
			continue
		var local_points := PackedVector3Array()
		for surface_index in mesh_instance.mesh.get_surface_count():
			var arrays := mesh_instance.mesh.surface_get_arrays(surface_index)
			if arrays.is_empty():
				continue
			var vertices = arrays[Mesh.ARRAY_VERTEX]
			if not (vertices is PackedVector3Array):
				continue
			var packed_vertices: PackedVector3Array = vertices
			if packed_vertices.is_empty():
				continue
			var stride := maxi(
				1,
				ceili(float(packed_vertices.size()) / 128.0)
			)
			for vertex_index in range(0, packed_vertices.size(), stride):
				local_points.append(packed_vertices[vertex_index])
		if local_points.is_empty():
			for corner in _aabb_corners(mesh_instance.get_aabb()):
				local_points.append(corner)
		samples.append({
			"node": mesh_instance,
			"points": local_points,
		})
	return samples


func _aabb_corners(bounds: AABB) -> Array[Vector3]:
	var corners: Array[Vector3] = []
	for x in [bounds.position.x, bounds.end.x]:
		for y in [bounds.position.y, bounds.end.y]:
			for z in [bounds.position.z, bounds.end.z]:
				corners.append(Vector3(x, y, z))
	return corners


func _planet_item_glow_position_on_outline(
	angle: float,
	outline: PackedVector2Array,
	outline_center: Vector2
) -> Vector2:
	if outline.size() < 3:
		return outline_center
	var direction := Vector2.from_angle(angle)
	var ray_distance := (
		get_viewport().get_visible_rect().size.length() * 2.0
	)
	var ray_end := outline_center + direction * ray_distance
	var nearest_hit := INF
	for index in outline.size():
		var hit = Geometry2D.segment_intersects_segment(
			outline_center,
			ray_end,
			outline[index],
			outline[(index + 1) % outline.size()]
		)
		if hit is Vector2:
			var hit_distance := outline_center.distance_to(hit)
			if hit_distance > 0.5:
				nearest_hit = minf(nearest_hit, hit_distance)
	if not is_finite(nearest_hit):
		return outline_center + direction * PLANET_ITEM_OUTLINE_GAP
	return (
		outline_center
		+ direction * (nearest_hit + PLANET_ITEM_OUTLINE_GAP)
	)


func _spread_planet_item_glow_positions(
	glows: Array[Dictionary],
	planet_rect: Rect2
) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	if glows.is_empty():
		return positions
	var outline := PackedVector2Array()
	if current_3d_scene == "vain":
		outline = _planet_item_outline_screen()
	var use_outline := outline.size() >= 3
	if not use_outline and not planet_rect.has_area():
		for glow in glows:
			positions.append(glow.item_screen + glow.screen_offset)
		return positions
	var center := planet_rect.get_center()
	if use_outline:
		center = Vector2.ZERO
		for point in outline:
			center += point
		center /= float(outline.size())
	var mean_direction := Vector2.ZERO
	var relative_angles: Array[float] = []
	for glow in glows:
		var item_direction: Vector2 = glow.item_screen - center
		var angle := (
			item_direction.angle()
			if item_direction.length_squared() > 0.01
			else -PI * 0.5
		)
		mean_direction += Vector2.from_angle(angle)
	if mean_direction.length_squared() < 0.01:
		mean_direction = Vector2(0.0, -1.0)
	var mean_angle := mean_direction.angle()
	for glow in glows:
		var item_direction: Vector2 = glow.item_screen - center
		var item_angle := (
			item_direction.angle()
			if item_direction.length_squared() > 0.01
			else mean_angle
		)
		relative_angles.append(
			wrapf(
				item_angle - mean_angle,
				-PI,
				PI
			)
		)
	var min_separation := deg_to_rad(18.0)
	var required_span := maxf(
		min_separation * float(glows.size() - 1),
		0.0
	)
	var target_angles := Array(relative_angles)
	if target_angles.max() - target_angles.min() < required_span:
		var order: Array[int] = []
		for index in glows.size():
			order.append(index)
		order.sort_custom(
			func(first: int, second: int) -> bool:
				return relative_angles[first] < relative_angles[second]
		)
		for rank in order.size():
			var ratio := (
				float(rank) / float(order.size() - 1)
				if order.size() > 1
				else 0.5
			)
			target_angles[order[rank]] = lerpf(
				-required_span * 0.5,
				required_span * 0.5,
				ratio
			)
	for index in glows.size():
		var angle: float = mean_angle + float(target_angles[index])
		if use_outline:
			positions.append(
				_planet_item_glow_position_on_outline(
					angle,
					outline,
					center
				)
			)
		else:
			positions.append(
				_planet_item_glow_position_for_angle(angle, planet_rect)
			)
	return positions


func _rect_overlap_area(first: Rect2, second: Rect2) -> float:
	var overlap := first.intersection(second)
	return overlap.size.x * overlap.size.y


func _update_planet_item_glows(delta: float) -> void:
	if planet_item_glow_layer == null:
		return
	if player_drop_surface != null:
		player_drop_surface.mouse_filter = (
			Control.MOUSE_FILTER_PASS
			if current_3d_scene == "player"
			else Control.MOUSE_FILTER_IGNORE
		)
	planet_item_glow_time += delta
	if not _planet_item_notes_available():
		planet_item_glow_layer.visible = false
		_set_planet_item_glow_buttons_visible(false)
		_hide_planet_item_note()
		return
	var scene_key := "%s:%d" % [
		current_3d_scene,
		editable_3d_objects.size(),
	]
	if scene_key != planet_item_glow_scene_key:
		_rebuild_planet_item_glows()
	planet_item_glow_layer.visible = not planet_item_glows.is_empty()
	if not planet_item_glow_layer.visible:
		_set_planet_item_glow_buttons_visible(false)
		_hide_planet_item_note()
		return
	var viewport_size := get_viewport().get_visible_rect().size
	var planet_rect := _planet_visual_screen_rect()
	var active_note_glow: Control = null
	var ready_glows: Array[Dictionary] = []
	for entry in planet_item_glows:
		var button := entry.get("button") as Control
		if button == null or not is_instance_valid(button):
			continue
		var record := _first_visible_item_record_for_kind(
			String(entry.get("kind", "")),
			String(entry.get("fallback_kind", ""))
		)
		var node := record.get("node") as Node3D
		if node == null:
			button.visible = false
			continue
		var bounds := _editable_world_bounds(node)
		if bounds.size == Vector3.ZERO:
			button.visible = false
			continue
		var anchor_world := _planet_item_glow_anchor_world(node, bounds)
		if camera_3d.is_position_behind(anchor_world):
			button.visible = false
			continue
		button.visible = true
		ready_glows.append({
			"entry": entry,
			"button": button,
			"item_screen": camera_3d.unproject_position(anchor_world),
			"screen_offset": entry.get(
				"screen_offset",
				Vector2.ZERO
			),
		})
	var glow_positions := _spread_planet_item_glow_positions(
		ready_glows,
		planet_rect
	)
	for index in ready_glows.size():
		var ready: Dictionary = ready_glows[index]
		var entry: Dictionary = ready.entry
		var button := ready.get("button") as Control
		if button == null or not is_instance_valid(button):
			continue
		var anchor_screen: Vector2 = glow_positions[index]
		var margin := button.size * 0.5
		if (
			anchor_screen.x < -margin.x
			or anchor_screen.y < -margin.y
			or anchor_screen.x > viewport_size.x + margin.x
			or anchor_screen.y > viewport_size.y + margin.y
		):
			button.visible = false
			continue
		var bob := sin(
			planet_item_glow_time * 1.55 + float(entry.get("phase", 0.0))
		) * 3.2
		button.position = Vector2(
			clampf(
				anchor_screen.x,
				24.0,
				viewport_size.x - 24.0
			) - button.size.x * 0.5,
			clampf(
				anchor_screen.y,
				118.0,
				viewport_size.y - 86.0
			) - button.size.y * 0.5 + bob
		)
		if String(entry.get("kind", "")) == planet_item_note_target:
			active_note_glow = button
	if planet_item_note_panel != null and planet_item_note_panel.visible:
		planet_item_note_age += delta
		if active_note_glow == null or planet_item_note_age >= 7.0:
			_hide_planet_item_note()
		else:
			if planet_item_note_age >= 5.8:
				planet_item_note_panel.modulate.a = clampf(
					(7.0 - planet_item_note_age) / 1.2,
					0.0,
					1.0
				)
			_position_planet_item_note(active_note_glow)


func _build_player_drop_surface(root: Control) -> void:
	player_drop_surface = PLAYER_DROP_SURFACE_SCRIPT.new()
	player_drop_surface.name = "PlayerPlacementDropSurface"
	player_drop_surface.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_child(player_drop_surface)
	player_drop_surface.connect(
		"player_asset_dropped",
		Callable(self, "_on_player_asset_dropped")
	)


func _build_player_placement_ui(root: Control) -> void:
	var place_symbol_style := StyleBoxEmpty.new()
	player_place_button = Button.new()
	player_place_button.name = "PlayerPlaceButton"
	player_place_button.text = ""
	player_place_button.tooltip_text = "打开我的星球模型摆放栏"
	player_place_button.position = Vector2(1500, 323)
	player_place_button.size = Vector2(80, 80)
	player_place_button.z_index = 46
	player_place_button.focus_mode = Control.FOCUS_NONE
	player_place_button.visible = false
	player_place_button.icon = load(PLAYER_PLACE_SYMBOL) as Texture2D
	player_place_button.expand_icon = true
	player_place_button.add_theme_constant_override("icon_max_width", 74)
	player_place_button.add_theme_stylebox_override("normal", place_symbol_style)
	player_place_button.add_theme_stylebox_override("hover", place_symbol_style)
	player_place_button.add_theme_stylebox_override("pressed", place_symbol_style)
	player_place_button.add_theme_stylebox_override("focus", place_symbol_style)
	player_place_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	player_place_button.pressed.connect(_toggle_player_placement_dock)
	root.add_child(player_place_button)

	player_character_reset_button = Button.new()
	player_character_reset_button.name = "PlayerCharacterResetButton"
	player_character_reset_button.text = "复位人物"
	player_character_reset_button.tooltip_text = "脱离卡死：停止移动并将玩家小人与小王子放回安全站位"
	player_character_reset_button.position = Vector2(1376, 372)
	player_character_reset_button.size = Vector2(96, 44)
	player_character_reset_button.visible = false
	_style_button(
		player_character_reset_button,
		Color(0.88, 0.68, 0.48)
	)
	player_character_reset_button.add_theme_font_size_override(
		"font_size",
		UI_FONT_CAPTION
	)
	player_character_reset_button.pressed.connect(
		_reset_player_characters_from_stuck
	)
	root.add_child(player_character_reset_button)

	player_place_dock = PanelContainer.new()
	player_place_dock.name = "PlayerPlacementDock"
	player_place_dock.anchor_left = 0.0
	player_place_dock.anchor_right = 1.0
	player_place_dock.anchor_top = 1.0
	player_place_dock.anchor_bottom = 1.0
	player_place_dock.offset_top = -240.0
	player_place_dock.offset_bottom = 0.0
	player_place_dock.visible = false
	player_place_dock.mouse_filter = Control.MOUSE_FILTER_STOP
	var dock_style := StyleBoxFlat.new()
	dock_style.bg_color = Color(0.0, 0.0, 0.0, 0.5)
	dock_style.border_color = Color(0.88, 0.78, 0.57, 0.30)
	dock_style.border_width_top = 1
	player_place_dock.add_theme_stylebox_override("panel", dock_style)
	player_place_dock.gui_input.connect(_on_player_place_scroll_gui_input)
	root.add_child(player_place_dock)

	var dock_margin := MarginContainer.new()
	dock_margin.mouse_filter = Control.MOUSE_FILTER_PASS
	dock_margin.add_theme_constant_override("margin_left", 28)
	dock_margin.add_theme_constant_override("margin_right", 28)
	dock_margin.add_theme_constant_override("margin_top", 9)
	dock_margin.add_theme_constant_override("margin_bottom", 9)
	player_place_dock.add_child(dock_margin)

	var dock_column := VBoxContainer.new()
	dock_column.mouse_filter = Control.MOUSE_FILTER_PASS
	dock_column.add_theme_constant_override("separation", 6)
	dock_margin.add_child(dock_column)

	var header := HBoxContainer.new()
	header.mouse_filter = Control.MOUSE_FILTER_PASS
	header.add_theme_constant_override("separation", 14)
	dock_column.add_child(header)

	var title := Label.new()
	title.text = "摆放模型"
	title.add_theme_font_size_override("font_size", UI_FONT_BODY)
	title.add_theme_color_override("font_color", Color(1.0, 0.94, 0.82, 0.98))
	header.add_child(title)

	var page_tabs := HBoxContainer.new()
	page_tabs.add_theme_constant_override("separation", 4)
	header.add_child(page_tabs)

	player_place_items_tab = Button.new()
	player_place_items_tab.text = "物品"
	player_place_items_tab.custom_minimum_size = Vector2(58.0, 30.0)
	player_place_items_tab.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	_style_button(player_place_items_tab)
	player_place_items_tab.pressed.connect(
		_switch_player_place_page.bind("items")
	)
	page_tabs.add_child(player_place_items_tab)

	player_place_stars_tab = Button.new()
	player_place_stars_tab.text = "星光背包"
	player_place_stars_tab.custom_minimum_size = Vector2(92.0, 30.0)
	player_place_stars_tab.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	_style_button(player_place_stars_tab, Color(0.82, 0.68, 0.40))
	player_place_stars_tab.pressed.connect(
		_switch_player_place_page.bind("stars")
	)
	page_tabs.add_child(player_place_stars_tab)

	var hint := Label.new()
	hint.text = "拖缩略图到星球摆放 | 点击物品显示调整按钮 | 点击空白取消选择"
	hint.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hint.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	hint.add_theme_color_override("font_color", Color(0.84, 0.82, 0.76, 0.76))
	header.add_child(hint)

	player_place_status = Label.new()
	player_place_status.text = "%d 个模型" % PLAYER_PLACEABLE_ASSETS.size()
	player_place_status.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	player_place_status.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	player_place_status.add_theme_color_override(
		"font_color",
		Color(0.96, 0.82, 0.56, 0.92)
	)
	header.add_child(player_place_status)

	player_light_string_operation_hint = _add_label(
		root,
		"",
		Vector2(320.0, 690.0),
		Vector2(680.0, 48.0),
		19,
		Color(1.0, 0.91, 0.70, 1.0),
		HORIZONTAL_ALIGNMENT_LEFT
	)
	player_light_string_operation_hint.name = "PlayerLightStringOperationHint"
	player_light_string_operation_hint.autowrap_mode = (
		TextServer.AUTOWRAP_WORD_SMART
	)
	player_light_string_operation_hint.add_theme_color_override(
		"font_shadow_color",
		Color(0.01, 0.02, 0.04, 0.92)
	)
	player_light_string_operation_hint.add_theme_constant_override(
		"shadow_offset_x",
		1
	)
	player_light_string_operation_hint.add_theme_constant_override(
		"shadow_offset_y",
		2
	)
	player_light_string_operation_hint.add_theme_constant_override(
		"outline_size",
		2
	)
	player_light_string_operation_hint.add_theme_color_override(
		"font_outline_color",
		Color(0.02, 0.04, 0.07, 0.76)
	)
	player_light_string_operation_hint.mouse_filter = (
		Control.MOUSE_FILTER_IGNORE
	)
	player_light_string_operation_hint.z_index = 120
	player_light_string_operation_hint.visible = false

	var collapse := Button.new()
	collapse.text = "收起"
	collapse.custom_minimum_size = Vector2(62, 30)
	collapse.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	_style_button(collapse)
	collapse.pressed.connect(_toggle_player_placement_dock)
	header.add_child(collapse)

	player_place_height_row = HBoxContainer.new()
	player_place_height_row.name = "PlayerPlacementHeightRow"
	player_place_height_row.visible = false
	player_place_height_row.mouse_filter = Control.MOUSE_FILTER_PASS
	player_place_height_row.add_theme_constant_override("separation", 8)
	dock_column.add_child(player_place_height_row)

	var height_title := Label.new()
	height_title.text = "离吸附面"
	height_title.custom_minimum_size = Vector2(72, 0)
	height_title.tooltip_text = "调整选中物件沿桌面或垫面法线的高度"
	height_title.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	height_title.add_theme_color_override(
		"font_color",
		Color(0.95, 0.86, 0.68, 0.96)
	)
	player_place_height_row.add_child(height_title)
	player_place_height_title = height_title

	var height_minus := Button.new()
	height_minus.text = "−"
	height_minus.custom_minimum_size = Vector2(34, 26)
	height_minus.tooltip_text = "降低 0.01"
	_style_button(height_minus)
	height_minus.pressed.connect(_nudge_player_place_height.bind(-0.01))
	player_place_height_row.add_child(height_minus)

	player_place_height_slider = HSlider.new()
	player_place_height_slider.min_value = PLAYER_HEIGHT_OFFSET_MIN
	player_place_height_slider.max_value = PLAYER_HEIGHT_OFFSET_MAX
	player_place_height_slider.step = 0.005
	player_place_height_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	player_place_height_slider.tooltip_text = "沿吸附面法线微调物件高度"
	player_place_height_slider.value_changed.connect(
		_on_player_place_height_changed
	)
	player_place_height_slider.drag_ended.connect(
		_on_player_place_height_drag_ended
	)
	player_place_height_row.add_child(player_place_height_slider)

	player_place_height_value = Label.new()
	player_place_height_value.custom_minimum_size = Vector2(62, 0)
	player_place_height_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	player_place_height_value.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	player_place_height_row.add_child(player_place_height_value)

	var height_plus := Button.new()
	height_plus.text = "+"
	height_plus.custom_minimum_size = Vector2(34, 26)
	height_plus.tooltip_text = "升高 0.01"
	_style_button(height_plus)
	height_plus.pressed.connect(_nudge_player_place_height.bind(0.01))
	player_place_height_row.add_child(height_plus)

	player_height_lock_row = HBoxContainer.new()
	player_height_lock_row.name = "PlayerCharacterHeightLocks"
	player_height_lock_row.visible = false
	player_height_lock_row.mouse_filter = Control.MOUSE_FILTER_PASS
	player_height_lock_row.add_theme_constant_override("separation", 8)
	dock_column.add_child(player_height_lock_row)

	player_standing_height_lock_button = Button.new()
	player_standing_height_lock_button.text = "站立高度：锁定"
	player_standing_height_lock_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	player_standing_height_lock_button.toggle_mode = true
	player_standing_height_lock_button.tooltip_text = "锁定人物站立时离地面的高度"
	_style_button(player_standing_height_lock_button, Color(0.52, 0.68, 0.78))
	player_standing_height_lock_button.pressed.connect(
		_toggle_player_character_height_lock.bind("standing")
	)
	player_height_lock_row.add_child(player_standing_height_lock_button)

	player_sitting_height_lock_button = Button.new()
	player_sitting_height_lock_button.text = "坐下高度：锁定"
	player_sitting_height_lock_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	player_sitting_height_lock_button.toggle_mode = true
	player_sitting_height_lock_button.tooltip_text = "锁定人物坐下时离座位接触面的高度"
	_style_button(player_sitting_height_lock_button, Color(0.76, 0.62, 0.42))
	player_sitting_height_lock_button.pressed.connect(
		_toggle_player_character_height_lock.bind("sitting")
	)
	player_height_lock_row.add_child(player_sitting_height_lock_button)

	player_place_scroll = ScrollContainer.new()
	player_place_scroll.name = "PlayerPlacementScroll"
	player_place_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	player_place_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	player_place_scroll.scroll_horizontal_custom_step = 150.0
	player_place_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	player_place_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	player_place_scroll.mouse_filter = Control.MOUSE_FILTER_STOP
	player_place_scroll.gui_input.connect(_on_player_place_scroll_gui_input)
	dock_column.add_child(player_place_scroll)

	player_place_row = HBoxContainer.new()
	player_place_row.name = "PlayerPlacementRow"
	player_place_row.add_theme_constant_override("separation", 12)
	player_place_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	player_place_scroll.add_child(player_place_row)

	_refresh_player_placeable_entries()
	_rebuild_player_place_cards()

	player_item_action_arc = Control.new()
	player_item_action_arc.name = "PlayerItemActionArc"
	player_item_action_arc.visible = false
	player_item_action_arc.z_index = 30
	player_item_action_arc.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(player_item_action_arc)
	player_item_action_arc.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	player_item_action_buttons.clear()

	player_item_lock_button = Button.new()
	player_item_lock_button.name = "PlayerItemLockButton"
	player_item_lock_button.text = "锁"
	player_item_lock_button.tooltip_text = "锁定或解锁当前位置"
	player_item_lock_button.pressed.connect(_toggle_player_item_lock)
	_style_player_arc_button(player_item_lock_button)
	_set_player_arc_button_icon(
		player_item_lock_button,
		UI_PLAYER_ACTION_LOCK
	)
	player_item_action_arc.add_child(player_item_lock_button)
	player_item_action_buttons.append(player_item_lock_button)

	var rotate_left := Button.new()
	rotate_left.name = "PlayerItemRotateLeftButton"
	rotate_left.text = "右"
	rotate_left.tooltip_text = "绕 Z 轴右转 15°"
	rotate_left.pressed.connect(_rotate_player_item_z.bind(-15.0))
	_style_player_arc_button(rotate_left)
	_set_player_arc_button_icon(
		rotate_left,
		UI_PLAYER_ACTION_ROTATE_RIGHT
	)
	player_item_action_arc.add_child(rotate_left)
	player_item_action_buttons.append(rotate_left)

	var rotate_right := Button.new()
	rotate_right.name = "PlayerItemRotateRightButton"
	rotate_right.text = "左"
	rotate_right.tooltip_text = "绕 Z 轴左转 15°"
	rotate_right.pressed.connect(_rotate_player_item_z.bind(15.0))
	_style_player_arc_button(rotate_right)
	_set_player_arc_button_icon(
		rotate_right,
		UI_PLAYER_ACTION_ROTATE_LEFT
	)
	player_item_action_arc.add_child(rotate_right)
	player_item_action_buttons.append(rotate_right)

	var duplicate := Button.new()
	duplicate.name = "PlayerItemDuplicateButton"
	duplicate.text = "复"
	duplicate.tooltip_text = "复制选中物件"
	duplicate.pressed.connect(_duplicate_player_item)
	_style_player_arc_button(duplicate, Color(0.58, 0.72, 0.54))
	_set_player_arc_button_icon(
		duplicate,
		UI_PLAYER_ACTION_DUPLICATE
	)
	player_item_action_arc.add_child(duplicate)
	player_item_action_buttons.append(duplicate)

	var delete := Button.new()
	delete.name = "PlayerItemDeleteButton"
	delete.text = "删"
	delete.tooltip_text = "删除选中物件"
	delete.pressed.connect(_delete_player_item)
	_style_player_arc_button(delete, Color(0.78, 0.38, 0.28))
	_set_player_arc_button_icon(
		delete,
		UI_PLAYER_ACTION_DELETE
	)
	player_item_action_arc.add_child(delete)
	player_item_action_buttons.append(delete)

	_build_player_expression_ui(root)
	_build_player_onboarding_guide(root)
	_build_player_avatar_picker(root)


func _build_player_avatar_picker(root: Control) -> void:
	player_avatar_picker_overlay = Control.new()
	player_avatar_picker_overlay.name = "PlayerAvatarPicker"
	player_avatar_picker_overlay.z_index = 120
	player_avatar_picker_overlay.visible = false
	player_avatar_picker_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	player_avatar_picker_overlay.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	root.add_child(player_avatar_picker_overlay)

	var shade := ColorRect.new()
	shade.name = "AvatarPickerShade"
	shade.color = Color(0.008, 0.016, 0.038, 0.78)
	shade.mouse_filter = Control.MOUSE_FILTER_STOP
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	player_avatar_picker_overlay.add_child(shade)

	player_avatar_picker_panel = PanelContainer.new()
	player_avatar_picker_panel.name = "AvatarPickerPanel"
	player_avatar_picker_panel.anchor_left = 0.5
	player_avatar_picker_panel.anchor_right = 0.5
	player_avatar_picker_panel.anchor_top = 0.5
	player_avatar_picker_panel.anchor_bottom = 0.5
	player_avatar_picker_panel.offset_left = -470.0
	player_avatar_picker_panel.offset_right = 470.0
	player_avatar_picker_panel.offset_top = -326.0
	player_avatar_picker_panel.offset_bottom = 326.0
	player_avatar_picker_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.026, 0.047, 0.088, 0.985)
	panel_style.border_color = Color(0.86, 0.72, 0.43, 0.72)
	panel_style.set_border_width_all(1)
	panel_style.border_width_top = 3
	panel_style.set_corner_radius_all(8)
	panel_style.shadow_color = Color(0.0, 0.0, 0.0, 0.55)
	panel_style.shadow_size = 22
	panel_style.shadow_offset = Vector2(0.0, 10.0)
	player_avatar_picker_panel.add_theme_stylebox_override(
		"panel",
		panel_style
	)
	player_avatar_picker_overlay.add_child(player_avatar_picker_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 42)
	margin.add_theme_constant_override("margin_right", 42)
	margin.add_theme_constant_override("margin_top", 30)
	margin.add_theme_constant_override("margin_bottom", 28)
	player_avatar_picker_panel.add_child(margin)

	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 18)
	margin.add_child(column)

	var kicker := Label.new()
	kicker.text = "MY PLANET | 第一次见面"
	kicker.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	kicker.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	kicker.add_theme_color_override(
		"font_color",
		Color(0.88, 0.75, 0.48, 0.94)
	)
	column.add_child(kicker)

	var title := Label.new()
	title.text = "选择你的形象"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 40)
	title.add_theme_color_override(
		"font_color",
		Color(0.98, 0.92, 0.78, 1.0)
	)
	column.add_child(title)

	var subtitle := Label.new()
	subtitle.text = "选一个小人，与小王子一起留在这里。"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", UI_FONT_BODY)
	subtitle.add_theme_color_override(
		"font_color",
		Color(0.80, 0.84, 0.84, 0.88)
	)
	column.add_child(subtitle)

	var cards := HBoxContainer.new()
	cards.alignment = BoxContainer.ALIGNMENT_CENTER
	cards.add_theme_constant_override("separation", 24)
	cards.size_flags_vertical = Control.SIZE_EXPAND_FILL
	column.add_child(cards)

	player_avatar_picker_cards.clear()
	player_avatar_picker_previews.clear()
	for option_value in PLAYER_AVATAR_OPTIONS:
		var option: Dictionary = option_value
		var kind := String(option.get("kind", ""))
		var card := Button.new()
		card.name = "AvatarCard_%s" % kind
		card.custom_minimum_size = Vector2(360.0, 404.0)
		card.focus_mode = Control.FOCUS_ALL
		card.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		var normal := StyleBoxFlat.new()
		normal.bg_color = Color(0.060, 0.083, 0.130, 0.98)
		normal.border_color = Color(0.63, 0.56, 0.39, 0.66)
		normal.set_border_width_all(1)
		normal.set_corner_radius_all(5)
		normal.content_margin_left = 16.0
		normal.content_margin_right = 16.0
		normal.content_margin_top = 16.0
		normal.content_margin_bottom = 16.0
		normal.shadow_color = Color(0.0, 0.0, 0.0, 0.34)
		normal.shadow_size = 8
		normal.shadow_offset = Vector2(0.0, 4.0)
		var hover := normal.duplicate() as StyleBoxFlat
		hover.bg_color = Color(0.092, 0.123, 0.181, 1.0)
		hover.border_color = Color(0.96, 0.81, 0.50, 0.98)
		hover.set_border_width_all(2)
		hover.shadow_color = Color(0.82, 0.64, 0.30, 0.22)
		hover.shadow_size = 13
		card.add_theme_stylebox_override("normal", normal)
		card.add_theme_stylebox_override("hover", hover)
		card.add_theme_stylebox_override("pressed", hover)
		card.add_theme_stylebox_override("focus", hover)
		card.pressed.connect(_on_player_avatar_chosen.bind(kind))
		cards.add_child(card)
		player_avatar_picker_cards.append(card)

		var card_margin := MarginContainer.new()
		card_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
		card_margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		card_margin.add_theme_constant_override("margin_left", 16)
		card_margin.add_theme_constant_override("margin_right", 16)
		card_margin.add_theme_constant_override("margin_top", 14)
		card_margin.add_theme_constant_override("margin_bottom", 14)
		card.add_child(card_margin)

		var card_column := VBoxContainer.new()
		card_column.mouse_filter = Control.MOUSE_FILTER_IGNORE
		card_column.add_theme_constant_override("separation", 10)
		card_margin.add_child(card_column)

		var preview_frame := PanelContainer.new()
		preview_frame.custom_minimum_size = Vector2(0.0, 282.0)
		preview_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var preview_style := StyleBoxFlat.new()
		preview_style.bg_color = Color(0.018, 0.030, 0.055, 0.82)
		preview_style.border_color = Color(0.31, 0.40, 0.48, 0.42)
		preview_style.set_border_width_all(1)
		preview_style.set_corner_radius_all(4)
		preview_frame.add_theme_stylebox_override("panel", preview_style)
		card_column.add_child(preview_frame)

		var preview := TextureRect.new()
		preview.name = "Preview"
		preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
		preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		preview.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
		preview_frame.add_child(preview)
		player_avatar_picker_previews.append(preview)

		var name_label := Label.new()
		name_label.text = String(option.get("label", "小人"))
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		name_label.add_theme_font_size_override("font_size", 26)
		name_label.add_theme_color_override(
			"font_color",
			Color(0.98, 0.91, 0.75, 1.0)
		)
		card_column.add_child(name_label)

		var caption := Label.new()
		caption.text = String(option.get("caption", ""))
		caption.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		caption.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		caption.add_theme_font_size_override("font_size", UI_FONT_ACTION)
		caption.add_theme_color_override(
			"font_color",
			Color(0.73, 0.79, 0.82, 0.86)
		)
		caption.add_theme_constant_override("line_spacing", 3)
		card_column.add_child(caption)

	var footer := Label.new()
	footer.text = "点击卡片，让小王子也来到这里"
	footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	footer.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	footer.add_theme_color_override(
		"font_color",
		Color(0.76, 0.70, 0.56, 0.72)
	)
	column.add_child(footer)


func _hide_player_characters_for_avatar_picker() -> void:
	for record_value in editable_3d_objects:
		var record: Dictionary = record_value
		if not _is_player_character_kind(String(record.get("kind", ""))):
			continue
		var node := record.get("node") as Node3D
		if node != null and is_instance_valid(node):
			node.visible = false


func _show_player_avatar_picker() -> void:
	if (
		current_3d_scene != "player"
		or player_avatar_picker_completed
		or player_avatar_picker_open
		or player_avatar_picker_overlay == null
	):
		return
	player_avatar_picker_open = true
	player_avatar_picker_choice_locked = false
	player_avatar_picker_generation += 1
	_hide_player_characters_for_avatar_picker()
	for card in player_avatar_picker_cards:
		if card != null and is_instance_valid(card):
			card.disabled = false
			card.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	player_avatar_picker_overlay.visible = true
	player_avatar_picker_overlay.modulate.a = 0.0
	var reveal := create_tween()
	reveal.tween_property(
		player_avatar_picker_overlay,
		"modulate:a",
		1.0,
		0.24
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if hud_scene_hint != null:
		hud_scene_hint.text = "先选一个喜欢的小人，再与小王子一起布置星球"
	if not player_avatar_picker_cards.is_empty():
		player_avatar_picker_cards[0].grab_focus()
	_load_player_avatar_picker_previews(player_avatar_picker_generation)


func _load_player_avatar_picker_previews(generation: int) -> void:
	await get_tree().process_frame
	if (
		generation != player_avatar_picker_generation
		or not player_avatar_picker_open
	):
		return
	if player_avatar_picker_preview_renderer == null:
		player_avatar_picker_preview_renderer = (
			PLAYER_THUMBNAIL_RENDERER_SCRIPT.new()
		)
		player_avatar_picker_preview_renderer.name = (
			"PlayerAvatarPickerPreviewRenderer"
		)
		add_child(player_avatar_picker_preview_renderer)
	for index in PLAYER_AVATAR_OPTIONS.size():
		if (
			generation != player_avatar_picker_generation
			or not player_avatar_picker_open
		):
			return
		var option: Dictionary = PLAYER_AVATAR_OPTIONS[index]
		var asset_data := _player_asset_definition_for_kind(
			String(option.get("kind", ""))
		)
		if asset_data.is_empty() or index >= player_avatar_picker_previews.size():
			continue
		var texture: Texture2D = await (
			player_avatar_picker_preview_renderer.render_avatar_preview(
				asset_data,
				"avatar_front_idle_soft_v3_"
				+ _player_thumbnail_cache_key(asset_data)
			)
		)
		if (
			generation != player_avatar_picker_generation
			or not player_avatar_picker_open
		):
			return
		if texture != null:
			texture = _make_player_avatar_preview_transparent(texture)
			var preview := player_avatar_picker_previews[index]
			if preview != null and is_instance_valid(preview):
				preview.texture = texture


func _make_player_avatar_preview_transparent(texture: Texture2D) -> Texture2D:
	var image := texture.get_image()
	if image == null or image.is_empty():
		return texture
	if image.is_compressed():
		image.decompress()
	image.convert(Image.FORMAT_RGBA8)
	for y in image.get_height():
		for x in image.get_width():
			var color := image.get_pixel(x, y)
			var luminance := maxf(color.r, maxf(color.g, color.b))
			if luminance <= 0.022:
				color.a = 0.0
			elif luminance < 0.070:
				color.a *= smoothstep(0.022, 0.070, luminance)
			image.set_pixel(x, y, color)
	return ImageTexture.create_from_image(image)


func _player_has_chosen_avatar() -> bool:
	for record_value in editable_3d_objects:
		var record: Dictionary = record_value
		if String(record.get("kind", "")) not in PLAYER_PERSON_KINDS:
			continue
		var node := record.get("node") as Node3D
		if node != null and is_instance_valid(node):
			return true
	return false


func _ensure_player_avatar_character(kind: String) -> int:
	var existing_index := _find_editable_record_index_by_kind(kind)
	if existing_index >= 0:
		return existing_index
	if (
		current_3d_scene != "player"
		or not player_placement_plane_ready
		or model_3d == null
	):
		return -1
	var asset_data := _player_asset_definition_for_kind(kind)
	if asset_data.is_empty():
		return -1
	var is_prince := kind == "player_prince"
	var yaw := float(asset_data.get("yaw", 0.0))
	var extent := float(asset_data.get("extent", 0.62))
	var footprint := clampf(extent * 0.30, 0.045, 0.34)
	var surface_normal := player_placement_plane_normal
	var side_offset := 0.92 if is_prince else 0.32
	var position := _clamp_player_placement_plane_position(
		player_placement_plane_center
		+ player_placement_plane_right * side_offset
		+ player_placement_plane_forward * 0.18
	)
	var height_offset := float(player_asset_height_offsets.get(
		kind,
		-0.07 if is_prince else -0.02
	))
	var wrapper := _add_player_asset_fitted(
		model_3d,
		asset_data,
		"Layout_avatar_%s" % kind,
		Transform3D(
			_normal_surface_basis(surface_normal, yaw),
			position + surface_normal * (0.018 + height_offset)
		),
		extent
	)
	if wrapper == null:
		return -1
	_register_editable_3d(
		wrapper,
		kind,
		String(asset_data.get("label", "小人")),
		surface_normal,
		0.0,
		true,
		yaw,
		1.0,
		String(asset_data.get("path", "")),
		false
	)
	var record_index := editable_3d_objects.size() - 1
	var record: Dictionary = editable_3d_objects[record_index]
	record["id"] = (
		"player_prince_avatar_intro"
		if is_prince
		else "%s_avatar_intro" % kind
	)
	record["planet_slug"] = "player"
	record["player_placeable"] = true
	record["placement_footprint"] = footprint
	record["placement_height_offset"] = height_offset
	record["initial_placement_height_offset"] = height_offset
	record["scale"] = float(player_asset_scale_defaults.get(
		kind,
		0.70 if is_prince else 0.75
	))
	record["initial_scale"] = float(record.scale)
	record["default_hidden"] = false
	record["initial_hidden"] = false
	_configure_player_plane_record(record, position, surface_normal)
	_apply_editable_3d_record(record_index)
	_apply_character_animation_choice(wrapper, "ambient_idle", true)
	return record_index


func _reveal_player_avatar_character(index: int, delay: float) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	var node := record.get("node") as Node3D
	if node == null or not is_instance_valid(node):
		return
	record["default_hidden"] = false
	node.visible = true
	var final_scale := node.scale
	node.scale = final_scale * 0.06
	var reveal := create_tween()
	if delay > 0.0:
		reveal.tween_interval(delay)
	reveal.tween_property(node, "scale", final_scale, 0.42) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_player_avatar_chosen(kind: String) -> void:
	if (
		not player_avatar_picker_open
		or player_avatar_picker_choice_locked
		or kind not in PLAYER_PERSON_KINDS
	):
		return
	AudioDirector.play_sfx("ui_primary")
	player_avatar_picker_choice_locked = true
	for card in player_avatar_picker_cards:
		if card != null and is_instance_valid(card):
			card.disabled = true
			card.mouse_default_cursor_shape = Control.CURSOR_ARROW
	var chosen_index := _ensure_player_avatar_character(kind)
	var prince_index := _ensure_player_avatar_character("player_prince")
	if chosen_index < 0 or prince_index < 0:
		player_avatar_picker_choice_locked = false
		for card in player_avatar_picker_cards:
			if card != null and is_instance_valid(card):
				card.disabled = false
				card.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		if hud_scene_hint != null:
			hud_scene_hint.text = "形象载入失败，请再选择一次"
		return
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		if not _is_player_character_kind(String(record.get("kind", ""))):
			continue
		var node := record.get("node") as Node3D
		var should_show := index == chosen_index or index == prince_index
		if String(record.get("kind", "")) in PLAYER_PERSON_KINDS:
			record["default_hidden"] = not (index == chosen_index)
		if not should_show and node != null and is_instance_valid(node):
			node.visible = false
	var chosen: Dictionary = editable_3d_objects[chosen_index]
	var prince: Dictionary = editable_3d_objects[prince_index]
	if String(chosen.get("seat_state", "")) == "seated":
		_stand_player_character(chosen, false)
	if String(prince.get("seat_state", "")) == "seated":
		_stand_player_character(prince, false)
	_set_active_player_character(chosen_index)
	player_avatar_picker_completed = true
	player_avatar_selected = true
	_save_onboarding_state()
	player_character_reset_states.clear()
	_capture_player_character_reset_states()
	_save_3d_layout()
	_refresh_player_seat_glow_markers()
	_reveal_player_avatar_character(chosen_index, 0.04)
	_reveal_player_avatar_character(prince_index, 0.16)
	await _dismiss_player_avatar_picker()
	_refresh_player_scene_hint()
	call_deferred("_maybe_start_player_onboarding")
	call_deferred("_start_player_thumbnail_generation")


func _dismiss_player_avatar_picker() -> void:
	if player_avatar_picker_overlay == null:
		player_avatar_picker_open = false
		return
	player_avatar_picker_generation += 1
	var fade := create_tween()
	fade.tween_property(
		player_avatar_picker_overlay,
		"modulate:a",
		0.0,
		0.28
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await fade.finished
	if player_avatar_picker_overlay != null:
		player_avatar_picker_overlay.visible = false
	player_avatar_picker_open = false
	player_avatar_picker_choice_locked = false


func _close_player_avatar_picker_overlay() -> void:
	player_avatar_picker_generation += 1
	player_avatar_picker_open = false
	player_avatar_picker_choice_locked = false
	if player_avatar_picker_overlay != null:
		player_avatar_picker_overlay.visible = false
		player_avatar_picker_overlay.modulate.a = 1.0


func _build_player_onboarding_guide(root: Control) -> void:
	player_onboarding_overlay = Control.new()
	player_onboarding_overlay.name = "PlayerOnboarding"
	player_onboarding_overlay.z_index = 110
	player_onboarding_overlay.visible = false
	player_onboarding_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	player_onboarding_overlay.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	root.add_child(player_onboarding_overlay)

	var center := CenterContainer.new()
	center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	player_onboarding_overlay.add_child(center)

	player_onboarding_panel = PanelContainer.new()
	player_onboarding_panel.name = "PlayerOnboardingPanel"
	player_onboarding_panel.custom_minimum_size = Vector2(560.0, 190.0)
	player_onboarding_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.96, 0.93, 0.85, 0.97)
	panel_style.border_color = Color(0.50, 0.39, 0.25, 0.72)
	panel_style.set_border_width_all(1)
	panel_style.set_corner_radius_all(3)
	panel_style.shadow_color = Color(0.01, 0.015, 0.025, 0.30)
	panel_style.shadow_size = 9
	panel_style.shadow_offset = Vector2(0.0, 4.0)
	player_onboarding_panel.add_theme_stylebox_override("panel", panel_style)
	center.add_child(player_onboarding_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 34)
	margin.add_theme_constant_override("margin_right", 34)
	margin.add_theme_constant_override("margin_top", 20)
	margin.add_theme_constant_override("margin_bottom", 20)
	player_onboarding_panel.add_child(margin)

	var column := VBoxContainer.new()
	column.alignment = BoxContainer.ALIGNMENT_CENTER
	column.add_theme_constant_override("separation", 7)
	margin.add_child(column)

	player_onboarding_title = _add_label(
		column,
		"",
		Vector2.ZERO,
		Vector2(492.0, 34.0),
		24,
		Color(0.24, 0.16, 0.09, 1.0),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	player_onboarding_title.name = "PlayerOnboardingTitle"
	player_onboarding_title.add_theme_color_override(
		"font_shadow_color",
		Color.TRANSPARENT
	)
	player_onboarding_title.add_theme_constant_override("line_spacing", 2)

	player_onboarding_body = _add_label(
		column,
		"",
		Vector2.ZERO,
		Vector2(492.0, 52.0),
		17,
		Color(0.29, 0.21, 0.14, 0.96),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	player_onboarding_body.name = "PlayerOnboardingBody"
	player_onboarding_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	player_onboarding_body.add_theme_color_override(
		"font_shadow_color",
		Color.TRANSPARENT
	)
	player_onboarding_body.add_theme_constant_override("line_spacing", 3)

	player_onboarding_note = _add_label(
		column,
		"",
		Vector2.ZERO,
		Vector2(492.0, 24.0),
		14,
		Color(0.43, 0.34, 0.25, 0.82),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	player_onboarding_note.name = "PlayerOnboardingNote"
	player_onboarding_note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	player_onboarding_note.add_theme_color_override(
		"font_shadow_color",
		Color.TRANSPARENT
	)
	player_onboarding_note.add_theme_constant_override("line_spacing", 2)

	var button_row := HBoxContainer.new()
	button_row.alignment = BoxContainer.ALIGNMENT_CENTER
	column.add_child(button_row)

	player_onboarding_button = Button.new()
	player_onboarding_button.name = "PlayerOnboardingButton"
	player_onboarding_button.text = "开始探索"
	player_onboarding_button.custom_minimum_size = Vector2(160.0, 40.0)
	_style_button(player_onboarding_button, Color(0.62, 0.49, 0.31))
	player_onboarding_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	player_onboarding_button.pressed.connect(_advance_player_onboarding)
	button_row.add_child(player_onboarding_button)

	player_move_guide = TextureRect.new()
	player_move_guide.name = "PlayerMovementGuide"
	player_move_guide.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	player_move_guide.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	player_move_guide.custom_minimum_size = Vector2.ZERO
	player_move_guide.texture = load(UI_CLICK_GUIDE) as Texture2D
	player_move_guide.size = Vector2(70.0, 101.0)
	player_move_guide.pivot_offset = player_move_guide.size * 0.5
	player_move_guide.mouse_filter = Control.MOUSE_FILTER_IGNORE
	player_move_guide.z_index = 58
	player_move_guide.visible = false
	root.add_child(player_move_guide)

	player_move_guide_caption = Label.new()
	player_move_guide_caption.name = "PlayerGuideCaption"
	player_move_guide_caption.size = Vector2(360.0, 38.0)
	player_move_guide_caption.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	player_move_guide_caption.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	player_move_guide_caption.add_theme_font_size_override("font_size", 18)
	player_move_guide_caption.add_theme_color_override(
		"font_color",
		Color(1.0, 0.94, 0.78, 1.0)
	)
	player_move_guide_caption.add_theme_color_override(
		"font_shadow_color",
		Color(0.01, 0.02, 0.04, 0.94)
	)
	player_move_guide_caption.add_theme_constant_override("shadow_offset_y", 2)
	player_move_guide_caption.add_theme_constant_override("outline_size", 2)
	player_move_guide_caption.add_theme_color_override(
		"font_outline_color",
		Color(0.02, 0.04, 0.07, 0.70)
	)
	player_move_guide_caption.mouse_filter = Control.MOUSE_FILTER_IGNORE
	player_move_guide_caption.z_index = 59
	player_move_guide_caption.visible = false
	root.add_child(player_move_guide_caption)


func _maybe_start_player_onboarding() -> void:
	if (
		current_3d_scene != "player"
		or player_onboarding_completed
		or not player_avatar_picker_completed
		or player_avatar_picker_open
		or player_onboarding_overlay == null
	):
		return
	await get_tree().create_timer(0.55).timeout
	if (
		current_3d_scene == "player"
		and stage_3d != null
		and stage_3d.visible
		and not player_avatar_picker_open
		and not player_onboarding_completed
		and (
			player_onboarding_overlay == null
			or not player_onboarding_overlay.visible
		)
	):
		if not player_move_guide_completed:
			_begin_player_movement_onboarding()
		elif not player_day_night_guide_completed:
			_begin_player_day_night_onboarding()
		elif not player_onboarding_triggered:
			_mark_player_onboarding_triggered()
			_show_player_onboarding_step(1)


func _begin_player_movement_onboarding() -> void:
	if (
		current_3d_scene != "player"
		or player_onboarding_completed
		or player_move_guide_completed
		or not _player_has_chosen_avatar()
		or player_move_guide == null
	):
		return
	player_move_guide_target = _clamp_player_placement_plane_position(
		player_placement_plane_center
		- player_placement_plane_right * 0.34
		+ player_placement_plane_forward * 0.22
	)
	player_move_guide_time = 0.0
	player_move_guide_active = true
	if player_move_guide_caption != null:
		player_move_guide_caption.text = "点击地面，让角色走到这里"
		player_move_guide_caption.visible = true
	player_move_guide.visible = true
	player_move_guide.modulate.a = 0.0
	var reveal := create_tween()
	reveal.tween_property(player_move_guide, "modulate:a", 1.0, 0.22)


func _update_player_movement_guide(delta: float) -> void:
	if player_move_guide == null:
		return
	var guide_active := (
		player_move_guide_active or player_day_night_guide_active
	)
	if (
		not guide_active
		or current_3d_scene != "player"
		or stage_3d == null
		or not stage_3d.visible
		or camera_3d == null
		or model_3d == null
		or player_avatar_picker_open
		or player_onboarding_completed
		or editor_active
		or dialogue_active
		or player_navigation_active
		or (player_place_dock != null and player_place_dock.visible)
	):
		player_move_guide.visible = false
		if player_move_guide_caption != null:
			player_move_guide_caption.visible = false
		return
	var target_world := (
		player_day_night_beacon.global_position
		if player_day_night_guide_active
			and player_day_night_beacon != null
		else model_3d.global_transform * player_move_guide_target
	)
	if camera_3d.is_position_behind(target_world):
		player_move_guide.visible = false
		if player_move_guide_caption != null:
			player_move_guide_caption.visible = false
		return
	player_move_guide_time += delta
	var target_screen := camera_3d.unproject_position(target_world)
	var bob := sin(player_move_guide_time * 4.8) * 5.0
	player_move_guide.position = target_screen + Vector2(-14.0, -19.0 + bob)
	player_move_guide.rotation = sin(player_move_guide_time * 3.1) * 0.035
	player_move_guide.scale = Vector2.ONE * (
		0.98 + 0.055 * sin(player_move_guide_time * 4.8)
	)
	player_move_guide.modulate.a = 1.0
	player_move_guide.visible = true
	if player_move_guide_caption != null:
		var viewport_size := get_viewport().get_visible_rect().size
		var caption_width := minf(360.0, viewport_size.x - 48.0)
		player_move_guide_caption.size = Vector2(caption_width, 38.0)
		player_move_guide_caption.position = Vector2(
			clampf(
				target_screen.x - caption_width * 0.5,
				24.0,
				viewport_size.x - caption_width - 24.0
			),
			clampf(
				target_screen.y + 86.0 + bob,
				24.0,
				viewport_size.y - 62.0
			)
		)
		player_move_guide_caption.modulate.a = 1.0
		player_move_guide_caption.visible = true


func _finish_player_movement_onboarding() -> void:
	if (
		not player_avatar_picker_completed
		or player_move_guide_completed
	):
		return
	player_move_guide_active = false
	player_move_guide_completed = true
	if player_move_guide != null:
		player_move_guide.visible = false
	if player_move_guide_caption != null:
		player_move_guide_caption.visible = false
	_save_onboarding_state()
	if player_onboarding_completed:
		return
	if not player_day_night_guide_completed:
		_begin_player_day_night_onboarding()
		return
	if player_onboarding_triggered:
		return
	_mark_player_onboarding_triggered()
	_show_player_onboarding_step(1)


func _begin_player_day_night_onboarding() -> void:
	if (
		current_3d_scene != "player"
		or player_onboarding_completed
		or player_day_night_guide_completed
		or not player_move_guide_completed
		or player_day_night_beacon == null
		or player_move_guide == null
	):
		return
	player_day_night_target = 0.0
	player_day_night_blend = 0.0
	_apply_player_day_night(0.0)
	player_day_night_guide_active = true
	player_move_guide_time = 0.0
	if player_move_guide_caption != null:
		player_move_guide_caption.text = "点击光点，把夜晚切换为白天"
		player_move_guide_caption.visible = true
	player_move_guide.visible = true
	player_move_guide.modulate.a = 0.0
	var reveal := create_tween()
	reveal.tween_property(player_move_guide, "modulate:a", 1.0, 0.22)


func _finish_player_day_night_onboarding() -> void:
	if (
		not player_day_night_guide_active
		or player_day_night_guide_completed
		or player_day_night_target < 0.5
	):
		return
	player_day_night_guide_active = false
	player_day_night_guide_completed = true
	if player_move_guide != null:
		player_move_guide.visible = false
	if player_move_guide_caption != null:
		player_move_guide_caption.visible = false
	_save_onboarding_state()
	await get_tree().create_timer(1.15).timeout
	if (
		current_3d_scene != "player"
		or player_onboarding_completed
		or player_onboarding_triggered
	):
		return
	_mark_player_onboarding_triggered()
	_show_player_onboarding_step(1)


func _cancel_player_movement_onboarding() -> void:
	player_move_guide_active = false
	player_day_night_guide_active = false
	if player_move_guide != null:
		player_move_guide.visible = false
	if player_move_guide_caption != null:
		player_move_guide_caption.visible = false


func _show_player_onboarding_step(step: int) -> void:
	if player_onboarding_completed or player_onboarding_overlay == null:
		return
	player_onboarding_step = step
	match step:
		0:
			player_onboarding_title.text = "你的星球"
			player_onboarding_body.text = (
				"你和小王子已经来到这里。点地面或发光座位，角色会自己走过去。"
			)
			player_onboarding_note.text = "拖动旋转 | 滚轮缩放 | 双击复位"
			player_onboarding_button.text = "开始探索"
		1:
			player_onboarding_title.text = "先布置这里"
			player_onboarding_body.text = "点右侧“摆放”，把物品或星光纪念拖进星球。"
			player_onboarding_note.text = "滚轮左右翻页，点击空白处取消选择。"
			player_onboarding_button.text = "去摆放"
		_:
			player_onboarding_title.text = "留下这段旅程"
			player_onboarding_body.text = (
				"右下角可以保存布置、拍照写信、和小王子说话，"
				+ "或用贴纸表达心情。"
			)
			player_onboarding_note.text = ""
			player_onboarding_button.text = "开始探索"
	player_onboarding_overlay.visible = true
	player_onboarding_overlay.modulate.a = 0.0
	if hud_scene_hint != null:
		hud_scene_hint.text = ""
	var reveal := create_tween()
	reveal.tween_property(
		player_onboarding_overlay,
		"modulate:a",
		1.0,
		0.22
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _advance_player_onboarding() -> void:
	AudioDirector.play_sfx("ui_soft")
	match player_onboarding_step:
		0:
			_show_player_onboarding_step(1)
		1:
			_hide_player_onboarding_guide()
			player_onboarding_step = 2
			_toggle_player_placement_dock()
		_:
			_complete_player_onboarding()


func _hide_player_onboarding_guide() -> void:
	if player_onboarding_overlay != null:
		player_onboarding_overlay.visible = false
		player_onboarding_overlay.modulate.a = 1.0


func _complete_player_onboarding() -> void:
	player_onboarding_triggered = true
	player_onboarding_completed = true
	player_onboarding_step = -1
	_hide_player_onboarding_guide()
	_begin_player_hint_cycle()


func _build_player_expression_ui(root: Control) -> void:
	var symbol_style := StyleBoxEmpty.new()
	var symbol_hover := StyleBoxEmpty.new()

	player_save_symbol_button = Button.new()
	player_save_symbol_button.name = "PlayerSaveSymbol"
	player_save_symbol_button.text = ""
	player_save_symbol_button.tooltip_text = "保存当前星球摆放"
	player_save_symbol_button.size = Vector2(80.0, 80.0)
	player_save_symbol_button.z_index = 46
	player_save_symbol_button.focus_mode = Control.FOCUS_NONE
	player_save_symbol_button.visible = false
	player_save_symbol_button.icon = load(PLAYER_SAVE_SYMBOL) as Texture2D
	player_save_symbol_button.expand_icon = true
	player_save_symbol_button.add_theme_constant_override("icon_max_width", 74)
	player_save_symbol_button.add_theme_stylebox_override("normal", symbol_style)
	player_save_symbol_button.add_theme_stylebox_override("hover", symbol_hover)
	player_save_symbol_button.add_theme_stylebox_override("pressed", symbol_hover)
	player_save_symbol_button.add_theme_stylebox_override("focus", symbol_hover)
	player_save_symbol_button.mouse_default_cursor_shape = (
		Control.CURSOR_POINTING_HAND
	)
	player_save_symbol_button.pressed.connect(_on_player_save_symbol_pressed)
	root.add_child(player_save_symbol_button)
	_register_ui_control(
		player_save_symbol_button,
		"hud.player_save_symbol",
		"玩家保存摆放符号",
		false
	)

	player_photo_symbol_button = Button.new()
	player_photo_symbol_button.name = "PlayerPhotoSymbol"
	player_photo_symbol_button.text = ""
	player_photo_symbol_button.tooltip_text = "为星球拍照并生成纪念信"
	player_photo_symbol_button.size = Vector2(80.0, 80.0)
	player_photo_symbol_button.z_index = 46
	player_photo_symbol_button.focus_mode = Control.FOCUS_NONE
	player_photo_symbol_button.visible = false
	player_photo_symbol_button.icon = load(PLAYER_PHOTO_SYMBOL) as Texture2D
	player_photo_symbol_button.expand_icon = true
	player_photo_symbol_button.add_theme_constant_override("icon_max_width", 74)
	player_photo_symbol_button.add_theme_stylebox_override("normal", symbol_style)
	player_photo_symbol_button.add_theme_stylebox_override("hover", symbol_hover)
	player_photo_symbol_button.add_theme_stylebox_override("pressed", symbol_hover)
	player_photo_symbol_button.add_theme_stylebox_override("focus", symbol_hover)
	player_photo_symbol_button.mouse_default_cursor_shape = (
		Control.CURSOR_POINTING_HAND
	)
	player_photo_symbol_button.pressed.connect(_on_player_photo_symbol_pressed)
	root.add_child(player_photo_symbol_button)
	_register_ui_control(
		player_photo_symbol_button,
		"hud.player_photo_symbol",
		"玩家拍照信纸符号",
		false
	)

	player_save_toast = Label.new()
	player_save_toast.name = "PlayerSaveToast"
	player_save_toast.text = "已保存"
	player_save_toast.size = Vector2(128.0, 38.0)
	player_save_toast.z_index = 49
	player_save_toast.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	player_save_toast.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	player_save_toast.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	player_save_toast.add_theme_color_override(
		"font_color",
		Color(0.31, 0.21, 0.14, 1.0)
	)
	var toast_style := StyleBoxFlat.new()
	toast_style.bg_color = Color(0.95, 0.89, 0.74, 0.96)
	toast_style.border_color = Color(0.61, 0.46, 0.27, 0.72)
	toast_style.set_border_width_all(1)
	toast_style.set_corner_radius_all(12)
	toast_style.shadow_color = Color(0.0, 0.0, 0.0, 0.34)
	toast_style.shadow_size = 8
	player_save_toast.add_theme_stylebox_override("normal", toast_style)
	player_save_toast.mouse_filter = Control.MOUSE_FILTER_IGNORE
	player_save_toast.visible = false
	root.add_child(player_save_toast)
	_register_ui_control(
		player_save_toast,
		"hud.player_save_toast",
		"玩家保存提示"
	)

	player_dialogue_bubble_root = Control.new()
	player_dialogue_bubble_root.name = "PlayerDialogueBubbles"
	player_dialogue_bubble_root.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	player_dialogue_bubble_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	player_dialogue_bubble_root.z_index = 47
	player_dialogue_bubble_root.visible = false
	root.add_child(player_dialogue_bubble_root)

	player_dialogue_symbol_button = Button.new()
	player_dialogue_symbol_button.name = "PlayerDialogueSymbol"
	player_dialogue_symbol_button.text = ""
	player_dialogue_symbol_button.tooltip_text = "和小王子对话"
	player_dialogue_symbol_button.size = Vector2(80.0, 80.0)
	player_dialogue_symbol_button.z_index = 46
	player_dialogue_symbol_button.focus_mode = Control.FOCUS_NONE
	player_dialogue_symbol_button.visible = false
	player_dialogue_symbol_button.icon = load(PLAYER_DIALOGUE_SYMBOL) as Texture2D
	player_dialogue_symbol_button.expand_icon = true
	player_dialogue_symbol_button.add_theme_constant_override("icon_max_width", 74)
	player_dialogue_symbol_button.add_theme_stylebox_override("normal", symbol_style)
	player_dialogue_symbol_button.add_theme_stylebox_override("hover", symbol_hover)
	player_dialogue_symbol_button.add_theme_stylebox_override("pressed", symbol_hover)
	player_dialogue_symbol_button.add_theme_stylebox_override("focus", symbol_hover)
	player_dialogue_symbol_button.mouse_default_cursor_shape = (
		Control.CURSOR_POINTING_HAND
	)
	player_dialogue_symbol_button.pressed.connect(
		_on_player_dialogue_symbol_pressed
	)
	root.add_child(player_dialogue_symbol_button)
	_register_ui_control(
		player_dialogue_symbol_button,
		"hud.player_dialogue_symbol",
		"玩家对话符号",
		false
	)

	player_sticker_symbol_button = Button.new()
	player_sticker_symbol_button.name = "PlayerStickerSymbol"
	player_sticker_symbol_button.text = ""
	player_sticker_symbol_button.tooltip_text = "打开或收起贴纸表情"
	player_sticker_symbol_button.size = Vector2(80.0, 80.0)
	player_sticker_symbol_button.z_index = 46
	player_sticker_symbol_button.focus_mode = Control.FOCUS_NONE
	player_sticker_symbol_button.visible = false
	player_sticker_symbol_button.icon = load(PLAYER_STICKER_SYMBOL) as Texture2D
	player_sticker_symbol_button.expand_icon = true
	player_sticker_symbol_button.add_theme_constant_override("icon_max_width", 74)
	player_sticker_symbol_button.add_theme_stylebox_override("normal", symbol_style)
	player_sticker_symbol_button.add_theme_stylebox_override("hover", symbol_hover)
	player_sticker_symbol_button.add_theme_stylebox_override("pressed", symbol_hover)
	player_sticker_symbol_button.add_theme_stylebox_override("focus", symbol_hover)
	player_sticker_symbol_button.mouse_default_cursor_shape = (
		Control.CURSOR_POINTING_HAND
	)
	player_sticker_symbol_button.pressed.connect(
		_on_player_sticker_symbol_pressed
	)
	root.add_child(player_sticker_symbol_button)
	_register_ui_control(
		player_sticker_symbol_button,
		"hud.player_sticker_symbol",
		"玩家贴纸符号",
		false
	)

	player_expression_bar = PanelContainer.new()
	player_expression_bar.name = "PlayerExpressionBar"
	player_expression_bar.anchor_left = 0.5
	player_expression_bar.anchor_right = 0.5
	player_expression_bar.anchor_top = 1.0
	player_expression_bar.anchor_bottom = 1.0
	player_expression_bar.offset_left = -460.0
	player_expression_bar.offset_right = 460.0
	player_expression_bar.offset_top = -218.0
	player_expression_bar.offset_bottom = -96.0
	player_expression_bar.visible = false
	player_expression_bar.z_index = 44
	player_expression_bar.mouse_filter = Control.MOUSE_FILTER_STOP
	var expression_bar_style := StyleBoxFlat.new()
	expression_bar_style.bg_color = Color(0.025, 0.030, 0.045, 0.72)
	expression_bar_style.border_color = Color(0.88, 0.78, 0.57, 0.36)
	expression_bar_style.border_width_top = 1
	expression_bar_style.set_corner_radius_all(14)
	expression_bar_style.shadow_color = Color(0.0, 0.0, 0.0, 0.34)
	expression_bar_style.shadow_size = 12
	player_expression_bar.add_theme_stylebox_override(
		"panel",
		expression_bar_style
	)
	root.add_child(player_expression_bar)
	_register_ui_control(
		player_expression_bar,
		"hud.player_expression_bar",
		"玩家贴纸表情栏"
	)

	var expression_margin := MarginContainer.new()
	expression_margin.add_theme_constant_override("margin_left", 18)
	expression_margin.add_theme_constant_override("margin_right", 18)
	expression_margin.add_theme_constant_override("margin_top", 12)
	expression_margin.add_theme_constant_override("margin_bottom", 12)
	expression_margin.mouse_filter = Control.MOUSE_FILTER_PASS
	player_expression_bar.add_child(expression_margin)

	player_expression_scroll = ScrollContainer.new()
	player_expression_scroll.name = "PlayerExpressionScroll"
	player_expression_scroll.horizontal_scroll_mode = (
		ScrollContainer.SCROLL_MODE_AUTO
	)
	player_expression_scroll.vertical_scroll_mode = (
		ScrollContainer.SCROLL_MODE_DISABLED
	)
	player_expression_scroll.scroll_horizontal_custom_step = 92.0
	player_expression_scroll.mouse_filter = Control.MOUSE_FILTER_STOP
	expression_margin.add_child(player_expression_scroll)

	player_expression_row = HBoxContainer.new()
	player_expression_row.name = "PlayerExpressionRow"
	player_expression_row.add_theme_constant_override("separation", 10)
	player_expression_row.mouse_filter = Control.MOUSE_FILTER_PASS
	player_expression_scroll.add_child(player_expression_row)
	player_expression_buttons.clear()
	var expression_button_style := StyleBoxFlat.new()
	expression_button_style.bg_color = Color(0.94, 0.90, 0.79, 0.98)
	expression_button_style.border_color = Color(0.53, 0.40, 0.25, 0.72)
	expression_button_style.set_border_width_all(1)
	expression_button_style.set_corner_radius_all(12)
	expression_button_style.shadow_color = Color(0.0, 0.0, 0.0, 0.30)
	expression_button_style.shadow_size = 5
	var expression_button_hover := expression_button_style.duplicate() as StyleBoxFlat
	expression_button_hover.bg_color = Color(1.0, 0.95, 0.80, 1.0)
	expression_button_hover.border_color = Color(0.82, 0.62, 0.26, 0.98)
	expression_button_hover.shadow_size = 9
	for expression_value in PLAYER_EXPRESSIONS:
		var expression: Dictionary = expression_value
		var expression_id := String(expression.id)
		var expression_button := Button.new()
		expression_button.name = "PlayerExpression_" + expression_id
		expression_button.text = ""
		expression_button.tooltip_text = String(expression.label)
		expression_button.size = Vector2(78.0, 78.0)
		expression_button.custom_minimum_size = Vector2(78.0, 78.0)
		expression_button.focus_mode = Control.FOCUS_NONE
		expression_button.icon = load(
			PLAYER_EXPRESSION_DIR + expression_id + ".png"
		) as Texture2D
		expression_button.expand_icon = true
		expression_button.add_theme_constant_override("icon_max_width", 72)
		expression_button.add_theme_stylebox_override(
			"normal",
			expression_button_style
		)
		expression_button.add_theme_stylebox_override(
			"hover",
			expression_button_hover
		)
		expression_button.add_theme_stylebox_override(
			"pressed",
			expression_button_hover
		)
		expression_button.add_theme_stylebox_override(
			"focus",
			expression_button_hover
		)
		expression_button.mouse_default_cursor_shape = (
			Control.CURSOR_POINTING_HAND
		)
		expression_button.pressed.connect(
			_on_player_expression_pressed.bind(expression_id)
		)
		player_expression_row.add_child(expression_button)
		player_expression_buttons.append(expression_button)
		_register_ui_control(
			expression_button,
			"hud.player_expression." + expression_id,
			"玩家表情：" + String(expression.label)
		)

	player_expression_overlay = Control.new()
	player_expression_overlay.name = "PlayerExpressionOverlay"
	player_expression_overlay.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	player_expression_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	player_expression_overlay.z_index = 48
	root.add_child(player_expression_overlay)
	player_expression_popup = _create_expression_popup("PlayerExpressionPopup")
	prince_expression_popup = _create_expression_popup("PrinceExpressionPopup")
	player_expression_overlay.add_child(player_expression_popup)
	player_expression_overlay.add_child(prince_expression_popup)

	player_keepsake_flow = PLAYER_KEEPSAKE_FLOW_SCRIPT.new()
	player_keepsake_flow.name = "PlayerKeepsakeFlow"
	add_child(player_keepsake_flow)
	player_keepsake_flow.setup(
		camera_3d,
		self,
		hud_3d,
		ui_layout_editor,
		interface_font
	)
	player_keepsake_flow.flow_closed.connect(
		_on_player_keepsake_flow_closed
	)
	player_keepsake_flow.letter_saved.connect(
		_on_player_keepsake_letter_saved
	)


func _create_expression_popup(node_name: String) -> TextureRect:
	var popup := TextureRect.new()
	popup.name = node_name
	popup.size = Vector2(176.0, 176.0)
	popup.pivot_offset = popup.size * 0.5
	popup.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	popup.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	popup.mouse_filter = Control.MOUSE_FILTER_IGNORE
	popup.visible = false
	popup.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	return popup


func _refresh_player_placeable_entries() -> void:
	player_placeable_entries.clear()
	for asset_value in PLAYER_PLACEABLE_ASSETS:
		var entry: Dictionary = (asset_value as Dictionary).duplicate(true)
		entry["page"] = "items"
		entry["memory_slug"] = ""
		player_placeable_entries.append(entry)
	player_placeable_entries.append({
		"kind": "player_light_string_tool",
		"label": "灯串",
		"path": "",
		"extent": 0.8,
		"yaw": 0.0,
		"page": "stars",
		"memory_slug": "",
		"tool": "light_string",
		"thumbnail_path": "res://assets/ui/player_light_string_card.png",
	})
	for slug in MEMORY_ORDER:
		if String(memory_collection_states.get(slug, "locked")) != "collected":
			continue
		var star_assets = STAR_BACKPACK_PLACEABLE_ASSETS.get(slug, [])
		if typeof(star_assets) != TYPE_ARRAY:
			continue
		for star_asset in star_assets:
			if typeof(star_asset) != TYPE_DICTIONARY:
				continue
			var star_entry: Dictionary = (
				(star_asset as Dictionary).duplicate(true)
			)
			star_entry["page"] = "stars"
			star_entry["memory_slug"] = String(slug)
			player_placeable_entries.append(star_entry)


func _star_backpack_asset_for_kind(kind: String) -> Dictionary:
	var canonical_kind := String(
		LEGACY_STAR_PLACEABLE_KIND_MAP.get(kind, kind)
	)
	for slug in MEMORY_ORDER:
		var star_assets = STAR_BACKPACK_PLACEABLE_ASSETS.get(slug, [])
		if typeof(star_assets) != TYPE_ARRAY:
			continue
		for star_asset in star_assets:
			if (
				typeof(star_asset) == TYPE_DICTIONARY
				and String(star_asset.get("kind", "")) == canonical_kind
			):
				return (star_asset as Dictionary).duplicate(true)
	return {}


func _collected_star_placeable_count() -> int:
	var total := 0
	for slug in MEMORY_ORDER:
		if String(memory_collection_states.get(slug, "locked")) != "collected":
			continue
		var star_assets = STAR_BACKPACK_PLACEABLE_ASSETS.get(slug, [])
		if typeof(star_assets) == TYPE_ARRAY:
			total += star_assets.size()
	return total + 1


func _player_placeable_entry(asset_index: int) -> Dictionary:
	if asset_index < 0 or asset_index >= player_placeable_entries.size():
		return {}
	return player_placeable_entries[asset_index]


func _sync_player_place_page_tabs() -> void:
	if player_place_items_tab == null or player_place_stars_tab == null:
		return
	player_place_items_tab.modulate = (
		Color.WHITE
		if player_place_page == "items"
		else Color(0.74, 0.72, 0.66, 0.72)
	)
	player_place_stars_tab.modulate = (
		Color.WHITE
		if player_place_page == "stars"
		else Color(0.74, 0.72, 0.66, 0.72)
	)


func _rebuild_player_place_cards() -> void:
	if player_place_row == null:
		return
	player_asset_cards.clear()
	for child in player_place_row.get_children():
		player_place_row.remove_child(child)
		child.queue_free()
	for asset_index in player_placeable_entries.size():
		var asset_data: Dictionary = player_placeable_entries[asset_index]
		if String(asset_data.get("page", "items")) != player_place_page:
			continue
		var card = PLAYER_ASSET_CARD_SCRIPT.new()
		card.configure(asset_index, String(asset_data.label))
		card.connect(
			"asset_drag_started",
			Callable(self, "_on_player_asset_drag_started")
		)
		card.connect(
			"asset_drag_moved",
			Callable(self, "_on_player_asset_drag_moved")
		)
		card.connect(
			"asset_drag_ended",
			Callable(self, "_on_player_asset_drag_ended")
		)
		player_place_row.add_child(card)
		player_asset_cards.append(card)
		var cached_texture: Texture2D = player_thumbnail_textures.get(
			_player_thumbnail_cache_key(asset_data),
			null
		)
		if cached_texture != null:
			card.set_thumbnail(cached_texture)
	if player_asset_cards.is_empty() and player_place_page == "stars":
		var empty_label := Label.new()
		empty_label.text = "尚未收集星光。完成前六颗星球的场景后，星光会来到这里。"
		empty_label.custom_minimum_size = Vector2(560.0, 126.0)
		empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		empty_label.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
		empty_label.add_theme_color_override(
			"font_color",
			Color(0.84, 0.80, 0.70, 0.72)
		)
		player_place_row.add_child(empty_label)
	_sync_player_place_page_tabs()
	if player_place_page == "stars":
		var collected_count := 0
		for slug in MEMORY_ORDER:
			if String(memory_collection_states.get(slug, "locked")) == "collected":
				collected_count += 1
		player_place_status.text = "星光 %d / %d | %d 件" % [
			collected_count,
			MEMORY_ORDER.size(),
			_collected_star_placeable_count(),
		]
	else:
		player_place_status.text = "%d 个模型" % player_asset_cards.size()


func _switch_player_place_page(page: String) -> void:
	if page not in ["items", "stars"]:
		return
	if player_3d_drag_preview != null:
		player_3d_drag_preview.queue_free()
		player_3d_drag_preview = null
	player_3d_drag_preview_asset_index = -1
	player_dragged_asset_index = -1
	player_drag_last_screen_position = Vector2.ZERO
	player_place_page = page
	_refresh_player_placeable_entries()
	_rebuild_player_place_cards()
	if player_place_scroll != null:
		player_place_scroll.scroll_horizontal = 0
	call_deferred("_start_player_thumbnail_generation")


func _refresh_player_scene_hint() -> void:
	if (
		current_3d_scene != "player"
		or hud_scene_hint == null
	):
		return
	_apply_player_scene_hint_layout()
	if player_place_dock != null and player_place_dock.visible:
		hud_scene_hint.text = (
			"摆放已打开 | 点击物品显示调整按钮 | 拖动摆位 | 点击空白取消选择"
		)
		return
	_begin_player_hint_cycle()


func _apply_player_scene_hint_layout() -> void:
	if hud_scene_hint == null:
		return
	hud_scene_hint.position = Vector2(400.0, 923.0)
	hud_scene_hint.size = Vector2(800.0, 44.0)
	hud_scene_hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func _begin_player_hint_cycle() -> void:
	if hud_scene_hint == null or PLAYER_IDLE_HINTS.is_empty():
		return
	player_hint_cycle_index = 0
	player_hint_cycle_elapsed = 0.0
	hud_scene_hint.text = String(PLAYER_IDLE_HINTS[0])
	hud_scene_hint.modulate.a = 1.0


func _update_player_hint_cycle(delta: float) -> void:
	if (
		current_3d_scene != "player"
		or hud_scene_hint == null
		or stage_3d == null
		or not stage_3d.visible
	):
		return
	_apply_player_scene_hint_layout()
	if (
		player_onboarding_overlay != null
		and player_onboarding_overlay.visible
	):
		if hud_scene_hint.text in PLAYER_IDLE_HINTS:
			hud_scene_hint.text = ""
		return
	if player_avatar_picker_open:
		return
	if player_place_dock != null and player_place_dock.visible:
		return
	if (
		dialogue_active
		or editor_active
		or (
			player_keepsake_flow != null
			and bool(player_keepsake_flow.visible)
		)
		or (
			player_expression_bar != null
			and player_expression_bar.visible
		)
	):
		if hud_scene_hint.text in PLAYER_IDLE_HINTS:
			hud_scene_hint.text = ""
		return
	if PLAYER_IDLE_HINTS.is_empty():
		return
	var cycle_text := String(PLAYER_IDLE_HINTS[player_hint_cycle_index])
	if hud_scene_hint.text.is_empty():
		hud_scene_hint.text = cycle_text
		hud_scene_hint.modulate.a = 1.0
	elif hud_scene_hint.text != cycle_text:
		return
	player_hint_cycle_elapsed += delta
	if player_hint_cycle_elapsed < STORY_HINT_CYCLE_SECONDS:
		return
	player_hint_cycle_elapsed = 0.0
	player_hint_cycle_index = (
		(player_hint_cycle_index + 1) % PLAYER_IDLE_HINTS.size()
	)
	_set_player_hint_animated(
		String(PLAYER_IDLE_HINTS[player_hint_cycle_index])
	)


func _set_player_hint_animated(text: String) -> void:
	if hud_scene_hint == null or hud_scene_hint.text == text:
		return
	if player_hint_cycle_tween != null and player_hint_cycle_tween.is_valid():
		player_hint_cycle_tween.kill()
	player_hint_cycle_tween = create_tween()
	player_hint_cycle_tween.tween_property(
		hud_scene_hint,
		"modulate:a",
		0.0,
		0.18
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	player_hint_cycle_tween.tween_callback(
		func() -> void:
			if hud_scene_hint != null:
				hud_scene_hint.text = text
	)
	player_hint_cycle_tween.tween_property(
		hud_scene_hint,
		"modulate:a",
		1.0,
		0.24
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _toggle_player_placement_dock() -> void:
	if current_3d_scene != "player" or player_place_dock == null:
		return
	if editor_active:
		return
	AudioDirector.play_sfx("ui_soft")
	player_place_dock.visible = not player_place_dock.visible
	if player_place_dock.visible:
		player_place_button_feedback_started_msec = Time.get_ticks_msec()
		if player_move_guide_active:
			player_move_guide_completed = true
			_cancel_player_movement_onboarding()
			if not player_onboarding_triggered:
				player_onboarding_triggered = true
			_save_onboarding_state()
		elif player_day_night_guide_active:
			player_day_night_guide_completed = true
			_cancel_player_movement_onboarding()
			if not player_onboarding_triggered:
				player_onboarding_triggered = true
			_save_onboarding_state()
		if (
			player_onboarding_overlay != null
			and player_onboarding_overlay.visible
		):
			_hide_player_onboarding_guide()
		if (
			not player_onboarding_completed
			and player_onboarding_step < 2
		):
			player_onboarding_step = 2
		_cancel_player_placement_selection()
		_close_player_character_interaction()
		_close_player_prince_interaction()
		_cancel_player_navigation(true)
		_refresh_player_placeable_entries()
		_rebuild_player_place_cards()
		_sync_player_place_height_control()
		call_deferred("_start_player_thumbnail_generation")
	else:
		_cancel_player_placement_selection()
		_sync_player_place_height_control()
	_update_player_character_interaction_buttons()
	_refresh_player_scene_hint()
	if (
		not player_place_dock.visible
		and not player_onboarding_completed
		and player_onboarding_step == 2
	):
		call_deferred("_show_player_onboarding_step", 3)


func _selected_player_support_record() -> Dictionary:
	if (
		current_3d_scene != "player"
		or selected_editable_index < 0
		or selected_editable_index >= editable_3d_objects.size()
	):
		return {}
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if not _is_player_plane_record(record):
		return {}
	if _is_player_character_kind(String(record.get("kind", ""))):
		return record
	if String(record.get("placement_support_id", "")).is_empty():
		return {}
	return record


func _player_standing_height_locked(record: Dictionary) -> bool:
	return bool(player_standing_height_locks.get(
		String(record.get("kind", "")),
		false
	))


func _player_sitting_height_locked(record: Dictionary) -> bool:
	var seat_kind := String(record.get("seat_kind", ""))
	if seat_kind.is_empty():
		return false
	var pose_key := _player_seat_pose_key(
		String(record.get("kind", "")),
		seat_kind
	)
	return bool(player_sitting_height_locks.get(pose_key, false))


func _toggle_player_character_height_lock(mode: String) -> void:
	var record := _selected_player_support_record()
	if (
		record.is_empty()
		or not _is_player_character_kind(String(record.get("kind", "")))
		or mode not in ["standing", "sitting"]
	):
		return
	var locked := false
	if mode == "standing":
		var kind := String(record.get("kind", ""))
		locked = not _player_standing_height_locked(record)
		player_standing_height_locks[kind] = locked
	else:
		var seat_kind := String(record.get("seat_kind", ""))
		if seat_kind.is_empty():
			player_place_status.text = "人物尚未绑定座位"
			return
		var pose_key := _player_seat_pose_key(
			String(record.get("kind", "")),
			seat_kind
		)
		locked = not _player_sitting_height_locked(record)
		player_sitting_height_locks[pose_key] = locked
	_sync_player_place_height_control()
	if editor_active:
		_sync_editor_controls()
	_save_3d_layout()
	player_place_status.text = (
		"站立高度已锁定"
		if mode == "standing" and locked
		else (
			"站立高度已解锁"
			if mode == "standing"
			else (
				"坐下高度已锁定"
				if locked
				else "坐下高度已解锁"
			)
		)
	)


func _apply_player_character_seat_height(
	record: Dictionary,
	height_offset: float
) -> void:
	var seat_index := _find_editable_record_index(
		String(record.get("seat_id", "")),
		-1
	)
	if seat_index < 0:
		return
	var seat_record: Dictionary = editable_3d_objects[seat_index]
	var seat_node := seat_record.get("node") as Node3D
	var character_node := record.get("node") as Node3D
	if seat_node == null or character_node == null:
		return
	var default_offset := _default_player_seat_offset(
		seat_node,
		int(record.get("seat_slot_index", 0)),
		int(record.get("seat_slot_count", 1))
	)
	var local_offset := (
		seat_node.transform.affine_inverse()
		* character_node.transform.origin
	)
	local_offset.y = default_offset.y + height_offset
	var target_position := seat_node.transform * local_offset
	record["position"] = target_position
	record["initial_position"] = target_position
	record["root_radius"] = target_position.y
	record["initial_root_radius"] = target_position.y
	record["seat_height"] = height_offset
	record["placement_height_offset"] = 0.0
	record["initial_placement_height_offset"] = 0.0
	record["placement_plane_normal"] = (
		seat_node.transform.basis * Vector3.UP
	).normalized()
	_apply_editable_3d_record(selected_editable_index)


func _sync_player_place_height_control() -> void:
	if player_place_height_row == null:
		return
	var record := _selected_player_support_record()
	var can_adjust := not record.is_empty() and player_place_dock != null \
		and player_place_dock.visible
	player_place_height_row.visible = can_adjust
	var is_character := _is_player_character_kind(
		String(record.get("kind", ""))
	)
	if player_height_lock_row != null:
		player_height_lock_row.visible = can_adjust and is_character
	if not can_adjust:
		return
	var is_seated := (
		is_character
		and String(record.get("seat_state", "")) == "seated"
	)
	var height_offset := 0.0
	if is_character:
		height_offset = float(record.get(
			"seat_height" if is_seated else "placement_height_offset",
			0.0
		))
		player_place_height_title.text = (
			"坐姿高度" if is_seated else "站立高度"
		)
		player_place_height_title.tooltip_text = (
			"沿座位法线调整人物坐下时与接触面的距离"
			if is_seated
			else "沿地面法线调整人物站立时离地面的距离"
		)
		var standing_locked := _player_standing_height_locked(record)
		var sitting_locked := _player_sitting_height_locked(record)
		player_standing_height_lock_button.set_pressed_no_signal(
			standing_locked
		)
		player_sitting_height_lock_button.set_pressed_no_signal(
			sitting_locked
		)
		player_standing_height_lock_button.text = (
			"站立高度：已锁定"
			if standing_locked
			else "站立高度：锁定"
		)
		player_sitting_height_lock_button.text = (
			"坐下高度：已锁定"
			if sitting_locked
			else "坐下高度：锁定"
		)
		player_standing_height_lock_button.modulate = (
			Color.WHITE
			if not is_seated
			else Color(0.68, 0.70, 0.70, 0.72)
		)
		player_sitting_height_lock_button.modulate = (
			Color.WHITE
			if is_seated
			else Color(0.68, 0.70, 0.70, 0.72)
		)
		player_place_height_slider.editable = not (
			sitting_locked if is_seated else standing_locked
		)
	else:
		height_offset = float(record.get(
			"placement_height_offset",
			0.0
		))
		var item_height_locked := bool(
			record.get("placement_height_locked", false)
		)
		player_place_height_title.text = (
			"离吸附面（已锁定）"
			if item_height_locked
			else "离吸附面"
		)
		player_place_height_title.tooltip_text = (
			"当前物件高度已锁定"
			if item_height_locked
			else "调整选中物件沿桌面或垫面法线的高度"
		)
		player_place_height_slider.editable = not item_height_locked
	height_offset = clampf(
		height_offset,
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	player_place_height_slider.set_block_signals(true)
	player_place_height_slider.set_value_no_signal(height_offset)
	player_place_height_slider.set_block_signals(false)
	player_place_height_value.text = "%+.2f" % height_offset
	# Placement height is authored for the default player layout. Keep the
	# dock focused on placing and arranging objects instead of exposing raw
	# ground/snap offsets to players.
	player_place_height_row.visible = false
	if player_height_lock_row != null:
		player_height_lock_row.visible = false


func _on_player_place_height_changed(value: float) -> void:
	var record := _selected_player_support_record()
	if record.is_empty():
		return
	var height_offset := clampf(
		value,
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	var character_kind := String(record.get("kind", ""))
	if _is_player_character_kind(character_kind):
		var is_seated := String(record.get("seat_state", "")) == "seated"
		var is_locked := (
			_player_sitting_height_locked(record)
			if is_seated
			else _player_standing_height_locked(record)
		)
		if is_locked:
			_sync_player_place_height_control()
			if player_place_status != null:
				player_place_status.text = (
					"坐下高度已锁定"
					if is_seated
					else "站立高度已锁定"
				)
			return
		if is_seated:
			_apply_player_character_seat_height(record, height_offset)
		else:
			if is_equal_approx(
				float(record.get("placement_height_offset", 0.0)),
				height_offset
			):
				return
			record["placement_height_offset"] = height_offset
			if String(record.get("placement_support_id", "")).is_empty():
				player_asset_height_offsets[character_kind] = height_offset
			_apply_editable_3d_record(selected_editable_index)
	else:
		if bool(record.get("placement_height_locked", false)):
			_sync_player_place_height_control()
			player_place_status.text = "当前物件高度已锁定"
			return
		if is_equal_approx(
			float(record.get("placement_height_offset", 0.0)),
			height_offset
		):
			return
		_set_player_record_height_for_context(
			record,
			not String(record.get("placement_support_id", "")).is_empty(),
			height_offset,
			true
		)
		_apply_editable_3d_record(selected_editable_index)
	player_place_height_value.text = "%+.2f" % height_offset
	_update_editor_selection_ring()
	_sync_editor_controls()
	player_place_status.text = "%s | %s %+.2f" % [
		String(record.label),
		"坐姿高度" if (
			_is_player_character_kind(character_kind)
			and String(record.get("seat_state", "")) == "seated"
		) else "离吸附面",
		height_offset,
	]


func _on_player_place_height_drag_ended(value_changed: bool) -> void:
	if not value_changed:
		return
	_save_3d_layout()


func _nudge_player_place_height(amount: float) -> void:
	if player_place_height_slider == null:
		return
	player_place_height_slider.value = clampf(
		player_place_height_slider.value + amount,
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	_save_3d_layout()


func _close_player_placement_dock() -> void:
	if player_place_dock != null:
		player_place_dock.visible = false
	_cancel_player_placement_selection()
	_sync_player_place_height_control()
	if player_3d_drag_preview != null:
		player_3d_drag_preview.queue_free()
		player_3d_drag_preview = null
	player_3d_drag_preview_asset_index = -1
	player_dragged_asset_index = -1
	player_drag_last_screen_position = Vector2.ZERO
	_refresh_player_scene_hint()


func _update_player_placement_scene(slug: String) -> void:
	var is_player := slug == "player"
	if (
		not is_player
		and player_keepsake_flow != null
		and bool(player_keepsake_flow.visible)
	):
		player_keepsake_flow.close_flow()
	if player_place_button != null:
		player_place_button.visible = is_player
	_update_player_day_night_beacon()
	if player_character_reset_button != null:
		player_character_reset_button.visible = false
	if editor_edit_button != null and is_player:
		editor_edit_button.visible = false
	if not is_player and player_save_toast != null:
		player_save_toast.visible = false
	if not is_player:
		_release_player_handhold()
		_close_player_prince_interaction()
		_cancel_player_navigation(false)
		_close_player_placement_dock()
		_cancel_player_placement_selection()
		_cancel_player_light_string_mode()
	else:
		selected_editable_index = -1
		player_placement_selected_index = -1
		player_placement_object_dragging = false
		if editor_selection_ring != null:
			editor_selection_ring.visible = false
		_refresh_player_placeable_entries()
		_rebuild_player_place_cards()
		call_deferred("_start_player_thumbnail_generation")


func _on_player_place_scroll_gui_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton or player_place_scroll == null:
		return
	var mouse_button := event as InputEventMouseButton
	if not mouse_button.pressed:
		return
	if mouse_button.button_index == MOUSE_BUTTON_WHEEL_UP:
		player_place_scroll.scroll_horizontal -= 150
		get_viewport().set_input_as_handled()
	elif mouse_button.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		player_place_scroll.scroll_horizontal += 150
		get_viewport().set_input_as_handled()


func _start_player_thumbnail_generation() -> void:
	if player_thumbnail_generation_busy:
		player_thumbnail_generation_requested = true
		return
	player_thumbnail_generation_busy = true
	player_thumbnail_generation_serial += 1
	var generation := player_thumbnail_generation_serial
	if not player_thumbnail_generation_started:
		player_thumbnail_generation_started = true
		player_thumbnail_renderer = PLAYER_THUMBNAIL_RENDERER_SCRIPT.new()
		player_thumbnail_renderer.name = "PlayerThumbnailRenderer"
		add_child(player_thumbnail_renderer)
	var cards_snapshot: Array[Control] = player_asset_cards.duplicate()
	var page_snapshot := player_place_page
	var generated_count := 0
	for card_value in cards_snapshot:
		if generation != player_thumbnail_generation_serial:
			break
		var card := card_value as Control
		if (
			card == null
			or not is_instance_valid(card)
			or card.is_queued_for_deletion()
		):
			continue
		var asset_data := _player_placeable_entry(
			int(card.get("asset_index"))
		)
		if (
			asset_data.is_empty()
			or String(asset_data.get("page", "items")) != page_snapshot
		):
			continue
		var cache_key := _player_thumbnail_cache_key(asset_data)
		var texture: Texture2D = player_thumbnail_textures.get(cache_key, null)
		if texture == null:
			var thumbnail_path := String(
				asset_data.get("thumbnail_path", "")
			)
			if (
				not thumbnail_path.is_empty()
				and FileAccess.file_exists(thumbnail_path)
			):
				var thumbnail_image := Image.load_from_file(
					ProjectSettings.globalize_path(thumbnail_path)
				)
				if thumbnail_image != null and not thumbnail_image.is_empty():
					texture = ImageTexture.create_from_image(thumbnail_image)
			else:
				texture = await player_thumbnail_renderer.render_preview(
					asset_data,
					cache_key
				)
		if texture != null:
			player_thumbnail_textures[cache_key] = texture
			if is_instance_valid(card):
				card.set_thumbnail(texture)
			generated_count += 1
		if player_place_status != null and generation == player_thumbnail_generation_serial:
			player_place_status.text = "缩略图 %d / %d" % [
				generated_count,
				cards_snapshot.size(),
			]
	if generation == player_thumbnail_generation_serial:
		_rebuild_player_place_cards()
	player_thumbnail_generation_busy = false
	if player_thumbnail_generation_requested:
		player_thumbnail_generation_requested = false
		call_deferred("_start_player_thumbnail_generation")


func _player_thumbnail_cache_key(asset_data: Dictionary) -> String:
	return PLAYER_ASSET_FACTORY_SCRIPT.cache_signature(asset_data)


func _on_player_asset_drag_started(asset_index: int, screen_position: Vector2) -> void:
	if (
		current_3d_scene != "player"
		or asset_index < 0
		or asset_index >= player_placeable_entries.size()
	):
		return
	player_dragged_asset_index = asset_index
	player_drag_last_screen_position = screen_position
	_cancel_player_placement_selection()
	if player_3d_drag_preview != null:
		player_3d_drag_preview.queue_free()
		player_3d_drag_preview = null
	var asset_data := _player_placeable_entry(asset_index)
	if asset_data.is_empty():
		return
	var asset_kind := String(asset_data.kind)
	if asset_kind == "player_light_string_tool":
		player_dragged_asset_index = -1
		player_drag_last_screen_position = Vector2.ZERO
		if not player_light_string_drawing:
			_toggle_player_light_string_mode()
		return
	_refresh_player_asset_template_from_saved_layout(asset_kind)
	var yaw := float(asset_data.get("yaw", 0.0))
	player_3d_drag_preview_footprint = clampf(
		float(asset_data.get("extent", 0.7)) * 0.30,
		0.045,
		0.34
	)
	player_3d_drag_preview_height_offset = (
		_player_asset_drag_context_height(asset_kind, screen_position)
	)
	player_3d_drag_preview_user_scale = clampf(
		float(player_asset_scale_defaults.get(
			asset_kind,
			1.0
		)),
		0.3,
		3.0
	)
	player_3d_drag_preview = _add_player_asset_fitted(
		model_3d,
		asset_data,
		"PlayerAsset3DDragPreview",
		_player_placement_transform(
			screen_position,
			yaw,
			player_3d_drag_preview_footprint,
			player_3d_drag_preview_height_offset,
			null,
			not _is_player_support_surface_kind(asset_kind),
			asset_kind
		),
		float(asset_data.get("extent", 0.7))
	)
	if player_3d_drag_preview == null:
		player_place_status.text = "模型载入失败"
		player_dragged_asset_index = -1
		return
	_configure_player_asset_light(player_3d_drag_preview, asset_data)
	player_3d_drag_preview.scale = (
		Vector3.ONE * player_3d_drag_preview_user_scale
	)
	player_3d_drag_preview_asset_index = asset_index
	player_3d_drag_preview_scale = float(
		player_3d_drag_preview.get_meta("generated_part_scale", 1.0)
	)
	_set_player_preview_transparency(player_3d_drag_preview, 0.24)
	_add_player_preview_selection_ring(player_3d_drag_preview)
	_update_player_asset_drag_status(asset_data, screen_position)
	call_deferred("_finish_player_asset_drag_if_released")


func _refresh_player_asset_template_from_saved_layout(kind: String) -> void:
	var layout_path := "user://player_layout.json"
	if not FileAccess.file_exists(layout_path):
		layout_path = "res://player_layout.json"
	if not FileAccess.file_exists(layout_path):
		return
	var parsed = JSON.parse_string(
		FileAccess.get_file_as_string(layout_path)
	)
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	var saved := parsed as Dictionary
	var heights = saved.get("player_item_heights", {})
	if typeof(heights) == TYPE_DICTIONARY and heights.has(kind):
		player_asset_height_offsets[kind] = clampf(
			float(heights[kind]),
			PLAYER_HEIGHT_OFFSET_MIN,
			PLAYER_HEIGHT_OFFSET_MAX
		)
	var support_heights = saved.get("player_item_support_heights", {})
	if (
		typeof(support_heights) == TYPE_DICTIONARY
		and support_heights.has(kind)
	):
		player_asset_support_height_offsets[kind] = clampf(
			float(support_heights[kind]),
			PLAYER_HEIGHT_OFFSET_MIN,
			PLAYER_HEIGHT_OFFSET_MAX
		)
	var scales = saved.get("player_item_scales", {})
	if typeof(scales) == TYPE_DICTIONARY and scales.has(kind):
		player_asset_scale_defaults[kind] = clampf(
			float(scales[kind]),
			0.3,
			3.0
		)


func _finish_player_asset_drag_if_released() -> void:
	if (
		player_3d_drag_preview == null
		or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	):
		return
	_on_player_asset_drag_ended(
		player_3d_drag_preview_asset_index,
		get_viewport().get_mouse_position()
	)


func _on_player_asset_drag_moved(asset_index: int, screen_position: Vector2) -> void:
	if (
		player_3d_drag_preview == null
		or not is_instance_valid(player_3d_drag_preview)
		or asset_index != player_3d_drag_preview_asset_index
	):
		return
	player_drag_last_screen_position = screen_position
	var asset_data := _player_placeable_entry(asset_index)
	if asset_data.is_empty():
		return
	player_3d_drag_preview_height_offset = (
		_player_asset_drag_context_height(
			String(asset_data.get("kind", "")),
			screen_position
		)
	)
	player_3d_drag_preview.transform = _player_placement_transform(
		screen_position,
		float(asset_data.get("yaw", 0.0)),
		player_3d_drag_preview_footprint,
		player_3d_drag_preview_height_offset,
		null,
		not _is_player_support_surface_kind(
			String(asset_data.get("kind", ""))
		),
		String(asset_data.get("kind", ""))
	)
	player_3d_drag_preview.scale = (
		Vector3.ONE * player_3d_drag_preview_user_scale
	)
	_update_player_asset_drag_status(asset_data, screen_position)


func _player_asset_drag_context_height(
	asset_kind: String,
	screen_position: Vector2
) -> float:
	var on_support := false
	if not _is_player_support_surface_kind(asset_kind):
		on_support = not _player_support_surface_hit(
			screen_position,
			null,
			asset_kind
		).is_empty()
	var source := (
		player_asset_support_height_offsets
		if on_support
		else player_asset_height_offsets
	)
	return clampf(
		float(source.get(asset_kind, 0.0)),
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)


func _update_player_asset_drag_status(
	asset_data: Dictionary,
	screen_position: Vector2
) -> void:
	if player_place_status == null:
		return
	var asset_kind := String(asset_data.get("kind", ""))
	var blocked_table_hit := _player_disallowed_table_hit(
		screen_position,
		asset_kind
	)
	var support_hit := (
		_player_support_surface_hit(
			screen_position,
			null,
			asset_kind
		)
		if not _is_player_support_surface_kind(
			asset_kind
		)
		else {}
	)
	var placement_target := (
		"该物件不能吸附到：长桌"
		if not blocked_table_hit.is_empty()
		else (
			"吸附到：%s" % String(support_hit.label)
			if not support_hit.is_empty()
			else "拖到摆放平面"
		)
	)
	player_place_status.text = "%s：%s | 离地 %+.2f | 缩放 %d%%" % [
		placement_target,
		String(asset_data.label),
		player_3d_drag_preview_height_offset,
		roundi(player_3d_drag_preview_user_scale * 100.0),
	]


func _on_player_asset_drag_ended(asset_index: int, screen_position: Vector2) -> void:
	if player_3d_drag_preview == null:
		player_dragged_asset_index = -1
		return
	if player_drag_last_screen_position != Vector2.ZERO:
		screen_position = player_drag_last_screen_position
	var asset_data := _player_placeable_entry(asset_index)
	if asset_data.is_empty():
		return
	if not _player_disallowed_table_hit(
		screen_position,
		String(asset_data.get("kind", ""))
	).is_empty():
		player_3d_drag_preview.queue_free()
		player_3d_drag_preview = null
		player_3d_drag_preview_asset_index = -1
		player_dragged_asset_index = -1
		player_drag_last_screen_position = Vector2.ZERO
		player_place_status.text = "该物件不能吸附到长桌"
		return
	var outside_drag_target := (
		player_place_dock != null
		and player_place_dock.visible
		and player_place_dock.get_global_rect().has_point(screen_position)
	)
	if outside_drag_target or not _screen_position_hits_player_planet(screen_position):
		player_3d_drag_preview.queue_free()
		player_3d_drag_preview = null
		player_3d_drag_preview_asset_index = -1
		player_dragged_asset_index = -1
		player_drag_last_screen_position = Vector2.ZERO
		player_place_status.text = "请拖到星球的平面摆放区"
		return
	_commit_player_asset_preview(asset_index, screen_position)
	player_dragged_asset_index = -1
	player_drag_last_screen_position = Vector2.ZERO


func _on_player_asset_dropped(asset_index: int, screen_position: Vector2) -> void:
	if current_3d_scene != "player" or model_3d == null:
		return
	if asset_index < 0 or asset_index >= player_placeable_entries.size():
		return
	var asset_data := _player_placeable_entry(asset_index)
	if asset_data.is_empty():
		return
	if (
		player_place_dock != null
		and player_place_dock.visible
		and player_place_dock.get_global_rect().has_point(screen_position)
	) or not _screen_position_hits_player_planet(screen_position):
		player_place_status.text = "请拖到星球的平面摆放区"
		return
	var asset_kind := String(asset_data.get("kind", ""))
	if not _player_disallowed_table_hit(
		screen_position,
		asset_kind
	).is_empty():
		player_place_status.text = "该物件不能吸附到长桌"
		return
	_on_player_asset_drag_started(asset_index, screen_position)
	_commit_player_asset_preview(asset_index, screen_position)


func _set_player_preview_transparency(root: Node3D, amount: float) -> void:
	if root == null:
		return
	for item in root.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		mesh_instance.set("transparency", amount)
		mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF


func _add_player_preview_selection_ring(root: Node3D) -> void:
	if root == null:
		return
	var torus := TorusMesh.new()
	torus.inner_radius = 0.11
	torus.outer_radius = 0.135
	torus.rings = 24
	torus.ring_segments = 8
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color(1.0, 0.91, 0.22, 1.0)
	material.emission_enabled = true
	material.emission = Color(1.0, 0.78, 0.08)
	material.emission_energy_multiplier = 3.2
	material.no_depth_test = true
	var ring := MeshInstance3D.new()
	ring.name = "PlayerPreviewSelectionRing"
	ring.mesh = torus
	ring.material_override = material
	ring.position = Vector3(0.0, 0.012, 0.0)
	ring.scale = Vector3.ONE * 1.2
	ring.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	root.add_child(ring)


func _screen_position_hits_player_planet(screen_position: Vector2) -> bool:
	if camera_3d == null or model_3d == null:
		return false
	if not _player_support_surface_hit(screen_position).is_empty():
		return true
	var base_node := model_3d.find_child("PlanetBase", true, false) as Node3D
	if base_node == null:
		return false
	var target_mesh := player_placement_surface_mesh
	if target_mesh == null or not is_instance_valid(target_mesh):
		var base_meshes := base_node.find_children(
			"*",
			"MeshInstance3D",
			true,
			false
		)
		if base_meshes.is_empty():
			return false
		target_mesh = base_meshes[0] as MeshInstance3D
	if target_mesh == null:
		return false
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var planet_aabb := target_mesh.global_transform * target_mesh.get_aabb()
	return _ray_aabb_distance(ray_origin, ray_direction, planet_aabb) != INF


func _commit_player_asset_preview(
	asset_index: int,
	screen_position: Vector2
) -> void:
	if player_3d_drag_preview == null or asset_index < 0:
		return
	var asset_data := _player_placeable_entry(asset_index)
	if asset_data.is_empty():
		return
	var wrapper := player_3d_drag_preview
	var final_transform := wrapper.transform
	var final_normal := final_transform.basis.y.normalized()
	var ground_position := (
		final_transform.origin
		- final_normal * player_3d_drag_preview_height_offset
	)
	player_3d_drag_preview = null
	player_3d_drag_preview_asset_index = -1
	var preview_ring := wrapper.get_node_or_null("PlayerPreviewSelectionRing")
	if preview_ring != null:
		preview_ring.queue_free()
	_set_player_preview_transparency(wrapper, 0.0)
	_register_editable_3d(
		wrapper,
		String(asset_data.kind),
		String(asset_data.label),
		final_normal,
		0.0,
		true,
		float(asset_data.get("yaw", 0.0)),
		player_3d_drag_preview_scale,
		String(asset_data.path),
		false
	)
	var record_index := editable_3d_objects.size() - 1
	var record: Dictionary = editable_3d_objects[record_index]
	record["id"] = "%s-%02d" % [String(asset_data.kind), editable_serial]
	record["planet_slug"] = "player"
	record["player_placeable"] = true
	record["placement_footprint"] = player_3d_drag_preview_footprint
	var lands_on_support := not _player_support_surface_hit(
		screen_position,
		null,
		String(asset_data.kind)
	).is_empty()
	var kind := String(asset_data.kind)
	record["ground_height_offset"] = clampf(
		float(player_asset_height_offsets.get(kind, 0.0)),
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	record["support_height_offset"] = clampf(
		float(player_asset_support_height_offsets.get(kind, 0.0)),
		PLAYER_HEIGHT_OFFSET_MIN,
		PLAYER_HEIGHT_OFFSET_MAX
	)
	record["placement_height_offset"] = (
		record.support_height_offset
		if lands_on_support
		else record.ground_height_offset
	)
	record["initial_placement_height_offset"] = player_3d_drag_preview_height_offset
	record["scale"] = player_3d_drag_preview_user_scale
	record["initial_scale"] = player_3d_drag_preview_user_scale
	_configure_player_plane_record(record, ground_position, final_normal)
	_assign_player_placement_support(record, screen_position)
	_apply_editable_3d_record(record_index)
	wrapper.transform = final_transform
	wrapper.visible = true
	var character_drop_screen := _player_character_drop_screen(
		record,
		screen_position
	)
	var auto_seated := _try_sit_dropped_player_character(
		record_index,
		character_drop_screen
	)
	_refresh_player_seat_glow_markers()
	_refresh_editor_object_list()
	_ensure_editor_selection_ring()
	selected_editable_index = record_index
	player_placement_selected_index = record_index
	_update_editor_selection_ring()
	_save_3d_layout()
	player_place_status.text = (
		"已摆放并坐下：%s"
		if auto_seated
		else "已摆放：%s"
	) % String(asset_data.label)
	_sync_player_place_height_control()


func _cancel_player_placement_selection() -> void:
	player_placement_selected_index = -1
	player_light_string_selected_index = -1
	player_placement_object_dragging = false
	player_placement_object_drag_moved = false
	player_placement_drag_press_position = Vector2.ZERO
	player_placement_drag_screen_offset = Vector2.ZERO
	player_placement_drag_travel = 0.0
	if selected_editable_index >= 0 and current_3d_scene == "player":
		selected_editable_index = -1
	if editor_selection_ring != null:
		editor_selection_ring.visible = false
	_sync_player_place_height_control()


func _pick_player_placement_object(screen_position: Vector2) -> int:
	return _pick_editable_object(screen_position, true)


func _pick_player_character_at_screen(
	screen_position: Vector2,
	padding := 12.0
) -> int:
	if camera_3d == null:
		return -1
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(screen_position).normalized()
	var active_index := _get_active_player_character_index()
	var best_mesh_index := -1
	var best_mesh_distance := INF
	var best_index := -1
	var best_center_distance := INF
	var active_contains_click := false
	for index in editable_3d_objects.size():
		var record: Dictionary = editable_3d_objects[index]
		var node_value = record.get("node")
		if (
			String(record.get("kind", "")) not in PLAYER_CHARACTER_KINDS
			or not node_value is Node3D
		):
			continue
		var node := node_value as Node3D
		if (
			node == null
			or not is_instance_valid(node)
			or not node.is_visible_in_tree()
		):
			continue
		var bounds := _editable_world_bounds(node)
		if bounds.size == Vector3.ZERO:
			continue
		var mesh_hit := _object_ray_hit_distance(
			node,
			ray_origin,
			ray_direction
		)
		if mesh_hit != INF and mesh_hit < best_mesh_distance:
			best_mesh_distance = mesh_hit
			best_mesh_index = index
		var screen_min := Vector2(INF, INF)
		var screen_max := Vector2(-INF, -INF)
		for x_side in [0.0, 1.0]:
			for y_side in [0.0, 1.0]:
				for z_side in [0.0, 1.0]:
					var corner := Vector3(
						bounds.position.x + bounds.size.x * x_side,
						bounds.position.y + bounds.size.y * y_side,
						bounds.position.z + bounds.size.z * z_side
					)
					if camera_3d.is_position_behind(corner):
						continue
					var screen_corner := camera_3d.unproject_position(corner)
					screen_min.x = minf(screen_min.x, screen_corner.x)
					screen_min.y = minf(screen_min.y, screen_corner.y)
					screen_max.x = maxf(screen_max.x, screen_corner.x)
					screen_max.y = maxf(screen_max.y, screen_corner.y)
		if screen_min.x == INF or screen_max.x == -INF:
			continue
		var screen_rect := Rect2(
			screen_min,
			screen_max - screen_min
		).grow(padding)
		if not screen_rect.has_point(screen_position):
			continue
		if index == active_index:
			active_contains_click = true
		var center := bounds.get_center()
		if camera_3d.is_position_behind(center):
			continue
		var center_distance := (
			camera_3d.unproject_position(center).distance_to(screen_position)
		)
		if center_distance < best_center_distance:
			best_center_distance = center_distance
			best_index = index
	if active_contains_click:
		return active_index
	if best_mesh_index >= 0:
		return best_mesh_index
	return best_index


func _is_player_plane_record(record: Dictionary) -> bool:
	var kind := String(record.get("kind", ""))
	return (
		current_3d_scene == "player"
		and (
			kind == "player_bridge"
			or kind.begins_with("player_")
		)
		and String(record.get("layout_mode", "sphere")) == "plane"
	)


func _select_player_placement_object(
	index: int,
	pointer_position := Vector2.ZERO
) -> void:
	if index < 0 or index >= editable_3d_objects.size():
		return
	var record: Dictionary = editable_3d_objects[index]
	var is_locked := bool(record.get("locked", false))
	var can_move_in_placement := (
		player_place_dock != null
		and player_place_dock.visible
	)
	player_light_string_selected_index = -1
	selected_editable_index = index
	player_placement_selected_index = index
	player_placement_object_dragging = (
		not is_locked and can_move_in_placement
	)
	player_placement_object_drag_moved = false
	player_placement_drag_press_position = pointer_position
	player_placement_drag_screen_offset = Vector2.ZERO
	player_placement_drag_travel = 0.0
	if (
		not is_locked
		and pointer_position != Vector2.ZERO
		and camera_3d != null
		and record.has("node")
	):
		var selected_node := record.get("node") as Node3D
		if selected_node != null:
			var selected_bounds := _editable_world_bounds(selected_node)
			if selected_bounds.size != Vector3.ZERO:
				var selected_screen := camera_3d.unproject_position(
					selected_bounds.get_center()
				)
				player_placement_drag_screen_offset = (
					selected_screen - pointer_position
				)
	dragging_3d = false
	model_orbit_enabled = false
	model_spin_velocity = Vector2.ZERO
	_ensure_editor_selection_ring()
	_update_editor_selection_ring()
	Input.set_default_cursor_shape(
		Input.CURSOR_DRAG
		if not is_locked and can_move_in_placement
		else Input.CURSOR_ARROW
	)
	_sync_player_place_height_control()


func _selected_player_item_record() -> Dictionary:
	if (
		current_3d_scene != "player"
		or editor_active
		or player_place_dock == null
		or not player_place_dock.visible
		or selected_editable_index < 0
		or selected_editable_index >= editable_3d_objects.size()
		or selected_editable_index != player_placement_selected_index
	):
		return {}
	var record: Dictionary = editable_3d_objects[selected_editable_index]
	if not _is_player_plane_record(record):
		return {}
	var node := record.get("node") as Node3D
	if node == null or not is_instance_valid(node) or not node.visible:
		return {}
	return record


func _selected_player_light_string_node() -> Node3D:
	if (
		current_3d_scene != "player"
		or editor_active
		or player_place_dock == null
		or not player_place_dock.visible
		or player_light_string_selected_index < 0
		or player_light_string_selected_index >= player_light_strings.size()
		or player_light_string_dragged_handle >= 0
	):
		return null
	var node := player_light_strings[
		player_light_string_selected_index
	].get("node") as Node3D
	if node == null or not is_instance_valid(node) or not node.visible:
		return null
	return node


func _update_player_item_action_arc() -> void:
	if player_item_action_arc == null:
		return
	var record := _selected_player_item_record()
	var light_string_node := _selected_player_light_string_node()
	if (
		record.is_empty() and light_string_node == null
		or player_placement_object_dragging
		or stage_3d == null
		or not stage_3d.visible
		or hud_3d == null
		or not hud_3d.visible
		or camera_3d == null
	):
		player_item_action_arc.visible = false
		return
	var selected_node := (
		light_string_node
		if light_string_node != null
		else record.get("node") as Node3D
	)
	var world_bounds := _editable_world_bounds(selected_node)
	if world_bounds.size == Vector3.ZERO:
		player_item_action_arc.visible = false
		return
	var anchor_world := world_bounds.get_center()
	if camera_3d.is_position_behind(anchor_world):
		player_item_action_arc.visible = false
		return
	var anchor_screen := camera_3d.unproject_position(anchor_world)
	var viewport_size := get_viewport().get_visible_rect().size
	if not Rect2(
		Vector2(-48.0, -48.0),
		viewport_size + Vector2(96.0, 96.0)
	).has_point(anchor_screen):
		player_item_action_arc.visible = false
		return
	var item_locked := (
		bool(player_light_strings[
			player_light_string_selected_index
		].get("locked", false))
		if light_string_node != null
		else bool(record.get("locked", false))
	)
	player_item_action_arc.visible = true
	var bottom_limit := viewport_size.y - 10.0
	if player_place_dock != null and player_place_dock.visible:
		bottom_limit = minf(
			bottom_limit,
			player_place_dock.position.y - 8.0
		)
	var arc_radius := 116.0
	var button_size := Vector2(44.0, 44.0)
	var button_count := player_item_action_buttons.size()
	for index in button_count:
		var angle := deg_to_rad(
			lerpf(-90.0, 0.0, float(index) / float(button_count - 1))
		)
		var target_center := (
			anchor_screen
			+ Vector2(cos(angle), sin(angle)) * arc_radius
		)
		var button := player_item_action_buttons[index]
		button.disabled = false
		button.modulate = Color.WHITE
		button.position = Vector2(
			clampf(
				target_center.x - button_size.x * 0.5,
				10.0,
				maxf(10.0, viewport_size.x - button_size.x - 10.0)
			),
			clampf(
				target_center.y - button_size.y * 0.5,
				66.0,
				maxf(66.0, bottom_limit - button_size.y)
			)
		)
	player_item_lock_button.modulate = (
		Color(1.0, 0.64, 0.24, 1.0)
		if item_locked
		else Color.WHITE
	)
	player_item_lock_button.tooltip_text = (
		"已锁定当前位置 | 点击解锁"
		if item_locked
		else "锁定当前位置"
	)


func _update_player_light_string_operation_hint() -> void:
	if player_light_string_operation_hint == null:
		return
	var selected_node: Node3D = null
	if (
		player_light_string_selected_index >= 0
		and player_light_string_selected_index < player_light_strings.size()
	):
		selected_node = player_light_strings[
			player_light_string_selected_index
		].get("node") as Node3D
	var active := (
		current_3d_scene == "player"
		and player_place_dock != null
		and player_place_dock.visible
		and (
			player_light_string_drawing
			or (
				selected_node != null
				and is_instance_valid(selected_node)
				and selected_node.visible
			)
		)
	)
	player_light_string_operation_hint.visible = active
	if player_place_status != null:
		player_place_status.visible = not active
	if not active:
		return
	var viewport_size := get_viewport().get_visible_rect().size
	var hint_width := minf(600.0, viewport_size.x * 0.46)
	var hint_height := 48.0
	var center_shift := minf(90.0, hint_width * 0.18)
	player_light_string_operation_hint.size = Vector2(
		hint_width,
		hint_height
	)
	player_light_string_operation_hint.position = Vector2(
		viewport_size.x * 0.5 - hint_width * 0.5 - center_shift,
		(viewport_size.y - hint_height) * 0.5
	)
	player_light_string_operation_hint.text = player_place_status.text


func _toggle_player_item_lock() -> void:
	if _selected_player_light_string_node() != null:
		var string_data := player_light_strings[
			player_light_string_selected_index
		] as Dictionary
		var locked := not bool(string_data.get("locked", false))
		string_data["locked"] = locked
		player_place_status.text = (
			"灯串已锁定位置" if locked else "灯串已解锁位置"
		)
		_save_3d_layout()
		_update_player_item_action_arc()
		_pulse_player_item_lock_feedback(locked)
		return
	var record := _selected_player_item_record()
	if record.is_empty():
		return
	var locked := not bool(record.get("locked", false))
	record["locked"] = locked
	player_placement_object_dragging = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	_refresh_editor_object_list()
	_update_editor_selection_ring()
	_sync_player_place_height_control()
	_save_3d_layout()
	player_place_status.text = (
		"已锁定：%s" if locked else "已解锁：%s"
	) % String(record.label)
	_update_player_item_action_arc()
	_pulse_player_item_lock_feedback(locked)


func _pulse_player_item_lock_feedback(locked: bool) -> void:
	if player_item_lock_button == null:
		return
	if (
		player_item_lock_feedback_tween != null
		and player_item_lock_feedback_tween.is_valid()
	):
		player_item_lock_feedback_tween.kill()
	player_item_lock_button.pivot_offset = player_item_lock_button.size * 0.5
	player_item_lock_button.scale = Vector2.ONE
	player_item_lock_feedback_tween = create_tween()
	player_item_lock_feedback_tween.tween_property(
		player_item_lock_button,
		"scale",
		Vector2.ONE * (1.22 if locked else 1.12),
		0.12
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	player_item_lock_feedback_tween.tween_property(
		player_item_lock_button,
		"scale",
		Vector2.ONE,
		0.22
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _rotate_player_item_z(delta_degrees: float) -> void:
	var light_string_node := _selected_player_light_string_node()
	if light_string_node != null:
		light_string_node.call(
			"rotate_around_center",
			delta_degrees,
			player_placement_plane_normal
		)
		_save_3d_layout()
		player_place_status.text = "灯串旋转 %+.0f°" % delta_degrees
		_update_player_item_action_arc()
		return
	var record := _selected_player_item_record()
	if record.is_empty():
		return
	record["yaw"] = wrapf(
		float(record.get("yaw", 0.0)) + delta_degrees,
		-180.0,
		180.0
	)
	_apply_editable_3d_record(selected_editable_index)
	_update_editor_selection_ring()
	_save_3d_layout()
	player_place_status.text = "%s | Z 轴 %+.0f°" % [
		String(record.label),
		float(record.yaw),
	]
	_update_player_item_action_arc()


func _duplicate_player_item() -> void:
	var light_string_node := _selected_player_light_string_node()
	if light_string_node != null:
		var start: Vector3 = light_string_node.get("start_point")
		var sag: Vector3 = light_string_node.get("sag_point")
		var end: Vector3 = light_string_node.get("end_point")
		var offset := (
			player_placement_plane_right * 0.22
			+ player_placement_plane_forward * 0.12
		)
		_create_player_light_string(
			start + offset,
			sag + offset,
			end + offset,
			float(light_string_node.get("brightness")),
			bool(light_string_node.get("light_on"))
		)
		_save_3d_layout()
		player_place_status.text = "已复制：灯串"
		_update_player_item_action_arc()
		return
	var record := _selected_player_item_record()
	if record.is_empty():
		return
	var label := String(record.label)
	_duplicate_selected_3d_object()
	if selected_editable_index < 0:
		return
	player_placement_selected_index = selected_editable_index
	player_placement_object_dragging = false
	_refresh_player_seat_glow_markers()
	_sync_player_place_height_control()
	_save_3d_layout()
	player_place_status.text = "已复制：%s" % label
	_update_player_item_action_arc()


func _delete_player_item() -> void:
	if _selected_player_light_string_node() != null:
		var string_data := player_light_strings[
			player_light_string_selected_index
		] as Dictionary
		var light_string_node := string_data.get("node") as Node3D
		if light_string_node != null:
			light_string_node.queue_free()
		player_light_strings.remove_at(player_light_string_selected_index)
		player_light_string_selected_index = -1
		player_light_string_dragged_handle = -1
		_save_3d_layout()
		player_place_status.text = "已删除：灯串"
		_update_player_item_action_arc()
		return
	var record := _selected_player_item_record()
	if record.is_empty():
		return
	var label := String(record.label)
	_delete_selected_3d_object()
	_refresh_player_seat_glow_markers()
	_sync_player_place_height_control()
	_save_3d_layout()
	player_place_status.text = "已删除：%s" % label
	_update_player_item_action_arc()


func _toggle_player_light_string_mode() -> void:
	if player_light_string_drawing:
		_cancel_player_light_string_mode()
		return
	if player_light_strings.size() >= PLAYER_LIGHT_STRING_MAX:
		player_place_status.text = "最多保留 %d 条灯串" % PLAYER_LIGHT_STRING_MAX
		return
	_cancel_player_placement_selection()
	if player_3d_drag_preview != null:
		player_3d_drag_preview.queue_free()
		player_3d_drag_preview = null
	player_light_string_drawing = true
	player_light_string_has_start = false
	player_place_status.text = "灯串：点击首端位置"
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)


func _cancel_player_light_string_mode() -> void:
	player_light_string_drawing = false
	player_light_string_has_start = false
	player_light_string_dragged_handle = -1
	if player_light_string_preview != null:
		player_light_string_preview.queue_free()
		player_light_string_preview = null
	if player_place_status != null:
		player_place_status.text = "灯串编辑已取消"
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _player_light_string_point_from_screen(
	screen_position: Vector2,
	elevation := PLAYER_LIGHT_STRING_ANCHOR_HEIGHT,
	allow_object_snap := true
) -> Vector3:
	if (
		not _screen_position_hits_player_planet(screen_position)
		or camera_3d == null
		or model_3d == null
	):
		return Vector3.INF
	player_light_string_snap_label = ""
	if allow_object_snap:
		var attachment := _player_light_string_attachment_at_screen(
			screen_position
		)
		if not attachment.is_empty():
			player_light_string_snap_label = String(
				attachment.get("label", "物件")
			)
			return attachment.position as Vector3
	var hit := _player_surface_hit(screen_position)
	if not hit.is_empty():
		return (
			(hit.position as Vector3)
			+ (hit.normal as Vector3).normalized() * elevation
		)
	return (
		_screen_position_to_player_placement_plane(screen_position)
		+ player_placement_plane_normal * elevation
	)


func _player_light_string_attachment_at_screen(
	screen_position: Vector2
) -> Dictionary:
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(
		screen_position
	).normalized()
	var best_distance := INF
	var best_attachment := {}
	for record in editable_3d_objects:
		var node := record.get("node") as Node3D
		if (
			node == null
			or not is_instance_valid(node)
			or not node.visible
		):
			continue
		for item in node.find_children("*", "MeshInstance3D", true, false):
			var mesh_instance := item as MeshInstance3D
			if (
				mesh_instance == null
				or mesh_instance.mesh == null
				or mesh_instance.has_meta("player_light_footprint")
			):
				continue
			var hit := _mesh_ray_hit_info(
				mesh_instance,
				ray_origin,
				ray_direction
			)
			if hit.is_empty() or float(hit.distance) >= best_distance:
				continue
			best_distance = float(hit.distance)
			var local_position: Vector3 = (
				model_3d.global_transform.affine_inverse()
				* (hit.position as Vector3)
			)
			var world_normal := (hit.normal as Vector3).normalized()
			if world_normal.dot(ray_direction) > 0.0:
				world_normal = -world_normal
			var local_normal := (
				model_3d.global_transform.basis.inverse().transposed()
				* world_normal
			).normalized()
			best_attachment = {
				"position": local_position + local_normal * 0.012,
				"label": String(record.get("label", "物件")),
				"anchor_id": String(record.get("id", "")),
			}
	return best_attachment


func _mesh_ray_hit_info(
	mesh_instance: MeshInstance3D,
	ray_origin: Vector3,
	ray_direction: Vector3
) -> Dictionary:
	var inverse_transform := mesh_instance.global_transform.affine_inverse()
	var local_origin := inverse_transform * ray_origin
	var local_direction := (inverse_transform.basis * ray_direction).normalized()
	var best_distance := INF
	var best_normal := Vector3.UP
	for surface_index in mesh_instance.mesh.get_surface_count():
		var arrays := mesh_instance.mesh.surface_get_arrays(surface_index)
		var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		var indices_value = arrays[Mesh.ARRAY_INDEX]
		if indices_value == null or indices_value.size() == 0:
			for vertex_index in range(0, vertices.size() - 2, 3):
				var a := vertices[vertex_index]
				var b := vertices[vertex_index + 1]
				var c := vertices[vertex_index + 2]
				var triangle_hit := _ray_triangle_distance(
					local_origin,
					local_direction,
					a, b, c
				)
				if triangle_hit != INF and triangle_hit < best_distance:
					best_distance = triangle_hit
					best_normal = (b - a).cross(c - a).normalized()
		else:
			var indices: PackedInt32Array = indices_value
			for index in range(0, indices.size() - 2, 3):
				var a := vertices[indices[index]]
				var b := vertices[indices[index + 1]]
				var c := vertices[indices[index + 2]]
				var triangle_hit := _ray_triangle_distance(
					local_origin,
					local_direction,
					a, b, c
				)
				if triangle_hit != INF and triangle_hit < best_distance:
					best_distance = triangle_hit
					best_normal = (b - a).cross(c - a).normalized()
	if best_distance == INF:
		return {}
	var world_position := mesh_instance.global_transform * (
		local_origin + local_direction * best_distance
	)
	var world_normal := (
		mesh_instance.global_transform.basis.inverse().transposed()
		* best_normal
	).normalized()
	return {
		"distance": ray_origin.distance_to(world_position),
		"position": world_position,
		"normal": world_normal,
	}


func _player_light_string_default_sag(
	start: Vector3,
	end: Vector3,
	normal: Vector3
) -> Vector3:
	var distance := start.distance_to(end)
	return (
		(start + end) * 0.5
		- normal.normalized() * maxf(distance * 0.15, 0.10)
	)


func _player_light_string_normal_at(point: Vector3) -> Vector3:
	return _player_surface_normal_at_position(point, 0.08)


func _update_player_light_string_preview(screen_position: Vector2) -> void:
	if (
		player_light_string_preview == null
		or not player_light_string_has_start
	):
		return
	var end := _player_light_string_point_from_screen(screen_position)
	if end == Vector3.INF:
		return
	var normal := _player_light_string_normal_at(player_light_string_start)
	var sag := _player_light_string_default_sag(
		player_light_string_start,
		end,
		normal
	)
	player_light_string_preview.call(
		"set_curve",
		player_light_string_start,
		sag,
		end
	)
	var snap_text := (
		" | 吸附：" + player_light_string_snap_label
		if not player_light_string_snap_label.is_empty()
		else ""
	)
	player_place_status.text = "灯串预览：第二次点击确定尾端 | %d 颗%s" % [
		int(player_light_string_preview.call("get_bulb_count")),
		snap_text,
	]


func _create_player_light_string(
	start: Vector3,
	sag: Vector3,
	end: Vector3,
	light_brightness := 1.0,
	light_enabled := true,
	select_instance := true
) -> Node3D:
	if player_light_strings.size() >= PLAYER_LIGHT_STRING_MAX:
		return null
	var node := PLAYER_LIGHT_STRING_SCRIPT.new() as Node3D
	node.name = "PlayerLightString_%02d" % (player_light_strings.size() + 1)
	model_3d.add_child(node)
	node.call("set_curve", start, sag, end)
	node.call("set_light_state", light_brightness, light_enabled)
	node.call("set_edit_handles_visible", true)
	player_light_strings.append({
		"node": node,
		"locked": false,
	})
	if select_instance:
		player_light_string_selected_index = player_light_strings.size() - 1
	return node


func _commit_player_light_string(screen_position: Vector2) -> void:
	if player_light_string_preview == null:
		return
	var end := _player_light_string_point_from_screen(screen_position)
	if (
		end == Vector3.INF
		or player_light_string_start.distance_to(end)
			< PLAYER_LIGHT_STRING_MIN_SPAN
	):
		player_place_status.text = "尾端离首端太近，请重新选择"
		return
	var normal := _player_light_string_normal_at(player_light_string_start)
	var sag := _player_light_string_default_sag(
		player_light_string_start,
		end,
		normal
	)
	player_light_string_preview.call(
		"set_curve",
		player_light_string_start,
		sag,
		end
	)
	player_light_string_preview.call("set_edit_handles_visible", true)
	player_light_strings.append({
		"node": player_light_string_preview,
	})
	player_light_string_selected_index = player_light_strings.size() - 1
	player_light_string_preview = null
	player_light_string_drawing = false
	player_light_string_has_start = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	player_place_status.text = "灯串已生成 | 可拖动两个浅黄端点调整"
	_save_3d_layout()


func _player_light_string_at_handle(screen_position: Vector2) -> Dictionary:
	if camera_3d == null:
		return {}
	for string_index in player_light_strings.size():
		var node := player_light_strings[string_index].get("node") as Node3D
		if node == null or not is_instance_valid(node):
			continue
		for handle_index in 2:
			var world_position: Vector3 = node.call(
				"get_handle_world_position",
				handle_index
			)
			if world_position == Vector3.INF or camera_3d.is_position_behind(world_position):
				continue
			if (
				camera_3d.unproject_position(world_position).distance_to(
					screen_position
				)
				<= 21.0
			):
				return {
					"string": string_index,
					"handle": handle_index,
				}
	return {}


func _player_light_string_at_screen(screen_position: Vector2) -> int:
	if camera_3d == null:
		return -1
	var ray_origin := camera_3d.project_ray_origin(screen_position)
	var ray_direction := camera_3d.project_ray_normal(
		screen_position
	).normalized()
	for index in range(player_light_strings.size() - 1, -1, -1):
		var node := player_light_strings[index].get("node") as Node3D
		if node == null or not is_instance_valid(node) or not node.visible:
			continue
		if _object_ray_hit_distance(node, ray_origin, ray_direction) != INF:
			return index
		var handle_points: Array[Vector3] = node.call("get_handle_points")
		if handle_points.size() < 3:
			continue
		var start := node.to_global(handle_points[0])
		var end := node.to_global(handle_points[2])
		var control := (
			node.to_global(handle_points[1]) * 2.0
			- (start + end) * 0.5
		)
		var best_distance := INF
		for sample_index in 25:
			var t := float(sample_index) / 24.0
			var inverse_t := 1.0 - t
			var world_point := (
				start * inverse_t * inverse_t
				+ control * 2.0 * inverse_t * t
				+ end * t * t
			)
			if camera_3d.is_position_behind(world_point):
				continue
			best_distance = minf(
				best_distance,
				camera_3d.unproject_position(world_point).distance_to(
					screen_position
				)
			)
		if best_distance <= PLAYER_LIGHT_STRING_PICK_RADIUS:
			return index
	return -1


func _drag_player_light_string_handle(screen_position: Vector2) -> void:
	if (
		player_light_string_selected_index < 0
		or player_light_string_selected_index >= player_light_strings.size()
		or player_light_string_dragged_handle < 0
	):
		return
	var node := player_light_strings[
		player_light_string_selected_index
	].get("node") as Node3D
	if node == null:
		return
	var point := _player_light_string_point_from_screen(
		screen_position,
		PLAYER_LIGHT_STRING_ANCHOR_HEIGHT,
		true
	)
	if point == Vector3.INF:
		return
	var start: Vector3 = node.get("start_point")
	var sag: Vector3 = node.get("sag_point")
	var end: Vector3 = node.get("end_point")
	match player_light_string_dragged_handle:
		0:
			start = point
			sag = _player_light_string_default_sag(
				start,
				end,
				_player_light_string_normal_at(start)
			)
		1:
			end = point
			sag = _player_light_string_default_sag(
				start,
				end,
				_player_light_string_normal_at(start)
			)
	node.call("set_curve", start, sag, end)
	player_place_status.text = ["拖动首端", "拖动尾端"][
		player_light_string_dragged_handle
	]


func _handle_player_light_string_pointer_event(event: InputEvent) -> bool:
	if (
		current_3d_scene != "player"
		or editor_active
		or dialogue_active
		or model_3d == null
	):
		return false
	if event is InputEventKey:
		var key := event as InputEventKey
		if (
			key.pressed
			and key.keycode == KEY_ESCAPE
			and player_light_string_drawing
		):
			_cancel_player_light_string_mode()
			get_viewport().set_input_as_handled()
			return true
		return false
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		if player_light_string_dragged_handle >= 0:
			_drag_player_light_string_handle(motion.position)
			get_viewport().set_input_as_handled()
			return true
		if player_light_string_drawing and player_light_string_has_start:
			_update_player_light_string_preview(motion.position)
			get_viewport().set_input_as_handled()
			return true
		return false
	if event is not InputEventMouseButton:
		return false
	var mouse_button := event as InputEventMouseButton
	if mouse_button.button_index != MOUSE_BUTTON_LEFT:
		return false
	if not mouse_button.pressed:
		if player_light_string_dragged_handle >= 0:
			_drag_player_light_string_handle(mouse_button.position)
			player_light_string_dragged_handle = -1
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			_save_3d_layout()
			get_viewport().set_input_as_handled()
			return true
		return false
	if player_light_string_drawing:
		if not player_light_string_has_start:
			var start := _player_light_string_point_from_screen(
				mouse_button.position
			)
			if start == Vector3.INF:
				player_place_status.text = "请在星球地面选择灯串首端"
				return true
			player_light_string_start = start
			player_light_string_preview = PLAYER_LIGHT_STRING_SCRIPT.new()
			player_light_string_preview.name = (
				"PlayerLightStringPreview_%02d" % (player_light_strings.size() + 1)
			)
			model_3d.add_child(player_light_string_preview)
			player_light_string_preview.call(
				"set_curve",
				start,
				start,
				start
			)
			player_light_string_preview.call(
				"set_edit_handles_visible",
				false
			)
			player_light_string_has_start = true
			player_place_status.text = (
				"首端已记录%s | 移动鼠标预览，第二次点击确定尾端"
				% (
					" | 吸附：" + player_light_string_snap_label
					if not player_light_string_snap_label.is_empty()
					else ""
				)
			)
		else:
			_commit_player_light_string(mouse_button.position)
		get_viewport().set_input_as_handled()
		return true
	var handle_hit := _player_light_string_at_handle(mouse_button.position)
	if not handle_hit.is_empty():
		_cancel_player_placement_selection()
		player_light_string_selected_index = int(handle_hit.string)
		var is_locked := bool(
			player_light_strings[
				player_light_string_selected_index
			].get("locked", false)
		)
		player_light_string_dragged_handle = (
			-1 if is_locked else int(handle_hit.handle)
		)
		Input.set_default_cursor_shape(
			Input.CURSOR_ARROW if is_locked else Input.CURSOR_DRAG
		)
		_update_player_item_action_arc()
		get_viewport().set_input_as_handled()
		return true
	var string_index := _player_light_string_at_screen(mouse_button.position)
	if string_index >= 0:
		_cancel_player_placement_selection()
		player_light_string_selected_index = string_index
		player_light_string_dragged_handle = -1
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		player_place_status.text = "已选中：灯串 | 点击旋转按钮调整朝向"
		_update_player_item_action_arc()
		get_viewport().set_input_as_handled()
		return true
	return false


func _serialize_player_light_strings() -> Array[Dictionary]:
	var serialized: Array[Dictionary] = []
	for string_data in player_light_strings:
		var node := string_data.get("node") as Node3D
		if node == null or not is_instance_valid(node):
			continue
		var start: Vector3 = node.get("start_point")
		var sag: Vector3 = node.get("sag_point")
		var end: Vector3 = node.get("end_point")
		serialized.append({
			"start": [start.x, start.y, start.z],
			"sag": [sag.x, sag.y, sag.z],
			"end": [end.x, end.y, end.z],
			"brightness": float(node.get("brightness")),
			"light_on": bool(node.get("light_on")),
			"locked": bool(string_data.get("locked", false)),
		})
	return serialized


func _clear_player_light_strings() -> void:
	for string_data in player_light_strings:
		var node := string_data.get("node") as Node3D
		if node != null and is_instance_valid(node):
			node.queue_free()
	player_light_strings.clear()
	player_light_string_selected_index = -1
	player_light_string_dragged_handle = -1


func _load_player_light_strings(values: Variant) -> void:
	_clear_player_light_strings()
	if typeof(values) != TYPE_ARRAY:
		return
	for value in values:
		if typeof(value) != TYPE_DICTIONARY:
			continue
		var data := value as Dictionary
		var start_value = data.get("start", [])
		var sag_value = data.get("sag", [])
		var end_value = data.get("end", [])
		if (
			typeof(start_value) != TYPE_ARRAY
			or start_value.size() < 3
			or typeof(sag_value) != TYPE_ARRAY
			or sag_value.size() < 3
			or typeof(end_value) != TYPE_ARRAY
			or end_value.size() < 3
		):
			continue
		var node := _create_player_light_string(
			Vector3(float(start_value[0]), float(start_value[1]), float(start_value[2])),
			Vector3(float(sag_value[0]), float(sag_value[1]), float(sag_value[2])),
			Vector3(float(end_value[0]), float(end_value[1]), float(end_value[2])),
			clampf(float(data.get("brightness", 1.0)), 0.1, 2.5),
			bool(data.get("light_on", true)),
			false
		)
		if node != null and player_light_strings.size() > 0:
			player_light_strings[-1]["locked"] = bool(
				data.get("locked", false)
			)


func _handle_player_placement_pointer_event(event: InputEvent) -> bool:
	if (
		current_3d_scene != "player"
		or player_avatar_picker_open
		or editor_active
		or dialogue_active
		or model_3d == null
	):
		return false
	if event is InputEventMouseMotion and player_placement_object_dragging:
		var motion := event as InputEventMouseMotion
		player_placement_drag_travel = motion.position.distance_to(
			player_placement_drag_press_position
		)
		if (
			not player_placement_object_drag_moved
			and player_placement_drag_travel < PLAYER_OBJECT_DRAG_THRESHOLD
		):
			get_viewport().set_input_as_handled()
			return true
		if (
			not player_placement_object_drag_moved
			and selected_editable_index >= 0
			and selected_editable_index < editable_3d_objects.size()
		):
			_stand_player_character(
				editable_3d_objects[selected_editable_index]
			)
		player_placement_object_drag_moved = true
		_move_selected_editable_to_pointer(
			motion.position + player_placement_drag_screen_offset
		)
		get_viewport().set_input_as_handled()
		return true
	if event is not InputEventMouseButton:
		return false
	var mouse_button := event as InputEventMouseButton
	if mouse_button.button_index != MOUSE_BUTTON_LEFT:
		return false
	if mouse_button.pressed:
		# The character has visible empty gaps in its 3D mesh. Check its
		# projected screen silhouette before the ground ray so a click inside
		# the character never falls through as a movement command.
		var picked := _pick_player_character_at_screen(mouse_button.position)
		if picked < 0:
			picked = _pick_player_placement_object(mouse_button.position)
		var picked_kind := ""
		if picked >= 0:
			picked_kind = String(
				editable_3d_objects[picked].get("kind", "")
			)
		if (
			picked_kind == "player_prince"
			and (player_place_dock == null or not player_place_dock.visible)
		):
			player_placement_object_dragging = false
			player_navigation_pointer_seat.clear()
			_close_player_character_interaction()
			get_viewport().set_input_as_handled()
			return true
		_close_player_prince_interaction()
		if picked_kind not in PLAYER_PERSON_KINDS:
			_close_player_character_interaction()
		if (
			_player_navigation_input_available()
			and picked_kind not in PLAYER_PERSON_KINDS
		):
			var active_index := _get_active_player_character_index()
			if active_index >= 0:
				# The glow ring is a separate visual mesh, so detect the seat
				# region before requiring the click to land on the furniture mesh.
				var clicked_seat := _player_seat_at_screen(
					mouse_button.position,
					editable_3d_objects[active_index]
				)
				if not clicked_seat.is_empty():
					player_navigation_pointer_seat = clicked_seat
					player_placement_object_dragging = false
					Input.set_default_cursor_shape(
						Input.CURSOR_POINTING_HAND
					)
					get_viewport().set_input_as_handled()
					return true
		if picked < 0:
			_close_player_prince_interaction()
			_close_player_character_interaction()
			player_navigation_pointer_seat.clear()
			_cancel_player_placement_selection()
			return false
		_close_player_prince_interaction()
		_select_player_placement_object(picked, mouse_button.position)
		if (
			String(editable_3d_objects[picked].get("kind", ""))
			in PLAYER_PERSON_KINDS
			and not player_navigation_active
		):
			var was_active_player := (
				active_player_character_id
				== String(editable_3d_objects[picked].get("id", ""))
			)
			_set_active_player_character(picked)
			if player_character_interaction_open and was_active_player:
				_close_player_character_interaction()
			else:
				_open_player_character_interaction(picked)
		get_viewport().set_input_as_handled()
		return true
	if not player_placement_object_dragging:
		if not player_navigation_pointer_seat.is_empty():
			var clicked_seat := player_navigation_pointer_seat.duplicate()
			player_navigation_pointer_seat.clear()
			_start_player_navigation_to_seat(clicked_seat)
			get_viewport().set_input_as_handled()
			return true
		return false
	if player_placement_object_drag_moved:
		_move_selected_editable_to_pointer(
			mouse_button.position + player_placement_drag_screen_offset
		)
	player_placement_object_dragging = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if player_placement_object_drag_moved:
		var moved_character := false
		var seated_after_move := false
		if (
			selected_editable_index >= 0
			and selected_editable_index < editable_3d_objects.size()
		):
			moved_character = _is_player_character_kind(String(
				editable_3d_objects[selected_editable_index].get("kind", "")
			))
			var character_drop_screen := _player_character_drop_screen(
				editable_3d_objects[selected_editable_index],
				mouse_button.position + player_placement_drag_screen_offset
			)
			seated_after_move = _try_sit_dropped_player_character(
				selected_editable_index,
				character_drop_screen,
				true
			)
		_save_3d_layout()
		player_place_status.text = (
			"已自动坐下并保存坐姿"
			if moved_character and seated_after_move
			else (
				"人物位置已保存"
				if moved_character
				else "位置已保存"
			)
		)
	player_placement_object_drag_moved = false
	player_placement_drag_press_position = Vector2.ZERO
	player_placement_drag_screen_offset = Vector2.ZERO
	player_placement_drag_travel = 0.0
	player_navigation_pointer_seat.clear()
	get_viewport().set_input_as_handled()
	return true


func _build_3d_editor_ui(root: Control) -> void:
	editor_panel = PanelContainer.new()
	editor_panel.name = "LayoutEditor"
	editor_panel.anchor_left = 1.0
	editor_panel.anchor_right = 1.0
	editor_panel.anchor_top = 0.0
	editor_panel.anchor_bottom = 1.0
	editor_panel.offset_left = -590.0
	editor_panel.offset_right = -40.0
	editor_panel.offset_top = 140.0
	editor_panel.offset_bottom = -30.0
	editor_panel.visible = false
	editor_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.025, 0.045, 0.075, 0.94)
	panel_style.border_color = Color(0.66, 0.55, 0.35, 0.76)
	panel_style.set_border_width_all(1)
	panel_style.set_corner_radius_all(4)
	panel_style.shadow_color = Color(0, 0, 0, 0.42)
	panel_style.shadow_size = 16
	editor_panel.add_theme_stylebox_override("panel", panel_style)
	root.add_child(editor_panel)

	editor_scroll = ScrollContainer.new()
	editor_scroll.name = "EditorScroll"
	editor_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	editor_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	editor_scroll.follow_focus = true
	editor_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	editor_panel.add_child(editor_scroll)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 22)
	margin.add_theme_constant_override("margin_right", 22)
	margin.add_theme_constant_override("margin_top", 18)
	margin.add_theme_constant_override("margin_bottom", 18)
	margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_scroll.add_child(margin)

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 6)
	content.custom_minimum_size = Vector2(388, 0)
	margin.add_child(content)

	var heading := Label.new()
	heading.text = "星球布局编辑器"
	heading.add_theme_font_size_override("font_size", 28)
	heading.add_theme_color_override("font_color", Color(0.95, 0.88, 0.73))
	content.add_child(heading)
	editor_heading = heading

	editor_subheading = Label.new()
	editor_subheading.text = "选择对象后拖拽星球表面，调整半径、缩放和朝向"
	editor_subheading.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	editor_subheading.add_theme_color_override("font_color", Color(0.72, 0.7, 0.64, 0.78))
	content.add_child(editor_subheading)

	var object_list_title := Label.new()
	object_list_title.text = "物品列表 | 点击选择"
	object_list_title.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	object_list_title.add_theme_color_override("font_color", Color(0.88, 0.76, 0.54, 0.9))
	content.add_child(object_list_title)

	editor_object_select = ItemList.new()
	editor_object_select.custom_minimum_size = Vector2(0, 100)
	editor_object_select.allow_reselect = true
	editor_object_select.select_mode = ItemList.SELECT_SINGLE
	editor_object_select.tooltip_text = "点击列表可直接选中被星球地形遮挡的物件"
	editor_object_select.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	editor_object_select.item_selected.connect(_on_editor_object_selected)
	content.add_child(editor_object_select)

	editor_character_animation_row = HBoxContainer.new()
	editor_character_animation_row.visible = false
	editor_character_animation_row.add_theme_constant_override("separation", 7)
	var character_animation_title := Label.new()
	character_animation_title.text = "角色动作"
	character_animation_title.custom_minimum_size = Vector2(82, 0)
	character_animation_title.tooltip_text = "选择后循环播放当前角色的指定动作"
	editor_character_animation_row.add_child(character_animation_title)
	editor_character_animation_select = OptionButton.new()
	editor_character_animation_select.name = "CharacterAnimationSelect"
	editor_character_animation_select.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_character_animation_select.tooltip_text = "切换当前选中角色的动画；选中的动作会循环播放"
	editor_character_animation_select.item_selected.connect(
		_on_editor_character_animation_selected
	)
	editor_character_animation_row.add_child(editor_character_animation_select)
	editor_character_animation_value = Label.new()
	editor_character_animation_value.text = "循环"
	editor_character_animation_value.custom_minimum_size = Vector2(42, 0)
	editor_character_animation_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	editor_character_animation_value.add_theme_color_override(
		"font_color",
		Color(0.68, 0.82, 0.72, 0.9)
	)
	editor_character_animation_row.add_child(editor_character_animation_value)
	content.add_child(editor_character_animation_row)

	var camera_zoom_row := HBoxContainer.new()
	camera_zoom_row.add_theme_constant_override("separation", 6)
	var camera_zoom_title := Label.new()
	camera_zoom_title.text = "镜头距离"
	camera_zoom_title.custom_minimum_size = Vector2(82, 0)
	camera_zoom_row.add_child(camera_zoom_title)
	var zoom_out_button := Button.new()
	zoom_out_button.text = "−"
	zoom_out_button.custom_minimum_size = Vector2(38, 32)
	zoom_out_button.tooltip_text = "拉远镜头，显示完整星球"
	_style_button(zoom_out_button)
	zoom_out_button.pressed.connect(_nudge_camera_distance.bind(1.0))
	camera_zoom_row.add_child(zoom_out_button)
	editor_camera_distance_slider = HSlider.new()
	editor_camera_distance_slider.min_value = CAMERA_ZOOM_MIN_DISTANCE
	editor_camera_distance_slider.max_value = CAMERA_ZOOM_MAX_DISTANCE
	editor_camera_distance_slider.step = 0.1
	editor_camera_distance_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_camera_distance_slider.value_changed.connect(
		_on_editor_camera_distance_changed
	)
	camera_zoom_row.add_child(editor_camera_distance_slider)
	var zoom_in_button := Button.new()
	zoom_in_button.text = "+"
	zoom_in_button.custom_minimum_size = Vector2(38, 32)
	zoom_in_button.tooltip_text = "拉近镜头"
	_style_button(zoom_in_button)
	zoom_in_button.pressed.connect(_nudge_camera_distance.bind(-1.0))
	camera_zoom_row.add_child(zoom_in_button)
	editor_camera_distance_value = Label.new()
	editor_camera_distance_value.custom_minimum_size = Vector2(48, 0)
	editor_camera_distance_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	camera_zoom_row.add_child(editor_camera_distance_value)
	content.add_child(camera_zoom_row)

	var initial_view_button := Button.new()
	initial_view_button.name = "SetInitialViewButton"
	initial_view_button.text = "将当前朝向设为初始视角"
	initial_view_button.custom_minimum_size = Vector2(0, 36)
	initial_view_button.tooltip_text = "旋转到满意的正面朝向后点击；重新进入或双击空白处会恢复此朝向"
	_style_button(initial_view_button, Color(0.46, 0.78, 0.72))
	initial_view_button.pressed.connect(_set_current_orientation_as_initial_view)
	content.add_child(initial_view_button)

	var planet_height_row := HBoxContainer.new()
	planet_height_row.add_theme_constant_override("separation", 7)
	var planet_height_title := Label.new()
	planet_height_title.text = "画面高度"
	planet_height_title.custom_minimum_size = Vector2(74, 0)
	planet_height_row.add_child(planet_height_title)
	var planet_move_up_button := Button.new()
	planet_move_up_button.name = "PlanetMoveUpButton"
	planet_move_up_button.text = "^ 星球上移"
	planet_move_up_button.custom_minimum_size = Vector2(108, 34)
	planet_move_up_button.tooltip_text = "让星球在画面中向上移动"
	_style_button(planet_move_up_button, Color(0.46, 0.78, 0.72))
	planet_move_up_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	planet_move_up_button.pressed.connect(_nudge_planet_framing_height.bind(0.06))
	planet_height_row.add_child(planet_move_up_button)
	var planet_move_down_button := Button.new()
	planet_move_down_button.name = "PlanetMoveDownButton"
	planet_move_down_button.text = "v 星球下移"
	planet_move_down_button.custom_minimum_size = Vector2(108, 34)
	planet_move_down_button.tooltip_text = "让星球在画面中向下移动"
	_style_button(planet_move_down_button)
	planet_move_down_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	planet_move_down_button.pressed.connect(_nudge_planet_framing_height.bind(-0.06))
	planet_height_row.add_child(planet_move_down_button)
	editor_planet_height_value = Label.new()
	editor_planet_height_value.custom_minimum_size = Vector2(54, 0)
	editor_planet_height_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	editor_planet_height_value.add_theme_color_override(
		"font_color",
		Color(0.75, 0.82, 0.72, 0.92)
	)
	planet_height_row.add_child(editor_planet_height_value)
	content.add_child(planet_height_row)

	var base_lighting_row := HBoxContainer.new()
	base_lighting_row.add_theme_constant_override("separation", 7)
	var base_lighting_title := Label.new()
	base_lighting_title.text = "基础光照"
	base_lighting_title.custom_minimum_size = Vector2(82, 0)
	base_lighting_title.tooltip_text = "调整当前星球的环境光、主光、轮廓光和补光强度"
	base_lighting_row.add_child(base_lighting_title)
	editor_base_lighting_slider = HSlider.new()
	editor_base_lighting_slider.name = "BaseLightingSlider"
	editor_base_lighting_slider.min_value = PLANET_BASE_LIGHTING_MIN
	editor_base_lighting_slider.max_value = PLANET_BASE_LIGHTING_MAX
	editor_base_lighting_slider.step = PLANET_BASE_LIGHTING_STEP
	editor_base_lighting_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_base_lighting_slider.tooltip_text = "25%–200%；100% 为当前星球的默认基础光照"
	editor_base_lighting_slider.value_changed.connect(
		_on_editor_base_lighting_changed
	)
	base_lighting_row.add_child(editor_base_lighting_slider)
	editor_base_lighting_value = Label.new()
	editor_base_lighting_value.custom_minimum_size = Vector2(58, 0)
	editor_base_lighting_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	base_lighting_row.add_child(editor_base_lighting_value)
	content.add_child(base_lighting_row)

	editor_earth_wheat_controls = VBoxContainer.new()
	editor_earth_wheat_controls.name = "EarthWheatLightingControls"
	editor_earth_wheat_controls.visible = false
	editor_earth_wheat_controls.add_theme_constant_override("separation", 4)
	var wheat_brightness_row := HBoxContainer.new()
	wheat_brightness_row.add_theme_constant_override("separation", 7)
	var wheat_brightness_title := Label.new()
	wheat_brightness_title.text = "麦田明暗"
	wheat_brightness_title.custom_minimum_size = Vector2(82, 0)
	wheat_brightness_row.add_child(wheat_brightness_title)
	var wheat_darker_button := Button.new()
	wheat_darker_button.text = "−"
	wheat_darker_button.custom_minimum_size = Vector2(38, 32)
	wheat_darker_button.tooltip_text = "降低麦田亮度"
	_style_button(wheat_darker_button)
	wheat_darker_button.pressed.connect(
		_nudge_earth_wheat_tone.bind("brightness", -EARTH_WHEAT_TONE_STEP)
	)
	wheat_brightness_row.add_child(wheat_darker_button)
	editor_earth_wheat_brightness_value = Label.new()
	editor_earth_wheat_brightness_value.custom_minimum_size = Vector2(58, 0)
	editor_earth_wheat_brightness_value.horizontal_alignment = (
		HORIZONTAL_ALIGNMENT_CENTER
	)
	wheat_brightness_row.add_child(editor_earth_wheat_brightness_value)
	var wheat_brighter_button := Button.new()
	wheat_brighter_button.text = "+"
	wheat_brighter_button.custom_minimum_size = Vector2(38, 32)
	wheat_brighter_button.tooltip_text = "提高麦田亮度"
	_style_button(wheat_brighter_button)
	wheat_brighter_button.pressed.connect(
		_nudge_earth_wheat_tone.bind("brightness", EARTH_WHEAT_TONE_STEP)
	)
	wheat_brightness_row.add_child(wheat_brighter_button)
	editor_earth_wheat_controls.add_child(wheat_brightness_row)

	var wheat_saturation_row := HBoxContainer.new()
	wheat_saturation_row.add_theme_constant_override("separation", 7)
	var wheat_saturation_title := Label.new()
	wheat_saturation_title.text = "麦田饱和"
	wheat_saturation_title.custom_minimum_size = Vector2(82, 0)
	wheat_saturation_row.add_child(wheat_saturation_title)
	var wheat_less_saturated_button := Button.new()
	wheat_less_saturated_button.text = "−"
	wheat_less_saturated_button.custom_minimum_size = Vector2(38, 32)
	wheat_less_saturated_button.tooltip_text = "降低麦田颜色饱和度"
	_style_button(wheat_less_saturated_button)
	wheat_less_saturated_button.pressed.connect(
		_nudge_earth_wheat_tone.bind("saturation", -EARTH_WHEAT_TONE_STEP)
	)
	wheat_saturation_row.add_child(wheat_less_saturated_button)
	editor_earth_wheat_saturation_value = Label.new()
	editor_earth_wheat_saturation_value.custom_minimum_size = Vector2(58, 0)
	editor_earth_wheat_saturation_value.horizontal_alignment = (
		HORIZONTAL_ALIGNMENT_CENTER
	)
	wheat_saturation_row.add_child(editor_earth_wheat_saturation_value)
	var wheat_more_saturated_button := Button.new()
	wheat_more_saturated_button.text = "+"
	wheat_more_saturated_button.custom_minimum_size = Vector2(38, 32)
	wheat_more_saturated_button.tooltip_text = "提高麦田颜色饱和度"
	_style_button(wheat_more_saturated_button)
	wheat_more_saturated_button.pressed.connect(
		_nudge_earth_wheat_tone.bind("saturation", EARTH_WHEAT_TONE_STEP)
	)
	wheat_saturation_row.add_child(wheat_more_saturated_button)
	editor_earth_wheat_controls.add_child(wheat_saturation_row)

	var earth_light_direction_row := HBoxContainer.new()
	earth_light_direction_row.add_theme_constant_override("separation", 7)
	var earth_light_direction_title := Label.new()
	earth_light_direction_title.text = "主光方向"
	earth_light_direction_title.custom_minimum_size = Vector2(82, 0)
	earth_light_direction_title.tooltip_text = "绕星球旋转地球主光的方向"
	earth_light_direction_row.add_child(earth_light_direction_title)
	var light_left_button := Button.new()
	light_left_button.text = "<"
	light_left_button.custom_minimum_size = Vector2(38, 32)
	light_left_button.tooltip_text = "主光向左旋转 10°"
	_style_button(light_left_button)
	light_left_button.pressed.connect(
		_nudge_earth_light_direction.bind(-EARTH_LIGHT_YAW_STEP)
	)
	earth_light_direction_row.add_child(light_left_button)
	editor_earth_light_yaw_value = Label.new()
	editor_earth_light_yaw_value.custom_minimum_size = Vector2(58, 0)
	editor_earth_light_yaw_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	earth_light_direction_row.add_child(editor_earth_light_yaw_value)
	var light_right_button := Button.new()
	light_right_button.text = ">"
	light_right_button.custom_minimum_size = Vector2(38, 32)
	light_right_button.tooltip_text = "主光向右旋转 10°"
	_style_button(light_right_button)
	light_right_button.pressed.connect(
		_nudge_earth_light_direction.bind(EARTH_LIGHT_YAW_STEP)
	)
	earth_light_direction_row.add_child(light_right_button)
	editor_earth_wheat_controls.add_child(earth_light_direction_row)

	var reset_earth_wheat_button := Button.new()
	reset_earth_wheat_button.text = "恢复麦田默认观感"
	reset_earth_wheat_button.custom_minimum_size = Vector2(0, 34)
	reset_earth_wheat_button.tooltip_text = "恢复较柔和的默认麦田明暗与饱和度"
	_style_button(reset_earth_wheat_button, Color(0.46, 0.78, 0.72))
	reset_earth_wheat_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	reset_earth_wheat_button.pressed.connect(_reset_earth_wheat_tone)
	editor_earth_wheat_controls.add_child(reset_earth_wheat_button)
	content.add_child(editor_earth_wheat_controls)

	editor_add_light_button = Button.new()
	editor_add_light_button.text = "添加发光点位"
	editor_add_light_button.custom_minimum_size = Vector2(0, 40)
	editor_add_light_button.visible = false
	_style_button(editor_add_light_button, Color(0.86, 0.66, 0.31))
	editor_add_light_button.pressed.connect(_add_king_light_from_editor)
	content.add_child(editor_add_light_button)

	var scale_row := HBoxContainer.new()
	var scale_title := Label.new()
	scale_title.text = "缩放"
	scale_title.custom_minimum_size = Vector2(110, 0)
	scale_row.add_child(scale_title)
	editor_scale_slider = HSlider.new()
	editor_scale_slider.min_value = 0.3
	editor_scale_slider.max_value = 3.0
	editor_scale_slider.step = 0.05
	editor_scale_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_scale_slider.value_changed.connect(_on_editor_scale_changed)
	scale_row.add_child(editor_scale_slider)
	editor_scale_value = Label.new()
	editor_scale_value.custom_minimum_size = Vector2(64, 0)
	editor_scale_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	scale_row.add_child(editor_scale_value)
	content.add_child(scale_row)

	var yaw_row := HBoxContainer.new()
	var yaw_title := Label.new()
	yaw_title.text = "朝向"
	yaw_title.custom_minimum_size = Vector2(110, 0)
	yaw_row.add_child(yaw_title)
	editor_yaw_slider = HSlider.new()
	editor_yaw_slider.min_value = -180.0
	editor_yaw_slider.max_value = 180.0
	editor_yaw_slider.step = 1.0
	editor_yaw_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_yaw_slider.value_changed.connect(_on_editor_yaw_changed)
	yaw_row.add_child(editor_yaw_slider)
	editor_yaw_value = Label.new()
	editor_yaw_value.custom_minimum_size = Vector2(64, 0)
	editor_yaw_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	yaw_row.add_child(editor_yaw_value)
	content.add_child(yaw_row)

	var surface_tilt_row := HBoxContainer.new()
	surface_tilt_row.add_theme_constant_override("separation", 5)
	var surface_tilt_title := Label.new()
	surface_tilt_title.text = "球面倾角"
	surface_tilt_title.tooltip_text = "0° 表示物件基座垂直于当前球面落点"
	surface_tilt_title.custom_minimum_size = Vector2(82, 0)
	surface_tilt_row.add_child(surface_tilt_title)
	var tilt_minus_button := Button.new()
	tilt_minus_button.text = "−1°"
	tilt_minus_button.custom_minimum_size = Vector2(42, 32)
	tilt_minus_button.tooltip_text = "沿球面切线向后倾斜 1°"
	_style_button(tilt_minus_button)
	tilt_minus_button.pressed.connect(_nudge_editor_surface_tilt.bind(-1.0))
	surface_tilt_row.add_child(tilt_minus_button)
	var tilt_align_button := Button.new()
	tilt_align_button.text = "贴地"
	tilt_align_button.custom_minimum_size = Vector2(54, 32)
	tilt_align_button.tooltip_text = "将物件基座对准当前球面落点"
	_style_button(tilt_align_button, Color(0.58, 0.74, 0.88))
	tilt_align_button.pressed.connect(_align_selected_3d_object_to_surface)
	surface_tilt_row.add_child(tilt_align_button)
	var tilt_plus_button := Button.new()
	tilt_plus_button.text = "+1°"
	tilt_plus_button.custom_minimum_size = Vector2(42, 32)
	tilt_plus_button.tooltip_text = "沿球面切线向前倾斜 1°"
	_style_button(tilt_plus_button)
	tilt_plus_button.pressed.connect(_nudge_editor_surface_tilt.bind(1.0))
	surface_tilt_row.add_child(tilt_plus_button)
	editor_surface_tilt_slider = HSlider.new()
	editor_surface_tilt_slider.min_value = -60.0
	editor_surface_tilt_slider.max_value = 60.0
	editor_surface_tilt_slider.step = 0.5
	editor_surface_tilt_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_surface_tilt_slider.tooltip_text = "微调物件相对球面法线的倾倒角度"
	editor_surface_tilt_slider.value_changed.connect(_on_editor_surface_tilt_changed)
	surface_tilt_row.add_child(editor_surface_tilt_slider)
	editor_surface_tilt_value = Label.new()
	editor_surface_tilt_value.custom_minimum_size = Vector2(54, 0)
	editor_surface_tilt_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	surface_tilt_row.add_child(editor_surface_tilt_value)
	content.add_child(surface_tilt_row)

	var distance_row := HBoxContainer.new()
	var distance_title := Label.new()
	distance_title.text = "离球心"
	distance_title.custom_minimum_size = Vector2(110, 0)
	distance_row.add_child(distance_title)
	editor_distance_title = distance_title
	editor_distance_slider = HSlider.new()
	editor_distance_slider.min_value = 1.5
	editor_distance_slider.max_value = 8.0
	editor_distance_slider.step = 0.01
	editor_distance_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_distance_slider.value_changed.connect(_on_editor_distance_changed)
	distance_row.add_child(editor_distance_slider)
	editor_distance_value = Label.new()
	editor_distance_value.custom_minimum_size = Vector2(64, 0)
	editor_distance_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	distance_row.add_child(editor_distance_value)
	content.add_child(distance_row)

	editor_height_row = HBoxContainer.new()
	editor_height_row.visible = false
	var height_title := Label.new()
	height_title.text = "离底部"
	height_title.custom_minimum_size = Vector2(110, 0)
	editor_height_row.add_child(height_title)
	editor_height_title = height_title
	editor_height_slider = HSlider.new()
	editor_height_slider.min_value = 0.0
	editor_height_slider.max_value = 6.0
	editor_height_slider.step = 0.01
	editor_height_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_height_slider.value_changed.connect(_on_editor_height_changed)
	editor_height_row.add_child(editor_height_slider)
	editor_height_value = Label.new()
	editor_height_value.custom_minimum_size = Vector2(64, 0)
	editor_height_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	editor_height_row.add_child(editor_height_value)
	content.add_child(editor_height_row)

	editor_height_lock_row = HBoxContainer.new()
	editor_height_lock_row.name = "CharacterHeightLocks"
	editor_height_lock_row.visible = false
	editor_height_lock_row.add_theme_constant_override("separation", 7)
	content.add_child(editor_height_lock_row)

	editor_standing_height_lock_button = Button.new()
	editor_standing_height_lock_button.text = "站立高度：锁定"
	editor_standing_height_lock_button.size_flags_horizontal = (
		Control.SIZE_EXPAND_FILL
	)
	editor_standing_height_lock_button.toggle_mode = true
	editor_standing_height_lock_button.pressed.connect(
		_toggle_player_character_height_lock.bind("standing")
	)
	_style_button(
		editor_standing_height_lock_button,
		Color(0.52, 0.68, 0.78)
	)
	editor_height_lock_row.add_child(editor_standing_height_lock_button)

	editor_sitting_height_lock_button = Button.new()
	editor_sitting_height_lock_button.text = "坐下高度：锁定"
	editor_sitting_height_lock_button.size_flags_horizontal = (
		Control.SIZE_EXPAND_FILL
	)
	editor_sitting_height_lock_button.toggle_mode = true
	editor_sitting_height_lock_button.pressed.connect(
		_toggle_player_character_height_lock.bind("sitting")
	)
	_style_button(
		editor_sitting_height_lock_button,
		Color(0.76, 0.62, 0.42)
	)
	editor_height_lock_row.add_child(editor_sitting_height_lock_button)

	var light_row := HBoxContainer.new()
	light_row.add_theme_constant_override("separation", 6)
	var light_title := Label.new()
	light_title.text = "灯光偏移"
	light_title.custom_minimum_size = Vector2(110, 0)
	light_row.add_child(light_title)
	var light_spins: Array[SpinBox] = []
	for axis in 3:
		var spin := SpinBox.new()
		spin.min_value = -2.0
		spin.max_value = 2.0
		spin.step = 0.01
		spin.custom_minimum_size = Vector2(92, 34)
		spin.prefix = ["X ", "Y ", "Z "][axis]
		spin.value_changed.connect(_on_editor_light_offset_changed.bind(axis))
		light_row.add_child(spin)
		light_spins.append(spin)
	editor_light_x = light_spins[0]
	editor_light_y = light_spins[1]
	editor_light_z = light_spins[2]
	content.add_child(light_row)

	editor_visible_check = CheckBox.new()
	editor_visible_check.text = "显示此物体"
	editor_visible_check.toggled.connect(_on_editor_visibility_toggled)
	content.add_child(editor_visible_check)

	editor_light_on_check = CheckBox.new()
	editor_light_on_check.text = "点亮发光点位"
	editor_light_on_check.visible = false
	editor_light_on_check.toggled.connect(_on_editor_light_power_toggled)
	content.add_child(editor_light_on_check)

	editor_brightness_row = HBoxContainer.new()
	editor_brightness_row.visible = false
	var brightness_title := Label.new()
	brightness_title.text = "亮度"
	brightness_title.custom_minimum_size = Vector2(110, 0)
	editor_brightness_row.add_child(brightness_title)
	editor_brightness_slider = HSlider.new()
	editor_brightness_slider.min_value = 0.1
	editor_brightness_slider.max_value = 2.5
	editor_brightness_slider.step = 0.05
	editor_brightness_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	editor_brightness_slider.value_changed.connect(_on_editor_brightness_changed)
	editor_brightness_row.add_child(editor_brightness_slider)
	editor_brightness_value = Label.new()
	editor_brightness_value.custom_minimum_size = Vector2(64, 0)
	editor_brightness_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	editor_brightness_row.add_child(editor_brightness_value)
	content.add_child(editor_brightness_row)

	editor_position_label = Label.new()
	editor_position_label.custom_minimum_size = Vector2(0, 42)
	editor_position_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	editor_position_label.add_theme_color_override("font_color", Color(0.68, 0.75, 0.86, 0.88))
	content.add_child(editor_position_label)

	var action_row := HBoxContainer.new()
	action_row.add_theme_constant_override("separation", 8)
	content.add_child(action_row)
	var copy_button := Button.new()
	copy_button.name = "CopyObjectButton"
	copy_button.text = "复制对象"
	copy_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_style_button(copy_button, Color(0.8, 0.65, 0.37))
	copy_button.pressed.connect(_duplicate_selected_3d_object)
	action_row.add_child(copy_button)
	var reset_button := Button.new()
	reset_button.name = "ResetObjectButton"
	reset_button.text = "恢复当前"
	reset_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_style_button(reset_button)
	reset_button.pressed.connect(_reset_selected_3d_object)
	action_row.add_child(reset_button)
	var delete_button := Button.new()
	delete_button.name = "DeleteObjectButton"
	delete_button.text = "删除对象"
	delete_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_style_button(delete_button, Color(0.86, 0.42, 0.34))
	delete_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	delete_button.pressed.connect(_delete_selected_3d_object)
	action_row.add_child(delete_button)
	editor_delete_button = delete_button
	var lock_button := Button.new()
	lock_button.name = "LockObjectButton"
	lock_button.text = "锁定位置"
	lock_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_style_button(lock_button, Color(0.55, 0.70, 0.86))
	lock_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	lock_button.pressed.connect(_toggle_selected_3d_object_lock)
	action_row.add_child(lock_button)
	editor_lock_button = lock_button

	var save_button := Button.new()
	save_button.name = "SaveLayoutButton"
	save_button.text = "保存布局"
	save_button.custom_minimum_size = Vector2(0, 44)
	_style_button(save_button, Color(0.83, 0.68, 0.39))
	save_button.pressed.connect(_save_3d_layout)
	content.add_child(save_button)

	editor_status_label = Label.new()
	editor_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	editor_status_label.custom_minimum_size = Vector2(0, 48)
	editor_status_label.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	editor_status_label.add_theme_color_override("font_color", Color(0.72, 0.7, 0.64, 0.72))
	content.add_child(editor_status_label)

	var done_button := Button.new()
	done_button.name = "DoneLayoutButton"
	done_button.text = "完成布局"
	done_button.custom_minimum_size = Vector2(0, 38)
	_style_button(done_button)
	done_button.pressed.connect(_toggle_3d_editor)
	content.add_child(done_button)


func _build_chair_interaction_ui(root: Control) -> void:
	chair_action_button = FACE_ARROW_BUTTON_SCRIPT.new()
	chair_action_button.name = "ChairAction"
	chair_action_button.set_arrow_angle(-90.0)
	chair_action_button.set_paper_texture(load(UI_CLICK_GUIDE) as Texture2D)
	chair_action_button.tooltip_text = ""
	chair_action_button.size = Vector2(50, 72)
	chair_action_button.visible = false
	chair_action_button.button_down.connect(_on_chair_action_button_down)
	chair_action_button.pressed.connect(_on_chair_action_pressed)
	root.add_child(chair_action_button)

	chair_target_marker = PanelContainer.new()
	chair_target_marker.name = "ChairTarget"
	chair_target_marker.size = Vector2(92, 92)
	chair_target_marker.visible = false
	chair_target_marker.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var target_style := StyleBoxFlat.new()
	target_style.bg_color = Color.TRANSPARENT
	target_style.set_border_width_all(0)
	chair_target_marker.add_theme_stylebox_override("panel", target_style)
	var target_paper := TextureRect.new()
	target_paper.texture = load(UI_CHAIR_TARGET)
	target_paper.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	target_paper.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	target_paper.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	target_paper.mouse_filter = Control.MOUSE_FILTER_IGNORE
	chair_target_marker.add_child(target_paper)
	root.add_child(chair_target_marker)

	chair_status_label = _add_label(
		root,
		"",
		Vector2(430, 850),
		Vector2(740, 40),
		17,
		Color(0.28, 0.20, 0.14, 1.0)
	)
	chair_status_label.add_theme_stylebox_override(
		"normal",
		_make_paper_style(
			UI_HINT_STRIP,
			Vector4(45, 14, 24, 14),
			Vector4(24, 5, 20, 5)
		)
	)
	chair_status_label.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	chair_subtitle_label = _add_label(
		root,
		"小王子搬来了一把椅子",
		Vector2(420, 790),
		Vector2(760, 52),
		24,
		Color(0.26, 0.18, 0.12, 1.0)
	)
	chair_subtitle_label.add_theme_stylebox_override(
		"normal",
		_make_paper_style(
			UI_HINT_STRIP,
			Vector4(45, 14, 24, 14),
			Vector4(24, 6, 20, 6)
		)
	)
	chair_subtitle_label.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	chair_subtitle_label.visible = false


func _build_lamplighter_dialogue_ui(root: Control) -> void:
	lamp_dialogue_trigger = CHAT_BUBBLE_BUTTON_SCRIPT.new()
	lamp_dialogue_trigger.name = "DialogueTrigger"
	lamp_dialogue_trigger.text = ""
	lamp_dialogue_trigger.tooltip_text = ""
	lamp_dialogue_trigger.size = Vector2(64, 57)
	lamp_dialogue_trigger.visible = false
	lamp_dialogue_trigger.focus_mode = Control.FOCUS_NONE
	lamp_dialogue_trigger.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	lamp_dialogue_trigger.pressed.connect(_start_current_dialogue)
	root.add_child(lamp_dialogue_trigger)

	dialogue_panel = PanelContainer.new()
	dialogue_panel.name = "LamplighterDialogue"
	dialogue_panel.position = Vector2(930, 135)
	dialogue_panel.size = Vector2(615, 805)
	dialogue_panel.visible = false
	dialogue_panel.clip_contents = true
	dialogue_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	_register_ui_control(
		dialogue_panel,
		"dialogue.panel",
		"对话框整体",
		false
	)
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color.TRANSPARENT
	panel_style.set_border_width_all(0)
	panel_style.content_margin_left = 0
	panel_style.content_margin_right = 0
	panel_style.content_margin_top = 0
	panel_style.content_margin_bottom = 0
	dialogue_panel.add_theme_stylebox_override("panel", panel_style)
	root.add_child(dialogue_panel)

	var paper_backdrop := TextureRect.new()
	paper_backdrop.name = "DialoguePaper"
	paper_backdrop.texture = load(DIALOGUE_PAPER_PATH)
	paper_backdrop.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	paper_backdrop.stretch_mode = TextureRect.STRETCH_SCALE
	paper_backdrop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	paper_backdrop.custom_minimum_size = Vector2.ZERO
	paper_backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	dialogue_panel.add_child(paper_backdrop)

	var margin := MarginContainer.new()
	# The dialogue card's inner ruled frame is drawn at x=73..343 on a
	# 370px-wide source texture. These margins map that safe area exactly
	# into the 615px dialogue panel instead of using the whole paper width.
	margin.add_theme_constant_override("margin_left", 121)
	margin.add_theme_constant_override("margin_right", 45)
	margin.add_theme_constant_override("margin_top", 76)
	margin.add_theme_constant_override("margin_bottom", 75)
	dialogue_panel.add_child(margin)
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 12)
	margin.add_child(content)

	var heading_row := Control.new()
	heading_row.custom_minimum_size = Vector2(0, 60)
	content.add_child(heading_row)
	var heading := Label.new()
	heading.text = "*  点灯人"
	heading.position = Vector2(18, 0)
	heading.size = Vector2(300, 42)
	heading.add_theme_font_size_override("font_size", 34)
	heading.add_theme_color_override("font_color", Color(0.31, 0.17, 0.13, 1.0))
	heading_row.add_child(heading)
	dialogue_heading = heading
	_register_ui_control(heading, "dialogue.heading", "对话标题")
	dialogue_text_edit_button = Button.new()
	dialogue_text_edit_button.name = "EditDialogueText"
	dialogue_text_edit_button.text = "调字"
	dialogue_text_edit_button.tooltip_text = "拖动选项目中的文字，调整它们的位置、宽高和字号"
	dialogue_text_edit_button.visible = false
	dialogue_text_edit_button.anchor_left = 1.0
	dialogue_text_edit_button.anchor_right = 1.0
	dialogue_text_edit_button.offset_left = -127.0
	dialogue_text_edit_button.offset_right = -65.0
	dialogue_text_edit_button.offset_top = 3.0
	dialogue_text_edit_button.offset_bottom = 41.0
	dialogue_text_edit_button.custom_minimum_size = Vector2.ZERO
	dialogue_text_edit_button.add_theme_font_size_override("font_size", UI_FONT_ACTION)
	_style_button(dialogue_text_edit_button)
	dialogue_text_edit_button.pressed.connect(_toggle_dialogue_text_edit_mode)
	heading_row.add_child(dialogue_text_edit_button)
	_register_ui_control(
		dialogue_text_edit_button,
		"dialogue.text_button",
		"对话调字按钮"
	)
	var close_button := PAPER_CLOSE_BUTTON_SCRIPT.new()
	close_button.name = "CloseDialogue"
	close_button.tooltip_text = "关闭"
	close_button.custom_minimum_size = Vector2.ZERO
	close_button.anchor_left = 1.0
	close_button.anchor_right = 1.0
	close_button.offset_left = -58.0
	close_button.offset_right = 0.0
	close_button.offset_top = 0.0
	close_button.offset_bottom = 48.0
	close_button.modulate = Color(1.0, 1.0, 1.0, 0.0)
	close_button.pressed.connect(_close_active_dialogue)
	heading_row.add_child(close_button)
	_register_ui_control(close_button, "dialogue.close", "对话关闭按钮", false)

	dialogue_text_toolbar = PanelContainer.new()
	dialogue_text_toolbar.name = "DialogueTextToolbar"
	dialogue_text_toolbar.visible = false
	var toolbar_style := StyleBoxFlat.new()
	toolbar_style.bg_color = Color(0.14, 0.11, 0.08, 0.90)
	toolbar_style.border_color = Color(0.67, 0.49, 0.25, 0.76)
	toolbar_style.set_border_width_all(1)
	toolbar_style.set_corner_radius_all(3)
	toolbar_style.content_margin_left = 10
	toolbar_style.content_margin_right = 10
	toolbar_style.content_margin_top = 6
	toolbar_style.content_margin_bottom = 6
	dialogue_text_toolbar.add_theme_stylebox_override("panel", toolbar_style)
	content.add_child(dialogue_text_toolbar)
	var toolbar_content := VBoxContainer.new()
	toolbar_content.add_theme_constant_override("separation", 5)
	dialogue_text_toolbar.add_child(toolbar_content)
	dialogue_text_status = Label.new()
	dialogue_text_status.text = "选中文字后可拖动；拖右下角改宽高"
	dialogue_text_status.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
	dialogue_text_status.add_theme_color_override(
		"font_color",
		Color(0.96, 0.88, 0.70, 0.96)
	)
	toolbar_content.add_child(dialogue_text_status)
	var typography_buttons := HBoxContainer.new()
	typography_buttons.add_theme_constant_override("separation", 6)
	toolbar_content.add_child(typography_buttons)
	for label_text in ["左齐", "居中", "右齐", "行距-", "行距+"]:
		var typography_button := Button.new()
		typography_button.text = label_text
		typography_button.custom_minimum_size = Vector2(66, 32)
		typography_button.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
		_style_button(typography_button)
		typography_buttons.add_child(typography_button)
		match label_text:
			"左齐":
				typography_button.pressed.connect(
					_set_dialogue_text_alignment.bind(HORIZONTAL_ALIGNMENT_LEFT)
				)
			"居中":
				typography_button.pressed.connect(
					_set_dialogue_text_alignment.bind(HORIZONTAL_ALIGNMENT_CENTER)
				)
			"右齐":
				typography_button.pressed.connect(
					_set_dialogue_text_alignment.bind(HORIZONTAL_ALIGNMENT_RIGHT)
				)
			"行距-":
				typography_button.pressed.connect(
					_adjust_dialogue_text_line_spacing.bind(-1)
				)
			"行距+":
				typography_button.pressed.connect(
					_adjust_dialogue_text_line_spacing.bind(1)
				)
	var toolbar_buttons := HBoxContainer.new()
	toolbar_buttons.add_theme_constant_override("separation", 6)
	toolbar_content.add_child(toolbar_buttons)
	for label_text in ["字小", "字大", "重置", "保存", "完成"]:
		var toolbar_button := Button.new()
		toolbar_button.text = label_text
		toolbar_button.custom_minimum_size = Vector2(66, 32)
		toolbar_button.add_theme_font_size_override("font_size", UI_FONT_CAPTION)
		_style_button(toolbar_button)
		toolbar_buttons.add_child(toolbar_button)
		match label_text:
			"字小":
				toolbar_button.pressed.connect(_adjust_dialogue_text_font.bind(-1))
			"字大":
				toolbar_button.pressed.connect(_adjust_dialogue_text_font.bind(1))
			"重置":
				toolbar_button.pressed.connect(_reset_dialogue_text_boxes)
			"保存":
				toolbar_button.pressed.connect(_save_dialogue_text_layout.bind(true))
			"完成":
				toolbar_button.pressed.connect(_set_dialogue_text_edit_mode.bind(false))

	var body_frame := MarginContainer.new()
	body_frame.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body_frame.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body_frame.add_theme_constant_override("margin_left", 18)
	body_frame.add_theme_constant_override("margin_right", 18)
	content.add_child(body_frame)
	dialogue_body_frame = body_frame
	dialogue_scroll = ScrollContainer.new()
	dialogue_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	dialogue_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	dialogue_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	dialogue_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
	body_frame.add_child(dialogue_scroll)
	dialogue_log = VBoxContainer.new()
	dialogue_log.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	dialogue_log.add_theme_constant_override("separation", 16)
	dialogue_scroll.add_child(dialogue_log)
	dialogue_choices = VBoxContainer.new()
	dialogue_choices.add_theme_constant_override("separation", 6)
	dialogue_choices.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	dialogue_choices.clip_contents = false
	content.add_child(dialogue_choices)


func _build_king_ritual_ui(root: Control) -> void:
	king_ritual_subtitle = _add_label(
		root,
		"",
		Vector2(220, 760),
		Vector2(1160, 104),
		26,
		Color(1.0, 0.93, 0.77, 0.96),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	king_ritual_subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	king_ritual_subtitle.add_theme_constant_override("line_spacing", 2)
	king_ritual_subtitle.add_theme_color_override("font_shadow_color", Color(0.01, 0.02, 0.04, 0.98))
	king_ritual_subtitle.add_theme_constant_override("shadow_offset_x", 0)
	king_ritual_subtitle.add_theme_constant_override("shadow_offset_y", 1)
	king_ritual_subtitle.add_theme_constant_override("outline_size", 1)
	king_ritual_subtitle.add_theme_color_override("font_outline_color", Color(0.01, 0.02, 0.04, 0.62))
	king_ritual_subtitle.visible = false
	_register_ui_control(
		king_ritual_subtitle,
		"hud.king.ritual_text",
		"国王仪式字幕"
	)

	king_sun_click_guide = FACE_ARROW_BUTTON_SCRIPT.new()
	king_sun_click_guide.name = "SunClickGuide"
	king_sun_click_guide.set_arrow_angle(-135.0)
	king_sun_click_guide.set_paper_texture(load(UI_CLICK_GUIDE) as Texture2D)
	king_sun_click_guide.tooltip_text = ""
	king_sun_click_guide.size = Vector2(58, 84)
	king_sun_click_guide.pivot_offset = king_sun_click_guide.size * 0.5
	king_sun_click_guide.visible = false
	king_sun_click_guide.pressed.connect(_advance_king_ritual)
	root.add_child(king_sun_click_guide)


func _build_story_action_ui(root: Control) -> void:
	story_subtitle_panel = Control.new()
	story_subtitle_panel.name = "StorySubtitlePanel"
	story_subtitle_panel.position = Vector2(180, 680)
	story_subtitle_panel.size = Vector2(1240, 144)
	story_subtitle_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	story_subtitle_panel.visible = false
	root.add_child(story_subtitle_panel)
	_register_ui_control(
		story_subtitle_panel,
		"story.subtitle_panel",
		"剧情字幕底板",
		false
	)

	var subtitle_backdrop := TextureRect.new()
	subtitle_backdrop.name = "StorySubtitleGradient"
	subtitle_backdrop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	subtitle_backdrop.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	subtitle_backdrop.stretch_mode = TextureRect.STRETCH_SCALE
	subtitle_backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var subtitle_gradient := Gradient.new()
	subtitle_gradient.offsets = PackedFloat32Array([
		0.0,
		0.24,
		0.76,
		1.0,
	])
	subtitle_gradient.colors = PackedColorArray([
		Color(0.018, 0.032, 0.048, 0.0),
		Color(0.018, 0.032, 0.048, 0.58),
		Color(0.018, 0.032, 0.048, 0.58),
		Color(0.018, 0.032, 0.048, 0.0),
	])
	var subtitle_texture := GradientTexture2D.new()
	subtitle_texture.gradient = subtitle_gradient
	subtitle_texture.width = 512
	subtitle_texture.height = 32
	subtitle_texture.fill_from = Vector2(0.0, 0.5)
	subtitle_texture.fill_to = Vector2(1.0, 0.5)
	subtitle_backdrop.texture = subtitle_texture
	story_subtitle_panel.add_child(subtitle_backdrop)

	story_subtitle_label = Label.new()
	story_subtitle_label.text = ""
	story_subtitle_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	story_subtitle_label.offset_left = 52.0
	story_subtitle_label.offset_right = -52.0
	story_subtitle_label.offset_top = 12.0
	story_subtitle_label.offset_bottom = -12.0
	story_subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	story_subtitle_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	story_subtitle_label.add_theme_font_size_override("font_size", 28)
	story_subtitle_label.add_theme_constant_override("line_spacing", 8)
	story_subtitle_label.add_theme_color_override(
		"font_color",
		Color(1.0, 0.94, 0.82, 1.0)
	)
	story_subtitle_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	story_subtitle_label.add_theme_color_override(
		"font_shadow_color",
		Color(0.01, 0.02, 0.04, 0.72)
	)
	story_subtitle_label.add_theme_constant_override("shadow_offset_y", 1)
	story_subtitle_label.add_theme_constant_override("outline_size", 1)
	story_subtitle_label.add_theme_color_override(
		"font_outline_color",
		Color(0.01, 0.02, 0.04, 0.62)
	)
	story_subtitle_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	story_subtitle_panel.add_child(story_subtitle_label)
	_register_ui_control(
		story_subtitle_label,
		"story.subtitle_text",
		"剧情字幕文字"
	)

	story_hint_panel = PanelContainer.new()
	story_hint_panel.name = "StoryHintPanel"
	story_hint_panel.position = Vector2(350, 842)
	story_hint_panel.size = Vector2(900, 52)
	story_hint_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var hint_style := _make_paper_style(
		UI_HINT_STRIP,
		Vector4(55, 16, 28, 16),
		Vector4(30, 8, 24, 8)
	)
	story_hint_panel.add_theme_stylebox_override("panel", hint_style)
	story_hint_panel.visible = false
	root.add_child(story_hint_panel)
	_register_ui_control(
		story_hint_panel,
		"story.hint_panel",
		"剧情操作提示底板",
		false
	)

	story_hint_label = Label.new()
	story_hint_label.text = ""
	story_hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	story_hint_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	story_hint_label.add_theme_font_size_override("font_size", 22)
	story_hint_label.add_theme_constant_override("line_spacing", 2)
	story_hint_label.add_theme_color_override(
		"font_color",
		Color(0.28, 0.20, 0.14, 1.0)
	)
	story_hint_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	story_hint_label.add_theme_color_override(
		"font_shadow_color",
		Color.TRANSPARENT
	)
	story_hint_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	story_hint_panel.add_child(story_hint_label)
	_register_ui_control(
		story_hint_label,
		"story.hint_text",
		"剧情操作提示文字"
	)

	story_action_button = FACE_ARROW_BUTTON_SCRIPT.new()
	story_action_button.name = "StoryAction"
	story_action_button.set_arrow_angle(-90.0)
	story_action_button.set_paper_texture(load(UI_CLICK_GUIDE) as Texture2D)
	story_action_button.tooltip_text = ""
	story_action_button.size = Vector2(52, 76)
	story_action_button.pivot_offset = story_action_button.size * 0.5
	story_action_button.visible = false
	story_action_button.pressed.connect(_on_story_action_pressed)
	root.add_child(story_action_button)
	_register_ui_control(
		story_action_button,
		"story.action_arrow",
		"剧情操作箭头",
		false
	)

	rose_cloth_button = PAPER_CLOTH_BUTTON_SCRIPT.new()
	rose_cloth_button.name = "RoseCleaningCloth"
	rose_cloth_button.tooltip_text = ""
	rose_cloth_button.size = Vector2(86, 86)
	rose_cloth_button.pivot_offset = rose_cloth_button.size * 0.5
	rose_cloth_button.visible = false
	rose_cloth_button.button_down.connect(_begin_rose_cloth_drag)
	root.add_child(rose_cloth_button)
	_register_ui_control(
		rose_cloth_button,
		"story.rose_cloth",
		"玫瑰擦拭布",
		false
	)


func _build_memory_collection_ui(root: Control) -> void:
	memory_fragment_layer = Control.new()
	memory_fragment_layer.name = "MemoryFragmentLayer"
	memory_fragment_layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	memory_fragment_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(memory_fragment_layer)

	memory_backpack = PAPER_BACKPACK_SCRIPT.new()
	memory_backpack.name = "StarMemoryBackpack"
	memory_backpack.position = Vector2(1374.0, 786.0)
	memory_backpack.size = Vector2(194.0, 198.0)
	memory_backpack.set_states(memory_collection_states)
	root.add_child(memory_backpack)
	_register_ui_control(
		memory_backpack,
		"hud.memory_backpack",
		"星光背包",
		false
	)

	memory_backpack_label = _add_label(
		root,
		"星光背包",
		Vector2(1352.0, 756.0),
		Vector2(216.0, 24.0),
		15,
		Color(0.94, 0.82, 0.60, 0.86),
		HORIZONTAL_ALIGNMENT_RIGHT
	)
	_register_ui_control(
		memory_backpack_label,
		"hud.memory_backpack_label",
		"星光背包标题"
	)

	memory_source_aura = MEMORY_SOURCE_AURA_SCRIPT.new()
	memory_source_aura.name = "MemorySourceAura"
	memory_source_aura.size = Vector2(180.0, 140.0)
	memory_source_aura.visible = false
	root.add_child(memory_source_aura)

	memory_star_button = MEMORY_STAR_BUTTON_SCRIPT.new()
	memory_star_button.name = "StarMemory"
	memory_star_button.size = Vector2(68.0, 64.0)
	memory_star_button.pivot_offset = memory_star_button.size * 0.5
	memory_star_button.tooltip_text = "收起这段星光"
	memory_star_button.visible = false
	memory_star_button.pressed.connect(_collect_current_memory)
	root.add_child(memory_star_button)
	_register_ui_control(
		memory_star_button,
		"hud.memory_star",
		"星光收集按钮",
		false
	)


func _hide_generated_planet_roots() -> void:
	for cached_model in generated_planet_models.values():
		var cached_node := cached_model as Node3D
		if cached_node != null:
			cached_node.visible = false


func _touch_generated_planet_cache(slug: String) -> void:
	generated_planet_cache_tick += 1
	generated_planet_last_used[slug] = generated_planet_cache_tick


func _evict_generated_planet_cache(keep_slug: String) -> void:
	while generated_planet_models.size() > MAX_CACHED_GENERATED_PLANETS:
		var eviction_slug := ""
		var oldest_use := INF
		for slug_value in generated_planet_models.keys():
			var slug := String(slug_value)
			if slug == keep_slug:
				continue
			var last_used := float(generated_planet_last_used.get(slug, -1.0))
			if last_used < oldest_use:
				oldest_use = last_used
				eviction_slug = slug
		if eviction_slug.is_empty():
			return
		var evicted_model := generated_planet_models.get(eviction_slug) as Node3D
		if evicted_model != null:
			evicted_model.visible = false
			evicted_model.queue_free()
		generated_planet_models.erase(eviction_slug)
		generated_planet_editable_objects.erase(eviction_slug)
		generated_planet_selected_indices[eviction_slug] = -1
		generated_planet_ready.erase(eviction_slug)
		generated_planet_last_used.erase(eviction_slug)


func _show_pointlighter_3d() -> void:
	if current_3d_scene == "king":
		king_editable_objects = editable_3d_objects
		king_selected_editable_index = selected_editable_index
		king_deleted_editable_ids = deleted_editable_ids
	current_3d_scene = "pointlighter"
	if editor_earth_wheat_controls != null:
		editor_earth_wheat_controls.visible = false
	model_3d = pointlighter_model_3d
	editable_3d_objects = []
	editable_3d_objects.assign(pointlighter_editable_objects)
	deleted_editable_ids = []
	deleted_editable_ids.assign(pointlighter_deleted_editable_ids)
	editable_serial = _highest_editable_serial(editable_3d_objects)
	selected_editable_index = pointlighter_selected_editable_index
	if pointlighter_model_3d != null:
		pointlighter_model_3d.visible = true
	_hide_generated_planet_roots()
	if king_model_3d != null:
		king_model_3d.visible = false
	if king_celestial_root != null:
		king_celestial_root.visible = false
	_apply_pointlighter_environment()
	if hud_scene_kicker != null:
		hud_scene_kicker.text = "第五颗星 | ASTEROID B-612"
		hud_scene_title.text = "点灯人"
		hud_scene_quote.text = "“每分钟点一次灯，因为他不知道还能做什么。”"
		hud_scene_hint.text = ""
	_reapply_star_title_layout("lamplighter")
	main_ui.visible = false
	stage_3d.visible = true
	hud_3d.visible = true
	if king_ritual_subtitle != null:
		king_ritual_subtitle.visible = false
	if king_sun_click_guide != null:
		king_sun_click_guide.visible = false
	if dream_grade_layer != null:
		dream_grade_layer.visible = true
	_reset_3d_view()
	_begin_story_hint_cycle("pointlighter")
	_restore_planet_map_instant(true)


func _show_king_3d() -> void:
	var request_id := planet_loading_generation
	if king_model_3d == null:
		var loaded_ok := await _wait_for_king_assets(request_id)
		if not loaded_ok:
			_finish_planet_loading()
			_restore_planet_map_instant()
			return
		_set_planet_loading_progress(94.0)
	else:
		await _wait_for_simulated_planet_loading(request_id)
	if planet_loading_generation != request_id:
		return
	if current_3d_scene == "pointlighter":
		pointlighter_editable_objects = editable_3d_objects
		pointlighter_selected_editable_index = selected_editable_index
		pointlighter_deleted_editable_ids = deleted_editable_ids
	current_3d_scene = "king"
	if editor_earth_wheat_controls != null:
		editor_earth_wheat_controls.visible = false
	if pointlighter_model_3d != null:
		pointlighter_model_3d.visible = false
	_hide_generated_planet_roots()
	editable_3d_objects = []
	editable_3d_objects.assign(king_editable_objects)
	deleted_editable_ids = []
	deleted_editable_ids.assign(king_deleted_editable_ids)
	editable_serial = _highest_editable_serial(editable_3d_objects)
	selected_editable_index = king_selected_editable_index
	model_3d = king_model_3d
	await _load_king_model()
	if king_model_3d == null:
		_finish_planet_loading()
		return
	_set_planet_loading_progress(98.0)
	king_model_3d.visible = true
	editable_3d_objects = king_editable_objects
	deleted_editable_ids = king_deleted_editable_ids
	model_3d = king_model_3d
	selected_editable_index = king_selected_editable_index
	_apply_king_environment()
	if king_celestial_root != null:
		king_celestial_root.visible = true
		king_celestial_root.basis = _king_celestial_basis(PI)
		king_day_night_blend = 0.0
		king_day_night_target = 0.0
		king_celestial_rotation = PI
		king_celestial_target_rotation = PI
		_apply_king_day_night(0.0)
	if hud_scene_kicker != null:
		hud_scene_kicker.text = "第一颗星 | ASTEROID 325"
		hud_scene_title.text = "国王"
		if king_dialogue_complete:
			hud_scene_quote.text = "“权力不是让世界停下，而是让每一次升落都有人回应。”"
			hud_scene_hint.text = ""
		else:
			hud_scene_quote.text = "“我命令你留下。这样，我的命令便终于有了对象。”"
			hud_scene_hint.text = ""
	_reapply_star_title_layout("king")
	main_ui.visible = false
	stage_3d.visible = true
	hud_3d.visible = true
	_restore_planet_map_instant(true)
	if king_ritual_subtitle != null:
		king_ritual_subtitle.visible = false
	if king_sun_click_guide != null:
		king_sun_click_guide.visible = false
	if dream_grade_layer != null:
		dream_grade_layer.visible = not king_cutout_bright_background
	editor_edit_button.visible = SHOW_LAYOUT_BUTTON
	editor_edit_button.text = "布局"
	_reset_3d_view()
	_begin_story_hint_cycle("king")
	await get_tree().process_frame
	_set_planet_loading_progress(100.0)
	await get_tree().process_frame
	_finish_planet_loading()


func _reset_3d_view() -> void:
	if dialogue_active and story_camera_focus_active:
		return
	_finish_abacus_bead_drag()
	if model_3d != null:
		var preserved_scale := model_3d.scale
		model_3d.quaternion = _get_initial_planet_orientation(
			current_3d_scene
		)
		model_3d.scale = preserved_scale
		_sync_planet_light_rig()
	model_spin_velocity = Vector2.ZERO
	dragging_3d = false
	model_orbit_enabled = false
	_reset_3d_camera()
	_sync_planet_height_control()


func _reset_3d_camera() -> void:
	if camera_3d == null:
		return
	# Every planet uses the same initial composition: the decorated upper
	# hemisphere stays at optical center while the sphere body falls into the
	# lower half of the frame.
	var framing_offset := _get_planet_framing_offset(current_3d_scene)
	camera_focus_point = Vector3(
		0.0,
		PLANET_HOME_FOCUS_Y - framing_offset,
		0.0
	)
	camera_home_position = Vector3(
		0.0,
		PLANET_HOME_CAMERA_HEIGHT - framing_offset,
		PLANET_HOME_DISTANCE
	)
	camera_distance = camera_home_position.distance_to(camera_focus_point)
	camera_3d.position = camera_home_position
	camera_3d.look_at(camera_focus_point)
	_sync_camera_zoom_controls()


func _apply_pointlighter_environment() -> void:
	if stage_environment == null:
		return
	if starfield_root != null:
		starfield_root.visible = true
	if stage_key_light != null:
		stage_key_light.shadow_enabled = true
		stage_key_light.shadow_opacity = 0.54
	if earth_front_light != null:
		earth_front_light.visible = false
		earth_front_light.light_energy = 0.0
	stage_environment.background_color = Color(0.025, 0.053, 0.112)
	stage_environment.ambient_light_color = Color(0.46, 0.56, 0.76)
	stage_environment.fog_light_color = Color(0.075, 0.115, 0.21)
	stage_environment.fog_density = 0.016
	stage_environment.adjustment_contrast = 0.96
	stage_environment.adjustment_saturation = 0.90
	stage_key_light.light_color = Color(0.82, 0.88, 1.0)
	stage_rim_light.light_color = Color(0.48, 0.60, 0.96)
	stage_cool_fill.light_color = Color(0.36, 0.59, 0.86)
	warm_fill_light.light_color = Color(1.0, 0.72, 0.43)
	stage_front_fill.light_color = Color(0.54, 0.66, 0.90)
	_update_main_lamp(0.0)


func _apply_king_environment() -> void:
	if stage_environment == null:
		return
	if starfield_root != null:
		starfield_root.visible = true
	if stage_key_light != null:
		stage_key_light.shadow_enabled = true
		stage_key_light.shadow_opacity = 0.54
	if earth_front_light != null:
		earth_front_light.visible = false
		earth_front_light.light_energy = 0.0
	stage_environment.background_color = Color(0.035, 0.022, 0.061)
	stage_environment.ambient_light_color = Color(0.54, 0.46, 0.66)
	stage_environment.ambient_light_energy = 0.66
	stage_environment.tonemap_exposure = 0.76
	stage_environment.fog_light_color = Color(0.12, 0.065, 0.14)
	stage_environment.fog_light_energy = 0.44
	stage_environment.fog_density = 0.013
	stage_environment.adjustment_brightness = 0.89
	stage_environment.adjustment_contrast = 0.99
	stage_environment.adjustment_saturation = 0.84
	if king_cutout_bright_background:
		stage_environment.background_color = Color(0.20, 0.26, 0.38)
		stage_environment.background_energy_multiplier = 1.25
		stage_environment.fog_light_color = Color(0.30, 0.37, 0.50)
		stage_environment.fog_light_energy = 0.72
		stage_environment.fog_density = 0.003
	stage_key_light.light_color = Color(0.96, 0.79, 0.66)
	stage_key_light.light_energy = 0.58
	stage_rim_light.light_color = Color(0.46, 0.34, 0.82)
	stage_rim_light.light_energy = 0.43
	stage_cool_fill.light_color = Color(0.38, 0.36, 0.72)
	stage_cool_fill.light_energy = 0.20
	warm_fill_light.light_color = Color(1.0, 0.61, 0.29)
	warm_fill_light.light_energy = 0.32
	stage_front_fill.light_color = Color(0.62, 0.51, 0.76)
	stage_front_fill.light_energy = 0.23
	_apply_planet_base_lighting_multiplier()


func _exit_3d(restore_map := true) -> void:
	if stage_3d == null:
		return
	AudioDirector.set_dialogue_duck(false)
	AudioDirector.play_music("main")
	_finish_abacus_bead_drag()
	_reset_star_lamp_swings()
	king_ritual_active = false
	king_ritual_phase = ""
	king_ritual_generation += 1
	king_ritual_sun_was_pressed = false
	if king_ritual_subtitle != null:
		king_ritual_subtitle.visible = false
	if king_sun_click_guide != null:
		king_sun_click_guide.visible = false
	_cancel_player_movement_onboarding()
	_stop_earth_fox_dialogue_idle_cycle()
	earth_fox_search_generation += 1
	earth_fox_search_active = false
	earth_fox_search_running = false
	earth_fox_exit_generation += 1
	earth_fox_exit_running = false
	_clear_memory_collection_ui()
	_clear_story_hint_cycle()
	_set_player_dialogue_bubble_mode(false)
	_restore_player_prince_dialogue_staging()
	_restore_dialogue_camera(true)
	_clear_story_action_ui()
	_close_player_avatar_picker_overlay()
	if player_onboarding_triggered and not player_onboarding_completed:
		player_onboarding_completed = true
		player_onboarding_step = -1
	_hide_player_onboarding_guide()
	if current_3d_scene == "rose":
		_end_rose_dialogue_animation()
	_close_player_character_interaction()
	player_prince_look_generation += 1
	player_prince_look_active = false
	_close_player_prince_interaction()
	_capture_current_editable_state()
	if dialogue_active:
		if dialogue_text_edit_active:
			_set_dialogue_text_edit_mode(false)
		dialogue_active = false
		dialogue_busy = false
		dialogue_generation += 1
		dialogue_scene = ""
		if dialogue_panel != null:
			dialogue_panel.visible = false
	if chair_dragging:
		chair_dragging = false
		chair_state = "floating"
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if editor_active:
		_toggle_3d_editor()
	ui_clean_mode_active = false
	stage_3d.visible = false
	if hud_3d != null:
		hud_3d.visible = false
	if dream_grade_layer != null:
		dream_grade_layer.visible = false
	if main_ui != null:
		main_ui.visible = true
	if restore_map and map_screen != null:
		cover.visible = false
		map_screen.visible = true
		_restore_planet_map_instant()
		_show_map_prince_layer()
		if _all_memories_collected():
			if journey_finale_played or player_planet_revealed:
				_refresh_journey_constellation(true)
				call_deferred("_reveal_player_planet_on_map")
			else:
				_apply_player_planet_map_reveal(false)
				_refresh_journey_constellation(false)
				call_deferred("_play_final_journey_sequence")
		else:
			_refresh_journey_constellation(true)
			_apply_player_planet_map_reveal(false)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var screenshot_key := event as InputEventKey
		if (
			screenshot_key.pressed
			and not screenshot_key.echo
			and (
				screenshot_key.keycode == KEY_F10
				or screenshot_key.physical_keycode == KEY_F10
			)
		):
			_toggle_ui_clean_mode()
			get_viewport().set_input_as_handled()
			return
		if (
			screenshot_key.pressed
			and not screenshot_key.echo
			and (
				screenshot_key.keycode == KEY_F12
				or screenshot_key.physical_keycode == KEY_F12
			)
		):
			_capture_viewport_screenshot()
			get_viewport().set_input_as_handled()
			return
	if stage_3d == null or not stage_3d.visible:
		return
	if player_avatar_picker_open:
		return
	if (
		current_3d_scene == "player"
		and player_place_dock != null
		and player_place_dock.visible
		and player_3d_drag_preview == null
		and event is InputEventMouseButton
	):
		var shelf_click := event as InputEventMouseButton
		if (
			shelf_click.button_index == MOUSE_BUTTON_LEFT
			and shelf_click.pressed
		):
			for card_value in player_asset_cards:
				var card := card_value as Control
				if card == null or not is_instance_valid(card):
					continue
				if card.get_global_rect().has_point(shelf_click.position):
					var asset_index := int(card.get("asset_index"))
					_on_player_asset_drag_started(
						asset_index,
						shelf_click.position
					)
					get_viewport().set_input_as_handled()
					return
	if (
		player_3d_drag_preview != null
		and player_3d_drag_preview_asset_index >= 0
	):
		if event is InputEventMouseMotion:
			var player_motion := event as InputEventMouseMotion
			_on_player_asset_drag_moved(
				player_3d_drag_preview_asset_index,
				player_motion.position
			)
			get_viewport().set_input_as_handled()
			return
		if (
			event is InputEventMouseButton
			and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
			and not (event as InputEventMouseButton).pressed
		):
			_on_player_asset_drag_ended(
				player_3d_drag_preview_asset_index,
				(event as InputEventMouseButton).position
			)
			get_viewport().set_input_as_handled()
			return
	if dialogue_active and event is InputEventKey:
		var dialogue_key := event as InputEventKey
		if dialogue_key.pressed and dialogue_key.keycode == KEY_ESCAPE:
			if dialogue_text_edit_active:
				_set_dialogue_text_edit_mode(false)
			else:
				_close_active_dialogue()
			get_viewport().set_input_as_handled()
			return
	if (
		current_3d_scene == "rose"
		and story_action_phase == "rose_cloth"
		and story_wipe_dragging
	):
		if event is InputEventMouseMotion:
			var motion := event as InputEventMouseMotion
			rose_cloth_button.position = (
				motion.position - rose_cloth_button.size * 0.5
			)
			if _story_node_at_screen(
				story_action_target,
				motion.position
			):
				_apply_rose_wipe_fog(
					story_wipe_progress + motion.relative.length() / 540.0
				)
				if story_wipe_progress < 0.999:
					_set_story_hint("按住布料，沿罩面来回擦动")
				else:
					_finish_rose_wipe()
			get_viewport().set_input_as_handled()
			return
		if event is InputEventMouseButton:
			var release := event as InputEventMouseButton
			if (
				release.button_index == MOUSE_BUTTON_LEFT
				and not release.pressed
			):
				story_wipe_dragging = false
				rose_cloth_button.set_grabbed(false)
				_set_story_hint("继续按住布料，沿罩面来回擦动")
				get_viewport().set_input_as_handled()
				return
	if not chair_dragging:
		return
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		chair_drag_distance += motion.relative.length()
		_update_chair_drag(motion.position)
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if mouse_button.button_index == MOUSE_BUTTON_LEFT and not mouse_button.pressed:
			_update_chair_drag(mouse_button.position)
			_finish_chair_drag()
			get_viewport().set_input_as_handled()


func _capture_viewport_screenshot() -> void:
	if not DirAccess.dir_exists_absolute(SCREENSHOT_SAVE_DIRECTORY):
		var directory_error := DirAccess.make_dir_recursive_absolute(
			SCREENSHOT_SAVE_DIRECTORY
		)
		if directory_error != OK:
			push_error(
				"无法创建截图目录：%s（错误码 %d）"
				% [SCREENSHOT_SAVE_DIRECTORY, directory_error]
			)
			return

	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		push_error("无法获取游戏视口截图：视口纹理不可用")
		return
	var image := viewport_texture.get_image()
	if image == null or image.is_empty():
		push_error("无法获取游戏视口截图：视口图像为空")
		return

	var now := Time.get_datetime_dict_from_system()
	var milliseconds := Time.get_ticks_msec() % 1000
	var file_stem := "小王子截图_%04d%02d%02d_%02d%02d%02d_%03d" % [
		now.year,
		now.month,
		now.day,
		now.hour,
		now.minute,
		now.second,
		milliseconds,
	]
	var file_path := SCREENSHOT_SAVE_DIRECTORY.path_join(file_stem + ".png")
	var duplicate_index := 2
	while FileAccess.file_exists(file_path):
		file_path = SCREENSHOT_SAVE_DIRECTORY.path_join(
			"%s_%d.png" % [file_stem, duplicate_index]
		)
		duplicate_index += 1

	var save_error := image.save_png(file_path)
	if save_error != OK:
		push_error(
			"保存截图失败：%s（错误码 %d）" % [file_path, save_error]
		)
		return
	print("SCREENSHOT_SAVED path=", file_path)


func _toggle_ui_clean_mode() -> void:
	var in_3d_scene := stage_3d != null and stage_3d.visible
	if in_3d_scene:
		_restore_map_ui_clean_mode()
		ui_clean_mode_active = not ui_clean_mode_active
		if hud_3d != null:
			hud_3d.visible = not ui_clean_mode_active
		return
	if (
		map_screen != null
		and map_screen.visible
		and not transition_running
		and not planet_zoom_active
	):
		if ui_clean_mode_active:
			_restore_map_ui_clean_mode()
		else:
			_hide_map_ui_clean_mode()


func _hide_map_ui_clean_mode() -> void:
	ui_clean_mode_restore_states.clear()
	ui_clean_mode_planet_states.clear()
	for node in _map_clean_mode_ui_nodes():
		ui_clean_mode_restore_states.append({
			"node": node,
			"visible": node.visible,
		})
		node.visible = false
	for record_value in planet_records.values():
		var record: Dictionary = record_value
		var button := record.get("button") as Control
		var focus_ring := record.get("focus_ring") as Control
		if button != null:
			ui_clean_mode_planet_states.append({
				"button": button,
				"mouse_filter": button.mouse_filter,
				"tooltip_text": button.tooltip_text,
				"focus_ring": focus_ring,
				"focus_visible": focus_ring.visible if focus_ring != null else false,
				"focus_alpha": focus_ring.modulate.a if focus_ring != null else 0.0,
			})
			button.mouse_filter = Control.MOUSE_FILTER_IGNORE
			button.tooltip_text = ""
		if focus_ring != null:
			focus_ring.visible = false
			focus_ring.modulate.a = 0.0
	ui_clean_mode_active = true


func _restore_map_ui_clean_mode() -> void:
	for restore_state in ui_clean_mode_restore_states:
		var node := restore_state.get("node") as Control
		if node == null or not is_instance_valid(node):
			continue
		node.visible = bool(restore_state.get("visible", true))
	for planet_state in ui_clean_mode_planet_states:
		var button := planet_state.get("button") as Control
		if button != null and is_instance_valid(button):
			button.mouse_filter = int(planet_state.get("mouse_filter", Control.MOUSE_FILTER_STOP))
			button.tooltip_text = String(planet_state.get("tooltip_text", ""))
		var focus_ring := planet_state.get("focus_ring") as Control
		if focus_ring != null and is_instance_valid(focus_ring):
			focus_ring.visible = bool(planet_state.get("focus_visible", false))
			focus_ring.modulate.a = float(planet_state.get("focus_alpha", 0.0))
	ui_clean_mode_restore_states.clear()
	ui_clean_mode_planet_states.clear()
	ui_clean_mode_active = false


func _map_clean_mode_ui_nodes() -> Array[Control]:
	var nodes: Array[Control] = []
	for node in [
		map_scene_label,
		map_hint,
		map_back_button,
		map_skip_button,
		map_onboarding_overlay,
		map_loading_overlay,
	]:
		if node != null:
			nodes.append(node)
	for record_value in planet_records.values():
		var record: Dictionary = record_value
		for key in ["label", "tag_frame"]:
			var node := record.get(key) as Control
			if node != null:
				nodes.append(node)
	return nodes


func _on_window_focus_exited() -> void:
	_reset_pointer_interactions()


func _recover_stalled_pointer_interactions() -> void:
	var left_pressed := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	var right_pressed := Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	var middle_pressed := Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE)
	if chair_dragging and not left_pressed:
		_cancel_chair_drag()
	if story_wipe_dragging and not left_pressed:
		story_wipe_dragging = false
		if rose_cloth_button != null:
			rose_cloth_button.set_grabbed(false)
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if dragging_3d and not (left_pressed or right_pressed or middle_pressed):
		dragging_3d = false
		editor_dragging_object = false
		editor_drag_travel = 0.0
		model_orbit_enabled = false
		model_drag_distance = 0.0
		lamp_was_pressed = false
		king_light_was_pressed = -1
		king_celestial_was_pressed = false
		king_ritual_sun_was_pressed = false
		player_day_night_beacon_was_pressed = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _cancel_chair_drag() -> void:
	if not chair_dragging:
		return
	chair_dragging = false
	if chair_state == "dragging":
		chair_state = "floating"
		if chair_3d != null:
			chair_3d.transform = chair_float_transform
			chair_3d.scale = chair_target_scale
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _reset_pointer_interactions() -> void:
	_cancel_chair_drag()
	if abacus_bead_dragging:
		_finish_abacus_bead_drag()
	dragging_3d = false
	editor_dragging_object = false
	editor_drag_travel = 0.0
	player_placement_object_dragging = false
	player_placement_object_drag_moved = false
	if player_3d_drag_preview != null:
		player_3d_drag_preview.queue_free()
		player_3d_drag_preview = null
	player_3d_drag_preview_asset_index = -1
	player_dragged_asset_index = -1
	player_drag_last_screen_position = Vector2.ZERO
	model_orbit_enabled = false
	model_drag_distance = 0.0
	lamp_was_pressed = false
	king_light_was_pressed = -1
	king_celestial_was_pressed = false
	king_ritual_sun_was_pressed = false
	player_day_night_beacon_was_pressed = false
	player_day_night_beacon_hovered = false
	if player_day_night_beacon_ripple != null:
		player_day_night_beacon_ripple.call(
			"set_feedback",
			false,
			player_day_night_beacon_color
		)
	story_wipe_dragging = false
	if rose_cloth_button != null:
		rose_cloth_button.set_grabbed(false)
	hovered_feedback_index = -1
	merchant_hover_pointer_valid = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _unhandled_input(event: InputEvent) -> void:
	if stage_3d != null and stage_3d.visible:
		if player_avatar_picker_open:
			return
		if dialogue_active:
			if event is InputEventKey:
				var dialogue_key := event as InputEventKey
				if dialogue_key.pressed and dialogue_key.keycode == KEY_ESCAPE:
					if dialogue_text_edit_active:
						_set_dialogue_text_edit_mode(false)
					else:
						_close_active_dialogue()
					get_viewport().set_input_as_handled()
					return
				return
		if _handle_story_pointer_event(event):
			get_viewport().set_input_as_handled()
			return
		if _handle_player_light_string_pointer_event(event):
			get_viewport().set_input_as_handled()
			return
		if _handle_player_placement_pointer_event(event):
			get_viewport().set_input_as_handled()
			return
		if event is InputEventMouseButton:
			var mouse_button := event as InputEventMouseButton
			var stage_pointer_position := mouse_button.position
			if mouse_button.button_index in [MOUSE_BUTTON_RIGHT, MOUSE_BUTTON_MIDDLE]:
				if dialogue_active:
					dragging_3d = false
					model_orbit_enabled = false
					model_spin_velocity = Vector2.ZERO
					return
				if mouse_button.pressed and abacus_bead_dragging:
					_finish_abacus_bead_drag()
				dragging_3d = mouse_button.pressed
				model_drag_distance = 0.0
				model_orbit_enabled = false
				if mouse_button.pressed:
					model_spin_velocity = Vector2.ZERO
					Input.set_default_cursor_shape(Input.CURSOR_DRAG)
				else:
					Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			elif (
				mouse_button.pressed
				and mouse_button.double_click
				and mouse_button.button_index == MOUSE_BUTTON_LEFT
			):
				if not dialogue_active and model_3d != null:
					_reset_3d_view()
			elif mouse_button.button_index == MOUSE_BUTTON_LEFT:
				if editor_active:
					if mouse_button.pressed:
						editor_dragging_object = _start_editor_object_drag(
							stage_pointer_position
						)
						dragging_3d = not editor_dragging_object
					else:
						editor_dragging_object = false
						dragging_3d = false
						model_orbit_enabled = false
				else:
					if mouse_button.pressed:
						var bead_index := _pick_abacus_bead_at_screen(
							stage_pointer_position
						)
						if bead_index >= 0:
							abacus_bead_hover_index = bead_index
							if not abacus_bead_dragging:
								_begin_abacus_bead_drag(bead_index)
							dragging_3d = false
							model_orbit_enabled = false
						else:
							dragging_3d = not dialogue_active
							model_drag_distance = 0.0
							model_orbit_enabled = false
							lamp_was_pressed = _is_main_lamp_at_screen(
								stage_pointer_position
							)
							king_light_was_pressed = _king_light_at_screen(
								stage_pointer_position
							)
							var ritual_waiting := (
								king_ritual_active
								and king_ritual_phase in ["sunrise", "sunset"]
							)
							king_ritual_sun_was_pressed = (
								ritual_waiting
								and _is_king_sun_at_screen(stage_pointer_position)
							)
							king_celestial_was_pressed = (
								not king_ritual_active
								and _is_king_celestial_at_screen(
									stage_pointer_position
								)
							)
							player_day_night_beacon_was_pressed = (
								current_3d_scene == "player"
								and _is_player_day_night_beacon_at_screen(
									stage_pointer_position
								)
							)
							player_day_night_beacon_hovered = (
								player_day_night_beacon_was_pressed
							)
							if player_day_night_beacon_ripple != null:
								player_day_night_beacon_ripple.call(
									"set_feedback",
									player_day_night_beacon_hovered,
									player_day_night_beacon_color
								)
							if (
								lamp_was_pressed
								or king_light_was_pressed >= 0
								or king_ritual_sun_was_pressed
								or player_day_night_beacon_was_pressed
							):
								model_spin_velocity = Vector2.ZERO
							if player_day_night_beacon_was_pressed:
								dragging_3d = false
					else:
						if abacus_bead_dragging or abacus_bead_hover_index >= 0:
							dragging_3d = false
							get_viewport().set_input_as_handled()
							return
						var toggle_lamp := lamp_was_pressed and model_drag_distance < 4.5
						var toggle_king_light := (
							king_light_was_pressed >= 0
							and model_drag_distance < 4.5
						)
						var toggle_celestial := (
							king_celestial_was_pressed
							and model_drag_distance < 4.5
						)
						var advance_king_ritual := (
							king_ritual_sun_was_pressed
							and model_drag_distance < 4.5
						)
						var toggle_player_day_night := (
							player_day_night_beacon_was_pressed
							and model_drag_distance < 4.5
						)
						dragging_3d = false
						model_orbit_enabled = false
						lamp_was_pressed = false
						king_ritual_sun_was_pressed = false
						player_day_night_beacon_was_pressed = false
						var pressed_king_light := king_light_was_pressed
						king_light_was_pressed = -1
						king_celestial_was_pressed = false
						if toggle_player_day_night:
							_toggle_player_day_night()
							get_viewport().set_input_as_handled()
							return
						if (
							current_3d_scene == "player"
							and not player_navigation_active
							and model_drag_distance < 4.5
							and _try_start_player_navigation_at_screen(
								stage_pointer_position
							)
						):
							get_viewport().set_input_as_handled()
							return
						if advance_king_ritual:
							_advance_king_ritual()
						elif toggle_king_light:
							_toggle_king_light(pressed_king_light)
						elif toggle_lamp:
							_toggle_main_lamp()
						elif toggle_celestial:
							_toggle_king_day_night()
			elif (
				not dialogue_active
				and mouse_button.pressed
				and mouse_button.button_index == MOUSE_BUTTON_WHEEL_UP
			):
				model_spin_velocity = Vector2.ZERO
				_set_3d_camera_distance(camera_distance - 0.65)
			elif (
				not dialogue_active
				and mouse_button.pressed
				and mouse_button.button_index == MOUSE_BUTTON_WHEEL_DOWN
			):
				model_spin_velocity = Vector2.ZERO
				_set_3d_camera_distance(camera_distance + 0.65)
		elif event is InputEventMouseMotion and editor_active and editor_dragging_object:
			var motion := event as InputEventMouseMotion
			var stage_delta := motion.relative
			editor_drag_travel += stage_delta.length()
			if editor_drag_travel > 2.0:
				_move_selected_editable_to_pointer(motion.position)
		elif event is InputEventMouseMotion and dragging_3d and model_3d != null:
			var motion := event as InputEventMouseMotion
			var stage_delta := motion.relative
			model_drag_distance += stage_delta.length()
			if model_drag_distance < 6.0:
				return
			if not model_orbit_enabled:
				model_orbit_enabled = true
				model_spin_velocity = Vector2.ZERO
				return
			var rotation_delta := stage_delta * 0.006
			_apply_model_orbit_delta(rotation_delta)
			model_spin_velocity = rotation_delta
		elif (
			event is InputEventMouseMotion
			and current_3d_scene == "player"
			and not editor_active
			and not dragging_3d
		):
			var motion := event as InputEventMouseMotion
			player_day_night_beacon_hovered = (
				_is_player_day_night_beacon_at_screen(motion.position)
			)
			if player_day_night_beacon_ripple != null:
				player_day_night_beacon_ripple.call(
					"set_feedback",
					player_day_night_beacon_hovered,
					player_day_night_beacon_color
				)
			Input.set_default_cursor_shape(
				Input.CURSOR_POINTING_HAND
				if player_day_night_beacon_hovered
				else Input.CURSOR_ARROW
			)
		elif (
			event is InputEventMouseMotion
			and current_3d_scene == "king"
			and not editor_active
			and not dragging_3d
		):
			var motion := event as InputEventMouseMotion
			var stage_pointer_position := motion.position
			var celestial_hovered := (
				not king_ritual_active
				and _is_king_celestial_at_screen(stage_pointer_position)
			)
			var king_light_hovered := _king_light_at_screen(
				stage_pointer_position
			) >= 0
			var ritual_sun_hovered := (
				king_ritual_active
				and king_ritual_phase in ["sunrise", "sunset"]
				and _is_king_sun_at_screen(stage_pointer_position)
			)
			Input.set_default_cursor_shape(
				Input.CURSOR_POINTING_HAND
				if celestial_hovered or king_light_hovered or ritual_sun_hovered
				else Input.CURSOR_ARROW
			)
		elif (
			event is InputEventMouseMotion
			and current_3d_scene in ["pointlighter", "rose", "merchant"]
			and not editor_active
			and not dragging_3d
		):
			var motion := event as InputEventMouseMotion
			var stage_pointer_position := motion.position
			var picked_index := _pick_prop_feedback_target(
				stage_pointer_position
			)
			if picked_index != hovered_feedback_index:
				hovered_feedback_index = picked_index
				if picked_index >= 0:
					_start_prop_wobble(picked_index, stage_pointer_position)
			Input.set_default_cursor_shape(
				Input.CURSOR_POINTING_HAND if picked_index >= 0 else Input.CURSOR_ARROW
			)
		elif event is InputEventKey:
			var key := event as InputEventKey
			if editor_active and key.pressed and key.keycode == KEY_DELETE:
				_delete_selected_3d_object()
				get_viewport().set_input_as_handled()
			elif key.pressed and key.keycode == KEY_ESCAPE:
				if editor_active:
					_toggle_3d_editor()
				else:
					_exit_3d()
				get_viewport().set_input_as_handled()
		return

	if event is InputEventKey:
		var key := event as InputEventKey
		if key.pressed and not key.echo and key.keycode == KEY_ESCAPE:
			if planet_zoom_active:
				_exit_planet_detail()
				get_viewport().set_input_as_handled()
			elif map_screen.visible and not transition_running:
				_return_to_cover()
				get_viewport().set_input_as_handled()


func _load_awake_state() -> void:
	var config := ConfigFile.new()
	if config.load("user://stellarmap.cfg") != OK:
		return
	for data in PLANETS:
		awake_planets[String(data.name)] = bool(config.get_value("planets", String(data.name), false))


func _load_onboarding_state() -> void:
	map_onboarding_triggered = false
	map_onboarding_completed = false
	player_onboarding_triggered = false
	player_onboarding_completed = false
	player_avatar_selected = false
	player_move_guide_completed = false
	player_day_night_guide_completed = false
	player_onboarding_step = -1
	var config := ConfigFile.new()
	if config.load(ONBOARDING_STATE_PATH) == OK:
		map_onboarding_triggered = bool(
			config.get_value("onboarding", "map_triggered", false)
		)
		player_onboarding_triggered = bool(
			config.get_value("onboarding", "player_triggered", false)
		)
		player_avatar_selected = bool(config.get_value(
			"onboarding",
			"player_avatar_selected",
			player_onboarding_triggered
		))
		player_move_guide_completed = bool(config.get_value(
			"onboarding",
			"player_move_guide_completed",
			player_onboarding_triggered
		))
		player_day_night_guide_completed = bool(config.get_value(
			"onboarding",
			"player_day_night_guide_completed",
			player_onboarding_triggered
		))
	elif SaveManager != null and SaveManager.active_slot_has_save():
		# Existing pre-migration saves have already had the guides available.
		# Suppress them once instead of showing both guides again after an update.
		map_onboarding_triggered = true
		player_onboarding_triggered = true
		player_avatar_selected = true
		player_move_guide_completed = true
		player_day_night_guide_completed = true
	map_onboarding_completed = map_onboarding_triggered
	player_onboarding_completed = player_onboarding_triggered


func _save_onboarding_state(request_autosave := true) -> void:
	if preview_mode_active:
		return
	var config := ConfigFile.new()
	config.set_value(
		"onboarding",
		"map_triggered",
		map_onboarding_triggered
	)
	config.set_value(
		"onboarding",
		"player_triggered",
		player_onboarding_triggered
	)
	config.set_value(
		"onboarding",
		"player_avatar_selected",
		player_avatar_selected
	)
	config.set_value(
		"onboarding",
		"player_move_guide_completed",
		player_move_guide_completed
	)
	config.set_value(
		"onboarding",
		"player_day_night_guide_completed",
		player_day_night_guide_completed
	)
	if config.save(ONBOARDING_STATE_PATH) == OK:
		if request_autosave:
			_request_autosave()


func _mark_map_onboarding_triggered() -> void:
	if map_onboarding_triggered:
		return
	map_onboarding_triggered = true
	_save_onboarding_state()


func _mark_player_onboarding_triggered() -> void:
	if player_onboarding_triggered:
		return
	player_onboarding_triggered = true
	_save_onboarding_state()


func _save_awake_state() -> void:
	var config := ConfigFile.new()
	for data in PLANETS:
		var name := String(data.name)
		config.set_value("planets", name, bool(awake_planets.get(name, false)))
	if config.save("user://stellarmap.cfg") == OK:
		_request_autosave()


func _load_planet_story_state() -> void:
	for slug in STORY_SCENE_SLUGS:
		planet_story_states[slug] = "new"
	var config := ConfigFile.new()
	if config.load(PLANET_STORY_STATE_PATH) != OK:
		return
	for slug in STORY_SCENE_SLUGS:
		var state := String(config.get_value("story", slug, "new"))
		if state not in ["new", "fox_found", "dialogue_done", "complete"]:
			state = "new"
		planet_story_states[slug] = state


func _save_planet_story_state() -> void:
	if preview_mode_active:
		return
	var config := ConfigFile.new()
	for slug in STORY_SCENE_SLUGS:
		config.set_value("story", slug, String(planet_story_states.get(slug, "new")))
	if config.save(PLANET_STORY_STATE_PATH) == OK:
		_request_autosave()


func _load_memory_state() -> void:
	memory_collection_states.clear()
	for slug in MEMORY_ORDER:
		memory_collection_states[slug] = "locked"
	var config := ConfigFile.new()
	if config.load(STAR_MEMORY_STATE_PATH) == OK:
		for slug in MEMORY_ORDER:
			var stored := String(config.get_value("memories", slug, "locked"))
			memory_collection_states[slug] = (
				stored if stored in ["locked", "available", "collected"] else "locked"
			)


func _load_journey_state() -> void:
	journey_slugs.clear()
	journey_legacy_reconstructed = false
	journey_finale_played = false
	journey_finale_sequence_active = false
	var config := ConfigFile.new()
	var loaded_config := config.load(JOURNEY_STATE_PATH) == OK
	if loaded_config:
		var stored_route = config.get_value(
			"journey",
			"route",
			PackedStringArray()
		)
		if stored_route is Array or stored_route is PackedStringArray:
			for value in stored_route:
				var slug := String(value)
				if (
					slug in MEMORY_ORDER
					and slug not in journey_slugs
					and String(memory_collection_states.get(slug, "locked")) == "collected"
				):
					journey_slugs.append(slug)
		journey_legacy_reconstructed = bool(
			config.get_value("journey", "legacy_reconstructed", false)
		)
	if journey_slugs.is_empty():
		# Older saves did not store visit order. Preserve a visible route by
		# reconstructing only the stars they had actually completed.
		for slug in MEMORY_ORDER:
			if String(memory_collection_states.get(slug, "locked")) == "collected":
				journey_slugs.append(String(slug))
		journey_legacy_reconstructed = not journey_slugs.is_empty()
	if loaded_config and config.has_section_key("journey", "finale_played"):
		journey_finale_played = bool(
			config.get_value("journey", "finale_played", false)
		)
	else:
		# Existing completed saves should see the new finale sequence once.
		journey_finale_played = false


func _save_journey_state() -> void:
	if preview_mode_active:
		return
	var config := ConfigFile.new()
	config.set_value(
		"journey",
		"route",
		PackedStringArray(journey_slugs)
	)
	config.set_value(
		"journey",
		"legacy_reconstructed",
		journey_legacy_reconstructed
	)
	config.set_value(
		"journey",
		"finale_played",
		journey_finale_played
	)
	if config.save(JOURNEY_STATE_PATH) == OK:
		_request_autosave()


func _record_journey_stop(slug: String) -> void:
	if (
		slug not in MEMORY_ORDER
		or slug in journey_slugs
		or String(memory_collection_states.get(slug, "locked")) != "collected"
	):
		return
	journey_slugs.append(slug)
	_save_journey_state()


func _refresh_journey_constellation(animate_new_segment := false) -> void:
	if map_route_layer == null:
		return
	var stops: Array[Dictionary] = []
	for slug_value in journey_slugs:
		var slug := String(slug_value)
		if String(memory_collection_states.get(slug, "locked")) != "collected":
			continue
		var stop := _journey_stop_for_slug(slug)
		if not stop.is_empty():
			stops.append(stop)
	var completed_all := _all_memories_collected()
	if completed_all:
		var player_stop := _journey_stop_for_slug("player")
		if not player_stop.is_empty():
			stops.append(player_stop)
	map_route_layer.call("set_route", stops, animate_new_segment)
	_update_journey_map_label(stops.size(), completed_all)


func _journey_stop_for_slug(slug: String) -> Dictionary:
	var planet_slug := slug
	if slug == "earth":
		planet_slug = "fox"
	elif slug == "pointlighter":
		planet_slug = "lamplighter"
	for data_value in PLANETS:
		var data: Dictionary = data_value
		if String(data.get("slug", "")) != planet_slug:
			continue
		var color := Color(0.97, 0.80, 0.44)
		if slug == "player":
			color = Color(0.98, 0.78, 0.38)
		elif MEMORY_DEFINITIONS.has(slug):
			color = MEMORY_DEFINITIONS[slug].accent
		return {
			"slug": slug,
			"center": data.get("center", Vector2.ZERO),
			"radius": float(data.get("radius", 60.0)),
			"color": color,
		}
	return {}


func _journey_slug_for_planet_name(name: String) -> String:
	for data_value in PLANETS:
		var data: Dictionary = data_value
		if String(data.get("name", "")) != name:
			continue
		var slug := String(data.get("slug", ""))
		if slug == "fox":
			return "earth"
		if slug == "lamplighter":
			return "pointlighter"
		return slug
	return ""


func _update_journey_map_label(stop_count: int, completed_all: bool) -> void:
	if map_scene_label == null:
		return
	if completed_all and stop_count >= MEMORY_ORDER.size() + 1:
		map_scene_label.text = "星　图 | 星光已连成归途"
		map_scene_label.add_theme_color_override(
			"font_color",
			Color(0.93, 0.88, 0.76, 0.68)
		)
	elif stop_count >= 2:
		map_scene_label.text = "星　图 | 你走过的路"
		map_scene_label.add_theme_color_override(
			"font_color",
			Color(0.90, 0.86, 0.76, 0.56)
		)
	else:
		map_scene_label.text = "星　图"
		map_scene_label.add_theme_color_override(
			"font_color",
			Color(0.90, 0.88, 0.80, 0.36)
		)


func _save_memory_state() -> void:
	if preview_mode_active:
		return
	var config := ConfigFile.new()
	for slug in MEMORY_ORDER:
		config.set_value(
			"memories",
			slug,
			String(memory_collection_states.get(slug, "locked"))
		)
	if config.save(STAR_MEMORY_STATE_PATH) == OK:
		_request_autosave()


func _request_autosave() -> void:
	if preview_mode_active or SaveManager == null:
		return
	SaveManager.auto_save(_build_save_summary())
	_refresh_cover_session_controls()


func _build_save_summary() -> Dictionary:
	var awake_count := 0
	for data in PLANETS:
		if String(data.slug) == "player":
			continue
		if bool(awake_planets.get(String(data.name), false)):
			awake_count += 1
	var memory_count := 0
	for slug in MEMORY_ORDER:
		if String(memory_collection_states.get(slug, "locked")) == "collected":
			memory_count += 1
	var completed_story_count := 0
	for slug in STORY_SCENE_SLUGS:
		if String(planet_story_states.get(slug, "new")) == "complete":
			completed_story_count += 1
	var chapter := "星图探索"
	if memory_count == MEMORY_ORDER.size():
		chapter = "第七星已显现"
	elif awake_count == 0:
		chapter = "星图启程"
	elif completed_story_count == STORY_SCENE_SLUGS.size():
		chapter = "星光已归位"
	return {
		"awake_count": awake_count,
		"memory_count": memory_count,
		"completed_story_count": completed_story_count,
		"chapter": chapter,
	}


func _mark_memory_available(slug: String, reveal_delay := 1.0) -> void:
	if slug not in MEMORY_ORDER:
		return
	if String(memory_collection_states.get(slug, "locked")) == "collected":
		return
	memory_collection_states[slug] = "available"
	memory_reveal_after[slug] = (
		Time.get_ticks_msec() + roundi(maxf(reveal_delay, 0.0) * 1000.0)
	)
	_save_memory_state()


func _memory_is_available(slug: String) -> bool:
	if String(memory_collection_states.get(slug, "locked")) == "collected":
		return false
	return String(memory_collection_states.get(slug, "locked")) == "available"


func _apply_preview_mode() -> void:
	var preview_mode := ""
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--preview="):
			preview_mode = argument.trim_prefix("--preview=")
	if preview_mode == "":
		return
	preview_mode_active = true
	await get_tree().process_frame
	match preview_mode:
		"map":
			cover.visible = false
			map_screen.visible = true
		"map_ui_edit":
			cover.visible = false
			map_screen.visible = true
			await get_tree().process_frame
			ui_layout_editor.set_edit_active(true)
		"map_focus":
			cover.visible = false
			map_screen.visible = true
			_set_planet_hover("玫瑰", true)
		"detail":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("玫瑰")
		"detail_ui":
			cover.visible = false
			map_screen.visible = true
			detail_name.text = "星球 | B-612 | 玫瑰"
			detail_text.text = "一朵玫瑰，把整颗星球变成了家。"
			detail_screen.visible = true
		"pointlighter":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
		"king":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("国王")
		"hud_ui_edit":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("玫瑰")
			while not stage_3d.visible or current_3d_scene != "rose":
				await get_tree().create_timer(0.2).timeout
			await get_tree().process_frame
			ui_layout_editor.set_edit_active(true)
		"rose":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("玫瑰")
		"vain":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("爱慕虚荣的人")
		"merchant":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("商人")
		"earth":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("狐狸与麦田")
		"player_planet":
			for slug in MEMORY_ORDER:
				memory_collection_states[slug] = "collected"
			cover.visible = false
			map_screen.visible = true
			_reveal_player_planet_on_map()
			_on_planet_pressed(PLAYER_PLANET_NAME)
		"player_map":
			for slug in MEMORY_ORDER:
				memory_collection_states[slug] = "collected"
			cover.visible = false
			map_screen.visible = true
			passage.visible = true
			passage.mouse_filter = Control.MOUSE_FILTER_IGNORE
			passage_page.visible = false
			passage_edge.modulate.a = 0.68
			passage_glow.modulate.a = 0.0
			passage_prince_above.modulate.a = 0.0
			_layout_passage_prince()
			_set_passage_prince_base(passage_prince_below)
			passage_prince_below.modulate.a = 1.0
			_reveal_player_planet_on_map()
		"player_skip":
			cover.visible = false
			map_screen.visible = true
			passage.visible = true
			passage.mouse_filter = Control.MOUSE_FILTER_IGNORE
			passage_page.visible = false
			passage_edge.modulate.a = 0.68
			passage_glow.modulate.a = 0.0
			passage_prince_above.modulate.a = 0.0
			_layout_passage_prince()
			_set_passage_prince_base(passage_prince_below)
			passage_prince_below.modulate.a = 1.0
			_skip_to_seventh_planet()
		"player_planet_editor":
			for slug in MEMORY_ORDER:
				memory_collection_states[slug] = "collected"
			cover.visible = false
			map_screen.visible = true
			_reveal_player_planet_on_map()
			_on_planet_pressed(PLAYER_PLANET_NAME)
			while not stage_3d.visible or current_3d_scene != "player":
				await get_tree().create_timer(0.2).timeout
			await get_tree().create_timer(0.3).timeout
			if not editor_active:
				_toggle_3d_editor()
		"rose_dialogue":
			planet_story_states["rose"] = "new"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("玫瑰")
			await get_tree().create_timer(1.5).timeout
			_start_generated_story_dialogue("rose")
		"vain_dialogue":
			planet_story_states["vain"] = "new"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("爱慕虚荣的人")
			await get_tree().create_timer(1.5).timeout
			_start_generated_story_dialogue("vain")
		"merchant_dialogue":
			planet_story_states["merchant"] = "new"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("商人")
			await get_tree().create_timer(1.5).timeout
			_start_generated_story_dialogue("merchant")
		"earth_dialogue":
			planet_story_states["earth"] = "new"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("狐狸与麦田")
			await get_tree().create_timer(1.5).timeout
			_start_generated_story_dialogue("earth")
		"rose_action":
			planet_story_states["rose"] = "dialogue_done"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("玫瑰")
			await get_tree().create_timer(2.5).timeout
			_begin_planet_story_action("rose")
		"vain_action":
			planet_story_states["vain"] = "dialogue_done"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("爱慕虚荣的人")
			await get_tree().create_timer(2.5).timeout
			_begin_planet_story_action("vain")
		"merchant_action":
			planet_story_states["merchant"] = "dialogue_done"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("商人")
			await get_tree().create_timer(2.5).timeout
			_begin_planet_story_action("merchant")
		"earth_action":
			planet_story_states["earth"] = "dialogue_done"
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("狐狸与麦田")
			await get_tree().create_timer(2.5).timeout
			_begin_planet_story_action("earth")
		"editor_isolation":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("狐狸与麦田")
			while not stage_3d.visible or current_3d_scene != "earth":
				await get_tree().create_timer(0.2).timeout
			_exit_3d()
			await get_tree().create_timer(0.5).timeout
			_restore_planet_map_instant()
			_on_planet_pressed("玫瑰")
			while not stage_3d.visible or current_3d_scene != "rose":
				await get_tree().create_timer(0.2).timeout
			_toggle_3d_editor()
			print(
				"QA_EDITOR_ISOLATION=",
				current_3d_scene,
				" layout=",
				_current_layout_key(),
				" earth_controls=",
				editor_earth_wheat_controls.visible,
				" first_object=",
				editable_3d_objects[0].label if not editable_3d_objects.is_empty() else "empty"
			)
		"king_editor":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("国王")
			await get_tree().create_timer(1.3).timeout
			if not editor_active:
				_toggle_3d_editor()
		"pointlighter_off":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.4).timeout
			var lamp_click_hit := false
			if main_lamp_light_anchor != null:
				var lamp_screen_position := camera_3d.unproject_position(
					main_lamp_light_anchor.global_position
				)
				lamp_click_hit = _is_main_lamp_at_screen(lamp_screen_position)
			print("QA_POINTLIGHTER_LAMP_CLICK_HIT=", lamp_click_hit)
			if lamp_click_hit and main_lamp_on:
				_toggle_main_lamp()
		"dialogue":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.5).timeout
			_start_lamplighter_dialogue()
		"dialogue_edit":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.5).timeout
			_start_lamplighter_dialogue()
			await get_tree().create_timer(0.15).timeout
			_set_dialogue_text_edit_mode(true)
		"dialogue_flow":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.5).timeout
			_start_lamplighter_dialogue()
			await get_tree().create_timer(0.1).timeout
			await _on_dialogue_choice(DIALOGUE_NODES.intro.choices[2])
			await _on_dialogue_choice(DIALOGUE_NODES.doubt.choices[0])
			await _on_dialogue_choice(DIALOGUE_NODES.afraid.choices[0])
			await _on_dialogue_choice(DIALOGUE_NODES.reflection.choices[0])
			await _on_dialogue_choice(DIALOGUE_NODES.ending.choices[0])
			await get_tree().create_timer(0.8).timeout
			print("QA_DIALOGUE_FLOW_CHAIR_STATE=", chair_state)
		"chair":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.5).timeout
			_start_chair_sequence()
		"wobble":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.5).timeout
			for index in editable_3d_objects.size():
				if String(editable_3d_objects[index].kind) == "round_tree":
					var tree_node := editable_3d_objects[index].node as Node3D
					var tree_screen := camera_3d.unproject_position(
						_editable_world_bounds(tree_node).get_center()
					)
					var picked_index := _pick_prop_feedback_target(tree_screen)
					print("QA_PROP_WOBBLE_HIT=", picked_index)
					if picked_index >= 0:
						_start_prop_wobble(picked_index, tree_screen)
					break
		"seated":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.5).timeout
			_start_chair_sequence()
			await get_tree().create_timer(0.1).timeout
			_begin_chair_drag()
			chair_3d.transform = chair_target_transform
			chair_3d.scale = chair_target_scale
			chair_drag_distance = 100.0
			_finish_chair_drag()
			_start_prince_sitting()
			await get_tree().create_timer(2.0).timeout
			print("QA_PRINCE_SEATED_STATE=", chair_state)
		"editor":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.3).timeout
			if not editor_active:
				_toggle_3d_editor()
		"standing_edit":
			cover.visible = false
			map_screen.visible = true
			_on_planet_pressed("点灯人")
			await get_tree().create_timer(1.3).timeout
			if not editor_active:
				_toggle_3d_editor()
			var standing_index := _find_editable_record_index_by_kind("standing_prince")
			if standing_index >= 0:
				selected_editable_index = standing_index
				editor_object_select.select(standing_index)
				_sync_editor_controls()
				_update_editor_selection_ring()
		"passage":
			cover.visible = false
			map_screen.visible = true
			map_screen.modulate = Color(1, 1, 1, 0.22)
			passage.visible = true
			passage.mouse_filter = Control.MOUSE_FILTER_IGNORE
			passage_page.visible = true
			passage_page.modulate.a = 1.0
			passage_page.scale = Vector2(1.06, 1.06)
			_layout_passage_prince()
			_set_passage_prince_base(passage_prince_above)
			passage_prince_above.scale = Vector2.ONE
			passage_prince_above.rotation = deg_to_rad(-1.2)
			passage_prince_above.modulate.a = 1.0
			passage_prince_below.modulate.a = 0.0
		"settled":
			cover.visible = false
			map_screen.visible = true
			map_screen.modulate = Color.WHITE
			passage.visible = true
			passage.mouse_filter = Control.MOUSE_FILTER_IGNORE
			passage_page.visible = false
			passage_edge.modulate.a = 0.68
			passage_glow.modulate.a = 0.0
			passage_prince_above.modulate.a = 0.0
			_layout_passage_prince()
			_set_passage_prince_base(passage_prince_below)
			passage_prince_below.scale = Vector2.ONE * 0.96
			passage_prince_below.rotation = deg_to_rad(-0.8)
			passage_prince_below.modulate.a = 1.0
		"transition":
			cover.visible = true
			map_screen.visible = false
			await _start_passage()
