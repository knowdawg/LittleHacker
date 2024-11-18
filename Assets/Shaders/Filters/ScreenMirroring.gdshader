shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;

void fragment() {
	vec4 c = vec4(1.0);

	float offset = 0.5;//(sin(TIME) + 1.0) * 0.25 * 0.5;
	//offset += 0.22;
	vec2 mirrorUV = vec2(abs(SCREEN_UV.x - offset) + offset, abs(SCREEN_UV.y - offset) + offset);
	c = texture(screen, mirrorUV);


	COLOR = c;
}
