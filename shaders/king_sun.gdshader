shader_type spatial;
render_mode unshaded, cull_back, depth_draw_opaque;

uniform float sun_energy : hint_range(0.0, 4.0) = 1.8;
uniform float sun_visibility : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	float facing = clamp(dot(normalize(NORMAL), normalize(VIEW)), 0.0, 1.0);
	float core = pow(facing, 2.4);
	float rim = pow(1.0 - facing, 1.6);
	vec3 warm_edge = vec3(1.0, 0.34, 0.06);
	vec3 warm_core = vec3(1.0, 0.76, 0.32);
	vec3 color = mix(warm_edge, warm_core, core);
	color += vec3(1.0, 0.54, 0.16) * rim * 0.24;
	ALBEDO = color * sun_energy;
	EMISSION = color * sun_energy;
	ALPHA = sun_visibility * mix(0.34, 1.0, core);
}
