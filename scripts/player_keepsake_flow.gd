extends CanvasLayer


signal flow_closed
signal letter_saved(path: String)


const QR := preload("res://addons/specqr/specqr.gd")
const PLANET_MEMORY_SHARE_SCRIPT := preload(
	"res://scripts/planet_memory_share.gd"
)
const LETTER_BACKDROP_PATH := "res://assets/ui/letter/planet_letter_backdrop.png"
const PHOTO_FRAME_PATH := "res://assets/ui/letter/planet_photo_frame.png"
const WAX_SEAL_PATH := "res://assets/ui/letter/letter_wax_seal.png"
const POSTAGE_STAMP_PATH := "res://assets/ui/letter/letter_postage_stamp.png"
const QR_PLAQUE_PATH := "res://assets/ui/letter/letter_qr_plaque.png"
const TITLE_FONT_PATH := "res://assets/ui/fonts/ZCOOLXiaoWei-Regular.ttf"
const OUTPUT_DIR := "user://planet_memories/"
const LETTER_SIZE := Vector2i(1440, 1440)
const CAPTURE_ASPECT := 1.6
const MIN_FOV := 18.0
const MAX_FOV := 54.0
const MAX_PAN := 0.42
const MIN_CAPTURE_PITCH := -32.0
const MAX_CAPTURE_PITCH := 38.0
const CAPTURE_PITCH_STEP := 4.0
const CAPTURE_ZOOM_STEP := 0.65
const SHARE_UPLOAD_URL := "https://tmpfiles.org/api/v1/upload"
const SHARE_EXPIRE_SECONDS := 86400
const ITEM_SUMMARY_ORDER := [
	"player_cottage",
	"player_tent",
	"player_long_table",
	"player_picnic_blanket",
	"player_bench",
	"player_swing",
	"player_star_pointlighter_lamp",
	"player_camping_lamp",
	"player_star_rose_combo",
	"player_tea_set",
	"player_picnic_basket",
	"player_flowers",
	"player_mailbox",
	"player_paper_boat",
	"player_open_book",
	"player_vase",
	"player_star_earth_fox",
	"player_star_earth_wheat_bundle",
	"player_star_merchant_ledger",
	"player_star_vain_mirror",
	"player_star_king_banner",
]
const EXPRESSION_LABELS := {
	"heart": "比心",
	"smile": "微笑",
	"laugh": "大笑",
	"shy": "害羞",
	"surprise": "惊讶",
	"think": "认真",
	"cheer": "加油",
	"sad": "难过",
	"invite": "邀请",
	"goodnight": "晚安",
}
const PRINCE_REPLY_LABELS := {
	"heart": "比心",
	"smile": "微笑",
	"laugh": "大笑",
	"star": "星星",
	"surprise": "惊讶",
	"nod": "认真",
	"cheer": "加油",
	"worry": "担心",
	"invite": "邀请",
	"goodnight": "晚安",
}
const CLASS_NARRATIVES := {
	"温柔": "你用茶香、花和一点点陪伴，把这里布置成一颗愿意倾听的星球。",
	"自在": "你给风留了经过的地方，也让每件喜欢的东西自己找到了位置。",
	"自信": "你把喜欢的东西放在看得见的地方，让这颗星球坦然地成为你的。",
	"守护": "你让重要的东西各有位置，也给归来的人留了一盏灯。",
	"勇敢": "你把小船、帐篷和还没走完的路留在星球边缘，像替出发留了一扇门。",
	"好奇": "你把书、镜子和没有写完的问题摆在手边，等星球慢慢回答。",
}


var camera_3d: Camera3D
var host: Node
var hud_layer: CanvasLayer
var ui_editor_layer: CanvasLayer
var interface_font: Font

var ui_root: Control
var capture_root: Control
var capture_frame: Panel
var capture_title_label: Label
var capture_live_label: Label
var capture_exposure_label: Label
var capture_hint_label: Label
var capture_cross_horizontal: ColorRect
var capture_cross_vertical: ColorRect
var capture_third_lines: Array[ColorRect] = []
var capture_controls: Control
var zoom_label: Label
var pitch_label: Label
var shutter_button: Button
var cancel_button: Button

var name_modal: Control
var name_panel: PanelContainer
var name_field: LineEdit
var name_error_label: Label

var stamp_root: Control
var stamp_seal: TextureRect
var stamp_label: Label
var stamp_flash: ColorRect

var result_root: Control
var result_letter: TextureRect
var result_title: Label
var result_path_label: Label
var result_close_button: Button

var camera_saved_fov := 34.0
var camera_saved_h_offset := 0.0
var camera_saved_v_offset := 0.0
var camera_saved_global_transform := Transform3D.IDENTITY
var camera_saved_focus_point := Vector3.ZERO
var camera_saved_up := Vector3.UP
var camera_saved_distance := 0.0
var capture_pitch_degrees := 0.0
var ui_editor_saved_visible := true
var capture_dragging := false
var capture_drag_distance := 0.0
var flow_busy := false
var current_planet_name := "我的星球"
var current_photo: Image
var current_letter: Image
var last_letter_path := ""
var last_photo_path := ""
var last_letter_copy: Dictionary = {}
var last_share_url := ""
var last_share_is_temporary := false
var planet_memory_share
var letter_viewport: SubViewport


func setup(
	p_camera: Camera3D,
	p_host: Node,
	p_hud_layer: CanvasLayer,
	p_ui_editor_layer: CanvasLayer,
	p_font: Font
) -> void:
	camera_3d = p_camera
	host = p_host
	hud_layer = p_hud_layer
	ui_editor_layer = p_ui_editor_layer
	interface_font = p_font
	layer = 92
	visible = false
	if ui_root == null:
		_build_interface()
	if planet_memory_share == null:
		planet_memory_share = PLANET_MEMORY_SHARE_SCRIPT.new()
		planet_memory_share.name = "PlanetMemoryShare"
		add_child(planet_memory_share)


func open_capture() -> void:
	if camera_3d == null or host == null or ui_root == null:
		return
	if host.get("current_3d_scene") != "player":
		return
	current_photo = null
	current_letter = null
	flow_busy = false
	capture_dragging = false
	camera_saved_fov = camera_3d.fov
	camera_saved_h_offset = camera_3d.h_offset
	camera_saved_v_offset = camera_3d.v_offset
	camera_saved_global_transform = camera_3d.global_transform
	camera_saved_up = camera_3d.global_basis.y.normalized()
	camera_saved_distance = float(host.get("camera_distance"))
	var focus_value = host.get("camera_focus_point")
	camera_saved_focus_point = (
		focus_value as Vector3
		if typeof(focus_value) == TYPE_VECTOR3
		else (
			camera_3d.global_position
			- camera_3d.global_basis.z.normalized() * 5.5
		)
	)
	capture_pitch_degrees = 0.0
	capture_drag_distance = 0.0
	ui_editor_saved_visible = (
		ui_editor_layer.visible if ui_editor_layer != null else true
	)
	hud_layer.visible = false
	if ui_editor_layer != null:
		ui_editor_layer.visible = false
	visible = true
	ui_root.visible = true
	capture_root.visible = true
	name_modal.visible = false
	stamp_root.visible = false
	result_root.visible = false
	name_error_label.text = ""
	name_field.text = "我的星球"
	capture_dragging = false
	_layout_capture_ui()
	_update_camera_readout()
	call_deferred("_focus_capture")


func close_flow() -> void:
	if not visible:
		return
	flow_busy = false
	capture_dragging = false
	capture_drag_distance = 0.0
	visible = false
	ui_root.visible = false
	if camera_3d != null:
		camera_3d.fov = camera_saved_fov
		camera_3d.h_offset = camera_saved_h_offset
		camera_3d.v_offset = camera_saved_v_offset
		camera_3d.global_transform = camera_saved_global_transform
	if host != null and camera_saved_distance > 0.0:
		host.set("camera_distance", camera_saved_distance)
	if hud_layer != null:
		hud_layer.visible = true
	if ui_editor_layer != null:
		ui_editor_layer.visible = ui_editor_saved_visible
	if host != null:
		host.call("_update_player_character_interaction_buttons")
		host.call("_refresh_player_scene_hint")
		host.call("_sync_camera_zoom_controls")
	flow_closed.emit()


func _focus_capture() -> void:
	if visible:
		shutter_button.grab_focus()


func _build_interface() -> void:
	ui_root = Control.new()
	ui_root.name = "PlayerKeepsakeOverlay"
	ui_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	ui_root.mouse_filter = Control.MOUSE_FILTER_STOP
	if interface_font != null:
		ui_root.add_theme_font_override("font", interface_font)
	add_child(ui_root)
	_build_capture_ui()
	_build_name_modal()
	_build_stamp_ui()
	_build_result_ui()
	ui_root.resized.connect(_on_overlay_resized)


