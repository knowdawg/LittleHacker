shader_type canvas_item;

uniform int octave_count: hint_range(1, 20) = 10;
uniform float amp_start = 0.5;
uniform float amp_coeff = 0.5;
uniform float freq_coeff = 2.0;

uniform float glow : hint_range(0.0, 0.2) = 0.05;
uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform int numOfLight = 3; //keep odd
uniform float progressOffset : hint_range(0.0, 1.0) = 0.5;
uniform float seed : hint_range(0.0, 10.0, 0.1) = 0.0;

uniform vec2 resolution = vec2(20.0, 20.0);

vec2 hash22(vec2 uv) {
    uv = vec2(dot(uv, vec2(127.1,311.7)),
              dot(uv, vec2(269.5,183.3)));
    return 2.0 * fract(sin(uv) * 43758.5453123) - 1.0;
}

float noise(vec2 uv) {
    vec2 iuv = floor(uv);
    vec2 fuv = fract(uv);
    vec2 blur = smoothstep(0.0, 1.0, fuv);
    float val = (mix(mix(dot(hash22(iuv + vec2(0.0,0.0)), fuv - vec2(0.0,0.0)),
                   dot(hash22(iuv + vec2(1.0,0.0)), fuv - vec2(1.0,0.0)), blur.x),
               mix(dot(hash22(iuv + vec2(0.0,1.0)), fuv - vec2(0.0,1.0)),
                   dot(hash22(iuv + vec2(1.0,1.0)), fuv - vec2(1.0,1.0)), blur.x), blur.y));
	return val;// + 0.25 / amp_start;
}

float fbm(vec2 uv, int octaves) {
    float value = 0.0;
    float amplitude = amp_start;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * noise(uv);
        uv *= freq_coeff;
        amplitude *= amp_coeff;
    }
    return value;
}

void fragment() {
	vec4 c = vec4(0.0);
	vec2 qUV = ceil(UV * resolution) / resolution;
	float prog2 = (progress + progressOffset) > 1.0 ? fract(progress + progressOffset) : (progress + progressOffset);

	for (int i = 1; i < numOfLight + 1; i++) {
		float p = progress * float(numOfLight) - float(i) + 1.0;
		float p2 = prog2 * float(numOfLight) - float(i) + 1.0;

		p = clamp(p, 0.0, 1.0);
		p2 = clamp(p2, 0.0, 1.0);
		if(p == 0.0){
			p = 1.0;
		}
		if(p2 == 0.0){
			p2 = 1.0;
		}
		p = min(p, p2);


	    vec2 uv = 2.0 * qUV - 1.0;
	    uv += 2.0 * fbm(uv + float(i) + hash22(vec2(seed)), octave_count);
	    float dist = abs(uv.y);
	    float val = mix(glow, 0.0, p) / dist;

		c += val;
	}

	c.a = smoothstep(glow, 1.0, c.a);
	COLOR *= c;
}
