shader_type canvas_item;

// Wind settings
uniform float wind_speed = 2.0;
uniform float wind_strength = 0.1;
uniform float wind_frequency = 0.5;
uniform vec2 windDirection = vec2(1.0, 0.0);

void vertex() {
	if (UV.y < 0.5){
	    // 3. Wind effect (slow, continuous sway)
	    float wind = windDirection.x * abs(sin(TIME * wind_speed + VERTEX.x * wind_frequency) * wind_strength);
	    VERTEX.x += wind;

	    // Optional: Add slight vertical movement
	    VERTEX.y += abs(wind) * 0.3; // Plants lift slightly in wind

	}


}