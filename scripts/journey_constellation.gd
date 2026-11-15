extends Control


const ROUTE_CENTER := Vector2(800.0, 500.0)
const CURVE_SEGMENTS := 34
const MIN_CURVE_BEND := 18.0
const MAX_CURVE_BEND := 42.0
const REVEAL_DURATION := 0.92
const REPLAY_SEGMENT_DURATION := 0.62
const GLOW_LAYERS := [
	{"width": 34.0, "alpha": 0.010},
	{"width": 30.0, "alpha": 0.013},
	{"width": 26.0, "alpha": 0.017},
	{"width": 22.0, "alpha": 0.022},
	{"width": 18.0, "alpha": 0.029},
	{"width": 14.0, "alpha": 0.038},
	{"width": 11.0, "alpha": 0.048},
	{"width": 8.0, "alpha": 0.060},
]


var _stops: Array[Dictionary] = []
var _segments: Array[Dictionary] = []
var _reveal_progress := 0.0
var _hovered_slug := ""
var _pulse_time := 0.0
var _reveal_tween: Tween


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	set_process(true)


func _process(delta: float) -> void:
	if not visible or _segments.is_empty():
		return
	_pulse_time += delta
	queue_redraw()


func set_route(
	route_stops: Array,
	animate_new_segment := false
) -> void:
	var previous_segment_count := _segments.size()
	_stops.clear()
	for value in route_stops:
		if typeof(value) != TYPE_DICTIONARY:
			continue
		var source: Dictionary = value
		if not source.has("center") or String(source.get("slug", "")).is_empty():
			continue
		_stops.append(source.duplicate(true))
	_rebuild_segments()

	if _reveal_tween != null and _reveal_tween.is_valid():
		_reveal_tween.kill()
	if _segments.is_empty():
		_reveal_progress = 0.0
		queue_redraw()
		return

	if animate_new_segment and previous_segment_count < _segments.size():
		_reveal_progress = float(previous_segment_count)
		_reveal_tween = create_tween()
		_reveal_tween.tween_method(
			_set_reveal_progress,
			_reveal_progress,
			float(_segments.size()),
			REVEAL_DURATION
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	else:
		_reveal_progress = float(_segments.size())
	queue_redraw()


func set_hovered_planet(slug: String) -> void:
	if _hovered_slug == slug:
		return
	_hovered_slug = slug
	queue_redraw()


func replay_route(
	seconds_per_segment := REPLAY_SEGMENT_DURATION
) -> Tween:
	if _segments.is_empty():
		_reveal_progress = 0.0
		queue_redraw()
		return null
	if _reveal_tween != null and _reveal_tween.is_valid():
		_reveal_tween.kill()
	_reveal_progress = 0.0
	queue_redraw()
	_reveal_tween = create_tween()
	_reveal_tween.tween_method(
		_set_reveal_progress,
		0.0,
		float(_segments.size()),
		maxf(0.12, seconds_per_segment) * float(_segments.size())
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	return _reveal_tween


func get_stop_count() -> int:
	return _stops.size()


func get_segment_count() -> int:
	return _segments.size()


func get_route_slugs() -> Array[String]:
	var result: Array[String] = []
	for stop in _stops:
		result.append(String(stop.get("slug", "")))
	return result


func _set_reveal_progress(value: float) -> void:
	_reveal_progress = value
	queue_redraw()


func _rebuild_segments() -> void:
	_segments.clear()
	for index in range(1, _stops.size()):
		var from_stop: Dictionary = _stops[index - 1]
		var to_stop: Dictionary = _stops[index]
		_segments.append(_make_segment(from_stop, to_stop, index - 1))


func _make_segment(
	from_stop: Dictionary,
	to_stop: Dictionary,
	index: int
) -> Dictionary:
	var start: Vector2 = from_stop.get("center", Vector2.ZERO)
	var finish: Vector2 = to_stop.get("center", Vector2.ZERO)
	var midpoint := (start + finish) * 0.5
	var outward := midpoint - ROUTE_CENTER
	if outward.length_squared() < 0.01:
		outward = (finish - start).orthogonal()
	outward = outward.normalized()
	var distance := start.distance_to(finish)
	var bend := clampf(
		distance * 0.075 + float(index % 3) * 3.5,
		MIN_CURVE_BEND,
		MAX_CURVE_BEND
	)
	var control := midpoint + outward * bend
	var points := PackedVector2Array()
	for sample in CURVE_SEGMENTS + 1:
		var t := float(sample) / float(CURVE_SEGMENTS)
		var inverse := 1.0 - t
		points.append(
			start * inverse * inverse
			+ control * 2.0 * inverse * t
			+ finish * t * t
		)
	return {
		"from": String(from_stop.get("slug", "")),
		"to": String(to_stop.get("slug", "")),
		"from_color": from_stop.get("color", Color(0.94, 0.76, 0.42)),
		"to_color": to_stop.get("color", Color(0.94, 0.76, 0.42)),
		"points": points,
	}


func _draw() -> void:
	if _segments.is_empty():
		return
	for index in _segments.size():
		var progress := clampf(
			_reveal_progress - float(index),
			0.0,
			1.0
		)
		if progress <= 0.0:
			continue
		_draw_segment(_segments[index], progress)
	_draw_stop_markers()


func _draw_segment(segment: Dictionary, progress: float) -> void:
	var all_points: PackedVector2Array = segment.get(
		"points",
		PackedVector2Array()
	)
	if all_points.size() < 2:
		return
	var visible_count := clampi(
		ceili(float(all_points.size() - 1) * progress) + 1,
		2,
		all_points.size()
	)
	var points := PackedVector2Array()
	for index in visible_count:
		points.append(all_points[index])
	var from_color: Color = segment.get(
		"from_color",
		Color(0.94, 0.76, 0.42)
	)
	var to_color: Color = segment.get(
		"to_color",
		Color(0.94, 0.76, 0.42)
	)
	var emphasis := _segment_emphasis(segment)
	for glow_layer in GLOW_LAYERS:
		draw_polyline(
			points,
			Color(
				0.98,
				0.88,
				0.69,
				float(glow_layer.alpha) * emphasis
			),
			float(glow_layer.width),
			true
		)
	for index in range(points.size() - 1):
		var t := float(index) / float(maxi(1, points.size() - 2))
		var line_color := from_color.lerp(to_color, t)
		line_color.a = 0.58 * emphasis
		draw_line(
			points[index],
			points[index + 1],
			line_color,
			4.2 + (1.6 if not _hovered_slug.is_empty() and emphasis > 1.0 else 0.0),
			true
		)
	for dot_index in range(3, points.size(), 7):
		var t := float(dot_index) / float(maxi(1, points.size() - 1))
		var dot_color := from_color.lerp(to_color, t).lightened(0.36)
		dot_color.a = 0.45 * emphasis
		draw_circle(points[dot_index], 1.25, dot_color, true, -1.0, true)


func _draw_stop_markers() -> void:
	for index in _stops.size():
		var stop: Dictionary = _stops[index]
		var slug := String(stop.get("slug", ""))
		var center: Vector2 = stop.get("center", Vector2.ZERO)
		var radius := float(stop.get("radius", 60.0))
		var color: Color = stop.get("color", Color(0.94, 0.76, 0.42))
		var direction := Vector2.UP
		if index + 1 < _stops.size():
			var next_center: Vector2 = _stops[index + 1].get("center", center)
			direction = (next_center - center).normalized()
		elif index > 0:
			var previous_center: Vector2 = _stops[index - 1].get("center", center)
			direction = (center - previous_center).normalized()
		var marker := center + direction * (radius + 13.0)
		var activity := _stop_activity(index)
		if activity <= 0.0:
			continue
		var hovered := _hovered_slug == slug
		var pulse := 0.5 + 0.5 * sin(_pulse_time * 2.3 + float(index) * 1.47)
		var emphasis := 1.0 + (0.75 if hovered else 0.0)
		var halo := color
		halo.a = (0.10 + pulse * 0.035) * activity * emphasis
		draw_circle(marker, 8.5 + pulse * 2.0, halo, true, -1.0, true)
		var shadow := Color(0.03, 0.05, 0.08, 0.52 * activity)
		draw_circle(marker + Vector2(0.6, 1.1), 2.7, shadow, true, -1.0, true)
		var core := color.lightened(0.42)
		core.a = 0.80 * activity
		draw_circle(marker, 2.25 + (0.55 if hovered else 0.0), core, true, -1.0, true)
		_draw_star_spark(marker, color.lightened(0.58), activity * (0.55 + pulse * 0.25))


func _draw_star_spark(
	center: Vector2,
	color: Color,
	alpha: float
) -> void:
	var sparkle := color
	sparkle.a = clampf(alpha, 0.0, 0.86)
	draw_line(center + Vector2(-5.0, 0.0), center + Vector2(5.0, 0.0), sparkle, 0.8, true)
	draw_line(center + Vector2(0.0, -5.0), center + Vector2(0.0, 5.0), sparkle, 0.8, true)


func _stop_activity(index: int) -> float:
	var activity := 0.0
	if index > 0:
		activity = maxf(
			activity,
			clampf(_reveal_progress - float(index - 1), 0.0, 1.0)
		)
	if index < _segments.size():
		activity = maxf(
			activity,
			clampf(_reveal_progress - float(index), 0.0, 1.0)
		)
	return activity


func _segment_emphasis(segment: Dictionary) -> float:
	if _hovered_slug.is_empty():
		return 1.0
	if (
		String(segment.get("from", "")) == _hovered_slug
		or String(segment.get("to", "")) == _hovered_slug
	):
		return 1.55
	return 0.42
