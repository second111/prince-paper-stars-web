extends Node


const MAIN_SCRIPT := preload("res://scripts/main.gd")


func _ready() -> void:
	var main := MAIN_SCRIPT.new()
	add_child(main)
	await get_tree().process_frame
	await main.call("_show_generated_planet_3d", "我的星球", 0)
	await get_tree().create_timer(0.4).timeout
	if bool(main.get("player_avatar_picker_open")):
		main.call("_close_player_avatar_picker_overlay")
	var center: Vector3 = main.get("player_placement_plane_center")
	var normal: Vector3 = main.get("player_placement_plane_normal")
	var started: bool = main.call(
		"_begin_player_navigation",
		center,
		normal,
		{}
	)
	var failures: Array[String] = []
	if not started:
		failures.append("navigation-did-not-start")
	else:
		var deadline := Time.get_ticks_msec() + 2000
		while (
			String(main.get("player_navigation_phase")) != "walking"
			and Time.get_ticks_msec() < deadline
		):
			await get_tree().create_timer(0.02).timeout
		if String(main.get("player_navigation_phase")) != "walking":
			failures.append("navigation-did-not-walk")
		else:
			var leader_index: int = main.call(
				"_find_editable_record_index",
				String(main.get("player_navigation_leader_id")),
				-1
			)
			var leader_before: Vector3 = (
				main.get("editable_3d_objects")[leader_index].position
			)
			await get_tree().create_timer(0.3).timeout
			var leader_after: Vector3 = (
				main.get("editable_3d_objects")[leader_index].position
			)
			if (
				leader_after.distance_to(leader_before) <= 0.01
				or not bool(main.get("player_navigation_active"))
			):
				failures.append("normal-motion-falsely-reset")
			var right: Vector3 = main.get("player_placement_plane_right")
			main.set(
				"player_navigation_target_position",
				center + right * 2.5
			)
			main.set("player_navigation_progress_distance", -1000.0)
			main.set("player_navigation_stuck_elapsed", 0.0)
			main.call("_update_player_navigation_motion", 0.41)
			main.call("_update_player_navigation_motion", 0.41)
			await get_tree().process_frame
			if bool(main.get("player_navigation_active")):
				failures.append("stuck-navigation-not-recovered")
			if String(main.get("player_navigation_phase")) != "idle":
				failures.append("navigation-phase-not-reset")
	main.queue_free()
	if failures.is_empty():
		print("PLAYER_NAVIGATION_RECOVERY_OK")
		get_tree().quit(0)
		return
	push_error("PLAYER_NAVIGATION_RECOVERY_FAILED: " + ", ".join(failures))
	get_tree().quit(1)
