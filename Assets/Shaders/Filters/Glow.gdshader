shader_type canvas_item;


uniform float BLOOM_THRESHOLD : hint_range(0.0, 1.0, 0.1);
uniform float BLOOM_INTENSITY = 3.0;

uniform int BLUR_ITERATIONS = 3;
uniform float BLUR_SIZE = 0.03;
uniform int BLUR_SUBDIVISIONS = 32;

vec4 getHDR(vec4 tex) {
    return max((tex - BLOOM_THRESHOLD) * BLOOM_INTENSITY, vec4(0.0));
}

vec4 gaussian(sampler2D sampler, vec2 uv) {
    vec4 sum = vec4(0.0);

    for (int i = 1; i <= BLUR_ITERATIONS; i++) {
        float angle = 360.0 / float(BLUR_SUBDIVISIONS);

        for (int j = 0; j < BLUR_SUBDIVISIONS; j++) {
            float dist = BLUR_SIZE * float(i + 1) / float(BLUR_ITERATIONS);
            float s = sin(angle * float(j));
            float c = cos(angle * float(j));

            sum += getHDR(texture(sampler, uv + vec2(c, s) * dist));
        }
    }

    sum /= float(BLUR_ITERATIONS * BLUR_SUBDIVISIONS);
    return sum * BLOOM_INTENSITY;
}

vec3 blend(vec3 a, vec3 b) {
    return 1.0 - (1.0 - a) * (1.0 - b);
}

void fragment() {
    vec4 tx = texture(TEXTURE, UV);
    vec4 result = gaussian(TEXTURE, UV);

	vec4 bg = result;

    float gray = dot(bg.rgb, vec3(0.299, 0.587, 0.114));
    bg = vec4(bg.rgb, gray * bg.a);

	vec4 final = bg;

	final = bg + tx;
	
	
    COLOR = final;
}