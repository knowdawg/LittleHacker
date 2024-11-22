extends State

@export var speed : float = 500.0

@export_group("Next States")
@export var idleState : State
@export var nextStates : Array[State]

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var deAggroProximity : ProximityAreaComponent
@export var attackProximity : ProximityAreaComponent
@export var longRangeProximity : ProximityAreaComponent
@export var movement : MovementComponent

func enter(_prevState):
	animator.play(animationName)

func update(delta):
	if !deAggroProximity.is_player_inside():
		trasitioned.emit(self, idleState.name)
	
	if attackProximity.is_player_inside():
		var nextState = nextStates[randi_range(0, nextStates.size() - 1)]
		trasitioned.emit(self, nextState.name)
	
	movement.moveTowardsPlayerX(speed, delta)

func chanceForLongRangeAttack():
	if longRangeProximity.is_player_inside():
		if randf() < 0.2:
			trasitioned.emit(self, "Thrust")

func _ready() -> void:
	longRangeProximity.onPlayerEnter.connect(chanceForLongRangeAttack)
