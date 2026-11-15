extends CanvasLayer

const STAR_TEXTURE := preload("res://assets/ui/cursor/falling_star.png")
const TRAIL_SCRIPT := preload("res://scripts/cursor_trail.gd")
const HALO_SCRIPT := preload("res://scripts/cursor_halo.gd")
const STAR_SIZE := 54.0
const TRAIL_POINT_SPACING := 0.45
const TRAIL_TELEPORT_DISTANCE := 140.0

var _star: TextureRect
var _trail: Node2D
var _halo: Node2D
var _last_mouse_position := Vector2(-10000.0, -10000.0)
var _tracking := false


func _ready() -> void:
	layer = 4096
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_cursor()
	var window := get_window()
	window.focus_entered.connect(_on_window_focus_entered)
	window.focus_exited.connect(_on_window_focus_exited)
	_set_tracking(true)


func _process(_delta: float) -> void:
	if not _tracking or _star == null:
		return
	var mouse_position := get_viewport().get_mouse_position()
	_star.position = (mouse_position - Vector2.ONE * STAR_SIZE * 0.5).round()
	_halo.position = mouse_position
	_halo.call(
		"set_hovered",
		_is_clickable_hovered()
	)
	if _last_mouse_position.x < -9999.0:
		_last_mouse_position = mouse_position
		return
	var moved := mouse_position - _last_mouse_position
	if moved.length() > TRAIL_TELEPORT_DISTANCE:
		_trail.call("clear_trail")
	elif moved.length() >= TRAIL_POINT_SPACING:
		_trail.call("push_point", mouse_position)
	_last_mouse_position = mouse_position


func _build_cursor() -> void:
	_trail = TRAIL_SCRIPT.new() as Node2D
	_trail.name = "FallingStarTrail"
	add_child(_trail)

	_halo = HALO_SCRIPT.new() as Node2D
	_halo.name = "FallingStarHoverHalo"
	add_child(_halo)

	_star = TextureRect.new()
	_star.name = "FallingStarCursor"
	_star.texture = STAR_TEXTURE
	_star.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_star.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	_star.position = Vector2.ZERO
	_star.size = Vector2.ONE * STAR_SIZE
	_star.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_star.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	add_child(_star)


func _set_tracking(active: bool) -> void:
	_tracking = active
	if _star != null:
		_star.visible = active
	if _trail != null:
		_trail.visible = active
		_trail.call("clear_trail")
	if _halo != null:
		_halo.visible = active
		_halo.call("set_hovered", false)
	if active:
		_last_mouse_position = get_viewport().get_mouse_position()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _is_clickable_hovered() -> bool:
	var hovered_control := get_viewport().gui_get_hovered_control()
	while hovered_control != null:
		if hovered_control is BaseButton:
			var button := hovered_control as BaseButton
			return not button.disabled
		if (
			hovered_control.mouse_default_cursor_shape
			== Control.CURSOR_POINTING_HAND
		):
			return true
		hovered_control = hovered_control.get_parent() as Control
	return Input.get_current_cursor_shape() == Input.CURSOR_POINTING_HAND


func _on_window_focus_entered() -> void:
	_set_tracking(true)


func _on_window_focus_exited() -> void:
	_set_tracking(false)
