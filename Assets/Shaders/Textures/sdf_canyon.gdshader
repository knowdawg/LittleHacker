shader_type canvas_item;

uniform float FOV : hint_range(0.0, 30.0);
uniform vec3 cameraPos;
uniform float hRes;
uniform float vRes;
uniform vec3 color : source_color;
uniform float xDisplacemnt : hint_range(-1.0, 1.0, 0.1);
uniform sampler2D pallete;

uniform sampler2D tex : filter_nearest, repeat_enable;

float sdBox( vec3 p, vec3 b ){
  vec3 q = abs(p) - b;
  return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}

float sdfPlane(vec3 pos, vec3 norm, float height){
	return dot(pos, norm) + height;
}

float smin(float a, float b, float k){
	float h = max(k - abs(a-b), 0.0) / k;
	return min(a, b) - h * h * h * k * (1.0/6.0);
}

mat2 rot2D(float angle){
	float s = sin(angle);
	float c = cos(angle);
	return mat2(vec2(c, -s), vec2(s, c));
}

float map(vec3 pos){
	vec3 newPos = pos - vec3(0.0, pow(pos.z * 0.1, 4.0), 0.0);
	float t = -newPos.y + 1.0;
	float walls = sdBox(abs(newPos) - vec3(2.0, 0.0, 0.0), vec3(1.0, 1.0, 100.0));

	return(min(t,walls));
}

void fragment() {
	//Quantize
	vec2 qUV = vec2(floor((UV.x +  xDisplacemnt) * hRes) / hRes, floor(UV.y * vRes) / vRes);

	//Clip Space
	vec2 clipUV = qUV * 2.0 - 1.0;
	vec2 iResolution = 1.0 / TEXTURE_PIXEL_SIZE;
	clipUV.x *= iResolution.x / iResolution.y;

	//Initialization
	vec3 rayOrigin = cameraPos;
	vec3 rayDirection = normalize(vec3(clipUV, 1.0 / FOV));
	float totalDis = 0.0;
	vec3 c = vec3(0.0);
	float a = 0.0;
	vec3 p;

	//Raymarching
	for(int i = 0; i < 200; i++){
		p = rayOrigin + rayDirection * totalDis;
		float SDFdis = map(p);
		totalDis += SDFdis;


		if(SDFdis < 0.001){
			c = vec3(1.0);
			a = 1.0;
			break;
		}
		if(SDFdis > 100.0) break;
	}

	c = clamp(c, vec3(0.0), vec3(1.0));
	c *= color;

	vec4 t = texture(tex, p.zy * 0.5);
	c *= t.rgb;

	c = texture(pallete, vec2(c.r, 0.0)).rgb * 0.7;//(2.0 / totalDis);

	COLOR = vec4(c, a);
}