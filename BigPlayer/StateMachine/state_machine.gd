extends StateMachine
class_name BigPlayerStateMachine

@export var staminaComponent : StaminaComponent

var inputBuffer : String = ""
var t = 0.15
func custumProcess(delta):
	t -= delta
	
	if Input.is_action_just_pressed("Jump") and !Input.is_action_pressed("Down"):
		inputBuffer = "Jump"
		t = 0.15
		
	if t <= 0.0:
		inputBuffer = ""
	
	if Game.inLittleGame:
		inputBuffer = ""

func getInputBuffer():
	return inputBuffer

func resetInputBuffer():
	inputBuffer = ""
