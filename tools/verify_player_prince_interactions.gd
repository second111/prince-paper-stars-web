extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const OUTPUT_DIR := "res://tools/test_output/"


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	if not await _wait_for_player_scene(main, 40.0):
		push_error("Player scene did not become ready.")
		quit(1)
		return
	await create_timer(0.8).timeout
	var failures: Array[String] = []
	var objects: Array = main.get("editable_3d_objects")
	var leader_index: int = main.call("_get_active_player_character_index")
	var prince_index: int = main.call("_player_prince_record_index")
	if leader_index < 0 or prince_index < 0:
		push_error("Player or Prince record is missing.")
		quit(1)
		return
	var leader: Dictionary = objects[leader_index]
	var prince: Dictionary = objects[prince_index]
	for record in [leader, prince]:
		if String(record.get("seat_state", "")) == "seated":
			main.call("_stand_player_character", record, false)
	await process_frame
	if bool(main.get("player_prince_look_active")):
		await _wait_for_look_interaction(main, 4.0)
	var leader_node := leader.get("node") as Node3D
	var prince_node := prince.get("node") as Node3D
	main.call("_open_player_prince_interaction")
	await process_frame
	var hand_button := main.get("player_prince_interaction_button") as Button
	var look_button := main.get("player_prince_look_button") as Button
	var hand_button_visible := hand_button != null and hand_button.visible
	var look_button_visible := look_button != null and look_button.visible
	if not hand_button_visible:
		failures.append("hand-action-button")
	if not look_button_visible:
		failures.append("look-action-button")
	var leader_head_before := main.call(
		"_capture_player_head_glance",
		leader_node,
		prince_node
	) as Dictionary
	var prince_head_before := main.call(
		"_capture_player_head_glance",
		prince_node,
		leader_node
	) as Dictionary
	main.call("_on_player_prince_look_action_pressed")
	var standing_animated := await _wait_for_glance_animation(
		main,
		leader_head_before,
		prince_head_before,
		5.0
	)
	if not standing_animated:
		failures.append("standing-glance-animation")
	await _save_viewport("player_prince_mutual_look.png")
	if not await _wait_for_look_interaction(main, 5.0):
		failures.append("standing-glance-finish")
	for record in [leader, prince]:
		var animation := _find_animation_player(record.get("node"))
		if animation == null or not animation.is_playing():
			failures.append("standing-animation-not-resumed")
	var facing_data := _character_facing_data(main, leader, prince)
	print("PLAYER_PRINCE_FACING ", facing_data)
	if (
		float(facing_data.get("leader", 0.0)) <= 0.95
		or float(facing_data.get("prince", 0.0)) <= 0.95
	):
		failures.append("standing-characters-not-facing")
	var bench := _find_player_kind(objects, "player_bench")
	if bench.is_empty():
		failures.append("seat-record")
	else:
		var seat_plan: Dictionary = main.call(
			"_player_navigation_seat_plan",
			bench,
			leader,
			prince
		)
		if seat_plan.is_empty():
			failures.append("seat-plan")
		else:
			main.call(
				"_sit_player_character_at_seat",
				leader,
				seat_plan.leader,
				false
			)
			main.call(
				"_sit_player_character_at_seat",
				prince,
				seat_plan.prince,
				false
			)
			var seat_id := String(bench.get("id", ""))
			if (
				String(leader.get("seat_state", "")) != "seated"
				or String(prince.get("seat_state", "")) != "seated"
				or String(leader.get("seat_id", "")) != seat_id
				or String(prince.get("seat_id", "")) != seat_id
			):
				failures.append("characters-not-seated")
			var seated_leader_head := main.call(
				"_capture_player_head_glance",
				leader_node,
				prince_node
			) as Dictionary
			var seated_prince_head := main.call(
				"_capture_player_head_glance",
				prince_node,
				leader_node
			) as Dictionary
			main.call("_on_player_prince_look_action_pressed")
			var seated_animated := await _wait_for_glance_animation(
				main,
				seated_leader_head,
				seated_prince_head,
				5.0
			)
			if not seated_animated:
				failures.append("seated-glance-animation")
			await _save_viewport("player_prince_seated_glance.png")
			if not await _wait_for_look_interaction(main, 5.0):
				failures.append("seated-glance-finish")
			if not _head_matches_pose(
				leader_node,
				seated_leader_head,
				prince_node
			):
				failures.append("seated-player-head-not-restored")
			if not _head_matches_pose(
				prince_node,
				seated_prince_head,
				leader_node
			):
				failures.append("seated-prince-head-not-restored")
			for record in [leader, prince]:
				var animation := _find_animation_player(record.get("node"))
				if animation == null or not is_equal_approx(
					animation.get_playing_speed(),
					0.0
				):
					failures.append("seated-pose-started-playing")
	print(
		"PLAYER_PRINCE_INTERACTIONS hand_button=",
		hand_button_visible,
		" look_button=",
		look_button_visible,
		" failures=",
		failures
	)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


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


