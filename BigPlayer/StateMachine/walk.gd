extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

func enter(_p):
	animator.play("Walk")

func update_physics(delta: float) -> void:
	parent.fall(delta)
	parent.check_for_movement(delta)

func update(_delta):
	parent.updateSpriteDirection()
	
	if Input.is_action_pressed("Roll"):
		trasitioned.emit(self, "Run")
		return
	
	if abs(parent.xMovement.x) < 0.1:
		trasitioned.emit(self, "Idle")
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
