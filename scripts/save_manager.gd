extends Node

const SLOT_COUNT := 3
const SAVE_ROOT := "user://autosaves"
const ACTIVE_CONFIG_PATH := "user://autosaves/active.cfg"
const META_FILE := "meta.json"
const SAVE_SCHEMA_VERSION := 1
const PLAYER_FRESH_START_PATH := "user://player_fresh_start.cfg"
const ACTIVE_STATE_FILES := [
	"stellarmap.cfg",
	"planet_story.cfg",
	"star_memories.cfg",
	"journey.cfg",
	"onboarding_state.cfg",
	"player_layout.json",
]

var active_slot := 1
var resume_target := ""


func _ready() -> void:
	DirAccess.make_dir_recursive_absolute(_global_path(SAVE_ROOT))
	_load_active_slot()


func list_slots() -> Array[Dictionary]:
	var slots: Array[Dictionary] = []
	for slot in range(1, SLOT_COUNT + 1):
		var meta := get_slot_meta(slot)
		slots.append({
			"slot": slot,
			"exists": not meta.is_empty(),
			"valid": _slot_has_state_files(slot),
			"meta": meta,
		})
	return slots


func get_slot_meta(slot: int) -> Dictionary:
	if slot < 1 or slot > SLOT_COUNT:
		return {}
	var meta_path := _slot_path(slot).path_join(META_FILE)
	if not FileAccess.file_exists(meta_path):
		return {}
	var parsed = JSON.parse_string(FileAccess.get_file_as_string(meta_path))
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("Auto-save metadata could not be parsed in slot %d." % slot)
		return {}
	var meta: Dictionary = parsed
	if int(meta.get("schema", 0)) != SAVE_SCHEMA_VERSION:
		return {}
	return meta


func has_any_save() -> bool:
	for slot in range(1, SLOT_COUNT + 1):
		if _slot_has_state_files(slot):
			return true
	return false


func active_slot_has_save() -> bool:
	return _slot_has_state_files(active_slot)


func auto_save(summary: Dictionary) -> bool:
	var meta := summary.duplicate(true)
	meta["schema"] = SAVE_SCHEMA_VERSION
	meta["slot"] = active_slot
	meta["saved_at"] = Time.get_unix_time_from_system()
	meta["saved_at_text"] = _now_text()
	var saved := _write_slot(active_slot, meta)
	if not saved:
		push_warning("Automatic save failed for slot %d." % active_slot)
	return saved


func load_slot(slot: int) -> Dictionary:
	var meta := get_slot_meta(slot)
	if meta.is_empty() or not _slot_has_state_files(slot):
		return {"ok": false, "error": "这个档位没有可读取的进度。"}
	_clear_active_state_files()
	_clear_player_fresh_start()
	for file_name in ACTIVE_STATE_FILES:
		var source_path := _slot_path(slot).path_join(file_name)
		if not FileAccess.file_exists(source_path):
			continue
		var target_path := "user://%s" % file_name
		var copy_error := DirAccess.copy_absolute(
			_global_path(source_path),
			_global_path(target_path)
		)
		if copy_error != OK:
			return {
				"ok": false,
				"error": "读取自动存档 %d 失败：%s" % [slot, error_string(copy_error)],
			}
	active_slot = slot
	_write_active_slot()
	resume_target = "map"
	return {"ok": true, "slot": slot}


func preview_new_game_slot() -> int:
	return _choose_new_game_slot()


func new_game_will_overwrite(slot: int) -> bool:
	return not get_slot_meta(slot).is_empty()


func start_new_game() -> int:
	var target_slot := _choose_new_game_slot()
	active_slot = target_slot
	_write_active_slot()
	_clear_active_state_files()
	_write_player_fresh_start()
	_remove_tree(_global_path(_slot_path(target_slot)))
	resume_target = "new_game"
	return target_slot


func consume_player_fresh_start() -> bool:
	if not FileAccess.file_exists(PLAYER_FRESH_START_PATH):
		return false
	_clear_player_fresh_start()
	return true


func consume_resume_target() -> String:
	var target := resume_target
	resume_target = ""
	return target


