extends AudioStreamPlayer2D
class_name RandomPitchAudio

@export var pitchRange := Vector2(0.9, 1.1)

func playSound():
	pitch_scale = randf_range(pitchRange.x, pitchRange.y)
	play()
