extends Button

const PAPER_TEXTURE := preload("res://assets/ui/paper_ui/dialogue_bubble.png")


func _ready() -> void:
	text = ""
	flat = true
	focus_mode = Control.FOCUS_NONE
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	mouse_entered.connect(queue_redraw)
	mouse_exited.connect(queue_redraw)
	resized.connect(queue_redraw)
	queue_redraw()


func _draw() -> void:
	var hovered := is_hovered()
	var tint := Color(1.08, 1.06, 1.0, 1.0) if hovered else Color.WHITE
	draw_texture_rect(PAPER_TEXTURE, Rect2(Vector2.ZERO, size), false, tint)
