extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

var t := 0.0
func enter(p : State):
	t = 0.0
	animator.play("Charging")
	
	if p is BigPlayerLightAttack2:
		t = 0.3
		animator.seek(0.3, true)
	

func update(delta):
	t += delta
	if !Input.is_action_pressed("Attack"):
		if t >= 0.7:
			trasitioned.emit(self, "ChargeAttack")
			return
		if t > 0.2:
			trasitioned.emit(self, "LightAttack")
			return
