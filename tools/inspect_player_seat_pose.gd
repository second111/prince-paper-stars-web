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
	var objects: Array = main.get("editable_3d_objects")
	var leader_index: int = main.call("_get_active_player_character_index")
	var prince_index: int = main.call("_player_prince_record_index")
	if leader_index < 0 or prince_index < 0:
		push_error("Player records are missing.")
		quit(1)
		return
	var leader: Dictionary = objects[leader_index]
	var prince: Dictionary = objects[prince_index]
	for record in [leader, prince]:
		if String(record.get("seat_state", "")) == "seated":
			main.call("_stand_player_character", record, false)
	await process_frame
	var bench := _find_player_kind(objects, "player_bench")
	if bench.is_empty():
		push_error("Bench is missing.")
		quit(1)
		return
	var seat_plan: Dictionary = main.call(
		"_player_navigation_seat_plan",
		bench,
		leader,
		prince
	)
	if seat_plan.is_empty():
		push_error("Seat plan is empty.")
		quit(1)
		return
	main.call(
		"_sit_player_character_at_seat",
		leader,
		seat_plan.leader,
		true
	)
	main.call(
		"_sit_player_character_at_seat",
		prince,
		seat_plan.prince,
		true
	)
	for second in [1, 3, 6, 8]:
		var wait_seconds := float(second - (1 if second > 1 else 0))
		await create_timer(wait_seconds).timeout
		_print_state(main, leader, prince, "T%d" % second)
		await _save_viewport("seat_pose_t%d.png" % second)
	main.call("_on_player_prince_look_action_pressed")
	await create_timer(0.45).timeout
	_print_state(main, leader, prince, "GLANCE")
	await _save_viewport("seat_pose_glance.png")
	await create_timer(2.5).timeout
	_print_state(main, leader, prince, "AFTER_GLANCE")
	main.queue_free()
	quit()


func _print_state(
	main: Node,
	leader: Dictionary,
	prince: Dictionary,
	label: String
) -> void:
	var data: Array[String] = []
	for record in [leader, prince]:
		var node := record.get("node") as Node3D
		var player := node.find_child("AnimationPlayer", true, false) as AnimationPlayer
		var skeleton: Skeleton3D
		var skeletons := node.find_children("*", "Skeleton3D", true, false)
		if not skeletons.is_empty():
			skeleton = skeletons[0] as Skeleton3D
		var head_rotation := Quaternion.IDENTITY
		if skeleton != null:
			var head_index := skeleton.find_bone("Head")
			if head_index >= 0:
				head_rotation = skeleton.get_bone_pose_rotation(head_index)
		data.append("%s clip=%s speed=%.3f pos=%.3f playing=%s head=%s" % [
			record.get("kind", ""),
			player.current_animation if player != null else "<none>",
			player.get_playing_speed() if player != null else -1.0,
			player.current_animation_position if player != null else -1.0,
			player.is_playing() if player != null else false,
			head_rotation,
		])
	print(
		"SEAT_POSE ",
		label,
		" pending=",
		leader.get("seat_pose_hold_pending", false),
		"/",
		prince.get("seat_pose_hold_pending", false),
		" look_active=",
		main.get("player_prince_look_active"),
		" | ",
		" | ".join(data)
	)


func _find_player_kind(objects: Array, kind: String) -> Dictionary:
	for value in objects:
		if (
			typeof(value) == TYPE_DICTIONARY
			and String(value.get("kind", "")) == kind
		):
			return value
	return {}


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

