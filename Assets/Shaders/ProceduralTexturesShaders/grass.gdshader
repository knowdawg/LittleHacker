
shader_type canvas_item;

global uniform sampler2D VelocityBuffer : filter_nearest;

uniform float velocity_scale = 0.1; // Match this to your velocity buffer's scale
uniform float strength = 1.0;       // Reaction intensity (0.01-0.5)


void fragment() {
    // 1. Calculate screen-space UV (normalized)
    vec2 screen_uv = SCREEN_UV;

    // 2. Sample velocity and decode to [-1, 1] range
    vec2 velocity = (texture(VelocityBuffer, screen_uv).rg - 0.5) * 2.0;

    // 3. Offset the UV to distort the foliage texture
    vec2 distorted_uv = UV + velocity.gr * strength;

    // 4. Sample the foliage texture with distortion
    COLOR = texture(TEXTURE, distorted_uv);

    // DEBUG: Visualize velocity (comment out in final)
    // COLOR.rg = abs(velocity); // Red/Green = movement direction
}
