extends RefCounted


static func cache_signature(asset_data: Dictionary) -> String:
	var stable_data := {
		"kind": String(asset_data.get("kind", "asset")),
		"path": String(asset_data.get("path", "")),
		"extent": float(asset_data.get("extent", 0.7)),
		"parts": asset_data.get("parts", []),
		"layout_source": String(asset_data.get("layout_source", "")),
		"layout_kinds": asset_data.get("layout_kinds", []),
		"layout_light_ids": asset_data.get("layout_light_ids", []),
		"thumbnail_path": String(asset_data.get("thumbnail_path", "")),
	}
	var layout_source := String(asset_data.get("layout_source", ""))
	if not layout_source.is_empty():
		var layout_path := layout_source
		if layout_source.begins_with("res://"):
			var user_path := "user://" + layout_source.trim_prefix("res://")
			if FileAccess.file_exists(user_path):
				layout_path = user_path
		if FileAccess.file_exists(layout_path):
			stable_data["layout_hash"] = FileAccess.get_file_as_string(
				layout_path
			).hash()
	return "%s_%d" % [
		String(stable_data.kind),
		JSON.stringify(stable_data).hash(),
	]


static func instantiate_fitted(asset_data: Dictionary, target_extent := -1.0) -> Node3D:
	if asset_data.is_empty():
		return null
	var root := Node3D.new()
	root.name = "FittedAsset"
	var content := Node3D.new()
	content.name = "Visual"
	root.add_child(content)
	var layout_source := String(asset_data.get("layout_source", ""))
	var parts = asset_data.get("parts", [])
	if not layout_source.is_empty():
		_add_layout_parts(content, asset_data)
	elif typeof(parts) == TYPE_ARRAY and not parts.is_empty():
		for part_value in parts:
			if typeof(part_value) != TYPE_DICTIONARY:
				continue
			_add_part(content, part_value as Dictionary)
	else:
		_add_part(content, {
			"path": String(asset_data.get("path", "")),
			"position": Vector3.ZERO,
		})
	var bounds := collect_bounds(content, Transform3D.IDENTITY)
	if bounds.size == Vector3.ZERO:
		root.free()
		return null
	var fit_extent := (
		target_extent
		if target_extent > 0.0
		else float(asset_data.get("extent", 0.7))
	)
	var longest_extent := maxf(
		bounds.size.x,
		maxf(bounds.size.y, bounds.size.z)
	)
	var uniform_scale := maxf(fit_extent, 0.02) / maxf(longest_extent, 0.0001)
	content.scale = Vector3.ONE * uniform_scale
	content.position = Vector3(
		-bounds.get_center().x * uniform_scale,
		-bounds.position.y * uniform_scale,
		-bounds.get_center().z * uniform_scale
	)
	root.set_meta("asset_fit_scale", uniform_scale)
	return root


