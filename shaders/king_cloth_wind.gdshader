shader_type spatial;
render_mode cull_back, depth_draw_opaque, diffuse_burley, specular_schlick_ggx;

uniform sampler2D albedo_texture : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D normal_texture : hint_normal, filter_linear_mipmap, repeat_enable;
uniform sampler2D metallic_roughness_texture : source_color, filter_linear_mipmap, repeat_enable;
uniform vec4 albedo_tint : source_color = vec4(1.0);
uniform float metallic_strength : hint_range(0.0, 1.0) = 0.04;
uniform float wind_strength : hint_range(0.0, 0.2) = 0.06;
uniform float wind_speed : hint_range(0.0, 3.0) = 0.85;
uniform float wind_phase = 0.0;
uniform float local_z_bottom = 0.0;
uniform float local_z_top = -1.0;

void vertex() {
	float z_span = local_z_top - local_z_bottom;
	float vertical = clamp((VERTEX.z - local_z_bottom) / max(abs(z_span), 0.001), 0.0, 1.0);
	float free_weight = 1.0 - vertical;
	vec3 sampled_albedo = texture(albedo_texture, UV).rgb;
	float red_mask = smoothstep(0.08, 0.20, sampled_albedo.r);
	red_mask *= 1.0 - smoothstep(0.12, 0.26, sampled_albedo.g);
	red_mask *= 1.0 - smoothstep(0.18, 0.34, sampled_albedo.b);
	float primary = sin(
		TIME * wind_speed + wind_phase
		+ VERTEX.x * 3.4
		+ VERTEX.y * 0.9
	);
	float ripple = sin(
		TIME * wind_speed * 2.35 + wind_phase * 1.7
		- VERTEX.z * 7.0
		+ VERTEX.x * 8.5
	) * 0.24;
	float sway = (
		(primary * 0.72 + ripple)
		* wind_strength
		* free_weight
		* red_mask
	);
	VERTEX.x += sway;
	VERTEX.y += sway * 0.28;
}

void fragment() {
	vec4 albedo = texture(albedo_texture, UV) * COLOR;
	ALBEDO = albedo.rgb * albedo_tint.rgb;
	NORMAL_MAP = texture(normal_texture, UV).rgb;
	NORMAL_MAP_DEPTH = 1.0;
	vec3 metallic_roughness = texture(metallic_roughness_texture, UV).rgb;
	ROUGHNESS = clamp(metallic_roughness.g, 0.08, 1.0);
	METALLIC = clamp(metallic_roughness.b * metallic_strength, 0.0, 1.0);
	SPECULAR = 0.34;
}
