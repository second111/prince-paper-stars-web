extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	if not await _wait_for_player_scene(main, 40.0):
		push_error("Player scene did not become ready.")
		quit(1)
		return
	await create_timer(0.8).timeout
	var leader_index: int = main.call("_get_active_player_character_index")
	var prince_index: int = main.call("_player_prince_record_index")
	var objects: Array = main.get("editable_3d_objects")
	var leader_record: Dictionary = objects[leader_index]
	var prince_record: Dictionary = objects[prince_index]
	await main.call("_stand_player_character", leader_record, true)
	await main.call("_stand_player_character", prince_record, true)
	main.call("_start_player_handhold")
	for frame in 70:
		await process_frame
	var leader := (objects[leader_index] as Dictionary).get("node") as Node3D
	var prince := (objects[prince_index] as Dictionary).get("node") as Node3D
	var camera := main.get("camera_3d") as Camera3D
	var normal: Vector3 = main.get("player_placement_plane_normal")
	var focus := (
		(leader.global_position + prince.global_position) * 0.5
		+ normal * 0.22
	)
	var view_direction := -camera.global_transform.basis.z.normalized()
	var camera_up := camera.global_transform.basis.y.normalized()
	main.set_process(false)
	main.set_physics_process(false)
	var hud := main.get("hud_3d") as CanvasLayer
	if hud != null:
		hud.visible = false
	camera.global_position = focus - view_direction * 1.25
	camera.fov = 24.0
	camera.look_at(focus, camera_up)
	main.call("_update_player_handhold_link")
	await process_frame
	await process_frame
	var image := root.get_viewport().get_texture().get_image()
	image.save_png("res://tools/test_output/handhold_natural_side.png")
	var leader_palm: Vector3 = main.get("player_handhold_leader_palm_center")
	var prince_palm: Vector3 = main.get("player_handhold_prince_palm_center")
	print(
		"HANDHOLD_NATURAL leader=",
		leader.global_position,
		" prince=",
		prince.global_position,
		" target=",
		(main.get("player_handhold_target") as Node3D).global_position,
		" palm_distance=",
		leader_palm.distance_to(prince_palm)
	)
	main.queue_free()
	quit()


func _wait_for_player_scene(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "player"
			and bool(main.get("generated_planet_ready").get("player", false))
		):
			return true
		await create_timer(0.15).timeout
	return false

