shader_type canvas_item;

uniform sampler2D otherVierport;
uniform vec2 cameraMovementOffset;
uniform vec2 wind;

void fragment() {
	vec4 c = texture(otherVierport, UV + cameraMovementOffset);
	c.r = (c.r - 0.5) * 2.0;
	c.b = (c.b - 0.5) * 2.0;

	c.r *= 0.9;
	//c.b *= 0.9;
	float mul = 1.0;
	if(c.b > 0.0){
		mul *= -1.0;
	}
	c.r += mul * sin((1.0 - c.g) * PI * 8.0) * 0.05 * c.g;

	c.b = (c.b / 2.0) + 0.5;
	c.r = (c.r / 2.0) + 0.5;

	c.g -= 0.0025;
	//c.b = 1.0;

	COLOR = c;
}