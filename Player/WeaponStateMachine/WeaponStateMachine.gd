extends StateMachine
class_name PlayerWeaponStateMachine

@export var pStateMachine : PlayerStateMachine

var inputBuffer = ""

var t = 0.2

var dead = false
func _process(delta):
	t -= delta
	
	if pStateMachine.noWeaponInputs():
		inputBuffer = ""
	else:
		if Input.is_action_just_pressed("Attack"):
			inputBuffer = "Attack"
			t = 0.3
		if Input.is_action_just_pressed("Parry"):
			inputBuffer = "Parry"
			t = 0.2
		if Input.is_action_just_pressed("Grapple"):
			inputBuffer = "Grapple"
			t = 0.2
		if Input.is_action_just_pressed("HackAttack"):
			inputBuffer = "HackAttack"
			t = 0.3
	
	
	if t <= 0.0:
		inputBuffer = ""
	
	if Game.inHackMode:
		inputBuffer = ""
	
	if dead:
		inputBuffer = ""
	
	if current_state:
		current_state.update(delta)


func _on_health_component_hit(_attack: Attack) -> void:
	inputBuffer = ""


func _on_health_component_death(_attack: Attack) -> void:
	dead = true
