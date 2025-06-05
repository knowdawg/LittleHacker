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
	
	if parent.getSummedVelocities().y > 0:
		trasitioned.emit(self, "Fall")
	
	if stateMachine.getInputBuffer() == "Jump":
		trasitioned.emit(self, "Jump")
