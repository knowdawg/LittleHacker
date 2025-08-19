extends AudioStreamPlayer2D
class_name RandomAudioPlayer

@export var pitchRange := Vector2(0.9, 1.1)

@export var sounds : Array[AudioStream]

func playSound():
	stream = sounds[randi_range(0, sounds.size() - 1)]
	pitch_scale = randf_range(pitchRange.x, pitchRange.y)
	play()
