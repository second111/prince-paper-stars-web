extends Node3D


const ROPE_SEGMENTS := 34
const CURVE_SAMPLES := 64
const BULB_SPACING := 0.06
const MIN_BULBS := 16
const MAX_BULBS := 40

var start_point := Vector3.ZERO
var sag_point := Vector3.ZERO
var end_point := Vector3.ZERO
var brightness := 1.0
var light_on := true

var _rope_root: Node3D
var _rope_mesh: CylinderMesh
var _rope_material: StandardMaterial3D
var _bulbs_root: Node3D
var _bulb_texture: Texture2D
var _bulb_material: StandardMaterial3D
var _bulb_mesh: QuadMesh
var _bulb_glows: Array[MeshInstance3D] = []
var _lights: Array[OmniLight3D] = []
var _handles: Array[MeshInstance3D] = []
var _handles_visible := false
var _bulb_count := 0


func _ready() -> void:
	_build_nodes()
	_refresh_visual()


func set_curve(
	new_start: Vector3,
	new_sag: Vector3,
	new_end: Vector3
) -> void:
	start_point = new_start
	sag_point = new_sag
	end_point = new_end
	if is_node_ready():
		_refresh_visual()


func set_edit_handles_visible(visible_now: bool) -> void:
	_handles_visible = visible_now
	for handle in _handles:
		handle.visible = visible_now


func set_light_state(new_brightness: float, enabled: bool) -> void:
	brightness = clampf(new_brightness, 0.1, 2.5)
	light_on = enabled
	var intensity := brightness if enabled else 0.0
	if _bulb_material != null:
		_bulb_material.emission_energy_multiplier = 3.0 * intensity
	_bulbs_root.visible = enabled
	for light in _lights:
		light.light_energy = float(light.get_meta("base_energy", 0.8)) * intensity
		light.visible = enabled


func get_bulb_count() -> int:
	return _bulb_count


func get_handle_world_position(handle_index: int) -> Vector3:
	if not _handles_visible or handle_index < 0 or handle_index >= _handles.size():
		return Vector3.INF
	return _handles[handle_index].global_position


func get_handle_points() -> Array[Vector3]:
	return [start_point, sag_point, end_point]


func rotate_around_center(delta_degrees: float, axis := Vector3.UP) -> void:
	var normalized_axis := axis.normalized()
	if normalized_axis.length_squared() < 0.000001:
		normalized_axis = Vector3.UP
	var pivot := (start_point + sag_point + end_point) / 3.0
	var rotation := Basis(normalized_axis, deg_to_rad(delta_degrees))
	start_point = pivot + rotation * (start_point - pivot)
	sag_point = pivot + rotation * (sag_point - pivot)
	end_point = pivot + rotation * (end_point - pivot)
	_refresh_visual()


func _build_nodes() -> void:
	_rope_root = Node3D.new()
	_rope_root.name = "RopeSegments"
	add_child(_rope_root)

	_rope_material = StandardMaterial3D.new()
	_rope_material.albedo_color = Color(0.68, 0.48, 0.22)
	_rope_material.roughness = 0.76
	_rope_material.metallic = 0.04
	_rope_mesh = CylinderMesh.new()
	_rope_mesh.top_radius = 0.002
	_rope_mesh.bottom_radius = 0.002
	_rope_mesh.height = 1.0
	_rope_mesh.radial_segments = 5
	_rope_mesh.rings = 1
	_rope_mesh.material = _rope_material

	_bulb_texture = _make_bulb_texture()
	_bulb_material = StandardMaterial3D.new()
	_bulb_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_bulb_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_bulb_material.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
	_bulb_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	_bulb_material.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED
	_bulb_material.billboard_keep_scale = true
	_bulb_material.albedo_texture = _bulb_texture
	_bulb_material.albedo_color = Color(1.0, 0.86, 0.58, 1.0)
	_bulb_material.emission_enabled = true
	_bulb_material.emission_texture = _bulb_texture
	_bulb_material.emission = Color(1.0, 0.72, 0.32)
	_bulb_material.emission_energy_multiplier = 3.0
	_bulb_material.render_priority = 4
	_bulb_mesh = QuadMesh.new()
	_bulb_mesh.size = Vector2.ONE
	_bulb_mesh.material = _bulb_material
	_bulbs_root = Node3D.new()
	_bulbs_root.name = "SoftStarBulbs"
	add_child(_bulbs_root)

	for index in 3:
		var light := OmniLight3D.new()
		light.name = "StringSoftLight_%02d" % (index + 1)
		light.light_color = Color(1.0, 0.78, 0.46)
		light.light_energy = [0.12, 0.18, 0.12][index]
		light.omni_range = 32.0
		light.omni_attenuation = 1.1
		light.shadow_enabled = false
		light.set_meta("base_energy", light.light_energy)
		add_child(light)
		_lights.append(light)

	var handle_colors := [
		Color(1.0, 0.84, 0.50),
		Color(1.0, 0.84, 0.50),
	]
	var handle_mesh := SphereMesh.new()
	handle_mesh.radius = 0.030
	handle_mesh.height = 0.060
	handle_mesh.radial_segments = 12
	handle_mesh.rings = 6
	for index in 2:
		var material := StandardMaterial3D.new()
		material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = handle_colors[index]
		material.emission_enabled = true
		material.emission = handle_colors[index]
		material.emission_energy_multiplier = 1.8
		var handle := MeshInstance3D.new()
		handle.name = ["StartHandle", "EndHandle"][index]
		handle.mesh = handle_mesh
		handle.material_override = material
		handle.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		handle.visible = false
		add_child(handle)
		_handles.append(handle)


