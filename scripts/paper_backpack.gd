extends Control

const SLOT_SLUGS := [
	"rose",
	"king",
	"vain",
	"earth",
	"merchant",
	"pointlighter",
]
const SLOT_COLORS := [
	Color(0.88, 0.38, 0.58),
	Color(0.96, 0.73, 0.31),
	Color(0.78, 0.52, 0.92),
	Color(0.96, 0.62, 0.28),
	Color(0.45, 0.76, 0.91),
	Color(0.98, 0.70, 0.30),
]

var collection_states: Dictionary = {}
var open_value := 0.0
var open_target := 0.0
var flash_index := -1
var flash_time := 0.0
var phase := 0.0
var backpack_closed_texture: Texture2D
var backpack_open_texture: Texture2D
var backpack_full_texture: Texture2D
var constellation_texture: Texture2D
var slot_star_textures: Dictionary = {}
var closed_mask_textures: Dictionary = {}
var open_mask_textures: Dictionary = {}


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	backpack_closed_texture = load(
		"res://assets/ui/star_memories/backpack_closed.png"
	)
	backpack_open_texture = load(
		"res://assets/ui/star_memories/backpack_open.png"
	)
	backpack_full_texture = load(
		"res://assets/ui/star_memories/backpack_full.png"
	)
	constellation_texture = load(
		"res://assets/ui/star_memories/constellation_seventh.png"
	)
	for slug in SLOT_SLUGS:
		slot_star_textures[slug] = load(
			"res://assets/ui/star_memories/star_%s.png" % slug
		)
	set_process(true)
	queue_redraw()


func set_states(states: Dictionary) -> void:
	collection_states = states.duplicate()
	queue_redraw()


func set_open(value: bool) -> void:
	open_target = 1.0 if value else 0.0


func flash_slot(index: int) -> void:
	flash_index = index
	flash_time = 2.0
	queue_redraw()


func _process(delta: float) -> void:
	phase += delta
	var previous_open := open_value
	open_value = lerpf(open_value, open_target, 1.0 - exp(-delta * 11.0))
	if flash_time > 0.0:
		flash_time = maxf(0.0, flash_time - delta)
	if absf(previous_open - open_value) > 0.0002 or flash_time > 0.0:
		queue_redraw()


func _draw() -> void:
	if backpack_closed_texture != null:
		_draw_textured_backpack()
		return
	var w := size.x
	var h := size.y
	var bag_left := w * 0.14
	var bag_right := w * 0.92
	var bag_top := h * 0.28
	var bag_bottom := h * 0.94
	var body := PackedVector2Array([
		Vector2(bag_left, bag_top + 14.0),
		Vector2(w * 0.28, bag_top),
		Vector2(w * 0.78, bag_top + 2.0),
		Vector2(bag_right, bag_top + 19.0),
		Vector2(w * 0.88, bag_bottom),
		Vector2(w * 0.67, h * 0.98),
		Vector2(w * 0.32, h * 0.96),
		Vector2(w * 0.19, bag_bottom - 12.0),
	])
	var shadow := PackedVector2Array()
	for point in body:
		shadow.append(point + Vector2(4.0, 6.0))
	draw_colored_polygon(shadow, Color(0.01, 0.015, 0.025, 0.42))
	draw_colored_polygon(body, Color(0.57, 0.40, 0.24, 0.94))
	var edge := PackedVector2Array(body)
	edge.append(body[0])
	draw_polyline(edge, Color(0.91, 0.70, 0.40, 0.92), 2.0, true)

	var flap_lift := open_value * h * 0.13
	var flap := PackedVector2Array([
		Vector2(w * 0.18, bag_top + 10.0),
		Vector2(w * 0.30, bag_top - 15.0 - flap_lift),
		Vector2(w * 0.74, bag_top - 17.0 - flap_lift),
		Vector2(w * 0.90, bag_top + 8.0),
		Vector2(w * 0.74, bag_top + 31.0),
		Vector2(w * 0.34, bag_top + 32.0),
	])
	draw_colored_polygon(flap, Color(0.70, 0.52, 0.31, 0.98))
	var flap_edge := PackedVector2Array(flap)
	flap_edge.append(flap[0])
	draw_polyline(flap_edge, Color(0.96, 0.79, 0.48, 0.88), 1.5, true)
	draw_line(
		Vector2(w * 0.33, bag_top + 31.0),
		Vector2(w * 0.75, bag_top + 30.0),
		Color(0.30, 0.18, 0.10, 0.62),
		2.0,
		true
	)

	var strap_start := Vector2(w * 0.23, h * 0.62 - h * 0.06)
	var strap_end := Vector2(w * 0.81, h * 0.62 - h * 0.06)
	draw_line(
		strap_start,
		strap_end,
		Color(0.28, 0.17, 0.09, 0.62),
		18.0,
		true
	)
	draw_line(
		strap_start,
		strap_end,
		Color(0.91, 0.70, 0.38, 0.42),
		1.2,
		true
	)
	var slot_centers: Array[Vector2] = []
	for index in SLOT_SLUGS.size():
		var t := float(index) / float(SLOT_SLUGS.size() - 1)
		var center := Vector2(
			lerpf(w * 0.25, w * 0.79, t),
			h * 0.62 - sin(t * PI) * h * 0.09
		)
		slot_centers.append(center)
		var slug: String = SLOT_SLUGS[index]
		var filled := String(collection_states.get(slug, "")) == "collected"
		var color: Color = SLOT_COLORS[index]
		var shimmer: float = (
			0.55 + 0.45 * sin(phase * 4.8 + index)
			if flash_index == index and flash_time > 0.0
			else 1.0
		)
		_draw_small_star(
			center,
			9.2,
			color if filled else Color(0.98, 0.83, 0.54, 0.84),
			filled,
			shimmer
		)

	var collected_count := 0
	for slug in SLOT_SLUGS:
		if String(collection_states.get(slug, "")) == "collected":
			collected_count += 1
	if collected_count == SLOT_SLUGS.size():
		for index in slot_centers.size() - 1:
			draw_line(
				slot_centers[index],
				slot_centers[index + 1],
				Color(1.0, 0.87, 0.55, 0.62),
				1.2,
				true
			)
		var seventh := Vector2(w * 0.90, h * 0.16)
		draw_dashed_line(
			slot_centers[slot_centers.size() - 1],
			seventh,
			Color(1.0, 0.91, 0.66, 0.62),
			1.2,
			5.0
		)
		_draw_small_star(
			seventh,
			8.5,
			Color(1.0, 0.94, 0.72),
			false,
			1.0
		)


