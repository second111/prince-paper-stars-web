extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	await process_frame
	await create_timer(0.35).timeout
	var failures: Array[String] = []
	var cover := main.get("cover") as Control
	var passage := main.get("passage") as Control
	var map_screen := main.get("map_screen") as Control
	var stage_3d := main.get("stage_3d") as Node3D
	var hud_3d := main.get("hud_3d") as CanvasLayer
	if cover == null or passage == null or map_screen == null:
		push_error("Map UI did not become ready.")
		quit(1)
		return
	cover.visible = false
	passage.visible = false
	if stage_3d != null:
		stage_3d.visible = false
	if hud_3d != null:
		hud_3d.visible = false
	map_screen.visible = true
	map_screen.modulate = Color.WHITE
	main.call("_skip_to_seventh_planet")
	await create_timer(1.45).timeout

	var records: Dictionary = main.get("planet_records")
	var planet_name := "我的星球"
	if not records.has(planet_name):
		failures.append("seventh-planet-record-missing")
	else:
		var record: Dictionary = records[planet_name]
		var data: Dictionary = record.data
		var holder := record.holder as Control
		var button := record.button as TextureButton
		if (data.center as Vector2).distance_to(Vector2(420, 684)) > 0.01:
			failures.append("seventh-planet-position")
		if (data.size as Vector2).distance_to(Vector2(228, 228)) > 0.01:
			failures.append("seventh-planet-size")
		if button == null or button.size.distance_to(Vector2(228, 228)) > 0.01:
			failures.append("seventh-planet-runtime-size")
		if holder == null or not holder.visible:
			failures.append("seventh-planet-not-visible")
	await _save_viewport("starmap_player_planet_scaled.png")
	print("PLAYER_PLANET_MAP failures=", failures)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


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

