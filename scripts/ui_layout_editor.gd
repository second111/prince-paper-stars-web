extends CanvasLayer

const SAVE_PATH := "res://ui_layout.json"
const USER_SAVE_PATH := "user://ui_layout.json"
const HANDLE_SIZE := 18.0
const MIN_TARGET_SIZE := Vector2(12.0, 12.0)
const MIN_READABLE_FONT_SIZE := 16
const SHOW_ADJUSTMENT_BUTTON := false

var targets: Array[Dictionary] = []
var targets_by_id: Dictionary = {}
var saved_layouts: Dictionary = {}
var selected_id := ""
var edit_active := false
var context_available := true
var active_scope := ""
var scope_roots: Dictionary = {}
var _registered_controls: Dictionary = {}

var _root: Control
var _overlay: Control
var _editor_button: Button
var _toolbar: PanelContainer
var _status: Label
var _drag_mode := 0
var _drag_start_mouse := Vector2.ZERO
var _drag_start_position := Vector2.ZERO
var _drag_start_size := Vector2.ZERO


func _ready() -> void:
	layer = 100
	_load_layouts()
	_build_ui()


func _process(_delta: float) -> void:
	if _editor_button != null:
		_editor_button.visible = (
			SHOW_ADJUSTMENT_BUTTON
			and context_available
			and not edit_active
		)
	if edit_active:
		if selected_id != "":
			var selected := _find_target(selected_id)
			if selected.is_empty() or not is_instance_valid(selected.control):
				selected_id = ""
		_overlay.queue_redraw()


func set_context_available(value: bool, scope := "") -> void:
	if value and scope != active_scope and edit_active:
		set_edit_active(false)
	context_available = value
	active_scope = scope
	if not value and edit_active:
		set_edit_active(false)


func set_scope_root(scope: String, root: Node) -> void:
	if scope.is_empty() or root == null:
		return
	scope_roots[scope] = root
	if edit_active and scope == active_scope:
		_discover_controls()


func register_control(
	control: Control,
	id: String,
	label: String,
	editable_font := true
) -> void:
	if control == null or id.is_empty():
		return
	if targets_by_id.has(id) and _find_target(id).get("control") == control:
		_apply_saved_layout(id, control)
		return
	var font_size := _read_font_size(control)
	var record := {
		"id": id,
		"scope": id.get_slice(".", 0),
		"label": label,
		"control": control,
		"default_position": control.position,
		"default_size": control.size,
		"default_font_size": font_size,
		"editable_font": editable_font and font_size > 0,
		"font_size": font_size,
		"center_pivot": (
			control.pivot_offset.distance_to(control.size * 0.5) < 1.5
		),
	}
	var old_index := _find_target_index(id)
	if old_index >= 0:
		targets[old_index] = record
	else:
		targets.append(record)
	targets_by_id[id] = targets.size() - 1 if old_index < 0 else old_index
	_registered_controls[control] = true
	_apply_saved_layout(id, control)


func reapply_saved_layout(id: String) -> void:
	var target := _find_target(id)
	if target.is_empty():
		return
	var control := target.get("control") as Control
	if control == null or not is_instance_valid(control):
		return
	_apply_saved_layout(id, control)


func _apply_saved_layout(id: String, control: Control) -> void:
	if not saved_layouts.has(id) or not is_instance_valid(control):
		return
	var saved = saved_layouts[id]
	if typeof(saved) != TYPE_DICTIONARY:
		return
	var index := _find_target_index(id)
	if index < 0:
		return
	var record := targets[index]
	var font_size := int(saved.get("font_size", record.get("font_size", 0)))
	if bool(record.get("editable_font", false)) and font_size > 0:
		_apply_font_size(control, font_size)
		record.font_size = font_size
		targets[index] = record
	# Apply typography before the saved rectangle. Changing a Label's font can
	# invalidate its minimum size, and doing that afterwards can move the text
	# for one frame when a planet title is rebuilt or re-entered.
	control.position = Vector2(
		float(saved.get("x", control.position.x)),
		float(saved.get("y", control.position.y))
	)
	control.size = Vector2(
		maxf(MIN_TARGET_SIZE.x, float(saved.get("width", control.size.x))),
		maxf(MIN_TARGET_SIZE.y, float(saved.get("height", control.size.y)))
	)
	if bool(record.get("center_pivot", false)):
		control.pivot_offset = control.size * 0.5


