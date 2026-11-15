extends Control

var _background_gradient: GradientTexture2D
var _warm_glow: GradientTexture2D
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
	sky.offsets = PackedFloat32Array([0.0, 0.35, 0.72, 1.0])
	sky.colors = PackedColorArray([
		Color("#02050b"),
		Color("#081222"),
		Color("#10243c"),
		Color("#1e394f"),
	])
	_background_gradient = GradientTexture2D.new()
	_background_gradient.gradient = sky
	_background_gradient.width = 64
	_background_gradient.height = 256
	_background_gradient.fill = GradientTexture2D.FILL_LINEAR
	_background_gradient.fill_from = Vector2(0.5, 0.0)
	_background_gradient.fill_to = Vector2(0.5, 1.0)

	var warm := Gradient.new()
	warm.offsets = PackedFloat32Array([0.0, 0.16, 0.42, 0.7, 1.0])
	warm.colors = PackedColorArray([
		Color(0.96, 0.88, 0.7, 0.54),
		Color(0.84, 0.73, 0.5, 0.3),
		Color(0.45, 0.65, 0.61, 0.15),
		Color(0.13, 0.28, 0.39, 0.07),
		Color(0.02, 0.05, 0.1, 0.0),
	])
	_warm_glow = GradientTexture2D.new()
	_warm_glow.gradient = warm
	_warm_glow.width = 512
	_warm_glow.height = 512
	_warm_glow.fill = GradientTexture2D.FILL_RADIAL
	_warm_glow.fill_from = Vector2(0.5, 0.5)
	_warm_glow.fill_to = Vector2(1.0, 0.5)

	var edge := Gradient.new()
	edge.offsets = PackedFloat32Array([0.42, 0.72, 1.0])
	edge.colors = PackedColorArray([
		Color(0.01, 0.025, 0.05, 0.0),
		Color(0.008, 0.018, 0.035, 0.34),
		Color(0.005, 0.012, 0.025, 0.86),
	])
	_vignette = GradientTexture2D.new()
	_vignette.gradient = edge
	_vignette.width = 512
	_vignette.height = 512
	_vignette.fill = GradientTexture2D.FILL_RADIAL
	_vignette.fill_from = Vector2(0.68, 0.3)
	_vignette.fill_to = Vector2(1.0, 0.3)


func _build_stars() -> void:
	_stars.clear()
	var rng := RandomNumberGenerator.new()
	rng.seed = 0xB612
	for index in 115:
		_stars.append({
			"position": Vector2(rng.randf(), rng.randf_range(0.04, 0.78)),
			"radius": rng.randf_range(0.65, 2.0),
			"alpha": rng.randf_range(0.12, 0.58),
			"gold": index % 7 == 0,
		})


func _draw() -> void:
	var view_size := size
	if view_size.x <= 0.0 or view_size.y <= 0.0:
		return
	draw_texture_rect(_background_gradient, Rect2(Vector2.ZERO, view_size), false)

	var core := Vector2(view_size.x * 0.7, view_size.y * 0.3)
	var halo_size := Vector2(view_size.x * 0.82, view_size.x * 0.82)
	draw_texture_rect(
		_warm_glow,
		Rect2(core - halo_size * 0.5, halo_size),
		false
	)

	_draw_beam(core, Vector2(view_size.x * 0.32, view_size.y * 0.47), 24.0, Color(0.86, 0.77, 0.58, 0.055))
	_draw_beam(core, Vector2(view_size.x * 0.3, view_size.y * 0.76), 36.0, Color(0.72, 0.78, 0.75, 0.045))
	_draw_beam(core, Vector2(view_size.x, view_size.y * 0.56), 46.0, Color(0.82, 0.72, 0.49, 0.035))

	for radius in [154.0, 190.0, 230.0, 278.0, 330.0]:
		var scale_factor := view_size.y / 1000.0
		draw_circle(core, radius * scale_factor, Color(0.9, 0.79, 0.56, 0.025))
		draw_arc(
			core,
			radius * scale_factor,
			0.0,
			TAU,
			180,
			Color(0.82, 0.69, 0.43, 0.12),
			1.2
		)

	for star in _stars:
		var position: Vector2 = star.position * view_size
		var color := Color(0.91, 0.8, 0.55, star.alpha) if star.gold else Color(0.82, 0.87, 0.94, star.alpha)
		draw_circle(position, star.radius, color)
		if star.radius > 1.6:
			draw_circle(position, star.radius * 2.8, Color(color.r, color.g, color.b, color.a * 0.08))

	draw_texture_rect(_vignette, Rect2(Vector2.ZERO, view_size), false)


func _draw_beam(core: Vector2, endpoint: Vector2, width: float, color: Color) -> void:
	var direction := (endpoint - core).normalized()
	var perpendicular := Vector2(-direction.y, direction.x)
	var polygon := PackedVector2Array([
		core - perpendicular * width * 0.2,
		core + perpendicular * width * 0.2,
		endpoint + perpendicular * width,
		endpoint - perpendicular * width,
	])
	draw_colored_polygon(polygon, color)
