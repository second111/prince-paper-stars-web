extends SceneTree


const OUTPUT_PATH := "res://tools/test_output/journey_finale_sequence.png"
const TEST_ORDER := [
	"king",
	"rose",
	"earth",
	"merchant",
	"vain",
	"pointlighter",
]


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var failures: Array[String] = []
	var main: Node = load("res://main.tscn").instantiate()
	root.add_child(main)
	var deadline := Time.get_ticks_msec() + 45000
	while Time.get_ticks_msec() < deadline:
		if main.get("map_route_layer") != null and main.get("map_screen") != null:
			break
		await create_timer(0.1).timeout
	if main.get("map_route_layer") == null:
		failures.append("map-not-ready")
	else:
		main.set("preview_mode_active", true)
		var memories: Dictionary = main.get("memory_collection_states")
		for slug in TEST_ORDER:
			memories[slug] = "collected"
		main.set("memory_collection_states", memories)
		var route: Array[String] = []
		for slug in TEST_ORDER:
			route.append(String(slug))
		main.set("journey_slugs", route)
		main.set("journey_legacy_reconstructed", false)
		main.set("journey_finale_played", false)
		main.set("journey_finale_sequence_active", false)
		main.set("player_planet_revealed", false)

		var planet_records: Dictionary = main.get("planet_records")
		for name_value in planet_records.keys():
			var name := String(name_value)
			if name != "我的星球":
				main.call("_apply_awake_visual", name, false, false)
		var cover := main.get("cover") as Control
		var map_screen := main.get("map_screen") as Control
		cover.visible = false
		map_screen.visible = true
		main.call("_apply_player_planet_map_reveal", false)
		await process_frame
		print(
			"FINALE_PRECALL all=",
			main.call("_all_memories_collected"),
			" slugs=",
			main.get("journey_slugs"),
			" played=",
			main.get("journey_finale_played"),
			" active=",
			main.get("journey_finale_sequence_active")
		)

		var player_record: Dictionary = planet_records["我的星球"]
		var holder := player_record.holder as Control
		var button := player_record.button as TextureButton
		var passage := main.get("passage") as Control
		var prince := main.get("passage_prince_below") as TextureRect
		if not holder.visible:
			failures.append("player-map-art-not-always-present")
		if not button.disabled:
			failures.append("locked-player-planet-clickable")
		if passage == null or not passage.visible or prince == null:
			failures.append("locked-player-prince-occluder-missing")
		elif not (
			prince.get_global_transform()
			* Rect2(Vector2.ZERO, prince.size)
		).has_point(holder.get_global_rect().get_center()):
			failures.append("locked-player-planet-not-occluded")
		var locked_image := root.get_texture().get_image()
		if locked_image != null and not locked_image.is_empty():
			locked_image.save_png("res://tools/test_output/journey_locked_seventh.png")

		main.call("_play_final_journey_sequence")
		await create_timer(0.72).timeout
		var route_layer = main.get("map_route_layer")
		var segment_count := int(route_layer.call("get_segment_count"))
		var mid_progress := float(route_layer.get("_reveal_progress"))
		print(
			"FINALE_MID active=",
			main.get("journey_finale_sequence_active"),
			" stops=",
			route_layer.call("get_stop_count"),
			" segments=",
			segment_count,
			" progress=",
			mid_progress,
			" revealed=",
			main.get("player_planet_revealed")
		)
		if not bool(main.get("journey_finale_sequence_active")):
			failures.append("finale-sequence-finished-too-early")
		if mid_progress <= 0.0 or mid_progress >= float(segment_count):
			failures.append("route-replay-not-progressive")
		if not button.disabled:
			failures.append("player-unlocked-before-finale")

		var finish_deadline := Time.get_ticks_msec() + 12000
		while (
			Time.get_ticks_msec() < finish_deadline
			and bool(main.get("journey_finale_sequence_active"))
		):
			await create_timer(0.1).timeout
		if bool(main.get("journey_finale_sequence_active")):
			failures.append("finale-sequence-timeout")
		if not bool(main.get("journey_finale_played")):
			failures.append("finale-not-marked-played")
		if not bool(main.get("player_planet_revealed")):
			failures.append("player-planet-not-revealed")
		if button.disabled:
			failures.append("player-planet-not-clickable-after-finale")
		if holder.visible == false:
			failures.append("player-map-art-hidden-after-finale")
		if prince != null:
			if float(prince.scale.x) >= 0.75:
				failures.append("prince-not-shrunk")
			elif _prince_texture_covers_point(
				prince,
				holder.get_global_rect().get_center()
			):
				print(
					"FINALE_RECTS prince=",
					prince.get_global_transform() * Rect2(Vector2.ZERO, prince.size),
					" holder=",
					holder.get_global_rect(),
					" prince_scale=",
					prince.scale
				)
				failures.append("prince-still-occluding-player")
		if int(route_layer.call("get_stop_count")) != TEST_ORDER.size() + 1:
			failures.append("route-stop-count")
		if segment_count != TEST_ORDER.size():
			failures.append("route-segment-count")
		if not is_equal_approx(float(route_layer.get("_reveal_progress")), float(segment_count)):
			failures.append("route-replay-incomplete")
		main.call("_play_final_journey_sequence")
		await process_frame
		if bool(main.get("journey_finale_sequence_active")):
			failures.append("finale-replayed-twice")
		await create_timer(0.2).timeout
		var image := root.get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png(OUTPUT_PATH)
	print("JOURNEY_FINALE_VERIFY failures=", failures)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)


func _prince_texture_covers_point(
	prince: TextureRect,
	screen_point: Vector2
) -> bool:
	var texture := prince.texture
	if texture == null:
		return false
	var image := texture.get_image()
	if image == null or image.is_empty():
		return false
	var draw_size := minf(prince.size.x, prince.size.y)
	var draw_rect := Rect2(
		Vector2(
			(prince.size.x - draw_size) * 0.5,
			(prince.size.y - draw_size) * 0.5
		),
		Vector2.ONE * draw_size
	)
	var local_point := (
		prince.get_global_transform().affine_inverse()
		* screen_point
	)
	if not draw_rect.has_point(local_point):
		return false
	var uv := (local_point - draw_rect.position) / draw_rect.size
	var pixel := Vector2i(
		clampi(int(uv.x * float(image.get_width())), 0, image.get_width() - 1),
		clampi(int(uv.y * float(image.get_height())), 0, image.get_height() - 1)
	)
	return image.get_pixelv(pixel).a > 0.1

