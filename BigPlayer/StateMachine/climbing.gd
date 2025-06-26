extends State
class_name BigPlayerClimb

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var topOfLadderProx : ProximityAreaComponent

func enter(p : State):
	if !p is BigPlayerSlideDown:
		parent.climbing = true
		parent.set_collision_mask_value(1, false)
		parent.set_collision_mask_value(2, false)
	
	if topOfLadderProx.getAreas().size() > 0:
		parent.global_position.x = topOfLadderProx.getAreas()[0].global_position.x
	animator.play("Climb")

func update_physics(delta):
	if Input.is_action_pressed("Up"):
		animator.play("Climb")
	else:
		animator.pause()
	
	if Input.is_action_pressed("Roll"):
		animator.speed_scale = 2.0
	else:
		animator.speed_scale = 1.0
	
	if stateMachine.inputBuffer == "Jump":
		trasitioned.emit(self, "Jump")
		return
	
	if Input.is_action_pressed("Down"):
		trasitioned.emit(self, "SlideDown")
		return
	
	if Input.is_action_pressed("Up"):
		if topOfLadderProx.getAreas().size() == 0:
			#Pull Self Up
			trasitioned.emit(self, "PullUp")
			return
	

func snapToRung():
	parent.global_position.y = round(parent.global_position.y)
	if topOfLadderProx.getAreas().size() > 0:
		parent.global_position.y += topOfLadderProx.getAreas()[0].getNearestRung(parent, -15.0)
	

func moveParrent(amount : float):
	parent.position.y -= amount

func exit(n : State):
	animator.speed_scale = 1.0
	if n is BigPlayerSlideDown or n is BigPlayerPullUp:
		return
	parent.climbing = false
	parent.set_collision_mask_value(1, true)
	parent.set_collision_mask_value(2, true)
