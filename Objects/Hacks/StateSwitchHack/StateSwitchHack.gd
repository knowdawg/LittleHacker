extends HackCommandComponent

@export var stateMachine : StateMachine
@export var stateToSwitchTo : State

func executeHack():
	stateMachine.switchStates(stateToSwitchTo.name)