static func _add_layout_parts(parent: Node3D, asset_data: Dictionary) -> void:
	var source := String(asset_data.get("layout_source", ""))
	var layout_path := source
	if source.begins_with("res://"):
		var user_path := "user://" + source.trim_prefix("res://")
		if FileAccess.file_exists(user_path):
			layout_path = user_path
	if not FileAccess.file_exists(layout_path):
		push_warning("Player composite layout is missing: " + layout_path)
		return
	var parsed = JSON.parse_string(FileAccess.get_file_as_string(layout_path))
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	var records_by_kind := {}
	var records_by_id := {}
	for object_value in (parsed as Dictionary).get("objects", []):
		if typeof(object_value) != TYPE_DICTIONARY:
			continue
		var record := object_value as Dictionary
		records_by_kind[String(record.get("kind", ""))] = record
		records_by_id[String(record.get("id", ""))] = record
	var layout_kinds: Array = asset_data.get("layout_kinds", [])
	var anchor_kind := String(
		asset_data.get("layout_anchor", layout_kinds[0] if not layout_kinds.is_empty() else "")
	)
	if not records_by_kind.has(anchor_kind):
		push_warning("Player composite anchor is missing: " + anchor_kind)
		return
	var anchor_record: Dictionary = records_by_kind[anchor_kind]
	var anchor_normal := _record_vector3(anchor_record, "normal", Vector3.UP).normalized()
	var anchor_origin := anchor_normal * float(
		anchor_record.get("root_radius", 2.48)
	)
	var anchor_basis := (
		_normal_surface_basis(
			anchor_normal,
			float(anchor_record.get("yaw", 0.0))
		)
		* Basis(
			Vector3.RIGHT,
			deg_to_rad(float(anchor_record.get("surface_tilt", 0.0)))
		)
	)
	var anchor_inverse := Transform3D(anchor_basis, anchor_origin).affine_inverse()
	for kind_value in layout_kinds:
		var kind := String(kind_value)
		if not records_by_kind.has(kind):
			continue
		var record: Dictionary = records_by_kind[kind]
		var path := String(record.get("asset_path", ""))
		if not ResourceLoader.exists(path):
			continue
		var normal := _record_vector3(record, "normal", anchor_normal).normalized()
		var origin := normal * float(record.get("root_radius", 2.48))
		var absolute_basis := (
			_normal_surface_basis(
				normal,
				float(record.get("yaw", 0.0))
			)
			* Basis(
				Vector3.RIGHT,
				deg_to_rad(float(record.get("surface_tilt", 0.0)))
			)
		)
		var relative_transform := (
			anchor_inverse
			* Transform3D(absolute_basis, origin)
		)
		var packed := ResourceLoader.load(
			path,
			"PackedScene",
			ResourceLoader.CACHE_MODE_REUSE
		) as PackedScene
		if packed == null:
			continue
		var model := packed.instantiate() as Node3D
		if model == null:
			continue
		var bounds := collect_bounds(model, Transform3D.IDENTITY)
		if bounds.size == Vector3.ZERO:
			model.free()
			continue
		var base_scale := float(record.get("base_scale", 1.0))
		var part_rig := Node3D.new()
		part_rig.name = kind
		part_rig.transform = relative_transform
		part_rig.scale = Vector3.ONE * float(record.get("scale", 1.0))
		model.scale = Vector3.ONE * base_scale
		model.position = -Vector3(
			bounds.get_center().x,
			bounds.position.y,
			bounds.get_center().z
		) * base_scale
		model.name = path.get_file().get_basename()
		part_rig.add_child(model)
		parent.add_child(part_rig)
		if kind == "glass_dome":
			_apply_glass_material(model)
	for light_id_value in asset_data.get("layout_light_ids", []):
		var light_id := String(light_id_value)
		if not records_by_id.has(light_id):
			continue
		var light_record: Dictionary = records_by_id[light_id]
		var light_normal := _record_vector3(
			light_record,
			"normal",
			anchor_normal
		).normalized()
		var light_origin := light_normal * float(
			light_record.get("root_radius", 3.0)
		)
		var light_node := Node3D.new()
		light_node.name = "CopiedRoseGlow"
		light_node.transform = (
			anchor_inverse
			* Transform3D(Basis.IDENTITY, light_origin)
		)
		light_node.scale = Vector3.ONE * float(
			light_record.get("scale", 0.3)
		)
		var light := OmniLight3D.new()
		light.light_color = Color(1.0, 0.78, 0.44)
		light.light_energy = 0.18 * float(
			light_record.get("brightness", 0.25)
		) / 0.25
		light.omni_range = 32.0
		light.omni_attenuation = 1.15
		light.shadow_enabled = false
		light_node.add_child(light)
		var glow_material := StandardMaterial3D.new()
		glow_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		glow_material.albedo_color = Color(1.0, 0.83, 0.52)
		glow_material.emission_enabled = true
		glow_material.emission = Color(1.0, 0.64, 0.26)
		glow_material.emission_energy_multiplier = 2.4
		var glow_mesh := SphereMesh.new()
		glow_mesh.radius = 0.06
		glow_mesh.height = 0.12
		glow_mesh.radial_segments = 10
		glow_mesh.rings = 5
		glow_mesh.material = glow_material
		var glow := MeshInstance3D.new()
		glow.name = "GlowCore"
		glow.mesh = glow_mesh
		glow.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		light_node.add_child(glow)
		parent.add_child(light_node)


