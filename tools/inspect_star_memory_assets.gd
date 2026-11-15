extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const ASSET_FACTORY_SCRIPT := preload("res://scripts/player_asset_factory.gd")


func _initialize() -> void:
	var asset_count := 0
	for slug in MAIN_SCRIPT.MEMORY_ORDER:
		for asset_value in MAIN_SCRIPT.STAR_BACKPACK_PLACEABLE_ASSETS.get(slug, []):
			var asset_data := asset_value as Dictionary
			var fitted := ASSET_FACTORY_SCRIPT.instantiate_fitted(
				asset_data,
				float(asset_data.get("extent", 0.7))
			) as Node3D
			if fitted == null:
				push_error("Could not fit " + String(asset_data.get("kind", "")))
				continue
			var bounds := ASSET_FACTORY_SCRIPT.collect_bounds(
				fitted,
				Transform3D.IDENTITY
			)
			var mesh_count := fitted.find_children(
				"*",
				"MeshInstance3D",
				true,
				false
			).size()
			print(
				slug,
				" / ", String(asset_data.get("kind", "")),
				" / ", String(asset_data.get("label", "")),
				" / meshes=", mesh_count,
				" / bounds=", bounds
			)
			fitted.free()
			asset_count += 1
	print("STAR_BACKPACK_ASSET_COUNT=", asset_count)
	quit()
