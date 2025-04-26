shader_type canvas_item;

uniform sampler2D positions_current;
uniform sampler2D positions_previous;
uniform sampler2D velocity_previous;  // Last frame's velocities
uniform float velocity_scale = 0.2;  
uniform float decay = 0.9;           // 0.9 = 10% fade per frame

void fragment() {
    // 1. Calculate raw velocity (can be negative)
    vec2 raw_vel = texture(positions_current, UV).rg - texture(positions_previous, UV).rg;
    vec2 new_velocity = raw_vel * velocity_scale;

    // 2. Decode last frame's velocity (from [0,1] to [-1,1] range)
    vec2 old_velocity = (texture(velocity_previous, UV).rg - 0.5) * 2.0;

    // 3. Blend with previous velocity (with fading)
    vec2 blended_velocity = mix(new_velocity, old_velocity, decay);

    // 4. Re-encode to [0,1] for storage
    COLOR.rg = blended_velocity * 0.5 + 0.5; // [-1,1] -> [0,1]
    COLOR.ba = vec2(0.5, 1.0);

    // DEBUG: Force-test directions (uncomment to verify)
    // COLOR.rg = vec2(0.0, 1.0);  // Green = up movement
    // COLOR.rg = vec2(1.0, 0.0);  // Red = right movement
    // COLOR.rg = vec2(0.0, 0.0);  // Black = left/down movement
}
