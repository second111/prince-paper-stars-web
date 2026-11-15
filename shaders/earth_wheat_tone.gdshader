shader_type spatial;
render_mode diffuse_toon, specular_disabled;

uniform sampler2D albedo_texture : source_color, filter_linear_mipmap;
uniform float brightness : hint_range(0.65, 1.15) = 0.88;
uniform float saturation : hint_range(0.65, 1.15) = 0.82;
uniform float detail_blend : hint_range(0.0, 1.0) = 0.34;
uniform vec3 warm_tint : source_color = vec3(1.0, 0.96, 0.86);
uniform float wind_strength : hint_range(0.0, 1.0) = 0.0;
uniform float wind_time = 0.0;
uniform vec3 wind_origin = vec3(0.0);
uniform vec3 wind_direction = vec3(0.0, 0.0, 1.0);
uniform float wind_radius : hint_range(0.1, 3.0) = 0.72;
uniform float wind_bend : hint_range(0.0, 0.5) = 0.12;
uniform float wind_floor_y = -0.5;
uniform float wind_height = 1.0;

void vertex() {
	if (wind_strength > 0.0001) {
		vec4 world_position = MODEL_MATRIX * vec4(VERTEX, 1.0);
		float height_factor = clamp(
			(VERTEX.y - wind_floor_y) / max(wind_height, 0.001),
			0.0,
			1.0
		);
		height_factor = smoothstep(0.0, 1.0, height_factor);
		height_factor *= height_factor;

		vec3 local_wind_direction = normalize(
			wind_direction * mat3(MODEL_MATRIX)
		);
		float distance_to_pointer = length(
			world_position.xyz - wind_origin
		);
		float influence = 1.0 - smoothstep(
			wind_radius * 0.12,
			wind_radius,
			distance_to_pointer
		);
		float travelling_wave = 0.62 + 0.38 * sin(
			distance_to_pointer * 16.0
			- wind_time * 9.4
			+ world_position.y * 4.0
			+ world_position.x * 2.6
			+ world_position.z * 1.9
			+ VERTEX.y * 8.0
		);
		float bend = height_factor * (
			wind_strength * influence * travelling_wave * wind_bend
		);
		VERTEX += local_wind_direction * bend;
	}
}

void fragment() {
	vec4 source = texture(albedo_texture, UV);
	float luminance = dot(source.rgb, vec3(0.299, 0.587, 0.114));
	vec3 adjusted = mix(vec3(luminance), source.rgb, saturation);
	vec3 posterized = floor(adjusted * 6.0 + 0.5) / 6.0;
	adjusted = mix(adjusted, posterized, detail_blend);
	adjusted *= warm_tint * brightness;
	ALBEDO = clamp(adjusted, vec3(0.0), vec3(1.0));
	ALPHA = source.a;
	ROUGHNESS = 1.0;
	EMISSION = ALBEDO * 0.035;
}
