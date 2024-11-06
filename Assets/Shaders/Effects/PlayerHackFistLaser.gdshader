shader_type canvas_item;

uniform vec4 color : source_color;
uniform sampler2D noise : repeat_enable;
uniform float progress : hint_range(0.0, 1.0);

void fragment() {
	vec4 r = color;
	vec4 b = texture(noise, UV + vec2(-TIME  * 5.5, 0.0));

	r.a = b.r;
	r.a -= smoothstep(0.5, 1.2, UV.x);
	r.a -= smoothstep(0.0, UV.x * 2.0, abs(UV.y - 0.5) * 2.0);

	r.a -= UV.x * (2.0 - progress * 2.0);

	r.a = smoothstep(0.0, 0.2, r.a);

	COLOR = r;
}
