extends Control


var glow_color := Color(1.0, 0.72, 0.30, 1.0)
var hovered := false
var _time := 0.0
var _click_ripples: Array[Dictionary] = []


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	focus_mode = Control.FOCUS_NONE
	custom_minimum_size = Vector2(150.0, 150.0)
	size = custom_minimum_size
	pivot_offset = size * 0.5


func set_feedback(hovered_now: bool, color: Color) -> void:
	hovered = hovered_now
	glow_color = color
	queue_redraw()


func trigger_click() -> void:
	_click_ripples.append({"age": 0.0, "delay": 0.0})
	_click_ripples.append({"age": 0.0, "delay": 0.12})
	queue_redraw()


func _process(delta: float) -> void:
	_time += delta
	for index in range(_click_ripples.size() - 1, -1, -1):
		var ripple: Dictionary = _click_ripples[index]
		ripple["age"] = float(ripple.get("age", 0.0)) + delta
		if float(ripple.age) >= 0.92:
			_click_ripples.remove_at(index)
	queue_redraw()


func _draw() -> void:
	if not hovered and _click_ripples.is_empty():
		return
	var center := size * 0.5
	var outer_radius := minf(size.x, size.y) * 0.47
	if hovered:
		for ring_index in 3:
			var phase := fposmod(
				_time * 0.58 + float(ring_index) / 3.0,
				1.0
			)
			_draw_soft_ring(
				center,
				lerpf(12.0, outer_radius, pow(phase, 0.72)),
				pow(1.0 - phase, 1.65) * 0.52,
				2.15
			)
	for ripple in _click_ripples:
		var age := float(ripple.get("age", 0.0)) - float(
			ripple.get("delay", 0.0)
		)
		if age < 0.0:
			continue
		var progress := clampf(age / 0.8, 0.0, 1.0)
		_draw_soft_ring(
			center,
			lerpf(10.0, outer_radius * 1.22, pow(progress, 0.66)),
			pow(1.0 - progress, 1.55) * 0.86,
			2.7
		)


func _draw_soft_ring(
	center: Vector2,
	radius: float,
	alpha: float,
	width: float
) -> void:
	for band in range(-3, 4):
		var offset := float(band)
		var band_alpha := exp(-offset * offset * 0.42)
		draw_arc(
			center,
			radius + offset * 1.15,
			0.0,
			TAU,
			72,
			Color(
				glow_color.r,
				glow_color.g,
				glow_color.b,
				alpha * band_alpha * 0.42
			),
			width,
			true
		)
