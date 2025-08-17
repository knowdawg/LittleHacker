shader_type canvas_item;

uniform sampler2D image : repeat_enable, filter_nearest;
uniform float rotations : hint_range(0.0, 10.0, 0.1) = 3.0;
uniform float shrinkSpeed : hint_range(-10.0, 10.0, 0.1) = -0.2;
uniform float roationSpeed : hint_range(-10.0, 10.0, 0.1) = 0.3;

uniform float shreekSpeed : hint_range(-25, 25.0) = 1.1;

uniform vec2 resolution;

uniform float progress : hint_range(0.0, 1.0);

vec2 toPolar(vec2 cartesian){
	float distance = length(cartesian);
	float angle = atan(cartesian.y, cartesian.x) + PI;
	return vec2(angle / (2.0 * PI), distance);
}

void fragment() {
	vec2 qUV = round(resolution * UV) / resolution;
	vec2 offsetUV = vec2(qUV.x - 0.5, qUV.y - 0.5);

	vec2 polarUV = toPolar(offsetUV);
	polarUV.x *= rotations;
	//polarUV.y *= depth;
	float dis = polarUV.y;


	vec4 c = vec4(0.0, 0.0, 0.0, 1.0);

	vec4 t = texture(image, vec2(polarUV.x + progress * roationSpeed, polarUV.y + progress * shrinkSpeed));
	t.a -= dis * 1.4;

	float val = abs(sin(dis - progress * shreekSpeed));
	t = smoothstep(0.0, val * 1.5, t);
	t = smoothstep(0.7, 1.0, t);


	c = t;

	COLOR = c;
}