extends Node2D
class_name EnemyParriedComponent

@export var attackComponents : Array[AttackComponent] = []
@export var stateMachine : StateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for a in attackComponents:
		a.gotParried.connect(onEnemyParried)

func onEnemyParried(_attack : Attack):
	if stateMachine:
		if stateMachine.current_state.has_method("canParry"):
			if !stateMachine.current_state.canParry():
				return
		if stateMachine.current_state.has_method("getParryState"):
			stateMachine.switchStates(stateMachine.current_state.getParryState().name)
