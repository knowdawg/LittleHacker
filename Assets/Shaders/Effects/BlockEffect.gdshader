shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec4 color : source_color;

void fragment() {
	vec4 c = vec4(1.0);
	c.a = texture(noise, UV + vec2(0.0, -TIME * 0.2)).r;

	c.a -= smoothstep(0.0, 0.5, abs(UV.y - 0.5));
	c.a -= 1.0 - floor(clamp(UV.y * 2.0, 0.0, 1.0));

	c.a = step(0.5, c.a);

	c *= color;
	COLOR = c;
}

