extends Enemy
class_name RemnantCrab


func _on_state_machine_state_switched(prevState: State, newState: State) -> void:
	print(newState.name)
	if newState.name == "StompRight":
		%Legs.flip_h = true
	if prevState:
		if prevState.name == "StompRight":
			%Legs.flip_h = false
	#if prevState:
		#print(prevState.name)

func _physics_process(delta: float) -> void:
	velocity.y += 1000.0 * delta
	
	if is_on_floor():
		if velocity.y > 0:
			velocity.y = 0
	
	move_and_slide()

func launch():
	velocity.y = -5000.0

func prepareForLanding():
	if Game.doesPlayerExist():
			global_position.x = Game.player.global_position.x

func launchLand():
	if %DownCast.is_colliding():
		global_position.y = %DownCast.get_collision_point().y - 23.0



var swordProjectile = preload("uid://c7xd4741m8qkc")
func createStompProjectile():
	var p : Projectile = swordProjectile.instantiate()
	p.speed = 240.0
	var offset := Vector2(0.0, 23.0)
	if %Legs.flip_h:
		p.dirVector = Vector2(1.0, 0.0)
		offset += Vector2(23.0, 0.0)
	else:
		p.dirVector = Vector2(-1.0, 0.0)
		offset += Vector2(-23.0, 0.0)
	p.flipH = %Legs.flip_h
	p.global_position = global_position + offset
	Game.addProjectile(p)

func shakeScreen(amount : float = 5.0):
	if Game.doesCameraExist():
		Game.camera.set_min_shake(amount)


func _on_jump_slam_got_parried(_a : Attack) -> void:
	if $StateMachine.current_state.name == "Jump":
		if Game.doesPlayerExist():
			Game.superParry(Game.player)
