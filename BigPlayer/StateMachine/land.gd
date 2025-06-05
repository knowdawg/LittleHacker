extends State
class_name BigPlayerLand

@export var stateMachine : BigPlayerStateMachine
@export var animator : AnimationPlayer

var t := 0.0
func enter(_p):
	t = 0.0
	if Input.is_action_pressed("Roll") and Input.get_axis("Left", "Right") != 0.0:
		if stateMachine.staminaComponent.getStamina() >= 5.0:
			return
	animator.play("Land")

func update(delta):
	t += delta
	
	if Input.is_action_pressed("Roll") and Input.get_axis("Left", "Right") != 0.0:
		if stateMachine.staminaComponent.getStamina() >= 5.0:
			trasitioned.emit(self, "Run")
			return
	
	if t >= 0.4:
		trasitioned.emit(self, "Idle")
		return
	
	if stateMachine.inputBuffer == "Jump":
		trasitioned.emit(self, "Jump")
		return
