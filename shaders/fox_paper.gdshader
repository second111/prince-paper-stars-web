shader_type spatial;
render_mode cull_back, diffuse_burley, specular_schlick_ggx;

uniform vec4 paper_color : source_color = vec4(0.72, 0.29, 0.11, 1.0);
uniform float paper_roughness : hint_range(0.0, 1.0) = 0.86;
uniform float grain_strength : hint_range(0.0, 1.0) = 0.55;
uniform float grain_scale : hint_range(1.0, 180.0) = 58.0;
uniform float warm_tint : hint_range(0.0, 0.3) = 0.06;

varying vec3 local_position;
varying vec3 local_normal;

float hash_21(vec2 point) {
	vec3 p3 = fract(vec3(point.xyx) * 0.1031);
	p3 += dot(p3, p3.yzx + 33.33);
	return fract((p3.x + p3.y) * p3.z);
}

float value_noise(vec2 point) {
	vec2 cell = floor(point);
	vec2 local = fract(point);
	local = local * local * (3.0 - 2.0 * local);
	float a = hash_21(cell);
	float b = hash_21(cell + vec2(1.0, 0.0));
	float c = hash_21(cell + vec2(0.0, 1.0));
	float d = hash_21(cell + vec2(1.0, 1.0));
	return mix(mix(a, b, local.x), mix(c, d, local.x), local.y);
}

float paper_pattern(vec3 point) {
	vec3 weight = abs(normalize(local_normal));
	weight /= max(weight.x + weight.y + weight.z, 0.001);
	vec2 yz = point.yz * grain_scale;
	vec2 xz = point.xz * grain_scale;
	vec2 xy = point.xy * grain_scale;
	float grain =
		value_noise(yz) * weight.x
		+ value_noise(xz) * weight.y
		+ value_noise(xy) * weight.z;
	float fiber = value_noise(
		vec2(point.y * grain_scale * 2.2, point.x * grain_scale * 18.0)
	) * 0.25;
	float mottling = value_noise(point.xz * grain_scale * 0.18);
	return grain + fiber + mottling * 0.35;
}

void vertex() {
	local_position = VERTEX;
	local_normal = NORMAL;
}

void fragment() {
	float pattern = paper_pattern(local_position);
	float grain = (pattern - 0.5) * grain_strength;
	vec3 tinted = paper_color.rgb + vec3(warm_tint, warm_tint * 0.45, 0.0);
	ALBEDO = clamp(tinted * (0.94 + grain * 0.18), vec3(0.0), vec3(1.0));
	ROUGHNESS = clamp(paper_roughness + grain * 0.10, 0.05, 1.0);
	SPECULAR = 0.22;
	METALLIC = 0.0;
	EMISSION = tinted * 0.012;
}
