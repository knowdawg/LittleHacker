extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

var t := 0.0
func enter(_p : State):
	parent.climbing = true
	parent.set_collision_mask_value(1, false)
	parent.set_collision_mask_value(2, false)
	
	if %GeneralLadderProx.getAreas().size() > 0:
		parent.global_position.x = %GeneralLadderProx.getAreas()[0].global_position.x + 1.0
	elif %ExstendedReachForFalureToFind.getAreas().size() > 0:
		parent.global_position.x = %ExstendedReachForFalureToFind.getAreas()[0].global_position.x + 1.0
	
	
	t = 0.0
	animator.speed_scale = 2.0
	animator.play("MountLadder")

func update_physics(delta):
	t += delta
	
	#if Input.get_axis("Left", "Right") != 0.0:
		#if t >= 0.7:
			#trasitioned.emit(self, "Idle")
			#return
	
	#if t >= 0.7:
		#if Input.is_action_pressed("Down"):
			#trasitioned.emit(self, "SlideDown")
			#return
	
	if t >= 0.5:
		trasitioned.emit(self, "Climbing")
		return
	
	#if stateMachine.inputBuffer == "Jump":
		#trasitioned.emit(self, "Jump")
		#return
	
	#if Input.is_action_pressed("Down"):
		#trasitioned.emit(self, "SlideDown")
		#return

func moveParrent(amount : float):
	parent.position.y += amount

func exit(n : State):
	animator.speed_scale = 1.0
	if n is BigPlayerClimb or n is BigPlayerSlideDown:
		return
	parent.climbing = false
	parent.set_collision_mask_value(1, true)
	parent.set_collision_mask_value(2, true)
