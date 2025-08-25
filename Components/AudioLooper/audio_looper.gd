extends FollowAudio
class_name AudioLooper

@export_group("Sounds")
@export var startSound : AudioStream
@export var loopSound : AudioStream
@export var endSound : AudioStream

@export_group("AudioChildren")
@export var audioChildren : Array[AudioStreamPlayer2D]

func _ready() -> void:
	for a in audioChildren:
		a.volume_db = volume_db
		a.pitch_scale = pitch_scale
		a.max_distance = max_distance
		a.attenuation = attenuation
		a.bus = bus
	$Start.stream = startSound
	$Loop.stream = loopSound
	$End.stream = endSound

var endQueued : bool = false
func playSound():
	$Start.play()

func forceEnd():
	$Start.stop()
	$Loop.stop()
	$End.play()

func queueEnd():
	endQueued = true



func _on_start_finished() -> void:
	if endQueued:
		$End.play()
	else:
		$Loop.play()


func _on_loop_finished() -> void:
	if endQueued:
		$End.play()
	else:
		$Loop.play()


func _on_end_finished() -> void:
	pass
