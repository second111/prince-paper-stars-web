extends Control

var accent_color := Color(0.96, 0.78, 0.42)
var art_texture: Texture2D
var phase := 0.0


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_process(true)
	queue_redraw()


func set_accent(value: Color) -> void:
	accent_color = value
	queue_redraw()


func set_art(texture: Texture2D) -> void:
	art_texture = texture
	queue_redraw()


func _process(delta: float) -> void:
	if not visible:
		return
	phase += delta
	queue_redraw()


func _draw() -> void:
	var center := size * 0.5
	for ring_index in 3:
		var radius := Vector2(
			size.x * (0.43 + ring_index * 0.025),
			size.y * (0.38 + ring_index * 0.025)
		)
		var points := PackedVector2Array()
		for point_index in 49:
			var angle := point_index * TAU / 48.0
			var wobble := 1.0 + sin(angle * 3.0 + phase * 0.45) * 0.018
			points.append(
				center
				+ Vector2(cos(angle), sin(angle)) * radius * wobble
			)
		draw_polyline(
			points,
			Color(
				accent_color.r,
				accent_color.g,
				accent_color.b,
				0.20 - ring_index * 0.045
			),
			1.3,
			true
		)
	for fleck_index in 7:
		var angle := phase * 0.16 + fleck_index * TAU / 7.0
		var radius := Vector2(size.x * 0.46, size.y * 0.41)
		var position := center + Vector2(cos(angle), sin(angle)) * radius
		draw_circle(
			position,
			1.3 + 0.4 * sin(phase * 3.0 + fleck_index),
			Color(accent_color.r, accent_color.g, accent_color.b, 0.42)
		)
	if art_texture != null:
		var texture_size := art_texture.get_size()
		var fit := minf(
			size.x * 0.54 / maxf(texture_size.x, 1.0),
			size.y * 0.54 / maxf(texture_size.y, 1.0)
		)
		var draw_size := texture_size * fit
		draw_texture_rect(
			art_texture,
			Rect2(
				Vector2(size.x * 0.05, size.y * 0.54),
				draw_size
			),
			false,
			Color(1.0, 1.0, 1.0, 0.78)
		)