func _build_ui() -> void:
	_root = Control.new()
	_root.name = "UiLayoutEditorLayer"
	_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_root)

	_overlay = Control.new()
	_overlay.name = "SelectionCanvas"
	_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	_overlay.visible = false
	_overlay.draw.connect(_draw_editor_overlay)
	_overlay.gui_input.connect(_on_overlay_gui_input)
	_root.add_child(_overlay)

	_editor_button = Button.new()
	_editor_button.name = "EditInterfaceButton"
	_editor_button.text = "界面"
	_editor_button.tooltip_text = "调整星图、标题、提示和新增 UI 的位置与大小"
	_editor_button.position = Vector2(33, 91)
	_editor_button.size = Vector2(78, 40)
	_editor_button.visible = SHOW_ADJUSTMENT_BUTTON
	_editor_button.add_theme_font_size_override("font_size", 16)
	_style_button(_editor_button)
	_editor_button.pressed.connect(toggle_edit)
	_root.add_child(_editor_button)

	_toolbar = PanelContainer.new()
	_toolbar.name = "UiLayoutToolbar"
	_toolbar.anchor_left = 0.5
	_toolbar.anchor_right = 0.5
	_toolbar.anchor_top = 1.0
	_toolbar.anchor_bottom = 1.0
	_toolbar.offset_left = -438.0
	_toolbar.offset_right = 438.0
	_toolbar.offset_top = -94.0
	_toolbar.offset_bottom = -18.0
	_toolbar.visible = false
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.035, 0.055, 0.075, 0.96)
	panel_style.border_color = Color(0.92, 0.66, 0.27, 0.88)
	panel_style.set_border_width_all(1)
	panel_style.set_corner_radius_all(5)
	panel_style.shadow_color = Color(0.0, 0.0, 0.0, 0.45)
	panel_style.shadow_size = 10
	panel_style.content_margin_left = 14
	panel_style.content_margin_right = 14
	panel_style.content_margin_top = 8
	panel_style.content_margin_bottom = 8
	_toolbar.add_theme_stylebox_override("panel", panel_style)
	_root.add_child(_toolbar)

	var toolbar_content := VBoxContainer.new()
	toolbar_content.add_theme_constant_override("separation", 5)
	_toolbar.add_child(toolbar_content)
	_status = Label.new()
	_status.text = "点选任意框后拖动；拖右下角改变长宽"
	_status.add_theme_font_size_override("font_size", 16)
	_status.add_theme_color_override("font_color", Color(0.97, 0.89, 0.72, 1.0))
	toolbar_content.add_child(_status)
	var buttons := HBoxContainer.new()
	buttons.add_theme_constant_override("separation", 7)
	toolbar_content.add_child(buttons)
	for item in [
		["上一处", _select_previous],
		["下一处", _select_next],
		["字小", _font_smaller],
		["字大", _font_larger],
		["重置", _reset_selected],
		["全部重置", _reset_all],
		["保存", _save_layout],
		["完成", _finish_edit],
	]:
		var button := Button.new()
		button.text = String(item[0])
		button.custom_minimum_size = Vector2(92, 32)
		button.add_theme_font_size_override("font_size", 16)
		_style_button(button)
		button.pressed.connect(item[1])
		buttons.add_child(button)


func toggle_edit() -> void:
	if not SHOW_ADJUSTMENT_BUTTON:
		return
	set_edit_active(not edit_active)


func set_edit_active(value: bool) -> void:
	edit_active = SHOW_ADJUSTMENT_BUTTON and value and context_available
	_overlay.visible = edit_active
	_toolbar.visible = edit_active
	_editor_button.visible = (
		SHOW_ADJUSTMENT_BUTTON
		and context_available
		and not edit_active
	)
	_drag_mode = 0
	if edit_active:
		_contextual_refresh()
		_discover_controls()
		_select_first_visible()
	else:
		selected_id = ""
		_overlay.queue_redraw()
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _finish_edit() -> void:
	_save_layout()
	set_edit_active(false)


func _contextual_refresh() -> void:
	if _selected_target().is_empty():
		_select_first_visible()
	else:
		_update_status()


