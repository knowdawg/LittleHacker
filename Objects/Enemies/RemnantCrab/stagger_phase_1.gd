extends GenericParriedState
class_name RemnantCrabStaggerPhase1

@export var velocityCurve : Curve
@export var velocity : float = 100.0

var v : float = 0.0
func customEnter(_p):
	v = -velocity


func customUpdate(_delta):
	parrent.velocity.x = v
	v = -velocity * velocityCurve.sample(t)
