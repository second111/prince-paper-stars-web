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
	var failures: Array[String] = []
	var leader_index: int = main.call("_get_active_player_character_index")
	var prince_index: int = main.call("_player_prince_record_index")
	var leader_record: Dictionary = main.get("editable_3d_objects")[leader_index]
	var prince_record: Dictionary = main.get("editable_3d_objects")[prince_index]
	var leader_position_before: Vector3 = leader_record.get("position")
	var prince_position_before: Vector3 = prince_record.get("position")
	var leader_yaw_before := float(leader_record.get("yaw", 0.0))
	var prince_yaw_before := float(prince_record.get("yaw", 0.0))
	var leader_normal_before: Vector3 = leader_record.get(
		"placement_plane_normal",
		Vector3.UP
	)
	var prince_normal_before: Vector3 = prince_record.get(
		"placement_plane_normal",
		Vector3.UP
	)
	var leader_seat_before := String(leader_record.get("seat_state", ""))
	var prince_seat_before := String(prince_record.get("seat_state", ""))
	var model := main.get("model_3d") as Node3D
	var model_position_before := model.position
	var model_scale_before := model.scale
	var camera := main.get("camera_3d") as Camera3D
	var camera_position_before := camera.position
	main.call("_on_player_dialogue_symbol_pressed")
	await create_timer(1.35).timeout
	var panel := main.get("dialogue_panel") as PanelContainer
	var choices := main.get("dialogue_choices") as VBoxContainer
	if not bool(main.get("dialogue_active")):
		failures.append("dialogue-not-active")
	if String(main.get("dialogue_scene")) != "player":
		failures.append("wrong-dialogue-scene")
	if panel == null or not panel.visible:
		failures.append("dialogue-panel-hidden")
	elif panel.get_global_rect().position.x < 900.0:
		failures.append("dialogue-panel-not-on-right")
	if choices == null or choices.get_child_count() != 8:
		failures.append("intro-choice-count")
	var body_frame := main.get("dialogue_body_frame") as Control
	if body_frame == null or body_frame.visible:
		failures.append("question-only-dialogue-body-visible")
	var bubble_root := main.get("player_dialogue_bubble_root") as Control
	var bubbles_before: Array = main.get("player_dialogue_bubbles")
	if bubble_root == null or not bubble_root.visible:
		failures.append("dialogue-bubble-layer")
	if not bubbles_before.is_empty():
		failures.append("dialogue-bubbles-before-question")
	var focus_center := _focus_screen_center(main)
	if focus_center.x > 680.0:
		failures.append("actors-not-moved-left")
	var viewport_height := root.get_viewport().get_visible_rect().size.y
	if absf(focus_center.y - viewport_height * 0.56) > viewport_height * 0.08:
		failures.append("dialogue-actors-not-centered")
	if (
		camera.position.distance_to(camera_position_before) < 2.0
		or absf(float(main.get("camera_distance")) - 1.2) > 0.12
	):
		failures.append("dialogue-camera-not-close-enough")
	var leader_node := leader_record.get("node") as Node3D
	var prince_node := prince_record.get("node") as Node3D
	var dialogue_up := Vector3.UP
	if leader_node != null and prince_node != null:
		dialogue_up = (
			leader_node.global_transform.basis.y.normalized()
			+ prince_node.global_transform.basis.y.normalized()
		).normalized()
	var camera_forward := -camera.global_basis.z.normalized()
	if absf(camera_forward.dot(dialogue_up)) > 0.05:
		failures.append("dialogue-camera-not-level")
	var staged_distance := (
		(leader_record.get("position") as Vector3)
		- (prince_record.get("position") as Vector3)
	).length()
	if staged_distance > 0.52:
		failures.append("dialogue-actors-not-close")
	if (
		String(leader_record.get("seat_state", "")) != leader_seat_before
		or String(prince_record.get("seat_state", "")) != prince_seat_before
	):
		failures.append("dialogue-seat-state-changed")
	if leader_node == null or prince_node == null:
		failures.append("dialogue-actor-node")
	else:
		var leader_head_screen := camera.unproject_position(
			main.call("_player_character_head_world_position", leader_node)
		)
		var prince_head_screen := camera.unproject_position(
			main.call("_player_character_head_world_position", prince_node)
		)
		if (
			minf(leader_head_screen.y, prince_head_screen.y)
			< viewport_height * 0.20
		):
			failures.append("dialogue-no-headroom-for-bubbles")
		if (
			not _world_up_is_screen_up(main, leader_node)
			or not _world_up_is_screen_up(main, prince_node)
		):
			failures.append("dialogue-actors-tilted-on-screen")
	if (
		not _record_faces_camera(main, leader_index)
		or not _record_faces_camera(main, prince_index)
	):
		failures.append("dialogue-actors-not-facing-camera")
	if (
		(leader_record.get("position") as Vector3).distance_to(
			leader_position_before
		) > 0.001
		or (prince_record.get("position") as Vector3).distance_to(
			prince_position_before
		) > 0.001
		or (leader_record.get(
			"placement_plane_normal",
			Vector3.UP
		) as Vector3).distance_to(leader_normal_before) > 0.001
		or (prince_record.get(
			"placement_plane_normal",
			Vector3.UP
		) as Vector3).distance_to(prince_normal_before) > 0.001
		or model.position.distance_to(model_position_before) > 0.001
		or model.scale.distance_to(model_scale_before) > 0.001
	):
		failures.append("dialogue-character-or-scene-state-moved")
	var dialogue_spots: Array = main.get("player_dialogue_spotlights")
	var dialogue_fill := main.get("player_dialogue_fill_light") as OmniLight3D
	if dialogue_spots.size() != 2:
		failures.append("dialogue-spotlight-count")
	for index in dialogue_spots.size():
		var spot := dialogue_spots[index] as SpotLight3D
		var expected_energy := 0.6 if index == 1 else 1.0
		if (
			spot == null
			or not spot.visible
			or absf(spot.light_energy - expected_energy) > 0.05
		):
			failures.append("dialogue-spotlights-not-enabled")
	if (
		dialogue_fill == null
		or not dialogue_fill.visible
		or dialogue_fill.light_energy < 0.12
	):
		failures.append("dialogue-face-fill-not-enabled")
	var dialogue_button := main.get("player_dialogue_symbol_button") as Button
	var sticker_button := main.get("player_sticker_symbol_button") as Button
	var place_button := main.get("player_place_button") as Button
	var save_button := main.get("player_save_symbol_button") as Button
	var photo_button := main.get("player_photo_symbol_button") as Button
	if (
		dialogue_button == null
		or sticker_button == null
		or place_button == null
		or save_button == null
		or photo_button == null
	):
		failures.append("symbols-missing")
	elif (
		dialogue_button.visible
		or sticker_button.visible
		or place_button.visible
		or save_button.visible
		or photo_button.visible
	):
		failures.append("symbols-visible-during-dialogue")
	await _save_viewport("player_prince_dialogue_intro.png")
	var rose_choice := {
		"id": "player_topic_rose",
		"label": "你怎么看玫瑰？",
		"next": "rose",
	}
	main.call("_on_dialogue_choice", rose_choice)
	await create_timer(0.90).timeout
	if choices == null or choices.get_child_count() != 2:
		failures.append("rose-followup-count")
	var bubbles: Array = main.get("player_dialogue_bubbles")
	if bubbles.size() != 2:
		failures.append("dialogue-bubble-count")
	else:
		var question_bubble := bubbles[0].get("node") as Control
		var reply_bubble := bubbles[1].get("node") as Control
		if String(bubbles[0].get("role", "")) != "user":
			failures.append("dialogue-question-bubble-role")
		if String(bubbles[1].get("role", "")) != "npc":
			failures.append("dialogue-reply-bubble-role")
		if question_bubble == null or reply_bubble == null:
			failures.append("dialogue-bubble-node")
		else:
			if question_bubble.position.y >= reply_bubble.position.y:
				failures.append("dialogue-bubbles-not-stacked-up")
			if reply_bubble.size.x <= reply_bubble.size.y * 1.2:
				failures.append("dialogue-bubble-not-a-long-strip")
			if question_bubble.size.x >= reply_bubble.size.x:
				failures.append("dialogue-bubble-width-not-content-aware")
			var reply_text := reply_bubble.find_child(
				"BubbleText",
				true,
				false
			) as Label
			var reply_font := (
				reply_text.get_theme_font("font")
				if reply_text != null
				else null
			)
			if (
				reply_font is not FontVariation
				or (reply_font as FontVariation).variation_embolden < 0.4
			):
				failures.append("dialogue-bubble-text-not-bold")
			var reply_style := (
				reply_bubble.get_theme_stylebox("panel") as StyleBoxFlat
			)
			if (
				reply_style == null
				or absf(reply_style.bg_color.a - 0.80) > 0.02
				or reply_style.bg_color.b <= reply_style.bg_color.r
				or reply_style.bg_color.b <= reply_style.bg_color.g
			):
				failures.append("dialogue-bubble-not-blue-80-alpha")
			var star_dots := reply_bubble.find_children(
				"StarDot*",
				"ColorRect",
				true,
				false
			)
			if star_dots.size() < 12:
				failures.append("dialogue-bubble-stars")
	await _save_viewport("player_prince_dialogue_rose.png")
	var followup := {
		"label": "你现在还会想她吗？",
		"next": "rose_miss",
	}
	main.call("_on_dialogue_choice", followup)
	await create_timer(1.0).timeout
	# Asked topics follow the same menu behavior as the other planets: they stay
	# hidden after their follow-up branch, leaving the other seven topics.
	if choices == null or choices.get_child_count() != 7:
		failures.append("return-to-filtered-topic-menu")
	var stacked_bubbles: Array = main.get("player_dialogue_bubbles")
	for bubble_value in stacked_bubbles:
		var stacked_bubble := bubble_value.get("node") as Control
		if stacked_bubble != null and stacked_bubble.position.y < -0.5:
			failures.append("dialogue-bubble-clipped-at-top")
			break
	for first_index in stacked_bubbles.size():
		var first_bubble := stacked_bubbles[first_index].get("node") as Control
		if first_bubble == null:
			continue
		for second_index in range(first_index + 1, stacked_bubbles.size()):
			var second_bubble := (
				stacked_bubbles[second_index].get("node") as Control
			)
			if (
				second_bubble != null
				and first_bubble.get_global_rect().grow(1.0).intersects(
					second_bubble.get_global_rect()
				)
			):
				failures.append("dialogue-bubbles-overlap")
	await _save_viewport("player_prince_dialogue_stacked.png")
	main.call("_close_active_dialogue")
	await create_timer(0.75).timeout
	if bool(main.get("dialogue_active")) or (panel != null and panel.visible):
		failures.append("dialogue-close")
	if bool(main.get("story_camera_focus_active")):
		failures.append("dialogue-camera-not-restored")
	if bool(main.get("player_dialogue_stage_active")):
		failures.append("dialogue-stage-not-restored")
	for spot_value in dialogue_spots:
		var spot := spot_value as SpotLight3D
		if spot != null and spot.light_energy > 0.05:
			failures.append("dialogue-spotlights-not-restored")
	if (
		(leader_record.get("position") as Vector3).distance_to(
			leader_position_before
		) > 0.01
		or (prince_record.get("position") as Vector3).distance_to(
			prince_position_before
		) > 0.01
		or absf(
			wrapf(
				float(leader_record.get("yaw", 0.0)) - leader_yaw_before,
				-180.0,
				180.0
			)
		) > 0.5
		or absf(
			wrapf(
				float(prince_record.get("yaw", 0.0)) - prince_yaw_before,
				-180.0,
				180.0
			)
		) > 0.5
	):
		failures.append("dialogue-character-pose-not-restored")
	print(
		"PLAYER_PRINCE_DIALOGUE focus=",
		focus_center,
		" panel_x=",
		panel.get_global_rect().position.x if panel != null else -1.0,
		" staged_yaws=",
		Vector2(
			float(leader_record.get("yaw", 0.0)),
			float(prince_record.get("yaw", 0.0))
		),
		" source_yaws=",
		Vector2(leader_yaw_before, prince_yaw_before),
		" failures=",
		failures
	)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


