extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const PRINCE_PATH := "res://assets/3d/characters/prince_rigged.glb"
const PRINCE_SOURCES := [
	"res://assets/3d/characters/prince_rigged.glb",
	"res://assets/3d/characters/prince_walk_rigged.glb",
	"res://assets/3d/characters/prince_sit_rigged.glb",
	"res://assets/3d/characters/prince_reactions_rigged.glb",
]
const EXPECTED_ACTIONS := [
	"walk_001",
	"sit_001",
	"look_around_001",
	"afraid_001",
	"clap_001",
	"subtle_idle_001",
]


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	for source_path in PRINCE_SOURCES:
		var source_root := (load(source_path) as PackedScene).instantiate()
		var source_player := source_root.find_child(
			"AnimationPlayer",
			true,
			false
		) as AnimationPlayer
		print(source_path, " animations=", source_player.get_animation_list())
		source_root.free()
	var packed := load(PRINCE_PATH) as PackedScene
	var root := packed.instantiate() as Node3D
	main.call("_prepare_prince_character_animations", root, "ambient_idle")
	var player := root.find_child("AnimationPlayer", true, false) as AnimationPlayer
	var failures: Array[String] = []
	for action in EXPECTED_ACTIONS:
		if not player.has_animation(action):
			failures.append(action)
	print("PLAYER_PRINCE animations=", player.get_animation_list())
	print(
		"PLAYER_PRINCE current=",
		player.current_animation,
		" speed=",
		player.speed_scale
	)
	if not failures.is_empty():
		push_error("Missing Prince actions: %s" % ", ".join(failures))
	var animation_row := HBoxContainer.new()
	var animation_select := OptionButton.new()
	animation_row.add_child(animation_select)
	main.set("editor_character_animation_row", animation_row)
	main.set("editor_character_animation_select", animation_select)
	var record := {
		"node": root,
		"kind": "player_prince",
		"selected_animation": "ambient_idle",
	}
	main.call("_sync_character_animation_controls", record)
	var menu_actions: Array[String] = []
	for item_index in animation_select.item_count:
		menu_actions.append(String(
			animation_select.get_item_metadata(item_index)
		))
	print("PLAYER_PRINCE menu=", menu_actions)
	for action in ["ambient_idle", "walk_001", "sit_001", "look_around_001", "afraid_001", "clap_001"]:
		if action not in menu_actions:
			failures.append("menu:" + action)
	animation_row.free()
	root.free()
	main.free()
	quit(1 if not failures.is_empty() else 0)
