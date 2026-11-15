extends Button


const VISUAL_SCALE := 0.8
const BREATH_RING_SCALE := 0.7
const OPACITY_SCALE := 0.8


var pulse_phase := 0.0
var pulse_speed := 1.45
var glow_color := Color(0.28, 0.68, 1.0, 1.0)


func _ready() -> void:
	flat = true
	focus_mode = Control.FOCUS_NONE
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	custom_minimum_size = Vector2(56.0, 56.0) * VISUAL_SCALE
	size = custom_minimum_size
	pivot_offset = size * 0.5
	var empty := StyleBoxEmpty.new()
	for style_name in [
		"normal",
		"hover",
		"pressed",
		"focus",
		"disabled",
	]:
		add_theme_stylebox_override(style_name, empty)
	queue_redraw()


func _process(delta: float) -> void:
	pulse_phase = fmod(pulse_phase + delta * pulse_speed, TAU)
	queue_redraw()


func _draw() -> void:
	var center := size * 0.5
	var pulse := 0.5 + 0.5 * sin(pulse_phase)
	var hover_boost := 1.0 if not is_hovered() else 1.12
	var glow_energy := (0.88 + pulse * 0.12) * hover_boost
	for layer in range(44, 0, -1):
		var layer_ratio := float(layer) / 44.0
		var radius := lerpf(3.0, 37.0, layer_ratio) * VISUAL_SCALE
		var alpha := (
			pow(1.0 - layer_ratio, 1.9)
			* 0.15
			* glow_energy
			* OPACITY_SCALE
		)
		draw_circle(
			center,
			radius,
			Color(
				lerpf(0.24, 0.72, 1.0 - layer_ratio),
				lerpf(0.56, 0.90, 1.0 - layer_ratio),
				1.0,
				alpha
			)
		)
	var ring_progress := fmod(pulse_phase / TAU * 1.8, 1.0)
	var ring_distance := pow(ring_progress, 0.55)
	var ring_radius := (
		lerpf(3.0, 64.0, ring_distance)
		* VISUAL_SCALE
		* BREATH_RING_SCALE
		* hover_boost
	)
	var ring_alpha := (
		pow(1.0 - ring_progress, 0.72)
		* 0.76
		* OPACITY_SCALE
	)
	for band in range(-6, 7):
		var band_offset := float(band) / 6.0
		var edge_fade := exp(-band_offset * band_offset * 2.9)
		draw_arc(
			center,
			ring_radius + (
				band_offset
				* 7.0
				* VISUAL_SCALE
				* BREATH_RING_SCALE
			),
			0.0,
			TAU,
			56,
			Color(
				glow_color.r,
				glow_color.g,
				1.0,
				ring_alpha * edge_fade * 0.30
			),
			2.6 * VISUAL_SCALE,
			true
		)
