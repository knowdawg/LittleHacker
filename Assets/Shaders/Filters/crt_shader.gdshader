shader_type canvas_item;
render_mode unshaded;

uniform float pixelsWidth : hint_range(1, 2000);
uniform float pixelsHight : hint_range(1, 2000);

vec2 curve(vec2 uv){
	uv = (uv - 0.5) * 2.0;
	uv *= 1.1;
	uv.x *= 1.0 + pow((abs(uv.y) / 16.0 * 1.0), 2.0);
	uv.y *= 1.0 + pow((abs(uv.x) / 9.0 * 1.0), 2.0);
	uv  = (uv / 2.0) + 0.5;
	uv =  uv * 0.90 + 0.04;
	return uv;
}

void fragment() {
	//Simulate CRT screen curve
	vec2 curvedUV = UV;//curve(UV);
	vec4 ogScreen = texture(TEXTURE, curvedUV);

	//Calculate the corresponding r, g, b values for current UV based on a sin wave with frequency equal to the number of pixels
	float r = texture(TEXTURE, curvedUV).r * pow(abs(sin(1.0 + pixelsHight * (curvedUV.y * PI))), 0.08);
	float g = texture(TEXTURE, curvedUV).g * pow(abs(sin(1.0 + pixelsHight * (curvedUV.y * PI) + (2.0 * PI)/3.0)), 0.08);
	float b = texture(TEXTURE, curvedUV).b * pow(abs(sin(1.0 + pixelsHight * (curvedUV.y * PI) + (4.0 * PI)/3.0)), 0.08);

	//CRT electron gun 'scanner' effect
	float scanner = 1.0 - fract(TIME * 0.3 - curvedUV.y);
	scanner = smoothstep(0.7, 1.0, scanner);
	scanner *= 0.01;

	//Verticle seperators
	float seperator = abs(sin(0.667 + pixelsWidth * (curvedUV.x * PI)));
	seperator = smoothstep(0.95, 1.0, seperator);
	seperator *= 0.01;

	//Light Vinete effect
	float darkEdges = distance(vec2(0.5, 0.5), curvedUV);
	darkEdges = 1.0 - smoothstep(0.9, 1.0, darkEdges);

	vec4 c = mix(vec4(r,g,b,1.0), ogScreen, 1.0 - distance(UV, vec2(0.5, 0.5)));
	c.rgb += scanner;
	c.rgb -= seperator;
	c.rgb *= darkEdges;

	//COLOR = c;
}
