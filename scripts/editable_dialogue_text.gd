extends Control

signal selection_requested(slot_index: int)
signal layout_changed(slot_index: int)

const HANDLE_SIZE := 16.0
const MIN_TEXT_BOX_SIZE := Vector2(80.0, 24.0)

var slot_index := 0
var edit_mode := false
var selected := false
var text_label: Label

var _drag_mode := 0
var _drag_start_mouse := Vector2.ZERO
var _drag_start_position := Vector2.ZERO
var _drag_start_size := Vector2.ZERO


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	mouse_default_cursor_shape = Control.CURSOR_ARROW
	clip_contents = false

	text_label = Label.new()
	text_label.name = "Text"
	text_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	text_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(text_label)


func configure(
	text: String,
	font: Font,
	box_rect: Rect2,
	font_size: int
) -> void:
	position = box_rect.position
	size = box_rect.size.max(MIN_TEXT_BOX_SIZE)
	text_label.text = text
	text_label.add_theme_font_size_override("font_size", font_size)
	text_label.add_theme_color_override("font_color", Color(0.30, 0.20, 0.13, 1.0))
	if font != null:
		text_label.add_theme_font_override("font", font)
	queue_redraw()


func set_edit_mode(enabled: bool) -> void:
	edit_mode = enabled
	_drag_mode = 0
	mouse_filter = Control.MOUSE_FILTER_STOP if edit_mode else Control.MOUSE_FILTER_IGNORE
	mouse_default_cursor_shape = (
		Control.CURSOR_MOVE if edit_mode else Control.CURSOR_ARROW
	)
	queue_redraw()


func set_selected(value: bool) -> void:
	selected = value
	queue_redraw()


func set_font_size(value: int) -> void:
	text_label.add_theme_font_size_override("font_size", value)
	queue_redraw()
	layout_changed.emit(slot_index)


func set_horizontal_alignment(value: int) -> void:
	text_label.horizontal_alignment = clampi(
		value,
		HORIZONTAL_ALIGNMENT_LEFT,
		HORIZONTAL_ALIGNMENT_RIGHT
	)
	queue_redraw()
	layout_changed.emit(slot_index)


func set_vertical_alignment(value: int) -> void:
	text_label.vertical_alignment = clampi(
		value,
		VERTICAL_ALIGNMENT_TOP,
		VERTICAL_ALIGNMENT_BOTTOM
	)
	queue_redraw()
	layout_changed.emit(slot_index)


func set_line_spacing(value: int) -> void:
	text_label.add_theme_constant_override("line_spacing", value)
	queue_redraw()
	layout_changed.emit(slot_index)


func required_text_height() -> float:
	if text_label == null:
		return size.y
	var font := text_label.get_theme_font("font")
	var font_size := text_label.get_theme_font_size("font_size")
	if font == null:
		return size.y
	var measured := font.get_multiline_string_size(
		text_label.text,
		HORIZONTAL_ALIGNMENT_LEFT,
		maxf(1.0, size.x),
		font_size
	)
	var estimated_lines := maxi(
		1,
		roundi(measured.y / maxf(1.0, font.get_height(font_size)))
	)
	var line_spacing := float(
		text_label.get_theme_constant("line_spacing")
	)
	return maxf(
		size.y,
		ceilf(
			measured.y
			+ maxf(0.0, float(estimated_lines - 1) * line_spacing)
			+ 10.0
		)
	)


func _gui_input(event: InputEvent) -> void:
	if not edit_mode:
		return
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		mouse_default_cursor_shape = (
			Control.CURSOR_FDIAGSIZE
			if _is_resize_handle(motion.position)
			else Control.CURSOR_MOVE
		)
		return
	if event is not InputEventMouseButton:
		return
	var mouse_button := event as InputEventMouseButton
	if mouse_button.button_index != MOUSE_BUTTON_LEFT:
		return
	if mouse_button.pressed:
		selection_requested.emit(slot_index)
		_drag_start_mouse = get_global_mouse_position()
		_drag_start_position = position
		_drag_start_size = size
		_drag_mode = 2 if _is_resize_handle(mouse_button.position) else 1
		mouse_default_cursor_shape = (
			Control.CURSOR_FDIAGSIZE if _drag_mode == 2 else Control.CURSOR_MOVE
		)
		accept_event()


func _input(event: InputEvent) -> void:
	if not edit_mode or _drag_mode == 0:
		return
	if event is InputEventMouseMotion:
		var delta := get_global_mouse_position() - _drag_start_mouse
		if _drag_mode == 1:
			position = _drag_start_position + delta
		else:
			size = (_drag_start_size + delta).max(MIN_TEXT_BOX_SIZE)
		layout_changed.emit(slot_index)
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if (
			mouse_button.button_index == MOUSE_BUTTON_LEFT
			and not mouse_button.pressed
		):
			_drag_mode = 0
			mouse_default_cursor_shape = Control.CURSOR_MOVE
			layout_changed.emit(slot_index)
			get_viewport().set_input_as_handled()


func _is_resize_handle(local_mouse: Vector2) -> bool:
	var handle_rect := Rect2(
		size - Vector2(HANDLE_SIZE, HANDLE_SIZE),
		Vector2(HANDLE_SIZE, HANDLE_SIZE)
	)
	return handle_rect.has_point(local_mouse)


func _draw() -> void:
	if not edit_mode:
		return
	var outline_color := (
		Color(0.98, 0.65, 0.20, 1.0)
		if selected
		else Color(0.94, 0.81, 0.54, 0.82)
	)
	draw_rect(Rect2(Vector2.ZERO, size), outline_color, false, 1.5)
	var handle_pos := size - Vector2(HANDLE_SIZE, HANDLE_SIZE)
	draw_rect(
		Rect2(handle_pos, Vector2(HANDLE_SIZE, HANDLE_SIZE)),
		Color(0.98, 0.65, 0.20, 0.74 if selected else 0.38)
	)
	draw_line(
		handle_pos + Vector2(4.0, HANDLE_SIZE - 3.0),
		handle_pos + Vector2(HANDLE_SIZE - 3.0, 4.0),
		Color(0.26, 0.13, 0.06, 0.92),
		1.2,
		true
	)
