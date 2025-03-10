extends State
class_name PlayerDeath

@export var hurtboxToDisable : HurtboxComponent

func enter(_prevState):
	hurtboxToDisable.call_deferred("disable")
