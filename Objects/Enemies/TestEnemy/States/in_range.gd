extends State

@export var parent : Node2D
@export var movementComponent : MovementComponent
@export var proximity : ProximityAreaComponent
@export var nextStates : Array[State] = []

@export_group("Movement Stall")
enum movementTypes {stop, move}
@export var usableMovement : Array[movementTypes] = []
@export var minMoves : int = 0
@export var maxMoves : int = 0
@export_subgroup("Stop Arguments")
@export var timeStopped : float = 0.3
@export_subgroup("Move Arguments")
@export var movementForce : float = 50

var movement : Array[movementTypes] = []

# Called when the node enters the scene tree for the first time.
func enter(_prevState) -> void:
	movement.clear()
	t = 0.0
	index = 0
	for i in randi_range(minMoves, maxMoves):
		var random = randi_range(0, usableMovement.size()-1)
		movement.append(usableMovement[random])

var t = 0.0
var index = 0
func update(delta):
	if !proximity.is_player_inside():
		trasitioned.emit(self, "Chase")
		return
	
	if index > movement.size() - 1:
		var nextState = nextStates[randi_range(0, nextStates.size() - 1)]
		trasitioned.emit(self, nextState.name)
		return
	
	t += delta
	if movement[index] == movementTypes["stop"]:
		if t >= timeStopped:
			t = 0.0
			index += 1
		return
	
	if movement[index] == movementTypes["move"]:
		if t == delta:
			var d = parent.position.distance_to(Game.player.global_position)
			if d <= 9:
				movementComponent.applyForce(movementComponent.getVectorToPlayerX(parent.position), movementForce)
			else:
				movementComponent.applyForce(movementComponent.getVectorToPlayerX(parent.position), -movementForce)
		if t >= 0.3:
			t = 0.0
			index += 1
		return
