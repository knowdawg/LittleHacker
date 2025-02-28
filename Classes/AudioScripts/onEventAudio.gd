extends RandomPitchAudio


@export var randomizePitch : bool = true

@export var onHit : bool = false
@export var healthComponent : HealthComponent

func _ready() -> void:
	if onHit:
		healthComponent.hit.connect(hit)

func hit(_attack):
	if randomizePitch:
		playSound()
	else:
		play()
