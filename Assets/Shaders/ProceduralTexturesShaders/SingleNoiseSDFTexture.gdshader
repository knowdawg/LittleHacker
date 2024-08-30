shader_type canvas_item;

uniform sampler2D noiseTex : filter_nearest, repeat_enable;
uniform sampler2D palete;
uniform vec2 size;
uniform vec2 noiseResolution;

void fragment() {
	vec2 quantizedUV = floor(UV * size) / size;
	vec2 quatizedScreenUV = floor(SCREEN_UV * size) / size;

	float val = texture(noiseTex, (quantizedUV * size * 2.0) * (1.0 / noiseResolution)).r;

	float sdfVal = -texture_sdf(screen_uv_to_sdf(quatizedScreenUV));
	float alphaBuffer = step(0.0, sdfVal);
	//sdfVal = fract(1.0 - clamp(0.0, 1.0, sdfVal));

	//val += step(sdfVal, 1.0);
	val -= smoothstep(0.0, 1.0, sdfVal * (10.0 / size.x));

	val = ceil(val * 4.0) / 4.0;
	vec4 c = texture(palete, vec2(val, 1.0));
	c.a = alphaBuffer;

	///c.rgb = vec3(sdfVal);

	COLOR = c * texture(TEXTURE, UV);
}