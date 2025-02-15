extends Node
class_name PlayerStateMachine

@export var initial_state : State
@export var parent : Player
@export var hurtboxComponent : HurtboxComponent

var current_state : State
var states : Dictionary = {}

var statesThatCanGoIntoHackAttack = [SmallPlayerIdle, SmallPlayerRun]
func canHackAttack() -> bool:
	if current_state is SmallPlayerIdle or current_state is SmallPlayerRun or current_state is PlayerGroundParry or current_state is SmallPlayerParryStun:
		return true
	return false

func enterParry():
	if current_state is SmallPlayerRoll:
		pass
	if parent.is_on_floor():
		current_state.trasitioned.emit(current_state, "GroundParry")

func enterHackMode():
	if hurtboxComponent.parryForgivenesTimer.time_left > 0:
		hurtboxComponent.damageStuff()
		return
	switchStates("HackMode")


@export var attackComponentsThatCanBeParried : Array[AttackComponent] = []
func _ready():
	Game.enterHackMode.connect(enterHackMode)
	
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.trasitioned.connect(onChildTransition)
	
	if initial_state:
		initial_state.enter(null)
		current_state = initial_state
	
	for a in attackComponentsThatCanBeParried:
		a.gotParried.connect(gotBlocked)


func gotBlocked(_attack):
	switchStates("Blocked")


var inputBuffer = ""
var t = 0.15
func _process(delta):
	t -= delta
	
	if Input.is_action_just_pressed("Jump") and !Input.is_action_pressed("Down"):
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

func switchStateWithParam(newState, param : bool = false):
	var n = states.get(newState.to_lower())
	
	var prevState : State = null
	if current_state:
		prevState = current_state
		current_state.exit(n)
	
	n.enter(prevState, param)
	
	current_state = n

func noWeaponInputs():
	if current_state is PlayerBlocked or current_state is PlayerGrabbed:
		return true
	return false
