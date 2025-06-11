extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var movement : Curve
@export var attackComponent : AttackComponent
@export var attackLength := 0.7
@export var cancelPoint : = 0.4

var dir := 1.0
var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("LightAttack")
	dir = parent.getDirection()

func update(delta):
	t += delta
	
	var b = movement.sample(t)
	parent.attackBoost = Vector2(b, 0.0) * 150.0 * dir
	
	attackComponent.scale = Vector2(dir, 1.0)
	
	if t > attackLength:
		trasitioned.emit(self, "Idle")
		return
		
	if t > cancelPoint:
		if stateMachine.getInputBuffer() == "Attack":
			trasitioned.emit(self, "LightAttack2")
			return
		
		parent.check_for_movement(delta)
		if abs(parent.xMovement.x) > 0.0:
			trasitioned.emit(self, "Walk")
			return
		
		if parent.getSummedVelocities().y > 0:
			trasitioned.emit(self, "Fall")
			return
		
		if stateMachine.getInputBuffer() == "Jump":
			trasitioned.emit(self, "Jump")
			return
			

func exit(_n):
	attackComponent.call_deferred("disable")
