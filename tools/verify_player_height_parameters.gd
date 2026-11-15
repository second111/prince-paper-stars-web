extends Node


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const ACTION_RAIL_CAPTURE_PATH := "res://tools/test_output/player_item_action_rail_empty.png"


func _ready() -> void:
	var main := MAIN_SCRIPT.new()
	add_child(main)
	await get_tree().process_frame
	await main.call("_show_generated_planet_3d", "我的星球", 0)
	await get_tree().create_timer(0.4).timeout
	var failures: Array[String] = []
	var objects: Array = main.get("editable_3d_objects")
	var heights: Dictionary = main.get("player_asset_height_offsets")
	var support_index := -1
	var ground_index := -1
	var unlocked_index := -1
	for index in objects.size():
		var record: Dictionary = objects[index]
		if not bool(main.call("_is_player_plane_record", record)):
			continue
		if bool(main.call("_is_player_character_kind", String(record.kind))):
			continue
		if (
			unlocked_index < 0
			and not bool(record.get("locked", false))
			and not bool(record.get("placement_height_locked", false))
		):
			unlocked_index = index
		if bool(main.call("_is_player_support_surface_kind", String(record.kind))):
			continue
		if not String(record.get("placement_support_id", "")).is_empty():
			if support_index < 0 and bool(
				record.get("placement_height_locked", false)
			):
				support_index = index
		elif ground_index < 0 and bool(
			record.get("placement_height_locked", false)
		):
			ground_index = index
	if support_index >= 0:
		await _verify_support_height_is_locked(
			main,
			objects,
			heights,
			support_index,
			failures
		)
	if ground_index >= 0:
		await _verify_ground_height_is_locked(
			main,
			objects,
			heights,
			ground_index,
			failures
		)
	if unlocked_index >= 0:
		await _verify_unlocked_height_can_change(
			main,
			objects,
			heights,
			unlocked_index,
			failures
		)
	if unlocked_index >= 0:
		_verify_reposition_has_single_height_application(
			main,
			objects,
			unlocked_index,
			failures
		)
	_verify_player_action_rail(main, objects, failures)
	await get_tree().process_frame
	await get_tree().process_frame
	var viewport_image := get_viewport().get_texture().get_image()
	if viewport_image != null and not viewport_image.is_empty():
		viewport_image.save_png(ACTION_RAIL_CAPTURE_PATH)
	main.queue_free()
	if failures.is_empty():
		print("PLAYER_HEIGHT_PARAMETERS_OK")
		get_tree().quit(0)
		return
	push_error("PLAYER_HEIGHT_PARAMETERS_FAILED: " + ", ".join(failures))
	get_tree().quit(1)


func _verify_support_height_is_locked(
	main: Node,
	objects: Array,
	heights: Dictionary,
	index: int,
	failures: Array[String]
) -> void:
	var record: Dictionary = objects[index]
	var kind := String(record.kind)
	var original_record_height := float(record.placement_height_offset)
	var original_ground_height := float(heights.get(kind, 0.0))
	main.set("selected_editable_index", index)
	main.call("_on_editor_height_changed", original_record_height + 0.02)
	await get_tree().process_frame
	if not is_equal_approx(
		float(record.placement_height_offset),
		original_record_height
	):
		failures.append("support-height-was-not-locked")
	if not is_equal_approx(
		float(heights.get(kind, 0.0)),
		original_ground_height
	):
		failures.append("support-height-overwrote-ground")
	record["placement_height_offset"] = original_record_height
	record["support_height_offset"] = record.get(
		"locked_support_height_offset",
		original_record_height
	)
	heights[kind] = original_ground_height
	main.call("_apply_editable_3d_record", index)


func _verify_ground_height_is_locked(
	main: Node,
	objects: Array,
	heights: Dictionary,
	index: int,
	failures: Array[String]
) -> void:
	var record: Dictionary = objects[index]
	var kind := String(record.kind)
	var original_record_height := float(record.placement_height_offset)
	var original_ground_height := float(heights.get(kind, 0.0))
	main.set("selected_editable_index", index)
	main.call("_on_editor_height_changed", original_record_height + 0.01)
	await get_tree().process_frame
	if not is_equal_approx(
		float(record.placement_height_offset),
		original_record_height
	):
		failures.append("ground-height-was-not-locked")
	if not is_equal_approx(
		float(heights.get(kind, 0.0)),
		original_ground_height
	):
		failures.append("locked-ground-height-changed-default")
	record["placement_height_offset"] = original_record_height
	record["ground_height_offset"] = record.get(
		"locked_ground_height_offset",
		original_record_height
	)
	heights[kind] = original_ground_height
	main.call("_apply_editable_3d_record", index)


