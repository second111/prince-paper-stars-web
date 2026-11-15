shader_type spatial;
render_mode unshaded, blend_mix, cull_disabled, depth_draw_never;

uniform vec4 deep_color : source_color = vec4(0.09, 0.34, 0.38, 1.0);
uniform vec4 shallow_color : source_color = vec4(0.28, 0.72, 0.69, 1.0);
uniform vec4 foam_color : source_color = vec4(0.94, 0.95, 0.82, 1.0);
uniform float opacity : hint_range(0.0, 1.0) = 0.88;
uniform float flow_speed : hint_range(0.0, 2.0) = 0.42;
uniform float wave_amplitude : hint_range(0.0, 0.03) = 0.014;
uniform float foam_amount : hint_range(0.0, 1.0) = 0.52;
uniform float layer_phase = 0.0;
uniform float terminal_fade_start = -1000.0;
uniform float terminal_fade_end = -1000.0;

varying float wave_height;
varying float terminal_visibility;

float hash21(vec2 point) {
	point = fract(point * vec2(123.34, 456.21));
	point += dot(point, point + 45.32);
	return fract(point.x * point.y);
}

float value_noise(vec2 point) {
	vec2 cell = floor(point);
	vec2 local = fract(point);
	local = local * local * (3.0 - 2.0 * local);
	float a = hash21(cell);
	float b = hash21(cell + vec2(1.0, 0.0));
	float c = hash21(cell + vec2(0.0, 1.0));
	float d = hash21(cell + vec2(1.0, 1.0));
	return mix(mix(a, b, local.x), mix(c, d, local.x), local.y);
}

float paper_noise(vec2 point) {
	float result = value_noise(point) * 0.56;
	result += value_noise(point * 2.03 + vec2(4.7, 1.3)) * 0.28;
	result += value_noise(point * 4.11 - vec2(2.1, 5.8)) * 0.16;
	return result;
}

float river_wave_field(vec3 position) {
	vec2 flow_position = vec2(
		dot(position, normalize(vec3(0.55, 0.08, 0.83))),
		dot(position, normalize(vec3(-0.82, 0.18, 0.54)))
	);
	float broad = value_noise(
		flow_position * 4.3 + vec2(-TIME * 0.34, TIME * 0.12)
	) - 0.5;
	float medium = value_noise(
		flow_position * 10.2 + vec2(TIME * 0.22, -TIME * 0.62)
	) - 0.5;
	float fine = value_noise(
		flow_position.yx * 21.0 + vec2(-TIME * 0.48, TIME * 0.31)
	) - 0.5;
	return broad * 1.25 + medium * 0.65 + fine * 0.24;
}

void vertex() {
	float base_height = VERTEX.y;
	float irregular_swell = river_wave_field(VERTEX);
	wave_height = irregular_swell * 0.84;
	vec3 wave_direction = normalize(VERTEX);
	if (dot(NORMAL, NORMAL) > 0.25) {
		wave_direction = normalize(NORMAL);
	}
	VERTEX += wave_direction * wave_height * wave_amplitude;
	terminal_visibility = smoothstep(
		terminal_fade_end,
		terminal_fade_start,
		base_height
	);
}

void fragment() {
	vec2 flow_uv = vec2(
		UV.x * 7.0 + layer_phase * 2.3,
		UV.y * 12.0 - TIME * flow_speed
	);
	float broad_paper = paper_noise(flow_uv);
	float fine_streaks = value_noise(
		vec2(UV.x * 22.0 + layer_phase * 4.0, UV.y * 34.0 - TIME * flow_speed * 2.2)
	);
	float current = smoothstep(
		0.30,
		0.76,
		broad_paper + sin(UV.y * 18.0 - TIME * 2.4) * 0.08
	);
	vec3 water_color = mix(deep_color.rgb, shallow_color.rgb, current);
	float crest = smoothstep(0.18, 0.82, wave_height);
	float trough = smoothstep(-0.14, -0.70, wave_height);
	water_color = mix(water_color, shallow_color.rgb, crest * 0.16);
	water_color *= 1.0 - trough * 0.055;
	float edge_band = smoothstep(0.0, 0.16, UV.x)
		* smoothstep(0.0, 0.16, 1.0 - UV.x);
	float bank_foam = pow(1.0 - edge_band, 2.2);
	float running_foam = smoothstep(
		0.73,
		0.93,
		fine_streaks + bank_foam * 0.19 + crest * 0.065
	);
	water_color = mix(
		water_color,
		foam_color.rgb,
		running_foam * foam_amount
	);
	water_color += foam_color.rgb * bank_foam * 0.05;
	ALBEDO = water_color;
	EMISSION = water_color * (0.09 + running_foam * 0.06);
	ALPHA = opacity
		* edge_band
		* (0.86 + running_foam * 0.14)
		* terminal_visibility;
}
