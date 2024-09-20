extends CharacterBody2D

func _process(_delta: float) -> void:
	pass

func hit(_attack):
	pass

func parried(_attack : Attack):
	$StateMachine.onChildTransition($StateMachine.current_state, "Parried")
	$Weapon/AttackComponent.call_deferred("disable")
