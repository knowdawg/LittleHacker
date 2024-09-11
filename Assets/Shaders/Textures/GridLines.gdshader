shader_type canvas_item;

uniform float hLines : hint_range(1.0, 100.0, 0.1);
uniform float vLines : hint_range(1.0, 100.0, 0.1);

uniform vec4 col : source_color;

uniform float progress : hint_range(0.0, 1.0);

void fragment() {
	vec4 c = col;

	float val = abs(sin(PI * hLines * UV.y));
	val = 0.05 / val;

	float val2 = abs(sin(PI * vLines * UV.x + TIME * 1.0));
	val2 = 0.05 / val2;

	val += val2;
	val = clamp(val, 0.0, 1.0);

	val -= smoothstep(0.0, 0.5, UV.x);

	c.rgb *= val;
	c.a = c.r;
	c.a *= 1.0 - progress;
	c.a *= 0.5;

	COLOR = c;
}