func _visible_targets() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for record in targets:
		var control := record.get("control") as Control
		if (
			control != null
			and is_instance_valid(control)
			and control.is_visible_in_tree()
			and (
				active_scope.is_empty()
				or String(record.get("scope", "")) == active_scope
			)
		):
			result.append(record)
	return result


func _discover_controls() -> void:
	var root := scope_roots.get(active_scope) as Node
	if root == null:
		return
	var controls: Array[Control] = []
	_collect_editable_controls(root, controls)
	for control in controls:
		if _registered_controls.has(control):
			continue
		var root_path := String(root.get_path())
		var control_path := String(control.get_path())
		var relative_path := control_path.trim_prefix(root_path + "/")
		if relative_path == control_path:
			relative_path = control_path.trim_prefix("/")
		var safe_path := (
			relative_path
			.replace("/", "_")
			.replace(":", "_")
			.replace("@", "_")
		)
		var has_text := _control_has_text(control)
		var kind_label := "文字" if has_text else "界面元素"
		register_control(
			control,
			"%s.auto.%s" % [active_scope, safe_path],
			"%s | %s" % [kind_label, str(control.get_path()).get_file()],
			has_text
		)


func _collect_editable_controls(node: Node, result: Array[Control]) -> void:
	var root := scope_roots.get(active_scope) as Control
	var root_rect := root.get_global_rect() if root != null else Rect2()
	for child in node.get_children():
		if child is Control:
			var control := child as Control
			if (
				not control.is_visible_in_tree()
				or control == root
				or _in_excluded_subtree(control)
				or control.has_meta("ui_layout_locked")
				or control.size.x < 8.0
				or control.size.y < 8.0
			):
				continue
			var nearly_full_screen := (
				root_rect.size.x > 0.0
				and root_rect.size.y > 0.0
				and control.get_global_rect().size.x >= root_rect.size.x * 0.94
				and control.get_global_rect().size.y >= root_rect.size.y * 0.94
			)
			if not nearly_full_screen:
				result.append(control)
		if not child.has_meta("ui_layout_locked"):
			_collect_editable_controls(child, result)


func _control_has_text(control: Control) -> bool:
	if control is Label:
		return not String((control as Label).text).is_empty()
	if control is RichTextLabel:
		return not String((control as RichTextLabel).text).is_empty()
	if control is Button:
		return not String((control as Button).text).is_empty()
	return false


func _in_excluded_subtree(control: Control) -> bool:
	var node: Node = control
	while node != null and node != get_parent():
		if String(node.name) in ["LayoutEditor", "UiLayoutToolbar"]:
			return true
		node = node.get_parent()
	return false


func _select_first_visible() -> void:
	var visible_targets := _visible_targets()
	selected_id = ""
	for record in visible_targets:
		if bool(record.get("editable_font", false)):
			selected_id = String(record.id)
			break
	if selected_id.is_empty() and not visible_targets.is_empty():
		selected_id = String(visible_targets[0].id)
	_update_status()
	_overlay.queue_redraw()


func _select_previous() -> void:
	_cycle_selection(-1)


func _select_next() -> void:
	_cycle_selection(1)


func _cycle_selection(direction: int) -> void:
	var visible_targets := _visible_targets()
	if visible_targets.is_empty():
		selected_id = ""
	elif selected_id == "":
		selected_id = String(visible_targets[0].id)
	else:
		var current_index := -1
		for index in visible_targets.size():
			if String(visible_targets[index].id) == selected_id:
				current_index = index
				break
		selected_id = String(
			visible_targets[
				posmod(current_index + direction, visible_targets.size())
			].id
		)
	_update_status()
	_overlay.queue_redraw()


func _selected_target() -> Dictionary:
	return _find_target(selected_id)


func _find_target(id: String) -> Dictionary:
	var index := _find_target_index(id)
	return targets[index] if index >= 0 else {}


func _find_target_index(id: String) -> int:
	for index in targets.size():
		if String(targets[index].id) == id:
			return index
	return -1