func _record_faces_camera(main: Node, index: int) -> bool:
	var records: Array = main.get("editable_3d_objects")
	if index < 0 or index >= records.size():
		return false
	var record: Dictionary = records[index]
	var node := record.get("node") as Node3D
	var camera := main.get("camera_3d") as Camera3D
	var model := main.get("model_3d") as Node3D
	if node == null or camera == null or model == null:
		return false
	var normal := record.get(
		"placement_plane_normal",
		Vector3.UP
	) as Vector3
	var camera_direction := (
		model.global_transform.basis.inverse()
		* (camera.global_position - node.global_position)
	)
	var expected_yaw := float(main.call(
		"_player_navigation_facing_yaw",
		camera_direction,
		normal
	))
	return absf(wrapf(
		float(record.get("yaw", 0.0)) - expected_yaw,
		-180.0,
		180.0
	)) <= 4.0


func _focus_screen_center(main: Node) -> Vector2:
	var objects: Array = main.get("editable_3d_objects")
	var leader_index: int = main.call("_get_active_player_character_index")
	var prince_index: int = main.call("_player_prince_record_index")
	var camera := main.get("camera_3d") as Camera3D
	var center := Vector2.ZERO
	var count := 0
	for index in [leader_index, prince_index]:
		if index < 0 or index >= objects.size():
			continue
		var node := objects[index].get("node") as Node3D
		if node == null:
			continue
		center += camera.unproject_position(
			(main.call("_editable_world_bounds", node) as AABB).get_center()
		)
		count += 1
	return center / maxf(float(count), 1.0)


