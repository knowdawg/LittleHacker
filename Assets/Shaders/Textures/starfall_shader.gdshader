shader_type canvas_item;

uniform sampler2D noiseTex : repeat_enable;
uniform sampler2D noiseWarp : repeat_enable;

uniform vec2 resolution;

uniform float textureScollSpeed = 2.0;
uniform float warpScrollSpeed = 3.0;
uniform float surgeFrequency = 2.0;
uniform float surgeSpeed = 5.0;
uniform float surgeSize = 1.0;

void fragment() {
	vec2 quantizedUV = round(UV * resolution) / resolution;

	vec4 c = vec4(1.0);
	float surge = abs(sin(quantizedUV.x * surgeFrequency - TIME * surgeSpeed));
	vec4 nWarp = texture(noiseWarp, quantizedUV - vec2(TIME * warpScrollSpeed, 0.0));
	vec4 nTex = texture(noiseTex, quantizedUV + vec2(-TIME * textureScollSpeed + surge * 0.2, 0.0) + vec2(nWarp.x, nWarp.y));
	nTex.rgb += surge * 0.1;
	nTex.a -= smoothstep(0.2, 0.5, abs(quantizedUV.y - 0.5));
	float nTexAmplitude = (nTex.r + nTex.g + nTex.b) * 0.3 + (surge * surgeSize);
	nTex.a = smoothstep(0.4, 0.5, nTex.a + nTexAmplitude * 0.2);

	c = nTex;

	c *= 2.0;
	c.rgb = pow(c.rgb, vec3(3.0));

	COLOR *= c;
}
