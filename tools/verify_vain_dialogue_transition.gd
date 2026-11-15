extends SceneTree


const OUTPUT_PATH := "res://tools/test_output/vain_dialogue_transition.png"


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
		):
			break
		await create_timer(0.1).timeout
	await create_timer(1.0).timeout
	if bool(main.get("dialogue_active")):
		main.call("_close_generated_story_dialogue", false)
	var actor := main.call("_story_node_by_kind", "vain_character") as Node3D
	var player := main.call("_find_rig_animation_player", actor) as AnimationPlayer
	var model := main.get("model_3d") as Node3D
	var camera := main.get("camera_3d") as Camera3D
	if actor == null or player == null:
		failures.append("vain-animation-player-missing")
	elif model == null or camera == null:
		failures.append("vain-camera-target-missing")
	else:
		var disturbed_quaternion := Quaternion(Vector3.UP, 1.15)
		var disturbed_camera_position := Vector3(1.4, 0.9, 3.2)
		var disturbed_camera_focus := Vector3(0.0, 0.35, 0.0)
		model.quaternion = disturbed_quaternion
		camera.position = disturbed_camera_position
		camera.look_at(disturbed_camera_focus)
		main.set("camera_focus_point", disturbed_camera_focus)
		main.set(
			"camera_distance",
			disturbed_camera_position.distance_to(disturbed_camera_focus)
		)
		var starting_scale: Vector3 = model.scale
		if player.current_animation != "dance_01_001":
			failures.append("non-dialogue-state-did-not-dance")
		main.call("_start_generated_story_dialogue", "vain")
		var timeline: Array[String] = []
		for sample in 90:
			var current := player.current_animation
			if timeline.is_empty() or timeline[-1] != current:
				timeline.append(current)
			if sample == 12:
				var image := root.get_texture().get_image()
				if image != null and not image.is_empty():
					image.save_png(OUTPUT_PATH)
			await create_timer(0.05).timeout
		var dance_index := timeline.find("dance_01_001")
		var idle_index := timeline.find("vain_idle_001")
		var reaction_index := timeline.find("look_around_001")
		if dance_index < 0:
			failures.append("dance-state-missing")
		if idle_index < 0:
			failures.append("transition-idle-missing")
		if reaction_index < 0:
			failures.append("dialogue-reaction-missing")
		if (
			dance_index >= 0
			and idle_index >= 0
			and reaction_index >= 0
			and not (dance_index < idle_index and idle_index < reaction_index)
		):
			failures.append("transition-order")
		if not is_equal_approx(player.speed_scale, 1.0):
			failures.append("dance-speed-not-restored")
		var initial_quaternion: Quaternion = main.call(
			"_get_initial_planet_orientation",
			"vain"
		)
		if absf(model.quaternion.dot(initial_quaternion)) < 0.999:
			failures.append("dialogue-did-not-use-initial-orientation")
		var initial_camera_pose: Dictionary = main.call(
			"_dialogue_initial_camera_pose"
		)
		var expected_camera_position: Vector3 = initial_camera_pose.position
		if camera.position.distance_to(expected_camera_position) > 0.02:
			failures.append("dialogue-did-not-use-initial-camera")
		var expected_scale := starting_scale * 1.85
		if model.scale.distance_to(expected_scale) > 0.01:
			failures.append("dialogue-zoom-scale-mismatch")
		main.call("_close_generated_story_dialogue", false)
		await create_timer(0.8).timeout
		if player.current_animation != "dance_01_001":
			failures.append("post-dialogue-state-did-not-resume-dance")
		if not is_equal_approx(player.speed_scale, 1.0):
			failures.append("post-dialogue-dance-speed-mismatch")
		if absf(model.quaternion.dot(disturbed_quaternion)) < 0.999:
			failures.append("dialogue-did-not-restore-orientation")
		if camera.position.distance_to(disturbed_camera_position) > 0.02:
			failures.append("dialogue-did-not-restore-camera")
		print(
			"VAIN_DIALOGUE_TRANSITION timeline=", timeline,
			" speed_scale=", player.speed_scale,
			" camera_distance=", expected_camera_position.distance_to(
				initial_camera_pose.focus
			)
		)
	print("VAIN_DIALOGUE_TRANSITION_VERIFY failures=", failures)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)

