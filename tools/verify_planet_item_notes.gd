extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const ITEM_SCENE_SLUGS := [
	"rose",
	"king",
	"vain",
	"merchant",
	"earth",
	"pointlighter",
]


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	var requested_scene := _requested_scene_slug()
	if not await _wait_for_scene(main, requested_scene, 40.0):
		push_error("%s scene did not become ready." % requested_scene)
		quit(1)
		return
	await create_timer(0.8).timeout
	var failures: Array[String] = []
	for slug in ITEM_SCENE_SLUGS:
		var entries: Array = main.call("_planet_item_intros_for_scene", slug)
		if entries.size() != 3:
			failures.append("%s-item-count" % slug)
			continue
		for entry_value in entries:
			var entry: Dictionary = entry_value
			var text := String(entry.get("text", ""))
			if not text.begins_with("“") or not text.ends_with("”"):
				failures.append("%s-quote-format" % slug)
				break

	var glow_layer := main.get("planet_item_glow_layer") as Control
	var glows: Array = main.get("planet_item_glows")
	var note := main.get("planet_item_note_panel") as PanelContainer
	var note_label := main.get("planet_item_note_label") as Label
	if glow_layer == null or not glow_layer.visible:
		failures.append("%s-glow-layer-hidden" % requested_scene)
	if glows.size() != 3:
		failures.append("%s-glow-count" % requested_scene)
	else:
		for attempt in 20:
			var all_glows_visible := true
			for glow_value in glows:
				var glow := glow_value.get("button") as Button
				if glow == null or not glow.visible:
					all_glows_visible = false
					break
			if all_glows_visible:
				break
			await create_timer(0.1).timeout
		for glow_index in glows.size():
			var glow_value: Dictionary = glows[glow_index]
			var glow := glow_value.get("button") as Button
			var intro: Dictionary = glow_value.get("intro", {})
			if glow == null or not glow.visible:
				failures.append(
					"%s-glow-hidden-%s" % [
						requested_scene,
						String(intro.get("kind", "unknown")),
					]
				)
				break
		if requested_scene == "rose":
			var rose_positions: Array[Vector2] = []
			for glow_value in glows:
				var glow := glow_value.get("button") as Control
				if glow != null:
					rose_positions.append(glow.position + glow.size * 0.5)
			if rose_positions.size() == 3:
				var minimum_spacing := INF
				for first_index in rose_positions.size():
					for second_index in range(first_index + 1, rose_positions.size()):
						minimum_spacing = minf(
							minimum_spacing,
							rose_positions[first_index].distance_to(
								rose_positions[second_index]
							)
						)
				if minimum_spacing < 90.0:
					print(
						"ROSE_GLOW_SPACING=",
						minimum_spacing,
						" positions=",
						rose_positions,
					)
					failures.append("rose-glow-spacing")
		var first_glow := glows[0].get("button") as Button
		if first_glow == null or not first_glow.visible:
			failures.append("%s-first-glow-hidden" % requested_scene)
		else:
			var sample_origin := first_glow.position
			var max_bob_distance := 0.0
			for sample in 8:
				await create_timer(0.1).timeout
				max_bob_distance = maxf(
					max_bob_distance,
					first_glow.position.distance_to(sample_origin)
				)
			if max_bob_distance < 0.2:
				failures.append("%s-glow-not-bobbing" % requested_scene)
			await _click_control(first_glow)
			await create_timer(0.3).timeout
			if note == null or not note.visible:
				failures.append("%s-note-hidden" % requested_scene)
			else:
				var planet_rect: Rect2 = main.call(
					"_planet_visual_screen_rect"
				)
				if (
					not (note.get_theme_stylebox("panel") is StyleBoxEmpty)
					or (
						planet_rect.has_area()
						and note.get_rect().intersects(
							planet_rect.grow(8.0)
						)
					)
				):
					failures.append("%s-note-not-in-starfield" % requested_scene)
				if planet_rect.has_area():
					var note_center_y := note.position.y + note.size.y * 0.5
					var glow_center_y := (
						first_glow.position.y
						+ first_glow.size.y * 0.5
					)
					var planet_side_gap := minf(
						absf(note.position.x + note.size.x - planet_rect.position.x),
						absf(note.position.x - planet_rect.end.x)
					)
					if (
						planet_side_gap > 42.0
						or absf(note_center_y - glow_center_y) > 12.0
					):
						failures.append("%s-note-not-near-item" % requested_scene)
			if (
				note_label == null
				or not note_label.text.begins_with(
					"%s：" % String(
						(glows[0].get("intro", {}) as Dictionary).get(
							"name",
							"物品"
						)
					)
				)
				or not note_label.text.ends_with("”")
			):
				failures.append("%s-note-text" % requested_scene)
			await _save_viewport(
				"planet_item_note_%s.png" % requested_scene
			)
			main.set("story_camera_focus_active", true)
			main.call("_update_planet_item_glows", 0.016)
			if glow_layer.visible or first_glow.visible:
				failures.append("%s-glow-visible-during-camera-focus" % requested_scene)
			main.set("story_camera_focus_active", false)
			main.call("_update_planet_item_glows", 0.016)
			main.set("current_3d_scene", "player")
			main.call("_update_planet_item_glows", 0.016)
			for glow_value in glows:
				var glow := glow_value.get("button") as Control
				if glow != null and glow.visible:
					failures.append("%s-glow-leaked-into-player" % requested_scene)
					break
	print("PLANET_ITEM_NOTES failures=", failures)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


func _requested_scene_slug() -> String:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--item-scene="):
			var requested := argument.trim_prefix("--item-scene=")
			if requested in ITEM_SCENE_SLUGS:
				return requested
	return "rose"


func _click_control(control: Control) -> void:
	var click_position := (
		root.get_final_transform()
		* control.get_global_rect().get_center()
	)
	var motion := InputEventMouseMotion.new()
	motion.position = click_position
	motion.global_position = click_position
	root.push_input(motion)
	await process_frame
	var press := InputEventMouseButton.new()
	press.button_index = MOUSE_BUTTON_LEFT
	press.pressed = true
	press.position = click_position
	press.global_position = click_position
	root.push_input(press)
	await process_frame
	var release := InputEventMouseButton.new()
	release.button_index = MOUSE_BUTTON_LEFT
	release.pressed = false
	release.position = click_position
	release.global_position = click_position
	root.push_input(release)
	await process_frame


func _wait_for_scene(main: Node, slug: String, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		var generated_ready := main.get("generated_planet_ready") as Dictionary
		if (
			String(main.get("current_3d_scene")) == slug
			and (
				bool(generated_ready.get(slug, false))
				or slug in ["king", "pointlighter"]
			)
			and bool(main.get("stage_3d").visible)
		):
			return true
		await create_timer(0.15).timeout
	return false


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

