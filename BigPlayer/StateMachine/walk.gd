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
	if Input.is_action_pressed("Roll"):
		if stateMachine.staminaComponent.getStamina() >= 5.0:
			trasitioned.emit(self, "Run")
	
	if abs(parent.xMovement.x) < 0.1:
		trasitioned.emit(self, "Idle")
	
	if parent.getSummedVelocities().y > 0:
		trasitioned.emit(self, "Fall")
	
	if stateMachine.getInputBuffer() == "Jump":
		trasitioned.emit(self, "Jump")