func _world_bounds_screen_rect(main: Node, node: Node3D) -> Rect2:
	var camera := main.get("camera_3d") as Camera3D
	var bounds: AABB = main.call("_editable_world_bounds", node)
	var first := camera.unproject_position(bounds.position)
	var result := Rect2(first, Vector2.ZERO)
	for x in [0.0, 1.0]:
		for y in [0.0, 1.0]:
			for z in [0.0, 1.0]:
				var point := bounds.position + Vector3(
					bounds.size.x * x,
					bounds.size.y * y,
					bounds.size.z * z
				)
				result = result.expand(camera.unproject_position(point))
	return result


func _world_up_is_screen_up(main: Node, node: Node3D) -> bool:
	var camera := main.get("camera_3d") as Camera3D
	if camera == null or node == null:
		return false
	var bounds: AABB = main.call("_editable_world_bounds", node)
	var center := bounds.get_center()
	var up := node.global_transform.basis.y.normalized() * maxf(bounds.size.y, 0.1)
	var screen_up := (
		camera.unproject_position(center + up * 0.45)
		- camera.unproject_position(center - up * 0.45)
	)
	return (
		screen_up.y < -0.1
		and absf(screen_up.x) <= absf(screen_up.y) * 0.18
	)


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


func _save_viewport(file_name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return
	await process_frame
	var texture := root.get_viewport().get_texture()
	if texture == null:
		return
	var image := texture.get_image()
	if image != null and not image.is_empty():
		image.save_png("res://tools/test_output/" + file_name)

