extends Node

const PREVIEW_SIZE := Vector2i(256, 176)
const AVATAR_PREVIEW_SIZE := Vector2i(512, 512)
const THUMBNAIL_CACHE_DIR := "user://player_thumbnails_v3"
const ASSET_FACTORY_SCRIPT := preload("res://scripts/player_asset_factory.gd")

var _viewport: SubViewport
var _stage: Node3D
var _camera: Camera3D
var _preview_root: Node3D
var _world_environment: WorldEnvironment
var _key_light: DirectionalLight3D
var _fill_light: DirectionalLight3D
var _avatar_front_light: OmniLight3D


func _ready() -> void:
	_ensure_stage()
	DirAccess.make_dir_recursive_absolute(
		ProjectSettings.globalize_path(THUMBNAIL_CACHE_DIR)
	)


func render_preview(asset_data: Dictionary, cache_key: String) -> Texture2D:
	# Keep both cache-hit and cache-miss paths asynchronous so callers can
	# reliably await this method and the generation queue never stalls.
	await get_tree().process_frame
	if _viewport == null:
		_ensure_stage()
	if _viewport == null:
		return null
	var cached_path := THUMBNAIL_CACHE_DIR.path_join(cache_key + ".png")
	if FileAccess.file_exists(cached_path):
		var cached_image := Image.load_from_file(cached_path)
		if cached_image != null and not cached_image.is_empty():
			return ImageTexture.create_from_image(cached_image)

	var model := ASSET_FACTORY_SCRIPT.instantiate_fitted(
		asset_data,
		float(asset_data.get("extent", 0.7))
	) as Node3D
	if model == null:
		return null
	var bounds := _collect_bounds(model, Transform3D.IDENTITY)
	if bounds.size == Vector3.ZERO:
		model.free()
		return null
	_preview_root.add_child(model)
	var largest_extent := maxf(bounds.size.x, maxf(bounds.size.y, bounds.size.z))
	var fit_scale := 1.78 / maxf(largest_extent, 0.0001)
	model.scale = Vector3.ONE * fit_scale
	model.position = -bounds.get_center() * fit_scale

	_camera.position = Vector3(2.45, 1.72, 3.22)
	_camera.look_at(Vector3.ZERO, Vector3.UP)
	_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	for _frame in 4:
		await get_tree().process_frame
	await RenderingServer.frame_post_draw
	var image := _viewport.get_texture().get_image()
	_preview_root.remove_child(model)
	model.queue_free()
	await get_tree().process_frame
	if image == null or image.is_empty():
		return null
	image.save_png(cached_path)
	return ImageTexture.create_from_image(image)


func render_avatar_preview(
	asset_data: Dictionary,
	cache_key: String
) -> Texture2D:
	await get_tree().process_frame
	if _viewport == null:
		_ensure_stage()
	if _viewport == null:
		return null
	_set_avatar_lighting(true)
	var cached_path := THUMBNAIL_CACHE_DIR.path_join(cache_key + ".png")
	if FileAccess.file_exists(cached_path):
		var cached_image := Image.load_from_file(cached_path)
		if cached_image != null and not cached_image.is_empty():
			return ImageTexture.create_from_image(cached_image)

	var model := ASSET_FACTORY_SCRIPT.instantiate_fitted(
		asset_data,
		float(asset_data.get("extent", 0.7))
	) as Node3D
	if model == null:
		return null
	var bounds := _collect_bounds(model, Transform3D.IDENTITY)
	if bounds.size == Vector3.ZERO:
		model.free()
		return null
	_preview_root.add_child(model)
	var largest_extent := maxf(bounds.size.x, maxf(bounds.size.y, bounds.size.z))
	var fit_scale := 1.78 / maxf(largest_extent, 0.0001)
	model.scale = Vector3.ONE * fit_scale
	model.position = -bounds.get_center() * fit_scale
	# These two rigs face along local +X. Turn them toward the portrait camera
	# so the card reads as a front-facing bust rather than a side profile.
	model.rotation_degrees.y = -90.0

	# The source rigs start in their bind pose. Apply the authored idle motion
	# before capturing so the choice card never shows outstretched T-pose arms.
	var animation_player := model.find_child(
		"AnimationPlayer",
		true,
		false
	) as AnimationPlayer
	if animation_player != null:
		var idle_clip := ""
		for candidate in ["gentle_look_around", "look_around", "idle_001"]:
			if animation_player.has_animation(candidate):
				idle_clip = candidate
				break
		if not idle_clip.is_empty():
			var animation := animation_player.get_animation(idle_clip)
			animation_player.play(idle_clip, 0.0)
			animation_player.seek(
				clampf(animation.length * 0.06, 0.0, animation.length),
				true
			)

	_viewport.size = AVATAR_PREVIEW_SIZE
	_camera.fov = 30.0
	_camera.position = Vector3(0.0, 0.44, 1.85)
	_camera.look_at(Vector3(0.0, 0.44, 0.0), Vector3.UP)
	_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	for _frame in 5:
		await get_tree().process_frame
	await RenderingServer.frame_post_draw
	var image := _viewport.get_texture().get_image()
	_preview_root.remove_child(model)
	model.queue_free()
	_viewport.size = PREVIEW_SIZE
	await get_tree().process_frame
	if image == null or image.is_empty():
		return null
	image.save_png(cached_path)
	return ImageTexture.create_from_image(image)


