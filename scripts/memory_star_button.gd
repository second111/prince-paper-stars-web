extends Button

var accent_color := Color(0.96, 0.78, 0.42)
var art_texture: Texture2D
var phase := 0.0
var hovered := false
var reveal_age := 0.0
var was_visible := false


func _ready() -> void:
	text = ""
	flat = true
	focus_mode = Control.FOCUS_NONE
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	mouse_entered.connect(_on_hover_changed.bind(true))
	mouse_exited.connect(_on_hover_changed.bind(false))
	set_process(true)
	queue_redraw()


func set_accent(value: Color) -> void:
	accent_color = value
	queue_redraw()


func set_art(texture: Texture2D) -> void:
	art_texture = texture
	queue_redraw()


func _on_hover_changed(value: bool) -> void:
	hovered = value
	queue_redraw()


func _process(delta: float) -> void:
	if not visible:
		was_visible = false
		reveal_age = 0.0
		return
	if not was_visible:
		reveal_age = 0.0
		was_visible = true
	phase += delta
	reveal_age += delta
	var jelly := sin(phase * 4.2)
	var reveal := clampf(reveal_age / 0.42, 0.0, 1.0)
	var settle := 1.0 + sin(reveal * PI) * 0.12
	rotation = sin(phase * 2.4) * 0.065
	scale = Vector2(
		1.0 + jelly * (0.13 if hovered else 0.095),
		1.0 - jelly * (0.085 if hovered else 0.06)
	) * reveal * settle
	queue_redraw()


func _draw() -> void:
	var center := size * 0.5
	var radius := minf(size.x, size.y) * (0.30 if hovered else 0.285)
	var glow := Color(
		accent_color.r,
		accent_color.g,
		accent_color.b,
		0.18 + (0.06 if hovered else 0.0) + sin(phase * 3.2) * 0.025
	)
	draw_circle(center, radius * (1.58 + sin(phase * 2.2) * 0.10), glow)
	draw_arc(
		center,
		radius * 1.42,
		phase * 0.33,
		phase * 0.33 + TAU * 0.82,
		40,
		Color(accent_color.r, accent_color.g, accent_color.b, 0.42),
		1.1,
		true
	)
	if art_texture != null:
		var texture_size := art_texture.get_size()
		var fit := minf(
			size.x * 0.90 / maxf(texture_size.x, 1.0),
			size.y * 0.90 / maxf(texture_size.y, 1.0)
		)
		var draw_size := texture_size * fit
		draw_texture_rect(
			art_texture,
			Rect2(center - draw_size * 0.5, draw_size),
			false
		)
		return
	var star := _star_points(center, Vector2(radius, radius * 0.94))
	var shadow := PackedVector2Array()
	for point in star:
		shadow.append(point + Vector2(2.5, 3.5))
	draw_colored_polygon(shadow, Color(0.02, 0.02, 0.03, 0.32))
	draw_colored_polygon(
		star,
		Color(
			lerpf(0.94, accent_color.r, 0.34),
			lerpf(0.90, accent_color.g, 0.34),
			lerpf(0.76, accent_color.b, 0.30),
			1.0
		)
	)
	var outline := PackedVector2Array(star)
	outline.append(star[0])
	draw_polyline(
		outline,
		Color(accent_color.r, accent_color.g, accent_color.b, 0.96),
		2.0,
		true
	)
	draw_circle(
		center + Vector2(radius * 0.12, -radius * 0.08),
		radius * 0.10,
		Color(1.0, 0.98, 0.88, 0.92)
	)


func _star_points(center: Vector2, radii: Vector2) -> PackedVector2Array:
	var points := PackedVector2Array()
	var irregular := [
		1.00, 0.88, 0.94, 1.04, 0.91,
		1.00, 0.90, 1.06, 0.96, 0.92,
	]
	for index in 10:
		var angle := -PI * 0.5 + index * PI / 5.0
		var reach := 1.0 if index % 2 == 0 else 0.43
		var radius_scale := float(irregular[index])
		points.append(
			center
			+ Vector2(cos(angle) * radii.x, sin(angle) * radii.y)
			* reach
			* radius_scale
		)
	return points
