extends SceneTree


const PATHS := [
	"res://assets/3d/player/props/长发小人.glb",
	"res://assets/3d/player/props/短发小人.glb",
]


func _initialize() -> void:
	for path in PATHS:
		print("MODEL ", path)
		var packed := load(path) as PackedScene
		if packed == null:
			print("  MISSING")
			continue
		var root := packed.instantiate()
		var mesh_count := root.find_children(
			"*",
			"MeshInstance3D",
			true,
			false
		).size()
		print("  meshes=", mesh_count)
		for item in root.find_children("*", "Skeleton3D", true, false):
			var skeleton := item as Skeleton3D
			print("  skeleton=", skeleton.name)
			for bone_index in skeleton.get_bone_count():
				var bone_name := skeleton.get_bone_name(bone_index)
				if (
					bone_name.to_lower().contains("head")
					or bone_name.to_lower().contains("neck")
					or bone_name.to_lower().contains("spine")
				):
					print("    bone=", bone_name)
		for item in root.find_children("*", "AnimationPlayer", true, false):
			var player := item as AnimationPlayer
			for library_name in player.get_animation_library_list():
				var library := player.get_animation_library(library_name)
				for clip_name in library.get_animation_list():
					var animation := library.get_animation(clip_name)
					print(
						"  animation=",
						library_name, "/", clip_name,
						" length=", animation.length,
						" tracks=", animation.get_track_count(),
						" loop=", animation.loop_mode
					)
					for track_index in mini(animation.get_track_count(), 12):
						print(
							"    track=",
							animation.track_get_path(track_index),
							" type=",
							animation.track_get_type(track_index)
						)
		root.free()
	quit()
