shader_type spatial;
render_mode unshaded, blend_mix, cull_disabled, depth_draw_never;

uniform vec4 deep_color : source_color = vec4(0.10, 0.42, 0.49, 1.0);
uniform vec4 shallow_color : source_color = vec4(0.34, 0.76, 0.77, 1.0);
uniform vec4 foam_color : source_color = vec4(0.96, 0.97, 0.88, 1.0);
uniform float opacity : hint_range(0.0, 1.0) = 0.62;
uniform float flow_speed : hint_range(0.0, 2.0) = 0.70;
uniform float wave_amplitude : hint_range(0.0, 0.04) = 0.012;
uniform float foam_amount : hint_range(0.0, 1.0) = 0.58;
uniform float layer_phase = 0.0;

varying float ripple;

float hash21(vec2 point) {
	point = fract(point * vec2(127.1, 311.7));
	point += dot(point, point + 19.19);
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

void vertex() {
	ripple = sin(
		UV.y * 38.0 - TIME * 4.4 + UV.x * 12.0 + layer_phase
	);
	float free_weight = smoothstep(0.08, 0.88, UV.y);
	VERTEX += NORMAL * ripple * wave_amplitude * free_weight;
}

void fragment() {
	float stream_texture = value_noise(
		vec2(
			UV.x * 19.0 + layer_phase * 5.0,
			UV.y * 7.5 - TIME * flow_speed
		)
	);
	float long_thread = value_noise(
		vec2(
			UV.x * 42.0 + layer_phase * 7.0,
			UV.y * 4.0 - TIME * flow_speed * 1.55
		)
	);
	float top_foam = smoothstep(0.83, 1.0, 1.0 - UV.y);
	float churn = smoothstep(
		0.73,
		0.94,
		stream_texture + long_thread * 0.20 + top_foam * 0.16
	);
	vec3 water_color = mix(deep_color.rgb, shallow_color.rgb, stream_texture);
	water_color = mix(
		water_color,
		foam_color.rgb,
		churn * foam_amount + top_foam * 0.13
	);
	float edge_fade = smoothstep(0.0, 0.12, UV.x)
		* smoothstep(0.0, 0.12, 1.0 - UV.x);
	float depth_fade = mix(0.96, 0.08, smoothstep(0.42, 1.0, UV.y));
	float shimmer = 0.94 + ripple * 0.035;
	ALBEDO = water_color * shimmer;
	EMISSION = water_color * (0.12 + churn * 0.08);
	ALPHA = opacity * edge_fade * depth_fade;
}
