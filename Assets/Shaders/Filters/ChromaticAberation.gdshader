shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;

void fragment() {
	vec2 offsetAmount = SCREEN_PIXEL_SIZE * 0.0;

	vec4 c = texture(TEXTURE, UV);

	float r = texture(screen, SCREEN_UV + vec2(0.0, offsetAmount.y)).r;
	float g = texture(screen, SCREEN_UV + vec2(offsetAmount.x, -offsetAmount.y)).g;
	float b = texture(screen, SCREEN_UV + vec2(-offsetAmount.x, -offsetAmount.y)).b;

	//c.r += (1.0 - r) * 0.5;
	//c.g += (1.0 - g) * 0.5;
	//c.b += (1.0 - b) * 0.5;

	COLOR = c;
}
