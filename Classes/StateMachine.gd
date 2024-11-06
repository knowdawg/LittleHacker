extends Node
class_name StateMachine

@export var initial_state : State
@export var hackedState : State
@export var parent : Node

var current_state : State
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.trasitioned.connect(onChildTransition)
	
	if initial_state:
		initial_state.enter(null)
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.update_physics(delta)

#Called by the signal
func onChildTransition(state : State, new_state_name):
	if state != current_state:
		return
	
	switchStates(new_state_name)

#Call for manualy overwriting State
func switchStates(newState):
	var n = states.get(newState.to_lower())
	
	var prevState : State = null
	if current_state:
		prevState = current_state
		current_state.exit(n)
	
	n.enter(prevState)
	
	current_state = n

signal onHacked
signal onHackFinished

func enterHackMode():
	switchStates(hackedState.name)
	Game.hackedEnemy = parent
	onHacked.emit()

func exitHackMode():
	onHackFinished.emit()
