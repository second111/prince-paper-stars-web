extends Control

var _background_gradient: GradientTexture2D
var _center_glow: GradientTexture2D
var _vignette: GradientTexture2D
var _stars: Array[Dictionary] = []


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_build_textures()
	_build_stars()
	resized.connect(queue_redraw)
	queue_redraw()


func _build_textures() -> void:
	var sky := Gradient.new()
	sky.offsets = PackedFloat32Array([0.0, 0.42, 0.72, 1.0])
	sky.colors = PackedColorArray([
		Color("#070d18"),
		Color("#0d1729"),
		Color("#15223a"),
		Color("#1b2b46"),
	])
	_background_gradient = GradientTexture2D.new()
	_background_gradient.gradient = sky
	_background_gradient.width = 64
	_background_gradient.height = 256
	_background_gradient.fill = GradientTexture2D.FILL_LINEAR
	_background_gradient.fill_from = Vector2(0.5, 0.0)
	_background_gradient.fill_to = Vector2(0.5, 1.0)

	var glow := Gradient.new()
	glow.offsets = PackedFloat32Array([0.0, 0.4, 1.0])
	glow.colors = PackedColorArray([
		Color(0.34, 0.47, 0.66, 0.28),
		Color(0.18, 0.25, 0.39, 0.12),
		Color(0.03, 0.06, 0.11, 0.0),
	])
	_center_glow = GradientTexture2D.new()
	_center_glow.gradient = glow
	_center_glow.width = 512
	_center_glow.height = 512
	_center_glow.fill = GradientTexture2D.FILL_RADIAL
	_center_glow.fill_from = Vector2(0.5, 0.5)
	_center_glow.fill_to = Vector2(1.0, 0.5)

	var edge := Gradient.new()
	edge.offsets = PackedFloat32Array([0.52, 0.78, 1.0])
	edge.colors = PackedColorArray([
		Color(0.01, 0.02, 0.04, 0.0),
		Color(0.01, 0.02, 0.04, 0.22),
		Color(0.01, 0.02, 0.04, 0.72),
	])
	_vignette = GradientTexture2D.new()
	_vignette.gradient = edge
	_vignette.width = 512
	_vignette.height = 512
	_vignette.fill = GradientTexture2D.FILL_RADIAL
	_vignette.fill_from = Vector2(0.5, 0.44)
	_vignette.fill_to = Vector2(1.0, 0.44)


func _build_stars() -> void:
	_stars.clear()
	var rng := RandomNumberGenerator.new()
	rng.seed = 0x612
	for index in 72:
		_stars.append({
			"position": Vector2(rng.randf(), rng.randf_range(0.04, 0.8)),
			"radius": rng.randf_range(0.7, 2.0),
			"alpha": rng.randf_range(0.12, 0.48),
			"gold": index % 9 == 0,
		})


func _draw() -> void:
	var view_size := size
	if view_size.x <= 0.0 or view_size.y <= 0.0:
		return
	draw_texture_rect(_background_gradient, Rect2(Vector2.ZERO, view_size), false)
	var glow_rect := Rect2(
		Vector2(-view_size.x * 0.08, -view_size.y * 0.16),
		Vector2(view_size.x * 1.16, view_size.y * 1.18)
	)
	draw_texture_rect(_center_glow, glow_rect, false)

	var center := Vector2(view_size.x * 0.5, view_size.y * 0.43)
	var ring_radius := minf(view_size.x * 0.205, view_size.y * 0.34)
	draw_arc(center, ring_radius, 0.0, TAU, 180, Color(0.56, 0.65, 0.79, 0.13), 1.2)
	draw_arc(center, ring_radius * 1.18, 0.0, TAU, 180, Color(0.78, 0.66, 0.44, 0.21), 1.0)
	draw_arc(center, ring_radius * 1.37, 0.0, TAU, 180, Color(0.56, 0.65, 0.79, 0.07), 1.0)

	for star in _stars:
		var position: Vector2 = star.position * view_size
		var color := Color(0.88, 0.78, 0.56, star.alpha) if star.gold else Color(0.82, 0.87, 0.94, star.alpha)
		draw_circle(position, star.radius, color)

	_draw_cloud_wave(view_size, view_size.y * 0.845, 16.0, 0.18, Color(0.18, 0.25, 0.39, 0.34), 0.0)
	_draw_cloud_wave(view_size, view_size.y * 0.885, 20.0, 0.32, Color(0.13, 0.19, 0.31, 0.42), 1.4)
	_draw_cloud_wave(view_size, view_size.y * 0.93, 25.0, 0.48, Color(0.075, 0.12, 0.21, 0.62), 2.1)
	draw_texture_rect(_vignette, Rect2(Vector2.ZERO, view_size), false)


func _draw_cloud_wave(
	view_size: Vector2,
	base_y: float,
	amplitude: float,
	frequency: float,
	color: Color,
	phase: float
) -> void:
	var points := PackedVector2Array()
	var outline := PackedVector2Array()
	var step := maxf(18.0, view_size.x / 90.0)
	var x := -step
	while x <= view_size.x + step:
		var y := base_y + sin(x / view_size.x * TAU * frequency + phase) * amplitude
		y += sin(x / view_size.x * TAU * frequency * 2.7 + phase * 1.8) * amplitude * 0.22
		outline.append(Vector2(x, y))
		points.append(Vector2(x, y))
		x += step
	points.append(Vector2(view_size.x + step, view_size.y + step))
	points.append(Vector2(-step, view_size.y + step))
	draw_colored_polygon(points, color)
	draw_polyline(outline, Color(0.76, 0.78, 0.8, color.a * 0.28), 1.1, true)
