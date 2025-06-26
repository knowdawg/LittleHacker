extends State
class_name BigPlayerSlideDown

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var bottomOfLadderProx : ProximityAreaComponent

func enter(p : State):
	if !p is BigPlayerClimb:
		parent.climbing = true
		parent.set_collision_mask_value(1, false)
		parent.set_collision_mask_value(2, false)
	
	if bottomOfLadderProx.getAreas().size() > 0:
		parent.global_position.x = bottomOfLadderProx.getAreas()[0].global_position.x
	animator.play("SlideDown")

func update_physics(delta):
	parent.position.y += 120.0 * delta
	
	
	if stateMachine.inputBuffer == "Jump":
		trasitioned.emit(self, "Jump")
		return
	
	if Input.is_action_pressed("Up"):
		trasitioned.emit(self, "Climbing")
		return
	if !Input.is_action_pressed("Down"):
		trasitioned.emit(self, "Climbing")
		return
	
	if Input.is_action_pressed("Down"):
		if bottomOfLadderProx.getAreas().size() == 0:
			#Finish
			trasitioned.emit(self, "Land")
			return

func exit(n : State):
	if n is BigPlayerClimb:
		return
	parent.climbing = false
	parent.set_collision_mask_value(1, true)
	parent.set_collision_mask_value(2, true)
