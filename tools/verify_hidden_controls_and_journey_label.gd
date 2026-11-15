extends SceneTree


const EXPECTED_COMPLETION_LABEL := "星　图 · 星光已连成归途"


func _initialize() -> void:
	var main: Node = load("res://main.tscn").instantiate()
	root.add_child(main)
	await process_frame
	await create_timer(0.35).timeout

	var failures: Array[String] = []
	var skip_button := main.get("map_skip_button") as Button
	var layout_button := main.get("editor_edit_button") as Button
	var map_label := main.get("map_scene_label") as Label

	if skip_button == null or skip_button.visible:
		failures.append("map-skip-button-visible")
	if layout_button == null or layout_button.visible:
		failures.append("layout-button-visible")
	if map_label == null:
		failures.append("map-label-missing")
	else:
		main.call("_update_journey_map_label", 7, true)
		if map_label.text != EXPECTED_COMPLETION_LABEL:
			failures.append("completion-label:%s" % map_label.text)

	for button_value in main.find_children("*", "Button", true, false):
		var button := button_value as Button
		if button != null and button.visible and button.text in ["跳过", "布局"]:
			failures.append("visible-control:%s" % button.text)

	print("HIDDEN_CONTROLS_AND_JOURNEY_LABEL failures=", failures)
	main.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)
