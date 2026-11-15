shader_type spatial;
render_mode cull_back, blend_mix, depth_draw_opaque, diffuse_burley, specular_schlick_ggx;

uniform float moon_glow : hint_range(0.0, 1.0) = 0.35;
uniform float moon_visibility : hint_range(0.0, 1.0) = 1.0;

float crater(vec2 uv, vec2 center, float radius) {
	float distance_to_center = length(uv - center);
	float pit = 1.0 - smoothstep(radius * 0.45, radius, distance_to_center);
	float rim = smoothstep(radius * 1.22, radius, distance_to_center)
		* (1.0 - smoothstep(radius, radius * 0.82, distance_to_center));
	return pit * 0.20 - rim * 0.10;
}

void fragment() {
	vec2 uv = UV;
	float surface_variation =
		sin(uv.x * 31.0 + uv.y * 17.0) * 0.025
		+ sin(uv.x * 63.0 - uv.y * 41.0) * 0.018;
	float craters = 0.0;
	craters += crater(uv, vec2(0.22, 0.31), 0.085);
	craters += crater(uv, vec2(0.43, 0.58), 0.055);
	craters += crater(uv, vec2(0.68, 0.27), 0.070);
	craters += crater(uv, vec2(0.78, 0.72), 0.048);
	craters += crater(uv, vec2(0.27, 0.76), 0.040);
	craters += crater(uv, vec2(0.54, 0.84), 0.032);
	craters += crater(uv, vec2(0.13, 0.55), 0.028);
	craters += crater(uv, vec2(0.90, 0.48), 0.024);
	vec3 moon_base = vec3(0.72, 0.77, 0.87);
	vec3 moon_color = moon_base + vec3(surface_variation) - vec3(craters);
	ALBEDO = clamp(moon_color, 0.0, 1.0);
	ROUGHNESS = 0.90;
	SPECULAR = 0.18;
	EMISSION = moon_color * moon_glow;
	ALPHA = moon_visibility;
}
