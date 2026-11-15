extends SceneTree


func _initialize() -> void:
	var packed := load(
		"res://assets/3d/player/player_planet_base_surface_plane.glb"
	) as PackedScene
	var root := packed.instantiate() as Node3D
	_print_nodes(root, 0)
	root.free()
	quit()


func _print_nodes(node: Node, depth: int) -> void:
	var indent := "  ".repeat(depth)
	if node is Node3D:
		var node_3d := node as Node3D
		print(
			indent,
			node.name,
			" type=",
			node.get_class(),
			" visible=",
			node_3d.visible,
			" transform=",
			node_3d.transform
		)
		if node is MeshInstance3D:
			var mesh_instance := node as MeshInstance3D
			print(indent, "  mesh=", mesh_instance.mesh.get_aabb())
	else:
		print(indent, node.name, " type=", node.get_class())
	for child in node.get_children():
		_print_nodes(child, depth + 1)
