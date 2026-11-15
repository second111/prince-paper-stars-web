extends Node3D

const CREEK_SHADER := preload("res://shaders/player_creek.gdshader")
const RIVER_END_DATA := "res://data/player_river_end_loop.json"
const RIVER_GUIDE_SCENE := "res://assets/3d/player/player_planet_base_river_guide.glb"

var _river_mesh: MeshInstance3D
var _guide_mesh: MeshInstance3D
var _river_material: ShaderMaterial
var _terminal_fade_start := -INF
var _terminal_fade_end := -INF


func _ready() -> void:
	_build_from_authored_guide()


func _build_from_authored_guide() -> void:
	var root := _find_planet_root()
	if root == null:
		push_warning("Player river: planet root is missing.")
		return
	var base := root.get_node_or_null("PlanetBase") as Node3D
	if base == null:
		push_warning("Player river: PlanetBase is missing.")
		return
	var temporary_guide_root: Node3D
	if ResourceLoader.exists(RIVER_GUIDE_SCENE):
		temporary_guide_root = (
			load(RIVER_GUIDE_SCENE) as PackedScene
		).instantiate() as Node3D
		if temporary_guide_root != null:
			temporary_guide_root.name = "RiverGuideSource"
			temporary_guide_root.visible = false
			root.add_child(temporary_guide_root)
			_guide_mesh = _find_river_guide_mesh(temporary_guide_root)
	if _guide_mesh == null:
		_guide_mesh = _find_river_guide_mesh(base)
	if _guide_mesh == null:
		push_warning("Player river: authored 圆管 guide is missing.")
		if temporary_guide_root != null:
			temporary_guide_root.queue_free()
		return

	var material := ShaderMaterial.new()
	material.shader = CREEK_SHADER
	_river_material = material
	material.set_shader_parameter("deep_color", Color(0.075, 0.35, 0.40, 1.0))
	material.set_shader_parameter("shallow_color", Color(0.34, 0.78, 0.73, 1.0))
	material.set_shader_parameter("foam_color", Color(0.96, 0.97, 0.86, 1.0))
	material.set_shader_parameter("opacity", 0.94)
	material.set_shader_parameter("flow_speed", 0.294)
	material.set_shader_parameter("wave_amplitude", 0.014)
	material.set_shader_parameter("foam_amount", 0.62)
	material.set_shader_parameter("layer_phase", 1.7)

	# Reuse the authored band mesh itself. This preserves its flat cross-section,
	# thickness, curvature, outlet and every other detail from the modelling app.
	_river_mesh = MeshInstance3D.new()
	_river_mesh.name = "RiverWater"
	_river_mesh.mesh = _guide_mesh.mesh
	if temporary_guide_root != null:
		# The archived guide is authored in the same source coordinates as the
		# planet model. Route it through PlanetBase's normalization so the river
		# follows the current base rather than using the old raw model scale.
		var guide_in_source := (
			temporary_guide_root.global_transform.affine_inverse()
			* _guide_mesh.global_transform
		)
		_river_mesh.transform = base.transform * guide_in_source
	else:
		_river_mesh.transform = (
			root.global_transform.affine_inverse()
			* _guide_mesh.global_transform
		)
	_river_mesh.material_override = material
	var river_bounds := _river_mesh.mesh.get_aabb()
	var terminal_fade_height := minf(
		0.210,
		river_bounds.size.y * 0.48
	)
	_terminal_fade_start = river_bounds.position.y + terminal_fade_height
	_terminal_fade_end = river_bounds.position.y
	material.set_shader_parameter(
		"terminal_fade_start",
		_terminal_fade_start
	)
	material.set_shader_parameter(
		"terminal_fade_end",
		_terminal_fade_end
	)
	_river_mesh.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(_river_mesh)
	_add_outlet_splash()
	_guide_mesh.visible = false
	if temporary_guide_root != null:
		temporary_guide_root.queue_free()


