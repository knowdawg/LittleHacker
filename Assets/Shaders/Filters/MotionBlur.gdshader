shader_type canvas_item;

uniform sampler2D blurNoise : repeat_enable;
uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap;
uniform vec2 blurCenter = vec2(0.5, 0.5);
uniform float blurIntensity : hint_range(0.0, 100.0) = 3.0;
uniform float disToCenter : hint_range(0.0, 1.0, 0.1) = 1.0;

vec2 toPolar(vec2 uv){
	vec2 clipUV = (uv * 2.0) - vec2(1.0);
	
	vec2 polarUV = vec2(0.0);
	polarUV.x = distance(clipUV, blurCenter);
	polarUV.y = atan((uv.y - blurCenter.y) / (uv.x - blurCenter.x));
	polarUV.y += TIME * 0.5;
	return vec2(polarUV);
}

void fragment() {
	float n = texture(blurNoise, toPolar(UV)).r;
	
	float dis = distance(SCREEN_UV, blurCenter);
	dis *= n;
	dis *= (1.0 - disToCenter)  * 2.0;
	dis = smoothstep(0.0, 0.3, dis);
	
	dis *= blurIntensity;
	
	vec4 c = textureLod(screen, SCREEN_UV, dis);
	//c.rgb += n * dis * 0.01;
	
	COLOR = c;
}
