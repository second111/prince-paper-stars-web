extends SceneTree

const OUTPUT_PATH := "res://docs/previews/cover-king-left-clean.png"
const TARGET_SIZE := Vector2i(1728, 1080)
const CAMERA_DISTANCE := 3.9
const CAMERA_H_OFFSET := 0.85


func _initialize() -> void:
	root.size = TARGET_SIZE
	root.content_scale_size = TARGET_SIZE
	call_deferred("_render")


func _render() -> void:
	var scene := load("res://main.tscn") as PackedScene
	if scene == null:
		push_error("Could not load the main scene.")
		quit(1)
		return
	var main := scene.instantiate()
	root.add_child(main)
	current_scene = main
	await process_frame
	root.size = TARGET_SIZE
	root.content_scale_size = TARGET_SIZE

	var deadline := Time.get_ticks_msec() + 45000
	while (
		main.get("current_3d_scene") != "king"
		or not bool(main.get("stage_3d").visible)
	):
		if Time.get_ticks_msec() >= deadline:
			push_error("Timed out waiting for the king scene.")
			quit(2)
			return
		await process_frame

	# Let the loading transition and character animation settle.
	for frame in 90:
		await process_frame

	var camera := main.get("camera_3d") as Camera3D
	if camera == null:
		push_error("King scene camera is unavailable.")
		quit(3)
		return
	main.call("_set_3d_camera_distance", CAMERA_DISTANCE)
	camera.h_offset = CAMERA_H_OFFSET

	var hud := main.get("hud_3d") as CanvasLayer
	if hud != null:
		hud.visible = false
	var main_ui := main.get("main_ui") as Control
	if main_ui != null:
		main_ui.visible = false
	if main.get("dream_grade_layer") is CanvasLayer:
		(main.get("dream_grade_layer") as CanvasLayer).visible = true

	# The cover uses an uninterrupted starfield rather than menu-like scene
	# ornaments. Planet-local fireflies remain part of the artwork.
	var celestial_root := main.get("king_celestial_root") as Node3D
	if celestial_root != null:
		celestial_root.visible = false
	for cloud_value in main.get("cloud_sprites"):
		var cloud := (cloud_value as Dictionary).get("sprite") as Sprite3D
		if cloud != null:
			cloud.visible = false

	var cursor_director := root.get_node_or_null("CursorDirector")
	if cursor_director != null:
		cursor_director.call("_set_tracking", false)

	# Several frames ensure deferred viewport sizing and animation have
	# produced the final rendered frame.
	for frame in 12:
		await process_frame

	var image := root.get_texture().get_image()
	if image == null or image.is_empty():
		push_error("Rendered viewport image is empty.")
		quit(4)
		return
	var save_path := ProjectSettings.globalize_path(OUTPUT_PATH)
	var save_error := image.save_png(save_path)
	if save_error != OK:
		push_error("Could not save cover render: %s" % save_path)
		quit(5)
		return
	print("KING_COVER_RENDERED path=%s size=%dx%d" % [
		save_path,
		image.get_width(),
		image.get_height(),
	])
	quit()
