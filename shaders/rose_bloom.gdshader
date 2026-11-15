shader_type spatial;
render_mode cull_disabled, depth_draw_opaque, diffuse_burley, specular_schlick_ggx;

uniform sampler2D albedo_texture : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D normal_texture : hint_normal, filter_linear_mipmap, repeat_enable;
uniform sampler2D roughness_texture : source_color, filter_linear_mipmap, repeat_enable;
uniform bool has_albedo_texture = true;
uniform bool has_normal_texture = false;
uniform bool has_roughness_texture = false;
uniform vec4 albedo_tint : source_color = vec4(1.0);
uniform vec4 emission_tint : source_color = vec4(0.42, 0.08, 0.12, 1.0);
uniform float base_roughness : hint_range(0.0, 1.0) = 0.72;
uniform float base_metallic : hint_range(0.0, 1.0) = 0.0;
uniform float bloom : hint_range(0.0, 1.0) = 0.5;
uniform float breath_strength : hint_range(0.0, 0.03) = 0.004;
uniform float sway_strength : hint_range(0.0, 0.02) = 0.0015;
uniform float sway_speed : hint_range(0.0, 3.0) = 0.36;
uniform float tremble_strength : hint_range(0.0, 1.0) = 0.0;
uniform float leaf_strength : hint_range(0.0, 1.0) = 0.22;
uniform float turn_strength : hint_range(-1.0, 1.0) = 0.0;
uniform vec2 turn_direction = vec2(1.0, 0.0);
uniform float glow_strength : hint_range(0.0, 1.0) = 0.0;

void vertex() {
	// The source model uses -Z as its height axis before import rotation.
	float height = clamp(-VERTEX.z / 1.1457, 0.0, 1.0);
	vec3 sampled_albedo = vec3(0.5);
	if (has_albedo_texture) {
		sampled_albedo = texture(albedo_texture, UV).rgb;
	}
	float green_mask = smoothstep(
		0.015,
		0.10,
		sampled_albedo.g - sampled_albedo.r
	);
	float leaf_band = (
		smoothstep(0.12, 0.28, height)
		* (1.0 - smoothstep(0.62, 0.78, height))
	);
	float outer_leaf = smoothstep(0.018, 0.085, abs(VERTEX.x));
	float side_phase = mix(1.15, -0.85, step(0.0, VERTEX.x));
	float leaf_wave = sin(
		TIME * 2.45
		+ side_phase
		+ VERTEX.z * 9.0
		+ abs(VERTEX.x) * 26.0
	) * leaf_strength * green_mask * leaf_band * outer_leaf * 0.055;
	VERTEX.y += leaf_wave;
	VERTEX.x += leaf_wave * 0.46;
}

void fragment() {
	vec4 albedo = COLOR;
	if (has_albedo_texture) {
		albedo *= texture(albedo_texture, UV);
	}
	ALBEDO = albedo.rgb * albedo_tint.rgb;
	if (has_normal_texture) {
		NORMAL_MAP = texture(normal_texture, UV).rgb;
		NORMAL_MAP_DEPTH = 1.0;
	}
	ROUGHNESS = base_roughness;
	METALLIC = min(base_metallic, 0.08);
	if (has_roughness_texture) {
		vec3 metallic_roughness = texture(roughness_texture, UV).rgb;
		ROUGHNESS = metallic_roughness.g;
		METALLIC = metallic_roughness.b * min(base_metallic, 0.18);
	}
	SPECULAR = 0.34;
	float pulse = 0.88 + 0.12 * sin(TIME * 1.7);
	EMISSION = emission_tint.rgb * glow_strength * pulse;
}
