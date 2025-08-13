shader_type canvas_item;

uniform sampler2D image : repeat_enable, filter_nearest;
uniform float rotations : hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float depth : hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float shrinkSpeed : hint_range(-10.0, 10.0, 0.1) = -1.0;
uniform float roationSpeed : hint_range(-10.0, 10.0, 0.1) = 0.0;

uniform float shreekSpeed : hint_range(-25, 25.0) = 20.0;
uniform float shreekFreq : hint_range(0.0, 100.0) = 10.0;
uniform float shreekSize : hint_range(0.0, 1.0) = 0.5;

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

	float t = texture(image, vec2(polarUV.x + TIME * roationSpeed, polarUV.y + TIME * shrinkSpeed)).r;

	float dis = polarUV.y;
	//dis *= dis;

	float val = abs(sin(shreekFreq * dis - TIME * shreekSpeed));
	t = smoothstep(0.0, val * (1.5 - shreekSize), t);
	t = smoothstep(0.3, 1.0, t);
	t *= smoothstep(-0.1, 0.2, dis);

	COLOR *= vec4(t);
}
