extends SceneTree

var failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var main_scene: Node = load("res://main.tscn").instantiate()
	root.add_child(main_scene)
	await create_timer(1.2).timeout

	var stale_objects: Array[Dictionary] = [{"id": "rose_model-37"}]
	main_scene.set("editable_3d_objects", stale_objects)
	main_scene.set("deleted_editable_ids", ["stale-38"])
	main_scene.set("editable_serial", 38)
	main_scene.set("current_3d_scene", "king")

	await main_scene.call("_load_king_model")
	await process_frame
	var king_model := main_scene.get("king_model_3d") as Node3D
	if king_model == null:
		failures.append("king-model-missing")
		_finish(main_scene)
		return

	var king_objects := main_scene.get("king_editable_objects") as Array
	var first_node_count := _descendant_count(king_model)
	var rendered_names := _rendered_editable_names(king_model)
	var rendered_objects := rendered_names.size()
	if rendered_objects != king_objects.size():
		failures.append(
			"king-rendered-objects=%d records=%d"
			% [rendered_objects, king_objects.size()]
		)
	if _duplicate_ids(king_objects):
		failures.append("king-duplicate-ids")

	main_scene.call("_show_king_3d")
	await process_frame
	var active_objects := main_scene.get("editable_3d_objects") as Array
	active_objects.clear()
	if (main_scene.get("king_editable_objects") as Array).size() != king_objects.size():
		failures.append("king-records-shared-with-active-scene")

	main_scene.call("_show_king_3d")
	await process_frame
	var second_node_count := _descendant_count(king_model)
	if second_node_count != first_node_count:
		failures.append(
			"king-reentry-node-count=%d->%d"
			% [first_node_count, second_node_count]
		)

	print(
		"KING_REENTRY failures=",
		failures,
		" nodes=",
		second_node_count,
		" rendered_objects=",
		rendered_objects,
		" names=",
		rendered_names,
		" records=",
		king_objects.size()
	)
	_finish(main_scene)


func _rendered_editable_names(king_model: Node3D) -> Array[String]:
	var names: Array[String] = []
	for child in king_model.get_children():
		if String(child.name) in ["KingPlanetBase", "KingGoldOrbitRing", "SurfaceFireflies"]:
			continue
		names.append(String(child.name))
	return names


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
