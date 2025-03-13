extends Node
class_name StateMachine

@export var initial_state : State
@export var hackedState : State
@export var parent : Node

@export var animators : Array[AnimationPlayer] = []

var current_state : State
var states : Dictionary = {}
signal stateSwitched(prevState : State, newState : State)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.trasitioned.connect(onChildTransition)
	
	if initial_state:
		initial_state.enter(null)
		current_state = initial_state
		stateSwitched.emit(null, initial_state)
	
	Game.exitHackMode.connect(hackModeFinished)

func _process(delta):
	#update the state only if the game is not in hack mode
	#this allows the player to have unlimited time while choosing 
	#what commands to execute
	if current_state:
		if !Game.inHackMode:
			current_state.update(delta)
		else:
			#States such as hacked states still need to be updated
			if current_state.updateWhileHacked:
				current_state.update(delta)
			else:
				#stop the animators as well
				for a in animators:
					a.pause()
	custumProcess(delta)
	
func custumProcess(_delta):
	pass
	
func hackModeFinished():
	#Resume the animators once hack mode is finished
	for a in animators:
		#prevent finished animations from playign again
		if a.current_animation_length != a.current_animation_position:
			a.play() 

func _physics_process(delta):
	if current_state:
		current_state.update_physics(delta)

#Called by the signal
func onChildTransition(state : State, new_state_name):
	if state != current_state:
		return
	
	switchStates(new_state_name)

#Call for manualy overwriting State
func switchStates(newState : String):
	var n = states.get(newState.to_lower())
	
	var prevState : State = null
	if current_state:
		prevState = current_state
		current_state.exit(n)
	
	if !n:
		printerr(newState + ": Non-existant State")
	else:
		n.enter(prevState)
	stateSwitched.emit(prevState, n)
	current_state = n

signal onHacked
signal onHackFinished

func enterHackMode():
	Game.hackedEnemy = parent
	onHacked.emit()
	switchStates(hackedState.name)

func exitHackMode():
	onHackFinished.emit()
