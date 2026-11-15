extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const OUTPUT_DIR := "res://tools/test_output/"


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	var loaded := await _wait_for_player_scene(main, 40.0)
	if not loaded:
		push_error("Player scene did not become ready.")
		quit(1)
		return
	await create_timer(0.8).timeout
	var failures: Array[String] = []
	var leader_index_before: int = main.call(
		"_get_active_player_character_index"
	)
	var prince_index_before: int = main.call(
		"_player_prince_record_index"
	)
	var objects_before: Array = main.get("editable_3d_objects")
	var leader_node_before := (
		objects_before[leader_index_before] as Dictionary
	).get("node") as Node3D
	var prince_node_before := (
		objects_before[prince_index_before] as Dictionary
	).get("node") as Node3D
	var leader_skeleton_before := leader_node_before.find_child(
		"Skeleton3D",
		true,
		false
	) as Skeleton3D
	var prince_skeleton_before := prince_node_before.find_child(
		"Skeleton3D",
		true,
		false
	) as Skeleton3D
	var saved_prince_position := prince_node_before.global_position
	var leader_right := leader_node_before.global_transform.basis.z.normalized()
	for side_sign in [1.0, -1.0]:
		prince_node_before.global_position = (
			leader_node_before.global_position
			+ leader_right * 0.24 * side_sign
		)
		var pair: Dictionary = main.call(
			"_player_handhold_hand_pair",
			leader_node_before,
			prince_node_before,
			leader_skeleton_before,
			prince_skeleton_before
		)
		var expected_leader_side := "R" if side_sign > 0.0 else "L"
		var expected_prince_side := "L" if side_sign > 0.0 else "R"
		if (
			String(pair.get("leader", "")) != expected_leader_side
			or String(pair.get("prince", "")) != expected_prince_side
		):
			failures.append("hand-pair-orientation:" + str(side_sign))
	prince_node_before.global_position = saved_prince_position
	main.call("_open_player_prince_interaction")
	await process_frame
	var hand_action_button := main.get(
		"player_prince_interaction_button"
	) as Button
	if hand_action_button == null or not hand_action_button.visible:
		failures.append("prince-hand-action-visible")
	else:
		await _save_viewport("player_prince_interaction_button.png")
	main.call("_on_player_prince_hand_action_pressed")
	var active := await _wait_for_handhold(main, 2.0)
	if not active:
		failures.append("handhold-active")
	var linked := await _wait_for_handhold_link(main, 5.0)
	if not linked:
		failures.append("handhold-ik")
	else:
		await process_frame
		await process_frame
		var target := main.get("player_handhold_target") as Node3D
		var handhold_skeletons: Array = main.get(
			"player_handhold_skeletons"
		)
		var leader_hand_side := String(
			main.get("player_handhold_leader_side")
		)
		var prince_hand_side := String(
			main.get("player_handhold_prince_side")
		)
		if (
			leader_hand_side.is_empty()
			or prince_hand_side.is_empty()
			or leader_hand_side == prince_hand_side
		):
			failures.append("handhold-opposite-hands")
		if target == null:
			failures.append("handhold-target")
		elif handhold_skeletons.size() == 2:
			for character_index in [0, 1]:
				var skeleton := handhold_skeletons[character_index] as Skeleton3D
				var hand_side := (
					leader_hand_side
					if character_index == 0
					else prince_hand_side
				)
				var tip_index := skeleton.find_bone(hand_side + "_Hand")
				var root_index := skeleton.find_bone(hand_side + "_Upperarm")
				var tip_world := (
					skeleton.global_transform
					* skeleton.get_bone_global_pose(tip_index).origin
				)
				var root_world := (
					skeleton.global_transform
					* skeleton.get_bone_global_pose(root_index).origin
				)
				var tip_distance := tip_world.distance_to(
					target.global_position
				)
				print(
					"HAND_IK tip=",
					hand_side + "_Hand",
					" distance=",
					tip_distance,
					" arm_distance=",
					root_world.distance_to(target.global_position),
					" world=",
					tip_world,
					" target=",
					target.global_position
				)
				if tip_distance > 0.025:
					failures.append(
						"handhold-tip:" + hand_side + "_Hand"
					)
			var leader_wrist: Vector3 = handhold_skeletons[0].global_transform * handhold_skeletons[0].get_bone_global_pose(
				handhold_skeletons[0].find_bone(leader_hand_side + "_Hand")
			).origin
			var prince_wrist: Vector3 = handhold_skeletons[1].global_transform * handhold_skeletons[1].get_bone_global_pose(
				handhold_skeletons[1].find_bone(prince_hand_side + "_Hand")
			).origin
			if leader_wrist.distance_to(prince_wrist) < 0.006:
				failures.append("handhold-wrists-not-separated")
			var leader_palm: Vector3 = main.get(
				"player_handhold_leader_palm_center"
			)
			var prince_palm: Vector3 = main.get(
				"player_handhold_prince_palm_center"
			)
			print(
				"HANDHOLD_PALMS pair=",
				main.get("player_handhold_pair_direction"),
				" leader=",
				leader_palm,
				" prince=",
				prince_palm,
				" wrist_distance=",
				leader_wrist.distance_to(prince_wrist),
				" palm_distance=",
				leader_palm.distance_to(prince_palm)
			)
			if leader_palm.distance_to(prince_palm) > 0.006:
				failures.append("handhold-palms-not-together")
		await _save_viewport("player_handhold_linked.png")
	var leader_index: int = main.call("_get_active_player_character_index")
	var prince_index: int = main.call("_player_prince_record_index")
	var objects: Array = main.get("editable_3d_objects")
	var leader: Dictionary = objects[leader_index]
	var prince: Dictionary = objects[prince_index]
	if (
		(leader.position as Vector3).length_squared() <= 0.0001
		or (prince.position as Vector3).length_squared() <= 0.0001
	):
		failures.append("handhold-positions")
	var center: Vector3 = main.get("player_placement_plane_center")
	var right: Vector3 = main.get("player_placement_plane_right")
	var forward: Vector3 = main.get("player_placement_plane_forward")
	var target := center + right * 0.34 + forward * 0.20
	var started: bool = main.call(
		"_begin_player_navigation",
		target,
		main.get("player_placement_plane_normal"),
		{}
	)
	if not started:
		failures.append("handhold-walk-start")
	var leader_start: Vector3 = leader.position
	var prince_start: Vector3 = prince.position
	await create_timer(1.2).timeout
	if leader.position.distance_to(leader_start) < 0.08:
		failures.append("leader-not-moving-while-holding")
	if prince.position.distance_to(prince_start) < 0.05:
		failures.append("prince-not-following-while-holding")
	if prince.position.distance_to(leader.position) > 0.20:
		failures.append("handhold-distance")
	await _save_viewport("player_handhold_walking.png")
	main.call("_release_player_handhold")
	await process_frame
	var handhold_skeletons = main.get("player_handhold_skeletons")
	if (
		typeof(handhold_skeletons) == TYPE_ARRAY
		and not (handhold_skeletons as Array).is_empty()
	):
		failures.append("handhold-release-ik")
	print(
		"PLAYER_HANDHOLD active=",
		active,
		" linked=",
		linked,
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


func _wait_for_handhold(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if bool(main.get("player_handhold_active")):
			return true
		await create_timer(0.05).timeout
	return false


func _wait_for_handhold_link(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		var handhold_skeletons = main.get("player_handhold_skeletons")
		if (
			typeof(handhold_skeletons) == TYPE_ARRAY
			and (handhold_skeletons as Array).size() == 2
		):
			return true
		await create_timer(0.05).timeout
	return false


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

