shader_type canvas_item;

uniform sampler2D noiseTex : filter_nearest, repeat_enable;
uniform sampler2D palete;
uniform float colors: hint_range(1.0, 20.0, 1.0);
uniform vec2 size;
uniform vec2 noiseResolution;

void fragment() {
	vec2 quantizedUV = floor(UV * size) / size;
	vec2 quatizedScreenUV = floor(SCREEN_UV * size) / size;

	float val = texture(noiseTex, (quantizedUV * size * 2.0) * (1.0 / noiseResolution)).r;

	float sdfVal = texture_sdf(screen_uv_to_sdf(quatizedScreenUV));

	//val -= smoothstep(0.0, 1.0, sdfVal * (3.0 / size.x));

	val = ceil(val * 4.0) / 4.0;
	vec4 c = texture(palete, round(colors * vec2(val, 1.0)) / colors);

	COLOR *= c * texture(TEXTURE, UV);
}