shader_type canvas_item;

uniform sampler2D noise : repeat_enable;

void fragment() {
	float sdfVal = texture_sdf(screen_uv_to_sdf(SCREEN_UV));

	vec4 c = vec4(0.0);

	float n = texture(noise, UV + vec2(0.0, TIME * 0.1)).r;
	c.g += n * 0.5;
	if(sdfVal < 0.01){
		c.g = 1.0;
	}
	c.r = 0.0;
	c.b = 0.0;
	c.a = 1.0;

	COLOR = c;
}