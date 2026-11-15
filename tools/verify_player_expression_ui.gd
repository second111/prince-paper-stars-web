extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const OUTPUT_DIR := "res://tools/test_output/"


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	await process_frame
	_open_player_scene(main)
	if not await _wait_for_player_scene(main, 40.0):
		push_error("Player scene did not become ready.")
		quit(1)
		return
	await create_timer(0.8).timeout
	var failures: Array[String] = []
	var leader_index: int = main.call("_get_active_player_character_index")
	if leader_index < 0:
		push_error("Active player is missing.")
		quit(1)
		return
	var dialogue_button := main.get("player_dialogue_symbol_button") as Button
	var sticker_button := main.get("player_sticker_symbol_button") as Button
	var save_button := main.get("player_save_symbol_button") as Button
	var photo_button := main.get("player_photo_symbol_button") as Button
	if dialogue_button == null or not dialogue_button.visible:
		failures.append("dialogue-symbol-not-persistent")
	if sticker_button == null or not sticker_button.visible:
		failures.append("sticker-symbol-not-persistent")
	if save_button == null or not save_button.visible:
		failures.append("save-symbol-not-persistent")
	if photo_button == null or not photo_button.visible:
		failures.append("photo-symbol-not-persistent")
	main.call("_on_player_sticker_symbol_pressed")
	await process_frame
	var expression_bar := main.get("player_expression_bar") as PanelContainer
	if expression_bar == null or not expression_bar.visible:
		failures.append("sticker-symbol-requires-player-click")
	main.call("_on_player_sticker_symbol_pressed")
	await process_frame
	var leader_record: Dictionary = main.get("editable_3d_objects")[leader_index]
	var prince_index: int = main.call("_player_prince_record_index")
	var prince_record: Dictionary = main.get("editable_3d_objects")[prince_index]
	var player_target_yaw: float = main.call(
		"_player_character_yaw_toward_record",
		leader_record,
		prince_record
	)
	var prince_target_yaw: float = main.call(
		"_player_character_yaw_toward_record",
		prince_record,
		leader_record
	)
	var leader_node := leader_record.get("node") as Node3D
	var camera := main.get("camera_3d") as Camera3D
	var leader_bounds: AABB = main.call(
		"_editable_world_bounds",
		leader_node
	)
	var click := InputEventMouseButton.new()
	click.button_index = MOUSE_BUTTON_LEFT
	click.pressed = true
	click.position = camera.unproject_position(
		Vector3(
			leader_bounds.get_center().x,
			leader_bounds.position.y + leader_bounds.size.y * 0.22,
			leader_bounds.get_center().z
		)
	)
	var direct_pick: int = main.call(
		"_pick_player_character_at_screen",
		click.position
	)
	print(
		"PLAYER_CLICK_DEBUG position=",
		click.position,
		" bounds=",
		leader_bounds,
		" pick=",
		direct_pick
	)
	main.call("_handle_player_placement_pointer_event", click)
	await process_frame
	if not bool(main.get("player_character_interaction_open")):
		failures.append("player-click-does-not-open")
	if bool(main.get("player_navigation_active")):
		failures.append("player-click-fell-through-to-ground")
	if dialogue_button == null or not dialogue_button.visible:
		failures.append("dialogue-symbol")
	if sticker_button == null or not sticker_button.visible:
		failures.append("sticker-symbol")
	if dialogue_button != null and dialogue_button.icon == null:
		failures.append("dialogue-symbol-texture")
	if sticker_button != null and sticker_button.icon == null:
		failures.append("sticker-symbol-texture")
	if save_button != null and save_button.icon == null:
		failures.append("save-symbol-texture")
	if photo_button != null and photo_button.icon == null:
		failures.append("photo-symbol-texture")
	if (
		dialogue_button != null
		and dialogue_button.get_theme_stylebox("normal") is not StyleBoxEmpty
	):
		failures.append("dialogue-symbol-background")
	if (
		sticker_button != null
		and sticker_button.get_theme_stylebox("normal") is not StyleBoxEmpty
	):
		failures.append("sticker-symbol-background")
	if (
		dialogue_button != null
		and sticker_button != null
		and save_button != null
		and photo_button != null
	):
		var viewport_size := root.get_visible_rect().size
		var save_center := save_button.get_global_rect().get_center()
		var photo_center := photo_button.get_global_rect().get_center()
		var dialogue_center := dialogue_button.get_global_rect().get_center()
		var sticker_center := sticker_button.get_global_rect().get_center()
		if (
			save_center.x < viewport_size.x * 0.66
			or photo_center.x < viewport_size.x * 0.66
			or dialogue_center.x < viewport_size.x * 0.66
			or sticker_center.x < viewport_size.x * 0.66
			or save_center.y < viewport_size.y * 0.82
			or photo_center.y < viewport_size.y * 0.82
			or dialogue_center.y < viewport_size.y * 0.82
			or sticker_center.y < viewport_size.y * 0.82
		):
			failures.append("symbols-not-bottom-right")
		if (
			photo_center.x <= save_center.x
			or dialogue_center.x <= photo_center.x
			or sticker_center.x <= dialogue_center.x
			or absf(sticker_center.y - dialogue_center.y) > 2.0
		):
			failures.append("symbols-not-side-by-side")
	await _save_viewport("player_expression_symbols.png")
	main.call("_on_player_sticker_symbol_pressed")
	await process_frame
	var expression_buttons: Array = main.get("player_expression_buttons")
	if expression_bar == null or not expression_bar.visible:
		failures.append("expression-bar")
	if expression_buttons.size() != 10:
		failures.append("expression-button-count")
	for expression_button_value in expression_buttons:
		var expression_button := expression_button_value as Button
		if expression_button == null or expression_button.icon == null:
			failures.append("expression-icon")
	if expression_bar != null:
		var viewport_height := float(root.get_visible_rect().size.y)
		if expression_bar.get_global_rect().end.y > viewport_height + 1.0:
			failures.append("expression-bar-below-screen")
	main.call("_on_player_expression_pressed", "heart")
	await create_timer(0.46).timeout
	var player_popup := main.get("player_expression_popup") as TextureRect
	if (
		player_popup == null
		or not player_popup.visible
		or player_popup.texture == null
	):
		failures.append("player-sticker-popup")
	if String(main.get("player_expression_last_sent")) != "heart":
		failures.append("player-expression-state")
	if absf(wrapf(
		float(leader_record.get("yaw", 0.0)) - player_target_yaw,
		-180.0,
		180.0
	)) > 1.0:
		failures.append("player-not-facing-prince-after-sticker")
	var prince_popup := main.get("prince_expression_popup") as TextureRect
	await create_timer(0.65).timeout
	if prince_popup != null and prince_popup.visible:
		failures.append("prince-reply-too-early")
	await create_timer(0.90).timeout
	if (
		prince_popup == null
		or not prince_popup.visible
		or prince_popup.texture == null
	):
		failures.append("prince-sticker-reply")
	if String(main.get("player_expression_last_reply")) != "heart":
		failures.append("prince-reply-state")
	if absf(wrapf(
		float(prince_record.get("yaw", 0.0)) - prince_target_yaw,
		-180.0,
		180.0
	)) > 1.0:
		failures.append("prince-not-facing-player-after-sticker")
	if (
		player_popup != null
		and prince_popup != null
		and player_popup.position.distance_to(prince_popup.position) < 8.0
	):
		failures.append("sticker-popups-overlap")
	if not await _wait_for_popups_to_hide(player_popup, prince_popup):
		failures.append("sticker-popups-did-not-finish")
	if (
		absf(wrapf(
			float(leader_record.get("yaw", 0.0)) - player_target_yaw,
			-180.0,
			180.0
		)) > 1.0
		or absf(wrapf(
			float(prince_record.get("yaw", 0.0)) - prince_target_yaw,
			-180.0,
			180.0
		)) > 1.0
	):
		failures.append("mutual-sticker-gaze-not-persistent")
	await _save_viewport("player_expression_bar_and_reply.png")
	print(
		"PLAYER_EXPRESSION_UI buttons=",
		expression_buttons.size(),
		" player_visible=",
		player_popup != null and player_popup.visible,
		" prince_visible=",
		prince_popup != null and prince_popup.visible,
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


func _open_player_scene(main: Node) -> void:
	var states: Dictionary = main.get("memory_collection_states")
	for slug in ["rose", "king", "vain", "earth", "merchant", "pointlighter"]:
		states[slug] = "collected"
	var cover := main.get("cover") as Control
	var map_screen := main.get("map_screen") as Control
	cover.visible = false
	map_screen.visible = true
	main.call("_reveal_player_planet_on_map")
	main.call("_on_planet_pressed", "我的星球")


func _wait_for_popups_to_hide(
	player_popup: TextureRect,
	prince_popup: TextureRect,
	timeout_seconds: float = 6.0
) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		var player_hidden := player_popup == null or not player_popup.visible
		var prince_hidden := prince_popup == null or not prince_popup.visible
		if player_hidden and prince_hidden:
			return true
		await create_timer(0.1).timeout
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

