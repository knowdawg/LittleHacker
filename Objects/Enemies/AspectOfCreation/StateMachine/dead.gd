extends GenericTransitionState

@export var movementCurve : Curve
@export var speed : float = 100.0
@export var movement : MovementComponent
@export var sm : AspectOfCreationStateMachine

@export var hitboxToDisable : HurtboxComponent

func customEnter(_prevState):
	hitboxToDisable.call_deferred("disable")

func customUpdate(delta):
	var m = movementCurve.sample(t) * speed
	
	if sm.dirToPlayer == sm.DIRECTION.LEFT:
		movement.move(Vector2(1.0, 0.0), m, delta)
	if sm.dirToPlayer == sm.DIRECTION.RIGHT:
		movement.move(Vector2(-1.0, 0.0), m, delta)
