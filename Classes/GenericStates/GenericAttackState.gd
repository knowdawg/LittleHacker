extends State
class_name GenericAttackState

@export var attackLength : float = 0.0
@export var animationName : String = ""

@export_group("Next States")
@export var agroState : State
@export var parryState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var attackComponents : Array[AttackComponent] = []

@export_group("Optional Nodes")
@export var nodeToFlip : Node2D
@export var parent : Node2D
@export var movement : MovementComponent
@export_subgroup("Movemnet Variables")
@export var movementPeriods : Array[Vector3]

@export_group("ParrySettings")
@export var dontReactToParryTimes : Array[Vector2] = []

var dir = 1.0
var t = 0.0
func enter(prevState):
	t = 0.0
	animator.play(animationName)
	orientateFlipNode()
	
	if parent and Game.player:
		if parent.position.x > Game.player.global_position.x: 
			dir = -1.0
		else:
			dir = 1.0
	customEnter(prevState)

func orientateFlipNode():
	if nodeToFlip and parent and Game.player:
		if parent.position.x > Game.player.global_position.x: 
			nodeToFlip.scale.x = 1.0
		else:
			nodeToFlip.scale.x = -1.0

func customEnter(_prevSate):
	pass

func update(delta):
	t += delta
	
	if movementPeriods.size() > 0:
		for v in movementPeriods:
			if t > v.x and t < v.y:
				var dif : float = abs(v.x - v.y)
				movement.move(Vector2(dir, 0), v.z / dif, delta)
	
	if t >= attackLength:
		trasitioned.emit(self, agroState.name)

func canParry(attack : Attack):
	for v in dontReactToParryTimes:
		if t >= v.x and t <= v.y:
			return false
	for a in attackComponents:
		if a.attackName == attack.attackName:
			return true
	return false
	
func getParryState():
	return parryState

func exit(_nextState):
	for a in attackComponents:
		a.call_deferred("disable")
