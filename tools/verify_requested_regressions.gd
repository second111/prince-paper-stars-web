extends SceneTree


const ENDING_TEXTS := [
	"现在我能看清你了。\n\n玻璃罩还留在原处。风被挡在外面，月光重新落进来。",
	"原来安静也没有把我带走。\n\n他低头整理袖口。这一次，他没有先问镜子好不好看。",
	"第 501,620,001 号，核对无误。\n\n抽屉里没有星星，只有一块写着号码的星签。",
	"太阳落下了。\n\n现在，我大概会在看见麦子的时候想起你。",
]


func _initialize() -> void:
	var manager := root.get_node_or_null("SaveManager")
	if manager == null:
		push_error("SaveManager autoload is missing.")
		quit(1)
		return
	manager.start_new_game()
	manager.resume_target = ""

	await process_frame
	var main := (load("res://main.tscn") as PackedScene).instantiate()
	root.add_child(main)
	await process_frame
	main.set("preview_mode_active", true)
	for slug in ["rose", "king", "vain", "earth", "merchant", "pointlighter"]:
		main.get("memory_collection_states")[String(slug)] = "collected"
	(main.get("cover") as Control).visible = false
	(main.get("map_screen") as Control).visible = true
	await process_frame
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		var output_dir := "res://tools/test_output"
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))
		var image := root.get_viewport().get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png(ProjectSettings.globalize_path(
				output_dir.path_join("map_hint_without_paper.png")
			))
	main.call("_apply_player_planet_map_reveal", true)
	main.call("_on_planet_pressed", "我的星球")
	if not await _wait_for_player_scene(main, 45.0):
		push_error("Player scene did not become ready.")
		quit(1)
		return
	await create_timer(0.8).timeout

	var failures: Array[String] = []
	_verify_map_hint(main, failures)
	_verify_placement_list(main, failures)
	_verify_fresh_player_layout(main, failures)
	await _choose_avatar_and_verify_scene(main, failures)
	await _verify_player_onboarding_and_feedback(main, failures)
	await _verify_dialogue_hides_sidebar(main, failures)
	await _verify_ending_layouts(main, failures)

	print(
		"REQUESTED_REGRESSIONS failures=",
		failures,
		" records=",
		main.get("editable_3d_objects").size()
	)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


func _verify_map_hint(main: Node, failures: Array[String]) -> void:
	if main.get("map_hint_frame") != null:
		failures.append("map-hint-paper-still-present")
	if main.find_child("MapHintPaper", true, false) != null:
		failures.append("map-hint-paper-node-present")
	var hint := main.get("map_hint") as Label
	if hint == null or hint.text.is_empty():
		failures.append("map-hint-text-missing")


func _verify_placement_list(main: Node, failures: Array[String]) -> void:
	main.call("_refresh_player_placeable_entries")
	var forbidden := ["小王子", "长发小人", "短发小人"]
	for entry_value in main.get("player_placeable_entries"):
		var entry: Dictionary = entry_value
		var label := String(entry.get("label", ""))
		if label in forbidden:
			failures.append("placement-list-contains:" + label)


func _verify_fresh_player_layout(main: Node, failures: Array[String]) -> void:
	if not bool(main.get("player_avatar_picker_open")):
		failures.append("avatar-picker-not-open-for-new-save")
	var records: Array = main.get("editable_3d_objects")
	if records.size() != 1:
		failures.append("fresh-layout-object-count:%d" % records.size())
	for record_value in records:
		var record: Dictionary = record_value
		var kind := String(record.get("kind", ""))
		if kind != "player_prince":
			failures.append("fresh-layout-contains:" + kind)
		elif not is_equal_approx(float(record.get("scale", 0.0)), 0.7):
			failures.append("fresh-prince-scale-not-template")
		elif not is_equal_approx(
			float(record.get("placement_height_offset", 0.0)),
			-0.03
		):
			failures.append("fresh-prince-height-not-template")
		var node := record.get("node") as Node3D
		if node != null and node.visible:
			failures.append("fresh-layout-character-visible-before-choice")
	if not (main.get("player_light_strings") as Array).is_empty():
		failures.append("fresh-layout-has-light-strings")


