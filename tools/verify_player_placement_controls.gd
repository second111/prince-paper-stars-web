extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	root.add_child(main)
	if not await _wait_for_player_scene(main, 40.0):
		push_error("Player scene did not become ready.")
		quit(1)
		return
	await create_timer(0.8).timeout
	var failures: Array[String] = []
	var dock := main.get("player_place_dock") as PanelContainer
	var action_arc := main.get("player_item_action_arc") as Control
	var hint := main.get("hud_scene_hint") as Label
	var selection_ring := main.get("editor_selection_ring") as Node3D
	var pick := _find_visible_placeable(main)
	if dock == null or action_arc == null or hint == null or pick < 0:
		push_error("Placement controls did not become ready.")
		quit(1)
		return
	var screen_position := _record_screen_position(main, pick)
	main.call("_select_player_placement_object", pick, screen_position)
	main.set("player_placement_object_dragging", false)
	main.call("_update_player_item_action_arc")
	if action_arc.visible:
		failures.append("action-arc-visible-with-dock-closed")
	if selection_ring != null and selection_ring.visible:
		failures.append("selection-ring-visible-with-dock-closed")
	if hint.text.contains("摆放已打开"):
		failures.append("placement-hint-visible-with-dock-closed")

	main.call("_toggle_player_placement_dock")
	await process_frame
	if not dock.visible:
		failures.append("placement-dock-not-open")
	if not hint.text.contains("摆放已打开"):
		failures.append("placement-hint-not-updated")
	if int(main.get("selected_editable_index")) != -1:
		failures.append("selection-not-cleared-when-dock-opened")

	main.call("_select_player_placement_object", pick, screen_position)
	main.set("player_placement_object_dragging", false)
	main.call("_update_player_item_action_arc")
	if not action_arc.visible:
		failures.append("action-arc-hidden-after-object-click")
	selection_ring = main.get("editor_selection_ring") as Node3D
	if selection_ring == null or not selection_ring.visible:
		failures.append("selection-ring-hidden-after-object-click")
	await _save_viewport("player_placement_actions_open.png")

	main.call("_toggle_player_placement_dock")
	await process_frame
	main.call("_update_player_item_action_arc")
	if action_arc.visible:
		failures.append("action-arc-not-hidden-after-close")
	if selection_ring != null and selection_ring.visible:
		failures.append("selection-ring-not-hidden-after-close")
	if int(main.get("selected_editable_index")) != -1:
		failures.append("selection-not-cleared-after-close")
	if hint.text.contains("摆放已打开"):
		failures.append("placement-hint-not-restored")

	print("PLAYER_PLACEMENT_CONTROLS failures=", failures)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


func _find_visible_placeable(main: Node) -> int:
	var records: Array = main.get("editable_3d_objects")
	var camera := main.get("camera_3d") as Camera3D
	if camera == null:
		return -1
	var viewport_size := root.get_viewport().get_visible_rect().size
	for index in records.size():
		var record: Dictionary = records[index]
		if not bool(main.call("_is_player_plane_record", record)):
			continue
		var node := record.get("node") as Node3D
		if node == null or not node.visible:
			continue
		var bounds: AABB = main.call("_editable_world_bounds", node)
		if bounds.size == Vector3.ZERO or camera.is_position_behind(bounds.get_center()):
			continue
		var screen := camera.unproject_position(bounds.get_center())
		if Rect2(32.0, 180.0, viewport_size.x - 64.0, viewport_size.y - 300.0).has_point(screen):
			return index
	return -1


func _record_screen_position(main: Node, index: int) -> Vector2:
	var records: Array = main.get("editable_3d_objects")
	var camera := main.get("camera_3d") as Camera3D
	if index < 0 or index >= records.size() or camera == null:
		return Vector2.ZERO
	var node := records[index].get("node") as Node3D
	var bounds: AABB = main.call("_editable_world_bounds", node)
	return camera.unproject_position(bounds.get_center())


func _wait_for_player_scene(main: Node, timeout_seconds: float) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if (
			String(main.get("current_3d_scene")) == "player"
			and bool(main.get("generated_planet_ready").get("player", false))
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

