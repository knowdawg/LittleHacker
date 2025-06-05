extends State
class_name BigPlayerFall

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

func enter(_p):
	if animator.current_animation == "SprintJumpStart":
		animator.play("SprintJumpPeak")
	else:
		animator.play("JumpPeak")

func update_physics(delta: float) -> void:
	parent.fall(delta)
	parent.check_for_movement(delta)

func update(_delta):
	if parent.is_on_floor():
		trasitioned.emit(self, "Land")