func configure_placement_darkening(
	center: Vector3,
	normal: Vector3
) -> void:
	if _river_mesh == null or _river_material == null:
		return
	var inverse_transform := _river_mesh.transform.affine_inverse()
	var local_center := inverse_transform * center
	var local_normal := (
		inverse_transform.basis.inverse().transposed()
		* normal.normalized()
	).normalized()
	_river_material.set_shader_parameter(
		"placement_center",
		local_center
	)
	_river_material.set_shader_parameter(
		"placement_normal",
		local_normal
	)


func _add_outlet_splash() -> void:
	var outlet := _find_lowest_water_outlet()
	var center: Vector3 = outlet.center
	var end_loop := _load_river_end_loop()
	var width := float(outlet.width)
	var depth := float(outlet.depth)
	if end_loop.size() >= 3:
		center = Vector3.ZERO
		var minimum_x := INF
		var maximum_x := -INF
		var minimum_z := INF
		var maximum_z := -INF
		for point in end_loop:
			center += point
			minimum_x = minf(minimum_x, point.x)
			maximum_x = maxf(maximum_x, point.x)
			minimum_z = minf(minimum_z, point.z)
			maximum_z = maxf(maximum_z, point.z)
		center /= float(end_loop.size())
		width = maxf(0.02, maximum_x - minimum_x)
		depth = maxf(0.02, maximum_z - minimum_z)
	# Start spraying where the water starts fading, so the particles conceal the
	# entire alpha transition instead of appearing only below the final cut.
	center.y = _terminal_fade_start + 0.012

	var streak_texture := _make_falling_streak_texture()
	var droplet_amounts := [620, 500, 400, 210]
	var thread_amounts := [300, 240, 190, 88]
	var lifetimes := [0.68, 0.83, 1.02, 1.16]
	var lateral_offsets := [
		Vector2(-0.035, 0.024),
		Vector2(0.028, -0.031),
		Vector2(-0.012, 0.043),
		Vector2(0.041, -0.016),
	]
	var width_scales := [0.92, 1.05, 0.86, 1.12]
	var exit_y := _terminal_fade_end + 0.010
	var fade_span := maxf(center.y - exit_y, 0.04)
	var curtain_center_y := (center.y + exit_y) * 0.5
	var emission_half_height := fade_span * 0.52
	for level in 4:
		var lateral_offset: Vector2 = lateral_offsets[level]
		var level_center := Vector3(
			center.x + lateral_offset.x * width,
			curtain_center_y,
			center.z + lateral_offset.y * depth
		)
		var layer_width := width * float(width_scales[level])
		_add_spray_droplets(
			level_center,
			layer_width,
			depth,
			int(droplet_amounts[level]),
			float(lifetimes[level]),
			emission_half_height,
			level
		)
		_add_outlet_water_threads(
			level_center,
			layer_width,
			depth,
			int(thread_amounts[level]),
			float(lifetimes[level]) * 0.94,
			emission_half_height,
			level,
			streak_texture
		)


func _add_spray_droplets(
	center: Vector3,
	width: float,
	depth: float,
	particle_count: int,
	particle_lifetime: float,
	emission_half_height: float,
	layer_index: int
) -> void:
	var droplets := GPUParticles3D.new()
	droplets.name = "WaterfallDroplets_%02d" % (layer_index + 1)
	droplets.amount = particle_count
	droplets.lifetime = particle_lifetime
	droplets.preprocess = particle_lifetime * 0.35
	droplets.fixed_fps = 30
	droplets.local_coords = true
	droplets.position = center
	droplets.visibility_aabb = AABB(
		Vector3(
			-width,
			-emission_half_height - 0.20,
			-depth
		),
		Vector3(
			width * 2.0,
			emission_half_height * 2.0 + 0.44,
			depth * 2.0
		)
	)
	droplets.draw_order = GPUParticles3D.DRAW_ORDER_VIEW_DEPTH
	var direction := Vector3(
		sin(float(layer_index) * 2.13) * 0.055,
		-1.0,
		cos(float(layer_index) * 1.71) * 0.045
	).normalized()
	droplets.process_material = _make_splash_process(
		direction,
		10.0 + float(layer_index) * 1.8,
		0.050 + float(layer_index % 2) * 0.007,
		0.125 + float(layer_index) * 0.010,
		Vector3(
			width * 0.43,
			emission_half_height,
			depth * 0.43
		),
		Vector3(0.0, -0.266, 0.0),
		0.48,
		1.02
	)
	var droplet_mesh := SphereMesh.new()
	droplet_mesh.radius = 0.0045
	droplet_mesh.height = 0.016
	droplet_mesh.radial_segments = 6
	droplet_mesh.rings = 4
	droplet_mesh.material = _make_splash_material(
		Color(0.80, 0.96, 0.98, 0.62),
		null,
		false
	)
	droplets.draw_pass_1 = droplet_mesh
	_river_mesh.add_child(droplets)


