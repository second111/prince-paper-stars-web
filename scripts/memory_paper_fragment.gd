extends Control

var accent_color := Color(0.94, 0.76, 0.43)
var icon_kind := "star"
var paper_color := Color(0.95, 0.89, 0.74, 0.88)
var art_texture: Texture2D


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	queue_redraw()


func setup(kind: String, accent: Color, texture: Texture2D = null) -> void:
	icon_kind = kind
	accent_color = accent
	art_texture = texture
	queue_redraw()


func _draw() -> void:
	var w := size.x
	var h := size.y
	if art_texture != null:
		var texture_size := art_texture.get_size()
		var fit := minf(
			(w - 2.0) / maxf(texture_size.x, 1.0),
			(h - 2.0) / maxf(texture_size.y, 1.0)
		)
		var draw_size := texture_size * fit
		draw_texture_rect(
			art_texture,
			Rect2((size - draw_size) * 0.5, draw_size),
			false
		)
		return
	var paper := PackedVector2Array([
		Vector2(w * 0.08, h * 0.20),
		Vector2(w * 0.68, h * 0.10),
		Vector2(w * 0.92, h * 0.24),
		Vector2(w * 0.86, h * 0.82),
		Vector2(w * 0.26, h * 0.90),
		Vector2(w * 0.05, h * 0.64),
	])
	var shadow := PackedVector2Array()
	for point in paper:
		shadow.append(point + Vector2(2.5, 3.5))
	draw_colored_polygon(shadow, Color(0.01, 0.015, 0.025, 0.24))
	draw_colored_polygon(paper, paper_color)
	var outline := PackedVector2Array(paper)
	outline.append(paper[0])
	draw_polyline(outline, Color(0.36, 0.22, 0.13, 0.82), 1.3, true)
	var center := Vector2(w * 0.49, h * 0.48)
	match icon_kind:
		"rose":
			draw_circle(center, w * 0.15, accent_color)
			draw_circle(center + Vector2(-w * 0.10, -h * 0.08), w * 0.10, accent_color.lightened(0.12))
			draw_circle(center + Vector2(w * 0.11, -h * 0.06), w * 0.09, accent_color.darkened(0.08))
			draw_line(center + Vector2(0, h * 0.15), center + Vector2(0, h * 0.34), Color(0.25, 0.42, 0.22), 2.0, true)
		"dome":
			draw_arc(center, w * 0.20, PI, TAU, 20, accent_color, 1.8, true)
			draw_line(center + Vector2(-w * 0.20, 0), center + Vector2(w * 0.20, 0), accent_color, 2.0, true)
			draw_circle(center + Vector2(w * 0.05, -h * 0.05), w * 0.045, accent_color.lightened(0.30))
		"mirror":
			draw_circle(center, w * 0.20, Color(accent_color.r, accent_color.g, accent_color.b, 0.34))
			draw_arc(center, w * 0.20, 0.0, TAU, 28, accent_color, 2.0, true)
			draw_line(center + Vector2(0, h * 0.20), center + Vector2(0, h * 0.36), accent_color, 2.0, true)
		"petal":
			for index in 5:
				var angle := -PI * 0.5 + index * TAU / 5.0
				draw_circle(center + Vector2(cos(angle), sin(angle)) * w * 0.12, w * 0.10, accent_color)
			draw_circle(center, w * 0.07, accent_color.lightened(0.24))
		"lamp":
			draw_rect(Rect2(center - Vector2(w * 0.13, h * 0.17), Vector2(w * 0.26, h * 0.34)), accent_color, true)
			draw_line(center + Vector2(0, -h * 0.30), center + Vector2(0, -h * 0.17), Color(0.30, 0.19, 0.10), 1.5, true)
			draw_circle(center, w * 0.065, Color(1.0, 0.96, 0.72))
		"ledger":
			draw_rect(Rect2(center - Vector2(w * 0.18, h * 0.22), Vector2(w * 0.36, h * 0.44)), accent_color, true)
			for row in 3:
				draw_line(
					center + Vector2(-w * 0.12, -h * 0.12 + row * h * 0.11),
					center + Vector2(w * 0.12, -h * 0.12 + row * h * 0.11),
					Color(0.25, 0.18, 0.12, 0.68),
					1.0,
					true
				)
		"fox":
			var head := PackedVector2Array([
				center + Vector2(-w * 0.20, h * 0.14),
				center + Vector2(-w * 0.14, -h * 0.20),
				center + Vector2(0, -h * 0.04),
				center + Vector2(w * 0.14, -h * 0.20),
				center + Vector2(w * 0.20, h * 0.14),
			])
			draw_colored_polygon(head, accent_color)
			draw_circle(center + Vector2(0, h * 0.08), w * 0.06, Color(0.25, 0.15, 0.10, 0.72))
		"wheat":
			draw_line(center + Vector2(0, -h * 0.24), center + Vector2(0, h * 0.28), accent_color, 2.0, true)
			for row in 3:
				var y := center.y - h * 0.12 + row * h * 0.10
				draw_line(Vector2(center.x, y), Vector2(center.x - w * 0.13, y - h * 0.05), accent_color, 1.5, true)
				draw_line(Vector2(center.x, y), Vector2(center.x + w * 0.13, y - h * 0.05), accent_color, 1.5, true)
		"sun":
			draw_circle(center, w * 0.17, accent_color)
			for ray in 8:
				var angle := ray * TAU / 8.0
				draw_line(
					center + Vector2(cos(angle), sin(angle)) * w * 0.21,
					center + Vector2(cos(angle), sin(angle)) * w * 0.31,
					accent_color,
					1.6,
					true
				)
		"crown":
			var crown := PackedVector2Array([
				center + Vector2(-w * 0.22, h * 0.16),
				center + Vector2(-w * 0.19, -h * 0.17),
				center + Vector2(-w * 0.05, h * 0.01),
				center + Vector2(0, -h * 0.24),
				center + Vector2(w * 0.05, h * 0.01),
				center + Vector2(w * 0.19, -h * 0.17),
				center + Vector2(w * 0.22, h * 0.16),
			])
			draw_colored_polygon(crown, accent_color)
		"chair":
			draw_line(center + Vector2(-w * 0.11, -h * 0.22), center + Vector2(-w * 0.11, h * 0.26), accent_color, 2.0, true)
			draw_line(center + Vector2(w * 0.11, -h * 0.22), center + Vector2(w * 0.11, h * 0.26), accent_color, 2.0, true)
			draw_line(center + Vector2(-w * 0.17, h * 0.05), center + Vector2(w * 0.17, h * 0.05), accent_color, 2.4, true)
		_:
			_draw_star(center, w * 0.22, accent_color)


func _draw_star(center: Vector2, radius: float, color: Color) -> void:
	var points := PackedVector2Array()
	for index in 10:
		var angle := -PI * 0.5 + index * PI / 5.0
		var reach := 1.0 if index % 2 == 0 else 0.42
		points.append(center + Vector2(cos(angle), sin(angle)) * radius * reach)
	draw_colored_polygon(points, color)
