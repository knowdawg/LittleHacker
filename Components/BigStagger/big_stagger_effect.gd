extends Sprite2D

@export var parent : Node2D

var explosionPoint := Vector2.ZERO

func _process(_delta: float) -> void:
	if parent:
		position = -parent.global_position + explosionPoint


func effect():
	if parent:
		explosionPoint = parent.global_position
		position = -parent.global_position + explosionPoint
	$AnimationPlayer.play("Effect")

func hitEfect(_a : Attack):
	effect()