func _wait_for_glance_animation(
	main: Node,
	leader_pose: Dictionary,
	prince_pose: Dictionary,
	timeout_seconds: float
) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if (
			_head_rotation_changed(leader_pose)
			or _head_rotation_changed(prince_pose)
		):
			return true
		if not bool(main.get("player_prince_look_active")):
			return false
		await create_timer(0.02).timeout
	return false


func _wait_for_look_interaction(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if not bool(main.get("player_prince_look_active")):
			return true
		await create_timer(0.03).timeout
	return false


func _head_rotation_changed(pose: Dictionary) -> bool:
	if pose.is_empty():
		return false
	var skeleton := pose.get("skeleton") as Skeleton3D
	if skeleton == null:
		return false
	var current := skeleton.get_bone_pose_rotation(int(pose.get("bone", -1)))
	var base := pose.get("rotation", Quaternion.IDENTITY) as Quaternion
	return current.dot(base) < 0.99995


func _head_matches_pose(
	root: Node3D,
	pose: Dictionary,
	target: Node3D
) -> bool:
	var current := _find_animation_player(root)
	if current == null:
		return false
	var skeleton: Skeleton3D
	var skeletons := root.find_children("*", "Skeleton3D", true, false)
	if not skeletons.is_empty():
		skeleton = skeletons[0] as Skeleton3D
	if skeleton == null:
		return false
	var bone_index := skeleton.find_bone("Head")
	if bone_index < 0:
		return false
	var rotation := skeleton.get_bone_pose_rotation(bone_index)
	var base := pose.get("rotation", Quaternion.IDENTITY) as Quaternion
	return rotation.dot(base) > 0.99999


func _character_facing_data(
	main: Node,
	leader: Dictionary,
	prince: Dictionary
) -> Dictionary:
	var leader_forward := (
		main.call(
			"_normal_surface_basis",
			leader.get("placement_plane_normal", Vector3.UP),
			float(leader.get("yaw", 0.0))
		) as Basis
	).x
	leader_forward = leader_forward.normalized()
	var prince_forward := (
		main.call(
			"_normal_surface_basis",
			prince.get("placement_plane_normal", Vector3.UP),
			float(prince.get("yaw", 0.0))
		) as Basis
	).x
	prince_forward = prince_forward.normalized()
	var to_prince := (
		(prince.get("position", Vector3.ZERO) as Vector3)
		- (leader.get("position", Vector3.ZERO) as Vector3)
	).normalized()
	var to_leader := (
		(leader.get("position", Vector3.ZERO) as Vector3)
		- (prince.get("position", Vector3.ZERO) as Vector3)
	).normalized()
	return {
		"leader": leader_forward.dot(to_prince),
		"prince": prince_forward.dot(to_leader),
		"leader_yaw": float(leader.get("yaw", 0.0)),
		"prince_yaw": float(prince.get("yaw", 0.0)),
		"leader_target": main.call(
			"_player_character_yaw_toward_record",
			leader,
			prince
		),
		"prince_target": main.call(
			"_player_character_yaw_toward_record",
			prince,
			leader
		),
	}


func _find_player_kind(objects: Array, kind: String) -> Dictionary:
	for value in objects:
		if (
			typeof(value) == TYPE_DICTIONARY
			and String(value.get("kind", "")) == kind
		):
			return value
	return {}


func _find_animation_player(root: Node) -> AnimationPlayer:
	if root == null:
		return null
	return root.find_child("AnimationPlayer", true, false) as AnimationPlayer


func _save_viewport(file_name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return
	await process_frame
	var texture := root.get_viewport().get_texture()
	if texture == null:
		return
	var image := texture.get_image()
	if image != null and not image.is_empty():
		image.save_png(OUTPUT_DIR + file_name)

