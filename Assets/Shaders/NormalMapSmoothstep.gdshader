shader_type canvas_item;

void light() {
	float cNdotL = max(0.0, dot(NORMAL, LIGHT_DIRECTION));
	//cNdotL = smoothstep(0.0, 0.5, cNdotL);
	vec4 l = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY * cNdotL, LIGHT_COLOR.a);
	LIGHT = l;
}
