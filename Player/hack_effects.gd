extends Node2D

@export var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func startEffects():
	if player.getSpriteDirection() == 1:
		scale.x = -1
	else:
		scale.x = 1
	$RedParticles.restart()
	$RedParticles2.restart()
	$AnimationPlayer.play("StartEffects")
	show()

func endEffects():
	hide()