func _verify_unlocked_height_can_change(
	main: Node,
	objects: Array,
	heights: Dictionary,
	index: int,
	failures: Array[String]
) -> void:
	var record: Dictionary = objects[index]
	var kind := String(record.kind)
	var original_record_height := float(record.placement_height_offset)
	var original_ground_height := float(heights.get(kind, 0.0))
	main.set("selected_editable_index", index)
	main.call("_on_editor_height_changed", original_record_height + 0.01)
	await get_tree().process_frame
	if is_equal_approx(
		float(record.placement_height_offset),
		original_record_height
	):
		failures.append("unlocked-height-could-not-change")
	record["placement_height_offset"] = original_record_height
	record["ground_height_offset"] = original_ground_height
	heights[kind] = original_ground_height
	main.call("_apply_editable_3d_record", index)


func _verify_reposition_has_single_height_application(
	main: Node,
	objects: Array,
	index: int,
	failures: Array[String]
) -> void:
	var camera := main.get("camera_3d") as Camera3D
	var model := main.get("model_3d") as Node3D
	if camera == null or model == null:
		failures.append("reposition-camera-missing")
		return
	var record: Dictionary = objects[index]
	var screen_position := Vector2.ZERO
	var found := false
	for x in [-0.7, -0.4, 0.0, 0.4, 0.7]:
		for z in [-0.4, 0.0, 0.4]:
			var sample: Vector3 = main.get("player_placement_plane_center")
			sample += main.get("player_placement_plane_right") * float(x)
			sample += main.get("player_placement_plane_forward") * float(z)
			var candidate := camera.unproject_position(
				model.global_transform * sample
			)
			if (
				not (main.call("_player_surface_hit", candidate) as Dictionary).is_empty()
				and (main.call(
					"_player_support_surface_hit",
					candidate,
					null,
					String(record.kind)
				) as Dictionary).is_empty()
			):
				screen_position = candidate
				found = true
				break
		if found:
			break
	if not found:
		failures.append("reposition-target-missing")
		return
	var previous_position: Vector3 = record.position
	var previous_height := float(record.placement_height_offset)
	main.set("selected_editable_index", index)
	main.call("_move_selected_editable_to_pointer", screen_position)
	var expected_transform: Transform3D = main.call(
		"_player_placement_transform",
		screen_position,
		float(record.yaw),
		float(record.get("placement_footprint", 0.10)),
		0.0,
		null,
		true,
		String(record.kind)
	)
	var reposition_delta := (record.position as Vector3).distance_to(
		expected_transform.origin
	)
	if reposition_delta > 0.0001:
		failures.append(
			"reposition-position-mismatch:%s:%.4f:record=%s:expected=%s:height=%+.3f"
			% [
				String(record.id),
				reposition_delta,
				str(record.position),
				str(expected_transform.origin),
				float(record.placement_height_offset),
			]
		)
	if not is_equal_approx(
		float(record.placement_height_offset),
		previous_height
	) and String(record.get("placement_support_id", "")).is_empty():
		failures.append("reposition-changed-ungrounded-height")
	record["position"] = previous_position
	main.call("_apply_editable_3d_record", index)


func _verify_player_action_rail(
	main: Node,
	objects: Array,
	failures: Array[String]
) -> void:
	var dock := main.get("player_place_dock") as Control
	var buttons: Array[Button] = [
		main.get("player_place_button") as Button,
		main.get("player_save_symbol_button") as Button,
		main.get("player_photo_symbol_button") as Button,
		main.get("player_dialogue_symbol_button") as Button,
		main.get("player_sticker_symbol_button") as Button,
	]
	if dock == null:
		failures.append("player-action-dock-missing")
		return
	if bool(main.get("player_avatar_picker_open")):
		main.call("_close_player_avatar_picker_overlay")
	dock.visible = true
	main.call("_update_player_character_interaction_buttons")
	var column_x := -INF
	for button_value in buttons:
		var button := button_value as Button
		if button == null:
			failures.append("player-action-button-missing")
			return
		if not button.visible:
			failures.append("player-action-button-hidden")
		if button.size.x < 68.0 or button.size.y < 68.0:
			failures.append("player-action-button-too-small")
		if is_finite(column_x) and not is_equal_approx(button.position.x, column_x):
			failures.append("player-action-buttons-not-aligned")
		column_x = button.position.x
	main.set("editable_3d_objects", [])
	main.call("_update_player_character_interaction_buttons")
	for button_value in buttons:
		var button := button_value as Button
		if button == null or not button.visible:
			failures.append("player-action-button-hidden-after-delete-all")
			return

