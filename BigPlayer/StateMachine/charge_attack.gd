extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var movement : Curve
@export var attackComponent : AttackComponent
@export var attackLength := 1.0
@export var cancelPoint : = 0.4

var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("ChargeAttack")

func update_physics(delta):
	parent.fall(delta)

func update(delta):
	t += delta
	
	var b = movement.sample(t)
	parent.attackBoost += Vector2(b, 0.0) * 200.0 * parent.getDirection() * delta * 60.0
	
	attackComponent.scale = Vector2(parent.getDirection(), 1.0)
	
	if t > attackLength:
		trasitioned.emit(self, "Idle")
		return
		
	if t > cancelPoint:
		if stateMachine.getInputBuffer() == "Attack":
			trasitioned.emit(self, "LightAttack2")
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
