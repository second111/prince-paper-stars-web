extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const PEOPLE := {
	"player_long_hair_person": "res://assets/3d/player/props/长发小人.glb",
	"player_short_hair_person": "res://assets/3d/player/props/短发小人.glb",
	"player_prince": "res://assets/3d/characters/prince_rigged.glb",
}


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	for kind in PEOPLE:
		var packed := load(PEOPLE[kind]) as PackedScene
		var root := packed.instantiate() as Node3D
		main.call("_prepare_player_person_animations", root, kind)
		if kind == "player_prince":
			main.call("_prepare_prince_character_animations", root, "ambient_idle")
		var player := root.find_child("AnimationPlayer", true, false) as AnimationPlayer
		print(
			kind,
			" animations=", player.get_animation_list(),
			" current=", player.current_animation,
			" speed=", player.speed_scale
		)
		if not player.has_animation("walk_001"):
			push_error(kind + " is missing the retargeted walk_001 clip")
			quit(1)
			return
		main.call(
			"_apply_character_animation_choice",
			root,
			"walk_001",
			true
		)
		if (
			player.current_animation != "walk_001"
			or player.get_animation("walk_001").loop_mode
				!= Animation.LOOP_LINEAR
		):
			push_error(kind + " did not enter looping walk animation")
			quit(1)
			return
		var skeleton := root.find_child("Skeleton3D", true, false) as Skeleton3D
		if not _walk_root_motion_is_in_place(player, skeleton):
			push_error(kind + " walk_001 still contains root translation")
			quit(1)
			return
		var sit_clip := "sit_001" if kind == "player_prince" else "sit"
		main.call(
			"_apply_character_animation_choice",
			root,
			sit_clip,
			true
		)
		print(
			kind,
			" sit_current=", player.current_animation,
			" sit_loop=", player.get_animation(sit_clip).loop_mode
		)
		root.free()
	main.free()
	quit()


func _walk_root_motion_is_in_place(
	player: AnimationPlayer,
	skeleton: Skeleton3D
) -> bool:
	if skeleton == null:
		return false
	var animation := player.get_animation("walk_001")
	for track_index in animation.get_track_count():
		if animation.track_get_type(track_index) != Animation.TYPE_POSITION_3D:
			continue
		var track_path := String(animation.track_get_path(track_index))
		var bone_name := track_path.get_slice(
			":",
			track_path.get_slice_count(":") - 1
		)
		if bone_name not in ["BoneRoot", "Hip"]:
			continue
		var bone_index := skeleton.find_bone(bone_name)
		if bone_index < 0:
			return false
		var rest_position := skeleton.get_bone_rest(bone_index).origin
		for key_index in animation.track_get_key_count(track_index):
			var key_position: Vector3 = animation.track_get_key_value(
				track_index,
				key_index
			)
			if key_position.distance_to(rest_position) > 0.0001:
				return false
	return true
