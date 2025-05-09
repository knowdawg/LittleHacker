shader_type canvas_item;

uniform sampler2D noiseTex : filter_nearest, repeat_enable;
uniform sampler2D palete;
uniform float paleteSize : hint_range(1.0, 10.0, 1.0);
uniform vec2 size;
uniform vec2 noiseResolution;
uniform float shading : hint_range(0.0, 0.1);
uniform float invert : hint_range(-1.0, 1.0, 2.0);

uniform bool warpBorder = false;
uniform sampler2D warpBorderNoise : repeat_enable;

void fragment() {
	vec2 quantizedUV = floor(UV * size) / size;
	vec2 quatizedScreenUV = floor(SCREEN_UV * size) / size;

	//Sample the noise based on quantized UV
	float val = texture(noiseTex, (quantizedUV * size * 2.0) * (1.0 / noiseResolution)).r;

	vec2 o = vec2(0.0);
	if(warpBorder){
		float v = texture(warpBorderNoise, quantizedUV).r;
		v = (v - 0.5) * 2.0 * 10.0;
		o = vec2(v, v * 0.3);
	}
	float sdfVal = invert * texture_sdf(screen_uv_to_sdf(quatizedScreenUV) + o);

	float alphaBuffer = step(0.0, sdfVal);

	val += step(sdfVal - 0.5, 1.0); //Outline
	val -= smoothstep(0.0, 1.0, sdfVal * (shading)); //Creates the Gradiant

	//Sample the palete based on Noise and SDF
	val = ceil(val * paleteSize) / paleteSize;
	vec4 c = texture(palete, vec2(val, 1.0));
	c.a = alphaBuffer;

	COLOR = c * texture(TEXTURE, UV);

	//Show only SDFVal for Debug
	//COLOR.rgb = vec3(sdfVal) * shading;
	//COLOR.a = 1.0;
}