func _build_capture_ui() -> void:
	capture_root = Control.new()
	capture_root.name = "CaptureMode"
	capture_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	capture_root.mouse_filter = Control.MOUSE_FILTER_STOP
	ui_root.add_child(capture_root)

	capture_frame = Panel.new()
	capture_frame.name = "Viewfinder"
	capture_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var frame_style := StyleBoxFlat.new()
	frame_style.bg_color = Color.TRANSPARENT
	frame_style.border_color = Color(0.91, 0.78, 0.50, 0.78)
	frame_style.set_border_width_all(1)
	frame_style.shadow_color = Color(0.0, 0.0, 0.0, 0.22)
	frame_style.shadow_size = 3
	capture_frame.add_theme_stylebox_override("panel", frame_style)
	capture_root.add_child(capture_frame)

	for corner_data in [
		{"name": "TopLeft", "anchor": Vector2(0, 0), "x_dir": 1.0, "y_dir": 1.0},
		{"name": "TopRight", "anchor": Vector2(1, 0), "x_dir": -1.0, "y_dir": 1.0},
		{"name": "BottomLeft", "anchor": Vector2(0, 1), "x_dir": 1.0, "y_dir": -1.0},
		{"name": "BottomRight", "anchor": Vector2(1, 1), "x_dir": -1.0, "y_dir": -1.0},
	]:
		_make_capture_corner(corner_data)

	for index in 4:
		var line := ColorRect.new()
		line.color = Color(0.94, 0.88, 0.72, 0.18)
		line.mouse_filter = Control.MOUSE_FILTER_IGNORE
		capture_root.add_child(line)
		capture_third_lines.append(line)

	capture_cross_horizontal = ColorRect.new()
	capture_cross_horizontal.color = Color(1.0, 0.91, 0.66, 0.82)
	capture_cross_horizontal.mouse_filter = Control.MOUSE_FILTER_IGNORE
	capture_root.add_child(capture_cross_horizontal)
	capture_cross_vertical = ColorRect.new()
	capture_cross_vertical.color = Color(1.0, 0.91, 0.66, 0.82)
	capture_cross_vertical.mouse_filter = Control.MOUSE_FILTER_IGNORE
	capture_root.add_child(capture_cross_vertical)

	capture_title_label = _make_overlay_label(
		capture_root,
		"S7  /  PLANET CAMERA",
		16,
		Color(0.99, 0.91, 0.72, 0.92)
	)
	capture_live_label = _make_overlay_label(
		capture_root,
		"o  LIVE  |  8:5",
		16,
		Color(1.0, 0.43, 0.30, 1.0),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	capture_exposure_label = _make_overlay_label(
		capture_root,
		"ISO 200   1/125   F2.8",
		16,
		Color(0.99, 0.91, 0.72, 0.78),
		HORIZONTAL_ALIGNMENT_RIGHT
	)
	capture_hint_label = _make_overlay_label(
		capture_root,
		"拖动星球旋转 | 滚轮缩放 | 双击复位 | Q / E 调整仰角",
		18,
		Color(0.96, 0.90, 0.75, 0.80),
		HORIZONTAL_ALIGNMENT_CENTER
	)

	capture_controls = Control.new()
	capture_controls.name = "CameraControls"
	capture_root.add_child(capture_controls)
	var control_panel := PanelContainer.new()
	control_panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	control_panel.mouse_filter = Control.MOUSE_FILTER_PASS
	var control_style := StyleBoxFlat.new()
	control_style.bg_color = Color(0.025, 0.035, 0.055, 0.66)
	control_style.border_color = Color(0.87, 0.76, 0.54, 0.40)
	control_style.set_border_width_all(1)
	control_style.set_corner_radius_all(16)
	control_style.shadow_color = Color(0.0, 0.0, 0.0, 0.28)
	control_style.shadow_size = 8
	control_panel.add_theme_stylebox_override("panel", control_style)
	capture_controls.add_child(control_panel)
	var controls_margin := MarginContainer.new()
	controls_margin.add_theme_constant_override("margin_left", 13)
	controls_margin.add_theme_constant_override("margin_right", 13)
	controls_margin.add_theme_constant_override("margin_top", 10)
	controls_margin.add_theme_constant_override("margin_bottom", 10)
	control_panel.add_child(controls_margin)
	var dock_row := HBoxContainer.new()
	dock_row.add_theme_constant_override("separation", 12)
	controls_margin.add_child(dock_row)

	var zoom_group := _make_camera_control_group("缩放")
	dock_row.add_child(zoom_group)
	zoom_label = _make_camera_group_label("ZOOM 1.00×")
	zoom_label.text = "ZOOM  1.00×"
	zoom_group.add_child(zoom_label)
	var zoom_row := HBoxContainer.new()
	zoom_row.add_theme_constant_override("separation", 4)
	zoom_group.add_child(zoom_row)
	var zoom_out := _make_camera_button("−", "缩小镜头", Vector2(36.0, 30.0))
	zoom_out.pressed.connect(_zoom_camera.bind(-CAPTURE_ZOOM_STEP))
	zoom_row.add_child(zoom_out)
	var zoom_in := _make_camera_button("+", "放大镜头", Vector2(36.0, 30.0))
	zoom_in.pressed.connect(_zoom_camera.bind(CAPTURE_ZOOM_STEP))
	zoom_row.add_child(zoom_in)

	var divider := VSeparator.new()
	divider.add_theme_color_override("separator", Color(0.92, 0.80, 0.57, 0.20))
	dock_row.add_child(divider)

	var pan_group := _make_camera_control_group("平移")
	dock_row.add_child(pan_group)
	var pan_grid := GridContainer.new()
	pan_grid.columns = 3
	pan_grid.add_theme_constant_override("h_separation", 4)
	pan_grid.add_theme_constant_override("v_separation", 4)
	pan_group.add_child(pan_grid)
	pan_grid.add_child(_make_camera_grid_spacer())
	var up := _make_camera_button("^", "镜头上移", Vector2(34.0, 28.0))
	up.pressed.connect(_pan_camera.bind(Vector2(0.0, 1.0)))
	pan_grid.add_child(up)
	pan_grid.add_child(_make_camera_grid_spacer())
	var left := _make_camera_button("<", "镜头左移", Vector2(34.0, 28.0))
	left.pressed.connect(_pan_camera.bind(Vector2(-1.0, 0.0)))
	pan_grid.add_child(left)
	var reset := _make_camera_button("|", "镜头回到初始位置", Vector2(34.0, 28.0))
	reset.pressed.connect(_reset_capture_camera)
	pan_grid.add_child(reset)
	var right := _make_camera_button(">", "镜头右移", Vector2(34.0, 28.0))
	right.pressed.connect(_pan_camera.bind(Vector2(1.0, 0.0)))
	pan_grid.add_child(right)
	pan_grid.add_child(_make_camera_grid_spacer())
	var down := _make_camera_button("v", "镜头下移", Vector2(34.0, 28.0))
	down.pressed.connect(_pan_camera.bind(Vector2(0.0, -1.0)))
	pan_grid.add_child(down)
	pan_grid.add_child(_make_camera_grid_spacer())

	var pitch_divider := VSeparator.new()
	pitch_divider.add_theme_color_override(
		"separator",
		Color(0.92, 0.80, 0.57, 0.20)
	)
	dock_row.add_child(pitch_divider)

	var pitch_group := _make_camera_control_group("仰角")
	dock_row.add_child(pitch_group)
	pitch_label = _make_camera_group_label("0°")
	pitch_group.add_child(pitch_label)
	var pitch_row := HBoxContainer.new()
	pitch_row.add_theme_constant_override("separation", 4)
	pitch_group.add_child(pitch_row)
	var pitch_down := _make_camera_button("−", "降低相机仰角", Vector2(36.0, 30.0))
	pitch_down.pressed.connect(_adjust_capture_pitch.bind(-CAPTURE_PITCH_STEP))
	pitch_row.add_child(pitch_down)
	var pitch_up := _make_camera_button("+", "抬高相机仰角", Vector2(36.0, 30.0))
	pitch_up.pressed.connect(_adjust_capture_pitch.bind(CAPTURE_PITCH_STEP))
	pitch_row.add_child(pitch_up)

	cancel_button = _make_overlay_text_button("退出取景")
	cancel_button.pressed.connect(close_flow)
	capture_root.add_child(cancel_button)

	shutter_button = Button.new()
	shutter_button.name = "CaptureShutter"
	shutter_button.text = ""
	shutter_button.tooltip_text = "拍下这颗星球"
	shutter_button.focus_mode = Control.FOCUS_ALL
	shutter_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var shutter_style := StyleBoxFlat.new()
	shutter_style.bg_color = Color(0.96, 0.91, 0.78, 0.96)
	shutter_style.border_color = Color(1.0, 0.82, 0.48, 1.0)
	shutter_style.set_border_width_all(3)
	shutter_style.set_corner_radius_all(47)
	shutter_style.shadow_color = Color(0.0, 0.0, 0.0, 0.40)
	shutter_style.shadow_size = 12
	var shutter_hover := shutter_style.duplicate() as StyleBoxFlat
	shutter_hover.bg_color = Color(1.0, 0.96, 0.84, 1.0)
	shutter_hover.border_color = Color(1.0, 0.90, 0.62, 1.0)
	shutter_button.add_theme_stylebox_override("normal", shutter_style)
	shutter_button.add_theme_stylebox_override("hover", shutter_hover)
	shutter_button.add_theme_stylebox_override("pressed", shutter_hover)
	shutter_button.add_theme_stylebox_override("focus", shutter_hover)
	shutter_button.pressed.connect(_on_shutter_pressed)
	capture_root.add_child(shutter_button)
	var shutter_core := Panel.new()
	shutter_core.mouse_filter = Control.MOUSE_FILTER_IGNORE
	shutter_core.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	shutter_core.size = Vector2(66, 66)
	shutter_core.position = Vector2(-33, -33)
	var core_style := StyleBoxFlat.new()
	core_style.bg_color = Color(0.72, 0.25, 0.14, 0.92)
	core_style.border_color = Color(1.0, 0.76, 0.42, 0.78)
	core_style.set_border_width_all(1)
	core_style.set_corner_radius_all(33)
	shutter_core.add_theme_stylebox_override("panel", core_style)
	shutter_button.add_child(shutter_core)


func _make_capture_corner(data: Dictionary) -> void:
	var x_dir := float(data.x_dir)
	var y_dir := float(data.y_dir)
	var corner := Control.new()
	corner.name = "FrameCorner" + String(data.name)
	corner.mouse_filter = Control.MOUSE_FILTER_IGNORE
	corner.anchor_left = float(data.anchor.x)
	corner.anchor_right = float(data.anchor.x)
	corner.anchor_top = float(data.anchor.y)
	corner.anchor_bottom = float(data.anchor.y)
	corner.offset_left = 34.0 if x_dir > 0.0 else -70.0
	corner.offset_right = 70.0 if x_dir > 0.0 else -34.0
	corner.offset_top = 50.0 if y_dir > 0.0 else -56.0
	corner.offset_bottom = 56.0 if y_dir > 0.0 else -50.0
	capture_root.add_child(corner)
	var horizontal := ColorRect.new()
	horizontal.color = Color(0.98, 0.86, 0.58, 0.90)
	horizontal.mouse_filter = Control.MOUSE_FILTER_IGNORE
	horizontal.position = (
		Vector2(0.0, 4.0) if y_dir > 0.0 else Vector2(0.0, 0.0)
	)
	horizontal.size = Vector2(36.0, 2.0)
	corner.add_child(horizontal)
	var vertical := ColorRect.new()
	vertical.color = Color(0.98, 0.86, 0.58, 0.90)
	vertical.mouse_filter = Control.MOUSE_FILTER_IGNORE
	vertical.position = (
		Vector2(4.0, 0.0) if x_dir > 0.0 else Vector2(0.0, 0.0)
	)
	vertical.size = Vector2(2.0, 36.0)
	corner.add_child(vertical)


func _make_camera_control_group(title_value: String) -> VBoxContainer:
	var group := VBoxContainer.new()
	group.add_theme_constant_override("separation", 4)
	var caption := Label.new()
	caption.text = title_value
	caption.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	caption.add_theme_font_size_override("font_size", 16)
	caption.add_theme_color_override(
		"font_color",
		Color(0.86, 0.75, 0.57, 0.72)
	)
	group.add_child(caption)
	return group


func _make_camera_group_label(text_value: String) -> Label:
	var label := Label.new()
	label.text = text_value
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override(
		"font_color",
		Color(0.96, 0.87, 0.68, 0.92)
	)
	return label


func _make_camera_grid_spacer() -> Control:
	var spacer := Control.new()
	spacer.custom_minimum_size = Vector2(34.0, 28.0)
	spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return spacer


func _make_camera_button(
	text_value: String,
	tooltip_value: String,
	size_value := Vector2(42.0, 34.0)
) -> Button:
	var button := Button.new()
	button.text = text_value
	button.tooltip_text = tooltip_value
	button.custom_minimum_size = size_value
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.92, 0.86, 0.70, 0.16)
	normal.border_color = Color(0.94, 0.82, 0.58, 0.42)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(7)
	var hover := normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color(0.96, 0.87, 0.65, 0.30)
	hover.border_color = Color(1.0, 0.91, 0.70, 0.78)
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", hover)
	button.add_theme_color_override("font_color", Color(1.0, 0.93, 0.77, 0.96))
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_font_size_override("font_size", 18)
	return button


