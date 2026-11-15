extends Node


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const PEOPLE := {
	"短发": "res://assets/3d/player/props/短发小人.glb",
	"长发": "res://assets/3d/player/props/长发小人.glb",
}


func _ready() -> void:
	var main := MAIN_SCRIPT.new()
	var failures: Array[String] = []
	for label in PEOPLE:
		var root := (load(PEOPLE[label]) as PackedScene).instantiate() as Node3D
		add_child(root)
		main.call(
			"_prepare_player_person_animations",
			root,
			"player_short_hair_person" if label == "短发" else "player_long_hair_person"
		)
		var player := root.find_child("AnimationPlayer", true, false) as AnimationPlayer
		var skeleton := root.find_child("Skeleton3D", true, false) as Skeleton3D
		var walk := player.get_animation("walk_001")
		if not _share_bones_stay_neutral(walk, skeleton):
			failures.append("%s-deformation-helper-animated" % label)
		player.play("walk_001")
		player.pause()
		for sample in [0.0, walk.length * 0.25, walk.length * 0.5, walk.length * 0.75]:
			player.seek(sample, true)
			await get_tree().process_frame
			var hip := skeleton.get_bone_global_pose(skeleton.find_bone("Hip")).origin.y
			var thigh := skeleton.get_bone_global_pose(skeleton.find_bone("L_Thigh")).origin.y
			var calf := skeleton.get_bone_global_pose(skeleton.find_bone("L_Calf")).origin.y
			var foot := skeleton.get_bone_global_pose(skeleton.find_bone("L_Foot")).origin.y
			var right_thigh := skeleton.get_bone_global_pose(skeleton.find_bone("R_Thigh")).origin.y
			var right_calf := skeleton.get_bone_global_pose(skeleton.find_bone("R_Calf")).origin.y
			var right_foot := skeleton.get_bone_global_pose(skeleton.find_bone("R_Foot")).origin.y
			print(
				label,
				" t=",
				sample,
				" hip=",
				hip,
				" L=",
				[thigh, calf, foot],
				" R=",
				[right_thigh, right_calf, right_foot]
			)
			if calf >= thigh - 0.05 or foot >= hip - 0.10:
				failures.append("%s-left-fold@%.2f" % [label, sample])
			if right_calf >= right_thigh - 0.05 or right_foot >= hip - 0.10:
				failures.append("%s-right-fold@%.2f" % [label, sample])
		root.queue_free()
	main.free()
	if failures.is_empty():
		print("PLAYER_WALK_RETARGET_OK")
		get_tree().quit(0)
		return
	push_error("PLAYER_WALK_RETARGET_FAILED: " + ", ".join(failures))
	get_tree().quit(1)


func _share_bones_stay_neutral(
	animation: Animation,
	skeleton: Skeleton3D
) -> bool:
	for track_index in animation.get_track_count():
		if animation.track_get_type(track_index) != Animation.TYPE_ROTATION_3D:
			continue
		var track_path := String(animation.track_get_path(track_index))
		var bone_name := track_path.get_slice(
			":",
			track_path.get_slice_count(":") - 1
		)
		if not bone_name.contains("ShareBone"):
			continue
		var bone := skeleton.find_bone(bone_name)
		if bone < 0:
			continue
		var rest := skeleton.get_bone_rest(bone).basis.get_rotation_quaternion()
		for key_index in animation.track_get_key_count(track_index):
			var value: Quaternion = animation.track_get_key_value(
				track_index,
				key_index
			)
			if absf(value.normalized().dot(rest.normalized())) < 0.9999:
				return false
	return true
