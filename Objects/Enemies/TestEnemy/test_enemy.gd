extends CharacterBody2D

func _process(_delta: float) -> void:
	pass

func hit(_attack):
	pass

func death(_attack):
	$StateMachine.switchStates("Dead")
	$AnimationPlayer.play("Death")
	$FlipPivot.visible = false

func parried(_attack : Attack):
	if $StateMachine.current_state.has_method("canParry"):
		if !$StateMachine.current_state.canParry():
			return
	$StateMachine.onChildTransition($StateMachine.current_state, "Parried")
	$FlipPivot/RotationPivot/AttackComponent.call_deferred("disable")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()
