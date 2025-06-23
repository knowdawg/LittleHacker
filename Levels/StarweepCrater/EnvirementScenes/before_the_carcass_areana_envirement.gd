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

func _process(_delta: float) -> void:
	if Game.camera and shakeAmount > 0.01:
		Game.camera.set_shake(shakeAmount)
	
	#Temp, find a better way to enable
	if $LavafallFront/Front1.width == 10.0:
		for c in colShapes:
			c.set_deferred("disabled", false)
	else:
		for c in colShapes:
			c.set_deferred("disabled", true)
