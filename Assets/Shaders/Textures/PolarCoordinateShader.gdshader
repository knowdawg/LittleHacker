shader_type canvas_item;

uniform sampler2D image : repeat_enable, filter_nearest;
uniform float rotations : hint_range(0.0, 10.0, 0.1);
uniform float depth : hint_range(0.0, 10.0, 0.1);
uniform float shrinkSpeed : hint_range(-10.0, 10.0, 0.1);
uniform float roationSpeed : hint_range(-10.0, 10.0, 0.1);

uniform sampler2D s : hint_screen_texture;

uniform sampler2D haloColor;

void vertex(){
	VERTEX.x += sin(UV.x + TIME * 2.0) * 5.0;
	VERTEX.y += cos(UV.y + TIME * 2.0) * 5.0;
}

vec2 toPolar(vec2 cartesian){
	float distance = length(cartesian);
	float angle = atan(cartesian.y, cartesian.x) + PI;
	return vec2(angle / (2.0 * PI), distance);
}

void fragment() {
	vec2 offsetUV = vec2(UV.x - 0.5, UV.y - 0.5);

	vec2 polarUV = toPolar(offsetUV);
	polarUV.x *= rotations;
	polarUV.y *= depth;

	vec4 c = vec4(0.0, 0.0, 0.0, 1.0);

	float blackHole = smoothstep(0.1, 0.1, length(offsetUV));
	vec4 ring = texture(haloColor, vec2(smoothstep(0.7, 1.0, 1.0 - length(offsetUV)), offsetUV.y));
	vec4 t = texture(image, vec2(polarUV.x + TIME * roationSpeed, polarUV.y + TIME * shrinkSpeed));

	c = t;
	c += ring;
	c.rgb *= blackHole;
	c.a += 1.0 - blackHole;
	c.a -= smoothstep(0.3, 0.7, distance(UV, vec2(0.5, 0.5)));
	c.rgb *= ring.rgb;

	vec4 screen = texture(s, SCREEN_UV + offsetUV);
	//c = screen;

	COLOR = c;
}