func _refresh_visual() -> void:
	if _rope_root == null:
		return
	for child in _rope_root.get_children():
		child.queue_free()
	var samples: Array[Vector3] = []
	for sample_index in CURVE_SAMPLES + 1:
		var t := float(sample_index) / float(CURVE_SAMPLES)
		samples.append(_curve_point(t))
	var lengths: Array[float] = [0.0]
	var total_length := 0.0
	for index in range(1, samples.size()):
		total_length += samples[index - 1].distance_to(samples[index])
		lengths.append(total_length)
	if total_length < 0.02:
		return
	for segment_index in ROPE_SEGMENTS:
		var start := _point_at_arc(
			float(segment_index) / float(ROPE_SEGMENTS),
			samples,
			lengths,
			total_length
		)
		var end := _point_at_arc(
			float(segment_index + 1) / float(ROPE_SEGMENTS),
			samples,
			lengths,
			total_length
		)
		var segment := MeshInstance3D.new()
		segment.name = "Rope_%02d" % segment_index
		segment.mesh = _rope_mesh
		segment.transform = _segment_transform(start, end)
		segment.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		_rope_root.add_child(segment)
	_bulb_count = clampi(
		roundi(total_length / BULB_SPACING),
		MIN_BULBS,
		MAX_BULBS
	)
	for child in _bulbs_root.get_children():
		child.queue_free()
	_bulb_glows.clear()
	for bulb_index in _bulb_count:
		var arc_fraction := (float(bulb_index) + 0.5) / float(_bulb_count)
		var bulb := MeshInstance3D.new()
		bulb.name = "SoftBulb_%02d" % bulb_index
		bulb.mesh = _bulb_mesh
		bulb.scale = Vector3.ONE * (
			0.075 + 0.012 * sin(float(bulb_index) * 1.73)
		)
		bulb.position = _point_at_arc(
			arc_fraction,
			samples,
			lengths,
			total_length
		)
		bulb.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		_bulbs_root.add_child(bulb)
		_bulb_glows.append(bulb)
	var light_arc_fractions := [0.14, 0.50, 0.86]
	for light_index in _lights.size():
		_lights[light_index].position = _point_at_arc(
			float(light_arc_fractions[light_index]),
			samples,
			lengths,
			total_length
		)
	_handles[0].position = start_point
	_handles[1].position = end_point
	set_light_state(brightness, light_on)


func _make_bulb_texture() -> Texture2D:
	var gradient := Gradient.new()
	gradient.offsets = PackedFloat32Array([0.0, 0.10, 0.26, 0.46, 1.0])
	gradient.colors = PackedColorArray([
		Color(1.0, 0.99, 0.90, 1.0),
		Color(1.0, 0.93, 0.68, 0.86),
		Color(1.0, 0.78, 0.38, 0.34),
		Color(1.0, 0.57, 0.18, 0.08),
		Color(1.0, 0.38, 0.08, 0.0),
	])
	var texture := GradientTexture2D.new()
	texture.width = 96
	texture.height = 96
	texture.fill = GradientTexture2D.FILL_RADIAL
	texture.fill_from = Vector2(0.5, 0.5)
	texture.fill_to = Vector2(1.0, 0.5)
	texture.gradient = gradient
	return texture


func _curve_point(t: float) -> Vector3:
	var control_point := sag_point * 2.0 - (start_point + end_point) * 0.5
	var inverse_t := 1.0 - t
	return (
		start_point * inverse_t * inverse_t
		+ control_point * 2.0 * inverse_t * t
		+ end_point * t * t
	)


func _point_at_arc(
	arc_fraction: float,
	samples: Array[Vector3],
	lengths: Array[float],
	total_length: float
) -> Vector3:
	var target_length := clampf(arc_fraction, 0.0, 1.0) * total_length
	for index in range(1, lengths.size()):
		if lengths[index] < target_length:
			continue
		var span := maxf(lengths[index] - lengths[index - 1], 0.00001)
		var weight := (target_length - lengths[index - 1]) / span
		return samples[index - 1].lerp(samples[index], weight)
	return samples[-1]


func _segment_transform(start: Vector3, end: Vector3) -> Transform3D:
	var direction := end - start
	var length := direction.length()
	if length <= 0.00001:
		return Transform3D(Basis.IDENTITY, start)
	var axis := Vector3.UP.cross(direction.normalized())
	var rotation := Basis.IDENTITY
	if axis.length_squared() > 0.000001:
		rotation = Basis(
			axis.normalized(),
			Vector3.UP.angle_to(direction.normalized())
		)
	return Transform3D(
		rotation * Basis.from_scale(Vector3(1.0, length * 1.12, 1.0)),
		(start + end) * 0.5
	)
