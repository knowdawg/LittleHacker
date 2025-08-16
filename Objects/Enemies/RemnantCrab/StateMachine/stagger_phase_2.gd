extends GenericParriedState
class_name RemnantCrabStaggerPhase2

@export var velocityCurve : Curve
@export var velocity : float = 100.0

@export var sm : RemnantCrabStateMachine
@export var legs : Sprite2D

var v : float = 0.0
var dir := Vector2.ZERO
func customEnter(_p):
	dir = -Vector2(sm.vectorToPlayer.x, 0.0).normalized()
	v = velocity * dir.x
	
	animator.stop()
	if dir.x > 0:
		animator.play("StaggerPhase2Right")
		legs.flip_h = true
	else:
		animator.play("StaggerPhase2Left")
		legs.flip_h = false


func enter(prevState):
	customEnter(prevState)
	t = 0.0
	#animator.play(animationName)
	if knockbackBasedOnDir:
		if sprite.flip_h:
			movement.applyForce(Vector2(-1, 0), knockback)
		else:
			movement.applyForce(Vector2(1, 0), knockback)
	else:
		if Game.doesPlayerExist():
			if !kbCom:
				movement.applyForce(biDirectionalKbCom.returnVecFromTwoObjects(parrent, Game.player), knockback)
			else:
				movement.applyForce(kbCom.returnVecFromTwoObjects(parrent, Game.player), knockback)


func customUpdate(_delta):
	parrent.velocity.x = v
	v = velocity * velocityCurve.sample(t) * dir.x

func customExit(_n):
	legs.flip_h = false
