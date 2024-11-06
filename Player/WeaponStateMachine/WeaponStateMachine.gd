extends StateMachine
class_name PlayerWeaponStateMachine

var inputBuffer = ""

var t = 0.2
func _process(delta):
	t -= delta
	
	if Input.is_action_just_pressed("Attack"):
		inputBuffer = "Attack"
		t = 0.2
	if Input.is_action_just_pressed("Parry"):
		inputBuffer = "Parry"
		t = 0.2
	if Input.is_action_just_pressed("HackAttack"):
		inputBuffer = "HackAttack"
		t = 0.2
	
	if t <= 0.0:
		inputBuffer = ""
	
	if Game.inTerminal:
		inputBuffer = ""
	
	if current_state:
		current_state.update(delta)
