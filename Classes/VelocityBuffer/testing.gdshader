shader_type canvas_item;



void fragment() {
	vec4 c = texture(TEXTURE, UV);

	//c.rg = vec2(0.0);

	COLOR = c;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
