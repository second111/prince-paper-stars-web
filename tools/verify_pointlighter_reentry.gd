extends SceneTree

var failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var main_scene: Node = load("res://main.tscn").instantiate()
	root.add_child(main_scene)
	await create_timer(1.2).timeout

	# Simulate entering the pointlighter after another planet has populated the
	# shared editor fields. The loader must reset these values before assigning
	# IDs from pointlighter_layout.json.
	var stale_objects: Array[Dictionary] = [{"id": "rose_model-37"}]
	main_scene.set("editable_3d_objects", stale_objects)
	main_scene.set("deleted_editable_ids", ["stale-38"])
	main_scene.set("editable_serial", 38)

	await main_scene.call("_load_pointlighter_model")
	await process_frame
	if int(main_scene.get("editable_serial")) < 50:
		failures.append("pointlighter-layout-ids-not-restored")

	var pointlighter_model := main_scene.get("pointlighter_model_3d") as Node3D
	if pointlighter_model == null:
		failures.append("pointlighter-model-missing")
		_finish(main_scene)
		return

	var first_node_count := _descendant_count(pointlighter_model)
	var pointlighter_objects := main_scene.get("pointlighter_editable_objects") as Array
	if pointlighter_objects.size() != 50:
		failures.append("pointlighter-object-count=%d" % pointlighter_objects.size())
	if _duplicate_ids(pointlighter_objects):
		failures.append("pointlighter-duplicate-ids")

	main_scene.call("_show_pointlighter_3d")
	await process_frame

	# A scene switch must not mutate the stored pointlighter records by sharing
	# the same Array instance with the active scene.
	var active_objects := main_scene.get("editable_3d_objects") as Array
	active_objects.clear()
	if (main_scene.get("pointlighter_editable_objects") as Array).size() != 50:
		failures.append("pointlighter-records-shared-with-active-scene")

	main_scene.call("_show_pointlighter_3d")
	await process_frame
	var second_node_count := _descendant_count(pointlighter_model)
	if second_node_count != first_node_count:
		failures.append(
			"pointlighter-reentry-node-count=%d->%d"
			% [first_node_count, second_node_count]
		)

	print(
		"POINTLIGHTER_REENTRY failures=",
		failures,
		" nodes=",
		second_node_count,
		" objects=",
		(main_scene.get("pointlighter_editable_objects") as Array).size()
	)
	_finish(main_scene)


func _descendant_count(node: Node) -> int:
	var total := 0
	for child in node.get_children():
		total += 1 + _descendant_count(child)
	return total


func _duplicate_ids(objects: Array) -> bool:
	var seen: Dictionary = {}
	for record in objects:
		if typeof(record) != TYPE_DICTIONARY:
			continue
		var id := String(record.get("id", ""))
		if id.is_empty():
			continue
		if seen.has(id):
			return true
		seen[id] = true
	return false


func _finish(main_scene: Node) -> void:
	main_scene.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)
