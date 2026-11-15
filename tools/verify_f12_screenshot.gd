extends SceneTree


const SCREENSHOT_DIRECTORY := "C:/Users/ctyb/Desktop/截图"
const SCREENSHOT_PREFIX := "小王子截图_"


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var previous_files := _screenshot_files()
	var main := (load("res://main.tscn") as PackedScene).instantiate()
	root.add_child(main)
	await process_frame
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
	else:
		await process_frame

	var screenshot_event := InputEventKey.new()
	screenshot_event.keycode = KEY_F12
	screenshot_event.physical_keycode = KEY_F12
	screenshot_event.pressed = true
	root.push_input(screenshot_event)
	await process_frame

	var new_files: Array[String] = []
	for file_name in _screenshot_files():
		if not previous_files.has(file_name):
			new_files.append(file_name)
	if new_files.size() != 1:
		push_error(
			"F12 screenshot count mismatch: expected 1, got %d"
			% new_files.size()
		)
		main.queue_free()
		quit(1)
		return

	var file_path := SCREENSHOT_DIRECTORY.path_join(new_files[0])
	var image := Image.load_from_file(file_path)
	if image == null or image.is_empty():
		push_error("F12 screenshot is not a valid image: " + file_path)
		main.queue_free()
		quit(1)
		return
	if image.get_width() <= 0 or image.get_height() <= 0:
		push_error("F12 screenshot has invalid dimensions: " + file_path)
		main.queue_free()
		quit(1)
		return

	print(
		"F12_SCREENSHOT_OK path=",
		file_path,
		" size=",
		image.get_width(),
		"x",
		image.get_height()
	)
	DirAccess.remove_absolute(file_path)
	main.queue_free()
	quit(0)


func _screenshot_files() -> Array[String]:
	var files: Array[String] = []
	var directory := DirAccess.open(SCREENSHOT_DIRECTORY)
	if directory == null:
		return files
	directory.list_dir_begin()
	var file_name := directory.get_next()
	while not file_name.is_empty():
		if (
			not directory.current_is_dir()
			and file_name.begins_with(SCREENSHOT_PREFIX)
			and file_name.ends_with(".png")
		):
			files.append(file_name)
		file_name = directory.get_next()
	directory.list_dir_end()
	return files
