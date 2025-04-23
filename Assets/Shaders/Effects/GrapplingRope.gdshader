shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0);

void fragment() {
	vec4 c = vec4(1.0);

	float offset = sin(5.0 * UV.x * UV.x * (1.0 - progress)) * UV.x * 0.04 * (1.0 - progress);

	c.a = 1.0 - abs(0.5 - UV.y + offset);
	c.a = step(0.95, c.a);

	COLOR = c;
}
