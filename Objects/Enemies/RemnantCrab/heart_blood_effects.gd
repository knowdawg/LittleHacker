extends Node2D

@export var stateMachine : RemnantCrabStateMachine

func _process(_delta: float) -> void:
	if stateMachine.phase == 1:
		visible = false
	if stateMachine.phase == 2:
		visible = true
