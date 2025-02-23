extends CharacterBody2D
class_name HealthBuggy

@export var movement : MovementComponent

func _on_interactable_area_on_interact() -> void:
	$StateMachine.switchStates("death")
	Game.player.heal(1.5)
	$DeathParticles.emitting = true
	$Sounds/RandomPitchAudio.playSound()

func _process(_delta: float) -> void:
	if !is_on_floor():
		if !$StateMachine.current_state is BuggyFalling:
			$StateMachine.switchStates("Falling")
	$StateMachine/Patroll.numOfAnimationsBeforeDirectionChange = randi_range(1, 4)
