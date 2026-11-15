extends Control

const OUTPUT_PATH := "res://tools/test_output/cursor_trail_preview.png"


func _ready() -> void:
	_build_test_background()
	await get_tree().process_frame
	var cursor_director := get_node("/root/CursorDirector")
	var trail := cursor_director.get_node("FallingStarTrail") as Node2D
	var halo := cursor_director.get_node("FallingStarHoverHalo") as Node2D
	var star := cursor_director.get_node("FallingStarCursor") as TextureRect
	Input.warp_mouse(Vector2(get_window().size) * 0.5)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	await get_tree().process_frame
	halo.call("set_hovered", true)
	star.queue_redraw()
	for frame in 20:
		await get_tree().process_frame
	print("CURSOR_TRAIL_SHAPE=", Input.get_current_cursor_shape())
	var hovered_control := get_viewport().gui_get_hovered_control()
	print(
		"CURSOR_TRAIL_HOVER=",
		hovered_control.name if hovered_control != null else "<none>"
	)
	trail.call("clear_trail")
	for index in 22:
		var progress := float(index) / 21.0
		var point := Vector2(
			lerpf(560.0, 800.0, progress),
			lerpf(650.0, 500.0, progress) - sin(progress * PI) * 34.0
		)
		trail.call("push_point", point)
	await get_tree().process_frame
	await RenderingServer.frame_post_draw
	var image := get_viewport().get_texture().get_image()
	if image == null or image.is_empty():
		push_error("Cursor preview capture is empty.")
		get_tree().quit(1)
		return
	var save_error := image.save_png(OUTPUT_PATH)
	if save_error != OK:
		push_error("Could not save cursor preview: %s" % save_error)
		get_tree().quit(1)
		return
	print(
		"CURSOR_TRAIL_OK path=", OUTPUT_PATH,
		" size=", image.get_width(), "x", image.get_height()
	)
	get_tree().quit(0)


func _build_test_background() -> void:
	var dark := ColorRect.new()
	dark.color = Color(0.025, 0.05, 0.095)
	dark.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(dark)

	var paper := ColorRect.new()
	paper.color = Color(0.91, 0.85, 0.73)
	paper.position = Vector2(800.0, 0.0)
	paper.size = Vector2(800.0, 1000.0)
	paper.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(paper)

	var label := Label.new()
	label.text = "Cursor trail contrast check"
	label.position = Vector2(42.0, 36.0)
	label.add_theme_font_size_override("font_size", 24)
	label.add_theme_color_override("font_color", Color(0.95, 0.87, 0.7))
	add_child(label)

	var hover_target := Button.new()
	hover_target.text = "HOVER"
	hover_target.position = Vector2(742.0, 442.0)
	hover_target.size = Vector2(116.0, 92.0)
	hover_target.focus_mode = Control.FOCUS_NONE
	hover_target.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	add_child(hover_target)
