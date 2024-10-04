extends State
class_name PlayerStun

@export var stunTime : float = 0.25
@export var animator : AnimationPlayer
@export var scaleAnimator : AnimationPlayer
@export var parent : Player

func enter(_prevState):
	animator.play("Stun")
	scaleAnimator.play("Stun")
	t = 0.0

func update_physics(delta):
	parent.update_physics(delta, true, false)

var t = 0.0
func update(delta):
	t += delta
	if t >= stunTime:
		trasitioned.emit(self, "Idle")
