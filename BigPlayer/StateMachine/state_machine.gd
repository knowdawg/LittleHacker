extends StateMachine
class_name BigPlayerStateMachine

@export var staminaComponent : StaminaComponent

var inputBuffer : String = ""
var t = 0.15
var blockBuffer : bool = false
var blockBufferTimer := 0.1
var upLadderBuffer : bool = false
var downLadderBuffer : bool = false
func custumProcess(delta):
	t -= delta
	blockBufferTimer -= delta
	
	if Input.is_action_just_pressed("Jump") and !Input.is_action_pressed("Down"):
		inputBuffer = "Jump"
		t = 0.15
	
	if Input.is_action_just_pressed("Attack"):
		inputBuffer = "Attack"
		t = 0.15
		
	if t <= 0.0:
		inputBuffer = ""

	
	if Input.is_action_pressed("Parry"):
		blockBuffer = true
		blockBufferTimer = 0.1
	
	
	if Input.is_action_pressed("Up"):
		var areas : Array[Area2D] = %TopLadder.getAreas()
		if areas.size() > 0:
			upLadderBuffer = true
		else:
			upLadderBuffer = false
	else:
		upLadderBuffer = false
		
	if Input.is_action_pressed("Down"):
		var areas : Array[Area2D] = %BottomLadder.getAreas()
		if areas.size() > 0:
			downLadderBuffer = true
		else:
			downLadderBuffer = false
	else:
		downLadderBuffer = false
	
	if blockBufferTimer <= 0.0:
		blockBuffer = false
	
	if !Game.inBigGame:
		inputBuffer = ""
		blockBuffer = false

func getInputBuffer():
	return inputBuffer

func resetInputBuffer():
	inputBuffer = ""

func switchToClimb(upInput : bool, s : State):
	if parent.getSummedVelocities().length() > 100.0 and abs(parent.getSummedVelocities().x) >= 50.0 and !parent.is_on_floor():
		switchStates("SprintToClimb")
		return
	if upInput:
		switchStates("Climbing")
		return
	if !upInput:
		switchStates("SlideDown")
		return
	
func _on_stamina_component_guard_broken(_attack: Attack) -> void:
	switchStates("Stagger")


func _on_stamina_component_hit(_attack: Attack) -> void:
	switchStates("Hit")
