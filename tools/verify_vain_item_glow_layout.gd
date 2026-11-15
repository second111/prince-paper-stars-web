extends SceneTree


const OUTPUT_PATH := "res://tools/test_output/vain_item_glow_after.png"


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var failures: Array[String] = []
	var main: Node = load("res://main.tscn").instantiate()
	root.add_child(main)
	var deadline := Time.get_ticks_msec() + 45000
	while Time.get_ticks_msec() < deadline:
		if main.get("map_screen") != null:
			break
		await create_timer(0.1).timeout
	main.set("preview_mode_active", true)
	(main.get("cover") as Control).visible = false
	(main.get("map_screen") as Control).visible = true
	main.call("_on_planet_pressed", "爱慕虚荣的人")
	deadline = Time.get_ticks_msec() + 45000
	while Time.get_ticks_msec() < deadline:
		var stage := main.get("stage_3d") as Control
		if (
			String(main.get("current_3d_scene")) == "vain"
			and stage != null
			and stage.visible
			and (main.get("planet_item_glows") as Array).size() == 3
		):
			break
		await create_timer(0.1).timeout
	await create_timer(2.0).timeout
	if bool(main.get("dialogue_active")):
		main.call("_close_generated_story_dialogue", false)
	main.call("_restore_dialogue_camera", true)
	await process_frame
	var glows: Array = main.get("planet_item_glows")
	var planet_rect: Rect2 = main.call("_planet_visual_screen_rect")
	var outline: PackedVector2Array = main.call("_planet_item_outline_screen")
	var positions: Array[Vector2] = []
	var kinds: Array[String] = []
	if outline.size() < 3:
		failures.append("item-outline-missing")
	var outline_rect := Rect2(outline[0], Vector2.ZERO)
	for point in outline:
		outline_rect = outline_rect.expand(point)
	print(
		"VAIN_ITEM_OUTLINE points=", outline.size(),
		" rect=", outline_rect
	)
	for glow_value in glows:
		var glow := glow_value.get("button") as Control
		if glow != null:
			positions.append(glow.position + glow.size * 0.5)
			kinds.append(String(glow_value.get("kind", "")))
			var glow_center := glow.position + glow.size * 0.5
			if Geometry2D.is_point_in_polygon(glow_center, outline):
				failures.append(
					"glow-inside-item-outline:%s" % glow_value.get("kind", "")
				)
			var edge_distance := INF
			for point_index in outline.size():
				edge_distance = minf(
					edge_distance,
					glow_center.distance_to(
						Geometry2D.get_closest_point_to_segment(
							glow_center,
							outline[point_index],
							outline[(point_index + 1) % outline.size()]
						)
					)
				)
			if edge_distance > 48.0:
				failures.append(
					"glow-not-hugging-item-outline:%s" % glow_value.get("kind", "")
				)
	print(
		"VAIN_ITEM_GLOWS kinds=", kinds,
		" centers=", positions,
		" planet=", planet_rect
	)
	var benchmark_model := main.get("model_3d") as Node3D
	var original_transform := benchmark_model.transform
	var update_times: Array[float] = []
	for frame in 60:
		benchmark_model.rotate_y(0.012)
		var update_start := Time.get_ticks_usec()
		main.call("_update_planet_item_glows", 0.016)
		update_times.append(
			float(Time.get_ticks_usec() - update_start) / 1000.0
		)
		await create_timer(0.016).timeout
	benchmark_model.transform = original_transform
	main.call("_update_planet_item_glows", 0.016)
	var update_total := 0.0
	var update_max := 0.0
	for update_time in update_times:
		update_total += update_time
		update_max = maxf(update_max, update_time)
	print(
		"VAIN_ITEM_GLOW_PERF avg_ms=",
		update_total / float(update_times.size()),
		" max_ms=", update_max
	)
	if update_total / float(update_times.size()) > 8.0:
		failures.append("item-glow-update-average-too-slow")
	if update_max > 24.0:
		failures.append("item-glow-update-frame-spike")
	var note := main.get("planet_item_note_panel") as Control
	for glow_value in glows:
		main.call(
			"_on_planet_item_glow_pressed",
			glow_value.get("intro", {})
		)
		await create_timer(0.3).timeout
		if note == null or not note.visible:
			failures.append(
				"note-hidden:%s" % glow_value.get("kind", "")
			)
		elif planet_rect.has_area() and note.get_rect().intersects(
			planet_rect.grow(8.0)
		):
			failures.append(
				"note-overlaps-planet:%s" % glow_value.get("kind", "")
			)
		else:
			for other_value in glows:
				var other_glow := other_value.get("button") as Control
				if (
					other_glow != null
					and note.get_rect().intersects(
						Rect2(other_glow.position, other_glow.size).grow(12.0)
					)
				):
					failures.append(
						"note-overlaps-glow:%s" % glow_value.get("kind", "")
					)
					break
		main.call("_hide_planet_item_note")
	main.call(
		"_on_planet_item_glow_pressed",
		glows[0].get("intro", {})
	)
	await create_timer(0.3).timeout
	await process_frame
	var image := root.get_texture().get_image()
	if image != null and not image.is_empty():
		image.save_png(OUTPUT_PATH)
	print("VAIN_ITEM_GLOW_VERIFY failures=", failures)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)

