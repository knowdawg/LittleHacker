shader_type canvas_item;

uniform vec2 mesh[500];

void vertex() {
	VERTEX = mesh[VERTEX_ID];
	//VERTEX.x += sin(TIME * VERTEX.y * 0.1);
}

//void fragment() {
	//vec4 c = vec4(UV.x, UV.y, 1.0, 1.0);
//
	//vec4 t = texture(TEXTURE, UV);
	//c = t;
//
	//COLOR = c;
//}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
