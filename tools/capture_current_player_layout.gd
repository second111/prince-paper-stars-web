extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const OUTPUT_PATH := "res://tools/test_output/current_player_layout_clean.png"


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	if not await _wait_for_player_scene(main, 40.0):
		push_error("Player scene did not become ready.")
		quit(1)
		return
	await create_timer(1.6).timeout
	var hud_3d := main.get("hud_3d") as CanvasLayer
	if hud_3d == null:
		push_error("3D HUD is missing.")
		quit(1)
		return
	hud_3d.visible = false
	var ui_layout_editor := main.get("ui_layout_editor") as CanvasLayer
	if ui_layout_editor != null:
		ui_layout_editor.visible = false
	await create_timer(0.45).timeout
	var texture := root.get_viewport().get_texture()
	if texture == null:
		push_error("Viewport texture is missing.")
		quit(1)
		return
	var image := texture.get_image()
	if image == null or image.is_empty():
		push_error("Viewport image is empty.")
		quit(1)
		return
	var error := image.save_png(OUTPUT_PATH)
	if error != OK:
		push_error("Could not save current player layout capture.")
		quit(1)
		return
	print("CURRENT_PLAYER_LAYOUT_CAPTURED path=", OUTPUT_PATH)
	main.queue_free()
	quit(0)


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

