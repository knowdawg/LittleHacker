//BackgroundFog
shader_type canvas_item;
render_mode blend_premul_alpha; //Workaround for the godot bug with subviewports blending

uniform sampler2D fog;
uniform float depth : hint_range(0.0, 1.0);
uniform float darken : hint_range(0.0, 1.0) = 0.0;

uniform float u_radius : hint_range(0.0, 1.0) = 0.0;

vec4 blur(sampler2D image, vec2 uv, vec2 dir, vec2 tps) {
    vec4 color = texture(image, uv) * 0.2270270270; // Center weight

    // Optimized 4-tap Gaussian approximation
    vec2 offset1 = dir * u_radius * 1.3846153846 * tps;
    vec2 offset2 = dir * u_radius * 3.2307692308 * tps;

    color += texture(image, uv + offset1) * 0.3162162162;
    color += texture(image, uv - offset1) * 0.3162162162;
    color += texture(image, uv + offset2) * 0.0702702703;
    color += texture(image, uv - offset2) * 0.0702702703;

    return color;
}


void fragment() {
	vec4 f = blur(TEXTURE, UV, vec2(1.0, 0.0), TEXTURE_PIXEL_SIZE);
	f = mix(f, blur(TEXTURE, UV, vec2(0.0, 1.0), TEXTURE_PIXEL_SIZE), 0.5);

	vec4 fogColor = texture(fog, vec2(depth, 0.0)) * f.a;
	vec4 c = vec4(1.0);

	f.rgb = mix(f.rgb, vec3(dot(f.rgb, vec3(0.299, 0.587, 0.114))), 0.3 + (depth * 0.7));
	//f.rgb -= vec3(depth);
	f.rgb *= vec3(1.0 - darken);

	c = mix(f, fogColor, 0.0 + (depth * 1.0));
	//c = f;
	c.a = f.a;

	COLOR = c;
}
