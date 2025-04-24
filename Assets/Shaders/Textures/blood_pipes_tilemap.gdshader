shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform float zoom = 1.0;

void fragment() {
	vec4 c = vec4(1.0);
	vec2 nDis = texture(noise2, zoom * UV).rg * 0.3;
	vec4 n = texture(noise, zoom * UV + vec2(TIME, 0.0) + nDis);
	
	float val = n.r * 0.2;
	
	COLOR.rgb -= val;
}
