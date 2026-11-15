extends Button

const PAPER_TEXTURE := preload("res://assets/ui/paper_ui/cloth.png")

var grabbed := false


func _ready() -> void:
	text = ""
	flat = true
	focus_mode = Control.FOCUS_NONE
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	mouse_entered.connect(queue_redraw)
	mouse_exited.connect(queue_redraw)
	button_down.connect(queue_redraw)
	button_up.connect(queue_redraw)
	resized.connect(queue_redraw)
	queue_redraw()


func set_grabbed(value: bool) -> void:
	grabbed = value
	mouse_default_cursor_shape = (
		Control.CURSOR_DRAG if grabbed else Control.CURSOR_POINTING_HAND
	)
	queue_redraw()


func _draw() -> void:
	var hovered := is_hovered() or grabbed
	var tint := Color(1.08, 1.06, 1.0, 1.0) if hovered else Color.WHITE
	draw_texture_rect(PAPER_TEXTURE, Rect2(Vector2.ZERO, size), false, tint)
