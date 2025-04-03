shader_type canvas_item;

uniform vec2 mesh[500];
uniform bool pinned[500];

uniform float windAmplitude : hint_range(0.0, 20.0, 0.1) = 4.0;
uniform float windSpeed : hint_range(-5.0, 5.0, 0.1) = 1.5;
uniform float noiseScale : hint_range(0.0, 3.0) = 0.7;
uniform sampler2D noise : filter_nearest, repeat_enable;

varying vec2 noiseUV;

void vertex() {
	VERTEX = mesh[VERTEX_ID];
	bool pin = pinned[VERTEX_ID];

	noiseUV = UV + vec2(-TIME * windSpeed, TIME * windSpeed * 0.5);
	noiseUV *= noiseScale;
	float n = texture(noise, noiseUV).r - 0.5;

	vec2 chaotic_wind = vec2(n) * windAmplitude;

	if(!pin){
		VERTEX += chaotic_wind;
	}
}

void fragment() {
	vec4 c = vec4(UV.x, UV.y, 1.0, 1.0);
	c = texture(TEXTURE, UV);

	float t = texture(noise, noiseUV).r - 0.5;
	c.rgb -= c.rgb * t * clamp(windAmplitude * 0.1, 0.0, 0.5);

	COLOR = c;
}