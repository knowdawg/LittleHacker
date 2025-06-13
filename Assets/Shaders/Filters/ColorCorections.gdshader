shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;
uniform float brightness : hint_range(0.0, 10.0) = 1.0;
uniform float contrast : hint_range(0.0, 2.0) = 1.0;
uniform float saturation : hint_range(0.0, 2.0) = 1.0;

// RGB to Luminance (for saturation)
float luminance(vec3 color) {
	return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

void fragment() {
	vec4 c = texture(screen, SCREEN_UV);

	// Apply brightness (scale RGB)
	vec3 result = c.rgb * brightness;

	// Apply contrast (pivot around 0.5)
	result = (result - 0.5) * contrast + 0.5;

	// Apply saturation (lerp with luminance)
	float lum = luminance(result);
	result = mix(vec3(lum), result, saturation);

	COLOR = vec4(result, c.a);
}
