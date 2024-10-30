extends CharacterBody2D

@export var movementComponent : MovementComponent

func _process(_delta: float) -> void:
	pass

func hit(_attack):
	pass

func hitFromRight(attack : Attack):
	movementComponent.applyForce(Vector2(-1, 0), attack.knockback_force)

func hitFromLeft(attack : Attack):
	movementComponent.applyForce(Vector2(1, 0), attack.knockback_force)

func death(_attack):
	$StateMachine.switchStates("Dead")
	$AnimationPlayer.play("Death")
	$FlipPivot.visible = false

func parried(_attack : Attack):
	if $StateMachine.current_state.has_method("canParry"):
		if !$StateMachine.current_state.canParry():
			return
	if $StateMachine.current_state.has_method("getParryState"):
		$StateMachine.onChildTransition($StateMachine.current_state, $StateMachine.current_state.getParryState().name)
	else:
		$StateMachine.onChildTransition($StateMachine.current_state, "Parried")
	$FlipPivot/RotationPivot/AttackComponent.call_deferred("disable")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()
