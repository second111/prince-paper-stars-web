extends SceneTree


const LIGHT_STRING_SCRIPT := preload("res://scripts/player_light_string.gd")
const OUTPUT_PATH := "res://tools/test_output/player_light_string_preview.png"


func _initialize() -> void:
	call_deferred("_render")


func _render() -> void:
	var viewport := SubViewport.new()
	viewport.size = Vector2i(640, 420)
	viewport.own_world_3d = true
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	viewport.msaa_3d = Viewport.MSAA_4X
	root.add_child(viewport)
	var environment := WorldEnvironment.new()
	var environment_resource := Environment.new()
	environment_resource.background_mode = Environment.BG_COLOR
	environment_resource.background_color = Color(0.035, 0.055, 0.12)
	environment_resource.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment_resource.ambient_light_color = Color(0.40, 0.48, 0.66)
	environment_resource.ambient_light_energy = 0.55
	environment.environment = environment_resource
	viewport.add_child(environment)
	var camera := Camera3D.new()
	camera.fov = 40.0
	viewport.add_child(camera)
	camera.look_at_from_position(
		Vector3(0.0, 1.28, 2.65),
		Vector3(0.0, 0.90, 0.0)
	)
	camera.current = true
	var string := LIGHT_STRING_SCRIPT.new() as Node3D
	viewport.add_child(string)
	string.call(
		"set_curve",
		Vector3(-0.72, 1.22, 0.0),
		Vector3(0.0, 0.73, 0.0),
		Vector3(0.72, 1.22, 0.0)
	)
	string.call("set_edit_handles_visible", false)
	for _frame in 5:
		await process_frame
	await RenderingServer.frame_post_draw
	var image := viewport.get_texture().get_image()
	image.save_png(ProjectSettings.globalize_path(OUTPUT_PATH))
	print(
		"LIGHT_STRING_PREVIEW bulbs=",
		int(string.call("get_bulb_count")),
		" lights=",
		string.find_children("*", "OmniLight3D", true, false).size()
	)
	quit()

