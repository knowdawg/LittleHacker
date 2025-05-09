extends State

@export var animator : AnimationPlayer
@export var afterImage : AfterImageComponent

func enter(_p):
	animator.play("Resonate")
	afterImage.setActive(true)

func exit(_n):
	afterImage.setActive(false)
