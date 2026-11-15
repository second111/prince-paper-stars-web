extends Node


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const OUTPUT_PATH := "res://tools/test_output/journey_constellation_map.png"
const TEST_ORDER := [
	"king",
	"rose",
	"earth",
	"merchant",
	"vain",
	"pointlighter",
]


func _ready() -> void:
	var main := MAIN_SCRIPT.new()
	add_child(main)
	if not await _wait_for_map(main, 25.0):
		push_error("Star map did not become ready.")
		get_tree().quit(1)
		return
	main.set("preview_mode_active", true)
	var route: Array[String] = []
	for slug in TEST_ORDER:
		route.append(String(slug))
	main.set("journey_slugs", route)
	main.set("journey_legacy_reconstructed", false)

	var memories: Dictionary = main.get("memory_collection_states")
	for slug in TEST_ORDER:
		memories[slug] = "collected"
	main.set("memory_collection_states", memories)
	var planet_records: Dictionary = main.get("planet_records")
	for name_value in planet_records.keys():
		var name := String(name_value)
		if name != "我的星球":
			main.call("_apply_awake_visual", name, false, false)

	var cover := main.get("cover") as Control
	var map_screen := main.get("map_screen") as Control
	var passage := main.get("passage") as Control
	var ui_layout_editor := main.get("ui_layout_editor") as CanvasLayer
	var map_skip_button := main.get("map_skip_button") as Button
	cover.visible = false
	map_screen.visible = true
	passage.visible = false
	if ui_layout_editor != null:
		ui_layout_editor.visible = false
	if map_skip_button != null:
		map_skip_button.visible = false
	main.set("player_planet_revealed", true)
	main.call("_apply_player_planet_map_reveal", true)
	main.call("_refresh_journey_constellation", false)

	var route_layer = main.get("map_route_layer")
	var failures: Array[String] = []
	if route_layer == null:
		failures.append("route-layer-missing")
	else:
		var actual_stop_count := int(route_layer.call("get_stop_count"))
		var actual_segment_count := int(route_layer.call("get_segment_count"))
		var displayed_slugs: Array = route_layer.call("get_route_slugs")
		print(
			"JOURNEY_COUNTS stops=",
			actual_stop_count,
			" segments=",
			actual_segment_count,
			" slugs=",
			displayed_slugs
		)
		if actual_stop_count != TEST_ORDER.size() + 1:
			failures.append("route-stop-count")
		if actual_segment_count != TEST_ORDER.size():
			failures.append("route-segment-count")
		var expected_slugs: Array[String] = route
		expected_slugs.append("player")
		if displayed_slugs != expected_slugs:
			failures.append("route-order")
		route_layer.call("set_hovered_planet", "earth")
		await get_tree().process_frame
		route_layer.call("set_hovered_planet", "")

	var before_duplicate := (main.get("journey_slugs") as Array).size()
	main.call("_record_journey_stop", "king")
	var after_duplicate := (main.get("journey_slugs") as Array).size()
	if before_duplicate != after_duplicate:
		failures.append("duplicate-stop")

	for index in 8:
		await get_tree().process_frame
	await get_tree().create_timer(1.1).timeout
	for record_value in planet_records.values():
		var record: Dictionary = record_value
		var focus_ring := record.get("focus_ring") as TextureRect
		var art_group := record.get("art_group") as Control
		if focus_ring != null:
			focus_ring.visible = false
			focus_ring.modulate.a = 0.0
		if art_group != null:
			art_group.scale = Vector2.ONE
	route_layer.call("set_hovered_planet", "")
	await _save_viewport(OUTPUT_PATH)
	print("JOURNEY_CONSTELLATION failures=", failures)
	main.queue_free()
	get_tree().quit(1 if not failures.is_empty() else 0)


func _wait_for_map(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if main.get("map_route_layer") != null and main.get("map_screen") != null:
			return true
		await get_tree().create_timer(0.1).timeout
	return false


func _save_viewport(path: String) -> void:
	if DisplayServer.get_name() == "headless":
		return
	await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null:
		return
	var image := texture.get_image()
	if image != null and not image.is_empty():
		image.save_png(path)

