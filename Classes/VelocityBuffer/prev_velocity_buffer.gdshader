shader_type canvas_item;

uniform sampler2D otherVierport;
uniform vec2 cameraMovementOffset;
uniform vec2 wind;

void fragment() {
	vec4 c = texture(otherVierport, UV + cameraMovementOffset);
	c.r = (c.r - 0.5) * 2.0;
	//c.g = (c.g - 0.5) * 2.0;
	
	c.r *= 0.9;
	
	//Good for going left to right
	c.r += sin((1.0 - c.g) * PI * 8.0) * 0.05 * c.g;
	
	//c.g = (c.g / 2.0) + 0.5;
	c.r = (c.r / 2.0) + 0.5;
	
	c.g -= 0.01;
	
	COLOR = c;
}