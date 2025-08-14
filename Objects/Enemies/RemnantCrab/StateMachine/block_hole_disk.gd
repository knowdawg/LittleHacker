extends State
class_name RemnantCrabBlackHoleDisk


@export var movementCurve : Curve
@export var recallCurve : Curve
@export var rightRaycast : RayCast2D
@export var leftRaycast : RayCast2D
@export var blackHoleVisual : Sprite2D
@export var blackHoleContainer : Node2D
@export var legs : Node2D

@export var attackLength : float = 0.0

@export_group("Next States")
@export var agroState : State
@export var parryState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var attackComponents : Array[AttackComponent] = []

@export_group("Optional Nodes")
@export var nodeToFlip : Node2D
@export var parent : Node2D

@export_group("ParrySettings")
@export var dontReactToParryTimes : Array[Vector2] = []

var dir = 1.0
var t = 0.0
func enter(prevState):
	t = 0.0
	orientateFlipNode()
	
	if parent and Game.player:
		if parent.position.x > Game.player.global_position.x: 
			dir = -1.0
		else:
			dir = 1.0
	if dir > 0.0:
		legs.flip_h = false
		animator.play("BlackHoleDiskRight")
	else:
		legs.flip_h = true
		animator.play("BlackHoleDiskLeft")
		


func launchBlackHole():
	if dir > 0.0:
		if rightRaycast.is_colliding():
			blackHoleContainer.global_position.x = rightRaycast.get_collision_point().x
	else:
		if leftRaycast.is_colliding():
			blackHoleContainer.global_position.x = leftRaycast.get_collision_point().x

func recoverBlackHole():
	blackHoleContainer.position = Vector2.ZERO
	legs.flip_h = !legs.flip_h

func update(delta):
	t += delta
	
	var moveVal : float = movementCurve.sample(t)
	parent.position.x += moveVal * dir * 30.0 * delta
	
	if t >= 1.3 and t <= 2.3:#Disk has been thrown
		var val : float = recallCurve.sample(t - 1.3)
		blackHoleContainer.position.x += val * dir * 2.0
	
	if t >= attackLength:
		trasitioned.emit(self, agroState.name)
		return



func orientateFlipNode():
	if nodeToFlip and parent and Game.player:
		if parent.position.x > Game.player.global_position.x: 
			nodeToFlip.scale.x = -1.0
		else:
			nodeToFlip.scale.x = 1.0
		
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
	legs.flip_h = false
	blackHoleContainer.position = Vector2.ZERO
	for a in attackComponents:
		a.call_deferred("disable")
