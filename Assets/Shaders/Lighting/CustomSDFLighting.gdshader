shader_type canvas_item;
//render_mode light_only;

uniform sampler2D screen : hint_screen_texture;
uniform float brightness : hint_range(0.0, 1.0, 0.1);
uniform float shadowIntensitiy : hint_range(-1.0, 1.0, 0.1);

varying vec2 screenSize;
varying vec4 screenVal;

void fragment(){
	screenSize = SCREEN_PIXEL_SIZE;
	vec4 c = texture(screen, SCREEN_UV);
	screenVal = c;
	c.rgb *= vec3(brightness); //For darkness where no light
	COLOR = c;
}

//Called for each light for each pixel
void light() {
	//Setup the variables for SDF Raymarching
	vec2 lightPosNormalized = LIGHT_POSITION.xy * screenSize;
	vec2 angleVector = normalize(lightPosNormalized - SCREEN_UV);
	float sdfVal = 0.0;
	float intensity = 1.0;
	float distanceNeededToTravel = length(lightPosNormalized - SCREEN_UV);
	float disTraveled = 0.0;
	float sdfDistanceTraveled = 0.0;
	float falloff = 0.03; //0.01

	float finished = 0.0;

	//Marching Algorithm
	for(int i = 0; i < 80; i++){
		if(distanceNeededToTravel > 0.7){
			break;
		}
		if((disTraveled + 0.0) > distanceNeededToTravel){
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

		disTraveled += 0.005;//0.001//Bump the distance traveled to speed up the algorithm and to prevent the raymarching from moving zero every loop.
		//intensity += 0.005;
	}
	intensity *= finished;

	intensity = clamp(intensity, 0.0, 1.0);

	intensity = smoothstep(shadowIntensitiy, 1.0, intensity);

	LIGHT = vec4(LIGHT_COLOR.rgb * screenVal.rgb * intensity * LIGHT_ENERGY, LIGHT_COLOR.a);
}
