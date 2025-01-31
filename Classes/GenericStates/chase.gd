extends State

@export var speed : float = 500.0

@export_group("Interval Movement")
@export var useIntervalMovement : bool = false
@export var animationLength : float = 0.0
@export var movementIntervals : Array[Vector3] = []

@export_group("Next States")
@export var idleState : State
@export var nextStates : Array[State]

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var deAggroProximity : ProximityAreaComponent
@export var attackProximity : ProximityAreaComponent
@export var movement : MovementComponent

@export_group("Optional Nodes")
@export var spriteDirector : SpriteDirectorComponent

var t : float = 0.0
func enter(_prevState):
	t = 0.0
	animator.play(animationName)

func update(delta):
	if spriteDirector:
		spriteDirector.lookAtPlayer()
	if !deAggroProximity.is_player_inside():
		trasitioned.emit(self, idleState.name)
		return
	
	if attackProximity.is_player_inside():
		var nextState = nextStates[randi_range(0, nextStates.size() - 1)]
		trasitioned.emit(self, nextState.name)
		return
	
	if !useIntervalMovement:
		if abs(movement.getVectorToPlayerX(movement.parent.global_position, false).x) < 1.0:
			pass
		else:
			movement.moveTowardsPlayerX(speed, delta)
	else:
		t += delta
		if t > animationLength:
			t -= animationLength
		for i in movementIntervals:
			if t > i.x and t < i.y:
				if abs(movement.getVectorToPlayerX(movement.parent.global_position, false).x) < 1.0:
					pass
				else:
					movement.moveTowardsPlayerX(i.z, delta)
