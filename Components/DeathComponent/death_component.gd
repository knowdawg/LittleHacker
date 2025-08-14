extends Node2D
class_name DeathComponent

@export var healthComponent : HealthComponent

@export var stateMachine : StateMachine
@export var stateToSwitchTo : State

@export var dieOnHealthHitingZero : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dieOnHealthHitingZero:
		if healthComponent:
			healthComponent.death.connect(death)
		else:
			printerr("deathComponent does not have a valid healthComponent")

func death(_attack : Attack):
	if stateToSwitchTo and stateMachine:
		stateMachine.switchStates(stateToSwitchTo.name)
		
