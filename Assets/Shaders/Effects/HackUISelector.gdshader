shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec4 color : source_color;
uniform sampler2D screen : hint_screen_texture;
uniform float progress : hint_range(0.0, 1.0);

void fragment() {
	vec4 c = texture(screen, SCREEN_UV);
	c.rgb = 1.0 - c.rgb;
	vec4 n = texture(noise, UV + vec2(-TIME * 1.0, 0));

	c.a = n.r;
	c.a += (1.0 - UV.x);
	c.a -= smoothstep(0.8, 1.0, 1.0 - UV.x) * 2.0;
	c.a -= UV.x * 0.5;
	c.a -= abs(0.5 - UV.y) * 2.0;

	c.a = step(0.2, c.a);

	COLOR = c;
}
