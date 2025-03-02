shader_type canvas_item;

uniform sampler2D blurNoise : repeat_enable;
uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap;
uniform vec2 blurCenter = vec2(0.5, 0.5);
uniform float disToCenter : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform vec3 color : source_color;
uniform float blackWhiteStepVal : hint_range(0.0, 1.0);
uniform float progress : hint_range(0.0, 1.0);


vec2 toPolar(vec2 uv){
	vec2 clipUV = (uv * 2.0) - vec2(1.0);

	vec2 polarUV = vec2(0.0);
	polarUV.x = distance(clipUV, blurCenter);
	polarUV.y = atan((uv.y - blurCenter.y) / (uv.x - blurCenter.x));
	return vec2(polarUV);
}

void fragment() {
	vec2 qUV = round(UV * vec2(128, 72)) / vec2(128, 72);
	float n = texture(blurNoise, toPolar(qUV)).r;

	float dis = distance(qUV, blurCenter);
	float dis2 = dis;
	dis *= n;
	dis *= (1.0 - disToCenter);
	dis = smoothstep(0.05, 1.0, dis);
	dis *= 6.0;

	vec4 s = texture(screen, SCREEN_UV);
	float v = s.r + s.g + s.b;
	v /= 3.0;
	v = step(blackWhiteStepVal, v);
	vec4 blackS = vec4(vec3(v), 1.0);

	s = mix(blackS, s, progress);


	COLOR = vec4(color * dis, dis) + s;
}