func _on_overlay_gui_input(event: InputEvent) -> void:
	if not edit_active:
		return
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		if _drag_mode == 0:
			_overlay.mouse_default_cursor_shape = (
				Control.CURSOR_FDIAGSIZE
				if _is_selected_handle(motion.position)
				else Control.CURSOR_MOVE
			)
			return
		var delta := motion.position - _drag_start_mouse
		var target := _selected_target()
		if target.is_empty():
			return
		var control := target.control as Control
		if _drag_mode == 1:
			control.position = _drag_start_position + delta
		else:
			control.size = (_drag_start_size + delta).max(MIN_TARGET_SIZE)
			if bool(target.get("center_pivot", false)):
				control.pivot_offset = control.size * 0.5
		_store_target_rect(target, control)
		_update_status()
		_overlay.queue_redraw()
		_overlay.accept_event()
		return
	if event is not InputEventMouseButton:
		return
	var mouse_button := event as InputEventMouseButton
	if mouse_button.button_index != MOUSE_BUTTON_LEFT:
		return
	if not mouse_button.pressed:
		_drag_mode = 0
		_overlay.mouse_default_cursor_shape = Control.CURSOR_ARROW
		return
	var hit_target := _target_at(mouse_button.position)
	if hit_target.is_empty():
		return
	selected_id = String(hit_target.id)
	_drag_start_mouse = mouse_button.position
	_drag_start_position = (hit_target.control as Control).position
	_drag_start_size = (hit_target.control as Control).size
	_drag_mode = 2 if _is_selected_handle(mouse_button.position) else 1
	_overlay.mouse_default_cursor_shape = (
		Control.CURSOR_FDIAGSIZE if _drag_mode == 2 else Control.CURSOR_MOVE
	)
	_update_status()
	_overlay.queue_redraw()
	_overlay.accept_event()


func _target_at(point: Vector2) -> Dictionary:
	var visible_targets := _visible_targets()
	for index in range(visible_targets.size() - 1, -1, -1):
		var record := visible_targets[index]
		var control := record.control as Control
		if control.get_global_rect().has_point(point):
			return record
	return {}


func _is_selected_handle(point: Vector2) -> bool:
	var target := _selected_target()
	if target.is_empty():
		return false
	var rect: Rect2 = (target.control as Control).get_global_rect()
	var handle := Rect2(
		rect.end - Vector2(HANDLE_SIZE, HANDLE_SIZE),
		Vector2(HANDLE_SIZE, HANDLE_SIZE)
	)
	return handle.has_point(point)


func _store_target_rect(record: Dictionary, control: Control) -> void:
	var id := String(record.id)
	var stored: Dictionary = saved_layouts.get(id, {})
	stored.x = control.position.x
	stored.y = control.position.y
	stored.width = control.size.x
	stored.height = control.size.y
	stored.font_size = int(record.get("font_size", 0))
	saved_layouts[id] = stored


func _font_smaller() -> void:
	_adjust_font_size(-1)


func _font_larger() -> void:
	_adjust_font_size(1)


func _adjust_font_size(delta: int) -> void:
	var target := _selected_target()
	if target.is_empty() or not bool(target.get("editable_font", false)):
		_set_status("当前对象没有可调字号")
		return
	var control := target.control as Control
	var next_size := clampi(
		int(target.font_size) + delta,
		MIN_READABLE_FONT_SIZE,
		256
	)
	target.font_size = next_size
	_apply_font_size(control, next_size)
	_store_target_rect(target, control)
	_update_status()


func _apply_font_size(control: Control, font_size: int) -> void:
	if control is Label or control is Button or control is RichTextLabel:
		control.add_theme_font_size_override("font_size", font_size)


func _read_font_size(control: Control) -> int:
	if control is Label or control is Button or control is RichTextLabel:
		return control.get_theme_font_size("font_size")
	return 0


func _reset_selected() -> void:
	var target := _selected_target()
	if target.is_empty():
		return
	_restore_target_default(target)
	saved_layouts.erase(String(target.id))
	_update_status()
	_overlay.queue_redraw()


func _reset_all() -> void:
	for target in targets:
		_restore_target_default(target)
	saved_layouts.clear()
	_set_status("已恢复所有界面对象的默认位置与大小")
	_overlay.queue_redraw()


