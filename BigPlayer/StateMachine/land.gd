extends State
class_name BigPlayerLand

@export var stateMachine : BigPlayerStateMachine
@export var animator : AnimationPlayer

var t := 0.0
func enter(_p):
	t = 0.0
	if Input.is_action_pressed("Roll") and Input.get_axis("Left", "Right") != 0.0:
		return
	animator.play("Land")

func update(delta):
	t += delta
	
	if stateMachine.getInputBuffer() == "Block":
		trasitioned.emit(self, "Block")
		return
	
	if Input.is_action_pressed("Roll") and Input.get_axis("Left", "Right") != 0.0:
		trasitioned.emit(self, "Run")
		return
	
	if t >= 0.4:
		trasitioned.emit(self, "Idle")
		return
	
	if stateMachine.inputBuffer == "Jump":
		trasitioned.emit(self, "Jump")
		return
		
	if stateMachine.getInputBuffer() == "Attack":
		trasitioned.emit(self, "AttackCharge")
		return
		
	if stateMachine.upLadderBuffer:
		trasitioned.emit(self, "Climbing")
		return
	if stateMachine.downLadderBuffer:
		trasitioned.emit(self, "SlideDown")
		return
