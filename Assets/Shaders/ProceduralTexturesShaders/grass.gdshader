shader_type canvas_item;

uniform vec2 size;
global uniform sampler2D VelocityBuffer : filter_nearest;
global uniform vec2 CameraSnapDistance;
uniform sampler2D wind : filter_nearest, repeat_enable;

//void vertex(){
	//VERTEX.x += sin(TIME * 3.0 * (1.0 - UV.y));
	//VERTEX.y += sin(TIME * 10.0 * (1.0 - UV.y));
//}

void fragment() {
	vec4 v = texture(VelocityBuffer, SCREEN_UV + CameraSnapDistance);
	vec2 quantizedUV = floor(UV * size) / size;
	vec4 n = texture(wind, quantizedUV + TIME * 0.5) - 0.5;
	//v.r += sin(TIME * 3.0) * 0.1;
	vec2 offsetUV = quantizedUV + vec2(((v.r - 0.5) * 2.0) * (1.0 - quantizedUV.y), -abs(v.r - 0.5) * (1.0 - UV.y));

	vec4 c = texture(TEXTURE, offsetUV);

	COLOR = c;
}
