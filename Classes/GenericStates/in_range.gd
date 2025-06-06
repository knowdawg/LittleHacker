extends State

@export var parent : Node2D
@export var movementComponent : MovementComponent
@export var proximity : ProximityAreaComponent
@export var nextStates : Array[State] = []


@export_subgroup("Stop Arguments")
@export var timeStopped : float = 0.3
@export_subgroup("Move Arguments")
@export var movementForce : float = 50


# Called when the node enters the scene tree for the first time.
func enter(_prevState) -> void:
	t = 0.0

var t = 0.0
var index = 0
func update(delta):
	if !proximity.is_player_inside():
		trasitioned.emit(self, "Chase")
		return
	
	var nextState = nextStates[randi_range(0, nextStates.size() - 1)]
	trasitioned.emit(self, nextState.name)
	return
