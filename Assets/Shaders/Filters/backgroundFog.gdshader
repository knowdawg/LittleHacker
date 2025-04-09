shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;
uniform sampler2D fog;
uniform float depth : hint_range(0.0, 1.0);

void fragment() {
	vec4 s = texture(TEXTURE, UV);
	vec4 fogColor = texture(fog, vec2(depth, 0.0));
	vec4 c = vec4(1.0);

	c.rgb = mix(vec3(dot(s.rgb, vec3(0.299, 0.587, 0.114))), s.rgb, 1.0 - depth);

	c = mix(c, fogColor, depth);

	COLOR.rgb = c.rgb;
}
