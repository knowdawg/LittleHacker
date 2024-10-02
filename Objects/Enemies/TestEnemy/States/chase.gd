extends State

@export var speed : float = 500.0

@export_group("Next States")
@export var idleState : State
@export var attackStates : Array[State]

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var deAggroProximity : ProximityAreaComponent
@export var attackProximity : ProximityAreaComponent
@export var movement : MovementComponent

func enter():
	animator.play("Chase")

func update(delta):
	if !deAggroProximity.is_player_inside():
		trasitioned.emit(self, idleState.name)
	
	if attackProximity.is_player_inside():
		var nextState = attackStates[randi_range(0, attackStates.size() - 1)]
		trasitioned.emit(self, nextState.name)
	
	movement.moveTowardsPlayerX(speed, delta)