static func _record_vector3(
	record: Dictionary,
	key: String,
	fallback: Vector3
) -> Vector3:
	var value = record.get(key, null)
	if value is Vector3:
		return value as Vector3
	if typeof(value) == TYPE_ARRAY and value.size() >= 3:
		return Vector3(
			float(value[0]),
			float(value[1]),
			float(value[2])
		)
	return fallback


static func _normal_surface_basis(normal: Vector3, yaw_degrees: float) -> Basis:
	var surface_normal := normal.normalized()
	var align := Basis.IDENTITY
	var dot := Vector3.UP.dot(surface_normal)
	if dot < -0.9999:
		align = Basis(Vector3.RIGHT, PI)
	elif dot < 0.9999:
		align = Basis(
			Vector3.UP.cross(surface_normal).normalized(),
			acos(dot)
		)
	var yaw := Basis(surface_normal, deg_to_rad(yaw_degrees))
	return yaw * align


static func _apply_glass_material(model: Node) -> void:
	var glass_material := StandardMaterial3D.new()
	glass_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	glass_material.albedo_color = Color(0.68, 0.82, 0.88, 0.20)
	glass_material.metallic = 0.08
	glass_material.roughness = 0.08
	glass_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	glass_material.rim_enabled = true
	glass_material.rim = 0.42
	glass_material.rim_tint = 0.38
	for item in model.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance != null:
			mesh_instance.material_override = glass_material


static func _add_part(parent: Node3D, part_data: Dictionary) -> void:
	var path := String(part_data.get("path", ""))
	if path.is_empty() or not ResourceLoader.exists(path):
		push_warning("Player asset part is missing: " + path)
		return
	var packed := ResourceLoader.load(
		path,
		"PackedScene",
		ResourceLoader.CACHE_MODE_REUSE
	) as PackedScene
	if packed == null:
		push_warning("Player asset part failed to load: " + path)
		return
	var model := packed.instantiate() as Node3D
	if model == null:
		return
	var bounds := collect_bounds(model, Transform3D.IDENTITY)
	if bounds.size == Vector3.ZERO:
		model.free()
		return
	var part_scale := 1.0
	if part_data.has("target_height"):
		part_scale = (
			maxf(float(part_data.target_height), 0.001)
			/ maxf(bounds.size.y, 0.0001)
		)
	elif part_data.has("target_extent"):
		var part_extent := maxf(
			bounds.size.x,
			maxf(bounds.size.y, bounds.size.z)
		)
		part_scale = (
			maxf(float(part_data.target_extent), 0.001)
			/ maxf(part_extent, 0.0001)
		)
	var position: Vector3 = part_data.get("position", Vector3.ZERO)
	var rotation_degrees: Vector3 = part_data.get(
		"rotation_degrees",
		Vector3.ZERO
	)
	model.scale = Vector3.ONE * part_scale
	model.position = Vector3(
		-bounds.get_center().x * part_scale + position.x,
		-bounds.position.y * part_scale + position.y,
		-bounds.get_center().z * part_scale + position.z
	)
	model.rotation_degrees = rotation_degrees
	model.name = path.get_file().get_basename()
	parent.add_child(model)
	if bool(part_data.get("glass", false)):
		_apply_glass_material(model)
	if (
		part_data.has("transparency")
		and not bool(part_data.get("glass", false))
	):
		var transparency := clampf(
			float(part_data.transparency),
			0.0,
			1.0
		)
		for item in model.find_children("*", "MeshInstance3D", true, false):
			var mesh_instance := item as MeshInstance3D
			if mesh_instance != null:
				mesh_instance.transparency = transparency


static func collect_bounds(node: Node, relative_transform: Transform3D) -> AABB:
	var bounds := AABB()
	var has_bounds := false
	if node is MeshInstance3D:
		var mesh_instance := node as MeshInstance3D
		if mesh_instance.mesh != null:
			bounds = relative_transform * mesh_instance.get_aabb()
			has_bounds = true
	for child in node.get_children():
		if not child is Node3D:
			continue
		var child_bounds := collect_bounds(
			child,
			relative_transform * (child as Node3D).transform
		)
		if child_bounds.size == Vector3.ZERO:
			continue
		bounds = child_bounds if not has_bounds else bounds.merge(child_bounds)
		has_bounds = true
	return bounds
