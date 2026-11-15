extends SceneTree


const MAIN_SCRIPT := preload("res://scripts/main.gd")
const CHARACTERS := [
	"player_long_hair_person",
	"player_short_hair_person",
	"player_prince",
]
const SEATS := {
	"player_bench": "res://assets/3d/player/props/长椅.glb",
	"player_star_pointlighter_chair": "res://assets/3d/generated/chair.glb",
	"player_star_king_throne": "res://assets/3d/king/king_throne.glb",
	"player_swing": "res://assets/3d/player/props/秋千.glb",
}


func _initialize() -> void:
	var main := MAIN_SCRIPT.new()
	main.set("current_3d_scene", "player")
	var failures: Array[String] = []
	for seat_kind in SEATS:
		for character_kind in CHARACTERS:
			var model := Node3D.new()
			root.add_child(model)
			main.set("model_3d", model)
			var seat_asset := {
				"kind": seat_kind,
				"label": seat_kind,
				"path": SEATS[seat_kind],
				"extent": 0.72 if seat_kind != "player_bench" else 1.06,
				"yaw": 0.0,
			}
			var seat_node := main.call(
				"_add_player_asset_fitted",
				model,
				seat_asset,
				"TestSeat",
				Transform3D.IDENTITY,
				float(seat_asset.extent)
			) as Node3D
			seat_node.scale = Vector3.ONE * 0.35
			var seat_record := _make_plane_record(
				"test-seat",
				seat_kind,
				seat_node,
				0.35
			)
			var character_asset: Dictionary = main.call(
				"_player_asset_definition_for_kind",
				character_kind
			)
			var seat_offset: Vector3 = main.call(
				"_default_player_seat_offset",
				seat_node
			)
			var character_position := seat_node.transform * seat_offset
			var character_node := main.call(
				"_add_player_asset_fitted",
				model,
				character_asset,
				"TestCharacter",
				Transform3D(
					main.call(
						"_normal_surface_basis",
						Vector3.UP,
						0.0
					),
					character_position
				),
				float(character_asset.extent)
			) as Node3D
			var character_record := _make_plane_record(
				"test-character",
				character_kind,
				character_node,
				1.0
			)
			character_record["selected_animation"] = "ambient_idle"
			var records: Array[Dictionary] = [
				seat_record,
				character_record,
			]
			main.set("editable_3d_objects", records)
			main.set("selected_editable_index", 1)
			main.call("_restore_player_character_seating")
			if String(character_record.get("seat_state", "")) == "seated":
				failures.append(
					character_kind + "@" + seat_kind + ":auto-seated-without-drop"
				)
			var seat_for_sit := seat_record.duplicate()
			seat_for_sit["seat_slot_index"] = 0
			seat_for_sit["seat_slot_count"] = int(
				main.call("_player_seat_capacity", seat_kind)
			)
			main.call(
				"_sit_player_character_at_seat",
				character_record,
				seat_for_sit
			)
			var seated := (
				String(character_record.get("seat_state", "")) == "seated"
			)
			var player := character_node.find_child(
				"AnimationPlayer",
				true,
				false
			) as AnimationPlayer
			var expected_clip := (
				"sit_001"
				if character_kind == "player_prince"
				else "sit"
			)
			if not seated:
				failures.append(character_kind + "@" + seat_kind + ":not-seated")
			if player == null or player.current_animation != expected_clip:
				failures.append(
					character_kind + "@" + seat_kind + ":wrong-clip"
				)
			if player != null:
				# Keep the test fast while still exercising the real
				# animation-finished path that freezes the final seated pose.
				player.speed_scale = 5.0
				var pose_paused := await _wait_for_seat_pose_pause(
					main,
					character_record,
					player,
					2.0
				)
				if not pose_paused:
					print(
						"SEAT_PAUSE_DEBUG ",
						character_kind,
						"@",
						seat_kind,
						" pending=",
						character_record.get("seat_pose_hold_pending", false),
						" current=",
						player.current_animation,
						" speed=",
						player.get_playing_speed(),
						" position=",
						player.current_animation_position
					)
					failures.append(
						character_kind + "@" + seat_kind + ":sit-pose-not-paused"
					)
			main.call("_capture_player_character_seat_poses")
			var offsets: Dictionary = main.get("player_seat_pose_offsets")
			var key: String = String(character_kind) + "::" + String(seat_kind)
			if not offsets.has(key):
				failures.append(character_kind + "@" + seat_kind + ":no-offset")
			var standing_heights: Dictionary = main.get(
				"player_asset_height_offsets"
			)
			standing_heights[character_kind] = -0.12
			main.call(
				"_apply_player_character_seat_height",
				character_record,
				0.08
			)
			main.call("_capture_player_character_seat_poses")
			offsets = main.get("player_seat_pose_offsets")
			var adjusted_pose: Dictionary = offsets.get(key, {})
			if not is_equal_approx(
				float(adjusted_pose.get("height_offset", 0.0)),
				0.08
			):
				failures.append(
					character_kind + "@" + seat_kind + ":sit-height-not-separate"
				)
			if not is_equal_approx(
				float(standing_heights.get(character_kind, 0.0)),
				-0.12
			):
				failures.append(
					character_kind + "@" + seat_kind + ":standing-height-overwritten"
				)
			var sitting_locks: Dictionary = main.get(
				"player_sitting_height_locks"
			)
			sitting_locks[key] = true
			main.call("_on_player_place_height_changed", 0.3)
			if not is_equal_approx(
				float(character_record.get("seat_height", 0.0)),
				0.08
			):
				failures.append(
					character_kind + "@" + seat_kind + ":sit-lock-ignored"
				)
			sitting_locks.erase(key)
			var rider_before_seat_move := character_node.transform.origin
			var seat_position_before_move := seat_node.transform.origin
			var seat_move := Vector3(0.2, 0.0, -0.1)
			seat_node.position += seat_move
			seat_record["position"] = seat_node.position
			main.call("_apply_editable_3d_record", 0)
			var expected_rider_position := rider_before_seat_move + seat_move
			if character_node.transform.origin.distance_to(
				expected_rider_position
			) > 0.001:
				failures.append(
					character_kind + "@" + seat_kind + ":seat-move-not-followed"
				)
			var seated_position := character_node.transform.origin
			character_node.position += Vector3(0.1, 0.0, 0.0)
			character_record["position"] = character_node.position
			main.call(
				"_apply_player_seat_pose",
				character_record,
				seat_record
			)
			if character_node.transform.origin.distance_to(seated_position) > 0.001:
				failures.append(
					character_kind + "@" + seat_kind + ":offset-not-reused"
				)
			print(
				key,
				" seated=", seated,
				" clip=", player.current_animation if player != null else "<none>",
				" playing_speed=", player.get_playing_speed() if player != null else -1.0,
				" offset=", offsets.get(key, {})
			)
			main.call("_stand_player_character", character_record)
			if player != null and player.get_playing_speed() >= 0.0:
				failures.append(character_kind + "@" + seat_kind + ":stand-not-reversed")
			model.free()
	if not failures.is_empty():
		push_error("Seating verification failed: %s" % ", ".join(failures))
	main.free()
	quit(1 if not failures.is_empty() else 0)


