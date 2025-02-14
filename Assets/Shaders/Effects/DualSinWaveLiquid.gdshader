shader_type canvas_item;

uniform vec4 waveColor : source_color;
uniform float amplitude : hint_range(0.0, 0.2, 0.01) = 0.1;
uniform float waveHieght : hint_range(0.0, 1.0) = 0.5;
uniform float waveSpeed : hint_range(0.0, 10.0, 0.1) = 7.0;
uniform float waveFrequency : hint_range(1.0, 10.0, 0.1) = 3.5;

void fragment() {
	vec4 c = vec4(1.0);

	float frontSin = sin(waveSpeed * TIME + UV.x * waveFrequency);
	frontSin += 1.0;
	frontSin *= 0.5;
	frontSin *= amplitude; //Wave Amplitude
	frontSin += waveHieght; //Wave hieght

	float backSin = cos(-waveSpeed * TIME + UV.x * waveFrequency);
	backSin += 1.0;
	backSin *= 0.5;
	backSin *= amplitude; //Wave Amplitude
	backSin += waveHieght; //Wave hieght

	if(UV.y < frontSin){
		c = texture(TEXTURE, UV);
		if(UV.y < backSin){
		}else{
			c = (c + waveColor) * 0.5;
		}
	}else{
		c = waveColor;
	}

	COLOR = c;
}
