extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("Charging")

func update(delta):
	t += delta
	if !Input.is_action_pressed("Attack"):
		if t >= 0.8:
			trasitioned.emit(self, "ChargeAttack")
			return
		if t > 0.2:
			trasitioned.emit(self, "LightAttack")
			return
