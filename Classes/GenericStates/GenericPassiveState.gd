extends State
class_name GenericPassiveState

@export var animator : AnimationPlayer
@export var animationName : String = ""

func enter(_prevState):
	animator.play(animationName)
