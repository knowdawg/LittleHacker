extends Node
class_name PlayerStateMachine

@export var initial_state : State
@export var parent : Player

var current_state : State
var states : Dictionary = {}

func enterParry():
	if current_state is SmallPlayerRoll:
		pass
	if parent.is_on_floor():
		current_state.trasitioned.emit(current_state, "GroundParry")

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.trasitioned.connect(onChildTransition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

var inputBuffer = ""
var t = 0.15
func _process(delta):
	t -= delta
	
	if Input.is_action_just_pressed("Jump"):
		inputBuffer = "Jump"
		t = 0.15
	if Input.is_action_just_pressed("Roll"):
		inputBuffer = "Roll"
		t = 0.15
		
	if t <= 0.0:
		inputBuffer = ""
	
	if Game.inTerminal:
		inputBuffer = ""
	
	if current_state:
		current_state.update(delta)

func getInputBuffer():
	return inputBuffer

func resetInputBuffer():
	inputBuffer = ""

func _physics_process(delta):
	if current_state:
		current_state.update_physics(delta)

func onChildTransition(state : State, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
	
	if current_state:
		current_state.exit(new_state)
	
	new_state.enter()
	
	current_state = new_state