func _choose_avatar_and_verify_scene(
	main: Node,
	failures: Array[String]
) -> void:
	main.call("_on_player_avatar_chosen", "player_short_hair_person")
	await create_timer(1.1).timeout
	if bool(main.get("player_avatar_picker_open")):
		failures.append("avatar-picker-did-not-close")
	main.call("_show_player_avatar_picker")
	await process_frame
	if bool(main.get("player_avatar_picker_open")):
		failures.append("avatar-picker-reopened-after-choice")
	if not bool(main.call("_player_has_chosen_avatar")):
		failures.append("chosen-avatar-not-detected-for-reentry")
	var records: Array = main.get("editable_3d_objects")
	if records.size() != 2:
		failures.append("post-choice-object-count:%d" % records.size())
	for record_value in records:
		var record: Dictionary = record_value
		var kind := String(record.get("kind", ""))
		if kind not in ["player_prince", "player_short_hair_person"]:
			failures.append("post-choice-extra-object:" + kind)
		var expected_scale := 0.7 if kind == "player_prince" else 0.75
		if not is_equal_approx(float(record.get("scale", 0.0)), expected_scale):
			failures.append("post-choice-scale-not-template:" + kind)
		var node := record.get("node") as Node3D
		if node == null or not node.visible:
			failures.append("post-choice-character-hidden:" + kind)
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		var output_dir := "res://tools/test_output"
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))
		var image := root.get_viewport().get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png(ProjectSettings.globalize_path(
				output_dir.path_join("player_fresh_scale_fixed.png")
			))


func _verify_dialogue_hides_sidebar(
	main: Node,
	failures: Array[String]
) -> void:
	main.call("_hide_player_onboarding_guide")
	await process_frame
	main.call("_update_player_character_interaction_buttons")
	var buttons: Array[Button] = [
		main.get("player_place_button") as Button,
		main.get("player_save_symbol_button") as Button,
		main.get("player_photo_symbol_button") as Button,
		main.get("player_dialogue_symbol_button") as Button,
		main.get("player_sticker_symbol_button") as Button,
	]
	for index in buttons.size():
		if buttons[index] == null or not buttons[index].visible:
			failures.append("sidebar-not-visible-before-dialogue:%d" % index)
	main.call("_on_player_dialogue_symbol_pressed")
	await process_frame
	if not bool(main.get("dialogue_active")):
		failures.append("player-dialogue-not-active")
	for index in buttons.size():
		if buttons[index] != null and buttons[index].visible:
			failures.append("sidebar-visible-during-dialogue:%d" % index)
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		var output_dir := "res://tools/test_output"
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))
		var image := root.get_viewport().get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png(ProjectSettings.globalize_path(
				output_dir.path_join("player_dialogue_sidebar_hidden.png")
			))
	main.call("_close_active_dialogue")
	await create_timer(0.75).timeout
	main.call("_update_player_character_interaction_buttons")
	for index in buttons.size():
		if buttons[index] == null or not buttons[index].visible:
			failures.append("sidebar-not-restored:%d" % index)


