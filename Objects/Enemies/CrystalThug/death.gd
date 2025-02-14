extends GenericEnemyDeath

@export var parrent : CharacterBody2D
@export var kbCom : OmniDirectionalKnockbackComponent
@export var movement : MovementComponent
@export var knockback : float = 0.0

func customEnter(prevState):
	if prevState is GenericEnemyHackedState:
		movement.applyForce(kbCom.returnVecFromTwoObjects(parrent, Game.player), knockback)
