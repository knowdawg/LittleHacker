extends GenericAttackState

@export var onPogoState : State
@export var grabHitState : State
@export var grabMissedState : State
@export var attackComponent : AttackComponent
@export var healthComponent : HealthComponent
@export var stateMachine : StateMachine

func _ready():
	healthComponent.hit.connect(onPogo)
	attackComponent.grabSucessful.connect(grabSucessful)

func customEnter(_prevState):
	agroState = grabMissedState

func grabSucessful(_attack):
	agroState = grabHitState

func onPogo(attack : Attack):
	if stateMachine.current_state == self:
		if attack.isPogo:
			healthComponent.set_weakness(healthComponent.get_weakness() + 3)
			trasitioned.emit(self, onPogoState.name)

func exit(_newState):
	attackComponent.call_deferred("disable")
