extends GenericParriedState
class_name RemnantCrabStaggerPhase2

@export var velocityCurve : Curve
@export var velocity : float = 100.0

@export var sm : RemnantCrabStateMachine

var v : float = 0.0
var dir := Vector2.ZERO
func customEnter(_p):
	dir = Vector2(1.0, 0.0)
	if sprite.flip_h:
		dir = Vector2(-1.0, 0.0)
	v = velocity * dir.x


func customUpdate(_delta):
	parrent.velocity.x = v
	v = velocity * velocityCurve.sample(t) * dir.x
