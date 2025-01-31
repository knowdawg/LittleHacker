shader_type canvas_item;

void fragment() {
	vec2 mUV = abs(UV - vec2(0.5)) + vec2(0.5);
	vec4 c = texture(TEXTURE, UV);

	float val = (1.0 - (mUV.x * mUV.y * 2.0));
	val *= 4.0;
	c.rgb *= val + 0.6;
	c.a = val;

	COLOR = c;
}
