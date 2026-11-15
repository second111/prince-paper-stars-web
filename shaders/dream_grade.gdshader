shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear, repeat_disable;
uniform float edge_softness : hint_range(0.0, 1.0) = 0.30;
uniform float bloom_strength : hint_range(0.0, 1.0) = 0.24;
uniform float bloom_threshold : hint_range(0.0, 1.0) = 0.46;
uniform float warmth : hint_range(0.0, 1.0) = 0.38;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.22;
uniform float tilt_shift_strength : hint_range(0.0, 1.0) = 0.86;
uniform float tilt_focus_center : hint_range(0.0, 1.0) = 0.34;
uniform float tilt_focus_band : hint_range(0.0, 0.6) = 0.18;
uniform float tilt_focus_falloff : hint_range(0.1, 0.8) = 0.56;
uniform float tilt_blur_radius : hint_range(0.0, 12.0) = 7.8;

float luminance(vec3 color) {
	return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

vec3 soft_sample(vec2 uv, vec2 radius) {
	vec2 horizontal = vec2(radius.x, 0.0);
	vec2 vertical = vec2(0.0, radius.y);
	vec3 color = texture(screen_texture, uv).rgb * 0.18;
	color += texture(screen_texture, uv + horizontal).rgb * 0.12;
	color += texture(screen_texture, uv - horizontal).rgb * 0.12;
	color += texture(screen_texture, uv + vertical).rgb * 0.12;
	color += texture(screen_texture, uv - vertical).rgb * 0.12;
	color += texture(screen_texture, uv + horizontal + vertical).rgb * 0.085;
	color += texture(screen_texture, uv + horizontal - vertical).rgb * 0.085;
	color += texture(screen_texture, uv - horizontal + vertical).rgb * 0.085;
	color += texture(screen_texture, uv - horizontal - vertical).rgb * 0.085;
	return color;
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 pixel = SCREEN_PIXEL_SIZE;
	vec3 center = texture(screen_texture, uv).rgb;
	vec3 narrow = soft_sample(uv, pixel * 1.8);
	vec3 wide = soft_sample(uv, pixel * 6.0);

	// Only soften silhouettes and high-frequency detail; broad forms keep their shape.
	float edge = (
		abs(luminance(texture(screen_texture, uv + vec2(pixel.x * 1.4, 0.0)).rgb) - luminance(center))
		+ abs(luminance(texture(screen_texture, uv - vec2(pixel.x * 1.4, 0.0)).rgb) - luminance(center))
		+ abs(luminance(texture(screen_texture, uv + vec2(0.0, pixel.y * 1.4)).rgb) - luminance(center))
		+ abs(luminance(texture(screen_texture, uv - vec2(0.0, pixel.y * 1.4)).rgb) - luminance(center))
	);
	float softened = clamp(edge * 3.4, 0.0, 1.0);
	vec3 color = mix(center, narrow, edge_softness * (0.22 + softened * 0.78));

	// A gentle, warm screen-space bloom replaces the unavailable compatibility-renderer glow.
	vec3 highlights = max(wide - vec3(bloom_threshold), vec3(0.0));
	color += highlights * bloom_strength * mix(vec3(1.0, 0.76, 0.48), vec3(1.0), 0.28);

	// A soft horizontal focus band creates the shallow-focus look of a miniature diorama.
	float focus_distance = abs(uv.y - tilt_focus_center);
	float tilt_mask = smoothstep(tilt_focus_band, tilt_focus_falloff, focus_distance);
	vec3 tilt_blur = soft_sample(uv, pixel * tilt_blur_radius);
	color = mix(color, tilt_blur, tilt_mask * tilt_shift_strength);

	float light = luminance(color);
	color = mix(vec3(light), color, 0.91);
	color = mix(color, color * vec3(1.045, 1.0, 0.925), warmth);
	color += vec3(0.010, 0.007, 0.002) * (1.0 - smoothstep(0.0, 0.6, light));

	vec2 centered = uv - vec2(0.5);
	float vignette = smoothstep(0.3, 0.78, length(centered * vec2(1.0, 0.82)));
	color *= 1.0 - vignette * vignette_strength;
	COLOR = vec4(color, 1.0);
}
