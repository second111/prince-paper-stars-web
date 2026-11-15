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
	var bench := _find_player_kind(objects, "player_bench")
	if leader_index < 0 or prince_index < 0 or bench.is_empty():
		push_error("Seated glance records are missing.")
		quit(1)
		return
	var leader: Dictionary = objects[leader_index]
	var prince: Dictionary = objects[prince_index]
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
		false
	)
	main.call(
		"_sit_player_character_at_seat",
		prince,
		seat_plan.prince,
		false
	)
	var first_started := await _wait_for_glance_state(main, true, 2.0)
	var first_finished := await _wait_for_glance_state(main, false, 5.0)
	var inactive_at := Time.get_ticks_msec()
	var repeated := await _wait_for_glance_state(main, true, 4.5)
	var repeat_delay := (
		float(Time.get_ticks_msec() - inactive_at) / 1000.0
	)
	var failures: Array[String] = []
	if not first_started:
		failures.append("first-glance-start")
	if not first_finished:
		failures.append("first-glance-finish")
	if not repeated:
		failures.append("glance-repeat")
	if repeated and repeat_delay < 2.7:
		failures.append("glance-repeat-too-soon")
	print(
		"SEATED_GLANCE_LOOP first_started=",
		first_started,
		" first_finished=",
		first_finished,
		" repeated=",
		repeated,
		" repeat_delay=",
		repeat_delay,
		" failures=",
		failures
	)
	main.queue_free()
	quit(1 if not failures.is_empty() else 0)


func _wait_for_glance_state(
	main: Node,
	active: bool,
	timeout_seconds: float
) -> bool:
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		if bool(main.get("player_prince_look_active")) == active:
			return true
		await create_timer(0.03).timeout
	return false


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
