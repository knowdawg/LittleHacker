shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec4 col : source_color;
uniform float progress : hint_range(0.0, 1.0);

void fragment() {
	vec4 c = vec4(1.0);
	float n = texture(noise, UV + vec2(progress * 0.4 - TIME, 0.0)).r;
	n += (1.0 - abs(UV.y - 0.5)) * 0.7;
	n -= abs(UV.y - 0.5) * 2.0;

	float leftEdge = smoothstep(0.0, 1.0 - progress, UV.x);
	float rightEdge = smoothstep(0.0, progress * 3.0, 1.0 - UV.x);
	n *= leftEdge;
	n *= rightEdge;

	n *= smoothstep(0.0, 0.1, 1.0 - progress);

	n = smoothstep(0.2, 1.0, n);

	c = vec4(n);
	c *= col;

	COLOR = c;
}
