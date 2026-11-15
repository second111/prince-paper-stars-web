extends Node


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const OUTPUT_DIR := "res://tools/test_output/"


func _ready() -> void:
	var main := MAIN_SCRIPT.new()
	add_child(main)
	await get_tree().process_frame
	await _open_player_scene(main)
	if not await _wait_for_player_scene(main, 40.0):
		push_error("Player scene did not become ready.")
		get_tree().quit(1)
		return
	await get_tree().create_timer(1.0).timeout
	var failures: Array[String] = []
	var viewport_size := get_viewport().get_visible_rect().size
	if bool(main.get("player_avatar_picker_open")):
		main.call("_close_player_avatar_picker_overlay")
	await get_tree().process_frame
	main.call("_update_player_character_interaction_buttons")
	var place_button := main.get("player_place_button") as Button
	var save_button := main.get("player_save_symbol_button") as Button
	var photo_button := main.get("player_photo_symbol_button") as Button
	var dialogue_button := main.get("player_dialogue_symbol_button") as Button
	var sticker_button := main.get("player_sticker_symbol_button") as Button
	var layout_button := main.get("editor_edit_button") as Button
	var reset_button := main.get("player_character_reset_button") as Button
	if layout_button != null and layout_button.visible:
		failures.append("layout-button-visible")
	if reset_button != null and reset_button.visible:
		failures.append("reset-button-visible")
	var buttons := [
		place_button,
		save_button,
		photo_button,
		dialogue_button,
		sticker_button,
	]
	var first_center := Vector2.ZERO
	var previous_center := Vector2.ZERO
	var first_button := true
	for button in buttons:
		if button == null or not button.visible:
			failures.append("entry-not-visible")
			continue
		var center: Vector2 = button.get_global_rect().get_center()
		if center.x < viewport_size.x * 0.90:
			failures.append("entry-not-right-rail")
		if button.size.x < 79.0 or button.size.y < 79.0:
			failures.append("entry-too-small")
		if button.icon == null:
			failures.append("entry-icon-missing")
		if first_button:
			first_center = center
			first_button = false
		elif (
			absf(center.x - first_center.x) > 1.0
			or center.y <= previous_center.y
		):
			failures.append("entry-not-vertical")
		previous_center = center
	if buttons[buttons.size() - 1].get_global_rect().end.x > viewport_size.x - 36.0:
		failures.append("entry-right-overflow")
	await _save_viewport("player_keepsake_entries.png")
	main.call("_on_player_sticker_symbol_pressed")
	var expression_bar := main.get("player_expression_bar") as PanelContainer
	var scene_hint := main.get("hud_scene_hint") as Label
	if expression_bar == null:
		failures.append("sticker-bar-missing")
	elif scene_hint != null:
		expression_bar.visible = true
		main.set_process(false)
		if (
			expression_bar.get_global_rect().end.y
				> scene_hint.get_global_rect().position.y - 8.0
		):
			failures.append("sticker-bar-covers-hint")
		await _save_viewport("player_sticker_bar_position.png")
		main.set_process(true)
		expression_bar.visible = false
	else:
		failures.append("scene-hint-missing")
	await get_tree().process_frame

	main.call("_on_player_save_symbol_pressed")
	await get_tree().process_frame
	var save_toast := main.get("player_save_toast") as Label
	if save_toast == null or not save_toast.visible:
		failures.append("save-feedback")
	if not FileAccess.file_exists("user://player_layout.json"):
		failures.append("save-layout-file")
	var expression_history: Array = main.get("player_expression_history")
	expression_history.append({"sent": "heart", "reply": "heart"})
	expression_history.append({"sent": "goodnight", "reply": "goodnight"})

	main.call("_on_player_photo_symbol_pressed")
	await get_tree().process_frame
	var flow: CanvasLayer = main.get("player_keepsake_flow") as CanvasLayer
	var hud := main.get("hud_3d") as CanvasLayer
	var ui_editor := main.get("ui_layout_editor") as CanvasLayer
	var camera := main.get("camera_3d") as Camera3D
	var model := main.get("model_3d") as Node3D
	if flow == null or not bool(flow.visible):
		failures.append("capture-flow-not-open")
		_finish(main, failures)
		return
	if hud.visible:
		failures.append("hud-not-hidden")
	if ui_editor != null and ui_editor.visible:
		failures.append("layout-editor-not-hidden")
	if camera == null:
		failures.append("camera-missing")
		_finish(main, failures)
		return
	if model == null:
		failures.append("planet-model-missing")
		_finish(main, failures)
		return
	var initial_h_offset := camera.h_offset
	var initial_position := camera.global_position
	var initial_distance := float(main.get("camera_distance"))
	var initial_model_rotation := model.global_basis.get_rotation_quaternion()
	var capture_frame := flow.get("capture_frame") as Panel
	var capture_controls := flow.get("capture_controls") as Control
	if capture_frame == null or capture_controls == null:
		failures.append("capture-controls-missing")
		_finish(main, failures)
		return
	if not bool(flow.call(
		"_capture_drag_point_allowed",
		capture_frame.get_global_rect().get_center()
	)):
		failures.append("viewfinder-drag-not-allowed")
	if bool(flow.call(
		"_capture_drag_point_allowed",
		capture_controls.get_global_rect().get_center()
	)):
		failures.append("camera-controls-intercept-planet-drag")
	var drag_position := capture_frame.get_global_rect().get_center()
	var drag_press := InputEventMouseButton.new()
	drag_press.button_index = MOUSE_BUTTON_LEFT
	drag_press.pressed = true
	drag_press.position = drag_position
	flow.call("_input", drag_press)
	var drag_motion := InputEventMouseMotion.new()
	drag_motion.position = drag_position + Vector2(32.0, 0.0)
	drag_motion.relative = Vector2(32.0, 0.0)
	flow.call("_input", drag_motion)
	var drag_release := InputEventMouseButton.new()
	drag_release.button_index = MOUSE_BUTTON_LEFT
	drag_release.pressed = false
	drag_release.position = drag_motion.position
	flow.call("_input", drag_release)
	if (
		initial_model_rotation.angle_to(
			model.global_basis.get_rotation_quaternion()
		) < 0.001
	):
		failures.append("planet-drag-no-rotation")
	flow.call("_zoom_camera", 0.65)
	flow.call("_pan_camera", Vector2(1.0, 0.0))
	flow.call("_adjust_capture_pitch", 12.0)
	if is_equal_approx(float(main.get("camera_distance")), initial_distance):
		failures.append("camera-zoom-not-applied")
	if is_equal_approx(camera.h_offset, initial_h_offset):
		failures.append("camera-pan")
	if camera.global_position.distance_to(initial_position) < 0.001:
		failures.append("camera-pitch")
	var pitch_label := flow.get("pitch_label") as Label
	if pitch_label == null or pitch_label.text == "0°":
		failures.append("camera-pitch-readout")
	await _save_viewport("player_capture_ui.png")
	flow.call("_reset_capture_camera")
	if camera.global_position.distance_to(initial_position) > 0.001:
		failures.append("camera-pitch-reset")
	if not is_equal_approx(float(main.get("camera_distance")), initial_distance):
		failures.append("camera-zoom-reset")
	if (
		DisplayServer.get_name() == "headless"
		or OS.get_cmdline_user_args().has("--capture-ui-only")
	):
		print(
			"PLAYER_KEEPSAKE_FLOW buttons=", buttons.size(),
			" drag=true zoom=true reset=true failures=", failures
		)
		_finish(main, failures)
		return

	flow.call("_on_shutter_pressed")
	if not await _wait_for_property(flow, "visible", true, 8.0):
		failures.append("flow-hidden-after-capture")
	var name_modal := flow.get("name_modal") as Control
	if not await _wait_until_visible(name_modal, 8.0):
		failures.append("name-modal")
		_finish(main, failures)
		return
	await _save_viewport("player_capture_name_modal.png")
	var name_field := flow.get("name_field") as LineEdit
	name_field.text = "测试星球"
	flow.call("_on_name_submitted", name_field.text)
	var result_root := flow.get("result_root") as Control
	if not await _wait_until_visible(result_root, 15.0):
		failures.append("letter-result")
		_finish(main, failures)
		return
	var current_letter := flow.get("current_letter") as Image
	if current_letter == null or current_letter.is_empty():
		failures.append("letter-image")
	else:
		if (
			current_letter.get_width() != 1440
			or current_letter.get_height() != 1440
		):
			failures.append("letter-size")
		current_letter.save_png(OUTPUT_DIR + "player_letter_generated.png")
	var last_letter_path := String(flow.get("last_letter_path"))
	if last_letter_path.is_empty() or not FileAccess.file_exists(last_letter_path):
		failures.append("letter-file")
	var letter_copy: Dictionary = flow.get("last_letter_copy")
	var classification := String(letter_copy.get("classification", ""))
	var action := String(letter_copy.get("action", ""))
	var echo := String(letter_copy.get("echo", ""))
	if not classification.contains("星球"):
		failures.append("letter-classification")
	if not action.contains("比心") or not action.contains("晚安"):
		failures.append("letter-action-history")
	if echo.is_empty() or not echo.contains("你和小王子"):
		failures.append("letter-layout-echo")
	var share_url := String(flow.get("last_share_url"))
	if not share_url.begins_with("http://"):
		failures.append("share-url")
	else:
		var request := HTTPRequest.new()
		request.timeout = 5.0
		get_tree().root.add_child(request)
		if request.request(share_url) != OK:
			failures.append("share-request-start")
		else:
			var response: Array = await request.request_completed
			var response_code := int(response[1])
			var response_body: PackedByteArray = response[3]
			if response_code != 200:
				failures.append("share-page-status")
			elif not response_body.get_string_from_utf8().contains("星球手记"):
				failures.append("share-page-content")
		request.queue_free()
		var image_request := HTTPRequest.new()
		image_request.timeout = 5.0
		get_tree().root.add_child(image_request)
		if image_request.request(share_url + ".png") != OK:
			failures.append("share-image-request-start")
		else:
			var image_response: Array = await image_request.request_completed
			var image_body: PackedByteArray = image_response[3]
			if (
				int(image_response[1]) != 200
				or image_body.size() < 1000
				or image_body.slice(0, 8)
					!= PackedByteArray([137, 80, 78, 71, 13, 10, 26, 10])
			):
				failures.append("share-image-content")
		image_request.queue_free()
	await _save_viewport("player_letter_result.png")
	flow.call("close_flow")
	await get_tree().process_frame
	if not hud.visible:
		failures.append("hud-not-restored")
	print(
		"PLAYER_KEEPSAKE_FLOW buttons=", buttons.size(),
		" letter_saved=", last_letter_path,
		" share_url=", share_url,
		" copy=", letter_copy,
		" failures=", failures
	)
	_finish(main, failures)


