shader_type canvas_item;

uniform vec2 resolution;

void fragment() {
	vec2 quv = floor(UV * resolution) / resolution;
	float a = fract(sin(dot(quv, vec2(12.9898, 78.233) * TIME)) * 438.5453) * 1.9;
	a -= 0.5;
	COLOR.rgb = vec3(a);
}