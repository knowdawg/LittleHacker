shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform float hFrames;
uniform vec2 spriteRes;
uniform float progess : hint_range(0.0, 1.0);

void fragment() {
	vec2 qUV = floor(UV * spriteRes * vec2(hFrames, 1.0)) / spriteRes;
	float n = texture(noise, qUV).r;

	vec4 c = texture(TEXTURE, UV);
	c.a *= n - progess;
	c.a = step(0.1, c.a);

	COLOR = c;
}
