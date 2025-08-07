shader_type canvas_item;
render_mode unshaded;

uniform float pixelsWidth : hint_range(1, 2000) = 128.0;
uniform float pixelsHeight : hint_range(1, 2000) = 72.0;
uniform bool enable_scanlines = true;
uniform bool enable_color_bleed = true;

void fragment() {
    // Mild vignette (softer than original)
    float vignette = 1.0 - smoothstep(0.7, 1.3, distance(UV, vec2(0.5, 0.5)));
    vignette = mix(1.0, vignette, 0.3); // Reduced strength

    // Sample original color
    vec4 color = texture(TEXTURE, UV);

    // Subtle color bleed (optional)
    if (enable_color_bleed) {
        vec2 bleed_uv = UV + vec2(0.001, 0.0);
        vec4 bleed_color = texture(TEXTURE, bleed_uv);
        color = mix(color, bleed_color, 0.1);
    }

    // Soft scanlines (optional)
    if (enable_scanlines) {
        float scanline = sin(UV.y * pixelsHeight * 3.14159) * 0.01 + 0.9;
        color.rgb *= scanline * 0.7 + 0.3; // Less contrast
    }

    // Apply vignette
    color.rgb *= vignette;

    COLOR = color;
}