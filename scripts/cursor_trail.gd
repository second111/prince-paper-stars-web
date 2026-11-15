extends Node2D

const LIFETIME := 0.23
const MAX_POINTS := 24
const GLOW_COLOR := Color(0.96, 0.69, 0.31)
const MID_COLOR := Color(1.0, 0.82, 0.48)
const CORE_COLOR := Color(1.0, 0.95, 0.79)

var _points: Array[Dictionary] = []


func push_point(screen_position: Vector2) -> void:
	_points.append({
		"position": screen_position,
		"age": 0.0,
	})
	while _points.size() > MAX_POINTS:
		_points.pop_front()
	queue_redraw()


func clear_trail() -> void:
	_points.clear()
	queue_redraw()


func _process(delta: float) -> void:
	if _points.is_empty():
		return
	for index in _points.size():
		_points[index]["age"] = float(_points[index]["age"]) + delta
	while (
		not _points.is_empty()
		and float(_points[0]["age"]) >= LIFETIME
	):
		_points.pop_front()
	queue_redraw()


func _draw() -> void:
	if _points.size() < 2:
		return
	var point_count := _points.size()
	for index in point_count - 1:
		var from_point := _points[index]
		var to_point := _points[index + 1]
		var from_position := from_point["position"] as Vector2
		var to_position := to_point["position"] as Vector2
		var from_visibility := clampf(
			1.0 - float(from_point["age"]) / LIFETIME,
			0.0,
			1.0
		)
		var to_visibility := clampf(
			1.0 - float(to_point["age"]) / LIFETIME,
			0.0,
			1.0
		)
		var taper := clampf(
			(float(index) + 1.0) / float(point_count - 1),
			0.0,
			1.0
		)
		taper = 0.12 + 0.88 * pow(taper, 1.15)
		var visibility := minf(from_visibility, to_visibility)
		var current_taper := taper * visibility
		var bloom_color := GLOW_COLOR
		bloom_color.a = 0.075 * current_taper
		var glow_color := GLOW_COLOR
		glow_color.a = 0.25 * current_taper
		var mid_color := MID_COLOR
		mid_color.a = 0.48 * current_taper
		var core_color := CORE_COLOR
		core_color.a = 0.9 * current_taper
		draw_line(
			from_position,
			to_position,
			bloom_color,
			24.0 * taper,
			true
		)
		draw_line(
			from_position,
			to_position,
			glow_color,
			15.0 * taper,
			true
		)
		draw_line(
			from_position,
			to_position,
			mid_color,
			8.0 * taper,
			true
		)
		draw_line(
			from_position,
			to_position,
			core_color,
			3.2 * taper,
			true
		)

	var head := _points[point_count - 1]
	var head_visibility := clampf(
		1.0 - float(head["age"]) / LIFETIME,
		0.0,
		1.0
	)
	var head_position := head["position"] as Vector2
	var head_bloom := GLOW_COLOR
	head_bloom.a = 0.075 * head_visibility
	var head_glow := GLOW_COLOR
	head_glow.a = 0.18 * head_visibility
	var head_mid := MID_COLOR
	head_mid.a = 0.3 * head_visibility
	var head_core := CORE_COLOR
	head_core.a = 0.65 * head_visibility
	draw_circle(head_position, 12.0, head_bloom)
	draw_circle(head_position, 7.5, head_glow)
	draw_circle(head_position, 4.0, head_mid)
	draw_circle(head_position, 1.8, head_core)
