@tool
extends Node2D

@export var clothSim : Node2D
@export var sprite : Sprite2D

func _process(_delta: float) -> void:
	clothSim.position = $ClothSimFollow.position + position
	if sprite.flip_h:
		clothSim.position.x *= -1.0
