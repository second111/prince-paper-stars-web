extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const ASSET_FACTORY_SCRIPT := preload("res://scripts/player_asset_factory.gd")
const THUMBNAIL_RENDERER_SCRIPT := preload(
	"res://scripts/player_thumbnail_renderer.gd"
)
const OUTPUT_DIR := "res://tools/test_output/star_memory_thumbnails"


func _initialize() -> void:
	call_deferred("_render_all")


func _render_all() -> void:
	DirAccess.make_dir_recursive_absolute(
		ProjectSettings.globalize_path(OUTPUT_DIR)
	)
	var renderer := THUMBNAIL_RENDERER_SCRIPT.new()
	root.add_child(renderer)
	await process_frame
	for slug in MAIN_SCRIPT.MEMORY_ORDER:
		for asset_value in MAIN_SCRIPT.STAR_BACKPACK_PLACEABLE_ASSETS.get(slug, []):
			var asset_data := asset_value as Dictionary
			var cache_key := ASSET_FACTORY_SCRIPT.cache_signature(asset_data)
			var texture := await renderer.render_preview(
				asset_data,
				cache_key
			)
			if texture == null:
				push_error("Thumbnail render failed: " + cache_key)
				continue
			var image := texture.get_image()
			var output_path := OUTPUT_DIR.path_join(cache_key + ".png")
			var error := image.save_png(
				ProjectSettings.globalize_path(output_path)
			)
			print("THUMBNAIL=", output_path, " error=", error)
	quit()

