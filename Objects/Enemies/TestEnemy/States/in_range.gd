extends State

@export var parent : Node2D
@export var movementComponent : MovementComponent
@export var proximity : ProximityAreaComponent
@export var nextStates : Array[State] = []

var posibleMoves : Array[String] = ["stop","move"]
var movement : Array = []

# Called when the node enters the scene tree for the first time.
func enter(_prevState) -> void:
	movement.clear()
	t = 0.0
	index = 0
	for i in randi_range(1, 3):
		var random = randi_range(0, posibleMoves.size()-1)
		movement.append(posibleMoves[random])

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
	if movement[index] == "stop":
		if t >= 0.3:
			t = 0.0
			index += 1
		return
	
	if movement[index] == "move":
		if t == delta:
			var d = parent.position.distance_to(Game.player.global_position)
			if d <= 9:
				movementComponent.applyForce(movementComponent.getVectorToPlayerX(parent.position), 50)
			else:
				movementComponent.applyForce(movementComponent.getVectorToPlayerX(parent.position), -50)
		if t >= 0.3:
			t = 0.0
			index += 1
		return
	
