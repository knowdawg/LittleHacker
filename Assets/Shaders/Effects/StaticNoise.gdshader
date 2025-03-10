shader_type canvas_item;

uniform float amount = 40.0;

void fragment() {
	vec2 quv = floor(UV * vec2(128.0, 72.0)) / vec2(128.0, 72.0);
	float a = fract(sin(dot(quv, vec2(12.9898, 78.233) * TIME)) * 438.5453) * 1.9;
	a -= 0.5;
	COLOR.rgb = vec3(a);
}