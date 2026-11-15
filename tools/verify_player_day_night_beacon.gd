extends Node


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const DAY_CAPTURE_PATH := "res://tools/test_output/player_day_night_beacon_day.png"
const NIGHT_CAPTURE_PATH := "res://tools/test_output/player_day_night_beacon_night.png"
const RIPPLE_CAPTURE_PATH := "res://tools/test_output/player_day_night_beacon_ripple.png"
const CLICK_CAPTURE_PATH := "res://tools/test_output/player_day_night_beacon_click.png"


func _ready() -> void:
	var main := MAIN_SCRIPT.new()
	add_child(main)
	await get_tree().process_frame
	await main.call("_show_generated_planet_3d", "我的星球", 0)
	if not await _wait_for_player_scene(main, 40.0):
		push_error(
			"Player scene did not become ready. current=%s ready=%s stage=%s args=%s"
			% [
				main.get("current_3d_scene"),
				main.get("generated_planet_ready"),
				main.get("stage_3d").visible,
				OS.get_cmdline_user_args(),
			]
		)
		get_tree().quit(1)
		return
	await get_tree().create_timer(1.0).timeout
	if bool(main.get("player_avatar_picker_open")):
		main.call("_close_player_avatar_picker_overlay")
		await get_tree().process_frame
	var failures: Array[String] = []
	var original_target := float(main.get("player_day_night_target"))
	var original_blend := float(main.get("player_day_night_blend"))
	main.set("player_day_night_target", 1.0)
	main.set("player_day_night_blend", 1.0)
	main.call("_apply_player_day_night", 1.0)
	var beacon := main.get("player_day_night_beacon") as Node3D
	var core := main.get("player_day_night_beacon_core") as MeshInstance3D
	var halo := main.get("player_day_night_beacon_halo") as Sprite3D
	var ripple := main.get("player_day_night_beacon_ripple") as Control
	var camera := main.get("camera_3d") as Camera3D
	if beacon == null:
		failures.append("beacon-missing")
	if core == null:
		failures.append("beacon-core-missing")
	if halo == null:
		failures.append("beacon-halo-missing")
	if ripple == null:
		failures.append("beacon-ripple-missing")
	if beacon != null and not beacon.visible:
		failures.append("beacon-hidden")
	if camera != null and beacon != null:
		var beacon_screen := camera.unproject_position(beacon.global_position)
		if not bool(main.call("_is_player_day_night_beacon_at_screen", beacon_screen)):
			failures.append("beacon-not-clickable")
	if ripple != null and beacon != null:
		main.set("player_day_night_beacon_hovered", true)
		ripple.call(
			"set_feedback",
			true,
			main.get("player_day_night_beacon_color")
		)
		main.call("_update_player_day_night_beacon")
		await get_tree().process_frame
		if not bool(ripple.get("hovered")):
			failures.append("hover-ripple-not-active")
		if not ripple.visible:
			failures.append("hover-ripple-hidden")
		await _capture(RIPPLE_CAPTURE_PATH, main, false)
	var initial_day_color := _beacon_color(main)
	await _capture(DAY_CAPTURE_PATH, main)
	main.call("_toggle_player_day_night")
	if ripple != null and (_click_ripples(ripple).size() < 2):
		failures.append("click-ripple-not-triggered")
	await get_tree().create_timer(0.10).timeout
	await _capture(CLICK_CAPTURE_PATH, main, false)
	if float(main.get("player_day_night_target")) >= 0.5:
		failures.append("toggle-to-night-failed")
	await get_tree().create_timer(1.6).timeout
	var night_color := _beacon_color(main)
	if night_color.b <= night_color.r:
		failures.append("night-color-not-blue-silver")
	var color_delta := Vector3(
		night_color.r - initial_day_color.r,
		night_color.g - initial_day_color.g,
		night_color.b - initial_day_color.b
	).length()
	if color_delta < 0.2:
		failures.append("beacon-color-did-not-change")
	await _capture(NIGHT_CAPTURE_PATH, main)
	main.call("_toggle_player_day_night")
	if float(main.get("player_day_night_target")) < 0.5:
		failures.append("toggle-to-day-failed")
	await get_tree().create_timer(1.6).timeout
	main.set("player_day_night_target", original_target)
	main.set("player_day_night_blend", original_blend)
	main.call("_apply_player_day_night", original_blend)
	main.call("_save_3d_layout")
	if failures.is_empty():
		print(
			"PLAYER_DAY_NIGHT_BEACON_OK day=",
			initial_day_color,
			" night=",
			night_color
		)
		main.queue_free()
		get_tree().quit(0)
		return
	push_error("PLAYER_DAY_NIGHT_BEACON_FAILED: " + ", ".join(failures))
	main.queue_free()
	get_tree().quit(1)


func _beacon_color(main: Node) -> Color:
	var material := main.get(
		"player_day_night_beacon_core_material"
	) as StandardMaterial3D
	return material.emission if material != null else Color.TRANSPARENT


func _wait_for_player_scene(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "player"
			and bool(main.get("generated_planet_ready").get("player", false))
			and bool(main.get("stage_3d").visible)
		):
			return true
		await get_tree().create_timer(0.12).timeout
	return false


func _capture(path: String, main: Node, hide_hud := true) -> void:
	var hud := main.get("hud_3d") as CanvasLayer
	var hud_was_visible := hud != null and hud.visible
	if hud != null and hide_hud:
		hud.visible = false
	await get_tree().create_timer(0.2).timeout
	var image := get_viewport().get_texture().get_image()
	if image == null or image.is_empty():
		if hud != null and hide_hud:
			hud.visible = hud_was_visible
		return
	image.save_png(path)
	if hud != null and hide_hud:
		hud.visible = hud_was_visible


func _click_ripples(ripple: Control) -> Array:
	var value = ripple.get("_click_ripples")
	return value as Array if typeof(value) == TYPE_ARRAY else []