func _wait_for_seat_pose_pause(
	main: Node,
	character_record: Dictionary,
	player: AnimationPlayer,
	timeout_seconds: float
) -> bool:
	var expected_clip := (
		"sit_001"
		if String(character_record.get("kind", "")) == "player_prince"
		else "sit"
	)
	var deadline := Time.get_ticks_msec() + roundi(timeout_seconds * 1000.0)
	while Time.get_ticks_msec() < deadline:
		main.call("_update_player_seated_pose_holds")
		var expected_animation := player.get_animation(expected_clip)
		var expected_hold_time := float(character_record.get(
			"seat_pose_hold_time",
			minf(0.95, expected_animation.length)
		))
		var at_end := (
			expected_animation != null
			and player.current_animation_position
				>= expected_hold_time - 0.01
		)
		if (
			not bool(character_record.get("seat_pose_hold_pending", false))
			and at_end
			and is_equal_approx(player.get_playing_speed(), 0.0)
		):
			return true
		await create_timer(0.03).timeout
	return false


func _make_plane_record(
	id: String,
	kind: String,
	node: Node3D,
	scale_value: float
) -> Dictionary:
	return {
		"id": id,
		"kind": kind,
		"label": kind,
		"node": node,
		"asset_path": "",
		"base_scale": 1.0,
		"normal": Vector3.UP,
		"initial_normal": Vector3.UP,
		"root_radius": node.position.y,
		"initial_root_radius": node.position.y,
		"scale": scale_value,
		"initial_scale": scale_value,
		"yaw": 0.0,
		"initial_yaw": 0.0,
		"surface_tilt": 0.0,
		"initial_surface_tilt": 0.0,
		"upright": true,
		"locked": false,
		"default_hidden": false,
		"initial_hidden": false,
		"layout_mode": "plane",
		"position": node.position,
		"initial_position": node.position,
		"placement_plane_normal": Vector3.UP,
		"placement_footprint": 0.18,
		"placement_height_offset": 0.0,
		"initial_placement_height_offset": 0.0,
	}
