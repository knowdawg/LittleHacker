shader_type canvas_item;

uniform vec2 center;
uniform float strength : hint_range(-1.0, 1.0);

void fragment() {
	float val = distance(UV, center);

	val = smoothstep(0.2, 1.0 - strength, val);

	COLOR = vec4(0.0, 0.0, 0.0, val);
}


