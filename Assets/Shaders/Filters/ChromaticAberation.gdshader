shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;
uniform float offset :hint_range(0.0, 10.0) = 0.0;
uniform vec2 screenResolution = vec2(320.0, 180.0);

void fragment() {
	vec2 offsetAmount = vec2(1.0 / screenResolution.x, 1.0 / screenResolution.y) * offset;

	vec4 c = texture(TEXTURE, UV);

	float r = texture(screen, SCREEN_UV + vec2(offsetAmount.x, 0.0)).r;
	float g = texture(screen, SCREEN_UV + vec2(0.0, 0.0)).g;
	float b = texture(screen, SCREEN_UV + vec2(-offsetAmount.x, 0.0)).b;


	c.rgb = vec3(r,g,b);

	COLOR = c;
}
