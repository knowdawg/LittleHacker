extends State
class_name BigPlayerLightAttack2

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var movement : Curve
@export var attackComponent : AttackComponent
@export var attackLength := 0.7
@export var cancelPoint : = 0.4

var dir := 1.0
var t := 0.0

var inTransition : bool = false
func enter(_p):
	inTransition = false
	t = 0.0
	animator.play("LightAttack2")
	dir = parent.getDirection()

func update(delta):
	t += delta
	
	if inTransition:
		if t>= 0.2:
			trasitioned.emit(self, "AttackCharge")
		return
	
	var b = movement.sample(t)
	parent.attackBoost += Vector2(b, 0.0) * 150.0 * dir * delta * 60.0
	
	attackComponent.scale = Vector2(dir, 1.0)
	
	if t > attackLength:
		trasitioned.emit(self, "Idle")
		return
		
	if t > cancelPoint:
		if stateMachine.getInputBuffer() == "Attack":
			inTransition = true
			t = 0.0
			animator.play("Attack2ToAttack1Transition")
			return
		
		if stateMachine.blockBuffer:
			trasitioned.emit(self, "Block")
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
