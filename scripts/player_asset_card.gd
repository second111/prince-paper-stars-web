extends PanelContainer

signal asset_drag_started(asset_index: int, screen_position: Vector2)
signal asset_drag_moved(asset_index: int, screen_position: Vector2)
signal asset_drag_ended(asset_index: int, screen_position: Vector2)

const CARD_SIZE := Vector2(150.0, 126.0)
const PREVIEW_SIZE := Vector2(132.0, 92.0)

var asset_index := -1
var asset_label := ""
var _thumbnail: TextureRect
var _placeholder: Label
var _left_down := false
var _drag_active := false
var _press_position := Vector2.ZERO


func _ready() -> void:
	custom_minimum_size = CARD_SIZE
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	tooltip_text = "按住缩略图，拖到星球表面即可摆放"
	clip_contents = true
	set_process_input(false)

	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.055, 0.075, 0.085, 0.82)
	style.border_color = Color(0.83, 0.72, 0.48, 0.38)
	style.set_border_width_all(1)
	style.set_corner_radius_all(7)
	add_theme_stylebox_override("panel", style)

	var margin := MarginContainer.new()
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.add_theme_constant_override("margin_left", 8)
	margin.add_theme_constant_override("margin_right", 8)
	margin.add_theme_constant_override("margin_top", 7)
	margin.add_theme_constant_override("margin_bottom", 6)
	add_child(margin)

	var column := VBoxContainer.new()
	column.mouse_filter = Control.MOUSE_FILTER_IGNORE
	column.add_theme_constant_override("separation", 4)
	margin.add_child(column)

	var preview_frame := PanelContainer.new()
	preview_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview_frame.custom_minimum_size = PREVIEW_SIZE
	var frame_style := StyleBoxFlat.new()
	frame_style.bg_color = Color(0.92, 0.90, 0.83, 0.08)
	frame_style.set_corner_radius_all(5)
	preview_frame.add_theme_stylebox_override("panel", frame_style)
	column.add_child(preview_frame)

	var preview_stack := Control.new()
	preview_stack.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview_stack.custom_minimum_size = PREVIEW_SIZE
	preview_frame.add_child(preview_stack)

	_thumbnail = TextureRect.new()
	_thumbnail.name = "ModelThumbnail"
	_thumbnail.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_thumbnail.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_thumbnail.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_thumbnail.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview_stack.add_child(_thumbnail)

	_placeholder = Label.new()
	_placeholder.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_placeholder.text = "预览载入中"
	_placeholder.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_placeholder.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_placeholder.add_theme_font_size_override("font_size", 16)
	_placeholder.add_theme_color_override("font_color", Color(0.82, 0.80, 0.73, 0.68))
	_placeholder.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	preview_stack.add_child(_placeholder)

	var title := Label.new()
	title.name = "ModelName"
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	title.text = asset_label
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	title.custom_minimum_size = Vector2(0.0, 20.0)
	title.add_theme_font_size_override("font_size", 16)
	title.add_theme_color_override("font_color", Color(0.98, 0.93, 0.83, 0.96))
	column.add_child(title)


func configure(index: int, label_text: String) -> void:
	asset_index = index
	asset_label = label_text
	name = "PlayerAssetCard_%02d" % index
	if is_node_ready():
		var title := get_node_or_null("MarginContainer/VBoxContainer/ModelName") as Label
		if title == null:
			title = find_child("ModelName", true, false) as Label
		if title != null:
			title.text = label_text


func set_thumbnail(texture: Texture2D) -> void:
	if texture == null:
		return
	if _thumbnail == null:
		_thumbnail = find_child("ModelThumbnail", true, false) as TextureRect
	if _placeholder == null:
		_placeholder = find_child("预览载入中", true, false) as Label
	if _thumbnail != null:
		_thumbnail.texture = texture
	if _placeholder != null:
		_placeholder.visible = false


func _gui_input(event: InputEvent) -> void:
	if (
		event is InputEventMouseButton
		and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
		and (event as InputEventMouseButton).pressed
	):
		_left_down = true
		_drag_active = false
		_press_position = get_viewport().get_mouse_position()
		set_process_input(true)
		accept_event()


func _input(event: InputEvent) -> void:
	if not _left_down:
		return
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		if not _drag_active:
			if motion.position.distance_to(_press_position) < 6.0:
				return
			_drag_active = true
			asset_drag_started.emit(asset_index, motion.position)
		asset_drag_moved.emit(asset_index, motion.position)
		get_viewport().set_input_as_handled()
	elif (
		event is InputEventMouseButton
		and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
		and not (event as InputEventMouseButton).pressed
	):
		var release_position := get_viewport().get_mouse_position()
		if _drag_active:
			asset_drag_ended.emit(asset_index, release_position)
			get_viewport().set_input_as_handled()
		_left_down = false
		_drag_active = false
		set_process_input(false)
