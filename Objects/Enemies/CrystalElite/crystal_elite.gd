extends CharacterBody2D


func _process(delta: float) -> void:
	if %StateMachine.current_state.name == "DashDoubleSlash":
		if %DashDoubleSlash.t > 0.8 and %DashDoubleSlash.t < 1.0:
			%MovementComponent.lerpToPlayerX(delta * 10.0, 0.0)
	

func _on_spin_got_parried(_a) -> void:
	if %StateMachine.current_state.name == "SpinAttack":
		var dir : Vector2 = %MovementComponent.getVectorToPlayerX(global_position, true)
		%MovementComponent.applyForce(dir, 200.0)


func setXPosToPlayerXPos():
	if Game.doesPlayerExist():
		global_position = Game.player.global_position

func _on_spin_finisher_got_parried(_a) -> void:
	if %StateMachine.current_state.name == "SpinAttack":
		Game.superParry(self)


func _on_dive_trasitioned(_p, _n) -> void:
	setXPosToPlayerXPos()


func _on_re_dive_trasitioned(_p, _n) -> void:
	setXPosToPlayerXPos()


func _on_sword_poke_trasitioned(_p, _n) -> void:
	setXPosToPlayerXPos()
