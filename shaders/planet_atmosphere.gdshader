shader_type spatial;
render_mode unshaded, blend_add, cull_back, depth_draw_never;

uniform vec4 rim_color : source_color = vec4(0.38, 0.58, 0.92, 0.34);
uniform float rim_power : hint_range(1.0, 6.0) = 2.35;

void fragment() {
	float facing = clamp(dot(NORMAL, VIEW), 0.0, 1.0);
	float rim = pow(1.0 - facing, rim_power);
	ALBEDO = rim_color.rgb;
	ALPHA = rim * rim_color.a;
}