func _make_overlay_text_button(text_value: String) -> Button:
	var button := Button.new()
	button.text = text_value
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.02, 0.03, 0.05, 0.54)
	normal.border_color = Color(0.91, 0.80, 0.60, 0.38)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(12)
	var hover := normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color(0.10, 0.09, 0.07, 0.72)
	hover.border_color = Color(1.0, 0.86, 0.58, 0.70)
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", hover)
	button.add_theme_color_override("font_color", Color(0.98, 0.91, 0.76, 0.90))
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_font_size_override("font_size", 18)
	return button


func _make_overlay_label(
	parent: Control,
	text_value: String,
	font_size: int,
	color: Color,
	alignment := HORIZONTAL_ALIGNMENT_LEFT
) -> Label:
	var label := Label.new()
	label.text = text_value
	label.horizontal_alignment = alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.76))
	label.add_theme_constant_override("shadow_offset_x", 0)
	label.add_theme_constant_override("shadow_offset_y", 2)
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(label)
	return label


func _build_name_modal() -> void:
	name_modal = Control.new()
	name_modal.name = "PlanetNameModal"
	name_modal.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	name_modal.mouse_filter = Control.MOUSE_FILTER_STOP
	name_modal.visible = false
	ui_root.add_child(name_modal)
	var dim := ColorRect.new()
	dim.color = Color(0.015, 0.025, 0.04, 0.72)
	dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	dim.mouse_filter = Control.MOUSE_FILTER_STOP
	name_modal.add_child(dim)
	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	center.mouse_filter = Control.MOUSE_FILTER_PASS
	name_modal.add_child(center)
	name_panel = PanelContainer.new()
	name_panel.custom_minimum_size = Vector2(590, 0)
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.94, 0.89, 0.76, 0.985)
	panel_style.border_color = Color(0.68, 0.52, 0.30, 0.78)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(18)
	panel_style.shadow_color = Color(0.0, 0.0, 0.0, 0.48)
	panel_style.shadow_size = 22
	name_panel.add_theme_stylebox_override("panel", panel_style)
	center.add_child(name_panel)
	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 34)
	margin.add_theme_constant_override("margin_right", 34)
	margin.add_theme_constant_override("margin_top", 26)
	margin.add_theme_constant_override("margin_bottom", 24)
	name_panel.add_child(margin)
	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 13)
	margin.add_child(column)
	var kicker := Label.new()
	kicker.text = "即将盖下星球印章"
	kicker.add_theme_font_size_override("font_size", 16)
	kicker.add_theme_color_override("font_color", Color(0.53, 0.39, 0.23, 0.88))
	column.add_child(kicker)
	var title := Label.new()
	title.text = "给这颗星球起个名字"
	title.add_theme_font_size_override("font_size", 32)
	title.add_theme_color_override("font_color", Color(0.39, 0.20, 0.14, 1.0))
	column.add_child(title)
	var description := Label.new()
	description.text = "它会出现在信纸标题和右下角的星球记忆二维码里。"
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description.add_theme_font_size_override("font_size", 18)
	description.add_theme_color_override("font_color", Color(0.37, 0.28, 0.20, 0.78))
	column.add_child(description)
	name_field = LineEdit.new()
	name_field.text = "我的星球"
	name_field.placeholder_text = "输入星球名称"
	name_field.max_length = 12
	name_field.custom_minimum_size = Vector2(0, 50)
	name_field.add_theme_font_size_override("font_size", 24)
	var field_style := StyleBoxFlat.new()
	field_style.bg_color = Color(1.0, 0.97, 0.89, 0.96)
	field_style.border_color = Color(0.68, 0.52, 0.31, 0.70)
	field_style.set_border_width_all(1)
	field_style.set_corner_radius_all(9)
	field_style.content_margin_left = 14.0
	field_style.content_margin_right = 14.0
	name_field.add_theme_stylebox_override("normal", field_style)
	name_field.add_theme_color_override("font_color", Color(0.30, 0.19, 0.13, 1.0))
	name_field.text_submitted.connect(_on_name_submitted)
	column.add_child(name_field)
	name_error_label = Label.new()
	name_error_label.text = ""
	name_error_label.add_theme_font_size_override("font_size", 16)
	name_error_label.add_theme_color_override("font_color", Color(0.63, 0.19, 0.12, 1.0))
	column.add_child(name_error_label)
	var buttons := HBoxContainer.new()
	buttons.alignment = BoxContainer.ALIGNMENT_END
	buttons.add_theme_constant_override("separation", 10)
	column.add_child(buttons)
	var cancel := _make_paper_modal_button("再看看", false)
	cancel.pressed.connect(_return_to_capture)
	buttons.add_child(cancel)
	var confirm := _make_paper_modal_button("盖章", true)
	confirm.pressed.connect(_on_name_submitted.bind(name_field.text))
	buttons.add_child(confirm)


