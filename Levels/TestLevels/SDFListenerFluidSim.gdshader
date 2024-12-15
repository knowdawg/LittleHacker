shader_type canvas_item;

uniform sampler2D smoke : repeat_enable;

global uniform sampler2D VelocityBuffer;

void fragment() {
	float sdfVal = texture_sdf(screen_uv_to_sdf(SCREEN_UV));

	vec4 c = vec4(0.0);

	c = texture(smoke, UV);
	//c += texture(VelocityBuffer, SCREEN_UV);

	COLOR = c;
}