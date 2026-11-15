extends SceneTree


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var failures: Array[String] = []
	var main: Node = load("res://main.tscn").instantiate()
	root.add_child(main)
	var deadline := Time.get_ticks_msec() + 30000
	while Time.get_ticks_msec() < deadline:
		if main.get("ui_layout_editor") != null:
			break
		await create_timer(0.1).timeout
	await process_frame
	var layout_editor: Node = main.get("ui_layout_editor")
	var interface_button := layout_editor.get("_editor_button") as Button
	var text_button := main.get("dialogue_text_edit_button") as Button
	if interface_button != null and interface_button.visible:
		failures.append("interface-adjustment-button-visible")
	if text_button != null and text_button.visible:
		failures.append("dialogue-text-adjustment-button-visible")
	layout_editor.call("set_context_available", true, "map")
	layout_editor.call("set_edit_active", true)
	await process_frame
	if bool(layout_editor.get("edit_active")):
		failures.append("interface-adjustment-still-open")
	if interface_button != null and interface_button.visible:
		failures.append("interface-adjustment-button-reappeared")
	for button_value in main.find_children("*", "Button", true, false):
		var button := button_value as Button
		if button == null or not button.visible:
			continue
		if button.text in ["界面", "调字"]:
			failures.append("adjustment-button-visible:%s" % button.text)
	print("UI_ADJUSTMENT_BUTTONS_VERIFY failures=", failures)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)