func _make_paper_modal_button(text_value: String, primary: bool) -> Button:
	var button := Button.new()
	button.text = text_value
	button.custom_minimum_size = Vector2(112, 42)
	button.focus_mode = Control.FOCUS_ALL
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var normal := StyleBoxFlat.new()
	normal.bg_color = (
		Color(0.68, 0.29, 0.17, 0.96)
		if primary
		else Color(0.88, 0.82, 0.68, 0.96)
	)
	normal.border_color = (
		Color(0.92, 0.58, 0.31, 0.94)
		if primary
		else Color(0.62, 0.48, 0.30, 0.68)
	)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(10)
	var hover := normal.duplicate() as StyleBoxFlat
	hover.bg_color = (
		Color(0.78, 0.36, 0.20, 1.0)
		if primary
		else Color(0.95, 0.89, 0.76, 1.0)
	)
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", hover)
	button.add_theme_color_override(
		"font_color",
		Color(1.0, 0.94, 0.80, 1.0) if primary else Color(0.31, 0.21, 0.14, 1.0)
	)
	return button


func _build_stamp_ui() -> void:
	stamp_root = Control.new()
	stamp_root.name = "WaxStampStage"
	stamp_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	stamp_root.mouse_filter = Control.MOUSE_FILTER_STOP
	stamp_root.visible = false
	ui_root.add_child(stamp_root)
	var dim := ColorRect.new()
	dim.color = Color(0.015, 0.025, 0.04, 0.78)
	dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	dim.mouse_filter = Control.MOUSE_FILTER_IGNORE
	stamp_root.add_child(dim)
	stamp_seal = TextureRect.new()
	stamp_seal.texture = load(WAX_SEAL_PATH) as Texture2D
	stamp_seal.size = Vector2(280, 276)
	stamp_seal.pivot_offset = stamp_seal.size * 0.5
	stamp_seal.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stamp_seal.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	stamp_seal.mouse_filter = Control.MOUSE_FILTER_IGNORE
	stamp_root.add_child(stamp_seal)
	stamp_label = _make_overlay_label(
		stamp_root,
		"正在为星球盖章",
		22,
		Color(0.98, 0.89, 0.70, 0.95),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	stamp_flash = ColorRect.new()
	stamp_flash.color = Color(1.0, 0.94, 0.82, 0.0)
	stamp_flash.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	stamp_flash.mouse_filter = Control.MOUSE_FILTER_IGNORE
	stamp_root.add_child(stamp_flash)


func _build_result_ui() -> void:
	result_root = Control.new()
	result_root.name = "LetterResult"
	result_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	result_root.mouse_filter = Control.MOUSE_FILTER_STOP
	result_root.visible = false
	ui_root.add_child(result_root)
	var backdrop := ColorRect.new()
	backdrop.color = Color(0.018, 0.027, 0.045, 0.97)
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	backdrop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	result_root.add_child(backdrop)
	result_title = _make_overlay_label(
		result_root,
		"星球信笺已经写好",
		28,
		Color(0.99, 0.89, 0.69, 0.96),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	result_letter = TextureRect.new()
	result_letter.name = "GeneratedLetter"
	result_letter.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	result_letter.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	result_letter.mouse_filter = Control.MOUSE_FILTER_IGNORE
	result_root.add_child(result_letter)
	result_path_label = _make_overlay_label(
		result_root,
		"",
		16,
		Color(0.93, 0.86, 0.70, 0.66),
		HORIZONTAL_ALIGNMENT_CENTER
	)
	result_path_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	result_close_button = _make_overlay_text_button("收下信纸")
	result_close_button.pressed.connect(close_flow)
	result_root.add_child(result_close_button)


func _on_overlay_resized() -> void:
	if capture_root != null and capture_root.visible:
		_layout_capture_ui()
	if stamp_root != null and stamp_root.visible:
		_layout_stamp_ui()
	if result_root != null and result_root.visible:
		_layout_result_ui()


func _layout_capture_ui() -> void:
	if ui_root == null:
		return
	var size := get_viewport().get_visible_rect().size
	var safe := Rect2(
		Vector2(78.0, 74.0),
		Vector2(maxf(480.0, size.x - 156.0), maxf(360.0, size.y - 148.0))
	)
	capture_frame.position = safe.position
	capture_frame.size = safe.size
	capture_title_label.position = Vector2(safe.position.x, 30.0)
	capture_title_label.size = Vector2(360.0, 30.0)
	capture_live_label.position = Vector2(size.x * 0.5 - 70.0, 30.0)
	capture_live_label.size = Vector2(140.0, 30.0)
	capture_exposure_label.position = Vector2(size.x - 424.0, 30.0)
	capture_exposure_label.size = Vector2(340.0, 30.0)
	capture_hint_label.size = Vector2(520.0, 28.0)
	capture_hint_label.position = Vector2(safe.end.x - 520.0, safe.end.y + 13.0)
	capture_hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	for index in capture_third_lines.size():
		var line := capture_third_lines[index]
		if index < 2:
			line.position = Vector2(
				safe.position.x + safe.size.x * float(index + 1) / 3.0,
				safe.position.y
			)
			line.size = Vector2(1.0, safe.size.y)
		else:
			line.position = Vector2(
				safe.position.x,
				safe.position.y + safe.size.y * float(index - 1) / 3.0
			)
			line.size = Vector2(safe.size.x, 1.0)
	var cross_center := safe.get_center()
	capture_cross_horizontal.position = cross_center - Vector2(28.0, 0.5)
	capture_cross_horizontal.size = Vector2(56.0, 1.0)
	capture_cross_vertical.position = cross_center - Vector2(0.5, 28.0)
	capture_cross_vertical.size = Vector2(1.0, 56.0)
	capture_controls.position = Vector2(24.0, size.y - 176.0)
	capture_controls.size = Vector2(350.0, 150.0)
	cancel_button.position = Vector2(size.x - 150.0, 68.0)
	cancel_button.size = Vector2(120.0, 38.0)
	shutter_button.position = Vector2(size.x * 0.5 - 47.0, size.y - 126.0)
	shutter_button.size = Vector2(94.0, 94.0)


func _layout_stamp_ui() -> void:
	var size := get_viewport().get_visible_rect().size
	stamp_seal.size = Vector2(280.0, 276.0)
	stamp_seal.pivot_offset = stamp_seal.size * 0.5
	stamp_seal.position = Vector2(
		size.x * 0.5 - stamp_seal.size.x * 0.5,
		size.y * 0.5 - stamp_seal.size.y * 0.5
	)
	stamp_label.position = Vector2(size.x * 0.5 - 220.0, size.y * 0.5 + 160.0)
	stamp_label.size = Vector2(440.0, 42.0)
	stamp_flash.position = Vector2.ZERO
	stamp_flash.size = size


func _layout_result_ui() -> void:
	var size := get_viewport().get_visible_rect().size
	result_title.position = Vector2(size.x * 0.5 - 280.0, 20.0)
	result_title.size = Vector2(560.0, 38.0)
	var available_height := size.y - 118.0
	var side := minf(available_height, size.x - 120.0)
	result_letter.size = Vector2(side, side)
	result_letter.position = Vector2(size.x * 0.5 - side * 0.5, 58.0)
	result_path_label.position = Vector2(size.x * 0.5 - 370.0, 62.0 + side)
	result_path_label.size = Vector2(740.0, 32.0)
	result_close_button.position = Vector2(size.x * 0.5 - 76.0, size.y - 48.0)
	result_close_button.size = Vector2(152.0, 38.0)


func _input(event: InputEvent) -> void:
	if not visible or flow_busy:
		return
	if name_modal.visible:
		if event is InputEventKey:
			var modal_key := event as InputEventKey
			if modal_key.pressed and modal_key.keycode == KEY_ESCAPE:
				_return_to_capture()
				get_viewport().set_input_as_handled()
		return
	if result_root.visible or not capture_root.visible:
		return
	if event is InputEventKey:
		var key := event as InputEventKey
		if not key.pressed or key.echo:
			return
		match key.keycode:
			KEY_ESCAPE:
				close_flow()
			KEY_LEFT, KEY_A:
				_pan_camera(Vector2(-1.0, 0.0))
			KEY_RIGHT, KEY_D:
				_pan_camera(Vector2(1.0, 0.0))
			KEY_UP, KEY_W:
				_pan_camera(Vector2(0.0, 1.0))
			KEY_DOWN, KEY_S:
				_pan_camera(Vector2(0.0, -1.0))
			KEY_Q:
				_adjust_capture_pitch(-CAPTURE_PITCH_STEP)
			KEY_E:
				_adjust_capture_pitch(CAPTURE_PITCH_STEP)
			KEY_EQUAL, KEY_PLUS, KEY_KP_ADD:
				_zoom_camera(CAPTURE_ZOOM_STEP)
			KEY_MINUS, KEY_KP_SUBTRACT:
				_zoom_camera(-CAPTURE_ZOOM_STEP)
			_:
				return
		get_viewport().set_input_as_handled()
		return
	if event is InputEventMagnifyGesture:
		var magnify := event as InputEventMagnifyGesture
		if _capture_drag_point_allowed(magnify.position):
			_zoom_camera((magnify.factor - 1.0) * CAPTURE_ZOOM_STEP * 4.0)
		get_viewport().set_input_as_handled()
		return
	if event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if mouse_button.button_index == MOUSE_BUTTON_WHEEL_UP and mouse_button.pressed:
			if _capture_drag_point_allowed(mouse_button.position):
				_zoom_camera(CAPTURE_ZOOM_STEP)
			get_viewport().set_input_as_handled()
			return
		if mouse_button.button_index == MOUSE_BUTTON_WHEEL_DOWN and mouse_button.pressed:
			if _capture_drag_point_allowed(mouse_button.position):
				_zoom_camera(-CAPTURE_ZOOM_STEP)
			get_viewport().set_input_as_handled()
			return
		if mouse_button.button_index == MOUSE_BUTTON_LEFT:
			if mouse_button.pressed:
				if (
					mouse_button.double_click
					and _capture_drag_point_allowed(mouse_button.position)
				):
					capture_dragging = false
					capture_drag_distance = 0.0
					_reset_capture_view()
					get_viewport().set_input_as_handled()
					return
				capture_dragging = _capture_drag_point_allowed(mouse_button.position)
				capture_drag_distance = 0.0
				if capture_dragging:
					Input.set_default_cursor_shape(Input.CURSOR_DRAG)
			else:
				capture_dragging = false
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			return
	if event is InputEventMouseMotion and capture_dragging:
		var motion := event as InputEventMouseMotion
		capture_drag_distance += motion.relative.length()
		if capture_drag_distance >= 6.0:
			if host != null:
				host.call(
					"_apply_model_orbit_delta",
					motion.relative * 0.006
				)
		get_viewport().set_input_as_handled()
		return
	if event is InputEventScreenDrag:
		var drag := event as InputEventScreenDrag
		if _capture_drag_point_allowed(drag.position):
			if host != null:
				host.call(
					"_apply_model_orbit_delta",
					drag.relative * 0.006
				)
			get_viewport().set_input_as_handled()


func _capture_drag_point_allowed(point: Vector2) -> bool:
	if capture_frame == null or not capture_frame.get_global_rect().has_point(point):
		return false
	for control in [capture_controls, cancel_button, shutter_button]:
		var ui_control := control as Control
		if ui_control != null and ui_control.get_global_rect().has_point(point):
			return false
	return true


func _pan_camera(direction: Vector2) -> void:
	if camera_3d == null:
		return
	camera_3d.h_offset = clampf(
		camera_3d.h_offset + direction.x * 0.035,
		-MAX_PAN,
		MAX_PAN
	)
	camera_3d.v_offset = clampf(
		camera_3d.v_offset + direction.y * 0.035,
		-MAX_PAN,
		MAX_PAN
	)
	_update_camera_readout()


func _zoom_camera(delta: float) -> void:
	if camera_3d == null or host == null:
		return
	var current_distance := float(host.get("camera_distance"))
	host.call("_set_3d_camera_distance", current_distance - delta)
	_update_camera_readout()


func _adjust_capture_pitch(delta: float) -> void:
	_set_capture_pitch(capture_pitch_degrees + delta)


func _set_capture_pitch(value: float) -> void:
	if camera_3d == null:
		return
	capture_pitch_degrees = clampf(
		value,
		MIN_CAPTURE_PITCH,
		MAX_CAPTURE_PITCH
	)
	var view_offset := (
		camera_saved_global_transform.origin
		- camera_saved_focus_point
	)
	if view_offset.length_squared() < 0.0001:
		_update_camera_readout()
		return
	var pitch_axis := camera_saved_global_transform.basis.x.normalized()
	if pitch_axis.length_squared() < 0.0001:
		pitch_axis = Vector3.RIGHT
	var pitch_radians := deg_to_rad(capture_pitch_degrees)
	camera_3d.global_position = (
		camera_saved_focus_point
		+ view_offset.rotated(pitch_axis, pitch_radians)
	)
	camera_3d.look_at(
		camera_saved_focus_point,
		camera_saved_up.rotated(pitch_axis, pitch_radians)
	)
	_update_camera_readout()


func _reset_capture_camera() -> void:
	if camera_3d == null:
		return
	camera_3d.fov = camera_saved_fov
	camera_3d.h_offset = camera_saved_h_offset
	camera_3d.v_offset = camera_saved_v_offset
	camera_3d.global_transform = camera_saved_global_transform
	if host != null and camera_saved_distance > 0.0:
		host.set("camera_distance", camera_saved_distance)
		host.call("_sync_camera_zoom_controls")
	capture_pitch_degrees = 0.0
	_update_camera_readout()


func _reset_capture_view() -> void:
	if host == null:
		return
	host.call("_reset_3d_view")
	camera_3d = host.get("camera_3d") as Camera3D
	_update_camera_readout()


func _update_camera_readout() -> void:
	if camera_3d == null or zoom_label == null:
		return
	var current_distance := (
		float(host.get("camera_distance"))
		if host != null
		else camera_saved_distance
	)
	var zoom := (
		camera_saved_distance / maxf(0.001, current_distance)
		if camera_saved_distance > 0.0
		else camera_saved_fov / maxf(1.0, camera_3d.fov)
	)
	zoom_label.text = "ZOOM  %.2f×" % zoom
	if pitch_label != null:
		pitch_label.text = "%+d°" % roundi(capture_pitch_degrees)


func _on_shutter_pressed() -> void:
	if flow_busy or camera_3d == null:
		return
	flow_busy = true
	capture_root.visible = false
	await get_tree().process_frame
	await RenderingServer.frame_post_draw
	var viewport_texture := get_viewport().get_texture()
	var image: Image = viewport_texture.get_image() if viewport_texture != null else null
	if image == null or image.is_empty():
		flow_busy = false
		capture_root.visible = true
		capture_hint_label.text = "没有拍到画面，请再试一次"
		return
	current_photo = _crop_to_capture_aspect(image)
	last_photo_path = _save_capture_photo(current_photo)
	flow_busy = false
	capture_root.visible = true
	name_modal.visible = true
	name_error_label.text = ""
	name_field.text = "我的星球"
	name_field.grab_focus()
	name_field.select_all()


func _crop_to_capture_aspect(source: Image) -> Image:
	if source == null or source.is_empty():
		return source
	var width := source.get_width()
	var height := source.get_height()
	var crop_width := width
	var crop_height := roundi(float(width) / CAPTURE_ASPECT)
	if crop_height > height:
		crop_height = height
		crop_width = roundi(float(height) * CAPTURE_ASPECT)
	crop_width = clampi(crop_width, 1, width)
	crop_height = clampi(crop_height, 1, height)
	var rect := Rect2i(
		roundi((width - crop_width) * 0.5),
		roundi((height - crop_height) * 0.5),
		crop_width,
		crop_height
	)
	return source.get_region(rect)


func _save_capture_photo(image: Image) -> String:
	if image == null or image.is_empty():
		return ""
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUTPUT_DIR))
	var stamp := Time.get_datetime_string_from_system(false, false)
	stamp = stamp.replace("-", "").replace(":", "").replace("T", "_").replace(" ", "_")
	var path := OUTPUT_DIR + "planet_photo_" + stamp + ".png"
	var error := image.save_png(path)
	return path if error == OK else ""


