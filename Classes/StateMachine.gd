extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.trasitioned.connect(onChildTransition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

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

func switchStates(newState):
	var n = states.get(newState.to_lower())
	
	if current_state:
		current_state.exit(n)
	
	n.enter()
	
	current_state = n