func _set_avatar_lighting(enabled: bool) -> void:
	if _world_environment == null or _world_environment.environment == null:
		return
	var environment := _world_environment.environment
	if enabled:
		# A high ambient fill and a nearly frontal key keep faceted low-poly
		# normals from turning into hard, high-contrast light folds.
		environment.ambient_light_color = Color(0.82, 0.80, 0.75)
		environment.ambient_light_energy = 1.46
		environment.tonemap_exposure = 1.04
		if _key_light != null:
			_key_light.rotation_degrees = Vector3(-18.0, -10.0, 0.0)
			_key_light.light_color = Color(1.0, 0.94, 0.84)
			_key_light.light_energy = 0.72
			_key_light.shadow_enabled = false
		if _fill_light != null:
			_fill_light.rotation_degrees = Vector3(-8.0, 158.0, 0.0)
			_fill_light.light_color = Color(0.72, 0.80, 0.90)
			_fill_light.light_energy = 0.44
			_fill_light.shadow_enabled = false
		if _avatar_front_light != null:
			_avatar_front_light.visible = true
			_avatar_front_light.position = Vector3(0.0, 0.62, 1.08)
			_avatar_front_light.light_color = Color(1.0, 0.91, 0.78)
			_avatar_front_light.light_energy = 0.56
			_avatar_front_light.omni_range = 3.2
			_avatar_front_light.shadow_enabled = false
	else:
		environment.ambient_light_color = Color(0.72, 0.77, 0.78)
		environment.ambient_light_energy = 0.85
		environment.tonemap_exposure = 1.02
		if _avatar_front_light != null:
			_avatar_front_light.visible = false


func _ensure_stage() -> void:
	if _viewport != null:
		return
	_viewport = SubViewport.new()
	_viewport.name = "PlayerThumbnailViewport"
	_viewport.size = PREVIEW_SIZE
	_viewport.transparent_bg = true
	_viewport.own_world_3d = true
	_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	_viewport.msaa_3d = Viewport.MSAA_4X
	_viewport.use_hdr_2d = true
	add_child(_viewport)

	_stage = Node3D.new()
	_stage.name = "ThumbnailStage"
	_viewport.add_child(_stage)
	_preview_root = Node3D.new()
	_preview_root.name = "PreviewModel"
	_stage.add_child(_preview_root)

	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.0, 0.0, 0.0, 0.0)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.72, 0.77, 0.78)
	environment.ambient_light_energy = 0.85
	environment.tonemap_mode = Environment.TONE_MAPPER_ACES
	environment.tonemap_exposure = 1.02
	world_environment.environment = environment
	_stage.add_child(world_environment)
	_world_environment = world_environment

	var key_light := DirectionalLight3D.new()
	key_light.rotation_degrees = Vector3(-46.0, -36.0, 0.0)
	key_light.light_color = Color(1.0, 0.89, 0.72)
	key_light.light_energy = 1.65
	_stage.add_child(key_light)
	_key_light = key_light
	var fill_light := DirectionalLight3D.new()
	fill_light.rotation_degrees = Vector3(-12.0, 145.0, 0.0)
	fill_light.light_color = Color(0.58, 0.76, 0.88)
	fill_light.light_energy = 0.78
	_stage.add_child(fill_light)
	_fill_light = fill_light
	_avatar_front_light = OmniLight3D.new()
	_avatar_front_light.visible = false
	_avatar_front_light.shadow_enabled = false
	_avatar_front_light.omni_attenuation = 0.42
	_stage.add_child(_avatar_front_light)

	_camera = Camera3D.new()
	_camera.fov = 30.0
	_camera.near = 0.03
	_camera.far = 30.0
	_camera.current = true
	_stage.add_child(_camera)


func _collect_bounds(node: Node, relative_transform: Transform3D) -> AABB:
	var bounds := AABB()
	var has_bounds := false
	if node is MeshInstance3D:
		var mesh_instance := node as MeshInstance3D
		if mesh_instance.mesh != null:
			bounds = relative_transform * mesh_instance.get_aabb()
			has_bounds = true
	for child in node.get_children():
		if not child is Node3D:
			continue
		var child_bounds := _collect_bounds(
			child,
			relative_transform * (child as Node3D).transform
		)
		if child_bounds.size == Vector3.ZERO:
			continue
		bounds = child_bounds if not has_bounds else bounds.merge(child_bounds)
		has_bounds = true
	return bounds
