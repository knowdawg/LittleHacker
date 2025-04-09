shader_type canvas_item;

uniform sampler2D noise1 : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform vec4 color : source_color;

void fragment() {
	vec4 c = vec4(1.0);
	vec4 n1 = texture(noise1, UV + vec2(TIME * 1.0, 0.0));
	vec4 n2 = texture(noise2, UV + n1.r + vec2(-TIME * 0.5, 0.0));

	float val = n2.r;
	val -= abs(0.5 - UV.y) * 2.0;
	//val = smoothstep(0.0, 0.5, val);

	c.a = val;
	c *= color;

	COLOR = c;
}
