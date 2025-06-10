extends State

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var movement : Curve
@export var attackComponent : AttackComponent

var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("ChargeAttack")

func update(delta):
	t += delta
	
	var b = movement.sample(t)
	parent.attackBoost = Vector2(b, 0.0) * 200.0 * parent.getDirection()
	
	attackComponent.scale = Vector2(parent.getDirection(), 1.0)
	
	if t > 0.4:
		trasitioned.emit(self, "Idle")
		return

func exit(_n):
	attackComponent.call_deferred("disable")
