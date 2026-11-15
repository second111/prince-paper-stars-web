extends Control

signal player_asset_dropped(asset_index: int, screen_position: Vector2)


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_PASS


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return (
		data is Dictionary
		and String((data as Dictionary).get("kind", "")) == "player_placeable_asset"
	)


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if not _can_drop_data(at_position, data):
		return
	var payload := data as Dictionary
	player_asset_dropped.emit(int(payload.get("index", -1)), at_position)
	accept_event()
