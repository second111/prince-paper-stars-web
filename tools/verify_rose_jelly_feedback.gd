extends SceneTree


const EXPECTED_ROSE_JELLY_KINDS := [
	"baobab",
	"volcano",
	"fence",
	"stone_path",
	"grass",
	"flower_cluster",
	"flower_patch",
	"round_tree",
	"pine_tree",
]
const EXCLUDED_ROSE_KINDS := [
	"rose_model",
	"glass_dome",
	"pedestal",
	"small_house",
]


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var failures: Array[String] = []
	var main: Node = load("res://main.tscn").instantiate()
	root.add_child(main)
	var deadline := Time.get_ticks_msec() + 45000
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "rose"
			and bool(main.get("stage_3d").visible)
		):
			break
		await create_timer(0.2).timeout
	await create_timer(0.8).timeout
	if String(main.get("current_3d_scene")) != "rose":
		failures.append("rose-scene-not-loaded")
	var records: Array = main.get("editable_3d_objects")
	var supported_kinds: Dictionary = {}
	var supported_count := 0
	for index in records.size():
		var record: Dictionary = records[index]
		var kind := String(record.get("kind", ""))
		var node := record.get("node") as Node3D
		var supports := bool(main.call("_supports_prop_feedback", kind))
		if kind in EXPECTED_ROSE_JELLY_KINDS:
			supported_kinds[kind] = true
			if not supports:
				failures.append("rose-jelly-missing:" + kind)
				continue
			var center := (main.call("_editable_world_bounds", node) as AABB).get_center()
			var screen := (main.get("camera_3d") as Camera3D).unproject_position(center)
			main.call("_start_prop_wobble", index, screen)
			await process_frame
			var states: Dictionary = main.get("prop_wobble_states")
			if not states.has(index):
				failures.append("rose-jelly-not-started:" + kind)
			else:
				supported_count += 1
		elif kind in EXCLUDED_ROSE_KINDS and supports:
			failures.append("rose-jelly-should-exclude:" + kind)
	for expected_kind in EXPECTED_ROSE_JELLY_KINDS:
		if not supported_kinds.has(expected_kind):
			failures.append("rose-jelly-kind-not-present:" + expected_kind)
	var hover_screen := Vector2(-1.0, -1.0)
	var hover_index := -1
	for index in records.size():
		var kind := String((records[index] as Dictionary).get("kind", ""))
		if kind not in EXPECTED_ROSE_JELLY_KINDS:
			continue
		var node := (records[index] as Dictionary).get("node") as Node3D
		var screen := (main.get("camera_3d") as Camera3D).unproject_position(
			(main.call("_editable_world_bounds", node) as AABB).get_center()
		)
		var picked_index := int(main.call("_pick_prop_feedback_target", screen))
		if picked_index >= 0:
			hover_screen = screen
			hover_index = picked_index
			break
	if hover_index < 0:
		failures.append("rose-jelly-hover-target-missing")
	else:
		(main.get("prop_wobble_states") as Dictionary).clear()
		main.set("hovered_feedback_index", -1)
		var motion := InputEventMouseMotion.new()
		motion.position = hover_screen
		main.call("_unhandled_input", motion)
		await process_frame
		if not (main.get("prop_wobble_states") as Dictionary).has(hover_index):
			failures.append("rose-jelly-hover-not-triggered")
	await create_timer(0.12).timeout
	var image := root.get_texture().get_image()
	if image != null and not image.is_empty():
		image.save_png("res://tools/test_output/rose_jelly_feedback.png")
	print(
		"ROSE_JELLY_VERIFY failures=",
		failures,
		" supported_records=",
		supported_count
	)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)

