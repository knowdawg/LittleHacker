shader_type canvas_item;
render_mode light_only;

uniform sampler2D screen : hint_screen_texture;

varying vec2 screenSize;

void fragment(){
	screenSize = SCREEN_PIXEL_SIZE;
	vec4 c = texture(screen, SCREEN_UV);

	//c = vec4(vec3(0.1), 0.1);
	COLOR = c;
}

void light() {
	vec2 lightPosNormalized = LIGHT_POSITION.xy * screenSize;
	vec2 angleVector = normalize(lightPosNormalized - SCREEN_UV);

	float sdfVal = 0.0;
	float intensity = 1.0;
	float distanceNeededToTravel = length(lightPosNormalized - SCREEN_UV);
	float disTraveled = 0.0;
	float sdfDistanceTraveled = 0.0;
	float falloff = 0.03;

	float finished = 0.0;
	for(int i = 0; i < 200; i++){
		if(disTraveled > distanceNeededToTravel){
			finished = 1.0;
			break;
		}
		if(intensity <= 0.0){
			break;
		}
		vec2 curPos = SCREEN_UV + (angleVector * disTraveled);
		sdfVal = texture_sdf(screen_uv_to_sdf(curPos));
		intensity += falloff * min(sdfVal, 0.0); //If sdfVal in negative, it is subtracted. If it is positive, nothing happens because of the min function
		disTraveled += screenSize.x * abs(sdfVal);
		disTraveled += 0.001;
	}
	intensity *= finished;

	intensity = clamp(intensity, 0.0, 1.0);
	LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * intensity * 4.0, LIGHT_COLOR.a);
}