func _add_outlet_water_threads(
	center: Vector3,
	width: float,
	depth: float,
	particle_count: int,
	particle_lifetime: float,
	emission_half_height: float,
	layer_index: int,
	texture: Texture2D
) -> void:
	var threads := GPUParticles3D.new()
	threads.name = "WaterfallThreads_%02d" % (layer_index + 1)
	threads.amount = particle_count
	threads.lifetime = particle_lifetime
	threads.preprocess = particle_lifetime * 0.35
	threads.fixed_fps = 30
	threads.local_coords = true
	threads.position = center
	threads.visibility_aabb = AABB(
		Vector3(
			-width,
			-emission_half_height - 0.20,
			-depth
		),
		Vector3(
			width * 2.0,
			emission_half_height * 2.0 + 0.44,
			depth * 2.0
		)
	)
	threads.draw_order = GPUParticles3D.DRAW_ORDER_VIEW_DEPTH
	var direction := Vector3(
		sin(float(layer_index) * 1.37 + 0.6) * 0.035,
		-1.0,
		cos(float(layer_index) * 2.07) * 0.028
	).normalized()
	threads.process_material = _make_splash_process(
		direction,
		5.5 + float(layer_index) * 1.25,
		0.032 + float(layer_index % 2) * 0.005,
		0.094 + float(layer_index) * 0.009,
		Vector3(
			width * 0.44,
			emission_half_height,
			depth * 0.44
		),
		Vector3(0.0, -0.175, 0.0),
		0.74,
		1.18
	)
	var streak := QuadMesh.new()
	streak.size = Vector2(0.014, 0.165)
	streak.material = _make_splash_material(
		Color(0.82, 0.97, 1.0, 0.56),
		texture,
		true
	)
	threads.draw_pass_1 = streak
	_river_mesh.add_child(threads)


func _load_river_end_loop() -> Array[Vector3]:
	var result: Array[Vector3] = []
	var parsed: Variant = JSON.parse_string(
		FileAccess.get_file_as_string(RIVER_END_DATA)
	)
	if not parsed is Dictionary:
		return result
	var values: Variant = (parsed as Dictionary).get("points", [])
	if not values is Array:
		return result
	for value in values:
		if not value is Array or (value as Array).size() < 3:
			continue
		var point: Array = value
		result.append(Vector3(
			float(point[0]),
			float(point[1]),
			float(point[2])
		))
	return result


func _find_lowest_water_outlet() -> Dictionary:
	var minimum_y := INF
	var maximum_y := -INF
	var all_vertices: Array[Vector3] = []
	for surface_index in _river_mesh.mesh.get_surface_count():
		var arrays := _river_mesh.mesh.surface_get_arrays(surface_index)
		if arrays.is_empty():
			continue
		var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		for vertex in vertices:
			all_vertices.append(vertex)
			minimum_y = minf(minimum_y, vertex.y)
			maximum_y = maxf(maximum_y, vertex.y)
	var edge_band := maxf(0.004, (maximum_y - minimum_y) * 0.018)
	var edge_vertices: Array[Vector3] = []
	var minimum_x := INF
	var maximum_x := -INF
	var minimum_z := INF
	var maximum_z := -INF
	for vertex in all_vertices:
		if vertex.y > minimum_y + edge_band:
			continue
		edge_vertices.append(vertex)
		minimum_x = minf(minimum_x, vertex.x)
		maximum_x = maxf(maximum_x, vertex.x)
		minimum_z = minf(minimum_z, vertex.z)
		maximum_z = maxf(maximum_z, vertex.z)
	if edge_vertices.is_empty():
		var bounds := _river_mesh.mesh.get_aabb()
		return {
			"center": Vector3(
				bounds.get_center().x,
				bounds.position.y,
				bounds.get_center().z
			),
			"width": bounds.size.x,
			"depth": bounds.size.z,
		}
	var center := Vector3.ZERO
	for vertex in edge_vertices:
		center += vertex
	center /= float(edge_vertices.size())
	center.y = minimum_y - 0.004
	return {
		"center": center,
		"width": maxf(0.02, maximum_x - minimum_x),
		"depth": maxf(0.02, maximum_z - minimum_z),
	}


