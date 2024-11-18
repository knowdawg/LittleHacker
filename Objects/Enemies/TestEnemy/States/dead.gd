extends State
class_name GenericEnemyDeath

@export var animator : AnimationPlayer
@export var animationName : String

func enter(_prevState):
	animator.play(animationName)
