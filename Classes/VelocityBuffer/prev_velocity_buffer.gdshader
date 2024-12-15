shader_type canvas_item;

uniform sampler2D otherVierport;
uniform vec2 cameraMovementOffset;
uniform vec2 wind;

void fragment() {
	vec4 c = texture(otherVierport, UV + cameraMovementOffset);
	c.r = (c.r - 0.5) * 2.0;
	c.r *= 0.9;
	c.r = (c.r / 2.0) + 0.5;
	
	COLOR = c;
}