func _on_name_submitted(text_value: String) -> void:
	if flow_busy or not name_modal.visible:
		return
	current_planet_name = text_value.strip_edges()
	if current_planet_name.is_empty():
		name_error_label.text = "先给星球留一个名字吧。"
		name_field.grab_focus()
		return
	if current_planet_name.length() > 12:
		current_planet_name = current_planet_name.left(12)
	name_modal.visible = false
	call_deferred("_play_stamp_and_generate", current_planet_name)


func _return_to_capture() -> void:
	if flow_busy:
		return
	name_modal.visible = false
	capture_root.visible = true
	call_deferred("_focus_capture")


func _play_stamp_and_generate(planet_name: String) -> void:
	if flow_busy:
		return
	flow_busy = true
	capture_root.visible = false
	name_modal.visible = false
	result_root.visible = false
	stamp_root.visible = true
	stamp_label.text = "正在为「%s」盖下星球印章" % planet_name
	_layout_stamp_ui()
	stamp_seal.modulate = Color(1.0, 1.0, 1.0, 0.0)
	stamp_seal.scale = Vector2.ONE * 1.55
	stamp_seal.rotation = deg_to_rad(-14.0)
	var landing := Vector2(
		get_viewport().get_visible_rect().size.x * 0.5 - stamp_seal.size.x * 0.5,
		get_viewport().get_visible_rect().size.y * 0.5 - stamp_seal.size.y * 0.5
	)
	stamp_seal.position = landing - Vector2(0.0, 240.0)
	var drop := create_tween()
	drop.set_parallel(true)
	drop.tween_property(stamp_seal, "modulate:a", 1.0, 0.12)
	drop.tween_property(stamp_seal, "position", landing, 0.42).set_trans(
		Tween.TRANS_QUAD
	).set_ease(Tween.EASE_IN)
	drop.tween_property(stamp_seal, "scale", Vector2.ONE, 0.42).set_trans(
		Tween.TRANS_BACK
	).set_ease(Tween.EASE_OUT)
	drop.tween_property(stamp_seal, "rotation", deg_to_rad(-4.5), 0.42)
	await drop.finished
	var flash := create_tween()
	flash.tween_property(stamp_flash, "color:a", 0.32, 0.06)
	flash.tween_property(stamp_flash, "color:a", 0.0, 0.22)
	await flash.finished
	await get_tree().create_timer(0.26).timeout
	var generated_path := await _compose_letter(planet_name)
	stamp_root.visible = false
	if generated_path.is_empty() or current_letter == null:
		flow_busy = false
		capture_root.visible = true
		capture_hint_label.text = "信纸生成失败，请再拍一次"
		return
	last_letter_path = generated_path
	result_letter.texture = ImageTexture.create_from_image(current_letter)
	result_path_label.text = (
		"已保存到星球记忆 | 二维码 24 小时内可扫码下载完整信笺"
		if last_share_is_temporary
		else (
			"已保存到星球记忆 | 手机与电脑连接同一网络后可扫码查看"
			if not last_share_url.is_empty()
			else "已保存到星球记忆 | 可以收下这张信纸了"
		)
	)
	result_root.visible = true
	_layout_result_ui()
	flow_busy = false
	letter_saved.emit(last_letter_path)


