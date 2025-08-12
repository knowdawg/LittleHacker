shader_type canvas_item;

uniform sampler2D cloudNoise : repeat_enable, filter_linear;
uniform sampler2D cloudWarp : repeat_enable, filter_linear;
uniform vec2 resolution;
uniform float speed : hint_range(0.0, 20.0, 0.1);
uniform float cloudFullness : hint_range(0.0, 1.0);
uniform float cloudPosition : hint_range(0.0, 1.0);
uniform float xDisplacment : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec2 qUV = round((UV + vec2(xDisplacment, 0.0)) * resolution) / resolution;
	vec4 c = vec4(1.0);
	float nWarp = texture(cloudNoise, qUV + vec2(speed * TIME * 0.005, 0.0)).r;
	float n = texture(cloudNoise, qUV + vec2(speed * TIME * 0.001 + nWarp, 0.0)).r;
	n -= abs(qUV.y - cloudPosition) * 1.0;
	n *= cloudFullness * 2.0;
	n = smoothstep(0.0, 1.0, n);

	c = vec4(n);

	COLOR *= c;
}
