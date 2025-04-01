shader_type canvas_item;

uniform sampler2D noise1 : repeat_enable, filter_nearest;
uniform sampler2D pallete;

void fragment() {
	vec4 c = vec4(0.0, 0.0, 0.0, 1.0);
	float n1 = texture(noise1, UV + vec2(TIME * 4.0, 0.0)).r;

	n1 -= abs(UV.y - 0.5) * 2.0;
	n1 = smoothstep(-0.2, 0.1, n1);


	//n1 = 1.0 - step(0.1, n1);
	c.a = n1;
	c.rgb = texture(pallete, vec2(n1, 0.0)).rgb;

	COLOR = c;
}
