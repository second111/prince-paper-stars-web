extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const PICKER_CAPTURE := "res://tools/test_output/player_avatar_picker.png"
const SELECTED_CAPTURE := "res://tools/test_output/player_avatar_picker_selected.png"


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	if not await _wait_for_player_avatar_picker(main, 45.0):
		push_error("Player avatar picker did not open on first entry.")
		quit(1)
		return
	var cards: Array = main.get("player_avatar_picker_cards")
	if cards.size() != 2:
		push_error("Expected two avatar cards, found %d." % cards.size())
		quit(1)
		return
	var characters_were_hidden := _player_characters_hidden(main)
	if not characters_were_hidden:
		push_error("Player characters must stay hidden while choosing an avatar.")
	var previews: Array = main.get("player_avatar_picker_previews")
	for index in mini(previews.size(), 2):
		var preview := previews[index] as TextureRect
		if preview != null and preview.texture == null:
			await create_timer(2.5).timeout
			break
	await RenderingServer.frame_post_draw
	_save_capture(PICKER_CAPTURE)

	var prince_before := _character_layout_signature(main, "player_prince")
	var long_before := _character_layout_signature(
		main,
		"player_long_hair_person"
	)
	var long_card := cards[1] as Button
	long_card.emit_signal("pressed")
	await create_timer(1.4).timeout
	var failures: Array[String] = []
	if bool(main.get("player_avatar_picker_open")):
		failures.append("picker-still-open")
	if not bool(main.get("player_avatar_picker_completed")):
		failures.append("choice-not-completed")
	var card_labels: Array[String] = []
	for card_value in cards:
		var card := card_value as Button
		for label_value in card.find_children("*", "Label", true, false):
			card_labels.append(String((label_value as Label).text))
	for expected_label in ["形象一", "形象二"]:
		if expected_label not in card_labels:
			failures.append("missing-label:%s" % expected_label)
	var active_kind := _active_player_kind(main)
	if active_kind != "player_long_hair_person":
		failures.append("wrong-active-kind:%s" % active_kind)
	if not _kind_is_visible(main, "player_long_hair_person"):
		failures.append("chosen-player-hidden")
	if not _kind_is_visible(main, "player_prince"):
		failures.append("prince-hidden")
	if _kind_is_visible(main, "player_short_hair_person"):
		failures.append("other-avatar-visible")
	if _character_layout_signature(main, "player_long_hair_person") != long_before:
		failures.append("chosen-layout-overwritten")
	if _character_layout_signature(main, "player_prince") != prince_before:
		failures.append("prince-layout-overwritten")
	_print_character_projection(main, "player_long_hair_person")
	_print_character_projection(main, "player_prince")
	main.call("_show_player_avatar_picker")
	await process_frame
	if bool(main.get("player_avatar_picker_open")):
		failures.append("picker-reopened")
	await RenderingServer.frame_post_draw
	_save_capture(SELECTED_CAPTURE)
	print(
		"PLAYER_AVATAR_PICKER cards=",
		cards.size(),
		" hidden_before=",
		characters_were_hidden,
		" active=",
		active_kind,
		" failures=",
		failures
	)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


func _wait_for_player_avatar_picker(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "player"
			and bool(main.get("player_avatar_picker_open"))
			and bool(main.get("stage_3d").visible)
		):
			return true
		await create_timer(0.12).timeout
	return false


func _player_characters_hidden(main: Node) -> bool:
	for kind in [
		"player_long_hair_person",
		"player_short_hair_person",
		"player_prince",
	]:
		if _kind_is_visible(main, kind):
			return false
	return true


func _kind_is_visible(main: Node, kind: String) -> bool:
	var records: Array = main.get("editable_3d_objects")
	for record_value in records:
		var record: Dictionary = record_value
		if String(record.get("kind", "")) != kind:
			continue
		var node := record.get("node") as Node3D
		return node != null and is_instance_valid(node) and node.visible
	return false


func _active_player_kind(main: Node) -> String:
	var active_id := String(main.get("active_player_character_id"))
	var records: Array = main.get("editable_3d_objects")
	for record_value in records:
		var record: Dictionary = record_value
		if String(record.get("id", "")) == active_id:
			return String(record.get("kind", ""))
	return ""


func _character_layout_signature(main: Node, kind: String) -> String:
	var records: Array = main.get("editable_3d_objects")
	for record_value in records:
		var record: Dictionary = record_value
		if String(record.get("kind", "")) != kind:
			continue
		return "%s|%s|%s|%s" % [
			record.get("scale"),
			record.get("placement_height_offset"),
			record.get("position"),
			record.get("yaw"),
		]
	return ""


func _print_character_projection(main: Node, kind: String) -> void:
	var camera := main.get("camera_3d") as Camera3D
	var records: Array = main.get("editable_3d_objects")
	for record_value in records:
		var record: Dictionary = record_value
		if String(record.get("kind", "")) != kind:
			continue
		var node := record.get("node") as Node3D
		if node == null:
			return
		var model := main.get("model_3d") as Node3D
		var world_origin := model.global_transform * (
			record.get("position", Vector3.ZERO) as Vector3
		)
		var screen := camera.unproject_position(world_origin)
		print(
			"AVATAR_PROJECTION kind=",
			kind,
			" screen=",
			screen,
			" position=",
			record.get("position"),
			" scale=",
			record.get("scale"),
			" visible=",
			node.visible
		)


func _save_capture(path: String) -> void:
	var texture := root.get_viewport().get_texture()
	if texture == null:
		return
	var image := texture.get_image()
	if image != null and not image.is_empty():
		image.save_png(path)

