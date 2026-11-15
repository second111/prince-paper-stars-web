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
	var leader_record: Dictionary = {}
	var prince_record: Dictionary = {}
	var seat_finished := false
	var placement_test_index := -1
	var placement_objects: Array = main.get("editable_3d_objects")
	for object_index in placement_objects.size():
		var placement_object: Dictionary = placement_objects[object_index]
		if (
			not bool(placement_object.get("locked", false))
			and not main.call(
				"_is_player_character_kind",
				String(placement_object.get("kind", ""))
			)
		):
			placement_test_index = object_index
			break
	var placement_dock := main.get("player_place_dock") as Control
	if placement_test_index >= 0 and placement_dock != null:
		var dock_was_visible := placement_dock.visible
		placement_dock.visible = false
		main.call(
			"_select_player_placement_object",
			placement_test_index,
			Vector2(320.0, 320.0)
		)
		if bool(main.get("player_placement_object_dragging")):
			failures.append("object-drags-outside-placement-mode")
		placement_dock.visible = true
		main.call(
			"_select_player_placement_object",
			placement_test_index,
			Vector2(320.0, 320.0)
		)
		if not bool(main.get("player_placement_object_dragging")):
			failures.append("object-cannot-drag-in-placement-mode")
		main.call("_cancel_player_placement_selection")
		placement_dock.visible = dock_was_visible
	var markers_value = main.get("player_seat_glow_markers")
	if typeof(markers_value) != TYPE_ARRAY or markers_value.size() < 4:
		failures.append("seat-glow-markers")
	var marker_counts := {
		"player_bench": 0,
		"player_swing": 0,
		"player_star_pointlighter_chair": 0,
		"player_star_king_throne": 0,
	}
	var expected_marker_counts := marker_counts.duplicate()
	for object_value in main.get("editable_3d_objects"):
		if typeof(object_value) != TYPE_DICTIONARY:
			continue
		var object: Dictionary = object_value
		var object_kind := String(object.get("kind", ""))
		if not expected_marker_counts.has(object_kind):
			continue
		var object_node := object.get("node") as Node3D
		if (
			object_node == null
			or not object_node.visible
			or bool(object.get("default_hidden", false))
		):
			continue
		expected_marker_counts[object_kind] = int(
			main.call("_player_seat_visible_slot_count", object_kind)
		)
	if typeof(markers_value) == TYPE_ARRAY:
		for marker_value in markers_value:
			if typeof(marker_value) != TYPE_DICTIONARY:
				continue
			var marker: Dictionary = marker_value
			var marker_kind := String(marker.get("seat_kind", ""))
			if marker_counts.has(marker_kind):
				marker_counts[marker_kind] = int(marker_counts[marker_kind]) + 1
	for seat_kind in marker_counts:
		if int(marker_counts[seat_kind]) != int(expected_marker_counts[seat_kind]):
			failures.append("seat-glow-slot-counts:" + String(seat_kind))
	var active_index: int = main.call("_get_active_player_character_index")
	if active_index < 0:
		failures.append("active-player")
	var plane_center: Vector3 = main.get("player_placement_plane_center")
	var plane_right: Vector3 = main.get("player_placement_plane_right")
	var plane_forward: Vector3 = main.get("player_placement_plane_forward")
	var ground_target := plane_center + plane_right * 0.34 + plane_forward * 0.20
	var ground_started: bool = main.call(
		"_begin_player_navigation",
		ground_target,
		main.get("player_placement_plane_normal"),
		{}
	)
	if not ground_started:
		failures.append("ground-navigation-start")
	var turned_ready := await _wait_for_navigation_phase(
		main,
		"turning",
		1.2
	)
	if not turned_ready:
		failures.append("ground-turn-start")
	else:
		var leader_index_before_turn: int = main.call(
			"_find_editable_record_index",
			String(main.get("player_navigation_leader_id")),
			-1
		)
		var prince_index_before_turn: int = main.call(
			"_find_editable_record_index",
			String(main.get("player_navigation_prince_id")),
			-1
		)
		var leader_position_before_turn: Vector3 = (
			main.get("editable_3d_objects")[leader_index_before_turn].position
		)
		var prince_position_before_turn: Vector3 = (
			main.get("editable_3d_objects")[prince_index_before_turn].position
		)
		await _save_viewport("player_navigation_turning.png")
		await create_timer(0.08).timeout
		if String(main.get("player_navigation_phase")) == "turning":
			var leader_position_during_turn: Vector3 = (
				main.get("editable_3d_objects")[leader_index_before_turn].position
			)
			var prince_position_during_turn: Vector3 = (
				main.get("editable_3d_objects")[prince_index_before_turn].position
			)
			if (
				leader_position_during_turn.distance_to(
					leader_position_before_turn
				) > 0.001
				or prince_position_during_turn.distance_to(
					prince_position_before_turn
				) > 0.001
			):
				failures.append("movement-before-turn-finishes")
			var leader_node: Node3D = (
				main.get("editable_3d_objects")[leader_index_before_turn].node
			)
			if bool(leader_node.get_meta("player_navigation_walking", false)):
				failures.append("walk-animation-during-turn")
	var walking_ready := await _wait_for_navigation_phase(
		main,
		"walking",
		1.2
	)
	if not walking_ready:
		failures.append("ground-walk-start")
	else:
		var leader_index_walking: int = main.call(
			"_find_editable_record_index",
			String(main.get("player_navigation_leader_id")),
			-1
		)
		var leader_walking: Dictionary = (
			main.get("editable_3d_objects")[leader_index_walking]
		)
		var leader_forward: Vector3 = (
			main.call(
				"_normal_surface_basis",
				main.get("player_navigation_target_normal"),
				float(leader_walking.yaw)
			) * Vector3.RIGHT
		).normalized()
		var leader_direction: Vector3 = main.get(
			"player_navigation_leader_direction"
		)
		if leader_forward.dot(leader_direction) < 0.995:
			failures.append("leader-facing-destination")
		var prince_index_walking: int = main.call(
			"_find_editable_record_index",
			String(main.get("player_navigation_prince_id")),
			-1
		)
		var prince_walking: Dictionary = (
			main.get("editable_3d_objects")[prince_index_walking]
		)
		var prince_position_before_follow: Vector3 = prince_walking.position
		var prince_follow_state_before := String(
			main.get("player_navigation_prince_follow_state")
		)
		var player_prince_distance_before: float = (
			prince_walking.position.distance_to(leader_walking.position)
		)
		if (
			player_prince_distance_before <= 0.46
			and prince_follow_state_before != "idle"
		):
			failures.append("prince-followed-before-threshold")
		await create_timer(0.22).timeout
		var leader_after_threshold: Dictionary = (
			main.get("editable_3d_objects")[leader_index_walking]
		)
		var prince_after_threshold: Dictionary = (
			main.get("editable_3d_objects")[prince_index_walking]
		)
		var player_prince_distance_after: float = (
			prince_after_threshold.position.distance_to(
				leader_after_threshold.position
			)
		)
		if (
			player_prince_distance_before <= 0.46
			and player_prince_distance_after <= 0.46
			and prince_after_threshold.position.distance_to(
				prince_position_before_follow
			) > 0.001
		):
			failures.append("prince-moved-before-threshold")
	await create_timer(0.45).timeout
	_print_navigation_state(main, "GROUND_045")
	await _save_viewport("player_navigation_ground_target.png")
	var follower_walked := await _wait_for_follow_state(
		main,
		"walking",
		4.0
	)
	if not follower_walked:
		failures.append("prince-follow-start")
	else:
		await _save_viewport("player_navigation_following.png")
	var ground_finished := await _wait_for_navigation(main, 12.0)
	if not ground_finished:
		failures.append("ground-navigation-finish")
	var leader_index: int = main.call(
		"_find_editable_record_index",
		String(main.get("player_navigation_leader_id")),
		-1
	)
	var prince_index: int = main.call("_player_prince_record_index")
	var objects: Array = main.get("editable_3d_objects")
	if leader_index >= 0 and prince_index >= 0:
		leader_record = objects[leader_index]
		prince_record = objects[prince_index]
		var resolved_ground_target: Vector3 = main.get(
			"player_navigation_target_position"
		)
		if leader_record.position.distance_to(resolved_ground_target) > 0.05:
			failures.append("leader-ground-position")
		if prince_record.position.distance_to(leader_record.position) > 0.4:
			failures.append("prince-follow-distance")
		var expected_follow_target: Vector3 = main.call(
			"_clamp_player_placement_plane_position",
			(leader_record.position as Vector3)
				+ (
					main.call(
						"_normal_surface_basis",
						leader_record.get("placement_plane_normal"),
						float(leader_record.get("yaw", 0.0))
					) as Basis
				).x * -0.22
				+ (
					main.call(
						"_normal_surface_basis",
						leader_record.get("placement_plane_normal"),
						float(leader_record.get("yaw", 0.0))
					) as Basis
				).z * 0.07
		)
		var actual_follow_target: Vector3 = main.get(
			"player_navigation_prince_follow_target"
		)
		if actual_follow_target.distance_to(expected_follow_target) > 0.08:
			failures.append("prince-target-is-not-follow-position")
		if _prince_forward_offset(main, leader_record, prince_record) > -0.10:
			failures.append("prince-is-not-behind-after-right-travel")
	else:
		failures.append("navigation-records")
	var left_target := plane_center - plane_right * 0.34 + plane_forward * 0.20
	var left_started: bool = main.call(
		"_begin_player_navigation",
		left_target,
		main.get("player_placement_plane_normal"),
		{}
	)
	if not left_started:
		failures.append("left-navigation-start")
	else:
		var left_finished := await _wait_for_navigation(main, 14.0)
		if not left_finished:
			failures.append("left-navigation-finish")
		objects = main.get("editable_3d_objects")
		leader_record = objects[leader_index]
		prince_record = objects[prince_index]
		var left_forward_offset := _prince_forward_offset(
			main,
			leader_record,
			prince_record
		)
		print(
			"PLAYER_NAVIGATION_LEFT forward_offset=",
			left_forward_offset,
			" leader_yaw=",
			leader_record.get("yaw", 0.0)
		)
		if left_forward_offset > -0.10:
			failures.append("prince-is-not-behind-after-left-travel")
	var chair_record := _find_player_kind(
		objects,
		"player_bench"
	)
	if chair_record.is_empty():
		failures.append("chair-record")
	else:
		var seat_started: bool = main.call(
			"_begin_player_navigation",
			chair_record.position,
			chair_record.normal,
			chair_record.duplicate()
		)
		if not seat_started:
			failures.append("seat-navigation-start")
		await create_timer(0.45).timeout
		await _save_viewport("player_navigation_seat_target.png")
		seat_finished = await _wait_for_navigation(main, 14.0)
		if not seat_finished:
			failures.append("seat-navigation-finish")
		objects = main.get("editable_3d_objects")
		leader_record = objects[leader_index]
		prince_record = objects[prince_index]
		var chair_id := String(chair_record.get("id", ""))
		if (
			String(leader_record.get("seat_state", "")) != "seated"
			or String(leader_record.get("seat_id", "")) != chair_id
		):
			failures.append("leader-seated")
		if (
			String(prince_record.get("seat_state", "")) != "seated"
			or String(prince_record.get("seat_id", "")) != chair_id
		):
			failures.append("prince-seated")
		if (
			int(leader_record.get("seat_slot_index", -1))
			== int(prince_record.get("seat_slot_index", -2))
		):
			failures.append("seat-slots-overlap")
		await create_timer(0.8).timeout
		await _save_viewport("player_navigation_seated.png")
	var reset_button := main.get("player_character_reset_button") as Button
	if reset_button == null or not reset_button.visible:
		failures.append("character-reset-button")
	else:
		main.call("_reset_player_characters_from_stuck")
		await process_frame
		objects = main.get("editable_3d_objects")
		leader_record = objects[leader_index]
		prince_record = objects[prince_index]
		if bool(main.get("player_navigation_active")):
			failures.append("reset-navigation-state")
		for reset_record in [leader_record, prince_record]:
			if String(reset_record.get("seat_state", "")) != "standing":
				failures.append("reset-character-not-standing")
			var reset_node := reset_record.get("node") as Node3D
			if (
				reset_node == null
				or bool(reset_node.get_meta(
					"player_navigation_walking",
					false
				))
			):
				failures.append("reset-character-still-walking")
	print(
		"PLAYER_NAVIGATION seat_markers=",
		markers_value.size() if typeof(markers_value) == TYPE_ARRAY else -1,
		" ground_started=",
		ground_started,
		" ground_finished=",
		ground_finished,
		" seat_finished=",
		seat_finished if chair_record else false,
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


func _wait_for_navigation(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	var next_report := Time.get_ticks_msec()
	while Time.get_ticks_msec() < deadline:
		if not bool(main.get("player_navigation_active")):
			return true
		if Time.get_ticks_msec() >= next_report:
			_print_navigation_state(main, "WAIT")
			next_report = Time.get_ticks_msec() + 2000
		await create_timer(0.08).timeout
	_print_navigation_state(main, "TIMEOUT")
	return false


func _wait_for_navigation_phase(
	main: Node,
	phase: String,
	timeout_seconds: float
) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if String(main.get("player_navigation_phase")) == phase:
			return true
		if not bool(main.get("player_navigation_active")):
			return false
		await create_timer(0.01).timeout
	return false


func _wait_for_follow_state(
	main: Node,
	state: String,
	timeout_seconds: float
) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if String(main.get("player_navigation_prince_follow_state")) == state:
			return true
		if not bool(main.get("player_navigation_active")):
			return false
		await create_timer(0.01).timeout
	return false


func _find_player_kind(objects: Array, kind: String) -> Dictionary:
	for object_value in objects:
		if typeof(object_value) != TYPE_DICTIONARY:
			continue
		var object: Dictionary = object_value
		if String(object.get("kind", "")) == kind:
			return object
	return {}


func _prince_forward_offset(
	main: Node,
	leader: Dictionary,
	prince: Dictionary
) -> float:
	var normal: Vector3 = main.call(
		"_align_player_surface_normal",
		leader.get("placement_plane_normal", Vector3.UP)
	)
	var facing := (
		main.call(
			"_normal_surface_basis",
			normal,
			float(leader.get("yaw", 0.0))
		) as Basis
	).x.normalized()
	return (
		(prince.get("position", Vector3.ZERO) as Vector3)
		- (leader.get("position", Vector3.ZERO) as Vector3)
	).dot(facing)


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


func _print_navigation_state(main: Node, label: String) -> void:
	var objects: Array = main.get("editable_3d_objects")
	var leader_index: int = main.call(
		"_find_editable_record_index",
		String(main.get("player_navigation_leader_id")),
		-1
	)
	var prince_index: int = main.call("_player_prince_record_index")
	var leader_data := "none"
	var prince_data := "none"
	if leader_index >= 0 and leader_index < objects.size():
		var leader: Dictionary = objects[leader_index]
		var animation := leader.get("node").find_child(
			"AnimationPlayer",
			true,
			false
		) as AnimationPlayer
		leader_data = "%s state=%s pos=%s anim=%s" % [
			leader.get("id", ""),
			leader.get("seat_state", ""),
			leader.get("position", Vector3.ZERO),
			animation.current_animation if animation != null else "none",
		]
	if prince_index >= 0 and prince_index < objects.size():
		var prince: Dictionary = objects[prince_index]
		var animation := prince.get("node").find_child(
			"AnimationPlayer",
			true,
			false
		) as AnimationPlayer
		prince_data = "%s state=%s pos=%s anim=%s" % [
			prince.get("id", ""),
			prince.get("seat_state", ""),
			prince.get("position", Vector3.ZERO),
			animation.current_animation if animation != null else "none",
		]
	print(
		"NAV_STATE ",
		label,
		" active=",
		main.get("player_navigation_active"),
		" phase=",
		main.get("player_navigation_phase"),
		" target=",
		main.get("player_navigation_target_position"),
		" leader=[",
		leader_data,
		"] prince=[",
		prince_data,
		"]"
	)

