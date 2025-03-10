shader_type canvas_item;


uniform float width : hint_range(0.0, 1.0, 0.1);
uniform float outlineAlpha : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 c = texture(TEXTURE, UV);

	vec4 left = texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x * width, 0));
	vec4 right = texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x * width, 0));
	vec4 up = texture(TEXTURE, UV + vec2(0, -TEXTURE_PIXEL_SIZE.y * width));
	vec4 down = texture(TEXTURE, UV + vec2(0, TEXTURE_PIXEL_SIZE.y * width));

	float alpha = left.a + right.a + up.a + down.a;
	vec3 avColor = left.rgb * left.a + right.rgb * right.a + up.rgb * up.a + down.rgb * down.a;
	avColor = avColor / alpha;
	avColor = vec3(1.0) - avColor;

	if(c.a == 0.0){
		c = vec4(avColor, clamp(alpha, 0.0, 1.0) * outlineAlpha);
	}


	COLOR.rgb = c.rgb;
	COLOR.a = c.a;
}