func _choose_new_game_slot() -> int:
	if not _slot_has_state_files(active_slot):
		return active_slot
	for slot in range(1, SLOT_COUNT + 1):
		if get_slot_meta(slot).is_empty():
			return slot
	var oldest_slot := 1
	var oldest_time := INF
	for slot in range(1, SLOT_COUNT + 1):
		var saved_at := float(get_slot_meta(slot).get("saved_at", 0.0))
		if saved_at < oldest_time:
			oldest_time = saved_at
			oldest_slot = slot
	return oldest_slot


func _write_slot(slot: int, meta: Dictionary) -> bool:
	DirAccess.make_dir_recursive_absolute(_global_path(SAVE_ROOT))
	var slot_path := _slot_path(slot)
	var temp_path := "%s.tmp" % slot_path
	var backup_path := "%s.backup" % slot_path
	var temp_global := _global_path(temp_path)
	var slot_global := _global_path(slot_path)
	var backup_global := _global_path(backup_path)
	_remove_tree(temp_global)
	_remove_tree(backup_global)
	var make_error := DirAccess.make_dir_recursive_absolute(temp_global)
	if make_error != OK:
		return false
	for file_name in ACTIVE_STATE_FILES:
		var source_path := "user://%s" % file_name
		if not FileAccess.file_exists(source_path):
			continue
		var copy_error := DirAccess.copy_absolute(
			_global_path(source_path),
			temp_global.path_join(file_name)
		)
		if copy_error != OK:
			_remove_tree(temp_global)
			return false
	if not _write_json(temp_global.path_join(META_FILE), meta):
		_remove_tree(temp_global)
		return false

	var had_previous := DirAccess.dir_exists_absolute(slot_global)
	if had_previous:
		var backup_error := DirAccess.rename_absolute(slot_global, backup_global)
		if backup_error != OK:
			_remove_tree(temp_global)
			return false
	var install_error := DirAccess.rename_absolute(temp_global, slot_global)
	if install_error != OK:
		if had_previous:
			DirAccess.rename_absolute(backup_global, slot_global)
		_remove_tree(temp_global)
		return false
	_remove_tree(backup_global)
	return true


func _write_json(path: String, payload: Dictionary) -> bool:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		return false
	file.store_string(JSON.stringify(payload, "\t"))
	file.close()
	return true


func _slot_has_state_files(slot: int) -> bool:
	if get_slot_meta(slot).is_empty():
		return false
	for file_name in ACTIVE_STATE_FILES:
		if FileAccess.file_exists(_slot_path(slot).path_join(file_name)):
			return true
	return false


func _load_active_slot() -> void:
	var config := ConfigFile.new()
	if config.load(ACTIVE_CONFIG_PATH) != OK:
		active_slot = 1
		_write_active_slot()
		return
	active_slot = clampi(int(config.get_value("session", "slot", 1)), 1, SLOT_COUNT)


func _write_active_slot() -> void:
	var config := ConfigFile.new()
	config.set_value("session", "slot", active_slot)
	config.save(ACTIVE_CONFIG_PATH)


func _clear_active_state_files() -> void:
	for file_name in ACTIVE_STATE_FILES:
		var path := _global_path("user://%s" % file_name)
		if FileAccess.file_exists(path):
			DirAccess.remove_absolute(path)


func _write_player_fresh_start() -> void:
	var file := FileAccess.open(PLAYER_FRESH_START_PATH, FileAccess.WRITE)
	if file != null:
		file.store_string("fresh")
		file.close()


func _clear_player_fresh_start() -> void:
	var path := _global_path(PLAYER_FRESH_START_PATH)
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)


func _slot_path(slot: int) -> String:
	return "%s/slot_%d" % [SAVE_ROOT, slot]


func _global_path(path: String) -> String:
	return ProjectSettings.globalize_path(path)


func _now_text() -> String:
	return Time.get_datetime_string_from_system(false, true).replace("T", " ")


func _remove_tree(path: String) -> void:
	if DirAccess.dir_exists_absolute(path):
		var dir := DirAccess.open(path)
		if dir != null:
			dir.list_dir_begin()
			var entry := dir.get_next()
			while not entry.is_empty():
				if entry != "." and entry != "..":
					var child_path := path.path_join(entry)
					if dir.current_is_dir():
						_remove_tree(child_path)
					else:
						DirAccess.remove_absolute(child_path)
				entry = dir.get_next()
			dir.list_dir_end()
		DirAccess.remove_absolute(path)
	elif FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
