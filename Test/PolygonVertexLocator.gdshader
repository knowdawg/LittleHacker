shader_type canvas_item;
//
//void vertex() {
	//COLOR.r = VERTEX.x;
	//COLOR.g = VERTEX.y;
//}

void fragment() {
	float xDis = max(distance(UV.x, 0.0), distance(UV.x, 1.0));
	float yDis = max(distance(UV.y, 0.0), distance(UV.y, 1.0));
	float val = max(xDis, yDis);
	val = smoothstep(0.5, 1.0, val);
	val = step(0.9, val);

	COLOR.r = val;
	COLOR.gb = vec2(0.0, 0.0);
	//COLOR.rgb = vec3(UV.x, UV.y, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
