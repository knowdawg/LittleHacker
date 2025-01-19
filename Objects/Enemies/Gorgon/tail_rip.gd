extends GenericTransitionState

@export var healthComponent : HealthComponent
@export var newDeathState : State
@export var deathComponent : DeathComponent

func customEnter(_prevState):
	healthComponent.set_health(1)
	deathComponent.stateToSwitchTo = newDeathState
