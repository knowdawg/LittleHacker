shader_type canvas_item;

uniform sampler2D text : repeat_enable, filter_nearest;
uniform float widthOfRope : hint_range(0.0, 25.0);
uniform float widthOfTexture : hint_range(0.0, 100.0);

void fragment() {
	vec4 c = vec4(1.0);

	vec4 t = texture(text, UV * widthOfRope / widthOfTexture);
	c = t;

	COLOR = c;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
