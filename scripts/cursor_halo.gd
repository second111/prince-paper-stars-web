extends Node2D

const RING_COUNT := 3
const PULSE_SPEED := 0.78
const MIN_RADIUS := 14.0
const MAX_RADIUS := 32.0
const RING_COLOR := Color(0.94, 0.66, 0.3)

var _hovered := false
var _intensity := 0.0
var _phase := 0.0


func set_hovered(hovered: bool) -> void:
	_hovered = hovered


func _process(delta: float) -> void:
	_phase = fmod(_phase + delta * PULSE_SPEED, 1.0)
	var target := 1.0 if _hovered else 0.0
	_intensity = lerpf(
		_intensity,
		target,
		1.0 - exp(-delta * 10.0)
	)
	if _intensity > 0.004 or _hovered:
		queue_redraw()


func _draw() -> void:
	if _intensity <= 0.004:
		return
	var aura_color := RING_COLOR
	aura_color.a = 0.045 * _intensity
	draw_circle(Vector2.ZERO, 17.0, aura_color)
	for ring_index in RING_COUNT:
		var progress := fmod(
			_phase + float(ring_index) / float(RING_COUNT),
			1.0
		)
		var radius := lerpf(MIN_RADIUS, MAX_RADIUS, progress)
		var fade := pow(1.0 - progress, 1.7)
		var ring_color := RING_COLOR
		ring_color.a = 0.43 * fade * _intensity
		draw_arc(
			Vector2.ZERO,
			radius,
			0.0,
			TAU,
			56,
			ring_color,
			1.5,
			true
		)
