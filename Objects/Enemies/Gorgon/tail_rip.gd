extends GenericTransitionState

@export var healthComponent : HealthComponent
@export var newDeathState : State
@export var deathComponent : DeathComponent
@export var movementComponent : MovementComponent
@export var knockbackComponent : OmniDirectionalKnockbackComponent
@export var parent : CharacterBody2D

@export var hackedState : State
@export var stateAfterHack : State

func customEnter(_prevState):
	healthComponent.set_health(1)
	deathComponent.stateToSwitchTo = newDeathState
	hackedState.nextState = stateAfterHack
	var k : Vector2 = knockbackComponent.returnVecFromTwoObjects(parent, Game.player)
	k.y = 0.0
	k = k.normalized()
	movementComponent.applyForce(k, 100.0)

#func _ready():
	#Game.exitHackMode.connect(exitHackMode)
#
#func exitHackMode():
