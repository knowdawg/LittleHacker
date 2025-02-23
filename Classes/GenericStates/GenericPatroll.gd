extends State
class_name GenericPatroll


@export var animationLength : float = 0.0
@export var movementIntervals : Array[Vector3] = []
@export var numOfAnimationsBeforeDirectionChange : int = 1
@export var turnState : State

@export_group("Next States")
@export var aggroState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var aggroProximity : ProximityAreaComponent
@export var movement : MovementComponent

@export_group("Optional Nodes")
@export var spriteDirector : SpriteDirectorComponent


var t : float = 0.0
func enter(_prevState):
	t = 0.0
	animator.play(animationName)
	tranistionOnFinish = false

var dir = 1.0
var numOfCompleteAnimations : int = 0
var tranistionOnFinish = false
func update(delta):
	if spriteDirector:
		spriteDirector.updateDirection()
	
	if aggroProximity:
		if aggroProximity.is_player_inside():
			tranistionOnFinish = true
	
	t += delta
	if t > animationLength:
		t -= animationLength
		numOfCompleteAnimations += 1
		if tranistionOnFinish == true:
			tranistionOnFinish = false
			trasitioned.emit(self, aggroState.name)
			return
		if numOfCompleteAnimations >= numOfAnimationsBeforeDirectionChange:
			numOfCompleteAnimations -= numOfAnimationsBeforeDirectionChange
			dir *= -1.0
			if turnState:
				trasitioned.emit(self, turnState.name)
	for i in movementIntervals:
		if t > i.x and t < i.y:
			movement.move(Vector2(dir, 0), i.z, delta)
	
	
