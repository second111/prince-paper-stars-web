extends Button

var arrow_angle_degrees := 0.0
var background_enabled := true
var circular_background := false
var paper_texture: Texture2D


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


func set_arrow_angle(value: float) -> void:
	arrow_angle_degrees = value
	queue_redraw()


func set_paper_texture(value: Texture2D) -> void:
	paper_texture = value
	queue_redraw()


func _draw() -> void:
	var hovered := is_hovered()
	var center := size * 0.5
	var reach := minf(size.x, size.y) * 0.46
	if paper_texture != null:
		var tint := Color.WHITE
		if disabled:
			tint = Color(1.0, 1.0, 1.0, 0.38)
		elif button_pressed:
			tint = Color(0.82, 0.78, 0.70, 1.0)
		elif hovered:
			tint = Color(1.08, 1.05, 0.96, 1.0)
		var texture_size := paper_texture.get_size()
		var fit := minf(size.x / texture_size.x, size.y / texture_size.y)
		var draw_size := texture_size * fit
		var draw_rect := Rect2((size - draw_size) * 0.5, draw_size)
		draw_texture_rect(paper_texture, draw_rect, false, tint)
		return
	if background_enabled:
		var shadow_center := center + Vector2(3.0, 4.0)
		if circular_background:
			draw_circle(shadow_center, reach, Color(0.02, 0.025, 0.03, 0.34))
			draw_circle(center, reach, Color(0.88, 0.80, 0.64, 0.98))
			draw_arc(
				center,
				reach - 1.5,
				0.0,
				TAU,
				40,
				Color(0.36, 0.24, 0.15, 0.92),
				2.0,
				true
			)
			draw_arc(
				center,
				reach - 6.0,
				0.0,
				TAU,
				40,
				Color(0.55, 0.39, 0.22, 0.52 if hovered else 0.34),
				1.0,
				true
			)
		else:
			var tab := PackedVector2Array([
				Vector2(5, 5),
				Vector2(size.x - 10, 2),
				Vector2(size.x - 3, 11),
				Vector2(size.x - 4, size.y - 5),
				Vector2(11, size.y - 2),
				Vector2(2, size.y - 12),
			])
			var tab_shadow := PackedVector2Array()
			for point in tab:
				tab_shadow.append(point + Vector2(2.0, 3.0))
			draw_colored_polygon(tab_shadow, Color(0.02, 0.025, 0.03, 0.32))
			draw_colored_polygon(tab, Color(0.89, 0.81, 0.66, 0.96))
			var outline := PackedVector2Array(tab)
			outline.append(tab[0])
			draw_polyline(outline, Color(0.36, 0.24, 0.15, 0.92), 2.0, true)

	var pointer_fill := (
		Color(0.35, 0.20, 0.14, 0.98)
		if hovered
		else Color(0.25, 0.17, 0.12, 0.92)
	)
	var pointer_highlight := Color(1.0, 0.80, 0.42, 0.84)
	var arrow_scale := minf(size.x, size.y) * 0.82
	var angle := deg_to_rad(arrow_angle_degrees)
	var compass := PackedVector2Array([
		Vector2(0.00, -0.40),
		Vector2(0.08, -0.10),
		Vector2(0.30, -0.02),
		Vector2(0.08, 0.08),
		Vector2(0.02, 0.28),
		Vector2(-0.06, 0.09),
		Vector2(-0.26, 0.04),
		Vector2(-0.08, -0.06),
	])
	var points := PackedVector2Array()
	for point in compass:
		points.append(center + (point.rotated(angle) * arrow_scale))
	draw_colored_polygon(points, pointer_fill)
	var facet := PackedVector2Array([
		center,
		center + Vector2(0.08, -0.10).rotated(angle) * arrow_scale,
		center + Vector2(0.30, -0.02).rotated(angle) * arrow_scale,
	])
	draw_colored_polygon(facet, pointer_highlight)
	var outline := PackedVector2Array(points)
	outline.append(points[0])
	draw_polyline(outline, Color(0.12, 0.08, 0.06, 0.92), 2.4, true)
