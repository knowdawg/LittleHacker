extends State
class_name GenericAttackState

@export var attackLength : float = 0.0
@export var animationName : String = ""

@export_group("Next States")
@export var agroState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer

@export_group("Optional Nodes")
@export var nodeToFlip : Node2D
@export var parent : Node2D
@export var movement : MovementComponent
@export_subgroup("Movemnet Variables")
@export var movementPeriods : Array[Vector3]

@export_group("ParrySettings")
@export var dontReactToParryTimes : Array[Vector2]

var t = 0.0
func enter():
	t = 0.0
	animator.play(animationName)
	if nodeToFlip and parent:
		if parent.position.x > Game.player.global_position.x: 
			nodeToFlip.scale.x = 1.0
		else:
			nodeToFlip.scale.x = -1.0

func update(delta):
	t += delta
	
	if movementPeriods.size() > 0:
		for v in movementPeriods:
			if t > v.x and t < v.y:
				movement.moveTowardsPlayer(v.z, delta)
	
	if t >= attackLength:
		trasitioned.emit(self, agroState.name)

func canParry():
	if dontReactToParryTimes.size() > 0:
		for v in dontReactToParryTimes:
			if t > v.x and t < v.y:
				return false
	return true