extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

var canJump : bool = true
var timeCrouched := 0.0
func enter(p : State):
	stateMachine.staminaComponent.atemptToSpendStamina(10.0, true)
	
	if p is BigPlayerRun:
		canJump = false
		parent.jump(0.5)
		animator.play("SprintJumpStart")
	else:
		timeCrouched = 0.0
		canJump = true
		animator.play("JumpCrouch")

func update_physics(delta: float) -> void:
	parent.fall(delta)
	if !canJump:
		parent.check_for_movement(delta)

func update(delta):
	timeCrouched += delta
	if timeCrouched > 0.1:
		if canJump:
			canJump = false
			parent.jump()
			animator.play("JumpStart")

	if parent.getSummedVelocities().y > 0:
		trasitioned.emit(self, "Fall")