func _finish(main: Node, failures: Array[String]) -> void:
	print("PLAYER_KEEPSAKE_FLOW failures=", failures)
	main.queue_free()
	get_tree().quit(1 if not failures.is_empty() else 0)


func _open_player_scene(main: Node) -> void:
	var states: Dictionary = main.get("memory_collection_states")
	for slug in ["rose", "king", "vain", "earth", "merchant", "pointlighter"]:
		states[slug] = "collected"
	var cover := main.get("cover") as Control
	var map_screen := main.get("map_screen") as Control
	cover.visible = false
	map_screen.visible = true
	main.call("_reveal_player_planet_on_map")
	await main.call("_show_generated_planet_3d", "我的星球", 0)


func _wait_for_player_scene(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "player"
			and bool(main.get("generated_planet_ready").get("player", false))
		):
			return true
		await get_tree().create_timer(0.12).timeout
	return false


func _wait_until_visible(control: Control, timeout_seconds: float) -> bool:
	if control == null:
		return false
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if control.visible:
			return true
		await get_tree().create_timer(0.08).timeout
	return false


func _wait_for_property(
	object: Object,
	property_name: String,
	expected: Variant,
	timeout_seconds: float
) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if object != null and object.get(property_name) == expected:
			return true
		await get_tree().create_timer(0.08).timeout
	return false


func _save_viewport(file_name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return
	await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null:
		return
	var image := texture.get_image()
	if image != null and not image.is_empty():
		image.save_png(OUTPUT_DIR + file_name)

