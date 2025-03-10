shader_type canvas_item;

uniform vec4 color : source_color;

void fragment() {
	vec4 c = vec4(1.0);

	c -= abs(0.5 - UV.y) * 5.0;
	c = smoothstep(0.5, 2.0, c);
	c /= 0.05;

	c *= color;

	COLOR = c;
}