func _compose_letter(planet_name: String) -> String:
	if current_photo == null or current_photo.is_empty():
		return ""
	if letter_viewport != null and is_instance_valid(letter_viewport):
		letter_viewport.queue_free()
	letter_viewport = SubViewport.new()
	letter_viewport.name = "PlanetLetterCompositor"
	letter_viewport.size = LETTER_SIZE
	letter_viewport.disable_3d = true
	letter_viewport.transparent_bg = false
	letter_viewport.gui_disable_input = true
	letter_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	add_child(letter_viewport)

	var canvas := Control.new()
	canvas.name = "LetterCanvas"
	canvas.size = Vector2(LETTER_SIZE)
	canvas.mouse_filter = Control.MOUSE_FILTER_IGNORE
	letter_viewport.add_child(canvas)

	var background := TextureRect.new()
	background.texture = load(LETTER_BACKDROP_PATH) as Texture2D
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(background)

	var photo_card := Control.new()
	photo_card.position = Vector2(370.0, 869.0)
	photo_card.size = Vector2(700.0, 498.0)
	photo_card.pivot_offset = photo_card.size * 0.5
	photo_card.rotation = deg_to_rad(-1.8)
	photo_card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(photo_card)
	var frame := TextureRect.new()
	frame.texture = _make_photo_card_texture()
	frame.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	frame.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	frame.stretch_mode = TextureRect.STRETCH_SCALE
	frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	photo_card.add_child(frame)

	var seal := TextureRect.new()
	seal.texture = load(WAX_SEAL_PATH) as Texture2D
	seal.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	seal.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	seal.position = Vector2(290.0, 143.0)
	seal.size = Vector2(190.0, 190.0)
	seal.pivot_offset = seal.size * 0.5
	seal.rotation = deg_to_rad(-4.5)
	seal.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(seal)

	var postage := TextureRect.new()
	postage.texture = load(POSTAGE_STAMP_PATH) as Texture2D
	postage.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	postage.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	postage.position = Vector2(1120.0, 112.0)
	postage.size = Vector2(178.0, 224.0)
	postage.pivot_offset = postage.size * 0.5
	postage.rotation = deg_to_rad(5.5)
	postage.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(postage)

	last_letter_copy = _build_letter_copy()
	var classification := String(last_letter_copy.get("classification", "温柔星球"))
	var narrative := String(last_letter_copy.get("narrative", ""))
	var action_summary := String(last_letter_copy.get("action", ""))
	var echo_summary := String(last_letter_copy.get("echo", ""))
	last_share_url = ""
	last_share_is_temporary = false
	var title_font := load(TITLE_FONT_PATH) as Font
	var body_font := _make_body_font()
	_add_letter_label(
		canvas,
		planet_name,
		Vector2(276.0, 206.0),
		Vector2(896.0, 100.0),
		60,
		Color(0.46, 0.19, 0.15, 1.0),
		title_font,
		HORIZONTAL_ALIGNMENT_CENTER
	)
	_add_letter_label(
		canvas,
		classification,
		Vector2(304.0, 332.0),
		Vector2(840.0, 60.0),
		34,
		Color(0.27, 0.40, 0.25, 1.0),
		body_font,
		HORIZONTAL_ALIGNMENT_CENTER
	)
	var body_line_height := maxf(
		1.0,
		roundf(body_font.get_height(26))
	)
	var label_line_height := maxf(
		1.0,
		roundf(body_font.get_height(24))
	)
	var letter_y := 405.0
	var narrative_label := _add_letter_label(
		canvas,
		narrative,
		Vector2(340.0, letter_y),
		Vector2(760.0, 180.0),
		26,
		Color(0.29, 0.20, 0.14, 1.0),
		body_font
	)
	letter_y += (
		maxi(1, narrative_label.get_line_count())
		* body_line_height
		+ body_line_height
	)
	_add_letter_label(
		canvas,
		"星球手记",
		Vector2(340.0, letter_y),
		Vector2(760.0, label_line_height),
		24,
		Color(0.59, 0.42, 0.20, 1.0),
		body_font
	)
	letter_y += label_line_height
	var action_label := _add_letter_label(
		canvas,
		action_summary,
		Vector2(340.0, letter_y),
		Vector2(760.0, 220.0),
		26,
		Color(0.29, 0.20, 0.14, 1.0),
		body_font
	)
	letter_y += (
		maxi(1, action_label.get_line_count())
		* body_line_height
		+ body_line_height
	)
	_add_letter_label(
		canvas,
		"此刻的星球",
		Vector2(340.0, letter_y),
		Vector2(760.0, label_line_height),
		24,
		Color(0.59, 0.42, 0.20, 1.0),
		body_font
	)
	letter_y += label_line_height
	_add_letter_label(
		canvas,
		echo_summary,
		Vector2(340.0, letter_y),
		Vector2(760.0, 210.0),
		26,
		Color(0.29, 0.20, 0.14, 1.0),
		body_font
	)

	await get_tree().process_frame
	await RenderingServer.frame_post_draw
	var rendered := letter_viewport.get_texture()
	current_letter = rendered.get_image() if rendered != null else null
	if current_letter == null or current_letter.is_empty():
		return ""
	last_share_url = await _upload_letter_image(current_letter)
	last_share_is_temporary = not last_share_url.is_empty()
	if (
		last_share_url.is_empty()
		and not OS.has_feature("web")
		and planet_memory_share != null
		and planet_memory_share.is_running()
	):
		var share_id: String = planet_memory_share.create_memory(
			planet_name,
			classification,
			narrative,
			action_summary,
			echo_summary
		)
		last_share_url = planet_memory_share.get_share_url(share_id)
		if not last_share_url.is_empty():
			planet_memory_share.attach_image(share_id, current_letter)
	if not last_share_url.is_empty():
		_add_letter_qr(canvas, last_share_url)
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
		current_letter = rendered.get_image() if rendered != null else null
		if current_letter == null or current_letter.is_empty():
			return ""
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUTPUT_DIR))
	var stamp_text := Time.get_datetime_string_from_system(false, false)
	stamp_text = (
		stamp_text
		.replace("-", "")
		.replace(":", "")
		.replace("T", "_")
		.replace(" ", "_")
	)
	var path := OUTPUT_DIR + "planet_letter_" + stamp_text + ".png"
	var error := current_letter.save_png(path)
	return path if error == OK else ""


func _make_photo_card_texture() -> Texture2D:
	var frame_texture := load(PHOTO_FRAME_PATH) as Texture2D
	if frame_texture == null:
		return null
	var frame_image := frame_texture.get_image()
	if frame_image == null or frame_image.is_empty():
		return frame_texture
	frame_image = frame_image.duplicate()
	var photo_image := current_photo.duplicate()
	photo_image.resize(607, 381, Image.INTERPOLATE_LANCZOS)
	frame_image.blit_rect(
		photo_image,
		Rect2i(0, 0, 607, 381),
		Vector2i(115, 111)
	)
	var overlay_image := frame_texture.get_image()
	frame_image.blend_rect(
		overlay_image,
		Rect2i(0, 0, overlay_image.get_width(), overlay_image.get_height()),
		Vector2i.ZERO
	)
	return ImageTexture.create_from_image(frame_image)


func _add_letter_label(
	parent: Control,
	text_value: String,
	position_value: Vector2,
	size_value: Vector2,
	font_size: int,
	color: Color,
	font: Font,
	alignment := HORIZONTAL_ALIGNMENT_LEFT
) -> Label:
	var label := Label.new()
	parent.add_child(label)
	label.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	label.clip_text = true
	label.text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING
	label.custom_minimum_size = Vector2.ZERO
	label.horizontal_alignment = alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	if font != null:
		label.add_theme_font_override("font", font)
	label.text = text_value
	label.position = position_value
	label.size = size_value
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return label


func _make_body_font() -> Font:
	return load(TITLE_FONT_PATH) as Font


