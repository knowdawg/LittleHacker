extends CharacterBody2D
class_name Enemy

signal death(e : Enemy)

@export var healthComponent : HealthComponent
@export var canBeGrappled : bool = true

func wake(): #method called usauly by an enemyWaveManager to wave up enemy
	pass

func _ready() -> void:
	EnemyPositionManager.addEnemy(self)
	if healthComponent:
		healthComponent.death.connect(die)
	customReady()

func customReady():
	pass

func die(attack : Attack):
	death.emit(self)
	customDeath(attack)

func customDeath(_attack : Attack):
	pass

func onSelectedForGrappleTarget():
	pass

func onPlayerStuckToMeWithGrapple():
	pass

func onPlayerJumpOffMe():
	pass
	
func canBeGrappledTo() -> bool:
	return true
