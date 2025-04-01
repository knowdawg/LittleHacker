shader_type canvas_item;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	if(c.a > 0.5){
		c.rgb /= c.a;
		c.a = 1.0;
	}else{
		c.a = 0.0;
	}

	COLOR.rgb = c.rgb;
	COLOR.a = c.a;
}