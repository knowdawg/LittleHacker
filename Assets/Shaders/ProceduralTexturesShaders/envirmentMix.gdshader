shader_type canvas_item;

uniform vec2 size;
uniform float blend : hint_range(0.0, 1.0);

uniform float paleteSize1 : hint_range(1.0, 10.0, 1.0);
uniform vec2 noiseResolution1;
uniform float shading1 : hint_range(0.0, 0.1);
uniform sampler2D noiseTex1 : filter_nearest, repeat_enable;
uniform sampler2D palete1;

uniform float paleteSize2 : hint_range(1.0, 10.0, 1.0);
uniform vec2 noiseResolution2;
uniform float shading2 : hint_range(0.0, 0.1);
uniform sampler2D noiseTex2 : filter_nearest, repeat_enable;
uniform sampler2D palete2;

void fragment() {
	vec2 quantizedUV = floor(UV * size) / size;
	vec2 quatizedScreenUV = floor(SCREEN_UV * size) / size;

	float sdfVal = -texture_sdf(screen_uv_to_sdf(quatizedScreenUV));
	float alphaBuffer = step(0.0, sdfVal);
	
	float mixVal = UV.x + blend - 0.5;
	
	//Sample the noise based on quantized UV
	float val1 = texture(noiseTex1, (quantizedUV * size * 2.0) * (1.0 / noiseResolution1)).r;
	float wieght1 = val1;
	val1 += step(sdfVal, 1.0); //Outline
	val1 -= smoothstep(0.0, 1.0, sdfVal * (shading1)); //Creates the Gradiant
	//Sample the palete based on Noise and SDF
	val1 = ceil(val1 * paleteSize1) / paleteSize1;
	vec4 c1 = texture(palete1, vec2(val1, 1.0));
	c1.a = alphaBuffer;
	
	
	//do it again for the other variables
	float val2 = texture(noiseTex2, (quantizedUV * size * 2.0) * (1.0 / noiseResolution2)).r;
	float wieght2 = val2;
	val2 += step(sdfVal, 1.0); //Outline
	val2 -= smoothstep(0.0, 1.0, sdfVal * (shading2)); //Creates the Gradiant
	//Sample the palete based on Noise and SDF
	val2 = ceil(val2 * paleteSize2) / paleteSize2;
	vec4 c2 = texture(palete2, vec2(val2, 1.0));
	c2.a = alphaBuffer;
	
	vec4 c = vec4(1.0);
	if((wieght1 + mixVal) > (wieght2)){
		c = c1;
	}else{
		c = c2;
	}
	

	COLOR = c * texture(TEXTURE, UV);

	//Show only SDFVal for Debug
	//COLOR.rgb = vec3(sdfVal) * shading;
	//COLOR.a = 1.0;
}