shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D pallete;
uniform float speed;

void fragment() {
	vec4 c = vec4(1.0);
	vec4 n = texture(noise, UV + vec2(TIME * 0.001 * speed, 0.0));
	n = texture(pallete, vec2(n.r, 0.0));
	c = n;

	COLOR = c;
}