func _restore_target_default(target: Dictionary) -> void:
	var control := target.control as Control
	if control == null or not is_instance_valid(control):
		return
	control.position = target.default_position
	control.size = target.default_size
	if bool(target.get("center_pivot", false)):
		control.pivot_offset = control.size * 0.5
	if bool(target.get("editable_font", false)):
		var font_size := int(target.default_font_size)
		target.font_size = font_size
		_apply_font_size(control, font_size)


func _save_layout() -> void:
	var payload := JSON.stringify({
		"version": 1,
		"description": "Global UI positions and sizes edited in game with the 界面 button.",
		"elements": saved_layouts,
	}, "\t")
	var saved_targets: Array[String] = []
	for path in [USER_SAVE_PATH, SAVE_PATH]:
		var file := FileAccess.open(path, FileAccess.WRITE)
		if file != null:
			file.store_string(payload)
			file.close()
			saved_targets.append("用户设置" if path == USER_SAVE_PATH else "项目文件")
	_set_status(
		"已保存 %d 个界面对象到 %s" % [
			saved_layouts.size(),
			"、".join(PackedStringArray(saved_targets)),
		]
		if not saved_targets.is_empty()
		else "保存失败：%s" % error_string(FileAccess.get_open_error())
	)


func _load_layouts() -> void:
	saved_layouts.clear()
	for path in [USER_SAVE_PATH, SAVE_PATH]:
		if not FileAccess.file_exists(path):
			continue
		var file := FileAccess.open(path, FileAccess.READ)
		if file == null:
			continue
		var parsed = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(parsed) != TYPE_DICTIONARY:
			continue
		var elements = parsed.get("elements", {})
		if typeof(elements) == TYPE_DICTIONARY:
			saved_layouts = elements.duplicate(true)
			return


func _update_status() -> void:
	var target := _selected_target()
	if target.is_empty():
		_set_status("没有可编辑对象")
		return
	var control := target.control as Control
	var font_part := (
		" | 字号 %d" % int(target.font_size)
		if bool(target.get("editable_font", false))
		else ""
	)
	_set_status(
		"%s | x %.0f  y %.0f  w %.0f  h %.0f%s"
		% [
			String(target.label),
			control.position.x,
			control.position.y,
			control.size.x,
			control.size.y,
			font_part,
		]
	)


func _set_status(text: String) -> void:
	if _status != null:
		_status.text = text


func _draw_editor_overlay() -> void:
	if not edit_active:
		return
	var visible_targets := _visible_targets()
	for record in visible_targets:
		var control := record.control as Control
		var rect := control.get_global_rect()
		var is_selected := String(record.id) == selected_id
		var color := (
			Color(1.0, 0.65, 0.16, 1.0)
			if is_selected
			else Color(0.78, 0.90, 0.96, 0.45)
		)
		_overlay.draw_rect(rect, color, false, 2.0 if is_selected else 1.0)
		if is_selected:
			var handle := Rect2(
				rect.end - Vector2(HANDLE_SIZE, HANDLE_SIZE),
				Vector2(HANDLE_SIZE, HANDLE_SIZE)
			)
			_overlay.draw_rect(handle, Color(1.0, 0.65, 0.16, 0.88))
			_overlay.draw_line(
				handle.position + Vector2(4.0, HANDLE_SIZE - 3.0),
				handle.position + Vector2(HANDLE_SIZE - 3.0, 4.0),
				Color(0.22, 0.10, 0.03, 0.96),
				1.4,
				true
			)


func _style_button(button: Button) -> void:
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.90, 0.84, 0.70, 0.96)
	normal.border_color = Color(0.38, 0.25, 0.15, 0.84)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(3)
	normal.content_margin_left = 8
	normal.content_margin_right = 8
	normal.content_margin_top = 4
	normal.content_margin_bottom = 4
	var hover := normal.duplicate()
	hover.bg_color = Color(1.0, 0.89, 0.66, 1.0)
	hover.border_color = Color(0.65, 0.40, 0.12, 1.0)
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", hover)
	button.add_theme_color_override("font_color", Color(0.25, 0.16, 0.10, 1.0))
	button.add_theme_color_override("font_hover_color", Color(0.22, 0.11, 0.05, 1.0))
	button.add_theme_color_override("font_pressed_color", Color(0.18, 0.09, 0.04, 1.0))
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
