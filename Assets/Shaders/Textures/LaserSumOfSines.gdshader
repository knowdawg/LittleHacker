shader_type canvas_item;

uniform sampler2D gradient;
uniform int numOfLasers = 4;

uniform float waveBaseSize = 1.0;
uniform float waveBaseSpeed = 1.0;
uniform float waveBaseFrequency = 1.0;

uniform float sizeMultiplier = 0.5;
uniform float speedMultiplier = 0.7;
uniform float frequencyMultiplier = 1.0;

uniform vec2 resolution = vec2(100.0, 100.0);

void fragment() {

	vec2 qUV = round(UV * resolution) / resolution;

	vec4 c = vec4(0.0);
	float multiplier = 1.0;
	float speed = 1.0;
	float freq = 1.0;
	for(int i = 1; i < numOfLasers + 1; i++){

		float val = 1.0;

		val = 1.0 - abs((0.5 + sin(qUV.x * waveBaseFrequency * freq - TIME * 10.0 * speed * waveBaseSpeed + (1.0 / multiplier)) * 0.1) - qUV.y);

		val = pow(val, 10.0 * (1.0 / multiplier));

		c += val;

		multiplier *= sizeMultiplier;
		speed *= speedMultiplier;
		freq *= frequencyMultiplier;
	}

	c = clamp(c, 0.0, 2.0);
	COLOR *= texture(gradient, vec2(c.r * 0.5));
}
