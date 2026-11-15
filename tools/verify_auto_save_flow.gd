extends SceneTree

var failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var manager := root.get_node_or_null("SaveManager")
	if manager == null:
		push_error("SaveManager autoload is missing.")
		quit(1)
		return

	if "--restart-check" in OS.get_cmdline_user_args():
		if not manager.has_any_save():
			failures.append("restart-save-missing")
		var persisted_slots: Array = manager.list_slots()
		if persisted_slots.is_empty() or not bool(persisted_slots[0].get("valid", false)):
			failures.append("restart-slot-invalid")
		print("AUTO_SAVE_RESTART failures=", failures, " slots=", persisted_slots)
		quit(0 if failures.is_empty() else 1)
		return

	manager.start_new_game()
	manager.resume_target = ""
	var config := ConfigFile.new()
	config.set_value("planets", "玫瑰", true)
	config.set_value("planets", "国王", true)
	if config.save("user://stellarmap.cfg") != OK:
		failures.append("seed-stellarmap")
	var memory_config := ConfigFile.new()
	memory_config.set_value("memories", "rose", "collected")
	if memory_config.save("user://star_memories.cfg") != OK:
		failures.append("seed-memories")
	var story_config := ConfigFile.new()
	story_config.set_value("story", "rose", "complete")
	if story_config.save("user://planet_story.cfg") != OK:
		failures.append("seed-story")

	if not manager.auto_save({
		"awake_count": 2,
		"memory_count": 1,
		"chapter": "星图探索",
	}):
		failures.append("auto-save-write")
	var slots: Array = manager.list_slots()
	if slots.is_empty() or not bool(slots[0].get("valid", false)):
		failures.append("slot-valid")
	var meta: Dictionary = slots[0].get("meta", {})
	if int(meta.get("awake_count", -1)) != 2:
		failures.append("slot-metadata")

	config.set_value("planets", "玫瑰", false)
	config.save("user://stellarmap.cfg")
	var load_result: Dictionary = manager.load_slot(1)
	if not bool(load_result.get("ok", false)):
		failures.append("load-result")
	if String(manager.resume_target) != "map":
		failures.append("load-target-map")
	var restored := ConfigFile.new()
	if restored.load("user://stellarmap.cfg") != OK:
		failures.append("restored-file")
	elif not bool(restored.get_value("planets", "玫瑰", false)):
		failures.append("restored-planets")

	var previous_active := int(manager.active_slot)
	var new_slot: int = int(manager.start_new_game())
	if previous_active == new_slot:
		failures.append("new-game-should-use-empty-slot")
	if manager.active_slot_has_save():
		failures.append("new-game-active-not-cleared")
	if String(manager.resume_target) != "new_game":
		failures.append("new-game-target")
	var old_slots: Array = manager.list_slots()
	if not bool(old_slots[0].get("valid", false)):
		failures.append("new-game-preserved-old-slot")
	manager.resume_target = ""

	var main_scene: Node = load("res://main.tscn").instantiate()
	root.add_child(main_scene)
	await create_timer(1.2).timeout
	await process_frame
	var load_button := main_scene.get("cover_load_button") as Button
	var new_game_button := main_scene.get("cover_new_game_button") as Button
	var overlay := main_scene.get("save_slot_overlay") as Control
	var slot_buttons: Array = main_scene.get("save_slot_buttons")
	if load_button == null:
		failures.append("cover-load-button")
	elif load_button.text != "读取进度":
		failures.append("cover-load-label")
	elif load_button.disabled:
		failures.append("cover-load-disabled-with-save")
	if new_game_button == null or new_game_button.text != "新游戏":
		failures.append("cover-new-game-label")
	if "--capture" in OS.get_cmdline_user_args():
		await create_timer(0.2).timeout
		var cover_image := root.get_texture().get_image()
		if cover_image != null and not cover_image.is_empty():
			cover_image.save_png("res://tools/test_output/auto_save_cover.png")
	main_scene.call("_open_load_slot_picker")
	if overlay == null or not overlay.visible:
		failures.append("slot-picker-open")
	if slot_buttons.size() != 3:
		failures.append("slot-picker-count")
	if "--capture" in OS.get_cmdline_user_args():
		await create_timer(0.35).timeout
		await process_frame
		var image := root.get_texture().get_image()
		if image != null and not image.is_empty():
			image.save_png("res://tools/test_output/auto_save_slot_picker.png")
	main_scene.call("_close_load_slot_picker")
	main_scene.call("_open_new_game_confirmation")
	var confirm_overlay := main_scene.get("new_game_confirm_overlay") as Control
	if confirm_overlay == null or not confirm_overlay.visible:
		failures.append("new-game-confirmation-open")
	if "--capture" in OS.get_cmdline_user_args():
		await create_timer(0.35).timeout
		await process_frame
		var confirm_image := root.get_texture().get_image()
		if confirm_image != null and not confirm_image.is_empty():
			confirm_image.save_png("res://tools/test_output/auto_save_new_game_confirm.png")
	main_scene.call("_close_new_game_confirmation")
	main_scene.call("_show_loaded_starmap")
	if not (main_scene.get("map_screen") as Control).visible:
		failures.append("loaded-starmap-visible")
	if (main_scene.get("cover") as Control).visible:
		failures.append("loaded-cover-hidden")

	print(
		"AUTO_SAVE_VERIFY failures=",
		failures,
		" active_slot=",
		manager.active_slot,
		" slots=",
		manager.list_slots()
	)
	main_scene.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)

