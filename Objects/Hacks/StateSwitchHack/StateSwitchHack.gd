extends HackCommandComponent
class_name SwitchStateHack

@export var stateMachine : StateMachine
@export var stateToSwitchTo : State

@export var removeAfterExecuted : bool = false
@export_group("Revmoval Nodes")
@export var enemyHealthbar : EnemyHealthBar

func executeHack():
	stateMachine.switchStates(stateToSwitchTo.name)
	if removeAfterExecuted:
		var index : int = enemyHealthbar.hackCommands.find(self)
		enemyHealthbar.hackCommands.remove_at(index)