func _verify_player_onboarding_and_feedback(
	main: Node,
	failures: Array[String]
) -> void:
	var guide := main.get("player_move_guide") as TextureRect
	var overlay := main.get("player_onboarding_overlay") as Control
	if guide == null or not guide.visible:
		failures.append("movement-guide-not-visible")
	elif guide.size.x > 70.5 or guide.size.y > 101.5:
		failures.append("movement-guide-not-half-size:%s" % guide.size)
	if overlay != null and overlay.visible:
		failures.append("placement-guide-showed-before-movement")
	if not bool(main.get("player_avatar_selected")):
		failures.append("avatar-choice-not-persisted-in-session")
	var target: Vector3 = main.call(
		"_clamp_player_placement_plane_position",
		main.get("player_placement_plane_center")
			- (main.get("player_placement_plane_right") as Vector3) * 0.28
			+ (main.get("player_placement_plane_forward") as Vector3) * 0.12
	)
	var started: bool = main.call(
		"_begin_player_navigation",
		target,
		main.get("player_placement_plane_normal"),
		{}
	)
	if not started:
		failures.append("movement-guide-navigation-did-not-start")
		return
	var deadline := Time.get_ticks_msec() + 10000
	while bool(main.get("player_navigation_active")) and Time.get_ticks_msec() < deadline:
		await create_timer(0.05).timeout
	if bool(main.get("player_navigation_active")):
		failures.append("movement-guide-navigation-timeout")
		return
	await create_timer(0.3).timeout
	if not bool(main.get("player_move_guide_completed")):
		failures.append("movement-guide-not-completed")
	if not bool(main.get("player_day_night_guide_active")):
		failures.append("day-night-guide-not-started-after-arrival")
	if float(main.get("player_day_night_target")) >= 0.5:
		failures.append("day-night-guide-did-not-start-at-night")
	if overlay != null and overlay.visible:
		failures.append("placement-guide-showed-before-day-night-guide")
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		var output_dir := "res://tools/test_output"
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))
		var image := root.get_viewport().get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png(ProjectSettings.globalize_path(
				output_dir.path_join("player_day_night_guide.png")
			))
	main.call("_toggle_player_day_night")
	await create_timer(1.55).timeout
	if not bool(main.get("player_day_night_guide_completed")):
		failures.append("day-night-guide-not-completed")
	if float(main.get("player_day_night_target")) < 0.5:
		failures.append("day-night-guide-did-not-switch-to-day")
	if overlay == null or not overlay.visible:
		failures.append("placement-guide-not-shown-after-day-night")
		return
	if int(main.get("player_onboarding_step")) != 1:
		failures.append("placement-guide-wrong-step")
	var onboarding_button := main.get("player_onboarding_button") as Button
	if onboarding_button == null or onboarding_button.text != "去摆放":
		failures.append("placement-guide-button-label")
	main.call("_advance_player_onboarding")
	await process_frame
	var dock := main.get("player_place_dock") as PanelContainer
	var place_button := main.get("player_place_button") as Button
	if dock == null or not dock.visible:
		failures.append("placement-dock-not-opened-by-guide")
	if place_button == null:
		failures.append("placement-button-missing")
	elif place_button.scale.x <= 1.035:
		failures.append("placement-button-has-no-scale-feedback")
	elif place_button.modulate.r <= place_button.modulate.b:
		failures.append("placement-button-has-no-color-feedback")
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		var output_dir := "res://tools/test_output"
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))
		var image := root.get_viewport().get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png(ProjectSettings.globalize_path(
				output_dir.path_join("player_place_button_feedback.png")
			))
	main.call("_select_player_placement_object", 0, Vector2.ZERO)
	main.call("_toggle_player_item_lock")
	await process_frame
	var lock_button := main.get("player_item_lock_button") as Button
	var records: Array = main.get("editable_3d_objects")
	if records.is_empty() or not bool(records[0].get("locked", false)):
		failures.append("lock-feedback-state-not-set")
	if lock_button == null:
		failures.append("lock-button-missing")
	else:
		if lock_button.modulate.r <= lock_button.modulate.b:
			failures.append("lock-button-has-no-color-feedback")
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		var output_dir := "res://tools/test_output"
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))
		var image := root.get_viewport().get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png(ProjectSettings.globalize_path(
				output_dir.path_join("player_item_lock_feedback.png")
			))
	main.call("_toggle_player_item_lock")
	main.call("_toggle_player_placement_dock")
	await process_frame
	main.call("_hide_player_onboarding_guide")


func _verify_ending_layouts(main: Node, failures: Array[String]) -> void:
	var panel := main.get("story_subtitle_panel") as Control
	var label := main.get("story_subtitle_label") as Label
	if panel == null or label == null:
		failures.append("ending-layout-nodes-missing")
		return
	for text_value in ENDING_TEXTS:
		var text := String(text_value)
		main.call("_set_story_subtitle", text)
		await process_frame
		await process_frame
		if label.get_line_count() > 2:
			failures.append("ending-wrapped-beyond-two-lines")
		var line_height := label.get_line_height()
		var line_spacing := label.get_theme_constant("line_spacing")
		var content_height := (
			line_height * label.get_line_count()
			+ line_spacing * maxi(label.get_line_count() - 1, 0)
		)
		if content_height > label.size.y + 0.5:
			failures.append("ending-text-exceeds-panel-height")
		var font := label.get_theme_font("font")
		var font_size := label.get_theme_font_size("font_size")
		for line in label.text.split("\n"):
			var line_width := font.get_string_size(
				line,
				HORIZONTAL_ALIGNMENT_LEFT,
				-1.0,
				font_size
			).x
			if line_width > label.size.x + 0.5:
				failures.append("ending-text-exceeds-panel-width")
		if (
			label.get_global_rect().position.y < panel.get_global_rect().position.y
			or label.get_global_rect().end.y > panel.get_global_rect().end.y
		):
			failures.append("ending-label-outside-panel")
	main.call("_set_story_subtitle", ENDING_TEXTS[2])
	await process_frame
	print("STORY_ENDING_DISPLAY=", DisplayServer.get_name())
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		var output_dir := "res://tools/test_output"
		DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(output_dir))
		var image := root.get_viewport().get_texture().get_image()
		print(
			"STORY_ENDING_IMAGE empty=",
			image == null or image.is_empty(),
			" size=",
			Vector2i.ZERO if image == null else image.get_size()
		)
		if image != null and not image.is_empty():
			var save_error := image.save_png(ProjectSettings.globalize_path(
				output_dir.path_join("story_ending_merchant.png")
			))
			print("STORY_ENDING_CAPTURE save_error=", save_error)


func _wait_for_player_scene(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "player"
			and bool(main.get("generated_planet_ready").get("player", false))
			and bool(main.get("stage_3d").visible)
		):
			return true
		await create_timer(0.12).timeout
	return false
