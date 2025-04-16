extends Node2D

@export var enemyWaveManager : EnemyWaveManager

@export var shakeAmount : float = 0.0

@export var colShapes : Array[CollisionPolygon2D]

func _ready() -> void:
	enemyWaveManager.onStartEncounter.connect(startLava)
	enemyWaveManager.onEndEncounter.connect(endLava)

func startLava():
	%LavaAnimator.play("Start") 
	for c in colShapes:
		c.set_deferred("disabled", false)

func endLava():
	%LavaAnimator.play("End")
	for c in colShapes:
		c.set_deferred("disabled", true)

func _process(delta: float) -> void:
	if Game.camera:
		Game.camera.set_shake(shakeAmount)
