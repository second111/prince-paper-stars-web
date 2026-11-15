extends SceneTree


const TREE_KINDS := ["round_tree", "pine_tree"]


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var failures: Array[String] = []
	var main: Node = load("res://main.tscn").instantiate()
	root.add_child(main)
	var deadline := Time.get_ticks_msec() + 45000
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "merchant"
			and bool(main.get("stage_3d").visible)
		):
			break
		await create_timer(0.2).timeout
	await create_timer(0.8).timeout
	if String(main.get("current_3d_scene")) != "merchant":
		failures.append("merchant-scene-not-loaded")
	var records: Array = main.get("editable_3d_objects")
	var tree_count := 0
	var hover_screen := Vector2(-1.0, -1.0)
	var hover_index := -1
	for index in records.size():
		var record: Dictionary = records[index]
		var kind := String(record.get("kind", ""))
		var node := record.get("node") as Node3D
		var supports := bool(main.call("_supports_prop_feedback", kind))
		if kind in TREE_KINDS:
			tree_count += 1
			if not supports:
				failures.append("merchant-tree-jelly-missing:" + kind)
				continue
			var center := (main.call("_editable_world_bounds", node) as AABB).get_center()
			var screen := (main.get("camera_3d") as Camera3D).unproject_position(center)
			main.call("_start_prop_wobble", index, screen)
			await process_frame
			if not (main.get("prop_wobble_states") as Dictionary).has(index):
				failures.append("merchant-tree-jelly-not-started:" + kind)
			if hover_index < 0:
				var picked_index := int(main.call("_pick_prop_feedback_target", screen))
				if picked_index >= 0:
					hover_screen = screen
					hover_index = picked_index
		elif kind == "grass" and supports:
			failures.append("merchant-grass-should-not-wobble")
	if tree_count == 0:
		failures.append("merchant-trees-missing")
	if hover_index < 0:
		failures.append("merchant-tree-hover-target-missing")
	else:
		(main.get("prop_wobble_states") as Dictionary).clear()
		main.set("hovered_feedback_index", -1)
		var motion := InputEventMouseMotion.new()
		motion.position = hover_screen
		main.call("_unhandled_input", motion)
		await process_frame
		if not (main.get("prop_wobble_states") as Dictionary).has(hover_index):
			failures.append("merchant-tree-hover-not-triggered")
	await create_timer(0.12).timeout
	var image := root.get_texture().get_image()
	if image != null and not image.is_empty():
		image.save_png("res://tools/test_output/merchant_tree_jelly_feedback.png")
	print(
		"MERCHANT_TREE_JELLY_VERIFY failures=",
		failures,
		" tree_count=",
		tree_count
	)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)

