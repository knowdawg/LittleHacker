extends State
class_name BigPlayerSpeedIntoLadder


@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var ladderProx : ProximityAreaComponent

func enter(_p : State):
	t = 0.1
	animator.play("SprintIntoClimb")
	animator.seek(0.1)
	
	parent.climbing = true
	parent.set_collision_mask_value(1, false)
	parent.set_collision_mask_value(2, false)
	
	if ladderProx.getAreas().size() > 0:
		parent.global_position.x = ladderProx.getAreas()[0].global_position.x + 1.0
		snapToRung()
	elif %ExstendedReachForFalureToFind.getAreas().size() > 0:
		parent.global_position.x = %ExstendedReachForFalureToFind.getAreas()[0].global_position.x + 1.0
		snapToRung()

func snapToRung():
	parent.global_position.y = round(parent.global_position.y)
	if ladderProx.getAreas().size() > 0:
		parent.global_position.y += ladderProx.getAreas()[0].getNearestRung(parent, -15.0) + 8.0

var t := 0.0
func update(delta):
	t += delta
	
	if t >= 0.6:
		if Input.is_action_pressed("Up"):
			trasitioned.emit(self, "Climbing")
			return
	if t >= 0.6:
		if Input.is_action_pressed("Down"):
			trasitioned.emit(self, "SlideDown")
			return
	
	if t >= 0.7:
		trasitioned.emit(self, "Climbing")
		return
	
	
