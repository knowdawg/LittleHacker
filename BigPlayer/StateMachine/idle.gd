extends State
class_name BigPlayerIdle

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

func enter(_p):
	animator.play("Idle")

func update_physics(delta: float) -> void:
	parent.fall(delta)
	parent.check_for_movement(delta)

func update(_delta):
	if abs(parent.xMovement.x) > 0.0:
		trasitioned.emit(self, "Walk")
		return
	
	if parent.getSummedVelocities().y > 0:
		trasitioned.emit(self, "Fall")
		return
	
	if stateMachine.blockBuffer:
		trasitioned.emit(self, "Block")
		return
	
	if stateMachine.getInputBuffer() == "Jump":
		trasitioned.emit(self, "Jump")
		return
		
	if stateMachine.getInputBuffer() == "Attack":
		trasitioned.emit(self, "AttackCharge")
		return
	
	if stateMachine.upLadderBuffer:
		trasitioned.emit(self, "Climbing")
		return
	if stateMachine.downLadderBuffer:
		trasitioned.emit(self, "SlideDown")
		return
