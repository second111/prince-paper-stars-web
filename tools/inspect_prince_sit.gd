extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const PRINCE_PATH := "res://assets/3d/characters/prince_rigged.glb"


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	var packed := load(PRINCE_PATH) as PackedScene
	var root := packed.instantiate() as Node3D
	main.call("_prepare_prince_character_animations", root, "ambient_idle")
	var player := root.find_child("AnimationPlayer", true, false) as AnimationPlayer
	var animation := player.get_animation("sit_001")
	print(
		"PRINCE_SIT length=", animation.length,
		" tracks=", animation.get_track_count(),
		" loop=", animation.loop_mode
	)
	var missing := 0
	for track_index in animation.get_track_count():
		var path := animation.track_get_path(track_index)
		var target := root.get_node_or_null(NodePath(path))
		if target == null:
			missing += 1
		if track_index < 40:
			print(
				"TRACK ", track_index,
				" path=", path,
				" keys=", animation.track_get_key_count(track_index),
				" exists=", target != null
			)
	print("MISSING_TRACKS ", missing)
	var skeleton := root.find_child("*Skeleton3D", true, false) as Skeleton3D
	if skeleton == null:
		var skeletons := root.find_children("*", "Skeleton3D", true, false)
		if not skeletons.is_empty():
			skeleton = skeletons[0] as Skeleton3D
	if skeleton != null:
		for bone_name in [
			"BoneRoot", "Hip", "Pelvis", "Spine01", "Head",
			"L_Thigh", "L_Calf", "R_Thigh", "R_Calf",
		]:
			var bone_index := skeleton.find_bone(bone_name)
			if bone_index >= 0:
				print(
					"BONE ", bone_name,
					" pose=", skeleton.get_bone_pose_position(bone_index),
					" rot=", skeleton.get_bone_pose_rotation(bone_index)
				)
	player.play("sit_001", 0.0)
	player.advance(animation.length * 0.5)
	if skeleton != null:
		for bone_name in [
			"BoneRoot", "Hip", "Pelvis", "Spine01", "Head",
			"L_Thigh", "L_Calf", "R_Thigh", "R_Calf",
		]:
			var bone_index := skeleton.find_bone(bone_name)
			if bone_index >= 0:
				print(
					"BONE_MID ", bone_name,
					" pose=", skeleton.get_bone_pose_position(bone_index),
					" rot=", skeleton.get_bone_pose_rotation(bone_index)
				)
	root.free()
	main.free()
	quit()
