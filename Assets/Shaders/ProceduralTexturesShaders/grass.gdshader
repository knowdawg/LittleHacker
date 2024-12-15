shader_type canvas_item;

uniform vec2 size;
global uniform sampler2D VelocityBuffer : filter_nearest;

//void vertex(){
	//VERTEX.x += sin(TIME * 3.0 * (1.0 - UV.y));
	//VERTEX.y += sin(TIME * 10.0 * (1.0 - UV.y));
//}

void fragment() {
	vec4 v = texture(VelocityBuffer, SCREEN_UV);
	vec2 quantizedUV = floor(UV * size) / size;
	vec2 offsetUV = quantizedUV + vec2((v.r - 0.5) * 2.0 * (1.0 - quantizedUV.y), 0.0);
	
	vec4 c = texture(TEXTURE, offsetUV);
	
	COLOR = c;
}
