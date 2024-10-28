shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform float progress : hint_range(0.0, 2.0);
uniform float intensity : hint_range(-10.0, 10.0);

void fragment() {
	//Convert to Clip Space
	vec2 clipUV = UV * 2.0 - 1.0;
	vec2 iResolution = 1.0 / TEXTURE_PIXEL_SIZE;
	clipUV.x *= iResolution.x / iResolution.y;

	float ring = 1.0 - abs(length(clipUV) - progress);
	ring = smoothstep(0.9, 1.0, ring);

	vec2 offset = TEXTURE_PIXEL_SIZE * ring * normalize(clipUV);

	vec4 c = texture(SCREEN_TEXTURE, SCREEN_UV - offset * intensity);

	COLOR = c;
}