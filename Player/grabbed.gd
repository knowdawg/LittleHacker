extends State
class_name PlayerGrabbed

@export var spriteAnimator : AnimationPlayer

func enter(_prevState):
	spriteAnimator.play("Stun")
