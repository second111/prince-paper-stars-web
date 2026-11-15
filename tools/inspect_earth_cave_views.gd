extends SceneTree


const HILL_PATH := "res://assets/3d/earth/earth_hill.glb"
const FOX_PATH := "res://assets/3d/earth/quaternius_fox_animated.glb"
const OUTPUT_DIR := "res://tools/test_output/earth_cave_views"


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUTPUT_DIR))
	var world := Node3D.new()
	root.add_child(world)
	var hill_scene := load(HILL_PATH) as PackedScene
	if hill_scene == null:
		printerr("Unable to load ", HILL_PATH)
		quit(1)
		return
	var hill := hill_scene.instantiate() as Node3D
	world.add_child(hill)
	var environment := WorldEnvironment.new()
	var environment_resource := Environment.new()
	environment_resource.background_mode = Environment.BG_COLOR
	environment_resource.background_color = Color(0.06, 0.10, 0.18)
	environment_resource.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment_resource.ambient_light_color = Color(0.72, 0.78, 0.95)
	environment_resource.ambient_light_energy = 0.7
	environment_resource.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.environment = environment_resource
	world.add_child(environment)
	var key_light := DirectionalLight3D.new()
	key_light.rotation_degrees = Vector3(-48.0, -34.0, 0.0)
	key_light.light_energy = 1.7
	key_light.shadow_enabled = true
	world.add_child(key_light)
	var fill_light := DirectionalLight3D.new()
	fill_light.rotation_degrees = Vector3(-20.0, 138.0, 0.0)
	fill_light.light_energy = 0.65
	world.add_child(fill_light)
	var camera := Camera3D.new()
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 1.9
	world.add_child(camera)
	camera.current = true

	var bounds := AABB()
	var has_bounds := false
	for item in hill.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var item_bounds := (
			hill.global_transform.affine_inverse()
			* mesh_instance.global_transform
			* mesh_instance.get_aabb()
		)
		bounds = item_bounds if not has_bounds else bounds.merge(item_bounds)
		has_bounds = true
	print("HILL_BOUNDS=", bounds)
	var center := bounds.get_center()
	camera.size = maxf(bounds.size.x, bounds.size.y) * 1.26

	var views := {
		"front_neg_z": Vector3(0.0, 0.22, -2.4),
		"back_pos_z": Vector3(0.0, 0.22, 2.4),
		"left_neg_x": Vector3(-2.4, 0.22, 0.0),
		"right_pos_x": Vector3(2.4, 0.22, 0.0),
		"top_pos_y": Vector3(0.0, 2.4, 0.001),
	}
	for view_name in views:
		camera.position = center + (views[view_name] as Vector3)
		camera.look_at(center, Vector3.UP if view_name != "top_pos_y" else Vector3.FORWARD)
		await process_frame
		await process_frame
		var image := root.get_texture().get_image()
		if image != null and not image.is_empty():
			var output_path := OUTPUT_DIR.path_join("%s.png" % view_name)
			image.save_png(output_path)
			print("SAVED=", output_path)
			if view_name == "right_pos_x":
				_report_front_opening(image, camera)
	hill.visible = false
	var fox_scene := load(FOX_PATH) as PackedScene
	if fox_scene != null:
		var fox := fox_scene.instantiate() as Node3D
		world.add_child(fox)
		var animation_players := fox.find_children("*", "AnimationPlayer", true, false)
		var animation_player := (
			animation_players.front() as AnimationPlayer
			if not animation_players.is_empty()
			else null
		)
		if animation_player != null:
			print("FOX_ANIMATIONS=", animation_player.get_animation_list())
			if animation_player.has_animation("Idle_2"):
				animation_player.play("Idle_2")
				animation_player.advance(0.2)
		var fox_bounds := AABB()
		var fox_has_bounds := false
		for item in fox.find_children("*", "MeshInstance3D", true, false):
			var mesh_instance := item as MeshInstance3D
			if mesh_instance.mesh == null:
				continue
			var item_bounds: AABB = (
				fox.global_transform.affine_inverse()
				* mesh_instance.global_transform
				* mesh_instance.get_aabb()
			)
			fox_bounds = item_bounds if not fox_has_bounds else fox_bounds.merge(item_bounds)
			fox_has_bounds = true
		var fox_center := fox_bounds.get_center()
		var fox_distance := maxf(fox_bounds.size.x, maxf(fox_bounds.size.y, fox_bounds.size.z)) * 2.2
		camera.size = maxf(fox_bounds.size.x, fox_bounds.size.y) * 1.35
		var fox_views := {
			"fox_from_neg_x": Vector3(-fox_distance, 0.0, 0.0),
			"fox_from_pos_x": Vector3(fox_distance, 0.0, 0.0),
			"fox_from_neg_z": Vector3(0.0, 0.0, -fox_distance),
			"fox_from_pos_z": Vector3(0.0, 0.0, fox_distance),
		}
		for view_name in fox_views:
			camera.position = fox_center + (fox_views[view_name] as Vector3)
			camera.look_at(fox_center, Vector3.UP)
			await process_frame
			await process_frame
			var image := root.get_texture().get_image()
			if image != null and not image.is_empty():
				var output_path := OUTPUT_DIR.path_join("%s.png" % view_name)
				image.save_png(output_path)
				print("SAVED=", output_path)
	world.queue_free()
	await process_frame
	quit(0)


func _report_front_opening(image: Image, camera: Camera3D) -> void:
	var width := image.get_width()
	var height := image.get_height()
	var mask := PackedByteArray()
	mask.resize(width * height)
	for y in height:
		for x in width:
			var color := image.get_pixel(x, y)
			if color.get_luminance() < 0.095:
				mask[y * width + x] = 1
	var seed_index := (height / 2) * width + width / 2
	if mask[seed_index] == 0:
		printerr("FRONT_OPENING seed is not dark")
		return
	var queue: Array[int] = [seed_index]
	var head := 0
	var minimum := Vector2i(width, height)
	var maximum := Vector2i(-1, -1)
	var count := 0
	while head < queue.size():
		var index := queue[head]
		head += 1
		var x := index % width
		var y := index / width
		minimum.x = mini(minimum.x, x)
		minimum.y = mini(minimum.y, y)
		maximum.x = maxi(maximum.x, x)
		maximum.y = maxi(maximum.y, y)
		count += 1
		for neighbor in [index - 1, index + 1, index - width, index + width]:
			if neighbor < 0 or neighbor >= mask.size() or mask[neighbor] == 0:
				continue
			var neighbor_x: int = neighbor % width
			if absi(neighbor_x - x) > 1:
				continue
			mask[neighbor] = 0
			queue.append(neighbor)
	var opening_center := (Vector2(minimum) + Vector2(maximum)) * 0.5
	var ndc := Vector2(
		opening_center.x / float(width) * 2.0 - 1.0,
		1.0 - opening_center.y / float(height) * 2.0
	)
	var camera_basis := camera.global_transform.basis
	var horizontal_size := camera.size * float(width) / float(height)
	var opening_world := (
		camera.global_position
		+ camera_basis.x * ndc.x * horizontal_size * 0.5
		+ camera_basis.y * ndc.y * camera.size * 0.5
	)
	print(
		"FRONT_OPENING count=",
		count,
		" screen_min=",
		minimum,
		" screen_max=",
		maximum,
		" screen_center=",
		opening_center,
		" projected_center=",
		opening_world
	)

