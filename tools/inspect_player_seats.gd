extends SceneTree


const SEATS := {
	"chair": "res://assets/3d/generated/chair.glb",
	"bench": "res://assets/3d/player/props/长椅.glb",
	"swing": "res://assets/3d/player/props/秋千.glb",
	"throne": "res://assets/3d/king/king_throne.glb",
}


func _initialize() -> void:
	for seat_name in SEATS:
		var packed := load(SEATS[seat_name]) as PackedScene
		var root := packed.instantiate() as Node3D
		var bounds := AABB()
		var has_bounds := false
		for item in root.find_children("*", "MeshInstance3D", true, false):
			var mesh := item as MeshInstance3D
			if mesh.mesh == null:
				continue
			var mesh_bounds := Transform3D.IDENTITY
			var parent := mesh.get_parent()
			while parent != null and parent != root:
				if parent is Node3D:
					mesh_bounds = (parent as Node3D).transform * mesh_bounds
				parent = parent.get_parent()
			mesh_bounds *= mesh.transform
			var box := mesh_bounds * mesh.get_aabb()
			bounds = box if not has_bounds else bounds.merge(box)
			has_bounds = true
		print(seat_name, " bounds=", bounds, " size=", bounds.size)
		root.free()
	quit()
