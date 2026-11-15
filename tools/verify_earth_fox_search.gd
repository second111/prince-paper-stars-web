extends SceneTree


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var failures: Array[String] = []
	var main: Node = load("res://main.tscn").instantiate()
	root.add_child(main)
	var deadline := Time.get_ticks_msec() + 45000
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "earth"
			and bool(main.get("stage_3d").visible)
		):
			break
		await create_timer(0.2).timeout
	await create_timer(0.8).timeout
	if not bool(main.get("earth_fox_search_active")):
		failures.append("search-not-started")
	if String(main.get("story_action_phase")) != "fox_search":
		failures.append("search-phase")
	var hint := main.get("hud_scene_hint") as Label
	if hint == null or hint.text != "寻找到狐狸":
		failures.append("search-hint")
	var search_controls := main.get("earth_fox_search_controls") as Label
	if search_controls == null:
		failures.append("search-controls-missing")
	elif (
		not search_controls.visible
		or search_controls.text != "拖动星球寻找 · 滚轮缩放 · 双击复位"
	):
		failures.append("search-controls")
	await process_frame
	var start_image := root.get_texture().get_image()
	if start_image != null and not start_image.is_empty():
		start_image.save_png("res://tools/test_output/earth_fox_search_start.png")
	var fox_index := int(main.call("_find_editable_record_index_by_kind", "fox"))
	var hill_index := int(main.call("_find_editable_record_index_by_kind", "earth_hill"))
	var fox_record: Dictionary = main.get("editable_3d_objects")[fox_index]
	var fox := fox_record.get("node") as Node3D
	var hill := main.get("editable_3d_objects")[hill_index].get("node") as Node3D
	var camera := main.get("camera_3d") as Camera3D
	var hill_inverse := hill.global_transform.affine_inverse()
	var hill_local_bounds := AABB()
	var hill_has_bounds := false
	for item in hill.find_children("*", "MeshInstance3D", true, false):
		var mesh_instance := item as MeshInstance3D
		if mesh_instance.mesh == null:
			continue
		var mesh_bounds: AABB = (
			hill_inverse
			* mesh_instance.global_transform
			* mesh_instance.get_aabb()
		)
		hill_local_bounds = (
			mesh_bounds
			if not hill_has_bounds
			else hill_local_bounds.merge(mesh_bounds)
		)
		hill_has_bounds = true
	print(
		"HILL_LOCAL_BOUNDS=",
		hill_local_bounds,
		" hill_scale=",
		hill.scale,
		" +Z_TO_CAMERA=",
		hill.global_transform.basis.z.normalized().dot(
			(camera.global_position - hill.global_position).normalized()
		),
		" -Z_TO_CAMERA=",
		(-hill.global_transform.basis.z.normalized()).dot(
			(camera.global_position - hill.global_position).normalized()
		)
	)
	var target_normal := (
		main.get("editable_3d_objects")[hill_index].get("normal") as Vector3
	).normalized()
	var fox_center: Vector3 = (
		main.call("_editable_world_bounds", fox) as AABB
	).get_center()
	if main.call("_earth_fox_hit_at_screen", camera.unproject_position(fox_center)):
		failures.append("fox-clickable-before-reveal")
	main.call("_apply_model_orbit_delta", Vector2(PI, 0.0))
	await process_frame
	await process_frame
	fox_center = (main.call("_editable_world_bounds", fox) as AABB).get_center()
	var fox_screen := camera.unproject_position(fox_center)
	var revealed_image := root.get_texture().get_image()
	if revealed_image != null and not revealed_image.is_empty():
		revealed_image.save_png("res://tools/test_output/earth_fox_search_revealed.png")
	if not main.call("_earth_fox_hit_at_screen", fox_screen):
		failures.append("fox-not-clickable-after-reveal")
	var click := InputEventMouseButton.new()
	click.button_index = MOUSE_BUTTON_LEFT
	click.pressed = true
	click.position = fox_screen
	var click_started_usec := Time.get_ticks_usec()
	if not bool(main.call("_handle_story_pointer_event", click)):
		failures.append("fox-click-not-consumed")
	var click_dispatch_ms := float(
		Time.get_ticks_usec() - click_started_usec
	) / 1000.0
	print("EARTH_FOX_CLICK_DISPATCH_MS=", click_dispatch_ms)
	if click_dispatch_ms > 500.0:
		failures.append("fox-click-synchronous-stall")
	var ground_body := main.get("earth_fox_ground_body") as StaticBody3D
	if ground_body == null or not is_instance_valid(ground_body):
		failures.append("fox-ground-collider-missing")
	await create_timer(1.2).timeout
	var first_run_image := root.get_texture().get_image()
	if first_run_image != null and not first_run_image.is_empty():
		first_run_image.save_png("res://tools/test_output/earth_fox_search_run_1.png")
	var model := main.get("model_3d") as Node3D
	var fox_local := model.global_transform.affine_inverse() * fox.global_position
	var expected_ground := float(
		main.call("_earth_fox_surface_radius", fox_local.normalized())
	)
	if absf(fox_local.length() - expected_ground) > 0.025:
		failures.append("fox-floating-during-run-1")
	await create_timer(1.8).timeout
	var second_run_image := root.get_texture().get_image()
	if second_run_image != null and not second_run_image.is_empty():
		second_run_image.save_png("res://tools/test_output/earth_fox_search_run_2.png")
	fox_local = model.global_transform.affine_inverse() * fox.global_position
	expected_ground = float(
		main.call("_earth_fox_surface_radius", fox_local.normalized())
	)
	if absf(fox_local.length() - expected_ground) > 0.025:
		failures.append("fox-floating-during-run-2")
	await create_timer(4.2).timeout
	if bool(main.get("earth_fox_search_running")):
		failures.append("search-still-running")
	if String(main.get("planet_story_states").get("earth", "")) != "fox_found":
		failures.append("fox-found-state")
	if String(main.get("story_action_phase")) != "":
		failures.append("action-phase-not-cleared")
	if String(fox_record.get("selected_animation", "")) != "Idle_2":
		failures.append("arrival-idle")
	if not bool(main.get("earth_fox_inside_cave")):
		failures.append("fox-not-inside-cave")
	var expected_inside_world := hill.global_transform * Vector3(
		0.50,
		0.065,
		0.0
	)
	if fox.global_position.distance_to(expected_inside_world) > 0.02:
		failures.append("fox-cave-standing-position")
	var cave_outward := hill.global_transform.basis.x.normalized()
	var fox_forward := fox.global_transform.basis.z.normalized()
	if fox_forward.dot(cave_outward) < 0.98:
		failures.append("fox-not-facing-cave-front")
	var trigger := main.get("lamp_dialogue_trigger") as Control
	if trigger == null or not trigger.visible:
		failures.append("dialogue-trigger-after-find")
	if search_controls != null and search_controls.visible:
		failures.append("search-controls-still-visible")
	var end_image := root.get_texture().get_image()
	if end_image != null and not end_image.is_empty():
		end_image.save_png("res://tools/test_output/earth_fox_search_end.png")
	main.call("_start_current_dialogue")
	await create_timer(1.3).timeout
	if bool(main.get("earth_fox_inside_cave")):
		failures.append("fox-did-not-exit-for-dialogue")
	var expected_entrance_world := hill.global_transform * Vector3(
		0.80,
		0.065,
		0.0
	)
	print(
		"FOX_EXIT expected=",
		expected_entrance_world,
		" actual=",
		fox.global_position
	)
	if fox.global_position.distance_to(expected_entrance_world) > 0.02:
		failures.append("fox-dialogue-entrance-position")
	var prince := main.call("_story_node_by_kind", "prince_character") as Node3D
	if prince == null:
		failures.append("earth-dialogue-prince-missing")
	elif not is_equal_approx(float(prince.get_meta("head_tilt_degrees", 0.0)), -30.0):
		failures.append("earth-dialogue-prince-head-bow")
	var fox_player := main.call("_find_rig_animation_player", fox) as AnimationPlayer
	var dialogue_idles: Dictionary = {}
	var idle_deadline := Time.get_ticks_msec() + 8200
	while Time.get_ticks_msec() < idle_deadline:
		if fox_player != null:
			dialogue_idles[fox_player.current_animation] = true
		await create_timer(0.18).timeout
	for expected_idle in ["Idle", "Idle_2", "Idle_2_HeadLow"]:
		if not dialogue_idles.has(expected_idle):
			failures.append("dialogue-idle-missing:" + expected_idle)
	var dialogue_image := root.get_texture().get_image()
	if dialogue_image != null and not dialogue_image.is_empty():
		dialogue_image.save_png("res://tools/test_output/earth_fox_dialogue_entrance.png")
	main.call("_close_active_dialogue", false)
	await create_timer(0.35).timeout
	if bool(main.get("earth_fox_dialogue_idle_active")):
		failures.append("dialogue-idle-cycle-not-stopped")
	if (
		prince != null
		and not is_equal_approx(float(prince.get_meta("head_tilt_degrees", 0.0)), 0.0)
	):
		failures.append("earth-dialogue-prince-head-not-restored")
	print(
		"EARTH_FOX_SEARCH_VERIFY failures=",
		failures,
		" route_bend=",
		main.get("earth_fox_route_bend"),
		" fox_pos=",
		fox.global_position
	)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)

