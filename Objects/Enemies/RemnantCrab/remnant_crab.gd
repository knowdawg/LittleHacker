extends CharacterBody2D
class_name RemnantCrab


#func _ready() -> void:
	#%Animator.play("Stomp")


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
