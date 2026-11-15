extends SceneTree


func _initialize() -> void:
	var scene := load(
		"res://assets/3d/player/player_planet_base_river_guide.glb"
	) as PackedScene
	var root := scene.instantiate()
	var meshes := root.find_children("*", "MeshInstance3D", true, false)
	for item in meshes:
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		print(
			"MESH ", mesh_instance.name,
			" bounds=", mesh_instance.mesh.get_aabb(),
			" surfaces=", mesh_instance.mesh.get_surface_count()
		)
		for surface in mesh_instance.mesh.get_surface_count():
			var arrays := mesh_instance.mesh.surface_get_arrays(surface)
			var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
			var uvs := (
				arrays[Mesh.ARRAY_TEX_UV] as PackedVector2Array
				if arrays[Mesh.ARRAY_TEX_UV] is PackedVector2Array
				else PackedVector2Array()
			)
			var normals := (
				arrays[Mesh.ARRAY_NORMAL] as PackedVector3Array
				if arrays[Mesh.ARRAY_NORMAL] is PackedVector3Array
				else PackedVector3Array()
			)
			var indices_value = arrays[Mesh.ARRAY_INDEX]
			var minimum_uv := Vector2(INF, INF)
			var maximum_uv := Vector2(-INF, -INF)
			for uv in uvs:
				minimum_uv.x = minf(minimum_uv.x, uv.x)
				minimum_uv.y = minf(minimum_uv.y, uv.y)
				maximum_uv.x = maxf(maximum_uv.x, uv.x)
				maximum_uv.y = maxf(maximum_uv.y, uv.y)
			var minimum_normal_y := INF
			var maximum_normal_y := -INF
			for normal in normals:
				minimum_normal_y = minf(minimum_normal_y, normal.y)
				maximum_normal_y = maxf(maximum_normal_y, normal.y)
			print(
				"  surface=", surface,
				" vertices=", vertices.size(),
				" uvs=", uvs.size(),
				" normals=", normals.size(),
				" indices=", (
					indices_value.size()
					if indices_value is PackedInt32Array
					else 0
				),
				" uv=", minimum_uv, "..", maximum_uv,
				" normal_y=", minimum_normal_y, "..", maximum_normal_y
			)
			for index in mini(12, vertices.size()):
				print(
					"    v=", vertices[index],
					" uv=", uvs[index] if index < uvs.size() else Vector2.ZERO,
					" n=", normals[index] if index < normals.size() else Vector3.ZERO
				)
	root.free()
	quit()
