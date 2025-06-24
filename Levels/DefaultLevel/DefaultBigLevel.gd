extends Node2D

@export var environment : Environment

func _ready() -> void:
	Game.enterBigGame.connect(setEnvirement)
	setEnvirement()

func setEnvirement():
	if environment:
		GameWorldEnvirement.setEnvironment(environment)
	else:
		GameWorldEnvirement.clearEnvironment()
