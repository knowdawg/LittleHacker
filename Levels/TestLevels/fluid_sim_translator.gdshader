shader_type canvas_item;

void fragment() {
	float val = texture(TEXTURE, UV).b;

	COLOR = vec4(val, val, val, val);
}