func _build_letter_copy() -> Dictionary:
	var records := _visible_player_records()
	var counts: Dictionary = {}
	var labels: Dictionary = {}
	for record in records:
		var kind := String(record.get("kind", ""))
		if kind.is_empty() or _is_player_character(kind):
			continue
		counts[kind] = int(counts.get(kind, 0)) + 1
		labels[kind] = _clean_item_label(record)

	var scores := _classification_scores(counts)
	var ranked: Array[String] = ["温柔", "自在", "自信", "守护", "勇敢", "好奇"]
	ranked.sort_custom(
		func(left: String, right: String) -> bool:
			return float(scores.get(left, 0.0)) > float(scores.get(right, 0.0))
	)
	var primary := ranked[0]
	var top_score := float(scores.get(primary, 0.0))
	var secondary := ""
	if (
		ranked.size() > 1
		and float(scores.get(ranked[1], 0.0)) >= maxf(1.0, top_score * 0.52)
	):
		secondary = ranked[1]
	var classification := primary + "星球"
	if not secondary.is_empty():
		classification = "%s | %s星球" % [primary, secondary]

	var narrative := String(
		CLASS_NARRATIVES.get(
			primary,
			"你把一路收集来的东西放进这里，让这颗星球慢慢有了自己的样子。"
		)
	)
	return {
		"classification": classification,
		"narrative": narrative,
		"action": _player_action_summary(counts, labels),
		"echo": _layout_echo(records),
	}


func _visible_player_records() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	if host == null:
		return result
	var raw_records = host.get("editable_3d_objects")
	if typeof(raw_records) != TYPE_ARRAY:
		return result
	for value in raw_records:
		if typeof(value) != TYPE_DICTIONARY:
			continue
		var record: Dictionary = value
		var node := record.get("node") as Node3D
		if node == null or not is_instance_valid(node) or not node.visible:
			continue
		result.append(record)
	return result


func _is_player_character(kind: String) -> bool:
	return kind in [
		"player_prince",
		"player_long_hair_person",
		"player_short_hair_person",
	]


func _clean_item_label(record: Dictionary) -> String:
	var label := String(record.get("label", "")).strip_edges()
	if label.is_empty():
		label = String(record.get("kind", "小物件"))
	label = label.trim_suffix(" 副本")
	return label


func _classification_scores(counts: Dictionary) -> Dictionary:
	var scores := {
		"温柔": 0.0,
		"自在": 0.0,
		"自信": 0.0,
		"守护": 0.0,
		"勇敢": 0.0,
		"好奇": 0.0,
	}
	for kind_value in counts.keys():
		var kind := String(kind_value)
		var weight := float(counts[kind_value])
		var item_scores := _item_style_scores(kind)
		for class_value in item_scores.keys():
			var style_name := String(class_value)
			scores[style_name] = (
				float(scores.get(style_name, 0.0))
				+ float(item_scores[class_value]) * weight
			)
	return scores


func _item_style_scores(kind: String) -> Dictionary:
	match kind:
		"player_cottage":
			return {"温柔": 2.0, "守护": 3.0}
		"player_tent":
			return {"勇敢": 2.0, "自在": 1.5}
		"player_long_table":
			return {"温柔": 2.0, "自在": 1.0}
		"player_picnic_blanket":
			return {"自在": 2.0, "温柔": 1.0}
		"player_bench":
			return {"自在": 2.0, "温柔": 1.0}
		"player_swing":
			return {"勇敢": 2.0, "自在": 1.5}
		"player_tea_set":
			return {"温柔": 2.0, "自在": 1.0}
		"player_picnic_basket":
			return {"自在": 2.0, "温柔": 1.0}
		"player_flowers", "player_vase":
			return {"温柔": 2.0, "自在": 1.0}
		"player_open_book":
			return {"好奇": 2.0, "温柔": 1.0}
		"player_mailbox":
			return {"守护": 2.0, "温柔": 1.0}
		"player_paper_boat":
			return {"勇敢": 2.0, "好奇": 1.0}
		"player_star_rose_combo":
			return {"温柔": 2.0, "守护": 1.0}
		"player_star_king_throne", "player_star_king_banner":
			return {"自信": 2.0, "勇敢": 1.0}
		"player_star_vain_mirror":
			return {"自信": 2.0, "好奇": 1.0}
		"player_star_merchant_ledger":
			return {"好奇": 2.0, "自信": 1.0}
		"player_star_earth_fox", "player_star_earth_wheat_bundle":
			return {"温柔": 1.0, "好奇": 1.0}
		"player_star_pointlighter_lamp":
			return {"守护": 2.0, "温柔": 1.0}
		"player_star_pointlighter_chair":
			return {"温柔": 1.0, "守护": 1.0}
	if kind.contains("lamp"):
		return {"守护": 1.5, "温柔": 1.0}
	if kind.contains("grass") or kind.contains("tree"):
		return {"自在": 0.5}
	return {}


func _player_action_summary(counts: Dictionary, labels: Dictionary) -> String:
	var structures := _summary_labels_for_kinds(
		counts,
		labels,
		[
			"player_cottage",
			"player_tent",
			"player_long_table",
			"player_picnic_blanket",
			"player_bench",
		],
		4
	)
	var details := _summary_labels_for_kinds(
		counts,
		labels,
		[
			"player_swing",
			"player_tea_set",
			"player_picnic_basket",
			"player_open_book",
			"player_vase",
			"player_flowers",
			"player_mailbox",
			"player_paper_boat",
			"player_camping_lamp",
		],
		4
	)
	var memory_items := _summary_labels_for_kinds(
		counts,
		labels,
		[
			"player_star_rose_combo",
			"player_star_earth_fox",
			"player_star_earth_wheat_bundle",
			"player_star_vain_mirror",
			"player_star_merchant_ledger",
			"player_star_pointlighter_lamp",
			"player_star_pointlighter_chair",
			"player_star_king_throne",
			"player_star_king_banner",
		],
		4
	)
	var scene_sentence := ""
	if not structures.is_empty():
		scene_sentence = "你搭起" + _join_chinese(structures)
		if not details.is_empty():
			scene_sentence += "，又把" + _join_chinese(details) + "留在周围"
	elif not details.is_empty():
		scene_sentence = "你把" + _join_chinese(details) + "摆成了喜欢的样子"
	else:
		scene_sentence = "你把这一小块宇宙留成了自己的房间"
	var light_strings = host.get("player_light_strings") if host != null else []
	if typeof(light_strings) == TYPE_ARRAY and not (light_strings as Array).is_empty():
		scene_sentence += "，还让几道灯串从头顶轻轻垂过"
	scene_sentence += "。"

	var action_parts: Array[String] = []
	if not memory_items.is_empty():
		action_parts.append(
			_join_chinese(memory_items) + "也从旅途中来到了这里"
		)
	var interaction := _expression_exchange_summary()
	if not interaction.is_empty():
		action_parts.append(interaction)
	if host != null and bool(host.get("player_handhold_active")):
		action_parts.append("你们牵着手，让这一页停在一起")
	if action_parts.is_empty():
		action_parts.append("每件喜欢的东西，都在这颗星球上找到了自己的位置")
	var action_sentence := "；".join(PackedStringArray(action_parts)) + "。"
	return scene_sentence + action_sentence


func _summary_labels_for_kinds(
	counts: Dictionary,
	labels: Dictionary,
	kinds: Array,
	limit: int
) -> Array[String]:
	var result: Array[String] = []
	for kind_value in kinds:
		var kind := String(kind_value)
		if not counts.has(kind):
			continue
		result.append(String(labels.get(kind, "小物件")))
		if result.size() >= limit:
			break
	return result


func _join_chinese(items: Array[String]) -> String:
	if items.is_empty():
		return ""
	if items.size() == 1:
		return items[0]
	if items.size() == 2:
		return items[0] + "和" + items[1]
	var head := PackedStringArray()
	for index in items.size() - 1:
		head.append(items[index])
	return "、".join(head) + "和" + items[items.size() - 1]


func _expression_exchange_summary() -> String:
	if host == null:
		return ""
	var history = host.get("player_expression_history")
	var names: Array[String] = []
	if typeof(history) == TYPE_ARRAY:
		for value in history:
			if typeof(value) != TYPE_DICTIONARY:
				continue
			var event: Dictionary = value
			var name := String(EXPRESSION_LABELS.get(
				String(event.get("sent", "")),
				""
			))
			if name.is_empty() or name in names:
				continue
			names.insert(0, name)
			if names.size() >= 3:
				break
	if names.is_empty():
		var sent := String(host.get("player_expression_last_sent"))
		var reply := String(host.get("player_expression_last_reply"))
		var sent_label := String(EXPRESSION_LABELS.get(sent, ""))
		var reply_label := String(PRINCE_REPLY_LABELS.get(reply, ""))
		if sent_label.is_empty():
			return ""
		if reply_label.is_empty():
			return "你向小王子发了“%s”" % sent_label
		return "你向小王子%s，他用%s回应了你" % [sent_label, reply_label]
	if names.size() == 1:
		return "你向小王子%s，他也回应了你" % names[0]
	return "你和小王子交换过" + _join_chinese(names)


