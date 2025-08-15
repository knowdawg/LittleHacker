extends State
class_name RemnantCrabDoubleHeadSwing


@export var movementCurve : Curve
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
		legs.flip_h = true
		animator.play("DoubleHeadSwingRight")
	else:
		legs.flip_h = false
		animator.play("DoubleHeadSwingLeft")
		



func update(delta):
	t += delta
	
	var moveVal : float = movementCurve.sample(t)
	parent.position.x += moveVal * dir * 30.0 * delta
	
	if (t >= 0.4 and t <= 0.7) or (t >= 1.5 and t <= 2.0):
		parent.suckInPlayer(delta, 3.0, true)
	
	if t >= attackLength:
		trasitioned.emit(self, agroState.name)
		return


func orientateFlipNode():
	if nodeToFlip and parent and Game.player:
		if parent.position.x > Game.player.global_position.x: 
			nodeToFlip.scale.x = 1.0
		else:
			nodeToFlip.scale.x = -1.0

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
	for a in attackComponents:
		a.call_deferred("disable")
