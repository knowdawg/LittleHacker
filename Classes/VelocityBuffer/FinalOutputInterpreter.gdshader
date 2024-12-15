shader_type canvas_item;

uniform sampler2D curFrame : filter_nearest;
uniform vec2 size;

void fragment() {
	vec4 c = texture(curFrame, UV);// + vec2(0.5 / size.x, 0.5 / size.y));
	
	float r = (c.r - 0.5) * 2.0;
	if(abs(r) < 0.05){
		c.r = 0.5;
	}
	
	COLOR = c;
}