func _layout_echo(records: Array[Dictionary]) -> String:
	if records.is_empty():
		return "星球安静地留在夜色里，像一个还没有写完却已经很温柔的句子。"
	var leader := _active_player_record(records)
	var prince := _record_by_kind(records, "player_prince")
	var clauses: Array[String] = []
	var focus_point := Vector3.ZERO
	if not leader.is_empty() and not prince.is_empty():
		var leader_position: Vector3 = leader.get("position", Vector3.ZERO)
		var prince_position: Vector3 = prince.get("position", Vector3.ZERO)
		focus_point = (leader_position + prince_position) * 0.5
		var distance := leader_position.distance_to(prince_position)
		var leader_seated := String(leader.get("seat_state", "")) == "seated"
		var prince_seated := String(prince.get("seat_state", "")) == "seated"
		if leader_seated and prince_seated:
			var leader_support := String(leader.get("placement_support_id", ""))
			var prince_support := String(prince.get("placement_support_id", ""))
			if (
				not leader_support.is_empty()
				and leader_support == prince_support
			):
				clauses.append("你和小王子靠着同一处坐下来")
			else:
				clauses.append("你和小王子各自坐了下来")
		elif distance < 0.55:
			clauses.append("你和小王子靠得很近")
		elif distance < 1.10:
			clauses.append("你和小王子相隔不远")
		else:
			clauses.append("你和小王子之间留出了一点距离")
	elif not leader.is_empty():
		focus_point = leader.get("position", Vector3.ZERO) as Vector3
		clauses.append("你站在自己的星球中央")

	var nearby := _nearest_summary_items(records, focus_point, 2)
	if not nearby.is_empty():
		clauses.append("近旁是" + _join_chinese(nearby))
	var night := host != null and float(host.get("player_day_night_target")) < 0.5
	var light_label := _nearest_light_label(records, focus_point)
	var landmark := ""
	if _contains_record_kind(records, "player_paper_boat") and "纸船" not in nearby:
		landmark = "纸船停在河岸"
	elif (
		_contains_record_kind(records, "player_star_rose_combo")
		and "玫瑰 | 底座 | 玻璃罩" not in nearby
	):
		landmark = "玫瑰在玻璃罩里静静亮着"
	if night and not light_label.is_empty():
		var atmosphere := "夜色里，%s把一小圈暖光留在脚边" % light_label
		if not landmark.is_empty():
			atmosphere += "，" + landmark
		atmosphere += "，远处的瀑布把夜色轻轻带下去"
		clauses.append(atmosphere)
	elif night:
		var atmosphere := "夜色落在树梢和河面上，星球安静地亮着"
		if not landmark.is_empty():
			atmosphere += "，" + landmark
		atmosphere += "，远处的瀑布把夜色轻轻带下去"
		clauses.append(atmosphere)
	else:
		var atmosphere := "白昼的光沿着草地和树林铺开，星球安静地醒着"
		if not landmark.is_empty():
			atmosphere += "，" + landmark
		atmosphere += "，远处的瀑布把风声带向远方"
		clauses.append(atmosphere)
	return "。".join(PackedStringArray(clauses)) + "。"


func _contains_record_kind(records: Array[Dictionary], kind: String) -> bool:
	for record in records:
		if String(record.get("kind", "")) == kind:
			return true
	return false


func _active_player_record(records: Array[Dictionary]) -> Dictionary:
	var active_id := String(host.get("active_player_character_id")) if host != null else ""
	for record in records:
		if String(record.get("id", "")) == active_id:
			return record
	for kind in [
		"player_long_hair_person",
		"player_short_hair_person",
	]:
		var found := _record_by_kind(records, kind)
		if not found.is_empty():
			return found
	return {}


func _record_by_kind(records: Array[Dictionary], kind: String) -> Dictionary:
	for record in records:
		if String(record.get("kind", "")) == kind:
			return record
	return {}


func _nearest_summary_items(
	records: Array[Dictionary],
	point: Vector3,
	limit: int
) -> Array[String]:
	var candidates: Array[Dictionary] = []
	for record in records:
		var kind := String(record.get("kind", ""))
		if _is_player_character(kind):
			continue
		var label := _clean_item_label(record)
		if (
			label.is_empty()
			or label.contains("草丛")
			or label.contains("圆冠树")
			or label.contains("针叶树")
		):
			continue
		var position: Vector3 = record.get("position", Vector3.ZERO)
		candidates.append({
			"label": label,
			"distance": point.distance_to(position),
		})
	candidates.sort_custom(
		func(left: Dictionary, right: Dictionary) -> bool:
			return float(left.distance) < float(right.distance)
	)
	var result: Array[String] = []
	for candidate in candidates:
		var label := String(candidate.get("label", ""))
		if label.is_empty() or label in result:
			continue
		result.append(label)
		if result.size() >= limit:
			break
	return result


func _nearest_light_label(records: Array[Dictionary], point: Vector3) -> String:
	var best_label := ""
	var best_distance := INF
	for record in records:
		if not bool(record.get("light_on", false)):
			continue
		var distance := point.distance_to(
			record.get("position", Vector3.ZERO) as Vector3
		)
		if distance >= best_distance:
			continue
		best_distance = distance
		best_label = _clean_item_label(record)
	return best_label


func _upload_letter_image(image: Image) -> String:
	if image == null or image.is_empty():
		return ""
	var png := image.save_png_to_buffer()
	if png.is_empty():
		return ""
	var boundary := "----LittlePrinceLetter%d" % Time.get_ticks_usec()
	var body := PackedByteArray()
	var multipart_header := (
		"--%s\r\n"
		+ "Content-Disposition: form-data; name=\"expire\"\r\n\r\n"
		+ "%d\r\n"
		+ "--%s\r\n"
		+ "Content-Disposition: form-data; name=\"file\"; filename=\"planet-letter.png\"\r\n"
		+ "Content-Type: image/png\r\n\r\n"
	) % [boundary, SHARE_EXPIRE_SECONDS, boundary]
	body.append_array(
		multipart_header.to_utf8_buffer()
	)
	body.append_array(png)
	body.append_array(("\r\n--%s--\r\n" % boundary).to_utf8_buffer())

	var request := HTTPRequest.new()
	request.timeout = 35.0
	_configure_upload_proxy(request)
	add_child(request)
	var request_error := request.request_raw(
		SHARE_UPLOAD_URL,
		PackedStringArray([
			"Content-Type: multipart/form-data; boundary=%s" % boundary,
			"Accept: application/json",
		]),
		HTTPClient.METHOD_POST,
		body
	)
	if request_error != OK:
		push_warning("Letter share upload request failed: " + error_string(request_error))
		request.queue_free()
		return ""
	var response: Array = await request.request_completed
	request.queue_free()
	if response.size() < 4 or int(response[0]) != HTTPRequest.RESULT_SUCCESS:
		push_warning("Letter share upload transport failed: " + str(response))
		return ""
	var response_code := int(response[1])
	if response_code < 200 or response_code >= 300:
		push_warning("Letter share upload HTTP status: " + str(response_code))
		return ""
	var response_body := response[3] as PackedByteArray
	var parsed = JSON.parse_string(response_body.get_string_from_utf8())
	if typeof(parsed) != TYPE_DICTIONARY:
		return ""
	var parsed_dictionary := parsed as Dictionary
	if String(parsed_dictionary.get("status", "")) != "success":
		return ""
	var data = parsed_dictionary.get("data", {})
	if typeof(data) != TYPE_DICTIONARY:
		return ""
	return String((data as Dictionary).get("url", ""))


func _configure_upload_proxy(request: HTTPRequest) -> void:
	var proxy_value := OS.get_environment("LITTLE_PRINCE_HTTPS_PROXY").strip_edges()
	if proxy_value.is_empty():
		return
	var proxy_host := proxy_value
	var proxy_port := 8080
	if proxy_host.begins_with("http://"):
		proxy_host = proxy_host.trim_prefix("http://")
	var separator := proxy_host.rfind(":")
	if separator > 0:
		proxy_port = int(proxy_host.substr(separator + 1))
		proxy_host = proxy_host.substr(0, separator)
	request.set_https_proxy(proxy_host, proxy_port)


func _add_letter_qr(canvas: Control, share_url: String) -> void:
	var qr_texture := _make_planet_qr(share_url)
	if qr_texture == null:
		return
	var plaque := TextureRect.new()
	plaque.texture = load(QR_PLAQUE_PATH) as Texture2D
	plaque.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	plaque.stretch_mode = TextureRect.STRETCH_SCALE
	plaque.position = Vector2(1106.0, 1165.0)
	plaque.size = Vector2(176.0, 184.0)
	plaque.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(plaque)
	var qr_image := TextureRect.new()
	qr_image.texture = qr_texture
	qr_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	qr_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	qr_image.position = Vector2(17.0, 17.0)
	qr_image.size = Vector2(142.0, 142.0)
	qr_image.mouse_filter = Control.MOUSE_FILTER_IGNORE
	plaque.add_child(qr_image)


func _make_planet_qr(share_url: String) -> Texture2D:
	if share_url.is_empty():
		return null
	var qr_data = QR.generate(share_url, {
		"errorCorrectionLevel": "M",
		"margin": 4,
	})
	if QR.is_error(qr_data):
		push_warning("Planet QR could not be generated: " + String(qr_data.get("message", "")))
		return null
	var qr_image = QR.to_image(qr_data, {
		"margin": 4,
		"scale": 4,
		"foreground": "#37261d",
		"background": "#f4e7c6",
	})
	if QR.is_error(qr_image):
		push_warning("Planet QR image could not be rendered: " + String(qr_image.get("message", "")))
		return null
	return ImageTexture.create_from_image(qr_image as Image)
