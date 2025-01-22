extends GenericAttackState


@export var onPogoState : State
@export var healthComponent : HealthComponent
@export var stateMachine : StateMachine

func _ready():
	healthComponent.hit.connect(onPogo)

func onPogo(attack : Attack):
	if t < 1.4:
		if stateMachine.current_state == self:
			if attack.isPogo:
				healthComponent.set_weakness(healthComponent.get_weakness() + 3)
				trasitioned.emit(self, onPogoState.name)