func _make_splash_process(
	direction: Vector3,
	spread: float,
	min_velocity: float,
	max_velocity: float,
	extents: Vector3,
	gravity: Vector3,
	min_scale: float,
	max_scale: float
) -> ParticleProcessMaterial:
	var process := ParticleProcessMaterial.new()
	process.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	process.emission_box_extents = extents
	process.direction = direction.normalized()
	process.spread = spread
	process.gravity = gravity
	process.initial_velocity_min = min_velocity
	process.initial_velocity_max = max_velocity
	process.damping_min = 0.16
	process.damping_max = 0.42
	process.scale_min = min_scale
	process.scale_max = max_scale
	process.color = Color(0.82, 0.97, 0.98, 1.0)
	var gradient := Gradient.new()
	gradient.offsets = PackedFloat32Array([0.0, 0.12, 0.48, 0.78, 1.0])
	gradient.colors = PackedColorArray([
		Color(0.86, 0.98, 1.0, 0.0),
		Color(0.90, 1.0, 1.0, 0.82),
		Color(0.72, 0.92, 0.96, 0.58),
		Color(0.63, 0.86, 0.91, 0.24),
		Color(0.62, 0.84, 0.90, 0.0),
	])
	var ramp := GradientTexture1D.new()
	ramp.gradient = gradient
	process.color_ramp = ramp
	return process


func _make_splash_material(
	tint: Color,
	texture: Texture2D,
	billboard: bool
) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = tint
	material.albedo_texture = texture
	material.vertex_color_use_as_albedo = true
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	material.no_depth_test = false
	if billboard:
		material.billboard_mode = BaseMaterial3D.BILLBOARD_PARTICLES
	return material


func _make_falling_streak_texture() -> ImageTexture:
	const width := 32
	const height := 128
	var image := Image.create(width, height, false, Image.FORMAT_RGBA8)
	for y in height:
		var vertical := float(y) / float(height - 1)
		var length_fade := (
			smoothstep(0.0, 0.05, vertical)
			* (1.0 - smoothstep(0.48, 1.0, vertical))
		)
		var center_x := 0.5 + sin(vertical * 21.0) * 0.045
		var line_width := 0.10 + 0.035 * sin(vertical * 37.0)
		for x in width:
			var horizontal := float(x) / float(width - 1)
			var across := absf(horizontal - center_x)
			var soft_line := 1.0 - smoothstep(
				line_width * 0.20,
				line_width,
				across
			)
			var broken := 0.72 + 0.28 * sin(vertical * 73.0 + 1.8)
			var alpha := clampf(soft_line * length_fade * broken, 0.0, 1.0)
			image.set_pixel(x, y, Color(0.90, 1.0, 1.0, alpha))
	return ImageTexture.create_from_image(image)


func _find_planet_root() -> Node3D:
	var candidate := get_parent()
	while candidate != null:
		if candidate.get_node_or_null("PlanetBase") != null:
			return candidate as Node3D
		candidate = candidate.get_parent()
	return null


func _find_river_guide_mesh(base: Node3D) -> MeshInstance3D:
	var mesh_instances: Array[Node] = base.find_children(
		"*",
		"MeshInstance3D",
		true,
		false
	)
	for item in mesh_instances:
		var instance := item as MeshInstance3D
		if instance == null or instance.mesh == null:
			continue
		var node_name := instance.name.to_lower()
		if node_name.contains("圆管") or node_name.contains("river"):
			return instance
	return null
