extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine


var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("HitBlunt")

func update_physics(delta):
	parent.fall(delta)

func update(delta):
	t += delta
	
	if t >= 0.3:
		trasitioned.emit(self, "Idle")
