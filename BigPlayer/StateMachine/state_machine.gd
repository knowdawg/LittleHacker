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
	
	if Input.is_action_just_pressed("Attack"):
		inputBuffer = "Attack"
		t = 0.15

	if Input.is_action_just_pressed("Parry"):
		inputBuffer = "Block"
		t = 0.15
		
	if t <= 0.0:
		inputBuffer = ""
	
	if Game.inLittleGame:
		inputBuffer = ""

func getInputBuffer():
	return inputBuffer

func resetInputBuffer():
	inputBuffer = ""


func _on_stamina_component_guard_broken(_attack: Attack) -> void:
	switchStates("Stagger")
