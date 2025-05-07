extends Enemy


func _process(delta: float) -> void:
	if %StateMachine.current_state.name == "DashDoubleSlash":
		if %DashDoubleSlash.t > 0.8 and %DashDoubleSlash.t < 1.0:
			%MovementComponent.lerpToPlayerX(delta * 10.0, 0.0)

func _on_spin_got_parried(_a) -> void:
	if %StateMachine.current_state.name == "SpinAttack":
		var dir : Vector2 = %MovementComponent.getVectorToPlayerX(global_position, true)
		%MovementComponent.applyForce(dir, 200.0)


var swordProjectile = preload("uid://c7xd4741m8qkc")
func createSwordProjectile():
	var p : Projectile = swordProjectile.instantiate()
	p.speed = 240.0
	var offset := Vector2(0.0, 7.0)
	if %Sprite2D.flip_h:
		p.dirVector = Vector2(1.0, 0.0)
		offset += Vector2(16.0, 0.0)
	else:
		p.dirVector = Vector2(-1.0, 0.0)
		offset += Vector2(-16.0, 0.0)
	p.flipH = %Sprite2D.flip_h
	p.global_position = global_position + offset
	Game.addProjectile(p)


var growingCrystalProjectile = preload("uid://cpwipfxes1rm0")
func createGrowingCrystalProjectile():
	var p : Projectile = growingCrystalProjectile.instantiate()
	p.speed = 60.0
	var offset := Vector2(0.0, 7.0)
	if %Sprite2D.flip_h:
		p.dirVector = Vector2(1.0, 0.0)
		offset += Vector2(9.0, 0.0)
	else:
		p.dirVector = Vector2(-1.0, 0.0)
		offset += Vector2(-9.0, 0.0)
	p.global_position = global_position + offset
	Game.addProjectile(p)


func setXPosToPlayerXPos():
	if Game.doesPlayerExist():
		global_position.x = Game.player.global_position.x

func _on_spin_finisher_got_parried(_a) -> void:
	if %StateMachine.current_state.name == "SpinAttack" or %StateMachine.current_state.name == "Stun":
		Game.superParry(self)
		


func _on_dive_trasitioned(_p, _n) -> void:
	setXPosToPlayerXPos()


func _on_re_dive_trasitioned(_p, _n) -> void:
	setXPosToPlayerXPos()


func _on_sword_poke_trasitioned(_p, _n) -> void:
	return
	#setXPosToPlayerXPos()
	#if randf() > 0.5:
		#global_position.x += 14.0
	#else:
		#global_position.x -= 14.0

func _on_head_slam_got_parried(_a) -> void:
	pass
	#if $Animator.current_animation == "BackBreakCombo":
		#if %StateMachine.current_state.name == "BackBreakCombo" and $Animator.current_animation_position > 1.6:
			#Game.superParry(self)