func _draw_textured_backpack() -> void:
	var collected_count := 0
	var collected_mask := 0
	for slug in SLOT_SLUGS:
		var index := SLOT_SLUGS.find(slug)
		if String(collection_states.get(slug, "")) == "collected":
			collected_count += 1
			if index >= 0:
				collected_mask |= 1 << index
	var all_collected := collected_count == SLOT_SLUGS.size()
	var is_open := open_value > 0.34
	var texture := _get_mask_texture(is_open, collected_mask)
	if texture == null:
		return
	var base_rect := _draw_texture_fit(
		texture,
		Rect2(Vector2(0.0, size.y * 0.02), size)
	)
	if flash_index >= 0 and flash_time > 0.0:
		var source_slot_positions: Array[Vector2] = (
			[
				Vector2(61.7, 128.4), Vector2(102.0, 128.4), Vector2(142.2, 128.4),
				Vector2(61.9, 167.6), Vector2(102.0, 167.6), Vector2(142.1, 167.6),
			]
			if is_open
			else [
				Vector2(61.7, 104.6), Vector2(101.9, 104.6), Vector2(142.1, 104.6),
				Vector2(61.8, 148.9), Vector2(102.0, 148.9), Vector2(142.0, 148.9),
			]
		)
		var texture_size := texture.get_size()
		var texture_fit := base_rect.size.x / maxf(texture_size.x, 1.0)
		var center := (
			base_rect.position
			+ source_slot_positions[flash_index] * texture_fit
		)
		var pulse := 0.5 + 0.5 * sin(phase * 12.0)
		draw_circle(
			center,
			21.0 + pulse * 13.0,
			Color(
				SLOT_COLORS[flash_index].r,
				SLOT_COLORS[flash_index].g,
				SLOT_COLORS[flash_index].b,
				0.34 + pulse * 0.18
			)
		)
	if all_collected and constellation_texture != null:
		_draw_texture_fit(
			constellation_texture,
			Rect2(
				Vector2(size.x * 0.44, -size.y * 0.46),
				Vector2(size.x * 0.68, size.y * 0.50)
			),
			Color(1.0, 1.0, 1.0, 0.92)
		)


func _get_mask_texture(is_open: bool, mask_index: int) -> Texture2D:
	var textures: Dictionary = (
		open_mask_textures if is_open else closed_mask_textures
	)
	var cached := textures.get(mask_index) as Texture2D
	if cached != null:
		return cached
	var state_name := "open" if is_open else "closed"
	var texture := load(
		"res://assets/ui/star_memories/backpack_%s_mask_%02d.png"
		% [state_name, mask_index]
	) as Texture2D
	if texture != null:
		textures[mask_index] = texture
	return texture


func _draw_texture_fit(
	texture: Texture2D,
	rect: Rect2,
	tint := Color.WHITE
) -> Rect2:
	var texture_size := texture.get_size()
	var fit := minf(
		rect.size.x / maxf(texture_size.x, 1.0),
		rect.size.y / maxf(texture_size.y, 1.0)
	)
	var draw_size := texture_size * fit
	var draw_rect := Rect2(
		rect.position + (rect.size - draw_size) * 0.5,
		draw_size
	)
	draw_texture_rect(texture, draw_rect, false, tint)
	return draw_rect


func _draw_small_star(
	center: Vector2,
	radius: float,
	color: Color,
	filled: bool,
	shimmer: float
) -> void:
	var points := PackedVector2Array()
	for index in 10:
		var angle := -PI * 0.5 + index * PI / 5.0
		var reach := 1.0 if index % 2 == 0 else 0.43
		points.append(center + Vector2(cos(angle), sin(angle)) * radius * reach)
	if filled:
		draw_circle(
			center,
			radius * (1.42 + 0.12 * shimmer),
			Color(color.r, color.g, color.b, 0.13 * shimmer)
		)
		draw_colored_polygon(points, color)
	else:
		var outline := PackedVector2Array(points)
		outline.append(points[0])
		draw_polyline(outline, color, 1.5, true)
		draw_circle(center, radius * 0.20, Color(color.r, color.g, color.b, 0.66))
