extends CharacterBody2D
class_name Enemy

signal death

@export var healthComponent : HealthComponent

func wake(): #method called usauly by an enemyWaveManager to wave up enemy
	pass

func _ready() -> void:
	if healthComponent:
		healthComponent.death.connect(die)
	customReady()

func customReady():
	pass

func die(attack : Attack):
	death.emit()
	customDeath(attack)

func customDeath(_attack : Attack):
	pass
