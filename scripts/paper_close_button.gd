extends Button


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


func _draw() -> void:
	var hovered := is_hovered()
	var w := size.x
	var h := size.y
	var sheet := PackedVector2Array([
		Vector2(w * 0.08, h * 0.18),
		Vector2(w * 0.72, h * 0.12),
		Vector2(w * 0.90, h * 0.28),
		Vector2(w * 0.84, h * 0.84),
		Vector2(w * 0.16, h * 0.88),
		Vector2(w * 0.06, h * 0.58),
	])
	var shadow := PackedVector2Array()
	for point in sheet:
		shadow.append(point + Vector2(2.0, 2.5))
	draw_colored_polygon(shadow, Color(0.03, 0.02, 0.015, 0.24))
	draw_colored_polygon(
		sheet,
		Color(0.93, 0.84, 0.67, 0.96 if hovered else 0.78)
	)
	var outline := PackedVector2Array(sheet)
	outline.append(sheet[0])
	draw_polyline(
		outline,
		Color(0.39, 0.24, 0.14, 0.92 if hovered else 0.68),
		1.2,
		true
	)
	var fold := PackedVector2Array([
		Vector2(w * 0.72, h * 0.12),
		Vector2(w * 0.90, h * 0.28),
		Vector2(w * 0.68, h * 0.32),
	])
	draw_colored_polygon(fold, Color(0.74, 0.61, 0.43, 0.56))
	var center := Vector2(w * 0.46, h * 0.51)
	var cross := minf(w, h) * 0.19
	var ink := Color(0.31, 0.17, 0.10, 1.0 if hovered else 0.88)
	draw_line(center + Vector2(-cross, -cross), center + Vector2(cross, cross), ink, 1.8, true)
	draw_line(center + Vector2(cross, -cross), center + Vector2(-cross, cross), ink, 1.8, true)
