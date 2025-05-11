extends State

@export var animator : AnimationPlayer
@export var afterImage : AfterImageComponent
@export var sound : RandomPitchAudio

func enter(_p):
	animator.play("Resonate")
	afterImage.setActive(true)
	sound.play()

func exit(_n):
	afterImage.setActive(false)
	sound.stop()
