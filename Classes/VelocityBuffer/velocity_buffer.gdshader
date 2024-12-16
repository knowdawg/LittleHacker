shader_type canvas_item;

uniform sampler2D otherViewport;
uniform sampler2D screen : hint_screen_texture;

void fragment() {
	vec4 c = vec4(1.0);
	c = texture(screen, UV);

	vec4 o = texture(otherViewport, UV);
	if(c.r == 0.5 || c.r == 0.0){
		c.r = o.r;
	}
	if(o.g > c.g){
		c.g = o.g;
	}
	if(c.b != 1.0 && c.b != 0.2){
		c.b = o.b;
	}


	COLOR = c;
}
