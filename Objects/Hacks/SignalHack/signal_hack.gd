extends HackCommandComponent

@export var removeAfterExecuted : bool = false
@export var enemyHealthbar : EnemyHealthBar

func executeHack():
	if removeAfterExecuted:
		var index : int = enemyHealthbar.hackCommands.find(self)
		enemyHealthbar.hackCommands.remove_at(index)
	customExecute()
	
func customExecute():
	pass
