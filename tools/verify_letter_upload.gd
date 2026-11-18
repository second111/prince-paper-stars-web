extends SceneTree

const KEEPSAKE_FLOW := preload("res://scripts/player_keepsake_flow.gd")


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var flow = KEEPSAKE_FLOW.new()
	root.add_child(flow)
	var image := Image.load_from_file(
		ProjectSettings.globalize_path("res://assets/planets/player-awake.png")
	)
	if image == null or image.is_empty():
		push_error("Test image could not be loaded")
		quit(1)
		return
	var share_url := String(await flow.call("_upload_letter_image", image))
	print("LETTER_UPLOAD url=", share_url)
	flow.queue_free()
	quit(0 if share_url.begins_with("https://tmpfiles.org/") else 1)
