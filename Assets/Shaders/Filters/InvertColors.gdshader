shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;

void fragment() {
	vec4 t = texture(TEXTURE, UV);
	vec4 c = texture(screen, SCREEN_UV);
	
	c.rgb = 1.0 - c.rgb;
	c.a *= t.a;
	
	COLOR = c;
}