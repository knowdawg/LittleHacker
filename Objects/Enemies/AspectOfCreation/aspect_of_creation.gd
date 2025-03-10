extends CharacterBody2D


func _on_smash_got_parried(_attack) -> void:
	$HumanSprite/SpriteDirectorComponent.lookAtPlayer()
	$BigHands.fadeOut()
	$StateMachine.call_deferred("switchStates", "SlamFollowUp")
	

func _on_punch_got_parried(_attack) -> void:
	if $StateMachine.current_state.name == "SlamFollowUp":
		Game.superParry(self)


func _on_state_machine_state_switched(_prevState, newState : State) -> void:
	if newState.name == "Shellify":
		var hackedState : GenericEnemyHackedState = $StateMachine/Hacked
		hackedState.animationName = "ShellHack"
		hackedState.nextState = $StateMachine/Shell
		hackedState.nextStateOnHack = $StateMachine/Shell
		
		$GeneralComponents/EnemyHeathbar/LifeDrainHeal.disable()

func _on_evicerate_hack_executed() -> void:
	var hackedState : GenericEnemyHackedState = $StateMachine/Hacked
	hackedState.animationName = "Stun"
	hackedState.nextState = $StateMachine/Idle
	hackedState.nextStateOnHack = $StateMachine/Idle
	$GeneralComponents/HealthComponent.locked = false
	
	$GeneralComponents/EnemyHeathbar/LifeDrainHeal.enable()

func _on_health_component_on_lock_hit(_lockName : String) -> void:
	$StateMachine.switchStates("Shellify")
