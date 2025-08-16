extends State

@export var animator : AnimationPlayer


func enter(_p):
	animator.play("Death")
