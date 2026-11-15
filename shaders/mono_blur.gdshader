shader_type canvas_item;

uniform float blur_pixels : hint_range(0.0, 8.0) = 2.25;
uniform float brightness : hint_range(0.4, 1.8) = 1.0;

void fragment() {
	vec2 step_uv = TEXTURE_PIXEL_SIZE * blur_pixels;
	vec4 color = texture(TEXTURE, UV) * 0.2;
	color += texture(TEXTURE, UV + vec2(step_uv.x, 0.0)) * 0.12;
	color += texture(TEXTURE, UV - vec2(step_uv.x, 0.0)) * 0.12;
	color += texture(TEXTURE, UV + vec2(0.0, step_uv.y)) * 0.12;
	color += texture(TEXTURE, UV - vec2(0.0, step_uv.y)) * 0.12;
	color += texture(TEXTURE, UV + step_uv) * 0.08;
	color += texture(TEXTURE, UV - step_uv) * 0.08;
	color += texture(TEXTURE, UV + vec2(step_uv.x, -step_uv.y)) * 0.08;
	color += texture(TEXTURE, UV + vec2(-step_uv.x, step_uv.y)) * 0.08;
	COLOR = vec4(color.rgb * brightness, color.a);
}

